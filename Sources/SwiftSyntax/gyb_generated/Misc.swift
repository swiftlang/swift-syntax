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

extension SyntaxProtocol {
  public var asUnknown: UnknownSyntax? {
    isUnknown ? UnknownSyntax(data: syntax.data) : nil
  }

  public var isUnknownDecl: Bool {
    RawUnknownDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asUnknownDecl: UnknownDeclSyntax? {
    isUnknownDecl ? UnknownDeclSyntax(data: syntax.data) : nil
  }

  public var isUnknownExpr: Bool {
    RawUnknownExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asUnknownExpr: UnknownExprSyntax? {
    isUnknownExpr ? UnknownExprSyntax(data: syntax.data) : nil
  }

  public var isUnknownStmt: Bool {
    RawUnknownStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asUnknownStmt: UnknownStmtSyntax? {
    isUnknownStmt ? UnknownStmtSyntax(data: syntax.data) : nil
  }

  public var isUnknownType: Bool {
    RawUnknownTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asUnknownType: UnknownTypeSyntax? {
    isUnknownType ? UnknownTypeSyntax(data: syntax.data) : nil
  }

  public var isUnknownPattern: Bool {
    RawUnknownPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asUnknownPattern: UnknownPatternSyntax? {
    isUnknownPattern ? UnknownPatternSyntax(data: syntax.data) : nil
  }

  public var isCodeBlockItem: Bool {
    RawCodeBlockItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCodeBlockItem: CodeBlockItemSyntax? {
    isCodeBlockItem ? CodeBlockItemSyntax(data: syntax.data) : nil
  }

  public var isCodeBlockItemList: Bool {
    RawCodeBlockItemListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCodeBlockItemList: CodeBlockItemListSyntax? {
    isCodeBlockItemList ? CodeBlockItemListSyntax(data: syntax.data) : nil
  }

  public var isCodeBlock: Bool {
    RawCodeBlockSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCodeBlock: CodeBlockSyntax? {
    isCodeBlock ? CodeBlockSyntax(data: syntax.data) : nil
  }

  public var isInOutExpr: Bool {
    RawInOutExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asInOutExpr: InOutExprSyntax? {
    isInOutExpr ? InOutExprSyntax(data: syntax.data) : nil
  }

  public var isPoundColumnExpr: Bool {
    RawPoundColumnExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundColumnExpr: PoundColumnExprSyntax? {
    isPoundColumnExpr ? PoundColumnExprSyntax(data: syntax.data) : nil
  }

  public var isTupleExprElementList: Bool {
    RawTupleExprElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTupleExprElementList: TupleExprElementListSyntax? {
    isTupleExprElementList ? TupleExprElementListSyntax(data: syntax.data) : nil
  }

  public var isArrayElementList: Bool {
    RawArrayElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asArrayElementList: ArrayElementListSyntax? {
    isArrayElementList ? ArrayElementListSyntax(data: syntax.data) : nil
  }

  public var isDictionaryElementList: Bool {
    RawDictionaryElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDictionaryElementList: DictionaryElementListSyntax? {
    isDictionaryElementList ? DictionaryElementListSyntax(data: syntax.data) : nil
  }

  public var isStringLiteralSegments: Bool {
    RawStringLiteralSegmentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asStringLiteralSegments: StringLiteralSegmentsSyntax? {
    isStringLiteralSegments ? StringLiteralSegmentsSyntax(data: syntax.data) : nil
  }

  public var isTryExpr: Bool {
    RawTryExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTryExpr: TryExprSyntax? {
    isTryExpr ? TryExprSyntax(data: syntax.data) : nil
  }

  public var isAwaitExpr: Bool {
    RawAwaitExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAwaitExpr: AwaitExprSyntax? {
    isAwaitExpr ? AwaitExprSyntax(data: syntax.data) : nil
  }

  public var isDeclNameArgument: Bool {
    RawDeclNameArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeclNameArgument: DeclNameArgumentSyntax? {
    isDeclNameArgument ? DeclNameArgumentSyntax(data: syntax.data) : nil
  }

  public var isDeclNameArgumentList: Bool {
    RawDeclNameArgumentListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeclNameArgumentList: DeclNameArgumentListSyntax? {
    isDeclNameArgumentList ? DeclNameArgumentListSyntax(data: syntax.data) : nil
  }

  public var isDeclNameArguments: Bool {
    RawDeclNameArgumentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeclNameArguments: DeclNameArgumentsSyntax? {
    isDeclNameArguments ? DeclNameArgumentsSyntax(data: syntax.data) : nil
  }

  public var isIdentifierExpr: Bool {
    RawIdentifierExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIdentifierExpr: IdentifierExprSyntax? {
    isIdentifierExpr ? IdentifierExprSyntax(data: syntax.data) : nil
  }

  public var isSuperRefExpr: Bool {
    RawSuperRefExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSuperRefExpr: SuperRefExprSyntax? {
    isSuperRefExpr ? SuperRefExprSyntax(data: syntax.data) : nil
  }

  public var isNilLiteralExpr: Bool {
    RawNilLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asNilLiteralExpr: NilLiteralExprSyntax? {
    isNilLiteralExpr ? NilLiteralExprSyntax(data: syntax.data) : nil
  }

  public var isDiscardAssignmentExpr: Bool {
    RawDiscardAssignmentExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDiscardAssignmentExpr: DiscardAssignmentExprSyntax? {
    isDiscardAssignmentExpr ? DiscardAssignmentExprSyntax(data: syntax.data) : nil
  }

  public var isAssignmentExpr: Bool {
    RawAssignmentExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAssignmentExpr: AssignmentExprSyntax? {
    isAssignmentExpr ? AssignmentExprSyntax(data: syntax.data) : nil
  }

  public var isSequenceExpr: Bool {
    RawSequenceExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSequenceExpr: SequenceExprSyntax? {
    isSequenceExpr ? SequenceExprSyntax(data: syntax.data) : nil
  }

  public var isExprList: Bool {
    RawExprListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asExprList: ExprListSyntax? {
    isExprList ? ExprListSyntax(data: syntax.data) : nil
  }

  public var isPoundLineExpr: Bool {
    RawPoundLineExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundLineExpr: PoundLineExprSyntax? {
    isPoundLineExpr ? PoundLineExprSyntax(data: syntax.data) : nil
  }

  public var isPoundFileExpr: Bool {
    RawPoundFileExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundFileExpr: PoundFileExprSyntax? {
    isPoundFileExpr ? PoundFileExprSyntax(data: syntax.data) : nil
  }

  public var isPoundFileIDExpr: Bool {
    RawPoundFileIDExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundFileIDExpr: PoundFileIDExprSyntax? {
    isPoundFileIDExpr ? PoundFileIDExprSyntax(data: syntax.data) : nil
  }

  public var isPoundFilePathExpr: Bool {
    RawPoundFilePathExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundFilePathExpr: PoundFilePathExprSyntax? {
    isPoundFilePathExpr ? PoundFilePathExprSyntax(data: syntax.data) : nil
  }

  public var isPoundFunctionExpr: Bool {
    RawPoundFunctionExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundFunctionExpr: PoundFunctionExprSyntax? {
    isPoundFunctionExpr ? PoundFunctionExprSyntax(data: syntax.data) : nil
  }

  public var isPoundDsohandleExpr: Bool {
    RawPoundDsohandleExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundDsohandleExpr: PoundDsohandleExprSyntax? {
    isPoundDsohandleExpr ? PoundDsohandleExprSyntax(data: syntax.data) : nil
  }

  public var isSymbolicReferenceExpr: Bool {
    RawSymbolicReferenceExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSymbolicReferenceExpr: SymbolicReferenceExprSyntax? {
    isSymbolicReferenceExpr ? SymbolicReferenceExprSyntax(data: syntax.data) : nil
  }

  public var isPrefixOperatorExpr: Bool {
    RawPrefixOperatorExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrefixOperatorExpr: PrefixOperatorExprSyntax? {
    isPrefixOperatorExpr ? PrefixOperatorExprSyntax(data: syntax.data) : nil
  }

  public var isBinaryOperatorExpr: Bool {
    RawBinaryOperatorExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asBinaryOperatorExpr: BinaryOperatorExprSyntax? {
    isBinaryOperatorExpr ? BinaryOperatorExprSyntax(data: syntax.data) : nil
  }

  public var isArrowExpr: Bool {
    RawArrowExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asArrowExpr: ArrowExprSyntax? {
    isArrowExpr ? ArrowExprSyntax(data: syntax.data) : nil
  }

  public var isFloatLiteralExpr: Bool {
    RawFloatLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFloatLiteralExpr: FloatLiteralExprSyntax? {
    isFloatLiteralExpr ? FloatLiteralExprSyntax(data: syntax.data) : nil
  }

  public var isTupleExpr: Bool {
    RawTupleExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTupleExpr: TupleExprSyntax? {
    isTupleExpr ? TupleExprSyntax(data: syntax.data) : nil
  }

  public var isArrayExpr: Bool {
    RawArrayExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asArrayExpr: ArrayExprSyntax? {
    isArrayExpr ? ArrayExprSyntax(data: syntax.data) : nil
  }

  public var isDictionaryExpr: Bool {
    RawDictionaryExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDictionaryExpr: DictionaryExprSyntax? {
    isDictionaryExpr ? DictionaryExprSyntax(data: syntax.data) : nil
  }

  public var isTupleExprElement: Bool {
    RawTupleExprElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTupleExprElement: TupleExprElementSyntax? {
    isTupleExprElement ? TupleExprElementSyntax(data: syntax.data) : nil
  }

  public var isArrayElement: Bool {
    RawArrayElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asArrayElement: ArrayElementSyntax? {
    isArrayElement ? ArrayElementSyntax(data: syntax.data) : nil
  }

  public var isDictionaryElement: Bool {
    RawDictionaryElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDictionaryElement: DictionaryElementSyntax? {
    isDictionaryElement ? DictionaryElementSyntax(data: syntax.data) : nil
  }

  public var isIntegerLiteralExpr: Bool {
    RawIntegerLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIntegerLiteralExpr: IntegerLiteralExprSyntax? {
    isIntegerLiteralExpr ? IntegerLiteralExprSyntax(data: syntax.data) : nil
  }

  public var isBooleanLiteralExpr: Bool {
    RawBooleanLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asBooleanLiteralExpr: BooleanLiteralExprSyntax? {
    isBooleanLiteralExpr ? BooleanLiteralExprSyntax(data: syntax.data) : nil
  }

  public var isTernaryExpr: Bool {
    RawTernaryExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTernaryExpr: TernaryExprSyntax? {
    isTernaryExpr ? TernaryExprSyntax(data: syntax.data) : nil
  }

  public var isMemberAccessExpr: Bool {
    RawMemberAccessExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMemberAccessExpr: MemberAccessExprSyntax? {
    isMemberAccessExpr ? MemberAccessExprSyntax(data: syntax.data) : nil
  }

  public var isIsExpr: Bool {
    RawIsExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIsExpr: IsExprSyntax? {
    isIsExpr ? IsExprSyntax(data: syntax.data) : nil
  }

  public var isAsExpr: Bool {
    RawAsExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAsExpr: AsExprSyntax? {
    isAsExpr ? AsExprSyntax(data: syntax.data) : nil
  }

  public var isTypeExpr: Bool {
    RawTypeExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTypeExpr: TypeExprSyntax? {
    isTypeExpr ? TypeExprSyntax(data: syntax.data) : nil
  }

  public var isClosureCaptureItem: Bool {
    RawClosureCaptureItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClosureCaptureItem: ClosureCaptureItemSyntax? {
    isClosureCaptureItem ? ClosureCaptureItemSyntax(data: syntax.data) : nil
  }

  public var isClosureCaptureItemList: Bool {
    RawClosureCaptureItemListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClosureCaptureItemList: ClosureCaptureItemListSyntax? {
    isClosureCaptureItemList ? ClosureCaptureItemListSyntax(data: syntax.data) : nil
  }

  public var isClosureCaptureSignature: Bool {
    RawClosureCaptureSignatureSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClosureCaptureSignature: ClosureCaptureSignatureSyntax? {
    isClosureCaptureSignature ? ClosureCaptureSignatureSyntax(data: syntax.data) : nil
  }

  public var isClosureParam: Bool {
    RawClosureParamSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClosureParam: ClosureParamSyntax? {
    isClosureParam ? ClosureParamSyntax(data: syntax.data) : nil
  }

  public var isClosureParamList: Bool {
    RawClosureParamListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClosureParamList: ClosureParamListSyntax? {
    isClosureParamList ? ClosureParamListSyntax(data: syntax.data) : nil
  }

  public var isClosureSignature: Bool {
    RawClosureSignatureSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClosureSignature: ClosureSignatureSyntax? {
    isClosureSignature ? ClosureSignatureSyntax(data: syntax.data) : nil
  }

  public var isClosureExpr: Bool {
    RawClosureExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClosureExpr: ClosureExprSyntax? {
    isClosureExpr ? ClosureExprSyntax(data: syntax.data) : nil
  }

  public var isUnresolvedPatternExpr: Bool {
    RawUnresolvedPatternExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asUnresolvedPatternExpr: UnresolvedPatternExprSyntax? {
    isUnresolvedPatternExpr ? UnresolvedPatternExprSyntax(data: syntax.data) : nil
  }

  public var isMultipleTrailingClosureElement: Bool {
    RawMultipleTrailingClosureElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMultipleTrailingClosureElement: MultipleTrailingClosureElementSyntax? {
    isMultipleTrailingClosureElement ? MultipleTrailingClosureElementSyntax(data: syntax.data) : nil
  }

  public var isMultipleTrailingClosureElementList: Bool {
    RawMultipleTrailingClosureElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMultipleTrailingClosureElementList: MultipleTrailingClosureElementListSyntax? {
    isMultipleTrailingClosureElementList ? MultipleTrailingClosureElementListSyntax(data: syntax.data) : nil
  }

  public var isFunctionCallExpr: Bool {
    RawFunctionCallExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFunctionCallExpr: FunctionCallExprSyntax? {
    isFunctionCallExpr ? FunctionCallExprSyntax(data: syntax.data) : nil
  }

  public var isSubscriptExpr: Bool {
    RawSubscriptExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSubscriptExpr: SubscriptExprSyntax? {
    isSubscriptExpr ? SubscriptExprSyntax(data: syntax.data) : nil
  }

  public var isOptionalChainingExpr: Bool {
    RawOptionalChainingExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asOptionalChainingExpr: OptionalChainingExprSyntax? {
    isOptionalChainingExpr ? OptionalChainingExprSyntax(data: syntax.data) : nil
  }

  public var isForcedValueExpr: Bool {
    RawForcedValueExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asForcedValueExpr: ForcedValueExprSyntax? {
    isForcedValueExpr ? ForcedValueExprSyntax(data: syntax.data) : nil
  }

  public var isPostfixUnaryExpr: Bool {
    RawPostfixUnaryExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPostfixUnaryExpr: PostfixUnaryExprSyntax? {
    isPostfixUnaryExpr ? PostfixUnaryExprSyntax(data: syntax.data) : nil
  }

  public var isSpecializeExpr: Bool {
    RawSpecializeExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSpecializeExpr: SpecializeExprSyntax? {
    isSpecializeExpr ? SpecializeExprSyntax(data: syntax.data) : nil
  }

  public var isStringSegment: Bool {
    RawStringSegmentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asStringSegment: StringSegmentSyntax? {
    isStringSegment ? StringSegmentSyntax(data: syntax.data) : nil
  }

  public var isExpressionSegment: Bool {
    RawExpressionSegmentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asExpressionSegment: ExpressionSegmentSyntax? {
    isExpressionSegment ? ExpressionSegmentSyntax(data: syntax.data) : nil
  }

  public var isStringLiteralExpr: Bool {
    RawStringLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asStringLiteralExpr: StringLiteralExprSyntax? {
    isStringLiteralExpr ? StringLiteralExprSyntax(data: syntax.data) : nil
  }

  public var isRegexLiteralExpr: Bool {
    RawRegexLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asRegexLiteralExpr: RegexLiteralExprSyntax? {
    isRegexLiteralExpr ? RegexLiteralExprSyntax(data: syntax.data) : nil
  }

  public var isKeyPathExpr: Bool {
    RawKeyPathExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asKeyPathExpr: KeyPathExprSyntax? {
    isKeyPathExpr ? KeyPathExprSyntax(data: syntax.data) : nil
  }

  public var isKeyPathBaseExpr: Bool {
    RawKeyPathBaseExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asKeyPathBaseExpr: KeyPathBaseExprSyntax? {
    isKeyPathBaseExpr ? KeyPathBaseExprSyntax(data: syntax.data) : nil
  }

  public var isObjcNamePiece: Bool {
    RawObjcNamePieceSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asObjcNamePiece: ObjcNamePieceSyntax? {
    isObjcNamePiece ? ObjcNamePieceSyntax(data: syntax.data) : nil
  }

  public var isObjcName: Bool {
    RawObjcNameSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asObjcName: ObjcNameSyntax? {
    isObjcName ? ObjcNameSyntax(data: syntax.data) : nil
  }

  public var isObjcKeyPathExpr: Bool {
    RawObjcKeyPathExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asObjcKeyPathExpr: ObjcKeyPathExprSyntax? {
    isObjcKeyPathExpr ? ObjcKeyPathExprSyntax(data: syntax.data) : nil
  }

  public var isObjcSelectorExpr: Bool {
    RawObjcSelectorExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asObjcSelectorExpr: ObjcSelectorExprSyntax? {
    isObjcSelectorExpr ? ObjcSelectorExprSyntax(data: syntax.data) : nil
  }

  public var isPostfixIfConfigExpr: Bool {
    RawPostfixIfConfigExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPostfixIfConfigExpr: PostfixIfConfigExprSyntax? {
    isPostfixIfConfigExpr ? PostfixIfConfigExprSyntax(data: syntax.data) : nil
  }

  public var isEditorPlaceholderExpr: Bool {
    RawEditorPlaceholderExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asEditorPlaceholderExpr: EditorPlaceholderExprSyntax? {
    isEditorPlaceholderExpr ? EditorPlaceholderExprSyntax(data: syntax.data) : nil
  }

  public var isObjectLiteralExpr: Bool {
    RawObjectLiteralExprSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asObjectLiteralExpr: ObjectLiteralExprSyntax? {
    isObjectLiteralExpr ? ObjectLiteralExprSyntax(data: syntax.data) : nil
  }

  public var isTypeInitializerClause: Bool {
    RawTypeInitializerClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTypeInitializerClause: TypeInitializerClauseSyntax? {
    isTypeInitializerClause ? TypeInitializerClauseSyntax(data: syntax.data) : nil
  }

  public var isTypealiasDecl: Bool {
    RawTypealiasDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTypealiasDecl: TypealiasDeclSyntax? {
    isTypealiasDecl ? TypealiasDeclSyntax(data: syntax.data) : nil
  }

  public var isAssociatedtypeDecl: Bool {
    RawAssociatedtypeDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAssociatedtypeDecl: AssociatedtypeDeclSyntax? {
    isAssociatedtypeDecl ? AssociatedtypeDeclSyntax(data: syntax.data) : nil
  }

  public var isFunctionParameterList: Bool {
    RawFunctionParameterListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFunctionParameterList: FunctionParameterListSyntax? {
    isFunctionParameterList ? FunctionParameterListSyntax(data: syntax.data) : nil
  }

  public var isParameterClause: Bool {
    RawParameterClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asParameterClause: ParameterClauseSyntax? {
    isParameterClause ? ParameterClauseSyntax(data: syntax.data) : nil
  }

  public var isReturnClause: Bool {
    RawReturnClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asReturnClause: ReturnClauseSyntax? {
    isReturnClause ? ReturnClauseSyntax(data: syntax.data) : nil
  }

  public var isFunctionSignature: Bool {
    RawFunctionSignatureSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFunctionSignature: FunctionSignatureSyntax? {
    isFunctionSignature ? FunctionSignatureSyntax(data: syntax.data) : nil
  }

  public var isIfConfigClause: Bool {
    RawIfConfigClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIfConfigClause: IfConfigClauseSyntax? {
    isIfConfigClause ? IfConfigClauseSyntax(data: syntax.data) : nil
  }

  public var isIfConfigClauseList: Bool {
    RawIfConfigClauseListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIfConfigClauseList: IfConfigClauseListSyntax? {
    isIfConfigClauseList ? IfConfigClauseListSyntax(data: syntax.data) : nil
  }

  public var isIfConfigDecl: Bool {
    RawIfConfigDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIfConfigDecl: IfConfigDeclSyntax? {
    isIfConfigDecl ? IfConfigDeclSyntax(data: syntax.data) : nil
  }

  public var isPoundErrorDecl: Bool {
    RawPoundErrorDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundErrorDecl: PoundErrorDeclSyntax? {
    isPoundErrorDecl ? PoundErrorDeclSyntax(data: syntax.data) : nil
  }

  public var isPoundWarningDecl: Bool {
    RawPoundWarningDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundWarningDecl: PoundWarningDeclSyntax? {
    isPoundWarningDecl ? PoundWarningDeclSyntax(data: syntax.data) : nil
  }

  public var isPoundSourceLocation: Bool {
    RawPoundSourceLocationSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundSourceLocation: PoundSourceLocationSyntax? {
    isPoundSourceLocation ? PoundSourceLocationSyntax(data: syntax.data) : nil
  }

  public var isPoundSourceLocationArgs: Bool {
    RawPoundSourceLocationArgsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundSourceLocationArgs: PoundSourceLocationArgsSyntax? {
    isPoundSourceLocationArgs ? PoundSourceLocationArgsSyntax(data: syntax.data) : nil
  }

  public var isDeclModifierDetail: Bool {
    RawDeclModifierDetailSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeclModifierDetail: DeclModifierDetailSyntax? {
    isDeclModifierDetail ? DeclModifierDetailSyntax(data: syntax.data) : nil
  }

  public var isDeclModifier: Bool {
    RawDeclModifierSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeclModifier: DeclModifierSyntax? {
    isDeclModifier ? DeclModifierSyntax(data: syntax.data) : nil
  }

  public var isInheritedType: Bool {
    RawInheritedTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asInheritedType: InheritedTypeSyntax? {
    isInheritedType ? InheritedTypeSyntax(data: syntax.data) : nil
  }

  public var isInheritedTypeList: Bool {
    RawInheritedTypeListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asInheritedTypeList: InheritedTypeListSyntax? {
    isInheritedTypeList ? InheritedTypeListSyntax(data: syntax.data) : nil
  }

  public var isTypeInheritanceClause: Bool {
    RawTypeInheritanceClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTypeInheritanceClause: TypeInheritanceClauseSyntax? {
    isTypeInheritanceClause ? TypeInheritanceClauseSyntax(data: syntax.data) : nil
  }

  public var isClassDecl: Bool {
    RawClassDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClassDecl: ClassDeclSyntax? {
    isClassDecl ? ClassDeclSyntax(data: syntax.data) : nil
  }

  public var isActorDecl: Bool {
    RawActorDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asActorDecl: ActorDeclSyntax? {
    isActorDecl ? ActorDeclSyntax(data: syntax.data) : nil
  }

  public var isStructDecl: Bool {
    RawStructDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asStructDecl: StructDeclSyntax? {
    isStructDecl ? StructDeclSyntax(data: syntax.data) : nil
  }

  public var isProtocolDecl: Bool {
    RawProtocolDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asProtocolDecl: ProtocolDeclSyntax? {
    isProtocolDecl ? ProtocolDeclSyntax(data: syntax.data) : nil
  }

  public var isExtensionDecl: Bool {
    RawExtensionDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asExtensionDecl: ExtensionDeclSyntax? {
    isExtensionDecl ? ExtensionDeclSyntax(data: syntax.data) : nil
  }

  public var isMemberDeclBlock: Bool {
    RawMemberDeclBlockSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMemberDeclBlock: MemberDeclBlockSyntax? {
    isMemberDeclBlock ? MemberDeclBlockSyntax(data: syntax.data) : nil
  }

  public var isMemberDeclList: Bool {
    RawMemberDeclListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMemberDeclList: MemberDeclListSyntax? {
    isMemberDeclList ? MemberDeclListSyntax(data: syntax.data) : nil
  }

  public var isMemberDeclListItem: Bool {
    RawMemberDeclListItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMemberDeclListItem: MemberDeclListItemSyntax? {
    isMemberDeclListItem ? MemberDeclListItemSyntax(data: syntax.data) : nil
  }

  public var isSourceFile: Bool {
    RawSourceFileSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSourceFile: SourceFileSyntax? {
    isSourceFile ? SourceFileSyntax(data: syntax.data) : nil
  }

  public var isInitializerClause: Bool {
    RawInitializerClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asInitializerClause: InitializerClauseSyntax? {
    isInitializerClause ? InitializerClauseSyntax(data: syntax.data) : nil
  }

  public var isFunctionParameter: Bool {
    RawFunctionParameterSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFunctionParameter: FunctionParameterSyntax? {
    isFunctionParameter ? FunctionParameterSyntax(data: syntax.data) : nil
  }

  public var isModifierList: Bool {
    RawModifierListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asModifierList: ModifierListSyntax? {
    isModifierList ? ModifierListSyntax(data: syntax.data) : nil
  }

  public var isFunctionDecl: Bool {
    RawFunctionDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFunctionDecl: FunctionDeclSyntax? {
    isFunctionDecl ? FunctionDeclSyntax(data: syntax.data) : nil
  }

  public var isInitializerDecl: Bool {
    RawInitializerDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asInitializerDecl: InitializerDeclSyntax? {
    isInitializerDecl ? InitializerDeclSyntax(data: syntax.data) : nil
  }

  public var isDeinitializerDecl: Bool {
    RawDeinitializerDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeinitializerDecl: DeinitializerDeclSyntax? {
    isDeinitializerDecl ? DeinitializerDeclSyntax(data: syntax.data) : nil
  }

  public var isSubscriptDecl: Bool {
    RawSubscriptDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSubscriptDecl: SubscriptDeclSyntax? {
    isSubscriptDecl ? SubscriptDeclSyntax(data: syntax.data) : nil
  }

  public var isAccessLevelModifier: Bool {
    RawAccessLevelModifierSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAccessLevelModifier: AccessLevelModifierSyntax? {
    isAccessLevelModifier ? AccessLevelModifierSyntax(data: syntax.data) : nil
  }

  public var isAccessPathComponent: Bool {
    RawAccessPathComponentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAccessPathComponent: AccessPathComponentSyntax? {
    isAccessPathComponent ? AccessPathComponentSyntax(data: syntax.data) : nil
  }

  public var isAccessPath: Bool {
    RawAccessPathSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAccessPath: AccessPathSyntax? {
    isAccessPath ? AccessPathSyntax(data: syntax.data) : nil
  }

  public var isImportDecl: Bool {
    RawImportDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asImportDecl: ImportDeclSyntax? {
    isImportDecl ? ImportDeclSyntax(data: syntax.data) : nil
  }

  public var isAccessorParameter: Bool {
    RawAccessorParameterSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAccessorParameter: AccessorParameterSyntax? {
    isAccessorParameter ? AccessorParameterSyntax(data: syntax.data) : nil
  }

  public var isAccessorDecl: Bool {
    RawAccessorDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAccessorDecl: AccessorDeclSyntax? {
    isAccessorDecl ? AccessorDeclSyntax(data: syntax.data) : nil
  }

  public var isAccessorList: Bool {
    RawAccessorListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAccessorList: AccessorListSyntax? {
    isAccessorList ? AccessorListSyntax(data: syntax.data) : nil
  }

  public var isAccessorBlock: Bool {
    RawAccessorBlockSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAccessorBlock: AccessorBlockSyntax? {
    isAccessorBlock ? AccessorBlockSyntax(data: syntax.data) : nil
  }

  public var isPatternBinding: Bool {
    RawPatternBindingSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPatternBinding: PatternBindingSyntax? {
    isPatternBinding ? PatternBindingSyntax(data: syntax.data) : nil
  }

  public var isPatternBindingList: Bool {
    RawPatternBindingListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPatternBindingList: PatternBindingListSyntax? {
    isPatternBindingList ? PatternBindingListSyntax(data: syntax.data) : nil
  }

  public var isVariableDecl: Bool {
    RawVariableDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asVariableDecl: VariableDeclSyntax? {
    isVariableDecl ? VariableDeclSyntax(data: syntax.data) : nil
  }

  public var isEnumCaseElement: Bool {
    RawEnumCaseElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asEnumCaseElement: EnumCaseElementSyntax? {
    isEnumCaseElement ? EnumCaseElementSyntax(data: syntax.data) : nil
  }

  public var isEnumCaseElementList: Bool {
    RawEnumCaseElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asEnumCaseElementList: EnumCaseElementListSyntax? {
    isEnumCaseElementList ? EnumCaseElementListSyntax(data: syntax.data) : nil
  }

  public var isEnumCaseDecl: Bool {
    RawEnumCaseDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asEnumCaseDecl: EnumCaseDeclSyntax? {
    isEnumCaseDecl ? EnumCaseDeclSyntax(data: syntax.data) : nil
  }

  public var isEnumDecl: Bool {
    RawEnumDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asEnumDecl: EnumDeclSyntax? {
    isEnumDecl ? EnumDeclSyntax(data: syntax.data) : nil
  }

  public var isOperatorDecl: Bool {
    RawOperatorDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asOperatorDecl: OperatorDeclSyntax? {
    isOperatorDecl ? OperatorDeclSyntax(data: syntax.data) : nil
  }

  public var isIdentifierList: Bool {
    RawIdentifierListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIdentifierList: IdentifierListSyntax? {
    isIdentifierList ? IdentifierListSyntax(data: syntax.data) : nil
  }

  public var isOperatorPrecedenceAndTypes: Bool {
    RawOperatorPrecedenceAndTypesSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asOperatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax? {
    isOperatorPrecedenceAndTypes ? OperatorPrecedenceAndTypesSyntax(data: syntax.data) : nil
  }

  public var isPrecedenceGroupDecl: Bool {
    RawPrecedenceGroupDeclSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrecedenceGroupDecl: PrecedenceGroupDeclSyntax? {
    isPrecedenceGroupDecl ? PrecedenceGroupDeclSyntax(data: syntax.data) : nil
  }

  public var isPrecedenceGroupAttributeList: Bool {
    RawPrecedenceGroupAttributeListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrecedenceGroupAttributeList: PrecedenceGroupAttributeListSyntax? {
    isPrecedenceGroupAttributeList ? PrecedenceGroupAttributeListSyntax(data: syntax.data) : nil
  }

  public var isPrecedenceGroupRelation: Bool {
    RawPrecedenceGroupRelationSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrecedenceGroupRelation: PrecedenceGroupRelationSyntax? {
    isPrecedenceGroupRelation ? PrecedenceGroupRelationSyntax(data: syntax.data) : nil
  }

  public var isPrecedenceGroupNameList: Bool {
    RawPrecedenceGroupNameListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrecedenceGroupNameList: PrecedenceGroupNameListSyntax? {
    isPrecedenceGroupNameList ? PrecedenceGroupNameListSyntax(data: syntax.data) : nil
  }

  public var isPrecedenceGroupNameElement: Bool {
    RawPrecedenceGroupNameElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrecedenceGroupNameElement: PrecedenceGroupNameElementSyntax? {
    isPrecedenceGroupNameElement ? PrecedenceGroupNameElementSyntax(data: syntax.data) : nil
  }

  public var isPrecedenceGroupAssignment: Bool {
    RawPrecedenceGroupAssignmentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrecedenceGroupAssignment: PrecedenceGroupAssignmentSyntax? {
    isPrecedenceGroupAssignment ? PrecedenceGroupAssignmentSyntax(data: syntax.data) : nil
  }

  public var isPrecedenceGroupAssociativity: Bool {
    RawPrecedenceGroupAssociativitySyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrecedenceGroupAssociativity: PrecedenceGroupAssociativitySyntax? {
    isPrecedenceGroupAssociativity ? PrecedenceGroupAssociativitySyntax(data: syntax.data) : nil
  }

  public var isTokenList: Bool {
    RawTokenListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTokenList: TokenListSyntax? {
    isTokenList ? TokenListSyntax(data: syntax.data) : nil
  }

  public var isNonEmptyTokenList: Bool {
    RawNonEmptyTokenListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asNonEmptyTokenList: NonEmptyTokenListSyntax? {
    isNonEmptyTokenList ? NonEmptyTokenListSyntax(data: syntax.data) : nil
  }

  public var isCustomAttribute: Bool {
    RawCustomAttributeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCustomAttribute: CustomAttributeSyntax? {
    isCustomAttribute ? CustomAttributeSyntax(data: syntax.data) : nil
  }

  public var isAttribute: Bool {
    RawAttributeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAttribute: AttributeSyntax? {
    isAttribute ? AttributeSyntax(data: syntax.data) : nil
  }

  public var isAttributeList: Bool {
    RawAttributeListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAttributeList: AttributeListSyntax? {
    isAttributeList ? AttributeListSyntax(data: syntax.data) : nil
  }

  public var isSpecializeAttributeSpecList: Bool {
    RawSpecializeAttributeSpecListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSpecializeAttributeSpecList: SpecializeAttributeSpecListSyntax? {
    isSpecializeAttributeSpecList ? SpecializeAttributeSpecListSyntax(data: syntax.data) : nil
  }

  public var isAvailabilityEntry: Bool {
    RawAvailabilityEntrySyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAvailabilityEntry: AvailabilityEntrySyntax? {
    isAvailabilityEntry ? AvailabilityEntrySyntax(data: syntax.data) : nil
  }

  public var isLabeledSpecializeEntry: Bool {
    RawLabeledSpecializeEntrySyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asLabeledSpecializeEntry: LabeledSpecializeEntrySyntax? {
    isLabeledSpecializeEntry ? LabeledSpecializeEntrySyntax(data: syntax.data) : nil
  }

  public var isTargetFunctionEntry: Bool {
    RawTargetFunctionEntrySyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTargetFunctionEntry: TargetFunctionEntrySyntax? {
    isTargetFunctionEntry ? TargetFunctionEntrySyntax(data: syntax.data) : nil
  }

  public var isNamedAttributeStringArgument: Bool {
    RawNamedAttributeStringArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asNamedAttributeStringArgument: NamedAttributeStringArgumentSyntax? {
    isNamedAttributeStringArgument ? NamedAttributeStringArgumentSyntax(data: syntax.data) : nil
  }

  public var isDeclName: Bool {
    RawDeclNameSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeclName: DeclNameSyntax? {
    isDeclName ? DeclNameSyntax(data: syntax.data) : nil
  }

  public var isImplementsAttributeArguments: Bool {
    RawImplementsAttributeArgumentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asImplementsAttributeArguments: ImplementsAttributeArgumentsSyntax? {
    isImplementsAttributeArguments ? ImplementsAttributeArgumentsSyntax(data: syntax.data) : nil
  }

  public var isObjCSelectorPiece: Bool {
    RawObjCSelectorPieceSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asObjCSelectorPiece: ObjCSelectorPieceSyntax? {
    isObjCSelectorPiece ? ObjCSelectorPieceSyntax(data: syntax.data) : nil
  }

  public var isObjCSelector: Bool {
    RawObjCSelectorSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asObjCSelector: ObjCSelectorSyntax? {
    isObjCSelector ? ObjCSelectorSyntax(data: syntax.data) : nil
  }

  public var isDifferentiableAttributeArguments: Bool {
    RawDifferentiableAttributeArgumentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDifferentiableAttributeArguments: DifferentiableAttributeArgumentsSyntax? {
    isDifferentiableAttributeArguments ? DifferentiableAttributeArgumentsSyntax(data: syntax.data) : nil
  }

  public var isDifferentiabilityParamsClause: Bool {
    RawDifferentiabilityParamsClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDifferentiabilityParamsClause: DifferentiabilityParamsClauseSyntax? {
    isDifferentiabilityParamsClause ? DifferentiabilityParamsClauseSyntax(data: syntax.data) : nil
  }

  public var isDifferentiabilityParams: Bool {
    RawDifferentiabilityParamsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDifferentiabilityParams: DifferentiabilityParamsSyntax? {
    isDifferentiabilityParams ? DifferentiabilityParamsSyntax(data: syntax.data) : nil
  }

  public var isDifferentiabilityParamList: Bool {
    RawDifferentiabilityParamListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDifferentiabilityParamList: DifferentiabilityParamListSyntax? {
    isDifferentiabilityParamList ? DifferentiabilityParamListSyntax(data: syntax.data) : nil
  }

  public var isDifferentiabilityParam: Bool {
    RawDifferentiabilityParamSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDifferentiabilityParam: DifferentiabilityParamSyntax? {
    isDifferentiabilityParam ? DifferentiabilityParamSyntax(data: syntax.data) : nil
  }

  public var isDerivativeRegistrationAttributeArguments: Bool {
    RawDerivativeRegistrationAttributeArgumentsSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDerivativeRegistrationAttributeArguments: DerivativeRegistrationAttributeArgumentsSyntax? {
    isDerivativeRegistrationAttributeArguments ? DerivativeRegistrationAttributeArgumentsSyntax(data: syntax.data) : nil
  }

  public var isQualifiedDeclName: Bool {
    RawQualifiedDeclNameSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asQualifiedDeclName: QualifiedDeclNameSyntax? {
    isQualifiedDeclName ? QualifiedDeclNameSyntax(data: syntax.data) : nil
  }

  public var isFunctionDeclName: Bool {
    RawFunctionDeclNameSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFunctionDeclName: FunctionDeclNameSyntax? {
    isFunctionDeclName ? FunctionDeclNameSyntax(data: syntax.data) : nil
  }

  public var isBackDeployAttributeSpecList: Bool {
    RawBackDeployAttributeSpecListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asBackDeployAttributeSpecList: BackDeployAttributeSpecListSyntax? {
    isBackDeployAttributeSpecList ? BackDeployAttributeSpecListSyntax(data: syntax.data) : nil
  }

  public var isBackDeployVersionList: Bool {
    RawBackDeployVersionListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asBackDeployVersionList: BackDeployVersionListSyntax? {
    isBackDeployVersionList ? BackDeployVersionListSyntax(data: syntax.data) : nil
  }

  public var isBackDeployVersionArgument: Bool {
    RawBackDeployVersionArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asBackDeployVersionArgument: BackDeployVersionArgumentSyntax? {
    isBackDeployVersionArgument ? BackDeployVersionArgumentSyntax(data: syntax.data) : nil
  }

  public var isContinueStmt: Bool {
    RawContinueStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asContinueStmt: ContinueStmtSyntax? {
    isContinueStmt ? ContinueStmtSyntax(data: syntax.data) : nil
  }

  public var isWhileStmt: Bool {
    RawWhileStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asWhileStmt: WhileStmtSyntax? {
    isWhileStmt ? WhileStmtSyntax(data: syntax.data) : nil
  }

  public var isDeferStmt: Bool {
    RawDeferStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeferStmt: DeferStmtSyntax? {
    isDeferStmt ? DeferStmtSyntax(data: syntax.data) : nil
  }

  public var isExpressionStmt: Bool {
    RawExpressionStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asExpressionStmt: ExpressionStmtSyntax? {
    isExpressionStmt ? ExpressionStmtSyntax(data: syntax.data) : nil
  }

  public var isSwitchCaseList: Bool {
    RawSwitchCaseListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSwitchCaseList: SwitchCaseListSyntax? {
    isSwitchCaseList ? SwitchCaseListSyntax(data: syntax.data) : nil
  }

  public var isRepeatWhileStmt: Bool {
    RawRepeatWhileStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asRepeatWhileStmt: RepeatWhileStmtSyntax? {
    isRepeatWhileStmt ? RepeatWhileStmtSyntax(data: syntax.data) : nil
  }

  public var isGuardStmt: Bool {
    RawGuardStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGuardStmt: GuardStmtSyntax? {
    isGuardStmt ? GuardStmtSyntax(data: syntax.data) : nil
  }

  public var isWhereClause: Bool {
    RawWhereClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asWhereClause: WhereClauseSyntax? {
    isWhereClause ? WhereClauseSyntax(data: syntax.data) : nil
  }

  public var isForInStmt: Bool {
    RawForInStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asForInStmt: ForInStmtSyntax? {
    isForInStmt ? ForInStmtSyntax(data: syntax.data) : nil
  }

  public var isSwitchStmt: Bool {
    RawSwitchStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSwitchStmt: SwitchStmtSyntax? {
    isSwitchStmt ? SwitchStmtSyntax(data: syntax.data) : nil
  }

  public var isCatchClauseList: Bool {
    RawCatchClauseListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCatchClauseList: CatchClauseListSyntax? {
    isCatchClauseList ? CatchClauseListSyntax(data: syntax.data) : nil
  }

  public var isDoStmt: Bool {
    RawDoStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDoStmt: DoStmtSyntax? {
    isDoStmt ? DoStmtSyntax(data: syntax.data) : nil
  }

  public var isReturnStmt: Bool {
    RawReturnStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asReturnStmt: ReturnStmtSyntax? {
    isReturnStmt ? ReturnStmtSyntax(data: syntax.data) : nil
  }

  public var isYieldStmt: Bool {
    RawYieldStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asYieldStmt: YieldStmtSyntax? {
    isYieldStmt ? YieldStmtSyntax(data: syntax.data) : nil
  }

  public var isYieldList: Bool {
    RawYieldListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asYieldList: YieldListSyntax? {
    isYieldList ? YieldListSyntax(data: syntax.data) : nil
  }

  public var isFallthroughStmt: Bool {
    RawFallthroughStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFallthroughStmt: FallthroughStmtSyntax? {
    isFallthroughStmt ? FallthroughStmtSyntax(data: syntax.data) : nil
  }

  public var isBreakStmt: Bool {
    RawBreakStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asBreakStmt: BreakStmtSyntax? {
    isBreakStmt ? BreakStmtSyntax(data: syntax.data) : nil
  }

  public var isCaseItemList: Bool {
    RawCaseItemListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCaseItemList: CaseItemListSyntax? {
    isCaseItemList ? CaseItemListSyntax(data: syntax.data) : nil
  }

  public var isCatchItemList: Bool {
    RawCatchItemListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCatchItemList: CatchItemListSyntax? {
    isCatchItemList ? CatchItemListSyntax(data: syntax.data) : nil
  }

  public var isConditionElement: Bool {
    RawConditionElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asConditionElement: ConditionElementSyntax? {
    isConditionElement ? ConditionElementSyntax(data: syntax.data) : nil
  }

  public var isAvailabilityCondition: Bool {
    RawAvailabilityConditionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAvailabilityCondition: AvailabilityConditionSyntax? {
    isAvailabilityCondition ? AvailabilityConditionSyntax(data: syntax.data) : nil
  }

  public var isMatchingPatternCondition: Bool {
    RawMatchingPatternConditionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMatchingPatternCondition: MatchingPatternConditionSyntax? {
    isMatchingPatternCondition ? MatchingPatternConditionSyntax(data: syntax.data) : nil
  }

  public var isOptionalBindingCondition: Bool {
    RawOptionalBindingConditionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asOptionalBindingCondition: OptionalBindingConditionSyntax? {
    isOptionalBindingCondition ? OptionalBindingConditionSyntax(data: syntax.data) : nil
  }

  public var isUnavailabilityCondition: Bool {
    RawUnavailabilityConditionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asUnavailabilityCondition: UnavailabilityConditionSyntax? {
    isUnavailabilityCondition ? UnavailabilityConditionSyntax(data: syntax.data) : nil
  }

  public var isConditionElementList: Bool {
    RawConditionElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asConditionElementList: ConditionElementListSyntax? {
    isConditionElementList ? ConditionElementListSyntax(data: syntax.data) : nil
  }

  public var isDeclarationStmt: Bool {
    RawDeclarationStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDeclarationStmt: DeclarationStmtSyntax? {
    isDeclarationStmt ? DeclarationStmtSyntax(data: syntax.data) : nil
  }

  public var isThrowStmt: Bool {
    RawThrowStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asThrowStmt: ThrowStmtSyntax? {
    isThrowStmt ? ThrowStmtSyntax(data: syntax.data) : nil
  }

  public var isIfStmt: Bool {
    RawIfStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIfStmt: IfStmtSyntax? {
    isIfStmt ? IfStmtSyntax(data: syntax.data) : nil
  }

  public var isElseIfContinuation: Bool {
    RawElseIfContinuationSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asElseIfContinuation: ElseIfContinuationSyntax? {
    isElseIfContinuation ? ElseIfContinuationSyntax(data: syntax.data) : nil
  }

  public var isElseBlock: Bool {
    RawElseBlockSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asElseBlock: ElseBlockSyntax? {
    isElseBlock ? ElseBlockSyntax(data: syntax.data) : nil
  }

  public var isSwitchCase: Bool {
    RawSwitchCaseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSwitchCase: SwitchCaseSyntax? {
    isSwitchCase ? SwitchCaseSyntax(data: syntax.data) : nil
  }

  public var isSwitchDefaultLabel: Bool {
    RawSwitchDefaultLabelSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSwitchDefaultLabel: SwitchDefaultLabelSyntax? {
    isSwitchDefaultLabel ? SwitchDefaultLabelSyntax(data: syntax.data) : nil
  }

  public var isCaseItem: Bool {
    RawCaseItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCaseItem: CaseItemSyntax? {
    isCaseItem ? CaseItemSyntax(data: syntax.data) : nil
  }

  public var isCatchItem: Bool {
    RawCatchItemSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCatchItem: CatchItemSyntax? {
    isCatchItem ? CatchItemSyntax(data: syntax.data) : nil
  }

  public var isSwitchCaseLabel: Bool {
    RawSwitchCaseLabelSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSwitchCaseLabel: SwitchCaseLabelSyntax? {
    isSwitchCaseLabel ? SwitchCaseLabelSyntax(data: syntax.data) : nil
  }

  public var isCatchClause: Bool {
    RawCatchClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCatchClause: CatchClauseSyntax? {
    isCatchClause ? CatchClauseSyntax(data: syntax.data) : nil
  }

  public var isPoundAssertStmt: Bool {
    RawPoundAssertStmtSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPoundAssertStmt: PoundAssertStmtSyntax? {
    isPoundAssertStmt ? PoundAssertStmtSyntax(data: syntax.data) : nil
  }

  public var isGenericWhereClause: Bool {
    RawGenericWhereClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericWhereClause: GenericWhereClauseSyntax? {
    isGenericWhereClause ? GenericWhereClauseSyntax(data: syntax.data) : nil
  }

  public var isGenericRequirementList: Bool {
    RawGenericRequirementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericRequirementList: GenericRequirementListSyntax? {
    isGenericRequirementList ? GenericRequirementListSyntax(data: syntax.data) : nil
  }

  public var isGenericRequirement: Bool {
    RawGenericRequirementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericRequirement: GenericRequirementSyntax? {
    isGenericRequirement ? GenericRequirementSyntax(data: syntax.data) : nil
  }

  public var isSameTypeRequirement: Bool {
    RawSameTypeRequirementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSameTypeRequirement: SameTypeRequirementSyntax? {
    isSameTypeRequirement ? SameTypeRequirementSyntax(data: syntax.data) : nil
  }

  public var isGenericParameterList: Bool {
    RawGenericParameterListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericParameterList: GenericParameterListSyntax? {
    isGenericParameterList ? GenericParameterListSyntax(data: syntax.data) : nil
  }

  public var isGenericParameter: Bool {
    RawGenericParameterSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericParameter: GenericParameterSyntax? {
    isGenericParameter ? GenericParameterSyntax(data: syntax.data) : nil
  }

  public var isPrimaryAssociatedTypeList: Bool {
    RawPrimaryAssociatedTypeListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrimaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax? {
    isPrimaryAssociatedTypeList ? PrimaryAssociatedTypeListSyntax(data: syntax.data) : nil
  }

  public var isPrimaryAssociatedType: Bool {
    RawPrimaryAssociatedTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrimaryAssociatedType: PrimaryAssociatedTypeSyntax? {
    isPrimaryAssociatedType ? PrimaryAssociatedTypeSyntax(data: syntax.data) : nil
  }

  public var isGenericParameterClause: Bool {
    RawGenericParameterClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericParameterClause: GenericParameterClauseSyntax? {
    isGenericParameterClause ? GenericParameterClauseSyntax(data: syntax.data) : nil
  }

  public var isConformanceRequirement: Bool {
    RawConformanceRequirementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asConformanceRequirement: ConformanceRequirementSyntax? {
    isConformanceRequirement ? ConformanceRequirementSyntax(data: syntax.data) : nil
  }

  public var isPrimaryAssociatedTypeClause: Bool {
    RawPrimaryAssociatedTypeClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asPrimaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax? {
    isPrimaryAssociatedTypeClause ? PrimaryAssociatedTypeClauseSyntax(data: syntax.data) : nil
  }

  public var isSimpleTypeIdentifier: Bool {
    RawSimpleTypeIdentifierSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asSimpleTypeIdentifier: SimpleTypeIdentifierSyntax? {
    isSimpleTypeIdentifier ? SimpleTypeIdentifierSyntax(data: syntax.data) : nil
  }

  public var isMemberTypeIdentifier: Bool {
    RawMemberTypeIdentifierSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMemberTypeIdentifier: MemberTypeIdentifierSyntax? {
    isMemberTypeIdentifier ? MemberTypeIdentifierSyntax(data: syntax.data) : nil
  }

  public var isClassRestrictionType: Bool {
    RawClassRestrictionTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asClassRestrictionType: ClassRestrictionTypeSyntax? {
    isClassRestrictionType ? ClassRestrictionTypeSyntax(data: syntax.data) : nil
  }

  public var isArrayType: Bool {
    RawArrayTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asArrayType: ArrayTypeSyntax? {
    isArrayType ? ArrayTypeSyntax(data: syntax.data) : nil
  }

  public var isDictionaryType: Bool {
    RawDictionaryTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asDictionaryType: DictionaryTypeSyntax? {
    isDictionaryType ? DictionaryTypeSyntax(data: syntax.data) : nil
  }

  public var isMetatypeType: Bool {
    RawMetatypeTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asMetatypeType: MetatypeTypeSyntax? {
    isMetatypeType ? MetatypeTypeSyntax(data: syntax.data) : nil
  }

  public var isOptionalType: Bool {
    RawOptionalTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asOptionalType: OptionalTypeSyntax? {
    isOptionalType ? OptionalTypeSyntax(data: syntax.data) : nil
  }

  public var isConstrainedSugarType: Bool {
    RawConstrainedSugarTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asConstrainedSugarType: ConstrainedSugarTypeSyntax? {
    isConstrainedSugarType ? ConstrainedSugarTypeSyntax(data: syntax.data) : nil
  }

  public var isImplicitlyUnwrappedOptionalType: Bool {
    RawImplicitlyUnwrappedOptionalTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asImplicitlyUnwrappedOptionalType: ImplicitlyUnwrappedOptionalTypeSyntax? {
    isImplicitlyUnwrappedOptionalType ? ImplicitlyUnwrappedOptionalTypeSyntax(data: syntax.data) : nil
  }

  public var isCompositionTypeElement: Bool {
    RawCompositionTypeElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCompositionTypeElement: CompositionTypeElementSyntax? {
    isCompositionTypeElement ? CompositionTypeElementSyntax(data: syntax.data) : nil
  }

  public var isCompositionTypeElementList: Bool {
    RawCompositionTypeElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCompositionTypeElementList: CompositionTypeElementListSyntax? {
    isCompositionTypeElementList ? CompositionTypeElementListSyntax(data: syntax.data) : nil
  }

  public var isCompositionType: Bool {
    RawCompositionTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asCompositionType: CompositionTypeSyntax? {
    isCompositionType ? CompositionTypeSyntax(data: syntax.data) : nil
  }

  public var isTupleTypeElement: Bool {
    RawTupleTypeElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTupleTypeElement: TupleTypeElementSyntax? {
    isTupleTypeElement ? TupleTypeElementSyntax(data: syntax.data) : nil
  }

  public var isTupleTypeElementList: Bool {
    RawTupleTypeElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTupleTypeElementList: TupleTypeElementListSyntax? {
    isTupleTypeElementList ? TupleTypeElementListSyntax(data: syntax.data) : nil
  }

  public var isTupleType: Bool {
    RawTupleTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTupleType: TupleTypeSyntax? {
    isTupleType ? TupleTypeSyntax(data: syntax.data) : nil
  }

  public var isFunctionType: Bool {
    RawFunctionTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asFunctionType: FunctionTypeSyntax? {
    isFunctionType ? FunctionTypeSyntax(data: syntax.data) : nil
  }

  public var isAttributedType: Bool {
    RawAttributedTypeSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAttributedType: AttributedTypeSyntax? {
    isAttributedType ? AttributedTypeSyntax(data: syntax.data) : nil
  }

  public var isGenericArgumentList: Bool {
    RawGenericArgumentListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericArgumentList: GenericArgumentListSyntax? {
    isGenericArgumentList ? GenericArgumentListSyntax(data: syntax.data) : nil
  }

  public var isGenericArgument: Bool {
    RawGenericArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericArgument: GenericArgumentSyntax? {
    isGenericArgument ? GenericArgumentSyntax(data: syntax.data) : nil
  }

  public var isGenericArgumentClause: Bool {
    RawGenericArgumentClauseSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asGenericArgumentClause: GenericArgumentClauseSyntax? {
    isGenericArgumentClause ? GenericArgumentClauseSyntax(data: syntax.data) : nil
  }

  public var isTypeAnnotation: Bool {
    RawTypeAnnotationSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTypeAnnotation: TypeAnnotationSyntax? {
    isTypeAnnotation ? TypeAnnotationSyntax(data: syntax.data) : nil
  }

  public var isEnumCasePattern: Bool {
    RawEnumCasePatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asEnumCasePattern: EnumCasePatternSyntax? {
    isEnumCasePattern ? EnumCasePatternSyntax(data: syntax.data) : nil
  }

  public var isIsTypePattern: Bool {
    RawIsTypePatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIsTypePattern: IsTypePatternSyntax? {
    isIsTypePattern ? IsTypePatternSyntax(data: syntax.data) : nil
  }

  public var isOptionalPattern: Bool {
    RawOptionalPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asOptionalPattern: OptionalPatternSyntax? {
    isOptionalPattern ? OptionalPatternSyntax(data: syntax.data) : nil
  }

  public var isIdentifierPattern: Bool {
    RawIdentifierPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asIdentifierPattern: IdentifierPatternSyntax? {
    isIdentifierPattern ? IdentifierPatternSyntax(data: syntax.data) : nil
  }

  public var isAsTypePattern: Bool {
    RawAsTypePatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAsTypePattern: AsTypePatternSyntax? {
    isAsTypePattern ? AsTypePatternSyntax(data: syntax.data) : nil
  }

  public var isTuplePattern: Bool {
    RawTuplePatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTuplePattern: TuplePatternSyntax? {
    isTuplePattern ? TuplePatternSyntax(data: syntax.data) : nil
  }

  public var isWildcardPattern: Bool {
    RawWildcardPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asWildcardPattern: WildcardPatternSyntax? {
    isWildcardPattern ? WildcardPatternSyntax(data: syntax.data) : nil
  }

  public var isTuplePatternElement: Bool {
    RawTuplePatternElementSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTuplePatternElement: TuplePatternElementSyntax? {
    isTuplePatternElement ? TuplePatternElementSyntax(data: syntax.data) : nil
  }

  public var isExpressionPattern: Bool {
    RawExpressionPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asExpressionPattern: ExpressionPatternSyntax? {
    isExpressionPattern ? ExpressionPatternSyntax(data: syntax.data) : nil
  }

  public var isTuplePatternElementList: Bool {
    RawTuplePatternElementListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asTuplePatternElementList: TuplePatternElementListSyntax? {
    isTuplePatternElementList ? TuplePatternElementListSyntax(data: syntax.data) : nil
  }

  public var isValueBindingPattern: Bool {
    RawValueBindingPatternSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asValueBindingPattern: ValueBindingPatternSyntax? {
    isValueBindingPattern ? ValueBindingPatternSyntax(data: syntax.data) : nil
  }

  public var isAvailabilitySpecList: Bool {
    RawAvailabilitySpecListSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAvailabilitySpecList: AvailabilitySpecListSyntax? {
    isAvailabilitySpecList ? AvailabilitySpecListSyntax(data: syntax.data) : nil
  }

  public var isAvailabilityArgument: Bool {
    RawAvailabilityArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAvailabilityArgument: AvailabilityArgumentSyntax? {
    isAvailabilityArgument ? AvailabilityArgumentSyntax(data: syntax.data) : nil
  }

  public var isAvailabilityLabeledArgument: Bool {
    RawAvailabilityLabeledArgumentSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAvailabilityLabeledArgument: AvailabilityLabeledArgumentSyntax? {
    isAvailabilityLabeledArgument ? AvailabilityLabeledArgumentSyntax(data: syntax.data) : nil
  }

  public var isAvailabilityVersionRestriction: Bool {
    RawAvailabilityVersionRestrictionSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asAvailabilityVersionRestriction: AvailabilityVersionRestrictionSyntax? {
    isAvailabilityVersionRestriction ? AvailabilityVersionRestrictionSyntax(data: syntax.data) : nil
  }

  public var isVersionTuple: Bool {
    RawVersionTupleSyntax.isValid(syntaxKind: syntaxKind)
  }
  public var asVersionTuple: VersionTupleSyntax? {
    isVersionTuple ? VersionTupleSyntax(data: syntax.data) : nil
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
    case .token(let node): return node
    case .unknown(let node): return node
    case .decl(let node): return node
    case .expr(let node): return node
    case .stmt(let node): return node
    case .type(let node): return node
    case .pattern(let node): return node
    case .unknownDecl(let node): return node
    case .unknownExpr(let node): return node
    case .unknownStmt(let node): return node
    case .unknownType(let node): return node
    case .unknownPattern(let node): return node
    case .codeBlockItem(let node): return node
    case .codeBlockItemList(let node): return node
    case .codeBlock(let node): return node
    case .inOutExpr(let node): return node
    case .poundColumnExpr(let node): return node
    case .tupleExprElementList(let node): return node
    case .arrayElementList(let node): return node
    case .dictionaryElementList(let node): return node
    case .stringLiteralSegments(let node): return node
    case .tryExpr(let node): return node
    case .awaitExpr(let node): return node
    case .declNameArgument(let node): return node
    case .declNameArgumentList(let node): return node
    case .declNameArguments(let node): return node
    case .identifierExpr(let node): return node
    case .superRefExpr(let node): return node
    case .nilLiteralExpr(let node): return node
    case .discardAssignmentExpr(let node): return node
    case .assignmentExpr(let node): return node
    case .sequenceExpr(let node): return node
    case .exprList(let node): return node
    case .poundLineExpr(let node): return node
    case .poundFileExpr(let node): return node
    case .poundFileIDExpr(let node): return node
    case .poundFilePathExpr(let node): return node
    case .poundFunctionExpr(let node): return node
    case .poundDsohandleExpr(let node): return node
    case .symbolicReferenceExpr(let node): return node
    case .prefixOperatorExpr(let node): return node
    case .binaryOperatorExpr(let node): return node
    case .arrowExpr(let node): return node
    case .floatLiteralExpr(let node): return node
    case .tupleExpr(let node): return node
    case .arrayExpr(let node): return node
    case .dictionaryExpr(let node): return node
    case .tupleExprElement(let node): return node
    case .arrayElement(let node): return node
    case .dictionaryElement(let node): return node
    case .integerLiteralExpr(let node): return node
    case .booleanLiteralExpr(let node): return node
    case .ternaryExpr(let node): return node
    case .memberAccessExpr(let node): return node
    case .isExpr(let node): return node
    case .asExpr(let node): return node
    case .typeExpr(let node): return node
    case .closureCaptureItem(let node): return node
    case .closureCaptureItemList(let node): return node
    case .closureCaptureSignature(let node): return node
    case .closureParam(let node): return node
    case .closureParamList(let node): return node
    case .closureSignature(let node): return node
    case .closureExpr(let node): return node
    case .unresolvedPatternExpr(let node): return node
    case .multipleTrailingClosureElement(let node): return node
    case .multipleTrailingClosureElementList(let node): return node
    case .functionCallExpr(let node): return node
    case .subscriptExpr(let node): return node
    case .optionalChainingExpr(let node): return node
    case .forcedValueExpr(let node): return node
    case .postfixUnaryExpr(let node): return node
    case .specializeExpr(let node): return node
    case .stringSegment(let node): return node
    case .expressionSegment(let node): return node
    case .stringLiteralExpr(let node): return node
    case .regexLiteralExpr(let node): return node
    case .keyPathExpr(let node): return node
    case .keyPathBaseExpr(let node): return node
    case .objcNamePiece(let node): return node
    case .objcName(let node): return node
    case .objcKeyPathExpr(let node): return node
    case .objcSelectorExpr(let node): return node
    case .postfixIfConfigExpr(let node): return node
    case .editorPlaceholderExpr(let node): return node
    case .objectLiteralExpr(let node): return node
    case .typeInitializerClause(let node): return node
    case .typealiasDecl(let node): return node
    case .associatedtypeDecl(let node): return node
    case .functionParameterList(let node): return node
    case .parameterClause(let node): return node
    case .returnClause(let node): return node
    case .functionSignature(let node): return node
    case .ifConfigClause(let node): return node
    case .ifConfigClauseList(let node): return node
    case .ifConfigDecl(let node): return node
    case .poundErrorDecl(let node): return node
    case .poundWarningDecl(let node): return node
    case .poundSourceLocation(let node): return node
    case .poundSourceLocationArgs(let node): return node
    case .declModifierDetail(let node): return node
    case .declModifier(let node): return node
    case .inheritedType(let node): return node
    case .inheritedTypeList(let node): return node
    case .typeInheritanceClause(let node): return node
    case .classDecl(let node): return node
    case .actorDecl(let node): return node
    case .structDecl(let node): return node
    case .protocolDecl(let node): return node
    case .extensionDecl(let node): return node
    case .memberDeclBlock(let node): return node
    case .memberDeclList(let node): return node
    case .memberDeclListItem(let node): return node
    case .sourceFile(let node): return node
    case .initializerClause(let node): return node
    case .functionParameter(let node): return node
    case .modifierList(let node): return node
    case .functionDecl(let node): return node
    case .initializerDecl(let node): return node
    case .deinitializerDecl(let node): return node
    case .subscriptDecl(let node): return node
    case .accessLevelModifier(let node): return node
    case .accessPathComponent(let node): return node
    case .accessPath(let node): return node
    case .importDecl(let node): return node
    case .accessorParameter(let node): return node
    case .accessorDecl(let node): return node
    case .accessorList(let node): return node
    case .accessorBlock(let node): return node
    case .patternBinding(let node): return node
    case .patternBindingList(let node): return node
    case .variableDecl(let node): return node
    case .enumCaseElement(let node): return node
    case .enumCaseElementList(let node): return node
    case .enumCaseDecl(let node): return node
    case .enumDecl(let node): return node
    case .operatorDecl(let node): return node
    case .identifierList(let node): return node
    case .operatorPrecedenceAndTypes(let node): return node
    case .precedenceGroupDecl(let node): return node
    case .precedenceGroupAttributeList(let node): return node
    case .precedenceGroupRelation(let node): return node
    case .precedenceGroupNameList(let node): return node
    case .precedenceGroupNameElement(let node): return node
    case .precedenceGroupAssignment(let node): return node
    case .precedenceGroupAssociativity(let node): return node
    case .tokenList(let node): return node
    case .nonEmptyTokenList(let node): return node
    case .customAttribute(let node): return node
    case .attribute(let node): return node
    case .attributeList(let node): return node
    case .specializeAttributeSpecList(let node): return node
    case .availabilityEntry(let node): return node
    case .labeledSpecializeEntry(let node): return node
    case .targetFunctionEntry(let node): return node
    case .namedAttributeStringArgument(let node): return node
    case .declName(let node): return node
    case .implementsAttributeArguments(let node): return node
    case .objCSelectorPiece(let node): return node
    case .objCSelector(let node): return node
    case .differentiableAttributeArguments(let node): return node
    case .differentiabilityParamsClause(let node): return node
    case .differentiabilityParams(let node): return node
    case .differentiabilityParamList(let node): return node
    case .differentiabilityParam(let node): return node
    case .derivativeRegistrationAttributeArguments(let node): return node
    case .qualifiedDeclName(let node): return node
    case .functionDeclName(let node): return node
    case .backDeployAttributeSpecList(let node): return node
    case .backDeployVersionList(let node): return node
    case .backDeployVersionArgument(let node): return node
    case .continueStmt(let node): return node
    case .whileStmt(let node): return node
    case .deferStmt(let node): return node
    case .expressionStmt(let node): return node
    case .switchCaseList(let node): return node
    case .repeatWhileStmt(let node): return node
    case .guardStmt(let node): return node
    case .whereClause(let node): return node
    case .forInStmt(let node): return node
    case .switchStmt(let node): return node
    case .catchClauseList(let node): return node
    case .doStmt(let node): return node
    case .returnStmt(let node): return node
    case .yieldStmt(let node): return node
    case .yieldList(let node): return node
    case .fallthroughStmt(let node): return node
    case .breakStmt(let node): return node
    case .caseItemList(let node): return node
    case .catchItemList(let node): return node
    case .conditionElement(let node): return node
    case .availabilityCondition(let node): return node
    case .matchingPatternCondition(let node): return node
    case .optionalBindingCondition(let node): return node
    case .unavailabilityCondition(let node): return node
    case .conditionElementList(let node): return node
    case .declarationStmt(let node): return node
    case .throwStmt(let node): return node
    case .ifStmt(let node): return node
    case .elseIfContinuation(let node): return node
    case .elseBlock(let node): return node
    case .switchCase(let node): return node
    case .switchDefaultLabel(let node): return node
    case .caseItem(let node): return node
    case .catchItem(let node): return node
    case .switchCaseLabel(let node): return node
    case .catchClause(let node): return node
    case .poundAssertStmt(let node): return node
    case .genericWhereClause(let node): return node
    case .genericRequirementList(let node): return node
    case .genericRequirement(let node): return node
    case .sameTypeRequirement(let node): return node
    case .genericParameterList(let node): return node
    case .genericParameter(let node): return node
    case .primaryAssociatedTypeList(let node): return node
    case .primaryAssociatedType(let node): return node
    case .genericParameterClause(let node): return node
    case .conformanceRequirement(let node): return node
    case .primaryAssociatedTypeClause(let node): return node
    case .simpleTypeIdentifier(let node): return node
    case .memberTypeIdentifier(let node): return node
    case .classRestrictionType(let node): return node
    case .arrayType(let node): return node
    case .dictionaryType(let node): return node
    case .metatypeType(let node): return node
    case .optionalType(let node): return node
    case .constrainedSugarType(let node): return node
    case .implicitlyUnwrappedOptionalType(let node): return node
    case .compositionTypeElement(let node): return node
    case .compositionTypeElementList(let node): return node
    case .compositionType(let node): return node
    case .tupleTypeElement(let node): return node
    case .tupleTypeElementList(let node): return node
    case .tupleType(let node): return node
    case .functionType(let node): return node
    case .attributedType(let node): return node
    case .genericArgumentList(let node): return node
    case .genericArgument(let node): return node
    case .genericArgumentClause(let node): return node
    case .typeAnnotation(let node): return node
    case .enumCasePattern(let node): return node
    case .isTypePattern(let node): return node
    case .optionalPattern(let node): return node
    case .identifierPattern(let node): return node
    case .asTypePattern(let node): return node
    case .tuplePattern(let node): return node
    case .wildcardPattern(let node): return node
    case .tuplePatternElement(let node): return node
    case .expressionPattern(let node): return node
    case .tuplePatternElementList(let node): return node
    case .valueBindingPattern(let node): return node
    case .availabilitySpecList(let node): return node
    case .availabilityArgument(let node): return node
    case .availabilityLabeledArgument(let node): return node
    case .availabilityVersionRestriction(let node): return node
    case .versionTuple(let node): return node
    }
  }
}
