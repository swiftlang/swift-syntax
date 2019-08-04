import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class ImportTests: XCTestCase {
  func testImport() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (Import, String)] = [
      #line: (Import("SwiftSyntax"),
              "␣import SwiftSyntax"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let syntax = builder.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
