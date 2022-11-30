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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftBasicFormat
import _SwiftSyntaxTestSupport

final class FunctionTests: XCTestCase {
  func testFibonacci() {
    let buildable = FunctionDecl("func fibonacci(_ n: Int) -> Int") {
      IfStmt("if n <= 1 { return n }")

      ReturnStmt("return fibonacci(n - 1) + self.fibonacci(n - 2)")
    }

    AssertBuildResult(buildable, """
      func fibonacci(_ n: Int) -> Int {
          if n <= 1 {
              return n
          }
          return fibonacci(n - 1) + self.fibonacci(n - 2)
      }
      """)
  }

  func testArguments() {
    let buildable = FunctionCallExpr(callee: "test") {
      for param in (1...5) {
        TupleExprElement(label: param.isMultiple(of: 2) ? "p\(param)" : nil, expression: "value\(raw: param)")
      }
    }
    AssertBuildResult(buildable, "test(value1, p2: value2, value3, p4: value4, value5)")
  }

  func testParensEmittedForNoArgumentsAndNoTrailingClosure() {
    let buildable = FunctionCallExpr(callee: "test")
    AssertBuildResult(buildable, "test()")
  }

  func testParensEmittedForArgumentAndTrailingClosure() {
    let buildable = FunctionCallExpr(callee: "test", trailingClosure: ClosureExpr()) {
      TupleExprElement(expression: "42")
    }
    AssertBuildResult(buildable, "test(42) {\n}")
  }

  func testParensOmittedForNoArgumentsAndTrailingClosure() {
    let closure = ClosureExpr(statementsBuilder: {
      FunctionCallExpr(callee: "f") {
        TupleExprElement(expression: "a")
      }
    })
    let buildable = FunctionCallExpr(callee: "test", trailingClosure: closure)

    AssertBuildResult(
      buildable,
      """
      test {
          f(a)
      }
      """)
  }
}
