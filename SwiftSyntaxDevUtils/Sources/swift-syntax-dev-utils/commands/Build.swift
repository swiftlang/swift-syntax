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

struct Build: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Build swift-syntax."
  )

  @OptionGroup
  var arguments: BuildArguments

  func run() throws {
    let executor = BuildExecutor(
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

struct BuildExecutor {
  private let swiftPMBuilder: SwiftPMBuilder

  init(swiftPMBuilder: SwiftPMBuilder) {
    self.swiftPMBuilder = swiftPMBuilder
  }

  func run() throws {
    try swiftPMBuilder.buildTarget(packageDir: Paths.packageDir, targetName: "SwiftSyntax-all")
    try swiftPMBuilder.buildTarget(packageDir: Paths.examplesDir, targetName: "Examples-all")
    try swiftPMBuilder.buildTarget(packageDir: Paths.swiftParserCliDir, targetName: "swift-parser-cli")
    try buildEditorExtension()
  }

  private func buildEditorExtension() throws {
    #if os(macOS)
    logSection("Building Editor Extension")
    try invokeXcodeBuild(projectPath: Paths.editorExtensionProjectPath, scheme: "SwiftRefactorExtension")
    #endif
  }

  @discardableResult
  private func invokeXcodeBuild(projectPath: URL, scheme: String) throws -> ProcessResult {
    try withTemporaryDirectory { tempDir in
      let processRunner = ProcessRunner(
        executableURL: try Paths.xcodebuildExec,
        arguments: [
          "-project", projectPath.path,
          "-scheme", scheme,
          "-derivedDataPath", tempDir.path,
        ],
        additionalEnvironment: [:]
      )

      let result = try processRunner.run(verbose: swiftPMBuilder.verbose)

      return result
    }
  }
}
