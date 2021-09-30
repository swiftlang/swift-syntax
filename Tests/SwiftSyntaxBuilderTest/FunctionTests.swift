import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class FunctionTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")

    let input = ParameterClause(parameterListBuilder: {
      FunctionParameter(firstName: .wildcard, secondName: .identifier("n"), colon: .colon, type: SimpleTypeIdentifier("Int"), attributesBuilder: {})
    })

    let ifCodeBlock = CodeBlock(statementsBuilder: {
      ReturnStmt(expression: SequenceExpr(elementsBuilder: {
        IntegerLiteralExpr(digits: "n")
      }))
    })

    let signature = FunctionSignature(input: input, output: ReturnClause(returnType: SimpleTypeIdentifier("Int")))
    

    let codeBlock = CodeBlock(statementsBuilder: {
      IfStmt(labelName: nil, body: ifCodeBlock, conditionsBuilder: {
        ConditionElement(condition: ExprList([
          IntegerLiteralExpr(digits: "n"),

          BinaryOperatorExpr(operatorToken: .unspacedBinaryOperator("<=")),

          IntegerLiteralExpr(1)
        ]))
      })

      ReturnStmt(expression: SequenceExpr(elementsBuilder: {
        FunctionCallExpr(calledExpression: IdentifierExpr(identifier: .identifier("fibonacci")), leftParen: .leftParen, rightParen: .rightParen, argumentListBuilder: {
          TupleExprElement(expression: SequenceExpr(elementsBuilder: {
            IntegerLiteralExpr(digits: "n")

            BinaryOperatorExpr(operatorToken: .unspacedBinaryOperator("-"))

            IntegerLiteralExpr(1)
          }))
        })

        BinaryOperatorExpr(operatorToken: .spacedBinaryOperator("+"))

        FunctionCallExpr(calledExpression: IdentifierExpr(identifier: .identifier("fibonacci")), leftParen: .leftParen, rightParen: .rightParen, argumentListBuilder: {
          TupleExprElement(expression: SequenceExpr(elementsBuilder: {
            IntegerLiteralExpr(digits: "n")

            BinaryOperatorExpr(operatorToken: .unspacedBinaryOperator("-"))

            IntegerLiteralExpr(2)
          }))
        })
      }))
    })

    let buildable = FunctionDecl(identifier: .identifier("fibonacci"), signature: signature, body: codeBlock, attributesBuilder: {})
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    XCTAssertEqual(syntax.description, """
      func fibonacci(_ n: Int)-> Int{
          if n<=1{
              return n
          }
          return fibonacci(n-1)+fibonacci(n-2)
      }
      """)
  }
}
