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

// This test file has been translated from swift/test/Parse/number_identifier_errors.swift

import XCTest

final class NumberIdentifierErrorsTests: ParserTestCase {
  func testNumberIdentifierErrors1() {
    assertParse(
      """
      // Per rdar://problem/32316666 , it is a common mistake for beginners
      // to start a function name with a number, so it's worth
      // special-casing the diagnostic to make it clearer.
      """
    )
  }

  func testNumberIdentifierErrors2a() {
    assertParse(
      """
      func 1️⃣1() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors2b() {
    assertParse(
      """
      func 1️⃣2.0() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors2c() {
    assertParse(
      """
      func 1️⃣3func() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors3a() {
    assertParse(
      """
      protocol 1️⃣4 {
        associatedtype 2️⃣5
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
      ]
    )
  }

  func testNumberIdentifierErrors3b() {
    assertParse(
      """
      protocol 1️⃣6.0 {
        associatedtype 2️⃣7.0
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
      ]
    )
  }

  func testNumberIdentifierErrors3c() {
    assertParse(
      """
      protocol 1️⃣8protocol {
        associatedtype 2️⃣9associatedtype
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
      ]
    )
  }

  func testNumberIdentifierErrors4a() {
    assertParse(
      """
      typealias 1️⃣10 = Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors4b() {
    assertParse(
      """
      typealias 1️⃣11.0 = Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors4c() {
    assertParse(
      """
      typealias 1️⃣12typealias = Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors5a() {
    assertParse(
      """
      struct 1️⃣13 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors5b() {
    assertParse(
      """
      struct 1️⃣14.0 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors5c() {
    assertParse(
      """
      struct 1️⃣15struct {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors6a() {
    assertParse(
      """
      enum 1️⃣16 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors6b() {
    assertParse(
      """
      enum 1️⃣17.0 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors6c() {
    assertParse(
      """
      enum 1️⃣18enum {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors7a() {
    assertParse(
      """
      class 1️⃣19 {
        func 2️⃣20() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
      ]
    )
  }

  func testNumberIdentifierErrors7b() {
    assertParse(
      """
      class 1️⃣21.0 {
        func 2️⃣22.0() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
      ]
    )
  }

  func testNumberIdentifierErrors8() {
    assertParse(
      """
      class 1️⃣23class {
        func 2️⃣24method() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "identifier can only start with a letter or underscore, not a number"
        ),
      ]
    )
  }

}
