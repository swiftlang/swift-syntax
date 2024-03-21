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
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class MultiRoleMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testContextUniqueLocalNames() {
    let context = BasicMacroExpansionContext(lexicalContext: [])

    let t1 = context.makeUniqueName("mine")
    let t2 = context.makeUniqueName("mine")
    XCTAssertNotEqual(t1.description, t2.description)
    XCTAssertEqual(t1.description, "__macro_local_4minefMu_")
    XCTAssertEqual(t2.description, "__macro_local_4minefMu0_")
  }

  func testPropertyWrapper() {
    struct PropertyWrapper: AccessorMacro, PeerMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        guard let binding = declaration.as(VariableDeclSyntax.self)?.bindings.first,
          let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
          binding.accessorBlock == nil
        else {
          return []
        }

        return [
          """
          get {
            _\(identifier).wrappedValue
          }
          """,
          """
          set {
            _\(identifier).wrappedValue = newValue
          }
          """,
        ]
      }

      static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [SwiftSyntax.DeclSyntax] {
        guard let binding = declaration.as(VariableDeclSyntax.self)?.bindings.first,
          let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
          let type = binding.typeAnnotation?.type,
          binding.accessorBlock == nil
        else {
          return []
        }

        guard case .argumentList(let arguments) = node.arguments,
          let stringLiteral = arguments.first?.expression.as(StringLiteralExprSyntax.self),
          stringLiteral.segments.count == 1,
          case let .stringSegment(wrapperTypeNameSegment)? = stringLiteral.segments.first
        else {
          return []
        }

        let storageType: TypeSyntax = "\(wrapperTypeNameSegment.content)<\(type)>"
        let storageName = "_\(identifier)"

        return [
          """

          private var \(raw: storageName): \(storageType)

          """
        ]
      }
    }

    assertMacroExpansion(
      """
      @wrapProperty("MyWrapperType")
      var x: Int
      """,
      expandedSource: """
        var x: Int {
          get {
            _x.wrappedValue
          }
          set {
            _x.wrappedValue = newValue
          }
        }

        private var _x: MyWrapperType<Int>
        """,
      macros: ["wrapProperty": PropertyWrapper.self],
      indentationWidth: indentationWidth
    )
  }

  func testTypeWrapperTransform() {
    struct CustomTypeWrapperMacro: MemberMacro, MemberAttributeMacro, AccessorMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return ["var _storage: Wrapper<Self>"]
      }

      static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AttributeSyntax] {
        return ["@customTypeWrapper"]
      }

      static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        guard let property = declaration.as(VariableDeclSyntax.self),
          let binding = property.bindings.first,
          let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
          binding.accessorBlock == nil
        else {
          return []
        }

        if identifier.text == "_storage" { return [] }

        return [
          """
          get {
            _storage[wrappedKeyPath: \\.\(identifier)]
          }
          """,
          """
          set {
            _storage[wrappedKeyPath: \\.\(identifier)] = newValue
          }
          """,
        ]
      }
    }

    assertMacroExpansion(
      """
      @customTypeWrapper
      struct Point {
        var x: Int
        var y: Int
      }
      """,
      expandedSource: """

        struct Point {
          var x: Int {
            get {
              _storage[wrappedKeyPath: \\.x]
            }
            set {
              _storage[wrappedKeyPath: \\.x] = newValue
            }
          }
          var y: Int {
            get {
              _storage[wrappedKeyPath: \\.y]
            }
            set {
              _storage[wrappedKeyPath: \\.y] = newValue
            }
          }

          var _storage: Wrapper<Self>
        }
        """,
      macros: ["customTypeWrapper": CustomTypeWrapperMacro.self],
      indentationWidth: indentationWidth
    )
  }

  func testAttachedMacroOnFreestandingMacro() {
    struct DeclMacro: DeclarationMacro {
      static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return ["var x: Int"]
      }
    }

    struct MyPeerMacro: PeerMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [DeclSyntax] {
        return ["var peer: Int"]
      }
    }

    assertMacroExpansion(
      """
      struct Foo {
        @Peer
        #decl
      }
      """,
      expandedSource: """
        struct Foo {
          var x: Int

          var peer: Int
        }
        """,
      macros: ["decl": DeclMacro.self, "Peer": MyPeerMacro.self]
    )

    assertMacroExpansion(
      """
      @Peer
      #decl
      """,
      expandedSource: """
        var x: Int

        var peer: Int
        """,
      macros: ["decl": DeclMacro.self, "Peer": MyPeerMacro.self]
    )
  }
}
