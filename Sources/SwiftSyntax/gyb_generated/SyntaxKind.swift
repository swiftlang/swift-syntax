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

/// Enumerates the known kinds of Syntax represented in the Syntax tree.
internal enum SyntaxKind: CSyntaxKind {
  case token = 0
  case unknown = 1
  case decl = 87
  case expr = 88
  case stmt = 89
  case type = 90
  case pattern = 91
  case unknownDecl = 2
  case unknownExpr = 24
  case unknownStmt = 71
  case unknownType = 211
  case unknownPattern = 201
  case codeBlockItem = 92
  case codeBlockItemList = 163
  case codeBlock = 93
  case inOutExpr = 25
  case poundColumnExpr = 26
  case functionCallArgumentList = 164
  case tupleElementList = 165
  case arrayElementList = 166
  case dictionaryElementList = 167
  case stringLiteralSegments = 168
  case tryExpr = 27
  case declNameArgument = 94
  case declNameArgumentList = 169
  case declNameArguments = 95
  case identifierExpr = 28
  case superRefExpr = 29
  case nilLiteralExpr = 30
  case discardAssignmentExpr = 31
  case assignmentExpr = 32
  case sequenceExpr = 33
  case exprList = 170
  case poundLineExpr = 34
  case poundFileExpr = 35
  case poundFunctionExpr = 36
  case poundDsohandleExpr = 37
  case symbolicReferenceExpr = 38
  case prefixOperatorExpr = 39
  case binaryOperatorExpr = 40
  case arrowExpr = 41
  case floatLiteralExpr = 42
  case tupleExpr = 43
  case arrayExpr = 44
  case dictionaryExpr = 45
  case functionCallArgument = 96
  case tupleElement = 97
  case arrayElement = 98
  case dictionaryElement = 99
  case integerLiteralExpr = 47
  case booleanLiteralExpr = 49
  case ternaryExpr = 50
  case memberAccessExpr = 51
  case isExpr = 53
  case asExpr = 54
  case typeExpr = 55
  case closureCaptureItem = 100
  case closureCaptureItemList = 171
  case closureCaptureSignature = 101
  case closureParam = 102
  case closureParamList = 172
  case closureSignature = 103
  case closureExpr = 56
  case unresolvedPatternExpr = 57
  case functionCallExpr = 58
  case subscriptExpr = 59
  case optionalChainingExpr = 60
  case forcedValueExpr = 61
  case postfixUnaryExpr = 62
  case specializeExpr = 63
  case stringSegment = 104
  case expressionSegment = 105
  case stringLiteralExpr = 48
  case keyPathExpr = 65
  case keyPathBaseExpr = 66
  case objcNamePiece = 106
  case objcName = 173
  case objcKeyPathExpr = 67
  case objcSelectorExpr = 68
  case editorPlaceholderExpr = 69
  case objectLiteralExpr = 70
  case typeInitializerClause = 107
  case typealiasDecl = 3
  case associatedtypeDecl = 4
  case functionParameterList = 174
  case parameterClause = 108
  case returnClause = 109
  case functionSignature = 110
  case ifConfigClause = 111
  case ifConfigClauseList = 175
  case ifConfigDecl = 5
  case poundErrorDecl = 6
  case poundWarningDecl = 7
  case poundSourceLocation = 8
  case poundSourceLocationArgs = 112
  case declModifier = 113
  case inheritedType = 114
  case inheritedTypeList = 176
  case typeInheritanceClause = 115
  case classDecl = 9
  case structDecl = 10
  case protocolDecl = 11
  case extensionDecl = 12
  case memberDeclBlock = 116
  case memberDeclList = 177
  case memberDeclListItem = 117
  case sourceFile = 118
  case initializerClause = 119
  case functionParameter = 120
  case modifierList = 178
  case functionDecl = 13
  case initializerDecl = 14
  case deinitializerDecl = 15
  case subscriptDecl = 16
  case accessLevelModifier = 121
  case accessPathComponent = 122
  case accessPath = 179
  case importDecl = 17
  case accessorParameter = 123
  case accessorDecl = 18
  case accessorList = 180
  case accessorBlock = 124
  case patternBinding = 125
  case patternBindingList = 181
  case variableDecl = 19
  case enumCaseElement = 126
  case enumCaseElementList = 182
  case enumCaseDecl = 20
  case enumDecl = 21
  case operatorDecl = 22
  case identifierList = 226
  case operatorPrecedenceAndTypes = 127
  case precedenceGroupDecl = 23
  case precedenceGroupAttributeList = 183
  case precedenceGroupRelation = 128
  case precedenceGroupNameList = 184
  case precedenceGroupNameElement = 129
  case precedenceGroupAssignment = 130
  case precedenceGroupAssociativity = 131
  case tokenList = 185
  case nonEmptyTokenList = 186
  case customAttribute = 231
  case attribute = 132
  case attributeList = 187
  case specializeAttributeSpecList = 188
  case labeledSpecializeEntry = 133
  case namedAttributeStringArgument = 227
  case declName = 228
  case implementsAttributeArguments = 134
  case objCSelectorPiece = 135
  case objCSelector = 189
  case continueStmt = 72
  case whileStmt = 73
  case deferStmt = 74
  case expressionStmt = 75
  case switchCaseList = 190
  case repeatWhileStmt = 76
  case guardStmt = 77
  case whereClause = 136
  case forInStmt = 78
  case switchStmt = 79
  case catchClauseList = 191
  case doStmt = 80
  case returnStmt = 81
  case yieldStmt = 224
  case yieldList = 225
  case fallthroughStmt = 82
  case breakStmt = 83
  case caseItemList = 192
  case conditionElement = 137
  case availabilityCondition = 138
  case matchingPatternCondition = 139
  case optionalBindingCondition = 140
  case conditionElementList = 193
  case declarationStmt = 84
  case throwStmt = 85
  case ifStmt = 86
  case elseIfContinuation = 141
  case elseBlock = 142
  case switchCase = 143
  case switchDefaultLabel = 144
  case caseItem = 145
  case switchCaseLabel = 146
  case catchClause = 147
  case poundAssertStmt = 229
  case genericWhereClause = 148
  case genericRequirementList = 194
  case sameTypeRequirement = 149
  case genericParameterList = 195
  case genericParameter = 150
  case genericParameterClause = 151
  case conformanceRequirement = 152
  case simpleTypeIdentifier = 212
  case memberTypeIdentifier = 213
  case classRestrictionType = 214
  case arrayType = 215
  case dictionaryType = 216
  case metatypeType = 217
  case optionalType = 218
  case someType = 230
  case implicitlyUnwrappedOptionalType = 219
  case compositionTypeElement = 153
  case compositionTypeElementList = 196
  case compositionType = 220
  case tupleTypeElement = 154
  case tupleTypeElementList = 197
  case tupleType = 221
  case functionType = 222
  case attributedType = 223
  case genericArgumentList = 198
  case genericArgument = 155
  case genericArgumentClause = 156
  case typeAnnotation = 157
  case enumCasePattern = 202
  case isTypePattern = 203
  case optionalPattern = 204
  case identifierPattern = 205
  case asTypePattern = 206
  case tuplePattern = 207
  case wildcardPattern = 208
  case tuplePatternElement = 158
  case expressionPattern = 209
  case tuplePatternElementList = 199
  case valueBindingPattern = 210
  case availabilitySpecList = 200
  case availabilityArgument = 159
  case availabilityLabeledArgument = 160
  case availabilityVersionRestriction = 161
  case versionTuple = 162

  /// Whether the underlying kind is a sub-kind of DeclSyntax.
  public var isDecl: Bool {
    switch self {
    case .unknownDecl: return true
    case .typealiasDecl: return true
    case .associatedtypeDecl: return true
    case .ifConfigDecl: return true
    case .poundErrorDecl: return true
    case .poundWarningDecl: return true
    case .poundSourceLocation: return true
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
    case .integerLiteralExpr: return true
    case .booleanLiteralExpr: return true
    case .ternaryExpr: return true
    case .memberAccessExpr: return true
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
    case .stringLiteralExpr: return true
    case .keyPathExpr: return true
    case .keyPathBaseExpr: return true
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
    case .yieldStmt: return true
    case .fallthroughStmt: return true
    case .breakStmt: return true
    case .declarationStmt: return true
    case .throwStmt: return true
    case .ifStmt: return true
    case .poundAssertStmt: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of SyntaxCollectionSyntax.
  public var isSyntaxCollection: Bool {
    switch self {
    case .codeBlockItemList: return true
    case .functionCallArgumentList: return true
    case .tupleElementList: return true
    case .arrayElementList: return true
    case .dictionaryElementList: return true
    case .stringLiteralSegments: return true
    case .declNameArgumentList: return true
    case .exprList: return true
    case .closureCaptureItemList: return true
    case .closureParamList: return true
    case .objcName: return true
    case .functionParameterList: return true
    case .ifConfigClauseList: return true
    case .inheritedTypeList: return true
    case .memberDeclList: return true
    case .modifierList: return true
    case .accessPath: return true
    case .accessorList: return true
    case .patternBindingList: return true
    case .enumCaseElementList: return true
    case .identifierList: return true
    case .precedenceGroupAttributeList: return true
    case .precedenceGroupNameList: return true
    case .tokenList: return true
    case .nonEmptyTokenList: return true
    case .attributeList: return true
    case .specializeAttributeSpecList: return true
    case .objCSelector: return true
    case .switchCaseList: return true
    case .catchClauseList: return true
    case .caseItemList: return true
    case .conditionElementList: return true
    case .genericRequirementList: return true
    case .genericParameterList: return true
    case .compositionTypeElementList: return true
    case .tupleTypeElementList: return true
    case .genericArgumentList: return true
    case .tuplePatternElementList: return true
    case .availabilitySpecList: return true
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
    case .classRestrictionType: return true
    case .arrayType: return true
    case .dictionaryType: return true
    case .metatypeType: return true
    case .optionalType: return true
    case .someType: return true
    case .implicitlyUnwrappedOptionalType: return true
    case .compositionType: return true
    case .tupleType: return true
    case .functionType: return true
    case .attributedType: return true
    default: return false
    }
  }

  public var isUnknown: Bool {
    switch self {
    case .unknownDecl: return true
    case .unknownExpr: return true
    case .unknownStmt: return true
    case .unknownPattern: return true
    case .unknownType: return true
    case .unknown: return true
    default: return false
    }
  }
}

extension SyntaxKind {
  static func fromRawValue(_ rawValue: CSyntaxKind) -> SyntaxKind {
    return SyntaxKind(rawValue: rawValue)!
  }
}

/// Creates a Syntax node from the provided SyntaxData using the appropriate
/// Syntax type, as specified by its kind.
/// - Parameters:
///   - root: The root of this tree, or `nil` if the new node is the root.
///   - data: The data for this new node.
internal func makeSyntax(_ data: SyntaxData) -> _SyntaxBase {
  switch data.raw.kind {
  case .token: return TokenSyntax(data)
  case .unknown: return UnknownSyntax(data)
  case .decl:
    return UnknownDeclSyntax(data)
  case .expr:
    return UnknownExprSyntax(data)
  case .stmt:
    return UnknownStmtSyntax(data)
  case .type:
    return UnknownTypeSyntax(data)
  case .pattern:
    return UnknownPatternSyntax(data)
  case .unknownDecl:
    return UnknownDeclSyntax(data)
  case .unknownExpr:
    return UnknownExprSyntax(data)
  case .unknownStmt:
    return UnknownStmtSyntax(data)
  case .unknownType:
    return UnknownTypeSyntax(data)
  case .unknownPattern:
    return UnknownPatternSyntax(data)
  case .codeBlockItem:
    return CodeBlockItemSyntax(data)
  case .codeBlockItemList:
    return CodeBlockItemListSyntax(data)
  case .codeBlock:
    return CodeBlockSyntax(data)
  case .inOutExpr:
    return InOutExprSyntax(data)
  case .poundColumnExpr:
    return PoundColumnExprSyntax(data)
  case .functionCallArgumentList:
    return FunctionCallArgumentListSyntax(data)
  case .tupleElementList:
    return TupleElementListSyntax(data)
  case .arrayElementList:
    return ArrayElementListSyntax(data)
  case .dictionaryElementList:
    return DictionaryElementListSyntax(data)
  case .stringLiteralSegments:
    return StringLiteralSegmentsSyntax(data)
  case .tryExpr:
    return TryExprSyntax(data)
  case .declNameArgument:
    return DeclNameArgumentSyntax(data)
  case .declNameArgumentList:
    return DeclNameArgumentListSyntax(data)
  case .declNameArguments:
    return DeclNameArgumentsSyntax(data)
  case .identifierExpr:
    return IdentifierExprSyntax(data)
  case .superRefExpr:
    return SuperRefExprSyntax(data)
  case .nilLiteralExpr:
    return NilLiteralExprSyntax(data)
  case .discardAssignmentExpr:
    return DiscardAssignmentExprSyntax(data)
  case .assignmentExpr:
    return AssignmentExprSyntax(data)
  case .sequenceExpr:
    return SequenceExprSyntax(data)
  case .exprList:
    return ExprListSyntax(data)
  case .poundLineExpr:
    return PoundLineExprSyntax(data)
  case .poundFileExpr:
    return PoundFileExprSyntax(data)
  case .poundFunctionExpr:
    return PoundFunctionExprSyntax(data)
  case .poundDsohandleExpr:
    return PoundDsohandleExprSyntax(data)
  case .symbolicReferenceExpr:
    return SymbolicReferenceExprSyntax(data)
  case .prefixOperatorExpr:
    return PrefixOperatorExprSyntax(data)
  case .binaryOperatorExpr:
    return BinaryOperatorExprSyntax(data)
  case .arrowExpr:
    return ArrowExprSyntax(data)
  case .floatLiteralExpr:
    return FloatLiteralExprSyntax(data)
  case .tupleExpr:
    return TupleExprSyntax(data)
  case .arrayExpr:
    return ArrayExprSyntax(data)
  case .dictionaryExpr:
    return DictionaryExprSyntax(data)
  case .functionCallArgument:
    return FunctionCallArgumentSyntax(data)
  case .tupleElement:
    return TupleElementSyntax(data)
  case .arrayElement:
    return ArrayElementSyntax(data)
  case .dictionaryElement:
    return DictionaryElementSyntax(data)
  case .integerLiteralExpr:
    return IntegerLiteralExprSyntax(data)
  case .booleanLiteralExpr:
    return BooleanLiteralExprSyntax(data)
  case .ternaryExpr:
    return TernaryExprSyntax(data)
  case .memberAccessExpr:
    return MemberAccessExprSyntax(data)
  case .isExpr:
    return IsExprSyntax(data)
  case .asExpr:
    return AsExprSyntax(data)
  case .typeExpr:
    return TypeExprSyntax(data)
  case .closureCaptureItem:
    return ClosureCaptureItemSyntax(data)
  case .closureCaptureItemList:
    return ClosureCaptureItemListSyntax(data)
  case .closureCaptureSignature:
    return ClosureCaptureSignatureSyntax(data)
  case .closureParam:
    return ClosureParamSyntax(data)
  case .closureParamList:
    return ClosureParamListSyntax(data)
  case .closureSignature:
    return ClosureSignatureSyntax(data)
  case .closureExpr:
    return ClosureExprSyntax(data)
  case .unresolvedPatternExpr:
    return UnresolvedPatternExprSyntax(data)
  case .functionCallExpr:
    return FunctionCallExprSyntax(data)
  case .subscriptExpr:
    return SubscriptExprSyntax(data)
  case .optionalChainingExpr:
    return OptionalChainingExprSyntax(data)
  case .forcedValueExpr:
    return ForcedValueExprSyntax(data)
  case .postfixUnaryExpr:
    return PostfixUnaryExprSyntax(data)
  case .specializeExpr:
    return SpecializeExprSyntax(data)
  case .stringSegment:
    return StringSegmentSyntax(data)
  case .expressionSegment:
    return ExpressionSegmentSyntax(data)
  case .stringLiteralExpr:
    return StringLiteralExprSyntax(data)
  case .keyPathExpr:
    return KeyPathExprSyntax(data)
  case .keyPathBaseExpr:
    return KeyPathBaseExprSyntax(data)
  case .objcNamePiece:
    return ObjcNamePieceSyntax(data)
  case .objcName:
    return ObjcNameSyntax(data)
  case .objcKeyPathExpr:
    return ObjcKeyPathExprSyntax(data)
  case .objcSelectorExpr:
    return ObjcSelectorExprSyntax(data)
  case .editorPlaceholderExpr:
    return EditorPlaceholderExprSyntax(data)
  case .objectLiteralExpr:
    return ObjectLiteralExprSyntax(data)
  case .typeInitializerClause:
    return TypeInitializerClauseSyntax(data)
  case .typealiasDecl:
    return TypealiasDeclSyntax(data)
  case .associatedtypeDecl:
    return AssociatedtypeDeclSyntax(data)
  case .functionParameterList:
    return FunctionParameterListSyntax(data)
  case .parameterClause:
    return ParameterClauseSyntax(data)
  case .returnClause:
    return ReturnClauseSyntax(data)
  case .functionSignature:
    return FunctionSignatureSyntax(data)
  case .ifConfigClause:
    return IfConfigClauseSyntax(data)
  case .ifConfigClauseList:
    return IfConfigClauseListSyntax(data)
  case .ifConfigDecl:
    return IfConfigDeclSyntax(data)
  case .poundErrorDecl:
    return PoundErrorDeclSyntax(data)
  case .poundWarningDecl:
    return PoundWarningDeclSyntax(data)
  case .poundSourceLocation:
    return PoundSourceLocationSyntax(data)
  case .poundSourceLocationArgs:
    return PoundSourceLocationArgsSyntax(data)
  case .declModifier:
    return DeclModifierSyntax(data)
  case .inheritedType:
    return InheritedTypeSyntax(data)
  case .inheritedTypeList:
    return InheritedTypeListSyntax(data)
  case .typeInheritanceClause:
    return TypeInheritanceClauseSyntax(data)
  case .classDecl:
    return ClassDeclSyntax(data)
  case .structDecl:
    return StructDeclSyntax(data)
  case .protocolDecl:
    return ProtocolDeclSyntax(data)
  case .extensionDecl:
    return ExtensionDeclSyntax(data)
  case .memberDeclBlock:
    return MemberDeclBlockSyntax(data)
  case .memberDeclList:
    return MemberDeclListSyntax(data)
  case .memberDeclListItem:
    return MemberDeclListItemSyntax(data)
  case .sourceFile:
    return SourceFileSyntax(data)
  case .initializerClause:
    return InitializerClauseSyntax(data)
  case .functionParameter:
    return FunctionParameterSyntax(data)
  case .modifierList:
    return ModifierListSyntax(data)
  case .functionDecl:
    return FunctionDeclSyntax(data)
  case .initializerDecl:
    return InitializerDeclSyntax(data)
  case .deinitializerDecl:
    return DeinitializerDeclSyntax(data)
  case .subscriptDecl:
    return SubscriptDeclSyntax(data)
  case .accessLevelModifier:
    return AccessLevelModifierSyntax(data)
  case .accessPathComponent:
    return AccessPathComponentSyntax(data)
  case .accessPath:
    return AccessPathSyntax(data)
  case .importDecl:
    return ImportDeclSyntax(data)
  case .accessorParameter:
    return AccessorParameterSyntax(data)
  case .accessorDecl:
    return AccessorDeclSyntax(data)
  case .accessorList:
    return AccessorListSyntax(data)
  case .accessorBlock:
    return AccessorBlockSyntax(data)
  case .patternBinding:
    return PatternBindingSyntax(data)
  case .patternBindingList:
    return PatternBindingListSyntax(data)
  case .variableDecl:
    return VariableDeclSyntax(data)
  case .enumCaseElement:
    return EnumCaseElementSyntax(data)
  case .enumCaseElementList:
    return EnumCaseElementListSyntax(data)
  case .enumCaseDecl:
    return EnumCaseDeclSyntax(data)
  case .enumDecl:
    return EnumDeclSyntax(data)
  case .operatorDecl:
    return OperatorDeclSyntax(data)
  case .identifierList:
    return IdentifierListSyntax(data)
  case .operatorPrecedenceAndTypes:
    return OperatorPrecedenceAndTypesSyntax(data)
  case .precedenceGroupDecl:
    return PrecedenceGroupDeclSyntax(data)
  case .precedenceGroupAttributeList:
    return PrecedenceGroupAttributeListSyntax(data)
  case .precedenceGroupRelation:
    return PrecedenceGroupRelationSyntax(data)
  case .precedenceGroupNameList:
    return PrecedenceGroupNameListSyntax(data)
  case .precedenceGroupNameElement:
    return PrecedenceGroupNameElementSyntax(data)
  case .precedenceGroupAssignment:
    return PrecedenceGroupAssignmentSyntax(data)
  case .precedenceGroupAssociativity:
    return PrecedenceGroupAssociativitySyntax(data)
  case .tokenList:
    return TokenListSyntax(data)
  case .nonEmptyTokenList:
    return NonEmptyTokenListSyntax(data)
  case .customAttribute:
    return CustomAttributeSyntax(data)
  case .attribute:
    return AttributeSyntax(data)
  case .attributeList:
    return AttributeListSyntax(data)
  case .specializeAttributeSpecList:
    return SpecializeAttributeSpecListSyntax(data)
  case .labeledSpecializeEntry:
    return LabeledSpecializeEntrySyntax(data)
  case .namedAttributeStringArgument:
    return NamedAttributeStringArgumentSyntax(data)
  case .declName:
    return DeclNameSyntax(data)
  case .implementsAttributeArguments:
    return ImplementsAttributeArgumentsSyntax(data)
  case .objCSelectorPiece:
    return ObjCSelectorPieceSyntax(data)
  case .objCSelector:
    return ObjCSelectorSyntax(data)
  case .continueStmt:
    return ContinueStmtSyntax(data)
  case .whileStmt:
    return WhileStmtSyntax(data)
  case .deferStmt:
    return DeferStmtSyntax(data)
  case .expressionStmt:
    return ExpressionStmtSyntax(data)
  case .switchCaseList:
    return SwitchCaseListSyntax(data)
  case .repeatWhileStmt:
    return RepeatWhileStmtSyntax(data)
  case .guardStmt:
    return GuardStmtSyntax(data)
  case .whereClause:
    return WhereClauseSyntax(data)
  case .forInStmt:
    return ForInStmtSyntax(data)
  case .switchStmt:
    return SwitchStmtSyntax(data)
  case .catchClauseList:
    return CatchClauseListSyntax(data)
  case .doStmt:
    return DoStmtSyntax(data)
  case .returnStmt:
    return ReturnStmtSyntax(data)
  case .yieldStmt:
    return YieldStmtSyntax(data)
  case .yieldList:
    return YieldListSyntax(data)
  case .fallthroughStmt:
    return FallthroughStmtSyntax(data)
  case .breakStmt:
    return BreakStmtSyntax(data)
  case .caseItemList:
    return CaseItemListSyntax(data)
  case .conditionElement:
    return ConditionElementSyntax(data)
  case .availabilityCondition:
    return AvailabilityConditionSyntax(data)
  case .matchingPatternCondition:
    return MatchingPatternConditionSyntax(data)
  case .optionalBindingCondition:
    return OptionalBindingConditionSyntax(data)
  case .conditionElementList:
    return ConditionElementListSyntax(data)
  case .declarationStmt:
    return DeclarationStmtSyntax(data)
  case .throwStmt:
    return ThrowStmtSyntax(data)
  case .ifStmt:
    return IfStmtSyntax(data)
  case .elseIfContinuation:
    return ElseIfContinuationSyntax(data)
  case .elseBlock:
    return ElseBlockSyntax(data)
  case .switchCase:
    return SwitchCaseSyntax(data)
  case .switchDefaultLabel:
    return SwitchDefaultLabelSyntax(data)
  case .caseItem:
    return CaseItemSyntax(data)
  case .switchCaseLabel:
    return SwitchCaseLabelSyntax(data)
  case .catchClause:
    return CatchClauseSyntax(data)
  case .poundAssertStmt:
    return PoundAssertStmtSyntax(data)
  case .genericWhereClause:
    return GenericWhereClauseSyntax(data)
  case .genericRequirementList:
    return GenericRequirementListSyntax(data)
  case .sameTypeRequirement:
    return SameTypeRequirementSyntax(data)
  case .genericParameterList:
    return GenericParameterListSyntax(data)
  case .genericParameter:
    return GenericParameterSyntax(data)
  case .genericParameterClause:
    return GenericParameterClauseSyntax(data)
  case .conformanceRequirement:
    return ConformanceRequirementSyntax(data)
  case .simpleTypeIdentifier:
    return SimpleTypeIdentifierSyntax(data)
  case .memberTypeIdentifier:
    return MemberTypeIdentifierSyntax(data)
  case .classRestrictionType:
    return ClassRestrictionTypeSyntax(data)
  case .arrayType:
    return ArrayTypeSyntax(data)
  case .dictionaryType:
    return DictionaryTypeSyntax(data)
  case .metatypeType:
    return MetatypeTypeSyntax(data)
  case .optionalType:
    return OptionalTypeSyntax(data)
  case .someType:
    return SomeTypeSyntax(data)
  case .implicitlyUnwrappedOptionalType:
    return ImplicitlyUnwrappedOptionalTypeSyntax(data)
  case .compositionTypeElement:
    return CompositionTypeElementSyntax(data)
  case .compositionTypeElementList:
    return CompositionTypeElementListSyntax(data)
  case .compositionType:
    return CompositionTypeSyntax(data)
  case .tupleTypeElement:
    return TupleTypeElementSyntax(data)
  case .tupleTypeElementList:
    return TupleTypeElementListSyntax(data)
  case .tupleType:
    return TupleTypeSyntax(data)
  case .functionType:
    return FunctionTypeSyntax(data)
  case .attributedType:
    return AttributedTypeSyntax(data)
  case .genericArgumentList:
    return GenericArgumentListSyntax(data)
  case .genericArgument:
    return GenericArgumentSyntax(data)
  case .genericArgumentClause:
    return GenericArgumentClauseSyntax(data)
  case .typeAnnotation:
    return TypeAnnotationSyntax(data)
  case .enumCasePattern:
    return EnumCasePatternSyntax(data)
  case .isTypePattern:
    return IsTypePatternSyntax(data)
  case .optionalPattern:
    return OptionalPatternSyntax(data)
  case .identifierPattern:
    return IdentifierPatternSyntax(data)
  case .asTypePattern:
    return AsTypePatternSyntax(data)
  case .tuplePattern:
    return TuplePatternSyntax(data)
  case .wildcardPattern:
    return WildcardPatternSyntax(data)
  case .tuplePatternElement:
    return TuplePatternElementSyntax(data)
  case .expressionPattern:
    return ExpressionPatternSyntax(data)
  case .tuplePatternElementList:
    return TuplePatternElementListSyntax(data)
  case .valueBindingPattern:
    return ValueBindingPatternSyntax(data)
  case .availabilitySpecList:
    return AvailabilitySpecListSyntax(data)
  case .availabilityArgument:
    return AvailabilityArgumentSyntax(data)
  case .availabilityLabeledArgument:
    return AvailabilityLabeledArgumentSyntax(data)
  case .availabilityVersionRestriction:
    return AvailabilityVersionRestrictionSyntax(data)
  case .versionTuple:
    return VersionTupleSyntax(data)
  }
}
