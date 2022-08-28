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
    FunctionDecl(
      modifiers: [Token.public],
      identifier: .identifier("_indented"),
      signature: FunctionSignature(
        input: ParameterClause(),
        output: "Format"
      )
    ) {
      VariableDecl(.var, name: "copy", initializer: "self")
      SequenceExpr {
        MemberAccessExpr(base: "copy", name: "indents")
        BinaryOperatorExpr("+=")
        IntegerLiteralExpr(1)
      }
      ReturnStmt(expression: "copy")
    }

    FunctionDecl(
      modifiers: [Token.public],
      identifier: .identifier("_makeIndent"),
      signature: FunctionSignature(
        input: ParameterClause(),
        output: "Trivia"
      )
    ) {
      // TODO: Use sugared TernaryExpr once https://github.com/apple/swift-syntax/pull/610 is merged
      ReturnStmt(expression: TernaryExpr(
        conditionExpression: SequenceExpr {
          "indents"
          BinaryOperatorExpr("==")
          IntegerLiteralExpr(0)
        },
        questionMark: SwiftSyntaxBuilder.Token.infixQuestionMark.withLeadingTrivia(.space).withTrailingTrivia(.space),
        firstChoice: MemberAccessExpr(name: "zero"),
        colonMark: .colon.withLeadingTrivia(.space).withTrailingTrivia(.space),
        secondChoice: FunctionCallExpr(MemberAccessExpr(base: "Trivia", name: "spaces")) {
          TupleExprElement(expression: SequenceExpr {
            "indents"
            BinaryOperatorExpr("*")
            "indentWidth"
          })
        }
      ))
    }
  }
}
