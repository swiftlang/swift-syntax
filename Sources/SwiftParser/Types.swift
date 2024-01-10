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
  /// Parse a type.
  mutating func parseType(misplacedSpecifiers: [RawTokenSyntax] = []) -> RawTypeSyntax {
    // Parse pack expansion 'repeat T'.
    if let repeatKeyword = self.consume(if: .keyword(.repeat)) {
      let repetitionPattern = self.parseTypeScalar(misplacedSpecifiers: misplacedSpecifiers)
      return RawTypeSyntax(
        RawPackExpansionTypeSyntax(
          repeatKeyword: repeatKeyword,
          repetitionPattern: repetitionPattern,
          arena: self.arena
        )
      )
    }

    return self.parseTypeScalar(misplacedSpecifiers: misplacedSpecifiers)
  }

  mutating func parseTypeScalar(misplacedSpecifiers: [RawTokenSyntax] = []) -> RawTypeSyntax {
    let (specifier, unexpectedBeforeAttrList, attrList) = self.parseTypeAttributeList(misplacedSpecifiers: misplacedSpecifiers)
    var base = RawTypeSyntax(self.parseSimpleOrCompositionType())
    if self.withLookahead({ $0.atFunctionTypeArrow() }) {
      var effectSpecifiers = self.parseTypeEffectSpecifiers()
      let returnClause = self.parseFunctionReturnClause(effectSpecifiers: &effectSpecifiers, allowNamedOpaqueResultType: false)

      let unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax?
      let leftParen: RawTokenSyntax
      let unexpectedBetweenLeftParenAndElements: RawUnexpectedNodesSyntax?
      let parameters: RawTupleTypeElementListSyntax
      let unexpectedBetweenElementsAndRightParen: RawUnexpectedNodesSyntax?
      let rightParen: RawTokenSyntax
      if let input = base.as(RawTupleTypeSyntax.self) {
        unexpectedBeforeLeftParen = input.unexpectedBeforeLeftParen
        leftParen = input.leftParen
        unexpectedBetweenLeftParenAndElements = input.unexpectedBetweenLeftParenAndElements
        parameters = input.elements
        unexpectedBetweenElementsAndRightParen = input.unexpectedBetweenElementsAndRightParen
        rightParen = input.rightParen
      } else {
        unexpectedBeforeLeftParen = nil
        leftParen = RawTokenSyntax(missing: .leftParen, arena: self.arena)
        unexpectedBetweenLeftParenAndElements = nil
        parameters = RawTupleTypeElementListSyntax(
          elements: [
            RawTupleTypeElementSyntax(
              inoutKeyword: nil,
              firstName: nil,
              secondName: nil,
              colon: nil,
              type: base,
              ellipsis: nil,
              trailingComma: nil,
              arena: self.arena
            )
          ],
          arena: self.arena
        )
        unexpectedBetweenElementsAndRightParen = nil
        rightParen = RawTokenSyntax(missing: .rightParen, arena: self.arena)
      }

      base = RawTypeSyntax(
        RawFunctionTypeSyntax(
          unexpectedBeforeLeftParen,
          leftParen: leftParen,
          unexpectedBetweenLeftParenAndElements,
          parameters: parameters,
          unexpectedBetweenElementsAndRightParen,
          rightParen: rightParen,
          effectSpecifiers: effectSpecifiers,
          returnClause: returnClause,
          arena: self.arena
        )
      )
    }

    if unexpectedBeforeAttrList != nil || specifier != nil || !attrList.isEmpty {
      return RawTypeSyntax(
        RawAttributedTypeSyntax(
          specifier: specifier,
          unexpectedBeforeAttrList,
          attributes: attrList,
          baseType: base,
          arena: self.arena
        )
      )
    } else {
      return RawTypeSyntax(base)
    }
  }

  /// Parse a protocol composition involving at least one element.
  mutating func parseSimpleOrCompositionType() -> RawTypeSyntax {
    // 'each' is a contextual keyword for a pack reference.
    if let each = consume(if: .keyword(.each)) {
      let packType = parseSimpleType()
      return RawTypeSyntax(
        RawPackElementTypeSyntax(
          eachKeyword: each,
          pack: packType,
          arena: self.arena
        )
      )
    }

    let someOrAny = self.consume(if: .keyword(.some), .keyword(.any))

    var base = self.parseSimpleType()
    guard self.atContextualPunctuator("&") else {
      if let someOrAny {
        return RawTypeSyntax(
          RawSomeOrAnyTypeSyntax(
            someOrAnySpecifier: someOrAny,
            constraint: base,
            arena: self.arena
          )
        )
      } else {
        return base
      }
    }

    var elements = [RawCompositionTypeElementSyntax]()
    if let firstAmpersand = self.consumeIfContextualPunctuator("&") {
      elements.append(
        RawCompositionTypeElementSyntax(
          type: base,
          ampersand: firstAmpersand,
          arena: self.arena
        )
      )

      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let elementType = self.parseSimpleType()
        keepGoing = self.consumeIfContextualPunctuator("&")
        elements.append(
          RawCompositionTypeElementSyntax(
            type: elementType,
            ampersand: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)

      base = RawTypeSyntax(
        RawCompositionTypeSyntax(
          elements: RawCompositionTypeElementListSyntax(elements: elements, arena: self.arena),
          arena: self.arena
        )
      )
    }

    if let someOrAny {
      return RawTypeSyntax(
        RawSomeOrAnyTypeSyntax(
          someOrAnySpecifier: someOrAny,
          constraint: base,
          arena: self.arena
        )
      )
    } else {
      return base
    }
  }

  /// Parse a "simple" type
  mutating func parseSimpleType(
    stopAtFirstPeriod: Bool = false
  ) -> RawTypeSyntax {
    enum TypeBaseStart: TokenSpecSet {
      case `Self`
      case `Any`
      case identifier
      case leftParen
      case leftSquare
      case wildcard

      init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
        switch PrepareForKeywordMatch(lexeme) {
        case .keyword(.Self): self = .Self
        case .keyword(.Any): self = .Any
        case .identifier: self = .identifier
        case .leftParen: self = .leftParen
        case .leftSquare: self = .leftSquare
        case .wildcard: self = .wildcard
        default: return nil
        }
      }

      var spec: TokenSpec {
        switch self {
        case .Self: return .keyword(.Self)
        case .Any: return .keyword(.Any)
        case .identifier: return .identifier
        case .leftParen: return .leftParen
        case .leftSquare: return .leftSquare
        case .wildcard: return .wildcard
        }
      }
    }

    // Eat any '~' preceding the type.
    let maybeTilde = self.consumeIfContextualPunctuator("~", remapping: .prefixOperator)

    // Wrap as a suppressed type if needed.
    func wrapInTilde(_ node: RawTypeSyntax) -> RawTypeSyntax {
      if let tilde = maybeTilde {
        return RawTypeSyntax(
          RawSuppressedTypeSyntax(
            withoutTilde: tilde,
            type: node,
            arena: self.arena
          )
        )
      }
      return node
    }

    var base: RawTypeSyntax
    switch self.at(anyIn: TypeBaseStart.self)?.spec {
    case .Self, .Any, .identifier:
      base = self.parseTypeIdentifier()
    case .leftParen:
      base = RawTypeSyntax(self.parseTupleTypeBody())
    case .leftSquare:
      base = RawTypeSyntax(self.parseCollectionType())
    case .wildcard:
      base = RawTypeSyntax(self.parsePlaceholderType())
    case nil:
      return wrapInTilde(RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)))
    }

    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
      if !stopAtFirstPeriod, self.at(.period) {
        let (unexpectedPeriod, period, skipMemberName) = self.consumeMemberPeriod(previousNode: base)
        if skipMemberName {
          let missingIdentifier = missingToken(.identifier)
          base = RawTypeSyntax(
            RawMemberTypeSyntax(
              baseType: base,
              unexpectedPeriod,
              period: period,
              name: missingIdentifier,
              genericArgumentClause: nil,
              arena: self.arena
            )
          )
          break
        } else if self.at(.keyword(.Type)) || self.at(.keyword(.Protocol)) {
          let metatypeSpecifier = self.consume(if: .keyword(.Type)) ?? self.consume(if: .keyword(.Protocol))!
          base = RawTypeSyntax(
            RawMetatypeTypeSyntax(
              baseType: base,
              unexpectedPeriod,
              period: period,
              metatypeSpecifier: metatypeSpecifier,
              arena: self.arena
            )
          )
        } else {
          let name: RawTokenSyntax
          if let handle = self.at(anyIn: MemberTypeSyntax.NameOptions.self)?.handle {
            name = self.eat(handle)
          } else if self.currentToken.isLexerClassifiedKeyword {
            name = self.consumeAnyToken(remapping: .identifier)
          } else {
            name = missingToken(.identifier)
          }
          let generics: RawGenericArgumentClauseSyntax?
          if self.atContextualPunctuator("<") {
            generics = self.parseGenericArguments()
          } else {
            generics = nil
          }
          base = RawTypeSyntax(
            RawMemberTypeSyntax(
              baseType: base,
              unexpectedPeriod,
              period: period,
              name: name,
              genericArgumentClause: generics,
              arena: self.arena
            )
          )
        }
        continue
      }

      if self.at(TokenSpec(.postfixQuestionMark, allowAtStartOfLine: false)) {
        base = RawTypeSyntax(self.parseOptionalType(base))
        continue
      }
      if self.at(TokenSpec(.exclamationMark, allowAtStartOfLine: false)) {
        base = RawTypeSyntax(self.parseImplicitlyUnwrappedOptionalType(base))
        continue
      }

      break
    }

    base = wrapInTilde(base)

    return base
  }

  /// Parse an optional type.
  mutating func parseOptionalType(_ base: RawTypeSyntax) -> RawOptionalTypeSyntax {
    let (unexpectedBeforeMark, mark) = self.expect(.postfixQuestionMark)
    return RawOptionalTypeSyntax(
      wrappedType: base,
      unexpectedBeforeMark,
      questionMark: mark,
      arena: self.arena
    )
  }

  /// Parse an optional type.
  mutating func parseImplicitlyUnwrappedOptionalType(_ base: RawTypeSyntax) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
    let (unexpectedBeforeMark, mark) = self.expect(.exclamationMark)
    return RawImplicitlyUnwrappedOptionalTypeSyntax(
      wrappedType: base,
      unexpectedBeforeMark,
      exclamationMark: mark,
      arena: self.arena
    )
  }

  /// Parse a type identifier.
  mutating func parseTypeIdentifier() -> RawTypeSyntax {
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

    return RawTypeSyntax(
      RawIdentifierTypeSyntax(
        unexpectedBeforeName,
        name: name,
        genericArgumentClause: generics,
        arena: self.arena
      )
    )
  }

  /// Parse the existential `Any` type.
  mutating func parseAnyType() -> RawIdentifierTypeSyntax {
    let (unexpectedBeforeName, name) = self.expect(.keyword(.Any))
    return RawIdentifierTypeSyntax(
      unexpectedBeforeName,
      name: name,
      genericArgumentClause: nil,
      arena: self.arena
    )
  }

  /// Parse a type placeholder.
  mutating func parsePlaceholderType() -> RawIdentifierTypeSyntax {
    let (unexpectedBeforeName, name) = self.expect(.wildcard)
    return RawIdentifierTypeSyntax(
      unexpectedBeforeName,
      name: name,
      genericArgumentClause: nil,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse the generic arguments applied to a type.
  mutating func parseGenericArguments() -> RawGenericArgumentClauseSyntax {
    let langle = self.expectWithoutRecovery(prefix: "<", as: .leftAngle)
    var arguments = [RawGenericArgumentSyntax]()
    do {
      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let type = self.parseType()
        if arguments.isEmpty && type.is(RawMissingTypeSyntax.self) {
          break
        }
        keepGoing = self.consume(if: .comma)
        arguments.append(
          RawGenericArgumentSyntax(
            argument: type,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && self.hasProgressed(&loopProgress)
    }

    let rangle = self.expectWithoutRecovery(prefix: ">", as: .rightAngle)

    let args: RawGenericArgumentListSyntax
    if arguments.isEmpty && rangle.isMissing {
      args = RawGenericArgumentListSyntax(elements: [], arena: self.arena)
    } else {
      args = RawGenericArgumentListSyntax(elements: arguments, arena: self.arena)
    }
    return RawGenericArgumentClauseSyntax(
      leftAngle: langle,
      arguments: args,
      rightAngle: rangle,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a tuple type.
  mutating func parseTupleTypeBody() -> RawTupleTypeSyntax {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawTupleTypeSyntax(
        remainingTokens,
        leftParen: missingToken(.leftParen),
        elements: RawTupleTypeElementListSyntax(elements: [], arena: self.arena),
        rightParen: missingToken(.rightParen),
        arena: self.arena
      )
    }

    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    var elements = [RawTupleTypeElementSyntax]()
    do {
      var keepGoing = true
      var loopProgress = LoopProgressCondition()
      while !self.at(.endOfFile, .rightParen) && keepGoing && self.hasProgressed(&loopProgress) {
        let unexpectedBeforeFirst: RawUnexpectedNodesSyntax?
        let first: RawTokenSyntax?
        let unexpectedBeforeSecond: RawUnexpectedNodesSyntax?
        let second: RawTokenSyntax?
        let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
        let colon: RawTokenSyntax?
        var misplacedSpecifiers: [RawTokenSyntax] = []
        if self.withLookahead({ $0.startsParameterName(isClosure: false, allowMisplacedSpecifierRecovery: true) }) {
          while canHaveParameterSpecifier,
            let specifier = self.consume(ifAnyIn: TypeSpecifier.self)
          {
            misplacedSpecifiers.append(specifier)
          }
          (unexpectedBeforeFirst, first) = self.parseArgumentLabel()
          if let parsedColon = self.consume(if: .colon) {
            unexpectedBeforeSecond = nil
            second = nil
            unexpectedBeforeColon = nil
            colon = parsedColon
          } else if self.atArgumentLabel(allowDollarIdentifier: true) && self.peek(isAt: .colon) {
            (unexpectedBeforeSecond, second) = self.parseArgumentLabel()
            (unexpectedBeforeColon, colon) = self.expect(.colon)
          } else {
            unexpectedBeforeSecond = nil
            second = nil
            unexpectedBeforeColon = nil
            colon = RawTokenSyntax(missing: .colon, arena: self.arena)
          }
        } else {
          unexpectedBeforeFirst = nil
          first = nil
          unexpectedBeforeSecond = nil
          second = nil
          unexpectedBeforeColon = nil
          colon = nil
        }

        // In the case that the input is "(foo bar)" we have to decide whether we parse it as "(foo: bar)" or "(foo, bar)".
        // As most people write identifiers lowercase and types capitalized, we decide on the first character of the first token
        if let first,
          second == nil,
          colon?.isMissing == true,
          first.tokenKind == .identifier,
          first.tokenText.isStartingWithUppercase
        {
          elements.append(
            RawTupleTypeElementSyntax(
              inoutKeyword: nil,
              firstName: nil,
              secondName: nil,
              RawUnexpectedNodesSyntax(combining: misplacedSpecifiers, unexpectedBeforeColon, arena: self.arena),
              colon: nil,
              type: RawTypeSyntax(RawIdentifierTypeSyntax(name: first, genericArgumentClause: nil, arena: self.arena)),
              ellipsis: nil,
              trailingComma: self.missingToken(.comma),
              arena: self.arena
            )
          )
          keepGoing = true
          continue
        }
        // Parse the type annotation.
        let type = self.parseType(misplacedSpecifiers: misplacedSpecifiers)
        let ellipsis = self.consumeIfContextualPunctuator("...", remapping: .ellipsis)
        var trailingComma = self.consume(if: .comma)
        if trailingComma == nil && self.withLookahead({ $0.canParseType() }) {
          // If the next token does not close the tuple, it is very likely the user forgot the comma.
          trailingComma = self.missingToken(.comma)
        }
        keepGoing = trailingComma != nil
        elements.append(
          RawTupleTypeElementSyntax(
            inoutKeyword: nil,
            RawUnexpectedNodesSyntax(combining: misplacedSpecifiers, unexpectedBeforeFirst, arena: self.arena),
            firstName: first,
            unexpectedBeforeSecond,
            secondName: second,
            unexpectedBeforeColon,
            colon: colon,
            type: type,
            ellipsis: ellipsis,
            trailingComma: trailingComma,
            arena: self.arena
          )
        )
      }
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawTupleTypeSyntax(
      unexpectedBeforeLParen,
      leftParen: lparen,
      elements: RawTupleTypeElementListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse an array or dictionary type..
  mutating func parseCollectionType() -> RawTypeSyntax {
    if let remaingingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawTypeSyntax(
        RawArrayTypeSyntax(
          remaingingTokens,
          leftSquare: missingToken(.leftSquare),
          element: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
          rightSquare: missingToken(.rightSquare),
          arena: self.arena
        )
      )
    }

    let (unexpectedBeforeLSquare, leftsquare) = self.expect(.leftSquare)
    let firstType = self.parseType()
    if let colon = self.consume(if: .colon) {
      let secondType = self.parseType()
      let (unexpectedBeforeRSquareBracket, rightSquare) = self.expect(.rightSquare)
      return RawTypeSyntax(
        RawDictionaryTypeSyntax(
          unexpectedBeforeLSquare,
          leftSquare: leftsquare,
          key: firstType,
          colon: colon,
          value: secondType,
          unexpectedBeforeRSquareBracket,
          rightSquare: rightSquare,
          arena: self.arena
        )
      )
    } else {
      let (unexpectedBeforeRSquareBracket, rSquareBracket) = self.expect(.rightSquare)
      return RawTypeSyntax(
        RawArrayTypeSyntax(
          unexpectedBeforeLSquare,
          leftSquare: leftsquare,
          element: firstType,
          unexpectedBeforeRSquareBracket,
          rightSquare: rSquareBracket,
          arena: self.arena
        )
      )
    }
  }
}

extension Parser.Lookahead {
  mutating func canParseType() -> Bool {
    guard self.canParseTypeScalar() else {
      return false
    }

    if self.atContextualPunctuator("...") {
      self.consumeAnyToken()
    }

    return true
  }

  mutating func skipTypeAttributeList() {
    var specifierProgress = LoopProgressCondition()
    // TODO: Can we model isolated/_const so that they're specified in both canParse* and parse*?
    while canHaveParameterSpecifier,
      self.at(anyIn: TypeSpecifier.self) != nil || self.at(.keyword(.isolated)) || self.at(.keyword(._const)),
      self.hasProgressed(&specifierProgress)
    {
      self.consumeAnyToken()
    }

    var attributeProgress = LoopProgressCondition()
    while self.at(.atSign), self.hasProgressed(&attributeProgress) {
      self.consumeAnyToken()
      self.skipTypeAttribute()
    }
  }

  mutating func canParseTypeScalar() -> Bool {
    // 'repeat' starts a pack expansion type
    self.consume(if: .keyword(.repeat))

    self.skipTypeAttributeList()

    guard self.canParseSimpleOrCompositionType() else {
      return false
    }

    if self.atFunctionTypeArrow() {
      // Handle type-function if we have an '->' with optional
      // 'async' and/or 'throws'.
      var loopProgress = LoopProgressCondition()
      while let (_, handle) = self.at(anyIn: EffectSpecifier.self), self.hasProgressed(&loopProgress) {
        self.eat(handle)
      }

      guard self.consume(if: .arrow) != nil else {
        return false
      }

      return self.canParseType()
    }

    return true
  }

  mutating func canParseSimpleOrCompositionType() -> Bool {
    if self.at(.keyword(.some)) || self.at(.keyword(.any)) || self.at(.keyword(.each)) {
      self.consumeAnyToken()
    }

    guard self.canParseSimpleType() else {
      return false
    }

    var loopProgress = LoopProgressCondition()
    while self.atContextualPunctuator("&") && self.hasProgressed(&loopProgress) {
      self.consumeAnyToken()
      guard self.canParseSimpleType() else {
        return false
      }
    }

    return true
  }

  mutating func canParseSimpleType() -> Bool {
    switch self.currentToken {
    case TokenSpec(.Any):
      self.consumeAnyToken()
    case TokenSpec(.Self), TokenSpec(.identifier):
      guard self.canParseTypeIdentifier() else {
        return false
      }
    case TokenSpec(.leftParen):
      self.consumeAnyToken()
      guard self.canParseTupleBodyType() else {
        return false
      }
    case TokenSpec(.leftSquare):
      self.consumeAnyToken()
      guard self.canParseType() else {
        return false
      }
      if self.consume(if: .colon) != nil {
        guard self.canParseType() else {
          return false
        }
      }
      guard self.consume(if: .rightSquare) != nil else {
        return false
      }
    case TokenSpec(.wildcard):
      self.consumeAnyToken()
    case TokenSpec(.repeat):
      return true
    default:
      return false
    }

    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
      if self.at(.period) {
        self.consumeAnyToken()
        if self.at(.keyword(.Type)) || self.at(.keyword(.Protocol)) {
          self.consumeAnyToken()
          continue
        }

        if self.canParseTypeIdentifier(allowKeyword: true) {
          continue
        }

        return false
      }

      if self.at(TokenSpec(.postfixQuestionMark, allowAtStartOfLine: false)) || self.at(TokenSpec(.exclamationMark, allowAtStartOfLine: false)) {
        self.consumeAnyToken()
        continue
      }

      break
    }

    return true
  }

  mutating func canParseTupleBodyType() -> Bool {
    guard
      !self.at(.rightParen, .rightBrace) && !self.atContextualPunctuator("...")
        // In types, we do not allow for an inout binding to be declared in a
        // tuple type.
        && (self.at(.keyword(.inout)) || !self.atStartOfDeclaration())
    else {
      return self.consume(if: .rightParen) != nil
    }

    var loopProgress = LoopProgressCondition()
    repeat {
      // The contextual inout marker is part of argument lists.
      _ = self.consume(if: .keyword(.inout))

      // If the tuple element starts with "ident :", then it is followed
      // by a type annotation.
      if self.startsParameterName(isClosure: false, allowMisplacedSpecifierRecovery: false) {
        self.consumeAnyToken()
        if self.atArgumentLabel() {
          self.consumeAnyToken()
          guard self.at(.colon) else {
            return false
          }
        }
        self.eat(.colon)

        // Parse a type.
        guard self.canParseType() else {
          return false
        }

        // Parse default values. This aren't actually allowed, but we recover
        // better if we skip over them.
        if self.consume(if: .equal) != nil {
          var skipProgress = LoopProgressCondition()
          while !self.at(.endOfFile)
            && !self.at(.rightParen, .rightBrace, .comma)
            && !self.atContextualPunctuator("...")
            && !self.atStartOfDeclaration()
            && self.hasProgressed(&skipProgress)
          {
            self.skipSingle()
          }
        }

        continue
      }

      // Otherwise, this has to be a type.
      guard self.canParseType() else {
        return false
      }

      self.consumeIfContextualPunctuator("...")
    } while self.consume(if: .comma) != nil && self.hasProgressed(&loopProgress)
    return self.consume(if: .rightParen) != nil
  }

  mutating func atFunctionTypeArrow() -> Bool {
    if self.at(.arrow) {
      return true
    }

    if let effect = self.at(anyIn: EffectSpecifier.self) {
      if self.peek().rawTokenKind == .arrow {
        return true
      }

      if effect.spec.isThrowsSpecifier && self.peek().rawTokenKind == .leftParen {
        var backtrack = self.lookahead()
        backtrack.consumeAnyToken()
        backtrack.skipSingle()
        return backtrack.atFunctionTypeArrow()
      }

      if peek(isAtAnyIn: EffectSpecifier.self) != nil {
        var backtrack = self.lookahead()
        backtrack.consumeAnyToken()
        return backtrack.atFunctionTypeArrow()
      }

      return false
    }

    return false
  }

  mutating func canParseTypeIdentifier(allowKeyword: Bool = false) -> Bool {
    if self.at(.keyword(.Any)) {
      self.consumeAnyToken()
      return true
    }

    // Parse an identifier.
    guard self.at(.identifier) || self.at(.keyword(.Self)) || (allowKeyword && self.currentToken.isLexerClassifiedKeyword) else {
      return false
    }
    self.consumeAnyToken()

    // Parse an optional generic argument list.
    if self.at(prefix: "<") && !self.consumeGenericArguments() {
      return false
    }

    return true
  }

  mutating func canParseAsGenericArgumentList() -> Bool {
    guard self.atContextualPunctuator("<") else {
      return false
    }

    var lookahead = self.lookahead()
    guard lookahead.consumeGenericArguments() else {
      return false
    }
    return lookahead.currentToken.isGenericTypeDisambiguatingToken
  }

  mutating func consumeGenericArguments() -> Bool {
    // Parse the opening '<'.
    guard self.consume(ifPrefix: "<", as: .leftAngle) != nil else {
      return false
    }

    if !self.at(prefix: ">") {
      var loopProgress = LoopProgressCondition()
      repeat {
        guard self.canParseType() else {
          return false
        }
        // Parse the comma, if the list continues.
      } while self.consume(if: .comma) != nil && self.hasProgressed(&loopProgress)
    }

    guard self.consume(ifPrefix: ">", as: .rightAngle) != nil else {
      return false
    }

    return true
  }
}

extension Parser {
  mutating func parseTypeAttributeList(misplacedSpecifiers: [RawTokenSyntax] = []) -> (
    specifier: RawTokenSyntax?, unexpectedBeforeAttributes: RawUnexpectedNodesSyntax?, attributes: RawAttributeListSyntax
  ) {
    var specifier: RawTokenSyntax? = nil
    if canHaveParameterSpecifier {
      specifier = self.consume(ifAnyIn: TypeSpecifier.self)
    }
    // We can only stick one specifier on this type. Let's pick the first one
    if specifier == nil, let misplacedSpecifier = misplacedSpecifiers.first {
      specifier = missingToken(misplacedSpecifier.tokenKind, text: misplacedSpecifier.tokenText)
    }
    var extraneousSpecifiers: [RawTokenSyntax] = []

    while canHaveParameterSpecifier,
      let extraSpecifier = self.consume(ifAnyIn: AttributedTypeSyntax.SpecifierOptions.self)
    {
      if specifier == nil {
        specifier = extraSpecifier
      } else {
        extraneousSpecifiers.append(extraSpecifier)
      }
    }
    let unexpectedBeforeAttributeList = RawUnexpectedNodesSyntax(extraneousSpecifiers, arena: self.arena)

    if self.at(.atSign) {
      return (specifier, unexpectedBeforeAttributeList, self.parseTypeAttributeListPresent())
    }

    return (specifier, unexpectedBeforeAttributeList, self.emptyCollection(RawAttributeListSyntax.self))
  }

  mutating func parseTypeAttributeListPresent() -> RawAttributeListSyntax {
    var elements = [RawAttributeListSyntax.Element]()
    var attributeProgress = LoopProgressCondition()
    while self.at(.atSign) && self.hasProgressed(&attributeProgress) {
      elements.append(self.parseTypeAttribute())
    }
    return RawAttributeListSyntax(elements: elements, arena: self.arena)
  }

  mutating func parseTypeAttribute() -> RawAttributeListSyntax.Element {
    switch peek(isAtAnyIn: TypeAttribute.self) {
    case ._local, ._noMetadata, .async, .escaping, .noDerivative, .noescape,
      .preconcurrency, .retroactive, .Sendable, .unchecked, .autoclosure:
      // Known type attribute that doesn't take any arguments
      return parseAttributeWithoutArguments()
    case .differentiable:
      return .attribute(self.parseDifferentiableAttribute())

    case .convention:
      return parseAttribute(argumentMode: .required) { parser in
        return parser.parseConventionArguments()
      }
    case ._opaqueReturnTypeOf:
      return parseAttribute(argumentMode: .required) { parser in
        return .opaqueReturnTypeOfAttributeArguments(parser.parseOpaqueReturnTypeOfAttributeArguments())
      }
    case nil:  // Custom attribute
      return parseAttribute(argumentMode: .customAttribute) { parser in
        let arguments = parser.parseArgumentListElements(pattern: .none)
        return .argumentList(RawLabeledExprListSyntax(elements: arguments, arena: parser.arena))
      }

    }
  }
}

extension Parser {
  mutating func parseResultType() -> RawTypeSyntax {
    if self.currentToken.isEditorPlaceholder {
      return self.parseTypeIdentifier()
    } else if self.at(prefix: "<") {
      let generics = self.parseGenericParameters()
      let baseType = self.parseType()
      return RawTypeSyntax(
        RawNamedOpaqueReturnTypeSyntax(
          genericParameterClause: generics,
          type: baseType,
          arena: self.arena
        )
      )
    } else {
      var result = self.parseType()

      guard !result.hasError else {
        return result
      }

      // If the right square bracket is at a new line, we should just return the result
      if let rightSquare = self.consume(if: TokenSpec(.rightSquare, allowAtStartOfLine: false)) {
        result = RawTypeSyntax(
          RawArrayTypeSyntax(
            leftSquare: missingToken(.leftSquare),
            element: result,
            rightSquare: rightSquare,
            arena: self.arena
          )
        )
      } else if self.at(.colon) {
        var lookahead = self.lookahead()
        // We only want to continue with a dictionary if we can parse a colon and a simple type.
        // Otherwise we can get a wrong diagnostic if we get a Python-style function declaration.
        guard lookahead.consume(if: .colon) != nil && lookahead.canParseSimpleType(),
          let colon = self.consume(if: TokenSpec(.colon, allowAtStartOfLine: false))
        else {
          return result
        }

        let secondType = self.parseSimpleType()
        let rightSquare = self.consume(if: .rightSquare) ?? self.missingToken(.rightSquare)

        result = RawTypeSyntax(
          RawDictionaryTypeSyntax(
            leftSquare: self.missingToken(.leftSquare),
            key: result,
            colon: colon,
            value: secondType,
            rightSquare: rightSquare,
            arena: self.arena
          )
        )
      }

      var loopProgress = LoopProgressCondition()
      while self.hasProgressed(&loopProgress) {
        if self.at(TokenSpec(.postfixQuestionMark, allowAtStartOfLine: false)) {
          result = RawTypeSyntax(self.parseOptionalType(result))
        } else if self.at(TokenSpec(.exclamationMark, allowAtStartOfLine: false)) {
          result = RawTypeSyntax(self.parseImplicitlyUnwrappedOptionalType(result))
        } else {
          break
        }
      }

      return result
    }
  }
}

extension Lexer.Lexeme {
  var isGenericTypeDisambiguatingToken: Bool {
    switch self.rawTokenKind {
    case .rightParen,
      .rightSquare,
      .leftBrace,
      .rightBrace,
      .period,
      .comma,
      .semicolon,
      .endOfFile,
      .exclamationMark,
      .postfixQuestionMark,
      .colon:
      return true
    case .binaryOperator:
      return self.tokenText == "&"
    case .postfixOperator:
      return false
    case .leftParen, .leftSquare:
      // These only apply to the generic type if they don't start a new line.
      return !self.isAtStartOfLine
    default:
      return false
    }
  }
}
