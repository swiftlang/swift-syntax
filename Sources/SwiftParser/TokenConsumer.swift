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
}

// MARK: Consuming Tokens

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
  public func atAny(_ kind: [RawTokenKind]) -> Bool {
    return kind.contains(self.currentToken.tokenKind)
  }

  /// Examines the current token and consumes it if its kind matches the
  /// given `TokenKind`. If a token was consumed, the result is that token, else
  /// the result is `nil`.
  ///
  /// - Parameter kind: The kind of token to consume.
  /// - Returns: A token of the given kind if one was consumed, else `nil`.
  public mutating func consume(if kind: RawTokenKind) -> Token? {
    guard self.at(kind) else {
      return nil
    }
    return self.consumeAnyToken()
  }

  /// Examines the current token and consumes it if its kind is in `kinds`. If a
  /// token was consumed, the result is that token, else the result is `nil`.
  ///
  /// - Parameter kind: The kinds of token to consume.
  /// - Returns: A token of the given kind if one was consumed, else `nil`.
  public mutating func consume(ifAny kinds: RawTokenKind...) -> Token? {
    for kind in kinds {
      if let consumed = self.consume(if: kind) {
        return consumed
      }
    }
    return nil
  }

  /// Consumes the current token, and asserts that the kind of token that was
  /// consumed matches the given kind.
  ///
  /// If the token kind did not match, this function will abort. It is useful
  /// to insert structural invariants during parsing.
  ///
  /// - Parameter kind: The kind of token to consume.
  /// - Returns: A token of the given kind.
  public mutating func eat(_ kind: RawTokenKind) -> Token {
    return self.consume(if: kind)!
  }
}
