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
  /// The ``Syntax`` node that provides the underlying data.
  ///
  /// Don’t access this. Use `Syntax(token)` instead.
  public let _syntaxNode: Syntax

  /// The ``RawSyntaxTokenView`` of this token that allows accessing raw
  /// properties of the token.
  @_spi(RawSyntax)
  public var tokenView: RawSyntaxTokenView {
    return raw.tokenView!
  }

  /// If `node` is a token, return the ``TokenSyntax`` that represents it.
  /// Otherwise, return `nil`.
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

  /// Construct a new token with the given `kind`, `leadingTrivia`,
  /// `trailingTrivia` and `presence`.
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

  /// Whether the token is present or missing.
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
      guard raw.kind == .token else {
        fatalError("TokenSyntax must have token as its raw")
      }
      let arena = SyntaxArena()
      let newRaw = tokenView.withKind(newValue, arena: arena)
      let newData = data.replacingSelf(newRaw, arena: arena)
      self = TokenSyntax(newData)
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

  /// A token by itself has no structure, so we represent its structure by an
  /// empty layout node.
  ///
  /// Every syntax node that contains a token will have a
  /// ``SyntaxNodeStructure.SyntaxChoices.choices`` case for the token and those
  /// choices represent the token kinds the token might have.
  public static var structure: SyntaxNodeStructure {
    return .layout([])
  }

  /// If the token has a lexical error, the type of the error.
  public var tokenDiagnostic: TokenDiagnostic? {
    return tokenView.tokenDiagnostic
  }
}

extension TokenSyntax: CustomReflectable {
  /// A custom mirror that shows the token properties in a better for, making
  /// the debug output of the token easier to read.
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
