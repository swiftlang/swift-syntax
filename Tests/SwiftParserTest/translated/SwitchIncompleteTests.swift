// This test file has been translated from swift/test/Parse/switch_incomplete.swift

import XCTest

final class SwitchIncompleteTests: XCTestCase {
  func testSwitchIncomplete1() {
    AssertParse(
      """
      // <rdar://problem/15971438> Incomplete switch was parsing to an AST that
      // triggered an assertion failure.
      switch 1 #^NOTE^#{ 
      case 1:#^DIAG^#
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '}' to end 'switch' statement", notes: [
          NoteSpec(message: "to match this opening '{'")
        ]),
      ]
    )
  }

}
