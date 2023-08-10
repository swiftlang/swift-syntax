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

final class OperatorDeclDesignatedTypesTests: ParserTestCase {
  func testOperatorDeclDesignatedTypes1() {
    assertParse(
      """
      precedencegroup LowPrecedence {
        associativity: right
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes2() {
    assertParse(
      """
      precedencegroup MediumPrecedence {
        associativity: left
        higherThan: LowPrecedence
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes3() {
    assertParse(
      """
      protocol PrefixMagicOperatorProtocol {
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes4() {
    assertParse(
      """
      protocol PostfixMagicOperatorProtocol {
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes5() {
    assertParse(
      """
      protocol InfixMagicOperatorProtocol {
      }
      """
    )
  }

  func testOperatorDeclDesignatedTypes6() {
    assertParse(
      """
      prefix operator ^^ : PrefixMagicOperatorProtocol
      infix operator  <*< : MediumPrecedence, InfixMagicOperatorProtocol
      postfix operator ^^ : PostfixMagicOperatorProtocol
      """
    )
  }

  func testOperatorDeclDesignatedTypes7() {
    assertParse(
      """
      infix operator ^*^
      prefix operator *^^
      postfix operator ^^*
      """
    )
  }

  func testOperatorDeclDesignatedTypes8() {
    assertParse(
      """
      infix operator **>> : UndeclaredPrecedence
      """
    )
  }

  func testOperatorDeclDesignatedTypes9() {
    assertParse(
      """
      infix operator **+> : MediumPrecedence, UndeclaredProtocol
      """
    )
  }

  func testOperatorDeclDesignatedTypes10() {
    assertParse(
      """
      prefix operator *+*> : MediumPrecedence
      """
    )
  }

  func testOperatorDeclDesignatedTypes11() {
    assertParse(
      """
      postfix operator ++*> : MediumPrecedence
      """
    )
  }

  func testOperatorDeclDesignatedTypes12() {
    assertParse(
      """
      prefix operator *++> : UndeclaredProtocol
      postfix operator +*+> : UndeclaredProtocol
      """
    )
  }

  func testOperatorDeclDesignatedTypes13() {
    assertParse(
      """
      struct Struct {}
      class Class {}
      infix operator *>*> : Struct
      infix operator >**> : Class
      """
    )
  }

  func testOperatorDeclDesignatedTypes14() {
    assertParse(
      """
      prefix operator **>> : Struct
      prefix operator *>*> : Class
      """
    )
  }

  func testOperatorDeclDesignatedTypes15() {
    assertParse(
      """
      postfix operator >*>* : Struct
      postfix operator >>** : Class
      """
    )
  }

  func testOperatorDeclDesignatedTypes16() {
    assertParse(
      """
      infix operator  <*<<< : MediumPrecedence, &
      """
    )
  }

  func testOperatorDeclDesignatedTypes17() {
    assertParse(
      """
      infix operator **^^ : MediumPrecedence
      infix operator **^^ : InfixMagicOperatorProtocol
      """
    )
  }

  func testOperatorDeclDesignatedTypes18() {
    assertParse(
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
    assertParse(
      """
      infix operator <*<>*> : AdditionPrecedence,
      """
    )
  }

}
