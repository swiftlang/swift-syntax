import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class TypeAnnotationTests: XCTestCase {
  func testStringLiteral() {
    let testCases: [UInt: (ExpressibleAsTypeAnnotation, String)] = [
      #line: (TypeAnnotation(type: "Test"), ": Test"),
      #line: (TypeAnnotation(type: SimpleTypeIdentifier("Test")), ": Test"),
      #line: (TypeAnnotation("Test"), ": Test"),
      #line: (SimpleTypeIdentifier("Test"), ": Test"),
      #line: ("Test", ": Test")
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let typeAnnotation = builder.createTypeAnnotation()
      let syntax = typeAnnotation.buildSyntax()

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
