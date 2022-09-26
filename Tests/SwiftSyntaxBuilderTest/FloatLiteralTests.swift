import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class FloatLiteralTests: XCTestCase {
  func testFloatLiteral() {
    let testCases: [UInt: (FloatLiteralExpr, String)] = [
      #line: (FloatLiteralExpr(floatingDigits: .floatingLiteral(String(123.321))), "123.321"),
      #line: (FloatLiteralExpr(floatingDigits: .floatingLiteral(String(-123.321))), "-123.321"),
      #line: (FloatLiteralExpr(floatingDigits: "2_123.321"), "2_123.321"),
      #line: (FloatLiteralExpr(floatingDigits: "-2_123.321"), "-2_123.321"),
      #line: (FloatLiteralExpr(2_123.321), "2123.321"),
      #line: (FloatLiteralExpr(-2_123.321), "-2123.321"),
      #line: (2_123.321, "2123.321"),
      #line: (-2_123.321, "-2123.321")
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
