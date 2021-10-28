import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class FunctionTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")

    let input = ParameterClause(parameterListBuilder: {
      FunctionParameter(firstName: TokenSyntax.wildcard, secondName: TokenSyntax.identifier("n"), colon: TokenSyntax.colon, type: SimpleTypeIdentifier("Int"), attributesBuilder: {})
    })

    let ifCodeBlock = CodeBlock(statementsBuilder: {
      ReturnStmt(expression: IntegerLiteralExpr(digits: "n"))
    })

    let signature = FunctionSignature(input: input, output: ReturnClause(returnType: SimpleTypeIdentifier("Int")))
    

    let codeBlock = CodeBlock(statementsBuilder: {
      IfStmt(conditions: ExprList([
        IntegerLiteralExpr(digits: "n"),

        BinaryOperatorExpr(operatorToken: TokenSyntax.unspacedBinaryOperator("<=")),

        IntegerLiteralExpr(1)
      ]), body: ifCodeBlock)

      ReturnStmt(expression: SequenceExpr(elementsBuilder: {
        FunctionCallExpr(calledExpression: IdentifierExpr("fibonacci"), leftParen: TokenSyntax.leftParen, rightParen: TokenSyntax.rightParen, argumentListBuilder: {
          TupleExprElement(expression: SequenceExpr(elementsBuilder: {
            IntegerLiteralExpr(digits: "n")

            BinaryOperatorExpr(operatorToken: TokenSyntax.unspacedBinaryOperator("-"))

            IntegerLiteralExpr(1)
          }))
        })

        BinaryOperatorExpr(operatorToken: TokenSyntax.spacedBinaryOperator("+"))

        FunctionCallExpr("fibonacci", leftParen: TokenSyntax.leftParen, rightParen: TokenSyntax.rightParen, argumentListBuilder: {
          TupleExprElement(expression: SequenceExpr(elementsBuilder: {
            IntegerLiteralExpr(digits: "n")

            BinaryOperatorExpr(operatorToken: TokenSyntax.unspacedBinaryOperator("-"))

            IntegerLiteralExpr(2)
          }))
        })
      }))
    })

    let buildable = FunctionDecl(identifier: TokenSyntax.identifier("fibonacci"), signature: signature, body: codeBlock, attributesBuilder: {})
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
