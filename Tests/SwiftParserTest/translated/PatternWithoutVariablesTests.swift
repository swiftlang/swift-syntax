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

// This test file has been translated from swift/test/Parse/pattern_without_variables.swift

import XCTest

final class PatternWithoutVariablesTests: ParserTestCase {
  func testPatternWithoutVariables1() {
    assertParse(
      """
      let _ = 1
      inout _ = 1
      """
    )
  }

  func testPatternWithoutVariables2() {
    assertParse(
      """
      func foo() {
        let _ = 1 // OK
        inout _ = 1
      }
      """
    )
  }

  func testPatternWithoutVariables3() {
    assertParse(
      """
      struct Foo {
        let _ = 1
        var (_, _) = (1, 2)
        func foo() {
          let _ = 1 // OK
        }
        inout (_, _) = (1, 2)
      }
      """
    )
  }

  func testPatternWithoutVariables4() {
    assertParse(
      #"""
      // <rdar://problem/19786845> Warn on "let" and "var" when no data is bound in a pattern
      enum SimpleEnum { case Bar }
      """#
    )
  }

  func testPatternWithoutVariables5() {
    assertParse(
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
        switch a {
        case inout .Bar: break
        }
      }
      """#
    )
  }

  func testPatternWithoutVariables6() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/53293
      class C_53293 {
        static var _: Int { 0 }
      }
      """
    )
  }

}
