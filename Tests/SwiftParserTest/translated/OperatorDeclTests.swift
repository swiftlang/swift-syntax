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

final class OperatorDeclTests: ParserTestCase {
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
        DiagnosticSpec(message: "operator should not be declared with body", fixIts: ["remove operator body"])
      ],
      fixedSource: """
        postfix operator +++
        """
    )
  }

  func testOperatorDecl1c() {
    assertParse(
      """
      infix operator +++ 1️⃣{}
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body", fixIts: ["remove operator body"])
      ],
      fixedSource: """
        infix operator +++
        """
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
        DiagnosticSpec(message: "operator should not be declared with body", fixIts: ["remove operator body"])
      ],
      fixedSource: """
        infix operator +++*+ : A
        """
    )
  }

  func testOperatorDecl2() {
    assertParse(
      """
      prefix operator +++** : A 1️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "operator should not be declared with body", fixIts: ["remove operator body"])
      ],
      fixedSource: """
        prefix operator +++** : A
        """
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
        DiagnosticSpec(message: "operator should not be declared with body", fixIts: ["remove operator body"])
      ],
      fixedSource: """
        postfix operator ++*+* : A
        """
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
      1️⃣operator ++*** : A
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "operator must be declared as 'prefix', 'postfix', or 'infix'",
          fixIts: ["insert 'prefix'", "insert 'infix'", "insert 'postfix'"]
        )
      ],
      fixedSource:
        """
        prefix operator ++*** : A
        """
    )
  }

  func testOperatorDecl7() {
    assertParse(
      """
      1️⃣operator +*+++ 2️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "operator must be declared as 'prefix', 'postfix', or 'infix'",
          fixIts: ["insert 'prefix'", "insert 'infix'", "insert 'postfix'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "operator should not be declared with body", fixIts: ["remove operator body"]),
      ],
      fixedSource: """
        prefix operator +*+++
        """
    )
  }

  func testOperatorDecl8() {
    assertParse(
      """
      1️⃣operator +*++* : A 2️⃣{ }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "operator must be declared as 'prefix', 'postfix', or 'infix'",
          fixIts: ["insert 'prefix'", "insert 'infix'", "insert 'postfix'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "operator should not be declared with body", fixIts: ["remove operator body"]),
      ],
      fixedSource: """
        prefix operator +*++* : A
        """
    )
  }

  func testOperatorDecl9() {
    assertParse(
      """
      prefix operator1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected binary operator in operator declaration", fixIts: ["insert binary operator"])
      ],
      fixedSource: """
        prefix operator <#binary operator#>
        """
    )
  }

  func testOperatorDecl10() {
    assertParse(
      """
      1️⃣;
      prefix operator %%+
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected ';' separator", fixIts: ["remove ';'"])
      ],
      fixedSource:
        """

        prefix operator %%+
        """
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
        DiagnosticSpec(message: "'@aa' is not allowed in operator names", fixIts: ["remove '@aa'"])
      ],
      fixedSource: """
        infix operator !!
        """
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
        DiagnosticSpec(message: "'#' is not allowed in operator names", fixIts: ["remove '#'"])
      ],
      fixedSource: """
        infix operator ++=
        """
    )
  }

  func testOperatorDecl12g() {
    assertParse(
      """
      infix operator ->1️⃣#
      """,
      diagnostics: [
        DiagnosticSpec(message: "'#' is not allowed in operator names", fixIts: ["remove '#'"])
      ],
      fixedSource: """
        infix operator ->
        """
    )
  }

  func testOperatorDecl13() {
    assertParse(
      """
      infix operator =1️⃣#=
      """,
      diagnostics: [
        DiagnosticSpec(message: "'#=' is not allowed in operator names", fixIts: ["remove '#='"])
      ],
      fixedSource: """
        infix operator =
        """
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
        DiagnosticSpec(message: "expected precedence group in operator declaration", fixIts: ["insert precedence group"])
      ],
      fixedSource: """
        infix operator +++=
        infix operator *** : A
        infix operator --- : <#identifier#>;
        """
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
        DiagnosticSpec(message: "expected identifier in precedencegroup", fixIts: ["insert identifier"])
      ],
      fixedSource: """
        precedencegroup <#identifier#> {
          associativity: right
        }
        """
    )
  }

  func testOperatorDecl15b() {
    assertParse(
      """
      precedencegroup A {
        associativity1️⃣ right
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in 'associativity' property of precedencegroup", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        precedencegroup A {
          associativity: right
        }
        """
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
        DiagnosticSpec(message: "expected name in 'relation' property of precedencegroup", fixIts: ["insert name"])
      ],
      fixedSource: """
        precedencegroup E {
          higherThan: <#identifier#>
        }
        """
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
        DiagnosticSpec(message: "expected precedence group in operator declaration", fixIts: ["insert precedence group"])
      ],
      fixedSource: """
        postfix operator ++: <#identifier#>
        """
    )
  }

  func testOperatorDecl124() {
    assertParse(
      """
      1️⃣@objc
      postfix operator ++: PrecedenceGroup
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '@objc' before operator declaration")
      ]
    )
  }

  func testOperatorDecl125() {
    assertParse(
      """
      1️⃣mutating postfix operator --: UndefinedPrecedenceGroup
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'mutating' before operator declaration")
      ]
    )
  }

  func testOperatorDecl126() {
    assertParse(
      """
      1️⃣private(set) infix operator ~~~
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'private(set)' before operator declaration")
      ]
    )
  }

  func testOperatorDecl127() {
    assertParse(
      """
      1️⃣dynamic 2️⃣operator ~~~
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'dynamic' before operator declaration"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "operator must be declared as 'prefix', 'postfix', or 'infix'",
          fixIts: ["insert 'prefix'", "insert 'infix'", "insert 'postfix'"]
        ),
      ],
      fixedSource:
        """
        dynamic prefix operator ~~~
        """
    )
  }

  func testMultipleFixity() {
    assertParse(
      """
      prefix 1️⃣infix operator &+&
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'infix' in operator declaration")
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
