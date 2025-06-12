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
}
