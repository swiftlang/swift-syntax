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

  // MARK: - Line comments

  func testLineCommentWithSpace() {
    XCTAssertEqual(TriviaPiece.lineComment("// hello").commentValue, "hello")
  }

  func testLineCommentWithoutSpace() {
    XCTAssertEqual(TriviaPiece.lineComment("//hello").commentValue, "hello")
  }

  func testLineCommentEmpty() {
    XCTAssertEqual(TriviaPiece.lineComment("//").commentValue, "")
  }

  func testLineCommentPreservesExtraLeadingSpaces() {
    // Only the first space after `//` should be stripped; additional spaces are preserved.
    XCTAssertEqual(TriviaPiece.lineComment("//  indented").commentValue, " indented")
  }

  func testLineCommentPreservesMarkdownList() {
    XCTAssertEqual(TriviaPiece.lineComment("// - Task").commentValue, "- Task")
  }

  func testLineCommentWithOnlySpace() {
    XCTAssertEqual(TriviaPiece.lineComment("// ").commentValue, "")
  }

  // MARK: - Doc line comments

  func testDocLineCommentWithSpace() {
    XCTAssertEqual(TriviaPiece.docLineComment("/// docs").commentValue, "docs")
  }

  func testDocLineCommentWithoutSpace() {
    XCTAssertEqual(TriviaPiece.docLineComment("///docs").commentValue, "docs")
  }

  func testDocLineCommentEmpty() {
    XCTAssertEqual(TriviaPiece.docLineComment("///").commentValue, "")
  }

  func testDocLineCommentPreservesExtraLeadingSpaces() {
    XCTAssertEqual(TriviaPiece.docLineComment("///  indented").commentValue, " indented")
  }

  func testDocLineCommentPreservesMarkdownList() {
    XCTAssertEqual(TriviaPiece.docLineComment("/// - Parameter x: value").commentValue, "- Parameter x: value")
  }

  func testDocLineCommentWithSubIndentation() {
    XCTAssertEqual(TriviaPiece.docLineComment("///   - Subtask").commentValue, "  - Subtask")
  }

  // MARK: - Block comments

  func testBlockCommentWithSpaces() {
    XCTAssertEqual(TriviaPiece.blockComment("/* world */").commentValue, "world")
  }

  func testBlockCommentWithoutSpaces() {
    XCTAssertEqual(TriviaPiece.blockComment("/*world*/").commentValue, "world")
  }

  func testBlockCommentEmpty() {
    XCTAssertEqual(TriviaPiece.blockComment("/**/").commentValue, "")
  }

  func testBlockCommentWithOnlySpaces() {
    XCTAssertEqual(TriviaPiece.blockComment("/* */").commentValue, "")
  }

  func testBlockCommentMultiline() {
    let text = "/* line 1\n   line 2 */"
    XCTAssertEqual(TriviaPiece.blockComment(text).commentValue, "line 1\n   line 2")
  }

  func testBlockCommentUnterminated() {
    // An unterminated block comment has no `*/` suffix; only the opening marker is stripped.
    XCTAssertEqual(TriviaPiece.blockComment("/* unterminated").commentValue, "unterminated")
  }

  func testBlockCommentOnlyLeadingSpaceStripped() {
    // Only a single leading space after `/*` is removed, not all spaces.
    XCTAssertEqual(TriviaPiece.blockComment("/*  two spaces */").commentValue, " two spaces")
  }

  func testBlockCommentOnlyTrailingSpaceStripped() {
    // Only a single trailing space before `*/` is removed.
    XCTAssertEqual(TriviaPiece.blockComment("/* trailing  */").commentValue, "trailing")
  }

  func testBlockCommentNestedLineComment() {
    // Line comment syntax inside a block comment is preserved as-is.
    XCTAssertEqual(TriviaPiece.blockComment("/* // nested */").commentValue, "// nested")
  }

  // MARK: - Doc block comments

  func testDocBlockCommentWithSpaces() {
    XCTAssertEqual(TriviaPiece.docBlockComment("/** docs */").commentValue, "docs")
  }

  func testDocBlockCommentWithoutSpaces() {
    XCTAssertEqual(TriviaPiece.docBlockComment("/**docs*/").commentValue, "docs")
  }

  func testDocBlockCommentEmpty() {
    XCTAssertEqual(TriviaPiece.docBlockComment("/**/").commentValue, "")
  }

  func testDocBlockCommentWithOnlySpaces() {
    XCTAssertEqual(TriviaPiece.docBlockComment("/** */").commentValue, "")
  }

  func testDocBlockCommentMultiline() {
    let text = "/** line 1\n    line 2 */"
    XCTAssertEqual(TriviaPiece.docBlockComment(text).commentValue, "line 1\n    line 2")
  }

  func testDocBlockCommentUnterminated() {
    XCTAssertEqual(TriviaPiece.docBlockComment("/** unterminated").commentValue, "unterminated")
  }

  // MARK: - Non-comment pieces return nil

  func testNonCommentPiecesReturnNil() {
    XCTAssertNil(TriviaPiece.spaces(4).commentValue)
    XCTAssertNil(TriviaPiece.tabs(2).commentValue)
    XCTAssertNil(TriviaPiece.newlines(1).commentValue)
    XCTAssertNil(TriviaPiece.carriageReturns(1).commentValue)
    XCTAssertNil(TriviaPiece.carriageReturnLineFeeds(1).commentValue)
    XCTAssertNil(TriviaPiece.formfeeds(1).commentValue)
    XCTAssertNil(TriviaPiece.verticalTabs(1).commentValue)
    XCTAssertNil(TriviaPiece.backslashes(1).commentValue)
    XCTAssertNil(TriviaPiece.pounds(1).commentValue)
    XCTAssertNil(TriviaPiece.unexpectedText("abc").commentValue)
  }
}
