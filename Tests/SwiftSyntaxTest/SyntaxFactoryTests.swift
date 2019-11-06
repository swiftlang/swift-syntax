import XCTest
import SwiftSyntax

fileprivate func cannedStructDecl() -> StructDeclSyntax {
  let structKW = SyntaxFactory.makeStructKeyword(trailingTrivia: .spaces(1))
  let fooID = SyntaxFactory.makeIdentifier("Foo", trailingTrivia: .spaces(1))
  let rBrace = SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1))
  let members = MemberDeclBlockSyntax {
    $0.useLeftBrace(SyntaxFactory.makeLeftBraceToken())
    $0.useRightBrace(rBrace)
  }
  return StructDeclSyntax {
    $0.useStructKeyword(structKW)
    $0.useIdentifier(fooID)
    $0.useMembers(members)
  }
}

public class SyntaxFactoryTests: XCTestCase {

  public func testGenerated() {

    let structDecl = cannedStructDecl()

    XCTAssertEqual("\(structDecl)",
                   """
                   struct Foo {
                   }
                   """)

    let forType = SyntaxFactory.makeIdentifier("`for`",
                                               leadingTrivia: [],
                                               trailingTrivia: [
                                                 .spaces(1)
                                               ])
    let newBrace = SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(2))

    let renamed = structDecl.withIdentifier(forType)
                            .withMembers(structDecl.members
                                                   .withRightBrace(newBrace))

    XCTAssertEqual("\(renamed)",
                   """
                   struct `for` {

                   }
                   """)

    XCTAssertNotEqual(structDecl.members, renamed.members)
    XCTAssertEqual(structDecl, StructDeclSyntax(structDecl.root))
    XCTAssertNil(structDecl.parent)
    XCTAssertNotNil(structDecl.members.parent)
    XCTAssertEqual(structDecl.members.parent.map(StructDeclSyntax.init), structDecl)

    XCTAssertEqual("\(structDecl.members.rightBrace)",
                   """

                   }
                   """)
  }

  public func testTokenSyntax() {
    let tok = SyntaxFactory.makeStructKeyword()
    XCTAssertEqual("\(tok)", "struct")
    XCTAssertTrue(tok.isPresent)

    let preSpacedTok = tok.withLeadingTrivia(.spaces(3))
    XCTAssertEqual("\(preSpacedTok)", "   struct")

    var mutablePreSpacedTok = tok
    mutablePreSpacedTok.leadingTrivia = .spaces(4)
    XCTAssertEqual("\(mutablePreSpacedTok)", "    struct")

    let postSpacedTok = tok.withTrailingTrivia(.spaces(6))
    XCTAssertEqual("\(postSpacedTok)", "struct      ")

    var mutablePostSpacedTok = tok
    mutablePostSpacedTok.trailingTrivia = .spaces(3)
    XCTAssertEqual("\(mutablePostSpacedTok)", "struct   ")

    let prePostSpacedTok = preSpacedTok.withTrailingTrivia(.spaces(4))
    XCTAssertEqual("\(prePostSpacedTok)", "   struct    ")

    mutablePreSpacedTok.trailingTrivia = .spaces(2)
    XCTAssertEqual("\(mutablePreSpacedTok)", "    struct  ")
  }

  public func testFunctionCallSyntaxBuilder() {
    let string = SyntaxFactory.makeStringLiteralExpr("Hello, world!")
    let printID = SyntaxFactory.makeVariableExpr("print")
    let arg = TupleExprElementSyntax {
      $0.useExpression(ExprSyntax(string))
    }
    let call = FunctionCallExprSyntax {
      $0.useCalledExpression(ExprSyntax(printID))
      $0.useLeftParen(SyntaxFactory.makeLeftParenToken())
      $0.addArgument(arg)
      $0.useRightParen(SyntaxFactory.makeRightParenToken())
    }
    XCTAssertEqual("\(call)", "print(\"Hello, world!\")")

    let terminatorArg = TupleExprElementSyntax {
      $0.useLabel(SyntaxFactory.makeIdentifier("terminator"))
      $0.useColon(SyntaxFactory.makeColonToken(trailingTrivia: .spaces(1)))
      $0.useExpression(ExprSyntax(SyntaxFactory.makeStringLiteralExpr(" ")))
    }
    let callWithTerminator = call.withArgumentList(
      SyntaxFactory.makeTupleExprElementList([
        arg.withTrailingComma(
          SyntaxFactory.makeCommaToken(trailingTrivia: .spaces(1))),
        terminatorArg
      ])
    )

    XCTAssertEqual("\(callWithTerminator)",
                   "print(\"Hello, world!\", terminator: \" \")")
  }

  public func testWithOptionalChild() {
    let string = SyntaxFactory.makeStringLiteralExpr("Hello, world!")
    let printID = SyntaxFactory.makeVariableExpr("print")
    let arg = TupleExprElementSyntax {
      $0.useExpression(ExprSyntax(string))
    }
    let call1 = FunctionCallExprSyntax {
      $0.useCalledExpression(ExprSyntax(printID))
      $0.useLeftParen(SyntaxFactory.makeLeftParenToken())
      $0.addArgument(arg)
      $0.useRightParen(SyntaxFactory.makeRightParenToken())
    }
    XCTAssertNotNil(call1.leftParen)
    XCTAssertNotNil(call1.rightParen)

    let call2 = call1.withLeftParen(nil).withRightParen(nil)
    XCTAssertNil(call2.leftParen)
    XCTAssertNil(call2.rightParen)

    let call3 = FunctionCallExprSyntax {
      $0.useCalledExpression(ExprSyntax(printID))
      $0.addArgument(arg)
    }
    XCTAssertNil(call3.leftParen)
    XCTAssertNil(call3.rightParen)
  }

  public func testUnknownSyntax() {
    let expr = SyntaxFactory.makeStringLiteralExpr("Hello, world!")
    XCTAssertFalse(expr.isUnknown)
    let unknown = SyntaxFactory.makeUnknownSyntax(
      tokens: [SyntaxFactory.makeLeftBraceToken()])
    XCTAssertTrue(unknown.isUnknown)
    XCTAssertNoThrow(try SyntaxVerifier.verify(Syntax(expr)))
    XCTAssertThrowsError(try SyntaxVerifier.verify(Syntax(unknown)))
  }

  public func testMakeStringLiteralExpr() {
    let expr = SyntaxFactory.makeStringLiteralExpr(
      "Hello, world!",
      leadingTrivia: .init(pieces: [.lineComment("// hello"), .newlines(1)])
    )
    let expected = """
// hello
"Hello, world!"
"""
    XCTAssertEqual(expr.description, expected)
  }
    
  public func testMakeBinaryOperator() {
    let first = IntegerLiteralExprSyntax {
      $0.useDigits(SyntaxFactory.makeIntegerLiteral("1", trailingTrivia: .spaces(1)))
    }
    let second = IntegerLiteralExprSyntax {
      $0.useDigits(SyntaxFactory.makeIntegerLiteral("1"))
    }
    let operatorNames = ["==", "!=", "+", "-", "*", "/", "<", ">", "<=", ">="]
    operatorNames.forEach { operatorName in
      let operatorToken = SyntaxFactory.makeBinaryOperator(operatorName, trailingTrivia: .spaces(1))
      let operatorExpr = BinaryOperatorExprSyntax {
        $0.useOperatorToken(operatorToken)
      }
      let exprList = SyntaxFactory.makeExprList([ExprSyntax(first),
                                                 ExprSyntax(operatorExpr),
                                                 ExprSyntax(second)])

      XCTAssertEqual("\(exprList)", "1 \(operatorName) 1")
    }
  }
}
