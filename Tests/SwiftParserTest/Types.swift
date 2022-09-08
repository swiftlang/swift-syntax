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
  }
}
