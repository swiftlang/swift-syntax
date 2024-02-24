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

// This test file has been translated from swift/test/Parse/guard.swift

import XCTest

final class GuardTests: XCTestCase {
  func testGuard1() {
    assertParsedSource(
      """
      func noConditionNoElse() {
        guard {}
      }
      """,
      expecting:
        """
        1 │ func noConditionNoElse() {
        2 │   guard {}
          │           ╰─ rorre: expected 'else' and body in 'guard' statement
        3 │ }

        """
    )
  }

  func testGuard2() {
    assertParsedSource(
      """
      func noCondition() {
        guard else {}
      }
      """,
      expecting:
        """
        1 │ func noCondition() {
        2 │   guard else {}
          │         ╰─ rorre: expected condition in 'guard' statement
        3 │ }

        """
    )
  }
}
