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

fileprivate struct NoOpMemberMacro: MemberMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    return []
  }
}

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
      macros: ["Test": NoOpMemberMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testStructVariableDeclWithMultipleBindings() {
    assertMacroExpansion(
      """
      @Test
      struct S {
        var x: Int, y: Int
      }
      """,
      expandedSource: """
        struct S {
          var x: Int, y: Int
        }
        """,
      macros: ["Test": NoOpMemberMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testNestedStructVariableDeclWithMultipleBindings() {
    assertMacroExpansion(
      """
      @Test
      struct Q {
        struct R {
          var i: Int, j: Int
        }
      }
      """,
      expandedSource: """
        struct Q {
          struct R {
            var i: Int, j: Int
          }
        }
        """,
      macros: ["Test": NoOpMemberMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testFoldOperators() {
    struct ForceSubtractMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        guard case .argumentList(let arguments) = node.arguments, let argument = arguments.first?.expression else {
          fatalError("Must receive an argument")
        }
        guard var node = argument.as(InfixOperatorExprSyntax.self) else {
          return []
        }
        node.operator = ExprSyntax(BinaryOperatorExprSyntax(text: "- "))
        return [
          DeclSyntax(
            """
            var x: Int { \(node.trimmed) }
            """
          )
        ]
      }
    }
    assertMacroExpansion(
      """
      /// Test
      /// And another line
      @Test(1 + 2)
      struct Foo {
      }
      """,
      expandedSource: """
        /// Test
        /// And another line
        struct Foo {

          var x: Int {
            1 - 2
          }
        }
        """,
      macros: ["Test": ForceSubtractMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testDiagnosticFromFoldedOperators() {
    struct MyError: Error {}

    struct DiagnoseFirstArgument: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        guard case .argumentList(let arguments) = node.arguments, let argument = arguments.first?.expression else {
          fatalError("Must receive an argument")
        }
        context.addDiagnostics(from: MyError(), node: argument)
        return []
      }
    }

    assertMacroExpansion(
      """
      /// Test
      /// And another line
      @Test(1 + 2)
      struct Foo {}
      """,
      expandedSource: """
        /// Test
        /// And another line
        struct Foo {}
        """,
      diagnostics: [
        DiagnosticSpec(message: "MyError()", line: 3, column: 7, severity: .error)
      ],
      macros: ["Test": DiagnoseFirstArgument.self]
    )
  }

  func testEmpty() {
    struct TestMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
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

  func testAddMemberToEmptyDeclaration() {
    struct TestMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return [DeclSyntax("var x = 0")]
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {}
      """,
      expandedSource: """
        struct Foo {

          var x = 0
        }
        """,
      macros: [
        "Test": TestMacro.self
      ],
      indentationWidth: indentationWidth
    )
  }

  func testAddTwoMembersToEmptyDeclaration() {
    struct TestMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return [DeclSyntax("var x = 0"), DeclSyntax("var x = 0")]
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {}
      """,
      expandedSource: """
        struct Foo {

          var x = 0

          var x = 0
        }
        """,
      macros: [
        "Test": TestMacro.self
      ],
      indentationWidth: indentationWidth
    )
  }

  func testAddMemberToEmptyDeclarationWithEndingNewline() {
    struct TestMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return [DeclSyntax("var x = 0\n")]
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {}
      """,
      expandedSource: """
        struct Foo {

          var x = 0
        }
        """,
      macros: [
        "Test": TestMacro.self
      ],
      indentationWidth: indentationWidth
    )
  }

  func testAddMemberToDeclarationWithASingleVariable() {
    struct TestMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return [DeclSyntax("var x = 0\n")]
      }
    }

    assertMacroExpansion(
      """
      @Test
      struct Foo {
        var y = 0
      }
      """,
      expandedSource: """
        struct Foo {
          var y = 0

          var x = 0
        }
        """,
      macros: [
        "Test": TestMacro.self
      ],
      indentationWidth: indentationWidth
    )
  }

  func testRemoveAttributeFixIt() {
    struct ActorOnlyMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        guard declaration.is(ActorDeclSyntax.self) else {
          throw DiagnosticsError(diagnostics: [
            Diagnostic(
              node: node,
              message: SwiftSyntaxMacros.MacroExpansionErrorMessage("'@ActorOnly' is only applicable to actors."),
              fixIt: FixIt(
                message: SwiftSyntaxMacros.MacroExpansionFixItMessage("Remove '@ActorOnly' attribute."),
                changes: [
                  // This doesn't account for other attributes that *could* be present in the
                  // attribute list, but for this test it will be fine.
                  .replace(
                    oldNode: Syntax(declaration.attributes),
                    newNode: Syntax(AttributeListSyntax())
                  )
                ]
              )
            )
          ])
        }
        return []
      }
    }

    assertMacroExpansion(
      """
      actor Foo {
        var foo: Int
      }
      @ActorOnly
      struct Bar {
        var bar: Int
      }
      """,
      expandedSource:
        """
        actor Foo {
          var foo: Int
        }
        struct Bar {
          var bar: Int
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "'@ActorOnly' is only applicable to actors.",
          line: 4,
          column: 1,
          fixIts: [
            FixItSpec(message: "Remove '@ActorOnly' attribute.")
          ]
        )
      ],
      macros: [
        "ActorOnly": ActorOnlyMacro.self
      ],
      applyFixIts: [
        "Remove '@ActorOnly' attribute."
      ],
      fixedSource:
        """
        actor Foo {
          var foo: Int
        }
        struct Bar {
          var bar: Int
        }
        """,
      indentationWidth: indentationWidth
    )
  }

  func testConditionalMemberExpansion() {
    struct CodableExtensionMacro: MemberMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        let decls: [DeclSyntax] = protocols.compactMap { `protocol` in
          return """
            func print(arg: some \(`protocol`)) { }
            """ as DeclSyntax
        }

        return decls
      }
    }

    assertMacroExpansion(
      """
      @AddCodableExtensions
      class MyType {
      }
      """,
      expandedSource: """
        class MyType {

          func print(arg: some Decodable) {
          }

          func print(arg: some Encodable) {
          }
        }
        """,
      macroSpecs: ["AddCodableExtensions": MacroSpec(type: CodableExtensionMacro.self, conformances: ["Decodable", "Encodable"])],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      class Wrapper {
        @AddCodableExtensions
        class MyType {
        }
      }
      """,
      expandedSource: """
        class Wrapper {
          class MyType {

            func print(arg: some Encodable) {
            }
          }
        }
        """,
      macroSpecs: ["AddCodableExtensions": MacroSpec(type: CodableExtensionMacro.self, conformances: ["Encodable"])],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      class Wrapper {
        @AddCodableExtensions
        class MyType {
        }
      }
      """,
      expandedSource: """
        class Wrapper {
          class MyType {
          }
        }
        """,
      macros: ["AddCodableExtensions": CodableExtensionMacro.self],
      indentationWidth: indentationWidth
    )
  }
}
