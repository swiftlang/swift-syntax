import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class FunctionTests: XCTestCase {
  func testFibonacci() {
    let leadingTrivia = Trivia.garbageText("␣")

    let input = ParameterClause(parameterList: [
      FunctionParameter(firstName: .wildcard, secondName: .identifier("n"), colon: .colon, type: "Int")
    ])

    let ifCodeBlock = ReturnStmt(expression: IntegerLiteralExpr(digits: "n"))
    
    let signature = FunctionSignature(input: input, output: "Int")
    
    let buildable = FunctionDecl(identifier: .identifier("fibonacci"), signature: signature) {
      IfStmt(conditions: ExprList([
        IntegerLiteralExpr(digits: "n"),
        BinaryOperatorExpr("<="),
        IntegerLiteralExpr(1),
      ]), body: ifCodeBlock)

      ReturnStmt(expression: SequenceExpr(elements: ExprList([
        FunctionCallExpr("fibonacci") {
          SequenceExpr(elements: ExprList([
            IntegerLiteralExpr(digits: "n"),
            BinaryOperatorExpr("-"),
            IntegerLiteralExpr(1),
          ]))
        },

        BinaryOperatorExpr("+"),

        FunctionCallExpr(MemberAccessExpr(base: "self", name: "fibonacci")) {
          SequenceExpr(elements: ExprList([
            IntegerLiteralExpr(digits: "n"),
            BinaryOperatorExpr("-"),
            IntegerLiteralExpr(2),
          ]))
        },
      ])))
    }
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    XCTAssertEqual(syntax.description, """
      ␣func fibonacci(_ n: Int)-> Int {
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
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, "test(value1, p2: value2, value3, p4: value4, value5)")
  }

  func testParensEmittedForNoArgumentsAndNoTrailingClosure() {
    let buildable = FunctionCallExpr("test")
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, "test()")
  }

  func testParensEmittedForArgumentAndTrailingClosure() {
    let buildable = FunctionCallExpr("test", trailingClosure: ClosureExpr()) {
      TupleExprElement(expression: "42")
    }
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, "test(42) {\n}")
  }

  func testParensOmittedForNoArgumentsAndTrailingClosure() {
    let closure = ClosureExpr(statementsBuilder: {
      FunctionCallExpr("f") {
        TupleExprElement(expression: "a")
      }
    })
    let buildable = FunctionCallExpr("test", trailingClosure: closure)
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(
      syntax.description,
      """
      test {
          f(a)
      }
      """)
  }
}
