// This test file has been translated from swift/test/Parse/semicolon.swift

import XCTest

final class SemicolonTests: XCTestCase {
  func testSemicolon1() {
    AssertParse(
      #"""
      let a = 42;
      var b = "b";
      """#
    )
  }

  func testSemicolon2() {
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
      """
      typealias C1 = C;
      """
    )
  }

  func testSemicolon6() {
    AssertParse(
      """
      protocol D {
          var foo: () -> Int { get };
      }
      """
    )
  }

  func testSemicolon7() {
    AssertParse(
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
    AssertParse(
      """
      import Swift;
      """
    )
  }

  func testSemicolon9() {
    AssertParse(
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
    AssertParse(
      """
      let six = (1..<3).reduce(0, +);
      """
    )
  }

  func testSemicolon11() {
    AssertParse(
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
    AssertParse(
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
