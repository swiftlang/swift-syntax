import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TriviaTests: XCTestCase {
  func testLeadingTrivia() {
    let decl = VariableDecl(
      leadingTrivia: .docLineComment("/// A doc comment") + .newline,
      modifiers: [Token.static.withLeadingTrivia(.blockComment("/* An inline comment */") + .space)],
      letOrVarKeyword: .var
    ) {
      PatternBinding(
        pattern: "test",
        typeAnnotation: "String"
      )
    }

    let syntax = decl.buildSyntax()
    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
      /// A doc comment
      /* An inline comment */ static var test: String
      """)
  }

  func testTriviaConcatenation() {
    let x = Trivia.newline
    var y = x
    y += .space
    XCTAssertEqual(y, x + .space)
    XCTAssertEqual(y, [.newlines(1), .spaces(1)])
  }

  func testAttachedTrivia() {
    let testCases: [UInt: (VariableDecl, String)] = [
      #line: (
        VariableDecl(.let, name: "x", type: "Int").withLeadingTrivia(.space),
        " let x: Int"
      ),
      #line: (
        VariableDecl(.let, name: "x", type: "Int").withTrailingTrivia(.space),
        "let x: Int "
      ),
    ]
    for (line, testCase) in testCases {
      let (decl, expected) = testCase
      let syntax = decl.buildSyntax()
      XCTAssertEqual(syntax.description, expected, line: line)
    }
  }

  func testAttachedListTrivia() {
    let testCases: [UInt: (AttributeList, String)] = [
      #line: (
        AttributeList([CustomAttribute("Test")]).withLeadingTrivia(.space),
        " @Test"
      ),
      #line: (
        AttributeList([CustomAttribute("A").withTrailingTrivia(.space), CustomAttribute("B")]).withTrailingTrivia(.space),
        "@A @B "
      ),
    ]
    for (line, testCase) in testCases {
      let (decl, expected) = testCase
      let syntax = decl.buildSyntax()
      XCTAssertEqual(syntax.description, expected, line: line)
    }
  }
}
