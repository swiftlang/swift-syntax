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

// This test file has been translated from swift/test/Parse/availability_query.swift

import XCTest

final class AvailabilityQueryTests: XCTestCase {
  func testAvailabilityQuery1() {
    assertParse(
      """
      if #available(OSX 10.51, *) {
      }
      """
    )
  }

  func testAvailabilityQuery2() {
    assertParse(
      """
      // Disallow use as an expression.
      if (1️⃣#available(OSX 10.51, *)) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'")
      ]
    )
  }

  func testAvailabilityQuery3() {
    assertParse(
      """
      let x = 1️⃣#available(OSX 10.51, *)
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'")
      ]
    )
  }

  func testAvailabilityQuery4() {
    assertParse(
      """
      (1️⃣#available(OSX 10.51, *) ? 1 : 0)
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'")
      ]
    )
  }

  func testAvailabilityQuery5a() {
    assertParse(
      """
      if !1️⃣#available(OSX 10.52, *) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression; did you mean '#unavailable'?", fixIts: ["replace '!#available' with '#unavailable'"])
      ],
      fixedSource: """
        if #unavailable(OSX 10.52, *) {
        }
        """
    )
  }

  func testAvailabilityQuery5b() {
    assertParse(
      """
      if let _ = Optional(5), !1️⃣#available(OSX 10.52, *) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression; did you mean '#unavailable'?", fixIts: ["replace '!#available' with '#unavailable'"])
      ]
    )
  }

  func testAvailabilityQuery6() {
    assertParse(
      """
      if #available(OSX 10.51, *) 1️⃣&& #available(OSX 10.52, *) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' joining parts of a multi-clause condition", fixIts: ["replace '&&' with ','"])
      ],
      fixedSource: """
        if #available(OSX 10.51, *) , #available(OSX 10.52, *) {
        }
        """
    )
  }

  func testAvailabilityQuery7() {
    assertParse(
      """
      if #available 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '(', '@availability' arguments, and ')' in availability condition",
          fixIts: ["insert '(', '@availability' arguments, and ')'"]
        )
      ]
    )
  }

  func testAvailabilityQuery8() {
    assertParse(
      """
      if #available( 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected platform and ')' to end availability condition", fixIts: ["insert platform and ')'"])
      ]
    )
  }

  func testAvailabilityQuery9() {
    assertParse(
      """
      if #available(1️⃣) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument", fixIts: ["insert version restriction"])
      ]
    )
  }

  func testAvailabilityQuery10() {
    assertParse(
      """
      if #availableℹ️(OSX 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end availability condition",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ],
          fixIts: ["insert ')'"]
        )
      ]
    )
  }

  func testAvailabilityQuery11() {
    assertParse(
      """
      if #available(OSX) {
      }
      """
    )
  }

  func testAvailabilityQuery12() {
    assertParse(
      """
      if #availableℹ️(OSX 10.51 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end availability condition",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ],
          fixIts: ["insert ')'"]
        )
      ]
    )
  }

  func testAvailabilityQuery13() {
    assertParse(
      """
      if #available(iDishwasherOS 10.51) {
      }
      """
    )
  }

  func testAvailabilityQuery14() {
    assertParse(
      """
      if #available(iDishwasherOS 10.51, *) {
      }
      """
    )
  }

  func testAvailabilityQuery15() {
    assertParse(
      """
      if #available(macos 10.51, *) {
      }
      """
    )
  }

  func testAvailabilityQuery16() {
    assertParse(
      """
      if #available(mscos 10.51, *) {
      }
      """
    )
  }

  func testAvailabilityQuery17() {
    assertParse(
      """
      if #available(macoss 10.51, *) {
      }
      """
    )
  }

  func testAvailabilityQuery18() {
    assertParse(
      """
      if #available(mac 10.51, *) {
      }
      """
    )
  }

  func testAvailabilityQuery19() {
    assertParse(
      """
      if #available(OSX 10.51, OSX 10.52, *) {
      }
      """
    )
  }

  func testAvailabilityQuery20() {
    assertParse(
      """
      if #available(OSX 10.52) { }
      """
    )
  }

  func testAvailabilityQuery21() {
    assertParse(
      """
      if #available(OSX 10.51, iOS 8.0) { }
      """
    )
  }

  func testAvailabilityQuery22() {
    assertParse(
      """
      if #available(iOS 8.0, *) {
      }
      """
    )
  }

  func testAvailabilityQuery23() {
    assertParse(
      """
      if #available(iOSApplicationExtension, unavailable) { // expected-error 2{{expected version number}}
      }
      """
    )
  }

  func testAvailabilityQuery24() {
    assertParse(
      """
      // Want to make sure we can parse this. Perhaps we should not let this validate, though.
      if #available(*) {
      }
      """
    )
  }

  func testAvailabilityQuery25() {
    assertParse(
      """
      if #availableℹ️(* 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end availability condition",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ],
          fixIts: ["insert ')'"]
        )
      ]
    )
  }

  func testAvailabilityQuery26() {
    assertParse(
      """
      // Multiple platforms
      if #available(OSX 10.51, iOS 8.0, *) {
      }
      """
    )
  }

  func testAvailabilityQuery27() {
    assertParse(
      """
      if #available(OSX 10.51, 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument", fixIts: ["insert version restriction"]),
        DiagnosticSpec(message: "expected ')' to end availability condition", fixIts: ["insert ')'"]),
      ]
    )
  }

  func testAvailabilityQuery28() {
    assertParse(
      """
      if #available(OSX 10.51,1️⃣) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument", fixIts: ["insert version restriction"])
      ]
    )
  }

  func testAvailabilityQuery29() {
    assertParse(
      """
      if #availableℹ️(OSX 10.51, iOS 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end availability condition",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ],
          fixIts: ["insert ')'"]
        )
      ]
    )
  }

  func testAvailabilityQuery30() {
    assertParse(
      """
      if #available(OSX 10.51, iOS 8.0, iDishwasherOS 10.51) {
      }
      """
    )
  }

  func testAvailabilityQuery31() {
    assertParse(
      """
      if #available(iDishwasherOS 10.51, OSX 10.51) {
      }
      """
    )
  }

  func testAvailabilityQuery32() {
    assertParse(
      """
      if #available(OSX 10.51 1️⃣|| iOS 8.0) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' joining platforms in availability condition", fixIts: ["replace '||' with ','"])
      ],
      fixedSource: """
        if #available(OSX 10.51 , iOS 8.0) {
        }
        """
    )
  }

  func testAvailabilityQuery33() {
    assertParse(
      """
      // Emit Fix-It removing un-needed >=, for the moment.
      """
    )
  }

  func testAvailabilityQuery34() {
    assertParse(
      """
      if #available(OSX 1️⃣>= 10.51, *) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "version comparison not needed", fixIts: ["remove '>='"])
      ],
      fixedSource: """
        if #available(OSX 10.51, *) {
        }
        """
    )
  }

  func testAvailabilityQuery35() {
    assertParse(
      """
      // Bool then #available.
      if 1 != 2, #available(iOS 8.0, *) {}
      """
    )
  }

  func testAvailabilityQuery36() {
    assertParse(
      """
      // Pattern then #available(iOS 8.0, *) {
      if case 42 = 42, #available(iOS 8.0, *) {}
      if let _ = Optional(42), #available(iOS 8.0, *) {}
      """
    )
  }

  func testAvailabilityQuery37() {
    assertParse(
      #"""
      // Allow "macOS" as well.
      if #available(macOS 10.51, *) {
      }
      """#
    )
  }

}
