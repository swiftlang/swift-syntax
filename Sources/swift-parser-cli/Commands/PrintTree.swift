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
import SwiftParser
import SwiftSyntax

struct PrintTree: ParsableCommand, ParseCommand {
  static var configuration = CommandConfiguration(
    commandName: "print-tree",
    abstract: "Print the syntax tree produced by parsing a source file"
  )

  @OptionGroup
  var arguments: ParseArguments

  @Flag(name: .long, help: "Include trivia in the output")
  var includeTrivia: Bool = false

  func run() throws {
    try sourceFileContents.withUnsafeBufferPointer { sourceBuffer in
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
