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
  case accessorList
  case accessorParameter
  case actorDecl
  case arrayElementList
  case arrayElement
  case arrayExpr
  case arrayType
  case arrowExpr
  case asExpr
  case assignmentExpr
  case associatedtypeDecl
  case attributeList
  case attribute
  case attributedType
  case availabilityArgument
  case availabilityCondition
  case availabilityEntry
  case availabilityLabeledArgument
  case availabilitySpecList
  case availabilityVersionRestrictionListEntry
  case availabilityVersionRestrictionList
  case availabilityVersionRestriction
  case awaitExpr
  case backDeployedAttributeSpecList
  case binaryOperatorExpr
  case booleanLiteralExpr
  case borrowExpr
  case breakStmt
  case canImportExpr
  case canImportVersionInfo
  case caseItemList
  case caseItem
  case catchClauseList
  case catchClause
  case catchItemList
  case catchItem
  case classDecl
  case classRestrictionType
  case closureCaptureItemList
  case closureCaptureItemSpecifier
  case closureCaptureItem
  case closureCaptureSignature
  case closureExpr
  case closureParamList
  case closureParam
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
  case constrainedSugarType
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
  case deinitEffectSpecifiers
  case deinitializerDecl
  case derivativeRegistrationAttributeArguments
  case designatedTypeElement
  case designatedTypeList
  case dictionaryElementList
  case dictionaryElement
  case dictionaryExpr
  case dictionaryType
  case differentiabilityParamList
  case differentiabilityParam
  case differentiabilityParamsClause
  case differentiabilityParams
  case differentiableAttributeArguments
  case discardAssignmentExpr
  case discardStmt
  case doStmt
  case documentationAttributeArgument
  case documentationAttributeArguments
  case dynamicReplacementArguments
  case editorPlaceholderDecl
  case editorPlaceholderExpr
  case effectsArguments
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
  case expressionPattern
  case expressionSegment
  case expressionStmt
  case extensionDecl
  case fallthroughStmt
  case floatLiteralExpr
  case forInStmt
  case forcedValueExpr
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
  case importPath
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
  case labeledSpecializeEntry
  case labeledStmt
  case layoutRequirement
  case macroDecl
  case macroExpansionDecl
  case macroExpansionExpr
  case matchingPatternCondition
  case memberAccessExpr
  case memberDeclBlock
  case memberDeclListItem
  case memberDeclList
  case memberTypeIdentifier
  case metatypeType
  case missingDecl
  case missingExpr
  case missingPattern
  case missingStmt
  case missing
  case missingType
  case modifierList
  case moveExpr
  case multipleTrailingClosureElementList
  case multipleTrailingClosureElement
  case namedOpaqueReturnType
  case nilLiteralExpr
  case objCSelectorPiece
  case objCSelector
  case opaqueReturnTypeOfAttributeArguments
  case operatorDecl
  case operatorPrecedenceAndTypes
  case optionalBindingCondition
  case optionalChainingExpr
  case optionalType
  case originallyDefinedInArguments
  case packElementExpr
  case packExpansionExpr
  case packExpansionType
  case packReferenceType
  case parameterClause
  case patternBindingList
  case patternBinding
  case pattern
  case postfixIfConfigExpr
  case postfixUnaryExpr
  case poundSourceLocationArgs
  case poundSourceLocation
  case precedenceGroupAssignment
  case precedenceGroupAssociativity
  case precedenceGroupAttributeList
  case precedenceGroupDecl
  case precedenceGroupNameElement
  case precedenceGroupNameList
  case precedenceGroupRelation
  case prefixOperatorExpr
  case primaryAssociatedTypeClause
  case primaryAssociatedTypeList
  case primaryAssociatedType
  case protocolDecl
  case qualifiedDeclName
  case regexLiteralExpr
  case repeatWhileStmt
  case returnClause
  case returnStmt
  case sameTypeRequirement
  case sequenceExpr
  case simpleTypeIdentifier
  case sourceFile
  case specializeAttributeSpecList
  case specializeExpr
  case stmt
  case stringLiteralExpr
  case stringLiteralSegments
  case stringSegment
  case structDecl
  case subscriptDecl
  case subscriptExpr
  case superRefExpr
  case suppressedType
  case switchCaseLabel
  case switchCaseList
  case switchCase
  case switchDefaultLabel
  case switchExpr
  case targetFunctionEntry
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
  case typeInheritanceClause
  case typeInitializerClause
  case type
  case typealiasDecl
  case unavailableFromAsyncArguments
  case underscorePrivateAttributeArguments
  case unexpectedNodes
  case unresolvedAsExpr
  case unresolvedIsExpr
  case unresolvedPatternExpr
  case unresolvedTernaryExpr
  case valueBindingPattern
  case variableDecl
  case versionComponentList
  case versionComponent
  case versionTuple
  case whereClause
  case whileStmt
  case wildcardPattern
  case yieldExprListElement
  case yieldExprList
  case yieldList
  case yieldStmt

  // Nodes that have special handling throught the codebase

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
}
