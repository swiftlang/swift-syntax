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

// This test file has been translated from swift/test/Parse/actor.swift

import XCTest

final class ActorTests: XCTestCase {
  func testActor1() {
    assertParsedSource(
      """
      actor MyActor1
      """,
      expecting:
        """
        1 │ actor MyActor1
          │               ╰─ error: expected member block in actor

        """
    )
  }

  func testActor2() {
    assertParsedSource(
      """
      actor MyActor2 {
          init() {
          }
      func hello() { }
      """,
      expecting:
        """
        1 │ actor MyActor2 {
          │                ╰─ note: to match this opening '{'
        2 │     init() {
        3 │     }
        4 │ func hello() { }
          │                 ╰─ error: expected '}' to end actor

        """
    )
  }
}
