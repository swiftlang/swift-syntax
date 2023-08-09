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

final class ActorTests: ParserTestCase {
  func testActor1() {
    assertParse(
      """
      actor MyActor11️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected member block in actor",
          fixIts: ["insert member block"]
        )
      ],
      fixedSource: """
        actor MyActor1 {
        }
        """
    )
  }

  func testActor2() {
    assertParse(
      """
      actor MyActor2 ℹ️{
          init() {
          }
      func hello() { }1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '}' to end actor",
          notes: [
            NoteSpec(message: "to match this opening '{'")
          ],
          fixIts: ["insert '}'"]
        )
      ],
      fixedSource: """
        actor MyActor2 {
            init() {
            }
        func hello() { }
        }
        """
    )
  }
}
