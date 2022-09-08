//===-------------------------- Names.swift -------------------------------===//
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
  mutating func parseAnyIdentifier() -> RawTokenSyntax {
    if self.currentToken.isIdentifier || self.currentToken.isAnyOperator {
      return self.consumeAnyToken()
    } else {
      return RawTokenSyntax(missing: .identifier, arena: arena)
    }
  }

  mutating func parseArgumentLabel() -> RawTokenSyntax {
    assert(self.currentToken.canBeArgumentLabel)
    return self.consumeAnyToken()
  }
}

extension Parser {
  struct DeclNameOptions: OptionSet {
    var rawValue: UInt8

    /// If passed, operator basenames are allowed.
    static let operators = Self(rawValue: 1 << 0)

    /// If passed, names that coincide with keywords are allowed. Used after a
    /// dot to enable things like '.init' and '.default'.
    static let keywords = Self(rawValue: 1 << 1)

    /// If passed, 'deinit' and 'subscript' should be parsed as special names,
    /// not ordinary identifiers.
    static let keywordsUsingSpecialNames: Self = [ .keywords, Self(rawValue: 1 << 2) ]
    /// If passed, compound names with argument lists are allowed, unless they
    /// have empty argument lists.
    static let compoundNames = Self(rawValue: 1 << 4)

    /// If passed, compound names with empty argument lists are allowed.
    static let zeroArgCompoundNames: Self = [ .compoundNames, Self(rawValue: 1 << 5) ]
  }

  mutating func parseDeclNameRef(_ flags: DeclNameOptions = []) -> (RawTokenSyntax, RawDeclNameArgumentsSyntax?) {
    // Consume the base name.
    let ident: RawTokenSyntax
    if self.currentToken.isIdentifier || self.at(any: [.selfKeyword, .capitalSelfKeyword]) {
      ident = self.consumeIdentifier()
    } else if flags.contains(.operators) && self.currentToken.isAnyOperator {
      ident = self.consume(remapping: .identifier)
    } else if flags.contains(.keywords) && self.currentToken.tokenKind.isKeyword {
      ident = self.consume(remapping: .identifier)
    } else {
      ident = self.consumeIdentifier()
    }

    // Parse an argument list, if the flags allow it and it's present.
    let args = self.parseArgLabelList(flags)
    return (ident, args)
  }

  mutating func parseArgLabelList(_ flags: DeclNameOptions) -> RawDeclNameArgumentsSyntax? {
    guard flags.contains(.compoundNames) else {
      return nil
    }

    // Is the current token a left paren?
    guard self.at(.leftParen) && !self.currentToken.isAtStartOfLine else {
      return nil
    }

    // Okay, let's look ahead and see if the next token is something that could
    // be in an arg label list...
    let next = self.peek()

    // A close parenthesis, if empty lists are allowed.
    let nextIsRParen = flags.contains(.zeroArgCompoundNames) && next.tokenKind == .rightParen
    // An argument label.
    let nextIsArgLabel = next.canBeArgumentLabel || next.tokenKind == .colon

    guard nextIsRParen || nextIsArgLabel else {
      return nil
    }

    guard self.lookahead().canParseArgumentLabelList() else {
      return nil
    }
    return self.parsePresentArgumentLabelList()
  }

  mutating func parsePresentArgumentLabelList() -> RawDeclNameArgumentsSyntax {
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    var elements = [RawDeclNameArgumentSyntax]()
    do {
      var loopProgress = LoopProgressCondition()
      while !self.at(any: [.eof, .rightParen]) && loopProgress.evaluate(currentToken) {
        // Check to see if there is an argument label.
        assert(self.currentToken.canBeArgumentLabel && self.peek().tokenKind == .colon)
        let name = self.consumeAnyToken()
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        elements.append(RawDeclNameArgumentSyntax(
          name: name,
          unexpectedBeforeColon,
          colon: colon,
          arena: arena
        ))
      }
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawDeclNameArgumentsSyntax(
      unexpectedBeforeLParen,
      leftParen: lparen,
      arguments: RawDeclNameArgumentListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: arena)
  }
}

extension Parser.Lookahead {
  func canParseArgumentLabelList() -> Bool {
    var lookahead = self.lookahead()
    guard lookahead.consume(if: .leftParen) != nil else {
      return false
    }

    var loopProgress = LoopProgressCondition()
    while !lookahead.at(any: [.eof, .rightParen]) && loopProgress.evaluate(lookahead.currentToken) {
      // Check to see if there is an argument label.
      guard lookahead.currentToken.canBeArgumentLabel && lookahead.peek().tokenKind == .colon else {
        return false
      }

      lookahead.consumeAnyToken()
      guard lookahead.consume(if: .colon) != nil else {
        return false
      }
    }

    guard lookahead.consume(if: .rightParen) != nil else {
      return false
    }

    return true
  }
}

extension Lexer.Lexeme {
  var canBeArgumentLabel: Bool {
    switch self.tokenKind {
    case .identifier where self.tokenText == "__shared" || self.tokenText == "__owned":
      return false
    case .identifier, .wildcardKeyword:
      // Identifiers, escaped identifiers, and '_' can be argument labels.
      return true
    case .inoutKeyword:
      // inout cannot be used as an argument label.
      return false
    default:
      // All other keywords can be argument labels.
      return self.isKeyword
    }
  }

  var isBinaryOperator: Bool {
    return (self.tokenKind == .spacedBinaryOperator ||
            self.tokenKind == .unspacedBinaryOperator)
  }

  var isAnyOperator: Bool {
    return (self.isBinaryOperator ||
            self.tokenKind == .postfixOperator ||
            self.tokenKind == .prefixOperator)
  }

  func isContextualKeyword(_ name: SyntaxText) -> Bool {
    switch self.tokenKind {
    case .identifier, .contextualKeyword:
      return self.tokenText == name
    default:
      return false
    }
  }

  func isContextualKeyword(_ names: [SyntaxText]) -> Bool {
    switch self.tokenKind {
    case .identifier, .contextualKeyword:
      return names.contains(self.tokenText)
    default:
      return false
    }
  }

  func isContextualDeclKeyword() -> Bool {
    guard self.isIdentifier else {
      return false
    }
    switch self.tokenText {
    case "final",
      "required",
      "optional",
      "lazy",
      "dynamic",
      "infix",
      "prefix",
      "postfix",
      "_compilerInitialized",
      "__consuming",
      "mutating",
      "nonmutating",
      "convenience",
      "override",
      "open",
      "weak",
      "unowned",
      "indirect",
      "actor",
      "isolated",
      "async",
      "nonisolated",
      "distributed",
      "_const",
      "_local":
      return true
    default:
      return false
    }
  }

  func isContextualPunctuator(_ name: SyntaxText) -> Bool {
    return self.isAnyOperator && self.tokenText == name
  }

  var isKeyword: Bool {
    self.tokenKind.isKeyword
  }

  var isPunctuation: Bool {
    self.tokenKind.isPunctuation
  }

  var isIdentifier: Bool {
    return self.tokenKind == .identifier
  }

  var isEllipsis: Bool {
    return self.isAnyOperator && self.tokenText == "..."
  }


  var isEffectsSpecifier: Bool {
    // NOTE: If this returns 'true', that token must be handled in
    //       'parseEffectsSpecifiers()'.

    if (self.isContextualKeyword("async") ||
        (self.isContextualKeyword("await") && !self.isAtStartOfLine) ||
        self.isContextualKeyword("reasync")) {
      return true
    }

    // 'throws' and 'rethrows' are always valid effects specifiers.
    if self.tokenKind == .throwsKeyword || self.tokenKind == .rethrowsKeyword {
      return true
    }

    // We'll take 'throw' and 'try' too but they have to be on the same
    // line as the declaration they're modifying.
    if (self.tokenKind == .throwKeyword
        || self.tokenKind == .tryKeyword)
        && !self.isAtStartOfLine {
      return true
    }

    return false;
  }

  var isKeywordPossibleDeclStart: Bool {
    switch self.tokenKind {
    case .atSign,
        .associatedtypeKeyword,
        .caseKeyword,
        .classKeyword,
        .deinitKeyword,
        .enumKeyword,
        .extensionKeyword,
        .fileprivateKeyword,
        .funcKeyword,
        .importKeyword,
        .initKeyword,
        .internalKeyword,
        .letKeyword,
        .operatorKeyword,
        .precedencegroupKeyword,
        .privateKeyword,
        .protocolKeyword,
        .publicKeyword,
        .staticKeyword,
        .structKeyword,
        .subscriptKeyword,
        .typealiasKeyword,
        .varKeyword,
        .poundIfKeyword,
        .poundWarningKeyword,
        .poundErrorKeyword,
        .identifier,
        .poundSourceLocationKeyword:
      return true
    case .poundLineKeyword:
      // #line at the start of the line is a directive, but it's deprecated.
      // #line within a line is an expression.
      return self.isAtStartOfLine
    default:
      return false
    }
  }

  func starts(with symbol: SyntaxText) -> Bool {
    guard self.isAnyOperator || self.isPunctuation else {
      return false
    }

    return self.tokenText.hasPrefix(symbol)
  }
}

extension TokenConsumer {
  mutating func consumeIdentifier() -> Token {
    switch self.currentToken.tokenKind {
    case .selfKeyword,
        .capitalSelfKeyword,
        .anyKeyword,
        .identifier:
      return self.consumeAnyToken()
    default:
      return self.missingToken(.identifier)
    }
  }

  mutating func consumeIdentifierOrRethrows() -> Token {
    switch self.currentToken.tokenKind {
    case .selfKeyword,
        .capitalSelfKeyword,
        .anyKeyword,
        .identifier,
        .rethrowsKeyword:
      return self.consumeAnyToken()
    default:
      return self.missingToken(.identifier)
    }
  }

  mutating func consumeInteger() -> Token {
    switch self.currentToken.tokenKind {
    case .integerLiteral:
      return self.consumeAnyToken()
    default:
      return self.missingToken(.integerLiteral)
    }
  }
}
