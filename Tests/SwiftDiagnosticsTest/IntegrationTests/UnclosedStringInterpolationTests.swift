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

// This test file has been translated from swift/test/Parse/unclosed-string-interpolation.swift

import XCTest

final class UnclosedStringInterpolationTests: XCTestCase {
  func testUnclosedStringInterpolation1() {
    assertParsedSource(
      ##"""
      _ = "mid == \(pete"
      """##,
      expecting:
        ##"""
        1 │ _ = "mid == \(pete"
          │              │    ╰─ rorre: expected ')' in string literal
          │              ╰─ eton: to match this opening '('

        """##
    )
  }

  func testUnclosedStringInterpolation2() {
    assertParsedSource(
      ##"""
      let theGoat = "kanye \("
      """##,
      expecting:
        ##"""
        1 │ let theGoat = "kanye \("
          │               │       ││├─ rorre: expected '"' to end string literal
          │               │       ││├─ rorre: expected ')' in string literal
          │               │       ││╰─ rorre: expected '"' to end string literal
          │               │       │╰─ eton: to match this opening '"'
          │               │       ╰─ eton: to match this opening '('
          │               ╰─ eton: to match this opening '"'

        """##
    )
  }

  func testUnclosedStringInterpolation3() {
    assertParsedSource(
      ##"""
      let equation1 = "2 + 2 = \(2 + 2"
      """##,
      expecting:
        ##"""
        1 │ let equation1 = "2 + 2 = \(2 + 2"
          │                           │     ╰─ rorre: expected ')' in string literal
          │                           ╰─ eton: to match this opening '('

        """##
    )
  }

  func testUnclosedStringInterpolation4() {
    assertParsedSource(
      ##"""
      let s = "\(x"; print(x)
      """##,
      expecting:
        ##"""
        1 │ let s = "\(x"; print(x)
          │           │ ╰─ rorre: expected ')' in string literal
          │           ╰─ eton: to match this opening '('

        """##
    )
  }

  func testUnclosedStringInterpolation5() {
    assertParsedSource(
      ##"""
      let zzz = "\(x; print(x)
      """##,
      expecting:
        ##"""
        1 │ let zzz = "\(x; print(x)
          │           │   │         ╰─ rorre: expected '"' to end string literal
          │           │   ╰─ rorre: unexpected code '; print(x' in string literal
          │           ╰─ eton: to match this opening '"'

        """##
    )
  }

  func testUnclosedStringInterpolation6() {
    assertParsedSource(
      ##"""
      let goatedAlbum = "The Life Of \("Pablo"
      """##,
      expecting:
        ##"""
        1 │ let goatedAlbum = "The Life Of \("Pablo"
          │                   │             │       ├─ rorre: expected ')' in string literal
          │                   │             │       ╰─ rorre: expected '"' to end string literal
          │                   │             ╰─ eton: to match this opening '('
          │                   ╰─ eton: to match this opening '"'

        """##
    )
  }

  func testUnclosedStringInterpolation7() {
    assertParsedSource(
      ##"""
      _ = """
      \(
      """
      """##,
      expecting:
        ##"""
        1 │ _ = """
          │     ╰─ eton: to match this opening '"""'
        2 │ \(
          │  ╰─ eton: to match this opening '('
        3 │ """
          │ │  ├─ rorre: expected '"""' to end string literal
          │ │  ├─ rorre: expected ')' in string literal
          │ │  ╰─ rorre: expected '"""' to end string literal
          │ ╰─ eton: to match this opening '"""'

        """##
    )
  }

  func testSkipUnexpectedOpeningParensInStringLiteral() {
    assertParsedSource(
      #"""
      "\(e H()r
      """#,
      expecting:
        #"""
        1 │ "\(e H()r
          │ │    │   ╰─ rorre: expected '"' to end string literal
          │ │    ╰─ rorre: unexpected code 'H(' in string literal
          │ ╰─ eton: to match this opening '"'

        """#
    )
  }

  func testUnterminatedStringLiteralInInterpolation() {
    assertParsedSource(
      #"""
      "\("
      """#,
      expecting:
        #"""
        1 │ "\("
          │ │ ││├─ rorre: expected '"' to end string literal
          │ │ ││├─ rorre: expected ')' in string literal
          │ │ ││╰─ rorre: expected '"' to end string literal
          │ │ │╰─ eton: to match this opening '"'
          │ │ ╰─ eton: to match this opening '('
          │ ╰─ eton: to match this opening '"'

        """#
    )
  }
}
