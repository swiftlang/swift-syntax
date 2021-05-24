import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let members = MemberDeclBlock(leftBrace: Tokens.leftBrace.withLeadingTrivia(.spaces(1)),
                                  members: MemberDeclList([]),
                                  rightBrace: Tokens.rightBrace)
    let buildable = StructDecl(structKeyword: Tokens.struct,
                               identifier: SyntaxFactory.makeIdentifier("TestStruct"),
                               members: members)
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct {
    }
    """)
  }

  func testNestedStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let emptyMembers = MemberDeclBlock(leftBrace: Tokens.leftBrace.withLeadingTrivia(.spaces(1)),
                                  members: MemberDeclList([]),
                                  rightBrace: Tokens.rightBrace)
    let nestedStruct = StructDecl(structKeyword: Tokens.struct,
                               identifier: SyntaxFactory.makeIdentifier("NestedStruct"),
                               members: emptyMembers)
    let members = MemberDeclBlock(leftBrace: Tokens.leftBrace.withLeadingTrivia(.spaces(1)),
                                  members: MemberDeclList([MemberDeclListItem(decl: nestedStruct)]),
                                  rightBrace: Tokens.rightBrace)
    let testStruct = StructDecl(structKeyword: Tokens.struct,
                                identifier: SyntaxFactory.makeIdentifier("TestStruct"),
                                members: members)
    let syntax = testStruct.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct {
        struct NestedStruct {
        }
    }
    """)
  }

  func testEmptyStructWithBuilder() {
    let leadingTrivia = Trivia.garbageText("␣")
    let test = StructDecl(identifier: "TestStruct", members: MemberDeclBlock())

    let syntax = test.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct{
    }
    """)
  }

  func testNestedStructWithBuilder() {
    let leadingTrivia = Trivia.garbageText("␣")
    let memberDeclBlock = MemberDeclBlock {
      MemberDeclListItem(decl: StructDecl(identifier: "NestedStruct", members: MemberDeclBlock()))
    }
    let test = StructDecl(identifier: "TestStruct", members: memberDeclBlock)
    let syntax = test.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct{
        struct NestedStruct{
        }
    }
    """)
  }
}
