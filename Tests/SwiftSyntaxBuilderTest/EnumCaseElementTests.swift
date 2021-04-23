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
                                                             openQuote: Tokens.stringQuote,
                                                             segments: segments,
                                                             closeQuote: Tokens.stringQuote,
                                                             closeDelimiter: nil)

    let initializerClause = InitializerClause(equal: Tokens.equal,
                                              value: stringLiteralExpr)

    let enumCase = EnumCaseElement(identifier: SyntaxFactory.makeIdentifier("TestEnum"),
                                   associatedValue: nil,
                                   rawValue: initializerClause,
                                   trailingComma: nil)

    let test = enumCase.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var result = ""
    test.write(to: &result)
    XCTAssertEqual(result, "␣TestEnum = \"Hello World\"")
  }
}
