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

private struct WrapAllProperties: MemberAttributeMacro {
  static func expansion(
    of node: AttributeSyntax,
    attachedTo decl: some DeclGroupSyntax,
    providingAttributesFor member: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AttributeSyntax] {
    guard member.is(VariableDeclSyntax.self) else {
      return []
    }

    return ["@Wrapper"]
  }
}

final class MemberAttributeMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testWrapAllProperties() {
    assertMacroExpansion(
      """
      @wrapAllProperties
      struct Point {
        var x: Int
        var y: Int
        var description: String { "" }
        var computed: Int {
          get { 0 }
          set {}
        }

        func test() {}
      }
      """,
      expandedSource: """
        struct Point {
          @Wrapper
          var x: Int
          @Wrapper
          var y: Int
          @Wrapper
          var description: String { "" }
          @Wrapper
          var computed: Int {
            get { 0 }
            set {}
          }

          func test() {}
        }
        """,
      macros: ["wrapAllProperties": WrapAllProperties.self],
      indentationWidth: indentationWidth
    )
  }

  func testAttributeWithComment() {
    assertMacroExpansion(
      """
      @wrapAllProperties struct S {
        // Var value
        var value = 1
      }
      """,
      expandedSource: """
        struct S {
          @Wrapper
          // Var value
          var value = 1
        }
        """,
      macros: ["wrapAllProperties": WrapAllProperties.self],
      indentationWidth: indentationWidth
    )
  }

  func testWrapStoredProperties() {
    struct WrapStoredProperties: MemberAttributeMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo decl: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        guard let property = member.as(VariableDeclSyntax.self),
          property.bindings.count == 1
        else {
          return []
        }

        let binding = property.bindings.first!
        switch binding.accessorBlock?.accessors {
        case .none:
          break
        case .accessors(let node):
          for accessor in node {
            switch accessor.accessorSpecifier.tokenKind {
            case .keyword(.get), .keyword(.set):
              return []
            default:
              break
            }
          }
          break
        case .getter:
          return []
        }

        return ["@Wrapper"]
      }
    }

    assertMacroExpansion(
      """
      @wrapStoredProperties
      struct Point {
        var x: Int
        var y: Int

        var description: String { "" }

        var computed: Int {
          get { 0 }
          set {}
        }

        func test() {}
      }
      """,
      expandedSource: """
        struct Point {
          @Wrapper
          var x: Int
          @Wrapper
          var y: Int

          var description: String { "" }

          var computed: Int {
            get { 0 }
            set {}
          }

          func test() {}
        }
        """,
      macros: ["wrapStoredProperties": WrapStoredProperties.self],
      indentationWidth: indentationWidth
    )
  }

  func testMemberAttributeMacroOnPropertyThatAlreadyHasAttribute() {
    struct TestMacro: MemberAttributeMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo decl: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        return ["@Wrapper"]
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          @Wrapper var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) /* x */ var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          @Wrapper /* x */ var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated)

        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          @Wrapper

          var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) // some comment

        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          @Wrapper // some comment

          var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testMemberAttributeWithTriviaMacroOnPropertyThatAlreadyHasAttribute() {
    struct TestMacro: MemberAttributeMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo decl: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        return ["/* start */@Wrapper/* end */"]
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          /* start */@Wrapper/* end */ var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) /* x */ var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          /* start */@Wrapper/* end */ /* x */ var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated)

        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          /* start */@Wrapper/* end */

          var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        @available(*, deprecated) // some comment

        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @available(*, deprecated)
          /* start */@Wrapper/* end */ // some comment

          var x: Int
        }
        """,
      macros: ["Test": TestMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testEmpty() {
    struct TestMacro: MemberAttributeMacro {
      static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        return []
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          var x: Int
        }
        """,
      macros: [
        "Test": TestMacro.self
      ]
    )

    assertMacroExpansion(
      """
      @Test
      struct Foo {
      }
      """,
      expandedSource: """
        struct Foo {
        }
        """,
      macros: [
        "Test": TestMacro.self
      ]
    )
  }
}
