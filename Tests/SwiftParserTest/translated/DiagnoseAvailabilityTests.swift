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

// This test file has been translated from swift/test/Parse/diagnose_availability.swift

import XCTest

final class DiagnoseAvailabilityTests: XCTestCase {
  func testDiagnoseAvailability1() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/46814
      // Misleading/wrong error message for malformed '@available'
      """
    )
  }

  func testDiagnoseAvailability2() {
    AssertParse(
      """
      @available(OSX 10.6, *) // no error
      func availableSince10_6() {}
      """
    )
  }

  func testDiagnoseAvailability3() {
    AssertParse(
      """
      @available(OSX, introduced: 10.0, deprecated: 10.12) // no error
      func introducedFollowedByDeprecated() {}
      """
    )
  }

  func testDiagnoseAvailability4() {
    AssertParse(
      """
      @available(OSX 10.0, deprecated: 10.12)
      func shorthandFollowedByDeprecated() {}
      """
    )
  }

  func testDiagnoseAvailability5() {
    AssertParse(
      """
      @available(OSX 10.0, introduced: 10.12)
      func shorthandFollowedByIntroduced() {}
      """
    )
  }

  func testDiagnoseAvailability6() {
    AssertParse(
      """
      @available(iOS 6.0, OSX 10.8, *) // no error
      func availableOnMultiplePlatforms() {}
      """
    )
  }

  func testDiagnoseAvailability7() {
    AssertParse(
      """
      @available(iOS 6.0, OSX 10.0, deprecated: 10.12)
      func twoShorthandsFollowedByDeprecated() {}
      """
    )
  }

  func testDiagnoseAvailability8() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/51114
      // Missing/wrong warning message for '*' or 'swift' platform.
      """
    )
  }

  func testDiagnoseAvailability9() {
    AssertParse(
      """
      @available(*, deprecated: 4.2)
      func allPlatformsDeprecatedVersion() {}
      """
    )
  }

  func testDiagnoseAvailability10() {
    AssertParse(
      """
      @available(*, deprecated, obsoleted: 4.2)
      func allPlatformsDeprecatedAndObsoleted() {}
      """
    )
  }

  func testDiagnoseAvailability11() {
    AssertParse(
      """
      @available(*, introduced: 4.0, deprecated: 4.1, obsoleted: 4.2)
      func allPlatformsDeprecatedAndObsoleted2() {}
      """
    )
  }

  func testDiagnoseAvailability12() {
    AssertParse(
      """
      @available(swift, unavailable)
      func swiftUnavailable() {}
      """
    )
  }

  func testDiagnoseAvailability13() {
    AssertParse(
      """
      @available(swift, unavailable, introduced: 4.2)
      func swiftUnavailableIntroduced() {}
      """
    )
  }

  func testDiagnoseAvailability14() {
    AssertParse(
      """
      @available(swift, deprecated)
      func swiftDeprecated() {}
      """
    )
  }

  func testDiagnoseAvailability15() {
    AssertParse(
      """
      @available(swift, deprecated, obsoleted: 4.2)
      func swiftDeprecatedObsoleted() {}
      """
    )
  }

  func testDiagnoseAvailability16() {
    AssertParse(
      #"""
      @available(swift, message: "missing valid option")
      func swiftMessage() {}
      """#
    )
  }

  func testDiagnoseAvailability17() {
    AssertParse(
      #"""
      @available(*, unavailable, message: "\("message")")
      func interpolatedMessage() {}
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'message' cannot be an interpolated string literal
      ]
    )
  }

  func testDiagnoseAvailability18() {
    AssertParse(
      #"""
      @available(*, unavailable, message: """
        foobar message.
        """)
      func multilineMessage() {}
      multilineMessage()
      """#
    )
  }

  func testDiagnoseAvailability19() {
    AssertParse(
      #"""
      @available(*, unavailable, message: " ")
      func emptyMessage() {}
      emptyMessage()
      """#
    )
  }

  func testDiagnoseAvailability20() {
    AssertParse(
      ##"""
      @available(*, unavailable, message: #"""
        foobar message.
        """#)
      func extendedEscapedMultilineMessage() {}
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'message' cannot be an extended escaping string literal
      ]
    )
  }

  func testDiagnoseAvailability21() {
    AssertParse(
      ##"""
      @available(*, unavailable, renamed: #"available()"#)
      func extendedEscapedRenamed() {}
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'renamed' cannot be an extended escaping string literal
      ]
    )
  }

}
