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
  ///
  /// Grammar
  /// =======
  ///
  ///     type → simple-type
  ///     type → function-type
  ///     type → protocol-composition-type
  ///     type → constrained-sugar-type
  ///     type → opaque-type
  mutating func parseType(misplacedSpecifiers: [RawTokenSyntax] = []) -> RawTypeSyntax {
    // Parse pack expansion 'repeat T'.
    if let repeatKeyword = self.consume(if: .keyword(.repeat)) {
      let type = self.parseTypeScalar(misplacedSpecifiers: misplacedSpecifiers)
      return RawTypeSyntax(
        RawPackExpansionTypeSyntax(
          repeatKeyword: repeatKeyword,
          patternType: type,
          arena: self.arena
        )
      )
    }

    // Parse without operator preceding a type '~ T'.
    if let withoutTilde = self.consumeIfContextualPunctuator("~", remapping: .prefixOperator) {
      let type = self.parseTypeScalar(misplacedSpecifiers: misplacedSpecifiers)
      return RawTypeSyntax(
        RawSuppressedTypeSyntax(
          withoutTilde: withoutTilde,
          patternType: type,
          arena: self.arena
        )
      )
    }

    return self.parseTypeScalar(misplacedSpecifiers: misplacedSpecifiers)
  }

  mutating func parseTypeScalar(misplacedSpecifiers: [RawTokenSyntax] = []) -> RawTypeSyntax {
    let (specifier, unexpectedBeforeAttrList, attrList) = self.parseTypeAttributeList(misplacedSpecifiers: misplacedSpecifiers)
    var base = RawTypeSyntax(self.parseSimpleOrCompositionType())
    if self.withLookahead({ $0.isAtFunctionTypeArrow() }) {
      var effectSpecifiers = self.parseTypeEffectSpecifiers()
      let returnClause = self.parseFunctionReturnClause(effectSpecifiers: &effectSpecifiers, allowNamedOpaqueResultType: false)

      let unexpectedBeforeLeftParen: RawUnexpectedNodesSyntax?
      let leftParen: RawTokenSyntax
      let unexpectedBetweenLeftParenAndElements: RawUnexpectedNodesSyntax?
      let arguments: RawTupleTypeElementListSyntax
      let unexpectedBetweenElementsAndRightParen: RawUnexpectedNodesSyntax?
      let rightParen: RawTokenSyntax
      if let input = base.as(RawTupleTypeSyntax.self) {
        unexpectedBeforeLeftParen = input.unexpectedBeforeLeftParen
        leftParen = input.leftParen
        unexpectedBetweenLeftParenAndElements = input.unexpectedBetweenLeftParenAndElements
        arguments = input.elements
        unexpectedBetweenElementsAndRightParen = input.unexpectedBetweenElementsAndRightParen
        rightParen = input.rightParen
      } else {
        unexpectedBeforeLeftParen = nil
        leftParen = RawTokenSyntax(missing: .leftParen, arena: self.arena)
        unexpectedBetweenLeftParenAndElements = nil
        arguments = RawTupleTypeElementListSyntax(
          elements: [
            RawTupleTypeElementSyntax(
              inOut: nil,
              name: nil,
              secondName: nil,
              colon: nil,
              type: base,
              ellipsis: nil,
              initializer: nil,
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
          arguments: arguments,
          unexpectedBetweenElementsAndRightParen,
          rightParen: rightParen,
          effectSpecifiers: effectSpecifiers,
          output: returnClause,
          arena: self.arena
        )
      )
    }

    if unexpectedBeforeAttrList != nil || specifier != nil || attrList != nil {
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
  ///
  /// Grammar
  /// =======
  ///
  ///     protocol-composition-type → simple-type '&' protocol-composition-continuation
  ///     protocol-composition-continuation → simple-type | protocol-composition-type
  ///
  ///     constrained-sugar-type → constrained-sugar-type-specifier constrained-sugar-type-constraint
  ///     constrained-sugar-type-specifier → 'any' | 'some'
  ///     constrained-sugar-type-constraint → protocol-composition-type
  ///     constrained-sugar-type-constraint → type-simple
  mutating func parseSimpleOrCompositionType() -> RawTypeSyntax {
    // 'each' is a contextual keyword for a pack reference.
    if let each = consume(if: .keyword(.each)) {
      let packType = parseSimpleType()
      return RawTypeSyntax(
        RawPackReferenceTypeSyntax(
          eachKeyword: each,
          packType: packType,
          arena: self.arena
        )
      )
    }

    let someOrAny = self.consume(if: .keyword(.some), .keyword(.any))

    var base = self.parseSimpleType()
    guard self.atContextualPunctuator("&") else {
      if let someOrAny = someOrAny {
        return RawTypeSyntax(
          RawConstrainedSugarTypeSyntax(
            someOrAnySpecifier: someOrAny,
            baseType: base,
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
      } while keepGoing != nil && loopProgress.evaluate(currentToken)

      base = RawTypeSyntax(
        RawCompositionTypeSyntax(
          elements: RawCompositionTypeElementListSyntax(elements: elements, arena: self.arena),
          arena: self.arena
        )
      )
    }

    if let someOrAny = someOrAny {
      return RawTypeSyntax(
        RawConstrainedSugarTypeSyntax(
          someOrAnySpecifier: someOrAny,
          baseType: base,
          arena: self.arena
        )
      )
    } else {
      return base
    }
  }

  /// Parse a "simple" type
  ///
  /// Grammar
  /// =======
  ///
  ///     simple-type → type-identifier
  ///     simple-type → any-type
  ///     simple-type → paren-type
  ///     simple-type → tuple-type
  ///     simple-type → array-type
  ///     simple-type → dictionary-type
  ///     simple-type → optional-type
  ///     simple-type → implicitly-unwrapped-optional-type
  ///     simple-type → metatype-type
  ///     simple-type → member-type-identifier
  ///
  ///     metatype-type → simple-type '.' 'Type' | simple-type '.' 'Protocol'
  ///
  ///     member-type-identifier → member-type-identifier-base '.' type-identifier
  ///     member-type-identifier-base → simple-type | member-type-identifier
  mutating func parseSimpleType(
    stopAtFirstPeriod: Bool = false
  ) -> RawTypeSyntax {
    var base: RawTypeSyntax
    switch self.currentToken {
    case TokenSpec(.Self),
      TokenSpec(.Any),
      TokenSpec(.identifier):
      base = self.parseTypeIdentifier()
    case TokenSpec(.leftParen):
      base = RawTypeSyntax(self.parseTupleTypeBody())
    case TokenSpec(.leftSquareBracket):
      base = RawTypeSyntax(self.parseCollectionType())
    case TokenSpec(.wildcard):
      base = RawTypeSyntax(self.parsePlaceholderType())
    default:
      return RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena))
    }

    var loopCondition = LoopProgressCondition()
    while loopCondition.evaluate(currentToken) {
      if !stopAtFirstPeriod, self.at(.period) {
        let (unexpectedPeriod, period, skipMemberName) = self.consumeMemberPeriod(previousNode: base)
        if skipMemberName {
          let missingIdentifier = missingToken(.identifier)
          base = RawTypeSyntax(
            RawMemberTypeIdentifierSyntax(
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
          let typeOrProtocol = self.consume(if: .keyword(.Type)) ?? self.consume(if: .keyword(.Protocol))!
          base = RawTypeSyntax(
            RawMetatypeTypeSyntax(
              baseType: base,
              unexpectedPeriod,
              period: period,
              typeOrProtocol: typeOrProtocol,
              arena: self.arena
            )
          )
        } else {
          let (name, generics) = self.parseTypeNameWithGenerics(allowKeywordAsName: true)
          base = RawTypeSyntax(
            RawMemberTypeIdentifierSyntax(
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

      if !self.currentToken.isAtStartOfLine {
        if self.at(.postfixQuestionMark) {
          base = RawTypeSyntax(self.parseOptionalType(base))
          continue
        }
        if self.at(.exclamationMark) {
          base = RawTypeSyntax(self.parseImplicitlyUnwrappedOptionalType(base))
          continue
        }
      }

      break
    }

    return base
  }

  /// Parse an optional type.
  ///
  /// Grammar
  /// =======
  ///
  ///     optional-type → type '?'
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
  ///
  /// Grammar
  /// =======
  ///
  ///     implicitly-unwrapped-optional-type → type '!'
  mutating func parseImplicitlyUnwrappedOptionalType(_ base: RawTypeSyntax) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
    let (unexpectedBeforeMark, mark) = self.expect(.exclamationMark)
    return RawImplicitlyUnwrappedOptionalTypeSyntax(
      wrappedType: base,
      unexpectedBeforeMark,
      exclamationMark: mark,
      arena: self.arena
    )
  }

  mutating func parseTypeNameWithGenerics(allowKeywordAsName: Bool) -> (RawTokenSyntax, RawGenericArgumentClauseSyntax?) {
    let name: RawTokenSyntax
    if let identOrSelf = self.consume(if: .identifier, .keyword(.self), .keyword(.Self)) {
      name = identOrSelf
    } else if allowKeywordAsName && self.currentToken.isLexerClassifiedKeyword {
      name = self.consumeAnyToken(remapping: .identifier)
    } else {
      name = missingToken(.identifier)
    }
    if self.atContextualPunctuator("<") {
      return (name, self.parseGenericArguments())
    }
    return (name, nil)
  }

  /// Parse a type identifier.
  ///
  /// Grammar
  /// =======
  ///
  ///     type-identifier → identifier generic-argument-clause?
  mutating func parseTypeIdentifier() -> RawTypeSyntax {
    if self.at(.keyword(.Any)) {
      return RawTypeSyntax(self.parseAnyType())
    }

    let (name, generics) = parseTypeNameWithGenerics(allowKeywordAsName: false)
    return RawTypeSyntax(
      RawSimpleTypeIdentifierSyntax(
        name: name,
        genericArgumentClause: generics,
        arena: self.arena
      )
    )
  }

  /// Parse the existential `Any` type.
  ///
  /// Grammar
  /// =======
  ///
  ///     any-type → 'Any'
  mutating func parseAnyType() -> RawSimpleTypeIdentifierSyntax {
    let (unexpectedBeforeName, name) = self.expect(.keyword(.Any))
    return RawSimpleTypeIdentifierSyntax(
      unexpectedBeforeName,
      name: name,
      genericArgumentClause: nil,
      arena: self.arena
    )
  }

  /// Parse a type placeholder.
  ///
  /// Grammar
  /// =======
  ///
  ///     placeholder-type → wildcard
  mutating func parsePlaceholderType() -> RawSimpleTypeIdentifierSyntax {
    let (unexpectedBeforeName, name) = self.expect(.wildcard)
    // FIXME: Need a better syntax node than this
    return RawSimpleTypeIdentifierSyntax(
      unexpectedBeforeName,
      name: name,
      genericArgumentClause: nil,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse the generic arguments applied to a type.
  ///
  /// Grammar
  /// =======
  ///
  ///     generic-argument-clause → '<' generic-argument-list '>'
  ///     generic-argument-list → generic-argument | generic-argument ',' generic-argument-list
  ///     generic-argument → type
  mutating func parseGenericArguments() -> RawGenericArgumentClauseSyntax {
    precondition(self.currentToken.starts(with: "<"))
    let langle = self.consumePrefix("<", as: .leftAngle)
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
            argumentType: type,
            trailingComma: keepGoing,
            arena: self.arena
          )
        )
      } while keepGoing != nil && loopProgress.evaluate(currentToken)
    }

    let rangle: RawTokenSyntax
    if self.currentToken.starts(with: ">") {
      rangle = self.consumePrefix(">", as: .rightAngle)
    } else {
      rangle = RawTokenSyntax(missing: .rightAngle, arena: self.arena)
    }

    let args: RawGenericArgumentListSyntax
    if arguments.isEmpty && rangle.isMissing {
      args = RawGenericArgumentListSyntax(elements: [], arena: self.arena)
    } else {
      args = RawGenericArgumentListSyntax(elements: arguments, arena: self.arena)
    }
    return RawGenericArgumentClauseSyntax(
      leftAngleBracket: langle,
      arguments: args,
      rightAngleBracket: rangle,
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse a tuple type.
  ///
  /// Grammar
  /// =======
  ///
  ///     paren-type → '(' type ')'
  ///
  ///     tuple-type → '(' ')' | '(' tuple-type-element ',' tuple-type-element-list ')'
  ///     tuple-type-element-list → tuple-type-element | tuple-type-element ',' tuple-type-element-list
  ///     tuple-type-element → element-name type-annotation | type
  ///     element-name → identifier
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
      while !self.at(.eof, .rightParen) && keepGoing && loopProgress.evaluate(currentToken) {
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
          } else if self.currentToken.canBeArgumentLabel(allowDollarIdentifier: true) && self.peek().rawTokenKind == .colon {
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
        if let first = first,
          second == nil,
          colon?.isMissing == true,
          first.tokenText.isStartingWithUppercase
        {
          elements.append(
            RawTupleTypeElementSyntax(
              inOut: nil,
              name: nil,
              secondName: nil,
              RawUnexpectedNodesSyntax(combining: misplacedSpecifiers, unexpectedBeforeColon, arena: self.arena),
              colon: nil,
              type: RawTypeSyntax(RawSimpleTypeIdentifierSyntax(name: first, genericArgumentClause: nil, arena: self.arena)),
              ellipsis: nil,
              initializer: nil,
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
            inOut: nil,
            RawUnexpectedNodesSyntax(combining: misplacedSpecifiers, unexpectedBeforeFirst, arena: self.arena),
            name: first,
            unexpectedBeforeSecond,
            secondName: second,
            unexpectedBeforeColon,
            colon: colon,
            type: type,
            ellipsis: ellipsis,
            initializer: nil,
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
  ///
  /// Grammar
  /// =======
  ///
  ///     array-type → '[' type ']'
  ///
  ///     dictionary-type → '[' type ':' type ']'
  mutating func parseCollectionType() -> RawTypeSyntax {
    if let remaingingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawTypeSyntax(
        RawArrayTypeSyntax(
          remaingingTokens,
          leftSquareBracket: missingToken(.leftSquareBracket),
          elementType: RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena)),
          rightSquareBracket: missingToken(.rightSquareBracket),
          arena: self.arena
        )
      )
    }

    let (unexpectedBeforeLSquare, lsquare) = self.expect(.leftSquareBracket)
    let firstType = self.parseType()
    if let colon = self.consume(if: .colon) {
      let secondType = self.parseType()
      let (unexpectedBeforeRSquareBracket, rSquareBracket) = self.expect(.rightSquareBracket)
      return RawTypeSyntax(
        RawDictionaryTypeSyntax(
          unexpectedBeforeLSquare,
          leftSquareBracket: lsquare,
          keyType: firstType,
          colon: colon,
          valueType: secondType,
          unexpectedBeforeRSquareBracket,
          rightSquareBracket: rSquareBracket,
          arena: self.arena
        )
      )
    } else {
      let (unexpectedBeforeRSquareBracket, rSquareBracket) = self.expect(.rightSquareBracket)
      return RawTypeSyntax(
        RawArrayTypeSyntax(
          unexpectedBeforeLSquare,
          leftSquareBracket: lsquare,
          elementType: firstType,
          unexpectedBeforeRSquareBracket,
          rightSquareBracket: rSquareBracket,
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

    if self.currentToken.isEllipsis {
      self.consumeAnyToken()
    }

    return true
  }

  mutating func skipTypeAttributeList() {
    var specifierProgress = LoopProgressCondition()
    // TODO: Can we model isolated/_const so that they're specified in both canParse* and parse*?
    while canHaveParameterSpecifier,
      self.at(anyIn: TypeSpecifier.self) != nil || self.at(.keyword(.isolated)) || self.at(.keyword(._const)),
      specifierProgress.evaluate(currentToken)
    {
      self.consumeAnyToken()
    }

    var attributeProgress = LoopProgressCondition()
    while self.at(.atSign), attributeProgress.evaluate(currentToken) {
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

    if self.isAtFunctionTypeArrow() {
      // Handle type-function if we have an '->' with optional
      // 'async' and/or 'throws'.
      var loopProgress = LoopProgressCondition()
      while let (_, handle) = self.at(anyIn: EffectSpecifier.self), loopProgress.evaluate(currentToken) {
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

    var loopCondition = LoopProgressCondition()
    while self.atContextualPunctuator("&") && loopCondition.evaluate(self.currentToken) {
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
    case TokenSpec(.leftSquareBracket):
      self.consumeAnyToken()
      guard self.canParseType() else {
        return false
      }
      if self.consume(if: .colon) != nil {
        guard self.canParseType() else {
          return false
        }
      }
      guard self.consume(if: .rightSquareBracket) != nil else {
        return false
      }
    case TokenSpec(.wildcard):
      self.consumeAnyToken()
    case TokenSpec(.repeat):
      return true
    default:
      return false
    }

    var loopCondition = LoopProgressCondition()
    while loopCondition.evaluate(currentToken) {
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

      if !self.currentToken.isAtStartOfLine {
        if self.at(.postfixQuestionMark) || self.at(.exclamationMark) {
          self.consumeAnyToken()
          continue
        }
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
        if self.currentToken.canBeArgumentLabel() {
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
          while !self.at(.eof)
            && !self.at(.rightParen, .rightBrace, .comma)
            && !self.atContextualPunctuator("...")
            && !self.atStartOfDeclaration()
            && skipProgress.evaluate(currentToken)
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
    } while self.consume(if: .comma) != nil && loopProgress.evaluate(currentToken)
    return self.consume(if: .rightParen) != nil
  }

  mutating func isAtFunctionTypeArrow() -> Bool {
    if self.at(.arrow) {
      return true
    }

    if self.at(anyIn: EffectSpecifier.self) != nil {
      if self.peek().rawTokenKind == .arrow {
        return true
      }

      if EffectSpecifier(lexeme: self.peek()) != nil {
        var backtrack = self.lookahead()
        backtrack.consumeAnyToken()
        backtrack.consumeAnyToken()
        return backtrack.isAtFunctionTypeArrow()
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
    if self.currentToken.starts(with: "<") && !self.consumeGenericArguments() {
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
    guard self.currentToken.starts(with: "<") else {
      return false
    }

    self.consumePrefix("<", as: .leftAngle)

    if !self.currentToken.starts(with: ">") {
      var loopProgress = LoopProgressCondition()
      repeat {
        guard self.canParseType() else {
          return false
        }
        // Parse the comma, if the list continues.
      } while self.consume(if: .comma) != nil && loopProgress.evaluate(currentToken)
    }

    guard self.currentToken.starts(with: ">") else {
      return false
    }

    self.consumePrefix(">", as: .rightAngle)
    return true
  }
}

extension Parser {
  mutating func parseTypeAttributeList(misplacedSpecifiers: [RawTokenSyntax] = []) -> (
    specifier: RawTokenSyntax?, unexpectedBeforeAttributes: RawUnexpectedNodesSyntax?, attributes: RawAttributeListSyntax?
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

    enum ExtraneousSpecifier: TokenSpecSet {
      case `inout`
      case __shared
      case __owned
      case isolated
      case _const
      case consuming
      case borrowing

      var spec: TokenSpec {
        switch self {
        case .inout: return .keyword(.inout)
        case .__shared: return .keyword(.__shared)
        case .__owned: return .keyword(.__owned)
        case .isolated: return .keyword(.isolated)
        case ._const: return .keyword(._const)
        case .consuming: return .keyword(.consuming)
        case .borrowing: return .keyword(.borrowing)
        }
      }

      init?(lexeme: Lexer.Lexeme) {
        switch PrepareForKeywordMatch(lexeme) {
        case TokenSpec(.inout): self = .inout
        case TokenSpec(.__shared): self = .__shared
        case TokenSpec(.__owned): self = .__owned
        case TokenSpec(.isolated): self = .isolated
        case TokenSpec(._const): self = ._const
        case TokenSpec(.consuming): self = .consuming
        case TokenSpec(.borrowing): self = .borrowing
        default: return nil
        }
      }
    }

    while canHaveParameterSpecifier,
      let extraSpecifier = self.consume(ifAnyIn: ExtraneousSpecifier.self)
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

    return (specifier, unexpectedBeforeAttributeList, nil)
  }

  mutating func parseTypeAttributeListPresent() -> RawAttributeListSyntax {
    var elements = [RawAttributeListSyntax.Element]()
    var attributeProgress = LoopProgressCondition()
    while self.at(.atSign) && attributeProgress.evaluate(currentToken) {
      elements.append(self.parseTypeAttribute())
    }
    return RawAttributeListSyntax(elements: elements, arena: self.arena)
  }

  mutating func parseTypeAttribute() -> RawAttributeListSyntax.Element {
    let typeAttr = Parser.TypeAttribute(lexeme: self.peek())

    switch typeAttr {
    case ._local, ._noMetadata, .async, .escaping, .noDerivative, .noescape, .Sendable, .unchecked, .autoclosure:
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
        return .argumentList(RawTupleExprElementListSyntax(elements: arguments, arena: parser.arena))
      }

    }
  }
}

extension Parser {
  mutating func parseResultType() -> RawTypeSyntax {
    if self.currentToken.starts(with: "<") {
      let generics = self.parseGenericParameters()
      let baseType = self.parseType()
      return RawTypeSyntax(
        RawNamedOpaqueReturnTypeSyntax(
          genericParameters: generics,
          baseType: baseType,
          arena: self.arena
        )
      )
    } else {
      return self.parseType()
    }
  }
}

extension Lexer.Lexeme {
  var isAnyOperator: Bool {
    return self.rawTokenKind == .binaryOperator
      || self.rawTokenKind == .postfixOperator
      || self.rawTokenKind == .prefixOperator
  }

  var isAttachedKeyword: Bool {
    return self.rawTokenKind == .identifier && self.tokenText == "attached"
  }

  var isEllipsis: Bool {
    return self.isAnyOperator && self.tokenText == "..."
  }

  var isGenericTypeDisambiguatingToken: Bool {
    switch self.rawTokenKind {
    case .rightParen,
      .rightSquareBracket,
      .leftBrace,
      .rightBrace,
      .period,
      .comma,
      .semicolon,
      .eof,
      .exclamationMark,
      .postfixQuestionMark,
      .colon:
      return true
    case .binaryOperator:
      return self.tokenText == "&"
    case .postfixOperator:
      return false
    case .leftParen, .leftSquareBracket:
      // These only apply to the generic type if they don't start a new line.
      return !self.isAtStartOfLine
    default:
      return false
    }
  }
}
