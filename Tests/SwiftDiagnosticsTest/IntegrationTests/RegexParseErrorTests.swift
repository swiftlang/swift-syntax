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

// This test file has been translated from swift/test/StringProcessing/Parse/regex_parse_error.swift

import XCTest

final class RegexParseErrorTests: XCTestCase {
  func testRegexParseError1() {
    assertParsedSource(
      #"""
      _ = #/\\/''/
      """#,
      expecting:
        #"""
        1 │ _ = #/\\/''/
          │     │       ╰─ error: expected '#' to end regex literal
          │     ╰─ note: to match this opening '#'

        """#
    )
  }

  func testRegexParseError2() {
    assertParsedSource(
      #"""
      _ = #/\|
      """#,
      expecting:
        #"""
        1 │ _ = #/\|
          │         ╰─ error: expected '/#' to end regex literal

        """#
    )
  }

  func testRegexParseError3() {
    assertParsedSource(
      """
      _ = #//
      """,
      expecting:
        """
        1 │ _ = #//
          │     │  ╰─ error: expected '#' to end regex literal
          │     ╰─ note: to match this opening '#'

        """
    )
  }

  func testRegexParseError4() {
    assertParsedSource(
      """
      _ = #/xy
      """,
      expecting:
        """
        1 │ _ = #/xy
          │         ╰─ error: expected '/#' to end regex literal

        """
    )
  }

  func testRegexParseError5() {
    assertParsedSource(
      """
      do {
        _ = #/(?'a
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   _ = #/(?'a
          │             ╰─ error: expected '/#' to end regex literal
        3 │ }

        """
    )
  }

  func testRegexParseError6() {
    assertParsedSource(
      #"""
      do {
        _ = /\
        /
      }
      """#,
      expecting:
        #"""
        1 │ do {
        2 │   _ = /\
          │         ╰─ error: expected root in key path
        3 │   /
          │    ╰─ error: expected expression after operator
        4 │ }

        """#
    )
  }

  func testRegexParseError7() {
    assertParsedSource(
      #"""
      do {
        _ = #/\
      /#
      }
      """#,
      expecting:
        #"""
        1 │ do {
        2 │   _ = #/\
          │          ╰─ error: expected '/#' to end regex literal
        3 │ /#
          │   ╰─ error: expected identifier in macro expansion
        4 │ }

        """#
    )
  }
}
