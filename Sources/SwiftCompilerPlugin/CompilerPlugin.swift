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
public import SwiftSyntaxMacros
private import Foundation
private import SwiftCompilerPluginMessageHandling
#else
import SwiftSyntaxMacros
import Foundation
import SwiftCompilerPluginMessageHandling
#endif

#if os(Windows)
#if swift(>=6.0)
private import ucrt
#else
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

    let pluginPath = CommandLine.arguments.first ?? Bundle.main.executablePath ?? ProcessInfo.processInfo.processName
    throw CompilerPluginError(message: "macro implementation type '\(moduleName).\(typeName)' could not be found in executable plugin '\(pluginPath)'")
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

extension CompilerPlugin {

  /// Main entry point of the plugin — sets up a communication channel with
  /// the plugin host and runs the main message loop.
  public static func main() throws {
    // Duplicate the `stdin` file descriptor, which we will then use for
    // receiving messages from the plugin host.
    let inputFD = dup(fileno(stdin))
    guard inputFD >= 0 else {
      internalError("Could not duplicate `stdin`: \(describe(errno: errno)).")
    }

    // Having duplicated the original standard-input descriptor, we close
    // `stdin` so that attempts by the plugin to read console input (which
    // are usually a mistake) return errors instead of blocking.
    guard close(fileno(stdin)) >= 0 else {
      internalError("Could not close `stdin`: \(describe(errno: errno)).")
    }

    // Duplicate the `stdout` file descriptor, which we will then use for
    // sending messages to the plugin host.
    let outputFD = dup(fileno(stdout))
    guard outputFD >= 0 else {
      internalError("Could not dup `stdout`: \(describe(errno: errno)).")
    }

    // Having duplicated the original standard-output descriptor, redirect
    // `stdout` to `stderr` so that all free-form text output goes there.
    guard dup2(fileno(stderr), fileno(stdout)) >= 0 else {
      internalError("Could not dup2 `stdout` to `stderr`: \(describe(errno: errno)).")
    }

    // Turn off full buffering so printed text appears as soon as possible.
    // Windows is much less forgiving than other platforms.  If line
    // buffering is enabled, we must provide a buffer and the size of the
    // buffer.  As a result, on Windows, we completely disable all
    // buffering, which means that partial writes are possible.
    #if os(Windows)
    setvbuf(stdout, nil, _IONBF, 0)
    #else
    setvbuf(stdout, nil, _IOLBF, 0)
    #endif

    // Open a message channel for communicating with the plugin host.
    let connection = PluginHostConnection(
      inputStream: FileHandle(fileDescriptor: inputFD),
      outputStream: FileHandle(fileDescriptor: outputFD)
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
    fputs("Internal Error: \(message)\n", stderr)
    exit(1)
  }

  // Private function to construct an error message from an `errno` code.
  fileprivate static func describe(errno: Int32) -> String {
    if let cStr = strerror(errno) { return String(cString: cStr) }
    return String(describing: errno)
  }
}

internal struct PluginHostConnection: MessageConnection {
  fileprivate let inputStream: FileHandle
  fileprivate let outputStream: FileHandle

  func sendMessage<TX: Encodable>(_ message: TX) throws {
    // Encode the message as JSON.
    let payload = try JSONEncoder().encode(message)

    // Write the header (a 64-bit length field in little endian byte order).
    var count = UInt64(payload.count).littleEndian
    let header = Swift.withUnsafeBytes(of: &count) { Data($0) }
    precondition(header.count == 8)

    // Write the header and payload.
    try outputStream._write(contentsOf: header)
    try outputStream._write(contentsOf: payload)
  }

  func waitForNextMessage<RX: Decodable>(_ ty: RX.Type) throws -> RX? {
    // Read the header (a 64-bit length field in little endian byte order).
    guard
      let header = try inputStream._read(upToCount: 8),
      header.count != 0
    else {
      return nil
    }
    guard header.count == 8 else {
      throw PluginMessageError.truncatedHeader
    }

    // Decode the count.
    let count = header.withUnsafeBytes {
      UInt64(littleEndian: $0.loadUnaligned(as: UInt64.self))
    }
    guard count >= 2 else {
      throw PluginMessageError.invalidPayloadSize
    }

    // Read the JSON payload.
    guard
      let payload = try inputStream._read(upToCount: Int(count)),
      payload.count == count
    else {
      throw PluginMessageError.truncatedPayload
    }

    // Decode and return the message.
    return try JSONDecoder().decode(RX.self, from: payload)
  }

  enum PluginMessageError: Swift.Error {
    case truncatedHeader
    case invalidPayloadSize
    case truncatedPayload
  }
}

private extension FileHandle {
  func _write(contentsOf data: Data) throws {
    if #available(macOS 10.15.4, iOS 13.4, watchOS 6.2, tvOS 13.4, *) {
      return try self.write(contentsOf: data)
    } else {
      return self.write(data)
    }
  }

  func _read(upToCount count: Int) throws -> Data? {
    if #available(macOS 10.15.4, iOS 13.4, watchOS 6.2, tvOS 13.4, *) {
      return try self.read(upToCount: count)
    } else {
      return self.readData(ofLength: 8)
    }
  }
}

struct CompilerPluginError: Error, CustomStringConvertible {
  var description: String
  init(message: String) {
    self.description = message
  }
}
