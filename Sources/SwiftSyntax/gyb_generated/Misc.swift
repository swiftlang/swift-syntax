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
  /// Syntax nodes always conform to SyntaxProtocol. This API is just added
  /// for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: SyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: SyntaxProtocol.Protocol) -> SyntaxProtocol {
    switch self.as(SyntaxEnum.self) {
    case .token(let node):
      return node
    case .unknown(let node):
      return node
    case .unknownDecl(let node):
      return node
    case .unknownExpr(let node):
      return node
    case .unknownStmt(let node):
      return node
    case .unknownType(let node):
      return node
    case .unknownPattern(let node):
      return node
    case .missing(let node):
      return node
    case .missingDecl(let node):
      return node
    case .missingExpr(let node):
      return node
    case .missingStmt(let node):
      return node
    case .missingType(let node):
      return node
    case .missingPattern(let node):
      return node
    case .codeBlockItem(let node):
      return node
    case .codeBlockItemList(let node):
      return node
    case .codeBlock(let node):
      return node
    case .unexpectedNodes(let node):
      return node
    case .inOutExpr(let node):
      return node
    case .poundColumnExpr(let node):
      return node
    case .tupleExprElementList(let node):
      return node
    case .arrayElementList(let node):
      return node
    case .dictionaryElementList(let node):
      return node
    case .stringLiteralSegments(let node):
      return node
    case .tryExpr(let node):
      return node
    case .awaitExpr(let node):
      return node
    case .moveExpr(let node):
      return node
    case .declNameArgument(let node):
      return node
    case .declNameArgumentList(let node):
      return node
    case .declNameArguments(let node):
      return node
    case .identifierExpr(let node):
      return node
    case .superRefExpr(let node):
      return node
    case .nilLiteralExpr(let node):
      return node
    case .discardAssignmentExpr(let node):
      return node
    case .assignmentExpr(let node):
      return node
    case .sequenceExpr(let node):
      return node
    case .exprList(let node):
      return node
    case .poundLineExpr(let node):
      return node
    case .poundFileExpr(let node):
      return node
    case .poundFileIDExpr(let node):
      return node
    case .poundFilePathExpr(let node):
      return node
    case .poundFunctionExpr(let node):
      return node
    case .poundDsohandleExpr(let node):
      return node
    case .symbolicReferenceExpr(let node):
      return node
    case .prefixOperatorExpr(let node):
      return node
    case .binaryOperatorExpr(let node):
      return node
    case .arrowExpr(let node):
      return node
    case .infixOperatorExpr(let node):
      return node
    case .floatLiteralExpr(let node):
      return node
    case .tupleExpr(let node):
      return node
    case .arrayExpr(let node):
      return node
    case .dictionaryExpr(let node):
      return node
    case .tupleExprElement(let node):
      return node
    case .arrayElement(let node):
      return node
    case .dictionaryElement(let node):
      return node
    case .integerLiteralExpr(let node):
      return node
    case .booleanLiteralExpr(let node):
      return node
    case .unresolvedTernaryExpr(let node):
      return node
    case .ternaryExpr(let node):
      return node
    case .memberAccessExpr(let node):
      return node
    case .unresolvedIsExpr(let node):
      return node
    case .isExpr(let node):
      return node
    case .unresolvedAsExpr(let node):
      return node
    case .asExpr(let node):
      return node
    case .typeExpr(let node):
      return node
    case .closureCaptureItem(let node):
      return node
    case .closureCaptureItemList(let node):
      return node
    case .closureCaptureSignature(let node):
      return node
    case .closureParam(let node):
      return node
    case .closureParamList(let node):
      return node
    case .closureSignature(let node):
      return node
    case .closureExpr(let node):
      return node
    case .unresolvedPatternExpr(let node):
      return node
    case .multipleTrailingClosureElement(let node):
      return node
    case .multipleTrailingClosureElementList(let node):
      return node
    case .functionCallExpr(let node):
      return node
    case .subscriptExpr(let node):
      return node
    case .optionalChainingExpr(let node):
      return node
    case .forcedValueExpr(let node):
      return node
    case .postfixUnaryExpr(let node):
      return node
    case .specializeExpr(let node):
      return node
    case .stringSegment(let node):
      return node
    case .expressionSegment(let node):
      return node
    case .stringLiteralExpr(let node):
      return node
    case .regexLiteralExpr(let node):
      return node
    case .keyPathExpr(let node):
      return node
    case .keyPathComponentList(let node):
      return node
    case .keyPathComponent(let node):
      return node
    case .keyPathPropertyComponent(let node):
      return node
    case .keyPathSubscriptComponent(let node):
      return node
    case .keyPathOptionalComponent(let node):
      return node
    case .oldKeyPathExpr(let node):
      return node
    case .keyPathBaseExpr(let node):
      return node
    case .objcNamePiece(let node):
      return node
    case .objcName(let node):
      return node
    case .objcKeyPathExpr(let node):
      return node
    case .objcSelectorExpr(let node):
      return node
    case .macroExpansionExpr(let node):
      return node
    case .postfixIfConfigExpr(let node):
      return node
    case .editorPlaceholderExpr(let node):
      return node
    case .objectLiteralExpr(let node):
      return node
    case .yieldExprList(let node):
      return node
    case .yieldExprListElement(let node):
      return node
    case .typeInitializerClause(let node):
      return node
    case .typealiasDecl(let node):
      return node
    case .associatedtypeDecl(let node):
      return node
    case .functionParameterList(let node):
      return node
    case .parameterClause(let node):
      return node
    case .returnClause(let node):
      return node
    case .functionSignature(let node):
      return node
    case .ifConfigClause(let node):
      return node
    case .ifConfigClauseList(let node):
      return node
    case .ifConfigDecl(let node):
      return node
    case .poundErrorDecl(let node):
      return node
    case .poundWarningDecl(let node):
      return node
    case .poundSourceLocation(let node):
      return node
    case .poundSourceLocationArgs(let node):
      return node
    case .declModifierDetail(let node):
      return node
    case .declModifier(let node):
      return node
    case .inheritedType(let node):
      return node
    case .inheritedTypeList(let node):
      return node
    case .typeInheritanceClause(let node):
      return node
    case .classDecl(let node):
      return node
    case .actorDecl(let node):
      return node
    case .structDecl(let node):
      return node
    case .protocolDecl(let node):
      return node
    case .extensionDecl(let node):
      return node
    case .memberDeclBlock(let node):
      return node
    case .memberDeclList(let node):
      return node
    case .memberDeclListItem(let node):
      return node
    case .sourceFile(let node):
      return node
    case .initializerClause(let node):
      return node
    case .functionParameter(let node):
      return node
    case .modifierList(let node):
      return node
    case .functionDecl(let node):
      return node
    case .initializerDecl(let node):
      return node
    case .deinitializerDecl(let node):
      return node
    case .subscriptDecl(let node):
      return node
    case .accessLevelModifier(let node):
      return node
    case .accessPathComponent(let node):
      return node
    case .accessPath(let node):
      return node
    case .importDecl(let node):
      return node
    case .accessorParameter(let node):
      return node
    case .accessorDecl(let node):
      return node
    case .accessorList(let node):
      return node
    case .accessorBlock(let node):
      return node
    case .patternBinding(let node):
      return node
    case .patternBindingList(let node):
      return node
    case .variableDecl(let node):
      return node
    case .enumCaseElement(let node):
      return node
    case .enumCaseElementList(let node):
      return node
    case .enumCaseDecl(let node):
      return node
    case .enumDecl(let node):
      return node
    case .operatorDecl(let node):
      return node
    case .designatedTypeList(let node):
      return node
    case .designatedTypeElement(let node):
      return node
    case .operatorPrecedenceAndTypes(let node):
      return node
    case .precedenceGroupDecl(let node):
      return node
    case .precedenceGroupAttributeList(let node):
      return node
    case .precedenceGroupRelation(let node):
      return node
    case .precedenceGroupNameList(let node):
      return node
    case .precedenceGroupNameElement(let node):
      return node
    case .precedenceGroupAssignment(let node):
      return node
    case .precedenceGroupAssociativity(let node):
      return node
    case .macroExpansionDecl(let node):
      return node
    case .tokenList(let node):
      return node
    case .nonEmptyTokenList(let node):
      return node
    case .customAttribute(let node):
      return node
    case .attribute(let node):
      return node
    case .attributeList(let node):
      return node
    case .specializeAttributeSpecList(let node):
      return node
    case .availabilityEntry(let node):
      return node
    case .labeledSpecializeEntry(let node):
      return node
    case .targetFunctionEntry(let node):
      return node
    case .namedAttributeStringArgument(let node):
      return node
    case .declName(let node):
      return node
    case .implementsAttributeArguments(let node):
      return node
    case .objCSelectorPiece(let node):
      return node
    case .objCSelector(let node):
      return node
    case .differentiableAttributeArguments(let node):
      return node
    case .differentiabilityParamsClause(let node):
      return node
    case .differentiabilityParams(let node):
      return node
    case .differentiabilityParamList(let node):
      return node
    case .differentiabilityParam(let node):
      return node
    case .derivativeRegistrationAttributeArguments(let node):
      return node
    case .qualifiedDeclName(let node):
      return node
    case .functionDeclName(let node):
      return node
    case .backDeployAttributeSpecList(let node):
      return node
    case .backDeployVersionList(let node):
      return node
    case .backDeployVersionArgument(let node):
      return node
    case .opaqueReturnTypeOfAttributeArguments(let node):
      return node
    case .conventionAttributeArguments(let node):
      return node
    case .conventionWitnessMethodAttributeArguments(let node):
      return node
    case .labeledStmt(let node):
      return node
    case .continueStmt(let node):
      return node
    case .whileStmt(let node):
      return node
    case .deferStmt(let node):
      return node
    case .expressionStmt(let node):
      return node
    case .switchCaseList(let node):
      return node
    case .repeatWhileStmt(let node):
      return node
    case .guardStmt(let node):
      return node
    case .whereClause(let node):
      return node
    case .forInStmt(let node):
      return node
    case .switchStmt(let node):
      return node
    case .catchClauseList(let node):
      return node
    case .doStmt(let node):
      return node
    case .returnStmt(let node):
      return node
    case .yieldStmt(let node):
      return node
    case .yieldList(let node):
      return node
    case .fallthroughStmt(let node):
      return node
    case .breakStmt(let node):
      return node
    case .caseItemList(let node):
      return node
    case .catchItemList(let node):
      return node
    case .conditionElement(let node):
      return node
    case .availabilityCondition(let node):
      return node
    case .matchingPatternCondition(let node):
      return node
    case .optionalBindingCondition(let node):
      return node
    case .unavailabilityCondition(let node):
      return node
    case .hasSymbolCondition(let node):
      return node
    case .conditionElementList(let node):
      return node
    case .declarationStmt(let node):
      return node
    case .throwStmt(let node):
      return node
    case .ifStmt(let node):
      return node
    case .switchCase(let node):
      return node
    case .switchDefaultLabel(let node):
      return node
    case .caseItem(let node):
      return node
    case .catchItem(let node):
      return node
    case .switchCaseLabel(let node):
      return node
    case .catchClause(let node):
      return node
    case .poundAssertStmt(let node):
      return node
    case .genericWhereClause(let node):
      return node
    case .genericRequirementList(let node):
      return node
    case .genericRequirement(let node):
      return node
    case .sameTypeRequirement(let node):
      return node
    case .layoutRequirement(let node):
      return node
    case .genericParameterList(let node):
      return node
    case .genericParameter(let node):
      return node
    case .primaryAssociatedTypeList(let node):
      return node
    case .primaryAssociatedType(let node):
      return node
    case .genericParameterClause(let node):
      return node
    case .conformanceRequirement(let node):
      return node
    case .primaryAssociatedTypeClause(let node):
      return node
    case .simpleTypeIdentifier(let node):
      return node
    case .memberTypeIdentifier(let node):
      return node
    case .classRestrictionType(let node):
      return node
    case .arrayType(let node):
      return node
    case .dictionaryType(let node):
      return node
    case .metatypeType(let node):
      return node
    case .optionalType(let node):
      return node
    case .constrainedSugarType(let node):
      return node
    case .implicitlyUnwrappedOptionalType(let node):
      return node
    case .compositionTypeElement(let node):
      return node
    case .compositionTypeElementList(let node):
      return node
    case .compositionType(let node):
      return node
    case .packExpansionType(let node):
      return node
    case .tupleTypeElement(let node):
      return node
    case .tupleTypeElementList(let node):
      return node
    case .tupleType(let node):
      return node
    case .functionType(let node):
      return node
    case .attributedType(let node):
      return node
    case .genericArgumentList(let node):
      return node
    case .genericArgument(let node):
      return node
    case .genericArgumentClause(let node):
      return node
    case .namedOpaqueReturnType(let node):
      return node
    case .typeAnnotation(let node):
      return node
    case .enumCasePattern(let node):
      return node
    case .isTypePattern(let node):
      return node
    case .optionalPattern(let node):
      return node
    case .identifierPattern(let node):
      return node
    case .asTypePattern(let node):
      return node
    case .tuplePattern(let node):
      return node
    case .wildcardPattern(let node):
      return node
    case .tuplePatternElement(let node):
      return node
    case .expressionPattern(let node):
      return node
    case .tuplePatternElementList(let node):
      return node
    case .valueBindingPattern(let node):
      return node
    case .availabilitySpecList(let node):
      return node
    case .availabilityArgument(let node):
      return node
    case .availabilityLabeledArgument(let node):
      return node
    case .availabilityVersionRestriction(let node):
      return node
    case .versionTuple(let node):
      return node
    }
  }

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

  public func childNameForDiagnostics(_ index: SyntaxChildrenIndex) -> String? {
    switch self.as(SyntaxEnum.self) {
    case .token(let node):
      return node.childNameForDiagnostics(index)
    case .unknown(let node):
      return node.childNameForDiagnostics(index)
    case .unknownDecl(let node):
      return node.childNameForDiagnostics(index)
    case .unknownExpr(let node):
      return node.childNameForDiagnostics(index)
    case .unknownStmt(let node):
      return node.childNameForDiagnostics(index)
    case .unknownType(let node):
      return node.childNameForDiagnostics(index)
    case .unknownPattern(let node):
      return node.childNameForDiagnostics(index)
    case .missing(let node):
      return node.childNameForDiagnostics(index)
    case .missingDecl(let node):
      return node.childNameForDiagnostics(index)
    case .missingExpr(let node):
      return node.childNameForDiagnostics(index)
    case .missingStmt(let node):
      return node.childNameForDiagnostics(index)
    case .missingType(let node):
      return node.childNameForDiagnostics(index)
    case .missingPattern(let node):
      return node.childNameForDiagnostics(index)
    case .codeBlockItem(let node):
      return node.childNameForDiagnostics(index)
    case .codeBlockItemList(let node):
      return node.childNameForDiagnostics(index)
    case .codeBlock(let node):
      return node.childNameForDiagnostics(index)
    case .unexpectedNodes(let node):
      return node.childNameForDiagnostics(index)
    case .inOutExpr(let node):
      return node.childNameForDiagnostics(index)
    case .poundColumnExpr(let node):
      return node.childNameForDiagnostics(index)
    case .tupleExprElementList(let node):
      return node.childNameForDiagnostics(index)
    case .arrayElementList(let node):
      return node.childNameForDiagnostics(index)
    case .dictionaryElementList(let node):
      return node.childNameForDiagnostics(index)
    case .stringLiteralSegments(let node):
      return node.childNameForDiagnostics(index)
    case .tryExpr(let node):
      return node.childNameForDiagnostics(index)
    case .awaitExpr(let node):
      return node.childNameForDiagnostics(index)
    case .moveExpr(let node):
      return node.childNameForDiagnostics(index)
    case .declNameArgument(let node):
      return node.childNameForDiagnostics(index)
    case .declNameArgumentList(let node):
      return node.childNameForDiagnostics(index)
    case .declNameArguments(let node):
      return node.childNameForDiagnostics(index)
    case .identifierExpr(let node):
      return node.childNameForDiagnostics(index)
    case .superRefExpr(let node):
      return node.childNameForDiagnostics(index)
    case .nilLiteralExpr(let node):
      return node.childNameForDiagnostics(index)
    case .discardAssignmentExpr(let node):
      return node.childNameForDiagnostics(index)
    case .assignmentExpr(let node):
      return node.childNameForDiagnostics(index)
    case .sequenceExpr(let node):
      return node.childNameForDiagnostics(index)
    case .exprList(let node):
      return node.childNameForDiagnostics(index)
    case .poundLineExpr(let node):
      return node.childNameForDiagnostics(index)
    case .poundFileExpr(let node):
      return node.childNameForDiagnostics(index)
    case .poundFileIDExpr(let node):
      return node.childNameForDiagnostics(index)
    case .poundFilePathExpr(let node):
      return node.childNameForDiagnostics(index)
    case .poundFunctionExpr(let node):
      return node.childNameForDiagnostics(index)
    case .poundDsohandleExpr(let node):
      return node.childNameForDiagnostics(index)
    case .symbolicReferenceExpr(let node):
      return node.childNameForDiagnostics(index)
    case .prefixOperatorExpr(let node):
      return node.childNameForDiagnostics(index)
    case .binaryOperatorExpr(let node):
      return node.childNameForDiagnostics(index)
    case .arrowExpr(let node):
      return node.childNameForDiagnostics(index)
    case .infixOperatorExpr(let node):
      return node.childNameForDiagnostics(index)
    case .floatLiteralExpr(let node):
      return node.childNameForDiagnostics(index)
    case .tupleExpr(let node):
      return node.childNameForDiagnostics(index)
    case .arrayExpr(let node):
      return node.childNameForDiagnostics(index)
    case .dictionaryExpr(let node):
      return node.childNameForDiagnostics(index)
    case .tupleExprElement(let node):
      return node.childNameForDiagnostics(index)
    case .arrayElement(let node):
      return node.childNameForDiagnostics(index)
    case .dictionaryElement(let node):
      return node.childNameForDiagnostics(index)
    case .integerLiteralExpr(let node):
      return node.childNameForDiagnostics(index)
    case .booleanLiteralExpr(let node):
      return node.childNameForDiagnostics(index)
    case .unresolvedTernaryExpr(let node):
      return node.childNameForDiagnostics(index)
    case .ternaryExpr(let node):
      return node.childNameForDiagnostics(index)
    case .memberAccessExpr(let node):
      return node.childNameForDiagnostics(index)
    case .unresolvedIsExpr(let node):
      return node.childNameForDiagnostics(index)
    case .isExpr(let node):
      return node.childNameForDiagnostics(index)
    case .unresolvedAsExpr(let node):
      return node.childNameForDiagnostics(index)
    case .asExpr(let node):
      return node.childNameForDiagnostics(index)
    case .typeExpr(let node):
      return node.childNameForDiagnostics(index)
    case .closureCaptureItem(let node):
      return node.childNameForDiagnostics(index)
    case .closureCaptureItemList(let node):
      return node.childNameForDiagnostics(index)
    case .closureCaptureSignature(let node):
      return node.childNameForDiagnostics(index)
    case .closureParam(let node):
      return node.childNameForDiagnostics(index)
    case .closureParamList(let node):
      return node.childNameForDiagnostics(index)
    case .closureSignature(let node):
      return node.childNameForDiagnostics(index)
    case .closureExpr(let node):
      return node.childNameForDiagnostics(index)
    case .unresolvedPatternExpr(let node):
      return node.childNameForDiagnostics(index)
    case .multipleTrailingClosureElement(let node):
      return node.childNameForDiagnostics(index)
    case .multipleTrailingClosureElementList(let node):
      return node.childNameForDiagnostics(index)
    case .functionCallExpr(let node):
      return node.childNameForDiagnostics(index)
    case .subscriptExpr(let node):
      return node.childNameForDiagnostics(index)
    case .optionalChainingExpr(let node):
      return node.childNameForDiagnostics(index)
    case .forcedValueExpr(let node):
      return node.childNameForDiagnostics(index)
    case .postfixUnaryExpr(let node):
      return node.childNameForDiagnostics(index)
    case .specializeExpr(let node):
      return node.childNameForDiagnostics(index)
    case .stringSegment(let node):
      return node.childNameForDiagnostics(index)
    case .expressionSegment(let node):
      return node.childNameForDiagnostics(index)
    case .stringLiteralExpr(let node):
      return node.childNameForDiagnostics(index)
    case .regexLiteralExpr(let node):
      return node.childNameForDiagnostics(index)
    case .keyPathExpr(let node):
      return node.childNameForDiagnostics(index)
    case .keyPathComponentList(let node):
      return node.childNameForDiagnostics(index)
    case .keyPathComponent(let node):
      return node.childNameForDiagnostics(index)
    case .keyPathPropertyComponent(let node):
      return node.childNameForDiagnostics(index)
    case .keyPathSubscriptComponent(let node):
      return node.childNameForDiagnostics(index)
    case .keyPathOptionalComponent(let node):
      return node.childNameForDiagnostics(index)
    case .oldKeyPathExpr(let node):
      return node.childNameForDiagnostics(index)
    case .keyPathBaseExpr(let node):
      return node.childNameForDiagnostics(index)
    case .objcNamePiece(let node):
      return node.childNameForDiagnostics(index)
    case .objcName(let node):
      return node.childNameForDiagnostics(index)
    case .objcKeyPathExpr(let node):
      return node.childNameForDiagnostics(index)
    case .objcSelectorExpr(let node):
      return node.childNameForDiagnostics(index)
    case .macroExpansionExpr(let node):
      return node.childNameForDiagnostics(index)
    case .postfixIfConfigExpr(let node):
      return node.childNameForDiagnostics(index)
    case .editorPlaceholderExpr(let node):
      return node.childNameForDiagnostics(index)
    case .objectLiteralExpr(let node):
      return node.childNameForDiagnostics(index)
    case .yieldExprList(let node):
      return node.childNameForDiagnostics(index)
    case .yieldExprListElement(let node):
      return node.childNameForDiagnostics(index)
    case .typeInitializerClause(let node):
      return node.childNameForDiagnostics(index)
    case .typealiasDecl(let node):
      return node.childNameForDiagnostics(index)
    case .associatedtypeDecl(let node):
      return node.childNameForDiagnostics(index)
    case .functionParameterList(let node):
      return node.childNameForDiagnostics(index)
    case .parameterClause(let node):
      return node.childNameForDiagnostics(index)
    case .returnClause(let node):
      return node.childNameForDiagnostics(index)
    case .functionSignature(let node):
      return node.childNameForDiagnostics(index)
    case .ifConfigClause(let node):
      return node.childNameForDiagnostics(index)
    case .ifConfigClauseList(let node):
      return node.childNameForDiagnostics(index)
    case .ifConfigDecl(let node):
      return node.childNameForDiagnostics(index)
    case .poundErrorDecl(let node):
      return node.childNameForDiagnostics(index)
    case .poundWarningDecl(let node):
      return node.childNameForDiagnostics(index)
    case .poundSourceLocation(let node):
      return node.childNameForDiagnostics(index)
    case .poundSourceLocationArgs(let node):
      return node.childNameForDiagnostics(index)
    case .declModifierDetail(let node):
      return node.childNameForDiagnostics(index)
    case .declModifier(let node):
      return node.childNameForDiagnostics(index)
    case .inheritedType(let node):
      return node.childNameForDiagnostics(index)
    case .inheritedTypeList(let node):
      return node.childNameForDiagnostics(index)
    case .typeInheritanceClause(let node):
      return node.childNameForDiagnostics(index)
    case .classDecl(let node):
      return node.childNameForDiagnostics(index)
    case .actorDecl(let node):
      return node.childNameForDiagnostics(index)
    case .structDecl(let node):
      return node.childNameForDiagnostics(index)
    case .protocolDecl(let node):
      return node.childNameForDiagnostics(index)
    case .extensionDecl(let node):
      return node.childNameForDiagnostics(index)
    case .memberDeclBlock(let node):
      return node.childNameForDiagnostics(index)
    case .memberDeclList(let node):
      return node.childNameForDiagnostics(index)
    case .memberDeclListItem(let node):
      return node.childNameForDiagnostics(index)
    case .sourceFile(let node):
      return node.childNameForDiagnostics(index)
    case .initializerClause(let node):
      return node.childNameForDiagnostics(index)
    case .functionParameter(let node):
      return node.childNameForDiagnostics(index)
    case .modifierList(let node):
      return node.childNameForDiagnostics(index)
    case .functionDecl(let node):
      return node.childNameForDiagnostics(index)
    case .initializerDecl(let node):
      return node.childNameForDiagnostics(index)
    case .deinitializerDecl(let node):
      return node.childNameForDiagnostics(index)
    case .subscriptDecl(let node):
      return node.childNameForDiagnostics(index)
    case .accessLevelModifier(let node):
      return node.childNameForDiagnostics(index)
    case .accessPathComponent(let node):
      return node.childNameForDiagnostics(index)
    case .accessPath(let node):
      return node.childNameForDiagnostics(index)
    case .importDecl(let node):
      return node.childNameForDiagnostics(index)
    case .accessorParameter(let node):
      return node.childNameForDiagnostics(index)
    case .accessorDecl(let node):
      return node.childNameForDiagnostics(index)
    case .accessorList(let node):
      return node.childNameForDiagnostics(index)
    case .accessorBlock(let node):
      return node.childNameForDiagnostics(index)
    case .patternBinding(let node):
      return node.childNameForDiagnostics(index)
    case .patternBindingList(let node):
      return node.childNameForDiagnostics(index)
    case .variableDecl(let node):
      return node.childNameForDiagnostics(index)
    case .enumCaseElement(let node):
      return node.childNameForDiagnostics(index)
    case .enumCaseElementList(let node):
      return node.childNameForDiagnostics(index)
    case .enumCaseDecl(let node):
      return node.childNameForDiagnostics(index)
    case .enumDecl(let node):
      return node.childNameForDiagnostics(index)
    case .operatorDecl(let node):
      return node.childNameForDiagnostics(index)
    case .designatedTypeList(let node):
      return node.childNameForDiagnostics(index)
    case .designatedTypeElement(let node):
      return node.childNameForDiagnostics(index)
    case .operatorPrecedenceAndTypes(let node):
      return node.childNameForDiagnostics(index)
    case .precedenceGroupDecl(let node):
      return node.childNameForDiagnostics(index)
    case .precedenceGroupAttributeList(let node):
      return node.childNameForDiagnostics(index)
    case .precedenceGroupRelation(let node):
      return node.childNameForDiagnostics(index)
    case .precedenceGroupNameList(let node):
      return node.childNameForDiagnostics(index)
    case .precedenceGroupNameElement(let node):
      return node.childNameForDiagnostics(index)
    case .precedenceGroupAssignment(let node):
      return node.childNameForDiagnostics(index)
    case .precedenceGroupAssociativity(let node):
      return node.childNameForDiagnostics(index)
    case .macroExpansionDecl(let node):
      return node.childNameForDiagnostics(index)
    case .tokenList(let node):
      return node.childNameForDiagnostics(index)
    case .nonEmptyTokenList(let node):
      return node.childNameForDiagnostics(index)
    case .customAttribute(let node):
      return node.childNameForDiagnostics(index)
    case .attribute(let node):
      return node.childNameForDiagnostics(index)
    case .attributeList(let node):
      return node.childNameForDiagnostics(index)
    case .specializeAttributeSpecList(let node):
      return node.childNameForDiagnostics(index)
    case .availabilityEntry(let node):
      return node.childNameForDiagnostics(index)
    case .labeledSpecializeEntry(let node):
      return node.childNameForDiagnostics(index)
    case .targetFunctionEntry(let node):
      return node.childNameForDiagnostics(index)
    case .namedAttributeStringArgument(let node):
      return node.childNameForDiagnostics(index)
    case .declName(let node):
      return node.childNameForDiagnostics(index)
    case .implementsAttributeArguments(let node):
      return node.childNameForDiagnostics(index)
    case .objCSelectorPiece(let node):
      return node.childNameForDiagnostics(index)
    case .objCSelector(let node):
      return node.childNameForDiagnostics(index)
    case .differentiableAttributeArguments(let node):
      return node.childNameForDiagnostics(index)
    case .differentiabilityParamsClause(let node):
      return node.childNameForDiagnostics(index)
    case .differentiabilityParams(let node):
      return node.childNameForDiagnostics(index)
    case .differentiabilityParamList(let node):
      return node.childNameForDiagnostics(index)
    case .differentiabilityParam(let node):
      return node.childNameForDiagnostics(index)
    case .derivativeRegistrationAttributeArguments(let node):
      return node.childNameForDiagnostics(index)
    case .qualifiedDeclName(let node):
      return node.childNameForDiagnostics(index)
    case .functionDeclName(let node):
      return node.childNameForDiagnostics(index)
    case .backDeployAttributeSpecList(let node):
      return node.childNameForDiagnostics(index)
    case .backDeployVersionList(let node):
      return node.childNameForDiagnostics(index)
    case .backDeployVersionArgument(let node):
      return node.childNameForDiagnostics(index)
    case .opaqueReturnTypeOfAttributeArguments(let node):
      return node.childNameForDiagnostics(index)
    case .conventionAttributeArguments(let node):
      return node.childNameForDiagnostics(index)
    case .conventionWitnessMethodAttributeArguments(let node):
      return node.childNameForDiagnostics(index)
    case .labeledStmt(let node):
      return node.childNameForDiagnostics(index)
    case .continueStmt(let node):
      return node.childNameForDiagnostics(index)
    case .whileStmt(let node):
      return node.childNameForDiagnostics(index)
    case .deferStmt(let node):
      return node.childNameForDiagnostics(index)
    case .expressionStmt(let node):
      return node.childNameForDiagnostics(index)
    case .switchCaseList(let node):
      return node.childNameForDiagnostics(index)
    case .repeatWhileStmt(let node):
      return node.childNameForDiagnostics(index)
    case .guardStmt(let node):
      return node.childNameForDiagnostics(index)
    case .whereClause(let node):
      return node.childNameForDiagnostics(index)
    case .forInStmt(let node):
      return node.childNameForDiagnostics(index)
    case .switchStmt(let node):
      return node.childNameForDiagnostics(index)
    case .catchClauseList(let node):
      return node.childNameForDiagnostics(index)
    case .doStmt(let node):
      return node.childNameForDiagnostics(index)
    case .returnStmt(let node):
      return node.childNameForDiagnostics(index)
    case .yieldStmt(let node):
      return node.childNameForDiagnostics(index)
    case .yieldList(let node):
      return node.childNameForDiagnostics(index)
    case .fallthroughStmt(let node):
      return node.childNameForDiagnostics(index)
    case .breakStmt(let node):
      return node.childNameForDiagnostics(index)
    case .caseItemList(let node):
      return node.childNameForDiagnostics(index)
    case .catchItemList(let node):
      return node.childNameForDiagnostics(index)
    case .conditionElement(let node):
      return node.childNameForDiagnostics(index)
    case .availabilityCondition(let node):
      return node.childNameForDiagnostics(index)
    case .matchingPatternCondition(let node):
      return node.childNameForDiagnostics(index)
    case .optionalBindingCondition(let node):
      return node.childNameForDiagnostics(index)
    case .unavailabilityCondition(let node):
      return node.childNameForDiagnostics(index)
    case .hasSymbolCondition(let node):
      return node.childNameForDiagnostics(index)
    case .conditionElementList(let node):
      return node.childNameForDiagnostics(index)
    case .declarationStmt(let node):
      return node.childNameForDiagnostics(index)
    case .throwStmt(let node):
      return node.childNameForDiagnostics(index)
    case .ifStmt(let node):
      return node.childNameForDiagnostics(index)
    case .switchCase(let node):
      return node.childNameForDiagnostics(index)
    case .switchDefaultLabel(let node):
      return node.childNameForDiagnostics(index)
    case .caseItem(let node):
      return node.childNameForDiagnostics(index)
    case .catchItem(let node):
      return node.childNameForDiagnostics(index)
    case .switchCaseLabel(let node):
      return node.childNameForDiagnostics(index)
    case .catchClause(let node):
      return node.childNameForDiagnostics(index)
    case .poundAssertStmt(let node):
      return node.childNameForDiagnostics(index)
    case .genericWhereClause(let node):
      return node.childNameForDiagnostics(index)
    case .genericRequirementList(let node):
      return node.childNameForDiagnostics(index)
    case .genericRequirement(let node):
      return node.childNameForDiagnostics(index)
    case .sameTypeRequirement(let node):
      return node.childNameForDiagnostics(index)
    case .layoutRequirement(let node):
      return node.childNameForDiagnostics(index)
    case .genericParameterList(let node):
      return node.childNameForDiagnostics(index)
    case .genericParameter(let node):
      return node.childNameForDiagnostics(index)
    case .primaryAssociatedTypeList(let node):
      return node.childNameForDiagnostics(index)
    case .primaryAssociatedType(let node):
      return node.childNameForDiagnostics(index)
    case .genericParameterClause(let node):
      return node.childNameForDiagnostics(index)
    case .conformanceRequirement(let node):
      return node.childNameForDiagnostics(index)
    case .primaryAssociatedTypeClause(let node):
      return node.childNameForDiagnostics(index)
    case .simpleTypeIdentifier(let node):
      return node.childNameForDiagnostics(index)
    case .memberTypeIdentifier(let node):
      return node.childNameForDiagnostics(index)
    case .classRestrictionType(let node):
      return node.childNameForDiagnostics(index)
    case .arrayType(let node):
      return node.childNameForDiagnostics(index)
    case .dictionaryType(let node):
      return node.childNameForDiagnostics(index)
    case .metatypeType(let node):
      return node.childNameForDiagnostics(index)
    case .optionalType(let node):
      return node.childNameForDiagnostics(index)
    case .constrainedSugarType(let node):
      return node.childNameForDiagnostics(index)
    case .implicitlyUnwrappedOptionalType(let node):
      return node.childNameForDiagnostics(index)
    case .compositionTypeElement(let node):
      return node.childNameForDiagnostics(index)
    case .compositionTypeElementList(let node):
      return node.childNameForDiagnostics(index)
    case .compositionType(let node):
      return node.childNameForDiagnostics(index)
    case .packExpansionType(let node):
      return node.childNameForDiagnostics(index)
    case .tupleTypeElement(let node):
      return node.childNameForDiagnostics(index)
    case .tupleTypeElementList(let node):
      return node.childNameForDiagnostics(index)
    case .tupleType(let node):
      return node.childNameForDiagnostics(index)
    case .functionType(let node):
      return node.childNameForDiagnostics(index)
    case .attributedType(let node):
      return node.childNameForDiagnostics(index)
    case .genericArgumentList(let node):
      return node.childNameForDiagnostics(index)
    case .genericArgument(let node):
      return node.childNameForDiagnostics(index)
    case .genericArgumentClause(let node):
      return node.childNameForDiagnostics(index)
    case .namedOpaqueReturnType(let node):
      return node.childNameForDiagnostics(index)
    case .typeAnnotation(let node):
      return node.childNameForDiagnostics(index)
    case .enumCasePattern(let node):
      return node.childNameForDiagnostics(index)
    case .isTypePattern(let node):
      return node.childNameForDiagnostics(index)
    case .optionalPattern(let node):
      return node.childNameForDiagnostics(index)
    case .identifierPattern(let node):
      return node.childNameForDiagnostics(index)
    case .asTypePattern(let node):
      return node.childNameForDiagnostics(index)
    case .tuplePattern(let node):
      return node.childNameForDiagnostics(index)
    case .wildcardPattern(let node):
      return node.childNameForDiagnostics(index)
    case .tuplePatternElement(let node):
      return node.childNameForDiagnostics(index)
    case .expressionPattern(let node):
      return node.childNameForDiagnostics(index)
    case .tuplePatternElementList(let node):
      return node.childNameForDiagnostics(index)
    case .valueBindingPattern(let node):
      return node.childNameForDiagnostics(index)
    case .availabilitySpecList(let node):
      return node.childNameForDiagnostics(index)
    case .availabilityArgument(let node):
      return node.childNameForDiagnostics(index)
    case .availabilityLabeledArgument(let node):
      return node.childNameForDiagnostics(index)
    case .availabilityVersionRestriction(let node):
      return node.childNameForDiagnostics(index)
    case .versionTuple(let node):
      return node.childNameForDiagnostics(index)
    }
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
