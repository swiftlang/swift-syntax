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
  private enum IfConfigContinuationClauseStartKeyword: TokenSpecSet {
    case poundElseif
    case poundElse
    case pound

    var spec: TokenSpec {
      switch self {
      case .poundElseif: return .poundElseif
      case .poundElse: return .poundElse
      case .pound: return TokenSpec(.pound, recoveryPrecedence: .openingPoundIf)
      }
    }

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.poundElseif): self = .poundElseif
      case TokenSpec(.poundElse): self = .poundElse
      case TokenSpec(.pound): self = .pound
      default: return nil
      }
    }
  }

  /// Parse a conditional compilation block.
  ///
  /// This function should be used to parse conditional compilation statements,
  /// declarations, and expressions. It is generic over the particular kind of
  /// parse that must occur for these elements, and allows a context-specific
  /// syntax kind to be emitted to collect the results. For example, declaration
  /// parsing parses items and collects the items into a ``MemberDeclListSyntax``
  /// node.
  ///
  /// - Parameters:
  ///   - parseElement: Parse an element of the conditional compilation block.
  ///   - addSemicolonIfNeeded: If elements need to be separated by a newline, this
  ///                   allows the insertion of missing semicolons to the
  ///                   previous element.
  ///   - syntax: A function that aggregates the parsed conditional elements
  ///             into a syntax collection.
  mutating func parsePoundIfDirective<Element: RawSyntaxNodeProtocol>(
    _ parseElement: (_ parser: inout Parser, _ isFirstElement: Bool) -> Element?,
    addSemicolonIfNeeded: (_ lastElement: Element, _ newItemAtStartOfLine: Bool, _ parser: inout Parser) -> Element? = { _, _, _ in nil },
    syntax: (inout Parser, [Element]) -> RawIfConfigClauseSyntax.Elements?
  ) -> RawIfConfigDeclSyntax {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawIfConfigDeclSyntax(
        remainingTokens,
        clauses: RawIfConfigClauseListSyntax(elements: [], arena: self.arena),
        poundEndif: missingToken(.poundEndif),
        arena: self.arena
      )
    }

    var clauses = [RawIfConfigClauseSyntax]()

    // Parse #if
    let (unexpectedBeforePoundIf, poundIf) = self.expect(.poundIf)
    let condition = RawExprSyntax(self.parseSequenceExpression(flavor: .poundIfDirective))
    let unexpectedBetweenConditionAndElements = self.consumeRemainingTokenOnLine()

    clauses.append(
      RawIfConfigClauseSyntax(
        unexpectedBeforePoundIf,
        poundKeyword: poundIf,
        condition: condition,
        unexpectedBetweenConditionAndElements,
        elements: syntax(&self, parseIfConfigClauseElements(parseElement, addSemicolonIfNeeded: addSemicolonIfNeeded)),
        arena: self.arena
      )
    )

    // Proceed to parse #if continuation clauses (#elseif, #else, check #elif typo, #endif)
    var loopProgress = LoopProgressCondition()
    LOOP: while let (match, handle) = self.canRecoverTo(anyIn: IfConfigContinuationClauseStartKeyword.self), self.hasProgressed(&loopProgress) {
      var unexpectedBeforePound: RawUnexpectedNodesSyntax?
      var pound: RawTokenSyntax
      let condition: RawExprSyntax?
      let unexpectedBetweenConditionAndElements: RawUnexpectedNodesSyntax?

      switch match {
      case .poundElseif:
        (unexpectedBeforePound, pound) = self.eat(handle)
        condition = RawExprSyntax(self.parseSequenceExpression(flavor: .poundIfDirective))
        unexpectedBetweenConditionAndElements = self.consumeRemainingTokenOnLine()
      case .poundElse:
        (unexpectedBeforePound, pound) = self.eat(handle)
        if let ifToken = self.consume(if: .init(.if, allowAtStartOfLine: false)) {
          unexpectedBeforePound = RawUnexpectedNodesSyntax(combining: unexpectedBeforePound, pound, ifToken, arena: self.arena)
          pound = self.missingToken(.poundElseif)
          condition = RawExprSyntax(self.parseSequenceExpression(flavor: .poundIfDirective))
        } else {
          condition = nil
        }
        unexpectedBetweenConditionAndElements = self.consumeRemainingTokenOnLine()
      case .pound:
        if self.atElifTypo() {
          (unexpectedBeforePound, pound) = self.eat(handle)
          guard let elif = self.consume(if: TokenSpec(.identifier, allowAtStartOfLine: false)) else {
            preconditionFailure("The current token should be an identifier, guaranteed by the `atElifTypo` check.")
          }
          unexpectedBeforePound = RawUnexpectedNodesSyntax(combining: unexpectedBeforePound, pound, elif, arena: self.arena)
          pound = self.missingToken(.poundElseif)
          condition = RawExprSyntax(self.parseSequenceExpression(flavor: .poundIfDirective))
          unexpectedBetweenConditionAndElements = self.consumeRemainingTokenOnLine()
        } else {
          break LOOP
        }
      }

      clauses.append(
        RawIfConfigClauseSyntax(
          unexpectedBeforePound,
          poundKeyword: pound,
          condition: condition,
          unexpectedBetweenConditionAndElements,
          elements: syntax(&self, parseIfConfigClauseElements(parseElement, addSemicolonIfNeeded: addSemicolonIfNeeded)),
          arena: self.arena
        )
      )
    }

    let (unexpectedBeforePoundEndIf, poundEndIf) = self.expect(.poundEndif)
    let unexpectedAfterPoundEndif = self.consumeRemainingTokenOnLine()
    return RawIfConfigDeclSyntax(
      clauses: RawIfConfigClauseListSyntax(elements: clauses, arena: self.arena),
      unexpectedBeforePoundEndIf,
      poundEndif: poundEndIf,
      unexpectedAfterPoundEndif,
      arena: self.arena
    )
  }

  private mutating func atElifTypo() -> Bool {
    guard self.at(TokenSpec(.pound)), self.currentToken.trailingTriviaText.isEmpty else {
      return false
    }
    var lookahead = self.lookahead()
    lookahead.consumeAnyToken()  // consume `#`
    guard lookahead.at(TokenSpec(.identifier, allowAtStartOfLine: false)),
      lookahead.currentToken.tokenText == "elif",
      lookahead.currentToken.leadingTriviaText.isEmpty
    else {
      return false  // `#` and `elif` must not be separated by trivia
    }
    lookahead.consumeAnyToken()  // consume `elif`
    // We are only at a `elif` typo if it’s followed by an identifier for the condition.
    // `#elif` or `#elif(…)` could be macro invocations.
    return lookahead.at(TokenSpec(.identifier, allowAtStartOfLine: false))
  }

  private mutating func parseIfConfigClauseElements<Element: RawSyntaxNodeProtocol>(
    _ parseElement: (_ parser: inout Parser, _ isFirstElement: Bool) -> Element?,
    addSemicolonIfNeeded: (_ lastElement: Element, _ newItemAtStartOfLine: Bool, _ parser: inout Parser) -> Element?
  ) -> [Element] {
    var elements = [Element]()
    var elementsProgress = LoopProgressCondition()
    while !self.at(.endOfFile)
      && !self.at(.poundElse, .poundElseif, .poundEndif)
      && !self.atElifTypo()
      && self.hasProgressed(&elementsProgress)
    {
      let newItemAtStartOfLine = self.atStartOfLine
      guard let element = parseElement(&self, elements.isEmpty), !element.isEmpty else {
        break
      }
      if let lastElement = elements.last, let fixedUpLastItem = addSemicolonIfNeeded(lastElement, newItemAtStartOfLine, &self) {
        elements[elements.count - 1] = fixedUpLastItem
      }
      elements.append(element)
    }
    return elements
  }
}

extension Parser {
  /// Parse a line control directive.
  mutating func parsePoundSourceLocationDirective() -> RawPoundSourceLocationSyntax {
    let line = self.consumeAnyToken()
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    let arguments: RawPoundSourceLocationArgumentsSyntax?
    if !self.at(.rightParen) {
      let (unexpectedBeforeFile, file) = self.expect(.keyword(.file))
      let (unexpectedBeforeFileColon, fileColon) = self.expect(.colon)
      let fileName = self.parseSimpleString()
      let (unexpectedBeforeComma, comma) = self.expect(.comma)

      let (unexpectedBeforeLine, line) = self.expect(.keyword(.line))
      let (unexpectedBeforeLineColon, lineColon) = self.expect(.colon)
      let lineNumber = self.expectWithoutRecovery(.integerLiteral)

      arguments = RawPoundSourceLocationArgumentsSyntax(
        unexpectedBeforeFile,
        fileLabel: file,
        unexpectedBeforeFileColon,
        fileColon: fileColon,
        fileName: fileName,
        unexpectedBeforeComma,
        comma: comma,
        unexpectedBeforeLine,
        lineLabel: line,
        unexpectedBeforeLineColon,
        lineColon: lineColon,
        lineNumber: lineNumber,
        arena: self.arena
      )
    } else {
      arguments = nil
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    let unexpectedAfterRightParen = self.consumeRemainingTokenOnLine()

    return RawPoundSourceLocationSyntax(
      poundSourceLocation: line,
      unexpectedBeforeLParen,
      leftParen: lparen,
      arguments: arguments,
      unexpectedBeforeRParen,
      rightParen: rparen,
      unexpectedAfterRightParen,
      arena: self.arena
    )
  }
}
