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

class SyntaxChildrenTests: XCTestCase {

  public func testIterateWithAllPresent() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .keyword(.return),
      expression: ExprSyntax(MissingExprSyntax())
    )

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&iterator) { $0.as(TokenSyntax.self)?.tokenKind == .keyword(.return) }
    try XCTAssertNext(&iterator) { $0.is(ExprSyntax.self) }
    XCTAssertNextIsNil(&iterator)
  }

  public func testIterateWithSomeMissing() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .keyword(.return)
    )

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&iterator) { $0.as(TokenSyntax.self)?.tokenKind == .keyword(.return) }
    XCTAssertNextIsNil(&iterator)
  }

  public func testIterateWithAllMissing() {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: TokenSyntax.keyword(.return, presence: .missing)
    )

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    XCTAssertNextIsNil(&iterator)
  }

  public func testMissingTokens() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .keyword(.return, presence: .missing)
    )

    var sourceAccurateIterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    XCTAssertNextIsNil(&sourceAccurateIterator)

    var fixedUpIterator = returnStmt.children(viewMode: .fixedUp).makeIterator()
    try XCTAssertNext(&fixedUpIterator) { $0.as(TokenSyntax.self)?.tokenKind == .keyword(.return) }
    XCTAssertNextIsNil(&fixedUpIterator)
  }

  public func testMissingNodes() throws {
    let node = ReturnStmtSyntax(returnKeyword: .keyword(.return), expression: ExprSyntax(MissingExprSyntax()))

    var sourceAccurateIt = node.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&sourceAccurateIt) { $0.is(TokenSyntax.self) }
    try XCTAssertNext(&sourceAccurateIt) { $0.is(MissingExprSyntax.self) }

    var fixedUpIt = node.children(viewMode: .fixedUp).makeIterator()
    try XCTAssertNext(&fixedUpIt) { $0.is(TokenSyntax.self) }
    try XCTAssertNext(&fixedUpIt) { $0.is(MissingExprSyntax.self) }
  }

  public func testTokenSequencesWithMissingChild() {
    let codeBlock = CodeBlockSyntax(
      leftBrace: .leftBraceToken(presence: .missing),
      statements: [],
      rightBrace: .rightBraceToken(presence: .missing)
    )

    XCTAssertEqual(Array(codeBlock.tokens(viewMode: .all)).count, 2)
  }
}
