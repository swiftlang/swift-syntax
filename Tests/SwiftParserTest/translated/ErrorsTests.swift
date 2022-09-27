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
          true ? () : #^DIAG_1^#throw opaque_error() 
        } catch _ {
        }
        do {
        } catch { 
          let error2 = error
        }
        do {
        } catch #^DIAG_2^#where true { 
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
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in 'do' statement"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in pattern"),
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
          } catch MSV.CarriesInt(let i) where i == genError()#^DIAG^#) { 
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: expected '{'
        DiagnosticSpec(message: "unexpected text ')' in 'catch' clause"),
      ]
    )
  }

  func testErrors8() {
    AssertParse(
      """
      func postThrows() -> Int #^DIAG^#throws { 
        return 5
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 19 - 19 = 'throws ', 26 - 33 = ''
        DiagnosticSpec(message: "extraneous code at top level"),
      ]
    )
  }

  func testErrors9() {
    AssertParse(
      """
      func postThrows2() -> #^DIAG^#throws Int { 
        return try postThrows()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 20 - 20 = 'throws ', 23 - 30 = ''
        DiagnosticSpec(message: "'throws' may only occur before '->'"),
      ]
    )
  }

  func testErrors10() {
    AssertParse(
      """
      func postRethrows(_ f: () throws -> Int) -> Int #^DIAG^#rethrows { 
        return try f()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'rethrows' may only occur before '->', Fix-It replacements: 42 - 42 = 'rethrows ', 49 - 58 = ''
        DiagnosticSpec(message: "extraneous code at top level"),
      ]
    )
  }

  func testErrors11() {
    AssertParse(
      """
      func postRethrows2(_ f: () throws -> Int) #^DIAG_1^#-> #^DIAG_2^#rethrows Int { 
        return try f()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'rethrows' may only occur before '->', Fix-It replacements: 43 - 43 = 'rethrows ', 46 - 55 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected 'rethrows' in function signature"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text 'rethrows' in function signature"),
      ]
    )
  }

  func testErrors12() {
    AssertParse(
      """
      func postThrows3() {
        _ = { () -> Int #^DIAG^#throws in } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'throws' may only occur before '->', Fix-It replacements: 19 - 26 = '', 12 - 12 = 'throws '
        DiagnosticSpec(message: "expected 'in' in closure signature"),
        DiagnosticSpec(message: "unexpected text 'throws in' in closure"),
      ]
    )
  }

  func testErrors13() {
    AssertParse(
      """
      func dupThrows1() throws #^DIAG^#rethrows -> throws Int throw {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'rethrows' has already been specified, Fix-It replacements: 26 - 35 = ''
        // TODO: Old parser expected error on line 1: 'throws' has already been specified, Fix-It replacements: 38 - 45 = ''
        // TODO: Old parser expected error on line 1: 'throw' has already been specified, Fix-It replacements: 49 - 55 = ''
        DiagnosticSpec(message: "extraneous 'rethrows -> throws Int throw {}' at top level"),
      ]
    )
  }

  func testErrors14() {
    AssertParse(
      """
      func dupThrows2(_ f: () throws -> #^DIAG^#rethrows Int) {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'rethrows' has already been specified, Fix-It replacements: 35 - 44 = ''
        DiagnosticSpec(message: "expected type in function type"),
        DiagnosticSpec(message: "unexpected text 'rethrows Int' in parameter clause"),
      ]
    )
  }

  func testErrors15() {
    AssertParse(
      """
      func dupThrows3() {
        _ = { () try throws in }
        _ = { () throws -> Int #^DIAG^#throws in }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 12 - 15 = 'throws'
        // TODO: Old parser expected error on line 2: 'throws' has already been specified, Fix-It replacements: 16 - 23 = ''
        // TODO: Old parser expected error on line 3: 'throws' has already been specified, Fix-It replacements: 26 - 33 = ''
        DiagnosticSpec(message: "expected 'in' in closure signature"),
        DiagnosticSpec(message: "unexpected text 'throws in' in closure"),
      ]
    )
  }

  func testErrors16() {
    AssertParse(
      """
      func incompleteThrowType() {
        // FIXME: Bad recovery for incomplete function type.
        let _: () #^DIAG^#throws
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 3: expected expression
        DiagnosticSpec(message: "unexpected text 'throws' in function"),
      ]
    )
  }

  func testErrors17() {
    AssertParse(
      """
      // rdar://21328447
      func fixitThrow0() throw {} 
      func fixitThrow1() throw #^DIAG^#-> Int {} 
      func fixitThrow2() throws {
        var _: (Int)
        throw MSV.Foo
        var _: (Int) throw -> Int 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 20 - 25 = 'throws'
        // TODO: Old parser expected error on line 3: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 20 - 25 = 'throws'
        DiagnosticSpec(message: "expected expression in 'throw' statement"),
        DiagnosticSpec(message: "unexpected text '-> Int {}' before function"),
        // TODO: Old parser expected error on line 7: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 16 - 21 = 'throws'
      ]
    )
  }

  func testErrors18() {
    AssertParse(
      """
      let fn: () -> #^DIAG^#throws Void
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'throws' may only occur before '->', Fix-It replacements: 12 - 12 = 'throws ', 15 - 22 = ''
        DiagnosticSpec(message: "expected type in function type"),
        DiagnosticSpec(message: "extraneous 'throws Void' at top level"),
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
      func fixitTry0<T>(a: T) try #^DIAG^#where T:ExpressibleByStringLiteral {} 
      func fixitTry1<T>(a: T) try {} 
      func fixitTry2() try {} 
      let fixitTry3 : () try -> Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 25 - 28 = 'throws'
        DiagnosticSpec(message: "expected expression in 'try' expression"),
        DiagnosticSpec(message: "unexpected text 'where T:ExpressibleByStringLiteral {}' before function"),
        // TODO: Old parser expected error on line 2: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 25 - 28 = 'throws'
        // TODO: Old parser expected error on line 3: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 18 - 21 = 'throws'
        // TODO: Old parser expected error on line 4: expected throwing specifier; did you mean 'throws'?, Fix-It replacements: 20 - 23 = 'throws'
      ]
    )
  }

  func testErrors21() {
    AssertParse(
      """
      func fixitAwait0() await { } 
      func fixitAwait1() await #^DIAG_1^#-> Int { } 
      func fixitAwait2() throws await #^DIAG_2^#-> Int { }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected async specifier; did you mean 'async'?, Fix-It replacements: 20 - 25 = 'async'
        // TODO: Old parser expected error on line 2: expected async specifier; did you mean 'async'?, Fix-It replacements: 20 - 25 = 'async'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in 'await' expression"),
        // TODO: Old parser expected error on line 3: expected async specifier; did you mean 'async'?, Fix-It replacements: 27 - 32 = 'async'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in 'await' expression"),
      ]
    )
  }

}
