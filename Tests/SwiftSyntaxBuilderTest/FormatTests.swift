import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class FormatTests: XCTestCase {
  func test_makeIndented() {
    for width in 1 ... 4 {
      let format = Format(indentWidth: width)

      XCTAssertEqual(format._indentTrivia, .zero)
      XCTAssertEqual(format._indented._indentTrivia, .spaces(width))
      XCTAssertEqual(format._indented._indented._indentTrivia, .spaces(width * 2))
    }
  }
}
