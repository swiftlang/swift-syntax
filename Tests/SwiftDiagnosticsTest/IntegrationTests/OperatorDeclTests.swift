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
  func testOperatorDecl1() {
    assertParsedSource(
      """
      prefix operator +++ {}
      """,
      expecting:
        """
        1 │ prefix operator +++ {}
          │                     ╰─ error: operator should not be declared with body

        """
    )
  }

  func testOperatorDecl2() {
    assertParsedSource(
      """
      postfix operator +++ {}
      """,
      expecting:
        """
        1 │ postfix operator +++ {}
          │                      ╰─ error: operator should not be declared with body

        """
    )
  }

  func testOperatorDecl3() {
    assertParsedSource(
      """
      infix operator +++ {}
      """,
      expecting:
        """
        1 │ infix operator +++ {}
          │                    ╰─ error: operator should not be declared with body

        """
    )
  }

  func testOperatorDecl4() {
    assertParsedSource(
      """
      infix operator +++* {
        associativity right
      }
      """,
      expecting:
        """
        1 │ infix operator +++* {
          │                     ╰─ error: operator should not be declared with body
        2 │   associativity right
        3 │ }

        """
    )
  }

  func testOperatorDecl5() {
    assertParsedSource(
      """
      infix operator +++*+ : A { }
      """,
      expecting:
        """
        1 │ infix operator +++*+ : A { }
          │                          ╰─ error: operator should not be declared with body

        """
    )
  }

  func testOperatorDecl6() {
    assertParsedSource(
      """
      prefix operator +++** : A { }
      """,
      expecting:
        """
        1 │ prefix operator +++** : A { }
          │                           ╰─ error: operator should not be declared with body

        """
    )
  }

  func testOperatorDecl7() {
    assertParsedSource(
      """
      postfix operator ++*+* : A { }
      """,
      expecting:
        """
        1 │ postfix operator ++*+* : A { }
          │                            ╰─ error: operator should not be declared with body

        """
    )
  }

  func testOperatorDecl8() {
    assertParsedSource(
      """
      operator ++*** : A
      """,
      expecting:
        """
        1 │ operator ++*** : A
          │ ╰─ error: operator must be declared as 'prefix', 'postfix', or 'infix'

        """
    )
  }

  func testOperatorDecl9() {
    assertParsedSource(
      """
      operator +*+++ { }
      """,
      expecting:
        """
        1 │ operator +*+++ { }
          │ │              ╰─ error: operator should not be declared with body
          │ ╰─ error: operator must be declared as 'prefix', 'postfix', or 'infix'

        """
    )
  }

  func testOperatorDecl10() {
    assertParsedSource(
      """
      operator +*++* : A { }
      """,
      expecting:
        """
        1 │ operator +*++* : A { }
          │ │                  ╰─ error: operator should not be declared with body
          │ ╰─ error: operator must be declared as 'prefix', 'postfix', or 'infix'

        """
    )
  }

  func testOperatorDecl11() {
    assertParsedSource(
      """
      prefix operator
      """,
      expecting:
        """
        1 │ prefix operator
          │                ╰─ error: expected binary operator in operator declaration

        """
    )
  }

  func testOperatorDecl12() {
    assertParsedSource(
      """
      ;
      prefix operator %%+
      """,
      expecting:
        """
        1 │ ;
          │ ╰─ error: unexpected ';' separator
        2 │ prefix operator %%+

        """
    )
  }

  func testOperatorDecl13() {
    assertParsedSource(
      """
      postfix operator ?$$
      """,
      expecting:
        """
        1 │ postfix operator ?$$
          │                   ╰─ error: '$$' is considered an identifier and must not appear within an operator name

        """
    )
  }

  func testOperatorDecl14() {
    assertParsedSource(
      """
      infix operator --aa
      """,
      expecting:
        """
        1 │ infix operator --aa
          │                  ╰─ error: 'aa' is considered an identifier and must not appear within an operator name

        """
    )
  }

  func testOperatorDecl15() {
    assertParsedSource(
      """
      infix operator aa--: A
      """,
      expecting:
        """
        1 │ infix operator aa--: A
          │                ╰─ error: 'aa' is considered an identifier and must not appear within an operator name

        """
    )
  }

  func testOperatorDecl16() {
    assertParsedSource(
      """
      infix operator <<$$@<
      """,
      expecting:
        """
        1 │ infix operator <<$$@<
          │                  ╰─ error: '$$@<' is not allowed in operator names

        """
    )
  }

  func testOperatorDecl17() {
    assertParsedSource(
      """
      infix operator !!@aa
      """,
      expecting:
        """
        1 │ infix operator !!@aa
          │                  ╰─ error: '@aa' is not allowed in operator names

        """
    )
  }

  func testOperatorDecl18() {
    assertParsedSource(
      """
      infix operator #++=
      """,
      expecting:
        """
        1 │ infix operator #++=
          │                ╰─ error: '#' is not allowed in operator names

        """
    )
  }

  func testOperatorDecl19() {
    assertParsedSource(
      """
      infix operator ++=#
      """,
      expecting:
        """
        1 │ infix operator ++=#
          │                   ╰─ error: '#' is not allowed in operator names

        """
    )
  }

  func testOperatorDecl20() {
    assertParsedSource(
      """
      infix operator ->#
      """,
      expecting:
        """
        1 │ infix operator ->#
          │                  ╰─ error: '#' is not allowed in operator names

        """
    )
  }

  func testOperatorDecl21() {
    assertParsedSource(
      """
      infix operator =#=
      """,
      expecting:
        """
        1 │ infix operator =#=
          │                 ╰─ error: '#=' is not allowed in operator names

        """
    )
  }

  func testOperatorDecl22() {
    assertParsedSource(
      """
      infix operator +++=
      infix operator *** : A
      infix operator --- : ;
      """,
      expecting:
        """
        1 │ infix operator +++=
        2 │ infix operator *** : A
        3 │ infix operator --- : ;
          │                      ╰─ error: expected precedence group in operator declaration

        """
    )
  }

  func testOperatorDecl23() {
    assertParsedSource(
      """
      precedencegroup {
        associativity: right
      }
      """,
      expecting:
        """
        1 │ precedencegroup {
          │                 ╰─ error: expected identifier in precedencegroup
        2 │   associativity: right
        3 │ }

        """
    )
  }

  func testOperatorDecl24() {
    assertParsedSource(
      """
      precedencegroup A {
        associativity right
      }
      """,
      expecting:
        """
        1 │ precedencegroup A {
        2 │   associativity right
          │                ╰─ error: expected ':' in 'associativity' property of precedencegroup
        3 │ }

        """
    )
  }

  func testOperatorDecl25() {
    assertParsedSource(
      """
      precedencegroup B {
        precedence 123
      }
      """,
      expecting:
        """
        1 │ precedencegroup B {
        2 │   precedence 123
          │   ╰─ error: unexpected code 'precedence 123' in precedencegroup
        3 │ }

        """
    )
  }

  func testOperatorDecl26() {
    assertParsedSource(
      """
      precedencegroup C {
        associativity: sinister
      }
      """,
      expecting:
        """
        1 │ precedencegroup C {
        2 │   associativity: sinister
          │                  ╰─ error: Expected 'none', 'left', or 'right' after 'associativity'
        3 │ }

        """
    )
  }

  func testOperatorDecl27() {
    assertParsedSource(
      """
      precedencegroup D {
        assignment: no
      }
      """,
      expecting:
        """
        1 │ precedencegroup D {
        2 │   assignment: no
          │               ╰─ error: expected 'true' or 'false' after 'assignment'
        3 │ }

        """
    )
  }

  func testOperatorDecl28() {
    assertParsedSource(
      """
      precedencegroup E {
        higherThan:
      }
      """,
      expecting:
        """
        1 │ precedencegroup E {
        2 │   higherThan:
          │              ╰─ error: expected name in 'relation' property of precedencegroup
        3 │ }

        """
    )
  }

  func testOperatorDecl29() {
    assertParsedSource(
      """
      postfix operator ++:
      """,
      expecting:
        """
        1 │ postfix operator ++:
          │                     ╰─ error: expected precedence group in operator declaration

        """
    )
  }

  func testOperatorDecl30() {
    assertParsedSource(
      """
      @objc
      postfix operator ++: PrecedenceGroup
      """,
      expecting:
        """
        1 │ @objc
          │ ╰─ error: unexpected code '@objc' before operator declaration
        2 │ postfix operator ++: PrecedenceGroup

        """
    )
  }

  func testOperatorDecl31() {
    assertParsedSource(
      """
      mutating postfix operator --: UndefinedPrecedenceGroup
      """,
      expecting:
        """
        1 │ mutating postfix operator --: UndefinedPrecedenceGroup
          │ ╰─ error: unexpected code 'mutating' before operator declaration

        """
    )
  }

  func testOperatorDecl32() {
    assertParsedSource(
      """
      private(set) infix operator ~~~
      """,
      expecting:
        """
        1 │ private(set) infix operator ~~~
          │ ╰─ error: unexpected code 'private(set)' before operator declaration

        """
    )
  }

  func testOperatorDecl33() {
    assertParsedSource(
      """
      dynamic operator ~~~
      """,
      expecting:
        """
        1 │ dynamic operator ~~~
          │ │       ╰─ error: operator must be declared as 'prefix', 'postfix', or 'infix'
          │ ╰─ error: unexpected code 'dynamic' before operator declaration

        """
    )
  }

  func testMultipleFixity() {
    assertParsedSource(
      """
      prefix infix operator &+&
      """,
      expecting:
        """
        1 │ prefix infix operator &+&
          │        ╰─ error: unexpected code 'infix' in operator declaration

        """
    )
  }

  func testIdentifierAsOperatorName() {
    assertParsedSource(
      "postfix operator aa",
      expecting:
        """
        1 │ postfix operator aa
          │                  ╰─ error: 'aa' is considered an identifier and must not appear within an operator name

        """
    )
  }
}
