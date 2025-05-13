//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
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
  func testLineCommentValues() {
    assertCommentValue("//", commentValue: "")
    assertCommentValue("// Some line comment", commentValue: "Some line comment")

    assertCommentValue(
      """
      // Some line comment
      // Another
      """,
      commentValue: "Some line comment\nAnother"
    )

    assertCommentValue(
      """
      // - Task
      //   - Subtask
      // - Task 2
      """,
      commentValue: """
        - Task
          - Subtask
        - Task 2
        """
    )

    assertCommentValue(
      """
      //- Task
      //  - Subtask
      //- Task 2
      """,
      commentValue: """
        - Task
          - Subtask
        - Task 2
        """
    )

    assertCommentValue(
      """
      // abc

      // def
      """,
      commentValue: """
        abc
        def
        """
    )
  }

  func testDocLineCommentValues() {
    assertCommentValue("///", commentValue: "")

    assertCommentValue("/// Some doc line comment", commentValue: "Some doc line comment")

    assertCommentValue(
      """
      /// Some doc line comment
      /// Another
      """,
      commentValue: "Some doc line comment\nAnother"
    )

    assertCommentValue(
      """
      /// - Task
      ///   - Subtask
      /// - Task 2
      """,
      commentValue: """
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
      commentValue: """
        - Task
          - Subtask
        - Task 2
        """
    )
  }

  func testBlockCommentValues() {
    assertCommentValue("/**/", commentValue: "")

    assertCommentValue("/* Some block comment */", commentValue: "Some block comment")

    assertCommentValue(
      """
      /* Some block comment
      * spread on many lines */
      """,
      commentValue: """
        Some block comment
        * spread on many lines
        """
    )

    assertCommentValue(
      """
      /* Some block comment
      * spread on many lines
      */
      """,
      commentValue: """
        Some block comment
        * spread on many lines
        """
    )

    assertCommentValue(
      """
      /*
      Some block comment
      spread on many lines */
      """,
      commentValue: """
        Some block comment
        spread on many lines
        """
    )

    assertCommentValue(
      """
      /*
      *  Some block comment
      *  spread on many lines
      */
      """,
      commentValue: """
        *  Some block comment
        *  spread on many lines
        """
    )

    assertCommentValue(
      """
      /*
      Paragraph 1

      Paragraph 2
      */
      """,
      commentValue: """
        Paragraph 1

        Paragraph 2
        """
    )

    assertCommentValue(
      """
      /*
      /abc
      */
      """,
      commentValue: "/abc"
    )

    assertCommentValue("/* ///// abc */", commentValue: "///// abc")

    assertCommentValue(
      """
          /*
          Some block comment
          with another line
          */
      """,
      commentValue: """
        Some block comment
        with another line
        """
    )

    assertCommentValue(
      """
      /*
       Some block comment
       with another line
      */
      """,
      commentValue: """
         Some block comment
         with another line
        """
    )

    assertCommentValue(
      """
        /*
      unindented line
        */
      """,
      commentValue: "unindented line"
    )

    assertCommentValue(
      """
      /*
       Comment
        Comment */
      """,
      commentValue: """
        Comment
         Comment
        """
    )

    assertCommentValue(
      """
      /*
      \t\tComment
      \t\t\tComment */
      """,
      commentValue: """
        Comment
        \tComment
        """
    )

    assertCommentValue(
      """
      /*
       \t\tComment
      \t\t\tComment */
      """,
      commentValue: """
         \t\tComment
        \t\t\tComment
        """
    )

  }

  func testDocBlockCommentValues() {
    assertCommentValue(
      """
      /** Some doc block comment */
      """,
      commentValue: "Some doc block comment"
    )

    assertCommentValue(
      """
      /** Some doc block comment
      * spread on many lines */
      """,
      commentValue: """
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
      commentValue: "Some doc block comment\n* spread on many lines"
    )

    assertCommentValue(
      """
      /**
      Some doc block comment
      spread on many lines
      */
      """,
      commentValue: """
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
      commentValue: """
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
      commentValue: """
        *  Some doc block comment
        *  with a line comment
        """
    )

    assertCommentValue("/** ///// abc */", commentValue: "///// abc")

    assertCommentValue(
      """
          /**
          Some block comment
          with another line
          */
      """,
      commentValue: """
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
      commentValue: """
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
      commentValue: """
        *  Some doc block comment
        *  // spread on many lines\n*  with a line comment
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
      commentValue: """
        * Some doc block comment
        * // spread on many lines\n* with a line comment
        """
    )

    assertCommentValue("/*     abc     */", commentValue: "abc")

    assertCommentValue(
      """
      /*     \("")
      abc
      */
      """,
      commentValue: "abc"
    )
  }

  func testMixedStyleCommentValues() {
    assertCommentValue(
      """
      /** Some doc block comment
      * spread on many lines */

      /// Some doc line comment
      // Some line comment
      """,
      commentValue: nil
    )

    assertCommentValue(
      """
      /* Some block comment
      * // A line comment in a block
      * spread on many lines */
      /** Some doc block comment
      * spread on
      * many lines */
      """,
      commentValue: nil
    )

    assertCommentValue("/* abc *//* def */", commentValue: nil)
  }
}

private func assertCommentValue(
  _ input: String,
  commentValue expected: String?,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let trivia = parseTrivia(from: input)
  XCTAssertEqual(trivia.commentValue, expected, file: file, line: line)
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
