import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class VariableTests: XCTestCase {
  func testLet() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (Let, String)] = [
      #line: (Let("str", of: "String"),
              #"␣let str: String"#),
      #line: (Let("str", of: "String", value: StringLiteral("asdf")),
              #"␣let str: String = "asdf""#),
      #line: (Let("num", of: "Int", value: IntegerLiteral(123)),
              #"␣let num: Int = 123"#),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let syntax = builder.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      var text = ""
      syntax.write(to: &text)

      XCTAssertEqual(text, expected, line: line)
    }
  }

  func testVar() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (Var, String)] = [
      #line: (Var("str", of: "String"),
              #"␣var str: String"#),
      #line: (Var("str", of: "String", value: StringLiteral("asdf")),
              #"␣var str: String = "asdf""#),
      #line: (Var("num", of: "Int", value: IntegerLiteral(123)),
              #"␣var num: Int = 123"#),
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
