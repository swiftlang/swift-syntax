// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping-invalid.swift

import XCTest

final class ForwardSlashRegexSkippingInvalidTests: XCTestCase {
  func testForwardSlashRegexSkippingInvalid1() {
    assertParse(
      """
      // We don't consider this a regex literal when skipping as it has an initial
      // space.
      func a() { _ = /1️⃣ x*/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "bare slash regex literal may not start with space")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid2() {
    assertParse(
      """
      // Same because of unbalanced ')'
      func b() { _ = /x1️⃣)*/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ')*/' in function")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid3() {
    assertParse(
      """
      // These also fail the heuristic, but have unbalanced `{` `}`, so we don't skip.
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
    assertParse(
      """
      // Unterminated, and unbalanced `{}`.
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
    assertParse(
      #"""
      // Unbalanced `}`, make sure we don't consider the string literal `{`.
      func n() { 2️⃣/ "{"}3️⃣/ }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(locationMarker: "2️⃣", message: #"unexpected code '/ "{"' in function"#),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous code '/ }' at top level"),
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
        // TODO: Old parser expected error on line 4: extraneous '}' at top level
        // TODO: Old parser expected error on line 4: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 4: unterminated regex literal
        // TODO: Old parser expected warning on line 4: regular expression literal is unused
        DiagnosticSpec(message: "extraneous code at top level")
        // TODO: Old parser expected warning on line 5: integer literal is unused
        // TODO: Old parser expected error on line 6: extraneous '}' at top level
        // TODO: Old parser expected error on line 7: extraneous '}' at top level
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
        // TODO: Old parser expected error on line 3: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 3: unterminated regex literal
        // TODO: Old parser expected error on line 4: value of type 'Regex<Substring>' has no member 'bitWidth'
        // TODO: Old parser expected error on line 5: extraneous '}' at top level
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
