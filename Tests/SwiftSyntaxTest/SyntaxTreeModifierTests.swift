import XCTest
import SwiftSyntax

fileprivate func cannedVarDecl() -> VariableDeclSyntax {
  let identifierPattern = SyntaxFactory.makeIdentifierPattern(
    identifier: SyntaxFactory.makeIdentifier("a")
  )
  let pattern = SyntaxFactory.makePatternBinding(
    pattern: PatternSyntax(identifierPattern),
    typeAnnotation: SyntaxFactory.makeTypeAnnotation(
      colon: SyntaxFactory.makeColonToken().withTrailingTrivia(.space),
      type: SyntaxFactory.makeTypeIdentifier("Int")),
    initializer: nil, accessor: nil, trailingComma: nil)
  return SyntaxFactory.makeVariableDecl(
    attributes: nil,
    modifiers: nil,
    letOrVarKeyword: SyntaxFactory.makeLetKeyword(),
    bindings: SyntaxFactory.makePatternBindingList([pattern])
  )
}

public class SyntaxTreeModifierTests: XCTestCase {

  public func testAccessorAsModifier() {
    var VD = cannedVarDecl()
    XCTAssertEqual("\(VD)", "let a: Int")
    VD.letOrVarKeyword = SyntaxFactory.makeVarKeyword()
    XCTAssertEqual("\(VD)", "var a: Int")
  }
}
