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

struct LocalPrPrecheck: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: """
      Ensure changes are fully tested, formatted, and validated before pull request submission.
      """
  )

  @OptionGroup
  var arguments: SourceCodeGeneratorArguments

  func run() throws {
    let executor = LocalPrPrecheckExecutor(
      toolchain: try arguments.toolchain,
      verbose: arguments.verbose
    )
    try executor.run()
  }
}

struct LocalPrPrecheckExecutor {
  private let formatExecutor: FormatExecutor
  private let generateSourceCodeExecutor: GenerateSourceCodeExecutor
  private let buildExecutor: BuildExecutor
  private let testExecutor: TestExecutor

  /// Creates an executor
  /// - Parameters:
  ///   - toolchain: The path to the toolchain that shall be used to build SwiftSyntax.
  ///   - verbose: Enable verbose logging.
  init(toolchain: URL, verbose: Bool = false) {
    self.formatExecutor = FormatExecutor(update: false, verbose: verbose)
    self.generateSourceCodeExecutor = GenerateSourceCodeExecutor(toolchain: toolchain, verbose: verbose)
    self.buildExecutor = BuildExecutor(
      swiftPMBuilder: SwiftPMBuilder(toolchain: toolchain, useLocalDeps: false, verbose: verbose)
    )
    self.testExecutor = TestExecutor(
      swiftPMBuilder: SwiftPMBuilder(toolchain: toolchain, useLocalDeps: false, verbose: verbose)
    )
  }

  func run() throws {
    try formatExecutor.run()
    try generateSourceCodeExecutor.run(sourceDir: Paths.sourcesDir)
    try buildExecutor.run()
    try testExecutor.run()
  }
}
