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

fileprivate var modules: [String] {
  ["SwiftParser", "SwiftParserDiagnostics", "SwiftSyntax", "SwiftSyntaxBuilder"]
}

struct VerifySourceCode: ParsableCommand, SourceCodeGeneratorCommand {
  static var configuration: CommandConfiguration {
    return CommandConfiguration(
      abstract: "Verify that the generated sources match the ones checked into the repository."
    )
  }

  @OptionGroup
  var arguments: SourceCodeGeneratorArguments

  func run() throws {
    try withTemporaryDirectory(verifyCodeGeneratedFiles(tempDir:))
  }

  private func verifyCodeGeneratedFiles(tempDir: URL) throws {
    try self.runCodeGeneration(sourceDir: tempDir)

    logSection("Verifing code generated files")

    for module in modules {
      let selfGeneratedDir = tempDir.appendingPathComponent(module).appendingPathComponent("generated")
      let userGeneratedDir = Paths.sourcesDir.appendingPathComponent(module).appendingPathComponent("generated")

      let process = ProcessRunner(
        executableURL: try Paths.diffExec,
        arguments: [
          "--recursive",
          "--exclude",
          ".*",  // Exclude dot files like .DS_Store
          "--context=0",
          selfGeneratedDir.path,
          userGeneratedDir.path,
        ]
      )

      let result = try process.run(verbose: arguments.verbose)

      if !result.stderr.isEmpty {
        throw ScriptExectutionError(
          message: """
            FAIL: code-generated files committed to repository do
            not match generated ones. Please re-generate the
            code-generated-files using the following command, open a PR to the
            SwiftSyntax project and merge it alongside the main PR.
            $ swift run swift-syntax-dev-utils generate-source-code
            /path/to/toolchain.xctoolchain/usr
            """
        )
      }
    }
  }
}
