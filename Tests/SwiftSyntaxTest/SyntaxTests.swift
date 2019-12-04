import XCTest
import SwiftSyntax

public class SyntaxTests: XCTestCase {

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

    XCTAssertEqual(toks[0].id, rtoks[5].id)
    XCTAssertEqual(toks[1].id, rtoks[4].id)
    XCTAssertEqual(toks[2].id, rtoks[3].id)
    XCTAssertEqual(toks[3].id, rtoks[2].id)
    XCTAssertEqual(toks[4].id, rtoks[1].id)
    XCTAssertEqual(toks[5].id, rtoks[0].id)
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

  public func testCasting() {
    let integerExpr = IntegerLiteralExprSyntax {
      $0.useDigits(SyntaxFactory.makeIntegerLiteral("1", trailingTrivia: .spaces(1)))
    }

    let expr = ExprSyntax(integerExpr)
    let node = Syntax(expr)
    XCTAssertTrue(expr.is(IntegerLiteralExprSyntax.self))
    XCTAssertTrue(node.is(IntegerLiteralExprSyntax.self))
    XCTAssertTrue(node.as(ExprSyntax.self)!.is(IntegerLiteralExprSyntax.self))

    XCTAssertTrue(node.is(ExprSyntaxProtocol.self))
    XCTAssertTrue(node.as(ExprSyntaxProtocol.self) is IntegerLiteralExprSyntax)
    XCTAssertTrue(expr.as(ExprSyntaxProtocol.self) is IntegerLiteralExprSyntax)
    XCTAssertTrue(expr.as(ExprSyntaxProtocol.self) as? IntegerLiteralExprSyntax == integerExpr)

    XCTAssertFalse(node.is(BracedSyntax.self))
    XCTAssertNil(node.as(BracedSyntax.self))
    XCTAssertFalse(expr.is(BracedSyntax.self))
    XCTAssertNil(expr.as(BracedSyntax.self))

    let classDecl = SyntaxFactory.makeCodeBlock(
      leftBrace: SyntaxFactory.makeToken(.leftBrace, presence: .present),
      statements: SyntaxFactory.makeCodeBlockItemList([]),
      rightBrace: SyntaxFactory.makeToken(.rightBrace, presence: .present)
    )

    XCTAssertTrue(classDecl.is(BracedSyntax.self))
    XCTAssertNotNil(classDecl.as(BracedSyntax.self))

    let optNode: Syntax? = node
    switch optNode?.as(SyntaxEnum.self) {
    case .integerLiteralExpr: break
    default: XCTFail("failed to convert to SyntaxEnum")
    }
  }
}
