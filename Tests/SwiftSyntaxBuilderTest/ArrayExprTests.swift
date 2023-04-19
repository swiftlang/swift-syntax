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

final class ArrayExprTests: XCTestCase {
  func testPlainArrayExpr() {
    let buildable = ArrayExprSyntax {
      for i in 1...4 {
        ArrayElementSyntax(expression: IntegerLiteralExprSyntax(i))
      }
    }
    assertBuildResult(buildable, "[1, 2, 3, 4]")
  }

  func testMultilineArrayLiteral() {
    let builder = ExprSyntax(
      """
      [
        1,
        #"2"3"#,
        4,
      "五",
      ]
      """
    )
    assertBuildResult(
      builder,
      """
      [
        1,
        #"2"3"#,
        4,
        "五",
      ]
      """
    )
  }
}
