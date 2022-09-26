import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ArrayExprTests: XCTestCase {
  func testArrayExpr() {
    let testCases: [UInt: (ExpressibleAsArrayExpr, String)] = [
      #line: (ArrayElementList(), "[]"),
      #line: (ArrayElementList([ArrayElement(expression: IdentifierExpr("SomeIdenfier"))]), "[SomeIdenfier]"),
      #line: (ArrayElement(expression: IdentifierExpr("SomeIdenfier")), "[SomeIdenfier]"),
    ]
    
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let arrowExpr = builder.createArrayExpr()
      let syntax = arrowExpr.buildSyntax()
      
      var text = ""
      syntax.write(to: &text)
      
      XCTAssertEqual(text, expected, line: line)
    }
  }
}
