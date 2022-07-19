import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxParser
import SwiftSyntaxSupport
import XCTest

public class FuncDeclTests: XCTestCase {
  public func testAttributeParams() throws {
    let expected = SourceFile {
      FunctionDecl(
        attributes: CustomAttribute(attributeName: "attr", leftParen: .leftParen, rightParen: .rightParen) {
          TupleExprElement(expression: IdentifierExpr("p1"))
        },
        identifier: .identifier("f"),
        signature: FunctionSignature(input: ParameterClause())
      ) { }
    }
    try XCTAssertEquivalent("@attr(p1) func f() {}", expected)
  }

  public func testTrivia() throws {
    let expected = SourceFile {
      FunctionDecl(
        leadingTrivia: .spaces(4),
        funcKeyword: .func.withTrailingTrivia(.spaces(2)),
        identifier: .identifier("f"),
        signature: FunctionSignature(input: ParameterClause(leftParen: .leftParen.withTrailingTrivia(.space),
                                                            rightParen: .rightParen.withTrailingTrivia(.space)))
      ) { }
    }
    try XCTAssertEquivalent("    func  f( ) {}", expected, format: Format(autoFormat: false), includeTrivia: true)
  }
}
