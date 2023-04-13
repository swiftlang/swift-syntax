//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftSyntax

fileprivate func cannedStructDecl() -> StructDeclSyntax {
  let structKW = TokenSyntax.keyword(.struct, trailingTrivia: .space)
  let fooID = TokenSyntax.identifier("Foo", trailingTrivia: .space)
  let rBrace = TokenSyntax.rightBraceToken(leadingTrivia: .newline)
  let memberBlock = MemberDeclBlockSyntax(
    leftBrace: .leftBraceToken(),
    members: MemberDeclListSyntax([]),
    rightBrace: rBrace
  )
  return StructDeclSyntax(
    structKeyword: structKW,
    identifier: fooID,
    memberBlock: memberBlock
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

    let renamed = structDecl.with(\.identifier, forType)
      .with(
        \.memberBlock,
        structDecl.memberBlock
          .with(\.rightBrace, newBrace)
      )

    XCTAssertEqual(
      "\(renamed)",
      """
      struct `for` {

      }
      """
    )

    XCTAssertNotEqual(structDecl.memberBlock, renamed.memberBlock)
    XCTAssertEqual(structDecl, StructDeclSyntax(structDecl.root))
    XCTAssertNil(structDecl.parent)
    XCTAssertNotNil(structDecl.memberBlock.parent)
    XCTAssertEqual(structDecl.memberBlock.parent.map(StructDeclSyntax.init), structDecl)

    XCTAssertEqual(
      "\(structDecl.memberBlock.rightBrace)",
      """

      }
      """
    )
  }

  public func testTokenSyntax() {
    let tok = TokenSyntax.keyword(.struct, trailingTrivia: .space)
    XCTAssertEqual("\(tok)", "struct ")
    XCTAssertEqual(tok.presence, .present)

    let preSpacedTok = tok.with(\.leadingTrivia, .spaces(3))
    XCTAssertEqual("\(preSpacedTok)", "   struct ")

    var mutablePreSpacedTok = tok
    mutablePreSpacedTok.leadingTrivia = .spaces(4)
    XCTAssertEqual("\(mutablePreSpacedTok)", "    struct ")

    let postSpacedTok = tok.with(\.trailingTrivia, .spaces(6))
    XCTAssertEqual("\(postSpacedTok)", "struct      ")

    var mutablePostSpacedTok = tok
    mutablePostSpacedTok.trailingTrivia = .spaces(3)
    XCTAssertEqual("\(mutablePostSpacedTok)", "struct   ")

    let prePostSpacedTok = preSpacedTok.with(\.trailingTrivia, .spaces(4))
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
    let callWithTerminator = call.with(
      \.argumentList,
      TupleExprElementListSyntax([
        arg.with(
          \.trailingComma,
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

    let call2 = call1.with(\.leftParen, nil).with(\.rightParen, nil)
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
      let operatorToken = TokenSyntax.binaryOperator(operatorName, leadingTrivia: .space, trailingTrivia: .space)
      let operatorExpr = BinaryOperatorExprSyntax(operatorToken: operatorToken)
      let exprList = ExprListSyntax([
        ExprSyntax(first),
        ExprSyntax(operatorExpr),
        ExprSyntax(second),
      ])

      XCTAssertEqual("\(exprList)", "1 \(operatorName) 1")
    }
  }

  func testTriviaInInitializxerDoesNotOverrideFirstNode() {
    let node = ExpressionPatternSyntax(
      leadingTrivia: .lineComment("// Outer leading") + .newline,
      expression: IntegerLiteralExprSyntax(
        leadingTrivia: .lineComment("// Inner leading") + .newline,
        digits: .integerLiteral("42"),
        trailingTrivia: .newline + .lineComment("// Inner trailing")
      ),
      trailingTrivia: .newline + .lineComment("// Outer trailing")
    )

    XCTAssertEqual(
      node.description,
      """
      // Outer leading
      // Inner leading
      42
      // Inner trailing
      // Outer trailing
      """
    )
  }
}
