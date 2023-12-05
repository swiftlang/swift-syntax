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

struct TracedPreambleMacro: PreambleMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingPreambleFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
    in context: some MacroExpansionContext
  ) throws -> [CodeBlockItemSyntax] {
    // FIXME: Should be able to support (de-)initializers and accessors as
    // well, but this is a lazy implementation.
    guard let funcDecl = declaration.as(FunctionDeclSyntax.self) else {
      return []
    }

    let funcBaseName = funcDecl.name
    let paramNames = funcDecl.signature.parameterClause.parameters.map { param in
      param.parameterName?.text ?? "_"
    }

    let passedArgs = paramNames.map { "\($0): \\(\($0))" }.joined(separator: ", ")

    let entry: CodeBlockItemSyntax = """
      log("Entering \(funcBaseName)(\(raw: passedArgs))")
      """

    let argLabels = paramNames.map { "\($0):" }.joined()

    let exit: CodeBlockItemSyntax = """
      log("Exiting \(funcBaseName)(\(raw: argLabels))")
      """

    return [
      entry,
      """
      defer {
        \(exit)
      }
      """,
    ]
  }
}

final class PreambleMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testPreambleExpansion() {
    assertMacroExpansion(
      """
      @Traced
      func doSomethingDangerous(operation: String) {
        print("This is the operation: \\(operation)")
      }
      """,
      expandedSource: """

        func doSomethingDangerous(operation: String) {
          log("Entering doSomethingDangerous(operation: \\(operation))")
          defer {
            log("Exiting doSomethingDangerous(operation:)")
          }
          print("This is the operation: \\(operation)")
        }
        """,
      macros: ["Traced": TracedPreambleMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testPreambleExpansionTwice() {
    assertMacroExpansion(
      """
      @Traced @Traced
      func doSomethingDangerous(operation: String) {
        print("This is the operation: \\(operation)")
      }
      """,
      expandedSource: """

        func doSomethingDangerous(operation: String) {
          log("Entering doSomethingDangerous(operation: \\(operation))")
          defer {
            log("Exiting doSomethingDangerous(operation:)")
          }
          log("Entering doSomethingDangerous(operation: \\(operation))")
          defer {
            log("Exiting doSomethingDangerous(operation:)")
          }
          print("This is the operation: \\(operation)")
        }
        """,
      macros: ["Traced": TracedPreambleMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testBodyAndPreambleExpansion() {
    assertMacroExpansion(
      """
      @Remote @Traced
      func f(a: Int, b: String) async throws -> String
      """,
      expandedSource: """

        func f(a: Int, b: String) async throws -> String {
          log("Entering f(a: \\(a), b: \\(b))")
          defer {
            log("Exiting f(a:b:)")
          }
          return try await remoteCall(function: "f", arguments: ["a": a, "b": b])
        }
        """,
      macros: [
        "Remote": RemoteBodyMacro.self,
        "Traced": TracedPreambleMacro.self,
      ],
      indentationWidth: indentationWidth
    )
  }

  func testPreambleExpansionWithoutBody() {
    assertMacroExpansion(
      """
      @Traced
      func f(a: Int, b: String) async throws -> String
      """,
      expandedSource: """

        func f(a: Int, b: String) async throws -> String
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "preamble macro cannot be applied to a function with no body",
          line: 1,
          column: 1
        )
      ],
      macros: [
        "Traced": TracedPreambleMacro.self
      ],
      indentationWidth: indentationWidth
    )
  }
}
