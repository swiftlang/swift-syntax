import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class VariableTests: XCTestCase {
  func testVariableDecl() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = VariableDecl(letOrVarKeyword: .let, bindingsBuilder:  {
        PatternBinding(pattern: IdentifierPattern(identifier: SyntaxFactory.makeIdentifier("color")),
                       typeAnnotation: TypeAnnotation(type: SimpleTypeIdentifier("UIColor")))
    })

    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣let color: UIColor
    """)
  }

  func testVariableDeclWithValue() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = VariableDecl(letOrVarKeyword: .var, bindingsBuilder:  {
        PatternBinding(pattern: IdentifierPattern(identifier: SyntaxFactory.makeIdentifier("number")),
                       typeAnnotation: TypeAnnotation(type: SimpleTypeIdentifier("Int")),
                       initializer: InitializerClause(value: IntegerLiteralExpr(digits: .integerLiteral("123"))))
    })

    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣var number: Int = 123
    """)
  }
}
