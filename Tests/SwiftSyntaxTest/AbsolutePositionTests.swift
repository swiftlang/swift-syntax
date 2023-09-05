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
import _SwiftSyntaxTestSupport

public class AbsolutePositionTests: XCTestCase {
  public func testRecursion() {
    var l = [CodeBlockItemSyntax]()
    let idx = 2000
    for _ in 0...idx {
      l.append(
        CodeBlockItemSyntax(
          item: .init(
            ReturnStmtSyntax(
              returnKeyword: .keyword(.return, trailingTrivia: .newline)
            )
          )
        )
      )
    }
    let root = SourceFileSyntax(
      statements: CodeBlockItemListSyntax(l),
      endOfFileToken: .endOfFileToken()
    )
    let statements = root.statements
    _ = statements[statements.index(at: idx)].position
    _ = statements[statements.index(at: idx)].totalLength.utf8Length
    _ = statements[statements.index(at: idx)].positionAfterSkippingLeadingTrivia
  }

  static let leadingTrivia = Trivia(pieces: [
    .newlines(1),
    .docLineComment("/// some comment"),
    .carriageReturns(1),
  ])

  static let trailingTrivia = Trivia(pieces: [
    .blockComment("/* This is comment \r\r\n */"),
    .carriageReturnLineFeeds(1),
  ])

  func createSourceFile(_ count: Int) -> SourceFileSyntax {
    let items: [CodeBlockItemSyntax] =
      [CodeBlockItemSyntax](
        repeating: CodeBlockItemSyntax(
          item: .init(
            ReturnStmtSyntax(
              returnKeyword: .keyword(
                .return,
                leadingTrivia: AbsolutePositionTests.leadingTrivia,
                trailingTrivia: AbsolutePositionTests.trailingTrivia
              )
            )
          )
        ),
        count: count
      )
    return SourceFileSyntax(
      statements: CodeBlockItemListSyntax(items),
      endOfFileToken: .endOfFileToken()
    )
  }

  public func testTrivias() {
    let idx = 5
    let root = self.createSourceFile(idx + 1)
    XCTAssertEqual(3, root.leadingTrivia.count)
    XCTAssertEqual(0, root.trailingTrivia.count)
    let state = root.statements[root.statements.index(at: idx)]
    XCTAssertEqual(3, state.leadingTrivia.count)
    XCTAssertEqual(2, state.trailingTrivia.count)
    XCTAssertEqual(
      state.totalLength.utf8Length,
      state.leadingTrivia.sourceLength.utf8Length
        + state.trailingTrivia.sourceLength.utf8Length
        + state.trimmedLength.utf8Length
    )

    // Test Node trivia setters and getters

    XCTAssertEqual(AbsolutePositionTests.leadingTrivia, root.leadingTrivia)
    XCTAssertEqual([], root.trailingTrivia)

    var modifiedRoot1 = root.with(\.leadingTrivia, [.spaces(6), .tabs(1)])
    XCTAssertEqual([.spaces(6), .tabs(1)], modifiedRoot1.leadingTrivia)
    XCTAssertEqual(AbsolutePositionTests.leadingTrivia, root.leadingTrivia)
    modifiedRoot1.leadingTrivia = [.blockComment("/* this is a comment */")]
    XCTAssertEqual([.blockComment("/* this is a comment */")], modifiedRoot1.leadingTrivia)

    var modifiedRoot2 = root.with(\.trailingTrivia, [.tabs(2)])
    XCTAssertEqual([.tabs(2)], modifiedRoot2.trailingTrivia)
    XCTAssertEqual([], root.trailingTrivia)
    modifiedRoot2.trailingTrivia = [.carriageReturns(1), .newlines(2)]
    XCTAssertEqual([.carriageReturns(1), .newlines(2)], modifiedRoot2.trailingTrivia)

    // Test Collection trivia setters and getters

    XCTAssertEqual(AbsolutePositionTests.leadingTrivia, root.statements.leadingTrivia)
    XCTAssertEqual(AbsolutePositionTests.trailingTrivia, root.statements.trailingTrivia)

    var modifiedStatements1 = root.with(\.leadingTrivia, [.carriageReturnLineFeeds(3)])
    XCTAssertEqual([.carriageReturnLineFeeds(3)], modifiedStatements1.leadingTrivia)
    XCTAssertEqual(AbsolutePositionTests.leadingTrivia, root.statements.leadingTrivia)
    modifiedStatements1.leadingTrivia = [.unexpectedText("UNEXPECTED")]
    XCTAssertEqual([.unexpectedText("UNEXPECTED")], modifiedStatements1.leadingTrivia)

    var modifiedStatements2 = root.with(\.trailingTrivia, [.formfeeds(1), .carriageReturns(3)])
    XCTAssertEqual([.formfeeds(1), .carriageReturns(3)], modifiedStatements2.trailingTrivia)
    XCTAssertEqual(AbsolutePositionTests.trailingTrivia, root.statements.trailingTrivia)
    modifiedStatements2.trailingTrivia = [.verticalTabs(4)]
    XCTAssertEqual([.verticalTabs(4)], modifiedStatements2.trailingTrivia)
  }

  public func testWithoutSourceFileRoot() {
    let item = CodeBlockItemSyntax(
      item: .init(
        ReturnStmtSyntax(
          returnKeyword: .keyword(.return, leadingTrivia: .newline, trailingTrivia: .newline)
        )
      )
    )
    XCTAssertEqual(0, item.position.utf8Offset)
    XCTAssertEqual(1, item.positionAfterSkippingLeadingTrivia.utf8Offset)
  }

  public func testSourceLocation() {
    let filePath = "/tmp/test.swift"
    let root = self.createSourceFile(2)
    let converter = SourceLocationConverter(fileName: filePath, tree: root)
    let secondReturnStmt = root.statements[root.statements.index(at: 1)]
    let startLoc = secondReturnStmt.startLocation(converter: converter)
    XCTAssertEqual(startLoc.line, 8)
    XCTAssertEqual(startLoc.column, 1)
    XCTAssertEqual(
      converter.position(ofLine: startLoc.line, column: startLoc.column),
      secondReturnStmt.positionAfterSkippingLeadingTrivia
    )

    let startLocBeforeTrivia =
      secondReturnStmt.startLocation(
        converter: converter,
        afterLeadingTrivia: false
      )
    XCTAssertEqual(startLocBeforeTrivia.line, 6)
    XCTAssertEqual(startLocBeforeTrivia.column, 1)
    XCTAssertEqual(
      converter.position(ofLine: startLocBeforeTrivia.line, column: startLocBeforeTrivia.column),
      secondReturnStmt.position
    )

    let endLoc = secondReturnStmt.endLocation(converter: converter)
    XCTAssertEqual(endLoc.line, 8)
    XCTAssertEqual(endLoc.column, 7)

    let endLocAfterTrivia =
      secondReturnStmt.endLocation(
        converter: converter,
        afterTrailingTrivia: true
      )
    XCTAssertEqual(endLocAfterTrivia.line, 11)
    XCTAssertEqual(endLocAfterTrivia.column, 1)

    XCTAssertTrue(converter.isValid(line: startLoc.line, column: startLoc.column))
    XCTAssertFalse(converter.isValid(line: startLoc.line, column: startLoc.column + 50))
    XCTAssertFalse(converter.isValid(line: 0, column: startLoc.column))
    XCTAssertTrue(converter.isValid(position: secondReturnStmt.position))
    XCTAssertFalse(converter.isValid(position: secondReturnStmt.position + SourceLength(utf8Length: 100)))
  }
}
