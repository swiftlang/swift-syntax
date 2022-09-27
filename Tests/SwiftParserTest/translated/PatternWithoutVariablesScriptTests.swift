// This test file has been translated from swift/test/Parse/pattern_without_variables_script.swift

import XCTest

final class PatternWithoutVariablesScriptTests: XCTestCase {
  func testPatternWithoutVariablesScript1() {
    AssertParse(
      """
      _ = 1
      """
    )
  }

}
