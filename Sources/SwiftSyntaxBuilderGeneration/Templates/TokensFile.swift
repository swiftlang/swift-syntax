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
  ImportDecl(importTok: TokenSyntax.import.withLeadingTrivia(.docLineComment(copyrightHeader)), path: "SwiftSyntax")

  ExtensionDecl(
    modifiers: ModifierList([TokenSyntax.public.withLeadingTrivia(.newlines(1) + .docLineComment("/// Namespace for commonly used tokens with default trivia.") + .newlines(1))]),
    extendedType: "TokenSyntax",
    membersBuilder: {
      for token in SYNTAX_TOKENS {
        if token.isKeyword {
          VariableDecl(
            modifiers: ModifierList([token.text.map { TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `\($0)` keyword") + .newlines(1)) } ?? TokenSyntax.static]),
            .var,
            bindingsBuilder: {
              // We need to use `CodeBlock` here to ensure there is braces around.

              let accessor = CodeBlock {
                FunctionCallExpr(MemberAccessExpr(base: "SyntaxFactory", name: "make\(token.name)Keyword"))

                if token.requiresLeadingSpace {
                  createWithLeadingTriviaCall()
                }

                if token.requiresTrailingSpace {
                  createWithTrailingTriviaCall()
                }
              }

              createTokenSyntaxPatternBinding("`\(token.name.withFirstCharacterLowercased)`", accessor: accessor)
            }
          )
        } else if let text = token.text {
          VariableDecl(
            modifiers: ModifierList([TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `\(text)` token") + .newlines(1))]),
            .var,
            bindingsBuilder: {
              // We need to use `CodeBlock` here to ensure there is braces around.
              let accessor = CodeBlock {
                FunctionCallExpr(MemberAccessExpr(base: "SyntaxFactory", name: "make\(token.name)Token"))

                if token.requiresLeadingSpace {
                  createWithLeadingTriviaCall()
                }

                if token.requiresTrailingSpace {
                  createWithTrailingTriviaCall()
                }
              }

              createTokenSyntaxPatternBinding("`\(token.name.withFirstCharacterLowercased)`", accessor: accessor)
            }
          )
        } else {
          let signature = FunctionSignature(
            input: ParameterClause(
              parameterList: FunctionParameter(
                attributes: nil,
                firstName: .wildcard,
                secondName: .identifier("text"),
                colon: .colon,
                type: "String"
              ),
              rightParen: .rightParen.withTrailingTrivia(.spaces(1))
            ),
            output: "TokenSyntax"
          )

          FunctionDecl(
            modifiers: ModifierList([TokenSyntax.static]),
            identifier: .identifier("`\(token.name.withFirstCharacterLowercased)`"),
            signature: signature,
            bodyBuilder: {
              FunctionCallExpr(
                MemberAccessExpr(base: "SyntaxFactory", name: "make\(token.name)"),
                argumentListBuilder: {
                  TupleExprElement(expression: IdentifierExpr("text"))
                }
              )

              if token.requiresLeadingSpace {
                createWithLeadingTriviaCall()
              }

              if token.requiresTrailingSpace {
                createWithTrailingTriviaCall()
              }
            }
          )
        }
      }
      VariableDecl(
        modifiers: ModifierList([TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `eof` token") + .newlines(1))]),
        .var,
        bindingsBuilder: {
          // We need to use `CodeBlock` here to ensure there is braces around.
          let body = CodeBlock {
            FunctionCallExpr(
              MemberAccessExpr(base: "SyntaxFactory", name: "makeToken"),
              argumentListBuilder: {
                TupleExprElement(expression: MemberAccessExpr(name: "eof"), trailingComma: .comma)
                TupleExprElement(label: TokenSyntax.identifier("presence"), colon: .colon, expression: MemberAccessExpr(name: "present"))
              }
            )
          }

          createTokenSyntaxPatternBinding("eof", accessor: body)
        }
      )
      VariableDecl(
        modifiers: ModifierList([TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `open` contextual token") + .newlines(1))]),
        .var,
        bindingsBuilder: {
          // We need to use `CodeBlock` here to ensure there is braces around.
          let body = CodeBlock {
            FunctionCallExpr(
              MemberAccessExpr(base: "SyntaxFactory", name: "makeContextualKeyword"),
              argumentListBuilder: {
                TupleExprElement(expression: StringLiteralExpr("open"))
              }
            )

            createWithTrailingTriviaCall()
          }

          createTokenSyntaxPatternBinding("open", accessor: body)
        }
      )
    }
  )
}
