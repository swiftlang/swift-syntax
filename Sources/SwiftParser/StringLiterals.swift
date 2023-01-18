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

@_spi(RawSyntax) import SwiftSyntax

extension Parser {
  /// Consumes a raw string delimiter that has the same number of `#` as `openDelimiter`.
  private mutating func parseStringDelimiter(openDelimiter: RawTokenSyntax?) -> (unexpectedBeforeCheckedDelimiter: RawUnexpectedNodesSyntax?, checkedDelimiter: RawTokenSyntax?) {
    // Check for leadingTriviaText == "" so we don't consume the leading raw
    // string delimiter of an upcoming string literal, e.g. in
    // ```
    // "normal literal"
    // #"raw literal"#
    // ```
    let delimiter: RawTokenSyntax?
    if self.at(.rawStringDelimiter) && self.currentToken.leadingTriviaText == "" {
      delimiter = self.consumeAnyToken()
    } else {
      delimiter = nil
    }

    switch (openDelimiter, delimiter) {
    case (nil, nil):
      return (nil, nil)
    case (let open?, nil):
      return (nil, missingToken(.rawStringDelimiter, text: open.tokenText))
    case (nil, .some):
      return (RawUnexpectedNodesSyntax([delimiter], arena: self.arena), nil)
    case (let open?, let close?):
      if open.tokenText == close.tokenText {
        return (nil, close)
      } else {
        return (RawUnexpectedNodesSyntax([delimiter], arena: self.arena), missingToken(.rawStringDelimiter, text: open.tokenText))
      }
    }
  }

  /// Parse a string literal expression.
  @_spi(RawSyntax)
  public mutating func parseStringLiteral() -> RawStringLiteralExprSyntax {
    /// Parse opening raw string delimiter if exist.
    let openDelimiter = self.consume(if: .rawStringDelimiter)

    /// Parse open quote.
    let (unexpectedBeforeOpenQuote, openQuote) = self.expectAny([.stringQuote, .multilineStringQuote, .singleQuote], default: .stringQuote)

    /// Parse segments.
    var segments: [RawStringLiteralSegmentsSyntax.Element] = []
    var loopProgress = LoopProgressCondition()
    while loopProgress.evaluate(self.currentToken) {
      if let stringSegment = self.consume(if: .stringSegment) {
        segments.append(.stringSegment(RawStringSegmentSyntax(content: stringSegment, arena: self.arena)))
      } else if let backslash = self.consume(if: .backslash) {
        let (unexpectedBeforeDelimiter, delimiter) = self.parseStringDelimiter(openDelimiter: openDelimiter)
        let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
        let expressions = RawTupleExprElementListSyntax(elements: self.parseArgumentListElements(pattern: .none), arena: self.arena)

        // For recovery, eat anything up to the next token that either starts a new string segment or terminates the string.
        // This allows us to skip over extraneous identifiers etc. in an unterminated string interpolation.
        var unexpectedBeforeRightParen: [RawTokenSyntax] = []
        var unexpectedProgress = LoopProgressCondition()
        while !self.at(any: [.rightParen, .stringSegment, .backslash, openQuote.tokenKind, .eof]) && unexpectedProgress.evaluate(self.currentToken) {
          unexpectedBeforeRightParen.append(self.consumeAnyToken())
        }
        let rightParen = self.expectWithoutRecovery(.rightParen)
        segments.append(
          .expressionSegment(
            RawExpressionSegmentSyntax(
              backslash: backslash,
              unexpectedBeforeDelimiter,
              delimiter: delimiter,
              unexpectedBeforeLeftParen,
              leftParen: leftParen,
              expressions: expressions,
              RawUnexpectedNodesSyntax(unexpectedBeforeRightParen, arena: self.arena),
              rightParen: rightParen,
              arena: self.arena
            )
          )
        )
      } else {
        break
      }
    }

    /// Parse close quote.
    let (unexpectedBeforeCloseQuote, closeQuote) = self.expect(openQuote.tokenKind)

    let (unexpectedBeforeCloseDelimiter, closeDelimiter) = self.parseStringDelimiter(openDelimiter: openDelimiter)

    /// Construct the literal expression.
    return RawStringLiteralExprSyntax(
      openDelimiter: openDelimiter,
      unexpectedBeforeOpenQuote,
      openQuote: openQuote,
      segments: RawStringLiteralSegmentsSyntax(elements: segments, arena: self.arena),
      unexpectedBeforeCloseQuote,
      closeQuote: closeQuote,
      unexpectedBeforeCloseDelimiter,
      closeDelimiter: closeDelimiter,
      arena: self.arena
    )
  }
}
