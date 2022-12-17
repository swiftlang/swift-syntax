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

// This test file has been translated from swift/test/Parse/diagnose_initializer_as_typed_pattern.swift

import XCTest

// https://github.com/apple/swift/issues/44070
final class DiagnoseInitializerAsTypedPatternTests: XCTestCase {
  func testDiagnoseInitializerAsTypedPattern3a() {
    AssertParse(
      """
      let a1️⃣:[X]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ],
      fixedSource: "let a=[X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern3b() {
    AssertParse(
      """
      let b1️⃣: [X]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ],
      fixedSource: "let b= [X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern3c() {
    AssertParse(
      """
      let c 1️⃣:[X]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ],
      fixedSource: "let c =[X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern3d() {
    AssertParse(
      """
      let d 1️⃣: [X]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ],
      fixedSource: "let d = [X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern4() {
    AssertParse(
      """
      let e1️⃣: X(), ee: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?")
      ],
      fixedSource: "let e= X(), ee: Int"
    )
  }

  func testDiagnoseInitializerAsTypedPattern5a() {
    AssertParse(
      """
      let f1️⃣:/*comment*/[X]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ],
      fixedSource: "let f=/*comment*/[X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern5b() {
    AssertParse(
      """
      let f/*comment*/1️⃣:[X]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ],
      fixedSource: "let f/*comment*/=[X]()"
    )
  }

  func testDiagnoseInitializerAsTypedPattern6() {
    AssertParse(
      """
      var _1 = 1, _2 = 2
      """
    )
  }

  func testDiagnoseInitializerAsTypedPattern7() {
    // paren follows the type, but it's part of a separate (valid) expression
    AssertParse(
      """
      let ff: X
      (_1, _2) = (_2, _1)
      let fff: X
       (_1, _2) = (_2, _1)
      """
    )
  }

  func testDiagnoseInitializerAsTypedPattern8a() {
    AssertParse(
      """
      let g1️⃣: X(x)
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern8b() {
    AssertParse(
      """
      let h1️⃣: X(x, y)
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern8c() {
    AssertParse(
      """
      let i1️⃣: X() { foo() }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern8d() {
    AssertParse(
      """
      let j1️⃣: X(x) { foo() }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern8e() {
    AssertParse(
      """
      let k1️⃣: X(x, y) { foo() }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern9a() {
    AssertParse(
      """
      func nonTopLevel() {
        let a1️⃣:[X]()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern9b() {
    AssertParse(
      """
      func nonTopLevel() {
        let i1️⃣: X() { foo() }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern9c() {
    AssertParse(
      """
      func nonTopLevel() {
        let j1️⃣: X(x) { foo() }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern9d() {
    AssertParse(
      """
      func nonTopLevel() {
        let k1️⃣: X(x, y) { foo() }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected initializer in pattern; did you mean to use '='?", fixIts: ["replace ':' by '='"])
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern9e() {
    AssertParse(
      """
      func nonTopLevel() {
        _ = (a, i, j, k)
      }
      """
    )
  }

}
