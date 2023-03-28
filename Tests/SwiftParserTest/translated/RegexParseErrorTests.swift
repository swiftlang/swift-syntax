// This test file has been translated from swift/test/StringProcessing/Parse/regex_parse_error.swift

import XCTest

final class RegexParseErrorTests: XCTestCase {
  func testRegexParseError1() {
    AssertParse(
      """
      _ = /(/
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ')'
      ]
    )
  }

  func testRegexParseError2() {
    AssertParse(
      """
      _ = #/(/#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ')'
      ]
    )
  }

  func testRegexParseError3() {
    AssertParse(
      """
      // FIXME: Should be 'group openings'
      """
    )
  }

  func testRegexParseError4() {
    AssertParse(
      """
      _ = 1️⃣/)/
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code '/)/' at top level"),
        // TODO: Old parser expected error on line 1: closing ')' does not balance any groups openings
      ]
    )
  }

  func testRegexParseError5() {
    AssertParse(
      """
      _ = 1️⃣#/2️⃣)/#
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ')/#' at top level"),
        // TODO: Old parser expected error on line 1: closing ')' does not balance any groups openings
      ]
    )
  }

  func testRegexParseError6() {
    AssertParse(
      #"""
      _ = 1️⃣#/\2️⃣\3️⃣/''/
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#'"),
        // TODO: Old parser expected error on line 1: unterminated regex literal
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected root in key path"),
      ]
    )
  }

  func testRegexParseError7() {
    AssertParse(
      #"""
      _ = 1️⃣#/\2️⃣|
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#'"),
        // TODO: Old parser expected error on line 1: unterminated regex literal
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code '|' at top level"),
      ]
    )
  }

  func testRegexParseError8() {
    AssertParse(
      """
      _ = 1️⃣#//
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#'"),
        // TODO: Old parser expected error on line 1: unterminated regex literal
      ]
    )
  }

  func testRegexParseError9() {
    AssertParse(
      """
      _ = 1️⃣#/xy
      """,
      diagnostics: [
        DiagnosticSpec(message: "use of unknown directive '#'"),
        // TODO: Old parser expected error on line 1: unterminated regex literal
      ]
    )
  }

  func testRegexParseError10() {
    AssertParse(
      """
      _ = #/(?/#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected group specifier
      ]
    )
  }

  func testRegexParseError11() {
    AssertParse(
      """
      _ = #/(?'/#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected group name
      ]
    )
  }

  func testRegexParseError12() {
    AssertParse(
      """
      _ = #/(?'abc/#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '''
      ]
    )
  }

  func testRegexParseError13() {
    AssertParse(
      """
      _ = #/(?'abc /#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '''
      ]
    )
  }

  func testRegexParseError14() {
    AssertParse(
      """
      do {
        _ = 1️⃣#/(2️⃣?3️⃣'a
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "use of unknown directive '#'"),
        // TODO: Old parser expected error on line 2: unterminated regex literal
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected value and ')' to end tuple"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression and ':' in 'do' statement"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression in 'do' statement"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code ''a' in 'do' statement"),
        // TODO: Old parser expected error on line 2: cannot parse regular expression: expected '''
      ]
    )
  }

  func testRegexParseError15() {
    AssertParse(
      #"""
      _ = #/\(?'abc/#
      """#
    )
  }

  func testRegexParseError16() {
    AssertParse(
      #"""
      do {
        _ = /\1️⃣
        /2️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        // TODO: Old parser expected error on line 3: expected expression path in Swift key path
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'do' statement"),
      ]
    )
  }

  func testRegexParseError17() {
    AssertParse(
      #"""
      do {
        _ = #/\
        /#
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated regex literal
        // TODO: Old parser expected error on line 2: expected escape sequence
        // TODO: Old parser expected error on line 3: expected expression
      ]
    )
  }

  func testRegexParseError18() {
    AssertParse(
      """
      func foo<T>(
        _ x: T, 
      _ y: T) {}
      """
    )
  }

  func testRegexParseError19() {
    AssertParse(
      """
      foo(#/(?/#, #/abc/#) 
      foo(#/(?C/#, #/abc/#)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected group specifier
        // TODO: Old parser expected error on line 2: expected ')'
      ]
    )
  }

  func testRegexParseError20() {
    AssertParse(
      """
      foo(#/(?'/#, #/abc/#)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected group name
      ]
    )
  }

}
