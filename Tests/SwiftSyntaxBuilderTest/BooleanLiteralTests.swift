import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class BooleanLiteralTests: XCTestCase {
  func testBooleanLiteral() {
    let testCases: [UInt: (BooleanLiteralExpr, String)] = [
      #line: (BooleanLiteralExpr(booleanLiteral: .true), "true"),
      #line: (BooleanLiteralExpr(booleanLiteral: .false), "false"),
      #line: (BooleanLiteralExpr(true), "true"),
      #line: (BooleanLiteralExpr(false), "false"),
      #line: (true, "true"),
      #line: (false, "false")
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
