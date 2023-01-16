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
    let buildable = FunctionDeclSyntax("func fibonacci(_ n: Int) -> Int") {
      IfStmtSyntax("if n <= 1 { return n }")

      ReturnStmtSyntax("return fibonacci(n - 1) + self.fibonacci(n - 2)")
    }

    AssertBuildResult(
      buildable,
      """
      func fibonacci(_ n: Int) -> Int {
          if n <= 1 {
              return n
          }
          return fibonacci(n - 1) + self.fibonacci(n - 2)
      }
      """
    )
  }

  func testFunctionDeclEnsurePropperSpacing() {
    let testCases: [UInt: (FunctionDeclSyntax, String)] = [
      #line: (
        FunctionDeclSyntax(
          """
          @available(*, deprecated, message: "Use function on Baz")
          private func visitChildren<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) {
          }
          """
        ),
        """
        @available(*, deprecated, message: "Use function on Baz")
        private func visitChildren<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) {
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          """
          public static func == (lhs: String, rhs: String) -> Bool {
            return lhs < rhs
          }
          """
        ),
        """
        public static func == (lhs: String, rhs: String) -> Bool {
            return lhs < rhs
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          """
          public static func == (lhs: String, rhs: String) -> Bool {
            return lhs > rhs
          }
          """
        ),
        """
        public static func == (lhs: String, rhs: String) -> Bool {
            return lhs > rhs
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          """
          public static func == (lhs1: String, lhs2: String, rhs1: String, rhs2: String) -> Bool {
            return (lhs1, lhs2) > (rhs1, rhs2)
          }
          """
        ),
        """
        public static func == (lhs1: String, lhs2: String, rhs1: String, rhs2: String) -> Bool {
            return (lhs1, lhs2) > (rhs1, rhs2)
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          """
          public func foo<Generic>(input: Bas) -> Foo<Generic> {
            return input as Foo<Generic>!
          }
          """
        ),
        """
        public func foo<Generic>(input: Bas) -> Foo<Generic> {
            return input as Foo<Generic>!
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          """
          public func foo<Generic>(input: Bas) -> Foo<Generic?> {
            return input as Foo<Generic?>!
          }
          """
        ),
        """
        public func foo<Generic>(input: Bas) -> Foo<Generic?> {
            return input as Foo<Generic?>!
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          """
          public func foo<Generic>(input: [Bar]) -> Foo<[Bar]> {
            return input
          }
          """
        ),
        """
        public func foo<Generic>(input: [Bar]) -> Foo<[Bar]> {
            return input
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          """
          public func foo(myOptionalClosure: MyClosure?)  {
            myOptionalClosure!()
          }
          """
        ),
        """
        public func foo(myOptionalClosure: MyClosure?)  {
            myOptionalClosure!()
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          """
          public func foo(myOptionalValue: String?, myOtherOptionalValue: [String?])  {
          }
          """
        ),
        """
        public func foo(myOptionalValue: String?, myOtherOptionalValue: [String?])  {
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          modifiers: [DeclModifierSyntax(name: .keyword(.public)), DeclModifierSyntax(name: .keyword(.static))],
          identifier: TokenSyntax.identifier("=="),
          signature: FunctionSignatureSyntax(
            input: ParameterClauseSyntax(
              parameterList: FunctionParameterListSyntax {
                FunctionParameterSyntax(firstName: TokenSyntax.identifier("lhs"), colon: .colonToken(), type: SimpleTypeIdentifierSyntax("String"))
                FunctionParameterSyntax(firstName: TokenSyntax.identifier("rhs"), colon: .colonToken(), type: SimpleTypeIdentifierSyntax("String"))
              }
            ),
            output: ReturnClauseSyntax(
              returnType: SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Bool"))
            )
          ),
          bodyBuilder: {
            ReturnStmtSyntax(
              expression: SequenceExprSyntax(
                elements: ExprListSyntax {
                  IdentifierExprSyntax(identifier: .identifier("lhs"))
                  BinaryOperatorExprSyntax(operatorToken: .binaryOperator("<"))
                  IdentifierExprSyntax(identifier: .identifier("rhs"))
                }
              )
            )
          }
        ),
        """
        public static func ==(lhs: String, rhs: String) -> Bool {
            return lhs < rhs
        }
        """
      ),
      #line: (
        FunctionDeclSyntax(
          modifiers: [DeclModifierSyntax(name: .keyword(.public)), DeclModifierSyntax(name: .keyword(.static))],
          identifier: TokenSyntax.identifier("=="),
          signature: FunctionSignatureSyntax(
            input: ParameterClauseSyntax(
              parameterList: FunctionParameterListSyntax {
                FunctionParameterSyntax(firstName: TokenSyntax.identifier("lhs1"), colon: .colonToken(), type: SimpleTypeIdentifierSyntax("String"))
                FunctionParameterSyntax(firstName: TokenSyntax.identifier("lhs2"), colon: .colonToken(), type: SimpleTypeIdentifierSyntax("String"))
                FunctionParameterSyntax(firstName: TokenSyntax.identifier("rhs1"), colon: .colonToken(), type: SimpleTypeIdentifierSyntax("String"))
                FunctionParameterSyntax(firstName: TokenSyntax.identifier("rhs2"), colon: .colonToken(), type: SimpleTypeIdentifierSyntax("String"))
              }
            ),
            output: ReturnClauseSyntax(
              returnType: SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Bool"))
            )
          ),
          bodyBuilder: {
            ReturnStmtSyntax(
              expression: SequenceExprSyntax(
                elements: ExprListSyntax {
                  ExprSyntax("(lhs1, lhs2)")
                  BinaryOperatorExprSyntax(operatorToken: .binaryOperator("<"))
                  ExprSyntax("(rhs1, rhs2)")
                }
              )
            )
          }
        ),
        """
        public static func ==(lhs1: String, lhs2: String, rhs1: String, rhs2: String) -> Bool {
            return (lhs1, lhs2) < (rhs1, rhs2)
        }
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }

  func testArguments() {
    let buildable = FunctionCallExprSyntax(callee: ExprSyntax("test")) {
      for param in (1...5) {
        TupleExprElementSyntax(label: param.isMultiple(of: 2) ? "p\(param)" : nil, expression: ExprSyntax("value\(raw: param)"))
      }
    }
    AssertBuildResult(buildable, "test(value1, p2: value2, value3, p4: value4, value5)")
  }

  func testFunctionDeclBuilder() {
    let builder = FunctionDeclSyntax(
      """
      func test(_ p1: Int, p2: Int, _ p3: Int, p4: Int, _ p5: Int) -> Int {
          return p1 + p2 + p3 + p4 + p5
      }
      """
    )

    AssertBuildResult(
      builder,
      """
      func test(_ p1: Int, p2: Int, _ p3: Int, p4: Int, _ p5: Int) -> Int {
          return p1 + p2 + p3 + p4 + p5
      }
      """
    )
  }

  func testMultilineFunctionParameterList() {
    let builder = FunctionDeclSyntax(
      """
      func test(
        _ p1: Int,
        p2: Int,
        _ p3: Int,
        p4: Int,
        _ p5: Int
      ) -> Int {
        return p1 + p2 + p3 + p4 + p5
      }
      """
    )

    AssertBuildResult(
      builder,
      """
      func test(
          _ p1: Int,
          p2: Int,
          _ p3: Int,
          p4: Int,
          _ p5: Int
      ) -> Int {
          return p1 + p2 + p3 + p4 + p5
      }
      """
    )
  }

  func testMultilineFunctionCallExpr() {
    let builder = FunctionCallExprSyntax(
      """
      test(
      p1: value1,
      p2: value2,
      p3: value3,
      p4: value4,
      p5: value5
      )
      """
    )

    AssertBuildResult(
      builder,
      """
      test(
          p1: value1,
          p2: value2,
          p3: value3,
          p4: value4,
          p5: value5
      )
      """
    )
  }

  func testParensEmittedForNoArgumentsAndNoTrailingClosure() {
    let buildable = FunctionCallExprSyntax(callee: ExprSyntax("test"))
    AssertBuildResult(buildable, "test()")
  }

  func testParensEmittedForArgumentAndTrailingClosure() {
    let buildable = FunctionCallExprSyntax(callee: ExprSyntax("test"), trailingClosure: ClosureExprSyntax()) {
      TupleExprElementSyntax(expression: ExprSyntax("42"))
    }
    AssertBuildResult(buildable, "test(42) {\n}")
  }

  func testParensOmittedForNoArgumentsAndTrailingClosure() {
    let closure = ClosureExprSyntax(statementsBuilder: {
      FunctionCallExprSyntax(callee: ExprSyntax("f")) {
        TupleExprElementSyntax(expression: ExprSyntax("a"))
      }
    })
    let buildable = FunctionCallExprSyntax(callee: ExprSyntax("test"), trailingClosure: closure)

    AssertBuildResult(
      buildable,
      """
      test {
          f(a)
      }
      """
    )
  }
}
