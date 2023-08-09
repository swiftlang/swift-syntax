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

// This test file has been translated from swift/test/Parse/switch_incomplete.swift

import XCTest

final class SwitchIncompleteTests: ParserTestCase {
  func testSwitchIncomplete1() {
    // <rdar://problem/15971438> Incomplete switch was parsing to an AST that
    // triggered an assertion failure.
    assertParse(
      """
      switch 1 ℹ️{
      case 1:1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '}' to end 'switch' statement",
          notes: [
            NoteSpec(message: "to match this opening '{'")
          ],
          fixIts: ["insert '}'"]
        )
      ],
      fixedSource: """
        switch 1 {
        case 1:
        }
        """
    )
  }
}
