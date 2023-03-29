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

// This test file has been translated from swift/test/Parse/operator_decl.swift

import XCTest

final class OperatorDeclTests: XCTestCase {
  func testOperatorDecl1a() {
    assertParse(
      """
      prefix operator +++ 1️⃣{}
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body", fixIts: ["remove operator body"])
      ],
      fixedSource: "prefix operator +++"
    )
  }

  func testOperatorDecl1b() {
    assertParse(
      """
      postfix operator +++ 1️⃣{}
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl1c() {
    assertParse(
      """
      infix operator +++ 1️⃣{}
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl1d() {
    assertParse(
      """
      infix operator +++* 1️⃣{
        associativity right
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body", fixIts: ["remove operator body"])
      ],
      fixedSource: """
        infix operator +++*
        """
    )
  }

  func testOperatorDecl1e() {
    assertParse(
      """
      infix operator +++*+ : A 1️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl2() {
    assertParse(
      """
      prefix operator +++** : A 1️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl3() {
    assertParse(
      """
      prefix operator ++*++ : A
      """
    )
  }

  func testOperatorDecl4() {
    assertParse(
      """
      postfix operator ++*+* : A 1️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl5() {
    assertParse(
      """
      postfix operator ++**+ : A
      """
    )
  }

  func testOperatorDecl6() {
    assertParse(
      """
      operator ++*** : A
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator must be declared as 'prefix', 'postfix', or 'infix'
      ]
    )
  }

  func testOperatorDecl7() {
    assertParse(
      """
      operator +*+++ 1️⃣{ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator must be declared as 'prefix', 'postfix', or 'infix'
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl8() {
    assertParse(
      """
      operator +*++* : A 1️⃣{ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator must be declared as 'prefix', 'postfix', or 'infix'
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl9() {
    assertParse(
      """
      prefix operator1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected binary operator in operator declaration")
      ]
    )
  }

  func testOperatorDecl10() {
    assertParse(
      """
      1️⃣;
      prefix operator %%+
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code before operator declaration")
      ]
    )
  }

  func testOperatorDecl11a() {
    assertParse(
      """
      prefix operator ??
      """
    )
  }

  func testOperatorDecl11b() {
    assertParse(
      """
      postfix operator ??
      """
    )
  }

  func testOperatorDecl11c() {
    assertParse(
      """
      prefix operator !!
      """
    )
  }

  func testOperatorDecl11d() {
    assertParse(
      """
      postfix operator !!
      """
    )
  }

  func testOperatorDecl11e() {
    assertParse(
      """
      postfix operator ?1️⃣$$
      """,
      diagnostics: [
        DiagnosticSpec(message: "'$$' is considered an identifier and must not appear within an operator name", fixIts: ["remove '$$'"])
      ],
      fixedSource: "postfix operator ?"
    )
  }

  func testOperatorDecl12a() {
    assertParse(
      """
      infix operator --1️⃣aa
      """,
      diagnostics: [
        DiagnosticSpec(message: "'aa' is considered an identifier and must not appear within an operator name", fixIts: ["remove 'aa'"])
      ],
      fixedSource: "infix operator --"
    )
  }

  func testOperatorDecl12b() {
    assertParse(
      """
      infix operator 1️⃣aa--: A
      """,
      diagnostics: [
        DiagnosticSpec(message: "'aa' is considered an identifier and must not appear within an operator name", highlight: "aa", fixIts: ["remove 'aa'"])
      ],
      fixedSource: "infix operator --: A"
    )
  }

  func testOperatorDecl12c() {
    assertParse(
      """
      infix operator <<1️⃣$$@<
      """,
      diagnostics: [
        DiagnosticSpec(message: "'$$@<' is not allowed in operator names", fixIts: ["remove '$$@<'"])
      ],
      fixedSource: "infix operator <<"
    )
  }

  func testOperatorDecl12d() {
    assertParse(
      """
      infix operator !!1️⃣@aa2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "'@aa' is not allowed in operator names")
      ]
    )
  }

  func testOperatorDecl12e() {
    assertParse(
      """
      infix operator 1️⃣#++=
      """,
      diagnostics: [
        DiagnosticSpec(message: "'#' is not allowed in operator names", highlight: "#", fixIts: ["remove '#'"])
      ],
      fixedSource: "infix operator ++="
    )
  }

  func testOperatorDecl12f() {
    assertParse(
      """
      infix operator ++=1️⃣#
      """,
      diagnostics: [
        DiagnosticSpec(message: "'#' is not allowed in operator names")
      ]
    )
  }

  func testOperatorDecl12g() {
    assertParse(
      """
      infix operator ->1️⃣#
      """,
      diagnostics: [
        DiagnosticSpec(message: "'#' is not allowed in operator names")
      ]
    )
  }

  func testOperatorDecl13() {
    assertParse(
      """
      // FIXME: Ideally, we shouldn't emit the «consistent whitespace» diagnostic
      // where = cannot possibly mean an assignment.
      infix operator =1️⃣#=
      """,
      diagnostics: [
        DiagnosticSpec(message: "'#=' is not allowed in operator names")
      ]
    )
  }

  func testOperatorDecl14() {
    assertParse(
      """
      infix operator +++=
      infix operator *** : A
      infix operator --- : 1️⃣;
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected precedence group in operator declaration")
      ]
    )
  }

  func testOperatorDecl15a() {
    assertParse(
      """
      precedencegroup 1️⃣{
        associativity: right
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in precedencegroup")
      ]
    )
  }

  func testOperatorDecl15b() {
    assertParse(
      """
      precedencegroup A {
        associativity 1️⃣right
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in 'associativity' property of precedencegroup")
      ]
    )
  }

  func testOperatorDecl15c() {
    assertParse(
      """
      precedencegroup B {
        1️⃣precedence 123
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'precedence 123' in precedencegroup")
      ]
    )
  }

  func testOperatorDecl15d() {
    assertParse(
      """
      precedencegroup C {
        associativity: 1️⃣sinister
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected 'none', 'left', or 'right' after 'associativity'")
      ]
    )
  }

  func testOperatorDecl15e() {
    assertParse(
      """
      precedencegroup D {
        assignment: 1️⃣no
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'true' or 'false' after 'assignment'")
      ]
    )
  }

  func testOperatorDecl15() {
    assertParse(
      """
      precedencegroup E {
        higherThan:1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected name in 'relation' property of precedencegroup")
      ]
    )
  }

  func testOperatorDecl16() {
    assertParse(
      """
      precedencegroup F {
        higherThan: A, B, C
      }
      """
    )
  }

  func testOperatorDecl17() {
    assertParse(
      """
      precedencegroup BangBangBang {
        associativity: none
        associativity: left
      }
      """
    )
  }

  func testOperatorDecl18() {
    assertParse(
      """
      precedencegroup CaretCaretCaret {
        assignment: true
        assignment: false
      }
      """
    )
  }

  func testOperatorDecl19() {
    assertParse(
      """
      class Foo {
        infix operator |||
      }
      """
    )
  }

  func testOperatorDecl20() {
    assertParse(
      """
      infix operator **<< : UndeclaredPrecedenceGroup
      """
    )
  }

  func testOperatorDecl21() {
    // TODO: We should not allow specification of multiple precedence groups
    assertParse(
      """
      protocol Proto {}
      infix operator *<*< : F, Proto
      """
    )
  }

  func testOperatorDecl22() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/60932
      """
    )
  }

  func testOperatorDecl23() {
    assertParse(
      """
      postfix operator ++:1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected precedence group in operator declaration")
      ]
    )
  }

  func testIdentifierAsOperatorName() {
    assertParse(
      "postfix operator 1️⃣aa",
      diagnostics: [
        DiagnosticSpec(message: "'aa' is considered an identifier and must not appear within an operator name")
      ]
    )
  }

  func testRegexLikeOperator() {
    assertParse("prefix operator /^/")
  }
}
