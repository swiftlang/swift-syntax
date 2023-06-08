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
