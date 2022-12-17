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

extension RawSyntax {
  /// A view into the `RawSyntax` that exposes functionality that's specific to tokens.
  /// The token's payload must be a token, otherwise this traps.
  @_spi(RawSyntax)
  public var tokenView: RawSyntaxTokenView? {
    switch raw.payload {
    case .parsedToken, .materializedToken:
      return RawSyntaxTokenView(raw: self)
    case .layout(_):
      return nil
    }
  }
}

/// A view into `RawSyntax` that exposes functionality that only applies to tokens.
@_spi(RawSyntax)
public struct RawSyntaxTokenView {
  let raw: RawSyntax

  fileprivate init(raw: RawSyntax) {
    self.raw = raw
    switch raw.payload {
    case .parsedToken, .materializedToken:
      break
    case .layout(_):
      preconditionFailure("RawSyntax must be a token")
    }
  }

  /// Token kind of this node.
  @_spi(RawSyntax)
  public var rawKind: RawTokenKind {
    switch raw.rawData.payload {
    case .materializedToken(let dat):
      return dat.tokenKind
    case .parsedToken(let dat):
      return dat.tokenKind
    case .layout(_):
      preconditionFailure("'tokenKind' is not available for non-token node")
    }
  }

  /// Token text of this node.
  @_spi(RawSyntax)
  public var rawText: SyntaxText {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.tokenText
    case .materializedToken(let dat):
      return dat.tokenText
    case .layout(_):
      preconditionFailure("'tokenText' is not available for non-token node")
    }
  }

  /// The UTF-8 byte length of the leading trivia.
  @_spi(RawSyntax)
  public var leadingTriviaByteLength: Int {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.leadingTriviaText.count
    case .materializedToken(let dat):
      return dat.leadingTrivia.reduce(0) { $0 + $1.byteLength }
    case .layout(_):
      preconditionFailure("'tokenLeadingTriviaByteLength' is not available for non-token node")
    }
  }

  /// The UTF-8 byte length of the trailing trivia.
  @_spi(RawSyntax)
  public var trailingTriviaByteLength: Int {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.trailingTriviaText.count
    case .materializedToken(let dat):
      return dat.trailingTrivia.reduce(0) { $0 + $1.byteLength }
    case .layout(_):
      preconditionFailure("'tokenTrailingTriviaByteLength' is not available for non-token node")
    }
  }

  @_spi(RawSyntax)
  public var leadingRawTriviaPieces: [RawTriviaPiece] {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      let arena = raw.arena as! ParsingSyntaxArena
      return arena.parseTrivia(source: dat.leadingTriviaText, position: .leading)
    case .materializedToken(let dat):
      return Array(dat.leadingTrivia)
    case .layout(_):
      preconditionFailure("'tokenLeadingRawTriviaPieces' is called on non-token raw syntax")
    }
  }

  @_spi(RawSyntax)
  public var trailingRawTriviaPieces: [RawTriviaPiece] {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      let arena = raw.arena as! ParsingSyntaxArena
      return arena.parseTrivia(source: dat.trailingTriviaText, position: .trailing)
    case .materializedToken(let dat):
      return Array(dat.trailingTrivia)
    case .layout(_):
      preconditionFailure("'tokenTrailingRawTriviaPieces' is called on non-token raw syntax")
    }
  }

  /// Returns the leading `Trivia` length.
  @_spi(RawSyntax)
  public var leadingTriviaLength: SourceLength {
    return SourceLength(utf8Length: leadingTriviaByteLength)
  }

  /// Returns the trailing `Trivia` length.
  @_spi(RawSyntax)
  public var trailingTriviaLength: SourceLength {
    return SourceLength(utf8Length: trailingTriviaByteLength)
  }

  /// Returns the leading `Trivia`.
  @_spi(RawSyntax)
  public func formLeadingTrivia() -> Trivia {
    return Trivia(pieces: leadingRawTriviaPieces.map({ TriviaPiece(raw: $0) }))
  }

  /// Returns the trailing `Trivia`.
  /// - Returns: nil if called on a layout node.
  @_spi(RawSyntax)
  public func formTrailingTrivia() -> Trivia {
    return Trivia(pieces: trailingRawTriviaPieces.map({ TriviaPiece(raw: $0) }))
  }

  /// Returns a `RawSyntax` node with the same source text but with the token
  /// kind changed to `newValue`.
  @_spi(RawSyntax)
  public func withKind(_ newValue: TokenKind, arena: SyntaxArena) -> RawSyntax {
    switch raw.rawData.payload {
    case .parsedToken(_):
      // The wholeText can't be continuous anymore. Make a materialized token.
      return .makeMaterializedToken(
        kind: newValue,
        leadingTrivia: formLeadingTrivia(),
        trailingTrivia: formTrailingTrivia(),
        presence: presence,
        arena: arena
      )
    case .materializedToken(var payload):
      let decomposed = newValue.decomposeToRaw()
      let rawKind = decomposed.rawKind
      let text: SyntaxText = (decomposed.string.map({ arena.intern($0) }) ?? decomposed.rawKind.defaultText ?? "")
      payload.tokenKind = rawKind
      payload.tokenText = text
      return RawSyntax(arena: arena, payload: .materializedToken(payload))
    default:
      preconditionFailure("'withTokenKind()' is called on non-token raw syntax")
    }
  }

  /// The length of the token without leading or trailing trivia, assuming this
  /// is a token node.
  @_spi(RawSyntax)
  public var textByteLength: Int {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.tokenText.count
    case .materializedToken(let dat):
      return dat.tokenText.count
    case .layout(_):
      preconditionFailure("'tokenTextByteLength' is not available for non-token node")
    }
  }

  @_spi(RawSyntax)
  public var contentLength: SourceLength {
    SourceLength(utf8Length: textByteLength)
  }

  @_spi(RawSyntax)
  public func formKind() -> TokenKind {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return TokenKind.fromRaw(kind: dat.tokenKind, text: String(syntaxText: dat.tokenText))
    case .materializedToken(let dat):
      return TokenKind.fromRaw(kind: dat.tokenKind, text: String(syntaxText: dat.tokenText))
    case .layout(_):
      preconditionFailure("Must be invoked on a token")
    }
  }

  @_spi(RawSyntax)
  public var presence: SourcePresence {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.presence
    case .materializedToken(let dat):
      return dat.presence
    case .layout(_):
      preconditionFailure("'presence' is a token-only property")
    }
  }

  var hasLexerError: Bool {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.hasLexerError
    case .materializedToken(_):
      return false
    case .layout(_):
      preconditionFailure("'hasError' is a token-only property")
    }
  }
}
