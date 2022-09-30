// This test file has been translated from swift/test/Parse/actor.swift

import XCTest

final class ActorTests: XCTestCase {
  func testActor1() {
    AssertParse(
      """
      actor MyActor1#^DIAG^#
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected member block in actor"),
      ]
    )
  }

  func testActor2() {
    AssertParse(
      """
      actor MyActor2 #^NOTE^#{
          init() {
          }
      func hello() { }#^DIAG^#
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '}' to end actor", notes: [
          NoteSpec(message: "to match this opening '{'")
        ]),
      ]
    )
  }
}
