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

let formatFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  StructDecl(modifiers: [TokenSyntax.public], identifier: "Format") {
    VariableDecl(
      modifiers: [TokenSyntax.public],
      .let,
      name: "indentWidth",
      type: "Int"
    )

    VariableDecl(
      modifiers: [TokenSyntax.private],
      .var,
      name: "indents",
      type: "Int",
      initializer: IntegerLiteralExpr(0)
    )

    InitializerDecl(
      modifiers: [TokenSyntax.public],
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
      modifiers: [TokenSyntax.public],
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
      modifiers: [TokenSyntax.public],
      name: "_indentTrivia",
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
      modifiers: [TokenSyntax.private],
      name: "indentedNewline",
      type: "Trivia"
    ) {
      SequenceExpr {
        MemberAccessExpr(name: "newline")
        BinaryOperatorExpr("+")
        "_indentTrivia"
      }
    }
  }

  ExtensionDecl(extendedType: "Format") {
    for node in SYNTAX_NODES {
      let type = node.type
      let signature = FunctionSignature(
        input: ParameterClause {
          FunctionParameter(
            firstName: .identifier("syntax"),
            colon: .colon,
            type: type.syntaxBaseName
          )
        },
        output: type.syntaxBaseName
      )
      if node.isBuildable {
        FunctionDecl(
          modifiers: [TokenSyntax.public],
          identifier: .identifier("_format"),
          signature: signature
        ) {
          node.children
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
        }
      } else if node.isSyntaxCollection {
        FunctionDecl(
          modifiers: [TokenSyntax.public],
          identifier: .identifier("_format"),
          signature: signature
        ) {
          if node.elementsSeparatedByNewline {
            FunctionCallExpr(type.syntaxBaseName) {
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
    }
  }
}
