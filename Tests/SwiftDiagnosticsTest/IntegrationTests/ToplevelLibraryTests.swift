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

// This test file has been translated from swift/test/Parse/toplevel_library.swift

import XCTest

final class ToplevelLibraryTests: XCTestCase {
  func testToplevelLibraryInvalid1() {
    assertParsedSource(
      """
      for i
      """,
      expecting:
        """
        1 │ for i
          │      ╰─ rorre: expected 'in', expression, and body in 'for' statement

        """
    )
  }
}
