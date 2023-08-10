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

// This test file has been translated from swift/test/Parse/escaped_identifiers.swift

import XCTest

final class EscapedIdentifiersTests: ParserTestCase {
  func testEscapedIdentifiers1() {
    assertParse(
      """
      func `protocol`() {}
      """
    )
  }

  func testEscapedIdentifiers2() {
    assertParse(
      """
      `protocol`()
      """
    )
  }

  func testEscapedIdentifiers3() {
    assertParse(
      """
      class `Type` {}
      """
    )
  }

  func testEscapedIdentifiers4() {
    assertParse(
      """
      var `class` = `Type`.self
      """
    )
  }

  func testEscapedIdentifiers5() {
    assertParse(
      """
      func foo() {}
      """
    )
  }

  func testEscapedIdentifiers6() {
    assertParse(
      """
      `foo`()
      """
    )
  }

  func testEscapedIdentifiers7() {
    assertParse(
      """
      // Escaping suppresses identifier contextualization.
      var get: (() -> ()) -> () = { $0() }
      """
    )
  }

  func testEscapedIdentifiers8() {
    assertParse(
      """
      var applyGet: Int {
        `get` { }
        return 0
      }
      """
    )
  }

  func testEscapedIdentifiers9() {
    assertParse(
      """
      enum `switch` {}
      """
    )
  }

  func testEscapedIdentifiers10() {
    assertParse(
      """
      typealias `Self` = Int
      """
    )
  }

}
