// This test file has been translated from swift/test/Parse/subscripting.swift

import XCTest

final class SubscriptingTests: XCTestCase {
  func testSubscripting1() {
    AssertParse(
      """
      struct X { }
      """
    )
  }

  func testSubscripting2() {
    AssertParse(
      """
      // Simple examples
      struct X1 {
        var stored: Int
        subscript(i: Int) -> Int {
          get {
            return stored
          }
          mutating
          set {
            stored = newValue
          }
        }
      }
      """
    )
  }

  func testSubscripting3() {
    AssertParse(
      """
      struct X2 {
        var stored: Int
        subscript(i: Int) -> Int {
          get {
            return stored + i
          }
          set(v) {
            stored = v - i
          }
        }
      }
      """
    )
  }

  func testSubscripting4() {
    AssertParse(
      """
      struct X3 {
        var stored: Int
        subscript(_: Int) -> Int {
          get {
            return stored
          }
          set(v) {
            stored = v
          }
        }
      }
      """
    )
  }

  func testSubscripting5() {
    AssertParse(
      """
      struct X4 {
        var stored: Int
        subscript(i: Int, j: Int) -> Int {
          get {
            return stored + i + j
          }
          mutating
          set(v) {
            stored = v + i - j
          }
        }
      }
      """
    )
  }

  func testSubscripting6() {
    AssertParse(
      """
      struct X5 {
        static var stored: Int = 1
        static subscript(i: Int) -> Int {
          get {
            return stored + i
          }
          set {
            stored = newValue - i
          }
        }
      }
      """
    )
  }

  func testSubscripting7() {
    AssertParse(
      """
      class X6 {
        static var stored: Int = 1
        class subscript(i: Int) -> Int {
          get {
            return stored + i
          }
          set {
            stored = newValue - i
          }
        }
      }
      """
    )
  }

  func testSubscripting8() {
    AssertParse(
      """
      struct Y1 {
        var stored: Int
        subscript(_: i, j: Int) -> Int { 
          get {
            return stored + j
          }
          set {
            stored = j
          }
        }
      }
      """
    )
  }

  func testSubscripting9() {
    AssertParse(
      """
      // Mutating getters on constants
      // https://github.com/apple/swift/issues/43457
      """
    )
  }

  func testSubscripting10() {
    AssertParse(
      """
      struct Y2 {
        subscript(_: Int) -> Int {
          mutating get { return 0 }
        }
      }
      """
    )
  }

  func testSubscripting11() {
    AssertParse(
      """
      // FIXME: This test case does not belong in Parse/
      let y2 = Y2() 
      _ = y2[0]
      """
    )
  }

  func testSubscripting12() {
    AssertParse(
      """
      // Parsing errors
      struct A0 {
        subscript #^DIAG_1^#
          i : #^DIAG_2^#Int#^DIAG_3^#
           -> Int #^DIAG_4^#{
          get {
            return stored
          }
          set {
            stored = value
          }
        }
        subscript #^DIAG_5^#-> Int { 
          return 1
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: expected '(' for subscript parameters
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '(' to start parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '(' to start function type"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected ')' in function type"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected '->' and return type in subscript"),
        // TODO: Old parser expected error on line 13: expected '(' for subscript parameters, Fix-It replacements: 12 - 12 = '()'
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected argument list in function declaration"),
      ]
    )
  }

  func testSubscripting13() {
    AssertParse(
      """
      struct A1 {
        subscript (i : Int) #^DIAG_1^#
           #^DIAG_2^#Int {
          get {
            return stored 
          }
          set {
            stored = newValue
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '->' for subscript element type
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '->' and return type in subscript"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected declaration in struct"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text in struct"),
        // TODO: Old parser expected error on line 5: cannot find 'stored' in scope
        // TODO: Old parser expected error on line 8: cannot find 'stored' in scope
      ]
    )
  }

  func testSubscripting14() {
    AssertParse(
      """
      struct A2 {
        subscript (i : Int) -> #^DIAG^#
           {
          get {
            return stored
          }
          set {
            stored = newValue 
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected subscripting element type
        DiagnosticSpec(message: "expected return type in subscript"),
        // TODO: Old parser expected error on line 8: cannot find 'stored' in scope
      ]
    )
  }

  func testSubscripting15() {
    AssertParse(
      """
      struct A3 {
        subscript(i : Int) #^DIAG^#
        {
          get {
            return i
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '->' for subscript element type
        // TODO: Old parser expected error on line 2: expected subscripting element type
        DiagnosticSpec(message: "expected '->' and return type in subscript"),
      ]
    )
  }

  func testSubscripting16() {
    AssertParse(
      """
      struct A4 {
        subscript(i : Int) #^DIAG^#{ 
          get {
            return i
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '->' for subscript element type
        // TODO: Old parser expected error on line 2: expected subscripting element type
        DiagnosticSpec(message: "expected '->' and return type in subscript"),
      ]
    )
  }

  func testSubscripting17() {
    AssertParse(
      """
      struct A5 {
        subscript(i : Int) -> Int 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' in subscript to specify getter and setter implementation
      ]
    )
  }

  func testSubscripting18() {
    AssertParse(
      """
      struct A6 {
        subscript(i: Int)#^DIAG^#(j: Int) -> Int { 
          get {
            return i + j 
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '->' for subscript element type
        // TODO: Old parser expected error on line 2: function types cannot have argument labels
        DiagnosticSpec(message: "expected '->' and return type in subscript"),
        DiagnosticSpec(message: "expected declaration in struct"),
        DiagnosticSpec(message: "unexpected text in struct"),
      ]
    )
  }

  func testSubscripting19() {
    AssertParse(
      """
      struct A7 {
        class subscript(a: Float) -> Int { 
          get {
            return 42
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: class subscripts are only allowed within classes; use 'static' to declare a static subscript, Fix-It replacements: 3 - 8 = 'static'
      ]
    )
  }

  func testSubscripting20() {
    AssertParse(
      """
      class A7b {
        class static subscript(a: Float) -> Int { 
          get {
            return 42
          }
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'static' cannot appear after another 'static' or 'class' keyword, Fix-It replacements: 9 - 16 = ''
      ]
    )
  }

  func testSubscripting21() {
    AssertParse(
      """
      struct A8 {
        subscript(i : Int) -> Int #^DIAG_1^#
          #^DIAG_2^#get {
            return stored
          }
          set {
            stored = value
          }
        }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' in subscript to specify getter and setter implementation
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected declaration in struct"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text in struct"),
      ]
    )
  }

  func testSubscripting22() {
    AssertParse(
      """
      struct A9 {
        subscript #^DIAG^#x() -> Int { 
          return 0
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: subscripts cannot have a name, Fix-It replacements: 13 - 14 = ''
        DiagnosticSpec(message: "unexpected text 'x' before parameter clause"),
      ]
    )
  }

  func testSubscripting23() {
    AssertParse(
      """
      struct A10 {
        subscript #^DIAG_1^#x(i: Int) -> Int { 
          return 0
        }
        subscript #^DIAG_2^#x<T>(i: T) -> Int { 
          return 0
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: subscripts cannot have a name, Fix-It replacements: 13 - 14 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text 'x' before parameter clause"),
        // TODO: Old parser expected error on line 5: subscripts cannot have a name, Fix-It replacements: 13 - 14 = ''
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text 'x<T>' before parameter clause"),
      ]
    )
  }

  func testSubscripting24() {
    AssertParse(
      """
      struct A11 {
        subscript #^DIAG_1^#x y : #^DIAG_2^#Int #^DIAG_3^#-> Int #^DIAG_4^#{ 
          return 0
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '(' for subscript parameters
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '(' to start parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '(' to start function type"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected ')' in function type"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected '->' and return type in subscript"),
      ]
    )
  }

  func testSubscripting25() {
    AssertParse(
      """
      #^DIAG^#}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: extraneous '}' at top level, Fix-It replacements: 1 - 3 = ''
        DiagnosticSpec(message: "extraneous '}' at top level"),
      ]
    )
  }

}
