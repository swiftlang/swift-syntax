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

struct PrintDiags: ParsableCommand, ParseCommand {
  static var configuration = CommandConfiguration(
    commandName: "print-diags",
    abstract: "Print the diagnostics produced by parsing a source file"
  )

  @OptionGroup
  var arguments: ParseArguments

  @Flag(name: .long, help: "Force output coloring with ANSI color codes")
  var colorize: Bool = false

  func run() throws {
    try sourceFileContents.withUnsafeBufferPointer { sourceBuffer in
      let tree = Parser.parse(source: sourceBuffer)
      var diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
      if foldSequences {
        diags += foldAllSequences(tree).1
      }

      var group = GroupedDiagnostics()
      group.addSourceFile(tree: tree, displayName: sourceFileName, diagnostics: diags)
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
