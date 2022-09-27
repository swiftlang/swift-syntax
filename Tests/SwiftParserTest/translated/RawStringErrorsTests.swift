// This test file has been translated from swift/test/Parse/raw_string_errors.swift

import XCTest

final class RawStringErrorsTests: XCTestCase {
  func testRawStringErrors1() {
    AssertParse(
      ###"""
      let _ = "foo\(#"bar"##^DIAG^##)baz"
      """###,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in closing delimiter
        // TODO: Old parser expected error on line 1: expected ',' separator
        // TODO: Old parser expected error on line 1: expected expression in list of expressions
        DiagnosticSpec(message: "unexpected text '#' in string literal"),
      ]
    )
  }

  func testRawStringErrors2() {
    AssertParse(
      ###"""
      let _ = #^DIAG^##"\##("invalid")"#
      """###,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in delimited escape
        // TODO: Old parser expected error on line 1: invalid escape sequence in literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: ###"extraneous '#"\##("invalid")"#' at top level"###),
      ]
    )
  }

  func testRawStringErrors3() {
    AssertParse(
      #####"""
      let _ = ###"""invalid"####^DIAG^####
      """#####,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in closing delimiter, Fix-It replacements: 26 - 29 = ''
        // TODO: Old parser expected error on line 1: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 1: expected expression
        DiagnosticSpec(message: "extraneous '###' at top level"),
      ]
    )
  }

  func testRawStringErrors4() {
    AssertParse(
      #####"""
      let _ = ####"invalid"####^DIAG^#
      """#####,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: #####"expected '"####' to end string literal"#####),
      ]
    )
  }

  func testRawStringErrors5() {
    AssertParse(
      #####"""
      let _ = ###"invalid"####^DIAG^####
      """#####,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in closing delimiter, Fix-It replacements: 24 - 27 = ''
        // TODO: Old parser expected error on line 1: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 1: expected expression
        DiagnosticSpec(message: "extraneous '###' at top level"),
      ]
    )
  }

  func testRawStringErrors6() {
    AssertParse(
      ###"""
      let _ = ##"""aa
        foobar
        aa"""##
      """###,
      diagnostics: [
        // TODO: Old parser expected error on line 1: multi-line string literal content must begin on a new line, Fix-It replacements: 14 - 14 = '\n'
        // TODO: Old parser expected error on line 3: multi-line string literal closing delimiter must begin on a new line, Fix-It replacements: 5 - 5 = '\n'
      ]
    )
  }

  func testRawStringErrors7() {
    AssertParse(
      ##"""
      let _ = #""" foo "bar" #baz
        """#
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: multi-line string literal content must begin on a new line, Fix-It replacements: 13 - 13 = '\n'
      ]
    )
  }

  func testRawStringErrors8() {
    AssertParse(
      ####"""
      let _ = ###""" "# "##
        """###
      """####,
      diagnostics: [
        // TODO: Old parser expected error on line 1: multi-line string literal content must begin on a new line, Fix-It replacements: 15 - 15 = '\n'
      ]
    )
  }

}
