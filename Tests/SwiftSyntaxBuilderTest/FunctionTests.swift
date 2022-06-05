import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class FunctionTests: XCTestCase {
  func testFibonacci() {
    let leadingTrivia = Trivia.garbageText("␣")

    let input = ParameterClause(parameterListBuilder: {
      FunctionParameter(firstName: .wildcard, secondName: .identifier("n"), colon: .colon, type: "Int", attributesBuilder: {})
    })

    let ifCodeBlock = ReturnStmt(expression: IntegerLiteralExpr(digits: "n"))
    
    let signature = FunctionSignature(input: input, output: "Int")
    
    let codeBlock = CodeBlock(statementsBuilder: {
      IfStmt(conditions: ExprList([
        IntegerLiteralExpr(digits: "n"),

        BinaryOperatorExpr("<="),

        IntegerLiteralExpr(1)
      ]), body: ifCodeBlock)

      ReturnStmt(expression: SequenceExpr(elementsBuilder: {
        FunctionCallExpr("fibonacci", argumentListBuilder: {
          TupleExprElement(expression: SequenceExpr(elementsBuilder: {
            IntegerLiteralExpr(digits: "n")

            BinaryOperatorExpr("-")

            IntegerLiteralExpr(1)
          }))
        })

        BinaryOperatorExpr("+")

        FunctionCallExpr(MemberAccessExpr(base: "self", name: "fibonacci"), argumentListBuilder: {
          TupleExprElement(expression: SequenceExpr(elementsBuilder: {
            IntegerLiteralExpr(digits: "n")

            BinaryOperatorExpr("-")

            IntegerLiteralExpr(2)
          }))
        })
      }))
    })

    let buildable = FunctionDecl(identifier: .identifier("fibonacci"), signature: signature, body: codeBlock, attributesBuilder: {})
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    XCTAssertEqual(syntax.description, """
      ␣func fibonacci(_ n: Int)-> Int{
          if n <= 1{
              return n
          }
          return fibonacci(n - 1) + self.fibonacci(n - 2)
      }
      """)
  }

  func testParensEmittedForNoArgumentsAndNoTrailingClosure() {
    let buildable = FunctionCallExpr("test")
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, "test()")
  }

  func testParensEmittedForArgumentAndTrailingClosure() {
    let buildable = FunctionCallExpr("test", trailingClosure: ClosureExpr(), argumentListBuilder: {
      TupleExprElement(expression: "42")
    })
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, "test(42){}")
  }

  func testParensOmittedForNoArgumentsAndTrailingClosure() {
    let buildable = FunctionCallExpr("test", trailingClosure: ClosureExpr())
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, "test{}")
  }
}
