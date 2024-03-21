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

// This test file has been translated from swift/test/Parse/operators.swift

import XCTest

final class OperatorsTests: ParserTestCase {
  func testOperators1() {
    assertParse(
      """
      // This disables importing the stdlib intentionally.
      """
    )
  }

  func testOperators2() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      precedencegroup DefaultPrecedence {}
      """
    )
  }

  func testOperators6() {
    assertParse(
      """
      struct Man {}
      struct TheDevil {}
      struct God {}
      """
    )
  }

  func testOperators7() {
    assertParse(
      """
      struct Five {}
      struct Six {}
      struct Seven {}
      """
    )
  }

  func testOperators8() {
    assertParse(
      """
      struct ManIsFive {}
      struct TheDevilIsSix {}
      struct GodIsSeven {}
      """
    )
  }

  func testOperators9() {
    assertParse(
      """
      struct TheDevilIsSixThenGodIsSeven {}
      """
    )
  }

  func testOperators10() {
    assertParse(
      """
      func == (x: Man, y: Five) -> ManIsFive {}
      func == (x: TheDevil, y: Six) -> TheDevilIsSix {}
      func == (x: God, y: Seven) -> GodIsSeven {}
      """
    )
  }

  func testOperators11() {
    assertParse(
      """
      func => (x: TheDevilIsSix, y: GodIsSeven) -> TheDevilIsSixThenGodIsSeven {}
      func => (x: ManIsFive, y: TheDevilIsSixThenGodIsSeven) {}
      """
    )
  }

  func testOperators12() {
    assertParse(
      """
      func test1() {
        Man() == Five() => TheDevil() == Six() => God() == Seven()
      }
      """
    )
  }

  func testOperators13() {
    assertParse(
      """
      postfix operator *!*
      prefix operator *!*
      """
    )
  }

  func testOperators14() {
    assertParse(
      """
      struct LOOK {}
      struct LOOKBang {
        func exclaim() {}
      }
      """
    )
  }

  func testOperators15() {
    assertParse(
      """
      postfix func *!* (x: LOOK) -> LOOKBang {}
      prefix func *!* (x: LOOKBang) {}
      """
    )
  }

  func testOperators16() {
    assertParse(
      """
      func test2() {
        *!*LOOK()*!*
      }
      """
    )
  }

  func testOperators17() {
    assertParse(
      """
      // This should be parsed as (x*!*).exclaim()
      LOOK()*!*.exclaim()
      """
    )
  }

  func testOperators18() {
    assertParse(
      """
      prefix operator ^
      infix operator ^
      postfix operator ^
      """
    )
  }

  func testOperators19() {
    assertParse(
      """
      postfix func ^ (x: God) -> TheDevil {}
      prefix func ^ (x: TheDevil) -> God {}
      """
    )
  }

  func testOperators20() {
    assertParse(
      """
      func ^ (x: TheDevil, y: God) -> Man {}
      """
    )
  }

  func testOperators21() {
    assertParse(
      """
      var _ : TheDevil = God()^
      var _ : God = ^TheDevil()
      var _ : Man = TheDevil() ^ God()
      var _ : Man = God()^ ^ ^TheDevil()
      let _ = God()^TheDevil()
      """
    )
  }

  func testOperators22() {
    assertParse(
      """
      postfix func ^ (x: Man) -> () -> God {
        return { return God() }
      }
      """
    )
  }

  func testOperators23() {
    assertParse(
      """
      var _ : God = Man()^()
      """
    )
  }

  func testOperators24() {
    assertParse(
      """
      func &(x : Man, y : Man) -> Man { return x } // forgive amp_prefix token
      """
    )
  }

  func testOperators25() {
    assertParse(
      """
      prefix operator ⚽️
      """
    )
  }

  func testOperators26() {
    assertParse(
      """
      prefix func ⚽️(x: Man) { }
      """
    )
  }

  func testOperators27() {
    assertParse(
      """
      infix operator ?? : OptTest
      precedencegroup OptTest {
        associativity: right
      }
      """
    )
  }

  func testOperators28() {
    assertParse(
      """
      func ??(x: Man, y: TheDevil) -> TheDevil {
        return y
      }
      """
    )
  }

  func testOperators29() {
    assertParse(
      """
      func test3(a: Man, b: Man, c: TheDevil) -> TheDevil {
        return a ?? b ?? c
      }
      """
    )
  }

  func testOperators30() {
    assertParse(
      """
      // <rdar://problem/17821399> We don't parse infix operators bound on both
      // sides that begin with ! or ? correctly yet.
      infix operator !!
      """
    )
  }

  func testOperators31() {
    assertParse(
      """
      func !!(x: Man, y: Man) {}
      """
    )
  }

  func testOperators32() {
    assertParse(
      """
      let foo = Man()
      """
    )
  }

  func testOperators33() {
    assertParse(
      """
      let bar = TheDevil()
      """
    )
  }

  func testOperators34a() {
    assertParse(
      """
      foo!!1️⃣foo
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        foo!!
        foo
        """
    )
  }

  func testOperators34b() {
    assertParse(
      """
      foo!!1️⃣foo
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        foo!!; foo
        """
    )
  }

  func testOperators35a() {
    assertParse(
      """
      foo??1️⃣bar
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        foo??
        bar
        """
    )
  }

  func testOperators35b() {
    assertParse(
      """
      foo??1️⃣bar
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        foo??; bar
        """
    )
  }
}
