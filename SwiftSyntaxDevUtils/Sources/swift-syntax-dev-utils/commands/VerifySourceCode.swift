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
import RegexBuilder

fileprivate let modules: [String] = [
  "SwiftParser",
  "SwiftParserDiagnostics",
  "SwiftSyntax",
  "SwiftSyntaxBuilder",
]

struct VerifySourceCode: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Verify that the generated sources match the ones checked into the repository."
  )

  @OptionGroup
  var arguments: SourceCodeGeneratorArguments

  func run() throws {
    try VerifySpiYmlExecutor().run()

    try VerifySourceCodeExecutor(
      toolchain: try arguments.toolchain,
      verbose: arguments.verbose
    ).run()
  }
}

struct VerifySourceCodeExecutor {
  /// The path to the toolchain that shall be used to build SwiftSyntax.
  private let toolchain: URL

  /// Enable verbose logging.
  private let verbose: Bool

  private let generateSourceCodeExecutor: GenerateSourceCodeExecutor

  /// Creates an executor
  /// - Parameters:
  ///   - toolchain: The path to the toolchain that shall be used to build SwiftSyntax.
  ///   - verbose: Enable verbose logging.
  init(toolchain: URL, verbose: Bool = false) {
    self.toolchain = toolchain
    self.verbose = verbose
    self.generateSourceCodeExecutor = GenerateSourceCodeExecutor(
      toolchain: toolchain,
      verbose: verbose
    )
  }

  func run() throws {
    try withTemporaryDirectory(verifyCodeGeneratedFiles(tempDir:))
  }

  private func verifyCodeGeneratedFiles(tempDir: URL) throws {
    try generateSourceCodeExecutor.run(sourceDir: tempDir)

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

      let result = try process.run(verbose: verbose)

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

struct VerifySpiYmlExecutor {
  static let configuration = CommandConfiguration(
    abstract: "Verify that the .spi.yml file contains all libraries from Package.swift"
  )

  /// Returns all libraries declared in `Package.swift`.
  ///
  /// Note: It would be nice if we could compile Package.swift with this file and reallly
  /// inspect the package targets instead of doing regex scraping, but this is good enough
  /// for now.
  private func librariesInPackageManifest() throws -> [String] {
    let extractNameRegex = Regex {
      #/^.*/#
      #".library(name: ""#
      Capture(ZeroOrMore(.word))
      #"""#
      #/.*$/#
    }
    let packageFile = Paths.packageDir.appendingPathComponent("Package.swift")
    let packageFileContents = try String(contentsOf: packageFile)
    return
      packageFileContents
      .components(separatedBy: "\n")
      .filter({ !$0.matches(of: extractNameRegex).isEmpty })
      .map { $0.replacing(extractNameRegex) { $0.1 } }
      .filter({ !$0.hasPrefix("_") })
      .sorted()
  }
  /// Returns all targets listed in `.spi.yml`.
  ///
  /// Note: It would be nice to actually parse the .yml file but then we would need to add
  /// a dependency from this script on a YAML parser and that just doesn’t seem worth it.
  private func targetsInSwiftPackageIndexManifest() throws -> [String] {
    let extractTargetRegex = Regex {
      #/^      - /#
      Capture(ZeroOrMore(.word))
      #/$/#
    }
    let spiYmlFile = Paths.packageDir.appendingPathComponent(".spi.yml")
    let spiYmlFileContents = try String(contentsOf: spiYmlFile)
    return
      spiYmlFileContents
      .components(separatedBy: "\n")
      .filter({ !$0.matches(of: extractTargetRegex).isEmpty })
      .map { $0.replacing(extractTargetRegex) { $0.1 } }
      .sorted()
  }

  func run() throws {
    logSection("Verifing that .spi.yml is up-to-date")

    let difference = try targetsInSwiftPackageIndexManifest().difference(from: librariesInPackageManifest())

    if !difference.isEmpty {
      let differenceDescription = difference.map { change in
        switch change {
        case .insert(_, let element, _):
          return " - Unexpected in .spi.yml: \(element)"
        case .remove(_, let element, _):
          return " - Missing in .spi.yml: \(element)"
        }
      }.joined(separator: "\n")
      throw ScriptExectutionError(
        message: """
          .spi.yml did not contain the same libraries as Package.swift:
          \(differenceDescription)
          """
      )
    }
  }
}
