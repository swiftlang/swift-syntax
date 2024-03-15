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

// This test file has been translated from swift/test/Parse/pound_assert.swift

import XCTest

final class PoundAssertTests: ParserTestCase {
  func testPoundAssert1() {
    assertParse(
      """
      #assert(true, 1️⃣123)
      """
    )
  }

  func testPoundAssert2() {
    assertParse(
      #"""
      #assert(true, "error \(1) message")
      """#
    )
  }

  func testPoundAssert3a() {
    assertParse(
      #"""
      #assert1️⃣ true2️⃣, "error message")
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"extraneous code ', "error message")' at top level"#),
      ],
      applyFixIts: ["insert newline"],
      fixedSource: #"""
        #assert
        true, "error message")
        """#
    )
  }

  func testPoundAssert3b() {
    assertParse(
      #"""
      #assert1️⃣ true2️⃣, "error message")
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"extraneous code ', "error message")' at top level"#),
      ],
      applyFixIts: ["insert ';'"],
      fixedSource: #"""
        #assert; true, "error message")
        """#
    )
  }

  func testPoundAssert4() {
    assertParse(
      #"""
      #assert(1️⃣, "error message")
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected value in macro expansion", fixIts: ["insert value"])
      ],
      fixedSource: #"""
        #assert(<#expression#>, "error message")
        """#
    )
  }

  func testPoundAssert5() {
    assertParse(
      """
      func unbalanced1() {
        #assertℹ️(true1️⃣ 
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end macro expansion",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ],
          fixIts: ["insert ')'"]
        )
      ],
      fixedSource: """
        func unbalanced1() {
          #assert(true)
        }
        """
    )
  }

  func testPoundAssert6() {
    assertParse(
      #"""
      func unbalanced2() {
        #assertℹ️(true, "hello world"1️⃣ 
      }
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end macro expansion",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ],
          fixIts: ["insert ')'"]
        )
      ],
      fixedSource: #"""
        func unbalanced2() {
          #assert(true, "hello world")
        }
        """#
    )
  }
}
