//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxNodes.swift - Syntax Node definitions -------------===//
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

// MARK: UnknownSyntax

/// A wrapper around a raw Syntax layout.
public struct UnknownSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Convert the given `Syntax` node to an `UnknownSyntax` if possible. Return
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unknown else { return nil }
    self._syntaxNode = syntax
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public func _validateLayout() {
    // We are verifying an unknown node. Since we don’t know anything about it
    // we need to assume it’s valid.
  }

  /// Creates an `UnknownSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unknown)
    self._syntaxNode = Syntax(data)
  }
}

extension UnknownSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [:])
  }
}

// MARK: TokenSyntax

/// A Syntax node representing a single token.
public struct TokenSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TokenSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .token else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a Syntax node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .token)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public func _validateLayout() {
    /// A token is always valid as it has no children. Nothing to do here.
  }

  public var presence: SourcePresence {
    return raw.presence
  }

  /// The text of the token as written in the source code.
  public var text: String {
    return tokenKind.text
  }

  /// Returns a new TokenSyntax with its kind replaced
  /// by the provided token kind.
  public func withKind(_ tokenKind: TokenKind) -> TokenSyntax {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    let newRaw = RawSyntax.createAndCalcLength(kind: tokenKind,
      leadingTrivia: raw.formLeadingTrivia()!, trailingTrivia: raw.formTrailingTrivia()!,
      presence: raw.presence)
    let newData = data.replacingSelf(newRaw)
    return TokenSyntax(newData)
  }

  /// Returns a new TokenSyntax with its leading trivia replaced
  /// by the provided trivia.
  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> TokenSyntax {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    return TokenSyntax(data.withLeadingTrivia(leadingTrivia))
  }

  /// Returns a new TokenSyntax with its trailing trivia replaced
  /// by the provided trivia.
  public func withTrailingTrivia(_ trailingTrivia: Trivia) -> TokenSyntax {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    return TokenSyntax(data.withTrailingTrivia(trailingTrivia))
  }

  /// Returns a new TokenSyntax with its leading trivia removed.
  public func withoutLeadingTrivia() -> TokenSyntax {
    return withLeadingTrivia([])
  }

  /// Returns a new TokenSyntax with its trailing trivia removed.
  public func withoutTrailingTrivia() -> TokenSyntax {
    return withTrailingTrivia([])
  }

  /// Returns a new TokenSyntax with all trivia removed.
  public func withoutTrivia() -> TokenSyntax {
    return withoutLeadingTrivia().withoutTrailingTrivia()
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this token.
  public var leadingTrivia: Trivia {
    get {
      return raw.formTokenLeadingTrivia()!
    }
    set {
      self = withLeadingTrivia(newValue)
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this token.
  public var trailingTrivia: Trivia {
    get {
      return raw.formTokenTrailingTrivia()!
    }
    set {
      self = withTrailingTrivia(newValue)
    }
  }

  /// The kind of token this node represents.
  public var tokenKind: TokenKind {
    get {
      return raw.formTokenKind()!
    }
    set {
      self = withKind(newValue)
    }
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  public var contentLength: SourceLength {
    return raw.tokenContentLength
  }

  /// The length this node's leading trivia takes up spelled out in source.
  public var leadingTriviaLength: SourceLength {
    return raw.tokenLeadingTriviaLength
  }

  /// The length this node's trailing trivia takes up spelled out in source.
  public var trailingTriviaLength: SourceLength {
    return raw.tokenTrailingTriviaLength
  }

  /// The length of this node including all of its trivia.
  public var totalLength: SourceLength {
    return raw.totalLength
  }
}

extension TokenSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "text": text,
      "leadingTrivia": leadingTrivia,
      "trailingTrivia": trailingTrivia,
      "tokenKind": tokenKind,
    ])
  }
}
