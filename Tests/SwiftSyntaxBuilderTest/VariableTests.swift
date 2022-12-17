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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class VariableTests: XCTestCase {
  func testVariableDecl() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let buildable = VariableDecl(leadingTrivia: leadingTrivia, letOrVarKeyword: .let) {
      PatternBinding(pattern: PatternSyntax("a"), typeAnnotation: TypeAnnotation(type: ArrayType(elementType: Type("Int"))))
    }

    AssertBuildResult(buildable, "␣let a: [Int]")
  }

  func testVariableDeclWithTry() {
    let testCases: [UInt: (VariableDecl, String)] = [
      #line: (
        VariableDecl("let content = try? String(contentsOf: url)"),
        "let content = try? String(contentsOf: url)"
      ),
      #line: (
        VariableDecl("let content = try! String(contentsOf: url)"),
        "let content = try! String(contentsOf: url)"
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }

  func testVariableDeclWithValue() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let buildable = VariableDecl(leadingTrivia: leadingTrivia, letOrVarKeyword: .var) {
      PatternBinding(
        pattern: PatternSyntax("d"),
        typeAnnotation: TypeAnnotation(type: DictionaryType(keyType: Type("String"), valueType: Type("Int"))),
        initializer: InitializerClause(value: DictionaryExpr())
      )
    }

    AssertBuildResult(buildable, "␣var d: [String: Int] = [: ]")
  }

  func testVariableDeclWithExplicitTrailingCommas() {
    let buildable = VariableDecl(
      letOrVarKeyword: .let,
      bindings: [
        PatternBinding(
          pattern: PatternSyntax("a"),
          initializer: InitializerClause(
            value: ArrayExpr(
              leftSquare: .`leftSquareBracket`.withTrailingTrivia(.newline)
            ) {
              for i in 1...3 {
                ArrayElement(
                  expression: IntegerLiteralExpr(i),
                  trailingComma: .comma.withTrailingTrivia(.newline)
                )
              }
            }
          )
        )
      ]
    )
    AssertBuildResult(
      buildable,
      """
      let a = [
      1,
      2,
      3,
      ]
      """
    )
  }

  func testMultiPatternVariableDecl() {
    let buildable = VariableDecl(letOrVarKeyword: .let) {
      PatternBinding(
        pattern: PatternSyntax("a"),
        initializer: InitializerClause(
          value: ArrayExpr {
            for i in 1...3 {
              ArrayElement(expression: IntegerLiteralExpr(i))
            }
          }
        )
      )
      PatternBinding(
        pattern: PatternSyntax("d"),
        initializer: InitializerClause(
          value: DictionaryExpr {
            for i in 1...3 {
              DictionaryElement(keyExpression: StringLiteralExpr(content: "key\(i)"), valueExpression: IntegerLiteralExpr(i))
            }
          }
        )
      )
      PatternBinding(pattern: PatternSyntax("i"), typeAnnotation: TypeAnnotation(type: Type("Int")))
      PatternBinding(pattern: PatternSyntax("s"), typeAnnotation: TypeAnnotation(type: Type("String")))
    }
    AssertBuildResult(buildable, #"let a = [1, 2, 3], d = ["key1": 1, "key2": 2, "key3": 3], i: Int, s: String"#)
  }

  func testClosureTypeVariableDecl() {
    let type = FunctionType(arguments: [TupleTypeElement(type: Type("Int"))], returnType: Type("Bool"))
    let buildable = VariableDecl(letOrVarKeyword: .let) {
      PatternBinding(pattern: PatternSyntax("c"), typeAnnotation: TypeAnnotation(type: type))
    }
    AssertBuildResult(buildable, "let c: (Int) -> Bool")
  }

  func testComputedProperty() {
    let buildable = VariableDecl(name: "test", type: TypeAnnotation(type: Type("Int"))) {
      SequenceExpr {
        IntegerLiteralExpr(4)
        BinaryOperatorExpr(text: "+")
        IntegerLiteralExpr(5)
      }
    }

    AssertBuildResult(
      buildable,
      """
      var test: Int {
          4 + 5
      }
      """
    )
  }

  func testAttributedVariables() {
    let testCases: [UInt: (VariableDecl, String)] = [
      #line: (
        VariableDecl(
          attributes: AttributeList { CustomAttribute("Test") },
          .var,
          name: "x",
          type: TypeAnnotation(type: Type("Int"))
        ),
        """
        @Test var x: Int
        """
      ),
      #line: (
        VariableDecl(
          attributes: AttributeList { CustomAttribute("Test") },
          name: "y",
          type: TypeAnnotation(type: Type("String"))
        ) {
          StringLiteralExpr(content: "Hello world!")
        },
        """
        @Test var y: String {
            "Hello world!"
        }
        """
      ),
      #line: (
        VariableDecl(
          attributes: AttributeList {
            CustomAttribute("WithArgs") {
              TupleExprElement(expression: "value1")
              TupleExprElement(label: "label", expression: "value2")
            }
          },
          name: "z",
          type: TypeAnnotation(type: Type("Float"))
        ) {
          FloatLiteralExpr(0.0)
        },
        """
        @WithArgs(value1, label: value2) var z: Float {
            0.0
        }
        """
      ),
      #line: (
        VariableDecl(
          attributes: AttributeList {
            CustomAttribute("WithArgs") {
              TupleExprElement(expression: "value")
            }
          },
          modifiers: [DeclModifier(name: .public)],
          .let,
          name: "z",
          type: TypeAnnotation(type: Type("Float"))
        ),
        """
        @WithArgs(value) public let z: Float
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }
}
