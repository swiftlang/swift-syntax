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

import ArgumentParser
import Foundation

#if os(Windows)
import WinSDK
#endif

fileprivate func withTemporaryFile<T>(contents: [UInt8], body: (URL) throws -> T) throws -> T {
  var tempFileURL = FileManager.default.temporaryDirectory
  tempFileURL.appendPathComponent("swift-parser-cli-\(UUID().uuidString).swift")
  try Data(contents).write(to: tempFileURL)
  defer {
    try? FileManager.default.removeItem(at: tempFileURL)
  }
  return try body(tempFileURL)
}

struct Reduce: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "reduce",
    abstract:
      "Reduce a test case that crashes the parser or fails to round-trip to a smaller test case that still reproduces the issue"
  )

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
      let index =
        remaining.index(remaining.startIndex, offsetBy: chunkSize, limitedBy: remaining.endIndex) ?? remaining.endIndex
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
