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

// This test file has been translated from swift/test/Parse/number_identifier_errors.swift

import XCTest

final class NumberIdentifierErrorsTests: XCTestCase {
  func testNumberIdentifierErrors1() {
    assertParsedSource(
      """
      func 1() {}
      """,
      expecting:
        """
        1 │ func 1() {}
          │      ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors2() {
    assertParsedSource(
      """
      func 2.0() {}
      """,
      expecting:
        """
        1 │ func 2.0() {}
          │      ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors3() {
    assertParsedSource(
      """
      func 3func() {}
      """,
      expecting:
        """
        1 │ func 3func() {}
          │      ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors4() {
    assertParsedSource(
      """
      protocol 4 {
        associatedtype 5
      }
      """,
      expecting:
        """
        1 │ protocol 4 {
          │          ╰─ error: identifier can only start with a letter or underscore, not a number
        2 │   associatedtype 5
          │                  ╰─ error: identifier can only start with a letter or underscore, not a number
        3 │ }

        """
    )
  }

  func testNumberIdentifierErrors5() {
    assertParsedSource(
      """
      protocol 6.0 {
        associatedtype 7.0
      }
      """,
      expecting:
        """
        1 │ protocol 6.0 {
          │          ╰─ error: identifier can only start with a letter or underscore, not a number
        2 │   associatedtype 7.0
          │                  ╰─ error: identifier can only start with a letter or underscore, not a number
        3 │ }

        """
    )
  }

  func testNumberIdentifierErrors6() {
    assertParsedSource(
      """
      protocol 8protocol {
        associatedtype 9associatedtype
      }
      """,
      expecting:
        """
        1 │ protocol 8protocol {
          │          ╰─ error: identifier can only start with a letter or underscore, not a number
        2 │   associatedtype 9associatedtype
          │                  ╰─ error: identifier can only start with a letter or underscore, not a number
        3 │ }

        """
    )
  }

  func testNumberIdentifierErrors7() {
    assertParsedSource(
      """
      typealias 10 = Int
      """,
      expecting:
        """
        1 │ typealias 10 = Int
          │           ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors8() {
    assertParsedSource(
      """
      typealias 11.0 = Int
      """,
      expecting:
        """
        1 │ typealias 11.0 = Int
          │           ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors9() {
    assertParsedSource(
      """
      typealias 12typealias = Int
      """,
      expecting:
        """
        1 │ typealias 12typealias = Int
          │           ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors10() {
    assertParsedSource(
      """
      struct 13 {}
      """,
      expecting:
        """
        1 │ struct 13 {}
          │        ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors11() {
    assertParsedSource(
      """
      struct 14.0 {}
      """,
      expecting:
        """
        1 │ struct 14.0 {}
          │        ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors12() {
    assertParsedSource(
      """
      struct 15struct {}
      """,
      expecting:
        """
        1 │ struct 15struct {}
          │        ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors13() {
    assertParsedSource(
      """
      enum 16 {}
      """,
      expecting:
        """
        1 │ enum 16 {}
          │      ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors14() {
    assertParsedSource(
      """
      enum 17.0 {}
      """,
      expecting:
        """
        1 │ enum 17.0 {}
          │      ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors15() {
    assertParsedSource(
      """
      enum 18enum {}
      """,
      expecting:
        """
        1 │ enum 18enum {}
          │      ╰─ error: identifier can only start with a letter or underscore, not a number

        """
    )
  }

  func testNumberIdentifierErrors16() {
    assertParsedSource(
      """
      class 19 {
        func 20() {}
      }
      """,
      expecting:
        """
        1 │ class 19 {
          │       ╰─ error: identifier can only start with a letter or underscore, not a number
        2 │   func 20() {}
          │        ╰─ error: identifier can only start with a letter or underscore, not a number
        3 │ }

        """
    )
  }

  func testNumberIdentifierErrors17() {
    assertParsedSource(
      """
      class 21.0 {
        func 22.0() {}
      }
      """,
      expecting:
        """
        1 │ class 21.0 {
          │       ╰─ error: identifier can only start with a letter or underscore, not a number
        2 │   func 22.0() {}
          │        ╰─ error: identifier can only start with a letter or underscore, not a number
        3 │ }

        """
    )
  }

  func testNumberIdentifierErrors18() {
    assertParsedSource(
      """
      class 23class {
        func 24method() {}
      }
      """,
      expecting:
        """
        1 │ class 23class {
          │       ╰─ error: identifier can only start with a letter or underscore, not a number
        2 │   func 24method() {}
          │        ╰─ error: identifier can only start with a letter or underscore, not a number
        3 │ }

        """
    )
  }
}
