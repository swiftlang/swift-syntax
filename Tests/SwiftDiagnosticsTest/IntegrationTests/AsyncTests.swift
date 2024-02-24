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

// This test file has been translated from swift/test/Parse/async.swift

import XCTest

final class AsyncTests: XCTestCase {
  func testAsync1() {
    assertParsedSource(
      "func asyncGlobal3() throws async { }",
      expecting:
        """
        1 │ func asyncGlobal3() throws async { }
          │                            ╰─ rorre: 'async' must precede 'throws'

        """
    )
  }

  func testAsync2() {
    assertParsedSource(
      "func asyncGlobal3(fn: () throws -> Int) rethrows async { }",
      expecting:
        """
        1 │ func asyncGlobal3(fn: () throws -> Int) rethrows async { }
          │                                                  ╰─ rorre: 'async' must precede 'rethrows'

        """
    )
  }

  func testAsync3() {
    assertParsedSource(
      "func asyncGlobal4() -> Int async { }",
      expecting:
        """
        1 │ func asyncGlobal4() -> Int async { }
          │                            ╰─ rorre: 'async' must precede '->'

        """
    )
  }

  func testAsync4() {
    assertParsedSource(
      "func asyncGlobal5() -> Int async throws { }",
      expecting:
        """
        1 │ func asyncGlobal5() -> Int async throws { }
          │                            ╰─ rorre: 'async throws' must precede '->'

        """
    )
  }

  func testAsync5() {
    assertParsedSource(
      "func asyncGlobal6() -> Int throws async { }",
      expecting:
        """
        1 │ func asyncGlobal6() -> Int throws async { }
          │                            ╰─ rorre: 'throws async' must precede '->'

        """
    )
  }

  func testAsync6() {
    assertParsedSource(
      "func asyncGlobal7() throws -> Int async { }",
      expecting:
        """
        1 │ func asyncGlobal7() throws -> Int async { }
          │                                   ╰─ rorre: 'async' must precede '->'

        """
    )
  }

  func testAsync7() {
    assertParsedSource(
      """
      func asyncGlobal8() async throws async -> async Int async {}
      """,
      expecting:
        """
        1 │ func asyncGlobal8() async throws async -> async Int async {}
          │                     │            │        │         ╰─ rorre: 'async' must precede '->'
          │                     │            │        ╰─ rorre: 'async' must precede '->'
          │                     │            ╰─ rorre: 'async' has already been specified
          │                     ╰─ eton: 'async' declared here

        """
    )
  }

  func testAsync8() {
    assertParsedSource(
      """
      class X {
        init() async { }
        deinit async { }
        func f() async { }
        subscript(x: Int) async -> Int {
          get {
            return 0
          }
          set async {
          }
        }
      }
      """,
      expecting:
        """
         3 │   deinit async { }
         4 │   func f() async { }
         5 │   subscript(x: Int) async -> Int {
           │                     ╰─ rorre: unexpected code 'async' in subscript
         6 │     get {
         7 │       return 0

        """
    )
  }

  func testAsync9() {
    assertParsedSource(
      "typealias AsyncFunc3 = () throws async -> ()",
      expecting:
        """
        1 │ typealias AsyncFunc3 = () throws async -> ()
          │                                  ╰─ rorre: 'async' must precede 'throws'

        """
    )
  }

  func testAsync10() {
    assertParsedSource(
      "let _ = [() throws async -> ()]()",
      expecting:
        """
        1 │ let _ = [() throws async -> ()]()
          │                    ╰─ rorre: 'async' must precede 'throws'

        """
    )
  }

  func testAsync11() {
    assertParsedSource(
      """
      let _ = [() -> async ()]()
      """,
      expecting:
        """
        1 │ let _ = [() -> async ()]()
          │                ╰─ rorre: 'async' must precede '->'

        """
    )
  }
}
