//// Automatically Generated From Misc.swift.gyb.
//// Do Not Edit Directly!
//===---------- Misc.swift - Miscelaneous SwiftSyntax definitions ---------===//
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

extension Syntax {
  public static var structure: SyntaxNodeStructure {
    return .choices([
      .node(UnknownSyntax.self),
      .node(TokenSyntax.self),
      .node(UnknownDeclSyntax.self),
      .node(UnknownExprSyntax.self),
      .node(UnknownStmtSyntax.self),
      .node(UnknownTypeSyntax.self),
      .node(UnknownPatternSyntax.self),
      .node(MissingSyntax.self),
      .node(MissingDeclSyntax.self),
      .node(MissingExprSyntax.self),
      .node(MissingStmtSyntax.self),
      .node(MissingTypeSyntax.self),
      .node(MissingPatternSyntax.self),
      .node(CodeBlockItemSyntax.self),
      .node(CodeBlockItemListSyntax.self),
      .node(CodeBlockSyntax.self),
      .node(UnexpectedNodesSyntax.self),
      .node(InOutExprSyntax.self),
      .node(PoundColumnExprSyntax.self),
      .node(TupleExprElementListSyntax.self),
      .node(ArrayElementListSyntax.self),
      .node(DictionaryElementListSyntax.self),
      .node(StringLiteralSegmentsSyntax.self),
      .node(TryExprSyntax.self),
      .node(AwaitExprSyntax.self),
      .node(MoveExprSyntax.self),
      .node(DeclNameArgumentSyntax.self),
      .node(DeclNameArgumentListSyntax.self),
      .node(DeclNameArgumentsSyntax.self),
      .node(IdentifierExprSyntax.self),
      .node(SuperRefExprSyntax.self),
      .node(NilLiteralExprSyntax.self),
      .node(DiscardAssignmentExprSyntax.self),
      .node(AssignmentExprSyntax.self),
      .node(SequenceExprSyntax.self),
      .node(ExprListSyntax.self),
      .node(PoundLineExprSyntax.self),
      .node(PoundFileExprSyntax.self),
      .node(PoundFileIDExprSyntax.self),
      .node(PoundFilePathExprSyntax.self),
      .node(PoundFunctionExprSyntax.self),
      .node(PoundDsohandleExprSyntax.self),
      .node(SymbolicReferenceExprSyntax.self),
      .node(PrefixOperatorExprSyntax.self),
      .node(BinaryOperatorExprSyntax.self),
      .node(ArrowExprSyntax.self),
      .node(InfixOperatorExprSyntax.self),
      .node(FloatLiteralExprSyntax.self),
      .node(TupleExprSyntax.self),
      .node(ArrayExprSyntax.self),
      .node(DictionaryExprSyntax.self),
      .node(TupleExprElementSyntax.self),
      .node(ArrayElementSyntax.self),
      .node(DictionaryElementSyntax.self),
      .node(IntegerLiteralExprSyntax.self),
      .node(BooleanLiteralExprSyntax.self),
      .node(UnresolvedTernaryExprSyntax.self),
      .node(TernaryExprSyntax.self),
      .node(MemberAccessExprSyntax.self),
      .node(UnresolvedIsExprSyntax.self),
      .node(IsExprSyntax.self),
      .node(UnresolvedAsExprSyntax.self),
      .node(AsExprSyntax.self),
      .node(TypeExprSyntax.self),
      .node(ClosureCaptureItemSyntax.self),
      .node(ClosureCaptureItemListSyntax.self),
      .node(ClosureCaptureSignatureSyntax.self),
      .node(ClosureParamSyntax.self),
      .node(ClosureParamListSyntax.self),
      .node(ClosureSignatureSyntax.self),
      .node(ClosureExprSyntax.self),
      .node(UnresolvedPatternExprSyntax.self),
      .node(MultipleTrailingClosureElementSyntax.self),
      .node(MultipleTrailingClosureElementListSyntax.self),
      .node(FunctionCallExprSyntax.self),
      .node(SubscriptExprSyntax.self),
      .node(OptionalChainingExprSyntax.self),
      .node(ForcedValueExprSyntax.self),
      .node(PostfixUnaryExprSyntax.self),
      .node(SpecializeExprSyntax.self),
      .node(StringSegmentSyntax.self),
      .node(ExpressionSegmentSyntax.self),
      .node(StringLiteralExprSyntax.self),
      .node(RegexLiteralExprSyntax.self),
      .node(KeyPathExprSyntax.self),
      .node(KeyPathComponentListSyntax.self),
      .node(KeyPathComponentSyntax.self),
      .node(KeyPathPropertyComponentSyntax.self),
      .node(KeyPathSubscriptComponentSyntax.self),
      .node(KeyPathOptionalComponentSyntax.self),
      .node(OldKeyPathExprSyntax.self),
      .node(KeyPathBaseExprSyntax.self),
      .node(ObjcNamePieceSyntax.self),
      .node(ObjcNameSyntax.self),
      .node(ObjcKeyPathExprSyntax.self),
      .node(ObjcSelectorExprSyntax.self),
      .node(MacroExpansionExprSyntax.self),
      .node(PostfixIfConfigExprSyntax.self),
      .node(EditorPlaceholderExprSyntax.self),
      .node(ObjectLiteralExprSyntax.self),
      .node(YieldExprListSyntax.self),
      .node(YieldExprListElementSyntax.self),
      .node(TypeInitializerClauseSyntax.self),
      .node(TypealiasDeclSyntax.self),
      .node(AssociatedtypeDeclSyntax.self),
      .node(FunctionParameterListSyntax.self),
      .node(ParameterClauseSyntax.self),
      .node(ReturnClauseSyntax.self),
      .node(FunctionSignatureSyntax.self),
      .node(IfConfigClauseSyntax.self),
      .node(IfConfigClauseListSyntax.self),
      .node(IfConfigDeclSyntax.self),
      .node(PoundErrorDeclSyntax.self),
      .node(PoundWarningDeclSyntax.self),
      .node(PoundSourceLocationSyntax.self),
      .node(PoundSourceLocationArgsSyntax.self),
      .node(DeclModifierDetailSyntax.self),
      .node(DeclModifierSyntax.self),
      .node(InheritedTypeSyntax.self),
      .node(InheritedTypeListSyntax.self),
      .node(TypeInheritanceClauseSyntax.self),
      .node(ClassDeclSyntax.self),
      .node(ActorDeclSyntax.self),
      .node(StructDeclSyntax.self),
      .node(ProtocolDeclSyntax.self),
      .node(ExtensionDeclSyntax.self),
      .node(MemberDeclBlockSyntax.self),
      .node(MemberDeclListSyntax.self),
      .node(MemberDeclListItemSyntax.self),
      .node(SourceFileSyntax.self),
      .node(InitializerClauseSyntax.self),
      .node(FunctionParameterSyntax.self),
      .node(ModifierListSyntax.self),
      .node(FunctionDeclSyntax.self),
      .node(InitializerDeclSyntax.self),
      .node(DeinitializerDeclSyntax.self),
      .node(SubscriptDeclSyntax.self),
      .node(AccessLevelModifierSyntax.self),
      .node(AccessPathComponentSyntax.self),
      .node(AccessPathSyntax.self),
      .node(ImportDeclSyntax.self),
      .node(AccessorParameterSyntax.self),
      .node(AccessorDeclSyntax.self),
      .node(AccessorListSyntax.self),
      .node(AccessorBlockSyntax.self),
      .node(PatternBindingSyntax.self),
      .node(PatternBindingListSyntax.self),
      .node(VariableDeclSyntax.self),
      .node(EnumCaseElementSyntax.self),
      .node(EnumCaseElementListSyntax.self),
      .node(EnumCaseDeclSyntax.self),
      .node(EnumDeclSyntax.self),
      .node(OperatorDeclSyntax.self),
      .node(DesignatedTypeListSyntax.self),
      .node(DesignatedTypeElementSyntax.self),
      .node(OperatorPrecedenceAndTypesSyntax.self),
      .node(PrecedenceGroupDeclSyntax.self),
      .node(PrecedenceGroupAttributeListSyntax.self),
      .node(PrecedenceGroupRelationSyntax.self),
      .node(PrecedenceGroupNameListSyntax.self),
      .node(PrecedenceGroupNameElementSyntax.self),
      .node(PrecedenceGroupAssignmentSyntax.self),
      .node(PrecedenceGroupAssociativitySyntax.self),
      .node(MacroExpansionDeclSyntax.self),
      .node(TokenListSyntax.self),
      .node(NonEmptyTokenListSyntax.self),
      .node(CustomAttributeSyntax.self),
      .node(AttributeSyntax.self),
      .node(AttributeListSyntax.self),
      .node(SpecializeAttributeSpecListSyntax.self),
      .node(AvailabilityEntrySyntax.self),
      .node(LabeledSpecializeEntrySyntax.self),
      .node(TargetFunctionEntrySyntax.self),
      .node(NamedAttributeStringArgumentSyntax.self),
      .node(DeclNameSyntax.self),
      .node(ImplementsAttributeArgumentsSyntax.self),
      .node(ObjCSelectorPieceSyntax.self),
      .node(ObjCSelectorSyntax.self),
      .node(DifferentiableAttributeArgumentsSyntax.self),
      .node(DifferentiabilityParamsClauseSyntax.self),
      .node(DifferentiabilityParamsSyntax.self),
      .node(DifferentiabilityParamListSyntax.self),
      .node(DifferentiabilityParamSyntax.self),
      .node(DerivativeRegistrationAttributeArgumentsSyntax.self),
      .node(QualifiedDeclNameSyntax.self),
      .node(FunctionDeclNameSyntax.self),
      .node(BackDeployAttributeSpecListSyntax.self),
      .node(BackDeployVersionListSyntax.self),
      .node(BackDeployVersionArgumentSyntax.self),
      .node(OpaqueReturnTypeOfAttributeArgumentsSyntax.self),
      .node(ConventionAttributeArgumentsSyntax.self),
      .node(ConventionWitnessMethodAttributeArgumentsSyntax.self),
      .node(LabeledStmtSyntax.self),
      .node(ContinueStmtSyntax.self),
      .node(WhileStmtSyntax.self),
      .node(DeferStmtSyntax.self),
      .node(ExpressionStmtSyntax.self),
      .node(SwitchCaseListSyntax.self),
      .node(RepeatWhileStmtSyntax.self),
      .node(GuardStmtSyntax.self),
      .node(WhereClauseSyntax.self),
      .node(ForInStmtSyntax.self),
      .node(SwitchStmtSyntax.self),
      .node(CatchClauseListSyntax.self),
      .node(DoStmtSyntax.self),
      .node(ReturnStmtSyntax.self),
      .node(YieldStmtSyntax.self),
      .node(YieldListSyntax.self),
      .node(FallthroughStmtSyntax.self),
      .node(BreakStmtSyntax.self),
      .node(CaseItemListSyntax.self),
      .node(CatchItemListSyntax.self),
      .node(ConditionElementSyntax.self),
      .node(AvailabilityConditionSyntax.self),
      .node(MatchingPatternConditionSyntax.self),
      .node(OptionalBindingConditionSyntax.self),
      .node(UnavailabilityConditionSyntax.self),
      .node(HasSymbolConditionSyntax.self),
      .node(ConditionElementListSyntax.self),
      .node(DeclarationStmtSyntax.self),
      .node(ThrowStmtSyntax.self),
      .node(IfStmtSyntax.self),
      .node(SwitchCaseSyntax.self),
      .node(SwitchDefaultLabelSyntax.self),
      .node(CaseItemSyntax.self),
      .node(CatchItemSyntax.self),
      .node(SwitchCaseLabelSyntax.self),
      .node(CatchClauseSyntax.self),
      .node(PoundAssertStmtSyntax.self),
      .node(GenericWhereClauseSyntax.self),
      .node(GenericRequirementListSyntax.self),
      .node(GenericRequirementSyntax.self),
      .node(SameTypeRequirementSyntax.self),
      .node(LayoutRequirementSyntax.self),
      .node(GenericParameterListSyntax.self),
      .node(GenericParameterSyntax.self),
      .node(PrimaryAssociatedTypeListSyntax.self),
      .node(PrimaryAssociatedTypeSyntax.self),
      .node(GenericParameterClauseSyntax.self),
      .node(ConformanceRequirementSyntax.self),
      .node(PrimaryAssociatedTypeClauseSyntax.self),
      .node(SimpleTypeIdentifierSyntax.self),
      .node(MemberTypeIdentifierSyntax.self),
      .node(ClassRestrictionTypeSyntax.self),
      .node(ArrayTypeSyntax.self),
      .node(DictionaryTypeSyntax.self),
      .node(MetatypeTypeSyntax.self),
      .node(OptionalTypeSyntax.self),
      .node(ConstrainedSugarTypeSyntax.self),
      .node(ImplicitlyUnwrappedOptionalTypeSyntax.self),
      .node(CompositionTypeElementSyntax.self),
      .node(CompositionTypeElementListSyntax.self),
      .node(CompositionTypeSyntax.self),
      .node(PackExpansionTypeSyntax.self),
      .node(TupleTypeElementSyntax.self),
      .node(TupleTypeElementListSyntax.self),
      .node(TupleTypeSyntax.self),
      .node(FunctionTypeSyntax.self),
      .node(AttributedTypeSyntax.self),
      .node(GenericArgumentListSyntax.self),
      .node(GenericArgumentSyntax.self),
      .node(GenericArgumentClauseSyntax.self),
      .node(NamedOpaqueReturnTypeSyntax.self),
      .node(TypeAnnotationSyntax.self),
      .node(EnumCasePatternSyntax.self),
      .node(IsTypePatternSyntax.self),
      .node(OptionalPatternSyntax.self),
      .node(IdentifierPatternSyntax.self),
      .node(AsTypePatternSyntax.self),
      .node(TuplePatternSyntax.self),
      .node(WildcardPatternSyntax.self),
      .node(TuplePatternElementSyntax.self),
      .node(ExpressionPatternSyntax.self),
      .node(TuplePatternElementListSyntax.self),
      .node(ValueBindingPatternSyntax.self),
      .node(AvailabilitySpecListSyntax.self),
      .node(AvailabilityArgumentSyntax.self),
      .node(AvailabilityLabeledArgumentSyntax.self),
      .node(AvailabilityVersionRestrictionSyntax.self),
      .node(VersionTupleSyntax.self),
    ])
  }
}

extension SyntaxKind {
  var syntaxNodeType: SyntaxProtocol.Type {
    switch self {
    case .token: return TokenSyntax.self
    case .unknown: return UnknownSyntax.self
    case .unknownDecl: return UnknownDeclSyntax.self
    case .unknownExpr: return UnknownExprSyntax.self
    case .unknownStmt: return UnknownStmtSyntax.self
    case .unknownType: return UnknownTypeSyntax.self
    case .unknownPattern: return UnknownPatternSyntax.self
    case .missing: return MissingSyntax.self
    case .missingDecl: return MissingDeclSyntax.self
    case .missingExpr: return MissingExprSyntax.self
    case .missingStmt: return MissingStmtSyntax.self
    case .missingType: return MissingTypeSyntax.self
    case .missingPattern: return MissingPatternSyntax.self
    case .codeBlockItem: return CodeBlockItemSyntax.self
    case .codeBlockItemList: return CodeBlockItemListSyntax.self
    case .codeBlock: return CodeBlockSyntax.self
    case .unexpectedNodes: return UnexpectedNodesSyntax.self
    case .inOutExpr: return InOutExprSyntax.self
    case .poundColumnExpr: return PoundColumnExprSyntax.self
    case .tupleExprElementList: return TupleExprElementListSyntax.self
    case .arrayElementList: return ArrayElementListSyntax.self
    case .dictionaryElementList: return DictionaryElementListSyntax.self
    case .stringLiteralSegments: return StringLiteralSegmentsSyntax.self
    case .tryExpr: return TryExprSyntax.self
    case .awaitExpr: return AwaitExprSyntax.self
    case .moveExpr: return MoveExprSyntax.self
    case .declNameArgument: return DeclNameArgumentSyntax.self
    case .declNameArgumentList: return DeclNameArgumentListSyntax.self
    case .declNameArguments: return DeclNameArgumentsSyntax.self
    case .identifierExpr: return IdentifierExprSyntax.self
    case .superRefExpr: return SuperRefExprSyntax.self
    case .nilLiteralExpr: return NilLiteralExprSyntax.self
    case .discardAssignmentExpr: return DiscardAssignmentExprSyntax.self
    case .assignmentExpr: return AssignmentExprSyntax.self
    case .sequenceExpr: return SequenceExprSyntax.self
    case .exprList: return ExprListSyntax.self
    case .poundLineExpr: return PoundLineExprSyntax.self
    case .poundFileExpr: return PoundFileExprSyntax.self
    case .poundFileIDExpr: return PoundFileIDExprSyntax.self
    case .poundFilePathExpr: return PoundFilePathExprSyntax.self
    case .poundFunctionExpr: return PoundFunctionExprSyntax.self
    case .poundDsohandleExpr: return PoundDsohandleExprSyntax.self
    case .symbolicReferenceExpr: return SymbolicReferenceExprSyntax.self
    case .prefixOperatorExpr: return PrefixOperatorExprSyntax.self
    case .binaryOperatorExpr: return BinaryOperatorExprSyntax.self
    case .arrowExpr: return ArrowExprSyntax.self
    case .infixOperatorExpr: return InfixOperatorExprSyntax.self
    case .floatLiteralExpr: return FloatLiteralExprSyntax.self
    case .tupleExpr: return TupleExprSyntax.self
    case .arrayExpr: return ArrayExprSyntax.self
    case .dictionaryExpr: return DictionaryExprSyntax.self
    case .tupleExprElement: return TupleExprElementSyntax.self
    case .arrayElement: return ArrayElementSyntax.self
    case .dictionaryElement: return DictionaryElementSyntax.self
    case .integerLiteralExpr: return IntegerLiteralExprSyntax.self
    case .booleanLiteralExpr: return BooleanLiteralExprSyntax.self
    case .unresolvedTernaryExpr: return UnresolvedTernaryExprSyntax.self
    case .ternaryExpr: return TernaryExprSyntax.self
    case .memberAccessExpr: return MemberAccessExprSyntax.self
    case .unresolvedIsExpr: return UnresolvedIsExprSyntax.self
    case .isExpr: return IsExprSyntax.self
    case .unresolvedAsExpr: return UnresolvedAsExprSyntax.self
    case .asExpr: return AsExprSyntax.self
    case .typeExpr: return TypeExprSyntax.self
    case .closureCaptureItem: return ClosureCaptureItemSyntax.self
    case .closureCaptureItemList: return ClosureCaptureItemListSyntax.self
    case .closureCaptureSignature: return ClosureCaptureSignatureSyntax.self
    case .closureParam: return ClosureParamSyntax.self
    case .closureParamList: return ClosureParamListSyntax.self
    case .closureSignature: return ClosureSignatureSyntax.self
    case .closureExpr: return ClosureExprSyntax.self
    case .unresolvedPatternExpr: return UnresolvedPatternExprSyntax.self
    case .multipleTrailingClosureElement: return MultipleTrailingClosureElementSyntax.self
    case .multipleTrailingClosureElementList: return MultipleTrailingClosureElementListSyntax.self
    case .functionCallExpr: return FunctionCallExprSyntax.self
    case .subscriptExpr: return SubscriptExprSyntax.self
    case .optionalChainingExpr: return OptionalChainingExprSyntax.self
    case .forcedValueExpr: return ForcedValueExprSyntax.self
    case .postfixUnaryExpr: return PostfixUnaryExprSyntax.self
    case .specializeExpr: return SpecializeExprSyntax.self
    case .stringSegment: return StringSegmentSyntax.self
    case .expressionSegment: return ExpressionSegmentSyntax.self
    case .stringLiteralExpr: return StringLiteralExprSyntax.self
    case .regexLiteralExpr: return RegexLiteralExprSyntax.self
    case .keyPathExpr: return KeyPathExprSyntax.self
    case .keyPathComponentList: return KeyPathComponentListSyntax.self
    case .keyPathComponent: return KeyPathComponentSyntax.self
    case .keyPathPropertyComponent: return KeyPathPropertyComponentSyntax.self
    case .keyPathSubscriptComponent: return KeyPathSubscriptComponentSyntax.self
    case .keyPathOptionalComponent: return KeyPathOptionalComponentSyntax.self
    case .oldKeyPathExpr: return OldKeyPathExprSyntax.self
    case .keyPathBaseExpr: return KeyPathBaseExprSyntax.self
    case .objcNamePiece: return ObjcNamePieceSyntax.self
    case .objcName: return ObjcNameSyntax.self
    case .objcKeyPathExpr: return ObjcKeyPathExprSyntax.self
    case .objcSelectorExpr: return ObjcSelectorExprSyntax.self
    case .macroExpansionExpr: return MacroExpansionExprSyntax.self
    case .postfixIfConfigExpr: return PostfixIfConfigExprSyntax.self
    case .editorPlaceholderExpr: return EditorPlaceholderExprSyntax.self
    case .objectLiteralExpr: return ObjectLiteralExprSyntax.self
    case .yieldExprList: return YieldExprListSyntax.self
    case .yieldExprListElement: return YieldExprListElementSyntax.self
    case .typeInitializerClause: return TypeInitializerClauseSyntax.self
    case .typealiasDecl: return TypealiasDeclSyntax.self
    case .associatedtypeDecl: return AssociatedtypeDeclSyntax.self
    case .functionParameterList: return FunctionParameterListSyntax.self
    case .parameterClause: return ParameterClauseSyntax.self
    case .returnClause: return ReturnClauseSyntax.self
    case .functionSignature: return FunctionSignatureSyntax.self
    case .ifConfigClause: return IfConfigClauseSyntax.self
    case .ifConfigClauseList: return IfConfigClauseListSyntax.self
    case .ifConfigDecl: return IfConfigDeclSyntax.self
    case .poundErrorDecl: return PoundErrorDeclSyntax.self
    case .poundWarningDecl: return PoundWarningDeclSyntax.self
    case .poundSourceLocation: return PoundSourceLocationSyntax.self
    case .poundSourceLocationArgs: return PoundSourceLocationArgsSyntax.self
    case .declModifierDetail: return DeclModifierDetailSyntax.self
    case .declModifier: return DeclModifierSyntax.self
    case .inheritedType: return InheritedTypeSyntax.self
    case .inheritedTypeList: return InheritedTypeListSyntax.self
    case .typeInheritanceClause: return TypeInheritanceClauseSyntax.self
    case .classDecl: return ClassDeclSyntax.self
    case .actorDecl: return ActorDeclSyntax.self
    case .structDecl: return StructDeclSyntax.self
    case .protocolDecl: return ProtocolDeclSyntax.self
    case .extensionDecl: return ExtensionDeclSyntax.self
    case .memberDeclBlock: return MemberDeclBlockSyntax.self
    case .memberDeclList: return MemberDeclListSyntax.self
    case .memberDeclListItem: return MemberDeclListItemSyntax.self
    case .sourceFile: return SourceFileSyntax.self
    case .initializerClause: return InitializerClauseSyntax.self
    case .functionParameter: return FunctionParameterSyntax.self
    case .modifierList: return ModifierListSyntax.self
    case .functionDecl: return FunctionDeclSyntax.self
    case .initializerDecl: return InitializerDeclSyntax.self
    case .deinitializerDecl: return DeinitializerDeclSyntax.self
    case .subscriptDecl: return SubscriptDeclSyntax.self
    case .accessLevelModifier: return AccessLevelModifierSyntax.self
    case .accessPathComponent: return AccessPathComponentSyntax.self
    case .accessPath: return AccessPathSyntax.self
    case .importDecl: return ImportDeclSyntax.self
    case .accessorParameter: return AccessorParameterSyntax.self
    case .accessorDecl: return AccessorDeclSyntax.self
    case .accessorList: return AccessorListSyntax.self
    case .accessorBlock: return AccessorBlockSyntax.self
    case .patternBinding: return PatternBindingSyntax.self
    case .patternBindingList: return PatternBindingListSyntax.self
    case .variableDecl: return VariableDeclSyntax.self
    case .enumCaseElement: return EnumCaseElementSyntax.self
    case .enumCaseElementList: return EnumCaseElementListSyntax.self
    case .enumCaseDecl: return EnumCaseDeclSyntax.self
    case .enumDecl: return EnumDeclSyntax.self
    case .operatorDecl: return OperatorDeclSyntax.self
    case .designatedTypeList: return DesignatedTypeListSyntax.self
    case .designatedTypeElement: return DesignatedTypeElementSyntax.self
    case .operatorPrecedenceAndTypes: return OperatorPrecedenceAndTypesSyntax.self
    case .precedenceGroupDecl: return PrecedenceGroupDeclSyntax.self
    case .precedenceGroupAttributeList: return PrecedenceGroupAttributeListSyntax.self
    case .precedenceGroupRelation: return PrecedenceGroupRelationSyntax.self
    case .precedenceGroupNameList: return PrecedenceGroupNameListSyntax.self
    case .precedenceGroupNameElement: return PrecedenceGroupNameElementSyntax.self
    case .precedenceGroupAssignment: return PrecedenceGroupAssignmentSyntax.self
    case .precedenceGroupAssociativity: return PrecedenceGroupAssociativitySyntax.self
    case .macroExpansionDecl: return MacroExpansionDeclSyntax.self
    case .tokenList: return TokenListSyntax.self
    case .nonEmptyTokenList: return NonEmptyTokenListSyntax.self
    case .customAttribute: return CustomAttributeSyntax.self
    case .attribute: return AttributeSyntax.self
    case .attributeList: return AttributeListSyntax.self
    case .specializeAttributeSpecList: return SpecializeAttributeSpecListSyntax.self
    case .availabilityEntry: return AvailabilityEntrySyntax.self
    case .labeledSpecializeEntry: return LabeledSpecializeEntrySyntax.self
    case .targetFunctionEntry: return TargetFunctionEntrySyntax.self
    case .namedAttributeStringArgument: return NamedAttributeStringArgumentSyntax.self
    case .declName: return DeclNameSyntax.self
    case .implementsAttributeArguments: return ImplementsAttributeArgumentsSyntax.self
    case .objCSelectorPiece: return ObjCSelectorPieceSyntax.self
    case .objCSelector: return ObjCSelectorSyntax.self
    case .differentiableAttributeArguments: return DifferentiableAttributeArgumentsSyntax.self
    case .differentiabilityParamsClause: return DifferentiabilityParamsClauseSyntax.self
    case .differentiabilityParams: return DifferentiabilityParamsSyntax.self
    case .differentiabilityParamList: return DifferentiabilityParamListSyntax.self
    case .differentiabilityParam: return DifferentiabilityParamSyntax.self
    case .derivativeRegistrationAttributeArguments: return DerivativeRegistrationAttributeArgumentsSyntax.self
    case .qualifiedDeclName: return QualifiedDeclNameSyntax.self
    case .functionDeclName: return FunctionDeclNameSyntax.self
    case .backDeployAttributeSpecList: return BackDeployAttributeSpecListSyntax.self
    case .backDeployVersionList: return BackDeployVersionListSyntax.self
    case .backDeployVersionArgument: return BackDeployVersionArgumentSyntax.self
    case .opaqueReturnTypeOfAttributeArguments: return OpaqueReturnTypeOfAttributeArgumentsSyntax.self
    case .conventionAttributeArguments: return ConventionAttributeArgumentsSyntax.self
    case .conventionWitnessMethodAttributeArguments: return ConventionWitnessMethodAttributeArgumentsSyntax.self
    case .labeledStmt: return LabeledStmtSyntax.self
    case .continueStmt: return ContinueStmtSyntax.self
    case .whileStmt: return WhileStmtSyntax.self
    case .deferStmt: return DeferStmtSyntax.self
    case .expressionStmt: return ExpressionStmtSyntax.self
    case .switchCaseList: return SwitchCaseListSyntax.self
    case .repeatWhileStmt: return RepeatWhileStmtSyntax.self
    case .guardStmt: return GuardStmtSyntax.self
    case .whereClause: return WhereClauseSyntax.self
    case .forInStmt: return ForInStmtSyntax.self
    case .switchStmt: return SwitchStmtSyntax.self
    case .catchClauseList: return CatchClauseListSyntax.self
    case .doStmt: return DoStmtSyntax.self
    case .returnStmt: return ReturnStmtSyntax.self
    case .yieldStmt: return YieldStmtSyntax.self
    case .yieldList: return YieldListSyntax.self
    case .fallthroughStmt: return FallthroughStmtSyntax.self
    case .breakStmt: return BreakStmtSyntax.self
    case .caseItemList: return CaseItemListSyntax.self
    case .catchItemList: return CatchItemListSyntax.self
    case .conditionElement: return ConditionElementSyntax.self
    case .availabilityCondition: return AvailabilityConditionSyntax.self
    case .matchingPatternCondition: return MatchingPatternConditionSyntax.self
    case .optionalBindingCondition: return OptionalBindingConditionSyntax.self
    case .unavailabilityCondition: return UnavailabilityConditionSyntax.self
    case .hasSymbolCondition: return HasSymbolConditionSyntax.self
    case .conditionElementList: return ConditionElementListSyntax.self
    case .declarationStmt: return DeclarationStmtSyntax.self
    case .throwStmt: return ThrowStmtSyntax.self
    case .ifStmt: return IfStmtSyntax.self
    case .switchCase: return SwitchCaseSyntax.self
    case .switchDefaultLabel: return SwitchDefaultLabelSyntax.self
    case .caseItem: return CaseItemSyntax.self
    case .catchItem: return CatchItemSyntax.self
    case .switchCaseLabel: return SwitchCaseLabelSyntax.self
    case .catchClause: return CatchClauseSyntax.self
    case .poundAssertStmt: return PoundAssertStmtSyntax.self
    case .genericWhereClause: return GenericWhereClauseSyntax.self
    case .genericRequirementList: return GenericRequirementListSyntax.self
    case .genericRequirement: return GenericRequirementSyntax.self
    case .sameTypeRequirement: return SameTypeRequirementSyntax.self
    case .layoutRequirement: return LayoutRequirementSyntax.self
    case .genericParameterList: return GenericParameterListSyntax.self
    case .genericParameter: return GenericParameterSyntax.self
    case .primaryAssociatedTypeList: return PrimaryAssociatedTypeListSyntax.self
    case .primaryAssociatedType: return PrimaryAssociatedTypeSyntax.self
    case .genericParameterClause: return GenericParameterClauseSyntax.self
    case .conformanceRequirement: return ConformanceRequirementSyntax.self
    case .primaryAssociatedTypeClause: return PrimaryAssociatedTypeClauseSyntax.self
    case .simpleTypeIdentifier: return SimpleTypeIdentifierSyntax.self
    case .memberTypeIdentifier: return MemberTypeIdentifierSyntax.self
    case .classRestrictionType: return ClassRestrictionTypeSyntax.self
    case .arrayType: return ArrayTypeSyntax.self
    case .dictionaryType: return DictionaryTypeSyntax.self
    case .metatypeType: return MetatypeTypeSyntax.self
    case .optionalType: return OptionalTypeSyntax.self
    case .constrainedSugarType: return ConstrainedSugarTypeSyntax.self
    case .implicitlyUnwrappedOptionalType: return ImplicitlyUnwrappedOptionalTypeSyntax.self
    case .compositionTypeElement: return CompositionTypeElementSyntax.self
    case .compositionTypeElementList: return CompositionTypeElementListSyntax.self
    case .compositionType: return CompositionTypeSyntax.self
    case .packExpansionType: return PackExpansionTypeSyntax.self
    case .tupleTypeElement: return TupleTypeElementSyntax.self
    case .tupleTypeElementList: return TupleTypeElementListSyntax.self
    case .tupleType: return TupleTypeSyntax.self
    case .functionType: return FunctionTypeSyntax.self
    case .attributedType: return AttributedTypeSyntax.self
    case .genericArgumentList: return GenericArgumentListSyntax.self
    case .genericArgument: return GenericArgumentSyntax.self
    case .genericArgumentClause: return GenericArgumentClauseSyntax.self
    case .namedOpaqueReturnType: return NamedOpaqueReturnTypeSyntax.self
    case .typeAnnotation: return TypeAnnotationSyntax.self
    case .enumCasePattern: return EnumCasePatternSyntax.self
    case .isTypePattern: return IsTypePatternSyntax.self
    case .optionalPattern: return OptionalPatternSyntax.self
    case .identifierPattern: return IdentifierPatternSyntax.self
    case .asTypePattern: return AsTypePatternSyntax.self
    case .tuplePattern: return TuplePatternSyntax.self
    case .wildcardPattern: return WildcardPatternSyntax.self
    case .tuplePatternElement: return TuplePatternElementSyntax.self
    case .expressionPattern: return ExpressionPatternSyntax.self
    case .tuplePatternElementList: return TuplePatternElementListSyntax.self
    case .valueBindingPattern: return ValueBindingPatternSyntax.self
    case .availabilitySpecList: return AvailabilitySpecListSyntax.self
    case .availabilityArgument: return AvailabilityArgumentSyntax.self
    case .availabilityLabeledArgument: return AvailabilityLabeledArgumentSyntax.self
    case .availabilityVersionRestriction: return AvailabilityVersionRestrictionSyntax.self
    case .versionTuple: return VersionTupleSyntax.self
    }
  }
}
