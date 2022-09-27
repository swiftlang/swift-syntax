// This test file has been translated from swift/test/Parse/hashbang_main.swift

import XCTest

final class HashbangMainTests: XCTestCase {
  func testHashbangMain1() {
    AssertParse(
      """
      #!/usr/bin/swift
      let x = 42
      x + x 
      // Check that we skip the hashbang at the beginning of the file.
      """
    )
  }

}
