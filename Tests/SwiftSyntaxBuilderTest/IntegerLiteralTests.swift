import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class IntegerLiteralTests: XCTestCase {
  func testIntegerLiteral() {
    let testCases: [UInt: (IntegerLiteralExpr, String)] = [
      #line: (IntegerLiteralExpr(digits: .integerLiteral(String(123))), "123"),
      #line: (IntegerLiteralExpr(digits: .integerLiteral(String(-123))), "-123"),
      #line: (IntegerLiteralExpr(digits: "1_000"), "1_000"),
      #line: (IntegerLiteralExpr(digits: "-1_000"), "-1_000"),
      #line: (IntegerLiteralExpr(1_000), "1000"),
      #line: (IntegerLiteralExpr(-1_000), "-1000"),
      #line: (1_000, "1000"),
      #line: (-1_000, "-1000")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let syntax = builder.buildSyntax()

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
