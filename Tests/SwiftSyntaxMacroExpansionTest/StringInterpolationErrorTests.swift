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
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// An error that is not `SyntaxStringInterpolationError`, only used to verify
// that other error types won't get prefixed with `Internal macro error:` when
// passed to `MacroExpansionContext.addDiagnostics`.
private struct DummyError: Error {
  static let diagnosticTestError = DummyError()
}

// An extension macro that will fail with
// `SyntaxStringInterpolationError.producedInvalidNodeType`
private struct DummyMacro: ExtensionMacro {
  static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    let ext = try ExtensionDeclSyntax("var x: Int")
    return [ext]
  }
}

final class StringInterpolationErrorTests: XCTestCase {

  func testMacroExpansionContextAddDiagnosticsAddsSwiftSyntaxInterpolationErrorsWithWrappingMessage() throws {
    let context = BasicMacroExpansionContext(lexicalContext: [])
    let error = SyntaxStringInterpolationInvalidNodeTypeError(expectedType: DeclSyntax.self, actualNode: ExprSyntax("test"))

    // Since we only care about the error switch inside of addDagnostics, we don't care about the particular node we're passing in
    context.addDiagnostics(from: error, node: ExprSyntax("1"))
    XCTAssertEqual(context.diagnostics.count, 1)
    let diagnostic = try XCTUnwrap(context.diagnostics.first)
    XCTAssertTrue(diagnostic.message.starts(with: "Internal macro error:"))
  }

  // Verify that any other error messages do not get "Internal macro error:" prefix.
  func testMacroExpansionContextAddDiagnosticsUsesErrorDescriptionForDiagMessage() throws {
    let context = BasicMacroExpansionContext(lexicalContext: [])
    let error = DummyError.diagnosticTestError

    context.addDiagnostics(from: error, node: ExprSyntax("1"))
    XCTAssertEqual(context.diagnostics.count, 1)
    let diagnostic = try XCTUnwrap(context.diagnostics.first)
    XCTAssertEqual(diagnostic.message, String(describing: error))
  }

  func testMacroExpansionSyntaxInterpolationErrorGetsPrefixed() {
    let expectedDiagnostic = DiagnosticSpec(
      message: "Internal macro error: Parsing the code snippet was expected to produce a ExtensionDeclSyntax but produced a DeclSyntax",
      line: 1,
      column: 1
    )

    assertMacroExpansion(
      "@dummy struct Foo {}",
      expandedSource: "struct Foo {}",
      diagnostics: [expectedDiagnostic],
      macros: ["dummy": DummyMacro.self]
    )
  }
}
