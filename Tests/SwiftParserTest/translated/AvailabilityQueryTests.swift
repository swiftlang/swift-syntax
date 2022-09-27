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
      if (#^DIAG^##available(OSX 10.51, *)) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: #available may only be used as condition of an 'if', 'guard'
        DiagnosticSpec(message: "expected value in tuple"),
        DiagnosticSpec(message: "unexpected text '#available(OSX 10.51, *)' in tuple"),
      ]
    )
  }

  func testAvailabilityQuery3() {
    AssertParse(
      """
      let x = #^DIAG^##available(OSX 10.51, *)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: #available may only be used as condition of
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous '#available(OSX 10.51, *)' at top level"),
      ]
    )
  }

  func testAvailabilityQuery4() {
    AssertParse(
      """
      (#^DIAG^##available(OSX 10.51, *) ? 1 : 0)
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: #available may only be used as condition of an
        DiagnosticSpec(message: "expected value in tuple"),
        DiagnosticSpec(message: "unexpected text '#available(OSX 10.51, *) ? 1 : 0' in tuple"),
      ]
    )
  }

  func testAvailabilityQuery5() {
    AssertParse(
      """
      if !#^DIAG_1^##available(OSX 10.52, *) { 
      }
      if let _ = Optional(5), !#^DIAG_2^##available(OSX 10.52, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: #available cannot be used as an expression, did you mean to use '#unavailable'?, Fix-It replacements: 4 - 15 = '#unavailable'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in prefix operator expression"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '#available(OSX 10.52, *)' in 'if' statement"),
        // TODO: Old parser expected error on line 3: #available cannot be used as an expression, did you mean to use '#unavailable'?, Fix-It replacements: 25 - 36 = '#unavailable'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in prefix operator expression"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '#available(OSX 10.52, *)' in 'if' statement"),
      ]
    )
  }

  func testAvailabilityQuery6() {
    AssertParse(
      """
      if #available(OSX 10.51, *) #^DIAG^#&& #available(OSX 10.52, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ',' joining parts of a multi-clause condition, Fix-It replacements: 28 - 31 = ','
        DiagnosticSpec(message: "unexpected text '&& #available(OSX 10.52, *)' in 'if' statement"),
      ]
    )
  }

  func testAvailabilityQuery7() {
    AssertParse(
      """
      if #available #^DIAG_1^#{ 
      }#^DIAG_2^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected availability condition
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '(' in '#availabile' condition"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ')' to end '#availabile' condition"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected code block in 'if' statement"),
      ]
    )
  }

  func testAvailabilityQuery8() {
    AssertParse(
      """
      if #available( { 
      }#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected platform name
        // TODO: Old parser expected error on line 1: expected ')'
        // TODO: Old parser expected note on line 1: to match this opening '('
        DiagnosticSpec(message: "expected ')' to end '#availabile' condition"),
        DiagnosticSpec(message: "expected code block in 'if' statement"),
      ]
    )
  }

  func testAvailabilityQuery9() {
    AssertParse(
      """
      if #available() { #^DIAG^#
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected platform name
        DiagnosticSpec(message: "expected ')' to end '#availabile' condition"),
        DiagnosticSpec(message: "expected '{' in 'if' statement"),
      ]
    )
  }

  func testAvailabilityQuery10() {
    AssertParse(
      """
      if #available(OSX #^DIAG^#{ 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected version number
        // TODO: Old parser expected error on line 1: expected ')'
        // TODO: Old parser expected note on line 1: to match this opening '('
        DiagnosticSpec(message: "expected ')' to end '#availabile' condition"),
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
      if #available(OSX 10.51 #^DIAG^#{ 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ')'
        // TODO: Old parser expected note on line 1: to match this opening '('
        // TODO: Old parser expected error on line 1: must handle potential future platforms with '*', Fix-It replacements: 24 - 24 = ', *'
        DiagnosticSpec(message: "expected ')' to end '#availabile' condition"),
      ]
    )
  }

  func testAvailabilityQuery13() {
    AssertParse(
      """
      if #available(iDishwasherOS 10.51) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unrecognized platform name 'iDishwasherOS'
        // TODO: Old parser expected error on line 1: must handle potential future platforms with '*'
      ]
    )
  }

  func testAvailabilityQuery14() {
    AssertParse(
      """
      if #available(iDishwasherOS 10.51, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unrecognized platform name 'iDishwasherOS'
      ]
    )
  }

  func testAvailabilityQuery15() {
    AssertParse(
      """
      if #available(macos 10.51, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unrecognized platform name 'macos'; did you mean 'macOS'?, Fix-It replacements: 15 - 20 = 'macOS'
      ]
    )
  }

  func testAvailabilityQuery16() {
    AssertParse(
      """
      if #available(mscos 10.51, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unrecognized platform name 'mscos'; did you mean 'macOS'?, Fix-It replacements: 15 - 20 = 'macOS'
      ]
    )
  }

  func testAvailabilityQuery17() {
    AssertParse(
      """
      if #available(macoss 10.51, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unrecognized platform name 'macoss'; did you mean 'macOS'?, Fix-It replacements: 15 - 21 = 'macOS'
      ]
    )
  }

  func testAvailabilityQuery18() {
    AssertParse(
      """
      if #available(mac 10.51, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unrecognized platform name 'mac'; did you mean 'macOS'?, Fix-It replacements: 15 - 18 = 'macOS'
      ]
    )
  }

  func testAvailabilityQuery19() {
    AssertParse(
      """
      if #available(OSX 10.51, OSX 10.52, *) {  
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: version for 'macOS' already specified
      ]
    )
  }

  func testAvailabilityQuery20() {
    AssertParse(
      """
      if #available(OSX 10.52) { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: must handle potential future platforms with '*', Fix-It replacements: 24 - 24 = ', *'
      ]
    )
  }

  func testAvailabilityQuery21() {
    AssertParse(
      """
      if #available(OSX 10.51, iOS 8.0) { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: must handle potential future platforms with '*', Fix-It replacements: 33 - 33 = ', *'
      ]
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
      if #available(* #^DIAG^#{ 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ')' in availability query
        // TODO: Old parser expected note on line 1: to match this opening '('
        DiagnosticSpec(message: "expected ')' to end '#availabile' condition"),
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
      if #available(OSX 10.51, { 
      }#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ')'
        // TODO: Old parser expected note on line 1: to match this opening '('
        // TODO: Old parser expected error on line 1: expected platform name
        DiagnosticSpec(message: "expected ')' to end '#availabile' condition"),
        DiagnosticSpec(message: "expected code block in 'if' statement"),
      ]
    )
  }

  func testAvailabilityQuery28() {
    AssertParse(
      """
      if #available(OSX 10.51,) { #^DIAG^#
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected platform name
        DiagnosticSpec(message: "expected ')' to end '#availabile' condition"),
        DiagnosticSpec(message: "expected '{' in 'if' statement"),
      ]
    )
  }

  func testAvailabilityQuery29() {
    AssertParse(
      """
      if #available(OSX 10.51, iOS #^DIAG^#{ 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected ')'
        // TODO: Old parser expected note on line 1: to match this opening '('
        // TODO: Old parser expected error on line 1: expected version number
        DiagnosticSpec(message: "expected ')' to end '#availabile' condition"),
      ]
    )
  }

  func testAvailabilityQuery30() {
    AssertParse(
      """
      if #available(OSX 10.51, iOS 8.0, iDishwasherOS 10.51) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unrecognized platform name 'iDishwasherOS'
        // TODO: Old parser expected error on line 1: must handle potential future platforms with '*'
      ]
    )
  }

  func testAvailabilityQuery31() {
    AssertParse(
      """
      if #available(iDishwasherOS 10.51, OSX 10.51) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unrecognized platform name 'iDishwasherOS'
        // TODO: Old parser expected error on line 1: must handle potential future platforms with '*'
      ]
    )
  }

  func testAvailabilityQuery32() {
    AssertParse(
      """
      if #available(OSX 10.51 #^DIAG^#|| iOS 8.0) {
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '||' cannot be used in an availability condition
        DiagnosticSpec(message: "unexpected text '|| iOS 8.0' in '#availabile' condition"),
      ]
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
      if #available(OSX #^DIAG^#>= 10.51, *) { 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: version comparison not needed, Fix-It replacements: 19 - 22 = ''
        DiagnosticSpec(message: "unexpected text '>= 10.51, *' in '#availabile' condition"),
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
