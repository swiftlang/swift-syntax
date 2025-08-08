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
  mutating func parseAttributeList() -> RawAttributeListSyntax {
    guard self.at(.atSign, .poundIf) else {
      return self.emptyCollection(RawAttributeListSyntax.self)
    }

    var elements = [RawAttributeListSyntax.Element]()
    var loopProgress = LoopProgressCondition()
    repeat {
      let attribute = self.parseAttribute()
      elements.append(attribute)
    } while self.at(.atSign, .poundIf) && self.hasProgressed(&loopProgress)
    return RawAttributeListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  /// Compiler-known attributes that take arguments.
  enum DeclarationAttributeWithSpecialSyntax: TokenSpecSet {
    case _backDeploy
    case _documentation
    case _dynamicReplacement
    case _effects
    case _implements
    case _originallyDefinedIn
    case specialized
    case _specialize
    case _spi_available
    case `rethrows`
    case abi
    case attached
    case available
    case backDeployed
    case derivative
    case differentiable
    case freestanding
    case objc
    case Sendable
    case transpose

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(._backDeploy): self = ._backDeploy
      case TokenSpec(._documentation): self = ._documentation
      case TokenSpec(._dynamicReplacement): self = ._dynamicReplacement
      case TokenSpec(._effects): self = ._effects
      case TokenSpec(._implements): self = ._implements
      case TokenSpec(._originallyDefinedIn): self = ._originallyDefinedIn
      case TokenSpec(.specialized): self = .specialized
      case TokenSpec(._specialize): self = ._specialize
      case TokenSpec(._spi_available): self = ._spi_available
      case TokenSpec(.`rethrows`): self = .rethrows
      case TokenSpec(.abi): self = .abi
      case TokenSpec(.attached): self = .attached
      case TokenSpec(.available): self = .available
      case TokenSpec(.backDeployed): self = .backDeployed
      case TokenSpec(.derivative): self = .derivative
      case TokenSpec(.differentiable): self = .differentiable
      case TokenSpec(.freestanding): self = .freestanding
      case TokenSpec(.objc): self = .objc
      case TokenSpec(.Sendable): self = .Sendable
      case TokenSpec(.transpose): self = .transpose
      default:
        return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case ._backDeploy: return .keyword(._backDeploy)
      case ._documentation: return .keyword(._documentation)
      case ._dynamicReplacement: return .keyword(._dynamicReplacement)
      case ._effects: return .keyword(._effects)
      case ._implements: return .keyword(._implements)
      case ._originallyDefinedIn: return .keyword(._originallyDefinedIn)
      case .specialized: return .keyword(.specialized)
      case ._specialize: return .keyword(._specialize)
      case ._spi_available: return .keyword(._spi_available)
      case .`rethrows`: return .keyword(.rethrows)
      case .abi: return .keyword(.abi)
      case .attached: return .keyword(.attached)
      case .available: return .keyword(.available)
      case .backDeployed: return .keyword(.backDeployed)
      case .derivative: return .keyword(.derivative)
      case .differentiable: return .keyword(.differentiable)
      case .freestanding: return .keyword(.freestanding)
      case .objc: return .keyword(.objc)
      case .Sendable: return .keyword(.Sendable)
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
        atSign: atSign,
        attributeName: attributeName,
        leftParen: nil,
        arguments: nil,
        rightParen: nil,
        arena: self.arena
      )
    )
  }

  enum AttributeArgumentMode {
    case required
    case customAttribute
    case optional
    case noArgument
  }

  /// Parse the argument of an attribute, if it has one.
  ///
  /// - Parameters:
  ///   - argumentMode: Indicates whether the attribute must, may, or may not have an argument.
  ///   - parseArguments: Called to parse the argument list. If there is an opening parenthesis, it will have already been consumed.
  ///   - parseMissingArguments: If provided, called instead of `parseArgument` when an argument list was required but no opening parenthesis was present.
  mutating func parseAttribute(
    argumentMode: AttributeArgumentMode,
    parseArguments: (inout Parser) -> (
      unexpectedBefore: RawUnexpectedNodesSyntax?, arguments: RawAttributeSyntax.Arguments
    ),
    parseMissingArguments: (
      (inout Parser) -> (unexpectedBefore: RawUnexpectedNodesSyntax?, arguments: RawAttributeSyntax.Arguments)
    )? = nil
  ) -> RawAttributeListSyntax.Element {
    var (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    if atSign.trailingTriviaByteLength > 0 || self.currentToken.leadingTriviaByteLength > 0 {
      let diagnostic = TokenDiagnostic(
        self.swiftVersion < .v6 ? .extraneousTrailingWhitespaceWarning : .extraneousTrailingWhitespaceError,
        byteOffset: atSign.leadingTriviaByteLength + atSign.tokenText.count
      )
      atSign = atSign.tokenView.withTokenDiagnostic(tokenDiagnostic: diagnostic, arena: self.arena)
    }
    let attributeName = self.parseAttributeName()
    let shouldParseArgument: Bool
    switch argumentMode {
    case .required:
      shouldParseArgument = true
    case .customAttribute:
      shouldParseArgument =
        self.withLookahead { $0.atAttributeOrSpecifierArgument() }
        && self.at(TokenSpec(.leftParen, allowAtStartOfLine: false))
    case .optional:
      shouldParseArgument = self.at(TokenSpec(.leftParen, allowAtStartOfLine: false))
    case .noArgument:
      shouldParseArgument = false
    }
    if shouldParseArgument {
      var (unexpectedBeforeLeftParen, leftParen) = self.expect(TokenSpec(.leftParen, allowAtStartOfLine: false))
      if unexpectedBeforeLeftParen == nil
        && (attributeName.raw.trailingTriviaByteLength > 0 || leftParen.leadingTriviaByteLength > 0)
      {
        let diagnostic = TokenDiagnostic(
          self.swiftVersion < .v6 ? .extraneousLeadingWhitespaceWarning : .extraneousLeadingWhitespaceError,
          byteOffset: 0
        )
        leftParen = leftParen.tokenView.withTokenDiagnostic(tokenDiagnostic: diagnostic, arena: self.arena)
      }
      let unexpectedBeforeArguments: RawUnexpectedNodesSyntax?
      let argument: RawAttributeSyntax.Arguments
      if let parseMissingArguments, leftParen.presence == .missing {
        (unexpectedBeforeArguments, argument) = parseMissingArguments(&self)
      } else {
        (unexpectedBeforeArguments, argument) = parseArguments(&self)
      }
      let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
      return .attribute(
        RawAttributeSyntax(
          unexpectedBeforeAtSign,
          atSign: atSign,
          attributeName: attributeName,
          unexpectedBeforeLeftParen,
          leftParen: leftParen,
          unexpectedBeforeArguments,
          arguments: argument,
          unexpectedBeforeRightParen,
          rightParen: rightParen,
          arena: self.arena
        )
      )
    } else {
      return .attribute(
        RawAttributeSyntax(
          unexpectedBeforeAtSign,
          atSign: atSign,
          attributeName: attributeName,
          leftParen: nil,
          arguments: nil,
          rightParen: nil,
          arena: self.arena
        )
      )
    }
  }

  mutating func parseAttribute() -> RawAttributeListSyntax.Element {
    if self.at(.poundIf) {
      return .ifConfigDecl(
        self.parsePoundIfDirective { (parser, _) -> RawAttributeListSyntax.Element in
          return parser.parseAttribute()
        } syntax: { parser, attributes in
          return .attributes(RawAttributeListSyntax(elements: attributes, arena: parser.arena))
        }
      )
    }

    switch peek(isAtAnyIn: DeclarationAttributeWithSpecialSyntax.self) {
    case .abi:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .abiArguments(parser.parseABIAttributeArguments()))
      } parseMissingArguments: { parser in
        return (nil, .abiArguments(parser.parseABIAttributeArguments(missingLParen: true)))
      }
    case .available, ._spi_available:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .availability(parser.parseAvailabilityArgumentSpecList()))
      }
    case .backDeployed, ._backDeploy:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .backDeployedArguments(parser.parseBackDeployedAttributeArguments()))
      }
    case .differentiable:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .differentiableArguments(parser.parseDifferentiableAttributeArguments()))
      }
    case .derivative, .transpose:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .derivativeRegistrationArguments(parser.parseDerivativeAttributeArguments()))
      }
    case .objc:
      return parseAttribute(argumentMode: .optional) { parser in
        return (nil, .objCName(parser.parseObjectiveCSelector()))
      }
    case .specialized:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .specializedArguments(parser.parseSpecializedAttributeArgument()))
      }
    case ._specialize:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .specializeArguments(parser.parseSpecializeAttributeArgumentList()))
      }
    case ._dynamicReplacement:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .dynamicReplacementArguments(parser.parseDynamicReplacementAttributeArguments()))
      }
    case ._documentation:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .documentationArguments(parser.parseDocumentationAttributeArguments()))
      }
    case ._effects:
      return parseAttribute(argumentMode: .required) { parser in
        // The contents of the @_effects attribute are parsed in SIL, we just
        // represent the contents as a list of tokens in SwiftSyntax.
        var tokens: [RawTokenSyntax] = []
        while !parser.at(.rightParen, .endOfFile) {
          tokens.append(parser.consumeAnyToken())
        }
        return (nil, .effectsArguments(RawEffectsAttributeArgumentListSyntax(elements: tokens, arena: parser.arena)))
      }
    case ._implements:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .implementsArguments(parser.parseImplementsAttributeArguments()))
      }
    case ._originallyDefinedIn:
      return parseAttribute(argumentMode: .required) { parser in
        return (nil, .originallyDefinedInArguments(parser.parseOriginallyDefinedInAttributeArguments()))
      }
    case .attached, .freestanding:
      return parseAttribute(argumentMode: .customAttribute) { parser in
        let arguments = parser.parseMacroRoleArguments()
        return (nil, .argumentList(RawLabeledExprListSyntax(elements: arguments, arena: parser.arena)))
      }
    case .rethrows:
      let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
      let (unexpectedBeforeAttributeName, attributeName) = self.expect(TokenSpec(.rethrows, remapping: .identifier))
      return .attribute(
        RawAttributeSyntax(
          unexpectedBeforeAtSign,
          atSign: atSign,
          unexpectedBeforeAttributeName,
          attributeName: RawIdentifierTypeSyntax(name: attributeName, genericArgumentClause: nil, arena: self.arena),
          leftParen: nil,
          arguments: nil,
          rightParen: nil,
          arena: self.arena
        )
      )
    case .Sendable:
      return parseAttribute(argumentMode: .noArgument) { parser in
        preconditionFailure("Sendable has no argument")
      }
    case nil:
      return parseAttribute(argumentMode: .customAttribute) { parser in
        let arguments = parser.parseArgumentListElements(
          pattern: .none,
          allowTrailingComma: true
        )
        return (nil, .argumentList(RawLabeledExprListSyntax(elements: arguments, arena: parser.arena)))
      }
    }
  }
}

extension RawLabeledExprSyntax {
  fileprivate init(
    _ unexpectedBeforeIdentifier: RawUnexpectedNodesSyntax? = nil,
    identifier: RawTokenSyntax,
    _ unexpectedBetweenIdentifierAndTrailingComma: RawUnexpectedNodesSyntax? = nil,
    trailingComma: RawTokenSyntax? = nil,
    arena: __shared RawSyntaxArena
  ) {
    self.init(
      label: nil,
      colon: nil,
      expression: RawDeclReferenceExprSyntax(
        unexpectedBeforeIdentifier,
        baseName: identifier,
        argumentNames: nil,
        arena: arena
      ),
      unexpectedBetweenIdentifierAndTrailingComma,
      trailingComma: trailingComma,
      arena: arena
    )
  }
}

extension Parser {
  mutating func parseMacroRoleArguments() -> [RawLabeledExprSyntax] {
    let (unexpectedBeforeRole, role) = self.expect(
      .identifier,
      TokenSpec(.extension, remapping: .identifier),
      default: .identifier
    )
    let roleTrailingComma = self.consume(if: .comma)

    let roleElement = RawLabeledExprSyntax(
      unexpectedBeforeRole,
      identifier: role,
      trailingComma: roleTrailingComma,
      arena: self.arena
    )
    let additionalArgs = self.parseArgumentListElements(
      pattern: .none,
      flavor: .attributeArguments,
      allowTrailingComma: false
    )
    return [roleElement] + additionalArgs
  }
}

extension Parser {
  mutating func parseDifferentiableAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeDifferentiable, differentiable) = self.expect(
      TokenSpec(.differentiable, remapping: .identifier)
    )
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let argument = self.parseDifferentiableAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSign: atSign,
      unexpectedBeforeDifferentiable,
      attributeName: RawIdentifierTypeSyntax(name: differentiable, genericArgumentClause: nil, arena: self.arena),
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      arguments: .differentiableArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseDifferentiableAttributeArguments() -> RawDifferentiableAttributeArgumentsSyntax {
    let kindSpecifier: RawTokenSyntax?
    let kindSpecifierComma: RawTokenSyntax?
    if let (_, handle) = self.at(anyIn: DifferentiableAttributeArgumentsSyntax.KindSpecifierOptions.self) {
      kindSpecifier = self.eat(handle)
      kindSpecifierComma = self.consume(if: .comma)
    } else {
      kindSpecifier = nil
      kindSpecifierComma = nil
    }

    let arguments: RawDifferentiabilityWithRespectToArgumentSyntax?
    let argumentsComma: RawTokenSyntax?
    if self.at(.keyword(.wrt)) {
      arguments = self.parseDifferentiabilityWithRespectToArgument()
      argumentsComma = self.consume(if: .comma)
    } else {
      arguments = nil
      argumentsComma = nil
    }

    let whereClause: RawGenericWhereClauseSyntax?
    if self.at(.keyword(.where)) {
      whereClause = self.parseGenericWhereClause()
    } else {
      whereClause = nil
    }
    return RawDifferentiableAttributeArgumentsSyntax(
      kindSpecifier: kindSpecifier,
      kindSpecifierComma: kindSpecifierComma,
      arguments: arguments,
      argumentsComma: argumentsComma,
      genericWhereClause: whereClause,
      arena: self.arena
    )
  }

  mutating func parseDifferentiabilityWithRespectToArgument() -> RawDifferentiabilityWithRespectToArgumentSyntax {
    let (unexpectedBeforeWrt, wrt) = self.expect(.keyword(.wrt))
    let (unexpectedBeforeColon, colon) = self.expect(.colon)

    guard let leftParen = self.consume(if: .leftParen) else {
      // If no opening '(' for parameter list, parse a single parameter.
      let argument =
        self.parseDifferentiabilityArgument()
        ?? RawDifferentiabilityArgumentSyntax(
          argument: missingToken(.identifier),
          trailingComma: nil,
          arena: self.arena
        )
      return RawDifferentiabilityWithRespectToArgumentSyntax(
        unexpectedBeforeWrt,
        wrtLabel: wrt,
        unexpectedBeforeColon,
        colon: colon,
        arguments: .argument(argument),
        arena: self.arena
      )
    }

    var elements = [RawDifferentiabilityArgumentSyntax]()
    var loopProgress = LoopProgressCondition()
    while !self.at(.endOfFile, .rightParen) && self.hasProgressed(&loopProgress) {
      guard let param = self.parseDifferentiabilityArgument() else {
        break
      }
      elements.append(param)
    }
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    let arguments = RawDifferentiabilityArgumentListSyntax(elements: elements, arena: self.arena)
    let list = RawDifferentiabilityArgumentsSyntax(
      leftParen: leftParen,
      arguments: arguments,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
    return RawDifferentiabilityWithRespectToArgumentSyntax(
      wrtLabel: wrt,
      unexpectedBeforeColon,
      colon: colon,
      arguments: .argumentList(list),
      arena: self.arena
    )
  }

  mutating func parseDifferentiabilityArgument() -> RawDifferentiabilityArgumentSyntax? {
    switch self.at(anyIn: DifferentiabilityArgumentSyntax.ArgumentOptions.self) {
    case (.identifier, let handle)?:
      let token = self.eat(handle)
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityArgumentSyntax(
        argument: token,
        trailingComma: comma,
        arena: self.arena
      )
    case (.integerLiteral, let handle)?:
      let token = self.eat(handle)
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityArgumentSyntax(
        argument: token,
        trailingComma: comma,
        arena: self.arena
      )
    case (.self, let handle)?:
      let token = self.eat(handle)
      let comma = self.consume(if: .comma)
      return RawDifferentiabilityArgumentSyntax(
        argument: token,
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
    let (unexpectedBeforeDerivative, derivative) = self.expect(TokenSpec(.derivative, remapping: .identifier))

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let argument = self.parseDerivativeAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSign: atSign,
      unexpectedBeforeDerivative,
      attributeName: RawIdentifierTypeSyntax(name: derivative, genericArgumentClause: nil, arena: self.arena),
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      arguments: .derivativeRegistrationArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseTransposeAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeTranspose, transpose) = self.expect(TokenSpec(.transpose, remapping: .identifier))

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
    let argument = self.parseDerivativeAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSign: atSign,
      unexpectedBeforeTranspose,
      attributeName: RawIdentifierTypeSyntax(name: transpose, genericArgumentClause: nil, arena: self.arena),
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      arguments: .derivativeRegistrationArguments(argument),
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseDerivativeAttributeArguments() -> RawDerivativeAttributeArgumentsSyntax {
    let (unexpectedBeforeOfLabel, ofLabel) = self.expect(.keyword(.of))
    let (unexpectedBetweenOfLabelAndColon, colon) = self.expect(.colon)
    let originalDeclName = self.parseQualifiedDeclarationName()
    let period = self.consume(if: .period)
    let unexpectedBeforeAccessor: RawUnexpectedNodesSyntax?
    let accessor: RawTokenSyntax?
    if period != nil {
      (unexpectedBeforeAccessor, accessor) = self.expect(
        .keyword(.get),
        .keyword(.set),
        .keyword(._modify),
        default: .keyword(.get)
      )
    } else {
      (unexpectedBeforeAccessor, accessor) = (nil, nil)
    }
    let comma = self.consume(if: .comma)
    let arguments: RawDifferentiabilityWithRespectToArgumentSyntax?
    if comma != nil {
      arguments = self.parseDifferentiabilityWithRespectToArgument()
    } else {
      arguments = nil
    }
    return RawDerivativeAttributeArgumentsSyntax(
      unexpectedBeforeOfLabel,
      ofLabel: ofLabel,
      unexpectedBetweenOfLabelAndColon,
      colon: colon,
      originalDeclName: originalDeclName,
      period: period,
      unexpectedBeforeAccessor,
      accessorSpecifier: accessor,
      comma: comma,
      arguments: arguments,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseObjectiveCSelector() -> RawObjCSelectorPieceListSyntax {
    var elements = [RawObjCSelectorPieceSyntax]()
    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
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
      } else if self.at(.identifier, .wildcard) || self.currentToken.isLexerClassifiedKeyword {
        let name = self.consumeAnyToken(remapping: .identifier)

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
    return RawObjCSelectorPieceListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  mutating func parseSpecializedAttributeArgument() -> RawSpecializedAttributeArgumentSyntax {
    let whereClause = self.parseGenericWhereClause()
    return RawSpecializedAttributeArgumentSyntax(genericWhereClause: whereClause, arena: self.arena)
  }

  mutating func parseSpecializeAttributeArgumentList() -> RawSpecializeAttributeArgumentListSyntax {
    var elements = [RawSpecializeAttributeArgumentListSyntax.Element]()
    // Parse optional "exported" and "kind" labeled parameters.
    var loopProgress = LoopProgressCondition()
    LOOP: while !self.at(.endOfFile, .rightParen, .keyword(.where)) && self.hasProgressed(&loopProgress) {
      switch self.at(anyIn: LabeledSpecializeArgumentSyntax.LabelOptions.self) {
      case (.target, let handle)?:
        let label = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let declName = self.parseDeclReferenceExpr([.zeroArgCompoundNames, .keywordsUsingSpecialNames, .operators])
        let comma = self.consume(if: .comma)
        elements.append(
          .specializeTargetFunctionArgument(
            RawSpecializeTargetFunctionArgumentSyntax(
              targetLabel: label,
              unexpectedBeforeColon,
              colon: colon,
              declName: declName,
              trailingComma: comma,
              arena: self.arena
            )
          )
        )
      case (.availability, let handle)?:
        let label = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let availability = self.parseAvailabilityArgumentSpecList()
        let (unexpectedBeforeSemi, semi) = self.expect(.semicolon)
        elements.append(
          .specializeAvailabilityArgument(
            RawSpecializeAvailabilityArgumentSyntax(
              availabilityLabel: label,
              unexpectedBeforeColon,
              colon: colon,
              availabilityArguments: availability,
              unexpectedBeforeSemi,
              semicolon: semi,
              arena: self.arena
            )
          )
        )
      case (.exported, let handle)?:
        let label = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let (unexpectedBeforeValue, value) = self.expect(.keyword(.true), .keyword(.false), default: .keyword(.false))
        let comma = self.consume(if: .comma)
        elements.append(
          .labeledSpecializeArgument(
            RawLabeledSpecializeArgumentSyntax(
              label: label,
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
        let label = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let valueLabel = self.parseAnyIdentifier()
        let comma = self.consume(if: .comma)
        elements.append(
          .labeledSpecializeArgument(
            RawLabeledSpecializeArgumentSyntax(
              label: label,
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
        let label = self.eat(handle)
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        let valueLabel = self.consumeAnyToken()
        let comma = self.consume(if: .comma)
        elements.append(
          .labeledSpecializeArgument(
            RawLabeledSpecializeArgumentSyntax(
              label: label,
              unexpectedBeforeColon,
              colon: colon,
              value: valueLabel,
              trailingComma: comma,
              arena: self.arena
            )
          )
        )
      case nil:
        break LOOP
      }
    }

    // Parse the where clause.
    if self.at(.keyword(.where)) {
      let whereClause = self.parseGenericWhereClause()
      elements.append(.genericWhereClause(whereClause))
    }
    return RawSpecializeAttributeArgumentListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  mutating func parseImplementsAttributeArguments() -> RawImplementsAttributeArgumentsSyntax {
    let type = self.parseType()
    let (unexpectedBeforeComma, comma) = self.expect(.comma)
    let declName = self.parseDeclReferenceExpr([
      .zeroArgCompoundNames,
      .operators,
    ])
    return RawImplementsAttributeArgumentsSyntax(
      type: type,
      unexpectedBeforeComma,
      comma: comma,
      declName: declName,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseIsolatedAttributeArguments() -> RawLabeledExprListSyntax {
    let (unexpectedBeforeIsolationKind, isolationKind) =
      self.expectIdentifier(allowKeywordsAsIdentifier: true)
    let isolationKindElement = RawLabeledExprSyntax(
      unexpectedBeforeIsolationKind,
      identifier: isolationKind,
      arena: self.arena
    )

    return RawLabeledExprListSyntax(
      elements: [isolationKindElement],
      arena: self.arena
    )
  }
}

extension Parser {
  /// Parse the arguments inside an `@abi(...)` attribute.
  ///
  /// - Parameter missingLParen: `true` if the opening paren for the argument list was missing.
  mutating func parseABIAttributeArguments(
    missingLParen: Bool = false
  ) -> RawABIAttributeArgumentsSyntax {
    func makeMissingProviderArguments(unexpectedBefore: [RawSyntax]) -> RawABIAttributeArgumentsSyntax {
      return RawABIAttributeArgumentsSyntax(
        provider: .missing(
          RawMissingDeclSyntax(
            unexpectedBefore.isEmpty ? nil : RawUnexpectedNodesSyntax(elements: unexpectedBefore, arena: self.arena),
            attributes: self.emptyCollection(RawAttributeListSyntax.self),
            modifiers: self.emptyCollection(RawDeclModifierListSyntax.self),
            placeholder: self.missingToken(.identifier, text: "<#declaration#>"),
            arena: arena
          )
        ),
        arena: self.arena
      )
    }

    // Consider the three kinds of mistakes we might see here:
    //
    //   1. The user forgot the argument: `@abi(<<here>>) var x: Int`
    //   2. The user forgot the left paren: `@abi<<here>> var x_abi: Int) var x: Int`
    //   3. The user forgot the whole argument list: `@abi<<here>> var x: Int`
    //
    // It's difficult to write code that recovers from both #2 and #3. The problem is that in both cases, what comes
    // next looks like a declaration, so a simple lookahead cannot distinguish between them--you'd have to parse all
    // the way to the closing paren. (And what if *that's* also missing?)
    //
    // In lieu of that, we judge that recovering gracefully from #3 is more important than #2 and therefore do not even
    // attempt to parse the argument unless we've seen a left paren.
    guard !missingLParen && !self.at(.rightParen) else {
      return makeMissingProviderArguments(unexpectedBefore: [])
    }

    let decl = parseDeclaration(in: .argumentList)

    guard let provider = RawABIAttributeArgumentsSyntax.Provider(decl) else {
      return makeMissingProviderArguments(unexpectedBefore: [decl.raw])
    }

    return RawABIAttributeArgumentsSyntax(provider: provider, arena: self.arena)
  }
}

extension Parser {
  mutating func parseBackDeployedAttributeArguments() -> RawBackDeployedAttributeArgumentsSyntax {
    let (unexpectedBeforeLabel, label) = self.expect(.keyword(.before))
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    var elements: [RawPlatformVersionItemSyntax] = []
    var keepGoing: RawTokenSyntax? = nil
    repeat {
      let versionRestriction = self.parsePlatformVersion()
      keepGoing = self.consume(if: .comma)
      elements.append(
        RawPlatformVersionItemSyntax(
          platformVersion: versionRestriction,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil
    return RawBackDeployedAttributeArgumentsSyntax(
      unexpectedBeforeLabel,
      beforeLabel: label,
      unexpectedBeforeColon,
      colon: colon,
      platforms: RawPlatformVersionItemListSyntax(elements: elements, arena: self.arena),
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseOriginallyDefinedInAttributeArguments() -> RawOriginallyDefinedInAttributeArgumentsSyntax {
    let (unexpectedBeforeModuleLabel, moduleLabel) = self.expect(.keyword(.module))
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let moduleName = self.parseStringLiteral()
    let (unexpectedBeforeComma, comma) = self.expect(.comma)

    var platforms: [RawPlatformVersionItemSyntax] = []
    var keepGoing: RawTokenSyntax?
    repeat {
      let restriction = self.parsePlatformVersion(allowStarAsVersionNumber: true)
      keepGoing = self.consume(if: .comma)
      platforms.append(
        RawPlatformVersionItemSyntax(
          platformVersion: restriction,
          trailingComma: keepGoing,
          arena: self.arena
        )
      )
    } while keepGoing != nil

    return RawOriginallyDefinedInAttributeArgumentsSyntax(
      unexpectedBeforeModuleLabel,
      moduleLabel: moduleLabel,
      unexpectedBeforeColon,
      colon: colon,
      moduleName: moduleName,
      unexpectedBeforeComma,
      comma: comma,
      platforms: RawPlatformVersionItemListSyntax(elements: platforms, arena: self.arena),
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseDynamicReplacementAttributeArguments() -> RawDynamicReplacementAttributeArgumentsSyntax {
    let (unexpectedBeforeLabel, label) = self.expect(.keyword(.for))
    let (unexpectedBeforeColon, colon) = self.expect(.colon)
    let declName: RawDeclReferenceExprSyntax
    if label.isMissing && colon.isMissing && self.atStartOfLine {
      declName = RawDeclReferenceExprSyntax(
        baseName: RawTokenSyntax(missing: .identifier, arena: self.arena),
        argumentNames: nil,
        arena: self.arena
      )
    } else {
      declName = self.parseDeclReferenceExpr([
        .zeroArgCompoundNames, .keywordsUsingSpecialNames, .operators,
      ])
    }
    return RawDynamicReplacementAttributeArgumentsSyntax(
      unexpectedBeforeLabel,
      forLabel: label,
      unexpectedBeforeColon,
      colon: colon,
      declName: declName,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseDocumentationAttributeArguments() -> RawDocumentationAttributeArgumentListSyntax {
    var arguments: [RawDocumentationAttributeArgumentSyntax] = []

    var keepGoing: RawTokenSyntax? = nil
    repeat {
      let (unexpectedBeforeLabel, label) = self.expect(
        .keyword(.visibility),
        .keyword(.metadata),
        default: .keyword(.visibility)
      )
      let (unexpectedBeforeColon, colon) = self.expect(.colon)
      let unexpectedBeforeValue: RawUnexpectedNodesSyntax?
      let value: RawDocumentationAttributeArgumentSyntax.Value
      switch label.tokenText {
      case "visibility":
        enum AccessLevelModifier: TokenSpecSet {
          case `private`
          case `fileprivate`
          case `internal`
          case `package`
          case `public`
          case `open`

          var spec: TokenSpec {
            switch self {
            case .private: return .keyword(.private)
            case .fileprivate: return .keyword(.fileprivate)
            case .internal: return .keyword(.internal)
            case .package: return .keyword(.package)
            case .public: return .keyword(.public)
            case .open: return .keyword(.open)
            }
          }

          init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
            switch PrepareForKeywordMatch(lexeme) {
            case TokenSpec(.private): self = .private
            case TokenSpec(.fileprivate): self = .fileprivate
            case TokenSpec(.internal): self = .internal
            case TokenSpec(.package): self = .package
            case TokenSpec(.public): self = .public
            case TokenSpec(.open): self = .open
            default: return nil
            }
          }
        }

        let (unexpected, token) = self.expect(anyIn: AccessLevelModifier.self, default: .internal)
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

    return RawDocumentationAttributeArgumentListSyntax(elements: arguments, arena: self.arena)
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  mutating func atAttributeOrSpecifierArgument() -> Bool {
    var lookahead = self.lookahead()
    lookahead.skipSingle()

    // If we have any keyword, identifier, or token that follows a function
    // type's parameter list, this is a parameter list and not an attribute.
    // Alternatively, we might have a token that illustrates we're not going to
    // get anything following the attribute, which means the parentheses describe
    // what follows the attribute.
    switch lookahead.currentToken {
    case TokenSpec(.arrow),
      TokenSpec(.throw),
      TokenSpec(.throws),
      TokenSpec(.rethrows),
      TokenSpec(.rightParen),
      TokenSpec(.rightBrace),
      TokenSpec(.rightSquare),
      TokenSpec(.rightAngle):
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

    if self.at(TokenSpec(.leftParen, allowAtStartOfLine: false))
      && self.withLookahead({ $0.atAttributeOrSpecifierArgument() })
    {
      self.skipSingle()
    }

    return true
  }
}
