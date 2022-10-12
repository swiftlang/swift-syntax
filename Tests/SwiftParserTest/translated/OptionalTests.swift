// This test file has been translated from swift/test/Parse/optional.swift

import SwiftSyntax
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
      var b : A 1️⃣?
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code '?' at top level"),
      ]
    )
  }

  func testOptional3a() {
    AssertParse(
      """
      var c = a?  
      """,
      substructure: Syntax(OptionalChainingExprSyntax(
        expression: ExprSyntax(IdentifierExprSyntax(
          identifier: .identifier("a"),
          declNameArguments: nil
        )),
        questionMark: .postfixQuestionMarkToken()
      ))
    )
  }

  func testOptional3b() {
    AssertParse(
      """
      var d : ()? = a?.foo()
      """
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
