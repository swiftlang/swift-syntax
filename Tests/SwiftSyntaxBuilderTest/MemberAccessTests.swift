import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class MemberAccessTests: XCTestCase {
  func testMemberAccessExprConvenienceInitializers() {
    let builder = MemberAccessExpr( base: "Foo", name: "bar")
    let syntax = builder.buildSyntax()

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, "Foo.bar")
  }
}
