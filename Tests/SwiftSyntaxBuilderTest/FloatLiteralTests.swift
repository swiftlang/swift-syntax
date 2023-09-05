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

final class FloatLiteralTests: XCTestCase {
  func testFloatLiteral() {
    let testCases: [UInt: (FloatLiteralExprSyntax, String)] = [
      #line: (FloatLiteralExprSyntax(literal: .floatLiteral(String(123.321))), "123.321"),
      #line: (FloatLiteralExprSyntax(literal: .floatLiteral(String(-123.321))), "-123.321"),
      #line: (FloatLiteralExprSyntax(literal: .floatLiteral("2_123.321")), "2_123.321"),
      #line: (FloatLiteralExprSyntax(literal: .floatLiteral("-2_123.321")), "-2_123.321"),
      #line: (FloatLiteralExprSyntax(2_123.321), "2123.321"),
      #line: (FloatLiteralExprSyntax(-2_123.321), "-2123.321"),
      #line: (2_123.321, "2123.321"),
      #line: (-2_123.321, "-2123.321"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }
}
