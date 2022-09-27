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

}
