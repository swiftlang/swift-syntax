// This test file has been translated from swift/test/Parse/actor.swift

import XCTest

final class ActorTests: XCTestCase {
  func testActor1() {
    AssertParse(
      """
      actor MyActor11️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected member block in actor"),
      ]
    )
  }

  func testActor2() {
    AssertParse(
      """
      actor MyActor2 ℹ️{
          init() {
          }
      func hello() { }1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '}' to end actor", notes: [
          NoteSpec(message: "to match this opening '{'")
        ]),
      ]
    )
  }
}
