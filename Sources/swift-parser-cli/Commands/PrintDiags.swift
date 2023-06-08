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
import SwiftDiagnostics
import SwiftParser
import SwiftParserDiagnostics

class PrintDiags: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "print-diags",
    abstract: "Print the diagnostics produced by parsing a soruce file"
  )

  required init() {}

  @Argument(help: "The source file that should be parsed; if omitted, use stdin")
  var sourceFile: String?

  @Flag(name: .long, help: "Perform sequence folding with the standard operators")
  var foldSequences: Bool = false

  @Flag(name: .long, help: "Force output coloring with ANSI color codes")
  var colorize: Bool = false

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    source.withUnsafeBufferPointer { sourceBuffer in
      let tree = Parser.parse(source: sourceBuffer)
      var diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
      if foldSequences {
        diags += foldAllSequences(tree).1
      }

      var group = GroupedDiagnostics()
      group.addSourceFile(tree: tree, displayName: sourceFile ?? "stdin", diagnostics: diags)
      let annotatedSource = DiagnosticsFormatter.annotateSources(
        in: group,
        colorize: colorize || TerminalHelper.isConnectedToTerminal
      )

      print(annotatedSource)

      if diags.isEmpty {
        print("No diagnostics produced")
      }
    }
  }
}
