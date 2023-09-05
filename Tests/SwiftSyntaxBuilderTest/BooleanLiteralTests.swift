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

final class BooleanLiteralTests: XCTestCase {
  func testBooleanLiteral() {
    let testCases: [UInt: (BooleanLiteralExprSyntax, String)] = [
      #line: (BooleanLiteralExprSyntax(literal: .keyword(.true)), "true"),
      #line: (BooleanLiteralExprSyntax(literal: .keyword(.false)), "false"),
      #line: (BooleanLiteralExprSyntax(true), "true"),
      #line: (BooleanLiteralExprSyntax(false), "false"),
      #line: (true, "true"),
      #line: (false, "false"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }
}
