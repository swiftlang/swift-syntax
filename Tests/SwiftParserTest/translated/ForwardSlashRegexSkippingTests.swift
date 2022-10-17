// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping.swift

import XCTest

final class ForwardSlashRegexSkippingTests: XCTestCase {
  func testForwardSlashRegexSkipping1() {
    AssertParse(
      """
      // Make sure we properly handle `/.../` regex literals in skipped function
      // bodies. Currently we detect them and avoid skipping, but in the future we
      // ought to be able to skip over them.
      """
    )
  }

  func testForwardSlashRegexSkipping2() {
    AssertParse(
      """
      prefix operator ^^
      prefix func ^^ <T>(_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegexSkipping3() {
    AssertParse(
      #"""
      struct A {
        static let r = /test":"(.*?)"/
      }
      """#
    )
  }

  func testForwardSlashRegexSkipping4() {
    AssertParse(
      """
      struct B {
        static let r = /x*/
      }
      """
    )
  }

  func testForwardSlashRegexSkipping5() {
    AssertParse(
      """
      struct C {
        func foo() {
          let r = /x*/
        }
      }
      """
    )
  }

  func testForwardSlashRegexSkipping6() {
    AssertParse(
      """
      struct D {
        func foo() {
          func bar() {
            let r = /x}}*/
          }1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '}' to end function"),
        DiagnosticSpec(message: "expected '}' to end struct"),
      ]
    )
  }

  func testForwardSlashRegexSkipping7() {
    AssertParse(
      """
      1️⃣}
      }
      func a() { _ = /abc}}*/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected braces before function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping8() {
    AssertParse(
      #"""
      func b() { _ = /\// }
      """#
    )
  }

  func testForwardSlashRegexSkipping9() {
    AssertParse(
      #"""
      func c() { _ = /\\/ }
      """#
    )
  }

  func testForwardSlashRegexSkipping10() {
    AssertParse(
      """
      func d() { _ = ^^/x}1️⃣}*/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code '}*/ }' at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkipping11() {
    AssertParse(
      """
      func e() { _ = (^^/x1️⃣}2️⃣}*/) }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end tuple"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code '}*/) }' at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkipping12() {
    AssertParse(
      """
      func f() { _ = ^^/^x}1️⃣}*/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code '}*/ }' at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkipping13() {
    AssertParse(
      #"""
      func g() { _ = "\(/x}}*/)" }
      """#
    )
  }

  func testForwardSlashRegexSkipping14() {
    AssertParse(
      #"""
      func h() { _ = "\(^^/x1️⃣}}*/)" }
      """#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '}}*/' in string literal"),
      ]
    )
  }

  func testForwardSlashRegexSkipping15() {
    AssertParse(
      #"""
      func i() {
        func foo<T>(_ x: T, y: T) {}
        foo(/}}*/, y: /"/)
      }
      """#
    )
  }

  func testForwardSlashRegexSkipping16() {
    AssertParse(
      """
      func j() {
        _ = {
          0
          /x}}}/ 
          2
        }
      }
      """
    )
  }

  func testForwardSlashRegexSkipping17() {
    AssertParse(
      """
      func k() {
        _ = 2
        / 1 / .bitWidth
      }
      """
    )
  }

  func testForwardSlashRegexSkipping18() {
    AssertParse(
      """
      func l() {
        _ = 2
        /x}*/ .self1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '}' to end function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping19() {
    AssertParse(
      """
      1️⃣}
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous brace at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkipping20() {
    AssertParse(
      """
      func m() {
        _ = 2
        / 1 /
          .bitWidth
      }
      """
    )
  }

  func testForwardSlashRegexSkipping21() {
    AssertParse(
      """
      func n() {
        _ = 2
        /x}/1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '}' to end function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping22() {
    AssertParse(
      """
      .bitWidth
      1️⃣}
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous brace at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkipping23() {
    AssertParse(
      """
      func o() {
        _ = /x// comment
      }
      """
    )
  }

  func testForwardSlashRegexSkipping24() {
    AssertParse(
      """
      func p() {
        _ = /x // comment
      }
      """
    )
  }

  func testForwardSlashRegexSkipping25() {
    AssertParse(
      """
      func q() {
        _ = /x/*comment*/
      }
      """
    )
  }

  func testForwardSlashRegexSkipping26() {
    AssertParse(
      """
      func r() { _ = /[(0)]/ }
      """
    )
  }

  func testForwardSlashRegexSkipping27() {
    AssertParse(
      """
      func s() { _ = /(x)/ }
      """
    )
  }

  func testForwardSlashRegexSkipping28() {
    AssertParse(
      """
      func t() { _ = /[1️⃣)]/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ']' to end array"),
        DiagnosticSpec(message: "unexpected code ')]/' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping29() {
    AssertParse(
      #"""
      func u() { _ = /[a\1️⃣]2️⃣)]/ }
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code ')]/' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping30() {
    AssertParse(
      """
      func v() { _ = /([1️⃣)2️⃣])/ }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ']' to end array"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '])/' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping31() {
    AssertParse(
      """
      func w() { _ = 1️⃣/]]][)]/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "expected '}' to end function"),
        DiagnosticSpec(message: "extraneous code '/]]][)]/ }' at top level"),
      ]
    )
  }

  func testForwardSlashRegexSkipping32() {
    AssertParse(
      """
      func x() { _ = /,/ }
      """
    )
  }

  func testForwardSlashRegexSkipping33() {
    AssertParse(
      """
      func y() { _ = /}/ }
      """
    )
  }

  func testForwardSlashRegexSkipping34() {
    AssertParse(
      """
      func z() { _ = /]/ }
      """
    )
  }

  func testForwardSlashRegexSkipping35() {
    AssertParse(
      """
      func a1() { _ = /:/ }
      """
    )
  }

  func testForwardSlashRegexSkipping36() {
    AssertParse(
      """
      func a2() { _ = /;/ }
      """
    )
  }

  func testForwardSlashRegexSkipping37() {
    AssertParse(
      """
      func a3() { _ = 1️⃣/)/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "unexpected code '/)/' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping38() {
    AssertParse(
      """
      func a4() { _ = 1️⃣/ / }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: regex literal may not start with space; add backslash to escape
        DiagnosticSpec(message: "expected expression in function"),
        DiagnosticSpec(message: "unexpected code '/ /' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping39() {
    AssertParse(
      #"""
      func a5() { _ = /\ 1️⃣/ 2️⃣}
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping40() {
    AssertParse(
      """
      prefix operator /
      prefix func / <T> (_ x: T) -> T { x }
      """
    )
  }

  func testForwardSlashRegexSkipping41() {
    AssertParse(
      """
      enum E {
        case e
        func foo<T>(_ x: T) {}
      }
      """
    )
  }

  func testForwardSlashRegexSkipping42() {
    AssertParse(
      #"""
      func a7() { _ = /\/}/ }
      """#
    )
  }

  func testForwardSlashRegexSkipping43() {
    AssertParse(
      """
      // Make sure we don't emit errors for these.
      func err1() { _ = /0xG/ }
      """
    )
  }

  func testForwardSlashRegexSkipping44() {
    AssertParse(
      """
      func err2() { _ = /0oG/ }
      """
    )
  }

  func testForwardSlashRegexSkipping45() {
    AssertParse(
      #"""
      func err3() { _ = /"/ }
      """#
    )
  }

  func testForwardSlashRegexSkipping46() {
    AssertParse(
      """
      func err4() { _ = /'/ }
      """
    )
  }

  func testForwardSlashRegexSkipping47() {
    AssertParse(
      """
      func err5() { _ = /<#placeholder#>/ }
      """
    )
  }

  func testForwardSlashRegexSkipping48() {
    AssertParse(
      """
      func err6() { _ = ^^/1️⃣0xG/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in prefix operator expression"),
        DiagnosticSpec(message: "unexpected code '0xG/' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping49() {
    AssertParse(
      """
      func err7() { _ = ^^/1️⃣0oG/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in prefix operator expression"),
        DiagnosticSpec(message: "unexpected code '0oG/' in function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping50() {
    AssertParse(
      #"""
      func err8() { _ = ^^/"/ }1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#),
        DiagnosticSpec(message: "expected '}' to end function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping51() {
    AssertParse(
      """
      func err9() { _ = ^^/'/ }1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ''' in string literal"),
        DiagnosticSpec(message: "expected '}' to end function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping52() {
    AssertParse(
      """
      func err10() { _ = ^^/<#placeholder#>/ }
      """
    )
  }

  func testForwardSlashRegexSkipping53() {
    AssertParse(
      """
      func err11() { _ = (^^/1️⃣0xG/) }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in prefix operator expression"),
        DiagnosticSpec(message: "unexpected code '0xG/' in tuple"),
      ]
    )
  }

  func testForwardSlashRegexSkipping54() {
    AssertParse(
      """
      func err12() { _ = (^^/1️⃣0oG/) }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in prefix operator expression"),
        DiagnosticSpec(message: "unexpected code '0oG/' in tuple"),
      ]
    )
  }

  func testForwardSlashRegexSkipping55() {
    AssertParse(
      #"""
      func err13() { _ = (^^/"/) }1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#),
        DiagnosticSpec(message: "expected ')' to end tuple"),
        DiagnosticSpec(message: "expected '}' to end function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping56() {
    AssertParse(
      """
      func err14() { _ = (^^/'/) }1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ''' in string literal"),
        DiagnosticSpec(message: "expected ')' to end tuple"),
        DiagnosticSpec(message: "expected '}' to end function"),
      ]
    )
  }

  func testForwardSlashRegexSkipping57() {
    AssertParse(
      """
      func err15() { _ = (^^/<#placeholder#>/) }
      """
    )
  }

}
