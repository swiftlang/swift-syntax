//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TupleTests: XCTestCase {
  func testLabeledElementList() {
    let builder = TupleExprSyntax("(p1: value1, p2: value2, p3: value3)")
    AssertBuildResult(builder, "(p1: value1, p2: value2, p3: value3)")
  }

  func testMultilineTupleExpr() {
    let builder = TupleExprSyntax(
      """
      (
      p1: value1,
      p2: value2,
      p3: value3,
      p4: value4,
      p5: value5
      )
      """
    )

    AssertBuildResult(
      builder,
      """
      (
          p1: value1,
          p2: value2,
          p3: value3,
          p4: value4,
          p5: value5
      )
      """
    )
  }

  func testMultilineTupleType() {
    let builder = TupleTypeSyntax(
      """
      (
      Int,
      p2: Int,
      Int,
      p4: Int,
      Int
      )
      """
    )

    AssertBuildResult(
      builder,
      """
      (
          Int,
          p2: Int,
          Int,
          p4: Int,
          Int
      )
      """
    )
  }
}
