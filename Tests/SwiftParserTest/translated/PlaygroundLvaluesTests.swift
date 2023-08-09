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

// This test file has been translated from swift/test/Parse/playground_lvalues.swift

import XCTest

final class PlaygroundLvaluesTests: ParserTestCase {
  func testPlaygroundLvalues1() {
    assertParse(
      """
      var a = 1, b = 2
      let z = 3
      """
    )
  }

  func testPlaygroundLvalues2() {
    assertParse(
      """
      a
      (a, b)
      (a, z)
      """
    )
  }

}
