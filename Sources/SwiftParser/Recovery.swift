//===------------------------- Recovery.swift -----------------------------===//
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

// MARK: Lookahead


/// After calling `consume(ifAnyFrom:)` we know which token we are positioned
/// at based on that function's return type. This handle allows consuming that
/// token.
@_spi(RawSyntax)
public struct RecoveryConsumptionHandle {
  var unexpectedTokens: Int
  var tokenConsumptionHandle: TokenConsumptionHandle

  @_spi(RawSyntax)
  public static func constant(_ token: RawTokenKind) -> RecoveryConsumptionHandle {
    return RecoveryConsumptionHandle(
      unexpectedTokens: 0,
      tokenConsumptionHandle: TokenConsumptionHandle(tokenKind: token))
  }
}

extension Parser.Lookahead {
  /// Tries eating tokens until it finds a token whose kind is in `kinds` or a
  /// contextual keyword with a text in `contextualKeywords` without skipping
  /// tokens that have a precedence that's higher than the lowest precedence in
  /// `kinds`. If it found a token of `kind` in this way, returns `true`,
  /// otherwise `false`.
  /// If this method returns `true`, the parser probably wants to consume the
  /// tokens this lookahead skipped over to find `kind` by consuming
  /// `lookahead.tokensConsumed` as unexpected.
  mutating func canRecoverTo(
    _ kinds: [RawTokenKind],
    contextualKeywords: [SyntaxText] = [],
    recoveryPrecedence: TokenPrecedence? = nil
  ) -> RecoveryConsumptionHandle? {
    let initialTokensConsumed = self.tokensConsumed

    var precedences = kinds.map(TokenPrecedence.init)
    if !contextualKeywords.isEmpty {
      precedences += [TokenPrecedence(.identifier), TokenPrecedence(.contextualKeyword)]
    }
    let recoveryPrecedence = recoveryPrecedence ?? precedences.min()!

    while !self.at(.eof) {
      if !recoveryPrecedence.shouldSkipOverNewlines,
          self.currentToken.isAtStartOfLine {
        break
      }
      if self.at(any: kinds, contextualKeywords: contextualKeywords) {
        return RecoveryConsumptionHandle(
          unexpectedTokens: self.tokensConsumed - initialTokensConsumed,
          tokenConsumptionHandle: TokenConsumptionHandle(
            tokenKind: self.currentToken.tokenKind,
            remappedKind: self.at(any: [], contextualKeywords: contextualKeywords) ? .contextualKeyword : nil
          )
        )
      }
      let currentTokenPrecedence = TokenPrecedence(self.currentToken.tokenKind)
      if currentTokenPrecedence >= recoveryPrecedence {
        break
      }
      self.consumeAnyToken()
      if let closingDelimiter = currentTokenPrecedence.closingTokenKind {
        guard self.canRecoverTo([closingDelimiter]) != nil else {
          break
        }
        self.eat(closingDelimiter)
      }
    }

    return nil
  }

  /// Checks if we can reach a token in `subset` by skipping tokens that have
  /// a precedence that have a lower ``TokenPrecedence`` than the minimum
  /// precedence of a token in that subset.
  /// If so, return the token that we can recover to and a handle that can be
  /// used to consume the unexpected tokens and the token we recovered to.
  mutating func canRecoverTo<Subset: RawTokenKindSubset>(
    anyIn subset: Subset.Type,
    recoveryPrecedence: TokenPrecedence? = nil
  ) -> (Subset, RecoveryConsumptionHandle)? {
    let initialTokensConsumed = self.tokensConsumed

    assert(!subset.allCases.isEmpty, "Subset must have at least one case")
    let recoveryPrecedence = recoveryPrecedence ?? subset.allCases.map({
      if let precedence = $0.precedence {
        return precedence
      } else {
        return TokenPrecedence($0.rawTokenKind)
      }
    }).min()!
    while !self.at(.eof) {
      if !recoveryPrecedence.shouldSkipOverNewlines,
          self.currentToken.isAtStartOfLine {
        break
      }
      if let (kind, handle) = self.at(anyIn: subset) {
        return (kind, RecoveryConsumptionHandle(
          unexpectedTokens: self.tokensConsumed - initialTokensConsumed,
          tokenConsumptionHandle: handle
        ))
      }
      let currentTokenPrecedence = TokenPrecedence(self.currentToken.tokenKind)
      if currentTokenPrecedence >= recoveryPrecedence {
        break
      }
      self.consumeAnyToken()
      if let closingDelimiter = currentTokenPrecedence.closingTokenKind {
        guard self.canRecoverTo([closingDelimiter]) != nil else {
          break
        }
        self.eat(closingDelimiter)
      }
    }

    return nil
  }
}

