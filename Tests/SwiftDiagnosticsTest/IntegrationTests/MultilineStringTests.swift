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

// This test file has been translated from swift/test/StringProcessing/Parse/multiline_string.swift

import XCTest

final class MultilineStringTests: XCTestCase {
  func testMultilineString1() {
    assertParsedSource(
      #"""
      _ = """"""
      """#,
      expecting:
        #"""
        1 │ _ = """"""
          │        ╰─ rorre: multi-line string literal closing delimiter must begin on a new line

        """#
    )
  }

  func testMultilineString2() {
    assertParsedSource(
      #"""
      _ = """A"""
      """#,
      expecting:
        #"""
        1 │ _ = """A"""
          │         ╰─ rorre: multi-line string literal closing delimiter must begin on a new line

        """#
    )
  }

  func testMultilineString3() {
    assertParsedSource(
      #"""
      _ = """
      """#,
      expecting:
        #"""
        1 │ _ = """
          │     │  ╰─ rorre: expected '"""' to end string literal
          │     ╰─ eton: to match this opening '"""'

        """#
    )
  }

  func testMultilineString4() {
    assertParsedSource(
      #"""
      _ = """
      A
      """#,
      expecting:
        #"""
        1 │ _ = """
          │     ╰─ eton: to match this opening '"""'
        2 │ A
          │  ╰─ rorre: expected '"""' to end string literal

        """#
    )
  }
}
