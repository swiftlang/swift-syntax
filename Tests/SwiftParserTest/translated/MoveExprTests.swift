// This test file has been translated from swift/test/Parse/move_expr.swift

import XCTest

final class MoveExprTests: XCTestCase {
  func testMoveExpr1() {
    AssertParse(
      """
      var global: Int = 5
      func testGlobal() {
          let _ = _move global
      }
      """
    )
  }

  func testMoveExpr2() {
    AssertParse(
      """
      func testLet() {
          let t = String()
          let _ = _move t
      }
      """
    )
  }

  func testMoveExpr3() {
    AssertParse(
      """
      func testVar() {
          var t = String()
          t = String()
          let _ = _move t
      }
      """
    )
  }

}
