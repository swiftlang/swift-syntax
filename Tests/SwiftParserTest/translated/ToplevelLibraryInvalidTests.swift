// This test file has been translated from swift/test/Parse/toplevel_library_invalid.swift

import XCTest

final class ToplevelLibraryInvalidTests: XCTestCase {
  func testToplevelLibraryInvalid1() {
    AssertParse(
      """
      let x = 42
      x + x; 
      x + x; 
      // Make sure we don't crash on closures at the top level
      ({ }) 
      ({ 5 }())
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expressions are not allowed at the top level
        // TODO: Old parser expected error on line 3: expressions are not allowed at the top level
        // TODO: Old parser expected error on line 5: expressions are not allowed at the top level
        // TODO: Old parser expected error on line 6: expressions are not allowed at the top level
      ]
    )
  }

  func testToplevelLibraryInvalid2() {
    AssertParse(
      """
      for i#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected 'in' after for-each pattern
        // TODO: Old parser expected error on line 1: expected Sequence expression for for-each loop
        // TODO: Old parser expected error on line 1: expected '{' to start the body of for-each loop
        DiagnosticSpec(message: "expected 'in' and expression in 'for' statement"),
        DiagnosticSpec(message: "expected code block in 'for' statement"),
      ]
    )
  }

}
