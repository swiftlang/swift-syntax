//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping-invalid.swift

import XCTest

final class ForwardSlashRegexSkippingInvalidTests: XCTestCase {
  func testForwardSlashRegexSkippingInvalid1() {
    // We don't consider this a regex literal when skipping as it has an initial
    // space.
    assertParse(
      """
      func a() { _ = /1️⃣ x*/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid2() {
    // Same because of unbalanced ')'
    assertParse(
      """
      func b() { _ = /x1️⃣)*/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ')*/' in function")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid3() {
    // These also fail the heuristic, but have unbalanced `{` `}`, so we don't skip.
    assertParse(
      """
      func c() { _ = /1️⃣ x}*/ }
      func d() { _ = /2️⃣ x{*/ }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "bare slash regex literal may not start with space"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "bare slash regex literal may not start with space"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid4() {
    // Unterminated, and unbalanced `{}`.
    assertParse(
      """
      func e() {
        _ = /1️⃣         }2️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "bare slash regex literal may not start with space"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '/' to end regex literal"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid5() {
    assertParse(
      """
      func f() {
        _ = /1️⃣         {2️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "bare slash regex literal may not start with space"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '/' to end regex literal"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid6() {
    assertParse(
      """
      func g() {
        _ = /x         }
      1️⃣}
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous brace at top level")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid7() {
    assertParse(
      """
      func h() {
        _ = /x         {
        }
      }
      """
    )
  }

  func testForwardSlashRegexSkippingInvalid8() {
    assertParse(
      #"""
      func i() {
        _ = /x1️⃣ "[abc]     {2️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid9() {
    assertParse(
      """
      func j() {
        _ = /^ [abc]     {1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '/' to end regex literal")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid10() {
    assertParse(
      #"""
      func k() {
        _ = /^ "[abc]     {1️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected '/' to end regex literal")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid11() {
    assertParse(
      """
      func l() {
        _ = /^    } abc     {1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '/' to end regex literal")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid12() {
    assertParse(
      #"""
      func m() {
        _ = /1️⃣ "2️⃣
      }
      3️⃣}
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "bare slash regex literal may not start with space"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '/' to end regex literal"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous brace at top level"),

      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid13() {
    // Unbalanced `}`, make sure we don't consider the string literal `{`.
    assertParse(
      #"""
      func n() { /1️⃣ "{"}/ }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid14() {
    assertParse(
      """
      func o() {
        _ = {
          0
          /x}}1️⃣} /
          2
        } 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code at top level")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid15() {
    assertParse(
      """
      func p() {
        _ = 2
        /x} 1️⃣/
        .bitWidth
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code at top level")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid17() {
    assertParse(
      """
      func err1() { _ = /1️⃣ 0xG}/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid18() {
    assertParse(
      """
      func err2() { _ = /1️⃣ 0oG}/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid19() {
    assertParse(
      """
      func err3() { _ = /1️⃣ {"/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid20() {
    assertParse(
      """
      func err4() { _ = /1️⃣ {'/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid21() {
    assertParse(
      """
      func err5() { _ = /1️⃣ {<#placeholder#>/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }
}
