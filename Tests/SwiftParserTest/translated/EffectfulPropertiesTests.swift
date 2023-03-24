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

// This test file has been translated from swift/test/Parse/effectful_properties.swift

import XCTest

final class EffectfulPropertiesTests: XCTestCase {
  func testEffectfulProperties1() {
    assertParse(
      """
      struct MyProps {
        var prop1 : Int {
          get async { }
        }
        var prop2 : Int {
          get throws { }
        }
        var prop3 : Int {
          get async throws { }
        }
        var prop1mut : Int {
          mutating get async { }
        }
        var prop2mut : Int {
          mutating get throws { }
        }
        var prop3mut : Int {
          mutating get async throws { }
        }
      }
      """
    )
  }

  func testEffectfulProperties2() {
    assertParse(
      """
      struct X1 {
        subscript(_ i : Int) -> Int {
            get async {}
          }
      }
      """
    )
  }

  func testEffectfulProperties3() {
    assertParse(
      """
      class X2 {
        subscript(_ i : Int) -> Int {
            get throws {}
          }
      }
      """
    )
  }

  func testEffectfulProperties4() {
    assertParse(
      """
      struct X3 {
        subscript(_ i : Int) -> Int {
            get async throws {}
          }
      }
      """
    )
  }

  func testEffectfulProperties5() {
    assertParse(
      """
      struct BadSubscript1 {
        subscript(_ i : Int) -> Int {
            get async throws {}
            set {}
          }
      }
      """
    )
  }

  func testEffectfulProperties6() {
    assertParse(
      """
      struct BadSubscript2 {
        subscript(_ i : Int) -> Int {
            get throws {}
            set throws {}
          }
      }
      """
    )
  }

  func testEffectfulProperties7() {
    assertParse(
      """
      struct S {
        var prop2 : Int {
          mutating get async throws { 0 }
          nonmutating set {}
        }
      }
      """
    )
  }

  func testEffectfulProperties8() {
    assertParse(
      """
      var prop3 : Bool {
        _read { yield prop3 }
        get throws { false }
        get async { true }
        get {}
      }
      """
    )
  }

  func testEffectfulProperties9() {
    assertParse(
      """
      enum E {
        private(set) var prop4 : Double {
          set {}
          get async throws { 1.1 }
          _modify { yield &prop4 }
        }
      }
      """
    )
  }

  func testEffectfulProperties10() {
    assertParse(
      """
      protocol P {
        associatedtype T
        var prop1 : T { get async throws }
        var prop2 : T { get async throws set }
        var prop3 : T { get throws set }
        var prop4 : T { get async }
        var prop5 : T { mutating get async throws }
        var prop6 : T { mutating get throws }
        var prop7 : T { mutating get async nonmutating set }
      }
      """
    )
  }

  func testEffectfulProperties11() {
    assertParse(
      """
      ///////////////////
      // invalid syntax
      """
    )
  }

  func testEffectfulProperties12() {
    assertParse(
      """
      var bad1 : Int {
        get rethrows { 0 }
        set rethrows { }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: only function declarations may be marked 'rethrows'; did you mean 'throws'?
      ]
    )
  }

  func testEffectfulProperties13() {
    assertParse(
      """
      var bad2 : Int {
        get reasync { 0 }
        set reasync { }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' to start getter definition
      ]
    )
  }

  func testEffectfulProperties14() {
    assertParse(
      """
      var bad3 : Int {
        _read async { yield 0 }
        set(theValue) async { }
      }
      """
    )
  }

  func testEffectfulProperties15a() {
    assertParse(
      """
      var bad4 : Int = 0 {
        willSet(theValue) 3️⃣reasync 4️⃣rethrows 1️⃣async 2️⃣throws {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "'async' conflicts with 'reasync'", notes: [NoteSpec(locationMarker: "3️⃣", message: "'reasync' declared here")], fixIts: ["remove redundant 'async'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'throws' conflicts with 'rethrows'", notes: [NoteSpec(locationMarker: "4️⃣", message: "'rethrows' declared here")], fixIts: ["remove redundant 'throws'"]),
      ]
    )
  }

  func testEffectfulProperties15b() {
    assertParse(
      """
      var bad4 : Int = 0 {
        didSet throws 1️⃣bogus {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'bogus' in accessor")
      ]
    )
  }

  func testEffectfulProperties16() {
    assertParse(
      """
      var bad5 : Int {
        get 1️⃣bogus rethrows {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'bogus' before effect specifiers")
      ]
    )
  }

  func testEffectfulProperties17() {
    assertParse(
      """
      var bad6 : Int {
        get rethrows 1️⃣-> Int { 0 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '-> Int' in accessor")
      ]
    )
  }

  func testEffectfulProperties18() {
    assertParse(
      """
      var bad7 : Double {
        get throws 1️⃣async { 3.14 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'async' must precede 'throws'")
      ]
    )
  }

  func testEffectfulProperties19() {
    assertParse(
      """
      var bad8 : Double {
        get {}
        _modify throws 1️⃣async { yield &bad8 }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "'async' must precede 'throws'")
      ]
    )
  }

  func testEffectfulProperties20() {
    assertParse(
      """
      protocol BadP {
        var prop2 : Int { get 1️⃣bogus rethrows set }
        var prop3 : Int { get rethrows 2️⃣bogus set }
        var prop4 : Int { get reasync 3️⃣bogus set }
        var prop5 : Int { get throws 4️⃣async }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'bogus' before effect specifiers"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code 'bogus set' in variable"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected code 'bogus set' in variable"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "'async' must precede 'throws'"),
      ]
    )
  }

}
