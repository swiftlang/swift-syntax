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
    func buildInnerCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      FunctionCallExpr(calledExpression: "innerBuilder")
    }
    
    @CodeBlockItemListBuilder
    func buildOuterCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      FunctionCallExpr(calledExpression: "outerBuilder")
      
      buildInnerCodeBlockItemList()
    }
    
    let codeBlock = CodeBlock(leadingTrivia: leadingTrivia) {
      FunctionCallExpr(calledExpression: "outsideBuilder")
      buildOuterCodeBlockItemList()
    }

    AssertBuildResult(codeBlock, """
      ␣{
          outsideBuilder()
          outerBuilder()
          innerBuilder()
      }
      """)
  }
  
  func test_FlattenCodeBlockItemListWithConstructor() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    
    func buildInnerCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      CodeBlockItemList([FunctionCallExpr(calledExpression: "innerBuilder")])
    }
    
    func buildOuterCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      CodeBlockItemList(
        combining: [
          CodeBlockItemList([FunctionCallExpr(calledExpression: "outerBuilder")]),
          buildInnerCodeBlockItemList()
        ]
      )
    }
    
    let codeBlock = CodeBlock(
      leadingTrivia: leadingTrivia,
      statements: CodeBlockItemList(
        combining: [
          CodeBlockItemList([FunctionCallExpr(calledExpression: "outsideBuilder")]),
          buildOuterCodeBlockItemList()
        ]
      )
    )
    
    AssertBuildResult(codeBlock, """
        ␣{
            outsideBuilder()
            outerBuilder()
            innerBuilder()
        }
        """)
  }
}
