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

extension RawSyntax {
  /// A view into the ``RawSyntax`` that exposes functionality that's specific to tokens.
  /// The token's payload must be a token, otherwise this traps.
  @_spi(RawSyntax)
  public var tokenView: RawSyntaxTokenView? {
    switch header {
    case .parsedToken, .materializedToken:
      return RawSyntaxTokenView(raw: self)
    case .layout:
      return nil
    }
  }
}

/// A view into ``RawSyntax`` that exposes functionality that only applies to tokens.
@_spi(RawSyntax)
public struct RawSyntaxTokenView: Sendable {
  let raw: RawSyntax

  fileprivate init(raw: RawSyntax) {
    self.raw = raw
    switch raw.header {
    case .parsedToken, .materializedToken:
      break
    case .layout:
      preconditionFailure("RawSyntax must be a token")
    }
  }

  /// Token kind of this node.
  @_spi(RawSyntax)
  public var rawKind: RawTokenKind {
    switch raw.header {
    case .materializedToken:
      return raw.asMaterializedToken.tokenKind
    case .parsedToken:
      return raw.asParsedToken.tokenKind
    case .layout:
      preconditionFailure("'tokenKind' is not available for non-token node")
    }
  }

  /// Token text of this node.
  @_spi(RawSyntax)
  public var rawText: SyntaxText {
    switch raw.header {
    case .parsedToken:
      return raw.asParsedToken.tokenText
    case .materializedToken:
      return raw.asMaterializedToken.tokenText
    case .layout:
      preconditionFailure("'rawText' is not available for non-token node")
    }
  }

  /// The UTF-8 byte length of the leading trivia.
  @_spi(RawSyntax)
  public var leadingTriviaByteLength: Int {
    switch raw.header {
    case .parsedToken:
      return raw.asParsedToken.leadingTriviaText.count
    case .materializedToken:
      return raw.asMaterializedToken.leadingTrivia.reduce(0) { $0 + $1.byteLength }
    case .layout:
      preconditionFailure("'leadingTriviaByteLength' is not available for non-token node")
    }
  }

  /// The UTF-8 byte length of the trailing trivia.
  @_spi(RawSyntax)
  public var trailingTriviaByteLength: Int {
    switch raw.header {
    case .parsedToken:
      return raw.asParsedToken.trailingTriviaText.count
    case .materializedToken:
      return raw.asMaterializedToken.trailingTrivia.reduce(0) { $0 + $1.byteLength }
    case .layout:
      preconditionFailure("'trailingTriviaByteLength' is not available for non-token node")
    }
  }

  @_spi(RawSyntax)
  public var leadingRawTriviaPieces: [RawTriviaPiece] {
    switch raw.header {
    case .parsedToken:
      return raw.arenaReference.parseTrivia(source: raw.asParsedToken.leadingTriviaText, position: .leading)
    case .materializedToken:
      return Array(raw.asMaterializedToken.leadingTrivia)
    case .layout:
      preconditionFailure("'leadingRawTriviaPieces' is called on non-token raw syntax")
    }
  }

  @_spi(RawSyntax)
  public var trailingRawTriviaPieces: [RawTriviaPiece] {
    switch raw.header {
    case .parsedToken:
      return raw.arenaReference.parseTrivia(source: raw.asParsedToken.trailingTriviaText, position: .trailing)
    case .materializedToken:
      return Array(raw.asMaterializedToken.trailingTrivia)
    case .layout:
      preconditionFailure("'trailingRawTriviaPieces' is called on non-token raw syntax")
    }
  }

  /// Returns the leading ``Trivia`` length.
  @_spi(RawSyntax)
  public var leadingTriviaLength: SourceLength {
    return SourceLength(utf8Length: leadingTriviaByteLength)
  }

  /// Returns the trailing ``Trivia`` length.
  @_spi(RawSyntax)
  public var trailingTriviaLength: SourceLength {
    return SourceLength(utf8Length: trailingTriviaByteLength)
  }

  /// Run `body` with text of the leading trivia and return its result.
  @_spi(RawSyntax)
  public func leadingTrivia<T>(_ body: (SyntaxText) -> T) -> T {
    switch raw.header {
    case .parsedToken:
      return body(raw.asParsedToken.leadingTriviaText)
    case .materializedToken:
      var leadingTriviaStr = Trivia(pieces: raw.asMaterializedToken.leadingTrivia.map(TriviaPiece.init))
        .description
      return leadingTriviaStr.withSyntaxText(body)
    case .layout:
      preconditionFailure("'leadingTrivia' is called on non-token raw syntax")
    }
  }

  /// Run `body` with text of the leading trivia and return its result.
  @_spi(RawSyntax)
  public func trailingTrivia<T>(_ body: (SyntaxText) -> T) -> T {
    switch raw.header {
    case .parsedToken:
      return body(raw.asParsedToken.trailingTriviaText)
    case .materializedToken:
      var trailingTriviaStr = Trivia(pieces: raw.asMaterializedToken.trailingTrivia.map(TriviaPiece.init))
        .description
      return trailingTriviaStr.withSyntaxText(body)
    case .layout:
      preconditionFailure("'trailingTrivia' is called on non-token raw syntax")
    }
  }

  /// Returns the leading ``Trivia``.
  @_spi(RawSyntax)
  public func formLeadingTrivia() -> Trivia {
    return Trivia(pieces: leadingRawTriviaPieces.map({ TriviaPiece(raw: $0) }))
  }

  /// Returns the trailing ``Trivia``.
  /// - Returns: nil if called on a layout node.
  @_spi(RawSyntax)
  public func formTrailingTrivia() -> Trivia {
    return Trivia(pieces: trailingRawTriviaPieces.map({ TriviaPiece(raw: $0) }))
  }

  /// Returns a ``RawSyntax`` node with the same source text but with the token
  /// kind changed to `newValue`.
  @_spi(RawSyntax)
  public func withKind(_ newValue: TokenKind, arena: RawSyntaxArena) -> RawSyntax {
    arena.addChild(self.raw.arenaReference)
    switch raw.header {
    case .parsedToken:
      // The wholeText can't be continuous anymore. Make a materialized token.
      return .makeMaterializedToken(
        kind: newValue,
        leadingTrivia: formLeadingTrivia(),
        trailingTrivia: formTrailingTrivia(),
        presence: presence,
        tokenDiagnostic: tokenDiagnostic,
        arena: arena
      )
    case .materializedToken:
      var payload = raw.asMaterializedToken.fields
      let decomposed = newValue.decomposeToRaw()
      let rawKind = decomposed.rawKind
      let text: SyntaxText = (decomposed.string.map({ arena.intern($0) }) ?? decomposed.rawKind.defaultText ?? "")
      payload.tokenKind = rawKind
      payload.tokenText = text
      return RawSyntax(arena: arena, materializedToken: payload)
    default:
      preconditionFailure("'withKind()' is called on non-token raw syntax")
    }
  }

  /// Returns a ``RawSyntax`` node with the presence changed to `newValue`.
  @_spi(RawSyntax)
  public func withPresence(_ newValue: SourcePresence, arena: RawSyntaxArena) -> RawSyntax {
    arena.addChild(self.raw.arenaReference)
    switch raw.header {
    case .parsedToken:
      var payload = raw.asParsedToken.fields
      if arena == self.raw.arenaReference {
        payload.presence = newValue
        return RawSyntax(arena: arena, parsedToken: payload)
      }
      // If the modified token is allocated in a different arena, it might have
      // a different or no `parseTrivia` function. We thus cannot use a
      // `parsedToken` anymore.
      return .makeMaterializedToken(
        kind: formKind(),
        leadingTrivia: formLeadingTrivia(),
        trailingTrivia: formTrailingTrivia(),
        presence: newValue,
        tokenDiagnostic: tokenDiagnostic,
        arena: arena
      )
    case .materializedToken:
      var payload = raw.asMaterializedToken.fields
      payload.presence = newValue
      return RawSyntax(arena: arena, materializedToken: payload)
    default:
      preconditionFailure("'withKind()' is called on non-token raw syntax")
    }
  }

  /// The length of the token without leading or trailing trivia, assuming this
  /// is a token node.
  @_spi(RawSyntax)
  public var textByteLength: Int {
    switch raw.header {
    case .parsedToken:
      return raw.asParsedToken.tokenText.count
    case .materializedToken:
      return raw.asMaterializedToken.tokenText.count
    case .layout:
      preconditionFailure("'textByteLength' is not available for non-token node")
    }
  }

  @_spi(RawSyntax)
  public var trimmedLength: SourceLength {
    SourceLength(utf8Length: textByteLength)
  }

  @_spi(RawSyntax)
  public func formKind() -> TokenKind {
    switch raw.header {
    case .parsedToken:
      return TokenKind.fromRaw(
        kind: raw.asParsedToken.tokenKind,
        text: String(syntaxText: raw.asParsedToken.tokenText)
      )
    case .materializedToken:
      return TokenKind.fromRaw(
        kind: raw.asMaterializedToken.tokenKind,
        text: String(syntaxText: raw.asMaterializedToken.tokenText)
      )
    case .layout:
      preconditionFailure("'formKind' is not available for non-token node")
    }
  }

  @_spi(RawSyntax)
  public var presence: SourcePresence {
    switch raw.header {
    case .parsedToken:
      return raw.asParsedToken.presence
    case .materializedToken:
      return raw.asMaterializedToken.presence
    case .layout:
      preconditionFailure("'presence' is not available for non-token node")
    }
  }

  @_spi(RawSyntax)
  public var tokenDiagnostic: TokenDiagnostic? {
    switch raw.header {
    case .parsedToken:
      return raw.asParsedToken.tokenDiagnostic
    case .materializedToken:
      return raw.asMaterializedToken.tokenDiagnostic
    case .layout:
      preconditionFailure("'tokenDiagnostic' is not available for non-token node")
    }
  }

  @_spi(RawSyntax)
  public func withTokenDiagnostic(tokenDiagnostic: TokenDiagnostic?, arena: RawSyntaxArena) -> RawTokenSyntax {
    arena.addChild(self.raw.arenaReference)
    switch raw.header {
    case .parsedToken:
      var dat = raw.asParsedToken.fields
      if arena == self.raw.arenaReference {
        dat.tokenDiagnostic = tokenDiagnostic
        return RawSyntax(arena: arena, parsedToken: dat).cast(RawTokenSyntax.self)
      }
      // If the modified token is allocated in a different arena, it might have
      // a different or no `parseTrivia` function. We thus cannot use a
      // `parsedToken` anymore.
      return RawSyntax.makeMaterializedToken(
        kind: formKind(),
        leadingTrivia: formLeadingTrivia(),
        trailingTrivia: formTrailingTrivia(),
        presence: presence,
        tokenDiagnostic: tokenDiagnostic,
        arena: arena
      ).cast(RawTokenSyntax.self)
    case .materializedToken:
      var dat = raw.asMaterializedToken.fields
      dat.tokenDiagnostic = tokenDiagnostic
      return RawSyntax(arena: arena, materializedToken: dat).cast(RawTokenSyntax.self)
    default:
      preconditionFailure("'withTokenDiagnostic' is not available for non-token node")
    }
  }
}
