//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
@_spi(RawSyntax) import SwiftSyntax

fileprivate func cannedStructDecl(arena: SyntaxArena) -> RawStructDeclSyntax {
  let structKW = RawTokenSyntax(
    kind: .keyword(.struct),
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
  let members = RawMemberDeclBlockSyntax(
    leftBrace: lBrace,
    members: RawMemberDeclListSyntax(elements: [], arena: arena),
    rightBrace: rBrace,
    arena: arena
  )
  return RawStructDeclSyntax(
    attributes: nil,
    modifiers: nil,
    structKeyword: structKW,
    identifier: fooID,
    genericParameterClause: nil,
    inheritanceClause: nil,
    genericWhereClause: nil,
    members: members,
    arena: arena
  )
}

final class RawSyntaxTests: XCTestCase {

  func testFactory() {
    withExtendedLifetime(SyntaxArena()) { arena in
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

  func testMaterializedToken() {
    withExtendedLifetime(SyntaxArena()) { arena in
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
    // Dummy trivia parsing function.
    func dummyParseToken(source: SyntaxText, position: TriviaPosition) -> [RawTriviaPiece] {
      // Emit a single `unexpectedText` trivia of the whole trivia text.
      return [.unexpectedText(source)]
    }

    withExtendedLifetime(ParsingSyntaxArena(parseTriviaFunction: dummyParseToken)) { arena in
      let ident = RawTokenSyntax(
        kind: .identifier,
        wholeText: arena.intern("\nfoo "),
        textRange: 1..<4,
        presence: .present,
        lexerError: nil,
        arena: arena
      )

      XCTAssertEqual(ident.tokenKind, .identifier)
      XCTAssertEqual(ident.tokenText, "foo")
      XCTAssertEqual(ident.presence, .present)
      XCTAssertEqual(ident.leadingTriviaPieces, [.unexpectedText("\n")])
      XCTAssertEqual(ident.trailingTriviaPieces, [.unexpectedText(" ")])
      XCTAssertEqual(ident.description, "\nfoo ")

      let identSyntax = Syntax(raw: ident.raw).as(TokenSyntax.self)!
      let barIdentSyntax = identSyntax.withKind(.keyword(.open))
      let barIdent = barIdentSyntax.raw.as(RawTokenSyntax.self)!

      XCTAssertEqual(barIdent.tokenKind, .keyword(.open))
      XCTAssertEqual(barIdent.tokenText, "open")
      XCTAssertEqual(barIdent.leadingTriviaPieces, [.unexpectedText("\n")])
      XCTAssertEqual(barIdent.trailingTriviaPieces, [.unexpectedText(" ")])
      XCTAssertEqual(barIdent.description, "\nopen ")
    }
  }

  func testExtendingTrivia() {
    // We are only testing materialized token here because parsed token should
    // be covered pretty well in the parser. Materialized tokens are less common
    // and need dedicated testing.
    withExtendedLifetime(SyntaxArena()) { arena in
      let baseToken = RawTokenSyntax(
        kind: .identifier,
        text: "hello",
        leadingTriviaPieces: [.spaces(2), .unexpectedText("a")],
        trailingTriviaPieces: [.tabs(3), .unexpectedText("b"), .tabs(1)],
        presence: .present,
        arena: arena
      )

      let extendedLeading = baseToken.extendingLeadingTrivia(by: [.newlines(4)], arena: arena)
      XCTAssertEqual(extendedLeading.tokenKind, .identifier)
      XCTAssertEqual(extendedLeading.tokenText, "hello")
      XCTAssertEqual(extendedLeading.leadingTriviaPieces, [.newlines(4), .spaces(2), .unexpectedText("a")])
      XCTAssertEqual(extendedLeading.trailingTriviaPieces, [.tabs(3), .unexpectedText("b"), .tabs(1)])
      XCTAssertEqual(extendedLeading.presence, .present)
      XCTAssertEqual(extendedLeading.byteLength, baseToken.byteLength + 4)

      let extendedTrailing = baseToken.extendingTrailingTrivia(by: [.newlines(4)], arena: arena)
      XCTAssertEqual(extendedTrailing.tokenKind, .identifier)
      XCTAssertEqual(extendedTrailing.tokenText, "hello")
      XCTAssertEqual(extendedTrailing.leadingTriviaPieces, [.spaces(2), .unexpectedText("a")])
      XCTAssertEqual(extendedTrailing.trailingTriviaPieces, [.tabs(3), .unexpectedText("b"), .tabs(1), .newlines(4)])
      XCTAssertEqual(extendedTrailing.presence, .present)
      XCTAssertEqual(extendedTrailing.byteLength, baseToken.byteLength + 4)
    }
  }

  func testReclassifyingAsTrivia() {
    // We are only testing materialized token here because parsed token should
    // be covered pretty well in the parser. Materialized tokens are less common
    // and need dedicated testing.
    withExtendedLifetime(SyntaxArena()) { arena in
      let baseToken = RawTokenSyntax(
        kind: .identifier,
        text: "  hello\r\n",
        leadingTriviaPieces: [.spaces(2), .unexpectedText("a")],
        trailingTriviaPieces: [.tabs(3), .unexpectedText("b"), .tabs(1)],
        presence: .present,
        arena: arena
      )

      let reclassifiedLeading = baseToken.reclassifyAsLeadingTrivia([.spaces(2)], arena: arena)
      XCTAssertEqual(reclassifiedLeading.tokenKind, .identifier)
      XCTAssertEqual(reclassifiedLeading.tokenText, "hello\r\n")
      XCTAssertEqual(reclassifiedLeading.leadingTriviaPieces, [.spaces(2), .unexpectedText("a"), .spaces(2)])
      XCTAssertEqual(reclassifiedLeading.trailingTriviaPieces, [.tabs(3), .unexpectedText("b"), .tabs(1)])
      XCTAssertEqual(reclassifiedLeading.presence, .present)

      let reclassifiedTrailing = baseToken.reclassifyAsTrailingTrivia([.carriageReturnLineFeeds(1)], arena: arena)
      XCTAssertEqual(reclassifiedTrailing.tokenKind, .identifier)
      XCTAssertEqual(reclassifiedTrailing.tokenText, "  hello")
      XCTAssertEqual(reclassifiedTrailing.leadingTriviaPieces, [.spaces(2), .unexpectedText("a")])
      XCTAssertEqual(reclassifiedTrailing.trailingTriviaPieces, [.carriageReturnLineFeeds(1), .tabs(3), .unexpectedText("b"), .tabs(1)])
      XCTAssertEqual(reclassifiedTrailing.presence, .present)
    }
  }
}
