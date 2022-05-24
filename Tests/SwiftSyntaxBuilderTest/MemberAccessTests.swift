import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class MemberAccessTests: XCTestCase {
  func testMemberAccessExprConvenienceInitializers() {
    let leadingTrivia = Trivia.garbageText("␣")

    let builder = MemberAccessExpr(base: "Foo", name: "bar")
    let syntax = builder.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, "␣Foo.bar")
  }
}
