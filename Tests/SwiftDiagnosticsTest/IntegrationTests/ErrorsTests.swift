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

// This test file has been translated from swift/test/Parse/errors.swift

import XCTest

final class ErrorsTests: XCTestCase {
  func testErrors1() {
    assertParsedSource(
      """
      func illformed() throws {
          do {
            _ = try genError()
          } catch MSV.CarriesInt(let i) where i == genError()) {
          }
      }
      """,
      expecting:
        """
        2 │     do {
        3 │       _ = try genError()
        4 │     } catch MSV.CarriesInt(let i) where i == genError()) {
          │                                                        ╰─ error: unexpected code ')' in 'catch' clause
        5 │     }
        6 │ }

        """
    )
  }

  func testErrors2() {
    assertParsedSource(
      """
      func postThrows() -> Int throws {
        return 5
      }
      """,
      expecting:
        """
        1 │ func postThrows() -> Int throws {
          │                          ╰─ error: 'throws' must precede '->'
        2 │   return 5
        3 │ }

        """
    )
  }

  func testErrors3() {
    assertParsedSource(
      """
      func postThrows2() -> throws Int {
        return try postThrows()
      }
      """,
      expecting:
        """
        1 │ func postThrows2() -> throws Int {
          │                       ╰─ error: 'throws' must precede '->'
        2 │   return try postThrows()
        3 │ }

        """
    )
  }

  func testErrors4() {
    assertParsedSource(
      """
      func postRethrows(_ f: () throws -> Int) -> Int rethrows {
        return try f()
      }
      """,
      expecting:
        """
        1 │ func postRethrows(_ f: () throws -> Int) -> Int rethrows {
          │                                                 ╰─ error: 'rethrows' must precede '->'
        2 │   return try f()
        3 │ }

        """
    )
  }

  func testErrors5() {
    assertParsedSource(
      """
      func postRethrows2(_ f: () throws -> Int) -> rethrows Int {
        return try f()
      }
      """,
      expecting:
        """
        1 │ func postRethrows2(_ f: () throws -> Int) -> rethrows Int {
          │                                              ╰─ error: 'rethrows' must precede '->'
        2 │   return try f()
        3 │ }

        """
    )
  }

  func testErrors6() {
    assertParsedSource(
      """
      func postThrows3() {
        _ = { () -> Int throws in }
      }
      """,
      expecting:
        """
        1 │ func postThrows3() {
        2 │   _ = { () -> Int throws in }
          │                   ╰─ error: 'throws' must precede '->'
        3 │ }

        """
    )
  }

  func testErrors7() {
    assertParsedSource(
      """
      func dupThrows1() throws rethrows -> throws Int throw {}
      """,
      expecting:
        """
        1 │ func dupThrows1() throws rethrows -> throws Int throw {}
          │                   │      │           │          ╰─ error: 'throw' must precede '->'
          │                   │      │           ╰─ error: 'throws' must precede '->'
          │                   │      ╰─ error: 'rethrows' conflicts with 'throws'
          │                   ╰─ note: 'throws' declared here

        """
    )
  }

  func testErrors8() {
    assertParsedSource(
      """
      func dupThrows2(_ f: () throws -> rethrows Int) {}
      """,
      expecting:
        """
        1 │ func dupThrows2(_ f: () throws -> rethrows Int) {}
          │                                   ╰─ error: 'rethrows' must precede '->'

        """
    )
  }

  func testErrors9() {
    assertParsedSource(
      """
      _ = { () try throws in }
      """,
      expecting:
        """
        1 │ _ = { () try throws in }
          │          │   ╰─ note: 'throws' declared here
          │          ╰─ error: 'try' conflicts with 'throws'

        """
    )
  }

  func testErrors10() {
    assertParsedSource(
      """
      _ = { () throws -> Int throws in }
      """,
      expecting:
        """
        1 │ _ = { () throws -> Int throws in }
          │                        ╰─ error: 'throws' must precede '->'

        """
    )
  }

  func testErrors11() {
    // rdar://21328447
    assertParsedSource(
      """
      func fixitThrow0() throw {}
      """,
      expecting:
        """
        1 │ func fixitThrow0() throw {}
          │                    ╰─ error: expected throwing specifier; did you mean 'throws'?

        """
    )
  }

  func testErrors12() {
    assertParsedSource(
      """
      func fixitThrow1() throw -> Int {}
      """,
      expecting:
        """
        1 │ func fixitThrow1() throw -> Int {}
          │                    ╰─ error: expected throwing specifier; did you mean 'throws'?

        """
    )
  }

  func testErrors13() {
    assertParsedSource(
      """
      func fixitThrow2() throws {
        var _: (Int)
        throw MSV.Foo
        var _: (Int) throw -> Int
      }
      """,
      expecting:
        """
        2 │   var _: (Int)
        3 │   throw MSV.Foo
        4 │   var _: (Int) throw -> Int
          │                ╰─ error: expected throwing specifier; did you mean 'throws'?
        5 │ }

        """
    )
  }

  func testErrors14() {
    assertParsedSource(
      """
      let fn: () -> throws Void
      """,
      expecting:
        """
        1 │ let fn: () -> throws Void
          │               ╰─ error: 'throws' must precede '->'

        """
    )
  }

  func testErrors15() {
    assertParsedSource(
      """
      func fixitTry0<T>(a: T) try where T:ExpressibleByStringLiteral {}
      """,
      expecting:
        """
        1 │ func fixitTry0<T>(a: T) try where T:ExpressibleByStringLiteral {}
          │                         ╰─ error: expected throwing specifier; did you mean 'throws'?

        """
    )
  }

  func testErrors16() {
    assertParsedSource(
      """
      func fixitTry1<T>(a: T) try {}
      """,
      expecting:
        """
        1 │ func fixitTry1<T>(a: T) try {}
          │                         ╰─ error: expected throwing specifier; did you mean 'throws'?

        """
    )
  }

  func testErrors17() {
    assertParsedSource(
      """
      func fixitTry2() try {}
      """,
      expecting:
        """
        1 │ func fixitTry2() try {}
          │                  ╰─ error: expected throwing specifier; did you mean 'throws'?

        """
    )
  }

  func testErrors18() {
    assertParsedSource(
      """
      let fixitTry3 : () try -> Int
      """,
      expecting:
        """
        1 │ let fixitTry3 : () try -> Int
          │                    ╰─ error: expected throwing specifier; did you mean 'throws'?

        """
    )
  }

  func testErrors19() {
    assertParsedSource(
      """
      func fixitAwait0() await { }
      """,
      expecting:
        """
        1 │ func fixitAwait0() await { }
          │                    ╰─ error: expected async specifier; did you mean 'async'?

        """
    )
  }

  func testErrors20() {
    assertParsedSource(
      """
      func fixitAwait1() await -> Int { }
      """,
      expecting:
        """
        1 │ func fixitAwait1() await -> Int { }
          │                    ╰─ error: expected async specifier; did you mean 'async'?

        """
    )
  }

  func testErrors21() {
    assertParsedSource(
      """
      func fixitAwait2() throws await -> Int { }
      """,
      expecting:
        """
        1 │ func fixitAwait2() throws await -> Int { }
          │                           ╰─ error: 'await' must precede 'throws'

        """
    )
  }

  func testErrors22() {
    assertParsedSource(
      """
      do {
        true ? () : throw opaque_error()
      } catch _ {
      }
      """,
      expecting:
        """
        1 │ do {
        2 │   true ? () : throw opaque_error()
          │               ╰─ error: expected expression after ternary operator
        3 │ } catch _ {
        4 │ }

        """
    )
  }

  func testAwaitBetwenAsyncAndThrows() {
    assertParsedSource(
      """
      func fixitAwait2() async await throws -> Int { }
      """,
      expecting:
        """
        1 │ func fixitAwait2() async await throws -> Int { }
          │                    │     ╰─ error: 'await' conflicts with 'async'
          │                    ╰─ note: 'async' declared here

        """
    )
  }

  func testAsyncAwait() {
    assertParsedSource(
      """
      func fixitAwait2() async await -> Int { }
      """,
      expecting:
        """
        1 │ func fixitAwait2() async await -> Int { }
          │                    │     ╰─ error: 'await' conflicts with 'async'
          │                    ╰─ note: 'async' declared here

        """
    )
  }
}
