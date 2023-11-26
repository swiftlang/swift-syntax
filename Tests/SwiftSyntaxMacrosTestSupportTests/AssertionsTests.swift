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

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class AssertionsTests: XCTestCase {
  struct OnlyStruct: DiagnosticMessage {
    var message = "'@NoStruct' cannot be applied to struct types"
    var diagnosticID = MessageID(domain: "\(AssertionsTests.self)", id: "\(OnlyStruct.self)")
    var severity = DiagnosticSeverity.error
  }

  struct NoStruct: MemberMacro {
    static func expansion(
      of node: AttributeSyntax,
      providingMembersOf declaration: some DeclGroupSyntax,
      conformingTo protocols: [TypeSyntax],
      in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
      if let structDecl = declaration.as(StructDeclSyntax.self) {
        context.diagnose(
          .init(
            node: structDecl.structKeyword,
            message: OnlyStruct()
          )
        )
      }
      return []
    }
  }

  struct NoStructMultiHighlight: MemberMacro {
    static func expansion(
      of node: AttributeSyntax,
      providingMembersOf declaration: some DeclGroupSyntax,
      conformingTo protocols: [TypeSyntax],
      in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
      if let structDecl = declaration.as(StructDeclSyntax.self) {
        context.diagnose(
          .init(
            node: structDecl.structKeyword,
            message: OnlyStruct(),
            highlights: [
              Syntax(structDecl.structKeyword),
              Syntax(structDecl.name),
            ]
          )
        )
      }
      return []
    }
  }

  func testAssertMacroExpansionIgnoresHighlightMatchingIfNil() {
    assertMacroExpansion(
      "@NoStruct struct S { }",
      expandedSource: "struct S { }",
      diagnostics: [
        .init(message: OnlyStruct().message, line: 1, column: 11)
      ],
      macros: ["NoStruct": NoStruct.self]
    )
  }

  @available(*, deprecated)
  func testAssertMacroExpansionMatchesSingleStringHighlight() {
    assertMacroExpansion(
      "@NoStruct struct S { }",
      expandedSource: "struct S { }",
      diagnostics: [
        .init(message: OnlyStruct().message, line: 1, column: 11, highlight: "struct")
      ],
      macros: ["NoStruct": NoStruct.self]
    )
  }

  func testAssertMacroExpansionMatchesArrayHighlight() {
    assertMacroExpansion(
      "@NoStruct struct S { }",
      expandedSource: "struct S { }",
      diagnostics: [
        .init(message: OnlyStruct().message, line: 1, column: 11, highlights: ["struct", "S"])
      ],
      macros: ["NoStruct": NoStructMultiHighlight.self]
    )
  }
}
