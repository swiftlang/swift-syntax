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

// This test file has been translated from swift/test/Parse/foreach_async.swift

import XCTest

final class ForeachAsyncTests: XCTestCase {
  func testForeachAsync1() {
    assertParsedSource(
      """
      func for_each(r: AsyncRange<Int>, iir: AsyncIntRange<Int>) async {
        var sum = 0
        for await i r {
        }
      }
      """,
      expecting:
        """
        1 │ func for_each(r: AsyncRange<Int>, iir: AsyncIntRange<Int>) async {
        2 │   var sum = 0
        3 │   for await i r {
          │               ╰─ error: expected 'in' in 'for' statement
        4 │   }
        5 │ }

        """
    )

    assertParsedSource(
      """
      func for_each(r: AsyncRange<Int>, iir: AsyncIntRange<Int>) async {
        var sum = 0
        for await i in r sum = sum + i;
      }
      """,
      expecting:
        """
        1 │ func for_each(r: AsyncRange<Int>, iir: AsyncIntRange<Int>) async {
        2 │   var sum = 0
        3 │   for await i in r sum = sum + i;
          │                    │             ╰─ error: expected '}' to end 'for' statement
          │                    ╰─ error: expected '{' in 'for' statement
        4 │ }

        """
    )
  }
}
