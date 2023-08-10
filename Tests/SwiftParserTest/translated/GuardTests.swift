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

final class GuardTests: ParserTestCase {
  func testGuard1() {
    assertParse(
      """
      func noConditionNoElse() {
        guard {} 1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'else' and body in 'guard' statement", fixIts: ["insert 'else' and body"])
      ],
      fixedSource: """
        func noConditionNoElse() {
          guard {} else {
        }
        }
        """
    )
  }

  func testGuard2() {
    assertParse(
      """
      func noCondition() {
        guard 1️⃣else {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected condition in 'guard' statement", fixIts: ["insert condition"])
      ],
      fixedSource: """
        func noCondition() {
          guard <#expression#> else {}
        }
        """
    )
  }
}
