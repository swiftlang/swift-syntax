import XCTest
import SwiftSyntax

public class SyntaxAPITestCase: XCTestCase {

  public static let allTests = [
    ("testSyntaxAPI", testSyntaxAPI),
    ("testPositions", testPositions),
  ]

  public func testSyntaxAPI() {
    let source = "struct A { func f() {} }"
    let tree = try! SyntaxParser.parse(source: source)

    XCTAssertEqual("\(tree.firstToken!)", "struct ")
    XCTAssertEqual("\(tree.firstToken!.nextToken!)", "A ")
    let funcKW = tree.firstToken!.nextToken!.nextToken!.nextToken!
    XCTAssertEqual("\(funcKW)", "func ")
    XCTAssertEqual("\(funcKW.nextToken!.nextToken!.nextToken!.nextToken!.nextToken!.nextToken!)", "}")

    XCTAssertEqual(tree.lastToken!.tokenKind, .eof)
    XCTAssertEqual("\(funcKW.parent!.lastToken!)", "} ")
    XCTAssertEqual("\(funcKW.nextToken!.previousToken!)", "func ")
    XCTAssertEqual("\(funcKW.previousToken!)", "{ ")

    let toks = Array(funcKW.parent!.tokens)
    XCTAssertEqual(toks.count, 6)
    guard toks.count == 6 else {
      return
    }
    XCTAssertEqual("\(toks[0])", "func ")
    XCTAssertEqual("\(toks[1])", "f")
    XCTAssertEqual("\(toks[2])", "(")
    XCTAssertEqual("\(toks[3])", ") ")
    XCTAssertEqual("\(toks[4])", "{")
    XCTAssertEqual("\(toks[5])", "} ")

    let rtoks = Array(funcKW.parent!.tokens.reversed())
    XCTAssertEqual(rtoks.count, 6)
    guard rtoks.count == 6 else {
      return
    }
    XCTAssertEqual("\(rtoks[5])", "func ")
    XCTAssertEqual("\(rtoks[4])", "f")
    XCTAssertEqual("\(rtoks[3])", "(")
    XCTAssertEqual("\(rtoks[2])", ") ")
    XCTAssertEqual("\(rtoks[1])", "{")
    XCTAssertEqual("\(rtoks[0])", "} ")

    XCTAssertEqual(toks[0], rtoks[5])
    XCTAssertEqual(toks[1], rtoks[4])
    XCTAssertEqual(toks[2], rtoks[3])
    XCTAssertEqual(toks[3], rtoks[2])
    XCTAssertEqual(toks[4], rtoks[1])
    XCTAssertEqual(toks[5], rtoks[0])

    let tokset = Set(toks+rtoks)
    XCTAssertEqual(tokset.count, 6)

    XCTAssertEqual(toks[0].uniqueIdentifier, rtoks[5].uniqueIdentifier)
    XCTAssertEqual(toks[1].uniqueIdentifier, rtoks[4].uniqueIdentifier)
    XCTAssertEqual(toks[2].uniqueIdentifier, rtoks[3].uniqueIdentifier)
    XCTAssertEqual(toks[3].uniqueIdentifier, rtoks[2].uniqueIdentifier)
    XCTAssertEqual(toks[4].uniqueIdentifier, rtoks[1].uniqueIdentifier)
    XCTAssertEqual(toks[5].uniqueIdentifier, rtoks[0].uniqueIdentifier)
  }

  public func testPositions() {
    func testFuncKw(_ funcKW: TokenSyntax) {
      XCTAssertEqual("\(funcKW)", "  func ")
      XCTAssertEqual(funcKW.position, AbsolutePosition(utf8Offset: 0))
      XCTAssertEqual(funcKW.positionAfterSkippingLeadingTrivia, AbsolutePosition(utf8Offset: 2))
      XCTAssertEqual(funcKW.endPositionBeforeTrailingTrivia, AbsolutePosition(utf8Offset: 6))
      XCTAssertEqual(funcKW.endPosition, AbsolutePosition(utf8Offset: 7))
      XCTAssertEqual(funcKW.contentLength, SourceLength(utf8Length: 4))
    }
    do {
      let source = "  func f() {}"
      let tree = try! SyntaxParser.parse(source: source)
      let funcKW = tree.firstToken!
      testFuncKw(funcKW)
    }
    do {
      let leading = Trivia(pieces: [ .spaces(2) ])
      let trailing = Trivia(pieces: [ .spaces(1) ])
      let funcKW = SyntaxFactory.makeFuncKeyword(
        leadingTrivia: leading, trailingTrivia: trailing)
      testFuncKw(funcKW)
    }
  }
}
