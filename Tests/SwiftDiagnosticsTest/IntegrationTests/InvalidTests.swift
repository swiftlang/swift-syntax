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

// This test file has been translated from swift/test/Parse/invalid.swift

import XCTest

final class InvalidTests: XCTestCase {
  func testInvalid1() {
    // rdar://15946844
    assertParsedSource(
      """
      func test1(inout var x : Int) {}
      """,
      expecting:
        """
        1 │ func test1(inout var x : Int) {}
          │            ╰─ rorre: 'inout' before a parameter name is not allowed

        """
    )
  }

  func testInvalid2() {
    assertParsedSource(
      """
      func test2(inout let x : Int) {}
      """,
      expecting:
        """
        1 │ func test2(inout let x : Int) {}
          │            ╰─ rorre: 'inout' before a parameter name is not allowed

        """
    )
  }

  func testInvalid3() {
    assertParsedSource(
      """
      func test3(f : (inout _ x : Int) -> Void) {}
      """,
      expecting:
        """
        1 │ func test3(f : (inout _ x : Int) -> Void) {}
          │                 ╰─ rorre: 'inout' before a parameter name is not allowed

        """
    )
  }

  func testInvalid4() {
    assertParsedSource(
      """
      func test1s(__shared var x : Int) {}
      """,
      expecting:
        """
        1 │ func test1s(__shared var x : Int) {}
          │             ╰─ rorre: '__shared' before a parameter name is not allowed

        """
    )
  }

  func testInvalid5() {
    assertParsedSource(
      """
      func test2s(__shared let x : Int) {}
      """,
      expecting:
        """
        1 │ func test2s(__shared let x : Int) {}
          │             ╰─ rorre: '__shared' before a parameter name is not allowed

        """
    )
  }

  func testInvalid6() {
    assertParsedSource(
      """
      func test1o(__owned var x : Int) {}
      """,
      expecting:
        """
        1 │ func test1o(__owned var x : Int) {}
          │             ╰─ rorre: '__owned' before a parameter name is not allowed

        """
    )
  }

  func testInvalid7() {
    assertParsedSource(
      """
      func test2o(__owned let x : Int) {}
      """,
      expecting:
        """
        1 │ func test2o(__owned let x : Int) {}
          │             ╰─ rorre: '__owned' before a parameter name is not allowed

        """
    )
  }

  func testInvalid8() {
    assertParsedSource(
      """
      func test9() {
        undeclared_func(
      }
      """,
      expecting:
        """
        1 │ func test9() {
        2 │   undeclared_func(
          │                   ╰─ rorre: expected value and ')' to end function call
        3 │ }

        """
    )
  }

  func testInvalid9() {
    // rdar://16601779
    assertParsedSource(
      """
      func foo() {
        runAction(SKAction.sequence()
          skview!
      }
      """,
      expecting:
        """
        1 │ func foo() {
        2 │   runAction(SKAction.sequence()
          │            │                   ╰─ rorre: expected ')' to end function call
          │            ╰─ eton: to match this opening '('
        3 │     skview!
        4 │ }

        """
    )
  }

  func testInvalid10() {
    assertParsedSource(
      """
      switch state {
        let duration : Int = 0
        case 1:
          break
      }
      """,
      expecting:
        """
        1 │ switch state {
        2 │   let duration : Int = 0
          │   ╰─ rorre: all statements inside a switch must be covered by a 'case' or 'default' label
        3 │   case 1:
        4 │     break

        """
    )
  }

  func testInvalid11() {
    assertParsedSource(
      #"""
      func testNotCoveredCase(x: Int) {
        switch x {
          let y = "foo"
          switch y {
            case "bar":
              blah blah // ignored
          }
        case "baz":
          break
        case 1:
          break
        default:
          break
        }
      }
      """#,
      expecting:
        #"""
         1 │ func testNotCoveredCase(x: Int) {
         2 │   switch x {
         3 │     let y = "foo"
           │     ╰─ rorre: all statements inside a switch must be covered by a 'case' or 'default' label
         4 │     switch y {
         5 │       case "bar":
         6 │         blah blah // ignored
           │             ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
         7 │     }
         8 │   case "baz":

        """#
    )
  }

  func testInvalid12() {
    // rdar://18926814
    assertParsedSource(
      #"""
      func test14() {
        let abc = 123
        _ = " >> \( abc } ) << "
      """#,
      expecting:
        #"""
        1 │ func test14() {
          │               ╰─ eton: to match this opening '{'
        2 │   let abc = 123
        3 │   _ = " >> \( abc } ) << "
          │                   │       ╰─ rorre: expected '}' to end function
          │                   ╰─ rorre: unexpected brace in string literal

        """#
    )
  }

  func testInvalid13() {
    // rdar://problem/18507467
    assertParsedSource(
      """
      func d(_ b: String -> <T>() -> T) {}
      """,
      expecting:
        """
        1 │ func d(_ b: String -> <T>() -> T) {}
          │       │     │     │   ├─ rorre: expected return type in function type
          │       │     │     │   ├─ rorre: expected ')' to end parameter clause
          │       │     │     │   ╰─ rorre: unexpected code '<T>() -> T)' in function
          │       │     │     ╰─ rorre: expected ')' in function type
          │       │     ╰─ rorre: expected '(' to start function type
          │       ╰─ eton: to match this opening '('

        """
    )
  }

  func testInvalid14() {
    // https://github.com/apple/swift/issues/43190
    // Crash with invalid parameter declaration
    assertParsedSource(
      """
      do {
        class Starfish {}
        struct Salmon {}
        func f(s Starfish,
                  _ ss: Salmon) -> [Int] {}
        func g() { f(Starfish(), Salmon()) }
      }
      """,
      expecting:
        """
        2 │   class Starfish {}
        3 │   struct Salmon {}
        4 │   func f(s Starfish,
          │           ╰─ rorre: expected ':' in parameter
        5 │             _ ss: Salmon) -> [Int] {}
        6 │   func g() { f(Starfish(), Salmon()) }

        """
    )
  }

  func testInvalid15() {
    // https://github.com/apple/swift/issues/43313
    assertParsedSource(
      """
      do {
        func f(_ a: Int, b: Int) {}
        f(1, b: 2,)
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   func f(_ a: Int, b: Int) {}
        3 │   f(1, b: 2,)
          │             ╰─ rorre: expected value in function call
        4 │ }

        """
    )
  }

  func testInvalid16() {
    // https://github.com/apple/swift/issues/43591
    // Two inout crash compiler
    assertParsedSource(
      """
      func f1_43591(a : inout inout Int) {}
      """,
      expecting:
        """
        1 │ func f1_43591(a : inout inout Int) {}
          │                         ╰─ rorre: unexpected 'inout' keyword in type

        """
    )
  }

  func testInvalid17() {
    assertParsedSource(
      """
      func f2_43591(inout inout b: Int) {}
      """,
      expecting:
        """
        1 │ func f2_43591(inout inout b: Int) {}
          │               ╰─ rorre: 'inout inout' before a parameter name is not allowed

        """
    )
  }

  func testInvalid18() {
    assertParsedSource(
      """
      func f3_43591(let let a: Int) {}
      """,
      expecting:
        """
        1 │ func f3_43591(let let a: Int) {}
          │                       ╰─ rorre: unexpected code 'a' in parameter

        """
    )
  }

  func testInvalid19() {
    assertParsedSource(
      """
      func f4_43591(inout x: inout String) {}
      """,
      expecting:
        """
        1 │ func f4_43591(inout x: inout String) {}
          │               ╰─ rorre: 'inout' before a parameter name is not allowed

        """
    )
  }

  func testInvalid20() {
    assertParsedSource(
      """
      func f5_43591(inout i: inout Int) {}
      """,
      expecting:
        """
        1 │ func f5_43591(inout i: inout Int) {}
          │               ╰─ rorre: 'inout' before a parameter name is not allowed

        """
    )
  }

  func testInvalid21() {
    assertParsedSource(
      """
      func repeat() {}
      """,
      expecting:
        """
        1 │ func repeat() {}
          │      ╰─ rorre: keyword 'repeat' cannot be used as an identifier here

        """
    )
  }

  func testInvalid22() {
    assertParsedSource(
      """
      let for = 2
      """,
      expecting:
        """
        1 │ let for = 2
          │     ╰─ rorre: keyword 'for' cannot be used as an identifier here

        """
    )
  }

  func testInvalid23() {
    assertParsedSource(
      """
      func f4_43591(inout x: inout String) {}
      """,
      expecting:
        """
        1 │ func f4_43591(inout x: inout String) {}
          │               ╰─ rorre: 'inout' before a parameter name is not allowed

        """
    )
  }

  func testInvalid24() {
    assertParsedSource(
      """
      func f5_43591(inout i: inout Int) {}
      """,
      expecting:
        """
        1 │ func f5_43591(inout i: inout Int) {}
          │               ╰─ rorre: 'inout' before a parameter name is not allowed

        """
    )
  }

  func testInvalid25() {
    assertParsedSource(
      """
      func repeat() {}
      """,
      expecting:
        """
        1 │ func repeat() {}
          │      ╰─ rorre: keyword 'repeat' cannot be used as an identifier here

        """
    )
  }

  func testInvalid26() {
    assertParsedSource(
      """
      let for = 2
      """,
      expecting:
        """
        1 │ let for = 2
          │     ╰─ rorre: keyword 'for' cannot be used as an identifier here

        """
    )
  }

  func testInvalid27() {
    assertParsedSource(
      """
      func were
      wolf() {}
      """,
      expecting:
        """
        1 │ func were
          │          ╰─ rorre: expected '(' to start parameter clause
        2 │ wolf() {}
          │     │ ╰─ rorre: expected ')' to end parameter clause
          │     ╰─ rorre: expected ':' in parameter

        """
    )
  }

  func testInvalid28() {
    assertParsedSource(
      """
      func hammer
      leavings<T>(x: T) {}
      """,
      expecting:
        """
        1 │ func hammer
          │            ╰─ rorre: expected '(' to start parameter clause
        2 │ leavings<T>(x: T) {}
          │         ├─ rorre: expected ':' and type in parameter
          │         ├─ rorre: expected ')' to end parameter clause
          │         ╰─ rorre: unexpected code '<T>(x: T)' in function

        """
    )
  }

  func testInvalid29() {
    assertParsedSource(
      """
      struct Weak<T: class> {
        weak let value: T
      }
      """,
      expecting:
        """
        1 │ struct Weak<T: class> {
          │                ╰─ rorre: 'class' constraint can only appear on protocol declarations
        2 │   weak let value: T
        3 │ }

        """
    )
  }
}
