// This test file has been translated from swift/test/Parse/try_swift5.swift

import XCTest

final class TrySwift5Tests: XCTestCase {
  func testTrySwift51() {
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

  func testTrySwift52() {
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

  func testTrySwift53() {
    AssertParse(
      """
      func foo() throws -> Int { return 0 }
      func bar() throws -> Int { return 0 }
      """
    )
  }

  func testTrySwift54() {
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

  func testTrySwift55() {
    AssertParse(
      """
      var y = true ? try foo() : try bar() + 0
      var z = true ? try foo() : try bar() %%% 0
      """
    )
  }

  func testTrySwift56() {
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

  func testTrySwift57() {
    AssertParse(
      """
      var b = true ? try! foo() : try! bar() + 0
      var c = true ? try! foo() : try! bar() %%% 0
      """
    )
  }

  func testTrySwift58() {
    AssertParse(
      """
      infix operator ?+= : AssignmentPrecedence
      func ?+=(lhs: inout Int?, rhs: Int?) {
        lhs = lhs! + rhs!
      }
      """
    )
  }

  func testTrySwift59() {
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

  func testTrySwift510() {
    AssertParse(
      """
      let j = true ? try? foo() : try? bar() + 0
      let k = true ? try? foo() : try? bar() %%% 0
      """
    )
  }

  func testTrySwift511() {
    AssertParse(
      """
      try #^DIAG_1^#let singleLet = foo() 
      try #^DIAG_2^#var singleVar = foo() 
      try #^DIAG_3^#let uninit: Int 
      try #^DIAG_4^#let (destructure1, destructure2) = (foo(), bar()) 
      try #^DIAG_5^#let multi1 = foo(), multi2 = bar() //  expected-error 2 {{call can throw but is not marked with 'try'}}
      class TryDecl { 
        #^DIAG_6^#try let singleLet = foo() 
        #^DIAG_7^#try var singleVar = foo() 
        #^DIAG_8^#try 
        func method() {}
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 21 - 21 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 2: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 21 - 21 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 3: 'try' must be placed on the initial value expression
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 4: 'try' must be placed on the initial value expression, Fix-It replacements: 1 - 5 = '', 40 - 40 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 5: 'try' must be placed on the initial value expression
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 7: 'try' must be placed on the initial value expression, Fix-It replacements: 3 - 7 = '', 23 - 23 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_6", message: "unexpected text 'try' before variable"),
        // TODO: Old parser expected error on line 8: 'try' must be placed on the initial value expression, Fix-It replacements: 3 - 7 = '', 23 - 23 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_7", message: "unexpected text 'try' before variable"),
        // TODO: Old parser expected error on line 9: expected declaration
        DiagnosticSpec(locationMarker: "DIAG_8", message: "unexpected text 'try' before function"),
      ]
    )
  }

  func testTrySwift512() {
    AssertParse(
      """
      func test() throws -> Int {
        try #^DIAG_1^#while true { 
          try #^DIAG_2^#break 
        }
        try #^DIAG_3^#throw #^DIAG_4^#
        ; // Reset parser.
        try #^DIAG_5^#return 
        ; // Reset parser.
        try #^DIAG_6^#throw foo() 
        try #^DIAG_7^#return foo() 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: 'try' cannot be used with 'while'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 3: 'try' cannot be used with 'break'
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 5: 'try' must be placed on the thrown expression, Fix-It replacements: 3 - 7 = '', 3 - 3 = 'try '
        // TODO: Old parser expected error on line 5: expected expression in 'throw' statement
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected expression in 'try' expression"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected expression in 'throw' statement"),
        // TODO: Old parser expected error on line 7: 'try' cannot be used with 'return'
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 9: 'try' must be placed on the thrown expression, Fix-It replacements: 3 - 7 = '', 13 - 13 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_6", message: "expected expression in 'try' expression"),
        // TODO: Old parser expected error on line 10: 'try' must be placed on the returned expression, Fix-It replacements: 3 - 7 = '', 14 - 14 = 'try '
        DiagnosticSpec(locationMarker: "DIAG_7", message: "expected expression in 'try' expression"),
      ]
    )
  }

  func testTrySwift513() {
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

  func testTrySwift514() {
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

  func testTrySwift515() {
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

  func testTrySwift516() {
    AssertParse(
      """
      // <rdar://problem/21427855> Swift 2: Omitting try from call to throwing closure in rethrowing function crashes compiler
      func callThrowingClosureWithoutTry(closure: (Int) throws -> Int) rethrows {
        closure(0)  
      }
      """
    )
  }

  func testTrySwift517() {
    AssertParse(
      """
      func producesOptional() throws -> Int? { return nil }
      let singleOptional = try? producesOptional()
      let _: String = singleOptional
      """
    )
  }

  func testTrySwift518() {
    AssertParse(
      """
      let _ = (try? foo())!!
      """
    )
  }

  func testTrySwift519() {
    AssertParse(
      """
      func producesDoubleOptional() throws -> Int?? { return 3 }
      let _: String = try? producesDoubleOptional()
      """
    )
  }

  func testTrySwift520() {
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

  func testTrySwift521() {
    AssertParse(
      """
      let _: () -> Void = { try! maybeThrow() } // okay
      let _: () -> Void = { try? maybeThrow() } // okay since return type of maybeThrow is Void
      """
    )
  }

  func testTrySwift522() {
    AssertParse(
      """
      if try? maybeThrow() { 
      }
      let _: Int = try? foo()
      """
    )
  }

  func testTrySwift523() {
    AssertParse(
      """
      class X {}
      func test(_: X) {}
      func producesObject() throws -> AnyObject { return X() }
      test(try producesObject())
      """
    )
  }

  func testTrySwift524() {
    AssertParse(
      #"""
      _ = "a\(try maybeThrow())b"
      _ = try "a\(maybeThrow())b"
      _ = "a\(maybeThrow())"
      """#
    )
  }

  func testTrySwift525() {
    AssertParse(
      """
      extension DefaultStringInterpolation {
        mutating func appendInterpolation() throws {}
      }
      """
    )
  }

  func testTrySwift526() {
    AssertParse(
      #"""
      _ = try "a\()b"
      _ = "a\()b" 
      _ = try "\() \(1)"
      """#
    )
  }

  func testTrySwift527() {
    AssertParse(
      """
      func testGenericOptionalTry<T>(_ call: () throws -> T ) {
        let _: String = try? call() 
      }
      """
    )
  }

  func testTrySwift528() {
    AssertParse(
      """
      func genericOptionalTry<T>(_ call: () throws -> T ) -> T? {
        let x = try? call() // no error expected
        return x
      }
      """
    )
  }

  func testTrySwift529() {
    AssertParse(
      """
      // Test with a non-optional type
      let _: String = genericOptionalTry({ () throws -> Int in return 3 })
      """
    )
  }

  func testTrySwift530() {
    AssertParse(
      """
      // Test with an optional type
      let _: String = genericOptionalTry({ () throws -> Int? in return nil })
      """
    )
  }

  func testTrySwift531() {
    AssertParse(
      """
      func produceAny() throws -> Any {
        return 3
      }
      """
    )
  }

  func testTrySwift532() {
    AssertParse(
      """
      let _: Int? = try? produceAny() as? Int // good
      let _: Int? = (try? produceAny()) as? Int // good
      let _: String = try? produceAny() as? Int 
      let _: String = (try? produceAny()) as? Int
      """
    )
  }

  func testTrySwift533() {
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

  func testTrySwift534() {
    AssertParse(
      """
      let optProducer: ThingProducer? = ThingProducer()
      let _: Int? = try? optProducer?.produceInt()
      let _: Int = try? optProducer?.produceInt() 
      let _: String = try? optProducer?.produceInt() 
      let _: Int?? = try? optProducer?.produceInt() // This was the expected type before Swift 5, but this still works; just adds more optional-ness
      """
    )
  }

  func testTrySwift535() {
    AssertParse(
      """
      let _: Int? = try? optProducer?.produceIntNoThrowing()
      """
    )
  }

  func testTrySwift536() {
    AssertParse(
      """
      let _: Int? = (try? optProducer?.produceAny()) as? Int // good
      let _: Int? = try? optProducer?.produceAny() as? Int // good
      let _: Int?? = try? optProducer?.produceAny() as? Int // good
      let _: String = try? optProducer?.produceAny() as? Int
      """
    )
  }

  func testTrySwift537() {
    AssertParse(
      """
      let _: String = try? optProducer?.produceDoubleOptionalInt()
      """
    )
  }

  func testTrySwift538() {
    AssertParse(
      """
      let producer = ThingProducer()
      """
    )
  }

  func testTrySwift539() {
    AssertParse(
      """
      let _: Int = try? producer.produceDoubleOptionalInt()
      """
    )
  }

  func testTrySwift540() {
    AssertParse(
      """
      // We don't offer 'try!' here because it would not change the type of the expression in Swift 5+
      let _: Int? = try? producer.produceDoubleOptionalInt()
      """
    )
  }

  func testTrySwift541() {
    AssertParse(
      """
      let _: Int?? = try? producer.produceDoubleOptionalInt() // good
      let _: Int??? = try? producer.produceDoubleOptionalInt() // good
      let _: String = try? producer.produceDoubleOptionalInt()
      """
    )
  }

  func testTrySwift542() {
    AssertParse(
      """
      // rdar://problem/46742002
      protocol Dummy : AnyObject {}
      """
    )
  }

  func testTrySwift543() {
    AssertParse(
      """
      class F<T> {
        func wait() throws -> T { fatalError() }
      }
      """
    )
  }

  func testTrySwift544() {
    AssertParse(
      """
      func bar(_ a: F<Dummy>, _ b: F<Dummy>) {
        _ = (try? a.wait()) === (try? b.wait())
      }
      """
    )
  }

}
