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
  /// Compiler-known attributes that take arguments.
  enum DeclarationAttributeWithSpecialSyntax: RawTokenKindSubset {
    case _alignment
    case _backDeploy
    case _cdecl
    case _documentation
    case _dynamicReplacement
    case _effects
    case _expose
    case _implements
    case _nonSendable
    case _objcImplementation
    case _objcRuntimeName
    case _optimize
    case _originallyDefinedIn
    case _private
    case _projectedValueProperty
    case _semantics
    case _silgen_name
    case _specialize
    case _spi
    case _spi_available
    case _swift_native_objc_runtime_base
    case _typeEraser
    case _unavailableFromAsync
    case `rethrows`
    case available
    case derivative
    case differentiable
    case exclusivity
    case inline
    case objc
    case transpose

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(._alignment): self = ._alignment
      case RawTokenKindMatch(._backDeploy): self = ._backDeploy
      case RawTokenKindMatch(._cdecl): self = ._cdecl
      case RawTokenKindMatch(._documentation): self = ._documentation
      case RawTokenKindMatch(._dynamicReplacement): self = ._dynamicReplacement
      case RawTokenKindMatch(._effects): self = ._effects
      case RawTokenKindMatch(._expose): self = ._expose
      case RawTokenKindMatch(._implements): self = ._implements
      case RawTokenKindMatch(._nonSendable): self = ._nonSendable
      case RawTokenKindMatch(._objcImplementation): self = ._objcImplementation
      case RawTokenKindMatch(._objcRuntimeName): self = ._objcRuntimeName
      case RawTokenKindMatch(._optimize): self = ._optimize
      case RawTokenKindMatch(._originallyDefinedIn): self = ._originallyDefinedIn
      case RawTokenKindMatch(._private): self = ._private
      case RawTokenKindMatch(._projectedValueProperty): self = ._projectedValueProperty
      case RawTokenKindMatch(._semantics): self = ._semantics
      case RawTokenKindMatch(._silgen_name): self = ._silgen_name
      case RawTokenKindMatch(._specialize): self = ._specialize
      case RawTokenKindMatch(._spi): self = ._spi
      case RawTokenKindMatch(._spi_available): self = ._spi_available
      case RawTokenKindMatch(._swift_native_objc_runtime_base): self = ._swift_native_objc_runtime_base
      case RawTokenKindMatch(._typeEraser): self = ._typeEraser
      case RawTokenKindMatch(._unavailableFromAsync): self = ._unavailableFromAsync
      case RawTokenKindMatch(.`rethrows`): self = .rethrows
      case RawTokenKindMatch(.available): self = .available
      case RawTokenKindMatch(.derivative): self = .derivative
      case RawTokenKindMatch(.differentiable): self = .differentiable
      case RawTokenKindMatch(.exclusivity): self = .exclusivity
      case RawTokenKindMatch(.inline): self = .inline
      case RawTokenKindMatch(.objc): self = .objc
      case RawTokenKindMatch(.transpose): self = .transpose
      default:
        return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case ._alignment: return .keyword(._alignment)
      case ._backDeploy: return .keyword(._backDeploy)
      case ._cdecl: return .keyword(._cdecl)
      case ._documentation: return .keyword(._documentation)
      case ._dynamicReplacement: return .keyword(._dynamicReplacement)
      case ._effects: return .keyword(._effects)
      case ._expose: return .keyword(._expose)
      case ._implements: return .keyword(._implements)
      case ._nonSendable: return .keyword(._nonSendable)
      case ._objcImplementation: return .keyword(._objcImplementation)
      case ._objcRuntimeName: return .keyword(._objcRuntimeName)
      case ._optimize: return .keyword(._optimize)
      case ._originallyDefinedIn: return .keyword(._originallyDefinedIn)
      case ._private: return .keyword(._private)
      case ._projectedValueProperty: return .keyword(._projectedValueProperty)
      case ._semantics: return .keyword(._semantics)
      case ._silgen_name: return .keyword(._silgen_name)
      case ._specialize: return .keyword(._specialize)
      case ._spi: return .keyword(._spi)
      case ._spi_available: return .keyword(._spi_available)
      case ._swift_native_objc_runtime_base: return .keyword(._swift_native_objc_runtime_base)
      case ._typeEraser: return .keyword(._typeEraser)
      case ._unavailableFromAsync: return .keyword(._unavailableFromAsync)
      case .`rethrows`: return .keyword(.rethrows)
      case .available: return .keyword(.available)
      case .derivative: return .keyword(.derivative)
      case .differentiable: return .keyword(.differentiable)
      case .exclusivity: return .keyword(.exclusivity)
      case .inline: return .keyword(.inline)
      case .objc: return .keyword(.objc)
      case .transpose: return .keyword(.transpose)
      }
    }
  }
}

extension Parser {
  mutating func parseAttributeWithoutArguments() -> RawAttributeListSyntax.Element {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let attributeName = self.parseType()
    return .attribute(
      RawAttributeSyntax(
        unexpectedBeforeAtSign,
        atSignToken: atSign,
        attributeName: attributeName,
        leftParen: nil,
        argument: nil,
        rightParen: nil,
        arena: self.arena
      )
    )
  }

  enum AttributeArgumentMode {
    case required
    case customAttribute
    case optional
  }

  mutating func parseAttribute(argumentMode: AttributeArgumentMode, parseArguments: (inout Parser) -> RawAttributeSyntax.Argument) -> RawAttributeListSyntax.Element {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let attributeName = self.parseType()
    let shouldParseArgument: Bool
    switch argumentMode {
    case .required:
      shouldParseArgument = true
    case .customAttribute:
      shouldParseArgument = self.lookahead().isCustomAttributeArgument() && self.at(.leftParen, allowTokenAtStartOfLine: false)
    case .optional:
      shouldParseArgument = self.at(.leftParen)
    }
    if shouldParseArgument {
      let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
      let argument = parseArguments(&self)
      let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
      return .attribute(
        RawAttributeSyntax(
          unexpectedBeforeAtSign,
          atSignToken: atSign,
          attributeName: attributeName,
          unexpectedBeforeLeftParen,
          leftParen: leftParen,
          argument: argument,
          unexpectedBeforeRightParen,
          rightParen: rightParen,
          arena: self.arena
        )
      )
    } else {
      return .attribute(
        RawAttributeSyntax(
          unexpectedBeforeAtSign,
          atSignToken: atSign,
          attributeName: attributeName,
          leftParen: nil,
          argument: nil,
          rightParen: nil,
          arena: self.arena
        )
      )
    }
  }

  mutating func parseAttribute() -> RawAttributeListSyntax.Element {
    if self.at(.poundIfKeyword) {
      return .ifConfigDecl(
        self.parsePoundIfDirective { parser -> RawAttributeListSyntax.Element in
          return parser.parseAttribute()
        } syntax: { parser, attributes in
          return .attributes(RawAttributeListSyntax(elements: attributes, arena: parser.arena))
        }
      )
    }

    switch DeclarationAttributeWithSpecialSyntax(lexeme: self.peek()) {
    case .available, ._spi_available:
      return parseAttribute(argumentMode: .required) { parser in
        return .availability(parser.parseAvailabilityArgumentSpecList())
      }
    case .differentiable:
      return parseAttribute(argumentMode: .required) { parser in
        return .differentiableArguments(parser.parseDifferentiableAttributeArguments())
      }
    case .derivative, .transpose:
      return parseAttribute(argumentMode: .required) { parser in
        return .derivativeRegistrationArguments(parser.parseDerivativeAttributeArguments())
      }
    case .objc:
      return parseAttribute(argumentMode: .optional) { parser in
        return .objCName(parser.parseObjectiveCSelector())
      }
    case ._specialize:
      return parseAttribute(argumentMode: .required) { parser in
        return .specializeArguments(parser.parseSpecializeAttributeSpecList())
      }
    case ._private:
      return parseAttribute(argumentMode: .required) { parser in
        return .underscorePrivateAttributeArguments(parser.parseUnderscorePrivateAttributeArguments())
      }
    case ._dynamicReplacement:
      return parseAttribute(argumentMode: .required) { parser in
        return .dynamicReplacementArguments(parser.parseDynamicReplacementArguments())
      }
    case ._documentation:
      return parseAttribute(argumentMode: .required) { parser in
        return .documentationArguments(parser.parseDocumentationAttributeArguments())
      }
    case ._spi, ._objcRuntimeName, ._projectedValueProperty, ._swift_native_objc_runtime_base, ._typeEraser, ._optimize, .exclusivity, .inline, ._alignment:
      // Attributes that take a single token as argument. Some examples of these include:
      //  - Arbitrary identifiers (e.g. `@_spi(RawSyntax)`)
      //  - An integer literal (e.g. `@_alignment(4)`)
      //
      //  Because there seem to be very little restrictions on these parameters (they could be keywords instead of identifiers), we just allow any token.
      return parseAttribute(argumentMode: .required) { parser in
        if !parser.at(.rightParen) {
          return .token(parser.consumeAnyToken())
        } else {
          return .token(parser.missingToken(.identifier))
        }
      }
    case ._objcImplementation, ._nonSendable:
      // Similar to the above but the argument is optional
      return parseAttribute(argumentMode: .optional) { parser in
        if !parser.at(.rightParen) {
          return .token(parser.consumeAnyToken())
        } else {
          return .token(parser.missingToken(.identifier))
        }
      }
    case ._effects:
      return parseAttribute(argumentMode: .required) { parser in
        // The contents of the @_effects attribute are parsed in SIL, we just
        // represent the contents as a list of tokens in SwiftSyntax.
        var tokens: [RawTokenSyntax] = []
        while !parser.at(any: [.rightParen, .eof]) {
          tokens.append(parser.consumeAnyToken())
        }
        return .effectsArguments(RawEffectsArgumentsSyntax(elements: tokens, arena: parser.arena))
      }
    case ._cdecl, ._silgen_name:
      return parseAttribute(argumentMode: .required) { parser in
        return .string(parser.parseStringLiteral())
      }
    case ._implements:
      return parseAttribute(argumentMode: .required) { parser in
        return .implementsArguments(parser.parseImplementsAttributeArguments())
      }
    case ._semantics:
      return parseAttribute(argumentMode: .required) { parser in
        return .string(parser.parseStringLiteral())
      }
    case ._backDeploy:
      return parseAttribute(argumentMode: .required) { parser in
        return .backDeployArguments(parser.parseBackDeployArguments())
      }
    case ._expose:
      return parseAttribute(argumentMode: .required) { parser in
        return .exposeAttributeArguments(parser.parseExposeArguments())
      }
    case ._originallyDefinedIn:
      return parseAttribute(argumentMode: .required) { parser in
        return .originallyDefinedInArguments(parser.parseOriginallyDefinedInArguments())
      }
    case ._unavailableFromAsync:
      return parseAttribute(argumentMode: .optional) { parser in
        return .unavailableFromAsyncArguments(parser.parseUnavailableFromAsyncArguments())
      }
    case .rethrows:
      let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
      let (unexpectedBeforeAttributeName, attributeName) = self.expect(.keyword(.rethrows), remapping: .identifier)
      return .attribute(
        RawAttributeSyntax(
          unexpectedBeforeAtSign,
          atSignToken: atSign,
          unexpectedBeforeAttributeName,
          attributeName: RawTypeSyntax(RawSimpleTypeIdentifierSyntax(name: attributeName, genericArgumentClause: nil, arena: self.arena)),
          leftParen: nil,
          argument: nil,
          rightParen: nil,
          arena: self.arena
        )
      )
    case nil:
      return parseAttribute(argumentMode: .customAttribute) { parser in
        let arguments = parser.parseArgumentListElements(pattern: .none)
        return .argumentList(RawTupleExprElementListSyntax(elements: arguments, arena: parser.arena))
      }
    }
  }
}

extension Parser {
  mutating func parseDifferentiableAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeDifferentiable, differentiable) = self.expect(.keyword(.differentiable))
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let argument = self.parseDifferentiableAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeDifferentiable,
      attributeName: RawTypeSyntax(RawSimpleTypeIdentifierSyntax(name: differentiable, genericArgumentClause: nil, arena: self.arena)),
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .differentiableArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  enum DifferentiabilityKind: RawTokenKindSubset {
    case reverse
    case linear
    case forward

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.reverse): self = .reverse
      case RawTokenKindMatch(._linear): self = .linear
      case RawTokenKindMatch(._forward): self = .forward
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .reverse: return .keyword(.reverse)
      case .linear: return .keyword(._linear)
      case .forward: return .keyword(._forward)
      }
    }
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
    if self.at(.keyword(.wrt)) {
      diffParams = self.parseDifferentiabilityParameters()
      diffParamsComma = self.consume(if: .comma)
    } else {
      diffParams = nil
      diffParamsComma = nil
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
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
        switch lexeme {
        case RawTokenKindMatch(.identifier): self = .identifier
        case RawTokenKindMatch(.integerLiteral): self = .integerLiteral
        case RawTokenKindMatch(.self): self = .selfKeyword
        default: return nil
        }
      }

      var rawTokenKind: RawTokenKind {
        switch self {
        case .identifier: return .identifier
        case .integerLiteral: return .integerLiteral
        case .selfKeyword: return .keyword(.self)
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
    let (unexpectedBeforeDerivative, derivative) = self.expect(.keyword(.derivative))

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let argument = self.parseDerivativeAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeDerivative,
      attributeName: RawTypeSyntax(RawSimpleTypeIdentifierSyntax(name: derivative, genericArgumentClause: nil, arena: self.arena)),
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .derivativeRegistrationArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseTransposeAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeTranspose, transpose) = self.expect(.keyword(.transpose))

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let argument = self.parseDerivativeAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSignToken: atSign,
      unexpectedBeforeTranspose,
      attributeName: RawTypeSyntax(RawSimpleTypeIdentifierSyntax(name: transpose, genericArgumentClause: nil, arena: self.arena)),
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      argument: .derivativeRegistrationArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseDerivativeAttributeArguments() -> RawDerivativeRegistrationAttributeArgumentsSyntax {
    let (unexpectedBeforeOfLabel, ofLabel) = self.expect(.keyword(.of))
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
  mutating func parseObjectiveCSelector() -> RawObjCSelectorSyntax {
    var elements = [RawObjCSelectorPieceSyntax]()
    var loopProgress = LoopProgressCondition()
    while !self.at(any: [.eof, .rightParen]) && loopProgress.evaluate(currentToken) {
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

      if self.at(.identifier) || self.currentToken.isLexerClassifiedKeyword {
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
      }
    }
    return RawObjCSelectorSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  enum SpecializeParameter: RawTokenKindSubset {
    case target
    case availability
    case exported
    case kind
    case spi
    case spiModule
    case available

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.target): self = .target
      case RawTokenKindMatch(.availability): self = .availability
      case RawTokenKindMatch(.exported): self = .exported
      case RawTokenKindMatch(.kind): self = .kind
      case RawTokenKindMatch(.spi): self = .spi
      case RawTokenKindMatch(.spiModule): self = .spiModule
      case RawTokenKindMatch(.available): self = .available
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .target: return .keyword(.target)
      case .availability: return .keyword(.availability)
      case .exported: return .keyword(.exported)
      case .kind: return .keyword(.kind)
      case .spi: return .keyword(.spi)
      case .spiModule: return .keyword(.spiModule)
      case .available: return .keyword(.available)
      }
    }
  }
  mutating func parseSpecializeAttributeSpecList() -> RawSpecializeAttributeSpecListSyntax {
    var elements = [RawSpecializeAttributeSpecListSyntax.Element]()
    // Parse optional "exported" and "kind" labeled parameters.
    var loopProgress = LoopProgressCondition()
    while !self.at(any: [.eof, .rightParen, .keyword(.where)]) && loopProgress.evaluate(currentToken) {
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
        let availability = self.parseAvailabilitySpecList()
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
        let (unexpectedBeforeValue, value) = self.expectAny([.keyword(.true), .keyword(.false)], default: .keyword(.false))
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
    if self.at(.keyword(.where)) {
      let whereClause = self.parseGenericWhereClause()
      elements.append(.genericWhereClause(whereClause))
    }
    return RawSpecializeAttributeSpecListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  mutating func parseImplementsAttributeArguments() -> RawImplementsAttributeArgumentsSyntax {
    let type = self.parseType()
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
    let mangledName = self.parseStringLiteral()
    let (unexpectedBeforeComma, comma) = self.expect(.comma)
    let (unexpectedBeforeOrdinal, ordinal) = self.expect(.integerLiteral)
    return RawOpaqueReturnTypeOfAttributeArgumentsSyntax(
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
  mutating func parseConventionArguments() -> RawAttributeSyntax.Argument {
    if let witnessMethod = self.consume(if: .keyword(.witness_method)) {
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
      let cTypeString: RawStringLiteralExprSyntax?
      if self.at(.comma) {
        (unexpectedBeforeComma, comma) = self.expect(.comma)
        cTypeLabel = self.consumeAnyToken()
        (unexpectedBeforeColon, colon) = self.expect(.colon)
        cTypeString = self.parseStringLiteral()
      } else {
        unexpectedBeforeComma = nil
        comma = nil
        cTypeLabel = nil
        unexpectedBeforeColon = nil
        colon = nil
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
          cTypeString: cTypeString,
          arena: self.arena
        )
      )
    }
  }
}

extension Parser {
  mutating func parseBackDeployArguments() -> RawBackDeployAttributeSpecListSyntax {
    let (unexpectedBeforeLabel, label) = self.expect(.keyword(.before), remapping: .identifier)
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    var elements: [RawAvailabilityVersionRestrictionListEntrySyntax] = []
    var keepGoing: RawTokenSyntax? = nil
    repeat {
      let versionRestriction = self.parseAvailabilityMacro()
      keepGoing = self.consume(if: .comma)
      elements.append(
        RawAvailabilityVersionRestrictionListEntrySyntax(
          availabilityVersionRestriction: versionRestriction,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil
    return RawBackDeployAttributeSpecListSyntax(
      unexpectedBeforeLabel,
      beforeLabel: label,
      unexpectedBeforeColon,
      colon: colon,
      versionList: RawAvailabilityVersionRestrictionListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseExposeArguments() -> RawExposeAttributeArgumentsSyntax {
    let language: RawTokenSyntax
    if !self.at(any: [.rightParen, .comma]) {
      language = self.consumeAnyToken()
    } else {
      language = missingToken(.identifier)
    }
    let unexpectedBeforeComma: RawUnexpectedNodesSyntax?
    let comma: RawTokenSyntax?
    let cxxName: RawStringLiteralExprSyntax?
    if self.at(.comma) {
      (unexpectedBeforeComma, comma) = self.expect(.comma)
      cxxName = self.parseStringLiteral()
    } else {
      unexpectedBeforeComma = nil
      comma = nil
      cxxName = nil
    }
    return RawExposeAttributeArgumentsSyntax(
      language: language,
      unexpectedBeforeComma,
      comma: comma,
      cxxName: cxxName,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseOriginallyDefinedInArguments() -> RawOriginallyDefinedInArgumentsSyntax {
    let (unexpectedBeforeModuleLabel, moduleLabel) = self.expect(.keyword(.module), remapping: .identifier)
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let moduleName = self.parseStringLiteral()
    let (unexpectedBeforeComma, comma) = self.expect(.comma)

    var platforms: [RawAvailabilityVersionRestrictionListEntrySyntax] = []
    var keepGoing: RawTokenSyntax?
    repeat {
      let restriction = self.parseAvailabilityMacro(allowStarAsVersionNumber: true)
      keepGoing = self.consume(if: .comma)
      platforms.append(
        RawAvailabilityVersionRestrictionListEntrySyntax(
          availabilityVersionRestriction: restriction,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil

    return RawOriginallyDefinedInArgumentsSyntax(
      unexpectedBeforeModuleLabel,
      moduleLabel: moduleLabel,
      unexpectedBeforeColon,
      colon: colon,
      moduleName: moduleName,
      unexpectedBeforeComma,
      comma: comma,
      platforms: RawAvailabilityVersionRestrictionListSyntax(elements: platforms, arena: self.arena),
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseUnderscorePrivateAttributeArguments() -> RawUnderscorePrivateAttributeArgumentsSyntax {
    let (unexpectedBeforeLabel, label) = self.expect(.keyword(.sourceFile), remapping: .identifier)
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let filename = self.parseStringLiteral()
    return RawUnderscorePrivateAttributeArgumentsSyntax(
      unexpectedBeforeLabel,
      sourceFileLabel: label,
      unexpectedBeforeColon,
      colon: colon,
      filename: filename,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseDynamicReplacementArguments() -> RawDynamicReplacementArgumentsSyntax {
    let (unexpectedBeforeLabel, label) = self.expect(.keyword(.for), remapping: .identifier)
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
    return RawDynamicReplacementArgumentsSyntax(
      unexpectedBeforeLabel,
      forLabel: label,
      unexpectedBeforeColon,
      colon: colon,
      declname: method,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseUnavailableFromAsyncArguments() -> RawUnavailableFromAsyncArgumentsSyntax {
    let (unexpectedBeforeLabel, label) = self.expect(.keyword(.message), remapping: .identifier)
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let message = self.parseStringLiteral()
    return RawUnavailableFromAsyncArgumentsSyntax(
      unexpectedBeforeLabel,
      messageLabel: label,
      unexpectedBeforeColon,
      colon: colon,
      message: message,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseDocumentationAttributeArguments() -> RawDocumentationAttributeArgumentsSyntax {
    var arguments: [RawDocumentationAttributeArgumentSyntax] = []

    var keepGoing: RawTokenSyntax? = nil
    repeat {
      let (unexpectedBeforeLabel, label) = self.expectAny([.keyword(.visibility), .keyword(.metadata)], default: .keyword(.visibility))
      let (unexpectedBeforeColon, colon) = self.expect(.colon)
      let unexpectedBeforeValue: RawUnexpectedNodesSyntax?
      let value: RawDocumentationAttributeArgumentSyntax.Value
      switch label.tokenText {
      case "visibility":
        let (unexpected, token) = self.expectAny([.keyword(.open), .keyword(.public), .keyword(.internal), .keyword(.fileprivate), .keyword(.private)], default: .keyword(.internal))
        unexpectedBeforeValue = unexpected
        value = .token(token)
      case "metadata":
        unexpectedBeforeValue = nil
        if let identifier = self.consume(if: .identifier) {
          value = .token(identifier)
        } else {
          value = .string(self.parseStringLiteral())
        }
      default:
        unexpectedBeforeValue = nil
        value = .token(missingToken(.identifier))
      }
      keepGoing = self.consume(if: .comma)
      arguments.append(
        RawDocumentationAttributeArgumentSyntax(
          unexpectedBeforeLabel,
          label: label,
          unexpectedBeforeColon,
          colon: colon,
          unexpectedBeforeValue,
          value: value,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil

    return RawDocumentationAttributeArgumentsSyntax(elements: arguments, arena: self.arena)
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
    switch lookahead.currentToken.rawTokenKind {
    case .arrow,
      .keyword(.throw),
      .keyword(.throws),
      .keyword(.rethrows),
      .rightParen,
      .rightBrace,
      .rightSquareBracket,
      .rightAngle:
      return false
    case _ where lookahead.at(.keyword(.async)):
      return false
    case _ where lookahead.at(.keyword(.reasync)):
      return false
    default:
      return true
    }
  }

  mutating func canParseCustomAttribute() -> Bool {
    guard self.canParseType() else {
      return false
    }

    if self.at(.leftParen, allowTokenAtStartOfLine: false) && self.lookahead().isCustomAttributeArgument() {
      self.skipSingle()
    }

    return true
  }
}
