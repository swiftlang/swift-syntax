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

// This test file has been translated from swift/test/Parse/availability_query_unavailability.swift

import XCTest

final class AvailabilityQueryUnavailabilityTests: XCTestCase {
  func testAvailabilityQueryUnavailability1() {
    assertParse(
      """
      // This file is mostly an inverted version of availability_query.swift
      if #unavailable(OSX 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability2a() {
    assertParse(
      """
      // Disallow explicit wildcards.
      if #unavailable(OSX 10.51, *) {}
      // Disallow use as an expression.
      if (1️⃣#unavailable(OSX 10.51)) {}
      let x = 2️⃣#unavailable(OSX 10.51)
      (3️⃣#unavailable(OSX 10.51) ? 1 : 0)
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'"),
      ]
    )
  }

  func testAvailabilityQueryUnavailability2b() {
    assertParse(
      """
      if !1️⃣#unavailable(OSX 10.52) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression; did you mean '#available'?", fixIts: ["replace '!#unavailable' with '#available'"])
      ],
      fixedSource: """
        if #available(OSX 10.52) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability2c() {
    assertParse(
      """
      if let _ = Optional(5), !1️⃣#unavailable(OSX 10.52) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression; did you mean '#available'?", fixIts: ["replace '!#unavailable' with '#available'"])
      ]
    )
  }

  func testAvailabilityQueryUnavailability3() {
    assertParse(
      """
      if #unavailable(OSX 10.51) 1️⃣&& #unavailable(OSX 10.52) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' joining parts of a multi-clause condition", fixIts: ["replace '&&' with ','"])
      ]
    )
  }

  func testAvailabilityQueryUnavailability4() {
    assertParse(
      """
      if #unavailable 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '(', '@availability' arguments, and ')' in availability condition", fixIts: ["insert '(', '@availability' arguments, and ')'"])
      ],
      fixedSource: """
        if #unavailable(<#identifier#>) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability5() {
    assertParse(
      """
      if #unavailable( 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected platform and ')' to end availability condition", fixIts: ["insert platform and ')'"])
      ],
      fixedSource: """
        if #unavailable(<#identifier#>) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability6() {
    assertParse(
      """
      if #unavailable(1️⃣) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument", fixIts: ["insert version restriction"])
      ],
      fixedSource: """
        if #unavailable(<#identifier#>) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability7() {
    assertParse(
      """
      if #unavailableℹ️(OSX 1️⃣{
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

  func testAvailabilityQueryUnavailability8() {
    assertParse(
      """
      if #unavailable(OSX) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability9() {
    assertParse(
      """
      if #unavailableℹ️(OSX 10.51 1️⃣{
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
      ],
      fixedSource: """
        if #unavailable(OSX 10.51) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability10() {
    assertParse(
      """
      if #unavailable(iDishwasherOS 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability11() {
    assertParse(
      """
      if #unavailable(iDishwasherOS 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability12() {
    assertParse(
      """
      if #unavailable(macos 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability13() {
    assertParse(
      """
      if #unavailable(mscos 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability14() {
    assertParse(
      """
      if #unavailable(macoss 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability15() {
    assertParse(
      """
      if #unavailable(mac 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability16() {
    assertParse(
      """
      if #unavailable(OSX 10.51, OSX 10.52) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability17() {
    assertParse(
      """
      if #unavailable(OSX 10.51, iOS 8.0, *) { }
      if #unavailable(iOS 8.0) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability18() {
    assertParse(
      """
      if #unavailable(iOSApplicationExtension, unavailable) { // expected-error 2{{expected version number}}
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability19() {
    assertParse(
      """
      // Should this be a valid spelling since `#unvailable(*)` cannot be written?
      if #unavailable(1️⃣) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument", fixIts: ["insert version restriction"])
      ],
      fixedSource: """
        // Should this be a valid spelling since `#unvailable(*)` cannot be written?
        if #unavailable(<#identifier#>) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability20() {
    assertParse(
      """
      if #unavailableℹ️(OSX 10 1️⃣{
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
      ],
      fixedSource: """
        if #unavailable(OSX 10) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability21() {
    assertParse(
      """
      // Multiple platforms
      if #unavailable(OSX 10.51, iOS 8.0) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability22() {
    assertParse(
      """
      if #unavailable(OSX 10.51, 1️⃣{
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument", fixIts: ["insert version restriction"]),
        DiagnosticSpec(message: "expected ')' to end availability condition", fixIts: ["insert ')'"]),
      ],
      fixedSource: """
        if #unavailable(OSX 10.51, <#identifier#>) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability23() {
    assertParse(
      """
      if #unavailable(OSX 10.51,1️⃣) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected version restriction in availability argument", fixIts: ["insert version restriction"])
      ],
      fixedSource: """
        if #unavailable(OSX 10.51, <#identifier#>) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability24() {
    assertParse(
      """
      if #unavailableℹ️(OSX 10.51, iOS 1️⃣{
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
      ],
      fixedSource: """
        if #unavailable(OSX 10.51, iOS) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability25() {
    assertParse(
      """
      if #unavailable(OSX 10.51, iOS 8.0, iDishwasherOS 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability26() {
    assertParse(
      """
      if #unavailable(iDishwasherOS 10.51, OSX 10.51) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability27() {
    assertParse(
      """
      if #unavailable(OSX 10.51 1️⃣|| iOS 8.0) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' joining platforms in availability condition", fixIts: ["replace '||' with ','"])
      ],
      fixedSource: """
        if #unavailable(OSX 10.51 , iOS 8.0) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability28() {
    assertParse(
      """
      // Emit Fix-It removing un-needed >=, for the moment.
      if #unavailable(OSX 1️⃣>= 10.51) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "version comparison not needed", fixIts: ["remove '>='"])
      ]
    )
  }

  func testAvailabilityQueryUnavailability29() {
    assertParse(
      """
      // Bool then #unavailable.
      if 1 != 2, #unavailable(iOS 8.0) {}
      """
    )
  }

  func testAvailabilityQueryUnavailability30() {
    assertParse(
      """
      // Pattern then #unavailable(iOS 8.0) {
      if case 42 = 42, #unavailable(iOS 8.0) {}
      if let _ = Optional(42), #unavailable(iOS 8.0) {}
      """
    )
  }

  func testAvailabilityQueryUnavailability31() {
    assertParse(
      #"""
      // Allow "macOS" as well.
      if #unavailable(macOS 10.51) {
      }
      """#
    )
  }

  func testAvailabilityQueryUnavailability32() {
    assertParse(
      """
      // Prevent availability and unavailability being present in the same statement.
      if #unavailable(macOS 10.51), #available(macOS 10.52, *) {
      }
      if #available(macOS 10.51, *), #unavailable(macOS 10.52) {
      }
      if #available(macOS 10.51, *), #available(macOS 10.55, *), #unavailable(macOS 10.53) {
      }
      if #unavailable(macOS 10.51), #unavailable(macOS 10.55), #available(macOS 10.53, *) {
      }
      if case 42 = 42, #available(macOS 10.51, *), #unavailable(macOS 10.52) {
      }
      if #available(macOS 10.51, *), case 42 = 42, #unavailable(macOS 10.52) {
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability33() {
    assertParse(
      """
      // Allow availability and unavailability to mix if they are not in the same statement.
      if #unavailable(macOS 11) {
        if #available(macOS 10, *) { }
      }
      if #available(macOS 10, *) {
        if #unavailable(macOS 11) { }
      }
      """
    )
  }

  func testAvailabilityQueryUnavailability34a() {
    assertParse(
      """
      if #available(*) 1️⃣== false {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "#available cannot be used as an expression, did you mean to use '#unavailable'?", fixIts: ["replace '#available(*) == false' with '#unavailable(*)'"])
      ],
      fixedSource: """
        if #unavailable(*) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability34b() {
    assertParse(
      """
      if #available(*) 1️⃣== false 2️⃣&& true {
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "#available cannot be used as an expression, did you mean to use '#unavailable'?", fixIts: ["replace '#available(*) == false' with '#unavailable(*)'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ',' joining parts of a multi-clause condition", fixIts: ["replace '&&' with ','"]),
      ],
      fixedSource: """
        if #unavailable(*) , true {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability34c() {
    assertParse(
      """
      if !1️⃣#available(*) {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "availability condition cannot be used in an expression; did you mean '#unavailable'?", fixIts: ["replace '!#available' with '#unavailable'"])
      ],
      fixedSource: """
        if #unavailable(*) {
        }
        """
    )
  }

  func testAvailabilityQueryUnavailability34d() {
    assertParse(
      """
      if #available(*) 1️⃣== {
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '==' in 'if' statement")
      ]
    )
  }
}
