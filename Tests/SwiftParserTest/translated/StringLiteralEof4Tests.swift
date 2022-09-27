// This test file has been translated from swift/test/Parse/string_literal_eof4.swift

import XCTest

final class StringLiteralEof4Tests: XCTestCase {
  func testStringLiteralEof41() {
    AssertParse(
      #"""
      // NOTE: DO NOT add a newline at EOF.
      _ = """
          foo#^DIAG^#
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(message: #"expected '"""' to end string literal"#),
      ]
    )
  }

}
