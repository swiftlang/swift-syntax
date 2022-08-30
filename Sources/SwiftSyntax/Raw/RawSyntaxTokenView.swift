//===--- RawSyntaxTokenView.swift -----------------------------------------===//
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
  var tokenView: RawSyntaxTokenView? {
    switch raw.payload {
    case .parsedToken, .materializedToken:
      return RawSyntaxTokenView(raw: self)
    case .layout(_):
      return nil
    }
  }
}

/// A view into `RawSyntax` that exposes functionality that only applies to tokens.
struct RawSyntaxTokenView {
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
  var rawKind: RawTokenKind {
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
  var rawText: SyntaxText {
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
  var leadingTriviaByteLength: Int {
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
  var trailingTriviaByteLength: Int {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.trailingTriviaText.count
    case .materializedToken(let dat):
      return dat.trailingTrivia.reduce(0) { $0 + $1.byteLength }
    case .layout(_):
      preconditionFailure("'tokenTrailingTriviaByteLength' is not available for non-token node")
    }
  }

  var leadingRawTriviaPieces: [RawTriviaPiece] {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return raw.arena.parseTrivia(source: dat.leadingTriviaText, position: .leading)
    case .materializedToken(let dat):
      return Array(dat.leadingTrivia)
    case .layout(_):
      preconditionFailure("'tokenLeadingRawTriviaPieces' is called on non-token raw syntax")
    }
  }

  var trailingRawTriviaPieces: [RawTriviaPiece] {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return raw.arena.parseTrivia(source: dat.trailingTriviaText, position: .trailing)
    case .materializedToken(let dat):
      return Array(dat.trailingTrivia)
    case .layout(_):
      preconditionFailure("'tokenTrailingRawTriviaPieces' is called on non-token raw syntax")
    }
  }

  /// Returns the leading `Trivia` length.
  var leadingTriviaLength: SourceLength {
    return SourceLength(utf8Length: leadingTriviaByteLength)
  }

  /// Returns the trailing `Trivia` length.
  var trailingTriviaLength: SourceLength {
    return SourceLength(utf8Length: trailingTriviaByteLength)
  }

  /// Returns the leading `Trivia`.
  func formLeadingTrivia() -> Trivia {
    return Trivia(pieces: leadingRawTriviaPieces.map({ TriviaPiece(raw: $0) }))
  }

  /// Returns the trailing `Trivia`.
  /// - Returns: nil if called on a layout node.
  func formTrailingTrivia() -> Trivia {
    return Trivia(pieces: trailingRawTriviaPieces.map({ TriviaPiece(raw: $0) }))
  }

  /// Calls `body` with the token text. The token text value must not escape the closure.
  func withUnsafeTokenText<Result>(
    _ body: (SyntaxText?) -> Result
  ) -> Result {
    body(rawText)
  }

  /// Returns a `RawSyntax` node with the same source text but with the token
  /// kind changed to `newValue`.
  func withKind(_ newValue: TokenKind) -> RawSyntax {
    switch raw.rawData.payload {
    case .parsedToken(_):
      // The wholeText can't be continuous anymore. Make a materialized token.
      return .makeMaterializedToken(
        kind: newValue,
        leadingTrivia: formLeadingTrivia(),
        trailingTrivia: formTrailingTrivia(),
        arena: raw.arena)
    case .materializedToken(var payload):
      let decomposed = newValue.decomposeToRaw()
      let rawKind = decomposed.rawKind
      let text: SyntaxText = (decomposed.string.map({raw.arena.intern($0)}) ??
                              decomposed.rawKind.defaultText ??
                              "")
      payload.tokenKind = rawKind
      payload.tokenText = text
      return RawSyntax(arena: raw.arena, payload: .materializedToken(payload))
    default:
      preconditionFailure("'withTokenKind()' is called on non-token raw syntax")
    }
  }

  /// The length of the token without leading or trailing trivia, assuming this
  /// is a token node.
  var textByteLength: Int {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.tokenText.count
    case .materializedToken(let dat):
      return dat.tokenText.count
    case .layout(_):
      preconditionFailure("'tokenTextByteLength' is not available for non-token node")
    }
  }

  var contentLength: SourceLength {
    SourceLength(utf8Length: textByteLength)
  }

  func formKind() -> TokenKind {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return TokenKind.fromRaw(kind: dat.tokenKind, text: String(syntaxText: dat.tokenText))
    case .materializedToken(let dat):
      return TokenKind.fromRaw(kind: dat.tokenKind, text: String(syntaxText: dat.tokenText))
    case .layout(_):
      preconditionFailure("Must be invoked on a token")
    }
  }

  var presence: SourcePresence {
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      return dat.presence
    case .materializedToken(let dat):
      return dat.presence
    case .layout(_):
      preconditionFailure("'presence' is a token-only property")
    }
  }

}
