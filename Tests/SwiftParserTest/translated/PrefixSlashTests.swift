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

// This test file has been translated from swift/test/StringProcessing/Parse/prefix-slash.swift

import XCTest

final class PrefixSlashTests: ParserTestCase {
  func testPrefixSlash2() {
    assertParse(
      """
      prefix operator /
      prefix func / <T> (_ x: T) -> T { x }
      """
    )
  }

  func testPrefixSlash4() {
    assertParse(
      """
      _ = /E.e
      (/E.e).foo(/0)
      """
    )
  }

  func testPrefixSlash6() {
    assertParse(
      """
      foo(/E.e, /E.e)
      foo((/E.e), /E.e)
      foo((/)(E.e), /E.e)
      """
    )
  }

  func testPrefixSlash8() {
    assertParse(
      """
      _ = bar(/E.e) / 2
      """
    )
  }
}
