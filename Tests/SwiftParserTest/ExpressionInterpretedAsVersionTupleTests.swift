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

import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

final class ExpressionInterpretedAsVersionTupleTest: XCTestCase {
  func testExpressionInterpretedAsVersionTuple() throws {
    let expression: ExprSyntax = "1.2.3.4"
    let versionTuple = try XCTUnwrap(expression.interpretedAsVersionTuple)
    let subtreeMatcher = SubtreeMatcher(versionTuple, markers: [:])
    try subtreeMatcher.assertSameStructure(
      VersionTupleSyntax(
        major: .integerLiteral("1"),
        components: VersionComponentListSyntax([
          VersionComponentSyntax(
            period: .periodToken(),
            number: .integerLiteral("2")
          ),
          VersionComponentSyntax(
            period: .periodToken(),
            number: .integerLiteral("3")
          ),
          VersionComponentSyntax(
            period: .periodToken(),
            number: .integerLiteral("4")
          ),
        ])
      )
    )
  }

  func testExpressionInterpretedAsInvalidVersionTuple() throws {
    let expression: ExprSyntax = "2.0 + 1. + 1"
    XCTAssertNil(expression.interpretedAsVersionTuple)
  }

  func testMissingMajorComponent() throws {
    let expression: ExprSyntax = ".1.2"
    XCTAssertNil(expression.interpretedAsVersionTuple)
  }

  func testMissingSubComponentNumber() throws {
    let expression: ExprSyntax = "1.2."
    XCTAssertNil(expression.interpretedAsVersionTuple)
  }
}
