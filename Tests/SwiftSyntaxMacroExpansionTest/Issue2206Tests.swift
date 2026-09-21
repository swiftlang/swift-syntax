
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

private struct NoOpMemberMacro: MemberMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    return []
  }
}

final class Issue2206Tests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testMemberMacroOnVariable() {
    // Issue #2206: assertMacroExpansion should emit an error if member macro is applied to declaration that can’t have members
    // Currently this is expected to FAIL because the diagnostic is swallowed.
    assertMacroExpansion(
      """
      @Test
      var x: Int
      """,
      expandedSource: """
        var x: Int
        """,
      diagnostics: [
        DiagnosticSpec(message: "macro 'Test' can only be applied to a struct, enum, class, extension, or actor", line: 1, column: 1)
      ],
      macros: ["Test": NoOpMemberMacro.self],
      indentationWidth: indentationWidth
    )
  }
}
