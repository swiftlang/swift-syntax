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
    assertParsedSource(
      #"""
      @available(*, unavailable, message: "\("message")")
      func interpolatedMessage() {}
      """#,
      expecting:
        #"""
        1 │ @available(*, unavailable, message: "\("message")")
          │                                      ╰─ error: argument cannot be an interpolated string literal
        2 │ func interpolatedMessage() {}

        """#
    )
  }

  func testDiagnoseAvailability2() {
    assertParsedSource(
      #"""
      @available(*, unavailable, message: "\(someCall())")
      func interpolatedMessage() {}
      """#,
      expecting:
        #"""
        1 │ @available(*, unavailable, message: "\(someCall())")
          │                                      ╰─ error: argument cannot be an interpolated string literal
        2 │ func interpolatedMessage() {}

        """#
    )
  }

  func testDiagnoseAvailability3() {
    assertParsedSource(
      ##"""
      @available(*, unavailable, message: #"""
        foobar message.
        """#)
      func extendedEscapedMultilineMessage() {}
      """##,
      expecting:
        ##"""
        1 │ @available(*, unavailable, message: #"""
          │                                     ╰─ error: argument cannot be an extended escaping string literal
        2 │   foobar message.
        3 │   """#)

        """##
    )
  }

  func testDiagnoseAvailability4() {
    assertParsedSource(
      ##"""
      @available(*, unavailable, renamed: #"available()"#)
      func extendedEscapedRenamed() {}
      """##,
      expecting:
        ##"""
        1 │ @available(*, unavailable, renamed: #"available()"#)
          │                                     ╰─ error: argument cannot be an extended escaping string literal
        2 │ func extendedEscapedRenamed() {}

        """##
    )
  }
}
