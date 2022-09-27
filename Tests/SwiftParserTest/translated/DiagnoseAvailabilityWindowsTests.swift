// This test file has been translated from swift/test/Parse/diagnose_availability_windows.swift

import XCTest

final class DiagnoseAvailabilityWindowsTests: XCTestCase {
  func testDiagnoseAvailabilityWindows1() {
    AssertParse(
      #"""
      @available(Windows, unavailable, message: "unsupported")
      func unavailable() {}
      """#
    )
  }

  func testDiagnoseAvailabilityWindows2() {
    AssertParse(
      """
      unavailable()
      """
    )
  }

  func testDiagnoseAvailabilityWindows3() {
    AssertParse(
      """
      @available(Windows, introduced: 10.0.17763, deprecated: 10.0.19140)
      func introduced_deprecated() {}
      """
    )
  }

  func testDiagnoseAvailabilityWindows4() {
    AssertParse(
      """
      introduced_deprecated()
      """
    )
  }

  func testDiagnoseAvailabilityWindows5() {
    AssertParse(
      """
      @available(Windows 10, *)
      func windows10() {}
      """
    )
  }

  func testDiagnoseAvailabilityWindows6() {
    AssertParse(
      """
      windows10()
      """
    )
  }

  func testDiagnoseAvailabilityWindows7() {
    AssertParse(
      """
      func conditional_compilation() {
        if #available(Windows 10, *) {
        }
      }
      """
    )
  }

}
