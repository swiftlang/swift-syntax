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

final class ExtensionMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testSimpleExpansion() {
    assertMacroExpansion(
      """
      @AddSendableExtension
      struct MyType {}
      """,
      expandedSource: """
        struct MyType {}

        extension MyType: Sendable {
        }
        """,
      macros: ["AddSendableExtension": SendableExtensionMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testNestedExpansion() {
    assertMacroExpansion(
      """
      struct Wrapper {
        @AddSendableExtension
        struct MyType {}
      }
      """,
      expandedSource: """
        struct Wrapper {
          struct MyType {}
        }

        extension Wrapper.MyType: Sendable {
        }
        """,
      macros: ["AddSendableExtension": SendableExtensionMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testNestedInExtensionExpansion() {
    assertMacroExpansion(
      """
      struct Wrapper {
        struct AnotherWrapper {}
      }
      extension Wrapper.AnotherWrapper {
        @AddSendableExtension
        struct MyType {}
      }
      """,
      expandedSource: """
        struct Wrapper {
          struct AnotherWrapper {}
        }
        extension Wrapper.AnotherWrapper {
          struct MyType {}
        }

        extension Wrapper.AnotherWrapper.MyType: Sendable {
        }
        """,
      macros: ["AddSendableExtension": SendableExtensionMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testComplexNestedExpansion() {
    assertMacroExpansion(
      """
      struct Wrapper {}
      extension Wrapper {
        struct AnotherWrapper {
          @AddSendableExtension
          struct MyType {}
        }
      }
      """,
      expandedSource: """
        struct Wrapper {}
        extension Wrapper {
          struct AnotherWrapper {
            struct MyType {}
          }
        }

        extension Wrapper.AnotherWrapper.MyType: Sendable {
        }
        """,
      macros: ["AddSendableExtension": SendableExtensionMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testAttachedToInvalid() {
    assertMacroExpansion(
      "@AddSendableExtension var foo: Int",
      expandedSource: "var foo: Int",
      macros: [
        "AddSendableExtension": SendableExtensionMacro.self
      ]
    )

    assertMacroExpansion(
      """
      struct Foo {
        @AddSendableExtension var foo: Int
      }
      """,
      expandedSource:
        """
        struct Foo {
          var foo: Int
        }
        """,
      macros: [
        "AddSendableExtension": SendableExtensionMacro.self
      ]
    )
  }

  func testEmpty() {
    struct EmptyExtensionMacro: ExtensionMacro {
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
      "@Empty struct Foo {}",
      expandedSource: "struct Foo {}",
      macros: [
        "Empty": EmptyExtensionMacro.self
      ]
    )
  }

  func testConditionalExtensionExpansion() {
    struct CodableExtensionMacro: ExtensionMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [ExtensionDeclSyntax] {
        let extensions: [ExtensionDeclSyntax] = protocols.compactMap { `protocol` in
          let decl = """
            extension \(type.trimmed): \(`protocol`) {}
            """ as DeclSyntax
          return decl.as(ExtensionDeclSyntax.self)
        }

        return extensions
      }
    }

    assertMacroExpansion(
      """
      @AddCodableExtensions
      struct MyType {
      }
      """,
      expandedSource: """

        struct MyType {
        }

        extension MyType: Decodable {
        }

        extension MyType: Encodable {
        }
        """,
      macroSpecs: ["AddCodableExtensions": MacroSpec(type: CodableExtensionMacro.self, conformances: ["Decodable", "Encodable"])],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Wrapper {
        @AddCodableExtensions
        struct MyType {
        }
      }
      """,
      expandedSource: """
        struct Wrapper {
          struct MyType {
          }
        }

        extension Wrapper.MyType: Encodable {
        }
        """,
      macroSpecs: ["AddCodableExtensions": MacroSpec(type: CodableExtensionMacro.self, conformances: ["Encodable"])],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Wrapper {
        @AddCodableExtensions
        struct MyType {
        }
      }
      """,
      expandedSource: """
        struct Wrapper {
          struct MyType {
          }
        }
        """,
      macros: ["AddCodableExtensions": CodableExtensionMacro.self],
      indentationWidth: indentationWidth
    )
  }
}

fileprivate struct SendableExtensionMacro: ExtensionMacro {
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
