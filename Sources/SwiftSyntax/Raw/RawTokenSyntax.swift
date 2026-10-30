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

@_spi(RawSyntax)
public struct RawTokenSyntax: Sendable {
  @_spi(RawSyntax)
  public typealias SyntaxType = TokenSyntax

  @_spi(RawSyntax)
  public var tokenView: RawSyntaxTokenView {
    return raw.tokenView!
  }

  @_spi(RawSyntax)
  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .token
  }

  @_spi(RawSyntax)
  public var raw: RawSyntax

  @_spi(RawSyntax)
  public init(raw: RawSyntax) {
    precondition(Self.isKindOf(raw))
    self.raw = raw
  }

  /// Wraps `raw` without checking that it is a token. The caller must know it is.
  @_spi(RawSyntax)
  public init(unchecked raw: RawSyntax) {
    self.raw = raw
  }

  @_spi(RawSyntax)
  public var tokenKind: RawTokenKind {
    return tokenView.rawKind
  }

  @_spi(RawSyntax)
  public var tokenText: SyntaxText {
    return tokenView.rawText
  }

  @_spi(RawSyntax)
  public var byteLength: Int {
    return Int(raw.byteLength)
  }

  @_spi(RawSyntax)
  public var presence: SourcePresence {
    tokenView.presence
  }

  @_spi(RawSyntax)
  public var isMissing: Bool {
    presence == .missing
  }

  @_spi(RawSyntax)
  public var leadingTriviaByteLength: Int {
    return tokenView.leadingTriviaByteLength
  }

  @_spi(RawSyntax)
  public var leadingTriviaPieces: [RawTriviaPiece] {
    tokenView.leadingRawTriviaPieces
  }

  @_spi(RawSyntax)
  public var trailingTriviaByteLength: Int {
    return tokenView.trailingTriviaByteLength
  }

  @_spi(RawSyntax)
  public var trailingTriviaPieces: [RawTriviaPiece] {
    tokenView.trailingRawTriviaPieces
  }

  /// Creates a ``RawTokenSyntax``. `wholeText` must be managed by the same
  /// `arena`. `textRange` is a range of the token text in `wholeText`.
  public init(
    kind: RawTokenKind,
    wholeText: SyntaxText,
    textRange: Range<SyntaxText.Index>,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared ParsingRawSyntaxArena
  ) {
    // This text is already arena owned rather than lexed, so the buffer stops at
    // the token and its text is copied exactly.
    self.init(
      kind: kind,
      sourceBuffer: UnsafeBufferPointer(start: wholeText.baseAddress, count: wholeText.count),
      leadingTriviaByteLength: textRange.lowerBound,
      textByteLength: textRange.count,
      wholeTextLength: wholeText.count,
      presence: presence,
      tokenDiagnostic: tokenDiagnostic,
      arena: arena
    )
  }

  /// Creates a ``RawTokenSyntax`` from what the lexer holds: the buffer it is
  /// reading, positioned at the token, and the token's byte lengths.
  public init(
    kind: RawTokenKind,
    sourceBuffer: UnsafeBufferPointer<UInt8>,
    leadingTriviaByteLength: Int,
    textByteLength: Int,
    wholeTextLength: Int,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared ParsingRawSyntaxArena
  ) {
    let raw = RawSyntax.parsedToken(
      kind: kind,
      sourceBuffer: sourceBuffer,
      leadingTriviaByteLength: leadingTriviaByteLength,
      textByteLength: textByteLength,
      wholeTextLength: wholeTextLength,
      presence: presence,
      tokenDiagnostic: tokenDiagnostic,
      arena: arena
    )
    self = RawTokenSyntax(unchecked: raw)
  }

  /// Creates a ``RawTokenSyntax``. `text` and trivia must be managed by the same
  /// `arena`.
  public init(
    kind: RawTokenKind,
    text: SyntaxText,
    leadingTriviaPieces: [RawTriviaPiece] = [],
    trailingTriviaPieces: [RawTriviaPiece] = [],
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic? = nil,
    arena: __shared ParsingRawSyntaxArena
  ) {
    if leadingTriviaPieces.isEmpty && trailingTriviaPieces.isEmpty {
      // Create it via `RawSyntax.parsedToken()`.
      self.init(
        kind: kind,
        wholeText: text,
        textRange: 0..<text.count,
        presence: presence,
        tokenDiagnostic: tokenDiagnostic,
        arena: arena
      )
    } else {
      // Create it via `RawSyntax.makeMaterializedToken()`.
      self.init(
        materialized: kind,
        text: text,
        leadingTriviaPieces: leadingTriviaPieces,
        trailingTriviaPieces: trailingTriviaPieces,
        presence: presence,
        tokenDiagnostic: tokenDiagnostic,
        arena: arena
      )
    }
  }

  /// Creates a `MaterializedToken`. Trivia must be managed by the same `arena`.
  fileprivate init(
    materialized kind: RawTokenKind,
    text: SyntaxText,
    leadingTriviaPieces: [RawTriviaPiece],
    trailingTriviaPieces: [RawTriviaPiece],
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared RawSyntaxArena
  ) {
    let raw = RawSyntax.makeMaterializedToken(
      kind: kind,
      text: text,
      leadingTriviaPieceCount: leadingTriviaPieces.count,
      trailingTriviaPieceCount: trailingTriviaPieces.count,
      presence: presence,
      tokenDiagnostic: tokenDiagnostic,
      arena: arena,
      initializingLeadingTriviaWith: { buffer in
        _ = buffer.initialize(from: leadingTriviaPieces)
      },
      initializingTrailingTriviaWith: { buffer in
        _ = buffer.initialize(from: trailingTriviaPieces)
      }
    )
    self = RawTokenSyntax(unchecked: raw)
  }

  /// Creates a missing ``TokenSyntax`` with the specified kind.
  /// If `text` is passed, it will be used to represent the missing token's text.
  /// If `text` is `nil`, the `kind`'s default text will be used.
  /// If that is also `nil`, the token will have empty text.
  public init(
    missing kind: RawTokenKind,
    text: SyntaxText? = nil,
    leadingTriviaPieces: [RawTriviaPiece] = [],
    trailingTriviaPieces: [RawTriviaPiece] = [],
    arena: __shared RawSyntaxArena
  ) {
    self.init(
      materialized: kind,
      text: text ?? kind.defaultText ?? "",
      leadingTriviaPieces: leadingTriviaPieces,
      trailingTriviaPieces: trailingTriviaPieces,
      presence: .missing,
      tokenDiagnostic: nil,
      arena: arena
    )
  }
}
