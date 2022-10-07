// This test file has been translated from swift/test/Parse/invalid_if_expr.swift

import XCTest

final class InvalidIfExprTests: XCTestCase {
  func testInvalidIfExpr1() {
    AssertParse(
      """
      func unbalanced_question(a: Bool, b: Bool, c: Bool, d: Bool) {
        (a ? b1️⃣) 
        (a ? b : c ? d2️⃣) 
        (a ? b ? c : d3️⃣) 
        (a ? b ? c4️⃣) 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected ':' after '? ...' in ternary
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in tuple"),
        // TODO: Old parser expected error on line 3: expected ':' after '? ...' in ternary
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in tuple"),
        // TODO: Old parser expected error on line 4: expected ':' after '? ...' in ternary
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression in tuple"),
        // TODO: Old parser expected error on line 5: expected ':' after '? ...' in ternary
        // TODO: Old parser expected error on line 5: expected ':' after '? ...' in ternary
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected expression in tuple"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected expression in tuple"),
      ]
    )
  }

}
