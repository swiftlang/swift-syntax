import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class ExtensionTests: XCTestCase {
  func testEmptyExtension() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = Extension("TestExtension")
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣extension TestExtension {
    }
    """)
  }

  func testExtensionWithMember() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = Extension("TestExtension") {
      Struct("TestStruct")
    }
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣extension TestExtension {
        struct TestStruct {
        }
    }
    """)
  }

  func testExtensionWithIndent() {
    let format = Format()._indented()

    let buildable = Extension("TestExtension") {
        Struct("TestStruct")
    }
    let syntax = buildable.buildSyntax(format: format, leadingTrivia: format._makeIndent())

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
        extension TestExtension {
            struct TestStruct {
            }
        }
    """)
  }
}
