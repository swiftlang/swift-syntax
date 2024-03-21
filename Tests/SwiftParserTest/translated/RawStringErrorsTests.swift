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

final class RawStringErrorsTests: ParserTestCase {
  func testRawStringErrors1() {
    assertParse(
      ###"""
      let _ = "foo\(#"bar"#1️⃣#)baz"
      """###,
      diagnostics: [
        DiagnosticSpec(
          message: "too many '#' characters in closing delimiter",
          fixIts: ["remove extraneous delimiters"]
        )
      ],
      fixedSource: ###"""
        let _ = "foo\(#"bar"#)baz"
        """###
    )
  }

  func testRawStringErrors2() {
    assertParse(
      ###"""
      let _ = #"\#1️⃣#("invalid")"#
      """###,
      diagnostics: [
        DiagnosticSpec(
          message: "too many '#' characters to start string interpolation",
          fixIts: ["remove extraneous delimiters"]
        )
      ],
      fixedSource: ###"""
        let _ = #"\#("invalid")"#
        """###
    )
  }

  func testRawStringErrors3() {
    assertParse(
      #####"""
      let _ = ###"""invalid"###1️⃣###
      """#####,
      diagnostics: [
        DiagnosticSpec(
          message: "too many '#' characters in closing delimiter",
          fixIts: ["remove extraneous delimiters"]
        )
      ],
      fixedSource: #####"""
        let _ = ###"""invalid"###
        """#####
    )
  }

  func testRawStringErrors4() {
    assertParse(
      #####"""
      let _ = ####"invalid"###1️⃣
      """#####,
      diagnostics: [
        DiagnosticSpec(
          message: #####"expected '"####' to end string literal"#####,
          fixIts: [#####"insert '"####'"#####]
        )
      ],
      fixedSource: #####"""
        let _ = ####"invalid"###"####
        """#####
    )
  }

  func testRawStringErrors5() {
    assertParse(
      #####"""
      let _ = ###"invalid"###1️⃣###
      """#####,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "too many '#' characters in closing delimiter",
          fixIts: ["remove extraneous delimiters"]
        )
      ],
      fixedSource: #####"""
        let _ = ###"invalid"###
        """#####
    )
  }

  func testRawStringErrors6() {
    assertParse(
      ###"""
      let _ = ##"""1️⃣aa
        foobar
        aa2️⃣"""##
      """###,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "multi-line string literal content must begin on a new line",
          fixIts: ["insert newline"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "multi-line string literal closing delimiter must begin on a new line",
          fixIts: ["insert newline"]
        ),
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
    assertParse(
      ##"""
      let _ = #"""1️⃣ foo "bar" #baz
        """#
      """##,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal content must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: ##"""
        let _ = #"""
           foo "bar" #baz
          """#
        """##
    )
  }

  func testRawStringErrors8() {
    assertParse(
      ####"""
      let _ = ###"""1️⃣ "# "##
        """###
      """####,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal content must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: ####"""
        let _ = ###"""
           "# "##
          """###
        """####
    )
  }

}
