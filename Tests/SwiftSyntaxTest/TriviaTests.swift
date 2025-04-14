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
import XCTest

class TriviaTests: XCTestCase {

  func testTriviaEquatable() {
    XCTAssertEqual([.spaces(2), .tabs(1)] as Trivia, [.spaces(2), .tabs(1)])
    XCTAssertNotEqual([.spaces(2), .tabs(1)] as Trivia, [.spaces(2), .tabs(2)])
    XCTAssertNotEqual([.spaces(5)] as Trivia, [.spaces(2), .spaces(3)])
  }

  func testTriviaPieceEquatable() {
    XCTAssertEqual(TriviaPiece.spaces(1), .spaces(1))
    XCTAssertNotEqual(TriviaPiece.spaces(2), .spaces(4))
    XCTAssertNotEqual(TriviaPiece.spaces(2), .tabs(2))

    XCTAssertEqual(TriviaPiece.tabs(2), .tabs(2))
    XCTAssertNotEqual(TriviaPiece.tabs(1), .tabs(2))
    XCTAssertNotEqual(TriviaPiece.tabs(1), .verticalTabs(1))

    XCTAssertEqual(TriviaPiece.verticalTabs(3), .verticalTabs(3))
    XCTAssertNotEqual(TriviaPiece.verticalTabs(5), .verticalTabs(1))
    XCTAssertNotEqual(TriviaPiece.verticalTabs(5), .formfeeds(5))

    XCTAssertEqual(TriviaPiece.formfeeds(2), .formfeeds(2))
    XCTAssertNotEqual(TriviaPiece.formfeeds(1), .formfeeds(2))
    XCTAssertNotEqual(TriviaPiece.formfeeds(1), .newlines(1))

    XCTAssertEqual(TriviaPiece.newlines(3), .newlines(3))
    XCTAssertNotEqual(TriviaPiece.newlines(2), .newlines(1))
    XCTAssertNotEqual(TriviaPiece.newlines(2), .carriageReturns(2))

    XCTAssertEqual(TriviaPiece.carriageReturns(2), .carriageReturns(2))
    XCTAssertNotEqual(TriviaPiece.carriageReturns(1), .carriageReturns(3))
    XCTAssertNotEqual(TriviaPiece.carriageReturns(1), .carriageReturnLineFeeds(3))

    XCTAssertEqual(TriviaPiece.carriageReturnLineFeeds(3), .carriageReturnLineFeeds(3))
    XCTAssertNotEqual(TriviaPiece.carriageReturnLineFeeds(4), .carriageReturnLineFeeds(2))

    XCTAssertEqual(TriviaPiece.lineComment("a"), .lineComment("a"))
    XCTAssertNotEqual(TriviaPiece.lineComment("a"), .lineComment("b"))
    XCTAssertNotEqual(TriviaPiece.lineComment("a"), .blockComment("a"))

    XCTAssertEqual(TriviaPiece.blockComment("b"), .blockComment("b"))
    XCTAssertNotEqual(TriviaPiece.blockComment("b"), .blockComment("c"))
    XCTAssertNotEqual(TriviaPiece.blockComment("b"), .docLineComment("b"))

    XCTAssertEqual(TriviaPiece.docLineComment("c"), .docLineComment("c"))
    XCTAssertNotEqual(TriviaPiece.docLineComment("c"), .docLineComment("d"))
    XCTAssertNotEqual(TriviaPiece.docLineComment("c"), .docBlockComment("c"))

    XCTAssertEqual(TriviaPiece.docBlockComment("d"), .docBlockComment("d"))
    XCTAssertNotEqual(TriviaPiece.docBlockComment("d"), .docBlockComment("e"))
    XCTAssertNotEqual(TriviaPiece.docBlockComment("d"), .unexpectedText("d"))

    XCTAssertEqual(TriviaPiece.unexpectedText("e"), .unexpectedText("e"))
    XCTAssertNotEqual(TriviaPiece.unexpectedText("e"), .unexpectedText("f"))
    XCTAssertNotEqual(TriviaPiece.unexpectedText("e"), .lineComment("e"))
  }

  func testTriviaCommentValues() {

    // MARK: Line comment

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

    // MARK: Doc line comment

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

    // MARK: Block comment

    assertCommentValue("/* Some block comment */", commentValue: "Some block comment")

    assertCommentValue(
      """
      /* Some block comment
      * spread on many lines */
      """,
      commentValue: "Some block comment\n* spread on many lines"
    )

    assertCommentValue(
      """
      /* Some block comment
      * spread on many lines
      */
      """,
      commentValue: "Some block comment\n* spread on many lines"
    )

    assertCommentValue(
      """
      /*
      Some block comment
      spread on many lines */
      """,
      commentValue: "Some block comment\nspread on many lines"
    )

    assertCommentValue(
      """
      /* Some block comment
      * spread on many lines */
      /* Another block comment */
      """,
      commentValue: "Some block comment\n* spread on many lines\nAnother block comment"
    )

    assertCommentValue(
      """
      /* Some block comment
      * spread on many lines */

      /* Another block comment */
      """,
      commentValue: "Some block comment\n* spread on many lines\nAnother block comment"
    )

    assertCommentValue(
      """
      /*
      *  Some block comment
      *  spread on many lines
      */
      """,
      commentValue: "*  Some block comment\n*  spread on many lines"
    )

    assertCommentValue(
      """
      /*
      Paragraph 1

      Paragraph 2
      */
      """,
      commentValue: "Paragraph 1\n\nParagraph 2"
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
      commentValue: "Some block comment\nwith another line"
    )

    assertCommentValue(
      """
      /*
       Some block comment
       with another line
      */
      """,
      commentValue: " Some block comment\n with another line"
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
      commentValue: "Comment\n Comment")

    // MARK: Doc block comment

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
      commentValue: "Some doc block comment\n* spread on many lines"
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
      /** Some doc block comment
      * spread on many lines */
      /** Another doc block comment */
      """,
      commentValue: "Some doc block comment\n* spread on many lines\nAnother doc block comment"
    )

    assertCommentValue(
      """
      /** Some doc block comment
      * spread on many lines */

      /** Another doc block comment */
      """,
      commentValue: "Some doc block comment\n* spread on many lines\nAnother doc block comment"
    )

    assertCommentValue(
      """
      /**
      Some doc block comment
      spread on many lines
      */
      """,
      commentValue: "Some doc block comment\nspread on many lines"
    )

    assertCommentValue(
      """
      /**
      *  Some doc block comment
      *  spread on many lines
      */
      """,
      commentValue: "*  Some doc block comment\n*  spread on many lines"
    )

    assertCommentValue(
      """
      /**
       *  Some doc block comment
       *  with a line comment
       */
      """,
      commentValue: "*  Some doc block comment\n*  with a line comment"
    )

    assertCommentValue("/** ///// abc */", commentValue: "///// abc")

    assertCommentValue(
      """
          /**
          Some block comment
          with another line
          */
      """,
      commentValue: "Some block comment\nwith another line"
    )

    assertCommentValue(
      """
      /**
       Some block comment
       with another line
      */
      """,
      commentValue: " Some block comment\n with another line"
    )

    // MARK: Mixing comment styles

    assertCommentValue(
      """
      /**
      *  Some doc block comment
      *  // spread on many lines
      *  with a line comment
      */
      """,
      commentValue: "*  Some doc block comment\n*  // spread on many lines\n*  with a line comment"
    )

    assertCommentValue(
      """
      /**
      * Some doc block comment
      * // spread on many lines
      * with a line comment
      */
      """,
      commentValue: "* Some doc block comment\n* // spread on many lines\n* with a line comment"
    )

    assertCommentValue(
      """
      /** Some doc block comment
      * spread on many lines */

      /// Some doc line comment
      // Some line comment

      /* Some block comment
      * spread on many lines */
      /** Another doc block comment */
      """,
      commentValue: """
        Some doc block comment
        * spread on many lines
        Some doc line comment
        Some line comment
        Some block comment
        * spread on many lines
        Another doc block comment
        """
    )

    assertCommentValue(
      """
      /* Some block comment
      * // A line comment in a block
      * spread on many lines */
      /** Some doc block comment
      * /// A doc line comment in a block
      * spread on
      * many lines */
      """,
      commentValue: """
        Some block comment
        * // A line comment in a block
        * spread on many lines
        Some doc block comment
        * /// A doc line comment in a block
        * spread on
        * many lines
        """
    )
  }
}

func assertCommentValue(
  _ input: String,
  commentValue expected: String,
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
