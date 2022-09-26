import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class PrefixOperatorExprTests: XCTestCase {
  func testPrefixOperatorExprConvenienceInitializers() {
    let testCases: [UInt: (ExpressibleAsPrefixOperatorExpr, String)] = [
      #line: (PrefixOperatorExpr("!", "test"), "!test"),
      #line: (PrefixOperatorExpr("!", BooleanLiteralExpr(false)), "!false"),
      #line: (PrefixOperatorExpr("~", IntegerLiteralExpr(23)), "~23"),
    ]
    
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let expr = builder.createPrefixOperatorExpr()
      let syntax = expr.buildSyntax()

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
