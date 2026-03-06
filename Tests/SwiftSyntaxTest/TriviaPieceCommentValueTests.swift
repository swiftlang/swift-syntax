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

import SwiftSyntax
import XCTest

class TriviaPieceCommentValueTests: XCTestCase {

  func testLineCommentValue() {
    XCTAssertEqual(TriviaPiece.lineComment("// hello").commentValue, "hello")
    XCTAssertEqual(TriviaPiece.lineComment("//hello").commentValue, "hello")
    XCTAssertEqual(TriviaPiece.lineComment("//").commentValue, "")
  }

  func testBlockCommentValue() {
    XCTAssertEqual(TriviaPiece.blockComment("/* world */").commentValue, "world")
    XCTAssertEqual(TriviaPiece.blockComment("/*world*/").commentValue, "world")
    XCTAssertEqual(TriviaPiece.blockComment("/* */").commentValue, "")
  }

  func testDocLineCommentValue() {
    XCTAssertEqual(TriviaPiece.docLineComment("/// docs").commentValue, "docs")
    XCTAssertEqual(TriviaPiece.docLineComment("///docs").commentValue, "docs")
    XCTAssertEqual(TriviaPiece.docLineComment("///").commentValue, "")
  }

  func testDocBlockCommentValue() {
    XCTAssertEqual(TriviaPiece.docBlockComment("/** docs */").commentValue, "docs")
    XCTAssertEqual(TriviaPiece.docBlockComment("/**docs*/").commentValue, "docs")
    XCTAssertEqual(TriviaPiece.docBlockComment("/** */").commentValue, "")
  }

  func testMultilineBlockCommentValue() {
    // Standard multi-line block comment with `*` decoration.
    XCTAssertEqual(
      TriviaPiece.blockComment("/*\n * Hello, folks!\n * // Apples and oranges\n * I am a banana!\n */").commentValue,
      "Hello, folks!\n// Apples and oranges\nI am a banana!"
    )

    // Doc block comment with `*` decoration.
    XCTAssertEqual(
      TriviaPiece.docBlockComment("/**\n * A documented type.\n * - Parameter x: An integer.\n */").commentValue,
      "A documented type.\n- Parameter x: An integer."
    )

    // Multi-line without `*` decoration — preserves lines as-is, stripping empty first/last.
    XCTAssertEqual(
      TriviaPiece.blockComment("/*\n  Hello\n  World\n*/").commentValue,
      "  Hello\n  World"
    )
  }

  func testNonCommentPiecesReturnNil() {
    XCTAssertNil(TriviaPiece.spaces(4).commentValue)
    XCTAssertNil(TriviaPiece.newlines(1).commentValue)
    XCTAssertNil(TriviaPiece.tabs(2).commentValue)
    XCTAssertNil(TriviaPiece.unexpectedText("abc").commentValue)
    XCTAssertNil(TriviaPiece.carriageReturns(1).commentValue)
    XCTAssertNil(TriviaPiece.backslashes(1).commentValue)
  }
}
