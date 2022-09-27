// This test file has been translated from swift/test/Parse/playground_lvalues.swift

import XCTest

final class PlaygroundLvaluesTests: XCTestCase {
  func testPlaygroundLvalues1() {
    AssertParse(
      """
      var a = 1, b = 2
      let z = 3
      """
    )
  }

  func testPlaygroundLvalues2() {
    AssertParse(
      """
      a
      (a, b)
      (a, z)
      """
    )
  }

}
