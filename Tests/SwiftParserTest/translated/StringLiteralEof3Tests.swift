// This test file has been translated from swift/test/Parse/string_literal_eof3.swift

import XCTest

final class StringLiteralEof3Tests: XCTestCase {
  func testStringLiteralEof31() {
    AssertParse(
      ##"""
      _ = #^DIAG^#"foo \
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated string literal
        // TODO: Old parser expected error on line 1: invalid escape sequence in literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: #"extraneous '"foo \' at top level"#),
      ]
    )
  }

  func testStringLiteralEof32() {
    AssertParse(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = #^DIAG^#"foo \
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        // TODO: Old parser expected error on line 2: invalid escape sequence in literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: #"extraneous '"foo \' at top level"#),
      ]
    )
  }

}
