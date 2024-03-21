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

// This test file has been translated from swift/test/Parse/invalid_if_expr.swift

import XCTest

final class InvalidIfExprTests: ParserTestCase {
  func testInvalidIfExpr1() {
    assertParse(
      """
      (a ? b1️⃣)
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' and expression after '? ...' in ternary expression",
          fixIts: ["insert ':' and expression"]
        )
      ],
      fixedSource: "(a ? b : <#expression#>)"
    )
  }

  func testInvalidIfExpr2() {
    assertParse(
      """
      (a ? b : c ? d1️⃣)
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' and expression after '? ...' in ternary expression",
          fixIts: ["insert ':' and expression"]
        )
      ],
      fixedSource: "(a ? b : c ? d : <#expression#>)"
    )
  }

  func testInvalidIfExpr3() {
    assertParse(
      """
      ℹ️(a ? b ? c : d1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' and expression after '? ...' in ternary expression",
          fixIts: ["insert ':' and expression"]
        ),
        DiagnosticSpec(
          message: "expected ')' to end tuple",
          notes: [NoteSpec(message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: "(a ? b ? c : d : <#expression#>)"
    )
  }

  func testInvalidIfExpr4() {
    assertParse(
      """
      (a ? b ? c1️⃣)
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' and expression after '? ...' in ternary expression",
          fixIts: ["insert ':' and expression"]
        ),
        DiagnosticSpec(
          message: "expected ':' and expression after '? ...' in ternary expression",
          fixIts: ["insert ':' and expression"]
        ),
      ],
      fixedSource: "(a ? b ? c : <#expression#> : <#expression#>)"
    )
  }

  func testInvalidIfExpr5() {
    assertParse(
      """
      foo ? 1 1️⃣2
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' after '? ...' in ternary expression", fixIts: ["insert ':'"])
      ],
      fixedSource: "foo ? 1 : 2"
    )
  }

  func testInvalidIfExpr6() {
    assertParse(
      """
      foo ? 1 1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' and expression after '? ...' in ternary expression",
          fixIts: ["insert ':' and expression"]
        )
      ],
      fixedSource: "foo ? 1 : <#expression#>"
    )
  }

  func testInvalidIfExpr7() {
    assertParse(
      """
      condition ? 1 1️⃣
      someOtherVariable
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected ':' and expression after '? ...' in ternary expression",
          fixIts: ["insert ':' and expression"]
        )
      ],
      fixedSource: """
        condition ? 1 : <#expression#>
        someOtherVariable
        """
    )
  }
}
