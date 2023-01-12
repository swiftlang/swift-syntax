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
    let testCases: [UInt: (Attribute, String)] = [
      #line: (Attribute(attributeName: Type("Test")), "@Test"),
      #line: (Attribute("WithParens") {}, "@WithParens()"),
      #line: (
        Attribute("WithArgs") {
          TupleExprElement(expression: Expr("value1"))
          TupleExprElement(label: "labelled", expression: Expr("value2"))
        }, "@WithArgs(value1, labelled: value2)"
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }
}
