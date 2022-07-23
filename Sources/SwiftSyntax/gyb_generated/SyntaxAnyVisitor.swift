//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===--------- SyntaxAnyVisitor.swift - Syntax any visitor class ----------===//
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
    return visitAny(token.syntax)
  }

  override open func visitPost(_ node: TokenSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: UnknownSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }

  override open func visitPost(_ node: UnknownSyntax) {
    visitAnyPost(node.syntax)
  }


  override open func visit(_ node: UnknownDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: UnknownDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: UnknownExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: UnknownExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: UnknownStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: UnknownStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: UnknownTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: UnknownTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: UnknownPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: UnknownPatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CodeBlockItemSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CodeBlockItemListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CodeBlockSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: InOutExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: InOutExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundColumnExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundColumnExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TupleExprElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TupleExprElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ArrayElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ArrayElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DictionaryElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DictionaryElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: StringLiteralSegmentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: StringLiteralSegmentsSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TryExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AwaitExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AwaitExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeclNameArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeclNameArgumentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeclNameArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeclNameArgumentListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeclNameArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeclNameArgumentsSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IdentifierExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SuperRefExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SuperRefExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: NilLiteralExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DiscardAssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DiscardAssignmentExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AssignmentExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AssignmentExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SequenceExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ExprListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ExprListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundLineExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundLineExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundFileExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundFileExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundFileIDExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundFileIDExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundFilePathExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundFilePathExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundFunctionExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundFunctionExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundDsohandleExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundDsohandleExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SymbolicReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SymbolicReferenceExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrefixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrefixOperatorExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: BinaryOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: BinaryOperatorExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ArrowExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FloatLiteralExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TupleExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ArrayExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DictionaryExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TupleExprElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TupleExprElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ArrayElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ArrayElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DictionaryElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DictionaryElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IntegerLiteralExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: BooleanLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: BooleanLiteralExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TernaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TernaryExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MemberAccessExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IsExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AsExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TypeExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TypeExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClosureCaptureItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClosureCaptureItemSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClosureCaptureItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClosureCaptureItemListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClosureCaptureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClosureCaptureSignatureSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClosureParamSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClosureParamSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClosureParamListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClosureParamListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClosureSignatureSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClosureExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: UnresolvedPatternExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: UnresolvedPatternExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MultipleTrailingClosureElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MultipleTrailingClosureElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MultipleTrailingClosureElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MultipleTrailingClosureElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FunctionCallExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SubscriptExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SubscriptExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: OptionalChainingExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: OptionalChainingExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ForcedValueExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ForcedValueExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PostfixUnaryExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PostfixUnaryExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SpecializeExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SpecializeExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: StringSegmentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ExpressionSegmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ExpressionSegmentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: StringLiteralExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: RegexLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: RegexLiteralExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: KeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: KeyPathExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: KeyPathBaseExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: KeyPathBaseExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ObjcNamePieceSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ObjcNamePieceSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ObjcNameSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ObjcNameSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ObjcKeyPathExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ObjcKeyPathExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ObjcSelectorExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ObjcSelectorExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PostfixIfConfigExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PostfixIfConfigExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: EditorPlaceholderExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: EditorPlaceholderExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ObjectLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ObjectLiteralExprSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TypeInitializerClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TypealiasDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AssociatedtypeDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FunctionParameterListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FunctionParameterListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ParameterClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ReturnClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FunctionSignatureSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IfConfigClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IfConfigClauseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IfConfigClauseListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IfConfigDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundErrorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundErrorDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundWarningDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundWarningDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundSourceLocationSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundSourceLocationArgsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundSourceLocationArgsSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeclModifierDetailSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeclModifierDetailSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeclModifierSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: InheritedTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: InheritedTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: InheritedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: InheritedTypeListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TypeInheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TypeInheritanceClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClassDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ActorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ActorDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: StructDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ProtocolDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ExtensionDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MemberDeclBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MemberDeclBlockSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MemberDeclListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MemberDeclListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MemberDeclListItemSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SourceFileSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: InitializerClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FunctionParameterSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ModifierListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FunctionDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: InitializerDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeinitializerDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SubscriptDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AccessLevelModifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AccessLevelModifierSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AccessPathComponentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AccessPathComponentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AccessPathSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AccessPathSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ImportDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AccessorParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AccessorParameterSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AccessorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AccessorDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AccessorListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AccessorListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AccessorBlockSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PatternBindingSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PatternBindingSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PatternBindingListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: VariableDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: EnumCaseElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: EnumCaseElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: EnumCaseElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: EnumCaseDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: EnumDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: OperatorDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IdentifierListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IdentifierListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: OperatorPrecedenceAndTypesSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrecedenceGroupDeclSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrecedenceGroupDeclSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrecedenceGroupAttributeListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrecedenceGroupRelationSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrecedenceGroupNameListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrecedenceGroupNameListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrecedenceGroupNameElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrecedenceGroupNameElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrecedenceGroupAssignmentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrecedenceGroupAssociativitySyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TokenListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TokenListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: NonEmptyTokenListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: NonEmptyTokenListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CustomAttributeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CustomAttributeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AttributeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AttributeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AttributeListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SpecializeAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SpecializeAttributeSpecListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AvailabilityEntrySyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AvailabilityEntrySyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: LabeledSpecializeEntrySyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TargetFunctionEntrySyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TargetFunctionEntrySyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: NamedAttributeStringArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: NamedAttributeStringArgumentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeclNameSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeclNameSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ImplementsAttributeArgumentsSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ObjCSelectorPieceSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ObjCSelectorPieceSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ObjCSelectorSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ObjCSelectorSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DifferentiableAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DifferentiableAttributeArgumentsSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DifferentiabilityParamsClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DifferentiabilityParamsClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DifferentiabilityParamsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DifferentiabilityParamsSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DifferentiabilityParamListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DifferentiabilityParamListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DifferentiabilityParamSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DifferentiabilityParamSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DerivativeRegistrationAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DerivativeRegistrationAttributeArgumentsSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: QualifiedDeclNameSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: QualifiedDeclNameSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FunctionDeclNameSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FunctionDeclNameSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: BackDeployAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: BackDeployAttributeSpecListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: BackDeployVersionListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: BackDeployVersionListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: BackDeployVersionArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: BackDeployVersionArgumentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ContinueStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ContinueStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: WhileStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeferStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeferStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ExpressionStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ExpressionStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SwitchCaseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SwitchCaseListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: RepeatWhileStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: RepeatWhileStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GuardStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: WhereClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ForInStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SwitchStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SwitchStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CatchClauseListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CatchClauseListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DoStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DoStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ReturnStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: YieldStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: YieldStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: YieldListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: YieldListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FallthroughStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FallthroughStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: BreakStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: BreakStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CaseItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CaseItemListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CatchItemListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CatchItemListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ConditionElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AvailabilityConditionSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MatchingPatternConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MatchingPatternConditionSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: OptionalBindingConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: OptionalBindingConditionSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: UnavailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: UnavailabilityConditionSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ConditionElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ConditionElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DeclarationStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DeclarationStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ThrowStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IfStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IfStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ElseIfContinuationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ElseIfContinuationSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ElseBlockSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ElseBlockSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SwitchCaseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SwitchDefaultLabelSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CaseItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CaseItemSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CatchItemSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CatchItemSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SwitchCaseLabelSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SwitchCaseLabelSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CatchClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CatchClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PoundAssertStmtSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PoundAssertStmtSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericWhereClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericWhereClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericRequirementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericRequirementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericRequirementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SameTypeRequirementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericParameterListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericParameterListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericParameterSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrimaryAssociatedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrimaryAssociatedTypeListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrimaryAssociatedTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrimaryAssociatedTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericParameterClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericParameterClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ConformanceRequirementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ConformanceRequirementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: PrimaryAssociatedTypeClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: PrimaryAssociatedTypeClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: SimpleTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: SimpleTypeIdentifierSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MemberTypeIdentifierSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MemberTypeIdentifierSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ClassRestrictionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ClassRestrictionTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ArrayTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: DictionaryTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: DictionaryTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: MetatypeTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: MetatypeTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: OptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: OptionalTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ConstrainedSugarTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ConstrainedSugarTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CompositionTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CompositionTypeElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CompositionTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CompositionTypeElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: CompositionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: CompositionTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TupleTypeElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TupleTypeElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TupleTypeElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TupleTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TupleTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: FunctionTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AttributedTypeSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AttributedTypeSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericArgumentListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericArgumentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: GenericArgumentClauseSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TypeAnnotationSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TypeAnnotationSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: EnumCasePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: EnumCasePatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IsTypePatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: OptionalPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: OptionalPatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: IdentifierPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: IdentifierPatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AsTypePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AsTypePatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TuplePatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TuplePatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: WildcardPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: WildcardPatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TuplePatternElementSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TuplePatternElementSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ExpressionPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ExpressionPatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: TuplePatternElementListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: TuplePatternElementListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: ValueBindingPatternSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: ValueBindingPatternSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AvailabilitySpecListSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AvailabilitySpecListSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AvailabilityArgumentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AvailabilityLabeledArgumentSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: AvailabilityVersionRestrictionSyntax) {
    visitAnyPost(node.syntax)
  }

  override open func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    return visitAny(node.syntax)
  }
  override open func visitPost(_ node: VersionTupleSyntax) {
    visitAnyPost(node.syntax)
  }
}
