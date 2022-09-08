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
      self.eat(.atSign)
      self.consumeIdentifierOrRethrows()
      if self.consume(if: .leftParen) != nil {
        while !self.at(.eof), !self.at(.rightParen), !self.at(.poundEndifKeyword) {
          self.skipSingle()
        }
        self.consume(if: .rightParen)
      }
    } while self.at(.atSign)
    return true
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  private static let declAttributeNames: Set<SyntaxText> = [
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

  func isStartOfDeclaration() -> Bool {
    guard self.currentToken.isKeywordPossibleDeclStart else {
      // If this is obviously not the start of a decl, then we're done.
      return false
    }

    /*
     // When 'init' appears inside another 'init', it's likely the user wants to
     // invoke an initializer but forgets to prefix it with 'self.' or 'super.'
     // Otherwise, expect 'init' to be the start of a declaration (and complain
     // when the expectation is not fulfilled).
     if (Tok.is(tok::kw_init)) {
       return !isa<ConstructorDecl>(CurDeclContext);
     }
     */

    // Similarly, when 'case' appears inside a function, it's probably a switch
    // case, not an enum case declaration.
    if self.at(.caseKeyword) {
      return false
    }

    /*
     // The protocol keyword needs more checking to reject "protocol<Int>".
     if (Tok.is(tok::kw_protocol)) {
       const Token &Tok2 = peekToken();
       return !Tok2.isAnyOperator() || !Tok2.getText().equals("<");
     }

     // The 'try' case is only for simple local recovery, so we only bother to
     // check 'let' and 'var' right now.
     if (Tok.is(tok::kw_try))
       return peekToken().isAny(tok::kw_let, tok::kw_var);
     */

    // Skip an attribute, since it might be a type attribute.  This can't
    // happen at the top level of a scope, but we do use isStartOfSwiftDecl()
    // in positions like generic argument lists.
    if self.at(.atSign) {
      var subparser = self.lookahead()
      _ = subparser.eatParseAttributeList()
      // If this attribute is the last element in the block,
      // consider it is a start of incomplete decl.
      if subparser.at(.rightBrace) || subparser.at(.eof) || subparser.at(.poundEndifKeyword) {
        return true
      }
      return subparser.isStartOfDeclaration()
    }

    // If we have a decl modifying keyword, check if the next token is a valid
    // decl start. This is necessary to correctly handle Swift keywords that are
    // shared by SIL, e.g 'private' in 'sil private @foo :'. We need to make sure
    // this isn't considered a valid Swift decl start.
    if self.currentToken.tokenKind.isKeyword {
      if Self.declAttributeNames.contains(self.currentToken.tokenText) {
        var subparser = self.lookahead()
        subparser.consumeAnyToken()

        // Eat paren after modifier name; e.g. private(set)
        if subparser.consume(if: .leftParen) != nil {
          while !subparser.at(.eof) && !subparser.at(.rightBrace) && !subparser.at(.poundEndifKeyword) {
            if subparser.consume(if: .rightParen) != nil {
              break
            }

            // If we found the start of a decl while trying to skip over the
            // paren, then we have something incomplete like 'private('. Return
            // true for better recovery.
            if subparser.isStartOfDeclaration() {
              return true
            }

            subparser.consumeAnyToken()
          }
        }
        return subparser.isStartOfDeclaration()
      }
    }

    // Otherwise, the only hard case left is the identifier case.
    guard self.currentToken.isIdentifier else {
      return true
    }

    // If this is an operator declaration, handle it.
    if case .operatorKeyword = self.peek().tokenKind,
        (self.currentToken.isContextualKeyword("prefix") ||
         self.currentToken.isContextualKeyword("postfix") ||
         self.currentToken.isContextualKeyword("infix")) {
      return true
    }

    // If this can't possibly be a contextual keyword, then this identifier is
    // not interesting.  Bail out.
    guard self.currentToken.isContextualDeclKeyword() else {
      return false
    }

    // If it might be, we do some more digging.

    // If this is 'unowned', check to see if it is valid.
    let tok2 = self.peek()
    if self.currentToken.tokenText == "unowned" && tok2.tokenKind == .leftParen &&
        self.isParenthesizedUnowned() {
      var lookahead = self.lookahead()
      lookahead.consumeIdentifier()
      lookahead.eat(.leftParen)
      lookahead.consumeIdentifier()
      lookahead.eat(.rightParen)
      return lookahead.isStartOfDeclaration()
    }

    if self.currentToken.isContextualKeyword("actor") {
      if tok2.isIdentifier {
        return true
      }
      // actor may be somewhere in the modifier list. Eat the tokens until we get
      // to something that isn't the start of a decl. If that is an identifier,
      // it's an actor declaration, otherwise, it isn't.
      var lookahead = self.lookahead()
      repeat {
        lookahead.consumeAnyToken()
      } while lookahead.isStartOfDeclaration()
      return lookahead.currentToken.isIdentifier
    }

    // If the next token is obviously not the start of a decl, bail early.
    guard tok2.isKeywordPossibleDeclStart else {
      return false
    }

    // Otherwise, do a recursive parse.
    var next = self.lookahead()
    next.consumeIdentifier()
    return next.isStartOfDeclaration()
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
    lookahead.eat(.leftBrace)

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
