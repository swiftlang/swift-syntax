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

final class TernaryExprTests: XCTestCase {
  func testStringLiteralTernaryExpr() {
    let buildable = ExprSyntax("true ? a : b")
    assertBuildResult(
      buildable,
      """
      true ? a : b
      """
    )
  }

  func testTernarySequenceExpr() {
    let buildable = SequenceExprSyntax {
      BooleanLiteralExprSyntax(true)
      UnresolvedTernaryExprSyntax(thenExpression: IntegerLiteralExprSyntax(1))
      IntegerLiteralExprSyntax(0)
    }
    assertBuildResult(
      buildable,
      """
      true ? 1 : 0
      """
    )
  }

  func testTernaryExpr() {
    let buildable = TernaryExprSyntax(
      condition: BooleanLiteralExprSyntax(true),
      thenExpression: IntegerLiteralExprSyntax(1),
      elseExpression: IntegerLiteralExprSyntax(0)
    )
    assertBuildResult(
      buildable,
      """
      true ? 1 : 0
      """
    )
  }
}
