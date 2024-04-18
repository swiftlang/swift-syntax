//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
// NOTE: This basic plugin mechanism is mostly copied from
// https://github.com/apple/swift-package-manager/blob/main/Sources/PackagePlugin/Plugin.swift

#if swift(>=6.0)
private import _CShims
public import SwiftSyntaxMacros
@_spi(PluginMessage) private import SwiftCompilerPluginMessageHandling
#if canImport(Darwin)
private import Darwin
#elseif canImport(Glibc)
private import Glibc
#elseif canImport(ucrt)
private import ucrt
#endif
#else
import _CShims
import SwiftSyntaxMacros
@_spi(PluginMessage) import SwiftCompilerPluginMessageHandling
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#elseif canImport(ucrt)
import ucrt
#endif
#endif

//
// This source file contains the main entry point for compiler plugins.
// A plugin receives messages from the "plugin host" (typically
// 'swift-frontend'), and sends back messages in return based on its actions.
//
// Depending on the platform, plugins are invoked in a sandbox that blocks
// network access and prevents any file system changes.
//
// The host process and the plugin communicate using messages in the form of
// length-prefixed JSON-encoded Swift enums. The host sends messages to the
// plugin through its standard-input pipe, and receives messages through the
// plugin's standard-output pipe. The plugin's standard-error is considered
// to be free-form textual console output.
//
// Within the plugin process, `stdout` is redirected to `stderr` so that print
// statements from the plugin are treated as plain-text output, and `stdin` is
// closed so that any attempts by the plugin logic to read from console result
// in errors instead of blocking the process. The original `stdin` and `stdout`
// are duplicated for use as messaging pipes, and are not directly used by the
// plugin logic.
//
// The exit code of the plugin process indicates whether the plugin invocation
// is considered successful. A failure result should also be accompanied by an
// emitted error diagnostic, so that errors are understandable by the user.
//
// Using standard input and output streams for messaging avoids having to make
// allowances in the sandbox for other channels of communication, and seems a
// more portable approach than many of the alternatives. This is all somewhat
// temporary in any case — in the long term, something like distributed actors
// or something similar can hopefully replace the custom messaging.
//
// Usage:
//   struct MyPlugin: CompilerPlugin {
//   var providingMacros: [Macros.Type] = [
//     StringifyMacro.self
//   ]
public protocol CompilerPlugin {
  init()

  var providingMacros: [Macro.Type] { get }
}

extension CompilerPlugin {
  @_spi(Testing)
  public func resolveMacro(moduleName: String, typeName: String) throws -> Macro.Type {
    let qualifedName = "\(moduleName).\(typeName)"

    for type in providingMacros {
      // FIXME: Is `String(reflecting:)` stable?
      // Getting the module name and type name should be more robust.
      let name = String(reflecting: type)
      if name == qualifedName {
        return type
      }
    }

    let pluginPath = CommandLine.arguments.first ?? "<unknown>"
    throw CompilerPluginError(
      message:
        "macro implementation type '\(moduleName).\(typeName)' could not be found in executable plugin '\(pluginPath)'"
    )
  }
}

struct CompilerPluginError: Error, CustomStringConvertible {
  var description: String
  init(message: String) {
    self.description = message
  }
}

struct MacroProviderAdapter<Plugin: CompilerPlugin>: PluginProvider {
  let plugin: Plugin
  init(plugin: Plugin) {
    self.plugin = plugin
  }
  func resolveMacro(moduleName: String, typeName: String) throws -> Macro.Type {
    try plugin.resolveMacro(moduleName: moduleName, typeName: typeName)
  }
}

#if canImport(ucrt)
private let dup = _dup(_:)
private let fileno = _fileno(_:)
private let dup2 = _dup2(_:_:)
private let close = _close(_:)
private let read = _read(_:_:_:)
private let write = _write(_:_:_:)
#endif

extension CompilerPlugin {

  /// Main entry point of the plugin — sets up a communication channel with
  /// the plugin host and runs the main message loop.
  public static func main() throws {
    let stdin = _ss_stdin()
    let stdout = _ss_stdout()
    let stderr = _ss_stderr()

    // Duplicate the `stdin` file descriptor, which we will then use for
    // receiving messages from the plugin host.
    let inputFD = dup(fileno(stdin))
    guard inputFD >= 0 else {
      internalError("Could not duplicate `stdin`: \(describe(errno: _ss_errno())).")
    }

    // Having duplicated the original standard-input descriptor, we close
    // `stdin` so that attempts by the plugin to read console input (which
    // are usually a mistake) return errors instead of blocking.
    guard close(fileno(stdin)) >= 0 else {
      internalError("Could not close `stdin`: \(describe(errno: _ss_errno())).")
    }

    // Duplicate the `stdout` file descriptor, which we will then use for
    // sending messages to the plugin host.
    let outputFD = dup(fileno(stdout))
    guard outputFD >= 0 else {
      internalError("Could not dup `stdout`: \(describe(errno: _ss_errno())).")
    }

    // Having duplicated the original standard-output descriptor, redirect
    // `stdout` to `stderr` so that all free-form text output goes there.
    guard dup2(fileno(stderr), fileno(stdout)) >= 0 else {
      internalError("Could not dup2 `stdout` to `stderr`: \(describe(errno: _ss_errno())).")
    }

    #if canImport(ucrt)
    // Set I/O to binary mode. Avoid CRLF translation, and Ctrl+Z (0x1A) as EOF.
    _ = _setmode(inputFD, _O_BINARY)
    _ = _setmode(outputFD, _O_BINARY)
    #endif

    // Open a message channel for communicating with the plugin host.
    let connection = PluginHostConnection(
      inputStream: inputFD,
      outputStream: outputFD
    )

    // Handle messages from the host until the input stream is closed,
    // indicating that we're done.
    let provider = MacroProviderAdapter(plugin: Self())
    let impl = CompilerPluginMessageHandler(connection: connection, provider: provider)
    do {
      try impl.main()
    } catch {
      // Emit a diagnostic and indicate failure to the plugin host,
      // and exit with an error code.
      internalError(String(describing: error))
    }
  }

  // Private function to report internal errors and then exit.
  fileprivate static func internalError(_ message: String) -> Never {
    fputs("Internal Error: \(message)\n", _ss_stderr())
    exit(1)
  }
}

internal struct PluginHostConnection: MessageConnection {
  fileprivate let inputStream: CInt
  fileprivate let outputStream: CInt

  func sendMessage<TX: Encodable>(_ message: TX) throws {
    // Encode the message as JSON.
    let payload = try JSON.encode(message)

    // Write the header (a 64-bit length field in little endian byte order).
    let count = payload.count
    var header = UInt64(count).littleEndian
    try withUnsafeBytes(of: &header) { try _write(outputStream, contentsOf: $0) }

    // Write the JSON payload.
    try payload.withUnsafeBytes { try _write(outputStream, contentsOf: $0) }
  }

  func waitForNextMessage<RX: Decodable>(_ ty: RX.Type) throws -> RX? {
    // Read the header (a 64-bit length field in little endian byte order).
    var header: UInt64 = 0
    do {
      try withUnsafeMutableBytes(of: &header) { try _read(inputStream, into: $0) }
    } catch IOError.readReachedEndOfInput {
      // Connection closed.
      return nil
    }

    // Read the JSON payload.
    let count = Int(UInt64(littleEndian: header))
    let data = UnsafeMutableRawBufferPointer.allocate(byteCount: count, alignment: 1)
    defer { data.deallocate() }
    try _read(inputStream, into: data)

    // Decode and return the message.
    return try JSON.decode(ty, from: UnsafeBufferPointer(data.bindMemory(to: UInt8.self)))
  }
}

/// Write the buffer to the file descriptor. Throws an error on failure.
private func _write(_ fd: CInt, contentsOf buffer: UnsafeRawBufferPointer) throws {
  guard var ptr = buffer.baseAddress else { return }
  let endPtr = ptr.advanced(by: buffer.count)
  while ptr != endPtr {
    switch write(fd, ptr, numericCast(endPtr - ptr)) {
    case -1: throw IOError.writeFailed(_ss_errno())
    case 0: throw IOError.writeFailed(0) /* unreachable */
    case let n: ptr += Int(n)
    }
  }
}

/// Fill the buffer to the file descriptor. Throws an error on failure.
/// If the file descriptor reached the end-of-file, throws IOError.readReachedEndOfInput
private func _read(_ fd: CInt, into buffer: UnsafeMutableRawBufferPointer) throws {
  guard var ptr = buffer.baseAddress else { return }
  let endPtr = ptr.advanced(by: buffer.count)
  while ptr != endPtr {
    switch read(fd, ptr, numericCast(endPtr - ptr)) {
    case -1: throw IOError.readFailed(_ss_errno())
    case 0: throw IOError.readReachedEndOfInput
    case let n: ptr += Int(n)
    }
  }
}

private enum IOError: Error, CustomStringConvertible {
  case readReachedEndOfInput
  case readFailed(CInt)
  case writeFailed(CInt)

  var description: String {
    switch self {
    case .readReachedEndOfInput: "read(2) reached end-of-file"
    case .readFailed(let errno): "read(2) failed: \(describe(errno: errno))"
    case .writeFailed(let errno): "write(2) failed: \(describe(errno: errno))"
    }
  }
}

// Private function to construct an error message from an `errno` code.
private func describe(errno: CInt) -> String {
  if let cStr = strerror(errno) { return String(cString: cStr) }
  return String(describing: errno)
}
