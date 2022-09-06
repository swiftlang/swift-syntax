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
    let (specifier, attrList) = self.parseTypeAttributeList()
    var base = RawTypeSyntax(self.parseSimpleOrCompositionType())
    if self.lookahead().isAtFunctionTypeArrow() {
      let firstEffect = self.parseEffectsSpecifier()
      let secondEffect = self.parseEffectsSpecifier()
      let arrow = self.eat(.arrow)
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
    let someOrAny: RawTokenSyntax?
    if self.currentToken.isContextualKeyword("some") || self.currentToken.isContextualKeyword("any") {
      someOrAny = self.consumeAnyToken()
    } else {
      someOrAny = nil
    }

    var base = self.parseSimpleType()
    guard self.currentToken.isContextualPunctuator("&") else {
      if let someOrAny = someOrAny {
        return RawTypeSyntax(RawConstrainedSugarTypeSyntax(
          someOrAnySpecifier: someOrAny, baseType: base, arena: self.arena))
      } else {
        return base
      }
    }

    var elements = [RawCompositionTypeElementSyntax]()
    if self.currentToken.isContextualPunctuator("&") {
      let firstAmpersand = self.consumeAnyToken()
      elements.append(RawCompositionTypeElementSyntax(
        type: base, ampersand: firstAmpersand, arena: self.arena))

      var keepGoing = false
      var loopProgress = LoopProgressCondition()
      repeat {
        let elementType = self.parseSimpleType()
        keepGoing = self.currentToken.isContextualPunctuator("&")
        let ampersand: RawTokenSyntax?
        if keepGoing {
          ampersand = self.consumeAnyToken()
        } else {
          ampersand = nil
        }
        elements.append(RawCompositionTypeElementSyntax(
          type: elementType, ampersand: ampersand, arena: self.arena))
      } while keepGoing && loopProgress.evaluate(currentToken)

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
  public mutating func parseSimpleType() -> RawTypeSyntax {
    var base: RawTypeSyntax
    switch self.currentToken.tokenKind {
    case .capitalSelfKeyword,
        .anyKeyword,
        .identifier:
      base = self.parseTypeIdentifier()
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
      if self.at(.period) || self.at(.prefixPeriod) {
        if self.peek().isContextualKeyword("Type") || self.peek().isContextualKeyword("Protocol") {
          let period = self.consumeAnyToken()
          let type = self.consumeIdentifier()
          base = RawTypeSyntax(RawMetatypeTypeSyntax(
            baseType: base, period: period, typeOrProtocol: type, arena: self.arena))
        }
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
    let mark = self.eat(.postfixQuestionMark)
    return RawOptionalTypeSyntax(
      wrappedType: base, questionMark: mark, arena: self.arena)
  }

  /// Parse an optional type.
  ///
  /// Grammar
  /// =======
  ///
  ///     implicitly-unwrapped-optional-type → type '!'
  @_spi(RawSyntax)
  public mutating func parseImplicitlyUnwrappedOptionalType(_ base: RawTypeSyntax) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
    let mark = self.eat(.exclamationMark)
    return RawImplicitlyUnwrappedOptionalTypeSyntax(
      wrappedType: base, exclamationMark: mark, arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseTypeIdentifier() -> RawTypeSyntax {
    if self.currentToken.tokenKind == .anyKeyword {
      return RawTypeSyntax(self.parseAnyType())
    }

    var result: RawTypeSyntax?
    var keepGoing: RawTokenSyntax? = nil
    var loopProgress = LoopProgressCondition()
    repeat {
      let (name, _) = self.parseDeclNameRef()
      let generics: RawGenericArgumentClauseSyntax?
      if self.currentToken.isAnyOperator && self.currentToken.tokenText == "<" {
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
      keepGoing = self.consume(if: .period) ?? self.consume(if: .prefixPeriod)
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
    let name = self.eat(.anyKeyword)
    return RawSimpleTypeIdentifierSyntax(
      name: name, genericArgumentClause: nil, arena: self.arena)
  }

  /// Parse a type placeholder.
  ///
  /// Grammar
  /// =======
  ///
  ///     placeholder-type → wildcard
  @_spi(RawSyntax)
  public mutating func parsePlaceholderType() -> RawSimpleTypeIdentifierSyntax {
    let name = self.eat(.wildcardKeyword)
    // FIXME: Need a better syntax node than this
    return RawSimpleTypeIdentifierSyntax(
      name: name, genericArgumentClause: nil, arena: self.arena)
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
    let lparen = self.eat(.leftParen)
    var elements = [RawTupleTypeElementSyntax]()
    do {
      var keepGoing = true
      var loopProgress = LoopProgressCondition()
      while !self.at(.eof) && !self.at(.rightParen) && keepGoing && loopProgress.evaluate(currentToken) {
        let first: RawTokenSyntax?
        let second: RawTokenSyntax?
        let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
        let colon: RawTokenSyntax?
        if self.lookahead().startsParameterName(false) {
          first = self.parseArgumentLabel()
          if self.currentToken.tokenKind == .colon {
            (unexpectedBeforeColon, colon) = self.expect(.colon)
            second = nil
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
        let trailingComma = self.consume(if: .comma)
        keepGoing = trailingComma != nil
        elements.append(RawTupleTypeElementSyntax(
            inOut: nil,
            name: first,
            secondName: second,
            unexpectedBeforeColon,
            colon: colon,
            type: type,
            ellipsis: nil,
            initializer: nil,
            trailingComma: trailingComma,
            arena: self.arena
          ))
      }
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawTupleTypeSyntax(
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
    let lsquare = self.eat(.leftSquareBracket)
    let firstType = self.parseType()
    if self.at(.colon) {
      let colon = self.eat(.colon)
      let secondType = self.parseType()
      let (unexpectedBeforeRSquareBracket, rSquareBracket) = self.expect(.rightSquareBracket)
      return RawTypeSyntax(RawDictionaryTypeSyntax(
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

    if self.currentToken.isContextualKeyword("some") {
      self.consumeAnyToken()
    } else if self.currentToken.isContextualKeyword("any") {
      self.consumeAnyToken()
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
      if (self.at(.period) || self.at(.prefixPeriod)) &&
          (self.peek().isContextualKeyword("Type")
           || self.peek().isContextualKeyword("Protocol")) {
        self.consumeAnyToken()
        self.consumeIdentifier()
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
    while self.currentToken.isEffectsSpecifier && loopProgress.evaluate(currentToken) {
      self.consumeAnyToken()
    }

    guard self.consume(if: .arrow) != nil else {
      return false
    }

    return self.canParseType()
  }

  mutating func canParseTupleBodyType() -> Bool {
    guard
      !self.at(.rightParen) &&
        !self.at(.rightBrace) &&
        !self.currentToken.isEllipsis &&
        !self.isStartOfDeclaration()
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
          while !self.at(.eof) && !self.at(.rightParen)
                  && !self.at(.rightBrace) && !self.currentToken.isEllipsis
                  && !self.at(.comma) && !self.isStartOfDeclaration()
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

      if self.currentToken.isEllipsis {
        self.consumeAnyToken()
      }
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
      if (self.at(.period) || self.at(.prefixPeriod)) &&
          !self.peek().isContextualKeyword("Type") &&
          !self.peek().isContextualKeyword("Protocol") {
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

    if self.currentToken.isEffectsSpecifier {
      if self.peek().tokenKind == .arrow {
        return true
      }

      if self.peek().isEffectsSpecifier {
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

      if self.currentToken.isContextualPunctuator("&") {
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
    guard self.currentToken.isIdentifier || self.at(.capitalSelfKeyword) || self.at(.anyKeyword) else {
      return false
    }
    self.consumeAnyToken()

    // Parse an optional generic argument list.
    if self.currentToken.starts(with: "<") && !self.canParseGenericArguments() {
      return false
    }

    return true
  }

  func canParseAsGenericArgumentList() -> Bool {
    guard self.currentToken.isAnyOperator && self.currentToken.tokenText == "<" else {
      return false
    }

    var lookahead = self.lookahead()
    guard lookahead.canParseGenericArguments() else {
      return false
    }
    return lookahead.currentToken.isGenericTypeDisambiguatingToken
  }

  mutating func canParseGenericArguments() -> Bool {
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
    let specifier: RawTokenSyntax?
    if self.at(.inoutKeyword) {
      specifier = self.eat(.inoutKeyword)
    } else if self.currentToken.isIdentifier {
      if self.currentToken.tokenText == "__shared" {
        specifier = self.consumeAnyToken()
      } else if self.currentToken.tokenText == "__owned" {
        specifier = self.consumeAnyToken()
      } else {
        specifier = nil
      }
    } else {
      specifier = nil
    }

    if self.at(.atSign) || self.at(.inoutKeyword) {
      return (specifier, self.parseTypeAttributeListPresent())
    }

    if self.currentToken.isIdentifier {
      if self.currentToken.tokenText == "__shared"
          || self.currentToken.tokenText == "__owned"
          || self.currentToken.isContextualKeyword("isolated")
          || self.currentToken.isContextualKeyword("_const") {
        return (specifier, self.parseTypeAttributeListPresent())

      }
    }
    return (specifier, nil)
  }

  @_spi(RawSyntax)
  public mutating func parseTypeAttributeListPresent() -> RawAttributeListSyntax {
    var elements = [RawSyntax]()
    var modifiersProgress = LoopProgressCondition()
    while (self.at(.inoutKeyword)
           || self.currentToken.isContextualKeyword("__shared")
           || self.currentToken.isContextualKeyword("__owned")
           || self.currentToken.isContextualKeyword("isolated")
           || self.currentToken.isContextualKeyword("_const")
    ) && modifiersProgress.evaluate(currentToken) {
      if self.at(.inoutKeyword) {
        let inoutKeyword = self.eat(.inoutKeyword)
        elements.append(RawSyntax(inoutKeyword))
      } else {
        let ident = self.consumeIdentifier()
        elements.append(RawSyntax(ident))
      }
    }

    var attributeProgress = LoopProgressCondition()
    while self.at(.atSign) && attributeProgress.evaluate(currentToken) {
      elements.append(RawSyntax(self.parseTypeAttribute()))
    }
    return RawAttributeListSyntax(elements: elements, arena: self.arena)
  }

  @_spi(RawSyntax)
  public mutating func parseTypeAttribute() -> RawAttributeSyntax {
    let at = self.eat(.atSign)
    let ident = self.consumeIdentifier()
    if let attr = Parser.TypeAttribute(rawValue: ident.tokenText) {
      // Ok, it is a valid attribute, eat it, and then process it.
      if case .convention = attr {
        let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
        let convention = self.consumeIdentifier()
        let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
        return RawAttributeSyntax(
          atSignToken: at,
          attributeName: ident,
          unexpectedBeforeLeftParen,
          leftParen: leftParen,
          argument: RawSyntax(convention),
          unexpectedBeforeRightParen,
          rightParen: rightParen,
          tokenList: nil,
          arena: self.arena)
      }
    }
    return RawAttributeSyntax(
      atSignToken: at,
      attributeName: ident,
      leftParen: nil,
      argument: nil,
      rightParen: nil,
      tokenList: nil,
      arena: self.arena)
  }
}

extension Lexer.Lexeme {
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
