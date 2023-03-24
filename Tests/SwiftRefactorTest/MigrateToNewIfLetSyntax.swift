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

import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder

import XCTest
import _SwiftSyntaxTestSupport

func assertRefactorIfLet(
  _ syntax: ExprSyntax,
  expected: ExprSyntax,
  file: StaticString = #file,
  line: UInt = #line
) throws {
  let ifExpr = try XCTUnwrap(
    syntax.as(IfExprSyntax.self),
    file: file,
    line: line
  )

  let refactored = try XCTUnwrap(
    MigrateToNewIfLetSyntax.refactor(syntax: ifExpr),
    file: file,
    line: line
  )

  assertStringsEqualWithDiff(
    expected.description,
    refactored.description,
    file: file,
    line: line
  )
}

final class MigrateToNewIfLetSyntaxTest: XCTestCase {
  func testRefactoring() throws {
    let baselineSyntax: ExprSyntax = """
      if let x = x {}
      """

    let expectedSyntax: ExprSyntax = """
      if let x {}
      """

    try assertRefactorIfLet(baselineSyntax, expected: expectedSyntax)
  }

  func testIdempotence() throws {
    let baselineSyntax: ExprSyntax = """
      if let x = x {}
      """

    let expectedSyntax: ExprSyntax = """
      if let x {}
      """

    try assertRefactorIfLet(baselineSyntax, expected: expectedSyntax)
    try assertRefactorIfLet(expectedSyntax, expected: expectedSyntax)
  }

  func testMultiBinding() throws {
    let baselineSyntax: ExprSyntax = """
      if let x = x, var y = y, let z = z {}
      """

    let expectedSyntax: ExprSyntax = """
      if let x, var y, let z {}
      """

    try assertRefactorIfLet(baselineSyntax, expected: expectedSyntax)
  }

  func testMixedBinding() throws {
    let baselineSyntax: ExprSyntax = """
      if let x = x, var y = x, let z = y.w {}
      """

    let expectedSyntax: ExprSyntax = """
      if let x, var y = x, let z = y.w {}
      """

    try assertRefactorIfLet(baselineSyntax, expected: expectedSyntax)
  }

  func testConditions() throws {
    let baselineSyntax: ExprSyntax = """
      if let x = x + 1, x == x, !x {}
      """

    let expectedSyntax: ExprSyntax = """
      if let x = x + 1, x == x, !x {}
      """

    try assertRefactorIfLet(baselineSyntax, expected: expectedSyntax)
  }

  func testWhitespaceNormalization() throws {
    let baselineSyntax: ExprSyntax = """
      if let x = x   , let y = y {}
      """

    let expectedSyntax: ExprSyntax = """
      if let x, let y {}
      """

    try assertRefactorIfLet(baselineSyntax, expected: expectedSyntax)
  }

  func testIfStmt() throws {
    let baselineSyntax: StmtSyntax = """
      if let x = x {}
      """

    let expectedSyntax: ExprSyntax = """
      if let x {}
      """

    let exprStmt = try XCTUnwrap(baselineSyntax.as(ExpressionStmtSyntax.self))
    try assertRefactorIfLet(exprStmt.expression, expected: expectedSyntax)
  }
}
