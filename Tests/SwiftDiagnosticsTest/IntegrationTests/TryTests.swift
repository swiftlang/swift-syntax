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

// This test file has been translated from swift/test/Parse/try.swift

import XCTest

final class TryTests: XCTestCase {
  func testTry1() {
    assertParsedSource(
      """
      try let singleLet = try foo()
      """,
      expecting:
        """
        1 │ try let singleLet = try foo()
          │ ╰─ error: 'try' must be placed on the initial value expression

        """
    )
  }

  func testTry2() {
    assertParsedSource(
      """
      try let singleLet = foo()
      """,
      expecting:
        """
        1 │ try let singleLet = foo()
          │ ╰─ error: 'try' must be placed on the initial value expression

        """
    )
  }

  func testTry3() {
    assertParsedSource(
      """
      try var singleVar = foo()
      """,
      expecting:
        """
        1 │ try var singleVar = foo()
          │ ╰─ error: 'try' must be placed on the initial value expression

        """
    )
  }

  func testTry4() {
    assertParsedSource(
      """
      try let uninit: Int
      """,
      expecting:
        """
        1 │ try let uninit: Int
          │ ╰─ error: 'try' must be placed on the initial value expression

        """
    )
  }

  func testTry5() {
    assertParsedSource(
      """
      try let (destructure1, destructure2) = (foo(), bar())
      """,
      expecting:
        """
        1 │ try let (destructure1, destructure2) = (foo(), bar())
          │ ╰─ error: 'try' must be placed on the initial value expression

        """
    )
  }

  func testTry6() {
    assertParsedSource(
      """
      try let multi1 = foo(), multi2 = bar()
      """,
      expecting:
        """
        1 │ try let multi1 = foo(), multi2 = bar()
          │ ╰─ error: 'try' must be placed on the initial value expression

        """
    )
  }

  func testTry7() {
    assertParsedSource(
      """
      class TryDecl {
        try let singleLet = foo()
      }
      """,
      expecting:
        """
        1 │ class TryDecl {
        2 │   try let singleLet = foo()
          │   ╰─ error: 'try' must be placed on the initial value expression
        3 │ }

        """
    )
  }

  func testTry8() {
    assertParsedSource(
      """
      class TryDecl {
        try var singleVar = foo()
      }
      """,
      expecting:
        """
        1 │ class TryDecl {
        2 │   try var singleVar = foo()
          │   ╰─ error: 'try' must be placed on the initial value expression
        3 │ }

        """
    )
  }

  func testTry9() {
    assertParsedSource(
      """
      try
      func method() {}
      """,
      expecting:
        """
        1 │ try
          │    ╰─ error: expected expression after 'try'
        2 │ func method() {}

        """
    )
  }

  func testTry10() {
    assertParsedSource(
      """
      try func method() {}
      """,
      expecting:
        """
        1 │ try func method() {}
          │ ╰─ error: 'try' cannot be used with 'func'

        """
    )
  }

  func testTry11() {
    assertParsedSource(
      """
      try while true {
        try break
      }
      """,
      expecting:
        """
        1 │ try while true {
          │ ╰─ error: 'try' cannot be used with 'while'
        2 │   try break
          │   ╰─ error: 'try' cannot be used with 'break'
        3 │ }

        """
    )
  }

  func testTry12() {
    assertParsedSource(
      """
      try throw
      """,
      expecting:
        """
        1 │ try throw
          │ │        ╰─ error: expected expression after 'try'
          │ ╰─ error: 'try' must be placed on the thrown expression

        """
    )
  }

  func testTry13() {
    assertParsedSource(
      """
      try return
      """,
      expecting:
        """
        1 │ try return
          │ ╰─ error: 'try' cannot be used with 'return'

        """
    )
  }

  func testTry14() {
    assertParsedSource(
      """
      try throw foo()
      """,
      expecting:
        """
        1 │ try throw foo()
          │ ╰─ error: 'try' must be placed on the thrown expression

        """
    )
  }

  func testTry15() {
    assertParsedSource(
      """
      try return foo()
      """,
      expecting:
        """
        1 │ try return foo()
          │ ╰─ error: 'try' must be placed on the returned expression

        """
    )
  }
}
