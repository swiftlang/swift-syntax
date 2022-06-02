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
    extendedType: "TokenSyntax",
    modifiersBuilder: {
      TokenSyntax.public.withLeadingTrivia(.newlines(1) + .docLineComment("/// Namespace for commonly used tokens with default trivia.") + .newlines(1))
    },
    membersBuilder: {
      for token in SYNTAX_TOKENS {
        if token.isKeyword {
          VariableDecl(
            letOrVarKeyword: .var,
            modifiersBuilder: {
              if let text = token.text {
                TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `\(text)` keyword") + .newlines(1))
              } else {
                TokenSyntax.static
              }
            },
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
        } else if token.text != nil {
          VariableDecl(
            letOrVarKeyword: .var,
            modifiersBuilder: {
              if let text = token.text {
                TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `\(text)` token") + .newlines(1))
              } else {
                TokenSyntax.static
              }
            },
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
            identifier: .identifier("`\(token.name.withFirstCharacterLowercased)`"),
            signature: signature,
            modifiersBuilder: {
              if let text = token.text {
                TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `\(text)` token"))
              } else {
                TokenSyntax.static
              }
            },
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
        letOrVarKeyword: .var,
        modifiersBuilder: { TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `eof` token") + .newlines(1)) },
        bindingsBuilder: {
          // We need to use `CodeBlock` here to ensure there is braces around.
          let body = CodeBlock {
            FunctionCallExpr(
              MemberAccessExpr(base: "SyntaxFactory", name: "makeToken"),
              argumentListBuilder: {
                TupleExprElement(expression: MemberAccessExpr(name: "eof"))
                TupleExprElement(label: TokenSyntax.identifier("presence"), colon: .colon, expression: MemberAccessExpr(name: "present"))
              }
            )
          }

          createTokenSyntaxPatternBinding("eof", accessor: body)
        }
      )
      VariableDecl(
        letOrVarKeyword: .var,
        modifiersBuilder: { TokenSyntax.static.withLeadingTrivia(.newlines(1) + .docLineComment("/// The `open` contextual token") + .newlines(1)) },
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
