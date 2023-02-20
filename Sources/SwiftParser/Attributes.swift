//===----------------------------------------------------------------------===//
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
  mutating func parseAttributeList() -> RawAttributeListSyntax? {
    guard self.at(any: [.atSign, .poundIfKeyword]) else {
      return nil
    }

    var elements = [RawAttributeListSyntax.Element]()
    var loopProgress = LoopProgressCondition()
    repeat {
      let attribute = self.parseAttribute()
      elements.append(attribute)
    } while self.at(any: [.atSign, .poundIfKeyword]) && loopProgress.evaluate(currentToken)
    return RawAttributeListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  mutating func parseAttribute() -> RawAttributeListSyntax.Element {
    if self.at(.poundIfKeyword) {
      return .ifConfigDecl(
        self.parsePoundIfDirective { (parser, _) -> RawAttributeListSyntax.Element in
          return parser.parseAttribute()
        } syntax: { parser, attributes in
          return .attributes(RawAttributeListSyntax(elements: attributes, arena: parser.arena))
        }
      )
    }

    guard let declAttr = DeclarationAttribute(rawValue: self.peek().tokenText) else {
      return .customAttribute(self.parseCustomAttribute())
    }

    switch declAttr {
    case .available:
      return .attribute(self.parseAvailabilityAttribute())
    case ._spi_available:
      return .attribute(self.parseSPIAvailableAttribute())
    case .differentiable:
      return .attribute(self.parseDifferentiableAttribute())
    case .derivative:
      return .attribute(self.parseDerivativeAttribute())
    case .transpose:
      return .attribute(self.parseTransposeAttribute())
    case .objc:
      return .attribute(self.parseObjectiveCAttribute())
    case ._specialize:
      return .attribute(self.parseSpecializeAttribute())
    case ._private:
      return .attribute(self.parsePrivateImportAttribute())
    case ._dynamicReplacement:
      return .attribute(self.parseDynamicReplacementAttribute())
    case ._spi:
      return .attribute(self.parseSPIAttribute())
    case ._implements:
      return .attribute(self.parseImplementsAttribute())
    case ._semantics:
      return .attribute(self.parseSemanticsAttribute())
    default:
      break
    }

    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeIdent, ident) = self.expectIdentifierOrRethrows()
    let leftParen = self.consume(if: .leftParen)
    let arg: RawAttributeSyntax.Argument?
    let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
    let rightParen: RawTokenSyntax?
    if leftParen != nil {
      var args = [RawTokenSyntax]()
      var loopProgress = LoopProgressCondition()
      while !self.at(any: [.eof, .rightParen]) && loopProgress.evaluate(currentToken) {
        args.append(self.consumeAnyToken())
      }
      arg = .tokenList(RawTokenListSyntax(elements: args, arena: self.arena))
      (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    } else {
      arg = nil
      unexpectedBeforeRightParen = nil
      rightParen = nil
    }
    return .attribute(
      RawAttributeSyntax(
        unexpectedBeforeAtSign,
        atSignToken: atSign,
        unexpectedBeforeIdent,
        attributeName: ident,
        leftParen: leftParen,
        argument: arg,
        unexpectedBeforeRightParen,
        rightParen: rightParen,
        tokenList: nil,
        arena: self.arena
      )
    )
  }

  mutating func parseCustomAttribute() -> RawCustomAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let attrName = self.parseType()

    // Custom attributes are stricter than normal attributes about their
    // argument lists "immediately" following the attribute name.
    guard self.lookahead().isCustomAttributeArgument(),
      let leftParen = self.consume(if: .leftParen, where: { !$0.isAtStartOfLine })
    else {
      return RawCustomAttributeSyntax(
        atSignToken: atSign,
        attributeName: attrName,
        leftParen: nil,
        argumentList: nil,
        rightParen: nil,
        arena: self.arena
      )
    }
    let arguments = self.parseArgumentListElements(pattern: .none)
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawCustomAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      attributeName: attrName,
      leftParen: leftParen,
      argumentList: RawTupleExprElementListSyntax(elements: arguments, arena: self.arena),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseAvailabilityAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeAvailable, available) = self.expectContextualKeyword("available")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let argument: RawAttributeSyntax.Argument
    do {
      if self.peek().tokenKind == .integerLiteral {
        argument = .availability(self.parseAvailabilitySpecList(from: .available))
      } else if self.peek().tokenKind == .floatingLiteral {
        argument = .availability(self.parseAvailabilitySpecList(from: .available))
      } else {
        argument = .availability(self.parseExtendedAvailabilitySpecList())
      }
    }
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeAvailable,
      attributeName: available,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: argument,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }

  mutating func parseSPIAvailableAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeAvailable, available) = self.expectContextualKeyword("_spi_available")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let argument: RawAttributeSyntax.Argument
    do {
      if self.peek().tokenKind == .integerLiteral {
        argument = .availability(self.parseAvailabilitySpecList(from: .available))
      } else if self.peek().tokenKind == .floatingLiteral {
        argument = .availability(self.parseAvailabilitySpecList(from: .available))
      } else {
        argument = .availability(self.parseExtendedAvailabilitySpecList())
      }
    }
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeAvailable,
      attributeName: available,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: argument,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseDifferentiableAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeDifferentiable, differentiable) = self.expectContextualKeyword("differentiable")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let argument = self.parseDifferentiableAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeDifferentiable,
      attributeName: differentiable,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .differentiableArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }

  enum DifferentiabilityKind: SyntaxText, ContextualKeywords {
    case reverse = "reverse"
    case linear = "_linear"
    case forward = "_forward"
  }

  mutating func parseDifferentiableAttributeArguments() -> RawDifferentiableAttributeArgumentsSyntax {
    let diffKind: RawTokenSyntax?
    let diffKindComma: RawTokenSyntax?
    if let (_, handle) = self.at(anyIn: DifferentiabilityKind.self) {
      diffKind = self.eat(handle)
      diffKindComma = self.consume(if: .comma)
    } else {
      diffKind = nil
      diffKindComma = nil
    }

    let diffParams: RawDifferentiabilityParamsClauseSyntax?
    let diffParamsComma: RawTokenSyntax?
    if self.atContextualKeyword("wrt") {
      diffParams = self.parseDifferentiabilityParameters()
      diffParamsComma = self.consume(if: .comma)
    } else {
      diffParams = nil
      diffParamsComma = nil
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.whereKeyword) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }
    return RawDifferentiableAttributeArgumentsSyntax(
      diffKind: diffKind,
      diffKindComma: diffKindComma,
      diffParams: diffParams,
      diffParamsComma: diffParamsComma,
      whereClause: whereClause,
      arena: self.arena
    )
  }

  mutating func parseDifferentiabilityParameters() -> RawDifferentiabilityParamsClauseSyntax {
    let (unexpectedBeforeWrt, wrt) = self.expectIdentifier(keywordRecovery: true)
    let (unexpectedBeforeColon, colon) = self.expect(.colon)

    guard let leftParen = self.consume(if: .leftParen) else {
      // If no opening '(' for parameter list, parse a single parameter.
      let param =
        self.parseDifferentiabilityParameter()
        ?? RawDifferentiabilityParamSyntax(
          parameter: missingToken(.identifier),
          trailingComma: nil,
          arena: self.arena
        )
      return RawDifferentiabilityParamsClauseSyntax(
        unexpectedBeforeWrt,
        wrtLabel: wrt,
        unexpectedBeforeColon,
        colon: colon,
        parameters: .parameter(param),
        arena: self.arena
      )
    }

    var elements = [RawDifferentiabilityParamSyntax]()
    var loopProgress = LoopProgressCondition()
    while !self.at(any: [.eof, .rightParen]) && loopProgress.evaluate(currentToken) {
      guard let param = self.parseDifferentiabilityParameter() else {
        break
      }
      elements.append(param)
    }
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    let parameters = RawDifferentiabilityParamListSyntax(elements: elements, arena: self.arena)
    let list = RawDifferentiabilityParamsSyntax(
      leftParen: leftParen,
      diffParams: parameters,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
    return RawDifferentiabilityParamsClauseSyntax(
      wrtLabel: wrt,
      unexpectedBeforeColon,
      colon: colon,
      parameters: .parameterList(list),
      arena: self.arena
    )
  }

  mutating func parseDifferentiabilityParameter() -> RawDifferentiabilityParamSyntax? {
    enum ExpectedTokenKind: RawTokenKindSubset {
      case identifier
      case integerLiteral
      case selfKeyword

      init?(lexeme: Lexer.Lexeme) {
        switch lexeme.tokenKind {
        case .identifier: self = .identifier
        case .integerLiteral: self = .integerLiteral
        case .selfKeyword: self = .selfKeyword
        default: return nil
        }
      }

      var rawTokenKind: RawTokenKind {
        switch self {
        case .identifier: return .identifier
        case .integerLiteral: return .integerLiteral
        case .selfKeyword: return .selfKeyword
        }
      }
    }

    switch self.at(anyIn: ExpectedTokenKind.self) {
    case (.identifier, let handle)?:
      let token = self.eat(handle)
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityParamSyntax(
        parameter: token,
        trailingComma: comma,
        arena: self.arena
      )
    case (.integerLiteral, let handle)?:
      let token = self.eat(handle)
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityParamSyntax(
        parameter: token,
        trailingComma: comma,
        arena: self.arena
      )
    case (.selfKeyword, let handle)?:
      let token = self.eat(handle)
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityParamSyntax(
        parameter: token,
        trailingComma: comma,
        arena: self.arena
      )
    case nil:
      return nil
    }
  }
}

extension Parser {
  mutating func parseDerivativeAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeDerivative, derivative) = self.expectContextualKeyword("derivative")

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let argument = self.parseDerivativeAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeDerivative,
      attributeName: derivative,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .derivativeRegistrationArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }

  mutating func parseTransposeAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeTranspose, transpose) = self.expectContextualKeyword("transpose")

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let argument = self.parseDerivativeAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeTranspose,
      attributeName: transpose,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .derivativeRegistrationArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }

  mutating func parseDerivativeAttributeArguments() -> RawDerivativeRegistrationAttributeArgumentsSyntax {
    let (unexpectedBeforeOfLabel, ofLabel) = self.expectContextualKeyword("of")
    let (unexpectedBetweenOfLabelAndColon, colon) = self.expect(.colon)
    let originalDeclName = self.parseQualifiedDeclarationName()
    let period = self.consume(if: .period)
    let accessor: RawTokenSyntax?
    if period != nil {
      accessor = self.parseAnyIdentifier()
    } else {
      accessor = nil
    }
    let comma = self.consume(if: .comma)
    let diffParams: RawDifferentiabilityParamsClauseSyntax?
    if comma != nil {
      diffParams = self.parseDifferentiabilityParameters()
    } else {
      diffParams = nil
    }
    return RawDerivativeRegistrationAttributeArgumentsSyntax(
      unexpectedBeforeOfLabel,
      ofLabel: ofLabel,
      unexpectedBetweenOfLabelAndColon,
      colon: colon,
      originalDeclName: originalDeclName,
      period: period,
      accessorKind: accessor,
      comma: comma,
      diffParams: diffParams,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseObjectiveCAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeObjc, objc) = self.expectContextualKeyword("objc")

    let leftParen = self.consume(if: .leftParen)
    let argument: RawObjCSelectorSyntax?
    let unexpectedBeforeRightParen: RawUnexpectedNodesSyntax?
    let rightParen: RawTokenSyntax?
    if leftParen != nil {
      argument = self.parseObjectiveCSelector()
      (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    } else {
      argument = nil
      unexpectedBeforeRightParen = nil
      rightParen = nil
    }

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeObjc,
      attributeName: objc,
      leftParen: leftParen,
      argument: argument.map({ .objCName($0) }),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }

  mutating func parseObjectiveCSelector() -> RawObjCSelectorSyntax {
    var elements = [RawObjCSelectorPieceSyntax]()
    var loopProgress = LoopProgressCondition()
    while loopProgress.evaluate(currentToken) {
      // Empty selector piece.
      if let colon = self.consume(if: .colon) {
        elements.append(
          RawObjCSelectorPieceSyntax(
            name: nil,
            colon: colon,
            arena: self.arena
          )
        )
        continue
      }

      if self.at(any: [.identifier, .wildcardKeyword]) || self.currentToken.isKeyword {
        let name = self.consumeAnyToken()

        // If we hit a ')' we may have a zero-argument selector.
        if self.at(.rightParen) && elements.isEmpty {
          elements.append(
            RawObjCSelectorPieceSyntax(
              name: name,
              colon: nil,
              arena: self.arena
            )
          )
          break
        }

        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        elements.append(
          RawObjCSelectorPieceSyntax(
            name: name,
            unexpectedBeforeColon,
            colon: colon,
            arena: self.arena
          )
        )
      } else {
        break
      }
    }
    return RawObjCSelectorSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  mutating func parseSpecializeAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeSpecialize, specializeToken) = self.expectContextualKeyword("_specialize")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let argument = self.parseSpecializeAttributeSpecList()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeSpecialize,
      attributeName: specializeToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .specializeArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }

  enum SpecializeParameter: SyntaxText, ContextualKeywords {
    case target
    case availability
    case exported
    case kind
    case spi
    case spiModule
    case available
  }
  mutating func parseSpecializeAttributeSpecList() -> RawSpecializeAttributeSpecListSyntax {
    var elements = [RawSpecializeAttributeSpecListSyntax.Element]()
    // Parse optional "exported" and "kind" labeled parameters.
    var loopProgress = LoopProgressCondition()
    while !self.at(any: [.eof, .rightParen, .whereKeyword]) && loopProgress.evaluate(currentToken) {
      switch self.at(anyIn: SpecializeParameter.self) {
      case (.target, let handle)?:
        let ident = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let (targetFunction, args) = self.parseDeclNameRef([.zeroArgCompoundNames, .keywordsUsingSpecialNames, .operators])
        let declName = RawDeclNameSyntax(
          declBaseName: targetFunction,
          declNameArguments: args,
          arena: self.arena
        )
        let comma = self.consume(if: .comma)
        elements.append(
          .targetFunctionEntry(
            RawTargetFunctionEntrySyntax(
              label: ident,
              unexpectedBeforeColon,
              colon: colon,
              declname: declName,
              trailingComma: comma,
              arena: self.arena
            )
          )
        )
      case (.availability, let handle)?:
        let ident = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let availability = self.parseAvailabilitySpecList(from: .available)
        let (unexpectedBeforeSemi, semi) = self.expect(.semicolon)
        elements.append(
          .availabilityEntry(
            RawAvailabilityEntrySyntax(
              label: ident,
              unexpectedBeforeColon,
              colon: colon,
              availabilityList: availability,
              unexpectedBeforeSemi,
              semicolon: semi,
              arena: self.arena
            )
          )
        )
      case (.available, let handle)?:
        let ident = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        // FIXME: I have no idea what this is supposed to be, but the Syntax
        // tree only allows us to insert a token so we'll take anything.
        let available = self.consumeAnyToken()
        let comma = self.consume(if: .comma)
        elements.append(
          .labeledSpecializeEntry(
            RawLabeledSpecializeEntrySyntax(
              label: ident,
              unexpectedBeforeColon,
              colon: colon,
              value: available,
              trailingComma: comma,
              arena: self.arena
            )
          )
        )
      case (.exported, let handle)?:
        let ident = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let (unexpectedBeforeValue, value) = self.expectAny([.trueKeyword, .falseKeyword], default: .falseKeyword)
        let comma = self.consume(if: .comma)
        elements.append(
          .labeledSpecializeEntry(
            RawLabeledSpecializeEntrySyntax(
              label: ident,
              unexpectedBeforeColon,
              colon: colon,
              unexpectedBeforeValue,
              value: value,
              trailingComma: comma,
              arena: self.arena
            )
          )
        )
      case (.kind, let handle)?:
        let ident = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let valueLabel = self.parseAnyIdentifier()
        let comma = self.consume(if: .comma)
        elements.append(
          .labeledSpecializeEntry(
            RawLabeledSpecializeEntrySyntax(
              label: ident,
              unexpectedBeforeColon,
              colon: colon,
              value: valueLabel,
              trailingComma: comma,
              arena: self.arena
            )
          )
        )
      case (.spiModule, let handle)?,
        (.spi, let handle)?:
        let ident = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let valueLabel = self.consumeAnyToken()
        let comma = self.consume(if: .comma)
        elements.append(
          .labeledSpecializeEntry(
            RawLabeledSpecializeEntrySyntax(
              label: ident,
              unexpectedBeforeColon,
              colon: colon,
              value: valueLabel,
              trailingComma: comma,
              arena: self.arena
            )
          )
        )
      case nil:
        let ident = self.consumeAnyToken()
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let valueLabel = self.consumeAnyToken()
        let comma = self.consume(if: .comma)
        elements.append(
          .labeledSpecializeEntry(
            RawLabeledSpecializeEntrySyntax(
              label: ident,
              unexpectedBeforeColon,
              colon: colon,
              value: valueLabel,
              trailingComma: comma,
              arena: self.arena
            )
          )
        )
      }
    }

    // Parse the where clause.
    if self.at(.whereKeyword) {
      let whereClause = self.parseGenericWhereClause()
      elements.append(.genericWhereClause(whereClause))
    }
    return RawSpecializeAttributeSpecListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  mutating func parsePrivateImportAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforePrivateToken, privateToken) = self.expectContextualKeyword("_private")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let (unexpectedBeforeLabel, label) = self.expectIdentifier(keywordRecovery: true)
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let filename = self.consumeAnyToken()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforePrivateToken,
      attributeName: privateToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .namedAttributeString(
        RawNamedAttributeStringArgumentSyntax(
          unexpectedBeforeLabel,
          nameTok: label,
          unexpectedBeforeColon,
          colon: colon,
          stringOrDeclname: .string(filename),
          arena: self.arena
        )
      ),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseDynamicReplacementAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeDynamicReplacementToken, dynamicReplacementToken) = self.expectContextualKeyword("_dynamicReplacement")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let (unexpectedBeforeLabel, label) = self.expect(.forKeyword, remapping: .identifier)
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let base: RawTokenSyntax
    let args: RawDeclNameArgumentsSyntax?
    if label.isMissing && colon.isMissing && self.currentToken.isAtStartOfLine {
      base = RawTokenSyntax(missing: .identifier, arena: self.arena)
      args = nil
    } else {
      (base, args) = self.parseDeclNameRef([
        .zeroArgCompoundNames, .keywordsUsingSpecialNames, .operators,
      ])
    }
    let method = RawDeclNameSyntax(declBaseName: base, declNameArguments: args, arena: self.arena)
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeDynamicReplacementToken,
      attributeName: dynamicReplacementToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .namedAttributeString(
        RawNamedAttributeStringArgumentSyntax(
          unexpectedBeforeLabel,
          nameTok: label,
          unexpectedBeforeColon,
          colon: colon,
          stringOrDeclname: .declname(method),
          arena: self.arena
        )
      ),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: arena
    )
  }
}

extension Parser {
  mutating func parseSPIAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeSpiToken, spiToken) = self.expectContextualKeyword("_spi")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let label = self.consumeAnyToken()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeSpiToken,
      attributeName: spiToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .token(label),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseImplementsAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeSpiToken, spiToken) = self.expectContextualKeyword("_implements")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let label = self.parseImplementsAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeSpiToken,
      attributeName: spiToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .implementsArguments(label),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }

  mutating func parseImplementsAttributeArguments() -> RawImplementsAttributeArgumentsSyntax {
    let type = self.parseTypeIdentifier()
    let (unexpectedBeforeComma, comma) = self.expect(.comma)
    let (name, args) = self.parseDeclNameRef([
      .zeroArgCompoundNames,
      .operators,
    ])
    return RawImplementsAttributeArgumentsSyntax(
      type: type,
      unexpectedBeforeComma,
      comma: comma,
      declBaseName: name,
      declNameArguments: args,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseOpaqueReturnTypeOfAttributeArguments() -> RawOpaqueReturnTypeOfAttributeArgumentsSyntax {
    let (unexpectedBeforeString, mangledName) = self.expect(.stringLiteral)
    let (unexpectedBeforeComma, comma) = self.expect(.comma)
    let (unexpectedBeforeOrdinal, ordinal) = self.expect(.integerLiteral)
    return RawOpaqueReturnTypeOfAttributeArgumentsSyntax(
      unexpectedBeforeString,
      mangledName: mangledName,
      unexpectedBeforeComma,
      comma: comma,
      unexpectedBeforeOrdinal,
      ordinal: ordinal,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseSemanticsAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeSemanticsToken, semanticsToken) = self.expectContextualKeyword("_semantics")
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let label = self.parseStringLiteral()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeSemanticsToken,
      attributeName: semanticsToken,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .stringExpr(label),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      tokenList: nil,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseConventionArguments() -> RawAttributeSyntax.Argument {
    if let witnessMethod = self.consumeIfContextualKeyword("witness_method") {
      let (unexpectedBeforeColon, colon) = self.expect(.colon)
      let name = self.parseAnyIdentifier()
      return .conventionWitnessMethodArguments(
        RawConventionWitnessMethodAttributeArgumentsSyntax(
          witnessMethodLabel: witnessMethod,
          unexpectedBeforeColon,
          colon: colon,
          protocolName: name,
          arena: self.arena
        )
      )
    } else {
      let label = self.consumeAnyToken()
      let unexpectedBeforeComma: RawUnexpectedNodesSyntax?
      let comma: RawTokenSyntax?
      let cTypeLabel: RawTokenSyntax?
      let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
      let colon: RawTokenSyntax?
      let unexpectedBeforeCTypeString: RawUnexpectedNodesSyntax?
      let cTypeString: RawTokenSyntax?
      if self.at(.comma) {
        (unexpectedBeforeComma, comma) = self.expect(.comma)
        cTypeLabel = self.consumeAnyToken()
        (unexpectedBeforeColon, colon) = self.expect(.colon)
        (unexpectedBeforeCTypeString, cTypeString) = self.expect(.stringLiteral)
      } else {
        unexpectedBeforeComma = nil
        comma = nil
        cTypeLabel = nil
        unexpectedBeforeColon = nil
        colon = nil
        unexpectedBeforeCTypeString = nil
        cTypeString = nil
      }
      return .conventionArguments(
        RawConventionAttributeArgumentsSyntax(
          conventionLabel: label,
          unexpectedBeforeComma,
          comma: comma,
          cTypeLabel: cTypeLabel,
          unexpectedBeforeColon,
          colon: colon,
          unexpectedBeforeCTypeString,
          cTypeString: cTypeString,
          arena: self.arena
        )
      )
    }
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  func isCustomAttributeArgument() -> Bool {
    var lookahead = self.lookahead()
    lookahead.skipSingle()

    // If we have any keyword, identifier, or token that follows a function
    // type's parameter list, this is a parameter list and not an attribute.
    // Alternatively, we might have a token that illustrates we're not going to
    // get anything following the attribute, which means the parentheses describe
    // what follows the attribute.
    switch lookahead.currentToken.tokenKind {
    case .arrow,
      .throwKeyword,
      .throwsKeyword,
      .rethrowsKeyword,
      .rightParen,
      .rightBrace,
      .rightSquareBracket,
      .rightAngle:
      return false
    case _ where lookahead.atContextualKeyword("async"):
      return false
    case _ where lookahead.atContextualKeyword("reasync"):
      return false
    default:
      return true
    }
  }

  mutating func canParseCustomAttribute() -> Bool {
    guard self.canParseType() else {
      return false
    }

    if self.at(.leftParen, where: { !$0.isAtStartOfLine }) && self.lookahead().isCustomAttributeArgument() {
      self.skipSingle()
    }

    return true
  }
}
