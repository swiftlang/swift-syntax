// This test file has been translated from swift/test/Parse/optional.swift

import XCTest

final class OptionalTests: XCTestCase {
  func testOptional1() {
    AssertParse(
      """
      struct A {
        func foo() {}
      }
      """
    )
  }

  func testOptional2() {
    AssertParse(
      """
      var a : A?
      var b : A #^DIAG^#?
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: consecutive statements on a line, Fix-It replacements: 10 - 10 = ';'
        // TODO: Old parser expected error on line 2: expected expression
        DiagnosticSpec(message: "extraneous '?' at top level"),
      ]
    )
  }

  func testOptional3() {
    AssertParse(
      """
      var c = a?  
      var d : ()? = a?.foo()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '?' must be followed by a call, member lookup, or subscript
      ]
    )
  }

  func testOptional4() {
    AssertParse(
      """
      var e : (() -> A)?
      var f = e?()
      """
    )
  }

  func testOptional5() {
    AssertParse(
      """
      struct B<T> {}
      var g = B<A?>()
      """
    )
  }

}
