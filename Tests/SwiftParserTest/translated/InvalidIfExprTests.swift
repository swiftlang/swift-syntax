// This test file has been translated from swift/test/Parse/invalid_if_expr.swift

import XCTest

final class InvalidIfExprTests: XCTestCase {
  func testInvalidIfExpr1() {
    AssertParse(
      """
      (a ? b1️⃣)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression", fixIts: ["insert ':' and expression"]),
      ], fixedSource: "(a ? b: <#expression#>)"
    )
  }

  func testInvalidIfExpr2() {
    AssertParse(
      """
      (a ? b : c ? d1️⃣)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression", fixIts: ["insert ':' and expression"]),
     ], fixedSource: "(a ? b : c ? d: <#expression#>)"
    )
  }

  func testInvalidIfExpr3() {
    AssertParse(
      """
      (a ? b ? c : d1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression", fixIts: ["insert ':' and expression"]),
        DiagnosticSpec(message: "expected ')' to end tuple")
      ], fixedSource: "(a ? b ? c : d: <#expression#>)"
    )
  }

  func testInvalidIfExpr4() {
    AssertParse(
      """
      (a ? b ? c1️⃣)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression", fixIts: ["insert ':' and expression"]),
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression", fixIts: ["insert ':' and expression"]),
      ], fixedSource: "(a ? b ? c: <#expression#>: <#expression#>)"
    )
  }

}
