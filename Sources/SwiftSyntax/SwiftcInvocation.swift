//===------- SwiftcInvocation.swift - Utilities for invoking swiftc -------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
// This file provides the logic for invoking swiftc to parse Swift files.
//===----------------------------------------------------------------------===//

import Foundation
import Basic

#if os(macOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

/// Runs the provided executable with the provided arguments and returns the
/// contents of stdout and stderr as Data.
/// - Parameters:
///   - executable: The full file path to the executable you're running.
///   - arguments: A list of strings to pass to the process as arguments.
/// - Returns: A ProcessResult containing stdout, stderr, and the exit code.
func run(_ executable: AbsolutePath, arguments: [String] = []) throws
    -> ProcessResult {
#if _runtime(_ObjC)
  // Use an autoreleasepool to prevent memory- and file-descriptor leaks.
  return try autoreleasepool { () -> ProcessResult in
    return try Basic.Process.popen(arguments: [executable.asString] + arguments)
  }
#else
  return try Basic.Process.popen(arguments: [executable.asString] + arguments)
#endif
}

enum InvocationError: Error, CustomStringConvertible {
  case couldNotFindSwiftc
  case couldNotFindSDK

  var description: String {
    switch self {
    case .couldNotFindSwiftc:
      return "could not locate swift compiler binary"
    case .couldNotFindSDK:
      return "could not locate macOS SDK"
    }
  }
}

struct SwiftcRunner {
#if os(macOS)
  /// The location of the macOS SDK, or `nil` if it could not be found.
  static let macOSSDK: String? = {
    do {
      guard let xcrunPath = Basic.Process.findExecutable("xcrun") else {
        return nil
      }
      let result = try run(xcrunPath, arguments: ["--show-sdk-path"])
      guard result.exitStatus == .terminated(code: 0) else { return nil }
      let output = try result.utf8Output()
      let toolPath = output.trimmingCharacters(in: .whitespacesAndNewlines)
      if toolPath.isEmpty { return nil }
      return toolPath
    } catch {
      return nil
    }
  }()
#endif
  /// The URL where the `swiftc` binary lies. If `nil` the `swiftc` binary is 
  // looked up from the `PATH` environment variable.
  let swiftcURL: URL?

  /// The source file being parsed.
  let sourceFile: URL

  /// - Parameter sourceFile: The URL to the source file you're trying
  ///                         to parse.

  /// Creates a SwiftcRunner that will parse and emit the syntax
  /// tree for a provided source file.
  /// - Parameters:
  ///   - sourceFile: The URL to the source file you're trying to parse
  ///   - swiftcURL: The URL where the `swiftc` binary lies. If `nil` the
  ///                `swiftc` binary is looked up from the `PATH` environment
  ///                variable.
  init(sourceFile: URL, swiftcURL: URL? = nil) throws {
    self.sourceFile = sourceFile
    self.swiftcURL = swiftcURL
  }

  /// Invokes swiftc with the provided arguments.
  func invoke() throws -> ProcessResult {
    var arguments = ["-frontend", "-emit-syntax"]
    arguments.append(sourceFile.path)
#if os(macOS)
    guard let sdk = SwiftcRunner.macOSSDK else {
      throw InvocationError.couldNotFindSDK
    }
    arguments.append("-sdk")
    arguments.append(sdk)
#endif
    let swiftcPath: AbsolutePath
    if let swiftcURL = self.swiftcURL {
      swiftcPath = AbsolutePath(swiftcURL.path)
    } else {
      guard let lookupResult = Basic.Process.findExecutable("swiftc") else {
        throw InvocationError.couldNotFindSwiftc
      }
      swiftcPath = lookupResult
    }
    return try run(swiftcPath, arguments: arguments)
  }
}
