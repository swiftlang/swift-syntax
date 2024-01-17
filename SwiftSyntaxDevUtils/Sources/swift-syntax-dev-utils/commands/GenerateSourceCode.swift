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

struct GenerateSourceCode: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Generate swift-syntax sources."
  )

  @OptionGroup
  var arguments: SourceCodeGeneratorArguments

  func run() throws {
    let executor = GenerateSourceCodeExecutor(
      toolchain: try arguments.toolchain,
      verbose: arguments.verbose
    )
    try executor.run(sourceDir: Paths.sourcesDir)
  }
}

struct GenerateSourceCodeExecutor {
  /// The path to the toolchain that shall be used to build SwiftSyntax.
  private let toolchain: URL

  /// Enable verbose logging.
  private let verbose: Bool

  /// Creates an executor
  /// - Parameters:
  ///   - toolchain: The path to the toolchain that shall be used to build SwiftSyntax.
  ///   - verbose: Enable verbose logging.
  init(toolchain: URL, verbose: Bool = false) {
    self.toolchain = toolchain
    self.verbose = verbose
  }

  func run(sourceDir: URL) throws {
    logSection("Running code generation")

    var args = [
      "run",
      "--package-path", Paths.codeGenerationDir.relativePath,
      "generate-swift-syntax", sourceDir.relativePath,
    ]

    if verbose {
      args += ["--verbose"]
    }

    let additionalEnvironment = [
      "SWIFT_BUILD_SCRIPT_ENVIRONMENT": "1",
      "SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION": "1",
      "SWIFTCI_USE_LOCAL_DEPS": nil,
    ]

    let process = ProcessRunner(
      executableURL: toolchain.appendingPathComponent("bin").appendingPathComponent("swift"),
      arguments: args,
      additionalEnvironment: additionalEnvironment
    )

    try process.run(verbose: verbose)
  }
}
