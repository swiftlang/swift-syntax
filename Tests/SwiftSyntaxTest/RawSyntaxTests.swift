//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) import SwiftSyntax
import XCTest

private func cannedStructDecl(arena: ParsingRawSyntaxArena) -> RawSyntax {
  let structKW = RawTokenSyntax(
    kind: .keyword,
    text: arena.intern("struct"),
    leadingTriviaPieces: [],
    trailingTriviaPieces: [.spaces(1)],
    presence: .present,
    arena: arena
  )
  let fooID = RawTokenSyntax(
    kind: .identifier,
    text: arena.intern("Foo"),
    leadingTriviaPieces: [],
    trailingTriviaPieces: [.spaces(1)],
    presence: .present,
    arena: arena
  )
  let lBrace = RawTokenSyntax(
    kind: .leftBrace,
    text: arena.intern("{"),
    leadingTriviaPieces: [],
    trailingTriviaPieces: [],
    presence: .present,
    arena: arena
  )
  let rBrace = RawTokenSyntax(
    kind: .rightBrace,
    text: arena.intern("}"),
    leadingTriviaPieces: [.newlines(1)],
    trailingTriviaPieces: [],
    presence: .present,
    arena: arena
  )
  func emptyCollection(_ kind: SyntaxKind) -> RawSyntax {
    return RawSyntax.makeCollection(kind: kind, count: 0, arena: arena) { _ in }
  }
  let memberBlock = RawSyntax.makeMemberBlock(
    nil,
    leftBrace: lBrace.raw,
    nil,
    members: emptyCollection(.memberBlockItemList),
    nil,
    rightBrace: rBrace.raw,
    nil,
    arena: arena
  )
  return RawSyntax.makeStructDecl(
    nil,
    attributes: emptyCollection(.attributeList),
    nil,
    modifiers: emptyCollection(.declModifierList),
    nil,
    structKeyword: structKW.raw,
    nil,
    name: fooID.raw,
    nil,
    genericParameterClause: nil,
    nil,
    inheritanceClause: nil,
    nil,
    genericWhereClause: nil,
    nil,
    memberBlock: memberBlock,
    nil,
    arena: arena
  )
}

final class RawSyntaxTests: XCTestCase {

  func testFactory() {
    withExtendedLifetime(ParsingRawSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let structDecl = cannedStructDecl(arena: arena)
      XCTAssertEqual(
        "\(structDecl)",
        """
        struct Foo {
        }
        """
      )
    }
  }

  func testAccessor() {
    withExtendedLifetime(ParsingRawSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let node = Syntax(raw: cannedStructDecl(arena: arena), rawNodeArena: arena)
      let structDecl = node.cast(StructDeclSyntax.self)
      XCTAssertEqual(structDecl.name.tokenKind, .identifier("Foo"))
      XCTAssertEqual(structDecl.structKeyword.text, "struct")
      XCTAssertEqual(structDecl.memberBlock.leftBrace.text, "{")
      XCTAssertEqual(structDecl.memberBlock.members.count, 0)

      XCTAssert(node.is(DeclSyntax.self))
      XCTAssertNotNil(node.as(DeclSyntax.self))
      XCTAssertNil(node.as(ClassDeclSyntax.self))
      XCTAssertFalse(node.is(TypeSyntax.self))
    }
  }

  func testMaterializedToken() {
    withExtendedLifetime(ParsingRawSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let ident = RawTokenSyntax(
        kind: .identifier,
        text: arena.intern("foo"),
        leadingTriviaPieces: [],
        trailingTriviaPieces: [],
        presence: .present,
        arena: arena
      )
      XCTAssertEqual(ident.tokenKind, .identifier)
      XCTAssertEqual(ident.tokenText, "foo")
      XCTAssertEqual(ident.presence, .present)
      XCTAssertEqual(ident.raw.description, "foo")

      let missingIdent = RawTokenSyntax(missing: .identifier, arena: arena)
      XCTAssertEqual(missingIdent.presence, .missing)
      XCTAssertEqual(missingIdent.tokenText, "")
      XCTAssertEqual(missingIdent.raw.description, "")
    }
  }

  func testMaterializedTokenWithKind() {
    let privateKeyword = TokenSyntax.keyword(.private, trailingTrivia: .space)
    let fileprivateKeyword = privateKeyword.with(\.tokenKind, .keyword(.fileprivate))

    XCTAssertEqual(fileprivateKeyword.tokenKind, .keyword(.fileprivate))
    XCTAssertEqual(fileprivateKeyword.description, "fileprivate ")
    XCTAssertEqual(fileprivateKeyword.totalLength, SourceLength(utf8Length: 12))
    XCTAssertEqual(fileprivateKeyword.syntaxTextBytes, Array("fileprivate ".utf8))
  }

  func testParsedToken() {
    withExtendedLifetime(ParsingRawSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let ident = RawTokenSyntax(
        kind: .identifier,
        wholeText: arena.intern("\nfoo "),
        textRange: 1..<4,
        presence: .present,
        tokenDiagnostic: nil,
        arena: arena
      )

      XCTAssertEqual(ident.tokenKind, .identifier)
      XCTAssertEqual(ident.tokenText, "foo")
      XCTAssertEqual(ident.presence, .present)
      XCTAssertEqual(ident.leadingTriviaPieces, [.unexpectedText("\n")])
      XCTAssertEqual(ident.trailingTriviaPieces, [.unexpectedText(" ")])
      XCTAssertEqual(ident.raw.description, "\nfoo ")

      let identSyntax = Syntax(raw: ident.raw, rawNodeArena: arena).as(TokenSyntax.self)!
      let barIdentSyntax = identSyntax.with(\.tokenKind, .keyword(.open))
      let barIdent = RawTokenSyntax(raw: barIdentSyntax.raw)

      XCTAssertEqual(barIdent.tokenKind, .keyword)
      XCTAssertEqual(barIdent.tokenText, "open")
      XCTAssertEqual(barIdent.leadingTriviaPieces, [.unexpectedText("\n")])
      XCTAssertEqual(barIdent.trailingTriviaPieces, [.unexpectedText(" ")])
      XCTAssertEqual(barIdent.raw.description, "\nopen ")
    }
  }
}
