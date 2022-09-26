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
import SyntaxSupport
import Utils

let tokenFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )
  ImportDecl(
    path: "SwiftBasicFormat"
  )

  let tokenType = SyntaxBuildableType(syntaxKind: "Token")
  let conformances = ["SyntaxBuildable"] + tokenType.convertibleToTypes.map(\.expressibleAsBaseName)
  + tokenType.elementInCollections.map(\.expressibleAsBaseName)


  StructDecl(
    leadingTrivia: .newline +
      .docLineComment("""
      /// Represents `TokenSyntax` in `SwiftSyntaxBuilder`.
      /// At the moment, this just wraps `TokenSyntax`, but we can make it store just the information necessary to build a `TokenSyntax` in the future.
      """) +
      .newline,
    modifiers: [Token.public],
    identifier: "Token",
    inheritanceClause: createTypeInheritanceClause(conformances: conformances)
  ) {
    VariableDecl(.let, name: "tokenSyntax", type: "TokenSyntax")
    VariableDecl(.let, name: "leadingTrivia", type: OptionalType(wrappedType: "Trivia"))
    VariableDecl(.let, name: "trailingTrivia", type: OptionalType(wrappedType: "Trivia"))

    VariableDecl(
      leadingTrivia: .newline,
      letOrVarKeyword: .var
    ) {
      PatternBinding(pattern: "text",
                     typeAnnotation: "String",
                     accessor: CodeBlock {
        MemberAccessExpr(base: "tokenSyntax", name: "text")
      })
    }

    InitializerDecl(
      leadingTrivia: .newline,
      modifiers: [Token.public],
      signature: FunctionSignature(
        input: ParameterClause() {
          FunctionParameter(
            firstName: .identifier("tokenSyntax"),
            colon: .colon,
            type: "TokenSyntax"
          )
          FunctionParameter(
            firstName: .identifier("leadingTrivia"),
            colon: .colon,
            type: OptionalType(wrappedType: "Trivia"),
            defaultArgument: InitializerClause(value: NilLiteralExpr())
          )
          FunctionParameter(
            firstName: .identifier("trailingTrivia"),
            colon: .colon,
            type: OptionalType(wrappedType: "Trivia"),
            defaultArgument: InitializerClause(value: NilLiteralExpr())
          )
        }
      )
    ) {
      for member in ["tokenSyntax", "leadingTrivia", "trailingTrivia"] {
        SequenceExpr {
          MemberAccessExpr(base: "self", name: member)
          AssignmentExpr()
          member
        }
      }
    }

    for leadingTrailing in ["Leading", "Trailing"] {
      FunctionDecl(
        leadingTrivia: .newline,
        modifiers: [Token.public],
        identifier: .identifier("with\(leadingTrailing)Trivia"),
        signature: FunctionSignature(
          input: ParameterClause {
            FunctionParameter(
              firstName: .wildcard,
              secondName: .identifier("\(lowercaseFirstWord(name: leadingTrailing))Trivia"),
              colon: .colon,
              type: "Trivia"
            )
          },
          output: "Token"
        )
      ) {
        FunctionCallExpr("Token") {
          for arg in ["tokenSyntax", "leadingTrivia", "trailingTrivia"] {
            TupleExprElement(
              label: arg,
              expression: arg
            )
          }
        }
      }
    }

    FunctionDecl(
      leadingTrivia: .newline,
      modifiers: [Token.public],
      identifier: .identifier("buildToken"),
      signature: FunctionSignature(
        input: ParameterClause {
          FunctionParameter(
            firstName: .identifier("format"),
            colon: .colon,
            type: "Format"
          )
        },
        output: "TokenSyntax"
      )
    ) {
      VariableDecl(.var, name: "result", initializer: FunctionCallExpr(MemberAccessExpr(base: "format", name: "format")) {
        TupleExprElement(label: "syntax", expression: IdentifierExpr("tokenSyntax"))
      })
      for leadingTrailing in ["Leading", "Trailing"] {
        let varName = "\(lowercaseFirstWord(name: leadingTrailing))Trivia"
        IfStmt(conditions: OptionalBindingCondition(letOrVarKeyword: .let, pattern: IdentifierPattern(varName), initializer: InitializerClause(value: varName))) {
          SequenceExpr {
            "result"
            AssignmentExpr()
            FunctionCallExpr(MemberAccessExpr(base: "result", name: "with\(leadingTrailing)Trivia")) {
              TupleExprElement(expression: varName)
            }
          }
        }
      }
      ReturnStmt(expression: "result")
    }

    FunctionDecl(
      leadingTrivia: .newline,
      modifiers: [Token.public],
      identifier: .identifier("buildSyntax"),
      signature: FunctionSignature(
        input: ParameterClause {
          FunctionParameter(
            firstName: .identifier("format"),
            colon: .colon,
            type: "Format"
          )
        },
        output: "Syntax"
      )
    ) {
      FunctionCallExpr("Syntax") {
        TupleExprElement(expression: FunctionCallExpr(MemberAccessExpr(base: IdentifierExpr(identifier: .`self`), name: "buildToken")) {
          TupleExprElement(label: "format", expression: "format")
        })
      }
    }

    for conformance in tokenType.elementInCollections {
      FunctionDecl(
        leadingTrivia: .newline + .docLineComment("/// Conformance to \(conformance.expressibleAsBaseName)") + .newline,
        modifiers: [Token.public],
        identifier: .identifier("create\(conformance.buildableBaseName)"),
        signature: FunctionSignature(
          input: ParameterClause(),
          output: conformance.buildableBaseName
        )
      ) {
        ReturnStmt(expression: FunctionCallExpr(conformance.buildableBaseName) {
          TupleExprElement(expression: ArrayExpr {
            ArrayElement(expression: "self")
          })
        })
      }
    }

    for conformance in tokenType.convertibleToTypes {
      let param = Node.from(type: conformance).singleNonDefaultedChild
      FunctionDecl(
        leadingTrivia: .newline + .docLineComment("/// Conformance to \(conformance.expressibleAsBaseName)") + .newline,
        modifiers: [Token.public],
        identifier: .identifier("create\(conformance.buildableBaseName)"),
        signature: FunctionSignature(
          input: ParameterClause(),
          output: conformance.buildableBaseName
        )
      ) {
        ReturnStmt(expression: FunctionCallExpr(conformance.buildableBaseName) {
          TupleExprElement(label: param.swiftName, expression: "self")
        })
      }
    }

    for buildable in ["SyntaxBuildable", "ExprBuildable"] {
      FunctionDecl(
        leadingTrivia: .newline + .docLineComment("/// `Token` conforms to `\(buildable)` via different paths, so we need to pick one default conversion path.") + .newline,
        modifiers: [Token.public],
        identifier: .identifier("create\(buildable)"),
        signature: FunctionSignature(
          input: ParameterClause(),
          output: buildable
        )
      ) {
        ReturnStmt(expression: FunctionCallExpr("createIdentifierExpr"))
      }
    }
  }

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
