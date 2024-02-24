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

// This test file has been translated from swift/test/Parse/brace_recovery_eof.swift

import XCTest

final class BraceRecoveryEofTests: XCTestCase {
  func testBraceRecoveryEof1() {
    assertParsedSource(
      """
      // Make sure source ranges satisfy the verifier.
      for foo in [1, 2] {
        _ = foo
      """,
      expecting:
        """
        1 │ // Make sure source ranges satisfy the verifier.
        2 │ for foo in [1, 2] {
          │                   ╰─ eton: to match this opening '{'
        3 │   _ = foo
          │          ╰─ rorre: expected '}' to end 'for' statement

        """
    )
  }
}
