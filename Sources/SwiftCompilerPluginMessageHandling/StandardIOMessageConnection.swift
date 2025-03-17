//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6) && RESILIENT_LIBRARIES
@_implementationOnly private import _SwiftSyntaxCShims
#elseif compiler(>=6) && !RESILIENT_LIBRARIES
private import _SwiftSyntaxCShims
#elseif !compiler(>=6) && RESILIENT_LIBRARIES
@_implementationOnly import _SwiftSyntaxCShims
#elseif !compiler(>=6) && !RESILIENT_LIBRARIES
import _SwiftSyntaxCShims
#endif

#if canImport(ucrt)
private let dup = _dup(_:)
private let fileno = _fileno(_:)
private let dup2 = _dup2(_:_:)
private let close = _close(_:)
private let read = _read(_:_:_:)
private let write = _write(_:_:_:)
#endif

/// Concrete 'MessageConnection' type using Standard I/O.
///
/// Each message is serialized to UTF-8 encoded JSON text, prefixed with a
/// 8 byte header which is the byte size of the JSON payload serialized to a
/// little-endian 64bit unsigned integer.
@_spi(PluginMessage)
public struct StandardIOMessageConnection: MessageConnection {
  private let inputFileDescriptor: CInt
  private let outputFileDescriptor: CInt

  public init(inputFileDescriptor: CInt, outputFileDescriptor: CInt) {
    self.inputFileDescriptor = inputFileDescriptor
    self.outputFileDescriptor = outputFileDescriptor
  }

  #if os(WASI)
  /// Convenience initializer for Wasm executable plugins. Connects
  /// directly to `stdin` and `stdout` as WASI doesn't support
  /// `dup{,2}`.
  public init() throws {
    let inputFD = fileno(swift_syntax_stdin)
    let outputFD = fileno(swift_syntax_stdout)
    self.init(inputFileDescriptor: inputFD, outputFileDescriptor: outputFD)
  }
  #else
  /// Convenience initializer for normal executable plugins. Upon creation:
  ///   - Redirect `stdout` to `stderr` so that print statements from the plugin
  ///     are treated as plain-text output
  ///   - Close `stdin` so that any attempts by the plugin logic to read from
  ///     console result in errors  instead of blocking the process
  ///   - Duplicate the original `stdin` and `stdout` for use as messaging
  ///     pipes, and are not directly used by the plugin logic
  public init() throws {
    // Duplicate the `stdin` file descriptor, which we will then use for
    // receiving messages from the plugin host.
    let inputFD = dup(fileno(swift_syntax_stdin))
    guard inputFD >= 0 else {
      throw IOError.systemError(function: "dup(fileno(stdin))", errno: swift_syntax_errno)
    }

    // Having duplicated the original standard-input descriptor, we close
    // `stdin` so that attempts by the plugin to read console input (which
    // are usually a mistake) return errors instead of blocking.
    guard close(fileno(swift_syntax_stdin)) >= 0 else {
      throw IOError.systemError(function: "close(fileno(stdin))", errno: swift_syntax_errno)
    }

    // Duplicate the `stdout` file descriptor, which we will then use for
    // sending messages to the plugin host.
    let outputFD = dup(fileno(swift_syntax_stdout))
    guard outputFD >= 0 else {
      throw IOError.systemError(function: "dup(fileno(stdout))", errno: swift_syntax_errno)
    }

    // Having duplicated the original standard-output descriptor, redirect
    // `stdout` to `stderr` so that all free-form text output goes there.
    guard dup2(fileno(swift_syntax_stderr), fileno(swift_syntax_stdout)) >= 0 else {
      throw IOError.systemError(function: "dup2(fileno(stderr), fileno(stdout))", errno: swift_syntax_errno)
    }

    #if canImport(ucrt)
    // Set I/O to binary mode. Avoid CRLF translation, and Ctrl+Z (0x1A) as EOF.
    _ = _setmode(inputFD, _O_BINARY)
    _ = _setmode(outputFD, _O_BINARY)
    #endif

    self.init(inputFileDescriptor: inputFD, outputFileDescriptor: outputFD)
  }
  #endif

  /// Write the buffer to the file descriptor. Throws an error on failure.
  private func _write(contentsOf buffer: UnsafeRawBufferPointer) throws {
    guard var ptr = buffer.baseAddress else { return }
    let endPtr = ptr.advanced(by: buffer.count)
    while ptr != endPtr {
      switch write(outputFileDescriptor, ptr, numericCast(endPtr - ptr)) {
      case -1: throw IOError.systemError(function: "write(_:_:_:)", errno: swift_syntax_errno)
      case 0: throw IOError.systemError(function: "write", errno: 0) /* unreachable */
      case let n: ptr += Int(n)
      }
    }
  }

  /// Fill the buffer from the file descriptor. Throws an error on failure.
  /// If the file descriptor reached the end-of-file before filling up the entire
  /// buffer, throws IOError.readReachedEndOfInput
  private func _read(into buffer: UnsafeMutableRawBufferPointer) throws {
    guard var ptr = buffer.baseAddress else { return }
    let endPtr = ptr.advanced(by: buffer.count)
    while ptr != endPtr {
      switch read(inputFileDescriptor, ptr, numericCast(endPtr - ptr)) {
      case -1: throw IOError.systemError(function: "read(_:_:_:)", errno: swift_syntax_errno)
      case 0: throw IOError.readReachedEndOfInput
      case let n: ptr += Int(n)
      }
    }
  }

  public func sendMessage<TX: Encodable>(_ message: TX) throws {
    // Encode the message as JSON.
    let payload = try JSON.encode(message)

    // Write the header (a 64-bit length field in little endian byte order).
    let count = payload.count
    var header = UInt64(count).littleEndian
    try withUnsafeBytes(of: &header) { try _write(contentsOf: $0) }

    // Write the JSON payload.
    try payload.withUnsafeBytes { try _write(contentsOf: $0) }
  }

  public func waitForNextMessage<RX: Decodable>(_ type: RX.Type) throws -> RX? {
    // Read the header (a 64-bit length field in little endian byte order).
    var header: UInt64 = 0
    do {
      try withUnsafeMutableBytes(of: &header) { try _read(into: $0) }
    } catch IOError.readReachedEndOfInput {
      // Connection closed.
      return nil
    }

    // Read the JSON payload.
    let count = Int(UInt64(littleEndian: header))
    let data = UnsafeMutableRawBufferPointer.allocate(byteCount: count, alignment: 1)
    defer { data.deallocate() }
    try _read(into: data)

    // Decode and return the message.
    return try JSON.decode(type, from: UnsafeBufferPointer(data.bindMemory(to: UInt8.self)))
  }
}

private enum IOError: Error, CustomStringConvertible {
  case readReachedEndOfInput
  case systemError(function: String, errno: CInt)

  var description: String {
    switch self {
    case .readReachedEndOfInput:
      return "read(2) reached end-of-file"
    case .systemError(let function, let errno):
      return "\(function) failed: \(describe(errno: errno))"
    }
  }
}

// Private function to construct an error message from an `errno` code.
private func describe(errno: CInt) -> String {
  // We can't tell how long the error message will be but 1024 characters should be enough to hold most, if not all,
  // error messages.
  return withUnsafeTemporaryAllocation(of: CChar.self, capacity: 1024) { buffer in
    guard let baseAddress = buffer.baseAddress else {
      return ""
    }
    #if os(Windows)
    strerror_s(baseAddress, buffer.count, errno)
    #else
    strerror_r(errno, baseAddress, buffer.count)
    #endif
    return String(cString: baseAddress)
  }
}
