// This test file has been translated from swift/test/Parse/optional_chain_lvalues.swift

import XCTest

final class OptionalChainLvaluesTests: XCTestCase {
  func testOptionalChainLvalues1() {
    AssertParse(
      """
      struct S {
        var x: Int = 0
        let y: Int = 0  // expected-note 3 {{change 'let' to 'var' to make it mutable}} {{3-6=var}} {{3-6=var}} {{3-6=var}}
        mutating func mutateS() {}
        init() {}
      }
      """
    )
  }

  func testOptionalChainLvalues2() {
    AssertParse(
      """
      struct T {
        var mutS: S? = nil
        let immS: S? = nil  // expected-note 4 {{change 'let' to 'var' to make it mutable}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}}
        mutating func mutateT() {}
        init() {}
      }
      """
    )
  }

  func testOptionalChainLvalues3() {
    AssertParse(
      """
      var mutT: T?
      let immT: T? = nil
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 2: change 'let' to 'var' to make it mutable, Fix-It replacements: 1 - 4 = 'var'
      ]
    )
  }

  func testOptionalChainLvalues4() {
    AssertParse(
      """
      postfix operator ++
      prefix operator ++
      """
    )
  }

  func testOptionalChainLvalues5() {
    AssertParse(
      """
      public postfix func ++ <T>(rhs: inout T) -> T { fatalError() }
      public prefix func ++ <T>(rhs: inout T) -> T { fatalError() }
      """
    )
  }

  func testOptionalChainLvalues6() {
    AssertParse(
      """
      mutT?.mutateT()
      immT?.mutateT() 
      mutT?.mutS?.mutateS()
      mutT?.immS?.mutateS() 
      mutT?.mutS?.x += 1
      mutT?.mutS?.y++
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot use mutating member on immutable value: 'immT' is a 'let' constant
        // TODO: Old parser expected error on line 4: cannot use mutating member on immutable value: 'immS' is a 'let' constant
        // TODO: Old parser expected error on line 6: cannot pass immutable value to mutating operator: 'y' is a 'let' constant
      ]
    )
  }

  func testOptionalChainLvalues7() {
    AssertParse(
      """
      // Prefix operators don't chain
      ++mutT?.mutS?.x 
      ++mutT?.mutS?.y
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: cannot pass immutable value of type 'Int?' to mutating operator
        // TODO: Old parser expected error on line 3: cannot pass immutable value of type 'Int?' to mutating operator
      ]
    )
  }

  func testOptionalChainLvalues8() {
    AssertParse(
      """
      mutT? = T()
      mutT?.mutS = S()
      mutT?.mutS? = S()
      mutT?.mutS?.x += 0
      _ = mutT?.mutS?.x + 0 
      mutT?.mutS?.y -= 0 
      mutT?.immS = S() 
      mutT?.immS? = S() 
      mutT?.immS?.x += 0 
      mutT?.immS?.y -= 0
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: value of optional type 'Int?' must be unwrapped
        // TODO: Old parser expected note on line 5: coalesce
        // TODO: Old parser expected note on line 5: force-unwrap
        // TODO: Old parser expected error on line 6: left side of mutating operator isn't mutable: 'y' is a 'let' constant
        // TODO: Old parser expected error on line 7: cannot assign to property: 'immS' is a 'let' constant
        // TODO: Old parser expected error on line 8: cannot assign to value: 'immS' is a 'let' constant
        // TODO: Old parser expected error on line 9: left side of mutating operator isn't mutable: 'immS' is a 'let' constant
        // TODO: Old parser expected error on line 10: left side of mutating operator isn't mutable: 'y' is a 'let' constant
      ]
    )
  }

}
