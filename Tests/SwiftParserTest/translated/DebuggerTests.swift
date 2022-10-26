//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/debugger.swift

import XCTest

final class DebuggerTests: XCTestCase {
  func testDebugger1() {
    AssertParse(
      """
      import Nonexistent_Module
      """
    )
  }

  func testDebugger2() {
    AssertParse(
      """
      var ($x0, $x1) = (4, 3)
      var z = $x0 + $x1
      """
    )
  }

  func testDebugger3() {
    AssertParse(
      """
      z // no error.
      """
    )
  }

  func testDebugger4() {
    AssertParse(
      """
      var x: Double = z
      """
    )
  }

}
