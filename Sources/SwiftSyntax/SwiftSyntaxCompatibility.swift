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

public extension DeclGroupSyntax {
  @available(*, deprecated, renamed: "memberBlock")
  var members: MemberDeclBlockSyntax {
    return self.memberBlock
  }
}

@available(*, deprecated, renamed: "ImportPathSyntax")
public typealias AccessPathSyntax = ImportPathSyntax

@available(*, deprecated, renamed: "ImportPathComponentSyntax")
public typealias AccessPathComponentSyntax = ImportPathComponentSyntax

@available(*, deprecated, renamed: "WithAttributesSyntax")
public typealias AttributedSyntax = WithAttributesSyntax

public extension EnumDeclSyntax {
  @available(*, deprecated, renamed: "unexpectedBetweenIdentifierAndGenericParameterClause")
  var unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? { unexpectedBetweenIdentifierAndGenericParameterClause }

  @available(*, deprecated, renamed: "genericParameterClause")
  var genericParameters: GenericParameterClauseSyntax? { genericParameterClause }

  @available(*, deprecated, renamed: "unexpectedBetweenGenericParameterClauseAndInheritanceClause")
  var unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? { unexpectedBetweenGenericParameterClauseAndInheritanceClause }

  @available(*, deprecated, message: "Use an initializer with a genericParameterClause argument.")
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

public extension NamedOpaqueReturnTypeSyntax {
  @available(*, deprecated, renamed: "unexpectedBeforeGenericParameterClause")
  var unexpectedBeforeGenericParameters: UnexpectedNodesSyntax? { unexpectedBeforeGenericParameterClause }

  @available(*, deprecated, renamed: "genericParameterClause")
  var genericParameters: GenericParameterClauseSyntax? { genericParameterClause }

  @available(*, deprecated, renamed: "unexpectedBetweenGenericParameterClauseAndBaseType")
  var unexpectedBetweenGenericParametersAndBaseType: UnexpectedNodesSyntax? { unexpectedBetweenGenericParameterClauseAndBaseType }

  @available(*, deprecated, message: "Use an initializer with a genericParameterClause argument.")
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
