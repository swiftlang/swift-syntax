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
      AssertBuildResult(builder.createTypeInitializerClause(), expected, line: line)
    }
  }
}
