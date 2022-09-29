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

    let test = codeBlock.buildSyntax()

    var result = ""
    test.write(to: &result)
    XCTAssertEqual(result, """
      ␣ {
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
    
    let test = codeBlock.buildSyntax()
    
    var result = ""
    test.write(to: &result)
    XCTAssertEqual(result, """
        ␣ {
            outsideBuilder()
            outerBuilder()
            innerBuilder()
        }
        """)
  }
}
