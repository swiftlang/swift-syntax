// This test file has been translated from swift/test/Parse/number_identifier_errors.swift

import XCTest

final class NumberIdentifierErrorsTests: XCTestCase {
  func testNumberIdentifierErrors1() {
    AssertParse(
      """
      // Per rdar://problem/32316666 , it is a common mistake for beginners
      // to start a function name with a number, so it's worth
      // special-casing the diagnostic to make it clearer.
      """
    )
  }

  func testNumberIdentifierErrors2() {
    AssertParse(
      """
      func #^DIAG_1^#1() {}
      func #^DIAG_2^#2.0() {}
      func #^DIAG_3^#3func() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: function name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '1' before parameter clause"),
        // TODO: Old parser expected error on line 2: function name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '2.0' before parameter clause"),
        // TODO: Old parser expected error on line 3: function name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 3: 'f' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "DIAG_3", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

  func testNumberIdentifierErrors3a() {
    AssertParse(
      """
      protocol#^DIAG_1^# #^DIAG_2^#4 {
        associatedtype #^DIAG_3^#5
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: protocol name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in protocol"),
        // TODO: Old parser expected error on line 2: associatedtype name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected identifier in associatedtype declaration"),
      ]
    )
  }

  func testNumberIdentifierErrors3b() {
    AssertParse(
      """
      protocol#^DIAG_1^# #^DIAG_2^#6.0 {
        associatedtype #^DIAG_3^#7.0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: protocol name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in protocol"),
        // TODO: Old parser expected error on line 2: associatedtype name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected identifier in associatedtype declaration"),
      ]
    )
  }

  func testNumberIdentifierErrors3c() {
    AssertParse(
      """
      protocol #^DIAG_5^#8protocol {
        associatedtype #^DIAG_6^#9associatedtype
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: protocol name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 1: 'p' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "DIAG_5", message: "identifier can only start with a letter or underscore, not a number"),
        // TODO: Old parser expected error on line 2: associatedtype name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 2: 'a' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "DIAG_6", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }


  func testNumberIdentifierErrors4() {
    AssertParse(
      """
      typealias #^DIAG_1^#10 = Int
      typealias #^DIAG_2^#11.0 = Int
      typealias #^DIAG_3^#12typealias = Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: typealias name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in typealias declaration"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '10' in typealias declaration"),
        // TODO: Old parser expected error on line 2: typealias name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in typealias declaration"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text '11.0' in typealias declaration"),
        // TODO: Old parser expected error on line 3: typealias name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 3: 't' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "DIAG_3", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

  func testNumberIdentifierErrors5a() {
    AssertParse(
      """
      struct#^DIAG_1^# #^DIAG_2^#13 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: struct name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in struct"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in struct"),
      ]
    )
  }

  func testNumberIdentifierErrors5b() {
    AssertParse(
      """
      struct#^DIAG_1^# #^DIAG_2^#14.0 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: struct name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in struct"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in struct"),
      ]
    )
  }

  func testNumberIdentifierErrors5c() {
    AssertParse(
      """
      struct #^DIAG^#15struct {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: struct name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 1: 's' is not a valid digit in integer literal
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

  func testNumberIdentifierErrors6a() {
    AssertParse(
      """
      enum#^DIAG_1^# #^DIAG_2^#16 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: enum name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in enum"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in enum"),
      ]
    )
  }

  func testNumberIdentifierErrors6b() {
    AssertParse(
      """
      enum#^DIAG_1^# #^DIAG_2^#17.0 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: enum name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in enum"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in enum"),
      ]
    )
  }

  func testNumberIdentifierErrors6c() {
    AssertParse(
      """
      enum #^DIAG^#18enum {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: enum name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 1: 'n' is not a valid digit in floating point exponent
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

  func testNumberIdentifierErrors7a() {
    AssertParse(
      """
      class#^DIAG_1^# #^DIAG_2^#19 {
        func #^DIAG_3^#20() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: class name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in class"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in class"),
        // TODO: Old parser expected error on line 2: function name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text '20' before parameter clause"),
      ]
    )
  }

  func testNumberIdentifierErrors7b() {
    AssertParse(
      """
      class#^DIAG_1^# #^DIAG_2^#21.0 {
        func #^DIAG_3^#22.0() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: class name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected identifier in class"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected member block in class"),
        // TODO: Old parser expected error on line 2: function name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text '22.0' before parameter clause"),
      ]
    )
  }


  func testNumberIdentifierErrors8() {
    AssertParse(
      """
      class #^DIAG_1^#23class {
        func #^DIAG_2^#24method() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: class name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 1: 'c' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "DIAG_1", message: "identifier can only start with a letter or underscore, not a number"),
        // TODO: Old parser expected error on line 2: function name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 2: 'm' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "DIAG_2", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

}
