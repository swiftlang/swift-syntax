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

  func testNestedClosureInCondition() throws {
    // closures nested deeper inside conditions should also preserve parentheses.
    // Example: `if ({ true }) == ({ true }) {}`
    let ifExpr = IfExprSyntax(
      conditions: ConditionElementListSyntax {
        ConditionElementSyntax(condition: .expression(ExprSyntax("({ true }) == ({ true })")))
      },
      body: CodeBlockSyntax(statements: [])
    )
    let condition = try XCTUnwrap(ifExpr.conditions.first)
    let conditionExpr = try XCTUnwrap(condition.condition.as(ExprSyntax.self))
    let sequenceExpr = try XCTUnwrap(conditionExpr.as(SequenceExprSyntax.self))
    // Sequence: ({ true }), ==, ({ true })
    let elements = Array(sequenceExpr.elements)
    XCTAssertEqual(elements.count, 3)
    let lhsTuple = try XCTUnwrap(elements[0].as(TupleExprSyntax.self))
    let rhsTuple = try XCTUnwrap(elements[2].as(TupleExprSyntax.self))

    // Both closures should preserve their parentheses
    try assertRefactor(
      lhsTuple,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: lhsTuple
    )
    try assertRefactor(
      rhsTuple,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: rhsTuple
    )
  }

  func testTrailingClosureInCondition() throws {
    // Function calls with trailing closures inside conditions need parentheses.
    // e.g. `if (call { true }) {}` — without parens, `{ true }` would be parsed as the if body.
    let ifExpr = IfExprSyntax(
      conditions: ConditionElementListSyntax {
        ConditionElementSyntax(condition: .expression(ExprSyntax("(call { true })")))
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

  func testInitializerClause() throws {
    // Parentheses in initializer clauses are always redundant.
    // e.g. `let x = (a + b)` -> `let x = a + b`
    let decl: DeclSyntax = "let x = (a + b)"
    let varDecl = try XCTUnwrap(decl.as(VariableDeclSyntax.self))
    let binding = try XCTUnwrap(varDecl.bindings.first)
    let initializer = try XCTUnwrap(binding.initializer)
    let tupleExpr = try XCTUnwrap(initializer.value.as(TupleExprSyntax.self))
    let innerExpr = try XCTUnwrap(tupleExpr.elements.first?.expression)

    try assertRefactor(
      tupleExpr,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: innerExpr
    )
  }

  func testMacroExpansionWithTrailingClosureInCondition() throws {
    // Macro expansions with trailing closures inside conditions need parentheses.
    // e.g. `if (#macro { true }) == false {}`
    let ifExpr = IfExprSyntax(
      conditions: ConditionElementListSyntax {
        ConditionElementSyntax(condition: .expression(ExprSyntax("(#macro { true }) == false")))
      },
      body: CodeBlockSyntax(statements: [])
    )
    let condition = try XCTUnwrap(ifExpr.conditions.first)
    let conditionExpr = try XCTUnwrap(condition.condition.as(ExprSyntax.self))
    let sequenceExpr = try XCTUnwrap(conditionExpr.as(SequenceExprSyntax.self))
    let tupleExpr = try XCTUnwrap(sequenceExpr.elements.first?.as(TupleExprSyntax.self))

    try assertRefactor(
      tupleExpr,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: tupleExpr
    )
  }

  func testSubscriptWithTrailingClosureInCondition() throws {
    // Subscript calls with trailing closures inside conditions need parentheses.
    // e.g. `if (array[0] { true }) == false {}`
    let ifExpr = IfExprSyntax(
      conditions: ConditionElementListSyntax {
        ConditionElementSyntax(condition: .expression(ExprSyntax("(array[0] { true }) == false")))
      },
      body: CodeBlockSyntax(statements: [])
    )
    let condition = try XCTUnwrap(ifExpr.conditions.first)
    let conditionExpr = try XCTUnwrap(condition.condition.as(ExprSyntax.self))
    let sequenceExpr = try XCTUnwrap(conditionExpr.as(SequenceExprSyntax.self))
    let tupleExpr = try XCTUnwrap(sequenceExpr.elements.first?.as(TupleExprSyntax.self))

    try assertRefactor(
      tupleExpr,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: tupleExpr
    )
  }

  func testComplexTypeNeedsParentheses() throws {
    // Complex types like `any Equatable` need parentheses, e.g. `(any Equatable).self`
    // must not become `any Equatable.self`
    let tests: [(Int, input: String)] = [
      (#line, "(any Equatable).self"),
      (#line, "(some P).self"),
      (#line, "(A & B).self"),
    ]

    for (line, input) in tests {
      let expr = ExprSyntax(stringLiteral: input)
      let memberAccess = try XCTUnwrap(expr.as(MemberAccessExprSyntax.self), line: UInt(line))
      let tupleExpr = try XCTUnwrap(memberAccess.base?.as(TupleExprSyntax.self), line: UInt(line))

      try assertRefactor(
        tupleExpr,
        context: (),
        provider: RemoveRedundantParentheses.self,
        expected: tupleExpr,
        line: UInt(line)
      )
    }
  }

  func testWhileConditionWithClosure() throws {
    let whileStmt = WhileStmtSyntax(
      conditions: ConditionElementListSyntax {
        ConditionElementSyntax(condition: .expression(ExprSyntax("({ true })")))
      },
      body: CodeBlockSyntax(statements: [])
    )
    let condition = try XCTUnwrap(whileStmt.conditions.first)
    let conditionExpr = try XCTUnwrap(condition.condition.as(ExprSyntax.self))
    let tupleExpr = try XCTUnwrap(conditionExpr.as(TupleExprSyntax.self))

    try assertRefactor(
      tupleExpr,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: tupleExpr
    )
  }

  func testGuardConditionWithTrailingClosure() throws {
    let guardStmt = GuardStmtSyntax(
      conditions: ConditionElementListSyntax {
        ConditionElementSyntax(condition: .expression(ExprSyntax("(call { true })")))
      },
      body: CodeBlockSyntax(statements: [])
    )
    let condition = try XCTUnwrap(guardStmt.conditions.first)
    let conditionExpr = try XCTUnwrap(condition.condition.as(ExprSyntax.self))
    let tupleExpr = try XCTUnwrap(conditionExpr.as(TupleExprSyntax.self))

    try assertRefactor(
      tupleExpr,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: tupleExpr
    )
  }

  func testMetatypeTypeAccess() throws {
    // e.g., `(any Equatable).Type` must not become `any Equatable.Type`
    let tests: [(Int, input: String)] = [
      (#line, "(any Equatable).Type"),
      (#line, "(some P).Type"),
      (#line, "(A & B).Type"),
    ]

    for (line, input) in tests {
      let expr = ExprSyntax(stringLiteral: input)
      let memberAccess = try XCTUnwrap(expr.as(MemberAccessExprSyntax.self), line: UInt(line))
      let tupleExpr = try XCTUnwrap(memberAccess.base?.as(TupleExprSyntax.self), line: UInt(line))

      try assertRefactor(
        tupleExpr,
        context: (),
        provider: RemoveRedundantParentheses.self,
        expected: tupleExpr,
        line: UInt(line)
      )
    }
  }

  func testProtocolMetatypeAccess() throws {
    let tests: [(Int, input: String)] = [
      (#line, "(any Equatable).Protocol"),
      (#line, "(A & B).Protocol"),
    ]

    for (line, input) in tests {
      let expr = ExprSyntax(stringLiteral: input)
      let memberAccess = try XCTUnwrap(expr.as(MemberAccessExprSyntax.self), line: UInt(line))
      let tupleExpr = try XCTUnwrap(memberAccess.base?.as(TupleExprSyntax.self), line: UInt(line))

      try assertRefactor(
        tupleExpr,
        context: (),
        provider: RemoveRedundantParentheses.self,
        expected: tupleExpr,
        line: UInt(line)
      )
    }
  }

  func testRepeatWhileConditionWithClosure() throws {
    // repeat-while uses ExprSyntax for condition, not ConditionElementSyntax.
    let repeatStmt = RepeatStmtSyntax(
      body: CodeBlockSyntax(statements: []),
      condition: ExprSyntax("(call { true })")
    )
    let conditionExpr = repeatStmt.condition
    let tupleExpr = try XCTUnwrap(conditionExpr.as(TupleExprSyntax.self))

    try assertRefactor(
      tupleExpr,
      context: (),
      provider: RemoveRedundantParentheses.self,
      expected: tupleExpr
    )
  }
}
