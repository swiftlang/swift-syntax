//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===------- SyntaxFactory.swift - Syntax Factory implementations ---------===//
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
//
// This file defines the SyntaxFactory, one of the most important client-facing
// types in lib/Syntax and likely to be very commonly used.
//
// Effectively a namespace, SyntaxFactory is never instantiated, but is *the*
// one-stop shop for making new Syntax nodes. Putting all of these into a
// collection of static methods provides a single point of API lookup for
// clients' convenience.
//
//===----------------------------------------------------------------------===//

public enum SyntaxFactory {
  @available(*, deprecated, message: "Use initializer on TokenSyntax")
  public static func makeToken(_ kind: TokenKind, presence: SourcePresence,
                               leadingTrivia: Trivia = [],
                               trailingTrivia: Trivia = []) -> TokenSyntax {
    let raw = RawSyntax.makeMaterializedToken(kind: kind, leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia, presence: presence, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TokenSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownSyntax")
  public static func makeUnknownSyntax(tokens: [TokenSyntax]) -> UnknownSyntax {
    let raw = RawSyntax.makeLayout(kind: .unknown,
      from: tokens.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return UnknownSyntax(data)
  }

/// MARK: Syntax Node Creation APIs







  @available(*, deprecated, message: "Use initializer on UnknownDeclSyntax")
  public static func makeBlankUnknownDecl(presence: SourcePresence = .present) -> UnknownDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unknownDecl,
      from: [
    ], arena: .default))
    return UnknownDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownExprSyntax")
  public static func makeBlankUnknownExpr(presence: SourcePresence = .present) -> UnknownExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unknownExpr,
      from: [
    ], arena: .default))
    return UnknownExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownStmtSyntax")
  public static func makeBlankUnknownStmt(presence: SourcePresence = .present) -> UnknownStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unknownStmt,
      from: [
    ], arena: .default))
    return UnknownStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownTypeSyntax")
  public static func makeBlankUnknownType(presence: SourcePresence = .present) -> UnknownTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unknownType,
      from: [
    ], arena: .default))
    return UnknownTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownPatternSyntax")
  public static func makeBlankUnknownPattern(presence: SourcePresence = .present) -> UnknownPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unknownPattern,
      from: [
    ], arena: .default))
    return UnknownPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingSyntax")
  public static func makeBlankMissing(presence: SourcePresence = .missing) -> MissingSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missing,
      from: [
    ], arena: .default))
    return MissingSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MissingDeclSyntax")
  public static func makeMissingDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?) -> MissingDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.missingDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MissingDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingDeclSyntax")
  public static func makeBlankMissingDecl(presence: SourcePresence = .missing) -> MissingDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return MissingDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingExprSyntax")
  public static func makeBlankMissingExpr(presence: SourcePresence = .missing) -> MissingExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingExpr,
      from: [
    ], arena: .default))
    return MissingExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingStmtSyntax")
  public static func makeBlankMissingStmt(presence: SourcePresence = .missing) -> MissingStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingStmt,
      from: [
    ], arena: .default))
    return MissingStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingTypeSyntax")
  public static func makeBlankMissingType(presence: SourcePresence = .missing) -> MissingTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingType,
      from: [
    ], arena: .default))
    return MissingTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingPatternSyntax")
  public static func makeBlankMissingPattern(presence: SourcePresence = .missing) -> MissingPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingPattern,
      from: [
    ], arena: .default))
    return MissingPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockItemSyntax")
  public static func makeCodeBlockItem(_ unexpectedBeforeItem: UnexpectedNodesSyntax? = nil, item: Syntax, _ unexpectedBetweenItemAndSemicolon: UnexpectedNodesSyntax? = nil, semicolon: TokenSyntax?, _ unexpectedBetweenSemicolonAndErrorTokens: UnexpectedNodesSyntax? = nil, errorTokens: Syntax?) -> CodeBlockItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeItem?.raw,
      item.raw,
      unexpectedBetweenItemAndSemicolon?.raw,
      semicolon?.raw,
      unexpectedBetweenSemicolonAndErrorTokens?.raw,
      errorTokens?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockItemSyntax")
  public static func makeBlankCodeBlockItem(presence: SourcePresence = .present) -> CodeBlockItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .codeBlockItem,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return CodeBlockItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockItemListSyntax")
  public static func makeCodeBlockItemList(
    _ elements: [CodeBlockItemSyntax]) -> CodeBlockItemListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockItemListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockItemListSyntax")
  public static func makeBlankCodeBlockItemList(presence: SourcePresence = .present) -> CodeBlockItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .codeBlockItemList,
      from: [
    ], arena: .default))
    return CodeBlockItemListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockSyntax")
  public static func makeCodeBlock(_ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndStatements: UnexpectedNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax) -> CodeBlockSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlock,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockSyntax")
  public static func makeBlankCodeBlock(presence: SourcePresence = .present) -> CodeBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .codeBlock,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default),
    ], arena: .default))
    return CodeBlockSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on UnexpectedNodesSyntax")
  public static func makeUnexpectedNodes(
    _ elements: [Syntax]) -> UnexpectedNodesSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unexpectedNodes,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return UnexpectedNodesSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnexpectedNodesSyntax")
  public static func makeBlankUnexpectedNodes(presence: SourcePresence = .present) -> UnexpectedNodesSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unexpectedNodes,
      from: [
    ], arena: .default))
    return UnexpectedNodesSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InOutExprSyntax")
  public static func makeInOutExpr(_ unexpectedBeforeAmpersand: UnexpectedNodesSyntax? = nil, ampersand: TokenSyntax, _ unexpectedBetweenAmpersandAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax) -> InOutExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAmpersand?.raw,
      ampersand.raw,
      unexpectedBetweenAmpersandAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.inOutExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return InOutExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InOutExprSyntax")
  public static func makeBlankInOutExpr(presence: SourcePresence = .present) -> InOutExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .inOutExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.prefixAmpersand, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return InOutExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundColumnExprSyntax")
  public static func makePoundColumnExpr(_ unexpectedBeforePoundColumn: UnexpectedNodesSyntax? = nil, poundColumn: TokenSyntax) -> PoundColumnExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundColumn?.raw,
      poundColumn.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundColumnExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundColumnExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundColumnExprSyntax")
  public static func makeBlankPoundColumnExpr(presence: SourcePresence = .present) -> PoundColumnExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundColumnExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundColumnKeyword, arena: .default),
    ], arena: .default))
    return PoundColumnExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleExprElementListSyntax")
  public static func makeTupleExprElementList(
    _ elements: [TupleExprElementSyntax]) -> TupleExprElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TupleExprElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleExprElementListSyntax")
  public static func makeBlankTupleExprElementList(presence: SourcePresence = .present) -> TupleExprElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleExprElementList,
      from: [
    ], arena: .default))
    return TupleExprElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrayElementListSyntax")
  public static func makeArrayElementList(
    _ elements: [ArrayElementSyntax]) -> ArrayElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ArrayElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrayElementListSyntax")
  public static func makeBlankArrayElementList(presence: SourcePresence = .present) -> ArrayElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrayElementList,
      from: [
    ], arena: .default))
    return ArrayElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DictionaryElementListSyntax")
  public static func makeDictionaryElementList(
    _ elements: [DictionaryElementSyntax]) -> DictionaryElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DictionaryElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DictionaryElementListSyntax")
  public static func makeBlankDictionaryElementList(presence: SourcePresence = .present) -> DictionaryElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .dictionaryElementList,
      from: [
    ], arena: .default))
    return DictionaryElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on StringLiteralSegmentsSyntax")
  public static func makeStringLiteralSegments(
    _ elements: [Syntax]) -> StringLiteralSegmentsSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringLiteralSegments,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return StringLiteralSegmentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on StringLiteralSegmentsSyntax")
  public static func makeBlankStringLiteralSegments(presence: SourcePresence = .present) -> StringLiteralSegmentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .stringLiteralSegments,
      from: [
    ], arena: .default))
    return StringLiteralSegmentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TryExprSyntax")
  public static func makeTryExpr(_ unexpectedBeforeTryKeyword: UnexpectedNodesSyntax? = nil, tryKeyword: TokenSyntax, _ unexpectedBetweenTryKeywordAndQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax?, _ unexpectedBetweenQuestionOrExclamationMarkAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax) -> TryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeTryKeyword?.raw,
      tryKeyword.raw,
      unexpectedBetweenTryKeywordAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      unexpectedBetweenQuestionOrExclamationMarkAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TryExprSyntax")
  public static func makeBlankTryExpr(presence: SourcePresence = .present) -> TryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tryExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.tryKeyword, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return TryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AwaitExprSyntax")
  public static func makeAwaitExpr(_ unexpectedBeforeAwaitKeyword: UnexpectedNodesSyntax? = nil, awaitKeyword: TokenSyntax, _ unexpectedBetweenAwaitKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax) -> AwaitExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAwaitKeyword?.raw,
      awaitKeyword.raw,
      unexpectedBetweenAwaitKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.awaitExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AwaitExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AwaitExprSyntax")
  public static func makeBlankAwaitExpr(presence: SourcePresence = .present) -> AwaitExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .awaitExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return AwaitExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MoveExprSyntax")
  public static func makeMoveExpr(_ unexpectedBeforeMoveKeyword: UnexpectedNodesSyntax? = nil, moveKeyword: TokenSyntax, _ unexpectedBetweenMoveKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax) -> MoveExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMoveKeyword?.raw,
      moveKeyword.raw,
      unexpectedBetweenMoveKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.moveExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MoveExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MoveExprSyntax")
  public static func makeBlankMoveExpr(presence: SourcePresence = .present) -> MoveExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .moveExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return MoveExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentSyntax")
  public static func makeDeclNameArgument(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax) -> DeclNameArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndColon?.raw,
      colon.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentSyntax")
  public static func makeBlankDeclNameArgument(presence: SourcePresence = .present) -> DeclNameArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declNameArgument,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
    ], arena: .default))
    return DeclNameArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentListSyntax")
  public static func makeDeclNameArgumentList(
    _ elements: [DeclNameArgumentSyntax]) -> DeclNameArgumentListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArgumentList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentListSyntax")
  public static func makeBlankDeclNameArgumentList(presence: SourcePresence = .present) -> DeclNameArgumentListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declNameArgumentList,
      from: [
    ], arena: .default))
    return DeclNameArgumentListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentsSyntax")
  public static func makeDeclNameArguments(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil, arguments: DeclNameArgumentListSyntax, _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> DeclNameArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentsSyntax")
  public static func makeBlankDeclNameArguments(presence: SourcePresence = .present) -> DeclNameArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declNameArguments,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.declNameArgumentList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return DeclNameArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IdentifierExprSyntax")
  public static func makeIdentifierExpr(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?) -> IdentifierExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.identifierExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IdentifierExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IdentifierExprSyntax")
  public static func makeBlankIdentifierExpr(presence: SourcePresence = .present) -> IdentifierExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .identifierExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return IdentifierExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SuperRefExprSyntax")
  public static func makeSuperRefExpr(_ unexpectedBeforeSuperKeyword: UnexpectedNodesSyntax? = nil, superKeyword: TokenSyntax) -> SuperRefExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSuperKeyword?.raw,
      superKeyword.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.superRefExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SuperRefExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SuperRefExprSyntax")
  public static func makeBlankSuperRefExpr(presence: SourcePresence = .present) -> SuperRefExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .superRefExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.superKeyword, arena: .default),
    ], arena: .default))
    return SuperRefExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on NilLiteralExprSyntax")
  public static func makeNilLiteralExpr(_ unexpectedBeforeNilKeyword: UnexpectedNodesSyntax? = nil, nilKeyword: TokenSyntax) -> NilLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeNilKeyword?.raw,
      nilKeyword.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.nilLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return NilLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on NilLiteralExprSyntax")
  public static func makeBlankNilLiteralExpr(presence: SourcePresence = .present) -> NilLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .nilLiteralExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.nilKeyword, arena: .default),
    ], arena: .default))
    return NilLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DiscardAssignmentExprSyntax")
  public static func makeDiscardAssignmentExpr(_ unexpectedBeforeWildcard: UnexpectedNodesSyntax? = nil, wildcard: TokenSyntax) -> DiscardAssignmentExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWildcard?.raw,
      wildcard.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.discardAssignmentExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DiscardAssignmentExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DiscardAssignmentExprSyntax")
  public static func makeBlankDiscardAssignmentExpr(presence: SourcePresence = .present) -> DiscardAssignmentExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .discardAssignmentExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.wildcardKeyword, arena: .default),
    ], arena: .default))
    return DiscardAssignmentExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AssignmentExprSyntax")
  public static func makeAssignmentExpr(_ unexpectedBeforeAssignToken: UnexpectedNodesSyntax? = nil, assignToken: TokenSyntax) -> AssignmentExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssignToken?.raw,
      assignToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.assignmentExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AssignmentExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AssignmentExprSyntax")
  public static func makeBlankAssignmentExpr(presence: SourcePresence = .present) -> AssignmentExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .assignmentExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: .default),
    ], arena: .default))
    return AssignmentExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SequenceExprSyntax")
  public static func makeSequenceExpr(_ unexpectedBeforeElements: UnexpectedNodesSyntax? = nil, elements: ExprListSyntax) -> SequenceExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.sequenceExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SequenceExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SequenceExprSyntax")
  public static func makeBlankSequenceExpr(presence: SourcePresence = .present) -> SequenceExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .sequenceExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.exprList, arena: .default),
    ], arena: .default))
    return SequenceExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExprListSyntax")
  public static func makeExprList(
    _ elements: [ExprSyntax]) -> ExprListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.exprList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ExprListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExprListSyntax")
  public static func makeBlankExprList(presence: SourcePresence = .present) -> ExprListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .exprList,
      from: [
    ], arena: .default))
    return ExprListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundLineExprSyntax")
  public static func makePoundLineExpr(_ unexpectedBeforePoundLine: UnexpectedNodesSyntax? = nil, poundLine: TokenSyntax) -> PoundLineExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundLine?.raw,
      poundLine.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundLineExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundLineExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundLineExprSyntax")
  public static func makeBlankPoundLineExpr(presence: SourcePresence = .present) -> PoundLineExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundLineExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundLineKeyword, arena: .default),
    ], arena: .default))
    return PoundLineExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundFileExprSyntax")
  public static func makePoundFileExpr(_ unexpectedBeforePoundFile: UnexpectedNodesSyntax? = nil, poundFile: TokenSyntax) -> PoundFileExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundFile?.raw,
      poundFile.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundFileExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundFileExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundFileExprSyntax")
  public static func makeBlankPoundFileExpr(presence: SourcePresence = .present) -> PoundFileExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundFileExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundFileKeyword, arena: .default),
    ], arena: .default))
    return PoundFileExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundFileIDExprSyntax")
  public static func makePoundFileIDExpr(_ unexpectedBeforePoundFileID: UnexpectedNodesSyntax? = nil, poundFileID: TokenSyntax) -> PoundFileIDExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundFileID?.raw,
      poundFileID.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundFileIDExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundFileIDExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundFileIDExprSyntax")
  public static func makeBlankPoundFileIDExpr(presence: SourcePresence = .present) -> PoundFileIDExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundFileIDExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundFileIDKeyword, arena: .default),
    ], arena: .default))
    return PoundFileIDExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundFilePathExprSyntax")
  public static func makePoundFilePathExpr(_ unexpectedBeforePoundFilePath: UnexpectedNodesSyntax? = nil, poundFilePath: TokenSyntax) -> PoundFilePathExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundFilePath?.raw,
      poundFilePath.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundFilePathExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundFilePathExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundFilePathExprSyntax")
  public static func makeBlankPoundFilePathExpr(presence: SourcePresence = .present) -> PoundFilePathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundFilePathExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundFilePathKeyword, arena: .default),
    ], arena: .default))
    return PoundFilePathExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundFunctionExprSyntax")
  public static func makePoundFunctionExpr(_ unexpectedBeforePoundFunction: UnexpectedNodesSyntax? = nil, poundFunction: TokenSyntax) -> PoundFunctionExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundFunction?.raw,
      poundFunction.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundFunctionExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundFunctionExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundFunctionExprSyntax")
  public static func makeBlankPoundFunctionExpr(presence: SourcePresence = .present) -> PoundFunctionExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundFunctionExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundFunctionKeyword, arena: .default),
    ], arena: .default))
    return PoundFunctionExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundDsohandleExprSyntax")
  public static func makePoundDsohandleExpr(_ unexpectedBeforePoundDsohandle: UnexpectedNodesSyntax? = nil, poundDsohandle: TokenSyntax) -> PoundDsohandleExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundDsohandle?.raw,
      poundDsohandle.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundDsohandleExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundDsohandleExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundDsohandleExprSyntax")
  public static func makeBlankPoundDsohandleExpr(presence: SourcePresence = .present) -> PoundDsohandleExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundDsohandleExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundDsohandleKeyword, arena: .default),
    ], arena: .default))
    return PoundDsohandleExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SymbolicReferenceExprSyntax")
  public static func makeSymbolicReferenceExpr(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.symbolicReferenceExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SymbolicReferenceExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SymbolicReferenceExprSyntax")
  public static func makeBlankSymbolicReferenceExpr(presence: SourcePresence = .present) -> SymbolicReferenceExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .symbolicReferenceExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return SymbolicReferenceExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrefixOperatorExprSyntax")
  public static func makePrefixOperatorExpr(_ unexpectedBeforeOperatorToken: UnexpectedNodesSyntax? = nil, operatorToken: TokenSyntax?, _ unexpectedBetweenOperatorTokenAndPostfixExpression: UnexpectedNodesSyntax? = nil, postfixExpression: ExprSyntax) -> PrefixOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOperatorToken?.raw,
      operatorToken?.raw,
      unexpectedBetweenOperatorTokenAndPostfixExpression?.raw,
      postfixExpression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.prefixOperatorExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrefixOperatorExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrefixOperatorExprSyntax")
  public static func makeBlankPrefixOperatorExpr(presence: SourcePresence = .present) -> PrefixOperatorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .prefixOperatorExpr,
      from: [
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return PrefixOperatorExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BinaryOperatorExprSyntax")
  public static func makeBinaryOperatorExpr(_ unexpectedBeforeOperatorToken: UnexpectedNodesSyntax? = nil, operatorToken: TokenSyntax) -> BinaryOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOperatorToken?.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.binaryOperatorExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return BinaryOperatorExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BinaryOperatorExprSyntax")
  public static func makeBlankBinaryOperatorExpr(presence: SourcePresence = .present) -> BinaryOperatorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .binaryOperatorExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
    ], arena: .default))
    return BinaryOperatorExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrowExprSyntax")
  public static func makeArrowExpr(_ unexpectedBeforeAsyncKeyword: UnexpectedNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncKeywordAndThrowsToken: UnexpectedNodesSyntax? = nil, throwsToken: TokenSyntax?, _ unexpectedBetweenThrowsTokenAndArrowToken: UnexpectedNodesSyntax? = nil, arrowToken: TokenSyntax) -> ArrowExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAsyncKeyword?.raw,
      asyncKeyword?.raw,
      unexpectedBetweenAsyncKeywordAndThrowsToken?.raw,
      throwsToken?.raw,
      unexpectedBetweenThrowsTokenAndArrowToken?.raw,
      arrowToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrowExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ArrowExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrowExprSyntax")
  public static func makeBlankArrowExpr(presence: SourcePresence = .present) -> ArrowExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrowExpr,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: .default),
    ], arena: .default))
    return ArrowExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InfixOperatorExprSyntax")
  public static func makeInfixOperatorExpr(_ unexpectedBeforeLeftOperand: UnexpectedNodesSyntax? = nil, leftOperand: ExprSyntax, _ unexpectedBetweenLeftOperandAndOperatorOperand: UnexpectedNodesSyntax? = nil, operatorOperand: ExprSyntax, _ unexpectedBetweenOperatorOperandAndRightOperand: UnexpectedNodesSyntax? = nil, rightOperand: ExprSyntax) -> InfixOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftOperand?.raw,
      leftOperand.raw,
      unexpectedBetweenLeftOperandAndOperatorOperand?.raw,
      operatorOperand.raw,
      unexpectedBetweenOperatorOperandAndRightOperand?.raw,
      rightOperand.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.infixOperatorExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return InfixOperatorExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InfixOperatorExprSyntax")
  public static func makeBlankInfixOperatorExpr(presence: SourcePresence = .present) -> InfixOperatorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .infixOperatorExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return InfixOperatorExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FloatLiteralExprSyntax")
  public static func makeFloatLiteralExpr(_ unexpectedBeforeFloatingDigits: UnexpectedNodesSyntax? = nil, floatingDigits: TokenSyntax) -> FloatLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeFloatingDigits?.raw,
      floatingDigits.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.floatLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FloatLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FloatLiteralExprSyntax")
  public static func makeBlankFloatLiteralExpr(presence: SourcePresence = .present) -> FloatLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .floatLiteralExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.floatingLiteral(""), arena: .default),
    ], arena: .default))
    return FloatLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleExprSyntax")
  public static func makeTupleExpr(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? = nil, elementList: TupleExprElementListSyntax, _ unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> TupleExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      unexpectedBetweenElementListAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TupleExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleExprSyntax")
  public static func makeBlankTupleExpr(presence: SourcePresence = .present) -> TupleExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return TupleExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrayExprSyntax")
  public static func makeArrayExpr(_ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil, leftSquare: TokenSyntax, _ unexpectedBetweenLeftSquareAndElements: UnexpectedNodesSyntax? = nil, elements: ArrayElementListSyntax, _ unexpectedBetweenElementsAndRightSquare: UnexpectedNodesSyntax? = nil, rightSquare: TokenSyntax) -> ArrayExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndElements?.raw,
      elements.raw,
      unexpectedBetweenElementsAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ArrayExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrayExprSyntax")
  public static func makeBlankArrayExpr(presence: SourcePresence = .present) -> ArrayExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrayExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.arrayElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default),
    ], arena: .default))
    return ArrayExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DictionaryExprSyntax")
  public static func makeDictionaryExpr(_ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil, leftSquare: TokenSyntax, _ unexpectedBetweenLeftSquareAndContent: UnexpectedNodesSyntax? = nil, content: Syntax, _ unexpectedBetweenContentAndRightSquare: UnexpectedNodesSyntax? = nil, rightSquare: TokenSyntax) -> DictionaryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndContent?.raw,
      content.raw,
      unexpectedBetweenContentAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DictionaryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DictionaryExprSyntax")
  public static func makeBlankDictionaryExpr(presence: SourcePresence = .present) -> DictionaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .dictionaryExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default),
    ], arena: .default))
    return DictionaryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleExprElementSyntax")
  public static func makeTupleExprElement(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax?, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> TupleExprElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label?.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TupleExprElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleExprElementSyntax")
  public static func makeBlankTupleExprElement(presence: SourcePresence = .present) -> TupleExprElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleExprElement,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return TupleExprElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrayElementSyntax")
  public static func makeArrayElement(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> ArrayElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ArrayElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrayElementSyntax")
  public static func makeBlankArrayElement(presence: SourcePresence = .present) -> ArrayElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrayElement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return ArrayElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DictionaryElementSyntax")
  public static func makeDictionaryElement(_ unexpectedBeforeKeyExpression: UnexpectedNodesSyntax? = nil, keyExpression: ExprSyntax, _ unexpectedBetweenKeyExpressionAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValueExpression: UnexpectedNodesSyntax? = nil, valueExpression: ExprSyntax, _ unexpectedBetweenValueExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> DictionaryElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeKeyExpression?.raw,
      keyExpression.raw,
      unexpectedBetweenKeyExpressionAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValueExpression?.raw,
      valueExpression.raw,
      unexpectedBetweenValueExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DictionaryElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DictionaryElementSyntax")
  public static func makeBlankDictionaryElement(presence: SourcePresence = .present) -> DictionaryElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .dictionaryElement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return DictionaryElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IntegerLiteralExprSyntax")
  public static func makeIntegerLiteralExpr(_ unexpectedBeforeDigits: UnexpectedNodesSyntax? = nil, digits: TokenSyntax) -> IntegerLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDigits?.raw,
      digits.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.integerLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IntegerLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IntegerLiteralExprSyntax")
  public static func makeBlankIntegerLiteralExpr(presence: SourcePresence = .present) -> IntegerLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .integerLiteralExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: .default),
    ], arena: .default))
    return IntegerLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BooleanLiteralExprSyntax")
  public static func makeBooleanLiteralExpr(_ unexpectedBeforeBooleanLiteral: UnexpectedNodesSyntax? = nil, booleanLiteral: TokenSyntax) -> BooleanLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBooleanLiteral?.raw,
      booleanLiteral.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.booleanLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return BooleanLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BooleanLiteralExprSyntax")
  public static func makeBlankBooleanLiteralExpr(presence: SourcePresence = .present) -> BooleanLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .booleanLiteralExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.trueKeyword, arena: .default),
    ], arena: .default))
    return BooleanLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedTernaryExprSyntax")
  public static func makeUnresolvedTernaryExpr(_ unexpectedBeforeQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax, _ unexpectedBetweenQuestionMarkAndFirstChoice: UnexpectedNodesSyntax? = nil, firstChoice: ExprSyntax, _ unexpectedBetweenFirstChoiceAndColonMark: UnexpectedNodesSyntax? = nil, colonMark: TokenSyntax) -> UnresolvedTernaryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeQuestionMark?.raw,
      questionMark.raw,
      unexpectedBetweenQuestionMarkAndFirstChoice?.raw,
      firstChoice.raw,
      unexpectedBetweenFirstChoiceAndColonMark?.raw,
      colonMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedTernaryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return UnresolvedTernaryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedTernaryExprSyntax")
  public static func makeBlankUnresolvedTernaryExpr(presence: SourcePresence = .present) -> UnresolvedTernaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unresolvedTernaryExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.infixQuestionMark, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
    ], arena: .default))
    return UnresolvedTernaryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TernaryExprSyntax")
  public static func makeTernaryExpr(_ unexpectedBeforeConditionExpression: UnexpectedNodesSyntax? = nil, conditionExpression: ExprSyntax, _ unexpectedBetweenConditionExpressionAndQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax, _ unexpectedBetweenQuestionMarkAndFirstChoice: UnexpectedNodesSyntax? = nil, firstChoice: ExprSyntax, _ unexpectedBetweenFirstChoiceAndColonMark: UnexpectedNodesSyntax? = nil, colonMark: TokenSyntax, _ unexpectedBetweenColonMarkAndSecondChoice: UnexpectedNodesSyntax? = nil, secondChoice: ExprSyntax) -> TernaryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeConditionExpression?.raw,
      conditionExpression.raw,
      unexpectedBetweenConditionExpressionAndQuestionMark?.raw,
      questionMark.raw,
      unexpectedBetweenQuestionMarkAndFirstChoice?.raw,
      firstChoice.raw,
      unexpectedBetweenFirstChoiceAndColonMark?.raw,
      colonMark.raw,
      unexpectedBetweenColonMarkAndSecondChoice?.raw,
      secondChoice.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.ternaryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TernaryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TernaryExprSyntax")
  public static func makeBlankTernaryExpr(presence: SourcePresence = .present) -> TernaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ternaryExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.infixQuestionMark, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return TernaryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberAccessExprSyntax")
  public static func makeMemberAccessExpr(_ unexpectedBeforeBase: UnexpectedNodesSyntax? = nil, base: ExprSyntax?, _ unexpectedBetweenBaseAndDot: UnexpectedNodesSyntax? = nil, dot: TokenSyntax, _ unexpectedBetweenDotAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?) -> MemberAccessExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBase?.raw,
      base?.raw,
      unexpectedBetweenBaseAndDot?.raw,
      dot.raw,
      unexpectedBetweenDotAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberAccessExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MemberAccessExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberAccessExprSyntax")
  public static func makeBlankMemberAccessExpr(presence: SourcePresence = .present) -> MemberAccessExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberAccessExpr,
      from: [
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return MemberAccessExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedIsExprSyntax")
  public static func makeUnresolvedIsExpr(_ unexpectedBeforeIsTok: UnexpectedNodesSyntax? = nil, isTok: TokenSyntax) -> UnresolvedIsExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIsTok?.raw,
      isTok.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedIsExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return UnresolvedIsExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedIsExprSyntax")
  public static func makeBlankUnresolvedIsExpr(presence: SourcePresence = .present) -> UnresolvedIsExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unresolvedIsExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.isKeyword, arena: .default),
    ], arena: .default))
    return UnresolvedIsExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IsExprSyntax")
  public static func makeIsExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndIsTok: UnexpectedNodesSyntax? = nil, isTok: TokenSyntax, _ unexpectedBetweenIsTokAndTypeName: UnexpectedNodesSyntax? = nil, typeName: TypeSyntax) -> IsExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndIsTok?.raw,
      isTok.raw,
      unexpectedBetweenIsTokAndTypeName?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.isExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IsExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IsExprSyntax")
  public static func makeBlankIsExpr(presence: SourcePresence = .present) -> IsExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .isExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.isKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return IsExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedAsExprSyntax")
  public static func makeUnresolvedAsExpr(_ unexpectedBeforeAsTok: UnexpectedNodesSyntax? = nil, asTok: TokenSyntax, _ unexpectedBetweenAsTokAndQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax?) -> UnresolvedAsExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAsTok?.raw,
      asTok.raw,
      unexpectedBetweenAsTokAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedAsExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return UnresolvedAsExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedAsExprSyntax")
  public static func makeBlankUnresolvedAsExpr(presence: SourcePresence = .present) -> UnresolvedAsExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unresolvedAsExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.asKeyword, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return UnresolvedAsExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AsExprSyntax")
  public static func makeAsExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndAsTok: UnexpectedNodesSyntax? = nil, asTok: TokenSyntax, _ unexpectedBetweenAsTokAndQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax?, _ unexpectedBetweenQuestionOrExclamationMarkAndTypeName: UnexpectedNodesSyntax? = nil, typeName: TypeSyntax) -> AsExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndAsTok?.raw,
      asTok.raw,
      unexpectedBetweenAsTokAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      unexpectedBetweenQuestionOrExclamationMarkAndTypeName?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.asExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AsExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AsExprSyntax")
  public static func makeBlankAsExpr(presence: SourcePresence = .present) -> AsExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .asExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.asKeyword, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return AsExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypeExprSyntax")
  public static func makeTypeExpr(_ unexpectedBeforeType: UnexpectedNodesSyntax? = nil, type: TypeSyntax) -> TypeExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TypeExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypeExprSyntax")
  public static func makeBlankTypeExpr(presence: SourcePresence = .present) -> TypeExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typeExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return TypeExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemSyntax")
  public static func makeClosureCaptureItem(_ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil, specifier: TokenListSyntax?, _ unexpectedBetweenSpecifierAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax?, _ unexpectedBetweenNameAndAssignToken: UnexpectedNodesSyntax? = nil, assignToken: TokenSyntax?, _ unexpectedBetweenAssignTokenAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> ClosureCaptureItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSpecifier?.raw,
      specifier?.raw,
      unexpectedBetweenSpecifierAndName?.raw,
      name?.raw,
      unexpectedBetweenNameAndAssignToken?.raw,
      assignToken?.raw,
      unexpectedBetweenAssignTokenAndExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemSyntax")
  public static func makeBlankClosureCaptureItem(presence: SourcePresence = .present) -> ClosureCaptureItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureCaptureItem,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return ClosureCaptureItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemListSyntax")
  public static func makeClosureCaptureItemList(
    _ elements: [ClosureCaptureItemSyntax]) -> ClosureCaptureItemListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureItemList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureItemListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemListSyntax")
  public static func makeBlankClosureCaptureItemList(presence: SourcePresence = .present) -> ClosureCaptureItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureCaptureItemList,
      from: [
    ], arena: .default))
    return ClosureCaptureItemListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureSignatureSyntax")
  public static func makeClosureCaptureSignature(_ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil, leftSquare: TokenSyntax, _ unexpectedBetweenLeftSquareAndItems: UnexpectedNodesSyntax? = nil, items: ClosureCaptureItemListSyntax?, _ unexpectedBetweenItemsAndRightSquare: UnexpectedNodesSyntax? = nil, rightSquare: TokenSyntax) -> ClosureCaptureSignatureSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndItems?.raw,
      items?.raw,
      unexpectedBetweenItemsAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureSignature,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureSignatureSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureSignatureSyntax")
  public static func makeBlankClosureCaptureSignature(presence: SourcePresence = .present) -> ClosureCaptureSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureCaptureSignature,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default),
    ], arena: .default))
    return ClosureCaptureSignatureSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureParamSyntax")
  public static func makeClosureParam(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> ClosureParamSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureParam,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClosureParamSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureParamSyntax")
  public static func makeBlankClosureParam(presence: SourcePresence = .present) -> ClosureParamSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureParam,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return ClosureParamSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureParamListSyntax")
  public static func makeClosureParamList(
    _ elements: [ClosureParamSyntax]) -> ClosureParamListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureParamList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClosureParamListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureParamListSyntax")
  public static func makeBlankClosureParamList(presence: SourcePresence = .present) -> ClosureParamListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureParamList,
      from: [
    ], arena: .default))
    return ClosureParamListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureSignatureSyntax")
  public static func makeClosureSignature(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndCapture: UnexpectedNodesSyntax? = nil, capture: ClosureCaptureSignatureSyntax?, _ unexpectedBetweenCaptureAndInput: UnexpectedNodesSyntax? = nil, input: Syntax?, _ unexpectedBetweenInputAndAsyncKeyword: UnexpectedNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncKeywordAndThrowsTok: UnexpectedNodesSyntax? = nil, throwsTok: TokenSyntax?, _ unexpectedBetweenThrowsTokAndOutput: UnexpectedNodesSyntax? = nil, output: ReturnClauseSyntax?, _ unexpectedBetweenOutputAndInTok: UnexpectedNodesSyntax? = nil, inTok: TokenSyntax) -> ClosureSignatureSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndCapture?.raw,
      capture?.raw,
      unexpectedBetweenCaptureAndInput?.raw,
      input?.raw,
      unexpectedBetweenInputAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      unexpectedBetweenAsyncKeywordAndThrowsTok?.raw,
      throwsTok?.raw,
      unexpectedBetweenThrowsTokAndOutput?.raw,
      output?.raw,
      unexpectedBetweenOutputAndInTok?.raw,
      inTok.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureSignature,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClosureSignatureSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureSignatureSyntax")
  public static func makeBlankClosureSignature(presence: SourcePresence = .present) -> ClosureSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureSignature,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.inKeyword, arena: .default),
    ], arena: .default))
    return ClosureSignatureSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureExprSyntax")
  public static func makeClosureExpr(_ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndSignature: UnexpectedNodesSyntax? = nil, signature: ClosureSignatureSyntax?, _ unexpectedBetweenSignatureAndStatements: UnexpectedNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax) -> ClosureExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndSignature?.raw,
      signature?.raw,
      unexpectedBetweenSignatureAndStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClosureExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureExprSyntax")
  public static func makeBlankClosureExpr(presence: SourcePresence = .present) -> ClosureExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default),
    ], arena: .default))
    return ClosureExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedPatternExprSyntax")
  public static func makeUnresolvedPatternExpr(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax) -> UnresolvedPatternExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedPatternExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return UnresolvedPatternExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedPatternExprSyntax")
  public static func makeBlankUnresolvedPatternExpr(presence: SourcePresence = .present) -> UnresolvedPatternExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unresolvedPatternExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
    ], arena: .default))
    return UnresolvedPatternExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementSyntax")
  public static func makeMultipleTrailingClosureElement(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndClosure: UnexpectedNodesSyntax? = nil, closure: ClosureExprSyntax) -> MultipleTrailingClosureElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndClosure?.raw,
      closure.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MultipleTrailingClosureElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementSyntax")
  public static func makeBlankMultipleTrailingClosureElement(presence: SourcePresence = .present) -> MultipleTrailingClosureElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .multipleTrailingClosureElement,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.closureExpr, arena: .default),
    ], arena: .default))
    return MultipleTrailingClosureElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementListSyntax")
  public static func makeMultipleTrailingClosureElementList(
    _ elements: [MultipleTrailingClosureElementSyntax]) -> MultipleTrailingClosureElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MultipleTrailingClosureElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementListSyntax")
  public static func makeBlankMultipleTrailingClosureElementList(presence: SourcePresence = .present) -> MultipleTrailingClosureElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .multipleTrailingClosureElementList,
      from: [
    ], arena: .default))
    return MultipleTrailingClosureElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionCallExprSyntax")
  public static func makeFunctionCallExpr(_ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil, calledExpression: ExprSyntax, _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?, _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil, trailingClosure: ClosureExprSyntax?, _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?) -> FunctionCallExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCalledExpression?.raw,
      calledExpression.raw,
      unexpectedBetweenCalledExpressionAndLeftParen?.raw,
      leftParen?.raw,
      unexpectedBetweenLeftParenAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
      unexpectedBetweenRightParenAndTrailingClosure?.raw,
      trailingClosure?.raw,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionCallExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FunctionCallExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionCallExprSyntax")
  public static func makeBlankFunctionCallExpr(presence: SourcePresence = .present) -> FunctionCallExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionCallExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return FunctionCallExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SubscriptExprSyntax")
  public static func makeSubscriptExpr(_ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil, calledExpression: ExprSyntax, _ unexpectedBetweenCalledExpressionAndLeftBracket: UnexpectedNodesSyntax? = nil, leftBracket: TokenSyntax, _ unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? = nil, rightBracket: TokenSyntax, _ unexpectedBetweenRightBracketAndTrailingClosure: UnexpectedNodesSyntax? = nil, trailingClosure: ClosureExprSyntax?, _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?) -> SubscriptExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCalledExpression?.raw,
      calledExpression.raw,
      unexpectedBetweenCalledExpressionAndLeftBracket?.raw,
      leftBracket.raw,
      unexpectedBetweenLeftBracketAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightBracket?.raw,
      rightBracket.raw,
      unexpectedBetweenRightBracketAndTrailingClosure?.raw,
      trailingClosure?.raw,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.subscriptExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SubscriptExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SubscriptExprSyntax")
  public static func makeBlankSubscriptExpr(presence: SourcePresence = .present) -> SubscriptExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .subscriptExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return SubscriptExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OptionalChainingExprSyntax")
  public static func makeOptionalChainingExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax) -> OptionalChainingExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalChainingExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return OptionalChainingExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OptionalChainingExprSyntax")
  public static func makeBlankOptionalChainingExpr(presence: SourcePresence = .present) -> OptionalChainingExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .optionalChainingExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: .default),
    ], arena: .default))
    return OptionalChainingExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ForcedValueExprSyntax")
  public static func makeForcedValueExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndExclamationMark: UnexpectedNodesSyntax? = nil, exclamationMark: TokenSyntax) -> ForcedValueExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndExclamationMark?.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.forcedValueExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ForcedValueExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ForcedValueExprSyntax")
  public static func makeBlankForcedValueExpr(presence: SourcePresence = .present) -> ForcedValueExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .forcedValueExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.exclamationMark, arena: .default),
    ], arena: .default))
    return ForcedValueExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PostfixUnaryExprSyntax")
  public static func makePostfixUnaryExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndOperatorToken: UnexpectedNodesSyntax? = nil, operatorToken: TokenSyntax) -> PostfixUnaryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndOperatorToken?.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.postfixUnaryExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PostfixUnaryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PostfixUnaryExprSyntax")
  public static func makeBlankPostfixUnaryExpr(presence: SourcePresence = .present) -> PostfixUnaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .postfixUnaryExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.postfixOperator(""), arena: .default),
    ], arena: .default))
    return PostfixUnaryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SpecializeExprSyntax")
  public static func makeSpecializeExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax) -> SpecializeExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndGenericArgumentClause?.raw,
      genericArgumentClause.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.specializeExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SpecializeExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SpecializeExprSyntax")
  public static func makeBlankSpecializeExpr(presence: SourcePresence = .present) -> SpecializeExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .specializeExpr,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericArgumentClause, arena: .default),
    ], arena: .default))
    return SpecializeExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on StringSegmentSyntax")
  public static func makeStringSegment(_ unexpectedBeforeContent: UnexpectedNodesSyntax? = nil, content: TokenSyntax) -> StringSegmentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeContent?.raw,
      content.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringSegment,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return StringSegmentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on StringSegmentSyntax")
  public static func makeBlankStringSegment(presence: SourcePresence = .present) -> StringSegmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .stringSegment,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.stringSegment(""), arena: .default),
    ], arena: .default))
    return StringSegmentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExpressionSegmentSyntax")
  public static func makeExpressionSegment(_ unexpectedBeforeBackslash: UnexpectedNodesSyntax? = nil, backslash: TokenSyntax, _ unexpectedBetweenBackslashAndDelimiter: UnexpectedNodesSyntax? = nil, delimiter: TokenSyntax?, _ unexpectedBetweenDelimiterAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndExpressions: UnexpectedNodesSyntax? = nil, expressions: TupleExprElementListSyntax, _ unexpectedBetweenExpressionsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> ExpressionSegmentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBackslash?.raw,
      backslash.raw,
      unexpectedBetweenBackslashAndDelimiter?.raw,
      delimiter?.raw,
      unexpectedBetweenDelimiterAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndExpressions?.raw,
      expressions.raw,
      unexpectedBetweenExpressionsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.expressionSegment,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ExpressionSegmentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExpressionSegmentSyntax")
  public static func makeBlankExpressionSegment(presence: SourcePresence = .present) -> ExpressionSegmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .expressionSegment,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.backslash, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.stringInterpolationAnchor, arena: .default),
    ], arena: .default))
    return ExpressionSegmentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on StringLiteralExprSyntax")
  public static func makeStringLiteralExpr(_ unexpectedBeforeOpenDelimiter: UnexpectedNodesSyntax? = nil, openDelimiter: TokenSyntax?, _ unexpectedBetweenOpenDelimiterAndOpenQuote: UnexpectedNodesSyntax? = nil, openQuote: TokenSyntax, _ unexpectedBetweenOpenQuoteAndSegments: UnexpectedNodesSyntax? = nil, segments: StringLiteralSegmentsSyntax, _ unexpectedBetweenSegmentsAndCloseQuote: UnexpectedNodesSyntax? = nil, closeQuote: TokenSyntax, _ unexpectedBetweenCloseQuoteAndCloseDelimiter: UnexpectedNodesSyntax? = nil, closeDelimiter: TokenSyntax?) -> StringLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOpenDelimiter?.raw,
      openDelimiter?.raw,
      unexpectedBetweenOpenDelimiterAndOpenQuote?.raw,
      openQuote.raw,
      unexpectedBetweenOpenQuoteAndSegments?.raw,
      segments.raw,
      unexpectedBetweenSegmentsAndCloseQuote?.raw,
      closeQuote.raw,
      unexpectedBetweenCloseQuoteAndCloseDelimiter?.raw,
      closeDelimiter?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return StringLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on StringLiteralExprSyntax")
  public static func makeBlankStringLiteralExpr(presence: SourcePresence = .present) -> StringLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .stringLiteralExpr,
      from: [
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.stringQuote, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralSegments, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.stringQuote, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return StringLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on RegexLiteralExprSyntax")
  public static func makeRegexLiteralExpr(_ unexpectedBeforeRegex: UnexpectedNodesSyntax? = nil, regex: TokenSyntax) -> RegexLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeRegex?.raw,
      regex.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.regexLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return RegexLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on RegexLiteralExprSyntax")
  public static func makeBlankRegexLiteralExpr(presence: SourcePresence = .present) -> RegexLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .regexLiteralExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.regexLiteral(""), arena: .default),
    ], arena: .default))
    return RegexLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathExprSyntax")
  public static func makeKeyPathExpr(_ unexpectedBeforeBackslash: UnexpectedNodesSyntax? = nil, backslash: TokenSyntax, _ unexpectedBetweenBackslashAndRoot: UnexpectedNodesSyntax? = nil, root: TypeSyntax?, _ unexpectedBetweenRootAndComponents: UnexpectedNodesSyntax? = nil, components: KeyPathComponentListSyntax) -> KeyPathExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBackslash?.raw,
      backslash.raw,
      unexpectedBetweenBackslashAndRoot?.raw,
      root?.raw,
      unexpectedBetweenRootAndComponents?.raw,
      components.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return KeyPathExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathExprSyntax")
  public static func makeBlankKeyPathExpr(presence: SourcePresence = .present) -> KeyPathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.backslash, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.keyPathComponentList, arena: .default),
    ], arena: .default))
    return KeyPathExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathComponentListSyntax")
  public static func makeKeyPathComponentList(
    _ elements: [KeyPathComponentSyntax]) -> KeyPathComponentListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathComponentList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return KeyPathComponentListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathComponentListSyntax")
  public static func makeBlankKeyPathComponentList(presence: SourcePresence = .present) -> KeyPathComponentListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathComponentList,
      from: [
    ], arena: .default))
    return KeyPathComponentListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathComponentSyntax")
  public static func makeKeyPathComponent(_ unexpectedBeforePeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax?, _ unexpectedBetweenPeriodAndComponent: UnexpectedNodesSyntax? = nil, component: Syntax) -> KeyPathComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePeriod?.raw,
      period?.raw,
      unexpectedBetweenPeriodAndComponent?.raw,
      component.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return KeyPathComponentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathComponentSyntax")
  public static func makeBlankKeyPathComponent(presence: SourcePresence = .present) -> KeyPathComponentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathComponent,
      from: [
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
    ], arena: .default))
    return KeyPathComponentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathPropertyComponentSyntax")
  public static func makeKeyPathPropertyComponent(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?, _ unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?) -> KeyPathPropertyComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndDeclNameArguments?.raw,
      declNameArguments?.raw,
      unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathPropertyComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return KeyPathPropertyComponentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathPropertyComponentSyntax")
  public static func makeBlankKeyPathPropertyComponent(presence: SourcePresence = .present) -> KeyPathPropertyComponentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathPropertyComponent,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return KeyPathPropertyComponentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathSubscriptComponentSyntax")
  public static func makeKeyPathSubscriptComponent(_ unexpectedBeforeLeftBracket: UnexpectedNodesSyntax? = nil, leftBracket: TokenSyntax, _ unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? = nil, rightBracket: TokenSyntax) -> KeyPathSubscriptComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBracket?.raw,
      leftBracket.raw,
      unexpectedBetweenLeftBracketAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightBracket?.raw,
      rightBracket.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathSubscriptComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return KeyPathSubscriptComponentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathSubscriptComponentSyntax")
  public static func makeBlankKeyPathSubscriptComponent(presence: SourcePresence = .present) -> KeyPathSubscriptComponentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathSubscriptComponent,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default),
    ], arena: .default))
    return KeyPathSubscriptComponentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathOptionalComponentSyntax")
  public static func makeKeyPathOptionalComponent(_ unexpectedBeforeQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax) -> KeyPathOptionalComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeQuestionOrExclamationMark?.raw,
      questionOrExclamationMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathOptionalComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return KeyPathOptionalComponentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathOptionalComponentSyntax")
  public static func makeBlankKeyPathOptionalComponent(presence: SourcePresence = .present) -> KeyPathOptionalComponentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathOptionalComponent,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: .default),
    ], arena: .default))
    return KeyPathOptionalComponentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OldKeyPathExprSyntax")
  public static func makeOldKeyPathExpr(_ unexpectedBeforeBackslash: UnexpectedNodesSyntax? = nil, backslash: TokenSyntax, _ unexpectedBetweenBackslashAndRootExpr: UnexpectedNodesSyntax? = nil, rootExpr: ExprSyntax?, _ unexpectedBetweenRootExprAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax) -> OldKeyPathExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBackslash?.raw,
      backslash.raw,
      unexpectedBetweenBackslashAndRootExpr?.raw,
      rootExpr?.raw,
      unexpectedBetweenRootExprAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.oldKeyPathExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return OldKeyPathExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OldKeyPathExprSyntax")
  public static func makeBlankOldKeyPathExpr(presence: SourcePresence = .present) -> OldKeyPathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .oldKeyPathExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.backslash, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return OldKeyPathExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathBaseExprSyntax")
  public static func makeKeyPathBaseExpr(_ unexpectedBeforePeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax) -> KeyPathBaseExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePeriod?.raw,
      period.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathBaseExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return KeyPathBaseExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathBaseExprSyntax")
  public static func makeBlankKeyPathBaseExpr(presence: SourcePresence = .present) -> KeyPathBaseExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathBaseExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default),
    ], arena: .default))
    return KeyPathBaseExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjcNamePieceSyntax")
  public static func makeObjcNamePiece(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndDot: UnexpectedNodesSyntax? = nil, dot: TokenSyntax?) -> ObjcNamePieceSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndDot?.raw,
      dot?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objcNamePiece,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ObjcNamePieceSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjcNamePieceSyntax")
  public static func makeBlankObjcNamePiece(presence: SourcePresence = .present) -> ObjcNamePieceSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objcNamePiece,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return ObjcNamePieceSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjcNameSyntax")
  public static func makeObjcName(
    _ elements: [ObjcNamePieceSyntax]) -> ObjcNameSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objcName,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ObjcNameSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjcNameSyntax")
  public static func makeBlankObjcName(presence: SourcePresence = .present) -> ObjcNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objcName,
      from: [
    ], arena: .default))
    return ObjcNameSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjcKeyPathExprSyntax")
  public static func makeObjcKeyPathExpr(_ unexpectedBeforeKeyPath: UnexpectedNodesSyntax? = nil, keyPath: TokenSyntax, _ unexpectedBetweenKeyPathAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? = nil, name: ObjcNameSyntax, _ unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> ObjcKeyPathExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeKeyPath?.raw,
      keyPath.raw,
      unexpectedBetweenKeyPathAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objcKeyPathExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ObjcKeyPathExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjcKeyPathExprSyntax")
  public static func makeBlankObjcKeyPathExpr(presence: SourcePresence = .present) -> ObjcKeyPathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objcKeyPathExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundKeyPathKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.objcName, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return ObjcKeyPathExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjcSelectorExprSyntax")
  public static func makeObjcSelectorExpr(_ unexpectedBeforePoundSelector: UnexpectedNodesSyntax? = nil, poundSelector: TokenSyntax, _ unexpectedBetweenPoundSelectorAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndKind: UnexpectedNodesSyntax? = nil, kind: TokenSyntax?, _ unexpectedBetweenKindAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndName: UnexpectedNodesSyntax? = nil, name: ExprSyntax, _ unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> ObjcSelectorExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundSelector?.raw,
      poundSelector.raw,
      unexpectedBetweenPoundSelectorAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndKind?.raw,
      kind?.raw,
      unexpectedBetweenKindAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objcSelectorExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ObjcSelectorExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjcSelectorExprSyntax")
  public static func makeBlankObjcSelectorExpr(presence: SourcePresence = .present) -> ObjcSelectorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objcSelectorExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundSelectorKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return ObjcSelectorExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PostfixIfConfigExprSyntax")
  public static func makePostfixIfConfigExpr(_ unexpectedBeforeBase: UnexpectedNodesSyntax? = nil, base: ExprSyntax?, _ unexpectedBetweenBaseAndConfig: UnexpectedNodesSyntax? = nil, config: IfConfigDeclSyntax) -> PostfixIfConfigExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBase?.raw,
      base?.raw,
      unexpectedBetweenBaseAndConfig?.raw,
      config.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.postfixIfConfigExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PostfixIfConfigExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PostfixIfConfigExprSyntax")
  public static func makeBlankPostfixIfConfigExpr(presence: SourcePresence = .present) -> PostfixIfConfigExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .postfixIfConfigExpr,
      from: [
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.ifConfigDecl, arena: .default),
    ], arena: .default))
    return PostfixIfConfigExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EditorPlaceholderExprSyntax")
  public static func makeEditorPlaceholderExpr(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax) -> EditorPlaceholderExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.editorPlaceholderExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return EditorPlaceholderExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EditorPlaceholderExprSyntax")
  public static func makeBlankEditorPlaceholderExpr(presence: SourcePresence = .present) -> EditorPlaceholderExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .editorPlaceholderExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
    ], arena: .default))
    return EditorPlaceholderExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjectLiteralExprSyntax")
  public static func makeObjectLiteralExpr(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil, arguments: TupleExprElementListSyntax, _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> ObjectLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objectLiteralExpr,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ObjectLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjectLiteralExprSyntax")
  public static func makeBlankObjectLiteralExpr(presence: SourcePresence = .present) -> ObjectLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objectLiteralExpr,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundColorLiteralKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return ObjectLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on YieldExprListSyntax")
  public static func makeYieldExprList(
    _ elements: [YieldExprListElementSyntax]) -> YieldExprListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldExprList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return YieldExprListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on YieldExprListSyntax")
  public static func makeBlankYieldExprList(presence: SourcePresence = .present) -> YieldExprListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .yieldExprList,
      from: [
    ], arena: .default))
    return YieldExprListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on YieldExprListElementSyntax")
  public static func makeYieldExprListElement(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?) -> YieldExprListElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndComma?.raw,
      comma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldExprListElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return YieldExprListElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on YieldExprListElementSyntax")
  public static func makeBlankYieldExprListElement(presence: SourcePresence = .present) -> YieldExprListElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .yieldExprListElement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return YieldExprListElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypeInitializerClauseSyntax")
  public static func makeTypeInitializerClause(_ unexpectedBeforeEqual: UnexpectedNodesSyntax? = nil, equal: TokenSyntax, _ unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? = nil, value: TypeSyntax) -> TypeInitializerClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEqual?.raw,
      equal.raw,
      unexpectedBetweenEqualAndValue?.raw,
      value.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeInitializerClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TypeInitializerClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypeInitializerClauseSyntax")
  public static func makeBlankTypeInitializerClause(presence: SourcePresence = .present) -> TypeInitializerClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typeInitializerClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return TypeInitializerClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypealiasDeclSyntax")
  public static func makeTypealiasDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndTypealiasKeyword: UnexpectedNodesSyntax? = nil, typealiasKeyword: TokenSyntax, _ unexpectedBetweenTypealiasKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndInitializer: UnexpectedNodesSyntax? = nil, initializer: TypeInitializerClauseSyntax, _ unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?) -> TypealiasDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndTypealiasKeyword?.raw,
      typealiasKeyword.raw,
      unexpectedBetweenTypealiasKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndInitializer?.raw,
      initializer.raw,
      unexpectedBetweenInitializerAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typealiasDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TypealiasDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypealiasDeclSyntax")
  public static func makeBlankTypealiasDecl(presence: SourcePresence = .present) -> TypealiasDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typealiasDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.typealiasKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.typeInitializerClause, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return TypealiasDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AssociatedtypeDeclSyntax")
  public static func makeAssociatedtypeDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndAssociatedtypeKeyword: UnexpectedNodesSyntax? = nil, associatedtypeKeyword: TokenSyntax, _ unexpectedBetweenAssociatedtypeKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndInitializer: UnexpectedNodesSyntax? = nil, initializer: TypeInitializerClauseSyntax?, _ unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndAssociatedtypeKeyword?.raw,
      associatedtypeKeyword.raw,
      unexpectedBetweenAssociatedtypeKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndInitializer?.raw,
      initializer?.raw,
      unexpectedBetweenInitializerAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.associatedtypeDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AssociatedtypeDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AssociatedtypeDeclSyntax")
  public static func makeBlankAssociatedtypeDecl(presence: SourcePresence = .present) -> AssociatedtypeDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .associatedtypeDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.associatedtypeKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return AssociatedtypeDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionParameterListSyntax")
  public static func makeFunctionParameterList(
    _ elements: [FunctionParameterSyntax]) -> FunctionParameterListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionParameterList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FunctionParameterListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionParameterListSyntax")
  public static func makeBlankFunctionParameterList(presence: SourcePresence = .present) -> FunctionParameterListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionParameterList,
      from: [
    ], arena: .default))
    return FunctionParameterListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ParameterClauseSyntax")
  public static func makeParameterClause(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndParameterList: UnexpectedNodesSyntax? = nil, parameterList: FunctionParameterListSyntax, _ unexpectedBetweenParameterListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> ParameterClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndParameterList?.raw,
      parameterList.raw,
      unexpectedBetweenParameterListAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.parameterClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ParameterClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ParameterClauseSyntax")
  public static func makeBlankParameterClause(presence: SourcePresence = .present) -> ParameterClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .parameterClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionParameterList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return ParameterClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ReturnClauseSyntax")
  public static func makeReturnClause(_ unexpectedBeforeArrow: UnexpectedNodesSyntax? = nil, arrow: TokenSyntax, _ unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? = nil, returnType: TypeSyntax) -> ReturnClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeArrow?.raw,
      arrow.raw,
      unexpectedBetweenArrowAndReturnType?.raw,
      returnType.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.returnClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ReturnClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ReturnClauseSyntax")
  public static func makeBlankReturnClause(presence: SourcePresence = .present) -> ReturnClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .returnClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return ReturnClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionSignatureSyntax")
  public static func makeFunctionSignature(_ unexpectedBeforeInput: UnexpectedNodesSyntax? = nil, input: ParameterClauseSyntax, _ unexpectedBetweenInputAndAsyncOrReasyncKeyword: UnexpectedNodesSyntax? = nil, asyncOrReasyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: UnexpectedNodesSyntax? = nil, throwsOrRethrowsKeyword: TokenSyntax?, _ unexpectedBetweenThrowsOrRethrowsKeywordAndOutput: UnexpectedNodesSyntax? = nil, output: ReturnClauseSyntax?) -> FunctionSignatureSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeInput?.raw,
      input.raw,
      unexpectedBetweenInputAndAsyncOrReasyncKeyword?.raw,
      asyncOrReasyncKeyword?.raw,
      unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      unexpectedBetweenThrowsOrRethrowsKeywordAndOutput?.raw,
      output?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionSignature,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FunctionSignatureSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionSignatureSyntax")
  public static func makeBlankFunctionSignature(presence: SourcePresence = .present) -> FunctionSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionSignature,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.parameterClause, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return FunctionSignatureSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IfConfigClauseSyntax")
  public static func makeIfConfigClause(_ unexpectedBeforePoundKeyword: UnexpectedNodesSyntax? = nil, poundKeyword: TokenSyntax, _ unexpectedBetweenPoundKeywordAndCondition: UnexpectedNodesSyntax? = nil, condition: ExprSyntax?, _ unexpectedBetweenConditionAndElements: UnexpectedNodesSyntax? = nil, elements: Syntax) -> IfConfigClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundKeyword?.raw,
      poundKeyword.raw,
      unexpectedBetweenPoundKeywordAndCondition?.raw,
      condition?.raw,
      unexpectedBetweenConditionAndElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IfConfigClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IfConfigClauseSyntax")
  public static func makeBlankIfConfigClause(presence: SourcePresence = .present) -> IfConfigClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ifConfigClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundIfKeyword, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
    ], arena: .default))
    return IfConfigClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IfConfigClauseListSyntax")
  public static func makeIfConfigClauseList(
    _ elements: [IfConfigClauseSyntax]) -> IfConfigClauseListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigClauseList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IfConfigClauseListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IfConfigClauseListSyntax")
  public static func makeBlankIfConfigClauseList(presence: SourcePresence = .present) -> IfConfigClauseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ifConfigClauseList,
      from: [
    ], arena: .default))
    return IfConfigClauseListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IfConfigDeclSyntax")
  public static func makeIfConfigDecl(_ unexpectedBeforeClauses: UnexpectedNodesSyntax? = nil, clauses: IfConfigClauseListSyntax, _ unexpectedBetweenClausesAndPoundEndif: UnexpectedNodesSyntax? = nil, poundEndif: TokenSyntax) -> IfConfigDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeClauses?.raw,
      clauses.raw,
      unexpectedBetweenClausesAndPoundEndif?.raw,
      poundEndif.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IfConfigDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IfConfigDeclSyntax")
  public static func makeBlankIfConfigDecl(presence: SourcePresence = .present) -> IfConfigDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ifConfigDecl,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.ifConfigClauseList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundEndifKeyword, arena: .default),
    ], arena: .default))
    return IfConfigDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundErrorDeclSyntax")
  public static func makePoundErrorDecl(_ unexpectedBeforePoundError: UnexpectedNodesSyntax? = nil, poundError: TokenSyntax, _ unexpectedBetweenPoundErrorAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? = nil, message: StringLiteralExprSyntax, _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> PoundErrorDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundError?.raw,
      poundError.raw,
      unexpectedBetweenPoundErrorAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndMessage?.raw,
      message.raw,
      unexpectedBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundErrorDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundErrorDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundErrorDeclSyntax")
  public static func makeBlankPoundErrorDecl(presence: SourcePresence = .present) -> PoundErrorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundErrorDecl,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundErrorKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return PoundErrorDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundWarningDeclSyntax")
  public static func makePoundWarningDecl(_ unexpectedBeforePoundWarning: UnexpectedNodesSyntax? = nil, poundWarning: TokenSyntax, _ unexpectedBetweenPoundWarningAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? = nil, message: StringLiteralExprSyntax, _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> PoundWarningDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundWarning?.raw,
      poundWarning.raw,
      unexpectedBetweenPoundWarningAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndMessage?.raw,
      message.raw,
      unexpectedBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundWarningDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundWarningDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundWarningDeclSyntax")
  public static func makeBlankPoundWarningDecl(presence: SourcePresence = .present) -> PoundWarningDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundWarningDecl,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundWarningKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return PoundWarningDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundSourceLocationSyntax")
  public static func makePoundSourceLocation(_ unexpectedBeforePoundSourceLocation: UnexpectedNodesSyntax? = nil, poundSourceLocation: TokenSyntax, _ unexpectedBetweenPoundSourceLocationAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndArgs: UnexpectedNodesSyntax? = nil, args: PoundSourceLocationArgsSyntax?, _ unexpectedBetweenArgsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> PoundSourceLocationSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundSourceLocation?.raw,
      poundSourceLocation.raw,
      unexpectedBetweenPoundSourceLocationAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArgs?.raw,
      args?.raw,
      unexpectedBetweenArgsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundSourceLocation,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundSourceLocationSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundSourceLocationSyntax")
  public static func makeBlankPoundSourceLocation(presence: SourcePresence = .present) -> PoundSourceLocationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundSourceLocation,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundSourceLocationKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return PoundSourceLocationSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundSourceLocationArgsSyntax")
  public static func makePoundSourceLocationArgs(_ unexpectedBeforeFileArgLabel: UnexpectedNodesSyntax? = nil, fileArgLabel: TokenSyntax, _ unexpectedBetweenFileArgLabelAndFileArgColon: UnexpectedNodesSyntax? = nil, fileArgColon: TokenSyntax, _ unexpectedBetweenFileArgColonAndFileName: UnexpectedNodesSyntax? = nil, fileName: TokenSyntax, _ unexpectedBetweenFileNameAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax, _ unexpectedBetweenCommaAndLineArgLabel: UnexpectedNodesSyntax? = nil, lineArgLabel: TokenSyntax, _ unexpectedBetweenLineArgLabelAndLineArgColon: UnexpectedNodesSyntax? = nil, lineArgColon: TokenSyntax, _ unexpectedBetweenLineArgColonAndLineNumber: UnexpectedNodesSyntax? = nil, lineNumber: TokenSyntax) -> PoundSourceLocationArgsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeFileArgLabel?.raw,
      fileArgLabel.raw,
      unexpectedBetweenFileArgLabelAndFileArgColon?.raw,
      fileArgColon.raw,
      unexpectedBetweenFileArgColonAndFileName?.raw,
      fileName.raw,
      unexpectedBetweenFileNameAndComma?.raw,
      comma.raw,
      unexpectedBetweenCommaAndLineArgLabel?.raw,
      lineArgLabel.raw,
      unexpectedBetweenLineArgLabelAndLineArgColon?.raw,
      lineArgColon.raw,
      unexpectedBetweenLineArgColonAndLineNumber?.raw,
      lineNumber.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundSourceLocationArgs,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundSourceLocationArgsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundSourceLocationArgsSyntax")
  public static func makeBlankPoundSourceLocationArgs(presence: SourcePresence = .present) -> PoundSourceLocationArgsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundSourceLocationArgs,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.stringLiteral(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: .default),
    ], arena: .default))
    return PoundSourceLocationArgsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclModifierDetailSyntax")
  public static func makeDeclModifierDetail(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndDetail: UnexpectedNodesSyntax? = nil, detail: TokenSyntax, _ unexpectedBetweenDetailAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> DeclModifierDetailSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndDetail?.raw,
      detail.raw,
      unexpectedBetweenDetailAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declModifierDetail,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeclModifierDetailSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclModifierDetailSyntax")
  public static func makeBlankDeclModifierDetail(presence: SourcePresence = .present) -> DeclModifierDetailSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declModifierDetail,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return DeclModifierDetailSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclModifierSyntax")
  public static func makeDeclModifier(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndDetail: UnexpectedNodesSyntax? = nil, detail: DeclModifierDetailSyntax?) -> DeclModifierSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndDetail?.raw,
      detail?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declModifier,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeclModifierSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclModifierSyntax")
  public static func makeBlankDeclModifier(presence: SourcePresence = .present) -> DeclModifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declModifier,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return DeclModifierSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InheritedTypeSyntax")
  public static func makeInheritedType(_ unexpectedBeforeTypeName: UnexpectedNodesSyntax? = nil, typeName: TypeSyntax, _ unexpectedBetweenTypeNameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> InheritedTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeTypeName?.raw,
      typeName.raw,
      unexpectedBetweenTypeNameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.inheritedType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return InheritedTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InheritedTypeSyntax")
  public static func makeBlankInheritedType(presence: SourcePresence = .present) -> InheritedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .inheritedType,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return InheritedTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InheritedTypeListSyntax")
  public static func makeInheritedTypeList(
    _ elements: [InheritedTypeSyntax]) -> InheritedTypeListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.inheritedTypeList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return InheritedTypeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InheritedTypeListSyntax")
  public static func makeBlankInheritedTypeList(presence: SourcePresence = .present) -> InheritedTypeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .inheritedTypeList,
      from: [
    ], arena: .default))
    return InheritedTypeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypeInheritanceClauseSyntax")
  public static func makeTypeInheritanceClause(_ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndInheritedTypeCollection: UnexpectedNodesSyntax? = nil, inheritedTypeCollection: InheritedTypeListSyntax) -> TypeInheritanceClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndInheritedTypeCollection?.raw,
      inheritedTypeCollection.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeInheritanceClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TypeInheritanceClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypeInheritanceClauseSyntax")
  public static func makeBlankTypeInheritanceClause(presence: SourcePresence = .present) -> TypeInheritanceClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typeInheritanceClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.inheritedTypeList, arena: .default),
    ], arena: .default))
    return TypeInheritanceClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClassDeclSyntax")
  public static func makeClassDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndClassKeyword: UnexpectedNodesSyntax? = nil, classKeyword: TokenSyntax, _ unexpectedBetweenClassKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> ClassDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndClassKeyword?.raw,
      classKeyword.raw,
      unexpectedBetweenClassKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.classDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClassDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClassDeclSyntax")
  public static func makeBlankClassDecl(presence: SourcePresence = .present) -> ClassDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .classDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.classKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default),
    ], arena: .default))
    return ClassDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ActorDeclSyntax")
  public static func makeActorDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndActorKeyword: UnexpectedNodesSyntax? = nil, actorKeyword: TokenSyntax, _ unexpectedBetweenActorKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> ActorDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndActorKeyword?.raw,
      actorKeyword.raw,
      unexpectedBetweenActorKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.actorDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ActorDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ActorDeclSyntax")
  public static func makeBlankActorDecl(presence: SourcePresence = .present) -> ActorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .actorDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default),
    ], arena: .default))
    return ActorDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on StructDeclSyntax")
  public static func makeStructDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndStructKeyword: UnexpectedNodesSyntax? = nil, structKeyword: TokenSyntax, _ unexpectedBetweenStructKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> StructDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndStructKeyword?.raw,
      structKeyword.raw,
      unexpectedBetweenStructKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.structDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return StructDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on StructDeclSyntax")
  public static func makeBlankStructDecl(presence: SourcePresence = .present) -> StructDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .structDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.structKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default),
    ], arena: .default))
    return StructDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ProtocolDeclSyntax")
  public static func makeProtocolDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndProtocolKeyword: UnexpectedNodesSyntax? = nil, protocolKeyword: TokenSyntax, _ unexpectedBetweenProtocolKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: UnexpectedNodesSyntax? = nil, primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax?, _ unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> ProtocolDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndProtocolKeyword?.raw,
      protocolKeyword.raw,
      unexpectedBetweenProtocolKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause?.raw,
      primaryAssociatedTypeClause?.raw,
      unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.protocolDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ProtocolDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ProtocolDeclSyntax")
  public static func makeBlankProtocolDecl(presence: SourcePresence = .present) -> ProtocolDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .protocolDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.protocolKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default),
    ], arena: .default))
    return ProtocolDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExtensionDeclSyntax")
  public static func makeExtensionDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndExtensionKeyword: UnexpectedNodesSyntax? = nil, extensionKeyword: TokenSyntax, _ unexpectedBetweenExtensionKeywordAndExtendedType: UnexpectedNodesSyntax? = nil, extendedType: TypeSyntax, _ unexpectedBetweenExtendedTypeAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> ExtensionDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndExtensionKeyword?.raw,
      extensionKeyword.raw,
      unexpectedBetweenExtensionKeywordAndExtendedType?.raw,
      extendedType.raw,
      unexpectedBetweenExtendedTypeAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.extensionDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ExtensionDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExtensionDeclSyntax")
  public static func makeBlankExtensionDecl(presence: SourcePresence = .present) -> ExtensionDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .extensionDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.extensionKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default),
    ], arena: .default))
    return ExtensionDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclBlockSyntax")
  public static func makeMemberDeclBlock(_ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclListSyntax, _ unexpectedBetweenMembersAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax) -> MemberDeclBlockSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndMembers?.raw,
      members.raw,
      unexpectedBetweenMembersAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclBlock,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclBlockSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclBlockSyntax")
  public static func makeBlankMemberDeclBlock(presence: SourcePresence = .present) -> MemberDeclBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberDeclBlock,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default),
    ], arena: .default))
    return MemberDeclBlockSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclListSyntax")
  public static func makeMemberDeclList(
    _ elements: [MemberDeclListItemSyntax]) -> MemberDeclListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclListSyntax")
  public static func makeBlankMemberDeclList(presence: SourcePresence = .present) -> MemberDeclListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberDeclList,
      from: [
    ], arena: .default))
    return MemberDeclListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclListItemSyntax")
  public static func makeMemberDeclListItem(_ unexpectedBeforeDecl: UnexpectedNodesSyntax? = nil, decl: DeclSyntax, _ unexpectedBetweenDeclAndSemicolon: UnexpectedNodesSyntax? = nil, semicolon: TokenSyntax?) -> MemberDeclListItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDecl?.raw,
      decl.raw,
      unexpectedBetweenDeclAndSemicolon?.raw,
      semicolon?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclListItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclListItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclListItemSyntax")
  public static func makeBlankMemberDeclListItem(presence: SourcePresence = .present) -> MemberDeclListItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberDeclListItem,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingDecl, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return MemberDeclListItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SourceFileSyntax")
  public static func makeSourceFile(_ unexpectedBeforeStatements: UnexpectedNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ unexpectedBetweenStatementsAndEOFToken: UnexpectedNodesSyntax? = nil, eofToken: TokenSyntax) -> SourceFileSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndEOFToken?.raw,
      eofToken.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.sourceFile,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SourceFileSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SourceFileSyntax")
  public static func makeBlankSourceFile(presence: SourcePresence = .present) -> SourceFileSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .sourceFile,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
    ], arena: .default))
    return SourceFileSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InitializerClauseSyntax")
  public static func makeInitializerClause(_ unexpectedBeforeEqual: UnexpectedNodesSyntax? = nil, equal: TokenSyntax, _ unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? = nil, value: ExprSyntax) -> InitializerClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEqual?.raw,
      equal.raw,
      unexpectedBetweenEqualAndValue?.raw,
      value.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.initializerClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return InitializerClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InitializerClauseSyntax")
  public static func makeBlankInitializerClause(presence: SourcePresence = .present) -> InitializerClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .initializerClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return InitializerClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionParameterSyntax")
  public static func makeFunctionParameter(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndFirstName: UnexpectedNodesSyntax? = nil, firstName: TokenSyntax?, _ unexpectedBetweenFirstNameAndSecondName: UnexpectedNodesSyntax? = nil, secondName: TokenSyntax?, _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax?, _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil, ellipsis: TokenSyntax?, _ unexpectedBetweenEllipsisAndDefaultArgument: UnexpectedNodesSyntax? = nil, defaultArgument: InitializerClauseSyntax?, _ unexpectedBetweenDefaultArgumentAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> FunctionParameterSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndFirstName?.raw,
      firstName?.raw,
      unexpectedBetweenFirstNameAndSecondName?.raw,
      secondName?.raw,
      unexpectedBetweenSecondNameAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndType?.raw,
      type?.raw,
      unexpectedBetweenTypeAndEllipsis?.raw,
      ellipsis?.raw,
      unexpectedBetweenEllipsisAndDefaultArgument?.raw,
      defaultArgument?.raw,
      unexpectedBetweenDefaultArgumentAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionParameter,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FunctionParameterSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionParameterSyntax")
  public static func makeBlankFunctionParameter(presence: SourcePresence = .present) -> FunctionParameterSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionParameter,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return FunctionParameterSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ModifierListSyntax")
  public static func makeModifierList(
    _ elements: [DeclModifierSyntax]) -> ModifierListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ModifierListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ModifierListSyntax")
  public static func makeBlankModifierList(presence: SourcePresence = .present) -> ModifierListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .modifierList,
      from: [
    ], arena: .default))
    return ModifierListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionDeclSyntax")
  public static func makeFunctionDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndFuncKeyword: UnexpectedNodesSyntax? = nil, funcKeyword: TokenSyntax, _ unexpectedBetweenFuncKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil, signature: FunctionSignatureSyntax, _ unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndFuncKeyword?.raw,
      funcKeyword.raw,
      unexpectedBetweenFuncKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      unexpectedBetweenSignatureAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FunctionDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionDeclSyntax")
  public static func makeBlankFunctionDecl(presence: SourcePresence = .present) -> FunctionDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.funcKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionSignature, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return FunctionDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InitializerDeclSyntax")
  public static func makeInitializerDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndInitKeyword: UnexpectedNodesSyntax? = nil, initKeyword: TokenSyntax, _ unexpectedBetweenInitKeywordAndOptionalMark: UnexpectedNodesSyntax? = nil, optionalMark: TokenSyntax?, _ unexpectedBetweenOptionalMarkAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil, signature: FunctionSignatureSyntax, _ unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax?) -> InitializerDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndInitKeyword?.raw,
      initKeyword.raw,
      unexpectedBetweenInitKeywordAndOptionalMark?.raw,
      optionalMark?.raw,
      unexpectedBetweenOptionalMarkAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      unexpectedBetweenSignatureAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.initializerDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return InitializerDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InitializerDeclSyntax")
  public static func makeBlankInitializerDecl(presence: SourcePresence = .present) -> InitializerDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .initializerDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.initKeyword, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionSignature, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return InitializerDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeinitializerDeclSyntax")
  public static func makeDeinitializerDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndDeinitKeyword: UnexpectedNodesSyntax? = nil, deinitKeyword: TokenSyntax, _ unexpectedBetweenDeinitKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax?) -> DeinitializerDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndDeinitKeyword?.raw,
      deinitKeyword.raw,
      unexpectedBetweenDeinitKeywordAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.deinitializerDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeinitializerDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeinitializerDeclSyntax")
  public static func makeBlankDeinitializerDecl(presence: SourcePresence = .present) -> DeinitializerDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .deinitializerDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.deinitKeyword, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return DeinitializerDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SubscriptDeclSyntax")
  public static func makeSubscriptDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndSubscriptKeyword: UnexpectedNodesSyntax? = nil, subscriptKeyword: TokenSyntax, _ unexpectedBetweenSubscriptKeywordAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndIndices: UnexpectedNodesSyntax? = nil, indices: ParameterClauseSyntax, _ unexpectedBetweenIndicesAndResult: UnexpectedNodesSyntax? = nil, result: ReturnClauseSyntax, _ unexpectedBetweenResultAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndAccessor: UnexpectedNodesSyntax? = nil, accessor: Syntax?) -> SubscriptDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndSubscriptKeyword?.raw,
      subscriptKeyword.raw,
      unexpectedBetweenSubscriptKeywordAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndIndices?.raw,
      indices.raw,
      unexpectedBetweenIndicesAndResult?.raw,
      result.raw,
      unexpectedBetweenResultAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndAccessor?.raw,
      accessor?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.subscriptDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SubscriptDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SubscriptDeclSyntax")
  public static func makeBlankSubscriptDecl(presence: SourcePresence = .present) -> SubscriptDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .subscriptDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.subscriptKeyword, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.parameterClause, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.returnClause, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return SubscriptDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessLevelModifierSyntax")
  public static func makeAccessLevelModifier(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndModifier: UnexpectedNodesSyntax? = nil, modifier: DeclModifierDetailSyntax?) -> AccessLevelModifierSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndModifier?.raw,
      modifier?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessLevelModifier,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AccessLevelModifierSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessLevelModifierSyntax")
  public static func makeBlankAccessLevelModifier(presence: SourcePresence = .present) -> AccessLevelModifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessLevelModifier,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return AccessLevelModifierSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessPathComponentSyntax")
  public static func makeAccessPathComponent(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndTrailingDot: UnexpectedNodesSyntax? = nil, trailingDot: TokenSyntax?) -> AccessPathComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingDot?.raw,
      trailingDot?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessPathComponent,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AccessPathComponentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessPathComponentSyntax")
  public static func makeBlankAccessPathComponent(presence: SourcePresence = .present) -> AccessPathComponentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessPathComponent,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return AccessPathComponentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessPathSyntax")
  public static func makeAccessPath(
    _ elements: [AccessPathComponentSyntax]) -> AccessPathSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessPath,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AccessPathSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessPathSyntax")
  public static func makeBlankAccessPath(presence: SourcePresence = .present) -> AccessPathSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessPath,
      from: [
    ], arena: .default))
    return AccessPathSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ImportDeclSyntax")
  public static func makeImportDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndImportTok: UnexpectedNodesSyntax? = nil, importTok: TokenSyntax, _ unexpectedBetweenImportTokAndImportKind: UnexpectedNodesSyntax? = nil, importKind: TokenSyntax?, _ unexpectedBetweenImportKindAndPath: UnexpectedNodesSyntax? = nil, path: AccessPathSyntax) -> ImportDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndImportTok?.raw,
      importTok.raw,
      unexpectedBetweenImportTokAndImportKind?.raw,
      importKind?.raw,
      unexpectedBetweenImportKindAndPath?.raw,
      path.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.importDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ImportDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ImportDeclSyntax")
  public static func makeBlankImportDecl(presence: SourcePresence = .present) -> ImportDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .importDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.importKeyword, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.accessPath, arena: .default),
    ], arena: .default))
    return ImportDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessorParameterSyntax")
  public static func makeAccessorParameter(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> AccessorParameterSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorParameter,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AccessorParameterSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessorParameterSyntax")
  public static func makeBlankAccessorParameter(presence: SourcePresence = .present) -> AccessorParameterSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessorParameter,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return AccessorParameterSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessorDeclSyntax")
  public static func makeAccessorDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifier: UnexpectedNodesSyntax? = nil, modifier: DeclModifierSyntax?, _ unexpectedBetweenModifierAndAccessorKind: UnexpectedNodesSyntax? = nil, accessorKind: TokenSyntax, _ unexpectedBetweenAccessorKindAndParameter: UnexpectedNodesSyntax? = nil, parameter: AccessorParameterSyntax?, _ unexpectedBetweenParameterAndAsyncKeyword: UnexpectedNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncKeywordAndThrowsKeyword: UnexpectedNodesSyntax? = nil, throwsKeyword: TokenSyntax?, _ unexpectedBetweenThrowsKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax?) -> AccessorDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifier?.raw,
      modifier?.raw,
      unexpectedBetweenModifierAndAccessorKind?.raw,
      accessorKind.raw,
      unexpectedBetweenAccessorKindAndParameter?.raw,
      parameter?.raw,
      unexpectedBetweenParameterAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      unexpectedBetweenAsyncKeywordAndThrowsKeyword?.raw,
      throwsKeyword?.raw,
      unexpectedBetweenThrowsKeywordAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AccessorDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessorDeclSyntax")
  public static func makeBlankAccessorDecl(presence: SourcePresence = .present) -> AccessorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessorDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return AccessorDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessorListSyntax")
  public static func makeAccessorList(
    _ elements: [AccessorDeclSyntax]) -> AccessorListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AccessorListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessorListSyntax")
  public static func makeBlankAccessorList(presence: SourcePresence = .present) -> AccessorListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessorList,
      from: [
    ], arena: .default))
    return AccessorListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessorBlockSyntax")
  public static func makeAccessorBlock(_ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndAccessors: UnexpectedNodesSyntax? = nil, accessors: AccessorListSyntax, _ unexpectedBetweenAccessorsAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax) -> AccessorBlockSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndAccessors?.raw,
      accessors.raw,
      unexpectedBetweenAccessorsAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorBlock,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AccessorBlockSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessorBlockSyntax")
  public static func makeBlankAccessorBlock(presence: SourcePresence = .present) -> AccessorBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessorBlock,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.accessorList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default),
    ], arena: .default))
    return AccessorBlockSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PatternBindingSyntax")
  public static func makePatternBinding(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil, initializer: InitializerClauseSyntax?, _ unexpectedBetweenInitializerAndAccessor: UnexpectedNodesSyntax? = nil, accessor: Syntax?, _ unexpectedBetweenAccessorAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> PatternBindingSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      unexpectedBetweenTypeAnnotationAndInitializer?.raw,
      initializer?.raw,
      unexpectedBetweenInitializerAndAccessor?.raw,
      accessor?.raw,
      unexpectedBetweenAccessorAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.patternBinding,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PatternBindingSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PatternBindingSyntax")
  public static func makeBlankPatternBinding(presence: SourcePresence = .present) -> PatternBindingSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .patternBinding,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return PatternBindingSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PatternBindingListSyntax")
  public static func makePatternBindingList(
    _ elements: [PatternBindingSyntax]) -> PatternBindingListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.patternBindingList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PatternBindingListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PatternBindingListSyntax")
  public static func makeBlankPatternBindingList(presence: SourcePresence = .present) -> PatternBindingListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .patternBindingList,
      from: [
    ], arena: .default))
    return PatternBindingListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on VariableDeclSyntax")
  public static func makeVariableDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndLetOrVarKeyword: UnexpectedNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ unexpectedBetweenLetOrVarKeywordAndBindings: UnexpectedNodesSyntax? = nil, bindings: PatternBindingListSyntax) -> VariableDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      unexpectedBetweenLetOrVarKeywordAndBindings?.raw,
      bindings.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.variableDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return VariableDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on VariableDeclSyntax")
  public static func makeBlankVariableDecl(presence: SourcePresence = .present) -> VariableDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .variableDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.patternBindingList, arena: .default),
    ], arena: .default))
    return VariableDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseElementSyntax")
  public static func makeEnumCaseElement(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndAssociatedValue: UnexpectedNodesSyntax? = nil, associatedValue: ParameterClauseSyntax?, _ unexpectedBetweenAssociatedValueAndRawValue: UnexpectedNodesSyntax? = nil, rawValue: InitializerClauseSyntax?, _ unexpectedBetweenRawValueAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> EnumCaseElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndAssociatedValue?.raw,
      associatedValue?.raw,
      unexpectedBetweenAssociatedValueAndRawValue?.raw,
      rawValue?.raw,
      unexpectedBetweenRawValueAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseElementSyntax")
  public static func makeBlankEnumCaseElement(presence: SourcePresence = .present) -> EnumCaseElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumCaseElement,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return EnumCaseElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseElementListSyntax")
  public static func makeEnumCaseElementList(
    _ elements: [EnumCaseElementSyntax]) -> EnumCaseElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseElementListSyntax")
  public static func makeBlankEnumCaseElementList(presence: SourcePresence = .present) -> EnumCaseElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumCaseElementList,
      from: [
    ], arena: .default))
    return EnumCaseElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseDeclSyntax")
  public static func makeEnumCaseDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndCaseKeyword: UnexpectedNodesSyntax? = nil, caseKeyword: TokenSyntax, _ unexpectedBetweenCaseKeywordAndElements: UnexpectedNodesSyntax? = nil, elements: EnumCaseElementListSyntax) -> EnumCaseDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndCaseKeyword?.raw,
      caseKeyword.raw,
      unexpectedBetweenCaseKeywordAndElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseDeclSyntax")
  public static func makeBlankEnumCaseDecl(presence: SourcePresence = .present) -> EnumCaseDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumCaseDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.enumCaseElementList, arena: .default),
    ], arena: .default))
    return EnumCaseDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumDeclSyntax")
  public static func makeEnumDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndEnumKeyword: UnexpectedNodesSyntax? = nil, enumKeyword: TokenSyntax, _ unexpectedBetweenEnumKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? = nil, genericParameters: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> EnumDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndEnumKeyword?.raw,
      enumKeyword.raw,
      unexpectedBetweenEnumKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameters?.raw,
      genericParameters?.raw,
      unexpectedBetweenGenericParametersAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      unexpectedBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return EnumDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumDeclSyntax")
  public static func makeBlankEnumDecl(presence: SourcePresence = .present) -> EnumDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.enumKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: .default),
    ], arena: .default))
    return EnumDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OperatorDeclSyntax")
  public static func makeOperatorDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndOperatorKeyword: UnexpectedNodesSyntax? = nil, operatorKeyword: TokenSyntax, _ unexpectedBetweenOperatorKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? = nil, operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax?) -> OperatorDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndOperatorKeyword?.raw,
      operatorKeyword.raw,
      unexpectedBetweenOperatorKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes?.raw,
      operatorPrecedenceAndTypes?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.operatorDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return OperatorDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OperatorDeclSyntax")
  public static func makeBlankOperatorDecl(presence: SourcePresence = .present) -> OperatorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .operatorDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.operatorKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unspacedBinaryOperator(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return OperatorDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DesignatedTypeListSyntax")
  public static func makeDesignatedTypeList(
    _ elements: [DesignatedTypeElementSyntax]) -> DesignatedTypeListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.designatedTypeList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DesignatedTypeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DesignatedTypeListSyntax")
  public static func makeBlankDesignatedTypeList(presence: SourcePresence = .present) -> DesignatedTypeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .designatedTypeList,
      from: [
    ], arena: .default))
    return DesignatedTypeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DesignatedTypeElementSyntax")
  public static func makeDesignatedTypeElement(_ unexpectedBeforeLeadingComma: UnexpectedNodesSyntax? = nil, leadingComma: TokenSyntax, _ unexpectedBetweenLeadingCommaAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax) -> DesignatedTypeElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeadingComma?.raw,
      leadingComma.raw,
      unexpectedBetweenLeadingCommaAndName?.raw,
      name.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.designatedTypeElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DesignatedTypeElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DesignatedTypeElementSyntax")
  public static func makeBlankDesignatedTypeElement(presence: SourcePresence = .present) -> DesignatedTypeElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .designatedTypeElement,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
    ], arena: .default))
    return DesignatedTypeElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OperatorPrecedenceAndTypesSyntax")
  public static func makeOperatorPrecedenceAndTypes(_ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndPrecedenceGroup: UnexpectedNodesSyntax? = nil, precedenceGroup: TokenSyntax, _ unexpectedBetweenPrecedenceGroupAndDesignatedTypes: UnexpectedNodesSyntax? = nil, designatedTypes: DesignatedTypeListSyntax) -> OperatorPrecedenceAndTypesSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndPrecedenceGroup?.raw,
      precedenceGroup.raw,
      unexpectedBetweenPrecedenceGroupAndDesignatedTypes?.raw,
      designatedTypes.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.operatorPrecedenceAndTypes,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return OperatorPrecedenceAndTypesSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OperatorPrecedenceAndTypesSyntax")
  public static func makeBlankOperatorPrecedenceAndTypes(presence: SourcePresence = .present) -> OperatorPrecedenceAndTypesSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .operatorPrecedenceAndTypes,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.designatedTypeList, arena: .default),
    ], arena: .default))
    return OperatorPrecedenceAndTypesSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupDeclSyntax")
  public static func makePrecedenceGroupDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndPrecedencegroupKeyword: UnexpectedNodesSyntax? = nil, precedencegroupKeyword: TokenSyntax, _ unexpectedBetweenPrecedencegroupKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndGroupAttributes: UnexpectedNodesSyntax? = nil, groupAttributes: PrecedenceGroupAttributeListSyntax, _ unexpectedBetweenGroupAttributesAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax) -> PrecedenceGroupDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndPrecedencegroupKeyword?.raw,
      precedencegroupKeyword.raw,
      unexpectedBetweenPrecedencegroupKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndGroupAttributes?.raw,
      groupAttributes.raw,
      unexpectedBetweenGroupAttributesAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupDecl,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupDeclSyntax")
  public static func makeBlankPrecedenceGroupDecl(presence: SourcePresence = .present) -> PrecedenceGroupDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupDecl,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.precedencegroupKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.precedenceGroupAttributeList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default),
    ], arena: .default))
    return PrecedenceGroupDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAttributeListSyntax")
  public static func makePrecedenceGroupAttributeList(
    _ elements: [Syntax]) -> PrecedenceGroupAttributeListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAttributeList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAttributeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAttributeListSyntax")
  public static func makeBlankPrecedenceGroupAttributeList(presence: SourcePresence = .present) -> PrecedenceGroupAttributeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupAttributeList,
      from: [
    ], arena: .default))
    return PrecedenceGroupAttributeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupRelationSyntax")
  public static func makePrecedenceGroupRelation(_ unexpectedBeforeHigherThanOrLowerThan: UnexpectedNodesSyntax? = nil, higherThanOrLowerThan: TokenSyntax, _ unexpectedBetweenHigherThanOrLowerThanAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndOtherNames: UnexpectedNodesSyntax? = nil, otherNames: PrecedenceGroupNameListSyntax) -> PrecedenceGroupRelationSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeHigherThanOrLowerThan?.raw,
      higherThanOrLowerThan.raw,
      unexpectedBetweenHigherThanOrLowerThanAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndOtherNames?.raw,
      otherNames.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupRelation,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupRelationSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupRelationSyntax")
  public static func makeBlankPrecedenceGroupRelation(presence: SourcePresence = .present) -> PrecedenceGroupRelationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupRelation,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.precedenceGroupNameList, arena: .default),
    ], arena: .default))
    return PrecedenceGroupRelationSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameListSyntax")
  public static func makePrecedenceGroupNameList(
    _ elements: [PrecedenceGroupNameElementSyntax]) -> PrecedenceGroupNameListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupNameList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupNameListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameListSyntax")
  public static func makeBlankPrecedenceGroupNameList(presence: SourcePresence = .present) -> PrecedenceGroupNameListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupNameList,
      from: [
    ], arena: .default))
    return PrecedenceGroupNameListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameElementSyntax")
  public static func makePrecedenceGroupNameElement(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> PrecedenceGroupNameElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupNameElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupNameElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameElementSyntax")
  public static func makeBlankPrecedenceGroupNameElement(presence: SourcePresence = .present) -> PrecedenceGroupNameElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupNameElement,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return PrecedenceGroupNameElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssignmentSyntax")
  public static func makePrecedenceGroupAssignment(_ unexpectedBeforeAssignmentKeyword: UnexpectedNodesSyntax? = nil, assignmentKeyword: TokenSyntax, _ unexpectedBetweenAssignmentKeywordAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndFlag: UnexpectedNodesSyntax? = nil, flag: TokenSyntax) -> PrecedenceGroupAssignmentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssignmentKeyword?.raw,
      assignmentKeyword.raw,
      unexpectedBetweenAssignmentKeywordAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndFlag?.raw,
      flag.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAssignment,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAssignmentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssignmentSyntax")
  public static func makeBlankPrecedenceGroupAssignment(presence: SourcePresence = .present) -> PrecedenceGroupAssignmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupAssignment,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.trueKeyword, arena: .default),
    ], arena: .default))
    return PrecedenceGroupAssignmentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssociativitySyntax")
  public static func makePrecedenceGroupAssociativity(_ unexpectedBeforeAssociativityKeyword: UnexpectedNodesSyntax? = nil, associativityKeyword: TokenSyntax, _ unexpectedBetweenAssociativityKeywordAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil, value: TokenSyntax) -> PrecedenceGroupAssociativitySyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssociativityKeyword?.raw,
      associativityKeyword.raw,
      unexpectedBetweenAssociativityKeywordAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValue?.raw,
      value.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAssociativity,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAssociativitySyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssociativitySyntax")
  public static func makeBlankPrecedenceGroupAssociativity(presence: SourcePresence = .present) -> PrecedenceGroupAssociativitySyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupAssociativity,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
    ], arena: .default))
    return PrecedenceGroupAssociativitySyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TokenListSyntax")
  public static func makeTokenList(
    _ elements: [TokenSyntax]) -> TokenListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tokenList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TokenListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TokenListSyntax")
  public static func makeBlankTokenList(presence: SourcePresence = .present) -> TokenListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tokenList,
      from: [
    ], arena: .default))
    return TokenListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on NonEmptyTokenListSyntax")
  public static func makeNonEmptyTokenList(
    _ elements: [TokenSyntax]) -> NonEmptyTokenListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.nonEmptyTokenList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return NonEmptyTokenListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on NonEmptyTokenListSyntax")
  public static func makeBlankNonEmptyTokenList(presence: SourcePresence = .present) -> NonEmptyTokenListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .nonEmptyTokenList,
      from: [
    ], arena: .default))
    return NonEmptyTokenListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CustomAttributeSyntax")
  public static func makeCustomAttribute(_ unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? = nil, atSignToken: TokenSyntax, _ unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? = nil, attributeName: TypeSyntax, _ unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax?, _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?) -> CustomAttributeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAtSignToken?.raw,
      atSignToken.raw,
      unexpectedBetweenAtSignTokenAndAttributeName?.raw,
      attributeName.raw,
      unexpectedBetweenAttributeNameAndLeftParen?.raw,
      leftParen?.raw,
      unexpectedBetweenLeftParenAndArgumentList?.raw,
      argumentList?.raw,
      unexpectedBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.customAttribute,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CustomAttributeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CustomAttributeSyntax")
  public static func makeBlankCustomAttribute(presence: SourcePresence = .present) -> CustomAttributeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .customAttribute,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.atSign, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return CustomAttributeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AttributeSyntax")
  public static func makeAttribute(_ unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? = nil, atSignToken: TokenSyntax, _ unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? = nil, attributeName: TokenSyntax, _ unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndArgument: UnexpectedNodesSyntax? = nil, argument: Syntax?, _ unexpectedBetweenArgumentAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?, _ unexpectedBetweenRightParenAndTokenList: UnexpectedNodesSyntax? = nil, tokenList: TokenListSyntax?) -> AttributeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAtSignToken?.raw,
      atSignToken.raw,
      unexpectedBetweenAtSignTokenAndAttributeName?.raw,
      attributeName.raw,
      unexpectedBetweenAttributeNameAndLeftParen?.raw,
      leftParen?.raw,
      unexpectedBetweenLeftParenAndArgument?.raw,
      argument?.raw,
      unexpectedBetweenArgumentAndRightParen?.raw,
      rightParen?.raw,
      unexpectedBetweenRightParenAndTokenList?.raw,
      tokenList?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.attribute,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AttributeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AttributeSyntax")
  public static func makeBlankAttribute(presence: SourcePresence = .present) -> AttributeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .attribute,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.atSign, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return AttributeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AttributeListSyntax")
  public static func makeAttributeList(
    _ elements: [Syntax]) -> AttributeListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AttributeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AttributeListSyntax")
  public static func makeBlankAttributeList(presence: SourcePresence = .present) -> AttributeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .attributeList,
      from: [
    ], arena: .default))
    return AttributeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SpecializeAttributeSpecListSyntax")
  public static func makeSpecializeAttributeSpecList(
    _ elements: [Syntax]) -> SpecializeAttributeSpecListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.specializeAttributeSpecList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SpecializeAttributeSpecListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SpecializeAttributeSpecListSyntax")
  public static func makeBlankSpecializeAttributeSpecList(presence: SourcePresence = .present) -> SpecializeAttributeSpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .specializeAttributeSpecList,
      from: [
    ], arena: .default))
    return SpecializeAttributeSpecListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityEntrySyntax")
  public static func makeAvailabilityEntry(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndAvailabilityList: UnexpectedNodesSyntax? = nil, availabilityList: AvailabilitySpecListSyntax, _ unexpectedBetweenAvailabilityListAndSemicolon: UnexpectedNodesSyntax? = nil, semicolon: TokenSyntax) -> AvailabilityEntrySyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndAvailabilityList?.raw,
      availabilityList.raw,
      unexpectedBetweenAvailabilityListAndSemicolon?.raw,
      semicolon.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityEntry,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityEntrySyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityEntrySyntax")
  public static func makeBlankAvailabilityEntry(presence: SourcePresence = .present) -> AvailabilityEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityEntry,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.semicolon, arena: .default),
    ], arena: .default))
    return AvailabilityEntrySyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on LabeledSpecializeEntrySyntax")
  public static func makeLabeledSpecializeEntry(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil, value: TokenSyntax, _ unexpectedBetweenValueAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValue?.raw,
      value.raw,
      unexpectedBetweenValueAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.labeledSpecializeEntry,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return LabeledSpecializeEntrySyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on LabeledSpecializeEntrySyntax")
  public static func makeBlankLabeledSpecializeEntry(presence: SourcePresence = .present) -> LabeledSpecializeEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .labeledSpecializeEntry,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return LabeledSpecializeEntrySyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TargetFunctionEntrySyntax")
  public static func makeTargetFunctionEntry(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndDeclname: UnexpectedNodesSyntax? = nil, declname: DeclNameSyntax, _ unexpectedBetweenDeclnameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> TargetFunctionEntrySyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndDeclname?.raw,
      declname.raw,
      unexpectedBetweenDeclnameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.targetFunctionEntry,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TargetFunctionEntrySyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TargetFunctionEntrySyntax")
  public static func makeBlankTargetFunctionEntry(presence: SourcePresence = .present) -> TargetFunctionEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .targetFunctionEntry,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.declName, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return TargetFunctionEntrySyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on NamedAttributeStringArgumentSyntax")
  public static func makeNamedAttributeStringArgument(_ unexpectedBeforeNameTok: UnexpectedNodesSyntax? = nil, nameTok: TokenSyntax, _ unexpectedBetweenNameTokAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndStringOrDeclname: UnexpectedNodesSyntax? = nil, stringOrDeclname: Syntax) -> NamedAttributeStringArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeNameTok?.raw,
      nameTok.raw,
      unexpectedBetweenNameTokAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndStringOrDeclname?.raw,
      stringOrDeclname.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.namedAttributeStringArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return NamedAttributeStringArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on NamedAttributeStringArgumentSyntax")
  public static func makeBlankNamedAttributeStringArgument(presence: SourcePresence = .present) -> NamedAttributeStringArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .namedAttributeStringArgument,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
    ], arena: .default))
    return NamedAttributeStringArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclNameSyntax")
  public static func makeDeclName(_ unexpectedBeforeDeclBaseName: UnexpectedNodesSyntax? = nil, declBaseName: Syntax, _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?) -> DeclNameSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDeclBaseName?.raw,
      declBaseName.raw,
      unexpectedBetweenDeclBaseNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declName,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeclNameSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclNameSyntax")
  public static func makeBlankDeclName(presence: SourcePresence = .present) -> DeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declName,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return DeclNameSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ImplementsAttributeArgumentsSyntax")
  public static func makeImplementsAttributeArguments(_ unexpectedBeforeType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedBetweenTypeAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax, _ unexpectedBetweenCommaAndDeclBaseName: UnexpectedNodesSyntax? = nil, declBaseName: TokenSyntax, _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type.raw,
      unexpectedBetweenTypeAndComma?.raw,
      comma.raw,
      unexpectedBetweenCommaAndDeclBaseName?.raw,
      declBaseName.raw,
      unexpectedBetweenDeclBaseNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.implementsAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ImplementsAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ImplementsAttributeArgumentsSyntax")
  public static func makeBlankImplementsAttributeArguments(presence: SourcePresence = .present) -> ImplementsAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .implementsAttributeArguments,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return ImplementsAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjCSelectorPieceSyntax")
  public static func makeObjCSelectorPiece(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax?, _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?) -> ObjCSelectorPieceSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name?.raw,
      unexpectedBetweenNameAndColon?.raw,
      colon?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objCSelectorPiece,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ObjCSelectorPieceSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjCSelectorPieceSyntax")
  public static func makeBlankObjCSelectorPiece(presence: SourcePresence = .present) -> ObjCSelectorPieceSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objCSelectorPiece,
      from: [
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return ObjCSelectorPieceSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjCSelectorSyntax")
  public static func makeObjCSelector(
    _ elements: [ObjCSelectorPieceSyntax]) -> ObjCSelectorSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.objCSelector,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ObjCSelectorSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjCSelectorSyntax")
  public static func makeBlankObjCSelector(presence: SourcePresence = .present) -> ObjCSelectorSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objCSelector,
      from: [
    ], arena: .default))
    return ObjCSelectorSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiableAttributeArgumentsSyntax")
  public static func makeDifferentiableAttributeArguments(_ unexpectedBeforeDiffKind: UnexpectedNodesSyntax? = nil, diffKind: TokenSyntax?, _ unexpectedBetweenDiffKindAndDiffKindComma: UnexpectedNodesSyntax? = nil, diffKindComma: TokenSyntax?, _ unexpectedBetweenDiffKindCommaAndDiffParams: UnexpectedNodesSyntax? = nil, diffParams: DifferentiabilityParamsClauseSyntax?, _ unexpectedBetweenDiffParamsAndDiffParamsComma: UnexpectedNodesSyntax? = nil, diffParamsComma: TokenSyntax?, _ unexpectedBetweenDiffParamsCommaAndWhereClause: UnexpectedNodesSyntax? = nil, whereClause: GenericWhereClauseSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDiffKind?.raw,
      diffKind?.raw,
      unexpectedBetweenDiffKindAndDiffKindComma?.raw,
      diffKindComma?.raw,
      unexpectedBetweenDiffKindCommaAndDiffParams?.raw,
      diffParams?.raw,
      unexpectedBetweenDiffParamsAndDiffParamsComma?.raw,
      diffParamsComma?.raw,
      unexpectedBetweenDiffParamsCommaAndWhereClause?.raw,
      whereClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiableAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DifferentiableAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiableAttributeArgumentsSyntax")
  public static func makeBlankDifferentiableAttributeArguments(presence: SourcePresence = .present) -> DifferentiableAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiableAttributeArguments,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return DifferentiableAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsClauseSyntax")
  public static func makeDifferentiabilityParamsClause(_ unexpectedBeforeWrtLabel: UnexpectedNodesSyntax? = nil, wrtLabel: TokenSyntax, _ unexpectedBetweenWrtLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndParameters: UnexpectedNodesSyntax? = nil, parameters: Syntax) -> DifferentiabilityParamsClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrtLabel?.raw,
      wrtLabel.raw,
      unexpectedBetweenWrtLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndParameters?.raw,
      parameters.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParamsClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamsClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsClauseSyntax")
  public static func makeBlankDifferentiabilityParamsClause(presence: SourcePresence = .present) -> DifferentiabilityParamsClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiabilityParamsClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
    ], arena: .default))
    return DifferentiabilityParamsClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsSyntax")
  public static func makeDifferentiabilityParams(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndDiffParams: UnexpectedNodesSyntax? = nil, diffParams: DifferentiabilityParamListSyntax, _ unexpectedBetweenDiffParamsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> DifferentiabilityParamsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndDiffParams?.raw,
      diffParams.raw,
      unexpectedBetweenDiffParamsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParams,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsSyntax")
  public static func makeBlankDifferentiabilityParams(presence: SourcePresence = .present) -> DifferentiabilityParamsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiabilityParams,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.differentiabilityParamList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return DifferentiabilityParamsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamListSyntax")
  public static func makeDifferentiabilityParamList(
    _ elements: [DifferentiabilityParamSyntax]) -> DifferentiabilityParamListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParamList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamListSyntax")
  public static func makeBlankDifferentiabilityParamList(presence: SourcePresence = .present) -> DifferentiabilityParamListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiabilityParamList,
      from: [
    ], arena: .default))
    return DifferentiabilityParamListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamSyntax")
  public static func makeDifferentiabilityParam(_ unexpectedBeforeParameter: UnexpectedNodesSyntax? = nil, parameter: Syntax, _ unexpectedBetweenParameterAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> DifferentiabilityParamSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeParameter?.raw,
      parameter.raw,
      unexpectedBetweenParameterAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParam,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamSyntax")
  public static func makeBlankDifferentiabilityParam(presence: SourcePresence = .present) -> DifferentiabilityParamSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiabilityParam,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return DifferentiabilityParamSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DerivativeRegistrationAttributeArgumentsSyntax")
  public static func makeDerivativeRegistrationAttributeArguments(_ unexpectedBeforeOfLabel: UnexpectedNodesSyntax? = nil, ofLabel: TokenSyntax, _ unexpectedBetweenOfLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndOriginalDeclName: UnexpectedNodesSyntax? = nil, originalDeclName: QualifiedDeclNameSyntax, _ unexpectedBetweenOriginalDeclNameAndPeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax?, _ unexpectedBetweenPeriodAndAccessorKind: UnexpectedNodesSyntax? = nil, accessorKind: TokenSyntax?, _ unexpectedBetweenAccessorKindAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedBetweenCommaAndDiffParams: UnexpectedNodesSyntax? = nil, diffParams: DifferentiabilityParamsClauseSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOfLabel?.raw,
      ofLabel.raw,
      unexpectedBetweenOfLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndOriginalDeclName?.raw,
      originalDeclName.raw,
      unexpectedBetweenOriginalDeclNameAndPeriod?.raw,
      period?.raw,
      unexpectedBetweenPeriodAndAccessorKind?.raw,
      accessorKind?.raw,
      unexpectedBetweenAccessorKindAndComma?.raw,
      comma?.raw,
      unexpectedBetweenCommaAndDiffParams?.raw,
      diffParams?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.derivativeRegistrationAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DerivativeRegistrationAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DerivativeRegistrationAttributeArgumentsSyntax")
  public static func makeBlankDerivativeRegistrationAttributeArguments(presence: SourcePresence = .present) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .derivativeRegistrationAttributeArguments,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.qualifiedDeclName, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return DerivativeRegistrationAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on QualifiedDeclNameSyntax")
  public static func makeQualifiedDeclName(_ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax?, _ unexpectedBetweenBaseTypeAndDot: UnexpectedNodesSyntax? = nil, dot: TokenSyntax?, _ unexpectedBetweenDotAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? = nil, arguments: DeclNameArgumentsSyntax?) -> QualifiedDeclNameSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBaseType?.raw,
      baseType?.raw,
      unexpectedBetweenBaseTypeAndDot?.raw,
      dot?.raw,
      unexpectedBetweenDotAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndArguments?.raw,
      arguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.qualifiedDeclName,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return QualifiedDeclNameSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on QualifiedDeclNameSyntax")
  public static func makeBlankQualifiedDeclName(presence: SourcePresence = .present) -> QualifiedDeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .qualifiedDeclName,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return QualifiedDeclNameSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionDeclNameSyntax")
  public static func makeFunctionDeclName(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: Syntax, _ unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? = nil, arguments: DeclNameArgumentsSyntax?) -> FunctionDeclNameSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndArguments?.raw,
      arguments?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionDeclName,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FunctionDeclNameSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionDeclNameSyntax")
  public static func makeBlankFunctionDeclName(presence: SourcePresence = .present) -> FunctionDeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionDeclName,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return FunctionDeclNameSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BackDeployAttributeSpecListSyntax")
  public static func makeBackDeployAttributeSpecList(_ unexpectedBeforeBeforeLabel: UnexpectedNodesSyntax? = nil, beforeLabel: TokenSyntax, _ unexpectedBetweenBeforeLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndVersionList: UnexpectedNodesSyntax? = nil, versionList: BackDeployVersionListSyntax) -> BackDeployAttributeSpecListSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBeforeLabel?.raw,
      beforeLabel.raw,
      unexpectedBetweenBeforeLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndVersionList?.raw,
      versionList.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployAttributeSpecList,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return BackDeployAttributeSpecListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BackDeployAttributeSpecListSyntax")
  public static func makeBlankBackDeployAttributeSpecList(presence: SourcePresence = .present) -> BackDeployAttributeSpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .backDeployAttributeSpecList,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.backDeployVersionList, arena: .default),
    ], arena: .default))
    return BackDeployAttributeSpecListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BackDeployVersionListSyntax")
  public static func makeBackDeployVersionList(
    _ elements: [BackDeployVersionArgumentSyntax]) -> BackDeployVersionListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployVersionList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return BackDeployVersionListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BackDeployVersionListSyntax")
  public static func makeBlankBackDeployVersionList(presence: SourcePresence = .present) -> BackDeployVersionListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .backDeployVersionList,
      from: [
    ], arena: .default))
    return BackDeployVersionListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BackDeployVersionArgumentSyntax")
  public static func makeBackDeployVersionArgument(_ unexpectedBeforeAvailabilityVersionRestriction: UnexpectedNodesSyntax? = nil, availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax, _ unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> BackDeployVersionArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAvailabilityVersionRestriction?.raw,
      availabilityVersionRestriction.raw,
      unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployVersionArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return BackDeployVersionArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BackDeployVersionArgumentSyntax")
  public static func makeBlankBackDeployVersionArgument(presence: SourcePresence = .present) -> BackDeployVersionArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .backDeployVersionArgument,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilityVersionRestriction, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return BackDeployVersionArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OpaqueReturnTypeOfAttributeArgumentsSyntax")
  public static func makeOpaqueReturnTypeOfAttributeArguments(_ unexpectedBeforeMangledName: UnexpectedNodesSyntax? = nil, mangledName: TokenSyntax, _ unexpectedBetweenMangledNameAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax, _ unexpectedBetweenCommaAndOrdinal: UnexpectedNodesSyntax? = nil, ordinal: TokenSyntax) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMangledName?.raw,
      mangledName.raw,
      unexpectedBetweenMangledNameAndComma?.raw,
      comma.raw,
      unexpectedBetweenCommaAndOrdinal?.raw,
      ordinal.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.opaqueReturnTypeOfAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OpaqueReturnTypeOfAttributeArgumentsSyntax")
  public static func makeBlankOpaqueReturnTypeOfAttributeArguments(presence: SourcePresence = .present) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .opaqueReturnTypeOfAttributeArguments,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.stringLiteral(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: .default),
    ], arena: .default))
    return OpaqueReturnTypeOfAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConventionAttributeArgumentsSyntax")
  public static func makeConventionAttributeArguments(_ unexpectedBeforeConventionLabel: UnexpectedNodesSyntax? = nil, conventionLabel: TokenSyntax, _ unexpectedBetweenConventionLabelAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedBetweenCommaAndCTypeLabel: UnexpectedNodesSyntax? = nil, cTypeLabel: TokenSyntax?, _ unexpectedBetweenCTypeLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndCTypeString: UnexpectedNodesSyntax? = nil, cTypeString: TokenSyntax?) -> ConventionAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeConventionLabel?.raw,
      conventionLabel.raw,
      unexpectedBetweenConventionLabelAndComma?.raw,
      comma?.raw,
      unexpectedBetweenCommaAndCTypeLabel?.raw,
      cTypeLabel?.raw,
      unexpectedBetweenCTypeLabelAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndCTypeString?.raw,
      cTypeString?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conventionAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ConventionAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConventionAttributeArgumentsSyntax")
  public static func makeBlankConventionAttributeArguments(presence: SourcePresence = .present) -> ConventionAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conventionAttributeArguments,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return ConventionAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConventionWitnessMethodAttributeArgumentsSyntax")
  public static func makeConventionWitnessMethodAttributeArguments(_ unexpectedBeforeWitnessMethodLabel: UnexpectedNodesSyntax? = nil, witnessMethodLabel: TokenSyntax, _ unexpectedBetweenWitnessMethodLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndProtocolName: UnexpectedNodesSyntax? = nil, protocolName: TokenSyntax) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWitnessMethodLabel?.raw,
      witnessMethodLabel.raw,
      unexpectedBetweenWitnessMethodLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndProtocolName?.raw,
      protocolName.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conventionWitnessMethodAttributeArguments,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ConventionWitnessMethodAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConventionWitnessMethodAttributeArgumentsSyntax")
  public static func makeBlankConventionWitnessMethodAttributeArguments(presence: SourcePresence = .present) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conventionWitnessMethodAttributeArguments,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
    ], arena: .default))
    return ConventionWitnessMethodAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on LabeledStmtSyntax")
  public static func makeLabeledStmt(_ unexpectedBeforeLabelName: UnexpectedNodesSyntax? = nil, labelName: TokenSyntax, _ unexpectedBetweenLabelNameAndLabelColon: UnexpectedNodesSyntax? = nil, labelColon: TokenSyntax, _ unexpectedBetweenLabelColonAndStatement: UnexpectedNodesSyntax? = nil, statement: StmtSyntax) -> LabeledStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabelName?.raw,
      labelName.raw,
      unexpectedBetweenLabelNameAndLabelColon?.raw,
      labelColon.raw,
      unexpectedBetweenLabelColonAndStatement?.raw,
      statement.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.labeledStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return LabeledStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on LabeledStmtSyntax")
  public static func makeBlankLabeledStmt(presence: SourcePresence = .present) -> LabeledStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .labeledStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingStmt, arena: .default),
    ], arena: .default))
    return LabeledStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ContinueStmtSyntax")
  public static func makeContinueStmt(_ unexpectedBeforeContinueKeyword: UnexpectedNodesSyntax? = nil, continueKeyword: TokenSyntax, _ unexpectedBetweenContinueKeywordAndLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax?) -> ContinueStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeContinueKeyword?.raw,
      continueKeyword.raw,
      unexpectedBetweenContinueKeywordAndLabel?.raw,
      label?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.continueStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ContinueStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ContinueStmtSyntax")
  public static func makeBlankContinueStmt(presence: SourcePresence = .present) -> ContinueStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .continueStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.continueKeyword, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return ContinueStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on WhileStmtSyntax")
  public static func makeWhileStmt(_ unexpectedBeforeWhileKeyword: UnexpectedNodesSyntax? = nil, whileKeyword: TokenSyntax, _ unexpectedBetweenWhileKeywordAndConditions: UnexpectedNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ unexpectedBetweenConditionsAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax) -> WhileStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWhileKeyword?.raw,
      whileKeyword.raw,
      unexpectedBetweenWhileKeywordAndConditions?.raw,
      conditions.raw,
      unexpectedBetweenConditionsAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.whileStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return WhileStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on WhileStmtSyntax")
  public static func makeBlankWhileStmt(presence: SourcePresence = .present) -> WhileStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .whileStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.whileKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.conditionElementList, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
    ], arena: .default))
    return WhileStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeferStmtSyntax")
  public static func makeDeferStmt(_ unexpectedBeforeDeferKeyword: UnexpectedNodesSyntax? = nil, deferKeyword: TokenSyntax, _ unexpectedBetweenDeferKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax) -> DeferStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDeferKeyword?.raw,
      deferKeyword.raw,
      unexpectedBetweenDeferKeywordAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.deferStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeferStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeferStmtSyntax")
  public static func makeBlankDeferStmt(presence: SourcePresence = .present) -> DeferStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .deferStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.deferKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
    ], arena: .default))
    return DeferStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExpressionStmtSyntax")
  public static func makeExpressionStmt(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax) -> ExpressionStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.expressionStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ExpressionStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExpressionStmtSyntax")
  public static func makeBlankExpressionStmt(presence: SourcePresence = .present) -> ExpressionStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .expressionStmt,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return ExpressionStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseListSyntax")
  public static func makeSwitchCaseList(
    _ elements: [Syntax]) -> SwitchCaseListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCaseList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseListSyntax")
  public static func makeBlankSwitchCaseList(presence: SourcePresence = .present) -> SwitchCaseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchCaseList,
      from: [
    ], arena: .default))
    return SwitchCaseListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on RepeatWhileStmtSyntax")
  public static func makeRepeatWhileStmt(_ unexpectedBeforeRepeatKeyword: UnexpectedNodesSyntax? = nil, repeatKeyword: TokenSyntax, _ unexpectedBetweenRepeatKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedBetweenBodyAndWhileKeyword: UnexpectedNodesSyntax? = nil, whileKeyword: TokenSyntax, _ unexpectedBetweenWhileKeywordAndCondition: UnexpectedNodesSyntax? = nil, condition: ExprSyntax) -> RepeatWhileStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeRepeatKeyword?.raw,
      repeatKeyword.raw,
      unexpectedBetweenRepeatKeywordAndBody?.raw,
      body.raw,
      unexpectedBetweenBodyAndWhileKeyword?.raw,
      whileKeyword.raw,
      unexpectedBetweenWhileKeywordAndCondition?.raw,
      condition.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.repeatWhileStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return RepeatWhileStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on RepeatWhileStmtSyntax")
  public static func makeBlankRepeatWhileStmt(presence: SourcePresence = .present) -> RepeatWhileStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .repeatWhileStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.repeatKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.whileKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return RepeatWhileStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GuardStmtSyntax")
  public static func makeGuardStmt(_ unexpectedBeforeGuardKeyword: UnexpectedNodesSyntax? = nil, guardKeyword: TokenSyntax, _ unexpectedBetweenGuardKeywordAndConditions: UnexpectedNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ unexpectedBetweenConditionsAndElseKeyword: UnexpectedNodesSyntax? = nil, elseKeyword: TokenSyntax, _ unexpectedBetweenElseKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax) -> GuardStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeGuardKeyword?.raw,
      guardKeyword.raw,
      unexpectedBetweenGuardKeywordAndConditions?.raw,
      conditions.raw,
      unexpectedBetweenConditionsAndElseKeyword?.raw,
      elseKeyword.raw,
      unexpectedBetweenElseKeywordAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.guardStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GuardStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GuardStmtSyntax")
  public static func makeBlankGuardStmt(presence: SourcePresence = .present) -> GuardStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .guardStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.guardKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.conditionElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.elseKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
    ], arena: .default))
    return GuardStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on WhereClauseSyntax")
  public static func makeWhereClause(_ unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? = nil, whereKeyword: TokenSyntax, _ unexpectedBetweenWhereKeywordAndGuardResult: UnexpectedNodesSyntax? = nil, guardResult: ExprSyntax) -> WhereClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWhereKeyword?.raw,
      whereKeyword.raw,
      unexpectedBetweenWhereKeywordAndGuardResult?.raw,
      guardResult.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.whereClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return WhereClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on WhereClauseSyntax")
  public static func makeBlankWhereClause(presence: SourcePresence = .present) -> WhereClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .whereClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.whereKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return WhereClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ForInStmtSyntax")
  public static func makeForInStmt(_ unexpectedBeforeForKeyword: UnexpectedNodesSyntax? = nil, forKeyword: TokenSyntax, _ unexpectedBetweenForKeywordAndTryKeyword: UnexpectedNodesSyntax? = nil, tryKeyword: TokenSyntax?, _ unexpectedBetweenTryKeywordAndAwaitKeyword: UnexpectedNodesSyntax? = nil, awaitKeyword: TokenSyntax?, _ unexpectedBetweenAwaitKeywordAndCaseKeyword: UnexpectedNodesSyntax? = nil, caseKeyword: TokenSyntax?, _ unexpectedBetweenCaseKeywordAndPattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedBetweenTypeAnnotationAndInKeyword: UnexpectedNodesSyntax? = nil, inKeyword: TokenSyntax, _ unexpectedBetweenInKeywordAndSequenceExpr: UnexpectedNodesSyntax? = nil, sequenceExpr: ExprSyntax, _ unexpectedBetweenSequenceExprAndWhereClause: UnexpectedNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ unexpectedBetweenWhereClauseAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax) -> ForInStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeForKeyword?.raw,
      forKeyword.raw,
      unexpectedBetweenForKeywordAndTryKeyword?.raw,
      tryKeyword?.raw,
      unexpectedBetweenTryKeywordAndAwaitKeyword?.raw,
      awaitKeyword?.raw,
      unexpectedBetweenAwaitKeywordAndCaseKeyword?.raw,
      caseKeyword?.raw,
      unexpectedBetweenCaseKeywordAndPattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      unexpectedBetweenTypeAnnotationAndInKeyword?.raw,
      inKeyword.raw,
      unexpectedBetweenInKeywordAndSequenceExpr?.raw,
      sequenceExpr.raw,
      unexpectedBetweenSequenceExprAndWhereClause?.raw,
      whereClause?.raw,
      unexpectedBetweenWhereClauseAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.forInStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ForInStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ForInStmtSyntax")
  public static func makeBlankForInStmt(presence: SourcePresence = .present) -> ForInStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .forInStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.forKeyword, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.inKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
    ], arena: .default))
    return ForInStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchStmtSyntax")
  public static func makeSwitchStmt(_ unexpectedBeforeSwitchKeyword: UnexpectedNodesSyntax? = nil, switchKeyword: TokenSyntax, _ unexpectedBetweenSwitchKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndCases: UnexpectedNodesSyntax? = nil, cases: SwitchCaseListSyntax, _ unexpectedBetweenCasesAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax) -> SwitchStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSwitchKeyword?.raw,
      switchKeyword.raw,
      unexpectedBetweenSwitchKeywordAndExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndCases?.raw,
      cases.raw,
      unexpectedBetweenCasesAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SwitchStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchStmtSyntax")
  public static func makeBlankSwitchStmt(presence: SourcePresence = .present) -> SwitchStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.switchKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.switchCaseList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: .default),
    ], arena: .default))
    return SwitchStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CatchClauseListSyntax")
  public static func makeCatchClauseList(
    _ elements: [CatchClauseSyntax]) -> CatchClauseListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchClauseList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CatchClauseListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CatchClauseListSyntax")
  public static func makeBlankCatchClauseList(presence: SourcePresence = .present) -> CatchClauseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .catchClauseList,
      from: [
    ], arena: .default))
    return CatchClauseListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DoStmtSyntax")
  public static func makeDoStmt(_ unexpectedBeforeDoKeyword: UnexpectedNodesSyntax? = nil, doKeyword: TokenSyntax, _ unexpectedBetweenDoKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedBetweenBodyAndCatchClauses: UnexpectedNodesSyntax? = nil, catchClauses: CatchClauseListSyntax?) -> DoStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDoKeyword?.raw,
      doKeyword.raw,
      unexpectedBetweenDoKeywordAndBody?.raw,
      body.raw,
      unexpectedBetweenBodyAndCatchClauses?.raw,
      catchClauses?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.doStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DoStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DoStmtSyntax")
  public static func makeBlankDoStmt(presence: SourcePresence = .present) -> DoStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .doStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.doKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return DoStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ReturnStmtSyntax")
  public static func makeReturnStmt(_ unexpectedBeforeReturnKeyword: UnexpectedNodesSyntax? = nil, returnKeyword: TokenSyntax, _ unexpectedBetweenReturnKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax?) -> ReturnStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeReturnKeyword?.raw,
      returnKeyword.raw,
      unexpectedBetweenReturnKeywordAndExpression?.raw,
      expression?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.returnStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ReturnStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ReturnStmtSyntax")
  public static func makeBlankReturnStmt(presence: SourcePresence = .present) -> ReturnStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .returnStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.returnKeyword, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return ReturnStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on YieldStmtSyntax")
  public static func makeYieldStmt(_ unexpectedBeforeYieldKeyword: UnexpectedNodesSyntax? = nil, yieldKeyword: TokenSyntax, _ unexpectedBetweenYieldKeywordAndYields: UnexpectedNodesSyntax? = nil, yields: Syntax) -> YieldStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeYieldKeyword?.raw,
      yieldKeyword.raw,
      unexpectedBetweenYieldKeywordAndYields?.raw,
      yields.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return YieldStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on YieldStmtSyntax")
  public static func makeBlankYieldStmt(presence: SourcePresence = .present) -> YieldStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .yieldStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.yield, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
    ], arena: .default))
    return YieldStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on YieldListSyntax")
  public static func makeYieldList(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? = nil, elementList: YieldExprListSyntax, _ unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> YieldListSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      unexpectedBetweenElementListAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldList,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return YieldListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on YieldListSyntax")
  public static func makeBlankYieldList(presence: SourcePresence = .present) -> YieldListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .yieldList,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.yieldExprList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return YieldListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FallthroughStmtSyntax")
  public static func makeFallthroughStmt(_ unexpectedBeforeFallthroughKeyword: UnexpectedNodesSyntax? = nil, fallthroughKeyword: TokenSyntax) -> FallthroughStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeFallthroughKeyword?.raw,
      fallthroughKeyword.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.fallthroughStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FallthroughStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FallthroughStmtSyntax")
  public static func makeBlankFallthroughStmt(presence: SourcePresence = .present) -> FallthroughStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .fallthroughStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.fallthroughKeyword, arena: .default),
    ], arena: .default))
    return FallthroughStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BreakStmtSyntax")
  public static func makeBreakStmt(_ unexpectedBeforeBreakKeyword: UnexpectedNodesSyntax? = nil, breakKeyword: TokenSyntax, _ unexpectedBetweenBreakKeywordAndLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax?) -> BreakStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBreakKeyword?.raw,
      breakKeyword.raw,
      unexpectedBetweenBreakKeywordAndLabel?.raw,
      label?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.breakStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return BreakStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BreakStmtSyntax")
  public static func makeBlankBreakStmt(presence: SourcePresence = .present) -> BreakStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .breakStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.breakKeyword, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return BreakStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CaseItemListSyntax")
  public static func makeCaseItemList(
    _ elements: [CaseItemSyntax]) -> CaseItemListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.caseItemList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CaseItemListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CaseItemListSyntax")
  public static func makeBlankCaseItemList(presence: SourcePresence = .present) -> CaseItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .caseItemList,
      from: [
    ], arena: .default))
    return CaseItemListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CatchItemListSyntax")
  public static func makeCatchItemList(
    _ elements: [CatchItemSyntax]) -> CatchItemListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchItemList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CatchItemListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CatchItemListSyntax")
  public static func makeBlankCatchItemList(presence: SourcePresence = .present) -> CatchItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .catchItemList,
      from: [
    ], arena: .default))
    return CatchItemListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConditionElementSyntax")
  public static func makeConditionElement(_ unexpectedBeforeCondition: UnexpectedNodesSyntax? = nil, condition: Syntax, _ unexpectedBetweenConditionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> ConditionElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCondition?.raw,
      condition.raw,
      unexpectedBetweenConditionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conditionElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ConditionElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConditionElementSyntax")
  public static func makeBlankConditionElement(presence: SourcePresence = .present) -> ConditionElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conditionElement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return ConditionElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityConditionSyntax")
  public static func makeAvailabilityCondition(_ unexpectedBeforePoundAvailableKeyword: UnexpectedNodesSyntax? = nil, poundAvailableKeyword: TokenSyntax, _ unexpectedBetweenPoundAvailableKeywordAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? = nil, availabilitySpec: AvailabilitySpecListSyntax, _ unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> AvailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundAvailableKeyword?.raw,
      poundAvailableKeyword.raw,
      unexpectedBetweenPoundAvailableKeywordAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndAvailabilitySpec?.raw,
      availabilitySpec.raw,
      unexpectedBetweenAvailabilitySpecAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityConditionSyntax")
  public static func makeBlankAvailabilityCondition(presence: SourcePresence = .present) -> AvailabilityConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityCondition,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundAvailableKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return AvailabilityConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MatchingPatternConditionSyntax")
  public static func makeMatchingPatternCondition(_ unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? = nil, caseKeyword: TokenSyntax, _ unexpectedBetweenCaseKeywordAndPattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil, initializer: InitializerClauseSyntax) -> MatchingPatternConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCaseKeyword?.raw,
      caseKeyword.raw,
      unexpectedBetweenCaseKeywordAndPattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      unexpectedBetweenTypeAnnotationAndInitializer?.raw,
      initializer.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.matchingPatternCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MatchingPatternConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MatchingPatternConditionSyntax")
  public static func makeBlankMatchingPatternCondition(presence: SourcePresence = .present) -> MatchingPatternConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .matchingPatternCondition,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.initializerClause, arena: .default),
    ], arena: .default))
    return MatchingPatternConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OptionalBindingConditionSyntax")
  public static func makeOptionalBindingCondition(_ unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ unexpectedBetweenLetOrVarKeywordAndPattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil, initializer: InitializerClauseSyntax?) -> OptionalBindingConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      unexpectedBetweenLetOrVarKeywordAndPattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      unexpectedBetweenTypeAnnotationAndInitializer?.raw,
      initializer?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalBindingCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return OptionalBindingConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OptionalBindingConditionSyntax")
  public static func makeBlankOptionalBindingCondition(presence: SourcePresence = .present) -> OptionalBindingConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .optionalBindingCondition,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return OptionalBindingConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on UnavailabilityConditionSyntax")
  public static func makeUnavailabilityCondition(_ unexpectedBeforePoundUnavailableKeyword: UnexpectedNodesSyntax? = nil, poundUnavailableKeyword: TokenSyntax, _ unexpectedBetweenPoundUnavailableKeywordAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? = nil, availabilitySpec: AvailabilitySpecListSyntax, _ unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> UnavailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundUnavailableKeyword?.raw,
      poundUnavailableKeyword.raw,
      unexpectedBetweenPoundUnavailableKeywordAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndAvailabilitySpec?.raw,
      availabilitySpec.raw,
      unexpectedBetweenAvailabilitySpecAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.unavailabilityCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return UnavailabilityConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnavailabilityConditionSyntax")
  public static func makeBlankUnavailabilityCondition(presence: SourcePresence = .present) -> UnavailabilityConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unavailabilityCondition,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundUnavailableKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return UnavailabilityConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on HasSymbolConditionSyntax")
  public static func makeHasSymbolCondition(_ unexpectedBeforeHasSymbolKeyword: UnexpectedNodesSyntax? = nil, hasSymbolKeyword: TokenSyntax, _ unexpectedBetweenHasSymbolKeywordAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> HasSymbolConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeHasSymbolKeyword?.raw,
      hasSymbolKeyword.raw,
      unexpectedBetweenHasSymbolKeywordAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.hasSymbolCondition,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return HasSymbolConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on HasSymbolConditionSyntax")
  public static func makeBlankHasSymbolCondition(presence: SourcePresence = .present) -> HasSymbolConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .hasSymbolCondition,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return HasSymbolConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConditionElementListSyntax")
  public static func makeConditionElementList(
    _ elements: [ConditionElementSyntax]) -> ConditionElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conditionElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ConditionElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConditionElementListSyntax")
  public static func makeBlankConditionElementList(presence: SourcePresence = .present) -> ConditionElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conditionElementList,
      from: [
    ], arena: .default))
    return ConditionElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclarationStmtSyntax")
  public static func makeDeclarationStmt(_ unexpectedBeforeDeclaration: UnexpectedNodesSyntax? = nil, declaration: DeclSyntax) -> DeclarationStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDeclaration?.raw,
      declaration.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.declarationStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DeclarationStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclarationStmtSyntax")
  public static func makeBlankDeclarationStmt(presence: SourcePresence = .present) -> DeclarationStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declarationStmt,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingDecl, arena: .default),
    ], arena: .default))
    return DeclarationStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ThrowStmtSyntax")
  public static func makeThrowStmt(_ unexpectedBeforeThrowKeyword: UnexpectedNodesSyntax? = nil, throwKeyword: TokenSyntax, _ unexpectedBetweenThrowKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax) -> ThrowStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeThrowKeyword?.raw,
      throwKeyword.raw,
      unexpectedBetweenThrowKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.throwStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ThrowStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ThrowStmtSyntax")
  public static func makeBlankThrowStmt(presence: SourcePresence = .present) -> ThrowStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .throwStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.throwKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return ThrowStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IfStmtSyntax")
  public static func makeIfStmt(_ unexpectedBeforeIfKeyword: UnexpectedNodesSyntax? = nil, ifKeyword: TokenSyntax, _ unexpectedBetweenIfKeywordAndConditions: UnexpectedNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ unexpectedBetweenConditionsAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedBetweenBodyAndElseKeyword: UnexpectedNodesSyntax? = nil, elseKeyword: TokenSyntax?, _ unexpectedBetweenElseKeywordAndElseBody: UnexpectedNodesSyntax? = nil, elseBody: Syntax?) -> IfStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIfKeyword?.raw,
      ifKeyword.raw,
      unexpectedBetweenIfKeywordAndConditions?.raw,
      conditions.raw,
      unexpectedBetweenConditionsAndBody?.raw,
      body.raw,
      unexpectedBetweenBodyAndElseKeyword?.raw,
      elseKeyword?.raw,
      unexpectedBetweenElseKeywordAndElseBody?.raw,
      elseBody?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IfStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IfStmtSyntax")
  public static func makeBlankIfStmt(presence: SourcePresence = .present) -> IfStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ifStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.ifKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.conditionElementList, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return IfStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ElseIfContinuationSyntax")
  public static func makeElseIfContinuation(_ unexpectedBeforeIfStatement: UnexpectedNodesSyntax? = nil, ifStatement: IfStmtSyntax) -> ElseIfContinuationSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIfStatement?.raw,
      ifStatement.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.elseIfContinuation,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ElseIfContinuationSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ElseIfContinuationSyntax")
  public static func makeBlankElseIfContinuation(presence: SourcePresence = .present) -> ElseIfContinuationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .elseIfContinuation,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.ifStmt, arena: .default),
    ], arena: .default))
    return ElseIfContinuationSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ElseBlockSyntax")
  public static func makeElseBlock(_ unexpectedBeforeElseKeyword: UnexpectedNodesSyntax? = nil, elseKeyword: TokenSyntax, _ unexpectedBetweenElseKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax) -> ElseBlockSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeElseKeyword?.raw,
      elseKeyword.raw,
      unexpectedBetweenElseKeywordAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.elseBlock,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ElseBlockSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ElseBlockSyntax")
  public static func makeBlankElseBlock(presence: SourcePresence = .present) -> ElseBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .elseBlock,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.elseKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
    ], arena: .default))
    return ElseBlockSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseSyntax")
  public static func makeSwitchCase(_ unexpectedBeforeUnknownAttr: UnexpectedNodesSyntax? = nil, unknownAttr: AttributeSyntax?, _ unexpectedBetweenUnknownAttrAndLabel: UnexpectedNodesSyntax? = nil, label: Syntax, _ unexpectedBetweenLabelAndStatements: UnexpectedNodesSyntax? = nil, statements: CodeBlockItemListSyntax) -> SwitchCaseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeUnknownAttr?.raw,
      unknownAttr?.raw,
      unexpectedBetweenUnknownAttrAndLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndStatements?.raw,
      statements.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCase,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseSyntax")
  public static func makeBlankSwitchCase(presence: SourcePresence = .present) -> SwitchCaseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchCase,
      from: [
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: .default),
    ], arena: .default))
    return SwitchCaseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchDefaultLabelSyntax")
  public static func makeSwitchDefaultLabel(_ unexpectedBeforeDefaultKeyword: UnexpectedNodesSyntax? = nil, defaultKeyword: TokenSyntax, _ unexpectedBetweenDefaultKeywordAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax) -> SwitchDefaultLabelSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDefaultKeyword?.raw,
      defaultKeyword.raw,
      unexpectedBetweenDefaultKeywordAndColon?.raw,
      colon.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchDefaultLabel,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SwitchDefaultLabelSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchDefaultLabelSyntax")
  public static func makeBlankSwitchDefaultLabel(presence: SourcePresence = .present) -> SwitchDefaultLabelSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchDefaultLabel,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.defaultKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
    ], arena: .default))
    return SwitchDefaultLabelSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CaseItemSyntax")
  public static func makeCaseItem(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> CaseItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndWhereClause?.raw,
      whereClause?.raw,
      unexpectedBetweenWhereClauseAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.caseItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CaseItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CaseItemSyntax")
  public static func makeBlankCaseItem(presence: SourcePresence = .present) -> CaseItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .caseItem,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return CaseItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CatchItemSyntax")
  public static func makeCatchItem(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax?, _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> CatchItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern?.raw,
      unexpectedBetweenPatternAndWhereClause?.raw,
      whereClause?.raw,
      unexpectedBetweenWhereClauseAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchItem,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CatchItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CatchItemSyntax")
  public static func makeBlankCatchItem(presence: SourcePresence = .present) -> CatchItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .catchItem,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return CatchItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseLabelSyntax")
  public static func makeSwitchCaseLabel(_ unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? = nil, caseKeyword: TokenSyntax, _ unexpectedBetweenCaseKeywordAndCaseItems: UnexpectedNodesSyntax? = nil, caseItems: CaseItemListSyntax, _ unexpectedBetweenCaseItemsAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax) -> SwitchCaseLabelSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCaseKeyword?.raw,
      caseKeyword.raw,
      unexpectedBetweenCaseKeywordAndCaseItems?.raw,
      caseItems.raw,
      unexpectedBetweenCaseItemsAndColon?.raw,
      colon.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCaseLabel,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseLabelSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseLabelSyntax")
  public static func makeBlankSwitchCaseLabel(presence: SourcePresence = .present) -> SwitchCaseLabelSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchCaseLabel,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.caseItemList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
    ], arena: .default))
    return SwitchCaseLabelSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CatchClauseSyntax")
  public static func makeCatchClause(_ unexpectedBeforeCatchKeyword: UnexpectedNodesSyntax? = nil, catchKeyword: TokenSyntax, _ unexpectedBetweenCatchKeywordAndCatchItems: UnexpectedNodesSyntax? = nil, catchItems: CatchItemListSyntax?, _ unexpectedBetweenCatchItemsAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax) -> CatchClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCatchKeyword?.raw,
      catchKeyword.raw,
      unexpectedBetweenCatchKeywordAndCatchItems?.raw,
      catchItems?.raw,
      unexpectedBetweenCatchItemsAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CatchClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CatchClauseSyntax")
  public static func makeBlankCatchClause(presence: SourcePresence = .present) -> CatchClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .catchClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.catchKeyword, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: .default),
    ], arena: .default))
    return CatchClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundAssertStmtSyntax")
  public static func makePoundAssertStmt(_ unexpectedBeforePoundAssert: UnexpectedNodesSyntax? = nil, poundAssert: TokenSyntax, _ unexpectedBetweenPoundAssertAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndCondition: UnexpectedNodesSyntax? = nil, condition: ExprSyntax, _ unexpectedBetweenConditionAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedBetweenCommaAndMessage: UnexpectedNodesSyntax? = nil, message: TokenSyntax?, _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> PoundAssertStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundAssert?.raw,
      poundAssert.raw,
      unexpectedBetweenPoundAssertAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndCondition?.raw,
      condition.raw,
      unexpectedBetweenConditionAndComma?.raw,
      comma?.raw,
      unexpectedBetweenCommaAndMessage?.raw,
      message?.raw,
      unexpectedBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundAssertStmt,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PoundAssertStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundAssertStmtSyntax")
  public static func makeBlankPoundAssertStmt(presence: SourcePresence = .present) -> PoundAssertStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundAssertStmt,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.poundAssertKeyword, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return PoundAssertStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericWhereClauseSyntax")
  public static func makeGenericWhereClause(_ unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? = nil, whereKeyword: TokenSyntax, _ unexpectedBetweenWhereKeywordAndRequirementList: UnexpectedNodesSyntax? = nil, requirementList: GenericRequirementListSyntax) -> GenericWhereClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWhereKeyword?.raw,
      whereKeyword.raw,
      unexpectedBetweenWhereKeywordAndRequirementList?.raw,
      requirementList.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericWhereClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericWhereClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericWhereClauseSyntax")
  public static func makeBlankGenericWhereClause(presence: SourcePresence = .present) -> GenericWhereClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericWhereClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.whereKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericRequirementList, arena: .default),
    ], arena: .default))
    return GenericWhereClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericRequirementListSyntax")
  public static func makeGenericRequirementList(
    _ elements: [GenericRequirementSyntax]) -> GenericRequirementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericRequirementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericRequirementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericRequirementListSyntax")
  public static func makeBlankGenericRequirementList(presence: SourcePresence = .present) -> GenericRequirementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericRequirementList,
      from: [
    ], arena: .default))
    return GenericRequirementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericRequirementSyntax")
  public static func makeGenericRequirement(_ unexpectedBeforeBody: UnexpectedNodesSyntax? = nil, body: Syntax, _ unexpectedBetweenBodyAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> GenericRequirementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBody?.raw,
      body.raw,
      unexpectedBetweenBodyAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericRequirement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericRequirementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericRequirementSyntax")
  public static func makeBlankGenericRequirement(presence: SourcePresence = .present) -> GenericRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericRequirement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return GenericRequirementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SameTypeRequirementSyntax")
  public static func makeSameTypeRequirement(_ unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? = nil, leftTypeIdentifier: TypeSyntax, _ unexpectedBetweenLeftTypeIdentifierAndEqualityToken: UnexpectedNodesSyntax? = nil, equalityToken: TokenSyntax, _ unexpectedBetweenEqualityTokenAndRightTypeIdentifier: UnexpectedNodesSyntax? = nil, rightTypeIdentifier: TypeSyntax) -> SameTypeRequirementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftTypeIdentifier?.raw,
      leftTypeIdentifier.raw,
      unexpectedBetweenLeftTypeIdentifierAndEqualityToken?.raw,
      equalityToken.raw,
      unexpectedBetweenEqualityTokenAndRightTypeIdentifier?.raw,
      rightTypeIdentifier.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.sameTypeRequirement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SameTypeRequirementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SameTypeRequirementSyntax")
  public static func makeBlankSameTypeRequirement(presence: SourcePresence = .present) -> SameTypeRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .sameTypeRequirement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.spacedBinaryOperator(""), arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return SameTypeRequirementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on LayoutRequirementSyntax")
  public static func makeLayoutRequirement(_ unexpectedBeforeTypeIdentifier: UnexpectedNodesSyntax? = nil, typeIdentifier: TypeSyntax, _ unexpectedBetweenTypeIdentifierAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndLayoutConstraint: UnexpectedNodesSyntax? = nil, layoutConstraint: TokenSyntax, _ unexpectedBetweenLayoutConstraintAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndSize: UnexpectedNodesSyntax? = nil, size: TokenSyntax?, _ unexpectedBetweenSizeAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedBetweenCommaAndAlignment: UnexpectedNodesSyntax? = nil, alignment: TokenSyntax?, _ unexpectedBetweenAlignmentAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?) -> LayoutRequirementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeTypeIdentifier?.raw,
      typeIdentifier.raw,
      unexpectedBetweenTypeIdentifierAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndLayoutConstraint?.raw,
      layoutConstraint.raw,
      unexpectedBetweenLayoutConstraintAndLeftParen?.raw,
      leftParen?.raw,
      unexpectedBetweenLeftParenAndSize?.raw,
      size?.raw,
      unexpectedBetweenSizeAndComma?.raw,
      comma?.raw,
      unexpectedBetweenCommaAndAlignment?.raw,
      alignment?.raw,
      unexpectedBetweenAlignmentAndRightParen?.raw,
      rightParen?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.layoutRequirement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return LayoutRequirementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on LayoutRequirementSyntax")
  public static func makeBlankLayoutRequirement(presence: SourcePresence = .present) -> LayoutRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .layoutRequirement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return LayoutRequirementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterListSyntax")
  public static func makeGenericParameterList(
    _ elements: [GenericParameterSyntax]) -> GenericParameterListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameterList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterListSyntax")
  public static func makeBlankGenericParameterList(presence: SourcePresence = .present) -> GenericParameterListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericParameterList,
      from: [
    ], arena: .default))
    return GenericParameterListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterSyntax")
  public static func makeGenericParameter(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndInheritedType: UnexpectedNodesSyntax? = nil, inheritedType: TypeSyntax?, _ unexpectedBetweenInheritedTypeAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> GenericParameterSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndInheritedType?.raw,
      inheritedType?.raw,
      unexpectedBetweenInheritedTypeAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameter,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterSyntax")
  public static func makeBlankGenericParameter(presence: SourcePresence = .present) -> GenericParameterSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericParameter,
      from: [
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return GenericParameterSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeListSyntax")
  public static func makePrimaryAssociatedTypeList(
    _ elements: [PrimaryAssociatedTypeSyntax]) -> PrimaryAssociatedTypeListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedTypeList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeListSyntax")
  public static func makeBlankPrimaryAssociatedTypeList(presence: SourcePresence = .present) -> PrimaryAssociatedTypeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .primaryAssociatedTypeList,
      from: [
    ], arena: .default))
    return PrimaryAssociatedTypeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeSyntax")
  public static func makePrimaryAssociatedType(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> PrimaryAssociatedTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeSyntax")
  public static func makeBlankPrimaryAssociatedType(presence: SourcePresence = .present) -> PrimaryAssociatedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .primaryAssociatedType,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return PrimaryAssociatedTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterClauseSyntax")
  public static func makeGenericParameterClause(_ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ unexpectedBetweenLeftAngleBracketAndGenericParameterList: UnexpectedNodesSyntax? = nil, genericParameterList: GenericParameterListSyntax, _ unexpectedBetweenGenericParameterListAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndRightAngleBracket: UnexpectedNodesSyntax? = nil, rightAngleBracket: TokenSyntax) -> GenericParameterClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      unexpectedBetweenLeftAngleBracketAndGenericParameterList?.raw,
      genericParameterList.raw,
      unexpectedBetweenGenericParameterListAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameterClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterClauseSyntax")
  public static func makeBlankGenericParameterClause(presence: SourcePresence = .present) -> GenericParameterClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericParameterClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericParameterList, arena: .default),
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: .default),
    ], arena: .default))
    return GenericParameterClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConformanceRequirementSyntax")
  public static func makeConformanceRequirement(_ unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? = nil, leftTypeIdentifier: TypeSyntax, _ unexpectedBetweenLeftTypeIdentifierAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndRightTypeIdentifier: UnexpectedNodesSyntax? = nil, rightTypeIdentifier: TypeSyntax) -> ConformanceRequirementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftTypeIdentifier?.raw,
      leftTypeIdentifier.raw,
      unexpectedBetweenLeftTypeIdentifierAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndRightTypeIdentifier?.raw,
      rightTypeIdentifier.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.conformanceRequirement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ConformanceRequirementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConformanceRequirementSyntax")
  public static func makeBlankConformanceRequirement(presence: SourcePresence = .present) -> ConformanceRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conformanceRequirement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return ConformanceRequirementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeClauseSyntax")
  public static func makePrimaryAssociatedTypeClause(_ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: UnexpectedNodesSyntax? = nil, primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax, _ unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: UnexpectedNodesSyntax? = nil, rightAngleBracket: TokenSyntax) -> PrimaryAssociatedTypeClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.raw,
      primaryAssociatedTypeList.raw,
      unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedTypeClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeClauseSyntax")
  public static func makeBlankPrimaryAssociatedTypeClause(presence: SourcePresence = .present) -> PrimaryAssociatedTypeClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .primaryAssociatedTypeClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.primaryAssociatedTypeList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: .default),
    ], arena: .default))
    return PrimaryAssociatedTypeClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeSimpleTypeIdentifier(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.simpleTypeIdentifier,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return SimpleTypeIdentifierSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeBlankSimpleTypeIdentifier(presence: SourcePresence = .present) -> SimpleTypeIdentifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .simpleTypeIdentifier,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return SimpleTypeIdentifierSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberTypeIdentifierSyntax")
  public static func makeMemberTypeIdentifier(_ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax, _ unexpectedBetweenBaseTypeAndPeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax, _ unexpectedBetweenPeriodAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBaseType?.raw,
      baseType.raw,
      unexpectedBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberTypeIdentifier,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MemberTypeIdentifierSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberTypeIdentifierSyntax")
  public static func makeBlankMemberTypeIdentifier(presence: SourcePresence = .present) -> MemberTypeIdentifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberTypeIdentifier,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return MemberTypeIdentifierSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClassRestrictionTypeSyntax")
  public static func makeClassRestrictionType(_ unexpectedBeforeClassKeyword: UnexpectedNodesSyntax? = nil, classKeyword: TokenSyntax) -> ClassRestrictionTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeClassKeyword?.raw,
      classKeyword.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.classRestrictionType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ClassRestrictionTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClassRestrictionTypeSyntax")
  public static func makeBlankClassRestrictionType(presence: SourcePresence = .present) -> ClassRestrictionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .classRestrictionType,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.classKeyword, arena: .default),
    ], arena: .default))
    return ClassRestrictionTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrayTypeSyntax")
  public static func makeArrayType(_ unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? = nil, leftSquareBracket: TokenSyntax, _ unexpectedBetweenLeftSquareBracketAndElementType: UnexpectedNodesSyntax? = nil, elementType: TypeSyntax, _ unexpectedBetweenElementTypeAndRightSquareBracket: UnexpectedNodesSyntax? = nil, rightSquareBracket: TokenSyntax) -> ArrayTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      unexpectedBetweenLeftSquareBracketAndElementType?.raw,
      elementType.raw,
      unexpectedBetweenElementTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ArrayTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrayTypeSyntax")
  public static func makeBlankArrayType(presence: SourcePresence = .present) -> ArrayTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrayType,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default),
    ], arena: .default))
    return ArrayTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DictionaryTypeSyntax")
  public static func makeDictionaryType(_ unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? = nil, leftSquareBracket: TokenSyntax, _ unexpectedBetweenLeftSquareBracketAndKeyType: UnexpectedNodesSyntax? = nil, keyType: TypeSyntax, _ unexpectedBetweenKeyTypeAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValueType: UnexpectedNodesSyntax? = nil, valueType: TypeSyntax, _ unexpectedBetweenValueTypeAndRightSquareBracket: UnexpectedNodesSyntax? = nil, rightSquareBracket: TokenSyntax) -> DictionaryTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      unexpectedBetweenLeftSquareBracketAndKeyType?.raw,
      keyType.raw,
      unexpectedBetweenKeyTypeAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValueType?.raw,
      valueType.raw,
      unexpectedBetweenValueTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return DictionaryTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DictionaryTypeSyntax")
  public static func makeBlankDictionaryType(presence: SourcePresence = .present) -> DictionaryTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .dictionaryType,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: .default),
    ], arena: .default))
    return DictionaryTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MetatypeTypeSyntax")
  public static func makeMetatypeType(_ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax, _ unexpectedBetweenBaseTypeAndPeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax, _ unexpectedBetweenPeriodAndTypeOrProtocol: UnexpectedNodesSyntax? = nil, typeOrProtocol: TokenSyntax) -> MetatypeTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBaseType?.raw,
      baseType.raw,
      unexpectedBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndTypeOrProtocol?.raw,
      typeOrProtocol.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.metatypeType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return MetatypeTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MetatypeTypeSyntax")
  public static func makeBlankMetatypeType(presence: SourcePresence = .present) -> MetatypeTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .metatypeType,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
    ], arena: .default))
    return MetatypeTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OptionalTypeSyntax")
  public static func makeOptionalType(_ unexpectedBeforeWrappedType: UnexpectedNodesSyntax? = nil, wrappedType: TypeSyntax, _ unexpectedBetweenWrappedTypeAndQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax) -> OptionalTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrappedType?.raw,
      wrappedType.raw,
      unexpectedBetweenWrappedTypeAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return OptionalTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OptionalTypeSyntax")
  public static func makeBlankOptionalType(presence: SourcePresence = .present) -> OptionalTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .optionalType,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: .default),
    ], arena: .default))
    return OptionalTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConstrainedSugarTypeSyntax")
  public static func makeConstrainedSugarType(_ unexpectedBeforeSomeOrAnySpecifier: UnexpectedNodesSyntax? = nil, someOrAnySpecifier: TokenSyntax, _ unexpectedBetweenSomeOrAnySpecifierAndBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax) -> ConstrainedSugarTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSomeOrAnySpecifier?.raw,
      someOrAnySpecifier.raw,
      unexpectedBetweenSomeOrAnySpecifierAndBaseType?.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.constrainedSugarType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ConstrainedSugarTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConstrainedSugarTypeSyntax")
  public static func makeBlankConstrainedSugarType(presence: SourcePresence = .present) -> ConstrainedSugarTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .constrainedSugarType,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return ConstrainedSugarTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ImplicitlyUnwrappedOptionalTypeSyntax")
  public static func makeImplicitlyUnwrappedOptionalType(_ unexpectedBeforeWrappedType: UnexpectedNodesSyntax? = nil, wrappedType: TypeSyntax, _ unexpectedBetweenWrappedTypeAndExclamationMark: UnexpectedNodesSyntax? = nil, exclamationMark: TokenSyntax) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrappedType?.raw,
      wrappedType.raw,
      unexpectedBetweenWrappedTypeAndExclamationMark?.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.implicitlyUnwrappedOptionalType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ImplicitlyUnwrappedOptionalTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ImplicitlyUnwrappedOptionalTypeSyntax")
  public static func makeBlankImplicitlyUnwrappedOptionalType(presence: SourcePresence = .present) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .implicitlyUnwrappedOptionalType,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.exclamationMark, arena: .default),
    ], arena: .default))
    return ImplicitlyUnwrappedOptionalTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeElementSyntax")
  public static func makeCompositionTypeElement(_ unexpectedBeforeType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedBetweenTypeAndAmpersand: UnexpectedNodesSyntax? = nil, ampersand: TokenSyntax?) -> CompositionTypeElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type.raw,
      unexpectedBetweenTypeAndAmpersand?.raw,
      ampersand?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionTypeElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeElementSyntax")
  public static func makeBlankCompositionTypeElement(presence: SourcePresence = .present) -> CompositionTypeElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .compositionTypeElement,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return CompositionTypeElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeElementListSyntax")
  public static func makeCompositionTypeElementList(
    _ elements: [CompositionTypeElementSyntax]) -> CompositionTypeElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionTypeElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeElementListSyntax")
  public static func makeBlankCompositionTypeElementList(presence: SourcePresence = .present) -> CompositionTypeElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .compositionTypeElementList,
      from: [
    ], arena: .default))
    return CompositionTypeElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeSyntax")
  public static func makeCompositionType(_ unexpectedBeforeElements: UnexpectedNodesSyntax? = nil, elements: CompositionTypeElementListSyntax) -> CompositionTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeSyntax")
  public static func makeBlankCompositionType(presence: SourcePresence = .present) -> CompositionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .compositionType,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.compositionTypeElementList, arena: .default),
    ], arena: .default))
    return CompositionTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PackExpansionTypeSyntax")
  public static func makePackExpansionType(_ unexpectedBeforePatternType: UnexpectedNodesSyntax? = nil, patternType: TypeSyntax, _ unexpectedBetweenPatternTypeAndEllipsis: UnexpectedNodesSyntax? = nil, ellipsis: TokenSyntax) -> PackExpansionTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePatternType?.raw,
      patternType.raw,
      unexpectedBetweenPatternTypeAndEllipsis?.raw,
      ellipsis.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.packExpansionType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return PackExpansionTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PackExpansionTypeSyntax")
  public static func makeBlankPackExpansionType(presence: SourcePresence = .present) -> PackExpansionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .packExpansionType,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.ellipsis, arena: .default),
    ], arena: .default))
    return PackExpansionTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeElementSyntax")
  public static func makeTupleTypeElement(_ unexpectedBeforeInOut: UnexpectedNodesSyntax? = nil, inOut: TokenSyntax?, _ unexpectedBetweenInOutAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax?, _ unexpectedBetweenNameAndSecondName: UnexpectedNodesSyntax? = nil, secondName: TokenSyntax?, _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil, ellipsis: TokenSyntax?, _ unexpectedBetweenEllipsisAndInitializer: UnexpectedNodesSyntax? = nil, initializer: InitializerClauseSyntax?, _ unexpectedBetweenInitializerAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeInOut?.raw,
      inOut?.raw,
      unexpectedBetweenInOutAndName?.raw,
      name?.raw,
      unexpectedBetweenNameAndSecondName?.raw,
      secondName?.raw,
      unexpectedBetweenSecondNameAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndType?.raw,
      type.raw,
      unexpectedBetweenTypeAndEllipsis?.raw,
      ellipsis?.raw,
      unexpectedBetweenEllipsisAndInitializer?.raw,
      initializer?.raw,
      unexpectedBetweenInitializerAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleTypeElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeElementSyntax")
  public static func makeBlankTupleTypeElement(presence: SourcePresence = .present) -> TupleTypeElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleTypeElement,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return TupleTypeElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeElementListSyntax")
  public static func makeTupleTypeElementList(
    _ elements: [TupleTypeElementSyntax]) -> TupleTypeElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleTypeElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeElementListSyntax")
  public static func makeBlankTupleTypeElementList(presence: SourcePresence = .present) -> TupleTypeElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleTypeElementList,
      from: [
    ], arena: .default))
    return TupleTypeElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeTupleType(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndElements: UnexpectedNodesSyntax? = nil, elements: TupleTypeElementListSyntax, _ unexpectedBetweenElementsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> TupleTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElements?.raw,
      elements.raw,
      unexpectedBetweenElementsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeBlankTupleType(presence: SourcePresence = .present) -> TupleTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleType,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleTypeElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return TupleTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionTypeSyntax")
  public static func makeFunctionType(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil, arguments: TupleTypeElementListSyntax, _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedBetweenRightParenAndAsyncKeyword: UnexpectedNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: UnexpectedNodesSyntax? = nil, throwsOrRethrowsKeyword: TokenSyntax?, _ unexpectedBetweenThrowsOrRethrowsKeywordAndArrow: UnexpectedNodesSyntax? = nil, arrow: TokenSyntax, _ unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? = nil, returnType: TypeSyntax) -> FunctionTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
      unexpectedBetweenRightParenAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      unexpectedBetweenThrowsOrRethrowsKeywordAndArrow?.raw,
      arrow.raw,
      unexpectedBetweenArrowAndReturnType?.raw,
      returnType.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return FunctionTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionTypeSyntax")
  public static func makeBlankFunctionType(presence: SourcePresence = .present) -> FunctionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionType,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleTypeElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return FunctionTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AttributedTypeSyntax")
  public static func makeAttributedType(_ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil, specifier: TokenSyntax?, _ unexpectedBetweenSpecifierAndAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax) -> AttributedTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSpecifier?.raw,
      specifier?.raw,
      unexpectedBetweenSpecifierAndAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndBaseType?.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.attributedType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AttributedTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AttributedTypeSyntax")
  public static func makeBlankAttributedType(presence: SourcePresence = .present) -> AttributedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .attributedType,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return AttributedTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentListSyntax")
  public static func makeGenericArgumentList(
    _ elements: [GenericArgumentSyntax]) -> GenericArgumentListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgumentList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentListSyntax")
  public static func makeBlankGenericArgumentList(presence: SourcePresence = .present) -> GenericArgumentListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericArgumentList,
      from: [
    ], arena: .default))
    return GenericArgumentListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentSyntax")
  public static func makeGenericArgument(_ unexpectedBeforeArgumentType: UnexpectedNodesSyntax? = nil, argumentType: TypeSyntax, _ unexpectedBetweenArgumentTypeAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> GenericArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeArgumentType?.raw,
      argumentType.raw,
      unexpectedBetweenArgumentTypeAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentSyntax")
  public static func makeBlankGenericArgument(presence: SourcePresence = .present) -> GenericArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericArgument,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return GenericArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentClauseSyntax")
  public static func makeGenericArgumentClause(_ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ unexpectedBetweenLeftAngleBracketAndArguments: UnexpectedNodesSyntax? = nil, arguments: GenericArgumentListSyntax, _ unexpectedBetweenArgumentsAndRightAngleBracket: UnexpectedNodesSyntax? = nil, rightAngleBracket: TokenSyntax) -> GenericArgumentClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      unexpectedBetweenLeftAngleBracketAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgumentClause,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentClauseSyntax")
  public static func makeBlankGenericArgumentClause(presence: SourcePresence = .present) -> GenericArgumentClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericArgumentClause,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericArgumentList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: .default),
    ], arena: .default))
    return GenericArgumentClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on NamedOpaqueReturnTypeSyntax")
  public static func makeNamedOpaqueReturnType(_ unexpectedBeforeGenericParameters: UnexpectedNodesSyntax? = nil, genericParameters: GenericParameterClauseSyntax, _ unexpectedBetweenGenericParametersAndBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax) -> NamedOpaqueReturnTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeGenericParameters?.raw,
      genericParameters.raw,
      unexpectedBetweenGenericParametersAndBaseType?.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.namedOpaqueReturnType,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return NamedOpaqueReturnTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on NamedOpaqueReturnTypeSyntax")
  public static func makeBlankNamedOpaqueReturnType(presence: SourcePresence = .present) -> NamedOpaqueReturnTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .namedOpaqueReturnType,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericParameterClause, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return NamedOpaqueReturnTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypeAnnotationSyntax")
  public static func makeTypeAnnotation(_ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax) -> TypeAnnotationSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeAnnotation,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TypeAnnotationSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypeAnnotationSyntax")
  public static func makeBlankTypeAnnotation(presence: SourcePresence = .present) -> TypeAnnotationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typeAnnotation,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return TypeAnnotationSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumCasePatternSyntax")
  public static func makeEnumCasePattern(_ unexpectedBeforeType: UnexpectedNodesSyntax? = nil, type: TypeSyntax?, _ unexpectedBetweenTypeAndPeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax, _ unexpectedBetweenPeriodAndCaseName: UnexpectedNodesSyntax? = nil, caseName: TokenSyntax, _ unexpectedBetweenCaseNameAndAssociatedTuple: UnexpectedNodesSyntax? = nil, associatedTuple: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type?.raw,
      unexpectedBetweenTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndCaseName?.raw,
      caseName.raw,
      unexpectedBetweenCaseNameAndAssociatedTuple?.raw,
      associatedTuple?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCasePattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return EnumCasePatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumCasePatternSyntax")
  public static func makeBlankEnumCasePattern(presence: SourcePresence = .present) -> EnumCasePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumCasePattern,
      from: [
      nil,
      nil,
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.period, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return EnumCasePatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IsTypePatternSyntax")
  public static func makeIsTypePattern(_ unexpectedBeforeIsKeyword: UnexpectedNodesSyntax? = nil, isKeyword: TokenSyntax, _ unexpectedBetweenIsKeywordAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax) -> IsTypePatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIsKeyword?.raw,
      isKeyword.raw,
      unexpectedBetweenIsKeywordAndType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.isTypePattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IsTypePatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IsTypePatternSyntax")
  public static func makeBlankIsTypePattern(presence: SourcePresence = .present) -> IsTypePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .isTypePattern,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.isKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return IsTypePatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OptionalPatternSyntax")
  public static func makeOptionalPattern(_ unexpectedBeforeSubPattern: UnexpectedNodesSyntax? = nil, subPattern: PatternSyntax, _ unexpectedBetweenSubPatternAndQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax) -> OptionalPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSubPattern?.raw,
      subPattern.raw,
      unexpectedBetweenSubPatternAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalPattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return OptionalPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OptionalPatternSyntax")
  public static func makeBlankOptionalPattern(presence: SourcePresence = .present) -> OptionalPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .optionalPattern,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: .default),
    ], arena: .default))
    return OptionalPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IdentifierPatternSyntax")
  public static func makeIdentifierPattern(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax) -> IdentifierPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.identifierPattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return IdentifierPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IdentifierPatternSyntax")
  public static func makeBlankIdentifierPattern(presence: SourcePresence = .present) -> IdentifierPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .identifierPattern,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.selfKeyword, arena: .default),
    ], arena: .default))
    return IdentifierPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AsTypePatternSyntax")
  public static func makeAsTypePattern(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndAsKeyword: UnexpectedNodesSyntax? = nil, asKeyword: TokenSyntax, _ unexpectedBetweenAsKeywordAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax) -> AsTypePatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndAsKeyword?.raw,
      asKeyword.raw,
      unexpectedBetweenAsKeywordAndType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.asTypePattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AsTypePatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AsTypePatternSyntax")
  public static func makeBlankAsTypePattern(presence: SourcePresence = .present) -> AsTypePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .asTypePattern,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.asKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: .default),
    ], arena: .default))
    return AsTypePatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternSyntax")
  public static func makeTuplePattern(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndElements: UnexpectedNodesSyntax? = nil, elements: TuplePatternElementListSyntax, _ unexpectedBetweenElementsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax) -> TuplePatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElements?.raw,
      elements.raw,
      unexpectedBetweenElementsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tuplePattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternSyntax")
  public static func makeBlankTuplePattern(presence: SourcePresence = .present) -> TuplePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tuplePattern,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.tuplePatternElementList, arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: .default),
    ], arena: .default))
    return TuplePatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on WildcardPatternSyntax")
  public static func makeWildcardPattern(_ unexpectedBeforeWildcard: UnexpectedNodesSyntax? = nil, wildcard: TokenSyntax, _ unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWildcard?.raw,
      wildcard.raw,
      unexpectedBetweenWildcardAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.wildcardPattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return WildcardPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on WildcardPatternSyntax")
  public static func makeBlankWildcardPattern(presence: SourcePresence = .present) -> WildcardPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .wildcardPattern,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.wildcardKeyword, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return WildcardPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternElementSyntax")
  public static func makeTuplePatternElement(_ unexpectedBeforeLabelName: UnexpectedNodesSyntax? = nil, labelName: TokenSyntax?, _ unexpectedBetweenLabelNameAndLabelColon: UnexpectedNodesSyntax? = nil, labelColon: TokenSyntax?, _ unexpectedBetweenLabelColonAndPattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> TuplePatternElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabelName?.raw,
      labelName?.raw,
      unexpectedBetweenLabelNameAndLabelColon?.raw,
      labelColon?.raw,
      unexpectedBetweenLabelColonAndPattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tuplePatternElement,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternElementSyntax")
  public static func makeBlankTuplePatternElement(presence: SourcePresence = .present) -> TuplePatternElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tuplePatternElement,
      from: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return TuplePatternElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExpressionPatternSyntax")
  public static func makeExpressionPattern(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax) -> ExpressionPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.expressionPattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ExpressionPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExpressionPatternSyntax")
  public static func makeBlankExpressionPattern(presence: SourcePresence = .present) -> ExpressionPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .expressionPattern,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: .default),
    ], arena: .default))
    return ExpressionPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternElementListSyntax")
  public static func makeTuplePatternElementList(
    _ elements: [TuplePatternElementSyntax]) -> TuplePatternElementListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.tuplePatternElementList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternElementListSyntax")
  public static func makeBlankTuplePatternElementList(presence: SourcePresence = .present) -> TuplePatternElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tuplePatternElementList,
      from: [
    ], arena: .default))
    return TuplePatternElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ValueBindingPatternSyntax")
  public static func makeValueBindingPattern(_ unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ unexpectedBetweenLetOrVarKeywordAndValuePattern: UnexpectedNodesSyntax? = nil, valuePattern: PatternSyntax) -> ValueBindingPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      unexpectedBetweenLetOrVarKeywordAndValuePattern?.raw,
      valuePattern.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.valueBindingPattern,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return ValueBindingPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ValueBindingPatternSyntax")
  public static func makeBlankValueBindingPattern(presence: SourcePresence = .present) -> ValueBindingPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .valueBindingPattern,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: .default),
    ], arena: .default))
    return ValueBindingPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilitySpecListSyntax")
  public static func makeAvailabilitySpecList(
    _ elements: [AvailabilityArgumentSyntax]) -> AvailabilitySpecListSyntax {
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilitySpecList,
      from: elements.map { $0.raw }, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AvailabilitySpecListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilitySpecListSyntax")
  public static func makeBlankAvailabilitySpecList(presence: SourcePresence = .present) -> AvailabilitySpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilitySpecList,
      from: [
    ], arena: .default))
    return AvailabilitySpecListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityArgumentSyntax")
  public static func makeAvailabilityArgument(_ unexpectedBeforeEntry: UnexpectedNodesSyntax? = nil, entry: Syntax, _ unexpectedBetweenEntryAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?) -> AvailabilityArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEntry?.raw,
      entry.raw,
      unexpectedBetweenEntryAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityArgumentSyntax")
  public static func makeBlankAvailabilityArgument(presence: SourcePresence = .present) -> AvailabilityArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityArgument,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      nil,
    ], arena: .default))
    return AvailabilityArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityLabeledArgumentSyntax")
  public static func makeAvailabilityLabeledArgument(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil, value: Syntax) -> AvailabilityLabeledArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValue?.raw,
      value.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityLabeledArgument,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityLabeledArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityLabeledArgumentSyntax")
  public static func makeBlankAvailabilityLabeledArgument(presence: SourcePresence = .present) -> AvailabilityLabeledArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityLabeledArgument,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: .default),
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
    ], arena: .default))
    return AvailabilityLabeledArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityVersionRestrictionSyntax")
  public static func makeAvailabilityVersionRestriction(_ unexpectedBeforePlatform: UnexpectedNodesSyntax? = nil, platform: TokenSyntax, _ unexpectedBetweenPlatformAndVersion: UnexpectedNodesSyntax? = nil, version: VersionTupleSyntax?) -> AvailabilityVersionRestrictionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePlatform?.raw,
      platform.raw,
      unexpectedBetweenPlatformAndVersion?.raw,
      version?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityVersionRestriction,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityVersionRestrictionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityVersionRestrictionSyntax")
  public static func makeBlankAvailabilityVersionRestriction(presence: SourcePresence = .present) -> AvailabilityVersionRestrictionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityVersionRestriction,
      from: [
      nil,
      RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: .default),
      nil,
      nil,
    ], arena: .default))
    return AvailabilityVersionRestrictionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on VersionTupleSyntax")
  public static func makeVersionTuple(_ unexpectedBeforeMajorMinor: UnexpectedNodesSyntax? = nil, majorMinor: Syntax, _ unexpectedBetweenMajorMinorAndPatchPeriod: UnexpectedNodesSyntax? = nil, patchPeriod: TokenSyntax?, _ unexpectedBetweenPatchPeriodAndPatchVersion: UnexpectedNodesSyntax? = nil, patchVersion: TokenSyntax?) -> VersionTupleSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMajorMinor?.raw,
      majorMinor.raw,
      unexpectedBetweenMajorMinorAndPatchPeriod?.raw,
      patchPeriod?.raw,
      unexpectedBetweenPatchPeriodAndPatchVersion?.raw,
      patchVersion?.raw,
    ]
    let raw = RawSyntax.makeLayout(kind: SyntaxKind.versionTuple,
      from: layout, arena: .default)
    let data = SyntaxData.forRoot(raw)
    return VersionTupleSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on VersionTupleSyntax")
  public static func makeBlankVersionTuple(presence: SourcePresence = .present) -> VersionTupleSyntax {
    let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .versionTuple,
      from: [
      nil,
      RawSyntax.makeEmptyLayout(kind: SyntaxKind.unknown, arena: .default),
      nil,
      nil,
      nil,
      nil,
    ], arena: .default))
    return VersionTupleSyntax(data)
  }

/// MARK: Token Creation APIs


  @available(*, deprecated, message: "Use TokenSyntax.associatedtypeKeywordKeyword instead")
  public static func makeAssociatedtypeKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.associatedtypeKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.classKeywordKeyword instead")
  public static func makeClassKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.classKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.deinitKeywordKeyword instead")
  public static func makeDeinitKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.deinitKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.enumKeywordKeyword instead")
  public static func makeEnumKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.enumKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.extensionKeywordKeyword instead")
  public static func makeExtensionKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.extensionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.funcKeywordKeyword instead")
  public static func makeFuncKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.funcKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.importKeywordKeyword instead")
  public static func makeImportKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.importKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.initKeywordKeyword instead")
  public static func makeInitKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.initKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.inoutKeywordKeyword instead")
  public static func makeInoutKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.inoutKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.letKeywordKeyword instead")
  public static func makeLetKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.letKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.operatorKeywordKeyword instead")
  public static func makeOperatorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.operatorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.precedencegroupKeywordKeyword instead")
  public static func makePrecedencegroupKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.precedencegroupKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.protocolKeywordKeyword instead")
  public static func makeProtocolKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.protocolKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.structKeywordKeyword instead")
  public static func makeStructKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.structKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.subscriptKeywordKeyword instead")
  public static func makeSubscriptKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.subscriptKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.typealiasKeywordKeyword instead")
  public static func makeTypealiasKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.typealiasKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.varKeywordKeyword instead")
  public static func makeVarKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.varKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.fileprivateKeywordKeyword instead")
  public static func makeFileprivateKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.fileprivateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.internalKeywordKeyword instead")
  public static func makeInternalKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.internalKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.privateKeywordKeyword instead")
  public static func makePrivateKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.privateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.publicKeywordKeyword instead")
  public static func makePublicKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.publicKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.staticKeywordKeyword instead")
  public static func makeStaticKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.staticKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.deferKeywordKeyword instead")
  public static func makeDeferKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.deferKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.ifKeywordKeyword instead")
  public static func makeIfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.ifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.guardKeywordKeyword instead")
  public static func makeGuardKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.guardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.doKeywordKeyword instead")
  public static func makeDoKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.doKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.repeatKeywordKeyword instead")
  public static func makeRepeatKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.repeatKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.elseKeywordKeyword instead")
  public static func makeElseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.elseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.forKeywordKeyword instead")
  public static func makeForKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.forKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.inKeywordKeyword instead")
  public static func makeInKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.inKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.whileKeywordKeyword instead")
  public static func makeWhileKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.whileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.returnKeywordKeyword instead")
  public static func makeReturnKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.returnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.breakKeywordKeyword instead")
  public static func makeBreakKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.breakKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.continueKeywordKeyword instead")
  public static func makeContinueKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.continueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.fallthroughKeywordKeyword instead")
  public static func makeFallthroughKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.fallthroughKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.switchKeywordKeyword instead")
  public static func makeSwitchKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.switchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.caseKeywordKeyword instead")
  public static func makeCaseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.caseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.defaultKeywordKeyword instead")
  public static func makeDefaultKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.defaultKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.whereKeywordKeyword instead")
  public static func makeWhereKeyword(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.whereKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.catchKeywordKeyword instead")
  public static func makeCatchKeyword(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.catchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.throwKeywordKeyword instead")
  public static func makeThrowKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.throwKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.asKeywordKeyword instead")
  public static func makeAsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.asKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.anyKeywordKeyword instead")
  public static func makeAnyKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.anyKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.falseKeywordKeyword instead")
  public static func makeFalseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.falseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.isKeywordKeyword instead")
  public static func makeIsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.isKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.nilKeywordKeyword instead")
  public static func makeNilKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.nilKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.rethrowsKeywordKeyword instead")
  public static func makeRethrowsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.rethrowsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.superKeywordKeyword instead")
  public static func makeSuperKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.superKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.selfKeywordKeyword instead")
  public static func makeSelfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.selfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.capitalSelfKeywordKeyword instead")
  public static func makeCapitalSelfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.capitalSelfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.trueKeywordKeyword instead")
  public static func makeTrueKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.trueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.tryKeywordKeyword instead")
  public static func makeTryKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.tryKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.throwsKeywordKeyword instead")
  public static func makeThrowsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.throwsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.__file__KeywordKeyword instead")
  public static func make__FILE__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__file__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.__line__KeywordKeyword instead")
  public static func make__LINE__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__line__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.__column__KeywordKeyword instead")
  public static func make__COLUMN__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__column__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.__function__KeywordKeyword instead")
  public static func make__FUNCTION__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__function__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.__dso_handle__KeywordKeyword instead")
  public static func make__DSO_HANDLE__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__dso_handle__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.wildcardKeywordKeyword instead")
  public static func makeWildcardKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.wildcardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.leftParenToken instead")
  public static func makeLeftParenToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.leftParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.rightParenToken instead")
  public static func makeRightParenToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.rightParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.leftBraceToken instead")
  public static func makeLeftBraceToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.leftBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.rightBraceToken instead")
  public static func makeRightBraceToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.rightBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.leftSquareBracketToken instead")
  public static func makeLeftSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.leftSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.rightSquareBracketToken instead")
  public static func makeRightSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.rightSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.leftAngleToken instead")
  public static func makeLeftAngleToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.leftAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.rightAngleToken instead")
  public static func makeRightAngleToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.rightAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.periodToken instead")
  public static func makePeriodToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.period, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.prefixPeriodToken instead")
  public static func makePrefixPeriodToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.prefixPeriod, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.commaToken instead")
  public static func makeCommaToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.comma, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.ellipsisToken instead")
  public static func makeEllipsisToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.ellipsis, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.colonToken instead")
  public static func makeColonToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.colon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.semicolonToken instead")
  public static func makeSemicolonToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.semicolon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.equalToken instead")
  public static func makeEqualToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.equal, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.atSignToken instead")
  public static func makeAtSignToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.atSign, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundToken instead")
  public static func makePoundToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.pound, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.prefixAmpersandToken instead")
  public static func makePrefixAmpersandToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.prefixAmpersand, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.arrowToken instead")
  public static func makeArrowToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.arrow, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.backtickToken instead")
  public static func makeBacktickToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.backtick, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.backslashToken instead")
  public static func makeBackslashToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.backslash, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.exclamationMarkToken instead")
  public static func makeExclamationMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.exclamationMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.postfixQuestionMarkToken instead")
  public static func makePostfixQuestionMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.postfixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.infixQuestionMarkToken instead")
  public static func makeInfixQuestionMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.infixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.stringQuoteToken instead")
  public static func makeStringQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.stringQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.singleQuoteToken instead")
  public static func makeSingleQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.singleQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.multilineStringQuoteToken instead")
  public static func makeMultilineStringQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.multilineStringQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundKeyPathKeywordKeyword instead")
  public static func makePoundKeyPathKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundKeyPathKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundLineKeywordKeyword instead")
  public static func makePoundLineKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundLineKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundSelectorKeywordKeyword instead")
  public static func makePoundSelectorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundSelectorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundFileKeywordKeyword instead")
  public static func makePoundFileKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundFileIDKeywordKeyword instead")
  public static func makePoundFileIDKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFileIDKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundFilePathKeywordKeyword instead")
  public static func makePoundFilePathKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFilePathKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundColumnKeywordKeyword instead")
  public static func makePoundColumnKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundColumnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundFunctionKeywordKeyword instead")
  public static func makePoundFunctionKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFunctionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundDsohandleKeywordKeyword instead")
  public static func makePoundDsohandleKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundDsohandleKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundAssertKeywordKeyword instead")
  public static func makePoundAssertKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundAssertKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundSourceLocationKeywordKeyword instead")
  public static func makePoundSourceLocationKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundSourceLocationKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundWarningKeywordKeyword instead")
  public static func makePoundWarningKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundWarningKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundErrorKeywordKeyword instead")
  public static func makePoundErrorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundErrorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundIfKeywordKeyword instead")
  public static func makePoundIfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundIfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundElseKeywordKeyword instead")
  public static func makePoundElseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundElseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundElseifKeywordKeyword instead")
  public static func makePoundElseifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundElseifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundEndifKeywordKeyword instead")
  public static func makePoundEndifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundEndifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundAvailableKeywordKeyword instead")
  public static func makePoundAvailableKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundAvailableKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundUnavailableKeywordKeyword instead")
  public static func makePoundUnavailableKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundUnavailableKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundFileLiteralKeywordKeyword instead")
  public static func makePoundFileLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFileLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundImageLiteralKeywordKeyword instead")
  public static func makePoundImageLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundImageLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundColorLiteralKeywordKeyword instead")
  public static func makePoundColorLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundColorLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.poundHasSymbolKeywordKeyword instead")
  public static func makePoundHasSymbolKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundHasSymbolKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.integerLiteral instead")
  public static func makeIntegerLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.integerLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.floatingLiteral instead")
  public static func makeFloatingLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.floatingLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.stringLiteral instead")
  public static func makeStringLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.stringLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.regexLiteral instead")
  public static func makeRegexLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.regexLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.unknown instead")
  public static func makeUnknown(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.unknown(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.identifier instead")
  public static func makeIdentifier(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.identifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.unspacedBinaryOperator instead")
  public static func makeUnspacedBinaryOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.unspacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.spacedBinaryOperator instead")
  public static func makeSpacedBinaryOperator(
    _ text: String,
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.postfixOperator instead")
  public static func makePostfixOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.postfixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.prefixOperator instead")
  public static func makePrefixOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.prefixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.dollarIdentifier instead")
  public static func makeDollarIdentifier(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.dollarIdentifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.contextualKeyword instead")
  public static func makeContextualKeyword(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.contextualKeyword(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.rawStringDelimiter instead")
  public static func makeRawStringDelimiter(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.rawStringDelimiter(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.stringSegment instead")
  public static func makeStringSegment(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.stringSegment(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.stringInterpolationAnchorToken instead")
  public static func makeStringInterpolationAnchorToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.stringInterpolationAnchor, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  @available(*, deprecated, message: "Use TokenSyntax.yieldToken instead")
  public static func makeYieldToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.yield, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }

/// MARK: Convenience APIs

  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeVoidTupleType() -> TupleTypeSyntax {
    return makeTupleType(leftParen: makeLeftParenToken(),
                         elements: makeBlankTupleTypeElementList(),
                         rightParen: makeRightParenToken())
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeTupleTypeElement(name: TokenSyntax?,
    colon: TokenSyntax?, type: TypeSyntax,
    trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
    return makeTupleTypeElement(inOut: nil, name: name, secondName: nil,
                                colon: colon, type: type, ellipsis: nil,
                                initializer: nil, trailingComma: trailingComma)
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeTupleTypeElement(type: TypeSyntax,
    trailingComma: TokenSyntax?) -> TupleTypeElementSyntax  {
    return makeTupleTypeElement(name: nil, colon: nil, 
                                type: type, trailingComma: trailingComma)
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterSyntax")
  public static func makeGenericParameter(name: TokenSyntax,
      trailingComma: TokenSyntax) -> GenericParameterSyntax {
    return makeGenericParameter(attributes: nil, name: name, colon: nil,
                                inheritedType: nil,
                                trailingComma: trailingComma)
  }

  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeTypeIdentifier(_ name: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    let identifier = makeIdentifier(name, leadingTrivia: leadingTrivia, 
                                    trailingTrivia: trailingTrivia)
    let typeIdentifier = makeSimpleTypeIdentifier(name: identifier,
                                                  genericArgumentClause: nil)
    return TypeSyntax(typeIdentifier)
  }

  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeAnyTypeIdentifier(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    return makeTypeIdentifier("Any", leadingTrivia: leadingTrivia, 
                              trailingTrivia: trailingTrivia)
  }

  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeSelfTypeIdentifier(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    return makeTypeIdentifier("Self", leadingTrivia: leadingTrivia, 
                              trailingTrivia: trailingTrivia)
  }

  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeTypeToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeIdentifier("Type", leadingTrivia: leadingTrivia, 
                          trailingTrivia: trailingTrivia)
  }

  @available(*, deprecated, message: "Use TokenSyntax.protocol")
  public static func makeProtocolToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeIdentifier("Protocol", leadingTrivia: leadingTrivia,
                          trailingTrivia: trailingTrivia)
  }

  @available(*, deprecated, message: "Use TokenSyntax.spacedBinaryOperator")
  public static func makeBinaryOperator(_ name: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator(name),
                     presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }

  @available(*, deprecated, message: "Use initializer on StringLiteralExprSyntax")
  public static func makeStringLiteralExpr(_ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> StringLiteralExprSyntax {
    let string = makeStringSegment(text)
    let segment = makeStringSegment(content: string)
    let segments = makeStringLiteralSegments([Syntax(segment)])
    let openQuote = makeStringQuoteToken(leadingTrivia: leadingTrivia)
    let closeQuote = makeStringQuoteToken(trailingTrivia: trailingTrivia)
    return makeStringLiteralExpr(openDelimiter: nil,
                                 openQuote: openQuote,
                                 segments: segments,
                                 closeQuote: closeQuote,
                                 closeDelimiter: nil)
  }

  @available(*, deprecated, message: "Use initializer on IdentifierExprSyntax")
  public static func makeVariableExpr(_ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> IdentifierExprSyntax {
    let string = makeIdentifier(text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
    return makeIdentifierExpr(identifier: string,
                              declNameArguments: nil)
  }
}
