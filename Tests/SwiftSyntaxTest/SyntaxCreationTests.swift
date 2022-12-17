//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

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
    structKeyword: structKW,
    identifier: fooID,
    members: members
  )
}

public class SyntaxCreationTests: XCTestCase {

  public func testGenerated() {

    let structDecl = cannedStructDecl()

    XCTAssertEqual(
      "\(structDecl)",
      """
      struct Foo {
      }
      """
    )

    let forType = TokenSyntax.identifier("`for`", trailingTrivia: .space)
    let newBrace = TokenSyntax.rightBraceToken(leadingTrivia: .newlines(2))

    let renamed = structDecl.withIdentifier(forType)
      .withMembers(
        structDecl.members
          .withRightBrace(newBrace)
      )

    XCTAssertEqual(
      "\(renamed)",
      """
      struct `for` {

      }
      """
    )

    XCTAssertNotEqual(structDecl.members, renamed.members)
    XCTAssertEqual(structDecl, StructDeclSyntax(structDecl.root))
    XCTAssertNil(structDecl.parent)
    XCTAssertNotNil(structDecl.members.parent)
    XCTAssertEqual(structDecl.members.parent.map(StructDeclSyntax.init), structDecl)

    XCTAssertEqual(
      "\(structDecl.members.rightBrace)",
      """

      }
      """
    )
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
      openQuote: .stringQuoteToken(),
      segments: StringLiteralSegmentsSyntax([.stringSegment(StringSegmentSyntax(content: .stringSegment("Hello, world!")))]),
      closeQuote: .stringQuoteToken()
    )
    let printID = IdentifierExprSyntax(identifier: .identifier("print"))
    let arg = TupleExprElementSyntax(expression: string)
    let call = FunctionCallExprSyntax(
      calledExpression: printID,
      leftParen: .leftParenToken(),
      argumentList: TupleExprElementListSyntax([arg]),
      rightParen: .rightParenToken()
    )
    XCTAssertEqual("\(call)", "print(\"Hello, world!\")")

    let emptyString = StringLiteralExprSyntax(
      openQuote: .stringQuoteToken(),
      segments: StringLiteralSegmentsSyntax([.stringSegment(StringSegmentSyntax(content: .stringSegment(" ")))]),
      closeQuote: .stringQuoteToken()
    )
    let terminatorArg = TupleExprElementSyntax(
      label: .identifier("terminator"),
      colon: .colonToken(trailingTrivia: .space),
      expression: emptyString
    )
    let callWithTerminator = call.withArgumentList(
      TupleExprElementListSyntax([
        arg.withTrailingComma(
          .commaToken(trailingTrivia: .space)
        ),
        terminatorArg,
      ])
    )

    XCTAssertEqual(
      "\(callWithTerminator)",
      "print(\"Hello, world!\", terminator: \" \")"
    )
  }

  public func testWithOptionalChild() {
    let string = StringLiteralExprSyntax(
      openDelimiter: nil,
      openQuote: .stringQuoteToken(),
      segments: StringLiteralSegmentsSyntax([.stringSegment(StringSegmentSyntax(content: .stringSegment("Hello, world!")))]),
      closeQuote: .stringQuoteToken(),
      closeDelimiter: nil
    )
    let printID = IdentifierExprSyntax(identifier: .identifier("print"))
    let arg = TupleExprElementSyntax(expression: string)
    let call1 = FunctionCallExprSyntax(
      calledExpression: printID,
      leftParen: .leftParenToken(),
      argumentList: TupleExprElementListSyntax([arg]),
      rightParen: .rightParenToken()
    )
    XCTAssertNotNil(call1.leftParen)
    XCTAssertNotNil(call1.rightParen)

    let call2 = call1.withLeftParen(nil).withRightParen(nil)
    XCTAssertNil(call2.leftParen)
    XCTAssertNil(call2.rightParen)

    let call3 = FunctionCallExprSyntax(
      calledExpression: printID,
      argumentList: TupleExprElementListSyntax([arg])
    )
    XCTAssertNil(call3.leftParen)
    XCTAssertNil(call3.rightParen)
  }

  public func testMakeStringLiteralExpr() {
    let expr = StringLiteralExprSyntax(
      openQuote: .stringQuoteToken(leadingTrivia: [.lineComment("// hello"), .newlines(1)]),
      segments: StringLiteralSegmentsSyntax([.stringSegment(StringSegmentSyntax(content: .stringSegment("Hello, world!")))]),
      closeQuote: .stringQuoteToken()
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
      let exprList = ExprListSyntax([
        ExprSyntax(first),
        ExprSyntax(operatorExpr),
        ExprSyntax(second),
      ])

      XCTAssertEqual("\(exprList)", "1 \(operatorName) 1")
    }
  }
}
