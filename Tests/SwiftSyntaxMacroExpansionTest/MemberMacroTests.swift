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

import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacrosTestSupport
import XCTest

final class MemberMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testMemberDeclsFromStringLiterals() {
    struct DeclsFromStringsMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        guard case .argumentList(let arguments) = node.arguments else {
          return []
        }
        var strings: [String] = []
        for arg in arguments {
          guard let value = arg.expression.as(StringLiteralExprSyntax.self)?.representedLiteralValue else {
            continue
          }
          strings.append(value)
        }

        return strings.map { "\(raw: $0)" }
      }
    }

    assertMacroExpansion(
      """
      @decls("func foo() {}", "func bar() {}"
      struct Foo {
        var member: Int
      }
      """,
      expandedSource: """
        struct Foo {
          var member: Int

          func foo() {
          }

          func bar() {
          }
        }
        """,
      macros: ["decls": DeclsFromStringsMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testAddBackingStorage() {
    struct AddBackingStorage: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf decl: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return ["var _storage: Storage<Self>"]
      }
    }

    assertMacroExpansion(
      """
      @addBackingStorage
      struct S {
        var value: Int
      }
      """,
      expandedSource: """
        struct S {
          var value: Int

          var _storage: Storage<Self>
        }
        """,
      macros: ["addBackingStorage": AddBackingStorage.self],
      indentationWidth: indentationWidth
    )
  }

  func testCommentAroundeAttachedMacro() {
    struct TestMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return []
      }
    }

    assertMacroExpansion(
      """
      /// Some doc comment
      @Test /* trailing */
      struct S {
        var value: Int
      }
      """,
      expandedSource: """
        /// Some doc comment
        /* trailing */
        struct S {
          var value: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )
  }
}
