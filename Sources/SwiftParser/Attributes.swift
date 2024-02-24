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
    case _specialize
    case _spi
    case _spi_available
    case _swift_native_objc_runtime_base
    case _typeEraser
    case _unavailableFromAsync
    case `rethrows`
    case attached
    case available
    case backDeployed
    case derivative
    case differentiable
    case exclusivity
    case freestanding
    case inline
    case objc
    case Sendable
    case transpose

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(._alignment): self = ._alignment
      case TokenSpec(._backDeploy): self = ._backDeploy
      case TokenSpec(._cdecl): self = ._cdecl
      case TokenSpec(._documentation): self = ._documentation
      case TokenSpec(._dynamicReplacement): self = ._dynamicReplacement
      case TokenSpec(._effects): self = ._effects
      case TokenSpec(._expose): self = ._expose
      case TokenSpec(._implements): self = ._implements
      case TokenSpec(._nonSendable): self = ._nonSendable
      case TokenSpec(._objcImplementation): self = ._objcImplementation
      case TokenSpec(._objcRuntimeName): self = ._objcRuntimeName
      case TokenSpec(._optimize): self = ._optimize
      case TokenSpec(._originallyDefinedIn): self = ._originallyDefinedIn
      case TokenSpec(._private): self = ._private
      case TokenSpec(._projectedValueProperty): self = ._projectedValueProperty
      case TokenSpec(._semantics): self = ._semantics
      case TokenSpec(._specialize): self = ._specialize
      case TokenSpec(._spi): self = ._spi
      case TokenSpec(._spi_available): self = ._spi_available
      case TokenSpec(._swift_native_objc_runtime_base): self = ._swift_native_objc_runtime_base
      case TokenSpec(._typeEraser): self = ._typeEraser
      case TokenSpec(._unavailableFromAsync): self = ._unavailableFromAsync
      case TokenSpec(.`rethrows`): self = .rethrows
      case TokenSpec(.attached): self = .attached
      case TokenSpec(.available): self = .available
      case TokenSpec(.backDeployed): self = .backDeployed
      case TokenSpec(.derivative): self = .derivative
      case TokenSpec(.differentiable): self = .differentiable
      case TokenSpec(.exclusivity): self = .exclusivity
      case TokenSpec(.freestanding): self = .freestanding
      case TokenSpec(.inline): self = .inline
      case TokenSpec(.objc): self = .objc
      case TokenSpec(.Sendable): self = .Sendable
      case TokenSpec(.transpose): self = .transpose
      default:
        return nil
      }
    }

    var spec: TokenSpec {
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
      case ._specialize: return .keyword(._specialize)
      case ._spi: return .keyword(._spi)
      case ._spi_available: return .keyword(._spi_available)
      case ._swift_native_objc_runtime_base: return .keyword(._swift_native_objc_runtime_base)
      case ._typeEraser: return .keyword(._typeEraser)
      case ._unavailableFromAsync: return .keyword(._unavailableFromAsync)
      case .`rethrows`: return .keyword(.rethrows)
      case .attached: return .keyword(.attached)
      case .available: return .keyword(.available)
      case .backDeployed: return .keyword(.backDeployed)
      case .derivative: return .keyword(.derivative)
      case .differentiable: return .keyword(.differentiable)
      case .exclusivity: return .keyword(.exclusivity)
      case .freestanding: return .keyword(.freestanding)
      case .inline: return .keyword(.inline)
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

  mutating func parseAttribute(
    argumentMode: AttributeArgumentMode,
    parseArguments: (inout Parser) -> RawAttributeSyntax.Arguments
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
      shouldParseArgument = self.withLookahead { $0.atCustomAttributeArgument() } && self.at(TokenSpec(.leftParen, allowAtStartOfLine: false))
    case .optional:
      shouldParseArgument = self.at(.leftParen)
    case .noArgument:
      shouldParseArgument = false
    }
    if shouldParseArgument {
      var (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)
      if unexpectedBeforeLeftParen == nil && (attributeName.raw.trailingTriviaByteLength > 0 || leftParen.leadingTriviaByteLength > 0) {
        let diagnostic = TokenDiagnostic(
          self.swiftVersion < .v6 ? .extraneousLeadingWhitespaceWarning : .extraneousLeadingWhitespaceError,
          byteOffset: 0
        )
        leftParen = leftParen.tokenView.withTokenDiagnostic(tokenDiagnostic: diagnostic, arena: self.arena)
      }
      let argument = parseArguments(&self)
      let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
      return .attribute(
        RawAttributeSyntax(
          unexpectedBeforeAtSign,
          atSign: atSign,
          attributeName: attributeName,
          unexpectedBeforeLeftParen,
          leftParen: leftParen,
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
    case .available, ._spi_available:
      return parseAttribute(argumentMode: .required) { parser in
        return .availability(parser.parseAvailabilityArgumentSpecList())
      }
    case .backDeployed, ._backDeploy:
      return parseAttribute(argumentMode: .required) { parser in
        return .backDeployedArguments(parser.parseBackDeployedAttributeArguments())
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
        return .specializeArguments(parser.parseSpecializeAttributeArgumentList())
      }
    case ._private:
      return parseAttribute(argumentMode: .required) { parser in
        return .underscorePrivateAttributeArguments(parser.parseUnderscorePrivateAttributeArguments())
      }
    case ._dynamicReplacement:
      return parseAttribute(argumentMode: .required) { parser in
        return .dynamicReplacementArguments(parser.parseDynamicReplacementAttributeArguments())
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
        while !parser.at(.rightParen, .endOfFile) {
          tokens.append(parser.consumeAnyToken())
        }
        return .effectsArguments(RawEffectsAttributeArgumentListSyntax(elements: tokens, arena: parser.arena))
      }
    case ._cdecl:
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
    case ._expose:
      return parseAttribute(argumentMode: .required) { parser in
        return .exposeAttributeArguments(parser.parseExposeArguments())
      }
    case ._originallyDefinedIn:
      return parseAttribute(argumentMode: .required) { parser in
        return .originallyDefinedInArguments(parser.parseOriginallyDefinedInAttributeArguments())
      }
    case ._unavailableFromAsync:
      return parseAttribute(argumentMode: .optional) { parser in
        return .unavailableFromAsyncArguments(parser.parseUnavailableFromAsyncAttributeArguments())
      }
    case .attached, .freestanding:
      return parseAttribute(argumentMode: .customAttribute) { parser in
        let arguments = parser.parseMacroRoleArguments()
        return .argumentList(RawLabeledExprListSyntax(elements: arguments, arena: parser.arena))
      }
    case .rethrows:
      let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
      let (unexpectedBeforeAttributeName, attributeName) = self.expect(TokenSpec(.rethrows, remapping: .identifier))
      return .attribute(
        RawAttributeSyntax(
          unexpectedBeforeAtSign,
          atSign: atSign,
          unexpectedBeforeAttributeName,
          attributeName: RawTypeSyntax(RawIdentifierTypeSyntax(name: attributeName, genericArgumentClause: nil, arena: self.arena)),
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
        let arguments = parser.parseArgumentListElements(pattern: .none)
        return .argumentList(RawLabeledExprListSyntax(elements: arguments, arena: parser.arena))
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
    arena: __shared SyntaxArena
  ) {
    self.init(
      label: nil,
      colon: nil,
      expression: RawExprSyntax(
        RawDeclReferenceExprSyntax(
          unexpectedBeforeIdentifier,
          baseName: identifier,
          argumentNames: nil,
          arena: arena
        )
      ),
      unexpectedBetweenIdentifierAndTrailingComma,
      trailingComma: trailingComma,
      arena: arena
    )
  }
}

extension Parser {
  mutating func parseMacroRoleArguments() -> [RawLabeledExprSyntax] {
    let (unexpectedBeforeRole, role) = self.expect(.identifier, TokenSpec(.extension, remapping: .identifier), default: .identifier)
    let roleTrailingComma = self.consume(if: .comma)

    let roleElement = RawLabeledExprSyntax(
      unexpectedBeforeRole,
      identifier: role,
      trailingComma: roleTrailingComma,
      arena: self.arena
    )
    let additionalArgs = self.parseArgumentListElements(pattern: .none, flavor: .attributeArguments)
    return [roleElement] + additionalArgs
  }
}

extension Parser {
  mutating func parseDifferentiableAttribute() -> RawAttributeSyntax {
    let (unexpectedBeforeAtSign, atSign) = self.expect(.atSign)
    let (unexpectedBeforeDifferentiable, differentiable) = self.expect(TokenSpec(.differentiable, remapping: .identifier))
    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let argument = self.parseDifferentiableAttributeArguments()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAttributeSyntax(
      unexpectedBeforeAtSign,
      atSign: atSign,
      unexpectedBeforeDifferentiable,
      attributeName: RawTypeSyntax(RawIdentifierTypeSyntax(name: differentiable, genericArgumentClause: nil, arena: self.arena)),
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
      attributeName: RawTypeSyntax(RawIdentifierTypeSyntax(name: derivative, genericArgumentClause: nil, arena: self.arena)),
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
      attributeName: RawTypeSyntax(RawIdentifierTypeSyntax(name: transpose, genericArgumentClause: nil, arena: self.arena)),
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
      (unexpectedBeforeAccessor, accessor) = self.expect(.keyword(.get), .keyword(.set), default: .keyword(.get))
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
        let availability = self.parseAvailabilitySpecList()
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
  mutating func parseConventionArguments() -> RawAttributeSyntax.Arguments {
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
      let (unexpectedBeforeLabel, label) = self.expect(.identifier)
      let unexpectedBeforeComma: RawUnexpectedNodesSyntax?
      let comma: RawTokenSyntax?
      let unexpectedBeforeCTypeLabel: RawUnexpectedNodesSyntax?
      let cTypeLabel: RawTokenSyntax?
      let unexpectedBeforeColon: RawUnexpectedNodesSyntax?
      let colon: RawTokenSyntax?
      let cTypeString: RawStringLiteralExprSyntax?
      if self.at(.comma) {
        (unexpectedBeforeComma, comma) = self.expect(.comma)
        (unexpectedBeforeCTypeLabel, cTypeLabel) = self.expect(.keyword(.cType))
        (unexpectedBeforeColon, colon) = self.expect(.colon)
        cTypeString = self.parseStringLiteral()
      } else {
        unexpectedBeforeComma = nil
        comma = nil
        unexpectedBeforeCTypeLabel = nil
        cTypeLabel = nil
        unexpectedBeforeColon = nil
        colon = nil
        cTypeString = nil
      }
      return .conventionArguments(
        RawConventionAttributeArgumentsSyntax(
          unexpectedBeforeLabel,
          conventionLabel: label,
          unexpectedBeforeComma,
          comma: comma,
          unexpectedBeforeCTypeLabel,
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
  mutating func parseExposeArguments() -> RawExposeAttributeArgumentsSyntax {
    let language: RawTokenSyntax
    if !self.at(.rightParen, .comma) {
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
  mutating func parseUnderscorePrivateAttributeArguments() -> RawUnderscorePrivateAttributeArgumentsSyntax {
    let (unexpectedBeforeLabel, label) = self.expect(.keyword(.sourceFile))
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
  mutating func parseUnavailableFromAsyncAttributeArguments() -> RawUnavailableFromAsyncAttributeArgumentsSyntax {
    let (unexpectedBeforeLabel, label) = self.expect(.keyword(.message))
    let (unexpectedBeforeColon, colon) = self.expect(.colon)

    let unexpectedBetweenColonAndMessage: RawUnexpectedNodesSyntax?
    if let equalToken = self.consume(if: .equal) {
      unexpectedBetweenColonAndMessage = RawUnexpectedNodesSyntax([equalToken], arena: self.arena)
    } else {
      unexpectedBetweenColonAndMessage = nil
    }

    let message = self.parseStringLiteral()
    return RawUnavailableFromAsyncAttributeArgumentsSyntax(
      unexpectedBeforeLabel,
      messageLabel: label,
      unexpectedBeforeColon,
      colon: colon,
      unexpectedBetweenColonAndMessage,
      message: message,
      arena: self.arena
    )
  }
}

extension Parser {
  mutating func parseDocumentationAttributeArguments() -> RawDocumentationAttributeArgumentListSyntax {
    var arguments: [RawDocumentationAttributeArgumentSyntax] = []

    var keepGoing: RawTokenSyntax? = nil
    repeat {
      let (unexpectedBeforeLabel, label) = self.expect(.keyword(.visibility), .keyword(.metadata), default: .keyword(.visibility))
      let (unexpectedBeforeColon, colon) = self.expect(.colon)
      let unexpectedBeforeValue: RawUnexpectedNodesSyntax?
      let value: RawDocumentationAttributeArgumentSyntax.Value
      switch label.tokenText {
      case "visibility":
        enum AccessLevelModifier: TokenSpecSet {
          case `private`
          case `fileprivate`
          case `internal`
          case `public`
          case `open`

          var spec: TokenSpec {
            switch self {
            case .private: return .keyword(.private)
            case .fileprivate: return .keyword(.fileprivate)
            case .internal: return .keyword(.internal)
            case .public: return .keyword(.public)
            case .open: return .keyword(.open)
            }
          }

          init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
            switch PrepareForKeywordMatch(lexeme) {
            case TokenSpec(.private): self = .private
            case TokenSpec(.fileprivate): self = .fileprivate
            case TokenSpec(.internal): self = .internal
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
  mutating func atCustomAttributeArgument() -> Bool {
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

    if self.at(TokenSpec(.leftParen, allowAtStartOfLine: false)) && self.withLookahead({ $0.atCustomAttributeArgument() }) {
      self.skipSingle()
    }

    return true
  }
}
