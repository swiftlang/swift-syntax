// This test file has been translated from swift/test/Parse/pound_assert.swift

import XCTest

final class PoundAssertTests: XCTestCase {
  func testPoundAssert1() {
    AssertParse(
      """
      #assert(true, 123)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected a string literal
      ]
    )
  }

  func testPoundAssert2() {
    AssertParse(
      #"""
      #assert(true, "error \(1) message")
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#assert' message cannot be an interpolated string literal
      ]
    )
  }

  func testPoundAssert3() {
    AssertParse(
      #"""
      #assert #^DIAG^#true, "error message")
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '(' in #assert directive
        DiagnosticSpec(message: "expected '(' in '#assert' statement"),
      ]
    )
  }

  func testPoundAssert4() {
    AssertParse(
      #"""
      #assert(#^DIAG^#, "error message")
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected a condition expression
        DiagnosticSpec(message: "expected condition in '#assert' statement"),
      ]
    )
  }

  func testPoundAssert5() {
    AssertParse(
      """
      func unbalanced1() {
        #assert(true #^DIAG^#
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected ')' in #assert directive
        // TODO: Old parser expected note on line 2: to match this opening '('
        DiagnosticSpec(message: "expected ')' to end '#assert' statement"),
      ]
    )
  }

  func testPoundAssert6() {
    AssertParse(
      #"""
      func unbalanced2() {
        #assert(true, "hello world" #^DIAG^#
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected ')' in #assert directive
        // TODO: Old parser expected note on line 2: to match this opening '('
        DiagnosticSpec(message: "expected ')' to end '#assert' statement"),
      ]
    )
  }

}
