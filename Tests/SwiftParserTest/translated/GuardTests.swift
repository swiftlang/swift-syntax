// This test file has been translated from swift/test/Parse/guard.swift

import XCTest

final class GuardTests: XCTestCase {
  func testGuard1() {
    AssertParse(
      """
      func noConditionNoElse() {
        guard {} #^DIAG_1^#
      }
      func noCondition() {
        guard #^DIAG_2^#else {} 
      }#^DIAG_3^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: missing condition in 'guard' statement
        // TODO: Old parser expected error on line 2: expected 'else' after 'guard' condition
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected 'else' in 'guard' statement"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '{' in 'guard' statement"),
        // TODO: Old parser expected error on line 5: missing condition in 'guard' statement
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in 'guard' statement"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected '}' to end function"),
      ]
    )
  }

}
