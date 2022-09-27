// This test file has been translated from swift/test/Parse/guard-top-level.swift

import XCTest

final class GuardTopLevelTests: XCTestCase {
  func testGuardTopLevel1() {
    AssertParse(
      """
      let a: Int? = 1
      guard let b = a else {
      }
      """
    )
  }

  func testGuardTopLevel2() {
    AssertParse(
      """
      func foo() {} // to interrupt the TopLevelCodeDecl
      """
    )
  }

  func testGuardTopLevel3() {
    AssertParse(
      """
      let c = b
      """
    )
  }

}
