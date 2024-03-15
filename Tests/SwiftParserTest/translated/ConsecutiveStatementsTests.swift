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

final class ConsecutiveStatementsTests: ParserTestCase {
  func testSimple1() {
    assertParse(
      "let x = 21️⃣ let y = 3",
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        let x = 2
        let y = 3
        """
    )
  }

  func testSimple2() {
    assertParse(
      "let x = 21️⃣ let y = 3",
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: "let x = 2; let y = 3"
    )
  }

  func testConsecutiveStatements1() {
    assertParse(
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

  func testConsecutiveStatements2a() {
    assertParse(
      """
      // Within a function
      func test(i: inout Int, j: inout Int) {
        // Okay
        let q : Int; i = j; j = i; _ = q
        if i != j { i = j }
        // Errors
        i = j1️⃣ j = i
        let r : Int 2️⃣i = j
        let s : Int3️⃣ let t : Int
        _ = r; _ = s; _ = t
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      applyFixIts: ["insert newline", "insert '='"],
      fixedSource: """
        // Within a function
        func test(i: inout Int, j: inout Int) {
          // Okay
          let q : Int; i = j; j = i; _ = q
          if i != j { i = j }
          // Errors
          i = j
          j = i
          let r : Int = i = j
          let s : Int
          let t : Int
          _ = r; _ = s; _ = t
        }
        """
    )
  }

  func testConsecutiveStatements2b() {
    assertParse(
      """
      // Within a function
      func test(i: inout Int, j: inout Int) {
        // Okay
        let q : Int; i = j; j = i; _ = q
        if i != j { i = j }
        // Errors
        i = j1️⃣ j = i
        let r : Int 2️⃣i = j
        let s : Int3️⃣ let t : Int
        _ = r; _ = s; _ = t
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        // Within a function
        func test(i: inout Int, j: inout Int) {
          // Okay
          let q : Int; i = j; j = i; _ = q
          if i != j { i = j }
          // Errors
          i = j; j = i
          let r : Int i = j
          let s : Int; let t : Int
          _ = r; _ = s; _ = t
        }
        """
    )
  }

  func testConsecutiveStatements3a() {
    assertParse(
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
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "5️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        struct X {
          // In a sequence of declarations.
          var a, b : Int
          func d() -> Int {}
          var prop : Int { return 4
          }
          var other : Float
          // Within property accessors
          subscript(i: Int) -> Float {
            get {
              var x = i
              x = i + x
              return Float(x)
            }
            set {
              var x = i
              x = i + 1
              _ = x
            }
          }
        }
        """
    )
  }

  func testConsecutiveStatements3b() {
    assertParse(
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
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "5️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        struct X {
          // In a sequence of declarations.
          var a, b : Int; func d() -> Int {}
          var prop : Int { return 4
          }; var other : Float
          // Within property accessors
          subscript(i: Int) -> Float {
            get {
              var x = i; x = i + x; return Float(x)
            }
            set {
              var x = i; x = i + 1
              _ = x
            }
          }
        }
        """
    )
  }

  func testConsecutiveStatements4a() {
    assertParse(
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
        DiagnosticSpec(
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        class C {
          // In a sequence of declarations.
          var a, b : Int
          func d() -> Int {}
          init() {
            a = 0
            b = 0
          }
        }
        """
    )
  }

  func testConsecutiveStatements4b() {
    assertParse(
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
        DiagnosticSpec(
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert ';'"],
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

  func testConsecutiveStatements5a() {
    assertParse(
      """
      protocol P {
        func a()1️⃣ func b()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        protocol P {
          func a()
          func b()
        }
        """
    )
  }

  func testConsecutiveStatements5b() {
    assertParse(
      """
      protocol P {
        func a()1️⃣ func b()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        protocol P {
          func a(); func b()
        }
        """
    )
  }

  func testConsecutiveStatements6a() {
    assertParse(
      """
      enum Color {
        case Red1️⃣ case Blue
        func a() {}2️⃣ func b() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        enum Color {
          case Red
          case Blue
          func a() {}
          func b() {}
        }
        """
    )
  }

  func testConsecutiveStatements6b() {
    assertParse(
      """
      enum Color {
        case Red1️⃣ case Blue
        func a() {}2️⃣ func b() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: """
        enum Color {
          case Red; case Blue
          func a() {}; func b() {}
        }
        """
    )
  }

  func testConsecutiveStatements7a() {
    assertParse(
      """
      // At the top level
      var i, j : Int 1️⃣i = j2️⃣ j = i
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        )
      ],
      fixedSource: """
        // At the top level
        var i, j : Int = i = j j = i
        """
    )
  }

  func testConsecutiveStatements7() {
    assertParse(
      """
      // At the top level
      var i, j : Int 1️⃣i = j j = i
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '=' in variable",
          fixIts: ["insert '='"]
        )
      ],
      fixedSource: """
        // At the top level
        var i, j : Int = i = j j = i
        """
    )
  }

  func testConsecutiveStatements8() {
    assertParse(
      """
      class Foo {
        func a() {}1️⃣/* some comment */ func b() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive declarations on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      applyFixIts: ["insert newline"],
      fixedSource: """
        class Foo {
          func a() {}/* some comment */
          func b() {}
        }
        """
    )
  }
}
