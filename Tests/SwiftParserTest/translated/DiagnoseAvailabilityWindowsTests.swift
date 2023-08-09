//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/diagnose_availability_windows.swift

import XCTest

final class DiagnoseAvailabilityWindowsTests: ParserTestCase {
  func testDiagnoseAvailabilityWindows1() {
    assertParse(
      #"""
      @available(Windows, unavailable, message: "unsupported")
      func unavailable() {}
      """#
    )
  }

  func testDiagnoseAvailabilityWindows2() {
    assertParse(
      """
      unavailable()
      """
    )
  }

  func testDiagnoseAvailabilityWindows3() {
    assertParse(
      """
      @available(Windows, introduced: 10.0.17763, deprecated: 10.0.19140)
      func introduced_deprecated() {}
      """
    )
  }

  func testDiagnoseAvailabilityWindows4() {
    assertParse(
      """
      introduced_deprecated()
      """
    )
  }

  func testDiagnoseAvailabilityWindows5() {
    assertParse(
      """
      @available(Windows 10, *)
      func windows10() {}
      """
    )
  }

  func testDiagnoseAvailabilityWindows6() {
    assertParse(
      """
      windows10()
      """
    )
  }

  func testDiagnoseAvailabilityWindows7() {
    assertParse(
      """
      func conditional_compilation() {
        if #available(Windows 10, *) {
        }
      }
      """
    )
  }

}
