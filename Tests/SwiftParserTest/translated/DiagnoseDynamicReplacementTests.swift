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
      @_dynamicReplacement#^DIAG^#
      func test_dynamic_replacement_for() {
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '(' in '_dynamicReplacement' attribute
        DiagnosticSpec(message: "expected '(' in attribute"),
        DiagnosticSpec(message: "expected argument for '@_dynamicReplacement' attribute"),
        DiagnosticSpec(message: "expected ')' to end attribute"),
      ]
    )
  }

  func testDiagnoseDynamicReplacement3() {
    AssertParse(
      """
      @_dynamicReplacement(#^DIAG^#
      func test_dynamic_replacement_for2() {
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected 'for' in '_dynamicReplacement' attribute
        DiagnosticSpec(message: "expected argument for '@_dynamicReplacement' attribute"),
        DiagnosticSpec(message: "expected ')' to end attribute"),
      ]
    )
  }

  func testDiagnoseDynamicReplacement4() {
    AssertParse(
      """
      @_dynamicReplacement(for: dynamically_replaceable() #^DIAG^#
      func test_dynamic_replacement_for3() {
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: to match this opening '('
        DiagnosticSpec(message: "expected ')' to end attribute"),
        // TODO: Old parser expected error on line 2: expected ')' after function name for @_dynamicReplacement
      ]
    )
  }

}
