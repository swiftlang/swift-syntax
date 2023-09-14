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
    try runTests()
    try runCodeGenerationTests()

    logSection("All tests passed")
  }

  private func runTests() throws {
    logSection("Running SwiftSyntax Tests")

    try invokeSwiftPM(
      action: "test",
      packageDir: Paths.packageDir,
      additionalArguments: ["--test-product", "swift-syntaxPackageTests"],
      additionalEnvironment: swiftPMEnvironmentVariables,
      captureStdout: false,
      captureStderr: false
    )
  }

  private func runCodeGenerationTests() throws {
    logSection("Running CodeGeneration Tests")
    try invokeSwiftPM(
      action: "test",
      packageDir: Paths.codeGenerationDir,
      additionalArguments: ["--test-product", "CodeGenerationPackageTests"],
      additionalEnvironment: swiftPMEnvironmentVariables,
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
