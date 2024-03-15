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
import SwiftBasicFormat
import SwiftDiagnostics
import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax

struct BasicFormat: ParsableCommand, ParseCommand {
  enum Error: Swift.Error, CustomStringConvertible {
    case unknownSyntaxNodeType(nodeType: String, parsableTypes: [String])

    var description: String {
      switch self {
      case .unknownSyntaxNodeType(nodeType: let nodeType, parsableTypes: let parsableTypes):
        return """
          '\(nodeType)' is not a SwiftSyntax node type that conforms to SyntaxParsable. Possible options are:
          \(parsableTypes.map {" - \($0)" }.joined(separator: "\n"))
          """
      }
    }
  }

  static var configuration = CommandConfiguration(
    commandName: "basic-format",
    abstract: "Format a source file using BasicFormat"
  )

  @OptionGroup
  var arguments: ParseArguments

  @Option(help: "The number of spaces to use for indentation")
  var indentationWidth: Int = 4

  @Option(help: "The type that the node should be parsed as")
  var nodeType: String = "SourceFileSyntax"

  func run() throws {
    guard case .choices(let choices) = Syntax.structure else {
      fatalError("Expected `Syntax.structure` to be the `choices` case")
    }

    let parsableMetatypes = choices.compactMap { (choice) -> SyntaxParseable.Type? in
      guard case .node(let nodeType) = choice else {
        return nil
      }
      return nodeType as? SyntaxParseable.Type
    }
    let parsableMetatypesByName = Dictionary(
      parsableMetatypes.map {
        (String(reflecting: $0).replacingOccurrences(of: "SwiftSyntax.", with: ""), $0)
      },
      uniquingKeysWith: { l, r in l }
    )

    guard let parseType = parsableMetatypesByName[nodeType] else {
      throw Error.unknownSyntaxNodeType(nodeType: nodeType, parsableTypes: parsableMetatypesByName.keys.sorted())
    }

    let tree = try sourceFileContents.withUnsafeBufferPointer { sourceBuffer in
      var parser = Parser(sourceBuffer)
      return parseType.parse(from: &parser)
    }

    let resultTree: Syntax
    if foldSequences {
      resultTree = foldAllSequences(tree).0
    } else {
      resultTree = Syntax(tree)
    }

    if resultTree.hasError {
      let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
      printerr(
        """
        Source input contained syntax errors. Formatting might be incorrect due to these errors:
        \(DiagnosticsFormatter(colorize: TerminalHelper.isConnectedToTerminal).annotatedSource(tree: tree, diags: diags))
        ----------------------------------------
        """
      )
    }

    let formattedTree = resultTree.formatted(
      using: SwiftBasicFormat.BasicFormat(indentationWidth: .spaces(indentationWidth))
    )

    print(formattedTree.description)
  }
}
