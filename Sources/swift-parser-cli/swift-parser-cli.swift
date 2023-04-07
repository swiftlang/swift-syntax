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

import _InstructionCounter
import SwiftDiagnostics
import SwiftSyntax
import SwiftParser
import SwiftParserDiagnostics
import SwiftOperators
import Foundation
import ArgumentParser
#if os(Windows)
import WinSDK
#endif

/// Print the given message to stderr
func printerr(_ message: String, terminator: String = "\n") {
  FileHandle.standardError.write((message + terminator).data(using: .utf8)!)
}

private func withTemporaryFile<T>(contents: [UInt8], body: (URL) throws -> T) throws -> T {
  var tempFileURL = FileManager.default.temporaryDirectory
  tempFileURL.appendPathComponent("swift-parser-cli-\(UUID().uuidString).swift")
  try Data(contents).write(to: tempFileURL)
  defer {
    try? FileManager.default.removeItem(at: tempFileURL)
  }
  return try body(tempFileURL)
}

private func getContentsOfSourceFile(at path: String?) throws -> [UInt8] {
  let source: Data
  if let path = path {
    let sourceURL = URL(fileURLWithPath: path)
    source = try Data(contentsOf: sourceURL)
  } else {
    source = FileHandle.standardInput.readDataToEndOfFile()
  }
  return [UInt8](source)
}

extension String {
  /// Drop everything up to and including the last '/' from the string.
  fileprivate func withoutPath() -> String {
    // Only keep everything after the last slash.
    if let lastSlash = lastIndex(of: "/") {
      return String(self[index(after: lastSlash)...])
    }

    return self
  }
}

/// Fold all of the sequences in the given source file.
func foldAllSequences(_ tree: SourceFileSyntax) -> (Syntax, [Diagnostic]) {
  var diags: [Diagnostic] = []

  let recordOperatorError: (OperatorError) -> Void = { error in
    diags.append(error.asDiagnostic)
  }
  var operatorTable = OperatorTable.standardOperators
  operatorTable.addSourceFile(tree, errorHandler: recordOperatorError)
  let resultTree = operatorTable.foldAll(tree, errorHandler: recordOperatorError)
  return (resultTree, diags)
}

@main
class SwiftParserCli: ParsableCommand {
  required init() {}

  static var configuration = CommandConfiguration(
    abstract: "Utility to test SwiftSyntax syntax tree creation.",
    subcommands: [
      PerformanceTest.self,
      PrintDiags.self,
      PrintTree.self,
      Reduce.self,
      VerifyRoundTrip.self,
    ]
  )
}

class VerifyRoundTrip: ParsableCommand {
  required init() {}

  static var configuration = CommandConfiguration(
    commandName: "verify-round-trip",
    abstract: "Verify that printing the parsed syntax tree produces the original source"
  )

  init(sourceFile: String?) {
    self.sourceFile = sourceFile
  }

  @Argument(help: "The source file that should be parsed; if omitted, use stdin")
  var sourceFile: String?

  @Flag(name: .long, help: "Perform sequence folding with the standard operators")
  var foldSequences: Bool = false

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

    try source.withUnsafeBufferPointer { sourceBuffer in
      try Self.run(
        source: sourceBuffer,
        foldSequences: foldSequences
      )
    }
  }

  static func run(
    source: UnsafeBufferPointer<UInt8>,
    foldSequences: Bool
  ) throws {
    let tree = Parser.parse(source: source)

    var diags = ParseDiagnosticsGenerator.diagnostics(for: tree)

    let resultTree: Syntax
    if foldSequences {
      let folded = foldAllSequences(tree)
      resultTree = folded.0
      diags += folded.1
    } else {
      resultTree = Syntax(tree)
    }

    _ = DiagnosticsFormatter.annotatedSource(tree: tree, diags: diags)

    if resultTree.syntaxTextBytes != [UInt8](source) {
      throw Error.roundTripFailed
    }
  }
}

class PerformanceTest: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "performance-test",
    abstract: "Parse all .swift files in '--directory' and its subdirectories '--iteration' times and output the average time (in milliseconds) one iteration took."
  )

  required init() {}

  @Option(help: "The directory in which all .swift files should be parsed")
  var directory: String

  @Option(help: "How many times should the directory be parsed?")
  var iterations: Int

  func run() throws {
    let sourceDir = URL(fileURLWithPath: self.directory)

    let files = try FileManager.default
      .enumerator(at: sourceDir, includingPropertiesForKeys: nil)!
      .compactMap({ $0 as? URL })
      .filter { $0.pathExtension == "swift" }
      .map { try Data(contentsOf: $0) }

    let start = Date()
    let startInstructions = getInstructionsExecuted()
    for _ in 0..<self.iterations {
      for file in files {
        file.withUnsafeBytes { buf in
          _ = Parser.parse(source: buf.bindMemory(to: UInt8.self))
        }
      }
    }
    let endInstructions = getInstructionsExecuted()
    let endDate = Date()

    print("Time:         \(endDate.timeIntervalSince(start) / Double(self.iterations) * 1000)ms")
    if endInstructions != startInstructions {
      // endInstructions == startInstructions only happens if we are on non-macOS
      // platforms that don't support `getInstructionsExecuted`. Don't display anything.
      print("Instructions: \(Double(endInstructions - startInstructions) / Double(self.iterations))")
    }
  }
}

class PrintDiags: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "print-diags",
    abstract: "Print the diagnostics produced by parsing a soruce file"
  )

  required init() {}

  @Argument(help: "The source file that should be parsed; if omitted, use stdin")
  var sourceFile: String?

  @Flag(name: .long, help: "Perform sequence folding with the standard operators")
  var foldSequences: Bool = false

  @Flag(name: .long, help: "Force output coloring with ANSI color codes")
  var colorize: Bool = false

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    source.withUnsafeBufferPointer { sourceBuffer in
      let tree = Parser.parse(source: sourceBuffer)
      var diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
      if foldSequences {
        diags += foldAllSequences(tree).1
      }

      var group = GroupedDiagnostics()
      group.addSourceFile(tree: tree, displayName: sourceFile ?? "stdin", diagnostics: diags)
      let annotatedSource = DiagnosticsFormatter.annotateSources(
        in: group,
        colorize: colorize || TerminalHelper.isConnectedToTerminal
      )

      print(annotatedSource)

      if diags.isEmpty {
        print("No diagnostics produced")
      }
    }
  }
}

class PrintTree: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "print-tree",
    abstract: "Print the syntax tree produced by parsing a source file"
  )

  required init() {}

  @Argument(help: "The source file that should be parsed; if omitted, use stdin")
  var sourceFile: String?

  @Flag(name: .long, help: "Perform sequence folding with the standard operators")
  var foldSequences: Bool = false

  @Flag(name: .long, help: "Include trivia in the output")
  var includeTrivia: Bool = false

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    source.withUnsafeBufferPointer { sourceBuffer in
      let tree = Parser.parse(source: sourceBuffer)

      let resultTree: Syntax
      if foldSequences {
        resultTree = foldAllSequences(tree).0
      } else {
        resultTree = Syntax(tree)
      }

      print(resultTree.debugDescription(includeTrivia: includeTrivia))
    }
  }
}

class Reduce: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "reduce",
    abstract: "Reduce a test case that crashes the parser or fails to round-trip to a smaller test case that still reproduces the issue"
  )

  required init() {}

  @Argument(help: "The test case that should be reduced; if omitted, use stdin")
  var sourceFile: String?

  @Flag(name: .long, help: "Perform sequence folding with the standard operators")
  var foldSequences: Bool = false

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

  /// Invoke `swift-parser-cli verify-round-trip` with the same arguments as this `reduce` subcommand.
  /// Returns the exit code of the invocation.
  private func runVerifyRoundTripInSeparateProcess(source: [UInt8]) throws -> ProcessExit {
    #if os(iOS) || os(tvOS) || os(watchOS)
    // We cannot launch a new process on iOS-like platforms.
    // Default to running verification in-process.
    // Honestly, this isn't very important because you can't launch swift-parser-cli
    // on iOS anyway but this fixes a compilation error of the pacakge on iOS.
    return try runVerifyRoundTripInCurrentProcess(source: source) ? ProcessExit.success : ProcessExit.potentialCrash
    #else
    return try withTemporaryFile(contents: source) { tempFileURL in
      let process = Process()
      process.executableURL = URL(fileURLWithPath: ProcessInfo.processInfo.arguments[0])
      process.arguments = [
        "verify-round-trip", tempFileURL.path,
      ]
      if foldSequences {
        process.arguments! += ["--fold-sequences"]
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
    #endif
  }

  /// Runs the `verify-round-trip` subcommand in process.
  /// Returns `true` if `source` round-tripped successfully, `false` otherwise.
  private func runVerifyRoundTripInCurrentProcess(source: [UInt8]) throws -> Bool {
    do {
      try source.withUnsafeBufferPointer { sourceBuffer in
        try VerifyRoundTrip.run(
          source: sourceBuffer,
          foldSequences: foldSequences
        )
      }
    } catch {
      return false
    }
    return true
  }

  private func reduce(source: [UInt8], testPasses: ([UInt8]) throws -> Bool) throws -> [UInt8] {
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
  private func reduceImpl(source: [UInt8], chunkSize: Int, testPasses: ([UInt8]) throws -> Bool) rethrows -> [UInt8] {
    var reduced: [UInt8] = []
    // Characters that stil need to be checked whether they can be removed.
    var remaining = source
    while !remaining.isEmpty {
      let index = remaining.index(remaining.startIndex, offsetBy: chunkSize, limitedBy: remaining.endIndex) ?? remaining.endIndex
      let testChunk = [UInt8](remaining[..<index])
      remaining = [UInt8](remaining[index...])
      if try testPasses(reduced + remaining) {
        // The test doesn't fail anymore if we remove testChunk. Add it again.
        reduced.append(contentsOf: testChunk)
      }
    }
    return reduced
  }

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    let testPasses: ([UInt8]) throws -> Bool
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

    FileHandle.standardOutput.write(Data(reduced))
  }
}
