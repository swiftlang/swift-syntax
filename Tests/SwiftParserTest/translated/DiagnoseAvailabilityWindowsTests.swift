// This test file has been translated from swift/test/Parse/diagnose_availability_windows.swift

import XCTest

final class DiagnoseAvailabilityWindowsTests: XCTestCase {
  func testDiagnoseAvailabilityWindows1() {
    AssertParse(
      #"""
      @available(Windows, unavailable, message: "unsupported")
      func unavailable() {}
      """#,
      diagnostics: [
        // TODO: Old parser expected note on line 2: 'unavailable()' has been explicitly marked unavailable here
      ]
    )
  }

  func testDiagnoseAvailabilityWindows2() {
    AssertParse(
      """
      unavailable()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'unavailable()' is unavailable in Windows: unsupported
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'introduced_deprecated()' is only available in * 10.0.17763 or newe
        // TODO: Old parser expected note on line 1: add 'if #available' version check
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'windows10()' is only available in * 10 or newer
        // TODO: Old parser expected note on line 1: add 'if #available' version check
      ]
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
