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

// This test file has been translated from swift/test/Parse/operator_decl.swift

import XCTest

final class OperatorDeclTests: XCTestCase {
  func testOperatorDecl1a() {
    AssertParse(
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
    AssertParse(
      """
      postfix operator +++ 1️⃣{}
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl1c() {
    AssertParse(
      """
      infix operator +++ 1️⃣{}
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl1d() {
    AssertParse(
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
    AssertParse(
      """
      infix operator +++*+ : A 1️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl2() {
    AssertParse(
      """
      prefix operator +++** : A 1️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl3() {
    AssertParse(
      """
      prefix operator ++*++ : A
      """
    )
  }

  func testOperatorDecl4() {
    AssertParse(
      """
      postfix operator ++*+* : A 1️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body")
      ]
    )
  }

  func testOperatorDecl5() {
    AssertParse(
      """
      postfix operator ++**+ : A
      """
    )
  }

  func testOperatorDecl6() {
    AssertParse(
      """
      operator ++*** : A
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator must be declared as 'prefix', 'postfix', or 'infix'
      ]
    )
  }

  func testOperatorDecl7() {
    AssertParse(
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
    AssertParse(
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
    AssertParse(
      """
      prefix operator1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected binary operator in operator declaration")
      ]
    )
  }

  func testOperatorDecl10() {
    AssertParse(
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
    AssertParse(
      """
      prefix operator ??
      """
    )
  }

  func testOperatorDecl11b() {
    AssertParse(
      """
      postfix operator ??
      """
    )
  }

  func testOperatorDecl11c() {
    AssertParse(
      """
      prefix operator !!
      """
    )
  }

  func testOperatorDecl11d() {
    AssertParse(
      """
      postfix operator !!
      """
    )
  }

  func testOperatorDecl11e() {
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
      """
      infix operator !!1️⃣@aa2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "'@aa' is not allowed in operator names")
      ]
    )
  }

  func testOperatorDecl12e() {
    AssertParse(
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
    AssertParse(
      """
      infix operator ++=1️⃣#
      """,
      diagnostics: [
        DiagnosticSpec(message: "'#' is not allowed in operator names")
      ]
    )
  }

  func testOperatorDecl12g() {
    AssertParse(
      """
      infix operator ->1️⃣#
      """,
      diagnostics: [
        DiagnosticSpec(message: "'#' is not allowed in operator names")
      ]
    )
  }

  func testOperatorDecl13() {
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
      """
      precedencegroup C {
        associativity: sinister
      }
      """
    )
  }

  func testOperatorDecl15e() {
    AssertParse(
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
    AssertParse(
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
    AssertParse(
      """
      precedencegroup F {
        higherThan: A, B, C
      }
      """
    )
  }

  func testOperatorDecl17() {
    AssertParse(
      """
      precedencegroup BangBangBang {
        associativity: none
        associativity: left 
      }
      """
    )
  }

  func testOperatorDecl18() {
    AssertParse(
      """
      precedencegroup CaretCaretCaret {
        assignment: true 
        assignment: false 
      }
      """
    )
  }

  func testOperatorDecl19() {
    AssertParse(
      """
      class Foo {
        infix operator ||| 
      }
      """
    )
  }

  func testOperatorDecl20() {
    AssertParse(
      """
      infix operator **<< : UndeclaredPrecedenceGroup
      """
    )
  }

  func testOperatorDecl21() {
    // TODO: We should not allow specification of multiple precedence groups
    AssertParse(
      """
      protocol Proto {}
      infix operator *<*< : F, Proto
      """
    )
  }

  func testOperatorDecl22() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/60932
      """
    )
  }

  func testOperatorDecl23() {
    AssertParse(
      """
      postfix operator ++:1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected precedence group in operator declaration")
      ]
    )
  }

  func testIdentifierAsOperatorName() {
    AssertParse(
      "postfix operator 1️⃣aa",
      diagnostics: [
        DiagnosticSpec(message: "'aa' is considered an identifier and must not appear within an operator name")
      ]
    )
  }

  func testRegexLikeOperator() {
    AssertParse("prefix operator /^/")
  }
}
