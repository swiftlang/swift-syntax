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
    let raw = RawSyntax.createAndCalcLength(kind: kind, leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia, presence: presence)
    let data = SyntaxData.forRoot(raw)
    return TokenSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownSyntax")
  public static func makeUnknownSyntax(tokens: [TokenSyntax]) -> UnknownSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: .unknown,
      layout: tokens.map { $0.raw }, presence: .present)
    let data = SyntaxData.forRoot(raw)
    return UnknownSyntax(data)
  }

/// MARK: Syntax Node Creation APIs







  @available(*, deprecated, message: "Use initializer on UnknownDeclSyntax")
  public static func makeBlankUnknownDecl(presence: SourcePresence = .present) -> UnknownDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownDecl,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownExprSyntax")
  public static func makeBlankUnknownExpr(presence: SourcePresence = .present) -> UnknownExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownExpr,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownStmtSyntax")
  public static func makeBlankUnknownStmt(presence: SourcePresence = .present) -> UnknownStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownStmt,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownTypeSyntax")
  public static func makeBlankUnknownType(presence: SourcePresence = .present) -> UnknownTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownType,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnknownPatternSyntax")
  public static func makeBlankUnknownPattern(presence: SourcePresence = .present) -> UnknownPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownPattern,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingSyntax")
  public static func makeBlankMissing(presence: SourcePresence = .missing) -> MissingSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .missing,
      layout: [
    ], length: .zero, presence: presence))
    return MissingSyntax(data)
  }
  public static func makeMissingDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?) -> MissingDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.missingDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MissingDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingDeclSyntax")
  public static func makeBlankMissingDecl(presence: SourcePresence = .missing) -> MissingDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .missingDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return MissingDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingExprSyntax")
  public static func makeBlankMissingExpr(presence: SourcePresence = .missing) -> MissingExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .missingExpr,
      layout: [
    ], length: .zero, presence: presence))
    return MissingExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingStmtSyntax")
  public static func makeBlankMissingStmt(presence: SourcePresence = .missing) -> MissingStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .missingStmt,
      layout: [
    ], length: .zero, presence: presence))
    return MissingStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingTypeSyntax")
  public static func makeBlankMissingType(presence: SourcePresence = .missing) -> MissingTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .missingType,
      layout: [
    ], length: .zero, presence: presence))
    return MissingTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MissingPatternSyntax")
  public static func makeBlankMissingPattern(presence: SourcePresence = .missing) -> MissingPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .missingPattern,
      layout: [
    ], length: .zero, presence: presence))
    return MissingPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockItemSyntax")
  public static func makeCodeBlockItem(_ garbageBeforeItem: GarbageNodesSyntax? = nil, item: Syntax, _ garbageBetweenItemAndSemicolon: GarbageNodesSyntax? = nil, semicolon: TokenSyntax?, _ garbageBetweenSemicolonAndErrorTokens: GarbageNodesSyntax? = nil, errorTokens: Syntax?) -> CodeBlockItemSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeItem?.raw,
      item.raw,
      garbageBetweenItemAndSemicolon?.raw,
      semicolon?.raw,
      garbageBetweenSemicolonAndErrorTokens?.raw,
      errorTokens?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.codeBlockItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockItemSyntax")
  public static func makeBlankCodeBlockItem(presence: SourcePresence = .present) -> CodeBlockItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .codeBlockItem,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CodeBlockItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockItemListSyntax")
  public static func makeCodeBlockItemList(
    _ elements: [CodeBlockItemSyntax]) -> CodeBlockItemListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.codeBlockItemList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockItemListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockItemListSyntax")
  public static func makeBlankCodeBlockItemList(presence: SourcePresence = .present) -> CodeBlockItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .codeBlockItemList,
      layout: [
    ], length: .zero, presence: presence))
    return CodeBlockItemListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockSyntax")
  public static func makeCodeBlock(_ garbageBeforeLeftBrace: GarbageNodesSyntax? = nil, leftBrace: TokenSyntax, _ garbageBetweenLeftBraceAndStatements: GarbageNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ garbageBetweenStatementsAndRightBrace: GarbageNodesSyntax? = nil, rightBrace: TokenSyntax) -> CodeBlockSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndStatements?.raw,
      statements.raw,
      garbageBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.codeBlock,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockSyntax")
  public static func makeBlankCodeBlock(presence: SourcePresence = .present) -> CodeBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .codeBlock,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftBrace),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
      nil,
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return CodeBlockSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GarbageNodesSyntax")
  public static func makeGarbageNodes(
    _ elements: [Syntax]) -> GarbageNodesSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.garbageNodes,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GarbageNodesSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GarbageNodesSyntax")
  public static func makeBlankGarbageNodes(presence: SourcePresence = .present) -> GarbageNodesSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .garbageNodes,
      layout: [
    ], length: .zero, presence: presence))
    return GarbageNodesSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InOutExprSyntax")
  public static func makeInOutExpr(_ garbageBeforeAmpersand: GarbageNodesSyntax? = nil, ampersand: TokenSyntax, _ garbageBetweenAmpersandAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax) -> InOutExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAmpersand?.raw,
      ampersand.raw,
      garbageBetweenAmpersandAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.inOutExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InOutExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InOutExprSyntax")
  public static func makeBlankInOutExpr(presence: SourcePresence = .present) -> InOutExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .inOutExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.prefixAmpersand),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return InOutExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundColumnExprSyntax")
  public static func makePoundColumnExpr(_ garbageBeforePoundColumn: GarbageNodesSyntax? = nil, poundColumn: TokenSyntax) -> PoundColumnExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundColumn?.raw,
      poundColumn.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundColumnExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundColumnExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundColumnExprSyntax")
  public static func makeBlankPoundColumnExpr(presence: SourcePresence = .present) -> PoundColumnExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundColumnExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundColumnKeyword),
    ], length: .zero, presence: presence))
    return PoundColumnExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleExprElementListSyntax")
  public static func makeTupleExprElementList(
    _ elements: [TupleExprElementSyntax]) -> TupleExprElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleExprElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleExprElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleExprElementListSyntax")
  public static func makeBlankTupleExprElementList(presence: SourcePresence = .present) -> TupleExprElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleExprElementList,
      layout: [
    ], length: .zero, presence: presence))
    return TupleExprElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrayElementListSyntax")
  public static func makeArrayElementList(
    _ elements: [ArrayElementSyntax]) -> ArrayElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrayElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrayElementListSyntax")
  public static func makeBlankArrayElementList(presence: SourcePresence = .present) -> ArrayElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrayElementList,
      layout: [
    ], length: .zero, presence: presence))
    return ArrayElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DictionaryElementListSyntax")
  public static func makeDictionaryElementList(
    _ elements: [DictionaryElementSyntax]) -> DictionaryElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DictionaryElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DictionaryElementListSyntax")
  public static func makeBlankDictionaryElementList(presence: SourcePresence = .present) -> DictionaryElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .dictionaryElementList,
      layout: [
    ], length: .zero, presence: presence))
    return DictionaryElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on StringLiteralSegmentsSyntax")
  public static func makeStringLiteralSegments(
    _ elements: [Syntax]) -> StringLiteralSegmentsSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.stringLiteralSegments,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return StringLiteralSegmentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on StringLiteralSegmentsSyntax")
  public static func makeBlankStringLiteralSegments(presence: SourcePresence = .present) -> StringLiteralSegmentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .stringLiteralSegments,
      layout: [
    ], length: .zero, presence: presence))
    return StringLiteralSegmentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TryExprSyntax")
  public static func makeTryExpr(_ garbageBeforeTryKeyword: GarbageNodesSyntax? = nil, tryKeyword: TokenSyntax, _ garbageBetweenTryKeywordAndQuestionOrExclamationMark: GarbageNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax?, _ garbageBetweenQuestionOrExclamationMarkAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax) -> TryExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeTryKeyword?.raw,
      tryKeyword.raw,
      garbageBetweenTryKeywordAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      garbageBetweenQuestionOrExclamationMarkAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TryExprSyntax")
  public static func makeBlankTryExpr(presence: SourcePresence = .present) -> TryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tryExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.tryKeyword),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return TryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AwaitExprSyntax")
  public static func makeAwaitExpr(_ garbageBeforeAwaitKeyword: GarbageNodesSyntax? = nil, awaitKeyword: TokenSyntax, _ garbageBetweenAwaitKeywordAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax) -> AwaitExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAwaitKeyword?.raw,
      awaitKeyword.raw,
      garbageBetweenAwaitKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.awaitExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AwaitExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AwaitExprSyntax")
  public static func makeBlankAwaitExpr(presence: SourcePresence = .present) -> AwaitExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .awaitExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.contextualKeyword("")),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return AwaitExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MoveExprSyntax")
  public static func makeMoveExpr(_ garbageBeforeMoveKeyword: GarbageNodesSyntax? = nil, moveKeyword: TokenSyntax, _ garbageBetweenMoveKeywordAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax) -> MoveExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeMoveKeyword?.raw,
      moveKeyword.raw,
      garbageBetweenMoveKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.moveExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MoveExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MoveExprSyntax")
  public static func makeBlankMoveExpr(presence: SourcePresence = .present) -> MoveExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .moveExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.contextualKeyword("")),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return MoveExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentSyntax")
  public static func makeDeclNameArgument(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax) -> DeclNameArgumentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndColon?.raw,
      colon.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declNameArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentSyntax")
  public static func makeBlankDeclNameArgument(presence: SourcePresence = .present) -> DeclNameArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declNameArgument,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
    ], length: .zero, presence: presence))
    return DeclNameArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentListSyntax")
  public static func makeDeclNameArgumentList(
    _ elements: [DeclNameArgumentSyntax]) -> DeclNameArgumentListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declNameArgumentList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentListSyntax")
  public static func makeBlankDeclNameArgumentList(presence: SourcePresence = .present) -> DeclNameArgumentListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declNameArgumentList,
      layout: [
    ], length: .zero, presence: presence))
    return DeclNameArgumentListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentsSyntax")
  public static func makeDeclNameArguments(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndArguments: GarbageNodesSyntax? = nil, arguments: DeclNameArgumentListSyntax, _ garbageBetweenArgumentsAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> DeclNameArgumentsSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      garbageBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declNameArguments,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentsSyntax")
  public static func makeBlankDeclNameArguments(presence: SourcePresence = .present) -> DeclNameArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declNameArguments,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.declNameArgumentList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return DeclNameArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IdentifierExprSyntax")
  public static func makeIdentifierExpr(_ garbageBeforeIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndDeclNameArguments: GarbageNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?) -> IdentifierExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.identifierExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IdentifierExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IdentifierExprSyntax")
  public static func makeBlankIdentifierExpr(presence: SourcePresence = .present) -> IdentifierExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .identifierExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return IdentifierExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SuperRefExprSyntax")
  public static func makeSuperRefExpr(_ garbageBeforeSuperKeyword: GarbageNodesSyntax? = nil, superKeyword: TokenSyntax) -> SuperRefExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeSuperKeyword?.raw,
      superKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.superRefExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SuperRefExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SuperRefExprSyntax")
  public static func makeBlankSuperRefExpr(presence: SourcePresence = .present) -> SuperRefExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .superRefExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.superKeyword),
    ], length: .zero, presence: presence))
    return SuperRefExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on NilLiteralExprSyntax")
  public static func makeNilLiteralExpr(_ garbageBeforeNilKeyword: GarbageNodesSyntax? = nil, nilKeyword: TokenSyntax) -> NilLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeNilKeyword?.raw,
      nilKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.nilLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return NilLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on NilLiteralExprSyntax")
  public static func makeBlankNilLiteralExpr(presence: SourcePresence = .present) -> NilLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .nilLiteralExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.nilKeyword),
    ], length: .zero, presence: presence))
    return NilLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DiscardAssignmentExprSyntax")
  public static func makeDiscardAssignmentExpr(_ garbageBeforeWildcard: GarbageNodesSyntax? = nil, wildcard: TokenSyntax) -> DiscardAssignmentExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeWildcard?.raw,
      wildcard.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.discardAssignmentExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DiscardAssignmentExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DiscardAssignmentExprSyntax")
  public static func makeBlankDiscardAssignmentExpr(presence: SourcePresence = .present) -> DiscardAssignmentExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .discardAssignmentExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.wildcardKeyword),
    ], length: .zero, presence: presence))
    return DiscardAssignmentExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AssignmentExprSyntax")
  public static func makeAssignmentExpr(_ garbageBeforeAssignToken: GarbageNodesSyntax? = nil, assignToken: TokenSyntax) -> AssignmentExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAssignToken?.raw,
      assignToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.assignmentExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AssignmentExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AssignmentExprSyntax")
  public static func makeBlankAssignmentExpr(presence: SourcePresence = .present) -> AssignmentExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .assignmentExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.equal),
    ], length: .zero, presence: presence))
    return AssignmentExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SequenceExprSyntax")
  public static func makeSequenceExpr(_ garbageBeforeElements: GarbageNodesSyntax? = nil, elements: ExprListSyntax) -> SequenceExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.sequenceExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SequenceExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SequenceExprSyntax")
  public static func makeBlankSequenceExpr(presence: SourcePresence = .present) -> SequenceExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .sequenceExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.exprList),
    ], length: .zero, presence: presence))
    return SequenceExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExprListSyntax")
  public static func makeExprList(
    _ elements: [ExprSyntax]) -> ExprListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.exprList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExprListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExprListSyntax")
  public static func makeBlankExprList(presence: SourcePresence = .present) -> ExprListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .exprList,
      layout: [
    ], length: .zero, presence: presence))
    return ExprListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundLineExprSyntax")
  public static func makePoundLineExpr(_ garbageBeforePoundLine: GarbageNodesSyntax? = nil, poundLine: TokenSyntax) -> PoundLineExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundLine?.raw,
      poundLine.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundLineExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundLineExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundLineExprSyntax")
  public static func makeBlankPoundLineExpr(presence: SourcePresence = .present) -> PoundLineExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundLineExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundLineKeyword),
    ], length: .zero, presence: presence))
    return PoundLineExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundFileExprSyntax")
  public static func makePoundFileExpr(_ garbageBeforePoundFile: GarbageNodesSyntax? = nil, poundFile: TokenSyntax) -> PoundFileExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundFile?.raw,
      poundFile.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFileExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundFileExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundFileExprSyntax")
  public static func makeBlankPoundFileExpr(presence: SourcePresence = .present) -> PoundFileExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundFileExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundFileKeyword),
    ], length: .zero, presence: presence))
    return PoundFileExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundFileIDExprSyntax")
  public static func makePoundFileIDExpr(_ garbageBeforePoundFileID: GarbageNodesSyntax? = nil, poundFileID: TokenSyntax) -> PoundFileIDExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundFileID?.raw,
      poundFileID.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFileIDExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundFileIDExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundFileIDExprSyntax")
  public static func makeBlankPoundFileIDExpr(presence: SourcePresence = .present) -> PoundFileIDExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundFileIDExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundFileIDKeyword),
    ], length: .zero, presence: presence))
    return PoundFileIDExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundFilePathExprSyntax")
  public static func makePoundFilePathExpr(_ garbageBeforePoundFilePath: GarbageNodesSyntax? = nil, poundFilePath: TokenSyntax) -> PoundFilePathExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundFilePath?.raw,
      poundFilePath.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFilePathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundFilePathExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundFilePathExprSyntax")
  public static func makeBlankPoundFilePathExpr(presence: SourcePresence = .present) -> PoundFilePathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundFilePathExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundFilePathKeyword),
    ], length: .zero, presence: presence))
    return PoundFilePathExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundFunctionExprSyntax")
  public static func makePoundFunctionExpr(_ garbageBeforePoundFunction: GarbageNodesSyntax? = nil, poundFunction: TokenSyntax) -> PoundFunctionExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundFunction?.raw,
      poundFunction.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFunctionExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundFunctionExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundFunctionExprSyntax")
  public static func makeBlankPoundFunctionExpr(presence: SourcePresence = .present) -> PoundFunctionExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundFunctionExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundFunctionKeyword),
    ], length: .zero, presence: presence))
    return PoundFunctionExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundDsohandleExprSyntax")
  public static func makePoundDsohandleExpr(_ garbageBeforePoundDsohandle: GarbageNodesSyntax? = nil, poundDsohandle: TokenSyntax) -> PoundDsohandleExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundDsohandle?.raw,
      poundDsohandle.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundDsohandleExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundDsohandleExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundDsohandleExprSyntax")
  public static func makeBlankPoundDsohandleExpr(presence: SourcePresence = .present) -> PoundDsohandleExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundDsohandleExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundDsohandleKeyword),
    ], length: .zero, presence: presence))
    return PoundDsohandleExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SymbolicReferenceExprSyntax")
  public static func makeSymbolicReferenceExpr(_ garbageBeforeIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndGenericArgumentClause: GarbageNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.symbolicReferenceExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SymbolicReferenceExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SymbolicReferenceExprSyntax")
  public static func makeBlankSymbolicReferenceExpr(presence: SourcePresence = .present) -> SymbolicReferenceExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .symbolicReferenceExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return SymbolicReferenceExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrefixOperatorExprSyntax")
  public static func makePrefixOperatorExpr(_ garbageBeforeOperatorToken: GarbageNodesSyntax? = nil, operatorToken: TokenSyntax?, _ garbageBetweenOperatorTokenAndPostfixExpression: GarbageNodesSyntax? = nil, postfixExpression: ExprSyntax) -> PrefixOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeOperatorToken?.raw,
      operatorToken?.raw,
      garbageBetweenOperatorTokenAndPostfixExpression?.raw,
      postfixExpression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.prefixOperatorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrefixOperatorExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrefixOperatorExprSyntax")
  public static func makeBlankPrefixOperatorExpr(presence: SourcePresence = .present) -> PrefixOperatorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .prefixOperatorExpr,
      layout: [
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return PrefixOperatorExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BinaryOperatorExprSyntax")
  public static func makeBinaryOperatorExpr(_ garbageBeforeOperatorToken: GarbageNodesSyntax? = nil, operatorToken: TokenSyntax) -> BinaryOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeOperatorToken?.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.binaryOperatorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BinaryOperatorExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BinaryOperatorExprSyntax")
  public static func makeBlankBinaryOperatorExpr(presence: SourcePresence = .present) -> BinaryOperatorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .binaryOperatorExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
    ], length: .zero, presence: presence))
    return BinaryOperatorExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrowExprSyntax")
  public static func makeArrowExpr(_ garbageBeforeAsyncKeyword: GarbageNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ garbageBetweenAsyncKeywordAndThrowsToken: GarbageNodesSyntax? = nil, throwsToken: TokenSyntax?, _ garbageBetweenThrowsTokenAndArrowToken: GarbageNodesSyntax? = nil, arrowToken: TokenSyntax) -> ArrowExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAsyncKeyword?.raw,
      asyncKeyword?.raw,
      garbageBetweenAsyncKeywordAndThrowsToken?.raw,
      throwsToken?.raw,
      garbageBetweenThrowsTokenAndArrowToken?.raw,
      arrowToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrowExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrowExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrowExprSyntax")
  public static func makeBlankArrowExpr(presence: SourcePresence = .present) -> ArrowExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrowExpr,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.arrow),
    ], length: .zero, presence: presence))
    return ArrowExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InfixOperatorExprSyntax")
  public static func makeInfixOperatorExpr(_ garbageBeforeLeftOperand: GarbageNodesSyntax? = nil, leftOperand: ExprSyntax, _ garbageBetweenLeftOperandAndOperatorOperand: GarbageNodesSyntax? = nil, operatorOperand: ExprSyntax, _ garbageBetweenOperatorOperandAndRightOperand: GarbageNodesSyntax? = nil, rightOperand: ExprSyntax) -> InfixOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftOperand?.raw,
      leftOperand.raw,
      garbageBetweenLeftOperandAndOperatorOperand?.raw,
      operatorOperand.raw,
      garbageBetweenOperatorOperandAndRightOperand?.raw,
      rightOperand.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.infixOperatorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InfixOperatorExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InfixOperatorExprSyntax")
  public static func makeBlankInfixOperatorExpr(presence: SourcePresence = .present) -> InfixOperatorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .infixOperatorExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return InfixOperatorExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FloatLiteralExprSyntax")
  public static func makeFloatLiteralExpr(_ garbageBeforeFloatingDigits: GarbageNodesSyntax? = nil, floatingDigits: TokenSyntax) -> FloatLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeFloatingDigits?.raw,
      floatingDigits.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.floatLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FloatLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FloatLiteralExprSyntax")
  public static func makeBlankFloatLiteralExpr(presence: SourcePresence = .present) -> FloatLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .floatLiteralExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.floatingLiteral("")),
    ], length: .zero, presence: presence))
    return FloatLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleExprSyntax")
  public static func makeTupleExpr(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndElementList: GarbageNodesSyntax? = nil, elementList: TupleExprElementListSyntax, _ garbageBetweenElementListAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> TupleExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      garbageBetweenElementListAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleExprSyntax")
  public static func makeBlankTupleExpr(presence: SourcePresence = .present) -> TupleExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return TupleExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrayExprSyntax")
  public static func makeArrayExpr(_ garbageBeforeLeftSquare: GarbageNodesSyntax? = nil, leftSquare: TokenSyntax, _ garbageBetweenLeftSquareAndElements: GarbageNodesSyntax? = nil, elements: ArrayElementListSyntax, _ garbageBetweenElementsAndRightSquare: GarbageNodesSyntax? = nil, rightSquare: TokenSyntax) -> ArrayExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquare?.raw,
      leftSquare.raw,
      garbageBetweenLeftSquareAndElements?.raw,
      elements.raw,
      garbageBetweenElementsAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrayExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrayExprSyntax")
  public static func makeBlankArrayExpr(presence: SourcePresence = .present) -> ArrayExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrayExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      nil,
      RawSyntax.missing(SyntaxKind.arrayElementList),
      nil,
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return ArrayExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DictionaryExprSyntax")
  public static func makeDictionaryExpr(_ garbageBeforeLeftSquare: GarbageNodesSyntax? = nil, leftSquare: TokenSyntax, _ garbageBetweenLeftSquareAndContent: GarbageNodesSyntax? = nil, content: Syntax, _ garbageBetweenContentAndRightSquare: GarbageNodesSyntax? = nil, rightSquare: TokenSyntax) -> DictionaryExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquare?.raw,
      leftSquare.raw,
      garbageBetweenLeftSquareAndContent?.raw,
      content.raw,
      garbageBetweenContentAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DictionaryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DictionaryExprSyntax")
  public static func makeBlankDictionaryExpr(presence: SourcePresence = .present) -> DictionaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .dictionaryExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return DictionaryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleExprElementSyntax")
  public static func makeTupleExprElement(_ garbageBeforeLabel: GarbageNodesSyntax? = nil, label: TokenSyntax?, _ garbageBetweenLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax?, _ garbageBetweenColonAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax, _ garbageBetweenExpressionAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> TupleExprElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLabel?.raw,
      label?.raw,
      garbageBetweenLabelAndColon?.raw,
      colon?.raw,
      garbageBetweenColonAndExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleExprElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleExprElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleExprElementSyntax")
  public static func makeBlankTupleExprElement(presence: SourcePresence = .present) -> TupleExprElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleExprElement,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return TupleExprElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrayElementSyntax")
  public static func makeArrayElement(_ garbageBeforeExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax, _ garbageBetweenExpressionAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> ArrayElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrayElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrayElementSyntax")
  public static func makeBlankArrayElement(presence: SourcePresence = .present) -> ArrayElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrayElement,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ArrayElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DictionaryElementSyntax")
  public static func makeDictionaryElement(_ garbageBeforeKeyExpression: GarbageNodesSyntax? = nil, keyExpression: ExprSyntax, _ garbageBetweenKeyExpressionAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndValueExpression: GarbageNodesSyntax? = nil, valueExpression: ExprSyntax, _ garbageBetweenValueExpressionAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> DictionaryElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeKeyExpression?.raw,
      keyExpression.raw,
      garbageBetweenKeyExpressionAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndValueExpression?.raw,
      valueExpression.raw,
      garbageBetweenValueExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DictionaryElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DictionaryElementSyntax")
  public static func makeBlankDictionaryElement(presence: SourcePresence = .present) -> DictionaryElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .dictionaryElement,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DictionaryElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IntegerLiteralExprSyntax")
  public static func makeIntegerLiteralExpr(_ garbageBeforeDigits: GarbageNodesSyntax? = nil, digits: TokenSyntax) -> IntegerLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeDigits?.raw,
      digits.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.integerLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IntegerLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IntegerLiteralExprSyntax")
  public static func makeBlankIntegerLiteralExpr(presence: SourcePresence = .present) -> IntegerLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .integerLiteralExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
    ], length: .zero, presence: presence))
    return IntegerLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BooleanLiteralExprSyntax")
  public static func makeBooleanLiteralExpr(_ garbageBeforeBooleanLiteral: GarbageNodesSyntax? = nil, booleanLiteral: TokenSyntax) -> BooleanLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBooleanLiteral?.raw,
      booleanLiteral.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.booleanLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BooleanLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BooleanLiteralExprSyntax")
  public static func makeBlankBooleanLiteralExpr(presence: SourcePresence = .present) -> BooleanLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .booleanLiteralExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.trueKeyword),
    ], length: .zero, presence: presence))
    return BooleanLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TernaryExprSyntax")
  public static func makeTernaryExpr(_ garbageBeforeConditionExpression: GarbageNodesSyntax? = nil, conditionExpression: ExprSyntax, _ garbageBetweenConditionExpressionAndQuestionMark: GarbageNodesSyntax? = nil, questionMark: TokenSyntax, _ garbageBetweenQuestionMarkAndFirstChoice: GarbageNodesSyntax? = nil, firstChoice: ExprSyntax, _ garbageBetweenFirstChoiceAndColonMark: GarbageNodesSyntax? = nil, colonMark: TokenSyntax, _ garbageBetweenColonMarkAndSecondChoice: GarbageNodesSyntax? = nil, secondChoice: ExprSyntax) -> TernaryExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeConditionExpression?.raw,
      conditionExpression.raw,
      garbageBetweenConditionExpressionAndQuestionMark?.raw,
      questionMark.raw,
      garbageBetweenQuestionMarkAndFirstChoice?.raw,
      firstChoice.raw,
      garbageBetweenFirstChoiceAndColonMark?.raw,
      colonMark.raw,
      garbageBetweenColonMarkAndSecondChoice?.raw,
      secondChoice.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ternaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TernaryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TernaryExprSyntax")
  public static func makeBlankTernaryExpr(presence: SourcePresence = .present) -> TernaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ternaryExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.infixQuestionMark),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return TernaryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberAccessExprSyntax")
  public static func makeMemberAccessExpr(_ garbageBeforeBase: GarbageNodesSyntax? = nil, base: ExprSyntax?, _ garbageBetweenBaseAndDot: GarbageNodesSyntax? = nil, dot: TokenSyntax, _ garbageBetweenDotAndName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndDeclNameArguments: GarbageNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?) -> MemberAccessExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBase?.raw,
      base?.raw,
      garbageBetweenBaseAndDot?.raw,
      dot.raw,
      garbageBetweenDotAndName?.raw,
      name.raw,
      garbageBetweenNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberAccessExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberAccessExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberAccessExprSyntax")
  public static func makeBlankMemberAccessExpr(presence: SourcePresence = .present) -> MemberAccessExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberAccessExpr,
      layout: [
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.period),
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return MemberAccessExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IsExprSyntax")
  public static func makeIsExpr(_ garbageBeforeIsTok: GarbageNodesSyntax? = nil, isTok: TokenSyntax, _ garbageBetweenIsTokAndTypeName: GarbageNodesSyntax? = nil, typeName: TypeSyntax) -> IsExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIsTok?.raw,
      isTok.raw,
      garbageBetweenIsTokAndTypeName?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.isExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IsExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IsExprSyntax")
  public static func makeBlankIsExpr(presence: SourcePresence = .present) -> IsExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .isExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.isKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return IsExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AsExprSyntax")
  public static func makeAsExpr(_ garbageBeforeAsTok: GarbageNodesSyntax? = nil, asTok: TokenSyntax, _ garbageBetweenAsTokAndQuestionOrExclamationMark: GarbageNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax?, _ garbageBetweenQuestionOrExclamationMarkAndTypeName: GarbageNodesSyntax? = nil, typeName: TypeSyntax) -> AsExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAsTok?.raw,
      asTok.raw,
      garbageBetweenAsTokAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      garbageBetweenQuestionOrExclamationMarkAndTypeName?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.asExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AsExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AsExprSyntax")
  public static func makeBlankAsExpr(presence: SourcePresence = .present) -> AsExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .asExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.asKeyword),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return AsExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypeExprSyntax")
  public static func makeTypeExpr(_ garbageBeforeType: GarbageNodesSyntax? = nil, type: TypeSyntax) -> TypeExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypeExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypeExprSyntax")
  public static func makeBlankTypeExpr(presence: SourcePresence = .present) -> TypeExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typeExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return TypeExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemSyntax")
  public static func makeClosureCaptureItem(_ garbageBeforeSpecifier: GarbageNodesSyntax? = nil, specifier: TokenListSyntax?, _ garbageBetweenSpecifierAndName: GarbageNodesSyntax? = nil, name: TokenSyntax?, _ garbageBetweenNameAndAssignToken: GarbageNodesSyntax? = nil, assignToken: TokenSyntax?, _ garbageBetweenAssignTokenAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax, _ garbageBetweenExpressionAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> ClosureCaptureItemSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeSpecifier?.raw,
      specifier?.raw,
      garbageBetweenSpecifierAndName?.raw,
      name?.raw,
      garbageBetweenNameAndAssignToken?.raw,
      assignToken?.raw,
      garbageBetweenAssignTokenAndExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureCaptureItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemSyntax")
  public static func makeBlankClosureCaptureItem(presence: SourcePresence = .present) -> ClosureCaptureItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureCaptureItem,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ClosureCaptureItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemListSyntax")
  public static func makeClosureCaptureItemList(
    _ elements: [ClosureCaptureItemSyntax]) -> ClosureCaptureItemListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureCaptureItemList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureItemListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemListSyntax")
  public static func makeBlankClosureCaptureItemList(presence: SourcePresence = .present) -> ClosureCaptureItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureCaptureItemList,
      layout: [
    ], length: .zero, presence: presence))
    return ClosureCaptureItemListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureSignatureSyntax")
  public static func makeClosureCaptureSignature(_ garbageBeforeLeftSquare: GarbageNodesSyntax? = nil, leftSquare: TokenSyntax, _ garbageBetweenLeftSquareAndItems: GarbageNodesSyntax? = nil, items: ClosureCaptureItemListSyntax?, _ garbageBetweenItemsAndRightSquare: GarbageNodesSyntax? = nil, rightSquare: TokenSyntax) -> ClosureCaptureSignatureSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquare?.raw,
      leftSquare.raw,
      garbageBetweenLeftSquareAndItems?.raw,
      items?.raw,
      garbageBetweenItemsAndRightSquare?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureCaptureSignature,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureSignatureSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureSignatureSyntax")
  public static func makeBlankClosureCaptureSignature(presence: SourcePresence = .present) -> ClosureCaptureSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureCaptureSignature,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return ClosureCaptureSignatureSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureParamSyntax")
  public static func makeClosureParam(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> ClosureParamSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureParam,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureParamSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureParamSyntax")
  public static func makeBlankClosureParam(presence: SourcePresence = .present) -> ClosureParamSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureParam,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ClosureParamSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureParamListSyntax")
  public static func makeClosureParamList(
    _ elements: [ClosureParamSyntax]) -> ClosureParamListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureParamList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureParamListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureParamListSyntax")
  public static func makeBlankClosureParamList(presence: SourcePresence = .present) -> ClosureParamListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureParamList,
      layout: [
    ], length: .zero, presence: presence))
    return ClosureParamListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureSignatureSyntax")
  public static func makeClosureSignature(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndCapture: GarbageNodesSyntax? = nil, capture: ClosureCaptureSignatureSyntax?, _ garbageBetweenCaptureAndInput: GarbageNodesSyntax? = nil, input: Syntax?, _ garbageBetweenInputAndAsyncKeyword: GarbageNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ garbageBetweenAsyncKeywordAndThrowsTok: GarbageNodesSyntax? = nil, throwsTok: TokenSyntax?, _ garbageBetweenThrowsTokAndOutput: GarbageNodesSyntax? = nil, output: ReturnClauseSyntax?, _ garbageBetweenOutputAndInTok: GarbageNodesSyntax? = nil, inTok: TokenSyntax) -> ClosureSignatureSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndCapture?.raw,
      capture?.raw,
      garbageBetweenCaptureAndInput?.raw,
      input?.raw,
      garbageBetweenInputAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      garbageBetweenAsyncKeywordAndThrowsTok?.raw,
      throwsTok?.raw,
      garbageBetweenThrowsTokAndOutput?.raw,
      output?.raw,
      garbageBetweenOutputAndInTok?.raw,
      inTok.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureSignature,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureSignatureSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureSignatureSyntax")
  public static func makeBlankClosureSignature(presence: SourcePresence = .present) -> ClosureSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureSignature,
      layout: [
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
      RawSyntax.missingToken(TokenKind.inKeyword),
    ], length: .zero, presence: presence))
    return ClosureSignatureSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClosureExprSyntax")
  public static func makeClosureExpr(_ garbageBeforeLeftBrace: GarbageNodesSyntax? = nil, leftBrace: TokenSyntax, _ garbageBetweenLeftBraceAndSignature: GarbageNodesSyntax? = nil, signature: ClosureSignatureSyntax?, _ garbageBetweenSignatureAndStatements: GarbageNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ garbageBetweenStatementsAndRightBrace: GarbageNodesSyntax? = nil, rightBrace: TokenSyntax) -> ClosureExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndSignature?.raw,
      signature?.raw,
      garbageBetweenSignatureAndStatements?.raw,
      statements.raw,
      garbageBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClosureExprSyntax")
  public static func makeBlankClosureExpr(presence: SourcePresence = .present) -> ClosureExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftBrace),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
      nil,
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return ClosureExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedPatternExprSyntax")
  public static func makeUnresolvedPatternExpr(_ garbageBeforePattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax) -> UnresolvedPatternExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePattern?.raw,
      pattern.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unresolvedPatternExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return UnresolvedPatternExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedPatternExprSyntax")
  public static func makeBlankUnresolvedPatternExpr(presence: SourcePresence = .present) -> UnresolvedPatternExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unresolvedPatternExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
    ], length: .zero, presence: presence))
    return UnresolvedPatternExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementSyntax")
  public static func makeMultipleTrailingClosureElement(_ garbageBeforeLabel: GarbageNodesSyntax? = nil, label: TokenSyntax, _ garbageBetweenLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndClosure: GarbageNodesSyntax? = nil, closure: ClosureExprSyntax) -> MultipleTrailingClosureElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLabel?.raw,
      label.raw,
      garbageBetweenLabelAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndClosure?.raw,
      closure.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.multipleTrailingClosureElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MultipleTrailingClosureElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementSyntax")
  public static func makeBlankMultipleTrailingClosureElement(presence: SourcePresence = .present) -> MultipleTrailingClosureElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .multipleTrailingClosureElement,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.closureExpr),
    ], length: .zero, presence: presence))
    return MultipleTrailingClosureElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementListSyntax")
  public static func makeMultipleTrailingClosureElementList(
    _ elements: [MultipleTrailingClosureElementSyntax]) -> MultipleTrailingClosureElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.multipleTrailingClosureElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MultipleTrailingClosureElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementListSyntax")
  public static func makeBlankMultipleTrailingClosureElementList(presence: SourcePresence = .present) -> MultipleTrailingClosureElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .multipleTrailingClosureElementList,
      layout: [
    ], length: .zero, presence: presence))
    return MultipleTrailingClosureElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionCallExprSyntax")
  public static func makeFunctionCallExpr(_ garbageBeforeCalledExpression: GarbageNodesSyntax? = nil, calledExpression: ExprSyntax, _ garbageBetweenCalledExpressionAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax?, _ garbageBetweenLeftParenAndArgumentList: GarbageNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ garbageBetweenArgumentListAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax?, _ garbageBetweenRightParenAndTrailingClosure: GarbageNodesSyntax? = nil, trailingClosure: ClosureExprSyntax?, _ garbageBetweenTrailingClosureAndAdditionalTrailingClosures: GarbageNodesSyntax? = nil, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?) -> FunctionCallExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeCalledExpression?.raw,
      calledExpression.raw,
      garbageBetweenCalledExpressionAndLeftParen?.raw,
      leftParen?.raw,
      garbageBetweenLeftParenAndArgumentList?.raw,
      argumentList.raw,
      garbageBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
      garbageBetweenRightParenAndTrailingClosure?.raw,
      trailingClosure?.raw,
      garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionCallExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionCallExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionCallExprSyntax")
  public static func makeBlankFunctionCallExpr(presence: SourcePresence = .present) -> FunctionCallExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionCallExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return FunctionCallExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SubscriptExprSyntax")
  public static func makeSubscriptExpr(_ garbageBeforeCalledExpression: GarbageNodesSyntax? = nil, calledExpression: ExprSyntax, _ garbageBetweenCalledExpressionAndLeftBracket: GarbageNodesSyntax? = nil, leftBracket: TokenSyntax, _ garbageBetweenLeftBracketAndArgumentList: GarbageNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ garbageBetweenArgumentListAndRightBracket: GarbageNodesSyntax? = nil, rightBracket: TokenSyntax, _ garbageBetweenRightBracketAndTrailingClosure: GarbageNodesSyntax? = nil, trailingClosure: ClosureExprSyntax?, _ garbageBetweenTrailingClosureAndAdditionalTrailingClosures: GarbageNodesSyntax? = nil, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?) -> SubscriptExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeCalledExpression?.raw,
      calledExpression.raw,
      garbageBetweenCalledExpressionAndLeftBracket?.raw,
      leftBracket.raw,
      garbageBetweenLeftBracketAndArgumentList?.raw,
      argumentList.raw,
      garbageBetweenArgumentListAndRightBracket?.raw,
      rightBracket.raw,
      garbageBetweenRightBracketAndTrailingClosure?.raw,
      trailingClosure?.raw,
      garbageBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.subscriptExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SubscriptExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SubscriptExprSyntax")
  public static func makeBlankSubscriptExpr(presence: SourcePresence = .present) -> SubscriptExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .subscriptExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      nil,
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      nil,
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return SubscriptExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OptionalChainingExprSyntax")
  public static func makeOptionalChainingExpr(_ garbageBeforeExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax, _ garbageBetweenExpressionAndQuestionMark: GarbageNodesSyntax? = nil, questionMark: TokenSyntax) -> OptionalChainingExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalChainingExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OptionalChainingExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OptionalChainingExprSyntax")
  public static func makeBlankOptionalChainingExpr(presence: SourcePresence = .present) -> OptionalChainingExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .optionalChainingExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
    ], length: .zero, presence: presence))
    return OptionalChainingExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ForcedValueExprSyntax")
  public static func makeForcedValueExpr(_ garbageBeforeExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax, _ garbageBetweenExpressionAndExclamationMark: GarbageNodesSyntax? = nil, exclamationMark: TokenSyntax) -> ForcedValueExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndExclamationMark?.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.forcedValueExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ForcedValueExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ForcedValueExprSyntax")
  public static func makeBlankForcedValueExpr(presence: SourcePresence = .present) -> ForcedValueExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .forcedValueExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.exclamationMark),
    ], length: .zero, presence: presence))
    return ForcedValueExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PostfixUnaryExprSyntax")
  public static func makePostfixUnaryExpr(_ garbageBeforeExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax, _ garbageBetweenExpressionAndOperatorToken: GarbageNodesSyntax? = nil, operatorToken: TokenSyntax) -> PostfixUnaryExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndOperatorToken?.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.postfixUnaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PostfixUnaryExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PostfixUnaryExprSyntax")
  public static func makeBlankPostfixUnaryExpr(presence: SourcePresence = .present) -> PostfixUnaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .postfixUnaryExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.postfixOperator("")),
    ], length: .zero, presence: presence))
    return PostfixUnaryExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SpecializeExprSyntax")
  public static func makeSpecializeExpr(_ garbageBeforeExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax, _ garbageBetweenExpressionAndGenericArgumentClause: GarbageNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax) -> SpecializeExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndGenericArgumentClause?.raw,
      genericArgumentClause.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.specializeExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SpecializeExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SpecializeExprSyntax")
  public static func makeBlankSpecializeExpr(presence: SourcePresence = .present) -> SpecializeExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .specializeExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
    ], length: .zero, presence: presence))
    return SpecializeExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on StringSegmentSyntax")
  public static func makeStringSegment(_ garbageBeforeContent: GarbageNodesSyntax? = nil, content: TokenSyntax) -> StringSegmentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeContent?.raw,
      content.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.stringSegment,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return StringSegmentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on StringSegmentSyntax")
  public static func makeBlankStringSegment(presence: SourcePresence = .present) -> StringSegmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .stringSegment,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.stringSegment("")),
    ], length: .zero, presence: presence))
    return StringSegmentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExpressionSegmentSyntax")
  public static func makeExpressionSegment(_ garbageBeforeBackslash: GarbageNodesSyntax? = nil, backslash: TokenSyntax, _ garbageBetweenBackslashAndDelimiter: GarbageNodesSyntax? = nil, delimiter: TokenSyntax?, _ garbageBetweenDelimiterAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndExpressions: GarbageNodesSyntax? = nil, expressions: TupleExprElementListSyntax, _ garbageBetweenExpressionsAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> ExpressionSegmentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBackslash?.raw,
      backslash.raw,
      garbageBetweenBackslashAndDelimiter?.raw,
      delimiter?.raw,
      garbageBetweenDelimiterAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndExpressions?.raw,
      expressions.raw,
      garbageBetweenExpressionsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.expressionSegment,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExpressionSegmentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExpressionSegmentSyntax")
  public static func makeBlankExpressionSegment(presence: SourcePresence = .present) -> ExpressionSegmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .expressionSegment,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.backslash),
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      nil,
      RawSyntax.missingToken(TokenKind.stringInterpolationAnchor),
    ], length: .zero, presence: presence))
    return ExpressionSegmentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on StringLiteralExprSyntax")
  public static func makeStringLiteralExpr(_ garbageBeforeOpenDelimiter: GarbageNodesSyntax? = nil, openDelimiter: TokenSyntax?, _ garbageBetweenOpenDelimiterAndOpenQuote: GarbageNodesSyntax? = nil, openQuote: TokenSyntax, _ garbageBetweenOpenQuoteAndSegments: GarbageNodesSyntax? = nil, segments: StringLiteralSegmentsSyntax, _ garbageBetweenSegmentsAndCloseQuote: GarbageNodesSyntax? = nil, closeQuote: TokenSyntax, _ garbageBetweenCloseQuoteAndCloseDelimiter: GarbageNodesSyntax? = nil, closeDelimiter: TokenSyntax?) -> StringLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeOpenDelimiter?.raw,
      openDelimiter?.raw,
      garbageBetweenOpenDelimiterAndOpenQuote?.raw,
      openQuote.raw,
      garbageBetweenOpenQuoteAndSegments?.raw,
      segments.raw,
      garbageBetweenSegmentsAndCloseQuote?.raw,
      closeQuote.raw,
      garbageBetweenCloseQuoteAndCloseDelimiter?.raw,
      closeDelimiter?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.stringLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return StringLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on StringLiteralExprSyntax")
  public static func makeBlankStringLiteralExpr(presence: SourcePresence = .present) -> StringLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .stringLiteralExpr,
      layout: [
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.stringQuote),
      nil,
      RawSyntax.missing(SyntaxKind.stringLiteralSegments),
      nil,
      RawSyntax.missingToken(TokenKind.stringQuote),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return StringLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on RegexLiteralExprSyntax")
  public static func makeRegexLiteralExpr(_ garbageBeforeRegex: GarbageNodesSyntax? = nil, regex: TokenSyntax) -> RegexLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeRegex?.raw,
      regex.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.regexLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return RegexLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on RegexLiteralExprSyntax")
  public static func makeBlankRegexLiteralExpr(presence: SourcePresence = .present) -> RegexLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .regexLiteralExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.regexLiteral("")),
    ], length: .zero, presence: presence))
    return RegexLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathExprSyntax")
  public static func makeKeyPathExpr(_ garbageBeforeBackslash: GarbageNodesSyntax? = nil, backslash: TokenSyntax, _ garbageBetweenBackslashAndRootExpr: GarbageNodesSyntax? = nil, rootExpr: ExprSyntax?, _ garbageBetweenRootExprAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax) -> KeyPathExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBackslash?.raw,
      backslash.raw,
      garbageBetweenBackslashAndRootExpr?.raw,
      rootExpr?.raw,
      garbageBetweenRootExprAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.keyPathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return KeyPathExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathExprSyntax")
  public static func makeBlankKeyPathExpr(presence: SourcePresence = .present) -> KeyPathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .keyPathExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.backslash),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return KeyPathExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on KeyPathBaseExprSyntax")
  public static func makeKeyPathBaseExpr(_ garbageBeforePeriod: GarbageNodesSyntax? = nil, period: TokenSyntax) -> KeyPathBaseExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePeriod?.raw,
      period.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.keyPathBaseExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return KeyPathBaseExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on KeyPathBaseExprSyntax")
  public static func makeBlankKeyPathBaseExpr(presence: SourcePresence = .present) -> KeyPathBaseExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .keyPathBaseExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.period),
    ], length: .zero, presence: presence))
    return KeyPathBaseExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjcNamePieceSyntax")
  public static func makeObjcNamePiece(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndDot: GarbageNodesSyntax? = nil, dot: TokenSyntax?) -> ObjcNamePieceSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndDot?.raw,
      dot?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcNamePiece,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjcNamePieceSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjcNamePieceSyntax")
  public static func makeBlankObjcNamePiece(presence: SourcePresence = .present) -> ObjcNamePieceSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objcNamePiece,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ObjcNamePieceSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjcNameSyntax")
  public static func makeObjcName(
    _ elements: [ObjcNamePieceSyntax]) -> ObjcNameSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcName,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjcNameSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjcNameSyntax")
  public static func makeBlankObjcName(presence: SourcePresence = .present) -> ObjcNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objcName,
      layout: [
    ], length: .zero, presence: presence))
    return ObjcNameSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjcKeyPathExprSyntax")
  public static func makeObjcKeyPathExpr(_ garbageBeforeKeyPath: GarbageNodesSyntax? = nil, keyPath: TokenSyntax, _ garbageBetweenKeyPathAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndName: GarbageNodesSyntax? = nil, name: ObjcNameSyntax, _ garbageBetweenNameAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> ObjcKeyPathExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeKeyPath?.raw,
      keyPath.raw,
      garbageBetweenKeyPathAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndName?.raw,
      name.raw,
      garbageBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcKeyPathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjcKeyPathExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjcKeyPathExprSyntax")
  public static func makeBlankObjcKeyPathExpr(presence: SourcePresence = .present) -> ObjcKeyPathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objcKeyPathExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundKeyPathKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.objcName),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return ObjcKeyPathExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjcSelectorExprSyntax")
  public static func makeObjcSelectorExpr(_ garbageBeforePoundSelector: GarbageNodesSyntax? = nil, poundSelector: TokenSyntax, _ garbageBetweenPoundSelectorAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndKind: GarbageNodesSyntax? = nil, kind: TokenSyntax?, _ garbageBetweenKindAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax?, _ garbageBetweenColonAndName: GarbageNodesSyntax? = nil, name: ExprSyntax, _ garbageBetweenNameAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> ObjcSelectorExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundSelector?.raw,
      poundSelector.raw,
      garbageBetweenPoundSelectorAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndKind?.raw,
      kind?.raw,
      garbageBetweenKindAndColon?.raw,
      colon?.raw,
      garbageBetweenColonAndName?.raw,
      name.raw,
      garbageBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcSelectorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjcSelectorExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjcSelectorExprSyntax")
  public static func makeBlankObjcSelectorExpr(presence: SourcePresence = .present) -> ObjcSelectorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objcSelectorExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundSelectorKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return ObjcSelectorExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PostfixIfConfigExprSyntax")
  public static func makePostfixIfConfigExpr(_ garbageBeforeBase: GarbageNodesSyntax? = nil, base: ExprSyntax?, _ garbageBetweenBaseAndConfig: GarbageNodesSyntax? = nil, config: IfConfigDeclSyntax) -> PostfixIfConfigExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBase?.raw,
      base?.raw,
      garbageBetweenBaseAndConfig?.raw,
      config.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.postfixIfConfigExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PostfixIfConfigExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PostfixIfConfigExprSyntax")
  public static func makeBlankPostfixIfConfigExpr(presence: SourcePresence = .present) -> PostfixIfConfigExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .postfixIfConfigExpr,
      layout: [
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.ifConfigDecl),
    ], length: .zero, presence: presence))
    return PostfixIfConfigExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EditorPlaceholderExprSyntax")
  public static func makeEditorPlaceholderExpr(_ garbageBeforeIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax) -> EditorPlaceholderExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.editorPlaceholderExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EditorPlaceholderExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EditorPlaceholderExprSyntax")
  public static func makeBlankEditorPlaceholderExpr(presence: SourcePresence = .present) -> EditorPlaceholderExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .editorPlaceholderExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
    ], length: .zero, presence: presence))
    return EditorPlaceholderExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjectLiteralExprSyntax")
  public static func makeObjectLiteralExpr(_ garbageBeforeIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndArguments: GarbageNodesSyntax? = nil, arguments: TupleExprElementListSyntax, _ garbageBetweenArgumentsAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> ObjectLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      garbageBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objectLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjectLiteralExprSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjectLiteralExprSyntax")
  public static func makeBlankObjectLiteralExpr(presence: SourcePresence = .present) -> ObjectLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objectLiteralExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundColorLiteralKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return ObjectLiteralExprSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypeInitializerClauseSyntax")
  public static func makeTypeInitializerClause(_ garbageBeforeEqual: GarbageNodesSyntax? = nil, equal: TokenSyntax, _ garbageBetweenEqualAndValue: GarbageNodesSyntax? = nil, value: TypeSyntax) -> TypeInitializerClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeEqual?.raw,
      equal.raw,
      garbageBetweenEqualAndValue?.raw,
      value.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeInitializerClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypeInitializerClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypeInitializerClauseSyntax")
  public static func makeBlankTypeInitializerClause(presence: SourcePresence = .present) -> TypeInitializerClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typeInitializerClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.equal),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return TypeInitializerClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypealiasDeclSyntax")
  public static func makeTypealiasDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndTypealiasKeyword: GarbageNodesSyntax? = nil, typealiasKeyword: TokenSyntax, _ garbageBetweenTypealiasKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ garbageBetweenGenericParameterClauseAndInitializer: GarbageNodesSyntax? = nil, initializer: TypeInitializerClauseSyntax, _ garbageBetweenInitializerAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?) -> TypealiasDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndTypealiasKeyword?.raw,
      typealiasKeyword.raw,
      garbageBetweenTypealiasKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndInitializer?.raw,
      initializer.raw,
      garbageBetweenInitializerAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typealiasDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypealiasDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypealiasDeclSyntax")
  public static func makeBlankTypealiasDecl(presence: SourcePresence = .present) -> TypealiasDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typealiasDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.typealiasKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.typeInitializerClause),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return TypealiasDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AssociatedtypeDeclSyntax")
  public static func makeAssociatedtypeDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndAssociatedtypeKeyword: GarbageNodesSyntax? = nil, associatedtypeKeyword: TokenSyntax, _ garbageBetweenAssociatedtypeKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndInheritanceClause: GarbageNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ garbageBetweenInheritanceClauseAndInitializer: GarbageNodesSyntax? = nil, initializer: TypeInitializerClauseSyntax?, _ garbageBetweenInitializerAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndAssociatedtypeKeyword?.raw,
      associatedtypeKeyword.raw,
      garbageBetweenAssociatedtypeKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndInitializer?.raw,
      initializer?.raw,
      garbageBetweenInitializerAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.associatedtypeDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AssociatedtypeDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AssociatedtypeDeclSyntax")
  public static func makeBlankAssociatedtypeDecl(presence: SourcePresence = .present) -> AssociatedtypeDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .associatedtypeDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.associatedtypeKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AssociatedtypeDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionParameterListSyntax")
  public static func makeFunctionParameterList(
    _ elements: [FunctionParameterSyntax]) -> FunctionParameterListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionParameterList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionParameterListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionParameterListSyntax")
  public static func makeBlankFunctionParameterList(presence: SourcePresence = .present) -> FunctionParameterListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionParameterList,
      layout: [
    ], length: .zero, presence: presence))
    return FunctionParameterListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ParameterClauseSyntax")
  public static func makeParameterClause(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndParameterList: GarbageNodesSyntax? = nil, parameterList: FunctionParameterListSyntax, _ garbageBetweenParameterListAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> ParameterClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndParameterList?.raw,
      parameterList.raw,
      garbageBetweenParameterListAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.parameterClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ParameterClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ParameterClauseSyntax")
  public static func makeBlankParameterClause(presence: SourcePresence = .present) -> ParameterClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .parameterClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.functionParameterList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return ParameterClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ReturnClauseSyntax")
  public static func makeReturnClause(_ garbageBeforeArrow: GarbageNodesSyntax? = nil, arrow: TokenSyntax, _ garbageBetweenArrowAndReturnType: GarbageNodesSyntax? = nil, returnType: TypeSyntax) -> ReturnClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeArrow?.raw,
      arrow.raw,
      garbageBetweenArrowAndReturnType?.raw,
      returnType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.returnClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ReturnClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ReturnClauseSyntax")
  public static func makeBlankReturnClause(presence: SourcePresence = .present) -> ReturnClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .returnClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.arrow),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return ReturnClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionSignatureSyntax")
  public static func makeFunctionSignature(_ garbageBeforeInput: GarbageNodesSyntax? = nil, input: ParameterClauseSyntax, _ garbageBetweenInputAndAsyncOrReasyncKeyword: GarbageNodesSyntax? = nil, asyncOrReasyncKeyword: TokenSyntax?, _ garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: GarbageNodesSyntax? = nil, throwsOrRethrowsKeyword: TokenSyntax?, _ garbageBetweenThrowsOrRethrowsKeywordAndOutput: GarbageNodesSyntax? = nil, output: ReturnClauseSyntax?) -> FunctionSignatureSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeInput?.raw,
      input.raw,
      garbageBetweenInputAndAsyncOrReasyncKeyword?.raw,
      asyncOrReasyncKeyword?.raw,
      garbageBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      garbageBetweenThrowsOrRethrowsKeywordAndOutput?.raw,
      output?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionSignature,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionSignatureSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionSignatureSyntax")
  public static func makeBlankFunctionSignature(presence: SourcePresence = .present) -> FunctionSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionSignature,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.parameterClause),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return FunctionSignatureSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IfConfigClauseSyntax")
  public static func makeIfConfigClause(_ garbageBeforePoundKeyword: GarbageNodesSyntax? = nil, poundKeyword: TokenSyntax, _ garbageBetweenPoundKeywordAndCondition: GarbageNodesSyntax? = nil, condition: ExprSyntax?, _ garbageBetweenConditionAndElements: GarbageNodesSyntax? = nil, elements: Syntax) -> IfConfigClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundKeyword?.raw,
      poundKeyword.raw,
      garbageBetweenPoundKeywordAndCondition?.raw,
      condition?.raw,
      garbageBetweenConditionAndElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifConfigClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IfConfigClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IfConfigClauseSyntax")
  public static func makeBlankIfConfigClause(presence: SourcePresence = .present) -> IfConfigClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ifConfigClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundIfKeyword),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return IfConfigClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IfConfigClauseListSyntax")
  public static func makeIfConfigClauseList(
    _ elements: [IfConfigClauseSyntax]) -> IfConfigClauseListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifConfigClauseList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IfConfigClauseListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IfConfigClauseListSyntax")
  public static func makeBlankIfConfigClauseList(presence: SourcePresence = .present) -> IfConfigClauseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ifConfigClauseList,
      layout: [
    ], length: .zero, presence: presence))
    return IfConfigClauseListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IfConfigDeclSyntax")
  public static func makeIfConfigDecl(_ garbageBeforeClauses: GarbageNodesSyntax? = nil, clauses: IfConfigClauseListSyntax, _ garbageBetweenClausesAndPoundEndif: GarbageNodesSyntax? = nil, poundEndif: TokenSyntax) -> IfConfigDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeClauses?.raw,
      clauses.raw,
      garbageBetweenClausesAndPoundEndif?.raw,
      poundEndif.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifConfigDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IfConfigDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IfConfigDeclSyntax")
  public static func makeBlankIfConfigDecl(presence: SourcePresence = .present) -> IfConfigDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ifConfigDecl,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.ifConfigClauseList),
      nil,
      RawSyntax.missingToken(TokenKind.poundEndifKeyword),
    ], length: .zero, presence: presence))
    return IfConfigDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundErrorDeclSyntax")
  public static func makePoundErrorDecl(_ garbageBeforePoundError: GarbageNodesSyntax? = nil, poundError: TokenSyntax, _ garbageBetweenPoundErrorAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndMessage: GarbageNodesSyntax? = nil, message: StringLiteralExprSyntax, _ garbageBetweenMessageAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> PoundErrorDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundError?.raw,
      poundError.raw,
      garbageBetweenPoundErrorAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndMessage?.raw,
      message.raw,
      garbageBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundErrorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundErrorDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundErrorDeclSyntax")
  public static func makeBlankPoundErrorDecl(presence: SourcePresence = .present) -> PoundErrorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundErrorDecl,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundErrorKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.stringLiteralExpr),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return PoundErrorDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundWarningDeclSyntax")
  public static func makePoundWarningDecl(_ garbageBeforePoundWarning: GarbageNodesSyntax? = nil, poundWarning: TokenSyntax, _ garbageBetweenPoundWarningAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndMessage: GarbageNodesSyntax? = nil, message: StringLiteralExprSyntax, _ garbageBetweenMessageAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> PoundWarningDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundWarning?.raw,
      poundWarning.raw,
      garbageBetweenPoundWarningAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndMessage?.raw,
      message.raw,
      garbageBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundWarningDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundWarningDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundWarningDeclSyntax")
  public static func makeBlankPoundWarningDecl(presence: SourcePresence = .present) -> PoundWarningDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundWarningDecl,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundWarningKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.stringLiteralExpr),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return PoundWarningDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundSourceLocationSyntax")
  public static func makePoundSourceLocation(_ garbageBeforePoundSourceLocation: GarbageNodesSyntax? = nil, poundSourceLocation: TokenSyntax, _ garbageBetweenPoundSourceLocationAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndArgs: GarbageNodesSyntax? = nil, args: PoundSourceLocationArgsSyntax?, _ garbageBetweenArgsAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> PoundSourceLocationSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundSourceLocation?.raw,
      poundSourceLocation.raw,
      garbageBetweenPoundSourceLocationAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndArgs?.raw,
      args?.raw,
      garbageBetweenArgsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundSourceLocation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundSourceLocationSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundSourceLocationSyntax")
  public static func makeBlankPoundSourceLocation(presence: SourcePresence = .present) -> PoundSourceLocationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundSourceLocation,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundSourceLocationKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return PoundSourceLocationSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundSourceLocationArgsSyntax")
  public static func makePoundSourceLocationArgs(_ garbageBeforeFileArgLabel: GarbageNodesSyntax? = nil, fileArgLabel: TokenSyntax, _ garbageBetweenFileArgLabelAndFileArgColon: GarbageNodesSyntax? = nil, fileArgColon: TokenSyntax, _ garbageBetweenFileArgColonAndFileName: GarbageNodesSyntax? = nil, fileName: TokenSyntax, _ garbageBetweenFileNameAndComma: GarbageNodesSyntax? = nil, comma: TokenSyntax, _ garbageBetweenCommaAndLineArgLabel: GarbageNodesSyntax? = nil, lineArgLabel: TokenSyntax, _ garbageBetweenLineArgLabelAndLineArgColon: GarbageNodesSyntax? = nil, lineArgColon: TokenSyntax, _ garbageBetweenLineArgColonAndLineNumber: GarbageNodesSyntax? = nil, lineNumber: TokenSyntax) -> PoundSourceLocationArgsSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeFileArgLabel?.raw,
      fileArgLabel.raw,
      garbageBetweenFileArgLabelAndFileArgColon?.raw,
      fileArgColon.raw,
      garbageBetweenFileArgColonAndFileName?.raw,
      fileName.raw,
      garbageBetweenFileNameAndComma?.raw,
      comma.raw,
      garbageBetweenCommaAndLineArgLabel?.raw,
      lineArgLabel.raw,
      garbageBetweenLineArgLabelAndLineArgColon?.raw,
      lineArgColon.raw,
      garbageBetweenLineArgColonAndLineNumber?.raw,
      lineNumber.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundSourceLocationArgs,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundSourceLocationArgsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundSourceLocationArgsSyntax")
  public static func makeBlankPoundSourceLocationArgs(presence: SourcePresence = .present) -> PoundSourceLocationArgsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundSourceLocationArgs,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missingToken(TokenKind.stringLiteral("")),
      nil,
      RawSyntax.missingToken(TokenKind.comma),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
    ], length: .zero, presence: presence))
    return PoundSourceLocationArgsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclModifierDetailSyntax")
  public static func makeDeclModifierDetail(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndDetail: GarbageNodesSyntax? = nil, detail: TokenSyntax, _ garbageBetweenDetailAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> DeclModifierDetailSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndDetail?.raw,
      detail.raw,
      garbageBetweenDetailAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declModifierDetail,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclModifierDetailSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclModifierDetailSyntax")
  public static func makeBlankDeclModifierDetail(presence: SourcePresence = .present) -> DeclModifierDetailSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declModifierDetail,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return DeclModifierDetailSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclModifierSyntax")
  public static func makeDeclModifier(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndDetail: GarbageNodesSyntax? = nil, detail: DeclModifierDetailSyntax?) -> DeclModifierSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndDetail?.raw,
      detail?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declModifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclModifierSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclModifierSyntax")
  public static func makeBlankDeclModifier(presence: SourcePresence = .present) -> DeclModifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declModifier,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DeclModifierSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InheritedTypeSyntax")
  public static func makeInheritedType(_ garbageBeforeTypeName: GarbageNodesSyntax? = nil, typeName: TypeSyntax, _ garbageBetweenTypeNameAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> InheritedTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeTypeName?.raw,
      typeName.raw,
      garbageBetweenTypeNameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.inheritedType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InheritedTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InheritedTypeSyntax")
  public static func makeBlankInheritedType(presence: SourcePresence = .present) -> InheritedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .inheritedType,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return InheritedTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InheritedTypeListSyntax")
  public static func makeInheritedTypeList(
    _ elements: [InheritedTypeSyntax]) -> InheritedTypeListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.inheritedTypeList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InheritedTypeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InheritedTypeListSyntax")
  public static func makeBlankInheritedTypeList(presence: SourcePresence = .present) -> InheritedTypeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .inheritedTypeList,
      layout: [
    ], length: .zero, presence: presence))
    return InheritedTypeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypeInheritanceClauseSyntax")
  public static func makeTypeInheritanceClause(_ garbageBeforeColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndInheritedTypeCollection: GarbageNodesSyntax? = nil, inheritedTypeCollection: InheritedTypeListSyntax) -> TypeInheritanceClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeColon?.raw,
      colon.raw,
      garbageBetweenColonAndInheritedTypeCollection?.raw,
      inheritedTypeCollection.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeInheritanceClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypeInheritanceClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypeInheritanceClauseSyntax")
  public static func makeBlankTypeInheritanceClause(presence: SourcePresence = .present) -> TypeInheritanceClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typeInheritanceClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.inheritedTypeList),
    ], length: .zero, presence: presence))
    return TypeInheritanceClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClassDeclSyntax")
  public static func makeClassDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndClassKeyword: GarbageNodesSyntax? = nil, classKeyword: TokenSyntax, _ garbageBetweenClassKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> ClassDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndClassKeyword?.raw,
      classKeyword.raw,
      garbageBetweenClassKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.classDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClassDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClassDeclSyntax")
  public static func makeBlankClassDecl(presence: SourcePresence = .present) -> ClassDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .classDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.classKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return ClassDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ActorDeclSyntax")
  public static func makeActorDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndActorKeyword: GarbageNodesSyntax? = nil, actorKeyword: TokenSyntax, _ garbageBetweenActorKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> ActorDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndActorKeyword?.raw,
      actorKeyword.raw,
      garbageBetweenActorKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.actorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ActorDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ActorDeclSyntax")
  public static func makeBlankActorDecl(presence: SourcePresence = .present) -> ActorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .actorDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.contextualKeyword("")),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return ActorDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on StructDeclSyntax")
  public static func makeStructDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndStructKeyword: GarbageNodesSyntax? = nil, structKeyword: TokenSyntax, _ garbageBetweenStructKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ garbageBetweenGenericParameterClauseAndInheritanceClause: GarbageNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> StructDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndStructKeyword?.raw,
      structKeyword.raw,
      garbageBetweenStructKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.structDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return StructDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on StructDeclSyntax")
  public static func makeBlankStructDecl(presence: SourcePresence = .present) -> StructDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .structDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.structKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return StructDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ProtocolDeclSyntax")
  public static func makeProtocolDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndProtocolKeyword: GarbageNodesSyntax? = nil, protocolKeyword: TokenSyntax, _ garbageBetweenProtocolKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndPrimaryAssociatedTypeClause: GarbageNodesSyntax? = nil, primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax?, _ garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: GarbageNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> ProtocolDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndProtocolKeyword?.raw,
      protocolKeyword.raw,
      garbageBetweenProtocolKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndPrimaryAssociatedTypeClause?.raw,
      primaryAssociatedTypeClause?.raw,
      garbageBetweenPrimaryAssociatedTypeClauseAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.protocolDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ProtocolDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ProtocolDeclSyntax")
  public static func makeBlankProtocolDecl(presence: SourcePresence = .present) -> ProtocolDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .protocolDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.protocolKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return ProtocolDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExtensionDeclSyntax")
  public static func makeExtensionDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndExtensionKeyword: GarbageNodesSyntax? = nil, extensionKeyword: TokenSyntax, _ garbageBetweenExtensionKeywordAndExtendedType: GarbageNodesSyntax? = nil, extendedType: TypeSyntax, _ garbageBetweenExtendedTypeAndInheritanceClause: GarbageNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> ExtensionDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndExtensionKeyword?.raw,
      extensionKeyword.raw,
      garbageBetweenExtensionKeywordAndExtendedType?.raw,
      extendedType.raw,
      garbageBetweenExtendedTypeAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.extensionDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExtensionDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExtensionDeclSyntax")
  public static func makeBlankExtensionDecl(presence: SourcePresence = .present) -> ExtensionDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .extensionDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.extensionKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return ExtensionDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclBlockSyntax")
  public static func makeMemberDeclBlock(_ garbageBeforeLeftBrace: GarbageNodesSyntax? = nil, leftBrace: TokenSyntax, _ garbageBetweenLeftBraceAndMembers: GarbageNodesSyntax? = nil, members: MemberDeclListSyntax, _ garbageBetweenMembersAndRightBrace: GarbageNodesSyntax? = nil, rightBrace: TokenSyntax) -> MemberDeclBlockSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndMembers?.raw,
      members.raw,
      garbageBetweenMembersAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberDeclBlock,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclBlockSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclBlockSyntax")
  public static func makeBlankMemberDeclBlock(presence: SourcePresence = .present) -> MemberDeclBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberDeclBlock,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftBrace),
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclList),
      nil,
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return MemberDeclBlockSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclListSyntax")
  public static func makeMemberDeclList(
    _ elements: [MemberDeclListItemSyntax]) -> MemberDeclListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberDeclList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclListSyntax")
  public static func makeBlankMemberDeclList(presence: SourcePresence = .present) -> MemberDeclListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberDeclList,
      layout: [
    ], length: .zero, presence: presence))
    return MemberDeclListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclListItemSyntax")
  public static func makeMemberDeclListItem(_ garbageBeforeDecl: GarbageNodesSyntax? = nil, decl: DeclSyntax, _ garbageBetweenDeclAndSemicolon: GarbageNodesSyntax? = nil, semicolon: TokenSyntax?) -> MemberDeclListItemSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeDecl?.raw,
      decl.raw,
      garbageBetweenDeclAndSemicolon?.raw,
      semicolon?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberDeclListItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclListItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclListItemSyntax")
  public static func makeBlankMemberDeclListItem(presence: SourcePresence = .present) -> MemberDeclListItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberDeclListItem,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingDecl),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return MemberDeclListItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SourceFileSyntax")
  public static func makeSourceFile(_ garbageBeforeStatements: GarbageNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ garbageBetweenStatementsAndEOFToken: GarbageNodesSyntax? = nil, eofToken: TokenSyntax) -> SourceFileSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeStatements?.raw,
      statements.raw,
      garbageBetweenStatementsAndEOFToken?.raw,
      eofToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.sourceFile,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SourceFileSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SourceFileSyntax")
  public static func makeBlankSourceFile(presence: SourcePresence = .present) -> SourceFileSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .sourceFile,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
    ], length: .zero, presence: presence))
    return SourceFileSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InitializerClauseSyntax")
  public static func makeInitializerClause(_ garbageBeforeEqual: GarbageNodesSyntax? = nil, equal: TokenSyntax, _ garbageBetweenEqualAndValue: GarbageNodesSyntax? = nil, value: ExprSyntax) -> InitializerClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeEqual?.raw,
      equal.raw,
      garbageBetweenEqualAndValue?.raw,
      value.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.initializerClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InitializerClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InitializerClauseSyntax")
  public static func makeBlankInitializerClause(presence: SourcePresence = .present) -> InitializerClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .initializerClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.equal),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return InitializerClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionParameterSyntax")
  public static func makeFunctionParameter(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndFirstName: GarbageNodesSyntax? = nil, firstName: TokenSyntax?, _ garbageBetweenFirstNameAndSecondName: GarbageNodesSyntax? = nil, secondName: TokenSyntax?, _ garbageBetweenSecondNameAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax?, _ garbageBetweenColonAndType: GarbageNodesSyntax? = nil, type: TypeSyntax?, _ garbageBetweenTypeAndEllipsis: GarbageNodesSyntax? = nil, ellipsis: TokenSyntax?, _ garbageBetweenEllipsisAndDefaultArgument: GarbageNodesSyntax? = nil, defaultArgument: InitializerClauseSyntax?, _ garbageBetweenDefaultArgumentAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> FunctionParameterSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndFirstName?.raw,
      firstName?.raw,
      garbageBetweenFirstNameAndSecondName?.raw,
      secondName?.raw,
      garbageBetweenSecondNameAndColon?.raw,
      colon?.raw,
      garbageBetweenColonAndType?.raw,
      type?.raw,
      garbageBetweenTypeAndEllipsis?.raw,
      ellipsis?.raw,
      garbageBetweenEllipsisAndDefaultArgument?.raw,
      defaultArgument?.raw,
      garbageBetweenDefaultArgumentAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionParameter,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionParameterSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionParameterSyntax")
  public static func makeBlankFunctionParameter(presence: SourcePresence = .present) -> FunctionParameterSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionParameter,
      layout: [
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
    ], length: .zero, presence: presence))
    return FunctionParameterSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ModifierListSyntax")
  public static func makeModifierList(
    _ elements: [DeclModifierSyntax]) -> ModifierListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.modifierList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ModifierListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ModifierListSyntax")
  public static func makeBlankModifierList(presence: SourcePresence = .present) -> ModifierListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .modifierList,
      layout: [
    ], length: .zero, presence: presence))
    return ModifierListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionDeclSyntax")
  public static func makeFunctionDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndFuncKeyword: GarbageNodesSyntax? = nil, funcKeyword: TokenSyntax, _ garbageBetweenFuncKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndGenericParameterClause: GarbageNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ garbageBetweenGenericParameterClauseAndSignature: GarbageNodesSyntax? = nil, signature: FunctionSignatureSyntax, _ garbageBetweenSignatureAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndFuncKeyword?.raw,
      funcKeyword.raw,
      garbageBetweenFuncKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      garbageBetweenSignatureAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionDeclSyntax")
  public static func makeBlankFunctionDecl(presence: SourcePresence = .present) -> FunctionDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.funcKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.functionSignature),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return FunctionDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on InitializerDeclSyntax")
  public static func makeInitializerDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndInitKeyword: GarbageNodesSyntax? = nil, initKeyword: TokenSyntax, _ garbageBetweenInitKeywordAndOptionalMark: GarbageNodesSyntax? = nil, optionalMark: TokenSyntax?, _ garbageBetweenOptionalMarkAndGenericParameterClause: GarbageNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ garbageBetweenGenericParameterClauseAndSignature: GarbageNodesSyntax? = nil, signature: FunctionSignatureSyntax, _ garbageBetweenSignatureAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax?) -> InitializerDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndInitKeyword?.raw,
      initKeyword.raw,
      garbageBetweenInitKeywordAndOptionalMark?.raw,
      optionalMark?.raw,
      garbageBetweenOptionalMarkAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      garbageBetweenSignatureAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.initializerDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InitializerDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on InitializerDeclSyntax")
  public static func makeBlankInitializerDecl(presence: SourcePresence = .present) -> InitializerDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .initializerDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.initKeyword),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.functionSignature),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return InitializerDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeinitializerDeclSyntax")
  public static func makeDeinitializerDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndDeinitKeyword: GarbageNodesSyntax? = nil, deinitKeyword: TokenSyntax, _ garbageBetweenDeinitKeywordAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax?) -> DeinitializerDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndDeinitKeyword?.raw,
      deinitKeyword.raw,
      garbageBetweenDeinitKeywordAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.deinitializerDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeinitializerDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeinitializerDeclSyntax")
  public static func makeBlankDeinitializerDecl(presence: SourcePresence = .present) -> DeinitializerDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .deinitializerDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.deinitKeyword),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DeinitializerDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SubscriptDeclSyntax")
  public static func makeSubscriptDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndSubscriptKeyword: GarbageNodesSyntax? = nil, subscriptKeyword: TokenSyntax, _ garbageBetweenSubscriptKeywordAndGenericParameterClause: GarbageNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ garbageBetweenGenericParameterClauseAndIndices: GarbageNodesSyntax? = nil, indices: ParameterClauseSyntax, _ garbageBetweenIndicesAndResult: GarbageNodesSyntax? = nil, result: ReturnClauseSyntax, _ garbageBetweenResultAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndAccessor: GarbageNodesSyntax? = nil, accessor: Syntax?) -> SubscriptDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndSubscriptKeyword?.raw,
      subscriptKeyword.raw,
      garbageBetweenSubscriptKeywordAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      garbageBetweenGenericParameterClauseAndIndices?.raw,
      indices.raw,
      garbageBetweenIndicesAndResult?.raw,
      result.raw,
      garbageBetweenResultAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndAccessor?.raw,
      accessor?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.subscriptDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SubscriptDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SubscriptDeclSyntax")
  public static func makeBlankSubscriptDecl(presence: SourcePresence = .present) -> SubscriptDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .subscriptDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.subscriptKeyword),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.parameterClause),
      nil,
      RawSyntax.missing(SyntaxKind.returnClause),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return SubscriptDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessLevelModifierSyntax")
  public static func makeAccessLevelModifier(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndModifier: GarbageNodesSyntax? = nil, modifier: DeclModifierDetailSyntax?) -> AccessLevelModifierSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndModifier?.raw,
      modifier?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessLevelModifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessLevelModifierSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessLevelModifierSyntax")
  public static func makeBlankAccessLevelModifier(presence: SourcePresence = .present) -> AccessLevelModifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessLevelModifier,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AccessLevelModifierSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessPathComponentSyntax")
  public static func makeAccessPathComponent(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndTrailingDot: GarbageNodesSyntax? = nil, trailingDot: TokenSyntax?) -> AccessPathComponentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndTrailingDot?.raw,
      trailingDot?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessPathComponent,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessPathComponentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessPathComponentSyntax")
  public static func makeBlankAccessPathComponent(presence: SourcePresence = .present) -> AccessPathComponentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessPathComponent,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AccessPathComponentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessPathSyntax")
  public static func makeAccessPath(
    _ elements: [AccessPathComponentSyntax]) -> AccessPathSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessPath,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessPathSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessPathSyntax")
  public static func makeBlankAccessPath(presence: SourcePresence = .present) -> AccessPathSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessPath,
      layout: [
    ], length: .zero, presence: presence))
    return AccessPathSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ImportDeclSyntax")
  public static func makeImportDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndImportTok: GarbageNodesSyntax? = nil, importTok: TokenSyntax, _ garbageBetweenImportTokAndImportKind: GarbageNodesSyntax? = nil, importKind: TokenSyntax?, _ garbageBetweenImportKindAndPath: GarbageNodesSyntax? = nil, path: AccessPathSyntax) -> ImportDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndImportTok?.raw,
      importTok.raw,
      garbageBetweenImportTokAndImportKind?.raw,
      importKind?.raw,
      garbageBetweenImportKindAndPath?.raw,
      path.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.importDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ImportDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ImportDeclSyntax")
  public static func makeBlankImportDecl(presence: SourcePresence = .present) -> ImportDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .importDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.importKeyword),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.accessPath),
    ], length: .zero, presence: presence))
    return ImportDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessorParameterSyntax")
  public static func makeAccessorParameter(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> AccessorParameterSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndName?.raw,
      name.raw,
      garbageBetweenNameAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorParameter,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessorParameterSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessorParameterSyntax")
  public static func makeBlankAccessorParameter(presence: SourcePresence = .present) -> AccessorParameterSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessorParameter,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return AccessorParameterSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessorDeclSyntax")
  public static func makeAccessorDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifier: GarbageNodesSyntax? = nil, modifier: DeclModifierSyntax?, _ garbageBetweenModifierAndAccessorKind: GarbageNodesSyntax? = nil, accessorKind: TokenSyntax, _ garbageBetweenAccessorKindAndParameter: GarbageNodesSyntax? = nil, parameter: AccessorParameterSyntax?, _ garbageBetweenParameterAndAsyncKeyword: GarbageNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ garbageBetweenAsyncKeywordAndThrowsKeyword: GarbageNodesSyntax? = nil, throwsKeyword: TokenSyntax?, _ garbageBetweenThrowsKeywordAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax?) -> AccessorDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifier?.raw,
      modifier?.raw,
      garbageBetweenModifierAndAccessorKind?.raw,
      accessorKind.raw,
      garbageBetweenAccessorKindAndParameter?.raw,
      parameter?.raw,
      garbageBetweenParameterAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      garbageBetweenAsyncKeywordAndThrowsKeyword?.raw,
      throwsKeyword?.raw,
      garbageBetweenThrowsKeywordAndBody?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessorDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessorDeclSyntax")
  public static func makeBlankAccessorDecl(presence: SourcePresence = .present) -> AccessorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessorDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AccessorDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessorListSyntax")
  public static func makeAccessorList(
    _ elements: [AccessorDeclSyntax]) -> AccessorListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessorListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessorListSyntax")
  public static func makeBlankAccessorList(presence: SourcePresence = .present) -> AccessorListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessorList,
      layout: [
    ], length: .zero, presence: presence))
    return AccessorListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AccessorBlockSyntax")
  public static func makeAccessorBlock(_ garbageBeforeLeftBrace: GarbageNodesSyntax? = nil, leftBrace: TokenSyntax, _ garbageBetweenLeftBraceAndAccessors: GarbageNodesSyntax? = nil, accessors: AccessorListSyntax, _ garbageBetweenAccessorsAndRightBrace: GarbageNodesSyntax? = nil, rightBrace: TokenSyntax) -> AccessorBlockSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndAccessors?.raw,
      accessors.raw,
      garbageBetweenAccessorsAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorBlock,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessorBlockSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AccessorBlockSyntax")
  public static func makeBlankAccessorBlock(presence: SourcePresence = .present) -> AccessorBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessorBlock,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftBrace),
      nil,
      RawSyntax.missing(SyntaxKind.accessorList),
      nil,
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return AccessorBlockSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PatternBindingSyntax")
  public static func makePatternBinding(_ garbageBeforePattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax, _ garbageBetweenPatternAndTypeAnnotation: GarbageNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ garbageBetweenTypeAnnotationAndInitializer: GarbageNodesSyntax? = nil, initializer: InitializerClauseSyntax?, _ garbageBetweenInitializerAndAccessor: GarbageNodesSyntax? = nil, accessor: Syntax?, _ garbageBetweenAccessorAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> PatternBindingSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePattern?.raw,
      pattern.raw,
      garbageBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      garbageBetweenTypeAnnotationAndInitializer?.raw,
      initializer?.raw,
      garbageBetweenInitializerAndAccessor?.raw,
      accessor?.raw,
      garbageBetweenAccessorAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.patternBinding,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PatternBindingSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PatternBindingSyntax")
  public static func makeBlankPatternBinding(presence: SourcePresence = .present) -> PatternBindingSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .patternBinding,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return PatternBindingSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PatternBindingListSyntax")
  public static func makePatternBindingList(
    _ elements: [PatternBindingSyntax]) -> PatternBindingListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.patternBindingList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PatternBindingListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PatternBindingListSyntax")
  public static func makeBlankPatternBindingList(presence: SourcePresence = .present) -> PatternBindingListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .patternBindingList,
      layout: [
    ], length: .zero, presence: presence))
    return PatternBindingListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on VariableDeclSyntax")
  public static func makeVariableDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndLetOrVarKeyword: GarbageNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ garbageBetweenLetOrVarKeywordAndBindings: GarbageNodesSyntax? = nil, bindings: PatternBindingListSyntax) -> VariableDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      garbageBetweenLetOrVarKeywordAndBindings?.raw,
      bindings.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.variableDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return VariableDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on VariableDeclSyntax")
  public static func makeBlankVariableDecl(presence: SourcePresence = .present) -> VariableDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .variableDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.letKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.patternBindingList),
    ], length: .zero, presence: presence))
    return VariableDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseElementSyntax")
  public static func makeEnumCaseElement(_ garbageBeforeIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndAssociatedValue: GarbageNodesSyntax? = nil, associatedValue: ParameterClauseSyntax?, _ garbageBetweenAssociatedValueAndRawValue: GarbageNodesSyntax? = nil, rawValue: InitializerClauseSyntax?, _ garbageBetweenRawValueAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> EnumCaseElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndAssociatedValue?.raw,
      associatedValue?.raw,
      garbageBetweenAssociatedValueAndRawValue?.raw,
      rawValue?.raw,
      garbageBetweenRawValueAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCaseElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseElementSyntax")
  public static func makeBlankEnumCaseElement(presence: SourcePresence = .present) -> EnumCaseElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumCaseElement,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return EnumCaseElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseElementListSyntax")
  public static func makeEnumCaseElementList(
    _ elements: [EnumCaseElementSyntax]) -> EnumCaseElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCaseElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseElementListSyntax")
  public static func makeBlankEnumCaseElementList(presence: SourcePresence = .present) -> EnumCaseElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumCaseElementList,
      layout: [
    ], length: .zero, presence: presence))
    return EnumCaseElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseDeclSyntax")
  public static func makeEnumCaseDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndCaseKeyword: GarbageNodesSyntax? = nil, caseKeyword: TokenSyntax, _ garbageBetweenCaseKeywordAndElements: GarbageNodesSyntax? = nil, elements: EnumCaseElementListSyntax) -> EnumCaseDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndCaseKeyword?.raw,
      caseKeyword.raw,
      garbageBetweenCaseKeywordAndElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCaseDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseDeclSyntax")
  public static func makeBlankEnumCaseDecl(presence: SourcePresence = .present) -> EnumCaseDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumCaseDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.caseKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.enumCaseElementList),
    ], length: .zero, presence: presence))
    return EnumCaseDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumDeclSyntax")
  public static func makeEnumDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndEnumKeyword: GarbageNodesSyntax? = nil, enumKeyword: TokenSyntax, _ garbageBetweenEnumKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndGenericParameters: GarbageNodesSyntax? = nil, genericParameters: GenericParameterClauseSyntax?, _ garbageBetweenGenericParametersAndInheritanceClause: GarbageNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ garbageBetweenInheritanceClauseAndGenericWhereClause: GarbageNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ garbageBetweenGenericWhereClauseAndMembers: GarbageNodesSyntax? = nil, members: MemberDeclBlockSyntax) -> EnumDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndEnumKeyword?.raw,
      enumKeyword.raw,
      garbageBetweenEnumKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndGenericParameters?.raw,
      genericParameters?.raw,
      garbageBetweenGenericParametersAndInheritanceClause?.raw,
      inheritanceClause?.raw,
      garbageBetweenInheritanceClauseAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      garbageBetweenGenericWhereClauseAndMembers?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumDeclSyntax")
  public static func makeBlankEnumDecl(presence: SourcePresence = .present) -> EnumDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.enumKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return EnumDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OperatorDeclSyntax")
  public static func makeOperatorDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndOperatorKeyword: GarbageNodesSyntax? = nil, operatorKeyword: TokenSyntax, _ garbageBetweenOperatorKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndOperatorPrecedenceAndTypes: GarbageNodesSyntax? = nil, operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax?) -> OperatorDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndOperatorKeyword?.raw,
      operatorKeyword.raw,
      garbageBetweenOperatorKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndOperatorPrecedenceAndTypes?.raw,
      operatorPrecedenceAndTypes?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.operatorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OperatorDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OperatorDeclSyntax")
  public static func makeBlankOperatorDecl(presence: SourcePresence = .present) -> OperatorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .operatorDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.operatorKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.unspacedBinaryOperator("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return OperatorDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IdentifierListSyntax")
  public static func makeIdentifierList(
    _ elements: [TokenSyntax]) -> IdentifierListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.identifierList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IdentifierListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IdentifierListSyntax")
  public static func makeBlankIdentifierList(presence: SourcePresence = .present) -> IdentifierListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .identifierList,
      layout: [
    ], length: .zero, presence: presence))
    return IdentifierListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OperatorPrecedenceAndTypesSyntax")
  public static func makeOperatorPrecedenceAndTypes(_ garbageBeforeColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes: GarbageNodesSyntax? = nil, precedenceGroupAndDesignatedTypes: IdentifierListSyntax) -> OperatorPrecedenceAndTypesSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeColon?.raw,
      colon.raw,
      garbageBetweenColonAndPrecedenceGroupAndDesignatedTypes?.raw,
      precedenceGroupAndDesignatedTypes.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.operatorPrecedenceAndTypes,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OperatorPrecedenceAndTypesSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OperatorPrecedenceAndTypesSyntax")
  public static func makeBlankOperatorPrecedenceAndTypes(presence: SourcePresence = .present) -> OperatorPrecedenceAndTypesSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .operatorPrecedenceAndTypes,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.identifierList),
    ], length: .zero, presence: presence))
    return OperatorPrecedenceAndTypesSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupDeclSyntax")
  public static func makePrecedenceGroupDecl(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndModifiers: GarbageNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ garbageBetweenModifiersAndPrecedencegroupKeyword: GarbageNodesSyntax? = nil, precedencegroupKeyword: TokenSyntax, _ garbageBetweenPrecedencegroupKeywordAndIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax, _ garbageBetweenIdentifierAndLeftBrace: GarbageNodesSyntax? = nil, leftBrace: TokenSyntax, _ garbageBetweenLeftBraceAndGroupAttributes: GarbageNodesSyntax? = nil, groupAttributes: PrecedenceGroupAttributeListSyntax, _ garbageBetweenGroupAttributesAndRightBrace: GarbageNodesSyntax? = nil, rightBrace: TokenSyntax) -> PrecedenceGroupDeclSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      garbageBetweenModifiersAndPrecedencegroupKeyword?.raw,
      precedencegroupKeyword.raw,
      garbageBetweenPrecedencegroupKeywordAndIdentifier?.raw,
      identifier.raw,
      garbageBetweenIdentifierAndLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndGroupAttributes?.raw,
      groupAttributes.raw,
      garbageBetweenGroupAttributesAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupDeclSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupDeclSyntax")
  public static func makeBlankPrecedenceGroupDecl(presence: SourcePresence = .present) -> PrecedenceGroupDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupDecl,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.precedencegroupKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.leftBrace),
      nil,
      RawSyntax.missing(SyntaxKind.precedenceGroupAttributeList),
      nil,
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return PrecedenceGroupDeclSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAttributeListSyntax")
  public static func makePrecedenceGroupAttributeList(
    _ elements: [Syntax]) -> PrecedenceGroupAttributeListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupAttributeList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAttributeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAttributeListSyntax")
  public static func makeBlankPrecedenceGroupAttributeList(presence: SourcePresence = .present) -> PrecedenceGroupAttributeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupAttributeList,
      layout: [
    ], length: .zero, presence: presence))
    return PrecedenceGroupAttributeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupRelationSyntax")
  public static func makePrecedenceGroupRelation(_ garbageBeforeHigherThanOrLowerThan: GarbageNodesSyntax? = nil, higherThanOrLowerThan: TokenSyntax, _ garbageBetweenHigherThanOrLowerThanAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndOtherNames: GarbageNodesSyntax? = nil, otherNames: PrecedenceGroupNameListSyntax) -> PrecedenceGroupRelationSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeHigherThanOrLowerThan?.raw,
      higherThanOrLowerThan.raw,
      garbageBetweenHigherThanOrLowerThanAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndOtherNames?.raw,
      otherNames.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupRelation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupRelationSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupRelationSyntax")
  public static func makeBlankPrecedenceGroupRelation(presence: SourcePresence = .present) -> PrecedenceGroupRelationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupRelation,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.precedenceGroupNameList),
    ], length: .zero, presence: presence))
    return PrecedenceGroupRelationSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameListSyntax")
  public static func makePrecedenceGroupNameList(
    _ elements: [PrecedenceGroupNameElementSyntax]) -> PrecedenceGroupNameListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupNameList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupNameListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameListSyntax")
  public static func makeBlankPrecedenceGroupNameList(presence: SourcePresence = .present) -> PrecedenceGroupNameListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupNameList,
      layout: [
    ], length: .zero, presence: presence))
    return PrecedenceGroupNameListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameElementSyntax")
  public static func makePrecedenceGroupNameElement(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> PrecedenceGroupNameElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupNameElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupNameElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameElementSyntax")
  public static func makeBlankPrecedenceGroupNameElement(presence: SourcePresence = .present) -> PrecedenceGroupNameElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupNameElement,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return PrecedenceGroupNameElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssignmentSyntax")
  public static func makePrecedenceGroupAssignment(_ garbageBeforeAssignmentKeyword: GarbageNodesSyntax? = nil, assignmentKeyword: TokenSyntax, _ garbageBetweenAssignmentKeywordAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndFlag: GarbageNodesSyntax? = nil, flag: TokenSyntax) -> PrecedenceGroupAssignmentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAssignmentKeyword?.raw,
      assignmentKeyword.raw,
      garbageBetweenAssignmentKeywordAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndFlag?.raw,
      flag.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupAssignment,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAssignmentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssignmentSyntax")
  public static func makeBlankPrecedenceGroupAssignment(presence: SourcePresence = .present) -> PrecedenceGroupAssignmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupAssignment,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missingToken(TokenKind.trueKeyword),
    ], length: .zero, presence: presence))
    return PrecedenceGroupAssignmentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssociativitySyntax")
  public static func makePrecedenceGroupAssociativity(_ garbageBeforeAssociativityKeyword: GarbageNodesSyntax? = nil, associativityKeyword: TokenSyntax, _ garbageBetweenAssociativityKeywordAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndValue: GarbageNodesSyntax? = nil, value: TokenSyntax) -> PrecedenceGroupAssociativitySyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAssociativityKeyword?.raw,
      associativityKeyword.raw,
      garbageBetweenAssociativityKeywordAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndValue?.raw,
      value.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupAssociativity,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAssociativitySyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssociativitySyntax")
  public static func makeBlankPrecedenceGroupAssociativity(presence: SourcePresence = .present) -> PrecedenceGroupAssociativitySyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupAssociativity,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
    ], length: .zero, presence: presence))
    return PrecedenceGroupAssociativitySyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TokenListSyntax")
  public static func makeTokenList(
    _ elements: [TokenSyntax]) -> TokenListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tokenList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TokenListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TokenListSyntax")
  public static func makeBlankTokenList(presence: SourcePresence = .present) -> TokenListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tokenList,
      layout: [
    ], length: .zero, presence: presence))
    return TokenListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on NonEmptyTokenListSyntax")
  public static func makeNonEmptyTokenList(
    _ elements: [TokenSyntax]) -> NonEmptyTokenListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.nonEmptyTokenList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return NonEmptyTokenListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on NonEmptyTokenListSyntax")
  public static func makeBlankNonEmptyTokenList(presence: SourcePresence = .present) -> NonEmptyTokenListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .nonEmptyTokenList,
      layout: [
    ], length: .zero, presence: presence))
    return NonEmptyTokenListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CustomAttributeSyntax")
  public static func makeCustomAttribute(_ garbageBeforeAtSignToken: GarbageNodesSyntax? = nil, atSignToken: TokenSyntax, _ garbageBetweenAtSignTokenAndAttributeName: GarbageNodesSyntax? = nil, attributeName: TypeSyntax, _ garbageBetweenAttributeNameAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax?, _ garbageBetweenLeftParenAndArgumentList: GarbageNodesSyntax? = nil, argumentList: TupleExprElementListSyntax?, _ garbageBetweenArgumentListAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax?) -> CustomAttributeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAtSignToken?.raw,
      atSignToken.raw,
      garbageBetweenAtSignTokenAndAttributeName?.raw,
      attributeName.raw,
      garbageBetweenAttributeNameAndLeftParen?.raw,
      leftParen?.raw,
      garbageBetweenLeftParenAndArgumentList?.raw,
      argumentList?.raw,
      garbageBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.customAttribute,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CustomAttributeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CustomAttributeSyntax")
  public static func makeBlankCustomAttribute(presence: SourcePresence = .present) -> CustomAttributeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .customAttribute,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.atSign),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CustomAttributeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AttributeSyntax")
  public static func makeAttribute(_ garbageBeforeAtSignToken: GarbageNodesSyntax? = nil, atSignToken: TokenSyntax, _ garbageBetweenAtSignTokenAndAttributeName: GarbageNodesSyntax? = nil, attributeName: TokenSyntax, _ garbageBetweenAttributeNameAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax?, _ garbageBetweenLeftParenAndArgument: GarbageNodesSyntax? = nil, argument: Syntax?, _ garbageBetweenArgumentAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax?, _ garbageBetweenRightParenAndTokenList: GarbageNodesSyntax? = nil, tokenList: TokenListSyntax?) -> AttributeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAtSignToken?.raw,
      atSignToken.raw,
      garbageBetweenAtSignTokenAndAttributeName?.raw,
      attributeName.raw,
      garbageBetweenAttributeNameAndLeftParen?.raw,
      leftParen?.raw,
      garbageBetweenLeftParenAndArgument?.raw,
      argument?.raw,
      garbageBetweenArgumentAndRightParen?.raw,
      rightParen?.raw,
      garbageBetweenRightParenAndTokenList?.raw,
      tokenList?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.attribute,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AttributeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AttributeSyntax")
  public static func makeBlankAttribute(presence: SourcePresence = .present) -> AttributeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .attribute,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.atSign),
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AttributeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AttributeListSyntax")
  public static func makeAttributeList(
    _ elements: [Syntax]) -> AttributeListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.attributeList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AttributeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AttributeListSyntax")
  public static func makeBlankAttributeList(presence: SourcePresence = .present) -> AttributeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .attributeList,
      layout: [
    ], length: .zero, presence: presence))
    return AttributeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SpecializeAttributeSpecListSyntax")
  public static func makeSpecializeAttributeSpecList(
    _ elements: [Syntax]) -> SpecializeAttributeSpecListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.specializeAttributeSpecList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SpecializeAttributeSpecListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SpecializeAttributeSpecListSyntax")
  public static func makeBlankSpecializeAttributeSpecList(presence: SourcePresence = .present) -> SpecializeAttributeSpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .specializeAttributeSpecList,
      layout: [
    ], length: .zero, presence: presence))
    return SpecializeAttributeSpecListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityEntrySyntax")
  public static func makeAvailabilityEntry(_ garbageBeforeLabel: GarbageNodesSyntax? = nil, label: TokenSyntax, _ garbageBetweenLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndAvailabilityList: GarbageNodesSyntax? = nil, availabilityList: AvailabilitySpecListSyntax, _ garbageBetweenAvailabilityListAndSemicolon: GarbageNodesSyntax? = nil, semicolon: TokenSyntax) -> AvailabilityEntrySyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLabel?.raw,
      label.raw,
      garbageBetweenLabelAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndAvailabilityList?.raw,
      availabilityList.raw,
      garbageBetweenAvailabilityListAndSemicolon?.raw,
      semicolon.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityEntry,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityEntrySyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityEntrySyntax")
  public static func makeBlankAvailabilityEntry(presence: SourcePresence = .present) -> AvailabilityEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityEntry,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.availabilitySpecList),
      nil,
      RawSyntax.missingToken(TokenKind.semicolon),
    ], length: .zero, presence: presence))
    return AvailabilityEntrySyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on LabeledSpecializeEntrySyntax")
  public static func makeLabeledSpecializeEntry(_ garbageBeforeLabel: GarbageNodesSyntax? = nil, label: TokenSyntax, _ garbageBetweenLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndValue: GarbageNodesSyntax? = nil, value: TokenSyntax, _ garbageBetweenValueAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLabel?.raw,
      label.raw,
      garbageBetweenLabelAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndValue?.raw,
      value.raw,
      garbageBetweenValueAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.labeledSpecializeEntry,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return LabeledSpecializeEntrySyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on LabeledSpecializeEntrySyntax")
  public static func makeBlankLabeledSpecializeEntry(presence: SourcePresence = .present) -> LabeledSpecializeEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .labeledSpecializeEntry,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return LabeledSpecializeEntrySyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TargetFunctionEntrySyntax")
  public static func makeTargetFunctionEntry(_ garbageBeforeLabel: GarbageNodesSyntax? = nil, label: TokenSyntax, _ garbageBetweenLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndDeclname: GarbageNodesSyntax? = nil, declname: DeclNameSyntax, _ garbageBetweenDeclnameAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> TargetFunctionEntrySyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLabel?.raw,
      label.raw,
      garbageBetweenLabelAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndDeclname?.raw,
      declname.raw,
      garbageBetweenDeclnameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.targetFunctionEntry,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TargetFunctionEntrySyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TargetFunctionEntrySyntax")
  public static func makeBlankTargetFunctionEntry(presence: SourcePresence = .present) -> TargetFunctionEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .targetFunctionEntry,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.declName),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return TargetFunctionEntrySyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on NamedAttributeStringArgumentSyntax")
  public static func makeNamedAttributeStringArgument(_ garbageBeforeNameTok: GarbageNodesSyntax? = nil, nameTok: TokenSyntax, _ garbageBetweenNameTokAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndStringOrDeclname: GarbageNodesSyntax? = nil, stringOrDeclname: Syntax) -> NamedAttributeStringArgumentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeNameTok?.raw,
      nameTok.raw,
      garbageBetweenNameTokAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndStringOrDeclname?.raw,
      stringOrDeclname.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.namedAttributeStringArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return NamedAttributeStringArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on NamedAttributeStringArgumentSyntax")
  public static func makeBlankNamedAttributeStringArgument(presence: SourcePresence = .present) -> NamedAttributeStringArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .namedAttributeStringArgument,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return NamedAttributeStringArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclNameSyntax")
  public static func makeDeclName(_ garbageBeforeDeclBaseName: GarbageNodesSyntax? = nil, declBaseName: Syntax, _ garbageBetweenDeclBaseNameAndDeclNameArguments: GarbageNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?) -> DeclNameSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeDeclBaseName?.raw,
      declBaseName.raw,
      garbageBetweenDeclBaseNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declName,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclNameSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclNameSyntax")
  public static func makeBlankDeclName(presence: SourcePresence = .present) -> DeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declName,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DeclNameSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ImplementsAttributeArgumentsSyntax")
  public static func makeImplementsAttributeArguments(_ garbageBeforeType: GarbageNodesSyntax? = nil, type: SimpleTypeIdentifierSyntax, _ garbageBetweenTypeAndComma: GarbageNodesSyntax? = nil, comma: TokenSyntax, _ garbageBetweenCommaAndDeclBaseName: GarbageNodesSyntax? = nil, declBaseName: Syntax, _ garbageBetweenDeclBaseNameAndDeclNameArguments: GarbageNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeType?.raw,
      type.raw,
      garbageBetweenTypeAndComma?.raw,
      comma.raw,
      garbageBetweenCommaAndDeclBaseName?.raw,
      declBaseName.raw,
      garbageBetweenDeclBaseNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.implementsAttributeArguments,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ImplementsAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ImplementsAttributeArgumentsSyntax")
  public static func makeBlankImplementsAttributeArguments(presence: SourcePresence = .present) -> ImplementsAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .implementsAttributeArguments,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.simpleTypeIdentifier),
      nil,
      RawSyntax.missingToken(TokenKind.comma),
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ImplementsAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjCSelectorPieceSyntax")
  public static func makeObjCSelectorPiece(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax?, _ garbageBetweenNameAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax?) -> ObjCSelectorPieceSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name?.raw,
      garbageBetweenNameAndColon?.raw,
      colon?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objCSelectorPiece,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjCSelectorPieceSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjCSelectorPieceSyntax")
  public static func makeBlankObjCSelectorPiece(presence: SourcePresence = .present) -> ObjCSelectorPieceSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objCSelectorPiece,
      layout: [
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ObjCSelectorPieceSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ObjCSelectorSyntax")
  public static func makeObjCSelector(
    _ elements: [ObjCSelectorPieceSyntax]) -> ObjCSelectorSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objCSelector,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjCSelectorSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ObjCSelectorSyntax")
  public static func makeBlankObjCSelector(presence: SourcePresence = .present) -> ObjCSelectorSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objCSelector,
      layout: [
    ], length: .zero, presence: presence))
    return ObjCSelectorSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiableAttributeArgumentsSyntax")
  public static func makeDifferentiableAttributeArguments(_ garbageBeforeDiffKind: GarbageNodesSyntax? = nil, diffKind: TokenSyntax?, _ garbageBetweenDiffKindAndDiffKindComma: GarbageNodesSyntax? = nil, diffKindComma: TokenSyntax?, _ garbageBetweenDiffKindCommaAndDiffParams: GarbageNodesSyntax? = nil, diffParams: DifferentiabilityParamsClauseSyntax?, _ garbageBetweenDiffParamsAndDiffParamsComma: GarbageNodesSyntax? = nil, diffParamsComma: TokenSyntax?, _ garbageBetweenDiffParamsCommaAndWhereClause: GarbageNodesSyntax? = nil, whereClause: GenericWhereClauseSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeDiffKind?.raw,
      diffKind?.raw,
      garbageBetweenDiffKindAndDiffKindComma?.raw,
      diffKindComma?.raw,
      garbageBetweenDiffKindCommaAndDiffParams?.raw,
      diffParams?.raw,
      garbageBetweenDiffParamsAndDiffParamsComma?.raw,
      diffParamsComma?.raw,
      garbageBetweenDiffParamsCommaAndWhereClause?.raw,
      whereClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiableAttributeArguments,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiableAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiableAttributeArgumentsSyntax")
  public static func makeBlankDifferentiableAttributeArguments(presence: SourcePresence = .present) -> DifferentiableAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiableAttributeArguments,
      layout: [
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
    ], length: .zero, presence: presence))
    return DifferentiableAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsClauseSyntax")
  public static func makeDifferentiabilityParamsClause(_ garbageBeforeWrtLabel: GarbageNodesSyntax? = nil, wrtLabel: TokenSyntax, _ garbageBetweenWrtLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndParameters: GarbageNodesSyntax? = nil, parameters: Syntax) -> DifferentiabilityParamsClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeWrtLabel?.raw,
      wrtLabel.raw,
      garbageBetweenWrtLabelAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndParameters?.raw,
      parameters.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiabilityParamsClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamsClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsClauseSyntax")
  public static func makeBlankDifferentiabilityParamsClause(presence: SourcePresence = .present) -> DifferentiabilityParamsClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiabilityParamsClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return DifferentiabilityParamsClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsSyntax")
  public static func makeDifferentiabilityParams(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndDiffParams: GarbageNodesSyntax? = nil, diffParams: DifferentiabilityParamListSyntax, _ garbageBetweenDiffParamsAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> DifferentiabilityParamsSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndDiffParams?.raw,
      diffParams.raw,
      garbageBetweenDiffParamsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiabilityParams,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsSyntax")
  public static func makeBlankDifferentiabilityParams(presence: SourcePresence = .present) -> DifferentiabilityParamsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiabilityParams,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.differentiabilityParamList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return DifferentiabilityParamsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamListSyntax")
  public static func makeDifferentiabilityParamList(
    _ elements: [DifferentiabilityParamSyntax]) -> DifferentiabilityParamListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiabilityParamList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamListSyntax")
  public static func makeBlankDifferentiabilityParamList(presence: SourcePresence = .present) -> DifferentiabilityParamListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiabilityParamList,
      layout: [
    ], length: .zero, presence: presence))
    return DifferentiabilityParamListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamSyntax")
  public static func makeDifferentiabilityParam(_ garbageBeforeParameter: GarbageNodesSyntax? = nil, parameter: Syntax, _ garbageBetweenParameterAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> DifferentiabilityParamSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeParameter?.raw,
      parameter.raw,
      garbageBetweenParameterAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiabilityParam,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamSyntax")
  public static func makeBlankDifferentiabilityParam(presence: SourcePresence = .present) -> DifferentiabilityParamSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiabilityParam,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DifferentiabilityParamSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DerivativeRegistrationAttributeArgumentsSyntax")
  public static func makeDerivativeRegistrationAttributeArguments(_ garbageBeforeOfLabel: GarbageNodesSyntax? = nil, ofLabel: TokenSyntax, _ garbageBetweenOfLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndOriginalDeclName: GarbageNodesSyntax? = nil, originalDeclName: QualifiedDeclNameSyntax, _ garbageBetweenOriginalDeclNameAndPeriod: GarbageNodesSyntax? = nil, period: TokenSyntax?, _ garbageBetweenPeriodAndAccessorKind: GarbageNodesSyntax? = nil, accessorKind: TokenSyntax?, _ garbageBetweenAccessorKindAndComma: GarbageNodesSyntax? = nil, comma: TokenSyntax?, _ garbageBetweenCommaAndDiffParams: GarbageNodesSyntax? = nil, diffParams: DifferentiabilityParamsClauseSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeOfLabel?.raw,
      ofLabel.raw,
      garbageBetweenOfLabelAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndOriginalDeclName?.raw,
      originalDeclName.raw,
      garbageBetweenOriginalDeclNameAndPeriod?.raw,
      period?.raw,
      garbageBetweenPeriodAndAccessorKind?.raw,
      accessorKind?.raw,
      garbageBetweenAccessorKindAndComma?.raw,
      comma?.raw,
      garbageBetweenCommaAndDiffParams?.raw,
      diffParams?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.derivativeRegistrationAttributeArguments,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DerivativeRegistrationAttributeArgumentsSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DerivativeRegistrationAttributeArgumentsSyntax")
  public static func makeBlankDerivativeRegistrationAttributeArguments(presence: SourcePresence = .present) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .derivativeRegistrationAttributeArguments,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.qualifiedDeclName),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DerivativeRegistrationAttributeArgumentsSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on QualifiedDeclNameSyntax")
  public static func makeQualifiedDeclName(_ garbageBeforeBaseType: GarbageNodesSyntax? = nil, baseType: TypeSyntax?, _ garbageBetweenBaseTypeAndDot: GarbageNodesSyntax? = nil, dot: TokenSyntax?, _ garbageBetweenDotAndName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndArguments: GarbageNodesSyntax? = nil, arguments: DeclNameArgumentsSyntax?) -> QualifiedDeclNameSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBaseType?.raw,
      baseType?.raw,
      garbageBetweenBaseTypeAndDot?.raw,
      dot?.raw,
      garbageBetweenDotAndName?.raw,
      name.raw,
      garbageBetweenNameAndArguments?.raw,
      arguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.qualifiedDeclName,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return QualifiedDeclNameSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on QualifiedDeclNameSyntax")
  public static func makeBlankQualifiedDeclName(presence: SourcePresence = .present) -> QualifiedDeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .qualifiedDeclName,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return QualifiedDeclNameSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionDeclNameSyntax")
  public static func makeFunctionDeclName(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: Syntax, _ garbageBetweenNameAndArguments: GarbageNodesSyntax? = nil, arguments: DeclNameArgumentsSyntax?) -> FunctionDeclNameSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndArguments?.raw,
      arguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionDeclName,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionDeclNameSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionDeclNameSyntax")
  public static func makeBlankFunctionDeclName(presence: SourcePresence = .present) -> FunctionDeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionDeclName,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return FunctionDeclNameSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BackDeployAttributeSpecListSyntax")
  public static func makeBackDeployAttributeSpecList(_ garbageBeforeBeforeLabel: GarbageNodesSyntax? = nil, beforeLabel: TokenSyntax, _ garbageBetweenBeforeLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndVersionList: GarbageNodesSyntax? = nil, versionList: BackDeployVersionListSyntax) -> BackDeployAttributeSpecListSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBeforeLabel?.raw,
      beforeLabel.raw,
      garbageBetweenBeforeLabelAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndVersionList?.raw,
      versionList.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.backDeployAttributeSpecList,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BackDeployAttributeSpecListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BackDeployAttributeSpecListSyntax")
  public static func makeBlankBackDeployAttributeSpecList(presence: SourcePresence = .present) -> BackDeployAttributeSpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .backDeployAttributeSpecList,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.backDeployVersionList),
    ], length: .zero, presence: presence))
    return BackDeployAttributeSpecListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BackDeployVersionListSyntax")
  public static func makeBackDeployVersionList(
    _ elements: [BackDeployVersionArgumentSyntax]) -> BackDeployVersionListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.backDeployVersionList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BackDeployVersionListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BackDeployVersionListSyntax")
  public static func makeBlankBackDeployVersionList(presence: SourcePresence = .present) -> BackDeployVersionListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .backDeployVersionList,
      layout: [
    ], length: .zero, presence: presence))
    return BackDeployVersionListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BackDeployVersionArgumentSyntax")
  public static func makeBackDeployVersionArgument(_ garbageBeforeAvailabilityVersionRestriction: GarbageNodesSyntax? = nil, availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax, _ garbageBetweenAvailabilityVersionRestrictionAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> BackDeployVersionArgumentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAvailabilityVersionRestriction?.raw,
      availabilityVersionRestriction.raw,
      garbageBetweenAvailabilityVersionRestrictionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.backDeployVersionArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BackDeployVersionArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BackDeployVersionArgumentSyntax")
  public static func makeBlankBackDeployVersionArgument(presence: SourcePresence = .present) -> BackDeployVersionArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .backDeployVersionArgument,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.availabilityVersionRestriction),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return BackDeployVersionArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on LabeledStmtSyntax")
  public static func makeLabeledStmt(_ garbageBeforeLabelName: GarbageNodesSyntax? = nil, labelName: TokenSyntax, _ garbageBetweenLabelNameAndLabelColon: GarbageNodesSyntax? = nil, labelColon: TokenSyntax, _ garbageBetweenLabelColonAndStatement: GarbageNodesSyntax? = nil, statement: StmtSyntax) -> LabeledStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLabelName?.raw,
      labelName.raw,
      garbageBetweenLabelNameAndLabelColon?.raw,
      labelColon.raw,
      garbageBetweenLabelColonAndStatement?.raw,
      statement.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.labeledStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return LabeledStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on LabeledStmtSyntax")
  public static func makeBlankLabeledStmt(presence: SourcePresence = .present) -> LabeledStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .labeledStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.missingStmt),
    ], length: .zero, presence: presence))
    return LabeledStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ContinueStmtSyntax")
  public static func makeContinueStmt(_ garbageBeforeContinueKeyword: GarbageNodesSyntax? = nil, continueKeyword: TokenSyntax, _ garbageBetweenContinueKeywordAndLabel: GarbageNodesSyntax? = nil, label: TokenSyntax?) -> ContinueStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeContinueKeyword?.raw,
      continueKeyword.raw,
      garbageBetweenContinueKeywordAndLabel?.raw,
      label?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.continueStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ContinueStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ContinueStmtSyntax")
  public static func makeBlankContinueStmt(presence: SourcePresence = .present) -> ContinueStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .continueStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.continueKeyword),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ContinueStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on WhileStmtSyntax")
  public static func makeWhileStmt(_ garbageBeforeWhileKeyword: GarbageNodesSyntax? = nil, whileKeyword: TokenSyntax, _ garbageBetweenWhileKeywordAndConditions: GarbageNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ garbageBetweenConditionsAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax) -> WhileStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeWhileKeyword?.raw,
      whileKeyword.raw,
      garbageBetweenWhileKeywordAndConditions?.raw,
      conditions.raw,
      garbageBetweenConditionsAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.whileStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return WhileStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on WhileStmtSyntax")
  public static func makeBlankWhileStmt(presence: SourcePresence = .present) -> WhileStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .whileStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.whileKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.conditionElementList),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return WhileStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeferStmtSyntax")
  public static func makeDeferStmt(_ garbageBeforeDeferKeyword: GarbageNodesSyntax? = nil, deferKeyword: TokenSyntax, _ garbageBetweenDeferKeywordAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax) -> DeferStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeDeferKeyword?.raw,
      deferKeyword.raw,
      garbageBetweenDeferKeywordAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.deferStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeferStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeferStmtSyntax")
  public static func makeBlankDeferStmt(presence: SourcePresence = .present) -> DeferStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .deferStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.deferKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return DeferStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExpressionStmtSyntax")
  public static func makeExpressionStmt(_ garbageBeforeExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax) -> ExpressionStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.expressionStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExpressionStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExpressionStmtSyntax")
  public static func makeBlankExpressionStmt(presence: SourcePresence = .present) -> ExpressionStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .expressionStmt,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return ExpressionStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseListSyntax")
  public static func makeSwitchCaseList(
    _ elements: [Syntax]) -> SwitchCaseListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchCaseList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseListSyntax")
  public static func makeBlankSwitchCaseList(presence: SourcePresence = .present) -> SwitchCaseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchCaseList,
      layout: [
    ], length: .zero, presence: presence))
    return SwitchCaseListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on RepeatWhileStmtSyntax")
  public static func makeRepeatWhileStmt(_ garbageBeforeRepeatKeyword: GarbageNodesSyntax? = nil, repeatKeyword: TokenSyntax, _ garbageBetweenRepeatKeywordAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax, _ garbageBetweenBodyAndWhileKeyword: GarbageNodesSyntax? = nil, whileKeyword: TokenSyntax, _ garbageBetweenWhileKeywordAndCondition: GarbageNodesSyntax? = nil, condition: ExprSyntax) -> RepeatWhileStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeRepeatKeyword?.raw,
      repeatKeyword.raw,
      garbageBetweenRepeatKeywordAndBody?.raw,
      body.raw,
      garbageBetweenBodyAndWhileKeyword?.raw,
      whileKeyword.raw,
      garbageBetweenWhileKeywordAndCondition?.raw,
      condition.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.repeatWhileStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return RepeatWhileStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on RepeatWhileStmtSyntax")
  public static func makeBlankRepeatWhileStmt(presence: SourcePresence = .present) -> RepeatWhileStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .repeatWhileStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.repeatKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
      nil,
      RawSyntax.missingToken(TokenKind.whileKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return RepeatWhileStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GuardStmtSyntax")
  public static func makeGuardStmt(_ garbageBeforeGuardKeyword: GarbageNodesSyntax? = nil, guardKeyword: TokenSyntax, _ garbageBetweenGuardKeywordAndConditions: GarbageNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ garbageBetweenConditionsAndElseKeyword: GarbageNodesSyntax? = nil, elseKeyword: TokenSyntax, _ garbageBetweenElseKeywordAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax) -> GuardStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeGuardKeyword?.raw,
      guardKeyword.raw,
      garbageBetweenGuardKeywordAndConditions?.raw,
      conditions.raw,
      garbageBetweenConditionsAndElseKeyword?.raw,
      elseKeyword.raw,
      garbageBetweenElseKeywordAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.guardStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GuardStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GuardStmtSyntax")
  public static func makeBlankGuardStmt(presence: SourcePresence = .present) -> GuardStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .guardStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.guardKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.conditionElementList),
      nil,
      RawSyntax.missingToken(TokenKind.elseKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return GuardStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on WhereClauseSyntax")
  public static func makeWhereClause(_ garbageBeforeWhereKeyword: GarbageNodesSyntax? = nil, whereKeyword: TokenSyntax, _ garbageBetweenWhereKeywordAndGuardResult: GarbageNodesSyntax? = nil, guardResult: ExprSyntax) -> WhereClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeWhereKeyword?.raw,
      whereKeyword.raw,
      garbageBetweenWhereKeywordAndGuardResult?.raw,
      guardResult.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.whereClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return WhereClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on WhereClauseSyntax")
  public static func makeBlankWhereClause(presence: SourcePresence = .present) -> WhereClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .whereClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.whereKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return WhereClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ForInStmtSyntax")
  public static func makeForInStmt(_ garbageBeforeForKeyword: GarbageNodesSyntax? = nil, forKeyword: TokenSyntax, _ garbageBetweenForKeywordAndTryKeyword: GarbageNodesSyntax? = nil, tryKeyword: TokenSyntax?, _ garbageBetweenTryKeywordAndAwaitKeyword: GarbageNodesSyntax? = nil, awaitKeyword: TokenSyntax?, _ garbageBetweenAwaitKeywordAndCaseKeyword: GarbageNodesSyntax? = nil, caseKeyword: TokenSyntax?, _ garbageBetweenCaseKeywordAndPattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax, _ garbageBetweenPatternAndTypeAnnotation: GarbageNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ garbageBetweenTypeAnnotationAndInKeyword: GarbageNodesSyntax? = nil, inKeyword: TokenSyntax, _ garbageBetweenInKeywordAndSequenceExpr: GarbageNodesSyntax? = nil, sequenceExpr: ExprSyntax, _ garbageBetweenSequenceExprAndWhereClause: GarbageNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ garbageBetweenWhereClauseAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax) -> ForInStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeForKeyword?.raw,
      forKeyword.raw,
      garbageBetweenForKeywordAndTryKeyword?.raw,
      tryKeyword?.raw,
      garbageBetweenTryKeywordAndAwaitKeyword?.raw,
      awaitKeyword?.raw,
      garbageBetweenAwaitKeywordAndCaseKeyword?.raw,
      caseKeyword?.raw,
      garbageBetweenCaseKeywordAndPattern?.raw,
      pattern.raw,
      garbageBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      garbageBetweenTypeAnnotationAndInKeyword?.raw,
      inKeyword.raw,
      garbageBetweenInKeywordAndSequenceExpr?.raw,
      sequenceExpr.raw,
      garbageBetweenSequenceExprAndWhereClause?.raw,
      whereClause?.raw,
      garbageBetweenWhereClauseAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.forInStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ForInStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ForInStmtSyntax")
  public static func makeBlankForInStmt(presence: SourcePresence = .present) -> ForInStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .forInStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.forKeyword),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.inKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return ForInStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchStmtSyntax")
  public static func makeSwitchStmt(_ garbageBeforeSwitchKeyword: GarbageNodesSyntax? = nil, switchKeyword: TokenSyntax, _ garbageBetweenSwitchKeywordAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax, _ garbageBetweenExpressionAndLeftBrace: GarbageNodesSyntax? = nil, leftBrace: TokenSyntax, _ garbageBetweenLeftBraceAndCases: GarbageNodesSyntax? = nil, cases: SwitchCaseListSyntax, _ garbageBetweenCasesAndRightBrace: GarbageNodesSyntax? = nil, rightBrace: TokenSyntax) -> SwitchStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeSwitchKeyword?.raw,
      switchKeyword.raw,
      garbageBetweenSwitchKeywordAndExpression?.raw,
      expression.raw,
      garbageBetweenExpressionAndLeftBrace?.raw,
      leftBrace.raw,
      garbageBetweenLeftBraceAndCases?.raw,
      cases.raw,
      garbageBetweenCasesAndRightBrace?.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchStmtSyntax")
  public static func makeBlankSwitchStmt(presence: SourcePresence = .present) -> SwitchStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.switchKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      RawSyntax.missingToken(TokenKind.leftBrace),
      nil,
      RawSyntax.missing(SyntaxKind.switchCaseList),
      nil,
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return SwitchStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CatchClauseListSyntax")
  public static func makeCatchClauseList(
    _ elements: [CatchClauseSyntax]) -> CatchClauseListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.catchClauseList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CatchClauseListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CatchClauseListSyntax")
  public static func makeBlankCatchClauseList(presence: SourcePresence = .present) -> CatchClauseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .catchClauseList,
      layout: [
    ], length: .zero, presence: presence))
    return CatchClauseListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DoStmtSyntax")
  public static func makeDoStmt(_ garbageBeforeDoKeyword: GarbageNodesSyntax? = nil, doKeyword: TokenSyntax, _ garbageBetweenDoKeywordAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax, _ garbageBetweenBodyAndCatchClauses: GarbageNodesSyntax? = nil, catchClauses: CatchClauseListSyntax?) -> DoStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeDoKeyword?.raw,
      doKeyword.raw,
      garbageBetweenDoKeywordAndBody?.raw,
      body.raw,
      garbageBetweenBodyAndCatchClauses?.raw,
      catchClauses?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.doStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DoStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DoStmtSyntax")
  public static func makeBlankDoStmt(presence: SourcePresence = .present) -> DoStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .doStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.doKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DoStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ReturnStmtSyntax")
  public static func makeReturnStmt(_ garbageBeforeReturnKeyword: GarbageNodesSyntax? = nil, returnKeyword: TokenSyntax, _ garbageBetweenReturnKeywordAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax?) -> ReturnStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeReturnKeyword?.raw,
      returnKeyword.raw,
      garbageBetweenReturnKeywordAndExpression?.raw,
      expression?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.returnStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ReturnStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ReturnStmtSyntax")
  public static func makeBlankReturnStmt(presence: SourcePresence = .present) -> ReturnStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .returnStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.returnKeyword),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ReturnStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on YieldStmtSyntax")
  public static func makeYieldStmt(_ garbageBeforeYieldKeyword: GarbageNodesSyntax? = nil, yieldKeyword: TokenSyntax, _ garbageBetweenYieldKeywordAndYields: GarbageNodesSyntax? = nil, yields: Syntax) -> YieldStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeYieldKeyword?.raw,
      yieldKeyword.raw,
      garbageBetweenYieldKeywordAndYields?.raw,
      yields.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.yieldStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return YieldStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on YieldStmtSyntax")
  public static func makeBlankYieldStmt(presence: SourcePresence = .present) -> YieldStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .yieldStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.yield),
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return YieldStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on YieldListSyntax")
  public static func makeYieldList(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndElementList: GarbageNodesSyntax? = nil, elementList: ExprListSyntax, _ garbageBetweenElementListAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?, _ garbageBetweenTrailingCommaAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> YieldListSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      garbageBetweenElementListAndTrailingComma?.raw,
      trailingComma?.raw,
      garbageBetweenTrailingCommaAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.yieldList,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return YieldListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on YieldListSyntax")
  public static func makeBlankYieldList(presence: SourcePresence = .present) -> YieldListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .yieldList,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.exprList),
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return YieldListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FallthroughStmtSyntax")
  public static func makeFallthroughStmt(_ garbageBeforeFallthroughKeyword: GarbageNodesSyntax? = nil, fallthroughKeyword: TokenSyntax) -> FallthroughStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeFallthroughKeyword?.raw,
      fallthroughKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.fallthroughStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FallthroughStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FallthroughStmtSyntax")
  public static func makeBlankFallthroughStmt(presence: SourcePresence = .present) -> FallthroughStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .fallthroughStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.fallthroughKeyword),
    ], length: .zero, presence: presence))
    return FallthroughStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on BreakStmtSyntax")
  public static func makeBreakStmt(_ garbageBeforeBreakKeyword: GarbageNodesSyntax? = nil, breakKeyword: TokenSyntax, _ garbageBetweenBreakKeywordAndLabel: GarbageNodesSyntax? = nil, label: TokenSyntax?) -> BreakStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBreakKeyword?.raw,
      breakKeyword.raw,
      garbageBetweenBreakKeywordAndLabel?.raw,
      label?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.breakStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BreakStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on BreakStmtSyntax")
  public static func makeBlankBreakStmt(presence: SourcePresence = .present) -> BreakStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .breakStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.breakKeyword),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return BreakStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CaseItemListSyntax")
  public static func makeCaseItemList(
    _ elements: [CaseItemSyntax]) -> CaseItemListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.caseItemList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CaseItemListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CaseItemListSyntax")
  public static func makeBlankCaseItemList(presence: SourcePresence = .present) -> CaseItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .caseItemList,
      layout: [
    ], length: .zero, presence: presence))
    return CaseItemListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CatchItemListSyntax")
  public static func makeCatchItemList(
    _ elements: [CatchItemSyntax]) -> CatchItemListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.catchItemList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CatchItemListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CatchItemListSyntax")
  public static func makeBlankCatchItemList(presence: SourcePresence = .present) -> CatchItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .catchItemList,
      layout: [
    ], length: .zero, presence: presence))
    return CatchItemListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConditionElementSyntax")
  public static func makeConditionElement(_ garbageBeforeCondition: GarbageNodesSyntax? = nil, condition: Syntax, _ garbageBetweenConditionAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> ConditionElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeCondition?.raw,
      condition.raw,
      garbageBetweenConditionAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.conditionElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ConditionElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConditionElementSyntax")
  public static func makeBlankConditionElement(presence: SourcePresence = .present) -> ConditionElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .conditionElement,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ConditionElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityConditionSyntax")
  public static func makeAvailabilityCondition(_ garbageBeforePoundAvailableKeyword: GarbageNodesSyntax? = nil, poundAvailableKeyword: TokenSyntax, _ garbageBetweenPoundAvailableKeywordAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndAvailabilitySpec: GarbageNodesSyntax? = nil, availabilitySpec: AvailabilitySpecListSyntax, _ garbageBetweenAvailabilitySpecAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> AvailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundAvailableKeyword?.raw,
      poundAvailableKeyword.raw,
      garbageBetweenPoundAvailableKeywordAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndAvailabilitySpec?.raw,
      availabilitySpec.raw,
      garbageBetweenAvailabilitySpecAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityCondition,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityConditionSyntax")
  public static func makeBlankAvailabilityCondition(presence: SourcePresence = .present) -> AvailabilityConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityCondition,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundAvailableKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.availabilitySpecList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return AvailabilityConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MatchingPatternConditionSyntax")
  public static func makeMatchingPatternCondition(_ garbageBeforeCaseKeyword: GarbageNodesSyntax? = nil, caseKeyword: TokenSyntax, _ garbageBetweenCaseKeywordAndPattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax, _ garbageBetweenPatternAndTypeAnnotation: GarbageNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ garbageBetweenTypeAnnotationAndInitializer: GarbageNodesSyntax? = nil, initializer: InitializerClauseSyntax) -> MatchingPatternConditionSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeCaseKeyword?.raw,
      caseKeyword.raw,
      garbageBetweenCaseKeywordAndPattern?.raw,
      pattern.raw,
      garbageBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      garbageBetweenTypeAnnotationAndInitializer?.raw,
      initializer.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.matchingPatternCondition,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MatchingPatternConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MatchingPatternConditionSyntax")
  public static func makeBlankMatchingPatternCondition(presence: SourcePresence = .present) -> MatchingPatternConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .matchingPatternCondition,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.caseKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.initializerClause),
    ], length: .zero, presence: presence))
    return MatchingPatternConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OptionalBindingConditionSyntax")
  public static func makeOptionalBindingCondition(_ garbageBeforeLetOrVarKeyword: GarbageNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ garbageBetweenLetOrVarKeywordAndPattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax, _ garbageBetweenPatternAndTypeAnnotation: GarbageNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ garbageBetweenTypeAnnotationAndInitializer: GarbageNodesSyntax? = nil, initializer: InitializerClauseSyntax?) -> OptionalBindingConditionSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      garbageBetweenLetOrVarKeywordAndPattern?.raw,
      pattern.raw,
      garbageBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      garbageBetweenTypeAnnotationAndInitializer?.raw,
      initializer?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalBindingCondition,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OptionalBindingConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OptionalBindingConditionSyntax")
  public static func makeBlankOptionalBindingCondition(presence: SourcePresence = .present) -> OptionalBindingConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .optionalBindingCondition,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.letKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return OptionalBindingConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on UnavailabilityConditionSyntax")
  public static func makeUnavailabilityCondition(_ garbageBeforePoundUnavailableKeyword: GarbageNodesSyntax? = nil, poundUnavailableKeyword: TokenSyntax, _ garbageBetweenPoundUnavailableKeywordAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndAvailabilitySpec: GarbageNodesSyntax? = nil, availabilitySpec: AvailabilitySpecListSyntax, _ garbageBetweenAvailabilitySpecAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> UnavailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundUnavailableKeyword?.raw,
      poundUnavailableKeyword.raw,
      garbageBetweenPoundUnavailableKeywordAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndAvailabilitySpec?.raw,
      availabilitySpec.raw,
      garbageBetweenAvailabilitySpecAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unavailabilityCondition,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return UnavailabilityConditionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on UnavailabilityConditionSyntax")
  public static func makeBlankUnavailabilityCondition(presence: SourcePresence = .present) -> UnavailabilityConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unavailabilityCondition,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundUnavailableKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.availabilitySpecList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return UnavailabilityConditionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConditionElementListSyntax")
  public static func makeConditionElementList(
    _ elements: [ConditionElementSyntax]) -> ConditionElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.conditionElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ConditionElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConditionElementListSyntax")
  public static func makeBlankConditionElementList(presence: SourcePresence = .present) -> ConditionElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .conditionElementList,
      layout: [
    ], length: .zero, presence: presence))
    return ConditionElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DeclarationStmtSyntax")
  public static func makeDeclarationStmt(_ garbageBeforeDeclaration: GarbageNodesSyntax? = nil, declaration: DeclSyntax) -> DeclarationStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeDeclaration?.raw,
      declaration.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declarationStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclarationStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DeclarationStmtSyntax")
  public static func makeBlankDeclarationStmt(presence: SourcePresence = .present) -> DeclarationStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declarationStmt,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingDecl),
    ], length: .zero, presence: presence))
    return DeclarationStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ThrowStmtSyntax")
  public static func makeThrowStmt(_ garbageBeforeThrowKeyword: GarbageNodesSyntax? = nil, throwKeyword: TokenSyntax, _ garbageBetweenThrowKeywordAndExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax) -> ThrowStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeThrowKeyword?.raw,
      throwKeyword.raw,
      garbageBetweenThrowKeywordAndExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.throwStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ThrowStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ThrowStmtSyntax")
  public static func makeBlankThrowStmt(presence: SourcePresence = .present) -> ThrowStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .throwStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.throwKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return ThrowStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IfStmtSyntax")
  public static func makeIfStmt(_ garbageBeforeIfKeyword: GarbageNodesSyntax? = nil, ifKeyword: TokenSyntax, _ garbageBetweenIfKeywordAndConditions: GarbageNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ garbageBetweenConditionsAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax, _ garbageBetweenBodyAndElseKeyword: GarbageNodesSyntax? = nil, elseKeyword: TokenSyntax?, _ garbageBetweenElseKeywordAndElseBody: GarbageNodesSyntax? = nil, elseBody: Syntax?) -> IfStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIfKeyword?.raw,
      ifKeyword.raw,
      garbageBetweenIfKeywordAndConditions?.raw,
      conditions.raw,
      garbageBetweenConditionsAndBody?.raw,
      body.raw,
      garbageBetweenBodyAndElseKeyword?.raw,
      elseKeyword?.raw,
      garbageBetweenElseKeywordAndElseBody?.raw,
      elseBody?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IfStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IfStmtSyntax")
  public static func makeBlankIfStmt(presence: SourcePresence = .present) -> IfStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ifStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.ifKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.conditionElementList),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return IfStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ElseIfContinuationSyntax")
  public static func makeElseIfContinuation(_ garbageBeforeIfStatement: GarbageNodesSyntax? = nil, ifStatement: IfStmtSyntax) -> ElseIfContinuationSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIfStatement?.raw,
      ifStatement.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.elseIfContinuation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ElseIfContinuationSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ElseIfContinuationSyntax")
  public static func makeBlankElseIfContinuation(presence: SourcePresence = .present) -> ElseIfContinuationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .elseIfContinuation,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.ifStmt),
    ], length: .zero, presence: presence))
    return ElseIfContinuationSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ElseBlockSyntax")
  public static func makeElseBlock(_ garbageBeforeElseKeyword: GarbageNodesSyntax? = nil, elseKeyword: TokenSyntax, _ garbageBetweenElseKeywordAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax) -> ElseBlockSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeElseKeyword?.raw,
      elseKeyword.raw,
      garbageBetweenElseKeywordAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.elseBlock,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ElseBlockSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ElseBlockSyntax")
  public static func makeBlankElseBlock(presence: SourcePresence = .present) -> ElseBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .elseBlock,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.elseKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return ElseBlockSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseSyntax")
  public static func makeSwitchCase(_ garbageBeforeUnknownAttr: GarbageNodesSyntax? = nil, unknownAttr: AttributeSyntax?, _ garbageBetweenUnknownAttrAndLabel: GarbageNodesSyntax? = nil, label: Syntax, _ garbageBetweenLabelAndStatements: GarbageNodesSyntax? = nil, statements: CodeBlockItemListSyntax) -> SwitchCaseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeUnknownAttr?.raw,
      unknownAttr?.raw,
      garbageBetweenUnknownAttrAndLabel?.raw,
      label.raw,
      garbageBetweenLabelAndStatements?.raw,
      statements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchCase,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseSyntax")
  public static func makeBlankSwitchCase(presence: SourcePresence = .present) -> SwitchCaseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchCase,
      layout: [
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
    ], length: .zero, presence: presence))
    return SwitchCaseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchDefaultLabelSyntax")
  public static func makeSwitchDefaultLabel(_ garbageBeforeDefaultKeyword: GarbageNodesSyntax? = nil, defaultKeyword: TokenSyntax, _ garbageBetweenDefaultKeywordAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax) -> SwitchDefaultLabelSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeDefaultKeyword?.raw,
      defaultKeyword.raw,
      garbageBetweenDefaultKeywordAndColon?.raw,
      colon.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchDefaultLabel,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchDefaultLabelSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchDefaultLabelSyntax")
  public static func makeBlankSwitchDefaultLabel(presence: SourcePresence = .present) -> SwitchDefaultLabelSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchDefaultLabel,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.defaultKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
    ], length: .zero, presence: presence))
    return SwitchDefaultLabelSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CaseItemSyntax")
  public static func makeCaseItem(_ garbageBeforePattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax, _ garbageBetweenPatternAndWhereClause: GarbageNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ garbageBetweenWhereClauseAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> CaseItemSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePattern?.raw,
      pattern.raw,
      garbageBetweenPatternAndWhereClause?.raw,
      whereClause?.raw,
      garbageBetweenWhereClauseAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.caseItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CaseItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CaseItemSyntax")
  public static func makeBlankCaseItem(presence: SourcePresence = .present) -> CaseItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .caseItem,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CaseItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CatchItemSyntax")
  public static func makeCatchItem(_ garbageBeforePattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax?, _ garbageBetweenPatternAndWhereClause: GarbageNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ garbageBetweenWhereClauseAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> CatchItemSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePattern?.raw,
      pattern?.raw,
      garbageBetweenPatternAndWhereClause?.raw,
      whereClause?.raw,
      garbageBetweenWhereClauseAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.catchItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CatchItemSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CatchItemSyntax")
  public static func makeBlankCatchItem(presence: SourcePresence = .present) -> CatchItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .catchItem,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CatchItemSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseLabelSyntax")
  public static func makeSwitchCaseLabel(_ garbageBeforeCaseKeyword: GarbageNodesSyntax? = nil, caseKeyword: TokenSyntax, _ garbageBetweenCaseKeywordAndCaseItems: GarbageNodesSyntax? = nil, caseItems: CaseItemListSyntax, _ garbageBetweenCaseItemsAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax) -> SwitchCaseLabelSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeCaseKeyword?.raw,
      caseKeyword.raw,
      garbageBetweenCaseKeywordAndCaseItems?.raw,
      caseItems.raw,
      garbageBetweenCaseItemsAndColon?.raw,
      colon.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchCaseLabel,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseLabelSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseLabelSyntax")
  public static func makeBlankSwitchCaseLabel(presence: SourcePresence = .present) -> SwitchCaseLabelSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchCaseLabel,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.caseKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.caseItemList),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
    ], length: .zero, presence: presence))
    return SwitchCaseLabelSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CatchClauseSyntax")
  public static func makeCatchClause(_ garbageBeforeCatchKeyword: GarbageNodesSyntax? = nil, catchKeyword: TokenSyntax, _ garbageBetweenCatchKeywordAndCatchItems: GarbageNodesSyntax? = nil, catchItems: CatchItemListSyntax?, _ garbageBetweenCatchItemsAndBody: GarbageNodesSyntax? = nil, body: CodeBlockSyntax) -> CatchClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeCatchKeyword?.raw,
      catchKeyword.raw,
      garbageBetweenCatchKeywordAndCatchItems?.raw,
      catchItems?.raw,
      garbageBetweenCatchItemsAndBody?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.catchClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CatchClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CatchClauseSyntax")
  public static func makeBlankCatchClause(presence: SourcePresence = .present) -> CatchClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .catchClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.catchKeyword),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return CatchClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PoundAssertStmtSyntax")
  public static func makePoundAssertStmt(_ garbageBeforePoundAssert: GarbageNodesSyntax? = nil, poundAssert: TokenSyntax, _ garbageBetweenPoundAssertAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndCondition: GarbageNodesSyntax? = nil, condition: ExprSyntax, _ garbageBetweenConditionAndComma: GarbageNodesSyntax? = nil, comma: TokenSyntax?, _ garbageBetweenCommaAndMessage: GarbageNodesSyntax? = nil, message: TokenSyntax?, _ garbageBetweenMessageAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> PoundAssertStmtSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePoundAssert?.raw,
      poundAssert.raw,
      garbageBetweenPoundAssertAndLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndCondition?.raw,
      condition.raw,
      garbageBetweenConditionAndComma?.raw,
      comma?.raw,
      garbageBetweenCommaAndMessage?.raw,
      message?.raw,
      garbageBetweenMessageAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundAssertStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundAssertStmtSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PoundAssertStmtSyntax")
  public static func makeBlankPoundAssertStmt(presence: SourcePresence = .present) -> PoundAssertStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundAssertStmt,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.poundAssertKeyword),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return PoundAssertStmtSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericWhereClauseSyntax")
  public static func makeGenericWhereClause(_ garbageBeforeWhereKeyword: GarbageNodesSyntax? = nil, whereKeyword: TokenSyntax, _ garbageBetweenWhereKeywordAndRequirementList: GarbageNodesSyntax? = nil, requirementList: GenericRequirementListSyntax) -> GenericWhereClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeWhereKeyword?.raw,
      whereKeyword.raw,
      garbageBetweenWhereKeywordAndRequirementList?.raw,
      requirementList.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericWhereClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericWhereClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericWhereClauseSyntax")
  public static func makeBlankGenericWhereClause(presence: SourcePresence = .present) -> GenericWhereClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericWhereClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.whereKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.genericRequirementList),
    ], length: .zero, presence: presence))
    return GenericWhereClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericRequirementListSyntax")
  public static func makeGenericRequirementList(
    _ elements: [GenericRequirementSyntax]) -> GenericRequirementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericRequirementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericRequirementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericRequirementListSyntax")
  public static func makeBlankGenericRequirementList(presence: SourcePresence = .present) -> GenericRequirementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericRequirementList,
      layout: [
    ], length: .zero, presence: presence))
    return GenericRequirementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericRequirementSyntax")
  public static func makeGenericRequirement(_ garbageBeforeBody: GarbageNodesSyntax? = nil, body: Syntax, _ garbageBetweenBodyAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> GenericRequirementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBody?.raw,
      body.raw,
      garbageBetweenBodyAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericRequirement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericRequirementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericRequirementSyntax")
  public static func makeBlankGenericRequirement(presence: SourcePresence = .present) -> GenericRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericRequirement,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return GenericRequirementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SameTypeRequirementSyntax")
  public static func makeSameTypeRequirement(_ garbageBeforeLeftTypeIdentifier: GarbageNodesSyntax? = nil, leftTypeIdentifier: TypeSyntax, _ garbageBetweenLeftTypeIdentifierAndEqualityToken: GarbageNodesSyntax? = nil, equalityToken: TokenSyntax, _ garbageBetweenEqualityTokenAndRightTypeIdentifier: GarbageNodesSyntax? = nil, rightTypeIdentifier: TypeSyntax) -> SameTypeRequirementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftTypeIdentifier?.raw,
      leftTypeIdentifier.raw,
      garbageBetweenLeftTypeIdentifierAndEqualityToken?.raw,
      equalityToken.raw,
      garbageBetweenEqualityTokenAndRightTypeIdentifier?.raw,
      rightTypeIdentifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.sameTypeRequirement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SameTypeRequirementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SameTypeRequirementSyntax")
  public static func makeBlankSameTypeRequirement(presence: SourcePresence = .present) -> SameTypeRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .sameTypeRequirement,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.spacedBinaryOperator("")),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return SameTypeRequirementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on LayoutRequirementSyntax")
  public static func makeLayoutRequirement(_ garbageBeforeTypeIdentifier: GarbageNodesSyntax? = nil, typeIdentifier: TypeSyntax, _ garbageBetweenTypeIdentifierAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndLayoutConstraint: GarbageNodesSyntax? = nil, layoutConstraint: TokenSyntax, _ garbageBetweenLayoutConstraintAndLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax?, _ garbageBetweenLeftParenAndSize: GarbageNodesSyntax? = nil, size: TokenSyntax?, _ garbageBetweenSizeAndComma: GarbageNodesSyntax? = nil, comma: TokenSyntax?, _ garbageBetweenCommaAndAlignment: GarbageNodesSyntax? = nil, alignment: TokenSyntax?, _ garbageBetweenAlignmentAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax?) -> LayoutRequirementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeTypeIdentifier?.raw,
      typeIdentifier.raw,
      garbageBetweenTypeIdentifierAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndLayoutConstraint?.raw,
      layoutConstraint.raw,
      garbageBetweenLayoutConstraintAndLeftParen?.raw,
      leftParen?.raw,
      garbageBetweenLeftParenAndSize?.raw,
      size?.raw,
      garbageBetweenSizeAndComma?.raw,
      comma?.raw,
      garbageBetweenCommaAndAlignment?.raw,
      alignment?.raw,
      garbageBetweenAlignmentAndRightParen?.raw,
      rightParen?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.layoutRequirement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return LayoutRequirementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on LayoutRequirementSyntax")
  public static func makeBlankLayoutRequirement(presence: SourcePresence = .present) -> LayoutRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .layoutRequirement,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
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
    ], length: .zero, presence: presence))
    return LayoutRequirementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterListSyntax")
  public static func makeGenericParameterList(
    _ elements: [GenericParameterSyntax]) -> GenericParameterListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericParameterList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterListSyntax")
  public static func makeBlankGenericParameterList(presence: SourcePresence = .present) -> GenericParameterListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericParameterList,
      layout: [
    ], length: .zero, presence: presence))
    return GenericParameterListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterSyntax")
  public static func makeGenericParameter(_ garbageBeforeAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax?, _ garbageBetweenColonAndInheritedType: GarbageNodesSyntax? = nil, inheritedType: TypeSyntax?, _ garbageBetweenInheritedTypeAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> GenericParameterSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndName?.raw,
      name.raw,
      garbageBetweenNameAndColon?.raw,
      colon?.raw,
      garbageBetweenColonAndInheritedType?.raw,
      inheritedType?.raw,
      garbageBetweenInheritedTypeAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericParameter,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterSyntax")
  public static func makeBlankGenericParameter(presence: SourcePresence = .present) -> GenericParameterSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericParameter,
      layout: [
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return GenericParameterSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeListSyntax")
  public static func makePrimaryAssociatedTypeList(
    _ elements: [PrimaryAssociatedTypeSyntax]) -> PrimaryAssociatedTypeListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.primaryAssociatedTypeList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeListSyntax")
  public static func makeBlankPrimaryAssociatedTypeList(presence: SourcePresence = .present) -> PrimaryAssociatedTypeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .primaryAssociatedTypeList,
      layout: [
    ], length: .zero, presence: presence))
    return PrimaryAssociatedTypeListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeSyntax")
  public static func makePrimaryAssociatedType(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> PrimaryAssociatedTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.primaryAssociatedType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeSyntax")
  public static func makeBlankPrimaryAssociatedType(presence: SourcePresence = .present) -> PrimaryAssociatedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .primaryAssociatedType,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return PrimaryAssociatedTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterClauseSyntax")
  public static func makeGenericParameterClause(_ garbageBeforeLeftAngleBracket: GarbageNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ garbageBetweenLeftAngleBracketAndGenericParameterList: GarbageNodesSyntax? = nil, genericParameterList: GenericParameterListSyntax, _ garbageBetweenGenericParameterListAndRightAngleBracket: GarbageNodesSyntax? = nil, rightAngleBracket: TokenSyntax) -> GenericParameterClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      garbageBetweenLeftAngleBracketAndGenericParameterList?.raw,
      genericParameterList.raw,
      garbageBetweenGenericParameterListAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericParameterClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterClauseSyntax")
  public static func makeBlankGenericParameterClause(presence: SourcePresence = .present) -> GenericParameterClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericParameterClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftAngle),
      nil,
      RawSyntax.missing(SyntaxKind.genericParameterList),
      nil,
      RawSyntax.missingToken(TokenKind.rightAngle),
    ], length: .zero, presence: presence))
    return GenericParameterClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConformanceRequirementSyntax")
  public static func makeConformanceRequirement(_ garbageBeforeLeftTypeIdentifier: GarbageNodesSyntax? = nil, leftTypeIdentifier: TypeSyntax, _ garbageBetweenLeftTypeIdentifierAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndRightTypeIdentifier: GarbageNodesSyntax? = nil, rightTypeIdentifier: TypeSyntax) -> ConformanceRequirementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftTypeIdentifier?.raw,
      leftTypeIdentifier.raw,
      garbageBetweenLeftTypeIdentifierAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndRightTypeIdentifier?.raw,
      rightTypeIdentifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.conformanceRequirement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ConformanceRequirementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConformanceRequirementSyntax")
  public static func makeBlankConformanceRequirement(presence: SourcePresence = .present) -> ConformanceRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .conformanceRequirement,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return ConformanceRequirementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeClauseSyntax")
  public static func makePrimaryAssociatedTypeClause(_ garbageBeforeLeftAngleBracket: GarbageNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: GarbageNodesSyntax? = nil, primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax, _ garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket: GarbageNodesSyntax? = nil, rightAngleBracket: TokenSyntax) -> PrimaryAssociatedTypeClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      garbageBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.raw,
      primaryAssociatedTypeList.raw,
      garbageBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.primaryAssociatedTypeClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeClauseSyntax")
  public static func makeBlankPrimaryAssociatedTypeClause(presence: SourcePresence = .present) -> PrimaryAssociatedTypeClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .primaryAssociatedTypeClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftAngle),
      nil,
      RawSyntax.missing(SyntaxKind.primaryAssociatedTypeList),
      nil,
      RawSyntax.missingToken(TokenKind.rightAngle),
    ], length: .zero, presence: presence))
    return PrimaryAssociatedTypeClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeSimpleTypeIdentifier(_ garbageBeforeName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndGenericArgumentClause: GarbageNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeName?.raw,
      name.raw,
      garbageBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.simpleTypeIdentifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SimpleTypeIdentifierSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeBlankSimpleTypeIdentifier(presence: SourcePresence = .present) -> SimpleTypeIdentifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .simpleTypeIdentifier,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return SimpleTypeIdentifierSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MemberTypeIdentifierSyntax")
  public static func makeMemberTypeIdentifier(_ garbageBeforeBaseType: GarbageNodesSyntax? = nil, baseType: TypeSyntax, _ garbageBetweenBaseTypeAndPeriod: GarbageNodesSyntax? = nil, period: TokenSyntax, _ garbageBetweenPeriodAndName: GarbageNodesSyntax? = nil, name: TokenSyntax, _ garbageBetweenNameAndGenericArgumentClause: GarbageNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBaseType?.raw,
      baseType.raw,
      garbageBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      garbageBetweenPeriodAndName?.raw,
      name.raw,
      garbageBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberTypeIdentifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberTypeIdentifierSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MemberTypeIdentifierSyntax")
  public static func makeBlankMemberTypeIdentifier(presence: SourcePresence = .present) -> MemberTypeIdentifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberTypeIdentifier,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.period),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return MemberTypeIdentifierSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ClassRestrictionTypeSyntax")
  public static func makeClassRestrictionType(_ garbageBeforeClassKeyword: GarbageNodesSyntax? = nil, classKeyword: TokenSyntax) -> ClassRestrictionTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeClassKeyword?.raw,
      classKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.classRestrictionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClassRestrictionTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ClassRestrictionTypeSyntax")
  public static func makeBlankClassRestrictionType(presence: SourcePresence = .present) -> ClassRestrictionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .classRestrictionType,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.classKeyword),
    ], length: .zero, presence: presence))
    return ClassRestrictionTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ArrayTypeSyntax")
  public static func makeArrayType(_ garbageBeforeLeftSquareBracket: GarbageNodesSyntax? = nil, leftSquareBracket: TokenSyntax, _ garbageBetweenLeftSquareBracketAndElementType: GarbageNodesSyntax? = nil, elementType: TypeSyntax, _ garbageBetweenElementTypeAndRightSquareBracket: GarbageNodesSyntax? = nil, rightSquareBracket: TokenSyntax) -> ArrayTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      garbageBetweenLeftSquareBracketAndElementType?.raw,
      elementType.raw,
      garbageBetweenElementTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrayTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ArrayTypeSyntax")
  public static func makeBlankArrayType(presence: SourcePresence = .present) -> ArrayTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrayType,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return ArrayTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on DictionaryTypeSyntax")
  public static func makeDictionaryType(_ garbageBeforeLeftSquareBracket: GarbageNodesSyntax? = nil, leftSquareBracket: TokenSyntax, _ garbageBetweenLeftSquareBracketAndKeyType: GarbageNodesSyntax? = nil, keyType: TypeSyntax, _ garbageBetweenKeyTypeAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndValueType: GarbageNodesSyntax? = nil, valueType: TypeSyntax, _ garbageBetweenValueTypeAndRightSquareBracket: GarbageNodesSyntax? = nil, rightSquareBracket: TokenSyntax) -> DictionaryTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      garbageBetweenLeftSquareBracketAndKeyType?.raw,
      keyType.raw,
      garbageBetweenKeyTypeAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndValueType?.raw,
      valueType.raw,
      garbageBetweenValueTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DictionaryTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on DictionaryTypeSyntax")
  public static func makeBlankDictionaryType(presence: SourcePresence = .present) -> DictionaryTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .dictionaryType,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return DictionaryTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on MetatypeTypeSyntax")
  public static func makeMetatypeType(_ garbageBeforeBaseType: GarbageNodesSyntax? = nil, baseType: TypeSyntax, _ garbageBetweenBaseTypeAndPeriod: GarbageNodesSyntax? = nil, period: TokenSyntax, _ garbageBetweenPeriodAndTypeOrProtocol: GarbageNodesSyntax? = nil, typeOrProtocol: TokenSyntax) -> MetatypeTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeBaseType?.raw,
      baseType.raw,
      garbageBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      garbageBetweenPeriodAndTypeOrProtocol?.raw,
      typeOrProtocol.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.metatypeType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MetatypeTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on MetatypeTypeSyntax")
  public static func makeBlankMetatypeType(presence: SourcePresence = .present) -> MetatypeTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .metatypeType,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.period),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
    ], length: .zero, presence: presence))
    return MetatypeTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OptionalTypeSyntax")
  public static func makeOptionalType(_ garbageBeforeWrappedType: GarbageNodesSyntax? = nil, wrappedType: TypeSyntax, _ garbageBetweenWrappedTypeAndQuestionMark: GarbageNodesSyntax? = nil, questionMark: TokenSyntax) -> OptionalTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeWrappedType?.raw,
      wrappedType.raw,
      garbageBetweenWrappedTypeAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OptionalTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OptionalTypeSyntax")
  public static func makeBlankOptionalType(presence: SourcePresence = .present) -> OptionalTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .optionalType,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
    ], length: .zero, presence: presence))
    return OptionalTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ConstrainedSugarTypeSyntax")
  public static func makeConstrainedSugarType(_ garbageBeforeSomeOrAnySpecifier: GarbageNodesSyntax? = nil, someOrAnySpecifier: TokenSyntax, _ garbageBetweenSomeOrAnySpecifierAndBaseType: GarbageNodesSyntax? = nil, baseType: TypeSyntax) -> ConstrainedSugarTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeSomeOrAnySpecifier?.raw,
      someOrAnySpecifier.raw,
      garbageBetweenSomeOrAnySpecifierAndBaseType?.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.constrainedSugarType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ConstrainedSugarTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ConstrainedSugarTypeSyntax")
  public static func makeBlankConstrainedSugarType(presence: SourcePresence = .present) -> ConstrainedSugarTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .constrainedSugarType,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return ConstrainedSugarTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ImplicitlyUnwrappedOptionalTypeSyntax")
  public static func makeImplicitlyUnwrappedOptionalType(_ garbageBeforeWrappedType: GarbageNodesSyntax? = nil, wrappedType: TypeSyntax, _ garbageBetweenWrappedTypeAndExclamationMark: GarbageNodesSyntax? = nil, exclamationMark: TokenSyntax) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeWrappedType?.raw,
      wrappedType.raw,
      garbageBetweenWrappedTypeAndExclamationMark?.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.implicitlyUnwrappedOptionalType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ImplicitlyUnwrappedOptionalTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ImplicitlyUnwrappedOptionalTypeSyntax")
  public static func makeBlankImplicitlyUnwrappedOptionalType(presence: SourcePresence = .present) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .implicitlyUnwrappedOptionalType,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      RawSyntax.missingToken(TokenKind.exclamationMark),
    ], length: .zero, presence: presence))
    return ImplicitlyUnwrappedOptionalTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeElementSyntax")
  public static func makeCompositionTypeElement(_ garbageBeforeType: GarbageNodesSyntax? = nil, type: TypeSyntax, _ garbageBetweenTypeAndAmpersand: GarbageNodesSyntax? = nil, ampersand: TokenSyntax?) -> CompositionTypeElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeType?.raw,
      type.raw,
      garbageBetweenTypeAndAmpersand?.raw,
      ampersand?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.compositionTypeElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeElementSyntax")
  public static func makeBlankCompositionTypeElement(presence: SourcePresence = .present) -> CompositionTypeElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .compositionTypeElement,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CompositionTypeElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeElementListSyntax")
  public static func makeCompositionTypeElementList(
    _ elements: [CompositionTypeElementSyntax]) -> CompositionTypeElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.compositionTypeElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeElementListSyntax")
  public static func makeBlankCompositionTypeElementList(presence: SourcePresence = .present) -> CompositionTypeElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .compositionTypeElementList,
      layout: [
    ], length: .zero, presence: presence))
    return CompositionTypeElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeSyntax")
  public static func makeCompositionType(_ garbageBeforeElements: GarbageNodesSyntax? = nil, elements: CompositionTypeElementListSyntax) -> CompositionTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeElements?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.compositionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeSyntax")
  public static func makeBlankCompositionType(presence: SourcePresence = .present) -> CompositionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .compositionType,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.compositionTypeElementList),
    ], length: .zero, presence: presence))
    return CompositionTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeElementSyntax")
  public static func makeTupleTypeElement(_ garbageBeforeInOut: GarbageNodesSyntax? = nil, inOut: TokenSyntax?, _ garbageBetweenInOutAndName: GarbageNodesSyntax? = nil, name: TokenSyntax?, _ garbageBetweenNameAndSecondName: GarbageNodesSyntax? = nil, secondName: TokenSyntax?, _ garbageBetweenSecondNameAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax?, _ garbageBetweenColonAndType: GarbageNodesSyntax? = nil, type: TypeSyntax, _ garbageBetweenTypeAndEllipsis: GarbageNodesSyntax? = nil, ellipsis: TokenSyntax?, _ garbageBetweenEllipsisAndInitializer: GarbageNodesSyntax? = nil, initializer: InitializerClauseSyntax?, _ garbageBetweenInitializerAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeInOut?.raw,
      inOut?.raw,
      garbageBetweenInOutAndName?.raw,
      name?.raw,
      garbageBetweenNameAndSecondName?.raw,
      secondName?.raw,
      garbageBetweenSecondNameAndColon?.raw,
      colon?.raw,
      garbageBetweenColonAndType?.raw,
      type.raw,
      garbageBetweenTypeAndEllipsis?.raw,
      ellipsis?.raw,
      garbageBetweenEllipsisAndInitializer?.raw,
      initializer?.raw,
      garbageBetweenInitializerAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleTypeElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeElementSyntax")
  public static func makeBlankTupleTypeElement(presence: SourcePresence = .present) -> TupleTypeElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleTypeElement,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return TupleTypeElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeElementListSyntax")
  public static func makeTupleTypeElementList(
    _ elements: [TupleTypeElementSyntax]) -> TupleTypeElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleTypeElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeElementListSyntax")
  public static func makeBlankTupleTypeElementList(presence: SourcePresence = .present) -> TupleTypeElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleTypeElementList,
      layout: [
    ], length: .zero, presence: presence))
    return TupleTypeElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeTupleType(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndElements: GarbageNodesSyntax? = nil, elements: TupleTypeElementListSyntax, _ garbageBetweenElementsAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> TupleTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndElements?.raw,
      elements.raw,
      garbageBetweenElementsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeBlankTupleType(presence: SourcePresence = .present) -> TupleTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleType,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.tupleTypeElementList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return TupleTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on FunctionTypeSyntax")
  public static func makeFunctionType(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndArguments: GarbageNodesSyntax? = nil, arguments: TupleTypeElementListSyntax, _ garbageBetweenArgumentsAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax, _ garbageBetweenRightParenAndAsyncKeyword: GarbageNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: GarbageNodesSyntax? = nil, throwsOrRethrowsKeyword: TokenSyntax?, _ garbageBetweenThrowsOrRethrowsKeywordAndArrow: GarbageNodesSyntax? = nil, arrow: TokenSyntax, _ garbageBetweenArrowAndReturnType: GarbageNodesSyntax? = nil, returnType: TypeSyntax) -> FunctionTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      garbageBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
      garbageBetweenRightParenAndAsyncKeyword?.raw,
      asyncKeyword?.raw,
      garbageBetweenAsyncKeywordAndThrowsOrRethrowsKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      garbageBetweenThrowsOrRethrowsKeywordAndArrow?.raw,
      arrow.raw,
      garbageBetweenArrowAndReturnType?.raw,
      returnType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on FunctionTypeSyntax")
  public static func makeBlankFunctionType(presence: SourcePresence = .present) -> FunctionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionType,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.tupleTypeElementList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.arrow),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return FunctionTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AttributedTypeSyntax")
  public static func makeAttributedType(_ garbageBeforeSpecifier: GarbageNodesSyntax? = nil, specifier: TokenSyntax?, _ garbageBetweenSpecifierAndAttributes: GarbageNodesSyntax? = nil, attributes: AttributeListSyntax?, _ garbageBetweenAttributesAndBaseType: GarbageNodesSyntax? = nil, baseType: TypeSyntax) -> AttributedTypeSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeSpecifier?.raw,
      specifier?.raw,
      garbageBetweenSpecifierAndAttributes?.raw,
      attributes?.raw,
      garbageBetweenAttributesAndBaseType?.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.attributedType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AttributedTypeSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AttributedTypeSyntax")
  public static func makeBlankAttributedType(presence: SourcePresence = .present) -> AttributedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .attributedType,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return AttributedTypeSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentListSyntax")
  public static func makeGenericArgumentList(
    _ elements: [GenericArgumentSyntax]) -> GenericArgumentListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericArgumentList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentListSyntax")
  public static func makeBlankGenericArgumentList(presence: SourcePresence = .present) -> GenericArgumentListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericArgumentList,
      layout: [
    ], length: .zero, presence: presence))
    return GenericArgumentListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentSyntax")
  public static func makeGenericArgument(_ garbageBeforeArgumentType: GarbageNodesSyntax? = nil, argumentType: TypeSyntax, _ garbageBetweenArgumentTypeAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> GenericArgumentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeArgumentType?.raw,
      argumentType.raw,
      garbageBetweenArgumentTypeAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentSyntax")
  public static func makeBlankGenericArgument(presence: SourcePresence = .present) -> GenericArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericArgument,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return GenericArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentClauseSyntax")
  public static func makeGenericArgumentClause(_ garbageBeforeLeftAngleBracket: GarbageNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ garbageBetweenLeftAngleBracketAndArguments: GarbageNodesSyntax? = nil, arguments: GenericArgumentListSyntax, _ garbageBetweenArgumentsAndRightAngleBracket: GarbageNodesSyntax? = nil, rightAngleBracket: TokenSyntax) -> GenericArgumentClauseSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      garbageBetweenLeftAngleBracketAndArguments?.raw,
      arguments.raw,
      garbageBetweenArgumentsAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericArgumentClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentClauseSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentClauseSyntax")
  public static func makeBlankGenericArgumentClause(presence: SourcePresence = .present) -> GenericArgumentClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericArgumentClause,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftAngle),
      nil,
      RawSyntax.missing(SyntaxKind.genericArgumentList),
      nil,
      RawSyntax.missingToken(TokenKind.rightAngle),
    ], length: .zero, presence: presence))
    return GenericArgumentClauseSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TypeAnnotationSyntax")
  public static func makeTypeAnnotation(_ garbageBeforeColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndType: GarbageNodesSyntax? = nil, type: TypeSyntax) -> TypeAnnotationSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeColon?.raw,
      colon.raw,
      garbageBetweenColonAndType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeAnnotation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypeAnnotationSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TypeAnnotationSyntax")
  public static func makeBlankTypeAnnotation(presence: SourcePresence = .present) -> TypeAnnotationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typeAnnotation,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return TypeAnnotationSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on EnumCasePatternSyntax")
  public static func makeEnumCasePattern(_ garbageBeforeType: GarbageNodesSyntax? = nil, type: TypeSyntax?, _ garbageBetweenTypeAndPeriod: GarbageNodesSyntax? = nil, period: TokenSyntax, _ garbageBetweenPeriodAndCaseName: GarbageNodesSyntax? = nil, caseName: TokenSyntax, _ garbageBetweenCaseNameAndAssociatedTuple: GarbageNodesSyntax? = nil, associatedTuple: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeType?.raw,
      type?.raw,
      garbageBetweenTypeAndPeriod?.raw,
      period.raw,
      garbageBetweenPeriodAndCaseName?.raw,
      caseName.raw,
      garbageBetweenCaseNameAndAssociatedTuple?.raw,
      associatedTuple?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCasePattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumCasePatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on EnumCasePatternSyntax")
  public static func makeBlankEnumCasePattern(presence: SourcePresence = .present) -> EnumCasePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumCasePattern,
      layout: [
      nil,
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.period),
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return EnumCasePatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IsTypePatternSyntax")
  public static func makeIsTypePattern(_ garbageBeforeIsKeyword: GarbageNodesSyntax? = nil, isKeyword: TokenSyntax, _ garbageBetweenIsKeywordAndType: GarbageNodesSyntax? = nil, type: TypeSyntax) -> IsTypePatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIsKeyword?.raw,
      isKeyword.raw,
      garbageBetweenIsKeywordAndType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.isTypePattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IsTypePatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IsTypePatternSyntax")
  public static func makeBlankIsTypePattern(presence: SourcePresence = .present) -> IsTypePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .isTypePattern,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.isKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return IsTypePatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on OptionalPatternSyntax")
  public static func makeOptionalPattern(_ garbageBeforeSubPattern: GarbageNodesSyntax? = nil, subPattern: PatternSyntax, _ garbageBetweenSubPatternAndQuestionMark: GarbageNodesSyntax? = nil, questionMark: TokenSyntax) -> OptionalPatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeSubPattern?.raw,
      subPattern.raw,
      garbageBetweenSubPatternAndQuestionMark?.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OptionalPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on OptionalPatternSyntax")
  public static func makeBlankOptionalPattern(presence: SourcePresence = .present) -> OptionalPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .optionalPattern,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
      nil,
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
    ], length: .zero, presence: presence))
    return OptionalPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on IdentifierPatternSyntax")
  public static func makeIdentifierPattern(_ garbageBeforeIdentifier: GarbageNodesSyntax? = nil, identifier: TokenSyntax) -> IdentifierPatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeIdentifier?.raw,
      identifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.identifierPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IdentifierPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on IdentifierPatternSyntax")
  public static func makeBlankIdentifierPattern(presence: SourcePresence = .present) -> IdentifierPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .identifierPattern,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.selfKeyword),
    ], length: .zero, presence: presence))
    return IdentifierPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AsTypePatternSyntax")
  public static func makeAsTypePattern(_ garbageBeforePattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax, _ garbageBetweenPatternAndAsKeyword: GarbageNodesSyntax? = nil, asKeyword: TokenSyntax, _ garbageBetweenAsKeywordAndType: GarbageNodesSyntax? = nil, type: TypeSyntax) -> AsTypePatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePattern?.raw,
      pattern.raw,
      garbageBetweenPatternAndAsKeyword?.raw,
      asKeyword.raw,
      garbageBetweenAsKeywordAndType?.raw,
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.asTypePattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AsTypePatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AsTypePatternSyntax")
  public static func makeBlankAsTypePattern(presence: SourcePresence = .present) -> AsTypePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .asTypePattern,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
      nil,
      RawSyntax.missingToken(TokenKind.asKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingType),
    ], length: .zero, presence: presence))
    return AsTypePatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternSyntax")
  public static func makeTuplePattern(_ garbageBeforeLeftParen: GarbageNodesSyntax? = nil, leftParen: TokenSyntax, _ garbageBetweenLeftParenAndElements: GarbageNodesSyntax? = nil, elements: TuplePatternElementListSyntax, _ garbageBetweenElementsAndRightParen: GarbageNodesSyntax? = nil, rightParen: TokenSyntax) -> TuplePatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLeftParen?.raw,
      leftParen.raw,
      garbageBetweenLeftParenAndElements?.raw,
      elements.raw,
      garbageBetweenElementsAndRightParen?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tuplePattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternSyntax")
  public static func makeBlankTuplePattern(presence: SourcePresence = .present) -> TuplePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tuplePattern,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missing(SyntaxKind.tuplePatternElementList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return TuplePatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on WildcardPatternSyntax")
  public static func makeWildcardPattern(_ garbageBeforeWildcard: GarbageNodesSyntax? = nil, wildcard: TokenSyntax, _ garbageBetweenWildcardAndTypeAnnotation: GarbageNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeWildcard?.raw,
      wildcard.raw,
      garbageBetweenWildcardAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.wildcardPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return WildcardPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on WildcardPatternSyntax")
  public static func makeBlankWildcardPattern(presence: SourcePresence = .present) -> WildcardPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .wildcardPattern,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.wildcardKeyword),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return WildcardPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternElementSyntax")
  public static func makeTuplePatternElement(_ garbageBeforeLabelName: GarbageNodesSyntax? = nil, labelName: TokenSyntax?, _ garbageBetweenLabelNameAndLabelColon: GarbageNodesSyntax? = nil, labelColon: TokenSyntax?, _ garbageBetweenLabelColonAndPattern: GarbageNodesSyntax? = nil, pattern: PatternSyntax, _ garbageBetweenPatternAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> TuplePatternElementSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLabelName?.raw,
      labelName?.raw,
      garbageBetweenLabelNameAndLabelColon?.raw,
      labelColon?.raw,
      garbageBetweenLabelColonAndPattern?.raw,
      pattern.raw,
      garbageBetweenPatternAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tuplePatternElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternElementSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternElementSyntax")
  public static func makeBlankTuplePatternElement(presence: SourcePresence = .present) -> TuplePatternElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tuplePatternElement,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return TuplePatternElementSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ExpressionPatternSyntax")
  public static func makeExpressionPattern(_ garbageBeforeExpression: GarbageNodesSyntax? = nil, expression: ExprSyntax) -> ExpressionPatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeExpression?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.expressionPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExpressionPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ExpressionPatternSyntax")
  public static func makeBlankExpressionPattern(presence: SourcePresence = .present) -> ExpressionPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .expressionPattern,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.missingExpr),
    ], length: .zero, presence: presence))
    return ExpressionPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternElementListSyntax")
  public static func makeTuplePatternElementList(
    _ elements: [TuplePatternElementSyntax]) -> TuplePatternElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tuplePatternElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternElementListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternElementListSyntax")
  public static func makeBlankTuplePatternElementList(presence: SourcePresence = .present) -> TuplePatternElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tuplePatternElementList,
      layout: [
    ], length: .zero, presence: presence))
    return TuplePatternElementListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on ValueBindingPatternSyntax")
  public static func makeValueBindingPattern(_ garbageBeforeLetOrVarKeyword: GarbageNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ garbageBetweenLetOrVarKeywordAndValuePattern: GarbageNodesSyntax? = nil, valuePattern: PatternSyntax) -> ValueBindingPatternSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      garbageBetweenLetOrVarKeywordAndValuePattern?.raw,
      valuePattern.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.valueBindingPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ValueBindingPatternSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on ValueBindingPatternSyntax")
  public static func makeBlankValueBindingPattern(presence: SourcePresence = .present) -> ValueBindingPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .valueBindingPattern,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.letKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.missingPattern),
    ], length: .zero, presence: presence))
    return ValueBindingPatternSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilitySpecListSyntax")
  public static func makeAvailabilitySpecList(
    _ elements: [AvailabilityArgumentSyntax]) -> AvailabilitySpecListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilitySpecList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilitySpecListSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilitySpecListSyntax")
  public static func makeBlankAvailabilitySpecList(presence: SourcePresence = .present) -> AvailabilitySpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilitySpecList,
      layout: [
    ], length: .zero, presence: presence))
    return AvailabilitySpecListSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityArgumentSyntax")
  public static func makeAvailabilityArgument(_ garbageBeforeEntry: GarbageNodesSyntax? = nil, entry: Syntax, _ garbageBetweenEntryAndTrailingComma: GarbageNodesSyntax? = nil, trailingComma: TokenSyntax?) -> AvailabilityArgumentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeEntry?.raw,
      entry.raw,
      garbageBetweenEntryAndTrailingComma?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityArgumentSyntax")
  public static func makeBlankAvailabilityArgument(presence: SourcePresence = .present) -> AvailabilityArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityArgument,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AvailabilityArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityLabeledArgumentSyntax")
  public static func makeAvailabilityLabeledArgument(_ garbageBeforeLabel: GarbageNodesSyntax? = nil, label: TokenSyntax, _ garbageBetweenLabelAndColon: GarbageNodesSyntax? = nil, colon: TokenSyntax, _ garbageBetweenColonAndValue: GarbageNodesSyntax? = nil, value: Syntax) -> AvailabilityLabeledArgumentSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeLabel?.raw,
      label.raw,
      garbageBetweenLabelAndColon?.raw,
      colon.raw,
      garbageBetweenColonAndValue?.raw,
      value.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityLabeledArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityLabeledArgumentSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityLabeledArgumentSyntax")
  public static func makeBlankAvailabilityLabeledArgument(presence: SourcePresence = .present) -> AvailabilityLabeledArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityLabeledArgument,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missingToken(TokenKind.colon),
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return AvailabilityLabeledArgumentSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityVersionRestrictionSyntax")
  public static func makeAvailabilityVersionRestriction(_ garbageBeforePlatform: GarbageNodesSyntax? = nil, platform: TokenSyntax, _ garbageBetweenPlatformAndVersion: GarbageNodesSyntax? = nil, version: VersionTupleSyntax?) -> AvailabilityVersionRestrictionSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforePlatform?.raw,
      platform.raw,
      garbageBetweenPlatformAndVersion?.raw,
      version?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityVersionRestriction,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityVersionRestrictionSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityVersionRestrictionSyntax")
  public static func makeBlankAvailabilityVersionRestriction(presence: SourcePresence = .present) -> AvailabilityVersionRestrictionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityVersionRestriction,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AvailabilityVersionRestrictionSyntax(data)
  }
  @available(*, deprecated, message: "Use initializer on VersionTupleSyntax")
  public static func makeVersionTuple(_ garbageBeforeMajorMinor: GarbageNodesSyntax? = nil, majorMinor: Syntax, _ garbageBetweenMajorMinorAndPatchPeriod: GarbageNodesSyntax? = nil, patchPeriod: TokenSyntax?, _ garbageBetweenPatchPeriodAndPatchVersion: GarbageNodesSyntax? = nil, patchVersion: TokenSyntax?) -> VersionTupleSyntax {
    let layout: [RawSyntax?] = [
      garbageBeforeMajorMinor?.raw,
      majorMinor.raw,
      garbageBetweenMajorMinorAndPatchPeriod?.raw,
      patchPeriod?.raw,
      garbageBetweenPatchPeriodAndPatchVersion?.raw,
      patchVersion?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.versionTuple,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return VersionTupleSyntax(data)
  }

  @available(*, deprecated, message: "Use initializer on VersionTupleSyntax")
  public static func makeBlankVersionTuple(presence: SourcePresence = .present) -> VersionTupleSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .versionTuple,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
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
