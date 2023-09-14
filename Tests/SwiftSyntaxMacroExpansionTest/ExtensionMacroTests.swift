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
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

fileprivate struct DeclsFromStringsMacro: DeclarationMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    var strings: [String] = []
    for arg in node.arguments {
      guard let value = arg.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue else {
        continue
      }
      strings.append(value)
    }

    return strings.map { "\(raw: $0)" }
  }
}

final class ExtensionMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testExtensionExpansion() {
    struct SendableExtensionMacro: ExtensionMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [ExtensionDeclSyntax] {
        let sendableExtension: DeclSyntax =
          """
          extension \(type.trimmed): Sendable {}
          """

        guard let extensionDecl = sendableExtension.as(ExtensionDeclSyntax.self) else {
          return []
        }

        return [extensionDecl]
      }
    }

    assertMacroExpansion(
      """
      @AddSendableExtension
      struct MyType {
      }
      """,
      expandedSource: """

        struct MyType {
        }

        extension MyType: Sendable {
        }
        """,
      macros: ["AddSendableExtension": SendableExtensionMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Wrapper {
        @AddSendableExtension
        struct MyType {
        }
      }
      """,
      expandedSource: """
        struct Wrapper {
          struct MyType {
          }
        }

        extension MyType: Sendable {
        }
        """,
      macros: ["AddSendableExtension": SendableExtensionMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testEmpty() {
    struct TestMacro: ExtensionMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [ExtensionDeclSyntax] {
        return []
      }
    }

    assertMacroExpansion(
      "@Test struct Foo {}",
      expandedSource: "struct Foo {}",
      macros: [
        "Test": TestMacro.self
      ]
    )
  }
}
