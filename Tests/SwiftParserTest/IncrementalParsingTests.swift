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
import SwiftParser
import _SwiftSyntaxTestSupport

public class IncrementalParsingTests: XCTestCase {

  public func testIncrementalInvalid() {
    assertIncrementalParse(
      """
      struct A⏩️⏸️A⏪️ { func f() {
      """
    )
  }

  public func testReusedNode() throws {
    try XCTSkipIf(true, "Swift parser does not handle node reuse yet")
    assertIncrementalParse(
      """
      struct A⏩️⏸️A⏪️ {}
      struct B {}
      """,
      reusedNodes: [
        ReusedNodeSpec("struct B {}", kind: .codeBlockItem)
      ]
    )
  }
}
