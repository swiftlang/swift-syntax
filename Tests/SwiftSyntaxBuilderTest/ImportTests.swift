import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ImportTests: XCTestCase {
  func testImport() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let identifier = Token.identifier("SwiftSyntax")

    let importDecl = ImportDecl(
      leadingTrivia: leadingTrivia,
      path: AccessPath([AccessPathComponent(name: identifier)])
    )

    AssertBuildResult(importDecl, "␣import SwiftSyntax")
  }
}
