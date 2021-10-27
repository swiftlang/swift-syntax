import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class BinaryOperatorExprTests: XCTestCase {
  func testBinaryOperatorExprConvenienceInitializers() {
    let leadingTrivia = Trivia.garbageText("␣")
    let testCases: [UInt: (ExpressibleAsBinaryOperatorExpr, String)] = [
      #line: (BinaryOperatorExpr("=="), "␣ == "),
      #line: (TokenSyntax.unspacedBinaryOperator("=="), "␣=="),
      #line: ("==", "␣ == "),
    ]
    
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let binaryOperatorExpr = builder.createBinaryOperatorExpr()
      let syntax = binaryOperatorExpr.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
