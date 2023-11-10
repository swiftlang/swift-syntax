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
        toolchain: arguments.toolchain,
        buildDir: arguments.buildDir,
        multirootDataFile: arguments.multirootDataFile,
        release: arguments.release,
        enableRawSyntaxValidation: arguments.enableRawSyntaxValidation,
        enableTestFuzzing: arguments.enableTestFuzzing,
        warningsAsErrors: arguments.warningsAsErrors,
        verbose: arguments.verbose
      )
    )
    try executor.run()
  }
}

struct TestExecutor {
  private let swiftPMBuilder: SwiftPMBuilder

  init(swiftPMBuilder: SwiftPMBuilder) {
    self.swiftPMBuilder = swiftPMBuilder
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
      additionalArguments: ["--show-bin-path"],
      additionalEnvironment: [:]
    ).stdout
  }
}
