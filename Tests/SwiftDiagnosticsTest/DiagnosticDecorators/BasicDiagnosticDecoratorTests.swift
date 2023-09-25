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

final class BasicDiagnosticDecoratorTests: XCTestCase {

  private let decorator = BasicDiagnosticDecorator()

  // MARK: - Decorate Message Tests

  func testDecorateMessage() {
    let message = "File not found"

    let decoratedMessageForError = decorator.decorateMessage(message, basedOnSeverity: .error)
    assertStringsEqualWithDiff(decoratedMessageForError, "error: File not found")

    let decoratedMessageForWarning = decorator.decorateMessage(message, basedOnSeverity: .warning)
    assertStringsEqualWithDiff(decoratedMessageForWarning, "warning: File not found")

    let decoratedMessageForNote = decorator.decorateMessage(message, basedOnSeverity: .note)
    assertStringsEqualWithDiff(decoratedMessageForNote, "note: File not found")

    let decoratedMessageForRemark = decorator.decorateMessage(message, basedOnSeverity: .remark)
    assertStringsEqualWithDiff(decoratedMessageForRemark, "remark: File not found")
  }

  // MARK: - Decorate Buffer Outline Tests

  func testDecorateBufferOutline() {
    let bufferOutline = "┆"

    let decoratedOutline = decorator.decorateBufferOutline(bufferOutline)

    assertStringsEqualWithDiff(decoratedOutline, bufferOutline)
  }

  // MARK: - Decorate Highlight Tests

  func testDecorateHighlight() {
    let highlightedText = "let x = 10"

    let decoratedHighlight = decorator.decorateHighlight(highlightedText)

    assertStringsEqualWithDiff(decoratedHighlight.highlightedSourceCode, highlightedText)
    XCTAssertNil(decoratedHighlight.additionalHighlightedLine)
  }
}
