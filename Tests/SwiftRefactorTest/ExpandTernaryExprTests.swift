//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class ExpandTernaryExprTests: XCTestCase {
  func testSimpleTernary() throws {
    let baseline = TernaryExprSyntax(
      condition: ExprSyntax("a"),
      thenExpression: ExprSyntax("b"),
      elseExpression: ExprSyntax("c")
    )

    let expected: ExprSyntax = """
      if a {
          b
      } else {
          c
      }
      """

    try assertRefactor(baseline, context: (), provider: ExpandTernaryExpr.self, expected: expected)
  }

  func testTernaryWithComplexCondition() throws {
    let baseline = TernaryExprSyntax(
      condition: ExprSyntax("(x > 0 && y < 10)"),
      thenExpression: ExprSyntax("a"),
      elseExpression: ExprSyntax("b")
    )

    let expected: ExprSyntax = """
      if (x > 0 && y < 10) {
          a
      } else {
          b
      }
      """

    try assertRefactor(baseline, context: (), provider: ExpandTernaryExpr.self, expected: expected)
  }

  func testTernaryWithStringLiterals() throws {
    let baseline = TernaryExprSyntax(
      condition: ExprSyntax("flag"),
      thenExpression: ExprSyntax("\"yes\""),
      elseExpression: ExprSyntax("\"no\"")
    )

    let expected: ExprSyntax = """
      if flag {
          "yes"
      } else {
          "no"
      }
      """

    try assertRefactor(baseline, context: (), provider: ExpandTernaryExpr.self, expected: expected)
  }

  func testTernaryWithFunctionCalls() throws {
    let baseline = TernaryExprSyntax(
      condition: ExprSyntax("isValid"),
      thenExpression: ExprSyntax("doA()"),
      elseExpression: ExprSyntax("doB()")
    )

    let expected: ExprSyntax = """
      if isValid {
          doA()
      } else {
          doB()
      }
      """

    try assertRefactor(baseline, context: (), provider: ExpandTernaryExpr.self, expected: expected)
  }

  func testTernaryWithBooleanLiterals() throws {
    let baseline = TernaryExprSyntax(
      condition: ExprSyntax("condition"),
      thenExpression: ExprSyntax("true"),
      elseExpression: ExprSyntax("false")
    )

    let expected: ExprSyntax = """
      if condition {
          true
      } else {
          false
      }
      """

    try assertRefactor(baseline, context: (), provider: ExpandTernaryExpr.self, expected: expected)
  }

  func testTernaryWithComparisonCondition() throws {
    let baseline = TernaryExprSyntax(
      condition: ExprSyntax("x == 5"),
      thenExpression: ExprSyntax("result1"),
      elseExpression: ExprSyntax("result2")
    )

    let expected: ExprSyntax = """
      if x == 5 {
          result1
      } else {
          result2
      }
      """

    try assertRefactor(baseline, context: (), provider: ExpandTernaryExpr.self, expected: expected)
  }

  func testTernaryWithNilLiteral() throws {
    let baseline = TernaryExprSyntax(
      condition: ExprSyntax("hasValue"),
      thenExpression: ExprSyntax("value"),
      elseExpression: ExprSyntax("nil")
    )

    let expected: ExprSyntax = """
      if hasValue {
          value
      } else {
          nil
      }
      """

    try assertRefactor(baseline, context: (), provider: ExpandTernaryExpr.self, expected: expected)
  }

  func testTernaryWithMemberAccess() throws {
    let baseline = TernaryExprSyntax(
      condition: ExprSyntax("obj.isEnabled"),
      thenExpression: ExprSyntax("obj.enabledValue"),
      elseExpression: ExprSyntax("obj.disabledValue")
    )

    let expected: ExprSyntax = """
      if obj.isEnabled {
          obj.enabledValue
      } else {
          obj.disabledValue
      }
      """

    try assertRefactor(baseline, context: (), provider: ExpandTernaryExpr.self, expected: expected)
  }
}
