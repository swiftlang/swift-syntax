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

  /// If `text` only consists of indentation whitespace (space and tab), return
  /// the trivia pieces that represent `text`, otherwise return `nil`.
  private func parseIndentationTrivia(text: SyntaxText) -> [RawTriviaPiece]? {
    let trivia = TriviaParser.parseTrivia(text, position: .leading)
    if trivia.allSatisfy({ $0.isIndentationWhitespace }) {
      return trivia
    } else {
      return nil
    }
  }

  // FIXME: Handle \r and \r\n if needed in here
  private func postProcessMultilineStringLiteral(
    openQuote: RawTokenSyntax,
    segments allSegments: [RawStringLiteralSegmentsSyntax.Element],
    closeQuote: RawTokenSyntax
  ) -> (
    unexpectedBeforeOpenQuote: [RawTokenSyntax],
    openQuote: RawTokenSyntax,
    segments: [RawStringLiteralSegmentsSyntax.Element],
    unexpectedBeforeCloseQuote: [RawTokenSyntax],
    closeQuote: RawTokenSyntax
  ) {
    // -------------------------------------------------------------------------
    // Precondition

    assert(openQuote.trailingTriviaByteLength == 0, "Open quote produced by the lexer should not have trailing trivia because we would drop it during post-processing")
    assert(closeQuote.leadingTriviaByteLength == 0, "Closing quote produced by the lexer should not have leading trivia because we would drop it during post-processing")
    assert(
      allSegments.allSatisfy {
        if case .stringSegment(let segment) = $0 {
          return segment.unexpectedBeforeContent == nil
            && segment.unexpectedAfterContent == nil
            && segment.content.leadingTriviaByteLength == 0
            && segment.content.trailingTriviaByteLength == 0
        } else {
          return true
        }
      },
      "String segement produced by the lexer should not have unexpected text or trivia because we would drop it during post-processing"
    )

    // -------------------------------------------------------------------------
    // Variables

    var middleSegments = allSegments
    let lastSegment = !middleSegments.isEmpty ? middleSegments.removeLast().as(RawStringSegmentSyntax.self) : nil
    let firstSegment = !middleSegments.isEmpty ? middleSegments.removeFirst().as(RawStringSegmentSyntax.self) : nil

    let indentation: SyntaxText
    let indentationTrivia: [RawTriviaPiece]

    var unexpectedBeforeOpenQuote: [RawTokenSyntax] = []
    var openQuote = openQuote
    var unexpectedBeforeCloseQuote: [RawTokenSyntax] = []
    var closeQuote = closeQuote

    // -------------------------------------------------------------------------
    // Check close quote is on new line

    let closeDelimiterOnNewLine: Bool
    switch middleSegments.last {
    case .stringSegment(let lastMiddleSegment):
      if lastMiddleSegment.content.tokenText.hasSuffix("\n") {
        // The newline at the end of the last line in the string literal is not part of the represented string.
        // Mark it as trivia.
        middleSegments[middleSegments.count - 1] = .stringSegment(
          RawStringSegmentSyntax(
            content: lastMiddleSegment.content.reclassifyAsTrailingTrivia([.newlines(1)], arena: self.arena),
            arena: self.arena
          )
        )
        closeDelimiterOnNewLine = true
      } else {
        closeDelimiterOnNewLine = false
      }
    case .expressionSegment:
      closeDelimiterOnNewLine = false
    case nil:
      closeDelimiterOnNewLine = firstSegment?.content.tokenText.hasSuffix("\n") ?? false
    }

    if !closeDelimiterOnNewLine {
      unexpectedBeforeCloseQuote = [closeQuote]
      closeQuote = RawTokenSyntax(missing: closeQuote.tokenKind, leadingTriviaPieces: [.newlines(1)], arena: self.arena)

      // The closing delimiter doesn't start on a new line and thus it doesn't
      // make sense to try and extract indentation from it.
      return (unexpectedBeforeOpenQuote, openQuote, allSegments, unexpectedBeforeCloseQuote, closeQuote)
    }

    // -------------------------------------------------------------------------
    // Parse indentation

    if let lastSegment = lastSegment,
      let parsedTrivia = parseIndentationTrivia(text: lastSegment.content.tokenText)
    {
      indentationTrivia = parsedTrivia
      indentation = lastSegment.content.tokenText
      closeQuote = closeQuote.extendingLeadingTrivia(by: parsedTrivia, arena: self.arena)
    } else {
      if let lastSegment = lastSegment {
        indentationTrivia = TriviaParser.parseTrivia(lastSegment.content.tokenText, position: .leading).prefix(while: { $0.isIndentationWhitespace })
        let indentationByteLength = indentationTrivia.reduce(0, { $0 + $1.byteLength })
        indentation = SyntaxText(rebasing: lastSegment.content.tokenText[0..<indentationByteLength])
        middleSegments.append(.stringSegment(lastSegment))
      } else {
        indentationTrivia = []
        indentation = ""
      }

      unexpectedBeforeCloseQuote = [closeQuote]
      closeQuote = RawTokenSyntax(missing: closeQuote.tokenKind, leadingTriviaPieces: [.newlines(1)] + indentationTrivia, arena: self.arena)
    }

    // -------------------------------------------------------------------------
    // Check open quote followed by newline

    if firstSegment?.content.tokenText == "\n" {
      openQuote = openQuote.extendingTrailingTrivia(by: [.newlines(1)], arena: self.arena)
    } else {
      if let firstSegment = firstSegment {
        middleSegments.insert(.stringSegment(firstSegment), at: 0)
      }
      unexpectedBeforeOpenQuote = [openQuote]
      openQuote = RawTokenSyntax(missing: openQuote.tokenKind, trailingTriviaPieces: [.newlines(1)] + indentationTrivia, arena: self.arena)
    }

    // -------------------------------------------------------------------------
    // Check indentation of segments

    for (index, segment) in middleSegments.enumerated() {
      switch segment {
      case .stringSegment(var segment):
        assert(segment.unexpectedBeforeContent == nil, "Segment should not have unexpected before content")
        assert(segment.content.leadingTriviaByteLength == 0, "Segment should not have leading trivia")
        if segment.content.tokenText.hasPrefix(indentation) {
          segment = RawStringSegmentSyntax(
            content: segment.content.reclassifyAsLeadingTrivia(indentationTrivia, arena: self.arena),
            arena: self.arena
          )
        } else {
          // TODO: Diagnose
        }
        if segment.content.tokenText.hasSuffix("\\\n") {
          // TODO: Add a backslash trivia kind
          segment = RawStringSegmentSyntax(
            content: segment.content.reclassifyAsTrailingTrivia([.unexpectedText("\\"), .newlines(1)], arena: self.arena),
            arena: self.arena
          )
        }
        middleSegments[index] = .stringSegment(segment)
      case .expressionSegment:
        // TODO: Check indentation
        break
      }
    }

    // -------------------------------------------------------------------------
    // Done

    return (
      unexpectedBeforeOpenQuote,
      openQuote,
      middleSegments,
      unexpectedBeforeCloseQuote,
      closeQuote
    )
  }

  /// Parse a string literal expression.
  @_spi(RawSyntax)
  public mutating func parseStringLiteral() -> RawStringLiteralExprSyntax {
    /// Parse opening raw string delimiter if exist.
    let openDelimiter = self.consume(if: .rawStringDelimiter)

    /// Parse open quote.
    var (unexpectedBeforeOpenQuote, openQuote) = self.expectAny([.stringQuote, .multilineStringQuote], default: .stringQuote)
    var openQuoteKind: RawTokenKind = openQuote.tokenKind
    if openQuote.isMissing, let singleQuote = self.consume(if: .singleQuote) {
      unexpectedBeforeOpenQuote = RawUnexpectedNodesSyntax(combining: unexpectedBeforeOpenQuote, singleQuote, arena: self.arena)
      openQuoteKind = .singleQuote
    }

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
        while !self.at(any: [.rightParen, .stringSegment, .backslash, openQuoteKind, .eof]) && unexpectedProgress.evaluate(self.currentToken) {
          unexpectedBeforeRightParen.append(self.consumeAnyToken())
        }
        let rightParen = self.expectWithoutRecovery(.rightParen)
        if rightParen.isMissing, case .inStringInterpolation = self.currentToken.cursor.currentState {
          // The parser has more knowledge that we have reached the end of the
          // string interpolation now, even if we haven't seen the closing ')'.
          // For example, consider the following code
          //   "\(abc "
          // Since the lexer doesn't know anything about the expression structure,
          // it assumes that the `"` starts a new string literal. But since we
          // know in the parser that an identifier cannot be followed by a string
          // literal without a connecting binary operator and can thus consider
          // it as the surrounding string literal end, which thus also terminates
          // the string interpolation.
          self.lexemes.perform(stateTransition: .pop, currentToken: &self.currentToken)
        }
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
    let unexpectedBeforeCloseQuote: RawUnexpectedNodesSyntax?
    let closeQuote: RawTokenSyntax
    if openQuoteKind == .singleQuote {
      let singleQuote = self.expectWithoutRecovery(.singleQuote)
      unexpectedBeforeCloseQuote = RawUnexpectedNodesSyntax([singleQuote], arena: self.arena)
      closeQuote = missingToken(.stringQuote)
    } else {
      unexpectedBeforeCloseQuote = nil
      closeQuote = self.expectWithoutRecovery(openQuote.tokenKind)
    }

    let (unexpectedBeforeCloseDelimiter, closeDelimiter) = self.parseStringDelimiter(openDelimiter: openDelimiter)

    if openQuote.tokenKind == .multilineStringQuote, !openQuote.isMissing, !closeQuote.isMissing {
      let postProcessed = postProcessMultilineStringLiteral(openQuote: openQuote, segments: segments, closeQuote: closeQuote)
      return RawStringLiteralExprSyntax(
        openDelimiter: openDelimiter,
        RawUnexpectedNodesSyntax(combining: unexpectedBeforeOpenQuote, postProcessed.unexpectedBeforeOpenQuote, arena: self.arena),
        openQuote: postProcessed.openQuote,
        segments: RawStringLiteralSegmentsSyntax(elements: postProcessed.segments, arena: self.arena),
        RawUnexpectedNodesSyntax(combining: postProcessed.unexpectedBeforeCloseQuote, unexpectedBeforeCloseQuote, arena: self.arena),
        closeQuote: postProcessed.closeQuote,
        unexpectedBeforeCloseDelimiter,
        closeDelimiter: closeDelimiter,
        arena: self.arena
      )
    } else {
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
}
