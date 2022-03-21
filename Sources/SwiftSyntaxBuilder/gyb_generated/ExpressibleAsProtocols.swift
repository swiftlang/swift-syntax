//// Automatically Generated From ExpressibleAsProtocols.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
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

import SwiftSyntax

public protocol ExpressibleAsDeclBuildable: ExpressibleAsCodeBlockItem, ExpressibleAsMemberDeclListItem {
  func createDeclBuildable() -> DeclBuildable
}

public extension ExpressibleAsDeclBuildable {
  /// Conformance to `ExpressibleAsCodeBlockItem`.
  func createCodeBlockItem() -> CodeBlockItem {
    return CodeBlockItem(item: self)
  }
  /// Conformance to `ExpressibleAsMemberDeclListItem`.
  func createMemberDeclListItem() -> MemberDeclListItem {
    return MemberDeclListItem(decl: self)
  }
}

public protocol ExpressibleAsExprBuildable: ExpressibleAsExprList {
  func createExprBuildable() -> ExprBuildable
}

public extension ExpressibleAsExprBuildable {
  /// Conformance to `ExpressibleAsExprList`.
  func createExprList() -> ExprList {
    return ExprList([self])
  }
}

public protocol ExpressibleAsPatternBuildable {
  func createPatternBuildable() -> PatternBuildable
}

public protocol ExpressibleAsStmtBuildable: ExpressibleAsCodeBlockItem {
  func createStmtBuildable() -> StmtBuildable
}

public extension ExpressibleAsStmtBuildable {
  /// Conformance to `ExpressibleAsCodeBlockItem`.
  func createCodeBlockItem() -> CodeBlockItem {
    return CodeBlockItem(item: self)
  }
}

public protocol ExpressibleAsSyntaxBuildable: ExpressibleAsStringLiteralSegments, ExpressibleAsPrecedenceGroupAttributeList, ExpressibleAsAttributeList, ExpressibleAsSpecializeAttributeSpecList, ExpressibleAsSwitchCaseList {
  func createSyntaxBuildable() -> SyntaxBuildable
}

public extension ExpressibleAsSyntaxBuildable {
  /// Conformance to `ExpressibleAsStringLiteralSegments`.
  func createStringLiteralSegments() -> StringLiteralSegments {
    return StringLiteralSegments([self])
  }
  /// Conformance to `ExpressibleAsPrecedenceGroupAttributeList`.
  func createPrecedenceGroupAttributeList() -> PrecedenceGroupAttributeList {
    return PrecedenceGroupAttributeList([self])
  }
  /// Conformance to `ExpressibleAsAttributeList`.
  func createAttributeList() -> AttributeList {
    return AttributeList([self])
  }
  /// Conformance to `ExpressibleAsSpecializeAttributeSpecList`.
  func createSpecializeAttributeSpecList() -> SpecializeAttributeSpecList {
    return SpecializeAttributeSpecList([self])
  }
  /// Conformance to `ExpressibleAsSwitchCaseList`.
  func createSwitchCaseList() -> SwitchCaseList {
    return SwitchCaseList([self])
  }
}

public protocol ExpressibleAsTypeBuildable: ExpressibleAsReturnClause {
  func createTypeBuildable() -> TypeBuildable
}

public extension ExpressibleAsTypeBuildable {
  /// Conformance to `ExpressibleAsReturnClause`.
  func createReturnClause() -> ReturnClause {
    return ReturnClause(returnType: self)
  }
}

public protocol ExpressibleAsCodeBlockItem: ExpressibleAsCodeBlockItemList {
  func createCodeBlockItem() -> CodeBlockItem
}

public extension ExpressibleAsCodeBlockItem {
  /// Conformance to `ExpressibleAsCodeBlockItemList`.
  func createCodeBlockItemList() -> CodeBlockItemList {
    return CodeBlockItemList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createCodeBlockItem()
  }
}

public protocol ExpressibleAsCodeBlockItemList: ExpressibleAsCodeBlock {
  func createCodeBlockItemList() -> CodeBlockItemList
}

public extension ExpressibleAsCodeBlockItemList {
  /// Conformance to `ExpressibleAsCodeBlock`.
  func createCodeBlock() -> CodeBlock {
    return CodeBlock(statements: self)
  }
}

public protocol ExpressibleAsCodeBlock: ExpressibleAsSyntaxBuildable {
  func createCodeBlock() -> CodeBlock
}

public extension ExpressibleAsCodeBlock {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createCodeBlock()
  }
}

public protocol ExpressibleAsInOutExpr: ExpressibleAsExprBuildable {
  func createInOutExpr() -> InOutExpr
}

public extension ExpressibleAsInOutExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createInOutExpr()
  }
}

public protocol ExpressibleAsPoundColumnExpr: ExpressibleAsExprBuildable {
  func createPoundColumnExpr() -> PoundColumnExpr
}

public extension ExpressibleAsPoundColumnExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPoundColumnExpr()
  }
}

public protocol ExpressibleAsTupleExprElementList {
  func createTupleExprElementList() -> TupleExprElementList
}

public protocol ExpressibleAsArrayElementList {
  func createArrayElementList() -> ArrayElementList
}

public protocol ExpressibleAsDictionaryElementList {
  func createDictionaryElementList() -> DictionaryElementList
}

public protocol ExpressibleAsStringLiteralSegments {
  func createStringLiteralSegments() -> StringLiteralSegments
}

public protocol ExpressibleAsTryExpr: ExpressibleAsExprBuildable {
  func createTryExpr() -> TryExpr
}

public extension ExpressibleAsTryExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createTryExpr()
  }
}

public protocol ExpressibleAsAwaitExpr: ExpressibleAsExprBuildable {
  func createAwaitExpr() -> AwaitExpr
}

public extension ExpressibleAsAwaitExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createAwaitExpr()
  }
}

public protocol ExpressibleAsDeclNameArgument: ExpressibleAsDeclNameArgumentList, ExpressibleAsSyntaxBuildable {
  func createDeclNameArgument() -> DeclNameArgument
}

public extension ExpressibleAsDeclNameArgument {
  /// Conformance to `ExpressibleAsDeclNameArgumentList`.
  func createDeclNameArgumentList() -> DeclNameArgumentList {
    return DeclNameArgumentList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDeclNameArgument()
  }
}

public protocol ExpressibleAsDeclNameArgumentList {
  func createDeclNameArgumentList() -> DeclNameArgumentList
}

public protocol ExpressibleAsDeclNameArguments: ExpressibleAsSyntaxBuildable {
  func createDeclNameArguments() -> DeclNameArguments
}

public extension ExpressibleAsDeclNameArguments {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDeclNameArguments()
  }
}

public protocol ExpressibleAsIdentifierExpr: ExpressibleAsExprBuildable {
  func createIdentifierExpr() -> IdentifierExpr
}

public extension ExpressibleAsIdentifierExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createIdentifierExpr()
  }
}

public protocol ExpressibleAsSuperRefExpr: ExpressibleAsExprBuildable {
  func createSuperRefExpr() -> SuperRefExpr
}

public extension ExpressibleAsSuperRefExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createSuperRefExpr()
  }
}

public protocol ExpressibleAsNilLiteralExpr: ExpressibleAsExprBuildable {
  func createNilLiteralExpr() -> NilLiteralExpr
}

public extension ExpressibleAsNilLiteralExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createNilLiteralExpr()
  }
}

public protocol ExpressibleAsDiscardAssignmentExpr: ExpressibleAsExprBuildable {
  func createDiscardAssignmentExpr() -> DiscardAssignmentExpr
}

public extension ExpressibleAsDiscardAssignmentExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createDiscardAssignmentExpr()
  }
}

public protocol ExpressibleAsAssignmentExpr: ExpressibleAsExprBuildable {
  func createAssignmentExpr() -> AssignmentExpr
}

public extension ExpressibleAsAssignmentExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createAssignmentExpr()
  }
}

public protocol ExpressibleAsSequenceExpr: ExpressibleAsCodeBlockItem, ExpressibleAsTupleExprElement, ExpressibleAsExprBuildable {
  func createSequenceExpr() -> SequenceExpr
}

public extension ExpressibleAsSequenceExpr {
  /// Conformance to `ExpressibleAsCodeBlockItem`.
  func createCodeBlockItem() -> CodeBlockItem {
    return CodeBlockItem(item: self)
  }
  /// Conformance to `ExpressibleAsTupleExprElement`.
  func createTupleExprElement() -> TupleExprElement {
    return TupleExprElement(expression: self)
  }
  func createExprBuildable() -> ExprBuildable {
    return self.createSequenceExpr()
  }
}

public protocol ExpressibleAsExprList: ExpressibleAsConditionElement {
  func createExprList() -> ExprList
}

public extension ExpressibleAsExprList {
  /// Conformance to `ExpressibleAsConditionElement`.
  func createConditionElement() -> ConditionElement {
    return ConditionElement(condition: self)
  }
}

public protocol ExpressibleAsPoundLineExpr: ExpressibleAsExprBuildable {
  func createPoundLineExpr() -> PoundLineExpr
}

public extension ExpressibleAsPoundLineExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPoundLineExpr()
  }
}

public protocol ExpressibleAsPoundFileExpr: ExpressibleAsExprBuildable {
  func createPoundFileExpr() -> PoundFileExpr
}

public extension ExpressibleAsPoundFileExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPoundFileExpr()
  }
}

public protocol ExpressibleAsPoundFileIDExpr: ExpressibleAsExprBuildable {
  func createPoundFileIDExpr() -> PoundFileIDExpr
}

public extension ExpressibleAsPoundFileIDExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPoundFileIDExpr()
  }
}

public protocol ExpressibleAsPoundFilePathExpr: ExpressibleAsExprBuildable {
  func createPoundFilePathExpr() -> PoundFilePathExpr
}

public extension ExpressibleAsPoundFilePathExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPoundFilePathExpr()
  }
}

public protocol ExpressibleAsPoundFunctionExpr: ExpressibleAsExprBuildable {
  func createPoundFunctionExpr() -> PoundFunctionExpr
}

public extension ExpressibleAsPoundFunctionExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPoundFunctionExpr()
  }
}

public protocol ExpressibleAsPoundDsohandleExpr: ExpressibleAsExprBuildable {
  func createPoundDsohandleExpr() -> PoundDsohandleExpr
}

public extension ExpressibleAsPoundDsohandleExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPoundDsohandleExpr()
  }
}

public protocol ExpressibleAsSymbolicReferenceExpr: ExpressibleAsExprBuildable {
  func createSymbolicReferenceExpr() -> SymbolicReferenceExpr
}

public extension ExpressibleAsSymbolicReferenceExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createSymbolicReferenceExpr()
  }
}

public protocol ExpressibleAsPrefixOperatorExpr: ExpressibleAsExprBuildable {
  func createPrefixOperatorExpr() -> PrefixOperatorExpr
}

public extension ExpressibleAsPrefixOperatorExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPrefixOperatorExpr()
  }
}

public protocol ExpressibleAsBinaryOperatorExpr: ExpressibleAsExprBuildable {
  func createBinaryOperatorExpr() -> BinaryOperatorExpr
}

public extension ExpressibleAsBinaryOperatorExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createBinaryOperatorExpr()
  }
}

public protocol ExpressibleAsArrowExpr: ExpressibleAsExprBuildable {
  func createArrowExpr() -> ArrowExpr
}

public extension ExpressibleAsArrowExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createArrowExpr()
  }
}

public protocol ExpressibleAsFloatLiteralExpr: ExpressibleAsExprBuildable {
  func createFloatLiteralExpr() -> FloatLiteralExpr
}

public extension ExpressibleAsFloatLiteralExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createFloatLiteralExpr()
  }
}

public protocol ExpressibleAsTupleExpr: ExpressibleAsExprBuildable {
  func createTupleExpr() -> TupleExpr
}

public extension ExpressibleAsTupleExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createTupleExpr()
  }
}

public protocol ExpressibleAsArrayExpr: ExpressibleAsExprBuildable {
  func createArrayExpr() -> ArrayExpr
}

public extension ExpressibleAsArrayExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createArrayExpr()
  }
}

public protocol ExpressibleAsDictionaryExpr: ExpressibleAsExprBuildable {
  func createDictionaryExpr() -> DictionaryExpr
}

public extension ExpressibleAsDictionaryExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createDictionaryExpr()
  }
}

public protocol ExpressibleAsTupleExprElement: ExpressibleAsTupleExprElementList, ExpressibleAsSyntaxBuildable {
  func createTupleExprElement() -> TupleExprElement
}

public extension ExpressibleAsTupleExprElement {
  /// Conformance to `ExpressibleAsTupleExprElementList`.
  func createTupleExprElementList() -> TupleExprElementList {
    return TupleExprElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createTupleExprElement()
  }
}

public protocol ExpressibleAsArrayElement: ExpressibleAsArrayElementList, ExpressibleAsSyntaxBuildable {
  func createArrayElement() -> ArrayElement
}

public extension ExpressibleAsArrayElement {
  /// Conformance to `ExpressibleAsArrayElementList`.
  func createArrayElementList() -> ArrayElementList {
    return ArrayElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createArrayElement()
  }
}

public protocol ExpressibleAsDictionaryElement: ExpressibleAsDictionaryElementList, ExpressibleAsSyntaxBuildable {
  func createDictionaryElement() -> DictionaryElement
}

public extension ExpressibleAsDictionaryElement {
  /// Conformance to `ExpressibleAsDictionaryElementList`.
  func createDictionaryElementList() -> DictionaryElementList {
    return DictionaryElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDictionaryElement()
  }
}

public protocol ExpressibleAsIntegerLiteralExpr: ExpressibleAsExprBuildable {
  func createIntegerLiteralExpr() -> IntegerLiteralExpr
}

public extension ExpressibleAsIntegerLiteralExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createIntegerLiteralExpr()
  }
}

public protocol ExpressibleAsBooleanLiteralExpr: ExpressibleAsExprBuildable {
  func createBooleanLiteralExpr() -> BooleanLiteralExpr
}

public extension ExpressibleAsBooleanLiteralExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createBooleanLiteralExpr()
  }
}

public protocol ExpressibleAsTernaryExpr: ExpressibleAsExprBuildable {
  func createTernaryExpr() -> TernaryExpr
}

public extension ExpressibleAsTernaryExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createTernaryExpr()
  }
}

public protocol ExpressibleAsMemberAccessExpr: ExpressibleAsExprBuildable {
  func createMemberAccessExpr() -> MemberAccessExpr
}

public extension ExpressibleAsMemberAccessExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createMemberAccessExpr()
  }
}

public protocol ExpressibleAsIsExpr: ExpressibleAsExprBuildable {
  func createIsExpr() -> IsExpr
}

public extension ExpressibleAsIsExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createIsExpr()
  }
}

public protocol ExpressibleAsAsExpr: ExpressibleAsExprBuildable {
  func createAsExpr() -> AsExpr
}

public extension ExpressibleAsAsExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createAsExpr()
  }
}

public protocol ExpressibleAsTypeExpr: ExpressibleAsExprBuildable {
  func createTypeExpr() -> TypeExpr
}

public extension ExpressibleAsTypeExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createTypeExpr()
  }
}

public protocol ExpressibleAsClosureCaptureItem: ExpressibleAsClosureCaptureItemList, ExpressibleAsSyntaxBuildable {
  func createClosureCaptureItem() -> ClosureCaptureItem
}

public extension ExpressibleAsClosureCaptureItem {
  /// Conformance to `ExpressibleAsClosureCaptureItemList`.
  func createClosureCaptureItemList() -> ClosureCaptureItemList {
    return ClosureCaptureItemList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createClosureCaptureItem()
  }
}

public protocol ExpressibleAsClosureCaptureItemList {
  func createClosureCaptureItemList() -> ClosureCaptureItemList
}

public protocol ExpressibleAsClosureCaptureSignature: ExpressibleAsSyntaxBuildable {
  func createClosureCaptureSignature() -> ClosureCaptureSignature
}

public extension ExpressibleAsClosureCaptureSignature {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createClosureCaptureSignature()
  }
}

public protocol ExpressibleAsClosureParam: ExpressibleAsClosureParamList, ExpressibleAsSyntaxBuildable {
  func createClosureParam() -> ClosureParam
}

public extension ExpressibleAsClosureParam {
  /// Conformance to `ExpressibleAsClosureParamList`.
  func createClosureParamList() -> ClosureParamList {
    return ClosureParamList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createClosureParam()
  }
}

public protocol ExpressibleAsClosureParamList {
  func createClosureParamList() -> ClosureParamList
}

public protocol ExpressibleAsClosureSignature: ExpressibleAsSyntaxBuildable {
  func createClosureSignature() -> ClosureSignature
}

public extension ExpressibleAsClosureSignature {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createClosureSignature()
  }
}

public protocol ExpressibleAsClosureExpr: ExpressibleAsExprBuildable {
  func createClosureExpr() -> ClosureExpr
}

public extension ExpressibleAsClosureExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createClosureExpr()
  }
}

public protocol ExpressibleAsUnresolvedPatternExpr: ExpressibleAsExprBuildable {
  func createUnresolvedPatternExpr() -> UnresolvedPatternExpr
}

public extension ExpressibleAsUnresolvedPatternExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createUnresolvedPatternExpr()
  }
}

public protocol ExpressibleAsMultipleTrailingClosureElement: ExpressibleAsMultipleTrailingClosureElementList, ExpressibleAsSyntaxBuildable {
  func createMultipleTrailingClosureElement() -> MultipleTrailingClosureElement
}

public extension ExpressibleAsMultipleTrailingClosureElement {
  /// Conformance to `ExpressibleAsMultipleTrailingClosureElementList`.
  func createMultipleTrailingClosureElementList() -> MultipleTrailingClosureElementList {
    return MultipleTrailingClosureElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createMultipleTrailingClosureElement()
  }
}

public protocol ExpressibleAsMultipleTrailingClosureElementList {
  func createMultipleTrailingClosureElementList() -> MultipleTrailingClosureElementList
}

public protocol ExpressibleAsFunctionCallExpr: ExpressibleAsCodeBlockItem, ExpressibleAsExprBuildable {
  func createFunctionCallExpr() -> FunctionCallExpr
}

public extension ExpressibleAsFunctionCallExpr {
  /// Conformance to `ExpressibleAsCodeBlockItem`.
  func createCodeBlockItem() -> CodeBlockItem {
    return CodeBlockItem(item: self)
  }
  func createExprBuildable() -> ExprBuildable {
    return self.createFunctionCallExpr()
  }
}

public protocol ExpressibleAsSubscriptExpr: ExpressibleAsExprBuildable {
  func createSubscriptExpr() -> SubscriptExpr
}

public extension ExpressibleAsSubscriptExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createSubscriptExpr()
  }
}

public protocol ExpressibleAsOptionalChainingExpr: ExpressibleAsExprBuildable {
  func createOptionalChainingExpr() -> OptionalChainingExpr
}

public extension ExpressibleAsOptionalChainingExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createOptionalChainingExpr()
  }
}

public protocol ExpressibleAsForcedValueExpr: ExpressibleAsExprBuildable {
  func createForcedValueExpr() -> ForcedValueExpr
}

public extension ExpressibleAsForcedValueExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createForcedValueExpr()
  }
}

public protocol ExpressibleAsPostfixUnaryExpr: ExpressibleAsExprBuildable {
  func createPostfixUnaryExpr() -> PostfixUnaryExpr
}

public extension ExpressibleAsPostfixUnaryExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPostfixUnaryExpr()
  }
}

public protocol ExpressibleAsSpecializeExpr: ExpressibleAsExprBuildable {
  func createSpecializeExpr() -> SpecializeExpr
}

public extension ExpressibleAsSpecializeExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createSpecializeExpr()
  }
}

public protocol ExpressibleAsStringSegment: ExpressibleAsSyntaxBuildable {
  func createStringSegment() -> StringSegment
}

public extension ExpressibleAsStringSegment {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createStringSegment()
  }
}

public protocol ExpressibleAsExpressionSegment: ExpressibleAsSyntaxBuildable {
  func createExpressionSegment() -> ExpressionSegment
}

public extension ExpressibleAsExpressionSegment {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createExpressionSegment()
  }
}

public protocol ExpressibleAsStringLiteralExpr: ExpressibleAsExprBuildable {
  func createStringLiteralExpr() -> StringLiteralExpr
}

public extension ExpressibleAsStringLiteralExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createStringLiteralExpr()
  }
}

public protocol ExpressibleAsRegexLiteralExpr: ExpressibleAsExprBuildable {
  func createRegexLiteralExpr() -> RegexLiteralExpr
}

public extension ExpressibleAsRegexLiteralExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createRegexLiteralExpr()
  }
}

public protocol ExpressibleAsKeyPathExpr: ExpressibleAsExprBuildable {
  func createKeyPathExpr() -> KeyPathExpr
}

public extension ExpressibleAsKeyPathExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createKeyPathExpr()
  }
}

public protocol ExpressibleAsKeyPathBaseExpr: ExpressibleAsExprBuildable {
  func createKeyPathBaseExpr() -> KeyPathBaseExpr
}

public extension ExpressibleAsKeyPathBaseExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createKeyPathBaseExpr()
  }
}

public protocol ExpressibleAsObjcNamePiece: ExpressibleAsObjcName, ExpressibleAsSyntaxBuildable {
  func createObjcNamePiece() -> ObjcNamePiece
}

public extension ExpressibleAsObjcNamePiece {
  /// Conformance to `ExpressibleAsObjcName`.
  func createObjcName() -> ObjcName {
    return ObjcName([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createObjcNamePiece()
  }
}

public protocol ExpressibleAsObjcName {
  func createObjcName() -> ObjcName
}

public protocol ExpressibleAsObjcKeyPathExpr: ExpressibleAsExprBuildable {
  func createObjcKeyPathExpr() -> ObjcKeyPathExpr
}

public extension ExpressibleAsObjcKeyPathExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createObjcKeyPathExpr()
  }
}

public protocol ExpressibleAsObjcSelectorExpr: ExpressibleAsExprBuildable {
  func createObjcSelectorExpr() -> ObjcSelectorExpr
}

public extension ExpressibleAsObjcSelectorExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createObjcSelectorExpr()
  }
}

public protocol ExpressibleAsPostfixIfConfigExpr: ExpressibleAsExprBuildable {
  func createPostfixIfConfigExpr() -> PostfixIfConfigExpr
}

public extension ExpressibleAsPostfixIfConfigExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createPostfixIfConfigExpr()
  }
}

public protocol ExpressibleAsEditorPlaceholderExpr: ExpressibleAsExprBuildable {
  func createEditorPlaceholderExpr() -> EditorPlaceholderExpr
}

public extension ExpressibleAsEditorPlaceholderExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createEditorPlaceholderExpr()
  }
}

public protocol ExpressibleAsObjectLiteralExpr: ExpressibleAsExprBuildable {
  func createObjectLiteralExpr() -> ObjectLiteralExpr
}

public extension ExpressibleAsObjectLiteralExpr {
  func createExprBuildable() -> ExprBuildable {
    return self.createObjectLiteralExpr()
  }
}

public protocol ExpressibleAsTypeInitializerClause: ExpressibleAsSyntaxBuildable {
  func createTypeInitializerClause() -> TypeInitializerClause
}

public extension ExpressibleAsTypeInitializerClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createTypeInitializerClause()
  }
}

public protocol ExpressibleAsTypealiasDecl: ExpressibleAsDeclBuildable {
  func createTypealiasDecl() -> TypealiasDecl
}

public extension ExpressibleAsTypealiasDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createTypealiasDecl()
  }
}

public protocol ExpressibleAsAssociatedtypeDecl: ExpressibleAsDeclBuildable {
  func createAssociatedtypeDecl() -> AssociatedtypeDecl
}

public extension ExpressibleAsAssociatedtypeDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createAssociatedtypeDecl()
  }
}

public protocol ExpressibleAsFunctionParameterList {
  func createFunctionParameterList() -> FunctionParameterList
}

public protocol ExpressibleAsParameterClause: ExpressibleAsSyntaxBuildable {
  func createParameterClause() -> ParameterClause
}

public extension ExpressibleAsParameterClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createParameterClause()
  }
}

public protocol ExpressibleAsReturnClause: ExpressibleAsSyntaxBuildable {
  func createReturnClause() -> ReturnClause
}

public extension ExpressibleAsReturnClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createReturnClause()
  }
}

public protocol ExpressibleAsFunctionSignature: ExpressibleAsSyntaxBuildable {
  func createFunctionSignature() -> FunctionSignature
}

public extension ExpressibleAsFunctionSignature {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createFunctionSignature()
  }
}

public protocol ExpressibleAsIfConfigClause: ExpressibleAsIfConfigClauseList, ExpressibleAsSyntaxBuildable {
  func createIfConfigClause() -> IfConfigClause
}

public extension ExpressibleAsIfConfigClause {
  /// Conformance to `ExpressibleAsIfConfigClauseList`.
  func createIfConfigClauseList() -> IfConfigClauseList {
    return IfConfigClauseList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createIfConfigClause()
  }
}

public protocol ExpressibleAsIfConfigClauseList {
  func createIfConfigClauseList() -> IfConfigClauseList
}

public protocol ExpressibleAsIfConfigDecl: ExpressibleAsDeclBuildable {
  func createIfConfigDecl() -> IfConfigDecl
}

public extension ExpressibleAsIfConfigDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createIfConfigDecl()
  }
}

public protocol ExpressibleAsPoundErrorDecl: ExpressibleAsDeclBuildable {
  func createPoundErrorDecl() -> PoundErrorDecl
}

public extension ExpressibleAsPoundErrorDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createPoundErrorDecl()
  }
}

public protocol ExpressibleAsPoundWarningDecl: ExpressibleAsDeclBuildable {
  func createPoundWarningDecl() -> PoundWarningDecl
}

public extension ExpressibleAsPoundWarningDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createPoundWarningDecl()
  }
}

public protocol ExpressibleAsPoundSourceLocation: ExpressibleAsDeclBuildable {
  func createPoundSourceLocation() -> PoundSourceLocation
}

public extension ExpressibleAsPoundSourceLocation {
  func createDeclBuildable() -> DeclBuildable {
    return self.createPoundSourceLocation()
  }
}

public protocol ExpressibleAsPoundSourceLocationArgs: ExpressibleAsSyntaxBuildable {
  func createPoundSourceLocationArgs() -> PoundSourceLocationArgs
}

public extension ExpressibleAsPoundSourceLocationArgs {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createPoundSourceLocationArgs()
  }
}

public protocol ExpressibleAsDeclModifier: ExpressibleAsModifierList, ExpressibleAsSyntaxBuildable {
  func createDeclModifier() -> DeclModifier
}

public extension ExpressibleAsDeclModifier {
  /// Conformance to `ExpressibleAsModifierList`.
  func createModifierList() -> ModifierList {
    return ModifierList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDeclModifier()
  }
}

public protocol ExpressibleAsInheritedType: ExpressibleAsInheritedTypeList, ExpressibleAsSyntaxBuildable {
  func createInheritedType() -> InheritedType
}

public extension ExpressibleAsInheritedType {
  /// Conformance to `ExpressibleAsInheritedTypeList`.
  func createInheritedTypeList() -> InheritedTypeList {
    return InheritedTypeList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createInheritedType()
  }
}

public protocol ExpressibleAsInheritedTypeList {
  func createInheritedTypeList() -> InheritedTypeList
}

public protocol ExpressibleAsTypeInheritanceClause: ExpressibleAsSyntaxBuildable {
  func createTypeInheritanceClause() -> TypeInheritanceClause
}

public extension ExpressibleAsTypeInheritanceClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createTypeInheritanceClause()
  }
}

public protocol ExpressibleAsClassDecl: ExpressibleAsDeclBuildable {
  func createClassDecl() -> ClassDecl
}

public extension ExpressibleAsClassDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createClassDecl()
  }
}

public protocol ExpressibleAsStructDecl: ExpressibleAsDeclBuildable {
  func createStructDecl() -> StructDecl
}

public extension ExpressibleAsStructDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createStructDecl()
  }
}

public protocol ExpressibleAsProtocolDecl: ExpressibleAsDeclBuildable {
  func createProtocolDecl() -> ProtocolDecl
}

public extension ExpressibleAsProtocolDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createProtocolDecl()
  }
}

public protocol ExpressibleAsExtensionDecl: ExpressibleAsDeclBuildable {
  func createExtensionDecl() -> ExtensionDecl
}

public extension ExpressibleAsExtensionDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createExtensionDecl()
  }
}

public protocol ExpressibleAsMemberDeclBlock: ExpressibleAsSyntaxBuildable {
  func createMemberDeclBlock() -> MemberDeclBlock
}

public extension ExpressibleAsMemberDeclBlock {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createMemberDeclBlock()
  }
}

public protocol ExpressibleAsMemberDeclList: ExpressibleAsMemberDeclBlock {
  func createMemberDeclList() -> MemberDeclList
}

public extension ExpressibleAsMemberDeclList {
  /// Conformance to `ExpressibleAsMemberDeclBlock`.
  func createMemberDeclBlock() -> MemberDeclBlock {
    return MemberDeclBlock(members: self)
  }
}

public protocol ExpressibleAsMemberDeclListItem: ExpressibleAsMemberDeclList {
  func createMemberDeclListItem() -> MemberDeclListItem
}

public extension ExpressibleAsMemberDeclListItem {
  /// Conformance to `ExpressibleAsMemberDeclList`.
  func createMemberDeclList() -> MemberDeclList {
    return MemberDeclList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createMemberDeclListItem()
  }
}

public protocol ExpressibleAsSourceFile: ExpressibleAsSyntaxBuildable {
  func createSourceFile() -> SourceFile
}

public extension ExpressibleAsSourceFile {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createSourceFile()
  }
}

public protocol ExpressibleAsInitializerClause: ExpressibleAsSyntaxBuildable {
  func createInitializerClause() -> InitializerClause
}

public extension ExpressibleAsInitializerClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createInitializerClause()
  }
}

public protocol ExpressibleAsFunctionParameter: ExpressibleAsFunctionParameterList, ExpressibleAsSyntaxBuildable {
  func createFunctionParameter() -> FunctionParameter
}

public extension ExpressibleAsFunctionParameter {
  /// Conformance to `ExpressibleAsFunctionParameterList`.
  func createFunctionParameterList() -> FunctionParameterList {
    return FunctionParameterList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createFunctionParameter()
  }
}

public protocol ExpressibleAsModifierList {
  func createModifierList() -> ModifierList
}

public protocol ExpressibleAsFunctionDecl: ExpressibleAsDeclBuildable {
  func createFunctionDecl() -> FunctionDecl
}

public extension ExpressibleAsFunctionDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createFunctionDecl()
  }
}

public protocol ExpressibleAsInitializerDecl: ExpressibleAsDeclBuildable {
  func createInitializerDecl() -> InitializerDecl
}

public extension ExpressibleAsInitializerDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createInitializerDecl()
  }
}

public protocol ExpressibleAsDeinitializerDecl: ExpressibleAsDeclBuildable {
  func createDeinitializerDecl() -> DeinitializerDecl
}

public extension ExpressibleAsDeinitializerDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createDeinitializerDecl()
  }
}

public protocol ExpressibleAsSubscriptDecl: ExpressibleAsDeclBuildable {
  func createSubscriptDecl() -> SubscriptDecl
}

public extension ExpressibleAsSubscriptDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createSubscriptDecl()
  }
}

public protocol ExpressibleAsAccessLevelModifier: ExpressibleAsSyntaxBuildable {
  func createAccessLevelModifier() -> AccessLevelModifier
}

public extension ExpressibleAsAccessLevelModifier {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAccessLevelModifier()
  }
}

public protocol ExpressibleAsAccessPathComponent: ExpressibleAsAccessPath, ExpressibleAsSyntaxBuildable {
  func createAccessPathComponent() -> AccessPathComponent
}

public extension ExpressibleAsAccessPathComponent {
  /// Conformance to `ExpressibleAsAccessPath`.
  func createAccessPath() -> AccessPath {
    return AccessPath([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAccessPathComponent()
  }
}

public protocol ExpressibleAsAccessPath {
  func createAccessPath() -> AccessPath
}

public protocol ExpressibleAsImportDecl: ExpressibleAsDeclBuildable {
  func createImportDecl() -> ImportDecl
}

public extension ExpressibleAsImportDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createImportDecl()
  }
}

public protocol ExpressibleAsAccessorParameter: ExpressibleAsSyntaxBuildable {
  func createAccessorParameter() -> AccessorParameter
}

public extension ExpressibleAsAccessorParameter {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAccessorParameter()
  }
}

public protocol ExpressibleAsAccessorDecl: ExpressibleAsAccessorList, ExpressibleAsDeclBuildable {
  func createAccessorDecl() -> AccessorDecl
}

public extension ExpressibleAsAccessorDecl {
  /// Conformance to `ExpressibleAsAccessorList`.
  func createAccessorList() -> AccessorList {
    return AccessorList([self])
  }
  func createDeclBuildable() -> DeclBuildable {
    return self.createAccessorDecl()
  }
}

public protocol ExpressibleAsAccessorList: ExpressibleAsAccessorBlock {
  func createAccessorList() -> AccessorList
}

public extension ExpressibleAsAccessorList {
  /// Conformance to `ExpressibleAsAccessorBlock`.
  func createAccessorBlock() -> AccessorBlock {
    return AccessorBlock(accessors: self)
  }
}

public protocol ExpressibleAsAccessorBlock: ExpressibleAsSyntaxBuildable {
  func createAccessorBlock() -> AccessorBlock
}

public extension ExpressibleAsAccessorBlock {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAccessorBlock()
  }
}

public protocol ExpressibleAsPatternBinding: ExpressibleAsPatternBindingList, ExpressibleAsSyntaxBuildable {
  func createPatternBinding() -> PatternBinding
}

public extension ExpressibleAsPatternBinding {
  /// Conformance to `ExpressibleAsPatternBindingList`.
  func createPatternBindingList() -> PatternBindingList {
    return PatternBindingList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createPatternBinding()
  }
}

public protocol ExpressibleAsPatternBindingList {
  func createPatternBindingList() -> PatternBindingList
}

public protocol ExpressibleAsVariableDecl: ExpressibleAsDeclBuildable {
  func createVariableDecl() -> VariableDecl
}

public extension ExpressibleAsVariableDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createVariableDecl()
  }
}

public protocol ExpressibleAsEnumCaseElement: ExpressibleAsEnumCaseElementList, ExpressibleAsSyntaxBuildable {
  func createEnumCaseElement() -> EnumCaseElement
}

public extension ExpressibleAsEnumCaseElement {
  /// Conformance to `ExpressibleAsEnumCaseElementList`.
  func createEnumCaseElementList() -> EnumCaseElementList {
    return EnumCaseElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createEnumCaseElement()
  }
}

public protocol ExpressibleAsEnumCaseElementList {
  func createEnumCaseElementList() -> EnumCaseElementList
}

public protocol ExpressibleAsEnumCaseDecl: ExpressibleAsDeclBuildable {
  func createEnumCaseDecl() -> EnumCaseDecl
}

public extension ExpressibleAsEnumCaseDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createEnumCaseDecl()
  }
}

public protocol ExpressibleAsEnumDecl: ExpressibleAsDeclBuildable {
  func createEnumDecl() -> EnumDecl
}

public extension ExpressibleAsEnumDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createEnumDecl()
  }
}

public protocol ExpressibleAsOperatorDecl: ExpressibleAsDeclBuildable {
  func createOperatorDecl() -> OperatorDecl
}

public extension ExpressibleAsOperatorDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createOperatorDecl()
  }
}

public protocol ExpressibleAsIdentifierList {
  func createIdentifierList() -> IdentifierList
}

public protocol ExpressibleAsOperatorPrecedenceAndTypes: ExpressibleAsSyntaxBuildable {
  func createOperatorPrecedenceAndTypes() -> OperatorPrecedenceAndTypes
}

public extension ExpressibleAsOperatorPrecedenceAndTypes {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createOperatorPrecedenceAndTypes()
  }
}

public protocol ExpressibleAsPrecedenceGroupDecl: ExpressibleAsDeclBuildable {
  func createPrecedenceGroupDecl() -> PrecedenceGroupDecl
}

public extension ExpressibleAsPrecedenceGroupDecl {
  func createDeclBuildable() -> DeclBuildable {
    return self.createPrecedenceGroupDecl()
  }
}

public protocol ExpressibleAsPrecedenceGroupAttributeList {
  func createPrecedenceGroupAttributeList() -> PrecedenceGroupAttributeList
}

public protocol ExpressibleAsPrecedenceGroupRelation: ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupRelation() -> PrecedenceGroupRelation
}

public extension ExpressibleAsPrecedenceGroupRelation {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createPrecedenceGroupRelation()
  }
}

public protocol ExpressibleAsPrecedenceGroupNameList {
  func createPrecedenceGroupNameList() -> PrecedenceGroupNameList
}

public protocol ExpressibleAsPrecedenceGroupNameElement: ExpressibleAsPrecedenceGroupNameList, ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupNameElement() -> PrecedenceGroupNameElement
}

public extension ExpressibleAsPrecedenceGroupNameElement {
  /// Conformance to `ExpressibleAsPrecedenceGroupNameList`.
  func createPrecedenceGroupNameList() -> PrecedenceGroupNameList {
    return PrecedenceGroupNameList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createPrecedenceGroupNameElement()
  }
}

public protocol ExpressibleAsPrecedenceGroupAssignment: ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupAssignment() -> PrecedenceGroupAssignment
}

public extension ExpressibleAsPrecedenceGroupAssignment {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createPrecedenceGroupAssignment()
  }
}

public protocol ExpressibleAsPrecedenceGroupAssociativity: ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupAssociativity() -> PrecedenceGroupAssociativity
}

public extension ExpressibleAsPrecedenceGroupAssociativity {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createPrecedenceGroupAssociativity()
  }
}

public protocol ExpressibleAsTokenList {
  func createTokenList() -> TokenList
}

public protocol ExpressibleAsNonEmptyTokenList {
  func createNonEmptyTokenList() -> NonEmptyTokenList
}

public protocol ExpressibleAsCustomAttribute: ExpressibleAsSyntaxBuildable {
  func createCustomAttribute() -> CustomAttribute
}

public extension ExpressibleAsCustomAttribute {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createCustomAttribute()
  }
}

public protocol ExpressibleAsAttribute: ExpressibleAsSyntaxBuildable {
  func createAttribute() -> Attribute
}

public extension ExpressibleAsAttribute {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAttribute()
  }
}

public protocol ExpressibleAsAttributeList {
  func createAttributeList() -> AttributeList
}

public protocol ExpressibleAsSpecializeAttributeSpecList {
  func createSpecializeAttributeSpecList() -> SpecializeAttributeSpecList
}

public protocol ExpressibleAsAvailabilityEntry: ExpressibleAsSyntaxBuildable {
  func createAvailabilityEntry() -> AvailabilityEntry
}

public extension ExpressibleAsAvailabilityEntry {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAvailabilityEntry()
  }
}

public protocol ExpressibleAsLabeledSpecializeEntry: ExpressibleAsSyntaxBuildable {
  func createLabeledSpecializeEntry() -> LabeledSpecializeEntry
}

public extension ExpressibleAsLabeledSpecializeEntry {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createLabeledSpecializeEntry()
  }
}

public protocol ExpressibleAsTargetFunctionEntry: ExpressibleAsSyntaxBuildable {
  func createTargetFunctionEntry() -> TargetFunctionEntry
}

public extension ExpressibleAsTargetFunctionEntry {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createTargetFunctionEntry()
  }
}

public protocol ExpressibleAsNamedAttributeStringArgument: ExpressibleAsSyntaxBuildable {
  func createNamedAttributeStringArgument() -> NamedAttributeStringArgument
}

public extension ExpressibleAsNamedAttributeStringArgument {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createNamedAttributeStringArgument()
  }
}

public protocol ExpressibleAsDeclName: ExpressibleAsSyntaxBuildable {
  func createDeclName() -> DeclName
}

public extension ExpressibleAsDeclName {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDeclName()
  }
}

public protocol ExpressibleAsImplementsAttributeArguments: ExpressibleAsSyntaxBuildable {
  func createImplementsAttributeArguments() -> ImplementsAttributeArguments
}

public extension ExpressibleAsImplementsAttributeArguments {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createImplementsAttributeArguments()
  }
}

public protocol ExpressibleAsObjCSelectorPiece: ExpressibleAsObjCSelector, ExpressibleAsSyntaxBuildable {
  func createObjCSelectorPiece() -> ObjCSelectorPiece
}

public extension ExpressibleAsObjCSelectorPiece {
  /// Conformance to `ExpressibleAsObjCSelector`.
  func createObjCSelector() -> ObjCSelector {
    return ObjCSelector([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createObjCSelectorPiece()
  }
}

public protocol ExpressibleAsObjCSelector {
  func createObjCSelector() -> ObjCSelector
}

public protocol ExpressibleAsDifferentiableAttributeArguments: ExpressibleAsSyntaxBuildable {
  func createDifferentiableAttributeArguments() -> DifferentiableAttributeArguments
}

public extension ExpressibleAsDifferentiableAttributeArguments {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDifferentiableAttributeArguments()
  }
}

public protocol ExpressibleAsDifferentiabilityParamsClause: ExpressibleAsSyntaxBuildable {
  func createDifferentiabilityParamsClause() -> DifferentiabilityParamsClause
}

public extension ExpressibleAsDifferentiabilityParamsClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDifferentiabilityParamsClause()
  }
}

public protocol ExpressibleAsDifferentiabilityParams: ExpressibleAsSyntaxBuildable {
  func createDifferentiabilityParams() -> DifferentiabilityParams
}

public extension ExpressibleAsDifferentiabilityParams {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDifferentiabilityParams()
  }
}

public protocol ExpressibleAsDifferentiabilityParamList {
  func createDifferentiabilityParamList() -> DifferentiabilityParamList
}

public protocol ExpressibleAsDifferentiabilityParam: ExpressibleAsDifferentiabilityParamList, ExpressibleAsSyntaxBuildable {
  func createDifferentiabilityParam() -> DifferentiabilityParam
}

public extension ExpressibleAsDifferentiabilityParam {
  /// Conformance to `ExpressibleAsDifferentiabilityParamList`.
  func createDifferentiabilityParamList() -> DifferentiabilityParamList {
    return DifferentiabilityParamList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDifferentiabilityParam()
  }
}

public protocol ExpressibleAsDerivativeRegistrationAttributeArguments: ExpressibleAsSyntaxBuildable {
  func createDerivativeRegistrationAttributeArguments() -> DerivativeRegistrationAttributeArguments
}

public extension ExpressibleAsDerivativeRegistrationAttributeArguments {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createDerivativeRegistrationAttributeArguments()
  }
}

public protocol ExpressibleAsQualifiedDeclName: ExpressibleAsSyntaxBuildable {
  func createQualifiedDeclName() -> QualifiedDeclName
}

public extension ExpressibleAsQualifiedDeclName {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createQualifiedDeclName()
  }
}

public protocol ExpressibleAsFunctionDeclName: ExpressibleAsSyntaxBuildable {
  func createFunctionDeclName() -> FunctionDeclName
}

public extension ExpressibleAsFunctionDeclName {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createFunctionDeclName()
  }
}

public protocol ExpressibleAsBackDeployAttributeSpecList: ExpressibleAsSyntaxBuildable {
  func createBackDeployAttributeSpecList() -> BackDeployAttributeSpecList
}

public extension ExpressibleAsBackDeployAttributeSpecList {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createBackDeployAttributeSpecList()
  }
}

public protocol ExpressibleAsBackDeployVersionList {
  func createBackDeployVersionList() -> BackDeployVersionList
}

public protocol ExpressibleAsBackDeployVersionArgument: ExpressibleAsBackDeployVersionList, ExpressibleAsSyntaxBuildable {
  func createBackDeployVersionArgument() -> BackDeployVersionArgument
}

public extension ExpressibleAsBackDeployVersionArgument {
  /// Conformance to `ExpressibleAsBackDeployVersionList`.
  func createBackDeployVersionList() -> BackDeployVersionList {
    return BackDeployVersionList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createBackDeployVersionArgument()
  }
}

public protocol ExpressibleAsContinueStmt: ExpressibleAsStmtBuildable {
  func createContinueStmt() -> ContinueStmt
}

public extension ExpressibleAsContinueStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createContinueStmt()
  }
}

public protocol ExpressibleAsWhileStmt: ExpressibleAsStmtBuildable {
  func createWhileStmt() -> WhileStmt
}

public extension ExpressibleAsWhileStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createWhileStmt()
  }
}

public protocol ExpressibleAsDeferStmt: ExpressibleAsStmtBuildable {
  func createDeferStmt() -> DeferStmt
}

public extension ExpressibleAsDeferStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createDeferStmt()
  }
}

public protocol ExpressibleAsExpressionStmt: ExpressibleAsStmtBuildable {
  func createExpressionStmt() -> ExpressionStmt
}

public extension ExpressibleAsExpressionStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createExpressionStmt()
  }
}

public protocol ExpressibleAsSwitchCaseList {
  func createSwitchCaseList() -> SwitchCaseList
}

public protocol ExpressibleAsRepeatWhileStmt: ExpressibleAsStmtBuildable {
  func createRepeatWhileStmt() -> RepeatWhileStmt
}

public extension ExpressibleAsRepeatWhileStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createRepeatWhileStmt()
  }
}

public protocol ExpressibleAsGuardStmt: ExpressibleAsStmtBuildable {
  func createGuardStmt() -> GuardStmt
}

public extension ExpressibleAsGuardStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createGuardStmt()
  }
}

public protocol ExpressibleAsWhereClause: ExpressibleAsSyntaxBuildable {
  func createWhereClause() -> WhereClause
}

public extension ExpressibleAsWhereClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createWhereClause()
  }
}

public protocol ExpressibleAsForInStmt: ExpressibleAsStmtBuildable {
  func createForInStmt() -> ForInStmt
}

public extension ExpressibleAsForInStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createForInStmt()
  }
}

public protocol ExpressibleAsSwitchStmt: ExpressibleAsStmtBuildable {
  func createSwitchStmt() -> SwitchStmt
}

public extension ExpressibleAsSwitchStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createSwitchStmt()
  }
}

public protocol ExpressibleAsCatchClauseList {
  func createCatchClauseList() -> CatchClauseList
}

public protocol ExpressibleAsDoStmt: ExpressibleAsStmtBuildable {
  func createDoStmt() -> DoStmt
}

public extension ExpressibleAsDoStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createDoStmt()
  }
}

public protocol ExpressibleAsReturnStmt: ExpressibleAsStmtBuildable {
  func createReturnStmt() -> ReturnStmt
}

public extension ExpressibleAsReturnStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createReturnStmt()
  }
}

public protocol ExpressibleAsYieldStmt: ExpressibleAsStmtBuildable {
  func createYieldStmt() -> YieldStmt
}

public extension ExpressibleAsYieldStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createYieldStmt()
  }
}

public protocol ExpressibleAsYieldList: ExpressibleAsSyntaxBuildable {
  func createYieldList() -> YieldList
}

public extension ExpressibleAsYieldList {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createYieldList()
  }
}

public protocol ExpressibleAsFallthroughStmt: ExpressibleAsStmtBuildable {
  func createFallthroughStmt() -> FallthroughStmt
}

public extension ExpressibleAsFallthroughStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createFallthroughStmt()
  }
}

public protocol ExpressibleAsBreakStmt: ExpressibleAsStmtBuildable {
  func createBreakStmt() -> BreakStmt
}

public extension ExpressibleAsBreakStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createBreakStmt()
  }
}

public protocol ExpressibleAsCaseItemList {
  func createCaseItemList() -> CaseItemList
}

public protocol ExpressibleAsCatchItemList {
  func createCatchItemList() -> CatchItemList
}

public protocol ExpressibleAsConditionElement: ExpressibleAsConditionElementList, ExpressibleAsSyntaxBuildable {
  func createConditionElement() -> ConditionElement
}

public extension ExpressibleAsConditionElement {
  /// Conformance to `ExpressibleAsConditionElementList`.
  func createConditionElementList() -> ConditionElementList {
    return ConditionElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createConditionElement()
  }
}

public protocol ExpressibleAsAvailabilityCondition: ExpressibleAsSyntaxBuildable {
  func createAvailabilityCondition() -> AvailabilityCondition
}

public extension ExpressibleAsAvailabilityCondition {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAvailabilityCondition()
  }
}

public protocol ExpressibleAsMatchingPatternCondition: ExpressibleAsSyntaxBuildable {
  func createMatchingPatternCondition() -> MatchingPatternCondition
}

public extension ExpressibleAsMatchingPatternCondition {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createMatchingPatternCondition()
  }
}

public protocol ExpressibleAsOptionalBindingCondition: ExpressibleAsSyntaxBuildable {
  func createOptionalBindingCondition() -> OptionalBindingCondition
}

public extension ExpressibleAsOptionalBindingCondition {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createOptionalBindingCondition()
  }
}

public protocol ExpressibleAsUnavailabilityCondition: ExpressibleAsSyntaxBuildable {
  func createUnavailabilityCondition() -> UnavailabilityCondition
}

public extension ExpressibleAsUnavailabilityCondition {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createUnavailabilityCondition()
  }
}

public protocol ExpressibleAsConditionElementList {
  func createConditionElementList() -> ConditionElementList
}

public protocol ExpressibleAsDeclarationStmt: ExpressibleAsStmtBuildable {
  func createDeclarationStmt() -> DeclarationStmt
}

public extension ExpressibleAsDeclarationStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createDeclarationStmt()
  }
}

public protocol ExpressibleAsThrowStmt: ExpressibleAsStmtBuildable {
  func createThrowStmt() -> ThrowStmt
}

public extension ExpressibleAsThrowStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createThrowStmt()
  }
}

public protocol ExpressibleAsIfStmt: ExpressibleAsStmtBuildable {
  func createIfStmt() -> IfStmt
}

public extension ExpressibleAsIfStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createIfStmt()
  }
}

public protocol ExpressibleAsElseIfContinuation: ExpressibleAsSyntaxBuildable {
  func createElseIfContinuation() -> ElseIfContinuation
}

public extension ExpressibleAsElseIfContinuation {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createElseIfContinuation()
  }
}

public protocol ExpressibleAsElseBlock: ExpressibleAsSyntaxBuildable {
  func createElseBlock() -> ElseBlock
}

public extension ExpressibleAsElseBlock {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createElseBlock()
  }
}

public protocol ExpressibleAsSwitchCase: ExpressibleAsSyntaxBuildable {
  func createSwitchCase() -> SwitchCase
}

public extension ExpressibleAsSwitchCase {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createSwitchCase()
  }
}

public protocol ExpressibleAsSwitchDefaultLabel: ExpressibleAsSyntaxBuildable {
  func createSwitchDefaultLabel() -> SwitchDefaultLabel
}

public extension ExpressibleAsSwitchDefaultLabel {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createSwitchDefaultLabel()
  }
}

public protocol ExpressibleAsCaseItem: ExpressibleAsCaseItemList, ExpressibleAsSyntaxBuildable {
  func createCaseItem() -> CaseItem
}

public extension ExpressibleAsCaseItem {
  /// Conformance to `ExpressibleAsCaseItemList`.
  func createCaseItemList() -> CaseItemList {
    return CaseItemList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createCaseItem()
  }
}

public protocol ExpressibleAsCatchItem: ExpressibleAsCatchItemList, ExpressibleAsSyntaxBuildable {
  func createCatchItem() -> CatchItem
}

public extension ExpressibleAsCatchItem {
  /// Conformance to `ExpressibleAsCatchItemList`.
  func createCatchItemList() -> CatchItemList {
    return CatchItemList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createCatchItem()
  }
}

public protocol ExpressibleAsSwitchCaseLabel: ExpressibleAsSyntaxBuildable {
  func createSwitchCaseLabel() -> SwitchCaseLabel
}

public extension ExpressibleAsSwitchCaseLabel {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createSwitchCaseLabel()
  }
}

public protocol ExpressibleAsCatchClause: ExpressibleAsCatchClauseList, ExpressibleAsSyntaxBuildable {
  func createCatchClause() -> CatchClause
}

public extension ExpressibleAsCatchClause {
  /// Conformance to `ExpressibleAsCatchClauseList`.
  func createCatchClauseList() -> CatchClauseList {
    return CatchClauseList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createCatchClause()
  }
}

public protocol ExpressibleAsPoundAssertStmt: ExpressibleAsStmtBuildable {
  func createPoundAssertStmt() -> PoundAssertStmt
}

public extension ExpressibleAsPoundAssertStmt {
  func createStmtBuildable() -> StmtBuildable {
    return self.createPoundAssertStmt()
  }
}

public protocol ExpressibleAsGenericWhereClause: ExpressibleAsSyntaxBuildable {
  func createGenericWhereClause() -> GenericWhereClause
}

public extension ExpressibleAsGenericWhereClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createGenericWhereClause()
  }
}

public protocol ExpressibleAsGenericRequirementList {
  func createGenericRequirementList() -> GenericRequirementList
}

public protocol ExpressibleAsGenericRequirement: ExpressibleAsGenericRequirementList, ExpressibleAsSyntaxBuildable {
  func createGenericRequirement() -> GenericRequirement
}

public extension ExpressibleAsGenericRequirement {
  /// Conformance to `ExpressibleAsGenericRequirementList`.
  func createGenericRequirementList() -> GenericRequirementList {
    return GenericRequirementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createGenericRequirement()
  }
}

public protocol ExpressibleAsSameTypeRequirement: ExpressibleAsSyntaxBuildable {
  func createSameTypeRequirement() -> SameTypeRequirement
}

public extension ExpressibleAsSameTypeRequirement {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createSameTypeRequirement()
  }
}

public protocol ExpressibleAsGenericParameterList {
  func createGenericParameterList() -> GenericParameterList
}

public protocol ExpressibleAsGenericParameter: ExpressibleAsGenericParameterList, ExpressibleAsSyntaxBuildable {
  func createGenericParameter() -> GenericParameter
}

public extension ExpressibleAsGenericParameter {
  /// Conformance to `ExpressibleAsGenericParameterList`.
  func createGenericParameterList() -> GenericParameterList {
    return GenericParameterList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createGenericParameter()
  }
}

public protocol ExpressibleAsPrimaryAssociatedTypeList {
  func createPrimaryAssociatedTypeList() -> PrimaryAssociatedTypeList
}

public protocol ExpressibleAsPrimaryAssociatedType: ExpressibleAsPrimaryAssociatedTypeList, ExpressibleAsSyntaxBuildable {
  func createPrimaryAssociatedType() -> PrimaryAssociatedType
}

public extension ExpressibleAsPrimaryAssociatedType {
  /// Conformance to `ExpressibleAsPrimaryAssociatedTypeList`.
  func createPrimaryAssociatedTypeList() -> PrimaryAssociatedTypeList {
    return PrimaryAssociatedTypeList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createPrimaryAssociatedType()
  }
}

public protocol ExpressibleAsGenericParameterClause: ExpressibleAsSyntaxBuildable {
  func createGenericParameterClause() -> GenericParameterClause
}

public extension ExpressibleAsGenericParameterClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createGenericParameterClause()
  }
}

public protocol ExpressibleAsConformanceRequirement: ExpressibleAsSyntaxBuildable {
  func createConformanceRequirement() -> ConformanceRequirement
}

public extension ExpressibleAsConformanceRequirement {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createConformanceRequirement()
  }
}

public protocol ExpressibleAsPrimaryAssociatedTypeClause: ExpressibleAsSyntaxBuildable {
  func createPrimaryAssociatedTypeClause() -> PrimaryAssociatedTypeClause
}

public extension ExpressibleAsPrimaryAssociatedTypeClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createPrimaryAssociatedTypeClause()
  }
}

public protocol ExpressibleAsSimpleTypeIdentifier: ExpressibleAsTypeAnnotation, ExpressibleAsTypeExpr, ExpressibleAsTypeBuildable {
  func createSimpleTypeIdentifier() -> SimpleTypeIdentifier
}

public extension ExpressibleAsSimpleTypeIdentifier {
  /// Conformance to `ExpressibleAsTypeAnnotation`.
  func createTypeAnnotation() -> TypeAnnotation {
    return TypeAnnotation(type: self)
  }
  /// Conformance to `ExpressibleAsTypeExpr`.
  func createTypeExpr() -> TypeExpr {
    return TypeExpr(type: self)
  }
  func createTypeBuildable() -> TypeBuildable {
    return self.createSimpleTypeIdentifier()
  }
}

public protocol ExpressibleAsMemberTypeIdentifier: ExpressibleAsTypeBuildable {
  func createMemberTypeIdentifier() -> MemberTypeIdentifier
}

public extension ExpressibleAsMemberTypeIdentifier {
  func createTypeBuildable() -> TypeBuildable {
    return self.createMemberTypeIdentifier()
  }
}

public protocol ExpressibleAsClassRestrictionType: ExpressibleAsTypeBuildable {
  func createClassRestrictionType() -> ClassRestrictionType
}

public extension ExpressibleAsClassRestrictionType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createClassRestrictionType()
  }
}

public protocol ExpressibleAsArrayType: ExpressibleAsTypeBuildable {
  func createArrayType() -> ArrayType
}

public extension ExpressibleAsArrayType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createArrayType()
  }
}

public protocol ExpressibleAsDictionaryType: ExpressibleAsTypeBuildable {
  func createDictionaryType() -> DictionaryType
}

public extension ExpressibleAsDictionaryType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createDictionaryType()
  }
}

public protocol ExpressibleAsMetatypeType: ExpressibleAsTypeBuildable {
  func createMetatypeType() -> MetatypeType
}

public extension ExpressibleAsMetatypeType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createMetatypeType()
  }
}

public protocol ExpressibleAsOptionalType: ExpressibleAsTypeBuildable {
  func createOptionalType() -> OptionalType
}

public extension ExpressibleAsOptionalType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createOptionalType()
  }
}

public protocol ExpressibleAsConstrainedSugarType: ExpressibleAsTypeBuildable {
  func createConstrainedSugarType() -> ConstrainedSugarType
}

public extension ExpressibleAsConstrainedSugarType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createConstrainedSugarType()
  }
}

public protocol ExpressibleAsImplicitlyUnwrappedOptionalType: ExpressibleAsTypeBuildable {
  func createImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalType
}

public extension ExpressibleAsImplicitlyUnwrappedOptionalType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createImplicitlyUnwrappedOptionalType()
  }
}

public protocol ExpressibleAsCompositionTypeElement: ExpressibleAsCompositionTypeElementList, ExpressibleAsSyntaxBuildable {
  func createCompositionTypeElement() -> CompositionTypeElement
}

public extension ExpressibleAsCompositionTypeElement {
  /// Conformance to `ExpressibleAsCompositionTypeElementList`.
  func createCompositionTypeElementList() -> CompositionTypeElementList {
    return CompositionTypeElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createCompositionTypeElement()
  }
}

public protocol ExpressibleAsCompositionTypeElementList {
  func createCompositionTypeElementList() -> CompositionTypeElementList
}

public protocol ExpressibleAsCompositionType: ExpressibleAsTypeBuildable {
  func createCompositionType() -> CompositionType
}

public extension ExpressibleAsCompositionType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createCompositionType()
  }
}

public protocol ExpressibleAsTupleTypeElement: ExpressibleAsTupleTypeElementList, ExpressibleAsSyntaxBuildable {
  func createTupleTypeElement() -> TupleTypeElement
}

public extension ExpressibleAsTupleTypeElement {
  /// Conformance to `ExpressibleAsTupleTypeElementList`.
  func createTupleTypeElementList() -> TupleTypeElementList {
    return TupleTypeElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createTupleTypeElement()
  }
}

public protocol ExpressibleAsTupleTypeElementList {
  func createTupleTypeElementList() -> TupleTypeElementList
}

public protocol ExpressibleAsTupleType: ExpressibleAsTypeBuildable {
  func createTupleType() -> TupleType
}

public extension ExpressibleAsTupleType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createTupleType()
  }
}

public protocol ExpressibleAsFunctionType: ExpressibleAsTypeBuildable {
  func createFunctionType() -> FunctionType
}

public extension ExpressibleAsFunctionType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createFunctionType()
  }
}

public protocol ExpressibleAsAttributedType: ExpressibleAsTypeBuildable {
  func createAttributedType() -> AttributedType
}

public extension ExpressibleAsAttributedType {
  func createTypeBuildable() -> TypeBuildable {
    return self.createAttributedType()
  }
}

public protocol ExpressibleAsGenericArgumentList {
  func createGenericArgumentList() -> GenericArgumentList
}

public protocol ExpressibleAsGenericArgument: ExpressibleAsGenericArgumentList, ExpressibleAsSyntaxBuildable {
  func createGenericArgument() -> GenericArgument
}

public extension ExpressibleAsGenericArgument {
  /// Conformance to `ExpressibleAsGenericArgumentList`.
  func createGenericArgumentList() -> GenericArgumentList {
    return GenericArgumentList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createGenericArgument()
  }
}

public protocol ExpressibleAsGenericArgumentClause: ExpressibleAsSyntaxBuildable {
  func createGenericArgumentClause() -> GenericArgumentClause
}

public extension ExpressibleAsGenericArgumentClause {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createGenericArgumentClause()
  }
}

public protocol ExpressibleAsTypeAnnotation: ExpressibleAsSyntaxBuildable {
  func createTypeAnnotation() -> TypeAnnotation
}

public extension ExpressibleAsTypeAnnotation {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createTypeAnnotation()
  }
}

public protocol ExpressibleAsEnumCasePattern: ExpressibleAsPatternBuildable {
  func createEnumCasePattern() -> EnumCasePattern
}

public extension ExpressibleAsEnumCasePattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createEnumCasePattern()
  }
}

public protocol ExpressibleAsIsTypePattern: ExpressibleAsPatternBuildable {
  func createIsTypePattern() -> IsTypePattern
}

public extension ExpressibleAsIsTypePattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createIsTypePattern()
  }
}

public protocol ExpressibleAsOptionalPattern: ExpressibleAsPatternBuildable {
  func createOptionalPattern() -> OptionalPattern
}

public extension ExpressibleAsOptionalPattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createOptionalPattern()
  }
}

public protocol ExpressibleAsIdentifierPattern: ExpressibleAsPatternBuildable {
  func createIdentifierPattern() -> IdentifierPattern
}

public extension ExpressibleAsIdentifierPattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createIdentifierPattern()
  }
}

public protocol ExpressibleAsAsTypePattern: ExpressibleAsPatternBuildable {
  func createAsTypePattern() -> AsTypePattern
}

public extension ExpressibleAsAsTypePattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createAsTypePattern()
  }
}

public protocol ExpressibleAsTuplePattern: ExpressibleAsPatternBuildable {
  func createTuplePattern() -> TuplePattern
}

public extension ExpressibleAsTuplePattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createTuplePattern()
  }
}

public protocol ExpressibleAsWildcardPattern: ExpressibleAsPatternBuildable {
  func createWildcardPattern() -> WildcardPattern
}

public extension ExpressibleAsWildcardPattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createWildcardPattern()
  }
}

public protocol ExpressibleAsTuplePatternElement: ExpressibleAsTuplePatternElementList, ExpressibleAsSyntaxBuildable {
  func createTuplePatternElement() -> TuplePatternElement
}

public extension ExpressibleAsTuplePatternElement {
  /// Conformance to `ExpressibleAsTuplePatternElementList`.
  func createTuplePatternElementList() -> TuplePatternElementList {
    return TuplePatternElementList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createTuplePatternElement()
  }
}

public protocol ExpressibleAsExpressionPattern: ExpressibleAsPatternBuildable {
  func createExpressionPattern() -> ExpressionPattern
}

public extension ExpressibleAsExpressionPattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createExpressionPattern()
  }
}

public protocol ExpressibleAsTuplePatternElementList {
  func createTuplePatternElementList() -> TuplePatternElementList
}

public protocol ExpressibleAsValueBindingPattern: ExpressibleAsPatternBuildable {
  func createValueBindingPattern() -> ValueBindingPattern
}

public extension ExpressibleAsValueBindingPattern {
  func createPatternBuildable() -> PatternBuildable {
    return self.createValueBindingPattern()
  }
}

public protocol ExpressibleAsAvailabilitySpecList {
  func createAvailabilitySpecList() -> AvailabilitySpecList
}

public protocol ExpressibleAsAvailabilityArgument: ExpressibleAsAvailabilitySpecList, ExpressibleAsSyntaxBuildable {
  func createAvailabilityArgument() -> AvailabilityArgument
}

public extension ExpressibleAsAvailabilityArgument {
  /// Conformance to `ExpressibleAsAvailabilitySpecList`.
  func createAvailabilitySpecList() -> AvailabilitySpecList {
    return AvailabilitySpecList([self])
  }
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAvailabilityArgument()
  }
}

public protocol ExpressibleAsAvailabilityLabeledArgument: ExpressibleAsSyntaxBuildable {
  func createAvailabilityLabeledArgument() -> AvailabilityLabeledArgument
}

public extension ExpressibleAsAvailabilityLabeledArgument {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAvailabilityLabeledArgument()
  }
}

public protocol ExpressibleAsAvailabilityVersionRestriction: ExpressibleAsSyntaxBuildable {
  func createAvailabilityVersionRestriction() -> AvailabilityVersionRestriction
}

public extension ExpressibleAsAvailabilityVersionRestriction {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createAvailabilityVersionRestriction()
  }
}

public protocol ExpressibleAsVersionTuple: ExpressibleAsSyntaxBuildable {
  func createVersionTuple() -> VersionTuple
}

public extension ExpressibleAsVersionTuple {
  func createSyntaxBuildable() -> SyntaxBuildable {
    return self.createVersionTuple()
  }
}

