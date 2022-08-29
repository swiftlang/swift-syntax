import XCTest
@_spi(RawSyntax) import SwiftSyntax

fileprivate func cannedStructDecl(arena: SyntaxArena) -> RawStructDeclSyntax {
  let structKW = RawTokenSyntax(
    kind: .structKeyword, text: arena.intern("struct"),
    leadingTriviaPieces: [], trailingTriviaPieces: [.spaces(1)],
    presence: .present,
    arena: arena)
  let fooID = RawTokenSyntax(
    kind: .identifier, text: arena.intern("Foo"),
    leadingTriviaPieces: [], trailingTriviaPieces: [.spaces(1)],
    presence: .present,
    arena: arena)
  let lBrace = RawTokenSyntax(
    kind: .leftBrace, text: arena.intern("{"),
    leadingTriviaPieces: [], trailingTriviaPieces: [],
    presence: .present,
    arena: arena)
  let rBrace = RawTokenSyntax(
    kind: .leftBrace, text: arena.intern("}"),
    leadingTriviaPieces: [.newlines(1)], trailingTriviaPieces: [],
    presence: .present,
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
        presence: .present,
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

  func testParsedToken() throws {
    // Dummy trivia parsing function.
    func dummyParseToken(source: SyntaxText, position: TriviaPosition) -> [RawTriviaPiece] {
      // Emit a single `unexpectedText` trivia of the whole trivia text.
      return [.unexpectedText(source)]
    }

    withExtendedLifetime(SyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let ident = RawTokenSyntax(
        kind: .identifier, wholeText: arena.intern("\nfoo "), textRange: 1..<4,
        presence: .present,
        arena: arena)

      XCTAssertEqual(ident.tokenKind, .identifier)
      XCTAssertEqual(ident.tokenText, "foo")
      XCTAssertEqual(ident.presence, .present)
      XCTAssertEqual(ident.leadingTriviaPieces, [.unexpectedText("\n")])
      XCTAssertEqual(ident.trailingTriviaPieces, [.unexpectedText(" ")])
      XCTAssertEqual(ident.description, "\nfoo ")

      let identSyntax = Syntax(raw: ident.raw).as(TokenSyntax.self)!
      let barIdentSyntax = identSyntax.withKind(.contextualKeyword("open"))
      let barIdent = barIdentSyntax.raw.as(RawTokenSyntax.self)!

      XCTAssertEqual(barIdent.tokenKind, .contextualKeyword)
      XCTAssertEqual(barIdent.tokenText, "open")
      XCTAssertEqual(barIdent.leadingTriviaPieces, [.unexpectedText("\n")])
      XCTAssertEqual(barIdent.trailingTriviaPieces, [.unexpectedText(" ")])
      XCTAssertEqual(barIdent.description, "\nopen ")
    }
  }
}
