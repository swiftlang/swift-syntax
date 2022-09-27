// This test file has been translated from swift/test/Parse/invalid_if_expr.swift

import XCTest

final class InvalidIfExprTests: XCTestCase {
  func testInvalidIfExpr1() {
    AssertParse(
      """
      func unbalanced_question(a: Bool, b: Bool, c: Bool, d: Bool) {
        (a ? b#^DIAG_1^#) 
        (a ? b : c ? d#^DIAG_2^#) 
        (a ? b ? c : d#^DIAG_3^#) 
        (a ? b ? c#^DIAG_4^#) 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected ':' after '? ...' in ternary
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in tuple"),
        // TODO: Old parser expected error on line 3: expected ':' after '? ...' in ternary
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in tuple"),
        // TODO: Old parser expected error on line 4: expected ':' after '? ...' in ternary
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected expression in tuple"),
        // TODO: Old parser expected error on line 5: expected ':' after '? ...' in ternary
        // TODO: Old parser expected error on line 5: expected ':' after '? ...' in ternary
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected expression in tuple"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected expression in tuple"),
      ]
    )
  }

}
