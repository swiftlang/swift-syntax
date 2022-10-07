// This test file has been translated from swift/test/Parse/operator_decl.swift

import XCTest

final class OperatorDeclTests: XCTestCase {
  func testOperatorDecl1a() {
    AssertParse(
      """
      prefix operator +++1️⃣ {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 20 - 23 = ''
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl1b() {
    AssertParse(
      """
      postfix operator +++1️⃣ {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 21 - 24 = ''
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl1c() {
    AssertParse(
      """
      infix operator +++1️⃣ {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 19 - 22 = ''
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl1d() {
    AssertParse(
      """
      infix operator +++*1️⃣ { //  {{none}}
        associativity right
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body; use a precedence group instead
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl1e() {
    AssertParse(
      """
      infix operator +++*+ : A1️⃣ { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 25 - 29 = ''
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }


  func testOperatorDecl2() {
    AssertParse(
      """
      prefix operator +++** : A1️⃣ { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: only infix operators may declare a precedence, Fix-It replacements: 23 - 27 = ''
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 26 - 30 = ''
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl3() {
    AssertParse(
      """
      prefix operator ++*++ : A
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: only infix operators may declare a precedence, Fix-It replacements: 23 - 26 = ''
      ]
    )
  }

  func testOperatorDecl4() {
    AssertParse(
      """
      postfix operator ++*+* : A1️⃣ { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: only infix operators may declare a precedence, Fix-It replacements: 24 - 28 = ''
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 27 - 31 = ''
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl5() {
    AssertParse(
      """
      postfix operator ++**+ : A
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: only infix operators may declare a precedence, Fix-It replacements: 24 - 27 = ''
      ]
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
      operator +*+++1️⃣ { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator must be declared as 'prefix', 'postfix', or 'infix'
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 15 - 19 = ''
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl8() {
    AssertParse(
      """
      operator +*++* : A1️⃣ { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator must be declared as 'prefix', 'postfix', or 'infix'
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 19 - 23 = ''
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl9() {
    AssertParse(
      """
      prefix operator
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected operator name in operator declaration
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
        DiagnosticSpec(message: "unexpected text before operator"),
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: postfix operator names starting with '?' or '!' are disallowed to avoid collisions with built-in unwrapping operators
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: postfix operator names starting with '?' or '!' are disallowed to avoid collisions with built-in unwrapping operators
      ]
    )
  }

  func testOperatorDecl11e() {
    AssertParse(
      """
      postfix operator ?1️⃣$$
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: postfix operator names starting with '?' or '!' are disallowed
        // TODO: Old parser expected error on line 1: '$$' is considered an identifier
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testOperatorDecl12a() {
    AssertParse(
      """
      infix operator --1️⃣aa
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'aa' is considered an identifier and must not appear within an operator name
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testOperatorDecl12b() {
    AssertParse(
      """
      infix operator aa1️⃣--: A
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'aa' is considered an identifier and must not appear within an operator name
        DiagnosticSpec(message: "extraneous '--: A' at top level"),
      ]
    )
  }

  func testOperatorDecl12c() {
    AssertParse(
      """
      infix operator <<1️⃣$$2️⃣@3️⃣<
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 1: '$$' is considered an identifier and must not appear within an operator name
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected name in attribute"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected declaration after attribute"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous '<' at top level"),
      ]
    )
  }

  func testOperatorDecl12d() {
    AssertParse(
      """
      infix operator !!1️⃣@aa2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 1: '@' is not allowed in operator names
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected declaration after attribute"),
      ]
    )
  }

  func testOperatorDecl12e() {
    AssertParse(
      """
      infix operator #1️⃣++=
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#' is not allowed in operator names
        DiagnosticSpec(message: "extraneous '++=' at top level"),
      ]
    )
  }

  func testOperatorDecl12f() {
    AssertParse(
      """
      infix operator ++=1️⃣#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#' is not allowed in operator names
        DiagnosticSpec(message: "extraneous '#' at top level"),
      ]
    )
  }

  func testOperatorDecl12g() {
    AssertParse(
      """
      infix operator ->1️⃣#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: '#' is not allowed in operator names
        DiagnosticSpec(message: "extraneous '#' at top level"),
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
        // TODO: Old parser expected error on line 3: '#' is not allowed in operator names
        // TODO: Old parser expected error on line 3: '=' must have consistent whitespace on both sides
        DiagnosticSpec(message: "extraneous '#=' at top level"),
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
        // TODO: Old parser expected error on line 3: expected precedence group name after ':' in operator declaration
        DiagnosticSpec(message: "expected identifier in operator"),
      ]
    )
  }

  func testOperatorDecl15() {
    AssertParse(
      """
      precedencegroup 1️⃣{ 
        associativity: right
      }
      precedencegroup A {
        associativity 2️⃣right 
      }
      precedencegroup B {
        3️⃣precedence 123 
      }
      precedencegroup C {
        associativity: sinister 
      }
      precedencegroup D {
        assignment: 4️⃣no 
      }
      precedencegroup E {
        higherThan:5️⃣
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected identifier after 'precedencegroup'
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in precedencegroup"),
        // TODO: Old parser expected error on line 5: expected colon after attribute name in precedence group
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ':' in 'associativity' property of precedencegroup"),
        // TODO: Old parser expected error on line 8: 'precedence' is not a valid precedence group attribute
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected text 'precedence 123' in precedencegroup"),
        // TODO: Old parser expected error on line 11: expected 'none', 'left', or 'right' after 'associativity'
        // TODO: Old parser expected error on line 14: expected 'true' or 'false' after 'assignment'
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected 'true' in 'assignment' property of precedencegroup"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected text 'no' in precedencegroup"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "expected identifier in 'relation' property of precedencegroup"),
        // TODO: Old parser expected error on line 18: expected name of related precedence group after 'higherThan'
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'associativity' attribute for precedence group declared multiple times
      ]
    )
  }

  func testOperatorDecl18() {
    AssertParse(
      """
      precedencegroup CaretCaretCaret {
        assignment: true 
        assignment: false 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'assignment' attribute for precedence group declared multiple times
      ]
    )
  }

  func testOperatorDecl19() {
    AssertParse(
      """
      class Foo {
        infix operator ||| 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'operator' may only be declared at file scope
      ]
    )
  }

  func testOperatorDecl20() {
    AssertParse(
      """
      infix operator **<< : UndeclaredPrecedenceGroup
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unknown precedence group 'UndeclaredPrecedenceGroup'
      ]
    )
  }

  func testOperatorDecl21() {
    AssertParse(
      """
      protocol Proto {}
      infix operator *<*< : F, Proto
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 2: expected expression
      ]
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
        // TODO: Old parser expected error on line 1: only infix operators may declare a precedence, Fix-It replacements: 20 - 21 = ''
        DiagnosticSpec(message: "expected identifier in operator"),
        // TODO: Old parser expected error on line 2: expected precedence group name after ':' in operator declaration
      ]
    )
  }

}
