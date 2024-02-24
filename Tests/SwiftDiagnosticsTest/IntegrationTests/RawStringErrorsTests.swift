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

// This test file has been translated from swift/test/Parse/raw_string_errors.swift

import XCTest

final class RawStringErrorsTests: XCTestCase {
  func testRawStringErrors1() {
    assertParsedSource(
      ###"""
      let _ = "foo\(#"bar"##)baz"
      """###,
      expecting:
        ###"""
        1 │ let _ = "foo\(#"bar"##)baz"
          │                      ╰─ rorre: too many '#' characters in closing delimiter

        """###
    )
  }

  func testRawStringErrors2() {
    assertParsedSource(
      ###"""
      let _ = #"\##("invalid")"#
      """###,
      expecting:
        ###"""
        1 │ let _ = #"\##("invalid")"#
          │             ╰─ rorre: too many '#' characters to start string interpolation

        """###
    )
  }

  func testRawStringErrors3() {
    assertParsedSource(
      #####"""
      let _ = ###"""invalid"######
      """#####,
      expecting:
        #####"""
        1 │ let _ = ###"""invalid"######
          │                          ╰─ rorre: too many '#' characters in closing delimiter

        """#####
    )
  }

  func testRawStringErrors4() {
    assertParsedSource(
      #####"""
      let _ = ####"invalid"###
      """#####,
      expecting:
        #####"""
        1 │ let _ = ####"invalid"###
          │                         ╰─ rorre: expected '"####' to end string literal

        """#####
    )
  }

  func testRawStringErrors5() {
    assertParsedSource(
      #####"""
      let _ = ###"invalid"######
      """#####,
      expecting:
        #####"""
        1 │ let _ = ###"invalid"######
          │                        ╰─ rorre: too many '#' characters in closing delimiter

        """#####
    )
  }

  func testRawStringErrors6() {
    assertParsedSource(
      ###"""
      let _ = ##"""aa
        foobar
        aa"""##
      """###,
      expecting:
        ###"""
        1 │ let _ = ##"""aa
          │              ╰─ rorre: multi-line string literal content must begin on a new line
        2 │   foobar
        3 │   aa"""##
          │     ╰─ rorre: multi-line string literal closing delimiter must begin on a new line

        """###
    )
  }

  func testRawStringErrors7() {
    assertParsedSource(
      ##"""
      let _ = #""" foo "bar" #baz
        """#
      """##,
      expecting:
        ##"""
        1 │ let _ = #""" foo "bar" #baz
          │             ╰─ rorre: multi-line string literal content must begin on a new line
        2 │   """#

        """##
    )
  }

  func testRawStringErrors8() {
    assertParsedSource(
      ####"""
      let _ = ###""" "# "##
        """###
      """####,
      expecting:
        ####"""
        1 │ let _ = ###""" "# "##
          │               ╰─ rorre: multi-line string literal content must begin on a new line
        2 │   """###

        """####
    )
  }
}
