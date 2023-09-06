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
}
