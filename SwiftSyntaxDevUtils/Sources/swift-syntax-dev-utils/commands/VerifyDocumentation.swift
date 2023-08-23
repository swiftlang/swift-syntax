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

struct VerifyDocumentation: ParsableCommand {
  static var configuration: CommandConfiguration {
    CommandConfiguration(
      abstract: "Verify that the docc documentation builds without warnings or errors."
    )
  }

  @Flag(help: "Enable verbose logging.")
  var verbose: Bool = false

  func targetsInSwiftPackageIndexManifest() throws -> [String] {
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
    for target in try targetsInSwiftPackageIndexManifest() {
      try buildDocumentation(product: target)
    }
  }

  func buildDocumentation(product: String) throws {
    guard let xcodebuildExec = try? Paths.xcodebuildExec else {
      return
    }
    logSection("Building documentation for \(product)")
    try ProcessRunner(
      executableURL: xcodebuildExec,
      arguments: [
        "docbuild",
        "-workspace",
        Paths.packageDir.path,
        "-scheme",
        product,
        "-destination", "platform=macOS",
        "OTHER_DOCC_FLAGS='--warnings-as-errors'",
      ]
    ).run(captureStdout: false, captureStderr: false, verbose: self.verbose)
  }
}
