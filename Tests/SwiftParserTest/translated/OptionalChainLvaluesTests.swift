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

// This test file has been translated from swift/test/Parse/optional_chain_lvalues.swift

import XCTest

final class OptionalChainLvaluesTests: ParserTestCase {
  func testOptionalChainLvalues1() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      var mutT: T?
      let immT: T? = nil
      """
    )
  }

  func testOptionalChainLvalues4() {
    assertParse(
      """
      postfix operator ++
      prefix operator ++
      """
    )
  }

  func testOptionalChainLvalues5() {
    assertParse(
      """
      public postfix func ++ <T>(rhs: inout T) -> T { fatalError() }
      public prefix func ++ <T>(rhs: inout T) -> T { fatalError() }
      """
    )
  }

  func testOptionalChainLvalues6() {
    assertParse(
      """
      mutT?.mutateT()
      immT?.mutateT()
      mutT?.mutS?.mutateS()
      mutT?.immS?.mutateS()
      mutT?.mutS?.x += 1
      mutT?.mutS?.y++
      """
    )
  }

  func testOptionalChainLvalues7() {
    assertParse(
      """
      // Prefix operators don't chain
      ++mutT?.mutS?.x
      ++mutT?.mutS?.y
      """
    )
  }

  func testOptionalChainLvalues8() {
    assertParse(
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
      """
    )
  }

}
