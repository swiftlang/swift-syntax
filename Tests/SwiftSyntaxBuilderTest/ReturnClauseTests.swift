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

final class ReturnClauseTests: XCTestCase {
  func testReturnClause() {
    let testCases: [UInt: (ExpressibleAsReturnClause, String)] = [
      #line: (ReturnClause(returnType: "Int"), " -> Int"),
      #line: (ArrayType(elementType: "Int"), " -> [Int]"),
      #line: ("Int", " -> Int"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder.createReturnClause(), expected, line: line)
    }
  }
}
