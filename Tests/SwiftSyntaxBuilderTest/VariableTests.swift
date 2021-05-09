import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class VariableTests: XCTestCase {
  func testVariableDecl() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = VariableDecl(letOrVarKeyword: Tokens.let) {
        PatternBinding(pattern: IdentifierPattern(identifier: SyntaxFactory.makeIdentifier("color")),
                       typeAnnotation: TypeAnnotation(colon: Tokens.colon, type: SimpleTypeIdentifier("UIColor")))
    }

    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣let color: UIColor
    """)
  }

  func testVariableDeclWithValue() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = VariableDecl(letOrVarKeyword: Tokens.var) {
        PatternBinding(pattern: IdentifierPattern(identifier: SyntaxFactory.makeIdentifier("number")),
                       typeAnnotation: TypeAnnotation(colon: Tokens.colon, type: SimpleTypeIdentifier("Int")),
                       initializer: InitializerClause(equal: Tokens.equal, value: IntegerLiteralExpr(digits: Tokens.integerLiteral("123"))))
    }

    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣var number: Int = 123
    """)
  }
}
