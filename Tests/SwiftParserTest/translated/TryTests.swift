// This test file has been translated from swift/test/Parse/try.swift

import XCTest

final class TryTests: XCTestCase {
  func testTry1() {
    AssertParse(
      """
      // Intentionally has lower precedence than assignments and ?:
      infix operator %%%% : LowPrecedence
      precedencegroup LowPrecedence {
        associativity: none
        lowerThan: AssignmentPrecedence
      }
      func %%%%<T, U>(x: T, y: U) -> Int { return 0 }
      """
    )
  }

  func testTry2() {
    AssertParse(
      """
      // Intentionally has lower precedence between assignments and ?:
      infix operator %%% : MiddlingPrecedence
      precedencegroup MiddlingPrecedence {
        associativity: none
        higherThan: AssignmentPrecedence
        lowerThan: TernaryPrecedence
      }
      func %%%<T, U>(x: T, y: U) -> Int { return 1 }
      """
    )
  }

  func testTry3() {
    AssertParse(
      """
      func foo() throws -> Int { return 0 }
      func bar() throws -> Int { return 0 }
      """
    )
  }

  func testTry4() {
    AssertParse(
      """
      var x = try foo() + bar()
      x = try foo() + bar()
      x += try foo() + bar()
      x += try foo() %%%% bar() 
      x += try foo() %%% bar()
      x = foo() + try bar()
      """
    )
  }

  func testTry5() {
    AssertParse(
      """
      var y = true ? try foo() : try bar() + 0
      var z = true ? try foo() : try bar() %%% 0
      """
    )
  }

  func testTry6() {
    AssertParse(
      """
      var a = try! foo() + bar()
      a = try! foo() + bar()
      a += try! foo() + bar()
      a += try! foo() %%%% bar() 
      a += try! foo() %%% bar()
      a = foo() + try! bar()
      """
    )
  }

  func testTry7() {
    AssertParse(
      """
      var b = true ? try! foo() : try! bar() + 0
      var c = true ? try! foo() : try! bar() %%% 0
      """
    )
  }

  func testTry8() {
    AssertParse(
      """
      infix operator ?+= : AssignmentPrecedence
      func ?+=(lhs: inout Int?, rhs: Int?) {
        lhs = lhs! + rhs!
      }
      """
    )
  }

  func testTry9() {
    AssertParse(
      """
      var i = try? foo() + bar()
      let _: Double = i 
      i = try? foo() + bar()
      i ?+= try? foo() + bar()
      i ?+= try? foo() %%%% bar() 
      i ?+= try? foo() %%% bar()
      _ = foo() == try? bar() 
      _ = (try? foo()) == bar() 
      _ = foo() == (try? bar()) 
      _ = (try? foo()) == (try? bar())
      """
    )
  }

  func testTry10() {
    AssertParse(
      """
      let j = true ? try? foo() : try? bar() + 0
      let k = true ? try? foo() : try? bar() %%% 0
      """
    )
  }

  func testTry11a() {
    AssertParse(
      """
      try1️⃣ 2️⃣let singleLet = foo()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 21 - 21 = 'try '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry11b() {
    AssertParse(
      """
      try1️⃣ 2️⃣var singleVar = foo()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 21 - 21 = 'try '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry11c() {
    AssertParse(
      """
      try1️⃣ 2️⃣let uninit: Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'try' must be placed on the initial value expression
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry11d() {
    AssertParse(
      """
      try1️⃣ 2️⃣let (destructure1, destructure2) = (foo(), bar())
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 40 - 40 = 'try '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry11e() {
    AssertParse(
      """
      try1️⃣ 2️⃣let multi1 = foo(), multi2 = bar() //  expected-error 2 {{call can throw but is not marked with 'try'}}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'try' must be placed on the initial value expression
        // TODO: Old parser expected note on line 1: did you mean to use 'try'?, Fix-It replacements: 18 - 18 = 'try '
        // TODO: Old parser expected note on line 1: did you mean to use 'try'?, Fix-It replacements: 34 - 34 = 'try '
        // TODO: Old parser expected note on line 1: did you mean to handle error as optional value?, Fix-It replacements: 18 - 18 = 'try? '
        // TODO: Old parser expected note on line 1: did you mean to handle error as optional value?, Fix-It replacements: 34 - 34 = 'try? '
        // TODO: Old parser expected note on line 1: did you mean to disable error propagation?, Fix-It replacements: 18 - 18 = 'try! '
        // TODO: Old parser expected note on line 1: did you mean to disable error propagation?, Fix-It replacements: 34 - 34 = 'try! '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry11f() {
    AssertParse(
      """
      class TryDecl {
        1️⃣try let singleLet = foo()
        2️⃣try var singleVar = foo()
        3️⃣try
        func method() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected note on line 1: in declaration of 'TryDecl'
        // TODO: Old parser expected error on line 2: 'try' must be placed on the initial value expression, Fix-It replacements: 3 - 7 = '', 23 - 23 = 'try '
        // TODO: Old parser expected error on line 2: call can throw, but errors cannot be thrown out of a property initializer
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text 'try' before variable"),
        // TODO: Old parser expected error on line 3: 'try' must be placed on the initial value expression, Fix-It replacements: 3 - 7 = '', 23 - 23 = 'try '
        // TODO: Old parser expected error on line 3: call can throw, but errors cannot be thrown out of a property initializer
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text 'try' before variable"),
        // TODO: Old parser expected error on line 4: expected declaration
        DiagnosticSpec(locationMarker: "3️⃣", message: "unexpected text 'try' before function"),
      ]
    )
  }

  func testTry12a() {
    AssertParse(
      """
      func test() throws -> Int {
        try1️⃣ 2️⃣while true {
          try3️⃣ 4️⃣break
        }
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'try' cannot be used with 'while'
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 3: 'try' cannot be used with 'break'
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry12b() {
    AssertParse(
      """
      func test() throws -> Int {
        try1️⃣ 2️⃣throw 3️⃣
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 5: 'try' must be placed on the thrown expression, Fix-It replacements: 3 - 7 = '', 3 - 3 = 'try '
        // TODO: Old parser expected error on line 5: expected expression in 'throw' statement
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression in 'throw' statement"),
      ]
    )
  }

  func testTry12c() {
    AssertParse(
      """
      func test() throws -> Int {
        try1️⃣ 2️⃣return
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 7: 'try' cannot be used with 'return'
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry12d() {
    AssertParse(
      """
      func test() throws -> Int {
        try1️⃣ 2️⃣throw foo()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 9: 'try' must be placed on the thrown expression, Fix-It replacements: 3 - 7 = '', 13 - 13 = 'try '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry12e() {
    AssertParse(
      """
      func test() throws -> Int {
        try1️⃣ 2️⃣return foo()
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 10: 'try' must be placed on the returned expression, Fix-It replacements: 3 - 7 = '', 14 - 14 = 'try '
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTry13() {
    AssertParse(
      #"""
      // Test operators.
      func *(a : String, b : String) throws -> Int { return 42 }
      let _ = "foo"
              *  
              "bar"
      let _ = try! "foo"*"bar"
      let _ = try? "foo"*"bar"
      let _ = (try? "foo"*"bar") ?? 0
      """#
    )
  }

  func testTry14() {
    AssertParse(
      """
      // <rdar://problem/21414023> Assertion failure when compiling function that takes throwing functions and rethrows
      func rethrowsDispatchError(handleError: ((Error) throws -> ()), body: () throws -> ()) rethrows {
        do {
          body()   
        } catch {
        }
      }
      """
    )
  }

  func testTry15() {
    AssertParse(
      """
      // <rdar://problem/21432429> Calling rethrows from rethrows crashes Swift compiler
      struct r21432429 {
        func x(_ f: () throws -> ()) rethrows {}
        func y(_ f: () throws -> ()) rethrows {
          x(f)  
        }
      }
      """
    )
  }

  func testTry16() {
    AssertParse(
      """
      // <rdar://problem/21427855> Swift 2: Omitting try from call to throwing closure in rethrowing function crashes compiler
      func callThrowingClosureWithoutTry(closure: (Int) throws -> Int) rethrows {
        closure(0)  
      }
      """
    )
  }

  func testTry17() {
    AssertParse(
      """
      func producesOptional() throws -> Int? { return nil }
      let _: String = try? producesOptional()
      """
    )
  }

  func testTry18() {
    AssertParse(
      """
      let _ = (try? foo())!!
      """
    )
  }

  func testTry19() {
    AssertParse(
      """
      func producesDoubleOptional() throws -> Int?? { return 3 }
      let _: String = try? producesDoubleOptional()
      """
    )
  }

  func testTry20() {
    AssertParse(
      """
      func maybeThrow() throws {}
      try maybeThrow() // okay
      try! maybeThrow() // okay
      try? maybeThrow() // okay since return type of maybeThrow is Void
      _ = try? maybeThrow() // okay
      """
    )
  }

  func testTry21() {
    AssertParse(
      """
      let _: () -> Void = { try! maybeThrow() } // okay
      let _: () -> Void = { try? maybeThrow() } // okay since return type of maybeThrow is Void
      """
    )
  }

  func testTry22() {
    AssertParse(
      """
      if try? maybeThrow() { 
      }
      let _: Int = try? foo()
      """
    )
  }

  func testTry23() {
    AssertParse(
      """
      class X {}
      func test(_: X) {}
      func producesObject() throws -> AnyObject { return X() }
      test(try producesObject())
      """
    )
  }

  func testTry24() {
    AssertParse(
      #"""
      _ = "a\(try maybeThrow())b"
      _ = try "a\(maybeThrow())b"
      _ = "a\(maybeThrow())"
      """#
    )
  }

  func testTry25() {
    AssertParse(
      """
      extension DefaultStringInterpolation {
        mutating func appendInterpolation() throws {}
      }
      """
    )
  }

  func testTry26() {
    AssertParse(
      #"""
      _ = try "a\()b"
      _ = "a\()b" 
      _ = try "\() \(1)"
      """#
    )
  }

  func testTry27() {
    AssertParse(
      """
      func testGenericOptionalTry<T>(_ call: () throws -> T ) {
        let _: String = try? call() 
      }
      """
    )
  }

  func testTry28() {
    AssertParse(
      """
      func genericOptionalTry<T>(_ call: () throws -> T ) -> T? {
        let x = try? call() // no error expected
        return x
      }
      """
    )
  }

  func testTry29() {
    AssertParse(
      """
      // Test with a non-optional type
      let _: String = genericOptionalTry({ () throws -> Int in return 3 })
      """
    )
  }

  func testTry30() {
    AssertParse(
      """
      // Test with an optional type
      let _: String = genericOptionalTry({ () throws -> Int? in return nil })
      """
    )
  }

  func testTry31() {
    AssertParse(
      """
      func produceAny() throws -> Any {
        return 3
      }
      """
    )
  }

  func testTry32() {
    AssertParse(
      """
      let _: Int? = try? produceAny() as? Int 
      let _: Int?? = (try? produceAny()) as? Int // good
      let _: String = try? produceAny() as? Int 
      let _: String = (try? produceAny()) as? Int
      """
    )
  }

  func testTry33() {
    AssertParse(
      """
      struct ThingProducer {
        func produceInt() throws -> Int { return 3 }
        func produceIntNoThrowing() -> Int { return 3 }
        func produceAny() throws -> Any { return 3 }
        func produceOptionalAny() throws -> Any? { return 3 }
        func produceDoubleOptionalInt() throws -> Int?? { return 3 }
      }
      """
    )
  }

  func testTry34() {
    AssertParse(
      """
      let optProducer: ThingProducer? = ThingProducer()
      let _: Int? = try? optProducer?.produceInt() 
      let _: Int = try? optProducer?.produceInt() 
      let _: String = try? optProducer?.produceInt() 
      let _: Int?? = try? optProducer?.produceInt() // good
      """
    )
  }

  func testTry35() {
    AssertParse(
      """
      let _: Int? = try? optProducer?.produceIntNoThrowing() 
      let _: Int?? = try? optProducer?.produceIntNoThrowing()
      """
    )
  }

  func testTry36() {
    AssertParse(
      """
      let _: Int? = (try? optProducer?.produceAny()) as? Int // good
      let _: Int? = try? optProducer?.produceAny() as? Int 
      let _: Int?? = try? optProducer?.produceAny() as? Int // good
      let _: String = try? optProducer?.produceAny() as? Int
      """
    )
  }

  func testTry37() {
    AssertParse(
      """
      let _: String = try? optProducer?.produceDoubleOptionalInt()
      """
    )
  }

  func testTry38() {
    AssertParse(
      """
      let producer = ThingProducer()
      """
    )
  }

  func testTry39() {
    AssertParse(
      """
      let _: Int = try? producer.produceDoubleOptionalInt() 
      let _: Int? = try? producer.produceDoubleOptionalInt() 
      let _: Int?? = try? producer.produceDoubleOptionalInt() 
      let _: Int??? = try? producer.produceDoubleOptionalInt() // good
      let _: String = try? producer.produceDoubleOptionalInt()
      """
    )
  }

  func testTry40() {
    AssertParse(
      """
      // rdar://problem/46742002
      protocol Dummy : class {}
      """
    )
  }

  func testTry41() {
    AssertParse(
      """
      class F<T> {
        func wait() throws -> T { fatalError() }
      }
      """
    )
  }

  func testTry42() {
    AssertParse(
      """
      func bar(_ a: F<Dummy>, _ b: F<Dummy>) {
        _ = (try? a.wait()) === (try? b.wait())
      }
      """
    )
  }

}
