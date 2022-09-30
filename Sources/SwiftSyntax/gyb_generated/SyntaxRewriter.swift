//// Automatically Generated From SyntaxRewriter.swift.gyb.
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

  /// Visit a `MissingSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `MissingDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingDeclSyntax) -> DeclSyntax {
    return DeclSyntax(visitChildren(node))
  }

  /// Visit a `MissingExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `MissingStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
  }

  /// Visit a `MissingTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
  }

  /// Visit a `MissingPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingPatternSyntax) -> PatternSyntax {
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

  /// Visit a `UnexpectedNodesSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnexpectedNodesSyntax) -> Syntax {
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

  /// Visit a `MoveExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MoveExprSyntax) -> ExprSyntax {
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

  /// Visit a `InfixOperatorExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InfixOperatorExprSyntax) -> ExprSyntax {
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

  /// Visit a `UnresolvedTernaryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedTernaryExprSyntax) -> ExprSyntax {
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

  /// Visit a `UnresolvedIsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedIsExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `IsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IsExprSyntax) -> ExprSyntax {
    return ExprSyntax(visitChildren(node))
  }

  /// Visit a `UnresolvedAsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedAsExprSyntax) -> ExprSyntax {
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

  /// Visit a `KeyPathComponentListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathComponentListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `KeyPathComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathComponentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `KeyPathPropertyComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathPropertyComponentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `KeyPathSubscriptComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathSubscriptComponentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `KeyPathOptionalComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathOptionalComponentSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `OldKeyPathExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OldKeyPathExprSyntax) -> ExprSyntax {
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

  /// Visit a `YieldExprListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldExprListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `YieldExprListElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldExprListElementSyntax) -> Syntax {
    return Syntax(visitChildren(node))
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

  /// Visit a `DesignatedTypeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DesignatedTypeListSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `DesignatedTypeElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DesignatedTypeElementSyntax) -> Syntax {
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

  /// Visit a `OpaqueReturnTypeOfAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OpaqueReturnTypeOfAttributeArgumentsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ConventionAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConventionAttributeArgumentsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `ConventionWitnessMethodAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConventionWitnessMethodAttributeArgumentsSyntax) -> Syntax {
    return Syntax(visitChildren(node))
  }

  /// Visit a `LabeledStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: LabeledStmtSyntax) -> StmtSyntax {
    return StmtSyntax(visitChildren(node))
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

  /// Visit a `HasSymbolConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: HasSymbolConditionSyntax) -> Syntax {
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

  /// Visit a `LayoutRequirementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: LayoutRequirementSyntax) -> Syntax {
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

  /// Visit a `PackExpansionTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PackExpansionTypeSyntax) -> TypeSyntax {
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

  /// Visit a `NamedOpaqueReturnTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NamedOpaqueReturnTypeSyntax) -> TypeSyntax {
    return TypeSyntax(visitChildren(node))
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
  public func visit(_ node: Syntax) -> Syntax {
    return visit(node.data)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingSyntax(_ data: SyntaxData) -> Syntax {
      let node = MissingSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = MissingDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = MissingExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = MissingStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = MissingTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = MissingPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = CodeBlockItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockItemListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CodeBlockItemListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockSyntax(_ data: SyntaxData) -> Syntax {
      let node = CodeBlockSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnexpectedNodesSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnexpectedNodesSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInOutExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = InOutExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundColumnExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundColumnExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleExprElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrayElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = DictionaryElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringLiteralSegmentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = StringLiteralSegmentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = TryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAwaitExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = AwaitExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMoveExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = MoveExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclNameArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentListSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclNameArgumentListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclNameArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = IdentifierExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSuperRefExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SuperRefExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNilLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = NilLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDiscardAssignmentExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = DiscardAssignmentExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAssignmentExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = AssignmentExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSequenceExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SequenceExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExprListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExprListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundLineExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundLineExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFileExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundFileExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFileIDExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundFileIDExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFilePathExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundFilePathExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFunctionExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundFunctionExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundDsohandleExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundDsohandleExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSymbolicReferenceExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SymbolicReferenceExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrefixOperatorExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrefixOperatorExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBinaryOperatorExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = BinaryOperatorExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrowExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrowExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInfixOperatorExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = InfixOperatorExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFloatLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = FloatLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrayExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = DictionaryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleExprElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrayElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = DictionaryElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIntegerLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = IntegerLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBooleanLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = BooleanLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedTernaryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnresolvedTernaryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTernaryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = TernaryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberAccessExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberAccessExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedIsExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnresolvedIsExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIsExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = IsExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedAsExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnresolvedAsExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAsExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = AsExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypeExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureCaptureItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureItemListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureCaptureItemListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureSignatureSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureCaptureSignatureSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureParamSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureParamSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureParamListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureParamListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureSignatureSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureSignatureSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedPatternExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnresolvedPatternExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = MultipleTrailingClosureElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = MultipleTrailingClosureElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionCallExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionCallExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSubscriptExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SubscriptExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalChainingExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = OptionalChainingExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplForcedValueExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ForcedValueExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPostfixUnaryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PostfixUnaryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSpecializeExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SpecializeExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringSegmentSyntax(_ data: SyntaxData) -> Syntax {
      let node = StringSegmentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionSegmentSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExpressionSegmentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = StringLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplRegexLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = RegexLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathComponentListSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathComponentListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathComponentSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathPropertyComponentSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathPropertyComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathSubscriptComponentSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathSubscriptComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathOptionalComponentSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathOptionalComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOldKeyPathExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = OldKeyPathExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathBaseExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathBaseExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcNamePieceSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjcNamePieceSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcNameSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjcNameSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcKeyPathExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjcKeyPathExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcSelectorExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjcSelectorExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPostfixIfConfigExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PostfixIfConfigExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEditorPlaceholderExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = EditorPlaceholderExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjectLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjectLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldExprListSyntax(_ data: SyntaxData) -> Syntax {
      let node = YieldExprListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldExprListElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = YieldExprListElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeInitializerClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypeInitializerClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypealiasDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypealiasDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAssociatedtypeDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = AssociatedtypeDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionParameterListSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionParameterListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplParameterClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = ParameterClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplReturnClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = ReturnClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionSignatureSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionSignatureSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = IfConfigClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigClauseListSyntax(_ data: SyntaxData) -> Syntax {
      let node = IfConfigClauseListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = IfConfigDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundErrorDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundErrorDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundWarningDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundWarningDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundSourceLocationSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundSourceLocationSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundSourceLocationArgsSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundSourceLocationArgsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclModifierDetailSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclModifierDetailSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclModifierSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclModifierSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInheritedTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = InheritedTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInheritedTypeListSyntax(_ data: SyntaxData) -> Syntax {
      let node = InheritedTypeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeInheritanceClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypeInheritanceClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClassDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClassDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplActorDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ActorDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStructDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = StructDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplProtocolDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ProtocolDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExtensionDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExtensionDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclBlockSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberDeclBlockSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclListSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberDeclListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclListItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberDeclListItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSourceFileSyntax(_ data: SyntaxData) -> Syntax {
      let node = SourceFileSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInitializerClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = InitializerClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionParameterSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionParameterSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplModifierListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ModifierListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInitializerDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = InitializerDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeinitializerDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeinitializerDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSubscriptDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = SubscriptDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessLevelModifierSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessLevelModifierSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessPathComponentSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessPathComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessPathSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessPathSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImportDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ImportDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorParameterSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessorParameterSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessorDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorListSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessorListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorBlockSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessorBlockSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternBindingSyntax(_ data: SyntaxData) -> Syntax {
      let node = PatternBindingSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternBindingListSyntax(_ data: SyntaxData) -> Syntax {
      let node = PatternBindingListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplVariableDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = VariableDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumCaseElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumCaseElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumCaseDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOperatorDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = OperatorDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDesignatedTypeListSyntax(_ data: SyntaxData) -> Syntax {
      let node = DesignatedTypeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDesignatedTypeElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = DesignatedTypeElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOperatorPrecedenceAndTypesSyntax(_ data: SyntaxData) -> Syntax {
      let node = OperatorPrecedenceAndTypesSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAttributeListSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupAttributeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupRelationSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupRelationSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupNameListSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupNameListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupNameElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupNameElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAssignmentSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupAssignmentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAssociativitySyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupAssociativitySyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTokenListSyntax(_ data: SyntaxData) -> Syntax {
      let node = TokenListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNonEmptyTokenListSyntax(_ data: SyntaxData) -> Syntax {
      let node = NonEmptyTokenListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCustomAttributeSyntax(_ data: SyntaxData) -> Syntax {
      let node = CustomAttributeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributeSyntax(_ data: SyntaxData) -> Syntax {
      let node = AttributeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributeListSyntax(_ data: SyntaxData) -> Syntax {
      let node = AttributeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSpecializeAttributeSpecListSyntax(_ data: SyntaxData) -> Syntax {
      let node = SpecializeAttributeSpecListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityEntrySyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityEntrySyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplLabeledSpecializeEntrySyntax(_ data: SyntaxData) -> Syntax {
      let node = LabeledSpecializeEntrySyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTargetFunctionEntrySyntax(_ data: SyntaxData) -> Syntax {
      let node = TargetFunctionEntrySyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNamedAttributeStringArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = NamedAttributeStringArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclNameSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImplementsAttributeArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = ImplementsAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjCSelectorPieceSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjCSelectorPieceSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjCSelectorSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjCSelectorSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiableAttributeArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = DifferentiableAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamsClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = DifferentiabilityParamsClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamsSyntax(_ data: SyntaxData) -> Syntax {
      let node = DifferentiabilityParamsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamListSyntax(_ data: SyntaxData) -> Syntax {
      let node = DifferentiabilityParamListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamSyntax(_ data: SyntaxData) -> Syntax {
      let node = DifferentiabilityParamSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDerivativeRegistrationAttributeArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = DerivativeRegistrationAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplQualifiedDeclNameSyntax(_ data: SyntaxData) -> Syntax {
      let node = QualifiedDeclNameSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionDeclNameSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionDeclNameSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployAttributeSpecListSyntax(_ data: SyntaxData) -> Syntax {
      let node = BackDeployAttributeSpecListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployVersionListSyntax(_ data: SyntaxData) -> Syntax {
      let node = BackDeployVersionListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployVersionArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = BackDeployVersionArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOpaqueReturnTypeOfAttributeArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = OpaqueReturnTypeOfAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConventionAttributeArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConventionAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConventionWitnessMethodAttributeArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConventionWitnessMethodAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplLabeledStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = LabeledStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplContinueStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ContinueStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWhileStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = WhileStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeferStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeferStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExpressionStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseListSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchCaseListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplRepeatWhileStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = RepeatWhileStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGuardStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = GuardStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWhereClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = WhereClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplForInStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ForInStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchClauseListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CatchClauseListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDoStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = DoStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplReturnStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ReturnStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = YieldStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldListSyntax(_ data: SyntaxData) -> Syntax {
      let node = YieldListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFallthroughStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = FallthroughStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBreakStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = BreakStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCaseItemListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CaseItemListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchItemListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CatchItemListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConditionElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConditionElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityConditionSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMatchingPatternConditionSyntax(_ data: SyntaxData) -> Syntax {
      let node = MatchingPatternConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalBindingConditionSyntax(_ data: SyntaxData) -> Syntax {
      let node = OptionalBindingConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnavailabilityConditionSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnavailabilityConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplHasSymbolConditionSyntax(_ data: SyntaxData) -> Syntax {
      let node = HasSymbolConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConditionElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConditionElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclarationStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclarationStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplThrowStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ThrowStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = IfStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplElseIfContinuationSyntax(_ data: SyntaxData) -> Syntax {
      let node = ElseIfContinuationSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplElseBlockSyntax(_ data: SyntaxData) -> Syntax {
      let node = ElseBlockSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchCaseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchDefaultLabelSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchDefaultLabelSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCaseItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = CaseItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = CatchItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseLabelSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchCaseLabelSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = CatchClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundAssertStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundAssertStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericWhereClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericWhereClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericRequirementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericRequirementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericRequirementSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericRequirementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSameTypeRequirementSyntax(_ data: SyntaxData) -> Syntax {
      let node = SameTypeRequirementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplLayoutRequirementSyntax(_ data: SyntaxData) -> Syntax {
      let node = LayoutRequirementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterListSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericParameterListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericParameterSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeListSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrimaryAssociatedTypeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrimaryAssociatedTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericParameterClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConformanceRequirementSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConformanceRequirementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrimaryAssociatedTypeClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSimpleTypeIdentifierSyntax(_ data: SyntaxData) -> Syntax {
      let node = SimpleTypeIdentifierSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberTypeIdentifierSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberTypeIdentifierSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClassRestrictionTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClassRestrictionTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrayTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = DictionaryTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMetatypeTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = MetatypeTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = OptionalTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConstrainedSugarTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConstrainedSugarTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImplicitlyUnwrappedOptionalTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = CompositionTypeElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CompositionTypeElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = CompositionTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPackExpansionTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = PackExpansionTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleTypeElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleTypeElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributedTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = AttributedTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentListSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericArgumentListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericArgumentClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNamedOpaqueReturnTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = NamedOpaqueReturnTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeAnnotationSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypeAnnotationSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCasePatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumCasePatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIsTypePatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = IsTypePatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = OptionalPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = IdentifierPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAsTypePatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = AsTypePatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = TuplePatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWildcardPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = WildcardPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = TuplePatternElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExpressionPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = TuplePatternElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplValueBindingPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = ValueBindingPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return Syntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilitySpecListSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilitySpecListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityLabeledArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityLabeledArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityVersionRestrictionSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityVersionRestrictionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplVersionTupleSyntax(_ data: SyntaxData) -> Syntax {
      let node = VersionTupleSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
  }


  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTokenSyntax(_ data: SyntaxData) -> Syntax {
    let node = TokenSyntax(data)
    // Accessing _syntaxNode directly is faster than calling Syntax(node)
    visitPre(node._syntaxNode)
    defer { visitPost(node._syntaxNode) }
    if let newNode = visitAny(node._syntaxNode) { return newNode }
    return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownSyntax(_ data: SyntaxData) -> Syntax {
    let node = UnknownSyntax(data)
    // Accessing _syntaxNode directly is faster than calling Syntax(node)
    visitPre(node._syntaxNode)
    defer { visitPost(node._syntaxNode) }
    if let newNode = visitAny(node._syntaxNode) { return newNode }
    return visit(node)
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
  private func visitationFunc(for data: SyntaxData) -> ((SyntaxData) -> Syntax) {
    switch data.raw.kind {
    case .token:
      return visitImplTokenSyntax
    case .unknown:
      return visitImplUnknownSyntax
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
    case .missing:
      return visitImplMissingSyntax
    case .missingDecl:
      return visitImplMissingDeclSyntax
    case .missingExpr:
      return visitImplMissingExprSyntax
    case .missingStmt:
      return visitImplMissingStmtSyntax
    case .missingType:
      return visitImplMissingTypeSyntax
    case .missingPattern:
      return visitImplMissingPatternSyntax
    case .codeBlockItem:
      return visitImplCodeBlockItemSyntax
    case .codeBlockItemList:
      return visitImplCodeBlockItemListSyntax
    case .codeBlock:
      return visitImplCodeBlockSyntax
    case .unexpectedNodes:
      return visitImplUnexpectedNodesSyntax
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
    case .moveExpr:
      return visitImplMoveExprSyntax
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
    case .infixOperatorExpr:
      return visitImplInfixOperatorExprSyntax
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
    case .unresolvedTernaryExpr:
      return visitImplUnresolvedTernaryExprSyntax
    case .ternaryExpr:
      return visitImplTernaryExprSyntax
    case .memberAccessExpr:
      return visitImplMemberAccessExprSyntax
    case .unresolvedIsExpr:
      return visitImplUnresolvedIsExprSyntax
    case .isExpr:
      return visitImplIsExprSyntax
    case .unresolvedAsExpr:
      return visitImplUnresolvedAsExprSyntax
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
    case .keyPathComponentList:
      return visitImplKeyPathComponentListSyntax
    case .keyPathComponent:
      return visitImplKeyPathComponentSyntax
    case .keyPathPropertyComponent:
      return visitImplKeyPathPropertyComponentSyntax
    case .keyPathSubscriptComponent:
      return visitImplKeyPathSubscriptComponentSyntax
    case .keyPathOptionalComponent:
      return visitImplKeyPathOptionalComponentSyntax
    case .oldKeyPathExpr:
      return visitImplOldKeyPathExprSyntax
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
    case .yieldExprList:
      return visitImplYieldExprListSyntax
    case .yieldExprListElement:
      return visitImplYieldExprListElementSyntax
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
    case .designatedTypeList:
      return visitImplDesignatedTypeListSyntax
    case .designatedTypeElement:
      return visitImplDesignatedTypeElementSyntax
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
    case .opaqueReturnTypeOfAttributeArguments:
      return visitImplOpaqueReturnTypeOfAttributeArgumentsSyntax
    case .conventionAttributeArguments:
      return visitImplConventionAttributeArgumentsSyntax
    case .conventionWitnessMethodAttributeArguments:
      return visitImplConventionWitnessMethodAttributeArgumentsSyntax
    case .labeledStmt:
      return visitImplLabeledStmtSyntax
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
    case .hasSymbolCondition:
      return visitImplHasSymbolConditionSyntax
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
    case .layoutRequirement:
      return visitImplLayoutRequirementSyntax
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
    case .packExpansionType:
      return visitImplPackExpansionTypeSyntax
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
    case .namedOpaqueReturnType:
      return visitImplNamedOpaqueReturnTypeSyntax
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

  private func visit(_ data: SyntaxData) -> Syntax {
    return visitationFunc(for: data)(data)
  }

#else

  private func visit(_ data: SyntaxData) -> Syntax {
    switch data.raw.kind {
    case .token:
      return visitImplTokenSyntax(data)
    case .unknown:
      return visitImplUnknownSyntax(data)
    case .unknownDecl:
      return visitImplUnknownDeclSyntax(data)
    case .unknownExpr:
      return visitImplUnknownExprSyntax(data)
    case .unknownStmt:
      return visitImplUnknownStmtSyntax(data)
    case .unknownType:
      return visitImplUnknownTypeSyntax(data)
    case .unknownPattern:
      return visitImplUnknownPatternSyntax(data)
    case .missing:
      return visitImplMissingSyntax(data)
    case .missingDecl:
      return visitImplMissingDeclSyntax(data)
    case .missingExpr:
      return visitImplMissingExprSyntax(data)
    case .missingStmt:
      return visitImplMissingStmtSyntax(data)
    case .missingType:
      return visitImplMissingTypeSyntax(data)
    case .missingPattern:
      return visitImplMissingPatternSyntax(data)
    case .codeBlockItem:
      return visitImplCodeBlockItemSyntax(data)
    case .codeBlockItemList:
      return visitImplCodeBlockItemListSyntax(data)
    case .codeBlock:
      return visitImplCodeBlockSyntax(data)
    case .unexpectedNodes:
      return visitImplUnexpectedNodesSyntax(data)
    case .inOutExpr:
      return visitImplInOutExprSyntax(data)
    case .poundColumnExpr:
      return visitImplPoundColumnExprSyntax(data)
    case .tupleExprElementList:
      return visitImplTupleExprElementListSyntax(data)
    case .arrayElementList:
      return visitImplArrayElementListSyntax(data)
    case .dictionaryElementList:
      return visitImplDictionaryElementListSyntax(data)
    case .stringLiteralSegments:
      return visitImplStringLiteralSegmentsSyntax(data)
    case .tryExpr:
      return visitImplTryExprSyntax(data)
    case .awaitExpr:
      return visitImplAwaitExprSyntax(data)
    case .moveExpr:
      return visitImplMoveExprSyntax(data)
    case .declNameArgument:
      return visitImplDeclNameArgumentSyntax(data)
    case .declNameArgumentList:
      return visitImplDeclNameArgumentListSyntax(data)
    case .declNameArguments:
      return visitImplDeclNameArgumentsSyntax(data)
    case .identifierExpr:
      return visitImplIdentifierExprSyntax(data)
    case .superRefExpr:
      return visitImplSuperRefExprSyntax(data)
    case .nilLiteralExpr:
      return visitImplNilLiteralExprSyntax(data)
    case .discardAssignmentExpr:
      return visitImplDiscardAssignmentExprSyntax(data)
    case .assignmentExpr:
      return visitImplAssignmentExprSyntax(data)
    case .sequenceExpr:
      return visitImplSequenceExprSyntax(data)
    case .exprList:
      return visitImplExprListSyntax(data)
    case .poundLineExpr:
      return visitImplPoundLineExprSyntax(data)
    case .poundFileExpr:
      return visitImplPoundFileExprSyntax(data)
    case .poundFileIDExpr:
      return visitImplPoundFileIDExprSyntax(data)
    case .poundFilePathExpr:
      return visitImplPoundFilePathExprSyntax(data)
    case .poundFunctionExpr:
      return visitImplPoundFunctionExprSyntax(data)
    case .poundDsohandleExpr:
      return visitImplPoundDsohandleExprSyntax(data)
    case .symbolicReferenceExpr:
      return visitImplSymbolicReferenceExprSyntax(data)
    case .prefixOperatorExpr:
      return visitImplPrefixOperatorExprSyntax(data)
    case .binaryOperatorExpr:
      return visitImplBinaryOperatorExprSyntax(data)
    case .arrowExpr:
      return visitImplArrowExprSyntax(data)
    case .infixOperatorExpr:
      return visitImplInfixOperatorExprSyntax(data)
    case .floatLiteralExpr:
      return visitImplFloatLiteralExprSyntax(data)
    case .tupleExpr:
      return visitImplTupleExprSyntax(data)
    case .arrayExpr:
      return visitImplArrayExprSyntax(data)
    case .dictionaryExpr:
      return visitImplDictionaryExprSyntax(data)
    case .tupleExprElement:
      return visitImplTupleExprElementSyntax(data)
    case .arrayElement:
      return visitImplArrayElementSyntax(data)
    case .dictionaryElement:
      return visitImplDictionaryElementSyntax(data)
    case .integerLiteralExpr:
      return visitImplIntegerLiteralExprSyntax(data)
    case .booleanLiteralExpr:
      return visitImplBooleanLiteralExprSyntax(data)
    case .unresolvedTernaryExpr:
      return visitImplUnresolvedTernaryExprSyntax(data)
    case .ternaryExpr:
      return visitImplTernaryExprSyntax(data)
    case .memberAccessExpr:
      return visitImplMemberAccessExprSyntax(data)
    case .unresolvedIsExpr:
      return visitImplUnresolvedIsExprSyntax(data)
    case .isExpr:
      return visitImplIsExprSyntax(data)
    case .unresolvedAsExpr:
      return visitImplUnresolvedAsExprSyntax(data)
    case .asExpr:
      return visitImplAsExprSyntax(data)
    case .typeExpr:
      return visitImplTypeExprSyntax(data)
    case .closureCaptureItem:
      return visitImplClosureCaptureItemSyntax(data)
    case .closureCaptureItemList:
      return visitImplClosureCaptureItemListSyntax(data)
    case .closureCaptureSignature:
      return visitImplClosureCaptureSignatureSyntax(data)
    case .closureParam:
      return visitImplClosureParamSyntax(data)
    case .closureParamList:
      return visitImplClosureParamListSyntax(data)
    case .closureSignature:
      return visitImplClosureSignatureSyntax(data)
    case .closureExpr:
      return visitImplClosureExprSyntax(data)
    case .unresolvedPatternExpr:
      return visitImplUnresolvedPatternExprSyntax(data)
    case .multipleTrailingClosureElement:
      return visitImplMultipleTrailingClosureElementSyntax(data)
    case .multipleTrailingClosureElementList:
      return visitImplMultipleTrailingClosureElementListSyntax(data)
    case .functionCallExpr:
      return visitImplFunctionCallExprSyntax(data)
    case .subscriptExpr:
      return visitImplSubscriptExprSyntax(data)
    case .optionalChainingExpr:
      return visitImplOptionalChainingExprSyntax(data)
    case .forcedValueExpr:
      return visitImplForcedValueExprSyntax(data)
    case .postfixUnaryExpr:
      return visitImplPostfixUnaryExprSyntax(data)
    case .specializeExpr:
      return visitImplSpecializeExprSyntax(data)
    case .stringSegment:
      return visitImplStringSegmentSyntax(data)
    case .expressionSegment:
      return visitImplExpressionSegmentSyntax(data)
    case .stringLiteralExpr:
      return visitImplStringLiteralExprSyntax(data)
    case .regexLiteralExpr:
      return visitImplRegexLiteralExprSyntax(data)
    case .keyPathExpr:
      return visitImplKeyPathExprSyntax(data)
    case .keyPathComponentList:
      return visitImplKeyPathComponentListSyntax(data)
    case .keyPathComponent:
      return visitImplKeyPathComponentSyntax(data)
    case .keyPathPropertyComponent:
      return visitImplKeyPathPropertyComponentSyntax(data)
    case .keyPathSubscriptComponent:
      return visitImplKeyPathSubscriptComponentSyntax(data)
    case .keyPathOptionalComponent:
      return visitImplKeyPathOptionalComponentSyntax(data)
    case .oldKeyPathExpr:
      return visitImplOldKeyPathExprSyntax(data)
    case .keyPathBaseExpr:
      return visitImplKeyPathBaseExprSyntax(data)
    case .objcNamePiece:
      return visitImplObjcNamePieceSyntax(data)
    case .objcName:
      return visitImplObjcNameSyntax(data)
    case .objcKeyPathExpr:
      return visitImplObjcKeyPathExprSyntax(data)
    case .objcSelectorExpr:
      return visitImplObjcSelectorExprSyntax(data)
    case .postfixIfConfigExpr:
      return visitImplPostfixIfConfigExprSyntax(data)
    case .editorPlaceholderExpr:
      return visitImplEditorPlaceholderExprSyntax(data)
    case .objectLiteralExpr:
      return visitImplObjectLiteralExprSyntax(data)
    case .yieldExprList:
      return visitImplYieldExprListSyntax(data)
    case .yieldExprListElement:
      return visitImplYieldExprListElementSyntax(data)
    case .typeInitializerClause:
      return visitImplTypeInitializerClauseSyntax(data)
    case .typealiasDecl:
      return visitImplTypealiasDeclSyntax(data)
    case .associatedtypeDecl:
      return visitImplAssociatedtypeDeclSyntax(data)
    case .functionParameterList:
      return visitImplFunctionParameterListSyntax(data)
    case .parameterClause:
      return visitImplParameterClauseSyntax(data)
    case .returnClause:
      return visitImplReturnClauseSyntax(data)
    case .functionSignature:
      return visitImplFunctionSignatureSyntax(data)
    case .ifConfigClause:
      return visitImplIfConfigClauseSyntax(data)
    case .ifConfigClauseList:
      return visitImplIfConfigClauseListSyntax(data)
    case .ifConfigDecl:
      return visitImplIfConfigDeclSyntax(data)
    case .poundErrorDecl:
      return visitImplPoundErrorDeclSyntax(data)
    case .poundWarningDecl:
      return visitImplPoundWarningDeclSyntax(data)
    case .poundSourceLocation:
      return visitImplPoundSourceLocationSyntax(data)
    case .poundSourceLocationArgs:
      return visitImplPoundSourceLocationArgsSyntax(data)
    case .declModifierDetail:
      return visitImplDeclModifierDetailSyntax(data)
    case .declModifier:
      return visitImplDeclModifierSyntax(data)
    case .inheritedType:
      return visitImplInheritedTypeSyntax(data)
    case .inheritedTypeList:
      return visitImplInheritedTypeListSyntax(data)
    case .typeInheritanceClause:
      return visitImplTypeInheritanceClauseSyntax(data)
    case .classDecl:
      return visitImplClassDeclSyntax(data)
    case .actorDecl:
      return visitImplActorDeclSyntax(data)
    case .structDecl:
      return visitImplStructDeclSyntax(data)
    case .protocolDecl:
      return visitImplProtocolDeclSyntax(data)
    case .extensionDecl:
      return visitImplExtensionDeclSyntax(data)
    case .memberDeclBlock:
      return visitImplMemberDeclBlockSyntax(data)
    case .memberDeclList:
      return visitImplMemberDeclListSyntax(data)
    case .memberDeclListItem:
      return visitImplMemberDeclListItemSyntax(data)
    case .sourceFile:
      return visitImplSourceFileSyntax(data)
    case .initializerClause:
      return visitImplInitializerClauseSyntax(data)
    case .functionParameter:
      return visitImplFunctionParameterSyntax(data)
    case .modifierList:
      return visitImplModifierListSyntax(data)
    case .functionDecl:
      return visitImplFunctionDeclSyntax(data)
    case .initializerDecl:
      return visitImplInitializerDeclSyntax(data)
    case .deinitializerDecl:
      return visitImplDeinitializerDeclSyntax(data)
    case .subscriptDecl:
      return visitImplSubscriptDeclSyntax(data)
    case .accessLevelModifier:
      return visitImplAccessLevelModifierSyntax(data)
    case .accessPathComponent:
      return visitImplAccessPathComponentSyntax(data)
    case .accessPath:
      return visitImplAccessPathSyntax(data)
    case .importDecl:
      return visitImplImportDeclSyntax(data)
    case .accessorParameter:
      return visitImplAccessorParameterSyntax(data)
    case .accessorDecl:
      return visitImplAccessorDeclSyntax(data)
    case .accessorList:
      return visitImplAccessorListSyntax(data)
    case .accessorBlock:
      return visitImplAccessorBlockSyntax(data)
    case .patternBinding:
      return visitImplPatternBindingSyntax(data)
    case .patternBindingList:
      return visitImplPatternBindingListSyntax(data)
    case .variableDecl:
      return visitImplVariableDeclSyntax(data)
    case .enumCaseElement:
      return visitImplEnumCaseElementSyntax(data)
    case .enumCaseElementList:
      return visitImplEnumCaseElementListSyntax(data)
    case .enumCaseDecl:
      return visitImplEnumCaseDeclSyntax(data)
    case .enumDecl:
      return visitImplEnumDeclSyntax(data)
    case .operatorDecl:
      return visitImplOperatorDeclSyntax(data)
    case .designatedTypeList:
      return visitImplDesignatedTypeListSyntax(data)
    case .designatedTypeElement:
      return visitImplDesignatedTypeElementSyntax(data)
    case .operatorPrecedenceAndTypes:
      return visitImplOperatorPrecedenceAndTypesSyntax(data)
    case .precedenceGroupDecl:
      return visitImplPrecedenceGroupDeclSyntax(data)
    case .precedenceGroupAttributeList:
      return visitImplPrecedenceGroupAttributeListSyntax(data)
    case .precedenceGroupRelation:
      return visitImplPrecedenceGroupRelationSyntax(data)
    case .precedenceGroupNameList:
      return visitImplPrecedenceGroupNameListSyntax(data)
    case .precedenceGroupNameElement:
      return visitImplPrecedenceGroupNameElementSyntax(data)
    case .precedenceGroupAssignment:
      return visitImplPrecedenceGroupAssignmentSyntax(data)
    case .precedenceGroupAssociativity:
      return visitImplPrecedenceGroupAssociativitySyntax(data)
    case .tokenList:
      return visitImplTokenListSyntax(data)
    case .nonEmptyTokenList:
      return visitImplNonEmptyTokenListSyntax(data)
    case .customAttribute:
      return visitImplCustomAttributeSyntax(data)
    case .attribute:
      return visitImplAttributeSyntax(data)
    case .attributeList:
      return visitImplAttributeListSyntax(data)
    case .specializeAttributeSpecList:
      return visitImplSpecializeAttributeSpecListSyntax(data)
    case .availabilityEntry:
      return visitImplAvailabilityEntrySyntax(data)
    case .labeledSpecializeEntry:
      return visitImplLabeledSpecializeEntrySyntax(data)
    case .targetFunctionEntry:
      return visitImplTargetFunctionEntrySyntax(data)
    case .namedAttributeStringArgument:
      return visitImplNamedAttributeStringArgumentSyntax(data)
    case .declName:
      return visitImplDeclNameSyntax(data)
    case .implementsAttributeArguments:
      return visitImplImplementsAttributeArgumentsSyntax(data)
    case .objCSelectorPiece:
      return visitImplObjCSelectorPieceSyntax(data)
    case .objCSelector:
      return visitImplObjCSelectorSyntax(data)
    case .differentiableAttributeArguments:
      return visitImplDifferentiableAttributeArgumentsSyntax(data)
    case .differentiabilityParamsClause:
      return visitImplDifferentiabilityParamsClauseSyntax(data)
    case .differentiabilityParams:
      return visitImplDifferentiabilityParamsSyntax(data)
    case .differentiabilityParamList:
      return visitImplDifferentiabilityParamListSyntax(data)
    case .differentiabilityParam:
      return visitImplDifferentiabilityParamSyntax(data)
    case .derivativeRegistrationAttributeArguments:
      return visitImplDerivativeRegistrationAttributeArgumentsSyntax(data)
    case .qualifiedDeclName:
      return visitImplQualifiedDeclNameSyntax(data)
    case .functionDeclName:
      return visitImplFunctionDeclNameSyntax(data)
    case .backDeployAttributeSpecList:
      return visitImplBackDeployAttributeSpecListSyntax(data)
    case .backDeployVersionList:
      return visitImplBackDeployVersionListSyntax(data)
    case .backDeployVersionArgument:
      return visitImplBackDeployVersionArgumentSyntax(data)
    case .opaqueReturnTypeOfAttributeArguments:
      return visitImplOpaqueReturnTypeOfAttributeArgumentsSyntax(data)
    case .conventionAttributeArguments:
      return visitImplConventionAttributeArgumentsSyntax(data)
    case .conventionWitnessMethodAttributeArguments:
      return visitImplConventionWitnessMethodAttributeArgumentsSyntax(data)
    case .labeledStmt:
      return visitImplLabeledStmtSyntax(data)
    case .continueStmt:
      return visitImplContinueStmtSyntax(data)
    case .whileStmt:
      return visitImplWhileStmtSyntax(data)
    case .deferStmt:
      return visitImplDeferStmtSyntax(data)
    case .expressionStmt:
      return visitImplExpressionStmtSyntax(data)
    case .switchCaseList:
      return visitImplSwitchCaseListSyntax(data)
    case .repeatWhileStmt:
      return visitImplRepeatWhileStmtSyntax(data)
    case .guardStmt:
      return visitImplGuardStmtSyntax(data)
    case .whereClause:
      return visitImplWhereClauseSyntax(data)
    case .forInStmt:
      return visitImplForInStmtSyntax(data)
    case .switchStmt:
      return visitImplSwitchStmtSyntax(data)
    case .catchClauseList:
      return visitImplCatchClauseListSyntax(data)
    case .doStmt:
      return visitImplDoStmtSyntax(data)
    case .returnStmt:
      return visitImplReturnStmtSyntax(data)
    case .yieldStmt:
      return visitImplYieldStmtSyntax(data)
    case .yieldList:
      return visitImplYieldListSyntax(data)
    case .fallthroughStmt:
      return visitImplFallthroughStmtSyntax(data)
    case .breakStmt:
      return visitImplBreakStmtSyntax(data)
    case .caseItemList:
      return visitImplCaseItemListSyntax(data)
    case .catchItemList:
      return visitImplCatchItemListSyntax(data)
    case .conditionElement:
      return visitImplConditionElementSyntax(data)
    case .availabilityCondition:
      return visitImplAvailabilityConditionSyntax(data)
    case .matchingPatternCondition:
      return visitImplMatchingPatternConditionSyntax(data)
    case .optionalBindingCondition:
      return visitImplOptionalBindingConditionSyntax(data)
    case .unavailabilityCondition:
      return visitImplUnavailabilityConditionSyntax(data)
    case .hasSymbolCondition:
      return visitImplHasSymbolConditionSyntax(data)
    case .conditionElementList:
      return visitImplConditionElementListSyntax(data)
    case .declarationStmt:
      return visitImplDeclarationStmtSyntax(data)
    case .throwStmt:
      return visitImplThrowStmtSyntax(data)
    case .ifStmt:
      return visitImplIfStmtSyntax(data)
    case .elseIfContinuation:
      return visitImplElseIfContinuationSyntax(data)
    case .elseBlock:
      return visitImplElseBlockSyntax(data)
    case .switchCase:
      return visitImplSwitchCaseSyntax(data)
    case .switchDefaultLabel:
      return visitImplSwitchDefaultLabelSyntax(data)
    case .caseItem:
      return visitImplCaseItemSyntax(data)
    case .catchItem:
      return visitImplCatchItemSyntax(data)
    case .switchCaseLabel:
      return visitImplSwitchCaseLabelSyntax(data)
    case .catchClause:
      return visitImplCatchClauseSyntax(data)
    case .poundAssertStmt:
      return visitImplPoundAssertStmtSyntax(data)
    case .genericWhereClause:
      return visitImplGenericWhereClauseSyntax(data)
    case .genericRequirementList:
      return visitImplGenericRequirementListSyntax(data)
    case .genericRequirement:
      return visitImplGenericRequirementSyntax(data)
    case .sameTypeRequirement:
      return visitImplSameTypeRequirementSyntax(data)
    case .layoutRequirement:
      return visitImplLayoutRequirementSyntax(data)
    case .genericParameterList:
      return visitImplGenericParameterListSyntax(data)
    case .genericParameter:
      return visitImplGenericParameterSyntax(data)
    case .primaryAssociatedTypeList:
      return visitImplPrimaryAssociatedTypeListSyntax(data)
    case .primaryAssociatedType:
      return visitImplPrimaryAssociatedTypeSyntax(data)
    case .genericParameterClause:
      return visitImplGenericParameterClauseSyntax(data)
    case .conformanceRequirement:
      return visitImplConformanceRequirementSyntax(data)
    case .primaryAssociatedTypeClause:
      return visitImplPrimaryAssociatedTypeClauseSyntax(data)
    case .simpleTypeIdentifier:
      return visitImplSimpleTypeIdentifierSyntax(data)
    case .memberTypeIdentifier:
      return visitImplMemberTypeIdentifierSyntax(data)
    case .classRestrictionType:
      return visitImplClassRestrictionTypeSyntax(data)
    case .arrayType:
      return visitImplArrayTypeSyntax(data)
    case .dictionaryType:
      return visitImplDictionaryTypeSyntax(data)
    case .metatypeType:
      return visitImplMetatypeTypeSyntax(data)
    case .optionalType:
      return visitImplOptionalTypeSyntax(data)
    case .constrainedSugarType:
      return visitImplConstrainedSugarTypeSyntax(data)
    case .implicitlyUnwrappedOptionalType:
      return visitImplImplicitlyUnwrappedOptionalTypeSyntax(data)
    case .compositionTypeElement:
      return visitImplCompositionTypeElementSyntax(data)
    case .compositionTypeElementList:
      return visitImplCompositionTypeElementListSyntax(data)
    case .compositionType:
      return visitImplCompositionTypeSyntax(data)
    case .packExpansionType:
      return visitImplPackExpansionTypeSyntax(data)
    case .tupleTypeElement:
      return visitImplTupleTypeElementSyntax(data)
    case .tupleTypeElementList:
      return visitImplTupleTypeElementListSyntax(data)
    case .tupleType:
      return visitImplTupleTypeSyntax(data)
    case .functionType:
      return visitImplFunctionTypeSyntax(data)
    case .attributedType:
      return visitImplAttributedTypeSyntax(data)
    case .genericArgumentList:
      return visitImplGenericArgumentListSyntax(data)
    case .genericArgument:
      return visitImplGenericArgumentSyntax(data)
    case .genericArgumentClause:
      return visitImplGenericArgumentClauseSyntax(data)
    case .namedOpaqueReturnType:
      return visitImplNamedOpaqueReturnTypeSyntax(data)
    case .typeAnnotation:
      return visitImplTypeAnnotationSyntax(data)
    case .enumCasePattern:
      return visitImplEnumCasePatternSyntax(data)
    case .isTypePattern:
      return visitImplIsTypePatternSyntax(data)
    case .optionalPattern:
      return visitImplOptionalPatternSyntax(data)
    case .identifierPattern:
      return visitImplIdentifierPatternSyntax(data)
    case .asTypePattern:
      return visitImplAsTypePatternSyntax(data)
    case .tuplePattern:
      return visitImplTuplePatternSyntax(data)
    case .wildcardPattern:
      return visitImplWildcardPatternSyntax(data)
    case .tuplePatternElement:
      return visitImplTuplePatternElementSyntax(data)
    case .expressionPattern:
      return visitImplExpressionPatternSyntax(data)
    case .tuplePatternElementList:
      return visitImplTuplePatternElementListSyntax(data)
    case .valueBindingPattern:
      return visitImplValueBindingPatternSyntax(data)
    case .availabilitySpecList:
      return visitImplAvailabilitySpecListSyntax(data)
    case .availabilityArgument:
      return visitImplAvailabilityArgumentSyntax(data)
    case .availabilityLabeledArgument:
      return visitImplAvailabilityLabeledArgumentSyntax(data)
    case .availabilityVersionRestriction:
      return visitImplAvailabilityVersionRestrictionSyntax(data)
    case .versionTuple:
      return visitImplVersionTupleSyntax(data)
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

    // Rewritten children just to keep their 'SyntaxArena' alive until they are
    // wrapped with 'Syntax'
    var rewrittens: ContiguousArray<Syntax> = []

    let syntaxNode = node._syntaxNode

    // Incrementing i manually is faster than using .enumerated()
    var childIndex = 0
    for (raw, info) in RawSyntaxChildren(syntaxNode) {
      defer { childIndex += 1 }
      guard let child = raw else {
        // Node does not exist. If we are collecting rewritten nodes, we need to 
        // collect this one as well, otherwise we can ignore it.
        if newLayout != nil {
          newLayout!.append(nil)
        }
        continue
      }

      // Build the Syntax node to rewrite
      let absoluteRaw = AbsoluteRawSyntax(raw: child, info: info)
      let data = SyntaxData(absoluteRaw, parent: syntaxNode)
      
      let rewritten = visit(data)
      if rewritten.data.nodeId != info.nodeId {
        // The node was rewritten, let's handle it
        if newLayout == nil {
          // We have not yet collected any previous rewritten nodes. Initialize
          // the new layout with the previous nodes of the parent. This is 
          // possible, since we know they were not rewritten.
          
          // The below implementation is based on Collection.map but directly
          // reserves enough capacity for the entire layout.
          newLayout = ContiguousArray<RawSyntax?>()
          newLayout!.reserveCapacity(node.raw.layoutView!.children.count)
          for j in 0..<childIndex {
            newLayout!.append(node.raw.layoutView!.children[j])
          }
        }
        
        // Now that we know we have a new layout in which we collect rewritten 
        // nodes, add it.
        rewrittens.append(rewritten)
        newLayout!.append(rewritten.raw)
      } else {
        // The node was not changed by the rewriter. Only store it if a previous
        // node has been rewritten and we are collecting a rewritten layout.
        if newLayout != nil {
          newLayout!.append(raw)
        }
      }
    }

    if let newLayout = newLayout {
      // A child node was rewritten. Build the updated node.

      // Sanity check, ensure the new children are the same length.
      assert(newLayout.count == node.raw.layoutView!.children.count)

      let newRaw = node.raw.layoutView!.replacingLayout(with: Array(newLayout), arena: .default)
      // 'withExtendedLifetime' to keep 'SyntaxArena's of them alive until here.
      return withExtendedLifetime(rewrittens) {
        SyntaxType(Syntax(SyntaxData.forRoot(newRaw)))!
      }
    } else {
      // No child node was rewritten. So no need to change this node as well.
      return node
    }

  }
}
