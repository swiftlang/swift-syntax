//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxRewriter.swift - Syntax Rewriter class ------------===//
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

  /// Visit a `UnknownDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `UnknownExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `UnknownStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `UnknownTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `UnknownPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownPatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `CodeBlockItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockItemSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CodeBlockItemListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockItemListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CodeBlockSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `InOutExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InOutExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PoundColumnExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundColumnExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `TupleExprElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ArrayElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DictionaryElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `StringLiteralSegmentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringLiteralSegmentsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `TryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TryExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `AwaitExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AwaitExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `DeclNameArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DeclNameArgumentListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DeclNameArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `IdentifierExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IdentifierExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `SuperRefExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SuperRefExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `NilLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NilLiteralExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `DiscardAssignmentExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DiscardAssignmentExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `AssignmentExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AssignmentExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `SequenceExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SequenceExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `ExprListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExprListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PoundLineExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundLineExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PoundFileExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFileExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PoundFileIDExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFileIDExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PoundFilePathExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFilePathExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PoundFunctionExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFunctionExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PoundDsohandleExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundDsohandleExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `SymbolicReferenceExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SymbolicReferenceExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PrefixOperatorExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrefixOperatorExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `BinaryOperatorExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BinaryOperatorExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `ArrowExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrowExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `FloatLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FloatLiteralExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `TupleExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `ArrayExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `DictionaryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `TupleExprElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ArrayElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DictionaryElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `IntegerLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IntegerLiteralExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `BooleanLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BooleanLiteralExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `TernaryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TernaryExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `MemberAccessExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberAccessExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `IsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IsExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `AsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AsExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `TypeExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `ClosureCaptureItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureItemSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ClosureCaptureItemListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureItemListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ClosureCaptureSignatureSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureSignatureSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ClosureParamSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureParamSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ClosureParamListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureParamListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ClosureSignatureSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureSignatureSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ClosureExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `UnresolvedPatternExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedPatternExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `MultipleTrailingClosureElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MultipleTrailingClosureElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `MultipleTrailingClosureElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MultipleTrailingClosureElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `FunctionCallExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `SubscriptExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SubscriptExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `OptionalChainingExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalChainingExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `ForcedValueExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ForcedValueExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PostfixUnaryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PostfixUnaryExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `SpecializeExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SpecializeExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `StringSegmentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringSegmentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ExpressionSegmentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionSegmentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `StringLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringLiteralExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `RegexLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: RegexLiteralExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `KeyPathExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `KeyPathBaseExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathBaseExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `ObjcNamePieceSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcNamePieceSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ObjcNameSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcNameSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ObjcKeyPathExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcKeyPathExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `ObjcSelectorExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcSelectorExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `PostfixIfConfigExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PostfixIfConfigExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `EditorPlaceholderExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EditorPlaceholderExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `ObjectLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjectLiteralExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `TypeInitializerClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeInitializerClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `TypealiasDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypealiasDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `AssociatedtypeDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AssociatedtypeDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `FunctionParameterListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionParameterListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ParameterClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ParameterClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ReturnClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ReturnClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `FunctionSignatureSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionSignatureSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `IfConfigClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `IfConfigClauseListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigClauseListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `IfConfigDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `PoundErrorDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundErrorDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `PoundWarningDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundWarningDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `PoundSourceLocationSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundSourceLocationSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `PoundSourceLocationArgsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundSourceLocationArgsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DeclModifierDetailSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclModifierDetailSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DeclModifierSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclModifierSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `InheritedTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InheritedTypeSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `InheritedTypeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InheritedTypeListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `TypeInheritanceClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeInheritanceClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ClassDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `ActorDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ActorDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `StructDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StructDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `ProtocolDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ProtocolDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `ExtensionDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExtensionDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `MemberDeclBlockSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclBlockSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `MemberDeclListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `MemberDeclListItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclListItemSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `SourceFileSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SourceFileSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `InitializerClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InitializerClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `FunctionParameterSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionParameterSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ModifierListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ModifierListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `FunctionDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `InitializerDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InitializerDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `DeinitializerDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeinitializerDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `SubscriptDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SubscriptDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `AccessLevelModifierSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessLevelModifierSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AccessPathComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessPathComponentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AccessPathSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessPathSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ImportDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImportDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `AccessorParameterSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorParameterSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AccessorDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `AccessorListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AccessorBlockSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorBlockSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PatternBindingSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PatternBindingSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PatternBindingListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PatternBindingListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `VariableDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `EnumCaseElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `EnumCaseElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `EnumCaseDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `EnumDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `OperatorDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OperatorDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `IdentifierListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IdentifierListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `OperatorPrecedenceAndTypesSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrecedenceGroupDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `PrecedenceGroupAttributeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrecedenceGroupRelationSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupRelationSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrecedenceGroupNameListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupNameListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrecedenceGroupNameElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrecedenceGroupAssignmentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrecedenceGroupAssociativitySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `TokenListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TokenListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `NonEmptyTokenListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NonEmptyTokenListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CustomAttributeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CustomAttributeSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AttributeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributeSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AttributeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributeListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `SpecializeAttributeSpecListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AvailabilityEntrySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityEntrySyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `LabeledSpecializeEntrySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `TargetFunctionEntrySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TargetFunctionEntrySyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `NamedAttributeStringArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NamedAttributeStringArgumentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DeclNameSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ImplementsAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ObjCSelectorPieceSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjCSelectorPieceSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ObjCSelectorSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjCSelectorSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DifferentiableAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiableAttributeArgumentsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DifferentiabilityParamsClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiabilityParamsClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DifferentiabilityParamsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiabilityParamsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DifferentiabilityParamListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiabilityParamListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DifferentiabilityParamSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiabilityParamSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DerivativeRegistrationAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DerivativeRegistrationAttributeArgumentsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `QualifiedDeclNameSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: QualifiedDeclNameSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `FunctionDeclNameSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionDeclNameSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `BackDeployAttributeSpecListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BackDeployAttributeSpecListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `BackDeployVersionListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BackDeployVersionListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `BackDeployVersionArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BackDeployVersionArgumentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ContinueStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ContinueStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `WhileStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WhileStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `DeferStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeferStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `ExpressionStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `SwitchCaseListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `RepeatWhileStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: RepeatWhileStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `GuardStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GuardStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `WhereClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WhereClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ForInStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ForInStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `SwitchStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `CatchClauseListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchClauseListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DoStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DoStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `ReturnStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ReturnStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `YieldStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `YieldListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `FallthroughStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FallthroughStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `BreakStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BreakStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `CaseItemListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CaseItemListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CatchItemListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchItemListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ConditionElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConditionElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AvailabilityConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityConditionSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `MatchingPatternConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MatchingPatternConditionSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `OptionalBindingConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalBindingConditionSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `UnavailabilityConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnavailabilityConditionSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ConditionElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConditionElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DeclarationStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclarationStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `ThrowStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ThrowStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `IfStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `ElseIfContinuationSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ElseIfContinuationSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ElseBlockSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ElseBlockSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `SwitchCaseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `SwitchDefaultLabelSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchDefaultLabelSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CaseItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CaseItemSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CatchItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchItemSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `SwitchCaseLabelSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseLabelSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CatchClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PoundAssertStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundAssertStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `GenericWhereClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericWhereClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `GenericRequirementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericRequirementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `GenericRequirementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericRequirementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `SameTypeRequirementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SameTypeRequirementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `GenericParameterListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `GenericParameterSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrimaryAssociatedTypeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrimaryAssociatedTypeListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrimaryAssociatedTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrimaryAssociatedTypeSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `GenericParameterClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ConformanceRequirementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConformanceRequirementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `PrimaryAssociatedTypeClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrimaryAssociatedTypeClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `SimpleTypeIdentifierSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SimpleTypeIdentifierSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `MemberTypeIdentifierSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberTypeIdentifierSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `ClassRestrictionTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClassRestrictionTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `ArrayTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `DictionaryTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `MetatypeTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MetatypeTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `OptionalTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `ConstrainedSugarTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConstrainedSugarTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `ImplicitlyUnwrappedOptionalTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `CompositionTypeElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CompositionTypeElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `CompositionTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `TupleTypeElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `TupleTypeElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `TupleTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `FunctionTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `AttributedTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributedTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `GenericArgumentListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `GenericArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `GenericArgumentClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentClauseSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `TypeAnnotationSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeAnnotationSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `EnumCasePatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCasePatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `IsTypePatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IsTypePatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `OptionalPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalPatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `IdentifierPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IdentifierPatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `AsTypePatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AsTypePatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `TuplePatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `WildcardPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WildcardPatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `TuplePatternElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ExpressionPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionPatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `TuplePatternElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternElementListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ValueBindingPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ValueBindingPatternSyntax) -> PatternSyntax {
    return PatternSyntax(visitChildren(node))
  }

  /// Visit a `AvailabilitySpecListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilitySpecListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AvailabilityArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityArgumentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AvailabilityLabeledArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `AvailabilityVersionRestrictionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `VersionTupleSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: VersionTupleSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }


  /// Visit a `TokenSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ token: TokenSyntax) -> Syntax {
    return Syntax(token)
  }
  
  /// Visit an `UnknownSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// The function called before visiting the node and its descendents.
  ///   - node: the node we are about to visit.
  open func visitPre(_ node: Syntax) {}

  /// Override point to choose custom visitation dispatch instead of the
  /// specialized `visit(_:)` methods. Use this instead of those methods if
  /// you intend to dynamically dispatch rewriting behavior.
  /// - note: If this method returns a non-nil result, the specialized
  ///         `visit(_:)` methods will not be called for this node and the 
  ///         visited node will be replaced by the returned node in the 
  ///         rewritten tree.
  open func visitAny(_ node: Syntax) -> Syntax? {
    return nil
  }

  /// The function called after visiting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: Syntax) {}

  /// Visit any Syntax node. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  public func visit(_ syntax: Syntax) -> Syntax {
    return visitImpl(syntax)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownPatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownPatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownPatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockItemSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CodeBlockItemSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockItemListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CodeBlockItemListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CodeBlockSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInOutExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(InOutExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundColumnExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundColumnExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TupleExprElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ArrayElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DictionaryElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringLiteralSegmentsSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(StringLiteralSegmentsSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTryExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TryExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAwaitExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AwaitExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeclNameArgumentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeclNameArgumentListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentsSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeclNameArgumentsSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IdentifierExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSuperRefExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SuperRefExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNilLiteralExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(NilLiteralExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDiscardAssignmentExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DiscardAssignmentExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAssignmentExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AssignmentExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSequenceExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SequenceExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExprListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ExprListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundLineExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundLineExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFileExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundFileExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFileIDExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundFileIDExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFilePathExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundFilePathExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFunctionExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundFunctionExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundDsohandleExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundDsohandleExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSymbolicReferenceExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SymbolicReferenceExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrefixOperatorExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrefixOperatorExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBinaryOperatorExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(BinaryOperatorExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrowExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ArrowExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFloatLiteralExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FloatLiteralExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TupleExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ArrayExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DictionaryExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TupleExprElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ArrayElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DictionaryElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIntegerLiteralExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IntegerLiteralExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBooleanLiteralExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(BooleanLiteralExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTernaryExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TernaryExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberAccessExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MemberAccessExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIsExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IsExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAsExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AsExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TypeExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureItemSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClosureCaptureItemSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureItemListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClosureCaptureItemListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureSignatureSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClosureCaptureSignatureSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureParamSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClosureParamSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureParamListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClosureParamListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureSignatureSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClosureSignatureSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClosureExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedPatternExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnresolvedPatternExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MultipleTrailingClosureElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MultipleTrailingClosureElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionCallExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FunctionCallExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSubscriptExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SubscriptExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalChainingExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(OptionalChainingExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplForcedValueExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ForcedValueExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPostfixUnaryExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PostfixUnaryExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSpecializeExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SpecializeExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringSegmentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(StringSegmentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionSegmentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ExpressionSegmentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringLiteralExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(StringLiteralExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplRegexLiteralExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(RegexLiteralExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(KeyPathExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathBaseExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(KeyPathBaseExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcNamePieceSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ObjcNamePieceSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcNameSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ObjcNameSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcKeyPathExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ObjcKeyPathExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcSelectorExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ObjcSelectorExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPostfixIfConfigExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PostfixIfConfigExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEditorPlaceholderExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(EditorPlaceholderExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjectLiteralExprSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ObjectLiteralExprSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeInitializerClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TypeInitializerClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypealiasDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TypealiasDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAssociatedtypeDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AssociatedtypeDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionParameterListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FunctionParameterListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplParameterClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ParameterClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplReturnClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ReturnClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionSignatureSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FunctionSignatureSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IfConfigClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigClauseListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IfConfigClauseListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IfConfigDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundErrorDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundErrorDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundWarningDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundWarningDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundSourceLocationSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundSourceLocationSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundSourceLocationArgsSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundSourceLocationArgsSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclModifierDetailSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeclModifierDetailSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclModifierSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeclModifierSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInheritedTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(InheritedTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInheritedTypeListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(InheritedTypeListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeInheritanceClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TypeInheritanceClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClassDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClassDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplActorDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ActorDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStructDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(StructDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplProtocolDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ProtocolDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExtensionDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ExtensionDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclBlockSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MemberDeclBlockSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MemberDeclListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclListItemSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MemberDeclListItemSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSourceFileSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SourceFileSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInitializerClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(InitializerClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionParameterSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FunctionParameterSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplModifierListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ModifierListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FunctionDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInitializerDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(InitializerDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeinitializerDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeinitializerDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSubscriptDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SubscriptDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessLevelModifierSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AccessLevelModifierSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessPathComponentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AccessPathComponentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessPathSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AccessPathSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImportDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ImportDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorParameterSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AccessorParameterSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AccessorDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AccessorListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorBlockSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AccessorBlockSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternBindingSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PatternBindingSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternBindingListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PatternBindingListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplVariableDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(VariableDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(EnumCaseElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(EnumCaseElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(EnumCaseDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(EnumDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOperatorDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(OperatorDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IdentifierListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOperatorPrecedenceAndTypesSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(OperatorPrecedenceAndTypesSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupDeclSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrecedenceGroupDeclSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAttributeListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrecedenceGroupAttributeListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupRelationSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrecedenceGroupRelationSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupNameListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrecedenceGroupNameListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupNameElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrecedenceGroupNameElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAssignmentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrecedenceGroupAssignmentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAssociativitySyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrecedenceGroupAssociativitySyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTokenListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TokenListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNonEmptyTokenListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(NonEmptyTokenListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCustomAttributeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CustomAttributeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AttributeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributeListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AttributeListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSpecializeAttributeSpecListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SpecializeAttributeSpecListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityEntrySyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AvailabilityEntrySyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplLabeledSpecializeEntrySyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(LabeledSpecializeEntrySyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTargetFunctionEntrySyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TargetFunctionEntrySyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNamedAttributeStringArgumentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(NamedAttributeStringArgumentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeclNameSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImplementsAttributeArgumentsSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ImplementsAttributeArgumentsSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjCSelectorPieceSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ObjCSelectorPieceSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjCSelectorSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ObjCSelectorSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiableAttributeArgumentsSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DifferentiableAttributeArgumentsSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamsClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DifferentiabilityParamsClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamsSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DifferentiabilityParamsSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DifferentiabilityParamListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DifferentiabilityParamSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDerivativeRegistrationAttributeArgumentsSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DerivativeRegistrationAttributeArgumentsSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplQualifiedDeclNameSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(QualifiedDeclNameSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionDeclNameSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FunctionDeclNameSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployAttributeSpecListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(BackDeployAttributeSpecListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployVersionListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(BackDeployVersionListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployVersionArgumentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(BackDeployVersionArgumentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplContinueStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ContinueStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWhileStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(WhileStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeferStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeferStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ExpressionStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SwitchCaseListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplRepeatWhileStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(RepeatWhileStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGuardStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GuardStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWhereClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(WhereClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplForInStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ForInStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SwitchStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchClauseListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CatchClauseListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDoStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DoStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplReturnStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ReturnStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(YieldStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(YieldListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFallthroughStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FallthroughStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBreakStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(BreakStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCaseItemListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CaseItemListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchItemListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CatchItemListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConditionElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ConditionElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityConditionSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AvailabilityConditionSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMatchingPatternConditionSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MatchingPatternConditionSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalBindingConditionSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(OptionalBindingConditionSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnavailabilityConditionSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnavailabilityConditionSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConditionElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ConditionElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclarationStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DeclarationStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplThrowStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ThrowStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IfStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplElseIfContinuationSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ElseIfContinuationSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplElseBlockSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ElseBlockSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SwitchCaseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchDefaultLabelSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SwitchDefaultLabelSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCaseItemSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CaseItemSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchItemSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CatchItemSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseLabelSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SwitchCaseLabelSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CatchClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundAssertStmtSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PoundAssertStmtSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericWhereClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericWhereClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericRequirementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericRequirementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericRequirementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericRequirementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSameTypeRequirementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SameTypeRequirementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericParameterListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericParameterSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrimaryAssociatedTypeListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrimaryAssociatedTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericParameterClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConformanceRequirementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ConformanceRequirementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(PrimaryAssociatedTypeClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSimpleTypeIdentifierSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(SimpleTypeIdentifierSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberTypeIdentifierSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MemberTypeIdentifierSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClassRestrictionTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ClassRestrictionTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ArrayTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(DictionaryTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMetatypeTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(MetatypeTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(OptionalTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConstrainedSugarTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ConstrainedSugarTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImplicitlyUnwrappedOptionalTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ImplicitlyUnwrappedOptionalTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CompositionTypeElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CompositionTypeElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(CompositionTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TupleTypeElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TupleTypeElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TupleTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(FunctionTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributedTypeSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AttributedTypeSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericArgumentListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericArgumentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentClauseSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(GenericArgumentClauseSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeAnnotationSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TypeAnnotationSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCasePatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(EnumCasePatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIsTypePatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IsTypePatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalPatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(OptionalPatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierPatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(IdentifierPatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAsTypePatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AsTypePatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TuplePatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWildcardPatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(WildcardPatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternElementSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TuplePatternElementSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionPatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ExpressionPatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternElementListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TuplePatternElementListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplValueBindingPatternSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(ValueBindingPatternSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilitySpecListSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AvailabilitySpecListSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityArgumentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AvailabilityArgumentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityLabeledArgumentSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AvailabilityLabeledArgumentSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityVersionRestrictionSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(AvailabilityVersionRestrictionSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplVersionTupleSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(VersionTupleSyntax(data: syntax.data)).syntax
  }


  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTokenSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(TokenSyntax(data: syntax.data)).syntax
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownSyntax(_ syntax: Syntax) -> Syntax {
    visitPre(syntax)
    defer { visitPost(syntax) }
    if let newNode = visitAny(syntax) { return newNode }
    return visit(UnknownSyntax(data: syntax.data)).syntax
  }

// SwiftSyntax requires a lot of stack space in debug builds for syntax tree
// rewriting. In scenarios with reduced stack space (in particular dispatch 
// queues), this easily results in a stack overflow. To work around this issue, 
// use a less performant but also less stack-hungry version of SwiftSyntax's 
// SyntaxRewriter in debug builds.
#if DEBUG

  /// Implementation detail of visit(_:). Do not call directly.
  /// 
  /// Returns the function that shall be called to visit a specific syntax node.
  ///
  /// To determine the correct specific visitation function for a syntax node,
  /// we need to switch through a huge switch statement that covers all syntax
  /// types. In debug builds, the cases of this switch statement do not share 
  /// stack space (rdar://55929175). Because of this, the switch statement 
  /// requires allocates about 15KB of stack space. In scenarios with reduced 
  /// stack size (in particular dispatch queues), this often results in a stack 
  /// overflow during syntax tree rewriting.
  /// 
  /// To circumvent this problem, make calling the specific visitation function 
  /// a two-step process: First determine the function to call in this function
  /// and return a reference to it, then call it. This way, the stack frame
  /// that determines the correct visitiation function will be popped of the
  /// stack before the function is being called, making the switch's stack
  /// space transient instead of having it linger in the call stack.
  private func visitationFunc(for syntax: Syntax) -> ((Syntax) -> Syntax) {
    switch syntax.syntaxKind {
    case .token:
      return visitImplTokenSyntax
    case .unknown:
      return visitImplUnknownSyntax
    case .decl:
      return visitImplDeclSyntax
    case .expr:
      return visitImplExprSyntax
    case .stmt:
      return visitImplStmtSyntax
    case .type:
      return visitImplTypeSyntax
    case .pattern:
      return visitImplPatternSyntax
    case .unknownDecl:
      return visitImplUnknownDeclSyntax
    case .unknownExpr:
      return visitImplUnknownExprSyntax
    case .unknownStmt:
      return visitImplUnknownStmtSyntax
    case .unknownType:
      return visitImplUnknownTypeSyntax
    case .unknownPattern:
      return visitImplUnknownPatternSyntax
    case .codeBlockItem:
      return visitImplCodeBlockItemSyntax
    case .codeBlockItemList:
      return visitImplCodeBlockItemListSyntax
    case .codeBlock:
      return visitImplCodeBlockSyntax
    case .inOutExpr:
      return visitImplInOutExprSyntax
    case .poundColumnExpr:
      return visitImplPoundColumnExprSyntax
    case .tupleExprElementList:
      return visitImplTupleExprElementListSyntax
    case .arrayElementList:
      return visitImplArrayElementListSyntax
    case .dictionaryElementList:
      return visitImplDictionaryElementListSyntax
    case .stringLiteralSegments:
      return visitImplStringLiteralSegmentsSyntax
    case .tryExpr:
      return visitImplTryExprSyntax
    case .awaitExpr:
      return visitImplAwaitExprSyntax
    case .declNameArgument:
      return visitImplDeclNameArgumentSyntax
    case .declNameArgumentList:
      return visitImplDeclNameArgumentListSyntax
    case .declNameArguments:
      return visitImplDeclNameArgumentsSyntax
    case .identifierExpr:
      return visitImplIdentifierExprSyntax
    case .superRefExpr:
      return visitImplSuperRefExprSyntax
    case .nilLiteralExpr:
      return visitImplNilLiteralExprSyntax
    case .discardAssignmentExpr:
      return visitImplDiscardAssignmentExprSyntax
    case .assignmentExpr:
      return visitImplAssignmentExprSyntax
    case .sequenceExpr:
      return visitImplSequenceExprSyntax
    case .exprList:
      return visitImplExprListSyntax
    case .poundLineExpr:
      return visitImplPoundLineExprSyntax
    case .poundFileExpr:
      return visitImplPoundFileExprSyntax
    case .poundFileIDExpr:
      return visitImplPoundFileIDExprSyntax
    case .poundFilePathExpr:
      return visitImplPoundFilePathExprSyntax
    case .poundFunctionExpr:
      return visitImplPoundFunctionExprSyntax
    case .poundDsohandleExpr:
      return visitImplPoundDsohandleExprSyntax
    case .symbolicReferenceExpr:
      return visitImplSymbolicReferenceExprSyntax
    case .prefixOperatorExpr:
      return visitImplPrefixOperatorExprSyntax
    case .binaryOperatorExpr:
      return visitImplBinaryOperatorExprSyntax
    case .arrowExpr:
      return visitImplArrowExprSyntax
    case .floatLiteralExpr:
      return visitImplFloatLiteralExprSyntax
    case .tupleExpr:
      return visitImplTupleExprSyntax
    case .arrayExpr:
      return visitImplArrayExprSyntax
    case .dictionaryExpr:
      return visitImplDictionaryExprSyntax
    case .tupleExprElement:
      return visitImplTupleExprElementSyntax
    case .arrayElement:
      return visitImplArrayElementSyntax
    case .dictionaryElement:
      return visitImplDictionaryElementSyntax
    case .integerLiteralExpr:
      return visitImplIntegerLiteralExprSyntax
    case .booleanLiteralExpr:
      return visitImplBooleanLiteralExprSyntax
    case .ternaryExpr:
      return visitImplTernaryExprSyntax
    case .memberAccessExpr:
      return visitImplMemberAccessExprSyntax
    case .isExpr:
      return visitImplIsExprSyntax
    case .asExpr:
      return visitImplAsExprSyntax
    case .typeExpr:
      return visitImplTypeExprSyntax
    case .closureCaptureItem:
      return visitImplClosureCaptureItemSyntax
    case .closureCaptureItemList:
      return visitImplClosureCaptureItemListSyntax
    case .closureCaptureSignature:
      return visitImplClosureCaptureSignatureSyntax
    case .closureParam:
      return visitImplClosureParamSyntax
    case .closureParamList:
      return visitImplClosureParamListSyntax
    case .closureSignature:
      return visitImplClosureSignatureSyntax
    case .closureExpr:
      return visitImplClosureExprSyntax
    case .unresolvedPatternExpr:
      return visitImplUnresolvedPatternExprSyntax
    case .multipleTrailingClosureElement:
      return visitImplMultipleTrailingClosureElementSyntax
    case .multipleTrailingClosureElementList:
      return visitImplMultipleTrailingClosureElementListSyntax
    case .functionCallExpr:
      return visitImplFunctionCallExprSyntax
    case .subscriptExpr:
      return visitImplSubscriptExprSyntax
    case .optionalChainingExpr:
      return visitImplOptionalChainingExprSyntax
    case .forcedValueExpr:
      return visitImplForcedValueExprSyntax
    case .postfixUnaryExpr:
      return visitImplPostfixUnaryExprSyntax
    case .specializeExpr:
      return visitImplSpecializeExprSyntax
    case .stringSegment:
      return visitImplStringSegmentSyntax
    case .expressionSegment:
      return visitImplExpressionSegmentSyntax
    case .stringLiteralExpr:
      return visitImplStringLiteralExprSyntax
    case .regexLiteralExpr:
      return visitImplRegexLiteralExprSyntax
    case .keyPathExpr:
      return visitImplKeyPathExprSyntax
    case .keyPathBaseExpr:
      return visitImplKeyPathBaseExprSyntax
    case .objcNamePiece:
      return visitImplObjcNamePieceSyntax
    case .objcName:
      return visitImplObjcNameSyntax
    case .objcKeyPathExpr:
      return visitImplObjcKeyPathExprSyntax
    case .objcSelectorExpr:
      return visitImplObjcSelectorExprSyntax
    case .postfixIfConfigExpr:
      return visitImplPostfixIfConfigExprSyntax
    case .editorPlaceholderExpr:
      return visitImplEditorPlaceholderExprSyntax
    case .objectLiteralExpr:
      return visitImplObjectLiteralExprSyntax
    case .typeInitializerClause:
      return visitImplTypeInitializerClauseSyntax
    case .typealiasDecl:
      return visitImplTypealiasDeclSyntax
    case .associatedtypeDecl:
      return visitImplAssociatedtypeDeclSyntax
    case .functionParameterList:
      return visitImplFunctionParameterListSyntax
    case .parameterClause:
      return visitImplParameterClauseSyntax
    case .returnClause:
      return visitImplReturnClauseSyntax
    case .functionSignature:
      return visitImplFunctionSignatureSyntax
    case .ifConfigClause:
      return visitImplIfConfigClauseSyntax
    case .ifConfigClauseList:
      return visitImplIfConfigClauseListSyntax
    case .ifConfigDecl:
      return visitImplIfConfigDeclSyntax
    case .poundErrorDecl:
      return visitImplPoundErrorDeclSyntax
    case .poundWarningDecl:
      return visitImplPoundWarningDeclSyntax
    case .poundSourceLocation:
      return visitImplPoundSourceLocationSyntax
    case .poundSourceLocationArgs:
      return visitImplPoundSourceLocationArgsSyntax
    case .declModifierDetail:
      return visitImplDeclModifierDetailSyntax
    case .declModifier:
      return visitImplDeclModifierSyntax
    case .inheritedType:
      return visitImplInheritedTypeSyntax
    case .inheritedTypeList:
      return visitImplInheritedTypeListSyntax
    case .typeInheritanceClause:
      return visitImplTypeInheritanceClauseSyntax
    case .classDecl:
      return visitImplClassDeclSyntax
    case .actorDecl:
      return visitImplActorDeclSyntax
    case .structDecl:
      return visitImplStructDeclSyntax
    case .protocolDecl:
      return visitImplProtocolDeclSyntax
    case .extensionDecl:
      return visitImplExtensionDeclSyntax
    case .memberDeclBlock:
      return visitImplMemberDeclBlockSyntax
    case .memberDeclList:
      return visitImplMemberDeclListSyntax
    case .memberDeclListItem:
      return visitImplMemberDeclListItemSyntax
    case .sourceFile:
      return visitImplSourceFileSyntax
    case .initializerClause:
      return visitImplInitializerClauseSyntax
    case .functionParameter:
      return visitImplFunctionParameterSyntax
    case .modifierList:
      return visitImplModifierListSyntax
    case .functionDecl:
      return visitImplFunctionDeclSyntax
    case .initializerDecl:
      return visitImplInitializerDeclSyntax
    case .deinitializerDecl:
      return visitImplDeinitializerDeclSyntax
    case .subscriptDecl:
      return visitImplSubscriptDeclSyntax
    case .accessLevelModifier:
      return visitImplAccessLevelModifierSyntax
    case .accessPathComponent:
      return visitImplAccessPathComponentSyntax
    case .accessPath:
      return visitImplAccessPathSyntax
    case .importDecl:
      return visitImplImportDeclSyntax
    case .accessorParameter:
      return visitImplAccessorParameterSyntax
    case .accessorDecl:
      return visitImplAccessorDeclSyntax
    case .accessorList:
      return visitImplAccessorListSyntax
    case .accessorBlock:
      return visitImplAccessorBlockSyntax
    case .patternBinding:
      return visitImplPatternBindingSyntax
    case .patternBindingList:
      return visitImplPatternBindingListSyntax
    case .variableDecl:
      return visitImplVariableDeclSyntax
    case .enumCaseElement:
      return visitImplEnumCaseElementSyntax
    case .enumCaseElementList:
      return visitImplEnumCaseElementListSyntax
    case .enumCaseDecl:
      return visitImplEnumCaseDeclSyntax
    case .enumDecl:
      return visitImplEnumDeclSyntax
    case .operatorDecl:
      return visitImplOperatorDeclSyntax
    case .identifierList:
      return visitImplIdentifierListSyntax
    case .operatorPrecedenceAndTypes:
      return visitImplOperatorPrecedenceAndTypesSyntax
    case .precedenceGroupDecl:
      return visitImplPrecedenceGroupDeclSyntax
    case .precedenceGroupAttributeList:
      return visitImplPrecedenceGroupAttributeListSyntax
    case .precedenceGroupRelation:
      return visitImplPrecedenceGroupRelationSyntax
    case .precedenceGroupNameList:
      return visitImplPrecedenceGroupNameListSyntax
    case .precedenceGroupNameElement:
      return visitImplPrecedenceGroupNameElementSyntax
    case .precedenceGroupAssignment:
      return visitImplPrecedenceGroupAssignmentSyntax
    case .precedenceGroupAssociativity:
      return visitImplPrecedenceGroupAssociativitySyntax
    case .tokenList:
      return visitImplTokenListSyntax
    case .nonEmptyTokenList:
      return visitImplNonEmptyTokenListSyntax
    case .customAttribute:
      return visitImplCustomAttributeSyntax
    case .attribute:
      return visitImplAttributeSyntax
    case .attributeList:
      return visitImplAttributeListSyntax
    case .specializeAttributeSpecList:
      return visitImplSpecializeAttributeSpecListSyntax
    case .availabilityEntry:
      return visitImplAvailabilityEntrySyntax
    case .labeledSpecializeEntry:
      return visitImplLabeledSpecializeEntrySyntax
    case .targetFunctionEntry:
      return visitImplTargetFunctionEntrySyntax
    case .namedAttributeStringArgument:
      return visitImplNamedAttributeStringArgumentSyntax
    case .declName:
      return visitImplDeclNameSyntax
    case .implementsAttributeArguments:
      return visitImplImplementsAttributeArgumentsSyntax
    case .objCSelectorPiece:
      return visitImplObjCSelectorPieceSyntax
    case .objCSelector:
      return visitImplObjCSelectorSyntax
    case .differentiableAttributeArguments:
      return visitImplDifferentiableAttributeArgumentsSyntax
    case .differentiabilityParamsClause:
      return visitImplDifferentiabilityParamsClauseSyntax
    case .differentiabilityParams:
      return visitImplDifferentiabilityParamsSyntax
    case .differentiabilityParamList:
      return visitImplDifferentiabilityParamListSyntax
    case .differentiabilityParam:
      return visitImplDifferentiabilityParamSyntax
    case .derivativeRegistrationAttributeArguments:
      return visitImplDerivativeRegistrationAttributeArgumentsSyntax
    case .qualifiedDeclName:
      return visitImplQualifiedDeclNameSyntax
    case .functionDeclName:
      return visitImplFunctionDeclNameSyntax
    case .backDeployAttributeSpecList:
      return visitImplBackDeployAttributeSpecListSyntax
    case .backDeployVersionList:
      return visitImplBackDeployVersionListSyntax
    case .backDeployVersionArgument:
      return visitImplBackDeployVersionArgumentSyntax
    case .continueStmt:
      return visitImplContinueStmtSyntax
    case .whileStmt:
      return visitImplWhileStmtSyntax
    case .deferStmt:
      return visitImplDeferStmtSyntax
    case .expressionStmt:
      return visitImplExpressionStmtSyntax
    case .switchCaseList:
      return visitImplSwitchCaseListSyntax
    case .repeatWhileStmt:
      return visitImplRepeatWhileStmtSyntax
    case .guardStmt:
      return visitImplGuardStmtSyntax
    case .whereClause:
      return visitImplWhereClauseSyntax
    case .forInStmt:
      return visitImplForInStmtSyntax
    case .switchStmt:
      return visitImplSwitchStmtSyntax
    case .catchClauseList:
      return visitImplCatchClauseListSyntax
    case .doStmt:
      return visitImplDoStmtSyntax
    case .returnStmt:
      return visitImplReturnStmtSyntax
    case .yieldStmt:
      return visitImplYieldStmtSyntax
    case .yieldList:
      return visitImplYieldListSyntax
    case .fallthroughStmt:
      return visitImplFallthroughStmtSyntax
    case .breakStmt:
      return visitImplBreakStmtSyntax
    case .caseItemList:
      return visitImplCaseItemListSyntax
    case .catchItemList:
      return visitImplCatchItemListSyntax
    case .conditionElement:
      return visitImplConditionElementSyntax
    case .availabilityCondition:
      return visitImplAvailabilityConditionSyntax
    case .matchingPatternCondition:
      return visitImplMatchingPatternConditionSyntax
    case .optionalBindingCondition:
      return visitImplOptionalBindingConditionSyntax
    case .unavailabilityCondition:
      return visitImplUnavailabilityConditionSyntax
    case .conditionElementList:
      return visitImplConditionElementListSyntax
    case .declarationStmt:
      return visitImplDeclarationStmtSyntax
    case .throwStmt:
      return visitImplThrowStmtSyntax
    case .ifStmt:
      return visitImplIfStmtSyntax
    case .elseIfContinuation:
      return visitImplElseIfContinuationSyntax
    case .elseBlock:
      return visitImplElseBlockSyntax
    case .switchCase:
      return visitImplSwitchCaseSyntax
    case .switchDefaultLabel:
      return visitImplSwitchDefaultLabelSyntax
    case .caseItem:
      return visitImplCaseItemSyntax
    case .catchItem:
      return visitImplCatchItemSyntax
    case .switchCaseLabel:
      return visitImplSwitchCaseLabelSyntax
    case .catchClause:
      return visitImplCatchClauseSyntax
    case .poundAssertStmt:
      return visitImplPoundAssertStmtSyntax
    case .genericWhereClause:
      return visitImplGenericWhereClauseSyntax
    case .genericRequirementList:
      return visitImplGenericRequirementListSyntax
    case .genericRequirement:
      return visitImplGenericRequirementSyntax
    case .sameTypeRequirement:
      return visitImplSameTypeRequirementSyntax
    case .genericParameterList:
      return visitImplGenericParameterListSyntax
    case .genericParameter:
      return visitImplGenericParameterSyntax
    case .primaryAssociatedTypeList:
      return visitImplPrimaryAssociatedTypeListSyntax
    case .primaryAssociatedType:
      return visitImplPrimaryAssociatedTypeSyntax
    case .genericParameterClause:
      return visitImplGenericParameterClauseSyntax
    case .conformanceRequirement:
      return visitImplConformanceRequirementSyntax
    case .primaryAssociatedTypeClause:
      return visitImplPrimaryAssociatedTypeClauseSyntax
    case .simpleTypeIdentifier:
      return visitImplSimpleTypeIdentifierSyntax
    case .memberTypeIdentifier:
      return visitImplMemberTypeIdentifierSyntax
    case .classRestrictionType:
      return visitImplClassRestrictionTypeSyntax
    case .arrayType:
      return visitImplArrayTypeSyntax
    case .dictionaryType:
      return visitImplDictionaryTypeSyntax
    case .metatypeType:
      return visitImplMetatypeTypeSyntax
    case .optionalType:
      return visitImplOptionalTypeSyntax
    case .constrainedSugarType:
      return visitImplConstrainedSugarTypeSyntax
    case .implicitlyUnwrappedOptionalType:
      return visitImplImplicitlyUnwrappedOptionalTypeSyntax
    case .compositionTypeElement:
      return visitImplCompositionTypeElementSyntax
    case .compositionTypeElementList:
      return visitImplCompositionTypeElementListSyntax
    case .compositionType:
      return visitImplCompositionTypeSyntax
    case .tupleTypeElement:
      return visitImplTupleTypeElementSyntax
    case .tupleTypeElementList:
      return visitImplTupleTypeElementListSyntax
    case .tupleType:
      return visitImplTupleTypeSyntax
    case .functionType:
      return visitImplFunctionTypeSyntax
    case .attributedType:
      return visitImplAttributedTypeSyntax
    case .genericArgumentList:
      return visitImplGenericArgumentListSyntax
    case .genericArgument:
      return visitImplGenericArgumentSyntax
    case .genericArgumentClause:
      return visitImplGenericArgumentClauseSyntax
    case .typeAnnotation:
      return visitImplTypeAnnotationSyntax
    case .enumCasePattern:
      return visitImplEnumCasePatternSyntax
    case .isTypePattern:
      return visitImplIsTypePatternSyntax
    case .optionalPattern:
      return visitImplOptionalPatternSyntax
    case .identifierPattern:
      return visitImplIdentifierPatternSyntax
    case .asTypePattern:
      return visitImplAsTypePatternSyntax
    case .tuplePattern:
      return visitImplTuplePatternSyntax
    case .wildcardPattern:
      return visitImplWildcardPatternSyntax
    case .tuplePatternElement:
      return visitImplTuplePatternElementSyntax
    case .expressionPattern:
      return visitImplExpressionPatternSyntax
    case .tuplePatternElementList:
      return visitImplTuplePatternElementListSyntax
    case .valueBindingPattern:
      return visitImplValueBindingPatternSyntax
    case .availabilitySpecList:
      return visitImplAvailabilitySpecListSyntax
    case .availabilityArgument:
      return visitImplAvailabilityArgumentSyntax
    case .availabilityLabeledArgument:
      return visitImplAvailabilityLabeledArgumentSyntax
    case .availabilityVersionRestriction:
      return visitImplAvailabilityVersionRestrictionSyntax
    case .versionTuple:
      return visitImplVersionTupleSyntax
    }
  }

  private func visitImpl(_ syntax: Syntax) -> Syntax {
    return visitationFunc(for: syntax)(syntax)
  }

#else

  private func visitImpl(_ syntax: Syntax) -> Syntax {
    switch data.raw.kind {
    case .token:
      return visitImplTokenSyntax(syntax)
    case .unknown:
      return visitImplUnknownSyntax(syntax)
    case .decl:
      return visitImplDeclSyntax(syntax)
    case .expr:
      return visitImplExprSyntax(syntax)
    case .stmt:
      return visitImplStmtSyntax(syntax)
    case .type:
      return visitImplTypeSyntax(syntax)
    case .pattern:
      return visitImplPatternSyntax(syntax)
    case .unknownDecl:
      return visitImplUnknownDeclSyntax(syntax)
    case .unknownExpr:
      return visitImplUnknownExprSyntax(syntax)
    case .unknownStmt:
      return visitImplUnknownStmtSyntax(syntax)
    case .unknownType:
      return visitImplUnknownTypeSyntax(syntax)
    case .unknownPattern:
      return visitImplUnknownPatternSyntax(syntax)
    case .codeBlockItem:
      return visitImplCodeBlockItemSyntax(syntax)
    case .codeBlockItemList:
      return visitImplCodeBlockItemListSyntax(syntax)
    case .codeBlock:
      return visitImplCodeBlockSyntax(syntax)
    case .inOutExpr:
      return visitImplInOutExprSyntax(syntax)
    case .poundColumnExpr:
      return visitImplPoundColumnExprSyntax(syntax)
    case .tupleExprElementList:
      return visitImplTupleExprElementListSyntax(syntax)
    case .arrayElementList:
      return visitImplArrayElementListSyntax(syntax)
    case .dictionaryElementList:
      return visitImplDictionaryElementListSyntax(syntax)
    case .stringLiteralSegments:
      return visitImplStringLiteralSegmentsSyntax(syntax)
    case .tryExpr:
      return visitImplTryExprSyntax(syntax)
    case .awaitExpr:
      return visitImplAwaitExprSyntax(syntax)
    case .declNameArgument:
      return visitImplDeclNameArgumentSyntax(syntax)
    case .declNameArgumentList:
      return visitImplDeclNameArgumentListSyntax(syntax)
    case .declNameArguments:
      return visitImplDeclNameArgumentsSyntax(syntax)
    case .identifierExpr:
      return visitImplIdentifierExprSyntax(syntax)
    case .superRefExpr:
      return visitImplSuperRefExprSyntax(syntax)
    case .nilLiteralExpr:
      return visitImplNilLiteralExprSyntax(syntax)
    case .discardAssignmentExpr:
      return visitImplDiscardAssignmentExprSyntax(syntax)
    case .assignmentExpr:
      return visitImplAssignmentExprSyntax(syntax)
    case .sequenceExpr:
      return visitImplSequenceExprSyntax(syntax)
    case .exprList:
      return visitImplExprListSyntax(syntax)
    case .poundLineExpr:
      return visitImplPoundLineExprSyntax(syntax)
    case .poundFileExpr:
      return visitImplPoundFileExprSyntax(syntax)
    case .poundFileIDExpr:
      return visitImplPoundFileIDExprSyntax(syntax)
    case .poundFilePathExpr:
      return visitImplPoundFilePathExprSyntax(syntax)
    case .poundFunctionExpr:
      return visitImplPoundFunctionExprSyntax(syntax)
    case .poundDsohandleExpr:
      return visitImplPoundDsohandleExprSyntax(syntax)
    case .symbolicReferenceExpr:
      return visitImplSymbolicReferenceExprSyntax(syntax)
    case .prefixOperatorExpr:
      return visitImplPrefixOperatorExprSyntax(syntax)
    case .binaryOperatorExpr:
      return visitImplBinaryOperatorExprSyntax(syntax)
    case .arrowExpr:
      return visitImplArrowExprSyntax(syntax)
    case .floatLiteralExpr:
      return visitImplFloatLiteralExprSyntax(syntax)
    case .tupleExpr:
      return visitImplTupleExprSyntax(syntax)
    case .arrayExpr:
      return visitImplArrayExprSyntax(syntax)
    case .dictionaryExpr:
      return visitImplDictionaryExprSyntax(syntax)
    case .tupleExprElement:
      return visitImplTupleExprElementSyntax(syntax)
    case .arrayElement:
      return visitImplArrayElementSyntax(syntax)
    case .dictionaryElement:
      return visitImplDictionaryElementSyntax(syntax)
    case .integerLiteralExpr:
      return visitImplIntegerLiteralExprSyntax(syntax)
    case .booleanLiteralExpr:
      return visitImplBooleanLiteralExprSyntax(syntax)
    case .ternaryExpr:
      return visitImplTernaryExprSyntax(syntax)
    case .memberAccessExpr:
      return visitImplMemberAccessExprSyntax(syntax)
    case .isExpr:
      return visitImplIsExprSyntax(syntax)
    case .asExpr:
      return visitImplAsExprSyntax(syntax)
    case .typeExpr:
      return visitImplTypeExprSyntax(syntax)
    case .closureCaptureItem:
      return visitImplClosureCaptureItemSyntax(syntax)
    case .closureCaptureItemList:
      return visitImplClosureCaptureItemListSyntax(syntax)
    case .closureCaptureSignature:
      return visitImplClosureCaptureSignatureSyntax(syntax)
    case .closureParam:
      return visitImplClosureParamSyntax(syntax)
    case .closureParamList:
      return visitImplClosureParamListSyntax(syntax)
    case .closureSignature:
      return visitImplClosureSignatureSyntax(syntax)
    case .closureExpr:
      return visitImplClosureExprSyntax(syntax)
    case .unresolvedPatternExpr:
      return visitImplUnresolvedPatternExprSyntax(syntax)
    case .multipleTrailingClosureElement:
      return visitImplMultipleTrailingClosureElementSyntax(syntax)
    case .multipleTrailingClosureElementList:
      return visitImplMultipleTrailingClosureElementListSyntax(syntax)
    case .functionCallExpr:
      return visitImplFunctionCallExprSyntax(syntax)
    case .subscriptExpr:
      return visitImplSubscriptExprSyntax(syntax)
    case .optionalChainingExpr:
      return visitImplOptionalChainingExprSyntax(syntax)
    case .forcedValueExpr:
      return visitImplForcedValueExprSyntax(syntax)
    case .postfixUnaryExpr:
      return visitImplPostfixUnaryExprSyntax(syntax)
    case .specializeExpr:
      return visitImplSpecializeExprSyntax(syntax)
    case .stringSegment:
      return visitImplStringSegmentSyntax(syntax)
    case .expressionSegment:
      return visitImplExpressionSegmentSyntax(syntax)
    case .stringLiteralExpr:
      return visitImplStringLiteralExprSyntax(syntax)
    case .regexLiteralExpr:
      return visitImplRegexLiteralExprSyntax(syntax)
    case .keyPathExpr:
      return visitImplKeyPathExprSyntax(syntax)
    case .keyPathBaseExpr:
      return visitImplKeyPathBaseExprSyntax(syntax)
    case .objcNamePiece:
      return visitImplObjcNamePieceSyntax(syntax)
    case .objcName:
      return visitImplObjcNameSyntax(syntax)
    case .objcKeyPathExpr:
      return visitImplObjcKeyPathExprSyntax(syntax)
    case .objcSelectorExpr:
      return visitImplObjcSelectorExprSyntax(syntax)
    case .postfixIfConfigExpr:
      return visitImplPostfixIfConfigExprSyntax(syntax)
    case .editorPlaceholderExpr:
      return visitImplEditorPlaceholderExprSyntax(syntax)
    case .objectLiteralExpr:
      return visitImplObjectLiteralExprSyntax(syntax)
    case .typeInitializerClause:
      return visitImplTypeInitializerClauseSyntax(syntax)
    case .typealiasDecl:
      return visitImplTypealiasDeclSyntax(syntax)
    case .associatedtypeDecl:
      return visitImplAssociatedtypeDeclSyntax(syntax)
    case .functionParameterList:
      return visitImplFunctionParameterListSyntax(syntax)
    case .parameterClause:
      return visitImplParameterClauseSyntax(syntax)
    case .returnClause:
      return visitImplReturnClauseSyntax(syntax)
    case .functionSignature:
      return visitImplFunctionSignatureSyntax(syntax)
    case .ifConfigClause:
      return visitImplIfConfigClauseSyntax(syntax)
    case .ifConfigClauseList:
      return visitImplIfConfigClauseListSyntax(syntax)
    case .ifConfigDecl:
      return visitImplIfConfigDeclSyntax(syntax)
    case .poundErrorDecl:
      return visitImplPoundErrorDeclSyntax(syntax)
    case .poundWarningDecl:
      return visitImplPoundWarningDeclSyntax(syntax)
    case .poundSourceLocation:
      return visitImplPoundSourceLocationSyntax(syntax)
    case .poundSourceLocationArgs:
      return visitImplPoundSourceLocationArgsSyntax(syntax)
    case .declModifierDetail:
      return visitImplDeclModifierDetailSyntax(syntax)
    case .declModifier:
      return visitImplDeclModifierSyntax(syntax)
    case .inheritedType:
      return visitImplInheritedTypeSyntax(syntax)
    case .inheritedTypeList:
      return visitImplInheritedTypeListSyntax(syntax)
    case .typeInheritanceClause:
      return visitImplTypeInheritanceClauseSyntax(syntax)
    case .classDecl:
      return visitImplClassDeclSyntax(syntax)
    case .actorDecl:
      return visitImplActorDeclSyntax(syntax)
    case .structDecl:
      return visitImplStructDeclSyntax(syntax)
    case .protocolDecl:
      return visitImplProtocolDeclSyntax(syntax)
    case .extensionDecl:
      return visitImplExtensionDeclSyntax(syntax)
    case .memberDeclBlock:
      return visitImplMemberDeclBlockSyntax(syntax)
    case .memberDeclList:
      return visitImplMemberDeclListSyntax(syntax)
    case .memberDeclListItem:
      return visitImplMemberDeclListItemSyntax(syntax)
    case .sourceFile:
      return visitImplSourceFileSyntax(syntax)
    case .initializerClause:
      return visitImplInitializerClauseSyntax(syntax)
    case .functionParameter:
      return visitImplFunctionParameterSyntax(syntax)
    case .modifierList:
      return visitImplModifierListSyntax(syntax)
    case .functionDecl:
      return visitImplFunctionDeclSyntax(syntax)
    case .initializerDecl:
      return visitImplInitializerDeclSyntax(syntax)
    case .deinitializerDecl:
      return visitImplDeinitializerDeclSyntax(syntax)
    case .subscriptDecl:
      return visitImplSubscriptDeclSyntax(syntax)
    case .accessLevelModifier:
      return visitImplAccessLevelModifierSyntax(syntax)
    case .accessPathComponent:
      return visitImplAccessPathComponentSyntax(syntax)
    case .accessPath:
      return visitImplAccessPathSyntax(syntax)
    case .importDecl:
      return visitImplImportDeclSyntax(syntax)
    case .accessorParameter:
      return visitImplAccessorParameterSyntax(syntax)
    case .accessorDecl:
      return visitImplAccessorDeclSyntax(syntax)
    case .accessorList:
      return visitImplAccessorListSyntax(syntax)
    case .accessorBlock:
      return visitImplAccessorBlockSyntax(syntax)
    case .patternBinding:
      return visitImplPatternBindingSyntax(syntax)
    case .patternBindingList:
      return visitImplPatternBindingListSyntax(syntax)
    case .variableDecl:
      return visitImplVariableDeclSyntax(syntax)
    case .enumCaseElement:
      return visitImplEnumCaseElementSyntax(syntax)
    case .enumCaseElementList:
      return visitImplEnumCaseElementListSyntax(syntax)
    case .enumCaseDecl:
      return visitImplEnumCaseDeclSyntax(syntax)
    case .enumDecl:
      return visitImplEnumDeclSyntax(syntax)
    case .operatorDecl:
      return visitImplOperatorDeclSyntax(syntax)
    case .identifierList:
      return visitImplIdentifierListSyntax(syntax)
    case .operatorPrecedenceAndTypes:
      return visitImplOperatorPrecedenceAndTypesSyntax(syntax)
    case .precedenceGroupDecl:
      return visitImplPrecedenceGroupDeclSyntax(syntax)
    case .precedenceGroupAttributeList:
      return visitImplPrecedenceGroupAttributeListSyntax(syntax)
    case .precedenceGroupRelation:
      return visitImplPrecedenceGroupRelationSyntax(syntax)
    case .precedenceGroupNameList:
      return visitImplPrecedenceGroupNameListSyntax(syntax)
    case .precedenceGroupNameElement:
      return visitImplPrecedenceGroupNameElementSyntax(syntax)
    case .precedenceGroupAssignment:
      return visitImplPrecedenceGroupAssignmentSyntax(syntax)
    case .precedenceGroupAssociativity:
      return visitImplPrecedenceGroupAssociativitySyntax(syntax)
    case .tokenList:
      return visitImplTokenListSyntax(syntax)
    case .nonEmptyTokenList:
      return visitImplNonEmptyTokenListSyntax(syntax)
    case .customAttribute:
      return visitImplCustomAttributeSyntax(syntax)
    case .attribute:
      return visitImplAttributeSyntax(syntax)
    case .attributeList:
      return visitImplAttributeListSyntax(syntax)
    case .specializeAttributeSpecList:
      return visitImplSpecializeAttributeSpecListSyntax(syntax)
    case .availabilityEntry:
      return visitImplAvailabilityEntrySyntax(syntax)
    case .labeledSpecializeEntry:
      return visitImplLabeledSpecializeEntrySyntax(syntax)
    case .targetFunctionEntry:
      return visitImplTargetFunctionEntrySyntax(syntax)
    case .namedAttributeStringArgument:
      return visitImplNamedAttributeStringArgumentSyntax(syntax)
    case .declName:
      return visitImplDeclNameSyntax(syntax)
    case .implementsAttributeArguments:
      return visitImplImplementsAttributeArgumentsSyntax(syntax)
    case .objCSelectorPiece:
      return visitImplObjCSelectorPieceSyntax(syntax)
    case .objCSelector:
      return visitImplObjCSelectorSyntax(syntax)
    case .differentiableAttributeArguments:
      return visitImplDifferentiableAttributeArgumentsSyntax(syntax)
    case .differentiabilityParamsClause:
      return visitImplDifferentiabilityParamsClauseSyntax(syntax)
    case .differentiabilityParams:
      return visitImplDifferentiabilityParamsSyntax(syntax)
    case .differentiabilityParamList:
      return visitImplDifferentiabilityParamListSyntax(syntax)
    case .differentiabilityParam:
      return visitImplDifferentiabilityParamSyntax(syntax)
    case .derivativeRegistrationAttributeArguments:
      return visitImplDerivativeRegistrationAttributeArgumentsSyntax(syntax)
    case .qualifiedDeclName:
      return visitImplQualifiedDeclNameSyntax(syntax)
    case .functionDeclName:
      return visitImplFunctionDeclNameSyntax(syntax)
    case .backDeployAttributeSpecList:
      return visitImplBackDeployAttributeSpecListSyntax(syntax)
    case .backDeployVersionList:
      return visitImplBackDeployVersionListSyntax(syntax)
    case .backDeployVersionArgument:
      return visitImplBackDeployVersionArgumentSyntax(syntax)
    case .continueStmt:
      return visitImplContinueStmtSyntax(syntax)
    case .whileStmt:
      return visitImplWhileStmtSyntax(syntax)
    case .deferStmt:
      return visitImplDeferStmtSyntax(syntax)
    case .expressionStmt:
      return visitImplExpressionStmtSyntax(syntax)
    case .switchCaseList:
      return visitImplSwitchCaseListSyntax(syntax)
    case .repeatWhileStmt:
      return visitImplRepeatWhileStmtSyntax(syntax)
    case .guardStmt:
      return visitImplGuardStmtSyntax(syntax)
    case .whereClause:
      return visitImplWhereClauseSyntax(syntax)
    case .forInStmt:
      return visitImplForInStmtSyntax(syntax)
    case .switchStmt:
      return visitImplSwitchStmtSyntax(syntax)
    case .catchClauseList:
      return visitImplCatchClauseListSyntax(syntax)
    case .doStmt:
      return visitImplDoStmtSyntax(syntax)
    case .returnStmt:
      return visitImplReturnStmtSyntax(syntax)
    case .yieldStmt:
      return visitImplYieldStmtSyntax(syntax)
    case .yieldList:
      return visitImplYieldListSyntax(syntax)
    case .fallthroughStmt:
      return visitImplFallthroughStmtSyntax(syntax)
    case .breakStmt:
      return visitImplBreakStmtSyntax(syntax)
    case .caseItemList:
      return visitImplCaseItemListSyntax(syntax)
    case .catchItemList:
      return visitImplCatchItemListSyntax(syntax)
    case .conditionElement:
      return visitImplConditionElementSyntax(syntax)
    case .availabilityCondition:
      return visitImplAvailabilityConditionSyntax(syntax)
    case .matchingPatternCondition:
      return visitImplMatchingPatternConditionSyntax(syntax)
    case .optionalBindingCondition:
      return visitImplOptionalBindingConditionSyntax(syntax)
    case .unavailabilityCondition:
      return visitImplUnavailabilityConditionSyntax(syntax)
    case .conditionElementList:
      return visitImplConditionElementListSyntax(syntax)
    case .declarationStmt:
      return visitImplDeclarationStmtSyntax(syntax)
    case .throwStmt:
      return visitImplThrowStmtSyntax(syntax)
    case .ifStmt:
      return visitImplIfStmtSyntax(syntax)
    case .elseIfContinuation:
      return visitImplElseIfContinuationSyntax(syntax)
    case .elseBlock:
      return visitImplElseBlockSyntax(syntax)
    case .switchCase:
      return visitImplSwitchCaseSyntax(syntax)
    case .switchDefaultLabel:
      return visitImplSwitchDefaultLabelSyntax(syntax)
    case .caseItem:
      return visitImplCaseItemSyntax(syntax)
    case .catchItem:
      return visitImplCatchItemSyntax(syntax)
    case .switchCaseLabel:
      return visitImplSwitchCaseLabelSyntax(syntax)
    case .catchClause:
      return visitImplCatchClauseSyntax(syntax)
    case .poundAssertStmt:
      return visitImplPoundAssertStmtSyntax(syntax)
    case .genericWhereClause:
      return visitImplGenericWhereClauseSyntax(syntax)
    case .genericRequirementList:
      return visitImplGenericRequirementListSyntax(syntax)
    case .genericRequirement:
      return visitImplGenericRequirementSyntax(syntax)
    case .sameTypeRequirement:
      return visitImplSameTypeRequirementSyntax(syntax)
    case .genericParameterList:
      return visitImplGenericParameterListSyntax(syntax)
    case .genericParameter:
      return visitImplGenericParameterSyntax(syntax)
    case .primaryAssociatedTypeList:
      return visitImplPrimaryAssociatedTypeListSyntax(syntax)
    case .primaryAssociatedType:
      return visitImplPrimaryAssociatedTypeSyntax(syntax)
    case .genericParameterClause:
      return visitImplGenericParameterClauseSyntax(syntax)
    case .conformanceRequirement:
      return visitImplConformanceRequirementSyntax(syntax)
    case .primaryAssociatedTypeClause:
      return visitImplPrimaryAssociatedTypeClauseSyntax(syntax)
    case .simpleTypeIdentifier:
      return visitImplSimpleTypeIdentifierSyntax(syntax)
    case .memberTypeIdentifier:
      return visitImplMemberTypeIdentifierSyntax(syntax)
    case .classRestrictionType:
      return visitImplClassRestrictionTypeSyntax(syntax)
    case .arrayType:
      return visitImplArrayTypeSyntax(syntax)
    case .dictionaryType:
      return visitImplDictionaryTypeSyntax(syntax)
    case .metatypeType:
      return visitImplMetatypeTypeSyntax(syntax)
    case .optionalType:
      return visitImplOptionalTypeSyntax(syntax)
    case .constrainedSugarType:
      return visitImplConstrainedSugarTypeSyntax(syntax)
    case .implicitlyUnwrappedOptionalType:
      return visitImplImplicitlyUnwrappedOptionalTypeSyntax(syntax)
    case .compositionTypeElement:
      return visitImplCompositionTypeElementSyntax(syntax)
    case .compositionTypeElementList:
      return visitImplCompositionTypeElementListSyntax(syntax)
    case .compositionType:
      return visitImplCompositionTypeSyntax(syntax)
    case .tupleTypeElement:
      return visitImplTupleTypeElementSyntax(syntax)
    case .tupleTypeElementList:
      return visitImplTupleTypeElementListSyntax(syntax)
    case .tupleType:
      return visitImplTupleTypeSyntax(syntax)
    case .functionType:
      return visitImplFunctionTypeSyntax(syntax)
    case .attributedType:
      return visitImplAttributedTypeSyntax(syntax)
    case .genericArgumentList:
      return visitImplGenericArgumentListSyntax(syntax)
    case .genericArgument:
      return visitImplGenericArgumentSyntax(syntax)
    case .genericArgumentClause:
      return visitImplGenericArgumentClauseSyntax(syntax)
    case .typeAnnotation:
      return visitImplTypeAnnotationSyntax(syntax)
    case .enumCasePattern:
      return visitImplEnumCasePatternSyntax(syntax)
    case .isTypePattern:
      return visitImplIsTypePatternSyntax(syntax)
    case .optionalPattern:
      return visitImplOptionalPatternSyntax(syntax)
    case .identifierPattern:
      return visitImplIdentifierPatternSyntax(syntax)
    case .asTypePattern:
      return visitImplAsTypePatternSyntax(syntax)
    case .tuplePattern:
      return visitImplTuplePatternSyntax(syntax)
    case .wildcardPattern:
      return visitImplWildcardPatternSyntax(syntax)
    case .tuplePatternElement:
      return visitImplTuplePatternElementSyntax(syntax)
    case .expressionPattern:
      return visitImplExpressionPatternSyntax(syntax)
    case .tuplePatternElementList:
      return visitImplTuplePatternElementListSyntax(syntax)
    case .valueBindingPattern:
      return visitImplValueBindingPatternSyntax(syntax)
    case .availabilitySpecList:
      return visitImplAvailabilitySpecListSyntax(syntax)
    case .availabilityArgument:
      return visitImplAvailabilityArgumentSyntax(syntax)
    case .availabilityLabeledArgument:
      return visitImplAvailabilityLabeledArgumentSyntax(syntax)
    case .availabilityVersionRestriction:
      return visitImplAvailabilityVersionRestrictionSyntax(syntax)
    case .versionTuple:
      return visitImplVersionTupleSyntax(syntax)
    }
  }

#endif

  private func visitChildren<SyntaxType: SyntaxProtocol>(
    _ node: SyntaxType
  ) -> SyntaxType {
    // Walk over all children of this node and rewrite them. Don't store any
    // rewritten nodes until the first non-`nil` value is encountered. When this
    // happens, retrieve all previous syntax nodes from the parent node to
    // initialize the new layout. Once we know that we have to rewrite the
    // layout, we need to collect all futher children, regardless of whether
    // they are rewritten or not.

    // newLayout is nil until the first child node is rewritten and rewritten
    // nodes are being collected.
    var newLayout: ContiguousArray<RawSyntax?>?

    for child in node.children {
      let rewritten = visit(child)
      if rewritten.raw.id != child.raw.id {
        // The node was rewritten, let's handle it
        if newLayout == nil {
          // We have not yet collected any previous rewritten nodes. Initialize
          // the new layout with the previous nodes of the parent. This is
          // possible, since we know they were not rewritten.

          // The below implementation is based on Collection.map but directly
          // reserves enough capacity for the entire layout.
          newLayout = ContiguousArray<RawSyntax?>()
          newLayout!.reserveCapacity(node.raw.children.count)
          for j in 0 ..< child.indexInParent! {
            newLayout?.append(node.raw.children[j])
          }
        }

        // Now that we know we have a new layout in which we collect rewritten
        // nodes, add it.
        newLayout!.append(rewritten.raw)
      } else {
        // The node was not changed by the rewriter. Only store it if a previous
        // node has been rewritten and we are collecting a rewritten layout.
        if newLayout != nil {
          newLayout!.append(child.raw)
        }
      }
    }

    if let newLayout = newLayout {
      // A child node was rewritten. Build the updated node.

      // Sanity check, ensure the new children are the same length.
      assert(newLayout.count == node.raw.children.count)


      let arena = node.arena
      let newRaw = node.raw.replacingLayout(with: newLayout, arena: arena)
      return SyntaxType(Syntax(raw: newRaw, arena: arena))!
    } else {
      // No child node was rewritten. So no need to change this node as well.
      return node
    }
  }
}
