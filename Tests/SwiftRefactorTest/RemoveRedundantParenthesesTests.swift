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
    let tests: [(Int, input: ExprSyntax, expected: ExprSyntax)] = [
      (#line, input: "((1))", expected: "1"),
      (#line, input: "((x))", expected: "x"),
      (#line, input: "((x + y))", expected: "(x + y)"),
      (#line, input: "(x)", expected: "x"),
      (#line, input: "(1)", expected: "1"),
      (#line, input: "(\"s\")", expected: "\"s\""),
      (#line, input: "(true)", expected: "true"),
      (#line, input: "(x.y)", expected: "x.y"),
      (#line, input: "(f(x))", expected: "f(x)"),
      (#line, input: "(x[0])", expected: "x[0]"),
      (#line, input: "([1, 2])", expected: "[1, 2]"),
      (#line, input: "([:])", expected: "[:]"),
      (#line, input: "({ x in x })", expected: "{ x in x }"),
      (
        #line, input: "(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))",
        expected: "#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)"
      ),
      (#line, input: "(try! f())", expected: "try! f()"),
      (#line, input: "(try? f())", expected: "try? f()"),
      (#line, input: "(await f())", expected: "await f()"),
      (#line, input: "(x?.y)", expected: "x?.y"),
      (#line, input: "(x!)", expected: "x!"),
      (#line, input: "(nil)", expected: "nil"),
    ]

    for (line, input, expected) in tests {
      try assertRefactor(
        input,
        context: (),
        provider: RemoveRedundantParentheses.self,
        expected: expected,
        line: UInt(line)
      )
    }
  }

  func testPreservesTrivia() throws {
    let input: ExprSyntax = "/* a */ (( /* b */ x /* c */ )) /* d */"
    let expected: ExprSyntax = "/* a */ /* b */ x /* c */  /* d */"

    try assertRefactor(
      input,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: expected
    )
  }

  func testDoesNotRemoveNecessaryParentheses() throws {
    let tests: [(Int, input: ExprSyntax)] = [
      (#line, input: "(1 + 2)"),
      (#line, input: "(x as T)"),
      (#line, input: "(x ? y : z)"),
      (#line, input: "({ true }())"),
      // try without ! or ? requires parentheses for precedence
      (#line, input: "(try f())"),
      // await with complex expression requires parentheses
      (#line, input: "(await 1 + 2)"),
    ]

    for (line, input) in tests {
      try assertRefactor(
        input,
        context: (),
        provider: RemoveRedundantParentheses.self,
        expected: input,
        line: UInt(line)
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
