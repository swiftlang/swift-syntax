import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class CollectionNodeFlatteningTests: XCTestCase {
  
  func test_FlattenCodeBlockItemListWithBuilder() {
    let leadingTrivia = Trivia.garbageText("␣")
    
    @CodeBlockItemListBuilder
    func buildInnerCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      FunctionCallExpr("innerBuilder")
    }
    
    @CodeBlockItemListBuilder
    func buildOuterCodeBlockItemList() -> ExpressibleAsCodeBlockItemList {
      FunctionCallExpr("outerBuilder")
      
      buildInnerCodeBlockItemList()
    }
    
    let codeBlock = CodeBlock {
      FunctionCallExpr("outsideBuilder")
      buildOuterCodeBlockItemList()
    }

    let test = codeBlock.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

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
      let leadingTrivia = Trivia.garbageText("␣")
      
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
        statements: CodeBlockItemList(
          combining: [
            CodeBlockItemList([FunctionCallExpr("outsideBuilder")]),
            buildOuterCodeBlockItemList()
          ]
        )
      )

      let test = codeBlock.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

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
