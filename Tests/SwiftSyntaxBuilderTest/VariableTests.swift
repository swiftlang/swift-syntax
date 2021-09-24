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

  func testConvenienceInitializer() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (TokenSyntax, String, String, String)] = [
      #line: (TokenSyntax.let, "foo", "Int", "␣let foo: Int"),
      #line: (TokenSyntax.var, "bar", "Baz", "␣var bar: Baz")
    ]

    for (line, testCase) in testCases {
      let (keyword, name, type, expected) = testCase
      let builder = VariableDecl(keyword, name: name, type: type)
      let syntax = builder.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      XCTAssertEqual(syntax.description, expected, line: line)
    }
  }
}
