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

final class BraceRecoveryEofTests: ParserTestCase {
  func testBraceRecoveryEof1() {
    assertParse(
      """
      // Make sure source ranges satisfy the verifier.
      for foo in [1, 2] ℹ️{
        _ = foo1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '}' to end 'for' statement",
          notes: [
            NoteSpec(message: "to match this opening '{'")
          ],
          fixIts: ["insert '}'"]
        )
      ],
      fixedSource: """
        // Make sure source ranges satisfy the verifier.
        for foo in [1, 2] {
          _ = foo
        }
        """
    )
  }
}
