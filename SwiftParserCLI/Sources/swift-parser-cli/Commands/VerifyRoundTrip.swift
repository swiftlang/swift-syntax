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
import SwiftSyntax

struct VerifyRoundTrip: ParsableCommand, ParseCommand {
  static var configuration = CommandConfiguration(
    commandName: "verify-round-trip",
    abstract: "Verify that printing the parsed syntax tree produces the original source"
  )

  init() {}

  init(sourceFile: String?) {
    self.arguments.sourceFile = sourceFile
  }

  @OptionGroup
  var arguments: ParseArguments

  enum Error: Swift.Error, CustomStringConvertible {
    case roundTripFailed

    public var description: String {
      switch self {
      case .roundTripFailed:
        return "Round-tripping the source file failed"
      }
    }
  }

  func run() throws {
    try sourceFileContents.withUnsafeBufferPointer { sourceBuffer in
      try Self.run(
        source: sourceBuffer,
        foldSequences: foldSequences
      )
    }
  }

  static func run(
    source: UnsafeBufferPointer<UInt8>,
    foldSequences: Bool
  ) throws {
    let tree = Parser.parse(source: source)

    var diags = ParseDiagnosticsGenerator.diagnostics(for: tree)

    let resultTree: Syntax
    if foldSequences {
      let folded = foldAllSequences(tree)
      resultTree = folded.0
      diags += folded.1
    } else {
      resultTree = Syntax(tree)
    }

    _ = DiagnosticsFormatter.annotatedSource(tree: tree, diags: diags)

    if resultTree.syntaxTextBytes != [UInt8](source) {
      throw Error.roundTripFailed
    }
  }
}
