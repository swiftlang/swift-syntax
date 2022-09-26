import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class StringLiteralTests: XCTestCase {
  func testStringLiteral() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let testCases: [UInt: (String, String)] = [
      #line: ("", #"␣"""#),
      #line: ("asdf", #"␣"asdf""#)
    ]

    for (line, testCase) in testCases {
      let (value, expected) = testCase
      let string = Token.stringSegment(value)
      let segment = StringSegment(content: string)
      let builder = StringLiteralExpr(leadingTrivia: leadingTrivia,
                                      openQuote: .stringQuote,
                                      segments: StringLiteralSegments([segment]),
                                      closeQuote: .stringQuote)
      let syntax = builder.buildSyntax()

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }

  func testStringLiteralConvenienceInitializers() {
    let testCases: [UInt: (ExpressibleAsStringLiteralExpr, String)] = [
      #line: (StringLiteralExpr(""), #""""#),
      #line: (StringLiteralExpr("asdf"), #""asdf""#),
      #line: ("", #""""#),
      #line: ("asdf", #""asdf""#),
      #line: (StringLiteralExpr(raw: "abc"), "#\"abc\"#"),
      #line: (StringLiteralExpr(raw: #""quoted""#), ##"#""quoted""#"##),
      #line: (StringLiteralExpr(raw: ##"#"rawquoted"#"##), ###"##"#"rawquoted"#"##"###),
      #line: (StringLiteralExpr(raw: ####"###"unbalanced"####), #####"####"###"unbalanced"####"#####),
      #line: (StringLiteralExpr(raw: ###"some "# string ##""###), ####"###"some "# string ##""###"####),
      #line: (StringLiteralExpr(raw: ###"\##(abc) \(def)"###), ####"###"\##(abc) \(def)"###"####),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let stringLiteralExpr = builder.createStringLiteralExpr()
      let syntax = stringLiteralExpr.buildSyntax()

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
