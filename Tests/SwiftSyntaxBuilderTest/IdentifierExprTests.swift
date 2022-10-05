import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class IdentifierExprTests: XCTestCase {
  func testStringLiteral() {
    let testCases: [UInt: (ExpressibleAsIdentifierExpr, String)] = [
      #line: (IdentifierExpr(identifier: .identifier("Test")), "Test"),
      #line: (IdentifierExpr("Test"), "Test"),
      #line: ("Test", "Test")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder.createIdentifierExpr(), expected, line: line)
    }
  }
}
