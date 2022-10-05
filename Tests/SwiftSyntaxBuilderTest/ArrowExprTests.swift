import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ArrowExprTests: XCTestCase {
  func testArrowExpr() {
    let testCases: [UInt: (ExpressibleAsArrowExpr, String)] = [
      #line: (ArrowExpr(), " -> "),
      #line: (ArrowExpr(asyncKeyword: "async"), "async -> ")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder.createArrowExpr(), expected, line: line)
    }
  }
}
