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
    if let token = self.consume(if: .identifier) {
      return token
    } else if let (_, handle) = self.at(anyIn: Operator.self) {
      return self.eat(handle)
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
    if self.at(.identifier) || self.at(any: [.selfKeyword, .capitalSelfKeyword]) {
      ident = self.expectIdentifierWithoutRecovery()
    } else if flags.contains(.operators), let (_, _) = self.at(anyIn: Operator.self) {
      ident = self.consumeAnyToken(remapping: .unspacedBinaryOperator)
    } else if flags.contains(.keywords) && self.currentToken.tokenKind.isKeyword {
      ident = self.consumeAnyToken(remapping: .identifier)
    } else {
      ident = self.expectIdentifierWithoutRecovery()
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
    guard self.at(.leftParen, where: { !$0.isAtStartOfLine }) else {
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

extension Parser {
  mutating func parseQualifiedDeclarationName() -> RawQualifiedDeclNameSyntax {
    let type: RawTypeSyntax?
    let dot: RawTokenSyntax?
    if self.lookahead().canParseBaseTypeForQualifiedDeclName() {
      type = self.parseQualifiedTypeIdentifier()
      dot = self.consumePrefix(".", as: .period)
    } else {
      type = nil
      dot = nil
    }

    let (name, args) = self.parseDeclNameRef([
      .zeroArgCompoundNames,
      .keywordsUsingSpecialNames,
      .operators,
    ])
    return RawQualifiedDeclNameSyntax(
      baseType: type,
      dot: dot,
      name: name,
      arguments: args,
      arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseQualifiedTypeIdentifier() -> RawTypeSyntax {
    if self.at(.anyKeyword) {
      return RawTypeSyntax(self.parseAnyType())
    }

    var result: RawTypeSyntax?
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let (name, _) = self.parseDeclNameRef()
      let generics: RawGenericArgumentClauseSyntax?
      if self.atContextualPunctuator("<") {
        generics = self.parseGenericArguments()
      } else {
        generics = nil
      }
      if let keepGoing = keepGoing {
        result = RawTypeSyntax(RawMemberTypeIdentifierSyntax(
          baseType: result!,
          period: keepGoing,
          name: name,
          genericArgumentClause: generics,
          arena: self.arena))
      } else {
        result = RawTypeSyntax(RawSimpleTypeIdentifierSyntax(
          name: name, genericArgumentClause: generics, arena: self.arena))
      }

      // If qualified name base type cannot be parsed from the current
      // point (i.e. the next type identifier is not followed by a '.'),
      // then the next identifier is the final declaration name component.
      var backtrack = self.lookahead()
      backtrack.consumePrefix(".", as: .period)
      guard backtrack.canParseBaseTypeForQualifiedDeclName() else {
        break
      }

      keepGoing = self.consume(if: .period) ?? self.consume(if: .prefixPeriod)
    } while keepGoing != nil && loopProgress.evaluate(currentToken)

    return result!
  }
}

extension Parser.Lookahead {
  func canParseBaseTypeForQualifiedDeclName() -> Bool {
    var lookahead = self.lookahead()
    guard lookahead.canParseSimpleTypeIdentifier() else {
      return false
    }
    return lookahead.currentToken.starts(with: ".")
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

  func isContextualPunctuator(_ name: SyntaxText) -> Bool {
    return Operator(lexeme: self) != nil && self.tokenText == name
  }

  var isKeyword: Bool {
    self.tokenKind.isKeyword
  }

  func starts(with symbol: SyntaxText) -> Bool {
    guard Operator(lexeme: self) != nil || self.tokenKind.isPunctuation else {
      return false
    }

    return self.tokenText.hasPrefix(symbol)
  }
}

