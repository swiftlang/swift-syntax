//===-------------------------- Types.swift -------------------------------===//
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
  /// Parse a type.
  ///
  /// Grammar
  /// =======
  ///
  ///     type → function-type
  ///     type → array-type
  ///     type → dictionary-type
  ///     type → type-identifier
  ///     type → tuple-type
  ///     type → optional-type
  ///     type → implicitly-unwrapped-optional-type
  ///     type → protocol-composition-type
  ///     type → opaque-type
  ///     type → metatype-type
  ///     type → any-type
  ///     type → self-type
  ///     type → '(' type ')'
  @_spi(RawSyntax)
  public mutating func parseType() -> RawTypeSyntax {
    let type = self.parseTypeScalar()

    // Parse pack expansion 'T...'.
    if self.currentToken.isEllipsis {
      let ellipsis = self.consumeAnyToken(remapping: .ellipsis)
      return RawTypeSyntax(
        RawPackExpansionTypeSyntax(
          patternType: type,
          ellipsis: ellipsis,
          arena: self.arena))
    }
    return type
  }

  mutating func parseTypeScalar() -> RawTypeSyntax {
    let (specifier, attrList) = self.parseTypeAttributeList()
    var base = RawTypeSyntax(self.parseSimpleOrCompositionType())
    if self.lookahead().isAtFunctionTypeArrow() {
      let firstEffect = self.parseEffectsSpecifier()
      let secondEffect = self.parseEffectsSpecifier()
      let (unexpectedBeforeArrow, arrow) = self.expect(.arrow)
      let returnTy = self.parseType()

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
        arguments = RawTupleTypeElementListSyntax(elements: [
          RawTupleTypeElementSyntax(
            inOut: nil, name: nil, secondName: nil, colon: nil, type: base,
            ellipsis: nil, initializer: nil, trailingComma: nil, arena: self.arena)
        ], arena: self.arena)
        unexpectedBetweenElementsAndRightParen = nil
        rightParen = RawTokenSyntax(missing: .rightParen, arena: self.arena)
      }

      base = RawTypeSyntax(RawFunctionTypeSyntax(
        unexpectedBeforeLeftParen,
        leftParen: leftParen,
        unexpectedBetweenLeftParenAndElements,
        arguments: arguments,
        unexpectedBetweenElementsAndRightParen,
        rightParen: rightParen,
        asyncKeyword: firstEffect,
        throwsOrRethrowsKeyword: secondEffect,
        unexpectedBeforeArrow,
        arrow: arrow,
        returnType: returnTy,
        arena: self.arena))
    }

    if attrList != nil || specifier != nil {
      return RawTypeSyntax(RawAttributedTypeSyntax(
        specifier: specifier,
        attributes: attrList,
        baseType: base, arena: self.arena))
    } else {
      return RawTypeSyntax(base)
    }
  }

  /// Parse a protocol composition involving at least one element.
  ///
  /// Grammar
  /// =======
  ///
  ///     type-identifier → type-name generic-argument-clause? | type-name generic-argument-clause? '.' type-identifier
  ///     type-name → identifier
  ///
  ///     protocol-composition-type → type-identifier '&' protocol-composition-continuation
  ///     protocol-composition-continuation → type-identifier | protocol-composition-type
  @_spi(RawSyntax)
  public mutating func parseSimpleOrCompositionType() -> RawTypeSyntax {
    let someOrAny = self.consume(ifAny: [], contextualKeywords: ["some", "any"])

    var base = self.parseSimpleType()
    guard self.atContextualPunctuator("&") else {
      if let someOrAny = someOrAny {
        return RawTypeSyntax(RawConstrainedSugarTypeSyntax(
          someOrAnySpecifier: someOrAny, baseType: base, arena: self.arena))
      } else {
        return base
      }
    }

    var elements = [RawCompositionTypeElementSyntax]()
    if let firstAmpersand = self.consumeIfContextualPunctuator("&") {
      elements.append(RawCompositionTypeElementSyntax(
        type: base, ampersand: firstAmpersand, arena: self.arena))

      var keepGoing: RawTokenSyntax? = nil
      var loopProgress = LoopProgressCondition()
      repeat {
        let elementType = self.parseSimpleType()
        keepGoing = self.consumeIfContextualPunctuator("&")
        elements.append(RawCompositionTypeElementSyntax(
          type: elementType,
          ampersand: keepGoing,
          arena: self.arena
        ))
      } while keepGoing != nil && loopProgress.evaluate(currentToken)

      base = RawTypeSyntax(RawCompositionTypeSyntax(
        elements: RawCompositionTypeElementListSyntax(elements: elements, arena: self.arena),
        arena: self.arena))
    }

    if let someOrAny = someOrAny {
      return RawTypeSyntax(RawConstrainedSugarTypeSyntax(
        someOrAnySpecifier: someOrAny, baseType: base, arena: self.arena))
    } else {
      return base
    }
  }

  /// Parse a "simple" type
  ///
  /// Grammar
  /// =======
  ///
  ///     type → type-identifier
  ///     type → tuple-type
  ///     type → array-type
  ///     type → dictionary-type
  ///     type → metatype-type
  ///
  ///     metatype-type → type '.' 'Type' | type '.' 'Protocol'
  @_spi(RawSyntax)
  public mutating func parseSimpleType(
    stopAtFirstPeriod: Bool = false
  ) -> RawTypeSyntax {
    var base: RawTypeSyntax
    switch self.currentToken.tokenKind {
    case .capitalSelfKeyword,
        .anyKeyword,
        .identifier:
      base = self.parseTypeIdentifier(stopAtFirstPeriod: stopAtFirstPeriod)
    case .leftParen:
      base = RawTypeSyntax(self.parseTupleTypeBody())
    case .leftSquareBracket:
      base = RawTypeSyntax(self.parseCollectionType())
    case .wildcardKeyword:
      base = RawTypeSyntax(self.parsePlaceholderType())
    default:
      return RawTypeSyntax(RawMissingTypeSyntax(arena: self.arena))
    }

    // '.Type', '.Protocol', '?', '!', and '[]' still leave us with type-simple.
    var loopCondition = LoopProgressCondition()
    while loopCondition.evaluate(currentToken) {
      if !stopAtFirstPeriod, let (period, type) = self.consume(
        if: { [.period, .prefixPeriod].contains($0.tokenKind) },
        followedBy: { $0.isContextualKeyword(["Type", "Protocol"])}
      ) {
        base = RawTypeSyntax(RawMetatypeTypeSyntax(
          baseType: base, period: period, typeOrProtocol: type, arena: self.arena))
        continue
      }

      if !self.currentToken.isAtStartOfLine {
        if self.currentToken.isOptionalToken {
          base = RawTypeSyntax(self.parseOptionalType(base))
          continue
        }
        if self.currentToken.isImplicitlyUnwrappedOptionalToken {
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
  @_spi(RawSyntax)
  public mutating func parseOptionalType(_ base: RawTypeSyntax) -> RawOptionalTypeSyntax {
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
  @_spi(RawSyntax)
  public mutating func parseImplicitlyUnwrappedOptionalType(_ base: RawTypeSyntax) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
    let (unexpectedBeforeMark, mark) = self.expect(.exclamationMark)
    return RawImplicitlyUnwrappedOptionalTypeSyntax(
      wrappedType: base,
      unexpectedBeforeMark,
      exclamationMark: mark,
      arena: self.arena
    )
  }

  @_spi(RawSyntax)
  public mutating func parseTypeIdentifier(
    stopAtFirstPeriod: Bool = false
  ) -> RawTypeSyntax {
    if self.at(.anyKeyword) && !stopAtFirstPeriod {
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

      if stopAtFirstPeriod {
        keepGoing = nil
      } else {
        keepGoing = self.consume(if: .period) ?? self.consume(if: .prefixPeriod)
      }
    } while keepGoing != nil && loopProgress.evaluate(currentToken)

    return result!
  }

  /// Parse the existential `Any` type.
  ///
  /// Grammar
  /// =======
  ///
  ///     any-type → Any
  @_spi(RawSyntax)
  public mutating func parseAnyType() -> RawSimpleTypeIdentifierSyntax {
    let (unexpectedBeforeName, name) = self.expect(.anyKeyword)
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
  @_spi(RawSyntax)
  public mutating func parsePlaceholderType() -> RawSimpleTypeIdentifierSyntax {
    let (unexpectedBeforeName, name) = self.expect(.wildcardKeyword)
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
  @_spi(RawSyntax)
  public mutating func parseGenericArguments() -> RawGenericArgumentClauseSyntax {
    assert(self.currentToken.starts(with: "<"))
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
        arguments.append(RawGenericArgumentSyntax(
          argumentType: type, trailingComma: keepGoing, arena: self.arena))
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
      arena: self.arena)
  }
}

extension Parser {
  /// Parse a tuple type.
  ///
  /// Grammar
  /// =======
  ///
  ///     tuple-type → '(' ')' | '(' tuple-type-element ',' tuple-type-element-list ')'
  ///     tuple-type-element-list → tuple-type-element | tuple-type-element ',' tuple-type-element-list
  ///     tuple-type-element → element-name type-annotation | type
  ///     element-name → identifier
  @_spi(RawSyntax)
  public mutating func parseTupleTypeBody() -> RawTupleTypeSyntax {
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    var elements = [RawTupleTypeElementSyntax]()
    do {
      var keepGoing = true
      var loopProgress = LoopProgressCondition()
      while !self.at(any: [.eof, .rightParen]) && keepGoing && loopProgress.evaluate(currentToken) {
        let first: RawTokenSyntax?
        let second: RawTokenSyntax?
        let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
        let colon: RawTokenSyntax?
        if self.lookahead().startsParameterName(false) {
          first = self.parseArgumentLabel()
          if let parsedColon = self.consume(if: .colon) {
            second = nil
            unexpectedBeforeColon = nil
            colon = parsedColon
          } else if self.currentToken.canBeArgumentLabel && self.peek().tokenKind == .colon {
            second = self.parseArgumentLabel()
            (unexpectedBeforeColon, colon) = self.expect(.colon)
          } else {
            second = nil
            unexpectedBeforeColon = nil
            colon = RawTokenSyntax(missing: .colon, arena: self.arena)
          }
        } else {
          first = nil
          second = nil
          unexpectedBeforeColon = nil
          colon = nil
        }
        // Parse the type annotation.
        let type = self.parseType()
        let ellipsis = self.currentToken.isEllipsis ? self.consumeAnyToken() : nil
        let trailingComma = self.consume(if: .comma)
        keepGoing = trailingComma != nil
        elements.append(RawTupleTypeElementSyntax(
            inOut: nil,
            name: first,
            secondName: second,
            unexpectedBeforeColon,
            colon: colon,
            type: type,
            ellipsis: ellipsis,
            initializer: nil,
            trailingComma: trailingComma,
            arena: self.arena
          ))
      }
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawTupleTypeSyntax(
      unexpectedBeforeLParen,
      leftParen: lparen,
      elements: RawTupleTypeElementListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: self.arena)
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
  @_spi(RawSyntax)
  public mutating func parseCollectionType() -> RawTypeSyntax {
    let (unexpectedBeforeLSquare, lsquare) = self.expect(.leftSquareBracket)
    let firstType = self.parseType()
    if let colon = self.consume(if: .colon) {
      let secondType = self.parseType()
      let (unexpectedBeforeRSquareBracket, rSquareBracket) = self.expect(.rightSquareBracket)
      return RawTypeSyntax(RawDictionaryTypeSyntax(
        unexpectedBeforeLSquare,
        leftSquareBracket: lsquare,
        keyType: firstType,
        colon: colon,
        valueType: secondType,
        unexpectedBeforeRSquareBracket,
        rightSquareBracket: rSquareBracket,
        arena: self.arena
      ))
    } else {
      let (unexpectedBeforeRSquareBracket, rSquareBracket) = self.expect(.rightSquareBracket)
      return RawTypeSyntax(RawArrayTypeSyntax(
        unexpectedBeforeLSquare,
        leftSquareBracket: lsquare,
        elementType: firstType,
        unexpectedBeforeRSquareBracket,
        rightSquareBracket: rSquareBracket,
        arena: self.arena
      ))
    }
  }
}

extension Parser.Lookahead {
  mutating func canParseType() -> Bool {
    // Accept 'inout' at for better recovery.
    _ = self.consume(if: .inoutKeyword)

    if self.consumeIfContextualKeyword("some") != nil {
    } else {
      self.consumeIfContextualKeyword("any")
    }

    switch self.currentToken.tokenKind {
    case .capitalSelfKeyword, .anyKeyword:
      guard self.canParseTypeIdentifier() else {
        return false
      }
    case .protocolKeyword, // Deprecated composition syntax
        .identifier:
      guard self.canParseIdentifierTypeOrCompositionType() else {
        return false
      }
    case .leftParen:
      self.consumeAnyToken()
      guard self.canParseTupleBodyType() else {
        return false
      }
    case .atSign:
      self.consumeAnyToken()
      self.skipTypeAttribute()
      return self.canParseType()
    case .leftSquareBracket:
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
    case .wildcardKeyword:
      self.consumeAnyToken()
    default:
      return false
    }

    // '.Type', '.Protocol', '?', and '!' still leave us with type-simple.
    var loopCondition = LoopProgressCondition()
    while loopCondition.evaluate(currentToken) {
      if let (_, _) = self.consume(
        if: { [.period, .prefixPeriod].contains($0.tokenKind) },
        followedBy: { $0.isContextualKeyword(["Type", "Protocol"])}) {
        continue
      }
      if self.currentToken.isOptionalToken {
        self.consumePrefix("?", as: .postfixQuestionMark)
        continue
      }
      if self.currentToken.isImplicitlyUnwrappedOptionalToken {
        self.consumePrefix("!", as: .exclamationMark)
        continue
      }
      break
    }

    guard self.isAtFunctionTypeArrow() else {
      return true
    }

    // Handle type-function if we have an '->' with optional
    // 'async' and/or 'throws'.
    var loopProgress = LoopProgressCondition()
    while let (_, handle) = self.at(anyIn: EffectsSpecifier.self), loopProgress.evaluate(currentToken) {
      self.eat(handle)
    }

    guard self.consume(if: .arrow) != nil else {
      return false
    }

    return self.canParseType()
  }

  mutating func canParseTupleBodyType() -> Bool {
    guard
      !self.at(any: [.rightParen, .rightBrace]) &&
        !self.atContextualPunctuator("...") &&
        !self.atStartOfDeclaration()
    else {
      return self.consume(if: .rightParen) != nil
    }

    var loopProgress = LoopProgressCondition()
    repeat {
      // The contextual inout marker is part of argument lists.
      _ = self.consume(if: .inoutKeyword)

      // If the tuple element starts with "ident :", then it is followed
      // by a type annotation.
      if self.startsParameterName(/*isClosure=*/false) {
        self.consumeAnyToken()
        if self.currentToken.canBeArgumentLabel {
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
          while !self.at(any: [.eof, .rightParen, .rightBrace, .comma])
                  && !self.atContextualPunctuator("...")
                  && !self.atStartOfDeclaration()
                  && skipProgress.evaluate(currentToken) {
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
  
  mutating func canParseTypeIdentifier() -> Bool {
    var loopCondition = LoopProgressCondition()
    while loopCondition.evaluate(currentToken) {
      guard self.canParseSimpleTypeIdentifier() else {
        return false
      }

      // Treat 'Foo.<anything>' as an attempt to write a dotted type
      // unless <anything> is 'Type' or 'Protocol'.
      if self.at(any: [.period, .prefixPeriod]) &&
          !self.peek().isContextualKeyword(["Type", "Protocol"]) {
        self.consumeAnyToken()
      } else {
        return true
      }
    }
    preconditionFailure("Should return from inside the loop")
  }

  func isAtFunctionTypeArrow() -> Bool {
    if self.at(.arrow) {
      return true
    }

    if self.at(anyIn: EffectsSpecifier.self) != nil {
      if self.peek().tokenKind == .arrow {
        return true
      }

      if EffectsSpecifier(lexeme: self.peek()) != nil {
        var backtrack = self.lookahead()
        backtrack.consumeAnyToken()
        backtrack.consumeAnyToken()
        return backtrack.isAtFunctionTypeArrow()
      }

      return false
    }

    return false
  }

  mutating func canParseIdentifierTypeOrCompositionType() -> Bool {
    if self.at(.protocolKeyword) {
      return self.canParseOldStyleProtocolComposition()
    }

    var loopCondition = LoopProgressCondition()
    while loopCondition.evaluate(currentToken) {
      guard self.canParseTypeIdentifier() else {
        return false
      }

      if self.atContextualPunctuator("&") {
        self.consumeAnyToken()
        continue
      } else {
        return true
      }
    }
    preconditionFailure("Should return from inside the loop")
  }

  mutating func canParseOldStyleProtocolComposition() -> Bool {
    self.eat(.protocolKeyword)

    // Check for the starting '<'.
    guard self.currentToken.starts(with: "<") else {
      return false
    }

    self.consumePrefix("<", as: .leftAngle)

    // Check for empty protocol composition.
    if self.currentToken.starts(with: ">") {
      self.consumePrefix(">", as: .rightAngle)
      return true
    }

    // Parse the type-composition-list.
    var loopProgress = LoopProgressCondition()
    repeat {
      guard self.canParseTypeIdentifier() else {
        return false;
      }
    } while self.consume(if: .comma) != nil && loopProgress.evaluate(currentToken)

    // Check for the terminating '>'.
    guard self.currentToken.starts(with: ">") else {
      return false
    }
    self.consumePrefix(">", as: .rightAngle)

    return true
  }

  mutating func canParseSimpleTypeIdentifier() -> Bool {
    // Parse an identifier.
    guard self.at(.identifier) || self.at(any: [.capitalSelfKeyword, .anyKeyword]) else {
      return false
    }
    self.consumeAnyToken()

    // Parse an optional generic argument list.
    if self.currentToken.starts(with: "<") && !self.consumeGenericArguments() {
      return false
    }

    return true
  }

  func canParseAsGenericArgumentList() -> Bool {
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
    var loopProgress = LoopProgressCondition()
    repeat {
      guard self.canParseType() else {
        return false
      }
      // Parse the comma, if the list continues.
    } while self.consume(if: .comma) != nil && loopProgress.evaluate(currentToken)


    guard self.currentToken.starts(with: ">") else {
      return false
    }

    self.consumePrefix(">", as: .rightAngle)
    return true
  }
}

extension Parser {
  @_spi(RawSyntax)
  public mutating func parseTypeAttributeList() -> (RawTokenSyntax?, RawAttributeListSyntax?) {
    let specifier = self.consume(ifAny: [.inoutKeyword], contextualKeywords: ["__shared", "__owned"])

    if self.at(any: [.atSign, .inoutKeyword]) {
      return (specifier, self.parseTypeAttributeListPresent())
    }

    if self.at(.identifier) {
      if self.at(any: [], contextualKeywords: ["__shared", "__owned", "isolated", "_const"]) {
        return (specifier, self.parseTypeAttributeListPresent())

      }
    }
    return (specifier, nil)
  }

  @_spi(RawSyntax)
  public mutating func parseTypeAttributeListPresent() -> RawAttributeListSyntax {
    var elements = [RawSyntax]()
    var modifiersProgress = LoopProgressCondition()
    while let token = self.consume(ifAny: [.inoutKeyword], contextualKeywords: ["__shared", "__owned", "isolated", "_const"]), modifiersProgress.evaluate(currentToken) {
      elements.append(RawSyntax(token))
    }

    var attributeProgress = LoopProgressCondition()
    while self.at(.atSign) && attributeProgress.evaluate(currentToken) {
      elements.append(self.parseTypeAttribute())
    }
    return RawAttributeListSyntax(elements: elements, arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseTypeAttribute() -> RawSyntax {
    guard let typeAttr = Parser.TypeAttribute(rawValue: self.peek().tokenText) else {
      return RawSyntax(self.parseCustomAttribute())
    }

    switch typeAttr {
    case .differentiable:
      return RawSyntax(self.parseDifferentiableAttribute())

    case .convention:
      let (unexpectedBeforeAt, at) = self.expect(.atSign)
      let (unexpectedBeforeIdent, ident) = self.expectIdentifier()
      let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
      let arguments = self.parseConventionArguments()
      let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
      return RawSyntax(
        RawAttributeSyntax(
          unexpectedBeforeAt,
          atSignToken: at,
          unexpectedBeforeIdent,
          attributeName: ident,
          unexpectedBeforeLeftParen,
          leftParen: leftParen,
          argument: arguments,
          unexpectedBeforeRightParen,
          rightParen: rightParen,
          tokenList: nil,
          arena: self.arena
        )
      )
    case ._opaqueReturnTypeOf:
      let (unexpectedBeforeAt, at) = self.expect(.atSign)
      let ident = self.expectIdentifierWithoutRecovery()
      let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
      let argument = self.parseOpaqueReturnTypeOfAttributeArguments()
      let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
      return RawSyntax(
        RawAttributeSyntax(
          unexpectedBeforeAt,
          atSignToken: at,
          attributeName: ident,
          unexpectedBeforeLeftParen,
          leftParen: leftParen,
          argument: RawSyntax(argument),
          unexpectedBeforeRightParen,
          rightParen: rightParen,
          tokenList: nil,
          arena: self.arena
        )
      )

    default:
      let (unexpectedBeforeAt, at) = self.expect(.atSign)
      let ident = self.expectIdentifierWithoutRecovery()
      return RawSyntax(
        RawAttributeSyntax(
          unexpectedBeforeAt,
          atSignToken: at,
          attributeName: ident,
          leftParen: nil,
          argument: nil,
          rightParen: nil,
          tokenList: nil,
          arena: self.arena
        )
      )
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
          arena: self.arena))
    } else {
      return self.parseType()
    }
  }
}

extension Lexer.Lexeme {
  var isBinaryOperator: Bool {
    return self.tokenKind == .spacedBinaryOperator
        || self.tokenKind == .unspacedBinaryOperator
  }

  var isAnyOperator: Bool {
    return self.isBinaryOperator
        || self.tokenKind == .postfixOperator
        || self.tokenKind == .prefixOperator
  }

  var isEllipsis: Bool {
    return self.isAnyOperator && self.tokenText == "..."
  }

  var isOptionalToken: Bool {
    // A postfix '?' by itself is obviously optional.
    if self.tokenKind == .postfixQuestionMark {
      return true
    }
    // A postfix or bound infix operator token that begins with '?' can be
    // optional too.
    if self.tokenKind == .postfixOperator || self.tokenKind == .unspacedBinaryOperator {
      return self.tokenText.first == UInt8(ascii: "?")
    }

    return false
  }

  var isImplicitlyUnwrappedOptionalToken: Bool {
    // A postfix !?' by itself is obviously optional.
    if self.tokenKind == .exclamationMark {
      return true
    }
    // A postfix or bound infix operator token that begins with '?' can be
    // optional too.
    if self.tokenKind == .postfixOperator || self.tokenKind == .unspacedBinaryOperator {
      return self.tokenText.first == UInt8(ascii: "!")
    }

    return false
  }

  var isGenericTypeDisambiguatingToken: Bool {
    switch self.tokenKind {
    case .rightParen,
         .rightSquareBracket,
         .leftBrace,
         .rightBrace,
         .period,
         .prefixPeriod,
         .comma,
         .semicolon,
         .eof,
         .exclamationMark,
         .postfixQuestionMark,
         .colon:
      return true
    case .spacedBinaryOperator:
      return self.tokenText == "&"
    case .unspacedBinaryOperator,
         .postfixOperator:
      return self.isOptionalToken || self.isImplicitlyUnwrappedOptionalToken
    case .leftParen, .leftSquareBracket:
      // These only apply to the generic type if they don't start a new line.
      return !self.isAtStartOfLine
    default:
      return false
    }
  }
}
