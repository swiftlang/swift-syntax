import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TriviaTests: XCTestCase {
  func testLeadingTrivia() {
    let decl = VariableDecl(
      leadingTrivia: .docLineComment("/// A doc comment") + .newlines(1),
      modifiers: [TokenSyntax.static.withLeadingTrivia(.blockComment("/* An inline comment */") + .spaces(1))],
      letOrVarKeyword: .var
    ) {
      PatternBinding(
        pattern: "test",
        typeAnnotation: "String"
      )
    }

    let syntax = decl.buildSyntax(format: Format())
    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
      /// A doc comment
      /* An inline comment */ static var test: String
      """)
  }
}
