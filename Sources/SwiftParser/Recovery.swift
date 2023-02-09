//===----------------------------------------------------------------------===//
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
      tokenConsumptionHandle: TokenConsumptionHandle(tokenKind: token)
    )
  }

  /// A `RecoveryConsumptionHandle` that will not eat any tokens but instead
  /// synthesize a missing token of kind `token`.
  @_spi(RawSyntax)
  public static func missing(_ token: RawTokenKind) -> RecoveryConsumptionHandle {
    return RecoveryConsumptionHandle(
      unexpectedTokens: 0,
      tokenConsumptionHandle: TokenConsumptionHandle(tokenKind: token, missing: true)
    )
  }
}

extension Parser.Lookahead {
  /// See `canRecoverTo` that takes 3 kinds.
  mutating func canRecoverTo(
    _ kind1: RawTokenKind,
    recoveryPrecedence: TokenPrecedence? = nil
  ) -> RecoveryConsumptionHandle? {
    return canRecoverTo(kind1, kind1, kind1, recoveryPrecedence: recoveryPrecedence)
  }

  /// See `canRecoverTo` that takes 3 kinds.
  mutating func canRecoverTo(
    _ kind1: RawTokenKind,
    _ kind2: RawTokenKind,
    recoveryPrecedence: TokenPrecedence? = nil
  ) -> RecoveryConsumptionHandle? {
    return canRecoverTo(kind1, kind2, kind1, recoveryPrecedence: recoveryPrecedence)
  }

  /// Tries eating tokens until it finds a token whose kind is `kind1`, `kind2` or `kind3`
  /// without skipping tokens that have a precedence that's higher than the
  /// lowest precedence in the expected kinds. If it found a token of `kind` in this way,
  /// returns `true`, otherwise `false`.
  /// If this method returns `true`, the parser probably wants to consume the
  /// tokens this lookahead skipped over to find `kind` by consuming
  /// `lookahead.tokensConsumed` as unexpected.
  mutating func canRecoverTo(
    _ kind1: RawTokenKind,
    _ kind2: RawTokenKind,
    _ kind3: RawTokenKind,
    recoveryPrecedence: TokenPrecedence? = nil
  ) -> RecoveryConsumptionHandle? {
    #if ENABLE_FUZZING_INTERSPECTION
    recordAlternativeTokenChoice(for: self.currentToken, choices: [kind1, kind2, kind3])
    #endif
    let initialTokensConsumed = self.tokensConsumed

    let recoveryPrecedence = recoveryPrecedence ?? min(TokenPrecedence(kind1), TokenPrecedence(kind2), TokenPrecedence(kind3))

    while !self.at(.eof) {
      if !recoveryPrecedence.shouldSkipOverNewlines, self.currentToken.isAtStartOfLine {
        break
      }
      let matchedKind: RawTokenKind?
      switch self.currentToken {
      case RawTokenKindMatch(kind1):
        matchedKind = kind1
      case RawTokenKindMatch(kind2):
        matchedKind = kind2
      case RawTokenKindMatch(kind3):
        matchedKind = kind3
      default:
        matchedKind = nil
      }
      if let matchedKind = matchedKind {
        let remapKind: RawTokenKind?
        if matchedKind.base == .keyword {
          remapKind = matchedKind
        } else {
          remapKind = nil
        }
        return RecoveryConsumptionHandle(
          unexpectedTokens: self.tokensConsumed - initialTokensConsumed,
          tokenConsumptionHandle: TokenConsumptionHandle(
            tokenKind: self.currentToken.rawTokenKind,
            remappedKind: remapKind
          )
        )
      }
      let currentTokenPrecedence = TokenPrecedence(self.currentToken.rawTokenKind)
      if currentTokenPrecedence >= recoveryPrecedence {
        break
      }
      self.consumeAnyToken()
      if let closingDelimiter = currentTokenPrecedence.closingTokenKind {
        guard self.canRecoverTo(closingDelimiter) != nil else {
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
  ) -> (matchedKind: Subset, handle: RecoveryConsumptionHandle)? {
    #if ENABLE_FUZZING_INTERSPECTION
    recordAlternativeTokenChoice(for: self.currentToken, choices: subset.allCases.map(\.rawTokenKind))
    #endif
    let initialTokensConsumed = self.tokensConsumed

    assert(!subset.allCases.isEmpty, "Subset must have at least one case")
    let recoveryPrecedence =
      recoveryPrecedence ?? subset.allCases.map({
        if let precedence = $0.precedence {
          return precedence
        } else {
          return TokenPrecedence($0.rawTokenKind)
        }
      }).min()!
    var loopProgress = LoopProgressCondition()
    while !self.at(.eof) && loopProgress.evaluate(self.currentToken) {
      if !recoveryPrecedence.shouldSkipOverNewlines,
        self.currentToken.isAtStartOfLine
      {
        break
      }
      if let (kind, handle) = self.at(anyIn: subset) {
        return (
          kind,
          RecoveryConsumptionHandle(
            unexpectedTokens: self.tokensConsumed - initialTokensConsumed,
            tokenConsumptionHandle: handle
          )
        )
      }
      let currentTokenPrecedence = TokenPrecedence(self.currentToken.rawTokenKind)
      if currentTokenPrecedence >= recoveryPrecedence {
        break
      }
      self.consumeAnyToken()
      if let closingDelimiter = currentTokenPrecedence.closingTokenKind {
        guard self.canRecoverTo(closingDelimiter) != nil else {
          break
        }
        self.eat(closingDelimiter)
      }
    }

    return nil
  }
}
