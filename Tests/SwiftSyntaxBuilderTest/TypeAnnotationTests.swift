import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TypeAnnotationTests: XCTestCase {
  func testStringLiteral() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (TypeAnnotation, String)] = [
      #line: (TypeAnnotation(type: SimpleTypeIdentifier("Test")), "␣: Test"),
      #line: (TypeAnnotation(stringLiteral: "Test"), "␣: Test"),
      #line: (TypeAnnotation("Test"), "␣: Test"),
      #line: ("Test", "␣: Test")
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
