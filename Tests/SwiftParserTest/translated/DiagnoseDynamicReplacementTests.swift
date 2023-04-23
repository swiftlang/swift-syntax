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

// This test file has been translated from swift/test/Parse/diagnose_dynamicReplacement.swift

import XCTest

final class DiagnoseDynamicReplacementTests: XCTestCase {
  func testDiagnoseDynamicReplacement1() {
    assertParse(
      """
      dynamic func dynamic_replaceable() {
      }
      """
    )
  }

  func testDiagnoseDynamicReplacement2() {
    assertParse(
      """
      @_dynamicReplacement1️⃣
      func test_dynamic_replacement_for() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '(', @_dynamicReplacement argument, and ')' in attribute", fixIts: ["insert '(', @_dynamicReplacement argument, and ')'"])
      ]
    )
  }

  func testDiagnoseDynamicReplacement3() {
    assertParse(
      """
      @_dynamicReplacement(1️⃣
      func test_dynamic_replacement_for2() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected argument for '@_dynamicReplacement' attribute", fixIts: ["insert attribute argument"]),
        DiagnosticSpec(message: "expected ')' to end attribute", fixIts: ["insert ')'"]),
      ]
    )
  }

  func testDiagnoseDynamicReplacement4() {
    assertParse(
      """
      @_dynamicReplacementℹ️(for: dynamically_replaceable() 1️⃣
      func test_dynamic_replacement_for3() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ')' to end attribute",
          notes: [
            NoteSpec(message: "to match this opening '('")
          ],
          fixIts: ["insert ')'"]
        )
      ],
      fixedSource: """
        @_dynamicReplacement(for: dynamically_replaceable())
        func test_dynamic_replacement_for3() {
        }
        """
    )
  }
}
