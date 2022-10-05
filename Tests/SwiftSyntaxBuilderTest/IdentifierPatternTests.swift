import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class IdentifierPatternTests: XCTestCase {
  func testStringLiteral() {
    let testCases: [UInt: (ExpressibleAsIdentifierPattern, String)] = [
      #line: (IdentifierPattern(identifier: .identifier("Test")), "Test"),
      #line: (IdentifierPattern("Test"), "Test"),
      #line: ("Test", "Test")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder.createIdentifierPattern(), expected, line: line)
    }
  }
}
