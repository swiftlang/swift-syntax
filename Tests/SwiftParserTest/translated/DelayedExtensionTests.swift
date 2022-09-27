// This test file has been translated from swift/test/Parse/delayed_extension.swift

import XCTest

final class DelayedExtensionTests: XCTestCase {
  func testDelayedExtension1() {
    AssertParse(
      """
      extension X { } 
      _ = 1
      f()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find type 'X' in scope
        // TODO: Old parser expected error on line 3: cannot find 'f' in scope
      ]
    )
  }

}
