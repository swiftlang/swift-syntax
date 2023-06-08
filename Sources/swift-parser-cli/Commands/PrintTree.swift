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
import SwiftSyntax
import SwiftParser

class PrintTree: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "print-tree",
    abstract: "Print the syntax tree produced by parsing a source file"
  )

  required init() {}

  @Argument(help: "The source file that should be parsed; if omitted, use stdin")
  var sourceFile: String?

  @Flag(name: .long, help: "Perform sequence folding with the standard operators")
  var foldSequences: Bool = false

  @Flag(name: .long, help: "Include trivia in the output")
  var includeTrivia: Bool = false

  func run() throws {
    let source = try getContentsOfSourceFile(at: sourceFile)

    source.withUnsafeBufferPointer { sourceBuffer in
      let tree = Parser.parse(source: sourceBuffer)

      let resultTree: Syntax
      if foldSequences {
        resultTree = foldAllSequences(tree).0
      } else {
        resultTree = Syntax(tree)
      }

      print(resultTree.debugDescription(includeTrivia: includeTrivia))
    }
  }
}
