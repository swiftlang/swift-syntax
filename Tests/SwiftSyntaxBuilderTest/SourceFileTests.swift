import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class SourceFileTests: XCTestCase {
  func testSourceFile() {
    let leadingTrivia = Trivia.garbageText("␣")

    let sourceFile = SourceFile {
      Import("SwiftSyntax")

      Struct("ExampleStruct") {
        Let("syntax", of: "Syntax")
      }
    }

    let syntax = sourceFile.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)
    XCTAssertEqual(text, """
    ␣import SwiftSyntax
    struct ExampleStruct {
        let syntax: Syntax
    }
    """)
  }
}
