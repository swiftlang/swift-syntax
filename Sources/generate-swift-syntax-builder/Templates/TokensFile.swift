//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

let tokensFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  ExtensionDecl(
    leadingTrivia: .newline + .docLineComment("/// Namespace for commonly used tokens with default trivia.") + .newline,
    modifiers: [TokenSyntax.public],
    extendedType: "TokenSyntax"
  ) {
    for token in SYNTAX_TOKENS {
      if token.isKeyword {
        VariableDecl(
          leadingTrivia: token.text.map { .newline + .docLineComment("/// The `\($0)` keyword") + .newline } ?? [],
          modifiers: [TokenSyntax.static],
          letOrVarKeyword: .var
        ) {
          // We need to use `CodeBlock` here to ensure there is braces around.

          let accessor = CodeBlock {
            FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: token.swiftKind))
          }

          createTokenSyntaxPatternBinding(token.name.withFirstCharacterLowercased.backticked, accessor: accessor)
        }
      } else if let text = token.text {
        VariableDecl(
          leadingTrivia: .newline + .docLineComment("/// The `\(text)` token") + .newline,
          modifiers: [TokenSyntax.static],
          letOrVarKeyword: .var
        ) {
          // We need to use `CodeBlock` here to ensure there is braces around.
          let accessor = CodeBlock {
            FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: "\(token.swiftKind)Token"))
          }

          createTokenSyntaxPatternBinding(token.name.withFirstCharacterLowercased.backticked, accessor: accessor)
        }
      }
      // TokenSyntax with custom text already has a static constructor function defined in SwiftSyntax.
    }
    VariableDecl(
      leadingTrivia: .newline + .docLineComment("/// The `eof` token") + .newline,
      modifiers: [TokenSyntax.static],
      letOrVarKeyword: .var
    ) {
      // We need to use `CodeBlock` here to ensure there is braces around.
      let body = CodeBlock {
        FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: "eof")) {
        }
      }

      createTokenSyntaxPatternBinding("eof", accessor: body)
    }
    VariableDecl(
      leadingTrivia: .newline + .docLineComment("/// The `open` contextual token") + .newline,
      modifiers: [TokenSyntax.static],
      letOrVarKeyword: .var
    ) {
      // We need to use `CodeBlock` here to ensure there is braces around.
      let body = CodeBlock {
        FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: "contextualKeyword")) {
          TupleExprElement(expression: StringLiteralExpr("open"))
        }

        createWithTrailingTriviaCall()
      }

      createTokenSyntaxPatternBinding("open", accessor: body)
    }
  }
}
