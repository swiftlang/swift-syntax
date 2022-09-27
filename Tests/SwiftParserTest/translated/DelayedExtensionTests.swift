// This test file has been translated from swift/test/Parse/delayed_extension.swift

import XCTest

final class DelayedExtensionTests: XCTestCase {
  func testDelayedExtension1() {
    AssertParse(
      """
      extension X { } 
      _ = 1
      f()
      """
    )
  }

}
