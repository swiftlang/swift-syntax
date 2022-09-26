import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TypeInitializerClauseTests: XCTestCase {
  func testTypeInitializerClause() {
    let testCases: [UInt: (ExpressibleAsTypeInitializerClause, String)] = [
      #line: ("String", " = String"),
      #line: (ArrayType(elementType: "String"), " = [String]")
    ]
    
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let typeInitializerClause = builder.createTypeInitializerClause()
      let syntax = typeInitializerClause.buildSyntax()
      
      var text = ""
      syntax.write(to: &text)
      
      XCTAssertEqual(text, expected, line: line)
    }
  }
}
