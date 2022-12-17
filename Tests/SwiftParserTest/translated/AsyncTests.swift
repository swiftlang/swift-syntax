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
      """
      func asyncGlobal3() throws1️⃣ async { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' must precede 'throws', Fix-It replacements: 28 - 34 = '', 21 - 21 = 'async '
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testAsync3() {
    AssertParse(
      """
      func asyncGlobal3(fn: () throws -> Int) rethrows1️⃣ async { }
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
        // TODO: Old parser expected error on line 1: 'async' must precede 'rethrows', Fix-It replacements: 50 - 56 = '', 41 - 41 = 'async '
      ]
    )
  }

  func testAsync4() {
    AssertParse(
      """
      func asyncGlobal4() -> Int1️⃣ async { }
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
        // TODO: Old parser expected error on line 1: 'async' may only occur before '->', Fix-It replacements: 28 - 34 = '', 21 - 21 = 'async '
      ]
    )
  }

  func testAsync5() {
    AssertParse(
      """
      func asyncGlobal5() -> Int1️⃣ async throws 2️⃣{ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' may only occur before '->', Fix-It replacements: 28 - 34 = '', 21 - 21 = 'async '
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 34 - 41 = '', 21 - 21 = 'throws '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '->'"),
      ]
    )
  }

  func testAsync6() {
    AssertParse(
      """
      func asyncGlobal6() -> Int 1️⃣throws async { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 28 - 35 = '', 21 - 21 = 'throws '
        // TODO: Old parser expected error on line 1: 'async' may only occur before '->', Fix-It replacements: 35 - 41 = '', 21 - 21 = 'async '
        DiagnosticSpec(message: "extraneous code 'throws async { }' at top level")
      ]
    )
  }

  func testAsync7() {
    AssertParse(
      """
      func asyncGlobal7() throws -> Int1️⃣ async { }
      """,
      diagnostics: [
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
        // TODO: Old parser expected error on line 1: 'async' may only occur before '->', Fix-It replacements: 35 - 41 = '', 21 - 21 = 'async '
      ]
    )
  }

  func testAsync8() {
    AssertParse(
      """
      func asyncGlobal8() async throws1️⃣ async -> 2️⃣async Int async {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'async' may only occur before '->'"),
        // TODO: Old parser expected error on line 1: 'async' has already been specified, Fix-It replacements: 34 - 40 = ''
        // TODO: Old parser expected error on line 1: 'async' has already been specified, Fix-It replacements: 43 - 49 = ''
        // TODO: Old parser expected error on line 1: 'async' has already been specified, Fix-It replacements: 53 - 59 = ''
      ],
      // TODO: This should not insert another 'async'
      fixedSource: """
        func asyncGlobal8() async throws; async async -> Int async {}
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
      """
      typealias AsyncFunc3 = () throws async -> ()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' must precede 'throws', Fix-It replacements: 34 - 40 = '', 27 - 27 = 'async '
      ]
    )
  }

  func testAsync11() {
    AssertParse(
      """
      // Parsing type expressions with 'async'.
      func testTypeExprs() {
        let _ = [() async -> ()]()
        let _ = [() async throws -> ()]()
        let _ = [() throws 1️⃣async -> ()]()
        let _ = [() -> 2️⃣async ()]()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: 'async' must precede 'throws', Fix-It replacements: 22 - 28 = '', 15 - 15 = 'async '
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'async' in array element"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'async' may only occur before '->'"),
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' must be written after the parameter list of a function, Fix-It replacements: 1 - 7 = '', 30 - 30 = ' async'
      ]
    )
  }

}
