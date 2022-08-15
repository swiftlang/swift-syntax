import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TypeInitializerClauseTests: XCTestCase {
  func testTypeInitializerClause() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let testCases: [UInt: (ExpressibleAsTypeInitializerClause, String)] = [
      #line: ("String", "␣ = String"),
      #line: (ArrayType(elementType: "String"), "␣ = [String]")
    ]
    
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let typeInitializerClause = builder.createTypeInitializerClause()
      let syntax = typeInitializerClause.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)
      
      var text = ""
      syntax.write(to: &text)
      
      XCTAssertEqual(text, expected, line: line)
    }
  }
}
