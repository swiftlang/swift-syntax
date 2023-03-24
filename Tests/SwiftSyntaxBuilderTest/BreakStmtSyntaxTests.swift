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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class BreakStmtSyntaxTests: XCTestCase {
  func testBreakStmtSyntax() {
    let testCases: [UInt: (StmtSyntax, String)] = [
      #line: (BreakStmtSyntax().as(StmtSyntax.self)!, "break"),
      #line: (StmtSyntax("break"), "break"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, trimTrailingWhitespace: false, line: line)
    }
  }
}
