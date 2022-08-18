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
    return raw.rawTokenKind
  }

  public var tokenText: SyntaxText {
    return raw.rawTokenText
  }

  public var byteLength: Int {
    return raw.byteLength
  }

  public var presence: SourcePresence {
    raw.presence
  }

  public var isMissing: Bool {
    presence == .missing
  }

  public var leadingTriviaPieces: [RawTriviaPiece] {
    raw.tokenLeadingRawTriviaPieces
  }

  public var trailingTriviaPieces: [RawTriviaPiece] {
    raw.tokenTrailingRawTriviaPieces
  }

  /// Creates a `RawTokenSyntax`. `wholeText` must be managed by the same
  /// `arena`. `textRange` is a range of the token text in `wholeText`.
  public init(
    kind: RawTokenKind,
    wholeText: SyntaxText,
    textRange: Range<SyntaxText.Index>,
    arena: __shared SyntaxArena
  ) {
    assert(arena.contains(text: wholeText),
           "token text must be managed by the arena")
    let raw = RawSyntax.parsedToken(
      kind: kind, wholeText: wholeText, textRange: textRange, arena: arena)
    self = RawTokenSyntax(raw: raw)
  }

  /// Creates a `RawTokenSyntax`. `text` and trivia must be managed by the same
  /// `arena`.
  public init(
    kind: RawTokenKind,
    text: SyntaxText,
    leadingTriviaPieces: [RawTriviaPiece],
    trailingTriviaPieces: [RawTriviaPiece],
    arena: __shared SyntaxArena
  ) {
    assert(arena.contains(text: text), "token text must be managed by the arena")
    let totalTriviaCount = leadingTriviaPieces.count + trailingTriviaPieces.count
    let buffer = arena.allocateRawTriviaPieceBuffer(count: totalTriviaCount)
    var byteLength = text.count
    if totalTriviaCount != 0 {
      var ptr = buffer.baseAddress!
      for piece in leadingTriviaPieces + trailingTriviaPieces {
        assert(piece.storedText.map(arena.contains(text:)) ?? true,
               "trivia text must be managed by the arena")
        byteLength += piece.byteLength
        ptr.initialize(to: piece)
        ptr = ptr.advanced(by: 1)
      }
    }
    let raw = RawSyntax.materializedToken(
      kind: kind, text: text, triviaPieces: RawTriviaPieceBuffer(buffer),
      numLeadingTrivia: numericCast(leadingTriviaPieces.count),
      byteLength: numericCast(byteLength),
      arena: arena)
    self = RawTokenSyntax(raw: raw)
  }

  /// Creates a missing `TokenSyntax` with the specified kind.
  public init(missing kind: RawTokenKind, arena: __shared SyntaxArena) {
    self.init(
      kind: kind, text: "", leadingTriviaPieces: [], trailingTriviaPieces: [],
      arena: arena)
  }
}

