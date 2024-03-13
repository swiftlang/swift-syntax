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
public enum SyntaxNodeKind: String, CaseIterable {
  // Please keep this list sorted alphabetically

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
  case canImportExpr
  case canImportVersionInfo
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

  /// Whether this is one of the syntax base nodes.
  public var isBase: Bool {
    switch self {
    case .decl, .expr, .pattern, .stmt, .syntax, .syntaxCollection, .type:
      return true
    default:
      return false
    }
  }

  /// A name for this node that is suitable to be used as a variables or enum
  /// case's name.
  public var varOrCaseName: TokenSyntax {
    return .identifier(rawValue)
  }

  /// The type name of this node in the SwiftSyntax module.
  public var syntaxType: TypeSyntax {
    switch self {
    case .syntax:
      return "Syntax"
    case .syntaxCollection:
      return "SyntaxCollection"
    default:
      return "\(raw: rawValue.withFirstCharacterUppercased)Syntax"
    }
  }

  /// If this node is non-experimental a docc link wrapped in two backticks.
  ///
  /// For experimental nodes, the node's type name in code font.
  public var doccLink: String {
    if let node = SYNTAX_NODE_MAP[self], node.isExperimental {
      return "`\(syntaxType)`"
    } else {
      return "``\(syntaxType)``"
    }
  }

  /// For base nodes, the name of the corresponding protocol to which all the
  /// concrete nodes that have this base kind, conform.
  public var protocolType: TypeSyntax {
    return "\(syntaxType)Protocol"
  }

  /// The name of this node at the `RawSyntax` level.
  public var rawType: TypeSyntax {
    return "Raw\(syntaxType)"
  }

  /// For base nodes, the name of the corresponding raw protocol to which all the
  /// concrete raw nodes that have this base kind, conform.
  public var rawProtocolType: TypeSyntax {
    switch self {
    case .syntax, .syntaxCollection:
      return "RawSyntaxNodeProtocol"
    default:
      return "Raw\(raw: rawValue.withFirstCharacterUppercased)SyntaxNodeProtocol"
    }
  }

  /// For base node types, generates the name of the protocol to which all
  /// concrete leaf nodes that derive from this base kind should conform.
  ///
  /// - Warning: This property can only be accessed for base node kinds; attempting to
  /// access it for a non-base kind will result in a runtime error.
  public var leafProtocolType: TypeSyntax {
    if isBase {
      return "_Leaf\(syntaxType)NodeProtocol"
    } else {
      fatalError("Only base kind can define leaf protocol")
    }
  }

  /// If the syntax kind has been renamed, the previous raw value that is now
  /// deprecated.
  public var deprecatedRawValue: String? {
    switch self {
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
}
