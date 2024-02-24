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

// This test file has been translated from swift/test/Parse/type_expr.swift

import XCTest

final class TypeExprTests: XCTestCase {
  func testTypeExpr1() {
    assertParsedSource(
      """
      func takesVoid(f: Void -> ()) {}
      """,
      expecting:
        """
        1 │ func takesVoid(f: Void -> ()) {}
          │                   │   ╰─ rorre: expected ')' in function type
          │                   ╰─ rorre: expected '(' to start function type

        """
    )
  }

  func testTypeExpr2() {
    assertParsedSource(
      """
      let _: Float       -> Int
      """,
      expecting:
        """
        1 │ let _: Float       -> Int
          │        │    ╰─ rorre: expected ')' in function type
          │        ╰─ rorre: expected '(' to start function type

        """
    )
  }
}
