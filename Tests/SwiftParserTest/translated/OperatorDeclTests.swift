// This test file has been translated from swift/test/Parse/operator_decl.swift

import XCTest

final class OperatorDeclTests: XCTestCase {
  func testOperatorDecl1() {
    AssertParse(
      """
      prefix operator +++ {} 
      postfix operator +++ {} 
      infix operator +++ {} 
      infix operator +++* { //  {{none}}
        associativity right
      }
      infix operator +++*+ : A { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 20 - 23 = ''
        // TODO: Old parser expected error on line 2: operator should no longer be declared with body, Fix-It replacements: 21 - 24 = ''
        // TODO: Old parser expected error on line 3: operator should no longer be declared with body, Fix-It replacements: 19 - 22 = ''
        // TODO: Old parser expected error on line 4: operator should no longer be declared with body; use a precedence group instead
        // TODO: Old parser expected error on line 7: operator should no longer be declared with body, Fix-It replacements: 25 - 29 = ''
      ]
    )
  }

  func testOperatorDecl2() {
    AssertParse(
      """
      prefix operator +++** : A { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: only infix operators may declare a precedence, Fix-It replacements: 23 - 27 = ''
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 26 - 30 = ''
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
      postfix operator ++*+* : A { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: only infix operators may declare a precedence, Fix-It replacements: 24 - 28 = ''
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 27 - 31 = ''
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
      operator +*+++ { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator must be declared as 'prefix', 'postfix', or 'infix'
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 15 - 19 = ''
      ]
    )
  }

  func testOperatorDecl8() {
    AssertParse(
      """
      operator +*++* : A { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: operator must be declared as 'prefix', 'postfix', or 'infix'
        // TODO: Old parser expected error on line 1: operator should no longer be declared with body, Fix-It replacements: 19 - 23 = ''
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
      #^DIAG^#;
      prefix operator %%+
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected text before operator"),
      ]
    )
  }

  func testOperatorDecl11() {
    AssertParse(
      """
      prefix operator ??
      postfix operator ?? 
      prefix operator !!
      postfix operator !! 
      postfix operator ?$$
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: postfix operator names starting with '?' or '!' are disallowed to avoid collisions with built-in unwrapping operators
        // TODO: Old parser expected error on line 4: postfix operator names starting with '?' or '!' are disallowed to avoid collisions with built-in unwrapping operators
        // TODO: Old parser expected error on line 5: postfix operator names starting with '?' or '!' are disallowed
        // TODO: Old parser expected error on line 5: '$$' is considered an identifier
      ]
    )
  }

  func testOperatorDecl12() {
    AssertParse(
      """
      infix operator --aa 
      infix operator aa#^DIAG_1^#--: A 
      infix operator <<$$@#^DIAG_2^#< 
      infix operator !!@aa 
      infix operator ##^DIAG_3^#++= 
      infix operator ++=#^DIAG_4^## 
      infix operator ->#^DIAG_5^##
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'aa' is considered an identifier and must not appear within an operator name
        // TODO: Old parser expected error on line 2: 'aa' is considered an identifier and must not appear within an operator name
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text before operator"),
        // TODO: Old parser expected error on line 3: '$$' is considered an identifier and must not appear within an operator name
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected name in attribute"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text in operator"),
        // TODO: Old parser expected error on line 4: '@' is not allowed in operator names
        // TODO: Old parser expected error on line 5: '#' is not allowed in operator names
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text before operator"),
        // TODO: Old parser expected error on line 6: '#' is not allowed in operator names
        DiagnosticSpec(locationMarker: "DIAG_4", message: "unexpected text before operator"),
        // TODO: Old parser expected error on line 7: '#' is not allowed in operator names
        DiagnosticSpec(locationMarker: "DIAG_5", message: "extraneous '#' at top level"),
      ]
    )
  }

  func testOperatorDecl13() {
    AssertParse(
      """
      // FIXME: Ideally, we shouldn't emit the «consistent whitespace» diagnostic
      // where = cannot possibly mean an assignment.
      infix operator =#^DIAG^##=
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
      infix operator --- : #^DIAG^#;
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
      precedencegroup #^DIAG_1^#{ 
        associativity: right
      }
      precedencegroup A {
        associativity #^DIAG_2^#right 
      }
      precedencegroup B {
        #^DIAG_3^#precedence 123 
      }
      precedencegroup C {
        associativity: sinister 
      }
      precedencegroup D {
        assignment: #^DIAG_4^#no 
      }
      precedencegroup E {
        higherThan:#^DIAG_5^#
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected identifier after 'precedencegroup'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in precedencegroup"),
        // TODO: Old parser expected error on line 5: expected colon after attribute name in precedence group
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ':' in 'associativity' property of precedencegroup"),
        // TODO: Old parser expected error on line 8: 'precedence' is not a valid precedence group attribute
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text 'precedence 123' in precedencegroup"),
        // TODO: Old parser expected error on line 11: expected 'none', 'left', or 'right' after 'associativity'
        // TODO: Old parser expected error on line 14: expected 'true' or 'false' after 'assignment'
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected 'true' in 'assignment' property of precedencegroup"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "unexpected text 'no' in precedencegroup"),
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected identifier in 'relation' property of precedencegroup"),
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
      postfix operator ++:#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: only infix operators may declare a precedence, Fix-It replacements: 20 - 21 = ''
        DiagnosticSpec(message: "expected identifier in operator"),
        // TODO: Old parser expected error on line 2: expected precedence group name after ':' in operator declaration
      ]
    )
  }

}
