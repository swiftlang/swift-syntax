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

@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class TypeTests: XCTestCase {

  func testMissingColonInType() {
    AssertParse(
      """
      var foo 1️⃣Bar = 1
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in type annotation")
      ]
    )
  }

  func testClosureParsing() {
    AssertParse(
      "(a, b) -> c",
      { TypeSyntax.parse(from: &$0) }
    )

    AssertParse(
      "@MainActor (a, b) async throws -> c",
      { TypeSyntax.parse(from: &$0) }
    )

    AssertParse("() -> (\u{feff})")
  }

  func testGenericTypeWithTrivia() {
    // N.B. Whitespace is significant here.
    AssertParse(
      """
              Foo<Bar<
                  V, Baz<Quux>
              >>
      """,
      { TypeSyntax.parse(from: &$0) }
    )
  }

  func testFunctionTypes() {
    AssertParse(
      "t as(1️⃣..)->2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in function type"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '..' in function type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected type in function type"),
      ]
    )
  }

  func testClosureSignatures() {

    AssertParse(
      """
      simple { [] str in
        print("closure with empty capture list")
      }
      """
    )

    AssertParse(
      """
      { ()
      throws -> Void in }
      """,
      { ExprSyntax.parse(from: &$0) }
    )

    AssertParse(
      """
      { [weak a, unowned(safe) self, b = 3] (a: Int, b: Int, _: Int) -> Int in }
      """,
      { ExprSyntax.parse(from: &$0) }
    )

    AssertParse(
      "{[1️⃣class]in2️⃣",
      { ExprSyntax.parse(from: &$0) },
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in closure capture item"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected 'class' keyword in closure capture signature"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end closure"),
      ]
    )

    AssertParse(
      "{[n1️⃣`]in}",
      { ExprSyntax.parse(from: &$0) },
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '`' in closure capture signature")
      ]
    )

    AssertParse(
      "{[weak1️⃣^]in}",
      { ExprSyntax.parse(from: &$0) },
      diagnostics: [
        DiagnosticSpec(message: "expected identifier in closure capture item"),
        DiagnosticSpec(message: "unexpected code '^' in closure capture signature"),
      ]
    )
  }

  func testOpaqueReturnTypes() {
    AssertParse(
      """
      public typealias Body = @_opaqueReturnTypeOf("$s6CatKit10pspspspspsV5cmereV6lilguyQrvp", 0) __
      """
    )
  }

  func testVariadics() {
    AssertParse(
      #"""
      func takesVariadicFnWithGenericRet<T>(_ fn: (S...) -> T) {}
      let _: (S...) -> Int = \.i
      let _: (S...) -> Int = \Array.i1️⃣
      let _: (S...) -> Int = \S.i2️⃣
      """#
    )
  }

  func testConvention() {
    AssertParse(
      #"""
      let _: @convention(thin) (@convention(thick) () -> (),
                                @convention(thin) () -> (),
                                @convention(c) () -> (),
                                @convention(c, cType: "intptr_t (*)(size_t)") (Int) -> Int,
                                @convention(block) () -> (),
                                @convention(method) () -> (),
                                @convention(objc_method) () -> (),
                                @convention(witness_method: Bendable) (Fork) -> ()) -> ()
      """#
    )
  }

  func testMetatypes() {
    AssertParse(
      """
      arg.covariantAssocMetatype1 { (_: Any.Type.Type.Type) in }
      """
    )

    AssertParse(
      """
      protocol CovariantMetatypes {
        associatedtype Q

        func covariantSelfMetatype1(_: (Self.Type.Type.Type) -> Void)
        func covariantSelfMetatype2() -> (Self.Type, Self.Type.Type)

        func covariantAssocMetatype1(_: (Q.Type.Type.Type) -> Void)
        func covariantAssocMetatype2() -> (Q.Type, Q.Type.Type)

        var covariantSelfMetatypeProp1: Self.Type.Type.Type { get }
        var covariantSelfMetatypeProp2: (Self.Type, Self.Type.Type) { get }

        var covariantAssocMetatypeProp1: Q.Type.Type.Type { get }
        var covariantAssocMetatypeProp2: (Q.Type, Q.Type.Type) { get }

        subscript(covariantSelfMetatypeSubscript1 _: (Self.Type.Type.Type) -> Void) -> Self.Type { get }
        subscript(covariantSelfMetatypeSubscript2 _: Void) -> (Self.Type, Self.Type.Type) { get }

        subscript(covariantAssocMetatypeSubscript1 _: (Q.Type.Type.Type) -> Void) -> Q.Type { get }
        subscript(covariantAssocMetatypeSubscript2 _: Void) -> (Q.Type, Q.Type.Type) { get }
      }
      """
    )
  }

  func testNamedOpaqueReturnTypes() {
    AssertParse(
      """
      func f2() -> <T: SignedInteger, U: SignedInteger> Int {
      }

      dynamic func lazyMapCollection<C: Collection, T>(_ collection: C, body: @escaping (C.Element) -> T)
          -> <R: Collection where R.Element == T> R {
        return collection.lazy.map { body($0) }
      }

      struct Boom<T: P> {
        var prop1: Int = 5
        var prop2: <U, V> (U, V) = ("hello", 5)
      }
      """
    )
  }
}

final class TypeParameterPackTests: XCTestCase {
  func testParameterPacks1() {
    AssertParse(
      """
      func f1<T...>() -> T... {}
      """
    )
  }
  func testParameterPacks2() {
    AssertParse(
      """
      func f2<T...>() -> (T...) {}
      """
    )
  }
  func testParameterPacks3() {
    AssertParse(
      """
      func f3<T...>() -> G<T... > {}
      """
    )
  }
  func testParameterPacks4() {
    AssertParse(
      """
      protocol P {
        associatedtype T1️⃣...
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "associated types cannot be variadic",
          fixIts: ["remove '...'"]
        )
      ]
    )
  }
  func testParameterPacks5() {
    AssertParse(
      """
      typealias Alias<T...> = (T...)
      """
    )
  }
  func testParameterPacks6() {
    AssertParse(
      """
      struct S<T...> {}
      """
    )
  }
  func testParameterPacks7() {
    AssertParse(
      """
      struct S<T, U...> {}
      """
    )
  }
  func testParameterPacks8() {
    AssertParse(
      """
      struct S<T..., U> {}
      """
    )
  }
  func testParameterPacks9() {
    AssertParse(
      """
      struct S<T...:P, U> {}
      """
    )
  }
  func testParameterPacks10() {
    AssertParse(
      """
      struct S<T... :P, U> {}
      """
    )
  }
  func testParameterPacks11() {
    AssertParse(
      """
      struct S<T...: P> {}
      """
    )
  }
  func testParameterPacks12() {
    AssertParse(
      """
      struct S<T... : P> {}
      """
    )
  }
  func testParameterPacks13() {
    AssertParse(
      """
      func foo<T...>(_ x: T...) {}
      """
    )
  }
  func testParameterPacks14() {
    AssertParse(
      """
      func foo<T...:P>(_ x: T...) {}
      """
    )
  }
  func testParameterPacks15() {
    AssertParse(
      """
      func foo<T... :P>(_ x: T...) {}
      """
    )
  }
  func testParameterPacks16() {
    AssertParse(
      """
      func foo<T... : P>(_ x: T...) {}
      """
    )
  }
  func testParameterPacks17() {
    AssertParse(
      """
      func foo<T...: P>(_ x: T...) {}
      """
    )
  }
  func testParameterPacks18() {
    AssertParse(
      """
      func foo<T, U, V...>(x: T, y: U, z: V...) { }
      """
    )
  }
  func testParameterPacks19() {
    AssertParse(
      """
      func foo<T, U..., V>(x: T, y: U..., z: V) { }
      """
    )
  }
  func testParameterPacks20() {
    AssertParse(
      """
      func foo<T..., U..., V...>(x: T..., y: U..., z: V...) { }
      """
    )
  }
  func testParameterPacks21() {
    AssertParse(
      """
      enum E<T...> {
        case f1(_: T...)
      }
      """
    )
  }
  func testParameterPacks22() {
    AssertParse(
      """
      enum E<T...> {
        case f2(_: G<T... >)
      }
      """
    )
  }
  func testParameterPacks23() {
    AssertParse(
      """
      enum E<T...> {
        var x: T... { fatalError() }
      }
      """
    )
  }
  func testParameterPacks24() {
    AssertParse(
      """
      enum E<T...> {
        var x: (T...) { fatalError() }
      }
      """
    )
  }
  func testParameterPacks25() {
    AssertParse(
      """
      enum E<T...> {
        subscript(_: T...) -> Int { fatalError() }
      }
      """
    )
  }
  func testParameterPacks26() {
    AssertParse(
      """
      enum E<T...> {
        subscript() -> T... { fatalError() }
      }
      """
    )
  }
  func testParameterPacks27() {
    AssertParse(
      """
      enum E<T...> {
        subscript() -> (T...) { fatalError() }
      }
      """
    )
  }
  func testParameterPacks28() {
    // We allow whitespace between the generic parameter and the '...', this is
    // consistent with regular variadic parameters.
    AssertParse(
      """
      func f1<T ...>(_ x: T ...) -> (T ...) {}
      """
    )
  }
  func testVariadicTypes() {
    AssertParse(
      """
      let _: G< > = G()
      let _: G<T... > = G()
      let _: G<Int, T... > = G()
      let _ = G< >.self
      let _ = G<T... >.self
      let _ = G<Int, T... >.self
      """
    )

  }

  func testMissingCommaInType() throws {
    AssertParse(
      """
      var foo: (Int)
      """
    )

    AssertParse(
      """
      var foo: (Int, Int)
      """
    )

    AssertParse(
      """
      var foo: (bar: Int 1️⃣bar2: Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (bar: Int 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (a 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (A 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (_ 1️⃣a 2️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in tuple type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ',' in tuple type"),
      ]
    )

    AssertParse(
      """
      var foo: (Array<Foo> 1️⃣Array<Bar>)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (a 1️⃣Array<Bar>)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (Array<Foo> 1️⃣a)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )
  }
}
