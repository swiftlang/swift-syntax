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
  /// Visiting `IdentifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IdentifierListSyntax) -> ResultType
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
  public func visit(_ token: TokenSyntax) -> ResultType { visitAny(Syntax(token)) }
  public func visit(_ node: UnknownSyntax) -> ResultType { visitAny(Syntax(node)) }

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
  /// Visiting `IdentifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IdentifierListSyntax) -> ResultType {
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

  public func visit(_ data: Syntax) -> ResultType {
    switch data.raw.kind {
    case .token:
      let node = TokenSyntax(data)!
      return visit(node)
    case .unknown:
      let node = UnknownSyntax(data)!
      return visit(node)
    // The implementation of every generated case goes into its own function. This
    // circumvents an issue where the compiler allocates stack space for every
    // case statement next to each other in debug builds, causing it to allocate
    // ~50KB per call to this function. rdar://55929175
    case .unknownDecl:
      let node = UnknownDeclSyntax(data)!
      return visit(node)
    case .unknownExpr:
      let node = UnknownExprSyntax(data)!
      return visit(node)
    case .unknownStmt:
      let node = UnknownStmtSyntax(data)!
      return visit(node)
    case .unknownType:
      let node = UnknownTypeSyntax(data)!
      return visit(node)
    case .unknownPattern:
      let node = UnknownPatternSyntax(data)!
      return visit(node)
    case .missing:
      let node = MissingSyntax(data)!
      return visit(node)
    case .missingDecl:
      let node = MissingDeclSyntax(data)!
      return visit(node)
    case .missingExpr:
      let node = MissingExprSyntax(data)!
      return visit(node)
    case .missingStmt:
      let node = MissingStmtSyntax(data)!
      return visit(node)
    case .missingType:
      let node = MissingTypeSyntax(data)!
      return visit(node)
    case .missingPattern:
      let node = MissingPatternSyntax(data)!
      return visit(node)
    case .codeBlockItem:
      let node = CodeBlockItemSyntax(data)!
      return visit(node)
    case .codeBlockItemList:
      let node = CodeBlockItemListSyntax(data)!
      return visit(node)
    case .codeBlock:
      let node = CodeBlockSyntax(data)!
      return visit(node)
    case .unexpectedNodes:
      let node = UnexpectedNodesSyntax(data)!
      return visit(node)
    case .inOutExpr:
      let node = InOutExprSyntax(data)!
      return visit(node)
    case .poundColumnExpr:
      let node = PoundColumnExprSyntax(data)!
      return visit(node)
    case .tupleExprElementList:
      let node = TupleExprElementListSyntax(data)!
      return visit(node)
    case .arrayElementList:
      let node = ArrayElementListSyntax(data)!
      return visit(node)
    case .dictionaryElementList:
      let node = DictionaryElementListSyntax(data)!
      return visit(node)
    case .stringLiteralSegments:
      let node = StringLiteralSegmentsSyntax(data)!
      return visit(node)
    case .tryExpr:
      let node = TryExprSyntax(data)!
      return visit(node)
    case .awaitExpr:
      let node = AwaitExprSyntax(data)!
      return visit(node)
    case .moveExpr:
      let node = MoveExprSyntax(data)!
      return visit(node)
    case .declNameArgument:
      let node = DeclNameArgumentSyntax(data)!
      return visit(node)
    case .declNameArgumentList:
      let node = DeclNameArgumentListSyntax(data)!
      return visit(node)
    case .declNameArguments:
      let node = DeclNameArgumentsSyntax(data)!
      return visit(node)
    case .identifierExpr:
      let node = IdentifierExprSyntax(data)!
      return visit(node)
    case .superRefExpr:
      let node = SuperRefExprSyntax(data)!
      return visit(node)
    case .nilLiteralExpr:
      let node = NilLiteralExprSyntax(data)!
      return visit(node)
    case .discardAssignmentExpr:
      let node = DiscardAssignmentExprSyntax(data)!
      return visit(node)
    case .assignmentExpr:
      let node = AssignmentExprSyntax(data)!
      return visit(node)
    case .sequenceExpr:
      let node = SequenceExprSyntax(data)!
      return visit(node)
    case .exprList:
      let node = ExprListSyntax(data)!
      return visit(node)
    case .poundLineExpr:
      let node = PoundLineExprSyntax(data)!
      return visit(node)
    case .poundFileExpr:
      let node = PoundFileExprSyntax(data)!
      return visit(node)
    case .poundFileIDExpr:
      let node = PoundFileIDExprSyntax(data)!
      return visit(node)
    case .poundFilePathExpr:
      let node = PoundFilePathExprSyntax(data)!
      return visit(node)
    case .poundFunctionExpr:
      let node = PoundFunctionExprSyntax(data)!
      return visit(node)
    case .poundDsohandleExpr:
      let node = PoundDsohandleExprSyntax(data)!
      return visit(node)
    case .symbolicReferenceExpr:
      let node = SymbolicReferenceExprSyntax(data)!
      return visit(node)
    case .prefixOperatorExpr:
      let node = PrefixOperatorExprSyntax(data)!
      return visit(node)
    case .binaryOperatorExpr:
      let node = BinaryOperatorExprSyntax(data)!
      return visit(node)
    case .arrowExpr:
      let node = ArrowExprSyntax(data)!
      return visit(node)
    case .infixOperatorExpr:
      let node = InfixOperatorExprSyntax(data)!
      return visit(node)
    case .floatLiteralExpr:
      let node = FloatLiteralExprSyntax(data)!
      return visit(node)
    case .tupleExpr:
      let node = TupleExprSyntax(data)!
      return visit(node)
    case .arrayExpr:
      let node = ArrayExprSyntax(data)!
      return visit(node)
    case .dictionaryExpr:
      let node = DictionaryExprSyntax(data)!
      return visit(node)
    case .tupleExprElement:
      let node = TupleExprElementSyntax(data)!
      return visit(node)
    case .arrayElement:
      let node = ArrayElementSyntax(data)!
      return visit(node)
    case .dictionaryElement:
      let node = DictionaryElementSyntax(data)!
      return visit(node)
    case .integerLiteralExpr:
      let node = IntegerLiteralExprSyntax(data)!
      return visit(node)
    case .booleanLiteralExpr:
      let node = BooleanLiteralExprSyntax(data)!
      return visit(node)
    case .unresolvedTernaryExpr:
      let node = UnresolvedTernaryExprSyntax(data)!
      return visit(node)
    case .ternaryExpr:
      let node = TernaryExprSyntax(data)!
      return visit(node)
    case .memberAccessExpr:
      let node = MemberAccessExprSyntax(data)!
      return visit(node)
    case .unresolvedIsExpr:
      let node = UnresolvedIsExprSyntax(data)!
      return visit(node)
    case .isExpr:
      let node = IsExprSyntax(data)!
      return visit(node)
    case .unresolvedAsExpr:
      let node = UnresolvedAsExprSyntax(data)!
      return visit(node)
    case .asExpr:
      let node = AsExprSyntax(data)!
      return visit(node)
    case .typeExpr:
      let node = TypeExprSyntax(data)!
      return visit(node)
    case .closureCaptureItem:
      let node = ClosureCaptureItemSyntax(data)!
      return visit(node)
    case .closureCaptureItemList:
      let node = ClosureCaptureItemListSyntax(data)!
      return visit(node)
    case .closureCaptureSignature:
      let node = ClosureCaptureSignatureSyntax(data)!
      return visit(node)
    case .closureParam:
      let node = ClosureParamSyntax(data)!
      return visit(node)
    case .closureParamList:
      let node = ClosureParamListSyntax(data)!
      return visit(node)
    case .closureSignature:
      let node = ClosureSignatureSyntax(data)!
      return visit(node)
    case .closureExpr:
      let node = ClosureExprSyntax(data)!
      return visit(node)
    case .unresolvedPatternExpr:
      let node = UnresolvedPatternExprSyntax(data)!
      return visit(node)
    case .multipleTrailingClosureElement:
      let node = MultipleTrailingClosureElementSyntax(data)!
      return visit(node)
    case .multipleTrailingClosureElementList:
      let node = MultipleTrailingClosureElementListSyntax(data)!
      return visit(node)
    case .functionCallExpr:
      let node = FunctionCallExprSyntax(data)!
      return visit(node)
    case .subscriptExpr:
      let node = SubscriptExprSyntax(data)!
      return visit(node)
    case .optionalChainingExpr:
      let node = OptionalChainingExprSyntax(data)!
      return visit(node)
    case .forcedValueExpr:
      let node = ForcedValueExprSyntax(data)!
      return visit(node)
    case .postfixUnaryExpr:
      let node = PostfixUnaryExprSyntax(data)!
      return visit(node)
    case .specializeExpr:
      let node = SpecializeExprSyntax(data)!
      return visit(node)
    case .stringSegment:
      let node = StringSegmentSyntax(data)!
      return visit(node)
    case .expressionSegment:
      let node = ExpressionSegmentSyntax(data)!
      return visit(node)
    case .stringLiteralExpr:
      let node = StringLiteralExprSyntax(data)!
      return visit(node)
    case .regexLiteralExpr:
      let node = RegexLiteralExprSyntax(data)!
      return visit(node)
    case .keyPathExpr:
      let node = KeyPathExprSyntax(data)!
      return visit(node)
    case .keyPathBaseExpr:
      let node = KeyPathBaseExprSyntax(data)!
      return visit(node)
    case .objcNamePiece:
      let node = ObjcNamePieceSyntax(data)!
      return visit(node)
    case .objcName:
      let node = ObjcNameSyntax(data)!
      return visit(node)
    case .objcKeyPathExpr:
      let node = ObjcKeyPathExprSyntax(data)!
      return visit(node)
    case .objcSelectorExpr:
      let node = ObjcSelectorExprSyntax(data)!
      return visit(node)
    case .postfixIfConfigExpr:
      let node = PostfixIfConfigExprSyntax(data)!
      return visit(node)
    case .editorPlaceholderExpr:
      let node = EditorPlaceholderExprSyntax(data)!
      return visit(node)
    case .objectLiteralExpr:
      let node = ObjectLiteralExprSyntax(data)!
      return visit(node)
    case .typeInitializerClause:
      let node = TypeInitializerClauseSyntax(data)!
      return visit(node)
    case .typealiasDecl:
      let node = TypealiasDeclSyntax(data)!
      return visit(node)
    case .associatedtypeDecl:
      let node = AssociatedtypeDeclSyntax(data)!
      return visit(node)
    case .functionParameterList:
      let node = FunctionParameterListSyntax(data)!
      return visit(node)
    case .parameterClause:
      let node = ParameterClauseSyntax(data)!
      return visit(node)
    case .returnClause:
      let node = ReturnClauseSyntax(data)!
      return visit(node)
    case .functionSignature:
      let node = FunctionSignatureSyntax(data)!
      return visit(node)
    case .ifConfigClause:
      let node = IfConfigClauseSyntax(data)!
      return visit(node)
    case .ifConfigClauseList:
      let node = IfConfigClauseListSyntax(data)!
      return visit(node)
    case .ifConfigDecl:
      let node = IfConfigDeclSyntax(data)!
      return visit(node)
    case .poundErrorDecl:
      let node = PoundErrorDeclSyntax(data)!
      return visit(node)
    case .poundWarningDecl:
      let node = PoundWarningDeclSyntax(data)!
      return visit(node)
    case .poundSourceLocation:
      let node = PoundSourceLocationSyntax(data)!
      return visit(node)
    case .poundSourceLocationArgs:
      let node = PoundSourceLocationArgsSyntax(data)!
      return visit(node)
    case .declModifierDetail:
      let node = DeclModifierDetailSyntax(data)!
      return visit(node)
    case .declModifier:
      let node = DeclModifierSyntax(data)!
      return visit(node)
    case .inheritedType:
      let node = InheritedTypeSyntax(data)!
      return visit(node)
    case .inheritedTypeList:
      let node = InheritedTypeListSyntax(data)!
      return visit(node)
    case .typeInheritanceClause:
      let node = TypeInheritanceClauseSyntax(data)!
      return visit(node)
    case .classDecl:
      let node = ClassDeclSyntax(data)!
      return visit(node)
    case .actorDecl:
      let node = ActorDeclSyntax(data)!
      return visit(node)
    case .structDecl:
      let node = StructDeclSyntax(data)!
      return visit(node)
    case .protocolDecl:
      let node = ProtocolDeclSyntax(data)!
      return visit(node)
    case .extensionDecl:
      let node = ExtensionDeclSyntax(data)!
      return visit(node)
    case .memberDeclBlock:
      let node = MemberDeclBlockSyntax(data)!
      return visit(node)
    case .memberDeclList:
      let node = MemberDeclListSyntax(data)!
      return visit(node)
    case .memberDeclListItem:
      let node = MemberDeclListItemSyntax(data)!
      return visit(node)
    case .sourceFile:
      let node = SourceFileSyntax(data)!
      return visit(node)
    case .initializerClause:
      let node = InitializerClauseSyntax(data)!
      return visit(node)
    case .functionParameter:
      let node = FunctionParameterSyntax(data)!
      return visit(node)
    case .modifierList:
      let node = ModifierListSyntax(data)!
      return visit(node)
    case .functionDecl:
      let node = FunctionDeclSyntax(data)!
      return visit(node)
    case .initializerDecl:
      let node = InitializerDeclSyntax(data)!
      return visit(node)
    case .deinitializerDecl:
      let node = DeinitializerDeclSyntax(data)!
      return visit(node)
    case .subscriptDecl:
      let node = SubscriptDeclSyntax(data)!
      return visit(node)
    case .accessLevelModifier:
      let node = AccessLevelModifierSyntax(data)!
      return visit(node)
    case .accessPathComponent:
      let node = AccessPathComponentSyntax(data)!
      return visit(node)
    case .accessPath:
      let node = AccessPathSyntax(data)!
      return visit(node)
    case .importDecl:
      let node = ImportDeclSyntax(data)!
      return visit(node)
    case .accessorParameter:
      let node = AccessorParameterSyntax(data)!
      return visit(node)
    case .accessorDecl:
      let node = AccessorDeclSyntax(data)!
      return visit(node)
    case .accessorList:
      let node = AccessorListSyntax(data)!
      return visit(node)
    case .accessorBlock:
      let node = AccessorBlockSyntax(data)!
      return visit(node)
    case .patternBinding:
      let node = PatternBindingSyntax(data)!
      return visit(node)
    case .patternBindingList:
      let node = PatternBindingListSyntax(data)!
      return visit(node)
    case .variableDecl:
      let node = VariableDeclSyntax(data)!
      return visit(node)
    case .enumCaseElement:
      let node = EnumCaseElementSyntax(data)!
      return visit(node)
    case .enumCaseElementList:
      let node = EnumCaseElementListSyntax(data)!
      return visit(node)
    case .enumCaseDecl:
      let node = EnumCaseDeclSyntax(data)!
      return visit(node)
    case .enumDecl:
      let node = EnumDeclSyntax(data)!
      return visit(node)
    case .operatorDecl:
      let node = OperatorDeclSyntax(data)!
      return visit(node)
    case .identifierList:
      let node = IdentifierListSyntax(data)!
      return visit(node)
    case .operatorPrecedenceAndTypes:
      let node = OperatorPrecedenceAndTypesSyntax(data)!
      return visit(node)
    case .precedenceGroupDecl:
      let node = PrecedenceGroupDeclSyntax(data)!
      return visit(node)
    case .precedenceGroupAttributeList:
      let node = PrecedenceGroupAttributeListSyntax(data)!
      return visit(node)
    case .precedenceGroupRelation:
      let node = PrecedenceGroupRelationSyntax(data)!
      return visit(node)
    case .precedenceGroupNameList:
      let node = PrecedenceGroupNameListSyntax(data)!
      return visit(node)
    case .precedenceGroupNameElement:
      let node = PrecedenceGroupNameElementSyntax(data)!
      return visit(node)
    case .precedenceGroupAssignment:
      let node = PrecedenceGroupAssignmentSyntax(data)!
      return visit(node)
    case .precedenceGroupAssociativity:
      let node = PrecedenceGroupAssociativitySyntax(data)!
      return visit(node)
    case .tokenList:
      let node = TokenListSyntax(data)!
      return visit(node)
    case .nonEmptyTokenList:
      let node = NonEmptyTokenListSyntax(data)!
      return visit(node)
    case .customAttribute:
      let node = CustomAttributeSyntax(data)!
      return visit(node)
    case .attribute:
      let node = AttributeSyntax(data)!
      return visit(node)
    case .attributeList:
      let node = AttributeListSyntax(data)!
      return visit(node)
    case .specializeAttributeSpecList:
      let node = SpecializeAttributeSpecListSyntax(data)!
      return visit(node)
    case .availabilityEntry:
      let node = AvailabilityEntrySyntax(data)!
      return visit(node)
    case .labeledSpecializeEntry:
      let node = LabeledSpecializeEntrySyntax(data)!
      return visit(node)
    case .targetFunctionEntry:
      let node = TargetFunctionEntrySyntax(data)!
      return visit(node)
    case .namedAttributeStringArgument:
      let node = NamedAttributeStringArgumentSyntax(data)!
      return visit(node)
    case .declName:
      let node = DeclNameSyntax(data)!
      return visit(node)
    case .implementsAttributeArguments:
      let node = ImplementsAttributeArgumentsSyntax(data)!
      return visit(node)
    case .objCSelectorPiece:
      let node = ObjCSelectorPieceSyntax(data)!
      return visit(node)
    case .objCSelector:
      let node = ObjCSelectorSyntax(data)!
      return visit(node)
    case .differentiableAttributeArguments:
      let node = DifferentiableAttributeArgumentsSyntax(data)!
      return visit(node)
    case .differentiabilityParamsClause:
      let node = DifferentiabilityParamsClauseSyntax(data)!
      return visit(node)
    case .differentiabilityParams:
      let node = DifferentiabilityParamsSyntax(data)!
      return visit(node)
    case .differentiabilityParamList:
      let node = DifferentiabilityParamListSyntax(data)!
      return visit(node)
    case .differentiabilityParam:
      let node = DifferentiabilityParamSyntax(data)!
      return visit(node)
    case .derivativeRegistrationAttributeArguments:
      let node = DerivativeRegistrationAttributeArgumentsSyntax(data)!
      return visit(node)
    case .qualifiedDeclName:
      let node = QualifiedDeclNameSyntax(data)!
      return visit(node)
    case .functionDeclName:
      let node = FunctionDeclNameSyntax(data)!
      return visit(node)
    case .backDeployAttributeSpecList:
      let node = BackDeployAttributeSpecListSyntax(data)!
      return visit(node)
    case .backDeployVersionList:
      let node = BackDeployVersionListSyntax(data)!
      return visit(node)
    case .backDeployVersionArgument:
      let node = BackDeployVersionArgumentSyntax(data)!
      return visit(node)
    case .labeledStmt:
      let node = LabeledStmtSyntax(data)!
      return visit(node)
    case .continueStmt:
      let node = ContinueStmtSyntax(data)!
      return visit(node)
    case .whileStmt:
      let node = WhileStmtSyntax(data)!
      return visit(node)
    case .deferStmt:
      let node = DeferStmtSyntax(data)!
      return visit(node)
    case .expressionStmt:
      let node = ExpressionStmtSyntax(data)!
      return visit(node)
    case .switchCaseList:
      let node = SwitchCaseListSyntax(data)!
      return visit(node)
    case .repeatWhileStmt:
      let node = RepeatWhileStmtSyntax(data)!
      return visit(node)
    case .guardStmt:
      let node = GuardStmtSyntax(data)!
      return visit(node)
    case .whereClause:
      let node = WhereClauseSyntax(data)!
      return visit(node)
    case .forInStmt:
      let node = ForInStmtSyntax(data)!
      return visit(node)
    case .switchStmt:
      let node = SwitchStmtSyntax(data)!
      return visit(node)
    case .catchClauseList:
      let node = CatchClauseListSyntax(data)!
      return visit(node)
    case .doStmt:
      let node = DoStmtSyntax(data)!
      return visit(node)
    case .returnStmt:
      let node = ReturnStmtSyntax(data)!
      return visit(node)
    case .yieldStmt:
      let node = YieldStmtSyntax(data)!
      return visit(node)
    case .yieldList:
      let node = YieldListSyntax(data)!
      return visit(node)
    case .fallthroughStmt:
      let node = FallthroughStmtSyntax(data)!
      return visit(node)
    case .breakStmt:
      let node = BreakStmtSyntax(data)!
      return visit(node)
    case .caseItemList:
      let node = CaseItemListSyntax(data)!
      return visit(node)
    case .catchItemList:
      let node = CatchItemListSyntax(data)!
      return visit(node)
    case .conditionElement:
      let node = ConditionElementSyntax(data)!
      return visit(node)
    case .availabilityCondition:
      let node = AvailabilityConditionSyntax(data)!
      return visit(node)
    case .matchingPatternCondition:
      let node = MatchingPatternConditionSyntax(data)!
      return visit(node)
    case .optionalBindingCondition:
      let node = OptionalBindingConditionSyntax(data)!
      return visit(node)
    case .unavailabilityCondition:
      let node = UnavailabilityConditionSyntax(data)!
      return visit(node)
    case .conditionElementList:
      let node = ConditionElementListSyntax(data)!
      return visit(node)
    case .declarationStmt:
      let node = DeclarationStmtSyntax(data)!
      return visit(node)
    case .throwStmt:
      let node = ThrowStmtSyntax(data)!
      return visit(node)
    case .ifStmt:
      let node = IfStmtSyntax(data)!
      return visit(node)
    case .elseIfContinuation:
      let node = ElseIfContinuationSyntax(data)!
      return visit(node)
    case .elseBlock:
      let node = ElseBlockSyntax(data)!
      return visit(node)
    case .switchCase:
      let node = SwitchCaseSyntax(data)!
      return visit(node)
    case .switchDefaultLabel:
      let node = SwitchDefaultLabelSyntax(data)!
      return visit(node)
    case .caseItem:
      let node = CaseItemSyntax(data)!
      return visit(node)
    case .catchItem:
      let node = CatchItemSyntax(data)!
      return visit(node)
    case .switchCaseLabel:
      let node = SwitchCaseLabelSyntax(data)!
      return visit(node)
    case .catchClause:
      let node = CatchClauseSyntax(data)!
      return visit(node)
    case .poundAssertStmt:
      let node = PoundAssertStmtSyntax(data)!
      return visit(node)
    case .genericWhereClause:
      let node = GenericWhereClauseSyntax(data)!
      return visit(node)
    case .genericRequirementList:
      let node = GenericRequirementListSyntax(data)!
      return visit(node)
    case .genericRequirement:
      let node = GenericRequirementSyntax(data)!
      return visit(node)
    case .sameTypeRequirement:
      let node = SameTypeRequirementSyntax(data)!
      return visit(node)
    case .layoutRequirement:
      let node = LayoutRequirementSyntax(data)!
      return visit(node)
    case .genericParameterList:
      let node = GenericParameterListSyntax(data)!
      return visit(node)
    case .genericParameter:
      let node = GenericParameterSyntax(data)!
      return visit(node)
    case .primaryAssociatedTypeList:
      let node = PrimaryAssociatedTypeListSyntax(data)!
      return visit(node)
    case .primaryAssociatedType:
      let node = PrimaryAssociatedTypeSyntax(data)!
      return visit(node)
    case .genericParameterClause:
      let node = GenericParameterClauseSyntax(data)!
      return visit(node)
    case .conformanceRequirement:
      let node = ConformanceRequirementSyntax(data)!
      return visit(node)
    case .primaryAssociatedTypeClause:
      let node = PrimaryAssociatedTypeClauseSyntax(data)!
      return visit(node)
    case .simpleTypeIdentifier:
      let node = SimpleTypeIdentifierSyntax(data)!
      return visit(node)
    case .memberTypeIdentifier:
      let node = MemberTypeIdentifierSyntax(data)!
      return visit(node)
    case .classRestrictionType:
      let node = ClassRestrictionTypeSyntax(data)!
      return visit(node)
    case .arrayType:
      let node = ArrayTypeSyntax(data)!
      return visit(node)
    case .dictionaryType:
      let node = DictionaryTypeSyntax(data)!
      return visit(node)
    case .metatypeType:
      let node = MetatypeTypeSyntax(data)!
      return visit(node)
    case .optionalType:
      let node = OptionalTypeSyntax(data)!
      return visit(node)
    case .constrainedSugarType:
      let node = ConstrainedSugarTypeSyntax(data)!
      return visit(node)
    case .implicitlyUnwrappedOptionalType:
      let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)!
      return visit(node)
    case .compositionTypeElement:
      let node = CompositionTypeElementSyntax(data)!
      return visit(node)
    case .compositionTypeElementList:
      let node = CompositionTypeElementListSyntax(data)!
      return visit(node)
    case .compositionType:
      let node = CompositionTypeSyntax(data)!
      return visit(node)
    case .tupleTypeElement:
      let node = TupleTypeElementSyntax(data)!
      return visit(node)
    case .tupleTypeElementList:
      let node = TupleTypeElementListSyntax(data)!
      return visit(node)
    case .tupleType:
      let node = TupleTypeSyntax(data)!
      return visit(node)
    case .functionType:
      let node = FunctionTypeSyntax(data)!
      return visit(node)
    case .attributedType:
      let node = AttributedTypeSyntax(data)!
      return visit(node)
    case .genericArgumentList:
      let node = GenericArgumentListSyntax(data)!
      return visit(node)
    case .genericArgument:
      let node = GenericArgumentSyntax(data)!
      return visit(node)
    case .genericArgumentClause:
      let node = GenericArgumentClauseSyntax(data)!
      return visit(node)
    case .typeAnnotation:
      let node = TypeAnnotationSyntax(data)!
      return visit(node)
    case .enumCasePattern:
      let node = EnumCasePatternSyntax(data)!
      return visit(node)
    case .isTypePattern:
      let node = IsTypePatternSyntax(data)!
      return visit(node)
    case .optionalPattern:
      let node = OptionalPatternSyntax(data)!
      return visit(node)
    case .identifierPattern:
      let node = IdentifierPatternSyntax(data)!
      return visit(node)
    case .asTypePattern:
      let node = AsTypePatternSyntax(data)!
      return visit(node)
    case .tuplePattern:
      let node = TuplePatternSyntax(data)!
      return visit(node)
    case .wildcardPattern:
      let node = WildcardPatternSyntax(data)!
      return visit(node)
    case .tuplePatternElement:
      let node = TuplePatternElementSyntax(data)!
      return visit(node)
    case .expressionPattern:
      let node = ExpressionPatternSyntax(data)!
      return visit(node)
    case .tuplePatternElementList:
      let node = TuplePatternElementListSyntax(data)!
      return visit(node)
    case .valueBindingPattern:
      let node = ValueBindingPatternSyntax(data)!
      return visit(node)
    case .availabilitySpecList:
      let node = AvailabilitySpecListSyntax(data)!
      return visit(node)
    case .availabilityArgument:
      let node = AvailabilityArgumentSyntax(data)!
      return visit(node)
    case .availabilityLabeledArgument:
      let node = AvailabilityLabeledArgumentSyntax(data)!
      return visit(node)
    case .availabilityVersionRestriction:
      let node = AvailabilityVersionRestrictionSyntax(data)!
      return visit(node)
    case .versionTuple:
      let node = VersionTupleSyntax(data)!
      return visit(node)
    }
  }
  
  public func visit(_ data: ExprSyntax) -> ResultType {
    switch data.raw.kind {
    case .unknownExpr:
      let node = data.as(UnknownExprSyntax.self)!
      return visit(node)
    case .missingExpr:
      let node = data.as(MissingExprSyntax.self)!
      return visit(node)
    case .inOutExpr:
      let node = data.as(InOutExprSyntax.self)!
      return visit(node)
    case .poundColumnExpr:
      let node = data.as(PoundColumnExprSyntax.self)!
      return visit(node)
    case .tryExpr:
      let node = data.as(TryExprSyntax.self)!
      return visit(node)
    case .awaitExpr:
      let node = data.as(AwaitExprSyntax.self)!
      return visit(node)
    case .moveExpr:
      let node = data.as(MoveExprSyntax.self)!
      return visit(node)
    case .identifierExpr:
      let node = data.as(IdentifierExprSyntax.self)!
      return visit(node)
    case .superRefExpr:
      let node = data.as(SuperRefExprSyntax.self)!
      return visit(node)
    case .nilLiteralExpr:
      let node = data.as(NilLiteralExprSyntax.self)!
      return visit(node)
    case .discardAssignmentExpr:
      let node = data.as(DiscardAssignmentExprSyntax.self)!
      return visit(node)
    case .assignmentExpr:
      let node = data.as(AssignmentExprSyntax.self)!
      return visit(node)
    case .sequenceExpr:
      let node = data.as(SequenceExprSyntax.self)!
      return visit(node)
    case .poundLineExpr:
      let node = data.as(PoundLineExprSyntax.self)!
      return visit(node)
    case .poundFileExpr:
      let node = data.as(PoundFileExprSyntax.self)!
      return visit(node)
    case .poundFileIDExpr:
      let node = data.as(PoundFileIDExprSyntax.self)!
      return visit(node)
    case .poundFilePathExpr:
      let node = data.as(PoundFilePathExprSyntax.self)!
      return visit(node)
    case .poundFunctionExpr:
      let node = data.as(PoundFunctionExprSyntax.self)!
      return visit(node)
    case .poundDsohandleExpr:
      let node = data.as(PoundDsohandleExprSyntax.self)!
      return visit(node)
    case .symbolicReferenceExpr:
      let node = data.as(SymbolicReferenceExprSyntax.self)!
      return visit(node)
    case .prefixOperatorExpr:
      let node = data.as(PrefixOperatorExprSyntax.self)!
      return visit(node)
    case .binaryOperatorExpr:
      let node = data.as(BinaryOperatorExprSyntax.self)!
      return visit(node)
    case .arrowExpr:
      let node = data.as(ArrowExprSyntax.self)!
      return visit(node)
    case .infixOperatorExpr:
      let node = data.as(InfixOperatorExprSyntax.self)!
      return visit(node)
    case .floatLiteralExpr:
      let node = data.as(FloatLiteralExprSyntax.self)!
      return visit(node)
    case .tupleExpr:
      let node = data.as(TupleExprSyntax.self)!
      return visit(node)
    case .arrayExpr:
      let node = data.as(ArrayExprSyntax.self)!
      return visit(node)
    case .dictionaryExpr:
      let node = data.as(DictionaryExprSyntax.self)!
      return visit(node)
    case .integerLiteralExpr:
      let node = data.as(IntegerLiteralExprSyntax.self)!
      return visit(node)
    case .booleanLiteralExpr:
      let node = data.as(BooleanLiteralExprSyntax.self)!
      return visit(node)
    case .unresolvedTernaryExpr:
      let node = data.as(UnresolvedTernaryExprSyntax.self)!
      return visit(node)
    case .ternaryExpr:
      let node = data.as(TernaryExprSyntax.self)!
      return visit(node)
    case .memberAccessExpr:
      let node = data.as(MemberAccessExprSyntax.self)!
      return visit(node)
    case .unresolvedIsExpr:
      let node = data.as(UnresolvedIsExprSyntax.self)!
      return visit(node)
    case .isExpr:
      let node = data.as(IsExprSyntax.self)!
      return visit(node)
    case .unresolvedAsExpr:
      let node = data.as(UnresolvedAsExprSyntax.self)!
      return visit(node)
    case .asExpr:
      let node = data.as(AsExprSyntax.self)!
      return visit(node)
    case .typeExpr:
      let node = data.as(TypeExprSyntax.self)!
      return visit(node)
    case .closureExpr:
      let node = data.as(ClosureExprSyntax.self)!
      return visit(node)
    case .unresolvedPatternExpr:
      let node = data.as(UnresolvedPatternExprSyntax.self)!
      return visit(node)
    case .functionCallExpr:
      let node = data.as(FunctionCallExprSyntax.self)!
      return visit(node)
    case .subscriptExpr:
      let node = data.as(SubscriptExprSyntax.self)!
      return visit(node)
    case .optionalChainingExpr:
      let node = data.as(OptionalChainingExprSyntax.self)!
      return visit(node)
    case .forcedValueExpr:
      let node = data.as(ForcedValueExprSyntax.self)!
      return visit(node)
    case .postfixUnaryExpr:
      let node = data.as(PostfixUnaryExprSyntax.self)!
      return visit(node)
    case .specializeExpr:
      let node = data.as(SpecializeExprSyntax.self)!
      return visit(node)
    case .stringLiteralExpr:
      let node = data.as(StringLiteralExprSyntax.self)!
      return visit(node)
    case .regexLiteralExpr:
      let node = data.as(RegexLiteralExprSyntax.self)!
      return visit(node)
    case .keyPathExpr:
      let node = data.as(KeyPathExprSyntax.self)!
      return visit(node)
    case .keyPathBaseExpr:
      let node = data.as(KeyPathBaseExprSyntax.self)!
      return visit(node)
    case .objcKeyPathExpr:
      let node = data.as(ObjcKeyPathExprSyntax.self)!
      return visit(node)
    case .objcSelectorExpr:
      let node = data.as(ObjcSelectorExprSyntax.self)!
      return visit(node)
    case .postfixIfConfigExpr:
      let node = data.as(PostfixIfConfigExprSyntax.self)!
      return visit(node)
    case .editorPlaceholderExpr:
      let node = data.as(EditorPlaceholderExprSyntax.self)!
      return visit(node)
    case .objectLiteralExpr:
      let node = data.as(ObjectLiteralExprSyntax.self)!
      return visit(node)
    default:
      fatalError("Not expression?")
    }
  }
  
  public func visit(_ data: PatternSyntax) -> ResultType {
    switch data.raw.kind {
    case .unknownPattern:
      let node = data.as(UnknownPatternSyntax.self)!
      return visit(node)
    case .missingPattern:
      let node = data.as(MissingPatternSyntax.self)!
      return visit(node)
    case .enumCasePattern:
      let node = data.as(EnumCasePatternSyntax.self)!
      return visit(node)
    case .isTypePattern:
      let node = data.as(IsTypePatternSyntax.self)!
      return visit(node)
    case .optionalPattern:
      let node = data.as(OptionalPatternSyntax.self)!
      return visit(node)
    case .identifierPattern:
      let node = data.as(IdentifierPatternSyntax.self)!
      return visit(node)
    case .asTypePattern:
      let node = data.as(AsTypePatternSyntax.self)!
      return visit(node)
    case .tuplePattern:
      let node = data.as(TuplePatternSyntax.self)!
      return visit(node)
    case .wildcardPattern:
      let node = data.as(WildcardPatternSyntax.self)!
      return visit(node)
    case .expressionPattern:
      let node = data.as(ExpressionPatternSyntax.self)!
      return visit(node)
    case .valueBindingPattern:
      let node = data.as(ValueBindingPatternSyntax.self)!
      return visit(node)
    default:
      fatalError("Not expression?")
    }
  }
  
  public func visit(_ data: TypeSyntax) -> ResultType {
    switch data.raw.kind {
    case .unknownType:
      let node = data.as(UnknownTypeSyntax.self)!
      return visit(node)
    case .missingType:
      let node = data.as(MissingTypeSyntax.self)!
      return visit(node)
    case .simpleTypeIdentifier:
      let node = data.as(SimpleTypeIdentifierSyntax.self)!
      return visit(node)
    case .memberTypeIdentifier:
      let node = data.as(MemberTypeIdentifierSyntax.self)!
      return visit(node)
    case .classRestrictionType:
      let node = data.as(ClassRestrictionTypeSyntax.self)!
      return visit(node)
    case .arrayType:
      let node = data.as(ArrayTypeSyntax.self)!
      return visit(node)
    case .dictionaryType:
      let node = data.as(DictionaryTypeSyntax.self)!
      return visit(node)
    case .metatypeType:
      let node = data.as(MetatypeTypeSyntax.self)!
      return visit(node)
    case .optionalType:
      let node = data.as(OptionalTypeSyntax.self)!
      return visit(node)
    case .constrainedSugarType:
      let node = data.as(ConstrainedSugarTypeSyntax.self)!
      return visit(node)
    case .implicitlyUnwrappedOptionalType:
      let node = data.as(ImplicitlyUnwrappedOptionalTypeSyntax.self)!
      return visit(node)
    case .compositionType:
      let node = data.as(CompositionTypeSyntax.self)!
      return visit(node)
    case .tupleType:
      let node = data.as(TupleTypeSyntax.self)!
      return visit(node)
    case .functionType:
      let node = data.as(FunctionTypeSyntax.self)!
      return visit(node)
    case .attributedType:
      let node = data.as(AttributedTypeSyntax.self)!
      return visit(node)
    default:
      fatalError("Not expression?")
    }
  }

  public func visitChildren<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) -> [ResultType] {
    let syntaxNode = Syntax(node)
    return NonNilRawSyntaxChildren(syntaxNode, viewMode: .sourceAccurate).map { rawChild in
      let child = Syntax(SyntaxData(rawChild, parent: syntaxNode))
      return visit(child)
    }
  }
}
