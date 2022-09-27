// This test file has been translated from swift/test/Parse/switch_incomplete.swift

import XCTest

final class SwitchIncompleteTests: XCTestCase {
  func testSwitchIncomplete1() {
    AssertParse(
      """
      // <rdar://problem/15971438> Incomplete switch was parsing to an AST that
      // triggered an assertion failure.
      switch 1 { 
      case 1:#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: switch must be exhaustive
        // TODO: Old parser expected note on line 3: do you want to add a default clause?
        // TODO: Old parser expected note on line 3: to match this opening '{'
        DiagnosticSpec(message: "expected '}' to end 'switch' statement"),
        // TODO: Old parser expected error on line 5: expected '}' at end of 'switch' statement
      ]
    )
  }

}
