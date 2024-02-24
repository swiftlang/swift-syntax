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
    assertParsedSource(
      """
      @_dynamicReplacement
      func test_dynamic_replacement_for() {
      }
      """,
      expecting:
        """
        1 │ @_dynamicReplacement
          │                     ╰─ rorre: expected '(', @_dynamicReplacement argument, and ')' in attribute
        2 │ func test_dynamic_replacement_for() {
        3 │ }

        """
    )
  }

  func testDiagnoseDynamicReplacement2() {
    assertParsedSource(
      """
      @_dynamicReplacement(
      func test_dynamic_replacement_for1() {
      }
      """,
      expecting:
        """
        1 │ @_dynamicReplacement(
          │                     │├─ rorre: expected argument for '@_dynamicReplacement' attribute
          │                     │╰─ rorre: expected ')' to end attribute
          │                     ╰─ eton: to match this opening '('
        2 │ func test_dynamic_replacement_for1() {
        3 │ }

        """
    )
  }

  func testDiagnoseDynamicReplacement3() {
    assertParsedSource(
      """
      @_dynamicReplacement(for: dynamically_replaceable()
      func test_dynamic_replacement_for2() {
      }
      """,
      expecting:
        """
        1 │ @_dynamicReplacement(for: dynamically_replaceable()
          │                     │                              ╰─ rorre: expected ')' to end attribute
          │                     ╰─ eton: to match this opening '('
        2 │ func test_dynamic_replacement_for2() {
        3 │ }

        """
    )
  }
}
