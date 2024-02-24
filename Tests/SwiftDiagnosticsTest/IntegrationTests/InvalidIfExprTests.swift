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

// This test file has been translated from swift/test/Parse/invalid_if_expr.swift

import XCTest

final class InvalidIfExprTests: XCTestCase {
  func testInvalidIfExpr1() {
    assertParsedSource(
      """
      (a ? b)
      """,
      expecting:
        """
        1 │ (a ? b)
          │       ╰─ rorre: expected ':' and expression after '? ...' in ternary expression

        """
    )
  }

  func testInvalidIfExpr2() {
    assertParsedSource(
      """
      (a ? b : c ? d)
      """,
      expecting:
        """
        1 │ (a ? b : c ? d)
          │               ╰─ rorre: expected ':' and expression after '? ...' in ternary expression

        """
    )
  }

  func testInvalidIfExpr3() {
    assertParsedSource(
      """
      (a ? b ? c : d
      """,
      expecting:
        """
        1 │ (a ? b ? c : d
          │ │             ├─ rorre: expected ':' and expression after '? ...' in ternary expression
          │ │             ╰─ rorre: expected ')' to end tuple
          │ ╰─ eton: to match this opening '('

        """
    )
  }

  func testInvalidIfExpr4() {
    assertParsedSource(
      """
      (a ? b ? c)
      """,
      expecting:
        """
        1 │ (a ? b ? c)
          │           ├─ rorre: expected ':' and expression after '? ...' in ternary expression
          │           ╰─ rorre: expected ':' and expression after '? ...' in ternary expression

        """
    )
  }

  func testInvalidIfExpr5() {
    assertParsedSource(
      """
      foo ? 1 2
      """,
      expecting:
        """
        1 │ foo ? 1 2
          │         ╰─ rorre: expected ':' after '? ...' in ternary expression

        """
    )
  }

  func testInvalidIfExpr6() {
    assertParsedSource(
      """
      foo ? 1
      """,
      expecting:
        """
        1 │ foo ? 1
          │        ╰─ rorre: expected ':' and expression after '? ...' in ternary expression

        """
    )
  }

  func testInvalidIfExpr7() {
    assertParsedSource(
      """
      condition ? 1
      someOtherVariable
      """,
      expecting:
        """
        1 │ condition ? 1
          │              ╰─ rorre: expected ':' and expression after '? ...' in ternary expression
        2 │ someOtherVariable

        """
    )
  }
}
