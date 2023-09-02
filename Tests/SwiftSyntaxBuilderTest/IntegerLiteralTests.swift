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
import SwiftSyntaxBuilder
import XCTest

final class IntegerLiteralTests: XCTestCase {
  func testIntegerLiteral() {
    let testCases: [UInt: (IntegerLiteralExprSyntax, String)] = [
      #line: (IntegerLiteralExprSyntax(literal: .integerLiteral(String(123))), "123"),
      #line: (IntegerLiteralExprSyntax(literal: .integerLiteral(String(-123))), "-123"),
      #line: (IntegerLiteralExprSyntax(literal: .integerLiteral("1_000")), "1_000"),
      #line: (IntegerLiteralExprSyntax(literal: .integerLiteral("-1_000")), "-1_000"),
      #line: (IntegerLiteralExprSyntax(1_000), "1000"),
      #line: (IntegerLiteralExprSyntax(-1_000), "-1000"),
      #line: (1_000, "1000"),
      #line: (-1_000, "-1000"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }
}
