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

fileprivate struct NoOpPeerMacro: PeerMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingPeersOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    return []
  }
}

final class AttributeRemoverTests: XCTestCase {
  func testEmptyOnSameLineAsVariable() {
    assertMacroExpansion(
      "@Test var x: Int",
      expandedSource: "var x: Int",
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testEmptyTwiceOnSameLineAsVariable() {
    assertMacroExpansion(
      "@Test @Test var x: Int",
      expandedSource: "var x: Int",
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testEmptyOnOwnLineBeforeVariable() {
    assertMacroExpansion(
      """
      @Test
      var x: Int
      """,
      expandedSource: "var x: Int",
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testEmptyTwiceOnOwnLineBeforeVariable() {
    assertMacroExpansion(
      """
      @Test @Test
      var x: Int
      """,
      expandedSource: "var x: Int",
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testEmptyAndAttributeOnOwnLineBeforeVariable() {
    assertMacroExpansion(
      """
      @Test @State
      var x: Int
      """,
      expandedSource: """
        @State
        var x: Int
        """,
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testAttributeAndEmptyOnOwnLineBeforeVariable() {
    assertMacroExpansion(
      """
      @State @Test
      var x: Int
      """,
      expandedSource: """
        @State
        var x: Int
        """,
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testAttributeAndEmptyAndCommentOnOwnLineBeforeVariable() {
    assertMacroExpansion(
      """
      @State @Test// comment
      var x: Int
      """,
      expandedSource: """
        @State // comment
        var x: Int
        """,
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testAttributeAndEmptyAndCommentOnOwnLineBeforeVariable2() {
    assertMacroExpansion(
      """
      @State @Test // comment
      var x: Int
      """,
      expandedSource: """
        @State // comment
        var x: Int
        """,
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testCommentsAroundEmpty() {
    assertMacroExpansion(
      """
      struct S {
        /// Some doc comment
        @Test /* trailing */
        var value: Int
      }
      """,
      expandedSource: """
        struct S {
          /// Some doc comment
          /* trailing */
          var value: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testBlockCommentNewlineEmpty() {
    assertMacroExpansion(
      """
      /* comment */
      @Test
      var value: Int
      """,
      expandedSource: """
        /* comment */
        var value: Int
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmpyNewlineBlockComment() {
    assertMacroExpansion(
      """
      @Test
      /* comment */
      var value: Int
      """,
      expandedSource: """
        /* comment */
        var value: Int
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testAttributeNewlineBlockCommentEmpty() {
    assertMacroExpansion(
      """
      @State
      /*doc comment*/@Test
      var x: Int
      """,
      expandedSource: """
        @State
        /*doc comment*/
        var x: Int
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyBlockCommentEmpty() {
    assertMacroExpansion(
      """
      @Test /* comment */ @Test var value: Int
      """,
      expandedSource: """
        /* comment */ var value: Int
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyBlockCommentEmptyNewline() {
    assertMacroExpansion(
      """
      @Test /* comment */ @Test
      var value: Int
      """,
      expandedSource: """
        /* comment */
        var value: Int
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyBlockCommentEmptyBlockComment() {
    assertMacroExpansion(
      """
      @Test /* comment1 */ @Test /* comment2 */ var value: Int
      """,
      expandedSource: """
        /* comment1 */ /* comment2 */ var value: Int
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyWithLeadingSpace_SpacePreserved() {
    assertMacroExpansion(
      """
      \u{0020}@Test var value: Int
      """,
      expandedSource: """
        \u{0020}var value: Int
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyWithLeadingSpaceOnMember_SpacePreserved() {
    assertMacroExpansion(
      """
      struct Foo {
        \u{0020}@Test var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          \u{0020}var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyAndAttributeMashedTogether() {
    // NB: In Swift, attributes can validly cozy up without whitespace.
    assertMacroExpansion(
      """
      struct Foo {
        @Test@State var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testAttributeAndEmptyMashedTogether() {
    // NB: In Swift, attributes can validly cozy up without whitespace.
    assertMacroExpansion(
      """
      struct Foo {
        @State@Test var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyAndAttributeMashedTogether_VariableNextLine() {
    // NB: In Swift, attributes can validly cozy up without whitespace.
    assertMacroExpansion(
      """
      struct Foo {
        @Test@State
        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State
          var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testAttributeAndEmptyMashedTogether_VariableNextLine() {
    // NB: In Swift, attributes can validly cozy up without whitespace.
    assertMacroExpansion(
      """
      struct Foo {
        @State@Test
        var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State
          var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testAttributeAndEmptyOnOwnLinesBeforeVariable() {
    assertMacroExpansion(
      """
      @State
      @Test
      var x: Int
      """,
      expandedSource: """
        @State
        var x: Int
        """,
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testEmptyAndAttributeOnOwnLinesBeforeVariable() {
    assertMacroExpansion(
      """
      @Test
      @State
      var x: Int
      """,
      expandedSource: """
        @State
        var x: Int
        """,
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testAttributeOnOwnLineThenEmptyBeforeVariable() {
    assertMacroExpansion(
      """
      @State
      @Test var x: Int
      """,
      expandedSource: """
        @State
        var x: Int
        """,
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testEmptyOnOwnLineThenEmptyBeforeVariable() {
    assertMacroExpansion(
      """
      @Test
      @Test var x: Int
      """,
      expandedSource: "var x: Int",
      macros: [
        "Test": NoOpPeerMacro.self
      ]
    )
  }

  func testEmptyOnMemberVariable() {
    assertMacroExpansion(
      """
      struct Foo {
        @Test var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyBeforeAttributeOnSameLineAsMemberVariable() {
    assertMacroExpansion(
      """
      struct Foo {
        @Test @State var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyAfterAttributeOnSameLineAsMemberVariable() {
    assertMacroExpansion(
      """
      struct Foo {
        @State @Test var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyAfterAttributeOnSameLineAsMemberVariable_AwkwardWhitespace() {
    assertMacroExpansion(
      """
      struct Foo {
        @State \t  @Test \t  var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State \t  var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testEmptyOnOwnLineThenAttributedMemberVariable() {
    assertMacroExpansion(
      """
      struct Foo {
        @Test
        @State var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }

  func testAttributeOnOwnLineThenEmptyOnMemberVariable() {
    assertMacroExpansion(
      """
      struct Foo {
        @State
        @Test var x: Int
      }
      """,
      expandedSource: """
        struct Foo {
          @State
          var x: Int
        }
        """,
      macros: ["Test": NoOpPeerMacro.self]
    )
  }
}
