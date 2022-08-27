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
}
