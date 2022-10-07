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
      func 1️⃣1() {}
      func 2️⃣2.0() {}
      func 3️⃣3func() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: function name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '1' before parameter clause"),
        // TODO: Old parser expected error on line 2: function name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text '2.0' before parameter clause"),
        // TODO: Old parser expected error on line 3: function name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 3: 'f' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "3️⃣", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

  func testNumberIdentifierErrors3a() {
    AssertParse(
      """
      protocol 1️⃣4 {
        associatedtype 2️⃣5
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: protocol name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected member block in protocol"),
        // TODO: Old parser expected error on line 2: associatedtype name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in associatedtype declaration"),
      ]
    )
  }

  func testNumberIdentifierErrors3b() {
    AssertParse(
      """
      protocol 1️⃣6.0 {
        associatedtype 2️⃣7.0
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: protocol name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected member block in protocol"),
        // TODO: Old parser expected error on line 2: associatedtype name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in associatedtype declaration"),
      ]
    )
  }

  func testNumberIdentifierErrors3c() {
    AssertParse(
      """
      protocol 1️⃣8protocol {
        associatedtype 2️⃣9associatedtype
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: protocol name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 1: 'p' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        // TODO: Old parser expected error on line 2: associatedtype name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 2: 'a' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }


  func testNumberIdentifierErrors4() {
    AssertParse(
      """
      typealias 1️⃣10 = Int
      typealias 2️⃣11.0 = Int
      typealias 3️⃣12typealias = Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: typealias name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in typealias declaration"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '10' in typealias declaration"),
        // TODO: Old parser expected error on line 2: typealias name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in typealias declaration"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text '11.0' in typealias declaration"),
        // TODO: Old parser expected error on line 3: typealias name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 3: 't' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "3️⃣", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

  func testNumberIdentifierErrors5a() {
    AssertParse(
      """
      struct 1️⃣13 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: struct name can only start with a letter or underscore, not a number
        DiagnosticSpec(message: "expected identifier in struct"),
        DiagnosticSpec(message: "expected member block in struct"),
      ]
    )
  }

  func testNumberIdentifierErrors5b() {
    AssertParse(
      """
      struct 1️⃣14.0 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: struct name can only start with a letter or underscore, not a number
        DiagnosticSpec(message: "expected identifier in struct"),
        DiagnosticSpec(message: "expected member block in struct"),
      ]
    )
  }

  func testNumberIdentifierErrors5c() {
    AssertParse(
      """
      struct 1️⃣15struct {}
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
      enum 1️⃣16 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: enum name can only start with a letter or underscore, not a number
        DiagnosticSpec(message: "expected identifier in enum"),
        DiagnosticSpec(message: "expected member block in enum"),
      ]
    )
  }

  func testNumberIdentifierErrors6b() {
    AssertParse(
      """
      enum 1️⃣17.0 {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: enum name can only start with a letter or underscore, not a number
        DiagnosticSpec(message: "expected identifier in enum"),
        DiagnosticSpec(message: "expected member block in enum"),
      ]
    )
  }

  func testNumberIdentifierErrors6c() {
    AssertParse(
      """
      enum 1️⃣18enum {}
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
      class 1️⃣19 {
        func 2️⃣20() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: class name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in class"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected member block in class"),
        // TODO: Old parser expected error on line 2: function name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text '20' before parameter clause"),
      ]
    )
  }

  func testNumberIdentifierErrors7b() {
    AssertParse(
      """
      class 1️⃣21.0 {
        func 2️⃣22.0() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: class name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in class"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected member block in class"),
        // TODO: Old parser expected error on line 2: function name can only start with a letter or underscore, not a number
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text '22.0' before parameter clause"),
      ]
    )
  }


  func testNumberIdentifierErrors8() {
    AssertParse(
      """
      class 1️⃣23class {
        func 2️⃣24method() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: class name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 1: 'c' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        // TODO: Old parser expected error on line 2: function name can only start with a letter or underscore, not a number
        // TODO: Old parser expected error on line 2: 'm' is not a valid digit in integer literal
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

}
