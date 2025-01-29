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

fileprivate struct ConstantOneGetter: AccessorMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AccessorDeclSyntax] {
    return [
      """
      get {
        return 1
      }
      """
    ]
  }
}

final class AccessorMacroTests: XCTestCase {
  private let indentationWidth: Trivia = .spaces(2)

  func testAccessorOnVariableDeclWithTrailingLineCommentAndNoAccessorBlock() {
    assertMacroExpansion(
      """
      @constantOne
      var x: Int /*1*/ // hello
      """,
      expandedSource: """
        var x: Int { /*1*/ // hello
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @constantOne
      var x: Int /// hello
      """,
      expandedSource: """
        var x: Int { /// hello
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @constantOne
      var x: Int = 1 /// hello
      """,
      expandedSource: """
        var x: Int { /// hello
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @constantOne
      var x /// hello
      """,
      expandedSource: """
        var x { /// hello
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnVariableDeclWithTrailingLineCommentAndAccessorBlock() {
    assertMacroExpansion(
      """
      @constantOne
      var x: Int /*h*/ { // hello
        1
      }
      """,
      expandedSource: """
        var x: Int /*h*/ { // hello
        get {
            1
        }
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnVariableDeclWithTrailingCommentsAndSingleLineGetterExpansion() {
    struct ConstantOneSingleLineGetter: AccessorMacro {
      static let formatMode: FormatMode = .disabled

      static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        return [
          """
          get { 1 }
          """
        ]
      }
    }

    assertMacroExpansion(
      """
      @constantOne
      var x: Int // hello
      """,
      expandedSource: """
        var x: Int { // hello
        get { 1 }
        }
        """,
      macros: ["constantOne": ConstantOneSingleLineGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnVariableDeclWithExistingGetter() {
    assertMacroExpansion(
      """
      @constantOne
      var x: Int {
        return 42
      }
      """,
      expandedSource: """
        var x: Int {
          get {
            return 42
          }
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        var x: Int {
          return 42
        }
      }
      """,
      expandedSource: """
        struct Foo {
          var x: Int {
            get {
              return 42
            }
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      @constantOne
      var x: Int {
        get {
          return 42
        }
      }
      """,
      expandedSource: """
        var x: Int {
          get {
            return 42
          }
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnSubscript() {
    // Adding an accessor to a subscript without an accessor isn't supported by
    // the compiler (it complains that the subscript should have a body) but we
    // can stil make the most reasonable syntactic expansion.
    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        subscript() -> Int
      }
      """,
      expandedSource: """
        struct Foo {
          subscript() -> Int {
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnSubscriptDeclWithExistingGetter() {
    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        subscript() -> Int {
          return 42
        }
      }
      """,
      expandedSource: """
        struct Foo {
          subscript() -> Int {
            get {
              return 42
            }
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        subscript() -> Int {
          return 42
        }
      }
      """,
      expandedSource: """
        struct Foo {
          subscript() -> Int {
            get {
              return 42
            }
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    assertMacroExpansion(
      """
      struct Foo {
        @constantOne
        subscript() -> Int {
          get {
            return 42
          }
        }
      }
      """,
      expandedSource: """
        struct Foo {
          subscript() -> Int {
            get {
              return 42
            }
            get {
              return 1
            }
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testAccessorOnVariableDeclWithMultipleBindings() {
    assertMacroExpansion(
      """
      @constantOneGetter
      var x: Int, y: Int
      """,
      expandedSource: """
        var x: Int, y: Int
        """,
      diagnostics: [
        DiagnosticSpec(
          message:
            "accessor macro can only be applied to a single variable",
          line: 1,
          column: 1,
          severity: .error
        )
      ],
      macros: ["constantOneGetter": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testMultipleAccessorMacros() {
    assertMacroExpansion(
      """
      @constantOne
      @constantOne
      var x: Int
      """,
      expandedSource: """
        var x: Int {
          get {
            return 1
          }
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testEmpty() {
    struct TestMacro: AccessorMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        return []
      }
    }

    // The compiler will reject this with
    // 'Expansion of macro 'Test()' did not produce a non-observing accessor'
    // We consider this a semantic error because swift-syntax doesn't have
    // knowledge about which accessors are observing and which ones aren't.
    assertMacroExpansion(
      "@Test var x: Int",
      expandedSource: "var x: Int",
      macros: ["Test": TestMacro.self]
    )

    assertMacroExpansion(
      "@Test var x: Int { 1 }",
      expandedSource: "var x: Int { 1 }",
      macros: ["Test": TestMacro.self]
    )
  }

  func testEmitErrorFromMacro() {
    struct TestMacro: AccessorMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        context.diagnose(Diagnostic(node: node, message: SwiftSyntaxMacros.MacroExpansionErrorMessage("test")))
        return []
      }
    }

    assertMacroExpansion(
      "@Test var x: Int",
      expandedSource: "var x: Int",
      diagnostics: [
        DiagnosticSpec(message: "test", line: 1, column: 1)
      ],
      macros: ["Test": TestMacro.self]
    )

    assertMacroExpansion(
      "@Test var x: Int { 1 }",
      expandedSource: "var x: Int { 1 }",
      diagnostics: [DiagnosticSpec(message: "test", line: 1, column: 1)],
      macros: ["Test": TestMacro.self]
    )
  }

  func testInitializerRemovedForGetSet() {
    assertMacroExpansion(
      """
      @constantOne
      var x: Int = 1
      """,
      expandedSource: """
        var x: Int {
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )

    // Bit of an odd case, compiler has the type but we don't know it in `MacroSystem`
    assertMacroExpansion(
      """
      @constantOne
      var x = 1
      """,
      expandedSource: """
        var x {
          get {
            return 1
          }
        }
        """,
      macros: ["constantOne": ConstantOneGetter.self],
      indentationWidth: indentationWidth
    )
  }

  func testInitializerRemainsForObserver() {
    struct DidSetAdder: AccessorMacro {
      static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        return [
          """
          didSet {
          }
          """
        ]
      }
    }

    assertMacroExpansion(
      """
      @addDidSet
      var x = 1
      """,
      expandedSource: """
        var x = 1 {
          didSet {
          }
        }
        """,
      macros: ["addDidSet": DidSetAdder.self],
      indentationWidth: indentationWidth
    )

    // Invalid semantically, but we shouldn't remove the initializer as the
    // macro did not produce a getter/setter
    assertMacroExpansion(
      """
      @addDidSet
      var x = 1 {
        get {
          return 1
        }
      }
      """,
      expandedSource: """
        var x = 1 {
          get {
            return 1
          }
          didSet {
          }
        }
        """,
      macros: ["addDidSet": DidSetAdder.self],
      indentationWidth: indentationWidth
    )
  }

  func testClosureInAccessorMacro() {
    enum PropertyWrapperMacro: AccessorMacro {
      public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
      ) throws -> [AccessorDeclSyntax] {
        guard let structDecl = context.lexicalContext.first?.as(StructDeclSyntax.self) else {
          return []
        }

        return ["get { \(literal: structDecl.name.text) }"]
      }
    }
    assertMacroExpansion(
      """
      struct Foo {
          @TestWrapper(b: { a in 1 }) var test3: Thing
      }
      """,
      expandedSource: """
        struct Foo {
            var test3: Thing {
                get {
                    "Foo"
                }
            }
        }
        """,
      macros: ["TestWrapper": PropertyWrapperMacro.self]
    )
  }
}
