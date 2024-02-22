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

// This test file has been translated from swift/test/Parse/string_literal_eof1.swift

import XCTest

final class StringLiteralEofTests: XCTestCase {
  func testStringLiteralEof1() {
    assertParsedSource(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = "foo\(
      """##,
      expecting:
        ##"""
        1 │ // NOTE: DO NOT add a newline at EOF.
        2 │ _ = "foo\(
          │     │     ├─ error: expected value and ')' in string literal
          │     │     ╰─ error: expected '"' to end string literal
          │     ╰─ note: to match this opening '"'

        """##
    )
  }

  func testStringLiteralEof2() {
    assertParsedSource(
      // NOTE: DO NOT add a newline at EOF.
      ##"""
      _ = "foo\("bar
      """##,
      expecting:
        ##"""
        1 │ _ = "foo\("bar
          │     │    ││   ├─ error: expected '"' to end string literal
          │     │    ││   ├─ error: expected ')' in string literal
          │     │    ││   ╰─ error: expected '"' to end string literal
          │     │    │╰─ note: to match this opening '"'
          │     │    ╰─ note: to match this opening '('
          │     ╰─ note: to match this opening '"'

        """##
    )
  }

  func testStringLiteralEof3() {
    assertParsedSource(
      ##"""
      _ = "foo \
      """##,
      expecting:
        ##"""
        1 │ _ = "foo \
          │     │    │╰─ error: expected '"' to end string literal
          │     │    ╰─ error: invalid escape sequence in literal
          │     ╰─ note: to match this opening '"'

        """##
    )
  }

  func testStringLiteralEof4() {
    assertParsedSource(
      ##"""
      // NOTE: DO NOT add a newline at EOF.
      _ = "foo \
      """##,
      expecting:
        ##"""
        1 │ // NOTE: DO NOT add a newline at EOF.
        2 │ _ = "foo \
          │     │    │╰─ error: expected '"' to end string literal
          │     │    ╰─ error: invalid escape sequence in literal
          │     ╰─ note: to match this opening '"'

        """##
    )
  }

  func testStringLiteralEof5() {
    assertParsedSource(
      #"""
      // NOTE: DO NOT add a newline at EOF.
      _ = """
          foo
      """#,
      expecting:
        #"""
        1 │ // NOTE: DO NOT add a newline at EOF.
        2 │ _ = """
          │     ╰─ note: to match this opening '"""'
        3 │     foo
          │        ╰─ error: expected '"""' to end string literal

        """#
    )
  }

  func testStringLiteralEof6() {
    // NOTE: DO NOT add a newline at EOF.
    assertParsedSource(
      ##"""
      _ = """
          foo
          \(
      """##,
      expecting:
        ##"""
        1 │ _ = """
          │     ╰─ note: to match this opening '"""'
        2 │     foo
        3 │     \(
          │       ├─ error: expected value and ')' in string literal
          │       ╰─ error: expected '"""' to end string literal

        """##
    )
  }

  func testStringLiteralEof7() {
    // NOTE: DO NOT add a newline at EOF.
    assertParsedSource(
      ##"""
      _ = """
          foo
          \("bar
      """##,
      expecting:
        ##"""
        1 │ _ = """
          │     ╰─ note: to match this opening '"""'
        2 │     foo
        3 │     \("bar
          │      ││   ├─ error: expected '"' to end string literal
          │      ││   ├─ error: expected ')' in string literal
          │      ││   ╰─ error: expected '"""' to end string literal
          │      │╰─ note: to match this opening '"'
          │      ╰─ note: to match this opening '('

        """##
    )
  }

  func testStringLiteralEof8() {
    assertParsedSource(
      ##"""
      _ = """
          \("bar
          baz
      """##,
      expecting:
        ##"""
        1 │ _ = """
          │     ╰─ note: to match this opening '"""'
        2 │     \("bar
          │      ││   ╰─ error: expected '"' to end string literal
          │      │╰─ note: to match this opening '"'
          │      ╰─ note: to match this opening '('
        3 │     baz
          │     │  ├─ error: expected ')' in string literal
          │     │  ╰─ error: expected '"""' to end string literal
          │     ╰─ error: unexpected code 'baz' in string literal

        """##
    )
  }
}
