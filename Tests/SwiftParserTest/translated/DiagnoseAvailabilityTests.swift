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

final class DiagnoseAvailabilityTests: ParserTestCase {
  func testDiagnoseAvailability1() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/46814
      // Misleading/wrong error message for malformed '@available'
      """
    )
  }

  func testDiagnoseAvailability2() {
    assertParse(
      """
      @available(OSX 10.6, *) // no error
      func availableSince10_6() {}
      """
    )
  }

  func testDiagnoseAvailability3() {
    assertParse(
      """
      @available(OSX, introduced: 10.0, deprecated: 10.12) // no error
      func introducedFollowedByDeprecated() {}
      """
    )
  }

  func testDiagnoseAvailability4() {
    assertParse(
      """
      @available(OSX 10.0, deprecated: 10.12)
      func shorthandFollowedByDeprecated() {}
      """
    )
  }

  func testDiagnoseAvailability5() {
    assertParse(
      """
      @available(OSX 10.0, introduced: 10.12)
      func shorthandFollowedByIntroduced() {}
      """
    )
  }

  func testDiagnoseAvailability6() {
    assertParse(
      """
      @available(iOS 6.0, OSX 10.8, *) // no error
      func availableOnMultiplePlatforms() {}
      """
    )
  }

  func testDiagnoseAvailability7() {
    assertParse(
      """
      @available(iOS 6.0, OSX 10.0, deprecated: 10.12)
      func twoShorthandsFollowedByDeprecated() {}
      """
    )
  }

  func testDiagnoseAvailability9() {
    // https://github.com/apple/swift/issues/51114
    // Missing/wrong warning message for '*' or 'swift' platform.
    assertParse(
      """
      @available(*, deprecated: 4.2)
      func allPlatformsDeprecatedVersion() {}
      """
    )
  }

  func testDiagnoseAvailability10() {
    assertParse(
      """
      @available(*, deprecated, obsoleted: 4.2)
      func allPlatformsDeprecatedAndObsoleted() {}
      """
    )
  }

  func testDiagnoseAvailability11() {
    assertParse(
      """
      @available(*, introduced: 4.0, deprecated: 4.1, obsoleted: 4.2)
      func allPlatformsDeprecatedAndObsoleted2() {}
      """
    )
  }

  func testDiagnoseAvailability12() {
    assertParse(
      """
      @available(swift, unavailable)
      func swiftUnavailable() {}
      """
    )
  }

  func testDiagnoseAvailability13() {
    assertParse(
      """
      @available(swift, unavailable, introduced: 4.2)
      func swiftUnavailableIntroduced() {}
      """
    )
  }

  func testDiagnoseAvailability14() {
    assertParse(
      """
      @available(swift, deprecated)
      func swiftDeprecated() {}
      """
    )
  }

  func testDiagnoseAvailability15() {
    assertParse(
      """
      @available(swift, deprecated, obsoleted: 4.2)
      func swiftDeprecatedObsoleted() {}
      """
    )
  }

  func testDiagnoseAvailability16() {
    assertParse(
      #"""
      @available(swift, message: "missing valid option")
      func swiftMessage() {}
      """#
    )
  }

  func testDiagnoseAvailability17a() {
    assertParse(
      #"""
      @available(*, unavailable, message: "1️⃣\("message")")
      func interpolatedMessage() {}
      """#,
      diagnostics: [
        DiagnosticSpec(message: "argument cannot be an interpolated string literal")
      ]
    )
  }

  func testDiagnoseAvailability17b() {
    assertParse(
      #"""
      @available(*, unavailable, message: "1️⃣\(someCall())")
      func interpolatedMessage() {}
      """#,
      diagnostics: [
        DiagnosticSpec(message: "argument cannot be an interpolated string literal")
      ]
    )
  }

  func testDiagnoseAvailability18() {
    assertParse(
      #"""
      @available(*, unavailable, message: """
        foobar message.
        """)
      func multilineMessage() {}
      """#
    )
  }

  func testDiagnoseAvailability19() {
    assertParse(
      #"""
      @available(*, unavailable, message: " ")
      func emptyMessage() {}
      emptyMessage()
      """#
    )
  }

  func testDiagnoseAvailability20() {
    assertParse(
      ##"""
      @available(*, unavailable, message: 1️⃣#"""
        foobar message.
        """#)
      func extendedEscapedMultilineMessage() {}
      """##,
      diagnostics: [
        DiagnosticSpec(
          message: "argument cannot be an extended escaping string literal",
          fixIts: ["remove '#' and '#'"]
        )
      ],
      fixedSource: ##"""
        @available(*, unavailable, message: """
          foobar message.
          """)
        func extendedEscapedMultilineMessage() {}
        """##
    )
  }

  func testDiagnoseAvailability21() {
    assertParse(
      ##"""
      @available(*, unavailable, renamed: 1️⃣#"available()"#)
      func extendedEscapedRenamed() {}
      """##,
      diagnostics: [
        DiagnosticSpec(
          message: "argument cannot be an extended escaping string literal",
          fixIts: ["remove '#' and '#'"]
        )
      ],
      fixedSource: #"""
        @available(*, unavailable, renamed: "available()")
        func extendedEscapedRenamed() {}
        """#
    )
  }
}
