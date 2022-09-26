import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class CollectionNodeFlatteningTests: XCTestCase {
  
  func test_FlattenCodeBlockItemListWithBuilder() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    
    @CodeBlockItemListBuilder
    func buildInnerCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      FunctionCallExpr("innerBuilder")
    }
    
    @CodeBlockItemListBuilder
    func buildOuterCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      FunctionCallExpr("outerBuilder")
      
      buildInnerCodeBlockItemList()
    }
    
    let codeBlock = CodeBlock(leadingTrivia: leadingTrivia) {
      FunctionCallExpr("outsideBuilder")
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
      CodeBlockItemList([FunctionCallExpr("innerBuilder")])
    }
    
    func buildOuterCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      CodeBlockItemList(
        combining: [
          CodeBlockItemList([FunctionCallExpr("outerBuilder")]),
          buildInnerCodeBlockItemList()
        ]
      )
    }
    
    let codeBlock = CodeBlock(
      leadingTrivia: leadingTrivia,
      statements: CodeBlockItemList(
        combining: [
          CodeBlockItemList([FunctionCallExpr("outsideBuilder")]),
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
