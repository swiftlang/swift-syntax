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

// This test file has been translated from swift/test/Parse/borrow_expr.swift

import XCTest

final class BorrowExprTests: ParserTestCase {
  func testBorrowExpr1() {
    assertParse(
      """
      func useString(_ str: String) {}
      var global: String = "123"
      func testGlobal() {
        useString(_borrow global)
      }
      """
    )
  }

  func testBorrowExpr2() {
    assertParse(
      """
      func useString(_ str: String) {}
      func testVar() {
          var t = String()
          t = String()
          useString(_borrow t)
      }
      """
    )
  }

}
