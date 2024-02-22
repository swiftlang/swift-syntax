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

// This test file has been translated from swift/test/Parse/availability_query_unavailability.swift

import XCTest

final class AvailabilityQueryUnavailabilityTests: XCTestCase {
  func testAvailabilityQueryUnavailability1() {
    assertParsedSource(
      """
      // Disallow explicit wildcards.
      if #unavailable(OSX 10.51, *) {}
      // Disallow use as an expression.
      if (#unavailable(OSX 10.51)) {}
      let x = #unavailable(OSX 10.51)
      (#unavailable(OSX 10.51) ? 1 : 0)
      """,
      expecting:
        """
        2 │ if #unavailable(OSX 10.51, *) {}
        3 │ // Disallow use as an expression.
        4 │ if (#unavailable(OSX 10.51)) {}
          │     ╰─ error: availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'
        5 │ let x = #unavailable(OSX 10.51)
          │         ╰─ error: availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'
        6 │ (#unavailable(OSX 10.51) ? 1 : 0)
          │  ╰─ error: availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'

        """
    )
  }

  func testAvailabilityQueryUnavailability2() {
    assertParsedSource(
      """
      if !#unavailable(OSX 10.52) {
      }
      """,
      expecting:
        """
        1 │ if !#unavailable(OSX 10.52) {
          │     ╰─ error: availability condition cannot be used in an expression; did you mean '#available'?
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability3() {
    assertParsedSource(
      """
      if let _ = Optional(5), !#unavailable(OSX 10.52) {
      }
      """,
      expecting:
        """
        1 │ if let _ = Optional(5), !#unavailable(OSX 10.52) {
          │                          ╰─ error: availability condition cannot be used in an expression; did you mean '#available'?
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability4() {
    assertParsedSource(
      """
      if #unavailable(OSX 10.51) && #unavailable(OSX 10.52) {
      }
      """,
      expecting:
        """
        1 │ if #unavailable(OSX 10.51) && #unavailable(OSX 10.52) {
          │                            ╰─ error: expected ',' joining parts of a multi-clause condition
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability5() {
    assertParsedSource(
      """
      if #unavailable {
      }
      """,
      expecting:
        """
        1 │ if #unavailable {
          │                ╰─ error: expected '(', '@availability' arguments, and ')' in availability condition
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability6() {
    assertParsedSource(
      """
      if #unavailable( {
      }
      """,
      expecting:
        """
        1 │ if #unavailable( {
          │                 ╰─ error: expected platform and ')' to end availability condition
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability7() {
    assertParsedSource(
      """
      if #unavailable() {
      }
      """,
      expecting:
        """
        1 │ if #unavailable() {
          │                 ╰─ error: expected version restriction in availability argument
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability8() {
    assertParsedSource(
      """
      if #unavailable(OSX {
      }
      """,
      expecting:
        """
        1 │ if #unavailable(OSX {
          │                │   ╰─ error: expected ')' to end availability condition
          │                ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability9() {
    assertParsedSource(
      """
      if #unavailable(OSX 10.51 {
      }
      """,
      expecting:
        """
        1 │ if #unavailable(OSX 10.51 {
          │                │         ╰─ error: expected ')' to end availability condition
          │                ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability10() {
    assertParsedSource(
      """
      // Should this be a valid spelling since `#unvailable(*)` cannot be written?
      if #unavailable() {
      }
      """,
      expecting:
        """
        1 │ // Should this be a valid spelling since `#unvailable(*)` cannot be written?
        2 │ if #unavailable() {
          │                 ╰─ error: expected version restriction in availability argument
        3 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability11() {
    assertParsedSource(
      """
      if #unavailable(OSX 10 {
      }
      """,
      expecting:
        """
        1 │ if #unavailable(OSX 10 {
          │                │      ╰─ error: expected ')' to end availability condition
          │                ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability12() {
    assertParsedSource(
      """
      if #unavailable(OSX 10.51, {
      }
      """,
      expecting:
        """
        1 │ if #unavailable(OSX 10.51, {
          │                │           ├─ error: expected version restriction in availability argument
          │                │           ╰─ error: expected ')' to end availability condition
          │                ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability13() {
    assertParsedSource(
      """
      if #unavailable(OSX 10.51,) {
      }
      """,
      expecting:
        """
        1 │ if #unavailable(OSX 10.51,) {
          │                           ╰─ error: expected version restriction in availability argument
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability14() {
    assertParsedSource(
      """
      if #unavailable(OSX 10.51, iOS {
      }
      """,
      expecting:
        """
        1 │ if #unavailable(OSX 10.51, iOS {
          │                │              ╰─ error: expected ')' to end availability condition
          │                ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability15() {
    assertParsedSource(
      """
      if #unavailable(OSX 10.51 || iOS 8.0) {
      }
      """,
      expecting:
        """
        1 │ if #unavailable(OSX 10.51 || iOS 8.0) {
          │                           ╰─ error: expected ',' joining platforms in availability condition
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability16() {
    assertParsedSource(
      """
      // Emit Fix-It removing un-needed >=, for the moment.
      if #unavailable(OSX >= 10.51) {
      }
      """,
      expecting:
        """
        1 │ // Emit Fix-It removing un-needed >=, for the moment.
        2 │ if #unavailable(OSX >= 10.51) {
          │                     ╰─ error: version comparison not needed
        3 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability17() {
    assertParsedSource(
      """
      if #available(*) == false {
      }
      """,
      expecting:
        """
        1 │ if #available(*) == false {
          │                  ╰─ error: #available cannot be used as an expression, did you mean to use '#unavailable'?
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability18() {
    assertParsedSource(
      """
      if #available(*) == false && true {
      }
      """,
      expecting:
        """
        1 │ if #available(*) == false && true {
          │                  │        ╰─ error: expected ',' joining parts of a multi-clause condition
          │                  ╰─ error: #available cannot be used as an expression, did you mean to use '#unavailable'?
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability19() {
    assertParsedSource(
      """
      if !#available(*) {
      }
      """,
      expecting:
        """
        1 │ if !#available(*) {
          │     ╰─ error: availability condition cannot be used in an expression; did you mean '#unavailable'?
        2 │ }

        """
    )
  }

  func testAvailabilityQueryUnavailability20() {
    assertParsedSource(
      """
      if #available(*) == {
      }
      """,
      expecting:
        """
        1 │ if #available(*) == {
          │                  ╰─ error: unexpected code '==' in 'if' statement
        2 │ }

        """
    )
  }
}
