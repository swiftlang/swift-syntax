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

final class AsyncTests: ParserTestCase {
  func testAsync1() {
    assertParse(
      """
      // Parsing function declarations with 'async'
      func asyncGlobal1() async { }
      func asyncGlobal2() async throws { }
      """
    )
  }

  func testAsync2() {
    assertParse(
      "func asyncGlobal3() throws 1️⃣async { }",
      diagnostics: [
        DiagnosticSpec(
          message: "'async' must precede 'throws'",
          fixIts: ["move 'async' in front of 'throws'"]
        )
      ],
      fixedSource: "func asyncGlobal3() async throws { }"
    )
  }

  func testAsync3() {
    assertParse(
      "func asyncGlobal3(fn: () throws -> Int) rethrows 1️⃣async { }",
      diagnostics: [
        DiagnosticSpec(
          message: "'async' must precede 'rethrows'",
          fixIts: ["move 'async' in front of 'rethrows'"]
        )
      ],
      fixedSource: "func asyncGlobal3(fn: () throws -> Int) async rethrows { }"
    )
  }

  func testAsync4() {
    assertParse(
      "func asyncGlobal4() -> Int 1️⃣async { }",
      diagnostics: [
        DiagnosticSpec(
          message: "'async' must precede '->'",
          fixIts: ["move 'async' in front of '->'"]
        )
      ],
      fixedSource: "func asyncGlobal4() async -> Int { }"
    )
  }

  func testAsync5() {
    assertParse(
      "func asyncGlobal5() -> Int 1️⃣async throws { }",
      diagnostics: [
        DiagnosticSpec(
          message: "'async throws' must precede '->'",
          fixIts: ["move 'async throws' in front of '->'"]
        )
      ],
      fixedSource: "func asyncGlobal5() async throws -> Int { }"
    )
  }

  func testAsync6() {
    assertParse(
      "func asyncGlobal6() -> Int 1️⃣throws async { }",
      diagnostics: [
        DiagnosticSpec(
          message: "'throws async' must precede '->'",
          fixIts: ["move 'throws async' in front of '->'"]
        )
      ],
      fixedSource: "func asyncGlobal6() async throws -> Int { }"
    )
  }

  func testAsync7() {
    assertParse(
      "func asyncGlobal7() throws -> Int 1️⃣async { }",
      diagnostics: [
        DiagnosticSpec(
          message: "'async' must precede '->'",
          fixIts: ["move 'async' in front of '->'"]
        )
      ],
      fixedSource: "func asyncGlobal7() async throws -> Int { }"
    )
  }

  func testAsync8() {
    assertParse(
      """
      func asyncGlobal8() ℹ️async throws 1️⃣async -> 2️⃣async Int 3️⃣async {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "'async' has already been specified",
          notes: [NoteSpec(message: "'async' declared here")],
          fixIts: ["remove redundant 'async'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "'async' must precede '->'",
          fixIts: ["remove redundant 'async'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "'async' must precede '->'",
          fixIts: ["remove redundant 'async'"]
        ),
      ],
      fixedSource: """
        func asyncGlobal8() async throws -> Int {}
        """
    )
  }

  func testAsync9() {
    assertParse(
      """
      class X {
        init() async { }
        deinit async { }
        func f() async { }
        subscript(x: Int) 1️⃣async -> Int {
          get {
            return 0
          }
          set async {
          }
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'async' in subscript")
      ]
    )
  }

  func testAsync10a() {
    assertParse(
      """
      typealias AsyncFunc1 = () async -> ()
      """
    )
  }

  func testAsync10b() {
    assertParse(
      """
      typealias AsyncFunc2 = () async throws -> ()
      """
    )
  }

  func testAsync10c() {
    assertParse(
      "typealias AsyncFunc3 = () throws 1️⃣async -> ()",
      diagnostics: [
        DiagnosticSpec(
          message: "'async' must precede 'throws'",
          fixIts: ["move 'async' in front of 'throws'"]
        )
      ],
      fixedSource: "typealias AsyncFunc3 = () async throws -> ()"
    )
  }

  func testAsync11a() {
    assertParse(
      """
      let _ = [() async -> ()]()
      """
    )
  }

  func testAsync11b() {
    assertParse(
      """
      let _ = [() async throws -> ()]()
      """
    )
  }

  func testAsync11c() {
    assertParse(
      "let _ = [() throws 1️⃣async -> ()]()",
      diagnostics: [
        DiagnosticSpec(
          message: "'async' must precede 'throws'",
          fixIts: ["move 'async' in front of 'throws'"]
        )
      ],
      fixedSource: "let _ = [() async throws -> ()]()"
    )
  }

  func testAsync11d() {
    assertParse(
      """
      let _ = [() -> 1️⃣async ()]()
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'async' must precede '->'",
          fixIts: ["move 'async' in front of '->'"]
        )
      ],
      fixedSource: """
        let _ = [() async -> ()]()
        """
    )
  }

  func testAsync12() {
    assertParse(
      """
      // Parsing await syntax.
      struct MyFuture {
        func await() -> Int { 0 }
      }
      """
    )
  }

  func testAsync13() {
    assertParse(
      """
      func testAwaitExpr() async {
        let _ = await asyncGlobal1()
        let myFuture = MyFuture()
        let _ = myFuture.await()
      }
      """
    )
  }

  func testAsync14() {
    assertParse(
      """
      func getIntSomeday() async -> Int { 5 }
      """
    )
  }

  func testAsync15() {
    assertParse(
      """
      func testAsyncLet() async {
        async let x = await getIntSomeday()
        _ = await x
      }
      """
    )
  }

  func testAsync16() {
    assertParse(
      """
      async func asyncIncorrectly() { }
      """
    )
  }
}
