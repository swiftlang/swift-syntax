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

// This file provides compatiblity aliases to keep dependents of SwiftSyntax building.
// All users of the declarations in this file should transition away from them ASAP.

@available(*, deprecated, renamed: "ImportPathSyntax")
public typealias AccessPathSyntax = ImportPathSyntax

@available(*, deprecated, renamed: "ImportPathComponentSyntax")
public typealias AccessPathComponentSyntax = ImportPathComponentSyntax

@available(*, deprecated, renamed: "WithAttributesSyntax")
public typealias AttributedSyntax = WithAttributesSyntax

public extension ArrayTypeSyntax {
  @available(*, deprecated, renamed: "unexpectedBeforeLeftSquare")
  var unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? {
    return unexpectedBeforeLeftSquare
  }

  @available(*, deprecated, renamed: "leftSquare")
  var leftSquareBracket: TokenSyntax {
    get {
      return leftSquare
    }
    set(value) {
      leftSquare = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenLeftSquareAndElementType")
  var unexpectedBetweenLeftSquareBracketAndElementType: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenLeftSquareAndElementType
    }
    set(value) {
      unexpectedBetweenLeftSquareAndElementType = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenElementTypeAndRightSquare")
  var unexpectedBetweenElementTypeAndRightSquareBracket: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenElementTypeAndRightSquare
    }
    set(value) {
      unexpectedBetweenElementTypeAndRightSquare = value
    }
  }

  @available(*, deprecated, renamed: "rightSquare")
  var rightSquareBracket: TokenSyntax {
    get {
      return rightSquare
    }
    set(value) {
      rightSquare = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedAfterRightSquare")
  var unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? {
    get {
      return unexpectedAfterRightSquare
    }
    set(value) {
      unexpectedAfterRightSquare = value
    }
  }

  @available(*, deprecated, message: "Use an initializer with leftSquare and rightSquare arguments")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? = nil,
    leftSquareBracket: TokenSyntax = .leftSquareToken(),
    _ unexpectedBetweenLeftSquareBracketAndElementType: UnexpectedNodesSyntax? = nil,
    elementType: some TypeSyntaxProtocol,
    _ unexpectedBetweenElementTypeAndRightSquareBracket: UnexpectedNodesSyntax? = nil,
    rightSquareBracket: TokenSyntax = .rightSquareToken(),
    _ unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeLeftSquareBracket,
      leftSquare: leftSquareBracket,
      unexpectedBetweenLeftSquareBracketAndElementType,
      elementType: elementType,
      unexpectedBetweenElementTypeAndRightSquareBracket,
      rightSquare: rightSquareBracket,
      unexpectedAfterRightSquareBracket,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension AvailabilityConditionSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenLeftParenAndAvailabilityArguments")
  var unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? {
    get { unexpectedBetweenLeftParenAndAvailabilityArguments }
    set { unexpectedBetweenLeftParenAndAvailabilityArguments = newValue }
  }

  @available(*, deprecated, renamed: "availabilityArguments")
  var availabilitySpec: AvailabilitySpecListSyntax {
    get { availabilityArguments }
    set { availabilityArguments = newValue }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenAvailabilityArgumentsAndRightParen")
  var unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? {
    get { unexpectedBetweenAvailabilityArgumentsAndRightParen }
    set { unexpectedBetweenAvailabilityArgumentsAndRightParen = newValue }
  }

  @available(*, deprecated, message: "Use an initializer with an availabilityArguments argument")
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAvailabilityKeyword: UnexpectedNodesSyntax? = nil,
    availabilityKeyword: TokenSyntax,
    _ unexpectedBetweenAvailabilityKeywordAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? = nil,
    availabilitySpec: AvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeAvailabilityKeyword,
      availabilityKeyword: availabilityKeyword,
      unexpectedBetweenAvailabilityKeywordAndLeftParen,
      leftParen: leftParen,
      unexpectedBetweenLeftParenAndAvailabilitySpec,
      availabilityArguments: availabilitySpec,
      unexpectedBetweenAvailabilitySpecAndRightParen,
      rightParen: rightParen,
      unexpectedAfterRightParen,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension AvailabilityEntrySyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenColonAndAvailabilityArguments")
  var unexpectedBetweenColonAndAvailabilityList: UnexpectedNodesSyntax? {
    get { unexpectedBetweenColonAndAvailabilityArguments }
    set { unexpectedBetweenColonAndAvailabilityArguments = newValue }
  }

  @available(*, deprecated, renamed: "availabilityArguments")
  var availabilityList: AvailabilitySpecListSyntax {
    get { availabilityArguments }
    set { availabilityArguments = newValue }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenAvailabilityArgumentsAndSemicolon")
  var unexpectedBetweenAvailabilityListAndSemicolon: UnexpectedNodesSyntax? {
    get { unexpectedBetweenAvailabilityArgumentsAndSemicolon }
    set { unexpectedBetweenAvailabilityArgumentsAndSemicolon = newValue }
  }

  /// Adds the provided `element` to the node's `availabilityList`
  /// collection.
  /// - param element: The new `Availability` to add to the node's
  ///                  `availabilityList` collection.
  /// - returns: A copy of the receiver with the provided `Availability`
  ///            appended to its `availabilityList` collection.
  @available(*, deprecated, renamed: "addAvailabilityArgument")
  func addAvailability(_ element: AvailabilityArgumentSyntax) -> AvailabilityEntrySyntax {
    addAvailabilityArgument(element)
  }

  @available(*, deprecated, message: "Use an initializer with an availabilityArguments argument")
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil,
    label: TokenSyntax = .keyword(.availability),
    _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndAvailabilityList: UnexpectedNodesSyntax? = nil,
    availabilityList: AvailabilitySpecListSyntax,
    _ unexpectedBetweenAvailabilityListAndSemicolon: UnexpectedNodesSyntax? = nil,
    semicolon: TokenSyntax = .semicolonToken(),
    _ unexpectedAfterSemicolon: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeLabel,
      label: label,
      unexpectedBetweenLabelAndColon,
      colon: colon,
      unexpectedBetweenColonAndAvailabilityList,
      availabilityArguments: availabilityList,
      unexpectedBetweenAvailabilityListAndSemicolon,
      semicolon: semicolon,
      unexpectedAfterSemicolon,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension BackDeployedAttributeSpecListSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenColonAndPlatforms")
  var unexpectedBetweenColonAndVersionList: UnexpectedNodesSyntax? {
    get { unexpectedBetweenColonAndPlatforms }
    set { unexpectedBetweenColonAndPlatforms = newValue }
  }

  @available(*, deprecated, renamed: "platforms")
  var versionList: AvailabilityVersionRestrictionListSyntax {
    get { platforms }
    set { platforms = newValue }
  }

  @available(*, deprecated, renamed: "unexpectedAfterPlatforms")
  var unexpectedAfterVersionList: UnexpectedNodesSyntax? {
    get { unexpectedAfterPlatforms }
    set { unexpectedAfterPlatforms = newValue }
  }

  /// Adds the provided `element` to the node's `versionList`
  /// collection.
  /// - param element: The new `Availability` to add to the node's
  ///                  `versionList` collection.
  /// - returns: A copy of the receiver with the provided `Availability`
  ///            appended to its `versionList` collection.
  @available(*, deprecated, renamed: "addPlatform")
  func addAvailability(_ element: AvailabilityVersionRestrictionListEntrySyntax) -> BackDeployedAttributeSpecListSyntax {
    addPlatform(element)
  }

  @available(*, deprecated, message: "Use an initializer with a platforms argument")
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeBeforeLabel: UnexpectedNodesSyntax? = nil,
    beforeLabel: TokenSyntax = .keyword(.before),
    _ unexpectedBetweenBeforeLabelAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndVersionList: UnexpectedNodesSyntax? = nil,
    versionList: AvailabilityVersionRestrictionListSyntax,
    _ unexpectedAfterVersionList: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeBeforeLabel,
      beforeLabel: beforeLabel,
      unexpectedBetweenBeforeLabelAndColon,
      colon: colon,
      unexpectedBetweenColonAndVersionList,
      platforms: versionList,
      unexpectedAfterVersionList,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension DeclGroupSyntax {
  @available(*, deprecated, renamed: "memberBlock")
  var members: MemberDeclBlockSyntax {
    get {
      return memberBlock
    }
    set(value) {
      memberBlock = value
    }
  }
}

public extension EditorPlaceholderDeclSyntax {
  @available(*, deprecated, renamed: "placeholder")
  var identifier: TokenSyntax { placeholder }

  @available(*, deprecated, renamed: "placeholder")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedAfterIdentifier: UnexpectedNodesSyntax? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeIdentifier,
      placeholder: identifier,
      unexpectedAfterIdentifier
    )
  }
}

public extension DictionaryTypeSyntax {
  @available(*, deprecated, renamed: "unexpectedBeforeLeftSquare")
  var unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? {
    get {
      return unexpectedBeforeLeftSquare
    }
    set(value) {
      unexpectedBeforeLeftSquare = value
    }
  }

  @available(*, deprecated, renamed: "leftSquare")
  var leftSquareBracket: TokenSyntax {
    get {
      return leftSquare
    }
    set(value) {
      leftSquare = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenLeftSquareAndKeyType")
  var unexpectedBetweenLeftSquareBracketAndKeyType: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenLeftSquareAndKeyType
    }
    set(value) {
      unexpectedBetweenLeftSquareAndKeyType = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenValueTypeAndRightSquare")
  var unexpectedBetweenValueTypeAndRightSquareBracket: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenValueTypeAndRightSquare
    }
    set(value) {
      unexpectedBetweenValueTypeAndRightSquare = value
    }
  }

  @available(*, deprecated, renamed: "rightSquare")
  var rightSquareBracket: TokenSyntax {
    get {
      return rightSquare
    }
    set(value) {
      rightSquare = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedAfterRightSquare")
  var unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? {
    get {
      return unexpectedAfterRightSquare
    }
    set(value) {
      unexpectedAfterRightSquare = value
    }
  }

  @available(*, deprecated, message: "Use an initializer with leftSquare and rightSquare arguments")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? = nil,
    leftSquareBracket: TokenSyntax = .leftSquareToken(),
    _ unexpectedBetweenLeftSquareBracketAndKeyType: UnexpectedNodesSyntax? = nil,
    keyType: some TypeSyntaxProtocol,
    _ unexpectedBetweenKeyTypeAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndValueType: UnexpectedNodesSyntax? = nil,
    valueType: some TypeSyntaxProtocol,
    _ unexpectedBetweenValueTypeAndRightSquareBracket: UnexpectedNodesSyntax? = nil,
    rightSquareBracket: TokenSyntax = .rightSquareToken(),
    _ unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil

  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeLeftSquareBracket,
      leftSquare: leftSquareBracket,
      unexpectedBetweenLeftSquareBracketAndKeyType,
      keyType: keyType,
      unexpectedBetweenKeyTypeAndColon,
      colon: colon,
      unexpectedBetweenColonAndValueType,
      valueType: valueType,
      unexpectedBetweenValueTypeAndRightSquareBracket,
      rightSquare: rightSquareBracket,
      unexpectedAfterRightSquareBracket,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension EnumDeclSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenIdentifierAndGenericParameterClause")
  var unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenIdentifierAndGenericParameterClause
    }
    set(value) {
      unexpectedBetweenIdentifierAndGenericParameterClause = value
    }
  }

  @available(*, deprecated, renamed: "genericParameterClause")
  var genericParameters: GenericParameterClauseSyntax? {
    get {
      return genericParameterClause
    }
    set(value) {
      genericParameterClause = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenGenericParameterClauseAndInheritanceClause")
  var unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenGenericParameterClauseAndInheritanceClause
    }
    set(value) {
      unexpectedBetweenGenericParameterClauseAndInheritanceClause = value
    }
  }

  @available(*, deprecated, message: "Use an initializer with a genericParameterClause argument.")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndEnumKeyword: UnexpectedNodesSyntax? = nil,
    enumKeyword: TokenSyntax = .keyword(.enum),
    _ unexpectedBetweenEnumKeywordAndIdentifier: UnexpectedNodesSyntax? = nil,
    identifier: TokenSyntax,
    _ unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? = nil,
    genericParameters: GenericParameterClauseSyntax? = nil,
    _ unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? = nil,
    inheritanceClause: TypeInheritanceClauseSyntax? = nil,
    _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndMemberBlock: UnexpectedNodesSyntax? = nil,
    memberBlock: MemberDeclBlockSyntax,
    _ unexpectedAfterMemberBlock: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeAttributes,
      attributes: attributes,
      unexpectedBetweenAttributesAndModifiers,
      modifiers: modifiers,
      unexpectedBetweenModifiersAndEnumKeyword,
      enumKeyword: enumKeyword,
      unexpectedBetweenEnumKeywordAndIdentifier,
      identifier: identifier,
      unexpectedBetweenIdentifierAndGenericParameters,
      genericParameterClause: genericParameters,
      unexpectedBetweenGenericParametersAndInheritanceClause,
      inheritanceClause: inheritanceClause,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      unexpectedBetweenGenericWhereClauseAndMemberBlock,
      memberBlock: memberBlock,
      unexpectedAfterMemberBlock,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension FunctionTypeSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenLeftParenAndParameters")
  var unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenLeftParenAndParameters
    }
    set(value) {
      unexpectedBetweenLeftParenAndParameters = value
    }
  }

  @available(*, deprecated, renamed: "parameters")
  var arguments: TupleTypeElementListSyntax {
    get {
      return parameters
    }
    set(value) {
      parameters = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenParametersAndRightParen")
  var unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenParametersAndRightParen
    }
    set(value) {
      unexpectedBetweenParametersAndRightParen = value
    }
  }

  /// Adds the provided `element` to the node's `arguments`
  /// - param element: The new `Argument` to add to the node's
  ///                  `arguments` collection.
  /// - returns: A copy of the receiver with the provided `Argument`
  ///            appended to its `arguments` collection.
  @available(*, deprecated, renamed: "addParameter")
  func addArgument(_ element: TupleTypeElementSyntax) -> FunctionTypeSyntax {
    return self.addParameter(element)
  }

  @available(*, deprecated, message: "Use an initializer with a parameters")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    arguments: TupleTypeElementListSyntax,
    _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedBetweenRightParenAndEffectSpecifiers: UnexpectedNodesSyntax? = nil,
    effectSpecifiers: TypeEffectSpecifiersSyntax? = nil,
    _ unexpectedBetweenEffectSpecifiersAndOutput: UnexpectedNodesSyntax? = nil,
    output: ReturnClauseSyntax,
    _ unexpectedAfterOutput: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      unexpectedBetweenLeftParenAndArguments,
      parameters: arguments,
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: rightParen,
      unexpectedBetweenRightParenAndEffectSpecifiers,
      effectSpecifiers: effectSpecifiers,
      unexpectedBetweenEffectSpecifiersAndOutput,
      output: output,
      unexpectedAfterOutput,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension GenericParameterClauseSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenLeftAngleBracketAndParameters")
  var unexpectedBetweenLeftAngleBracketAndGenericParameterList: UnexpectedNodesSyntax? {
    get { unexpectedBetweenLeftAngleBracketAndParameters }
    set { unexpectedBetweenLeftAngleBracketAndParameters = newValue }
  }

  @available(*, deprecated, renamed: "parameters")
  var genericParameterList: GenericParameterListSyntax {
    get { parameters }
    set { parameters = newValue }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenParametersAndGenericWhereClause")
  var unexpectedBetweenGenericParameterListAndGenericWhereClause: UnexpectedNodesSyntax? {
    get { unexpectedBetweenParametersAndGenericWhereClause }
    set { unexpectedBetweenParametersAndGenericWhereClause = newValue }
  }

  /// Adds the provided `element` to the node's `genericParameterList`
  /// collection.
  /// - param element: The new `GenericParameter` to add to the node's
  ///                  `genericParameterList` collection.
  /// - returns: A copy of the receiver with the provided `GenericParameter`
  ///            appended to its `genericParameterList` collection.
  @available(*, deprecated, renamed: "addParameter")
  func addGenericParameter(_ element: GenericParameterSyntax) -> GenericParameterClauseSyntax {
    addParameter(element)
  }

  @available(*, deprecated, message: "Use an initializer with a parameters argument")
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil,
    leftAngleBracket: TokenSyntax = .leftAngleToken(),
    _ unexpectedBetweenLeftAngleBracketAndGenericParameterList: UnexpectedNodesSyntax? = nil,
    genericParameterList: GenericParameterListSyntax,
    _ unexpectedBetweenGenericParameterListAndGenericWhereClause: UnexpectedNodesSyntax? = nil,
    genericWhereClause: GenericWhereClauseSyntax? = nil,
    _ unexpectedBetweenGenericWhereClauseAndRightAngleBracket: UnexpectedNodesSyntax? = nil,
    rightAngleBracket: TokenSyntax = .rightAngleToken(),
    _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeLeftAngleBracket,
      leftAngleBracket: leftAngleBracket,
      unexpectedBetweenLeftAngleBracketAndGenericParameterList,
      parameters: genericParameterList,
      unexpectedBetweenGenericParameterListAndGenericWhereClause,
      genericWhereClause: genericWhereClause,
      unexpectedBetweenGenericWhereClauseAndRightAngleBracket,
      rightAngleBracket: rightAngleBracket,
      unexpectedAfterRightAngleBracket,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension ImportDeclSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenModifiersAndImportKeyword")
  var unexpectedBetweenModifiersAndImportTok: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenModifiersAndImportKeyword
    }
    set(value) {
      unexpectedBetweenModifiersAndImportKeyword = value
    }
  }

  @available(*, deprecated, renamed: "importKeyword")
  var importTok: TokenSyntax {
    get {
      return importKeyword
    }
    set(value) {
      importKeyword = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenImportKeywordAndImportKind")
  var unexpectedBetweenImportTokAndImportKind: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenImportKeywordAndImportKind
    }
    set(value) {
      unexpectedBetweenImportKeywordAndImportKind = value
    }
  }

  @available(*, deprecated, message: "Use an initializer with importKeyword")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil,
    attributes: AttributeListSyntax? = nil,
    _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil,
    modifiers: ModifierListSyntax? = nil,
    _ unexpectedBetweenModifiersAndImportTok: UnexpectedNodesSyntax? = nil,
    importTok: TokenSyntax = .keyword(.import),
    _ unexpectedBetweenImportTokAndImportKind: UnexpectedNodesSyntax? = nil,
    importKind: TokenSyntax? = nil,
    _ unexpectedBetweenImportKindAndPath: UnexpectedNodesSyntax? = nil,
    path: ImportPathSyntax,
    _ unexpectedAfterPath: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeAttributes,
      attributes: attributes,
      unexpectedBetweenAttributesAndModifiers,
      modifiers: modifiers,
      unexpectedBetweenModifiersAndImportTok,
      importKeyword: importTok,
      unexpectedBetweenImportTokAndImportKind,
      importKind: importKind,
      unexpectedBetweenImportKindAndPath,
      path: path,
      unexpectedAfterPath,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension NamedOpaqueReturnTypeSyntax {
  @available(*, deprecated, renamed: "unexpectedBeforeGenericParameterClause")
  var unexpectedBeforeGenericParameters: UnexpectedNodesSyntax? {
    get {
      return unexpectedBeforeGenericParameterClause
    }
    set(value) {
      unexpectedBeforeGenericParameterClause = value
    }
  }

  @available(*, deprecated, renamed: "genericParameterClause")
  var genericParameters: GenericParameterClauseSyntax {
    get {
      return genericParameterClause
    }
    set(value) {
      genericParameterClause = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenGenericParameterClauseAndBaseType")
  var unexpectedBetweenGenericParametersAndBaseType: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenGenericParameterClauseAndBaseType
    }
    set(value) {
      unexpectedBetweenGenericParameterClauseAndBaseType = value
    }
  }

  @available(*, deprecated, message: "Use an initializer with a genericParameterClause argument.")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeGenericParameters: UnexpectedNodesSyntax? = nil,
    genericParameters: GenericParameterClauseSyntax,
    _ unexpectedBetweenGenericParametersAndBaseType: UnexpectedNodesSyntax? = nil,
    baseType: some TypeSyntaxProtocol,
    _ unexpectedAfterBaseType: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeGenericParameters,
      genericParameterClause: genericParameters,
      unexpectedBetweenGenericParametersAndBaseType,
      baseType: baseType,
      unexpectedAfterBaseType,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension PrecedenceGroupRelationSyntax {
  @available(*, deprecated, renamed: "unexpectedBeforeHigherThanOrLowerThanKeyword")
  var unexpectedBeforeHigherThanOrLowerThan: UnexpectedNodesSyntax? {
    get {
      return unexpectedBeforeHigherThanOrLowerThanKeyword
    }
    set(value) {
      unexpectedBeforeHigherThanOrLowerThanKeyword = value
    }
  }

  @available(*, deprecated, renamed: "higherThanOrLowerThanKeyword")
  var higherThanOrLowerThan: TokenSyntax {
    get {
      return higherThanOrLowerThanKeyword
    }
    set(value) {
      higherThanOrLowerThanKeyword = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenHigherThanOrLowerThanKeywordAndColon")
  var unexpectedBetweenHigherThanOrLowerThanAndColon: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenHigherThanOrLowerThanKeywordAndColon
    }
    set(value) {
      unexpectedBetweenHigherThanOrLowerThanKeywordAndColon = value
    }
  }

  @available(*, deprecated, message: "Use an initializer with a genericParameterClause argument.")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeHigherThanOrLowerThan: UnexpectedNodesSyntax? = nil,
    higherThanOrLowerThan: TokenSyntax,
    _ unexpectedBetweenHigherThanOrLowerThanAndColon: UnexpectedNodesSyntax? = nil,
    colon: TokenSyntax = .colonToken(),
    _ unexpectedBetweenColonAndOtherNames: UnexpectedNodesSyntax? = nil,
    otherNames: PrecedenceGroupNameListSyntax,
    _ unexpectedAfterOtherNames: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeHigherThanOrLowerThan,
      higherThanOrLowerThanKeyword: higherThanOrLowerThan,
      unexpectedBetweenHigherThanOrLowerThanAndColon,
      colon: colon,
      unexpectedBetweenColonAndOtherNames,
      otherNames: otherNames,
      unexpectedAfterOtherNames,
      trailingTrivia: trailingTrivia
    )
  }
}

public extension SyntaxProtocol {
  @available(*, deprecated, message: "Use detached computed property instead.")
  func detach() -> Self {
    return detached
  }
}

public extension TokenKind {
  @available(*, deprecated, renamed: "leftSquare")
  static var leftSquareBracket: TokenKind {
    return .leftSquare
  }

  @available(*, deprecated, renamed: "rightSquare")
  static var rightSquareBracket: TokenKind {
    return .rightSquare
  }
}

public extension TokenSyntax {
  @available(*, deprecated, renamed: "leftSquareToken")
  static func leftSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return .leftSquareToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }

  @available(*, deprecated, renamed: "rightSquareToken")
  static func rightSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [],
    presence: SourcePresence = .present
  ) -> TokenSyntax {
    return .rightSquareToken(
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence
    )
  }
}

public extension TupleExprSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenLeftParenAndElements")
  var unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenLeftParenAndElements
    }
    set(value) {
      unexpectedBetweenLeftParenAndElements = value
    }
  }

  @available(*, deprecated, renamed: "elements")
  var elementList: TupleExprElementListSyntax {
    get {
      return elements
    }
    set(value) {
      elements = value
    }
  }

  @available(*, deprecated, renamed: "unexpectedBetweenElementsAndRightParen")
  var unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? {
    get {
      return unexpectedBetweenElementsAndRightParen
    }
    set(value) {
      unexpectedBetweenElementsAndRightParen = value
    }
  }

  @available(*, deprecated, message: "Use an initializer with a elements argument")
  @_disfavoredOverload
  init(
    leadingTrivia: Trivia? = nil,
    _ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax = .leftParenToken(),
    _ unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? = nil,
    elementList: TupleExprElementListSyntax,
    _ unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax = .rightParenToken(),
    _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil,
    trailingTrivia: Trivia? = nil
  ) {
    self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      unexpectedBetweenLeftParenAndElementList,
      elements: elementList,
      unexpectedBetweenElementListAndRightParen,
      rightParen: rightParen,
      unexpectedAfterRightParen,
      trailingTrivia: trailingTrivia
    )
  }
}

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatiblity layer code here      //
// please insert it in alphabetical order above                             //
//==========================================================================//
