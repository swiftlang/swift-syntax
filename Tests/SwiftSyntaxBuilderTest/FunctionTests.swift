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
        FunctionCallExpr("fibonacci") {
          SequenceExpr {
            IntegerLiteralExpr(digits: "n")
            BinaryOperatorExpr("-")
            IntegerLiteralExpr(1)
          }
        }

        BinaryOperatorExpr("+")

        FunctionCallExpr(MemberAccessExpr(base: "self", name: "fibonacci")) {
          SequenceExpr {
            IntegerLiteralExpr(digits: "n")
            BinaryOperatorExpr("-")
            IntegerLiteralExpr(2)
          }
        }
      })
    }
    let syntax = buildable.buildSyntax()

    XCTAssertEqual(syntax.description, """
      ␣func fibonacci(_ n: Int) -> Int {
          if n <= 1 {
              return n
          }
          return fibonacci(n - 1) + self.fibonacci(n - 2)
      }
      """)
  }

  func testArguments() {
    let buildable = FunctionCallExpr("test") {
      for param in (1...5) {
        TupleExprElement(label: param.isMultiple(of: 2) ? "p\(param)" : nil, expression: "value\(param)")
      }
    }
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, "test(value1, p2: value2, value3, p4: value4, value5)")
  }

  func testParensEmittedForNoArgumentsAndNoTrailingClosure() {
    let buildable = FunctionCallExpr("test")
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, "test()")
  }

  func testParensEmittedForArgumentAndTrailingClosure() {
    let buildable = FunctionCallExpr("test", trailingClosure: ClosureExpr()) {
      TupleExprElement(expression: "42")
    }
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, "test(42) {\n}")
  }

  func testParensOmittedForNoArgumentsAndTrailingClosure() {
    let closure = ClosureExpr(statementsBuilder: {
      FunctionCallExpr("f") {
        TupleExprElement(expression: "a")
      }
    })
    let buildable = FunctionCallExpr("test", trailingClosure: closure)
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(
      syntax.description,
      """
      test {
          f(a)
      }
      """)
  }

  func testParserInterop() {
    let cases = SwitchCaseList {
      for i in 0..<2 {
        SwitchCase("""
        case \(i):
          return \(i + 1)
        """)
      }
      SwitchCase("""
      default:
        return -1
      """)
    }
    let plusOne = FunctionDeclSyntax("""
    func plusOne(base: Int) -> Int {
      switch base {
      \(cases)
      }
    }
    """)
    
    XCTAssertEqual(plusOne.description.trimmingTrailingWhitespace(), """
    func plusOne(base: Int) -> Int {
      switch base {

      case 0:
        return 1
      case 1:
        return 2
      default:
        return -1
      }
    }
    """)
  }
}
