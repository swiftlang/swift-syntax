//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/raw_string_errors.swift

import XCTest

final class RawStringErrorsTests: XCTestCase {
  func testRawStringErrors1() {
    AssertParse(
      ###"""
      let _ = "foo\(#"bar"#1️⃣#)baz"
      """###,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in closing delimiter
        // TODO: Old parser expected error on line 1: expected ',' separator
        // TODO: Old parser expected error on line 1: expected expression in list of expressions
        DiagnosticSpec(message: "unexpected code '#' in string literal")
      ]
    )
  }

  func testRawStringErrors2() {
    AssertParse(
      ###"""
      let _ = 1️⃣#"\##("invalid")"#
      """###,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in delimited escape
        // TODO: Old parser expected error on line 1: invalid escape sequence in literal
      ]
    )
  }

  func testRawStringErrors3() {
    AssertParse(
      #####"""
      let _ = ###"""invalid"###1️⃣#2️⃣#3️⃣#4️⃣
      """#####,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in closing delimiter, Fix-It replacements: 26 - 29 = ''
        // TODO: Old parser expected error on line 1: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 1: expected expression
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in pound literal expression"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in pound literal expression"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected identifier in pound literal expression"),
      ]
    )
  }

  func testRawStringErrors4() {
    AssertParse(
      #####"""
      let _ = ####"invalid"###1️⃣
      """#####,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: #####"expected '"####' to end string literal"#####)
      ]
    )
  }

  func testRawStringErrors5() {
    AssertParse(
      #####"""
      let _ = ###"invalid"###1️⃣#2️⃣#3️⃣#4️⃣
      """#####,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in closing delimiter, Fix-It replacements: 24 - 27 = ''
        // TODO: Old parser expected error on line 1: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 1: expected expression
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in pound literal expression"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in pound literal expression"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected identifier in pound literal expression"),
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
