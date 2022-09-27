// This test file has been translated from swift/test/Parse/debugger.swift

import XCTest

final class DebuggerTests: XCTestCase {
  func testDebugger1() {
    AssertParse(
      """
      import Nonexistent_Module
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: no such module
      ]
    )
  }

  func testDebugger2() {
    AssertParse(
      """
      var ($x0, $x1) = (4, 3)
      var z = $x0 + $x1
      """
    )
  }

  func testDebugger3() {
    AssertParse(
      """
      z // no error.
      """
    )
  }

  func testDebugger4() {
    AssertParse(
      """
      var x: Double = z
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot convert value of type 'Int' to specified type 'Double'
      ]
    )
  }

}
