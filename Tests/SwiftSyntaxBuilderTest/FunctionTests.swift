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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftBasicFormat
import _SwiftSyntaxTestSupport

final class FunctionTests: XCTestCase {
  func testFibonacci() throws {
    let buildable = try FunctionDeclSyntax("func fibonacci(_ n: Int) -> Int") {
      StmtSyntax("if n <= 1 { return n }")

      StmtSyntax("return fibonacci(n - 1) + self.fibonacci(n - 2)")
    }

    assertBuildResult(
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
    let testCases: [UInt: (DeclSyntax, String)] = [
      #line: (
        DeclSyntax(
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
        DeclSyntax(
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
        DeclSyntax(
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
        DeclSyntax(
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
        DeclSyntax(
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
        DeclSyntax(
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
        DeclSyntax(
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
        DeclSyntax(
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
        DeclSyntax(
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
        DeclSyntax(
          FunctionDeclSyntax(
            modifiers: [DeclModifierSyntax(name: .keyword(.public)), DeclModifierSyntax(name: .keyword(.static))],
            identifier: TokenSyntax.identifier("=="),
            signature: FunctionSignatureSyntax(
              input: ParameterClauseSyntax(
                parameterList: FunctionParameterListSyntax {
                  FunctionParameterSyntax(firstName: TokenSyntax.identifier("lhs"), colon: .colonToken(), type: TypeSyntax("String"))
                  FunctionParameterSyntax(firstName: TokenSyntax.identifier("rhs"), colon: .colonToken(), type: TypeSyntax("String"))
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
          )
        ),
        """
        public static func ==(lhs: String, rhs: String) -> Bool {
            return lhs < rhs
        }
        """
      ),
      #line: (
        DeclSyntax(
          FunctionDeclSyntax(
            modifiers: [DeclModifierSyntax(name: .keyword(.public)), DeclModifierSyntax(name: .keyword(.static))],
            identifier: TokenSyntax.identifier("=="),
            signature: FunctionSignatureSyntax(
              input: ParameterClauseSyntax(
                parameterList: FunctionParameterListSyntax {
                  FunctionParameterSyntax(firstName: TokenSyntax.identifier("lhs1"), colon: .colonToken(), type: TypeSyntax("String"))
                  FunctionParameterSyntax(firstName: TokenSyntax.identifier("lhs2"), colon: .colonToken(), type: TypeSyntax("String"))
                  FunctionParameterSyntax(firstName: TokenSyntax.identifier("rhs1"), colon: .colonToken(), type: TypeSyntax("String"))
                  FunctionParameterSyntax(firstName: TokenSyntax.identifier("rhs2"), colon: .colonToken(), type: TypeSyntax("String"))
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
          )
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
      assertBuildResult(builder, expected, line: line)
    }
  }

  func testArguments() {
    let buildable = FunctionCallExprSyntax(callee: ExprSyntax("test")) {
      for param in (1...5) {
        TupleExprElementSyntax(label: param.isMultiple(of: 2) ? "p\(param)" : nil, expression: ExprSyntax("value\(raw: param)"))
      }
    }
    assertBuildResult(buildable, "test(value1, p2: value2, value3, p4: value4, value5)")
  }

  func testFunctionDeclBuilder() {
    let builder = DeclSyntax(
      """
      func test(_ p1: Int, p2: Int, _ p3: Int, p4: Int, _ p5: Int) -> Int {
          return p1 + p2 + p3 + p4 + p5
      }
      """
    )

    assertBuildResult(
      builder,
      """
      func test(_ p1: Int, p2: Int, _ p3: Int, p4: Int, _ p5: Int) -> Int {
          return p1 + p2 + p3 + p4 + p5
      }
      """
    )
  }

  func testMultilineFunctionParameterList() {
    let builder = DeclSyntax(
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

    assertBuildResult(
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
    let builder = ExprSyntax(
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

    assertBuildResult(
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
    assertBuildResult(buildable, "test()")
  }

  func testParensEmittedForArgumentAndTrailingClosure() {
    let buildable = FunctionCallExprSyntax(callee: ExprSyntax("test"), trailingClosure: ClosureExprSyntax {}) {
      TupleExprElementSyntax(expression: ExprSyntax("42"))
    }
    assertBuildResult(buildable, "test(42) {\n}")
  }

  func testParensOmittedForNoArgumentsAndTrailingClosure() {
    let closure = ClosureExprSyntax(statementsBuilder: {
      FunctionCallExprSyntax(callee: ExprSyntax("f")) {
        TupleExprElementSyntax(expression: ExprSyntax("a"))
      }
    })
    let buildable = FunctionCallExprSyntax(callee: ExprSyntax("test"), trailingClosure: closure)

    assertBuildResult(
      buildable,
      """
      test {
          f(a)
      }
      """
    )
  }
}
