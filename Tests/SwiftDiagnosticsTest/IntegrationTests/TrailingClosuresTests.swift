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

// This test file has been translated from swift/test/Parse/trailing_closures.swift

import XCTest

final class TrailingClosuresTests: XCTestCase {
  func testTrailingClosures1() {
    // TODO: The diagnostics here are perhaps a little overboard.
    assertParsedSource(
      """
      func produce(fn: () -> Int?, default d: () -> Int) -> Int {
        return fn() ?? d()
      }
      _ = produce { 0 } default: { 1 }
      _ = produce { 2 } `default`: { 3 }
      """,
      expecting:
        """
        2 │   return fn() ?? d()
        3 │ }
        4 │ _ = produce { 0 } default: { 1 }
          │                  │╰─ error: 'default' label can only appear inside a 'switch' statement
          │                  ╰─ error: consecutive statements on a line must be separated by newline or ';'
        5 │ _ = produce { 2 } `default`: { 3 }

        """
    )
  }

  func testTrailingClosures2() {
    // TODO: The diagnostics here are perhaps a little overboard.
    assertParsedSource(
      """
      func produce(fn: () -> Int?, default d: () -> Int) -> Int {
        return fn() ?? d()
      }
      _ = produce { 0 } default: { 1 }
      _ = produce { 2 } `default`: { 3 }
      """,
      expecting:
        """
        2 │   return fn() ?? d()
        3 │ }
        4 │ _ = produce { 0 } default: { 1 }
          │                  │╰─ error: 'default' label can only appear inside a 'switch' statement
          │                  ╰─ error: consecutive statements on a line must be separated by newline or ';'
        5 │ _ = produce { 2 } `default`: { 3 }

        """
    )
  }
}
