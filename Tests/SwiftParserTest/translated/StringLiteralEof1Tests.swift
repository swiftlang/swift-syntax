// This test file has been translated from swift/test/Parse/string_literal_eof1.swift

import XCTest

final class StringLiteralEof1Tests: XCTestCase {
  func testStringLiteralEof11() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = #^DIAG^#"foo\(
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        // TODO: Old parser expected error on line 2: cannot find ')' to match opening '(' in string interpolation
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: #"extraneous '"foo\(' at top level"#),
      ]
    )
  }

}
