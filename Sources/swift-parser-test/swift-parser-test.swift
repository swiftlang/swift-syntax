//===------------ main.swift - Entry point for swift-parser-test ----------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//


import SwiftSyntax
import SwiftParser
import Foundation
import ArgumentParser
#if os(Windows)
import WinSDK
#endif

enum CommonError: Swift.Error {
  case readingSourceFileFailed(URL)

  public var description: String {
    switch self {
    case .readingSourceFileFailed(let url):
      return "Reading the source file at \(url) failed"
    }
  }
}

/// Print the given message to stderr
func printerr(_ message: String, terminator: String = "\n") {
  FileHandle.standardError.write((message + terminator).data(using: .utf8)!)
}

private func withTemporaryFile<T>(contents: String, body: (URL) throws -> T) throws -> T {
  var tempFileURL = FileManager.default.temporaryDirectory
  tempFileURL.appendPathComponent("swift-parser-test-\(UUID().uuidString).swift")
  try contents.write(to: tempFileURL, atomically: false, encoding: .utf8)
  defer {
    try? FileManager.default.removeItem(at: tempFileURL)
  }
  return try body(tempFileURL)
}

private func getContentsOfSourceFile(at path: String) throws -> String {
  let sourceURL = URL(fileURLWithPath: path)
  guard let source = try String(data: Data(contentsOf: sourceURL), encoding: .utf8) else {
    throw CommonError.readingSourceFileFailed(sourceURL)
  }
  return source
}

@main
class SwiftParserTest: ParsableCommand {
  required init() {}

  static var configuration = CommandConfiguration(
    abstract: "Utility to test SwiftSyntax syntax tree creation.",
    subcommands: [VerifyRoundTrip.self, DumpTree.self, PrintDiags.self, Reduce.self]
  )
}

class VerifyRoundTrip: ParsableCommand {
  required init() {}

  init(sourceFile: String, swiftVersion: String?, enableBareSlashRegex: Bool?) {
    self.sourceFile = sourceFile
    self.swiftVersion = swiftVersion
    self.enableBareSlashRegex = enableBareSlashRegex
  }

  @Argument(help: "The source file that should be parsed")
  var sourceFile: String

  @Option(name: .long, help: "Interpret input according to a specific Swift language version number")
  var swiftVersion: String?

  @Option(name: .long, help: "Enable or disable the use of forward slash regular-expression literal syntax")
  var enableBareSlashRegex: Bool?

  enum Error: Swift.Error, CustomStringConvertible {
    case roundTripFailed

    public var description: String {
      switch self {
      case .roundTripFailed:
        return "Round-tripping the source file failed"
      }
    }
  }

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    try Self.run(source: source, swiftVersion: swiftVersion, enableBareSlashRegex: enableBareSlashRegex)
  }

  static func run(source: String, swiftVersion: String?, enableBareSlashRegex: Bool?) throws {
    let tree = try Parser.parse(
      source: source,
      languageVersion: swiftVersion,
      enableBareSlashRegexLiteral: enableBareSlashRegex
    )
    if tree.description != source {
      throw Error.roundTripFailed
    }
  }
}

class PrintDiags: ParsableCommand {
  required init() {}

  @Argument(help: "The source file that should be parsed")
  var sourceFile: String

  @Option(name: .long, help: "Interpret input according to a specific Swift language version number")
  var swiftVersion: String?

  @Option(name: .long, help: "Enable or disable the use of forward slash regular-expression literal syntax")
  var enableBareSlashRegex: Bool?

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    let tree = try Parser.parse(
      source: source,
      languageVersion: swiftVersion,
      enableBareSlashRegexLiteral: enableBareSlashRegex
    )
    let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
    let locationConverter = SourceLocationConverter(file: sourceFile, tree: tree)
    if diags.isEmpty {
      print("No diagnostics produced")
    }
    for diag in diags {
      let location = diag.location(converter: locationConverter)
      let message = diag.message
      print("\(location): \(message)")
    }
  }
}

class DumpTree: ParsableCommand {
  required init() {}

  @Argument(help: "The source file that should be parsed")
  var sourceFile: String

  @Option(name: .long, help: "Interpret input according to a specific Swift language version number")
  var swiftVersion: String?

  @Option(name: .long, help: "Enable or disable the use of forward slash regular-expression literal syntax")
  var enableBareSlashRegex: Bool?

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    let tree = try Parser.parse(
      source: source,
      languageVersion: swiftVersion,
      enableBareSlashRegexLiteral: enableBareSlashRegex
    )
    print(tree.recursiveDescription)
  }
}

class Reduce: ParsableCommand {
  required init() {}

  @Argument(help: "The test case that should be reduced")
  var sourceFile: String

  @Option(name: .long, help: "Interpret input according to a specific Swift language version number")
  var swiftVersion: String?

  @Option(name: .long, help: "Enable or disable the use of forward slash regular-expression literal syntax")
  var enableBareSlashRegex: Bool?

  @Flag(help: "Print status updates while reducing the test case")
  var verbose: Bool = false

  enum Error: Swift.Error, CustomStringConvertible {
    case testDoesNotFail

    public var description: String {
      switch self {
      case .testDoesNotFail:
        return "Source file passed to reduce subcommand does not fail to roundtrip"
      }
    }
  }

  enum ProcessExit {
    /// The process finished successfully.
    case success
    /// The process finished with an exit code of 1, indicating that it failed but did not crash
    case failure
    /// Running the process didn't finish in a specified timeout
    case timeout
    /// The process exited with an exit code that was neither 0 nor 1 and might have been a crash.
    case potentialCrash
  }

  /// Invoke `swift-parser-test verify-round-trip` with the same arguments as this `reduce` subcommand.
  /// Returns the exit code of the invocation.
  private func runVerifyRoundTripInSeparateProcess(source: String) throws -> ProcessExit {
    return try withTemporaryFile(contents: source) { tempFileURL in
      let process = Process()
      process.executableURL = URL(fileURLWithPath: ProcessInfo.processInfo.arguments[0])
      process.arguments = [
        "verify-round-trip", tempFileURL.path,
      ]
      if let enableBareSlashRegex = enableBareSlashRegex {
        process.arguments! += [
          "--enable-bare-slash-regex", enableBareSlashRegex ? "true" : "false"
        ]
      }
      if let swiftVersion = swiftVersion {
        process.arguments! += [
          "--swift-version", swiftVersion
        ]
      }
      let sema = DispatchSemaphore(value: 0)
      process.standardOutput = FileHandle.nullDevice
      process.standardError = FileHandle.nullDevice
      process.terminationHandler = { process in
        sema.signal()
      }

      try process.run()
      if sema.wait(timeout: DispatchTime.now() + .seconds(2)) == .timedOut {
#if os(Windows)
        _ = TerminateProcess(process.processHandle, 0)
#else
        kill(pid_t(process.processIdentifier), SIGKILL)
#endif
        return .timeout
      }
      switch process.terminationStatus {
      case 0:
        return .success
      case 1:
        return .potentialCrash
      default:
        return .potentialCrash
      }
    }
  }

  /// Runs the `verify-round-trip` subcommand in process.
  /// Returns `true` if `source` round-tripped successfully, `false` otherwise.
  private func runVerifyRoundTripInCurrentProcess(source: String) throws -> Bool {
    do {
      try VerifyRoundTrip.run(source: source, swiftVersion: self.swiftVersion, enableBareSlashRegex: self.enableBareSlashRegex)
    } catch {
      return false
    }
    return true
  }

  private func reduce(source: String, testPasses: (String) throws -> Bool) throws -> String {
    var reduced = source
    var chunkSize = source.count / 4
    while chunkSize > 0 {
      if chunkSize < reduced.count / 20 {
        // The chunk sizes are really tiny compared to the source file. Looks like we aren't making any progress reducing. Abort.
        break
      }
      if verbose {
        printerr("Current source size \(reduced.count), reducing with chunk size \(chunkSize)")
      }
      reduced = try reduceImpl(source: reduced, chunkSize: chunkSize, testPasses: testPasses)
      chunkSize = min(
        reduced.count / 2,
        chunkSize / 2
      )
    }
    return reduced
  }

  /// Reduces a test case with `source` by iteratively attempting to remove `chunkSize` characters - ie. removing the chunk if `testPasses` returns `false`.
  private func reduceImpl(source: String, chunkSize: Int, testPasses: (String) throws -> Bool) rethrows -> String {
    var reduced = ""
    // Characters that stil need to be checked whether they can be removed.
    var remaining = source
    while !remaining.isEmpty {
      let index = remaining.index(remaining.startIndex, offsetBy: chunkSize, limitedBy: remaining.endIndex) ?? remaining.endIndex
      let testChunk = String(remaining[..<index])
      remaining = String(remaining[index...])
      if try testPasses(reduced + remaining) {
        // The test doesn't fail anymore if we remove testChunk. Add it again.
        reduced.append(testChunk)
      }
    }
    return reduced
  }

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    let testPasses: (String) throws -> Bool
    switch try runVerifyRoundTripInSeparateProcess(source: source) {
    case .success:
      throw Error.testDoesNotFail
    case .failure:
      // Round-tripping did not crash. We can run the checks in-process
      testPasses = self.runVerifyRoundTripInCurrentProcess
    case .potentialCrash, .timeout:
      // Invoking verify-round-trip might have crashed. We don’t want to crash this process, so run in a separate process.
      testPasses = { try self.runVerifyRoundTripInSeparateProcess(source: $0) == .success }
    }

    var checks = 0
    let reduced = try reduce(source: source) { reducedSource in
      checks += 1
      return try testPasses(reducedSource)
    }
    if verbose {
      printerr("Reduced from \(source.count) to \(reduced.count) characters in \(checks) iterations")
    }
    print(reduced)
  }
}
