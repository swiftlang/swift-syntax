// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping-invalid.swift

import XCTest

final class ForwardSlashRegexSkippingInvalidTests: XCTestCase {
  func testForwardSlashRegexSkippingInvalid1() {
    AssertParse(
      """
      // We don't consider this a regex literal when skipping as it has an initial
      // space.
      func a() { _ = 1️⃣/ x*/ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: unexpected end of block comment
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "unexpected code '/ x*/' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid2() {
    AssertParse(
      """
      // Same because of unbalanced ')'
      func b() { _ = /x1️⃣)*/ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected end of block comment
        DiagnosticSpec(message: "unexpected code ')*/' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid3() {
    AssertParse(
      """
      // These also fail the heuristic, but have unbalanced `{` `}`, so we don't skip.
      func c() { _ = 1️⃣/ x}2️⃣*/ } 
      func d() { _ = 3️⃣/ x{*/ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in function"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '/ x' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '*/ }' before function"),
        // TODO: Old parser expected error on line 3: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression in function"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '}' to end function"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous code '/ x{*/ }' at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid4() {
    AssertParse(
      """
      // Unterminated, and unbalanced `{}`.
      func e() {
        _ = 1️⃣/         }
      2️⃣}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in function"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '/' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous brace at top level"),
        // TODO: Old parser expected error on line 0: unterminated regex literal
        // TODO: Old parser expected error on line 0: regex literal may not start with space; add backslash to escape
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid5() {
    AssertParse(
      """
      func f() {
        _ = 1️⃣/         {
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: unterminated regex literal
        // TODO: Old parser expected error on line 3: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "expected '}' to end function"),
        DiagnosticSpec(message: "extraneous code at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid6() {
    AssertParse(
      """
      func g() {
        _ = /x         }
      1️⃣}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: extraneous '}' at top level
        DiagnosticSpec(message: "extraneous brace at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid7() {
    AssertParse(
      """
      func h() {
        _ = /x         {
        }
      }
      """
    )
  }

  func testForwardSlashRegexSkippingInvalid8() {
    AssertParse(
      #"""
      func i() {
        _ = /x 2️⃣"[abc]     {
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(locationMarker: "2️⃣", message: #"unexpected code '"[abc]     {' in function"#),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid9() {
    AssertParse(
      """
      func j() {
        _ = 1️⃣/^ [abc]     {
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated regex literal
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "expected '}' to end function"),
        DiagnosticSpec(message: "extraneous code at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid10() {
    AssertParse(
      #"""
      func k() {
        _ = 1️⃣/^ "[abc]     {
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: #"unexpected code '/^ "[abc]     {' in function"#),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid11() {
    AssertParse(
      """
      func l() {
        _ = 1️⃣/^    } abc     {
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated regex literal
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "unexpected code '/^' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid12() {
    AssertParse(
      #"""
      func m() {
        _ = 1️⃣/ "
        }
      2️⃣}
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unterminated string literal
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in function"),
        DiagnosticSpec(locationMarker: "1️⃣", message: #"unexpected code '/ "' in function"#),
        // TODO: Old parser expected error on line 4: extraneous '}' at top level
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous brace at top level"),

      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid13() {
    AssertParse(
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
    AssertParse(
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
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected warning on line 5: integer literal is unused
        // TODO: Old parser expected error on line 6: extraneous '}' at top level
        // TODO: Old parser expected error on line 7: extraneous '}' at top level
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid15() {
    AssertParse(
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
        DiagnosticSpec(message: "extraneous code at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid17() {
    AssertParse(
      """
      func err1() { _ = 1️⃣/ 0xG}2️⃣/ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in function"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '/ 0xG' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code '/ }' at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid18() {
    AssertParse(
      """
      func err2() { _ = 1️⃣/ 0oG}2️⃣/ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in function"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '/ 0oG' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code '/ }' at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid19() {
    AssertParse(
      #"""
      func err3() { _ = 1️⃣/ {"/ }
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "expected '}' to end function"),
        DiagnosticSpec(message: #"extraneous code '/ {"/ }' at top level"#),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid20() {
    AssertParse(
      """
      func err4() { _ = 1️⃣/ {'/ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "expected '}' to end function"),
        DiagnosticSpec(message: "extraneous code '/ {'/ }' at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid21() {
    AssertParse(
      """
      func err5() { _ = 1️⃣/ {<#placeholder#>/ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "expected '}' to end function"),
        DiagnosticSpec(message: "extraneous code '/ {<#placeholder#>/ }' at top level"),
      ]
    )
  }

}
