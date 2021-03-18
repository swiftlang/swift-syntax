import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class IntegerLiteralTests: XCTestCase {
  func testIntegerLiteral() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (IntegerLiteralExpr, String)] = [
      #line: (IntegerLiteralExpr(digits: SyntaxFactory.makeIntegerLiteral(String(123))), "␣123"),
      #line: (IntegerLiteralExpr(digits: SyntaxFactory.makeIntegerLiteral(String(-123))), "␣-123"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let syntax = builder.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
