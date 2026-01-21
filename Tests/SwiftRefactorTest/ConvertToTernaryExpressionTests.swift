//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
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

final class ConvertToTernaryExpressionTests: XCTestCase {

  // MARK: - Basic Pattern Tests
  func testBasicIfElseWithLetDeclaration() throws {
    let baseline: CodeBlockItemListSyntax = """
      let result: Int
      if condition {
        result = 10
      } else {
        result = 20
      }
      """

    let expected: CodeBlockItemListSyntax = """
      let result = condition ? 10 : 20
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testBasicIfElseWithVarDeclaration() throws {
    let baseline: CodeBlockItemListSyntax = """
      var status: String
      if isValid {
        status = "approved"
      } else {
        status = "rejected"
      }
      """

    let expected: CodeBlockItemListSyntax = """
      var status = isValid ? "approved" : "rejected"
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testStandaloneIfElseAssignment() throws {
    let baseline: CodeBlockItemListSyntax = """
      if isActive {
        flag = true
      } else {
        flag = false
      }
      """

    let expected: CodeBlockItemListSyntax = """
      flag = isActive ? true : false
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testParenthesizedCondition() throws {
    let baseline: CodeBlockItemListSyntax = """
      let output: Int
      if (x > 0) {
        output = 1
      } else {
        output = 0
      }
      """

    let expected: CodeBlockItemListSyntax = """
      let output = (x > 0) ? 1 : 0
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  // MARK: - Tuple Assignment Tests
  func testSimpleTupleAssignment() throws {
    let baseline: CodeBlockItemListSyntax = """
      let point: (Int, Int)
      if isOrigin {
        point = (0, 0)
      } else {
        point = (10, 20)
      }
      """

    let expected: CodeBlockItemListSyntax = """
      let point = isOrigin ? (0, 0) : (10, 20)
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testNamedTupleAssignment() throws {
    let baseline: CodeBlockItemListSyntax = """
      let coordinates: (x: Int, y: Int)
      if reset {
        coordinates = (x: 0, y: 0)
      } else {
        coordinates = (x: 100, y: 200)
      }
      """

    let expected: CodeBlockItemListSyntax = """
      let coordinates = reset ? (x: 0, y: 0) : (x: 100, y: 200)
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  // MARK: - Complex Expression Tests

  func testFunctionCallInBranches() throws {
    let baseline: CodeBlockItemListSyntax = """
      let result: String
      if shouldTransform {
        result = transform(input)
      } else {
        result = identity(input)
      }
      """

    let expected: CodeBlockItemListSyntax = """
      let result = shouldTransform ? transform(input) : identity(input)
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testDictionaryLiteralInBranches() throws {
    let baseline: CodeBlockItemListSyntax = """
      let config: [String: Int]
      if useDefault {
        config = [:]
      } else {
        config = ["key": 42]
      }
      """

    let expected: CodeBlockItemListSyntax = """
      let config = useDefault ? [:] : ["key": 42]
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  // MARK: - Negative Tests - Should NOT Refactor

  func testRejectsElseIfChain() throws {
    let baseline: CodeBlockItemListSyntax = """
      let result: Int
      if condition1 {
        result = 1
      } else if condition2 {
        result = 2
      } else {
        result = 3
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }

  func testRejectsNestedTernary() throws {
    let baseline: CodeBlockItemListSyntax = """
      let result: Int
      if outer {
        result = inner ? 1 : 2
      } else {
        result = 3
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }

  func testRejectsClosureInBranch() throws {
    let baseline: CodeBlockItemListSyntax = """
      let result: () -> Void
      if condition {
        result = { print("hello") }
      } else {
        result = { print("goodbye") }
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }

  func testRejectsDifferentVariablesInBranches() throws {
    let baseline: CodeBlockItemListSyntax = """
      let result: Int
      if condition {
        result = 10
      } else {
        other = 20
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }

  func testRejectsNoElseClause() throws {
    let baseline: CodeBlockItemListSyntax = """
      let result: Int
      if condition {
        result = 10
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }
}

private func assertRefactorConvert(
  _ baseline: CodeBlockItemListSyntax,
  expected: CodeBlockItemListSyntax?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  try assertRefactor(
    baseline,
    context: (),
    provider: ConvertToTernaryExpression.self,
    expected: expected,
    file: file,
    line: line
  )
}
