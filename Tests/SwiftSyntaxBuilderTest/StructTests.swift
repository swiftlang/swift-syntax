import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = Struct("TestStruct")
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct {
    }
    """)
  }

  func testStructWithMember() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = Struct("TestStruct") {
      Let("member", of: "String")
    }
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct {
        let member: String
    }
    """)
  }

  func testNestedStruct() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = Struct("TestStruct") {
      Struct("NestedStruct") {
          Let("member", of: "String")
      }
    }
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct {
        struct NestedStruct {
            let member: String
        }
    }
    """)
  }

  func testStructWithIndent() {
    let format = Format()._indented()

    let buildable = Struct("TestStruct") {
      Let("member", of: "String")
    }
    let syntax = buildable.buildSyntax(format: format, leadingTrivia: format._makeIndent())

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
        struct TestStruct {
            let member: String
        }
    """)
  }
}
