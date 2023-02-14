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

final class IfStmtTests: XCTestCase {
  func testEmptyIfStmt() {
    // Use the convenience initializer from IfStmtConvenienceInitializers. This is
    // disambiguated by the absence of a labelName parameter and the use of a
    // trailing closure.
    let buildable = IfStmt(conditions: ConditionElementList { BooleanLiteralExpr(false) }) {}
    AssertBuildResult(
      buildable,
      """
      if false {
      }
      """
    )
  }

  func testIfElseStmt() {
    // Use the convenience initializer from IfStmtConvenienceInitializers
    // with an else branch expressed by a second trailing closure.
    let buildable = IfStmt(conditions: ConditionElementList { BooleanLiteralExpr(true) }) {
      FunctionCallExpr(callee: ExprSyntax("print")) {
        TupleExprElement(expression: StringLiteralExpr(content: "Hello from the if-branch!"))
      }
    } elseBody: {
      FunctionCallExpr(callee: ExprSyntax("print")) {
        TupleExprElement(expression: StringLiteralExpr(content: "Hello from the else-branch!"))
      }
    }
    AssertBuildResult(
      buildable,
      """
      if true {
          print("Hello from the if-branch!")
      } else {
          print("Hello from the else-branch!")
      }
      """
    )
  }

  func testIfLetStmt() {
    let buildable = IfStmt(
      conditions: ConditionElementList {
        OptionalBindingCondition(
          letOrVarKeyword: .let,
          pattern: PatternSyntax("x"),
          initializer: InitializerClause(value: Expr("y"))
        )
      }
    ) {}
    AssertBuildResult(
      buildable,
      """
      if let x = y {
      }
      """
    )
  }

  func testIfCaseStmt() {
    let buildable = IfStmt(
      conditions: ConditionElementList {
        MatchingPatternCondition(
          pattern: ExpressionPattern(expression: MemberAccessExpr(name: "x")),
          initializer: InitializerClause(value: Expr("y"))
        )
      }
    ) {}
    AssertBuildResult(
      buildable,
      """
      if case .x = y {
      }
      """
    )
  }
}
