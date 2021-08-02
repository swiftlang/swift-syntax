import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let members = MemberDeclBlock(members: MemberDeclList([]))
    let buildable = StructDecl(identifier: "TestStruct",
                               members: members)
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct{
    }
    """)
  }

  func testNestedStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let emptyMembers = MemberDeclBlock(members: MemberDeclList([]))
    let nestedStruct = StructDecl(structKeyword: .struct.withLeadingTrivia(.docLineComment("/// A nested struct\n")),
                                  identifier: "NestedStruct",
                                  members: emptyMembers)
    let members = MemberDeclBlock(members: MemberDeclList([MemberDeclListItem(decl: nestedStruct)]))
    let testStruct = StructDecl(identifier: "TestStruct",
                                members: members)
    let syntax = testStruct.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    // FIXME: We should indent the nested struct by adding the indentation after every newline in the leading trivia.
    XCTAssertEqual(text, """
    ␣struct TestStruct{
        /// A nested struct
    struct NestedStruct{
        }
    }
    """)
  }
}
