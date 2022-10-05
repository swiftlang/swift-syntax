import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ReturnClauseTests: XCTestCase {
  func testReturnClause() {
    let testCases: [UInt: (ExpressibleAsReturnClause, String)] = [
      #line: (ReturnClause(returnType: "Int"), " -> Int"),
      #line: (ArrayType(elementType: "Int"), " -> [Int]"),
      #line: ("Int", " -> Int"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder.createReturnClause(), expected, line: line)
    }
  }
}
