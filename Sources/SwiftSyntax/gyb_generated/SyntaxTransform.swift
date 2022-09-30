//// Automatically Generated From SyntaxTransform.swift.gyb.
//// Do Not Edit Directly!
//===------ SyntaxTransform.swift - Syntax Transform Visitor Protocol -----===//
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

public protocol SyntaxTransformVisitor {
  associatedtype ResultType = Void
  
  func visitAny(_ node: Syntax) -> ResultType
  
  func visit(_ token: TokenSyntax) -> ResultType
  func visit(_ node: UnknownSyntax) -> ResultType
  
  /// Visiting `UnknownDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownDeclSyntax) -> ResultType
  /// Visiting `UnknownExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownExprSyntax) -> ResultType
  /// Visiting `UnknownStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownStmtSyntax) -> ResultType
  /// Visiting `UnknownTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownTypeSyntax) -> ResultType
  /// Visiting `UnknownPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownPatternSyntax) -> ResultType
  /// Visiting `MissingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingSyntax) -> ResultType
  /// Visiting `MissingDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingDeclSyntax) -> ResultType
  /// Visiting `MissingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingExprSyntax) -> ResultType
  /// Visiting `MissingStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingStmtSyntax) -> ResultType
  /// Visiting `MissingTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingTypeSyntax) -> ResultType
  /// Visiting `MissingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingPatternSyntax) -> ResultType
  /// Visiting `CodeBlockItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CodeBlockItemSyntax) -> ResultType
  /// Visiting `CodeBlockItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CodeBlockItemListSyntax) -> ResultType
  /// Visiting `CodeBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CodeBlockSyntax) -> ResultType
  /// Visiting `UnexpectedNodesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnexpectedNodesSyntax) -> ResultType
  /// Visiting `InOutExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InOutExprSyntax) -> ResultType
  /// Visiting `PoundColumnExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundColumnExprSyntax) -> ResultType
  /// Visiting `TupleExprElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleExprElementListSyntax) -> ResultType
  /// Visiting `ArrayElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrayElementListSyntax) -> ResultType
  /// Visiting `DictionaryElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DictionaryElementListSyntax) -> ResultType
  /// Visiting `StringLiteralSegmentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: StringLiteralSegmentsSyntax) -> ResultType
  /// Visiting `TryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TryExprSyntax) -> ResultType
  /// Visiting `AwaitExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AwaitExprSyntax) -> ResultType
  /// Visiting `MoveExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MoveExprSyntax) -> ResultType
  /// Visiting `DeclNameArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclNameArgumentSyntax) -> ResultType
  /// Visiting `DeclNameArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclNameArgumentListSyntax) -> ResultType
  /// Visiting `DeclNameArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclNameArgumentsSyntax) -> ResultType
  /// Visiting `IdentifierExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IdentifierExprSyntax) -> ResultType
  /// Visiting `SuperRefExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SuperRefExprSyntax) -> ResultType
  /// Visiting `NilLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: NilLiteralExprSyntax) -> ResultType
  /// Visiting `DiscardAssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DiscardAssignmentExprSyntax) -> ResultType
  /// Visiting `AssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AssignmentExprSyntax) -> ResultType
  /// Visiting `SequenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SequenceExprSyntax) -> ResultType
  /// Visiting `ExprListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExprListSyntax) -> ResultType
  /// Visiting `PoundLineExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundLineExprSyntax) -> ResultType
  /// Visiting `PoundFileExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundFileExprSyntax) -> ResultType
  /// Visiting `PoundFileIDExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundFileIDExprSyntax) -> ResultType
  /// Visiting `PoundFilePathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundFilePathExprSyntax) -> ResultType
  /// Visiting `PoundFunctionExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundFunctionExprSyntax) -> ResultType
  /// Visiting `PoundDsohandleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundDsohandleExprSyntax) -> ResultType
  /// Visiting `SymbolicReferenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SymbolicReferenceExprSyntax) -> ResultType
  /// Visiting `PrefixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrefixOperatorExprSyntax) -> ResultType
  /// Visiting `BinaryOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BinaryOperatorExprSyntax) -> ResultType
  /// Visiting `ArrowExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrowExprSyntax) -> ResultType
  /// Visiting `InfixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InfixOperatorExprSyntax) -> ResultType
  /// Visiting `FloatLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FloatLiteralExprSyntax) -> ResultType
  /// Visiting `TupleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleExprSyntax) -> ResultType
  /// Visiting `ArrayExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrayExprSyntax) -> ResultType
  /// Visiting `DictionaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DictionaryExprSyntax) -> ResultType
  /// Visiting `TupleExprElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleExprElementSyntax) -> ResultType
  /// Visiting `ArrayElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrayElementSyntax) -> ResultType
  /// Visiting `DictionaryElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DictionaryElementSyntax) -> ResultType
  /// Visiting `IntegerLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IntegerLiteralExprSyntax) -> ResultType
  /// Visiting `BooleanLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BooleanLiteralExprSyntax) -> ResultType
  /// Visiting `UnresolvedTernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnresolvedTernaryExprSyntax) -> ResultType
  /// Visiting `TernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TernaryExprSyntax) -> ResultType
  /// Visiting `MemberAccessExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberAccessExprSyntax) -> ResultType
  /// Visiting `UnresolvedIsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnresolvedIsExprSyntax) -> ResultType
  /// Visiting `IsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IsExprSyntax) -> ResultType
  /// Visiting `UnresolvedAsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnresolvedAsExprSyntax) -> ResultType
  /// Visiting `AsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AsExprSyntax) -> ResultType
  /// Visiting `TypeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypeExprSyntax) -> ResultType
  /// Visiting `ClosureCaptureItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureCaptureItemSyntax) -> ResultType
  /// Visiting `ClosureCaptureItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureCaptureItemListSyntax) -> ResultType
  /// Visiting `ClosureCaptureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureCaptureSignatureSyntax) -> ResultType
  /// Visiting `ClosureParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureParamSyntax) -> ResultType
  /// Visiting `ClosureParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureParamListSyntax) -> ResultType
  /// Visiting `ClosureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureSignatureSyntax) -> ResultType
  /// Visiting `ClosureExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureExprSyntax) -> ResultType
  /// Visiting `UnresolvedPatternExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnresolvedPatternExprSyntax) -> ResultType
  /// Visiting `MultipleTrailingClosureElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MultipleTrailingClosureElementSyntax) -> ResultType
  /// Visiting `MultipleTrailingClosureElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MultipleTrailingClosureElementListSyntax) -> ResultType
  /// Visiting `FunctionCallExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionCallExprSyntax) -> ResultType
  /// Visiting `SubscriptExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SubscriptExprSyntax) -> ResultType
  /// Visiting `OptionalChainingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OptionalChainingExprSyntax) -> ResultType
  /// Visiting `ForcedValueExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ForcedValueExprSyntax) -> ResultType
  /// Visiting `PostfixUnaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PostfixUnaryExprSyntax) -> ResultType
  /// Visiting `SpecializeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SpecializeExprSyntax) -> ResultType
  /// Visiting `StringSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: StringSegmentSyntax) -> ResultType
  /// Visiting `ExpressionSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExpressionSegmentSyntax) -> ResultType
  /// Visiting `StringLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: StringLiteralExprSyntax) -> ResultType
  /// Visiting `RegexLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: RegexLiteralExprSyntax) -> ResultType
  /// Visiting `KeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathExprSyntax) -> ResultType
  /// Visiting `KeyPathComponentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathComponentListSyntax) -> ResultType
  /// Visiting `KeyPathComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathComponentSyntax) -> ResultType
  /// Visiting `KeyPathPropertyComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathPropertyComponentSyntax) -> ResultType
  /// Visiting `KeyPathSubscriptComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathSubscriptComponentSyntax) -> ResultType
  /// Visiting `KeyPathOptionalComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathOptionalComponentSyntax) -> ResultType
  /// Visiting `OldKeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OldKeyPathExprSyntax) -> ResultType
  /// Visiting `KeyPathBaseExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathBaseExprSyntax) -> ResultType
  /// Visiting `ObjcNamePieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjcNamePieceSyntax) -> ResultType
  /// Visiting `ObjcNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjcNameSyntax) -> ResultType
  /// Visiting `ObjcKeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjcKeyPathExprSyntax) -> ResultType
  /// Visiting `ObjcSelectorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjcSelectorExprSyntax) -> ResultType
  /// Visiting `PostfixIfConfigExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PostfixIfConfigExprSyntax) -> ResultType
  /// Visiting `EditorPlaceholderExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EditorPlaceholderExprSyntax) -> ResultType
  /// Visiting `ObjectLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjectLiteralExprSyntax) -> ResultType
  /// Visiting `YieldExprListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: YieldExprListSyntax) -> ResultType
  /// Visiting `YieldExprListElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: YieldExprListElementSyntax) -> ResultType
  /// Visiting `TypeInitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypeInitializerClauseSyntax) -> ResultType
  /// Visiting `TypealiasDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypealiasDeclSyntax) -> ResultType
  /// Visiting `AssociatedtypeDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AssociatedtypeDeclSyntax) -> ResultType
  /// Visiting `FunctionParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionParameterListSyntax) -> ResultType
  /// Visiting `ParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ParameterClauseSyntax) -> ResultType
  /// Visiting `ReturnClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ReturnClauseSyntax) -> ResultType
  /// Visiting `FunctionSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionSignatureSyntax) -> ResultType
  /// Visiting `IfConfigClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IfConfigClauseSyntax) -> ResultType
  /// Visiting `IfConfigClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IfConfigClauseListSyntax) -> ResultType
  /// Visiting `IfConfigDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IfConfigDeclSyntax) -> ResultType
  /// Visiting `PoundErrorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundErrorDeclSyntax) -> ResultType
  /// Visiting `PoundWarningDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundWarningDeclSyntax) -> ResultType
  /// Visiting `PoundSourceLocationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundSourceLocationSyntax) -> ResultType
  /// Visiting `PoundSourceLocationArgsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundSourceLocationArgsSyntax) -> ResultType
  /// Visiting `DeclModifierDetailSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclModifierDetailSyntax) -> ResultType
  /// Visiting `DeclModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclModifierSyntax) -> ResultType
  /// Visiting `InheritedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InheritedTypeSyntax) -> ResultType
  /// Visiting `InheritedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InheritedTypeListSyntax) -> ResultType
  /// Visiting `TypeInheritanceClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypeInheritanceClauseSyntax) -> ResultType
  /// Visiting `ClassDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClassDeclSyntax) -> ResultType
  /// Visiting `ActorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ActorDeclSyntax) -> ResultType
  /// Visiting `StructDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: StructDeclSyntax) -> ResultType
  /// Visiting `ProtocolDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ProtocolDeclSyntax) -> ResultType
  /// Visiting `ExtensionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExtensionDeclSyntax) -> ResultType
  /// Visiting `MemberDeclBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberDeclBlockSyntax) -> ResultType
  /// Visiting `MemberDeclListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberDeclListSyntax) -> ResultType
  /// Visiting `MemberDeclListItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberDeclListItemSyntax) -> ResultType
  /// Visiting `SourceFileSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SourceFileSyntax) -> ResultType
  /// Visiting `InitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InitializerClauseSyntax) -> ResultType
  /// Visiting `FunctionParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionParameterSyntax) -> ResultType
  /// Visiting `ModifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ModifierListSyntax) -> ResultType
  /// Visiting `FunctionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionDeclSyntax) -> ResultType
  /// Visiting `InitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InitializerDeclSyntax) -> ResultType
  /// Visiting `DeinitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeinitializerDeclSyntax) -> ResultType
  /// Visiting `SubscriptDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SubscriptDeclSyntax) -> ResultType
  /// Visiting `AccessLevelModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessLevelModifierSyntax) -> ResultType
  /// Visiting `AccessPathComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessPathComponentSyntax) -> ResultType
  /// Visiting `AccessPathSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessPathSyntax) -> ResultType
  /// Visiting `ImportDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ImportDeclSyntax) -> ResultType
  /// Visiting `AccessorParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessorParameterSyntax) -> ResultType
  /// Visiting `AccessorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessorDeclSyntax) -> ResultType
  /// Visiting `AccessorListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessorListSyntax) -> ResultType
  /// Visiting `AccessorBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessorBlockSyntax) -> ResultType
  /// Visiting `PatternBindingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PatternBindingSyntax) -> ResultType
  /// Visiting `PatternBindingListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PatternBindingListSyntax) -> ResultType
  /// Visiting `VariableDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: VariableDeclSyntax) -> ResultType
  /// Visiting `EnumCaseElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumCaseElementSyntax) -> ResultType
  /// Visiting `EnumCaseElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumCaseElementListSyntax) -> ResultType
  /// Visiting `EnumCaseDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumCaseDeclSyntax) -> ResultType
  /// Visiting `EnumDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumDeclSyntax) -> ResultType
  /// Visiting `OperatorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OperatorDeclSyntax) -> ResultType
  /// Visiting `DesignatedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DesignatedTypeListSyntax) -> ResultType
  /// Visiting `DesignatedTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DesignatedTypeElementSyntax) -> ResultType
  /// Visiting `OperatorPrecedenceAndTypesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> ResultType
  /// Visiting `PrecedenceGroupDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupDeclSyntax) -> ResultType
  /// Visiting `PrecedenceGroupAttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupAttributeListSyntax) -> ResultType
  /// Visiting `PrecedenceGroupRelationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupRelationSyntax) -> ResultType
  /// Visiting `PrecedenceGroupNameListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupNameListSyntax) -> ResultType
  /// Visiting `PrecedenceGroupNameElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupNameElementSyntax) -> ResultType
  /// Visiting `PrecedenceGroupAssignmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupAssignmentSyntax) -> ResultType
  /// Visiting `PrecedenceGroupAssociativitySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupAssociativitySyntax) -> ResultType
  /// Visiting `TokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TokenListSyntax) -> ResultType
  /// Visiting `NonEmptyTokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: NonEmptyTokenListSyntax) -> ResultType
  /// Visiting `CustomAttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CustomAttributeSyntax) -> ResultType
  /// Visiting `AttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AttributeSyntax) -> ResultType
  /// Visiting `AttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AttributeListSyntax) -> ResultType
  /// Visiting `SpecializeAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SpecializeAttributeSpecListSyntax) -> ResultType
  /// Visiting `AvailabilityEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityEntrySyntax) -> ResultType
  /// Visiting `LabeledSpecializeEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: LabeledSpecializeEntrySyntax) -> ResultType
  /// Visiting `TargetFunctionEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TargetFunctionEntrySyntax) -> ResultType
  /// Visiting `NamedAttributeStringArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: NamedAttributeStringArgumentSyntax) -> ResultType
  /// Visiting `DeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclNameSyntax) -> ResultType
  /// Visiting `ImplementsAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ImplementsAttributeArgumentsSyntax) -> ResultType
  /// Visiting `ObjCSelectorPieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjCSelectorPieceSyntax) -> ResultType
  /// Visiting `ObjCSelectorSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjCSelectorSyntax) -> ResultType
  /// Visiting `DifferentiableAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiableAttributeArgumentsSyntax) -> ResultType
  /// Visiting `DifferentiabilityParamsClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiabilityParamsClauseSyntax) -> ResultType
  /// Visiting `DifferentiabilityParamsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiabilityParamsSyntax) -> ResultType
  /// Visiting `DifferentiabilityParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiabilityParamListSyntax) -> ResultType
  /// Visiting `DifferentiabilityParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiabilityParamSyntax) -> ResultType
  /// Visiting `DerivativeRegistrationAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DerivativeRegistrationAttributeArgumentsSyntax) -> ResultType
  /// Visiting `QualifiedDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: QualifiedDeclNameSyntax) -> ResultType
  /// Visiting `FunctionDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionDeclNameSyntax) -> ResultType
  /// Visiting `BackDeployAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BackDeployAttributeSpecListSyntax) -> ResultType
  /// Visiting `BackDeployVersionListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BackDeployVersionListSyntax) -> ResultType
  /// Visiting `BackDeployVersionArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BackDeployVersionArgumentSyntax) -> ResultType
  /// Visiting `OpaqueReturnTypeOfAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OpaqueReturnTypeOfAttributeArgumentsSyntax) -> ResultType
  /// Visiting `ConventionAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConventionAttributeArgumentsSyntax) -> ResultType
  /// Visiting `ConventionWitnessMethodAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConventionWitnessMethodAttributeArgumentsSyntax) -> ResultType
  /// Visiting `LabeledStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: LabeledStmtSyntax) -> ResultType
  /// Visiting `ContinueStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ContinueStmtSyntax) -> ResultType
  /// Visiting `WhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: WhileStmtSyntax) -> ResultType
  /// Visiting `DeferStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeferStmtSyntax) -> ResultType
  /// Visiting `ExpressionStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExpressionStmtSyntax) -> ResultType
  /// Visiting `SwitchCaseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchCaseListSyntax) -> ResultType
  /// Visiting `RepeatWhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: RepeatWhileStmtSyntax) -> ResultType
  /// Visiting `GuardStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GuardStmtSyntax) -> ResultType
  /// Visiting `WhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: WhereClauseSyntax) -> ResultType
  /// Visiting `ForInStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ForInStmtSyntax) -> ResultType
  /// Visiting `SwitchStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchStmtSyntax) -> ResultType
  /// Visiting `CatchClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CatchClauseListSyntax) -> ResultType
  /// Visiting `DoStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DoStmtSyntax) -> ResultType
  /// Visiting `ReturnStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ReturnStmtSyntax) -> ResultType
  /// Visiting `YieldStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: YieldStmtSyntax) -> ResultType
  /// Visiting `YieldListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: YieldListSyntax) -> ResultType
  /// Visiting `FallthroughStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FallthroughStmtSyntax) -> ResultType
  /// Visiting `BreakStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BreakStmtSyntax) -> ResultType
  /// Visiting `CaseItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CaseItemListSyntax) -> ResultType
  /// Visiting `CatchItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CatchItemListSyntax) -> ResultType
  /// Visiting `ConditionElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConditionElementSyntax) -> ResultType
  /// Visiting `AvailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityConditionSyntax) -> ResultType
  /// Visiting `MatchingPatternConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MatchingPatternConditionSyntax) -> ResultType
  /// Visiting `OptionalBindingConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OptionalBindingConditionSyntax) -> ResultType
  /// Visiting `UnavailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnavailabilityConditionSyntax) -> ResultType
  /// Visiting `HasSymbolConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: HasSymbolConditionSyntax) -> ResultType
  /// Visiting `ConditionElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConditionElementListSyntax) -> ResultType
  /// Visiting `DeclarationStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclarationStmtSyntax) -> ResultType
  /// Visiting `ThrowStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ThrowStmtSyntax) -> ResultType
  /// Visiting `IfStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IfStmtSyntax) -> ResultType
  /// Visiting `ElseIfContinuationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ElseIfContinuationSyntax) -> ResultType
  /// Visiting `ElseBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ElseBlockSyntax) -> ResultType
  /// Visiting `SwitchCaseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchCaseSyntax) -> ResultType
  /// Visiting `SwitchDefaultLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchDefaultLabelSyntax) -> ResultType
  /// Visiting `CaseItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CaseItemSyntax) -> ResultType
  /// Visiting `CatchItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CatchItemSyntax) -> ResultType
  /// Visiting `SwitchCaseLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchCaseLabelSyntax) -> ResultType
  /// Visiting `CatchClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CatchClauseSyntax) -> ResultType
  /// Visiting `PoundAssertStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundAssertStmtSyntax) -> ResultType
  /// Visiting `GenericWhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericWhereClauseSyntax) -> ResultType
  /// Visiting `GenericRequirementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericRequirementListSyntax) -> ResultType
  /// Visiting `GenericRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericRequirementSyntax) -> ResultType
  /// Visiting `SameTypeRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SameTypeRequirementSyntax) -> ResultType
  /// Visiting `LayoutRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: LayoutRequirementSyntax) -> ResultType
  /// Visiting `GenericParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericParameterListSyntax) -> ResultType
  /// Visiting `GenericParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericParameterSyntax) -> ResultType
  /// Visiting `PrimaryAssociatedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrimaryAssociatedTypeListSyntax) -> ResultType
  /// Visiting `PrimaryAssociatedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrimaryAssociatedTypeSyntax) -> ResultType
  /// Visiting `GenericParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericParameterClauseSyntax) -> ResultType
  /// Visiting `ConformanceRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConformanceRequirementSyntax) -> ResultType
  /// Visiting `PrimaryAssociatedTypeClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrimaryAssociatedTypeClauseSyntax) -> ResultType
  /// Visiting `SimpleTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SimpleTypeIdentifierSyntax) -> ResultType
  /// Visiting `MemberTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberTypeIdentifierSyntax) -> ResultType
  /// Visiting `ClassRestrictionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClassRestrictionTypeSyntax) -> ResultType
  /// Visiting `ArrayTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrayTypeSyntax) -> ResultType
  /// Visiting `DictionaryTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DictionaryTypeSyntax) -> ResultType
  /// Visiting `MetatypeTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MetatypeTypeSyntax) -> ResultType
  /// Visiting `OptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OptionalTypeSyntax) -> ResultType
  /// Visiting `ConstrainedSugarTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConstrainedSugarTypeSyntax) -> ResultType
  /// Visiting `ImplicitlyUnwrappedOptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> ResultType
  /// Visiting `CompositionTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CompositionTypeElementSyntax) -> ResultType
  /// Visiting `CompositionTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CompositionTypeElementListSyntax) -> ResultType
  /// Visiting `CompositionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CompositionTypeSyntax) -> ResultType
  /// Visiting `PackExpansionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PackExpansionTypeSyntax) -> ResultType
  /// Visiting `TupleTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleTypeElementSyntax) -> ResultType
  /// Visiting `TupleTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleTypeElementListSyntax) -> ResultType
  /// Visiting `TupleTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleTypeSyntax) -> ResultType
  /// Visiting `FunctionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionTypeSyntax) -> ResultType
  /// Visiting `AttributedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AttributedTypeSyntax) -> ResultType
  /// Visiting `GenericArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericArgumentListSyntax) -> ResultType
  /// Visiting `GenericArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericArgumentSyntax) -> ResultType
  /// Visiting `GenericArgumentClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericArgumentClauseSyntax) -> ResultType
  /// Visiting `NamedOpaqueReturnTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: NamedOpaqueReturnTypeSyntax) -> ResultType
  /// Visiting `TypeAnnotationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypeAnnotationSyntax) -> ResultType
  /// Visiting `EnumCasePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumCasePatternSyntax) -> ResultType
  /// Visiting `IsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IsTypePatternSyntax) -> ResultType
  /// Visiting `OptionalPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OptionalPatternSyntax) -> ResultType
  /// Visiting `IdentifierPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IdentifierPatternSyntax) -> ResultType
  /// Visiting `AsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AsTypePatternSyntax) -> ResultType
  /// Visiting `TuplePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TuplePatternSyntax) -> ResultType
  /// Visiting `WildcardPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: WildcardPatternSyntax) -> ResultType
  /// Visiting `TuplePatternElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TuplePatternElementSyntax) -> ResultType
  /// Visiting `ExpressionPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExpressionPatternSyntax) -> ResultType
  /// Visiting `TuplePatternElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TuplePatternElementListSyntax) -> ResultType
  /// Visiting `ValueBindingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ValueBindingPatternSyntax) -> ResultType
  /// Visiting `AvailabilitySpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilitySpecListSyntax) -> ResultType
  /// Visiting `AvailabilityArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityArgumentSyntax) -> ResultType
  /// Visiting `AvailabilityLabeledArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityLabeledArgumentSyntax) -> ResultType
  /// Visiting `AvailabilityVersionRestrictionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityVersionRestrictionSyntax) -> ResultType
  /// Visiting `VersionTupleSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: VersionTupleSyntax) -> ResultType
}

extension SyntaxTransformVisitor {
  public func visit(_ token: TokenSyntax) -> ResultType {
    visitAny(Syntax(token))
  }

  public func visit(_ node: UnknownSyntax) -> ResultType {
    visitAny(Syntax(node))
  }

  /// Visiting `UnknownDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnknownExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnknownStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnknownTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnknownPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownPatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MissingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MissingDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MissingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MissingStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MissingTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MissingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingPatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CodeBlockItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CodeBlockItemSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CodeBlockItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CodeBlockItemListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CodeBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CodeBlockSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnexpectedNodesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnexpectedNodesSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `InOutExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InOutExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundColumnExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundColumnExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TupleExprElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleExprElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ArrayElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrayElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DictionaryElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DictionaryElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `StringLiteralSegmentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: StringLiteralSegmentsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TryExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AwaitExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AwaitExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MoveExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MoveExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeclNameArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclNameArgumentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeclNameArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclNameArgumentListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeclNameArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclNameArgumentsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IdentifierExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IdentifierExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SuperRefExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SuperRefExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `NilLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: NilLiteralExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DiscardAssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DiscardAssignmentExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AssignmentExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SequenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SequenceExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ExprListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExprListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundLineExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundLineExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundFileExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundFileExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundFileIDExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundFileIDExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundFilePathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundFilePathExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundFunctionExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundFunctionExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundDsohandleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundDsohandleExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SymbolicReferenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SymbolicReferenceExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrefixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrefixOperatorExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `BinaryOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BinaryOperatorExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ArrowExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrowExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `InfixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InfixOperatorExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FloatLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FloatLiteralExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TupleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ArrayExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrayExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DictionaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DictionaryExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TupleExprElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleExprElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ArrayElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrayElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DictionaryElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DictionaryElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IntegerLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IntegerLiteralExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `BooleanLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BooleanLiteralExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnresolvedTernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnresolvedTernaryExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TernaryExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MemberAccessExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberAccessExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnresolvedIsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnresolvedIsExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IsExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnresolvedAsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnresolvedAsExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AsExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TypeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypeExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClosureCaptureItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureCaptureItemSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClosureCaptureItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureCaptureItemListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClosureCaptureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureCaptureSignatureSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClosureParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureParamSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClosureParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureParamListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClosureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureSignatureSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClosureExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnresolvedPatternExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnresolvedPatternExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MultipleTrailingClosureElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MultipleTrailingClosureElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MultipleTrailingClosureElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MultipleTrailingClosureElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FunctionCallExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionCallExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SubscriptExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SubscriptExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `OptionalChainingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OptionalChainingExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ForcedValueExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ForcedValueExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PostfixUnaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PostfixUnaryExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SpecializeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SpecializeExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `StringSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: StringSegmentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ExpressionSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExpressionSegmentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `StringLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: StringLiteralExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `RegexLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: RegexLiteralExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `KeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `KeyPathComponentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathComponentListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `KeyPathComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathComponentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `KeyPathPropertyComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathPropertyComponentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `KeyPathSubscriptComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathSubscriptComponentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `KeyPathOptionalComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathOptionalComponentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `OldKeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OldKeyPathExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `KeyPathBaseExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathBaseExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ObjcNamePieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjcNamePieceSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ObjcNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjcNameSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ObjcKeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjcKeyPathExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ObjcSelectorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjcSelectorExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PostfixIfConfigExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PostfixIfConfigExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `EditorPlaceholderExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EditorPlaceholderExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ObjectLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjectLiteralExprSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `YieldExprListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: YieldExprListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `YieldExprListElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: YieldExprListElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TypeInitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypeInitializerClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TypealiasDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypealiasDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AssociatedtypeDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AssociatedtypeDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FunctionParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionParameterListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ParameterClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ReturnClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ReturnClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FunctionSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionSignatureSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IfConfigClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IfConfigClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IfConfigClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IfConfigClauseListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IfConfigDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IfConfigDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundErrorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundErrorDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundWarningDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundWarningDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundSourceLocationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundSourceLocationSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundSourceLocationArgsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundSourceLocationArgsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeclModifierDetailSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclModifierDetailSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeclModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclModifierSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `InheritedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InheritedTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `InheritedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InheritedTypeListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TypeInheritanceClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypeInheritanceClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClassDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClassDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ActorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ActorDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `StructDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: StructDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ProtocolDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ProtocolDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ExtensionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExtensionDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MemberDeclBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberDeclBlockSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MemberDeclListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberDeclListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MemberDeclListItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberDeclListItemSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SourceFileSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SourceFileSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `InitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InitializerClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FunctionParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionParameterSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ModifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ModifierListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FunctionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `InitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InitializerDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeinitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeinitializerDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SubscriptDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SubscriptDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AccessLevelModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessLevelModifierSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AccessPathComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessPathComponentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AccessPathSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessPathSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ImportDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ImportDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AccessorParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessorParameterSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AccessorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessorDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AccessorListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessorListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AccessorBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessorBlockSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PatternBindingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PatternBindingSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PatternBindingListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PatternBindingListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `VariableDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: VariableDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `EnumCaseElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumCaseElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `EnumCaseElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumCaseElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `EnumCaseDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumCaseDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `EnumDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `OperatorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OperatorDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DesignatedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DesignatedTypeListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DesignatedTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DesignatedTypeElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `OperatorPrecedenceAndTypesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrecedenceGroupDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupDeclSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrecedenceGroupAttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupAttributeListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrecedenceGroupRelationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupRelationSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrecedenceGroupNameListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupNameListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrecedenceGroupNameElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupNameElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrecedenceGroupAssignmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupAssignmentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrecedenceGroupAssociativitySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupAssociativitySyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TokenListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `NonEmptyTokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: NonEmptyTokenListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CustomAttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CustomAttributeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AttributeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AttributeListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SpecializeAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SpecializeAttributeSpecListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AvailabilityEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityEntrySyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `LabeledSpecializeEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: LabeledSpecializeEntrySyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TargetFunctionEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TargetFunctionEntrySyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `NamedAttributeStringArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: NamedAttributeStringArgumentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclNameSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ImplementsAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ImplementsAttributeArgumentsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ObjCSelectorPieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjCSelectorPieceSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ObjCSelectorSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjCSelectorSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DifferentiableAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiableAttributeArgumentsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DifferentiabilityParamsClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiabilityParamsClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DifferentiabilityParamsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiabilityParamsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DifferentiabilityParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiabilityParamListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DifferentiabilityParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiabilityParamSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DerivativeRegistrationAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DerivativeRegistrationAttributeArgumentsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `QualifiedDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: QualifiedDeclNameSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FunctionDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionDeclNameSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `BackDeployAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BackDeployAttributeSpecListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `BackDeployVersionListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BackDeployVersionListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `BackDeployVersionArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BackDeployVersionArgumentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `OpaqueReturnTypeOfAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OpaqueReturnTypeOfAttributeArgumentsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ConventionAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConventionAttributeArgumentsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ConventionWitnessMethodAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConventionWitnessMethodAttributeArgumentsSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `LabeledStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: LabeledStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ContinueStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ContinueStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `WhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: WhileStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeferStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeferStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ExpressionStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExpressionStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SwitchCaseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchCaseListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `RepeatWhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: RepeatWhileStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GuardStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GuardStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `WhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: WhereClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ForInStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ForInStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SwitchStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CatchClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CatchClauseListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DoStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DoStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ReturnStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ReturnStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `YieldStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: YieldStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `YieldListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: YieldListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FallthroughStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FallthroughStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `BreakStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BreakStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CaseItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CaseItemListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CatchItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CatchItemListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ConditionElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConditionElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AvailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityConditionSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MatchingPatternConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MatchingPatternConditionSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `OptionalBindingConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OptionalBindingConditionSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `UnavailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnavailabilityConditionSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `HasSymbolConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: HasSymbolConditionSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ConditionElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConditionElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DeclarationStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclarationStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ThrowStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ThrowStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IfStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IfStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ElseIfContinuationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ElseIfContinuationSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ElseBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ElseBlockSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SwitchCaseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchCaseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SwitchDefaultLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchDefaultLabelSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CaseItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CaseItemSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CatchItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CatchItemSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SwitchCaseLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchCaseLabelSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CatchClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CatchClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PoundAssertStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundAssertStmtSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericWhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericWhereClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericRequirementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericRequirementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericRequirementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SameTypeRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SameTypeRequirementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `LayoutRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: LayoutRequirementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericParameterListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericParameterSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrimaryAssociatedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrimaryAssociatedTypeListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrimaryAssociatedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrimaryAssociatedTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericParameterClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ConformanceRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConformanceRequirementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PrimaryAssociatedTypeClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrimaryAssociatedTypeClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `SimpleTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SimpleTypeIdentifierSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MemberTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberTypeIdentifierSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ClassRestrictionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClassRestrictionTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ArrayTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrayTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `DictionaryTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DictionaryTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `MetatypeTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MetatypeTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `OptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OptionalTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ConstrainedSugarTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConstrainedSugarTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ImplicitlyUnwrappedOptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CompositionTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CompositionTypeElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CompositionTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CompositionTypeElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `CompositionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CompositionTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `PackExpansionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PackExpansionTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TupleTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleTypeElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TupleTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleTypeElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TupleTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `FunctionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AttributedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AttributedTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericArgumentListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericArgumentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `GenericArgumentClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericArgumentClauseSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `NamedOpaqueReturnTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: NamedOpaqueReturnTypeSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TypeAnnotationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypeAnnotationSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `EnumCasePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumCasePatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IsTypePatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `OptionalPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OptionalPatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `IdentifierPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IdentifierPatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AsTypePatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TuplePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TuplePatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `WildcardPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: WildcardPatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TuplePatternElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TuplePatternElementSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ExpressionPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExpressionPatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `TuplePatternElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TuplePatternElementListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `ValueBindingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ValueBindingPatternSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AvailabilitySpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilitySpecListSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AvailabilityArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityArgumentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AvailabilityLabeledArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityLabeledArgumentSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `AvailabilityVersionRestrictionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityVersionRestrictionSyntax) -> ResultType {
    visitAny(Syntax(node))
  }
  /// Visiting `VersionTupleSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: VersionTupleSyntax) -> ResultType {
    visitAny(Syntax(node))
  }

  public func visit(_ node: Syntax) -> ResultType {
    switch node.as(SyntaxEnum.self) {
    case .token(let node):
      return visit(node)
    case .unknown(let node):
      return visit(node)
    case .unknownDecl(let derived):
      return visit(derived)
    case .unknownExpr(let derived):
      return visit(derived)
    case .unknownStmt(let derived):
      return visit(derived)
    case .unknownType(let derived):
      return visit(derived)
    case .unknownPattern(let derived):
      return visit(derived)
    case .missing(let derived):
      return visit(derived)
    case .missingDecl(let derived):
      return visit(derived)
    case .missingExpr(let derived):
      return visit(derived)
    case .missingStmt(let derived):
      return visit(derived)
    case .missingType(let derived):
      return visit(derived)
    case .missingPattern(let derived):
      return visit(derived)
    case .codeBlockItem(let derived):
      return visit(derived)
    case .codeBlockItemList(let derived):
      return visit(derived)
    case .codeBlock(let derived):
      return visit(derived)
    case .unexpectedNodes(let derived):
      return visit(derived)
    case .inOutExpr(let derived):
      return visit(derived)
    case .poundColumnExpr(let derived):
      return visit(derived)
    case .tupleExprElementList(let derived):
      return visit(derived)
    case .arrayElementList(let derived):
      return visit(derived)
    case .dictionaryElementList(let derived):
      return visit(derived)
    case .stringLiteralSegments(let derived):
      return visit(derived)
    case .tryExpr(let derived):
      return visit(derived)
    case .awaitExpr(let derived):
      return visit(derived)
    case .moveExpr(let derived):
      return visit(derived)
    case .declNameArgument(let derived):
      return visit(derived)
    case .declNameArgumentList(let derived):
      return visit(derived)
    case .declNameArguments(let derived):
      return visit(derived)
    case .identifierExpr(let derived):
      return visit(derived)
    case .superRefExpr(let derived):
      return visit(derived)
    case .nilLiteralExpr(let derived):
      return visit(derived)
    case .discardAssignmentExpr(let derived):
      return visit(derived)
    case .assignmentExpr(let derived):
      return visit(derived)
    case .sequenceExpr(let derived):
      return visit(derived)
    case .exprList(let derived):
      return visit(derived)
    case .poundLineExpr(let derived):
      return visit(derived)
    case .poundFileExpr(let derived):
      return visit(derived)
    case .poundFileIDExpr(let derived):
      return visit(derived)
    case .poundFilePathExpr(let derived):
      return visit(derived)
    case .poundFunctionExpr(let derived):
      return visit(derived)
    case .poundDsohandleExpr(let derived):
      return visit(derived)
    case .symbolicReferenceExpr(let derived):
      return visit(derived)
    case .prefixOperatorExpr(let derived):
      return visit(derived)
    case .binaryOperatorExpr(let derived):
      return visit(derived)
    case .arrowExpr(let derived):
      return visit(derived)
    case .infixOperatorExpr(let derived):
      return visit(derived)
    case .floatLiteralExpr(let derived):
      return visit(derived)
    case .tupleExpr(let derived):
      return visit(derived)
    case .arrayExpr(let derived):
      return visit(derived)
    case .dictionaryExpr(let derived):
      return visit(derived)
    case .tupleExprElement(let derived):
      return visit(derived)
    case .arrayElement(let derived):
      return visit(derived)
    case .dictionaryElement(let derived):
      return visit(derived)
    case .integerLiteralExpr(let derived):
      return visit(derived)
    case .booleanLiteralExpr(let derived):
      return visit(derived)
    case .unresolvedTernaryExpr(let derived):
      return visit(derived)
    case .ternaryExpr(let derived):
      return visit(derived)
    case .memberAccessExpr(let derived):
      return visit(derived)
    case .unresolvedIsExpr(let derived):
      return visit(derived)
    case .isExpr(let derived):
      return visit(derived)
    case .unresolvedAsExpr(let derived):
      return visit(derived)
    case .asExpr(let derived):
      return visit(derived)
    case .typeExpr(let derived):
      return visit(derived)
    case .closureCaptureItem(let derived):
      return visit(derived)
    case .closureCaptureItemList(let derived):
      return visit(derived)
    case .closureCaptureSignature(let derived):
      return visit(derived)
    case .closureParam(let derived):
      return visit(derived)
    case .closureParamList(let derived):
      return visit(derived)
    case .closureSignature(let derived):
      return visit(derived)
    case .closureExpr(let derived):
      return visit(derived)
    case .unresolvedPatternExpr(let derived):
      return visit(derived)
    case .multipleTrailingClosureElement(let derived):
      return visit(derived)
    case .multipleTrailingClosureElementList(let derived):
      return visit(derived)
    case .functionCallExpr(let derived):
      return visit(derived)
    case .subscriptExpr(let derived):
      return visit(derived)
    case .optionalChainingExpr(let derived):
      return visit(derived)
    case .forcedValueExpr(let derived):
      return visit(derived)
    case .postfixUnaryExpr(let derived):
      return visit(derived)
    case .specializeExpr(let derived):
      return visit(derived)
    case .stringSegment(let derived):
      return visit(derived)
    case .expressionSegment(let derived):
      return visit(derived)
    case .stringLiteralExpr(let derived):
      return visit(derived)
    case .regexLiteralExpr(let derived):
      return visit(derived)
    case .keyPathExpr(let derived):
      return visit(derived)
    case .keyPathComponentList(let derived):
      return visit(derived)
    case .keyPathComponent(let derived):
      return visit(derived)
    case .keyPathPropertyComponent(let derived):
      return visit(derived)
    case .keyPathSubscriptComponent(let derived):
      return visit(derived)
    case .keyPathOptionalComponent(let derived):
      return visit(derived)
    case .oldKeyPathExpr(let derived):
      return visit(derived)
    case .keyPathBaseExpr(let derived):
      return visit(derived)
    case .objcNamePiece(let derived):
      return visit(derived)
    case .objcName(let derived):
      return visit(derived)
    case .objcKeyPathExpr(let derived):
      return visit(derived)
    case .objcSelectorExpr(let derived):
      return visit(derived)
    case .postfixIfConfigExpr(let derived):
      return visit(derived)
    case .editorPlaceholderExpr(let derived):
      return visit(derived)
    case .objectLiteralExpr(let derived):
      return visit(derived)
    case .yieldExprList(let derived):
      return visit(derived)
    case .yieldExprListElement(let derived):
      return visit(derived)
    case .typeInitializerClause(let derived):
      return visit(derived)
    case .typealiasDecl(let derived):
      return visit(derived)
    case .associatedtypeDecl(let derived):
      return visit(derived)
    case .functionParameterList(let derived):
      return visit(derived)
    case .parameterClause(let derived):
      return visit(derived)
    case .returnClause(let derived):
      return visit(derived)
    case .functionSignature(let derived):
      return visit(derived)
    case .ifConfigClause(let derived):
      return visit(derived)
    case .ifConfigClauseList(let derived):
      return visit(derived)
    case .ifConfigDecl(let derived):
      return visit(derived)
    case .poundErrorDecl(let derived):
      return visit(derived)
    case .poundWarningDecl(let derived):
      return visit(derived)
    case .poundSourceLocation(let derived):
      return visit(derived)
    case .poundSourceLocationArgs(let derived):
      return visit(derived)
    case .declModifierDetail(let derived):
      return visit(derived)
    case .declModifier(let derived):
      return visit(derived)
    case .inheritedType(let derived):
      return visit(derived)
    case .inheritedTypeList(let derived):
      return visit(derived)
    case .typeInheritanceClause(let derived):
      return visit(derived)
    case .classDecl(let derived):
      return visit(derived)
    case .actorDecl(let derived):
      return visit(derived)
    case .structDecl(let derived):
      return visit(derived)
    case .protocolDecl(let derived):
      return visit(derived)
    case .extensionDecl(let derived):
      return visit(derived)
    case .memberDeclBlock(let derived):
      return visit(derived)
    case .memberDeclList(let derived):
      return visit(derived)
    case .memberDeclListItem(let derived):
      return visit(derived)
    case .sourceFile(let derived):
      return visit(derived)
    case .initializerClause(let derived):
      return visit(derived)
    case .functionParameter(let derived):
      return visit(derived)
    case .modifierList(let derived):
      return visit(derived)
    case .functionDecl(let derived):
      return visit(derived)
    case .initializerDecl(let derived):
      return visit(derived)
    case .deinitializerDecl(let derived):
      return visit(derived)
    case .subscriptDecl(let derived):
      return visit(derived)
    case .accessLevelModifier(let derived):
      return visit(derived)
    case .accessPathComponent(let derived):
      return visit(derived)
    case .accessPath(let derived):
      return visit(derived)
    case .importDecl(let derived):
      return visit(derived)
    case .accessorParameter(let derived):
      return visit(derived)
    case .accessorDecl(let derived):
      return visit(derived)
    case .accessorList(let derived):
      return visit(derived)
    case .accessorBlock(let derived):
      return visit(derived)
    case .patternBinding(let derived):
      return visit(derived)
    case .patternBindingList(let derived):
      return visit(derived)
    case .variableDecl(let derived):
      return visit(derived)
    case .enumCaseElement(let derived):
      return visit(derived)
    case .enumCaseElementList(let derived):
      return visit(derived)
    case .enumCaseDecl(let derived):
      return visit(derived)
    case .enumDecl(let derived):
      return visit(derived)
    case .operatorDecl(let derived):
      return visit(derived)
    case .designatedTypeList(let derived):
      return visit(derived)
    case .designatedTypeElement(let derived):
      return visit(derived)
    case .operatorPrecedenceAndTypes(let derived):
      return visit(derived)
    case .precedenceGroupDecl(let derived):
      return visit(derived)
    case .precedenceGroupAttributeList(let derived):
      return visit(derived)
    case .precedenceGroupRelation(let derived):
      return visit(derived)
    case .precedenceGroupNameList(let derived):
      return visit(derived)
    case .precedenceGroupNameElement(let derived):
      return visit(derived)
    case .precedenceGroupAssignment(let derived):
      return visit(derived)
    case .precedenceGroupAssociativity(let derived):
      return visit(derived)
    case .tokenList(let derived):
      return visit(derived)
    case .nonEmptyTokenList(let derived):
      return visit(derived)
    case .customAttribute(let derived):
      return visit(derived)
    case .attribute(let derived):
      return visit(derived)
    case .attributeList(let derived):
      return visit(derived)
    case .specializeAttributeSpecList(let derived):
      return visit(derived)
    case .availabilityEntry(let derived):
      return visit(derived)
    case .labeledSpecializeEntry(let derived):
      return visit(derived)
    case .targetFunctionEntry(let derived):
      return visit(derived)
    case .namedAttributeStringArgument(let derived):
      return visit(derived)
    case .declName(let derived):
      return visit(derived)
    case .implementsAttributeArguments(let derived):
      return visit(derived)
    case .objCSelectorPiece(let derived):
      return visit(derived)
    case .objCSelector(let derived):
      return visit(derived)
    case .differentiableAttributeArguments(let derived):
      return visit(derived)
    case .differentiabilityParamsClause(let derived):
      return visit(derived)
    case .differentiabilityParams(let derived):
      return visit(derived)
    case .differentiabilityParamList(let derived):
      return visit(derived)
    case .differentiabilityParam(let derived):
      return visit(derived)
    case .derivativeRegistrationAttributeArguments(let derived):
      return visit(derived)
    case .qualifiedDeclName(let derived):
      return visit(derived)
    case .functionDeclName(let derived):
      return visit(derived)
    case .backDeployAttributeSpecList(let derived):
      return visit(derived)
    case .backDeployVersionList(let derived):
      return visit(derived)
    case .backDeployVersionArgument(let derived):
      return visit(derived)
    case .opaqueReturnTypeOfAttributeArguments(let derived):
      return visit(derived)
    case .conventionAttributeArguments(let derived):
      return visit(derived)
    case .conventionWitnessMethodAttributeArguments(let derived):
      return visit(derived)
    case .labeledStmt(let derived):
      return visit(derived)
    case .continueStmt(let derived):
      return visit(derived)
    case .whileStmt(let derived):
      return visit(derived)
    case .deferStmt(let derived):
      return visit(derived)
    case .expressionStmt(let derived):
      return visit(derived)
    case .switchCaseList(let derived):
      return visit(derived)
    case .repeatWhileStmt(let derived):
      return visit(derived)
    case .guardStmt(let derived):
      return visit(derived)
    case .whereClause(let derived):
      return visit(derived)
    case .forInStmt(let derived):
      return visit(derived)
    case .switchStmt(let derived):
      return visit(derived)
    case .catchClauseList(let derived):
      return visit(derived)
    case .doStmt(let derived):
      return visit(derived)
    case .returnStmt(let derived):
      return visit(derived)
    case .yieldStmt(let derived):
      return visit(derived)
    case .yieldList(let derived):
      return visit(derived)
    case .fallthroughStmt(let derived):
      return visit(derived)
    case .breakStmt(let derived):
      return visit(derived)
    case .caseItemList(let derived):
      return visit(derived)
    case .catchItemList(let derived):
      return visit(derived)
    case .conditionElement(let derived):
      return visit(derived)
    case .availabilityCondition(let derived):
      return visit(derived)
    case .matchingPatternCondition(let derived):
      return visit(derived)
    case .optionalBindingCondition(let derived):
      return visit(derived)
    case .unavailabilityCondition(let derived):
      return visit(derived)
    case .hasSymbolCondition(let derived):
      return visit(derived)
    case .conditionElementList(let derived):
      return visit(derived)
    case .declarationStmt(let derived):
      return visit(derived)
    case .throwStmt(let derived):
      return visit(derived)
    case .ifStmt(let derived):
      return visit(derived)
    case .elseIfContinuation(let derived):
      return visit(derived)
    case .elseBlock(let derived):
      return visit(derived)
    case .switchCase(let derived):
      return visit(derived)
    case .switchDefaultLabel(let derived):
      return visit(derived)
    case .caseItem(let derived):
      return visit(derived)
    case .catchItem(let derived):
      return visit(derived)
    case .switchCaseLabel(let derived):
      return visit(derived)
    case .catchClause(let derived):
      return visit(derived)
    case .poundAssertStmt(let derived):
      return visit(derived)
    case .genericWhereClause(let derived):
      return visit(derived)
    case .genericRequirementList(let derived):
      return visit(derived)
    case .genericRequirement(let derived):
      return visit(derived)
    case .sameTypeRequirement(let derived):
      return visit(derived)
    case .layoutRequirement(let derived):
      return visit(derived)
    case .genericParameterList(let derived):
      return visit(derived)
    case .genericParameter(let derived):
      return visit(derived)
    case .primaryAssociatedTypeList(let derived):
      return visit(derived)
    case .primaryAssociatedType(let derived):
      return visit(derived)
    case .genericParameterClause(let derived):
      return visit(derived)
    case .conformanceRequirement(let derived):
      return visit(derived)
    case .primaryAssociatedTypeClause(let derived):
      return visit(derived)
    case .simpleTypeIdentifier(let derived):
      return visit(derived)
    case .memberTypeIdentifier(let derived):
      return visit(derived)
    case .classRestrictionType(let derived):
      return visit(derived)
    case .arrayType(let derived):
      return visit(derived)
    case .dictionaryType(let derived):
      return visit(derived)
    case .metatypeType(let derived):
      return visit(derived)
    case .optionalType(let derived):
      return visit(derived)
    case .constrainedSugarType(let derived):
      return visit(derived)
    case .implicitlyUnwrappedOptionalType(let derived):
      return visit(derived)
    case .compositionTypeElement(let derived):
      return visit(derived)
    case .compositionTypeElementList(let derived):
      return visit(derived)
    case .compositionType(let derived):
      return visit(derived)
    case .packExpansionType(let derived):
      return visit(derived)
    case .tupleTypeElement(let derived):
      return visit(derived)
    case .tupleTypeElementList(let derived):
      return visit(derived)
    case .tupleType(let derived):
      return visit(derived)
    case .functionType(let derived):
      return visit(derived)
    case .attributedType(let derived):
      return visit(derived)
    case .genericArgumentList(let derived):
      return visit(derived)
    case .genericArgument(let derived):
      return visit(derived)
    case .genericArgumentClause(let derived):
      return visit(derived)
    case .namedOpaqueReturnType(let derived):
      return visit(derived)
    case .typeAnnotation(let derived):
      return visit(derived)
    case .enumCasePattern(let derived):
      return visit(derived)
    case .isTypePattern(let derived):
      return visit(derived)
    case .optionalPattern(let derived):
      return visit(derived)
    case .identifierPattern(let derived):
      return visit(derived)
    case .asTypePattern(let derived):
      return visit(derived)
    case .tuplePattern(let derived):
      return visit(derived)
    case .wildcardPattern(let derived):
      return visit(derived)
    case .tuplePatternElement(let derived):
      return visit(derived)
    case .expressionPattern(let derived):
      return visit(derived)
    case .tuplePatternElementList(let derived):
      return visit(derived)
    case .valueBindingPattern(let derived):
      return visit(derived)
    case .availabilitySpecList(let derived):
      return visit(derived)
    case .availabilityArgument(let derived):
      return visit(derived)
    case .availabilityLabeledArgument(let derived):
      return visit(derived)
    case .availabilityVersionRestriction(let derived):
      return visit(derived)
    case .versionTuple(let derived):
      return visit(derived)
    }
  }
  
  public func visit(_ node: ExprSyntax) -> ResultType {
    visit(Syntax(node))
  }
  
  public func visit(_ node: PatternSyntax) -> ResultType {
    visit(Syntax(node))
  }
  
  public func visit(_ node: TypeSyntax) -> ResultType {
    visit(Syntax(node))
  }

  public func visitChildren<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) -> [ResultType] {
    let syntaxNode = Syntax(node)
    return NonNilRawSyntaxChildren(syntaxNode, viewMode: .sourceAccurate).map { rawChild in
      let child = Syntax(SyntaxData(rawChild, parent: syntaxNode))
      return visit(child)
    }
  }
}
