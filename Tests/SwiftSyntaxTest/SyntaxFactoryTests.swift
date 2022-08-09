import XCTest
import SwiftSyntax

fileprivate func cannedStructDecl() -> StructDeclSyntax {
  let structKW = SyntaxFactory.makeStructKeyword(trailingTrivia: .space)
  let fooID = SyntaxFactory.makeIdentifier("Foo")
  let rBrace = SyntaxFactory.makeRightBraceToken(leadingTrivia: .newline)
  let members = SyntaxFactory.makeMemberDeclBlock(
    leftBrace: SyntaxFactory.makeLeftBraceToken(),
    members: SyntaxFactory.makeMemberDeclList([]),
    rightBrace: rBrace
  )
  return SyntaxFactory.makeStructDecl(
    attributes: nil,
    modifiers: nil,
    structKeyword: structKW,
    identifier: fooID,
    genericParameterClause: nil,
    inheritanceClause: nil,
    genericWhereClause: nil,
    members: members
  )
}

public class SyntaxFactoryTests: XCTestCase {

  public func testGenerated() {

    let structDecl = cannedStructDecl()

    XCTAssertEqual("\(structDecl)",
                   """
                   struct Foo {
                   }
                   """)

    let forType = SyntaxFactory.makeIdentifier("`for`")
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
    XCTAssertEqual("\(tok)", "struct ")
    XCTAssertEqual(tok.presence, .present)

    let preSpacedTok = tok.withLeadingTrivia(.spaces(3))
    XCTAssertEqual("\(preSpacedTok)", "   struct ")

    var mutablePreSpacedTok = tok
    mutablePreSpacedTok.leadingTrivia = .spaces(4)
    XCTAssertEqual("\(mutablePreSpacedTok)", "    struct ")

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
    let arg = SyntaxFactory.makeTupleExprElement(
      label: nil,
      colon: nil,
      expression: ExprSyntax(string),
      trailingComma: nil
    )
    let call = SyntaxFactory.makeFunctionCallExpr(
      calledExpression: ExprSyntax(printID),
      leftParen: SyntaxFactory.makeLeftParenToken(),
      argumentList: SyntaxFactory.makeTupleExprElementList([arg]),
      rightParen: SyntaxFactory.makeRightParenToken(),
      trailingClosure: nil,
      additionalTrailingClosures: nil
    )
    XCTAssertEqual("\(call)", "print(\"Hello, world!\")")

    let terminatorArg = SyntaxFactory.makeTupleExprElement(
      label: SyntaxFactory.makeIdentifier("terminator"),
      colon: SyntaxFactory.makeColonToken(trailingTrivia: .space),
      expression: ExprSyntax(SyntaxFactory.makeStringLiteralExpr(" ")),
      trailingComma: nil
    )
    let callWithTerminator = call.withArgumentList(
      SyntaxFactory.makeTupleExprElementList([
        arg.withTrailingComma(
          SyntaxFactory.makeCommaToken(trailingTrivia: .space)),
        terminatorArg
      ])
    )

    XCTAssertEqual("\(callWithTerminator)",
                   "print(\"Hello, world!\", terminator: \" \")")
  }

  public func testWithOptionalChild() {
    let string = SyntaxFactory.makeStringLiteralExpr("Hello, world!")
    let printID = SyntaxFactory.makeVariableExpr("print")
    let arg = SyntaxFactory.makeTupleExprElement(
      label: nil,
      colon: nil,
      expression: ExprSyntax(string),
      trailingComma: nil
    )
    let call1 = SyntaxFactory.makeFunctionCallExpr(
      calledExpression: ExprSyntax(printID),
      leftParen: SyntaxFactory.makeLeftParenToken(),
      argumentList: SyntaxFactory.makeTupleExprElementList([arg]),
      rightParen: SyntaxFactory.makeRightParenToken(),
      trailingClosure: nil,
      additionalTrailingClosures: nil
    )
    XCTAssertNotNil(call1.leftParen)
    XCTAssertNotNil(call1.rightParen)

    let call2 = call1.withLeftParen(nil).withRightParen(nil)
    XCTAssertNil(call2.leftParen)
    XCTAssertNil(call2.rightParen)

    let call3 = SyntaxFactory.makeFunctionCallExpr(
      calledExpression: ExprSyntax(printID),
      leftParen: nil,
      argumentList: SyntaxFactory.makeTupleExprElementList([arg]),
      rightParen: nil,
      trailingClosure: nil,
      additionalTrailingClosures: nil
    )
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
    let first = SyntaxFactory.makeIntegerLiteralExpr(
      digits: SyntaxFactory.makeIntegerLiteral("1", trailingTrivia: .space)
    )
    let second = SyntaxFactory.makeIntegerLiteralExpr(
      digits: SyntaxFactory.makeIntegerLiteral("1")
    )
    let operatorNames = ["==", "!=", "+", "-", "*", "/", "<", ">", "<=", ">="]
    operatorNames.forEach { operatorName in
      let operatorToken = SyntaxFactory.makeBinaryOperator(operatorName, trailingTrivia: .space)
      let operatorExpr = SyntaxFactory.makeBinaryOperatorExpr(operatorToken: operatorToken)
      let exprList = SyntaxFactory.makeExprList([ExprSyntax(first),
                                                 ExprSyntax(operatorExpr),
                                                 ExprSyntax(second)])

      XCTAssertEqual("\(exprList)", "1 \(operatorName) 1")
    }
  }
}
