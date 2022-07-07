import XCTest
import SwiftSyntax
import SwiftSyntaxParser

public class TokenTests: XCTestCase {

  public func testKeywordKinds() {
    XCTAssertTrue(TokenKind.operatorKeyword.isKeyword)
    XCTAssertTrue(TokenKind.funcKeyword.isKeyword)
    XCTAssertFalse(TokenKind.leftAngle.isKeyword)
    XCTAssertFalse(TokenKind.rightAngle.isKeyword)
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
    XCTAssertTrue(TokenKind.prefixPeriod.isPunctuation)
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
    let tok = tree.firstToken!
    XCTAssertTrue(tok.tokenKind == .multilineStringQuote)
    XCTAssertEqual(tok.contentLength.utf8Length, 3)

    let tok2 = SyntaxFactory.makeMultilineStringQuoteToken()
    XCTAssertTrue(tok2.tokenKind == .multilineStringQuote)
    XCTAssertEqual(tok2.contentLength.utf8Length, 3)
  }
}
