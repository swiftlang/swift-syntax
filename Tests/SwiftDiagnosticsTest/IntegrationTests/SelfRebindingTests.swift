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

// This test file has been translated from swift/test/Parse/self_rebinding.swift

import XCTest

final class SelfRebindingTests: XCTestCase {
  func testSelfRebinding1() {
    assertParsedSource(
      """
      struct T {
          var mutable: Int = 0
          func f() {
              let self = self
          }
      }
      """,
      expecting:
        """
        2 │     var mutable: Int = 0
        3 │     func f() {
        4 │         let self = self
          │             ╰─ error: keyword 'self' cannot be used as an identifier here
        5 │     }
        6 │ }

        """
    )
  }
}
