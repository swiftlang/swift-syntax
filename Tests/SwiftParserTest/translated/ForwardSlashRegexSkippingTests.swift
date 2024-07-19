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

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping.swift

import XCTest

final class ForwardSlashRegexSkippingTests: ParserTestCase {
  func testForwardSlashRegexSkipping3() {
    assertParse(
      #"""
      struct A {
        static let r = /test":"(.*?)"/
      }
      """#
    )
  }

  func testForwardSlashRegexSkipping4() {
    assertParse(
      """
      struct B {
        static let r = /x*/
      }
      """
    )
  }

  func testForwardSlashRegexSkipping5() {
    assertParse(
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
    assertParse(
      """
      struct D {
        func foo() {
          func bar() {
            let r = /x}}*/
          }
        }
      }
      """
    )
  }

  func testForwardSlashRegexSkipping7() {
    assertParse(
      """
      func a() { _ = /abc}}*/ }
      """
    )
  }

  func testForwardSlashRegexSkipping8() {
    assertParse(
      #"""
      func b() { _ = /\// }
      """#
    )
  }

  func testForwardSlashRegexSkipping9() {
    assertParse(
      #"""
      func c() { _ = /\\/ }
      """#
    )
  }

  func testForwardSlashRegexSkipping10() {
    assertParse(
      """
      func d() { _ = ^^/x}1️⃣}*/ }
      """
    )
  }

  func testForwardSlashRegexSkipping11() {
    assertParse(
      """
      func e() { _ = (^^/x1️⃣}2️⃣}*/) }
      """
    )
  }

  func testForwardSlashRegexSkipping12() {
    assertParse(
      """
      func f() { _ = ^^/^x}1️⃣}*/ }
      """
    )
  }

  func testForwardSlashRegexSkipping13() {
    assertParse(
      #"""
      func g() { _ = "\(/x}}*/)" }
      """#
    )
  }

  func testForwardSlashRegexSkipping14() {
    assertParse(
      #"""
      func h() { _ = "\(^^/x1️⃣}}*/)" }
      """#
    )
  }

  func testForwardSlashRegexSkipping15() {
    assertParse(
      #"""
      func i() {
        func foo<T>(_ x: T, y: T) {}
        foo(/}}*/, y: /"/)
      }
      """#
    )
  }

  func testForwardSlashRegexSkipping16() {
    assertParse(
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
    assertParse(
      """
      func k() {
        _ = 2
        / 1 / .bitWidth
      }
      """
    )
  }

  func testForwardSlashRegexSkipping18() {
    assertParse(
      """
      func l() {
        _ = 2
        /x}*/ .self
      }
      """
    )
  }

  func testForwardSlashRegexSkipping20() {
    assertParse(
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
    assertParse(
      """
      func n() {
        _ = 2
        /x}/
          .bitWidth
      }
      """
    )
  }

  func testForwardSlashRegexSkipping23() {
    assertParse(
      """
      func o() {
        _ = /x// comment
      }
      """
    )
  }

  func testForwardSlashRegexSkipping24() {
    assertParse(
      """
      func p() {
        _ = /x // comment
      }
      """
    )
  }

  func testForwardSlashRegexSkipping25() {
    assertParse(
      """
      func q() {
        _ = /x/*comment*/
      }
      """
    )
  }

  func testForwardSlashRegexSkipping26() {
    assertParse(
      """
      func r() { _ = /[(0)]/ }
      """
    )
  }

  func testForwardSlashRegexSkipping27() {
    assertParse(
      """
      func s() { _ = /(x)/ }
      """
    )
  }

  func testForwardSlashRegexSkipping28() {
    assertParse(
      """
      func t() { _ = /[)]/ }
      """
    )
  }

  func testForwardSlashRegexSkipping29() {
    assertParse(
      #"""
      func u() { _ = /[a\])]/ }
      """#
    )
  }

  func testForwardSlashRegexSkipping30() {
    assertParse(
      """
      func v() { _ = /([)])/ }
      """
    )
  }

  func testForwardSlashRegexSkipping31() {
    assertParse(
      """
      func w() { _ = /]]][)]/ }
      """
    )
  }

  func testForwardSlashRegexSkipping32() {
    assertParse(
      """
      func x() { _ = /,/ }
      """
    )
  }

  func testForwardSlashRegexSkipping33() {
    assertParse(
      """
      func y() { _ = /}/ }
      """
    )
  }

  func testForwardSlashRegexSkipping34() {
    assertParse(
      """
      func z() { _ = /]/ }
      """
    )
  }

  func testForwardSlashRegexSkipping35() {
    assertParse(
      """
      func a1() { _ = /:/ }
      """
    )
  }

  func testForwardSlashRegexSkipping36() {
    assertParse(
      """
      func a2() { _ = /;/ }
      """
    )
  }

  func testForwardSlashRegexSkipping37() {
    assertParse(
      """
      func a3() { _ = /)/ }
      """
    )
  }

  func testForwardSlashRegexSkipping38() {
    assertParse(
      """
      func a4() { _ = /1️⃣ / }
      """,
      diagnostics: [
        // TODO: Old parser had a fix-it to add backslash to escape
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      applyFixIts: [],
      fixedSource: """
        func a4() { _ = / / }
        """
    )
  }

  func testForwardSlashRegexSkipping39() {
    assertParse(
      #"""
      func a5() { _ = /\ / }
      """#
    )
  }

  func testForwardSlashRegexSkipping42() {
    assertParse(
      #"""
      func a7() { _ = /\/}/ }
      """#
    )
  }

  func testForwardSlashRegexSkipping43() {
    // Make sure we don't emit errors for these.
    assertParse(
      """
      func err1() { _ = /0xG/ }
      """
    )
  }

  func testForwardSlashRegexSkipping44() {
    assertParse(
      """
      func err2() { _ = /0oG/ }
      """
    )
  }

  func testForwardSlashRegexSkipping45() {
    assertParse(
      #"""
      func err3() { _ = /"/ }
      """#
    )
  }

  func testForwardSlashRegexSkipping46() {
    assertParse(
      """
      func err4() { _ = /'/ }
      """
    )
  }

  func testForwardSlashRegexSkipping47() {
    assertParse(
      """
      func err5() { _ = /<#placeholder#>/ }
      """
    )
  }

  func testForwardSlashRegexSkipping48() {
    assertParse(
      """
      func err6() { _ = ^^/1️⃣0xG/ }
      """
    )
  }

  func testForwardSlashRegexSkipping49() {
    assertParse(
      """
      func err7() { _ = ^^/1️⃣0oG/ }
      """
    )
  }

  func testForwardSlashRegexSkipping50() {
    assertParse(
      #"""
      func err8() { _ = ^^/"/ }1️⃣
      """#
    )
  }

  func testForwardSlashRegexSkipping51() {
    assertParse(
      """
      func err9() { _ = ^^/'/ }1️⃣
      """
    )
  }

  func testForwardSlashRegexSkipping52() {
    assertParse(
      """
      func err10() { _ = ^^/<#placeholder#>/ }
      """
    )
  }

  func testForwardSlashRegexSkipping53() {
    assertParse(
      """
      func err11() { _ = (^^/1️⃣0xG/) }
      """
    )
  }

  func testForwardSlashRegexSkipping54() {
    assertParse(
      """
      func err12() { _ = (^^/1️⃣0oG/) }
      """
    )
  }

  func testForwardSlashRegexSkipping55() {
    assertParse(
      #"""
      func err13() { _ = (^^/"/) }1️⃣
      """#
    )
  }

  func testForwardSlashRegexSkipping56() {
    assertParse(
      """
      func err14() { _ = (^^/'/) }1️⃣
      """
    )
  }

  func testForwardSlashRegexSkipping57() {
    assertParse(
      """
      func err15() { _ = (^^/<#placeholder#>/) }
      """
    )
  }

}
