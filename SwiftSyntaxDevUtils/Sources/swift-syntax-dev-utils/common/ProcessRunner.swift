//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

/// Keeps track of subprocesses spawned by this script and forwards SIGINT
/// signals to them.
class SigIntListener {
  /// The subprocesses spawned by this script that are currently running.
  static var runningSubprocesses: Set<Process> = []

  /// Whether a `SIGINT` signal has been received by this script.
  static var hasReceivedSigInt: Bool = false

  /// Registers a `SIGINT` signal handler that forwards `SIGINT` to all
  /// subprocesses that are registered in `runningSubprocesses`
  static func registerSigIntSubprocessTerminationHandler() {
    #if canImport(Darwin) || canImport(Glibc)
    signal(SIGINT) { _ in
      SigIntListener.hasReceivedSigInt = true
      for process in SigIntListener.runningSubprocesses {
        process.interrupt()
      }
    }
    #endif
  }
}

/// Provides convenience APIs for launching and gathering output from a subprocess
class ProcessRunner {
  private let process: Process

  init(
    executableURL: URL,
    arguments: [String],
    additionalEnvironment: [String: String?] = [:]
  ) {
    process = Process()
    process.executableURL = executableURL
    process.arguments = arguments
    process.environment = ProcessInfo.processInfo.environment
    for (key, value) in additionalEnvironment {
      process.environment![key] = value
    }
  }

  @discardableResult
  func run(
    captureStdout: Bool = true,
    captureStderr: Bool = true,
    verbose: Bool
  ) throws -> ProcessResult {
    if verbose {
      print(process.command)
    }

    let group = DispatchGroup()

    var stdoutData = Data()
    if captureStdout {
      let outPipe = Pipe()
      process.standardOutput = outPipe
      addHandler(pipe: outPipe, group: group) { stdoutData.append($0) }
    }

    var stderrData = Data()
    if captureStderr {
      let errPipe = Pipe()
      process.standardError = errPipe
      addHandler(pipe: errPipe, group: group) { stderrData.append($0) }
    }

    try process.run()
    SigIntListener.runningSubprocesses.insert(process)
    process.waitUntilExit()
    SigIntListener.runningSubprocesses.remove(process)
    if captureStdout || captureStderr {
      // Make sure we've received all stdout/stderr
      group.wait()
    }

    guard let stdoutString = String(data: stdoutData, encoding: .utf8) else {
      throw FailedToDecodeUTF8Error(data: stdoutData)
    }
    guard let stderrString = String(data: stderrData, encoding: .utf8) else {
      throw FailedToDecodeUTF8Error(data: stderrData)
    }

    guard process.terminationStatus == 0 else {
      throw NonZeroExitCodeError(
        process: process,
        stdout: stdoutString,
        stderr: stderrString,
        exitCode: Int(process.terminationStatus)
      )
    }

    return ProcessResult(
      stdout: stdoutString,
      stderr: stderrString
    )
  }

  private func addHandler(
    pipe: Pipe,
    group: DispatchGroup,
    addData: @escaping (Data) -> Void
  ) {
    group.enter()
    pipe.fileHandleForReading.readabilityHandler = { fileHandle in
      // Apparently using availableData can cause various issues
      let newData = fileHandle.readData(ofLength: Int.max)
      if newData.count == 0 {
        pipe.fileHandleForReading.readabilityHandler = nil;
        group.leave()
      } else {
        addData(newData)
      }
    }
  }
}

/// The exit code and output (if redirected) from a subprocess that has
/// terminated
struct ProcessResult {
  let stdout: String
  let stderr: String
}

/// Error thrown if a process terminates with a non-zero exit code.
struct NonZeroExitCodeError: Error, CustomStringConvertible {
  let process: Process
  let stdout: String
  let stderr: String
  let exitCode: Int

  var description: String {
    var result = """
      Command failed with non-zero exit code \(exitCode):
      Command: \(process.command)
      """
    if !stdout.isEmpty {
      result += """
        Standard output:
        \(stdout)
        """
    }
    if !stderr.isEmpty {
      result += """
        Standard error:
        \(stderr)
        """
    }
    return result
  }
}

/// Error thrown if `stdout` or `stderr` could not be decoded as UTF-8.
struct FailedToDecodeUTF8Error: Error {
  let data: Data
}
