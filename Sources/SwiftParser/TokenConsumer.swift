//===---------------------- TokenConsumer.swift ---------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax

/// A type that consumes  instances of `TokenSyntax`.
public protocol TokenConsumer {
  associatedtype Token
  /// The current token syntax being examined by the consumer
  @_spi(RawSyntax)
  var currentToken: Lexer.Lexeme { get }
  /// Whether the current token matches the given kind.
  mutating func consumeAnyToken() -> Token

  /// Consume the current token and change its token kind to `remappedTokenKind`.
  mutating func consumeAnyToken(remapping remappedTokenKind: RawTokenKind) -> Token

  /// Synthesize a missing token with `kind`.
  /// If `text` is not `nil`, use it for the token's text, otherwise use the token's default text.
  @_spi(RawSyntax)
  mutating func missingToken(_ kind: RawTokenKind, text: SyntaxText?) -> Token

  /// Return the lexeme that will be parsed next.
  func peek() -> Lexer.Lexeme

  func lookahead() -> Parser.Lookahead
}

// MARK: Checking if we are at one specific token (`at`)

/// After calling `consume(ifAnyFrom:)` we know which token we are positioned
/// at based on that function's return type. This handle allows consuming that
/// token.
struct TokenConsumptionHandle {
  /// The kind that is expected to be consumed if the handle is eaten.
  var tokenKind: RawTokenKind
  /// When not `nil`, the token's kind will be remapped to this kind when consumed.
  var remappedKind: RawTokenKind?
}

extension TokenConsumer {
  /// Returns whether the the current token is of kind `kind` and satisfies
  /// `condition`.
  ///
  /// - Parameter kind: The kind to test for.
  /// - Parameter condition: An additional condition that must be satisfied for
  ///                        this function to return `true`.
  /// - Returns: `true` if the given `kind` matches the current token's kind.
  public func at(
    _ kind: RawTokenKind,
    where condition: (Lexer.Lexeme) -> Bool = { _ in true}
  ) -> Bool {
    return self.currentToken.tokenKind == kind && condition(self.currentToken)
  }

  /// Returns whether the current token is a contextual keyword with the given `name`.
  @_spi(RawSyntax)
  public func atContextualKeyword(_ name: SyntaxText) -> Bool {
    return self.currentToken.isContextualKeyword(name)
  }

  /// Returns whether the current token is an operator with the given `name`.
  @_spi(RawSyntax)
  public func atContextualPunctuator(_ name: SyntaxText) -> Bool {
    return self.currentToken.isContextualPunctuator(name)
  }


  /// Returns whether the kind of the current token is any of the given
  /// kinds or a contextual keyword with text in `contextualKeywords` and
  /// additionally satisfies `condition`.
  ///
  /// - Parameter kinds: The kinds to test for.
  /// - Parameter contextualKeywords: Contextual keywords that are also accepted.
  /// - Parameter condition: An additional condition that must be satisfied for
  ///                        this function to return `true`.
  /// - Returns: `true` if the current token's kind is in `kinds`.
  @_spi(RawSyntax)
  public func at(
    any kinds: [RawTokenKind],
    contextualKeywords: [SyntaxText] = [],
    where condition: (Lexer.Lexeme) -> Bool = { _ in true }
  ) -> Bool {
    if kinds.contains(self.currentToken.tokenKind) && condition(self.currentToken) {
      return true
    }
    switch self.currentToken.tokenKind {
    case .identifier, .contextualKeyword:
      return contextualKeywords.contains(self.currentToken.tokenText) && condition(self.currentToken)
    default:
      return false
    }
  }

  /// Checks whether the parser is currently positioned at any token in `Subset`.
  /// If this is the case, return the `Subset` case that the parser is positioned in
  /// as well as a handle to consume that token.
  func at<Subset: RawTokenKindSubset>(anyIn subset: Subset.Type) -> (Subset, TokenConsumptionHandle)? {
    if let matchedKind = Subset(lexeme: self.currentToken) {
      return (matchedKind, TokenConsumptionHandle(
        tokenKind: matchedKind.rawTokenKind,
        remappedKind: matchedKind.remappedKind
      ))
    }
    return nil
  }

  /// Eat a token that we know we are currently positioned at, based on `at(anyIn:)`.
  mutating func eat(_ handle: TokenConsumptionHandle) -> Token {
    assert(self.at(handle.tokenKind))
    if let remappedKind = handle.remappedKind {
      return consumeAnyToken(remapping: remappedKind)
    } else {
      return consumeAnyToken()
    }
  }
}

// MARK: Consuming tokens (`consume`)

extension TokenConsumer {
  /// Examines the current token and consumes it if its kind matches the
  /// given `TokenKind` and additionally satisfies `condition`. If a token was
  /// consumed, the result is that token, else the result is `nil`.
  ///
  /// - Parameter kind: The kind of token to consume.
  /// - Parameter condition: An additional condition that must be satisfied for
  ///                        the token to be consumed.
  /// - Returns: A token of the given kind if one was consumed, else `nil`.
  @_spi(RawSyntax)
  public mutating func consume(
    if kind: RawTokenKind,
    remapping: RawTokenKind? = nil,
    where condition: (Lexer.Lexeme) -> Bool = { _ in true}
  ) -> Token? {
    if self.at(kind, where: condition) {
      if let remapping = remapping {
        return self.consumeAnyToken(remapping: remapping)
      } else {
        return self.consumeAnyToken()
      }
    }
    return nil
  }

  /// Consumes and returns the current token is a contextual keyword with the given `name`.
  @_spi(RawSyntax)
  public mutating func consumeIfContextualKeyword(_ name: SyntaxText) -> Token? {
    if self.atContextualKeyword(name) {
      return self.consumeAnyToken(remapping: .contextualKeyword)
    }
    return nil
  }

  /// Consumes and returns the current token is an operator with the given `name`.
  @_spi(RawSyntax)
  public mutating func consumeIfContextualPunctuator(_ name: SyntaxText) -> Token? {
    if self.atContextualPunctuator(name) {
      return self.consumeAnyToken()
    }
    return nil
  }

  /// Examines the current token and consumes it if is any of the given
  /// kinds or a contextual keyword with text in `contextualKeywords` and
  /// additionally satisfies `condition`.
  ///
  /// - Parameter kind: The kinds of token to consume.
  /// - Parameter contextualKeywords: Contextual keywords that are also accepted.
  /// - Parameter condition: An additional condition that must be satisfied for
  ///                        the token to be consumed.
  /// - Returns: A token of the given kind if one was consumed, else `nil`.
  @_spi(RawSyntax)
  public mutating func consume(
    ifAny kinds: [RawTokenKind],
    contextualKeywords: [SyntaxText] = [],
    where condition: (Lexer.Lexeme) -> Bool = { _ in true }
  ) -> Token? {
    if self.at(any: kinds, contextualKeywords: contextualKeywords, where: condition) {
      return self.consumeAnyToken()
    }
    return nil
  }

  /// If the current token has `kind1` and is followed by `kind2` consume both
  /// tokens and return them. Otherwise, return `nil`.
  @_spi(RawSyntax)
  public mutating func consume(if kind1: RawTokenKind, followedBy kind2: RawTokenKind) -> (Token, Token)? {
    if self.at(kind1) && self.peek().tokenKind == kind2 {
      return (consumeAnyToken(), consumeAnyToken())
    } else {
      return nil
    }
  }

  /// If the current token satisfies `condition1` and the next token satisfies
  /// `condition2` consume both tokens and return them.
  /// Otherwise, return `nil`.
  @_spi(RawSyntax)
  public mutating func consume(
    if condition1: (Lexer.Lexeme) -> Bool,
    followedBy condition2: (Lexer.Lexeme) -> Bool
  ) -> (Token, Token)? {
    if condition1(self.currentToken) && condition2(self.peek()) {
      return (consumeAnyToken(), consumeAnyToken())
    } else {
      return nil
    }
  }
}

// MARK: Expecting Tokens (`expect`)

extension TokenConsumer {
  /// If the current token matches the given `kind` and additionally satisfies
  /// `condition`, consume it. Othwerise, synthesize a missing token of the
  /// given `kind`.
  ///
  /// This method does not try to eat unexpected until it finds the token of the specified `kind`.
  /// In the parser, `expect` should be preferred.
  ///
  /// - Parameter kind: The kind of token to consume.
  /// - Parameter condition: An additional condition that must be satisfied for
  ///                        the token to be consumed.
  /// - Returns: A token of the given kind.
  public mutating func expectWithoutRecovery(
    _ kind: RawTokenKind,
    where condition: (Lexer.Lexeme) -> Bool = { _ in true }
  ) -> Token {
    if let token = self.consume(if: kind, where: condition) {
      return token
    } else {
      return missingToken(kind, text: nil)
    }
  }

  /// If the current token is a contextual keyword with the given `name`,
  /// consume it. Othwerise, synthesize a missing contextual keyword with that
  /// `name`.
  ///
  /// This method does not try to eat unexpected until it finds the token of the specified `kind`.
  /// In the parser, `expect` should be preferred.
  @_spi(RawSyntax)
  public mutating func expectContextualKeywordWithoutRecovery(_ name: SyntaxText) -> Token {
    if let token = self.consumeIfContextualKeyword(name) {
      return token
    } else {
      return missingToken(.contextualKeyword, text: name)
    }
  }
}


// MARK: Convenience functions

extension TokenConsumer {
  mutating func expectIdentifierWithoutRecovery() -> Token {
    if let (_ , handle) = self.at(anyIn: IdentifierTokens.self) {
      return self.eat(handle)
    }
    return missingToken(.identifier, text: nil)
  }

  mutating func expectIdentifierOrRethrowsWithoutRecovery() -> Token {
    if let (_ , handle) = self.at(anyIn: IdentifierOrRethrowsTokens.self) {
      return self.eat(handle)
    }
    return missingToken(.identifier, text: nil)
  }
}
