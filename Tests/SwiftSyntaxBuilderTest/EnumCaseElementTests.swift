import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class EnumCaseElementTests: XCTestCase {
  func test_enumCaseElementInit() {
    let leadingTrivia = Trivia.garbageText("␣")
    let string = SyntaxFactory.makeStringSegment("Hello World")
    let segment = StringSegment(content: string)
    let segments = StringLiteralSegments([segment])

    let stringLiteralExpr: ExprBuildable = StringLiteralExpr(openDelimiter: nil,
                                                             openQuote: SyntaxFactory.makeStringQuoteToken(),
                                                             segments: segments,
                                                             closeQuote: SyntaxFactory.makeStringQuoteToken(),
                                                             closeDelimiter: nil)

    let initializerClause = InitializerClause(equal: SyntaxFactory.makeEqualToken().withTrailingTrivia(.spaces(1)),
                                              value: stringLiteralExpr)

    let enumCase = EnumCaseElement(identifier: SyntaxFactory.makeIdentifier("TestEnum").withTrailingTrivia(.spaces(1)),
                                   associatedValue: nil,
                                   rawValue: initializerClause,
                                   trailingComma: nil)

    let test = enumCase.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var result = ""
    test.write(to: &result)
    XCTAssertEqual(result, "␣TestEnum = \"Hello World\"")
  }
}
