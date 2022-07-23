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

/// RawXXXSyntax is a typed wrappeer of RawSyntax
@_spi(RawSyntax)
public protocol RawSyntaxNodeProtocol {
  static func isValid(syntaxKind: SyntaxKind) -> Bool
  var raw: RawSyntax { get }
  init?<T: RawSyntaxNodeProtocol>(_ other: T)
}

extension RawSyntaxNodeProtocol {
  @inlinable
  public var syntaxKind: SyntaxKind {
    raw.syntaxKind
  }

  /// Check if this instance can be cast to the specified syntax type.
  @inlinable
  public func `as`<Node: RawSyntaxNodeProtocol>(_: Node.Type) -> Node? {
    Node(self)
  }

  /// Check if this instance can be cast to the specified syntax type.
  @inlinable
  public func `is`<Node: RawSyntaxNodeProtocol>(_: Node.Type) -> Bool {
    Node.isValid(syntaxKind: self.syntaxKind)
  }
}

/// `RawSyntax` itself conforms to `RawSyntaxNodeProtocol`.
extension RawSyntax: RawSyntaxNodeProtocol {
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return true
  }
  public var raw: RawSyntax { self }

  @usableFromInline
  init(raw: RawSyntax) {
    self = raw
  }

  public init<T: RawSyntaxNodeProtocol>(_ other: T) {
    self.init(raw: other.raw)
  }
}

extension RawSyntax {
  public static func makeBlank(arena: SyntaxArena) -> RawSyntax {
    let raw = RawSyntax.makeEmptyLayout(arena: arena, kind: .unknown)
    return RawSyntax(raw: raw)
  }
}

@_spi(RawSyntax)
public struct RawTokenSyntax: RawSyntaxNodeProtocol {
  public static func isValid(syntaxKind: SyntaxKind) -> Bool {
    return syntaxKind == .token
  }

  public var raw: RawSyntax

  @usableFromInline
  init(raw: RawSyntax) {
    assert(Self.isValid(syntaxKind: raw.syntaxKind))
    self.raw = raw
  }

  public init?<Node: RawSyntaxNodeProtocol>(_ other: Node) {
    guard Self.isValid(syntaxKind: other.syntaxKind) else { return nil }
    self.init(raw: other.raw)
  }

  @inlinable
  public var tokenKind: TokenKind {
    return raw.tokenKind
  }

  @inlinable
  public var tokenText: StringRef {
    return raw.tokenText!
  }

  @inlinable
  public var isMissing: Bool {
    raw.byteLength == 0
  }

  @inlinable
  public static func makeParsed(
    arena: SyntaxArena,
    kind: TokenKind,
    wholeText: StringRef,
    tokenTextRange: Range<StringRef.Index>
  ) -> RawTokenSyntax {
    let raw = RawSyntax.makeParsedToken(
      arena: arena, kind: kind, wholeText: wholeText, tokenTextRange: tokenTextRange)
    return RawTokenSyntax(raw: raw)
  }

  public static func makeBlank(
    arena: SyntaxArena,
    tokenKind: TokenKind
  ) -> RawTokenSyntax {
    return makeParsed(
      arena: arena, kind: tokenKind, wholeText: "", tokenTextRange: 0..<0)
  }
}

