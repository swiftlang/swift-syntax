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

final class DictionaryExprTests: XCTestCase {
  func testPlainDictionaryExpr() {
    let buildable = DictionaryExpr {
      for i in 1...3 {
        DictionaryElement(keyExpression: IntegerLiteralExpr(i), valueExpression: IntegerLiteralExpr(i))
      }
    }
    AssertBuildResult(buildable, "[1: 1, 2: 2, 3: 3]")
  }

  func testEmptyDictionaryExpr() {
    let buildable = DictionaryExpr()
    AssertBuildResult(buildable, "[:]")
  }

  func testMultilineDictionaryLiteral() {
    let builder = DictionaryExpr(
      """
      [
        1:1,
      2: "二",
        "three": 3,
      4:
        #"f"o"u"r"#,
      ]
      """
    )
    AssertBuildResult(
      builder,
      """
      [
          1: 1,
          2: "二",
          "three": 3,
          4:
              #"f"o"u"r"#,
      ]
      """
    )
  }
}
