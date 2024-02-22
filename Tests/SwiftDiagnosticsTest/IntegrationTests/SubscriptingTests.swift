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

// This test file has been translated from swift/test/Parse/subscripting.swift

import XCTest

final class SubscriptingTests: XCTestCase {
  func testSubscripting1() {
    assertParsedSource(
      """
      struct A0 {
        subscript
          i : Int
           -> Int {
          get {
            return stored
          }
          set {
            stored = value
          }
        }
      }
      """,
      expecting:
        """
         1 │ struct A0 {
         2 │   subscript
           │            ╰─ error: expected '(' to start parameter clause
         3 │     i : Int
           │         │  ╰─ error: expected ')' in function type
           │         ╰─ error: expected '(' to start function type
         4 │      -> Int {
           │            │╰─ error: expected '->' and return type in subscript
           │            ╰─ error: expected ')' to end parameter clause
         5 │     get {
         6 │       return stored

        """
    )
  }

  func testSubscripting2() {
    assertParsedSource(
      """
      // Parsing errors
      struct A0 {
        subscript -> Int {
          return 1
        }
      }
      """,
      expecting:
        """
        1 │ // Parsing errors
        2 │ struct A0 {
        3 │   subscript -> Int {
          │            ╰─ error: expected parameter clause in subscript
        4 │     return 1
        5 │   }

        """
    )
  }

  func testSubscripting3() {
    assertParsedSource(
      """
      struct A1 {
        subscript (i : Int)
           Int {
          get {
            return stored
          }
          set {
            stored = newValue
          }
        }
      }
      """,
      expecting:
        """
         1 │ struct A1 {
         2 │   subscript (i : Int)
           │                      ╰─ error: expected '->' in subscript
         3 │      Int {
         4 │     get {

        """
    )
  }

  func testSubscripting4() {
    assertParsedSource(
      """
      struct A2 {
        subscript (i : Int) ->
           {
          get {
            return stored
          }
          set {
            stored = newValue
          }
        }
      }
      """,
      expecting:
        """
         1 │ struct A2 {
         2 │   subscript (i : Int) ->
           │                         ╰─ error: expected return type in subscript
         3 │      {
         4 │     get {

        """
    )
  }

  func testSubscripting5() {
    assertParsedSource(
      """
      struct A3 {
        subscript(i : Int)
        {
          get {
            return i
          }
        }
      }
      """,
      expecting:
        """
        1 │ struct A3 {
        2 │   subscript(i : Int)
          │                     ╰─ error: expected '->' and return type in subscript
        3 │   {
        4 │     get {

        """
    )
  }

  func testSubscripting6() {
    assertParsedSource(
      """
      struct A4 {
        subscript(i : Int) {
          get {
            return i
          }
        }
      }
      """,
      expecting:
        """
        1 │ struct A4 {
        2 │   subscript(i : Int) {
          │                      ╰─ error: expected '->' and return type in subscript
        3 │     get {
        4 │       return i

        """
    )
  }

  func testSubscripting7() {
    assertParsedSource(
      """
      struct A6 {
        subscript(i: Int)(j: Int) -> Int {
          get {
            return i + j
          }
        }
      }
      """,
      expecting:
        """
        1 │ struct A6 {
        2 │   subscript(i: Int)(j: Int) -> Int {
          │                    ╰─ error: unexpected code '(j: Int)' in subscript
        3 │     get {
        4 │       return i + j

        """
    )
  }

  func testSubscripting8() {
    assertParsedSource(
      """
      struct A8 {
        subscript(i : Int) -> Int
          get {
            return stored
          }
          set {
            stored = value
          }
        }
      """,
      expecting:
        """
        1 │ struct A8 {
          │           ╰─ note: to match this opening '{'
        2 │   subscript(i : Int) -> Int
          │                            ╰─ error: expected '{' in subscript
        3 │     get {
        4 │       return stored
          ┆
        7 │       stored = value
        8 │     }
        9 │   }
          │    ╰─ error: expected '}' to end struct

        """
    )
  }

  func testSubscripting9() {
    assertParsedSource(
      """
      struct A9 {
        subscript x() -> Int {
          return 0
        }
      }
      """,
      expecting:
        """
        1 │ struct A9 {
        2 │   subscript x() -> Int {
          │             ╰─ error: subscripts cannot have a name
        3 │     return 0
        4 │   }

        """
    )
  }

  func testSubscripting10() {
    assertParsedSource(
      """
      struct A10 {
        subscript x(i: Int) -> Int {
          return 0
        }
        subscript x<T>(i: T) -> Int {
          return 0
        }
      }
      """,
      expecting:
        """
        1 │ struct A10 {
        2 │   subscript x(i: Int) -> Int {
          │             ╰─ error: subscripts cannot have a name
        3 │     return 0
        4 │   }
        5 │   subscript x<T>(i: T) -> Int {
          │             ╰─ error: subscripts cannot have a name
        6 │     return 0
        7 │   }

        """
    )
  }

  func testSubscripting11() {
    assertParsedSource(
      """
      struct A11 {
        subscript x y : Int -> Int {
          return 0
        }
      }
      """,
      expecting:
        """
        1 │ struct A11 {
        2 │   subscript x y : Int -> Int {
          │            │      │  │      │╰─ error: expected '->' and return type in subscript
          │            │      │  │      ╰─ error: expected ')' to end parameter clause
          │            │      │  ╰─ error: expected ')' in function type
          │            │      ╰─ error: expected '(' to start function type
          │            ╰─ error: expected '(' to start parameter clause
        3 │     return 0
        4 │   }

        """
    )
  }
}
