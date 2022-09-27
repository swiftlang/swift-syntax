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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'deprecated' can't be combined with shorthand specification 'OSX 10.0'
        // TODO: Old parser expected note on line 1: did you mean to specify an introduction version?, Fix-It replacements: 15 - 15 = ', introduced:'
        // TODO: Old parser expected error on line 1: expected declaration
      ]
    )
  }

  func testDiagnoseAvailability5() {
    AssertParse(
      """
      @available(OSX 10.0, introduced: 10.12)
      func shorthandFollowedByIntroduced() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'introduced' can't be combined with shorthand specification 'OSX 10.0'
        // TODO: Old parser expected error on line 1: expected declaration
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'deprecated' can't be combined with shorthand specification 'OSX 10.0'
        // TODO: Old parser expected error on line 1: expected declaration
      ]
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
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unexpected version number in 'available' attribute for non-specific platform '*', Fix-It replacements: 25 - 30 = ''
      ]
    )
  }

  func testDiagnoseAvailability10() {
    AssertParse(
      """
      @available(*, deprecated, obsoleted: 4.2)
      func allPlatformsDeprecatedAndObsoleted() {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unexpected version number in 'available' attribute for non-specific platform '*', Fix-It replacements: 36 - 41 = ''
      ]
    )
  }

  func testDiagnoseAvailability11() {
    AssertParse(
      """
      @available(*, introduced: 4.0, deprecated: 4.1, obsoleted: 4.2)
      func allPlatformsDeprecatedAndObsoleted2() {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: unexpected version number in 'available' attribute for non-specific platform '*', Fix-It replacements: 25 - 30 = '', 42 - 47 = '', 58 - 63 = ''
      ]
    )
  }

  func testDiagnoseAvailability12() {
    AssertParse(
      """
      @available(swift, unavailable)
      func swiftUnavailable() {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'unavailable' cannot be used in 'available' attribute for platform 'swift'
      ]
    )
  }

  func testDiagnoseAvailability13() {
    AssertParse(
      """
      @available(swift, unavailable, introduced: 4.2)
      func swiftUnavailableIntroduced() {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: 'unavailable' cannot be used in 'available' attribute for platform 'swift'
      ]
    )
  }

  func testDiagnoseAvailability14() {
    AssertParse(
      """
      @available(swift, deprecated)
      func swiftDeprecated() {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: expected version number with 'deprecated' in 'available' attribute for platform 'swift'
      ]
    )
  }

  func testDiagnoseAvailability15() {
    AssertParse(
      """
      @available(swift, deprecated, obsoleted: 4.2)
      func swiftDeprecatedObsoleted() {}
      """,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: expected version number with 'deprecated' in 'available' attribute for platform 'swift'
      ]
    )
  }

  func testDiagnoseAvailability16() {
    AssertParse(
      #"""
      @available(swift, message: "missing valid option")
      func swiftMessage() {}
      """#,
      diagnostics: [
        // TODO: Old parser expected warning on line 1: expected 'introduced', 'deprecated', or 'obsoleted' in 'available' attribute for platform 'swift'
      ]
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
