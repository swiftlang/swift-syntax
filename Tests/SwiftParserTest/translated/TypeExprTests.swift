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

// This test file has been translated from swift/test/Parse/type_expr.swift

import XCTest

// Types in expression contexts must be followed by a member access or
// constructor call.
final class TypeExprTests: XCTestCase {
  func testTypeExpr3() {
    AssertParse(
      """
      struct Foo {
        struct Bar {
          init() {}
          static var prop: Int = 0
          static func meth() {}
          func instMeth() {}
        }
        init() {}
        static var prop: Int = 0
        static func meth() {}
        func instMeth() {}
      }
      """
    )
  }

  func testTypeExpr4() {
    AssertParse(
      """
      protocol Zim {
        associatedtype Zang
        init()
        // TODO class var prop: Int { get }
        static func meth() {} 
        func instMeth() {} 
      }
      """
    )
  }

  func testTypeExpr5() {
    AssertParse(
      """
      protocol Bad {
        init() {} 
      }
      """
    )
  }

  func testTypeExpr6() {
    AssertParse(
      """
      struct Gen<T> {
        struct Bar {
          init() {}
          static var prop: Int { return 0 }
          static func meth() {}
          func instMeth() {}
        }
        init() {}
        static var prop: Int { return 0 }
        static func meth() {}
        func instMeth() {}
      }
      """
    )
  }

  func testTypeExpr7() {
    AssertParse(
      """
      func unqualifiedType() {
        _ = Foo.self
        _ = Foo.self
        _ = Foo()
        _ = Foo.prop
        _ = Foo.meth
        let _ : () = Foo.meth()
        _ = Foo.instMeth
        _ = Foo 
        _ = Foo.dynamicType 
        _ = Bad 
      }
      """
    )
  }

  func testTypeExpr8() {
    AssertParse(
      """
      func qualifiedType() {
        _ = Foo.Bar.self
        let _ : Foo.Bar.Type = Foo.Bar.self
        let _ : Foo.Protocol = Foo.self 
        _ = Foo.Bar()
        _ = Foo.Bar.prop
        _ = Foo.Bar.meth
        let _ : () = Foo.Bar.meth()
        _ = Foo.Bar.instMeth
        _ = Foo.Bar 
        _ = Foo.Bar.dynamicType 
      }
      """
    )
  }

  func testTypeExpr9() {
    AssertParse(
      """
      // We allow '.Type' in expr context
      func metaType() {
        let _ = Foo.Type.self
        let _ = Foo.Type.self
        let _ = Foo.Type 
        let _ = type(of: Foo.Type) 
      }
      """
    )
  }

  func testTypeExpr10() {
    AssertParse(
      """
      func genType() {
        _ = Gen<Foo>.self
        _ = Gen<Foo>()
        _ = Gen<Foo>.prop
        _ = Gen<Foo>.meth
        let _ : () = Gen<Foo>.meth()
        _ = Gen<Foo>.instMeth
        _ = Gen<Foo> 
      }
      """
    )
  }

  func testTypeExpr11() {
    AssertParse(
      """
      func genQualifiedType() {
        _ = Gen<Foo>.Bar.self
        _ = Gen<Foo>.Bar()
        _ = Gen<Foo>.Bar.prop
        _ = Gen<Foo>.Bar.meth
        let _ : () = Gen<Foo>.Bar.meth()
        _ = Gen<Foo>.Bar.instMeth
        _ = Gen<Foo>.Bar 
        _ = Gen<Foo>.Bar.dynamicType 
      }
      """
    )
  }

  func testTypeExpr12() {
    AssertParse(
      """
      func typeOfShadowing() {
        // Try to shadow type(of:)
        func type<T>(of t: T.Type, flag: Bool) -> T.Type { 
          return t
        }
        func type<T, U>(of t: T.Type, _ : U) -> T.Type {
          return t
        }
        func type<T>(_ t: T.Type) -> T.Type {
          return t
        }
        func type<T>(fo t: T.Type) -> T.Type {
          return t
        }
        _ = type(of: Gen<Foo>.Bar) 
        _ = type(Gen<Foo>.Bar) 
        _ = type(of: Gen<Foo>.Bar.self, flag: false) // No error here.
        _ = type(fo: Foo.Bar.self) // No error here.
        _ = type(of: Foo.Bar.self, [1, 2, 3]) // No error here.
      }
      """
    )
  }

  func testTypeExpr13() {
    AssertParse(
      """
      func archetype<T: Zim>(_: T) {
        _ = T.self
        _ = T()
        // TODO let prop = T.prop
        _ = T.meth
        let _ : () = T.meth()
        _ = T 
      }
      """
    )
  }

  func testTypeExpr14() {
    AssertParse(
      """
      func assocType<T: Zim>(_: T) where T.Zang: Zim {
        _ = T.Zang.self
        _ = T.Zang()
        // TODO _ = T.Zang.prop
        _ = T.Zang.meth
        let _ : () = T.Zang.meth()
        _ = T.Zang 
      }
      """
    )
  }

  func testTypeExpr15() {
    AssertParse(
      """
      class B {
        class func baseMethod() {}
      }
      class D: B {
        class func derivedMethod() {}
      }
      """
    )
  }

  func testTypeExpr16() {
    AssertParse(
      """
      func derivedType() {
        let _: B.Type = D.self
        _ = D.baseMethod
        let _ : () = D.baseMethod()
        let _: D.Type = D.self
        _ = D.derivedMethod
        let _ : () = D.derivedMethod()
        let _: B.Type = D 
        let _: D.Type = D 
      }
      """
    )
  }

  func testTypeExpr17() {
    AssertParse(
      #"""
      // Referencing a nonexistent member or constructor should not trigger errors
      // about the type expression.
      func nonexistentMember() {
        let cons = Foo("this constructor does not exist") 
        let prop = Foo.nonexistent 
        let meth = Foo.nonexistent() 
      }
      """#
    )
  }

  func testTypeExpr18() {
    AssertParse(
      """
      protocol P {}
      """
    )
  }

  func testTypeExpr19() {
    AssertParse(
      """
      func meta_metatypes() {
        let _: P.Protocol = P.self
        _ = P.Type.self
        _ = P.Protocol.self
        _ = P.Protocol.Protocol.self 
        _ = P.Protocol.Type.self
        _ = B.Type.self
      }
      """
    )
  }

  func testTypeExpr20() {
    AssertParse(
      """
      class E {
        private init() {}
      }
      """
    )
  }

  func testTypeExpr21() {
    AssertParse(
      """
      func inAccessibleInit() {
        _ = E 
      }
      """
    )
  }

  func testTypeExpr22() {
    AssertParse(
      """
      enum F: Int {
        case A, B
      }
      """
    )
  }

  func testTypeExpr23() {
    AssertParse(
      """
      struct G {
        var x: Int
      }
      """
    )
  }

  func testTypeExpr24() {
    AssertParse(
      """
      func implicitInit() {
        _ = F 
        _ = G 
      }
      """
    )
  }

  func testTypeExpr25a() {
    AssertParse(
      """
      _ = [(Int) -> Int]()
      """
    )
  }

  func testTypeExpr25b() {
    AssertParse(
      """
      _ = [(Int, Int) -> Int]()
      """
    )
  }

  func testTypeExpr25c() {
    AssertParse(
      """
      _ = [(x: Int, y: Int) -> Int]()
      """
    )
  }

  func testTypeExpr25d() {
    AssertParse(
      """
      // Make sure associativity is correct
      let a = [(Int) -> (Int) -> Int]()
      """
    )
  }

  func testTypeExpr25e() {
    AssertParse(
      """
      let b: Int = a[0](5)(4)
      """
    )
  }

  func testTypeExpr25f() {
    AssertParse(
      """
      _ = [String: (Int) -> Int]()
      """
    )
  }

  func testTypeExpr25g() {
    AssertParse(
      """
      _ = [String: (Int, Int) -> Int]()
      """
    )
  }

  func testTypeExpr25h() {
    AssertParse(
      """
      _ = [1 -> Int]()
      """
    )
  }

  func testTypeExpr25i() {
    AssertParse(
      """
      _ = [Int -> 1]()
      """
    )
  }

  func testTypeExpr25j() {
    AssertParse(
      """
      // Should parse () as void type when before or after arrow
      _ = [() -> Int]()
      """
    )
  }

  func testTypeExpr25k() {
    AssertParse(
      """
      _ = [(Int) -> ()]()
      """
    )
  }

  func testTypeExpr25l() {
    AssertParse(
      """
      _ = 2 + () -> Int
      """
    )
  }

  func testTypeExpr25m() {
    AssertParse(
      """
      _ = () -> (Int, Int).2
      """
    )
  }

  func testTypeExpr25n() {
    AssertParse(
      """
      _ = (Int) -> Int
      """
    )
  }

  func testTypeExpr25o() {
    AssertParse(
      """
      _ = @convention(c) () -> Int
      """
    )
  }

  func testTypeExpr25p() {
    AssertParse(
      """
      _ = 1 + (@convention(c) () -> Int).self
      """
    )
  }

  func testTypeExpr25q() {
    AssertParse(
      """
      _ = (@autoclosure () -> Int) -> (Int, Int).2
      """
    )
  }

  func testTypeExpr25r() {
    AssertParse(
      """
      _ = ((@autoclosure () -> Int) -> (Int, Int)).1
      """
    )
  }

  func testTypeExpr25s() {
    AssertParse(
      """
      _ = ((inout Int) -> Void).self
      """
    )
  }

  func testTypeExpr25t() {
    AssertParse(
      """
      _ = [(Int) throws -> Int]()
      """
    )
  }

  func testTypeExpr25u() {
    AssertParse(
      """
      _ = [@convention(swift) (Int) throws -> Int]().count
      """
    )
  }

  func testTypeExpr25v() {
    AssertParse(
      """
      _ = [(inout Int) throws -> (inout () -> Void) -> Void]().count
      """
    )
  }

  func testTypeExpr25w() {
    AssertParse(
      """
      _ = [String: (@autoclosure (Int) -> Int32) -> Void]().keys
      """
    )
  }

  func testTypeExpr25x() {
    AssertParse(
      """
      let _ = [(Int) -> 1️⃣throws Int]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "'throws' may only occur before '->'")
      ],
      fixedSource: """
        let _ = [(Int) throws -> Int]()
        """
    )
  }

  func testTypeExpr25y() {
    AssertParse(
      """
      let _ = [Int throws 1️⃣Int]();
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '->' in array element")
      ]
    )
  }

  func testTypeExpr26() {
    AssertParse(
      """
      protocol P1 {}
      protocol P2 {}
      protocol P3 {}
      func compositionType() {
        _ = P1 & P2 
        _ = P1 & P2.self 
        _ = (P1 & P2).self // Ok.
        _ = (P1 & (P2)).self // FIXME: OK? while `typealias P = P1 & (P2)` is rejected.
        _ = (P1 & (P2, P3)).self 
        _ = (P1 & Int).self 
        _ = (P1? & P2).self 
        _ = (P1 & P2.Type).self 
        _ = P1 & P2 -> P3
        _ = P1 & P2 -> P3 & P1 -> Int
        _ = (() -> P1 & P2).self // Ok
        _ = (P1 & P2 -> P3 & P2).self 
        _ = ((P1 & P2) -> (P3 & P2) -> P1 & Any).self // Ok
      }
      """
    )
  }

  func testTypeExpr27() {
    AssertParse(
      """
      func complexSequence() {
        // (assign_expr
        //   (discard_assignment_expr)
        //   (try_expr
        //     (type_expr typerepr='P1 & P2 throws -> P3 & P1')))
        _ = try P1 & P2 throws -> P3 & P1
      }
      """
    )
  }

  func testTypeExpr28() {
    AssertParse(
      """
      func takesVoid(f: 1️⃣Void 2️⃣-> ()) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start function type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' in function type"),
      ]
    )
  }

  func testTypeExpr29() {
    AssertParse(
      """
      func takesOneArg<T>(_: T.Type) {}
      func takesTwoArgs<T>(_: T.Type, _: Int) {}
      """
    )
  }

  func testTypeExpr30() {
    AssertParse(
      """
      func testMissingSelf() {
        // None of these were not caught in Swift 3.
        // See test/Compatibility/type_expr.swift.
        takesOneArg(Int)
        takesOneArg(Swift.Int)
        takesTwoArgs(Int, 0)
        takesTwoArgs(Swift.Int, 0)
        Swift.Int 
        _ = Swift.Int
      }
      """
    )
  }

}
