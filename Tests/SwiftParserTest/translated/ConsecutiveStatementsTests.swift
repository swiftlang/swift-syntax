// This test file has been translated from swift/test/Parse/consecutive_statements.swift

import XCTest

final class ConsecutiveStatementsTests: XCTestCase {
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
        i = j j = i 
        let r : Int i = j 
        let s : Int let t : Int 
        _ = r; _ = s; _ = t
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 7: consecutive statements, Fix-It replacements: 8 - 8 = ';'
        // TODO: Old parser expected error on line 8: consecutive statements, Fix-It replacements: 14 - 14 = ';'
        // TODO: Old parser expected error on line 9: consecutive statements, Fix-It replacements: 14 - 14 = ';'
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
            var x = i x = i + x return Float(x) 
          }
          set {
            var x = i x = i + 1 
            _ = x
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: consecutive declarations, Fix-It replacements: 17 - 17 = ';'
        // TODO: Old parser expected error on line 5: consecutive declarations, Fix-It replacements: 4 - 4 = ';'
        // TODO: Old parser expected error on line 9: consecutive statements, Fix-It replacements: 16 - 16 = ';'
        // TODO: Old parser expected error on line 9: consecutive statements, Fix-It replacements: 26 - 26 = ';'
        // TODO: Old parser expected error on line 12: consecutive statements, Fix-It replacements: 16 - 16 = ';'
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
      var i, j : Int i = j j = i
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: consecutive statements, Fix-It replacements: 15 - 15 = ';'
        // TODO: Old parser expected error on line 2: consecutive statements, Fix-It replacements: 21 - 21 = ';'
      ]
    )
  }

}
