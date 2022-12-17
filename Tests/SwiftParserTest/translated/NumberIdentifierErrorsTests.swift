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

  func testNumberIdentifierErrors2a() {
    AssertParse(
      """
      func 1️⃣1() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors2b() {
    AssertParse(
      """
      func 1️⃣2.0() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors2c() {
    AssertParse(
      """
      func 1️⃣3func() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

  func testNumberIdentifierErrors4a() {
    AssertParse(
      """
      typealias 1️⃣10 = Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors4b() {
    AssertParse(
      """
      typealias 1️⃣11.0 = Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors4c() {
    AssertParse(
      """
      typealias 1️⃣12typealias = Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors5a() {
    AssertParse(
      """
      struct 1️⃣13 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors5b() {
    AssertParse(
      """
      struct 1️⃣14.0 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors5c() {
    AssertParse(
      """
      struct 1️⃣15struct {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors6a() {
    AssertParse(
      """
      enum 1️⃣16 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors6b() {
    AssertParse(
      """
      enum 1️⃣17.0 {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
      ]
    )
  }

  func testNumberIdentifierErrors6c() {
    AssertParse(
      """
      enum 1️⃣18enum {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "identifier can only start with a letter or underscore, not a number")
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "identifier can only start with a letter or underscore, not a number"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "identifier can only start with a letter or underscore, not a number"),
      ]
    )
  }

}
