//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if canImport(Glibc)
import Glibc
#elseif canImport(Musl)
import Musl
#elseif os(Windows)
import CRT
#else
import Darwin.C
#endif

#if os(Android)
typealias FILEPointer = OpaquePointer
#else
typealias FILEPointer = UnsafeMutablePointer<FILE>
#endif

enum TerminalHelper {
  static var isConnectedToTerminal: Bool {
    return isTTY(stderr)
  }

  /// Checks if passed file pointer is a tty.
  static func isTTY(_ filePointer: FILEPointer) -> Bool {
    return terminalType(filePointer) == .tty
  }

  /// The type of terminal.
  enum TerminalType {
    /// The terminal is a TTY.
    case tty

    /// The terminal is a file stream.
    case file
  }

  /// Computes the terminal type of the stream.
  static func terminalType(_ filePointer: FILEPointer) -> TerminalType {
    let isTTY = isatty(fileno(filePointer)) != 0
    return isTTY ? .tty : .file
  }
}
