import XCTest
@_spi(Testing) import SwiftSyntax
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

  public func testKeywordRoundTripping() throws {
    let someKeywords = [
      TokenKind.associatedtypeKeyword,
      TokenKind.classKeyword,
      TokenKind.deinitKeyword,
      TokenKind.enumKeyword,
      TokenKind.extensionKeyword,
      TokenKind.funcKeyword,
      TokenKind.importKeyword,
      TokenKind.initKeyword,
      TokenKind.inoutKeyword,
      TokenKind.letKeyword,
      TokenKind.operatorKeyword,
      TokenKind.precedencegroupKeyword,
      TokenKind.protocolKeyword,
      TokenKind.structKeyword,
      TokenKind.subscriptKeyword,
      TokenKind.typealiasKeyword,
      TokenKind.varKeyword,
      TokenKind.fileprivateKeyword,
      TokenKind.internalKeyword,
      TokenKind.privateKeyword,
      TokenKind.publicKeyword,
      TokenKind.staticKeyword,
      TokenKind.deferKeyword,
      TokenKind.ifKeyword,
      TokenKind.guardKeyword,
      TokenKind.doKeyword,
      TokenKind.repeatKeyword,
      TokenKind.elseKeyword,
      TokenKind.forKeyword,
      TokenKind.inKeyword,
      TokenKind.whileKeyword,
      TokenKind.returnKeyword,
      TokenKind.breakKeyword,
      TokenKind.continueKeyword,
      TokenKind.fallthroughKeyword,
      TokenKind.switchKeyword,
      TokenKind.caseKeyword,
      TokenKind.defaultKeyword,
      TokenKind.whereKeyword,
      TokenKind.catchKeyword,
      TokenKind.throwKeyword,
      TokenKind.asKeyword,
      TokenKind.anyKeyword,
      TokenKind.falseKeyword,
      TokenKind.isKeyword,
      TokenKind.nilKeyword,
      TokenKind.rethrowsKeyword,
      TokenKind.superKeyword,
      TokenKind.selfKeyword,
      TokenKind.capitalSelfKeyword,
      TokenKind.trueKeyword,
      TokenKind.tryKeyword,
      TokenKind.throwsKeyword,
      TokenKind.__file__Keyword,
      TokenKind.__line__Keyword,
      TokenKind.__column__Keyword,
      TokenKind.__function__Keyword,
      TokenKind.__dso_handle__Keyword,
      TokenKind.wildcardKeyword,
    ]

    for keyword in someKeywords {
      let constructedKeyword = try XCTUnwrap(TokenKind(keyword: keyword.text))
      XCTAssertEqual(keyword, constructedKeyword)
    }
  }
}
