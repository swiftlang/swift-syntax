//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxValidation.swift - Layout validation --------------===//
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


/// Check that the `layout` is valid for the given 'SyntaxKind'.
///
/// Note that this only validates the immediate children.
/// Results in an assertion failure if the layout is invalid.
func validateLayout(layout: RawSyntaxBuffer, as kind: SyntaxKind) {
#if DEBUG
  switch kind {
  case .unknown:
    break
  case .token:
    assertionFailure("validateLayout for .token kind is not supported")
  case .decl:
    break
  case .expr:
    break
  case .stmt:
    break
  case .type:
    break
  case .pattern:
    break
  case .unknownDecl:
    break
  case .unknownExpr:
    break
  case .unknownStmt:
    break
  case .unknownType:
    break
  case .unknownPattern:
    break
  case .codeBlockItem:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .codeBlockItemList:
    for element in layout {
      assert(element != nil)
      assert(RawCodeBlockItemSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .codeBlock:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawCodeBlockItemListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .inOutExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundColumnExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tupleExprElementList:
    for element in layout {
      assert(element != nil)
      assert(RawTupleExprElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .arrayElementList:
    for element in layout {
      assert(element != nil)
      assert(RawArrayElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .dictionaryElementList:
    for element in layout {
      assert(element != nil)
      assert(RawDictionaryElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .stringLiteralSegments:
    for element in layout {
      assert(element != nil)
      assert(RawSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .tryExpr:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .awaitExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .declNameArgument:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .declNameArgumentList:
    for element in layout {
      assert(element != nil)
      assert(RawDeclNameArgumentSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .declNameArguments:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawDeclNameArgumentListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .identifierExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawDeclNameArgumentsSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .superRefExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .nilLiteralExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .discardAssignmentExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .assignmentExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .sequenceExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .exprList:
    for element in layout {
      assert(element != nil)
      assert(RawExprSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .poundLineExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundFileExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundFileIDExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundFilePathExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundFunctionExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundDsohandleExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .symbolicReferenceExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawGenericArgumentClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .prefixOperatorExpr:
    assert(layout.count == 2)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .binaryOperatorExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .arrowExpr:
    assert(layout.count == 3)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .floatLiteralExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tupleExpr:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTupleExprElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .arrayExpr:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawArrayElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .dictionaryExpr:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tupleExprElement:
    assert(layout.count == 4)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .arrayElement:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .dictionaryElement:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .integerLiteralExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .booleanLiteralExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .ternaryExpr:
    assert(layout.count == 5)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .memberAccessExpr:
    assert(layout.count == 4)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawDeclNameArgumentsSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .isExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .asExpr:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .typeExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .closureCaptureItem:
    assert(layout.count == 5)
    layout[0].map { child in
      assert(RawTokenListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .closureCaptureItemList:
    for element in layout {
      assert(element != nil)
      assert(RawClosureCaptureItemSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .closureCaptureSignature:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawClosureCaptureItemListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .closureParam:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .closureParamList:
    for element in layout {
      assert(element != nil)
      assert(RawClosureParamSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .closureSignature:
    assert(layout.count == 7)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawClosureCaptureSignatureSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawReturnClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[6] != nil)
    layout[6].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .closureExpr:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawClosureSignatureSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawCodeBlockItemListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .unresolvedPatternExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .multipleTrailingClosureElement:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawClosureExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .multipleTrailingClosureElementList:
    for element in layout {
      assert(element != nil)
      assert(RawMultipleTrailingClosureElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .functionCallExpr:
    assert(layout.count == 6)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTupleExprElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawClosureExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawMultipleTrailingClosureElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .subscriptExpr:
    assert(layout.count == 6)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTupleExprElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawClosureExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawMultipleTrailingClosureElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .optionalChainingExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .forcedValueExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .postfixUnaryExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .specializeExpr:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawGenericArgumentClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .stringSegment:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .expressionSegment:
    assert(layout.count == 5)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTupleExprElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .stringLiteralExpr:
    assert(layout.count == 5)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawStringLiteralSegmentsSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .regexLiteralExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .keyPathExpr:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .keyPathBaseExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .objcNamePiece:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .objcName:
    for element in layout {
      assert(element != nil)
      assert(RawObjcNamePieceSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .objcKeyPathExpr:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawObjcNameSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .objcSelectorExpr:
    assert(layout.count == 6)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .postfixIfConfigExpr:
    assert(layout.count == 2)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawIfConfigDeclSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .editorPlaceholderExpr:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .objectLiteralExpr:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTupleExprElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .typeInitializerClause:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .typealiasDecl:
    assert(layout.count == 7)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawGenericParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawTypeInitializerClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .associatedtypeDecl:
    assert(layout.count == 7)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTypeInheritanceClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTypeInitializerClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .functionParameterList:
    for element in layout {
      assert(element != nil)
      assert(RawFunctionParameterSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .parameterClause:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawFunctionParameterListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .returnClause:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .functionSignature:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawReturnClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .ifConfigClause:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .ifConfigClauseList:
    for element in layout {
      assert(element != nil)
      assert(RawIfConfigClauseSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .ifConfigDecl:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawIfConfigClauseListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundErrorDecl:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawStringLiteralExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundWarningDecl:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawStringLiteralExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundSourceLocation:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawPoundSourceLocationArgsSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundSourceLocationArgs:
    assert(layout.count == 7)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[6] != nil)
    layout[6].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .declModifierDetail:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .declModifier:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawDeclModifierDetailSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .inheritedType:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .inheritedTypeList:
    for element in layout {
      assert(element != nil)
      assert(RawInheritedTypeSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .typeInheritanceClause:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawInheritedTypeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .classDecl:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawGenericParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTypeInheritanceClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[7] != nil)
    layout[7].map { child in
      assert(RawMemberDeclBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .actorDecl:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawGenericParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTypeInheritanceClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[7] != nil)
    layout[7].map { child in
      assert(RawMemberDeclBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .structDecl:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawGenericParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTypeInheritanceClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[7] != nil)
    layout[7].map { child in
      assert(RawMemberDeclBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .protocolDecl:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawPrimaryAssociatedTypeClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTypeInheritanceClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[7] != nil)
    layout[7].map { child in
      assert(RawMemberDeclBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .extensionDecl:
    assert(layout.count == 7)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTypeInheritanceClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[6] != nil)
    layout[6].map { child in
      assert(RawMemberDeclBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .memberDeclBlock:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawMemberDeclListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .memberDeclList:
    for element in layout {
      assert(element != nil)
      assert(RawMemberDeclListItemSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .memberDeclListItem:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawDeclSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .sourceFile:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawCodeBlockItemListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .initializerClause:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .functionParameter:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawInitializerClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[7].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .modifierList:
    for element in layout {
      assert(element != nil)
      assert(RawDeclModifierSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .functionDecl:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawGenericParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawFunctionSignatureSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[7].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .initializerDecl:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawGenericParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawFunctionSignatureSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[7].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .deinitializerDecl:
    assert(layout.count == 4)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .subscriptDecl:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawGenericParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawReturnClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[7].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .accessLevelModifier:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawDeclModifierDetailSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .accessPathComponent:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .accessPath:
    for element in layout {
      assert(element != nil)
      assert(RawAccessPathComponentSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .importDecl:
    assert(layout.count == 5)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawAccessPathSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .accessorParameter:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .accessorDecl:
    assert(layout.count == 7)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawDeclModifierSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawAccessorParameterSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .accessorList:
    for element in layout {
      assert(element != nil)
      assert(RawAccessorDeclSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .accessorBlock:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawAccessorListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .patternBinding:
    assert(layout.count == 5)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTypeAnnotationSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawInitializerClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .patternBindingList:
    for element in layout {
      assert(element != nil)
      assert(RawPatternBindingSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .variableDecl:
    assert(layout.count == 4)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawPatternBindingListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .enumCaseElement:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawInitializerClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .enumCaseElementList:
    for element in layout {
      assert(element != nil)
      assert(RawEnumCaseElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .enumCaseDecl:
    assert(layout.count == 4)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawEnumCaseElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .enumDecl:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawGenericParameterClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTypeInheritanceClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[7] != nil)
    layout[7].map { child in
      assert(RawMemberDeclBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .operatorDecl:
    assert(layout.count == 5)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawOperatorPrecedenceAndTypesSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .identifierList:
    for element in layout {
      assert(element != nil)
      assert(RawTokenSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .operatorPrecedenceAndTypes:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawIdentifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .precedenceGroupDecl:
    assert(layout.count == 7)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawModifierListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawPrecedenceGroupAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[6] != nil)
    layout[6].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .precedenceGroupAttributeList:
    for element in layout {
      assert(element != nil)
      assert(RawSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .precedenceGroupRelation:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawPrecedenceGroupNameListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .precedenceGroupNameList:
    for element in layout {
      assert(element != nil)
      assert(RawPrecedenceGroupNameElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .precedenceGroupNameElement:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .precedenceGroupAssignment:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .precedenceGroupAssociativity:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tokenList:
    for element in layout {
      assert(element != nil)
      assert(RawTokenSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .nonEmptyTokenList:
    for element in layout {
      assert(element != nil)
      assert(RawTokenSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .customAttribute:
    assert(layout.count == 5)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTupleExprElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .attribute:
    assert(layout.count == 6)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTokenListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .attributeList:
    for element in layout {
      assert(element != nil)
      assert(RawSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .specializeAttributeSpecList:
    for element in layout {
      assert(element != nil)
      assert(RawSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .availabilityEntry:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawAvailabilitySpecListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .labeledSpecializeEntry:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .targetFunctionEntry:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawDeclNameSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .namedAttributeStringArgument:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .declName:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawDeclNameArgumentsSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .implementsAttributeArguments:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSimpleTypeIdentifierSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawDeclNameArgumentsSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .objCSelectorPiece:
    assert(layout.count == 2)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .objCSelector:
    for element in layout {
      assert(element != nil)
      assert(RawObjCSelectorPieceSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .differentiableAttributeArguments:
    assert(layout.count == 5)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawDifferentiabilityParamsClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawGenericWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .differentiabilityParamsClause:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .differentiabilityParams:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawDifferentiabilityParamListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .differentiabilityParamList:
    for element in layout {
      assert(element != nil)
      assert(RawDifferentiabilityParamSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .differentiabilityParam:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .derivativeRegistrationAttributeArguments:
    assert(layout.count == 7)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawQualifiedDeclNameSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawDifferentiabilityParamsClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .qualifiedDeclName:
    assert(layout.count == 4)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawDeclNameArgumentsSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .functionDeclName:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawDeclNameArgumentsSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .backDeployAttributeSpecList:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawBackDeployVersionListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .backDeployVersionList:
    for element in layout {
      assert(element != nil)
      assert(RawBackDeployVersionArgumentSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .backDeployVersionArgument:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawAvailabilityVersionRestrictionSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .continueStmt:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .whileStmt:
    assert(layout.count == 5)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawConditionElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .deferStmt:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .expressionStmt:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .switchCaseList:
    for element in layout {
      assert(element != nil)
      assert(RawSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .repeatWhileStmt:
    assert(layout.count == 6)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .guardStmt:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawConditionElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .whereClause:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .forInStmt:
    assert(layout.count == 12)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[6] != nil)
    layout[6].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[7].map { child in
      assert(RawTypeAnnotationSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[8] != nil)
    layout[8].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[9] != nil)
    layout[9].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[10].map { child in
      assert(RawWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[11] != nil)
    layout[11].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .switchStmt:
    assert(layout.count == 7)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawSwitchCaseListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[6] != nil)
    layout[6].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .catchClauseList:
    for element in layout {
      assert(element != nil)
      assert(RawCatchClauseSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .doStmt:
    assert(layout.count == 5)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawCatchClauseListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .returnStmt:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .yieldStmt:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .yieldList:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawExprListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .fallthroughStmt:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .breakStmt:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .caseItemList:
    for element in layout {
      assert(element != nil)
      assert(RawCaseItemSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .catchItemList:
    for element in layout {
      assert(element != nil)
      assert(RawCatchItemSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .conditionElement:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .availabilityCondition:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawAvailabilitySpecListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .matchingPatternCondition:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTypeAnnotationSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawInitializerClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .optionalBindingCondition:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTypeAnnotationSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawInitializerClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .unavailabilityCondition:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawAvailabilitySpecListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .conditionElementList:
    for element in layout {
      assert(element != nil)
      assert(RawConditionElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .declarationStmt:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawDeclSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .throwStmt:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .ifStmt:
    assert(layout.count == 7)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawConditionElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .elseIfContinuation:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawIfStmtSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .elseBlock:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .switchCase:
    assert(layout.count == 3)
    layout[0].map { child in
      assert(RawAttributeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawCodeBlockItemListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .switchDefaultLabel:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .caseItem:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .catchItem:
    assert(layout.count == 3)
    layout[0].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawWhereClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .switchCaseLabel:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawCaseItemListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .catchClause:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawCatchItemListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawCodeBlockSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .poundAssertStmt:
    assert(layout.count == 6)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .genericWhereClause:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawGenericRequirementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .genericRequirementList:
    for element in layout {
      assert(element != nil)
      assert(RawGenericRequirementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .genericRequirement:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .sameTypeRequirement:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .genericParameterList:
    for element in layout {
      assert(element != nil)
      assert(RawGenericParameterSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .genericParameter:
    assert(layout.count == 5)
    layout[0].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .primaryAssociatedTypeList:
    for element in layout {
      assert(element != nil)
      assert(RawPrimaryAssociatedTypeSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .primaryAssociatedType:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .genericParameterClause:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawGenericParameterListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .conformanceRequirement:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .primaryAssociatedTypeClause:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawPrimaryAssociatedTypeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .simpleTypeIdentifier:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawGenericArgumentClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .memberTypeIdentifier:
    assert(layout.count == 4)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawGenericArgumentClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .classRestrictionType:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .arrayType:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .dictionaryType:
    assert(layout.count == 5)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[3] != nil)
    layout[3].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .metatypeType:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .optionalType:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .constrainedSugarType:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .implicitlyUnwrappedOptionalType:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .compositionTypeElement:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .compositionTypeElementList:
    for element in layout {
      assert(element != nil)
      assert(RawCompositionTypeElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .compositionType:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawCompositionTypeElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tupleTypeElement:
    assert(layout.count == 8)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[4] != nil)
    layout[4].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[6].map { child in
      assert(RawInitializerClauseSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[7].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tupleTypeElementList:
    for element in layout {
      assert(element != nil)
      assert(RawTupleTypeElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .tupleType:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTupleTypeElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .functionType:
    assert(layout.count == 7)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTupleTypeElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[4].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[5] != nil)
    layout[5].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[6] != nil)
    layout[6].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .attributedType:
    assert(layout.count == 3)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawAttributeListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .genericArgumentList:
    for element in layout {
      assert(element != nil)
      assert(RawGenericArgumentSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .genericArgument:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .genericArgumentClause:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawGenericArgumentListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .typeAnnotation:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .enumCasePattern:
    assert(layout.count == 4)
    layout[0].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTuplePatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .isTypePattern:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .optionalPattern:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .identifierPattern:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .asTypePattern:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTypeSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tuplePattern:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTuplePatternElementListSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .wildcardPattern:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTypeAnnotationSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tuplePatternElement:
    assert(layout.count == 4)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[3].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .expressionPattern:
    assert(layout.count == 1)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawExprSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .tuplePatternElementList:
    for element in layout {
      assert(element != nil)
      assert(RawTuplePatternElementSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .valueBindingPattern:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawPatternSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .availabilitySpecList:
    for element in layout {
      assert(element != nil)
      assert(RawAvailabilityArgumentSyntax.isValid(syntaxKind: element!.syntaxKind))
    }
    break
  case .availabilityArgument:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .availabilityLabeledArgument:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[1] != nil)
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    assert(layout[2] != nil)
    layout[2].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .availabilityVersionRestriction:
    assert(layout.count == 2)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawVersionTupleSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  case .versionTuple:
    assert(layout.count == 3)
    assert(layout[0] != nil)
    layout[0].map { child in
      assert(RawSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[1].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    layout[2].map { child in
      assert(RawTokenSyntax.isValid(syntaxKind: child.syntaxKind))
    }
    break
  }
#endif
}
