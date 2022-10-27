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
  enum ValidationError: CustomStringConvertible {
    case expectedNonNil(expectedKind: RawSyntaxNodeProtocol.Type, file: StaticString, line: UInt)
    case kindMismatch(expectedKind: RawSyntaxNodeProtocol.Type, actualKind: SyntaxKind, file: StaticString, line: UInt)
    case mismatchedTokenKindChoices(expectedKinds: [RawTokenKind], actualKind: RawTokenKind, file: StaticString, line: UInt)
    case mismatchedTokenTextChoices(expectedTexts: [SyntaxText], actualText: SyntaxText, file: StaticString, line: UInt)

    var description: String {
      switch self {
      case .expectedNonNil(expectedKind: let expectedKind, file: _, line: _):
        return "Expected non-nil node of type \(expectedKind) but received nil"
      case .kindMismatch(expectedKind: let expectedKind, actualKind: let actualKind, file: _, line: _):
        return "Expected node of type \(expectedKind) but received \(actualKind)"
      case .mismatchedTokenKindChoices(expectedKinds: let expectedKinds, actualKind: let actualKind, file: _, line: _):
        return "Expected token of kind \(expectedKinds) but received \(actualKind)"
      case .mismatchedTokenTextChoices(expectedTexts: let expectedTexts, actualText: let actualText, file: _, line: _):
        return "Expected token with text \(expectedTexts) but received \(actualText)"
      }
    }

    var fileAndLine: (StaticString, UInt) {
      switch self {
      case .expectedNonNil(expectedKind: _, file: let file, line: let line):
        return (file, line)
      case .kindMismatch(expectedKind: _, actualKind: _, file: let file, line: let line):
        return (file, line)
      case .mismatchedTokenKindChoices(expectedKinds: _, actualKind: _, file: let file, line: let line):
        return (file, line)
      case .mismatchedTokenTextChoices(expectedTexts: _, actualText: _, file: let file, line: let line):
        return (file, line)
      }
    }
  }

  func verify<Node: RawSyntaxNodeProtocol>(_ raw: RawSyntax?, as _: Node.Type, file: StaticString = #file, line: UInt = #line) -> ValidationError? {
    guard let raw = raw else {
      return .expectedNonNil(expectedKind: Node.self, file: file, line: line)
    }
    guard Node.isKindOf(raw) else {
      return .kindMismatch(expectedKind: Node.self, actualKind: raw.kind, file: file, line: line)
    }
    return nil
  }

  func verify<Node: RawSyntaxNodeProtocol>(_ raw: RawSyntax?, as _: Node?.Type, file: StaticString = #file, line: UInt = #line) -> ValidationError? {
    if raw != nil {
      return verify(raw, as: Node.self, file: file, line: line)
    }
    return nil
  }

  func verify(_ raw: RawSyntax?, as: RawTokenSyntax.Type, tokenChoices: [RawTokenKind], textChoices: [SyntaxText], file: StaticString = #file, line: UInt = #line) -> ValidationError? {
    guard let raw = raw else {
      return .expectedNonNil(expectedKind: RawTokenSyntax.self, file: file, line: line)
    }
    guard let token = raw.as(RawTokenSyntax.self) else {
      return .kindMismatch(expectedKind: RawTokenSyntax.self, actualKind: raw.kind, file: file, line: line)
    }
    guard tokenChoices.isEmpty || tokenChoices.contains(token.tokenKind) else {
      return .mismatchedTokenKindChoices(expectedKinds: tokenChoices, actualKind: token.tokenKind, file: file, line: line)
    }
    guard textChoices.isEmpty || textChoices.contains(token.tokenText) else {
      return .mismatchedTokenTextChoices(expectedTexts: textChoices, actualText: token.tokenText, file: file, line: line)
    }
    return nil
  }

  func verify(_ raw: RawSyntax?, as: RawTokenSyntax?.Type, tokenChoices: [RawTokenKind], textChoices: [SyntaxText], file: StaticString = #file, line: UInt = #line) -> ValidationError? {
    if raw != nil {
      return verify(raw, as: RawTokenSyntax.self, tokenChoices: tokenChoices, textChoices: textChoices, file: file, line: line)
    }
    return nil
  }

  func assertNoError(_ nodeKind: SyntaxKind, _ index: Int, _ error: ValidationError?) {
    if let error = error {
      let (file, line) = error.fileAndLine
      assertionFailure("""
        Error validating child at index \(index) of \(nodeKind):
        \(error.description)
        """, file: file, line: line)
    }
  }

  func assertAnyHasNoError(_ nodeKind: SyntaxKind, _ index: Int, _ errors: [ValidationError?]) {
    let nonNilErrors = errors.compactMap({ $0 })
    if nonNilErrors.count == errors.count, let firstError = nonNilErrors.first {
      let (file, line) = firstError.fileAndLine
      assertionFailure("""
        Error validating child at index \(index) of \(nodeKind):
        Node did not satisfy any node choice requirement.
        Validation failures:
        \(nonNilErrors.map({ "- \($0.description)" }).joined(separator: "\n") )
        """, file: file, line: line)
    }
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
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
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
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 1, [
      verify(layout[1], as: RawDeclSyntax.self),
      verify(layout[1], as: RawStmtSyntax.self),
      verify(layout[1], as: RawExprSyntax.self),
      verify(layout[1], as: RawTokenListSyntax.self),
      verify(layout[1], as: RawNonEmptyTokenListSyntax.self),
    ])
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.semicolon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .codeBlockItemList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawCodeBlockItemSyntax.self))
    }
    break
  case .codeBlock:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftBrace], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawCodeBlockItemListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightBrace], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .unexpectedNodes:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawSyntax.self))
    }
    break
  case .inOutExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.prefixAmpersand], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundColumnExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundColumnKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tupleExprElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawTupleExprElementSyntax.self))
    }
    break
  case .arrayElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawArrayElementSyntax.self))
    }
    break
  case .dictionaryElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawDictionaryElementSyntax.self))
    }
    break
  case .stringLiteralSegments:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawSyntax.self))
    }
    break
  case .tryExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.tryKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.postfixQuestionMark, .exclamationMark], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .awaitExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.contextualKeyword], textChoices: ["await"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .moveExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.contextualKeyword], textChoices: ["_move"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .declNameArgument:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .declNameArgumentList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawDeclNameArgumentSyntax.self))
    }
    break
  case .declNameArguments:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDeclNameArgumentListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .identifierExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier, .selfKeyword, .capitalSelfKeyword, .dollarIdentifier, .spacedBinaryOperator], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDeclNameArgumentsSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .superRefExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.superKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .nilLiteralExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.nilKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .discardAssignmentExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.wildcardKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .assignmentExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.equal], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .sequenceExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprListSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .exprList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawExprSyntax.self))
    }
    break
  case .poundLineExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundLineKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundFileExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundFileKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundFileIDExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundFileIDKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundFilePathExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundFilePathKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundFunctionExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundFunctionKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundDsohandleExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundDsohandleKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .symbolicReferenceExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawGenericArgumentClauseSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .prefixOperatorExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.prefixOperator], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .binaryOperatorExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .arrowExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.contextualKeyword], textChoices: ["async"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.throwsKeyword], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.arrow], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .infixOperatorExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .floatLiteralExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.floatingLiteral], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tupleExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTupleExprElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .arrayExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftSquareBracket], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawArrayElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightSquareBracket], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .dictionaryExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftSquareBracket], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 3, [
      verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []),
      verify(layout[3], as: RawDictionaryElementListSyntax.self),
    ])
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightSquareBracket], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tupleExprElement:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.identifier, .wildcardKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .arrayElement:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .dictionaryElement:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .integerLiteralExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.integerLiteral], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .booleanLiteralExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.trueKeyword, .falseKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .unresolvedTernaryExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.infixQuestionMark], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .ternaryExpr:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.infixQuestionMark], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawExprSyntax.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .memberAccessExpr:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.period, .prefixPeriod], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawDeclNameArgumentsSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .unresolvedIsExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.isKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .isExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.isKeyword], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTypeSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .unresolvedAsExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.asKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.postfixQuestionMark, .exclamationMark], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .asExpr:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.asKeyword], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.postfixQuestionMark, .exclamationMark], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTypeSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .typeExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .closureCaptureItem:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.equal], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawExprSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .closureCaptureItemList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawClosureCaptureItemSyntax.self))
    }
    break
  case .closureCaptureSignature:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftSquareBracket], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawClosureCaptureItemListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightSquareBracket], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .closureParam:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier, .wildcardKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .closureParamList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawClosureParamSyntax.self))
    }
    break
  case .closureSignature:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawClosureCaptureSignatureSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 5, [
      verify(layout[5], as: RawClosureParamListSyntax?.self),
      verify(layout[5], as: RawParameterClauseSyntax?.self),
    ])
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.contextualKeyword, .throwsKeyword], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.throwsKeyword], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawReturnClauseSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawTokenSyntax.self, tokenChoices: [.inKeyword], textChoices: []))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .closureExpr:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftBrace], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawClosureSignatureSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawCodeBlockItemListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightBrace], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .unresolvedPatternExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawPatternSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .multipleTrailingClosureElement:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier, .wildcardKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawClosureExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .multipleTrailingClosureElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawMultipleTrailingClosureElementSyntax.self))
    }
    break
  case .functionCallExpr:
    assert(layout.count == 13)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTupleExprElementListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawClosureExprSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawMultipleTrailingClosureElementListSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    break
  case .subscriptExpr:
    assert(layout.count == 13)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftSquareBracket], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTupleExprElementListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightSquareBracket], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawClosureExprSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawMultipleTrailingClosureElementListSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    break
  case .optionalChainingExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.postfixQuestionMark], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .forcedValueExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.exclamationMark], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .postfixUnaryExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.postfixOperator], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .specializeExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawGenericArgumentClauseSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .stringSegment:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.stringSegment], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .expressionSegment:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.backslash], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.rawStringDelimiter], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTupleExprElementListSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax.self, tokenChoices: [.stringInterpolationAnchor], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .stringLiteralExpr:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.rawStringDelimiter], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.stringQuote, .multilineStringQuote], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawStringLiteralSegmentsSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.stringQuote, .multilineStringQuote], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.rawStringDelimiter], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .regexLiteralExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.regexLiteral], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .keyPathExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.backslash], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawKeyPathComponentListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .keyPathComponentList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawKeyPathComponentSyntax.self))
    }
    break
  case .keyPathComponent:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.period, .prefixPeriod], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 3, [
      verify(layout[3], as: RawKeyPathPropertyComponentSyntax.self),
      verify(layout[3], as: RawKeyPathSubscriptComponentSyntax.self),
      verify(layout[3], as: RawKeyPathOptionalComponentSyntax.self),
    ])
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .keyPathPropertyComponent:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier, .selfKeyword, .capitalSelfKeyword, .dollarIdentifier, .spacedBinaryOperator, .integerLiteral], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDeclNameArgumentsSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawGenericArgumentClauseSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .keyPathSubscriptComponent:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftSquareBracket], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTupleExprElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightSquareBracket], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .keyPathOptionalComponent:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.postfixQuestionMark, .exclamationMark], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .oldKeyPathExpr:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.backslash], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 3, [
      verify(layout[3], as: RawIdentifierExprSyntax?.self),
      verify(layout[3], as: RawSpecializeExprSyntax?.self),
      verify(layout[3], as: RawOptionalChainingExprSyntax?.self),
    ])
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .keyPathBaseExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.period], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .objcNamePiece:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.period], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .objcName:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawObjcNamePieceSyntax.self))
    }
    break
  case .objcKeyPathExpr:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundKeyPathKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawObjcNameSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .objcSelectorExpr:
    assert(layout.count == 13)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundSelectorKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.contextualKeyword], textChoices: ["getter", "setter"]))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawExprSyntax.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    break
  case .macroExpansionExpr:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.pound], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTupleExprElementListSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawClosureExprSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawMultipleTrailingClosureElementListSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .postfixIfConfigExpr:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawIfConfigDeclSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .editorPlaceholderExpr:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .objectLiteralExpr:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundColorLiteralKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTupleExprElementListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .yieldExprList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawYieldExprListElementSyntax.self))
    }
    break
  case .yieldExprListElement:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .typeInitializerClause:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.equal], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .typealiasDecl:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.typealiasKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawGenericParameterClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeInitializerClauseSyntax.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .associatedtypeDecl:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.associatedtypeKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTypeInheritanceClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeInitializerClauseSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .functionParameterList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawFunctionParameterSyntax.self))
    }
    break
  case .parameterClause:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawFunctionParameterListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .returnClause:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.arrow], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .functionSignature:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawParameterClauseSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.contextualKeyword], textChoices: ["async", "reasync"]))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.throwsKeyword, .rethrowsKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawReturnClauseSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .ifConfigClause:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundIfKeyword, .poundElseifKeyword, .poundElseKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 5, [
      verify(layout[5], as: RawCodeBlockItemListSyntax?.self),
      verify(layout[5], as: RawSwitchCaseListSyntax?.self),
      verify(layout[5], as: RawMemberDeclListSyntax?.self),
      verify(layout[5], as: RawExprSyntax?.self),
    ])
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .ifConfigClauseList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawIfConfigClauseSyntax.self))
    }
    break
  case .ifConfigDecl:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawIfConfigClauseListSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.poundEndifKeyword], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundErrorDecl:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundErrorKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawStringLiteralExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundWarningDecl:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundWarningKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawStringLiteralExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundSourceLocation:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundSourceLocationKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawPoundSourceLocationArgsSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundSourceLocationArgs:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["file"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.stringLiteral], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["line"]))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawTokenSyntax.self, tokenChoices: [.integerLiteral], textChoices: []))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .declModifierDetail:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .declModifier:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [], textChoices: ["class", "convenience", "dynamic", "final", "infix", "lazy", "optional", "override", "postfix", "prefix", "required", "static", "unowned", "weak", "private", "fileprivate", "internal", "public", "open", "mutating", "nonmutating", "indirect", "__consuming", "actor", "async", "distributed", "isolated", "nonisolated", "_const", "_local"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDeclModifierDetailSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .inheritedType:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .inheritedTypeList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawInheritedTypeSyntax.self))
    }
    break
  case .typeInheritanceClause:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawInheritedTypeListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .classDecl:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.classKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawGenericParameterClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawMemberDeclBlockSyntax.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .actorDecl:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.contextualKeyword], textChoices: ["actor"]))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawGenericParameterClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawMemberDeclBlockSyntax.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .structDecl:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.structKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawGenericParameterClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawMemberDeclBlockSyntax.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .protocolDecl:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.protocolKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawPrimaryAssociatedTypeClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawMemberDeclBlockSyntax.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .extensionDecl:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.extensionKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTypeSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTypeInheritanceClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawMemberDeclBlockSyntax.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .memberDeclBlock:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftBrace], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawMemberDeclListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightBrace], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .memberDeclList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawMemberDeclListItemSyntax.self))
    }
    break
  case .memberDeclListItem:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawDeclSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.semicolon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .sourceFile:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawCodeBlockItemListSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .initializerClause:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.equal], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .functionParameter:
    assert(layout.count == 19)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.identifier, .wildcardKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.identifier, .wildcardKeyword], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawTokenSyntax?.self, tokenChoices: [.ellipsis], textChoices: []))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawInitializerClauseSyntax?.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 17, verify(layout[17], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 18, verify(layout[18], as: RawUnexpectedNodesSyntax?.self))
    break
  case .modifierList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawDeclModifierSyntax.self))
    }
    break
  case .functionDecl:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.funcKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier, .unspacedBinaryOperator, .spacedBinaryOperator, .prefixOperator, .postfixOperator], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawGenericParameterClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawFunctionSignatureSyntax.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawCodeBlockSyntax?.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .initializerDecl:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.initKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.postfixQuestionMark, .infixQuestionMark, .exclamationMark], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawGenericParameterClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawFunctionSignatureSyntax.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawCodeBlockSyntax?.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .deinitializerDecl:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.deinitKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawCodeBlockSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .subscriptDecl:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.subscriptKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawGenericParameterClauseSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawParameterClauseSyntax.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawReturnClauseSyntax.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 15, [
      verify(layout[15], as: RawAccessorBlockSyntax?.self),
      verify(layout[15], as: RawCodeBlockSyntax?.self),
    ])
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .accessLevelModifier:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDeclModifierDetailSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .accessPathComponent:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.period], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .accessPath:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawAccessPathComponentSyntax.self))
    }
    break
  case .importDecl:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.importKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.typealiasKeyword, .structKeyword, .classKeyword, .enumKeyword, .protocolKeyword, .varKeyword, .letKeyword, .funcKeyword], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawAccessPathSyntax.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .accessorParameter:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .accessorDecl:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDeclModifierSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [], textChoices: ["get", "set", "didSet", "willSet", "unsafeAddress", "addressWithOwner", "addressWithNativeOwner", "unsafeMutableAddress", "mutableAddressWithOwner", "mutableAddressWithNativeOwner", "_read", "_modify"]))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawAccessorParameterSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.contextualKeyword], textChoices: ["async"]))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax?.self, tokenChoices: [.throwsKeyword, .rethrowsKeyword], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawCodeBlockSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .accessorList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawAccessorDeclSyntax.self))
    }
    break
  case .accessorBlock:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftBrace], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawAccessorListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightBrace], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .patternBinding:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawPatternSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeAnnotationSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawInitializerClauseSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 7, [
      verify(layout[7], as: RawAccessorBlockSyntax?.self),
      verify(layout[7], as: RawCodeBlockSyntax?.self),
    ])
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .patternBindingList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawPatternBindingSyntax.self))
    }
    break
  case .variableDecl:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.letKeyword, .varKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawPatternBindingListSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .enumCaseElement:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawParameterClauseSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawInitializerClauseSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .enumCaseElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawEnumCaseElementSyntax.self))
    }
    break
  case .enumCaseDecl:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.caseKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawEnumCaseElementListSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .enumDecl:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.enumKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawGenericParameterClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeInheritanceClauseSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawMemberDeclBlockSyntax.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .operatorDecl:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.operatorKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.unspacedBinaryOperator, .spacedBinaryOperator, .prefixOperator, .postfixOperator], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawOperatorPrecedenceAndTypesSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .designatedTypeList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawDesignatedTypeElementSyntax.self))
    }
    break
  case .designatedTypeElement:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .operatorPrecedenceAndTypes:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawDesignatedTypeListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .precedenceGroupDecl:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawModifierListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.precedencegroupKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax.self, tokenChoices: [.leftBrace], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawPrecedenceGroupAttributeListSyntax.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawTokenSyntax.self, tokenChoices: [.rightBrace], textChoices: []))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .precedenceGroupAttributeList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawSyntax.self))
    }
    break
  case .precedenceGroupRelation:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["higherThan", "lowerThan"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawPrecedenceGroupNameListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .precedenceGroupNameList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawPrecedenceGroupNameElementSyntax.self))
    }
    break
  case .precedenceGroupNameElement:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .precedenceGroupAssignment:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["assignment"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.trueKeyword, .falseKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .precedenceGroupAssociativity:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["associativity"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["left", "right", "none"]))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .macroExpansionDecl:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.pound], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTupleExprElementListSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawClosureExprSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawMultipleTrailingClosureElementListSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tokenList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawTokenSyntax.self))
    }
    break
  case .nonEmptyTokenList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawTokenSyntax.self))
    }
    break
  case .customAttribute:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.atSign], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTupleExprElementListSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .attribute:
    assert(layout.count == 13)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.atSign], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 7, [
      verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: []),
      verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.stringLiteral], textChoices: []),
      verify(layout[7], as: RawStringLiteralExprSyntax?.self),
      verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.integerLiteral], textChoices: []),
      verify(layout[7], as: RawAvailabilitySpecListSyntax?.self),
      verify(layout[7], as: RawSpecializeAttributeSpecListSyntax?.self),
      verify(layout[7], as: RawObjCSelectorSyntax?.self),
      verify(layout[7], as: RawImplementsAttributeArgumentsSyntax?.self),
      verify(layout[7], as: RawDifferentiableAttributeArgumentsSyntax?.self),
      verify(layout[7], as: RawDerivativeRegistrationAttributeArgumentsSyntax?.self),
      verify(layout[7], as: RawNamedAttributeStringArgumentSyntax?.self),
      verify(layout[7], as: RawBackDeployAttributeSpecListSyntax?.self),
      verify(layout[7], as: RawConventionAttributeArgumentsSyntax?.self),
      verify(layout[7], as: RawConventionWitnessMethodAttributeArgumentsSyntax?.self),
      verify(layout[7], as: RawTokenListSyntax?.self),
    ])
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenListSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    break
  case .attributeList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawSyntax.self))
    }
    break
  case .specializeAttributeSpecList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawSyntax.self))
    }
    break
  case .availabilityEntry:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawAvailabilitySpecListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.semicolon], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .labeledSpecializeEntry:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier, .contextualKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .targetFunctionEntry:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawDeclNameSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .namedAttributeStringArgument:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 5, [
      verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.stringLiteral], textChoices: []),
      verify(layout[5], as: RawDeclNameSyntax.self),
    ])
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .declName:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 1, [
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []),
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.prefixOperator], textChoices: []),
    ])
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDeclNameArgumentsSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .implementsAttributeArguments:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawDeclNameArgumentsSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .objCSelectorPiece:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .objCSelector:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawObjCSelectorPieceSyntax.self))
    }
    break
  case .differentiableAttributeArguments:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.contextualKeyword], textChoices: ["forward", "reverse", "linear"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawDifferentiabilityParamsClauseSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .differentiabilityParamsClause:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["wrt"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 5, [
      verify(layout[5], as: RawDifferentiabilityParamSyntax.self),
      verify(layout[5], as: RawDifferentiabilityParamsSyntax.self),
    ])
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .differentiabilityParams:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDifferentiabilityParamListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .differentiabilityParamList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawDifferentiabilityParamSyntax.self))
    }
    break
  case .differentiabilityParam:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 1, [
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.selfKeyword], textChoices: []),
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []),
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.integerLiteral], textChoices: []),
    ])
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .derivativeRegistrationAttributeArguments:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.contextualKeyword], textChoices: ["of"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawQualifiedDeclNameSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.period], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: ["get", "set"]))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawDifferentiabilityParamsClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .qualifiedDeclName:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.period, .prefixPeriod], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.identifier, .unspacedBinaryOperator, .spacedBinaryOperator, .prefixOperator, .postfixOperator], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawDeclNameArgumentsSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .functionDeclName:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 1, [
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []),
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.prefixOperator], textChoices: []),
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.spacedBinaryOperator], textChoices: []),
    ])
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawDeclNameArgumentsSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .backDeployAttributeSpecList:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["before"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawBackDeployVersionListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .backDeployVersionList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawBackDeployVersionArgumentSyntax.self))
    }
    break
  case .backDeployVersionArgument:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAvailabilityVersionRestrictionSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .opaqueReturnTypeOfAttributeArguments:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.stringLiteral], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.integerLiteral], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .conventionAttributeArguments:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["block", "c", "objc_method", "thin", "thick"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: ["cType"]))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.stringLiteral], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .conventionWitnessMethodAttributeArguments:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .labeledStmt:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawStmtSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .continueStmt:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.continueKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .whileStmt:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.whileKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawConditionElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawCodeBlockSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .deferStmt:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.deferKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawCodeBlockSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .expressionStmt:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .switchCaseList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawSyntax.self))
    }
    break
  case .repeatWhileStmt:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.repeatKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawCodeBlockSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.whileKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawExprSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .guardStmt:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.guardKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawConditionElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.elseKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawCodeBlockSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .whereClause:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.whereKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .forInStmt:
    assert(layout.count == 21)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.forKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.tryKeyword], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: ["await"]))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.caseKeyword], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawPatternSyntax.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTypeAnnotationSyntax?.self))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawTokenSyntax.self, tokenChoices: [.inKeyword], textChoices: []))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawExprSyntax.self))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 17, verify(layout[17], as: RawWhereClauseSyntax?.self))
    assertNoError(kind, 18, verify(layout[18], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 19, verify(layout[19], as: RawCodeBlockSyntax.self))
    assertNoError(kind, 20, verify(layout[20], as: RawUnexpectedNodesSyntax?.self))
    break
  case .switchStmt:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.switchKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.leftBrace], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawSwitchCaseListSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax.self, tokenChoices: [.rightBrace], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .catchClauseList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawCatchClauseSyntax.self))
    }
    break
  case .doStmt:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.doKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawCodeBlockSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawCatchClauseListSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .returnStmt:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.returnKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .yieldStmt:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.yield], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 3, [
      verify(layout[3], as: RawYieldListSyntax.self),
      verify(layout[3], as: RawExprSyntax.self),
    ])
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .yieldList:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawYieldExprListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .fallthroughStmt:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.fallthroughKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .breakStmt:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.breakKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .caseItemList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawCaseItemSyntax.self))
    }
    break
  case .catchItemList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawCatchItemSyntax.self))
    }
    break
  case .conditionElement:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 1, [
      verify(layout[1], as: RawExprSyntax.self),
      verify(layout[1], as: RawAvailabilityConditionSyntax.self),
      verify(layout[1], as: RawUnavailabilityConditionSyntax.self),
      verify(layout[1], as: RawMatchingPatternConditionSyntax.self),
      verify(layout[1], as: RawOptionalBindingConditionSyntax.self),
      verify(layout[1], as: RawHasSymbolConditionSyntax.self),
    ])
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .availabilityCondition:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundAvailableKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawAvailabilitySpecListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .matchingPatternCondition:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.caseKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawPatternSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTypeAnnotationSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawInitializerClauseSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .optionalBindingCondition:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.letKeyword, .varKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawPatternSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTypeAnnotationSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawInitializerClauseSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .unavailabilityCondition:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundUnavailableKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawAvailabilitySpecListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .hasSymbolCondition:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .conditionElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawConditionElementSyntax.self))
    }
    break
  case .declarationStmt:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawDeclSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .throwStmt:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.throwKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawExprSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .ifStmt:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.ifKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawConditionElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawCodeBlockSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.elseKeyword], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 9, [
      verify(layout[9], as: RawIfStmtSyntax?.self),
      verify(layout[9], as: RawCodeBlockSyntax?.self),
    ])
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .switchCase:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 3, [
      verify(layout[3], as: RawSwitchDefaultLabelSyntax.self),
      verify(layout[3], as: RawSwitchCaseLabelSyntax.self),
    ])
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawCodeBlockItemListSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .switchDefaultLabel:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.defaultKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .caseItem:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawPatternSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawWhereClauseSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .catchItem:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawPatternSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawWhereClauseSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .switchCaseLabel:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.caseKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawCaseItemListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .catchClause:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.catchKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawCatchItemListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawCodeBlockSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .poundAssertStmt:
    assert(layout.count == 13)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.poundAssertKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawExprSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.stringLiteral], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    break
  case .genericWhereClause:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.whereKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawGenericRequirementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .genericRequirementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawGenericRequirementSyntax.self))
    }
    break
  case .genericRequirement:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 1, [
      verify(layout[1], as: RawSameTypeRequirementSyntax.self),
      verify(layout[1], as: RawConformanceRequirementSyntax.self),
      verify(layout[1], as: RawLayoutRequirementSyntax.self),
    ])
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .sameTypeRequirement:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.spacedBinaryOperator, .unspacedBinaryOperator, .prefixOperator, .postfixOperator, .equal], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTypeSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .layoutRequirement:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.integerLiteral], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawTokenSyntax?.self, tokenChoices: [.integerLiteral], textChoices: []))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawTokenSyntax?.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .genericParameterList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawGenericParameterSyntax.self))
    }
    break
  case .genericParameter:
    assert(layout.count == 13)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.ellipsis], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTypeSyntax?.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    break
  case .primaryAssociatedTypeList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawPrimaryAssociatedTypeSyntax.self))
    }
    break
  case .primaryAssociatedType:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .genericParameterClause:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftAngle], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawGenericParameterListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawGenericWhereClauseSyntax?.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax.self, tokenChoices: [.rightAngle], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .conformanceRequirement:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTypeSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .primaryAssociatedTypeClause:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftAngle], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawPrimaryAssociatedTypeListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightAngle], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .simpleTypeIdentifier:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier, .capitalSelfKeyword, .anyKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawGenericArgumentClauseSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .memberTypeIdentifier:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.period, .prefixPeriod], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.identifier, .capitalSelfKeyword, .anyKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawGenericArgumentClauseSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .classRestrictionType:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.classKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .arrayType:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftSquareBracket], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightSquareBracket], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .dictionaryType:
    assert(layout.count == 11)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftSquareBracket], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTypeSyntax.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax.self, tokenChoices: [.rightSquareBracket], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    break
  case .metatypeType:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.period], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["Type", "Protocol"]))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .optionalType:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.postfixQuestionMark], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .constrainedSugarType:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: ["some", "any"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .implicitlyUnwrappedOptionalType:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.exclamationMark], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .compositionTypeElement:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [], textChoices: ["&"]))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .compositionTypeElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawCompositionTypeElementSyntax.self))
    }
    break
  case .compositionType:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawCompositionTypeElementListSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .packExpansionType:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.ellipsis], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tupleTypeElement:
    assert(layout.count == 17)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.inoutKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.identifier, .wildcardKeyword], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.identifier, .wildcardKeyword], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTypeSyntax.self))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax?.self, tokenChoices: [.ellipsis], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawInitializerClauseSyntax?.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 15, verify(layout[15], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 16, verify(layout[16], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tupleTypeElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawTupleTypeElementSyntax.self))
    }
    break
  case .tupleType:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTupleTypeElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .functionType:
    assert(layout.count == 15)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTupleTypeElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.contextualKeyword, .throwsKeyword, .rethrowsKeyword, .throwKeyword], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 9, verify(layout[9], as: RawTokenSyntax?.self, tokenChoices: [.contextualKeyword, .throwsKeyword, .rethrowsKeyword, .throwKeyword], textChoices: []))
    assertNoError(kind, 10, verify(layout[10], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 11, verify(layout[11], as: RawTokenSyntax.self, tokenChoices: [.arrow], textChoices: []))
    assertNoError(kind, 12, verify(layout[12], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 13, verify(layout[13], as: RawTypeSyntax.self))
    assertNoError(kind, 14, verify(layout[14], as: RawUnexpectedNodesSyntax?.self))
    break
  case .attributedType:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [], textChoices: ["inout", "__shared", "__owned"]))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawAttributeListSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTypeSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .genericArgumentList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawGenericArgumentSyntax.self))
    }
    break
  case .genericArgument:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .genericArgumentClause:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftAngle], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawGenericArgumentListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightAngle], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .namedOpaqueReturnType:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawGenericParameterClauseSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .typeAnnotation:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .enumCasePattern:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTypeSyntax?.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.period], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTuplePatternSyntax?.self))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .isTypePattern:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.isKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .optionalPattern:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawPatternSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.postfixQuestionMark], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .identifierPattern:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.selfKeyword, .identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .asTypePattern:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawPatternSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.asKeyword], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTypeSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tuplePattern:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.leftParen], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTuplePatternElementListSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.rightParen], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .wildcardPattern:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.wildcardKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTypeAnnotationSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tuplePatternElement:
    assert(layout.count == 9)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax?.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawPatternSyntax.self))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 7, verify(layout[7], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 8, verify(layout[8], as: RawUnexpectedNodesSyntax?.self))
    break
  case .expressionPattern:
    assert(layout.count == 3)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawExprSyntax.self))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    break
  case .tuplePatternElementList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawTuplePatternElementSyntax.self))
    }
    break
  case .valueBindingPattern:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.letKeyword, .varKeyword], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawPatternSyntax.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .availabilitySpecList:
    for (index, element) in layout.enumerated() {
      assertNoError(kind, index, verify(element, as: RawAvailabilityArgumentSyntax.self))
    }
    break
  case .availabilityArgument:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 1, [
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.spacedBinaryOperator], textChoices: ["*"]),
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.contextualKeyword], textChoices: []),
      verify(layout[1], as: RawAvailabilityVersionRestrictionSyntax.self),
      verify(layout[1], as: RawAvailabilityLabeledArgumentSyntax.self),
      verify(layout[1], as: RawTokenListSyntax.self),
    ])
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.comma], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .availabilityLabeledArgument:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax.self, tokenChoices: [.colon], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 5, [
      verify(layout[5], as: RawTokenSyntax.self, tokenChoices: [.stringLiteral], textChoices: []),
      verify(layout[5], as: RawVersionTupleSyntax.self),
    ])
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  case .availabilityVersionRestriction:
    assert(layout.count == 5)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 1, verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.identifier], textChoices: []))
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawVersionTupleSyntax?.self))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    break
  case .versionTuple:
    assert(layout.count == 7)
    assertNoError(kind, 0, verify(layout[0], as: RawUnexpectedNodesSyntax?.self))
    assertAnyHasNoError(kind, 1, [
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.integerLiteral], textChoices: []),
      verify(layout[1], as: RawTokenSyntax.self, tokenChoices: [.floatingLiteral], textChoices: []),
    ])
    assertNoError(kind, 2, verify(layout[2], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 3, verify(layout[3], as: RawTokenSyntax?.self, tokenChoices: [.period], textChoices: []))
    assertNoError(kind, 4, verify(layout[4], as: RawUnexpectedNodesSyntax?.self))
    assertNoError(kind, 5, verify(layout[5], as: RawTokenSyntax?.self, tokenChoices: [.integerLiteral], textChoices: []))
    assertNoError(kind, 6, verify(layout[6], as: RawUnexpectedNodesSyntax?.self))
    break
  }
#endif
}
