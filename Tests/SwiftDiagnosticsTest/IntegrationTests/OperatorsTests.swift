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

// This test file has been translated from swift/test/Parse/operators.swift

import XCTest

final class OperatorsTests: XCTestCase {
  func testOperators1() {
    assertParsedSource(
      """
      foo!!foo
      """,
      expecting:
        """
        1 │ foo!!foo
          │      ╰─ error: consecutive statements on a line must be separated by newline or ';'

        """
    )
  }

  func testOperators2() {
    assertParsedSource(
      """
      foo!!foo
      """,
      expecting:
        """
        1 │ foo!!foo
          │      ╰─ error: consecutive statements on a line must be separated by newline or ';'

        """
    )
  }

  func testOperators3() {
    assertParsedSource(
      """
      foo??bar
      """,
      expecting:
        """
        1 │ foo??bar
          │      ╰─ error: consecutive statements on a line must be separated by newline or ';'

        """
    )
  }

  func testOperators4() {
    assertParsedSource(
      """
      foo??bar
      """,
      expecting:
        """
        1 │ foo??bar
          │      ╰─ error: consecutive statements on a line must be separated by newline or ';'

        """
    )
  }
}
