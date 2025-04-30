//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#if compiler(>=6)
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) internal import SwiftSyntax
#else
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
#endif

extension Parser {
  /// Parse an argument for `-define-availability` compiler option.
  mutating func parseAvailabilityMacroDefinitionFile() -> RawAvailabilityMacroDefinitionFileSyntax {
    let namedAndVersion = self.parsePlatformVersion(allowStarAsVersionNumber: false)
    let (unexpectedBetweenPlatformVersionAndColon, colon) = self.expect(.colon)
    let specs = self.parseAvailabilitySpecList()
    let (unexpectedBeforeEndOfFileToken, endOfFile) = self.expectEndOfFile()

    return RawAvailabilityMacroDefinitionFileSyntax(
      platformVersion: namedAndVersion,
      unexpectedBetweenPlatformVersionAndColon,
      colon: colon,
      specs: specs,
      unexpectedBeforeEndOfFileToken,
      endOfFileToken: endOfFile,
      arena: self.arena
    )
  }

  /// Parse an `accessor` macro expansion.
  mutating func parseAccessorBlockFile() -> RawAccessorBlockFileSyntax {
    let leftBrace = self.consume(if: .leftBrace)
    let accessors = self.parseAccessorList()
    let unexpectedBeforeRightBrace: RawUnexpectedNodesSyntax?
    let rightBrace: RawTokenSyntax?
    if leftBrace != nil {
      (unexpectedBeforeRightBrace, rightBrace) = self.expect(.rightBrace)
    } else {
      (unexpectedBeforeRightBrace, rightBrace) = (nil, nil)
    }
    let (unexpectedBeforeEndOfFileToken, endOfFile) = self.expectEndOfFile()

    return RawAccessorBlockFileSyntax(
      leftBrace: leftBrace,
      accessors: accessors ?? RawAccessorDeclListSyntax(elements: [], arena: self.arena),
      unexpectedBeforeRightBrace,
      rightBrace: rightBrace,
      unexpectedBeforeEndOfFileToken,
      endOfFileToken: endOfFile,
      arena: self.arena
    )
  }

  /// Parse a `memberAttribute` macro expansion, or `swift_attr` clang attribute.
  mutating func parseAttributeClauseFile() -> RawAttributeClauseFileSyntax {
    let attributes = self.parseAttributeList()
    let modifiers = self.parseDeclModifierList()
    let (unexpectedBeforeEndOfFileToken, endOfFile) = self.expectEndOfFile()

    return RawAttributeClauseFileSyntax(
      attributes: attributes,
      modifiers: modifiers,
      unexpectedBeforeEndOfFileToken,
      endOfFileToken: endOfFile,
      arena: self.arena
    )
  }

  /// Parse a 'body' macro expansion.
  mutating func parseCodeBlockFile() -> RawCodeBlockFileSyntax {
    let body = self.parseCodeBlock()
    let (unexpectedBeforeEndOfFileToken, endOfFile) = self.expectEndOfFile()

    return RawCodeBlockFileSyntax(
      body: body,
      unexpectedBeforeEndOfFileToken,
      endOfFileToken: endOfFile,
      arena: self.arena
    )
  }

  /// Parse a declaration macro expansions in type contexts.
  mutating func parseMemberBlockItemListFile() -> RawMemberBlockItemListFileSyntax {
    let members = self.parseMemberDeclList()
    let (unexpectedBeforeEndOfFileToken, endOfFile) = self.expectEndOfFile()

    return RawMemberBlockItemListFileSyntax(
      members: members,
      unexpectedBeforeEndOfFileToken,
      endOfFileToken: endOfFile,
      arena: self.arena
    )
  }
}
