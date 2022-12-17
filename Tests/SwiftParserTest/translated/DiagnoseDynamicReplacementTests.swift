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

// This test file has been translated from swift/test/Parse/diagnose_dynamicReplacement.swift

import XCTest

final class DiagnoseDynamicReplacementTests: XCTestCase {
  func testDiagnoseDynamicReplacement1() {
    AssertParse(
      """
      dynamic func dynamic_replaceable() {
      }
      """
    )
  }

  func testDiagnoseDynamicReplacement2() {
    AssertParse(
      """
      @_dynamicReplacement1️⃣
      func test_dynamic_replacement_for() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '(', attribute argument, and ')' in attribute")
      ]
    )
  }

  func testDiagnoseDynamicReplacement3() {
    AssertParse(
      """
      @_dynamicReplacement(1️⃣
      func test_dynamic_replacement_for2() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected argument for '@_dynamicReplacement' attribute"),
        DiagnosticSpec(message: "expected ')' to end attribute"),
      ]
    )
  }

  func testDiagnoseDynamicReplacement4() {
    AssertParse(
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
          ]
        )
      ]
    )
  }

}
