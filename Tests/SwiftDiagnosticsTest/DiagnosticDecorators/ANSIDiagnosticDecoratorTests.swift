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

@_spi(Testing) import SwiftDiagnostics
import XCTest
import _SwiftSyntaxTestSupport

final class ANSIDiagnosticDecoratorTests: XCTestCase {

  private let decorator = ANSIDiagnosticDecorator()

  // MARK: - Decorate Message Tests

  func testDecorateMessage() {
    let message = "File not found"

    let decoratedMessageForError = decorator.decorateMessage(message, basedOnSeverity: .error)
    assertStringsEqualWithDiff(decoratedMessageForError, "\u{1B}[1;31merror: \u{1B}[1;39mFile not found\u{1B}[0;0m")

    let decoratedMessageForWarning = decorator.decorateMessage(message, basedOnSeverity: .warning)
    assertStringsEqualWithDiff(decoratedMessageForWarning, "\u{1B}[1;33mwarning: \u{1B}[1;39mFile not found\u{1B}[0;0m")

    let decoratedMessageForNote = decorator.decorateMessage(message, basedOnSeverity: .note)
    assertStringsEqualWithDiff(decoratedMessageForNote, "\u{1B}[1;39mnote: \u{1B}[1;39mFile not found\u{1B}[0;0m")

    let decoratedMessageForRemark = decorator.decorateMessage(message, basedOnSeverity: .remark)
    assertStringsEqualWithDiff(decoratedMessageForRemark, "\u{1B}[1;34mremark: \u{1B}[1;39mFile not found\u{1B}[0;0m")
  }

  func testDecorateMessageWithEmptyMessage() {
    let decoratedMessageForError = decorator.decorateMessage("", basedOnSeverity: .error)

    assertStringsEqualWithDiff(decoratedMessageForError, "\u{1B}[1;31merror: ")
  }

  // MARK: - Decorate Buffer Outline Tests

  func testDecorateBufferOutline() {
    let bufferOutline = "    │"

    let decoratedOutline = decorator.decorateBufferOutline(bufferOutline)

    assertStringsEqualWithDiff(decoratedOutline, "\u{1B}[0;36m    │\u{1B}[0;0m")
  }

  func testDecorateBufferOutlineWithEmptyString() {

    let decoratedOutline = decorator.decorateBufferOutline("")

    assertStringsEqualWithDiff(decoratedOutline, "")
  }

  // MARK: - Decorate Highlight Tests

  func testDecorateHighlight() {
    let highlightedText = "let x = 10"

    let decoratedHighlight = decorator.decorateHighlight(highlightedText)

    assertStringsEqualWithDiff(decoratedHighlight.highlightedSourceCode, "\u{1B}[4;39mlet x = 10\u{1B}[0;0m")
    XCTAssertNil(decoratedHighlight.additionalHighlightedLine)
  }

  func testDecorateHighlightWithEmptyString() {
    let decoratedHighlight = decorator.decorateHighlight("")

    assertStringsEqualWithDiff(decoratedHighlight.highlightedSourceCode, "")
    XCTAssertNil(decoratedHighlight.additionalHighlightedLine)
  }
}
