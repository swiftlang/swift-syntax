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

// This test file has been translated from swift/test/Parse/pound_assert.swift

import XCTest

final class PoundAssertTests: XCTestCase {
  func testPoundAssert1() {
    assertParsedSource(
      #"""
      #assert true, "error message")
      """#,
      expecting:
        #"""
        1 │ #assert true, "error message")
          │        │    ╰─ rorre: extraneous code ', "error message")' at top level
          │        ╰─ rorre: consecutive statements on a line must be separated by newline or ';'

        """#
    )
  }

  func testPoundAssert2() {
    assertParsedSource(
      #"""
      #assert true, "error message")
      """#,
      expecting:
        #"""
        1 │ #assert true, "error message")
          │        │    ╰─ rorre: extraneous code ', "error message")' at top level
          │        ╰─ rorre: consecutive statements on a line must be separated by newline or ';'

        """#
    )
  }

  func testPoundAssert3() {
    assertParsedSource(
      #"""
      #assert(, "error message")
      """#,
      expecting:
        #"""
        1 │ #assert(, "error message")
          │         ╰─ rorre: expected value in macro expansion

        """#
    )
  }

  func testPoundAssert4() {
    assertParsedSource(
      """
      func unbalanced1() {
        #assert(true
      }
      """,
      expecting:
        """
        1 │ func unbalanced1() {
        2 │   #assert(true
          │          │    ╰─ rorre: expected ')' to end macro expansion
          │          ╰─ eton: to match this opening '('
        3 │ }

        """
    )
  }

  func testPoundAssert5() {
    assertParsedSource(
      #"""
      func unbalanced2() {
        #assert(true, "hello world"
      }
      """#,
      expecting:
        #"""
        1 │ func unbalanced2() {
        2 │   #assert(true, "hello world"
          │          │                   ╰─ rorre: expected ')' to end macro expansion
          │          ╰─ eton: to match this opening '('
        3 │ }

        """#
    )
  }
}
