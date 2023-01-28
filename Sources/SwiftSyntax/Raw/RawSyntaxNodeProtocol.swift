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

/// All typed raw syntax nodes conform to this protocol.
/// `RawXXXSyntax` is a typed wrappeer of `RawSyntax`.
@_spi(RawSyntax)
public protocol RawSyntaxNodeProtocol: CustomStringConvertible, TextOutputStreamable {
  /// Returns `true` if `raw` can be cast to this concrete raw syntax type.
  static func isKindOf(_ raw: RawSyntax) -> Bool

  /// Type erased raw syntax.
  var raw: RawSyntax { get }

  /// Create the typed raw syntax if `other` can be cast to `Self`
  init?<T: RawSyntaxNodeProtocol>(_ other: T)
}

public extension RawSyntaxNodeProtocol {
  /// Cast to the specified raw syntax type if possible.
  func `as`<Node: RawSyntaxNodeProtocol>(_: Node.Type) -> Node? {
    Node(self)
  }

  /// Check if this instance can be cast to the specified syntax type.
  func `is`<Node: RawSyntaxNodeProtocol>(_: Node.Type) -> Bool {
    Node.isKindOf(self.raw)
  }

  var description: String {
    raw.description
  }

  func write<Target>(to target: inout Target) where Target: TextOutputStream {
    raw.write(to: &target)
  }

  var isEmpty: Bool {
    return raw.byteLength == 0
  }
}

/// `RawSyntax` itself conforms to `RawSyntaxNodeProtocol`.
extension RawSyntax: RawSyntaxNodeProtocol {
  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return true
  }
  public var raw: RawSyntax { self }

  init(raw: RawSyntax) {
    self = raw
  }

  public init<T: RawSyntaxNodeProtocol>(_ other: T) {
    self.init(raw: other.raw)
  }
}

@_spi(RawSyntax)
public struct RawTokenSyntax: RawSyntaxNodeProtocol {
  public typealias SyntaxType = TokenSyntax

  @_spi(RawSyntax)
  public var tokenView: RawSyntaxTokenView {
    return raw.tokenView!
  }

  public static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .token
  }

  public var raw: RawSyntax

  init(raw: RawSyntax) {
    assert(Self.isKindOf(raw))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(raw: other.raw)
  }

  public var tokenKind: RawTokenKind {
    return tokenView.rawKind
  }

  public var tokenText: SyntaxText {
    return tokenView.rawText
  }

  public var byteLength: Int {
    return raw.byteLength
  }

  public var presence: SourcePresence {
    tokenView.presence
  }

  public var isMissing: Bool {
    presence == .missing
  }

  public var leadingTriviaByteLength: Int {
    return tokenView.leadingTriviaByteLength
  }

  public var leadingTriviaPieces: [RawTriviaPiece] {
    tokenView.leadingRawTriviaPieces
  }

  public var trailingTriviaByteLength: Int {
    return tokenView.trailingTriviaByteLength
  }

  public var trailingTriviaPieces: [RawTriviaPiece] {
    tokenView.trailingRawTriviaPieces
  }

  /// Creates a `RawTokenSyntax`. `wholeText` must be managed by the same
  /// `arena`. `textRange` is a range of the token text in `wholeText`.
  public init(
    kind: RawTokenKind,
    wholeText: SyntaxText,
    textRange: Range<SyntaxText.Index>,
    presence: SourcePresence,
    lexerError: LexerError?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.parsedToken(
      kind: kind,
      wholeText: wholeText,
      textRange: textRange,
      presence: presence,
      lexerError: lexerError,
      arena: arena
    )
    self = RawTokenSyntax(raw: raw)
  }

  /// Creates a `RawTokenSyntax`. `text` and trivia must be managed by the same
  /// `arena`.
  public init(
    kind: RawTokenKind,
    text: SyntaxText,
    leadingTriviaPieces: [RawTriviaPiece] = [],
    trailingTriviaPieces: [RawTriviaPiece] = [],
    presence: SourcePresence,
    lexerError: LexerError? = nil,
    arena: __shared SyntaxArena
  ) {
    if leadingTriviaPieces.isEmpty && trailingTriviaPieces.isEmpty {
      // Create it via `RawSyntax.parsedToken()`.
      self.init(
        kind: kind,
        wholeText: text,
        textRange: 0..<text.count,
        presence: presence,
        lexerError: lexerError,
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
        lexerError: lexerError,
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
    lexerError: LexerError?,
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeMaterializedToken(
      kind: kind,
      text: text,
      leadingTriviaPieceCount: leadingTriviaPieces.count,
      trailingTriviaPieceCount: trailingTriviaPieces.count,
      presence: presence,
      lexerError: lexerError,
      arena: arena,
      initializingLeadingTriviaWith: { buffer in
        _ = buffer.initialize(from: leadingTriviaPieces)
      },
      initializingTrailingTriviaWith: { buffer in
        _ = buffer.initialize(from: trailingTriviaPieces)
      }
    )
    self = RawTokenSyntax(raw: raw)
  }

  /// Creates a missing `TokenSyntax` with the specified kind.
  /// If `text` is passed, it will be used to represent the missing token's text.
  /// If `text` is `nil`, the `kind`'s default text will be used.
  /// If that is also `nil`, the token will have empty text.
  public init(
    missing kind: RawTokenKind,
    text: SyntaxText? = nil,
    leadingTriviaPieces: [RawTriviaPiece] = [],
    trailingTriviaPieces: [RawTriviaPiece] = [],
    arena: __shared SyntaxArena
  ) {
    // FIXME: Allow creating a `RawSyntax.parsedToken()` with a string literal
    // for text. Currently it asserts that the string buffer is not contained
    // within the `arena`.
    self.init(
      materialized: kind,
      text: text ?? kind.defaultText ?? "",
      leadingTriviaPieces: leadingTriviaPieces,
      trailingTriviaPieces: trailingTriviaPieces,
      presence: .missing,
      lexerError: nil,
      arena: arena
    )
  }

  /// Assuming that text representing `extendedTrivia` preceeds this token,
  /// return a token that has its leading trivia prepended by `extendedTrivia`.
  /// This can be used to transfer trivia from a preceeding token to this token.
  /// The caller is responsible to delete preceeding trivia from the tree to
  /// maintain source-fidelity.
  public func extendingLeadingTrivia(by extendedTrivia: [RawTriviaPiece], arena: SyntaxArena) -> RawTokenSyntax {
    let extendedTriviaByteLength = extendedTrivia.reduce(0, { $0 + $1.byteLength })
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      assert(String(syntaxText: SyntaxText(baseAddress: dat.wholeText.baseAddress?.advanced(by: -extendedTriviaByteLength), count: extendedTriviaByteLength)) == Trivia(pieces: extendedTrivia.map(TriviaPiece.init)).description)
      let wholeText = SyntaxText(baseAddress: dat.wholeText.baseAddress?.advanced(by: -extendedTriviaByteLength), count: dat.wholeText.count + extendedTriviaByteLength)
      let textRange = (dat.textRange.lowerBound + extendedTriviaByteLength)..<(dat.textRange.upperBound + extendedTriviaByteLength)
      return RawSyntax.parsedToken(
        kind: dat.tokenKind,
        wholeText: arena.intern(wholeText),
        textRange: textRange,
        presence: dat.presence,
        lexerError: dat.lexerError,
        arena: arena
      ).as(RawTokenSyntax.self)!
    case .materializedToken(let dat):
      let triviaBuffer = arena.allocateRawTriviaPieceBuffer(count: dat.triviaPieces.count + extendedTrivia.count)
      let (_, extenedTriviaEndIndex) = triviaBuffer.initialize(from: extendedTrivia)
      let (_, triviaEndIndex) = triviaBuffer[extenedTriviaEndIndex...].initialize(from: dat.triviaPieces)
      assert(triviaEndIndex == triviaBuffer.endIndex)
      return RawSyntax.materializedToken(
        kind: dat.tokenKind,
        text: dat.tokenText,
        triviaPieces: RawTriviaPieceBuffer(triviaBuffer),
        numLeadingTrivia: dat.numLeadingTrivia + UInt32(extendedTrivia.count),
        byteLength: dat.byteLength + UInt32(extendedTriviaByteLength),
        presence: dat.presence,
        lexerError: dat.lexerError,
        arena: arena
      ).as(RawTokenSyntax.self)!
    case .layout(_):
      preconditionFailure("Should be a token")
    }
  }

  /// Assuming that text representing `extendedTrivia` comes after this token,
  /// return a token that has its trailing trivia appended by `extendedTrivia`.
  /// This can be used to transfer trivia from the next token to this token.
  /// The caller is responsible to delete succeeding trivia from the tree to
  /// maintain source-fidelity.
  public func extendingTrailingTrivia(by extendedTrivia: [RawTriviaPiece], arena: SyntaxArena) -> RawTokenSyntax {
    let extendedTriviaByteLength = extendedTrivia.reduce(0, { $0 + $1.byteLength })
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      // TODO: Can we write this assert easier using subscript slicing?
      assert(String(syntaxText: SyntaxText(baseAddress: dat.wholeText.baseAddress?.advanced(by: dat.wholeText.count), count: extendedTriviaByteLength)) == Trivia(pieces: extendedTrivia.map(TriviaPiece.init)).description)
      let wholeText = SyntaxText(baseAddress: dat.wholeText.baseAddress, count: dat.wholeText.count + extendedTriviaByteLength)
      return RawSyntax.parsedToken(
        kind: dat.tokenKind,
        wholeText: arena.intern(wholeText),
        textRange: dat.textRange,
        presence: dat.presence,
        lexerError: dat.lexerError,
        arena: arena
      ).as(RawTokenSyntax.self)!
    case .materializedToken(let dat):
      let triviaBuffer = arena.allocateRawTriviaPieceBuffer(count: dat.triviaPieces.count + extendedTrivia.count)
      let (_, existingTriviaEndIndex) = triviaBuffer.initialize(from: dat.triviaPieces)
      let (_, triviaEndIndex) = triviaBuffer[existingTriviaEndIndex...].initialize(from: extendedTrivia)
      assert(triviaEndIndex == triviaBuffer.endIndex)
      return RawSyntax.materializedToken(
        kind: dat.tokenKind,
        text: dat.tokenText,
        triviaPieces: RawTriviaPieceBuffer(triviaBuffer),
        numLeadingTrivia: dat.numLeadingTrivia,
        byteLength: dat.byteLength + UInt32(extendedTriviaByteLength),
        presence: dat.presence,
        lexerError: dat.lexerError,
        arena: arena
      ).as(RawTokenSyntax.self)!
    case .layout(_):
      preconditionFailure("Should be a token")
    }
  }

  /// Assuming that the tokens tet starts with text representing `reclassifiedTrivia`,
  /// re-classify those characters as no longer being part of the token's text
  /// but as part of the token's leading trivia.
  /// If `error` is not `nil` and the token currently doesn't have a lexer error,
  /// that error will be set as the lexer error.
  public func reclassifyAsLeadingTrivia(_ reclassifiedTrivia: [RawTriviaPiece], lexerError: LexerError? = nil, arena: SyntaxArena) -> RawTokenSyntax {
    let reclassifiedTriviaByteLength = reclassifiedTrivia.reduce(0, { $0 + $1.byteLength })
    assert(String(syntaxText: SyntaxText(rebasing: self.tokenText[0..<reclassifiedTriviaByteLength])) == Trivia(pieces: reclassifiedTrivia.map(TriviaPiece.init)).description)
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      assert(String(syntaxText: SyntaxText(rebasing: dat.tokenText[0..<reclassifiedTriviaByteLength])) == Trivia(pieces: reclassifiedTrivia.map(TriviaPiece.init)).description)
      let textRange = (dat.textRange.lowerBound + reclassifiedTriviaByteLength)..<dat.textRange.upperBound
      return RawSyntax.parsedToken(
        kind: dat.tokenKind,
        wholeText: dat.wholeText,
        textRange: textRange,
        presence: dat.presence,
        lexerError: dat.lexerError ?? lexerError,
        arena: arena
      ).as(RawTokenSyntax.self)!
    case .materializedToken(let dat):
      assert(String(syntaxText: SyntaxText(rebasing: dat.tokenText[0..<reclassifiedTriviaByteLength])) == Trivia(pieces: reclassifiedTrivia.map(TriviaPiece.init)).description)
      let triviaBuffer = arena.allocateRawTriviaPieceBuffer(count: dat.triviaPieces.count + reclassifiedTrivia.count)
      let (_, existingLeadingTriviaEndIndex) = triviaBuffer.initialize(from: dat.leadingTrivia)
      let (_, reclassifiedTriviaEndIndex) = triviaBuffer[existingLeadingTriviaEndIndex...].initialize(from: reclassifiedTrivia)
      let (_, triviaEndIndex) = triviaBuffer[reclassifiedTriviaEndIndex...].initialize(from: dat.trailingTrivia)
      assert(triviaEndIndex == triviaBuffer.endIndex)
      return RawSyntax.materializedToken(
        kind: dat.tokenKind,
        text: SyntaxText(rebasing: dat.tokenText[reclassifiedTriviaByteLength...]),
        triviaPieces: RawTriviaPieceBuffer(triviaBuffer),
        numLeadingTrivia: dat.numLeadingTrivia + UInt32(reclassifiedTrivia.count),
        byteLength: dat.byteLength,
        presence: dat.presence,
        lexerError: dat.lexerError ?? lexerError,
        arena: arena
      ).as(RawTokenSyntax.self)!
    case .layout(_):
      preconditionFailure("Should be a token")
    }
  }

  /// Assuming that the tokens tet ends with text representing `reclassifiedTrivia`,
  /// re-classify those characters as no longer being part of the token's text
  /// but as part of the token's trailing trivia.
  /// If `error` is not `nil` and the token currently doesn't have a lexer error,
  /// that error will be set as the lexer error.
  public func reclassifyAsTrailingTrivia(_ reclassifiedTrivia: [RawTriviaPiece], lexerError: LexerError? = nil, arena: SyntaxArena) -> RawTokenSyntax {
    let reclassifiedTriviaByteLength = reclassifiedTrivia.reduce(0, { $0 + $1.byteLength })
    assert(String(syntaxText: SyntaxText(rebasing: self.tokenText[(self.tokenText.count - reclassifiedTriviaByteLength)...])) == Trivia(pieces: reclassifiedTrivia.map(TriviaPiece.init)).description)
    switch raw.rawData.payload {
    case .parsedToken(let dat):
      let textRange = dat.textRange.lowerBound..<(dat.textRange.upperBound - reclassifiedTriviaByteLength)
      return RawSyntax.parsedToken(
        kind: dat.tokenKind,
        wholeText: dat.wholeText,
        textRange: textRange,
        presence: dat.presence,
        lexerError: dat.lexerError ?? lexerError,
        arena: arena
      ).as(RawTokenSyntax.self)!
    case .materializedToken(let dat):
      let triviaBuffer = arena.allocateRawTriviaPieceBuffer(count: dat.triviaPieces.count + reclassifiedTrivia.count)
      let (_, existingLeadingTriviaEndIndex) = triviaBuffer.initialize(from: dat.leadingTrivia)
      let (_, reclassifiedTriviaEndIndex) = triviaBuffer[existingLeadingTriviaEndIndex...].initialize(from: reclassifiedTrivia)
      let (_, triviaEndIndex) = triviaBuffer[reclassifiedTriviaEndIndex...].initialize(from: dat.trailingTrivia)
      assert(triviaEndIndex == triviaBuffer.endIndex)
      return RawSyntax.materializedToken(
        kind: dat.tokenKind,
        text: SyntaxText(rebasing: dat.tokenText[0..<(dat.tokenText.endIndex - reclassifiedTriviaByteLength)]),
        triviaPieces: RawTriviaPieceBuffer(triviaBuffer),
        numLeadingTrivia: dat.numLeadingTrivia,
        byteLength: dat.byteLength,
        presence: dat.presence,
        lexerError: dat.lexerError ?? lexerError,
        arena: arena
      ).as(RawTokenSyntax.self)!
    case .layout(_):
      preconditionFailure("Should be a token")
    }
  }
}
