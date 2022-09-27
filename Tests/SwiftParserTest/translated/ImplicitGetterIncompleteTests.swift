// This test file has been translated from swift/test/Parse/implicit_getter_incomplete.swift

import XCTest

final class ImplicitGetterIncompleteTests: XCTestCase {
  func testImplicitGetterIncomplete1() {
    AssertParse(
      """
      func test1() {
        var a : Int {
      #if arch(x86_64)
          return 0
      #else
          return 1
      #endif
        }
      }
      """
    )
  }

  func testImplicitGetterIncomplete2() {
    AssertParse(
      #"""
      // Would trigger assertion when AST verifier checks source ranges ("child source range not contained within its parent")
      func test2() { 
        var a : Int { 
          switch i { 
      }#^DIAG^#
      // expected-error@+1 2 {{expected '}'}}
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'switch' statement body must have at least one 'case'
        DiagnosticSpec(message: "expected '}' to end variable"),
        DiagnosticSpec(message: "expected '}' to end function"),
      ]
    )
  }

}
