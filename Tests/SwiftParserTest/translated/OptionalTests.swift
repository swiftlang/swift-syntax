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

// This test file has been translated from swift/test/Parse/optional.swift

import SwiftSyntax
import XCTest

final class OptionalTests: ParserTestCase {
  func testOptional1() {
    assertParse(
      """
      struct A {
        func foo() {}
      }
      """
    )
  }

  func testOptional2() {
    assertParse(
      """
      var a : A?
      var b : A 1️⃣?
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code '?' at top level")
      ]
    )
  }

  func testOptional3a() {
    assertParse(
      """
      var c = a?
      """,
      substructure: OptionalChainingExprSyntax(
        expression: DeclReferenceExprSyntax(baseName: .identifier("a")),
        questionMark: .postfixQuestionMarkToken()
      )
    )
  }

  func testOptional3b() {
    assertParse(
      """
      var d : ()? = a?.foo()
      """
    )
  }

  func testOptional4() {
    assertParse(
      """
      var e : (() -> A)?
      var f = e?()
      """
    )
  }

  func testOptional5() {
    assertParse(
      """
      struct B<T> {}
      var g = B<A?>()
      """
    )
  }

}
