import XCTest
import SwiftSyntax

fileprivate func cannedVarDecl() -> VariableDeclSyntax {
  let Pattern = SyntaxFactory.makePatternBinding(
    pattern: SyntaxFactory.makeIdentifierPattern(
      identifier: SyntaxFactory.makeIdentifier("a").withLeadingTrivia(.spaces(1))),
    typeAnnotation: SyntaxFactory.makeTypeAnnotation(
      colon: SyntaxFactory.makeColonToken().withTrailingTrivia(.spaces(1)),
      type: SyntaxFactory.makeTypeIdentifier("Int")),
    initializer: nil, accessor: nil, trailingComma: nil)
  return VariableDeclSyntax {
    $0.useLetOrVarKeyword(SyntaxFactory.makeLetKeyword())
    $0.addBinding(Pattern)
  }
}

public class SyntaxTreeModifierTests: XCTestCase {

  public static let allTests = [
    ("testAccessorAsModifier", testAccessorAsModifier)
  ]

  public func testAccessorAsModifier() {
    var VD = cannedVarDecl()
    XCTAssertEqual("\(VD)", "let a: Int")
    VD.letOrVarKeyword = SyntaxFactory.makeVarKeyword().withTrailingTrivia(.spaces(0))
    XCTAssertEqual("\(VD)", "var a: Int")
  }
}
