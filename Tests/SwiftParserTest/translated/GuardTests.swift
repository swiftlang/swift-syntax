// This test file has been translated from swift/test/Parse/guard.swift

import XCTest

final class GuardTests: XCTestCase {
  func testGuard1() {
    AssertParse(
      """
      func noConditionNoElse() {
        guard {} 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'else' and body in 'guard' statement"),
      ]
    )
  }

  func testGuard2() {
    AssertParse(
      """
      func noCondition() {
        guard 1️⃣else {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected conditions in 'guard' statement"),
      ]
    )
  }
}
