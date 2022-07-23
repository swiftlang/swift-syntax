//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===------------- SyntaxVisitor.swift - Syntax Visitor class -------------===//
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
    visit(node.syntax)
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
  /// Visiting `AwaitExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AwaitExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AwaitExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AwaitExprSyntax) {}
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
  /// Visiting `PoundFileIDExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundFileIDExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundFileIDExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundFileIDExprSyntax) {}
  /// Visiting `PoundFilePathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PoundFilePathExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PoundFilePathExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PoundFilePathExprSyntax) {}
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
  /// Visiting `MultipleTrailingClosureElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MultipleTrailingClosureElementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MultipleTrailingClosureElementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MultipleTrailingClosureElementSyntax) {}
  /// Visiting `MultipleTrailingClosureElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MultipleTrailingClosureElementListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MultipleTrailingClosureElementListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MultipleTrailingClosureElementListSyntax) {}
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
  /// Visiting `RegexLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: RegexLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `RegexLiteralExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: RegexLiteralExprSyntax) {}
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
  /// Visiting `PostfixIfConfigExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PostfixIfConfigExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PostfixIfConfigExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PostfixIfConfigExprSyntax) {}
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
  /// Visiting `DeclModifierDetailSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DeclModifierDetailSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DeclModifierDetailSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DeclModifierDetailSyntax) {}
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
  /// Visiting `ActorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ActorDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ActorDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ActorDeclSyntax) {}
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
  /// Visiting `AvailabilityEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: AvailabilityEntrySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `AvailabilityEntrySyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: AvailabilityEntrySyntax) {}
  /// Visiting `LabeledSpecializeEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: LabeledSpecializeEntrySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `LabeledSpecializeEntrySyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: LabeledSpecializeEntrySyntax) {}
  /// Visiting `TargetFunctionEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: TargetFunctionEntrySyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `TargetFunctionEntrySyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: TargetFunctionEntrySyntax) {}
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
  /// Visiting `DifferentiableAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DifferentiableAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DifferentiableAttributeArgumentsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DifferentiableAttributeArgumentsSyntax) {}
  /// Visiting `DifferentiabilityParamsClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DifferentiabilityParamsClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DifferentiabilityParamsClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DifferentiabilityParamsClauseSyntax) {}
  /// Visiting `DifferentiabilityParamsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DifferentiabilityParamsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DifferentiabilityParamsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DifferentiabilityParamsSyntax) {}
  /// Visiting `DifferentiabilityParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DifferentiabilityParamListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DifferentiabilityParamListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DifferentiabilityParamListSyntax) {}
  /// Visiting `DifferentiabilityParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DifferentiabilityParamSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DifferentiabilityParamSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DifferentiabilityParamSyntax) {}
  /// Visiting `DerivativeRegistrationAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: DerivativeRegistrationAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `DerivativeRegistrationAttributeArgumentsSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: DerivativeRegistrationAttributeArgumentsSyntax) {}
  /// Visiting `QualifiedDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: QualifiedDeclNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `QualifiedDeclNameSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: QualifiedDeclNameSyntax) {}
  /// Visiting `FunctionDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: FunctionDeclNameSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `FunctionDeclNameSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: FunctionDeclNameSyntax) {}
  /// Visiting `BackDeployAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BackDeployAttributeSpecListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `BackDeployAttributeSpecListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: BackDeployAttributeSpecListSyntax) {}
  /// Visiting `BackDeployVersionListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BackDeployVersionListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `BackDeployVersionListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: BackDeployVersionListSyntax) {}
  /// Visiting `BackDeployVersionArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: BackDeployVersionArgumentSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `BackDeployVersionArgumentSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: BackDeployVersionArgumentSyntax) {}
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
  /// Visiting `CatchItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CatchItemListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CatchItemListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CatchItemListSyntax) {}
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
  /// Visiting `UnavailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnavailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnavailabilityConditionSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnavailabilityConditionSyntax) {}
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
  /// Visiting `CatchItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: CatchItemSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `CatchItemSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: CatchItemSyntax) {}
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
  /// Visiting `PrimaryAssociatedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrimaryAssociatedTypeListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrimaryAssociatedTypeListSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrimaryAssociatedTypeListSyntax) {}
  /// Visiting `PrimaryAssociatedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrimaryAssociatedTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrimaryAssociatedTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrimaryAssociatedTypeSyntax) {}
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
  /// Visiting `PrimaryAssociatedTypeClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PrimaryAssociatedTypeClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PrimaryAssociatedTypeClauseSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PrimaryAssociatedTypeClauseSyntax) {}
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
  /// Visiting `ConstrainedSugarTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: ConstrainedSugarTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `ConstrainedSugarTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: ConstrainedSugarTypeSyntax) {}
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
  private func visitImplDeclSyntax(_ node: Syntax) {
    let node = UnknownDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExprSyntax(_ node: Syntax) {
    let node = UnknownExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStmtSyntax(_ node: Syntax) {
    let node = UnknownStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeSyntax(_ node: Syntax) {
    let node = UnknownTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternSyntax(_ node: Syntax) {
    let node = UnknownPatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownDeclSyntax(_ node: Syntax) {
    let node = UnknownDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownExprSyntax(_ node: Syntax) {
    let node = UnknownExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownStmtSyntax(_ node: Syntax) {
    let node = UnknownStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownTypeSyntax(_ node: Syntax) {
    let node = UnknownTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownPatternSyntax(_ node: Syntax) {
    let node = UnknownPatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockItemSyntax(_ node: Syntax) {
    let node = CodeBlockItemSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockItemListSyntax(_ node: Syntax) {
    let node = CodeBlockItemListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockSyntax(_ node: Syntax) {
    let node = CodeBlockSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInOutExprSyntax(_ node: Syntax) {
    let node = InOutExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundColumnExprSyntax(_ node: Syntax) {
    let node = PoundColumnExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprElementListSyntax(_ node: Syntax) {
    let node = TupleExprElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayElementListSyntax(_ node: Syntax) {
    let node = ArrayElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryElementListSyntax(_ node: Syntax) {
    let node = DictionaryElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringLiteralSegmentsSyntax(_ node: Syntax) {
    let node = StringLiteralSegmentsSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTryExprSyntax(_ node: Syntax) {
    let node = TryExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAwaitExprSyntax(_ node: Syntax) {
    let node = AwaitExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentSyntax(_ node: Syntax) {
    let node = DeclNameArgumentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentListSyntax(_ node: Syntax) {
    let node = DeclNameArgumentListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentsSyntax(_ node: Syntax) {
    let node = DeclNameArgumentsSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierExprSyntax(_ node: Syntax) {
    let node = IdentifierExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSuperRefExprSyntax(_ node: Syntax) {
    let node = SuperRefExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNilLiteralExprSyntax(_ node: Syntax) {
    let node = NilLiteralExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDiscardAssignmentExprSyntax(_ node: Syntax) {
    let node = DiscardAssignmentExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAssignmentExprSyntax(_ node: Syntax) {
    let node = AssignmentExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSequenceExprSyntax(_ node: Syntax) {
    let node = SequenceExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExprListSyntax(_ node: Syntax) {
    let node = ExprListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundLineExprSyntax(_ node: Syntax) {
    let node = PoundLineExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFileExprSyntax(_ node: Syntax) {
    let node = PoundFileExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFileIDExprSyntax(_ node: Syntax) {
    let node = PoundFileIDExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFilePathExprSyntax(_ node: Syntax) {
    let node = PoundFilePathExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFunctionExprSyntax(_ node: Syntax) {
    let node = PoundFunctionExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundDsohandleExprSyntax(_ node: Syntax) {
    let node = PoundDsohandleExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSymbolicReferenceExprSyntax(_ node: Syntax) {
    let node = SymbolicReferenceExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrefixOperatorExprSyntax(_ node: Syntax) {
    let node = PrefixOperatorExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBinaryOperatorExprSyntax(_ node: Syntax) {
    let node = BinaryOperatorExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrowExprSyntax(_ node: Syntax) {
    let node = ArrowExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFloatLiteralExprSyntax(_ node: Syntax) {
    let node = FloatLiteralExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprSyntax(_ node: Syntax) {
    let node = TupleExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayExprSyntax(_ node: Syntax) {
    let node = ArrayExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryExprSyntax(_ node: Syntax) {
    let node = DictionaryExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprElementSyntax(_ node: Syntax) {
    let node = TupleExprElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayElementSyntax(_ node: Syntax) {
    let node = ArrayElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryElementSyntax(_ node: Syntax) {
    let node = DictionaryElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIntegerLiteralExprSyntax(_ node: Syntax) {
    let node = IntegerLiteralExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBooleanLiteralExprSyntax(_ node: Syntax) {
    let node = BooleanLiteralExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTernaryExprSyntax(_ node: Syntax) {
    let node = TernaryExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberAccessExprSyntax(_ node: Syntax) {
    let node = MemberAccessExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIsExprSyntax(_ node: Syntax) {
    let node = IsExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAsExprSyntax(_ node: Syntax) {
    let node = AsExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeExprSyntax(_ node: Syntax) {
    let node = TypeExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureItemSyntax(_ node: Syntax) {
    let node = ClosureCaptureItemSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureItemListSyntax(_ node: Syntax) {
    let node = ClosureCaptureItemListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureSignatureSyntax(_ node: Syntax) {
    let node = ClosureCaptureSignatureSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureParamSyntax(_ node: Syntax) {
    let node = ClosureParamSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureParamListSyntax(_ node: Syntax) {
    let node = ClosureParamListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureSignatureSyntax(_ node: Syntax) {
    let node = ClosureSignatureSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureExprSyntax(_ node: Syntax) {
    let node = ClosureExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnresolvedPatternExprSyntax(_ node: Syntax) {
    let node = UnresolvedPatternExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementSyntax(_ node: Syntax) {
    let node = MultipleTrailingClosureElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementListSyntax(_ node: Syntax) {
    let node = MultipleTrailingClosureElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionCallExprSyntax(_ node: Syntax) {
    let node = FunctionCallExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSubscriptExprSyntax(_ node: Syntax) {
    let node = SubscriptExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalChainingExprSyntax(_ node: Syntax) {
    let node = OptionalChainingExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplForcedValueExprSyntax(_ node: Syntax) {
    let node = ForcedValueExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPostfixUnaryExprSyntax(_ node: Syntax) {
    let node = PostfixUnaryExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSpecializeExprSyntax(_ node: Syntax) {
    let node = SpecializeExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringSegmentSyntax(_ node: Syntax) {
    let node = StringSegmentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionSegmentSyntax(_ node: Syntax) {
    let node = ExpressionSegmentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringLiteralExprSyntax(_ node: Syntax) {
    let node = StringLiteralExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplRegexLiteralExprSyntax(_ node: Syntax) {
    let node = RegexLiteralExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplKeyPathExprSyntax(_ node: Syntax) {
    let node = KeyPathExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplKeyPathBaseExprSyntax(_ node: Syntax) {
    let node = KeyPathBaseExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcNamePieceSyntax(_ node: Syntax) {
    let node = ObjcNamePieceSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcNameSyntax(_ node: Syntax) {
    let node = ObjcNameSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcKeyPathExprSyntax(_ node: Syntax) {
    let node = ObjcKeyPathExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcSelectorExprSyntax(_ node: Syntax) {
    let node = ObjcSelectorExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPostfixIfConfigExprSyntax(_ node: Syntax) {
    let node = PostfixIfConfigExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEditorPlaceholderExprSyntax(_ node: Syntax) {
    let node = EditorPlaceholderExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjectLiteralExprSyntax(_ node: Syntax) {
    let node = ObjectLiteralExprSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeInitializerClauseSyntax(_ node: Syntax) {
    let node = TypeInitializerClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypealiasDeclSyntax(_ node: Syntax) {
    let node = TypealiasDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAssociatedtypeDeclSyntax(_ node: Syntax) {
    let node = AssociatedtypeDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionParameterListSyntax(_ node: Syntax) {
    let node = FunctionParameterListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplParameterClauseSyntax(_ node: Syntax) {
    let node = ParameterClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplReturnClauseSyntax(_ node: Syntax) {
    let node = ReturnClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionSignatureSyntax(_ node: Syntax) {
    let node = FunctionSignatureSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigClauseSyntax(_ node: Syntax) {
    let node = IfConfigClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigClauseListSyntax(_ node: Syntax) {
    let node = IfConfigClauseListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigDeclSyntax(_ node: Syntax) {
    let node = IfConfigDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundErrorDeclSyntax(_ node: Syntax) {
    let node = PoundErrorDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundWarningDeclSyntax(_ node: Syntax) {
    let node = PoundWarningDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundSourceLocationSyntax(_ node: Syntax) {
    let node = PoundSourceLocationSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundSourceLocationArgsSyntax(_ node: Syntax) {
    let node = PoundSourceLocationArgsSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclModifierDetailSyntax(_ node: Syntax) {
    let node = DeclModifierDetailSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclModifierSyntax(_ node: Syntax) {
    let node = DeclModifierSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInheritedTypeSyntax(_ node: Syntax) {
    let node = InheritedTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInheritedTypeListSyntax(_ node: Syntax) {
    let node = InheritedTypeListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeInheritanceClauseSyntax(_ node: Syntax) {
    let node = TypeInheritanceClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClassDeclSyntax(_ node: Syntax) {
    let node = ClassDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplActorDeclSyntax(_ node: Syntax) {
    let node = ActorDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStructDeclSyntax(_ node: Syntax) {
    let node = StructDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplProtocolDeclSyntax(_ node: Syntax) {
    let node = ProtocolDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExtensionDeclSyntax(_ node: Syntax) {
    let node = ExtensionDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclBlockSyntax(_ node: Syntax) {
    let node = MemberDeclBlockSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclListSyntax(_ node: Syntax) {
    let node = MemberDeclListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclListItemSyntax(_ node: Syntax) {
    let node = MemberDeclListItemSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSourceFileSyntax(_ node: Syntax) {
    let node = SourceFileSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInitializerClauseSyntax(_ node: Syntax) {
    let node = InitializerClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionParameterSyntax(_ node: Syntax) {
    let node = FunctionParameterSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplModifierListSyntax(_ node: Syntax) {
    let node = ModifierListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionDeclSyntax(_ node: Syntax) {
    let node = FunctionDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInitializerDeclSyntax(_ node: Syntax) {
    let node = InitializerDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeinitializerDeclSyntax(_ node: Syntax) {
    let node = DeinitializerDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSubscriptDeclSyntax(_ node: Syntax) {
    let node = SubscriptDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessLevelModifierSyntax(_ node: Syntax) {
    let node = AccessLevelModifierSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessPathComponentSyntax(_ node: Syntax) {
    let node = AccessPathComponentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessPathSyntax(_ node: Syntax) {
    let node = AccessPathSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImportDeclSyntax(_ node: Syntax) {
    let node = ImportDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorParameterSyntax(_ node: Syntax) {
    let node = AccessorParameterSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorDeclSyntax(_ node: Syntax) {
    let node = AccessorDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorListSyntax(_ node: Syntax) {
    let node = AccessorListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorBlockSyntax(_ node: Syntax) {
    let node = AccessorBlockSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternBindingSyntax(_ node: Syntax) {
    let node = PatternBindingSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternBindingListSyntax(_ node: Syntax) {
    let node = PatternBindingListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplVariableDeclSyntax(_ node: Syntax) {
    let node = VariableDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseElementSyntax(_ node: Syntax) {
    let node = EnumCaseElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseElementListSyntax(_ node: Syntax) {
    let node = EnumCaseElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseDeclSyntax(_ node: Syntax) {
    let node = EnumCaseDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumDeclSyntax(_ node: Syntax) {
    let node = EnumDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOperatorDeclSyntax(_ node: Syntax) {
    let node = OperatorDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierListSyntax(_ node: Syntax) {
    let node = IdentifierListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOperatorPrecedenceAndTypesSyntax(_ node: Syntax) {
    let node = OperatorPrecedenceAndTypesSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupDeclSyntax(_ node: Syntax) {
    let node = PrecedenceGroupDeclSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAttributeListSyntax(_ node: Syntax) {
    let node = PrecedenceGroupAttributeListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupRelationSyntax(_ node: Syntax) {
    let node = PrecedenceGroupRelationSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupNameListSyntax(_ node: Syntax) {
    let node = PrecedenceGroupNameListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupNameElementSyntax(_ node: Syntax) {
    let node = PrecedenceGroupNameElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAssignmentSyntax(_ node: Syntax) {
    let node = PrecedenceGroupAssignmentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAssociativitySyntax(_ node: Syntax) {
    let node = PrecedenceGroupAssociativitySyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTokenListSyntax(_ node: Syntax) {
    let node = TokenListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNonEmptyTokenListSyntax(_ node: Syntax) {
    let node = NonEmptyTokenListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCustomAttributeSyntax(_ node: Syntax) {
    let node = CustomAttributeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributeSyntax(_ node: Syntax) {
    let node = AttributeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributeListSyntax(_ node: Syntax) {
    let node = AttributeListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSpecializeAttributeSpecListSyntax(_ node: Syntax) {
    let node = SpecializeAttributeSpecListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityEntrySyntax(_ node: Syntax) {
    let node = AvailabilityEntrySyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplLabeledSpecializeEntrySyntax(_ node: Syntax) {
    let node = LabeledSpecializeEntrySyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTargetFunctionEntrySyntax(_ node: Syntax) {
    let node = TargetFunctionEntrySyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNamedAttributeStringArgumentSyntax(_ node: Syntax) {
    let node = NamedAttributeStringArgumentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameSyntax(_ node: Syntax) {
    let node = DeclNameSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImplementsAttributeArgumentsSyntax(_ node: Syntax) {
    let node = ImplementsAttributeArgumentsSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjCSelectorPieceSyntax(_ node: Syntax) {
    let node = ObjCSelectorPieceSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjCSelectorSyntax(_ node: Syntax) {
    let node = ObjCSelectorSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiableAttributeArgumentsSyntax(_ node: Syntax) {
    let node = DifferentiableAttributeArgumentsSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiabilityParamsClauseSyntax(_ node: Syntax) {
    let node = DifferentiabilityParamsClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiabilityParamsSyntax(_ node: Syntax) {
    let node = DifferentiabilityParamsSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiabilityParamListSyntax(_ node: Syntax) {
    let node = DifferentiabilityParamListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiabilityParamSyntax(_ node: Syntax) {
    let node = DifferentiabilityParamSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDerivativeRegistrationAttributeArgumentsSyntax(_ node: Syntax) {
    let node = DerivativeRegistrationAttributeArgumentsSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplQualifiedDeclNameSyntax(_ node: Syntax) {
    let node = QualifiedDeclNameSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionDeclNameSyntax(_ node: Syntax) {
    let node = FunctionDeclNameSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBackDeployAttributeSpecListSyntax(_ node: Syntax) {
    let node = BackDeployAttributeSpecListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBackDeployVersionListSyntax(_ node: Syntax) {
    let node = BackDeployVersionListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBackDeployVersionArgumentSyntax(_ node: Syntax) {
    let node = BackDeployVersionArgumentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplContinueStmtSyntax(_ node: Syntax) {
    let node = ContinueStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWhileStmtSyntax(_ node: Syntax) {
    let node = WhileStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeferStmtSyntax(_ node: Syntax) {
    let node = DeferStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionStmtSyntax(_ node: Syntax) {
    let node = ExpressionStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseListSyntax(_ node: Syntax) {
    let node = SwitchCaseListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplRepeatWhileStmtSyntax(_ node: Syntax) {
    let node = RepeatWhileStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGuardStmtSyntax(_ node: Syntax) {
    let node = GuardStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWhereClauseSyntax(_ node: Syntax) {
    let node = WhereClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplForInStmtSyntax(_ node: Syntax) {
    let node = ForInStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchStmtSyntax(_ node: Syntax) {
    let node = SwitchStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchClauseListSyntax(_ node: Syntax) {
    let node = CatchClauseListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDoStmtSyntax(_ node: Syntax) {
    let node = DoStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplReturnStmtSyntax(_ node: Syntax) {
    let node = ReturnStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplYieldStmtSyntax(_ node: Syntax) {
    let node = YieldStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplYieldListSyntax(_ node: Syntax) {
    let node = YieldListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFallthroughStmtSyntax(_ node: Syntax) {
    let node = FallthroughStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBreakStmtSyntax(_ node: Syntax) {
    let node = BreakStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCaseItemListSyntax(_ node: Syntax) {
    let node = CaseItemListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchItemListSyntax(_ node: Syntax) {
    let node = CatchItemListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConditionElementSyntax(_ node: Syntax) {
    let node = ConditionElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityConditionSyntax(_ node: Syntax) {
    let node = AvailabilityConditionSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMatchingPatternConditionSyntax(_ node: Syntax) {
    let node = MatchingPatternConditionSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalBindingConditionSyntax(_ node: Syntax) {
    let node = OptionalBindingConditionSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnavailabilityConditionSyntax(_ node: Syntax) {
    let node = UnavailabilityConditionSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConditionElementListSyntax(_ node: Syntax) {
    let node = ConditionElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclarationStmtSyntax(_ node: Syntax) {
    let node = DeclarationStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplThrowStmtSyntax(_ node: Syntax) {
    let node = ThrowStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfStmtSyntax(_ node: Syntax) {
    let node = IfStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplElseIfContinuationSyntax(_ node: Syntax) {
    let node = ElseIfContinuationSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplElseBlockSyntax(_ node: Syntax) {
    let node = ElseBlockSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseSyntax(_ node: Syntax) {
    let node = SwitchCaseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchDefaultLabelSyntax(_ node: Syntax) {
    let node = SwitchDefaultLabelSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCaseItemSyntax(_ node: Syntax) {
    let node = CaseItemSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchItemSyntax(_ node: Syntax) {
    let node = CatchItemSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseLabelSyntax(_ node: Syntax) {
    let node = SwitchCaseLabelSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchClauseSyntax(_ node: Syntax) {
    let node = CatchClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundAssertStmtSyntax(_ node: Syntax) {
    let node = PoundAssertStmtSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericWhereClauseSyntax(_ node: Syntax) {
    let node = GenericWhereClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericRequirementListSyntax(_ node: Syntax) {
    let node = GenericRequirementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericRequirementSyntax(_ node: Syntax) {
    let node = GenericRequirementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSameTypeRequirementSyntax(_ node: Syntax) {
    let node = SameTypeRequirementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterListSyntax(_ node: Syntax) {
    let node = GenericParameterListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterSyntax(_ node: Syntax) {
    let node = GenericParameterSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeListSyntax(_ node: Syntax) {
    let node = PrimaryAssociatedTypeListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeSyntax(_ node: Syntax) {
    let node = PrimaryAssociatedTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterClauseSyntax(_ node: Syntax) {
    let node = GenericParameterClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConformanceRequirementSyntax(_ node: Syntax) {
    let node = ConformanceRequirementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeClauseSyntax(_ node: Syntax) {
    let node = PrimaryAssociatedTypeClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSimpleTypeIdentifierSyntax(_ node: Syntax) {
    let node = SimpleTypeIdentifierSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberTypeIdentifierSyntax(_ node: Syntax) {
    let node = MemberTypeIdentifierSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClassRestrictionTypeSyntax(_ node: Syntax) {
    let node = ClassRestrictionTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayTypeSyntax(_ node: Syntax) {
    let node = ArrayTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryTypeSyntax(_ node: Syntax) {
    let node = DictionaryTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMetatypeTypeSyntax(_ node: Syntax) {
    let node = MetatypeTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalTypeSyntax(_ node: Syntax) {
    let node = OptionalTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConstrainedSugarTypeSyntax(_ node: Syntax) {
    let node = ConstrainedSugarTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImplicitlyUnwrappedOptionalTypeSyntax(_ node: Syntax) {
    let node = ImplicitlyUnwrappedOptionalTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeElementSyntax(_ node: Syntax) {
    let node = CompositionTypeElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeElementListSyntax(_ node: Syntax) {
    let node = CompositionTypeElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeSyntax(_ node: Syntax) {
    let node = CompositionTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeElementSyntax(_ node: Syntax) {
    let node = TupleTypeElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeElementListSyntax(_ node: Syntax) {
    let node = TupleTypeElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeSyntax(_ node: Syntax) {
    let node = TupleTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionTypeSyntax(_ node: Syntax) {
    let node = FunctionTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributedTypeSyntax(_ node: Syntax) {
    let node = AttributedTypeSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentListSyntax(_ node: Syntax) {
    let node = GenericArgumentListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentSyntax(_ node: Syntax) {
    let node = GenericArgumentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentClauseSyntax(_ node: Syntax) {
    let node = GenericArgumentClauseSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeAnnotationSyntax(_ node: Syntax) {
    let node = TypeAnnotationSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCasePatternSyntax(_ node: Syntax) {
    let node = EnumCasePatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIsTypePatternSyntax(_ node: Syntax) {
    let node = IsTypePatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalPatternSyntax(_ node: Syntax) {
    let node = OptionalPatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierPatternSyntax(_ node: Syntax) {
    let node = IdentifierPatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAsTypePatternSyntax(_ node: Syntax) {
    let node = AsTypePatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternSyntax(_ node: Syntax) {
    let node = TuplePatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWildcardPatternSyntax(_ node: Syntax) {
    let node = WildcardPatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternElementSyntax(_ node: Syntax) {
    let node = TuplePatternElementSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionPatternSyntax(_ node: Syntax) {
    let node = ExpressionPatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternElementListSyntax(_ node: Syntax) {
    let node = TuplePatternElementListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplValueBindingPatternSyntax(_ node: Syntax) {
    let node = ValueBindingPatternSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilitySpecListSyntax(_ node: Syntax) {
    let node = AvailabilitySpecListSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityArgumentSyntax(_ node: Syntax) {
    let node = AvailabilityArgumentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityLabeledArgumentSyntax(_ node: Syntax) {
    let node = AvailabilityLabeledArgumentSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityVersionRestrictionSyntax(_ node: Syntax) {
    let node = AvailabilityVersionRestrictionSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }
  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplVersionTupleSyntax(_ node: Syntax) {
    let node = VersionTupleSyntax(data: node.data)
    if visit(node) == .visitChildren {
      for child in node.children { visit(child) }
    }
    visitPost(node)
  }

  private func visit(_ node: Syntax) {
    switch node.syntaxKind {
    case .token:
      let node = TokenSyntax(data: node.data)
      _ = visit(node)
      // No children to visit.
      visitPost(node)
    case .unknown:
      let node = UnknownSyntax(data: node.data)
      if visit(node) == .visitChildren {
        for child in node.children { visit(child) }
      }
      visitPost(node)
    // The implementation of every generated case goes into its own function. This
    // circumvents an issue where the compiler allocates stack space for every
    // case statement next to each other in debug builds, causing it to allocate
    // ~50KB per call to this function. rdar://55929175
    case .decl: visitImplDeclSyntax(node)
    case .expr: visitImplExprSyntax(node)
    case .stmt: visitImplStmtSyntax(node)
    case .type: visitImplTypeSyntax(node)
    case .pattern: visitImplPatternSyntax(node)
    case .unknownDecl: visitImplUnknownDeclSyntax(node)
    case .unknownExpr: visitImplUnknownExprSyntax(node)
    case .unknownStmt: visitImplUnknownStmtSyntax(node)
    case .unknownType: visitImplUnknownTypeSyntax(node)
    case .unknownPattern: visitImplUnknownPatternSyntax(node)
    case .codeBlockItem: visitImplCodeBlockItemSyntax(node)
    case .codeBlockItemList: visitImplCodeBlockItemListSyntax(node)
    case .codeBlock: visitImplCodeBlockSyntax(node)
    case .inOutExpr: visitImplInOutExprSyntax(node)
    case .poundColumnExpr: visitImplPoundColumnExprSyntax(node)
    case .tupleExprElementList: visitImplTupleExprElementListSyntax(node)
    case .arrayElementList: visitImplArrayElementListSyntax(node)
    case .dictionaryElementList: visitImplDictionaryElementListSyntax(node)
    case .stringLiteralSegments: visitImplStringLiteralSegmentsSyntax(node)
    case .tryExpr: visitImplTryExprSyntax(node)
    case .awaitExpr: visitImplAwaitExprSyntax(node)
    case .declNameArgument: visitImplDeclNameArgumentSyntax(node)
    case .declNameArgumentList: visitImplDeclNameArgumentListSyntax(node)
    case .declNameArguments: visitImplDeclNameArgumentsSyntax(node)
    case .identifierExpr: visitImplIdentifierExprSyntax(node)
    case .superRefExpr: visitImplSuperRefExprSyntax(node)
    case .nilLiteralExpr: visitImplNilLiteralExprSyntax(node)
    case .discardAssignmentExpr: visitImplDiscardAssignmentExprSyntax(node)
    case .assignmentExpr: visitImplAssignmentExprSyntax(node)
    case .sequenceExpr: visitImplSequenceExprSyntax(node)
    case .exprList: visitImplExprListSyntax(node)
    case .poundLineExpr: visitImplPoundLineExprSyntax(node)
    case .poundFileExpr: visitImplPoundFileExprSyntax(node)
    case .poundFileIDExpr: visitImplPoundFileIDExprSyntax(node)
    case .poundFilePathExpr: visitImplPoundFilePathExprSyntax(node)
    case .poundFunctionExpr: visitImplPoundFunctionExprSyntax(node)
    case .poundDsohandleExpr: visitImplPoundDsohandleExprSyntax(node)
    case .symbolicReferenceExpr: visitImplSymbolicReferenceExprSyntax(node)
    case .prefixOperatorExpr: visitImplPrefixOperatorExprSyntax(node)
    case .binaryOperatorExpr: visitImplBinaryOperatorExprSyntax(node)
    case .arrowExpr: visitImplArrowExprSyntax(node)
    case .floatLiteralExpr: visitImplFloatLiteralExprSyntax(node)
    case .tupleExpr: visitImplTupleExprSyntax(node)
    case .arrayExpr: visitImplArrayExprSyntax(node)
    case .dictionaryExpr: visitImplDictionaryExprSyntax(node)
    case .tupleExprElement: visitImplTupleExprElementSyntax(node)
    case .arrayElement: visitImplArrayElementSyntax(node)
    case .dictionaryElement: visitImplDictionaryElementSyntax(node)
    case .integerLiteralExpr: visitImplIntegerLiteralExprSyntax(node)
    case .booleanLiteralExpr: visitImplBooleanLiteralExprSyntax(node)
    case .ternaryExpr: visitImplTernaryExprSyntax(node)
    case .memberAccessExpr: visitImplMemberAccessExprSyntax(node)
    case .isExpr: visitImplIsExprSyntax(node)
    case .asExpr: visitImplAsExprSyntax(node)
    case .typeExpr: visitImplTypeExprSyntax(node)
    case .closureCaptureItem: visitImplClosureCaptureItemSyntax(node)
    case .closureCaptureItemList: visitImplClosureCaptureItemListSyntax(node)
    case .closureCaptureSignature: visitImplClosureCaptureSignatureSyntax(node)
    case .closureParam: visitImplClosureParamSyntax(node)
    case .closureParamList: visitImplClosureParamListSyntax(node)
    case .closureSignature: visitImplClosureSignatureSyntax(node)
    case .closureExpr: visitImplClosureExprSyntax(node)
    case .unresolvedPatternExpr: visitImplUnresolvedPatternExprSyntax(node)
    case .multipleTrailingClosureElement: visitImplMultipleTrailingClosureElementSyntax(node)
    case .multipleTrailingClosureElementList: visitImplMultipleTrailingClosureElementListSyntax(node)
    case .functionCallExpr: visitImplFunctionCallExprSyntax(node)
    case .subscriptExpr: visitImplSubscriptExprSyntax(node)
    case .optionalChainingExpr: visitImplOptionalChainingExprSyntax(node)
    case .forcedValueExpr: visitImplForcedValueExprSyntax(node)
    case .postfixUnaryExpr: visitImplPostfixUnaryExprSyntax(node)
    case .specializeExpr: visitImplSpecializeExprSyntax(node)
    case .stringSegment: visitImplStringSegmentSyntax(node)
    case .expressionSegment: visitImplExpressionSegmentSyntax(node)
    case .stringLiteralExpr: visitImplStringLiteralExprSyntax(node)
    case .regexLiteralExpr: visitImplRegexLiteralExprSyntax(node)
    case .keyPathExpr: visitImplKeyPathExprSyntax(node)
    case .keyPathBaseExpr: visitImplKeyPathBaseExprSyntax(node)
    case .objcNamePiece: visitImplObjcNamePieceSyntax(node)
    case .objcName: visitImplObjcNameSyntax(node)
    case .objcKeyPathExpr: visitImplObjcKeyPathExprSyntax(node)
    case .objcSelectorExpr: visitImplObjcSelectorExprSyntax(node)
    case .postfixIfConfigExpr: visitImplPostfixIfConfigExprSyntax(node)
    case .editorPlaceholderExpr: visitImplEditorPlaceholderExprSyntax(node)
    case .objectLiteralExpr: visitImplObjectLiteralExprSyntax(node)
    case .typeInitializerClause: visitImplTypeInitializerClauseSyntax(node)
    case .typealiasDecl: visitImplTypealiasDeclSyntax(node)
    case .associatedtypeDecl: visitImplAssociatedtypeDeclSyntax(node)
    case .functionParameterList: visitImplFunctionParameterListSyntax(node)
    case .parameterClause: visitImplParameterClauseSyntax(node)
    case .returnClause: visitImplReturnClauseSyntax(node)
    case .functionSignature: visitImplFunctionSignatureSyntax(node)
    case .ifConfigClause: visitImplIfConfigClauseSyntax(node)
    case .ifConfigClauseList: visitImplIfConfigClauseListSyntax(node)
    case .ifConfigDecl: visitImplIfConfigDeclSyntax(node)
    case .poundErrorDecl: visitImplPoundErrorDeclSyntax(node)
    case .poundWarningDecl: visitImplPoundWarningDeclSyntax(node)
    case .poundSourceLocation: visitImplPoundSourceLocationSyntax(node)
    case .poundSourceLocationArgs: visitImplPoundSourceLocationArgsSyntax(node)
    case .declModifierDetail: visitImplDeclModifierDetailSyntax(node)
    case .declModifier: visitImplDeclModifierSyntax(node)
    case .inheritedType: visitImplInheritedTypeSyntax(node)
    case .inheritedTypeList: visitImplInheritedTypeListSyntax(node)
    case .typeInheritanceClause: visitImplTypeInheritanceClauseSyntax(node)
    case .classDecl: visitImplClassDeclSyntax(node)
    case .actorDecl: visitImplActorDeclSyntax(node)
    case .structDecl: visitImplStructDeclSyntax(node)
    case .protocolDecl: visitImplProtocolDeclSyntax(node)
    case .extensionDecl: visitImplExtensionDeclSyntax(node)
    case .memberDeclBlock: visitImplMemberDeclBlockSyntax(node)
    case .memberDeclList: visitImplMemberDeclListSyntax(node)
    case .memberDeclListItem: visitImplMemberDeclListItemSyntax(node)
    case .sourceFile: visitImplSourceFileSyntax(node)
    case .initializerClause: visitImplInitializerClauseSyntax(node)
    case .functionParameter: visitImplFunctionParameterSyntax(node)
    case .modifierList: visitImplModifierListSyntax(node)
    case .functionDecl: visitImplFunctionDeclSyntax(node)
    case .initializerDecl: visitImplInitializerDeclSyntax(node)
    case .deinitializerDecl: visitImplDeinitializerDeclSyntax(node)
    case .subscriptDecl: visitImplSubscriptDeclSyntax(node)
    case .accessLevelModifier: visitImplAccessLevelModifierSyntax(node)
    case .accessPathComponent: visitImplAccessPathComponentSyntax(node)
    case .accessPath: visitImplAccessPathSyntax(node)
    case .importDecl: visitImplImportDeclSyntax(node)
    case .accessorParameter: visitImplAccessorParameterSyntax(node)
    case .accessorDecl: visitImplAccessorDeclSyntax(node)
    case .accessorList: visitImplAccessorListSyntax(node)
    case .accessorBlock: visitImplAccessorBlockSyntax(node)
    case .patternBinding: visitImplPatternBindingSyntax(node)
    case .patternBindingList: visitImplPatternBindingListSyntax(node)
    case .variableDecl: visitImplVariableDeclSyntax(node)
    case .enumCaseElement: visitImplEnumCaseElementSyntax(node)
    case .enumCaseElementList: visitImplEnumCaseElementListSyntax(node)
    case .enumCaseDecl: visitImplEnumCaseDeclSyntax(node)
    case .enumDecl: visitImplEnumDeclSyntax(node)
    case .operatorDecl: visitImplOperatorDeclSyntax(node)
    case .identifierList: visitImplIdentifierListSyntax(node)
    case .operatorPrecedenceAndTypes: visitImplOperatorPrecedenceAndTypesSyntax(node)
    case .precedenceGroupDecl: visitImplPrecedenceGroupDeclSyntax(node)
    case .precedenceGroupAttributeList: visitImplPrecedenceGroupAttributeListSyntax(node)
    case .precedenceGroupRelation: visitImplPrecedenceGroupRelationSyntax(node)
    case .precedenceGroupNameList: visitImplPrecedenceGroupNameListSyntax(node)
    case .precedenceGroupNameElement: visitImplPrecedenceGroupNameElementSyntax(node)
    case .precedenceGroupAssignment: visitImplPrecedenceGroupAssignmentSyntax(node)
    case .precedenceGroupAssociativity: visitImplPrecedenceGroupAssociativitySyntax(node)
    case .tokenList: visitImplTokenListSyntax(node)
    case .nonEmptyTokenList: visitImplNonEmptyTokenListSyntax(node)
    case .customAttribute: visitImplCustomAttributeSyntax(node)
    case .attribute: visitImplAttributeSyntax(node)
    case .attributeList: visitImplAttributeListSyntax(node)
    case .specializeAttributeSpecList: visitImplSpecializeAttributeSpecListSyntax(node)
    case .availabilityEntry: visitImplAvailabilityEntrySyntax(node)
    case .labeledSpecializeEntry: visitImplLabeledSpecializeEntrySyntax(node)
    case .targetFunctionEntry: visitImplTargetFunctionEntrySyntax(node)
    case .namedAttributeStringArgument: visitImplNamedAttributeStringArgumentSyntax(node)
    case .declName: visitImplDeclNameSyntax(node)
    case .implementsAttributeArguments: visitImplImplementsAttributeArgumentsSyntax(node)
    case .objCSelectorPiece: visitImplObjCSelectorPieceSyntax(node)
    case .objCSelector: visitImplObjCSelectorSyntax(node)
    case .differentiableAttributeArguments: visitImplDifferentiableAttributeArgumentsSyntax(node)
    case .differentiabilityParamsClause: visitImplDifferentiabilityParamsClauseSyntax(node)
    case .differentiabilityParams: visitImplDifferentiabilityParamsSyntax(node)
    case .differentiabilityParamList: visitImplDifferentiabilityParamListSyntax(node)
    case .differentiabilityParam: visitImplDifferentiabilityParamSyntax(node)
    case .derivativeRegistrationAttributeArguments: visitImplDerivativeRegistrationAttributeArgumentsSyntax(node)
    case .qualifiedDeclName: visitImplQualifiedDeclNameSyntax(node)
    case .functionDeclName: visitImplFunctionDeclNameSyntax(node)
    case .backDeployAttributeSpecList: visitImplBackDeployAttributeSpecListSyntax(node)
    case .backDeployVersionList: visitImplBackDeployVersionListSyntax(node)
    case .backDeployVersionArgument: visitImplBackDeployVersionArgumentSyntax(node)
    case .continueStmt: visitImplContinueStmtSyntax(node)
    case .whileStmt: visitImplWhileStmtSyntax(node)
    case .deferStmt: visitImplDeferStmtSyntax(node)
    case .expressionStmt: visitImplExpressionStmtSyntax(node)
    case .switchCaseList: visitImplSwitchCaseListSyntax(node)
    case .repeatWhileStmt: visitImplRepeatWhileStmtSyntax(node)
    case .guardStmt: visitImplGuardStmtSyntax(node)
    case .whereClause: visitImplWhereClauseSyntax(node)
    case .forInStmt: visitImplForInStmtSyntax(node)
    case .switchStmt: visitImplSwitchStmtSyntax(node)
    case .catchClauseList: visitImplCatchClauseListSyntax(node)
    case .doStmt: visitImplDoStmtSyntax(node)
    case .returnStmt: visitImplReturnStmtSyntax(node)
    case .yieldStmt: visitImplYieldStmtSyntax(node)
    case .yieldList: visitImplYieldListSyntax(node)
    case .fallthroughStmt: visitImplFallthroughStmtSyntax(node)
    case .breakStmt: visitImplBreakStmtSyntax(node)
    case .caseItemList: visitImplCaseItemListSyntax(node)
    case .catchItemList: visitImplCatchItemListSyntax(node)
    case .conditionElement: visitImplConditionElementSyntax(node)
    case .availabilityCondition: visitImplAvailabilityConditionSyntax(node)
    case .matchingPatternCondition: visitImplMatchingPatternConditionSyntax(node)
    case .optionalBindingCondition: visitImplOptionalBindingConditionSyntax(node)
    case .unavailabilityCondition: visitImplUnavailabilityConditionSyntax(node)
    case .conditionElementList: visitImplConditionElementListSyntax(node)
    case .declarationStmt: visitImplDeclarationStmtSyntax(node)
    case .throwStmt: visitImplThrowStmtSyntax(node)
    case .ifStmt: visitImplIfStmtSyntax(node)
    case .elseIfContinuation: visitImplElseIfContinuationSyntax(node)
    case .elseBlock: visitImplElseBlockSyntax(node)
    case .switchCase: visitImplSwitchCaseSyntax(node)
    case .switchDefaultLabel: visitImplSwitchDefaultLabelSyntax(node)
    case .caseItem: visitImplCaseItemSyntax(node)
    case .catchItem: visitImplCatchItemSyntax(node)
    case .switchCaseLabel: visitImplSwitchCaseLabelSyntax(node)
    case .catchClause: visitImplCatchClauseSyntax(node)
    case .poundAssertStmt: visitImplPoundAssertStmtSyntax(node)
    case .genericWhereClause: visitImplGenericWhereClauseSyntax(node)
    case .genericRequirementList: visitImplGenericRequirementListSyntax(node)
    case .genericRequirement: visitImplGenericRequirementSyntax(node)
    case .sameTypeRequirement: visitImplSameTypeRequirementSyntax(node)
    case .genericParameterList: visitImplGenericParameterListSyntax(node)
    case .genericParameter: visitImplGenericParameterSyntax(node)
    case .primaryAssociatedTypeList: visitImplPrimaryAssociatedTypeListSyntax(node)
    case .primaryAssociatedType: visitImplPrimaryAssociatedTypeSyntax(node)
    case .genericParameterClause: visitImplGenericParameterClauseSyntax(node)
    case .conformanceRequirement: visitImplConformanceRequirementSyntax(node)
    case .primaryAssociatedTypeClause: visitImplPrimaryAssociatedTypeClauseSyntax(node)
    case .simpleTypeIdentifier: visitImplSimpleTypeIdentifierSyntax(node)
    case .memberTypeIdentifier: visitImplMemberTypeIdentifierSyntax(node)
    case .classRestrictionType: visitImplClassRestrictionTypeSyntax(node)
    case .arrayType: visitImplArrayTypeSyntax(node)
    case .dictionaryType: visitImplDictionaryTypeSyntax(node)
    case .metatypeType: visitImplMetatypeTypeSyntax(node)
    case .optionalType: visitImplOptionalTypeSyntax(node)
    case .constrainedSugarType: visitImplConstrainedSugarTypeSyntax(node)
    case .implicitlyUnwrappedOptionalType: visitImplImplicitlyUnwrappedOptionalTypeSyntax(node)
    case .compositionTypeElement: visitImplCompositionTypeElementSyntax(node)
    case .compositionTypeElementList: visitImplCompositionTypeElementListSyntax(node)
    case .compositionType: visitImplCompositionTypeSyntax(node)
    case .tupleTypeElement: visitImplTupleTypeElementSyntax(node)
    case .tupleTypeElementList: visitImplTupleTypeElementListSyntax(node)
    case .tupleType: visitImplTupleTypeSyntax(node)
    case .functionType: visitImplFunctionTypeSyntax(node)
    case .attributedType: visitImplAttributedTypeSyntax(node)
    case .genericArgumentList: visitImplGenericArgumentListSyntax(node)
    case .genericArgument: visitImplGenericArgumentSyntax(node)
    case .genericArgumentClause: visitImplGenericArgumentClauseSyntax(node)
    case .typeAnnotation: visitImplTypeAnnotationSyntax(node)
    case .enumCasePattern: visitImplEnumCasePatternSyntax(node)
    case .isTypePattern: visitImplIsTypePatternSyntax(node)
    case .optionalPattern: visitImplOptionalPatternSyntax(node)
    case .identifierPattern: visitImplIdentifierPatternSyntax(node)
    case .asTypePattern: visitImplAsTypePatternSyntax(node)
    case .tuplePattern: visitImplTuplePatternSyntax(node)
    case .wildcardPattern: visitImplWildcardPatternSyntax(node)
    case .tuplePatternElement: visitImplTuplePatternElementSyntax(node)
    case .expressionPattern: visitImplExpressionPatternSyntax(node)
    case .tuplePatternElementList: visitImplTuplePatternElementListSyntax(node)
    case .valueBindingPattern: visitImplValueBindingPatternSyntax(node)
    case .availabilitySpecList: visitImplAvailabilitySpecListSyntax(node)
    case .availabilityArgument: visitImplAvailabilityArgumentSyntax(node)
    case .availabilityLabeledArgument: visitImplAvailabilityLabeledArgumentSyntax(node)
    case .availabilityVersionRestriction: visitImplAvailabilityVersionRestrictionSyntax(node)
    case .versionTuple: visitImplVersionTupleSyntax(node)
    }
  }
}
