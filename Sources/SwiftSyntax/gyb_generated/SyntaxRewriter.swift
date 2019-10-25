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

  /// Visit a `LabeledSpecializeEntrySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> Syntax {
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

  /// Visit a `SomeTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SomeTypeSyntax) -> TypeSyntax {
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
  private func visitImplIsExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = IsExprSyntax(data)
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
  private func visitImplKeyPathExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathExprSyntax(data)
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
  private func visitImplIdentifierListSyntax(_ data: SyntaxData) -> Syntax {
      let node = IdentifierListSyntax(data)
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
  private func visitImplLabeledSpecializeEntrySyntax(_ data: SyntaxData) -> Syntax {
      let node = LabeledSpecializeEntrySyntax(data)
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
  private func visitImplSomeTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = SomeTypeSyntax(data)
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


  private func visit(_ data: SyntaxData) -> Syntax {
    switch data.raw.kind {
    case .token:
      let node = TokenSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
    case .unknown:
      let node = UnknownSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return visit(node)
    // The implementation of every generated case goes into its own function. This
    // circumvents an issue where the compiler allocates stack space for every
    // case statement next to each other in debug builds, causing it to allocate
    // ~50KB per call to this function. rdar://55929175
    case .decl:
      return visitImplDeclSyntax(data)
    case .expr:
      return visitImplExprSyntax(data)
    case .stmt:
      return visitImplStmtSyntax(data)
    case .type:
      return visitImplTypeSyntax(data)
    case .pattern:
      return visitImplPatternSyntax(data)
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
    case .codeBlockItem:
      return visitImplCodeBlockItemSyntax(data)
    case .codeBlockItemList:
      return visitImplCodeBlockItemListSyntax(data)
    case .codeBlock:
      return visitImplCodeBlockSyntax(data)
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
    case .ternaryExpr:
      return visitImplTernaryExprSyntax(data)
    case .memberAccessExpr:
      return visitImplMemberAccessExprSyntax(data)
    case .isExpr:
      return visitImplIsExprSyntax(data)
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
    case .keyPathExpr:
      return visitImplKeyPathExprSyntax(data)
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
    case .editorPlaceholderExpr:
      return visitImplEditorPlaceholderExprSyntax(data)
    case .objectLiteralExpr:
      return visitImplObjectLiteralExprSyntax(data)
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
    case .identifierList:
      return visitImplIdentifierListSyntax(data)
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
    case .labeledSpecializeEntry:
      return visitImplLabeledSpecializeEntrySyntax(data)
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
    case .conditionElement:
      return visitImplConditionElementSyntax(data)
    case .availabilityCondition:
      return visitImplAvailabilityConditionSyntax(data)
    case .matchingPatternCondition:
      return visitImplMatchingPatternConditionSyntax(data)
    case .optionalBindingCondition:
      return visitImplOptionalBindingConditionSyntax(data)
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
    case .genericParameterList:
      return visitImplGenericParameterListSyntax(data)
    case .genericParameter:
      return visitImplGenericParameterSyntax(data)
    case .genericParameterClause:
      return visitImplGenericParameterClauseSyntax(data)
    case .conformanceRequirement:
      return visitImplConformanceRequirementSyntax(data)
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
    case .someType:
      return visitImplSomeTypeSyntax(data)
    case .implicitlyUnwrappedOptionalType:
      return visitImplImplicitlyUnwrappedOptionalTypeSyntax(data)
    case .compositionTypeElement:
      return visitImplCompositionTypeElementSyntax(data)
    case .compositionTypeElementList:
      return visitImplCompositionTypeElementListSyntax(data)
    case .compositionType:
      return visitImplCompositionTypeSyntax(data)
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

    let syntaxNode = node._syntaxNode
    let parentBox = SyntaxBox(syntaxNode)

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
      let data = SyntaxData(absoluteRaw, parentBox: parentBox)
      
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
          newLayout!.reserveCapacity(node.raw.numberOfChildren)
          for j in 0..<childIndex {
            newLayout!.append(node.raw.child(at: j))
          }
        }
        
        // Now that we know we have a new layout in which we collect rewritten 
        // nodes, add it.
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
      assert(newLayout.count == node.raw.numberOfChildren)
      
      let newRaw = node.raw.replacingLayout(Array(newLayout))
      return SyntaxType(Syntax(SyntaxData.forRoot(newRaw)))!
    } else {
      // No child node was rewritten. So no need to change this node as well.
      return node
    }

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

open class SyntaxVisitor {
  public init() {}

  /// Walk all nodes of the given syntax tree, calling the corresponding `visit` 
  /// function for every node that is being visited.
  public func walk<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) {
    visit(node.data)
  }

  /// Visiting `UnknownDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnknownDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnknownDeclSyntax) {}
  /// Visiting `UnknownExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnknownExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnknownExprSyntax) {}
  /// Visiting `UnknownStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnknownStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnknownStmtSyntax) {}
  /// Visiting `UnknownTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnknownTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnknownTypeSyntax) {}
  /// Visiting `UnknownPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnknownPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnknownPatternSyntax) {}
  /// Visiting `CodeBlockItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CodeBlockItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CodeBlockItemSyntax) {}
  /// Visiting `CodeBlockItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CodeBlockItemListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CodeBlockItemListSyntax) {}
  /// Visiting `CodeBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CodeBlockSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CodeBlockSyntax) {}
  /// Visiting `InOutExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `InOutExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: InOutExprSyntax) {}
  /// Visiting `PoundColumnExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundColumnExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundColumnExprSyntax) {}
  /// Visiting `TupleExprElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleExprElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TupleExprElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TupleExprElementListSyntax) {}
  /// Visiting `ArrayElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ArrayElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ArrayElementListSyntax) {}
  /// Visiting `DictionaryElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DictionaryElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DictionaryElementListSyntax) {}
  /// Visiting `StringLiteralSegmentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StringLiteralSegmentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `StringLiteralSegmentsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: StringLiteralSegmentsSyntax) {}
  /// Visiting `TryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TryExprSyntax) {}
  /// Visiting `DeclNameArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeclNameArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeclNameArgumentSyntax) {}
  /// Visiting `DeclNameArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeclNameArgumentListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeclNameArgumentListSyntax) {}
  /// Visiting `DeclNameArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeclNameArgumentsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeclNameArgumentsSyntax) {}
  /// Visiting `IdentifierExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IdentifierExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IdentifierExprSyntax) {}
  /// Visiting `SuperRefExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SuperRefExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SuperRefExprSyntax) {}
  /// Visiting `NilLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `NilLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: NilLiteralExprSyntax) {}
  /// Visiting `DiscardAssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DiscardAssignmentExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DiscardAssignmentExprSyntax) {}
  /// Visiting `AssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AssignmentExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AssignmentExprSyntax) {}
  /// Visiting `SequenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SequenceExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SequenceExprSyntax) {}
  /// Visiting `ExprListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ExprListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ExprListSyntax) {}
  /// Visiting `PoundLineExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundLineExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundLineExprSyntax) {}
  /// Visiting `PoundFileExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundFileExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundFileExprSyntax) {}
  /// Visiting `PoundFunctionExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundFunctionExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundFunctionExprSyntax) {}
  /// Visiting `PoundDsohandleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundDsohandleExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundDsohandleExprSyntax) {}
  /// Visiting `SymbolicReferenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SymbolicReferenceExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SymbolicReferenceExprSyntax) {}
  /// Visiting `PrefixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrefixOperatorExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrefixOperatorExprSyntax) {}
  /// Visiting `BinaryOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `BinaryOperatorExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: BinaryOperatorExprSyntax) {}
  /// Visiting `ArrowExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ArrowExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ArrowExprSyntax) {}
  /// Visiting `FloatLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FloatLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FloatLiteralExprSyntax) {}
  /// Visiting `TupleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TupleExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TupleExprSyntax) {}
  /// Visiting `ArrayExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ArrayExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ArrayExprSyntax) {}
  /// Visiting `DictionaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DictionaryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DictionaryExprSyntax) {}
  /// Visiting `TupleExprElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleExprElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TupleExprElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TupleExprElementSyntax) {}
  /// Visiting `ArrayElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ArrayElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ArrayElementSyntax) {}
  /// Visiting `DictionaryElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DictionaryElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DictionaryElementSyntax) {}
  /// Visiting `IntegerLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IntegerLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IntegerLiteralExprSyntax) {}
  /// Visiting `BooleanLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `BooleanLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: BooleanLiteralExprSyntax) {}
  /// Visiting `TernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TernaryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TernaryExprSyntax) {}
  /// Visiting `MemberAccessExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MemberAccessExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MemberAccessExprSyntax) {}
  /// Visiting `IsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IsExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IsExprSyntax) {}
  /// Visiting `AsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AsExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AsExprSyntax) {}
  /// Visiting `TypeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TypeExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TypeExprSyntax) {}
  /// Visiting `ClosureCaptureItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClosureCaptureItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClosureCaptureItemSyntax) {}
  /// Visiting `ClosureCaptureItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClosureCaptureItemListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClosureCaptureItemListSyntax) {}
  /// Visiting `ClosureCaptureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClosureCaptureSignatureSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClosureCaptureSignatureSyntax) {}
  /// Visiting `ClosureParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClosureParamSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClosureParamSyntax) {}
  /// Visiting `ClosureParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClosureParamListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClosureParamListSyntax) {}
  /// Visiting `ClosureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClosureSignatureSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClosureSignatureSyntax) {}
  /// Visiting `ClosureExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClosureExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClosureExprSyntax) {}
  /// Visiting `UnresolvedPatternExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnresolvedPatternExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnresolvedPatternExprSyntax) {}
  /// Visiting `FunctionCallExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FunctionCallExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FunctionCallExprSyntax) {}
  /// Visiting `SubscriptExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SubscriptExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SubscriptExprSyntax) {}
  /// Visiting `OptionalChainingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `OptionalChainingExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: OptionalChainingExprSyntax) {}
  /// Visiting `ForcedValueExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ForcedValueExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ForcedValueExprSyntax) {}
  /// Visiting `PostfixUnaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PostfixUnaryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PostfixUnaryExprSyntax) {}
  /// Visiting `SpecializeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SpecializeExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SpecializeExprSyntax) {}
  /// Visiting `StringSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `StringSegmentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: StringSegmentSyntax) {}
  /// Visiting `ExpressionSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ExpressionSegmentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ExpressionSegmentSyntax) {}
  /// Visiting `StringLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `StringLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: StringLiteralExprSyntax) {}
  /// Visiting `KeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `KeyPathExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: KeyPathExprSyntax) {}
  /// Visiting `KeyPathBaseExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `KeyPathBaseExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: KeyPathBaseExprSyntax) {}
  /// Visiting `ObjcNamePieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ObjcNamePieceSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ObjcNamePieceSyntax) {}
  /// Visiting `ObjcNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ObjcNameSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ObjcNameSyntax) {}
  /// Visiting `ObjcKeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ObjcKeyPathExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ObjcKeyPathExprSyntax) {}
  /// Visiting `ObjcSelectorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ObjcSelectorExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ObjcSelectorExprSyntax) {}
  /// Visiting `EditorPlaceholderExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `EditorPlaceholderExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: EditorPlaceholderExprSyntax) {}
  /// Visiting `ObjectLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ObjectLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ObjectLiteralExprSyntax) {}
  /// Visiting `TypeInitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TypeInitializerClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TypeInitializerClauseSyntax) {}
  /// Visiting `TypealiasDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TypealiasDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TypealiasDeclSyntax) {}
  /// Visiting `AssociatedtypeDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AssociatedtypeDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AssociatedtypeDeclSyntax) {}
  /// Visiting `FunctionParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FunctionParameterListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FunctionParameterListSyntax) {}
  /// Visiting `ParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ParameterClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ParameterClauseSyntax) {}
  /// Visiting `ReturnClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ReturnClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ReturnClauseSyntax) {}
  /// Visiting `FunctionSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FunctionSignatureSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FunctionSignatureSyntax) {}
  /// Visiting `IfConfigClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IfConfigClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IfConfigClauseSyntax) {}
  /// Visiting `IfConfigClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IfConfigClauseListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IfConfigClauseListSyntax) {}
  /// Visiting `IfConfigDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IfConfigDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IfConfigDeclSyntax) {}
  /// Visiting `PoundErrorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundErrorDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundErrorDeclSyntax) {}
  /// Visiting `PoundWarningDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundWarningDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundWarningDeclSyntax) {}
  /// Visiting `PoundSourceLocationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundSourceLocationSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundSourceLocationSyntax) {}
  /// Visiting `PoundSourceLocationArgsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundSourceLocationArgsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundSourceLocationArgsSyntax) {}
  /// Visiting `DeclModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeclModifierSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeclModifierSyntax) {}
  /// Visiting `InheritedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `InheritedTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: InheritedTypeSyntax) {}
  /// Visiting `InheritedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `InheritedTypeListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: InheritedTypeListSyntax) {}
  /// Visiting `TypeInheritanceClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TypeInheritanceClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TypeInheritanceClauseSyntax) {}
  /// Visiting `ClassDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClassDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClassDeclSyntax) {}
  /// Visiting `StructDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `StructDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: StructDeclSyntax) {}
  /// Visiting `ProtocolDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ProtocolDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ProtocolDeclSyntax) {}
  /// Visiting `ExtensionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ExtensionDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ExtensionDeclSyntax) {}
  /// Visiting `MemberDeclBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MemberDeclBlockSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MemberDeclBlockSyntax) {}
  /// Visiting `MemberDeclListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MemberDeclListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MemberDeclListSyntax) {}
  /// Visiting `MemberDeclListItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MemberDeclListItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MemberDeclListItemSyntax) {}
  /// Visiting `SourceFileSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SourceFileSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SourceFileSyntax) {}
  /// Visiting `InitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `InitializerClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: InitializerClauseSyntax) {}
  /// Visiting `FunctionParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FunctionParameterSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FunctionParameterSyntax) {}
  /// Visiting `ModifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ModifierListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ModifierListSyntax) {}
  /// Visiting `FunctionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FunctionDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FunctionDeclSyntax) {}
  /// Visiting `InitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `InitializerDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: InitializerDeclSyntax) {}
  /// Visiting `DeinitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeinitializerDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeinitializerDeclSyntax) {}
  /// Visiting `SubscriptDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SubscriptDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SubscriptDeclSyntax) {}
  /// Visiting `AccessLevelModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AccessLevelModifierSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AccessLevelModifierSyntax) {}
  /// Visiting `AccessPathComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AccessPathComponentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AccessPathComponentSyntax) {}
  /// Visiting `AccessPathSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AccessPathSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AccessPathSyntax) {}
  /// Visiting `ImportDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ImportDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ImportDeclSyntax) {}
  /// Visiting `AccessorParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AccessorParameterSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AccessorParameterSyntax) {}
  /// Visiting `AccessorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AccessorDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AccessorDeclSyntax) {}
  /// Visiting `AccessorListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AccessorListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AccessorListSyntax) {}
  /// Visiting `AccessorBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AccessorBlockSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AccessorBlockSyntax) {}
  /// Visiting `PatternBindingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PatternBindingSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PatternBindingSyntax) {}
  /// Visiting `PatternBindingListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PatternBindingListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PatternBindingListSyntax) {}
  /// Visiting `VariableDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `VariableDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: VariableDeclSyntax) {}
  /// Visiting `EnumCaseElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `EnumCaseElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: EnumCaseElementSyntax) {}
  /// Visiting `EnumCaseElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `EnumCaseElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: EnumCaseElementListSyntax) {}
  /// Visiting `EnumCaseDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `EnumCaseDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: EnumCaseDeclSyntax) {}
  /// Visiting `EnumDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `EnumDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: EnumDeclSyntax) {}
  /// Visiting `OperatorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `OperatorDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: OperatorDeclSyntax) {}
  /// Visiting `IdentifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IdentifierListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IdentifierListSyntax) {}
  /// Visiting `OperatorPrecedenceAndTypesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `OperatorPrecedenceAndTypesSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: OperatorPrecedenceAndTypesSyntax) {}
  /// Visiting `PrecedenceGroupDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrecedenceGroupDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrecedenceGroupDeclSyntax) {}
  /// Visiting `PrecedenceGroupAttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrecedenceGroupAttributeListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrecedenceGroupAttributeListSyntax) {}
  /// Visiting `PrecedenceGroupRelationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrecedenceGroupRelationSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrecedenceGroupRelationSyntax) {}
  /// Visiting `PrecedenceGroupNameListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrecedenceGroupNameListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrecedenceGroupNameListSyntax) {}
  /// Visiting `PrecedenceGroupNameElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrecedenceGroupNameElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrecedenceGroupNameElementSyntax) {}
  /// Visiting `PrecedenceGroupAssignmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrecedenceGroupAssignmentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrecedenceGroupAssignmentSyntax) {}
  /// Visiting `PrecedenceGroupAssociativitySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrecedenceGroupAssociativitySyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrecedenceGroupAssociativitySyntax) {}
  /// Visiting `TokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TokenListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TokenListSyntax) {}
  /// Visiting `NonEmptyTokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `NonEmptyTokenListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: NonEmptyTokenListSyntax) {}
  /// Visiting `CustomAttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CustomAttributeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CustomAttributeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CustomAttributeSyntax) {}
  /// Visiting `AttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AttributeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AttributeSyntax) {}
  /// Visiting `AttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AttributeListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AttributeListSyntax) {}
  /// Visiting `SpecializeAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SpecializeAttributeSpecListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SpecializeAttributeSpecListSyntax) {}
  /// Visiting `LabeledSpecializeEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `LabeledSpecializeEntrySyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: LabeledSpecializeEntrySyntax) {}
  /// Visiting `NamedAttributeStringArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `NamedAttributeStringArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: NamedAttributeStringArgumentSyntax) {}
  /// Visiting `DeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeclNameSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeclNameSyntax) {}
  /// Visiting `ImplementsAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ImplementsAttributeArgumentsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ImplementsAttributeArgumentsSyntax) {}
  /// Visiting `ObjCSelectorPieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ObjCSelectorPieceSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ObjCSelectorPieceSyntax) {}
  /// Visiting `ObjCSelectorSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ObjCSelectorSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ObjCSelectorSyntax) {}
  /// Visiting `ContinueStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ContinueStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ContinueStmtSyntax) {}
  /// Visiting `WhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `WhileStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: WhileStmtSyntax) {}
  /// Visiting `DeferStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeferStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeferStmtSyntax) {}
  /// Visiting `ExpressionStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ExpressionStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ExpressionStmtSyntax) {}
  /// Visiting `SwitchCaseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SwitchCaseListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SwitchCaseListSyntax) {}
  /// Visiting `RepeatWhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `RepeatWhileStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: RepeatWhileStmtSyntax) {}
  /// Visiting `GuardStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GuardStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GuardStmtSyntax) {}
  /// Visiting `WhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `WhereClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: WhereClauseSyntax) {}
  /// Visiting `ForInStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ForInStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ForInStmtSyntax) {}
  /// Visiting `SwitchStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SwitchStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SwitchStmtSyntax) {}
  /// Visiting `CatchClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CatchClauseListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CatchClauseListSyntax) {}
  /// Visiting `DoStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DoStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DoStmtSyntax) {}
  /// Visiting `ReturnStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ReturnStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ReturnStmtSyntax) {}
  /// Visiting `YieldStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `YieldStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: YieldStmtSyntax) {}
  /// Visiting `YieldListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `YieldListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: YieldListSyntax) {}
  /// Visiting `FallthroughStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FallthroughStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FallthroughStmtSyntax) {}
  /// Visiting `BreakStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `BreakStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: BreakStmtSyntax) {}
  /// Visiting `CaseItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CaseItemListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CaseItemListSyntax) {}
  /// Visiting `ConditionElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ConditionElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ConditionElementSyntax) {}
  /// Visiting `AvailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AvailabilityConditionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AvailabilityConditionSyntax) {}
  /// Visiting `MatchingPatternConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MatchingPatternConditionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MatchingPatternConditionSyntax) {}
  /// Visiting `OptionalBindingConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `OptionalBindingConditionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: OptionalBindingConditionSyntax) {}
  /// Visiting `ConditionElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ConditionElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ConditionElementListSyntax) {}
  /// Visiting `DeclarationStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeclarationStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeclarationStmtSyntax) {}
  /// Visiting `ThrowStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ThrowStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ThrowStmtSyntax) {}
  /// Visiting `IfStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IfStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IfStmtSyntax) {}
  /// Visiting `ElseIfContinuationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ElseIfContinuationSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ElseIfContinuationSyntax) {}
  /// Visiting `ElseBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ElseBlockSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ElseBlockSyntax) {}
  /// Visiting `SwitchCaseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SwitchCaseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SwitchCaseSyntax) {}
  /// Visiting `SwitchDefaultLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SwitchDefaultLabelSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SwitchDefaultLabelSyntax) {}
  /// Visiting `CaseItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CaseItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CaseItemSyntax) {}
  /// Visiting `SwitchCaseLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SwitchCaseLabelSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SwitchCaseLabelSyntax) {}
  /// Visiting `CatchClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CatchClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CatchClauseSyntax) {}
  /// Visiting `PoundAssertStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundAssertStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundAssertStmtSyntax) {}
  /// Visiting `GenericWhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericWhereClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericWhereClauseSyntax) {}
  /// Visiting `GenericRequirementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericRequirementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericRequirementListSyntax) {}
  /// Visiting `GenericRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericRequirementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericRequirementSyntax) {}
  /// Visiting `SameTypeRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SameTypeRequirementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SameTypeRequirementSyntax) {}
  /// Visiting `GenericParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericParameterListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericParameterListSyntax) {}
  /// Visiting `GenericParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericParameterSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericParameterSyntax) {}
  /// Visiting `GenericParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericParameterClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericParameterClauseSyntax) {}
  /// Visiting `ConformanceRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ConformanceRequirementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ConformanceRequirementSyntax) {}
  /// Visiting `SimpleTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SimpleTypeIdentifierSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SimpleTypeIdentifierSyntax) {}
  /// Visiting `MemberTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MemberTypeIdentifierSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MemberTypeIdentifierSyntax) {}
  /// Visiting `ClassRestrictionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ClassRestrictionTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ClassRestrictionTypeSyntax) {}
  /// Visiting `ArrayTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ArrayTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ArrayTypeSyntax) {}
  /// Visiting `DictionaryTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DictionaryTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DictionaryTypeSyntax) {}
  /// Visiting `MetatypeTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MetatypeTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MetatypeTypeSyntax) {}
  /// Visiting `OptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `OptionalTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: OptionalTypeSyntax) {}
  /// Visiting `SomeTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: SomeTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `SomeTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: SomeTypeSyntax) {}
  /// Visiting `ImplicitlyUnwrappedOptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ImplicitlyUnwrappedOptionalTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) {}
  /// Visiting `CompositionTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CompositionTypeElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CompositionTypeElementSyntax) {}
  /// Visiting `CompositionTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CompositionTypeElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CompositionTypeElementListSyntax) {}
  /// Visiting `CompositionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CompositionTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CompositionTypeSyntax) {}
  /// Visiting `TupleTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TupleTypeElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TupleTypeElementSyntax) {}
  /// Visiting `TupleTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TupleTypeElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TupleTypeElementListSyntax) {}
  /// Visiting `TupleTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TupleTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TupleTypeSyntax) {}
  /// Visiting `FunctionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FunctionTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FunctionTypeSyntax) {}
  /// Visiting `AttributedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AttributedTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AttributedTypeSyntax) {}
  /// Visiting `GenericArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericArgumentListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericArgumentListSyntax) {}
  /// Visiting `GenericArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericArgumentSyntax) {}
  /// Visiting `GenericArgumentClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `GenericArgumentClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: GenericArgumentClauseSyntax) {}
  /// Visiting `TypeAnnotationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TypeAnnotationSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TypeAnnotationSyntax) {}
  /// Visiting `EnumCasePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `EnumCasePatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: EnumCasePatternSyntax) {}
  /// Visiting `IsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IsTypePatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IsTypePatternSyntax) {}
  /// Visiting `OptionalPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `OptionalPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: OptionalPatternSyntax) {}
  /// Visiting `IdentifierPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IdentifierPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IdentifierPatternSyntax) {}
  /// Visiting `AsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AsTypePatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AsTypePatternSyntax) {}
  /// Visiting `TuplePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TuplePatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TuplePatternSyntax) {}
  /// Visiting `WildcardPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `WildcardPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: WildcardPatternSyntax) {}
  /// Visiting `TuplePatternElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TuplePatternElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TuplePatternElementSyntax) {}
  /// Visiting `ExpressionPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ExpressionPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ExpressionPatternSyntax) {}
  /// Visiting `TuplePatternElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TuplePatternElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TuplePatternElementListSyntax) {}
  /// Visiting `ValueBindingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ValueBindingPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ValueBindingPatternSyntax) {}
  /// Visiting `AvailabilitySpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AvailabilitySpecListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AvailabilitySpecListSyntax) {}
  /// Visiting `AvailabilityArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AvailabilityArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AvailabilityArgumentSyntax) {}
  /// Visiting `AvailabilityLabeledArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AvailabilityLabeledArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AvailabilityLabeledArgumentSyntax) {}
  /// Visiting `AvailabilityVersionRestrictionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AvailabilityVersionRestrictionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AvailabilityVersionRestrictionSyntax) {}
  /// Visiting `VersionTupleSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `VersionTupleSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: VersionTupleSyntax) {}

  /// Visiting `TokenSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TokenSyntax) {}

  /// Visiting `UnknownSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnknownSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnknownSyntax) {}

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclSyntax(_ data: SyntaxData) {
      let node = UnknownDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExprSyntax(_ data: SyntaxData) {
      let node = UnknownExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStmtSyntax(_ data: SyntaxData) {
      let node = UnknownStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeSyntax(_ data: SyntaxData) {
      let node = UnknownTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternSyntax(_ data: SyntaxData) {
      let node = UnknownPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownDeclSyntax(_ data: SyntaxData) {
      let node = UnknownDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownExprSyntax(_ data: SyntaxData) {
      let node = UnknownExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownStmtSyntax(_ data: SyntaxData) {
      let node = UnknownStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownTypeSyntax(_ data: SyntaxData) {
      let node = UnknownTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownPatternSyntax(_ data: SyntaxData) {
      let node = UnknownPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockItemSyntax(_ data: SyntaxData) {
      let node = CodeBlockItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockItemListSyntax(_ data: SyntaxData) {
      let node = CodeBlockItemListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockSyntax(_ data: SyntaxData) {
      let node = CodeBlockSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInOutExprSyntax(_ data: SyntaxData) {
      let node = InOutExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundColumnExprSyntax(_ data: SyntaxData) {
      let node = PoundColumnExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprElementListSyntax(_ data: SyntaxData) {
      let node = TupleExprElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayElementListSyntax(_ data: SyntaxData) {
      let node = ArrayElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryElementListSyntax(_ data: SyntaxData) {
      let node = DictionaryElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringLiteralSegmentsSyntax(_ data: SyntaxData) {
      let node = StringLiteralSegmentsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTryExprSyntax(_ data: SyntaxData) {
      let node = TryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentSyntax(_ data: SyntaxData) {
      let node = DeclNameArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentListSyntax(_ data: SyntaxData) {
      let node = DeclNameArgumentListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentsSyntax(_ data: SyntaxData) {
      let node = DeclNameArgumentsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierExprSyntax(_ data: SyntaxData) {
      let node = IdentifierExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSuperRefExprSyntax(_ data: SyntaxData) {
      let node = SuperRefExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNilLiteralExprSyntax(_ data: SyntaxData) {
      let node = NilLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDiscardAssignmentExprSyntax(_ data: SyntaxData) {
      let node = DiscardAssignmentExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAssignmentExprSyntax(_ data: SyntaxData) {
      let node = AssignmentExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSequenceExprSyntax(_ data: SyntaxData) {
      let node = SequenceExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExprListSyntax(_ data: SyntaxData) {
      let node = ExprListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundLineExprSyntax(_ data: SyntaxData) {
      let node = PoundLineExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFileExprSyntax(_ data: SyntaxData) {
      let node = PoundFileExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFunctionExprSyntax(_ data: SyntaxData) {
      let node = PoundFunctionExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundDsohandleExprSyntax(_ data: SyntaxData) {
      let node = PoundDsohandleExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSymbolicReferenceExprSyntax(_ data: SyntaxData) {
      let node = SymbolicReferenceExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrefixOperatorExprSyntax(_ data: SyntaxData) {
      let node = PrefixOperatorExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBinaryOperatorExprSyntax(_ data: SyntaxData) {
      let node = BinaryOperatorExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrowExprSyntax(_ data: SyntaxData) {
      let node = ArrowExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFloatLiteralExprSyntax(_ data: SyntaxData) {
      let node = FloatLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprSyntax(_ data: SyntaxData) {
      let node = TupleExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayExprSyntax(_ data: SyntaxData) {
      let node = ArrayExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryExprSyntax(_ data: SyntaxData) {
      let node = DictionaryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprElementSyntax(_ data: SyntaxData) {
      let node = TupleExprElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayElementSyntax(_ data: SyntaxData) {
      let node = ArrayElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryElementSyntax(_ data: SyntaxData) {
      let node = DictionaryElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIntegerLiteralExprSyntax(_ data: SyntaxData) {
      let node = IntegerLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBooleanLiteralExprSyntax(_ data: SyntaxData) {
      let node = BooleanLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTernaryExprSyntax(_ data: SyntaxData) {
      let node = TernaryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberAccessExprSyntax(_ data: SyntaxData) {
      let node = MemberAccessExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIsExprSyntax(_ data: SyntaxData) {
      let node = IsExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAsExprSyntax(_ data: SyntaxData) {
      let node = AsExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeExprSyntax(_ data: SyntaxData) {
      let node = TypeExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureItemSyntax(_ data: SyntaxData) {
      let node = ClosureCaptureItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureItemListSyntax(_ data: SyntaxData) {
      let node = ClosureCaptureItemListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureSignatureSyntax(_ data: SyntaxData) {
      let node = ClosureCaptureSignatureSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureParamSyntax(_ data: SyntaxData) {
      let node = ClosureParamSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureParamListSyntax(_ data: SyntaxData) {
      let node = ClosureParamListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureSignatureSyntax(_ data: SyntaxData) {
      let node = ClosureSignatureSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureExprSyntax(_ data: SyntaxData) {
      let node = ClosureExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnresolvedPatternExprSyntax(_ data: SyntaxData) {
      let node = UnresolvedPatternExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionCallExprSyntax(_ data: SyntaxData) {
      let node = FunctionCallExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSubscriptExprSyntax(_ data: SyntaxData) {
      let node = SubscriptExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalChainingExprSyntax(_ data: SyntaxData) {
      let node = OptionalChainingExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplForcedValueExprSyntax(_ data: SyntaxData) {
      let node = ForcedValueExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPostfixUnaryExprSyntax(_ data: SyntaxData) {
      let node = PostfixUnaryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSpecializeExprSyntax(_ data: SyntaxData) {
      let node = SpecializeExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringSegmentSyntax(_ data: SyntaxData) {
      let node = StringSegmentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionSegmentSyntax(_ data: SyntaxData) {
      let node = ExpressionSegmentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringLiteralExprSyntax(_ data: SyntaxData) {
      let node = StringLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplKeyPathExprSyntax(_ data: SyntaxData) {
      let node = KeyPathExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplKeyPathBaseExprSyntax(_ data: SyntaxData) {
      let node = KeyPathBaseExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcNamePieceSyntax(_ data: SyntaxData) {
      let node = ObjcNamePieceSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcNameSyntax(_ data: SyntaxData) {
      let node = ObjcNameSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcKeyPathExprSyntax(_ data: SyntaxData) {
      let node = ObjcKeyPathExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcSelectorExprSyntax(_ data: SyntaxData) {
      let node = ObjcSelectorExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEditorPlaceholderExprSyntax(_ data: SyntaxData) {
      let node = EditorPlaceholderExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjectLiteralExprSyntax(_ data: SyntaxData) {
      let node = ObjectLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeInitializerClauseSyntax(_ data: SyntaxData) {
      let node = TypeInitializerClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypealiasDeclSyntax(_ data: SyntaxData) {
      let node = TypealiasDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAssociatedtypeDeclSyntax(_ data: SyntaxData) {
      let node = AssociatedtypeDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionParameterListSyntax(_ data: SyntaxData) {
      let node = FunctionParameterListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplParameterClauseSyntax(_ data: SyntaxData) {
      let node = ParameterClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplReturnClauseSyntax(_ data: SyntaxData) {
      let node = ReturnClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionSignatureSyntax(_ data: SyntaxData) {
      let node = FunctionSignatureSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigClauseSyntax(_ data: SyntaxData) {
      let node = IfConfigClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigClauseListSyntax(_ data: SyntaxData) {
      let node = IfConfigClauseListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigDeclSyntax(_ data: SyntaxData) {
      let node = IfConfigDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundErrorDeclSyntax(_ data: SyntaxData) {
      let node = PoundErrorDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundWarningDeclSyntax(_ data: SyntaxData) {
      let node = PoundWarningDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundSourceLocationSyntax(_ data: SyntaxData) {
      let node = PoundSourceLocationSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundSourceLocationArgsSyntax(_ data: SyntaxData) {
      let node = PoundSourceLocationArgsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclModifierSyntax(_ data: SyntaxData) {
      let node = DeclModifierSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInheritedTypeSyntax(_ data: SyntaxData) {
      let node = InheritedTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInheritedTypeListSyntax(_ data: SyntaxData) {
      let node = InheritedTypeListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeInheritanceClauseSyntax(_ data: SyntaxData) {
      let node = TypeInheritanceClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClassDeclSyntax(_ data: SyntaxData) {
      let node = ClassDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStructDeclSyntax(_ data: SyntaxData) {
      let node = StructDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplProtocolDeclSyntax(_ data: SyntaxData) {
      let node = ProtocolDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExtensionDeclSyntax(_ data: SyntaxData) {
      let node = ExtensionDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclBlockSyntax(_ data: SyntaxData) {
      let node = MemberDeclBlockSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclListSyntax(_ data: SyntaxData) {
      let node = MemberDeclListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclListItemSyntax(_ data: SyntaxData) {
      let node = MemberDeclListItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSourceFileSyntax(_ data: SyntaxData) {
      let node = SourceFileSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInitializerClauseSyntax(_ data: SyntaxData) {
      let node = InitializerClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionParameterSyntax(_ data: SyntaxData) {
      let node = FunctionParameterSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplModifierListSyntax(_ data: SyntaxData) {
      let node = ModifierListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionDeclSyntax(_ data: SyntaxData) {
      let node = FunctionDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInitializerDeclSyntax(_ data: SyntaxData) {
      let node = InitializerDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeinitializerDeclSyntax(_ data: SyntaxData) {
      let node = DeinitializerDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSubscriptDeclSyntax(_ data: SyntaxData) {
      let node = SubscriptDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessLevelModifierSyntax(_ data: SyntaxData) {
      let node = AccessLevelModifierSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessPathComponentSyntax(_ data: SyntaxData) {
      let node = AccessPathComponentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessPathSyntax(_ data: SyntaxData) {
      let node = AccessPathSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImportDeclSyntax(_ data: SyntaxData) {
      let node = ImportDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorParameterSyntax(_ data: SyntaxData) {
      let node = AccessorParameterSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorDeclSyntax(_ data: SyntaxData) {
      let node = AccessorDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorListSyntax(_ data: SyntaxData) {
      let node = AccessorListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorBlockSyntax(_ data: SyntaxData) {
      let node = AccessorBlockSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternBindingSyntax(_ data: SyntaxData) {
      let node = PatternBindingSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternBindingListSyntax(_ data: SyntaxData) {
      let node = PatternBindingListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplVariableDeclSyntax(_ data: SyntaxData) {
      let node = VariableDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseElementSyntax(_ data: SyntaxData) {
      let node = EnumCaseElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseElementListSyntax(_ data: SyntaxData) {
      let node = EnumCaseElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseDeclSyntax(_ data: SyntaxData) {
      let node = EnumCaseDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumDeclSyntax(_ data: SyntaxData) {
      let node = EnumDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOperatorDeclSyntax(_ data: SyntaxData) {
      let node = OperatorDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierListSyntax(_ data: SyntaxData) {
      let node = IdentifierListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOperatorPrecedenceAndTypesSyntax(_ data: SyntaxData) {
      let node = OperatorPrecedenceAndTypesSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupDeclSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAttributeListSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupAttributeListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupRelationSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupRelationSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupNameListSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupNameListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupNameElementSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupNameElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAssignmentSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupAssignmentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAssociativitySyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupAssociativitySyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTokenListSyntax(_ data: SyntaxData) {
      let node = TokenListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNonEmptyTokenListSyntax(_ data: SyntaxData) {
      let node = NonEmptyTokenListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCustomAttributeSyntax(_ data: SyntaxData) {
      let node = CustomAttributeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributeSyntax(_ data: SyntaxData) {
      let node = AttributeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributeListSyntax(_ data: SyntaxData) {
      let node = AttributeListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSpecializeAttributeSpecListSyntax(_ data: SyntaxData) {
      let node = SpecializeAttributeSpecListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplLabeledSpecializeEntrySyntax(_ data: SyntaxData) {
      let node = LabeledSpecializeEntrySyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNamedAttributeStringArgumentSyntax(_ data: SyntaxData) {
      let node = NamedAttributeStringArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameSyntax(_ data: SyntaxData) {
      let node = DeclNameSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImplementsAttributeArgumentsSyntax(_ data: SyntaxData) {
      let node = ImplementsAttributeArgumentsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjCSelectorPieceSyntax(_ data: SyntaxData) {
      let node = ObjCSelectorPieceSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjCSelectorSyntax(_ data: SyntaxData) {
      let node = ObjCSelectorSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplContinueStmtSyntax(_ data: SyntaxData) {
      let node = ContinueStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWhileStmtSyntax(_ data: SyntaxData) {
      let node = WhileStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeferStmtSyntax(_ data: SyntaxData) {
      let node = DeferStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionStmtSyntax(_ data: SyntaxData) {
      let node = ExpressionStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseListSyntax(_ data: SyntaxData) {
      let node = SwitchCaseListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplRepeatWhileStmtSyntax(_ data: SyntaxData) {
      let node = RepeatWhileStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGuardStmtSyntax(_ data: SyntaxData) {
      let node = GuardStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWhereClauseSyntax(_ data: SyntaxData) {
      let node = WhereClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplForInStmtSyntax(_ data: SyntaxData) {
      let node = ForInStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchStmtSyntax(_ data: SyntaxData) {
      let node = SwitchStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchClauseListSyntax(_ data: SyntaxData) {
      let node = CatchClauseListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDoStmtSyntax(_ data: SyntaxData) {
      let node = DoStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplReturnStmtSyntax(_ data: SyntaxData) {
      let node = ReturnStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplYieldStmtSyntax(_ data: SyntaxData) {
      let node = YieldStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplYieldListSyntax(_ data: SyntaxData) {
      let node = YieldListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFallthroughStmtSyntax(_ data: SyntaxData) {
      let node = FallthroughStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBreakStmtSyntax(_ data: SyntaxData) {
      let node = BreakStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCaseItemListSyntax(_ data: SyntaxData) {
      let node = CaseItemListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConditionElementSyntax(_ data: SyntaxData) {
      let node = ConditionElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityConditionSyntax(_ data: SyntaxData) {
      let node = AvailabilityConditionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMatchingPatternConditionSyntax(_ data: SyntaxData) {
      let node = MatchingPatternConditionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalBindingConditionSyntax(_ data: SyntaxData) {
      let node = OptionalBindingConditionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConditionElementListSyntax(_ data: SyntaxData) {
      let node = ConditionElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclarationStmtSyntax(_ data: SyntaxData) {
      let node = DeclarationStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplThrowStmtSyntax(_ data: SyntaxData) {
      let node = ThrowStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfStmtSyntax(_ data: SyntaxData) {
      let node = IfStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplElseIfContinuationSyntax(_ data: SyntaxData) {
      let node = ElseIfContinuationSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplElseBlockSyntax(_ data: SyntaxData) {
      let node = ElseBlockSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseSyntax(_ data: SyntaxData) {
      let node = SwitchCaseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchDefaultLabelSyntax(_ data: SyntaxData) {
      let node = SwitchDefaultLabelSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCaseItemSyntax(_ data: SyntaxData) {
      let node = CaseItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseLabelSyntax(_ data: SyntaxData) {
      let node = SwitchCaseLabelSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchClauseSyntax(_ data: SyntaxData) {
      let node = CatchClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundAssertStmtSyntax(_ data: SyntaxData) {
      let node = PoundAssertStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericWhereClauseSyntax(_ data: SyntaxData) {
      let node = GenericWhereClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericRequirementListSyntax(_ data: SyntaxData) {
      let node = GenericRequirementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericRequirementSyntax(_ data: SyntaxData) {
      let node = GenericRequirementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSameTypeRequirementSyntax(_ data: SyntaxData) {
      let node = SameTypeRequirementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterListSyntax(_ data: SyntaxData) {
      let node = GenericParameterListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterSyntax(_ data: SyntaxData) {
      let node = GenericParameterSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterClauseSyntax(_ data: SyntaxData) {
      let node = GenericParameterClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConformanceRequirementSyntax(_ data: SyntaxData) {
      let node = ConformanceRequirementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSimpleTypeIdentifierSyntax(_ data: SyntaxData) {
      let node = SimpleTypeIdentifierSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberTypeIdentifierSyntax(_ data: SyntaxData) {
      let node = MemberTypeIdentifierSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClassRestrictionTypeSyntax(_ data: SyntaxData) {
      let node = ClassRestrictionTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayTypeSyntax(_ data: SyntaxData) {
      let node = ArrayTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryTypeSyntax(_ data: SyntaxData) {
      let node = DictionaryTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMetatypeTypeSyntax(_ data: SyntaxData) {
      let node = MetatypeTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalTypeSyntax(_ data: SyntaxData) {
      let node = OptionalTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSomeTypeSyntax(_ data: SyntaxData) {
      let node = SomeTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImplicitlyUnwrappedOptionalTypeSyntax(_ data: SyntaxData) {
      let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeElementSyntax(_ data: SyntaxData) {
      let node = CompositionTypeElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeElementListSyntax(_ data: SyntaxData) {
      let node = CompositionTypeElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeSyntax(_ data: SyntaxData) {
      let node = CompositionTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeElementSyntax(_ data: SyntaxData) {
      let node = TupleTypeElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeElementListSyntax(_ data: SyntaxData) {
      let node = TupleTypeElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeSyntax(_ data: SyntaxData) {
      let node = TupleTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionTypeSyntax(_ data: SyntaxData) {
      let node = FunctionTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributedTypeSyntax(_ data: SyntaxData) {
      let node = AttributedTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentListSyntax(_ data: SyntaxData) {
      let node = GenericArgumentListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentSyntax(_ data: SyntaxData) {
      let node = GenericArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentClauseSyntax(_ data: SyntaxData) {
      let node = GenericArgumentClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeAnnotationSyntax(_ data: SyntaxData) {
      let node = TypeAnnotationSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCasePatternSyntax(_ data: SyntaxData) {
      let node = EnumCasePatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIsTypePatternSyntax(_ data: SyntaxData) {
      let node = IsTypePatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalPatternSyntax(_ data: SyntaxData) {
      let node = OptionalPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierPatternSyntax(_ data: SyntaxData) {
      let node = IdentifierPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAsTypePatternSyntax(_ data: SyntaxData) {
      let node = AsTypePatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternSyntax(_ data: SyntaxData) {
      let node = TuplePatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWildcardPatternSyntax(_ data: SyntaxData) {
      let node = WildcardPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternElementSyntax(_ data: SyntaxData) {
      let node = TuplePatternElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionPatternSyntax(_ data: SyntaxData) {
      let node = ExpressionPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternElementListSyntax(_ data: SyntaxData) {
      let node = TuplePatternElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplValueBindingPatternSyntax(_ data: SyntaxData) {
      let node = ValueBindingPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilitySpecListSyntax(_ data: SyntaxData) {
      let node = AvailabilitySpecListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityArgumentSyntax(_ data: SyntaxData) {
      let node = AvailabilityArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityLabeledArgumentSyntax(_ data: SyntaxData) {
      let node = AvailabilityLabeledArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityVersionRestrictionSyntax(_ data: SyntaxData) {
      let node = AvailabilityVersionRestrictionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplVersionTupleSyntax(_ data: SyntaxData) {
      let node = VersionTupleSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
  }


  private func visit(_ data: SyntaxData) {
    switch data.raw.kind {
    case .token:
      let node = TokenSyntax(data)
      _ = visit(node)
      // No children to visit.
      visitPost(node)
    case .unknown:
      let node = UnknownSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && node.raw.numberOfChildren > 0 {
        visitChildren(node)
      }
      visitPost(node)
    // The implementation of every generated case goes into its own function. This
    // circumvents an issue where the compiler allocates stack space for every
    // case statement next to each other in debug builds, causing it to allocate
    // ~50KB per call to this function. rdar://55929175
    case .decl:
      visitImplDeclSyntax(data)
    case .expr:
      visitImplExprSyntax(data)
    case .stmt:
      visitImplStmtSyntax(data)
    case .type:
      visitImplTypeSyntax(data)
    case .pattern:
      visitImplPatternSyntax(data)
    case .unknownDecl:
      visitImplUnknownDeclSyntax(data)
    case .unknownExpr:
      visitImplUnknownExprSyntax(data)
    case .unknownStmt:
      visitImplUnknownStmtSyntax(data)
    case .unknownType:
      visitImplUnknownTypeSyntax(data)
    case .unknownPattern:
      visitImplUnknownPatternSyntax(data)
    case .codeBlockItem:
      visitImplCodeBlockItemSyntax(data)
    case .codeBlockItemList:
      visitImplCodeBlockItemListSyntax(data)
    case .codeBlock:
      visitImplCodeBlockSyntax(data)
    case .inOutExpr:
      visitImplInOutExprSyntax(data)
    case .poundColumnExpr:
      visitImplPoundColumnExprSyntax(data)
    case .tupleExprElementList:
      visitImplTupleExprElementListSyntax(data)
    case .arrayElementList:
      visitImplArrayElementListSyntax(data)
    case .dictionaryElementList:
      visitImplDictionaryElementListSyntax(data)
    case .stringLiteralSegments:
      visitImplStringLiteralSegmentsSyntax(data)
    case .tryExpr:
      visitImplTryExprSyntax(data)
    case .declNameArgument:
      visitImplDeclNameArgumentSyntax(data)
    case .declNameArgumentList:
      visitImplDeclNameArgumentListSyntax(data)
    case .declNameArguments:
      visitImplDeclNameArgumentsSyntax(data)
    case .identifierExpr:
      visitImplIdentifierExprSyntax(data)
    case .superRefExpr:
      visitImplSuperRefExprSyntax(data)
    case .nilLiteralExpr:
      visitImplNilLiteralExprSyntax(data)
    case .discardAssignmentExpr:
      visitImplDiscardAssignmentExprSyntax(data)
    case .assignmentExpr:
      visitImplAssignmentExprSyntax(data)
    case .sequenceExpr:
      visitImplSequenceExprSyntax(data)
    case .exprList:
      visitImplExprListSyntax(data)
    case .poundLineExpr:
      visitImplPoundLineExprSyntax(data)
    case .poundFileExpr:
      visitImplPoundFileExprSyntax(data)
    case .poundFunctionExpr:
      visitImplPoundFunctionExprSyntax(data)
    case .poundDsohandleExpr:
      visitImplPoundDsohandleExprSyntax(data)
    case .symbolicReferenceExpr:
      visitImplSymbolicReferenceExprSyntax(data)
    case .prefixOperatorExpr:
      visitImplPrefixOperatorExprSyntax(data)
    case .binaryOperatorExpr:
      visitImplBinaryOperatorExprSyntax(data)
    case .arrowExpr:
      visitImplArrowExprSyntax(data)
    case .floatLiteralExpr:
      visitImplFloatLiteralExprSyntax(data)
    case .tupleExpr:
      visitImplTupleExprSyntax(data)
    case .arrayExpr:
      visitImplArrayExprSyntax(data)
    case .dictionaryExpr:
      visitImplDictionaryExprSyntax(data)
    case .tupleExprElement:
      visitImplTupleExprElementSyntax(data)
    case .arrayElement:
      visitImplArrayElementSyntax(data)
    case .dictionaryElement:
      visitImplDictionaryElementSyntax(data)
    case .integerLiteralExpr:
      visitImplIntegerLiteralExprSyntax(data)
    case .booleanLiteralExpr:
      visitImplBooleanLiteralExprSyntax(data)
    case .ternaryExpr:
      visitImplTernaryExprSyntax(data)
    case .memberAccessExpr:
      visitImplMemberAccessExprSyntax(data)
    case .isExpr:
      visitImplIsExprSyntax(data)
    case .asExpr:
      visitImplAsExprSyntax(data)
    case .typeExpr:
      visitImplTypeExprSyntax(data)
    case .closureCaptureItem:
      visitImplClosureCaptureItemSyntax(data)
    case .closureCaptureItemList:
      visitImplClosureCaptureItemListSyntax(data)
    case .closureCaptureSignature:
      visitImplClosureCaptureSignatureSyntax(data)
    case .closureParam:
      visitImplClosureParamSyntax(data)
    case .closureParamList:
      visitImplClosureParamListSyntax(data)
    case .closureSignature:
      visitImplClosureSignatureSyntax(data)
    case .closureExpr:
      visitImplClosureExprSyntax(data)
    case .unresolvedPatternExpr:
      visitImplUnresolvedPatternExprSyntax(data)
    case .functionCallExpr:
      visitImplFunctionCallExprSyntax(data)
    case .subscriptExpr:
      visitImplSubscriptExprSyntax(data)
    case .optionalChainingExpr:
      visitImplOptionalChainingExprSyntax(data)
    case .forcedValueExpr:
      visitImplForcedValueExprSyntax(data)
    case .postfixUnaryExpr:
      visitImplPostfixUnaryExprSyntax(data)
    case .specializeExpr:
      visitImplSpecializeExprSyntax(data)
    case .stringSegment:
      visitImplStringSegmentSyntax(data)
    case .expressionSegment:
      visitImplExpressionSegmentSyntax(data)
    case .stringLiteralExpr:
      visitImplStringLiteralExprSyntax(data)
    case .keyPathExpr:
      visitImplKeyPathExprSyntax(data)
    case .keyPathBaseExpr:
      visitImplKeyPathBaseExprSyntax(data)
    case .objcNamePiece:
      visitImplObjcNamePieceSyntax(data)
    case .objcName:
      visitImplObjcNameSyntax(data)
    case .objcKeyPathExpr:
      visitImplObjcKeyPathExprSyntax(data)
    case .objcSelectorExpr:
      visitImplObjcSelectorExprSyntax(data)
    case .editorPlaceholderExpr:
      visitImplEditorPlaceholderExprSyntax(data)
    case .objectLiteralExpr:
      visitImplObjectLiteralExprSyntax(data)
    case .typeInitializerClause:
      visitImplTypeInitializerClauseSyntax(data)
    case .typealiasDecl:
      visitImplTypealiasDeclSyntax(data)
    case .associatedtypeDecl:
      visitImplAssociatedtypeDeclSyntax(data)
    case .functionParameterList:
      visitImplFunctionParameterListSyntax(data)
    case .parameterClause:
      visitImplParameterClauseSyntax(data)
    case .returnClause:
      visitImplReturnClauseSyntax(data)
    case .functionSignature:
      visitImplFunctionSignatureSyntax(data)
    case .ifConfigClause:
      visitImplIfConfigClauseSyntax(data)
    case .ifConfigClauseList:
      visitImplIfConfigClauseListSyntax(data)
    case .ifConfigDecl:
      visitImplIfConfigDeclSyntax(data)
    case .poundErrorDecl:
      visitImplPoundErrorDeclSyntax(data)
    case .poundWarningDecl:
      visitImplPoundWarningDeclSyntax(data)
    case .poundSourceLocation:
      visitImplPoundSourceLocationSyntax(data)
    case .poundSourceLocationArgs:
      visitImplPoundSourceLocationArgsSyntax(data)
    case .declModifier:
      visitImplDeclModifierSyntax(data)
    case .inheritedType:
      visitImplInheritedTypeSyntax(data)
    case .inheritedTypeList:
      visitImplInheritedTypeListSyntax(data)
    case .typeInheritanceClause:
      visitImplTypeInheritanceClauseSyntax(data)
    case .classDecl:
      visitImplClassDeclSyntax(data)
    case .structDecl:
      visitImplStructDeclSyntax(data)
    case .protocolDecl:
      visitImplProtocolDeclSyntax(data)
    case .extensionDecl:
      visitImplExtensionDeclSyntax(data)
    case .memberDeclBlock:
      visitImplMemberDeclBlockSyntax(data)
    case .memberDeclList:
      visitImplMemberDeclListSyntax(data)
    case .memberDeclListItem:
      visitImplMemberDeclListItemSyntax(data)
    case .sourceFile:
      visitImplSourceFileSyntax(data)
    case .initializerClause:
      visitImplInitializerClauseSyntax(data)
    case .functionParameter:
      visitImplFunctionParameterSyntax(data)
    case .modifierList:
      visitImplModifierListSyntax(data)
    case .functionDecl:
      visitImplFunctionDeclSyntax(data)
    case .initializerDecl:
      visitImplInitializerDeclSyntax(data)
    case .deinitializerDecl:
      visitImplDeinitializerDeclSyntax(data)
    case .subscriptDecl:
      visitImplSubscriptDeclSyntax(data)
    case .accessLevelModifier:
      visitImplAccessLevelModifierSyntax(data)
    case .accessPathComponent:
      visitImplAccessPathComponentSyntax(data)
    case .accessPath:
      visitImplAccessPathSyntax(data)
    case .importDecl:
      visitImplImportDeclSyntax(data)
    case .accessorParameter:
      visitImplAccessorParameterSyntax(data)
    case .accessorDecl:
      visitImplAccessorDeclSyntax(data)
    case .accessorList:
      visitImplAccessorListSyntax(data)
    case .accessorBlock:
      visitImplAccessorBlockSyntax(data)
    case .patternBinding:
      visitImplPatternBindingSyntax(data)
    case .patternBindingList:
      visitImplPatternBindingListSyntax(data)
    case .variableDecl:
      visitImplVariableDeclSyntax(data)
    case .enumCaseElement:
      visitImplEnumCaseElementSyntax(data)
    case .enumCaseElementList:
      visitImplEnumCaseElementListSyntax(data)
    case .enumCaseDecl:
      visitImplEnumCaseDeclSyntax(data)
    case .enumDecl:
      visitImplEnumDeclSyntax(data)
    case .operatorDecl:
      visitImplOperatorDeclSyntax(data)
    case .identifierList:
      visitImplIdentifierListSyntax(data)
    case .operatorPrecedenceAndTypes:
      visitImplOperatorPrecedenceAndTypesSyntax(data)
    case .precedenceGroupDecl:
      visitImplPrecedenceGroupDeclSyntax(data)
    case .precedenceGroupAttributeList:
      visitImplPrecedenceGroupAttributeListSyntax(data)
    case .precedenceGroupRelation:
      visitImplPrecedenceGroupRelationSyntax(data)
    case .precedenceGroupNameList:
      visitImplPrecedenceGroupNameListSyntax(data)
    case .precedenceGroupNameElement:
      visitImplPrecedenceGroupNameElementSyntax(data)
    case .precedenceGroupAssignment:
      visitImplPrecedenceGroupAssignmentSyntax(data)
    case .precedenceGroupAssociativity:
      visitImplPrecedenceGroupAssociativitySyntax(data)
    case .tokenList:
      visitImplTokenListSyntax(data)
    case .nonEmptyTokenList:
      visitImplNonEmptyTokenListSyntax(data)
    case .customAttribute:
      visitImplCustomAttributeSyntax(data)
    case .attribute:
      visitImplAttributeSyntax(data)
    case .attributeList:
      visitImplAttributeListSyntax(data)
    case .specializeAttributeSpecList:
      visitImplSpecializeAttributeSpecListSyntax(data)
    case .labeledSpecializeEntry:
      visitImplLabeledSpecializeEntrySyntax(data)
    case .namedAttributeStringArgument:
      visitImplNamedAttributeStringArgumentSyntax(data)
    case .declName:
      visitImplDeclNameSyntax(data)
    case .implementsAttributeArguments:
      visitImplImplementsAttributeArgumentsSyntax(data)
    case .objCSelectorPiece:
      visitImplObjCSelectorPieceSyntax(data)
    case .objCSelector:
      visitImplObjCSelectorSyntax(data)
    case .continueStmt:
      visitImplContinueStmtSyntax(data)
    case .whileStmt:
      visitImplWhileStmtSyntax(data)
    case .deferStmt:
      visitImplDeferStmtSyntax(data)
    case .expressionStmt:
      visitImplExpressionStmtSyntax(data)
    case .switchCaseList:
      visitImplSwitchCaseListSyntax(data)
    case .repeatWhileStmt:
      visitImplRepeatWhileStmtSyntax(data)
    case .guardStmt:
      visitImplGuardStmtSyntax(data)
    case .whereClause:
      visitImplWhereClauseSyntax(data)
    case .forInStmt:
      visitImplForInStmtSyntax(data)
    case .switchStmt:
      visitImplSwitchStmtSyntax(data)
    case .catchClauseList:
      visitImplCatchClauseListSyntax(data)
    case .doStmt:
      visitImplDoStmtSyntax(data)
    case .returnStmt:
      visitImplReturnStmtSyntax(data)
    case .yieldStmt:
      visitImplYieldStmtSyntax(data)
    case .yieldList:
      visitImplYieldListSyntax(data)
    case .fallthroughStmt:
      visitImplFallthroughStmtSyntax(data)
    case .breakStmt:
      visitImplBreakStmtSyntax(data)
    case .caseItemList:
      visitImplCaseItemListSyntax(data)
    case .conditionElement:
      visitImplConditionElementSyntax(data)
    case .availabilityCondition:
      visitImplAvailabilityConditionSyntax(data)
    case .matchingPatternCondition:
      visitImplMatchingPatternConditionSyntax(data)
    case .optionalBindingCondition:
      visitImplOptionalBindingConditionSyntax(data)
    case .conditionElementList:
      visitImplConditionElementListSyntax(data)
    case .declarationStmt:
      visitImplDeclarationStmtSyntax(data)
    case .throwStmt:
      visitImplThrowStmtSyntax(data)
    case .ifStmt:
      visitImplIfStmtSyntax(data)
    case .elseIfContinuation:
      visitImplElseIfContinuationSyntax(data)
    case .elseBlock:
      visitImplElseBlockSyntax(data)
    case .switchCase:
      visitImplSwitchCaseSyntax(data)
    case .switchDefaultLabel:
      visitImplSwitchDefaultLabelSyntax(data)
    case .caseItem:
      visitImplCaseItemSyntax(data)
    case .switchCaseLabel:
      visitImplSwitchCaseLabelSyntax(data)
    case .catchClause:
      visitImplCatchClauseSyntax(data)
    case .poundAssertStmt:
      visitImplPoundAssertStmtSyntax(data)
    case .genericWhereClause:
      visitImplGenericWhereClauseSyntax(data)
    case .genericRequirementList:
      visitImplGenericRequirementListSyntax(data)
    case .genericRequirement:
      visitImplGenericRequirementSyntax(data)
    case .sameTypeRequirement:
      visitImplSameTypeRequirementSyntax(data)
    case .genericParameterList:
      visitImplGenericParameterListSyntax(data)
    case .genericParameter:
      visitImplGenericParameterSyntax(data)
    case .genericParameterClause:
      visitImplGenericParameterClauseSyntax(data)
    case .conformanceRequirement:
      visitImplConformanceRequirementSyntax(data)
    case .simpleTypeIdentifier:
      visitImplSimpleTypeIdentifierSyntax(data)
    case .memberTypeIdentifier:
      visitImplMemberTypeIdentifierSyntax(data)
    case .classRestrictionType:
      visitImplClassRestrictionTypeSyntax(data)
    case .arrayType:
      visitImplArrayTypeSyntax(data)
    case .dictionaryType:
      visitImplDictionaryTypeSyntax(data)
    case .metatypeType:
      visitImplMetatypeTypeSyntax(data)
    case .optionalType:
      visitImplOptionalTypeSyntax(data)
    case .someType:
      visitImplSomeTypeSyntax(data)
    case .implicitlyUnwrappedOptionalType:
      visitImplImplicitlyUnwrappedOptionalTypeSyntax(data)
    case .compositionTypeElement:
      visitImplCompositionTypeElementSyntax(data)
    case .compositionTypeElementList:
      visitImplCompositionTypeElementListSyntax(data)
    case .compositionType:
      visitImplCompositionTypeSyntax(data)
    case .tupleTypeElement:
      visitImplTupleTypeElementSyntax(data)
    case .tupleTypeElementList:
      visitImplTupleTypeElementListSyntax(data)
    case .tupleType:
      visitImplTupleTypeSyntax(data)
    case .functionType:
      visitImplFunctionTypeSyntax(data)
    case .attributedType:
      visitImplAttributedTypeSyntax(data)
    case .genericArgumentList:
      visitImplGenericArgumentListSyntax(data)
    case .genericArgument:
      visitImplGenericArgumentSyntax(data)
    case .genericArgumentClause:
      visitImplGenericArgumentClauseSyntax(data)
    case .typeAnnotation:
      visitImplTypeAnnotationSyntax(data)
    case .enumCasePattern:
      visitImplEnumCasePatternSyntax(data)
    case .isTypePattern:
      visitImplIsTypePatternSyntax(data)
    case .optionalPattern:
      visitImplOptionalPatternSyntax(data)
    case .identifierPattern:
      visitImplIdentifierPatternSyntax(data)
    case .asTypePattern:
      visitImplAsTypePatternSyntax(data)
    case .tuplePattern:
      visitImplTuplePatternSyntax(data)
    case .wildcardPattern:
      visitImplWildcardPatternSyntax(data)
    case .tuplePatternElement:
      visitImplTuplePatternElementSyntax(data)
    case .expressionPattern:
      visitImplExpressionPatternSyntax(data)
    case .tuplePatternElementList:
      visitImplTuplePatternElementListSyntax(data)
    case .valueBindingPattern:
      visitImplValueBindingPatternSyntax(data)
    case .availabilitySpecList:
      visitImplAvailabilitySpecListSyntax(data)
    case .availabilityArgument:
      visitImplAvailabilityArgumentSyntax(data)
    case .availabilityLabeledArgument:
      visitImplAvailabilityLabeledArgumentSyntax(data)
    case .availabilityVersionRestriction:
      visitImplAvailabilityVersionRestrictionSyntax(data)
    case .versionTuple:
      visitImplVersionTupleSyntax(data)
    }
  }

  private func visitChildren<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) {
    let syntaxNode = Syntax(node)
    let parentBox = SyntaxBox(syntaxNode)
    for childRaw in PresentRawSyntaxChildren(syntaxNode) {
      let childData = SyntaxData(childRaw, parentBox: parentBox)
      visit(childData)
    }
  }
}

/// A `SyntaxVisitor` that can visit the nodes as generic `Syntax` values.
///
/// This subclass of `SyntaxVisitor` is slower than the type-specific visitation 
/// of `SyntaxVisitor`. Use `SyntaxAnyVisitor` if the `visitAny(_)` function 
/// would be useful to have, otherwise inherit from `SyntaxVisitor`.
///
/// This works by overriding the type-specific visit function that delegate to 
/// `visitAny(_)`. A subclass that provides a custom type-specific visit 
/// function, should also call `visitAny(_)` in its implementation, if calling 
/// `visitAny` is needed:
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
open class SyntaxAnyVisitor: SyntaxVisitor {
  /// Visiting `UnknownSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitAnyPost(_ node: Syntax) {}

  // MARK: Override type specific visit methods

  override open func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(token._syntaxNode)
  }

  override open func visitPost(_ node: TokenSyntax) {
    visitAnyPost(node._syntaxNode)
  }

  override open func visit(_ node: UnknownSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: UnknownSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  
  override open func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: UnknownDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: UnknownExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: UnknownStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: UnknownTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: UnknownPatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CodeBlockItemSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CodeBlockItemListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CodeBlockSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: InOutExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundColumnExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TupleExprElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TupleExprElementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ArrayElementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DictionaryElementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: StringLiteralSegmentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: StringLiteralSegmentsSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TryExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DeclNameArgumentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DeclNameArgumentListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DeclNameArgumentsSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IdentifierExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SuperRefExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: NilLiteralExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DiscardAssignmentExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AssignmentExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SequenceExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ExprListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundLineExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundFileExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundFunctionExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundDsohandleExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SymbolicReferenceExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PrefixOperatorExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: BinaryOperatorExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ArrowExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: FloatLiteralExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TupleExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ArrayExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DictionaryExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TupleExprElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TupleExprElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ArrayElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DictionaryElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IntegerLiteralExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: BooleanLiteralExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TernaryExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: MemberAccessExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IsExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AsExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TypeExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClosureCaptureItemSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClosureCaptureItemListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClosureCaptureSignatureSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClosureParamSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClosureParamListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClosureSignatureSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClosureExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: UnresolvedPatternExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: FunctionCallExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SubscriptExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: OptionalChainingExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ForcedValueExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PostfixUnaryExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SpecializeExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: StringSegmentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ExpressionSegmentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: StringLiteralExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: KeyPathExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: KeyPathBaseExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ObjcNamePieceSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ObjcNameSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ObjcKeyPathExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ObjcSelectorExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: EditorPlaceholderExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ObjectLiteralExprSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TypeInitializerClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TypealiasDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AssociatedtypeDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: FunctionParameterListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ParameterClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ReturnClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: FunctionSignatureSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IfConfigClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IfConfigClauseListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IfConfigDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundErrorDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundWarningDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundSourceLocationSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundSourceLocationArgsSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DeclModifierSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: InheritedTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: InheritedTypeListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TypeInheritanceClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClassDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: StructDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ProtocolDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ExtensionDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: MemberDeclBlockSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: MemberDeclListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: MemberDeclListItemSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SourceFileSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: InitializerClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: FunctionParameterSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ModifierListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: FunctionDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: InitializerDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DeinitializerDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SubscriptDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AccessLevelModifierSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AccessPathComponentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AccessPathSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ImportDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AccessorParameterSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AccessorDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AccessorListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AccessorBlockSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PatternBindingSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PatternBindingListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: VariableDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: EnumCaseElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: EnumCaseElementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: EnumCaseDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: EnumDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: OperatorDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IdentifierListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: OperatorPrecedenceAndTypesSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PrecedenceGroupDeclSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PrecedenceGroupAttributeListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PrecedenceGroupRelationSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PrecedenceGroupNameListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PrecedenceGroupNameElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PrecedenceGroupAssignmentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PrecedenceGroupAssociativitySyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TokenListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: NonEmptyTokenListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CustomAttributeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CustomAttributeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AttributeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AttributeListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SpecializeAttributeSpecListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: LabeledSpecializeEntrySyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: NamedAttributeStringArgumentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DeclNameSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ImplementsAttributeArgumentsSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ObjCSelectorPieceSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ObjCSelectorSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ContinueStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: WhileStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DeferStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ExpressionStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SwitchCaseListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: RepeatWhileStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GuardStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: WhereClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ForInStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SwitchStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CatchClauseListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DoStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ReturnStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: YieldStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: YieldListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: FallthroughStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: BreakStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CaseItemListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ConditionElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AvailabilityConditionSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: MatchingPatternConditionSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: OptionalBindingConditionSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ConditionElementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DeclarationStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ThrowStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IfStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ElseIfContinuationSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ElseBlockSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SwitchCaseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SwitchDefaultLabelSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CaseItemSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SwitchCaseLabelSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CatchClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: PoundAssertStmtSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericWhereClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericRequirementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericRequirementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SameTypeRequirementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericParameterListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericParameterSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericParameterClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ConformanceRequirementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SimpleTypeIdentifierSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: MemberTypeIdentifierSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ClassRestrictionTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ArrayTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: DictionaryTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: MetatypeTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: OptionalTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: SomeTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: SomeTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CompositionTypeElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CompositionTypeElementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: CompositionTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TupleTypeElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TupleTypeElementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TupleTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: FunctionTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AttributedTypeSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericArgumentListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericArgumentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: GenericArgumentClauseSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TypeAnnotationSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: EnumCasePatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IsTypePatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: OptionalPatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: IdentifierPatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AsTypePatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TuplePatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: WildcardPatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TuplePatternElementSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ExpressionPatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: TuplePatternElementListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: ValueBindingPatternSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AvailabilitySpecListSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AvailabilityArgumentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AvailabilityLabeledArgumentSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: AvailabilityVersionRestrictionSyntax) {
    visitAnyPost(node._syntaxNode)
  }
  override open func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node._syntaxNode)
  }

  override open func visitPost(_ node: VersionTupleSyntax) {
    visitAnyPost(node._syntaxNode)
  }

}
