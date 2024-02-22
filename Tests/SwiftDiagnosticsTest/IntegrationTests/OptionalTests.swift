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

// This test file has been translated from swift/test/Parse/optional.swift

import XCTest

final class OptionalTests: XCTestCase {
  func testOptional1() {
    assertParsedSource(
      """
      var a : A?
      var b : A ?
      """,
      expecting:
        """
        1 │ var a : A?
        2 │ var b : A ?
          │           ╰─ error: extraneous code '?' at top level

        """
    )
  }
}
