//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/move_expr.swift

@_spi(ExperimentalLanguageFeatures) import SwiftParser
import SwiftSyntax
import XCTest

final class MoveExprTests: ParserTestCase {
  func testMoveExpr1() {
    assertParse(
      """
      var global: Int = 5
      func testGlobal() {
          let _ = _move global
      }
      """,
      experimentalFeatures: [.oldOwnershipOperatorSpellings]
    )
  }

  func testMoveExpr2() {
    assertParse(
      """
      func testLet() {
          let t = String()
          let _ = _move t
      }
      """,
      experimentalFeatures: [.oldOwnershipOperatorSpellings]

    )
  }

  func testMoveExpr3() {
    assertParse(
      """
      func testVar() {
          var t = String()
          t = String()
          let _ = _move t
      }
      """,
      experimentalFeatures: [.oldOwnershipOperatorSpellings]
    )
  }

  func testMoveExpr4() {
    assertParse(
      """
      _move(t)
      """,
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("_move")),
        leftParen: .leftParenToken(),
        arguments: [.init(expression: DeclReferenceExprSyntax(baseName: .identifier("t")))],
        rightParen: .rightParenToken()
      ),
      experimentalFeatures: [.oldOwnershipOperatorSpellings]
    )
  }

  func testMoveExpr5() {
    assertParse(
      """
      _move(t)
      """,
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("_move")),
        leftParen: .leftParenToken(),
        arguments: [.init(expression: DeclReferenceExprSyntax(baseName: .identifier("t")))],
        rightParen: .rightParenToken()
      ),
      experimentalFeatures: []
    )
  }

  func testMoveExpr6() {
    assertParse(
      """
      _move1️⃣ t 
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      fixedSource:
        """
        _move
        t
        """,
      experimentalFeatures: []
    )
  }

  func testConsumeExpr1() {
    assertParse(
      """
      var global: Int = 5
      func testGlobal() {
          let _ = consume global
      }
      """
    )
  }

  func testConsumeExpr2() {
    assertParse(
      """
      func testLet() {
          let t = String()
          let _ = consume t
      }
      """
    )
  }

  func testConsumeExpr3() {
    assertParse(
      """
      func testVar() {
          var t = String()
          t = String()
          let _ = consume t
      }
      """
    )
  }

  func testConsumeVariableNameInCast() {
    assertParse(
      """
      class ParentKlass {}
      class SubKlass : ParentKlass {}

      func test(_ x: SubKlass) {
        switch x {
        case let consume as ParentKlass:
          fallthrough
        }
      }
      """
    )
  }
}
