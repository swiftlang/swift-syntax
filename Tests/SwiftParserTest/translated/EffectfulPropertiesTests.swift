// This test file has been translated from swift/test/Parse/effectful_properties.swift

import XCTest

final class EffectfulPropertiesTests: XCTestCase {
  func testEffectfulProperties1() {
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
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
    AssertParse(
      """
      struct BadSubscript1 {
        subscript(_ i : Int) -> Int {
            get async throws {}
            set {} 
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
      ]
    )
  }

  func testEffectfulProperties6() {
    AssertParse(
      """
      struct BadSubscript2 {
        subscript(_ i : Int) -> Int {
            get throws {}
            set throws {}
          }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
        // TODO: Old parser expected error on line 4: 'set' accessor cannot have specifier 'throws'
      ]
    )
  }

  func testEffectfulProperties7() {
    AssertParse(
      """
      struct S {
        var prop2 : Int {
          mutating get async throws { 0 }
          nonmutating set {} 
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
      ]
    )
  }

  func testEffectfulProperties8() {
    AssertParse(
      """
      var prop3 : Bool {
        _read { yield prop3 }
        // expected-note@+1 2 {{previous definition of getter here}}
        get throws { false }
        get async { true } 
        get {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '_read' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
        // TODO: Old parser expected error on line 2: variable cannot provide both a 'read' accessor and a getter
        // TODO: Old parser expected note on line 4: getter defined here
        // TODO: Old parser expected error on line 5: variable already has a getter
        // TODO: Old parser expected error on line 6: variable already has a getter
      ]
    )
  }

  func testEffectfulProperties9() {
    AssertParse(
      """
      enum E {
        private(set) var prop4 : Double {
          set {} 
          get async throws { 1.1 }
          _modify { yield &prop4 } 
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: 'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
        // TODO: Old parser expected error on line 5: '_modify' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
      ]
    )
  }

  func testEffectfulProperties10() {
    AssertParse(
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
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 4: 'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
        // TODO: Old parser expected error on line 5: 'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
        // TODO: Old parser expected error on line 9: 'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
      ]
    )
  }

  func testEffectfulProperties11() {
    AssertParse(
      """
      ///////////////////
      // invalid syntax
      """
    )
  }

  func testEffectfulProperties12() {
    AssertParse(
      """
      var bad1 : Int {
        get rethrows { 0 }  
        set rethrows { }   
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: only function declarations may be marked 'rethrows'; did you mean 'throws'?
        // TODO: Old parser expected error on line 3: 'set' accessor is not allowed on property with 'get' accessor that is 'async' or 'throws'
        // TODO: Old parser expected error on line 3: 'set' accessor cannot have specifier 'rethrows'
      ]
    )
  }

  func testEffectfulProperties13() {
    AssertParse(
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
    AssertParse(
      """
      var bad3 : Int {
        _read async { yield 0 } 
        set(theValue) async { } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: '_read' accessor cannot have specifier 'async'
        // TODO: Old parser expected error on line 3: 'set' accessor cannot have specifier 'async'
      ]
    )
  }

  func testEffectfulProperties15() {
    AssertParse(
      """
      var bad4 : Int = 0 {
        willSet(theValue) reasync rethrows #^DIAG^#async throws {}
        didSet throws bogus {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'willSet' accessor cannot have specifier 'throws'
        // TODO: Old parser expected error on line 2: 'willSet' accessor cannot have specifier 'async'
        // TODO: Old parser expected error on line 2: 'willSet' accessor cannot have specifier 'rethrows'
        // TODO: Old parser expected error on line 2: 'willSet' accessor cannot have specifier 'reasync'
        DiagnosticSpec(message: "unexpected text in variable"),
        // TODO: Old parser expected error on line 3: expected '{' to start 'didSet' definition
        // TODO: Old parser expected error on line 3: 'didSet' accessor cannot have specifier 'throws'
      ]
    )
  }

  func testEffectfulProperties16() {
    AssertParse(
      """
      var bad5 : Int {
        get #^DIAG^#bogus rethrows {} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' to start getter definition
        DiagnosticSpec(message: "unexpected text 'bogus rethrows {}' in variable"),
      ]
    )
  }

  func testEffectfulProperties17() {
    AssertParse(
      """
      var bad6 : Int {
        get rethrows #^DIAG^#-> Int { 0 }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' to start getter definition
        // TODO: Old parser expected error on line 2: only function declarations may be marked 'rethrows'; did you mean 'throws'?
        DiagnosticSpec(message: "unexpected text '-> Int { 0 }' in variable"),
      ]
    )
  }

  func testEffectfulProperties18() {
    AssertParse(
      """
      var bad7 : Double {
        get throws async { 3.14 } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'async' must precede 'throws'
      ]
    )
  }

  func testEffectfulProperties19() {
    AssertParse(
      """
      var bad8 : Double {
        get {}
        _modify throws async { yield &bad8 }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: '_modify' accessor cannot have specifier 'async'
        // TODO: Old parser expected error on line 3: '_modify' accessor cannot have specifier 'throws'
      ]
    )
  }

  func testEffectfulProperties20() {
    AssertParse(
      """
      protocol BadP {
        var prop2 : Int { get #^DIAG_1^#bogus rethrows set } 
        var prop3 : Int { get rethrows #^DIAG_2^#bogus set }
        var prop4 : Int { get reasync #^DIAG_3^#bogus set }
        var prop5 : Int { get throws async } 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected get or set in a protocol property
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text 'bogus rethrows set' in variable"),
        // TODO: Old parser expected error on line 3: only function declarations may be marked 'rethrows'; did you mean 'throws'?
        // TODO: Old parser expected error on line 3: expected get or set in a protocol property
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text 'bogus set' in variable"),
        // TODO: Old parser expected error on line 4: expected get or set in a protocol property
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text 'bogus set' in variable"),
        // TODO: Old parser expected error on line 5: 'async' must precede 'throws'
      ]
    )
  }

}
