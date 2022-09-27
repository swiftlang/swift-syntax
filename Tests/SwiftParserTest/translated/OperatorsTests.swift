// This test file has been translated from swift/test/Parse/operators.swift

import XCTest

final class OperatorsTests: XCTestCase {
  func testOperators1() {
    AssertParse(
      """
      // This disables importing the stdlib intentionally.
      """
    )
  }

  func testOperators2() {
    AssertParse(
      """
      infix operator == : Equal
      precedencegroup Equal {
        associativity: left
        higherThan: FatArrow
      }
      """
    )
  }

  func testOperators3() {
    AssertParse(
      """
      infix operator & : BitAnd
      precedencegroup BitAnd {
        associativity: left
        higherThan: Equal
      }
      """
    )
  }

  func testOperators4() {
    AssertParse(
      """
      infix operator => : FatArrow
      precedencegroup FatArrow {
        associativity: right
        higherThan: AssignmentPrecedence
      }
      precedencegroup AssignmentPrecedence {
        assignment: true
      }
      """
    )
  }

  func testOperators5() {
    AssertParse(
      """
      precedencegroup DefaultPrecedence {}
      """
    )
  }

  func testOperators6() {
    AssertParse(
      """
      struct Man {}
      struct TheDevil {}
      struct God {}
      """
    )
  }

  func testOperators7() {
    AssertParse(
      """
      struct Five {}
      struct Six {}
      struct Seven {}
      """
    )
  }

  func testOperators8() {
    AssertParse(
      """
      struct ManIsFive {}
      struct TheDevilIsSix {}
      struct GodIsSeven {}
      """
    )
  }

  func testOperators9() {
    AssertParse(
      """
      struct TheDevilIsSixThenGodIsSeven {}
      """
    )
  }

  func testOperators10() {
    AssertParse(
      """
      func == (x: Man, y: Five) -> ManIsFive {}
      func == (x: TheDevil, y: Six) -> TheDevilIsSix {}
      func == (x: God, y: Seven) -> GodIsSeven {}
      """
    )
  }

  func testOperators11() {
    AssertParse(
      """
      func => (x: TheDevilIsSix, y: GodIsSeven) -> TheDevilIsSixThenGodIsSeven {}
      func => (x: ManIsFive, y: TheDevilIsSixThenGodIsSeven) {}
      """
    )
  }

  func testOperators12() {
    AssertParse(
      """
      func test1() {
        Man() == Five() => TheDevil() == Six() => God() == Seven()
      }
      """
    )
  }

  func testOperators13() {
    AssertParse(
      """
      postfix operator *!*
      prefix operator *!*
      """
    )
  }

  func testOperators14() {
    AssertParse(
      """
      struct LOOK {}
      struct LOOKBang {
        func exclaim() {}
      }
      """
    )
  }

  func testOperators15() {
    AssertParse(
      """
      postfix func *!* (x: LOOK) -> LOOKBang {}
      prefix func *!* (x: LOOKBang) {}
      """
    )
  }

  func testOperators16() {
    AssertParse(
      """
      func test2() {
        *!*LOOK()*!*
      }
      """
    )
  }

  func testOperators17() {
    AssertParse(
      """
      // This should be parsed as (x*!*).exclaim()
      LOOK()*!*.exclaim()
      """
    )
  }

  func testOperators18() {
    AssertParse(
      """
      prefix operator ^
      infix operator ^
      postfix operator ^
      """
    )
  }

  func testOperators19() {
    AssertParse(
      """
      postfix func ^ (x: God) -> TheDevil {}
      prefix func ^ (x: TheDevil) -> God {}
      """
    )
  }

  func testOperators20() {
    AssertParse(
      """
      func ^ (x: TheDevil, y: God) -> Man {}
      """
    )
  }

  func testOperators21() {
    AssertParse(
      """
      var _ : TheDevil = God()^
      var _ : God = ^TheDevil()
      var _ : Man = TheDevil() ^ God()
      var _ : Man = God()^ ^ ^TheDevil()
      let _ = God()^TheDevil()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: operator argument #2 must precede operator argument #1, Fix-It replacements: 9 - 9 = 'TheDevil()', 14 - 25 = ''
      ]
    )
  }

  func testOperators22() {
    AssertParse(
      """
      postfix func ^ (x: Man) -> () -> God {
        return { return God() }
      }
      """
    )
  }

  func testOperators23() {
    AssertParse(
      """
      var _ : God = Man()^()
      """
    )
  }

  func testOperators24() {
    AssertParse(
      """
      func &(x : Man, y : Man) -> Man { return x } // forgive amp_prefix token
      """
    )
  }

  func testOperators25() {
    AssertParse(
      """
      prefix operator ⚽️
      """
    )
  }

  func testOperators26() {
    AssertParse(
      """
      prefix func ⚽️(x: Man) { }
      """
    )
  }

  func testOperators27() {
    AssertParse(
      """
      infix operator ?? : OptTest
      precedencegroup OptTest {
        associativity: right
      }
      """
    )
  }

  func testOperators28() {
    AssertParse(
      """
      func ??(x: Man, y: TheDevil) -> TheDevil {
        return y
      }
      """
    )
  }

  func testOperators29() {
    AssertParse(
      """
      func test3(a: Man, b: Man, c: TheDevil) -> TheDevil {
        return a ?? b ?? c
      }
      """
    )
  }

  func testOperators30() {
    AssertParse(
      """
      // <rdar://problem/17821399> We don't parse infix operators bound on both
      // sides that begin with ! or ? correctly yet.
      infix operator !!
      """
    )
  }

  func testOperators31() {
    AssertParse(
      """
      func !!(x: Man, y: Man) {}
      let foo = Man()
      let bar = TheDevil()
      foo!!foo
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: consecutive statements, Fix-It replacements: 6 - 6 = ';'
      ]
    )
  }

  func testOperators32() {
    AssertParse(
      """
      foo??bar
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: consecutive statements, Fix-It replacements: 6 - 6 = ';'
      ]
    )
  }

}
