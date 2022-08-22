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

extension Parser {
  /// Implements general-purpose, balanced delimiter parser recovery.
  ///
  /// This function implements a very coarse recovery algorithm that tries to
  /// skip over as much balanced token structure as it can before yielding back
  /// to the parser. For example, this enables the parser to recover from
  ///
  /// ```swift
  /// case: { ("Hello World") }
  /// ```
  ///
  /// Item parsing runs recovery in a loop until it encounters a
  /// token that could be the start of a new item. After eating the erroneous
  /// `case` at the top level, the parser calls `recover()` to eat the colon,
  /// then calls it again to eat the braces. The final time around, this
  /// routine will eat not just the braces, but also the parenthesized
  /// `"Hello World"` string token contained therein and its paren tokens.
  ///
  /// Using Recovery
  /// ==============
  ///
  /// Parser recovery is a method of last resort. It indicates that the parser
  /// has encountered some part of the input that it believes to be so erroneous
  /// it cannot possibly assign it any structure. The resulting syntax tree
  /// thus contains a sequence of unparsed tokens. As such, this function should
  /// be considered only when the parser would otherwise be unable to make
  /// forward progress, such as when an entire missing syntax node is
  /// encountered. For simple cases like a missing token, it is more appropriate
  /// to use ``Parser/expect(_:)``, which will correctly handle looking ahead
  /// to try to reach the desired point in the token stream.
  ///
  /// - Returns: A non-empty list of tokens that were eaten during the recovery process.
  mutating func recover() -> [RawTokenSyntax] {
    var tokens = [RawTokenSyntax]()
    switch self.currentToken.tokenKind {
    case .leftParen:
      tokens.append(self.consumeAnyToken())
      while !self.at(.eof) && !self.at(.rightParen)
              && !self.at(.poundEndifKeyword) && !self.at(.poundElseKeyword) && !self.at(.poundElseifKeyword) {
        tokens.append(contentsOf: self.recover())
      }
      if let token = self.consume(if: .rightParen) {
        tokens.append(token)
      }
      return tokens
    case .leftBrace:
      tokens.append(self.consumeAnyToken())
      while !self.at(.eof) && !self.at(.rightBrace)
              && !self.at(.poundEndifKeyword) && !self.at(.poundElseKeyword) && !self.at(.poundElseifKeyword) {
        tokens.append(contentsOf: self.recover())
      }
      if let token = self.consume(if: .rightBrace) {
        tokens.append(token)
      }
      return tokens
    case .leftSquareBracket:
      tokens.append(self.consumeAnyToken())
      while !self.at(.eof) && !self.at(.rightSquareBracket)
              && !self.at(.poundEndifKeyword) && !self.at(.poundElseKeyword) && !self.at(.poundElseifKeyword) {
        tokens.append(contentsOf: self.recover())
      }
      if let token = self.consume(if: .rightSquareBracket) {
        tokens.append(token)
      }
      return tokens
    case .poundIfKeyword,
        .poundElseKeyword,
        .poundElseifKeyword:
      tokens.append(self.consumeAnyToken())
      // skipUntil also implicitly stops at tok::pound_endif.
      while !self.at(.eof) && !self.at(.poundElseKeyword) && !self.at(.poundElseifKeyword)
              && !self.at(.poundEndifKeyword) {
        tokens.append(contentsOf: self.recover())
      }
      if let token = self.consume(if: .rightSquareBracket) {
        tokens.append(token)
      }

      if self.at(.poundElseKeyword) || self.at(.poundElseifKeyword) {
        tokens.append(contentsOf: self.recover())
        return tokens
      } else {
        if let token = self.consume(if: .poundEndifKeyword) {
          tokens.append(token)
        }
        return tokens
      }

    default:
      tokens.append(self.consumeAnyToken())
      return tokens
    }
  }
}

extension Parser {
  /// A recovery function that recovers from a number of special cases for syntax
  /// elements that cannot possibly be the start of items.
  ///
  /// This function  is intended to be called at the start of item parsing so
  /// that future calls to item parsing will have a better shot at succeeding
  /// without necessarily invoking the general purpose recovery
  /// mechanism.
  ///
  /// - Returns: A syntax node capturing the result of recovering from a bad
  ///            item parse, or `nil` if recovery did not occur.
  mutating func recoverFromBadItem() -> RawCodeBlockItemSyntax? {
    if let extraRightBrace = self.consume(if: .rightBrace) {
      // If we see an extraneous right brace, we need to make progress by
      // eating it. The legacy parser forms an unknown stmt kind here, so
      // we match it.
      let missingStmt = RawMissingStmtSyntax(arena: self.arena)
      return RawCodeBlockItemSyntax(
        item: RawSyntax(missingStmt),
        semicolon: nil,
        errorTokens: RawSyntax(RawNonEmptyTokenListSyntax(elements: [ extraRightBrace ], arena: self.arena)),
        arena: self.arena)
    } else if self.at(.caseKeyword) || self.at(.defaultKeyword) {
      // If there's a case or default label at the top level then the user
      // has tried to write one outside of the scope of a switch statement.
      // Recover up to the next braced block.
      let missingStmt = RawMissingStmtSyntax(arena: self.arena)
      let extraTokens = self.recover()
      return RawCodeBlockItemSyntax(
        item: RawSyntax(missingStmt),
        semicolon: nil,
        errorTokens: RawSyntax(RawNonEmptyTokenListSyntax(elements: extraTokens, arena: self.arena)),
        arena: self.arena)
    } else if self.at(.poundElseKeyword) || self.at(.poundElseifKeyword)
        || self.at(.poundEndifKeyword) {
      // In the case of a catastrophic parse error, consume any trailing
      // #else, #elseif, or #endif and move on to the next statement or
      // declaration block.
      let token = self.consumeAnyToken()
      // Create 'MissingDecl' for orphan directives.
      return RawCodeBlockItemSyntax(
        item: RawSyntax(RawMissingDeclSyntax(attributes: nil, modifiers: nil, arena: self.arena)),
        semicolon: nil,
        errorTokens: RawSyntax(RawNonEmptyTokenListSyntax(elements: [ token ], arena: self.arena)),
        arena: self.arena)
    } else {
      return nil
    }
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  /// Tries eating tokens until it finds a token of `kind` without skipping any
  /// higher precedence tokens. If it found a token of `kind` in this way,
  /// returns `true`, otherwise `false`.
  /// If this method returns `true`, the parser probably wants to consume the
  /// tokens this lookahead skipped over to find `kind` by consuming
  /// `lookahead.tokensConsumed` as unexpected.
  mutating func canRecoverTo(_ kind: RawTokenKind) -> Bool {
    // If the `Set` implementation has noticable performance overheads, we could
    // provide a matching implementaiton for a single `TokenKind` here.
    return canRecoverTo([kind])
  }

  /// Tries eating tokens until it finds a token whose kind is in `kinds`
  /// without skipping tokens that have a precedence that's higher than the
  /// lowest precedence in `kinds`. If it found a token of `kind` in this way,
  /// returns `true`, otherwise `false`.
  /// If this method returns `true`, the parser probably wants to consume the
  /// tokens this lookahead skipped over to find `kind` by consuming
  /// `lookahead.tokensConsumed` as unexpected.
  mutating func canRecoverTo(_ kinds: [RawTokenKind]) -> Bool {
    assert(!kinds.isEmpty)
    let recoveryPrecedence = kinds.map(TokenPrecedence.init).min()!
    while !self.at(.eof) {
      if !recoveryPrecedence.shouldSkipOverNewlines,
          self.currentToken.isAtStartOfLine {
        break
      }
      if self.atAny(kinds) {
        return true
      }
      let currentTokenPrecedence = TokenPrecedence(self.currentToken.tokenKind)
      if currentTokenPrecedence >= recoveryPrecedence {
        break
      }
      self.consumeAnyToken()
      if let closingDelimiter = currentTokenPrecedence.closingTokenKind {
        guard self.canRecoverTo(closingDelimiter) else {
          break
        }
        self.eat(closingDelimiter)
      }
    }

    return false
  }
}

