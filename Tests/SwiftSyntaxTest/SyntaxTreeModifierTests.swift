import XCTest
import SwiftSyntax

fileprivate func cannedVarDecl() -> VariableDeclSyntax {
  let identifierPattern = IdentifierPatternSyntax(
    identifier: TokenSyntax.identifier("a")
  )
  let pattern = PatternBindingSyntax(
    pattern: PatternSyntax(identifierPattern),
    typeAnnotation: TypeAnnotationSyntax(
      colon: TokenSyntax.colonToken(trailingTrivia: .space),
      type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("Int"), genericArgumentClause: nil))),
    initializer: nil, accessor: nil, trailingComma: nil)
  return VariableDeclSyntax(
    attributes: nil,
    modifiers: nil,
    letOrVarKeyword: .letKeyword(trailingTrivia: .space),
    bindings: PatternBindingListSyntax([pattern])
  )
}

public class SyntaxTreeModifierTests: XCTestCase {

  public func testAccessorAsModifier() {
    var VD = cannedVarDecl()
    XCTAssertEqual("\(VD)", "let a: Int")
    VD.letOrVarKeyword = .varKeyword(trailingTrivia: .space)
    XCTAssertEqual("\(VD)", "var a: Int")
  }
}
