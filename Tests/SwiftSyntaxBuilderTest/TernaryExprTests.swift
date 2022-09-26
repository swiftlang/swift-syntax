import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TernaryExprTests: XCTestCase {
  func testTernaryExpr() {
    let buildable = TernaryExpr(if: BooleanLiteralExpr(true), then: "a", else: "b")
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, """
      true ? a : b
      """)
  }
}

