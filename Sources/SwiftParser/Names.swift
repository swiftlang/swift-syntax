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
@_spi(ExperimentalLanguageFeatures) @_spi(RawSyntax) internal import SwiftSyntax
#else
@_spi(ExperimentalLanguageFeatures) @_spi(RawSyntax) import SwiftSyntax
#endif

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
        RawUnexpectedNodesSyntax([dollarIdent], arena: self.arena),
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

extension TokenConsumer {
  /// Do the subsequent tokens have the form of a module selector? Encompasses some invalid syntax which nonetheless
  /// can be handled by `consumeModuleSelectorTokensIfPresent()`.
  ///
  /// - Postcondition: If `true`, either the current token or the next token is `.colonColon`.
  mutating func isAtModuleSelector() -> Bool {
    // If this is a module selector, the next token should be `::`.
    guard self.peek(isAt: .colonColon) else {
      // ...however, we will also allow the *current* token to be `::`. `consumeModuleSelectorTokensIfPresent()` will
      // create a missing identifier.
      return self.at(.colonColon)
    }

    // Technically the current token *should* be an identifier, but we also want to diagnose other tokens that might be
    // used by accident or given special meanings later ('_', certain keywords).
    return self.at(.identifier, .wildcard, .keyword(.Any))
      || self.at(.keyword(.self), .keyword(.Self), .keyword(.super))
  }

  mutating func unlessPeekModuleSelector<T>(_ operation: (inout Self) -> T?) -> T? {
    var lookahead = self.lookahead()
    lookahead.skipSingle()
    if lookahead.isAtModuleSelector() {
      return nil
    }
    return operation(&self)
  }

  /// If the subsequent tokens have the form of a module selector, valid or otherwise, consume and return them;
  /// otherwise consume nothing and return `nil`. Additionally consumes invalid chained module selectors.
  ///
  /// Returns a tuple comprised of:
  ///
  ///  - `moduleNameOrUnexpected`: The module name if present; in a valid module selector, this will be a present
  ///     identifier, but either of those can be untrue in invalid code.
  ///  - `colonColonToken`: The `::` indicating this module selector. Always `.colonColon`, always present.
  ///  - `extra`: Tokens for additional trailing module selectors. There is no situation in which two module selectors
  ///    can be validly chained.
  ///  - `skipQualifiedName`: True if the next token should be interpreted as a different statement.
  @_optimize(size)  // Work around SIL optimizer bug (rdar://158171994)
  mutating func consumeModuleSelectorTokensIfPresent() -> (
    moduleNameOrUnexpected: Token, colonColonToken: Token, extra: [Token], skipQualifiedName: Bool
  )? {
    guard self.isAtModuleSelector() else {
      return nil
    }

    let moduleName: Token
    let colonColonToken: Token

    // Did we forget the module name?
    if let earlyColonColon = self.consume(if: .colonColon) {
      moduleName = self.missingToken(.identifier)
      colonColonToken = earlyColonColon
    } else {
      // Consume whatever comes before the `::`, plus the `::` itself. (Whether or not the "name" is an identifier is
      // checked elsewhere.)
      moduleName = self.consumeAnyToken()
      colonColonToken = self.eat(.colonColon)
    }

    var extra: [Token] = []
    while !self.currentToken.isAtStartOfLine && self.isAtModuleSelector() {
      if !self.at(.colonColon) {
        extra.append(self.consumeAnyToken())
      }
      extra.append(self.eat(.colonColon))
    }

    let afterContainsAnyNewline = self.atStartOfLine

    return (moduleName, colonColonToken, extra, afterContainsAnyNewline)
  }
}

extension Parser {
  /// Parses one or more module selectors, if present.
  mutating func parseModuleSelectorIfPresent() -> (moduleSelector: RawModuleSelectorSyntax?, skipQualifiedName: Bool) {
    guard
      let (moduleNameOrUnexpected, colonColon, extra, skipQualifiedName) =
        consumeModuleSelectorTokensIfPresent()
    else {
      return (nil, false)
    }

    let leadingUnexpected: [RawSyntax]
    let moduleName: RawTokenSyntax
    let trailingUnexpected: [RawSyntax]

    if moduleNameOrUnexpected.tokenKind == .identifier {
      leadingUnexpected = []
      moduleName = moduleNameOrUnexpected
    } else {
      leadingUnexpected = [RawSyntax(moduleNameOrUnexpected)]
      moduleName = RawTokenSyntax(missing: .identifier, arena: arena)
    }

    trailingUnexpected = extra.map { RawSyntax($0) }

    return (
      moduleSelector: RawModuleSelectorSyntax(
        RawUnexpectedNodesSyntax(leadingUnexpected, arena: arena),
        moduleName: moduleName,
        colonColon: colonColon,
        RawUnexpectedNodesSyntax(trailingUnexpected, arena: arena),
        arena: arena
      ),
      skipQualifiedName: skipQualifiedName
    )
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
    // Consume the module selector, if present, and base name.
    let (moduleSelector, base) = self.parseDeclReferenceBase(flags)

    // Parse an argument list, if the flags allow it and it's present.
    let args = self.parseArgLabelList(flags)
    return RawDeclReferenceExprSyntax(
      moduleSelector: moduleSelector,
      baseName: base,
      argumentNames: args,
      arena: self.arena
    )
  }

  private mutating func parseDeclReferenceBase(
    _ flags: DeclNameOptions
  ) -> (moduleSelector: RawModuleSelectorSyntax?, base: RawTokenSyntax) {
    // Consume a module selector if present.
    let (moduleSelector, skipQualifiedName) = self.parseModuleSelectorIfPresent()

    // Consume the base name.
    if !skipQualifiedName {
      if let identOrInit = self.consume(if: .identifier, .keyword(.`init`)) {
        return (moduleSelector, identOrInit)
      }
      if moduleSelector == nil, let selfOrSelf = self.consume(if: .keyword(.`self`), .keyword(.`Self`)) {
        return (moduleSelector, selfOrSelf)
      }
      if flags.contains(.operators), let (_, _) = self.at(anyIn: Operator.self) {
        return (moduleSelector, self.consumeAnyToken(remapping: .binaryOperator))
      }
      if flags.contains(.keywordsUsingSpecialNames),
        let special = self.consume(if: .keyword(.`deinit`), .keyword(.`subscript`))
      {
        return (moduleSelector, special)
      }
      if (flags.contains(.keywords) || moduleSelector != nil) && self.currentToken.isLexerClassifiedKeyword {
        return (moduleSelector, self.consumeAnyToken(remapping: .identifier))
      }
    }
    return (moduleSelector, missingToken(.identifier))
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

    let identifierType = self.parseTypeIdentifier()
    var result = RawTypeSyntax(identifierType)

    // There are no nested types inside `Any`.
    if case TokenSpec.keyword(.Any) = identifierType.name {
      return result
    }

    func hasAnotherMember() -> Bool {
      // If qualified name base type cannot be parsed from the current
      // point (i.e. the next type identifier is not followed by a '.'),
      // then the next identifier is the final declaration name component.
      var lookahead = self.lookahead()
      return lookahead.consume(ifPrefix: ".", as: .period) != nil && lookahead.canParseBaseTypeForQualifiedDeclName()
    }

    guard hasAnotherMember() else {
      return result
    }

    var keepGoing = self.consume(if: .period)
    var loopProgress = LoopProgressCondition()
    while keepGoing != nil && self.hasProgressed(&loopProgress) {
      let (memberModuleSelector, skipQualifiedName) = self.parseModuleSelectorIfPresent()
      let name = self.parseMemberTypeName(moduleSelector: memberModuleSelector, skipName: skipQualifiedName)
      let generics: RawGenericArgumentClauseSyntax?
      if self.at(prefix: "<") {
        generics = self.parseGenericArguments()
      } else {
        generics = nil
      }
      result = RawTypeSyntax(
        RawMemberTypeSyntax(
          baseType: result,
          period: keepGoing!,
          moduleSelector: memberModuleSelector,
          name: name,
          genericArgumentClause: generics,
          arena: self.arena
        )
      )

      guard !skipQualifiedName && hasAnotherMember() else {
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
