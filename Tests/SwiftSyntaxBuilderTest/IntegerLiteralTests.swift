import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class IntegerLiteralTests: XCTestCase {
  func testIntegerLiteral() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (IntegerLiteral, String)] = [
      #line: (IntegerLiteral(123), "␣123"),
      #line: (IntegerLiteral(-123), "␣-123"),
      #line: (123, "␣123"),
      #line: (-123, "␣-123"),
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
