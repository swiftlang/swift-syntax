# ``SwiftSyntax``

@Comment {
  Automatically Generated From SwiftSyntax.md.gyb.
  Do Not Edit Directly!
}

A library for working with Swift code.

## Overview

SwiftSyntax is a source accurate tree representation of Swift source code. It 
allows Swift tools to parse, inspect, generate, and transform Swift source code.

## Topics

### Articles

- <doc:ChangingSwiftSyntax>

### Syntax

- <doc:SwiftSyntax/Syntax>
- <doc:SwiftSyntax/SyntaxCollection>

### Trivia

- <doc:SwiftSyntax/Trivia>
- <doc:SwiftSyntax/TriviaPiece>
- <doc:SwiftSyntax/TriviaPosition>

### Tokens

- <doc:SwiftSyntax/TokenSyntax>
- <doc:SwiftSyntax/TokenKind>
- <doc:SwiftSyntax/TokenSequence>
- <doc:SwiftSyntax/SourcePresence>

### Syntax Visitors

- <doc:SwiftSyntax/SyntaxVisitor>
- <doc:SwiftSyntax/SyntaxAnyVisitor>
- <doc:SwiftSyntax/SyntaxRewriter>
- <doc:SwiftSyntax/SyntaxVerifier>
- <doc:SwiftSyntax/SyntaxVerifierError>
- <doc:SwiftSyntax/SyntaxTreeViewMode>
- <doc:SwiftSyntax/SyntaxVisitorContinueKind>
- <doc:SwiftSyntax/ReversedTokenSequence>

### Declarations

- <doc:SwiftSyntax/DeclSyntax>
- <doc:SwiftSyntax/DeclSyntaxProtocol>
- <doc:SwiftSyntax/UnknownDeclSyntax>
- <doc:SwiftSyntax/TypealiasDeclSyntax>
- <doc:SwiftSyntax/AssociatedtypeDeclSyntax>
- <doc:SwiftSyntax/IfConfigDeclSyntax>
- <doc:SwiftSyntax/PoundErrorDeclSyntax>
- <doc:SwiftSyntax/PoundWarningDeclSyntax>
- <doc:SwiftSyntax/PoundSourceLocationSyntax>
- <doc:SwiftSyntax/ClassDeclSyntax>
- <doc:SwiftSyntax/ActorDeclSyntax>
- <doc:SwiftSyntax/StructDeclSyntax>
- <doc:SwiftSyntax/ProtocolDeclSyntax>
- <doc:SwiftSyntax/ExtensionDeclSyntax>
- <doc:SwiftSyntax/FunctionDeclSyntax>
- <doc:SwiftSyntax/InitializerDeclSyntax>
- <doc:SwiftSyntax/DeinitializerDeclSyntax>
- <doc:SwiftSyntax/SubscriptDeclSyntax>
- <doc:SwiftSyntax/ImportDeclSyntax>
- <doc:SwiftSyntax/AccessorDeclSyntax>
- <doc:SwiftSyntax/VariableDeclSyntax>
- <doc:SwiftSyntax/EnumCaseDeclSyntax>
- <doc:SwiftSyntax/EnumDeclSyntax>
- <doc:SwiftSyntax/OperatorDeclSyntax>
- <doc:SwiftSyntax/PrecedenceGroupDeclSyntax>

### Statements

- <doc:SwiftSyntax/StmtSyntax>
- <doc:SwiftSyntax/StmtSyntaxProtocol>
- <doc:SwiftSyntax/UnknownStmtSyntax>
- <doc:SwiftSyntax/LabeledStmtSyntax>
- <doc:SwiftSyntax/ContinueStmtSyntax>
- <doc:SwiftSyntax/WhileStmtSyntax>
- <doc:SwiftSyntax/DeferStmtSyntax>
- <doc:SwiftSyntax/ExpressionStmtSyntax>
- <doc:SwiftSyntax/RepeatWhileStmtSyntax>
- <doc:SwiftSyntax/GuardStmtSyntax>
- <doc:SwiftSyntax/ForInStmtSyntax>
- <doc:SwiftSyntax/SwitchStmtSyntax>
- <doc:SwiftSyntax/DoStmtSyntax>
- <doc:SwiftSyntax/ReturnStmtSyntax>
- <doc:SwiftSyntax/YieldStmtSyntax>
- <doc:SwiftSyntax/FallthroughStmtSyntax>
- <doc:SwiftSyntax/BreakStmtSyntax>
- <doc:SwiftSyntax/DeclarationStmtSyntax>
- <doc:SwiftSyntax/ThrowStmtSyntax>
- <doc:SwiftSyntax/IfStmtSyntax>
- <doc:SwiftSyntax/PoundAssertStmtSyntax>

### Expressions

- <doc:SwiftSyntax/ExprSyntax>
- <doc:SwiftSyntax/ExprSyntaxProtocol>
- <doc:SwiftSyntax/UnknownExprSyntax>
- <doc:SwiftSyntax/InOutExprSyntax>
- <doc:SwiftSyntax/PoundColumnExprSyntax>
- <doc:SwiftSyntax/TryExprSyntax>
- <doc:SwiftSyntax/AwaitExprSyntax>
- <doc:SwiftSyntax/MoveExprSyntax>
- <doc:SwiftSyntax/IdentifierExprSyntax>
- <doc:SwiftSyntax/SuperRefExprSyntax>
- <doc:SwiftSyntax/NilLiteralExprSyntax>
- <doc:SwiftSyntax/DiscardAssignmentExprSyntax>
- <doc:SwiftSyntax/AssignmentExprSyntax>
- <doc:SwiftSyntax/SequenceExprSyntax>
- <doc:SwiftSyntax/PoundLineExprSyntax>
- <doc:SwiftSyntax/PoundFileExprSyntax>
- <doc:SwiftSyntax/PoundFileIDExprSyntax>
- <doc:SwiftSyntax/PoundFilePathExprSyntax>
- <doc:SwiftSyntax/PoundFunctionExprSyntax>
- <doc:SwiftSyntax/PoundDsohandleExprSyntax>
- <doc:SwiftSyntax/SymbolicReferenceExprSyntax>
- <doc:SwiftSyntax/PrefixOperatorExprSyntax>
- <doc:SwiftSyntax/BinaryOperatorExprSyntax>
- <doc:SwiftSyntax/ArrowExprSyntax>
- <doc:SwiftSyntax/InfixOperatorExprSyntax>
- <doc:SwiftSyntax/FloatLiteralExprSyntax>
- <doc:SwiftSyntax/TupleExprSyntax>
- <doc:SwiftSyntax/ArrayExprSyntax>
- <doc:SwiftSyntax/DictionaryExprSyntax>
- <doc:SwiftSyntax/IntegerLiteralExprSyntax>
- <doc:SwiftSyntax/BooleanLiteralExprSyntax>
- <doc:SwiftSyntax/UnresolvedTernaryExprSyntax>
- <doc:SwiftSyntax/TernaryExprSyntax>
- <doc:SwiftSyntax/MemberAccessExprSyntax>
- <doc:SwiftSyntax/UnresolvedIsExprSyntax>
- <doc:SwiftSyntax/IsExprSyntax>
- <doc:SwiftSyntax/UnresolvedAsExprSyntax>
- <doc:SwiftSyntax/AsExprSyntax>
- <doc:SwiftSyntax/TypeExprSyntax>
- <doc:SwiftSyntax/ClosureExprSyntax>
- <doc:SwiftSyntax/UnresolvedPatternExprSyntax>
- <doc:SwiftSyntax/FunctionCallExprSyntax>
- <doc:SwiftSyntax/SubscriptExprSyntax>
- <doc:SwiftSyntax/OptionalChainingExprSyntax>
- <doc:SwiftSyntax/ForcedValueExprSyntax>
- <doc:SwiftSyntax/PostfixUnaryExprSyntax>
- <doc:SwiftSyntax/SpecializeExprSyntax>
- <doc:SwiftSyntax/StringLiteralExprSyntax>
- <doc:SwiftSyntax/RegexLiteralExprSyntax>
- <doc:SwiftSyntax/KeyPathExprSyntax>
- <doc:SwiftSyntax/OldKeyPathExprSyntax>
- <doc:SwiftSyntax/KeyPathBaseExprSyntax>
- <doc:SwiftSyntax/ObjcKeyPathExprSyntax>
- <doc:SwiftSyntax/ObjcSelectorExprSyntax>
- <doc:SwiftSyntax/PostfixIfConfigExprSyntax>
- <doc:SwiftSyntax/EditorPlaceholderExprSyntax>
- <doc:SwiftSyntax/ObjectLiteralExprSyntax>

### Types

- <doc:SwiftSyntax/TypeSyntax>
- <doc:SwiftSyntax/TypeSyntaxProtocol>
- <doc:SwiftSyntax/UnknownTypeSyntax>
- <doc:SwiftSyntax/SimpleTypeIdentifierSyntax>
- <doc:SwiftSyntax/MemberTypeIdentifierSyntax>
- <doc:SwiftSyntax/ClassRestrictionTypeSyntax>
- <doc:SwiftSyntax/ArrayTypeSyntax>
- <doc:SwiftSyntax/DictionaryTypeSyntax>
- <doc:SwiftSyntax/MetatypeTypeSyntax>
- <doc:SwiftSyntax/OptionalTypeSyntax>
- <doc:SwiftSyntax/ConstrainedSugarTypeSyntax>
- <doc:SwiftSyntax/ImplicitlyUnwrappedOptionalTypeSyntax>
- <doc:SwiftSyntax/CompositionTypeSyntax>
- <doc:SwiftSyntax/PackExpansionTypeSyntax>
- <doc:SwiftSyntax/TupleTypeSyntax>
- <doc:SwiftSyntax/FunctionTypeSyntax>
- <doc:SwiftSyntax/AttributedTypeSyntax>
- <doc:SwiftSyntax/NamedOpaqueReturnTypeSyntax>

### Patterns

- <doc:SwiftSyntax/PatternSyntax>
- <doc:SwiftSyntax/PatternSyntaxProtocol>
- <doc:SwiftSyntax/UnknownPatternSyntax>
- <doc:SwiftSyntax/EnumCasePatternSyntax>
- <doc:SwiftSyntax/IsTypePatternSyntax>
- <doc:SwiftSyntax/OptionalPatternSyntax>
- <doc:SwiftSyntax/IdentifierPatternSyntax>
- <doc:SwiftSyntax/AsTypePatternSyntax>
- <doc:SwiftSyntax/TuplePatternSyntax>
- <doc:SwiftSyntax/WildcardPatternSyntax>
- <doc:SwiftSyntax/ExpressionPatternSyntax>
- <doc:SwiftSyntax/ValueBindingPatternSyntax>

### Collections

- <doc:SwiftSyntax/SyntaxChildren>
- <doc:SwiftSyntax/CodeBlockItemListSyntax>
- <doc:SwiftSyntax/CodeBlockItemSyntax>
- <doc:SwiftSyntax/TupleExprElementListSyntax>
- <doc:SwiftSyntax/TupleExprElementSyntax>
- <doc:SwiftSyntax/ArrayElementListSyntax>
- <doc:SwiftSyntax/ArrayElementSyntax>
- <doc:SwiftSyntax/DictionaryElementListSyntax>
- <doc:SwiftSyntax/DictionaryElementSyntax>
- <doc:SwiftSyntax/DeclNameArgumentListSyntax>
- <doc:SwiftSyntax/DeclNameArgumentSyntax>
- <doc:SwiftSyntax/ExprListSyntax>
- <doc:SwiftSyntax/ExprSyntax>
- <doc:SwiftSyntax/ClosureCaptureItemListSyntax>
- <doc:SwiftSyntax/ClosureCaptureItemSyntax>
- <doc:SwiftSyntax/ClosureParamListSyntax>
- <doc:SwiftSyntax/ClosureParamSyntax>
- <doc:SwiftSyntax/MultipleTrailingClosureElementListSyntax>
- <doc:SwiftSyntax/MultipleTrailingClosureElementSyntax>
- <doc:SwiftSyntax/KeyPathComponentListSyntax>
- <doc:SwiftSyntax/KeyPathComponentSyntax>
- <doc:SwiftSyntax/ObjcNameSyntax>
- <doc:SwiftSyntax/ObjcNamePieceSyntax>
- <doc:SwiftSyntax/YieldExprListSyntax>
- <doc:SwiftSyntax/YieldExprListElementSyntax>
- <doc:SwiftSyntax/FunctionParameterListSyntax>
- <doc:SwiftSyntax/FunctionParameterSyntax>
- <doc:SwiftSyntax/IfConfigClauseListSyntax>
- <doc:SwiftSyntax/IfConfigClauseSyntax>
- <doc:SwiftSyntax/InheritedTypeListSyntax>
- <doc:SwiftSyntax/InheritedTypeSyntax>
- <doc:SwiftSyntax/MemberDeclListSyntax>
- <doc:SwiftSyntax/MemberDeclListItemSyntax>
- <doc:SwiftSyntax/ModifierListSyntax>
- <doc:SwiftSyntax/DeclModifierSyntax>
- <doc:SwiftSyntax/AccessPathSyntax>
- <doc:SwiftSyntax/AccessPathComponentSyntax>
- <doc:SwiftSyntax/AccessorListSyntax>
- <doc:SwiftSyntax/AccessorDeclSyntax>
- <doc:SwiftSyntax/PatternBindingListSyntax>
- <doc:SwiftSyntax/PatternBindingSyntax>
- <doc:SwiftSyntax/EnumCaseElementListSyntax>
- <doc:SwiftSyntax/EnumCaseElementSyntax>
- <doc:SwiftSyntax/DesignatedTypeListSyntax>
- <doc:SwiftSyntax/DesignatedTypeElementSyntax>
- <doc:SwiftSyntax/PrecedenceGroupNameListSyntax>
- <doc:SwiftSyntax/PrecedenceGroupNameElementSyntax>
- <doc:SwiftSyntax/ObjCSelectorSyntax>
- <doc:SwiftSyntax/ObjCSelectorPieceSyntax>
- <doc:SwiftSyntax/DifferentiabilityParamListSyntax>
- <doc:SwiftSyntax/DifferentiabilityParamSyntax>
- <doc:SwiftSyntax/BackDeployVersionListSyntax>
- <doc:SwiftSyntax/BackDeployVersionArgumentSyntax>
- <doc:SwiftSyntax/CatchClauseListSyntax>
- <doc:SwiftSyntax/CatchClauseSyntax>
- <doc:SwiftSyntax/CaseItemListSyntax>
- <doc:SwiftSyntax/CaseItemSyntax>
- <doc:SwiftSyntax/CatchItemListSyntax>
- <doc:SwiftSyntax/CatchItemSyntax>
- <doc:SwiftSyntax/ConditionElementListSyntax>
- <doc:SwiftSyntax/ConditionElementSyntax>
- <doc:SwiftSyntax/GenericRequirementListSyntax>
- <doc:SwiftSyntax/GenericRequirementSyntax>
- <doc:SwiftSyntax/GenericParameterListSyntax>
- <doc:SwiftSyntax/GenericParameterSyntax>
- <doc:SwiftSyntax/PrimaryAssociatedTypeListSyntax>
- <doc:SwiftSyntax/PrimaryAssociatedTypeSyntax>
- <doc:SwiftSyntax/CompositionTypeElementListSyntax>
- <doc:SwiftSyntax/CompositionTypeElementSyntax>
- <doc:SwiftSyntax/TupleTypeElementListSyntax>
- <doc:SwiftSyntax/TupleTypeElementSyntax>
- <doc:SwiftSyntax/GenericArgumentListSyntax>
- <doc:SwiftSyntax/GenericArgumentSyntax>
- <doc:SwiftSyntax/TuplePatternElementListSyntax>
- <doc:SwiftSyntax/TuplePatternElementSyntax>
- <doc:SwiftSyntax/AvailabilitySpecListSyntax>
- <doc:SwiftSyntax/AvailabilityArgumentSyntax>
- <doc:SwiftSyntax/SyntaxChildrenIndex>
- <doc:SwiftSyntax/SyntaxChildrenIndexData>

### Miscellaneous Syntax

- <doc:SwiftSyntax/CodeBlockItemSyntax>
- <doc:SwiftSyntax/CodeBlockItemListSyntax>
- <doc:SwiftSyntax/CodeBlockSyntax>
- <doc:SwiftSyntax/UnexpectedNodesSyntax>
- <doc:SwiftSyntax/TupleExprElementListSyntax>
- <doc:SwiftSyntax/ArrayElementListSyntax>
- <doc:SwiftSyntax/DictionaryElementListSyntax>
- <doc:SwiftSyntax/StringLiteralSegmentsSyntax>
- <doc:SwiftSyntax/DeclNameArgumentSyntax>
- <doc:SwiftSyntax/DeclNameArgumentListSyntax>
- <doc:SwiftSyntax/DeclNameArgumentsSyntax>
- <doc:SwiftSyntax/ExprListSyntax>
- <doc:SwiftSyntax/TupleExprElementSyntax>
- <doc:SwiftSyntax/ArrayElementSyntax>
- <doc:SwiftSyntax/DictionaryElementSyntax>
- <doc:SwiftSyntax/ClosureCaptureItemSyntax>
- <doc:SwiftSyntax/ClosureCaptureItemListSyntax>
- <doc:SwiftSyntax/ClosureCaptureSignatureSyntax>
- <doc:SwiftSyntax/ClosureParamSyntax>
- <doc:SwiftSyntax/ClosureParamListSyntax>
- <doc:SwiftSyntax/ClosureSignatureSyntax>
- <doc:SwiftSyntax/MultipleTrailingClosureElementSyntax>
- <doc:SwiftSyntax/MultipleTrailingClosureElementListSyntax>
- <doc:SwiftSyntax/StringSegmentSyntax>
- <doc:SwiftSyntax/ExpressionSegmentSyntax>
- <doc:SwiftSyntax/KeyPathComponentListSyntax>
- <doc:SwiftSyntax/KeyPathComponentSyntax>
- <doc:SwiftSyntax/KeyPathPropertyComponentSyntax>
- <doc:SwiftSyntax/KeyPathSubscriptComponentSyntax>
- <doc:SwiftSyntax/KeyPathOptionalComponentSyntax>
- <doc:SwiftSyntax/ObjcNamePieceSyntax>
- <doc:SwiftSyntax/ObjcNameSyntax>
- <doc:SwiftSyntax/YieldExprListSyntax>
- <doc:SwiftSyntax/YieldExprListElementSyntax>
- <doc:SwiftSyntax/TypeInitializerClauseSyntax>
- <doc:SwiftSyntax/FunctionParameterListSyntax>
- <doc:SwiftSyntax/ParameterClauseSyntax>
- <doc:SwiftSyntax/ReturnClauseSyntax>
- <doc:SwiftSyntax/FunctionSignatureSyntax>
- <doc:SwiftSyntax/IfConfigClauseSyntax>
- <doc:SwiftSyntax/IfConfigClauseListSyntax>
- <doc:SwiftSyntax/PoundSourceLocationArgsSyntax>
- <doc:SwiftSyntax/DeclModifierDetailSyntax>
- <doc:SwiftSyntax/DeclModifierSyntax>
- <doc:SwiftSyntax/InheritedTypeSyntax>
- <doc:SwiftSyntax/InheritedTypeListSyntax>
- <doc:SwiftSyntax/TypeInheritanceClauseSyntax>
- <doc:SwiftSyntax/MemberDeclBlockSyntax>
- <doc:SwiftSyntax/MemberDeclListSyntax>
- <doc:SwiftSyntax/MemberDeclListItemSyntax>
- <doc:SwiftSyntax/SourceFileSyntax>
- <doc:SwiftSyntax/InitializerClauseSyntax>
- <doc:SwiftSyntax/FunctionParameterSyntax>
- <doc:SwiftSyntax/ModifierListSyntax>
- <doc:SwiftSyntax/AccessLevelModifierSyntax>
- <doc:SwiftSyntax/AccessPathComponentSyntax>
- <doc:SwiftSyntax/AccessPathSyntax>
- <doc:SwiftSyntax/AccessorParameterSyntax>
- <doc:SwiftSyntax/AccessorListSyntax>
- <doc:SwiftSyntax/AccessorBlockSyntax>
- <doc:SwiftSyntax/PatternBindingSyntax>
- <doc:SwiftSyntax/PatternBindingListSyntax>
- <doc:SwiftSyntax/EnumCaseElementSyntax>
- <doc:SwiftSyntax/EnumCaseElementListSyntax>
- <doc:SwiftSyntax/DesignatedTypeListSyntax>
- <doc:SwiftSyntax/DesignatedTypeElementSyntax>
- <doc:SwiftSyntax/OperatorPrecedenceAndTypesSyntax>
- <doc:SwiftSyntax/PrecedenceGroupAttributeListSyntax>
- <doc:SwiftSyntax/PrecedenceGroupRelationSyntax>
- <doc:SwiftSyntax/PrecedenceGroupNameListSyntax>
- <doc:SwiftSyntax/PrecedenceGroupNameElementSyntax>
- <doc:SwiftSyntax/PrecedenceGroupAssignmentSyntax>
- <doc:SwiftSyntax/PrecedenceGroupAssociativitySyntax>
- <doc:SwiftSyntax/TokenListSyntax>
- <doc:SwiftSyntax/NonEmptyTokenListSyntax>
- <doc:SwiftSyntax/CustomAttributeSyntax>
- <doc:SwiftSyntax/AttributeSyntax>
- <doc:SwiftSyntax/AttributeListSyntax>
- <doc:SwiftSyntax/SpecializeAttributeSpecListSyntax>
- <doc:SwiftSyntax/AvailabilityEntrySyntax>
- <doc:SwiftSyntax/LabeledSpecializeEntrySyntax>
- <doc:SwiftSyntax/TargetFunctionEntrySyntax>
- <doc:SwiftSyntax/NamedAttributeStringArgumentSyntax>
- <doc:SwiftSyntax/DeclNameSyntax>
- <doc:SwiftSyntax/ImplementsAttributeArgumentsSyntax>
- <doc:SwiftSyntax/ObjCSelectorPieceSyntax>
- <doc:SwiftSyntax/ObjCSelectorSyntax>
- <doc:SwiftSyntax/DifferentiableAttributeArgumentsSyntax>
- <doc:SwiftSyntax/DifferentiabilityParamsClauseSyntax>
- <doc:SwiftSyntax/DifferentiabilityParamsSyntax>
- <doc:SwiftSyntax/DifferentiabilityParamListSyntax>
- <doc:SwiftSyntax/DifferentiabilityParamSyntax>
- <doc:SwiftSyntax/DerivativeRegistrationAttributeArgumentsSyntax>
- <doc:SwiftSyntax/QualifiedDeclNameSyntax>
- <doc:SwiftSyntax/FunctionDeclNameSyntax>
- <doc:SwiftSyntax/BackDeployAttributeSpecListSyntax>
- <doc:SwiftSyntax/BackDeployVersionListSyntax>
- <doc:SwiftSyntax/BackDeployVersionArgumentSyntax>
- <doc:SwiftSyntax/OpaqueReturnTypeOfAttributeArgumentsSyntax>
- <doc:SwiftSyntax/ConventionAttributeArgumentsSyntax>
- <doc:SwiftSyntax/ConventionWitnessMethodAttributeArgumentsSyntax>
- <doc:SwiftSyntax/SwitchCaseListSyntax>
- <doc:SwiftSyntax/WhereClauseSyntax>
- <doc:SwiftSyntax/CatchClauseListSyntax>
- <doc:SwiftSyntax/YieldListSyntax>
- <doc:SwiftSyntax/CaseItemListSyntax>
- <doc:SwiftSyntax/CatchItemListSyntax>
- <doc:SwiftSyntax/ConditionElementSyntax>
- <doc:SwiftSyntax/AvailabilityConditionSyntax>
- <doc:SwiftSyntax/MatchingPatternConditionSyntax>
- <doc:SwiftSyntax/OptionalBindingConditionSyntax>
- <doc:SwiftSyntax/UnavailabilityConditionSyntax>
- <doc:SwiftSyntax/HasSymbolConditionSyntax>
- <doc:SwiftSyntax/ConditionElementListSyntax>
- <doc:SwiftSyntax/ElseIfContinuationSyntax>
- <doc:SwiftSyntax/ElseBlockSyntax>
- <doc:SwiftSyntax/SwitchCaseSyntax>
- <doc:SwiftSyntax/SwitchDefaultLabelSyntax>
- <doc:SwiftSyntax/CaseItemSyntax>
- <doc:SwiftSyntax/CatchItemSyntax>
- <doc:SwiftSyntax/SwitchCaseLabelSyntax>
- <doc:SwiftSyntax/CatchClauseSyntax>
- <doc:SwiftSyntax/GenericWhereClauseSyntax>
- <doc:SwiftSyntax/GenericRequirementListSyntax>
- <doc:SwiftSyntax/GenericRequirementSyntax>
- <doc:SwiftSyntax/SameTypeRequirementSyntax>
- <doc:SwiftSyntax/LayoutRequirementSyntax>
- <doc:SwiftSyntax/GenericParameterListSyntax>
- <doc:SwiftSyntax/GenericParameterSyntax>
- <doc:SwiftSyntax/PrimaryAssociatedTypeListSyntax>
- <doc:SwiftSyntax/PrimaryAssociatedTypeSyntax>
- <doc:SwiftSyntax/GenericParameterClauseSyntax>
- <doc:SwiftSyntax/ConformanceRequirementSyntax>
- <doc:SwiftSyntax/PrimaryAssociatedTypeClauseSyntax>
- <doc:SwiftSyntax/CompositionTypeElementSyntax>
- <doc:SwiftSyntax/CompositionTypeElementListSyntax>
- <doc:SwiftSyntax/TupleTypeElementSyntax>
- <doc:SwiftSyntax/TupleTypeElementListSyntax>
- <doc:SwiftSyntax/GenericArgumentListSyntax>
- <doc:SwiftSyntax/GenericArgumentSyntax>
- <doc:SwiftSyntax/GenericArgumentClauseSyntax>
- <doc:SwiftSyntax/TypeAnnotationSyntax>
- <doc:SwiftSyntax/TuplePatternElementSyntax>
- <doc:SwiftSyntax/TuplePatternElementListSyntax>
- <doc:SwiftSyntax/AvailabilitySpecListSyntax>
- <doc:SwiftSyntax/AvailabilityArgumentSyntax>
- <doc:SwiftSyntax/AvailabilityLabeledArgumentSyntax>
- <doc:SwiftSyntax/AvailabilityVersionRestrictionSyntax>
- <doc:SwiftSyntax/VersionTupleSyntax>

### Missing and Unknown Syntax

- <doc:SwiftSyntax/MissingSyntax>
- <doc:SwiftSyntax/MissingDeclSyntax>
- <doc:SwiftSyntax/MissingExprSyntax>
- <doc:SwiftSyntax/MissingStmtSyntax>
- <doc:SwiftSyntax/MissingTypeSyntax>
- <doc:SwiftSyntax/MissingPatternSyntax>
- <doc:SwiftSyntax/UnknownSyntax>

### Traits

- <doc:SwiftSyntax/DeclGroupSyntax>
- <doc:SwiftSyntax/BracedSyntax>
- <doc:SwiftSyntax/IdentifiedDeclSyntax>
- <doc:SwiftSyntax/WithCodeBlockSyntax>
- <doc:SwiftSyntax/ParenthesizedSyntax>
- <doc:SwiftSyntax/WithTrailingCommaSyntax>
- <doc:SwiftSyntax/WithStatementsSyntax>

### Syntax Position

- <doc:SwiftSyntax/AbsolutePosition>
- <doc:SwiftSyntax/ByteSourceRange>
- <doc:SwiftSyntax/SourceLocation>
- <doc:SwiftSyntax/SourceLocationConverter>
- <doc:SwiftSyntax/SourceRange>
- <doc:SwiftSyntax/SourceLength>

### Classifying Syntax

- <doc:SwiftSyntax/SyntaxClassification>
- <doc:SwiftSyntax/SyntaxClassifications>
- <doc:SwiftSyntax/SyntaxClassifiedRange>

### Incremental Parsing

- <doc:SwiftSyntax/IncrementalParseLookup>
- <doc:SwiftSyntax/IncrementalParseTransition>
- <doc:SwiftSyntax/IncrementalParseReusedNodeDelegate>
- <doc:SwiftSyntax/IncrementalParseReusedNodeCollector>
- <doc:SwiftSyntax/SourceEdit>
- <doc:SwiftSyntax/ConcurrentEdits>

### Internals

- <doc:SwiftSyntax/SyntaxProtocol>
- <doc:SwiftSyntax/SyntaxArena>
- <doc:SwiftSyntax/SyntaxEnum>
- <doc:SwiftSyntax/SyntaxFactory>
- <doc:SwiftSyntax/SyntaxHashable>
- <doc:SwiftSyntax/SyntaxIdentifier>
- <doc:SwiftSyntax/RawTokenKind>
- <doc:SwiftSyntax/SyntaxNode>
