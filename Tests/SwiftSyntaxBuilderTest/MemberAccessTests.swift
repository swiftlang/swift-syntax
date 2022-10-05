import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class MemberAccessTests: XCTestCase {
  func testMemberAccessExprConvenienceInitializers() {
    let builder = MemberAccessExpr( base: "Foo", name: "bar")
    AssertBuildResult(builder, "Foo.bar")
  }
}
