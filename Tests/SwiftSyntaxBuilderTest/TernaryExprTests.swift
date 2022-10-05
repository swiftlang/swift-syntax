import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TernaryExprTests: XCTestCase {
  func testTernaryExpr() {
    let buildable = TernaryExpr(if: BooleanLiteralExpr(true), then: "a", else: "b")
    AssertBuildResult(buildable, """
      true ? a : b
      """)
  }
}

