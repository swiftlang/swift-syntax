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

// This test file has been translated from swift/test/StringProcessing/Parse/regex.swift

import XCTest

final class RegexTests: ParserTestCase {
  func testRegex1() {
    assertParse(
      """
      _ = /abc/
      _ = #/abc/#
      _ = ##/abc/##
      """
    )
  }

  func testRegex3() {
    assertParse(
      """
      foo(/abc/, #/abc/#, ##/abc/##)
      """
    )
  }

  func testRegex4() {
    assertParse(
      """
      let arr = [/abc/, #/abc/#, ##/abc/##]
      """
    )
  }

  func testRegex5() {
    assertParse(
      #"""
      _ = /\w+/.self
      _ = #/\w+/#.self
      _ = ##/\w+/##.self
      """#
    )
  }

  func testRegex6() {
    assertParse(
      ##"""
      _ = /#\/\#\\/
      _ = #/#/\/\#\\/#
      _ = ##/#|\|\#\\/##
      """##
    )
  }

  func testRegex7() {
    assertParse(
      """
      _ = (#/[*/#, #/+]/#, #/.]/#)
      """
    )
  }

}
