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

// MARK: - Check multiline string literal indentation

fileprivate class StringLiteralExpressionIndentationChecker {
  // MARK: Entry

  init(expectedIndentation: SyntaxText, arena: SyntaxArena) {
    self.expectedIndentation = expectedIndentation
    self.arena = arena
  }

  func checkIndentation(of expressionSegment: RawExpressionSegmentSyntax) -> RawExpressionSegmentSyntax? {
    if let rewrittenSegment = self.visit(node: RawSyntax(expressionSegment)) {
      return rewrittenSegment.as(RawExpressionSegmentSyntax.self)
    } else {
      return nil
    }
  }

  // MARK: Implementation

  private let expectedIndentation: SyntaxText
  private let arena: SyntaxArena

  private func visit(node: RawSyntax) -> RawSyntax? {
    if node.isToken {
      return visitTokenNode(token: node.as(RawTokenSyntax.self)!)
    } else {
      return visitLayoutNode(node: node)
    }
  }

  private func visitTokenNode(token: RawTokenSyntax) -> RawSyntax? {
    if !token.leadingTriviaPieces.contains(where: { $0.isNewline }) {
      // Only checking tokens on a newline
      return nil
    }
    let hasSufficientIndentation = token.tokenView.leadingTrivia { leadingTrivia -> Bool in
      let indentationStartIndex =
        leadingTrivia
        .lastIndex(where: { $0 == UInt8(ascii: "\n") || $0 == UInt8(ascii: "\r") })?
        .advanced(by: 1)
        ?? leadingTrivia.startIndex
      return SyntaxText(rebasing: leadingTrivia[indentationStartIndex...]).hasPrefix(expectedIndentation)
    }
    if hasSufficientIndentation {
      return nil
    }
    if let tokenDiagnostic = token.tokenView.tokenDiagnostic, tokenDiagnostic.severity == .error {
      // Token already has a lexer error, ignore the indentation error until that
      // error is fixed
      return nil
    }
    let tokenWithDiagnostic = token.tokenView.withTokenDiagnostic(
      tokenDiagnostic: TokenDiagnostic(.insufficientIndentationInMultilineStringLiteral, byteOffset: 0),
      arena: arena
    )
    return RawSyntax(tokenWithDiagnostic)
  }

  private func visitLayoutNode(node: RawSyntax) -> RawSyntax? {
    let layoutView = node.layoutView!

    var hasRewrittenChild = false
    var rewrittenChildren: [RawSyntax?] = []
    for child in layoutView.children {
      if let child, let rewrittenChild = visit(node: child) {
        hasRewrittenChild = true
        rewrittenChildren.append(rewrittenChild)
      } else {
        rewrittenChildren.append(child)
      }
    }
    precondition(rewrittenChildren.count == layoutView.children.count)
    if hasRewrittenChild {
      return layoutView.replacingLayout(with: rewrittenChildren, arena: arena)
    } else {
      return nil
    }
  }
}

// MARK: - Post-process multi-line string literals

fileprivate extension SyntaxText {
  /// If the text ends with any newline character, return that character,
  /// otherwise `nil`.
  var newlineSuffix: SyntaxText? {
    if hasSuffix("\r\n") {
      return "\r\n"
    } else if hasSuffix("\n") {
      return "\n"
    } else if hasSuffix("\r") {
      return "\r"
    } else {
      return nil
    }
  }

  /// If the text is a single newline character, return the trivia piece that
  /// represents it, otherwise `nil`.
  var triviaPieceIfNewline: RawTriviaPiece? {
    if self == "\r\n" {
      return .carriageReturnLineFeeds(1)
    } else if self == "\n" {
      return .newlines(1)
    } else if self == "\r" {
      return .carriageReturns(1)
    } else {
      return nil
    }
  }
}

extension Parser {
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

  private func reclassifyTrivia(
    in token: RawTokenSyntax,
    leading reclassifyLeading: SyntaxText = "",
    trailing reclassifyTrailing: SyntaxText = "",
    tokenDiagnostic: TokenDiagnostic? = nil
  ) -> RawTokenSyntax {
    precondition(SyntaxText(rebasing: token.tokenText.prefix(reclassifyLeading.count)) == reclassifyLeading)
    precondition(SyntaxText(rebasing: token.tokenText.suffix(reclassifyTrailing.count)) == reclassifyTrailing)
    return RawTokenSyntax(
      kind: token.tokenKind,
      text: SyntaxText(rebasing: token.tokenText.dropFirst(reclassifyLeading.count).dropLast(reclassifyTrailing.count)),
      leadingTriviaPieces: token.leadingTriviaPieces + TriviaParser.parseTrivia(reclassifyLeading, position: .leading),
      trailingTriviaPieces: TriviaParser.parseTrivia(reclassifyTrailing, position: .trailing) + token.trailingTriviaPieces,
      presence: token.presence,
      tokenDiagnostic: token.tokenView.tokenDiagnostic ?? tokenDiagnostic,
      arena: self.arena
    )
  }

  /// Re-classify the newline of the last line as trivia since the newline is
  /// not part of the represented string. If the last line has its newline
  /// escaped by a trailing `\`, mark that string segment as unexpected and
  /// generate a missing segment that doesn't have a trailing `\`.
  ///
  /// Returns `true` if the closing quote is on its own line and `false` otherwise.
  private func reclassifyNewlineOfLastSegmentAsTrivia(
    rawStringDelimitersToken: RawTokenSyntax?,
    openQuoteHasTrailingNewline: Bool,
    middleSegments: inout [RawStringLiteralSegmentListSyntax.Element]
  ) -> Bool {
    guard let segment = middleSegments.last else {
      return openQuoteHasTrailingNewline
    }
    switch segment {
    case .stringSegment(let lastMiddleSegment):
      if !lastMiddleSegment.content.trailingTriviaPieces.isEmpty {
        precondition(
          lastMiddleSegment.content.trailingTriviaPieces.contains(where: { $0.isBackslash }),
          "The lexer should only add trailing trivia to a string segment if the newline is escaped by a backslash"
        )

        if rawStringDelimitersToken != nil {
          // ... except in raw string literals where the C++ parser accepts the
          // last line to be escaped. To match the C++ parser's behavior, we also
          // need to allow escaped newline in raw string literals.
          return true
        }

        let unexpectedBeforeContent = lastMiddleSegment.content
        let content = RawTokenSyntax(
          missing: .stringSegment,
          text: lastMiddleSegment.content.tokenText,
          leadingTriviaPieces: lastMiddleSegment.content.leadingTriviaPieces,
          trailingTriviaPieces: lastMiddleSegment.content.trailingTriviaPieces.filter({ $0.isNewline }),
          arena: self.arena
        )
        middleSegments[middleSegments.count - 1] = .stringSegment(
          RawStringSegmentSyntax(
            RawUnexpectedNodesSyntax(combining: lastMiddleSegment.unexpectedBeforeContent, unexpectedBeforeContent, arena: self.arena),
            content: content,
            lastMiddleSegment.unexpectedAfterContent,
            arena: self.arena
          )
        )
        return true
      } else if let newlineSuffix = lastMiddleSegment.content.tokenText.newlineSuffix {
        // The newline at the end of the last line in the string literal is not part of the represented string.
        // Mark it as trivia.
        let content = self.reclassifyTrivia(in: lastMiddleSegment.content, trailing: newlineSuffix)

        middleSegments[middleSegments.count - 1] = .stringSegment(
          RawStringSegmentSyntax(
            lastMiddleSegment.unexpectedBeforeContent,
            content: content,
            lastMiddleSegment.unexpectedAfterContent,
            arena: self.arena
          )
        )
        return true
      } else {
        return false
      }
    case .expressionSegment:
      return false
    #if RESILIENT_LIBRARIES
    @unknown default:
      fatalError()
    #endif
    }
  }

  /// Re-classifying the indentation of the middle lines as trivia, such that
  /// the string segment token only contains whitespace that is part of the
  /// actual string. If a line is under-indented a
  /// `.insufficientIndentationInMultilineStringLiteral` lexer error will be
  /// attached to the string segment token.
  private func postProcessIndentationAndEscapedNewlineOfMiddleSegments(
    rawStringDelimitersToken: RawTokenSyntax?,
    middleSegments: inout [RawStringLiteralSegmentListSyntax.Element],
    isFirstSegmentOnNewLine: Bool,
    indentation: SyntaxText
  ) {
    let expressionIndentationChecker = StringLiteralExpressionIndentationChecker(expectedIndentation: indentation, arena: self.arena)

    var isSegmentOnNewLine = isFirstSegmentOnNewLine
    for (index, segment) in middleSegments.enumerated() {
      switch segment {
      case .stringSegment(var segment):
        // We are not considering leading trivia for indentation computation.
        // If these assertions are violated, we can probably lift them but we
        // would need to check that they produce the expected results.
        precondition(segment.content.leadingTriviaByteLength == 0)

        // Re-classify indentation as leading trivia
        if isSegmentOnNewLine {
          if segment.content.tokenText.hasPrefix(indentation) {
            segment = RawStringSegmentSyntax(
              segment.unexpectedBeforeContent,
              content: self.reclassifyTrivia(in: segment.content, leading: indentation),
              segment.unexpectedAfterContent,
              arena: self.arena
            )
          } else if (segment.content.tokenText == "" || segment.content.tokenText.triviaPieceIfNewline != nil)
            && segment.content.trailingTriviaPieces.allSatisfy({ $0.isNewline })
          {
            // Empty lines don't need to be indented and there's no indentation we need to strip away.
          } else {
            let actualIndentation = SyntaxText(rebasing: segment.content.tokenText.prefix(while: { $0 == UInt8(ascii: " ") || $0 == UInt8(ascii: "\t") }))
            let tokenDiagnostic = TokenDiagnostic(.insufficientIndentationInMultilineStringLiteral, byteOffset: 0)
            let content = self.reclassifyTrivia(in: segment.content, leading: actualIndentation, tokenDiagnostic: tokenDiagnostic)
            segment = RawStringSegmentSyntax(
              segment.unexpectedBeforeContent,
              content: content,
              segment.unexpectedAfterContent,
              arena: self.arena
            )
          }
        }

        isSegmentOnNewLine =
          segment.content.tokenText.newlineSuffix != nil
          || (segment.content.trailingTriviaPieces.last?.isNewline ?? false)

        middleSegments[index] = .stringSegment(segment)
      case .expressionSegment(let segment):
        isSegmentOnNewLine = segment.rightParen.trailingTriviaPieces.contains(where: { $0.isNewline })

        if let rewrittenSegment = expressionIndentationChecker.checkIndentation(of: segment) {
          middleSegments[index] = .expressionSegment(rewrittenSegment)
        }
      #if RESILIENT_LIBRARIES
      @unknown default:
        fatalError()
      #endif
      }
    }
  }

  /// After parsing a multi-line string literal from tokens produced by the lexer,
  /// post-process the string literal by performing the following steps
  ///  - Ensuring that the open quote is followed by a newline (i.e. the opening
  ///    quote shouldn't have any any text on the same line). If this is not the
  ///    case, mark the existing opening quote as unexpected and synthesize
  ///    a missing quote that is followed by a newline
  ///  - Re-classifying the indentation of the middle lines as trivia, such that
  ///    the string segment token only contains whitespace that is part of the
  ///    actual string. If a line is under-indented a
  ///    `.insufficientIndentationInMultilineStringLiteral` lexer error will be
  ///    attached to the string segment token.
  ///  - Re-classify the newline of the last line as trivia since the newline is
  ///    not part of the represented string. If the last line has its newline
  ///    escaped by a trailing `\`, mark that string segment as unexpected and
  ///    generate a missing segment that doesn't have a trailing `\`.
  private func postProcessMultilineStringLiteral(
    rawStringDelimitersToken: RawTokenSyntax?,
    openQuote: RawTokenSyntax,
    segments allSegments: [RawStringLiteralSegmentListSyntax.Element],
    closeQuote: RawTokenSyntax
  ) -> (
    unexpectedBeforeOpeningQuote: [RawTokenSyntax],
    openingQuote: RawTokenSyntax,
    segments: [RawStringLiteralSegmentListSyntax.Element],
    unexpectedBeforeClosingQuote: [RawTokenSyntax],
    closingQuote: RawTokenSyntax
  ) {
    // -------------------------------------------------------------------------
    // Precondition

    precondition(
      allSegments.allSatisfy {
        if case .stringSegment(let segment) = $0 {
          return segment.unexpectedBeforeContent == nil
            && segment.unexpectedAfterContent == nil
            && segment.content.leadingTriviaByteLength == 0
        } else {
          return true
        }
      },
      "String segment produced by the lexer should not have unexpected text or trivia because we would drop it during post-processing"
    )

    // -------------------------------------------------------------------------
    // Variables

    var middleSegments = allSegments
    // In a well-formed string literal, the last segment only consists of whitespace and contains the closing quote's indentation
    let lastSegment = middleSegments.popLast()?.as(RawStringSegmentSyntax.self)

    let indentation: SyntaxText
    let indentationTrivia: [RawTriviaPiece]

    var unexpectedBeforeOpenQuote: [RawTokenSyntax] = []
    var openQuote = openQuote
    var unexpectedBeforeCloseQuote: [RawTokenSyntax] = []
    var closeQuote = closeQuote

    // -------------------------------------------------------------------------
    // Check that the close quote is on new line

    let openQuoteHasTrailingNewline = openQuote.trailingTriviaPieces.last?.isNewline ?? false

    let closeDelimiterOnNewLine = reclassifyNewlineOfLastSegmentAsTrivia(
      rawStringDelimitersToken: rawStringDelimitersToken,
      openQuoteHasTrailingNewline: openQuoteHasTrailingNewline,
      middleSegments: &middleSegments
    )

    if !closeDelimiterOnNewLine || closeQuote.leadingTriviaByteLength != 0 {
      unexpectedBeforeCloseQuote = [closeQuote]
      closeQuote = RawTokenSyntax(missing: closeQuote.tokenKind, leadingTriviaPieces: [.newlines(1)], arena: self.arena)

      // The closing delimiter doesn't start on a new line and thus it doesn't
      // make sense to try and extract indentation from it.
      return (unexpectedBeforeOpenQuote, openQuote, allSegments, unexpectedBeforeCloseQuote, closeQuote)
    }

    // -------------------------------------------------------------------------
    // Parse indentation of the closing quote

    if let lastSegment,
      let parsedTrivia = parseIndentationTrivia(text: lastSegment.content.tokenText)
    {
      indentationTrivia = parsedTrivia
      indentation = lastSegment.content.tokenText
      closeQuote = RawTokenSyntax(
        kind: closeQuote.tokenKind,
        text: closeQuote.tokenText,
        leadingTriviaPieces: parsedTrivia + closeQuote.leadingTriviaPieces,
        trailingTriviaPieces: closeQuote.trailingTriviaPieces,
        presence: closeQuote.presence,
        tokenDiagnostic: closeQuote.tokenView.tokenDiagnostic,
        arena: self.arena
      )
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
    // Check that the open quote is followed by newline

    // Condition for the loop below that indicates whether the segment we are
    // iterating over is on a new line.

    if !openQuoteHasTrailingNewline {
      unexpectedBeforeOpenQuote = [openQuote]
      openQuote = RawTokenSyntax(missing: openQuote.tokenKind, trailingTriviaPieces: [.newlines(1)] + indentationTrivia, arena: self.arena)
    }

    // -------------------------------------------------------------------------
    // Check indentation of segments and escaped newlines at end of segment

    postProcessIndentationAndEscapedNewlineOfMiddleSegments(
      rawStringDelimitersToken: rawStringDelimitersToken,
      middleSegments: &middleSegments,
      isFirstSegmentOnNewLine: openQuoteHasTrailingNewline,
      indentation: indentation
    )

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
}

// MARK: - Parse string literals

extension Parser {
  /// Consumes a raw string or extended regex delimiter that has the same
  /// number of `#` as `openDelimiter`.
  mutating func parsePoundDelimiter(
    _ kind: RawTokenKind,
    matching openDelimiter: RawTokenSyntax?
  ) -> (unexpectedBeforeCheckedDelimiter: RawUnexpectedNodesSyntax?, checkedDelimiter: RawTokenSyntax?) {
    // Check for leadingTriviaText == "" so we don't consume the leading raw
    // string delimiter of an upcoming string literal, e.g. in
    // ```
    // "normal literal"
    // #"raw literal"#
    // ```
    let delimiter: RawTokenSyntax?
    if self.at(TokenSpec(kind)) && self.currentToken.leadingTriviaText == "" {
      delimiter = self.consumeAnyToken()
    } else {
      delimiter = nil
    }

    switch (openDelimiter, delimiter) {
    case (nil, nil):
      return (nil, nil)
    case (let open?, nil):
      return (nil, missingToken(kind, text: open.tokenText))
    case (nil, .some):
      return (RawUnexpectedNodesSyntax([delimiter], arena: self.arena), nil)
    case (let open?, let close?):
      if open.tokenText == close.tokenText {
        return (nil, close)
      } else {
        return (RawUnexpectedNodesSyntax([delimiter], arena: self.arena), missingToken(kind, text: open.tokenText))
      }
    }
  }

  /// Parse a string literal expression.
  mutating func parseStringLiteral() -> RawStringLiteralExprSyntax {
    /// Parse opening raw string delimiter if exist.
    let openingPounds = self.consume(if: .rawStringPoundDelimiter)

    /// Try to parse @ in order to recover from Objective-C style literals
    let unexpectedAtSign = self.consume(if: .atSign)

    /// Parse open quote.
    var (unexpectedBeforeOpeningQuote, openQuote) = self.expect(.stringQuote, .multilineStringQuote, default: .stringQuote)
    unexpectedBeforeOpeningQuote = RawUnexpectedNodesSyntax(combining: unexpectedAtSign, unexpectedBeforeOpeningQuote, arena: self.arena)
    var openQuoteKind: RawTokenKind = openQuote.tokenKind
    if openQuote.isMissing, let singleQuote = self.consume(if: .singleQuote) {
      unexpectedBeforeOpeningQuote = RawUnexpectedNodesSyntax(combining: unexpectedBeforeOpeningQuote, singleQuote, arena: self.arena)
      openQuoteKind = .singleQuote
    }

    /// Parse segments.
    var segments: [RawStringLiteralSegmentListSyntax.Element] = []
    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
      // If we encounter a token with leading trivia, we're no longer in the
      // string literal.
      guard currentToken.leadingTriviaText.isEmpty else { break }

      if let stringSegment = self.consume(if: .stringSegment, TokenSpec(.identifier, remapping: .stringSegment)) {
        segments.append(.stringSegment(RawStringSegmentSyntax(content: stringSegment, arena: self.arena)))
      } else if let backslash = self.consume(if: .backslash) {
        let (unexpectedBeforeDelimiter, delimiter) = self.parsePoundDelimiter(.rawStringPoundDelimiter, matching: openingPounds)
        let leftParen = self.expectWithoutRecoveryOrLeadingTrivia(.leftParen)
        let expressions = RawLabeledExprListSyntax(elements: self.parseArgumentListElements(pattern: .none), arena: self.arena)

        // For recovery, eat anything up to the next token that either starts a new string segment or terminates the string.
        // This allows us to skip over extraneous identifiers etc. in an unterminated string interpolation.
        var unexpectedBeforeRightParen: [RawTokenSyntax] = []
        var unexpectedProgress = LoopProgressCondition()
        while !self.at(.rightParen, .stringSegment, .backslash) && !self.at(TokenSpec(openQuoteKind), .endOfFile)
          && self.hasProgressed(&unexpectedProgress)
        {
          unexpectedBeforeRightParen.append(self.consumeAnyToken())
        }
        // Consume the right paren if present, ensuring that it's on the same
        // line if this is a single-line literal. Leading trivia is fine as
        // we allow e.g "\(foo )".
        let rightParen: Token
        if self.at(.rightParen) && self.atStartOfLine && openQuote.tokenKind != .multilineStringQuote {
          rightParen = missingToken(.rightParen)
        } else {
          rightParen = self.expectWithoutRecovery(.rightParen)
        }
        if case .inStringInterpolation = self.currentToken.cursor.currentState {
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
              pounds: delimiter,
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
    let unexpectedBeforeClosingQuote: RawUnexpectedNodesSyntax?
    let closingQuote: RawTokenSyntax
    if openQuoteKind == .singleQuote {
      let singleQuote = self.expectWithoutRecoveryOrLeadingTrivia(.singleQuote)
      unexpectedBeforeClosingQuote = RawUnexpectedNodesSyntax([singleQuote], arena: self.arena)
      closingQuote = missingToken(.stringQuote)
    } else {
      unexpectedBeforeClosingQuote = nil
      closingQuote = self.expectWithoutRecoveryOrLeadingTrivia(TokenSpec(openQuote.tokenKind))
    }

    let (unexpectedBeforeClosingPounds, closingPounds) = self.parsePoundDelimiter(.rawStringPoundDelimiter, matching: openingPounds)

    if openQuote.tokenKind == .multilineStringQuote, !openQuote.isMissing, !closingQuote.isMissing {
      let postProcessed = postProcessMultilineStringLiteral(
        rawStringDelimitersToken: openingPounds,
        openQuote: openQuote,
        segments: segments,
        closeQuote: closingQuote
      )
      return RawStringLiteralExprSyntax(
        openingPounds: openingPounds,
        RawUnexpectedNodesSyntax(combining: unexpectedBeforeOpeningQuote, postProcessed.unexpectedBeforeOpeningQuote, arena: self.arena),
        openingQuote: postProcessed.openingQuote,
        segments: RawStringLiteralSegmentListSyntax(elements: postProcessed.segments, arena: self.arena),
        RawUnexpectedNodesSyntax(combining: postProcessed.unexpectedBeforeClosingQuote, unexpectedBeforeClosingQuote, arena: self.arena),
        closingQuote: postProcessed.closingQuote,
        unexpectedBeforeClosingPounds,
        closingPounds: closingPounds,
        arena: self.arena
      )
    } else {
      return RawStringLiteralExprSyntax(
        openingPounds: openingPounds,
        unexpectedBeforeOpeningQuote,
        openingQuote: openQuote,
        segments: RawStringLiteralSegmentListSyntax(elements: segments, arena: self.arena),
        unexpectedBeforeClosingQuote,
        closingQuote: closingQuote,
        unexpectedBeforeClosingPounds,
        closingPounds: closingPounds,
        arena: self.arena
      )
    }
  }

  mutating func parseSimpleString() -> RawSimpleStringLiteralExprSyntax {
    let openDelimiter = self.consume(if: .rawStringPoundDelimiter)
    let (unexpectedBeforeOpenQuote, openQuote) = self.expect(anyIn: SimpleStringLiteralExprSyntax.OpeningQuoteOptions.self, default: .stringQuote)

    /// Parse segments.
    var segments: [RawStringSegmentSyntax] = []
    var loopProgress = LoopProgressCondition()
    while hasProgressed(&loopProgress) {
      // If we encounter a token with leading trivia, we're no longer in the
      // string literal.
      guard currentToken.leadingTriviaText.isEmpty else { break }

      if let stringSegment = self.consume(if: .stringSegment, TokenSpec(.identifier, remapping: .stringSegment)) {
        var unexpectedAfterContent: RawUnexpectedNodesSyntax?

        if let (backslash, leftParen) = self.consume(if: .backslash, followedBy: .leftParen) {
          var unexpectedTokens: [RawSyntax] = [RawSyntax(backslash), RawSyntax(leftParen)]

          let (unexpectedBeforeRightParen, rightParen) = self.expect(TokenSpec(.rightParen, allowAtStartOfLine: false))
          unexpectedTokens += unexpectedBeforeRightParen?.elements ?? []
          unexpectedTokens.append(RawSyntax(rightParen))

          unexpectedAfterContent = RawUnexpectedNodesSyntax(
            unexpectedTokens,
            arena: self.arena
          )
        }

        segments.append(RawStringSegmentSyntax(content: stringSegment, unexpectedAfterContent, arena: self.arena))
      } else {
        break
      }
    }

    let (unexpectedBetweenSegmentAndCloseQuote, closeQuote) = self.expect(
      anyIn: SimpleStringLiteralExprSyntax.ClosingQuoteOptions.self,
      default: openQuote.closeTokenKind
    )
    let closeDelimiter = self.consume(if: .rawStringPoundDelimiter)

    if openQuote.tokenKind == .multilineStringQuote, !openQuote.isMissing, !closeQuote.isMissing {
      let postProcessed = postProcessMultilineStringLiteral(
        rawStringDelimitersToken: openDelimiter,
        openQuote: openQuote,
        segments: segments.compactMap { RawStringLiteralSegmentListSyntax.Element.stringSegment($0) },
        closeQuote: closeQuote
      )

      return RawSimpleStringLiteralExprSyntax(
        RawUnexpectedNodesSyntax(
          combining: openDelimiter,
          unexpectedBeforeOpenQuote,
          postProcessed.unexpectedBeforeOpeningQuote,
          arena: self.arena
        ),
        openingQuote: postProcessed.openingQuote,
        segments: RawSimpleStringLiteralSegmentListSyntax(
          // `RawSimpleStringLiteralSegmentListSyntax` only accepts `RawStringSegmentSyntax`.
          // So we can safely cast.
          elements: postProcessed.segments.map { $0.cast(RawStringSegmentSyntax.self) },
          arena: self.arena
        ),
        RawUnexpectedNodesSyntax(
          combining: unexpectedBetweenSegmentAndCloseQuote,
          postProcessed.unexpectedBeforeClosingQuote,
          arena: self.arena
        ),
        closingQuote: postProcessed.closingQuote,
        RawUnexpectedNodesSyntax(
          [closeDelimiter],
          arena: self.arena
        ),
        arena: self.arena
      )
    } else {
      return RawSimpleStringLiteralExprSyntax(
        RawUnexpectedNodesSyntax(combining: unexpectedBeforeOpenQuote, openDelimiter, arena: self.arena),
        openingQuote: openQuote,
        segments: RawSimpleStringLiteralSegmentListSyntax(elements: segments, arena: self.arena),
        unexpectedBetweenSegmentAndCloseQuote,
        closingQuote: closeQuote,
        RawUnexpectedNodesSyntax([closeDelimiter], arena: self.arena),
        arena: self.arena
      )
    }
  }
}

// MARK: - Utilities

fileprivate extension RawTokenSyntax {
  var closeTokenKind: SimpleStringLiteralExprSyntax.ClosingQuoteOptions {
    switch self {
    case .multilineStringQuote:
      return .multilineStringQuote
    case .stringQuote:
      return .stringQuote
    default:
      return .stringQuote
    }
  }
}

fileprivate extension SyntaxText {
  private func hasSuffix(_ other: String) -> Bool {
    var other = other
    return other.withSyntaxText { self.hasSuffix($0) }
  }
}

fileprivate extension RawTriviaPiece {
  var isBackslash: Bool {
    switch self {
    case .backslashes: return true
    default: return false
    }
  }
}
