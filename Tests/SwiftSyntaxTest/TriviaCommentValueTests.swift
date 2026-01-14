//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftParser
import SwiftSyntax
import XCTest

class TriviaCommentValueTests: XCTestCase {

  func testDocLineCommentValues() {
    assertCommentValue("///", docCommentValue: "")
    assertCommentValue("/// Some doc line comment", docCommentValue: "Some doc line comment")
    assertCommentValue(
      """
      /// Some doc line comment
      /// Another
      """,
      docCommentValue: """
        Some doc line comment
        Another
        """
    )
    assertCommentValue(
      """
      /// - Task
      ///   - Subtask
      /// - Task 2
      """,
      docCommentValue: """
        - Task
          - Subtask
        - Task 2
        """
    )
    assertCommentValue(
      """
      ///- Task
      ///  - Subtask
      ///- Task 2
      """,
      docCommentValue: """
        - Task
          - Subtask
        - Task 2
        """
    )
    assertCommentValue(
      """
      /// included
      // ignored
      """,
      docCommentValue: "included"
    )
    assertCommentValue(
      """
      /** not included */
      /// included
      """,
      docCommentValue: "included"
    )
    assertCommentValue(
      """
      /// not included
      /* abc */
      /// included
      """,
      docCommentValue: "included"
    )
    assertCommentValue(
      """
      /// not included
      //
      /// included
      """,
      docCommentValue: "included"
    )
    assertCommentValue(
      """
      /// not included
      \("")
      /// included
      /// also included
      """,
      docCommentValue: """
        included
        also included
        """
    )
    assertCommentValue(
      """
      ///not included
      \("")
      /// included
      /// also included
      """,
      docCommentValue: """
        included
        also included
        """
    )
  }

  func testDocBlockCommentValues() {
    assertCommentValue(
      """
      /** Some doc block comment */
      """,
      docCommentValue: "Some doc block comment"
    )
    assertCommentValue(
      """
      /** Some doc block comment
      * spread on many lines */
      """,
      docCommentValue: """
        Some doc block comment
        * spread on many lines
        """
    )
    assertCommentValue(
      """
      /** Some doc block comment
      * spread on many lines
      */
      """,
      docCommentValue: """
        Some doc block comment
        * spread on many lines
        """
    )
    assertCommentValue(
      """
      /**
      Some doc block comment
      spread on many lines
      */
      """,
      docCommentValue: """
        Some doc block comment
        spread on many lines
        """
    )
    assertCommentValue(
      """
      /**
      *  Some doc block comment
      *  spread on many lines
      */
      """,
      docCommentValue: """
        *  Some doc block comment
        *  spread on many lines
        """
    )
    assertCommentValue(
      """
      /**
       *  Some doc block comment
       *  with a line comment
       */
      """,
      docCommentValue: """
        *  Some doc block comment
        *  with a line comment
        """
    )
    assertCommentValue(
      """
          /**
          Some block comment
          with another line
          */
      """,
      docCommentValue: """
        Some block comment
        with another line
        """
    )
    assertCommentValue(
      """
      /**
       Some block comment
       with another line
      */
      """,
      docCommentValue: """
         Some block comment
         with another line
        """
    )
    assertCommentValue(
      """
      /**
      *  Some doc block comment
      *  // spread on many lines
      *  with a line comment
      */
      """,
      docCommentValue: """
        *  Some doc block comment
        *  // spread on many lines
        *  with a line comment
        """
    )
    assertCommentValue(
      """
      /**
      * Some doc block comment
      * // spread on many lines
      * with a line comment
      */
      """,
      docCommentValue: """
        * Some doc block comment
        * // spread on many lines
        * with a line comment
        """
    )
    assertCommentValue("/**     abc     */", docCommentValue: "abc")
    assertCommentValue(
      """
      /**     \("")
      abc
      */
      """,
      docCommentValue: "abc"
    )
    assertCommentValue(
      """
      /**

      First paragraph.

      Second paragraph.

      */
      """,
      docCommentValue: """

        First paragraph.

        Second paragraph.

        """
    )
  }

  func testMixedStyleCommentValues() {
    assertCommentValue(
      """
      /** Some doc block comment
        * spread on many lines */
      /// Some doc line comment
      /// Some line comment
      """,
      docCommentValue: """
        Some doc line comment
        Some line comment
        """
    )
    assertCommentValue(
      """
      /** abc */
      /** def */
      """,
      docCommentValue: "def"
    )
    assertCommentValue(
      """
      /* abc */
      /** def */
      """,
      docCommentValue: "def"
    )
  }
}

private func assertCommentValue(
  _ input: String,
  docCommentValue expected: String?,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let trivia = parseTrivia(from: input)
  XCTAssertEqual(trivia.docCommentValue, expected, file: file, line: line)
}

private func parseTrivia(from input: String) -> Trivia {
  // Wrap the input in valid Swift code so the parser can recognize it
  let wrappedSource = "let _ = 0\n\(input)\nlet _ = 1"
  let sourceFile = Parser.parse(source: wrappedSource)

  // Find the token where the comment would appear (before `let _ = 1`)
  guard
    let commentToken = sourceFile.tokens(viewMode: .sourceAccurate).first(where: {
      $0.leadingTrivia.contains(where: { $0.isComment })
    })
  else {
    return []
  }

  return commentToken.leadingTrivia
}
