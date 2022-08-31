import XCTest
import SwiftSyntax

fileprivate func cannedStructDecl() -> StructDeclSyntax {
  let structKW = TokenSyntax.structKeyword(trailingTrivia: .space)
  let fooID = TokenSyntax.identifier("Foo", trailingTrivia: .space)
  let rBrace = TokenSyntax.rightBraceToken(leadingTrivia: .newline)
  let members = MemberDeclBlockSyntax(
    leftBrace: .leftBraceToken(),
    members: MemberDeclListSyntax([]),
    rightBrace: rBrace
  )
  return StructDeclSyntax(
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

public class SyntaxCreationTests: XCTestCase {

  public func testGenerated() {

    let structDecl = cannedStructDecl()

    XCTAssertEqual("\(structDecl)",
                   """
                   struct Foo {
                   }
                   """)

    let forType = TokenSyntax.identifier("`for`", trailingTrivia: .space)
    let newBrace = TokenSyntax.rightBraceToken(leadingTrivia: .newlines(2))

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
    let tok = TokenSyntax.structKeyword(trailingTrivia: .space)
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

//  private func makeStringLiteralExpr(_ text: String, leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> StringLiteralExprSyntax {
//    return
//  }

  public func testFunctionCallSyntaxBuilder() {
    let string = StringLiteralExprSyntax(
      openDelimiter: nil,
      openQuote: .stringQuoteToken(),
      segments: StringLiteralSegmentsSyntax([Syntax(StringSegmentSyntax(content: .stringSegment("Hello, world!")))]),
      closeQuote: .stringQuoteToken(),
      closeDelimiter: nil
    )
    let printID = ExprSyntax(IdentifierExprSyntax(identifier: .identifier("print"), declNameArguments: nil))
    let arg = TupleExprElementSyntax(
      label: nil,
      colon: nil,
      expression: ExprSyntax(string),
      trailingComma: nil
    )
    let call = FunctionCallExprSyntax(
      calledExpression: ExprSyntax(printID),
      leftParen: .leftParenToken(),
      argumentList: TupleExprElementListSyntax([arg]),
      rightParen: .rightParenToken(),
      trailingClosure: nil,
      additionalTrailingClosures: nil
    )
    XCTAssertEqual("\(call)", "print(\"Hello, world!\")")

    let emptyString = StringLiteralExprSyntax(
      openDelimiter: nil,
      openQuote: .stringQuoteToken(),
      segments: StringLiteralSegmentsSyntax([Syntax(StringSegmentSyntax(content: .stringSegment(" ")))]),
      closeQuote: .stringQuoteToken(),
      closeDelimiter: nil
    )
    let terminatorArg = TupleExprElementSyntax(
      label: TokenSyntax.identifier("terminator"),
      colon: TokenSyntax.colonToken(trailingTrivia: .space),
      expression: ExprSyntax(emptyString),
      trailingComma: nil
    )
    let callWithTerminator = call.withArgumentList(
      TupleExprElementListSyntax([
        arg.withTrailingComma(
          .commaToken(trailingTrivia: .space)),
        terminatorArg
      ])
    )

    XCTAssertEqual("\(callWithTerminator)",
                   "print(\"Hello, world!\", terminator: \" \")")
  }

  public func testWithOptionalChild() {
    let string = StringLiteralExprSyntax(
      openDelimiter: nil,
      openQuote: .stringQuoteToken(),
      segments: StringLiteralSegmentsSyntax([Syntax(StringSegmentSyntax(content: .stringSegment("Hello, world!")))]),
      closeQuote: .stringQuoteToken(),
      closeDelimiter: nil
    )
    let printID = IdentifierExprSyntax(identifier: .identifier("print"), declNameArguments: nil)
    let arg = TupleExprElementSyntax(
      label: nil,
      colon: nil,
      expression: ExprSyntax(string),
      trailingComma: nil
    )
    let call1 = FunctionCallExprSyntax(
      calledExpression: ExprSyntax(printID),
      leftParen: TokenSyntax.leftParenToken(),
      argumentList: TupleExprElementListSyntax([arg]),
      rightParen: TokenSyntax.rightParenToken(),
      trailingClosure: nil,
      additionalTrailingClosures: nil
    )
    XCTAssertNotNil(call1.leftParen)
    XCTAssertNotNil(call1.rightParen)

    let call2 = call1.withLeftParen(nil).withRightParen(nil)
    XCTAssertNil(call2.leftParen)
    XCTAssertNil(call2.rightParen)

    let call3 = FunctionCallExprSyntax(
      calledExpression: ExprSyntax(printID),
      leftParen: nil,
      argumentList: TupleExprElementListSyntax([arg]),
      rightParen: nil,
      trailingClosure: nil,
      additionalTrailingClosures: nil
    )
    XCTAssertNil(call3.leftParen)
    XCTAssertNil(call3.rightParen)
  }

  public func testUnknownSyntax() {
    let expr = StringLiteralExprSyntax(
      openDelimiter: nil,
      openQuote: .stringQuoteToken(),
      segments: StringLiteralSegmentsSyntax([Syntax(StringSegmentSyntax(content: .stringSegment("Hello, world!")))]),
      closeQuote: .stringQuoteToken(),
      closeDelimiter: nil
    )
    XCTAssertFalse(expr.isUnknown)
    let unknown = UnknownSyntax(
      tokens: [.leftBraceToken()])
    XCTAssertTrue(unknown.isUnknown)
    XCTAssertNoThrow(try SyntaxVerifier.verify(Syntax(expr)))
    XCTAssertThrowsError(try SyntaxVerifier.verify(Syntax(unknown)))
  }

  public func testMakeStringLiteralExpr() {
    let expr = StringLiteralExprSyntax(
      openDelimiter: nil,
      openQuote: .stringQuoteToken(leadingTrivia: [.lineComment("// hello"), .newlines(1)]),
      segments: StringLiteralSegmentsSyntax([Syntax(StringSegmentSyntax(content: .stringSegment("Hello, world!")))]),
      closeQuote: .stringQuoteToken(),
      closeDelimiter: nil
    )
    let expected = """
// hello
"Hello, world!"
"""
    XCTAssertEqual(expr.description, expected)
  }
    
  public func testMakeBinaryOperator() {
    let first = IntegerLiteralExprSyntax(
      digits: .integerLiteral("1")
    )
    let second = IntegerLiteralExprSyntax(
      digits: .integerLiteral("1")
    )
    let operatorNames = ["==", "!=", "+", "-", "*", "/", "<", ">", "<=", ">="]
    operatorNames.forEach { operatorName in
      let operatorToken = TokenSyntax.spacedBinaryOperator(operatorName, leadingTrivia: .space, trailingTrivia: .space)
      let operatorExpr = BinaryOperatorExprSyntax(operatorToken: operatorToken)
      let exprList = ExprListSyntax([ExprSyntax(first),
                                                 ExprSyntax(operatorExpr),
                                                 ExprSyntax(second)])

      XCTAssertEqual("\(exprList)", "1 \(operatorName) 1")
    }
  }
}
