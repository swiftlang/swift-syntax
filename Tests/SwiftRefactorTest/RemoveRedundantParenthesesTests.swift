//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
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

final class RemoveRedundantParenthesesTest: XCTestCase {
  func testRemoveRedundantParentheses() throws {
    let tests: [(ExprSyntax, ExprSyntax)] = [
      ("((1))", "1"),
      ("((x))", "x"),
      ("((x + y))", "(x + y)"),
      ("(x)", "x"),
      ("(1)", "1"),
      ("(\"s\")", "\"s\""),
      ("(true)", "true"),
      ("(x.y)", "x.y"),
      ("(f(x))", "f(x)"),
      ("(x[0])", "x[0]"),
      ("([1, 2])", "[1, 2]"),
      ("([:])", "[:]"),
      ("({ x in x })", "{ x in x }"),
      ("(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))", "#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)"),
      ("(try f())", "try f()"),
      ("(await f())", "await f()"),
      ("(x?.y)", "x?.y"),
    ]

    for (input, expected) in tests {
      try assertRefactor(
        input,
        context: (),
        provider: RemoveRedundantParentheses.self,
        expected: expected
      )
    }
  }

  func testPreservesTrivia() throws {
    let input: ExprSyntax = "/* a */ (( /* b */ x /* c */ )) /* d */"
    let expected: ExprSyntax = "/* a */  /* b */ x /* c */  /* d */"

    try assertRefactor(
      input,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: expected
    )
  }

  func testDoesNotRemoveNecessaryParentheses() throws {
    let tests: [ExprSyntax] = [
      "(1 + 2)",
      "(x as T)",
      "(x ? y : z)",
      "({ true }())",
    ]

    for input in tests {
      try assertRefactor(
        input,
        context: (),
        provider: RemoveRedundantParentheses.self,
        expected: input
      )
    }
  }

  func testNestedTuple() throws {
    let input: ExprSyntax = "((x, y))"
    let expected: ExprSyntax = "(x, y)"

    try assertRefactor(
      input,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: expected
    )
  }

  func testSingleElementTupleWithTrailingComma() throws {
    let input: ExprSyntax = "(x,)"
    let expected: ExprSyntax = "x"

    try assertRefactor(
      input,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: expected
    )
  }

  func testTwoElementTuple() throws {
    // should NOT change
    let input: ExprSyntax = "(x, y)"
    let expected: ExprSyntax = "(x, y)"

    try assertRefactor(
      input,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: expected
    )
  }

  func testClosureInCondition() throws {
    let ifExpr = IfExprSyntax(
      conditions: ConditionElementListSyntax {
        ConditionElementSyntax(condition: .expression(ExprSyntax("({ true })")))
      },
      body: CodeBlockSyntax(statements: [])
    )
    let condition = try XCTUnwrap(ifExpr.conditions.first)
    let conditionExpr = try XCTUnwrap(condition.condition.as(ExprSyntax.self))
    let tupleExpr = try XCTUnwrap(conditionExpr.as(TupleExprSyntax.self))

    try assertRefactor(
      tupleExpr,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: tupleExpr
    )
  }
}
