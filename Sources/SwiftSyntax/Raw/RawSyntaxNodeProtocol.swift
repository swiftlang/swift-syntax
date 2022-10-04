//===------- RawSyntaxNodeProtocol.swift - Typed Raw Syntax Protocol ------===//
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

  func write<Target>(to target: inout Target) where Target : TextOutputStream {
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
public struct RawTokenSyntax: RawSyntaxToSyntax, RawSyntaxNodeProtocol {
  public typealias SyntaxType = TokenSyntax

  var tokenView: RawSyntaxTokenView {
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

  public var leadingTriviaPieces: [RawTriviaPiece] {
    tokenView.leadingRawTriviaPieces
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
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.parsedToken(
      kind: kind,
      wholeText: wholeText,
      textRange: textRange,
      presence: presence,
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
    arena: __shared SyntaxArena
  ) {
    if leadingTriviaPieces.isEmpty && trailingTriviaPieces.isEmpty {
      // Create it via `RawSyntax.parsedToken()`.
      self.init(
        kind: kind,
        wholeText: text,
        textRange: 0 ..< text.count,
        presence: presence,
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
    arena: __shared SyntaxArena
  ) {
    let raw = RawSyntax.makeMaterializedToken(
      kind: kind,
      text: text,
      leadingTriviaPieceCount: leadingTriviaPieces.count,
      trailingTriviaPieceCount: trailingTriviaPieces.count,
      presence: presence,
      arena: arena,
      initializingLeadingTriviaWith: { buffer in
        _ = buffer.initialize(from: leadingTriviaPieces)
      }, initializingTrailingTriviaWith: { buffer in
        _ = buffer.initialize(from: trailingTriviaPieces)
      })
    self = RawTokenSyntax(raw: raw)
  }

  /// Creates a missing `TokenSyntax` with the specified kind.
  /// If `text` is passed, it will be used to represent the missing token's text.
  /// If `text` is `nil`, the `kind`'s default text will be used.
  /// If that is also `nil`, the token will have empty text.
  public init(
    missing kind: RawTokenKind,
    text: SyntaxText? = nil,
    arena: __shared SyntaxArena
  ) {
    // FIXME: Allow creating a `RawSyntax.parsedToken()` with a string literal
    // for text. Currently it asserts that the string buffer is not contained
    // within the `arena`.
    self.init(
      materialized: kind,
      text: text ?? kind.defaultText ?? "",
      leadingTriviaPieces: [],
      trailingTriviaPieces: [],
      presence: .missing,
      arena: arena
    )
  }
}

/// Provides the `Syntax` type that a RawSyntax node represents.
/// All syntax nodes conform to this protocol.
/// We cannot add `SyntaxType` to `RawSyntaxNodeProtocol` because then
/// `RawSyntaxNodeProtocol` has associated type requirements, which limits the
/// places that `RawSyntaxNodeProtocol` can be used.
@_spi(RawSyntax)
public protocol RawSyntaxToSyntax: RawSyntaxNodeProtocol {
  associatedtype SyntaxType: SyntaxProtocol
}

@_spi(RawSyntax)
public extension RawSyntaxToSyntax {
  /// Realizes a `Syntax` node for this `RawSyntax` node.
  var syntax: SyntaxType {
    return Syntax(raw: raw).as(SyntaxType.self)!
  }
}
