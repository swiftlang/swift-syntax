import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class EnumCaseElementTests: XCTestCase {
  func test_enumCaseElementInit() {
    let leadingTrivia = Trivia.garbageText("␣")
    let string = SyntaxFactory.makeStringSegment("Hello World")
    let segment = StringSegment(content: string)
    let segments = StringLiteralSegments([segment])

    let stringLiteralExpr: ExprBuildable = StringLiteralExpr(openQuote: Tokens.stringQuote,
                                                             segments: segments,
                                                             closeQuote: Tokens.stringQuote)

    let initializerClause = InitializerClause(value: stringLiteralExpr)

    let enumCase = EnumCaseElement(identifier: SyntaxFactory.makeIdentifier("TestEnum"),
                                   rawValue: initializerClause)

    let test = enumCase.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var result = ""
    test.write(to: &result)
    XCTAssertEqual(result, "␣TestEnum = \"Hello World\"")
  }
}
