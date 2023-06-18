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

import SwiftSyntax
import SwiftParser
import Foundation

extension Parser {
  public static func parse(_ url: URL) throws -> SourceFileSyntax {
    let source = try String(contentsOf: url)
    return Self.parse(source: source)
  }
}

/// Print the given message to stderr
func printerr(_ message: String, terminator: String = "\n") {
  FileHandle.standardError.write((message + terminator).data(using: .utf8)!)
}

/// Print the help message
func printHelp() {
  print(
    """
    Utility to test SwiftSyntax syntax tree creation.

    Actions (must specify one):
      -classify-syntax
            Parse the given source file (-source-file) and output it with
            tokens classified for syntax colouring.
      -roundtrip
            Parse the given source file (-source-file) and print it out using
            its syntax tree.
      -print-tree
            Parse the given source file (-source-file) and output its syntax
            tree.
      -help
            Print this help message

    Arguments:
      -source-file FILENAME
            The path to a Swift source file to parse
      -out FILENAME
            The file to which the source representation of the post-edit syntax
            tree shall be written.
      -swift-version
            Interpret input according to a specific Swift language version
            number
      -enable-bare-slash-regex [0|1]
            Enable or disable the use of forward slash regular-expression
            literal syntax
    """
  )
}

/// Rewrites a parsed tree with all constructed nodes.
class TreeReconstructor: SyntaxRewriter {
  override func visit(_ token: TokenSyntax) -> TokenSyntax {
    let token = TokenSyntax(
      token.tokenKind,
      leadingTrivia: token.leadingTrivia,
      trailingTrivia: token.trailingTrivia,
      presence: token.presence
    )
    return token
  }
}

func performClassifySyntax(args: CommandLineArguments) throws {
  let treeURL = URL(fileURLWithPath: try args.getRequired("-source-file"))

  let tree = try Parser.parse(treeURL)
  let result = ClassifiedSyntaxTreePrinter.print(Syntax(tree))
  do {
    // Sanity check that we get the same result if the tree has constructed nodes.
    let ctorTree = TreeReconstructor().visit(tree)
    let ctorResult = ClassifiedSyntaxTreePrinter.print(Syntax(ctorTree))
    if ctorResult != result {
      throw TestingError.classificationVerificationFailed(result, ctorResult)
    }
  }

  if let outURL = args["-out"].map(URL.init(fileURLWithPath:)) {
    try result.write(to: outURL, atomically: false, encoding: .utf8)
  } else {
    print(result)
  }
}

enum TestingError: Error, CustomStringConvertible {
  case classificationVerificationFailed(String, String)
  case readingSourceFileFailed(URL)
  case roundTripFailed

  public var description: String {
    switch self {
    case .classificationVerificationFailed(let parsed, let constructed):
      return """
        parsed vs constructed tree resulted in different classification output
        --- PARSED:
        \(parsed)
        --- CONSTRUCTED:
        \(constructed)
        """
    case .readingSourceFileFailed(let url):
      return "Reading the source file at \(url) failed"
    case .roundTripFailed:
      return "Round-tripping the source file failed"
    }
  }
}

func performRoundtrip(args: CommandLineArguments) throws {
  let sourceURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  let tree = try Parser.parse(sourceURL)
  let treeText = tree.description

  if let outURL = args["-out"].map(URL.init(fileURLWithPath:)) {
    try treeText.write(to: outURL, atomically: false, encoding: .utf8)
  } else {
    print(treeText)
  }
}

class NodePrinter: SyntaxAnyVisitor {
  init() {
    super.init(viewMode: .sourceAccurate)
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    print("<\(type(of: node.asProtocol(SyntaxProtocol.self)))>", terminator: "")
    return .visitChildren
  }
  override func visitAnyPost(_ node: Syntax) {
    print("</\(type(of: node.asProtocol(SyntaxProtocol.self)))>", terminator: "")
  }
  override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    print("<\(type(of: token))>", terminator: "")
    print(token, terminator: "")
    return .visitChildren
  }
}

func printSyntaxTree(args: CommandLineArguments) throws {
  let treeURL = URL(fileURLWithPath: try args.getRequired("-source-file"))
  let tree = try Parser.parse(treeURL)
  let printer = NodePrinter()
  printer.walk(tree)
}

/// Write the given string to stderr **without** appending a newline character.
func writeToStderr(_ msg: String) {
  FileHandle.standardError.write(msg.data(using: .utf8)!)
}

do {
  let args = try CommandLineArguments.parse(CommandLine.arguments.dropFirst())

  if args.has("-classify-syntax") {
    try performClassifySyntax(args: args)
  } else if args.has("-roundtrip") {
    try performRoundtrip(args: args)
  } else if args.has("-print-tree") {
    try printSyntaxTree(args: args)
  } else if args.has("-help") {
    printHelp()
  } else {
    printerr(
      """
      No action specified.
      See -help for information about available actions
      """
    )
    exit(1)
  }
  exit(0)
} catch let error as TestingError {
  printerr("\(error)")
  exit(1)
} catch {
  printerr("\(error)")
  printerr("Run lit-test-helper -help for more help.")
  exit(1)
}
