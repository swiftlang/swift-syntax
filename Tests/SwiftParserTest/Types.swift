@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class TypeTests: XCTestCase {
  func testClosureParsing() throws {
    try AssertParse({ $0.parseType() }) {
      "(a, b) -> c"
    }

    try AssertParse({ $0.parseType() }) {
      "@MainActor (a, b) async throws -> c"
    }
  }

  func testGenericTypeWithTrivia() throws {
    // N.B. Whitespace is significant here.
    try AssertParse({ $0.parseType() }) {
      """
              Foo<Bar<
                  V, Baz<Quux>
              >>
      """
    }
  }
}
