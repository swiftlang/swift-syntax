// This test file has been translated from swift/test/Parse/brace_recovery_eof.swift

import XCTest

final class BraceRecoveryEofTests: XCTestCase {
  func testBraceRecoveryEof1() {
    AssertParse(
      """
      // Make sure source ranges satisfy the verifier.
      for foo in [1, 2] #^NOTE^#{
        _ = foo#^DIAG^#
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '}' to end 'for' statement", notes: [
          NoteSpec(message: "to match this opening '{'")
        ]),
      ]
    )
  }

}
