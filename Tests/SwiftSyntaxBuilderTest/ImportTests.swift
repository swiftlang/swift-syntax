import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ImportTests: XCTestCase {
  func testImport() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let identifier = TokenSyntax.identifier("SwiftSyntax")

    let importDecl = ImportDecl(
      leadingTrivia: leadingTrivia,
      path: AccessPath([AccessPathComponent(name: identifier)])
    )

    let syntax = importDecl.buildDecl(format: Format())

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, "␣import SwiftSyntax")
  }
}
