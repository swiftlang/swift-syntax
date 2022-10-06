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
      let a:[X]#^DIAG_1^#()
      let b: [X]#^DIAG_2^#()
      let c :[X]#^DIAG_3^#()
      let d : [X]#^DIAG_4^#()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' = '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_2", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 7 - 8 = '= '
        DiagnosticSpec(locationMarker: "DIAG_3", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 7 - 8 = '='
        DiagnosticSpec(locationMarker: "DIAG_4", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern4() {
    AssertParse(
      """
      let e: X#^DIAG_1^#()#^DIAG_2^#, ee: Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "extraneous ', ee: Int' at top level"),
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern5() {
    AssertParse(
      """
      let f:/*comment*/[X]#^DIAG^#()
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
      let g: X#^DIAG_1^#(x)
      let h: X#^DIAG_2^#(x, y)
      let i: X#^DIAG_3^#() { foo() }
      let j: X#^DIAG_4^#(x) { foo() }
      let k: X#^DIAG_5^#(x, y) { foo() }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_2", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_3", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_4", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 5: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_5", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern9() {
    AssertParse(
      """
      func nonTopLevel() {
        let a:[X]#^DIAG_1^#()
        let i: X#^DIAG_2^#() { foo() }
        let j: X#^DIAG_3^#(x) { foo() }
        let k: X#^DIAG_4^#(x, y) { foo() }
        _ = (a, i, j, k)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' = '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_2", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_3", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 5: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_4", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

}
