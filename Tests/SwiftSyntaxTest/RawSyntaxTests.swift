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

fileprivate func cannedStructDecl(arena: ParsingSyntaxArena) -> RawStructDeclSyntax {
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
  let memberBlock = RawMemberBlockSyntax(
    leftBrace: lBrace,
    members: RawMemberBlockItemListSyntax(elements: [], arena: arena),
    rightBrace: rBrace,
    arena: arena
  )
  return RawStructDeclSyntax(
    attributes: RawAttributeListSyntax(elements: [], arena: arena),
    modifiers: RawDeclModifierListSyntax(elements: [], arena: arena),
    structKeyword: structKW,
    name: fooID,
    genericParameterClause: nil,
    inheritanceClause: nil,
    genericWhereClause: nil,
    memberBlock: memberBlock,
    arena: arena
  )
}

final class RawSyntaxTests: XCTestCase {

  func testFactory() {
    withExtendedLifetime(ParsingSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let structDecl = cannedStructDecl(arena: arena)
      XCTAssertEqual(
        "\(structDecl.raw)",
        """
        struct Foo {
        }
        """
      )
    }
  }

  func testAccessor() {
    withExtendedLifetime(ParsingSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let structDecl = cannedStructDecl(arena: arena)
      XCTAssertEqual(structDecl.name.tokenKind, .identifier)
      XCTAssertEqual(structDecl.structKeyword.tokenText, "struct")
      XCTAssertEqual(structDecl.memberBlock.leftBrace.tokenText, "{")
      XCTAssertEqual(structDecl.memberBlock.members.elements.count, 0)

      XCTAssert(structDecl.is(RawDeclSyntax.self))
      XCTAssertNotNil(structDecl.as(RawDeclSyntax.self))
      XCTAssertNil(structDecl.as(RawClassDeclSyntax.self))
      XCTAssertFalse(structDecl.is(RawTypeSyntax.self))
    }
  }

  func testMaterializedToken() {
    withExtendedLifetime(ParsingSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
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
      XCTAssertEqual(ident.description, "foo")

      let missingIdent = RawTokenSyntax(missing: .identifier, arena: arena)
      XCTAssertEqual(missingIdent.presence, .missing)
      XCTAssertEqual(missingIdent.tokenText, "")
      XCTAssertEqual(missingIdent.description, "")
    }
  }

  func testParsedToken() {
    withExtendedLifetime(ParsingSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
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
      XCTAssertEqual(ident.description, "\nfoo ")

      let identSyntax = Syntax(raw: ident.raw, rawNodeArena: arena).as(TokenSyntax.self)!
      let barIdentSyntax = identSyntax.with(\.tokenKind, .keyword(.open))
      let barIdent = barIdentSyntax.raw.as(RawTokenSyntax.self)!

      XCTAssertEqual(barIdent.tokenKind, .keyword)
      XCTAssertEqual(barIdent.tokenText, "open")
      XCTAssertEqual(barIdent.leadingTriviaPieces, [.unexpectedText("\n")])
      XCTAssertEqual(barIdent.trailingTriviaPieces, [.unexpectedText(" ")])
      XCTAssertEqual(barIdent.description, "\nopen ")
    }
  }
}
