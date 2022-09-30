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
        DiagnosticSpec(message: "expected '(' in '#assert' directive"),
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
        DiagnosticSpec(message: "expected condition in '#assert' directive"),
      ]
    )
  }

  func testPoundAssert5() {
    AssertParse(
      """
      func unbalanced1() {
        #assert#^NOTE^#(true #^DIAG^#
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ')' to end '#assert' directive", notes: [
          NoteSpec(message: "to match this opening '('")
        ]),
      ]
    )
  }

  func testPoundAssert6() {
    AssertParse(
      #"""
      func unbalanced2() {
        #assert#^NOTE^#(true, "hello world" #^DIAG^#
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected ')' to end '#assert' directive", notes: [
          NoteSpec(message: "to match this opening '('")
        ]),
      ]
    )
  }

}
