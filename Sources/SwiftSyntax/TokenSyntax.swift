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

// MARK: TokenSyntax

/// A Syntax node representing a single token.
public struct TokenSyntax: SyntaxProtocol, SyntaxHashable {
  public let _syntaxNode: Syntax

  @_spi(RawSyntax)
  public var tokenView: RawSyntaxTokenView {
    return raw.tokenView!
  }

  public init?<S: SyntaxProtocol>(_ node: S) {
    guard node.raw.kind == .token else { return nil }
    self._syntaxNode = node._syntaxNode
  }

  /// Creates a Syntax node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    precondition(data.raw.kind == .token)
    self._syntaxNode = Syntax(data)
  }

  public init(
    _ kind: TokenKind,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence
  ) {
    let data: SyntaxData = withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeMaterializedToken(
        kind: kind,
        leadingTrivia: leadingTrivia,
        trailingTrivia: trailingTrivia,
        presence: presence,
        tokenDiagnostic: nil,
        arena: arena
      )
      return SyntaxData.forRoot(raw)
    }
    self.init(data)
  }

  public var presence: SourcePresence {
    get {
      return tokenView.presence
    }
    set {
      self = TokenSyntax(data.withPresence(newValue, arena: SyntaxArena()))
    }
  }

  /// The text of the token as written in the source code, without any trivia.
  public var text: String {
    return tokenKind.text
  }

  public var rawTokenKind: RawTokenKind {
    return tokenView.rawKind
  }

  /// Returns a new TokenSyntax with its kind replaced
  /// by the provided token kind.
  public func withKind(_ tokenKind: TokenKind) -> TokenSyntax {
    guard raw.kind == .token else {
      fatalError("TokenSyntax must have token as its raw")
    }
    let arena = SyntaxArena()
    let newRaw = tokenView.withKind(tokenKind, arena: arena)
    let newData = data.replacingSelf(newRaw, arena: arena)
    return TokenSyntax(newData)
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this token.
  public var leadingTrivia: Trivia {
    get {
      return tokenView.formLeadingTrivia()
    }
    set {
      self = TokenSyntax(data.withLeadingTrivia(newValue, arena: SyntaxArena()))
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this token.
  public var trailingTrivia: Trivia {
    get {
      return tokenView.formTrailingTrivia()
    }
    set {
      self = TokenSyntax(data.withTrailingTrivia(newValue, arena: SyntaxArena()))
    }
  }

  /// The kind of token this node represents.
  public var tokenKind: TokenKind {
    get {
      return tokenView.formKind()
    }
    set {
      self = withKind(newValue)
    }
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  public var contentLength: SourceLength {
    return tokenView.contentLength
  }

  /// The length this node's leading trivia takes up spelled out in source.
  public var leadingTriviaLength: SourceLength {
    return tokenView.leadingTriviaLength
  }

  /// The length this node's trailing trivia takes up spelled out in source.
  public var trailingTriviaLength: SourceLength {
    return tokenView.trailingTriviaLength
  }

  /// The length of this node including all of its trivia.
  public var totalLength: SourceLength {
    return raw.totalLength
  }

  public static var structure: SyntaxNodeStructure {
    return .layout([])
  }

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    return nil
  }

  /// If the token has a lexical error, the type of the error.
  public var tokenDiagnostic: TokenDiagnostic? {
    return tokenView.tokenDiagnostic
  }
}

extension TokenSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(
      self,
      children: [
        "text": text,
        "leadingTrivia": leadingTrivia,
        "trailingTrivia": trailingTrivia,
        "tokenKind": tokenKind,
      ]
    )
  }
}
