// This test file has been translated from swift/test/Parse/actor.swift

import XCTest

final class ActorTests: XCTestCase {
  func testActor1() {
    AssertParse(
      """
      actor MyActor1#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '{' in actor
        DiagnosticSpec(message: "expected member block in actor"),
      ]
    )
  }

  func testActor2() {
    AssertParse(
      """
      actor MyActor2 { 
          init() {
          }
      func hello() { }#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: to match this opening '{'
        DiagnosticSpec(message: "expected '}' to end actor"),
        // TODO: Old parser expected error on line 5: expected '}' in actor
      ]
    )
  }

}
