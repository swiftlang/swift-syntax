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

  func testPackExpansion() throws {
    AssertParse(
      """
      func f1<@_typeSequence T>() -> T... {}
      func f2<@_typeSequence T>() -> (T...) {}
      func f3<@_typeSequence T>() -> G<T... > {}
      """)

    AssertParse(
      """
      enum E<@_typeSequence T> {
        case f1(_: T...)
        case f2(_: G<T... >)
        var x: T... { fatalError() }
        var x: (T...) { fatalError() }
        subscript(_: T...) -> Int { fatalError() }
        subscript() -> T... { fatalError() }
        subscript() -> (T...) { fatalError() }
      }
      """)
  }
}

