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

import SwiftParser
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class InlineFunctionCallTests: XCTestCase {
  private func functionCallExpr(from markedText: String) throws -> FunctionCallExprSyntax {
    let (markers, source) = extractMarkers(markedText)
    let startOffset = markers["1️⃣"] ?? markers["DEFAULT"] ?? 0

    class FunctionCallFinder: SyntaxAnyVisitor {
      let startOffset: Int
      var found: FunctionCallExprSyntax?

      init(startOffset: Int) {
        self.startOffset = startOffset
        super.init(viewMode: .all)
      }

      override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        if found != nil || node.endPosition.utf8Offset < startOffset {
          return .skipChildren
        }

        if node.positionAfterSkippingLeadingTrivia.utf8Offset >= startOffset,
          let call = node.as(FunctionCallExprSyntax.self)
        {
          found = call
          return .skipChildren
        }

        return .visitChildren
      }
    }

    let finder = FunctionCallFinder(startOffset: startOffset)
    finder.walk(Syntax(Parser.parse(source: source)))
    return try XCTUnwrap(
      finder.found,
      "Could not find function call expression after marker",
      file: #file,
      line: #line
    )
  }

  // MARK: - Basic Expression Inlining

  func testInlineSimpleFunctionExpression() throws {
    let input = try functionCallExpr(
      from: """
        func double(_ x: Int) -> Int {
          return x * 2
        }

        func example() {
          let result = 1️⃣double(5)
        }
        """
    )

    let expected: ExprSyntax = "5 * 2"

    try assertRefactor(
      input,
      context: (),
      provider: InlineFunctionCall.self,
      expected: expected
    )
  }

  func testInlineMultipleParametersExpression() throws {
    let input = try functionCallExpr(
      from: """
        func add(_ a: Int, _ b: Int) -> Int {
          return a + b
        }

        func example() {
          let result = 1️⃣add(10, 20)
        }
        """
    )

    let expected: ExprSyntax = "10 + 20"

    try assertRefactor(
      input,
      context: (),
      provider: InlineFunctionCall.self,
      expected: expected
    )
  }

  // MARK: - Closure Wrapping Cases

  func testInlineMultiStatementFunction() throws {
    let input = try functionCallExpr(
      from: """
        func compute(_ x: Int) -> Int {
          let y = x + 1
          return y
        }

        func example() {
          let result = 1️⃣compute(5)
        }
        """
    )

    let result = try InlineFunctionCall.refactor(syntax: input, in: ())

    XCTAssertTrue(result.description.contains("let y = 5 + 1"))
    XCTAssertTrue(result.description.contains("return y"))
    XCTAssertTrue(result.description.contains("()"))
  }

  func testInlineVoidFunction() throws {
    let input = try functionCallExpr(
      from: """
        func log(_ x: Int) {
          print(x)
        }

        func example() {
          1️⃣log(5)
        }
        """
    )

    let result = try InlineFunctionCall.refactor(syntax: input, in: ())

    XCTAssertTrue(result.description.contains("print(5)"))
    XCTAssertTrue(result.description.contains("()"))
  }

  // MARK: - Edge Cases

  func testInlineExpressionBodyFunction() throws {
    let input = try functionCallExpr(
      from: """
        func double(_ x: Int) -> Int { x * 2 }

        func example() {
          let result = 1️⃣double(5)
        }
        """
    )

    let result = try InlineFunctionCall.refactor(syntax: input, in: ())

    XCTAssertTrue(result.description.contains("5 * 2"))
  }

  func testParameterUsedMultipleTimes() throws {
    let input = try functionCallExpr(
      from: """
        func square(_ x: Int) -> Int {
          return x * x
        }

        func example() {
          let result = 1️⃣square(5)
        }
        """
    )

    let result = try InlineFunctionCall.refactor(syntax: input, in: ())
    let output = result.description

    let count = output.components(separatedBy: "5").count - 1
    XCTAssertGreaterThanOrEqual(count, 2)
  }

  func testFunctionDefinedAfterCall() throws {
    let input = try functionCallExpr(
      from: """
        func example() {
          let result = 1️⃣increment(5)
        }

        func increment(_ x: Int) -> Int {
          return x + 1
        }
        """
    )

    let expected: ExprSyntax = "5 + 1"

    try assertRefactor(
      input,
      context: (),
      provider: InlineFunctionCall.self,
      expected: expected
    )
  }

  // MARK: - Tests to log error

  func testFunctionNotFound() throws {
    let input = try functionCallExpr(
      from: """
        func example() {
          let result = 1️⃣unknown(5)
        }
        """
    )

    XCTAssertThrowsError(
      try InlineFunctionCall.refactor(syntax: input, in: ())
    )
  }

  func testMethodCallShouldFail() throws {
    let input = try functionCallExpr(
      from: """
        struct A {
          func foo() {}
        }

        let a = A()
        1️⃣a.foo()
        """
    )

    XCTAssertThrowsError(
      try InlineFunctionCall.refactor(syntax: input, in: ())
    )
  }

  func testFewerArgumentsThanParameters() throws {
    let input = try functionCallExpr(
      from: """
        func add(_ a: Int, _ b: Int) -> Int {
          return a + b
        }

        func example() {
          let result = 1️⃣add(5)
        }
        """
    )

    let result = try InlineFunctionCall.refactor(syntax: input, in: ())

    XCTAssertTrue(result.description.contains("5"))
    XCTAssertTrue(result.description.contains("b"))
  }
}
