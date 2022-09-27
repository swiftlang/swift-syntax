// This test file has been translated from swift/test/Parse/pattern_without_variables.swift

import XCTest

final class PatternWithoutVariablesTests: XCTestCase {
  func testPatternWithoutVariables1() {
    AssertParse(
      """
      let _ = 1
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: global variable declaration does not bind any variables
      ]
    )
  }

  func testPatternWithoutVariables2() {
    AssertParse(
      """
      func foo() {
        let _ = 1 // OK
      }
      """
    )
  }

  func testPatternWithoutVariables3() {
    AssertParse(
      """
      struct Foo {
        let _ = 1 
        var (_, _) = (1, 2) 
        func foo() {
          let _ = 1 // OK
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: property declaration does not bind any variables
        // TODO: Old parser expected error on line 3: property declaration does not bind any variables
      ]
    )
  }

  func testPatternWithoutVariables4() {
    AssertParse(
      #"""
      // <rdar://problem/19786845> Warn on "let" and "var" when no data is bound in a pattern
      enum SimpleEnum { case Bar }
      """#
    )
  }

  func testPatternWithoutVariables5() {
    AssertParse(
      #"""
      func testVarLetPattern(a : SimpleEnum) {
        switch a {
        case let .Bar: break      
        }
        switch a {
        case let x: _ = x; break         // Ok.
        }
        switch a {
        case let _: break         
        }
        switch (a, 42) {
        case let (_, x): _ = x; break    // ok
        }
        if case let _ = "str" {}  
      }
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 3: 'let' pattern has no effect; sub-pattern didn't bind any variables, Fix-It replacements: 8 - 12 = ''
        // TODO: Old parser expected warning on line 9: 'let' pattern has no effect; sub-pattern didn't bind any variables, Fix-It replacements: 8 - 12 = ''
        // TODO: Old parser expected warning on line 14: 'let' pattern has no effect; sub-pattern didn't bind any variables, Fix-It replacements: 11 - 15 = ''
      ]
    )
  }

  func testPatternWithoutVariables6() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/53293
      class C_53293 {
        static var _: Int { 0 } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: getter/setter can only be defined for a single variable
      ]
    )
  }

}
