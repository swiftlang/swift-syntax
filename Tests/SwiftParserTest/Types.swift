@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class TypeTests: XCTestCase {
  
  func testMissingColonInType() {
    AssertParse(
      """
      var foo 1️⃣Bar = 1
      """, diagnostics: [
        DiagnosticSpec(message: "expected ':' in type annotation")
      ])
  }
    
  func testClosureParsing() throws {
    AssertParse(
      "(a, b) -> c",
      { $0.parseType() }
    )

    AssertParse(
      "@MainActor (a, b) async throws -> c",
      { $0.parseType() }
    )

    AssertParse("() -> (\u{feff})")
  }

  func testGenericTypeWithTrivia() throws {
    // N.B. Whitespace is significant here.
    AssertParse(
      """
              Foo<Bar<
                  V, Baz<Quux>
              >>
      """,
      { $0.parseType() }
    )
  }

  func testFunctionTypes() throws {
    AssertParse("t as(1️⃣..)->2️⃣", diagnostics: [
      DiagnosticSpec(locationMarker: "1️⃣", message: "expected type in function type"),
      DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '..' in function type"),
      DiagnosticSpec(locationMarker: "2️⃣", message: "expected type in function type"),
    ])
  }

  func testClosureSignatures() throws {

    AssertParse(
      """
      simple { [] str in
        print("closure with empty capture list")
      }
      """)
    
    AssertParse("""
                { ()
                throws -> Void in }
                """,
                { $0.parseClosureExpression() })

    AssertParse("""
                { [weak a, unowned(safe) self, b = 3] (a: Int, b: Int, _: Int) -> Int in }
                """,
                { $0.parseClosureExpression() })

    AssertParse("{[1️⃣class]in2️⃣",
                { $0.parseClosureExpression() },
                diagnostics: [
                  DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in closure capture item"),
                  DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'class' in closure capture signature"),
                  DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end closure"),
                ])

    AssertParse("{[n1️⃣`]in}",
                { $0.parseClosureExpression() },
                diagnostics: [
                  DiagnosticSpec(message: "unexpected code '`' in closure capture signature")
                ])

    AssertParse("{[weak1️⃣^]in}",
                { $0.parseClosureExpression() },
                diagnostics: [
                  DiagnosticSpec(message: "expected identifier in closure capture item"),
                  DiagnosticSpec(message: "unexpected code '^' in closure capture signature"),
                ])
  }

  func testOpaqueReturnTypes() throws {
    AssertParse("""
                public typealias Body = @_opaqueReturnTypeOf("$s6CatKit10pspspspspsV5cmereV6lilguyQrvp", 0) __
                """)
  }

  func testVariadics() throws {
    AssertParse(
      #"""
      func takesVariadicFnWithGenericRet<T>(_ fn: (S...) -> T) {}
      let _: (S...) -> Int = \.i
      let _: (S...) -> Int = \Array.i1️⃣
      let _: (S...) -> Int = \S.i2️⃣
      """#
    )
  }

  func testConvention() throws {
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
      """#)
  }

  func testMetatypes() throws {
    AssertParse(
      """
      arg.covariantAssocMetatype1 { (_: Any.Type.Type.Type) in }
      """)
    
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
      """)
  }

  func testNamedOpaqueReturnTypes() throws {
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
      """)
  }
}

final class TypeParameterPackTests: XCTestCase {
  func testParameterPacks1() throws {
    AssertParse(
      """
      func f1<T...>() -> T... {}
      """)
  }
  func testParameterPacks2() throws {
    AssertParse(
      """
      func f2<T...>() -> (T...) {}
      """)
  }
  func testParameterPacks3() throws {
    AssertParse(
      """
      func f3<T...>() -> G<T... > {}
      """)
  }
  func testParameterPacks4() throws {
    AssertParse(
      """
      protocol P {
        associatedtype T1️⃣...
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "associated types cannot be variadic",
                       fixIts: ["remove '...'"])
      ])
  }
  func testParameterPacks5() throws {
    AssertParse(
    """
    typealias Alias<T...> = (T...)
    """)
  }
  func testParameterPacks6() throws {
    AssertParse(
      """
      struct S<T...> {}
      """)
  }
  func testParameterPacks7() throws {
    AssertParse(
      """
      struct S<T, U...> {}
      """)
  }
  func testParameterPacks8() throws {
    AssertParse(
      """
      struct S<T..., U> {}
      """)
  }
  func testParameterPacks9() throws {
    AssertParse(
      """
      struct S<T...:P, U> {}
      """)
  }
  func testParameterPacks10() throws {
    AssertParse(
      """
      struct S<T... :P, U> {}
      """)
  }
  func testParameterPacks11() throws {
    AssertParse(
      """
      struct S<T...: P> {}
      """)
  }
  func testParameterPacks12() throws {
    AssertParse(
      """
      struct S<T... : P> {}
      """)
  }
  func testParameterPacks13() throws {
    AssertParse(
      """
      func foo<T...>(_ x: T...) {}
      """)
  }
  func testParameterPacks14() throws {
    AssertParse(
      """
      func foo<T...:P>(_ x: T...) {}
      """)
  }
  func testParameterPacks15() throws {
    AssertParse(
      """
      func foo<T... :P>(_ x: T...) {}
      """)
  }
  func testParameterPacks16() throws {
    AssertParse(
      """
      func foo<T... : P>(_ x: T...) {}
      """)
  }
  func testParameterPacks17() throws {
    AssertParse(
      """
      func foo<T...: P>(_ x: T...) {}
      """)
  }
  func testParameterPacks18() throws {
    AssertParse(
      """
      func foo<T, U, V...>(x: T, y: U, z: V...) { }
      """)
  }
  func testParameterPacks19() throws {
    AssertParse(
      """
      func foo<T, U..., V>(x: T, y: U..., z: V) { }
      """)
  }
  func testParameterPacks20() throws {
    AssertParse(
      """
      func foo<T..., U..., V...>(x: T..., y: U..., z: V...) { }
      """)
  }
  func testParameterPacks21() throws {
    AssertParse(
      """
      enum E<T...> {
        case f1(_: T...)
      }
      """)
  }
  func testParameterPacks22() throws {
    AssertParse(
      """
      enum E<T...> {
        case f2(_: G<T... >)
      }
      """)
  }
  func testParameterPacks23() throws {
    AssertParse(
      """
      enum E<T...> {
        var x: T... { fatalError() }
      }
      """)
  }
  func testParameterPacks24() throws {
    AssertParse(
      """
      enum E<T...> {
        var x: (T...) { fatalError() }
      }
      """)
  }
  func testParameterPacks25() throws {
    AssertParse(
      """
      enum E<T...> {
        subscript(_: T...) -> Int { fatalError() }
      }
      """)
  }
  func testParameterPacks26() throws {
    AssertParse(
      """
      enum E<T...> {
        subscript() -> T... { fatalError() }
      }
      """)
  }
  func testParameterPacks27() throws {
    AssertParse(
      """
      enum E<T...> {
        subscript() -> (T...) { fatalError() }
      }
      """)
  }
}

