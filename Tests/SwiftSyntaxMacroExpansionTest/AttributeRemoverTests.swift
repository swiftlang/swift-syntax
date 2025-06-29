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

import SwiftParser
import SwiftSyntax
@_spi(Testing) import SwiftSyntaxMacroExpansion
import XCTest
import _SwiftSyntaxTestSupport

private func assertSyntaxRemovingTestAttributes(
  _ originalSource: String,
  reduction expectedReducedSource: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let attributeToRemove = AttributeSyntax(stringLiteral: "@Test")

  let reducedSource = AttributeRemover(
    removingWhere: { $0.trimmedDescription == attributeToRemove.trimmedDescription }
  )
  .rewrite(
    Parser.parse(source: originalSource)
  )

  assertStringsEqualWithDiff(
    reducedSource.description,
    expectedReducedSource,
    "Attribute removal did not produce the expected reduced source",
    additionalInfo: """
      Actual reduced source:
      \(reducedSource)
      """,
    file: file,
    line: line
  )
}

final class AttributeRemoverTests: XCTestCase {
  func testEmptyOnSameLineAsVariable() {
    assertSyntaxRemovingTestAttributes(
      "@Test var x: Int",
      reduction: "var x: Int"
    )
  }

  func testEmptyTwiceOnSameLineAsVariable() {
    assertSyntaxRemovingTestAttributes(
      "@Test @Test var x: Int",
      reduction: "var x: Int"
    )
  }

  // FIXME: `AttributeRemover` should not leave a leading newline.
  func testEmptyOnOwnLineBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test
      var x: Int
      """,
      reduction: "\nvar x: Int"
    )
  }

  // FIXME: `AttributeRemover` should not leave a leading newline.
  func testEmptyTwiceOnOwnLineBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test @Test
      var x: Int
      """,
      reduction: "\nvar x: Int"
    )
  }

  func testEmptyAndAttributeOnOwnLineBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test @State
      var x: Int
      """,
      reduction: """
        @State
        var x: Int
        """
    )
  }

  func testAttributeAndEmptyOnOwnLineBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @State @Test
      var x: Int
      """,
      reduction: """
        @State
        var x: Int
        """
    )
  }

  func testAttributeAndEmptyAndCommentOnOwnLineBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @State @Test// comment
      var x: Int
      """,
      reduction: """
        @State // comment
        var x: Int
        """
    )
  }

  func testAttributeAndEmptyAndCommentOnOwnLineBeforeVariable2() {
    assertSyntaxRemovingTestAttributes(
      """
      @State @Test // comment
      var x: Int
      """,
      reduction: """
        @State // comment
        var x: Int
        """
    )
  }

  func testCommentsAroundEmpty() {
    assertSyntaxRemovingTestAttributes(
      """
      struct S {
        /// Some doc comment
        @Test /* trailing */
        var value: Int
      }
      """,
      reduction: """
        struct S {
          /// Some doc comment
          /* trailing */
          var value: Int
        }
        """
    )
  }

  func testBlockCommentNewlineEmpty() {
    assertSyntaxRemovingTestAttributes(
      """
      /* comment */
      @Test
      var value: Int
      """,
      reduction: """
        /* comment */
        var value: Int
        """
    )
  }

  // FIXME: `AttributeRemover` should not leave a leading newline.
  func testEmptyNewlineBlockComment() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test
      /* comment */
      var value: Int
      """,
      reduction: """
        \n/* comment */
        var value: Int
        """
    )
  }

  func testAttributeNewlineBlockCommentEmpty() {
    assertSyntaxRemovingTestAttributes(
      """
      @State
      /*doc comment*/@Test
      var x: Int
      """,
      reduction: """
        @State
        /*doc comment*/
        var x: Int
        """
    )
  }

  func testEmptyBlockCommentEmpty() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test /* comment */ @Test var value: Int
      """,
      reduction: """
        /* comment */ var value: Int
        """
    )
  }

  func testEmptyBlockCommentEmptyNewline() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test /* comment */ @Test
      var value: Int
      """,
      reduction: """
        /* comment */
        var value: Int
        """
    )
  }

  func testEmptyBlockCommentEmptyBlockComment() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test /* comment1 */ @Test /* comment2 */ var value: Int
      """,
      reduction: """
        /* comment1 */ /* comment2 */ var value: Int
        """
    )
  }

  func testEmptyWithLeadingSpace_SpacePreserved() {
    assertSyntaxRemovingTestAttributes(
      """
      \u{0020}@Test var value: Int
      """,
      reduction: """
        \u{0020}var value: Int
        """
    )
  }

  func testEmptyWithLeadingSpaceOnMember_SpacePreserved() {
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        \u{0020}@Test var x: Int
      }
      """,
      reduction: """
        struct Foo {
          \u{0020}var x: Int
        }
        """
    )
  }

  func testEmptyAndAttributeMashedTogether() {
    // NB: In Swift, attributes can validly cozy up without whitespace.
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @Test@State var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State var x: Int
        }
        """
    )
  }

  func testAttributeAndEmptyMashedTogether() {
    // NB: In Swift, attributes can validly cozy up without whitespace.
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @State@Test var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State var x: Int
        }
        """
    )
  }

  func testEmptyAndAttributeMashedTogether_VariableNextLine() {
    // NB: In Swift, attributes can validly cozy up without whitespace.
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @Test@State
        var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State
          var x: Int
        }
        """
    )
  }

  func testAttributeAndEmptyMashedTogether_VariableNextLine() {
    // NB: In Swift, attributes can validly cozy up without whitespace.
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @State@Test
        var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State
          var x: Int
        }
        """
    )
  }

  func testAttributeAndEmptyOnOwnLinesBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @State
      @Test
      var x: Int
      """,
      reduction: """
        @State
        var x: Int
        """
    )
  }

  // FIXME: `AttributeRemover` should not leave a leading newline.
  func testEmptyAndAttributeOnOwnLinesBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test
      @State
      var x: Int
      """,
      reduction: """
        \n@State
        var x: Int
        """
    )
  }

  func testAttributeOnOwnLineThenEmptyBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @State
      @Test var x: Int
      """,
      reduction: """
        @State
        var x: Int
        """
    )
  }

  // FIXME: `AttributeRemover` should not leave a leading newline.
  func testEmptyOnOwnLineThenEmptyBeforeVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      @Test
      @Test var x: Int
      """,
      reduction: "\nvar x: Int"
    )
  }

  func testEmptyOnMemberVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @Test var x: Int
      }
      """,
      reduction: """
        struct Foo {
          var x: Int
        }
        """
    )
  }

  func testEmptyBeforeAttributeOnSameLineAsMemberVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @Test @State var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State var x: Int
        }
        """
    )
  }

  func testEmptyAfterAttributeOnSameLineAsMemberVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @State @Test var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State var x: Int
        }
        """
    )
  }

  func testEmptyAfterAttributeOnSameLineAsMemberVariable_AwkwardWhitespace() {
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @State \t  @Test \t  var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State \t  var x: Int
        }
        """
    )
  }

  func testEmptyOnOwnLineThenAttributedMemberVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @Test
        @State var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State var x: Int
        }
        """
    )
  }

  func testAttributeOnOwnLineThenEmptyOnMemberVariable() {
    assertSyntaxRemovingTestAttributes(
      """
      struct Foo {
        @State
        @Test var x: Int
      }
      """,
      reduction: """
        struct Foo {
          @State
          var x: Int
        }
        """
    )
  }

  func testKeepPoundIfInAttributes() {
    assertSyntaxRemovingTestAttributes(
      """
      #if true
      @inlinable
      #endif
      func f() {}
      """,
      reduction: """
        #if true
        @inlinable
        #endif
        func f() {}
        """
    )
  }
}
