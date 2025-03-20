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

#if compiler(>=6)
@_spi(RawSyntax) internal import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

// MARK: Lookahead

/// After calling `consume(ifAnyFrom:)` we know which token we are positioned
/// at based on that function's return type. This handle allows consuming that
/// token.
struct RecoveryConsumptionHandle {
  var unexpectedTokens: Int
  var tokenConsumptionHandle: TokenConsumptionHandle

  fileprivate init(unexpectedTokens: Int, tokenConsumptionHandle: TokenConsumptionHandle) {
    self.unexpectedTokens = unexpectedTokens
    self.tokenConsumptionHandle = tokenConsumptionHandle
  }

  /// A `RecoveryConsumptionHandle` that doesn't skip over any unexpected tokens
  /// and consumes a token matching `spec`.
  static func constant(_ spec: TokenSpec) -> RecoveryConsumptionHandle {
    return RecoveryConsumptionHandle(
      unexpectedTokens: 0,
      tokenConsumptionHandle: TokenConsumptionHandle(spec: spec)
    )
  }

  /// A `RecoveryConsumptionHandle` that doesn't skip over any unexpected tokens
  /// and consumes `handle`.
  static func noRecovery(_ handle: TokenConsumptionHandle) -> RecoveryConsumptionHandle {
    return RecoveryConsumptionHandle(
      unexpectedTokens: 0,
      tokenConsumptionHandle: handle
    )
  }

  /// A `RecoveryConsumptionHandle` that will not eat any tokens but instead
  /// synthesize a missing token of kind `token`.
  static func missing(_ spec: TokenSpec) -> RecoveryConsumptionHandle {
    return RecoveryConsumptionHandle(
      unexpectedTokens: 0,
      tokenConsumptionHandle: TokenConsumptionHandle(spec: spec, tokenIsMissing: true)
    )
  }
}

extension Parser.Lookahead {
  /// Tries eating tokens until it finds a token that matches one of `specs`
  /// without skipping tokens that have a precedence that's higher than the
  /// lowest precedence in the expected kinds. If it found a token in this way,
  /// returns `true`, otherwise `false`.
  /// If this method returns `true`, the parser probably wants to consume the
  /// tokens this lookahead skipped over to find `kind` by consuming
  /// `lookahead.tokensConsumed` as unexpected.
  mutating func canRecoverTo(
    _ specs: [TokenSpec],
    recursionDepth: Int = 1
  ) -> RecoveryConsumptionHandle? {
    if recursionDepth > 10 {
      // `canRecoverTo` calls itself recursively if it finds a nested opening token, eg. when calling `canRecoverTo` on
      // `{{{`. To avoid stack overflowing, limit the number of nested `canRecoverTo` calls we make. Since returning a
      // recovery handle from this function only improves error recovery but is not necessary for correctness, bailing
      // from recovery is safe.
      // The value 10 was chosen fairly arbitrarily. It seems unlikely that we get useful recovery if we find more than
      // 10 nested open and closing delimiters.
      return nil
    }
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.currentToken, choices: specs)
    }
    #endif
    let initialTokensConsumed = self.tokensConsumed

    let recoveryPrecedence = specs.map(\.recoveryPrecedence).min()!
    let shouldSkipOverNewlines = recoveryPrecedence.shouldSkipOverNewlines && specs.allSatisfy(\.allowAtStartOfLine)

    while !self.at(.endOfFile) {
      if !shouldSkipOverNewlines, self.atStartOfLine {
        break
      }
      let matchedSpec = specs.first { spec in
        spec ~= self.currentToken
      }
      if let matchedSpec {
        return RecoveryConsumptionHandle(
          unexpectedTokens: self.tokensConsumed - initialTokensConsumed,
          tokenConsumptionHandle: TokenConsumptionHandle(spec: matchedSpec)
        )
      }
      let currentTokenPrecedence = TokenPrecedence(self.currentToken)
      if currentTokenPrecedence >= recoveryPrecedence {
        break
      }
      if !currentTokenPrecedence.closingTokenKinds.isEmpty {
        let closingDelimiterSpecs = currentTokenPrecedence.closingTokenKinds.map { TokenSpec($0) }
        let canCloseAtSameLine: Int? = self.withLookahead { lookahead in
          var tokensToSkip = 0
          while !lookahead.at(.endOfFile), !lookahead.currentToken.isAtStartOfLine {
            tokensToSkip += 1
            if lookahead.at(closingDelimiterSpecs) {
              return tokensToSkip
            } else {
              lookahead.consumeAnyToken()
            }
          }
          return nil
        }
        if let tokensToSkip = canCloseAtSameLine {
          for _ in 0..<tokensToSkip {
            self.consumeAnyToken()
          }
          continue
        }
        self.consumeAnyToken()
        guard self.canRecoverTo(closingDelimiterSpecs, recursionDepth: recursionDepth + 1) != nil else {
          continue
        }
        self.eat(closingDelimiterSpecs)
      } else {
        self.consumeAnyToken()
      }
    }

    return nil
  }

  /// Tries eating tokens until it finds a token that matches one of `specs`
  /// without skipping tokens that have a precedence that's higher than the
  /// lowest precedence in the expected kinds. If it found a token in this way,
  /// returns `true`, otherwise `false`.
  /// If this method returns `true`, the parser probably wants to consume the
  /// tokens this lookahead skipped over to find `kind` by consuming
  /// `lookahead.tokensConsumed` as unexpected.
  mutating func canRecoverTo(
    _ specs: TokenSpec...,
    recursionDepth: Int = 1
  ) -> RecoveryConsumptionHandle? {
    return self.canRecoverTo(specs, recursionDepth: recursionDepth)
  }

  /// Checks if we can reach a token in `subset` by skipping tokens that have
  /// a precedence that have a lower ``TokenPrecedence`` than the minimum
  /// precedence of a token in that subset.
  /// If so, return the token that we can recover to and a handle that can be
  /// used to consume the unexpected tokens and the token we recovered to.
  mutating func canRecoverTo<SpecSet: TokenSpecSet>(
    anyIn specSet: SpecSet.Type,
    overrideRecoveryPrecedence: TokenPrecedence? = nil
  ) -> (match: SpecSet, handle: RecoveryConsumptionHandle)? {
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.currentToken, choices: specSet.allCases.map(\.spec))
    }
    #endif
    let initialTokensConsumed = self.tokensConsumed

    if specSet.allCases.isEmpty {
      return nil
    }

    let recoveryPrecedence =
      overrideRecoveryPrecedence ?? specSet.allCases.map({
        return $0.spec.recoveryPrecedence
      }).min()!
    var loopProgress = LoopProgressCondition()
    while !self.at(.endOfFile) && self.hasProgressed(&loopProgress) {
      if !recoveryPrecedence.shouldSkipOverNewlines, self.atStartOfLine {
        break
      }
      if let (kind, handle) = self.at(anyIn: specSet) {
        return (
          kind,
          RecoveryConsumptionHandle(
            unexpectedTokens: self.tokensConsumed - initialTokensConsumed,
            tokenConsumptionHandle: handle
          )
        )
      }
      let currentTokenPrecedence = TokenPrecedence(self.currentToken)
      if currentTokenPrecedence >= recoveryPrecedence {
        break
      }
      self.consumeAnyToken()
      if !currentTokenPrecedence.closingTokenKinds.isEmpty {
        let closingDelimiterSpecs = currentTokenPrecedence.closingTokenKinds.map { TokenSpec($0) }
        guard self.canRecoverTo(closingDelimiterSpecs) != nil else {
          break
        }
        self.eat(closingDelimiterSpecs)
      }
    }

    return nil
  }
}
