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
  func testFlattenCodeBlockItemListWithBuilder() {
    @CodeBlockItemListBuilder
    func buildInnerCodeBlockItemList() -> CodeBlockItemListSyntax {
      [ExprSyntax("innerBuilder1"), ExprSyntax("innerBuilder2")].lazy.map {
        FunctionCallExprSyntax(callee: $0)
      }
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
          innerBuilder1()
          innerBuilder2()
      }
      """
    )
  }

  func testFlattenCodeBlockItemListWithCodeBlockItemStrings() {
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

  func testFlattenCodeBlockItemListWithCodeBlockItemStringArray() {
    let buildable = CodeBlockItemListSyntax {
      ["let one = object.methodOne()", "let two = object.methodTwo()"]
    }

    assertBuildResult(
      buildable,
      """
      let one = object.methodOne()
      let two = object.methodTwo()
      """
    )
  }

  func testFlattenCodeBlockItemListWithCodeBlockInterpolated() {
    let block = CodeBlockItemListSyntax {
      "let a = 1"
      "let b = 2"
      "let c = 3"
    }

    let buildable = CodeBlockItemListSyntax {
      "let one = object.methodOne()"
      "let two = object.methodTwo()"
      "let three = {\(block)}()"
    }

    assertBuildResult(
      buildable,
      """
      let one = object.methodOne()
      let two = object.methodTwo()
      let three = {
          let a = 1
          let b = 2
          let c = 3
      }()
      """
    )
  }

  func testFlattenCodeBlockItemListWithTrailingNewline() {
    let buildable = CodeBlockItemListSyntax {
      DeclSyntax("let a = 1").with(\.trailingTrivia, .newline)
      DeclSyntax("let b = 2").with(\.trailingTrivia, .newline)
    }

    assertBuildResult(
      buildable,
      """
      let a = 1
      let b = 2

      """
    )
  }

}
