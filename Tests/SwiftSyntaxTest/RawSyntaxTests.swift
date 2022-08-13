import XCTest
@_spi(RawSyntax) import SwiftSyntax

fileprivate func cannedStructDecl(arena: SyntaxArena) -> RawStructDeclSyntax {
  let structKW = RawTokenSyntax(
    kind: .structKeyword, text: arena.intern("struct"),
    leadingTriviaPieces: [], trailingTriviaPieces: [.spaces(1)],
    arena: arena)
  let fooID = RawTokenSyntax(
    kind: .identifier, text: arena.intern("Foo"),
    leadingTriviaPieces: [], trailingTriviaPieces: [.spaces(1)],
    arena: arena)
  let lBrace = RawTokenSyntax(
    kind: .leftBrace, text: arena.intern("{"),
    leadingTriviaPieces: [], trailingTriviaPieces: [],
    arena: arena)
  let rBrace = RawTokenSyntax(
    kind: .leftBrace, text: arena.intern("}"),
    leadingTriviaPieces: [.newlines(1)], trailingTriviaPieces: [],
    arena: arena)
  let members = RawMemberDeclBlockSyntax(
    leftBrace: lBrace,
    members: RawMemberDeclListSyntax(elements: [], arena: arena),
    rightBrace: rBrace,
    arena: arena)
  return RawStructDeclSyntax(
    attributes: nil,
    modifiers: nil,
    structKeyword: structKW,
    identifier: fooID,
    genericParameterClause: nil,
    inheritanceClause: nil,
    genericWhereClause: nil,
    members: members, arena: arena)
}

final class RawSyntaxTests: XCTestCase {

  func testFactory() throws {
    withExtendedLifetime(SyntaxArena()) { arena in
      let structDecl = cannedStructDecl(arena: arena)
      XCTAssertEqual("\(structDecl.raw)",
                       """
                       struct Foo {
                       }
                       """)
    }
  }

  func testAccessor() throws {
    withExtendedLifetime(SyntaxArena()) { arena in
      let structDecl = cannedStructDecl(arena: arena)
      XCTAssertEqual(structDecl.identifier.tokenKind, .identifier)
      XCTAssertEqual(structDecl.structKeyword.tokenText, "struct")
      XCTAssertEqual(structDecl.members.leftBrace.tokenText, "{")
      XCTAssertEqual(structDecl.members.members.elements.count, 0)

      XCTAssert(structDecl.is(RawDeclSyntax.self))
      XCTAssertNotNil(structDecl.as(RawDeclSyntax.self))
      XCTAssertNil(structDecl.as(RawClassDeclSyntax.self))
      XCTAssertFalse(structDecl.is(RawTypeSyntax.self))
    }
  }

  func testMaterializedToken() throws {
    withExtendedLifetime(SyntaxArena()) { arena in
      let ident = RawTokenSyntax(
        kind: .identifier, text: arena.intern("foo"),
        leadingTriviaPieces: [], trailingTriviaPieces: [],
        arena: arena)
      XCTAssertEqual(ident.tokenKind, .identifier)
      XCTAssertEqual(ident.tokenText, "foo")
      XCTAssertEqual(ident.presence, .present)
      XCTAssertEqual(ident.description, "foo")

      let missingIdent = RawTokenSyntax(missing: .identifier, arena: arena)
      XCTAssertEqual(missingIdent.presence, .missing)
      XCTAssertEqual(missingIdent.tokenText, "")
      XCTAssertEqual(missingIdent.description, "")
    }
  }


}
