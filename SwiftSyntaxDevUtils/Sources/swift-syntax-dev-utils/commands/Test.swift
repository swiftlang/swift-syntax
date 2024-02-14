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

struct Test: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Run swift-syntax tests."
  )

  @OptionGroup
  var arguments: BuildArguments

  func run() throws {
    let executor = TestExecutor(
      swiftPMBuilder: SwiftPMBuilder(
        toolchain: try arguments.toolchain,
        buildDir: arguments.buildDir,
        multirootDataFile: arguments.multirootDataFile,
        release: arguments.release,
        enableRawSyntaxValidation: arguments.enableRawSyntaxValidation,
        enableTestFuzzing: arguments.enableTestFuzzing,
        verbose: arguments.verbose
      ),
      warningsAsErrors: arguments.warningsAsErrors
    )
    try executor.run()
  }
}

struct TestExecutor {
  private let swiftPMBuilder: SwiftPMBuilder
  private let warningsAsErrors: Bool

  init(swiftPMBuilder: SwiftPMBuilder, warningsAsErrors: Bool = false) {
    self.swiftPMBuilder = swiftPMBuilder
    self.warningsAsErrors = warningsAsErrors
  }

  func run() throws {
    try runTests()
    try runCodeGenerationTests()
    try runExamplesTests()

    logSection("All tests passed")
  }

  private func runTests() throws {
    logSection("Running SwiftSyntax Tests")

    try swiftPMBuilder.invokeSwiftPM(
      action: "test",
      packageDir: Paths.packageDir,
      warningsAsErrors: warningsAsErrors,
      additionalArguments: ["--test-product", "swift-syntaxPackageTests"],
      additionalEnvironment: swiftPMBuilder.swiftPMEnvironmentVariables,
      captureStdout: false,
      captureStderr: false
    )
  }

  private func runCodeGenerationTests() throws {
    logSection("Running CodeGeneration Tests")
    try swiftPMBuilder.invokeSwiftPM(
      action: "test",
      packageDir: Paths.codeGenerationDir,
      warningsAsErrors: warningsAsErrors,
      additionalArguments: ["--test-product", "CodeGenerationPackageTests"],
      additionalEnvironment: swiftPMBuilder.swiftPMEnvironmentVariables,
      captureStdout: false,
      captureStderr: false
    )
  }

  private func runExamplesTests() throws {
    logSection("Running Examples Tests")
    try swiftPMBuilder.invokeSwiftPM(
      action: "test",
      packageDir: Paths.examplesDir,
      warningsAsErrors: warningsAsErrors,
      additionalArguments: ["--test-product", "ExamplesPackageTests"],
      additionalEnvironment: swiftPMBuilder.swiftPMEnvironmentVariables,
      captureStdout: false,
      captureStderr: false
    )
  }

  private func findSwiftpmBinPath(packageDir: URL) throws -> String {
    return try swiftPMBuilder.invokeSwiftPM(
      action: "build",
      packageDir: packageDir,
      warningsAsErrors: warningsAsErrors,
      additionalArguments: ["--show-bin-path"],
      additionalEnvironment: [:]
    ).stdout
  }
}
