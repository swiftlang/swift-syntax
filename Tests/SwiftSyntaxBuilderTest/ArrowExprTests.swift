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
import SwiftSyntaxBuilder

final class ArrowExprTests: XCTestCase {
  func testArrowExpr() {
    let testCases: [UInt: (ExpressibleAsArrowExpr, String)] = [
      #line: (ArrowExpr(), " -> "),
      #line: (ArrowExpr(asyncKeyword: "async"), "async -> ")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder.createArrowExpr(), expected, line: line)
    }
  }
}
