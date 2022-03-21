//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===---------- Misc.swift - Miscelaneous SwiftSyntax definitions ---------===//
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

extension SyntaxNode {
  public var isUnknown: Bool { return raw.kind.isUnknown }
  public var asUnknown: UnknownSyntax? {
    guard isUnknown else { return nil }
    return UnknownSyntax(asSyntaxData)
  }

  public var isUnknownDecl: Bool { return raw.kind == .unknownDecl }
  public var asUnknownDecl: UnknownDeclSyntax? {
    guard isUnknownDecl else { return nil }
    return UnknownDeclSyntax(asSyntaxData)
  }

  public var isUnknownExpr: Bool { return raw.kind == .unknownExpr }
  public var asUnknownExpr: UnknownExprSyntax? {
    guard isUnknownExpr else { return nil }
    return UnknownExprSyntax(asSyntaxData)
  }

  public var isUnknownStmt: Bool { return raw.kind == .unknownStmt }
  public var asUnknownStmt: UnknownStmtSyntax? {
    guard isUnknownStmt else { return nil }
    return UnknownStmtSyntax(asSyntaxData)
  }

  public var isUnknownType: Bool { return raw.kind == .unknownType }
  public var asUnknownType: UnknownTypeSyntax? {
    guard isUnknownType else { return nil }
    return UnknownTypeSyntax(asSyntaxData)
  }

  public var isUnknownPattern: Bool { return raw.kind == .unknownPattern }
  public var asUnknownPattern: UnknownPatternSyntax? {
    guard isUnknownPattern else { return nil }
    return UnknownPatternSyntax(asSyntaxData)
  }

  public var isCodeBlockItem: Bool { return raw.kind == .codeBlockItem }
  public var asCodeBlockItem: CodeBlockItemSyntax? {
    guard isCodeBlockItem else { return nil }
    return CodeBlockItemSyntax(asSyntaxData)
  }

  public var isCodeBlockItemList: Bool { return raw.kind == .codeBlockItemList }
  public var asCodeBlockItemList: CodeBlockItemListSyntax? {
    guard isCodeBlockItemList else { return nil }
    return CodeBlockItemListSyntax(asSyntaxData)
  }

  public var isCodeBlock: Bool { return raw.kind == .codeBlock }
  public var asCodeBlock: CodeBlockSyntax? {
    guard isCodeBlock else { return nil }
    return CodeBlockSyntax(asSyntaxData)
  }

  public var isInOutExpr: Bool { return raw.kind == .inOutExpr }
  public var asInOutExpr: InOutExprSyntax? {
    guard isInOutExpr else { return nil }
    return InOutExprSyntax(asSyntaxData)
  }

  public var isPoundColumnExpr: Bool { return raw.kind == .poundColumnExpr }
  public var asPoundColumnExpr: PoundColumnExprSyntax? {
    guard isPoundColumnExpr else { return nil }
    return PoundColumnExprSyntax(asSyntaxData)
  }

  public var isTupleExprElementList: Bool { return raw.kind == .tupleExprElementList }
  public var asTupleExprElementList: TupleExprElementListSyntax? {
    guard isTupleExprElementList else { return nil }
    return TupleExprElementListSyntax(asSyntaxData)
  }

  public var isArrayElementList: Bool { return raw.kind == .arrayElementList }
  public var asArrayElementList: ArrayElementListSyntax? {
    guard isArrayElementList else { return nil }
    return ArrayElementListSyntax(asSyntaxData)
  }

  public var isDictionaryElementList: Bool { return raw.kind == .dictionaryElementList }
  public var asDictionaryElementList: DictionaryElementListSyntax? {
    guard isDictionaryElementList else { return nil }
    return DictionaryElementListSyntax(asSyntaxData)
  }

  public var isStringLiteralSegments: Bool { return raw.kind == .stringLiteralSegments }
  public var asStringLiteralSegments: StringLiteralSegmentsSyntax? {
    guard isStringLiteralSegments else { return nil }
    return StringLiteralSegmentsSyntax(asSyntaxData)
  }

  public var isTryExpr: Bool { return raw.kind == .tryExpr }
  public var asTryExpr: TryExprSyntax? {
    guard isTryExpr else { return nil }
    return TryExprSyntax(asSyntaxData)
  }

  public var isAwaitExpr: Bool { return raw.kind == .awaitExpr }
  public var asAwaitExpr: AwaitExprSyntax? {
    guard isAwaitExpr else { return nil }
    return AwaitExprSyntax(asSyntaxData)
  }

  public var isDeclNameArgument: Bool { return raw.kind == .declNameArgument }
  public var asDeclNameArgument: DeclNameArgumentSyntax? {
    guard isDeclNameArgument else { return nil }
    return DeclNameArgumentSyntax(asSyntaxData)
  }

  public var isDeclNameArgumentList: Bool { return raw.kind == .declNameArgumentList }
  public var asDeclNameArgumentList: DeclNameArgumentListSyntax? {
    guard isDeclNameArgumentList else { return nil }
    return DeclNameArgumentListSyntax(asSyntaxData)
  }

  public var isDeclNameArguments: Bool { return raw.kind == .declNameArguments }
  public var asDeclNameArguments: DeclNameArgumentsSyntax? {
    guard isDeclNameArguments else { return nil }
    return DeclNameArgumentsSyntax(asSyntaxData)
  }

  public var isIdentifierExpr: Bool { return raw.kind == .identifierExpr }
  public var asIdentifierExpr: IdentifierExprSyntax? {
    guard isIdentifierExpr else { return nil }
    return IdentifierExprSyntax(asSyntaxData)
  }

  public var isSuperRefExpr: Bool { return raw.kind == .superRefExpr }
  public var asSuperRefExpr: SuperRefExprSyntax? {
    guard isSuperRefExpr else { return nil }
    return SuperRefExprSyntax(asSyntaxData)
  }

  public var isNilLiteralExpr: Bool { return raw.kind == .nilLiteralExpr }
  public var asNilLiteralExpr: NilLiteralExprSyntax? {
    guard isNilLiteralExpr else { return nil }
    return NilLiteralExprSyntax(asSyntaxData)
  }

  public var isDiscardAssignmentExpr: Bool { return raw.kind == .discardAssignmentExpr }
  public var asDiscardAssignmentExpr: DiscardAssignmentExprSyntax? {
    guard isDiscardAssignmentExpr else { return nil }
    return DiscardAssignmentExprSyntax(asSyntaxData)
  }

  public var isAssignmentExpr: Bool { return raw.kind == .assignmentExpr }
  public var asAssignmentExpr: AssignmentExprSyntax? {
    guard isAssignmentExpr else { return nil }
    return AssignmentExprSyntax(asSyntaxData)
  }

  public var isSequenceExpr: Bool { return raw.kind == .sequenceExpr }
  public var asSequenceExpr: SequenceExprSyntax? {
    guard isSequenceExpr else { return nil }
    return SequenceExprSyntax(asSyntaxData)
  }

  public var isExprList: Bool { return raw.kind == .exprList }
  public var asExprList: ExprListSyntax? {
    guard isExprList else { return nil }
    return ExprListSyntax(asSyntaxData)
  }

  public var isPoundLineExpr: Bool { return raw.kind == .poundLineExpr }
  public var asPoundLineExpr: PoundLineExprSyntax? {
    guard isPoundLineExpr else { return nil }
    return PoundLineExprSyntax(asSyntaxData)
  }

  public var isPoundFileExpr: Bool { return raw.kind == .poundFileExpr }
  public var asPoundFileExpr: PoundFileExprSyntax? {
    guard isPoundFileExpr else { return nil }
    return PoundFileExprSyntax(asSyntaxData)
  }

  public var isPoundFileIDExpr: Bool { return raw.kind == .poundFileIDExpr }
  public var asPoundFileIDExpr: PoundFileIDExprSyntax? {
    guard isPoundFileIDExpr else { return nil }
    return PoundFileIDExprSyntax(asSyntaxData)
  }

  public var isPoundFilePathExpr: Bool { return raw.kind == .poundFilePathExpr }
  public var asPoundFilePathExpr: PoundFilePathExprSyntax? {
    guard isPoundFilePathExpr else { return nil }
    return PoundFilePathExprSyntax(asSyntaxData)
  }

  public var isPoundFunctionExpr: Bool { return raw.kind == .poundFunctionExpr }
  public var asPoundFunctionExpr: PoundFunctionExprSyntax? {
    guard isPoundFunctionExpr else { return nil }
    return PoundFunctionExprSyntax(asSyntaxData)
  }

  public var isPoundDsohandleExpr: Bool { return raw.kind == .poundDsohandleExpr }
  public var asPoundDsohandleExpr: PoundDsohandleExprSyntax? {
    guard isPoundDsohandleExpr else { return nil }
    return PoundDsohandleExprSyntax(asSyntaxData)
  }

  public var isSymbolicReferenceExpr: Bool { return raw.kind == .symbolicReferenceExpr }
  public var asSymbolicReferenceExpr: SymbolicReferenceExprSyntax? {
    guard isSymbolicReferenceExpr else { return nil }
    return SymbolicReferenceExprSyntax(asSyntaxData)
  }

  public var isPrefixOperatorExpr: Bool { return raw.kind == .prefixOperatorExpr }
  public var asPrefixOperatorExpr: PrefixOperatorExprSyntax? {
    guard isPrefixOperatorExpr else { return nil }
    return PrefixOperatorExprSyntax(asSyntaxData)
  }

  public var isBinaryOperatorExpr: Bool { return raw.kind == .binaryOperatorExpr }
  public var asBinaryOperatorExpr: BinaryOperatorExprSyntax? {
    guard isBinaryOperatorExpr else { return nil }
    return BinaryOperatorExprSyntax(asSyntaxData)
  }

  public var isArrowExpr: Bool { return raw.kind == .arrowExpr }
  public var asArrowExpr: ArrowExprSyntax? {
    guard isArrowExpr else { return nil }
    return ArrowExprSyntax(asSyntaxData)
  }

  public var isFloatLiteralExpr: Bool { return raw.kind == .floatLiteralExpr }
  public var asFloatLiteralExpr: FloatLiteralExprSyntax? {
    guard isFloatLiteralExpr else { return nil }
    return FloatLiteralExprSyntax(asSyntaxData)
  }

  public var isTupleExpr: Bool { return raw.kind == .tupleExpr }
  public var asTupleExpr: TupleExprSyntax? {
    guard isTupleExpr else { return nil }
    return TupleExprSyntax(asSyntaxData)
  }

  public var isArrayExpr: Bool { return raw.kind == .arrayExpr }
  public var asArrayExpr: ArrayExprSyntax? {
    guard isArrayExpr else { return nil }
    return ArrayExprSyntax(asSyntaxData)
  }

  public var isDictionaryExpr: Bool { return raw.kind == .dictionaryExpr }
  public var asDictionaryExpr: DictionaryExprSyntax? {
    guard isDictionaryExpr else { return nil }
    return DictionaryExprSyntax(asSyntaxData)
  }

  public var isTupleExprElement: Bool { return raw.kind == .tupleExprElement }
  public var asTupleExprElement: TupleExprElementSyntax? {
    guard isTupleExprElement else { return nil }
    return TupleExprElementSyntax(asSyntaxData)
  }

  public var isArrayElement: Bool { return raw.kind == .arrayElement }
  public var asArrayElement: ArrayElementSyntax? {
    guard isArrayElement else { return nil }
    return ArrayElementSyntax(asSyntaxData)
  }

  public var isDictionaryElement: Bool { return raw.kind == .dictionaryElement }
  public var asDictionaryElement: DictionaryElementSyntax? {
    guard isDictionaryElement else { return nil }
    return DictionaryElementSyntax(asSyntaxData)
  }

  public var isIntegerLiteralExpr: Bool { return raw.kind == .integerLiteralExpr }
  public var asIntegerLiteralExpr: IntegerLiteralExprSyntax? {
    guard isIntegerLiteralExpr else { return nil }
    return IntegerLiteralExprSyntax(asSyntaxData)
  }

  public var isBooleanLiteralExpr: Bool { return raw.kind == .booleanLiteralExpr }
  public var asBooleanLiteralExpr: BooleanLiteralExprSyntax? {
    guard isBooleanLiteralExpr else { return nil }
    return BooleanLiteralExprSyntax(asSyntaxData)
  }

  public var isTernaryExpr: Bool { return raw.kind == .ternaryExpr }
  public var asTernaryExpr: TernaryExprSyntax? {
    guard isTernaryExpr else { return nil }
    return TernaryExprSyntax(asSyntaxData)
  }

  public var isMemberAccessExpr: Bool { return raw.kind == .memberAccessExpr }
  public var asMemberAccessExpr: MemberAccessExprSyntax? {
    guard isMemberAccessExpr else { return nil }
    return MemberAccessExprSyntax(asSyntaxData)
  }

  public var isIsExpr: Bool { return raw.kind == .isExpr }
  public var asIsExpr: IsExprSyntax? {
    guard isIsExpr else { return nil }
    return IsExprSyntax(asSyntaxData)
  }

  public var isAsExpr: Bool { return raw.kind == .asExpr }
  public var asAsExpr: AsExprSyntax? {
    guard isAsExpr else { return nil }
    return AsExprSyntax(asSyntaxData)
  }

  public var isTypeExpr: Bool { return raw.kind == .typeExpr }
  public var asTypeExpr: TypeExprSyntax? {
    guard isTypeExpr else { return nil }
    return TypeExprSyntax(asSyntaxData)
  }

  public var isClosureCaptureItem: Bool { return raw.kind == .closureCaptureItem }
  public var asClosureCaptureItem: ClosureCaptureItemSyntax? {
    guard isClosureCaptureItem else { return nil }
    return ClosureCaptureItemSyntax(asSyntaxData)
  }

  public var isClosureCaptureItemList: Bool { return raw.kind == .closureCaptureItemList }
  public var asClosureCaptureItemList: ClosureCaptureItemListSyntax? {
    guard isClosureCaptureItemList else { return nil }
    return ClosureCaptureItemListSyntax(asSyntaxData)
  }

  public var isClosureCaptureSignature: Bool { return raw.kind == .closureCaptureSignature }
  public var asClosureCaptureSignature: ClosureCaptureSignatureSyntax? {
    guard isClosureCaptureSignature else { return nil }
    return ClosureCaptureSignatureSyntax(asSyntaxData)
  }

  public var isClosureParam: Bool { return raw.kind == .closureParam }
  public var asClosureParam: ClosureParamSyntax? {
    guard isClosureParam else { return nil }
    return ClosureParamSyntax(asSyntaxData)
  }

  public var isClosureParamList: Bool { return raw.kind == .closureParamList }
  public var asClosureParamList: ClosureParamListSyntax? {
    guard isClosureParamList else { return nil }
    return ClosureParamListSyntax(asSyntaxData)
  }

  public var isClosureSignature: Bool { return raw.kind == .closureSignature }
  public var asClosureSignature: ClosureSignatureSyntax? {
    guard isClosureSignature else { return nil }
    return ClosureSignatureSyntax(asSyntaxData)
  }

  public var isClosureExpr: Bool { return raw.kind == .closureExpr }
  public var asClosureExpr: ClosureExprSyntax? {
    guard isClosureExpr else { return nil }
    return ClosureExprSyntax(asSyntaxData)
  }

  public var isUnresolvedPatternExpr: Bool { return raw.kind == .unresolvedPatternExpr }
  public var asUnresolvedPatternExpr: UnresolvedPatternExprSyntax? {
    guard isUnresolvedPatternExpr else { return nil }
    return UnresolvedPatternExprSyntax(asSyntaxData)
  }

  public var isMultipleTrailingClosureElement: Bool { return raw.kind == .multipleTrailingClosureElement }
  public var asMultipleTrailingClosureElement: MultipleTrailingClosureElementSyntax? {
    guard isMultipleTrailingClosureElement else { return nil }
    return MultipleTrailingClosureElementSyntax(asSyntaxData)
  }

  public var isMultipleTrailingClosureElementList: Bool { return raw.kind == .multipleTrailingClosureElementList }
  public var asMultipleTrailingClosureElementList: MultipleTrailingClosureElementListSyntax? {
    guard isMultipleTrailingClosureElementList else { return nil }
    return MultipleTrailingClosureElementListSyntax(asSyntaxData)
  }

  public var isFunctionCallExpr: Bool { return raw.kind == .functionCallExpr }
  public var asFunctionCallExpr: FunctionCallExprSyntax? {
    guard isFunctionCallExpr else { return nil }
    return FunctionCallExprSyntax(asSyntaxData)
  }

  public var isSubscriptExpr: Bool { return raw.kind == .subscriptExpr }
  public var asSubscriptExpr: SubscriptExprSyntax? {
    guard isSubscriptExpr else { return nil }
    return SubscriptExprSyntax(asSyntaxData)
  }

  public var isOptionalChainingExpr: Bool { return raw.kind == .optionalChainingExpr }
  public var asOptionalChainingExpr: OptionalChainingExprSyntax? {
    guard isOptionalChainingExpr else { return nil }
    return OptionalChainingExprSyntax(asSyntaxData)
  }

  public var isForcedValueExpr: Bool { return raw.kind == .forcedValueExpr }
  public var asForcedValueExpr: ForcedValueExprSyntax? {
    guard isForcedValueExpr else { return nil }
    return ForcedValueExprSyntax(asSyntaxData)
  }

  public var isPostfixUnaryExpr: Bool { return raw.kind == .postfixUnaryExpr }
  public var asPostfixUnaryExpr: PostfixUnaryExprSyntax? {
    guard isPostfixUnaryExpr else { return nil }
    return PostfixUnaryExprSyntax(asSyntaxData)
  }

  public var isSpecializeExpr: Bool { return raw.kind == .specializeExpr }
  public var asSpecializeExpr: SpecializeExprSyntax? {
    guard isSpecializeExpr else { return nil }
    return SpecializeExprSyntax(asSyntaxData)
  }

  public var isStringSegment: Bool { return raw.kind == .stringSegment }
  public var asStringSegment: StringSegmentSyntax? {
    guard isStringSegment else { return nil }
    return StringSegmentSyntax(asSyntaxData)
  }

  public var isExpressionSegment: Bool { return raw.kind == .expressionSegment }
  public var asExpressionSegment: ExpressionSegmentSyntax? {
    guard isExpressionSegment else { return nil }
    return ExpressionSegmentSyntax(asSyntaxData)
  }

  public var isStringLiteralExpr: Bool { return raw.kind == .stringLiteralExpr }
  public var asStringLiteralExpr: StringLiteralExprSyntax? {
    guard isStringLiteralExpr else { return nil }
    return StringLiteralExprSyntax(asSyntaxData)
  }

  public var isRegexLiteralExpr: Bool { return raw.kind == .regexLiteralExpr }
  public var asRegexLiteralExpr: RegexLiteralExprSyntax? {
    guard isRegexLiteralExpr else { return nil }
    return RegexLiteralExprSyntax(asSyntaxData)
  }

  public var isKeyPathExpr: Bool { return raw.kind == .keyPathExpr }
  public var asKeyPathExpr: KeyPathExprSyntax? {
    guard isKeyPathExpr else { return nil }
    return KeyPathExprSyntax(asSyntaxData)
  }

  public var isKeyPathBaseExpr: Bool { return raw.kind == .keyPathBaseExpr }
  public var asKeyPathBaseExpr: KeyPathBaseExprSyntax? {
    guard isKeyPathBaseExpr else { return nil }
    return KeyPathBaseExprSyntax(asSyntaxData)
  }

  public var isObjcNamePiece: Bool { return raw.kind == .objcNamePiece }
  public var asObjcNamePiece: ObjcNamePieceSyntax? {
    guard isObjcNamePiece else { return nil }
    return ObjcNamePieceSyntax(asSyntaxData)
  }

  public var isObjcName: Bool { return raw.kind == .objcName }
  public var asObjcName: ObjcNameSyntax? {
    guard isObjcName else { return nil }
    return ObjcNameSyntax(asSyntaxData)
  }

  public var isObjcKeyPathExpr: Bool { return raw.kind == .objcKeyPathExpr }
  public var asObjcKeyPathExpr: ObjcKeyPathExprSyntax? {
    guard isObjcKeyPathExpr else { return nil }
    return ObjcKeyPathExprSyntax(asSyntaxData)
  }

  public var isObjcSelectorExpr: Bool { return raw.kind == .objcSelectorExpr }
  public var asObjcSelectorExpr: ObjcSelectorExprSyntax? {
    guard isObjcSelectorExpr else { return nil }
    return ObjcSelectorExprSyntax(asSyntaxData)
  }

  public var isPostfixIfConfigExpr: Bool { return raw.kind == .postfixIfConfigExpr }
  public var asPostfixIfConfigExpr: PostfixIfConfigExprSyntax? {
    guard isPostfixIfConfigExpr else { return nil }
    return PostfixIfConfigExprSyntax(asSyntaxData)
  }

  public var isEditorPlaceholderExpr: Bool { return raw.kind == .editorPlaceholderExpr }
  public var asEditorPlaceholderExpr: EditorPlaceholderExprSyntax? {
    guard isEditorPlaceholderExpr else { return nil }
    return EditorPlaceholderExprSyntax(asSyntaxData)
  }

  public var isObjectLiteralExpr: Bool { return raw.kind == .objectLiteralExpr }
  public var asObjectLiteralExpr: ObjectLiteralExprSyntax? {
    guard isObjectLiteralExpr else { return nil }
    return ObjectLiteralExprSyntax(asSyntaxData)
  }

  public var isTypeInitializerClause: Bool { return raw.kind == .typeInitializerClause }
  public var asTypeInitializerClause: TypeInitializerClauseSyntax? {
    guard isTypeInitializerClause else { return nil }
    return TypeInitializerClauseSyntax(asSyntaxData)
  }

  public var isTypealiasDecl: Bool { return raw.kind == .typealiasDecl }
  public var asTypealiasDecl: TypealiasDeclSyntax? {
    guard isTypealiasDecl else { return nil }
    return TypealiasDeclSyntax(asSyntaxData)
  }

  public var isAssociatedtypeDecl: Bool { return raw.kind == .associatedtypeDecl }
  public var asAssociatedtypeDecl: AssociatedtypeDeclSyntax? {
    guard isAssociatedtypeDecl else { return nil }
    return AssociatedtypeDeclSyntax(asSyntaxData)
  }

  public var isFunctionParameterList: Bool { return raw.kind == .functionParameterList }
  public var asFunctionParameterList: FunctionParameterListSyntax? {
    guard isFunctionParameterList else { return nil }
    return FunctionParameterListSyntax(asSyntaxData)
  }

  public var isParameterClause: Bool { return raw.kind == .parameterClause }
  public var asParameterClause: ParameterClauseSyntax? {
    guard isParameterClause else { return nil }
    return ParameterClauseSyntax(asSyntaxData)
  }

  public var isReturnClause: Bool { return raw.kind == .returnClause }
  public var asReturnClause: ReturnClauseSyntax? {
    guard isReturnClause else { return nil }
    return ReturnClauseSyntax(asSyntaxData)
  }

  public var isFunctionSignature: Bool { return raw.kind == .functionSignature }
  public var asFunctionSignature: FunctionSignatureSyntax? {
    guard isFunctionSignature else { return nil }
    return FunctionSignatureSyntax(asSyntaxData)
  }

  public var isIfConfigClause: Bool { return raw.kind == .ifConfigClause }
  public var asIfConfigClause: IfConfigClauseSyntax? {
    guard isIfConfigClause else { return nil }
    return IfConfigClauseSyntax(asSyntaxData)
  }

  public var isIfConfigClauseList: Bool { return raw.kind == .ifConfigClauseList }
  public var asIfConfigClauseList: IfConfigClauseListSyntax? {
    guard isIfConfigClauseList else { return nil }
    return IfConfigClauseListSyntax(asSyntaxData)
  }

  public var isIfConfigDecl: Bool { return raw.kind == .ifConfigDecl }
  public var asIfConfigDecl: IfConfigDeclSyntax? {
    guard isIfConfigDecl else { return nil }
    return IfConfigDeclSyntax(asSyntaxData)
  }

  public var isPoundErrorDecl: Bool { return raw.kind == .poundErrorDecl }
  public var asPoundErrorDecl: PoundErrorDeclSyntax? {
    guard isPoundErrorDecl else { return nil }
    return PoundErrorDeclSyntax(asSyntaxData)
  }

  public var isPoundWarningDecl: Bool { return raw.kind == .poundWarningDecl }
  public var asPoundWarningDecl: PoundWarningDeclSyntax? {
    guard isPoundWarningDecl else { return nil }
    return PoundWarningDeclSyntax(asSyntaxData)
  }

  public var isPoundSourceLocation: Bool { return raw.kind == .poundSourceLocation }
  public var asPoundSourceLocation: PoundSourceLocationSyntax? {
    guard isPoundSourceLocation else { return nil }
    return PoundSourceLocationSyntax(asSyntaxData)
  }

  public var isPoundSourceLocationArgs: Bool { return raw.kind == .poundSourceLocationArgs }
  public var asPoundSourceLocationArgs: PoundSourceLocationArgsSyntax? {
    guard isPoundSourceLocationArgs else { return nil }
    return PoundSourceLocationArgsSyntax(asSyntaxData)
  }

  public var isDeclModifier: Bool { return raw.kind == .declModifier }
  public var asDeclModifier: DeclModifierSyntax? {
    guard isDeclModifier else { return nil }
    return DeclModifierSyntax(asSyntaxData)
  }

  public var isInheritedType: Bool { return raw.kind == .inheritedType }
  public var asInheritedType: InheritedTypeSyntax? {
    guard isInheritedType else { return nil }
    return InheritedTypeSyntax(asSyntaxData)
  }

  public var isInheritedTypeList: Bool { return raw.kind == .inheritedTypeList }
  public var asInheritedTypeList: InheritedTypeListSyntax? {
    guard isInheritedTypeList else { return nil }
    return InheritedTypeListSyntax(asSyntaxData)
  }

  public var isTypeInheritanceClause: Bool { return raw.kind == .typeInheritanceClause }
  public var asTypeInheritanceClause: TypeInheritanceClauseSyntax? {
    guard isTypeInheritanceClause else { return nil }
    return TypeInheritanceClauseSyntax(asSyntaxData)
  }

  public var isClassDecl: Bool { return raw.kind == .classDecl }
  public var asClassDecl: ClassDeclSyntax? {
    guard isClassDecl else { return nil }
    return ClassDeclSyntax(asSyntaxData)
  }

  public var isStructDecl: Bool { return raw.kind == .structDecl }
  public var asStructDecl: StructDeclSyntax? {
    guard isStructDecl else { return nil }
    return StructDeclSyntax(asSyntaxData)
  }

  public var isProtocolDecl: Bool { return raw.kind == .protocolDecl }
  public var asProtocolDecl: ProtocolDeclSyntax? {
    guard isProtocolDecl else { return nil }
    return ProtocolDeclSyntax(asSyntaxData)
  }

  public var isExtensionDecl: Bool { return raw.kind == .extensionDecl }
  public var asExtensionDecl: ExtensionDeclSyntax? {
    guard isExtensionDecl else { return nil }
    return ExtensionDeclSyntax(asSyntaxData)
  }

  public var isMemberDeclBlock: Bool { return raw.kind == .memberDeclBlock }
  public var asMemberDeclBlock: MemberDeclBlockSyntax? {
    guard isMemberDeclBlock else { return nil }
    return MemberDeclBlockSyntax(asSyntaxData)
  }

  public var isMemberDeclList: Bool { return raw.kind == .memberDeclList }
  public var asMemberDeclList: MemberDeclListSyntax? {
    guard isMemberDeclList else { return nil }
    return MemberDeclListSyntax(asSyntaxData)
  }

  public var isMemberDeclListItem: Bool { return raw.kind == .memberDeclListItem }
  public var asMemberDeclListItem: MemberDeclListItemSyntax? {
    guard isMemberDeclListItem else { return nil }
    return MemberDeclListItemSyntax(asSyntaxData)
  }

  public var isSourceFile: Bool { return raw.kind == .sourceFile }
  public var asSourceFile: SourceFileSyntax? {
    guard isSourceFile else { return nil }
    return SourceFileSyntax(asSyntaxData)
  }

  public var isInitializerClause: Bool { return raw.kind == .initializerClause }
  public var asInitializerClause: InitializerClauseSyntax? {
    guard isInitializerClause else { return nil }
    return InitializerClauseSyntax(asSyntaxData)
  }

  public var isFunctionParameter: Bool { return raw.kind == .functionParameter }
  public var asFunctionParameter: FunctionParameterSyntax? {
    guard isFunctionParameter else { return nil }
    return FunctionParameterSyntax(asSyntaxData)
  }

  public var isModifierList: Bool { return raw.kind == .modifierList }
  public var asModifierList: ModifierListSyntax? {
    guard isModifierList else { return nil }
    return ModifierListSyntax(asSyntaxData)
  }

  public var isFunctionDecl: Bool { return raw.kind == .functionDecl }
  public var asFunctionDecl: FunctionDeclSyntax? {
    guard isFunctionDecl else { return nil }
    return FunctionDeclSyntax(asSyntaxData)
  }

  public var isInitializerDecl: Bool { return raw.kind == .initializerDecl }
  public var asInitializerDecl: InitializerDeclSyntax? {
    guard isInitializerDecl else { return nil }
    return InitializerDeclSyntax(asSyntaxData)
  }

  public var isDeinitializerDecl: Bool { return raw.kind == .deinitializerDecl }
  public var asDeinitializerDecl: DeinitializerDeclSyntax? {
    guard isDeinitializerDecl else { return nil }
    return DeinitializerDeclSyntax(asSyntaxData)
  }

  public var isSubscriptDecl: Bool { return raw.kind == .subscriptDecl }
  public var asSubscriptDecl: SubscriptDeclSyntax? {
    guard isSubscriptDecl else { return nil }
    return SubscriptDeclSyntax(asSyntaxData)
  }

  public var isAccessLevelModifier: Bool { return raw.kind == .accessLevelModifier }
  public var asAccessLevelModifier: AccessLevelModifierSyntax? {
    guard isAccessLevelModifier else { return nil }
    return AccessLevelModifierSyntax(asSyntaxData)
  }

  public var isAccessPathComponent: Bool { return raw.kind == .accessPathComponent }
  public var asAccessPathComponent: AccessPathComponentSyntax? {
    guard isAccessPathComponent else { return nil }
    return AccessPathComponentSyntax(asSyntaxData)
  }

  public var isAccessPath: Bool { return raw.kind == .accessPath }
  public var asAccessPath: AccessPathSyntax? {
    guard isAccessPath else { return nil }
    return AccessPathSyntax(asSyntaxData)
  }

  public var isImportDecl: Bool { return raw.kind == .importDecl }
  public var asImportDecl: ImportDeclSyntax? {
    guard isImportDecl else { return nil }
    return ImportDeclSyntax(asSyntaxData)
  }

  public var isAccessorParameter: Bool { return raw.kind == .accessorParameter }
  public var asAccessorParameter: AccessorParameterSyntax? {
    guard isAccessorParameter else { return nil }
    return AccessorParameterSyntax(asSyntaxData)
  }

  public var isAccessorDecl: Bool { return raw.kind == .accessorDecl }
  public var asAccessorDecl: AccessorDeclSyntax? {
    guard isAccessorDecl else { return nil }
    return AccessorDeclSyntax(asSyntaxData)
  }

  public var isAccessorList: Bool { return raw.kind == .accessorList }
  public var asAccessorList: AccessorListSyntax? {
    guard isAccessorList else { return nil }
    return AccessorListSyntax(asSyntaxData)
  }

  public var isAccessorBlock: Bool { return raw.kind == .accessorBlock }
  public var asAccessorBlock: AccessorBlockSyntax? {
    guard isAccessorBlock else { return nil }
    return AccessorBlockSyntax(asSyntaxData)
  }

  public var isPatternBinding: Bool { return raw.kind == .patternBinding }
  public var asPatternBinding: PatternBindingSyntax? {
    guard isPatternBinding else { return nil }
    return PatternBindingSyntax(asSyntaxData)
  }

  public var isPatternBindingList: Bool { return raw.kind == .patternBindingList }
  public var asPatternBindingList: PatternBindingListSyntax? {
    guard isPatternBindingList else { return nil }
    return PatternBindingListSyntax(asSyntaxData)
  }

  public var isVariableDecl: Bool { return raw.kind == .variableDecl }
  public var asVariableDecl: VariableDeclSyntax? {
    guard isVariableDecl else { return nil }
    return VariableDeclSyntax(asSyntaxData)
  }

  public var isEnumCaseElement: Bool { return raw.kind == .enumCaseElement }
  public var asEnumCaseElement: EnumCaseElementSyntax? {
    guard isEnumCaseElement else { return nil }
    return EnumCaseElementSyntax(asSyntaxData)
  }

  public var isEnumCaseElementList: Bool { return raw.kind == .enumCaseElementList }
  public var asEnumCaseElementList: EnumCaseElementListSyntax? {
    guard isEnumCaseElementList else { return nil }
    return EnumCaseElementListSyntax(asSyntaxData)
  }

  public var isEnumCaseDecl: Bool { return raw.kind == .enumCaseDecl }
  public var asEnumCaseDecl: EnumCaseDeclSyntax? {
    guard isEnumCaseDecl else { return nil }
    return EnumCaseDeclSyntax(asSyntaxData)
  }

  public var isEnumDecl: Bool { return raw.kind == .enumDecl }
  public var asEnumDecl: EnumDeclSyntax? {
    guard isEnumDecl else { return nil }
    return EnumDeclSyntax(asSyntaxData)
  }

  public var isOperatorDecl: Bool { return raw.kind == .operatorDecl }
  public var asOperatorDecl: OperatorDeclSyntax? {
    guard isOperatorDecl else { return nil }
    return OperatorDeclSyntax(asSyntaxData)
  }

  public var isIdentifierList: Bool { return raw.kind == .identifierList }
  public var asIdentifierList: IdentifierListSyntax? {
    guard isIdentifierList else { return nil }
    return IdentifierListSyntax(asSyntaxData)
  }

  public var isOperatorPrecedenceAndTypes: Bool { return raw.kind == .operatorPrecedenceAndTypes }
  public var asOperatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax? {
    guard isOperatorPrecedenceAndTypes else { return nil }
    return OperatorPrecedenceAndTypesSyntax(asSyntaxData)
  }

  public var isPrecedenceGroupDecl: Bool { return raw.kind == .precedenceGroupDecl }
  public var asPrecedenceGroupDecl: PrecedenceGroupDeclSyntax? {
    guard isPrecedenceGroupDecl else { return nil }
    return PrecedenceGroupDeclSyntax(asSyntaxData)
  }

  public var isPrecedenceGroupAttributeList: Bool { return raw.kind == .precedenceGroupAttributeList }
  public var asPrecedenceGroupAttributeList: PrecedenceGroupAttributeListSyntax? {
    guard isPrecedenceGroupAttributeList else { return nil }
    return PrecedenceGroupAttributeListSyntax(asSyntaxData)
  }

  public var isPrecedenceGroupRelation: Bool { return raw.kind == .precedenceGroupRelation }
  public var asPrecedenceGroupRelation: PrecedenceGroupRelationSyntax? {
    guard isPrecedenceGroupRelation else { return nil }
    return PrecedenceGroupRelationSyntax(asSyntaxData)
  }

  public var isPrecedenceGroupNameList: Bool { return raw.kind == .precedenceGroupNameList }
  public var asPrecedenceGroupNameList: PrecedenceGroupNameListSyntax? {
    guard isPrecedenceGroupNameList else { return nil }
    return PrecedenceGroupNameListSyntax(asSyntaxData)
  }

  public var isPrecedenceGroupNameElement: Bool { return raw.kind == .precedenceGroupNameElement }
  public var asPrecedenceGroupNameElement: PrecedenceGroupNameElementSyntax? {
    guard isPrecedenceGroupNameElement else { return nil }
    return PrecedenceGroupNameElementSyntax(asSyntaxData)
  }

  public var isPrecedenceGroupAssignment: Bool { return raw.kind == .precedenceGroupAssignment }
  public var asPrecedenceGroupAssignment: PrecedenceGroupAssignmentSyntax? {
    guard isPrecedenceGroupAssignment else { return nil }
    return PrecedenceGroupAssignmentSyntax(asSyntaxData)
  }

  public var isPrecedenceGroupAssociativity: Bool { return raw.kind == .precedenceGroupAssociativity }
  public var asPrecedenceGroupAssociativity: PrecedenceGroupAssociativitySyntax? {
    guard isPrecedenceGroupAssociativity else { return nil }
    return PrecedenceGroupAssociativitySyntax(asSyntaxData)
  }

  public var isTokenList: Bool { return raw.kind == .tokenList }
  public var asTokenList: TokenListSyntax? {
    guard isTokenList else { return nil }
    return TokenListSyntax(asSyntaxData)
  }

  public var isNonEmptyTokenList: Bool { return raw.kind == .nonEmptyTokenList }
  public var asNonEmptyTokenList: NonEmptyTokenListSyntax? {
    guard isNonEmptyTokenList else { return nil }
    return NonEmptyTokenListSyntax(asSyntaxData)
  }

  public var isCustomAttribute: Bool { return raw.kind == .customAttribute }
  public var asCustomAttribute: CustomAttributeSyntax? {
    guard isCustomAttribute else { return nil }
    return CustomAttributeSyntax(asSyntaxData)
  }

  public var isAttribute: Bool { return raw.kind == .attribute }
  public var asAttribute: AttributeSyntax? {
    guard isAttribute else { return nil }
    return AttributeSyntax(asSyntaxData)
  }

  public var isAttributeList: Bool { return raw.kind == .attributeList }
  public var asAttributeList: AttributeListSyntax? {
    guard isAttributeList else { return nil }
    return AttributeListSyntax(asSyntaxData)
  }

  public var isSpecializeAttributeSpecList: Bool { return raw.kind == .specializeAttributeSpecList }
  public var asSpecializeAttributeSpecList: SpecializeAttributeSpecListSyntax? {
    guard isSpecializeAttributeSpecList else { return nil }
    return SpecializeAttributeSpecListSyntax(asSyntaxData)
  }

  public var isAvailabilityEntry: Bool { return raw.kind == .availabilityEntry }
  public var asAvailabilityEntry: AvailabilityEntrySyntax? {
    guard isAvailabilityEntry else { return nil }
    return AvailabilityEntrySyntax(asSyntaxData)
  }

  public var isLabeledSpecializeEntry: Bool { return raw.kind == .labeledSpecializeEntry }
  public var asLabeledSpecializeEntry: LabeledSpecializeEntrySyntax? {
    guard isLabeledSpecializeEntry else { return nil }
    return LabeledSpecializeEntrySyntax(asSyntaxData)
  }

  public var isTargetFunctionEntry: Bool { return raw.kind == .targetFunctionEntry }
  public var asTargetFunctionEntry: TargetFunctionEntrySyntax? {
    guard isTargetFunctionEntry else { return nil }
    return TargetFunctionEntrySyntax(asSyntaxData)
  }

  public var isNamedAttributeStringArgument: Bool { return raw.kind == .namedAttributeStringArgument }
  public var asNamedAttributeStringArgument: NamedAttributeStringArgumentSyntax? {
    guard isNamedAttributeStringArgument else { return nil }
    return NamedAttributeStringArgumentSyntax(asSyntaxData)
  }

  public var isDeclName: Bool { return raw.kind == .declName }
  public var asDeclName: DeclNameSyntax? {
    guard isDeclName else { return nil }
    return DeclNameSyntax(asSyntaxData)
  }

  public var isImplementsAttributeArguments: Bool { return raw.kind == .implementsAttributeArguments }
  public var asImplementsAttributeArguments: ImplementsAttributeArgumentsSyntax? {
    guard isImplementsAttributeArguments else { return nil }
    return ImplementsAttributeArgumentsSyntax(asSyntaxData)
  }

  public var isObjCSelectorPiece: Bool { return raw.kind == .objCSelectorPiece }
  public var asObjCSelectorPiece: ObjCSelectorPieceSyntax? {
    guard isObjCSelectorPiece else { return nil }
    return ObjCSelectorPieceSyntax(asSyntaxData)
  }

  public var isObjCSelector: Bool { return raw.kind == .objCSelector }
  public var asObjCSelector: ObjCSelectorSyntax? {
    guard isObjCSelector else { return nil }
    return ObjCSelectorSyntax(asSyntaxData)
  }

  public var isDifferentiableAttributeArguments: Bool { return raw.kind == .differentiableAttributeArguments }
  public var asDifferentiableAttributeArguments: DifferentiableAttributeArgumentsSyntax? {
    guard isDifferentiableAttributeArguments else { return nil }
    return DifferentiableAttributeArgumentsSyntax(asSyntaxData)
  }

  public var isDifferentiabilityParamsClause: Bool { return raw.kind == .differentiabilityParamsClause }
  public var asDifferentiabilityParamsClause: DifferentiabilityParamsClauseSyntax? {
    guard isDifferentiabilityParamsClause else { return nil }
    return DifferentiabilityParamsClauseSyntax(asSyntaxData)
  }

  public var isDifferentiabilityParams: Bool { return raw.kind == .differentiabilityParams }
  public var asDifferentiabilityParams: DifferentiabilityParamsSyntax? {
    guard isDifferentiabilityParams else { return nil }
    return DifferentiabilityParamsSyntax(asSyntaxData)
  }

  public var isDifferentiabilityParamList: Bool { return raw.kind == .differentiabilityParamList }
  public var asDifferentiabilityParamList: DifferentiabilityParamListSyntax? {
    guard isDifferentiabilityParamList else { return nil }
    return DifferentiabilityParamListSyntax(asSyntaxData)
  }

  public var isDifferentiabilityParam: Bool { return raw.kind == .differentiabilityParam }
  public var asDifferentiabilityParam: DifferentiabilityParamSyntax? {
    guard isDifferentiabilityParam else { return nil }
    return DifferentiabilityParamSyntax(asSyntaxData)
  }

  public var isDerivativeRegistrationAttributeArguments: Bool { return raw.kind == .derivativeRegistrationAttributeArguments }
  public var asDerivativeRegistrationAttributeArguments: DerivativeRegistrationAttributeArgumentsSyntax? {
    guard isDerivativeRegistrationAttributeArguments else { return nil }
    return DerivativeRegistrationAttributeArgumentsSyntax(asSyntaxData)
  }

  public var isQualifiedDeclName: Bool { return raw.kind == .qualifiedDeclName }
  public var asQualifiedDeclName: QualifiedDeclNameSyntax? {
    guard isQualifiedDeclName else { return nil }
    return QualifiedDeclNameSyntax(asSyntaxData)
  }

  public var isFunctionDeclName: Bool { return raw.kind == .functionDeclName }
  public var asFunctionDeclName: FunctionDeclNameSyntax? {
    guard isFunctionDeclName else { return nil }
    return FunctionDeclNameSyntax(asSyntaxData)
  }

  public var isBackDeployAttributeSpecList: Bool { return raw.kind == .backDeployAttributeSpecList }
  public var asBackDeployAttributeSpecList: BackDeployAttributeSpecListSyntax? {
    guard isBackDeployAttributeSpecList else { return nil }
    return BackDeployAttributeSpecListSyntax(asSyntaxData)
  }

  public var isBackDeployVersionList: Bool { return raw.kind == .backDeployVersionList }
  public var asBackDeployVersionList: BackDeployVersionListSyntax? {
    guard isBackDeployVersionList else { return nil }
    return BackDeployVersionListSyntax(asSyntaxData)
  }

  public var isBackDeployVersionArgument: Bool { return raw.kind == .backDeployVersionArgument }
  public var asBackDeployVersionArgument: BackDeployVersionArgumentSyntax? {
    guard isBackDeployVersionArgument else { return nil }
    return BackDeployVersionArgumentSyntax(asSyntaxData)
  }

  public var isContinueStmt: Bool { return raw.kind == .continueStmt }
  public var asContinueStmt: ContinueStmtSyntax? {
    guard isContinueStmt else { return nil }
    return ContinueStmtSyntax(asSyntaxData)
  }

  public var isWhileStmt: Bool { return raw.kind == .whileStmt }
  public var asWhileStmt: WhileStmtSyntax? {
    guard isWhileStmt else { return nil }
    return WhileStmtSyntax(asSyntaxData)
  }

  public var isDeferStmt: Bool { return raw.kind == .deferStmt }
  public var asDeferStmt: DeferStmtSyntax? {
    guard isDeferStmt else { return nil }
    return DeferStmtSyntax(asSyntaxData)
  }

  public var isExpressionStmt: Bool { return raw.kind == .expressionStmt }
  public var asExpressionStmt: ExpressionStmtSyntax? {
    guard isExpressionStmt else { return nil }
    return ExpressionStmtSyntax(asSyntaxData)
  }

  public var isSwitchCaseList: Bool { return raw.kind == .switchCaseList }
  public var asSwitchCaseList: SwitchCaseListSyntax? {
    guard isSwitchCaseList else { return nil }
    return SwitchCaseListSyntax(asSyntaxData)
  }

  public var isRepeatWhileStmt: Bool { return raw.kind == .repeatWhileStmt }
  public var asRepeatWhileStmt: RepeatWhileStmtSyntax? {
    guard isRepeatWhileStmt else { return nil }
    return RepeatWhileStmtSyntax(asSyntaxData)
  }

  public var isGuardStmt: Bool { return raw.kind == .guardStmt }
  public var asGuardStmt: GuardStmtSyntax? {
    guard isGuardStmt else { return nil }
    return GuardStmtSyntax(asSyntaxData)
  }

  public var isWhereClause: Bool { return raw.kind == .whereClause }
  public var asWhereClause: WhereClauseSyntax? {
    guard isWhereClause else { return nil }
    return WhereClauseSyntax(asSyntaxData)
  }

  public var isForInStmt: Bool { return raw.kind == .forInStmt }
  public var asForInStmt: ForInStmtSyntax? {
    guard isForInStmt else { return nil }
    return ForInStmtSyntax(asSyntaxData)
  }

  public var isSwitchStmt: Bool { return raw.kind == .switchStmt }
  public var asSwitchStmt: SwitchStmtSyntax? {
    guard isSwitchStmt else { return nil }
    return SwitchStmtSyntax(asSyntaxData)
  }

  public var isCatchClauseList: Bool { return raw.kind == .catchClauseList }
  public var asCatchClauseList: CatchClauseListSyntax? {
    guard isCatchClauseList else { return nil }
    return CatchClauseListSyntax(asSyntaxData)
  }

  public var isDoStmt: Bool { return raw.kind == .doStmt }
  public var asDoStmt: DoStmtSyntax? {
    guard isDoStmt else { return nil }
    return DoStmtSyntax(asSyntaxData)
  }

  public var isReturnStmt: Bool { return raw.kind == .returnStmt }
  public var asReturnStmt: ReturnStmtSyntax? {
    guard isReturnStmt else { return nil }
    return ReturnStmtSyntax(asSyntaxData)
  }

  public var isYieldStmt: Bool { return raw.kind == .yieldStmt }
  public var asYieldStmt: YieldStmtSyntax? {
    guard isYieldStmt else { return nil }
    return YieldStmtSyntax(asSyntaxData)
  }

  public var isYieldList: Bool { return raw.kind == .yieldList }
  public var asYieldList: YieldListSyntax? {
    guard isYieldList else { return nil }
    return YieldListSyntax(asSyntaxData)
  }

  public var isFallthroughStmt: Bool { return raw.kind == .fallthroughStmt }
  public var asFallthroughStmt: FallthroughStmtSyntax? {
    guard isFallthroughStmt else { return nil }
    return FallthroughStmtSyntax(asSyntaxData)
  }

  public var isBreakStmt: Bool { return raw.kind == .breakStmt }
  public var asBreakStmt: BreakStmtSyntax? {
    guard isBreakStmt else { return nil }
    return BreakStmtSyntax(asSyntaxData)
  }

  public var isCaseItemList: Bool { return raw.kind == .caseItemList }
  public var asCaseItemList: CaseItemListSyntax? {
    guard isCaseItemList else { return nil }
    return CaseItemListSyntax(asSyntaxData)
  }

  public var isCatchItemList: Bool { return raw.kind == .catchItemList }
  public var asCatchItemList: CatchItemListSyntax? {
    guard isCatchItemList else { return nil }
    return CatchItemListSyntax(asSyntaxData)
  }

  public var isConditionElement: Bool { return raw.kind == .conditionElement }
  public var asConditionElement: ConditionElementSyntax? {
    guard isConditionElement else { return nil }
    return ConditionElementSyntax(asSyntaxData)
  }

  public var isAvailabilityCondition: Bool { return raw.kind == .availabilityCondition }
  public var asAvailabilityCondition: AvailabilityConditionSyntax? {
    guard isAvailabilityCondition else { return nil }
    return AvailabilityConditionSyntax(asSyntaxData)
  }

  public var isMatchingPatternCondition: Bool { return raw.kind == .matchingPatternCondition }
  public var asMatchingPatternCondition: MatchingPatternConditionSyntax? {
    guard isMatchingPatternCondition else { return nil }
    return MatchingPatternConditionSyntax(asSyntaxData)
  }

  public var isOptionalBindingCondition: Bool { return raw.kind == .optionalBindingCondition }
  public var asOptionalBindingCondition: OptionalBindingConditionSyntax? {
    guard isOptionalBindingCondition else { return nil }
    return OptionalBindingConditionSyntax(asSyntaxData)
  }

  public var isUnavailabilityCondition: Bool { return raw.kind == .unavailabilityCondition }
  public var asUnavailabilityCondition: UnavailabilityConditionSyntax? {
    guard isUnavailabilityCondition else { return nil }
    return UnavailabilityConditionSyntax(asSyntaxData)
  }

  public var isConditionElementList: Bool { return raw.kind == .conditionElementList }
  public var asConditionElementList: ConditionElementListSyntax? {
    guard isConditionElementList else { return nil }
    return ConditionElementListSyntax(asSyntaxData)
  }

  public var isDeclarationStmt: Bool { return raw.kind == .declarationStmt }
  public var asDeclarationStmt: DeclarationStmtSyntax? {
    guard isDeclarationStmt else { return nil }
    return DeclarationStmtSyntax(asSyntaxData)
  }

  public var isThrowStmt: Bool { return raw.kind == .throwStmt }
  public var asThrowStmt: ThrowStmtSyntax? {
    guard isThrowStmt else { return nil }
    return ThrowStmtSyntax(asSyntaxData)
  }

  public var isIfStmt: Bool { return raw.kind == .ifStmt }
  public var asIfStmt: IfStmtSyntax? {
    guard isIfStmt else { return nil }
    return IfStmtSyntax(asSyntaxData)
  }

  public var isElseIfContinuation: Bool { return raw.kind == .elseIfContinuation }
  public var asElseIfContinuation: ElseIfContinuationSyntax? {
    guard isElseIfContinuation else { return nil }
    return ElseIfContinuationSyntax(asSyntaxData)
  }

  public var isElseBlock: Bool { return raw.kind == .elseBlock }
  public var asElseBlock: ElseBlockSyntax? {
    guard isElseBlock else { return nil }
    return ElseBlockSyntax(asSyntaxData)
  }

  public var isSwitchCase: Bool { return raw.kind == .switchCase }
  public var asSwitchCase: SwitchCaseSyntax? {
    guard isSwitchCase else { return nil }
    return SwitchCaseSyntax(asSyntaxData)
  }

  public var isSwitchDefaultLabel: Bool { return raw.kind == .switchDefaultLabel }
  public var asSwitchDefaultLabel: SwitchDefaultLabelSyntax? {
    guard isSwitchDefaultLabel else { return nil }
    return SwitchDefaultLabelSyntax(asSyntaxData)
  }

  public var isCaseItem: Bool { return raw.kind == .caseItem }
  public var asCaseItem: CaseItemSyntax? {
    guard isCaseItem else { return nil }
    return CaseItemSyntax(asSyntaxData)
  }

  public var isCatchItem: Bool { return raw.kind == .catchItem }
  public var asCatchItem: CatchItemSyntax? {
    guard isCatchItem else { return nil }
    return CatchItemSyntax(asSyntaxData)
  }

  public var isSwitchCaseLabel: Bool { return raw.kind == .switchCaseLabel }
  public var asSwitchCaseLabel: SwitchCaseLabelSyntax? {
    guard isSwitchCaseLabel else { return nil }
    return SwitchCaseLabelSyntax(asSyntaxData)
  }

  public var isCatchClause: Bool { return raw.kind == .catchClause }
  public var asCatchClause: CatchClauseSyntax? {
    guard isCatchClause else { return nil }
    return CatchClauseSyntax(asSyntaxData)
  }

  public var isPoundAssertStmt: Bool { return raw.kind == .poundAssertStmt }
  public var asPoundAssertStmt: PoundAssertStmtSyntax? {
    guard isPoundAssertStmt else { return nil }
    return PoundAssertStmtSyntax(asSyntaxData)
  }

  public var isGenericWhereClause: Bool { return raw.kind == .genericWhereClause }
  public var asGenericWhereClause: GenericWhereClauseSyntax? {
    guard isGenericWhereClause else { return nil }
    return GenericWhereClauseSyntax(asSyntaxData)
  }

  public var isGenericRequirementList: Bool { return raw.kind == .genericRequirementList }
  public var asGenericRequirementList: GenericRequirementListSyntax? {
    guard isGenericRequirementList else { return nil }
    return GenericRequirementListSyntax(asSyntaxData)
  }

  public var isGenericRequirement: Bool { return raw.kind == .genericRequirement }
  public var asGenericRequirement: GenericRequirementSyntax? {
    guard isGenericRequirement else { return nil }
    return GenericRequirementSyntax(asSyntaxData)
  }

  public var isSameTypeRequirement: Bool { return raw.kind == .sameTypeRequirement }
  public var asSameTypeRequirement: SameTypeRequirementSyntax? {
    guard isSameTypeRequirement else { return nil }
    return SameTypeRequirementSyntax(asSyntaxData)
  }

  public var isGenericParameterList: Bool { return raw.kind == .genericParameterList }
  public var asGenericParameterList: GenericParameterListSyntax? {
    guard isGenericParameterList else { return nil }
    return GenericParameterListSyntax(asSyntaxData)
  }

  public var isGenericParameter: Bool { return raw.kind == .genericParameter }
  public var asGenericParameter: GenericParameterSyntax? {
    guard isGenericParameter else { return nil }
    return GenericParameterSyntax(asSyntaxData)
  }

  public var isPrimaryAssociatedTypeList: Bool { return raw.kind == .primaryAssociatedTypeList }
  public var asPrimaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax? {
    guard isPrimaryAssociatedTypeList else { return nil }
    return PrimaryAssociatedTypeListSyntax(asSyntaxData)
  }

  public var isPrimaryAssociatedType: Bool { return raw.kind == .primaryAssociatedType }
  public var asPrimaryAssociatedType: PrimaryAssociatedTypeSyntax? {
    guard isPrimaryAssociatedType else { return nil }
    return PrimaryAssociatedTypeSyntax(asSyntaxData)
  }

  public var isGenericParameterClause: Bool { return raw.kind == .genericParameterClause }
  public var asGenericParameterClause: GenericParameterClauseSyntax? {
    guard isGenericParameterClause else { return nil }
    return GenericParameterClauseSyntax(asSyntaxData)
  }

  public var isConformanceRequirement: Bool { return raw.kind == .conformanceRequirement }
  public var asConformanceRequirement: ConformanceRequirementSyntax? {
    guard isConformanceRequirement else { return nil }
    return ConformanceRequirementSyntax(asSyntaxData)
  }

  public var isPrimaryAssociatedTypeClause: Bool { return raw.kind == .primaryAssociatedTypeClause }
  public var asPrimaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax? {
    guard isPrimaryAssociatedTypeClause else { return nil }
    return PrimaryAssociatedTypeClauseSyntax(asSyntaxData)
  }

  public var isSimpleTypeIdentifier: Bool { return raw.kind == .simpleTypeIdentifier }
  public var asSimpleTypeIdentifier: SimpleTypeIdentifierSyntax? {
    guard isSimpleTypeIdentifier else { return nil }
    return SimpleTypeIdentifierSyntax(asSyntaxData)
  }

  public var isMemberTypeIdentifier: Bool { return raw.kind == .memberTypeIdentifier }
  public var asMemberTypeIdentifier: MemberTypeIdentifierSyntax? {
    guard isMemberTypeIdentifier else { return nil }
    return MemberTypeIdentifierSyntax(asSyntaxData)
  }

  public var isClassRestrictionType: Bool { return raw.kind == .classRestrictionType }
  public var asClassRestrictionType: ClassRestrictionTypeSyntax? {
    guard isClassRestrictionType else { return nil }
    return ClassRestrictionTypeSyntax(asSyntaxData)
  }

  public var isArrayType: Bool { return raw.kind == .arrayType }
  public var asArrayType: ArrayTypeSyntax? {
    guard isArrayType else { return nil }
    return ArrayTypeSyntax(asSyntaxData)
  }

  public var isDictionaryType: Bool { return raw.kind == .dictionaryType }
  public var asDictionaryType: DictionaryTypeSyntax? {
    guard isDictionaryType else { return nil }
    return DictionaryTypeSyntax(asSyntaxData)
  }

  public var isMetatypeType: Bool { return raw.kind == .metatypeType }
  public var asMetatypeType: MetatypeTypeSyntax? {
    guard isMetatypeType else { return nil }
    return MetatypeTypeSyntax(asSyntaxData)
  }

  public var isOptionalType: Bool { return raw.kind == .optionalType }
  public var asOptionalType: OptionalTypeSyntax? {
    guard isOptionalType else { return nil }
    return OptionalTypeSyntax(asSyntaxData)
  }

  public var isConstrainedSugarType: Bool { return raw.kind == .constrainedSugarType }
  public var asConstrainedSugarType: ConstrainedSugarTypeSyntax? {
    guard isConstrainedSugarType else { return nil }
    return ConstrainedSugarTypeSyntax(asSyntaxData)
  }

  public var isImplicitlyUnwrappedOptionalType: Bool { return raw.kind == .implicitlyUnwrappedOptionalType }
  public var asImplicitlyUnwrappedOptionalType: ImplicitlyUnwrappedOptionalTypeSyntax? {
    guard isImplicitlyUnwrappedOptionalType else { return nil }
    return ImplicitlyUnwrappedOptionalTypeSyntax(asSyntaxData)
  }

  public var isCompositionTypeElement: Bool { return raw.kind == .compositionTypeElement }
  public var asCompositionTypeElement: CompositionTypeElementSyntax? {
    guard isCompositionTypeElement else { return nil }
    return CompositionTypeElementSyntax(asSyntaxData)
  }

  public var isCompositionTypeElementList: Bool { return raw.kind == .compositionTypeElementList }
  public var asCompositionTypeElementList: CompositionTypeElementListSyntax? {
    guard isCompositionTypeElementList else { return nil }
    return CompositionTypeElementListSyntax(asSyntaxData)
  }

  public var isCompositionType: Bool { return raw.kind == .compositionType }
  public var asCompositionType: CompositionTypeSyntax? {
    guard isCompositionType else { return nil }
    return CompositionTypeSyntax(asSyntaxData)
  }

  public var isTupleTypeElement: Bool { return raw.kind == .tupleTypeElement }
  public var asTupleTypeElement: TupleTypeElementSyntax? {
    guard isTupleTypeElement else { return nil }
    return TupleTypeElementSyntax(asSyntaxData)
  }

  public var isTupleTypeElementList: Bool { return raw.kind == .tupleTypeElementList }
  public var asTupleTypeElementList: TupleTypeElementListSyntax? {
    guard isTupleTypeElementList else { return nil }
    return TupleTypeElementListSyntax(asSyntaxData)
  }

  public var isTupleType: Bool { return raw.kind == .tupleType }
  public var asTupleType: TupleTypeSyntax? {
    guard isTupleType else { return nil }
    return TupleTypeSyntax(asSyntaxData)
  }

  public var isFunctionType: Bool { return raw.kind == .functionType }
  public var asFunctionType: FunctionTypeSyntax? {
    guard isFunctionType else { return nil }
    return FunctionTypeSyntax(asSyntaxData)
  }

  public var isAttributedType: Bool { return raw.kind == .attributedType }
  public var asAttributedType: AttributedTypeSyntax? {
    guard isAttributedType else { return nil }
    return AttributedTypeSyntax(asSyntaxData)
  }

  public var isGenericArgumentList: Bool { return raw.kind == .genericArgumentList }
  public var asGenericArgumentList: GenericArgumentListSyntax? {
    guard isGenericArgumentList else { return nil }
    return GenericArgumentListSyntax(asSyntaxData)
  }

  public var isGenericArgument: Bool { return raw.kind == .genericArgument }
  public var asGenericArgument: GenericArgumentSyntax? {
    guard isGenericArgument else { return nil }
    return GenericArgumentSyntax(asSyntaxData)
  }

  public var isGenericArgumentClause: Bool { return raw.kind == .genericArgumentClause }
  public var asGenericArgumentClause: GenericArgumentClauseSyntax? {
    guard isGenericArgumentClause else { return nil }
    return GenericArgumentClauseSyntax(asSyntaxData)
  }

  public var isTypeAnnotation: Bool { return raw.kind == .typeAnnotation }
  public var asTypeAnnotation: TypeAnnotationSyntax? {
    guard isTypeAnnotation else { return nil }
    return TypeAnnotationSyntax(asSyntaxData)
  }

  public var isEnumCasePattern: Bool { return raw.kind == .enumCasePattern }
  public var asEnumCasePattern: EnumCasePatternSyntax? {
    guard isEnumCasePattern else { return nil }
    return EnumCasePatternSyntax(asSyntaxData)
  }

  public var isIsTypePattern: Bool { return raw.kind == .isTypePattern }
  public var asIsTypePattern: IsTypePatternSyntax? {
    guard isIsTypePattern else { return nil }
    return IsTypePatternSyntax(asSyntaxData)
  }

  public var isOptionalPattern: Bool { return raw.kind == .optionalPattern }
  public var asOptionalPattern: OptionalPatternSyntax? {
    guard isOptionalPattern else { return nil }
    return OptionalPatternSyntax(asSyntaxData)
  }

  public var isIdentifierPattern: Bool { return raw.kind == .identifierPattern }
  public var asIdentifierPattern: IdentifierPatternSyntax? {
    guard isIdentifierPattern else { return nil }
    return IdentifierPatternSyntax(asSyntaxData)
  }

  public var isAsTypePattern: Bool { return raw.kind == .asTypePattern }
  public var asAsTypePattern: AsTypePatternSyntax? {
    guard isAsTypePattern else { return nil }
    return AsTypePatternSyntax(asSyntaxData)
  }

  public var isTuplePattern: Bool { return raw.kind == .tuplePattern }
  public var asTuplePattern: TuplePatternSyntax? {
    guard isTuplePattern else { return nil }
    return TuplePatternSyntax(asSyntaxData)
  }

  public var isWildcardPattern: Bool { return raw.kind == .wildcardPattern }
  public var asWildcardPattern: WildcardPatternSyntax? {
    guard isWildcardPattern else { return nil }
    return WildcardPatternSyntax(asSyntaxData)
  }

  public var isTuplePatternElement: Bool { return raw.kind == .tuplePatternElement }
  public var asTuplePatternElement: TuplePatternElementSyntax? {
    guard isTuplePatternElement else { return nil }
    return TuplePatternElementSyntax(asSyntaxData)
  }

  public var isExpressionPattern: Bool { return raw.kind == .expressionPattern }
  public var asExpressionPattern: ExpressionPatternSyntax? {
    guard isExpressionPattern else { return nil }
    return ExpressionPatternSyntax(asSyntaxData)
  }

  public var isTuplePatternElementList: Bool { return raw.kind == .tuplePatternElementList }
  public var asTuplePatternElementList: TuplePatternElementListSyntax? {
    guard isTuplePatternElementList else { return nil }
    return TuplePatternElementListSyntax(asSyntaxData)
  }

  public var isValueBindingPattern: Bool { return raw.kind == .valueBindingPattern }
  public var asValueBindingPattern: ValueBindingPatternSyntax? {
    guard isValueBindingPattern else { return nil }
    return ValueBindingPatternSyntax(asSyntaxData)
  }

  public var isAvailabilitySpecList: Bool { return raw.kind == .availabilitySpecList }
  public var asAvailabilitySpecList: AvailabilitySpecListSyntax? {
    guard isAvailabilitySpecList else { return nil }
    return AvailabilitySpecListSyntax(asSyntaxData)
  }

  public var isAvailabilityArgument: Bool { return raw.kind == .availabilityArgument }
  public var asAvailabilityArgument: AvailabilityArgumentSyntax? {
    guard isAvailabilityArgument else { return nil }
    return AvailabilityArgumentSyntax(asSyntaxData)
  }

  public var isAvailabilityLabeledArgument: Bool { return raw.kind == .availabilityLabeledArgument }
  public var asAvailabilityLabeledArgument: AvailabilityLabeledArgumentSyntax? {
    guard isAvailabilityLabeledArgument else { return nil }
    return AvailabilityLabeledArgumentSyntax(asSyntaxData)
  }

  public var isAvailabilityVersionRestriction: Bool { return raw.kind == .availabilityVersionRestriction }
  public var asAvailabilityVersionRestriction: AvailabilityVersionRestrictionSyntax? {
    guard isAvailabilityVersionRestriction else { return nil }
    return AvailabilityVersionRestrictionSyntax(asSyntaxData)
  }

  public var isVersionTuple: Bool { return raw.kind == .versionTuple }
  public var asVersionTuple: VersionTupleSyntax? {
    guard isVersionTuple else { return nil }
    return VersionTupleSyntax(asSyntaxData)
  }
}

extension Syntax {
  /// Syntax nodes always conform to SyntaxProtocol. This API is just added
  /// for consistency.
  /// Note that this will incur an existential conversion.
  @available(*, deprecated, message: "Expression always evaluates to true")
  public func isProtocol(_: SyntaxProtocol.Protocol) -> Bool {
    return true
  }

  /// Return the non-type erased version of this syntax node.
  /// Note that this will incur an existential conversion.
  public func asProtocol(_: SyntaxProtocol.Protocol) -> SyntaxProtocol {
    switch self.as(SyntaxEnum.self) {
    case .token(let node):
      return node
    case .unknown(let node):
      return node
    case .decl(let node):
      return node
    case .expr(let node):
      return node
    case .stmt(let node):
      return node
    case .type(let node):
      return node
    case .pattern(let node):
      return node
    case .unknownDecl(let node):
      return node
    case .unknownExpr(let node):
      return node
    case .unknownStmt(let node):
      return node
    case .unknownType(let node):
      return node
    case .unknownPattern(let node):
      return node
    case .codeBlockItem(let node):
      return node
    case .codeBlockItemList(let node):
      return node
    case .codeBlock(let node):
      return node
    case .inOutExpr(let node):
      return node
    case .poundColumnExpr(let node):
      return node
    case .tupleExprElementList(let node):
      return node
    case .arrayElementList(let node):
      return node
    case .dictionaryElementList(let node):
      return node
    case .stringLiteralSegments(let node):
      return node
    case .tryExpr(let node):
      return node
    case .awaitExpr(let node):
      return node
    case .declNameArgument(let node):
      return node
    case .declNameArgumentList(let node):
      return node
    case .declNameArguments(let node):
      return node
    case .identifierExpr(let node):
      return node
    case .superRefExpr(let node):
      return node
    case .nilLiteralExpr(let node):
      return node
    case .discardAssignmentExpr(let node):
      return node
    case .assignmentExpr(let node):
      return node
    case .sequenceExpr(let node):
      return node
    case .exprList(let node):
      return node
    case .poundLineExpr(let node):
      return node
    case .poundFileExpr(let node):
      return node
    case .poundFileIDExpr(let node):
      return node
    case .poundFilePathExpr(let node):
      return node
    case .poundFunctionExpr(let node):
      return node
    case .poundDsohandleExpr(let node):
      return node
    case .symbolicReferenceExpr(let node):
      return node
    case .prefixOperatorExpr(let node):
      return node
    case .binaryOperatorExpr(let node):
      return node
    case .arrowExpr(let node):
      return node
    case .floatLiteralExpr(let node):
      return node
    case .tupleExpr(let node):
      return node
    case .arrayExpr(let node):
      return node
    case .dictionaryExpr(let node):
      return node
    case .tupleExprElement(let node):
      return node
    case .arrayElement(let node):
      return node
    case .dictionaryElement(let node):
      return node
    case .integerLiteralExpr(let node):
      return node
    case .booleanLiteralExpr(let node):
      return node
    case .ternaryExpr(let node):
      return node
    case .memberAccessExpr(let node):
      return node
    case .isExpr(let node):
      return node
    case .asExpr(let node):
      return node
    case .typeExpr(let node):
      return node
    case .closureCaptureItem(let node):
      return node
    case .closureCaptureItemList(let node):
      return node
    case .closureCaptureSignature(let node):
      return node
    case .closureParam(let node):
      return node
    case .closureParamList(let node):
      return node
    case .closureSignature(let node):
      return node
    case .closureExpr(let node):
      return node
    case .unresolvedPatternExpr(let node):
      return node
    case .multipleTrailingClosureElement(let node):
      return node
    case .multipleTrailingClosureElementList(let node):
      return node
    case .functionCallExpr(let node):
      return node
    case .subscriptExpr(let node):
      return node
    case .optionalChainingExpr(let node):
      return node
    case .forcedValueExpr(let node):
      return node
    case .postfixUnaryExpr(let node):
      return node
    case .specializeExpr(let node):
      return node
    case .stringSegment(let node):
      return node
    case .expressionSegment(let node):
      return node
    case .stringLiteralExpr(let node):
      return node
    case .regexLiteralExpr(let node):
      return node
    case .keyPathExpr(let node):
      return node
    case .keyPathBaseExpr(let node):
      return node
    case .objcNamePiece(let node):
      return node
    case .objcName(let node):
      return node
    case .objcKeyPathExpr(let node):
      return node
    case .objcSelectorExpr(let node):
      return node
    case .postfixIfConfigExpr(let node):
      return node
    case .editorPlaceholderExpr(let node):
      return node
    case .objectLiteralExpr(let node):
      return node
    case .typeInitializerClause(let node):
      return node
    case .typealiasDecl(let node):
      return node
    case .associatedtypeDecl(let node):
      return node
    case .functionParameterList(let node):
      return node
    case .parameterClause(let node):
      return node
    case .returnClause(let node):
      return node
    case .functionSignature(let node):
      return node
    case .ifConfigClause(let node):
      return node
    case .ifConfigClauseList(let node):
      return node
    case .ifConfigDecl(let node):
      return node
    case .poundErrorDecl(let node):
      return node
    case .poundWarningDecl(let node):
      return node
    case .poundSourceLocation(let node):
      return node
    case .poundSourceLocationArgs(let node):
      return node
    case .declModifier(let node):
      return node
    case .inheritedType(let node):
      return node
    case .inheritedTypeList(let node):
      return node
    case .typeInheritanceClause(let node):
      return node
    case .classDecl(let node):
      return node
    case .structDecl(let node):
      return node
    case .protocolDecl(let node):
      return node
    case .extensionDecl(let node):
      return node
    case .memberDeclBlock(let node):
      return node
    case .memberDeclList(let node):
      return node
    case .memberDeclListItem(let node):
      return node
    case .sourceFile(let node):
      return node
    case .initializerClause(let node):
      return node
    case .functionParameter(let node):
      return node
    case .modifierList(let node):
      return node
    case .functionDecl(let node):
      return node
    case .initializerDecl(let node):
      return node
    case .deinitializerDecl(let node):
      return node
    case .subscriptDecl(let node):
      return node
    case .accessLevelModifier(let node):
      return node
    case .accessPathComponent(let node):
      return node
    case .accessPath(let node):
      return node
    case .importDecl(let node):
      return node
    case .accessorParameter(let node):
      return node
    case .accessorDecl(let node):
      return node
    case .accessorList(let node):
      return node
    case .accessorBlock(let node):
      return node
    case .patternBinding(let node):
      return node
    case .patternBindingList(let node):
      return node
    case .variableDecl(let node):
      return node
    case .enumCaseElement(let node):
      return node
    case .enumCaseElementList(let node):
      return node
    case .enumCaseDecl(let node):
      return node
    case .enumDecl(let node):
      return node
    case .operatorDecl(let node):
      return node
    case .identifierList(let node):
      return node
    case .operatorPrecedenceAndTypes(let node):
      return node
    case .precedenceGroupDecl(let node):
      return node
    case .precedenceGroupAttributeList(let node):
      return node
    case .precedenceGroupRelation(let node):
      return node
    case .precedenceGroupNameList(let node):
      return node
    case .precedenceGroupNameElement(let node):
      return node
    case .precedenceGroupAssignment(let node):
      return node
    case .precedenceGroupAssociativity(let node):
      return node
    case .tokenList(let node):
      return node
    case .nonEmptyTokenList(let node):
      return node
    case .customAttribute(let node):
      return node
    case .attribute(let node):
      return node
    case .attributeList(let node):
      return node
    case .specializeAttributeSpecList(let node):
      return node
    case .availabilityEntry(let node):
      return node
    case .labeledSpecializeEntry(let node):
      return node
    case .targetFunctionEntry(let node):
      return node
    case .namedAttributeStringArgument(let node):
      return node
    case .declName(let node):
      return node
    case .implementsAttributeArguments(let node):
      return node
    case .objCSelectorPiece(let node):
      return node
    case .objCSelector(let node):
      return node
    case .differentiableAttributeArguments(let node):
      return node
    case .differentiabilityParamsClause(let node):
      return node
    case .differentiabilityParams(let node):
      return node
    case .differentiabilityParamList(let node):
      return node
    case .differentiabilityParam(let node):
      return node
    case .derivativeRegistrationAttributeArguments(let node):
      return node
    case .qualifiedDeclName(let node):
      return node
    case .functionDeclName(let node):
      return node
    case .backDeployAttributeSpecList(let node):
      return node
    case .backDeployVersionList(let node):
      return node
    case .backDeployVersionArgument(let node):
      return node
    case .continueStmt(let node):
      return node
    case .whileStmt(let node):
      return node
    case .deferStmt(let node):
      return node
    case .expressionStmt(let node):
      return node
    case .switchCaseList(let node):
      return node
    case .repeatWhileStmt(let node):
      return node
    case .guardStmt(let node):
      return node
    case .whereClause(let node):
      return node
    case .forInStmt(let node):
      return node
    case .switchStmt(let node):
      return node
    case .catchClauseList(let node):
      return node
    case .doStmt(let node):
      return node
    case .returnStmt(let node):
      return node
    case .yieldStmt(let node):
      return node
    case .yieldList(let node):
      return node
    case .fallthroughStmt(let node):
      return node
    case .breakStmt(let node):
      return node
    case .caseItemList(let node):
      return node
    case .catchItemList(let node):
      return node
    case .conditionElement(let node):
      return node
    case .availabilityCondition(let node):
      return node
    case .matchingPatternCondition(let node):
      return node
    case .optionalBindingCondition(let node):
      return node
    case .unavailabilityCondition(let node):
      return node
    case .conditionElementList(let node):
      return node
    case .declarationStmt(let node):
      return node
    case .throwStmt(let node):
      return node
    case .ifStmt(let node):
      return node
    case .elseIfContinuation(let node):
      return node
    case .elseBlock(let node):
      return node
    case .switchCase(let node):
      return node
    case .switchDefaultLabel(let node):
      return node
    case .caseItem(let node):
      return node
    case .catchItem(let node):
      return node
    case .switchCaseLabel(let node):
      return node
    case .catchClause(let node):
      return node
    case .poundAssertStmt(let node):
      return node
    case .genericWhereClause(let node):
      return node
    case .genericRequirementList(let node):
      return node
    case .genericRequirement(let node):
      return node
    case .sameTypeRequirement(let node):
      return node
    case .genericParameterList(let node):
      return node
    case .genericParameter(let node):
      return node
    case .primaryAssociatedTypeList(let node):
      return node
    case .primaryAssociatedType(let node):
      return node
    case .genericParameterClause(let node):
      return node
    case .conformanceRequirement(let node):
      return node
    case .primaryAssociatedTypeClause(let node):
      return node
    case .simpleTypeIdentifier(let node):
      return node
    case .memberTypeIdentifier(let node):
      return node
    case .classRestrictionType(let node):
      return node
    case .arrayType(let node):
      return node
    case .dictionaryType(let node):
      return node
    case .metatypeType(let node):
      return node
    case .optionalType(let node):
      return node
    case .constrainedSugarType(let node):
      return node
    case .implicitlyUnwrappedOptionalType(let node):
      return node
    case .compositionTypeElement(let node):
      return node
    case .compositionTypeElementList(let node):
      return node
    case .compositionType(let node):
      return node
    case .tupleTypeElement(let node):
      return node
    case .tupleTypeElementList(let node):
      return node
    case .tupleType(let node):
      return node
    case .functionType(let node):
      return node
    case .attributedType(let node):
      return node
    case .genericArgumentList(let node):
      return node
    case .genericArgument(let node):
      return node
    case .genericArgumentClause(let node):
      return node
    case .typeAnnotation(let node):
      return node
    case .enumCasePattern(let node):
      return node
    case .isTypePattern(let node):
      return node
    case .optionalPattern(let node):
      return node
    case .identifierPattern(let node):
      return node
    case .asTypePattern(let node):
      return node
    case .tuplePattern(let node):
      return node
    case .wildcardPattern(let node):
      return node
    case .tuplePatternElement(let node):
      return node
    case .expressionPattern(let node):
      return node
    case .tuplePatternElementList(let node):
      return node
    case .valueBindingPattern(let node):
      return node
    case .availabilitySpecList(let node):
      return node
    case .availabilityArgument(let node):
      return node
    case .availabilityLabeledArgument(let node):
      return node
    case .availabilityVersionRestriction(let node):
      return node
    case .versionTuple(let node):
      return node
    }
  }
}
