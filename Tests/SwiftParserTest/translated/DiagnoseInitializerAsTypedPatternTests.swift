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

// This test file has been translated from swift/test/Parse/diagnose_initializer_as_typed_pattern.swift

import XCTest

// https://github.com/apple/swift/issues/44070
final class DiagnoseInitializerAsTypedPatternTests: ParserTestCase {
  func testDiagnoseInitializerAsTypedPattern3a() {
    assertParse(
      """
      let a1️⃣:[X]()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: "let a = [X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern3b() {
    assertParse(
      """
      let b1️⃣: [X]()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: "let b = [X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern3c() {
    assertParse(
      """
      let c 1️⃣:[X]()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: "let c = [X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern3d() {
    assertParse(
      """
      let d 1️⃣: [X]()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: "let d = [X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern4() {
    assertParse(
      """
      let e1️⃣: X(), ee: Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: "let e = X(), ee: Int"
    )
  }

  func testDiagnoseInitializerAsTypedPattern5a() {
    assertParse(
      """
      let f1️⃣:/*comment*/[X]()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: "let f =/*comment*/[X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern5b() {
    assertParse(
      """
      let f/*comment*/1️⃣:[X]()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: "let f/*comment*/ = [X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern6() {
    assertParse(
      """
      var _1 = 1, _2 = 2
      """
    )
  }

  func testDiagnoseInitializerAsTypedPattern7() {
    // paren follows the type, but it's part of a separate (valid) expression
    assertParse(
      """
      let ff: X
      (_1, _2) = (_2, _1)
      let fff: X
       (_1, _2) = (_2, _1)
      """
    )
  }

  func testDiagnoseInitializerAsTypedPattern8a() {
    assertParse(
      """
      let g1️⃣: X(x)
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        let g = X(x)
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern8b() {
    assertParse(
      """
      let h1️⃣: X(x, y)
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        let h = X(x, y)
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern8c() {
    assertParse(
      """
      let i1️⃣: X() { foo() }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        let i = X() { foo() }
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern8d() {
    assertParse(
      """
      let j1️⃣: X(x) { foo() }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        let j = X(x) { foo() }
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern8e() {
    assertParse(
      """
      let k1️⃣: X(x, y) { foo() }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        let k = X(x, y) { foo() }
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern9a() {
    assertParse(
      """
      func nonTopLevel() {
        let a1️⃣:[X]()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        func nonTopLevel() {
          let a = [X]()
        }
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern9b() {
    assertParse(
      """
      func nonTopLevel() {
        let i1️⃣: X() { foo() }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        func nonTopLevel() {
          let i = X() { foo() }
        }
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern9c() {
    assertParse(
      """
      func nonTopLevel() {
        let j1️⃣: X(x) { foo() }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        func nonTopLevel() {
          let j = X(x) { foo() }
        }
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern9d() {
    assertParse(
      """
      func nonTopLevel() {
        let k1️⃣: X(x, y) { foo() }
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected initializer in pattern; did you mean to use '='?",
          fixIts: ["replace ':' with '='"]
        )
      ],
      fixedSource: """
        func nonTopLevel() {
          let k = X(x, y) { foo() }
        }
        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern9e() {
    assertParse(
      """
      func nonTopLevel() {
        _ = (a, i, j, k)
      }
      """
    )
  }

}
