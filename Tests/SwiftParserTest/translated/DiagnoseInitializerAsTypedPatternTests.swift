// This test file has been translated from swift/test/Parse/diagnose_initializer_as_typed_pattern.swift

import XCTest

final class DiagnoseInitializerAsTypedPatternTests: XCTestCase {
  func testDiagnoseInitializerAsTypedPattern1() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/44070
      """
    )
  }

  func testDiagnoseInitializerAsTypedPattern2() {
    AssertParse(
      """
      class X {}
      func foo() {}
      """
    )
  }

  func testDiagnoseInitializerAsTypedPattern3() {
    AssertParse(
      """
      let a:[X]1️⃣()
      let b: [X]2️⃣()
      let c :[X]3️⃣()
      let d : [X]4️⃣()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' = '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 7 - 8 = '= '
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 7 - 8 = '='
        DiagnosticSpec(locationMarker: "4️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern4() {
    AssertParse(
      """
      let e: X1️⃣()2️⃣, ee: Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous ', ee: Int' at top level"),
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern5() {
    AssertParse(
      """
      let f:/*comment*/[X]1️⃣()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' = '
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
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
    AssertParse(
      """
      // paren follows the type, but it's part of a separate (valid) expression
      let ff: X
      (_1, _2) = (_2, _1)
      let fff: X
       (_1, _2) = (_2, _1)
      """
    )
  }

  func testDiagnoseInitializerAsTypedPattern8() {
    AssertParse(
      """
      let g: X1️⃣(x)
      let h: X2️⃣(x, y)
      let i: X3️⃣() { foo() }
      let j: X4️⃣(x) { foo() }
      let k: X5️⃣(x, y) { foo() }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "4️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 5: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "5️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern9() {
    AssertParse(
      """
      func nonTopLevel() {
        let a:[X]1️⃣()
        let i: X2️⃣() { foo() }
        let j: X3️⃣(x) { foo() }
        let k: X4️⃣(x, y) { foo() }
        _ = (a, i, j, k)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' = '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 5: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
        DiagnosticSpec(locationMarker: "4️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

}
