//===--- SyntaxTests.swift ------------------------------------------------===//
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

public class SyntaxTests: XCTestCase {

  public func testHasError() {
    XCTAssertTrue(TokenSyntax.funcKeyword(presence: .missing).hasError)
    XCTAssertFalse(TokenSyntax.funcKeyword(presence: .present).hasError)
    XCTAssertTrue(UnexpectedNodesSyntax([]).hasError)
    XCTAssertTrue(MissingExprSyntax().hasError)
    XCTAssertFalse(CodeBlockItemListSyntax([]).hasError)

    XCTAssertTrue(TokenListSyntax([TokenSyntax.funcKeyword(presence: .missing)]).hasError)
    XCTAssertFalse(TokenListSyntax([TokenSyntax.funcKeyword(presence: .present)]).hasError)
  }
}
