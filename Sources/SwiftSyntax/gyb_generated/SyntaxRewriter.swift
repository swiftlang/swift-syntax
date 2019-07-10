//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxRewriter.swift - Syntax Rewriter class ------------===//
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
//
// This file defines the SyntaxRewriter, a class that performs a standard walk
// and tree-rebuilding pattern.
//
// Subclassers of this class can override the walking behavior for any syntax
// node and transform nodes however they like.
//
//===----------------------------------------------------------------------===//

open class SyntaxRewriter {
  public init() {}
  open func visit(_ node: UnknownDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: UnknownExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: UnknownStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: UnknownTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: UnknownPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: CodeBlockItemSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: CodeBlockItemListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: CodeBlockSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: InOutExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: PoundColumnExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: FunctionCallArgumentListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TupleElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ArrayElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: DictionaryElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: StringLiteralSegmentsSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TryExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: DeclNameArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: DeclNameArgumentListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: DeclNameArgumentsSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: IdentifierExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: SuperRefExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: NilLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: DiscardAssignmentExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: AssignmentExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: SequenceExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: ExprListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PoundLineExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: PoundFileExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: PoundFunctionExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: PoundDsohandleExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: SymbolicReferenceExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: PrefixOperatorExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: BinaryOperatorExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: ArrowExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: FloatLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: TupleExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: ArrayExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: DictionaryExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: FunctionCallArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TupleElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ArrayElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: DictionaryElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: IntegerLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: BooleanLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: TernaryExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: MemberAccessExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: IsExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: AsExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: TypeExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: ClosureCaptureItemSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ClosureCaptureItemListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ClosureCaptureSignatureSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ClosureParamSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ClosureParamListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ClosureSignatureSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ClosureExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: UnresolvedPatternExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: SubscriptExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: OptionalChainingExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: ForcedValueExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: PostfixUnaryExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: SpecializeExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: StringSegmentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ExpressionSegmentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: StringLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: KeyPathExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: KeyPathBaseExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: ObjcNamePieceSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ObjcNameSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ObjcKeyPathExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: ObjcSelectorExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: EditorPlaceholderExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: ObjectLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  open func visit(_ node: TypeInitializerClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TypealiasDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: AssociatedtypeDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: FunctionParameterListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ParameterClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ReturnClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: FunctionSignatureSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: IfConfigClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: IfConfigClauseListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: IfConfigDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: PoundErrorDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: PoundWarningDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: PoundSourceLocationSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: PoundSourceLocationArgsSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: DeclModifierSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: InheritedTypeSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: InheritedTypeListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TypeInheritanceClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: StructDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: ProtocolDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: ExtensionDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: MemberDeclBlockSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: MemberDeclListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: MemberDeclListItemSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: SourceFileSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: InitializerClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: FunctionParameterSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ModifierListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: InitializerDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: DeinitializerDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: SubscriptDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: AccessLevelModifierSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AccessPathComponentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AccessPathSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ImportDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: AccessorParameterSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AccessorDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: AccessorListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AccessorBlockSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PatternBindingSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PatternBindingListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: EnumCaseElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: EnumCaseElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: EnumCaseDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: OperatorDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: IdentifierListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PrecedenceGroupDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PrecedenceGroupRelationSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PrecedenceGroupNameListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TokenListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: NonEmptyTokenListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: CustomAttributeSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AttributeSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AttributeListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: LabeledSpecializeEntrySyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: NamedAttributeStringArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: DeclNameSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ObjCSelectorPieceSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ObjCSelectorSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ContinueStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: WhileStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: DeferStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: ExpressionStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: SwitchCaseListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: RepeatWhileStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: GuardStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: WhereClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ForInStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: SwitchStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: CatchClauseListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: DoStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: ReturnStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: YieldStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: YieldListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: FallthroughStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: BreakStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: CaseItemListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ConditionElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AvailabilityConditionSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: MatchingPatternConditionSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: OptionalBindingConditionSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ConditionElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: DeclarationStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: ThrowStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: IfStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: ElseIfContinuationSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ElseBlockSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: SwitchCaseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: SwitchDefaultLabelSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: CaseItemSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: SwitchCaseLabelSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: CatchClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: PoundAssertStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  open func visit(_ node: GenericWhereClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: GenericRequirementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: SameTypeRequirementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: GenericParameterListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: GenericParameterSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: GenericParameterClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ConformanceRequirementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: SimpleTypeIdentifierSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: MemberTypeIdentifierSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: ClassRestrictionTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: ArrayTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: DictionaryTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: MetatypeTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: OptionalTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: SomeTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: CompositionTypeElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: CompositionTypeElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: CompositionTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: TupleTypeElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TupleTypeElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TupleTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: FunctionTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: AttributedTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  open func visit(_ node: GenericArgumentListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: GenericArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: GenericArgumentClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: TypeAnnotationSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: EnumCasePatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: IsTypePatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: OptionalPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: IdentifierPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: AsTypePatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: TuplePatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: WildcardPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: TuplePatternElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ExpressionPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: TuplePatternElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: ValueBindingPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  open func visit(_ node: AvailabilitySpecListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AvailabilityArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> Syntax {
    return visitChildren(node) 
  }

  open func visit(_ node: VersionTupleSyntax) -> Syntax {
    return visitChildren(node) 
  }


  open func visit(_ token: TokenSyntax) -> Syntax {
    return token
  }

  /// The function called before visiting the node and its descendents.
  ///   - node: the node we are about to visit.
  open func visitPre(_ node: Syntax) {}

  /// Override point to choose custom visitation dispatch instead of the
  /// specialized `visit(_:)` methods. Use this instead of those methods if
  /// you intend to dynamically dispatch rewriting behavior.
  /// - note: If this method returns a non-nil result, the specialized
  ///         `visit(_:)` methods will not be called for this node.
  open func visitAny(_ node: Syntax) -> Syntax? {
    return nil
  }

  /// The function called after visiting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: Syntax) {}

  public func visit(_ node: Syntax) -> Syntax {
    visitPre(node)
    defer { visitPost(node) }

    // If the global visitor returned non-nil, skip specialized dispatch.
    if let newNode = visitAny(node) {
      return newNode
    }

    switch node.raw.kind {
    case .token: return visit(node as! TokenSyntax)
    case .unknownDecl: return visit(node as! UnknownDeclSyntax)
    case .unknownExpr: return visit(node as! UnknownExprSyntax)
    case .unknownStmt: return visit(node as! UnknownStmtSyntax)
    case .unknownType: return visit(node as! UnknownTypeSyntax)
    case .unknownPattern: return visit(node as! UnknownPatternSyntax)
    case .codeBlockItem: return visit(node as! CodeBlockItemSyntax)
    case .codeBlockItemList: return visit(node as! CodeBlockItemListSyntax)
    case .codeBlock: return visit(node as! CodeBlockSyntax)
    case .inOutExpr: return visit(node as! InOutExprSyntax)
    case .poundColumnExpr: return visit(node as! PoundColumnExprSyntax)
    case .functionCallArgumentList: return visit(node as! FunctionCallArgumentListSyntax)
    case .tupleElementList: return visit(node as! TupleElementListSyntax)
    case .arrayElementList: return visit(node as! ArrayElementListSyntax)
    case .dictionaryElementList: return visit(node as! DictionaryElementListSyntax)
    case .stringLiteralSegments: return visit(node as! StringLiteralSegmentsSyntax)
    case .tryExpr: return visit(node as! TryExprSyntax)
    case .declNameArgument: return visit(node as! DeclNameArgumentSyntax)
    case .declNameArgumentList: return visit(node as! DeclNameArgumentListSyntax)
    case .declNameArguments: return visit(node as! DeclNameArgumentsSyntax)
    case .identifierExpr: return visit(node as! IdentifierExprSyntax)
    case .superRefExpr: return visit(node as! SuperRefExprSyntax)
    case .nilLiteralExpr: return visit(node as! NilLiteralExprSyntax)
    case .discardAssignmentExpr: return visit(node as! DiscardAssignmentExprSyntax)
    case .assignmentExpr: return visit(node as! AssignmentExprSyntax)
    case .sequenceExpr: return visit(node as! SequenceExprSyntax)
    case .exprList: return visit(node as! ExprListSyntax)
    case .poundLineExpr: return visit(node as! PoundLineExprSyntax)
    case .poundFileExpr: return visit(node as! PoundFileExprSyntax)
    case .poundFunctionExpr: return visit(node as! PoundFunctionExprSyntax)
    case .poundDsohandleExpr: return visit(node as! PoundDsohandleExprSyntax)
    case .symbolicReferenceExpr: return visit(node as! SymbolicReferenceExprSyntax)
    case .prefixOperatorExpr: return visit(node as! PrefixOperatorExprSyntax)
    case .binaryOperatorExpr: return visit(node as! BinaryOperatorExprSyntax)
    case .arrowExpr: return visit(node as! ArrowExprSyntax)
    case .floatLiteralExpr: return visit(node as! FloatLiteralExprSyntax)
    case .tupleExpr: return visit(node as! TupleExprSyntax)
    case .arrayExpr: return visit(node as! ArrayExprSyntax)
    case .dictionaryExpr: return visit(node as! DictionaryExprSyntax)
    case .functionCallArgument: return visit(node as! FunctionCallArgumentSyntax)
    case .tupleElement: return visit(node as! TupleElementSyntax)
    case .arrayElement: return visit(node as! ArrayElementSyntax)
    case .dictionaryElement: return visit(node as! DictionaryElementSyntax)
    case .integerLiteralExpr: return visit(node as! IntegerLiteralExprSyntax)
    case .booleanLiteralExpr: return visit(node as! BooleanLiteralExprSyntax)
    case .ternaryExpr: return visit(node as! TernaryExprSyntax)
    case .memberAccessExpr: return visit(node as! MemberAccessExprSyntax)
    case .isExpr: return visit(node as! IsExprSyntax)
    case .asExpr: return visit(node as! AsExprSyntax)
    case .typeExpr: return visit(node as! TypeExprSyntax)
    case .closureCaptureItem: return visit(node as! ClosureCaptureItemSyntax)
    case .closureCaptureItemList: return visit(node as! ClosureCaptureItemListSyntax)
    case .closureCaptureSignature: return visit(node as! ClosureCaptureSignatureSyntax)
    case .closureParam: return visit(node as! ClosureParamSyntax)
    case .closureParamList: return visit(node as! ClosureParamListSyntax)
    case .closureSignature: return visit(node as! ClosureSignatureSyntax)
    case .closureExpr: return visit(node as! ClosureExprSyntax)
    case .unresolvedPatternExpr: return visit(node as! UnresolvedPatternExprSyntax)
    case .functionCallExpr: return visit(node as! FunctionCallExprSyntax)
    case .subscriptExpr: return visit(node as! SubscriptExprSyntax)
    case .optionalChainingExpr: return visit(node as! OptionalChainingExprSyntax)
    case .forcedValueExpr: return visit(node as! ForcedValueExprSyntax)
    case .postfixUnaryExpr: return visit(node as! PostfixUnaryExprSyntax)
    case .specializeExpr: return visit(node as! SpecializeExprSyntax)
    case .stringSegment: return visit(node as! StringSegmentSyntax)
    case .expressionSegment: return visit(node as! ExpressionSegmentSyntax)
    case .stringLiteralExpr: return visit(node as! StringLiteralExprSyntax)
    case .keyPathExpr: return visit(node as! KeyPathExprSyntax)
    case .keyPathBaseExpr: return visit(node as! KeyPathBaseExprSyntax)
    case .objcNamePiece: return visit(node as! ObjcNamePieceSyntax)
    case .objcName: return visit(node as! ObjcNameSyntax)
    case .objcKeyPathExpr: return visit(node as! ObjcKeyPathExprSyntax)
    case .objcSelectorExpr: return visit(node as! ObjcSelectorExprSyntax)
    case .editorPlaceholderExpr: return visit(node as! EditorPlaceholderExprSyntax)
    case .objectLiteralExpr: return visit(node as! ObjectLiteralExprSyntax)
    case .typeInitializerClause: return visit(node as! TypeInitializerClauseSyntax)
    case .typealiasDecl: return visit(node as! TypealiasDeclSyntax)
    case .associatedtypeDecl: return visit(node as! AssociatedtypeDeclSyntax)
    case .functionParameterList: return visit(node as! FunctionParameterListSyntax)
    case .parameterClause: return visit(node as! ParameterClauseSyntax)
    case .returnClause: return visit(node as! ReturnClauseSyntax)
    case .functionSignature: return visit(node as! FunctionSignatureSyntax)
    case .ifConfigClause: return visit(node as! IfConfigClauseSyntax)
    case .ifConfigClauseList: return visit(node as! IfConfigClauseListSyntax)
    case .ifConfigDecl: return visit(node as! IfConfigDeclSyntax)
    case .poundErrorDecl: return visit(node as! PoundErrorDeclSyntax)
    case .poundWarningDecl: return visit(node as! PoundWarningDeclSyntax)
    case .poundSourceLocation: return visit(node as! PoundSourceLocationSyntax)
    case .poundSourceLocationArgs: return visit(node as! PoundSourceLocationArgsSyntax)
    case .declModifier: return visit(node as! DeclModifierSyntax)
    case .inheritedType: return visit(node as! InheritedTypeSyntax)
    case .inheritedTypeList: return visit(node as! InheritedTypeListSyntax)
    case .typeInheritanceClause: return visit(node as! TypeInheritanceClauseSyntax)
    case .classDecl: return visit(node as! ClassDeclSyntax)
    case .structDecl: return visit(node as! StructDeclSyntax)
    case .protocolDecl: return visit(node as! ProtocolDeclSyntax)
    case .extensionDecl: return visit(node as! ExtensionDeclSyntax)
    case .memberDeclBlock: return visit(node as! MemberDeclBlockSyntax)
    case .memberDeclList: return visit(node as! MemberDeclListSyntax)
    case .memberDeclListItem: return visit(node as! MemberDeclListItemSyntax)
    case .sourceFile: return visit(node as! SourceFileSyntax)
    case .initializerClause: return visit(node as! InitializerClauseSyntax)
    case .functionParameter: return visit(node as! FunctionParameterSyntax)
    case .modifierList: return visit(node as! ModifierListSyntax)
    case .functionDecl: return visit(node as! FunctionDeclSyntax)
    case .initializerDecl: return visit(node as! InitializerDeclSyntax)
    case .deinitializerDecl: return visit(node as! DeinitializerDeclSyntax)
    case .subscriptDecl: return visit(node as! SubscriptDeclSyntax)
    case .accessLevelModifier: return visit(node as! AccessLevelModifierSyntax)
    case .accessPathComponent: return visit(node as! AccessPathComponentSyntax)
    case .accessPath: return visit(node as! AccessPathSyntax)
    case .importDecl: return visit(node as! ImportDeclSyntax)
    case .accessorParameter: return visit(node as! AccessorParameterSyntax)
    case .accessorDecl: return visit(node as! AccessorDeclSyntax)
    case .accessorList: return visit(node as! AccessorListSyntax)
    case .accessorBlock: return visit(node as! AccessorBlockSyntax)
    case .patternBinding: return visit(node as! PatternBindingSyntax)
    case .patternBindingList: return visit(node as! PatternBindingListSyntax)
    case .variableDecl: return visit(node as! VariableDeclSyntax)
    case .enumCaseElement: return visit(node as! EnumCaseElementSyntax)
    case .enumCaseElementList: return visit(node as! EnumCaseElementListSyntax)
    case .enumCaseDecl: return visit(node as! EnumCaseDeclSyntax)
    case .enumDecl: return visit(node as! EnumDeclSyntax)
    case .operatorDecl: return visit(node as! OperatorDeclSyntax)
    case .identifierList: return visit(node as! IdentifierListSyntax)
    case .operatorPrecedenceAndTypes: return visit(node as! OperatorPrecedenceAndTypesSyntax)
    case .precedenceGroupDecl: return visit(node as! PrecedenceGroupDeclSyntax)
    case .precedenceGroupAttributeList: return visit(node as! PrecedenceGroupAttributeListSyntax)
    case .precedenceGroupRelation: return visit(node as! PrecedenceGroupRelationSyntax)
    case .precedenceGroupNameList: return visit(node as! PrecedenceGroupNameListSyntax)
    case .precedenceGroupNameElement: return visit(node as! PrecedenceGroupNameElementSyntax)
    case .precedenceGroupAssignment: return visit(node as! PrecedenceGroupAssignmentSyntax)
    case .precedenceGroupAssociativity: return visit(node as! PrecedenceGroupAssociativitySyntax)
    case .tokenList: return visit(node as! TokenListSyntax)
    case .nonEmptyTokenList: return visit(node as! NonEmptyTokenListSyntax)
    case .customAttribute: return visit(node as! CustomAttributeSyntax)
    case .attribute: return visit(node as! AttributeSyntax)
    case .attributeList: return visit(node as! AttributeListSyntax)
    case .specializeAttributeSpecList: return visit(node as! SpecializeAttributeSpecListSyntax)
    case .labeledSpecializeEntry: return visit(node as! LabeledSpecializeEntrySyntax)
    case .namedAttributeStringArgument: return visit(node as! NamedAttributeStringArgumentSyntax)
    case .declName: return visit(node as! DeclNameSyntax)
    case .implementsAttributeArguments: return visit(node as! ImplementsAttributeArgumentsSyntax)
    case .objCSelectorPiece: return visit(node as! ObjCSelectorPieceSyntax)
    case .objCSelector: return visit(node as! ObjCSelectorSyntax)
    case .continueStmt: return visit(node as! ContinueStmtSyntax)
    case .whileStmt: return visit(node as! WhileStmtSyntax)
    case .deferStmt: return visit(node as! DeferStmtSyntax)
    case .expressionStmt: return visit(node as! ExpressionStmtSyntax)
    case .switchCaseList: return visit(node as! SwitchCaseListSyntax)
    case .repeatWhileStmt: return visit(node as! RepeatWhileStmtSyntax)
    case .guardStmt: return visit(node as! GuardStmtSyntax)
    case .whereClause: return visit(node as! WhereClauseSyntax)
    case .forInStmt: return visit(node as! ForInStmtSyntax)
    case .switchStmt: return visit(node as! SwitchStmtSyntax)
    case .catchClauseList: return visit(node as! CatchClauseListSyntax)
    case .doStmt: return visit(node as! DoStmtSyntax)
    case .returnStmt: return visit(node as! ReturnStmtSyntax)
    case .yieldStmt: return visit(node as! YieldStmtSyntax)
    case .yieldList: return visit(node as! YieldListSyntax)
    case .fallthroughStmt: return visit(node as! FallthroughStmtSyntax)
    case .breakStmt: return visit(node as! BreakStmtSyntax)
    case .caseItemList: return visit(node as! CaseItemListSyntax)
    case .conditionElement: return visit(node as! ConditionElementSyntax)
    case .availabilityCondition: return visit(node as! AvailabilityConditionSyntax)
    case .matchingPatternCondition: return visit(node as! MatchingPatternConditionSyntax)
    case .optionalBindingCondition: return visit(node as! OptionalBindingConditionSyntax)
    case .conditionElementList: return visit(node as! ConditionElementListSyntax)
    case .declarationStmt: return visit(node as! DeclarationStmtSyntax)
    case .throwStmt: return visit(node as! ThrowStmtSyntax)
    case .ifStmt: return visit(node as! IfStmtSyntax)
    case .elseIfContinuation: return visit(node as! ElseIfContinuationSyntax)
    case .elseBlock: return visit(node as! ElseBlockSyntax)
    case .switchCase: return visit(node as! SwitchCaseSyntax)
    case .switchDefaultLabel: return visit(node as! SwitchDefaultLabelSyntax)
    case .caseItem: return visit(node as! CaseItemSyntax)
    case .switchCaseLabel: return visit(node as! SwitchCaseLabelSyntax)
    case .catchClause: return visit(node as! CatchClauseSyntax)
    case .poundAssertStmt: return visit(node as! PoundAssertStmtSyntax)
    case .genericWhereClause: return visit(node as! GenericWhereClauseSyntax)
    case .genericRequirementList: return visit(node as! GenericRequirementListSyntax)
    case .sameTypeRequirement: return visit(node as! SameTypeRequirementSyntax)
    case .genericParameterList: return visit(node as! GenericParameterListSyntax)
    case .genericParameter: return visit(node as! GenericParameterSyntax)
    case .genericParameterClause: return visit(node as! GenericParameterClauseSyntax)
    case .conformanceRequirement: return visit(node as! ConformanceRequirementSyntax)
    case .simpleTypeIdentifier: return visit(node as! SimpleTypeIdentifierSyntax)
    case .memberTypeIdentifier: return visit(node as! MemberTypeIdentifierSyntax)
    case .classRestrictionType: return visit(node as! ClassRestrictionTypeSyntax)
    case .arrayType: return visit(node as! ArrayTypeSyntax)
    case .dictionaryType: return visit(node as! DictionaryTypeSyntax)
    case .metatypeType: return visit(node as! MetatypeTypeSyntax)
    case .optionalType: return visit(node as! OptionalTypeSyntax)
    case .someType: return visit(node as! SomeTypeSyntax)
    case .implicitlyUnwrappedOptionalType: return visit(node as! ImplicitlyUnwrappedOptionalTypeSyntax)
    case .compositionTypeElement: return visit(node as! CompositionTypeElementSyntax)
    case .compositionTypeElementList: return visit(node as! CompositionTypeElementListSyntax)
    case .compositionType: return visit(node as! CompositionTypeSyntax)
    case .tupleTypeElement: return visit(node as! TupleTypeElementSyntax)
    case .tupleTypeElementList: return visit(node as! TupleTypeElementListSyntax)
    case .tupleType: return visit(node as! TupleTypeSyntax)
    case .functionType: return visit(node as! FunctionTypeSyntax)
    case .attributedType: return visit(node as! AttributedTypeSyntax)
    case .genericArgumentList: return visit(node as! GenericArgumentListSyntax)
    case .genericArgument: return visit(node as! GenericArgumentSyntax)
    case .genericArgumentClause: return visit(node as! GenericArgumentClauseSyntax)
    case .typeAnnotation: return visit(node as! TypeAnnotationSyntax)
    case .enumCasePattern: return visit(node as! EnumCasePatternSyntax)
    case .isTypePattern: return visit(node as! IsTypePatternSyntax)
    case .optionalPattern: return visit(node as! OptionalPatternSyntax)
    case .identifierPattern: return visit(node as! IdentifierPatternSyntax)
    case .asTypePattern: return visit(node as! AsTypePatternSyntax)
    case .tuplePattern: return visit(node as! TuplePatternSyntax)
    case .wildcardPattern: return visit(node as! WildcardPatternSyntax)
    case .tuplePatternElement: return visit(node as! TuplePatternElementSyntax)
    case .expressionPattern: return visit(node as! ExpressionPatternSyntax)
    case .tuplePatternElementList: return visit(node as! TuplePatternElementListSyntax)
    case .valueBindingPattern: return visit(node as! ValueBindingPatternSyntax)
    case .availabilitySpecList: return visit(node as! AvailabilitySpecListSyntax)
    case .availabilityArgument: return visit(node as! AvailabilityArgumentSyntax)
    case .availabilityLabeledArgument: return visit(node as! AvailabilityLabeledArgumentSyntax)
    case .availabilityVersionRestriction: return visit(node as! AvailabilityVersionRestrictionSyntax)
    case .versionTuple: return visit(node as! VersionTupleSyntax)
    default: return visitChildren(node)
    }
  }

  func visitChildren(_ nodeS: Syntax) -> Syntax {
    // Visit all children of this node, returning `nil` if child is not
    // present. This will ensure that there are always the same number
    // of children after transforming.
    let node = nodeS.base
    let newLayout = RawSyntaxChildren(node).map { (n: (RawSyntax?, AbsoluteSyntaxInfo)) -> RawSyntax? in
      let (raw, info) = n
      guard let child = raw else { return nil }
      let absoluteRaw = AbsoluteRawSyntax(raw: child, info: info)
      let data = SyntaxData(absoluteRaw, parent: node)
      return visit(makeSyntax(data)).raw
    }

    // Sanity check, ensure the new children are the same length.
    assert(newLayout.count == node.raw.numberOfChildren)

    let newRaw = node.raw.replacingLayout(newLayout)
    return makeSyntax(.forRoot(newRaw))
  }
}

/// The enum describes how the SyntaxVistor should continue after visiting
/// the current node.
public enum SyntaxVisitorContinueKind {

  /// The visitor should visit the descendents of the current node.
  case visitChildren

  /// The visitor should avoid visiting the descendents of the current node.
  case skipChildren
}

public protocol SyntaxVisitor {
  /// Visiting `UnknownDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `UnknownDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: UnknownDeclSyntax)
  /// Visiting `UnknownExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `UnknownExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: UnknownExprSyntax)
  /// Visiting `UnknownStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `UnknownStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: UnknownStmtSyntax)
  /// Visiting `UnknownTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `UnknownTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: UnknownTypeSyntax)
  /// Visiting `UnknownPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `UnknownPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: UnknownPatternSyntax)
  /// Visiting `CodeBlockItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CodeBlockItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CodeBlockItemSyntax)
  /// Visiting `CodeBlockItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CodeBlockItemListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CodeBlockItemListSyntax)
  /// Visiting `CodeBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CodeBlockSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CodeBlockSyntax)
  /// Visiting `InOutExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `InOutExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: InOutExprSyntax)
  /// Visiting `PoundColumnExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundColumnExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundColumnExprSyntax)
  /// Visiting `FunctionCallArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FunctionCallArgumentListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FunctionCallArgumentListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FunctionCallArgumentListSyntax)
  /// Visiting `TupleElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TupleElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TupleElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TupleElementListSyntax)
  /// Visiting `ArrayElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ArrayElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ArrayElementListSyntax)
  /// Visiting `DictionaryElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DictionaryElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DictionaryElementListSyntax)
  /// Visiting `StringLiteralSegmentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: StringLiteralSegmentsSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `StringLiteralSegmentsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: StringLiteralSegmentsSyntax)
  /// Visiting `TryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TryExprSyntax)
  /// Visiting `DeclNameArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DeclNameArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DeclNameArgumentSyntax)
  /// Visiting `DeclNameArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DeclNameArgumentListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DeclNameArgumentListSyntax)
  /// Visiting `DeclNameArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DeclNameArgumentsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DeclNameArgumentsSyntax)
  /// Visiting `IdentifierExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IdentifierExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IdentifierExprSyntax)
  /// Visiting `SuperRefExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SuperRefExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SuperRefExprSyntax)
  /// Visiting `NilLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `NilLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: NilLiteralExprSyntax)
  /// Visiting `DiscardAssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DiscardAssignmentExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DiscardAssignmentExprSyntax)
  /// Visiting `AssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AssignmentExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AssignmentExprSyntax)
  /// Visiting `SequenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SequenceExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SequenceExprSyntax)
  /// Visiting `ExprListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ExprListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ExprListSyntax)
  /// Visiting `PoundLineExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundLineExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundLineExprSyntax)
  /// Visiting `PoundFileExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundFileExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundFileExprSyntax)
  /// Visiting `PoundFunctionExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundFunctionExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundFunctionExprSyntax)
  /// Visiting `PoundDsohandleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundDsohandleExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundDsohandleExprSyntax)
  /// Visiting `SymbolicReferenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SymbolicReferenceExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SymbolicReferenceExprSyntax)
  /// Visiting `PrefixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PrefixOperatorExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PrefixOperatorExprSyntax)
  /// Visiting `BinaryOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `BinaryOperatorExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: BinaryOperatorExprSyntax)
  /// Visiting `ArrowExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ArrowExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ArrowExprSyntax)
  /// Visiting `FloatLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FloatLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FloatLiteralExprSyntax)
  /// Visiting `TupleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TupleExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TupleExprSyntax)
  /// Visiting `ArrayExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ArrayExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ArrayExprSyntax)
  /// Visiting `DictionaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DictionaryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DictionaryExprSyntax)
  /// Visiting `FunctionCallArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FunctionCallArgumentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FunctionCallArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FunctionCallArgumentSyntax)
  /// Visiting `TupleElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TupleElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TupleElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TupleElementSyntax)
  /// Visiting `ArrayElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ArrayElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ArrayElementSyntax)
  /// Visiting `DictionaryElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DictionaryElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DictionaryElementSyntax)
  /// Visiting `IntegerLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IntegerLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IntegerLiteralExprSyntax)
  /// Visiting `BooleanLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `BooleanLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: BooleanLiteralExprSyntax)
  /// Visiting `TernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TernaryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TernaryExprSyntax)
  /// Visiting `MemberAccessExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `MemberAccessExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: MemberAccessExprSyntax)
  /// Visiting `IsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IsExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IsExprSyntax)
  /// Visiting `AsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AsExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AsExprSyntax)
  /// Visiting `TypeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TypeExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TypeExprSyntax)
  /// Visiting `ClosureCaptureItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClosureCaptureItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClosureCaptureItemSyntax)
  /// Visiting `ClosureCaptureItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClosureCaptureItemListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClosureCaptureItemListSyntax)
  /// Visiting `ClosureCaptureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClosureCaptureSignatureSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClosureCaptureSignatureSyntax)
  /// Visiting `ClosureParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClosureParamSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClosureParamSyntax)
  /// Visiting `ClosureParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClosureParamListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClosureParamListSyntax)
  /// Visiting `ClosureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClosureSignatureSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClosureSignatureSyntax)
  /// Visiting `ClosureExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClosureExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClosureExprSyntax)
  /// Visiting `UnresolvedPatternExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `UnresolvedPatternExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: UnresolvedPatternExprSyntax)
  /// Visiting `FunctionCallExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FunctionCallExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FunctionCallExprSyntax)
  /// Visiting `SubscriptExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SubscriptExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SubscriptExprSyntax)
  /// Visiting `OptionalChainingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `OptionalChainingExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: OptionalChainingExprSyntax)
  /// Visiting `ForcedValueExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ForcedValueExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ForcedValueExprSyntax)
  /// Visiting `PostfixUnaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PostfixUnaryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PostfixUnaryExprSyntax)
  /// Visiting `SpecializeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SpecializeExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SpecializeExprSyntax)
  /// Visiting `StringSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `StringSegmentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: StringSegmentSyntax)
  /// Visiting `ExpressionSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ExpressionSegmentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ExpressionSegmentSyntax)
  /// Visiting `StringLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `StringLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: StringLiteralExprSyntax)
  /// Visiting `KeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `KeyPathExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: KeyPathExprSyntax)
  /// Visiting `KeyPathBaseExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `KeyPathBaseExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: KeyPathBaseExprSyntax)
  /// Visiting `ObjcNamePieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ObjcNamePieceSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ObjcNamePieceSyntax)
  /// Visiting `ObjcNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ObjcNameSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ObjcNameSyntax)
  /// Visiting `ObjcKeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ObjcKeyPathExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ObjcKeyPathExprSyntax)
  /// Visiting `ObjcSelectorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ObjcSelectorExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ObjcSelectorExprSyntax)
  /// Visiting `EditorPlaceholderExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `EditorPlaceholderExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: EditorPlaceholderExprSyntax)
  /// Visiting `ObjectLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ObjectLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ObjectLiteralExprSyntax)
  /// Visiting `TypeInitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TypeInitializerClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TypeInitializerClauseSyntax)
  /// Visiting `TypealiasDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TypealiasDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TypealiasDeclSyntax)
  /// Visiting `AssociatedtypeDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AssociatedtypeDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AssociatedtypeDeclSyntax)
  /// Visiting `FunctionParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FunctionParameterListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FunctionParameterListSyntax)
  /// Visiting `ParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ParameterClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ParameterClauseSyntax)
  /// Visiting `ReturnClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ReturnClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ReturnClauseSyntax)
  /// Visiting `FunctionSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FunctionSignatureSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FunctionSignatureSyntax)
  /// Visiting `IfConfigClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IfConfigClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IfConfigClauseSyntax)
  /// Visiting `IfConfigClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IfConfigClauseListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IfConfigClauseListSyntax)
  /// Visiting `IfConfigDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IfConfigDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IfConfigDeclSyntax)
  /// Visiting `PoundErrorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundErrorDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundErrorDeclSyntax)
  /// Visiting `PoundWarningDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundWarningDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundWarningDeclSyntax)
  /// Visiting `PoundSourceLocationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundSourceLocationSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundSourceLocationSyntax)
  /// Visiting `PoundSourceLocationArgsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundSourceLocationArgsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundSourceLocationArgsSyntax)
  /// Visiting `DeclModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DeclModifierSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DeclModifierSyntax)
  /// Visiting `InheritedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `InheritedTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: InheritedTypeSyntax)
  /// Visiting `InheritedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `InheritedTypeListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: InheritedTypeListSyntax)
  /// Visiting `TypeInheritanceClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TypeInheritanceClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TypeInheritanceClauseSyntax)
  /// Visiting `ClassDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClassDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClassDeclSyntax)
  /// Visiting `StructDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `StructDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: StructDeclSyntax)
  /// Visiting `ProtocolDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ProtocolDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ProtocolDeclSyntax)
  /// Visiting `ExtensionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ExtensionDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ExtensionDeclSyntax)
  /// Visiting `MemberDeclBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `MemberDeclBlockSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: MemberDeclBlockSyntax)
  /// Visiting `MemberDeclListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `MemberDeclListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: MemberDeclListSyntax)
  /// Visiting `MemberDeclListItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `MemberDeclListItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: MemberDeclListItemSyntax)
  /// Visiting `SourceFileSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SourceFileSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SourceFileSyntax)
  /// Visiting `InitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `InitializerClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: InitializerClauseSyntax)
  /// Visiting `FunctionParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FunctionParameterSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FunctionParameterSyntax)
  /// Visiting `ModifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ModifierListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ModifierListSyntax)
  /// Visiting `FunctionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FunctionDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FunctionDeclSyntax)
  /// Visiting `InitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `InitializerDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: InitializerDeclSyntax)
  /// Visiting `DeinitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DeinitializerDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DeinitializerDeclSyntax)
  /// Visiting `SubscriptDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SubscriptDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SubscriptDeclSyntax)
  /// Visiting `AccessLevelModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AccessLevelModifierSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AccessLevelModifierSyntax)
  /// Visiting `AccessPathComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AccessPathComponentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AccessPathComponentSyntax)
  /// Visiting `AccessPathSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AccessPathSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AccessPathSyntax)
  /// Visiting `ImportDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ImportDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ImportDeclSyntax)
  /// Visiting `AccessorParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AccessorParameterSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AccessorParameterSyntax)
  /// Visiting `AccessorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AccessorDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AccessorDeclSyntax)
  /// Visiting `AccessorListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AccessorListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AccessorListSyntax)
  /// Visiting `AccessorBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AccessorBlockSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AccessorBlockSyntax)
  /// Visiting `PatternBindingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PatternBindingSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PatternBindingSyntax)
  /// Visiting `PatternBindingListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PatternBindingListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PatternBindingListSyntax)
  /// Visiting `VariableDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `VariableDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: VariableDeclSyntax)
  /// Visiting `EnumCaseElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `EnumCaseElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: EnumCaseElementSyntax)
  /// Visiting `EnumCaseElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `EnumCaseElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: EnumCaseElementListSyntax)
  /// Visiting `EnumCaseDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `EnumCaseDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: EnumCaseDeclSyntax)
  /// Visiting `EnumDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `EnumDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: EnumDeclSyntax)
  /// Visiting `OperatorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `OperatorDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: OperatorDeclSyntax)
  /// Visiting `IdentifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IdentifierListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IdentifierListSyntax)
  /// Visiting `OperatorPrecedenceAndTypesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `OperatorPrecedenceAndTypesSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: OperatorPrecedenceAndTypesSyntax)
  /// Visiting `PrecedenceGroupDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PrecedenceGroupDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PrecedenceGroupDeclSyntax)
  /// Visiting `PrecedenceGroupAttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PrecedenceGroupAttributeListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PrecedenceGroupAttributeListSyntax)
  /// Visiting `PrecedenceGroupRelationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PrecedenceGroupRelationSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PrecedenceGroupRelationSyntax)
  /// Visiting `PrecedenceGroupNameListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PrecedenceGroupNameListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PrecedenceGroupNameListSyntax)
  /// Visiting `PrecedenceGroupNameElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PrecedenceGroupNameElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PrecedenceGroupNameElementSyntax)
  /// Visiting `PrecedenceGroupAssignmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PrecedenceGroupAssignmentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PrecedenceGroupAssignmentSyntax)
  /// Visiting `PrecedenceGroupAssociativitySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PrecedenceGroupAssociativitySyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PrecedenceGroupAssociativitySyntax)
  /// Visiting `TokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TokenListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TokenListSyntax)
  /// Visiting `NonEmptyTokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `NonEmptyTokenListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: NonEmptyTokenListSyntax)
  /// Visiting `CustomAttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CustomAttributeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CustomAttributeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CustomAttributeSyntax)
  /// Visiting `AttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AttributeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AttributeSyntax)
  /// Visiting `AttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AttributeListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AttributeListSyntax)
  /// Visiting `SpecializeAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SpecializeAttributeSpecListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SpecializeAttributeSpecListSyntax)
  /// Visiting `LabeledSpecializeEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `LabeledSpecializeEntrySyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: LabeledSpecializeEntrySyntax)
  /// Visiting `NamedAttributeStringArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `NamedAttributeStringArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: NamedAttributeStringArgumentSyntax)
  /// Visiting `DeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DeclNameSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DeclNameSyntax)
  /// Visiting `ImplementsAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ImplementsAttributeArgumentsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ImplementsAttributeArgumentsSyntax)
  /// Visiting `ObjCSelectorPieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ObjCSelectorPieceSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ObjCSelectorPieceSyntax)
  /// Visiting `ObjCSelectorSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ObjCSelectorSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ObjCSelectorSyntax)
  /// Visiting `ContinueStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ContinueStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ContinueStmtSyntax)
  /// Visiting `WhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `WhileStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: WhileStmtSyntax)
  /// Visiting `DeferStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DeferStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DeferStmtSyntax)
  /// Visiting `ExpressionStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ExpressionStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ExpressionStmtSyntax)
  /// Visiting `SwitchCaseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SwitchCaseListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SwitchCaseListSyntax)
  /// Visiting `RepeatWhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `RepeatWhileStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: RepeatWhileStmtSyntax)
  /// Visiting `GuardStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GuardStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GuardStmtSyntax)
  /// Visiting `WhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `WhereClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: WhereClauseSyntax)
  /// Visiting `ForInStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ForInStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ForInStmtSyntax)
  /// Visiting `SwitchStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SwitchStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SwitchStmtSyntax)
  /// Visiting `CatchClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CatchClauseListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CatchClauseListSyntax)
  /// Visiting `DoStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DoStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DoStmtSyntax)
  /// Visiting `ReturnStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ReturnStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ReturnStmtSyntax)
  /// Visiting `YieldStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `YieldStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: YieldStmtSyntax)
  /// Visiting `YieldListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `YieldListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: YieldListSyntax)
  /// Visiting `FallthroughStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FallthroughStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FallthroughStmtSyntax)
  /// Visiting `BreakStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `BreakStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: BreakStmtSyntax)
  /// Visiting `CaseItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CaseItemListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CaseItemListSyntax)
  /// Visiting `ConditionElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ConditionElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ConditionElementSyntax)
  /// Visiting `AvailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AvailabilityConditionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AvailabilityConditionSyntax)
  /// Visiting `MatchingPatternConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `MatchingPatternConditionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: MatchingPatternConditionSyntax)
  /// Visiting `OptionalBindingConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `OptionalBindingConditionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: OptionalBindingConditionSyntax)
  /// Visiting `ConditionElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ConditionElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ConditionElementListSyntax)
  /// Visiting `DeclarationStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DeclarationStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DeclarationStmtSyntax)
  /// Visiting `ThrowStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ThrowStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ThrowStmtSyntax)
  /// Visiting `IfStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IfStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IfStmtSyntax)
  /// Visiting `ElseIfContinuationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ElseIfContinuationSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ElseIfContinuationSyntax)
  /// Visiting `ElseBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ElseBlockSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ElseBlockSyntax)
  /// Visiting `SwitchCaseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SwitchCaseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SwitchCaseSyntax)
  /// Visiting `SwitchDefaultLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SwitchDefaultLabelSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SwitchDefaultLabelSyntax)
  /// Visiting `CaseItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CaseItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CaseItemSyntax)
  /// Visiting `SwitchCaseLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SwitchCaseLabelSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SwitchCaseLabelSyntax)
  /// Visiting `CatchClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CatchClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CatchClauseSyntax)
  /// Visiting `PoundAssertStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `PoundAssertStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: PoundAssertStmtSyntax)
  /// Visiting `GenericWhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericWhereClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericWhereClauseSyntax)
  /// Visiting `GenericRequirementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericRequirementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericRequirementListSyntax)
  /// Visiting `SameTypeRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SameTypeRequirementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SameTypeRequirementSyntax)
  /// Visiting `GenericParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericParameterListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericParameterListSyntax)
  /// Visiting `GenericParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericParameterSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericParameterSyntax)
  /// Visiting `GenericParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericParameterClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericParameterClauseSyntax)
  /// Visiting `ConformanceRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ConformanceRequirementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ConformanceRequirementSyntax)
  /// Visiting `SimpleTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SimpleTypeIdentifierSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SimpleTypeIdentifierSyntax)
  /// Visiting `MemberTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `MemberTypeIdentifierSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: MemberTypeIdentifierSyntax)
  /// Visiting `ClassRestrictionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ClassRestrictionTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ClassRestrictionTypeSyntax)
  /// Visiting `ArrayTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ArrayTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ArrayTypeSyntax)
  /// Visiting `DictionaryTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `DictionaryTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: DictionaryTypeSyntax)
  /// Visiting `MetatypeTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `MetatypeTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: MetatypeTypeSyntax)
  /// Visiting `OptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `OptionalTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: OptionalTypeSyntax)
  /// Visiting `SomeTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: SomeTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `SomeTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: SomeTypeSyntax)
  /// Visiting `ImplicitlyUnwrappedOptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ImplicitlyUnwrappedOptionalTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ImplicitlyUnwrappedOptionalTypeSyntax)
  /// Visiting `CompositionTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CompositionTypeElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CompositionTypeElementSyntax)
  /// Visiting `CompositionTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CompositionTypeElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CompositionTypeElementListSyntax)
  /// Visiting `CompositionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `CompositionTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: CompositionTypeSyntax)
  /// Visiting `TupleTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TupleTypeElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TupleTypeElementSyntax)
  /// Visiting `TupleTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TupleTypeElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TupleTypeElementListSyntax)
  /// Visiting `TupleTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TupleTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TupleTypeSyntax)
  /// Visiting `FunctionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `FunctionTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: FunctionTypeSyntax)
  /// Visiting `AttributedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AttributedTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AttributedTypeSyntax)
  /// Visiting `GenericArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericArgumentListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericArgumentListSyntax)
  /// Visiting `GenericArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericArgumentSyntax)
  /// Visiting `GenericArgumentClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericArgumentClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericArgumentClauseSyntax)
  /// Visiting `TypeAnnotationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TypeAnnotationSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TypeAnnotationSyntax)
  /// Visiting `EnumCasePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `EnumCasePatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: EnumCasePatternSyntax)
  /// Visiting `IsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IsTypePatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IsTypePatternSyntax)
  /// Visiting `OptionalPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `OptionalPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: OptionalPatternSyntax)
  /// Visiting `IdentifierPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `IdentifierPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: IdentifierPatternSyntax)
  /// Visiting `AsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AsTypePatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AsTypePatternSyntax)
  /// Visiting `TuplePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TuplePatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TuplePatternSyntax)
  /// Visiting `WildcardPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `WildcardPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: WildcardPatternSyntax)
  /// Visiting `TuplePatternElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TuplePatternElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TuplePatternElementSyntax)
  /// Visiting `ExpressionPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ExpressionPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ExpressionPatternSyntax)
  /// Visiting `TuplePatternElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TuplePatternElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TuplePatternElementListSyntax)
  /// Visiting `ValueBindingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `ValueBindingPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: ValueBindingPatternSyntax)
  /// Visiting `AvailabilitySpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AvailabilitySpecListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AvailabilitySpecListSyntax)
  /// Visiting `AvailabilityArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AvailabilityArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AvailabilityArgumentSyntax)
  /// Visiting `AvailabilityLabeledArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AvailabilityLabeledArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AvailabilityLabeledArgumentSyntax)
  /// Visiting `AvailabilityVersionRestrictionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `AvailabilityVersionRestrictionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: AvailabilityVersionRestrictionSyntax)
  /// Visiting `VersionTupleSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `VersionTupleSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: VersionTupleSyntax)

  /// Visiting `TokenSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting the node and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TokenSyntax)

  /// Visiting `UnknownSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: UnknownSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting the node and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: UnknownSyntax)
}

public extension SyntaxVisitor {
  mutating func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: UnknownDeclSyntax) {}
  mutating func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: UnknownExprSyntax) {}
  mutating func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: UnknownStmtSyntax) {}
  mutating func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: UnknownTypeSyntax) {}
  mutating func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: UnknownPatternSyntax) {}
  mutating func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CodeBlockItemSyntax) {}
  mutating func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CodeBlockItemListSyntax) {}
  mutating func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CodeBlockSyntax) {}
  mutating func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: InOutExprSyntax) {}
  mutating func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundColumnExprSyntax) {}
  mutating func visit(_ node: FunctionCallArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FunctionCallArgumentListSyntax) {}
  mutating func visit(_ node: TupleElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TupleElementListSyntax) {}
  mutating func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ArrayElementListSyntax) {}
  mutating func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DictionaryElementListSyntax) {}
  mutating func visit(_ node: StringLiteralSegmentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: StringLiteralSegmentsSyntax) {}
  mutating func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TryExprSyntax) {}
  mutating func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DeclNameArgumentSyntax) {}
  mutating func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DeclNameArgumentListSyntax) {}
  mutating func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DeclNameArgumentsSyntax) {}
  mutating func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IdentifierExprSyntax) {}
  mutating func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SuperRefExprSyntax) {}
  mutating func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: NilLiteralExprSyntax) {}
  mutating func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DiscardAssignmentExprSyntax) {}
  mutating func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AssignmentExprSyntax) {}
  mutating func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SequenceExprSyntax) {}
  mutating func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ExprListSyntax) {}
  mutating func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundLineExprSyntax) {}
  mutating func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundFileExprSyntax) {}
  mutating func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundFunctionExprSyntax) {}
  mutating func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundDsohandleExprSyntax) {}
  mutating func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SymbolicReferenceExprSyntax) {}
  mutating func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PrefixOperatorExprSyntax) {}
  mutating func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: BinaryOperatorExprSyntax) {}
  mutating func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ArrowExprSyntax) {}
  mutating func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FloatLiteralExprSyntax) {}
  mutating func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TupleExprSyntax) {}
  mutating func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ArrayExprSyntax) {}
  mutating func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DictionaryExprSyntax) {}
  mutating func visit(_ node: FunctionCallArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FunctionCallArgumentSyntax) {}
  mutating func visit(_ node: TupleElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TupleElementSyntax) {}
  mutating func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ArrayElementSyntax) {}
  mutating func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DictionaryElementSyntax) {}
  mutating func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IntegerLiteralExprSyntax) {}
  mutating func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: BooleanLiteralExprSyntax) {}
  mutating func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TernaryExprSyntax) {}
  mutating func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: MemberAccessExprSyntax) {}
  mutating func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IsExprSyntax) {}
  mutating func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AsExprSyntax) {}
  mutating func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TypeExprSyntax) {}
  mutating func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClosureCaptureItemSyntax) {}
  mutating func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClosureCaptureItemListSyntax) {}
  mutating func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClosureCaptureSignatureSyntax) {}
  mutating func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClosureParamSyntax) {}
  mutating func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClosureParamListSyntax) {}
  mutating func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClosureSignatureSyntax) {}
  mutating func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClosureExprSyntax) {}
  mutating func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: UnresolvedPatternExprSyntax) {}
  mutating func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FunctionCallExprSyntax) {}
  mutating func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SubscriptExprSyntax) {}
  mutating func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: OptionalChainingExprSyntax) {}
  mutating func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ForcedValueExprSyntax) {}
  mutating func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PostfixUnaryExprSyntax) {}
  mutating func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SpecializeExprSyntax) {}
  mutating func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: StringSegmentSyntax) {}
  mutating func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ExpressionSegmentSyntax) {}
  mutating func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: StringLiteralExprSyntax) {}
  mutating func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: KeyPathExprSyntax) {}
  mutating func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: KeyPathBaseExprSyntax) {}
  mutating func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ObjcNamePieceSyntax) {}
  mutating func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ObjcNameSyntax) {}
  mutating func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ObjcKeyPathExprSyntax) {}
  mutating func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ObjcSelectorExprSyntax) {}
  mutating func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: EditorPlaceholderExprSyntax) {}
  mutating func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ObjectLiteralExprSyntax) {}
  mutating func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TypeInitializerClauseSyntax) {}
  mutating func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TypealiasDeclSyntax) {}
  mutating func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AssociatedtypeDeclSyntax) {}
  mutating func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FunctionParameterListSyntax) {}
  mutating func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ParameterClauseSyntax) {}
  mutating func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ReturnClauseSyntax) {}
  mutating func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FunctionSignatureSyntax) {}
  mutating func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IfConfigClauseSyntax) {}
  mutating func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IfConfigClauseListSyntax) {}
  mutating func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IfConfigDeclSyntax) {}
  mutating func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundErrorDeclSyntax) {}
  mutating func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundWarningDeclSyntax) {}
  mutating func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundSourceLocationSyntax) {}
  mutating func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundSourceLocationArgsSyntax) {}
  mutating func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DeclModifierSyntax) {}
  mutating func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: InheritedTypeSyntax) {}
  mutating func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: InheritedTypeListSyntax) {}
  mutating func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TypeInheritanceClauseSyntax) {}
  mutating func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClassDeclSyntax) {}
  mutating func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: StructDeclSyntax) {}
  mutating func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ProtocolDeclSyntax) {}
  mutating func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ExtensionDeclSyntax) {}
  mutating func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: MemberDeclBlockSyntax) {}
  mutating func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: MemberDeclListSyntax) {}
  mutating func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: MemberDeclListItemSyntax) {}
  mutating func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SourceFileSyntax) {}
  mutating func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: InitializerClauseSyntax) {}
  mutating func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FunctionParameterSyntax) {}
  mutating func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ModifierListSyntax) {}
  mutating func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FunctionDeclSyntax) {}
  mutating func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: InitializerDeclSyntax) {}
  mutating func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DeinitializerDeclSyntax) {}
  mutating func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SubscriptDeclSyntax) {}
  mutating func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AccessLevelModifierSyntax) {}
  mutating func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AccessPathComponentSyntax) {}
  mutating func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AccessPathSyntax) {}
  mutating func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ImportDeclSyntax) {}
  mutating func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AccessorParameterSyntax) {}
  mutating func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AccessorDeclSyntax) {}
  mutating func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AccessorListSyntax) {}
  mutating func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AccessorBlockSyntax) {}
  mutating func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PatternBindingSyntax) {}
  mutating func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PatternBindingListSyntax) {}
  mutating func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: VariableDeclSyntax) {}
  mutating func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: EnumCaseElementSyntax) {}
  mutating func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: EnumCaseElementListSyntax) {}
  mutating func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: EnumCaseDeclSyntax) {}
  mutating func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: EnumDeclSyntax) {}
  mutating func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: OperatorDeclSyntax) {}
  mutating func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IdentifierListSyntax) {}
  mutating func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: OperatorPrecedenceAndTypesSyntax) {}
  mutating func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PrecedenceGroupDeclSyntax) {}
  mutating func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PrecedenceGroupAttributeListSyntax) {}
  mutating func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PrecedenceGroupRelationSyntax) {}
  mutating func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PrecedenceGroupNameListSyntax) {}
  mutating func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PrecedenceGroupNameElementSyntax) {}
  mutating func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PrecedenceGroupAssignmentSyntax) {}
  mutating func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PrecedenceGroupAssociativitySyntax) {}
  mutating func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TokenListSyntax) {}
  mutating func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: NonEmptyTokenListSyntax) {}
  mutating func visit(_ node: CustomAttributeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CustomAttributeSyntax) {}
  mutating func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AttributeSyntax) {}
  mutating func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AttributeListSyntax) {}
  mutating func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SpecializeAttributeSpecListSyntax) {}
  mutating func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: LabeledSpecializeEntrySyntax) {}
  mutating func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: NamedAttributeStringArgumentSyntax) {}
  mutating func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DeclNameSyntax) {}
  mutating func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ImplementsAttributeArgumentsSyntax) {}
  mutating func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ObjCSelectorPieceSyntax) {}
  mutating func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ObjCSelectorSyntax) {}
  mutating func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ContinueStmtSyntax) {}
  mutating func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: WhileStmtSyntax) {}
  mutating func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DeferStmtSyntax) {}
  mutating func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ExpressionStmtSyntax) {}
  mutating func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SwitchCaseListSyntax) {}
  mutating func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: RepeatWhileStmtSyntax) {}
  mutating func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GuardStmtSyntax) {}
  mutating func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: WhereClauseSyntax) {}
  mutating func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ForInStmtSyntax) {}
  mutating func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SwitchStmtSyntax) {}
  mutating func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CatchClauseListSyntax) {}
  mutating func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DoStmtSyntax) {}
  mutating func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ReturnStmtSyntax) {}
  mutating func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: YieldStmtSyntax) {}
  mutating func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: YieldListSyntax) {}
  mutating func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FallthroughStmtSyntax) {}
  mutating func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: BreakStmtSyntax) {}
  mutating func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CaseItemListSyntax) {}
  mutating func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ConditionElementSyntax) {}
  mutating func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AvailabilityConditionSyntax) {}
  mutating func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: MatchingPatternConditionSyntax) {}
  mutating func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: OptionalBindingConditionSyntax) {}
  mutating func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ConditionElementListSyntax) {}
  mutating func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DeclarationStmtSyntax) {}
  mutating func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ThrowStmtSyntax) {}
  mutating func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IfStmtSyntax) {}
  mutating func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ElseIfContinuationSyntax) {}
  mutating func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ElseBlockSyntax) {}
  mutating func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SwitchCaseSyntax) {}
  mutating func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SwitchDefaultLabelSyntax) {}
  mutating func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CaseItemSyntax) {}
  mutating func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SwitchCaseLabelSyntax) {}
  mutating func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CatchClauseSyntax) {}
  mutating func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: PoundAssertStmtSyntax) {}
  mutating func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericWhereClauseSyntax) {}
  mutating func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericRequirementListSyntax) {}
  mutating func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SameTypeRequirementSyntax) {}
  mutating func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericParameterListSyntax) {}
  mutating func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericParameterSyntax) {}
  mutating func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericParameterClauseSyntax) {}
  mutating func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ConformanceRequirementSyntax) {}
  mutating func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SimpleTypeIdentifierSyntax) {}
  mutating func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: MemberTypeIdentifierSyntax) {}
  mutating func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ClassRestrictionTypeSyntax) {}
  mutating func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ArrayTypeSyntax) {}
  mutating func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: DictionaryTypeSyntax) {}
  mutating func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: MetatypeTypeSyntax) {}
  mutating func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: OptionalTypeSyntax) {}
  mutating func visit(_ node: SomeTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: SomeTypeSyntax) {}
  mutating func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) {}
  mutating func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CompositionTypeElementSyntax) {}
  mutating func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CompositionTypeElementListSyntax) {}
  mutating func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: CompositionTypeSyntax) {}
  mutating func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TupleTypeElementSyntax) {}
  mutating func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TupleTypeElementListSyntax) {}
  mutating func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TupleTypeSyntax) {}
  mutating func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: FunctionTypeSyntax) {}
  mutating func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AttributedTypeSyntax) {}
  mutating func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericArgumentListSyntax) {}
  mutating func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericArgumentSyntax) {}
  mutating func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericArgumentClauseSyntax) {}
  mutating func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TypeAnnotationSyntax) {}
  mutating func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: EnumCasePatternSyntax) {}
  mutating func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IsTypePatternSyntax) {}
  mutating func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: OptionalPatternSyntax) {}
  mutating func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: IdentifierPatternSyntax) {}
  mutating func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AsTypePatternSyntax) {}
  mutating func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TuplePatternSyntax) {}
  mutating func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: WildcardPatternSyntax) {}
  mutating func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TuplePatternElementSyntax) {}
  mutating func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ExpressionPatternSyntax) {}
  mutating func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TuplePatternElementListSyntax) {}
  mutating func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: ValueBindingPatternSyntax) {}
  mutating func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AvailabilitySpecListSyntax) {}
  mutating func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AvailabilityArgumentSyntax) {}
  mutating func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AvailabilityLabeledArgumentSyntax) {}
  mutating func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: AvailabilityVersionRestrictionSyntax) {}
  mutating func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: VersionTupleSyntax) {}

  mutating func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TokenSyntax) {}

  mutating func visit(_ node: UnknownSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: UnknownSyntax) {}
}

/// A `SyntaxVisitor` that can visit the nodes as generic `Syntax` values.
///
/// This is a separate protocol because this kind of visitation is slower than
/// the type-specific visitation of `SyntaxVisitor`. Use `SyntaxAnyVisitor` if
/// the `visitAny(_)` function would be useful to have, otherwise use
/// `SyntaxVisitor`.
///
/// This works by introducing default implementations of the type-specific
/// visit function that delegate to `visitAny(_)`. A conformant type that
/// provides a custom type-specific visit function, should also call
/// `visitAny(_)` in its implementation, if calling `visitAny` is needed:
///
///     struct MyVisitor: SyntaxAnyVisitor {
///       func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
///         <code>
///       }
///
///       func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
///         <code>
///         // Call this to pass tokens to `visitAny(_)` as well if needed
///         visitAny(token)
///       }
///
public protocol SyntaxAnyVisitor: SyntaxVisitor {
  mutating func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind
  mutating func visitAnyPost(_ node: Syntax)
}

public extension SyntaxAnyVisitor {
  mutating func visitAnyPost(_ node: Syntax) {}

  mutating func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: UnknownDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: UnknownExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: UnknownStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: UnknownTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: UnknownPatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CodeBlockItemSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CodeBlockItemListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CodeBlockSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: InOutExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundColumnExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FunctionCallArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FunctionCallArgumentListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TupleElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TupleElementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ArrayElementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DictionaryElementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: StringLiteralSegmentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: StringLiteralSegmentsSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TryExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DeclNameArgumentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DeclNameArgumentListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DeclNameArgumentsSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IdentifierExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SuperRefExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: NilLiteralExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DiscardAssignmentExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AssignmentExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SequenceExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ExprListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundLineExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundFileExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundFunctionExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundDsohandleExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SymbolicReferenceExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PrefixOperatorExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: BinaryOperatorExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ArrowExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FloatLiteralExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TupleExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ArrayExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DictionaryExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FunctionCallArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FunctionCallArgumentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TupleElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TupleElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ArrayElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DictionaryElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IntegerLiteralExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: BooleanLiteralExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TernaryExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: MemberAccessExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IsExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AsExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TypeExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClosureCaptureItemSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClosureCaptureItemListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClosureCaptureSignatureSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClosureParamSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClosureParamListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClosureSignatureSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClosureExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: UnresolvedPatternExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FunctionCallExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SubscriptExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: OptionalChainingExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ForcedValueExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PostfixUnaryExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SpecializeExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: StringSegmentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ExpressionSegmentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: StringLiteralExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: KeyPathExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: KeyPathBaseExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ObjcNamePieceSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ObjcNameSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ObjcKeyPathExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ObjcSelectorExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: EditorPlaceholderExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ObjectLiteralExprSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TypeInitializerClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TypealiasDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AssociatedtypeDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FunctionParameterListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ParameterClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ReturnClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FunctionSignatureSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IfConfigClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IfConfigClauseListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IfConfigDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundErrorDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundWarningDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundSourceLocationSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundSourceLocationArgsSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DeclModifierSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: InheritedTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: InheritedTypeListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TypeInheritanceClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClassDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: StructDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ProtocolDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ExtensionDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: MemberDeclBlockSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: MemberDeclListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: MemberDeclListItemSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SourceFileSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: InitializerClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FunctionParameterSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ModifierListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FunctionDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: InitializerDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DeinitializerDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SubscriptDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AccessLevelModifierSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AccessPathComponentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AccessPathSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ImportDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AccessorParameterSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AccessorDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AccessorListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AccessorBlockSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PatternBindingSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PatternBindingListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: VariableDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: EnumCaseElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: EnumCaseElementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: EnumCaseDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: EnumDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: OperatorDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IdentifierListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: OperatorPrecedenceAndTypesSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PrecedenceGroupDeclSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PrecedenceGroupAttributeListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PrecedenceGroupRelationSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PrecedenceGroupNameListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PrecedenceGroupNameElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PrecedenceGroupAssignmentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PrecedenceGroupAssociativitySyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TokenListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: NonEmptyTokenListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CustomAttributeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CustomAttributeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AttributeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AttributeListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SpecializeAttributeSpecListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: LabeledSpecializeEntrySyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: NamedAttributeStringArgumentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DeclNameSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ImplementsAttributeArgumentsSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ObjCSelectorPieceSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ObjCSelectorSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ContinueStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: WhileStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DeferStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ExpressionStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SwitchCaseListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: RepeatWhileStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GuardStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: WhereClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ForInStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SwitchStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CatchClauseListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DoStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ReturnStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: YieldStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: YieldListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FallthroughStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: BreakStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CaseItemListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ConditionElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AvailabilityConditionSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: MatchingPatternConditionSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: OptionalBindingConditionSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ConditionElementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DeclarationStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ThrowStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IfStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ElseIfContinuationSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ElseBlockSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SwitchCaseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SwitchDefaultLabelSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CaseItemSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SwitchCaseLabelSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CatchClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: PoundAssertStmtSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericWhereClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericRequirementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SameTypeRequirementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericParameterListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericParameterSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericParameterClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ConformanceRequirementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SimpleTypeIdentifierSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: MemberTypeIdentifierSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ClassRestrictionTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ArrayTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: DictionaryTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: MetatypeTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: OptionalTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: SomeTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: SomeTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CompositionTypeElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CompositionTypeElementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: CompositionTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TupleTypeElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TupleTypeElementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TupleTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: FunctionTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AttributedTypeSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericArgumentListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericArgumentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericArgumentClauseSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TypeAnnotationSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: EnumCasePatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IsTypePatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: OptionalPatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: IdentifierPatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AsTypePatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TuplePatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: WildcardPatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TuplePatternElementSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ExpressionPatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TuplePatternElementListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: ValueBindingPatternSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AvailabilitySpecListSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AvailabilityArgumentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AvailabilityLabeledArgumentSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: AvailabilityVersionRestrictionSyntax) {
    return visitAnyPost(node)
  }
  mutating func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: VersionTupleSyntax) {
    return visitAnyPost(node)
  }

  mutating func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(token)
  }
  mutating func visitPost(_ node: TokenSyntax) {
    return visitAnyPost(node)
  }

  mutating func visit(_ node: UnknownSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: UnknownSyntax) {
    return visitAnyPost(node)
  }
}

/// A class version of the `SyntaxVisitor` protocol. This is useful if you
/// intend to have subclasses overriding specific methods of a common base
/// `SyntaxVisitor` class.
///
/// It workarounds the issue of not being able to override the default
/// implementations of the protocol (see https://bugs.swift.org/browse/SR-103).
open class SyntaxVisitorBase: SyntaxVisitor {
  public init() {}

  open func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: UnknownDeclSyntax) {}
  open func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: UnknownExprSyntax) {}
  open func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: UnknownStmtSyntax) {}
  open func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: UnknownTypeSyntax) {}
  open func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: UnknownPatternSyntax) {}
  open func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CodeBlockItemSyntax) {}
  open func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CodeBlockItemListSyntax) {}
  open func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CodeBlockSyntax) {}
  open func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: InOutExprSyntax) {}
  open func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundColumnExprSyntax) {}
  open func visit(_ node: FunctionCallArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FunctionCallArgumentListSyntax) {}
  open func visit(_ node: TupleElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TupleElementListSyntax) {}
  open func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ArrayElementListSyntax) {}
  open func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DictionaryElementListSyntax) {}
  open func visit(_ node: StringLiteralSegmentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: StringLiteralSegmentsSyntax) {}
  open func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TryExprSyntax) {}
  open func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DeclNameArgumentSyntax) {}
  open func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DeclNameArgumentListSyntax) {}
  open func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DeclNameArgumentsSyntax) {}
  open func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IdentifierExprSyntax) {}
  open func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SuperRefExprSyntax) {}
  open func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: NilLiteralExprSyntax) {}
  open func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DiscardAssignmentExprSyntax) {}
  open func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AssignmentExprSyntax) {}
  open func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SequenceExprSyntax) {}
  open func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ExprListSyntax) {}
  open func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundLineExprSyntax) {}
  open func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundFileExprSyntax) {}
  open func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundFunctionExprSyntax) {}
  open func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundDsohandleExprSyntax) {}
  open func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SymbolicReferenceExprSyntax) {}
  open func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PrefixOperatorExprSyntax) {}
  open func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: BinaryOperatorExprSyntax) {}
  open func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ArrowExprSyntax) {}
  open func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FloatLiteralExprSyntax) {}
  open func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TupleExprSyntax) {}
  open func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ArrayExprSyntax) {}
  open func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DictionaryExprSyntax) {}
  open func visit(_ node: FunctionCallArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FunctionCallArgumentSyntax) {}
  open func visit(_ node: TupleElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TupleElementSyntax) {}
  open func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ArrayElementSyntax) {}
  open func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DictionaryElementSyntax) {}
  open func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IntegerLiteralExprSyntax) {}
  open func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: BooleanLiteralExprSyntax) {}
  open func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TernaryExprSyntax) {}
  open func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: MemberAccessExprSyntax) {}
  open func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IsExprSyntax) {}
  open func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AsExprSyntax) {}
  open func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TypeExprSyntax) {}
  open func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClosureCaptureItemSyntax) {}
  open func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClosureCaptureItemListSyntax) {}
  open func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClosureCaptureSignatureSyntax) {}
  open func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClosureParamSyntax) {}
  open func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClosureParamListSyntax) {}
  open func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClosureSignatureSyntax) {}
  open func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClosureExprSyntax) {}
  open func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: UnresolvedPatternExprSyntax) {}
  open func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FunctionCallExprSyntax) {}
  open func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SubscriptExprSyntax) {}
  open func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: OptionalChainingExprSyntax) {}
  open func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ForcedValueExprSyntax) {}
  open func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PostfixUnaryExprSyntax) {}
  open func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SpecializeExprSyntax) {}
  open func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: StringSegmentSyntax) {}
  open func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ExpressionSegmentSyntax) {}
  open func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: StringLiteralExprSyntax) {}
  open func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: KeyPathExprSyntax) {}
  open func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: KeyPathBaseExprSyntax) {}
  open func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ObjcNamePieceSyntax) {}
  open func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ObjcNameSyntax) {}
  open func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ObjcKeyPathExprSyntax) {}
  open func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ObjcSelectorExprSyntax) {}
  open func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: EditorPlaceholderExprSyntax) {}
  open func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ObjectLiteralExprSyntax) {}
  open func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TypeInitializerClauseSyntax) {}
  open func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TypealiasDeclSyntax) {}
  open func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AssociatedtypeDeclSyntax) {}
  open func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FunctionParameterListSyntax) {}
  open func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ParameterClauseSyntax) {}
  open func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ReturnClauseSyntax) {}
  open func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FunctionSignatureSyntax) {}
  open func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IfConfigClauseSyntax) {}
  open func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IfConfigClauseListSyntax) {}
  open func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IfConfigDeclSyntax) {}
  open func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundErrorDeclSyntax) {}
  open func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundWarningDeclSyntax) {}
  open func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundSourceLocationSyntax) {}
  open func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundSourceLocationArgsSyntax) {}
  open func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DeclModifierSyntax) {}
  open func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: InheritedTypeSyntax) {}
  open func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: InheritedTypeListSyntax) {}
  open func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TypeInheritanceClauseSyntax) {}
  open func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClassDeclSyntax) {}
  open func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: StructDeclSyntax) {}
  open func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ProtocolDeclSyntax) {}
  open func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ExtensionDeclSyntax) {}
  open func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: MemberDeclBlockSyntax) {}
  open func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: MemberDeclListSyntax) {}
  open func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: MemberDeclListItemSyntax) {}
  open func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SourceFileSyntax) {}
  open func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: InitializerClauseSyntax) {}
  open func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FunctionParameterSyntax) {}
  open func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ModifierListSyntax) {}
  open func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FunctionDeclSyntax) {}
  open func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: InitializerDeclSyntax) {}
  open func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DeinitializerDeclSyntax) {}
  open func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SubscriptDeclSyntax) {}
  open func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AccessLevelModifierSyntax) {}
  open func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AccessPathComponentSyntax) {}
  open func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AccessPathSyntax) {}
  open func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ImportDeclSyntax) {}
  open func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AccessorParameterSyntax) {}
  open func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AccessorDeclSyntax) {}
  open func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AccessorListSyntax) {}
  open func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AccessorBlockSyntax) {}
  open func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PatternBindingSyntax) {}
  open func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PatternBindingListSyntax) {}
  open func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: VariableDeclSyntax) {}
  open func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: EnumCaseElementSyntax) {}
  open func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: EnumCaseElementListSyntax) {}
  open func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: EnumCaseDeclSyntax) {}
  open func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: EnumDeclSyntax) {}
  open func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: OperatorDeclSyntax) {}
  open func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IdentifierListSyntax) {}
  open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: OperatorPrecedenceAndTypesSyntax) {}
  open func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PrecedenceGroupDeclSyntax) {}
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PrecedenceGroupAttributeListSyntax) {}
  open func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PrecedenceGroupRelationSyntax) {}
  open func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PrecedenceGroupNameListSyntax) {}
  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PrecedenceGroupNameElementSyntax) {}
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PrecedenceGroupAssignmentSyntax) {}
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PrecedenceGroupAssociativitySyntax) {}
  open func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TokenListSyntax) {}
  open func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: NonEmptyTokenListSyntax) {}
  open func visit(_ node: CustomAttributeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CustomAttributeSyntax) {}
  open func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AttributeSyntax) {}
  open func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AttributeListSyntax) {}
  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SpecializeAttributeSpecListSyntax) {}
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: LabeledSpecializeEntrySyntax) {}
  open func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: NamedAttributeStringArgumentSyntax) {}
  open func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DeclNameSyntax) {}
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ImplementsAttributeArgumentsSyntax) {}
  open func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ObjCSelectorPieceSyntax) {}
  open func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ObjCSelectorSyntax) {}
  open func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ContinueStmtSyntax) {}
  open func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: WhileStmtSyntax) {}
  open func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DeferStmtSyntax) {}
  open func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ExpressionStmtSyntax) {}
  open func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SwitchCaseListSyntax) {}
  open func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: RepeatWhileStmtSyntax) {}
  open func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GuardStmtSyntax) {}
  open func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: WhereClauseSyntax) {}
  open func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ForInStmtSyntax) {}
  open func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SwitchStmtSyntax) {}
  open func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CatchClauseListSyntax) {}
  open func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DoStmtSyntax) {}
  open func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ReturnStmtSyntax) {}
  open func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: YieldStmtSyntax) {}
  open func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: YieldListSyntax) {}
  open func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FallthroughStmtSyntax) {}
  open func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: BreakStmtSyntax) {}
  open func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CaseItemListSyntax) {}
  open func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ConditionElementSyntax) {}
  open func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AvailabilityConditionSyntax) {}
  open func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: MatchingPatternConditionSyntax) {}
  open func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: OptionalBindingConditionSyntax) {}
  open func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ConditionElementListSyntax) {}
  open func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DeclarationStmtSyntax) {}
  open func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ThrowStmtSyntax) {}
  open func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IfStmtSyntax) {}
  open func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ElseIfContinuationSyntax) {}
  open func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ElseBlockSyntax) {}
  open func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SwitchCaseSyntax) {}
  open func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SwitchDefaultLabelSyntax) {}
  open func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CaseItemSyntax) {}
  open func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SwitchCaseLabelSyntax) {}
  open func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CatchClauseSyntax) {}
  open func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: PoundAssertStmtSyntax) {}
  open func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericWhereClauseSyntax) {}
  open func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericRequirementListSyntax) {}
  open func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SameTypeRequirementSyntax) {}
  open func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericParameterListSyntax) {}
  open func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericParameterSyntax) {}
  open func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericParameterClauseSyntax) {}
  open func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ConformanceRequirementSyntax) {}
  open func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SimpleTypeIdentifierSyntax) {}
  open func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: MemberTypeIdentifierSyntax) {}
  open func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ClassRestrictionTypeSyntax) {}
  open func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ArrayTypeSyntax) {}
  open func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: DictionaryTypeSyntax) {}
  open func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: MetatypeTypeSyntax) {}
  open func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: OptionalTypeSyntax) {}
  open func visit(_ node: SomeTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: SomeTypeSyntax) {}
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) {}
  open func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CompositionTypeElementSyntax) {}
  open func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CompositionTypeElementListSyntax) {}
  open func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: CompositionTypeSyntax) {}
  open func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TupleTypeElementSyntax) {}
  open func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TupleTypeElementListSyntax) {}
  open func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TupleTypeSyntax) {}
  open func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: FunctionTypeSyntax) {}
  open func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AttributedTypeSyntax) {}
  open func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericArgumentListSyntax) {}
  open func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericArgumentSyntax) {}
  open func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericArgumentClauseSyntax) {}
  open func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TypeAnnotationSyntax) {}
  open func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: EnumCasePatternSyntax) {}
  open func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IsTypePatternSyntax) {}
  open func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: OptionalPatternSyntax) {}
  open func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: IdentifierPatternSyntax) {}
  open func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AsTypePatternSyntax) {}
  open func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TuplePatternSyntax) {}
  open func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: WildcardPatternSyntax) {}
  open func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TuplePatternElementSyntax) {}
  open func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ExpressionPatternSyntax) {}
  open func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TuplePatternElementListSyntax) {}
  open func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: ValueBindingPatternSyntax) {}
  open func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AvailabilitySpecListSyntax) {}
  open func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AvailabilityArgumentSyntax) {}
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AvailabilityLabeledArgumentSyntax) {}
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: AvailabilityVersionRestrictionSyntax) {}
  open func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: VersionTupleSyntax) {}

  open func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TokenSyntax) {}

  open func visit(_ node: UnknownSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: UnknownSyntax) {}
}

extension _SyntaxBase {
  func walk<Visitor>(_ visitor: inout Visitor) where Visitor : SyntaxVisitor {
    guard isPresent else { return }
    return doVisit(data, &visitor)
  }
}

extension Syntax {
  public func walk<Visitor>(_ visitor: inout Visitor) where Visitor : SyntaxVisitor {
    return base.walk(&visitor)
  }
}

fileprivate func doVisit<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor {
  // Create the node types directly instead of going through `makeSyntax()`
  // which has additional cost for casting back and forth from `_SyntaxBase`.
  switch data.raw.kind {
  case .token:
    let node = TokenSyntax(data)
    _ = visitor.visit(node)
    // No children to visit.
    visitor.visitPost(node)
  case .unknown:
    let node = UnknownSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .decl:
    let node = UnknownDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .expr:
    let node = UnknownExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .stmt:
    let node = UnknownStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .type:
    let node = UnknownTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .pattern:
    let node = UnknownPatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .unknownDecl:
    let node = UnknownDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .unknownExpr:
    let node = UnknownExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .unknownStmt:
    let node = UnknownStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .unknownType:
    let node = UnknownTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .unknownPattern:
    let node = UnknownPatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .codeBlockItem:
    let node = CodeBlockItemSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .codeBlockItemList:
    let node = CodeBlockItemListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .codeBlock:
    let node = CodeBlockSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .inOutExpr:
    let node = InOutExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundColumnExpr:
    let node = PoundColumnExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .functionCallArgumentList:
    let node = FunctionCallArgumentListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tupleElementList:
    let node = TupleElementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .arrayElementList:
    let node = ArrayElementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .dictionaryElementList:
    let node = DictionaryElementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .stringLiteralSegments:
    let node = StringLiteralSegmentsSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tryExpr:
    let node = TryExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .declNameArgument:
    let node = DeclNameArgumentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .declNameArgumentList:
    let node = DeclNameArgumentListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .declNameArguments:
    let node = DeclNameArgumentsSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .identifierExpr:
    let node = IdentifierExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .superRefExpr:
    let node = SuperRefExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .nilLiteralExpr:
    let node = NilLiteralExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .discardAssignmentExpr:
    let node = DiscardAssignmentExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .assignmentExpr:
    let node = AssignmentExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .sequenceExpr:
    let node = SequenceExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .exprList:
    let node = ExprListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundLineExpr:
    let node = PoundLineExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundFileExpr:
    let node = PoundFileExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundFunctionExpr:
    let node = PoundFunctionExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundDsohandleExpr:
    let node = PoundDsohandleExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .symbolicReferenceExpr:
    let node = SymbolicReferenceExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .prefixOperatorExpr:
    let node = PrefixOperatorExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .binaryOperatorExpr:
    let node = BinaryOperatorExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .arrowExpr:
    let node = ArrowExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .floatLiteralExpr:
    let node = FloatLiteralExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tupleExpr:
    let node = TupleExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .arrayExpr:
    let node = ArrayExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .dictionaryExpr:
    let node = DictionaryExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .functionCallArgument:
    let node = FunctionCallArgumentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tupleElement:
    let node = TupleElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .arrayElement:
    let node = ArrayElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .dictionaryElement:
    let node = DictionaryElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .integerLiteralExpr:
    let node = IntegerLiteralExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .booleanLiteralExpr:
    let node = BooleanLiteralExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .ternaryExpr:
    let node = TernaryExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .memberAccessExpr:
    let node = MemberAccessExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .isExpr:
    let node = IsExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .asExpr:
    let node = AsExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .typeExpr:
    let node = TypeExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .closureCaptureItem:
    let node = ClosureCaptureItemSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .closureCaptureItemList:
    let node = ClosureCaptureItemListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .closureCaptureSignature:
    let node = ClosureCaptureSignatureSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .closureParam:
    let node = ClosureParamSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .closureParamList:
    let node = ClosureParamListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .closureSignature:
    let node = ClosureSignatureSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .closureExpr:
    let node = ClosureExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .unresolvedPatternExpr:
    let node = UnresolvedPatternExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .functionCallExpr:
    let node = FunctionCallExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .subscriptExpr:
    let node = SubscriptExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .optionalChainingExpr:
    let node = OptionalChainingExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .forcedValueExpr:
    let node = ForcedValueExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .postfixUnaryExpr:
    let node = PostfixUnaryExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .specializeExpr:
    let node = SpecializeExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .stringSegment:
    let node = StringSegmentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .expressionSegment:
    let node = ExpressionSegmentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .stringLiteralExpr:
    let node = StringLiteralExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .keyPathExpr:
    let node = KeyPathExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .keyPathBaseExpr:
    let node = KeyPathBaseExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .objcNamePiece:
    let node = ObjcNamePieceSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .objcName:
    let node = ObjcNameSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .objcKeyPathExpr:
    let node = ObjcKeyPathExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .objcSelectorExpr:
    let node = ObjcSelectorExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .editorPlaceholderExpr:
    let node = EditorPlaceholderExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .objectLiteralExpr:
    let node = ObjectLiteralExprSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .typeInitializerClause:
    let node = TypeInitializerClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .typealiasDecl:
    let node = TypealiasDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .associatedtypeDecl:
    let node = AssociatedtypeDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .functionParameterList:
    let node = FunctionParameterListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .parameterClause:
    let node = ParameterClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .returnClause:
    let node = ReturnClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .functionSignature:
    let node = FunctionSignatureSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .ifConfigClause:
    let node = IfConfigClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .ifConfigClauseList:
    let node = IfConfigClauseListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .ifConfigDecl:
    let node = IfConfigDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundErrorDecl:
    let node = PoundErrorDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundWarningDecl:
    let node = PoundWarningDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundSourceLocation:
    let node = PoundSourceLocationSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundSourceLocationArgs:
    let node = PoundSourceLocationArgsSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .declModifier:
    let node = DeclModifierSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .inheritedType:
    let node = InheritedTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .inheritedTypeList:
    let node = InheritedTypeListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .typeInheritanceClause:
    let node = TypeInheritanceClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .classDecl:
    let node = ClassDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .structDecl:
    let node = StructDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .protocolDecl:
    let node = ProtocolDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .extensionDecl:
    let node = ExtensionDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .memberDeclBlock:
    let node = MemberDeclBlockSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .memberDeclList:
    let node = MemberDeclListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .memberDeclListItem:
    let node = MemberDeclListItemSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .sourceFile:
    let node = SourceFileSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .initializerClause:
    let node = InitializerClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .functionParameter:
    let node = FunctionParameterSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .modifierList:
    let node = ModifierListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .functionDecl:
    let node = FunctionDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .initializerDecl:
    let node = InitializerDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .deinitializerDecl:
    let node = DeinitializerDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .subscriptDecl:
    let node = SubscriptDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .accessLevelModifier:
    let node = AccessLevelModifierSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .accessPathComponent:
    let node = AccessPathComponentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .accessPath:
    let node = AccessPathSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .importDecl:
    let node = ImportDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .accessorParameter:
    let node = AccessorParameterSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .accessorDecl:
    let node = AccessorDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .accessorList:
    let node = AccessorListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .accessorBlock:
    let node = AccessorBlockSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .patternBinding:
    let node = PatternBindingSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .patternBindingList:
    let node = PatternBindingListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .variableDecl:
    let node = VariableDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .enumCaseElement:
    let node = EnumCaseElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .enumCaseElementList:
    let node = EnumCaseElementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .enumCaseDecl:
    let node = EnumCaseDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .enumDecl:
    let node = EnumDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .operatorDecl:
    let node = OperatorDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .identifierList:
    let node = IdentifierListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .operatorPrecedenceAndTypes:
    let node = OperatorPrecedenceAndTypesSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .precedenceGroupDecl:
    let node = PrecedenceGroupDeclSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .precedenceGroupAttributeList:
    let node = PrecedenceGroupAttributeListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .precedenceGroupRelation:
    let node = PrecedenceGroupRelationSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .precedenceGroupNameList:
    let node = PrecedenceGroupNameListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .precedenceGroupNameElement:
    let node = PrecedenceGroupNameElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .precedenceGroupAssignment:
    let node = PrecedenceGroupAssignmentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .precedenceGroupAssociativity:
    let node = PrecedenceGroupAssociativitySyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tokenList:
    let node = TokenListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .nonEmptyTokenList:
    let node = NonEmptyTokenListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .customAttribute:
    let node = CustomAttributeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .attribute:
    let node = AttributeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .attributeList:
    let node = AttributeListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .specializeAttributeSpecList:
    let node = SpecializeAttributeSpecListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .labeledSpecializeEntry:
    let node = LabeledSpecializeEntrySyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .namedAttributeStringArgument:
    let node = NamedAttributeStringArgumentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .declName:
    let node = DeclNameSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .implementsAttributeArguments:
    let node = ImplementsAttributeArgumentsSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .objCSelectorPiece:
    let node = ObjCSelectorPieceSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .objCSelector:
    let node = ObjCSelectorSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .continueStmt:
    let node = ContinueStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .whileStmt:
    let node = WhileStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .deferStmt:
    let node = DeferStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .expressionStmt:
    let node = ExpressionStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .switchCaseList:
    let node = SwitchCaseListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .repeatWhileStmt:
    let node = RepeatWhileStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .guardStmt:
    let node = GuardStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .whereClause:
    let node = WhereClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .forInStmt:
    let node = ForInStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .switchStmt:
    let node = SwitchStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .catchClauseList:
    let node = CatchClauseListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .doStmt:
    let node = DoStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .returnStmt:
    let node = ReturnStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .yieldStmt:
    let node = YieldStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .yieldList:
    let node = YieldListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .fallthroughStmt:
    let node = FallthroughStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .breakStmt:
    let node = BreakStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .caseItemList:
    let node = CaseItemListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .conditionElement:
    let node = ConditionElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .availabilityCondition:
    let node = AvailabilityConditionSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .matchingPatternCondition:
    let node = MatchingPatternConditionSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .optionalBindingCondition:
    let node = OptionalBindingConditionSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .conditionElementList:
    let node = ConditionElementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .declarationStmt:
    let node = DeclarationStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .throwStmt:
    let node = ThrowStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .ifStmt:
    let node = IfStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .elseIfContinuation:
    let node = ElseIfContinuationSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .elseBlock:
    let node = ElseBlockSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .switchCase:
    let node = SwitchCaseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .switchDefaultLabel:
    let node = SwitchDefaultLabelSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .caseItem:
    let node = CaseItemSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .switchCaseLabel:
    let node = SwitchCaseLabelSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .catchClause:
    let node = CatchClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .poundAssertStmt:
    let node = PoundAssertStmtSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .genericWhereClause:
    let node = GenericWhereClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .genericRequirementList:
    let node = GenericRequirementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .sameTypeRequirement:
    let node = SameTypeRequirementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .genericParameterList:
    let node = GenericParameterListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .genericParameter:
    let node = GenericParameterSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .genericParameterClause:
    let node = GenericParameterClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .conformanceRequirement:
    let node = ConformanceRequirementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .simpleTypeIdentifier:
    let node = SimpleTypeIdentifierSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .memberTypeIdentifier:
    let node = MemberTypeIdentifierSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .classRestrictionType:
    let node = ClassRestrictionTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .arrayType:
    let node = ArrayTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .dictionaryType:
    let node = DictionaryTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .metatypeType:
    let node = MetatypeTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .optionalType:
    let node = OptionalTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .someType:
    let node = SomeTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .implicitlyUnwrappedOptionalType:
    let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .compositionTypeElement:
    let node = CompositionTypeElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .compositionTypeElementList:
    let node = CompositionTypeElementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .compositionType:
    let node = CompositionTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tupleTypeElement:
    let node = TupleTypeElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tupleTypeElementList:
    let node = TupleTypeElementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tupleType:
    let node = TupleTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .functionType:
    let node = FunctionTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .attributedType:
    let node = AttributedTypeSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .genericArgumentList:
    let node = GenericArgumentListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .genericArgument:
    let node = GenericArgumentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .genericArgumentClause:
    let node = GenericArgumentClauseSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .typeAnnotation:
    let node = TypeAnnotationSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .enumCasePattern:
    let node = EnumCasePatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .isTypePattern:
    let node = IsTypePatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .optionalPattern:
    let node = OptionalPatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .identifierPattern:
    let node = IdentifierPatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .asTypePattern:
    let node = AsTypePatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tuplePattern:
    let node = TuplePatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .wildcardPattern:
    let node = WildcardPatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tuplePatternElement:
    let node = TuplePatternElementSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .expressionPattern:
    let node = ExpressionPatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .tuplePatternElementList:
    let node = TuplePatternElementListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .valueBindingPattern:
    let node = ValueBindingPatternSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .availabilitySpecList:
    let node = AvailabilitySpecListSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .availabilityArgument:
    let node = AvailabilityArgumentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .availabilityLabeledArgument:
    let node = AvailabilityLabeledArgumentSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .availabilityVersionRestriction:
    let node = AvailabilityVersionRestrictionSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  case .versionTuple:
    let node = VersionTupleSyntax(data)
    let needsChildren = visitor.visit(node) == .visitChildren
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  }
}

fileprivate func visitChildren<Visitor>(
  _ data: SyntaxData, parent: _SyntaxBase, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor {
  for childRaw in PresentRawSyntaxChildren(data.absoluteRaw) {
    let childData = SyntaxData(childRaw, parent: parent)
    doVisit(childData, &visitor)
  }
}
