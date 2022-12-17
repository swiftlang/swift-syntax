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

final class CollectionNodeFlatteningTests: XCTestCase {

  func test_FlattenCodeBlockItemListWithBuilder() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    @CodeBlockItemListBuilder
    func buildInnerCodeBlockItemList() -> CodeBlockItemList {
      FunctionCallExpr(callee: ExprSyntax("innerBuilder"))
    }

    @CodeBlockItemListBuilder
    func buildOuterCodeBlockItemList() -> CodeBlockItemList {
      FunctionCallExpr(callee: ExprSyntax("outerBuilder"))

      buildInnerCodeBlockItemList()
    }

    let codeBlock = CodeBlock(leadingTrivia: leadingTrivia) {
      FunctionCallExpr(callee: ExprSyntax("outsideBuilder"))
      buildOuterCodeBlockItemList()
    }

    AssertBuildResult(
      codeBlock,
      """
      ␣{
          outsideBuilder()
          outerBuilder()
          innerBuilder()
      }
      """
    )
  }
}
