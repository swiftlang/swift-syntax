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
///
/// All source code of a syntax tree is represented by tokens – layout nodes
/// never contain any source code by themselves.
///
/// A token consists of leading ``Trivia``, i.e. whitespaces before the actual
/// token contents, the token’s `text` and trailing ``Trivia`` after the token’s
/// content.
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
    self._syntaxNode = Syntax(node)
  }

  /// Construct a new token with the given `kind`, `leadingTrivia`,
  /// `trailingTrivia` and `presence`.
  public init(
    _ kind: TokenKind,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence
  ) {
    let arena = SyntaxArena()
    let raw = RawSyntax.makeMaterializedToken(
      kind: kind,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence,
      tokenDiagnostic: nil,
      arena: arena
    )
    self = Syntax.forRoot(raw, rawNodeArena: RetainedSyntaxArena(arena)).cast(TokenSyntax.self)
  }

  /// Whether the token is present or missing.
  public var presence: SourcePresence {
    get {
      return tokenView.presence
    }
    set {
      self = Syntax(self).withPresence(newValue, arena: SyntaxArena()).cast(TokenSyntax.self)
    }
  }

  /// The text of the token as written in the source code, without any trivia.
  public var text: String {
    return tokenKind.text
  }

  @_spi(RawSyntax)
  public var rawText: SyntaxText {
    return tokenView.rawText
  }

  /// The leading trivia (spaces, newlines, etc.) associated with this token.
  public var leadingTrivia: Trivia {
    get {
      return tokenView.formLeadingTrivia()
    }
    set {
      self = Syntax(self).withLeadingTrivia(newValue, arena: SyntaxArena()).cast(TokenSyntax.self)
    }
  }

  /// The trailing trivia (spaces, newlines, etc.) associated with this token.
  public var trailingTrivia: Trivia {
    get {
      return tokenView.formTrailingTrivia()
    }
    set {
      self = Syntax(self).withTrailingTrivia(newValue, arena: SyntaxArena()).cast(TokenSyntax.self)
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
      self = Syntax(self).replacingSelf(newRaw, rawNodeArena: RetainedSyntaxArena(arena), allocationArena: arena).cast(TokenSyntax.self)
    }
  }

  @_spi(RawSyntax)
  public var rawTokenKind: RawTokenKind {
    return tokenView.rawKind
  }

  /// The length this node takes up spelled out in the source, excluding its
  /// leading or trailing trivia.
  public var trimmedLength: SourceLength {
    return tokenView.trimmedLength
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

  /// Whether the token text is an editor placeholder or not.
  public var isEditorPlaceholder: Bool {
    switch self.tokenKind {
    case .identifier(let text):
      return text.hasPrefix("<#") && text.hasSuffix("#>")
    default:
      return false
    }
  }

  /// A token by itself has no structure, so we represent its structure by an
  /// empty layout node.
  ///
  /// Every syntax node that contains a token will have a
  /// ``SyntaxNodeStructure/SyntaxChoice/token(_:)`` case for the token and those
  /// choices represent the token kinds the token might have.
  public static var structure: SyntaxNodeStructure {
    return .layout([])
  }

  /// If the token has a lexical error, the type of the error.
  public var tokenDiagnostic: TokenDiagnostic? {
    return tokenView.tokenDiagnostic
  }

  /// Checks if the current leaf syntax node can be cast to a different specified type.
  ///
  /// - Returns: `false` since the leaf node cannot be cast to a different specified type.
  ///
  /// - Note: This method overloads the general `is` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always fail.
  @available(*, deprecated, message: "This cast will always fail")
  public func `is`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> Bool {
    return false
  }

  /// Attempts to cast the current leaf syntax node to a different specified type.
  ///
  /// - Returns: `nil` since the leaf node cannot be cast to a different specified type.
  ///
  /// - Note: This method overloads the general `as` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always fail.
  @available(*, deprecated, message: "This cast will always fail")
  public func `as`<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S? {
    return nil
  }

  /// Force-casts the current leaf syntax node to a different specified type.
  ///
  /// - Returns: This method will always trigger a runtime crash and never return.
  ///
  /// - Note: This method overloads the general `cast` method and is marked as deprecated to produce a warning,
  ///         informing the user that the cast will always fail.
  /// - Warning: Invoking this method will lead to a fatal error.
  @available(*, deprecated, message: "This cast will always fail")
  public func cast<S: SyntaxProtocol>(_ syntaxType: S.Type) -> S {
    fatalError("\(Self.self) cannot be cast to \(S.self)")
  }
}

extension TokenSyntax: CustomReflectable {
  /// A custom mirror that shows the token properties in a simpler form, making
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
