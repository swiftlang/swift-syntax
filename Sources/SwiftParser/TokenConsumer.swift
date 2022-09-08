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

import SwiftSyntax

/// A type that consumes  instances of `TokenSyntax`.
public protocol TokenConsumer {
  associatedtype Token
  /// The current token syntax being examined by the consumer
  @_spi(RawSyntax)
  var currentToken: Lexer.Lexeme { get }
  /// Whether the current token matches the given kind.
  mutating func consumeAnyToken() -> Token
  mutating func missingToken(_ kind: RawTokenKind) -> Token
  /// Retrieves the token following the current token without consuming it.
  mutating func peek() -> Lexer.Lexeme
}

// MARK: Checking if we are at one specific token

extension TokenConsumer {
  /// Returns whether the kind of the current token matches the given
  /// kind without consuming the current token.
  ///
  /// - Parameter kind: The kind to test for.
  /// - Returns: `true` if the given `kind` matches the current token's kind.
  public func at(_ kind: RawTokenKind) -> Bool {
    return self.currentToken.tokenKind == kind
  }

  /// Returns whether the kind of the current token is any of the given
  /// kinds without consuming the current token.
  ///
  /// - Parameter kinds: The kinds to test for.
  /// - Returns: `true` if the current token's kind is in `kinds`.
  public func at(any kinds: [RawTokenKind]) -> Bool {
    return kinds.contains(self.currentToken.tokenKind)
  }

  /// Checks whether the parser is currently positioned at any token in `Subset`.
  /// If this is the case, return the `Subset` case that the parser is positioned in
  /// as well as a handle to consume that token.
  func at<Subset: RawTokenKindSubset>(anyIn subset: Subset.Type) -> (Subset, TokenConsumptionHandle)? {
    for kind in Subset.allCases {
      if self.at(kind.rawTokenKind) && kind.accepts(lexeme: currentToken) {
        return (kind, TokenConsumptionHandle(tokenKind: kind.rawTokenKind))
      }
    }
    return nil
  }

  /// Eat a token that we know we are currently positioned at, based on `at(anyIn:)`.
  mutating func eat(_ handle: TokenConsumptionHandle) -> Token {
    return consume(if: handle.tokenKind)!
  }
}

// MARK: Consuming Tokens with Lookahead

extension TokenConsumer {
  /// If the current token has `kind1` and is followed by `kind2` consume both tokens and return them.
  /// Otherwise, return `nil`.
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

// MARK: Consuming tokens

/// After calling `consume(ifAnyFrom:)` we know which token we are positioned
/// at based on that function's return type. This handle allows consuming that
/// token.
struct TokenConsumptionHandle {
  /// The kind that is expected to be consumed if the handle is eaten.
  var tokenKind: RawTokenKind
}

extension TokenConsumer {
  /// Examines the current token and consumes it if its kind matches the
  /// given `TokenKind` and additionally satisfies `condition`. If a token was
  /// consumed, the result is that token, else the result is `nil`.
  ///
  /// - Parameter kind: The kind of token to consume.
  /// - Returns: A token of the given kind if one was consumed, else `nil`.
  @_spi(RawSyntax)
  public mutating func consume(
    if kind: RawTokenKind,
    where condition: (Lexer.Lexeme) -> Bool = { _ in true}
  ) -> Token? {
    if self.at(kind) && condition(self.currentToken) {
      return self.consumeAnyToken()
    }
    return nil
  }

  /// Examines the current token and consumes it if its kind is in `kinds` and
  /// additionally satisfies `condition`. If a token was consumed, the result is
  /// that token, else the result is `nil`.
  ///
  /// - Parameter kind: The kinds of token to consume.
  /// - Returns: A token of the given kind if one was consumed, else `nil`.
  public mutating func consume(
    ifAny kinds: RawTokenKind...,
    where condition: (Lexer.Lexeme) -> Bool = { _ in true }
  ) -> Token? {
    for kind in kinds {
      if let consumed = self.consume(if: kind, where: condition) {
        return consumed
      }
    }
    return nil
  }
}

// MARK: Expecting Tokens

extension TokenConsumer {
  /// Attempts to consume a token of the given kind, synthesizing a missing
  /// token if the current token's kind does not match.
  ///
  /// This method does not try to eat unexpected until it finds the token of the specified `kind`.
  /// In general, `expect` or `expectAny` should be preferred.
  ///
  /// - Parameter kind: The kind of token to consume.
  /// - Returns: A token of the given kind.
  public mutating func expectWithoutLookahead(
    _ kind: RawTokenKind,
    where condition: (Lexer.Lexeme) -> Bool = { _ in true }
  ) -> Token {
    if self.currentToken.tokenKind == kind {
      if condition(self.currentToken) {
        return self.consumeAnyToken()
      } else {
        return self.consumeAnyToken()
      }
    }
    return missingToken(kind)
  }
}
