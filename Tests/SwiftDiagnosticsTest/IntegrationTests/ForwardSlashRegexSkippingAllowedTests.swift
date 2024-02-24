//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping-allowed.swift

import XCTest

final class ForwardSlashRegexSkippingAllowedTests: XCTestCase {
  func testForwardSlashRegexSkippingAllowed1() {
    // Ensures there is a parse error
    assertParsedSource(
      """
      var : Int
      """,
      expecting:
        """
        1 │ var : Int
          │     ╰─ rorre: expected pattern in variable

        """
    )
  }

  func testForwardSlashRegexSkippingAllowed2() {
    // Balanced `{}`, so okay.
    assertParsedSource(
      """
      func a() { / {}/ }
      """,
      expecting:
        """
        1 │ func a() { / {}/ }
          │             ╰─ rorre: bare slash regex literal may not start with space

        """
    )
  }

  func testForwardSlashRegexSkippingAllowed3() {
    assertParsedSource(
      #"""
      func b() { / \{}/ }
      """#,
      expecting:
        #"""
        1 │ func b() { / \{}/ }
          │             ╰─ rorre: bare slash regex literal may not start with space

        """#
    )
  }

  func testForwardSlashRegexSkippingAllowed4() {
    assertParsedSource(
      #"""
      func c() { / {"{"}/ }
      """#,
      expecting:
        #"""
        1 │ func c() { / {"{"}/ }
          │             ╰─ rorre: bare slash regex literal may not start with space

        """#
    )
  }
}
