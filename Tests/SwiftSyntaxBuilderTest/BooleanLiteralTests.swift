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

final class BooleanLiteralTests: XCTestCase {
  func testBooleanLiteral() {
    let testCases: [UInt: (BooleanLiteralExpr, String)] = [
      #line: (BooleanLiteralExpr(booleanLiteral: .true), "true"),
      #line: (BooleanLiteralExpr(booleanLiteral: .false), "false"),
      #line: (BooleanLiteralExpr(true), "true"),
      #line: (BooleanLiteralExpr(false), "false"),
      #line: (true, "true"),
      #line: (false, "false"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }
}
