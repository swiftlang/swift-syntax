//// Automatically Generated From SyntaxRawRewriter.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxRawRewriter.swift ---------------------------------===//
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

/// `SyntaxRawRewriter` is pretty much equivalent to `SyntaxRewriter` but the
/// `visit` methods return raw syntax nodes, which makes `SyntaxRawRewriter` x
/// more performant than `SyntaxRewriter`.
@_spi(RawSyntax)
open class SyntaxFastRewriter {
  /// The arena in which the rewritten syntax nodes should be allocated.
  let arena: SyntaxArena

  /// `arena` is the arena in which the rewritten syntax nodes should be
  /// allocated. By default the rewritten nodes live in a new arena.
  public init(arena: SyntaxArena = SyntaxArena()) {
    self.arena = arena
  }

  /// Visit a `UnknownDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownDeclSyntax) -> RawUnknownDeclSyntax {
    return visitChildren(node).as(RawUnknownDeclSyntax.self)!
  }

  /// Visit a `UnknownExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownExprSyntax) -> RawUnknownExprSyntax {
    return visitChildren(node).as(RawUnknownExprSyntax.self)!
  }

  /// Visit a `UnknownStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownStmtSyntax) -> RawUnknownStmtSyntax {
    return visitChildren(node).as(RawUnknownStmtSyntax.self)!
  }

  /// Visit a `UnknownTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownTypeSyntax) -> RawUnknownTypeSyntax {
    return visitChildren(node).as(RawUnknownTypeSyntax.self)!
  }

  /// Visit a `UnknownPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownPatternSyntax) -> RawUnknownPatternSyntax {
    return visitChildren(node).as(RawUnknownPatternSyntax.self)!
  }

  /// Visit a `MissingSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingSyntax) -> RawMissingSyntax {
    return visitChildren(node).as(RawMissingSyntax.self)!
  }

  /// Visit a `MissingDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingDeclSyntax) -> RawMissingDeclSyntax {
    return visitChildren(node).as(RawMissingDeclSyntax.self)!
  }

  /// Visit a `MissingExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingExprSyntax) -> RawMissingExprSyntax {
    return visitChildren(node).as(RawMissingExprSyntax.self)!
  }

  /// Visit a `MissingStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingStmtSyntax) -> RawMissingStmtSyntax {
    return visitChildren(node).as(RawMissingStmtSyntax.self)!
  }

  /// Visit a `MissingTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingTypeSyntax) -> RawMissingTypeSyntax {
    return visitChildren(node).as(RawMissingTypeSyntax.self)!
  }

  /// Visit a `MissingPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MissingPatternSyntax) -> RawMissingPatternSyntax {
    return visitChildren(node).as(RawMissingPatternSyntax.self)!
  }

  /// Visit a `CodeBlockItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockItemSyntax) -> RawCodeBlockItemSyntax {
    return visitChildren(node).as(RawCodeBlockItemSyntax.self)!
  }

  /// Visit a `CodeBlockItemListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockItemListSyntax) -> RawCodeBlockItemListSyntax {
    return visitChildren(node).as(RawCodeBlockItemListSyntax.self)!
  }

  /// Visit a `CodeBlockSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CodeBlockSyntax) -> RawCodeBlockSyntax {
    return visitChildren(node).as(RawCodeBlockSyntax.self)!
  }

  /// Visit a `UnexpectedNodesSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnexpectedNodesSyntax) -> RawUnexpectedNodesSyntax {
    return visitChildren(node).as(RawUnexpectedNodesSyntax.self)!
  }

  /// Visit a `InOutExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InOutExprSyntax) -> RawInOutExprSyntax {
    return visitChildren(node).as(RawInOutExprSyntax.self)!
  }

  /// Visit a `PoundColumnExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundColumnExprSyntax) -> RawPoundColumnExprSyntax {
    return visitChildren(node).as(RawPoundColumnExprSyntax.self)!
  }

  /// Visit a `TupleExprElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprElementListSyntax) -> RawTupleExprElementListSyntax {
    return visitChildren(node).as(RawTupleExprElementListSyntax.self)!
  }

  /// Visit a `ArrayElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayElementListSyntax) -> RawArrayElementListSyntax {
    return visitChildren(node).as(RawArrayElementListSyntax.self)!
  }

  /// Visit a `DictionaryElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryElementListSyntax) -> RawDictionaryElementListSyntax {
    return visitChildren(node).as(RawDictionaryElementListSyntax.self)!
  }

  /// Visit a `StringLiteralSegmentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringLiteralSegmentsSyntax) -> RawStringLiteralSegmentsSyntax {
    return visitChildren(node).as(RawStringLiteralSegmentsSyntax.self)!
  }

  /// Visit a `TryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TryExprSyntax) -> RawTryExprSyntax {
    return visitChildren(node).as(RawTryExprSyntax.self)!
  }

  /// Visit a `AwaitExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AwaitExprSyntax) -> RawAwaitExprSyntax {
    return visitChildren(node).as(RawAwaitExprSyntax.self)!
  }

  /// Visit a `MoveExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MoveExprSyntax) -> RawMoveExprSyntax {
    return visitChildren(node).as(RawMoveExprSyntax.self)!
  }

  /// Visit a `DeclNameArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentSyntax) -> RawDeclNameArgumentSyntax {
    return visitChildren(node).as(RawDeclNameArgumentSyntax.self)!
  }

  /// Visit a `DeclNameArgumentListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentListSyntax) -> RawDeclNameArgumentListSyntax {
    return visitChildren(node).as(RawDeclNameArgumentListSyntax.self)!
  }

  /// Visit a `DeclNameArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameArgumentsSyntax) -> RawDeclNameArgumentsSyntax {
    return visitChildren(node).as(RawDeclNameArgumentsSyntax.self)!
  }

  /// Visit a `IdentifierExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IdentifierExprSyntax) -> RawIdentifierExprSyntax {
    return visitChildren(node).as(RawIdentifierExprSyntax.self)!
  }

  /// Visit a `SuperRefExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SuperRefExprSyntax) -> RawSuperRefExprSyntax {
    return visitChildren(node).as(RawSuperRefExprSyntax.self)!
  }

  /// Visit a `NilLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NilLiteralExprSyntax) -> RawNilLiteralExprSyntax {
    return visitChildren(node).as(RawNilLiteralExprSyntax.self)!
  }

  /// Visit a `DiscardAssignmentExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DiscardAssignmentExprSyntax) -> RawDiscardAssignmentExprSyntax {
    return visitChildren(node).as(RawDiscardAssignmentExprSyntax.self)!
  }

  /// Visit a `AssignmentExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AssignmentExprSyntax) -> RawAssignmentExprSyntax {
    return visitChildren(node).as(RawAssignmentExprSyntax.self)!
  }

  /// Visit a `SequenceExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SequenceExprSyntax) -> RawSequenceExprSyntax {
    return visitChildren(node).as(RawSequenceExprSyntax.self)!
  }

  /// Visit a `ExprListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExprListSyntax) -> RawExprListSyntax {
    return visitChildren(node).as(RawExprListSyntax.self)!
  }

  /// Visit a `PoundLineExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundLineExprSyntax) -> RawPoundLineExprSyntax {
    return visitChildren(node).as(RawPoundLineExprSyntax.self)!
  }

  /// Visit a `PoundFileExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFileExprSyntax) -> RawPoundFileExprSyntax {
    return visitChildren(node).as(RawPoundFileExprSyntax.self)!
  }

  /// Visit a `PoundFileIDExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFileIDExprSyntax) -> RawPoundFileIDExprSyntax {
    return visitChildren(node).as(RawPoundFileIDExprSyntax.self)!
  }

  /// Visit a `PoundFilePathExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFilePathExprSyntax) -> RawPoundFilePathExprSyntax {
    return visitChildren(node).as(RawPoundFilePathExprSyntax.self)!
  }

  /// Visit a `PoundFunctionExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundFunctionExprSyntax) -> RawPoundFunctionExprSyntax {
    return visitChildren(node).as(RawPoundFunctionExprSyntax.self)!
  }

  /// Visit a `PoundDsohandleExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundDsohandleExprSyntax) -> RawPoundDsohandleExprSyntax {
    return visitChildren(node).as(RawPoundDsohandleExprSyntax.self)!
  }

  /// Visit a `SymbolicReferenceExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SymbolicReferenceExprSyntax) -> RawSymbolicReferenceExprSyntax {
    return visitChildren(node).as(RawSymbolicReferenceExprSyntax.self)!
  }

  /// Visit a `PrefixOperatorExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrefixOperatorExprSyntax) -> RawPrefixOperatorExprSyntax {
    return visitChildren(node).as(RawPrefixOperatorExprSyntax.self)!
  }

  /// Visit a `BinaryOperatorExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BinaryOperatorExprSyntax) -> RawBinaryOperatorExprSyntax {
    return visitChildren(node).as(RawBinaryOperatorExprSyntax.self)!
  }

  /// Visit a `ArrowExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrowExprSyntax) -> RawArrowExprSyntax {
    return visitChildren(node).as(RawArrowExprSyntax.self)!
  }

  /// Visit a `InfixOperatorExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InfixOperatorExprSyntax) -> RawInfixOperatorExprSyntax {
    return visitChildren(node).as(RawInfixOperatorExprSyntax.self)!
  }

  /// Visit a `FloatLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FloatLiteralExprSyntax) -> RawFloatLiteralExprSyntax {
    return visitChildren(node).as(RawFloatLiteralExprSyntax.self)!
  }

  /// Visit a `TupleExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprSyntax) -> RawTupleExprSyntax {
    return visitChildren(node).as(RawTupleExprSyntax.self)!
  }

  /// Visit a `ArrayExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayExprSyntax) -> RawArrayExprSyntax {
    return visitChildren(node).as(RawArrayExprSyntax.self)!
  }

  /// Visit a `DictionaryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryExprSyntax) -> RawDictionaryExprSyntax {
    return visitChildren(node).as(RawDictionaryExprSyntax.self)!
  }

  /// Visit a `TupleExprElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleExprElementSyntax) -> RawTupleExprElementSyntax {
    return visitChildren(node).as(RawTupleExprElementSyntax.self)!
  }

  /// Visit a `ArrayElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayElementSyntax) -> RawArrayElementSyntax {
    return visitChildren(node).as(RawArrayElementSyntax.self)!
  }

  /// Visit a `DictionaryElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryElementSyntax) -> RawDictionaryElementSyntax {
    return visitChildren(node).as(RawDictionaryElementSyntax.self)!
  }

  /// Visit a `IntegerLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IntegerLiteralExprSyntax) -> RawIntegerLiteralExprSyntax {
    return visitChildren(node).as(RawIntegerLiteralExprSyntax.self)!
  }

  /// Visit a `BooleanLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BooleanLiteralExprSyntax) -> RawBooleanLiteralExprSyntax {
    return visitChildren(node).as(RawBooleanLiteralExprSyntax.self)!
  }

  /// Visit a `UnresolvedTernaryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedTernaryExprSyntax) -> RawUnresolvedTernaryExprSyntax {
    return visitChildren(node).as(RawUnresolvedTernaryExprSyntax.self)!
  }

  /// Visit a `TernaryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TernaryExprSyntax) -> RawTernaryExprSyntax {
    return visitChildren(node).as(RawTernaryExprSyntax.self)!
  }

  /// Visit a `MemberAccessExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberAccessExprSyntax) -> RawMemberAccessExprSyntax {
    return visitChildren(node).as(RawMemberAccessExprSyntax.self)!
  }

  /// Visit a `UnresolvedIsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedIsExprSyntax) -> RawUnresolvedIsExprSyntax {
    return visitChildren(node).as(RawUnresolvedIsExprSyntax.self)!
  }

  /// Visit a `IsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IsExprSyntax) -> RawIsExprSyntax {
    return visitChildren(node).as(RawIsExprSyntax.self)!
  }

  /// Visit a `UnresolvedAsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedAsExprSyntax) -> RawUnresolvedAsExprSyntax {
    return visitChildren(node).as(RawUnresolvedAsExprSyntax.self)!
  }

  /// Visit a `AsExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AsExprSyntax) -> RawAsExprSyntax {
    return visitChildren(node).as(RawAsExprSyntax.self)!
  }

  /// Visit a `TypeExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeExprSyntax) -> RawTypeExprSyntax {
    return visitChildren(node).as(RawTypeExprSyntax.self)!
  }

  /// Visit a `ClosureCaptureItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureItemSyntax) -> RawClosureCaptureItemSyntax {
    return visitChildren(node).as(RawClosureCaptureItemSyntax.self)!
  }

  /// Visit a `ClosureCaptureItemListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureItemListSyntax) -> RawClosureCaptureItemListSyntax {
    return visitChildren(node).as(RawClosureCaptureItemListSyntax.self)!
  }

  /// Visit a `ClosureCaptureSignatureSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureCaptureSignatureSyntax) -> RawClosureCaptureSignatureSyntax {
    return visitChildren(node).as(RawClosureCaptureSignatureSyntax.self)!
  }

  /// Visit a `ClosureParamSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureParamSyntax) -> RawClosureParamSyntax {
    return visitChildren(node).as(RawClosureParamSyntax.self)!
  }

  /// Visit a `ClosureParamListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureParamListSyntax) -> RawClosureParamListSyntax {
    return visitChildren(node).as(RawClosureParamListSyntax.self)!
  }

  /// Visit a `ClosureSignatureSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureSignatureSyntax) -> RawClosureSignatureSyntax {
    return visitChildren(node).as(RawClosureSignatureSyntax.self)!
  }

  /// Visit a `ClosureExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClosureExprSyntax) -> RawClosureExprSyntax {
    return visitChildren(node).as(RawClosureExprSyntax.self)!
  }

  /// Visit a `UnresolvedPatternExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnresolvedPatternExprSyntax) -> RawUnresolvedPatternExprSyntax {
    return visitChildren(node).as(RawUnresolvedPatternExprSyntax.self)!
  }

  /// Visit a `MultipleTrailingClosureElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MultipleTrailingClosureElementSyntax) -> RawMultipleTrailingClosureElementSyntax {
    return visitChildren(node).as(RawMultipleTrailingClosureElementSyntax.self)!
  }

  /// Visit a `MultipleTrailingClosureElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MultipleTrailingClosureElementListSyntax) -> RawMultipleTrailingClosureElementListSyntax {
    return visitChildren(node).as(RawMultipleTrailingClosureElementListSyntax.self)!
  }

  /// Visit a `FunctionCallExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionCallExprSyntax) -> RawFunctionCallExprSyntax {
    return visitChildren(node).as(RawFunctionCallExprSyntax.self)!
  }

  /// Visit a `SubscriptExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SubscriptExprSyntax) -> RawSubscriptExprSyntax {
    return visitChildren(node).as(RawSubscriptExprSyntax.self)!
  }

  /// Visit a `OptionalChainingExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalChainingExprSyntax) -> RawOptionalChainingExprSyntax {
    return visitChildren(node).as(RawOptionalChainingExprSyntax.self)!
  }

  /// Visit a `ForcedValueExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ForcedValueExprSyntax) -> RawForcedValueExprSyntax {
    return visitChildren(node).as(RawForcedValueExprSyntax.self)!
  }

  /// Visit a `PostfixUnaryExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PostfixUnaryExprSyntax) -> RawPostfixUnaryExprSyntax {
    return visitChildren(node).as(RawPostfixUnaryExprSyntax.self)!
  }

  /// Visit a `SpecializeExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SpecializeExprSyntax) -> RawSpecializeExprSyntax {
    return visitChildren(node).as(RawSpecializeExprSyntax.self)!
  }

  /// Visit a `StringSegmentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringSegmentSyntax) -> RawStringSegmentSyntax {
    return visitChildren(node).as(RawStringSegmentSyntax.self)!
  }

  /// Visit a `ExpressionSegmentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionSegmentSyntax) -> RawExpressionSegmentSyntax {
    return visitChildren(node).as(RawExpressionSegmentSyntax.self)!
  }

  /// Visit a `StringLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StringLiteralExprSyntax) -> RawStringLiteralExprSyntax {
    return visitChildren(node).as(RawStringLiteralExprSyntax.self)!
  }

  /// Visit a `RegexLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: RegexLiteralExprSyntax) -> RawRegexLiteralExprSyntax {
    return visitChildren(node).as(RawRegexLiteralExprSyntax.self)!
  }

  /// Visit a `KeyPathExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathExprSyntax) -> RawKeyPathExprSyntax {
    return visitChildren(node).as(RawKeyPathExprSyntax.self)!
  }

  /// Visit a `KeyPathComponentListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathComponentListSyntax) -> RawKeyPathComponentListSyntax {
    return visitChildren(node).as(RawKeyPathComponentListSyntax.self)!
  }

  /// Visit a `KeyPathComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathComponentSyntax) -> RawKeyPathComponentSyntax {
    return visitChildren(node).as(RawKeyPathComponentSyntax.self)!
  }

  /// Visit a `KeyPathPropertyComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathPropertyComponentSyntax) -> RawKeyPathPropertyComponentSyntax {
    return visitChildren(node).as(RawKeyPathPropertyComponentSyntax.self)!
  }

  /// Visit a `KeyPathSubscriptComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathSubscriptComponentSyntax) -> RawKeyPathSubscriptComponentSyntax {
    return visitChildren(node).as(RawKeyPathSubscriptComponentSyntax.self)!
  }

  /// Visit a `KeyPathOptionalComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathOptionalComponentSyntax) -> RawKeyPathOptionalComponentSyntax {
    return visitChildren(node).as(RawKeyPathOptionalComponentSyntax.self)!
  }

  /// Visit a `OldKeyPathExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OldKeyPathExprSyntax) -> RawOldKeyPathExprSyntax {
    return visitChildren(node).as(RawOldKeyPathExprSyntax.self)!
  }

  /// Visit a `KeyPathBaseExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: KeyPathBaseExprSyntax) -> RawKeyPathBaseExprSyntax {
    return visitChildren(node).as(RawKeyPathBaseExprSyntax.self)!
  }

  /// Visit a `ObjcNamePieceSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcNamePieceSyntax) -> RawObjcNamePieceSyntax {
    return visitChildren(node).as(RawObjcNamePieceSyntax.self)!
  }

  /// Visit a `ObjcNameSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcNameSyntax) -> RawObjcNameSyntax {
    return visitChildren(node).as(RawObjcNameSyntax.self)!
  }

  /// Visit a `ObjcKeyPathExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcKeyPathExprSyntax) -> RawObjcKeyPathExprSyntax {
    return visitChildren(node).as(RawObjcKeyPathExprSyntax.self)!
  }

  /// Visit a `ObjcSelectorExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjcSelectorExprSyntax) -> RawObjcSelectorExprSyntax {
    return visitChildren(node).as(RawObjcSelectorExprSyntax.self)!
  }

  /// Visit a `PostfixIfConfigExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PostfixIfConfigExprSyntax) -> RawPostfixIfConfigExprSyntax {
    return visitChildren(node).as(RawPostfixIfConfigExprSyntax.self)!
  }

  /// Visit a `EditorPlaceholderExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EditorPlaceholderExprSyntax) -> RawEditorPlaceholderExprSyntax {
    return visitChildren(node).as(RawEditorPlaceholderExprSyntax.self)!
  }

  /// Visit a `ObjectLiteralExprSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjectLiteralExprSyntax) -> RawObjectLiteralExprSyntax {
    return visitChildren(node).as(RawObjectLiteralExprSyntax.self)!
  }

  /// Visit a `YieldExprListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldExprListSyntax) -> RawYieldExprListSyntax {
    return visitChildren(node).as(RawYieldExprListSyntax.self)!
  }

  /// Visit a `YieldExprListElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldExprListElementSyntax) -> RawYieldExprListElementSyntax {
    return visitChildren(node).as(RawYieldExprListElementSyntax.self)!
  }

  /// Visit a `TypeInitializerClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeInitializerClauseSyntax) -> RawTypeInitializerClauseSyntax {
    return visitChildren(node).as(RawTypeInitializerClauseSyntax.self)!
  }

  /// Visit a `TypealiasDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypealiasDeclSyntax) -> RawTypealiasDeclSyntax {
    return visitChildren(node).as(RawTypealiasDeclSyntax.self)!
  }

  /// Visit a `AssociatedtypeDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AssociatedtypeDeclSyntax) -> RawAssociatedtypeDeclSyntax {
    return visitChildren(node).as(RawAssociatedtypeDeclSyntax.self)!
  }

  /// Visit a `FunctionParameterListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionParameterListSyntax) -> RawFunctionParameterListSyntax {
    return visitChildren(node).as(RawFunctionParameterListSyntax.self)!
  }

  /// Visit a `ParameterClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ParameterClauseSyntax) -> RawParameterClauseSyntax {
    return visitChildren(node).as(RawParameterClauseSyntax.self)!
  }

  /// Visit a `ReturnClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ReturnClauseSyntax) -> RawReturnClauseSyntax {
    return visitChildren(node).as(RawReturnClauseSyntax.self)!
  }

  /// Visit a `FunctionSignatureSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionSignatureSyntax) -> RawFunctionSignatureSyntax {
    return visitChildren(node).as(RawFunctionSignatureSyntax.self)!
  }

  /// Visit a `IfConfigClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigClauseSyntax) -> RawIfConfigClauseSyntax {
    return visitChildren(node).as(RawIfConfigClauseSyntax.self)!
  }

  /// Visit a `IfConfigClauseListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigClauseListSyntax) -> RawIfConfigClauseListSyntax {
    return visitChildren(node).as(RawIfConfigClauseListSyntax.self)!
  }

  /// Visit a `IfConfigDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfConfigDeclSyntax) -> RawIfConfigDeclSyntax {
    return visitChildren(node).as(RawIfConfigDeclSyntax.self)!
  }

  /// Visit a `PoundErrorDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundErrorDeclSyntax) -> RawPoundErrorDeclSyntax {
    return visitChildren(node).as(RawPoundErrorDeclSyntax.self)!
  }

  /// Visit a `PoundWarningDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundWarningDeclSyntax) -> RawPoundWarningDeclSyntax {
    return visitChildren(node).as(RawPoundWarningDeclSyntax.self)!
  }

  /// Visit a `PoundSourceLocationSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundSourceLocationSyntax) -> RawPoundSourceLocationSyntax {
    return visitChildren(node).as(RawPoundSourceLocationSyntax.self)!
  }

  /// Visit a `PoundSourceLocationArgsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundSourceLocationArgsSyntax) -> RawPoundSourceLocationArgsSyntax {
    return visitChildren(node).as(RawPoundSourceLocationArgsSyntax.self)!
  }

  /// Visit a `DeclModifierDetailSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclModifierDetailSyntax) -> RawDeclModifierDetailSyntax {
    return visitChildren(node).as(RawDeclModifierDetailSyntax.self)!
  }

  /// Visit a `DeclModifierSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclModifierSyntax) -> RawDeclModifierSyntax {
    return visitChildren(node).as(RawDeclModifierSyntax.self)!
  }

  /// Visit a `InheritedTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InheritedTypeSyntax) -> RawInheritedTypeSyntax {
    return visitChildren(node).as(RawInheritedTypeSyntax.self)!
  }

  /// Visit a `InheritedTypeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InheritedTypeListSyntax) -> RawInheritedTypeListSyntax {
    return visitChildren(node).as(RawInheritedTypeListSyntax.self)!
  }

  /// Visit a `TypeInheritanceClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeInheritanceClauseSyntax) -> RawTypeInheritanceClauseSyntax {
    return visitChildren(node).as(RawTypeInheritanceClauseSyntax.self)!
  }

  /// Visit a `ClassDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClassDeclSyntax) -> RawClassDeclSyntax {
    return visitChildren(node).as(RawClassDeclSyntax.self)!
  }

  /// Visit a `ActorDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ActorDeclSyntax) -> RawActorDeclSyntax {
    return visitChildren(node).as(RawActorDeclSyntax.self)!
  }

  /// Visit a `StructDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: StructDeclSyntax) -> RawStructDeclSyntax {
    return visitChildren(node).as(RawStructDeclSyntax.self)!
  }

  /// Visit a `ProtocolDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ProtocolDeclSyntax) -> RawProtocolDeclSyntax {
    return visitChildren(node).as(RawProtocolDeclSyntax.self)!
  }

  /// Visit a `ExtensionDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExtensionDeclSyntax) -> RawExtensionDeclSyntax {
    return visitChildren(node).as(RawExtensionDeclSyntax.self)!
  }

  /// Visit a `MemberDeclBlockSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclBlockSyntax) -> RawMemberDeclBlockSyntax {
    return visitChildren(node).as(RawMemberDeclBlockSyntax.self)!
  }

  /// Visit a `MemberDeclListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclListSyntax) -> RawMemberDeclListSyntax {
    return visitChildren(node).as(RawMemberDeclListSyntax.self)!
  }

  /// Visit a `MemberDeclListItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberDeclListItemSyntax) -> RawMemberDeclListItemSyntax {
    return visitChildren(node).as(RawMemberDeclListItemSyntax.self)!
  }

  /// Visit a `SourceFileSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SourceFileSyntax) -> RawSourceFileSyntax {
    return visitChildren(node).as(RawSourceFileSyntax.self)!
  }

  /// Visit a `InitializerClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InitializerClauseSyntax) -> RawInitializerClauseSyntax {
    return visitChildren(node).as(RawInitializerClauseSyntax.self)!
  }

  /// Visit a `FunctionParameterSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionParameterSyntax) -> RawFunctionParameterSyntax {
    return visitChildren(node).as(RawFunctionParameterSyntax.self)!
  }

  /// Visit a `ModifierListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ModifierListSyntax) -> RawModifierListSyntax {
    return visitChildren(node).as(RawModifierListSyntax.self)!
  }

  /// Visit a `FunctionDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionDeclSyntax) -> RawFunctionDeclSyntax {
    return visitChildren(node).as(RawFunctionDeclSyntax.self)!
  }

  /// Visit a `InitializerDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: InitializerDeclSyntax) -> RawInitializerDeclSyntax {
    return visitChildren(node).as(RawInitializerDeclSyntax.self)!
  }

  /// Visit a `DeinitializerDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeinitializerDeclSyntax) -> RawDeinitializerDeclSyntax {
    return visitChildren(node).as(RawDeinitializerDeclSyntax.self)!
  }

  /// Visit a `SubscriptDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SubscriptDeclSyntax) -> RawSubscriptDeclSyntax {
    return visitChildren(node).as(RawSubscriptDeclSyntax.self)!
  }

  /// Visit a `AccessLevelModifierSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessLevelModifierSyntax) -> RawAccessLevelModifierSyntax {
    return visitChildren(node).as(RawAccessLevelModifierSyntax.self)!
  }

  /// Visit a `AccessPathComponentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessPathComponentSyntax) -> RawAccessPathComponentSyntax {
    return visitChildren(node).as(RawAccessPathComponentSyntax.self)!
  }

  /// Visit a `AccessPathSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessPathSyntax) -> RawAccessPathSyntax {
    return visitChildren(node).as(RawAccessPathSyntax.self)!
  }

  /// Visit a `ImportDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImportDeclSyntax) -> RawImportDeclSyntax {
    return visitChildren(node).as(RawImportDeclSyntax.self)!
  }

  /// Visit a `AccessorParameterSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorParameterSyntax) -> RawAccessorParameterSyntax {
    return visitChildren(node).as(RawAccessorParameterSyntax.self)!
  }

  /// Visit a `AccessorDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorDeclSyntax) -> RawAccessorDeclSyntax {
    return visitChildren(node).as(RawAccessorDeclSyntax.self)!
  }

  /// Visit a `AccessorListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorListSyntax) -> RawAccessorListSyntax {
    return visitChildren(node).as(RawAccessorListSyntax.self)!
  }

  /// Visit a `AccessorBlockSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AccessorBlockSyntax) -> RawAccessorBlockSyntax {
    return visitChildren(node).as(RawAccessorBlockSyntax.self)!
  }

  /// Visit a `PatternBindingSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PatternBindingSyntax) -> RawPatternBindingSyntax {
    return visitChildren(node).as(RawPatternBindingSyntax.self)!
  }

  /// Visit a `PatternBindingListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PatternBindingListSyntax) -> RawPatternBindingListSyntax {
    return visitChildren(node).as(RawPatternBindingListSyntax.self)!
  }

  /// Visit a `VariableDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: VariableDeclSyntax) -> RawVariableDeclSyntax {
    return visitChildren(node).as(RawVariableDeclSyntax.self)!
  }

  /// Visit a `EnumCaseElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseElementSyntax) -> RawEnumCaseElementSyntax {
    return visitChildren(node).as(RawEnumCaseElementSyntax.self)!
  }

  /// Visit a `EnumCaseElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseElementListSyntax) -> RawEnumCaseElementListSyntax {
    return visitChildren(node).as(RawEnumCaseElementListSyntax.self)!
  }

  /// Visit a `EnumCaseDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCaseDeclSyntax) -> RawEnumCaseDeclSyntax {
    return visitChildren(node).as(RawEnumCaseDeclSyntax.self)!
  }

  /// Visit a `EnumDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumDeclSyntax) -> RawEnumDeclSyntax {
    return visitChildren(node).as(RawEnumDeclSyntax.self)!
  }

  /// Visit a `OperatorDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OperatorDeclSyntax) -> RawOperatorDeclSyntax {
    return visitChildren(node).as(RawOperatorDeclSyntax.self)!
  }

  /// Visit a `DesignatedTypeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DesignatedTypeListSyntax) -> RawDesignatedTypeListSyntax {
    return visitChildren(node).as(RawDesignatedTypeListSyntax.self)!
  }

  /// Visit a `DesignatedTypeElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DesignatedTypeElementSyntax) -> RawDesignatedTypeElementSyntax {
    return visitChildren(node).as(RawDesignatedTypeElementSyntax.self)!
  }

  /// Visit a `OperatorPrecedenceAndTypesSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> RawOperatorPrecedenceAndTypesSyntax {
    return visitChildren(node).as(RawOperatorPrecedenceAndTypesSyntax.self)!
  }

  /// Visit a `PrecedenceGroupDeclSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupDeclSyntax) -> RawPrecedenceGroupDeclSyntax {
    return visitChildren(node).as(RawPrecedenceGroupDeclSyntax.self)!
  }

  /// Visit a `PrecedenceGroupAttributeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAttributeListSyntax) -> RawPrecedenceGroupAttributeListSyntax {
    return visitChildren(node).as(RawPrecedenceGroupAttributeListSyntax.self)!
  }

  /// Visit a `PrecedenceGroupRelationSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupRelationSyntax) -> RawPrecedenceGroupRelationSyntax {
    return visitChildren(node).as(RawPrecedenceGroupRelationSyntax.self)!
  }

  /// Visit a `PrecedenceGroupNameListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupNameListSyntax) -> RawPrecedenceGroupNameListSyntax {
    return visitChildren(node).as(RawPrecedenceGroupNameListSyntax.self)!
  }

  /// Visit a `PrecedenceGroupNameElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupNameElementSyntax) -> RawPrecedenceGroupNameElementSyntax {
    return visitChildren(node).as(RawPrecedenceGroupNameElementSyntax.self)!
  }

  /// Visit a `PrecedenceGroupAssignmentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAssignmentSyntax) -> RawPrecedenceGroupAssignmentSyntax {
    return visitChildren(node).as(RawPrecedenceGroupAssignmentSyntax.self)!
  }

  /// Visit a `PrecedenceGroupAssociativitySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrecedenceGroupAssociativitySyntax) -> RawPrecedenceGroupAssociativitySyntax {
    return visitChildren(node).as(RawPrecedenceGroupAssociativitySyntax.self)!
  }

  /// Visit a `TokenListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TokenListSyntax) -> RawTokenListSyntax {
    return visitChildren(node).as(RawTokenListSyntax.self)!
  }

  /// Visit a `NonEmptyTokenListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NonEmptyTokenListSyntax) -> RawNonEmptyTokenListSyntax {
    return visitChildren(node).as(RawNonEmptyTokenListSyntax.self)!
  }

  /// Visit a `CustomAttributeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CustomAttributeSyntax) -> RawCustomAttributeSyntax {
    return visitChildren(node).as(RawCustomAttributeSyntax.self)!
  }

  /// Visit a `AttributeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributeSyntax) -> RawAttributeSyntax {
    return visitChildren(node).as(RawAttributeSyntax.self)!
  }

  /// Visit a `AttributeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributeListSyntax) -> RawAttributeListSyntax {
    return visitChildren(node).as(RawAttributeListSyntax.self)!
  }

  /// Visit a `SpecializeAttributeSpecListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SpecializeAttributeSpecListSyntax) -> RawSpecializeAttributeSpecListSyntax {
    return visitChildren(node).as(RawSpecializeAttributeSpecListSyntax.self)!
  }

  /// Visit a `AvailabilityEntrySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityEntrySyntax) -> RawAvailabilityEntrySyntax {
    return visitChildren(node).as(RawAvailabilityEntrySyntax.self)!
  }

  /// Visit a `LabeledSpecializeEntrySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> RawLabeledSpecializeEntrySyntax {
    return visitChildren(node).as(RawLabeledSpecializeEntrySyntax.self)!
  }

  /// Visit a `TargetFunctionEntrySyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TargetFunctionEntrySyntax) -> RawTargetFunctionEntrySyntax {
    return visitChildren(node).as(RawTargetFunctionEntrySyntax.self)!
  }

  /// Visit a `NamedAttributeStringArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NamedAttributeStringArgumentSyntax) -> RawNamedAttributeStringArgumentSyntax {
    return visitChildren(node).as(RawNamedAttributeStringArgumentSyntax.self)!
  }

  /// Visit a `DeclNameSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclNameSyntax) -> RawDeclNameSyntax {
    return visitChildren(node).as(RawDeclNameSyntax.self)!
  }

  /// Visit a `ImplementsAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImplementsAttributeArgumentsSyntax) -> RawImplementsAttributeArgumentsSyntax {
    return visitChildren(node).as(RawImplementsAttributeArgumentsSyntax.self)!
  }

  /// Visit a `ObjCSelectorPieceSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjCSelectorPieceSyntax) -> RawObjCSelectorPieceSyntax {
    return visitChildren(node).as(RawObjCSelectorPieceSyntax.self)!
  }

  /// Visit a `ObjCSelectorSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ObjCSelectorSyntax) -> RawObjCSelectorSyntax {
    return visitChildren(node).as(RawObjCSelectorSyntax.self)!
  }

  /// Visit a `DifferentiableAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiableAttributeArgumentsSyntax) -> RawDifferentiableAttributeArgumentsSyntax {
    return visitChildren(node).as(RawDifferentiableAttributeArgumentsSyntax.self)!
  }

  /// Visit a `DifferentiabilityParamsClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiabilityParamsClauseSyntax) -> RawDifferentiabilityParamsClauseSyntax {
    return visitChildren(node).as(RawDifferentiabilityParamsClauseSyntax.self)!
  }

  /// Visit a `DifferentiabilityParamsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiabilityParamsSyntax) -> RawDifferentiabilityParamsSyntax {
    return visitChildren(node).as(RawDifferentiabilityParamsSyntax.self)!
  }

  /// Visit a `DifferentiabilityParamListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiabilityParamListSyntax) -> RawDifferentiabilityParamListSyntax {
    return visitChildren(node).as(RawDifferentiabilityParamListSyntax.self)!
  }

  /// Visit a `DifferentiabilityParamSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DifferentiabilityParamSyntax) -> RawDifferentiabilityParamSyntax {
    return visitChildren(node).as(RawDifferentiabilityParamSyntax.self)!
  }

  /// Visit a `DerivativeRegistrationAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DerivativeRegistrationAttributeArgumentsSyntax) -> RawDerivativeRegistrationAttributeArgumentsSyntax {
    return visitChildren(node).as(RawDerivativeRegistrationAttributeArgumentsSyntax.self)!
  }

  /// Visit a `QualifiedDeclNameSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: QualifiedDeclNameSyntax) -> RawQualifiedDeclNameSyntax {
    return visitChildren(node).as(RawQualifiedDeclNameSyntax.self)!
  }

  /// Visit a `FunctionDeclNameSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionDeclNameSyntax) -> RawFunctionDeclNameSyntax {
    return visitChildren(node).as(RawFunctionDeclNameSyntax.self)!
  }

  /// Visit a `BackDeployAttributeSpecListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BackDeployAttributeSpecListSyntax) -> RawBackDeployAttributeSpecListSyntax {
    return visitChildren(node).as(RawBackDeployAttributeSpecListSyntax.self)!
  }

  /// Visit a `BackDeployVersionListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BackDeployVersionListSyntax) -> RawBackDeployVersionListSyntax {
    return visitChildren(node).as(RawBackDeployVersionListSyntax.self)!
  }

  /// Visit a `BackDeployVersionArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BackDeployVersionArgumentSyntax) -> RawBackDeployVersionArgumentSyntax {
    return visitChildren(node).as(RawBackDeployVersionArgumentSyntax.self)!
  }

  /// Visit a `OpaqueReturnTypeOfAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OpaqueReturnTypeOfAttributeArgumentsSyntax) -> RawOpaqueReturnTypeOfAttributeArgumentsSyntax {
    return visitChildren(node).as(RawOpaqueReturnTypeOfAttributeArgumentsSyntax.self)!
  }

  /// Visit a `ConventionAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConventionAttributeArgumentsSyntax) -> RawConventionAttributeArgumentsSyntax {
    return visitChildren(node).as(RawConventionAttributeArgumentsSyntax.self)!
  }

  /// Visit a `ConventionWitnessMethodAttributeArgumentsSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConventionWitnessMethodAttributeArgumentsSyntax) -> RawConventionWitnessMethodAttributeArgumentsSyntax {
    return visitChildren(node).as(RawConventionWitnessMethodAttributeArgumentsSyntax.self)!
  }

  /// Visit a `LabeledStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: LabeledStmtSyntax) -> RawLabeledStmtSyntax {
    return visitChildren(node).as(RawLabeledStmtSyntax.self)!
  }

  /// Visit a `ContinueStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ContinueStmtSyntax) -> RawContinueStmtSyntax {
    return visitChildren(node).as(RawContinueStmtSyntax.self)!
  }

  /// Visit a `WhileStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WhileStmtSyntax) -> RawWhileStmtSyntax {
    return visitChildren(node).as(RawWhileStmtSyntax.self)!
  }

  /// Visit a `DeferStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeferStmtSyntax) -> RawDeferStmtSyntax {
    return visitChildren(node).as(RawDeferStmtSyntax.self)!
  }

  /// Visit a `ExpressionStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionStmtSyntax) -> RawExpressionStmtSyntax {
    return visitChildren(node).as(RawExpressionStmtSyntax.self)!
  }

  /// Visit a `SwitchCaseListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseListSyntax) -> RawSwitchCaseListSyntax {
    return visitChildren(node).as(RawSwitchCaseListSyntax.self)!
  }

  /// Visit a `RepeatWhileStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: RepeatWhileStmtSyntax) -> RawRepeatWhileStmtSyntax {
    return visitChildren(node).as(RawRepeatWhileStmtSyntax.self)!
  }

  /// Visit a `GuardStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GuardStmtSyntax) -> RawGuardStmtSyntax {
    return visitChildren(node).as(RawGuardStmtSyntax.self)!
  }

  /// Visit a `WhereClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WhereClauseSyntax) -> RawWhereClauseSyntax {
    return visitChildren(node).as(RawWhereClauseSyntax.self)!
  }

  /// Visit a `ForInStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ForInStmtSyntax) -> RawForInStmtSyntax {
    return visitChildren(node).as(RawForInStmtSyntax.self)!
  }

  /// Visit a `SwitchStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchStmtSyntax) -> RawSwitchStmtSyntax {
    return visitChildren(node).as(RawSwitchStmtSyntax.self)!
  }

  /// Visit a `CatchClauseListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchClauseListSyntax) -> RawCatchClauseListSyntax {
    return visitChildren(node).as(RawCatchClauseListSyntax.self)!
  }

  /// Visit a `DoStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DoStmtSyntax) -> RawDoStmtSyntax {
    return visitChildren(node).as(RawDoStmtSyntax.self)!
  }

  /// Visit a `ReturnStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ReturnStmtSyntax) -> RawReturnStmtSyntax {
    return visitChildren(node).as(RawReturnStmtSyntax.self)!
  }

  /// Visit a `YieldStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldStmtSyntax) -> RawYieldStmtSyntax {
    return visitChildren(node).as(RawYieldStmtSyntax.self)!
  }

  /// Visit a `YieldListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: YieldListSyntax) -> RawYieldListSyntax {
    return visitChildren(node).as(RawYieldListSyntax.self)!
  }

  /// Visit a `FallthroughStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FallthroughStmtSyntax) -> RawFallthroughStmtSyntax {
    return visitChildren(node).as(RawFallthroughStmtSyntax.self)!
  }

  /// Visit a `BreakStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: BreakStmtSyntax) -> RawBreakStmtSyntax {
    return visitChildren(node).as(RawBreakStmtSyntax.self)!
  }

  /// Visit a `CaseItemListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CaseItemListSyntax) -> RawCaseItemListSyntax {
    return visitChildren(node).as(RawCaseItemListSyntax.self)!
  }

  /// Visit a `CatchItemListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchItemListSyntax) -> RawCatchItemListSyntax {
    return visitChildren(node).as(RawCatchItemListSyntax.self)!
  }

  /// Visit a `ConditionElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConditionElementSyntax) -> RawConditionElementSyntax {
    return visitChildren(node).as(RawConditionElementSyntax.self)!
  }

  /// Visit a `AvailabilityConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityConditionSyntax) -> RawAvailabilityConditionSyntax {
    return visitChildren(node).as(RawAvailabilityConditionSyntax.self)!
  }

  /// Visit a `MatchingPatternConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MatchingPatternConditionSyntax) -> RawMatchingPatternConditionSyntax {
    return visitChildren(node).as(RawMatchingPatternConditionSyntax.self)!
  }

  /// Visit a `OptionalBindingConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalBindingConditionSyntax) -> RawOptionalBindingConditionSyntax {
    return visitChildren(node).as(RawOptionalBindingConditionSyntax.self)!
  }

  /// Visit a `UnavailabilityConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnavailabilityConditionSyntax) -> RawUnavailabilityConditionSyntax {
    return visitChildren(node).as(RawUnavailabilityConditionSyntax.self)!
  }

  /// Visit a `HasSymbolConditionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: HasSymbolConditionSyntax) -> RawHasSymbolConditionSyntax {
    return visitChildren(node).as(RawHasSymbolConditionSyntax.self)!
  }

  /// Visit a `ConditionElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConditionElementListSyntax) -> RawConditionElementListSyntax {
    return visitChildren(node).as(RawConditionElementListSyntax.self)!
  }

  /// Visit a `DeclarationStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DeclarationStmtSyntax) -> RawDeclarationStmtSyntax {
    return visitChildren(node).as(RawDeclarationStmtSyntax.self)!
  }

  /// Visit a `ThrowStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ThrowStmtSyntax) -> RawThrowStmtSyntax {
    return visitChildren(node).as(RawThrowStmtSyntax.self)!
  }

  /// Visit a `IfStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IfStmtSyntax) -> RawIfStmtSyntax {
    return visitChildren(node).as(RawIfStmtSyntax.self)!
  }

  /// Visit a `SwitchCaseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseSyntax) -> RawSwitchCaseSyntax {
    return visitChildren(node).as(RawSwitchCaseSyntax.self)!
  }

  /// Visit a `SwitchDefaultLabelSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchDefaultLabelSyntax) -> RawSwitchDefaultLabelSyntax {
    return visitChildren(node).as(RawSwitchDefaultLabelSyntax.self)!
  }

  /// Visit a `CaseItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CaseItemSyntax) -> RawCaseItemSyntax {
    return visitChildren(node).as(RawCaseItemSyntax.self)!
  }

  /// Visit a `CatchItemSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchItemSyntax) -> RawCatchItemSyntax {
    return visitChildren(node).as(RawCatchItemSyntax.self)!
  }

  /// Visit a `SwitchCaseLabelSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SwitchCaseLabelSyntax) -> RawSwitchCaseLabelSyntax {
    return visitChildren(node).as(RawSwitchCaseLabelSyntax.self)!
  }

  /// Visit a `CatchClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CatchClauseSyntax) -> RawCatchClauseSyntax {
    return visitChildren(node).as(RawCatchClauseSyntax.self)!
  }

  /// Visit a `PoundAssertStmtSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PoundAssertStmtSyntax) -> RawPoundAssertStmtSyntax {
    return visitChildren(node).as(RawPoundAssertStmtSyntax.self)!
  }

  /// Visit a `GenericWhereClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericWhereClauseSyntax) -> RawGenericWhereClauseSyntax {
    return visitChildren(node).as(RawGenericWhereClauseSyntax.self)!
  }

  /// Visit a `GenericRequirementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericRequirementListSyntax) -> RawGenericRequirementListSyntax {
    return visitChildren(node).as(RawGenericRequirementListSyntax.self)!
  }

  /// Visit a `GenericRequirementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericRequirementSyntax) -> RawGenericRequirementSyntax {
    return visitChildren(node).as(RawGenericRequirementSyntax.self)!
  }

  /// Visit a `SameTypeRequirementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SameTypeRequirementSyntax) -> RawSameTypeRequirementSyntax {
    return visitChildren(node).as(RawSameTypeRequirementSyntax.self)!
  }

  /// Visit a `LayoutRequirementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: LayoutRequirementSyntax) -> RawLayoutRequirementSyntax {
    return visitChildren(node).as(RawLayoutRequirementSyntax.self)!
  }

  /// Visit a `GenericParameterListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterListSyntax) -> RawGenericParameterListSyntax {
    return visitChildren(node).as(RawGenericParameterListSyntax.self)!
  }

  /// Visit a `GenericParameterSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterSyntax) -> RawGenericParameterSyntax {
    return visitChildren(node).as(RawGenericParameterSyntax.self)!
  }

  /// Visit a `PrimaryAssociatedTypeListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrimaryAssociatedTypeListSyntax) -> RawPrimaryAssociatedTypeListSyntax {
    return visitChildren(node).as(RawPrimaryAssociatedTypeListSyntax.self)!
  }

  /// Visit a `PrimaryAssociatedTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrimaryAssociatedTypeSyntax) -> RawPrimaryAssociatedTypeSyntax {
    return visitChildren(node).as(RawPrimaryAssociatedTypeSyntax.self)!
  }

  /// Visit a `GenericParameterClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericParameterClauseSyntax) -> RawGenericParameterClauseSyntax {
    return visitChildren(node).as(RawGenericParameterClauseSyntax.self)!
  }

  /// Visit a `ConformanceRequirementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConformanceRequirementSyntax) -> RawConformanceRequirementSyntax {
    return visitChildren(node).as(RawConformanceRequirementSyntax.self)!
  }

  /// Visit a `PrimaryAssociatedTypeClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PrimaryAssociatedTypeClauseSyntax) -> RawPrimaryAssociatedTypeClauseSyntax {
    return visitChildren(node).as(RawPrimaryAssociatedTypeClauseSyntax.self)!
  }

  /// Visit a `SimpleTypeIdentifierSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: SimpleTypeIdentifierSyntax) -> RawSimpleTypeIdentifierSyntax {
    return visitChildren(node).as(RawSimpleTypeIdentifierSyntax.self)!
  }

  /// Visit a `MemberTypeIdentifierSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MemberTypeIdentifierSyntax) -> RawMemberTypeIdentifierSyntax {
    return visitChildren(node).as(RawMemberTypeIdentifierSyntax.self)!
  }

  /// Visit a `ClassRestrictionTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ClassRestrictionTypeSyntax) -> RawClassRestrictionTypeSyntax {
    return visitChildren(node).as(RawClassRestrictionTypeSyntax.self)!
  }

  /// Visit a `ArrayTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ArrayTypeSyntax) -> RawArrayTypeSyntax {
    return visitChildren(node).as(RawArrayTypeSyntax.self)!
  }

  /// Visit a `DictionaryTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: DictionaryTypeSyntax) -> RawDictionaryTypeSyntax {
    return visitChildren(node).as(RawDictionaryTypeSyntax.self)!
  }

  /// Visit a `MetatypeTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: MetatypeTypeSyntax) -> RawMetatypeTypeSyntax {
    return visitChildren(node).as(RawMetatypeTypeSyntax.self)!
  }

  /// Visit a `OptionalTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalTypeSyntax) -> RawOptionalTypeSyntax {
    return visitChildren(node).as(RawOptionalTypeSyntax.self)!
  }

  /// Visit a `ConstrainedSugarTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ConstrainedSugarTypeSyntax) -> RawConstrainedSugarTypeSyntax {
    return visitChildren(node).as(RawConstrainedSugarTypeSyntax.self)!
  }

  /// Visit a `ImplicitlyUnwrappedOptionalTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> RawImplicitlyUnwrappedOptionalTypeSyntax {
    return visitChildren(node).as(RawImplicitlyUnwrappedOptionalTypeSyntax.self)!
  }

  /// Visit a `CompositionTypeElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeElementSyntax) -> RawCompositionTypeElementSyntax {
    return visitChildren(node).as(RawCompositionTypeElementSyntax.self)!
  }

  /// Visit a `CompositionTypeElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeElementListSyntax) -> RawCompositionTypeElementListSyntax {
    return visitChildren(node).as(RawCompositionTypeElementListSyntax.self)!
  }

  /// Visit a `CompositionTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: CompositionTypeSyntax) -> RawCompositionTypeSyntax {
    return visitChildren(node).as(RawCompositionTypeSyntax.self)!
  }

  /// Visit a `PackExpansionTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: PackExpansionTypeSyntax) -> RawPackExpansionTypeSyntax {
    return visitChildren(node).as(RawPackExpansionTypeSyntax.self)!
  }

  /// Visit a `TupleTypeElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeElementSyntax) -> RawTupleTypeElementSyntax {
    return visitChildren(node).as(RawTupleTypeElementSyntax.self)!
  }

  /// Visit a `TupleTypeElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeElementListSyntax) -> RawTupleTypeElementListSyntax {
    return visitChildren(node).as(RawTupleTypeElementListSyntax.self)!
  }

  /// Visit a `TupleTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TupleTypeSyntax) -> RawTupleTypeSyntax {
    return visitChildren(node).as(RawTupleTypeSyntax.self)!
  }

  /// Visit a `FunctionTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: FunctionTypeSyntax) -> RawFunctionTypeSyntax {
    return visitChildren(node).as(RawFunctionTypeSyntax.self)!
  }

  /// Visit a `AttributedTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AttributedTypeSyntax) -> RawAttributedTypeSyntax {
    return visitChildren(node).as(RawAttributedTypeSyntax.self)!
  }

  /// Visit a `GenericArgumentListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentListSyntax) -> RawGenericArgumentListSyntax {
    return visitChildren(node).as(RawGenericArgumentListSyntax.self)!
  }

  /// Visit a `GenericArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentSyntax) -> RawGenericArgumentSyntax {
    return visitChildren(node).as(RawGenericArgumentSyntax.self)!
  }

  /// Visit a `GenericArgumentClauseSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: GenericArgumentClauseSyntax) -> RawGenericArgumentClauseSyntax {
    return visitChildren(node).as(RawGenericArgumentClauseSyntax.self)!
  }

  /// Visit a `NamedOpaqueReturnTypeSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: NamedOpaqueReturnTypeSyntax) -> RawNamedOpaqueReturnTypeSyntax {
    return visitChildren(node).as(RawNamedOpaqueReturnTypeSyntax.self)!
  }

  /// Visit a `TypeAnnotationSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TypeAnnotationSyntax) -> RawTypeAnnotationSyntax {
    return visitChildren(node).as(RawTypeAnnotationSyntax.self)!
  }

  /// Visit a `EnumCasePatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: EnumCasePatternSyntax) -> RawEnumCasePatternSyntax {
    return visitChildren(node).as(RawEnumCasePatternSyntax.self)!
  }

  /// Visit a `IsTypePatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IsTypePatternSyntax) -> RawIsTypePatternSyntax {
    return visitChildren(node).as(RawIsTypePatternSyntax.self)!
  }

  /// Visit a `OptionalPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: OptionalPatternSyntax) -> RawOptionalPatternSyntax {
    return visitChildren(node).as(RawOptionalPatternSyntax.self)!
  }

  /// Visit a `IdentifierPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: IdentifierPatternSyntax) -> RawIdentifierPatternSyntax {
    return visitChildren(node).as(RawIdentifierPatternSyntax.self)!
  }

  /// Visit a `AsTypePatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AsTypePatternSyntax) -> RawAsTypePatternSyntax {
    return visitChildren(node).as(RawAsTypePatternSyntax.self)!
  }

  /// Visit a `TuplePatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternSyntax) -> RawTuplePatternSyntax {
    return visitChildren(node).as(RawTuplePatternSyntax.self)!
  }

  /// Visit a `WildcardPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: WildcardPatternSyntax) -> RawWildcardPatternSyntax {
    return visitChildren(node).as(RawWildcardPatternSyntax.self)!
  }

  /// Visit a `TuplePatternElementSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternElementSyntax) -> RawTuplePatternElementSyntax {
    return visitChildren(node).as(RawTuplePatternElementSyntax.self)!
  }

  /// Visit a `ExpressionPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ExpressionPatternSyntax) -> RawExpressionPatternSyntax {
    return visitChildren(node).as(RawExpressionPatternSyntax.self)!
  }

  /// Visit a `TuplePatternElementListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: TuplePatternElementListSyntax) -> RawTuplePatternElementListSyntax {
    return visitChildren(node).as(RawTuplePatternElementListSyntax.self)!
  }

  /// Visit a `ValueBindingPatternSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: ValueBindingPatternSyntax) -> RawValueBindingPatternSyntax {
    return visitChildren(node).as(RawValueBindingPatternSyntax.self)!
  }

  /// Visit a `AvailabilitySpecListSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilitySpecListSyntax) -> RawAvailabilitySpecListSyntax {
    return visitChildren(node).as(RawAvailabilitySpecListSyntax.self)!
  }

  /// Visit a `AvailabilityArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityArgumentSyntax) -> RawAvailabilityArgumentSyntax {
    return visitChildren(node).as(RawAvailabilityArgumentSyntax.self)!
  }

  /// Visit a `AvailabilityLabeledArgumentSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityLabeledArgumentSyntax) -> RawAvailabilityLabeledArgumentSyntax {
    return visitChildren(node).as(RawAvailabilityLabeledArgumentSyntax.self)!
  }

  /// Visit a `AvailabilityVersionRestrictionSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: AvailabilityVersionRestrictionSyntax) -> RawAvailabilityVersionRestrictionSyntax {
    return visitChildren(node).as(RawAvailabilityVersionRestrictionSyntax.self)!
  }

  /// Visit a `VersionTupleSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: VersionTupleSyntax) -> RawVersionTupleSyntax {
    return visitChildren(node).as(RawVersionTupleSyntax.self)!
  }


  /// Visit a `TokenSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ token: TokenSyntax) -> RawTokenSyntax {
    return token.raw.as(RawTokenSyntax.self)!
  }
  
  /// Visit an `UnknownSyntax`.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  open func visit(_ node: UnknownSyntax) -> RawSyntax {
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
  open func visitAny(_ node: Syntax) -> RawSyntax? {
    return nil
  }

  /// The function called after visiting the node and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: Syntax) {}

  /// Visit any Syntax node.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  public func visit(_ node: Syntax) -> RawSyntax {
    return visit(node.data)
  }

  /// Visit any DeclSyntax node.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  public func visit(_ node: DeclSyntax) -> RawDeclSyntax {
    return visit(node.data).as(RawDeclSyntax.self)!
  }

  /// Visit any ExprSyntax node.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  public func visit(_ node: ExprSyntax) -> RawExprSyntax {
    return visit(node.data).as(RawExprSyntax.self)!
  }

  /// Visit any PatternSyntax node.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  public func visit(_ node: PatternSyntax) -> RawPatternSyntax {
    return visit(node.data).as(RawPatternSyntax.self)!
  }

  /// Visit any StmtSyntax node.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  public func visit(_ node: StmtSyntax) -> RawStmtSyntax {
    return visit(node.data).as(RawStmtSyntax.self)!
  }

  /// Visit any TypeSyntax node.
  ///   - Parameter node: the node that is being visited
  ///   - Returns: the rewritten node
  public func visit(_ node: TypeSyntax) -> RawTypeSyntax {
    return visit(node.data).as(RawTypeSyntax.self)!
  }


  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownPatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnknownPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MissingSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MissingDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MissingExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MissingStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MissingTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMissingPatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MissingPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockItemSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CodeBlockItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockItemListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CodeBlockItemListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCodeBlockSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CodeBlockSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnexpectedNodesSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnexpectedNodesSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInOutExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = InOutExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundColumnExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundColumnExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TupleExprElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ArrayElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DictionaryElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringLiteralSegmentsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = StringLiteralSegmentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTryExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAwaitExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AwaitExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMoveExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MoveExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeclNameArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeclNameArgumentListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameArgumentsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeclNameArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IdentifierExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSuperRefExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SuperRefExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNilLiteralExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = NilLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDiscardAssignmentExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DiscardAssignmentExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAssignmentExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AssignmentExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSequenceExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SequenceExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExprListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ExprListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundLineExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundLineExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFileExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundFileExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFileIDExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundFileIDExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFilePathExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundFilePathExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundFunctionExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundFunctionExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundDsohandleExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundDsohandleExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSymbolicReferenceExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SymbolicReferenceExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrefixOperatorExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrefixOperatorExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBinaryOperatorExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = BinaryOperatorExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrowExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ArrowExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInfixOperatorExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = InfixOperatorExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFloatLiteralExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FloatLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TupleExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ArrayExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DictionaryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleExprElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TupleExprElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ArrayElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DictionaryElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIntegerLiteralExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IntegerLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBooleanLiteralExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = BooleanLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedTernaryExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnresolvedTernaryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTernaryExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TernaryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberAccessExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MemberAccessExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedIsExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnresolvedIsExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIsExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IsExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedAsExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnresolvedAsExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAsExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AsExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TypeExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureItemSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClosureCaptureItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureItemListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClosureCaptureItemListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureCaptureSignatureSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClosureCaptureSignatureSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureParamSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClosureParamSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureParamListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClosureParamListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureSignatureSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClosureSignatureSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClosureExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClosureExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnresolvedPatternExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnresolvedPatternExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MultipleTrailingClosureElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MultipleTrailingClosureElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionCallExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FunctionCallExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSubscriptExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SubscriptExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalChainingExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = OptionalChainingExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplForcedValueExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ForcedValueExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPostfixUnaryExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PostfixUnaryExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSpecializeExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SpecializeExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringSegmentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = StringSegmentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionSegmentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ExpressionSegmentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStringLiteralExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = StringLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplRegexLiteralExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = RegexLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = KeyPathExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathComponentListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = KeyPathComponentListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathComponentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = KeyPathComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathPropertyComponentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = KeyPathPropertyComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathSubscriptComponentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = KeyPathSubscriptComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathOptionalComponentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = KeyPathOptionalComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOldKeyPathExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = OldKeyPathExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplKeyPathBaseExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = KeyPathBaseExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcNamePieceSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ObjcNamePieceSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcNameSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ObjcNameSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcKeyPathExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ObjcKeyPathExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjcSelectorExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ObjcSelectorExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPostfixIfConfigExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PostfixIfConfigExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEditorPlaceholderExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = EditorPlaceholderExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjectLiteralExprSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ObjectLiteralExprSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldExprListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = YieldExprListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldExprListElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = YieldExprListElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeInitializerClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TypeInitializerClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypealiasDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TypealiasDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAssociatedtypeDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AssociatedtypeDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionParameterListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FunctionParameterListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplParameterClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ParameterClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplReturnClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ReturnClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionSignatureSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FunctionSignatureSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IfConfigClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigClauseListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IfConfigClauseListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfConfigDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IfConfigDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundErrorDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundErrorDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundWarningDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundWarningDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundSourceLocationSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundSourceLocationSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundSourceLocationArgsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundSourceLocationArgsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclModifierDetailSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeclModifierDetailSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclModifierSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeclModifierSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInheritedTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = InheritedTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInheritedTypeListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = InheritedTypeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeInheritanceClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TypeInheritanceClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClassDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClassDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplActorDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ActorDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplStructDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = StructDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplProtocolDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ProtocolDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExtensionDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ExtensionDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclBlockSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MemberDeclBlockSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MemberDeclListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberDeclListItemSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MemberDeclListItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSourceFileSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SourceFileSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInitializerClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = InitializerClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionParameterSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FunctionParameterSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplModifierListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ModifierListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FunctionDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplInitializerDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = InitializerDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeinitializerDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeinitializerDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSubscriptDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SubscriptDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessLevelModifierSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AccessLevelModifierSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessPathComponentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AccessPathComponentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessPathSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AccessPathSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImportDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ImportDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorParameterSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AccessorParameterSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AccessorDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AccessorListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAccessorBlockSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AccessorBlockSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternBindingSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PatternBindingSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPatternBindingListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PatternBindingListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplVariableDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = VariableDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = EnumCaseElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = EnumCaseElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCaseDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = EnumCaseDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = EnumDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOperatorDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = OperatorDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDesignatedTypeListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DesignatedTypeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDesignatedTypeElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DesignatedTypeElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOperatorPrecedenceAndTypesSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = OperatorPrecedenceAndTypesSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupDeclSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrecedenceGroupDeclSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAttributeListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrecedenceGroupAttributeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupRelationSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrecedenceGroupRelationSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupNameListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrecedenceGroupNameListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupNameElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrecedenceGroupNameElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAssignmentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrecedenceGroupAssignmentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrecedenceGroupAssociativitySyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrecedenceGroupAssociativitySyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTokenListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TokenListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNonEmptyTokenListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = NonEmptyTokenListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCustomAttributeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CustomAttributeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AttributeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributeListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AttributeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSpecializeAttributeSpecListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SpecializeAttributeSpecListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityEntrySyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AvailabilityEntrySyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplLabeledSpecializeEntrySyntax(_ data: SyntaxData) -> RawSyntax {
      let node = LabeledSpecializeEntrySyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTargetFunctionEntrySyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TargetFunctionEntrySyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNamedAttributeStringArgumentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = NamedAttributeStringArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclNameSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeclNameSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImplementsAttributeArgumentsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ImplementsAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjCSelectorPieceSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ObjCSelectorPieceSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplObjCSelectorSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ObjCSelectorSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiableAttributeArgumentsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DifferentiableAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamsClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DifferentiabilityParamsClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DifferentiabilityParamsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DifferentiabilityParamListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDifferentiabilityParamSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DifferentiabilityParamSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDerivativeRegistrationAttributeArgumentsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DerivativeRegistrationAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplQualifiedDeclNameSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = QualifiedDeclNameSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionDeclNameSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FunctionDeclNameSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployAttributeSpecListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = BackDeployAttributeSpecListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployVersionListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = BackDeployVersionListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBackDeployVersionArgumentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = BackDeployVersionArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOpaqueReturnTypeOfAttributeArgumentsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = OpaqueReturnTypeOfAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConventionAttributeArgumentsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ConventionAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConventionWitnessMethodAttributeArgumentsSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ConventionWitnessMethodAttributeArgumentsSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplLabeledStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = LabeledStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplContinueStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ContinueStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWhileStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = WhileStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeferStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeferStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ExpressionStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SwitchCaseListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplRepeatWhileStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = RepeatWhileStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGuardStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GuardStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWhereClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = WhereClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplForInStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ForInStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SwitchStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchClauseListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CatchClauseListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDoStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DoStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplReturnStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ReturnStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = YieldStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplYieldListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = YieldListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFallthroughStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FallthroughStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplBreakStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = BreakStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCaseItemListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CaseItemListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchItemListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CatchItemListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConditionElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ConditionElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityConditionSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AvailabilityConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMatchingPatternConditionSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MatchingPatternConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalBindingConditionSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = OptionalBindingConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnavailabilityConditionSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = UnavailabilityConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplHasSymbolConditionSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = HasSymbolConditionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConditionElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ConditionElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDeclarationStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DeclarationStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplThrowStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ThrowStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIfStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IfStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SwitchCaseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchDefaultLabelSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SwitchDefaultLabelSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCaseItemSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CaseItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchItemSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CatchItemSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSwitchCaseLabelSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SwitchCaseLabelSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCatchClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CatchClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPoundAssertStmtSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PoundAssertStmtSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericWhereClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericWhereClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericRequirementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericRequirementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericRequirementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericRequirementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSameTypeRequirementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SameTypeRequirementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplLayoutRequirementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = LayoutRequirementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericParameterListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericParameterSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrimaryAssociatedTypeListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrimaryAssociatedTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericParameterClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericParameterClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConformanceRequirementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ConformanceRequirementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PrimaryAssociatedTypeClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplSimpleTypeIdentifierSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = SimpleTypeIdentifierSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMemberTypeIdentifierSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MemberTypeIdentifierSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplClassRestrictionTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ClassRestrictionTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplArrayTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ArrayTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplDictionaryTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = DictionaryTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplMetatypeTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = MetatypeTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = OptionalTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplConstrainedSugarTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ConstrainedSugarTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplImplicitlyUnwrappedOptionalTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CompositionTypeElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CompositionTypeElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplCompositionTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = CompositionTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplPackExpansionTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = PackExpansionTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TupleTypeElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TupleTypeElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTupleTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TupleTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplFunctionTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = FunctionTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAttributedTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AttributedTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericArgumentListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplGenericArgumentClauseSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = GenericArgumentClauseSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplNamedOpaqueReturnTypeSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = NamedOpaqueReturnTypeSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTypeAnnotationSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TypeAnnotationSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplEnumCasePatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = EnumCasePatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIsTypePatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IsTypePatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplOptionalPatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = OptionalPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplIdentifierPatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = IdentifierPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAsTypePatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AsTypePatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TuplePatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplWildcardPatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = WildcardPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternElementSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TuplePatternElementSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplExpressionPatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ExpressionPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTuplePatternElementListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = TuplePatternElementListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplValueBindingPatternSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = ValueBindingPatternSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilitySpecListSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AvailabilitySpecListSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityArgumentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AvailabilityArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityLabeledArgumentSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AvailabilityLabeledArgumentSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplAvailabilityVersionRestrictionSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = AvailabilityVersionRestrictionSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplVersionTupleSyntax(_ data: SyntaxData) -> RawSyntax {
      let node = VersionTupleSyntax(data)
      // Accessing _syntaxNode directly is faster than calling Syntax(node)
      visitPre(node._syntaxNode)
      defer { visitPost(node._syntaxNode) }
      if let newNode = visitAny(node._syntaxNode) { return newNode }
      return RawSyntax(visit(node))
  }


  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplTokenSyntax(_ data: SyntaxData) -> RawSyntax {
    let node = TokenSyntax(data)
    // Accessing _syntaxNode directly is faster than calling Syntax(node)
    visitPre(node._syntaxNode)
    defer { visitPost(node._syntaxNode) }
    if let newNode = visitAny(node._syntaxNode) { return newNode }
    return RawSyntax(visit(node))
  }

  /// Implementation detail of visit(_:). Do not call directly.
  private func visitImplUnknownSyntax(_ data: SyntaxData) -> RawSyntax {
    let node = UnknownSyntax(data)
    // Accessing _syntaxNode directly is faster than calling Syntax(node)
    visitPre(node._syntaxNode)
    defer { visitPost(node._syntaxNode) }
    if let newNode = visitAny(node._syntaxNode) { return newNode }
    return RawSyntax(visit(node))
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
  private func visitationFunc(for data: SyntaxData) -> ((SyntaxData) -> RawSyntax) {
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

  private func visit(_ data: SyntaxData) -> RawSyntax {
    return visitationFunc(for: data)(data)
  }

#else

  private func visit(_ data: SyntaxData) -> RawSyntax {
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
  ) -> RawSyntax {
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
    var rewrittens: ContiguousArray<RawSyntax> = []

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
      if rewritten.pointer != child.pointer {
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

      let newRaw = node.raw.layoutView!.replacingLayout(with: Array(newLayout), arena: arena)
      // 'withExtendedLifetime' to keep 'SyntaxArena's of them alive until here.
      return newRaw
    } else {
      // No child node was rewritten. So no need to change this node as well.
      return node.raw
    }

  }
}
