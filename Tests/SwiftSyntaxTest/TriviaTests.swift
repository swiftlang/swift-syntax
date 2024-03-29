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
    XCTAssertTrue(Trivia(pieces: []).commentValues.isEmpty)

    // MARK: line comment

    XCTAssertEqual(
      Trivia(pieces: [.lineComment("")]).commentValues,
      [""]
    )

    XCTAssertEqual(
      Trivia(pieces: [.lineComment("Some line comment")]).commentValues,
      ["Some line comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [.lineComment("// Some line comment")]).commentValues,
      ["Some line comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .lineComment("// Some line comment"),
        .lineComment("// Another"),
      ]).commentValues,
      [
        "Some line comment",
        "Another",
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .lineComment("// Some line comment"),
        .lineComment("Other"),
      ]).commentValues,
      [
        "Some line comment",
        "Other",
      ]
    )

    // MARK: doc line comment

    XCTAssertEqual(
      Trivia(pieces: [.docLineComment("")]).commentValues,
      [""]
    )

    XCTAssertEqual(
      Trivia(pieces: [.docLineComment("Some doc line comment")]).commentValues,
      ["Some doc line comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [.docLineComment("/// Some doc line comment")]).commentValues,
      ["Some doc line comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docLineComment("/// Some doc line comment"),
        .docLineComment("/// Another"),
      ]).commentValues,
      [
        "Some doc line comment",
        "Another",
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docLineComment("/// Some doc line comment"),
        .docLineComment("Other"),
      ]).commentValues,
      [
        "Some doc line comment",
        "Other",
      ]
    )

    // MARK: block comment

    XCTAssertEqual(
      Trivia(pieces: [.blockComment("")]).commentValues,
      [""]
    )

    XCTAssertEqual(
      Trivia(pieces: [.blockComment("Some block comment")]).commentValues,
      ["Some block comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [.blockComment("/* Some block comment */")]).commentValues,
      ["Some block comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .blockComment("/* Some block comment"),
        .blockComment("* spread on many lines */"),
      ]).commentValues,
      [
        "Some block comment spread on many lines"
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .blockComment("/* Some block comment"),
        .blockComment("* spread on many lines"),
        .blockComment("*/"),
      ]).commentValues,
      [
        "Some block comment spread on many lines"
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .blockComment("/* Some block comment"),
        .blockComment("* spread on many lines */"),
        .blockComment("/* Another block comment */"),
      ]).commentValues,
      [
        "Some block comment spread on many lines",
        "Another block comment",
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .blockComment("/* Some block comment"),
        .blockComment("* spread on many lines */"),
        .newlines(2),
        .blockComment("/* Another block comment */"),
      ]).commentValues,
      [
        "Some block comment spread on many lines",
        "Another block comment",
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .blockComment(
          """
          /*
          Some block comment
          spread on many lines
          */
          """
        )
      ]).commentValues,
      ["Some block comment spread on many lines"]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .blockComment(
          """
          /*
          *  Some block comment
          *  spread on many lines
          */
          """
        )
      ]).commentValues,
      ["Some block comment spread on many lines"]
    )

    // MARK: doc block comment

    XCTAssertEqual(
      Trivia(pieces: [.docBlockComment("")]).commentValues,
      [""]
    )

    XCTAssertEqual(
      Trivia(pieces: [.docBlockComment("Some doc block comment")]).commentValues,
      ["Some doc block comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [.docBlockComment("/** Some doc block comment */")]).commentValues,
      ["Some doc block comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment("/** Some doc block comment"),
        .docBlockComment("* spread on many lines */"),
      ]).commentValues,
      [
        "Some doc block comment spread on many lines"
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment("/** Some doc block comment"),
        .docBlockComment("* spread on many lines"),
        .docBlockComment("*/"),
      ]).commentValues,
      [
        "Some doc block comment spread on many lines"
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment("/** Some doc block comment"),
        .docBlockComment("* spread on many lines */"),
        .docBlockComment("/** Another doc block comment */"),
      ]).commentValues,
      [
        "Some doc block comment spread on many lines",
        "Another doc block comment",
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment("/** Some doc block comment"),
        .docBlockComment("* spread on many lines */"),
        .newlines(2),
        .docBlockComment("/** Another doc block comment */"),
      ]).commentValues,
      [
        "Some doc block comment spread on many lines",
        "Another doc block comment",
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment(
          """
          /**
          Some doc block comment
          spread on many lines
          */
          """
        )
      ]).commentValues,
      ["Some doc block comment spread on many lines"]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment(
          """
          /**
          *  Some doc block comment
          *  spread on many lines
          */
          """
        )
      ]).commentValues,
      ["Some doc block comment spread on many lines"]
    )

    // MARK: Mixing comment styles

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment(
          """
          /**
          *  Some doc block comment
          *  // spread on many lines
          *  with a line comment
          */
          """
        )
      ]).commentValues,
      ["Some doc block comment // spread on many lines with a line comment"]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment("/** Some doc block comment"),
        .docBlockComment("* spread on many lines */"),
        .newlines(2),
        .docLineComment("/// Some doc line comment"),
        .docLineComment("// Some line comment"),
        .newlines(2),
        .spaces(4),
        .blockComment("/* Some block comment"),
        .blockComment("* spread on many lines */"),
        .newlines(2),
        .docBlockComment("/** Another doc block comment */"),
      ]).commentValues,
      [
        "Some doc block comment spread on many lines",
        "Some doc line comment",
        "Some line comment",
        "Some block comment spread on many lines",
        "Another doc block comment",
      ]
    )

    XCTAssertEqual(
      Trivia(pieces: [
        .docBlockComment("/* Some block comment"),
        .docLineComment("// A line comment in a block"),
        .docBlockComment("* spread on many lines */"),
        .newlines(2),
        .blockComment("/** Some doc block comment"),
        .docLineComment("/// A doc line comment in a block"),
        .blockComment("* spread on"),
        .blockComment("* many lines */"),
      ]).commentValues,
      [
        "Some block comment // A line comment in a block spread on many lines",
        "Some doc block comment /// A doc line comment in a block spread on many lines",
      ]
    )
  }
}
