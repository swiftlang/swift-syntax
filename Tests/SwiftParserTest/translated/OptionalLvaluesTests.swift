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

// This test file has been translated from swift/test/Parse/optional_lvalues.swift

import XCTest

final class OptionalLvaluesTests: ParserTestCase {
  func testOptionalLvalues1() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      var mutT: T?
      let immT: T? = nil  // expected-note 4 {{change 'let' to 'var' to make it mutable}} {{1-4=var}} {{1-4=var}} {{1-4=var}} {{1-4=var}}
      """
    )
  }

  func testOptionalLvalues4() {
    assertParse(
      """
      let mutTPayload = mutT!
      """
    )
  }

  func testOptionalLvalues5() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      var mutIUO: T! = nil
      let immIUO: T! = nil // expected-note 2 {{change 'let' to 'var' to make it mutable}} {{1-4=var}} {{1-4=var}}
      """
    )
  }

  func testOptionalLvalues8() {
    assertParse(
      """
      mutIUO!.mutS = S()
      mutIUO!.immS = S()
      immIUO!.mutS = S()
      immIUO!.immS = S()
      """
    )
  }

  func testOptionalLvalues9() {
    assertParse(
      """
      mutIUO.mutS = S()
      mutIUO.immS = S()
      immIUO.mutS = S()
      immIUO.immS = S()
      """
    )
  }

  func testOptionalLvalues10() {
    assertParse(
      """
      func foo(x: Int) {}
      """
    )
  }

  func testOptionalLvalues11() {
    assertParse(
      """
      var nonOptional: S = S()
      _ = nonOptional!
      _ = nonOptional!.x
      """
    )
  }

  func testOptionalLvalues12() {
    assertParse(
      """
      class C {}
      class D: C {}
      """
    )
  }

  func testOptionalLvalues13() {
    assertParse(
      """
      let c = C()
      let d = (c as! D)!
      """
    )
  }

}
