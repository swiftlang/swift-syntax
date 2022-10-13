// This test file has been translated from swift/test/Parse/toplevel_library.swift

import XCTest

final class ToplevelLibraryTests: XCTestCase {
  func testToplevelLibrary1() {
    AssertParse(
      """
      // make sure trailing semicolons are valid syntax in toplevel library code.
      var x = 4;
      """
    )
  }

  func testToplevelLibraryInvalid1() {
    AssertParse(
      """
      let x = 42
      x + x;
      x + x;
      // Make sure we don't crash on closures at the top level
      ({ })
      ({ 5 }())
      """
    )
  }

  func testToplevelLibraryInvalid2() {
    AssertParse(
      """
      for i1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'in', expression, and body in 'for' statement"),
      ]
    )
  }
}
