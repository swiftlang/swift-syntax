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

// This test file has been translated from swift/test/Parse/unclosed-string-interpolation.swift

import XCTest

final class UnclosedStringInterpolationTests: XCTestCase {
  func testUnclosedStringInterpolation1() {
    assertParse(
      #"""
      let mid = "pete"
      """#
    )
  }

  func testUnclosedStringInterpolation2() {
    assertParse(
      ##"""
      _ = "mid == \(pete1️⃣"
      """##,
      diagnostics: [
        DiagnosticSpec(message: "expected ')' in string literal", fixIts: ["insert ')'"])
      ],
      fixedSource: ##"""
        _ = "mid == \(pete)"
        """##
    )
  }

  func testUnclosedStringInterpolation3() {
    assertParse(
      ##"""
      let theGoat = "kanye \("1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#, fixIts: [#"insert '"'"#]),
        DiagnosticSpec(message: "expected ')' in string literal", fixIts: ["insert ')'"]),
        DiagnosticSpec(message: #"expected '"' to end string literal"#, fixIts: [#"insert '"'"#]),
      ]
    )
  }

  func testUnclosedStringInterpolation4() {
    assertParse(
      ##"""
      let equation1 = "2 + 2 = \(2 + 21️⃣"
      """##,
      diagnostics: [
        DiagnosticSpec(message: "expected ')' in string literal", fixIts: ["insert ')'"])
      ]
    )
  }

  func testUnclosedStringInterpolation5() {
    assertParse(
      ##"""
      let s = "\(x1️⃣"; print(x)
      """##,
      diagnostics: [
        DiagnosticSpec(message: "expected ')' in string literal", fixIts: ["insert ')'"])
      ]
    )
  }

  func testUnclosedStringInterpolation6() {
    assertParse(
      ##"""
      let zzz = "\(x1️⃣; print(x)2️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '; print(x' in string literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#, fixIts: [#"insert '"'"#]),
      ]
    )
  }

  func testUnclosedStringInterpolation7() {
    assertParse(
      ##"""
      let goatedAlbum = "The Life Of \("Pablo"1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: "expected ')' in string literal", fixIts: ["insert ')'"]),
        DiagnosticSpec(message: #"expected '"' to end string literal"#, fixIts: [#"insert '"'"#]),
      ]
    )
  }

  func testUnclosedStringInterpolation8() {
    assertParse(
      ##"""
      _ = """
      \(
      """1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"""' to end string literal"#, fixIts: [#"insert '"""'"#]),
        DiagnosticSpec(message: "expected ')' in string literal", fixIts: ["insert ')'"]),
        DiagnosticSpec(message: #"expected '"""' to end string literal"#, fixIts: [#"insert '"""'"#]),
      ]
    )
  }

  func testSkipUnexpectedOpeningParensInStringLiteral() {
    assertParse(
      #"""
      "\(e 1️⃣H()r2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'H(' in string literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#, fixIts: [#"insert '"'"#]),
      ]
    )
  }

  func testUnterminatedStringLiteralInInterpolation() {
    assertParse(
      #"""
      "\("1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#, fixIts: [#"insert '"'"#]),
        DiagnosticSpec(message: "expected ')' in string literal", fixIts: ["insert ')'"]),
        DiagnosticSpec(message: #"expected '"' to end string literal"#, fixIts: [#"insert '"'"#]),
      ]
    )
  }
}
