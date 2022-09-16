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
    public func lookahead() -> Lookahead {
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
  @_spi(RawSyntax)
  public mutating func missingToken(_ kind: RawTokenKind, text: SyntaxText?) {
    // do nothing
  }

  public mutating func consumeAnyToken() {
    tokensConsumed += 1
    self.currentToken = self.lexemes.advance()
  }

  public mutating func consumeAnyToken(remapping: RawTokenKind) {
    self.consumeAnyToken()
  }

  /// Consume tokens of lower precedence than `kind` until reaching a token of that kind.
  /// The token of `kind` is also consumed.
  @_spi(RawSyntax)
  public mutating func consume(to kind: RawTokenKind) {
    if self.consume(if: kind) != nil {
      return
    }
    var lookahead = self.lookahead()
    if lookahead.canRecoverTo([kind]) != nil {
      for _ in 0..<lookahead.tokensConsumed {
        self.consumeAnyToken()
      }
      self.consumeAnyToken()
    }
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
    guard self.at(.identifier) || self.at(any: [.inKeyword, .inoutKeyword]) else {
      return
    }

    // Determine which attribute it is.
    if let (attr, handle) = self.at(anyIn: Parser.TypeAttribute.self) {
      // Ok, it is a valid attribute, eat it, and then process it.
      self.eat(handle)
      if case .convention = attr {
        guard
          self.consume(if: .leftParen) != nil,
          self.consume(if: .identifier) != nil,
          self.consume(if: .rightParen) != nil
        else {
          return
        }
      }
      return
    }

    if let (_, handle) = self.at(anyIn: Parser.DeclarationAttribute.self) {
      // This is a valid decl attribute so they should have put it on the decl
      // instead of the type.
      //
      // Recover by eating @foo(...)
      self.eat(handle)
      if self.at(.leftParen) {
        var backtrack = self.lookahead()
        backtrack.skipSingle()
        // If we found '->', or 'throws' after paren, it's likely a parameter
        // of function type.
        guard backtrack.at(any: [.arrow, .throwsKeyword, .rethrowsKeyword, .throwKeyword]) else {
          self.skipSingle()
          return
        }
      }
      return
    }

    _ = self.canParseCustomAttribute()
    return
  }

  /// Consumes the current token, and asserts that the kind of token that was
  /// consumed matches the given kind.
  ///
  /// If the token kind did not match, this function will abort. It is useful
  /// to insert structural invariants during parsing.
  ///
  /// - Parameter kind: The kind of token to consume.
  /// - Returns: A token of the given kind.
  public mutating func eat(_ kind: RawTokenKind) -> Token {
    return self.consume(if: kind)!
  }
}

extension Parser.Lookahead {
  mutating func consumeAttributeList() -> Bool {
    guard self.at(.atSign) else {
      return false
    }

    while let _ = self.consume(if: .atSign) {
      // Consume qualified names that may or may not involve generic arguments.
      repeat {
        self.expectIdentifierOrRethrowsWithoutRecovery()
        // We don't care whether this succeeds or fails to eat generic
        // parameters.
        _ = self.consumeGenericArguments()
      } while self.consume(if: .period) != nil

      if self.consume(if: .leftParen) != nil {
        while !self.at(any: [.eof, .rightParen, .poundEndifKeyword]) {
          self.skipSingle()
        }
        self.consume(if: .rightParen)
      }
    }
    return true
  }

  mutating func consumeIfConfigOfAttributes() -> Bool {
    while true {
      // #if / #else / #elseif
      self.consumeAnyToken()

      // <expression>
      self.skipUntilEndOfLine()

      while true {
        if self.at(.atSign) {
          _ = self.consumeAttributeList()
          continue
        }

        if self.at(.poundIfKeyword) {
          _ = self.consumeIfConfigOfAttributes()
          continue
        }

        break
      }

      guard self.at(any: [ .poundElseifKeyword, .poundElseKeyword ]) else {
        break
      }
    }

    // If we ran out of tokens, say we consumed the rest.
    if self.at(.eof) {
      return true
    }

    guard self.currentToken.isAtStartOfLine else {
      return false
    }
    return self.consume(if: .poundEndifKeyword) != nil
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  private static let declAttributeNames: [SyntaxText] = [
    "autoclosure",
    "convention",
    "noescape",
    "escaping",
    "differentiable",
    "noDerivative",
    "async",
    "Sendable",
    "unchecked",
    "_typeSequence",
    "_local",
    "block_storage",
    "box",
    "dynamic_self",
    "sil_weak",
    "sil_unowned",
    "sil_unmanaged",
    "error",
    "out",
    "in",
    "inout",
    "inout_aliasable",
    "in_guaranteed",
    "in_constant",
    "owned",
    "unowned_inner_pointer",
    "guaranteed",
    "autoreleased",
    "callee_owned",
    "callee_guaranteed",
    "objc_metatype",
    "opened",
    "pseudogeneric",
    "yields",
    "yield_once",
    "yield_many",
    "captures_generics",
    "thin",
    "thick",
    "_opaqueReturnTypeOf",
  ]

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
    if nextToken.isContextualKeyword(["didSet", "willSet"]) {
      return true
    }

    // If we don't have attributes, then it cannot be an accessor block.
    if nextToken.tokenKind != .atSign {
      return false
    }

    // Eat the "{".
    var lookahead = self.lookahead()
    lookahead.eat(.leftBrace)

    // Eat attributes, if present.
    while lookahead.consume(if: .atSign) != nil {
      guard lookahead.consume(if: .identifier) != nil else {
        return false
      }
      // Eat paren after attribute name; e.g. @foo(x)
      if lookahead.at(.leftParen) {
        lookahead.skipSingle()
      }
    }

    // Check if we have 'didSet'/'willSet' after attributes.
    return lookahead.at(any: [], contextualKeywords: ["didSet", "willSet"])
  }
}

// MARK: Skipping Tokens

extension Parser.Lookahead {
  mutating func skipUntil(_ t1: RawTokenKind, _ t2: RawTokenKind) {
    while !self.at(any: [.eof, t1, t2, .poundEndifKeyword, .poundElseKeyword, .poundElseifKeyword]) {
      self.skipSingle()
    }
  }

  mutating func skipUntilEndOfLine() {
    while !self.at(.eof) && !self.currentToken.isAtStartOfLine {
      self.skipSingle()
    }
  }

  mutating func skipSingle() {
    enum BracketedTokens: RawTokenKindSubset {
      case leftParen
      case leftBrace
      case leftSquareBracket
      case poundIfKeyword
      case poundElseKeyword
      case poundElseifKeyword

      init?(lexeme: Lexer.Lexeme) {
        switch lexeme.tokenKind {
        case .leftParen: self = .leftParen
        case .leftBrace: self = .leftBrace
        case .leftSquareBracket: self = .leftSquareBracket
        case .poundIfKeyword: self = .poundIfKeyword
        case .poundElseKeyword: self = .poundElseKeyword
        case .poundElseifKeyword: self = .poundElseifKeyword
        default: return nil
        }
      }

      var rawTokenKind: RawTokenKind {
        switch self {
        case .leftParen: return .leftParen
        case .leftBrace: return .leftBrace
        case .leftSquareBracket: return .leftSquareBracket
        case .poundIfKeyword: return .poundIfKeyword
        case .poundElseKeyword: return .poundElseKeyword
        case .poundElseifKeyword: return .poundElseifKeyword
        }
      }
    }

    switch self.at(anyIn: BracketedTokens.self) {
    case (.leftParen, let handle)?:
      self.eat(handle)
      self.skipUntil(.rightParen, .rightBrace)
      self.consume(if: .rightParen)
      return
    case (.leftBrace, let handle)?:
      self.eat(handle)
      self.skipUntil(.rightBrace, .rightBrace)
      self.consume(if: .rightBrace)
      return
    case (.leftSquareBracket, let handle)?:
      self.eat(handle)
      self.skipUntil(.rightSquareBracket, .rightSquareBracket)
      self.consume(if: .rightSquareBracket)
      return
    case (.poundIfKeyword, let handle)?,
        (.poundElseKeyword, let handle)?,
        (.poundElseifKeyword, let handle)?:
      self.eat(handle)
      // skipUntil also implicitly stops at tok::pound_endif.
      self.skipUntil(.poundElseKeyword, .poundElseifKeyword)

      if self.at(any: [.poundElseKeyword, .poundElseifKeyword]) {
        self.skipSingle()
      } else {
        self.consume(if: .poundElseifKeyword)
      }
      return
    case nil:
      self.consumeAnyToken()
      return
    }
  }
}
