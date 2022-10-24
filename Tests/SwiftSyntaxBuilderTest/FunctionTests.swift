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
    let leadingTrivia = Trivia.unexpectedText("␣")

    let input = ParameterClause {
      FunctionParameter(firstName: .wildcard, secondName: .identifier("n"), colon: .colon, type: Type("Int"))
    }

    let signature = FunctionSignature(input: input, output: ReturnClause(returnType: Type("Int")))
    
    let buildable = FunctionDecl(leadingTrivia: leadingTrivia, identifier: .identifier("fibonacci"), signature: signature) {
      IfStmt("if n <= 1 { return n }")

      ReturnStmt("return fibonacci(n - 1) + self.fibonacci(n - 2)")
    }

    AssertBuildResult(buildable, """
      ␣func fibonacci(_ n: Int) -> Int {
          if n <= 1 {
              return n
          }
          return fibonacci(n - 1) + self.fibonacci(n - 2)
      }
      """)
  }

  func testArguments() {
    let buildable = FunctionCallExpr(calledExpression: Expr("test")) {
      for param in (1...5) {
        TupleExprElement(label: param.isMultiple(of: 2) ? "p\(param)" : nil, expression: "value\(param)")
      }
    }
    AssertBuildResult(buildable, "test(value1, p2: value2, value3, p4: value4, value5)")
  }

  func testParensEmittedForNoArgumentsAndNoTrailingClosure() {
    let buildable = FunctionCallExpr(calledExpression: Expr("test"))
    AssertBuildResult(buildable, "test()")
  }

  func testParensEmittedForArgumentAndTrailingClosure() {
    let buildable = FunctionCallExpr(calledExpression: Expr("test"), trailingClosure: ClosureExpr()) {
      TupleExprElement(expression: "42")
    }
    AssertBuildResult(buildable, "test(42) {\n}")
  }

  func testParensOmittedForNoArgumentsAndTrailingClosure() {
    let closure = ClosureExpr(statementsBuilder: {
      FunctionCallExpr(calledExpression: Expr("f")) {
        TupleExprElement(expression: "a")
      }
    })
    let buildable = FunctionCallExpr(calledExpression: Expr("test"), trailingClosure: closure)

    AssertBuildResult(
      buildable,
      """
      test {
          f(a)
      }
      """)
  }
}
