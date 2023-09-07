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

  func run() throws {
    try buildExample(exampleName: "ExamplePlugin")

    try runTests()

    logSection("All tests passed")
  }

  private func runTests() throws {
    logSection("Running SwiftSyntax Tests")
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
