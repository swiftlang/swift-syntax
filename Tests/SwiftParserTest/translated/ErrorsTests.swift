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

// This test file has been translated from swift/test/Parse/errors.swift

import SwiftSyntax
import XCTest

final class ErrorsTests: ParserTestCase {
  func testErrors1() {
    assertParse(
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
    assertParse(
      """
      func opaque_error() -> Error { return MSV.Foo }
      """
    )
  }

  func testErrors3() {
    assertParse(
      """
      do {
        throw opaque_error()
      } catch MSV.Foo, MSV.CarriesInt(let num) {
      } catch {
      }
      """
    )
  }

  func testErrors4() {
    assertParse(
      """
      func takesAutoclosure(_ fn : @autoclosure () -> Int) {}
      func takesThrowingAutoclosure(_ fn : @autoclosure () throws -> Int) {}
      """
    )
  }

  func testErrors5() {
    assertParse(
      """
      func genError() throws -> Int { throw MSV.Foo }
      func genNoError() -> Int { return 0 }
      """
    )
  }

  func testErrors6() {
    assertParse(
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
    assertParse(
      """
      func illformed() throws {
          do {
            _ = try genError()
          } catch MSV.CarriesInt(let i) where i == genError()1️⃣) {
          }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ')' in 'catch' clause")
      ]
    )
  }

  func testErrors8() {
    assertParse(
      """
      func postThrows() -> Int 1️⃣throws {
        return 5
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'throws' must precede '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: """
        func postThrows() throws -> Int {
          return 5
        }
        """
    )
  }

  func testErrors9() {
    assertParse(
      """
      func postThrows2() -> 1️⃣throws Int {
        return try postThrows()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'throws' must precede '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: """
        func postThrows2() throws -> Int {
          return try postThrows()
        }
        """
    )
  }

  func testErrors10() {
    assertParse(
      """
      func postRethrows(_ f: () throws -> Int) -> Int 1️⃣rethrows {
        return try f()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'rethrows' must precede '->'", fixIts: ["move 'rethrows' in front of '->'"])
      ],
      fixedSource: """
        func postRethrows(_ f: () throws -> Int) rethrows -> Int {
          return try f()
        }
        """
    )
  }

  func testErrors11() {
    assertParse(
      """
      func postRethrows2(_ f: () throws -> Int) -> 1️⃣rethrows Int {
        return try f()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'rethrows' must precede '->'", fixIts: ["move 'rethrows' in front of '->'"])
      ],
      fixedSource: """
        func postRethrows2(_ f: () throws -> Int) rethrows -> Int {
          return try f()
        }
        """
    )
  }

  func testErrors12() {
    assertParse(
      """
      func postThrows3() {
        _ = { () -> Int 1️⃣throws in }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'throws' must precede '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: """
        func postThrows3() {
          _ = { () throws -> Int in }
        }
        """
    )
  }

  func testErrors13() {
    assertParse(
      """
      func dupThrows1() ℹ️throws 1️⃣rethrows -> 2️⃣throws Int 3️⃣throw {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "'rethrows' conflicts with 'throws'",
          notes: [NoteSpec(message: "'throws' declared here")],
          fixIts: ["remove redundant 'rethrows'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "'throws' must precede '->'",
          fixIts: ["remove redundant 'throws'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "'throw' must precede '->'",
          fixIts: ["remove redundant 'throw'"]
        ),
      ],
      fixedSource: """
        func dupThrows1() throws -> Int {}
        """
    )
  }

  func testErrors14() {
    assertParse(
      """
      func dupThrows2(_ f: () throws -> 1️⃣rethrows Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'rethrows' must precede '->'",
          fixIts: ["remove redundant 'rethrows'"]
        )
      ],
      fixedSource: """
        func dupThrows2(_ f: () throws -> Int) {}
        """
    )
  }

  func testErrors15a() {
    assertParse(
      """
      _ = { () 1️⃣try ℹ️throws in }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'try' conflicts with 'throws'",
          notes: [NoteSpec(message: "'throws' declared here")],
          fixIts: ["remove redundant 'try'"]
        )
      ],
      fixedSource: """
        _ = { () throws in }
        """
    )
  }

  func testErrors15b() {
    assertParse(
      """
      _ = { () throws -> Int 1️⃣throws in }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'throws' must precede '->'",
          fixIts: ["remove redundant 'throws'"]
        )
      ],
      fixedSource: """
        _ = { () throws -> Int in }
        """
    )
  }

  func testErrors16() {
    assertParse(
      """
      func incompleteThrowType() {
        let _: () 1️⃣throws
      }
      """,
      substructure: CodeBlockSyntax(
        statements: CodeBlockItemListSyntax([
          CodeBlockItemSyntax(
            item: .decl(
              DeclSyntax(
                VariableDeclSyntax(
                  bindingSpecifier: .keyword(.let),
                  bindings: PatternBindingListSyntax([
                    PatternBindingSyntax(
                      pattern: WildcardPatternSyntax(),
                      typeAnnotation: TypeAnnotationSyntax(
                        type: TupleTypeSyntax(elements: TupleTypeElementListSyntax([]))
                      )
                    )
                  ])
                )
              )
            )
          )
        ]),
        UnexpectedNodesSyntax([TokenSyntax.keyword(.throws)])
      ),
      diagnostics: [
        DiagnosticSpec(message: "unexpected 'throws' keyword in function")
      ]
    )
  }

  func testErrors17a() {
    // rdar://21328447
    assertParse(
      """
      func fixitThrow0() 1️⃣throw {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'throw' with 'throws'"]
        )
      ],
      fixedSource: """
        func fixitThrow0() throws {}
        """
    )
  }

  func testErrors17b() {
    assertParse(
      """
      func fixitThrow1() 1️⃣throw -> Int {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'throw' with 'throws'"]
        )
      ],
      fixedSource: """
        func fixitThrow1() throws -> Int {}
        """
    )
  }

  func testErrors17c() {
    assertParse(
      """
      func fixitThrow2() throws {
        var _: (Int)
        throw MSV.Foo
        var _: (Int) 1️⃣throw -> Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'throw' with 'throws'"]
        )
      ],
      fixedSource: """
        func fixitThrow2() throws {
          var _: (Int)
          throw MSV.Foo
          var _: (Int) throws -> Int
        }
        """
    )
  }

  func testErrors18() {
    assertParse(
      """
      let fn: () -> 1️⃣throws Void
      """,
      diagnostics: [
        DiagnosticSpec(message: "'throws' must precede '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: """
        let fn: () throws -> Void
        """
    )
  }

  func testErrors19() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/53979
      """
    )
  }

  func testErrors20() {
    assertParse(
      """
      func fixitTry0<T>(a: T) 1️⃣try where T:ExpressibleByStringLiteral {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        )
      ],
      fixedSource: """
        func fixitTry0<T>(a: T) throws where T:ExpressibleByStringLiteral {}
        """
    )
  }

  func testErrors21() {
    assertParse(
      """
      func fixitTry1<T>(a: T) 1️⃣try {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        )
      ],
      fixedSource: """
        func fixitTry1<T>(a: T) throws {}
        """
    )
  }

  func testErrors22() {
    assertParse(
      """
      func fixitTry2() 1️⃣try {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        )
      ],
      fixedSource: """
        func fixitTry2() throws {}
        """
    )
  }

  func testErrors23() {
    assertParse(
      """
      let fixitTry3 : () 1️⃣try -> Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected throwing specifier; did you mean 'throws'?",
          fixIts: ["replace 'try' with 'throws'"]
        )
      ],
      fixedSource: """
        let fixitTry3 : () throws -> Int
        """
    )
  }

  func testErrors24() {
    assertParse(
      """
      func fixitAwait0() 1️⃣await { }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'await' with 'async'"]
        )
      ],
      fixedSource: """
        func fixitAwait0() async { }
        """
    )
  }

  func testErrors25() {
    assertParse(
      """
      func fixitAwait1() 1️⃣await -> Int { }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected async specifier; did you mean 'async'?",
          fixIts: ["replace 'await' with 'async'"]
        )
      ],
      fixedSource: """
        func fixitAwait1() async -> Int { }
        """
    )
  }

  func testErrors26() {
    assertParse(
      """
      func fixitAwait2() throws 1️⃣await -> Int { }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'await' must precede 'throws'",
          fixIts: ["move 'await' in front of 'throws'"]
        )
      ],
      fixedSource: """
        func fixitAwait2() async throws -> Int { }
        """
    )
  }

  func testErrors27() {
    assertParse(
      """
      do {
        true ? () : 1️⃣throw opaque_error()
      } catch _ {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after ternary operator", fixIts: ["insert expression"])
      ],
      fixedSource: """
        do {
          true ? () : <#expression#>throw opaque_error()
        } catch _ {
        }
        """
    )
  }

  func testErrors28() {
    assertParse(
      """
      do {
      } catch {
        let error2 = error
      }
      """
    )
  }

  func testErrors29() {
    assertParse(
      """
      do {
      } catch where true {
        let error2 = error
      } catch {
      }
      """
    )
  }

  // <rdar://problem/20985280> QoI: improve diagnostic on improper pattern match on type
  func testErrors30() {
    assertParse(
      """
      do {
        throw opaque_error()
      } catch MSV {
      } catch {
      }
      """
    )
  }

  func testErrors31() {
    assertParse(
      """
      do {
        throw opaque_error()
      } catch is Error {
      }
      """
    )
  }

  func testErrors32() {
    assertParse(
      """
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
      """
    )
  }

  func testAwaitBetwenAsyncAndThrows() {
    assertParse(
      """
      func fixitAwait2() ℹ️async 1️⃣await throws -> Int { }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'await' conflicts with 'async'",
          notes: [NoteSpec(message: "'async' declared here")],
          fixIts: ["remove redundant 'await'"]
        )
      ],
      fixedSource: """
        func fixitAwait2() async throws -> Int { }
        """
    )
  }

  func testAsyncAwait() {
    assertParse(
      """
      func fixitAwait2() ℹ️async 1️⃣await -> Int { }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "'await' conflicts with 'async'",
          notes: [NoteSpec(message: "'async' declared here")],
          fixIts: ["remove redundant 'await'"]
        )
      ],
      fixedSource: """
        func fixitAwait2() async -> Int { }
        """
    )
  }
}
