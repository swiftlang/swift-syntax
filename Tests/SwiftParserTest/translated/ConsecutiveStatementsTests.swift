// This test file has been translated from swift/test/Parse/consecutive_statements.swift

import XCTest

final class ConsecutiveStatementsTests: XCTestCase {
  func testSimple() {
    AssertParse(
      "let x = 2#^DIAG^# let y = 3",
      diagnostics: [
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'", fixIts: ["insert ';'"]),
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
        i = j#^DIAG_1^# j = i
        let r : Int#^DIAG_2^# i = j
        let s : Int#^DIAG_3^# let t : Int
        _ = r; _ = s; _ = t
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testConsecutiveStatements3() {
    AssertParse(
      """
      struct X {
        // In a sequence of declarations.
        var a, b : Int func d() -> Int {} 
        var prop : Int { return 4
        } var other : Float 
        // Within property accessors
        subscript(i: Int) -> Float {
          get {
            var x = i#^DIAG_1^# x = i + x#^DIAG_2^# return Float(x)
          }
          set {
            var x = i#^DIAG_3^# x = i + 1
            _ = x
          }
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testConsecutiveStatements4() {
    AssertParse(
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
      diagnostics: [
        // TODO: Old parser expected error on line 3: consecutive declarations, Fix-It replacements: 17 - 17 = ';'
      ]
    )
  }

  func testConsecutiveStatements5() {
    AssertParse(
      """
      protocol P {
        func a() func b() 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: consecutive declarations, Fix-It replacements: 11 - 11 = ';'
      ]
    )
  }

  func testConsecutiveStatements6() {
    AssertParse(
      """
      enum Color {
        case Red case Blue 
        func a() {} func b() {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: consecutive declarations, Fix-It replacements: 11 - 11 = ';'
        // TODO: Old parser expected error on line 3: consecutive declarations, Fix-It replacements: 14 - 14 = ';'
      ]
    )
  }

  func testConsecutiveStatements7() {
    AssertParse(
      """
      // At the top level
      var i, j : Int#^DIAG_1^# i = j#^DIAG_2^# j = i
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }
}
