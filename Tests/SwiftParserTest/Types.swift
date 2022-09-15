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
    AssertParse("t as(#^DIAG^#..)->", diagnostics: [
      DiagnosticSpec(message: "Unexpected text '..' in function type")
    ])
  }

  func testClosureSignatures() throws {
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
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Expected '' in closure capture item"),
                  DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text 'class' in closure capture signature"),
                  DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}' to end closure"),
                ])

    AssertParse("{[n#^DIAG^#`]in}",
                { $0.parseClosureExpression() },
                diagnostics: [
                  DiagnosticSpec(message: "Unexpected text '`' in closure capture signature")
                ])

    AssertParse("{[weak#^DIAG^#^]in}",
                { $0.parseClosureExpression() },
                diagnostics: [
                  DiagnosticSpec(message: "Expected '' in closure capture item"),
                  DiagnosticSpec(message: "Unexpected text '^' in closure capture signature"),
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
      let _: (S...) -> Int = \Array.i
      let _: (S...) -> Int = \S.i
      """#)
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
}

