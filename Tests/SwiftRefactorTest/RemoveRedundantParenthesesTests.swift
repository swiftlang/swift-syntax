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

import SwiftParser
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class RemoveRedundantParenthesesTest: XCTestCase {

  func testRemovesRedundantParentheses() throws {
    try assertParenRemoval("((1))", expected: "1")
    try assertParenRemoval("((x))", expected: "x")
    try assertParenRemoval("((x + y))", expected: "(x + y)")
    try assertParenRemoval("(x)", expected: "x")
    try assertParenRemoval("(1)", expected: "1")
    try assertParenRemoval("(\"s\")", expected: "\"s\"")
    try assertParenRemoval("(true)", expected: "true")
    try assertParenRemoval("(x.y)", expected: "x.y")
    try assertParenRemoval("(f(x))", expected: "f(x)")
    try assertParenRemoval("(x[0])", expected: "x[0]")
    try assertParenRemoval("([1, 2])", expected: "[1, 2]")
    try assertParenRemoval("([:])", expected: "[:]")
    try assertParenRemoval("({ x in x })", expected: "{ x in x }")
    try assertParenRemoval(
      "(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))",
      expected: "#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)"
    )
    try assertParenRemoval("(try! f())", expected: "try! f()")
    try assertParenRemoval("(try? f())", expected: "try? f()")
    try assertParenRemoval("(await f())", expected: "await f()")
    try assertParenRemoval("(x?.y)", expected: "x?.y")
    try assertParenRemoval("(x!)", expected: "x!")
    try assertParenRemoval("(nil)", expected: "nil")
  }

  func testPreservesNecessaryParentheses() throws {
    try assertParenRemoval("(1 + 2)", expected: "(1 + 2)")
    try assertParenRemoval("(x as T)", expected: "(x as T)")
    try assertParenRemoval("(x ? y : z)", expected: "(x ? y : z)")
    try assertParenRemoval("({ true }())", expected: "({ true }())")
    // try without ! or ? requires parentheses for precedence
    try assertParenRemoval("(try f())", expected: "(try f())")
    // await with complex expression requires parentheses
    try assertParenRemoval("(await 1 + 2)", expected: "(await 1 + 2)")
  }

  func testTupleHandling() throws {
    // Nested tuple: outer parens removed, inner tuple preserved
    try assertParenRemoval("((x, y))", expected: "(x, y)")
    // Single element with trailing comma: treated as parentheses, removed
    try assertParenRemoval("(x,)", expected: "x")
    // Two-element tuple: preserved
    try assertParenRemoval("(x, y)", expected: "(x, y)")
  }

  func testPreservesTrivia() throws {
    try assertParenRemoval(
      "/* a */ (( /* b */ x /* c */ )) /* d */",
      expected: "/* a */ /* b */ x /* c */  /* d */"
    )
  }

  func testInitializerClauseRemovesParentheses() throws {
    // `let x = (a + b)` removes parens because InitializerClauseSyntax context
    try assertParenRemoval("let x = (a + b)", expected: "let x = a + b")
    try assertParenRemoval("let x = ((1))", expected: "let x = 1")

    // `if let` and `guard let` initializers also remove parentheses
    try assertParenRemoval("if let x = (a + b) {}", expected: "if let x = a + b {}")
    try assertParenRemoval("if var x = (a + b) {}", expected: "if var x = a + b {}")
    try assertParenRemoval("guard let x = (a + b) else {}", expected: "guard let x = a + b else {}")

    // `try f()` is not a "simple expression", but in an initializer clause the parentheses are still redundant.
    try assertParenRemoval("let x = (try f())", expected: "let x = try f()")
  }

  func testPreservesParenthesesInConditions() throws {
    // Closures in conditions need parentheses
    try assertParenRemoval("if ({ true }) {}", expected: "if ({ true }) {}")
    try assertParenRemoval("if (call { true }) {}", expected: "if (call { true }) {}")
    try assertParenRemoval("while ({ true }) {}", expected: "while ({ true }) {}")
    try assertParenRemoval("guard (call { true }) else {}", expected: "guard (call { true }) else {}")
    try assertParenRemoval("repeat {} while (call { true })", expected: "repeat {} while (call { true })")
    // Nested in sequence expressions
    try assertParenRemoval("if ({ true }) == ({ true }) {}", expected: "if ({ true }) == ({ true }) {}")
    // Macro expansions with trailing closures
    try assertParenRemoval("if (#macro { true }) == false {}", expected: "if (#macro { true }) == false {}")
    // Subscripts with trailing closures
    try assertParenRemoval("if (array[0] { true }) == false {}", expected: "if (array[0] { true }) == false {}")

    // Complex trailing closures in conditions
    try assertParenRemoval("if (call { true }) == false {}", expected: "if (call { true }) == false {}")
    try assertParenRemoval("if let x: () -> Bool = ({ true }) {}", expected: "if let x: () -> Bool = ({ true }) {}")
  }

  func testPreservesParenthesesForMetatypes() throws {
    // e.g., `(any Equatable).self` must not become `any Equatable.self`
    try assertParenRemoval("(any Equatable).self", expected: "(any Equatable).self")
    try assertParenRemoval("(some P).self", expected: "(some P).self")
    try assertParenRemoval("(A & B).self", expected: "(A & B).self")
    try assertParenRemoval("(any Equatable).Type", expected: "(any Equatable).Type")
    try assertParenRemoval("(some P).Type", expected: "(some P).Type")
    try assertParenRemoval("(A & B).Type", expected: "(A & B).Type")
    try assertParenRemoval("(any Equatable).Protocol", expected: "(any Equatable).Protocol")
    try assertParenRemoval("(A & B).Protocol", expected: "(A & B).Protocol")
  }
}

// MARK: - Test Helper

/// Applies `RemoveRedundantParentheses` to all tuple expressions in the input and compares to expected.
private func assertParenRemoval(
  _ input: String,
  expected: String,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  var parser = Parser(input)
  let inputSyntax = SourceFileSyntax.parse(from: &parser)

  let rewriter = ParenRemovalRewriter()
  let result = rewriter.visit(inputSyntax)

  // Trim trailing newline that SourceFileSyntax adds
  let resultString = result.description.trimmingCharacters(in: .newlines)

  assertStringsEqualWithDiff(
    resultString,
    expected,
    file: file,
    line: line
  )
}

/// A SyntaxRewriter that applies `RemoveRedundantParentheses` to all tuple expressions.
private class ParenRemovalRewriter: SyntaxRewriter {
  override func visit(_ node: TupleExprSyntax) -> ExprSyntax {
    // First, recursively process children
    let visited = super.visit(node)
    guard let tuple = visited.as(TupleExprSyntax.self) else {
      return visited
    }
    // Then apply the refactoring
    return RemoveRedundantParentheses.refactor(syntax: tuple, in: ())
  }
}
