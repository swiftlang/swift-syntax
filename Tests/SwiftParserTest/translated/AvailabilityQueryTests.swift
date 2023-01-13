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

// This test file has been translated from swift/test/Parse/availability_query.swift

import XCTest

final class AvailabilityQueryTests: XCTestCase {
  func testAvailabilityQuery1() {
    AssertParse(
      """
      if #available(OSX 10.51, *) {
      }
      """
    )
  }

  func testAvailabilityQuery2() {
    AssertParse(
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
    AssertParse(
      """
      let x = 1️⃣#available(OSX 10.51, *)
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'")
      ]
    )
  }

  func testAvailabilityQuery4() {
    AssertParse(
      """
      (1️⃣#available(OSX 10.51, *) ? 1 : 0)
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'")
      ]
    )
  }

  func testAvailabilityQuery5a() {
    AssertParse(
      """
      if !1️⃣#available(OSX 10.52, *) { 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression; did you mean '#unavailable'?", fixIts: ["replace '!#available' by '#unavailable'"])
      ],
      fixedSource: """
        if #unavailable(OSX 10.52, *) {
        }
        """
    )
  }

  func testAvailabilityQuery5b() {
    AssertParse(
      """
      if let _ = Optional(5), !1️⃣#available(OSX 10.52, *) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression; did you mean '#unavailable'?", fixIts: ["replace '!#available' by '#unavailable'"])
      ]
    )
  }

  func testAvailabilityQuery6() {
    AssertParse(
      """
      if #available(OSX 10.51, *) 1️⃣&& #available(OSX 10.52, *) { 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' joining parts of a multi-clause condition", fixIts: ["replace '&&' by ','"])
      ],
      fixedSource: """
        if #available(OSX 10.51, *) , #available(OSX 10.52, *) {
        }
        """
    )
  }

  func testAvailabilityQuery7() {
    AssertParse(
      """
      if #available 1️⃣{ 
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(', '@availability' arguments, and ')' in availability condition")
      ]
    )
  }

  func testAvailabilityQuery8() {
    AssertParse(
      """
      if #available( 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument"),
        DiagnosticSpec(message: "expected ')' to end availability condition"),
      ]
    )
  }

  func testAvailabilityQuery9() {
    AssertParse(
      """
      if #available(1️⃣) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument")
      ]
    )
  }

  func testAvailabilityQuery10() {
    AssertParse(
      """
      if #availableℹ️(OSX 1️⃣{
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected version number
        DiagnosticSpec(
          message: "expected ')' to end availability condition",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ]
        )
      ]
    )
  }

  func testAvailabilityQuery11() {
    AssertParse(
      """
      if #available(OSX) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected version number
      ]
    )
  }

  func testAvailabilityQuery12() {
    AssertParse(
      """
      if #availableℹ️(OSX 10.51 1️⃣{
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ')'
        DiagnosticSpec(
          message: "expected ')' to end availability condition",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ]
        )
      ]
    )
  }

  func testAvailabilityQuery13() {
    AssertParse(
      """
      if #available(iDishwasherOS 10.51) { 
      }
      """
    )
  }

  func testAvailabilityQuery14() {
    AssertParse(
      """
      if #available(iDishwasherOS 10.51, *) { 
      }
      """
    )
  }

  func testAvailabilityQuery15() {
    AssertParse(
      """
      if #available(macos 10.51, *) { 
      }
      """
    )
  }

  func testAvailabilityQuery16() {
    AssertParse(
      """
      if #available(mscos 10.51, *) { 
      }
      """
    )
  }

  func testAvailabilityQuery17() {
    AssertParse(
      """
      if #available(macoss 10.51, *) { 
      }
      """
    )
  }

  func testAvailabilityQuery18() {
    AssertParse(
      """
      if #available(mac 10.51, *) { 
      }
      """
    )
  }

  func testAvailabilityQuery19() {
    AssertParse(
      """
      if #available(OSX 10.51, OSX 10.52, *) {  
      }
      """
    )
  }

  func testAvailabilityQuery20() {
    AssertParse(
      """
      if #available(OSX 10.52) { }
      """
    )
  }

  func testAvailabilityQuery21() {
    AssertParse(
      """
      if #available(OSX 10.51, iOS 8.0) { }
      """
    )
  }

  func testAvailabilityQuery22() {
    AssertParse(
      """
      if #available(iOS 8.0, *) {
      }
      """
    )
  }

  func testAvailabilityQuery23() {
    AssertParse(
      """
      if #available(iOSApplicationExtension, unavailable) { // expected-error 2{{expected version number}}
      }
      """
    )
  }

  func testAvailabilityQuery24() {
    AssertParse(
      """
      // Want to make sure we can parse this. Perhaps we should not let this validate, though.
      if #available(*) {
      }
      """
    )
  }

  func testAvailabilityQuery25() {
    AssertParse(
      """
      if #availableℹ️(* 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end availability condition",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ]
        )
      ]
    )
  }

  func testAvailabilityQuery26() {
    AssertParse(
      """
      // Multiple platforms
      if #available(OSX 10.51, iOS 8.0, *) {
      }
      """
    )
  }

  func testAvailabilityQuery27() {
    AssertParse(
      """
      if #available(OSX 10.51, 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument"),
        DiagnosticSpec(message: "expected ')' to end availability condition"),
      ]
    )
  }

  func testAvailabilityQuery28() {
    AssertParse(
      """
      if #available(OSX 10.51,1️⃣) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument")
      ]
    )
  }

  func testAvailabilityQuery29() {
    AssertParse(
      """
      if #availableℹ️(OSX 10.51, iOS 1️⃣{
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected version number
        DiagnosticSpec(
          message: "expected ')' to end availability condition",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ]
        )
      ]
    )
  }

  func testAvailabilityQuery30() {
    AssertParse(
      """
      if #available(OSX 10.51, iOS 8.0, iDishwasherOS 10.51) { 
      }
      """
    )
  }

  func testAvailabilityQuery31() {
    AssertParse(
      """
      if #available(iDishwasherOS 10.51, OSX 10.51) { 
      }
      """
    )
  }

  func testAvailabilityQuery32() {
    AssertParse(
      """
      if #available(OSX 10.51 1️⃣|| iOS 8.0) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' joining platforms in availability condition", fixIts: ["replace '||' by ','"])
      ],
      fixedSource: """
        if #available(OSX 10.51 , iOS 8.0) {
        }
        """
    )
  }

  func testAvailabilityQuery33() {
    AssertParse(
      """
      // Emit Fix-It removing un-needed >=, for the moment.
      """
    )
  }

  func testAvailabilityQuery34() {
    AssertParse(
      """
      if #available(OSX 1️⃣>= 10.51, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: version comparison not needed, Fix-It replacements: 19 - 22 = ''
        DiagnosticSpec(message: "unexpected code '>= 10.51, *' in availability condition")
      ]
    )
  }

  func testAvailabilityQuery35() {
    AssertParse(
      """
      // Bool then #available.
      if 1 != 2, #available(iOS 8.0, *) {}
      """
    )
  }

  func testAvailabilityQuery36() {
    AssertParse(
      """
      // Pattern then #available(iOS 8.0, *) {
      if case 42 = 42, #available(iOS 8.0, *) {}
      if let _ = Optional(42), #available(iOS 8.0, *) {}
      """
    )
  }

  func testAvailabilityQuery37() {
    AssertParse(
      #"""
      // Allow "macOS" as well.
      if #available(macOS 10.51, *) {
      }
      """#
    )
  }

}
