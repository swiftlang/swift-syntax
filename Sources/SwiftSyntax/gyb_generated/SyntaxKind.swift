//// Automatically Generated From SyntaxKind.swift.gyb.
//// Do Not Edit Directly!
//===--------------- SyntaxKind.swift - Syntax Kind definitions -----------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

/// Enumerates the known kinds of Syntax represented in the Syntax tree.
internal enum SyntaxKind: String, Codable {
  case token = "Token"
  case unknown = "Unknown"
  case decl = "Decl"
  case expr = "Expr"
  case stmt = "Stmt"
  case type = "Type"
  case pattern = "Pattern"
  case unknownDecl = "UnknownDecl"
  case unknownExpr = "UnknownExpr"
  case unknownStmt = "UnknownStmt"
  case unknownType = "UnknownType"
  case unknownPattern = "UnknownPattern"
  case codeBlockItem = "CodeBlockItem"
  case codeBlockItemList = "CodeBlockItemList"
  case codeBlock = "CodeBlock"
  case inOutExpr = "InOutExpr"
  case poundColumnExpr = "PoundColumnExpr"
  case functionCallArgumentList = "FunctionCallArgumentList"
  case tupleElementList = "TupleElementList"
  case arrayElementList = "ArrayElementList"
  case dictionaryElementList = "DictionaryElementList"
  case stringInterpolationSegments = "StringInterpolationSegments"
  case tryExpr = "TryExpr"
  case declNameArgument = "DeclNameArgument"
  case declNameArgumentList = "DeclNameArgumentList"
  case declNameArguments = "DeclNameArguments"
  case identifierExpr = "IdentifierExpr"
  case superRefExpr = "SuperRefExpr"
  case nilLiteralExpr = "NilLiteralExpr"
  case discardAssignmentExpr = "DiscardAssignmentExpr"
  case assignmentExpr = "AssignmentExpr"
  case sequenceExpr = "SequenceExpr"
  case exprList = "ExprList"
  case poundLineExpr = "PoundLineExpr"
  case poundFileExpr = "PoundFileExpr"
  case poundFunctionExpr = "PoundFunctionExpr"
  case poundDsohandleExpr = "PoundDsohandleExpr"
  case symbolicReferenceExpr = "SymbolicReferenceExpr"
  case prefixOperatorExpr = "PrefixOperatorExpr"
  case binaryOperatorExpr = "BinaryOperatorExpr"
  case arrowExpr = "ArrowExpr"
  case floatLiteralExpr = "FloatLiteralExpr"
  case tupleExpr = "TupleExpr"
  case arrayExpr = "ArrayExpr"
  case dictionaryExpr = "DictionaryExpr"
  case implicitMemberExpr = "ImplicitMemberExpr"
  case functionCallArgument = "FunctionCallArgument"
  case tupleElement = "TupleElement"
  case arrayElement = "ArrayElement"
  case dictionaryElement = "DictionaryElement"
  case integerLiteralExpr = "IntegerLiteralExpr"
  case stringLiteralExpr = "StringLiteralExpr"
  case booleanLiteralExpr = "BooleanLiteralExpr"
  case ternaryExpr = "TernaryExpr"
  case memberAccessExpr = "MemberAccessExpr"
  case dotSelfExpr = "DotSelfExpr"
  case isExpr = "IsExpr"
  case asExpr = "AsExpr"
  case typeExpr = "TypeExpr"
  case closureCaptureItem = "ClosureCaptureItem"
  case closureCaptureItemList = "ClosureCaptureItemList"
  case closureCaptureSignature = "ClosureCaptureSignature"
  case closureParam = "ClosureParam"
  case closureParamList = "ClosureParamList"
  case closureSignature = "ClosureSignature"
  case closureExpr = "ClosureExpr"
  case unresolvedPatternExpr = "UnresolvedPatternExpr"
  case functionCallExpr = "FunctionCallExpr"
  case subscriptExpr = "SubscriptExpr"
  case optionalChainingExpr = "OptionalChainingExpr"
  case forcedValueExpr = "ForcedValueExpr"
  case postfixUnaryExpr = "PostfixUnaryExpr"
  case specializeExpr = "SpecializeExpr"
  case stringSegment = "StringSegment"
  case expressionSegment = "ExpressionSegment"
  case stringInterpolationExpr = "StringInterpolationExpr"
  case keyPathExpr = "KeyPathExpr"
  case objcNamePiece = "ObjcNamePiece"
  case objcName = "ObjcName"
  case objcKeyPathExpr = "ObjcKeyPathExpr"
  case objcSelectorExpr = "ObjcSelectorExpr"
  case editorPlaceholderExpr = "EditorPlaceholderExpr"
  case objectLiteralExpr = "ObjectLiteralExpr"
  case typeInitializerClause = "TypeInitializerClause"
  case typealiasDecl = "TypealiasDecl"
  case associatedtypeDecl = "AssociatedtypeDecl"
  case functionParameterList = "FunctionParameterList"
  case parameterClause = "ParameterClause"
  case returnClause = "ReturnClause"
  case functionSignature = "FunctionSignature"
  case ifConfigClause = "IfConfigClause"
  case ifConfigClauseList = "IfConfigClauseList"
  case ifConfigDecl = "IfConfigDecl"
  case poundErrorDecl = "PoundErrorDecl"
  case poundWarningDecl = "PoundWarningDecl"
  case declModifier = "DeclModifier"
  case inheritedType = "InheritedType"
  case inheritedTypeList = "InheritedTypeList"
  case typeInheritanceClause = "TypeInheritanceClause"
  case classDecl = "ClassDecl"
  case structDecl = "StructDecl"
  case protocolDecl = "ProtocolDecl"
  case extensionDecl = "ExtensionDecl"
  case memberDeclBlock = "MemberDeclBlock"
  case declList = "DeclList"
  case sourceFile = "SourceFile"
  case initializerClause = "InitializerClause"
  case functionParameter = "FunctionParameter"
  case modifierList = "ModifierList"
  case functionDecl = "FunctionDecl"
  case initializerDecl = "InitializerDecl"
  case deinitializerDecl = "DeinitializerDecl"
  case subscriptDecl = "SubscriptDecl"
  case accessLevelModifier = "AccessLevelModifier"
  case accessPathComponent = "AccessPathComponent"
  case accessPath = "AccessPath"
  case importDecl = "ImportDecl"
  case accessorParameter = "AccessorParameter"
  case accessorDecl = "AccessorDecl"
  case accessorList = "AccessorList"
  case accessorBlock = "AccessorBlock"
  case patternBinding = "PatternBinding"
  case patternBindingList = "PatternBindingList"
  case variableDecl = "VariableDecl"
  case enumCaseElement = "EnumCaseElement"
  case enumCaseElementList = "EnumCaseElementList"
  case enumCaseDecl = "EnumCaseDecl"
  case enumDecl = "EnumDecl"
  case operatorDecl = "OperatorDecl"
  case infixOperatorGroup = "InfixOperatorGroup"
  case precedenceGroupDecl = "PrecedenceGroupDecl"
  case precedenceGroupAttributeList = "PrecedenceGroupAttributeList"
  case precedenceGroupRelation = "PrecedenceGroupRelation"
  case precedenceGroupNameList = "PrecedenceGroupNameList"
  case precedenceGroupNameElement = "PrecedenceGroupNameElement"
  case precedenceGroupAssignment = "PrecedenceGroupAssignment"
  case precedenceGroupAssociativity = "PrecedenceGroupAssociativity"
  case tokenList = "TokenList"
  case attribute = "Attribute"
  case attributeList = "AttributeList"
  case continueStmt = "ContinueStmt"
  case whileStmt = "WhileStmt"
  case deferStmt = "DeferStmt"
  case expressionStmt = "ExpressionStmt"
  case switchCaseList = "SwitchCaseList"
  case repeatWhileStmt = "RepeatWhileStmt"
  case guardStmt = "GuardStmt"
  case whereClause = "WhereClause"
  case forInStmt = "ForInStmt"
  case switchStmt = "SwitchStmt"
  case catchClauseList = "CatchClauseList"
  case doStmt = "DoStmt"
  case returnStmt = "ReturnStmt"
  case fallthroughStmt = "FallthroughStmt"
  case breakStmt = "BreakStmt"
  case caseItemList = "CaseItemList"
  case conditionElement = "ConditionElement"
  case availabilityCondition = "AvailabilityCondition"
  case matchingPatternCondition = "MatchingPatternCondition"
  case optionalBindingCondition = "OptionalBindingCondition"
  case conditionElementList = "ConditionElementList"
  case declarationStmt = "DeclarationStmt"
  case throwStmt = "ThrowStmt"
  case ifStmt = "IfStmt"
  case elseIfContinuation = "ElseIfContinuation"
  case elseBlock = "ElseBlock"
  case switchCase = "SwitchCase"
  case switchDefaultLabel = "SwitchDefaultLabel"
  case caseItem = "CaseItem"
  case switchCaseLabel = "SwitchCaseLabel"
  case catchClause = "CatchClause"
  case genericWhereClause = "GenericWhereClause"
  case genericRequirementList = "GenericRequirementList"
  case sameTypeRequirement = "SameTypeRequirement"
  case genericParameterList = "GenericParameterList"
  case genericParameter = "GenericParameter"
  case genericParameterClause = "GenericParameterClause"
  case conformanceRequirement = "ConformanceRequirement"
  case simpleTypeIdentifier = "SimpleTypeIdentifier"
  case memberTypeIdentifier = "MemberTypeIdentifier"
  case arrayType = "ArrayType"
  case dictionaryType = "DictionaryType"
  case metatypeType = "MetatypeType"
  case optionalType = "OptionalType"
  case implicitlyUnwrappedOptionalType = "ImplicitlyUnwrappedOptionalType"
  case compositionTypeElement = "CompositionTypeElement"
  case compositionTypeElementList = "CompositionTypeElementList"
  case compositionType = "CompositionType"
  case tupleTypeElement = "TupleTypeElement"
  case tupleTypeElementList = "TupleTypeElementList"
  case tupleType = "TupleType"
  case functionType = "FunctionType"
  case attributedType = "AttributedType"
  case genericArgumentList = "GenericArgumentList"
  case genericArgument = "GenericArgument"
  case genericArgumentClause = "GenericArgumentClause"
  case typeAnnotation = "TypeAnnotation"
  case enumCasePattern = "EnumCasePattern"
  case isTypePattern = "IsTypePattern"
  case optionalPattern = "OptionalPattern"
  case identifierPattern = "IdentifierPattern"
  case asTypePattern = "AsTypePattern"
  case tuplePattern = "TuplePattern"
  case wildcardPattern = "WildcardPattern"
  case tuplePatternElement = "TuplePatternElement"
  case expressionPattern = "ExpressionPattern"
  case tuplePatternElementList = "TuplePatternElementList"
  case valueBindingPattern = "ValueBindingPattern"

  /// Whether the underlying kind is a sub-kind of DeclSyntax.
  public var isDecl: Bool {
    switch self {
    case .unknownDecl: return true
    case .typealiasDecl: return true
    case .associatedtypeDecl: return true
    case .ifConfigDecl: return true
    case .poundErrorDecl: return true
    case .poundWarningDecl: return true
    case .classDecl: return true
    case .structDecl: return true
    case .protocolDecl: return true
    case .extensionDecl: return true
    case .functionDecl: return true
    case .initializerDecl: return true
    case .deinitializerDecl: return true
    case .subscriptDecl: return true
    case .importDecl: return true
    case .accessorDecl: return true
    case .variableDecl: return true
    case .enumCaseDecl: return true
    case .enumDecl: return true
    case .operatorDecl: return true
    case .precedenceGroupDecl: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of ExprSyntax.
  public var isExpr: Bool {
    switch self {
    case .unknownExpr: return true
    case .inOutExpr: return true
    case .poundColumnExpr: return true
    case .tryExpr: return true
    case .identifierExpr: return true
    case .superRefExpr: return true
    case .nilLiteralExpr: return true
    case .discardAssignmentExpr: return true
    case .assignmentExpr: return true
    case .sequenceExpr: return true
    case .poundLineExpr: return true
    case .poundFileExpr: return true
    case .poundFunctionExpr: return true
    case .poundDsohandleExpr: return true
    case .symbolicReferenceExpr: return true
    case .prefixOperatorExpr: return true
    case .binaryOperatorExpr: return true
    case .arrowExpr: return true
    case .floatLiteralExpr: return true
    case .tupleExpr: return true
    case .arrayExpr: return true
    case .dictionaryExpr: return true
    case .implicitMemberExpr: return true
    case .integerLiteralExpr: return true
    case .stringLiteralExpr: return true
    case .booleanLiteralExpr: return true
    case .ternaryExpr: return true
    case .memberAccessExpr: return true
    case .dotSelfExpr: return true
    case .isExpr: return true
    case .asExpr: return true
    case .typeExpr: return true
    case .closureExpr: return true
    case .unresolvedPatternExpr: return true
    case .functionCallExpr: return true
    case .subscriptExpr: return true
    case .optionalChainingExpr: return true
    case .forcedValueExpr: return true
    case .postfixUnaryExpr: return true
    case .specializeExpr: return true
    case .stringInterpolationExpr: return true
    case .keyPathExpr: return true
    case .objcKeyPathExpr: return true
    case .objcSelectorExpr: return true
    case .editorPlaceholderExpr: return true
    case .objectLiteralExpr: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of StmtSyntax.
  public var isStmt: Bool {
    switch self {
    case .unknownStmt: return true
    case .continueStmt: return true
    case .whileStmt: return true
    case .deferStmt: return true
    case .expressionStmt: return true
    case .repeatWhileStmt: return true
    case .guardStmt: return true
    case .forInStmt: return true
    case .switchStmt: return true
    case .doStmt: return true
    case .returnStmt: return true
    case .fallthroughStmt: return true
    case .breakStmt: return true
    case .declarationStmt: return true
    case .throwStmt: return true
    case .ifStmt: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of PatternSyntax.
  public var isPattern: Bool {
    switch self {
    case .unknownPattern: return true
    case .enumCasePattern: return true
    case .isTypePattern: return true
    case .optionalPattern: return true
    case .identifierPattern: return true
    case .asTypePattern: return true
    case .tuplePattern: return true
    case .wildcardPattern: return true
    case .expressionPattern: return true
    case .valueBindingPattern: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of TypeSyntax.
  public var isType: Bool {
    switch self {
    case .unknownType: return true
    case .simpleTypeIdentifier: return true
    case .memberTypeIdentifier: return true
    case .arrayType: return true
    case .dictionaryType: return true
    case .metatypeType: return true
    case .optionalType: return true
    case .implicitlyUnwrappedOptionalType: return true
    case .compositionType: return true
    case .tupleType: return true
    case .functionType: return true
    case .attributedType: return true
    default: return false
    }
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let kind = try container.decode(String.self)
    self = SyntaxKind(rawValue: kind) ?? .unknown
  }
}

/// Creates a Syntax node from the provided RawSyntax using the appropriate
/// Syntax type, as specified by its kind.
/// - Parameters:
///   - raw: The raw syntax with which to create this node.
///   - root: The root of this tree, or `nil` if the new node is the root.
internal func makeSyntax(_ raw: RawSyntax) -> Syntax {
  let data = SyntaxData(raw: raw)
  return makeSyntax(root: nil, data: data)
}

/// Creates a Syntax node from the provided SyntaxData using the appropriate
/// Syntax type, as specified by its kind.
/// - Parameters:
///   - root: The root of this tree, or `nil` if the new node is the root.
///   - data: The data for this new node.
internal func makeSyntax(root: SyntaxData?, data: SyntaxData) -> Syntax {
  let root = root ?? data
  switch data.raw.kind {
  case .token: return TokenSyntax(root: root, data: data)
  case .unknown: return UnknownSyntax(root: root, data: data)
  case .decl:
    return UnknownDeclSyntax(root: root, data: data)
  case .expr:
    return UnknownExprSyntax(root: root, data: data)
  case .stmt:
    return UnknownStmtSyntax(root: root, data: data)
  case .type:
    return UnknownTypeSyntax(root: root, data: data)
  case .pattern:
    return UnknownPatternSyntax(root: root, data: data)
  case .unknownDecl:
    return UnknownDeclSyntax(root: root, data: data)
  case .unknownExpr:
    return UnknownExprSyntax(root: root, data: data)
  case .unknownStmt:
    return UnknownStmtSyntax(root: root, data: data)
  case .unknownType:
    return UnknownTypeSyntax(root: root, data: data)
  case .unknownPattern:
    return UnknownPatternSyntax(root: root, data: data)
  case .codeBlockItem:
    return CodeBlockItemSyntax(root: root, data: data)
  case .codeBlockItemList:
    return CodeBlockItemListSyntax(root: root, data: data)
  case .codeBlock:
    return CodeBlockSyntax(root: root, data: data)
  case .inOutExpr:
    return InOutExprSyntax(root: root, data: data)
  case .poundColumnExpr:
    return PoundColumnExprSyntax(root: root, data: data)
  case .functionCallArgumentList:
    return FunctionCallArgumentListSyntax(root: root, data: data)
  case .tupleElementList:
    return TupleElementListSyntax(root: root, data: data)
  case .arrayElementList:
    return ArrayElementListSyntax(root: root, data: data)
  case .dictionaryElementList:
    return DictionaryElementListSyntax(root: root, data: data)
  case .stringInterpolationSegments:
    return StringInterpolationSegmentsSyntax(root: root, data: data)
  case .tryExpr:
    return TryExprSyntax(root: root, data: data)
  case .declNameArgument:
    return DeclNameArgumentSyntax(root: root, data: data)
  case .declNameArgumentList:
    return DeclNameArgumentListSyntax(root: root, data: data)
  case .declNameArguments:
    return DeclNameArgumentsSyntax(root: root, data: data)
  case .identifierExpr:
    return IdentifierExprSyntax(root: root, data: data)
  case .superRefExpr:
    return SuperRefExprSyntax(root: root, data: data)
  case .nilLiteralExpr:
    return NilLiteralExprSyntax(root: root, data: data)
  case .discardAssignmentExpr:
    return DiscardAssignmentExprSyntax(root: root, data: data)
  case .assignmentExpr:
    return AssignmentExprSyntax(root: root, data: data)
  case .sequenceExpr:
    return SequenceExprSyntax(root: root, data: data)
  case .exprList:
    return ExprListSyntax(root: root, data: data)
  case .poundLineExpr:
    return PoundLineExprSyntax(root: root, data: data)
  case .poundFileExpr:
    return PoundFileExprSyntax(root: root, data: data)
  case .poundFunctionExpr:
    return PoundFunctionExprSyntax(root: root, data: data)
  case .poundDsohandleExpr:
    return PoundDsohandleExprSyntax(root: root, data: data)
  case .symbolicReferenceExpr:
    return SymbolicReferenceExprSyntax(root: root, data: data)
  case .prefixOperatorExpr:
    return PrefixOperatorExprSyntax(root: root, data: data)
  case .binaryOperatorExpr:
    return BinaryOperatorExprSyntax(root: root, data: data)
  case .arrowExpr:
    return ArrowExprSyntax(root: root, data: data)
  case .floatLiteralExpr:
    return FloatLiteralExprSyntax(root: root, data: data)
  case .tupleExpr:
    return TupleExprSyntax(root: root, data: data)
  case .arrayExpr:
    return ArrayExprSyntax(root: root, data: data)
  case .dictionaryExpr:
    return DictionaryExprSyntax(root: root, data: data)
  case .implicitMemberExpr:
    return ImplicitMemberExprSyntax(root: root, data: data)
  case .functionCallArgument:
    return FunctionCallArgumentSyntax(root: root, data: data)
  case .tupleElement:
    return TupleElementSyntax(root: root, data: data)
  case .arrayElement:
    return ArrayElementSyntax(root: root, data: data)
  case .dictionaryElement:
    return DictionaryElementSyntax(root: root, data: data)
  case .integerLiteralExpr:
    return IntegerLiteralExprSyntax(root: root, data: data)
  case .stringLiteralExpr:
    return StringLiteralExprSyntax(root: root, data: data)
  case .booleanLiteralExpr:
    return BooleanLiteralExprSyntax(root: root, data: data)
  case .ternaryExpr:
    return TernaryExprSyntax(root: root, data: data)
  case .memberAccessExpr:
    return MemberAccessExprSyntax(root: root, data: data)
  case .dotSelfExpr:
    return DotSelfExprSyntax(root: root, data: data)
  case .isExpr:
    return IsExprSyntax(root: root, data: data)
  case .asExpr:
    return AsExprSyntax(root: root, data: data)
  case .typeExpr:
    return TypeExprSyntax(root: root, data: data)
  case .closureCaptureItem:
    return ClosureCaptureItemSyntax(root: root, data: data)
  case .closureCaptureItemList:
    return ClosureCaptureItemListSyntax(root: root, data: data)
  case .closureCaptureSignature:
    return ClosureCaptureSignatureSyntax(root: root, data: data)
  case .closureParam:
    return ClosureParamSyntax(root: root, data: data)
  case .closureParamList:
    return ClosureParamListSyntax(root: root, data: data)
  case .closureSignature:
    return ClosureSignatureSyntax(root: root, data: data)
  case .closureExpr:
    return ClosureExprSyntax(root: root, data: data)
  case .unresolvedPatternExpr:
    return UnresolvedPatternExprSyntax(root: root, data: data)
  case .functionCallExpr:
    return FunctionCallExprSyntax(root: root, data: data)
  case .subscriptExpr:
    return SubscriptExprSyntax(root: root, data: data)
  case .optionalChainingExpr:
    return OptionalChainingExprSyntax(root: root, data: data)
  case .forcedValueExpr:
    return ForcedValueExprSyntax(root: root, data: data)
  case .postfixUnaryExpr:
    return PostfixUnaryExprSyntax(root: root, data: data)
  case .specializeExpr:
    return SpecializeExprSyntax(root: root, data: data)
  case .stringSegment:
    return StringSegmentSyntax(root: root, data: data)
  case .expressionSegment:
    return ExpressionSegmentSyntax(root: root, data: data)
  case .stringInterpolationExpr:
    return StringInterpolationExprSyntax(root: root, data: data)
  case .keyPathExpr:
    return KeyPathExprSyntax(root: root, data: data)
  case .objcNamePiece:
    return ObjcNamePieceSyntax(root: root, data: data)
  case .objcName:
    return ObjcNameSyntax(root: root, data: data)
  case .objcKeyPathExpr:
    return ObjcKeyPathExprSyntax(root: root, data: data)
  case .objcSelectorExpr:
    return ObjcSelectorExprSyntax(root: root, data: data)
  case .editorPlaceholderExpr:
    return EditorPlaceholderExprSyntax(root: root, data: data)
  case .objectLiteralExpr:
    return ObjectLiteralExprSyntax(root: root, data: data)
  case .typeInitializerClause:
    return TypeInitializerClauseSyntax(root: root, data: data)
  case .typealiasDecl:
    return TypealiasDeclSyntax(root: root, data: data)
  case .associatedtypeDecl:
    return AssociatedtypeDeclSyntax(root: root, data: data)
  case .functionParameterList:
    return FunctionParameterListSyntax(root: root, data: data)
  case .parameterClause:
    return ParameterClauseSyntax(root: root, data: data)
  case .returnClause:
    return ReturnClauseSyntax(root: root, data: data)
  case .functionSignature:
    return FunctionSignatureSyntax(root: root, data: data)
  case .ifConfigClause:
    return IfConfigClauseSyntax(root: root, data: data)
  case .ifConfigClauseList:
    return IfConfigClauseListSyntax(root: root, data: data)
  case .ifConfigDecl:
    return IfConfigDeclSyntax(root: root, data: data)
  case .poundErrorDecl:
    return PoundErrorDeclSyntax(root: root, data: data)
  case .poundWarningDecl:
    return PoundWarningDeclSyntax(root: root, data: data)
  case .declModifier:
    return DeclModifierSyntax(root: root, data: data)
  case .inheritedType:
    return InheritedTypeSyntax(root: root, data: data)
  case .inheritedTypeList:
    return InheritedTypeListSyntax(root: root, data: data)
  case .typeInheritanceClause:
    return TypeInheritanceClauseSyntax(root: root, data: data)
  case .classDecl:
    return ClassDeclSyntax(root: root, data: data)
  case .structDecl:
    return StructDeclSyntax(root: root, data: data)
  case .protocolDecl:
    return ProtocolDeclSyntax(root: root, data: data)
  case .extensionDecl:
    return ExtensionDeclSyntax(root: root, data: data)
  case .memberDeclBlock:
    return MemberDeclBlockSyntax(root: root, data: data)
  case .declList:
    return DeclListSyntax(root: root, data: data)
  case .sourceFile:
    return SourceFileSyntax(root: root, data: data)
  case .initializerClause:
    return InitializerClauseSyntax(root: root, data: data)
  case .functionParameter:
    return FunctionParameterSyntax(root: root, data: data)
  case .modifierList:
    return ModifierListSyntax(root: root, data: data)
  case .functionDecl:
    return FunctionDeclSyntax(root: root, data: data)
  case .initializerDecl:
    return InitializerDeclSyntax(root: root, data: data)
  case .deinitializerDecl:
    return DeinitializerDeclSyntax(root: root, data: data)
  case .subscriptDecl:
    return SubscriptDeclSyntax(root: root, data: data)
  case .accessLevelModifier:
    return AccessLevelModifierSyntax(root: root, data: data)
  case .accessPathComponent:
    return AccessPathComponentSyntax(root: root, data: data)
  case .accessPath:
    return AccessPathSyntax(root: root, data: data)
  case .importDecl:
    return ImportDeclSyntax(root: root, data: data)
  case .accessorParameter:
    return AccessorParameterSyntax(root: root, data: data)
  case .accessorDecl:
    return AccessorDeclSyntax(root: root, data: data)
  case .accessorList:
    return AccessorListSyntax(root: root, data: data)
  case .accessorBlock:
    return AccessorBlockSyntax(root: root, data: data)
  case .patternBinding:
    return PatternBindingSyntax(root: root, data: data)
  case .patternBindingList:
    return PatternBindingListSyntax(root: root, data: data)
  case .variableDecl:
    return VariableDeclSyntax(root: root, data: data)
  case .enumCaseElement:
    return EnumCaseElementSyntax(root: root, data: data)
  case .enumCaseElementList:
    return EnumCaseElementListSyntax(root: root, data: data)
  case .enumCaseDecl:
    return EnumCaseDeclSyntax(root: root, data: data)
  case .enumDecl:
    return EnumDeclSyntax(root: root, data: data)
  case .operatorDecl:
    return OperatorDeclSyntax(root: root, data: data)
  case .infixOperatorGroup:
    return InfixOperatorGroupSyntax(root: root, data: data)
  case .precedenceGroupDecl:
    return PrecedenceGroupDeclSyntax(root: root, data: data)
  case .precedenceGroupAttributeList:
    return PrecedenceGroupAttributeListSyntax(root: root, data: data)
  case .precedenceGroupRelation:
    return PrecedenceGroupRelationSyntax(root: root, data: data)
  case .precedenceGroupNameList:
    return PrecedenceGroupNameListSyntax(root: root, data: data)
  case .precedenceGroupNameElement:
    return PrecedenceGroupNameElementSyntax(root: root, data: data)
  case .precedenceGroupAssignment:
    return PrecedenceGroupAssignmentSyntax(root: root, data: data)
  case .precedenceGroupAssociativity:
    return PrecedenceGroupAssociativitySyntax(root: root, data: data)
  case .tokenList:
    return TokenListSyntax(root: root, data: data)
  case .attribute:
    return AttributeSyntax(root: root, data: data)
  case .attributeList:
    return AttributeListSyntax(root: root, data: data)
  case .continueStmt:
    return ContinueStmtSyntax(root: root, data: data)
  case .whileStmt:
    return WhileStmtSyntax(root: root, data: data)
  case .deferStmt:
    return DeferStmtSyntax(root: root, data: data)
  case .expressionStmt:
    return ExpressionStmtSyntax(root: root, data: data)
  case .switchCaseList:
    return SwitchCaseListSyntax(root: root, data: data)
  case .repeatWhileStmt:
    return RepeatWhileStmtSyntax(root: root, data: data)
  case .guardStmt:
    return GuardStmtSyntax(root: root, data: data)
  case .whereClause:
    return WhereClauseSyntax(root: root, data: data)
  case .forInStmt:
    return ForInStmtSyntax(root: root, data: data)
  case .switchStmt:
    return SwitchStmtSyntax(root: root, data: data)
  case .catchClauseList:
    return CatchClauseListSyntax(root: root, data: data)
  case .doStmt:
    return DoStmtSyntax(root: root, data: data)
  case .returnStmt:
    return ReturnStmtSyntax(root: root, data: data)
  case .fallthroughStmt:
    return FallthroughStmtSyntax(root: root, data: data)
  case .breakStmt:
    return BreakStmtSyntax(root: root, data: data)
  case .caseItemList:
    return CaseItemListSyntax(root: root, data: data)
  case .conditionElement:
    return ConditionElementSyntax(root: root, data: data)
  case .availabilityCondition:
    return AvailabilityConditionSyntax(root: root, data: data)
  case .matchingPatternCondition:
    return MatchingPatternConditionSyntax(root: root, data: data)
  case .optionalBindingCondition:
    return OptionalBindingConditionSyntax(root: root, data: data)
  case .conditionElementList:
    return ConditionElementListSyntax(root: root, data: data)
  case .declarationStmt:
    return DeclarationStmtSyntax(root: root, data: data)
  case .throwStmt:
    return ThrowStmtSyntax(root: root, data: data)
  case .ifStmt:
    return IfStmtSyntax(root: root, data: data)
  case .elseIfContinuation:
    return ElseIfContinuationSyntax(root: root, data: data)
  case .elseBlock:
    return ElseBlockSyntax(root: root, data: data)
  case .switchCase:
    return SwitchCaseSyntax(root: root, data: data)
  case .switchDefaultLabel:
    return SwitchDefaultLabelSyntax(root: root, data: data)
  case .caseItem:
    return CaseItemSyntax(root: root, data: data)
  case .switchCaseLabel:
    return SwitchCaseLabelSyntax(root: root, data: data)
  case .catchClause:
    return CatchClauseSyntax(root: root, data: data)
  case .genericWhereClause:
    return GenericWhereClauseSyntax(root: root, data: data)
  case .genericRequirementList:
    return GenericRequirementListSyntax(root: root, data: data)
  case .sameTypeRequirement:
    return SameTypeRequirementSyntax(root: root, data: data)
  case .genericParameterList:
    return GenericParameterListSyntax(root: root, data: data)
  case .genericParameter:
    return GenericParameterSyntax(root: root, data: data)
  case .genericParameterClause:
    return GenericParameterClauseSyntax(root: root, data: data)
  case .conformanceRequirement:
    return ConformanceRequirementSyntax(root: root, data: data)
  case .simpleTypeIdentifier:
    return SimpleTypeIdentifierSyntax(root: root, data: data)
  case .memberTypeIdentifier:
    return MemberTypeIdentifierSyntax(root: root, data: data)
  case .arrayType:
    return ArrayTypeSyntax(root: root, data: data)
  case .dictionaryType:
    return DictionaryTypeSyntax(root: root, data: data)
  case .metatypeType:
    return MetatypeTypeSyntax(root: root, data: data)
  case .optionalType:
    return OptionalTypeSyntax(root: root, data: data)
  case .implicitlyUnwrappedOptionalType:
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: root, data: data)
  case .compositionTypeElement:
    return CompositionTypeElementSyntax(root: root, data: data)
  case .compositionTypeElementList:
    return CompositionTypeElementListSyntax(root: root, data: data)
  case .compositionType:
    return CompositionTypeSyntax(root: root, data: data)
  case .tupleTypeElement:
    return TupleTypeElementSyntax(root: root, data: data)
  case .tupleTypeElementList:
    return TupleTypeElementListSyntax(root: root, data: data)
  case .tupleType:
    return TupleTypeSyntax(root: root, data: data)
  case .functionType:
    return FunctionTypeSyntax(root: root, data: data)
  case .attributedType:
    return AttributedTypeSyntax(root: root, data: data)
  case .genericArgumentList:
    return GenericArgumentListSyntax(root: root, data: data)
  case .genericArgument:
    return GenericArgumentSyntax(root: root, data: data)
  case .genericArgumentClause:
    return GenericArgumentClauseSyntax(root: root, data: data)
  case .typeAnnotation:
    return TypeAnnotationSyntax(root: root, data: data)
  case .enumCasePattern:
    return EnumCasePatternSyntax(root: root, data: data)
  case .isTypePattern:
    return IsTypePatternSyntax(root: root, data: data)
  case .optionalPattern:
    return OptionalPatternSyntax(root: root, data: data)
  case .identifierPattern:
    return IdentifierPatternSyntax(root: root, data: data)
  case .asTypePattern:
    return AsTypePatternSyntax(root: root, data: data)
  case .tuplePattern:
    return TuplePatternSyntax(root: root, data: data)
  case .wildcardPattern:
    return WildcardPatternSyntax(root: root, data: data)
  case .tuplePatternElement:
    return TuplePatternElementSyntax(root: root, data: data)
  case .expressionPattern:
    return ExpressionPatternSyntax(root: root, data: data)
  case .tuplePatternElementList:
    return TuplePatternElementListSyntax(root: root, data: data)
  case .valueBindingPattern:
    return ValueBindingPatternSyntax(root: root, data: data)
  }
}