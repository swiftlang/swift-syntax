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

//==========================================================================//
// IMPORTANT: The macros defined in this file are intended to test the      //
// behavior of MacroSystem. Many of them do not serve as good examples of   //
// how macros should be written. In particular, they often lack error       //
// handling because it is not needed in the few test cases in which these   //
// macros are invoked.                                                      //
//==========================================================================//

import SwiftDiagnostics
import SwiftSyntax
@_spi(Testing) import SwiftSyntaxMacroExpansion
@_spi(ExperimentalLanguageFeature) import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

struct RemoteBodyMacro: BodyMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingBodyFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
    in context: some MacroExpansionContext
  ) throws -> [CodeBlockItemSyntax] {
    // FIXME: Should be able to support (de-)initializers and accessors as
    // well, but this is a lazy implementation.
    guard let funcDecl = declaration.as(FunctionDeclSyntax.self) else {
      return []
    }

    let funcBaseName = funcDecl.name.text
    let paramNames = funcDecl.signature.parameterClause.parameters.map { param in
      param.parameterName ?? TokenSyntax(.wildcard, presence: .present)
    }

    let passedArgs = DictionaryExprSyntax(
      content: .elements(
        DictionaryElementListSyntax {
          for paramName in paramNames {
            DictionaryElementSyntax(
              key: ExprSyntax("\(literal: paramName.text)"),
              value: DeclReferenceExprSyntax(baseName: paramName)
            )
          }
        }
      )
    )

    return [
      """
      return try await remoteCall(function: \(literal: funcBaseName), arguments: \(passedArgs))
      """
    ]
  }
}

final class BodyMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testBodyExpansion() {
    assertMacroExpansion(
      """
      @Remote
      func f(a: Int, b: String) async throws -> String
      """,
      expandedSource: """

        func f(a: Int, b: String) async throws -> String {
          return try await remoteCall(function: "f", arguments: ["a": a, "b": b])
        }
        """,
      macros: ["Remote": RemoteBodyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testBodyExpansionTwice() {
    assertMacroExpansion(
      """
      @Remote @Remote
      func f(a: Int, b: String) async throws -> String
      """,
      expandedSource: """

        func f(a: Int, b: String) async throws -> String {
          return try await remoteCall(function: "f", arguments: ["a": a, "b": b])
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "function can not have more than one body macro applied to it",
          line: 1,
          column: 1
        )
      ],
      macros: ["Remote": RemoteBodyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testBodyExpansionReplacement() {
    assertMacroExpansion(
      """
      @Remote
      func f(a: Int, b: String) async throws -> String {
        this; code; is; unused
      }
      """,
      expandedSource: """

        func f(a: Int, b: String) async throws -> String {
          return try await remoteCall(function: "f", arguments: ["a": a, "b": b])
        }
        """,
      macros: ["Remote": RemoteBodyMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testEmptyBodyMacro() {
    struct EmptyBodyMacro: BodyMacro {
      public static var formatMode: FormatMode { .disabled }

      public static func expansion(
        of node: AttributeSyntax,
        providingBodyFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
        in context: some MacroExpansionContext
      ) throws -> [CodeBlockItemSyntax] {
        return []
      }
    }

    assertMacroExpansion(
      """
      @EmptyBody
      func f() {
        print(42)
      }
      """,
      expandedSource: """
        func f() {
          print(42)
        }
        """,
      diagnostics: [],
      macros: ["EmptyBody": EmptyBodyMacro.self]
    )
  }

  func testDontAddIndentationWhenCollapsingBody() {
    struct SourceLocationMacro: BodyMacro {
      public static var formatMode: FormatMode { .disabled }

      public static func expansion(
        of node: AttributeSyntax,
        providingBodyFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
        in context: some MacroExpansionContext
      ) throws -> [CodeBlockItemSyntax] {
        guard let statements = declaration.body?.statements else {
          return []
        }
        if let location = context.location(of: statements, at: .afterLeadingTrivia, filePathMode: .filePath) {
          return statements.flatMap { statement in
            CodeBlockItemListSyntax {
              "#sourceLocation(file: \(location.file), line: \(location.line))"
              statement.trimmed(matching: \.isNewline)
              "#sourceLocation()"
            }
          }
        } else {
          return Array(statements)
        }
      }
    }

    assertMacroExpansion(
      """
      @SourceLocationMacro
      func f() {
              let x: Int = 1
      }
      """,
      expandedSource: """
        func f() {
        #sourceLocation(file: "test.swift", line: 3)
                let x: Int = 1
        #sourceLocation()
        }
        """,
      macros: ["SourceLocationMacro": SourceLocationMacro.self]
    )
  }
}
