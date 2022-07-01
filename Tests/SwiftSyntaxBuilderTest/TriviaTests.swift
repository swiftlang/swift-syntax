import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TriviaTests: XCTestCase {
  func testLeadingTrivia() {
    let decl = VariableDecl(
      leadingTrivia: .docLineComment("/// A doc comment") + .newline,
      modifiers: [TokenSyntax.static.withLeadingTrivia(.blockComment("/* An inline comment */") + .space)],
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
