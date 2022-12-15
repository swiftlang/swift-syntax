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

final class FloatLiteralTests: XCTestCase {
  func testFloatLiteral() {
    let testCases: [UInt: (FloatLiteralExpr, String)] = [
      #line: (FloatLiteralExpr(floatingDigits: .floatingLiteral(String(123.321))), "123.321"),
      #line: (FloatLiteralExpr(floatingDigits: .floatingLiteral(String(-123.321))), "-123.321"),
      #line: (FloatLiteralExpr(floatingDigits: "2_123.321"), "2_123.321"),
      #line: (FloatLiteralExpr(floatingDigits: "-2_123.321"), "-2_123.321"),
      #line: (FloatLiteralExpr(2_123.321), "2123.321"),
      #line: (FloatLiteralExpr(-2_123.321), "-2123.321"),
      #line: (2_123.321, "2123.321"),
      #line: (-2_123.321, "-2123.321"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }
}
