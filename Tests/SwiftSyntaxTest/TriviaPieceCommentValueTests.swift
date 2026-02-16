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

  func testNonCommentPiecesReturnNil() {
    XCTAssertNil(TriviaPiece.spaces(4).commentValue)
    XCTAssertNil(TriviaPiece.newlines(1).commentValue)
    XCTAssertNil(TriviaPiece.tabs(2).commentValue)
    XCTAssertNil(TriviaPiece.unexpectedText("abc").commentValue)
    XCTAssertNil(TriviaPiece.carriageReturns(1).commentValue)
    XCTAssertNil(TriviaPiece.backslashes(1).commentValue)
  }
}
