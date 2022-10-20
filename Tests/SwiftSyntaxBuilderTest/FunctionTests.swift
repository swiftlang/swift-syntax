import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftBasicFormat
import _SwiftSyntaxTestSupport

final class FunctionTests: XCTestCase {
  func testFibonacci() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let input = ParameterClause {
      FunctionParameter(firstName: .wildcard, secondName: .identifier("n"), colon: .colon, type: "Int")
    }

    let ifCodeBlock = ReturnStmt(expression: IntegerLiteralExpr(digits: "n"))
    
    let signature = FunctionSignature(input: input, output: "Int")
    
    let buildable = FunctionDecl(leadingTrivia: leadingTrivia, identifier: .identifier("fibonacci"), signature: signature) {
      IfStmt(
        conditions: ExprList {
          IntegerLiteralExpr(digits: "n")
          BinaryOperatorExpr("<=")
          IntegerLiteralExpr(1)
        },
        body: ifCodeBlock)

      ReturnStmt(expression: SequenceExpr {
        FunctionCallExpr(calledExpression: "fibonacci") {
          SequenceExpr {
            IntegerLiteralExpr(digits: "n")
            BinaryOperatorExpr("-")
            IntegerLiteralExpr(1)
          }
        }

        BinaryOperatorExpr("+")

        FunctionCallExpr(calledExpression: MemberAccessExpr(base: "self", name: "fibonacci")) {
          SequenceExpr {
            IntegerLiteralExpr(digits: "n")
            BinaryOperatorExpr("-")
            IntegerLiteralExpr(2)
          }
        }
      })
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
    let buildable = FunctionCallExpr(calledExpression: "test") {
      for param in (1...5) {
        TupleExprElement(label: param.isMultiple(of: 2) ? "p\(param)" : nil, expression: "value\(param)")
      }
    }
    AssertBuildResult(buildable, "test(value1, p2: value2, value3, p4: value4, value5)")
  }

  func testParensEmittedForNoArgumentsAndNoTrailingClosure() {
    let buildable = FunctionCallExpr(calledExpression: "test")
    AssertBuildResult(buildable, "test()")
  }

  func testParensEmittedForArgumentAndTrailingClosure() {
    let buildable = FunctionCallExpr(calledExpression: "test", trailingClosure: ClosureExpr()) {
      TupleExprElement(expression: "42")
    }
    AssertBuildResult(buildable, "test(42) {\n}")
  }

  func testParensOmittedForNoArgumentsAndTrailingClosure() {
    let closure = ClosureExpr(statementsBuilder: {
      FunctionCallExpr(calledExpression: "f") {
        TupleExprElement(expression: "a")
      }
    })
    let buildable = FunctionCallExpr(calledExpression: "test", trailingClosure: closure)
    AssertBuildResult(
      buildable,
      """
      test {
          f(a)
      }
      """)
  }
}
