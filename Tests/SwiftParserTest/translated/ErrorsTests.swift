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

// This test file has been translated from swift/test/Parse/errors.swift

import XCTest

final class ErrorsTests: XCTestCase {
  func testErrors1() {
    AssertParse(
      #"""
      enum MSV : Error {
        case Foo, Bar, Baz
        case CarriesInt(Int)
        var _domain: String { return "" }
        var _code: Int { return 0 }
      }
      """#
    )
  }

  func testErrors2() {
    AssertParse(
      """
      func opaque_error() -> Error { return MSV.Foo }
      """
    )
  }

  func testErrors3() {
    AssertParse(
      """
      func one() {
        do {
          true ? () : 1️⃣throw opaque_error()
        } catch _ {
        }
        do {
        } catch { 
          let error2 = error
        }
        do {
        } catch 2️⃣where true {
          let error2 = error
        } catch {
        }
        // <rdar://problem/20985280> QoI: improve diagnostic on improper pattern match on type
        do {
          throw opaque_error()
        } catch MSV { 
        } catch {
        }
        do {
          throw opaque_error()
        } catch is Error {  
        }
        func foo() throws {}
        do {
      #if false
          try foo()
      #endif
        } catch {    // don't warn, #if code should be scanned.
        }
        do {
      #if false
          throw opaque_error()
      #endif
        } catch {    // don't warn, #if code should be scanned.
        }
        do {
          throw opaque_error()
        } catch MSV.Foo, MSV.CarriesInt(let num) { 
        } catch {
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected expression after '? ... :' in ternary expression
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in 'do' statement")
      ]
    )
  }

  func testErrors4() {
    AssertParse(
      """
      func takesAutoclosure(_ fn : @autoclosure () -> Int) {}
      func takesThrowingAutoclosure(_ fn : @autoclosure () throws -> Int) {}
      """
    )
  }

  func testErrors5() {
    AssertParse(
      """
      func genError() throws -> Int { throw MSV.Foo }
      func genNoError() -> Int { return 0 }
      """
    )
  }

  func testErrors6() {
    AssertParse(
      """
      func testAutoclosures() throws {
        takesAutoclosure(genError()) 
        takesAutoclosure(genNoError())
        try takesAutoclosure(genError()) 
        try takesAutoclosure(genNoError()) 
        takesAutoclosure(try genError()) 
        takesAutoclosure(try genNoError()) 
        takesThrowingAutoclosure(try genError())
        takesThrowingAutoclosure(try genNoError()) 
        try takesThrowingAutoclosure(genError())
        try takesThrowingAutoclosure(genNoError()) 
        takesThrowingAutoclosure(genError()) 
        takesThrowingAutoclosure(genNoError())
      }
      """
    )
  }

  func testErrors7() {
    AssertParse(
      """
      func illformed() throws {
          do {
            _ = try genError()
          } catch MSV.CarriesInt(let i) where i == genError()1️⃣) { 
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: expected '{'
        DiagnosticSpec(message: "unexpected code ')' in 'catch' clause")
      ]
    )
  }

  func testErrors8() {
    AssertParse(
      """
      func postThrows() -> Int 1️⃣throws { 
        return 5
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 19 - 19 = 'throws ', 26 - 33 = ''
        DiagnosticSpec(message: "extraneous code at top level")
      ]
    )
  }

  func testErrors9() {
    AssertParse(
      """
      func postThrows2() -> 1️⃣throws Int { 
        return try postThrows()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 20 - 20 = 'throws ', 23 - 30 = ''
        DiagnosticSpec(message: "'throws' may only occur before '->'")
      ]
    )
  }

  func testErrors10() {
    AssertParse(
      """
      func postRethrows(_ f: () throws -> Int) -> Int 1️⃣rethrows { 
        return try f()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'rethrows' may only occur before '->', Fix-It replacements: 42 - 42 = 'rethrows ', 49 - 58 = ''
        DiagnosticSpec(message: "extraneous code at top level")
      ]
    )
  }

  func testErrors11() {
    AssertParse(
      """
      func postRethrows2(_ f: () throws -> Int) 1️⃣-> 2️⃣rethrows Int { 
        return try f()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'rethrows' may only occur before '->', Fix-It replacements: 43 - 43 = 'rethrows ', 46 - 55 = ''
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'rethrows' in function signature"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected 'rethrows' keyword in function signature"),
      ]
    )
  }

  func testErrors12() {
    AssertParse(
      """
      func postThrows3() {
        _ = { () -> Int 1️⃣throws in } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'throws' may only occur before '->', Fix-It replacements: 19 - 26 = '', 12 - 12 = 'throws '
        DiagnosticSpec(message: "expected 'in' in closure signature"),
        DiagnosticSpec(message: "unexpected code 'throws in' in closure"),
      ]
    )
  }

  func testErrors13() {
    AssertParse(
      """
      func dupThrows1() throws 1️⃣rethrows -> throws Int throw {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'rethrows' has already been specified, Fix-It replacements: 26 - 35 = ''
        // TODO: Old parser expected error on line 1: 'throws' has already been specified, Fix-It replacements: 38 - 45 = ''
        // TODO: Old parser expected error on line 1: 'throw' has already been specified, Fix-It replacements: 49 - 55 = ''
        DiagnosticSpec(message: "extraneous code 'rethrows -> throws Int throw {}' at top level")
      ]
    )
  }

  func testErrors14() {
    AssertParse(
      """
      func dupThrows2(_ f: () throws -> 1️⃣rethrows Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'rethrows' has already been specified, Fix-It replacements: 35 - 44 = ''
        DiagnosticSpec(message: "expected type in function type"),
        DiagnosticSpec(message: "unexpected code 'rethrows Int' in parameter clause"),
      ]
    )
  }

  func testErrors15() {
    AssertParse(
      """
      func dupThrows3() {
        _ = { () try throws in }
        _ = { () throws -> Int 1️⃣throws in }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 12 - 15 = 'throws'
        // TODO: Old parser expected error on line 2: 'throws' has already been specified, Fix-It replacements: 16 - 23 = ''
        // TODO: Old parser expected error on line 3: 'throws' has already been specified, Fix-It replacements: 26 - 33 = ''
        DiagnosticSpec(message: "expected 'in' in closure signature"),
        DiagnosticSpec(message: "unexpected code 'throws in' in closure"),
      ]
    )
  }

  func testErrors16() {
    AssertParse(
      """
      func incompleteThrowType() {
        // FIXME: Bad recovery for incomplete function type.
        let _: () 1️⃣throws
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 3: expected expression
        DiagnosticSpec(message: "unexpected 'throws' keyword in function")
      ]
    )
  }

  func testErrors17() {
    AssertParse(
      """
      // rdar://21328447
      func fixitThrow0()1️⃣ throw {}
      func fixitThrow1()2️⃣ throw 3️⃣-> Int {}
      func fixitThrow2() throws {
        var _: (Int)
        throw MSV.Foo
        var _: (Int) throw -> Int 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 20 - 25 = 'throws'
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        // TODO: Old parser expected error on line 3: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 20 - 25 = 'throws'
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression in 'throw' statement"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code '-> Int {}' before function"),
        // TODO: Old parser expected error on line 7: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 16 - 21 = 'throws'
      ]
    )
  }

  func testErrors18() {
    AssertParse(
      """
      let fn: () -> 1️⃣throws Void
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 12 - 12 = 'throws ', 15 - 22 = ''
        DiagnosticSpec(message: "expected type in function type"),
        DiagnosticSpec(message: "extraneous code 'throws Void' at top level"),
      ]
    )
  }

  func testErrors19() {
    AssertParse(
      """
      // https://github.com/apple/swift/issues/53979
      """
    )
  }

  func testErrors20() {
    AssertParse(
      """
      func fixitTry0<T>(a: T)1️⃣ try 2️⃣where T:ExpressibleByStringLiteral {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 25 - 28 = 'throws'
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression after 'try'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code 'where T:ExpressibleByStringLiteral {}' at top level"),
      ]
    )
  }

  func testErrors21() {
    AssertParse(
      """
      func fixitTry1<T>(a: T)1️⃣ try {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 25 - 28 = 'throws'
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testErrors22() {
    AssertParse(
      """
      func fixitTry2()1️⃣ try {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 18 - 21 = 'throws'
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testErrors23() {
    AssertParse(
      """
      let fixitTry3 : () try -> Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 20 - 23 = 'throws'
      ]
    )
  }

  func testErrors24() {
    AssertParse(
      """
      func fixitAwait0()1️⃣ await { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected async specifier; did you mean 'async'?, Fix-It replacements: 20 - 25 = 'async'
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testErrors25() {
    AssertParse(
      """
      func fixitAwait1()1️⃣ await 2️⃣-> Int { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected async specifier; did you mean 'async'?, Fix-It replacements: 20 - 25 = 'async'
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'await' expression"),
      ]
    )
  }

  func testErrors26() {
    AssertParse(
      """
      func fixitAwait2() throws1️⃣ await 2️⃣-> Int { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected async specifier; did you mean 'async'?, Fix-It replacements: 27 - 32 = 'async'
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'await' expression"),
      ]
    )
  }
}
