// This test file has been translated from swift/test/Parse/escaped_identifiers.swift

import XCTest

final class EscapedIdentifiersTests: XCTestCase {
  func testEscapedIdentifiers1() {
    AssertParse(
      """
      func `protocol`() {}
      """
    )
  }

  func testEscapedIdentifiers2() {
    AssertParse(
      """
      `protocol`()
      """
    )
  }

  func testEscapedIdentifiers3() {
    AssertParse(
      """
      class `Type` {}
      """
    )
  }

  func testEscapedIdentifiers4() {
    AssertParse(
      """
      var `class` = `Type`.self
      """
    )
  }

  func testEscapedIdentifiers5() {
    AssertParse(
      """
      func foo() {}
      """
    )
  }

  func testEscapedIdentifiers6() {
    AssertParse(
      """
      `foo`()
      """
    )
  }

  func testEscapedIdentifiers7() {
    AssertParse(
      """
      // Escaping suppresses identifier contextualization.
      var get: (() -> ()) -> () = { $0() }
      """
    )
  }

  func testEscapedIdentifiers8() {
    AssertParse(
      """
      var applyGet: Int {
        `get` { }
        return 0
      }
      """
    )
  }

  func testEscapedIdentifiers9() {
    AssertParse(
      """
      enum `switch` {}
      """
    )
  }

  func testEscapedIdentifiers10() {
    AssertParse(
      """
      typealias `Self` = Int
      """
    )
  }

}
