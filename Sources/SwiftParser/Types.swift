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
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) internal import SwiftSyntax
#else
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
#endif

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
    let specifiersAndAttributes = self.parseTypeAttributeList(misplacedSpecifiers: misplacedSpecifiers)
    var base = self.parseSimpleOrCompositionType()
    if self.withLookahead({ $0.canParseFunctionTypeArrow() }) {
      var effectSpecifiers = self.parseTypeEffectSpecifiers()
      let returnClause = self.parseFunctionReturnClause(
        effectSpecifiers: &effectSpecifiers,
        allowNamedOpaqueResultType: false
      )

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

    if let specifiersAndAttributes {
      return RawTypeSyntax(
        RawAttributedTypeSyntax(
          specifiers: specifiersAndAttributes.specifiers,
          attributes: specifiersAndAttributes.attributes,
          lateSpecifiers: specifiersAndAttributes.lateSpecifiers,
          baseType: base,
          arena: self.arena
        )
      )
    } else {
      return base
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

  /// Parse the subset of types that we allow in attribute names.
  mutating func parseAttributeName() -> RawTypeSyntax {
    return parseSimpleType(forAttributeName: true)
  }

  mutating func parseSimpleType(
    allowMemberTypes: Bool = true,
    forAttributeName: Bool = false
  ) -> RawTypeSyntax {
    let tilde = self.consumeIfContextualPunctuator("~", remapping: .prefixOperator)

    let baseType = self.parseUnsuppressedSimpleType(
      allowMemberTypes: allowMemberTypes,
      forAttributeName: forAttributeName
    )

    guard let tilde else {
      return baseType
    }

    return RawTypeSyntax(
      RawSuppressedTypeSyntax(withoutTilde: tilde, type: baseType, arena: self.arena)
    )
  }

  mutating func parseUnsuppressedSimpleType(
    allowMemberTypes: Bool = true,
    forAttributeName: Bool = false
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

    var base: RawTypeSyntax
    switch self.isAtModuleSelector() ? .identifier : self.at(anyIn: TypeBaseStart.self)?.spec {
    case .Self, .Any, .identifier:
      base = RawTypeSyntax(self.parseTypeIdentifier())
    case .leftParen:
      base = RawTypeSyntax(self.parseTupleTypeBody())
    case .leftSquare:
      base = self.parseCollectionType()
    case .wildcard:
      base = RawTypeSyntax(self.parsePlaceholderType())
    case nil:
      return RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena))
    }

    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
      if self.at(.period) && (allowMemberTypes || self.peek(isAt: .keyword(.Type), .keyword(.Protocol))) {
        let (unexpectedPeriod, period, skipMemberName) = self.consumeMemberPeriod(previousNode: base)
        if skipMemberName {
          let missingIdentifier = missingToken(.identifier)
          base = RawTypeSyntax(
            RawMemberTypeSyntax(
              baseType: base,
              unexpectedPeriod,
              period: period,
              moduleSelector: nil,
              name: missingIdentifier,
              genericArgumentClause: nil,
              arena: self.arena
            )
          )
          break
        }

        if !self.isAtModuleSelector() && (self.at(.keyword(.Type)) || self.at(.keyword(.Protocol))) {
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
          let (memberModuleSelector, skipQualifiedName) = self.parseModuleSelectorIfPresent()
          let name = self.parseMemberTypeName(moduleSelector: memberModuleSelector, skipName: skipQualifiedName)
          let generics: RawGenericArgumentClauseSyntax?
          if self.at(prefix: "<") {
            generics = self.parseGenericArguments()
          } else {
            generics = nil
          }
          base = RawTypeSyntax(
            RawMemberTypeSyntax(
              baseType: base,
              unexpectedPeriod,
              period: period,
              moduleSelector: memberModuleSelector,
              name: name,
              genericArgumentClause: generics,
              arena: self.arena
            )
          )
          if skipQualifiedName {
            break
          }
        }
        continue
      }

      // Do not allow ? or ! suffixes when parsing attribute names.
      if forAttributeName {
        break
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

    return base
  }

  /// Parse a type name that has been qualiified by a module selector. This very aggressively interprets keywords as
  /// identifiers.
  ///
  /// - Parameter skipQualifiedName: If `true`, the next token should not be parsed because it includes forbidden whitespace.
  mutating func parseTypeNameAfterModuleSelector(skipQualifiedName: Bool) -> RawTokenSyntax {
    if !skipQualifiedName {
      if let identifier = self.consume(if: .identifier) {
        return identifier
      } else if self.currentToken.isLexerClassifiedKeyword {
        return self.consumeAnyToken(remapping: .identifier)
      }
    }
    return missingToken(.identifier)
  }

  /// Parse the name of a member type, which may be a keyword that's
  /// interpreted as an identifier (per SE-0071).
  ///
  /// - Parameter moduleSelector: The module selector that will be attached to this name, if any.
  /// - Parameter skipName: If `true`, the next token should not be parsed because it includes forbidden whitespace.
  mutating func parseMemberTypeName(moduleSelector: RawModuleSelectorSyntax?, skipName: Bool) -> RawTokenSyntax {
    if moduleSelector != nil {
      return self.parseTypeNameAfterModuleSelector(skipQualifiedName: skipName)
    }

    if !skipName {
      if let handle = self.at(anyIn: MemberTypeSyntax.NameOptions.self)?.handle {
        return self.eat(handle)
      } else if self.currentToken.isLexerClassifiedKeyword {
        return self.consumeAnyToken(remapping: .identifier)
      }
    }
    return missingToken(.identifier)
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
  mutating func parseImplicitlyUnwrappedOptionalType(
    _ base: RawTypeSyntax
  ) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
    let (unexpectedBeforeMark, mark) = self.expect(.exclamationMark)
    return RawImplicitlyUnwrappedOptionalTypeSyntax(
      wrappedType: base,
      unexpectedBeforeMark,
      exclamationMark: mark,
      arena: self.arena
    )
  }

  /// Parse a type identifier.
  mutating func parseTypeIdentifier() -> RawIdentifierTypeSyntax {
    let (moduleSelector, skipQualifiedName) = self.parseModuleSelectorIfPresent()

    if moduleSelector == nil && self.at(.keyword(.Any)) {
      return self.parseAnyType()
    }

    let unexpectedBeforeName: RawUnexpectedNodesSyntax?
    let name: RawTokenSyntax
    if moduleSelector == nil {
      (unexpectedBeforeName, name) = self.expect(anyIn: IdentifierTypeSyntax.NameOptions.self, default: .identifier)
    } else {
      unexpectedBeforeName = nil
      name = self.parseTypeNameAfterModuleSelector(skipQualifiedName: skipQualifiedName)
    }

    let generics: RawGenericArgumentClauseSyntax?
    if self.at(prefix: "<") {
      generics = self.parseGenericArguments()
    } else {
      generics = nil
    }

    return RawIdentifierTypeSyntax(
      moduleSelector: moduleSelector,
      unexpectedBeforeName,
      name: name,
      genericArgumentClause: generics,
      arena: self.arena
    )
  }

  /// Parse the existential `Any` type.
  mutating func parseAnyType() -> RawIdentifierTypeSyntax {
    let (unexpectedBeforeName, name) = self.expect(.keyword(.Any))
    return RawIdentifierTypeSyntax(
      moduleSelector: nil,
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
      moduleSelector: nil,
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
        let argument = self.parseGenericArgumentType()

        if arguments.isEmpty, argument.raw.is(RawMissingTypeSyntax.self) {
          break
        }

        keepGoing = self.consume(if: .comma)
        arguments.append(
          RawGenericArgumentSyntax(
            argument: argument,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )

        // If this was a trailing comma, we're done parsing the list
        if self.at(prefix: ">") {
          break
        }
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

  mutating func parseGenericArgumentType() -> RawGenericArgumentSyntax.Argument {
    if let valueType = self.parseValueType() {
      return .expr(valueType)
    } else {
      return .type(self.parseType())
    }
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
            let specifier = self.consume(ifAnyIn: SimpleTypeSpecifierSyntax.SpecifierOptions.self)
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
              type: RawIdentifierTypeSyntax(
                moduleSelector: nil,
                name: first,
                genericArgumentClause: nil,
                arena: self.arena
              ),
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
  /// Whether the parser is at the start of an InlineArray type sugar body.
  func isAtStartOfInlineArrayTypeBody() -> Bool {
    withLookahead { $0.canParseStartOfInlineArrayTypeBody() }
  }

  /// Parse an array or dictionary type..
  mutating func parseCollectionType() -> RawTypeSyntax {
    if let remaingingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawTypeSyntax(
        RawArrayTypeSyntax(
          remaingingTokens,
          leftSquare: missingToken(.leftSquare),
          element: RawMissingTypeSyntax(arena: self.arena),
          rightSquare: missingToken(.rightSquare),
          arena: self.arena
        )
      )
    }

    let (unexpectedBeforeLSquare, leftsquare) = self.expect(.leftSquare)

    // Check to see if we're at the start of an InlineArray type.
    if self.isAtStartOfInlineArrayTypeBody() {
      return self.parseInlineArrayType(
        unexpectedBeforeLSquare: unexpectedBeforeLSquare,
        leftSquare: leftsquare
      )
    }

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

  mutating func parseInlineArrayType(
    unexpectedBeforeLSquare: RawUnexpectedNodesSyntax?,
    leftSquare: RawTokenSyntax
  ) -> RawTypeSyntax {
    // We allow both values and types here and for the element type for
    // better recovery in cases where the user writes e.g '[Int of 3]'.
    let count = self.parseGenericArgumentType()

    let (unexpectedBeforeSeparator, separator) = self.expect(
      TokenSpec(.of, allowAtStartOfLine: false)
    )

    let element = self.parseGenericArgumentType()

    let (unexpectedBeforeRightSquare, rightSquare) = self.expect(.rightSquare)

    return RawTypeSyntax(
      RawInlineArrayTypeSyntax(
        unexpectedBeforeLSquare,
        leftSquare: leftSquare,
        count: .init(argument: count, trailingComma: nil, arena: self.arena),
        unexpectedBeforeSeparator,
        separator: separator,
        element: .init(argument: element, trailingComma: nil, arena: self.arena),
        unexpectedBeforeRightSquare,
        rightSquare: rightSquare,
        arena: self.arena
      )
    )
  }
}

extension Parser.Lookahead {
  mutating func canParseType() -> Bool {
    // 'repeat' starts a pack expansion type
    self.consume(if: .keyword(.repeat))

    guard self.canParseTypeScalar() else {
      return false
    }

    if self.atContextualPunctuator("...") {
      self.consumeAnyToken()
    }

    return true
  }

  mutating func canParseTypeAttributeList() -> Bool {
    var specifierProgress = LoopProgressCondition()
    while canHaveParameterSpecifier,
      self.at(anyIn: SimpleTypeSpecifierSyntax.SpecifierOptions.self) != nil
        || self.at(.keyword(.nonisolated), .keyword(.dependsOn)),
      self.hasProgressed(&specifierProgress)
    {
      switch self.currentToken {
      case .keyword(.nonisolated):
        let canParseNonisolated = self.withLookahead({
          // Consume 'nonisolated'
          $0.consumeAnyToken()

          // The argument is missing but it still could be a valid modifier,
          // i.e. `nonisolated` in an inheritance clause.
          guard $0.at(TokenSpec(.leftParen, allowAtStartOfLine: false)) else {
            return true
          }

          // Consume '('
          $0.consumeAnyToken()

          // nonisolated accepts a single modifier at the moment: 'nonsending'
          // we need to check for that explicitly to avoid misinterpreting this
          // keyword to be a modifier when it isn't i.e. `[nonisolated(42)]`
          guard $0.consume(if: TokenSpec(.nonsending, allowAtStartOfLine: false)) != nil else {
            return false
          }

          return $0.consume(if: TokenSpec(.rightParen, allowAtStartOfLine: false)) != nil
        })

        guard canParseNonisolated else {
          return false
        }

        self.consumeAnyToken()

        guard self.at(TokenSpec(.leftParen, allowAtStartOfLine: false)) else {
          continue
        }

        self.skipSingle()

      case .keyword(.dependsOn):
        let canParseDependsOn = self.withLookahead({
          let nameHadSpace = $0.currentToken.trailingTriviaByteLength > 0
          // Consume 'dependsOn'
          $0.consumeAnyToken()

          if $0.currentToken.isAtStartOfLine {
            return false
          }

          // `dependsOn` requires an argument list.
          guard $0.atAttributeOrSpecifierArgument(lastTokenHadSpace: nameHadSpace) else {
            return false
          }

          return true
        })

        guard canParseDependsOn else {
          return false
        }

        self.consumeAnyToken()
        self.skipSingle()

      default:
        self.consumeAnyToken()
      }
    }

    _ = self.consumeAttributeList()

    return true
  }

  mutating func canParseTypeScalar() -> Bool {
    guard self.canParseTypeAttributeList() else {
      return false
    }

    guard self.canParseSimpleOrCompositionType() else {
      return false
    }

    if self.canParseFunctionTypeArrow() {
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
    case TokenSpec(.prefixOperator):
      // '~Copyable'
      if self.currentToken.tokenText == "~" {
        self.consumeAnyToken()
        fallthrough
      }

      return false
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
      guard self.canParseCollectionTypeBody() else {
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

      if self.at(TokenSpec(.postfixQuestionMark, allowAtStartOfLine: false))
        || self.at(TokenSpec(.exclamationMark, allowAtStartOfLine: false))
      {
        self.consumeAnyToken()
        continue
      }

      break
    }

    return true
  }

  /// Checks whether we can parse the start of an InlineArray type. This does
  /// not include the element type.
  mutating func canParseStartOfInlineArrayTypeBody() -> Bool {
    // We must have at least '[<type-or-integer> of', which cannot be any other
    // kind of expression or type. We specifically look for both types and
    // integers for better recovery in e.g cases where the user writes e.g
    // '[Int of 2]'. We only do type-scalar since variadics would be ambiguous
    // e.g 'Int...of'.
    guard self.canParseTypeScalar() || self.canParseIntegerLiteral() else {
      return false
    }

    // We don't currently allow multi-line since that would require
    // disambiguation with array literals.
    return self.consume(if: TokenSpec(.of, allowAtStartOfLine: false)) != nil
  }

  mutating func canParseInlineArrayTypeBody() -> Bool {
    guard self.canParseStartOfInlineArrayTypeBody() else {
      return false
    }
    // Note we look for both types and integers for better recovery in e.g cases
    // where the user writes e.g '[Int of 2]'.
    guard self.canParseGenericArgument() else {
      return false
    }
    return self.consume(if: .rightSquare) != nil
  }

  mutating func canParseCollectionTypeBody() -> Bool {
    // Check to see if we have an InlineArray sugar type.
    do {
      var lookahead = self.lookahead()
      if lookahead.canParseInlineArrayTypeBody() {
        self = lookahead
        return true
      }
    }
    guard self.canParseType() else {
      return false
    }
    if self.consume(if: .colon) != nil {
      guard self.canParseType() else {
        return false
      }
    }
    return self.consume(if: .rightSquare) != nil
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
        // If we have a secondary argument label, consume it.
        if self.atArgumentLabel() {
          self.consumeAnyToken()
        }
        guard self.consume(if: .colon) != nil else {
          return false
        }

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

  mutating func canParseFunctionTypeArrow() -> Bool {
    if self.consume(if: .arrow) != nil {
      return true
    }
    self.consumeEffectsSpecifiers()
    return self.consume(if: .arrow) != nil
  }

  mutating func canParseTypeIdentifier(allowKeyword: Bool = false) -> Bool {
    _ = self.consumeModuleSelectorTokensIfPresent()

    if self.at(.keyword(.Any)) {
      self.consumeAnyToken()
      return true
    }

    // Parse an identifier.
    guard
      self.at(.identifier) || self.at(.keyword(.Self)) || (allowKeyword && self.currentToken.isLexerClassifiedKeyword)
    else {
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
    guard self.at(prefix: "<"), !self.at(prefix: "<>") else {
      return false
    }

    var lookahead = self.lookahead()
    guard lookahead.consumeGenericArguments() else {
      return false
    }
    return lookahead.currentToken.isGenericTypeDisambiguatingToken
  }

  mutating func canParseIntegerLiteral() -> Bool {
    if self.currentToken.tokenText == "-", self.peek(isAt: .integerLiteral) {
      self.consumeAnyToken()
      self.consumeAnyToken()
      return true
    }
    if self.consume(if: .integerLiteral) != nil {
      return true
    }
    return false
  }

  mutating func canParseGenericArgument() -> Bool {
    // A generic argument can either be a type or an integer literal (who is
    // optionally negative).
    self.canParseType() || self.canParseIntegerLiteral()
  }

  mutating func consumeGenericArguments() -> Bool {
    // Parse the opening '<'.
    guard self.consume(ifPrefix: "<", as: .leftAngle) != nil else {
      return false
    }

    if !self.at(prefix: ">") {
      var loopProgress = LoopProgressCondition()
      repeat {
        guard self.canParseGenericArgument() else {
          return false
        }
        // Parse the comma, if the list continues.
        // This could be the trailing comma.
      } while self.consume(if: .comma) != nil && !self.at(prefix: ">") && self.hasProgressed(&loopProgress)
    }

    guard self.consume(ifPrefix: ">", as: .rightAngle) != nil else {
      return false
    }

    return true
  }
}

extension Parser {
  private mutating func parseLifetimeTypeSpecifier() -> RawTypeSpecifierListSyntax.Element {
    let (unexpectedBeforeDependsOnKeyword, dependsOnKeyword) = self.expect(.keyword(.dependsOn))

    guard let leftParen = self.consume(if: .leftParen) else {
      // If there is no left paren, add an entirely missing detail. Otherwise, we start to consume the following type
      // name as a token inside the detail, which leads to confusing recovery results.
      let lifetimeSpecifierArgumentList = RawLifetimeSpecifierArgumentListSyntax(
        elements: [
          RawLifetimeSpecifierArgumentSyntax(parameter: missingToken(.identifier), trailingComma: nil, arena: arena)
        ],
        arena: self.arena
      )
      let lifetimeSpecifier = RawLifetimeTypeSpecifierSyntax(
        unexpectedBeforeDependsOnKeyword,
        dependsOnKeyword: dependsOnKeyword,
        leftParen: missingToken(.leftParen),
        scopedKeyword: nil,
        arguments: lifetimeSpecifierArgumentList,
        rightParen: missingToken(.rightParen),
        arena: self.arena
      )
      return .lifetimeTypeSpecifier(lifetimeSpecifier)
    }

    let scoped = self.consume(if: .keyword(.scoped))
    var keepGoing: RawTokenSyntax?
    var arguments: [RawLifetimeSpecifierArgumentSyntax] = []
    var loopProgress = LoopProgressCondition()
    repeat {
      let (unexpectedBeforeParameter, parameter) = self.expect(
        anyIn: LifetimeSpecifierArgumentSyntax.ParameterOptions.self,
        default: .identifier
      )
      keepGoing = self.consume(if: .comma)
      arguments.append(
        RawLifetimeSpecifierArgumentSyntax(
          unexpectedBeforeParameter,
          parameter: parameter,
          trailingComma: keepGoing,
          arena: arena
        )
      )
    } while keepGoing != nil && self.hasProgressed(&loopProgress)
    let lifetimeSpecifierArgumentList = RawLifetimeSpecifierArgumentListSyntax(elements: arguments, arena: self.arena)
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    let lifetimeSpecifier = RawLifetimeTypeSpecifierSyntax(
      unexpectedBeforeDependsOnKeyword,
      dependsOnKeyword: dependsOnKeyword,
      leftParen: leftParen,
      scopedKeyword: scoped,
      arguments: lifetimeSpecifierArgumentList,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
    return .lifetimeTypeSpecifier(lifetimeSpecifier)
  }

  private mutating func parseNonisolatedTypeSpecifier() -> RawTypeSpecifierListSyntax.Element {
    let (unexpectedBeforeNonisolatedKeyword, nonisolatedKeyword) = self.expect(.keyword(.nonisolated))

    // If the next token is not '(' this could mean two things:
    //  - What follows is a type and we should allow it because
    //    using `nonsisolated` without an argument is allowed in
    //    an inheritance clause.
    //  - The '(nonsending)' was omitted.
    if !self.withLookahead({
      $0.atAttributeOrSpecifierArgument(lastTokenHadSpace: nonisolatedKeyword.trailingTriviaByteLength > 0)
    }) {
      // `nonisolated P<...>` is allowed in an inheritance clause.
      if withLookahead({ $0.canParseTypeIdentifier() }) {
        let nonisolatedSpecifier = RawNonisolatedTypeSpecifierSyntax(
          unexpectedBeforeNonisolatedKeyword,
          nonisolatedKeyword: nonisolatedKeyword,
          argument: nil,
          arena: self.arena
        )
        return .nonisolatedTypeSpecifier(nonisolatedSpecifier)
      }

      // Otherwise require '(nonsending)'
      let argument = RawNonisolatedSpecifierArgumentSyntax(
        leftParen: missingToken(.leftParen),
        nonsendingKeyword: missingToken(.keyword(.nonsending)),
        rightParen: missingToken(.rightParen),
        arena: self.arena
      )

      let nonisolatedSpecifier = RawNonisolatedTypeSpecifierSyntax(
        unexpectedBeforeNonisolatedKeyword,
        nonisolatedKeyword: nonisolatedKeyword,
        argument: argument,
        arena: self.arena
      )

      return .nonisolatedTypeSpecifier(nonisolatedSpecifier)
    } else {
      let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
      let (unexpectedBeforeModifier, modifier) = self.expect(.keyword(.nonsending))
      let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

      let argument = RawNonisolatedSpecifierArgumentSyntax(
        unexpectedBeforeLeftParen,
        leftParen: leftParen,
        unexpectedBeforeModifier,
        nonsendingKeyword: modifier,
        unexpectedBeforeRightParen,
        rightParen: rightParen,
        arena: self.arena
      )

      let nonisolatedSpecifier = RawNonisolatedTypeSpecifierSyntax(
        unexpectedBeforeNonisolatedKeyword,
        nonisolatedKeyword: nonisolatedKeyword,
        argument: argument,
        arena: self.arena
      )
      return .nonisolatedTypeSpecifier(nonisolatedSpecifier)
    }
  }

  private mutating func parseSimpleTypeSpecifier(
    specifierHandle: TokenConsumptionHandle
  ) -> RawTypeSpecifierListSyntax.Element {
    let specifier = self.eat(specifierHandle)
    return .simpleTypeSpecifier(RawSimpleTypeSpecifierSyntax(specifier: specifier, arena: arena))
  }

  mutating func parseTypeAttributeList(
    misplacedSpecifiers: [RawTokenSyntax] = []
  ) -> (
    specifiers: RawTypeSpecifierListSyntax,
    attributes: RawAttributeListSyntax,
    lateSpecifiers: RawTypeSpecifierListSyntax
  )? {
    var specifiers: [RawTypeSpecifierListSyntax.Element] = []
    SPECIFIER_PARSING: while canHaveParameterSpecifier {
      if let (_, specifierHandle) = self.at(anyIn: SimpleTypeSpecifierSyntax.SpecifierOptions.self) {
        specifiers.append(parseSimpleTypeSpecifier(specifierHandle: specifierHandle))
      } else if self.at(.keyword(.dependsOn)) {
        if self.experimentalFeatures.contains(.nonescapableTypes) {
          specifiers.append(parseLifetimeTypeSpecifier())
        } else {
          break SPECIFIER_PARSING
        }
      } else if self.at(.keyword(.nonisolated)) {
        // If '(' is located on the new line 'nonisolated' cannot be parsed
        // as a specifier.
        if self.peek(isAt: .leftParen) && self.peek().isAtStartOfLine {
          break SPECIFIER_PARSING
        }
        specifiers.append(parseNonisolatedTypeSpecifier())
      } else {
        break SPECIFIER_PARSING
      }
    }
    specifiers += misplacedSpecifiers.map {
      .simpleTypeSpecifier(
        RawSimpleTypeSpecifierSyntax(
          specifier: missingToken($0.tokenKind, text: $0.tokenText),
          arena: arena
        )
      )
    }

    let attributes: RawAttributeListSyntax?
    if self.at(.atSign) {
      attributes = self.parseTypeAttributeListPresent()
    } else {
      attributes = nil
    }

    // Only handle `nonisolated` as a late specifier.
    var lateSpecifiers: [RawTypeSpecifierListSyntax.Element] = []
    if self.at(.keyword(.nonisolated)) && !(self.peek(isAt: .leftParen) && self.peek().isAtStartOfLine)
      && canHaveParameterSpecifier
    {
      lateSpecifiers.append(parseNonisolatedTypeSpecifier())
    }

    guard !specifiers.isEmpty || attributes != nil || !lateSpecifiers.isEmpty else {
      // No specifiers or attributes on this type
      return nil
    }
    let specifierList: RawTypeSpecifierListSyntax
    if specifiers.isEmpty {
      specifierList = self.emptyCollection(RawTypeSpecifierListSyntax.self)
    } else {
      specifierList = RawTypeSpecifierListSyntax(elements: specifiers, arena: arena)
    }

    let lateSpecifierList: RawTypeSpecifierListSyntax
    if lateSpecifiers.isEmpty {
      lateSpecifierList = self.emptyCollection(RawTypeSpecifierListSyntax.self)
    } else {
      lateSpecifierList = RawTypeSpecifierListSyntax(elements: lateSpecifiers, arena: arena)
    }

    return (
      specifierList,
      attributes ?? self.emptyCollection(RawAttributeListSyntax.self),
      lateSpecifierList
    )
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
    // An attribute qualified by a module selector is *always* a custom attribute, even if it has the same name (or
    // module name) as a builtin attribute.
    let builtinAttr = self.unlessPeekModuleSelector { $0.peek(isAtAnyIn: TypeAttribute.self) }

    switch builtinAttr {
    case ._local, ._noMetadata, .async, .escaping, .noDerivative, .noescape,
      .preconcurrency, .retroactive, .Sendable, .unchecked, .autoclosure:
      // Known type attribute that doesn't take any arguments
      return parseAttributeWithoutArguments()
    case .differentiable:
      return .attribute(self.parseDifferentiableAttribute())

    case .isolated:
      return .attribute(
        parseAttribute(argumentMode: .required) { parser in
          return (nil, .argumentList(parser.parseIsolatedAttributeArguments()))
        }
      )
    case .convention, ._opaqueReturnTypeOf, nil:  // Custom attribute
      return .attribute(
        parseAttribute(argumentMode: .customAttribute) { parser in
          let arguments = parser.parseArgumentListElements(
            pattern: .none,
            allowTrailingComma: true
          )
          return (nil, .argumentList(RawLabeledExprListSyntax(elements: arguments, arena: parser.arena)))
        }
      )

    }
  }
}

extension Parser {
  mutating func parseResultType() -> RawTypeSyntax {
    if self.at(prefix: "<") && !self.currentToken.isEditorPlaceholder {
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

      // The rest of this tries to recover from a missing left square bracket like ` -> [Int]]? {`. We can do this for
      // result types because we know there isn't an enclosing expression context.

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

extension Parser {
  mutating func parseValueType() -> RawExprSyntax? {
    // Eat any '-' preceding integer literals.
    var minusSign: RawTokenSyntax? = nil
    if self.atContextualPunctuator("-"),
      self.peek(isAt: .integerLiteral)
    {
      minusSign = self.consumeIfContextualPunctuator("-", remapping: .prefixOperator)
    }

    // Attempt to parse values first. Right now the only value that can be parsed
    // as a type are integers.
    if let integerLiteral = self.consume(if: .integerLiteral) {
      let integerExpr = RawIntegerLiteralExprSyntax(
        literal: integerLiteral,
        arena: self.arena
      )

      guard let minusSign else {
        return RawExprSyntax(integerExpr)
      }

      return RawExprSyntax(
        RawPrefixOperatorExprSyntax(
          operator: minusSign,
          expression: integerExpr,
          arena: self.arena
        )
      )
    }

    return nil
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
