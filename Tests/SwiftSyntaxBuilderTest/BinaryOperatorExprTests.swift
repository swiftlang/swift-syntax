import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class BinaryOperatorExprTests: XCTestCase {
  func testBinaryOperatorExprConvenienceInitializers() {
    let testCases: [UInt: (ExpressibleAsBinaryOperatorExpr, String)] = [
      #line: (BinaryOperatorExpr("=="), " == "),
      #line: (Token.unspacedBinaryOperator("=="), "=="),
      #line: ("==", " == "),
    ]
    
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let binaryOperatorExpr = builder.createBinaryOperatorExpr()
      let syntax = binaryOperatorExpr.buildSyntax()

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
