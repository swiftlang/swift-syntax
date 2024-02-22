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

// This test file has been translated from swift/test/Parse/availability_query.swift

import XCTest

final class AvailabilityQueryTests: XCTestCase {
  func testAvailabilityQuery1() {
    assertParsedSource(
      """
      // Disallow use as an expression.
      if (#available(OSX 10.51, *)) {}
      """,
      expecting:
        """
        1 │ // Disallow use as an expression.
        2 │ if (#available(OSX 10.51, *)) {}
          │     ╰─ error: availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'

        """
    )
  }

  func testAvailabilityQuery2() {
    assertParsedSource(
      """
      (#available(OSX 10.51, *) ? 1 : 0)
      """,
      expecting:
        """
        1 │ (#available(OSX 10.51, *) ? 1 : 0)
          │  ╰─ error: availability condition cannot be used in an expression, only as a condition of 'if' or 'guard'

        """
    )
  }

  func testAvailabilityQuery3() {
    assertParsedSource(
      """
      if !#available(OSX 10.52, *) {
      }
      """,
      expecting:
        """
        1 │ if !#available(OSX 10.52, *) {
          │     ╰─ error: availability condition cannot be used in an expression; did you mean '#unavailable'?
        2 │ }

        """
    )
  }

  func testAvailabilityQuery4() {
    assertParsedSource(
      """
      if let _ = Optional(5), !#available(OSX 10.52, *) {
      }
      """,
      expecting:
        """
        1 │ if let _ = Optional(5), !#available(OSX 10.52, *) {
          │                          ╰─ error: availability condition cannot be used in an expression; did you mean '#unavailable'?
        2 │ }

        """
    )
  }

  func testAvailabilityQuery5() {
    assertParsedSource(
      """
      if #available(OSX 10.51, *) && #available(OSX 10.52, *) {
      }
      """,
      expecting:
        """
        1 │ if #available(OSX 10.51, *) && #available(OSX 10.52, *) {
          │                             ╰─ error: expected ',' joining parts of a multi-clause condition
        2 │ }

        """
    )
  }

  func testAvailabilityQuery6() {
    assertParsedSource(
      """
      if #available {
      }
      """,
      expecting:
        """
        1 │ if #available {
          │               ╰─ error: expected '(', '@availability' arguments, and ')' in availability condition
        2 │ }

        """
    )
  }

  func testAvailabilityQuery7() {
    assertParsedSource(
      """
      if #available( {
      }
      """,
      expecting:
        """
        1 │ if #available( {
          │               ╰─ error: expected platform and ')' to end availability condition
        2 │ }

        """
    )
  }

  func testAvailabilityQuery8() {
    assertParsedSource(
      """
      if #available() {
      }
      """,
      expecting:
        """
        1 │ if #available() {
          │               ╰─ error: expected version restriction in availability argument
        2 │ }

        """
    )
  }

  func testAvailabilityQuery9() {
    assertParsedSource(
      """
      if #available(OSX {
      }
      """,
      expecting:
        """
        1 │ if #available(OSX {
          │              │   ╰─ error: expected ')' to end availability condition
          │              ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQuery10() {
    assertParsedSource(
      """
      if #available(OSX 10.51 {
      }
      """,
      expecting:
        """
        1 │ if #available(OSX 10.51 {
          │              │         ╰─ error: expected ')' to end availability condition
          │              ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQuery11() {
    assertParsedSource(
      """
      if #available(* {
      }
      """,
      expecting:
        """
        1 │ if #available(* {
          │              │ ╰─ error: expected ')' to end availability condition
          │              ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQuery12() {
    assertParsedSource(
      """
      if #available(OSX 10.51, {
      }
      """,
      expecting:
        """
        1 │ if #available(OSX 10.51, {
          │              │           ├─ error: expected version restriction in availability argument
          │              │           ╰─ error: expected ')' to end availability condition
          │              ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQuery13() {
    assertParsedSource(
      """
      if #available(OSX 10.51,) {
      }
      """,
      expecting:
        """
        1 │ if #available(OSX 10.51,) {
          │                         ╰─ error: expected version restriction in availability argument
        2 │ }

        """
    )
  }

  func testAvailabilityQuery14() {
    assertParsedSource(
      """
      if #available(OSX 10.51, iOS {
      }
      """,
      expecting:
        """
        1 │ if #available(OSX 10.51, iOS {
          │              │              ╰─ error: expected ')' to end availability condition
          │              ╰─ note: to match this opening '('
        2 │ }

        """
    )
  }

  func testAvailabilityQuery15() {
    assertParsedSource(
      """
      if #available(OSX 10.51 || iOS 8.0) {
      }
      """,
      expecting:
        """
        1 │ if #available(OSX 10.51 || iOS 8.0) {
          │                         ╰─ error: expected ',' joining platforms in availability condition
        2 │ }

        """
    )
  }

  func testAvailabilityQuery16() {
    assertParsedSource(
      """
      if #available(OSX >= 10.51, *) {
      }
      """,
      expecting:
        """
        1 │ if #available(OSX >= 10.51, *) {
          │                   ╰─ error: version comparison not needed
        2 │ }

        """
    )
  }
}
