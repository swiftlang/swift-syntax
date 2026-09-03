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

#if compiler(>=6)
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

/// All typed raw syntax nodes conform to this protocol.
/// `RawXXXSyntax` is a typed wrappeer of ``RawSyntax``.
protocol RawSyntaxNodeProtocol: Sendable {
  /// Returns `true` if `raw` can be cast to this concrete raw syntax type.
  static func isKindOf(_ raw: RawSyntax) -> Bool

  /// Type erased raw syntax.
  var raw: RawSyntax { get }

  /// Create the typed raw syntax if `other` can be cast to `Self`
  init?(_ other: some RawSyntaxNodeProtocol)
}

extension RawSyntaxNodeProtocol {
  /// Cast to the specified raw syntax type if possible.
  func `as`<Node: RawSyntaxNodeProtocol>(_: Node.Type) -> Node? {
    Node(self)
  }

  /// Check if this instance can be cast to the specified syntax type.
  func `is`<Node: RawSyntaxNodeProtocol>(_: Node.Type) -> Bool {
    Node.isKindOf(self.raw)
  }

  func cast<S: RawSyntaxNodeProtocol>(_ syntaxType: S.Type) -> S {
    return self.as(S.self)!
  }

  var isEmpty: Bool {
    return raw.byteLength == 0
  }

  /// Whether the tree contained by this layout has any
  ///  - missing nodes or
  ///  - unexpected nodes or
  ///  - tokens with a ``TokenDiagnostic`` of severity `error`
  var hasError: Bool {
    return raw.hasError
  }
}

/// ``RawSyntax`` itself conforms to `RawSyntaxNodeProtocol`.
extension RawSyntax: RawSyntaxNodeProtocol {
  static func isKindOf(_ raw: RawSyntax) -> Bool {
    return true
  }

  var raw: RawSyntax { self }

  init(raw: RawSyntax) {
    self = raw
  }

  init(_ other: some RawSyntaxNodeProtocol) {
    self.init(raw: other.raw)
  }
}

#if swift(<5.8)
// Cherry-pick this function from SE-0370
extension Slice {
  @inlinable
  func initialize<S>(
    from source: S
  ) -> (unwritten: S.Iterator, index: Index)
  where S: Sequence, Base == UnsafeMutableBufferPointer<S.Element> {
    let buffer = Base(rebasing: self)
    let (iterator, index) = buffer.initialize(from: source)
    let distance = buffer.distance(from: buffer.startIndex, to: index)
    return (iterator, startIndex.advanced(by: distance))
  }
}
#endif

struct RawTokenSyntax: RawSyntaxNodeProtocol {
  typealias SyntaxType = TokenSyntax

  var tokenView: RawSyntaxTokenView {
    return raw.tokenView!
  }

  static func isKindOf(_ raw: RawSyntax) -> Bool {
    return raw.kind == .token
  }

  var raw: RawSyntax

  init(raw: RawSyntax) {
    precondition(Self.isKindOf(raw))
    self.raw = raw
  }

  private init(unchecked raw: RawSyntax) {
    self.raw = raw
  }

  init?(_ other: some RawSyntaxNodeProtocol) {
    guard Self.isKindOf(other.raw) else { return nil }
    self.init(unchecked: other.raw)
  }

  var tokenKind: RawTokenKind {
    return tokenView.rawKind
  }

  var tokenText: SyntaxText {
    return tokenView.rawText
  }

  var byteLength: Int {
    return raw.byteLength
  }

  var presence: SourcePresence {
    tokenView.presence
  }

  var isMissing: Bool {
    presence == .missing
  }

  var leadingTriviaByteLength: Int {
    return tokenView.leadingTriviaByteLength
  }

  var leadingTriviaPieces: [RawTriviaPiece] {
    tokenView.leadingRawTriviaPieces
  }

  var trailingTriviaByteLength: Int {
    return tokenView.trailingTriviaByteLength
  }

  var trailingTriviaPieces: [RawTriviaPiece] {
    tokenView.trailingRawTriviaPieces
  }

  /// Creates a ``RawTokenSyntax``. `wholeText` must be managed by the same
  /// `arena`. `textRange` is a range of the token text in `wholeText`.
  init(
    kind: RawTokenKind,
    wholeText: SyntaxText,
    textRange: Range<SyntaxText.Index>,
    presence: SourcePresence,
    tokenDiagnostic: TokenDiagnostic?,
    arena: __shared ParsingRawSyntaxArena
  ) {
    let raw = RawSyntax.parsedToken(
      kind: kind,
      wholeText: wholeText,
      textRange: textRange,
      presence: presence,
      tokenDiagnostic: tokenDiagnostic,
      arena: arena
    )
    self = RawTokenSyntax(unchecked: raw)
  }

  /// Creates a ``RawTokenSyntax``. `text` and trivia must be managed by the same
  /// `arena`.
  init(
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
  init(
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

extension RawUnexpectedNodesSyntax {
  /// Construct a ``RawUnexpectedNodesSyntax``with the given `elements`.
  ///
  /// If `isMaximumNestingLevelOverflow` is `true`, the node has the
  /// `isMaximumNestingLevelOverflow` error bit set, indicating that the parser
  /// overflowed its maximum nesting level and thus aborted parsing.
  init(elements: [RawSyntax], isMaximumNestingLevelOverflow: Bool, arena: __shared RawSyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .unexpectedNodes,
      uninitializedCount: elements.count,
      isMaximumNestingLevelOverflow: isMaximumNestingLevelOverflow,
      arena: arena
    ) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }
}
