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

import SwiftSyntax
import SwiftSyntaxBuilder

/// For every syntax node that shall be generated, this enum contains a case.
///
/// Using the cases of this enum, children of syntax nodes can refer the syntax
/// node that defines their layout.
public enum SyntaxNodeKind: String, CaseIterable, SyntaxNodeKindProtocol, IdentifierConvertible {
  // Please keep this list sorted alphabetically

  case _canImportExpr
  case _canImportVersionInfo
  case accessorBlock
  case accessorDecl
  case accessorDeclList
  case accessorEffectSpecifiers
  case accessorParameters
  case actorDecl
  case arrayElement
  case arrayElementList
  case arrayExpr
  case arrayType
  case arrowExpr
  case asExpr
  case assignmentExpr
  case associatedTypeDecl
  case attribute
  case attributedType
  case attributeList
  case availabilityArgument
  case availabilityArgumentList
  case availabilityCondition
  case availabilityLabeledArgument
  case awaitExpr
  case backDeployedAttributeArguments
  case binaryOperatorExpr
  case booleanLiteralExpr
  case borrowExpr
  case breakStmt
  case catchClause
  case catchClauseList
  case catchItem
  case catchItemList
  case classDecl
  case classRestrictionType
  case closureCapture
  case closureCaptureClause
  case closureCaptureList
  case closureCaptureSpecifier
  case closureExpr
  case closureParameter
  case closureParameterClause
  case closureParameterList
  case closureShorthandParameter
  case closureShorthandParameterList
  case closureSignature
  case codeBlock
  case codeBlockItem
  case codeBlockItemList
  case compositionType
  case compositionTypeElement
  case compositionTypeElementList
  case conditionElement
  case conditionElementList
  case conformanceRequirement
  case consumeExpr
  case continueStmt
  case conventionAttributeArguments
  case conventionWitnessMethodAttributeArguments
  case copyExpr
  case decl
  case declModifier
  case declModifierDetail
  case declModifierList
  case declNameArgument
  case declNameArgumentList
  case declNameArguments
  case declReferenceExpr
  case deferStmt
  case deinitializerDecl
  case deinitializerEffectSpecifiers
  case derivativeAttributeArguments
  case designatedType
  case designatedTypeList
  case dictionaryElement
  case dictionaryElementList
  case dictionaryExpr
  case dictionaryType
  case differentiabilityArgument
  case differentiabilityArgumentList
  case differentiabilityArguments
  case differentiabilityWithRespectToArgument
  case differentiableAttributeArguments
  case discardAssignmentExpr
  case discardStmt
  case documentationAttributeArgument
  case documentationAttributeArgumentList
  case doExpr
  case doStmt
  case dynamicReplacementAttributeArguments
  case editorPlaceholderDecl
  case editorPlaceholderExpr
  case effectsAttributeArgumentList
  case enumCaseDecl
  case enumCaseElement
  case enumCaseElementList
  case enumCaseParameter
  case enumCaseParameterClause
  case enumCaseParameterList
  case enumDecl
  case exposeAttributeArguments
  case expr
  case expressionPattern
  case expressionSegment
  case expressionStmt
  case exprList
  case extensionDecl
  case fallThroughStmt
  case floatLiteralExpr
  case forceUnwrapExpr
  case forStmt
  case functionCallExpr
  case functionDecl
  case functionEffectSpecifiers
  case functionParameter
  case functionParameterClause
  case functionParameterList
  case functionSignature
  case functionType
  case genericArgument
  case genericArgumentClause
  case genericArgumentList
  case genericParameter
  case genericParameterClause
  case genericParameterList
  case genericRequirement
  case genericRequirementList
  case genericSpecializationExpr
  case genericWhereClause
  case guardStmt
  case identifierPattern
  case identifierType
  case ifConfigClause
  case ifConfigClauseList
  case ifConfigDecl
  case ifExpr
  case implementsAttributeArguments
  case implicitlyUnwrappedOptionalType
  case importDecl
  case importPathComponent
  case importPathComponentList
  case infixOperatorExpr
  case inheritanceClause
  case inheritedType
  case inheritedTypeList
  case initializerClause
  case initializerDecl
  case inOutExpr
  case integerLiteralExpr
  case isExpr
  case isTypePattern
  case keyPathComponent
  case keyPathComponentList
  case keyPathExpr
  case keyPathOptionalComponent
  case keyPathPropertyComponent
  case keyPathSubscriptComponent
  case labeledExpr
  case labeledExprList
  case labeledSpecializeArgument
  case labeledStmt
  case layoutRequirement
  case lifetimeSpecifierArgument
  case lifetimeSpecifierArgumentList
  case lifetimeTypeSpecifier
  case macroDecl
  case macroExpansionDecl
  case macroExpansionExpr
  case matchingPatternCondition
  case memberAccessExpr
  case memberBlock
  case memberBlockItem
  case memberBlockItemList
  case memberType
  case metatypeType
  case missing
  case missingDecl
  case missingExpr
  case missingPattern
  case missingStmt
  case missingType
  case multipleTrailingClosureElement
  case multipleTrailingClosureElementList
  case namedOpaqueReturnType
  case nilLiteralExpr
  case objCSelectorPiece
  case objCSelectorPieceList
  case opaqueReturnTypeOfAttributeArguments
  case operatorDecl
  case operatorPrecedenceAndTypes
  case optionalBindingCondition
  case optionalChainingExpr
  case optionalType
  case originallyDefinedInAttributeArguments
  case packElementExpr
  case packElementType
  case packExpansionExpr
  case packExpansionType
  case pattern
  case patternBinding
  case patternBindingList
  case patternExpr
  case platformVersion
  case platformVersionItem
  case platformVersionItemList
  case postfixIfConfigExpr
  case postfixOperatorExpr
  case poundSourceLocation
  case poundSourceLocationArguments
  case precedenceGroupAssignment
  case precedenceGroupAssociativity
  case precedenceGroupAttributeList
  case precedenceGroupDecl
  case precedenceGroupName
  case precedenceGroupNameList
  case precedenceGroupRelation
  case prefixOperatorExpr
  case primaryAssociatedType
  case primaryAssociatedTypeClause
  case primaryAssociatedTypeList
  case protocolDecl
  case regexLiteralExpr
  case repeatStmt
  case returnClause
  case returnStmt
  case sameTypeRequirement
  case sequenceExpr
  case simpleTypeSpecifier
  case simpleStringLiteralExpr
  case simpleStringLiteralSegmentList
  case someOrAnyType
  case sourceFile
  case specializeAttributeArgumentList
  case specializeAvailabilityArgument
  case specializeTargetFunctionArgument
  case stmt
  case stringLiteralExpr
  case stringLiteralSegmentList
  case stringSegment
  case structDecl
  case subscriptCallExpr
  case subscriptDecl
  case superExpr
  case suppressedType
  case switchCase
  case switchCaseItem
  case switchCaseItemList
  case switchCaseLabel
  case switchCaseList
  case switchDefaultLabel
  case switchExpr
  case ternaryExpr
  case thenStmt
  case throwsClause
  case throwStmt
  case tryExpr
  case tupleExpr
  case tuplePattern
  case tuplePatternElement
  case tuplePatternElementList
  case tupleType
  case tupleTypeElement
  case tupleTypeElementList
  case type
  case typeAliasDecl
  case typeAnnotation
  case typeEffectSpecifiers
  case typeExpr
  case typeInitializerClause
  case typeSpecifier
  case lifetimeSpecifierArguments
  case typeSpecifierList
  case unavailableFromAsyncAttributeArguments
  case underscorePrivateAttributeArguments
  case unexpectedNodes
  case unresolvedAsExpr
  case unresolvedIsExpr
  case unresolvedTernaryExpr
  case valueBindingPattern
  case variableDecl
  case versionComponent
  case versionComponentList
  case versionTuple
  case whereClause
  case whileStmt
  case wildcardPattern
  case yieldedExpression
  case yieldedExpressionList
  case yieldedExpressionsClause
  case yieldStmt

  // Nodes that have special handling throughout the codebase

  case syntax
  case syntaxCollection
  case token

  /// `true` if this is one of the `missing*` cases.
  public var isMissing: Bool {
    switch self {
    case .missingDecl, .missingExpr, .missingPattern, .missingStmt, .missing, .missingType:
      return true
    default:
      return false
    }
  }

  public var isBaseType: Bool {
    switch self {
    case .decl, .expr, .pattern, .stmt, .syntax, .syntaxCollection, .type:
      return true
    default:
      return false
    }
  }

  public var base: Self {
    switch self {
    case .accessorDecl, .actorDecl, .associatedTypeDecl, .classDecl, .deinitializerDecl, .editorPlaceholderDecl,
      .enumCaseDecl, .enumDecl, .extensionDecl, .functionDecl, .ifConfigDecl, .importDecl, .initializerDecl, .macroDecl,
      .macroExpansionDecl, .missingDecl, .operatorDecl, .poundSourceLocation, .precedenceGroupDecl, .protocolDecl,
      .structDecl, .subscriptDecl, .typeAliasDecl, .variableDecl:
      return .decl
    case ._canImportExpr, ._canImportVersionInfo, .arrayExpr, .arrowExpr, .asExpr, .assignmentExpr, .awaitExpr,
      .binaryOperatorExpr, .booleanLiteralExpr, .borrowExpr, .closureExpr, .consumeExpr, .copyExpr, .declReferenceExpr,
      .dictionaryExpr, .discardAssignmentExpr, .doExpr, .editorPlaceholderExpr, .floatLiteralExpr, .forceUnwrapExpr,
      .functionCallExpr, .genericSpecializationExpr, .ifExpr, .infixOperatorExpr, .inOutExpr, .integerLiteralExpr,
      .isExpr, .keyPathExpr, .macroExpansionExpr, .memberAccessExpr, .missingExpr, .nilLiteralExpr,
      .optionalChainingExpr, .packElementExpr, .packExpansionExpr, .patternExpr, .postfixIfConfigExpr,
      .postfixOperatorExpr, .prefixOperatorExpr, .regexLiteralExpr, .sequenceExpr, .simpleStringLiteralExpr,
      .stringLiteralExpr, .subscriptCallExpr, .superExpr, .switchExpr, .ternaryExpr, .tryExpr, .tupleExpr, .typeExpr,
      .unresolvedAsExpr, .unresolvedIsExpr, .unresolvedTernaryExpr:
      return .expr
    case .expressionPattern, .identifierPattern, .isTypePattern, .missingPattern, .tuplePattern, .valueBindingPattern,
      .wildcardPattern:
      return .pattern
    case .breakStmt, .continueStmt, .deferStmt, .discardStmt, .doStmt, .expressionStmt, .fallThroughStmt, .forStmt,
      .guardStmt, .labeledStmt, .missingStmt, .repeatStmt, .returnStmt, .thenStmt, .throwStmt, .whileStmt, .yieldStmt:
      return .stmt
    case .arrayType, .attributedType, .classRestrictionType, .compositionType, .dictionaryType, .functionType,
      .identifierType, .implicitlyUnwrappedOptionalType, .memberType, .metatypeType, .missingType,
      .namedOpaqueReturnType, .optionalType, .packElementType, .packExpansionType, .someOrAnyType, .suppressedType,
      .tupleType:
      return .type
    case .accessorDeclList, .arrayElementList, .attributeList, .availabilityArgumentList, .catchClauseList,
      .catchItemList, .closureCaptureList, .closureParameterList, .closureShorthandParameterList, .codeBlockItemList,
      .compositionTypeElementList, .conditionElementList, .declModifierList, .declNameArgumentList, .designatedTypeList,
      .dictionaryElementList, .differentiabilityArgumentList, .documentationAttributeArgumentList,
      .effectsAttributeArgumentList, .enumCaseElementList, .enumCaseParameterList, .exprList, .functionParameterList,
      .genericArgumentList, .genericParameterList, .genericRequirementList, .ifConfigClauseList,
      .importPathComponentList, .inheritedTypeList, .keyPathComponentList, .labeledExprList,
      .lifetimeSpecifierArgumentList, .memberBlockItemList, .multipleTrailingClosureElementList, .objCSelectorPieceList,
      .patternBindingList, .platformVersionItemList, .precedenceGroupAttributeList, .precedenceGroupNameList,
      .primaryAssociatedTypeList, .simpleStringLiteralSegmentList, .specializeAttributeArgumentList,
      .stringLiteralSegmentList, .switchCaseItemList, .switchCaseList, .tuplePatternElementList, .tupleTypeElementList,
      .typeSpecifierList, .unexpectedNodes, .versionComponentList, .yieldedExpressionList:
      return .syntaxCollection
    case .accessorBlock, .accessorEffectSpecifiers, .accessorParameters, .arrayElement, .attribute,
      .availabilityArgument, .availabilityCondition, .availabilityLabeledArgument, .backDeployedAttributeArguments,
      .catchClause, .catchItem, .closureCapture, .closureCaptureClause, .closureCaptureSpecifier, .closureParameter,
      .closureParameterClause, .closureShorthandParameter, .closureSignature, .codeBlock, .codeBlockItem,
      .compositionTypeElement, .conditionElement, .conformanceRequirement, .conventionAttributeArguments,
      .conventionWitnessMethodAttributeArguments, .decl, .declModifier, .declModifierDetail, .declNameArgument,
      .declNameArguments, .deinitializerEffectSpecifiers, .derivativeAttributeArguments, .designatedType,
      .dictionaryElement, .differentiabilityArgument, .differentiabilityArguments,
      .differentiabilityWithRespectToArgument, .differentiableAttributeArguments, .documentationAttributeArgument,
      .dynamicReplacementAttributeArguments, .enumCaseElement, .enumCaseParameter, .enumCaseParameterClause,
      .exposeAttributeArguments, .expr, .expressionSegment, .functionEffectSpecifiers, .functionParameter,
      .functionParameterClause, .functionSignature, .genericArgument, .genericArgumentClause, .genericParameter,
      .genericParameterClause, .genericRequirement, .genericWhereClause, .ifConfigClause, .implementsAttributeArguments,
      .importPathComponent, .inheritanceClause, .inheritedType, .initializerClause, .keyPathComponent,
      .keyPathOptionalComponent, .keyPathPropertyComponent, .keyPathSubscriptComponent, .labeledExpr,
      .labeledSpecializeArgument, .layoutRequirement, .lifetimeSpecifierArgument, .lifetimeTypeSpecifier,
      .matchingPatternCondition, .memberBlock, .memberBlockItem, .missing, .multipleTrailingClosureElement,
      .objCSelectorPiece, .opaqueReturnTypeOfAttributeArguments, .operatorPrecedenceAndTypes, .optionalBindingCondition,
      .originallyDefinedInAttributeArguments, .pattern, .patternBinding, .platformVersion, .platformVersionItem,
      .poundSourceLocationArguments, .precedenceGroupAssignment, .precedenceGroupAssociativity, .precedenceGroupName,
      .precedenceGroupRelation, .primaryAssociatedType, .primaryAssociatedTypeClause, .returnClause,
      .sameTypeRequirement, .simpleTypeSpecifier, .sourceFile, .specializeAvailabilityArgument,
      .specializeTargetFunctionArgument, .stmt, .stringSegment, .switchCase, .switchCaseItem, .switchCaseLabel,
      .switchDefaultLabel, .throwsClause, .tuplePatternElement, .tupleTypeElement, .type, .typeAnnotation,
      .typeEffectSpecifiers, .typeInitializerClause, .typeSpecifier, .lifetimeSpecifierArguments,
      .unavailableFromAsyncAttributeArguments, .underscorePrivateAttributeArguments, .versionComponent, .versionTuple,
      .whereClause, .yieldedExpression, .yieldedExpressionsClause:
      return .syntax
    case .syntax, .syntaxCollection, .token:
      return .syntax
    }
  }

  public var identifier: TokenSyntax {
    return .identifier(self.rawValue)
  }

  public var syntaxType: TypeSyntax {
    switch self {
    case .syntax:
      return "Syntax"
    case .syntaxCollection:
      return "SyntaxCollection"
    default:
      return "\(raw: self.nameInProperCase)Syntax"
    }
  }

  public func doccLink(content: String) -> String {
    if self.node?.isExperimental == true || self.isDeprecated {
      return "`\(content)`"
    } else {
      return "``\(content)``"
    }
  }

  public var protocolType: TypeSyntax {
    return "\(self.syntaxType)Protocol"
  }

  /// For base node types, generates the name of the protocol to which all
  /// concrete leaf nodes that derive from this base kind should conform.
  ///
  /// - Warning: This property can only be accessed for base node kinds; attempting to
  /// access it for a non-base kind will result in a runtime error.
  public var leafProtocolType: TypeSyntax {
    if self.isBaseType {
      return "_Leaf\(self.syntaxType)NodeProtocol"
    } else {
      fatalError("Only base kind can define leaf protocol")
    }
  }

  /// If the syntax kind has been renamed, the previous raw value that is now
  /// deprecated.
  public var deprecatedRawValue: String? {
    switch self {
    case ._canImportExpr: return "canImportExpr"
    case ._canImportVersionInfo: return "canImportVersionInfo"
    case .accessorDeclList: return "accessorList"
    case .accessorParameters: return "accessorParameter"
    case .associatedTypeDecl: return "associatedtypeDecl"
    case .availabilityArgumentList: return "availabilitySpecList"
    case .backDeployedAttributeArguments: return "backDeployedAttributeSpecList"
    case .closureCapture: return "closureCaptureItem"
    case .closureCaptureClause: return "closureCaptureSignature"
    case .closureCaptureList: return "closureCaptureItemList"
    case .closureCaptureSpecifier: return "closureCaptureItemSpecifier"
    case .closureShorthandParameter: return "closureParam"
    case .closureShorthandParameterList: return "closureParamList"
    case .consumeExpr: return "moveExpr"
    case .declModifierList: return "modifierList"
    case .declReferenceExpr: return "identifierExpr"
    case .deinitializerEffectSpecifiers: return "deinitEffectSpecifiers"
    case .derivativeAttributeArguments: return "derivativeRegistrationAttributeArguments"
    case .designatedType: return "designatedTypeElement"
    case .differentiabilityArgument: return "differentiabilityParam"
    case .differentiabilityArgumentList: return "differentiabilityParamList"
    case .differentiabilityArguments: return "differentiabilityParams"
    case .differentiabilityWithRespectToArgument: return "differentiabilityParamsClause"
    case .documentationAttributeArgumentList: return "documentationAttributeArguments"
    case .dynamicReplacementAttributeArguments: return "dynamicReplacementArguments"
    case .effectsAttributeArgumentList: return "effectsArguments"
    case .enumCaseParameterClause: return "enumCaseAssociatedValue"
    case .fallThroughStmt: return "fallthroughStmt"
    case .forceUnwrapExpr: return "forcedValueExpr"
    case .forStmt: return "forInStmt"
    case .functionParameterClause: return "parameterClause"
    case .genericSpecializationExpr: return "specializeExpr"
    case .identifierType: return "simpleTypeIdentifier"
    case .importPathComponent: return "accessPathComponent"
    case .importPathComponentList: return "accessPath"
    case .inheritanceClause: return "typeInheritanceClause"
    case .labeledExpr: return "tupleExprElement"
    case .labeledExprList: return "tupleExprElementList"
    case .labeledSpecializeArgument: return "labeledSpecializeEntry"
    case .memberBlock: return "memberDeclBlock"
    case .memberBlockItem: return "memberDeclListItem"
    case .memberBlockItemList: return "memberDeclList"
    case .memberType: return "memberTypeIdentifier"
    case .objCSelectorPieceList: return "objCSelector"
    case .originallyDefinedInAttributeArguments: return "originallyDefinedInArguments"
    case .packElementType: return "packReferenceType"
    case .patternExpr: return "unresolvedPatternExpr"
    case .platformVersion: return "availabilityVersionRestriction"
    case .platformVersionItem: return "availabilityVersionRestrictionListEntry"
    case .platformVersionItemList: return "availabilityVersionRestrictionList"
    case .postfixOperatorExpr: return "postfixUnaryExpr"
    case .poundSourceLocationArguments: return "poundSourceLocationArgs"
    case .precedenceGroupName: return "precedenceGroupNameElement"
    case .repeatStmt: return "repeatWhileStmt"
    case .someOrAnyType: return "constrainedSugarType"
    case .simpleTypeSpecifier: return "typeSpecifier"
    case .specializeAttributeArgumentList: return "specializeAttributeSpecList"
    case .specializeAvailabilityArgument: return "availabilityEntry"
    case .specializeTargetFunctionArgument: return "targetFunctionEntry"
    case .stringLiteralSegmentList: return "stringLiteralSegments"
    case .subscriptCallExpr: return "subscriptExpr"
    case .superExpr: return "superRefExpr"
    case .switchCaseItem: return "caseItem"
    case .switchCaseItemList: return "caseItemList"
    case .typeAliasDecl: return "typealiasDecl"
    case .unavailableFromAsyncAttributeArguments: return "unavailableFromAsyncArguments"
    case .yieldedExpression: return "yieldExprListElement"
    case .yieldedExpressionList: return "yieldExprList"
    case .yieldedExpressionsClause: return "yieldList"
    default: return nil
    }
  }

  public var deprecationMessage: String? {
    switch self {
    case ._canImportExpr: return "'canImport' directives are now represented as a `FunctionCallExpr`"
    case ._canImportVersionInfo: return "'canImport' directives are now represented as a `FunctionCallExpr`"
    default: return nil
    }
  }

  var deprecationAttribute: AttributeSyntax? {
    if let deprecationMessage {
      AttributeSyntax("@available(*, deprecated, message: \(literal: deprecationMessage)")
    } else {
      AttributeSyntax(#"@available(*, deprecated, renamed: "\#(self.syntaxType)")"#)
    }
  }

  public var nonRaw: Self {
    self
  }
}

public extension SyntaxNodeKindProtocol where NonRaw == SyntaxNodeKind {
  /// The ``Node`` representation of this kind, if any.
  var node: Node? {
    SYNTAX_NODE_MAP[self.nonRaw]
  }

  var nameInProperCase: String {
    self.nonRaw.rawValue.withFirstCharacterUppercased
  }

  var isDeprecated: Bool {
    self.nonRaw.rawValue.first == "_"
  }
}
