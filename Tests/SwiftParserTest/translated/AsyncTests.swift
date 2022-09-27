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
      func asyncGlobal3() throws async { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' must precede 'throws', Fix-It replacements: 28 - 34 = '', 21 - 21 = 'async '
      ]
    )
  }

  func testAsync3() {
    AssertParse(
      """
      func asyncGlobal3(fn: () throws -> Int) rethrows async { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' must precede 'rethrows', Fix-It replacements: 50 - 56 = '', 41 - 41 = 'async '
      ]
    )
  }

  func testAsync4() {
    AssertParse(
      """
      func asyncGlobal4() -> Int async { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' may only occur before '->', Fix-It replacements: 28 - 34 = '', 21 - 21 = 'async '
      ]
    )
  }

  func testAsync5() {
    AssertParse(
      """
      func asyncGlobal5() -> Int async throws #^DIAG^#{ }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' may only occur before '->', Fix-It replacements: 28 - 34 = '', 21 - 21 = 'async '
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 34 - 41 = '', 21 - 21 = 'throws '
        DiagnosticSpec(message: "expected '->'"),
      ]
    )
  }

  func testAsync6() {
    AssertParse(
      """
      func asyncGlobal6() -> Int #^DIAG^#throws async { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 28 - 35 = '', 21 - 21 = 'throws '
        // TODO: Old parser expected error on line 1: 'async' may only occur before '->', Fix-It replacements: 35 - 41 = '', 21 - 21 = 'async '
        DiagnosticSpec(message: "extraneous 'throws async { }' at top level"),
      ]
    )
  }

  func testAsync7() {
    AssertParse(
      """
      func asyncGlobal7() throws -> Int async { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' may only occur before '->', Fix-It replacements: 35 - 41 = '', 21 - 21 = 'async '
      ]
    )
  }

  func testAsync8() {
    AssertParse(
      """
      func asyncGlobal8() async throws async -> async Int async {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'async' has already been specified, Fix-It replacements: 34 - 40 = ''
        // TODO: Old parser expected error on line 1: 'async' has already been specified, Fix-It replacements: 43 - 49 = ''
        // TODO: Old parser expected error on line 1: 'async' has already been specified, Fix-It replacements: 53 - 59 = ''
      ]
    )
  }

  func testAsync9() {
    AssertParse(
      """
      class X {
        init() async { }
        deinit async #^DIAG_1^#{ } 
        func f() async { }
        subscript(x: Int) #^DIAG_2^#async #^DIAG_3^#-> Int { 
          get {
            return 0
          }
          set async { 
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: deinitializers cannot have a name
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '{ }' in function"),
        // TODO: Old parser expected error on line 5: expected '->' for subscript element type
        // TODO: Old parser expected error on line 5: single argument function types require parentheses
        // TODO: Old parser expected error on line 5: cannot find type 'async' in scope
        // TODO: Old parser expected note on line 5: cannot use module 'async' as a type
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '->' and return type in subscript"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected declaration after 'async' modifier in class"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text in class"),
        // TODO: Old parser expected error on line 9: 'set' accessor cannot have specifier 'async'
      ]
    )
  }

  func testAsync10() {
    AssertParse(
      """
      // Parsing function types with 'async'.
      typealias AsyncFunc1 = () async -> ()
      typealias AsyncFunc2 = () async throws -> ()
      typealias AsyncFunc3 = () throws async -> ()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'async' must precede 'throws', Fix-It replacements: 34 - 40 = '', 27 - 27 = 'async '
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
        let _ = [() throws #^DIAG^#async -> ()]()  
        let _ = [() -> async ()]() 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: 'async' must precede 'throws', Fix-It replacements: 22 - 28 = '', 15 - 15 = 'async '
        DiagnosticSpec(message: "unexpected text 'async' in array element"),
        // TODO: Old parser expected error on line 6: 'async' may only occur before '->', Fix-It replacements: 18 - 24 = '', 15 - 15 = 'async '
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
