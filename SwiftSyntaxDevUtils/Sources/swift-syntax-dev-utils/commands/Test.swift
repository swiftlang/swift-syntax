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

struct Test: ParsableCommand, BuildCommand {
  static var configuration: CommandConfiguration {
    return CommandConfiguration(
      abstract: "Run swift-syntax tests."
    )
  }

  @OptionGroup
  var arguments: BuildArguments

  @Flag(help: "Don't run lit-based tests")
  var skipLitTests: Bool = false

  @Option(
    help: """
      Path to the FileCheck executable that was built as part of the LLVM repository.
      If not specified, it will be looked up from PATH.
      """
  )
  var filecheckExec: String?

  func run() throws {
    try buildExample(exampleName: "ExamplePlugin")

    try runTests()

    logSection("All tests passed")
  }

  private func runTests() throws {
    logSection("Running SwiftSyntax Tests")

    if !skipLitTests {
      try runLitTests()
    }

    try runXCTests()
  }

  private func runLitTests() throws {
    logSection("Running lit-based tests")

    guard FileManager.default.fileExists(atPath: Paths.litExec.path) else {
      throw ScriptExectutionError(
        message: """
          Error: Could not find lit.py.
          Looking at '\(Paths.litExec.path)'.

          Make sure you have the llvm repo checked out next to the swift-syntax repo.
          Refer to README.md for more information.
          """
      )
    }

    let examplesBinPath = try findExamplesBinPath()

    var litCall = [
      Paths.litExec.path,
      Paths.packageDir.appendingPathComponent("lit_tests").path,
    ]

    if let filecheckExec {
      litCall += ["--param", "FILECHECK=" + filecheckExec]
    }

    litCall += ["--param", "EXAMPLES_BIN_PATH=" + examplesBinPath.path]
    litCall += ["--param", "TOOLCHAIN=" + arguments.toolchain.path]

    // Print all failures
    litCall += ["--verbose"]
    // Don't show all commands if verbose is not enabled
    if !arguments.verbose {
      litCall += ["--succinct"]
    }

    guard let pythonExec = Paths.python3Exec else {
      throw ScriptExectutionError(message: "Didn't find python3 executable")
    }

    let process = ProcessRunner(
      executableURL: pythonExec,
      arguments: litCall
    )

    let processOutput = try process.run(verbose: arguments.verbose)

    if !processOutput.stdout.isEmpty {
      logSection("lit test stdout")
      print(processOutput.stdout)
    }

    if !processOutput.stderr.isEmpty {
      logSection("lit test stderr")
      print(processOutput.stderr)
    }
  }

  private func runXCTests() throws {
    logSection("Running XCTests")
    var swiftpmCallArguments: [String] = []

    if arguments.verbose {
      swiftpmCallArguments += ["--verbose"]
    }

    swiftpmCallArguments += ["--test-product", "swift-syntaxPackageTests"]

    var additionalEnvironment: [String: String] = [:]
    additionalEnvironment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] = "1"

    if arguments.enableRawSyntaxValidation {
      additionalEnvironment["SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION"] = "1"
    }

    if arguments.enableTestFuzzing {
      additionalEnvironment["SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION"] = "1"
    }

    // Tell other projects in the unified build to use local dependencies
    additionalEnvironment["SWIFTCI_USE_LOCAL_DEPS"] = "1"
    additionalEnvironment["SWIFT_SYNTAX_PARSER_LIB_SEARCH_PATH"] =
      arguments.toolchain
      .appendingPathComponent("lib")
      .appendingPathComponent("swift")
      .appendingPathComponent("macosx")
      .path

    try invokeSwiftPM(
      action: "test",
      packageDir: Paths.packageDir,
      additionalArguments: swiftpmCallArguments,
      additionalEnvironment: additionalEnvironment,
      captureStdout: false,
      captureStderr: false
    )
  }

  private func findSwiftpmBinPath(packageDir: URL) throws -> String {
    return try invokeSwiftPM(
      action: "build",
      packageDir: packageDir,
      additionalArguments: ["--show-bin-path"],
      additionalEnvironment: [:]
    ).stdout
  }

  /// This returns a path to the build examples folder.
  /// Example: '<workingDir>/swift-syntax/Examples/.build/arm64-apple-macosx/debug
  private func findExamplesBinPath() throws -> URL {
    let stdOut = try findSwiftpmBinPath(packageDir: Paths.examplesDir)
    return URL(fileURLWithPath: stdOut.trimmingCharacters(in: .whitespacesAndNewlines))
  }
}
