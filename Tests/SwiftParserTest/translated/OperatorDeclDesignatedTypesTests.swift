// This test file has been translated from swift/test/Parse/operator_decl_designated_types.swift

import XCTest

final class OperatorDeclDesignatedTypesTests: XCTestCase {
  func testOperatorDeclDesignatedTypes1() {
    AssertParse(
      """
      precedencegroup LowPrecedence {
        associativity: right
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes2() {
    AssertParse(
      """
      precedencegroup MediumPrecedence {
        associativity: left
        higherThan: LowPrecedence
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes3() {
    AssertParse(
      """
      protocol PrefixMagicOperatorProtocol {
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes4() {
    AssertParse(
      """
      protocol PostfixMagicOperatorProtocol {
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes5() {
    AssertParse(
      """
      protocol InfixMagicOperatorProtocol {
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes6() {
    AssertParse(
      """
      prefix operator ^^ : PrefixMagicOperatorProtocol
      infix operator  <*< : MediumPrecedence, InfixMagicOperatorProtocol
      postfix operator ^^ : PostfixMagicOperatorProtocol
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler; please remove the designated type list from this operator declaration, Fix-It replacements: 20 - 49 = ''
        // TODO: Old parser expected warning on line 2: designated types are no longer used by the compiler, Fix-It replacements: 39 - 67 = ''
        // TODO: Old parser expected warning on line 3: designated types are no longer used by the compiler, Fix-It replacements: 21 - 51 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes7() {
    AssertParse(
      """
      infix operator ^*^
      prefix operator *^^
      postfix operator ^^*
      """
    )
  }

  func testOperatorDeclDesignatedTypes8() {
    AssertParse(
      """
      infix operator **>> : UndeclaredPrecedence
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 21 - 43 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes9() {
    AssertParse(
      """
      infix operator **+> : MediumPrecedence, UndeclaredProtocol
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 39 - 59 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes10() {
    AssertParse(
      """
      prefix operator *+*> : MediumPrecedence
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 22 - 40 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes11() {
    AssertParse(
      """
      postfix operator ++*> : MediumPrecedence
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 23 - 41 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes12() {
    AssertParse(
      """
      prefix operator *++> : UndeclaredProtocol
      postfix operator +*+> : UndeclaredProtocol
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 22 - 42 = ''
        // TODO: Old parser expected warning on line 2: designated types are no longer used by the compiler, Fix-It replacements: 23 - 43 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes13() {
    AssertParse(
      """
      struct Struct {}
      class Class {}
      infix operator *>*> : Struct
      infix operator >**> : Class
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 3: designated types are no longer used by the compiler, Fix-It replacements: 21 - 29 = ''
        // TODO: Old parser expected warning on line 4: designated types are no longer used by the compiler, Fix-It replacements: 21 - 28 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes14() {
    AssertParse(
      """
      prefix operator **>> : Struct
      prefix operator *>*> : Class
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 22 - 30 = ''
        // TODO: Old parser expected warning on line 2: designated types are no longer used by the compiler, Fix-It replacements: 22 - 29 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes15() {
    AssertParse(
      """
      postfix operator >*>* : Struct
      postfix operator >>** : Class
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 23 - 31 = ''
        // TODO: Old parser expected warning on line 2: designated types are no longer used by the compiler, Fix-It replacements: 23 - 30 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes16() {
    AssertParse(
      """
      infix operator  <*<<< : MediumPrecedence, &
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 41 - 44 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes17() {
    AssertParse(
      """
      infix operator **^^ : MediumPrecedence 
      infix operator **^^ : InfixMagicOperatorProtocol
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 2: designated types are no longer used by the compiler, Fix-It replacements: 21 - 50 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes18() {
    AssertParse(
      """
      infix operator ^%*%^ : MediumPrecedence, Struct, Class
      infix operator ^%*%% : Struct, Class
      prefix operator %^*^^ : Struct, Class
      postfix operator ^^*^% : Struct, Class
      prefix operator %%*^^ : LowPrecedence, Class
      postfix operator ^^*%% : MediumPrecedence, Class
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 40 - 55 = ''
        // TODO: Old parser expected warning on line 2: designated types are no longer used by the compiler, Fix-It replacements: 30 - 37 = ''
        // TODO: Old parser expected warning on line 2: designated types are no longer used by the compiler, Fix-It replacements: 22 - 30 = ''
        // TODO: Old parser expected warning on line 3: designated types are no longer used by the compiler, Fix-It replacements: 23 - 38 = ''
        // TODO: Old parser expected warning on line 4: designated types are no longer used by the compiler, Fix-It replacements: 24 - 39 = ''
        // TODO: Old parser expected warning on line 5: designated types are no longer used by the compiler, Fix-It replacements: 23 - 45 = ''
        // TODO: Old parser expected warning on line 6: designated types are no longer used by the compiler, Fix-It replacements: 24 - 49 = ''
      ]
    )
  }

  func testOperatorDeclDesignatedTypes19() {
    AssertParse(
      """
      infix operator <*<>*> : AdditionPrecedence,
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: designated types are no longer used by the compiler, Fix-It replacements: 43 - 44 = ''
      ]
    )
  }

}
