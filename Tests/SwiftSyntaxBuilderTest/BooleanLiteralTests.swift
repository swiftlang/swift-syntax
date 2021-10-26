import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class BooleanLiteralTests: XCTestCase {
  func testBooleanLiteral() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (BooleanLiteralExpr, String)] = [
      #line: (BooleanLiteralExpr(booleanLiteral: TokenSyntax.true), "␣true "),
      #line: (BooleanLiteralExpr(booleanLiteral: TokenSyntax.false), "␣false "),
      #line: (BooleanLiteralExpr(true), "␣true "),
      #line: (BooleanLiteralExpr(false), "␣false "),
      #line: (true, "␣true "),
      #line: (false, "␣false ")
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
