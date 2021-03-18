import XCTest
import SwiftSyntax

import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let members = MemberDeclBlock(leftBrace: SyntaxFactory.makeLeftBraceToken().withLeadingTrivia(.spaces(1)),
                                  members: MemberDeclList([]),
                                  rightBrace: SyntaxFactory.makeRightBraceToken())
    let buildable = StructDecl(attributes: nil,
                               modifiers: nil,
                               structKeyword: SyntaxFactory.makeStructKeyword(),
                               identifier: SyntaxFactory.makeIdentifier("TestStruct").withLeadingTrivia(.spaces(1)),
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
    let leftBrace = SyntaxFactory.makeLeftBraceToken().withLeadingTrivia(.spaces(1))
    let rightBrace = SyntaxFactory.makeRightBraceToken().withLeadingTrivia(.spaces(1))
    let structKeyword = SyntaxFactory.makeStructKeyword()
    let emptyMembers = MemberDeclBlock(leftBrace: leftBrace,
                                  members: MemberDeclList([]),
                                  rightBrace: rightBrace)
    let nestedStruct = StructDecl(attributes: nil,
                               modifiers: nil,
                               structKeyword: structKeyword,
                               identifier: SyntaxFactory.makeIdentifier("NestedStruct").withLeadingTrivia(.spaces(1)),
                               genericParameterClause: nil,
                               inheritanceClause: nil,
                               genericWhereClause: nil,
                               members: emptyMembers)
    let members = MemberDeclBlock(leftBrace: leftBrace,
                                  members: MemberDeclList([MemberDeclListItem(decl: nestedStruct, semicolon: nil)]),
                                  rightBrace: rightBrace)
    let testStruct = StructDecl(attributes: nil,
                               modifiers: nil,
                               structKeyword: structKeyword,
                               identifier: SyntaxFactory.makeIdentifier("TestStruct").withLeadingTrivia(.spaces(1)),
                               genericParameterClause: nil,
                               inheritanceClause: nil,
                               genericWhereClause: nil,
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
