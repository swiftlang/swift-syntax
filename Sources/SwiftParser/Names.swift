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
  mutating func parseAnyIdentifier() -> RawTokenSyntax {
    if let token = self.consume(if: .identifier) {
      return token
    } else if let (_, handle) = self.at(anyIn: Operator.self) {
      return self.eat(handle)
    } else {
      return RawTokenSyntax(missing: .identifier, arena: arena)
    }
  }

  mutating func parseArgumentLabel() -> (RawUnexpectedNodesSyntax?, RawTokenSyntax) {
    guard self.atArgumentLabel(allowDollarIdentifier: true) else {
      return (nil, missingToken(.identifier))
    }
    if let dollarIdent = self.consume(if: .dollarIdentifier) {
      return (
        RawUnexpectedNodesSyntax(elements: [RawSyntax(dollarIdent)], arena: self.arena),
        self.missingToken(.identifier)
      )
    } else {
      if let wildcardToken = self.consume(if: .wildcard) {
        return (nil, wildcardToken)
      }
      return (nil, self.consumeAnyToken(remapping: .identifier))
    }
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
    static let keywordsUsingSpecialNames: Self = [.keywords, Self(rawValue: 1 << 2)]
    /// If passed, compound names with argument lists are allowed, unless they
    /// have empty argument lists.
    static let compoundNames = Self(rawValue: 1 << 4)

    /// If passed, compound names with empty argument lists are allowed.
    static let zeroArgCompoundNames: Self = [.compoundNames, Self(rawValue: 1 << 5)]
  }

  mutating func parseDeclReferenceExpr(_ flags: DeclNameOptions = []) -> RawDeclReferenceExprSyntax {
    // Consume the base name.
    let base: RawTokenSyntax
    if let identOrSelf = self.consume(if: .identifier, .keyword(.self), .keyword(.Self)) ?? self.consume(if: .keyword(.`init`)) {
      base = identOrSelf
    } else if flags.contains(.operators), let (_, _) = self.at(anyIn: Operator.self) {
      base = self.consumeAnyToken(remapping: .binaryOperator)
    } else if flags.contains(.keywordsUsingSpecialNames),
      let special = self.consume(if: .keyword(.`deinit`), .keyword(.`subscript`))
    {
      base = special
    } else if flags.contains(.keywords) && self.currentToken.isLexerClassifiedKeyword {
      base = self.consumeAnyToken(remapping: .identifier)
    } else {
      base = missingToken(.identifier)
    }

    // Parse an argument list, if the flags allow it and it's present.
    let args = self.parseArgLabelList(flags)
    return RawDeclReferenceExprSyntax(
      baseName: base,
      argumentNames: args,
      arena: self.arena
    )
  }

  mutating func parseArgLabelList(_ flags: DeclNameOptions) -> RawDeclNameArgumentsSyntax? {
    guard flags.contains(.compoundNames) else {
      return nil
    }

    // Is the current token a left paren?
    guard self.at(TokenSpec(.leftParen, allowAtStartOfLine: false)) else {
      return nil
    }

    // Okay, let's look ahead and see if the next token is something that could
    // be in an arg label list...
    // A close parenthesis, if empty lists are allowed.
    let nextIsRParen = flags.contains(.zeroArgCompoundNames) && peek(isAt: .rightParen)
    // An argument label.
    let nextIsArgLabel = peek().isArgumentLabel() || peek(isAt: .colon)

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
      while !self.at(.endOfFile, .rightParen) && self.hasProgressed(&loopProgress) {
        // Check to see if there is an argument label.
        precondition(self.atArgumentLabel() && self.peek(isAt: .colon))
        let name = self.consumeAnyToken()
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        elements.append(
          RawDeclNameArgumentSyntax(
            name: name,
            unexpectedBeforeColon,
            colon: colon,
            arena: arena
          )
        )
      }
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawDeclNameArgumentsSyntax(
      unexpectedBeforeLParen,
      leftParen: lparen,
      arguments: RawDeclNameArgumentListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: arena
    )
  }
}

extension Parser {
  mutating func parseQualifiedDeclarationName() -> RawExprSyntax {
    let type: RawExprSyntax?
    let period: RawTokenSyntax?

    if self.lookahead().canParseBaseTypeForQualifiedDeclName() {
      type = RawExprSyntax(RawTypeExprSyntax(type: self.parseQualifiedTypeIdentifier(), arena: self.arena))
      period = self.expectWithoutRecovery(prefix: ".", as: .period)
    } else {
      type = nil
      period = nil
    }

    let declName = self.parseDeclReferenceExpr([
      .zeroArgCompoundNames,
      .keywordsUsingSpecialNames,
      .operators,
    ])
    if let period = period {
      return RawExprSyntax(
        RawMemberAccessExprSyntax(
          base: type,
          period: period,
          declName: declName,
          arena: self.arena
        )
      )
    } else {
      return RawExprSyntax(declName)
    }
  }

  mutating func parseQualifiedTypeIdentifier() -> RawTypeSyntax {
    if self.at(.keyword(.Any)) {
      return RawTypeSyntax(self.parseAnyType())
    }

    let (unexpectedBeforeName, name) = self.expect(anyIn: IdentifierTypeSyntax.NameOptions.self, default: .identifier)
    let generics: RawGenericArgumentClauseSyntax?
    if self.atContextualPunctuator("<") {
      generics = self.parseGenericArguments()
    } else {
      generics = nil
    }

    var result = RawTypeSyntax(
      RawIdentifierTypeSyntax(
        unexpectedBeforeName,
        name: name,
        genericArgumentClause: generics,
        arena: self.arena
      )
    )

    // If qualified name base type cannot be parsed from the current
    // point (i.e. the next type identifier is not followed by a '.'),
    // then the next identifier is the final declaration name component.
    var lookahead = self.lookahead()
    guard
      lookahead.consume(ifPrefix: ".", as: .period) != nil,
      lookahead.canParseBaseTypeForQualifiedDeclName()
    else {
      return result
    }

    var keepGoing = self.consume(if: .period)
    var loopProgress = LoopProgressCondition()
    while keepGoing != nil && self.hasProgressed(&loopProgress) {
      let (unexpectedBeforeName, name) = self.expect(.identifier, .keyword(.self), TokenSpec(.Self, remapping: .identifier), default: .identifier)
      let generics: RawGenericArgumentClauseSyntax?
      if self.atContextualPunctuator("<") {
        generics = self.parseGenericArguments()
      } else {
        generics = nil
      }
      result = RawTypeSyntax(
        RawMemberTypeSyntax(
          baseType: result,
          period: keepGoing!,
          unexpectedBeforeName,
          name: name,
          genericArgumentClause: generics,
          arena: self.arena
        )
      )

      // If qualified name base type cannot be parsed from the current
      // point (i.e. the next type identifier is not followed by a '.'),
      // then the next identifier is the final declaration name component.
      var lookahead = self.lookahead()
      guard
        lookahead.consume(ifPrefix: ".", as: .period) != nil,
        lookahead.canParseBaseTypeForQualifiedDeclName()
      else {
        break
      }

      keepGoing = self.consume(if: .period)
    }

    return result
  }
}

extension Parser.Lookahead {
  func canParseBaseTypeForQualifiedDeclName() -> Bool {
    var lookahead = self.lookahead()
    guard lookahead.canParseTypeIdentifier() else {
      return false
    }
    return lookahead.at(prefix: ".")
  }
}

extension Parser.Lookahead {
  func canParseArgumentLabelList() -> Bool {
    var lookahead = self.lookahead()
    guard lookahead.consume(if: .leftParen) != nil else {
      return false
    }

    var loopProgress = LoopProgressCondition()
    while !lookahead.at(.endOfFile, .rightParen) && lookahead.hasProgressed(&loopProgress) {
      // Check to see if there is an argument label.
      guard lookahead.atArgumentLabel() && lookahead.peek().rawTokenKind == .colon else {
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
  func isArgumentLabel(allowDollarIdentifier: Bool = false) -> Bool {
    switch self {
    case .identifier, .wildcard:
      // Identifiers, escaped identifiers, and '_' can be argument labels.
      return true
    case .dollarIdentifier:
      return allowDollarIdentifier
    case .keyword(.inout):
      // `inout` cannot be an argument label for historical reasons.
      return false
    default:
      // All other keywords can be argument labels.
      return self.isLexerClassifiedKeyword
    }
  }

  func isContextualPunctuator(_ name: SyntaxText) -> Bool {
    // Currently we can ignore experimental features since a new kind of
    // non-prefix/infix/postfix operator seems unlikely.
    return Operator(lexeme: self, experimentalFeatures: []) != nil && self.tokenText == name
  }

  var isLexerClassifiedKeyword: Bool {
    // Only lexer-classified lexemes have ``RawTokenKind`` of `keyword.
    // Contextual keywords will only be made keywords when a ``RawTokenSyntax`` is
    // constructed from them.
    return self.rawTokenKind == .keyword
  }
}
