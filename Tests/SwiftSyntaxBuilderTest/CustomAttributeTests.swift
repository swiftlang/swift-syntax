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

final class CustomAttributeTests: XCTestCase {
  func testCustomAttributeConvenienceInitializer() {
    let testCases: [UInt: (CustomAttribute, String)] = [
      #line: (CustomAttribute("Test"), "@Test"),
      #line: (CustomAttribute("WithParens") {}, "@WithParens()"),
      #line: (
        CustomAttribute("WithArgs") {
          TupleExprElement(expression: "value1")
          TupleExprElement(label: "labelled", expression: "value2")
        }, "@WithArgs(value1, labelled: value2)"
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }
}
