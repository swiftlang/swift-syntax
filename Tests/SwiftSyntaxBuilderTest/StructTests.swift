import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let members = MemberDeclBlock(leftBrace: Tokens.leftBrace.withLeadingTrivia(.spaces(1)),
                                  members: MemberDeclList([]),
                                  rightBrace: Tokens.rightBrace)
    let buildable = StructDecl(attributes: nil,
                               modifiers: nil,
                               structKeyword: Tokens.struct,
                               identifier: SyntaxFactory.makeIdentifier("TestStruct"),
                               genericParameterClause: nil,
                               inheritanceClause: nil,
                               genericWhereClause: nil,
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
    let structKeyword = SyntaxFactory.makeStructKeyword()
    let emptyMembers = MemberDeclBlock(leftBrace: Tokens.leftBrace.withLeadingTrivia(.spaces(1)),
                                  members: MemberDeclList([]),
                                  rightBrace: Tokens.rightBrace)
    let nestedStruct = StructDecl(structKeyword: structKeyword,
                               identifier: SyntaxFactory.makeIdentifier("NestedStruct").withLeadingTrivia(.spaces(1)),
                               members: emptyMembers)
    let members = MemberDeclBlock(leftBrace: Tokens.leftBrace.withLeadingTrivia(.spaces(1)),
                                  members: MemberDeclList([MemberDeclListItem(decl: nestedStruct)]),
                                  rightBrace: Tokens.rightBrace)
    let testStruct = StructDecl(structKeyword: structKeyword,
                               identifier: SyntaxFactory.makeIdentifier("TestStruct").withLeadingTrivia(.spaces(1)),
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
}
