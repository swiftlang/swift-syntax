//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftSyntax
import _SwiftSyntaxTestSupport

public class SyntaxChildrenTests: XCTestCase {

  public func testIterateWithAllPresent() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .returnKeyword(),
      expression: ExprSyntax(MissingExprSyntax())
    )

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&iterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    try XCTAssertNext(&iterator) { $0.is(ExprSyntax.self) }
    XCTAssertNextIsNil(&iterator)
  }

  public func testIterateWithSomeMissing() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .returnKeyword()
    )

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&iterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    XCTAssertNextIsNil(&iterator)
  }

  public func testIterateWithAllMissing() {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: TokenSyntax.returnKeyword(presence: .missing)
    )

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    XCTAssertNextIsNil(&iterator)
  }

  public func testMissingTokens() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .returnKeyword(presence: .missing)
    )

    var sourceAccurateIterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    XCTAssertNextIsNil(&sourceAccurateIterator)

    var fixedUpIterator = returnStmt.children(viewMode: .fixedUp).makeIterator()
    try XCTAssertNext(&fixedUpIterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    XCTAssertNextIsNil(&fixedUpIterator)
  }

  public func testMissingNodes() throws {
    let node = DeclarationStmtSyntax(declaration: MissingDeclSyntax())

    var sourceAccurateIt = node.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&sourceAccurateIt) { $0.is(MissingDeclSyntax.self) }

    var fixedUpIt = node.children(viewMode: .fixedUp).makeIterator()
    try XCTAssertNext(&fixedUpIt) { $0.is(MissingDeclSyntax.self) }
  }
}
