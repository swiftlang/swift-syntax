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

// This test file has been translated from swift/test/Parse/semicolon.swift

import XCTest

final class SemicolonTests: ParserTestCase {
  func testSemicolon1() {
    assertParse(
      #"""
      let a = 42;
      var b = "b";
      """#
    )
  }

  func testSemicolon2() {
    assertParse(
      """
      struct A {
          var a1: Int;
          let a2: Int ;
          var a3: Int;let a4: Int
          var a5: Int; let a6: Int;
      };
      """
    )
  }

  func testSemicolon3() {
    assertParse(
      """
      enum B {
          case B1;
          case B2(value: Int);
          case B3
          case B4; case B5 ; case B6;
      };
      """
    )
  }

  func testSemicolon4() {
    assertParse(
      """
      class C {
          var x: Int;
          let y = 3.14159;
          init(x: Int) { self.x = x; }
      };
      """
    )
  }

  func testSemicolon5() {
    assertParse(
      """
      typealias C1 = C;
      """
    )
  }

  func testSemicolon6() {
    assertParse(
      """
      protocol D {
          var foo: () -> Int { get };
      }
      """
    )
  }

  func testSemicolon7() {
    assertParse(
      """
      struct D1: D {
          let foo = { return 42; };
      }
      func e() -> Bool {
          return false;
      }
      """
    )
  }

  func testSemicolon8() {
    assertParse(
      """
      import Swift;
      """
    )
  }

  func testSemicolon9() {
    assertParse(
      """
      for i in 1..<1000 {
          if i % 2 == 1 {
              break;
          };
      }
      """
    )
  }

  func testSemicolon10() {
    assertParse(
      """
      let six = (1..<3).reduce(0, +);
      """
    )
  }

  func testSemicolon11() {
    assertParse(
      """
      func lessThanTwo(input: UInt) -> Bool {
          switch input {
          case 0:     return true;
          case 1, 2:  return true;
          default:
              return false;
          }
      }
      """
    )
  }

  func testSemicolon12() {
    assertParse(
      """
      enum StarWars {
          enum Quality { case 😀; case 🙂; case 😐; case 😏; case 😞 };
          case Ep4; case Ep5; case Ep6
          case Ep1, Ep2; case Ep3;
      };
      """
    )
  }

}
