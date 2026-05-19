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

final class ArgumentMatchingTests: XCTestCase {

  func testStringBasedParsingHelper() throws {
    let result = try matchResult(
      declaration: "func foo(_ x: Int, y: Int) {}",
      call: "foo(1, y: 2)"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "y", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testDefaultLabeledParameterAndDefaultNonLabeledParameter() throws {
    let result = try matchResult(
      declaration: "func decl_closure_22(a p0: () -> Int = { -1000 }, _ p1: () -> Int = { -1001 }) {}",
      call: "decl_closure_22({ 1000 })"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testSingleTrailingClosure() throws {
    let result = try matchResult(
      declaration: "func foo(x: Int, body: () -> Void) {}",
      call: "foo(x: 1) {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "body", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testMultipleTrailingClosures() throws {
    let result = try matchResult(
      declaration: "func foo(x: Int, first: () -> Void, second: () -> Void, third: () -> Void) {}",
      call: "foo(x: 1) {} second: {} third: {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "first", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "second", expectedIndex: 2, expectedArgumentCount: 1)
    assertMatch(result, named: "third", expectedIndex: 3, expectedArgumentCount: 1)
  }

  func testTwoDefaultClosureParameters() throws {
    let result = try matchResult(
      declaration:
        #"func doubleTask(first: () -> Void = { print("Default 1") }, second: () -> Void = { print("Default 2") }) {}"#,
      call: #"doubleTask { print("Hello, World!") }"#
    )

    assertMatch(result, named: "first", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "second", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTwoDefaultClosureParametersWithSameLabel() throws {
    let result = try matchResult(
      declaration: "func decl_closure_16(a p0: () -> Int = { -1000 }, a p1: () -> Int = { -1001 } ) {}",
      call: "decl_closure_16() { 1000 } a: { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTrailingClosureWithDefaultedLeadingParameter() throws {
    let result = try matchResult(
      declaration: "func foo(x: Int = 0, body: () -> Void) {}",
      call: "foo {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "body", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTrailingClosureWithVariadicLeadingParameter() throws {
    let result = try matchResult(
      declaration: "func foo(values: Int..., body: () -> Void) {}",
      call: "foo(values: 1, 2, 3) {}"
    )

    assertMatch(result, named: "values", expectedIndex: 0, expectedArgumentCount: 3)
    assertMatch(result, named: "body", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testDefaultLabeledClosureAndUnlabeledVariadicWithTrailingClosure() throws {
    let result = try matchResult(
      declaration: "func decl_closure_23(a p0: () -> Int = { -1000 }, _ p1: (() -> Int)...) {}",
      call: "decl_closure_23({ 1000 }) { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 2)
  }

  func testMultipleTrailingClosuresWithDefaultAndVariadicParameters() throws {
    let result = try matchResult(
      declaration: "func foo(x: Int = 0, values: Int..., first: () -> Void, second: () -> Void) {}",
      call: "foo(values: 1, 2) {} second: {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "values", expectedIndex: 1, expectedArgumentCount: 2)
    assertMatch(result, named: "first", expectedIndex: 2, expectedArgumentCount: 1)
    assertMatch(result, named: "second", expectedIndex: 3, expectedArgumentCount: 1)
  }

  func testClosuresWithDefaultParameter() throws {
    let firstResult = try matchResult(
      declaration: #"func test(x: () -> Void, y: () -> Void = { print("y") }, z: () -> Void) {}"#,
      call: #"test(x: {}) {} z: {}"#
    )

    assertMatch(firstResult, named: "x", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(firstResult, named: "y", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(firstResult, named: "z", expectedIndex: 2, expectedArgumentCount: 1)

    let secondResult = try matchResult(
      declaration: #"func test(x: () -> Void, y: () -> Void = { print("y") }, z: () -> Void) {}"#,
      call: "test() {} z: {}"
    )

    assertMatch(secondResult, named: "x", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(secondResult, named: "y", expectedIndex: 1, expectedArgumentCount: 0)
    assertMatch(secondResult, named: "z", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testVariadicClosureParameterWithSingleTrailingClosure() throws {
    let result = try matchResult(
      declaration: "func test(x: () -> Void...) {}",
      call: "test {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 1)
  }

  func testTrailingClosureWithVariadicParameter() throws {
    let result = try matchResult(
      declaration: "func test(x: () -> Void..., y: () -> Void) {}",
      call: "test(x: {}, {}) {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "y", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTrailingClosureWithVariadicParameterAndDefaultedParameter() throws {
    let result = try matchResult(
      declaration: "func test(x: () -> Void..., y: () -> Void = {}) {}",
      call: "test {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "y", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTrailingClosuresWithVariadicParametersSpreadAcrossTrailingClosure() throws {
    let result = try matchResult(
      declaration: "func test(x: () -> Void..., b: () -> Void) {}",
      call: "test(x: {}) {} b: {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "b", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTrailingClosureWithDefaultClosureParameter() throws {
    let result = try matchResult(
      declaration: "func test(x: () -> Void, y: () -> Void = {}) {}",
      call: "test {}"
    )

    assertMatch(result, named: "x", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "y", expectedIndex: 1, expectedArgumentCount: 0)
  }

  func testMultipleTrailingClosuresWithVariadicAndIdentificalLabels() throws {
    let result = try matchResult(
      declaration: "func test(a p0:() -> Int...,a p1:() -> Int)",
      call: "test() { 1000 } a: { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testMultipleTrailingClosuresWithDefaultValueAndIdentificalLabels() throws {
    let result = try matchResult(
      declaration: "func test(a p0:() -> Int...,a p1:() -> Int = {-1001})",
      call: "test() { 1000 } a: { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testDefaultedAndRequiredParameterWithDuplicateLabels() throws {
    let result = try matchResult(
      declaration: "func test(a p0: Int = -1000, b p1: Int = -1001, a p2: Int) {}",
      call: "test(a: 1000, b: 1001, a: 1002)"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testLabeledPackFollowedByRequiredParameter() throws {
    let result = try matchResult(
      declaration: "func test<each T>(b p0: repeat each T, c p1: Int) where repeat each T: BinaryInteger {}",
      call: "test(b: 1, 2, c: 3)"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testUnlabeledPackFollowedByLabeledParameter() throws {
    let result = try matchResult(
      declaration: "func test<each T>(_ p0: repeat each T, c p1: Int) where repeat each T: BinaryInteger {}",
      call: "test(1, 2, c: 3)"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTwoPacksWithDistinctLabels() throws {
    let result = try matchResult(
      declaration:
        "func test<each T0, each T1>(a p0: repeat each T0, b p1: repeat each T1) where repeat each T0: BinaryInteger, repeat each T1: BinaryInteger {}",
      call: "test(a: 1, 2, b: 3, 4)"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 2)
  }

  func testPackContainingParenthesizedClosuresFollowedByClosureParameter() throws {
    let result = try matchResult(
      declaration: "func test<each T>(a p0: repeat each T, b p1: () -> Int) {}",
      call: "test(a: ({ 1000 }), ({ 1001 }), b: ({ 1002 }))"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTwoPacksContainingParenthesizedClosuresAndClosureParameter() throws {
    let result = try matchResult(
      declaration:
        "func test<each T0, each T1>(a p0: repeat each T0, b p1: repeat each T1, c p2: () -> Int) {}",
      call: "test(a: ({ 1000 }), ({ 1001 }), b: ({ 1002 }), ({ 1003 }), c: ({ 1004 }))"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 2)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testPackDoesNotConsumeFinalTrailingClosureNeededByLaterClosureParameter() throws {
    let result = try matchResult(
      declaration: "func test<each T>(a p0: repeat each T, b p1: () -> Int) {}",
      call: "test(a: ({ 1000 }), ({ 1001 })) { 1002 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testTrailingClosuresAroundVariadicClosureParameters() throws {
    let result = try matchResult(
      declaration: "func test(_ p0: (() -> Int)..., c p1: () -> Int, _ p2: (() -> Int)...) {}",
      call: "test() { 1000 } c: { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 0)
  }

  func testVariadicClosureAndDefaultedClosureWithSameLabel() throws {
    let result = try matchResult(
      declaration: "func test(a p0: (() -> Int)..., a p1: () -> Int = { -1001 }) {}",
      call: "test(a: { 1000 }) { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testStackedVariadicClosuresWithDefaultedClosureAndTrailingClosures() throws {
    let result = try matchResult(
      declaration: "func test(a p0: () -> Int..., a p1: () -> Int..., a p2: () -> Int = { -1002 }) {}",
      call: "test(a: { 1000 }, a: { 1002 }) { 1001 } a: { 1003 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 2)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testStackedVariadicClosuresWithSingleTrailingClosure() throws {
    let result = try matchResult(
      declaration: "func test(a p0: () -> Int..., a p1: () -> Int...) {}",
      call: "test(a: { 1000 }) { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testUnlabeledClosureParameterAndDefaultClosureParameter() throws {
    let result = try matchResult(
      declaration: "func decl_closure_40(_ p0: () -> Int = { -1000 }, b p1: () -> Int = { -1001 }) {}",
      call: "decl_closure_40() { 1000 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testRequiredClosureParameterBetweenDefaultedClosureParameters() throws {
    let result = try matchResult(
      declaration:
        "func decl_closure_130(a p0: () -> Int = { -1000 }, a p1: () -> Int, b p2: () -> Int = { -1002 }) {}",
      call: "decl_closure_130() { 1000 } b: { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testTwoDefaultClosuresFollowedByRequiredClosureCalledWithTwoClosures() throws {
    let result = try matchResult(
      declaration:
        "func decl_closure_138(a p0: () -> Int = { -1000 }, a p1: () -> Int = { -1001 }, b p2: () -> Int) {}",
      call: "decl_closure_138() { 1000 } b: { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 0)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testTwoDefaultClosuresFollowedByRequiredClosureCalledWithThreeClosures() throws {
    let result = try matchResult(
      declaration:
        "func decl_closure_138(a p0: () -> Int = { -1000 }, a p1: () -> Int = { -1001 }, b p2: () -> Int) {}",
      call: "decl_closure_138() { 1000 } a: { 1001 } b: { 1002 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testDefaultClosureFollowedByTwoRequiredClosures() throws {
    let result = try matchResult(
      declaration: "func decl_closure_129(a p0: () -> Int = { -1000 }, a p1: () -> Int, b p2: () -> Int) {}",
      call: "decl_closure_129() { 1000 } a: { 1001 } b: { 1002 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testTwoDefaultClosuresFollowedByUnlabeledVariadic() throws {
    let result = try matchResult(
      declaration:
        "func decl_closure_143(a p0: () -> Int = { -1000 }, a p1: () -> Int = { -1001 }, _ p2: (() -> Int)...) {}",
      call: "decl_closure_143(({ 1000 })) { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 0)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 2)
  }

  func testVariadicClosureFollowedByRequiredClosureFollowedByDefaultClosure() throws {
    let result = try matchResult(
      declaration: "func decl_closure_202(a p0: (() -> Int)..., a p1: () -> Int, b p2: () -> Int = { -1002 }) {}",
      call: "decl_closure_202() { 1000 } b: { 1001 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testUnlabeledVariadicClosureFollowedByRequiredClosureFollowedByDefaultClosure() throws {
    let result = try matchResult(
      declaration: "func decl_closure_394(_ p0: () -> Int..., b p1: () -> Int, c p2: () -> Int = { -1002 }) {}",
      call: "decl_closure_394() { 1000 } c: { 1001 }"
    )
    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 0)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testParenthesizedClosureArgumentMatchesLabeledClosureParameter() throws {
    let result = try matchResult(
      declaration: "func decl_closure_parenthesized_1(a p0: () -> Int, b p1: () -> Int) {}",
      call: "decl_closure_parenthesized_1(a: ({ 1000 }), b: ({ 1001 }))"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testParenthesizedClosureArgumentMatchesDefaultedClosureParameter() throws {
    let result = try matchResult(
      declaration: "func decl_closure_parenthesized_2(a p0: () -> Int = { -1000 }, b p1: () -> Int) {}",
      call: "decl_closure_parenthesized_2(a: ({ 1000 }), b: ({ 1001 }))"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
  }

  func testVariadicClosureFollowedByDefaultClosureFollowedByRequiredClosure() throws {
    let result = try matchResult(
      declaration: "func decl_closure_210(a p0: () -> Int..., a p1: () -> Int = { -1001 }, b p2: () -> Int) {}",
      call: "decl_closure_210() { 1000 } a: { 1001 } b: { 1002 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 1)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
  }

  func testPackParametersWithVariadics() throws {
    let result = try matchResult(
      declaration:
        "func decl_8012<each T1>(_ p0: Int..., c p1: repeat each T1, c p2: Int..., c p3: Int) where repeat each T1: BinaryInteger {}",
      call: "decl_8012(1000, c: 1001, 1002, c: 1003, 1004, c: 1005)"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 2)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 2)
    assertMatch(result, named: "p3", expectedIndex: 3, expectedArgumentCount: 1)
  }

  func testTwoPacksWithDefaultAndRequiredClosures() throws {
    let result = try matchResult(
      declaration:
        "func test<each T0, each T1>(a p0: repeat each T0, a p1: repeat each T1, b p2: () -> Int = { -1002 }, c p3: () -> Int) {}",
      call: "test(a: ({1000}), ({1001}), a: ({1002}), ({1003}), c: ({1004}))"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 2)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 0)
    assertMatch(result, named: "p3", expectedIndex: 3, expectedArgumentCount: 1)
  }

  func testTwoPacksWithDefaultClosuresAndExplicitLabeledClosure() throws {
    let result = try matchResult(
      declaration:
        "func test<each T0, each T1>(a p0: repeat each T0, b p1: () -> Int = { -1001 }, c p2: repeat each T1, d p3: () -> Int = { -1003 }) {}",
      call: "test(a: ({1000}), ({1001}), c: ({1002}), ({1003}), d: ({1004}))"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 2)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 0)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 2)
    assertMatch(result, named: "p3", expectedIndex: 3, expectedArgumentCount: 1)
  }

  func testTwoPacksWithDefaultClosureAndTrailingClosure() throws {
    let result = try matchResult(
      declaration:
        "func test<each T0, each T1>(a p0: repeat each T0, b p1: () -> Int = { -1001 }, c p2: repeat each T1, d p3: () -> Int) {}",
      call: "test(a: ({1000}), c: ({1001})) { 1002 }"
    )

    assertMatch(result, named: "p0", expectedIndex: 0, expectedArgumentCount: 1)
    assertMatch(result, named: "p1", expectedIndex: 1, expectedArgumentCount: 0)
    assertMatch(result, named: "p2", expectedIndex: 2, expectedArgumentCount: 1)
    assertMatch(result, named: "p3", expectedIndex: 3, expectedArgumentCount: 1)
  }

  private func matchResult(
    declaration: String,
    call: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) throws -> ArgumentMatchResult {
    let declarationTree = Parser.parse(source: declaration)
    let functionDeclaration = try XCTUnwrap(
      declarationTree.statements.first?.item.as(FunctionDeclSyntax.self),
      "Expected a function declaration",
      file: file,
      line: line
    )

    let callTree = Parser.parse(source: call)
    let functionCall = try XCTUnwrap(
      callTree.statements.first?.item.as(FunctionCallExprSyntax.self),
      "Expected a function call expression",
      file: file,
      line: line
    )

    return try XCTUnwrap(
      functionCall.matchArguments(to: functionDeclaration.signature.parameterClause.parameters),
      "Expected a match result",
      file: file,
      line: line
    )
  }

  private func assertMatch(
    _ matchResult: ArgumentMatchResult,
    named name: String,
    expectedIndex: Int,
    expectedArgumentCount: Int,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    let match = matchResult.matchForParameter(named: name)
    let indexMatch = matchResult.matchForParameter(at: expectedIndex)
    XCTAssertNotNil(match, "Expected a match for parameter '\(name)'", file: file, line: line)
    XCTAssertEqual(
      match?.parameter,
      indexMatch?.parameter,
      "Expected the match for parameter '\(name)' to be at index \(expectedIndex)",
      file: file,
      line: line
    )
    XCTAssertEqual(match?.arguments.count, expectedArgumentCount, file: file, line: line)
  }
}

private extension FunctionParameterSyntax {
  var externalArgumentLabelText: String? {
    guard firstName.tokenKind != .wildcard else {
      return nil
    }
    return firstName.text
  }
}
