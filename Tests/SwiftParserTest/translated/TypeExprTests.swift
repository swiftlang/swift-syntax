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

// This test file has been translated from swift/test/Parse/type_expr.swift

import SwiftSyntax
import XCTest

// Types in expression contexts must be followed by a member access or
// constructor call.
final class TypeExprTests: ParserTestCase {
  func testTypeExpr3() {
    assertParse(
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
    assertParse(
      """
      protocol Zim {
        associatedtype Zang
        init()
        static func meth() {}
        func instMeth() {}
      }
      """
    )
  }

  func testTypeExpr5() {
    assertParse(
      """
      protocol Bad {
        init() {}
      }
      """
    )
  }

  func testTypeExpr6() {
    assertParse(
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
    assertParse(
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
    assertParse(
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

    assertParse("(X).Y.self", { ExprSyntax.parse(from: &$0) })
    assertParse("(X.Y).Z.self", { ExprSyntax.parse(from: &$0) })
    assertParse("((X).Y).Z.self", { ExprSyntax.parse(from: &$0) })
  }

  func testTypeExpr9() {
    assertParse(
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
    assertParse(
      """
      func genType() {
        _ = Gen<Foo>.self
        _ = Gen<Foo>()
        _ = Gen<Foo>.prop
        _ = Gen<Foo>.meth
        let _ : () = Gen<Foo>.meth()
        _ = Gen<Foo>.instMeth
        _ = Gen<Foo>

        _ = X?.self
        _ = [X].self
        _ = [X : Y].self
      }
      """
    )

    assertParse("X?.self", { ExprSyntax.parse(from: &$0) })
    assertParse("[X].self", { ExprSyntax.parse(from: &$0) })
    assertParse("[X : Y].self", { ExprSyntax.parse(from: &$0) })
  }

  func testTypeExpr11() {
    assertParse(
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

        _ = (G<X>).Y.self
        _ = X?.Y.self
        _ = (X)?.Y.self
        _ = (X?).Y.self
        _ = [X].Y.self
        _ = [X : Y].Z.self
      }
      """
    )

    assertParse("(G<X>).Y.self", { ExprSyntax.parse(from: &$0) })
    assertParse("X?.Y.self", { ExprSyntax.parse(from: &$0) })
    assertParse("(X)?.Y.self", { ExprSyntax.parse(from: &$0) })
    assertParse("(X?).Y.self", { ExprSyntax.parse(from: &$0) })
    assertParse("[X].Y.self", { ExprSyntax.parse(from: &$0) })
    assertParse("[X : Y].Z.self", { ExprSyntax.parse(from: &$0) })
  }

  func testTypeExpr12() {
    assertParse(
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
    assertParse(
      """
      func archetype<T: Zim>(_: T) {
        _ = T.self
        _ = T()
        _ = T.meth
        let _ : () = T.meth()
        _ = T
      }
      """
    )
  }

  func testTypeExpr14() {
    assertParse(
      """
      func assocType<T: Zim>(_: T) where T.Zang: Zim {
        _ = T.Zang.self
        _ = T.Zang()
        _ = T.Zang.meth
        let _ : () = T.Zang.meth()
        _ = T.Zang
      }
      """
    )
  }

  func testTypeExpr15() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      protocol P {}
      """
    )
  }

  func testTypeExpr19() {
    assertParse(
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
    assertParse(
      """
      class E {
        private init() {}
      }
      """
    )
  }

  func testTypeExpr21() {
    assertParse(
      """
      func inAccessibleInit() {
        _ = E
      }
      """
    )
  }

  func testTypeExpr22() {
    assertParse(
      """
      enum F: Int {
        case A, B
      }
      """
    )
  }

  func testTypeExpr23() {
    assertParse(
      """
      struct G {
        var x: Int
      }
      """
    )
  }

  func testTypeExpr24() {
    assertParse(
      """
      func implicitInit() {
        _ = F
        _ = G
      }
      """
    )
  }

  func testTypeExpr25a() {
    assertParse(
      """
      _ = [(Int) -> Int]()
      """
    )
  }

  func testTypeExpr25b() {
    assertParse(
      """
      _ = [(Int, Int) -> Int]()
      """
    )
  }

  func testTypeExpr25c() {
    assertParse(
      """
      _ = [(x: Int, y: Int) -> Int]()
      """
    )
  }

  func testTypeExpr25d() {
    assertParse(
      """
      // Make sure associativity is correct
      let a = [(Int) -> (Int) -> Int]()
      """
    )
  }

  func testTypeExpr25e() {
    assertParse(
      """
      let b: Int = a[0](5)(4)
      """
    )
  }

  func testTypeExpr25f() {
    assertParse(
      """
      _ = [String: (Int) -> Int]()
      """
    )
  }

  func testTypeExpr25g() {
    assertParse(
      """
      _ = [String: (Int, Int) -> Int]()
      """
    )
  }

  func testTypeExpr25h() {
    assertParse(
      """
      _ = [1 -> Int]()
      """
    )
  }

  func testTypeExpr25i() {
    assertParse(
      """
      _ = [Int -> 1]()
      """
    )
  }

  func testTypeExpr25j() {
    assertParse(
      """
      // Should parse () as void type when before or after arrow
      _ = [() -> Int]()
      """
    )
  }

  func testTypeExpr25k() {
    assertParse(
      """
      _ = [(Int) -> ()]()
      """
    )
  }

  func testTypeExpr25l() {
    assertParse(
      """
      _ = 2 + () -> Int
      """
    )
  }

  func testTypeExpr25m() {
    assertParse(
      """
      _ = () -> (Int, Int).2
      """
    )
  }

  func testTypeExpr25n() {
    assertParse(
      """
      _ = (Int) -> Int
      """
    )
  }

  func testTypeExpr25o() {
    assertParse(
      """
      _ = @convention(c) () -> Int
      """
    )
  }

  func testTypeExpr25p() {
    assertParse(
      """
      _ = 1 + (@convention(c) () -> Int).self
      """
    )
  }

  func testTypeExpr25q() {
    assertParse(
      """
      _ = (@autoclosure () -> Int) -> (Int, Int).2
      """
    )
  }

  func testTypeExpr25r() {
    assertParse(
      """
      _ = ((@autoclosure () -> Int) -> (Int, Int)).1
      """
    )
  }

  func testTypeExpr25s() {
    assertParse(
      """
      _ = ((inout Int) -> Void).self
      """
    )
  }

  func testTypeExpr25t() {
    assertParse(
      """
      _ = [(Int) throws -> Int]()
      """
    )
  }

  func testTypeExpr25u() {
    assertParse(
      """
      _ = [@convention(swift) (Int) throws -> Int]().count
      """
    )
  }

  func testTypeExpr25v() {
    assertParse(
      """
      _ = [(inout Int) throws -> (inout () -> Void) -> Void]().count
      """
    )
  }

  func testTypeExpr25w() {
    assertParse(
      """
      _ = [String: (@autoclosure (Int) -> Int32) -> Void]().keys
      """
    )
  }

  func testTypeExpr25x() {
    assertParse(
      """
      let _ = [(Int) -> 1️⃣throws Int]()
      """,
      diagnostics: [
        DiagnosticSpec(message: "'throws' must precede '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: """
        let _ = [(Int) throws -> Int]()
        """
    )
  }

  func testTypeExpr25y() {
    assertParse(
      """
      let _ = [Int throws 1️⃣Int]();
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '->' in array element", fixIts: ["insert '->'"])
      ],
      fixedSource: """
        let _ = [Int throws -> Int]();
        """
    )
  }

  func testCompositionTypeExpr() {
    assertParse("P & Q", { ExprSyntax.parse(from: &$0) })
    assertParse("P & Q.self", { ExprSyntax.parse(from: &$0) })
    assertParse("any P & Q", { ExprSyntax.parse(from: &$0) })

    assertParse("(P & Q).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((P) & (Q)).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(A.B & C.D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((A).B & (C).D).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(G<X> & G<Y>).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(X? & Y?).self", { ExprSyntax.parse(from: &$0) })
    assertParse("([X] & [Y]).self", { ExprSyntax.parse(from: &$0) })
    assertParse("([A : B] & [C : D]).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(G<A>.B & G<C>.D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(A?.B & C?.D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("([A].B & [A].B).self", { ExprSyntax.parse(from: &$0) })
    assertParse("([A : B].C & [D : E].F).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(X.Type & Y.Type).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(X.Protocol & Y.Protocol).self", { ExprSyntax.parse(from: &$0) })

    assertParse("((A, B) & (C, D)).self", { ExprSyntax.parse(from: &$0) })
  }

  func testTupleTypeExpr() {
    assertParse("(X).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(X, Y)", { ExprSyntax.parse(from: &$0) })

    assertParse("(X, Y).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((X), (Y)).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(A.B, C.D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((A).B, (C).D).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(G<X>, G<Y>).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(X?, Y?).self", { ExprSyntax.parse(from: &$0) })
    assertParse("([X], [Y]).self", { ExprSyntax.parse(from: &$0) })
    assertParse("([A : B], [C : D]).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(G<A>.B, G<C>.D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(A?.B, C?.D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("([A].B, [C].D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("([A : B].C, [D : E].F).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(X.Type, Y.Type).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(X.Protocol, Y.Protocol).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(P & Q, P & Q).self", { ExprSyntax.parse(from: &$0) })

    assertParse(
      """
      (
        (G<X>.Y) -> (P) & X?.Y, (X.Y, [X : Y?].Type), [(G<X>).Y], [A.B.C].D
      ).self
      """,
      { ExprSyntax.parse(from: &$0) }
    )
  }

  func testFunctionTypeExpr() {
    assertParse("X -> Y", { ExprSyntax.parse(from: &$0) })
    assertParse("(X) -> Y", { ExprSyntax.parse(from: &$0) })
    assertParse("(X) -> Y -> Z", { ExprSyntax.parse(from: &$0) })
    assertParse("P & Q -> X", { ExprSyntax.parse(from: &$0) })
    assertParse("A & B -> C & D -> X", { ExprSyntax.parse(from: &$0) })
    assertParse("(X -> Y).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(A & B -> C & D).self", { ExprSyntax.parse(from: &$0) })

    assertParse("((X) -> Y).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(((X)) -> (Y)).self", { ExprSyntax.parse(from: &$0) })

    assertParse("((A.B) -> C.D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(((A).B) -> (C).D).self", { ExprSyntax.parse(from: &$0) })

    assertParse("((G<X>) -> G<Y>).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((X?) -> Y?).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(([X]) -> [Y]).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(([A : B]) -> [C : D]).self", { ExprSyntax.parse(from: &$0) })

    assertParse("((Gen<Foo>.Bar) -> Gen<Foo>.Bar).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((Foo?.Bar) -> Foo?.Bar).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(([Foo].Element) -> [Foo].Element).self", { ExprSyntax.parse(from: &$0) })
    assertParse("(([Int : Foo].Element) -> [Int : Foo].Element).self", { ExprSyntax.parse(from: &$0) })

    assertParse("((X.Type) -> Y.Type).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((X.Protocol) -> Y.Protocol).self", { ExprSyntax.parse(from: &$0) })

    assertParse("(() -> X & Y).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((A & B) -> C & D).self", { ExprSyntax.parse(from: &$0) })
    assertParse("((A & B) -> (C & D) -> E & Any).self", { ExprSyntax.parse(from: &$0) })

    assertParse(
      """
      (
        ((P) & X?.Y, G<X>.Y, (X, [A : B?].Type)) -> ([(X).Y]) -> [X].Y
      ).self
      """,
      { ExprSyntax.parse(from: &$0) }
    )
  }

  func testTypeExpr27() {
    assertParse(
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
    assertParse(
      """
      func takesVoid(f: 1️⃣Void2️⃣ -> ()) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start function type", fixIts: ["insert '('"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' in function type", fixIts: ["insert ')'"]),
      ],
      fixedSource: """
        func takesVoid(f: (Void) -> ()) {}
        """
    )
  }

  func testTypeExpr29() {
    assertParse(
      """
      func takesOneArg<T>(_: T.Type) {}
      func takesTwoArgs<T>(_: T.Type, _: Int) {}
      """
    )
  }

  func testTypeExpr30() {
    assertParse(
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

  func testTypeExpr31() {
    assertParse(
      """
      let _: 1️⃣Float2️⃣       -> Int
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '(' to start function type", fixIts: ["insert '('"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' in function type", fixIts: ["insert ')'"]),
      ],
      fixedSource: """
        let _: (Float) -> Int
        """
    )
  }

}
