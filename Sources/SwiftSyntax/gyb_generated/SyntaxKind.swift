//// Automatically Generated From SyntaxKind.swift.gyb.
//// Do Not Edit Directly!
//===--------------- SyntaxKind.swift - Syntax Kind definitions -----------===//
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

/// Enumerates the known kinds of Syntax represented in the Syntax tree.
public enum SyntaxKind {
  case token
  case unknown
  case unknownDecl
  case unknownExpr
  case unknownStmt
  case unknownType
  case unknownPattern
  case missing
  case missingDecl
  case missingExpr
  case missingStmt
  case missingType
  case missingPattern
  case codeBlockItem
  case codeBlockItemList
  case codeBlock
  case unexpectedNodes
  case inOutExpr
  case poundColumnExpr
  case tupleExprElementList
  case arrayElementList
  case dictionaryElementList
  case stringLiteralSegments
  case tryExpr
  case awaitExpr
  case moveExpr
  case declNameArgument
  case declNameArgumentList
  case declNameArguments
  case identifierExpr
  case superRefExpr
  case nilLiteralExpr
  case discardAssignmentExpr
  case assignmentExpr
  case sequenceExpr
  case exprList
  case poundLineExpr
  case poundFileExpr
  case poundFileIDExpr
  case poundFilePathExpr
  case poundFunctionExpr
  case poundDsohandleExpr
  case symbolicReferenceExpr
  case prefixOperatorExpr
  case binaryOperatorExpr
  case arrowExpr
  case infixOperatorExpr
  case floatLiteralExpr
  case tupleExpr
  case arrayExpr
  case dictionaryExpr
  case tupleExprElement
  case arrayElement
  case dictionaryElement
  case integerLiteralExpr
  case booleanLiteralExpr
  case unresolvedTernaryExpr
  case ternaryExpr
  case memberAccessExpr
  case unresolvedIsExpr
  case isExpr
  case unresolvedAsExpr
  case asExpr
  case typeExpr
  case closureCaptureItem
  case closureCaptureItemList
  case closureCaptureSignature
  case closureParam
  case closureParamList
  case closureSignature
  case closureExpr
  case unresolvedPatternExpr
  case multipleTrailingClosureElement
  case multipleTrailingClosureElementList
  case functionCallExpr
  case subscriptExpr
  case optionalChainingExpr
  case forcedValueExpr
  case postfixUnaryExpr
  case specializeExpr
  case stringSegment
  case expressionSegment
  case stringLiteralExpr
  case regexLiteralExpr
  case keyPathExpr
  case keyPathComponentList
  case keyPathComponent
  case keyPathPropertyComponent
  case keyPathSubscriptComponent
  case keyPathOptionalComponent
  case oldKeyPathExpr
  case keyPathBaseExpr
  case objcNamePiece
  case objcName
  case objcKeyPathExpr
  case objcSelectorExpr
  case macroExpansionExpr
  case postfixIfConfigExpr
  case editorPlaceholderExpr
  case objectLiteralExpr
  case yieldExprList
  case yieldExprListElement
  case typeInitializerClause
  case typealiasDecl
  case associatedtypeDecl
  case functionParameterList
  case parameterClause
  case returnClause
  case functionSignature
  case ifConfigClause
  case ifConfigClauseList
  case ifConfigDecl
  case poundErrorDecl
  case poundWarningDecl
  case poundSourceLocation
  case poundSourceLocationArgs
  case declModifierDetail
  case declModifier
  case inheritedType
  case inheritedTypeList
  case typeInheritanceClause
  case classDecl
  case actorDecl
  case structDecl
  case protocolDecl
  case extensionDecl
  case memberDeclBlock
  case memberDeclList
  case memberDeclListItem
  case sourceFile
  case initializerClause
  case functionParameter
  case modifierList
  case functionDecl
  case initializerDecl
  case deinitializerDecl
  case subscriptDecl
  case accessLevelModifier
  case accessPathComponent
  case accessPath
  case importDecl
  case accessorParameter
  case accessorDecl
  case accessorList
  case accessorBlock
  case patternBinding
  case patternBindingList
  case variableDecl
  case enumCaseElement
  case enumCaseElementList
  case enumCaseDecl
  case enumDecl
  case operatorDecl
  case designatedTypeList
  case designatedTypeElement
  case operatorPrecedenceAndTypes
  case precedenceGroupDecl
  case precedenceGroupAttributeList
  case precedenceGroupRelation
  case precedenceGroupNameList
  case precedenceGroupNameElement
  case precedenceGroupAssignment
  case precedenceGroupAssociativity
  case macroExpansionDecl
  case tokenList
  case nonEmptyTokenList
  case customAttribute
  case attribute
  case attributeList
  case specializeAttributeSpecList
  case availabilityEntry
  case labeledSpecializeEntry
  case targetFunctionEntry
  case namedAttributeStringArgument
  case declName
  case implementsAttributeArguments
  case objCSelectorPiece
  case objCSelector
  case differentiableAttributeArguments
  case differentiabilityParamsClause
  case differentiabilityParams
  case differentiabilityParamList
  case differentiabilityParam
  case derivativeRegistrationAttributeArguments
  case qualifiedDeclName
  case functionDeclName
  case backDeployAttributeSpecList
  case backDeployVersionList
  case backDeployVersionArgument
  case opaqueReturnTypeOfAttributeArguments
  case conventionAttributeArguments
  case conventionWitnessMethodAttributeArguments
  case labeledStmt
  case continueStmt
  case whileStmt
  case deferStmt
  case expressionStmt
  case switchCaseList
  case repeatWhileStmt
  case guardStmt
  case whereClause
  case forInStmt
  case switchStmt
  case catchClauseList
  case doStmt
  case returnStmt
  case yieldStmt
  case yieldList
  case fallthroughStmt
  case breakStmt
  case caseItemList
  case catchItemList
  case conditionElement
  case availabilityCondition
  case matchingPatternCondition
  case optionalBindingCondition
  case unavailabilityCondition
  case hasSymbolCondition
  case conditionElementList
  case declarationStmt
  case throwStmt
  case ifStmt
  case switchCase
  case switchDefaultLabel
  case caseItem
  case catchItem
  case switchCaseLabel
  case catchClause
  case poundAssertStmt
  case genericWhereClause
  case genericRequirementList
  case genericRequirement
  case sameTypeRequirement
  case layoutRequirement
  case genericParameterList
  case genericParameter
  case primaryAssociatedTypeList
  case primaryAssociatedType
  case genericParameterClause
  case conformanceRequirement
  case primaryAssociatedTypeClause
  case simpleTypeIdentifier
  case memberTypeIdentifier
  case classRestrictionType
  case arrayType
  case dictionaryType
  case metatypeType
  case optionalType
  case constrainedSugarType
  case implicitlyUnwrappedOptionalType
  case compositionTypeElement
  case compositionTypeElementList
  case compositionType
  case packExpansionType
  case tupleTypeElement
  case tupleTypeElementList
  case tupleType
  case functionType
  case attributedType
  case genericArgumentList
  case genericArgument
  case genericArgumentClause
  case namedOpaqueReturnType
  case typeAnnotation
  case enumCasePattern
  case isTypePattern
  case optionalPattern
  case identifierPattern
  case asTypePattern
  case tuplePattern
  case wildcardPattern
  case tuplePatternElement
  case expressionPattern
  case tuplePatternElementList
  case valueBindingPattern
  case availabilitySpecList
  case availabilityArgument
  case availabilityLabeledArgument
  case availabilityVersionRestriction
  case versionTuple

  public var isSyntaxCollection: Bool {
    switch self {
    case .codeBlockItemList: return true
    case .unexpectedNodes: return true
    case .tupleExprElementList: return true
    case .arrayElementList: return true
    case .dictionaryElementList: return true
    case .stringLiteralSegments: return true
    case .declNameArgumentList: return true
    case .exprList: return true
    case .closureCaptureItemList: return true
    case .closureParamList: return true
    case .multipleTrailingClosureElementList: return true
    case .keyPathComponentList: return true
    case .objcName: return true
    case .yieldExprList: return true
    case .functionParameterList: return true
    case .ifConfigClauseList: return true
    case .inheritedTypeList: return true
    case .memberDeclList: return true
    case .modifierList: return true
    case .accessPath: return true
    case .accessorList: return true
    case .patternBindingList: return true
    case .enumCaseElementList: return true
    case .designatedTypeList: return true
    case .precedenceGroupAttributeList: return true
    case .precedenceGroupNameList: return true
    case .tokenList: return true
    case .nonEmptyTokenList: return true
    case .attributeList: return true
    case .specializeAttributeSpecList: return true
    case .objCSelector: return true
    case .differentiabilityParamList: return true
    case .backDeployVersionList: return true
    case .switchCaseList: return true
    case .catchClauseList: return true
    case .caseItemList: return true
    case .catchItemList: return true
    case .conditionElementList: return true
    case .genericRequirementList: return true
    case .genericParameterList: return true
    case .primaryAssociatedTypeList: return true
    case .compositionTypeElementList: return true
    case .tupleTypeElementList: return true
    case .genericArgumentList: return true
    case .tuplePatternElementList: return true
    case .availabilitySpecList: return true
    case .unknown: return true
    default: return false
    }
  }

  public var isUnknown: Bool {
    switch self {
    case .unknownDecl: return true
    case .unknownExpr: return true
    case .unknownPattern: return true
    case .unknownStmt: return true
    case .unknownType: return true
    case .unknown: return true
    default: return false
    }
  }

  public var isMissing: Bool {
    switch self {
    case .missingDecl: return true
    case .missingExpr: return true
    case .missingPattern: return true
    case .missingStmt: return true
    case .missingType: return true
    case .missing: return true
    default: return false
    }
  }
}
