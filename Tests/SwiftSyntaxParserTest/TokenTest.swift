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
@_spi(Testing) import SwiftSyntax
import SwiftSyntaxParser

public class TokenTests: XCTestCase {

  public func testKeywordKinds() {
    XCTAssertTrue(TokenKind.keyword(.operator).isLexerClassifiedKeyword)
    XCTAssertTrue(TokenKind.keyword(.func).isLexerClassifiedKeyword)
    XCTAssertFalse(TokenKind.leftAngle.isLexerClassifiedKeyword)
    XCTAssertFalse(TokenKind.rightAngle.isLexerClassifiedKeyword)
  }

  public func testPunctuators() {
    XCTAssertTrue(TokenKind.leftParen.isPunctuation)
    XCTAssertTrue(TokenKind.rightParen.isPunctuation)
    XCTAssertTrue(TokenKind.leftBrace.isPunctuation)
    XCTAssertTrue(TokenKind.rightBrace.isPunctuation)
    XCTAssertTrue(TokenKind.leftSquareBracket.isPunctuation)
    XCTAssertTrue(TokenKind.rightSquareBracket.isPunctuation)
    XCTAssertTrue(TokenKind.leftAngle.isPunctuation)
    XCTAssertTrue(TokenKind.rightAngle.isPunctuation)
    XCTAssertTrue(TokenKind.period.isPunctuation)
    XCTAssertTrue(TokenKind.comma.isPunctuation)
    XCTAssertTrue(TokenKind.ellipsis.isPunctuation)
    XCTAssertTrue(TokenKind.colon.isPunctuation)
    XCTAssertTrue(TokenKind.semicolon.isPunctuation)
    XCTAssertTrue(TokenKind.equal.isPunctuation)
    XCTAssertTrue(TokenKind.atSign.isPunctuation)
    XCTAssertTrue(TokenKind.pound.isPunctuation)
    XCTAssertTrue(TokenKind.prefixAmpersand.isPunctuation)
    XCTAssertTrue(TokenKind.arrow.isPunctuation)
    XCTAssertTrue(TokenKind.backtick.isPunctuation)
    XCTAssertTrue(TokenKind.backslash.isPunctuation)
    XCTAssertTrue(TokenKind.exclamationMark.isPunctuation)
    XCTAssertTrue(TokenKind.postfixQuestionMark.isPunctuation)
    XCTAssertTrue(TokenKind.infixQuestionMark.isPunctuation)
    XCTAssertTrue(TokenKind.stringQuote.isPunctuation)
    XCTAssertTrue(TokenKind.singleQuote.isPunctuation)
    XCTAssertTrue(TokenKind.multilineStringQuote.isPunctuation)
  }

  public func testTokenLgnth() {
    let source = "\"\"\"\n\\(a)\n\"\"\""
    let tree = try! SyntaxParser.parse(source: source)
    let tok = tree.firstToken(viewMode: .sourceAccurate)!
    XCTAssertTrue(tok.tokenKind == .multilineStringQuote)
    XCTAssertEqual(tok.contentLength.utf8Length, 3)

    let tok2 = TokenSyntax.multilineStringQuoteToken()
    XCTAssertTrue(tok2.tokenKind == .multilineStringQuote)
    XCTAssertEqual(tok2.contentLength.utf8Length, 3)
  }
}
