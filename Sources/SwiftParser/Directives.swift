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

extension Parser {
  mutating func atEndOfIfConfigClauseBody() -> Bool {
    return self.at(.poundElseif, .poundElse, .poundEndif) || self.atElifTypo()
  }

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
  /// - Parameters:
  ///   - parseBody: Parse a body of single conditional compilation clause.
  mutating func parsePoundIfDirective(
    _ parseBody: (_ parser: inout Parser) -> RawIfConfigClauseSyntax.Elements?
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
    let condition = self.parseSequenceExpression(flavor: .poundIfDirective)
    let unexpectedBetweenConditionAndElements = self.consumeRemainingTokenOnLine()

    clauses.append(
      RawIfConfigClauseSyntax(
        unexpectedBeforePoundIf,
        poundKeyword: poundIf,
        condition: condition,
        unexpectedBetweenConditionAndElements,
        elements: parseBody(&self),
        arena: self.arena
      )
    )

    // Proceed to parse #if continuation clauses (#elseif, #else, check #elif typo, #endif)
    var loopProgress = LoopProgressCondition()
    LOOP: while let (match, handle) = self.canRecoverTo(anyIn: IfConfigContinuationClauseStartKeyword.self),
      self.hasProgressed(&loopProgress)
    {
      var unexpectedBeforePound: RawUnexpectedNodesSyntax?
      var pound: RawTokenSyntax
      let condition: RawExprSyntax?
      let unexpectedBetweenConditionAndElements: RawUnexpectedNodesSyntax?

      switch match {
      case .poundElseif:
        (unexpectedBeforePound, pound) = self.eat(handle)
        condition = self.parseSequenceExpression(flavor: .poundIfDirective)
        unexpectedBetweenConditionAndElements = self.consumeRemainingTokenOnLine()
      case .poundElse:
        (unexpectedBeforePound, pound) = self.eat(handle)
        if let ifToken = self.consume(if: .init(.if, allowAtStartOfLine: false)) {
          unexpectedBeforePound = RawUnexpectedNodesSyntax(
            combining: unexpectedBeforePound,
            pound,
            ifToken,
            arena: self.arena
          )
          pound = self.missingToken(.poundElseif)
          condition = self.parseSequenceExpression(flavor: .poundIfDirective)
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
          unexpectedBeforePound = RawUnexpectedNodesSyntax(
            combining: unexpectedBeforePound,
            pound,
            elif,
            arena: self.arena
          )
          pound = self.missingToken(.poundElseif)
          condition = self.parseSequenceExpression(flavor: .poundIfDirective)
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
          elements: parseBody(&self),
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
}

extension Parser {
  /// Parse a line control directive.
  mutating func parsePoundSourceLocationDirective() -> RawPoundSourceLocationSyntax {
    let line = self.consumeAnyToken()
    let (unexpectedBeforeLParen, lparen) = self.expect(TokenSpec(.leftParen, allowAtStartOfLine: false))
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
