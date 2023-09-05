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

final class CollectionNodeFlatteningTests: XCTestCase {
  func test_FlattenCodeBlockItemListWithBuilder() {
    @CodeBlockItemListBuilder
    func buildInnerCodeBlockItemList() -> CodeBlockItemListSyntax {
      FunctionCallExprSyntax(callee: ExprSyntax("innerBuilder"))
    }

    @CodeBlockItemListBuilder
    func buildOuterCodeBlockItemList() -> CodeBlockItemListSyntax {
      FunctionCallExprSyntax(callee: ExprSyntax("outerBuilder"))

      buildInnerCodeBlockItemList()
    }

    let codeBlock = CodeBlockSyntax {
      FunctionCallExprSyntax(callee: ExprSyntax("outsideBuilder"))
      buildOuterCodeBlockItemList()
    }

    assertBuildResult(
      codeBlock,
      """
      {
          outsideBuilder()
          outerBuilder()
          innerBuilder()
      }
      """
    )
  }

  func test_FlattenCodeBlockItemListWithCodeBlockItemStrings() {
    let buildable = CodeBlockItemListSyntax {
      "let one = object.methodOne()"
      "let two = object.methodTwo()"
    }

    assertBuildResult(
      buildable,
      """
      let one = object.methodOne()
      let two = object.methodTwo()
      """
    )
  }
}
