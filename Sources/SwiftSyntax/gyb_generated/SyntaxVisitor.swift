//// Automatically Generated From SyntaxVisitor.swift.gyb.
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
  public let viewMode: SyntaxTreeViewMode

  @available(*, deprecated, message: "Use init(viewMode:) instead")
  public convenience init() {
    self.init(viewMode: .sourceAccurate)
  }

  public init(viewMode: SyntaxTreeViewMode) {
    self.viewMode = viewMode
  }

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
  /// Visiting `MissingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MissingSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MissingSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MissingSyntax) {}
  /// Visiting `MissingDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MissingDeclSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MissingDeclSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MissingDeclSyntax) {}
  /// Visiting `MissingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MissingExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MissingExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MissingExprSyntax) {}
  /// Visiting `MissingStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MissingStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MissingStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MissingStmtSyntax) {}
  /// Visiting `MissingTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MissingTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MissingTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MissingTypeSyntax) {}
  /// Visiting `MissingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MissingPatternSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MissingPatternSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MissingPatternSyntax) {}
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
  /// Visiting `UnexpectedNodesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnexpectedNodesSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnexpectedNodesSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnexpectedNodesSyntax) {}
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
  /// Visiting `MoveExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: MoveExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `MoveExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: MoveExprSyntax) {}
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
  /// Visiting `InfixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: InfixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `InfixOperatorExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: InfixOperatorExprSyntax) {}
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
  /// Visiting `UnresolvedTernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnresolvedTernaryExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnresolvedTernaryExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnresolvedTernaryExprSyntax) {}
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
  /// Visiting `UnresolvedIsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnresolvedIsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnresolvedIsExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnresolvedIsExprSyntax) {}
  /// Visiting `IsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `IsExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: IsExprSyntax) {}
  /// Visiting `UnresolvedAsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: UnresolvedAsExprSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `UnresolvedAsExprSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: UnresolvedAsExprSyntax) {}
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
  /// Visiting `LabeledStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: LabeledStmtSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `LabeledStmtSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: LabeledStmtSyntax) {}
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
  /// Visiting `LayoutRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: LayoutRequirementSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `LayoutRequirementSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: LayoutRequirementSyntax) {}
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
  /// Visiting `PackExpansionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: how should we continue visiting.
  open func visit(_ node: PackExpansionTypeSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  /// The function called after visiting `PackExpansionTypeSyntax` and its descendents.
  ///   - node: the node we just finished visiting.
  open func visitPost(_ node: PackExpansionTypeSyntax) {}
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
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExprSyntax(_ data: SyntaxData) {
      let node = UnknownExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStmtSyntax(_ data: SyntaxData) {
      let node = UnknownStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeSyntax(_ data: SyntaxData) {
      let node = UnknownTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternSyntax(_ data: SyntaxData) {
      let node = UnknownPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownDeclSyntax(_ data: SyntaxData) {
      let node = UnknownDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownExprSyntax(_ data: SyntaxData) {
      let node = UnknownExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownStmtSyntax(_ data: SyntaxData) {
      let node = UnknownStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownTypeSyntax(_ data: SyntaxData) {
      let node = UnknownTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnknownPatternSyntax(_ data: SyntaxData) {
      let node = UnknownPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMissingSyntax(_ data: SyntaxData) {
      let node = MissingSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMissingDeclSyntax(_ data: SyntaxData) {
      let node = MissingDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMissingExprSyntax(_ data: SyntaxData) {
      let node = MissingExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMissingStmtSyntax(_ data: SyntaxData) {
      let node = MissingStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMissingTypeSyntax(_ data: SyntaxData) {
      let node = MissingTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMissingPatternSyntax(_ data: SyntaxData) {
      let node = MissingPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockItemSyntax(_ data: SyntaxData) {
      let node = CodeBlockItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockItemListSyntax(_ data: SyntaxData) {
      let node = CodeBlockItemListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCodeBlockSyntax(_ data: SyntaxData) {
      let node = CodeBlockSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnexpectedNodesSyntax(_ data: SyntaxData) {
      let node = UnexpectedNodesSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInOutExprSyntax(_ data: SyntaxData) {
      let node = InOutExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundColumnExprSyntax(_ data: SyntaxData) {
      let node = PoundColumnExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprElementListSyntax(_ data: SyntaxData) {
      let node = TupleExprElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayElementListSyntax(_ data: SyntaxData) {
      let node = ArrayElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryElementListSyntax(_ data: SyntaxData) {
      let node = DictionaryElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringLiteralSegmentsSyntax(_ data: SyntaxData) {
      let node = StringLiteralSegmentsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTryExprSyntax(_ data: SyntaxData) {
      let node = TryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAwaitExprSyntax(_ data: SyntaxData) {
      let node = AwaitExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMoveExprSyntax(_ data: SyntaxData) {
      let node = MoveExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentSyntax(_ data: SyntaxData) {
      let node = DeclNameArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentListSyntax(_ data: SyntaxData) {
      let node = DeclNameArgumentListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameArgumentsSyntax(_ data: SyntaxData) {
      let node = DeclNameArgumentsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierExprSyntax(_ data: SyntaxData) {
      let node = IdentifierExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSuperRefExprSyntax(_ data: SyntaxData) {
      let node = SuperRefExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNilLiteralExprSyntax(_ data: SyntaxData) {
      let node = NilLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDiscardAssignmentExprSyntax(_ data: SyntaxData) {
      let node = DiscardAssignmentExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAssignmentExprSyntax(_ data: SyntaxData) {
      let node = AssignmentExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSequenceExprSyntax(_ data: SyntaxData) {
      let node = SequenceExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExprListSyntax(_ data: SyntaxData) {
      let node = ExprListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundLineExprSyntax(_ data: SyntaxData) {
      let node = PoundLineExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFileExprSyntax(_ data: SyntaxData) {
      let node = PoundFileExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFileIDExprSyntax(_ data: SyntaxData) {
      let node = PoundFileIDExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFilePathExprSyntax(_ data: SyntaxData) {
      let node = PoundFilePathExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundFunctionExprSyntax(_ data: SyntaxData) {
      let node = PoundFunctionExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundDsohandleExprSyntax(_ data: SyntaxData) {
      let node = PoundDsohandleExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSymbolicReferenceExprSyntax(_ data: SyntaxData) {
      let node = SymbolicReferenceExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrefixOperatorExprSyntax(_ data: SyntaxData) {
      let node = PrefixOperatorExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBinaryOperatorExprSyntax(_ data: SyntaxData) {
      let node = BinaryOperatorExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrowExprSyntax(_ data: SyntaxData) {
      let node = ArrowExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInfixOperatorExprSyntax(_ data: SyntaxData) {
      let node = InfixOperatorExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFloatLiteralExprSyntax(_ data: SyntaxData) {
      let node = FloatLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprSyntax(_ data: SyntaxData) {
      let node = TupleExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayExprSyntax(_ data: SyntaxData) {
      let node = ArrayExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryExprSyntax(_ data: SyntaxData) {
      let node = DictionaryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleExprElementSyntax(_ data: SyntaxData) {
      let node = TupleExprElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayElementSyntax(_ data: SyntaxData) {
      let node = ArrayElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryElementSyntax(_ data: SyntaxData) {
      let node = DictionaryElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIntegerLiteralExprSyntax(_ data: SyntaxData) {
      let node = IntegerLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBooleanLiteralExprSyntax(_ data: SyntaxData) {
      let node = BooleanLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnresolvedTernaryExprSyntax(_ data: SyntaxData) {
      let node = UnresolvedTernaryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTernaryExprSyntax(_ data: SyntaxData) {
      let node = TernaryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberAccessExprSyntax(_ data: SyntaxData) {
      let node = MemberAccessExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnresolvedIsExprSyntax(_ data: SyntaxData) {
      let node = UnresolvedIsExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIsExprSyntax(_ data: SyntaxData) {
      let node = IsExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnresolvedAsExprSyntax(_ data: SyntaxData) {
      let node = UnresolvedAsExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAsExprSyntax(_ data: SyntaxData) {
      let node = AsExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeExprSyntax(_ data: SyntaxData) {
      let node = TypeExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureItemSyntax(_ data: SyntaxData) {
      let node = ClosureCaptureItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureItemListSyntax(_ data: SyntaxData) {
      let node = ClosureCaptureItemListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureCaptureSignatureSyntax(_ data: SyntaxData) {
      let node = ClosureCaptureSignatureSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureParamSyntax(_ data: SyntaxData) {
      let node = ClosureParamSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureParamListSyntax(_ data: SyntaxData) {
      let node = ClosureParamListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureSignatureSyntax(_ data: SyntaxData) {
      let node = ClosureSignatureSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClosureExprSyntax(_ data: SyntaxData) {
      let node = ClosureExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnresolvedPatternExprSyntax(_ data: SyntaxData) {
      let node = UnresolvedPatternExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementSyntax(_ data: SyntaxData) {
      let node = MultipleTrailingClosureElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMultipleTrailingClosureElementListSyntax(_ data: SyntaxData) {
      let node = MultipleTrailingClosureElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionCallExprSyntax(_ data: SyntaxData) {
      let node = FunctionCallExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSubscriptExprSyntax(_ data: SyntaxData) {
      let node = SubscriptExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalChainingExprSyntax(_ data: SyntaxData) {
      let node = OptionalChainingExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplForcedValueExprSyntax(_ data: SyntaxData) {
      let node = ForcedValueExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPostfixUnaryExprSyntax(_ data: SyntaxData) {
      let node = PostfixUnaryExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSpecializeExprSyntax(_ data: SyntaxData) {
      let node = SpecializeExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringSegmentSyntax(_ data: SyntaxData) {
      let node = StringSegmentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionSegmentSyntax(_ data: SyntaxData) {
      let node = ExpressionSegmentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStringLiteralExprSyntax(_ data: SyntaxData) {
      let node = StringLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplRegexLiteralExprSyntax(_ data: SyntaxData) {
      let node = RegexLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplKeyPathExprSyntax(_ data: SyntaxData) {
      let node = KeyPathExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplKeyPathBaseExprSyntax(_ data: SyntaxData) {
      let node = KeyPathBaseExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcNamePieceSyntax(_ data: SyntaxData) {
      let node = ObjcNamePieceSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcNameSyntax(_ data: SyntaxData) {
      let node = ObjcNameSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcKeyPathExprSyntax(_ data: SyntaxData) {
      let node = ObjcKeyPathExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjcSelectorExprSyntax(_ data: SyntaxData) {
      let node = ObjcSelectorExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPostfixIfConfigExprSyntax(_ data: SyntaxData) {
      let node = PostfixIfConfigExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEditorPlaceholderExprSyntax(_ data: SyntaxData) {
      let node = EditorPlaceholderExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjectLiteralExprSyntax(_ data: SyntaxData) {
      let node = ObjectLiteralExprSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeInitializerClauseSyntax(_ data: SyntaxData) {
      let node = TypeInitializerClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypealiasDeclSyntax(_ data: SyntaxData) {
      let node = TypealiasDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAssociatedtypeDeclSyntax(_ data: SyntaxData) {
      let node = AssociatedtypeDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionParameterListSyntax(_ data: SyntaxData) {
      let node = FunctionParameterListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplParameterClauseSyntax(_ data: SyntaxData) {
      let node = ParameterClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplReturnClauseSyntax(_ data: SyntaxData) {
      let node = ReturnClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionSignatureSyntax(_ data: SyntaxData) {
      let node = FunctionSignatureSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigClauseSyntax(_ data: SyntaxData) {
      let node = IfConfigClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigClauseListSyntax(_ data: SyntaxData) {
      let node = IfConfigClauseListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfConfigDeclSyntax(_ data: SyntaxData) {
      let node = IfConfigDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundErrorDeclSyntax(_ data: SyntaxData) {
      let node = PoundErrorDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundWarningDeclSyntax(_ data: SyntaxData) {
      let node = PoundWarningDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundSourceLocationSyntax(_ data: SyntaxData) {
      let node = PoundSourceLocationSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundSourceLocationArgsSyntax(_ data: SyntaxData) {
      let node = PoundSourceLocationArgsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclModifierDetailSyntax(_ data: SyntaxData) {
      let node = DeclModifierDetailSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclModifierSyntax(_ data: SyntaxData) {
      let node = DeclModifierSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInheritedTypeSyntax(_ data: SyntaxData) {
      let node = InheritedTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInheritedTypeListSyntax(_ data: SyntaxData) {
      let node = InheritedTypeListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeInheritanceClauseSyntax(_ data: SyntaxData) {
      let node = TypeInheritanceClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClassDeclSyntax(_ data: SyntaxData) {
      let node = ClassDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplActorDeclSyntax(_ data: SyntaxData) {
      let node = ActorDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplStructDeclSyntax(_ data: SyntaxData) {
      let node = StructDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplProtocolDeclSyntax(_ data: SyntaxData) {
      let node = ProtocolDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExtensionDeclSyntax(_ data: SyntaxData) {
      let node = ExtensionDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclBlockSyntax(_ data: SyntaxData) {
      let node = MemberDeclBlockSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclListSyntax(_ data: SyntaxData) {
      let node = MemberDeclListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberDeclListItemSyntax(_ data: SyntaxData) {
      let node = MemberDeclListItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSourceFileSyntax(_ data: SyntaxData) {
      let node = SourceFileSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInitializerClauseSyntax(_ data: SyntaxData) {
      let node = InitializerClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionParameterSyntax(_ data: SyntaxData) {
      let node = FunctionParameterSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplModifierListSyntax(_ data: SyntaxData) {
      let node = ModifierListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionDeclSyntax(_ data: SyntaxData) {
      let node = FunctionDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplInitializerDeclSyntax(_ data: SyntaxData) {
      let node = InitializerDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeinitializerDeclSyntax(_ data: SyntaxData) {
      let node = DeinitializerDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSubscriptDeclSyntax(_ data: SyntaxData) {
      let node = SubscriptDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessLevelModifierSyntax(_ data: SyntaxData) {
      let node = AccessLevelModifierSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessPathComponentSyntax(_ data: SyntaxData) {
      let node = AccessPathComponentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessPathSyntax(_ data: SyntaxData) {
      let node = AccessPathSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImportDeclSyntax(_ data: SyntaxData) {
      let node = ImportDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorParameterSyntax(_ data: SyntaxData) {
      let node = AccessorParameterSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorDeclSyntax(_ data: SyntaxData) {
      let node = AccessorDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorListSyntax(_ data: SyntaxData) {
      let node = AccessorListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAccessorBlockSyntax(_ data: SyntaxData) {
      let node = AccessorBlockSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternBindingSyntax(_ data: SyntaxData) {
      let node = PatternBindingSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPatternBindingListSyntax(_ data: SyntaxData) {
      let node = PatternBindingListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplVariableDeclSyntax(_ data: SyntaxData) {
      let node = VariableDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseElementSyntax(_ data: SyntaxData) {
      let node = EnumCaseElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseElementListSyntax(_ data: SyntaxData) {
      let node = EnumCaseElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCaseDeclSyntax(_ data: SyntaxData) {
      let node = EnumCaseDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumDeclSyntax(_ data: SyntaxData) {
      let node = EnumDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOperatorDeclSyntax(_ data: SyntaxData) {
      let node = OperatorDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierListSyntax(_ data: SyntaxData) {
      let node = IdentifierListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOperatorPrecedenceAndTypesSyntax(_ data: SyntaxData) {
      let node = OperatorPrecedenceAndTypesSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupDeclSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupDeclSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAttributeListSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupAttributeListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupRelationSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupRelationSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupNameListSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupNameListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupNameElementSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupNameElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAssignmentSyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupAssignmentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrecedenceGroupAssociativitySyntax(_ data: SyntaxData) {
      let node = PrecedenceGroupAssociativitySyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTokenListSyntax(_ data: SyntaxData) {
      let node = TokenListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNonEmptyTokenListSyntax(_ data: SyntaxData) {
      let node = NonEmptyTokenListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCustomAttributeSyntax(_ data: SyntaxData) {
      let node = CustomAttributeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributeSyntax(_ data: SyntaxData) {
      let node = AttributeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributeListSyntax(_ data: SyntaxData) {
      let node = AttributeListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSpecializeAttributeSpecListSyntax(_ data: SyntaxData) {
      let node = SpecializeAttributeSpecListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityEntrySyntax(_ data: SyntaxData) {
      let node = AvailabilityEntrySyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplLabeledSpecializeEntrySyntax(_ data: SyntaxData) {
      let node = LabeledSpecializeEntrySyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTargetFunctionEntrySyntax(_ data: SyntaxData) {
      let node = TargetFunctionEntrySyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplNamedAttributeStringArgumentSyntax(_ data: SyntaxData) {
      let node = NamedAttributeStringArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclNameSyntax(_ data: SyntaxData) {
      let node = DeclNameSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImplementsAttributeArgumentsSyntax(_ data: SyntaxData) {
      let node = ImplementsAttributeArgumentsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjCSelectorPieceSyntax(_ data: SyntaxData) {
      let node = ObjCSelectorPieceSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplObjCSelectorSyntax(_ data: SyntaxData) {
      let node = ObjCSelectorSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiableAttributeArgumentsSyntax(_ data: SyntaxData) {
      let node = DifferentiableAttributeArgumentsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiabilityParamsClauseSyntax(_ data: SyntaxData) {
      let node = DifferentiabilityParamsClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiabilityParamsSyntax(_ data: SyntaxData) {
      let node = DifferentiabilityParamsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiabilityParamListSyntax(_ data: SyntaxData) {
      let node = DifferentiabilityParamListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDifferentiabilityParamSyntax(_ data: SyntaxData) {
      let node = DifferentiabilityParamSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDerivativeRegistrationAttributeArgumentsSyntax(_ data: SyntaxData) {
      let node = DerivativeRegistrationAttributeArgumentsSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplQualifiedDeclNameSyntax(_ data: SyntaxData) {
      let node = QualifiedDeclNameSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionDeclNameSyntax(_ data: SyntaxData) {
      let node = FunctionDeclNameSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBackDeployAttributeSpecListSyntax(_ data: SyntaxData) {
      let node = BackDeployAttributeSpecListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBackDeployVersionListSyntax(_ data: SyntaxData) {
      let node = BackDeployVersionListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBackDeployVersionArgumentSyntax(_ data: SyntaxData) {
      let node = BackDeployVersionArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplLabeledStmtSyntax(_ data: SyntaxData) {
      let node = LabeledStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplContinueStmtSyntax(_ data: SyntaxData) {
      let node = ContinueStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWhileStmtSyntax(_ data: SyntaxData) {
      let node = WhileStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeferStmtSyntax(_ data: SyntaxData) {
      let node = DeferStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionStmtSyntax(_ data: SyntaxData) {
      let node = ExpressionStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseListSyntax(_ data: SyntaxData) {
      let node = SwitchCaseListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplRepeatWhileStmtSyntax(_ data: SyntaxData) {
      let node = RepeatWhileStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGuardStmtSyntax(_ data: SyntaxData) {
      let node = GuardStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWhereClauseSyntax(_ data: SyntaxData) {
      let node = WhereClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplForInStmtSyntax(_ data: SyntaxData) {
      let node = ForInStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchStmtSyntax(_ data: SyntaxData) {
      let node = SwitchStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchClauseListSyntax(_ data: SyntaxData) {
      let node = CatchClauseListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDoStmtSyntax(_ data: SyntaxData) {
      let node = DoStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplReturnStmtSyntax(_ data: SyntaxData) {
      let node = ReturnStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplYieldStmtSyntax(_ data: SyntaxData) {
      let node = YieldStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplYieldListSyntax(_ data: SyntaxData) {
      let node = YieldListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFallthroughStmtSyntax(_ data: SyntaxData) {
      let node = FallthroughStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplBreakStmtSyntax(_ data: SyntaxData) {
      let node = BreakStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCaseItemListSyntax(_ data: SyntaxData) {
      let node = CaseItemListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchItemListSyntax(_ data: SyntaxData) {
      let node = CatchItemListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConditionElementSyntax(_ data: SyntaxData) {
      let node = ConditionElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityConditionSyntax(_ data: SyntaxData) {
      let node = AvailabilityConditionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMatchingPatternConditionSyntax(_ data: SyntaxData) {
      let node = MatchingPatternConditionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalBindingConditionSyntax(_ data: SyntaxData) {
      let node = OptionalBindingConditionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplUnavailabilityConditionSyntax(_ data: SyntaxData) {
      let node = UnavailabilityConditionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConditionElementListSyntax(_ data: SyntaxData) {
      let node = ConditionElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDeclarationStmtSyntax(_ data: SyntaxData) {
      let node = DeclarationStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplThrowStmtSyntax(_ data: SyntaxData) {
      let node = ThrowStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIfStmtSyntax(_ data: SyntaxData) {
      let node = IfStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplElseIfContinuationSyntax(_ data: SyntaxData) {
      let node = ElseIfContinuationSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplElseBlockSyntax(_ data: SyntaxData) {
      let node = ElseBlockSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseSyntax(_ data: SyntaxData) {
      let node = SwitchCaseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchDefaultLabelSyntax(_ data: SyntaxData) {
      let node = SwitchDefaultLabelSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCaseItemSyntax(_ data: SyntaxData) {
      let node = CaseItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchItemSyntax(_ data: SyntaxData) {
      let node = CatchItemSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSwitchCaseLabelSyntax(_ data: SyntaxData) {
      let node = SwitchCaseLabelSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCatchClauseSyntax(_ data: SyntaxData) {
      let node = CatchClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPoundAssertStmtSyntax(_ data: SyntaxData) {
      let node = PoundAssertStmtSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericWhereClauseSyntax(_ data: SyntaxData) {
      let node = GenericWhereClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericRequirementListSyntax(_ data: SyntaxData) {
      let node = GenericRequirementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericRequirementSyntax(_ data: SyntaxData) {
      let node = GenericRequirementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSameTypeRequirementSyntax(_ data: SyntaxData) {
      let node = SameTypeRequirementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplLayoutRequirementSyntax(_ data: SyntaxData) {
      let node = LayoutRequirementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterListSyntax(_ data: SyntaxData) {
      let node = GenericParameterListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterSyntax(_ data: SyntaxData) {
      let node = GenericParameterSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeListSyntax(_ data: SyntaxData) {
      let node = PrimaryAssociatedTypeListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeSyntax(_ data: SyntaxData) {
      let node = PrimaryAssociatedTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericParameterClauseSyntax(_ data: SyntaxData) {
      let node = GenericParameterClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConformanceRequirementSyntax(_ data: SyntaxData) {
      let node = ConformanceRequirementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPrimaryAssociatedTypeClauseSyntax(_ data: SyntaxData) {
      let node = PrimaryAssociatedTypeClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplSimpleTypeIdentifierSyntax(_ data: SyntaxData) {
      let node = SimpleTypeIdentifierSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMemberTypeIdentifierSyntax(_ data: SyntaxData) {
      let node = MemberTypeIdentifierSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplClassRestrictionTypeSyntax(_ data: SyntaxData) {
      let node = ClassRestrictionTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplArrayTypeSyntax(_ data: SyntaxData) {
      let node = ArrayTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplDictionaryTypeSyntax(_ data: SyntaxData) {
      let node = DictionaryTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplMetatypeTypeSyntax(_ data: SyntaxData) {
      let node = MetatypeTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalTypeSyntax(_ data: SyntaxData) {
      let node = OptionalTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplConstrainedSugarTypeSyntax(_ data: SyntaxData) {
      let node = ConstrainedSugarTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplImplicitlyUnwrappedOptionalTypeSyntax(_ data: SyntaxData) {
      let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeElementSyntax(_ data: SyntaxData) {
      let node = CompositionTypeElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeElementListSyntax(_ data: SyntaxData) {
      let node = CompositionTypeElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplCompositionTypeSyntax(_ data: SyntaxData) {
      let node = CompositionTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplPackExpansionTypeSyntax(_ data: SyntaxData) {
      let node = PackExpansionTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeElementSyntax(_ data: SyntaxData) {
      let node = TupleTypeElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeElementListSyntax(_ data: SyntaxData) {
      let node = TupleTypeElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTupleTypeSyntax(_ data: SyntaxData) {
      let node = TupleTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplFunctionTypeSyntax(_ data: SyntaxData) {
      let node = FunctionTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAttributedTypeSyntax(_ data: SyntaxData) {
      let node = AttributedTypeSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentListSyntax(_ data: SyntaxData) {
      let node = GenericArgumentListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentSyntax(_ data: SyntaxData) {
      let node = GenericArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplGenericArgumentClauseSyntax(_ data: SyntaxData) {
      let node = GenericArgumentClauseSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTypeAnnotationSyntax(_ data: SyntaxData) {
      let node = TypeAnnotationSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplEnumCasePatternSyntax(_ data: SyntaxData) {
      let node = EnumCasePatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIsTypePatternSyntax(_ data: SyntaxData) {
      let node = IsTypePatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplOptionalPatternSyntax(_ data: SyntaxData) {
      let node = OptionalPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplIdentifierPatternSyntax(_ data: SyntaxData) {
      let node = IdentifierPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAsTypePatternSyntax(_ data: SyntaxData) {
      let node = AsTypePatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternSyntax(_ data: SyntaxData) {
      let node = TuplePatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplWildcardPatternSyntax(_ data: SyntaxData) {
      let node = WildcardPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternElementSyntax(_ data: SyntaxData) {
      let node = TuplePatternElementSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplExpressionPatternSyntax(_ data: SyntaxData) {
      let node = ExpressionPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplTuplePatternElementListSyntax(_ data: SyntaxData) {
      let node = TuplePatternElementListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplValueBindingPatternSyntax(_ data: SyntaxData) {
      let node = ValueBindingPatternSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilitySpecListSyntax(_ data: SyntaxData) {
      let node = AvailabilitySpecListSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityArgumentSyntax(_ data: SyntaxData) {
      let node = AvailabilityArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityLabeledArgumentSyntax(_ data: SyntaxData) {
      let node = AvailabilityLabeledArgumentSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplAvailabilityVersionRestrictionSyntax(_ data: SyntaxData) {
      let node = AvailabilityVersionRestrictionSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
  }

  /// Implementation detail of doVisit(_:_:). Do not call directly.
  private func visitImplVersionTupleSyntax(_ data: SyntaxData) {
      let node = VersionTupleSyntax(data)
      let needsChildren = (visit(node) == .visitChildren)
      // Avoid calling into visitChildren if possible.
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
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
      if needsChildren && !node.raw.layoutView!.children.isEmpty {
        visitChildren(node)
      }
      visitPost(node)
    // The implementation of every generated case goes into its own function. This
    // circumvents an issue where the compiler allocates stack space for every
    // case statement next to each other in debug builds, causing it to allocate
    // ~50KB per call to this function. rdar://55929175
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
    case .missing:
      visitImplMissingSyntax(data)
    case .missingDecl:
      visitImplMissingDeclSyntax(data)
    case .missingExpr:
      visitImplMissingExprSyntax(data)
    case .missingStmt:
      visitImplMissingStmtSyntax(data)
    case .missingType:
      visitImplMissingTypeSyntax(data)
    case .missingPattern:
      visitImplMissingPatternSyntax(data)
    case .codeBlockItem:
      visitImplCodeBlockItemSyntax(data)
    case .codeBlockItemList:
      visitImplCodeBlockItemListSyntax(data)
    case .codeBlock:
      visitImplCodeBlockSyntax(data)
    case .unexpectedNodes:
      visitImplUnexpectedNodesSyntax(data)
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
    case .awaitExpr:
      visitImplAwaitExprSyntax(data)
    case .moveExpr:
      visitImplMoveExprSyntax(data)
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
    case .poundFileIDExpr:
      visitImplPoundFileIDExprSyntax(data)
    case .poundFilePathExpr:
      visitImplPoundFilePathExprSyntax(data)
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
    case .infixOperatorExpr:
      visitImplInfixOperatorExprSyntax(data)
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
    case .unresolvedTernaryExpr:
      visitImplUnresolvedTernaryExprSyntax(data)
    case .ternaryExpr:
      visitImplTernaryExprSyntax(data)
    case .memberAccessExpr:
      visitImplMemberAccessExprSyntax(data)
    case .unresolvedIsExpr:
      visitImplUnresolvedIsExprSyntax(data)
    case .isExpr:
      visitImplIsExprSyntax(data)
    case .unresolvedAsExpr:
      visitImplUnresolvedAsExprSyntax(data)
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
    case .multipleTrailingClosureElement:
      visitImplMultipleTrailingClosureElementSyntax(data)
    case .multipleTrailingClosureElementList:
      visitImplMultipleTrailingClosureElementListSyntax(data)
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
    case .regexLiteralExpr:
      visitImplRegexLiteralExprSyntax(data)
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
    case .postfixIfConfigExpr:
      visitImplPostfixIfConfigExprSyntax(data)
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
    case .declModifierDetail:
      visitImplDeclModifierDetailSyntax(data)
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
    case .actorDecl:
      visitImplActorDeclSyntax(data)
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
    case .availabilityEntry:
      visitImplAvailabilityEntrySyntax(data)
    case .labeledSpecializeEntry:
      visitImplLabeledSpecializeEntrySyntax(data)
    case .targetFunctionEntry:
      visitImplTargetFunctionEntrySyntax(data)
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
    case .differentiableAttributeArguments:
      visitImplDifferentiableAttributeArgumentsSyntax(data)
    case .differentiabilityParamsClause:
      visitImplDifferentiabilityParamsClauseSyntax(data)
    case .differentiabilityParams:
      visitImplDifferentiabilityParamsSyntax(data)
    case .differentiabilityParamList:
      visitImplDifferentiabilityParamListSyntax(data)
    case .differentiabilityParam:
      visitImplDifferentiabilityParamSyntax(data)
    case .derivativeRegistrationAttributeArguments:
      visitImplDerivativeRegistrationAttributeArgumentsSyntax(data)
    case .qualifiedDeclName:
      visitImplQualifiedDeclNameSyntax(data)
    case .functionDeclName:
      visitImplFunctionDeclNameSyntax(data)
    case .backDeployAttributeSpecList:
      visitImplBackDeployAttributeSpecListSyntax(data)
    case .backDeployVersionList:
      visitImplBackDeployVersionListSyntax(data)
    case .backDeployVersionArgument:
      visitImplBackDeployVersionArgumentSyntax(data)
    case .labeledStmt:
      visitImplLabeledStmtSyntax(data)
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
    case .catchItemList:
      visitImplCatchItemListSyntax(data)
    case .conditionElement:
      visitImplConditionElementSyntax(data)
    case .availabilityCondition:
      visitImplAvailabilityConditionSyntax(data)
    case .matchingPatternCondition:
      visitImplMatchingPatternConditionSyntax(data)
    case .optionalBindingCondition:
      visitImplOptionalBindingConditionSyntax(data)
    case .unavailabilityCondition:
      visitImplUnavailabilityConditionSyntax(data)
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
    case .catchItem:
      visitImplCatchItemSyntax(data)
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
    case .layoutRequirement:
      visitImplLayoutRequirementSyntax(data)
    case .genericParameterList:
      visitImplGenericParameterListSyntax(data)
    case .genericParameter:
      visitImplGenericParameterSyntax(data)
    case .primaryAssociatedTypeList:
      visitImplPrimaryAssociatedTypeListSyntax(data)
    case .primaryAssociatedType:
      visitImplPrimaryAssociatedTypeSyntax(data)
    case .genericParameterClause:
      visitImplGenericParameterClauseSyntax(data)
    case .conformanceRequirement:
      visitImplConformanceRequirementSyntax(data)
    case .primaryAssociatedTypeClause:
      visitImplPrimaryAssociatedTypeClauseSyntax(data)
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
    case .constrainedSugarType:
      visitImplConstrainedSugarTypeSyntax(data)
    case .implicitlyUnwrappedOptionalType:
      visitImplImplicitlyUnwrappedOptionalTypeSyntax(data)
    case .compositionTypeElement:
      visitImplCompositionTypeElementSyntax(data)
    case .compositionTypeElementList:
      visitImplCompositionTypeElementListSyntax(data)
    case .compositionType:
      visitImplCompositionTypeSyntax(data)
    case .packExpansionType:
      visitImplPackExpansionTypeSyntax(data)
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
    for childRaw in NonNilRawSyntaxChildren(syntaxNode, viewMode: viewMode) {
      let childData = SyntaxData(childRaw, parent: syntaxNode)
      visit(childData)
    }
  }
}

public protocol SyntaxTransformVisitor {
  associatedtype ResultType = Void
  
  func visit(_ token: TokenSyntax) -> [ResultType]
  func visit(_ node: UnknownSyntax) -> [ResultType]
  
  /// Visiting `UnknownDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownDeclSyntax) -> [ResultType]
  /// Visiting `UnknownExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownExprSyntax) -> [ResultType]
  /// Visiting `UnknownStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownStmtSyntax) -> [ResultType]
  /// Visiting `UnknownTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownTypeSyntax) -> [ResultType]
  /// Visiting `UnknownPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnknownPatternSyntax) -> [ResultType]
  /// Visiting `MissingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingSyntax) -> [ResultType]
  /// Visiting `MissingDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingDeclSyntax) -> [ResultType]
  /// Visiting `MissingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingExprSyntax) -> [ResultType]
  /// Visiting `MissingStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingStmtSyntax) -> [ResultType]
  /// Visiting `MissingTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingTypeSyntax) -> [ResultType]
  /// Visiting `MissingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MissingPatternSyntax) -> [ResultType]
  /// Visiting `CodeBlockItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CodeBlockItemSyntax) -> [ResultType]
  /// Visiting `CodeBlockItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CodeBlockItemListSyntax) -> [ResultType]
  /// Visiting `CodeBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CodeBlockSyntax) -> [ResultType]
  /// Visiting `UnexpectedNodesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnexpectedNodesSyntax) -> [ResultType]
  /// Visiting `InOutExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InOutExprSyntax) -> [ResultType]
  /// Visiting `PoundColumnExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundColumnExprSyntax) -> [ResultType]
  /// Visiting `TupleExprElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleExprElementListSyntax) -> [ResultType]
  /// Visiting `ArrayElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrayElementListSyntax) -> [ResultType]
  /// Visiting `DictionaryElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DictionaryElementListSyntax) -> [ResultType]
  /// Visiting `StringLiteralSegmentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: StringLiteralSegmentsSyntax) -> [ResultType]
  /// Visiting `TryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TryExprSyntax) -> [ResultType]
  /// Visiting `AwaitExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AwaitExprSyntax) -> [ResultType]
  /// Visiting `MoveExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MoveExprSyntax) -> [ResultType]
  /// Visiting `DeclNameArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclNameArgumentSyntax) -> [ResultType]
  /// Visiting `DeclNameArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclNameArgumentListSyntax) -> [ResultType]
  /// Visiting `DeclNameArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclNameArgumentsSyntax) -> [ResultType]
  /// Visiting `IdentifierExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IdentifierExprSyntax) -> [ResultType]
  /// Visiting `SuperRefExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SuperRefExprSyntax) -> [ResultType]
  /// Visiting `NilLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: NilLiteralExprSyntax) -> [ResultType]
  /// Visiting `DiscardAssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DiscardAssignmentExprSyntax) -> [ResultType]
  /// Visiting `AssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AssignmentExprSyntax) -> [ResultType]
  /// Visiting `SequenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SequenceExprSyntax) -> [ResultType]
  /// Visiting `ExprListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExprListSyntax) -> [ResultType]
  /// Visiting `PoundLineExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundLineExprSyntax) -> [ResultType]
  /// Visiting `PoundFileExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundFileExprSyntax) -> [ResultType]
  /// Visiting `PoundFileIDExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundFileIDExprSyntax) -> [ResultType]
  /// Visiting `PoundFilePathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundFilePathExprSyntax) -> [ResultType]
  /// Visiting `PoundFunctionExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundFunctionExprSyntax) -> [ResultType]
  /// Visiting `PoundDsohandleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundDsohandleExprSyntax) -> [ResultType]
  /// Visiting `SymbolicReferenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SymbolicReferenceExprSyntax) -> [ResultType]
  /// Visiting `PrefixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrefixOperatorExprSyntax) -> [ResultType]
  /// Visiting `BinaryOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BinaryOperatorExprSyntax) -> [ResultType]
  /// Visiting `ArrowExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrowExprSyntax) -> [ResultType]
  /// Visiting `InfixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InfixOperatorExprSyntax) -> [ResultType]
  /// Visiting `FloatLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FloatLiteralExprSyntax) -> [ResultType]
  /// Visiting `TupleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleExprSyntax) -> [ResultType]
  /// Visiting `ArrayExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrayExprSyntax) -> [ResultType]
  /// Visiting `DictionaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DictionaryExprSyntax) -> [ResultType]
  /// Visiting `TupleExprElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleExprElementSyntax) -> [ResultType]
  /// Visiting `ArrayElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrayElementSyntax) -> [ResultType]
  /// Visiting `DictionaryElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DictionaryElementSyntax) -> [ResultType]
  /// Visiting `IntegerLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IntegerLiteralExprSyntax) -> [ResultType]
  /// Visiting `BooleanLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BooleanLiteralExprSyntax) -> [ResultType]
  /// Visiting `UnresolvedTernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnresolvedTernaryExprSyntax) -> [ResultType]
  /// Visiting `TernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TernaryExprSyntax) -> [ResultType]
  /// Visiting `MemberAccessExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberAccessExprSyntax) -> [ResultType]
  /// Visiting `UnresolvedIsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnresolvedIsExprSyntax) -> [ResultType]
  /// Visiting `IsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IsExprSyntax) -> [ResultType]
  /// Visiting `UnresolvedAsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnresolvedAsExprSyntax) -> [ResultType]
  /// Visiting `AsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AsExprSyntax) -> [ResultType]
  /// Visiting `TypeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypeExprSyntax) -> [ResultType]
  /// Visiting `ClosureCaptureItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureCaptureItemSyntax) -> [ResultType]
  /// Visiting `ClosureCaptureItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureCaptureItemListSyntax) -> [ResultType]
  /// Visiting `ClosureCaptureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureCaptureSignatureSyntax) -> [ResultType]
  /// Visiting `ClosureParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureParamSyntax) -> [ResultType]
  /// Visiting `ClosureParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureParamListSyntax) -> [ResultType]
  /// Visiting `ClosureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureSignatureSyntax) -> [ResultType]
  /// Visiting `ClosureExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClosureExprSyntax) -> [ResultType]
  /// Visiting `UnresolvedPatternExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnresolvedPatternExprSyntax) -> [ResultType]
  /// Visiting `MultipleTrailingClosureElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MultipleTrailingClosureElementSyntax) -> [ResultType]
  /// Visiting `MultipleTrailingClosureElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MultipleTrailingClosureElementListSyntax) -> [ResultType]
  /// Visiting `FunctionCallExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionCallExprSyntax) -> [ResultType]
  /// Visiting `SubscriptExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SubscriptExprSyntax) -> [ResultType]
  /// Visiting `OptionalChainingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OptionalChainingExprSyntax) -> [ResultType]
  /// Visiting `ForcedValueExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ForcedValueExprSyntax) -> [ResultType]
  /// Visiting `PostfixUnaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PostfixUnaryExprSyntax) -> [ResultType]
  /// Visiting `SpecializeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SpecializeExprSyntax) -> [ResultType]
  /// Visiting `StringSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: StringSegmentSyntax) -> [ResultType]
  /// Visiting `ExpressionSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExpressionSegmentSyntax) -> [ResultType]
  /// Visiting `StringLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: StringLiteralExprSyntax) -> [ResultType]
  /// Visiting `RegexLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: RegexLiteralExprSyntax) -> [ResultType]
  /// Visiting `KeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathExprSyntax) -> [ResultType]
  /// Visiting `KeyPathBaseExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: KeyPathBaseExprSyntax) -> [ResultType]
  /// Visiting `ObjcNamePieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjcNamePieceSyntax) -> [ResultType]
  /// Visiting `ObjcNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjcNameSyntax) -> [ResultType]
  /// Visiting `ObjcKeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjcKeyPathExprSyntax) -> [ResultType]
  /// Visiting `ObjcSelectorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjcSelectorExprSyntax) -> [ResultType]
  /// Visiting `PostfixIfConfigExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PostfixIfConfigExprSyntax) -> [ResultType]
  /// Visiting `EditorPlaceholderExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EditorPlaceholderExprSyntax) -> [ResultType]
  /// Visiting `ObjectLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjectLiteralExprSyntax) -> [ResultType]
  /// Visiting `TypeInitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypeInitializerClauseSyntax) -> [ResultType]
  /// Visiting `TypealiasDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypealiasDeclSyntax) -> [ResultType]
  /// Visiting `AssociatedtypeDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AssociatedtypeDeclSyntax) -> [ResultType]
  /// Visiting `FunctionParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionParameterListSyntax) -> [ResultType]
  /// Visiting `ParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ParameterClauseSyntax) -> [ResultType]
  /// Visiting `ReturnClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ReturnClauseSyntax) -> [ResultType]
  /// Visiting `FunctionSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionSignatureSyntax) -> [ResultType]
  /// Visiting `IfConfigClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IfConfigClauseSyntax) -> [ResultType]
  /// Visiting `IfConfigClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IfConfigClauseListSyntax) -> [ResultType]
  /// Visiting `IfConfigDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IfConfigDeclSyntax) -> [ResultType]
  /// Visiting `PoundErrorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundErrorDeclSyntax) -> [ResultType]
  /// Visiting `PoundWarningDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundWarningDeclSyntax) -> [ResultType]
  /// Visiting `PoundSourceLocationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundSourceLocationSyntax) -> [ResultType]
  /// Visiting `PoundSourceLocationArgsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundSourceLocationArgsSyntax) -> [ResultType]
  /// Visiting `DeclModifierDetailSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclModifierDetailSyntax) -> [ResultType]
  /// Visiting `DeclModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclModifierSyntax) -> [ResultType]
  /// Visiting `InheritedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InheritedTypeSyntax) -> [ResultType]
  /// Visiting `InheritedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InheritedTypeListSyntax) -> [ResultType]
  /// Visiting `TypeInheritanceClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypeInheritanceClauseSyntax) -> [ResultType]
  /// Visiting `ClassDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClassDeclSyntax) -> [ResultType]
  /// Visiting `ActorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ActorDeclSyntax) -> [ResultType]
  /// Visiting `StructDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: StructDeclSyntax) -> [ResultType]
  /// Visiting `ProtocolDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ProtocolDeclSyntax) -> [ResultType]
  /// Visiting `ExtensionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExtensionDeclSyntax) -> [ResultType]
  /// Visiting `MemberDeclBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberDeclBlockSyntax) -> [ResultType]
  /// Visiting `MemberDeclListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberDeclListSyntax) -> [ResultType]
  /// Visiting `MemberDeclListItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberDeclListItemSyntax) -> [ResultType]
  /// Visiting `SourceFileSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SourceFileSyntax) -> [ResultType]
  /// Visiting `InitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InitializerClauseSyntax) -> [ResultType]
  /// Visiting `FunctionParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionParameterSyntax) -> [ResultType]
  /// Visiting `ModifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ModifierListSyntax) -> [ResultType]
  /// Visiting `FunctionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionDeclSyntax) -> [ResultType]
  /// Visiting `InitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: InitializerDeclSyntax) -> [ResultType]
  /// Visiting `DeinitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeinitializerDeclSyntax) -> [ResultType]
  /// Visiting `SubscriptDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SubscriptDeclSyntax) -> [ResultType]
  /// Visiting `AccessLevelModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessLevelModifierSyntax) -> [ResultType]
  /// Visiting `AccessPathComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessPathComponentSyntax) -> [ResultType]
  /// Visiting `AccessPathSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessPathSyntax) -> [ResultType]
  /// Visiting `ImportDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ImportDeclSyntax) -> [ResultType]
  /// Visiting `AccessorParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessorParameterSyntax) -> [ResultType]
  /// Visiting `AccessorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessorDeclSyntax) -> [ResultType]
  /// Visiting `AccessorListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessorListSyntax) -> [ResultType]
  /// Visiting `AccessorBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AccessorBlockSyntax) -> [ResultType]
  /// Visiting `PatternBindingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PatternBindingSyntax) -> [ResultType]
  /// Visiting `PatternBindingListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PatternBindingListSyntax) -> [ResultType]
  /// Visiting `VariableDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: VariableDeclSyntax) -> [ResultType]
  /// Visiting `EnumCaseElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumCaseElementSyntax) -> [ResultType]
  /// Visiting `EnumCaseElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumCaseElementListSyntax) -> [ResultType]
  /// Visiting `EnumCaseDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumCaseDeclSyntax) -> [ResultType]
  /// Visiting `EnumDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumDeclSyntax) -> [ResultType]
  /// Visiting `OperatorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OperatorDeclSyntax) -> [ResultType]
  /// Visiting `IdentifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IdentifierListSyntax) -> [ResultType]
  /// Visiting `OperatorPrecedenceAndTypesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> [ResultType]
  /// Visiting `PrecedenceGroupDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupDeclSyntax) -> [ResultType]
  /// Visiting `PrecedenceGroupAttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupAttributeListSyntax) -> [ResultType]
  /// Visiting `PrecedenceGroupRelationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupRelationSyntax) -> [ResultType]
  /// Visiting `PrecedenceGroupNameListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupNameListSyntax) -> [ResultType]
  /// Visiting `PrecedenceGroupNameElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupNameElementSyntax) -> [ResultType]
  /// Visiting `PrecedenceGroupAssignmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupAssignmentSyntax) -> [ResultType]
  /// Visiting `PrecedenceGroupAssociativitySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrecedenceGroupAssociativitySyntax) -> [ResultType]
  /// Visiting `TokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TokenListSyntax) -> [ResultType]
  /// Visiting `NonEmptyTokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: NonEmptyTokenListSyntax) -> [ResultType]
  /// Visiting `CustomAttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CustomAttributeSyntax) -> [ResultType]
  /// Visiting `AttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AttributeSyntax) -> [ResultType]
  /// Visiting `AttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AttributeListSyntax) -> [ResultType]
  /// Visiting `SpecializeAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SpecializeAttributeSpecListSyntax) -> [ResultType]
  /// Visiting `AvailabilityEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityEntrySyntax) -> [ResultType]
  /// Visiting `LabeledSpecializeEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: LabeledSpecializeEntrySyntax) -> [ResultType]
  /// Visiting `TargetFunctionEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TargetFunctionEntrySyntax) -> [ResultType]
  /// Visiting `NamedAttributeStringArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: NamedAttributeStringArgumentSyntax) -> [ResultType]
  /// Visiting `DeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclNameSyntax) -> [ResultType]
  /// Visiting `ImplementsAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ImplementsAttributeArgumentsSyntax) -> [ResultType]
  /// Visiting `ObjCSelectorPieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjCSelectorPieceSyntax) -> [ResultType]
  /// Visiting `ObjCSelectorSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ObjCSelectorSyntax) -> [ResultType]
  /// Visiting `DifferentiableAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiableAttributeArgumentsSyntax) -> [ResultType]
  /// Visiting `DifferentiabilityParamsClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiabilityParamsClauseSyntax) -> [ResultType]
  /// Visiting `DifferentiabilityParamsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiabilityParamsSyntax) -> [ResultType]
  /// Visiting `DifferentiabilityParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiabilityParamListSyntax) -> [ResultType]
  /// Visiting `DifferentiabilityParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DifferentiabilityParamSyntax) -> [ResultType]
  /// Visiting `DerivativeRegistrationAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DerivativeRegistrationAttributeArgumentsSyntax) -> [ResultType]
  /// Visiting `QualifiedDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: QualifiedDeclNameSyntax) -> [ResultType]
  /// Visiting `FunctionDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionDeclNameSyntax) -> [ResultType]
  /// Visiting `BackDeployAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BackDeployAttributeSpecListSyntax) -> [ResultType]
  /// Visiting `BackDeployVersionListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BackDeployVersionListSyntax) -> [ResultType]
  /// Visiting `BackDeployVersionArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BackDeployVersionArgumentSyntax) -> [ResultType]
  /// Visiting `LabeledStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: LabeledStmtSyntax) -> [ResultType]
  /// Visiting `ContinueStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ContinueStmtSyntax) -> [ResultType]
  /// Visiting `WhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: WhileStmtSyntax) -> [ResultType]
  /// Visiting `DeferStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeferStmtSyntax) -> [ResultType]
  /// Visiting `ExpressionStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExpressionStmtSyntax) -> [ResultType]
  /// Visiting `SwitchCaseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchCaseListSyntax) -> [ResultType]
  /// Visiting `RepeatWhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: RepeatWhileStmtSyntax) -> [ResultType]
  /// Visiting `GuardStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GuardStmtSyntax) -> [ResultType]
  /// Visiting `WhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: WhereClauseSyntax) -> [ResultType]
  /// Visiting `ForInStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ForInStmtSyntax) -> [ResultType]
  /// Visiting `SwitchStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchStmtSyntax) -> [ResultType]
  /// Visiting `CatchClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CatchClauseListSyntax) -> [ResultType]
  /// Visiting `DoStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DoStmtSyntax) -> [ResultType]
  /// Visiting `ReturnStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ReturnStmtSyntax) -> [ResultType]
  /// Visiting `YieldStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: YieldStmtSyntax) -> [ResultType]
  /// Visiting `YieldListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: YieldListSyntax) -> [ResultType]
  /// Visiting `FallthroughStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FallthroughStmtSyntax) -> [ResultType]
  /// Visiting `BreakStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: BreakStmtSyntax) -> [ResultType]
  /// Visiting `CaseItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CaseItemListSyntax) -> [ResultType]
  /// Visiting `CatchItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CatchItemListSyntax) -> [ResultType]
  /// Visiting `ConditionElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConditionElementSyntax) -> [ResultType]
  /// Visiting `AvailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityConditionSyntax) -> [ResultType]
  /// Visiting `MatchingPatternConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MatchingPatternConditionSyntax) -> [ResultType]
  /// Visiting `OptionalBindingConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OptionalBindingConditionSyntax) -> [ResultType]
  /// Visiting `UnavailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: UnavailabilityConditionSyntax) -> [ResultType]
  /// Visiting `ConditionElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConditionElementListSyntax) -> [ResultType]
  /// Visiting `DeclarationStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DeclarationStmtSyntax) -> [ResultType]
  /// Visiting `ThrowStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ThrowStmtSyntax) -> [ResultType]
  /// Visiting `IfStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IfStmtSyntax) -> [ResultType]
  /// Visiting `ElseIfContinuationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ElseIfContinuationSyntax) -> [ResultType]
  /// Visiting `ElseBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ElseBlockSyntax) -> [ResultType]
  /// Visiting `SwitchCaseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchCaseSyntax) -> [ResultType]
  /// Visiting `SwitchDefaultLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchDefaultLabelSyntax) -> [ResultType]
  /// Visiting `CaseItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CaseItemSyntax) -> [ResultType]
  /// Visiting `CatchItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CatchItemSyntax) -> [ResultType]
  /// Visiting `SwitchCaseLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SwitchCaseLabelSyntax) -> [ResultType]
  /// Visiting `CatchClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CatchClauseSyntax) -> [ResultType]
  /// Visiting `PoundAssertStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PoundAssertStmtSyntax) -> [ResultType]
  /// Visiting `GenericWhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericWhereClauseSyntax) -> [ResultType]
  /// Visiting `GenericRequirementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericRequirementListSyntax) -> [ResultType]
  /// Visiting `GenericRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericRequirementSyntax) -> [ResultType]
  /// Visiting `SameTypeRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SameTypeRequirementSyntax) -> [ResultType]
  /// Visiting `LayoutRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: LayoutRequirementSyntax) -> [ResultType]
  /// Visiting `GenericParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericParameterListSyntax) -> [ResultType]
  /// Visiting `GenericParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericParameterSyntax) -> [ResultType]
  /// Visiting `PrimaryAssociatedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrimaryAssociatedTypeListSyntax) -> [ResultType]
  /// Visiting `PrimaryAssociatedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrimaryAssociatedTypeSyntax) -> [ResultType]
  /// Visiting `GenericParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericParameterClauseSyntax) -> [ResultType]
  /// Visiting `ConformanceRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConformanceRequirementSyntax) -> [ResultType]
  /// Visiting `PrimaryAssociatedTypeClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: PrimaryAssociatedTypeClauseSyntax) -> [ResultType]
  /// Visiting `SimpleTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: SimpleTypeIdentifierSyntax) -> [ResultType]
  /// Visiting `MemberTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MemberTypeIdentifierSyntax) -> [ResultType]
  /// Visiting `ClassRestrictionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ClassRestrictionTypeSyntax) -> [ResultType]
  /// Visiting `ArrayTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ArrayTypeSyntax) -> [ResultType]
  /// Visiting `DictionaryTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: DictionaryTypeSyntax) -> [ResultType]
  /// Visiting `MetatypeTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: MetatypeTypeSyntax) -> [ResultType]
  /// Visiting `OptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OptionalTypeSyntax) -> [ResultType]
  /// Visiting `ConstrainedSugarTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ConstrainedSugarTypeSyntax) -> [ResultType]
  /// Visiting `ImplicitlyUnwrappedOptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> [ResultType]
  /// Visiting `CompositionTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CompositionTypeElementSyntax) -> [ResultType]
  /// Visiting `CompositionTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CompositionTypeElementListSyntax) -> [ResultType]
  /// Visiting `CompositionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: CompositionTypeSyntax) -> [ResultType]
  /// Visiting `TupleTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleTypeElementSyntax) -> [ResultType]
  /// Visiting `TupleTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleTypeElementListSyntax) -> [ResultType]
  /// Visiting `TupleTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TupleTypeSyntax) -> [ResultType]
  /// Visiting `FunctionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: FunctionTypeSyntax) -> [ResultType]
  /// Visiting `AttributedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AttributedTypeSyntax) -> [ResultType]
  /// Visiting `GenericArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericArgumentListSyntax) -> [ResultType]
  /// Visiting `GenericArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericArgumentSyntax) -> [ResultType]
  /// Visiting `GenericArgumentClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: GenericArgumentClauseSyntax) -> [ResultType]
  /// Visiting `TypeAnnotationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TypeAnnotationSyntax) -> [ResultType]
  /// Visiting `EnumCasePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: EnumCasePatternSyntax) -> [ResultType]
  /// Visiting `IsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IsTypePatternSyntax) -> [ResultType]
  /// Visiting `OptionalPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: OptionalPatternSyntax) -> [ResultType]
  /// Visiting `IdentifierPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: IdentifierPatternSyntax) -> [ResultType]
  /// Visiting `AsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AsTypePatternSyntax) -> [ResultType]
  /// Visiting `TuplePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TuplePatternSyntax) -> [ResultType]
  /// Visiting `WildcardPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: WildcardPatternSyntax) -> [ResultType]
  /// Visiting `TuplePatternElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TuplePatternElementSyntax) -> [ResultType]
  /// Visiting `ExpressionPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ExpressionPatternSyntax) -> [ResultType]
  /// Visiting `TuplePatternElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: TuplePatternElementListSyntax) -> [ResultType]
  /// Visiting `ValueBindingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: ValueBindingPatternSyntax) -> [ResultType]
  /// Visiting `AvailabilitySpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilitySpecListSyntax) -> [ResultType]
  /// Visiting `AvailabilityArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityArgumentSyntax) -> [ResultType]
  /// Visiting `AvailabilityLabeledArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityLabeledArgumentSyntax) -> [ResultType]
  /// Visiting `AvailabilityVersionRestrictionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: AvailabilityVersionRestrictionSyntax) -> [ResultType]
  /// Visiting `VersionTupleSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: the sum of whatever the child visitors return.
  func visit(_ node: VersionTupleSyntax) -> [ResultType]
}

extension SyntaxTransformVisitor {
  public func visit(_ token: TokenSyntax) -> [ResultType] { [] }
  public func visit(_ node: UnknownSyntax) -> [ResultType] { [] }

  /// Visiting `UnknownDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnknownExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnknownStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnknownTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnknownPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnknownPatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MissingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MissingDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MissingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MissingStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MissingTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MissingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MissingPatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CodeBlockItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CodeBlockItemSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CodeBlockItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CodeBlockItemListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CodeBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CodeBlockSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnexpectedNodesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnexpectedNodesSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `InOutExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InOutExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundColumnExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundColumnExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TupleExprElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleExprElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ArrayElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrayElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DictionaryElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DictionaryElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `StringLiteralSegmentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: StringLiteralSegmentsSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TryExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AwaitExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AwaitExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MoveExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MoveExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeclNameArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclNameArgumentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeclNameArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclNameArgumentListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeclNameArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclNameArgumentsSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IdentifierExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IdentifierExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SuperRefExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SuperRefExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `NilLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: NilLiteralExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DiscardAssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DiscardAssignmentExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AssignmentExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AssignmentExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SequenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SequenceExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ExprListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExprListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundLineExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundLineExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundFileExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundFileExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundFileIDExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundFileIDExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundFilePathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundFilePathExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundFunctionExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundFunctionExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundDsohandleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundDsohandleExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SymbolicReferenceExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SymbolicReferenceExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrefixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrefixOperatorExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `BinaryOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BinaryOperatorExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ArrowExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrowExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `InfixOperatorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InfixOperatorExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FloatLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FloatLiteralExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TupleExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ArrayExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrayExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DictionaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DictionaryExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TupleExprElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleExprElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ArrayElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrayElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DictionaryElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DictionaryElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IntegerLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IntegerLiteralExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `BooleanLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BooleanLiteralExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnresolvedTernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnresolvedTernaryExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TernaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TernaryExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MemberAccessExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberAccessExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnresolvedIsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnresolvedIsExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IsExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnresolvedAsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnresolvedAsExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AsExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AsExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TypeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypeExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClosureCaptureItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureCaptureItemSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClosureCaptureItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureCaptureItemListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClosureCaptureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureCaptureSignatureSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClosureParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureParamSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClosureParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureParamListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClosureSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureSignatureSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClosureExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClosureExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnresolvedPatternExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnresolvedPatternExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MultipleTrailingClosureElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MultipleTrailingClosureElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MultipleTrailingClosureElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MultipleTrailingClosureElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FunctionCallExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionCallExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SubscriptExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SubscriptExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `OptionalChainingExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OptionalChainingExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ForcedValueExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ForcedValueExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PostfixUnaryExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PostfixUnaryExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SpecializeExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SpecializeExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `StringSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: StringSegmentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ExpressionSegmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExpressionSegmentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `StringLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: StringLiteralExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `RegexLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: RegexLiteralExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `KeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `KeyPathBaseExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: KeyPathBaseExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ObjcNamePieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjcNamePieceSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ObjcNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjcNameSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ObjcKeyPathExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjcKeyPathExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ObjcSelectorExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjcSelectorExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PostfixIfConfigExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PostfixIfConfigExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `EditorPlaceholderExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EditorPlaceholderExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ObjectLiteralExprSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjectLiteralExprSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TypeInitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypeInitializerClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TypealiasDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypealiasDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AssociatedtypeDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AssociatedtypeDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FunctionParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionParameterListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ParameterClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ReturnClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ReturnClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FunctionSignatureSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionSignatureSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IfConfigClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IfConfigClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IfConfigClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IfConfigClauseListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IfConfigDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IfConfigDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundErrorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundErrorDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundWarningDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundWarningDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundSourceLocationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundSourceLocationSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundSourceLocationArgsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundSourceLocationArgsSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeclModifierDetailSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclModifierDetailSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeclModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclModifierSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `InheritedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InheritedTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `InheritedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InheritedTypeListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TypeInheritanceClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypeInheritanceClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClassDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClassDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ActorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ActorDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `StructDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: StructDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ProtocolDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ProtocolDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ExtensionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExtensionDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MemberDeclBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberDeclBlockSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MemberDeclListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberDeclListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MemberDeclListItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberDeclListItemSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SourceFileSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SourceFileSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `InitializerClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InitializerClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FunctionParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionParameterSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ModifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ModifierListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FunctionDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `InitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: InitializerDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeinitializerDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeinitializerDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SubscriptDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SubscriptDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AccessLevelModifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessLevelModifierSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AccessPathComponentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessPathComponentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AccessPathSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessPathSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ImportDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ImportDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AccessorParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessorParameterSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AccessorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessorDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AccessorListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessorListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AccessorBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AccessorBlockSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PatternBindingSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PatternBindingSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PatternBindingListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PatternBindingListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `VariableDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: VariableDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `EnumCaseElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumCaseElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `EnumCaseElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumCaseElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `EnumCaseDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumCaseDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `EnumDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `OperatorDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OperatorDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IdentifierListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IdentifierListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `OperatorPrecedenceAndTypesSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OperatorPrecedenceAndTypesSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrecedenceGroupDeclSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupDeclSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrecedenceGroupAttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupAttributeListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrecedenceGroupRelationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupRelationSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrecedenceGroupNameListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupNameListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrecedenceGroupNameElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupNameElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrecedenceGroupAssignmentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupAssignmentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrecedenceGroupAssociativitySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrecedenceGroupAssociativitySyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TokenListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `NonEmptyTokenListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: NonEmptyTokenListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CustomAttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CustomAttributeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AttributeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AttributeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AttributeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AttributeListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SpecializeAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SpecializeAttributeSpecListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AvailabilityEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityEntrySyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `LabeledSpecializeEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: LabeledSpecializeEntrySyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TargetFunctionEntrySyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TargetFunctionEntrySyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `NamedAttributeStringArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: NamedAttributeStringArgumentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclNameSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ImplementsAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ImplementsAttributeArgumentsSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ObjCSelectorPieceSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjCSelectorPieceSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ObjCSelectorSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ObjCSelectorSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DifferentiableAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiableAttributeArgumentsSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DifferentiabilityParamsClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiabilityParamsClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DifferentiabilityParamsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiabilityParamsSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DifferentiabilityParamListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiabilityParamListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DifferentiabilityParamSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DifferentiabilityParamSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DerivativeRegistrationAttributeArgumentsSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DerivativeRegistrationAttributeArgumentsSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `QualifiedDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: QualifiedDeclNameSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FunctionDeclNameSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionDeclNameSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `BackDeployAttributeSpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BackDeployAttributeSpecListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `BackDeployVersionListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BackDeployVersionListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `BackDeployVersionArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BackDeployVersionArgumentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `LabeledStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: LabeledStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ContinueStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ContinueStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `WhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: WhileStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeferStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeferStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ExpressionStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExpressionStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SwitchCaseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchCaseListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `RepeatWhileStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: RepeatWhileStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GuardStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GuardStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `WhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: WhereClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ForInStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ForInStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SwitchStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CatchClauseListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CatchClauseListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DoStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DoStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ReturnStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ReturnStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `YieldStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: YieldStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `YieldListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: YieldListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FallthroughStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FallthroughStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `BreakStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: BreakStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CaseItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CaseItemListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CatchItemListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CatchItemListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ConditionElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConditionElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AvailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityConditionSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MatchingPatternConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MatchingPatternConditionSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `OptionalBindingConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OptionalBindingConditionSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `UnavailabilityConditionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: UnavailabilityConditionSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ConditionElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConditionElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DeclarationStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DeclarationStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ThrowStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ThrowStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IfStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IfStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ElseIfContinuationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ElseIfContinuationSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ElseBlockSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ElseBlockSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SwitchCaseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchCaseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SwitchDefaultLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchDefaultLabelSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CaseItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CaseItemSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CatchItemSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CatchItemSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SwitchCaseLabelSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SwitchCaseLabelSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CatchClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CatchClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PoundAssertStmtSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PoundAssertStmtSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericWhereClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericWhereClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericRequirementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericRequirementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericRequirementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SameTypeRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SameTypeRequirementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `LayoutRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: LayoutRequirementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericParameterListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericParameterListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericParameterSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericParameterSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrimaryAssociatedTypeListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrimaryAssociatedTypeListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrimaryAssociatedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrimaryAssociatedTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericParameterClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericParameterClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ConformanceRequirementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConformanceRequirementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `PrimaryAssociatedTypeClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: PrimaryAssociatedTypeClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `SimpleTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: SimpleTypeIdentifierSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MemberTypeIdentifierSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MemberTypeIdentifierSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ClassRestrictionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ClassRestrictionTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ArrayTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ArrayTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `DictionaryTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: DictionaryTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `MetatypeTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: MetatypeTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `OptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OptionalTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ConstrainedSugarTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ConstrainedSugarTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ImplicitlyUnwrappedOptionalTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CompositionTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CompositionTypeElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CompositionTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CompositionTypeElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `CompositionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: CompositionTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TupleTypeElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleTypeElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TupleTypeElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleTypeElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TupleTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TupleTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `FunctionTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: FunctionTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AttributedTypeSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AttributedTypeSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericArgumentListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericArgumentListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericArgumentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `GenericArgumentClauseSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: GenericArgumentClauseSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TypeAnnotationSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TypeAnnotationSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `EnumCasePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: EnumCasePatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IsTypePatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `OptionalPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: OptionalPatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `IdentifierPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: IdentifierPatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AsTypePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AsTypePatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TuplePatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TuplePatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `WildcardPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: WildcardPatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TuplePatternElementSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TuplePatternElementSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ExpressionPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ExpressionPatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `TuplePatternElementListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: TuplePatternElementListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `ValueBindingPatternSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: ValueBindingPatternSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AvailabilitySpecListSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilitySpecListSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AvailabilityArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityArgumentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AvailabilityLabeledArgumentSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityLabeledArgumentSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `AvailabilityVersionRestrictionSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: AvailabilityVersionRestrictionSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }
  /// Visiting `VersionTupleSyntax` specifically.
  ///   - Parameter node: the node we are visiting.
  ///   - Returns: nil by default.
  public func visit(_ node: VersionTupleSyntax) -> [ResultType] {
      // Avoid calling into visitChildren if possible.
      if !node.raw.layoutView!.children.isEmpty {
        return visitChildren(node)
      }
      return []
  }

  public func visit(_ data: SyntaxData) -> [ResultType] {
    switch data.raw.kind {
    case .token:
      let node = TokenSyntax(data)
      return visit(node)
    case .unknown:
      let node = UnknownSyntax(data)
      return visit(node)
    // The implementation of every generated case goes into its own function. This
    // circumvents an issue where the compiler allocates stack space for every
    // case statement next to each other in debug builds, causing it to allocate
    // ~50KB per call to this function. rdar://55929175
    case .unknownDecl:
      let node = UnknownDeclSyntax(data)
      return visit(node)
    case .unknownExpr:
      let node = UnknownExprSyntax(data)
      return visit(node)
    case .unknownStmt:
      let node = UnknownStmtSyntax(data)
      return visit(node)
    case .unknownType:
      let node = UnknownTypeSyntax(data)
      return visit(node)
    case .unknownPattern:
      let node = UnknownPatternSyntax(data)
      return visit(node)
    case .missing:
      let node = MissingSyntax(data)
      return visit(node)
    case .missingDecl:
      let node = MissingDeclSyntax(data)
      return visit(node)
    case .missingExpr:
      let node = MissingExprSyntax(data)
      return visit(node)
    case .missingStmt:
      let node = MissingStmtSyntax(data)
      return visit(node)
    case .missingType:
      let node = MissingTypeSyntax(data)
      return visit(node)
    case .missingPattern:
      let node = MissingPatternSyntax(data)
      return visit(node)
    case .codeBlockItem:
      let node = CodeBlockItemSyntax(data)
      return visit(node)
    case .codeBlockItemList:
      let node = CodeBlockItemListSyntax(data)
      return visit(node)
    case .codeBlock:
      let node = CodeBlockSyntax(data)
      return visit(node)
    case .unexpectedNodes:
      let node = UnexpectedNodesSyntax(data)
      return visit(node)
    case .inOutExpr:
      let node = InOutExprSyntax(data)
      return visit(node)
    case .poundColumnExpr:
      let node = PoundColumnExprSyntax(data)
      return visit(node)
    case .tupleExprElementList:
      let node = TupleExprElementListSyntax(data)
      return visit(node)
    case .arrayElementList:
      let node = ArrayElementListSyntax(data)
      return visit(node)
    case .dictionaryElementList:
      let node = DictionaryElementListSyntax(data)
      return visit(node)
    case .stringLiteralSegments:
      let node = StringLiteralSegmentsSyntax(data)
      return visit(node)
    case .tryExpr:
      let node = TryExprSyntax(data)
      return visit(node)
    case .awaitExpr:
      let node = AwaitExprSyntax(data)
      return visit(node)
    case .moveExpr:
      let node = MoveExprSyntax(data)
      return visit(node)
    case .declNameArgument:
      let node = DeclNameArgumentSyntax(data)
      return visit(node)
    case .declNameArgumentList:
      let node = DeclNameArgumentListSyntax(data)
      return visit(node)
    case .declNameArguments:
      let node = DeclNameArgumentsSyntax(data)
      return visit(node)
    case .identifierExpr:
      let node = IdentifierExprSyntax(data)
      return visit(node)
    case .superRefExpr:
      let node = SuperRefExprSyntax(data)
      return visit(node)
    case .nilLiteralExpr:
      let node = NilLiteralExprSyntax(data)
      return visit(node)
    case .discardAssignmentExpr:
      let node = DiscardAssignmentExprSyntax(data)
      return visit(node)
    case .assignmentExpr:
      let node = AssignmentExprSyntax(data)
      return visit(node)
    case .sequenceExpr:
      let node = SequenceExprSyntax(data)
      return visit(node)
    case .exprList:
      let node = ExprListSyntax(data)
      return visit(node)
    case .poundLineExpr:
      let node = PoundLineExprSyntax(data)
      return visit(node)
    case .poundFileExpr:
      let node = PoundFileExprSyntax(data)
      return visit(node)
    case .poundFileIDExpr:
      let node = PoundFileIDExprSyntax(data)
      return visit(node)
    case .poundFilePathExpr:
      let node = PoundFilePathExprSyntax(data)
      return visit(node)
    case .poundFunctionExpr:
      let node = PoundFunctionExprSyntax(data)
      return visit(node)
    case .poundDsohandleExpr:
      let node = PoundDsohandleExprSyntax(data)
      return visit(node)
    case .symbolicReferenceExpr:
      let node = SymbolicReferenceExprSyntax(data)
      return visit(node)
    case .prefixOperatorExpr:
      let node = PrefixOperatorExprSyntax(data)
      return visit(node)
    case .binaryOperatorExpr:
      let node = BinaryOperatorExprSyntax(data)
      return visit(node)
    case .arrowExpr:
      let node = ArrowExprSyntax(data)
      return visit(node)
    case .infixOperatorExpr:
      let node = InfixOperatorExprSyntax(data)
      return visit(node)
    case .floatLiteralExpr:
      let node = FloatLiteralExprSyntax(data)
      return visit(node)
    case .tupleExpr:
      let node = TupleExprSyntax(data)
      return visit(node)
    case .arrayExpr:
      let node = ArrayExprSyntax(data)
      return visit(node)
    case .dictionaryExpr:
      let node = DictionaryExprSyntax(data)
      return visit(node)
    case .tupleExprElement:
      let node = TupleExprElementSyntax(data)
      return visit(node)
    case .arrayElement:
      let node = ArrayElementSyntax(data)
      return visit(node)
    case .dictionaryElement:
      let node = DictionaryElementSyntax(data)
      return visit(node)
    case .integerLiteralExpr:
      let node = IntegerLiteralExprSyntax(data)
      return visit(node)
    case .booleanLiteralExpr:
      let node = BooleanLiteralExprSyntax(data)
      return visit(node)
    case .unresolvedTernaryExpr:
      let node = UnresolvedTernaryExprSyntax(data)
      return visit(node)
    case .ternaryExpr:
      let node = TernaryExprSyntax(data)
      return visit(node)
    case .memberAccessExpr:
      let node = MemberAccessExprSyntax(data)
      return visit(node)
    case .unresolvedIsExpr:
      let node = UnresolvedIsExprSyntax(data)
      return visit(node)
    case .isExpr:
      let node = IsExprSyntax(data)
      return visit(node)
    case .unresolvedAsExpr:
      let node = UnresolvedAsExprSyntax(data)
      return visit(node)
    case .asExpr:
      let node = AsExprSyntax(data)
      return visit(node)
    case .typeExpr:
      let node = TypeExprSyntax(data)
      return visit(node)
    case .closureCaptureItem:
      let node = ClosureCaptureItemSyntax(data)
      return visit(node)
    case .closureCaptureItemList:
      let node = ClosureCaptureItemListSyntax(data)
      return visit(node)
    case .closureCaptureSignature:
      let node = ClosureCaptureSignatureSyntax(data)
      return visit(node)
    case .closureParam:
      let node = ClosureParamSyntax(data)
      return visit(node)
    case .closureParamList:
      let node = ClosureParamListSyntax(data)
      return visit(node)
    case .closureSignature:
      let node = ClosureSignatureSyntax(data)
      return visit(node)
    case .closureExpr:
      let node = ClosureExprSyntax(data)
      return visit(node)
    case .unresolvedPatternExpr:
      let node = UnresolvedPatternExprSyntax(data)
      return visit(node)
    case .multipleTrailingClosureElement:
      let node = MultipleTrailingClosureElementSyntax(data)
      return visit(node)
    case .multipleTrailingClosureElementList:
      let node = MultipleTrailingClosureElementListSyntax(data)
      return visit(node)
    case .functionCallExpr:
      let node = FunctionCallExprSyntax(data)
      return visit(node)
    case .subscriptExpr:
      let node = SubscriptExprSyntax(data)
      return visit(node)
    case .optionalChainingExpr:
      let node = OptionalChainingExprSyntax(data)
      return visit(node)
    case .forcedValueExpr:
      let node = ForcedValueExprSyntax(data)
      return visit(node)
    case .postfixUnaryExpr:
      let node = PostfixUnaryExprSyntax(data)
      return visit(node)
    case .specializeExpr:
      let node = SpecializeExprSyntax(data)
      return visit(node)
    case .stringSegment:
      let node = StringSegmentSyntax(data)
      return visit(node)
    case .expressionSegment:
      let node = ExpressionSegmentSyntax(data)
      return visit(node)
    case .stringLiteralExpr:
      let node = StringLiteralExprSyntax(data)
      return visit(node)
    case .regexLiteralExpr:
      let node = RegexLiteralExprSyntax(data)
      return visit(node)
    case .keyPathExpr:
      let node = KeyPathExprSyntax(data)
      return visit(node)
    case .keyPathBaseExpr:
      let node = KeyPathBaseExprSyntax(data)
      return visit(node)
    case .objcNamePiece:
      let node = ObjcNamePieceSyntax(data)
      return visit(node)
    case .objcName:
      let node = ObjcNameSyntax(data)
      return visit(node)
    case .objcKeyPathExpr:
      let node = ObjcKeyPathExprSyntax(data)
      return visit(node)
    case .objcSelectorExpr:
      let node = ObjcSelectorExprSyntax(data)
      return visit(node)
    case .postfixIfConfigExpr:
      let node = PostfixIfConfigExprSyntax(data)
      return visit(node)
    case .editorPlaceholderExpr:
      let node = EditorPlaceholderExprSyntax(data)
      return visit(node)
    case .objectLiteralExpr:
      let node = ObjectLiteralExprSyntax(data)
      return visit(node)
    case .typeInitializerClause:
      let node = TypeInitializerClauseSyntax(data)
      return visit(node)
    case .typealiasDecl:
      let node = TypealiasDeclSyntax(data)
      return visit(node)
    case .associatedtypeDecl:
      let node = AssociatedtypeDeclSyntax(data)
      return visit(node)
    case .functionParameterList:
      let node = FunctionParameterListSyntax(data)
      return visit(node)
    case .parameterClause:
      let node = ParameterClauseSyntax(data)
      return visit(node)
    case .returnClause:
      let node = ReturnClauseSyntax(data)
      return visit(node)
    case .functionSignature:
      let node = FunctionSignatureSyntax(data)
      return visit(node)
    case .ifConfigClause:
      let node = IfConfigClauseSyntax(data)
      return visit(node)
    case .ifConfigClauseList:
      let node = IfConfigClauseListSyntax(data)
      return visit(node)
    case .ifConfigDecl:
      let node = IfConfigDeclSyntax(data)
      return visit(node)
    case .poundErrorDecl:
      let node = PoundErrorDeclSyntax(data)
      return visit(node)
    case .poundWarningDecl:
      let node = PoundWarningDeclSyntax(data)
      return visit(node)
    case .poundSourceLocation:
      let node = PoundSourceLocationSyntax(data)
      return visit(node)
    case .poundSourceLocationArgs:
      let node = PoundSourceLocationArgsSyntax(data)
      return visit(node)
    case .declModifierDetail:
      let node = DeclModifierDetailSyntax(data)
      return visit(node)
    case .declModifier:
      let node = DeclModifierSyntax(data)
      return visit(node)
    case .inheritedType:
      let node = InheritedTypeSyntax(data)
      return visit(node)
    case .inheritedTypeList:
      let node = InheritedTypeListSyntax(data)
      return visit(node)
    case .typeInheritanceClause:
      let node = TypeInheritanceClauseSyntax(data)
      return visit(node)
    case .classDecl:
      let node = ClassDeclSyntax(data)
      return visit(node)
    case .actorDecl:
      let node = ActorDeclSyntax(data)
      return visit(node)
    case .structDecl:
      let node = StructDeclSyntax(data)
      return visit(node)
    case .protocolDecl:
      let node = ProtocolDeclSyntax(data)
      return visit(node)
    case .extensionDecl:
      let node = ExtensionDeclSyntax(data)
      return visit(node)
    case .memberDeclBlock:
      let node = MemberDeclBlockSyntax(data)
      return visit(node)
    case .memberDeclList:
      let node = MemberDeclListSyntax(data)
      return visit(node)
    case .memberDeclListItem:
      let node = MemberDeclListItemSyntax(data)
      return visit(node)
    case .sourceFile:
      let node = SourceFileSyntax(data)
      return visit(node)
    case .initializerClause:
      let node = InitializerClauseSyntax(data)
      return visit(node)
    case .functionParameter:
      let node = FunctionParameterSyntax(data)
      return visit(node)
    case .modifierList:
      let node = ModifierListSyntax(data)
      return visit(node)
    case .functionDecl:
      let node = FunctionDeclSyntax(data)
      return visit(node)
    case .initializerDecl:
      let node = InitializerDeclSyntax(data)
      return visit(node)
    case .deinitializerDecl:
      let node = DeinitializerDeclSyntax(data)
      return visit(node)
    case .subscriptDecl:
      let node = SubscriptDeclSyntax(data)
      return visit(node)
    case .accessLevelModifier:
      let node = AccessLevelModifierSyntax(data)
      return visit(node)
    case .accessPathComponent:
      let node = AccessPathComponentSyntax(data)
      return visit(node)
    case .accessPath:
      let node = AccessPathSyntax(data)
      return visit(node)
    case .importDecl:
      let node = ImportDeclSyntax(data)
      return visit(node)
    case .accessorParameter:
      let node = AccessorParameterSyntax(data)
      return visit(node)
    case .accessorDecl:
      let node = AccessorDeclSyntax(data)
      return visit(node)
    case .accessorList:
      let node = AccessorListSyntax(data)
      return visit(node)
    case .accessorBlock:
      let node = AccessorBlockSyntax(data)
      return visit(node)
    case .patternBinding:
      let node = PatternBindingSyntax(data)
      return visit(node)
    case .patternBindingList:
      let node = PatternBindingListSyntax(data)
      return visit(node)
    case .variableDecl:
      let node = VariableDeclSyntax(data)
      return visit(node)
    case .enumCaseElement:
      let node = EnumCaseElementSyntax(data)
      return visit(node)
    case .enumCaseElementList:
      let node = EnumCaseElementListSyntax(data)
      return visit(node)
    case .enumCaseDecl:
      let node = EnumCaseDeclSyntax(data)
      return visit(node)
    case .enumDecl:
      let node = EnumDeclSyntax(data)
      return visit(node)
    case .operatorDecl:
      let node = OperatorDeclSyntax(data)
      return visit(node)
    case .identifierList:
      let node = IdentifierListSyntax(data)
      return visit(node)
    case .operatorPrecedenceAndTypes:
      let node = OperatorPrecedenceAndTypesSyntax(data)
      return visit(node)
    case .precedenceGroupDecl:
      let node = PrecedenceGroupDeclSyntax(data)
      return visit(node)
    case .precedenceGroupAttributeList:
      let node = PrecedenceGroupAttributeListSyntax(data)
      return visit(node)
    case .precedenceGroupRelation:
      let node = PrecedenceGroupRelationSyntax(data)
      return visit(node)
    case .precedenceGroupNameList:
      let node = PrecedenceGroupNameListSyntax(data)
      return visit(node)
    case .precedenceGroupNameElement:
      let node = PrecedenceGroupNameElementSyntax(data)
      return visit(node)
    case .precedenceGroupAssignment:
      let node = PrecedenceGroupAssignmentSyntax(data)
      return visit(node)
    case .precedenceGroupAssociativity:
      let node = PrecedenceGroupAssociativitySyntax(data)
      return visit(node)
    case .tokenList:
      let node = TokenListSyntax(data)
      return visit(node)
    case .nonEmptyTokenList:
      let node = NonEmptyTokenListSyntax(data)
      return visit(node)
    case .customAttribute:
      let node = CustomAttributeSyntax(data)
      return visit(node)
    case .attribute:
      let node = AttributeSyntax(data)
      return visit(node)
    case .attributeList:
      let node = AttributeListSyntax(data)
      return visit(node)
    case .specializeAttributeSpecList:
      let node = SpecializeAttributeSpecListSyntax(data)
      return visit(node)
    case .availabilityEntry:
      let node = AvailabilityEntrySyntax(data)
      return visit(node)
    case .labeledSpecializeEntry:
      let node = LabeledSpecializeEntrySyntax(data)
      return visit(node)
    case .targetFunctionEntry:
      let node = TargetFunctionEntrySyntax(data)
      return visit(node)
    case .namedAttributeStringArgument:
      let node = NamedAttributeStringArgumentSyntax(data)
      return visit(node)
    case .declName:
      let node = DeclNameSyntax(data)
      return visit(node)
    case .implementsAttributeArguments:
      let node = ImplementsAttributeArgumentsSyntax(data)
      return visit(node)
    case .objCSelectorPiece:
      let node = ObjCSelectorPieceSyntax(data)
      return visit(node)
    case .objCSelector:
      let node = ObjCSelectorSyntax(data)
      return visit(node)
    case .differentiableAttributeArguments:
      let node = DifferentiableAttributeArgumentsSyntax(data)
      return visit(node)
    case .differentiabilityParamsClause:
      let node = DifferentiabilityParamsClauseSyntax(data)
      return visit(node)
    case .differentiabilityParams:
      let node = DifferentiabilityParamsSyntax(data)
      return visit(node)
    case .differentiabilityParamList:
      let node = DifferentiabilityParamListSyntax(data)
      return visit(node)
    case .differentiabilityParam:
      let node = DifferentiabilityParamSyntax(data)
      return visit(node)
    case .derivativeRegistrationAttributeArguments:
      let node = DerivativeRegistrationAttributeArgumentsSyntax(data)
      return visit(node)
    case .qualifiedDeclName:
      let node = QualifiedDeclNameSyntax(data)
      return visit(node)
    case .functionDeclName:
      let node = FunctionDeclNameSyntax(data)
      return visit(node)
    case .backDeployAttributeSpecList:
      let node = BackDeployAttributeSpecListSyntax(data)
      return visit(node)
    case .backDeployVersionList:
      let node = BackDeployVersionListSyntax(data)
      return visit(node)
    case .backDeployVersionArgument:
      let node = BackDeployVersionArgumentSyntax(data)
      return visit(node)
    case .labeledStmt:
      let node = LabeledStmtSyntax(data)
      return visit(node)
    case .continueStmt:
      let node = ContinueStmtSyntax(data)
      return visit(node)
    case .whileStmt:
      let node = WhileStmtSyntax(data)
      return visit(node)
    case .deferStmt:
      let node = DeferStmtSyntax(data)
      return visit(node)
    case .expressionStmt:
      let node = ExpressionStmtSyntax(data)
      return visit(node)
    case .switchCaseList:
      let node = SwitchCaseListSyntax(data)
      return visit(node)
    case .repeatWhileStmt:
      let node = RepeatWhileStmtSyntax(data)
      return visit(node)
    case .guardStmt:
      let node = GuardStmtSyntax(data)
      return visit(node)
    case .whereClause:
      let node = WhereClauseSyntax(data)
      return visit(node)
    case .forInStmt:
      let node = ForInStmtSyntax(data)
      return visit(node)
    case .switchStmt:
      let node = SwitchStmtSyntax(data)
      return visit(node)
    case .catchClauseList:
      let node = CatchClauseListSyntax(data)
      return visit(node)
    case .doStmt:
      let node = DoStmtSyntax(data)
      return visit(node)
    case .returnStmt:
      let node = ReturnStmtSyntax(data)
      return visit(node)
    case .yieldStmt:
      let node = YieldStmtSyntax(data)
      return visit(node)
    case .yieldList:
      let node = YieldListSyntax(data)
      return visit(node)
    case .fallthroughStmt:
      let node = FallthroughStmtSyntax(data)
      return visit(node)
    case .breakStmt:
      let node = BreakStmtSyntax(data)
      return visit(node)
    case .caseItemList:
      let node = CaseItemListSyntax(data)
      return visit(node)
    case .catchItemList:
      let node = CatchItemListSyntax(data)
      return visit(node)
    case .conditionElement:
      let node = ConditionElementSyntax(data)
      return visit(node)
    case .availabilityCondition:
      let node = AvailabilityConditionSyntax(data)
      return visit(node)
    case .matchingPatternCondition:
      let node = MatchingPatternConditionSyntax(data)
      return visit(node)
    case .optionalBindingCondition:
      let node = OptionalBindingConditionSyntax(data)
      return visit(node)
    case .unavailabilityCondition:
      let node = UnavailabilityConditionSyntax(data)
      return visit(node)
    case .conditionElementList:
      let node = ConditionElementListSyntax(data)
      return visit(node)
    case .declarationStmt:
      let node = DeclarationStmtSyntax(data)
      return visit(node)
    case .throwStmt:
      let node = ThrowStmtSyntax(data)
      return visit(node)
    case .ifStmt:
      let node = IfStmtSyntax(data)
      return visit(node)
    case .elseIfContinuation:
      let node = ElseIfContinuationSyntax(data)
      return visit(node)
    case .elseBlock:
      let node = ElseBlockSyntax(data)
      return visit(node)
    case .switchCase:
      let node = SwitchCaseSyntax(data)
      return visit(node)
    case .switchDefaultLabel:
      let node = SwitchDefaultLabelSyntax(data)
      return visit(node)
    case .caseItem:
      let node = CaseItemSyntax(data)
      return visit(node)
    case .catchItem:
      let node = CatchItemSyntax(data)
      return visit(node)
    case .switchCaseLabel:
      let node = SwitchCaseLabelSyntax(data)
      return visit(node)
    case .catchClause:
      let node = CatchClauseSyntax(data)
      return visit(node)
    case .poundAssertStmt:
      let node = PoundAssertStmtSyntax(data)
      return visit(node)
    case .genericWhereClause:
      let node = GenericWhereClauseSyntax(data)
      return visit(node)
    case .genericRequirementList:
      let node = GenericRequirementListSyntax(data)
      return visit(node)
    case .genericRequirement:
      let node = GenericRequirementSyntax(data)
      return visit(node)
    case .sameTypeRequirement:
      let node = SameTypeRequirementSyntax(data)
      return visit(node)
    case .layoutRequirement:
      let node = LayoutRequirementSyntax(data)
      return visit(node)
    case .genericParameterList:
      let node = GenericParameterListSyntax(data)
      return visit(node)
    case .genericParameter:
      let node = GenericParameterSyntax(data)
      return visit(node)
    case .primaryAssociatedTypeList:
      let node = PrimaryAssociatedTypeListSyntax(data)
      return visit(node)
    case .primaryAssociatedType:
      let node = PrimaryAssociatedTypeSyntax(data)
      return visit(node)
    case .genericParameterClause:
      let node = GenericParameterClauseSyntax(data)
      return visit(node)
    case .conformanceRequirement:
      let node = ConformanceRequirementSyntax(data)
      return visit(node)
    case .primaryAssociatedTypeClause:
      let node = PrimaryAssociatedTypeClauseSyntax(data)
      return visit(node)
    case .simpleTypeIdentifier:
      let node = SimpleTypeIdentifierSyntax(data)
      return visit(node)
    case .memberTypeIdentifier:
      let node = MemberTypeIdentifierSyntax(data)
      return visit(node)
    case .classRestrictionType:
      let node = ClassRestrictionTypeSyntax(data)
      return visit(node)
    case .arrayType:
      let node = ArrayTypeSyntax(data)
      return visit(node)
    case .dictionaryType:
      let node = DictionaryTypeSyntax(data)
      return visit(node)
    case .metatypeType:
      let node = MetatypeTypeSyntax(data)
      return visit(node)
    case .optionalType:
      let node = OptionalTypeSyntax(data)
      return visit(node)
    case .constrainedSugarType:
      let node = ConstrainedSugarTypeSyntax(data)
      return visit(node)
    case .implicitlyUnwrappedOptionalType:
      let node = ImplicitlyUnwrappedOptionalTypeSyntax(data)
      return visit(node)
    case .compositionTypeElement:
      let node = CompositionTypeElementSyntax(data)
      return visit(node)
    case .compositionTypeElementList:
      let node = CompositionTypeElementListSyntax(data)
      return visit(node)
    case .compositionType:
      let node = CompositionTypeSyntax(data)
      return visit(node)
    case .tupleTypeElement:
      let node = TupleTypeElementSyntax(data)
      return visit(node)
    case .tupleTypeElementList:
      let node = TupleTypeElementListSyntax(data)
      return visit(node)
    case .tupleType:
      let node = TupleTypeSyntax(data)
      return visit(node)
    case .functionType:
      let node = FunctionTypeSyntax(data)
      return visit(node)
    case .attributedType:
      let node = AttributedTypeSyntax(data)
      return visit(node)
    case .genericArgumentList:
      let node = GenericArgumentListSyntax(data)
      return visit(node)
    case .genericArgument:
      let node = GenericArgumentSyntax(data)
      return visit(node)
    case .genericArgumentClause:
      let node = GenericArgumentClauseSyntax(data)
      return visit(node)
    case .typeAnnotation:
      let node = TypeAnnotationSyntax(data)
      return visit(node)
    case .enumCasePattern:
      let node = EnumCasePatternSyntax(data)
      return visit(node)
    case .isTypePattern:
      let node = IsTypePatternSyntax(data)
      return visit(node)
    case .optionalPattern:
      let node = OptionalPatternSyntax(data)
      return visit(node)
    case .identifierPattern:
      let node = IdentifierPatternSyntax(data)
      return visit(node)
    case .asTypePattern:
      let node = AsTypePatternSyntax(data)
      return visit(node)
    case .tuplePattern:
      let node = TuplePatternSyntax(data)
      return visit(node)
    case .wildcardPattern:
      let node = WildcardPatternSyntax(data)
      return visit(node)
    case .tuplePatternElement:
      let node = TuplePatternElementSyntax(data)
      return visit(node)
    case .expressionPattern:
      let node = ExpressionPatternSyntax(data)
      return visit(node)
    case .tuplePatternElementList:
      let node = TuplePatternElementListSyntax(data)
      return visit(node)
    case .valueBindingPattern:
      let node = ValueBindingPatternSyntax(data)
      return visit(node)
    case .availabilitySpecList:
      let node = AvailabilitySpecListSyntax(data)
      return visit(node)
    case .availabilityArgument:
      let node = AvailabilityArgumentSyntax(data)
      return visit(node)
    case .availabilityLabeledArgument:
      let node = AvailabilityLabeledArgumentSyntax(data)
      return visit(node)
    case .availabilityVersionRestriction:
      let node = AvailabilityVersionRestrictionSyntax(data)
      return visit(node)
    case .versionTuple:
      let node = VersionTupleSyntax(data)
      return visit(node)
    }
  }
  
  public func visit(_ data: ExprSyntax) -> [ResultType] {
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
  
  public func visit(_ data: PatternSyntax) -> [ResultType] {
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

  public func visitChildren<SyntaxType: SyntaxProtocol>(_ node: SyntaxType) -> [ResultType] {
    let syntaxNode = Syntax(node)
    return NonNilRawSyntaxChildren(syntaxNode, viewMode: .sourceAccurate).flatMap { childRaw in
      let childData = SyntaxData(childRaw, parent: syntaxNode)
      return visit(childData)
    }
  }
}
