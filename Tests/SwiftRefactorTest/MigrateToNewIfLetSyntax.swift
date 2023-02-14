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

import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder

import XCTest
import _SwiftSyntaxTestSupport

final class MigrateToNewIfLetSyntaxTest: XCTestCase {
  func testRefactoring() throws {
    let baselineSyntax: StmtSyntax = """
      if let x = x {}
      """

    let expectedSyntax: StmtSyntax = """
      if let x {}
      """

    let baseline = try XCTUnwrap(baselineSyntax.as(IfStmtSyntax.self))
    let expected = try XCTUnwrap(expectedSyntax.as(IfStmtSyntax.self))

    let refactored = try XCTUnwrap(MigrateToNewIfLetSyntax.refactor(syntax: baseline))

    AssertStringsEqualWithDiff(expected.description, refactored.description)
  }

  func testIdempotence() throws {
    let baselineSyntax: StmtSyntax = """
      if let x = x {}
      """

    let baseline = try XCTUnwrap(baselineSyntax.as(IfStmtSyntax.self))

    let refactored = try XCTUnwrap(MigrateToNewIfLetSyntax.refactor(syntax: baseline))
    let refactoredAgain = try XCTUnwrap(MigrateToNewIfLetSyntax.refactor(syntax: baseline))

    AssertStringsEqualWithDiff(refactored.description, refactoredAgain.description)
  }

  func testMultiBinding() throws {
    let baselineSyntax: StmtSyntax = """
      if let x = x, var y = y, let z = z {}
      """

    let expectedSyntax: StmtSyntax = """
      if let x, var y, let z {}
      """

    let baseline = try XCTUnwrap(baselineSyntax.as(IfStmtSyntax.self))
    let expected = try XCTUnwrap(expectedSyntax.as(IfStmtSyntax.self))

    let refactored = try XCTUnwrap(MigrateToNewIfLetSyntax.refactor(syntax: baseline))

    AssertStringsEqualWithDiff(expected.description, refactored.description)
  }

  func testMixedBinding() throws {
    let baselineSyntax: StmtSyntax = """
      if let x = x, var y = x, let z = y.w {}
      """

    let expectedSyntax: StmtSyntax = """
      if let x, var y = x, let z = y.w {}
      """

    let baseline = try XCTUnwrap(baselineSyntax.as(IfStmtSyntax.self))
    let expected = try XCTUnwrap(expectedSyntax.as(IfStmtSyntax.self))

    let refactored = try XCTUnwrap(MigrateToNewIfLetSyntax.refactor(syntax: baseline))

    AssertStringsEqualWithDiff(expected.description, refactored.description)
  }

  func testConditions() throws {
    let baselineSyntax: StmtSyntax = """
      if let x = x + 1, x == x, !x {}
      """

    let expectedSyntax: StmtSyntax = """
      if let x = x + 1, x == x, !x {}
      """

    let baseline = try XCTUnwrap(baselineSyntax.as(IfStmtSyntax.self))
    let expected = try XCTUnwrap(expectedSyntax.as(IfStmtSyntax.self))

    let refactored = try XCTUnwrap(MigrateToNewIfLetSyntax.refactor(syntax: baseline))

    AssertStringsEqualWithDiff(expected.description, refactored.description)
  }

  func testWhitespaceNormalization() throws {
    let baselineSyntax: StmtSyntax = """
      if let x = x   , let y = y {}
      """

    let expectedSyntax: StmtSyntax = """
      if let x, let y {}
      """

    let baseline = try XCTUnwrap(baselineSyntax.as(IfStmtSyntax.self))
    let expected = try XCTUnwrap(expectedSyntax.as(IfStmtSyntax.self))

    let refactored = try XCTUnwrap(MigrateToNewIfLetSyntax.refactor(syntax: baseline))

    AssertStringsEqualWithDiff(expected.description, refactored.description)
  }
}
