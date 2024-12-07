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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let macroAssertionsFile = makeMacroAssertionsFile()

private func makeMacroAssertionsFile() -> SourceFileSyntax {
  return SourceFileSyntax(leadingTrivia: copyrightHeader) {
    IfConfigDeclSyntax(
      clauses: IfConfigClauseListSyntax {
        IfConfigClauseSyntax(
          poundKeyword: .poundIfToken(),
          condition: ExprSyntax("swift(>=6.0)"),
          elements: .statements(
            CodeBlockItemListSyntax {
              DeclSyntax("public import SwiftSyntax")
              DeclSyntax("public import SwiftSyntaxMacroExpansion")
              DeclSyntax("public import SwiftSyntaxMacros")
              DeclSyntax("@_spi(XCTestFailureLocation) public import SwiftSyntaxMacrosGenericTestSupport")
              DeclSyntax("private import XCTest")
            }
          )
        )
        IfConfigClauseSyntax(
          poundKeyword: .poundElseToken(),
          elements: .statements(
            CodeBlockItemListSyntax {
              DeclSyntax("import SwiftSyntax")
              DeclSyntax("import SwiftSyntaxMacroExpansion")
              DeclSyntax("import SwiftSyntaxMacros")
              DeclSyntax("@_spi(XCTestFailureLocation) import SwiftSyntaxMacrosGenericTestSupport")
              DeclSyntax("import XCTest")
            }
          )
        )
      }
    )

    DeclSyntax(
      """
      // Re-export the spec types from `SwiftSyntaxMacrosGenericTestSupport`.
      public typealias NoteSpec = SwiftSyntaxMacrosGenericTestSupport.NoteSpec
      """
    )
    DeclSyntax("public typealias FixItSpec = SwiftSyntaxMacrosGenericTestSupport.FixItSpec")
    DeclSyntax("public typealias DiagnosticSpec = SwiftSyntaxMacrosGenericTestSupport.DiagnosticSpec")

    makeAssertMacroExpansionFunctions(isAsync: false)
    makeAssertMacroExpansionFunctions(isAsync: true)
  }
}

private func makeAssertMacroExpansionFunctions(isAsync: Bool) -> CodeBlockItemListSyntax {
  let asyncSpecifier = if isAsync { " async" } else { String() }
  let awaitOperator = if isAsync { "await " } else { String() }

  return CodeBlockItemListSyntax() {
    DeclSyntax(
      """
      /// Assert that expanding the given macros in the original source produces
      /// the given expanded source code.
      ///
      /// - Parameters:
      ///   - originalSource: The original source code, which is expected to contain
      ///     macros in various places (e.g., `#stringify(x + y)`).
      ///   - expectedExpandedSource: The source code that we expect to see after
      ///     performing macro expansion on the original source.
      ///   - diagnostics: The diagnostics when expanding any macro
      ///   - macros: The macros that should be expanded, provided as a dictionary
      ///     mapping macro names (e.g., `"stringify"`) to implementation types
      ///     (e.g., `StringifyMacro.self`).
      ///   - testModuleName: The name of the test module to use.
      ///   - testFileName: The name of the test file name to use.
      ///   - indentationWidth: The indentation width used in the expansion.
      ///
      /// - SeeAlso: ``assertMacroExpansion(_:expandedSource:diagnostics:macroSpecs:applyFixIts:fixedSource:testModuleName:testFileName:indentationWidth:file:line:)``
      ///   to also specify the list of conformances passed to the macro expansion.
      public func assertMacroExpansion(
        _ originalSource: String,
        expandedSource expectedExpandedSource: String,
        diagnostics: [DiagnosticSpec] = [],
        macros: [String: Macro.Type],
        applyFixIts: [String]? = nil,
        fixedSource expectedFixedSource: String? = nil,
        testModuleName: String = "TestModule",
        testFileName: String = "test.swift",
        indentationWidth: Trivia = .spaces(4),
        file: StaticString = #filePath,
        line: UInt = #line
      )\(raw: asyncSpecifier) {
        let specs = macros.mapValues { MacroSpec(type: $0) }
        \(raw: awaitOperator)assertMacroExpansion(
          originalSource,
          expandedSource: expectedExpandedSource,
          diagnostics: diagnostics,
          macroSpecs: specs,
          applyFixIts: applyFixIts,
          fixedSource: expectedFixedSource,
          testModuleName: testModuleName,
          testFileName: testFileName,
          indentationWidth: indentationWidth,
          file: file,
          line: line
        )
      }
      """
    )

    DeclSyntax(
      """
      /// Assert that expanding the given macros in the original source produces
      /// the given expanded source code.
      ///
      /// - Parameters:
      ///   - originalSource: The original source code, which is expected to contain
      ///     macros in various places (e.g., `#stringify(x + y)`).
      ///   - expectedExpandedSource: The source code that we expect to see after
      ///     performing macro expansion on the original source.
      ///   - diagnostics: The diagnostics when expanding any macro
      ///   - macroSpecs: The macros that should be expanded, provided as a dictionary
      ///     mapping macro names (e.g., `"CodableMacro"`) to specification with macro type
      ///     (e.g., `CodableMacro.self`) and a list of conformances macro provides
      ///     (e.g., `["Decodable", "Encodable"]`).
      ///   - applyFixIts: If specified, filters the Fix-Its that are applied to generate `fixedSource` to only those whose message occurs in this array. If `nil`, all Fix-Its from the diagnostics are applied.
      ///   - fixedSource: If specified, asserts that the source code after applying Fix-Its matches this string.
      ///   - testModuleName: The name of the test module to use.
      ///   - testFileName: The name of the test file name to use.
      ///   - indentationWidth: The indentation width used in the expansion.
      public func assertMacroExpansion(
        _ originalSource: String,
        expandedSource expectedExpandedSource: String,
        diagnostics: [DiagnosticSpec] = [],
        macroSpecs: [String: MacroSpec],
        applyFixIts: [String]? = nil,
        fixedSource expectedFixedSource: String? = nil,
        testModuleName: String = "TestModule",
        testFileName: String = "test.swift",
        indentationWidth: Trivia = .spaces(4),
        file: StaticString = #filePath,
        line: UInt = #line
      )\(raw: asyncSpecifier) {
        \(raw: awaitOperator)SwiftSyntaxMacrosGenericTestSupport.assertMacroExpansion(
          originalSource,
          expandedSource: expectedExpandedSource,
          diagnostics: diagnostics,
          macroSpecs: macroSpecs,
          applyFixIts: applyFixIts,
          fixedSource: expectedFixedSource,
          testModuleName: testModuleName,
          testFileName: testFileName,
          indentationWidth: indentationWidth,
          failureHandler: {
            XCTFail($0.message, file: $0.location.staticFilePath, line: $0.location.unsignedLine)
          },
          fileID: "",  // Not used in the failure handler
          filePath: file,
          line: line,
          column: 0  // Not used in the failure handler
        )
      }
      """
    )
  }
}
