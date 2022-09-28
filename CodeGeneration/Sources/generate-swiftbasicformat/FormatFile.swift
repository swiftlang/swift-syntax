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

let formatFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  StructDecl(modifiers: [Token.public], identifier: "Format") {
    VariableDecl(
      modifiers: [Token.public],
      .let,
      name: "indentWidth",
      type: "Int"
    )

    VariableDecl(
      modifiers: [Token.private],
      .var,
      name: "indents",
      type: "Int",
      initializer: IntegerLiteralExpr(0)
    )

    InitializerDecl(
      modifiers: [Token.public],
      signature: FunctionSignature(
        input: ParameterClause {
          FunctionParameter(
            firstName: .identifier("indentWidth"),
            colon: .colon,
            type: "Int",
            defaultArgument: IntegerLiteralExpr(4)
          )
        }
      )
    ) {
      SequenceExpr {
        MemberAccessExpr(base: "self", name: "indentWidth")
        AssignmentExpr()
        "indentWidth"
      }
    }
  }

  ExtensionDecl(extendedType: "Format") {
    VariableDecl(
      modifiers: [Token.public],
      name: "_indented",
      type: "Self"
    ) {
      VariableDecl(.var, name: "copy", initializer: "self")
      SequenceExpr {
        MemberAccessExpr(base: "copy", name: "indents")
        BinaryOperatorExpr("+=")
        IntegerLiteralExpr(1)
      }
      ReturnStmt(expression: "copy")
    }

    VariableDecl(
      modifiers: [Token.public],
      name: "indentTrivia",
      type: "Trivia"
    ) {
      TernaryExpr(
        if: SequenceExpr {
          "indents"
          BinaryOperatorExpr("==")
          IntegerLiteralExpr(0)
        },
        then: MemberAccessExpr(name: "zero"),
        else: FunctionCallExpr(MemberAccessExpr(name: "spaces")) {
          TupleExprElement(expression: SequenceExpr {
            "indents"
            BinaryOperatorExpr("*")
            "indentWidth"
          })
        }
      )
    }

    VariableDecl(
      modifiers: [Token.private],
      name: "indentedNewline",
      type: "Trivia"
    ) {
      SequenceExpr {
        MemberAccessExpr(name: "newline")
        BinaryOperatorExpr("+")
        "indentTrivia"
      }
    }
  }

  ExtensionDecl(extendedType: "Format") {
    for node in SYNTAX_NODES {
      if node.isBuildable {
        createBuildableNodeFormatFunction(node: node)
      } else if node.isSyntaxCollection {
        createBuildableCollectionNodeFormatFunction(node: node)
      }
    }
    createTokenFormatFunction()
  }
}

private func createFormatFunctionSignature(type: SyntaxBuildableType) -> FunctionSignature {
  FunctionSignature(
    input: ParameterClause {
      FunctionParameter(
        firstName: .identifier("syntax"),
        colon: .colon,
        type: type.syntaxBaseName
      )
    },
    output: type.syntaxBaseName
  )
}

/// Generate the format implementation for a buildable node.
private func createBuildableNodeFormatFunction(node: Node) -> FunctionDecl {
  FunctionDecl(
    modifiers: Token.public,
    identifier: .identifier("format"),
    signature: createFormatFunctionSignature(type: node.type)
  ) {
    VariableDecl(
      .var,
      name: "result",
      initializer: node.children
        .filter(\.requiresLeadingNewline)
        .reduce("syntax") { base, child in
          FunctionCallExpr(MemberAccessExpr(base: base, name: "with\(child.name)")) {
            let childExpr = MemberAccessExpr(base: "syntax", name: child.swiftName)
            TupleExprElement(expression: FunctionCallExpr(MemberAccessExpr(base: childExpr, name: "withLeadingTrivia")) {
              TupleExprElement(expression: SequenceExpr {
                "indentedNewline"
                BinaryOperatorExpr("+")
                TupleExpr {
                  SequenceExpr {
                    MemberAccessExpr(base: childExpr, name: "leadingTrivia")
                    BinaryOperatorExpr("??")
                    ArrayExpr()
                  }
                }
              })
            })
          }
      }
    )
    VariableDecl(
      .let,
      name: "leadingTrivia",
      initializer: SequenceExpr {
        MemberAccessExpr(base: "result", name: "leadingTrivia")
        BinaryOperatorExpr("??")
        ArrayExpr()
      }
    )
    IfStmt(conditions: ExprList {
      PrefixOperatorExpr("!", MemberAccessExpr(base: "leadingTrivia", name: "isEmpty"))
    }) {
      SequenceExpr {
        "result"
        AssignmentExpr()
        FunctionCallExpr(MemberAccessExpr(base: "result", name: "withLeadingTrivia")) {
          TupleExprElement(expression: FunctionCallExpr(MemberAccessExpr(base: "leadingTrivia", name: "addingSpacingAfterNewlinesIfNeeded")))
        }
      }
    }
    ReturnStmt(expression: "result")
  }
}

/// Generate the format implementation for a collection node.
/// The implementation updates the leading trivia of the elements with their indentation.
private func createBuildableCollectionNodeFormatFunction(node: Node) -> FunctionDecl {
  FunctionDecl(
    modifiers: Token.public,
    identifier: .identifier("format"),
    signature: createFormatFunctionSignature(type: node.type)
  ) {
    if node.elementsSeparatedByNewline {
      FunctionCallExpr(node.type.syntaxBaseName) {
        TupleExprElement(expression: FunctionCallExpr(
          MemberAccessExpr(base: "syntax", name: "map"),
          trailingClosure: ClosureExpr {
            FunctionCallExpr(MemberAccessExpr(base: "$0", name: "withLeadingTrivia")) {
              TupleExprElement(expression: FunctionCallExpr(MemberAccessExpr(
                base: TupleExpr {
                  SequenceExpr {
                    "indentedNewline"
                    BinaryOperatorExpr("+")
                    TupleExpr {
                      SequenceExpr {
                        MemberAccessExpr(base: "$0", name: "leadingTrivia")
                        BinaryOperatorExpr("??")
                        ArrayExpr()
                      }
                    }
                  }
                },
                name: "addingSpacingAfterNewlinesIfNeeded"
              )))
            }
          }
        ))
      }
    } else {
      "syntax"
    }
  }
}

private func createTokenFormatFunction() -> FunctionDecl {
  let tokenType = SyntaxBuildableType(syntaxKind: "Token")
  return FunctionDecl(
    modifiers: Token.public,
    identifier: .identifier("format"),
    signature: createFormatFunctionSignature(type: tokenType)
  ) {
    SwitchStmt(expression: MemberAccessExpr(base: "syntax", name: "tokenKind")) {
      for token in SYNTAX_TOKENS {
        SwitchCase(label: SwitchCaseLabel(caseItems: CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: token.swiftKind))))) {
          createWithLeadingWithTrailingTriviaCall(token: token)
        }
      }
      SwitchCase(label: SwitchCaseLabel(caseItems: CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: "eof"))))) {
        ReturnStmt(expression: "syntax")
      }
    }
  }
}

private func createWithLeadingWithTrailingTriviaCall(token: TokenSpec) -> CodeBlockItem {
  var res: ExprBuildable = IdentifierExpr("syntax")
  if token.requiresLeadingSpace {
    res = FunctionCallExpr(MemberAccessExpr(base: res, name: "withLeadingTrivia")) {
      TupleExprElement(expression: MemberAccessExpr(name: "space"))
    }
  }
  if token.requiresTrailingSpace {
    res = FunctionCallExpr(MemberAccessExpr(base: res, name: "withTrailingTrivia")) {
      TupleExprElement(expression: MemberAccessExpr(name: "space"))
    }
  }
  return CodeBlockItem(item: ReturnStmt(expression: res))
}
