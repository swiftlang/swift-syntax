//// Automatically Generated From RawSyntaxValidation.swift.gyb.
//// Do Not Edit Directly!
//===----------- RawSyntaxValidation.swift - Layout validation ------------===//
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
  func _verify<Node: RawSyntaxNodeProtocol>(_ raw: RawSyntax?, as _: Node.Type, file: StaticString = #file, line: UInt = #line) {
    assert(raw != nil, file: file, line: line)
    assert(Node.isKindOf(raw!), file: file, line: line)
  }
  func _verify<Node: RawSyntaxNodeProtocol>(_ raw: RawSyntax?, as _: Node?.Type, file: StaticString = #file, line: UInt = #line) {
    raw.map { assert(Node.isKindOf($0), file: file, line: line) }
  }
  switch kind {
  case .unknown:
    break
  case .token:
    assertionFailure("validateLayout for .token kind is not supported")
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
  case .missing:
    assert(layout.count == 0)
    break
  case .missingDecl:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    break
  case .missingExpr:
    assert(layout.count == 0)
    break
  case .missingStmt:
    assert(layout.count == 0)
    break
  case .missingType:
    assert(layout.count == 0)
    break
  case .missingPattern:
    assert(layout.count == 0)
    break
  case .codeBlockItem:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawSyntax?.self)
    break
  case .codeBlockItemList:
    for element in layout {
      _verify(element, as: RawCodeBlockItemSyntax.self)
    }
    break
  case .codeBlock:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawCodeBlockItemListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .unexpectedNodes:
    for element in layout {
      _verify(element, as: RawSyntax.self)
    }
    break
  case .inOutExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    break
  case .poundColumnExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .tupleExprElementList:
    for element in layout {
      _verify(element, as: RawTupleExprElementSyntax.self)
    }
    break
  case .arrayElementList:
    for element in layout {
      _verify(element, as: RawArrayElementSyntax.self)
    }
    break
  case .dictionaryElementList:
    for element in layout {
      _verify(element, as: RawDictionaryElementSyntax.self)
    }
    break
  case .stringLiteralSegments:
    for element in layout {
      _verify(element, as: RawSyntax.self)
    }
    break
  case .tryExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawExprSyntax.self)
    break
  case .awaitExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    break
  case .moveExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    break
  case .declNameArgument:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .declNameArgumentList:
    for element in layout {
      _verify(element, as: RawDeclNameArgumentSyntax.self)
    }
    break
  case .declNameArguments:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDeclNameArgumentListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .identifierExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDeclNameArgumentsSyntax?.self)
    break
  case .superRefExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .nilLiteralExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .discardAssignmentExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .assignmentExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .sequenceExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprListSyntax.self)
    break
  case .exprList:
    for element in layout {
      _verify(element, as: RawExprSyntax.self)
    }
    break
  case .poundLineExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .poundFileExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .poundFileIDExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .poundFilePathExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .poundFunctionExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .poundDsohandleExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .symbolicReferenceExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawGenericArgumentClauseSyntax?.self)
    break
  case .prefixOperatorExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    break
  case .binaryOperatorExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .arrowExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .infixOperatorExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawExprSyntax.self)
    break
  case .floatLiteralExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .tupleExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTupleExprElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .arrayExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawArrayElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .dictionaryExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .tupleExprElement:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawExprSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    break
  case .arrayElement:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .dictionaryElement:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawExprSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    break
  case .integerLiteralExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .booleanLiteralExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .unresolvedTernaryExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .ternaryExpr:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawExprSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawExprSyntax.self)
    break
  case .memberAccessExpr:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawDeclNameArgumentsSyntax?.self)
    break
  case .unresolvedIsExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .isExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTypeSyntax.self)
    break
  case .unresolvedAsExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .asExpr:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTypeSyntax.self)
    break
  case .typeExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    break
  case .closureCaptureItem:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawExprSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    break
  case .closureCaptureItemList:
    for element in layout {
      _verify(element, as: RawClosureCaptureItemSyntax.self)
    }
    break
  case .closureCaptureSignature:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawClosureCaptureItemListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .closureParam:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .closureParamList:
    for element in layout {
      _verify(element, as: RawClosureParamSyntax.self)
    }
    break
  case .closureSignature:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawClosureCaptureSignatureSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawReturnClauseSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawTokenSyntax.self)
    break
  case .closureExpr:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawClosureSignatureSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawCodeBlockItemListSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .unresolvedPatternExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawPatternSyntax.self)
    break
  case .multipleTrailingClosureElement:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawClosureExprSyntax.self)
    break
  case .multipleTrailingClosureElementList:
    for element in layout {
      _verify(element, as: RawMultipleTrailingClosureElementSyntax.self)
    }
    break
  case .functionCallExpr:
    assert(layout.count == 12)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTupleExprElementListSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawClosureExprSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawMultipleTrailingClosureElementListSyntax?.self)
    break
  case .subscriptExpr:
    assert(layout.count == 12)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTupleExprElementListSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawClosureExprSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawMultipleTrailingClosureElementListSyntax?.self)
    break
  case .optionalChainingExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .forcedValueExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .postfixUnaryExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .specializeExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawGenericArgumentClauseSyntax.self)
    break
  case .stringSegment:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .expressionSegment:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTupleExprElementListSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax.self)
    break
  case .stringLiteralExpr:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawStringLiteralSegmentsSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    break
  case .regexLiteralExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .keyPathExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawKeyPathComponentListSyntax.self)
    break
  case .keyPathComponentList:
    for element in layout {
      _verify(element, as: RawKeyPathComponentSyntax.self)
    }
    break
  case .keyPathComponent:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawSyntax.self)
    break
  case .keyPathPropertyComponent:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDeclNameArgumentsSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawGenericArgumentClauseSyntax?.self)
    break
  case .keyPathSubscriptComponent:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTupleExprElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .keyPathOptionalComponent:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .oldKeyPathExpr:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawExprSyntax.self)
    break
  case .keyPathBaseExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .objcNamePiece:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .objcName:
    for element in layout {
      _verify(element, as: RawObjcNamePieceSyntax.self)
    }
    break
  case .objcKeyPathExpr:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawObjcNameSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .objcSelectorExpr:
    assert(layout.count == 12)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawExprSyntax.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenSyntax.self)
    break
  case .postfixIfConfigExpr:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawIfConfigDeclSyntax.self)
    break
  case .editorPlaceholderExpr:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .objectLiteralExpr:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTupleExprElementListSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .yieldExprList:
    for element in layout {
      _verify(element, as: RawYieldExprListElementSyntax.self)
    }
    break
  case .yieldExprListElement:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .typeInitializerClause:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    break
  case .typealiasDecl:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawGenericParameterClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeInitializerClauseSyntax.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    break
  case .associatedtypeDecl:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTypeInheritanceClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeInitializerClauseSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    break
  case .functionParameterList:
    for element in layout {
      _verify(element, as: RawFunctionParameterSyntax.self)
    }
    break
  case .parameterClause:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawFunctionParameterListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .returnClause:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    break
  case .functionSignature:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawParameterClauseSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawReturnClauseSyntax?.self)
    break
  case .ifConfigClause:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawSyntax.self)
    break
  case .ifConfigClauseList:
    for element in layout {
      _verify(element, as: RawIfConfigClauseSyntax.self)
    }
    break
  case .ifConfigDecl:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawIfConfigClauseListSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .poundErrorDecl:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawStringLiteralExprSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .poundWarningDecl:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawStringLiteralExprSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .poundSourceLocation:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawPoundSourceLocationArgsSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .poundSourceLocationArgs:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenSyntax.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawTokenSyntax.self)
    break
  case .declModifierDetail:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .declModifier:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDeclModifierDetailSyntax?.self)
    break
  case .inheritedType:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .inheritedTypeList:
    for element in layout {
      _verify(element, as: RawInheritedTypeSyntax.self)
    }
    break
  case .typeInheritanceClause:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawInheritedTypeListSyntax.self)
    break
  case .classDecl:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawGenericParameterClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawMemberDeclBlockSyntax.self)
    break
  case .actorDecl:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawGenericParameterClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawMemberDeclBlockSyntax.self)
    break
  case .structDecl:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawGenericParameterClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawMemberDeclBlockSyntax.self)
    break
  case .protocolDecl:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawPrimaryAssociatedTypeClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawMemberDeclBlockSyntax.self)
    break
  case .extensionDecl:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTypeSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTypeInheritanceClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawMemberDeclBlockSyntax.self)
    break
  case .memberDeclBlock:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawMemberDeclListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .memberDeclList:
    for element in layout {
      _verify(element, as: RawMemberDeclListItemSyntax.self)
    }
    break
  case .memberDeclListItem:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawDeclSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .sourceFile:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawCodeBlockItemListSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .initializerClause:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    break
  case .functionParameter:
    assert(layout.count == 18)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawTokenSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawInitializerClauseSyntax?.self)
    _verify(layout[16], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[17], as: RawTokenSyntax?.self)
    break
  case .modifierList:
    for element in layout {
      _verify(element, as: RawDeclModifierSyntax.self)
    }
    break
  case .functionDecl:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawGenericParameterClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawFunctionSignatureSyntax.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawCodeBlockSyntax?.self)
    break
  case .initializerDecl:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawGenericParameterClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawFunctionSignatureSyntax.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawCodeBlockSyntax?.self)
    break
  case .deinitializerDecl:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawCodeBlockSyntax?.self)
    break
  case .subscriptDecl:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawGenericParameterClauseSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawParameterClauseSyntax.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawReturnClauseSyntax.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawSyntax?.self)
    break
  case .accessLevelModifier:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDeclModifierDetailSyntax?.self)
    break
  case .accessPathComponent:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .accessPath:
    for element in layout {
      _verify(element, as: RawAccessPathComponentSyntax.self)
    }
    break
  case .importDecl:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawAccessPathSyntax.self)
    break
  case .accessorParameter:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .accessorDecl:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDeclModifierSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawAccessorParameterSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawCodeBlockSyntax?.self)
    break
  case .accessorList:
    for element in layout {
      _verify(element, as: RawAccessorDeclSyntax.self)
    }
    break
  case .accessorBlock:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawAccessorListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .patternBinding:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawPatternSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeAnnotationSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawInitializerClauseSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    break
  case .patternBindingList:
    for element in layout {
      _verify(element, as: RawPatternBindingSyntax.self)
    }
    break
  case .variableDecl:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawPatternBindingListSyntax.self)
    break
  case .enumCaseElement:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawParameterClauseSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawInitializerClauseSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    break
  case .enumCaseElementList:
    for element in layout {
      _verify(element, as: RawEnumCaseElementSyntax.self)
    }
    break
  case .enumCaseDecl:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawEnumCaseElementListSyntax.self)
    break
  case .enumDecl:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawGenericParameterClauseSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawMemberDeclBlockSyntax.self)
    break
  case .operatorDecl:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawOperatorPrecedenceAndTypesSyntax?.self)
    break
  case .designatedTypeList:
    for element in layout {
      _verify(element, as: RawDesignatedTypeElementSyntax.self)
    }
    break
  case .designatedTypeElement:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .operatorPrecedenceAndTypes:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawDesignatedTypeListSyntax.self)
    break
  case .precedenceGroupDecl:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawModifierListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawPrecedenceGroupAttributeListSyntax.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawTokenSyntax.self)
    break
  case .precedenceGroupAttributeList:
    for element in layout {
      _verify(element, as: RawSyntax.self)
    }
    break
  case .precedenceGroupRelation:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawPrecedenceGroupNameListSyntax.self)
    break
  case .precedenceGroupNameList:
    for element in layout {
      _verify(element, as: RawPrecedenceGroupNameElementSyntax.self)
    }
    break
  case .precedenceGroupNameElement:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .precedenceGroupAssignment:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .precedenceGroupAssociativity:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .tokenList:
    for element in layout {
      _verify(element, as: RawTokenSyntax.self)
    }
    break
  case .nonEmptyTokenList:
    for element in layout {
      _verify(element, as: RawTokenSyntax.self)
    }
    break
  case .customAttribute:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTupleExprElementListSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    break
  case .attribute:
    assert(layout.count == 12)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenListSyntax?.self)
    break
  case .attributeList:
    for element in layout {
      _verify(element, as: RawSyntax.self)
    }
    break
  case .specializeAttributeSpecList:
    for element in layout {
      _verify(element, as: RawSyntax.self)
    }
    break
  case .availabilityEntry:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawAvailabilitySpecListSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .labeledSpecializeEntry:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    break
  case .targetFunctionEntry:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawDeclNameSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    break
  case .namedAttributeStringArgument:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawSyntax.self)
    break
  case .declName:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDeclNameArgumentsSyntax?.self)
    break
  case .implementsAttributeArguments:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawDeclNameArgumentsSyntax?.self)
    break
  case .objCSelectorPiece:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .objCSelector:
    for element in layout {
      _verify(element, as: RawObjCSelectorPieceSyntax.self)
    }
    break
  case .differentiableAttributeArguments:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawDifferentiabilityParamsClauseSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawGenericWhereClauseSyntax?.self)
    break
  case .differentiabilityParamsClause:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawSyntax.self)
    break
  case .differentiabilityParams:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDifferentiabilityParamListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .differentiabilityParamList:
    for element in layout {
      _verify(element, as: RawDifferentiabilityParamSyntax.self)
    }
    break
  case .differentiabilityParam:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .derivativeRegistrationAttributeArguments:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawQualifiedDeclNameSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawDifferentiabilityParamsClauseSyntax?.self)
    break
  case .qualifiedDeclName:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawDeclNameArgumentsSyntax?.self)
    break
  case .functionDeclName:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawDeclNameArgumentsSyntax?.self)
    break
  case .backDeployAttributeSpecList:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawBackDeployVersionListSyntax.self)
    break
  case .backDeployVersionList:
    for element in layout {
      _verify(element, as: RawBackDeployVersionArgumentSyntax.self)
    }
    break
  case .backDeployVersionArgument:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAvailabilityVersionRestrictionSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .opaqueReturnTypeOfAttributeArguments:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .conventionAttributeArguments:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    break
  case .conventionWitnessMethodAttributeArguments:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .labeledStmt:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawStmtSyntax.self)
    break
  case .continueStmt:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .whileStmt:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawConditionElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawCodeBlockSyntax.self)
    break
  case .deferStmt:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawCodeBlockSyntax.self)
    break
  case .expressionStmt:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    break
  case .switchCaseList:
    for element in layout {
      _verify(element, as: RawSyntax.self)
    }
    break
  case .repeatWhileStmt:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawCodeBlockSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawExprSyntax.self)
    break
  case .guardStmt:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawConditionElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawCodeBlockSyntax.self)
    break
  case .whereClause:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    break
  case .forInStmt:
    assert(layout.count == 20)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawPatternSyntax.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTypeAnnotationSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawTokenSyntax.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawExprSyntax.self)
    _verify(layout[16], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[17], as: RawWhereClauseSyntax?.self)
    _verify(layout[18], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[19], as: RawCodeBlockSyntax.self)
    break
  case .switchStmt:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawSwitchCaseListSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax.self)
    break
  case .catchClauseList:
    for element in layout {
      _verify(element, as: RawCatchClauseSyntax.self)
    }
    break
  case .doStmt:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawCodeBlockSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawCatchClauseListSyntax?.self)
    break
  case .returnStmt:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax?.self)
    break
  case .yieldStmt:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawSyntax.self)
    break
  case .yieldList:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawYieldExprListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .fallthroughStmt:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .breakStmt:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .caseItemList:
    for element in layout {
      _verify(element, as: RawCaseItemSyntax.self)
    }
    break
  case .catchItemList:
    for element in layout {
      _verify(element, as: RawCatchItemSyntax.self)
    }
    break
  case .conditionElement:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .availabilityCondition:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawAvailabilitySpecListSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .matchingPatternCondition:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawPatternSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTypeAnnotationSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawInitializerClauseSyntax.self)
    break
  case .optionalBindingCondition:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawPatternSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTypeAnnotationSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawInitializerClauseSyntax?.self)
    break
  case .unavailabilityCondition:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawAvailabilitySpecListSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .hasSymbolCondition:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawExprSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .conditionElementList:
    for element in layout {
      _verify(element, as: RawConditionElementSyntax.self)
    }
    break
  case .declarationStmt:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawDeclSyntax.self)
    break
  case .throwStmt:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawExprSyntax.self)
    break
  case .ifStmt:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawConditionElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawCodeBlockSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawSyntax?.self)
    break
  case .elseIfContinuation:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawIfStmtSyntax.self)
    break
  case .elseBlock:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawCodeBlockSyntax.self)
    break
  case .switchCase:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawCodeBlockItemListSyntax.self)
    break
  case .switchDefaultLabel:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .caseItem:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawPatternSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawWhereClauseSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    break
  case .catchItem:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawPatternSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawWhereClauseSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    break
  case .switchCaseLabel:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawCaseItemListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .catchClause:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawCatchItemListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawCodeBlockSyntax.self)
    break
  case .poundAssertStmt:
    assert(layout.count == 12)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawExprSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenSyntax.self)
    break
  case .genericWhereClause:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawGenericRequirementListSyntax.self)
    break
  case .genericRequirementList:
    for element in layout {
      _verify(element, as: RawGenericRequirementSyntax.self)
    }
    break
  case .genericRequirement:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .sameTypeRequirement:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTypeSyntax.self)
    break
  case .layoutRequirement:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawTokenSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawTokenSyntax?.self)
    break
  case .genericParameterList:
    for element in layout {
      _verify(element, as: RawGenericParameterSyntax.self)
    }
    break
  case .genericParameter:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawAttributeListSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTypeSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    break
  case .primaryAssociatedTypeList:
    for element in layout {
      _verify(element, as: RawPrimaryAssociatedTypeSyntax.self)
    }
    break
  case .primaryAssociatedType:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .genericParameterClause:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawGenericParameterListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawGenericWhereClauseSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax.self)
    break
  case .conformanceRequirement:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTypeSyntax.self)
    break
  case .primaryAssociatedTypeClause:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawPrimaryAssociatedTypeListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .simpleTypeIdentifier:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawGenericArgumentClauseSyntax?.self)
    break
  case .memberTypeIdentifier:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawGenericArgumentClauseSyntax?.self)
    break
  case .classRestrictionType:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .arrayType:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .dictionaryType:
    assert(layout.count == 10)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTypeSyntax.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax.self)
    break
  case .metatypeType:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .optionalType:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .constrainedSugarType:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    break
  case .implicitlyUnwrappedOptionalType:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .compositionTypeElement:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .compositionTypeElementList:
    for element in layout {
      _verify(element, as: RawCompositionTypeElementSyntax.self)
    }
    break
  case .compositionType:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawCompositionTypeElementListSyntax.self)
    break
  case .packExpansionType:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .tupleTypeElement:
    assert(layout.count == 16)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTypeSyntax.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenSyntax?.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawInitializerClauseSyntax?.self)
    _verify(layout[14], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[15], as: RawTokenSyntax?.self)
    break
  case .tupleTypeElementList:
    for element in layout {
      _verify(element, as: RawTupleTypeElementSyntax.self)
    }
    break
  case .tupleType:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTupleTypeElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .functionType:
    assert(layout.count == 14)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTupleTypeElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    _verify(layout[8], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[9], as: RawTokenSyntax?.self)
    _verify(layout[10], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[11], as: RawTokenSyntax.self)
    _verify(layout[12], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[13], as: RawTypeSyntax.self)
    break
  case .attributedType:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawAttributeListSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTypeSyntax.self)
    break
  case .genericArgumentList:
    for element in layout {
      _verify(element, as: RawGenericArgumentSyntax.self)
    }
    break
  case .genericArgument:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .genericArgumentClause:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawGenericArgumentListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .namedOpaqueReturnType:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawGenericParameterClauseSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    break
  case .typeAnnotation:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    break
  case .enumCasePattern:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTypeSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTuplePatternSyntax?.self)
    break
  case .isTypePattern:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeSyntax.self)
    break
  case .optionalPattern:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawPatternSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    break
  case .identifierPattern:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    break
  case .asTypePattern:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawPatternSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTypeSyntax.self)
    break
  case .tuplePattern:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTuplePatternElementListSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax.self)
    break
  case .wildcardPattern:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTypeAnnotationSyntax?.self)
    break
  case .tuplePatternElement:
    assert(layout.count == 8)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax?.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawPatternSyntax.self)
    _verify(layout[6], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[7], as: RawTokenSyntax?.self)
    break
  case .expressionPattern:
    assert(layout.count == 2)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawExprSyntax.self)
    break
  case .tuplePatternElementList:
    for element in layout {
      _verify(element, as: RawTuplePatternElementSyntax.self)
    }
    break
  case .valueBindingPattern:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawPatternSyntax.self)
    break
  case .availabilitySpecList:
    for element in layout {
      _verify(element, as: RawAvailabilityArgumentSyntax.self)
    }
    break
  case .availabilityArgument:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    break
  case .availabilityLabeledArgument:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawSyntax.self)
    break
  case .availabilityVersionRestriction:
    assert(layout.count == 4)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawTokenSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawVersionTupleSyntax?.self)
    break
  case .versionTuple:
    assert(layout.count == 6)
    _verify(layout[0], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[1], as: RawSyntax.self)
    _verify(layout[2], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[3], as: RawTokenSyntax?.self)
    _verify(layout[4], as: RawUnexpectedNodesSyntax?.self)
    _verify(layout[5], as: RawTokenSyntax?.self)
    break
  }
#endif
}
