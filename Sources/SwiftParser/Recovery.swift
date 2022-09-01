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

extension Parser.Lookahead {
  /// Information about the token that ended recovery.
  struct RecoveryMatch {
    /// The token kind to which the parser recovered.
    let tokenKind: RawTokenKind
    /// The text of the token to which the parser recovered.
    let text: SyntaxText

    init(_ lexeme: Lexer.Lexeme) {
      self.tokenKind = lexeme.tokenKind
      self.text = lexeme.tokenText
    }
  }

  /// Tries eating tokens until it finds a token of `kind` without skipping any
  /// higher precedence tokens. If it found a token of `kind` in this way,
  /// returns `true`, otherwise `false`.
  /// If this method returns `true`, the parser probably wants to consume the
  /// tokens this lookahead skipped over to find `kind` by consuming
  /// `lookahead.tokensConsumed` as unexpected.
  mutating func canRecoverTo(_ kind: RawTokenKind) -> Bool {
    // If the `Array` implementation has noticable performance overheads, we could
    // provide a matching implementaiton for a single `TokenKind` here.
    return canRecoverToImpl([kind], recoveryPrecedence: TokenPrecedence(kind)) != nil
  }

  /// Tries eating tokens until it finds a token whose kind is in `kinds`
  /// without skipping tokens that have a precedence higher than
  /// `recoveryPrecedence`. If it found a token this way, it returns the found
  /// tokens's kind and text, otherwise it returns `nil`.
  /// `contextualPrecedences` allows the caller to increase the precedence of
  /// contextual keywords.
  private mutating func canRecoverToImpl(
    _ kinds: [RawTokenKind],
    contextualPrecedences: [SyntaxText: TokenPrecedence] = [:],
    recoveryPrecedence: TokenPrecedence
  ) -> RecoveryMatch? {
    assert(!kinds.isEmpty)
    while !self.at(.eof) {
      if !recoveryPrecedence.shouldSkipOverNewlines,
         self.currentToken.isAtStartOfLine {
        break
      }
      if self.atAny(kinds) {
        return RecoveryMatch(self.currentToken)
      }
      let currentTokenPrecedence: TokenPrecedence
      if (self.currentToken.tokenKind == .identifier || self.currentToken.tokenKind == .contextualKeyword),
         let contextualPrecedence = contextualPrecedences[self.currentToken.tokenText] {
        currentTokenPrecedence = contextualPrecedence
      } else {
        currentTokenPrecedence = TokenPrecedence(self.currentToken.tokenKind)
      }

      if currentTokenPrecedence >= recoveryPrecedence {
        break
      }
      self.consumeAnyToken()
      if let closingDelimiter = currentTokenPrecedence.closingTokenKind {
        guard self.canRecoverTo(closingDelimiter) else {
          break
        }
        self.eatWithoutRecovery(closingDelimiter)
      }
    }
    return nil
  }

  /// Tries eating tokens until it finds a token whose kind is in `kinds`
  /// without skipping tokens that have a precedence that's higher than the
  /// lowest precedence in `kinds`. If it found a token this way, it returns the
  /// found tokens's kind and text, otherwise it returns `nil`.
  /// `contextualPrecedences` allows the caller to increase the precedence of
  /// contextual keywords.
  /// If this method returns a non-`nil` value, the parser probably wants to
  /// consume the tokens this lookahead skipped over to find `kind` by consuming
  /// `lookahead.tokensConsumed` as unexpected.
  mutating func canRecoverTo(
    _ kinds: [RawTokenKind],
    contextualPrecedences: [SyntaxText: TokenPrecedence] = [:]
  ) -> RecoveryMatch? {
    var kindsByPrecedence = [TokenPrecedence: [RawTokenKind]]()
    for kind in kinds {
      kindsByPrecedence[TokenPrecedence(kind), default: []].append(kind)
    }
    // If we increase the precedence of certain contextual keywords, we need to
    // also search the token stream for these contextual keywords at the remapped precedence.
    for contextualPrecedence in contextualPrecedences.values {
      kindsByPrecedence[contextualPrecedence, default: []].append(.identifier)
      kindsByPrecedence[contextualPrecedence, default: []].append(.contextualKeyword)
    }
    // Start by trying to recover to tokens with lower precedence because they
    // will skip fewer tokens.
    for precedence in kindsByPrecedence.keys.sorted() {
      if let recoveredLexeme = canRecoverToImpl(
        kindsByPrecedence[precedence]!,
        contextualPrecedences: contextualPrecedences,
        recoveryPrecedence: precedence
      ) {
        return recoveredLexeme
      }
    }
    return nil
  }
}

