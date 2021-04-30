import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class StringLiteralTests: XCTestCase {
  func testStringLiteral() {
    let leadingTrivia = Trivia.garbageText("␣")
    let testCases: [UInt: (String, String)] = [
      #line: ("", #"␣"""#),
      #line: ("asdf", #"␣"asdf""#),
    ]

    for (line, testCase) in testCases {
      let (value, expected) = testCase
      let string = SyntaxFactory.makeStringSegment(value)
      let segment = StringSegment(content: string)
      let builder = StringLiteralExpr(openQuote: Tokens.stringQuote,
                                      segments: StringLiteralSegments([segment]),
                                      closeQuote: Tokens.stringQuote)
      let syntax = builder.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
