// This test file has been translated from swift/test/Parse/string_literal_eof6.swift

import XCTest

final class StringLiteralEof6Tests: XCTestCase {
  func testStringLiteralEof61() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = #^DIAG^#"""
          foo
          \("bar
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 4: cannot find ')' to match opening '(' in string interpolation
      ]
    )
  }

}
