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
import SwiftDiagnostics
import SwiftIfConfig
import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax

struct ParseArguments: ParsableArguments {
  @Argument(help: "The source file that should be parsed; if omitted, use stdin")
  var sourceFile: String?

  @Option(name: [.long, .short], help: "If passed, parse this source text instead of reading source file")
  var source: String?

  @Flag(name: .long, help: "Perform sequence folding with the standard operators")
  var foldSequences: Bool = false

  @Option(help: "Apply the given static build configuration to the source text before further processing")
  var buildConfiguration: String?
}

/// A command  that has arguments to parse source code
protocol ParseCommand {
  var arguments: ParseArguments { get }
}

extension ParseCommand {
  /// The name of the source file that can can be displayed to users
  ///
  /// This is not necessarily a file path if the file contents are read from
  /// stdin or the command line arguments.
  var sourceFileName: String {
    return arguments.sourceFile ?? "stdin"
  }

  /// The contents of the source that should be parsed in UTF-8 bytes.
  var sourceFileContents: [UInt8] {
    get throws {
      if let source = arguments.source {
        return Array(source.utf8)
      }

      return try getContentsOfSourceFile(at: arguments.sourceFile)
    }
  }

  /// Whether sequence folding using standard operators should be performed
  var foldSequences: Bool { arguments.foldSequences }

  /// Parse the source file, applying any additional configuration options
  /// such as sequence folding, and return it with diagnostics.
  func parsedSourceFile(
    wantDiagnostics: Bool = true
  ) throws -> (SourceFileSyntax, [Diagnostic]) {
    return try sourceFileContents.withUnsafeBufferPointer { sourceBuffer in
      // Parse the sources
      var tree = Parser.parse(source: sourceBuffer)

      // If we want diagnostics, gather them from the parser.
      var diags: [Diagnostic] = []
      if wantDiagnostics {
        diags += ParseDiagnosticsGenerator.diagnostics(for: tree)
      }

      // If we are supposed to fold sequences, do it now.
      if foldSequences {
        let (folded, foldDiags) = foldAllSequences(tree)

        tree = folded.cast(SourceFileSyntax.self)
        if wantDiagnostics {
          diags += foldDiags
        }
      }

      // If we are supposed to apply a build configuration, do it now.
      if let buildConfiguration = arguments.buildConfiguration {
        // Load the build configuration.
        let buildConfigurationText = try Data(contentsOf: URL(fileURLWithPath: buildConfiguration))
        let staticBuildConfiguration = try JSONDecoder().decode(
          StaticBuildConfiguration.self,
          from: buildConfigurationText
        )

        // Apply the build configuration.
        let (configured, configuredDiags) = tree.removingInactive(in: staticBuildConfiguration)

        tree = configured.cast(SourceFileSyntax.self)
        if wantDiagnostics {
          diags += configuredDiags
        }
      }

      return (tree, diags)
    }
  }
}
