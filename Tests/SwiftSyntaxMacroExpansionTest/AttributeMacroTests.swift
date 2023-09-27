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
import SwiftParser
import XCTest

fileprivate struct FixedAttributes: AttributeMacro {
  enum ExpansionError: Error {
    case argumentHasLabel
    case argumentNotString
    case argumentHasInterpolations
  }

  static func expansion(
    of node: AttributeSyntax,
    providingAttributesFor member: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AttributeSyntax] {
    guard case .argumentList(let list)? = node.arguments else {
      return []
    }

    return try list.map { labeledExpr in
      guard labeledExpr.label == nil else {
        throw ExpansionError.argumentHasLabel
      }
      guard let stringExpr = labeledExpr.expression.as(StringLiteralExprSyntax.self) else {
        throw ExpansionError.argumentNotString
      }
      guard
        stringExpr.segments.count == 1,
        case .stringSegment(let segment)? = stringExpr.segments.first,
        case .stringSegment(let text) = segment.content.tokenKind
      else {
        throw ExpansionError.argumentHasInterpolations
      }

      var parser = Parser(text)
      return AttributeSyntax.parse(from: &parser)
    }
  }
}

final class AttributeMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)
  private let macros: [String: Macro.Type] = ["fixedAttributes": FixedAttributes.self]

  func testWrapAllProperties() {
    assertMacroExpansion(
      """
      @fixedAttributes("@frozen", "@available(macOS 99, *)")
      struct Point {
        var x: Int
        var y: Int
        var description: String { "" }
        var computed: Int {
          get { 0 }
          set {}
        }

        @fixedAttributes("@inlinable")
        func test() {}
      }
      """,
      expandedSource: """
        @frozen @available(macOS 99, *)
        struct Point {
          var x: Int
          var y: Int
          var description: String { "" }
          var computed: Int {
            get { 0 }
            set {}
          }
          @inlinable
          func test() {}
        }
        """,
      macros: macros,
      indentationWidth: indentationWidth
    )
  }

  #if false
  func testAttributeMacroOnPropertyThatAlreadyHasAttribute() {
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
  #endif
}
