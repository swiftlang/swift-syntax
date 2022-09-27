// This test file has been translated from swift/test/Parse/unclosed-string-interpolation.swift

import XCTest

final class UnclosedStringInterpolationTests: XCTestCase {
  func testUnclosedStringInterpolation1() {
    AssertParse(
      #"""
      let mid = "pete"
      """#
    )
  }

  func testUnclosedStringInterpolation2() {
    AssertParse(
      ##"""
      _ = #^DIAG^#"mid == \(pete"
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: #"extraneous '"mid == \(pete"' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation3() {
    AssertParse(
      ##"""
      let theGoat = #^DIAG^#"kanye \("
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous '"kanye \("' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation4() {
    AssertParse(
      ##"""
      let equation1 = #^DIAG^#"2 + 2 = \(2 + 2"
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous '"2 + 2 = \(2 + 2"' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation5() {
    AssertParse(
      ##"""
      let s = #^DIAG^#"\(x"; print(x)
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous '"\(x"; print(x)' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation6() {
    AssertParse(
      ##"""
      let zzz = #^DIAG^#"\(x; print(x)
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous '"\(x; print(x)' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation7() {
    AssertParse(
      ##"""
      let goatedAlbum = #^DIAG^#"The Life Of \("Pablo"
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous '"The Life Of \("Pablo"' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation8() {
    AssertParse(
      ##"""
      _ = #^DIAG^#"""
      \(
      """
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 2: cannot find ')' to match opening '(' in string interpolation
      ]
    )
  }

}
