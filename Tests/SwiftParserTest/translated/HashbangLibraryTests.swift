// This test file has been translated from swift/test/Parse/hashbang_library.swift

import XCTest

final class HashbangLibraryTests: XCTestCase {
  func testHashbangLibrary1() {
    AssertParse(
      """
      #!/usr/bin/swift 
      class Foo {}
      // Check that we diagnose and skip the hashbang at the beginning of the file
      // when compiling in library mode.
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: hashbang line is allowed only in the main file
      ]
    )
  }

}
