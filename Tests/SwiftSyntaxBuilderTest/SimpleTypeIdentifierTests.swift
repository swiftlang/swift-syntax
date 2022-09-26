import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class SimpleTypeIdentifierTests: XCTestCase {
  func testExpressibleAsSimpleTypeIdentifier() {
    let testCases: [UInt: (ExpressibleAsSimpleTypeIdentifier, String)] = [
      #line: (SimpleTypeIdentifier(name: .identifier("Foo")), "Foo"),
      #line: (SimpleTypeIdentifier("Foo"), "Foo"),
      #line: ("Foo", "Foo")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let identifier = builder.createSimpleTypeIdentifier()
      let syntax = identifier.buildSyntax()

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
