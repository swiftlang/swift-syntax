import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class StringLiteralTests: XCTestCase {
  func testStringLiteral() {
    let leadingTrivia = Trivia.garbageText("␣")
    let testCases: [UInt: (String, String)] = [
      #line: ("", #"␣"""#),
      #line: ("asdf", #"␣"asdf""#)
    ]

    for (line, testCase) in testCases {
      let (value, expected) = testCase
      let string = SyntaxFactory.makeStringSegment(value)
      let segment = StringSegment(content: string)
      let builder = StringLiteralExpr(openQuote: .stringQuote,
                                      segments: StringLiteralSegments([segment]),
                                      closeQuote: .stringQuote)
      let syntax = builder.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }

  func testStringLiteralConvenienceInitializers() {
    let leadingTrivia = Trivia.garbageText("␣")
    let testCases: [UInt: (ExpressibleAsStringLiteralExpr, String)] = [
      #line: (StringLiteralExpr(""), #"␣"""#),
      #line: (StringLiteralExpr("asdf"), #"␣"asdf""#),
      #line: ("", #"␣"""#),
      #line: ("asdf", #"␣"asdf""#),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let stringLiteralExpr = builder.createStringLiteralExpr()
      let syntax = stringLiteralExpr.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
