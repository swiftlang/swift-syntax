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

#if swift(>=6)
import SwiftDiagnostics
import SwiftParserDiagnostics
public import SwiftSyntax
#else
import SwiftDiagnostics
import SwiftParserDiagnostics
import SwiftSyntax
#endif

extension SyntaxProtocol {
  /// If `node` has contains no syntax errors, return `node`, otherwise
  /// throw an error with diagnostics describing the syntax errors.
  ///
  /// This allows clients to e.g. write `try DeclSyntax(validating: "struct Foo {}")`
  /// which constructs a ``DeclSyntax`` that's guaranteed to be free of syntax
  /// errors.
  public init(validating node: Self) throws {
    if node.hasError {
      let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: node)
      precondition(!diagnostics.isEmpty)
      throw SyntaxStringInterpolationDiagnosticError(diagnostics: diagnostics, tree: Syntax(node))
    }
    self = node
  }
}

extension Trivia {
  /// If `trivia` contains no unexpected trivia, return `trivia`, otherwise
  /// throw an error with diagnostics describing the unexpected trivia.
  public init(validating trivia: Trivia) throws {
    self = trivia
    if pieces.contains(where: { $0.isUnexpected }) {
      var diagnostics: [Diagnostic] = []
      let tree = SourceFileSyntax(statements: [], endOfFileToken: .endOfFileToken(leadingTrivia: self))
      var offset = 0
      for piece in pieces {
        if case .unexpectedText(let contents) = piece {
          diagnostics.append(
            Diagnostic(
              node: Syntax(tree),
              position: tree.position.advanced(by: offset),
              message: UnexpectedTrivia(triviaContents: contents)
            )
          )
        }
        offset += piece.sourceLength.utf8Length
      }
      throw SyntaxStringInterpolationDiagnosticError(diagnostics: diagnostics, tree: Syntax(tree))
    }
  }
}
