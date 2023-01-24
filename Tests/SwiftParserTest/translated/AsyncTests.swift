//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
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
    AssertParse(
      """
      // Parsing function declarations with 'async'
      func asyncGlobal1() async { }
      func asyncGlobal2() async throws { }
      """
    )
  }

  func testAsync2() {
    AssertParse(
      "func asyncGlobal3() throws 1️⃣async { }",
      diagnostics: [
        DiagnosticSpec(message: "'async' must precede 'throws'", fixIts: ["move 'async' in front of 'throws'"])
      ],
      fixedSource: "func asyncGlobal3() async throws { }"
    )
  }

  func testAsync3() {
    AssertParse(
      "func asyncGlobal3(fn: () throws -> Int) rethrows 1️⃣async { }",
      diagnostics: [
        DiagnosticSpec(message: "'async' must precede 'rethrows'", fixIts: ["move 'async' in front of 'rethrows'"])
      ],
      fixedSource: "func asyncGlobal3(fn: () throws -> Int) async rethrows { }"
    )
  }

  func testAsync4() {
    AssertParse(
      "func asyncGlobal4() -> Int 1️⃣async { }",
      diagnostics: [
        DiagnosticSpec(message: "'async' must preceed '->'", fixIts: ["move 'async' in front of '->'"])
      ],
      fixedSource: "func asyncGlobal4() async -> Int { }"
    )
  }

  func testAsync5() {
    AssertParse(
      "func asyncGlobal5() -> Int 1️⃣async throws { }",
      diagnostics: [
        DiagnosticSpec(message: "'async throws' must preceed '->'")
      ],
      fixedSource: "func asyncGlobal5() async throws -> Int { }"
    )
  }

  func testAsync6() {
    AssertParse(
      "func asyncGlobal6() -> Int 1️⃣throws async { }",
      diagnostics: [
        DiagnosticSpec(message: "'throws async' must preceed '->'", fixIts: ["move 'throws async' in front of '->'"])
      ],
      fixedSource: "func asyncGlobal6() async throws -> Int { }"
    )
  }

  func testAsync7() {
    AssertParse(
      "func asyncGlobal7() throws -> Int 1️⃣async { }",
      diagnostics: [
        DiagnosticSpec(message: "'async' must preceed '->'")
      ],
      fixedSource: "func asyncGlobal7() async throws -> Int { }"
    )
  }

  func testAsync8() {
    AssertParse(
      """
      func asyncGlobal8() async throws 1️⃣async -> 2️⃣async Int 3️⃣async {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "'async' has already been specified", fixIts: ["remove redundant 'async'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'async' must preceed '->'", fixIts: ["remove redundant 'async'"]),
        DiagnosticSpec(locationMarker: "3️⃣", message: "'async' must preceed '->'", fixIts: ["remove redundant 'async'"]),
      ],
      fixedSource: """
        func asyncGlobal8() async throws -> Int {}
        """
    )
  }

  func testAsync9() {
    AssertParse(
      """
      class X {
        init() async { }
        deinit 1️⃣async { }
        func f() async { }
        subscript(x: Int) 2️⃣async -> Int {
          get {
            return 0
          }
          set async { 
          }
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "deinitializers cannot have a name"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'async' in subscript"),
      ]
    )
  }

  func testAsync10a() {
    AssertParse(
      """
      typealias AsyncFunc1 = () async -> ()
      """
    )
  }

  func testAsync10b() {
    AssertParse(
      """
      typealias AsyncFunc2 = () async throws -> ()
      """
    )
  }

  func testAsync10c() {
    AssertParse(
      "typealias AsyncFunc3 = () throws 1️⃣async -> ()",
      diagnostics: [
        DiagnosticSpec(message: "'async' must precede 'throws'")
      ],
      fixedSource: "typealias AsyncFunc3 = () async throws -> ()"
    )
  }

  func testAsync11a() {
    AssertParse(
      """
      let _ = [() async -> ()]()
      """
    )
  }

  func testAsync11b() {
    AssertParse(
      """
      let _ = [() async throws -> ()]()
      """
    )
  }

  func testAsync11c() {
    AssertParse(
      "let _ = [() throws 1️⃣async -> ()]()",
      diagnostics: [
        DiagnosticSpec(message: "'async' must precede 'throws'")
      ],
      fixedSource: "let _ = [() async throws -> ()]()"
    )
  }

  func testAsync11d() {
    AssertParse(
      """
      let _ = [() -> 1️⃣async ()]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "'async' must preceed '->'")
      ]
    )
  }

  func testAsync12() {
    AssertParse(
      """
      // Parsing await syntax.
      struct MyFuture {
        func await() -> Int { 0 }
      }
      """
    )
  }

  func testAsync13() {
    AssertParse(
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
    AssertParse(
      """
      func getIntSomeday() async -> Int { 5 }
      """
    )
  }

  func testAsync15() {
    AssertParse(
      """
      func testAsyncLet() async {
        async let x = await getIntSomeday()
        _ = await x
      }
      """
    )
  }

  func testAsync16() {
    AssertParse(
      """
      async func asyncIncorrectly() { }
      """
    )
  }
}
