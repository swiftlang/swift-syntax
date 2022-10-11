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

  func testSubscripting12a() {
    AssertParse(
      """
      struct A0 {
        subscript 1️⃣
          i : 2️⃣Int3️⃣
           -> Int 4️⃣{
          get {
            return stored
          }
          set {
            stored = value
          }
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '(' to start function type"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ')' in function type"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected '->' and return type in subscript"),
      ], fixedSource: """
      struct A0 {
        subscript(
          i : (Int)
           -> Int)  -> <#type#>{
          get {
            return stored
          }
          set {
            stored = value
          }
        }
      }
      """
    )
  }

  func testSubscripting12b() {
    AssertParse(
      """
      // Parsing errors
      struct A0 {
        subscript 1️⃣-> Int {
          return 1
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected argument list in function declaration"),
      ]
    )
  }

  func testSubscripting13() {
    AssertParse(
      """
      struct A1 {
        subscript (i : Int) 1️⃣
           2️⃣Int {
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '->' and return type in subscript"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text in struct"),
        // TODO: Old parser expected error on line 5: cannot find 'stored' in scope
        // TODO: Old parser expected error on line 8: cannot find 'stored' in scope
      ]
    )
  }

  func testSubscripting14() {
    AssertParse(
      """
      struct A2 {
        subscript (i : Int) -> 1️⃣
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
        subscript(i : Int) 1️⃣
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
        subscript(i : Int) 1️⃣{ 
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
        subscript(i: Int)1️⃣(j: Int) -> Int { 
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
        subscript(i : Int) -> Int 1️⃣
          2️⃣get {
            return stored
          }
          set {
            stored = value
          }
        }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '{' in subscript to specify getter and setter implementation
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text in struct"),
      ]
    )
  }

  func testSubscripting22() {
    AssertParse(
      """
      struct A9 {
        subscript 1️⃣x() -> Int { 
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
        subscript 1️⃣x(i: Int) -> Int { 
          return 0
        }
        subscript 2️⃣x<T>(i: T) -> Int { 
          return 0
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: subscripts cannot have a name, Fix-It replacements: 13 - 14 = ''
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text 'x' before parameter clause"),
        // TODO: Old parser expected error on line 5: subscripts cannot have a name, Fix-It replacements: 13 - 14 = ''
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text 'x<T>' before parameter clause"),
      ]
    )
  }

  func testSubscripting24() {
    AssertParse(
      """
      struct A11 {
        subscript 1️⃣x y : 2️⃣Int 3️⃣-> Int 4️⃣{ 
          return 0
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '(' for subscript parameters
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start parameter clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '(' to start function type"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected ')' in function type"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected '->' and return type in subscript"),
      ]
    )
  }

  func testSubscripting25() {
    AssertParse(
      """
      1️⃣}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: extraneous '}' at top level, Fix-It replacements: 1 - 3 = ''
        DiagnosticSpec(message: "extraneous '}' at top level"),
      ]
    )
  }

}
