// This test file has been translated from swift/test/Parse/guard.swift

import XCTest

final class GuardTests: XCTestCase {
  func testGuard1() {
    AssertParse(
      """
      func noConditionNoElse() {
        guard {} 1️⃣
      }
      func noCondition() {
        guard 2️⃣else {} 
      }3️⃣
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: missing condition in 'guard' statement
        // TODO: Old parser expected error on line 2: expected 'else' after 'guard' condition
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'else' in 'guard' statement"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected code block in 'guard' statement"),
        // TODO: Old parser expected error on line 5: missing condition in 'guard' statement
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'guard' statement"),
      ]
    )
  }

}
