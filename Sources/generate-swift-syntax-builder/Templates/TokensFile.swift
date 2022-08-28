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
    modifiers: [Token.public],
    extendedType: "Token"
  ) {
    for token in SYNTAX_TOKENS {
      if token.isKeyword {
        VariableDecl(
          leadingTrivia: token.text.map { .newline + .docLineComment("/// The `\($0)` keyword") + .newline } ?? [],
          modifiers: [Token.static],
          letOrVarKeyword: .var
        ) {
          // We need to use `CodeBlock` here to ensure there is braces around.

          let accessor = CodeBlock {
            FunctionCallExpr("Token") {
              TupleExprElement(label: "tokenSyntax", expression: FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: token.swiftKind)))
            }
          }

          createTokenPatternBinding(token.name.withFirstCharacterLowercased.backticked, accessor: accessor)
        }
      } else if let text = token.text {
        VariableDecl(
          leadingTrivia: .newline + .docLineComment("/// The `\(text)` token") + .newline,
          modifiers: [Token.static],
          letOrVarKeyword: .var
        ) {
          // We need to use `CodeBlock` here to ensure there is braces around.
          let accessor = CodeBlock {
            FunctionCallExpr("Token") {
              TupleExprElement(label: "tokenSyntax", expression: FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: "\(token.swiftKind)Token")))
            }
          }

          createTokenPatternBinding(token.name.withFirstCharacterLowercased.backticked, accessor: accessor)
        }
      } else {
        let signature = FunctionSignature(
          input: ParameterClause {
            FunctionParameter(
              attributes: nil,
              firstName: .wildcard,
              secondName: .identifier("text"),
              colon: .colon,
              type: "String"
            )
          },
          output: "Token"
        )

        FunctionDecl(
          modifiers: [Token.static],
          identifier: .identifier(token.name.withFirstCharacterLowercased.backticked),
          signature: signature
        ) {
          FunctionCallExpr("Token") {
            TupleExprElement(
              label: "tokenSyntax",
              expression: FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: token.swiftKind)) {
                TupleExprElement(expression: "text")
              })
          }
        }
      }
    }
    VariableDecl(
      leadingTrivia: .newline + .docLineComment("/// The `eof` token") + .newline,
      modifiers: [Token.static],
      letOrVarKeyword: .var
    ) {
      // We need to use `CodeBlock` here to ensure there is braces around.
      let body = CodeBlock {
        FunctionCallExpr("Token") {
          TupleExprElement(label: "tokenSyntax", expression: FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: "eof")))
        }
      }

      createTokenPatternBinding("eof", accessor: body)
    }
    VariableDecl(
      leadingTrivia: .newline + .docLineComment("/// The `open` contextual token") + .newline,
      modifiers: [Token.static],
      letOrVarKeyword: .var
    ) {
      // We need to use `CodeBlock` here to ensure there is braces around.
      let body = CodeBlock {
        let tokenSyntax = FunctionCallExpr(MemberAccessExpr(base: "TokenSyntax", name: "contextualKeyword")) {
          TupleExprElement(expression: StringLiteralExpr("open"))
        }
        let tokenSyntaxWithTrailingTrivia = FunctionCallExpr(MemberAccessExpr(base: tokenSyntax, name: "withTrailingTrivia")) {
          TupleExprElement(expression: createSpacingCall())
        }
        FunctionCallExpr("Token") {
          TupleExprElement(label: "tokenSyntax", expression: tokenSyntaxWithTrailingTrivia)
        }
      }

      createTokenPatternBinding("open", accessor: body)
    }
  }
}
