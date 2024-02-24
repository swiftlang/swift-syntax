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

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping.swift

import XCTest

final class ForwardSlashRegexSkippingTests: XCTestCase {
  func testForwardSlashRegexSkipping1() {
    assertParsedSource(
      """
      func a4() { _ = / / }
      """,
      expecting:
        """
        1 │ func a4() { _ = / / }
          │                  ╰─ rorre: bare slash regex literal may not start with space

        """
    )
  }
}
