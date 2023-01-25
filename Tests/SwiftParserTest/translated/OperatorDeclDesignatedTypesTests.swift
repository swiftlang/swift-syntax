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
      infix operator  <*< : MediumPrecedence1️⃣, InfixMagicOperatorProtocol
      postfix operator ^^ : PostfixMagicOperatorProtocol
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(message: "unexpected code before operator declaration"),
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
      """
    )
  }

  func testOperatorDeclDesignatedTypes9() {
    AssertParse(
      """
      infix operator **+> : MediumPrecedence1️⃣, UndeclaredProtocol
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code ', UndeclaredProtocol' at top level")
      ]
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
      infix operator  <*<<< : MediumPrecedence1️⃣, &
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code ', &' at top level")
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
      infix operator ^%*%^ : MediumPrecedence1️⃣, Struct, Class
      infix operator ^%*%% : Struct2️⃣, Class
      prefix operator %^*^^ : Struct3️⃣, Class
      postfix operator ^^*^% : Struct4️⃣, Class
      prefix operator %%*^^ : LowPrecedence5️⃣, Class
      postfix operator ^^*%% : MediumPrecedence6️⃣, Class
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code before operator declaration"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code before operator declaration"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code before operator declaration"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "unexpected code before operator declaration"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "unexpected code before operator declaration"),
        DiagnosticSpec(locationMarker: "6️⃣", message: "extraneous code ', Class' at top level"),
      ]
    )
  }

  func testOperatorDeclDesignatedTypes19() {
    AssertParse(
      """
      infix operator <*<>*> : AdditionPrecedence1️⃣,
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code ',' at top level")
      ]
    )
  }

}
