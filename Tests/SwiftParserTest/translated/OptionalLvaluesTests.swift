// This test file has been translated from swift/test/Parse/optional_lvalues.swift

import XCTest

final class OptionalLvaluesTests: XCTestCase {
  func testOptionalLvalues1() {
    AssertParse(
      """
      struct S {
        var x: Int = 0
        let y: Int = 0 // expected-note 4 {{change 'let' to 'var' to make it mutable}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}}
        init() {}
      }
      """
    )
  }

  func testOptionalLvalues2() {
    AssertParse(
      """
      struct T {
        var mutS: S? = nil
        let immS: S? = nil // expected-note 10 {{change 'let' to 'var' to make it mutable}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}} {{3-6=var}}
        init() {}
      }
      """
    )
  }

  func testOptionalLvalues3() {
    AssertParse(
      """
      var mutT: T?
      let immT: T? = nil  // expected-note 4 {{change 'let' to 'var' to make it mutable}} {{1-4=var}} {{1-4=var}} {{1-4=var}} {{1-4=var}}
      """
    )
  }

  func testOptionalLvalues4() {
    AssertParse(
      """
      let mutTPayload = mutT!
      """
    )
  }

  func testOptionalLvalues5() {
    AssertParse(
      """
      mutT! = T()
      mutT!.mutS = S()
      mutT!.mutS! = S()
      mutT!.mutS!.x = 0
      mutT!.mutS!.y = 0 
      mutT!.immS = S() 
      mutT!.immS! = S() 
      mutT!.immS!.x = 0 
      mutT!.immS!.y = 0
      """
    )
  }

  func testOptionalLvalues6() {
    AssertParse(
      """
      immT! = T() 
      immT!.mutS = S() 
      immT!.mutS! = S() 
      immT!.mutS!.x = 0 
      immT!.mutS!.y = 0 
      immT!.immS = S() 
      immT!.immS! = S() 
      immT!.immS!.x = 0 
      immT!.immS!.y = 0
      """
    )
  }

  func testOptionalLvalues7() {
    AssertParse(
      """
      var mutIUO: T! = nil
      let immIUO: T! = nil // expected-note 2 {{change 'let' to 'var' to make it mutable}} {{1-4=var}} {{1-4=var}}
      """
    )
  }

  func testOptionalLvalues8() {
    AssertParse(
      """
      mutIUO!.mutS = S()
      mutIUO!.immS = S() 
      immIUO!.mutS = S() 
      immIUO!.immS = S()
      """
    )
  }

  func testOptionalLvalues9() {
    AssertParse(
      """
      mutIUO.mutS = S()
      mutIUO.immS = S() 
      immIUO.mutS = S() 
      immIUO.immS = S()
      """
    )
  }

  func testOptionalLvalues10() {
    AssertParse(
      """
      func foo(x: Int) {}
      """
    )
  }

  func testOptionalLvalues11() {
    AssertParse(
      """
      var nonOptional: S = S()
      _ = nonOptional! 
      _ = nonOptional!.x
      """
    )
  }

  func testOptionalLvalues12() {
    AssertParse(
      """
      class C {}
      class D: C {}
      """
    )
  }

  func testOptionalLvalues13() {
    AssertParse(
      """
      let c = C()
      let d = (c as! D)!
      """
    )
  }

}
