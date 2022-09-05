import XCTest
import SwiftSyntax
@_spi(Testing) import SwiftSyntaxBuilder

final class FormatTests: XCTestCase {
  func test_makeIndented() {
    for width in 1 ... 4 {
      let format = Format(indentWidth: width)

      XCTAssertEqual(format.indentTrivia, .zero)
      XCTAssertEqual(format._indented.indentTrivia, .spaces(width))
      XCTAssertEqual(format._indented._indented.indentTrivia, .spaces(width * 2))
    }
  }
}
