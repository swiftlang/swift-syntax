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
