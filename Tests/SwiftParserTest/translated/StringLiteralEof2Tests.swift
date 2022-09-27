// This test file has been translated from swift/test/Parse/string_literal_eof2.swift

import XCTest

final class StringLiteralEof2Tests: XCTestCase {
  func testStringLiteralEof21() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = #^DIAG^#"foo\("bar
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: #"extraneous '"foo\("bar' at top level"#),
      ]
    )
  }

}
