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

  case accessesEffect
  case accessorBlock
  case accessorDecl
  case accessorEffectSpecifiers
  case accessorInitEffects
  case accessorDeclList
  case accessorParameters
  case actorDecl
  case arrayElementList
  case arrayElement
  case arrayExpr
  case arrayType
  case unresolvedArrowExpr
  case asExpr
  case assignmentExpr
  case associatedTypeDecl
  case attributeList
  case attribute
  case attributedType
  case availabilityArgument
  case availabilityCondition
  case availabilityLabeledArgument
  case availabilityArgumentList
  case platformVersionItem
  case platformVersionItemList
  case platformVersion
  case awaitExpr
  case backDeployedAttributeArguments
  case unresolvedInfixOperatorExpr
  case booleanLiteralExpr
  case borrowExpr
  case breakStmt
  case canImportExpr
  case canImportVersionInfo
  case switchCaseItemList
  case switchCaseItem
  case catchClauseList
  case catchClause
  case catchItemList
  case catchItem
  case classDecl
  case classRestrictionType
  case closureCaptureList
  case closureCaptureSpecifier
  case closureCapture
  case closureCaptureClause
  case closureExpr
  case closureShorthandParameterList
  case closureShorthandParameter
  case closureParameterClause
  case closureParameterList
  case closureParameter
  case closureSignature
  case codeBlockItemList
  case codeBlockItem
  case codeBlock
  case compositionTypeElementList
  case compositionTypeElement
  case compositionType
  case conditionElementList
  case conditionElement
  case conformanceRequirement
  case someOrAnyType
  case continueStmt
  case conventionAttributeArguments
  case conventionWitnessMethodAttributeArguments
  case copyExpr
  case declModifierDetail
  case declModifier
  case declNameArgumentList
  case declNameArgument
  case declNameArguments
  case declName
  case decl
  case deferStmt
  case deinitializerEffectSpecifiers
  case deinitializerDecl
  case derivativeAttributeArguments
  case designatedType
  case designatedTypeList
  case dictionaryElementList
  case dictionaryElement
  case dictionaryExpr
  case dictionaryType
  case differentiabilityParameterList
  case differentiabilityArgument
  case differentiabilityWithRespectToArgument
  case differentiabilityArguments
  case differentiableAttributeArguments
  case discardAssignmentExpr
  case discardStmt
  case doStmt
  case documentationAttributeArgument
  case documentationAttributeArgumentList
  case dynamicReplacementAttributeArguments
  case editorPlaceholderDecl
  case editorPlaceholderExpr
  case effectsAttributeArgumentList
  case enumCaseDecl
  case enumCaseElementList
  case enumCaseElement
  case enumCaseParameterClause
  case enumCaseParameterList
  case enumCaseParameter
  case enumDecl
  case exposeAttributeArguments
  case exprList
  case expr
  case exprPattern
  case exprSegment
  case expressionStmt
  case extensionDecl
  case fallThroughtStmt
  case floatLiteralExpr
  case forStmt
  case forceUnwrapExpr
  case functionCallExpr
  case functionDecl
  case functionEffectSpecifiers
  case functionParameterList
  case functionParameter
  case functionSignature
  case functionType
  case genericArgumentClause
  case genericArgumentList
  case genericArgument
  case genericParameterClause
  case genericParameterList
  case genericParameter
  case genericRequirementList
  case genericRequirement
  case genericWhereClause
  case guardStmt
  case identifierExpr
  case identifierPattern
  case ifConfigClauseList
  case ifConfigClause
  case ifConfigDecl
  case ifExpr
  case implementsAttributeArguments
  case implicitlyUnwrappedOptionalType
  case importDecl
  case importPathComponent
  case importPathComponentList
  case inOutExpr
  case infixOperatorExpr
  case inheritedTypeList
  case inheritedType
  case initializerClause
  case initializerDecl
  case initializesEffect
  case integerLiteralExpr
  case isExpr
  case isTypePattern
  case keyPathComponentList
  case keyPathComponent
  case keyPathExpr
  case keyPathOptionalComponent
  case keyPathPropertyComponent
  case keyPathSubscriptComponent
  case labeledSpecializeArgument
  case labeledStmt
  case layoutRequirement
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
  case missingDecl
  case missingExpr
  case missingPattern
  case missingStmt
  case missing
  case missingType
  case declModifierList
  case consumeExpr
  case multipleTrailingClosureElementList
  case multipleTrailingClosureElement
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
  case packExpansionExpr
  case packExpansionType
  case packElementType
  case functionParameterClause
  case patternBindingList
  case patternBinding
  case pattern
  case postfixIfConfigExpr
  case postfixOperatorExpr
  case poundSourceLocationArguments
  case poundSourceLocation
  case precedenceGroupAssignment
  case precedenceGroupAssociativity
  case precedenceGroupAttributeList
  case precedenceGroupDecl
  case precedenceGroupName
  case precedenceGroupNameList
  case precedenceGroupRelation
  case prefixOperatorExpr
  case primaryAssociatedTypeClause
  case primaryAssociatedTypeList
  case primaryAssociatedType
  case protocolDecl
  case qualifiedDeclName
  case regexLiteralExpr
  case repeatStmt
  case returnClause
  case returnStmt
  case sameTypeRequirement
  case sequenceExpr
  case identifierType
  case sourceFile
  case specializeAttributeArgumentList
  case specializeAvailabilityArgument
  case genericSpecializationExpr
  case stmt
  case stringLiteralExpr
  case stringLiteralSegmentList
  case stringSegment
  case structDecl
  case subscriptDecl
  case subscriptCallExpr
  case superExpr
  case suppressedType
  case switchCaseLabel
  case switchCaseList
  case switchCase
  case switchDefaultLabel
  case switchExpr
  case specializeTargetFunctionArgument
  case ternaryExpr
  case throwStmt
  case tryExpr
  case tupleExprElementList
  case tupleExprElement
  case tupleExpr
  case tuplePatternElementList
  case tuplePatternElement
  case tuplePattern
  case tupleTypeElementList
  case tupleTypeElement
  case tupleType
  case typeAnnotation
  case typeEffectSpecifiers
  case typeExpr
  case inheritanceClause
  case typeInitializerClause
  case type
  case typeAliasDecl
  case unavailableFromAsyncAttributeArguments
  case underscorePrivateAttributeArguments
  case unexpectedNodes
  case unresolvedAsExpr
  case unresolvedIsExpr
  case patternExpr
  case unresolvedTernaryExpr
  case valueBindingPattern
  case variableDecl
  case versionComponentList
  case versionComponent
  case versionTuple
  case whereClause
  case whileStmt
  case wildcardPattern
  case yieldStmtArgument
  case yieldStmtArgumentList
  case yieldStmtArgumentClause
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

  /// If the syntax kind has been renamed, the previous raw value that is now
  /// deprecated.
  public var deprecatedRawValue: String? {
    switch self {
    case .memberBlock: return "memberDeclBlock"
    case .memberBlockItemList: return "memberDeclList"
    case .memberBlockItem: return "memberDeclListItem"
    case .packElementType: return "packReferenceType"
    case .functionParameterClause: return "parameterClause"
    case .associatedTypeDecl: return "associatedtypeDecl"
    case .enumCaseParameterClause: return "enumCaseAssociatedValue"
    case .closureShorthandParameterList: return "closureParamList"
    case .closureShorthandParameter: return "closureParam"
    case .accessorDeclList: return "accessorList"
    case .importPathComponentList: return "accessPath"
    case .importPathComponent: return "accessPathComponent"
    case .documentationAttributeArgumentList: return "documentationAttributeArguments"
    case .effectsAttributeArgumentList: return "effectsArguments"
    case .objCSelectorPieceList: return "objCSelector"
    case .stringLiteralSegmentList: return "stringLiteralSegments"
    case .accessorParameters: return "accessorParameter"
    case .specializeAvailabilityArgument: return "availabilityEntry"
    case .availabilityArgumentList: return "availabilitySpecList"
    case .backDeployedAttributeArguments: return "backDeployedAttributeSpecList"
    case .deinitializerEffectSpecifiers: return "deinitEffectSpecifiers"
    case .derivativeAttributeArguments: return "derivativeRegistrationAttributeArguments"
    case .differentiabilityParameterList: return "differentiabilityParamList"
    case .differentiabilityWithRespectToArgument: return "differentiabilityParamsClause"
    case .differentiabilityArguments: return "differentiabilityParams"
    case .differentiabilityArgument: return "differentiabilityParam"
    case .dynamicReplacementAttributeArguments: return "dynamicReplacementArguments"
    case .exprPattern: return "expressionPattern"
    case .exprSegment: return "expressionSegment"
    case .forceUnwrapExpr: return "forcedValueExpr"
    case .forStmt: return "forInStmt"
    case .labeledSpecializeArgument: return "labeledSpecializeEntry"
    case .memberType: return "memberTypeIdentifier"
    case .declModifierList: return "modifierList"
    case .consumeExpr: return "moveExpr"
    case .originallyDefinedInAttributeArguments: return "originallyDefinedInArguments"
    case .postfixOperatorExpr: return "postfixUnaryExpr"
    case .poundSourceLocationArguments: return "poundSourceLocationArgs"
    case .precedenceGroupName: return "precedenceGroupNameElement"
    case .repeatStmt: return "repeatWhileStmt"
    case .identifierType: return "simpleTypeIdentifier"
    case .specializeAttributeArgumentList: return "specializeAttributeSpecList"
    case .genericSpecializationExpr: return "specializeExpr"
    case .superExpr: return "superRefExpr"
    case .specializeTargetFunctionArgument: return "targetFunctionEntry"
    case .inheritanceClause: return "typeInheritanceClause"
    case .unavailableFromAsyncAttributeArguments: return "unavailableFromAsyncArguments"
    case .yieldStmtArgument: return "yieldExprListElement"
    case .yieldStmtArgumentList: return "yieldExprList"
    case .yieldStmtArgumentClause: return "yieldList"
    case .unresolvedArrowExpr: return "arrowExpr"
    case .platformVersionItem: return " availabilityVersionRestrictionListEntry"
    case .platformVersionItemList: return "availabilityVersionRestrictionList"
    case .platformVersion: return "availabilityVersionRestriction"
    case .switchCaseItemList: return "caseItemList"
    case .switchCaseItem: return "caseItem"
    case .closureCaptureClause: return "closureCaptureSignature"
    case .designatedType: return "designatedTypeElement"
    case .fallThroughtStmt: return "fallthroughStmt"
    case .patternExpr: return "unresolvedPatternExpr"
    case .subscriptCallExpr: return "subscriptExpr"
    case .unresolvedInfixOperatorExpr: return "binaryOperatorExpr"
    case .typeAliasDecl: return "typealiasDecl"
    case .closureCaptureList: return "closureCaptureItemList"
    case .closureCaptureSpecifier: return "closureCaptureItemSpecifier"
    case .closureCapture: return "closureCaptureItem"
    case .someOrAnyType: return "constrainedSugarType"
    default: return nil
    }
  }
}
