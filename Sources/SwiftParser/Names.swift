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
    guard self.currentToken.canBeArgumentLabel(allowDollarIdentifier: true) else {
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

  mutating func parseDeclNameRef(_ flags: DeclNameOptions = []) -> (RawTokenSyntax, RawDeclNameArgumentsSyntax?) {
    // Consume the base name.
    let base: RawTokenSyntax
    if let identOrSelf = self.consume(if: .identifier, .keyword(.self), .keyword(.Self)) ?? self.consume(if: .keyword(.`init`)) {
      base = identOrSelf
    } else if flags.contains(.operators), let (_, _) = self.at(anyIn: Operator.self) {
      base = self.consumeAnyToken(remapping: .binaryOperator)
    } else if flags.contains(.keywords) && self.currentToken.isLexerClassifiedKeyword {
      base = self.consumeAnyToken(remapping: .identifier)
    } else {
      base = missingToken(.identifier)
    }

    // Parse an argument list, if the flags allow it and it's present.
    let args = self.parseArgLabelList(flags)
    return (base, args)
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
    let next = self.peek()

    // A close parenthesis, if empty lists are allowed.
    let nextIsRParen = flags.contains(.zeroArgCompoundNames) && next.rawTokenKind == .rightParen
    // An argument label.
    let nextIsArgLabel = next.canBeArgumentLabel() || next.rawTokenKind == .colon

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
      while !self.at(.eof, .rightParen) && loopProgress.evaluate(currentToken) {
        // Check to see if there is an argument label.
        precondition(self.currentToken.canBeArgumentLabel() && self.peek().rawTokenKind == .colon)
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
      arena: self.arena
    )
  }

  mutating func parseQualifiedTypeIdentifier() -> RawTypeSyntax {
    if self.at(.keyword(.Any)) {
      return RawTypeSyntax(self.parseAnyType())
    }

    var result: RawTypeSyntax?
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let (unexpectedBeforeName, name) = self.expect(.identifier, .keyword(.self), .keyword(.Self), default: .identifier)
      let generics: RawGenericArgumentClauseSyntax?
      if self.atContextualPunctuator("<") {
        generics = self.parseGenericArguments()
      } else {
        generics = nil
      }
      if let keepGoing = keepGoing {
        result = RawTypeSyntax(
          RawMemberTypeIdentifierSyntax(
            baseType: result!,
            period: keepGoing,
            unexpectedBeforeName,
            name: name,
            genericArgumentClause: generics,
            arena: self.arena
          )
        )
      } else {
        result = RawTypeSyntax(
          RawSimpleTypeIdentifierSyntax(
            unexpectedBeforeName,
            name: name,
            genericArgumentClause: generics,
            arena: self.arena
          )
        )
      }

      // If qualified name base type cannot be parsed from the current
      // point (i.e. the next type identifier is not followed by a '.'),
      // then the next identifier is the final declaration name component.
      var backtrack = self.lookahead()
      backtrack.consumePrefix(".", as: .period)
      guard backtrack.canParseBaseTypeForQualifiedDeclName() else {
        break
      }

      keepGoing = self.consume(if: .period)
    } while keepGoing != nil && loopProgress.evaluate(currentToken)

    return result!
  }
}

extension Parser.Lookahead {
  func canParseBaseTypeForQualifiedDeclName() -> Bool {
    var lookahead = self.lookahead()
    guard lookahead.canParseTypeIdentifier() else {
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
    while !lookahead.at(.eof, .rightParen) && loopProgress.evaluate(lookahead.currentToken) {
      // Check to see if there is an argument label.
      guard lookahead.currentToken.canBeArgumentLabel() && lookahead.peek().rawTokenKind == .colon else {
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
  func canBeArgumentLabel(allowDollarIdentifier: Bool = false) -> Bool {
    // `inout` is reserved as an argument label for historical reasons.
    if TypeSpecifier(lexeme: self) == .inout {
      return false
    }

    switch self.rawTokenKind {
    case .identifier, .wildcard:
      // Identifiers, escaped identifiers, and '_' can be argument labels.
      return true
    case .dollarIdentifier:
      return allowDollarIdentifier
    default:
      // All other keywords can be argument labels.
      return self.isLexerClassifiedKeyword
    }
  }

  func isContextualPunctuator(_ name: SyntaxText) -> Bool {
    return Operator(lexeme: self) != nil && self.tokenText == name
  }

  var isLexerClassifiedKeyword: Bool {
    // Only lexer-classified lexemes have `RawTokenKind` of `keyword.
    // Contextual keywords will only be made keywords when a `RawTokenSyntax` is
    // constructed from them.
    return self.rawTokenKind == .keyword
  }

  func starts(with symbol: SyntaxText) -> Bool {
    guard Operator(lexeme: self) != nil || self.rawTokenKind.isPunctuation else {
      return false
    }

    return self.tokenText.hasPrefix(symbol)
  }
}
