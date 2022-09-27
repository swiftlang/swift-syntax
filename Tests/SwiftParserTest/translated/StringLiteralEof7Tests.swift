// This test file has been translated from swift/test/Parse/string_literal_eof7.swift

import XCTest

final class StringLiteralEof7Tests: XCTestCase {
  func testStringLiteralEof71() {
    AssertParse(
      ##"""
      _ = #^DIAG^#"""
          foo
          \("bar
          baz
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 3: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 3: unterminated string literal
      ]
    )
  }

}
