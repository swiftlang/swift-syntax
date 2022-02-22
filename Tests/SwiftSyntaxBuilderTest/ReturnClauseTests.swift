import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ReturnClauseTests: XCTestCase {
  func testReturnClause() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (ExpressibleAsReturnClause, String)] = [
      #line: (ReturnClause(returnType: "Int"), "␣-> Int"),
      #line: (ArrayType(elementType: "Int"), "␣-> [Int]"),
      #line: ("Int", "␣-> Int"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let returnClause = builder.createReturnClause()
      let syntax = returnClause.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
