import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class IdentifierExprTests: XCTestCase {
  func testStringLiteral() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (ExpressibleAsIdentifierExpr, String)] = [
      #line: (IdentifierExpr(identifier: .identifier("Test")), "␣Test"),
      #line: (IdentifierExpr("Test"), "␣Test"),
      #line: ("Test", "␣Test")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let identifierExpr = builder.createIdentifierExpr()
      let syntax = identifierExpr.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
