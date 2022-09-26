import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class CustomAttributeTests: XCTestCase {
  func testCustomAttributeConvenienceInitializer() {
    let testCases: [UInt: (CustomAttribute, String)] = [
      #line: (CustomAttribute("Test"), "@Test"),
      #line: (CustomAttribute("WithParens") {}, "@WithParens()"),
      #line: (CustomAttribute("WithArgs") {
        TupleExprElement(expression: "value1")
        TupleExprElement(label: "labelled", expression: "value2")
      }, "@WithArgs(value1, labelled: value2)"),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let syntax = builder.buildSyntax()

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }
}
