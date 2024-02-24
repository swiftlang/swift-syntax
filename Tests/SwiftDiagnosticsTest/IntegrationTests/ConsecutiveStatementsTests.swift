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

// This test file has been translated from swift/test/Parse/consecutive_statements.swift

import XCTest

final class ConsecutiveStatementsTests: XCTestCase {
  func testSimple1() {
    assertParsedSource(
      "let x = 2 let y = 3",
      expecting:
        """
        1 │ let x = 2 let y = 3
          │          ╰─ rorre: consecutive statements on a line must be separated by newline or ';'

        """
    )
  }

  func testSimple2() {
    assertParsedSource(
      "let x = 2 let y = 3",
      expecting:
        """
        1 │ let x = 2 let y = 3
          │          ╰─ rorre: consecutive statements on a line must be separated by newline or ';'

        """
    )
  }

  func testConsecutiveStatements1() {
    assertParsedSource(
      """
      // Within a function
      func test(i: inout Int, j: inout Int) {
        // Okay
        let q : Int; i = j; j = i; _ = q
        if i != j { i = j }
        // Errors
        i = j j = i
        let r : Int i = j
        let s : Int let t : Int
        _ = r; _ = s; _ = t
      }
      """,
      expecting:
        """
         5 │   if i != j { i = j }
         6 │   // Errors
         7 │   i = j j = i
           │        ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
         8 │   let r : Int i = j
           │               ╰─ rorre: expected '=' in variable
         9 │   let s : Int let t : Int
           │              ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
        10 │   _ = r; _ = s; _ = t
        11 │ }

        """
    )
  }

  func testConsecutiveStatements2() {
    assertParsedSource(
      """
      // Within a function
      func test(i: inout Int, j: inout Int) {
        // Okay
        let q : Int; i = j; j = i; _ = q
        if i != j { i = j }
        // Errors
        i = j j = i
        let r : Int i = j
        let s : Int let t : Int
        _ = r; _ = s; _ = t
      }
      """,
      expecting:
        """
         5 │   if i != j { i = j }
         6 │   // Errors
         7 │   i = j j = i
           │        ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
         8 │   let r : Int i = j
           │               ╰─ rorre: expected '=' in variable
         9 │   let s : Int let t : Int
           │              ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
        10 │   _ = r; _ = s; _ = t
        11 │ }

        """
    )
  }

  func testConsecutiveStatements3() {
    assertParsedSource(
      """
      struct X {
        // In a sequence of declarations.
        var a, b : Int func d() -> Int {}
        var prop : Int { return 4
        } var other : Float
        // Within property accessors
        subscript(i: Int) -> Float {
          get {
            var x = i x = i + x return Float(x)
          }
          set {
            var x = i x = i + 1
            _ = x
          }
        }
      }
      """,
      expecting:
        """
         1 │ struct X {
         2 │   // In a sequence of declarations.
         3 │   var a, b : Int func d() -> Int {}
           │                 ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         4 │   var prop : Int { return 4
         5 │   } var other : Float
           │    ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         6 │   // Within property accessors
         7 │   subscript(i: Int) -> Float {
         8 │     get {
         9 │       var x = i x = i + x return Float(x)
           │                │         ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
           │                ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
        10 │     }
        11 │     set {
        12 │       var x = i x = i + 1
           │                ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
        13 │       _ = x
        14 │     }

        """
    )
  }

  func testConsecutiveStatements4() {
    assertParsedSource(
      """
      struct X {
        // In a sequence of declarations.
        var a, b : Int func d() -> Int {}
        var prop : Int { return 4
        } var other : Float
        // Within property accessors
        subscript(i: Int) -> Float {
          get {
            var x = i x = i + x return Float(x)
          }
          set {
            var x = i x = i + 1
            _ = x
          }
        }
      }
      """,
      expecting:
        """
         1 │ struct X {
         2 │   // In a sequence of declarations.
         3 │   var a, b : Int func d() -> Int {}
           │                 ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         4 │   var prop : Int { return 4
         5 │   } var other : Float
           │    ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
         6 │   // Within property accessors
         7 │   subscript(i: Int) -> Float {
         8 │     get {
         9 │       var x = i x = i + x return Float(x)
           │                │         ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
           │                ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
        10 │     }
        11 │     set {
        12 │       var x = i x = i + 1
           │                ╰─ rorre: consecutive statements on a line must be separated by newline or ';'
        13 │       _ = x
        14 │     }

        """
    )
  }

  func testConsecutiveStatements5() {
    assertParsedSource(
      """
      class C {
        // In a sequence of declarations.
        var a, b : Int func d() -> Int {}
        init() {
          a = 0
          b = 0
        }
      }
      """,
      expecting:
        """
        1 │ class C {
        2 │   // In a sequence of declarations.
        3 │   var a, b : Int func d() -> Int {}
          │                 ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        4 │   init() {
        5 │     a = 0

        """
    )
  }

  func testConsecutiveStatements6() {
    assertParsedSource(
      """
      class C {
        // In a sequence of declarations.
        var a, b : Int func d() -> Int {}
        init() {
          a = 0
          b = 0
        }
      }
      """,
      expecting:
        """
        1 │ class C {
        2 │   // In a sequence of declarations.
        3 │   var a, b : Int func d() -> Int {}
          │                 ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        4 │   init() {
        5 │     a = 0

        """
    )
  }

  func testConsecutiveStatements7() {
    assertParsedSource(
      """
      protocol P {
        func a() func b()
      }
      """,
      expecting:
        """
        1 │ protocol P {
        2 │   func a() func b()
          │           ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        3 │ }

        """
    )
  }

  func testConsecutiveStatements8() {
    assertParsedSource(
      """
      protocol P {
        func a() func b()
      }
      """,
      expecting:
        """
        1 │ protocol P {
        2 │   func a() func b()
          │           ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        3 │ }

        """
    )
  }

  func testConsecutiveStatements9() {
    assertParsedSource(
      """
      enum Color {
        case Red case Blue
        func a() {} func b() {}
      }
      """,
      expecting:
        """
        1 │ enum Color {
        2 │   case Red case Blue
          │           ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        3 │   func a() {} func b() {}
          │              ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        4 │ }

        """
    )
  }

  func testConsecutiveStatements10() {
    assertParsedSource(
      """
      enum Color {
        case Red case Blue
        func a() {} func b() {}
      }
      """,
      expecting:
        """
        1 │ enum Color {
        2 │   case Red case Blue
          │           ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        3 │   func a() {} func b() {}
          │              ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        4 │ }

        """
    )
  }

  func testConsecutiveStatements11() {
    assertParsedSource(
      """
      // At the top level
      var i, j : Int i = j j = i
      """,
      expecting:
        """
        1 │ // At the top level
        2 │ var i, j : Int i = j j = i
          │                ╰─ rorre: expected '=' in variable

        """
    )
  }

  func testConsecutiveStatements12() {
    assertParsedSource(
      """
      // At the top level
      var i, j : Int i = j j = i
      """,
      expecting:
        """
        1 │ // At the top level
        2 │ var i, j : Int i = j j = i
          │                ╰─ rorre: expected '=' in variable

        """
    )
  }

  func testConsecutiveStatements13() {
    assertParsedSource(
      """
      class Foo {
        func a() {}/* some comment */ func b() {}
      }
      """,
      expecting:
        """
        1 │ class Foo {
        2 │   func a() {}/* some comment */ func b() {}
          │              ╰─ rorre: consecutive declarations on a line must be separated by newline or ';'
        3 │ }

        """
    )
  }
}
