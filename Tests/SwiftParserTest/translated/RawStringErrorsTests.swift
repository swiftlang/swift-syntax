//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
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
        DiagnosticSpec(message: "too many '#' characters in closing delimiter")
      ]
    )
  }

  func testRawStringErrors2() {
    AssertParse(
      ###"""
      let _ = #"\#1️⃣#("invalid")"#
      """###,
      diagnostics: [
        DiagnosticSpec(message: "too many '#' characters to start string interpolation")
      ],
      fixedSource: ###"""
        let _ = #"\#("invalid")"#
        """###
    )
  }

  func testRawStringErrors3() {
    AssertParse(
      #####"""
      let _ = ###"""invalid"###1️⃣###
      """#####,
      diagnostics: [
        DiagnosticSpec(message: "too many '#' characters in closing delimiter", fixIts: ["remove extraneous delimiters"])
      ],
      fixedSource: #####"""
        let _ = ###"""invalid"###
        """#####
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
      let _ = ###"invalid"###1️⃣###
      """#####,
      diagnostics: [
        // TODO: Old parser expected error on line 1: too many '#' characters in closing delimiter, Fix-It replacements: 24 - 27 = ''
        // TODO: Old parser expected error on line 1: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 1: expected expression
        DiagnosticSpec(locationMarker: "1️⃣", message: "too many '#' characters in closing delimiter")
      ]
    )
  }

  func testRawStringErrors6() {
    AssertParse(
      ###"""
      let _ = ##"""1️⃣aa
        foobar
        aa2️⃣"""##
      """###,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "multi-line string literal content must begin on a new line"),
        // TODO: Old parser expected error on line 1: multi-line string literal content must begin on a new line, Fix-It replacements: 14 - 14 = '\n'
        DiagnosticSpec(locationMarker: "2️⃣", message: "multi-line string literal closing delimiter must begin on a new line"),
      ],
      fixedSource: ###"""
        let _ = ##"""
          aa
          foobar
          aa
          """##
        """###
    )
  }

  func testRawStringErrors7() {
    AssertParse(
      ##"""
      let _ = #"""1️⃣ foo "bar" #baz
        """#
      """##,
      diagnostics: [
        DiagnosticSpec(message: "multi-line string literal content must begin on a new line")
      ],
      fixedSource: ##"""
        let _ = #"""
           foo "bar" #baz
          """#
        """##
    )
  }

  func testRawStringErrors8() {
    AssertParse(
      ####"""
      let _ = ###"""1️⃣ "# "##
        """###
      """####,
      diagnostics: [
        DiagnosticSpec(message: "multi-line string literal content must begin on a new line")
      ],
      fixedSource: ####"""
        let _ = ###"""
           "# "##
          """###
        """####
    )
  }

}
