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
      let a:[X]()  
      let b: [X]()  
      let c :[X]()  
      let d : [X]()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' = '
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 7 - 8 = '= '
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 7 - 8 = '='
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern4() {
    AssertParse(
      """
      let e: X()#^DIAG^#, ee: Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        DiagnosticSpec(message: "extraneous ', ee: Int' at top level"),
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern5() {
    AssertParse(
      """
      let f:/*comment*/[X]()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' = '
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
      let g: X(x)  
      let h: X(x, y)  
      let i: X() { foo() }  
      let j: X(x) { foo() }  
      let k: X(x, y) { foo() }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
        // TODO: Old parser expected error on line 5: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 6 - 7 = ' ='
      ]
    )
  }

  func testDiagnoseInitializerAsTypedPattern9() {
    AssertParse(
      """
      func nonTopLevel() {
        let a:[X]()   
        let i: X() { foo() }  
        let j: X(x) { foo() }  
        let k: X(x, y) { foo() }  
        _ = (a, i, j, k)
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' = '
        // TODO: Old parser expected error on line 3: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
        // TODO: Old parser expected error on line 4: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
        // TODO: Old parser expected error on line 5: unexpected initializer in pattern; did you mean to use '='?, Fix-It replacements: 8 - 9 = ' ='
      ]
    )
  }

}
