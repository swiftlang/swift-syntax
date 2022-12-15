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

// This test file has been translated from swift/test/Parse/consecutive_statements.swift

import XCTest

final class ConsecutiveStatementsTests: XCTestCase {
  func testSimple() {
    AssertParse(
      "let x = 21️⃣ let y = 3",
      diagnostics: [
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"])
      ],
      fixedSource: "let x = 2; let y = 3"
    )
  }

  func testConsecutiveStatements1() {
    AssertParse(
      """
      func statement_starts() {
        var f : (Int) -> ()
        f = { (x : Int) -> () in }
        f(0)
        f (0)
        f 
        (0) 
        var a = [1,2,3]
        a[0] = 1
        a [0] = 1
        a 
        [0, 1, 2] 
      }
      """
    )
  }

  func testConsecutiveStatements2() {
    AssertParse(
      """
      // Within a function
      func test(i: inout Int, j: inout Int) {
        // Okay
        let q : Int; i = j; j = i; _ = q
        if i != j { i = j }
        // Errors
        i = j1️⃣ j = i
        let r : Int2️⃣ i = j
        let s : Int3️⃣ let t : Int
        _ = r; _ = s; _ = t
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testConsecutiveStatements3() {
    AssertParse(
      """
      struct X {
        // In a sequence of declarations.
        var a, b : Int1️⃣ func d() -> Int {}
        var prop : Int { return 4
        }2️⃣ var other : Float
        // Within property accessors
        subscript(i: Int) -> Float {
          get {
            var x = i3️⃣ x = i + x4️⃣ return Float(x)
          }
          set {
            var x = i5️⃣ x = i + 1
            _ = x
          }
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive declarations on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive declarations on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "5️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testConsecutiveStatements4() {
    AssertParse(
      """
      class C {
        // In a sequence of declarations.
        var a, b : Int1️⃣ func d() -> Int {}
        init() {
          a = 0
          b = 0
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive declarations on a line must be separated by ';'", fixIts: ["insert ';'"])
      ],
      fixedSource: """
        class C {
          // In a sequence of declarations.
          var a, b : Int; func d() -> Int {}
          init() {
            a = 0
            b = 0
          }
        }
        """
    )
  }

  func testConsecutiveStatements5() {
    AssertParse(
      """
      protocol P {
        func a()1️⃣ func b()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive declarations on a line must be separated by ';'", fixIts: ["insert ';'"])
      ],
      fixedSource: """
        protocol P {
          func a(); func b()
        }
        """
    )
  }

  func testConsecutiveStatements6() {
    AssertParse(
      """
      enum Color {
        case Red1️⃣ case Blue
        func a() {}2️⃣ func b() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive declarations on a line must be separated by ';'", fixIts: ["insert ';'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive declarations on a line must be separated by ';'", fixIts: ["insert ';'"]),
      ],
      fixedSource: """
        enum Color {
          case Red; case Blue
          func a() {}; func b() {}
        }
        """
    )
  }

  func testConsecutiveStatements7() {
    AssertParse(
      """
      // At the top level
      var i, j : Int1️⃣ i = j2️⃣ j = i
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }
}
