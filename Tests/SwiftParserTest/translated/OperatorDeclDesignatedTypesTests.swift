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

// This test file has been translated from swift/test/Parse/operator_decl_designated_types.swift

import XCTest

// TODO: Designated operator types are only valid in langauge mode 4. We should disallow them in language mode 5.

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
      """
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
      """
    )
  }

  func testOperatorDeclDesignatedTypes9() {
    AssertParse(
      """
      infix operator **+> : MediumPrecedence, UndeclaredProtocol
      """
    )
  }

  func testOperatorDeclDesignatedTypes10() {
    AssertParse(
      """
      prefix operator *+*> : MediumPrecedence
      """
    )
  }

  func testOperatorDeclDesignatedTypes11() {
    AssertParse(
      """
      postfix operator ++*> : MediumPrecedence
      """
    )
  }

  func testOperatorDeclDesignatedTypes12() {
    AssertParse(
      """
      prefix operator *++> : UndeclaredProtocol
      postfix operator +*+> : UndeclaredProtocol
      """
    )
  }

  func testOperatorDeclDesignatedTypes13() {
    AssertParse(
      """
      struct Struct {}
      class Class {}
      infix operator *>*> : Struct
      infix operator >**> : Class
      """
    )
  }

  func testOperatorDeclDesignatedTypes14() {
    AssertParse(
      """
      prefix operator **>> : Struct
      prefix operator *>*> : Class
      """
    )
  }

  func testOperatorDeclDesignatedTypes15() {
    AssertParse(
      """
      postfix operator >*>* : Struct
      postfix operator >>** : Class
      """
    )
  }

  func testOperatorDeclDesignatedTypes16() {
    AssertParse(
      """
      infix operator  <*<<< : MediumPrecedence, &
      """
    )
  }

  func testOperatorDeclDesignatedTypes17() {
    AssertParse(
      """
      infix operator **^^ : MediumPrecedence
      infix operator **^^ : InfixMagicOperatorProtocol
      """
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
      """
    )
  }

  func testOperatorDeclDesignatedTypes19() {
    AssertParse(
      """
      infix operator <*<>*> : AdditionPrecedence,
      """
    )
  }

}
