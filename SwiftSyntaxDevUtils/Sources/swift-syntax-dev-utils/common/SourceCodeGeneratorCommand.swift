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
import Dispatch
import Foundation

protocol SourceCodeGeneratorCommand {
  var arguments: SourceCodeGeneratorArguments { get }
}

extension SourceCodeGeneratorCommand {
  func runCodeGeneration(sourceDir: URL) throws {
    logSection("Running code generation")

    var args = [
      "run",
      "--package-path", Paths.codeGenerationDir.relativePath,
      "generate-swift-syntax", sourceDir.relativePath,
    ]

    if arguments.verbose {
      args += ["--verbose"]
    }

    let additionalEnvironment = [
      "SWIFT_BUILD_SCRIPT_ENVIRONMENT": "1",
      "SWIFTSYNTAX_ENABLE_RAWSYNTAX_VALIDATION": "1",
      "SWIFTCI_USE_LOCAL_DEPS": nil,
    ]

    let process = ProcessRunner(
      executableURL: arguments.toolchain.appendingPathComponent("bin").appendingPathComponent("swift"),
      arguments: args,
      additionalEnvironment: additionalEnvironment
    )

    try process.run(verbose: arguments.verbose)
  }
}
