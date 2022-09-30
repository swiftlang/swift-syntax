@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class TypeTests: XCTestCase {
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
    AssertParse("t as(#^DIAG^#..)->#^END^#", diagnostics: [
      DiagnosticSpec(message: "expected type in function type"),
      DiagnosticSpec(message: "unexpected text '..' in function type"),
      DiagnosticSpec(locationMarker: "END", message: "expected type in function type"),
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

    AssertParse("{[#^DIAG_1^#class]in#^DIAG_2^#",
                { $0.parseClosureExpression() },
                diagnostics: [
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in closure capture item"),
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text 'class' in closure capture signature"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '}' to end closure"),
                ])

    AssertParse("{[n#^DIAG^#`]in}",
                { $0.parseClosureExpression() },
                diagnostics: [
                  DiagnosticSpec(message: "unexpected text '`' in closure capture signature")
                ])

    AssertParse("{[weak#^DIAG^#^]in}",
                { $0.parseClosureExpression() },
                diagnostics: [
                  DiagnosticSpec(message: "expected identifier in closure capture item"),
                  DiagnosticSpec(message: "unexpected text '^' in closure capture signature"),
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
      let _: (S...) -> Int = \Array.i#^DIAG_1^#
      let _: (S...) -> Int = \S.i#^DIAG_2^#
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

