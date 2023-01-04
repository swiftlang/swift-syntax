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
    let buildable = ArrayExpr {
      for i in 1...4 {
        ArrayElement(expression: IntegerLiteralExpr(i))
      }
    }
    AssertBuildResult(buildable, "[1, 2, 3, 4]")
  }

  func testMultilineArrayLiteral() {
    let builder = ArrayExpr("""
      [
        1,
        "23",
        4,
      #"5⃣️"#,
      ]
      """)
    AssertBuildResult(builder, """
      [
          1,
          "23",
          4,
          #"5⃣️"#,
      ]
      """)
  }
}
