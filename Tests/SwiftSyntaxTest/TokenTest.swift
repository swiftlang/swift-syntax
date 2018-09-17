import XCTest
import SwiftSyntax

public class TokenSyntaxTestCase: XCTestCase {
  public func testKeywordKinds() {
    XCTAssertTrue(TokenKind.operatorKeyword.isKeyword)
    XCTAssertTrue(TokenKind.funcKeyword.isKeyword)
    XCTAssertFalse(TokenKind.leftAngle.isKeyword)
    XCTAssertFalse(TokenKind.rightAngle.isKeyword)
  }
}
