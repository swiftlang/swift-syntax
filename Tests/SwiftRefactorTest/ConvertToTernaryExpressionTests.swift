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

final class ConvertToTernaryExpressionTests: XCTestCase {

  // MARK: - Basic Pattern Tests
  func testBasicIfElseWithLetDeclaration() throws {
    let baseline = """
      let result: Int
      if condition {
        result = 10
      } else {
        result = 20
      }
      """

    let expected = """
      let result = condition ? 10 : 20
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testStandaloneIfElseAssignment() throws {
    let baseline = """
      if isActive {
        flag = true
      } else {
        flag = false
      }
      """

    let expected = """
      flag = isActive ? true : false
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testParenthesizedCondition() throws {
    let baseline = """
      let output: Int
      if (x > 0) {
        output = 1
      } else {
        output = 0
      }
      """

    let expected = """
      let output = (x > 0) ? 1 : 0
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testUnparenthesizedCondition() throws {
    let baseline = """
      let output: Int
      if x > 0 {
        output = 1
      } else {
        output = 0
      }
      """

    let expected = """
      let output = x > 0 ? 1 : 0
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  // MARK: - Tuple Assignment Tests
  func testSimpleTupleAssignment() throws {
    let baseline = """
      let point: (Int, Int)
      if isOrigin {
        point = (0, 0)
      } else {
        point = (10, 20)
      }
      """

    let expected = """
      let point = isOrigin ? (0, 0) : (10, 20)
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testNamedTupleAssignment() throws {
    let baseline = """
      let coordinates: (x: Int, y: Int)
      if reset {
        coordinates = (x: 0, y: 0)
      } else {
        coordinates = (x: 100, y: 200)
      }
      """

    let expected = """
      let coordinates: (x: Int, y: Int) = reset ? (x: 0, y: 0) : (x: 100, y: 200)
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  // MARK: - Negative Tests - Should NOT Refactor

  func testRejectsElseIfChain() throws {
    let baseline = """
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

  func testNestedTernaryInBranch() throws {
    let baseline = """
      let result: Int
      if outer {
        result = inner ? 1 : 2
      } else {
        result = 3
      }
      """

    let expected = """
      let result = outer ? inner ? 1 : 2 : 3
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testClosureInBranch() throws {
    let baseline = """
      let result: () -> Void
      if condition {
        result = { print("hello") }
      } else {
        result = { print("goodbye") }
      }
      """

    let expected = """
      let result = condition ? { print("hello") } : { print("goodbye") }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRejectsDifferentVariablesInBranches() throws {
    let baseline = """
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
    let baseline = """
      let result: Int
      if condition {
        result = 10
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }
}

private func assertRefactorConvert(
  _ baseline: String,
  expected: String?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  let sourceFile = Parser.parse(source: baseline)

  class IfExprFinder: SyntaxVisitor {
    var result: IfExprSyntax?
    override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
      if result == nil { result = node }
      return .skipChildren
    }
  }

  let finder = IfExprFinder(viewMode: .sourceAccurate)
  finder.walk(sourceFile)

  guard let ifExpr = finder.result else {
    XCTFail("No IfExprSyntax found in baseline", file: file, line: line)
    return
  }

  let edits: [SourceEdit]
  do {
    edits = try ConvertToTernaryExpression.textRefactor(syntax: ifExpr)
  } catch {
    if expected != nil {
      XCTFail("Refactoring failed unexpectedly: \(error)", file: file, line: line)
    }
    return
  }

  guard let expected = expected else {
    XCTFail(
      "Expected refactoring to fail, but got \(edits.count) edit(s)",
      file: file,
      line: line
    )
    return
  }

  var bytes = Array(baseline.utf8)
  for edit in edits.sorted(by: { $0.range.lowerBound > $1.range.lowerBound }) {
    let start = edit.range.lowerBound.utf8Offset
    let end = edit.range.upperBound.utf8Offset
    bytes.replaceSubrange(start..<end, with: edit.replacementBytes)
  }

  let result = String(decoding: bytes, as: UTF8.self)
  assertStringsEqualWithDiff(result, expected, file: file, line: line)
}
