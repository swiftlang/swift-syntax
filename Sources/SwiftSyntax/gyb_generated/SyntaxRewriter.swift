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
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `UnknownExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `UnknownStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `UnknownTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `UnknownPatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `CodeBlockItemSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockItemSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `CodeBlockItemListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockItemListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `CodeBlockSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `InOutExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InOutExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `PoundColumnExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundColumnExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `TupleExprElementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ArrayElementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `DictionaryElementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `StringLiteralSegmentsSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringLiteralSegmentsSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `TryExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TryExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `DeclNameArgumentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `DeclNameArgumentListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `DeclNameArgumentsSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentsSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `IdentifierExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IdentifierExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `SuperRefExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SuperRefExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `NilLiteralExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NilLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `DiscardAssignmentExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DiscardAssignmentExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `AssignmentExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AssignmentExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `SequenceExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SequenceExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `ExprListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExprListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PoundLineExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundLineExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `PoundFileExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFileExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `PoundFunctionExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFunctionExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `PoundDsohandleExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundDsohandleExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `SymbolicReferenceExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SymbolicReferenceExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `PrefixOperatorExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrefixOperatorExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `BinaryOperatorExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BinaryOperatorExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `ArrowExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrowExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `FloatLiteralExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FloatLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `TupleExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `ArrayExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `DictionaryExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `TupleExprElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ArrayElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `DictionaryElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `IntegerLiteralExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IntegerLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `BooleanLiteralExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BooleanLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `TernaryExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TernaryExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `MemberAccessExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberAccessExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `IsExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IsExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `AsExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AsExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `TypeExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `ClosureCaptureItemSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureItemSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ClosureCaptureItemListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureItemListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ClosureCaptureSignatureSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureSignatureSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ClosureParamSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureParamSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ClosureParamListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureParamListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ClosureSignatureSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureSignatureSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ClosureExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `UnresolvedPatternExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedPatternExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `FunctionCallExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `SubscriptExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SubscriptExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `OptionalChainingExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalChainingExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `ForcedValueExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ForcedValueExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `PostfixUnaryExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PostfixUnaryExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `SpecializeExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SpecializeExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `StringSegmentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringSegmentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ExpressionSegmentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionSegmentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `StringLiteralExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `KeyPathExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `KeyPathBaseExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathBaseExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `ObjcNamePieceSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcNamePieceSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ObjcNameSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcNameSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ObjcKeyPathExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcKeyPathExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `ObjcSelectorExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcSelectorExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `EditorPlaceholderExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EditorPlaceholderExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `ObjectLiteralExprSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjectLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node) as! ExprSyntax
  }

  /// Visit a `TypeInitializerClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeInitializerClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `TypealiasDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypealiasDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `AssociatedtypeDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AssociatedtypeDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `FunctionParameterListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionParameterListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ParameterClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ParameterClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ReturnClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ReturnClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `FunctionSignatureSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionSignatureSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `IfConfigClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `IfConfigClauseListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigClauseListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `IfConfigDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `PoundErrorDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundErrorDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `PoundWarningDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundWarningDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `PoundSourceLocationSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundSourceLocationSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `PoundSourceLocationArgsSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundSourceLocationArgsSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `DeclModifierSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclModifierSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `InheritedTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InheritedTypeSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `InheritedTypeListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InheritedTypeListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `TypeInheritanceClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeInheritanceClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ClassDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `StructDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StructDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `ProtocolDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ProtocolDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `ExtensionDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExtensionDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `MemberDeclBlockSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclBlockSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `MemberDeclListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `MemberDeclListItemSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclListItemSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `SourceFileSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SourceFileSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `InitializerClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InitializerClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `FunctionParameterSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionParameterSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ModifierListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ModifierListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `FunctionDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `InitializerDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InitializerDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `DeinitializerDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeinitializerDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `SubscriptDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SubscriptDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `AccessLevelModifierSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessLevelModifierSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AccessPathComponentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessPathComponentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AccessPathSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessPathSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ImportDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImportDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `AccessorParameterSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorParameterSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AccessorDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `AccessorListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AccessorBlockSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorBlockSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PatternBindingSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PatternBindingSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PatternBindingListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PatternBindingListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `VariableDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `EnumCaseElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `EnumCaseElementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `EnumCaseDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `EnumDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `OperatorDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OperatorDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `IdentifierListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IdentifierListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `OperatorPrecedenceAndTypesSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PrecedenceGroupDeclSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupDeclSyntax) -> DeclSyntax {
    return visitChildren(node) as! DeclSyntax
  }

  /// Visit a `PrecedenceGroupAttributeListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PrecedenceGroupRelationSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupRelationSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PrecedenceGroupNameListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupNameListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PrecedenceGroupNameElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PrecedenceGroupAssignmentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PrecedenceGroupAssociativitySyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `TokenListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TokenListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `NonEmptyTokenListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NonEmptyTokenListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `CustomAttributeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CustomAttributeSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AttributeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributeSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AttributeListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributeListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `SpecializeAttributeSpecListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `LabeledSpecializeEntrySyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `NamedAttributeStringArgumentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NamedAttributeStringArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `DeclNameSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ImplementsAttributeArgumentsSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ObjCSelectorPieceSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjCSelectorPieceSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ObjCSelectorSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjCSelectorSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ContinueStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ContinueStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `WhileStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WhileStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `DeferStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeferStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `ExpressionStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `SwitchCaseListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `RepeatWhileStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: RepeatWhileStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `GuardStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GuardStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `WhereClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WhereClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ForInStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ForInStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `SwitchStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `CatchClauseListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchClauseListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `DoStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DoStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `ReturnStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ReturnStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `YieldStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `YieldListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `FallthroughStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FallthroughStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `BreakStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BreakStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `CaseItemListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CaseItemListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ConditionElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConditionElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AvailabilityConditionSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityConditionSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `MatchingPatternConditionSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MatchingPatternConditionSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `OptionalBindingConditionSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalBindingConditionSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ConditionElementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConditionElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `DeclarationStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclarationStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `ThrowStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ThrowStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `IfStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `ElseIfContinuationSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ElseIfContinuationSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ElseBlockSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ElseBlockSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `SwitchCaseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `SwitchDefaultLabelSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchDefaultLabelSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `CaseItemSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CaseItemSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `SwitchCaseLabelSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseLabelSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `CatchClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `PoundAssertStmtSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundAssertStmtSyntax) -> StmtSyntax {
    return visitChildren(node) as! StmtSyntax
  }

  /// Visit a `GenericWhereClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericWhereClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `GenericRequirementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericRequirementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `GenericRequirementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericRequirementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `SameTypeRequirementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SameTypeRequirementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `GenericParameterListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `GenericParameterSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `GenericParameterClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ConformanceRequirementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConformanceRequirementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `SimpleTypeIdentifierSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SimpleTypeIdentifierSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `MemberTypeIdentifierSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberTypeIdentifierSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `ClassRestrictionTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClassRestrictionTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `ArrayTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `DictionaryTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `MetatypeTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MetatypeTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `OptionalTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `SomeTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SomeTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `ImplicitlyUnwrappedOptionalTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `CompositionTypeElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `CompositionTypeElementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `CompositionTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `TupleTypeElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `TupleTypeElementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `TupleTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `FunctionTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `AttributedTypeSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributedTypeSyntax) -> TypeSyntax {
    return visitChildren(node) as! TypeSyntax
  }

  /// Visit a `GenericArgumentListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `GenericArgumentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `GenericArgumentClauseSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentClauseSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `TypeAnnotationSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeAnnotationSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `EnumCasePatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCasePatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `IsTypePatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IsTypePatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `OptionalPatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `IdentifierPatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IdentifierPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `AsTypePatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AsTypePatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `TuplePatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `WildcardPatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WildcardPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `TuplePatternElementSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternElementSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ExpressionPatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `TuplePatternElementListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternElementListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `ValueBindingPatternSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ValueBindingPatternSyntax) -> PatternSyntax {
    return visitChildren(node) as! PatternSyntax
  }

  /// Visit a `AvailabilitySpecListSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilitySpecListSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AvailabilityArgumentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AvailabilityLabeledArgumentSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `AvailabilityVersionRestrictionSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> Syntax {
    return visitChildren(node) 
  }

  /// Visit a `VersionTupleSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: VersionTupleSyntax) -> Syntax {
    return visitChildren(node) 
  }


  /// Visit a `TokenSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ token: TokenSyntax) -> Syntax {
    return token
  }
  
  /// Visit a `UnknownSyntax`. 
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node or `nil`.
  open func visit(_ node: UnknownSyntax) -> Syntax {
    return visitChildren(node)
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
    return visit(node.base.data)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownPatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnknownPatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = CodeBlockItemSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockItemListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CodeBlockItemListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockSyntax(_ data: SyntaxData) -> Syntax {
      let node = CodeBlockSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInOutExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = InOutExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundColumnExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundColumnExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleExprElementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrayElementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = DictionaryElementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringLiteralSegmentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = StringLiteralSegmentsSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = TryExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclNameArgumentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentListSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclNameArgumentListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclNameArgumentsSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = IdentifierExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSuperRefExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SuperRefExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNilLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = NilLiteralExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDiscardAssignmentExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = DiscardAssignmentExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAssignmentExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = AssignmentExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSequenceExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SequenceExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExprListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExprListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundLineExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundLineExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFileExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundFileExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFunctionExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundFunctionExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundDsohandleExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundDsohandleExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSymbolicReferenceExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SymbolicReferenceExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrefixOperatorExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrefixOperatorExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBinaryOperatorExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = BinaryOperatorExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrowExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrowExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFloatLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = FloatLiteralExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrayExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = DictionaryExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleExprElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrayElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = DictionaryElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIntegerLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = IntegerLiteralExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBooleanLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = BooleanLiteralExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTernaryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = TernaryExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberAccessExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberAccessExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIsExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = IsExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAsExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = AsExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypeExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureCaptureItemSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureItemListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureCaptureItemListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureSignatureSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureCaptureSignatureSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureParamSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureParamSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureParamListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureParamListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureSignatureSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureSignatureSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClosureExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedPatternExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = UnresolvedPatternExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionCallExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionCallExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSubscriptExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SubscriptExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalChainingExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = OptionalChainingExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplForcedValueExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ForcedValueExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPostfixUnaryExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = PostfixUnaryExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSpecializeExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = SpecializeExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringSegmentSyntax(_ data: SyntaxData) -> Syntax {
      let node = StringSegmentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionSegmentSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExpressionSegmentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = StringLiteralExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathBaseExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = KeyPathBaseExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcNamePieceSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjcNamePieceSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcNameSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjcNameSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcKeyPathExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjcKeyPathExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcSelectorExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjcSelectorExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEditorPlaceholderExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = EditorPlaceholderExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjectLiteralExprSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjectLiteralExprSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeInitializerClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypeInitializerClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypealiasDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypealiasDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAssociatedtypeDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = AssociatedtypeDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionParameterListSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionParameterListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplParameterClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = ParameterClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplReturnClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = ReturnClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionSignatureSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionSignatureSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = IfConfigClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigClauseListSyntax(_ data: SyntaxData) -> Syntax {
      let node = IfConfigClauseListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = IfConfigDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundErrorDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundErrorDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundWarningDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundWarningDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundSourceLocationSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundSourceLocationSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundSourceLocationArgsSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundSourceLocationArgsSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclModifierSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclModifierSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInheritedTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = InheritedTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInheritedTypeListSyntax(_ data: SyntaxData) -> Syntax {
      let node = InheritedTypeListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeInheritanceClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypeInheritanceClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClassDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClassDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStructDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = StructDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplProtocolDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ProtocolDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExtensionDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExtensionDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclBlockSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberDeclBlockSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclListSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberDeclListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclListItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberDeclListItemSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSourceFileSyntax(_ data: SyntaxData) -> Syntax {
      let node = SourceFileSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInitializerClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = InitializerClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionParameterSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionParameterSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplModifierListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ModifierListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInitializerDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = InitializerDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeinitializerDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeinitializerDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSubscriptDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = SubscriptDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessLevelModifierSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessLevelModifierSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessPathComponentSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessPathComponentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessPathSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessPathSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImportDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = ImportDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorParameterSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessorParameterSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessorDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorListSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessorListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorBlockSyntax(_ data: SyntaxData) -> Syntax {
      let node = AccessorBlockSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternBindingSyntax(_ data: SyntaxData) -> Syntax {
      let node = PatternBindingSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternBindingListSyntax(_ data: SyntaxData) -> Syntax {
      let node = PatternBindingListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplVariableDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = VariableDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumCaseElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumCaseElementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumCaseDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOperatorDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = OperatorDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierListSyntax(_ data: SyntaxData) -> Syntax {
      let node = IdentifierListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOperatorPrecedenceAndTypesSyntax(_ data: SyntaxData) -> Syntax {
      let node = OperatorPrecedenceAndTypesSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupDeclSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupDeclSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAttributeListSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupAttributeListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupRelationSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupRelationSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupNameListSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupNameListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupNameElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupNameElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAssignmentSyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupAssignmentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAssociativitySyntax(_ data: SyntaxData) -> Syntax {
      let node = PrecedenceGroupAssociativitySyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTokenListSyntax(_ data: SyntaxData) -> Syntax {
      let node = TokenListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNonEmptyTokenListSyntax(_ data: SyntaxData) -> Syntax {
      let node = NonEmptyTokenListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCustomAttributeSyntax(_ data: SyntaxData) -> Syntax {
      let node = CustomAttributeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributeSyntax(_ data: SyntaxData) -> Syntax {
      let node = AttributeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributeListSyntax(_ data: SyntaxData) -> Syntax {
      let node = AttributeListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSpecializeAttributeSpecListSyntax(_ data: SyntaxData) -> Syntax {
      let node = SpecializeAttributeSpecListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplLabeledSpecializeEntrySyntax(_ data: SyntaxData) -> Syntax {
      let node = LabeledSpecializeEntrySyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNamedAttributeStringArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = NamedAttributeStringArgumentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclNameSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImplementsAttributeArgumentsSyntax(_ data: SyntaxData) -> Syntax {
      let node = ImplementsAttributeArgumentsSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjCSelectorPieceSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjCSelectorPieceSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjCSelectorSyntax(_ data: SyntaxData) -> Syntax {
      let node = ObjCSelectorSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplContinueStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ContinueStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWhileStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = WhileStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeferStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeferStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExpressionStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseListSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchCaseListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplRepeatWhileStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = RepeatWhileStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGuardStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = GuardStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWhereClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = WhereClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplForInStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ForInStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchClauseListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CatchClauseListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDoStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = DoStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplReturnStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ReturnStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = YieldStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldListSyntax(_ data: SyntaxData) -> Syntax {
      let node = YieldListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFallthroughStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = FallthroughStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBreakStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = BreakStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCaseItemListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CaseItemListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConditionElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConditionElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityConditionSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityConditionSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMatchingPatternConditionSyntax(_ data: SyntaxData) -> Syntax {
      let node = MatchingPatternConditionSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalBindingConditionSyntax(_ data: SyntaxData) -> Syntax {
      let node = OptionalBindingConditionSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConditionElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConditionElementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclarationStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = DeclarationStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplThrowStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = ThrowStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = IfStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplElseIfContinuationSyntax(_ data: SyntaxData) -> Syntax {
      let node = ElseIfContinuationSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplElseBlockSyntax(_ data: SyntaxData) -> Syntax {
      let node = ElseBlockSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchCaseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchDefaultLabelSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchDefaultLabelSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCaseItemSyntax(_ data: SyntaxData) -> Syntax {
      let node = CaseItemSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseLabelSyntax(_ data: SyntaxData) -> Syntax {
      let node = SwitchCaseLabelSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = CatchClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundAssertStmtSyntax(_ data: SyntaxData) -> Syntax {
      let node = PoundAssertStmtSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericWhereClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericWhereClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericRequirementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericRequirementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericRequirementSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericRequirementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSameTypeRequirementSyntax(_ data: SyntaxData) -> Syntax {
      let node = SameTypeRequirementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterListSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericParameterListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericParameterSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericParameterClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConformanceRequirementSyntax(_ data: SyntaxData) -> Syntax {
      let node = ConformanceRequirementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSimpleTypeIdentifierSyntax(_ data: SyntaxData) -> Syntax {
      let node = SimpleTypeIdentifierSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberTypeIdentifierSyntax(_ data: SyntaxData) -> Syntax {
      let node = MemberTypeIdentifierSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClassRestrictionTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = ClassRestrictionTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = ArrayTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = DictionaryTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMetatypeTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = MetatypeTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = OptionalTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSomeTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = SomeTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImplicitlyUnwrappedOptionalTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = CompositionTypeElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = CompositionTypeElementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = CompositionTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleTypeElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleTypeElementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = TupleTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = FunctionTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributedTypeSyntax(_ data: SyntaxData) -> Syntax {
      let node = AttributedTypeSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentListSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericArgumentListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericArgumentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentClauseSyntax(_ data: SyntaxData) -> Syntax {
      let node = GenericArgumentClauseSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeAnnotationSyntax(_ data: SyntaxData) -> Syntax {
      let node = TypeAnnotationSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCasePatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = EnumCasePatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIsTypePatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = IsTypePatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = OptionalPatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = IdentifierPatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAsTypePatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = AsTypePatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = TuplePatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWildcardPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = WildcardPatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternElementSyntax(_ data: SyntaxData) -> Syntax {
      let node = TuplePatternElementSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = ExpressionPatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternElementListSyntax(_ data: SyntaxData) -> Syntax {
      let node = TuplePatternElementListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplValueBindingPatternSyntax(_ data: SyntaxData) -> Syntax {
      let node = ValueBindingPatternSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilitySpecListSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilitySpecListSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityArgumentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityLabeledArgumentSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityLabeledArgumentSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityVersionRestrictionSyntax(_ data: SyntaxData) -> Syntax {
      let node = AvailabilityVersionRestrictionSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplVersionTupleSyntax(_ data: SyntaxData) -> Syntax {
      let node = VersionTupleSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
  }


  final func visit(_ data: SyntaxData) -> Syntax {
    // Create the node types directly instead of going through `makeSyntax()`
    // which has additional cost for casting back and forth from `_SyntaxBase`.
    switch data.raw.kind {
    case .token:
      let node = TokenSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
      return visit(node)
    case .unknown:
      let node = UnknownSyntax(data)
      visitPre(node)
      defer { visitPost(node) }
      if let newNode = visitAny(node) { return newNode }
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

  final func visitChildren(_ nodeS: Syntax) -> Syntax {
    let node = nodeS.base

    // Walk over all children of this node and rewrite them. Don't store any 
    // rewritten nodes until the first non-`nil` value is encountered. When this 
    // happens, retrieve all previous syntax nodes from the parent node to 
    // initialize the new layout. Once we know that we have to rewrite the 
    // layout, we need to collect all futher children, regardless of whether 
    // they are rewritten or not.
    
    // newLayout is nil until the first child node is rewritten and rewritten 
    // nodes are being collected.
    var newLayout: ContiguousArray<RawSyntax?>?

    for (i, (raw, info)) in RawSyntaxChildren(node).enumerated() {
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
      let data = SyntaxData(absoluteRaw, parent: node)
      
      let rewritten = visit(data)
      if rewritten.base.data.absoluteRaw.info.nodeId != info.nodeId {
        // The node was rewritten, let's handle it
        if newLayout == nil {
          // We have not yet collected any previous rewritten nodes. Initialize
          // the new layout with the previous nodes of the parent. This is 
          // possible, since we know they were not rewritten.
          
          // The below implementation is based on Collection.map but directly
          // reserves enough capacity for the entire layout.
          newLayout = ContiguousArray<RawSyntax?>()
          newLayout!.reserveCapacity(node.raw.numberOfChildren)
          for j in 0..<i {
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
      return makeSyntax(.forRoot(newRaw))
    } else {
      // No child node was rewritten. So no need to change this node as well.
      return nodeS
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
  /// Visiting `TupleExprElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TupleExprElementListSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TupleExprElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TupleExprElementListSyntax)
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
  /// Visiting `TupleExprElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: TupleExprElementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `TupleExprElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: TupleExprElementSyntax)
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
  /// Visiting `GenericRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  mutating func visit(_ node: GenericRequirementSyntax) -> SyntaxVisitorContinueKind

  /// The function called after visiting `GenericRequirementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  mutating func visitPost(_ node: GenericRequirementSyntax)
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
  mutating func visit(_ node: TupleExprElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TupleExprElementListSyntax) {}
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
  mutating func visit(_ node: TupleExprElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: TupleExprElementSyntax) {}
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
  mutating func visit(_ node: GenericRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  mutating func visitPost(_ node: GenericRequirementSyntax) {}
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
  mutating func visit(_ node: TupleExprElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TupleExprElementListSyntax) {
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
  mutating func visit(_ node: TupleExprElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: TupleExprElementSyntax) {
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
  mutating func visit(_ node: GenericRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node)
  }
  mutating func visitPost(_ node: GenericRequirementSyntax) {
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
  open func visit(_ node: TupleExprElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TupleExprElementListSyntax) {}
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
  open func visit(_ node: TupleExprElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: TupleExprElementSyntax) {}
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
  open func visit(_ node: GenericRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }
  open func visitPost(_ node: GenericRequirementSyntax) {}
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

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownPatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplUnknownDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplUnknownExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplUnknownStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplUnknownTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplUnknownPatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnknownPatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCodeBlockItemSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CodeBlockItemSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCodeBlockItemListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CodeBlockItemListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCodeBlockSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CodeBlockSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplInOutExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = InOutExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundColumnExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundColumnExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTupleExprElementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TupleExprElementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplArrayElementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ArrayElementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDictionaryElementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DictionaryElementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplStringLiteralSegmentsSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = StringLiteralSegmentsSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTryExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TryExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeclNameArgumentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DeclNameArgumentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeclNameArgumentListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DeclNameArgumentListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeclNameArgumentsSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DeclNameArgumentsSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIdentifierExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IdentifierExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSuperRefExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SuperRefExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplNilLiteralExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = NilLiteralExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDiscardAssignmentExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DiscardAssignmentExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAssignmentExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AssignmentExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSequenceExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SequenceExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplExprListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ExprListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundLineExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundLineExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundFileExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundFileExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundFunctionExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundFunctionExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundDsohandleExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundDsohandleExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSymbolicReferenceExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SymbolicReferenceExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPrefixOperatorExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PrefixOperatorExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplBinaryOperatorExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = BinaryOperatorExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplArrowExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ArrowExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplFloatLiteralExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = FloatLiteralExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTupleExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TupleExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplArrayExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ArrayExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDictionaryExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DictionaryExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTupleExprElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TupleExprElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplArrayElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ArrayElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDictionaryElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DictionaryElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIntegerLiteralExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IntegerLiteralExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplBooleanLiteralExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = BooleanLiteralExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTernaryExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TernaryExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplMemberAccessExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = MemberAccessExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIsExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IsExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAsExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AsExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTypeExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TypeExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClosureCaptureItemSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClosureCaptureItemSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClosureCaptureItemListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClosureCaptureItemListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClosureCaptureSignatureSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClosureCaptureSignatureSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClosureParamSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClosureParamSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClosureParamListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClosureParamListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClosureSignatureSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClosureSignatureSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClosureExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClosureExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplUnresolvedPatternExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = UnresolvedPatternExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplFunctionCallExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = FunctionCallExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSubscriptExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SubscriptExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplOptionalChainingExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = OptionalChainingExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplForcedValueExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ForcedValueExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPostfixUnaryExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PostfixUnaryExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSpecializeExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SpecializeExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplStringSegmentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = StringSegmentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplExpressionSegmentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ExpressionSegmentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplStringLiteralExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = StringLiteralExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplKeyPathExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = KeyPathExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplKeyPathBaseExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = KeyPathBaseExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplObjcNamePieceSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ObjcNamePieceSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplObjcNameSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ObjcNameSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplObjcKeyPathExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ObjcKeyPathExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplObjcSelectorExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ObjcSelectorExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplEditorPlaceholderExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = EditorPlaceholderExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplObjectLiteralExprSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ObjectLiteralExprSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTypeInitializerClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TypeInitializerClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTypealiasDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TypealiasDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAssociatedtypeDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AssociatedtypeDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplFunctionParameterListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = FunctionParameterListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplParameterClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ParameterClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplReturnClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ReturnClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplFunctionSignatureSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = FunctionSignatureSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIfConfigClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IfConfigClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIfConfigClauseListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IfConfigClauseListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIfConfigDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IfConfigDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundErrorDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundErrorDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundWarningDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundWarningDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundSourceLocationSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundSourceLocationSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundSourceLocationArgsSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundSourceLocationArgsSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeclModifierSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DeclModifierSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplInheritedTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = InheritedTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplInheritedTypeListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = InheritedTypeListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTypeInheritanceClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TypeInheritanceClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClassDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClassDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplStructDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = StructDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplProtocolDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ProtocolDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplExtensionDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ExtensionDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplMemberDeclBlockSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = MemberDeclBlockSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplMemberDeclListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = MemberDeclListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplMemberDeclListItemSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = MemberDeclListItemSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSourceFileSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SourceFileSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplInitializerClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = InitializerClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplFunctionParameterSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = FunctionParameterSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplModifierListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ModifierListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplFunctionDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = FunctionDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplInitializerDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = InitializerDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeinitializerDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DeinitializerDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSubscriptDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SubscriptDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAccessLevelModifierSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AccessLevelModifierSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAccessPathComponentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AccessPathComponentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAccessPathSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AccessPathSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplImportDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ImportDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAccessorParameterSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AccessorParameterSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAccessorDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AccessorDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAccessorListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AccessorListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAccessorBlockSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AccessorBlockSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPatternBindingSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PatternBindingSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPatternBindingListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PatternBindingListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplVariableDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = VariableDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplEnumCaseElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = EnumCaseElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplEnumCaseElementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = EnumCaseElementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplEnumCaseDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = EnumCaseDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplEnumDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = EnumDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplOperatorDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = OperatorDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIdentifierListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IdentifierListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplOperatorPrecedenceAndTypesSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = OperatorPrecedenceAndTypesSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPrecedenceGroupDeclSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PrecedenceGroupDeclSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPrecedenceGroupAttributeListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PrecedenceGroupAttributeListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPrecedenceGroupRelationSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PrecedenceGroupRelationSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPrecedenceGroupNameListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PrecedenceGroupNameListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPrecedenceGroupNameElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PrecedenceGroupNameElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPrecedenceGroupAssignmentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PrecedenceGroupAssignmentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPrecedenceGroupAssociativitySyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PrecedenceGroupAssociativitySyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTokenListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TokenListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplNonEmptyTokenListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = NonEmptyTokenListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCustomAttributeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CustomAttributeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAttributeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AttributeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAttributeListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AttributeListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSpecializeAttributeSpecListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SpecializeAttributeSpecListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplLabeledSpecializeEntrySyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = LabeledSpecializeEntrySyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplNamedAttributeStringArgumentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = NamedAttributeStringArgumentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeclNameSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DeclNameSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplImplementsAttributeArgumentsSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ImplementsAttributeArgumentsSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplObjCSelectorPieceSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ObjCSelectorPieceSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplObjCSelectorSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ObjCSelectorSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplContinueStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ContinueStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplWhileStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = WhileStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeferStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DeferStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplExpressionStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ExpressionStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSwitchCaseListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SwitchCaseListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplRepeatWhileStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = RepeatWhileStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGuardStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GuardStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplWhereClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = WhereClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplForInStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ForInStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSwitchStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SwitchStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCatchClauseListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CatchClauseListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDoStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DoStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplReturnStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ReturnStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplYieldStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = YieldStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplYieldListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = YieldListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplFallthroughStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = FallthroughStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplBreakStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = BreakStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCaseItemListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CaseItemListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplConditionElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ConditionElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAvailabilityConditionSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AvailabilityConditionSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplMatchingPatternConditionSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = MatchingPatternConditionSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplOptionalBindingConditionSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = OptionalBindingConditionSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplConditionElementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ConditionElementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDeclarationStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DeclarationStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplThrowStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ThrowStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIfStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IfStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplElseIfContinuationSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ElseIfContinuationSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplElseBlockSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ElseBlockSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSwitchCaseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SwitchCaseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSwitchDefaultLabelSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SwitchDefaultLabelSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCaseItemSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CaseItemSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSwitchCaseLabelSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SwitchCaseLabelSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCatchClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CatchClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplPoundAssertStmtSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = PoundAssertStmtSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericWhereClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericWhereClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericRequirementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericRequirementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericRequirementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericRequirementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSameTypeRequirementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SameTypeRequirementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericParameterListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericParameterListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericParameterSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericParameterSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericParameterClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericParameterClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplConformanceRequirementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ConformanceRequirementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSimpleTypeIdentifierSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SimpleTypeIdentifierSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplMemberTypeIdentifierSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = MemberTypeIdentifierSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplClassRestrictionTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ClassRestrictionTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplArrayTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ArrayTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplDictionaryTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = DictionaryTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplMetatypeTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = MetatypeTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplOptionalTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = OptionalTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplSomeTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = SomeTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplImplicitlyUnwrappedOptionalTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCompositionTypeElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CompositionTypeElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCompositionTypeElementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CompositionTypeElementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplCompositionTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = CompositionTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTupleTypeElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TupleTypeElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTupleTypeElementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TupleTypeElementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTupleTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TupleTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplFunctionTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = FunctionTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAttributedTypeSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AttributedTypeSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericArgumentListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericArgumentListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericArgumentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericArgumentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplGenericArgumentClauseSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = GenericArgumentClauseSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTypeAnnotationSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TypeAnnotationSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplEnumCasePatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = EnumCasePatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIsTypePatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IsTypePatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplOptionalPatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = OptionalPatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplIdentifierPatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = IdentifierPatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAsTypePatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AsTypePatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTuplePatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TuplePatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplWildcardPatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = WildcardPatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTuplePatternElementSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TuplePatternElementSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplExpressionPatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ExpressionPatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplTuplePatternElementListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = TuplePatternElementListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplValueBindingPatternSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = ValueBindingPatternSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAvailabilitySpecListSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AvailabilitySpecListSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAvailabilityArgumentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AvailabilityArgumentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAvailabilityLabeledArgumentSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AvailabilityLabeledArgumentSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplAvailabilityVersionRestrictionSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = AvailabilityVersionRestrictionSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
}

/// Implementation detail of doVisit(_:_:). Do not call directly.
private func _doVisitImplVersionTupleSyntax<Visitor>(
  _ data: SyntaxData, _ visitor: inout Visitor
) where Visitor : SyntaxVisitor  {
    let node = VersionTupleSyntax(data)
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
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
    let needsChildren = (visitor.visit(node) == .visitChildren)
    // Avoid casting to `_SyntaxBase` if we don't need to visit children.
    if needsChildren && data.raw.numberOfChildren > 0 {
      visitChildren(data, parent: node, &visitor)
    }
    visitor.visitPost(node)
  // The implementation of every generated case goes into its own function. This
  // circumvents an issue where the compiler allocates stack space for every
  // case statement next to each other in debug builds, causing it to allocate
  // ~50KB per call to this function. rdar://55929175
  case .decl:
    _doVisitImplDeclSyntax(data, &visitor)
  case .expr:
    _doVisitImplExprSyntax(data, &visitor)
  case .stmt:
    _doVisitImplStmtSyntax(data, &visitor)
  case .type:
    _doVisitImplTypeSyntax(data, &visitor)
  case .pattern:
    _doVisitImplPatternSyntax(data, &visitor)
  case .unknownDecl:
    _doVisitImplUnknownDeclSyntax(data, &visitor)
  case .unknownExpr:
    _doVisitImplUnknownExprSyntax(data, &visitor)
  case .unknownStmt:
    _doVisitImplUnknownStmtSyntax(data, &visitor)
  case .unknownType:
    _doVisitImplUnknownTypeSyntax(data, &visitor)
  case .unknownPattern:
    _doVisitImplUnknownPatternSyntax(data, &visitor)
  case .codeBlockItem:
    _doVisitImplCodeBlockItemSyntax(data, &visitor)
  case .codeBlockItemList:
    _doVisitImplCodeBlockItemListSyntax(data, &visitor)
  case .codeBlock:
    _doVisitImplCodeBlockSyntax(data, &visitor)
  case .inOutExpr:
    _doVisitImplInOutExprSyntax(data, &visitor)
  case .poundColumnExpr:
    _doVisitImplPoundColumnExprSyntax(data, &visitor)
  case .tupleExprElementList:
    _doVisitImplTupleExprElementListSyntax(data, &visitor)
  case .arrayElementList:
    _doVisitImplArrayElementListSyntax(data, &visitor)
  case .dictionaryElementList:
    _doVisitImplDictionaryElementListSyntax(data, &visitor)
  case .stringLiteralSegments:
    _doVisitImplStringLiteralSegmentsSyntax(data, &visitor)
  case .tryExpr:
    _doVisitImplTryExprSyntax(data, &visitor)
  case .declNameArgument:
    _doVisitImplDeclNameArgumentSyntax(data, &visitor)
  case .declNameArgumentList:
    _doVisitImplDeclNameArgumentListSyntax(data, &visitor)
  case .declNameArguments:
    _doVisitImplDeclNameArgumentsSyntax(data, &visitor)
  case .identifierExpr:
    _doVisitImplIdentifierExprSyntax(data, &visitor)
  case .superRefExpr:
    _doVisitImplSuperRefExprSyntax(data, &visitor)
  case .nilLiteralExpr:
    _doVisitImplNilLiteralExprSyntax(data, &visitor)
  case .discardAssignmentExpr:
    _doVisitImplDiscardAssignmentExprSyntax(data, &visitor)
  case .assignmentExpr:
    _doVisitImplAssignmentExprSyntax(data, &visitor)
  case .sequenceExpr:
    _doVisitImplSequenceExprSyntax(data, &visitor)
  case .exprList:
    _doVisitImplExprListSyntax(data, &visitor)
  case .poundLineExpr:
    _doVisitImplPoundLineExprSyntax(data, &visitor)
  case .poundFileExpr:
    _doVisitImplPoundFileExprSyntax(data, &visitor)
  case .poundFunctionExpr:
    _doVisitImplPoundFunctionExprSyntax(data, &visitor)
  case .poundDsohandleExpr:
    _doVisitImplPoundDsohandleExprSyntax(data, &visitor)
  case .symbolicReferenceExpr:
    _doVisitImplSymbolicReferenceExprSyntax(data, &visitor)
  case .prefixOperatorExpr:
    _doVisitImplPrefixOperatorExprSyntax(data, &visitor)
  case .binaryOperatorExpr:
    _doVisitImplBinaryOperatorExprSyntax(data, &visitor)
  case .arrowExpr:
    _doVisitImplArrowExprSyntax(data, &visitor)
  case .floatLiteralExpr:
    _doVisitImplFloatLiteralExprSyntax(data, &visitor)
  case .tupleExpr:
    _doVisitImplTupleExprSyntax(data, &visitor)
  case .arrayExpr:
    _doVisitImplArrayExprSyntax(data, &visitor)
  case .dictionaryExpr:
    _doVisitImplDictionaryExprSyntax(data, &visitor)
  case .tupleExprElement:
    _doVisitImplTupleExprElementSyntax(data, &visitor)
  case .arrayElement:
    _doVisitImplArrayElementSyntax(data, &visitor)
  case .dictionaryElement:
    _doVisitImplDictionaryElementSyntax(data, &visitor)
  case .integerLiteralExpr:
    _doVisitImplIntegerLiteralExprSyntax(data, &visitor)
  case .booleanLiteralExpr:
    _doVisitImplBooleanLiteralExprSyntax(data, &visitor)
  case .ternaryExpr:
    _doVisitImplTernaryExprSyntax(data, &visitor)
  case .memberAccessExpr:
    _doVisitImplMemberAccessExprSyntax(data, &visitor)
  case .isExpr:
    _doVisitImplIsExprSyntax(data, &visitor)
  case .asExpr:
    _doVisitImplAsExprSyntax(data, &visitor)
  case .typeExpr:
    _doVisitImplTypeExprSyntax(data, &visitor)
  case .closureCaptureItem:
    _doVisitImplClosureCaptureItemSyntax(data, &visitor)
  case .closureCaptureItemList:
    _doVisitImplClosureCaptureItemListSyntax(data, &visitor)
  case .closureCaptureSignature:
    _doVisitImplClosureCaptureSignatureSyntax(data, &visitor)
  case .closureParam:
    _doVisitImplClosureParamSyntax(data, &visitor)
  case .closureParamList:
    _doVisitImplClosureParamListSyntax(data, &visitor)
  case .closureSignature:
    _doVisitImplClosureSignatureSyntax(data, &visitor)
  case .closureExpr:
    _doVisitImplClosureExprSyntax(data, &visitor)
  case .unresolvedPatternExpr:
    _doVisitImplUnresolvedPatternExprSyntax(data, &visitor)
  case .functionCallExpr:
    _doVisitImplFunctionCallExprSyntax(data, &visitor)
  case .subscriptExpr:
    _doVisitImplSubscriptExprSyntax(data, &visitor)
  case .optionalChainingExpr:
    _doVisitImplOptionalChainingExprSyntax(data, &visitor)
  case .forcedValueExpr:
    _doVisitImplForcedValueExprSyntax(data, &visitor)
  case .postfixUnaryExpr:
    _doVisitImplPostfixUnaryExprSyntax(data, &visitor)
  case .specializeExpr:
    _doVisitImplSpecializeExprSyntax(data, &visitor)
  case .stringSegment:
    _doVisitImplStringSegmentSyntax(data, &visitor)
  case .expressionSegment:
    _doVisitImplExpressionSegmentSyntax(data, &visitor)
  case .stringLiteralExpr:
    _doVisitImplStringLiteralExprSyntax(data, &visitor)
  case .keyPathExpr:
    _doVisitImplKeyPathExprSyntax(data, &visitor)
  case .keyPathBaseExpr:
    _doVisitImplKeyPathBaseExprSyntax(data, &visitor)
  case .objcNamePiece:
    _doVisitImplObjcNamePieceSyntax(data, &visitor)
  case .objcName:
    _doVisitImplObjcNameSyntax(data, &visitor)
  case .objcKeyPathExpr:
    _doVisitImplObjcKeyPathExprSyntax(data, &visitor)
  case .objcSelectorExpr:
    _doVisitImplObjcSelectorExprSyntax(data, &visitor)
  case .editorPlaceholderExpr:
    _doVisitImplEditorPlaceholderExprSyntax(data, &visitor)
  case .objectLiteralExpr:
    _doVisitImplObjectLiteralExprSyntax(data, &visitor)
  case .typeInitializerClause:
    _doVisitImplTypeInitializerClauseSyntax(data, &visitor)
  case .typealiasDecl:
    _doVisitImplTypealiasDeclSyntax(data, &visitor)
  case .associatedtypeDecl:
    _doVisitImplAssociatedtypeDeclSyntax(data, &visitor)
  case .functionParameterList:
    _doVisitImplFunctionParameterListSyntax(data, &visitor)
  case .parameterClause:
    _doVisitImplParameterClauseSyntax(data, &visitor)
  case .returnClause:
    _doVisitImplReturnClauseSyntax(data, &visitor)
  case .functionSignature:
    _doVisitImplFunctionSignatureSyntax(data, &visitor)
  case .ifConfigClause:
    _doVisitImplIfConfigClauseSyntax(data, &visitor)
  case .ifConfigClauseList:
    _doVisitImplIfConfigClauseListSyntax(data, &visitor)
  case .ifConfigDecl:
    _doVisitImplIfConfigDeclSyntax(data, &visitor)
  case .poundErrorDecl:
    _doVisitImplPoundErrorDeclSyntax(data, &visitor)
  case .poundWarningDecl:
    _doVisitImplPoundWarningDeclSyntax(data, &visitor)
  case .poundSourceLocation:
    _doVisitImplPoundSourceLocationSyntax(data, &visitor)
  case .poundSourceLocationArgs:
    _doVisitImplPoundSourceLocationArgsSyntax(data, &visitor)
  case .declModifier:
    _doVisitImplDeclModifierSyntax(data, &visitor)
  case .inheritedType:
    _doVisitImplInheritedTypeSyntax(data, &visitor)
  case .inheritedTypeList:
    _doVisitImplInheritedTypeListSyntax(data, &visitor)
  case .typeInheritanceClause:
    _doVisitImplTypeInheritanceClauseSyntax(data, &visitor)
  case .classDecl:
    _doVisitImplClassDeclSyntax(data, &visitor)
  case .structDecl:
    _doVisitImplStructDeclSyntax(data, &visitor)
  case .protocolDecl:
    _doVisitImplProtocolDeclSyntax(data, &visitor)
  case .extensionDecl:
    _doVisitImplExtensionDeclSyntax(data, &visitor)
  case .memberDeclBlock:
    _doVisitImplMemberDeclBlockSyntax(data, &visitor)
  case .memberDeclList:
    _doVisitImplMemberDeclListSyntax(data, &visitor)
  case .memberDeclListItem:
    _doVisitImplMemberDeclListItemSyntax(data, &visitor)
  case .sourceFile:
    _doVisitImplSourceFileSyntax(data, &visitor)
  case .initializerClause:
    _doVisitImplInitializerClauseSyntax(data, &visitor)
  case .functionParameter:
    _doVisitImplFunctionParameterSyntax(data, &visitor)
  case .modifierList:
    _doVisitImplModifierListSyntax(data, &visitor)
  case .functionDecl:
    _doVisitImplFunctionDeclSyntax(data, &visitor)
  case .initializerDecl:
    _doVisitImplInitializerDeclSyntax(data, &visitor)
  case .deinitializerDecl:
    _doVisitImplDeinitializerDeclSyntax(data, &visitor)
  case .subscriptDecl:
    _doVisitImplSubscriptDeclSyntax(data, &visitor)
  case .accessLevelModifier:
    _doVisitImplAccessLevelModifierSyntax(data, &visitor)
  case .accessPathComponent:
    _doVisitImplAccessPathComponentSyntax(data, &visitor)
  case .accessPath:
    _doVisitImplAccessPathSyntax(data, &visitor)
  case .importDecl:
    _doVisitImplImportDeclSyntax(data, &visitor)
  case .accessorParameter:
    _doVisitImplAccessorParameterSyntax(data, &visitor)
  case .accessorDecl:
    _doVisitImplAccessorDeclSyntax(data, &visitor)
  case .accessorList:
    _doVisitImplAccessorListSyntax(data, &visitor)
  case .accessorBlock:
    _doVisitImplAccessorBlockSyntax(data, &visitor)
  case .patternBinding:
    _doVisitImplPatternBindingSyntax(data, &visitor)
  case .patternBindingList:
    _doVisitImplPatternBindingListSyntax(data, &visitor)
  case .variableDecl:
    _doVisitImplVariableDeclSyntax(data, &visitor)
  case .enumCaseElement:
    _doVisitImplEnumCaseElementSyntax(data, &visitor)
  case .enumCaseElementList:
    _doVisitImplEnumCaseElementListSyntax(data, &visitor)
  case .enumCaseDecl:
    _doVisitImplEnumCaseDeclSyntax(data, &visitor)
  case .enumDecl:
    _doVisitImplEnumDeclSyntax(data, &visitor)
  case .operatorDecl:
    _doVisitImplOperatorDeclSyntax(data, &visitor)
  case .identifierList:
    _doVisitImplIdentifierListSyntax(data, &visitor)
  case .operatorPrecedenceAndTypes:
    _doVisitImplOperatorPrecedenceAndTypesSyntax(data, &visitor)
  case .precedenceGroupDecl:
    _doVisitImplPrecedenceGroupDeclSyntax(data, &visitor)
  case .precedenceGroupAttributeList:
    _doVisitImplPrecedenceGroupAttributeListSyntax(data, &visitor)
  case .precedenceGroupRelation:
    _doVisitImplPrecedenceGroupRelationSyntax(data, &visitor)
  case .precedenceGroupNameList:
    _doVisitImplPrecedenceGroupNameListSyntax(data, &visitor)
  case .precedenceGroupNameElement:
    _doVisitImplPrecedenceGroupNameElementSyntax(data, &visitor)
  case .precedenceGroupAssignment:
    _doVisitImplPrecedenceGroupAssignmentSyntax(data, &visitor)
  case .precedenceGroupAssociativity:
    _doVisitImplPrecedenceGroupAssociativitySyntax(data, &visitor)
  case .tokenList:
    _doVisitImplTokenListSyntax(data, &visitor)
  case .nonEmptyTokenList:
    _doVisitImplNonEmptyTokenListSyntax(data, &visitor)
  case .customAttribute:
    _doVisitImplCustomAttributeSyntax(data, &visitor)
  case .attribute:
    _doVisitImplAttributeSyntax(data, &visitor)
  case .attributeList:
    _doVisitImplAttributeListSyntax(data, &visitor)
  case .specializeAttributeSpecList:
    _doVisitImplSpecializeAttributeSpecListSyntax(data, &visitor)
  case .labeledSpecializeEntry:
    _doVisitImplLabeledSpecializeEntrySyntax(data, &visitor)
  case .namedAttributeStringArgument:
    _doVisitImplNamedAttributeStringArgumentSyntax(data, &visitor)
  case .declName:
    _doVisitImplDeclNameSyntax(data, &visitor)
  case .implementsAttributeArguments:
    _doVisitImplImplementsAttributeArgumentsSyntax(data, &visitor)
  case .objCSelectorPiece:
    _doVisitImplObjCSelectorPieceSyntax(data, &visitor)
  case .objCSelector:
    _doVisitImplObjCSelectorSyntax(data, &visitor)
  case .continueStmt:
    _doVisitImplContinueStmtSyntax(data, &visitor)
  case .whileStmt:
    _doVisitImplWhileStmtSyntax(data, &visitor)
  case .deferStmt:
    _doVisitImplDeferStmtSyntax(data, &visitor)
  case .expressionStmt:
    _doVisitImplExpressionStmtSyntax(data, &visitor)
  case .switchCaseList:
    _doVisitImplSwitchCaseListSyntax(data, &visitor)
  case .repeatWhileStmt:
    _doVisitImplRepeatWhileStmtSyntax(data, &visitor)
  case .guardStmt:
    _doVisitImplGuardStmtSyntax(data, &visitor)
  case .whereClause:
    _doVisitImplWhereClauseSyntax(data, &visitor)
  case .forInStmt:
    _doVisitImplForInStmtSyntax(data, &visitor)
  case .switchStmt:
    _doVisitImplSwitchStmtSyntax(data, &visitor)
  case .catchClauseList:
    _doVisitImplCatchClauseListSyntax(data, &visitor)
  case .doStmt:
    _doVisitImplDoStmtSyntax(data, &visitor)
  case .returnStmt:
    _doVisitImplReturnStmtSyntax(data, &visitor)
  case .yieldStmt:
    _doVisitImplYieldStmtSyntax(data, &visitor)
  case .yieldList:
    _doVisitImplYieldListSyntax(data, &visitor)
  case .fallthroughStmt:
    _doVisitImplFallthroughStmtSyntax(data, &visitor)
  case .breakStmt:
    _doVisitImplBreakStmtSyntax(data, &visitor)
  case .caseItemList:
    _doVisitImplCaseItemListSyntax(data, &visitor)
  case .conditionElement:
    _doVisitImplConditionElementSyntax(data, &visitor)
  case .availabilityCondition:
    _doVisitImplAvailabilityConditionSyntax(data, &visitor)
  case .matchingPatternCondition:
    _doVisitImplMatchingPatternConditionSyntax(data, &visitor)
  case .optionalBindingCondition:
    _doVisitImplOptionalBindingConditionSyntax(data, &visitor)
  case .conditionElementList:
    _doVisitImplConditionElementListSyntax(data, &visitor)
  case .declarationStmt:
    _doVisitImplDeclarationStmtSyntax(data, &visitor)
  case .throwStmt:
    _doVisitImplThrowStmtSyntax(data, &visitor)
  case .ifStmt:
    _doVisitImplIfStmtSyntax(data, &visitor)
  case .elseIfContinuation:
    _doVisitImplElseIfContinuationSyntax(data, &visitor)
  case .elseBlock:
    _doVisitImplElseBlockSyntax(data, &visitor)
  case .switchCase:
    _doVisitImplSwitchCaseSyntax(data, &visitor)
  case .switchDefaultLabel:
    _doVisitImplSwitchDefaultLabelSyntax(data, &visitor)
  case .caseItem:
    _doVisitImplCaseItemSyntax(data, &visitor)
  case .switchCaseLabel:
    _doVisitImplSwitchCaseLabelSyntax(data, &visitor)
  case .catchClause:
    _doVisitImplCatchClauseSyntax(data, &visitor)
  case .poundAssertStmt:
    _doVisitImplPoundAssertStmtSyntax(data, &visitor)
  case .genericWhereClause:
    _doVisitImplGenericWhereClauseSyntax(data, &visitor)
  case .genericRequirementList:
    _doVisitImplGenericRequirementListSyntax(data, &visitor)
  case .genericRequirement:
    _doVisitImplGenericRequirementSyntax(data, &visitor)
  case .sameTypeRequirement:
    _doVisitImplSameTypeRequirementSyntax(data, &visitor)
  case .genericParameterList:
    _doVisitImplGenericParameterListSyntax(data, &visitor)
  case .genericParameter:
    _doVisitImplGenericParameterSyntax(data, &visitor)
  case .genericParameterClause:
    _doVisitImplGenericParameterClauseSyntax(data, &visitor)
  case .conformanceRequirement:
    _doVisitImplConformanceRequirementSyntax(data, &visitor)
  case .simpleTypeIdentifier:
    _doVisitImplSimpleTypeIdentifierSyntax(data, &visitor)
  case .memberTypeIdentifier:
    _doVisitImplMemberTypeIdentifierSyntax(data, &visitor)
  case .classRestrictionType:
    _doVisitImplClassRestrictionTypeSyntax(data, &visitor)
  case .arrayType:
    _doVisitImplArrayTypeSyntax(data, &visitor)
  case .dictionaryType:
    _doVisitImplDictionaryTypeSyntax(data, &visitor)
  case .metatypeType:
    _doVisitImplMetatypeTypeSyntax(data, &visitor)
  case .optionalType:
    _doVisitImplOptionalTypeSyntax(data, &visitor)
  case .someType:
    _doVisitImplSomeTypeSyntax(data, &visitor)
  case .implicitlyUnwrappedOptionalType:
    _doVisitImplImplicitlyUnwrappedOptionalTypeSyntax(data, &visitor)
  case .compositionTypeElement:
    _doVisitImplCompositionTypeElementSyntax(data, &visitor)
  case .compositionTypeElementList:
    _doVisitImplCompositionTypeElementListSyntax(data, &visitor)
  case .compositionType:
    _doVisitImplCompositionTypeSyntax(data, &visitor)
  case .tupleTypeElement:
    _doVisitImplTupleTypeElementSyntax(data, &visitor)
  case .tupleTypeElementList:
    _doVisitImplTupleTypeElementListSyntax(data, &visitor)
  case .tupleType:
    _doVisitImplTupleTypeSyntax(data, &visitor)
  case .functionType:
    _doVisitImplFunctionTypeSyntax(data, &visitor)
  case .attributedType:
    _doVisitImplAttributedTypeSyntax(data, &visitor)
  case .genericArgumentList:
    _doVisitImplGenericArgumentListSyntax(data, &visitor)
  case .genericArgument:
    _doVisitImplGenericArgumentSyntax(data, &visitor)
  case .genericArgumentClause:
    _doVisitImplGenericArgumentClauseSyntax(data, &visitor)
  case .typeAnnotation:
    _doVisitImplTypeAnnotationSyntax(data, &visitor)
  case .enumCasePattern:
    _doVisitImplEnumCasePatternSyntax(data, &visitor)
  case .isTypePattern:
    _doVisitImplIsTypePatternSyntax(data, &visitor)
  case .optionalPattern:
    _doVisitImplOptionalPatternSyntax(data, &visitor)
  case .identifierPattern:
    _doVisitImplIdentifierPatternSyntax(data, &visitor)
  case .asTypePattern:
    _doVisitImplAsTypePatternSyntax(data, &visitor)
  case .tuplePattern:
    _doVisitImplTuplePatternSyntax(data, &visitor)
  case .wildcardPattern:
    _doVisitImplWildcardPatternSyntax(data, &visitor)
  case .tuplePatternElement:
    _doVisitImplTuplePatternElementSyntax(data, &visitor)
  case .expressionPattern:
    _doVisitImplExpressionPatternSyntax(data, &visitor)
  case .tuplePatternElementList:
    _doVisitImplTuplePatternElementListSyntax(data, &visitor)
  case .valueBindingPattern:
    _doVisitImplValueBindingPatternSyntax(data, &visitor)
  case .availabilitySpecList:
    _doVisitImplAvailabilitySpecListSyntax(data, &visitor)
  case .availabilityArgument:
    _doVisitImplAvailabilityArgumentSyntax(data, &visitor)
  case .availabilityLabeledArgument:
    _doVisitImplAvailabilityLabeledArgumentSyntax(data, &visitor)
  case .availabilityVersionRestriction:
    _doVisitImplAvailabilityVersionRestrictionSyntax(data, &visitor)
  case .versionTuple:
    _doVisitImplVersionTupleSyntax(data, &visitor)
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
