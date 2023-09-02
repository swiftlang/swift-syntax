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

final class CustomAttributeTests: XCTestCase {
  func testCustomAttributeConvenienceInitializer() {
    let testCases: [UInt: (AttributeSyntax, String)] = [
      #line: (AttributeSyntax(attributeName: TypeSyntax("Test")), "@Test"),
      #line: (AttributeSyntax("WithParens") {}, "@WithParens()"),
      #line: (
        AttributeSyntax("WithArgs") {
          LabeledExprSyntax(expression: ExprSyntax("value1"))
          LabeledExprSyntax(label: "labelled", expression: ExprSyntax("value2"))
        }, "@WithArgs(value1, labelled: value2)"
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }
}
