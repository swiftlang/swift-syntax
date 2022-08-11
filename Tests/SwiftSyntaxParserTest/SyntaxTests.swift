import XCTest
import SwiftSyntax
import SwiftSyntaxParser

fileprivate extension SyntaxProtocol {
  func token(at index: Int, viewMode: SyntaxTreeViewMode) -> TokenSyntax? {
    var token = self.firstToken(viewMode: viewMode)
    for _ in 0..<index {
      token = token?.nextToken(viewMode: viewMode)
    }
    return token
  }
}

public class SyntaxTests: XCTestCase {

  public func testSyntaxAPI() {
    let source = "struct A { func f() {} }"
    let tree = try! SyntaxParser.parse(source: source)

    XCTAssertEqual("\(tree.token(at: 0, viewMode: .sourceAccurate)!)", "struct ")
    XCTAssertEqual("\(tree.token(at: 1, viewMode: .sourceAccurate)!)", "A ")
    let funcKW = tree.token(at: 3, viewMode: .sourceAccurate)!
    XCTAssertEqual("\(funcKW)", "func ")
    XCTAssertEqual("\(tree.token(at: 9, viewMode: .sourceAccurate)!)", "}")

    XCTAssertEqual(tree.lastToken(viewMode: .sourceAccurate)!.tokenKind, .eof)
    XCTAssertEqual("\(funcKW.parent!.lastToken(viewMode: .sourceAccurate)!)", "} ")
    XCTAssertEqual("\(funcKW.nextToken(viewMode: .sourceAccurate)!.previousToken(viewMode: .sourceAccurate)!)", "func ")
    XCTAssertEqual("\(funcKW.previousToken(viewMode: .sourceAccurate)!)", "{ ")

    let toks = Array(funcKW.parent!.tokens(viewMode: .sourceAccurate))
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

    let rtoks = Array(funcKW.parent!.tokens(viewMode: .sourceAccurate).reversed())
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
      let funcKW = TokenSyntax.funcKeyword(
        leadingTrivia: leading, trailingTrivia: trailing)
      testFuncKw(funcKW)
    }
  }

  public func testCasting() {
    let integerExpr = IntegerLiteralExprSyntax(
      digits: .integerLiteral("1", trailingTrivia: .space)
    )

    let expr = ExprSyntax(integerExpr)
    let node = Syntax(expr)
    XCTAssertTrue(expr.is(IntegerLiteralExprSyntax.self))
    XCTAssertTrue(node.is(IntegerLiteralExprSyntax.self))
    XCTAssertTrue(node.as(ExprSyntax.self)!.is(IntegerLiteralExprSyntax.self))

    XCTAssertTrue(node.isProtocol(ExprSyntaxProtocol.self))
    XCTAssertTrue(node.asProtocol(ExprSyntaxProtocol.self) is IntegerLiteralExprSyntax)
    XCTAssertTrue(expr.asProtocol(ExprSyntaxProtocol.self) is IntegerLiteralExprSyntax)
    XCTAssertTrue(expr.asProtocol(ExprSyntaxProtocol.self) as? IntegerLiteralExprSyntax == integerExpr)

    XCTAssertFalse(node.isProtocol(BracedSyntax.self))
    XCTAssertNil(node.asProtocol(BracedSyntax.self))
    XCTAssertFalse(expr.isProtocol(BracedSyntax.self))
    XCTAssertNil(expr.asProtocol(BracedSyntax.self))

    let classDecl = CodeBlockSyntax(
      leftBrace: TokenSyntax.leftBraceToken(),
      statements: CodeBlockItemListSyntax([]),
      rightBrace: TokenSyntax.rightBraceToken()
    )

    XCTAssertTrue(classDecl.isProtocol(BracedSyntax.self))
    XCTAssertNotNil(classDecl.asProtocol(BracedSyntax.self))

    let optNode: Syntax? = node
    switch optNode?.as(SyntaxEnum.self) {
    case .integerLiteralExpr: break
    default: XCTFail("failed to convert to SyntaxEnum")
    }

    XCTAssertNil(ExprSyntax(nil as IntegerLiteralExprSyntax?))
    XCTAssertEqual(ExprSyntax(integerExpr).as(IntegerLiteralExprSyntax.self)!, integerExpr)
  }

  public func testNodeType() {
    let integerExpr = IntegerLiteralExprSyntax(
      digits: TokenSyntax.integerLiteral("1", trailingTrivia: .space)
    )
    let expr = ExprSyntax(integerExpr)
    let node = Syntax(expr)

    XCTAssertTrue(integerExpr.syntaxNodeType == expr.syntaxNodeType)
    XCTAssertTrue(integerExpr.syntaxNodeType == node.syntaxNodeType)
    XCTAssertEqual("\(integerExpr.syntaxNodeType)", "IntegerLiteralExprSyntax")
  }

  public func testConstructFromSyntaxProtocol() {
    let integerExpr = IntegerLiteralExprSyntax(
      digits: .integerLiteral("1", trailingTrivia: .space)
    )

    XCTAssertEqual(Syntax(integerExpr), Syntax(fromProtocol: integerExpr as SyntaxProtocol))
    XCTAssertEqual(Syntax(integerExpr), Syntax(fromProtocol: integerExpr as ExprSyntaxProtocol))
  }

  public func testRunParserOnForeignString() {
    // Store the source code in a foreign non-UTF-8 string.
    // If SwiftSyntax fails to convert it to a native UTF-8 string, internal assertions should fail.
    let sourceNsString = "var 🎉 = 2" as NSString
    _ = try? SyntaxParser.parse(source: sourceNsString as String)
  }

  public func testParseFileWithNullCharacter() throws {
    let source = "var x = 1\0\nvar y = 2"
    let tree = try SyntaxParser.parse(source: source)
    XCTAssertEqual(tree.description, source)
  }
}
