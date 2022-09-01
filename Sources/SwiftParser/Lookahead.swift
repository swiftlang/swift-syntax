//===------------------------ Lookahead.swift -----------------------------===//
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
  /// Token lookahead for the parser.
  ///
  /// Parser lookahead functions nearly identically to parsing, except the
  /// resulting functions do not construct syntax trees and may skip an
  /// arbitrary number of tokens ahead in the input stream. Instances of
  /// ``Lookahead`` are distinct from their parent ``Parser`` instances, so
  /// any tokens they consume will not be reflected in the parent parser.
  public struct Lookahead: TokenConsumer {
    var lexemes: Lexer.LexemeSequence
    @_spi(RawSyntax)
    public var currentToken: Lexer.Lexeme
    /// Number of tokens this ``Lookahead`` has consumed from where it was started,
    /// i.e. how far it looked ahead.
    var tokensConsumed: Int = 0

    private init(
      lexemes: Lexer.LexemeSequence,
      currentToken: Lexer.Lexeme
    ) {
      self.lexemes = lexemes
      self.currentToken = currentToken
    }

    fileprivate init(cloning other: Parser) {
      self.init(lexemes: other.lexemes, currentToken: other.currentToken)
    }

    /// Initiates a lookahead session from the current point in this
    /// lookahead session.
    func lookahead() -> Lookahead {
      return Lookahead(lexemes: self.lexemes, currentToken: self.currentToken)
    }
  }

  /// Initiates a lookahead session from the current point in this parse.
  public func lookahead() -> Lookahead {
    return Lookahead(cloning: self)
  }
}

extension Parser.Lookahead {
  @_spi(RawSyntax)
  public func peek() -> Lexer.Lexeme {
    return self.lexemes.peek()
  }
}

extension Parser.Lookahead {
  public mutating func missingToken(_ kind: RawTokenKind) {
    // do nothing
  }

  public mutating func consumeAnyToken() {
    tokensConsumed += 1
    self.currentToken = self.lexemes.advance()
  }

  /// Consumes a given token, or splits the current token into a leading token
  /// matching the given token and a trailing token and consumes the leading
  /// token.
  ///
  ///     <TOKEN> ... -> consumePrefix(<TOK>) -> [ <TOK> ] <EN> ...
  mutating func consumePrefix(_ prefix: SyntaxText, as tokenKind: RawTokenKind) {
    let tokenText = self.currentToken.tokenText

    if tokenText == prefix {
      return self.consumeAnyToken()
    }
    assert(tokenText.hasPrefix(prefix))

    // See also: Parser.consumePrefix(_:as:)
    let offset = (self.currentToken.trailingTriviaByteLength
                  + tokenText.count
                  - prefix.count)
    self.currentToken = self.lexemes.resetForSplit(of: offset)
  }
}

// MARK: Skipping Tokens

extension Parser.Lookahead {
  mutating func skipTypeAttribute() {
    // These are keywords that we accept as attribute names.
    guard self.currentToken.isIdentifier || self.at(.inKeyword) || self.at(.inoutKeyword) else {
      return
    }

    // Determine which attribute it is.
    if let attr = Parser.TypeAttribute(rawValue: self.currentToken.tokenText) {
      // Ok, it is a valid attribute, eat it, and then process it.
      self.consumeAnyToken()
      if case .convention = attr {
        guard
          self.consume(if: .leftParen) != nil,
          (self.currentToken.isIdentifier ? self.consumeIdentifier() : nil) != nil,
          self.consume(if: .rightParen) != nil
        else {
          return
        }
      }
      return
    }

    if Parser.DeclarationAttribute(rawValue: self.currentToken.tokenText) != nil {
      // This is a valid decl attribute so they should have put it on the decl
      // instead of the type.
      //
      // Recover by eating @foo(...)
      self.consumeAnyToken()
      if self.at(.leftParen) {
        var backtrack = self.lookahead()
        backtrack.skipSingle()
        // If we found '->', or 'throws' after paren, it's likely a parameter
        // of function type.
        guard backtrack.at(.arrow) || backtrack.at(.throwsKeyword) || backtrack.at(.rethrowsKeyword) || backtrack.at(.throwKeyword) else {
          self.skipSingle()
          return
        }
      }
      return
    }

    _ = self.canParseCustomAttribute()
    return
  }

  mutating func eatParseAttributeList() -> Bool {
    guard self.at(.atSign) else {
      return false
    }

    repeat {
      self.eatWithoutRecovery(.atSign)
      self.consumeIdentifier()
      if self.consume(if: .leftParen) != nil {
        while !self.at(.eof), !self.at(.rightParen), !self.at(.poundEndifKeyword) {
          self.skipSingle()
        }
        self.consume(if: .rightParen)
      }
    } while self.at(.atSign)
    return true
  }

  /// Consume tokens of lower precedence than `kind` until reaching a token of that kind.
  /// The token of `kind` is also consumed.
  @_spi(RawSyntax)
  public mutating func consume(to kind: RawTokenKind) {
    if self.consume(if: kind) != nil {
      return
    }
    var lookahead = self.lookahead()
    if lookahead.canRecoverTo(kind) {
      for _ in 0..<lookahead.tokensConsumed {
        self.consumeAnyToken()
      }
      self.consumeAnyToken()
    }
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  func isStartOfDeclaration(allowRecovery: Bool = false) -> Bool {
    // Fast path: If we are at a declaration keyword already, we don't need a subparser
    if TokenClassification.isDeclarationStart(self.currentToken) || TokenClassification.isPoundDeclarationKeyword(self.currentToken) {
      return true
    }

    var subparser = self.lookahead()

    var hasAttribute = false
    var attributeProgress = LoopProgressCondition()
    while attributeProgress.evaluate(subparser.currentToken) && subparser.at(.atSign) {
      hasAttribute = true
      _ = subparser.eatParseAttributeList()
    }

    var hasModifier = false
    var modifierProgress = LoopProgressCondition()
    while modifierProgress.evaluate(subparser.currentToken), TokenClassification.isDeclarationModifier(subparser.currentToken) {
      hasModifier = true
      subparser.consumeAnyToken()
      if subparser.at(.leftParen) {
        subparser.consumeAnyToken()
        subparser.consume(to: .rightParen)
      }
    }

    if hasAttribute || hasModifier {
      if subparser.at(.rightBrace) || subparser.at(.eof) || subparser.at(.poundEndifKeyword) {
        return true
      }
    }

    if allowRecovery {
      return subparser.canRecoverTo(TokenClassification.declarationStartKeywords, contextualPrecedences: TokenClassification.contextualDeclarationStartPrecedences) != nil
    } else {
      return TokenClassification.isDeclarationStart(subparser.currentToken)
    }
  }

  func isStartOfExpression() -> Bool {
    if self.atAny(TokenClassification.expressionStartKeywords) {
      return true
    }
    if self.currentToken.isContextualKeyword(TokenClassification.contextualExpressionStartKeywords) {
      return true
    }
    if self.at(.atSign) || self.at(.inoutKeyword) {
      var backtrack = self.lookahead()
      if backtrack.canParseType() {
        return true
      }
    }
    return false
  }

  func isParenthesizedUnowned() -> Bool {
    assert(self.currentToken.tokenText == "unowned" && self.peek().tokenKind == .leftParen,
           "Invariant violated")

    // Look ahead to parse the parenthesized expression.
    var lookahead = self.lookahead()
    lookahead.consumeIdentifier()
    guard lookahead.consume(if: .leftParen) != nil else {
      return false
    }
    return lookahead.currentToken.isIdentifier
        && lookahead.peek().tokenKind == .rightParen
        && (lookahead.currentToken.tokenText == "safe" || lookahead.currentToken.tokenText == "unsafe")
  }
}

extension Parser.Lookahead {
  func isStartOfGetSetAccessor() -> Bool {
    assert(self.at(.leftBrace), "not checking a brace?")

    // The only case this can happen is if the accessor label is immediately after
    // a brace (possibly preceded by attributes).  "get" is implicit, so it can't
    // be checked for.  Conveniently however, get/set properties are not allowed
    // to have initializers, so we don't have an ambiguity, we just have to check
    // for observing accessors.
    //
    // If we have a 'didSet' or a 'willSet' label, disambiguate immediately as
    // an accessor block.
    let nextToken = self.peek()
    if nextToken.isContextualKeyword("didSet") || nextToken.isContextualKeyword("willSet") {
      return true
    }

    // If we don't have attributes, then it cannot be an accessor block.
    if nextToken.tokenKind != .atSign {
      return false
    }

    // Eat the "{".
    var lookahead = self.lookahead()
    lookahead.eatWithoutRecovery(.leftBrace)

    // Eat attributes, if present.
    while lookahead.consume(if: .atSign) != nil {
      guard lookahead.currentToken.isIdentifier else {
        return false
      }
      lookahead.consumeIdentifier()
      // Eat paren after attribute name; e.g. @foo(x)
      if lookahead.at(.leftParen) {
        lookahead.skipSingle()
      }
    }

    // Check if we have 'didSet'/'willSet' after attributes.
    return lookahead.currentToken.isContextualKeyword("didSet") ||
           lookahead.currentToken.isContextualKeyword("willSet")
  }
}

// MARK: Skipping Tokens

extension Parser.Lookahead {
  mutating func skipUntil(_ t1: RawTokenKind, _ t2: RawTokenKind) {
    while !self.at(.eof) && !self.at(t1) && !self.at(t2)
            && !self.at(.poundEndifKeyword) && !self.at(.poundElseKeyword) && !self.at(.poundElseifKeyword) {
      self.skipSingle()
    }
  }

  mutating func skipUntilEndOfLine() {
    while !self.at(.eof) && !self.currentToken.isAtStartOfLine {
      self.skipSingle()
    }
  }

  mutating func skipSingle() {
    switch self.currentToken.tokenKind {
    case .leftParen:
      self.consumeAnyToken()
      self.skipUntil(.rightParen, .rightBrace)
      self.consume(if: .rightParen)
      return
    case .leftBrace:
      self.consumeAnyToken()
      self.skipUntil(.rightBrace, .rightBrace)
      self.consume(if: .rightBrace)
      return
    case .leftSquareBracket:
      self.consumeAnyToken()
      self.skipUntil(.rightSquareBracket, .rightSquareBracket)
      self.consume(if: .rightSquareBracket)
      return
    case .poundIfKeyword,
        .poundElseKeyword,
        .poundElseifKeyword:
      self.consumeAnyToken()
      // skipUntil also implicitly stops at tok::pound_endif.
      self.skipUntil(.poundElseKeyword, .poundElseifKeyword)

      if self.at(.poundElseKeyword) || self.at(.poundElseifKeyword) {
        self.skipSingle()
      } else {
        self.consume(if: .poundElseifKeyword)
      }
      return
    default:
      self.consumeAnyToken()
      return
    }
  }
}
