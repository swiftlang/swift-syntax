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
    TokenSyntax(
      kind,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia,
      presence: presence)
  }

/// MARK: Syntax Node Creation APIs







  @available(*, deprecated, message: "Use initializer on MissingSyntax")
  public static func makeBlankMissing(presence: SourcePresence = .missing) -> MissingSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missing,
        from: [
      ], arena: arena))
      return MissingSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MissingDeclSyntax")
  public static func makeMissingDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedAfterModifiers: UnexpectedNodesSyntax? = nil) -> MissingDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedAfterModifiers?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.missingDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MissingDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MissingDeclSyntax")
  public static func makeBlankMissingDecl(presence: SourcePresence = .missing) -> MissingDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return MissingDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MissingExprSyntax")
  public static func makeBlankMissingExpr(presence: SourcePresence = .missing) -> MissingExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingExpr,
        from: [
      ], arena: arena))
      return MissingExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MissingStmtSyntax")
  public static func makeBlankMissingStmt(presence: SourcePresence = .missing) -> MissingStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingStmt,
        from: [
      ], arena: arena))
      return MissingStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MissingTypeSyntax")
  public static func makeBlankMissingType(presence: SourcePresence = .missing) -> MissingTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingType,
        from: [
      ], arena: arena))
      return MissingTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MissingPatternSyntax")
  public static func makeBlankMissingPattern(presence: SourcePresence = .missing) -> MissingPatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .missingPattern,
        from: [
      ], arena: arena))
      return MissingPatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockItemSyntax")
  public static func makeCodeBlockItem(_ unexpectedBeforeItem: UnexpectedNodesSyntax? = nil, item: Syntax, _ unexpectedBetweenItemAndSemicolon: UnexpectedNodesSyntax? = nil, semicolon: TokenSyntax?, _ unexpectedBetweenSemicolonAndErrorTokens: UnexpectedNodesSyntax? = nil, errorTokens: Syntax?, _ unexpectedAfterErrorTokens: UnexpectedNodesSyntax? = nil) -> CodeBlockItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeItem?.raw,
      item.raw,
      unexpectedBetweenItemAndSemicolon?.raw,
      semicolon?.raw,
      unexpectedBetweenSemicolonAndErrorTokens?.raw,
      errorTokens?.raw,
      unexpectedAfterErrorTokens?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItem,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CodeBlockItemSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockItemSyntax")
  public static func makeBlankCodeBlockItem(presence: SourcePresence = .present) -> CodeBlockItemSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .codeBlockItem,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return CodeBlockItemSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockItemListSyntax")
  public static func makeCodeBlockItemList(
    _ elements: [CodeBlockItemSyntax]) -> CodeBlockItemListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlockItemList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CodeBlockItemListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockItemListSyntax")
  public static func makeBlankCodeBlockItemList(presence: SourcePresence = .present) -> CodeBlockItemListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .codeBlockItemList,
        from: [
      ], arena: arena))
      return CodeBlockItemListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CodeBlockSyntax")
  public static func makeCodeBlock(_ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndStatements: UnexpectedNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax, _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil) -> CodeBlockSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
      unexpectedAfterRightBrace?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.codeBlock,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CodeBlockSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CodeBlockSyntax")
  public static func makeBlankCodeBlock(presence: SourcePresence = .present) -> CodeBlockSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .codeBlock,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: arena),
        nil,
      ], arena: arena))
      return CodeBlockSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on UnexpectedNodesSyntax")
  public static func makeUnexpectedNodes(
    _ elements: [Syntax]) -> UnexpectedNodesSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.unexpectedNodes,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return UnexpectedNodesSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on UnexpectedNodesSyntax")
  public static func makeBlankUnexpectedNodes(presence: SourcePresence = .present) -> UnexpectedNodesSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unexpectedNodes,
        from: [
      ], arena: arena))
      return UnexpectedNodesSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on InOutExprSyntax")
  public static func makeInOutExpr(_ unexpectedBeforeAmpersand: UnexpectedNodesSyntax? = nil, ampersand: TokenSyntax, _ unexpectedBetweenAmpersandAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil) -> InOutExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAmpersand?.raw,
      ampersand.raw,
      unexpectedBetweenAmpersandAndExpression?.raw,
      expression.raw,
      unexpectedAfterExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.inOutExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return InOutExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on InOutExprSyntax")
  public static func makeBlankInOutExpr(presence: SourcePresence = .present) -> InOutExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .inOutExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.prefixAmpersand, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return InOutExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PoundColumnExprSyntax")
  public static func makePoundColumnExpr(_ unexpectedBeforePoundColumn: UnexpectedNodesSyntax? = nil, poundColumn: TokenSyntax, _ unexpectedAfterPoundColumn: UnexpectedNodesSyntax? = nil) -> PoundColumnExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundColumn?.raw,
      poundColumn.raw,
      unexpectedAfterPoundColumn?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundColumnExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PoundColumnExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PoundColumnExprSyntax")
  public static func makeBlankPoundColumnExpr(presence: SourcePresence = .present) -> PoundColumnExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundColumnExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundColumnKeyword, arena: arena),
        nil,
      ], arena: arena))
      return PoundColumnExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TupleExprElementListSyntax")
  public static func makeTupleExprElementList(
    _ elements: [TupleExprElementSyntax]) -> TupleExprElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TupleExprElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TupleExprElementListSyntax")
  public static func makeBlankTupleExprElementList(presence: SourcePresence = .present) -> TupleExprElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleExprElementList,
        from: [
      ], arena: arena))
      return TupleExprElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ArrayElementListSyntax")
  public static func makeArrayElementList(
    _ elements: [ArrayElementSyntax]) -> ArrayElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ArrayElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ArrayElementListSyntax")
  public static func makeBlankArrayElementList(presence: SourcePresence = .present) -> ArrayElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrayElementList,
        from: [
      ], arena: arena))
      return ArrayElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DictionaryElementListSyntax")
  public static func makeDictionaryElementList(
    _ elements: [DictionaryElementSyntax]) -> DictionaryElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DictionaryElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DictionaryElementListSyntax")
  public static func makeBlankDictionaryElementList(presence: SourcePresence = .present) -> DictionaryElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .dictionaryElementList,
        from: [
      ], arena: arena))
      return DictionaryElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on StringLiteralSegmentsSyntax")
  public static func makeStringLiteralSegments(
    _ elements: [Syntax]) -> StringLiteralSegmentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringLiteralSegments,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return StringLiteralSegmentsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on StringLiteralSegmentsSyntax")
  public static func makeBlankStringLiteralSegments(presence: SourcePresence = .present) -> StringLiteralSegmentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .stringLiteralSegments,
        from: [
      ], arena: arena))
      return StringLiteralSegmentsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TryExprSyntax")
  public static func makeTryExpr(_ unexpectedBeforeTryKeyword: UnexpectedNodesSyntax? = nil, tryKeyword: TokenSyntax, _ unexpectedBetweenTryKeywordAndQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax?, _ unexpectedBetweenQuestionOrExclamationMarkAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil) -> TryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeTryKeyword?.raw,
      tryKeyword.raw,
      unexpectedBetweenTryKeywordAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      unexpectedBetweenQuestionOrExclamationMarkAndExpression?.raw,
      expression.raw,
      unexpectedAfterExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tryExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TryExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TryExprSyntax")
  public static func makeBlankTryExpr(presence: SourcePresence = .present) -> TryExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tryExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.tryKeyword, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return TryExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AwaitExprSyntax")
  public static func makeAwaitExpr(_ unexpectedBeforeAwaitKeyword: UnexpectedNodesSyntax? = nil, awaitKeyword: TokenSyntax, _ unexpectedBetweenAwaitKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil) -> AwaitExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAwaitKeyword?.raw,
      awaitKeyword.raw,
      unexpectedBetweenAwaitKeywordAndExpression?.raw,
      expression.raw,
      unexpectedAfterExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.awaitExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AwaitExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AwaitExprSyntax")
  public static func makeBlankAwaitExpr(presence: SourcePresence = .present) -> AwaitExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .awaitExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return AwaitExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MoveExprSyntax")
  public static func makeMoveExpr(_ unexpectedBeforeMoveKeyword: UnexpectedNodesSyntax? = nil, moveKeyword: TokenSyntax, _ unexpectedBetweenMoveKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil) -> MoveExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMoveKeyword?.raw,
      moveKeyword.raw,
      unexpectedBetweenMoveKeywordAndExpression?.raw,
      expression.raw,
      unexpectedAfterExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.moveExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MoveExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MoveExprSyntax")
  public static func makeBlankMoveExpr(presence: SourcePresence = .present) -> MoveExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .moveExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return MoveExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentSyntax")
  public static func makeDeclNameArgument(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil) -> DeclNameArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndColon?.raw,
      colon.raw,
      unexpectedAfterColon?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArgument,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeclNameArgumentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentSyntax")
  public static func makeBlankDeclNameArgument(presence: SourcePresence = .present) -> DeclNameArgumentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declNameArgument,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
      ], arena: arena))
      return DeclNameArgumentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentListSyntax")
  public static func makeDeclNameArgumentList(
    _ elements: [DeclNameArgumentSyntax]) -> DeclNameArgumentListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArgumentList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeclNameArgumentListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentListSyntax")
  public static func makeBlankDeclNameArgumentList(presence: SourcePresence = .present) -> DeclNameArgumentListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declNameArgumentList,
        from: [
      ], arena: arena))
      return DeclNameArgumentListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeclNameArgumentsSyntax")
  public static func makeDeclNameArguments(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil, arguments: DeclNameArgumentListSyntax, _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> DeclNameArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.declNameArguments,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeclNameArgumentsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeclNameArgumentsSyntax")
  public static func makeBlankDeclNameArguments(presence: SourcePresence = .present) -> DeclNameArgumentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declNameArguments,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.declNameArgumentList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return DeclNameArgumentsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IdentifierExprSyntax")
  public static func makeIdentifierExpr(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?, _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil) -> IdentifierExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndDeclNameArguments?.raw,
      declNameArguments?.raw,
      unexpectedAfterDeclNameArguments?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.identifierExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IdentifierExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IdentifierExprSyntax")
  public static func makeBlankIdentifierExpr(presence: SourcePresence = .present) -> IdentifierExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .identifierExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return IdentifierExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SuperRefExprSyntax")
  public static func makeSuperRefExpr(_ unexpectedBeforeSuperKeyword: UnexpectedNodesSyntax? = nil, superKeyword: TokenSyntax, _ unexpectedAfterSuperKeyword: UnexpectedNodesSyntax? = nil) -> SuperRefExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSuperKeyword?.raw,
      superKeyword.raw,
      unexpectedAfterSuperKeyword?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.superRefExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SuperRefExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SuperRefExprSyntax")
  public static func makeBlankSuperRefExpr(presence: SourcePresence = .present) -> SuperRefExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .superRefExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.superKeyword, arena: arena),
        nil,
      ], arena: arena))
      return SuperRefExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on NilLiteralExprSyntax")
  public static func makeNilLiteralExpr(_ unexpectedBeforeNilKeyword: UnexpectedNodesSyntax? = nil, nilKeyword: TokenSyntax, _ unexpectedAfterNilKeyword: UnexpectedNodesSyntax? = nil) -> NilLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeNilKeyword?.raw,
      nilKeyword.raw,
      unexpectedAfterNilKeyword?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.nilLiteralExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return NilLiteralExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on NilLiteralExprSyntax")
  public static func makeBlankNilLiteralExpr(presence: SourcePresence = .present) -> NilLiteralExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .nilLiteralExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.nilKeyword, arena: arena),
        nil,
      ], arena: arena))
      return NilLiteralExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DiscardAssignmentExprSyntax")
  public static func makeDiscardAssignmentExpr(_ unexpectedBeforeWildcard: UnexpectedNodesSyntax? = nil, wildcard: TokenSyntax, _ unexpectedAfterWildcard: UnexpectedNodesSyntax? = nil) -> DiscardAssignmentExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWildcard?.raw,
      wildcard.raw,
      unexpectedAfterWildcard?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.discardAssignmentExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DiscardAssignmentExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DiscardAssignmentExprSyntax")
  public static func makeBlankDiscardAssignmentExpr(presence: SourcePresence = .present) -> DiscardAssignmentExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .discardAssignmentExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.wildcardKeyword, arena: arena),
        nil,
      ], arena: arena))
      return DiscardAssignmentExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AssignmentExprSyntax")
  public static func makeAssignmentExpr(_ unexpectedBeforeAssignToken: UnexpectedNodesSyntax? = nil, assignToken: TokenSyntax, _ unexpectedAfterAssignToken: UnexpectedNodesSyntax? = nil) -> AssignmentExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssignToken?.raw,
      assignToken.raw,
      unexpectedAfterAssignToken?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.assignmentExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AssignmentExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AssignmentExprSyntax")
  public static func makeBlankAssignmentExpr(presence: SourcePresence = .present) -> AssignmentExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .assignmentExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: arena),
        nil,
      ], arena: arena))
      return AssignmentExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PackElementExprSyntax")
  public static func makePackElementExpr(_ unexpectedBeforeEachKeyword: UnexpectedNodesSyntax? = nil, eachKeyword: TokenSyntax, _ unexpectedBetweenEachKeywordAndPackRefExpr: UnexpectedNodesSyntax? = nil, packRefExpr: ExprSyntax, _ unexpectedAfterPackRefExpr: UnexpectedNodesSyntax? = nil) -> PackElementExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEachKeyword?.raw,
      eachKeyword.raw,
      unexpectedBetweenEachKeywordAndPackRefExpr?.raw,
      packRefExpr.raw,
      unexpectedAfterPackRefExpr?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.packElementExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PackElementExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PackElementExprSyntax")
  public static func makeBlankPackElementExpr(presence: SourcePresence = .present) -> PackElementExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .packElementExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return PackElementExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SequenceExprSyntax")
  public static func makeSequenceExpr(_ unexpectedBeforeElements: UnexpectedNodesSyntax? = nil, elements: ExprListSyntax, _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil) -> SequenceExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeElements?.raw,
      elements.raw,
      unexpectedAfterElements?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.sequenceExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SequenceExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SequenceExprSyntax")
  public static func makeBlankSequenceExpr(presence: SourcePresence = .present) -> SequenceExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .sequenceExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.exprList, arena: arena),
        nil,
      ], arena: arena))
      return SequenceExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ExprListSyntax")
  public static func makeExprList(
    _ elements: [ExprSyntax]) -> ExprListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.exprList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ExprListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ExprListSyntax")
  public static func makeBlankExprList(presence: SourcePresence = .present) -> ExprListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .exprList,
        from: [
      ], arena: arena))
      return ExprListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SymbolicReferenceExprSyntax")
  public static func makeSymbolicReferenceExpr(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?, _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil) -> SymbolicReferenceExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
      unexpectedAfterGenericArgumentClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.symbolicReferenceExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SymbolicReferenceExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SymbolicReferenceExprSyntax")
  public static func makeBlankSymbolicReferenceExpr(presence: SourcePresence = .present) -> SymbolicReferenceExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .symbolicReferenceExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return SymbolicReferenceExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrefixOperatorExprSyntax")
  public static func makePrefixOperatorExpr(_ unexpectedBeforeOperatorToken: UnexpectedNodesSyntax? = nil, operatorToken: TokenSyntax?, _ unexpectedBetweenOperatorTokenAndPostfixExpression: UnexpectedNodesSyntax? = nil, postfixExpression: ExprSyntax, _ unexpectedAfterPostfixExpression: UnexpectedNodesSyntax? = nil) -> PrefixOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOperatorToken?.raw,
      operatorToken?.raw,
      unexpectedBetweenOperatorTokenAndPostfixExpression?.raw,
      postfixExpression.raw,
      unexpectedAfterPostfixExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.prefixOperatorExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrefixOperatorExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrefixOperatorExprSyntax")
  public static func makeBlankPrefixOperatorExpr(presence: SourcePresence = .present) -> PrefixOperatorExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .prefixOperatorExpr,
        from: [
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return PrefixOperatorExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on BinaryOperatorExprSyntax")
  public static func makeBinaryOperatorExpr(_ unexpectedBeforeOperatorToken: UnexpectedNodesSyntax? = nil, operatorToken: TokenSyntax, _ unexpectedAfterOperatorToken: UnexpectedNodesSyntax? = nil) -> BinaryOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeOperatorToken?.raw,
      operatorToken.raw,
      unexpectedAfterOperatorToken?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.binaryOperatorExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return BinaryOperatorExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on BinaryOperatorExprSyntax")
  public static func makeBlankBinaryOperatorExpr(presence: SourcePresence = .present) -> BinaryOperatorExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .binaryOperatorExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
      ], arena: arena))
      return BinaryOperatorExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ArrowExprSyntax")
  public static func makeArrowExpr(_ unexpectedBeforeAsyncKeyword: UnexpectedNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncKeywordAndThrowsToken: UnexpectedNodesSyntax? = nil, throwsToken: TokenSyntax?, _ unexpectedBetweenThrowsTokenAndArrowToken: UnexpectedNodesSyntax? = nil, arrowToken: TokenSyntax, _ unexpectedAfterArrowToken: UnexpectedNodesSyntax? = nil) -> ArrowExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAsyncKeyword?.raw,
      asyncKeyword?.raw,
      unexpectedBetweenAsyncKeywordAndThrowsToken?.raw,
      throwsToken?.raw,
      unexpectedBetweenThrowsTokenAndArrowToken?.raw,
      arrowToken.raw,
      unexpectedAfterArrowToken?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrowExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ArrowExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ArrowExprSyntax")
  public static func makeBlankArrowExpr(presence: SourcePresence = .present) -> ArrowExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrowExpr,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: arena),
        nil,
      ], arena: arena))
      return ArrowExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on InfixOperatorExprSyntax")
  public static func makeInfixOperatorExpr(_ unexpectedBeforeLeftOperand: UnexpectedNodesSyntax? = nil, leftOperand: ExprSyntax, _ unexpectedBetweenLeftOperandAndOperatorOperand: UnexpectedNodesSyntax? = nil, operatorOperand: ExprSyntax, _ unexpectedBetweenOperatorOperandAndRightOperand: UnexpectedNodesSyntax? = nil, rightOperand: ExprSyntax, _ unexpectedAfterRightOperand: UnexpectedNodesSyntax? = nil) -> InfixOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftOperand?.raw,
      leftOperand.raw,
      unexpectedBetweenLeftOperandAndOperatorOperand?.raw,
      operatorOperand.raw,
      unexpectedBetweenOperatorOperandAndRightOperand?.raw,
      rightOperand.raw,
      unexpectedAfterRightOperand?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.infixOperatorExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return InfixOperatorExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on InfixOperatorExprSyntax")
  public static func makeBlankInfixOperatorExpr(presence: SourcePresence = .present) -> InfixOperatorExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .infixOperatorExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return InfixOperatorExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FloatLiteralExprSyntax")
  public static func makeFloatLiteralExpr(_ unexpectedBeforeFloatingDigits: UnexpectedNodesSyntax? = nil, floatingDigits: TokenSyntax, _ unexpectedAfterFloatingDigits: UnexpectedNodesSyntax? = nil) -> FloatLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeFloatingDigits?.raw,
      floatingDigits.raw,
      unexpectedAfterFloatingDigits?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.floatLiteralExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FloatLiteralExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FloatLiteralExprSyntax")
  public static func makeBlankFloatLiteralExpr(presence: SourcePresence = .present) -> FloatLiteralExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .floatLiteralExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.floatingLiteral(""), arena: arena),
        nil,
      ], arena: arena))
      return FloatLiteralExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TupleExprSyntax")
  public static func makeTupleExpr(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? = nil, elementList: TupleExprElementListSyntax, _ unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> TupleExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      unexpectedBetweenElementListAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TupleExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TupleExprSyntax")
  public static func makeBlankTupleExpr(presence: SourcePresence = .present) -> TupleExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return TupleExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ArrayExprSyntax")
  public static func makeArrayExpr(_ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil, leftSquare: TokenSyntax, _ unexpectedBetweenLeftSquareAndElements: UnexpectedNodesSyntax? = nil, elements: ArrayElementListSyntax, _ unexpectedBetweenElementsAndRightSquare: UnexpectedNodesSyntax? = nil, rightSquare: TokenSyntax, _ unexpectedAfterRightSquare: UnexpectedNodesSyntax? = nil) -> ArrayExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndElements?.raw,
      elements.raw,
      unexpectedBetweenElementsAndRightSquare?.raw,
      rightSquare.raw,
      unexpectedAfterRightSquare?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ArrayExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ArrayExprSyntax")
  public static func makeBlankArrayExpr(presence: SourcePresence = .present) -> ArrayExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrayExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.arrayElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: arena),
        nil,
      ], arena: arena))
      return ArrayExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DictionaryExprSyntax")
  public static func makeDictionaryExpr(_ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil, leftSquare: TokenSyntax, _ unexpectedBetweenLeftSquareAndContent: UnexpectedNodesSyntax? = nil, content: Syntax, _ unexpectedBetweenContentAndRightSquare: UnexpectedNodesSyntax? = nil, rightSquare: TokenSyntax, _ unexpectedAfterRightSquare: UnexpectedNodesSyntax? = nil) -> DictionaryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndContent?.raw,
      content.raw,
      unexpectedBetweenContentAndRightSquare?.raw,
      rightSquare.raw,
      unexpectedAfterRightSquare?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DictionaryExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DictionaryExprSyntax")
  public static func makeBlankDictionaryExpr(presence: SourcePresence = .present) -> DictionaryExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .dictionaryExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: arena),
        nil,
      ], arena: arena))
      return DictionaryExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TupleExprElementSyntax")
  public static func makeTupleExprElement(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax?, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> TupleExprElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label?.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleExprElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TupleExprElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TupleExprElementSyntax")
  public static func makeBlankTupleExprElement(presence: SourcePresence = .present) -> TupleExprElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleExprElement,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return TupleExprElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ArrayElementSyntax")
  public static func makeArrayElement(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> ArrayElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ArrayElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ArrayElementSyntax")
  public static func makeBlankArrayElement(presence: SourcePresence = .present) -> ArrayElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrayElement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return ArrayElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DictionaryElementSyntax")
  public static func makeDictionaryElement(_ unexpectedBeforeKeyExpression: UnexpectedNodesSyntax? = nil, keyExpression: ExprSyntax, _ unexpectedBetweenKeyExpressionAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValueExpression: UnexpectedNodesSyntax? = nil, valueExpression: ExprSyntax, _ unexpectedBetweenValueExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> DictionaryElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeKeyExpression?.raw,
      keyExpression.raw,
      unexpectedBetweenKeyExpressionAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValueExpression?.raw,
      valueExpression.raw,
      unexpectedBetweenValueExpressionAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DictionaryElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DictionaryElementSyntax")
  public static func makeBlankDictionaryElement(presence: SourcePresence = .present) -> DictionaryElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .dictionaryElement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return DictionaryElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IntegerLiteralExprSyntax")
  public static func makeIntegerLiteralExpr(_ unexpectedBeforeDigits: UnexpectedNodesSyntax? = nil, digits: TokenSyntax, _ unexpectedAfterDigits: UnexpectedNodesSyntax? = nil) -> IntegerLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDigits?.raw,
      digits.raw,
      unexpectedAfterDigits?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.integerLiteralExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IntegerLiteralExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IntegerLiteralExprSyntax")
  public static func makeBlankIntegerLiteralExpr(presence: SourcePresence = .present) -> IntegerLiteralExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .integerLiteralExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: arena),
        nil,
      ], arena: arena))
      return IntegerLiteralExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on BooleanLiteralExprSyntax")
  public static func makeBooleanLiteralExpr(_ unexpectedBeforeBooleanLiteral: UnexpectedNodesSyntax? = nil, booleanLiteral: TokenSyntax, _ unexpectedAfterBooleanLiteral: UnexpectedNodesSyntax? = nil) -> BooleanLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBooleanLiteral?.raw,
      booleanLiteral.raw,
      unexpectedAfterBooleanLiteral?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.booleanLiteralExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return BooleanLiteralExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on BooleanLiteralExprSyntax")
  public static func makeBlankBooleanLiteralExpr(presence: SourcePresence = .present) -> BooleanLiteralExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .booleanLiteralExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.trueKeyword, arena: arena),
        nil,
      ], arena: arena))
      return BooleanLiteralExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedTernaryExprSyntax")
  public static func makeUnresolvedTernaryExpr(_ unexpectedBeforeQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax, _ unexpectedBetweenQuestionMarkAndFirstChoice: UnexpectedNodesSyntax? = nil, firstChoice: ExprSyntax, _ unexpectedBetweenFirstChoiceAndColonMark: UnexpectedNodesSyntax? = nil, colonMark: TokenSyntax, _ unexpectedAfterColonMark: UnexpectedNodesSyntax? = nil) -> UnresolvedTernaryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeQuestionMark?.raw,
      questionMark.raw,
      unexpectedBetweenQuestionMarkAndFirstChoice?.raw,
      firstChoice.raw,
      unexpectedBetweenFirstChoiceAndColonMark?.raw,
      colonMark.raw,
      unexpectedAfterColonMark?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedTernaryExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return UnresolvedTernaryExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedTernaryExprSyntax")
  public static func makeBlankUnresolvedTernaryExpr(presence: SourcePresence = .present) -> UnresolvedTernaryExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unresolvedTernaryExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.infixQuestionMark, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
      ], arena: arena))
      return UnresolvedTernaryExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TernaryExprSyntax")
  public static func makeTernaryExpr(_ unexpectedBeforeConditionExpression: UnexpectedNodesSyntax? = nil, conditionExpression: ExprSyntax, _ unexpectedBetweenConditionExpressionAndQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax, _ unexpectedBetweenQuestionMarkAndFirstChoice: UnexpectedNodesSyntax? = nil, firstChoice: ExprSyntax, _ unexpectedBetweenFirstChoiceAndColonMark: UnexpectedNodesSyntax? = nil, colonMark: TokenSyntax, _ unexpectedBetweenColonMarkAndSecondChoice: UnexpectedNodesSyntax? = nil, secondChoice: ExprSyntax, _ unexpectedAfterSecondChoice: UnexpectedNodesSyntax? = nil) -> TernaryExprSyntax {
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
      unexpectedAfterSecondChoice?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.ternaryExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TernaryExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TernaryExprSyntax")
  public static func makeBlankTernaryExpr(presence: SourcePresence = .present) -> TernaryExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ternaryExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.infixQuestionMark, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return TernaryExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MemberAccessExprSyntax")
  public static func makeMemberAccessExpr(_ unexpectedBeforeBase: UnexpectedNodesSyntax? = nil, base: ExprSyntax?, _ unexpectedBetweenBaseAndDot: UnexpectedNodesSyntax? = nil, dot: TokenSyntax, _ unexpectedBetweenDotAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?, _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil) -> MemberAccessExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBase?.raw,
      base?.raw,
      unexpectedBetweenBaseAndDot?.raw,
      dot.raw,
      unexpectedBetweenDotAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
      unexpectedAfterDeclNameArguments?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberAccessExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MemberAccessExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MemberAccessExprSyntax")
  public static func makeBlankMemberAccessExpr(presence: SourcePresence = .present) -> MemberAccessExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberAccessExpr,
        from: [
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.period, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return MemberAccessExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedIsExprSyntax")
  public static func makeUnresolvedIsExpr(_ unexpectedBeforeIsTok: UnexpectedNodesSyntax? = nil, isTok: TokenSyntax, _ unexpectedAfterIsTok: UnexpectedNodesSyntax? = nil) -> UnresolvedIsExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIsTok?.raw,
      isTok.raw,
      unexpectedAfterIsTok?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedIsExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return UnresolvedIsExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedIsExprSyntax")
  public static func makeBlankUnresolvedIsExpr(presence: SourcePresence = .present) -> UnresolvedIsExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unresolvedIsExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.isKeyword, arena: arena),
        nil,
      ], arena: arena))
      return UnresolvedIsExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IsExprSyntax")
  public static func makeIsExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndIsTok: UnexpectedNodesSyntax? = nil, isTok: TokenSyntax, _ unexpectedBetweenIsTokAndTypeName: UnexpectedNodesSyntax? = nil, typeName: TypeSyntax, _ unexpectedAfterTypeName: UnexpectedNodesSyntax? = nil) -> IsExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndIsTok?.raw,
      isTok.raw,
      unexpectedBetweenIsTokAndTypeName?.raw,
      typeName.raw,
      unexpectedAfterTypeName?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.isExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IsExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IsExprSyntax")
  public static func makeBlankIsExpr(presence: SourcePresence = .present) -> IsExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .isExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.isKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return IsExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedAsExprSyntax")
  public static func makeUnresolvedAsExpr(_ unexpectedBeforeAsTok: UnexpectedNodesSyntax? = nil, asTok: TokenSyntax, _ unexpectedBetweenAsTokAndQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax?, _ unexpectedAfterQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil) -> UnresolvedAsExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAsTok?.raw,
      asTok.raw,
      unexpectedBetweenAsTokAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      unexpectedAfterQuestionOrExclamationMark?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedAsExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return UnresolvedAsExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedAsExprSyntax")
  public static func makeBlankUnresolvedAsExpr(presence: SourcePresence = .present) -> UnresolvedAsExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unresolvedAsExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.asKeyword, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return UnresolvedAsExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AsExprSyntax")
  public static func makeAsExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndAsTok: UnexpectedNodesSyntax? = nil, asTok: TokenSyntax, _ unexpectedBetweenAsTokAndQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax?, _ unexpectedBetweenQuestionOrExclamationMarkAndTypeName: UnexpectedNodesSyntax? = nil, typeName: TypeSyntax, _ unexpectedAfterTypeName: UnexpectedNodesSyntax? = nil) -> AsExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndAsTok?.raw,
      asTok.raw,
      unexpectedBetweenAsTokAndQuestionOrExclamationMark?.raw,
      questionOrExclamationMark?.raw,
      unexpectedBetweenQuestionOrExclamationMarkAndTypeName?.raw,
      typeName.raw,
      unexpectedAfterTypeName?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.asExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AsExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AsExprSyntax")
  public static func makeBlankAsExpr(presence: SourcePresence = .present) -> AsExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .asExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.asKeyword, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return AsExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TypeExprSyntax")
  public static func makeTypeExpr(_ unexpectedBeforeType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedAfterType: UnexpectedNodesSyntax? = nil) -> TypeExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type.raw,
      unexpectedAfterType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TypeExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TypeExprSyntax")
  public static func makeBlankTypeExpr(presence: SourcePresence = .present) -> TypeExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typeExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return TypeExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemSyntax")
  public static func makeClosureCaptureItem(_ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil, specifier: TokenListSyntax?, _ unexpectedBetweenSpecifierAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax?, _ unexpectedBetweenNameAndAssignToken: UnexpectedNodesSyntax? = nil, assignToken: TokenSyntax?, _ unexpectedBetweenAssignTokenAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> ClosureCaptureItemSyntax {
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
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureItem,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClosureCaptureItemSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemSyntax")
  public static func makeBlankClosureCaptureItem(presence: SourcePresence = .present) -> ClosureCaptureItemSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureCaptureItem,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return ClosureCaptureItemSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemListSyntax")
  public static func makeClosureCaptureItemList(
    _ elements: [ClosureCaptureItemSyntax]) -> ClosureCaptureItemListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureItemList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClosureCaptureItemListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureItemListSyntax")
  public static func makeBlankClosureCaptureItemList(presence: SourcePresence = .present) -> ClosureCaptureItemListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureCaptureItemList,
        from: [
      ], arena: arena))
      return ClosureCaptureItemListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClosureCaptureSignatureSyntax")
  public static func makeClosureCaptureSignature(_ unexpectedBeforeLeftSquare: UnexpectedNodesSyntax? = nil, leftSquare: TokenSyntax, _ unexpectedBetweenLeftSquareAndItems: UnexpectedNodesSyntax? = nil, items: ClosureCaptureItemListSyntax?, _ unexpectedBetweenItemsAndRightSquare: UnexpectedNodesSyntax? = nil, rightSquare: TokenSyntax, _ unexpectedAfterRightSquare: UnexpectedNodesSyntax? = nil) -> ClosureCaptureSignatureSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquare?.raw,
      leftSquare.raw,
      unexpectedBetweenLeftSquareAndItems?.raw,
      items?.raw,
      unexpectedBetweenItemsAndRightSquare?.raw,
      rightSquare.raw,
      unexpectedAfterRightSquare?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureCaptureSignature,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClosureCaptureSignatureSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClosureCaptureSignatureSyntax")
  public static func makeBlankClosureCaptureSignature(presence: SourcePresence = .present) -> ClosureCaptureSignatureSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureCaptureSignature,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: arena),
        nil,
      ], arena: arena))
      return ClosureCaptureSignatureSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClosureParamSyntax")
  public static func makeClosureParam(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> ClosureParamSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureParam,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClosureParamSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClosureParamSyntax")
  public static func makeBlankClosureParam(presence: SourcePresence = .present) -> ClosureParamSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureParam,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return ClosureParamSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClosureParamListSyntax")
  public static func makeClosureParamList(
    _ elements: [ClosureParamSyntax]) -> ClosureParamListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureParamList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClosureParamListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClosureParamListSyntax")
  public static func makeBlankClosureParamList(presence: SourcePresence = .present) -> ClosureParamListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureParamList,
        from: [
      ], arena: arena))
      return ClosureParamListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClosureSignatureSyntax")
  public static func makeClosureSignature(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndCapture: UnexpectedNodesSyntax? = nil, capture: ClosureCaptureSignatureSyntax?, _ unexpectedBetweenCaptureAndInput: UnexpectedNodesSyntax? = nil, input: Syntax?, _ unexpectedBetweenInputAndAsyncKeyword: UnexpectedNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncKeywordAndThrowsTok: UnexpectedNodesSyntax? = nil, throwsTok: TokenSyntax?, _ unexpectedBetweenThrowsTokAndOutput: UnexpectedNodesSyntax? = nil, output: ReturnClauseSyntax?, _ unexpectedBetweenOutputAndInTok: UnexpectedNodesSyntax? = nil, inTok: TokenSyntax, _ unexpectedAfterInTok: UnexpectedNodesSyntax? = nil) -> ClosureSignatureSyntax {
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
      unexpectedAfterInTok?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureSignature,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClosureSignatureSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClosureSignatureSyntax")
  public static func makeBlankClosureSignature(presence: SourcePresence = .present) -> ClosureSignatureSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
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
        RawSyntax.makeMissingToken(kind: TokenKind.inKeyword, arena: arena),
        nil,
      ], arena: arena))
      return ClosureSignatureSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClosureExprSyntax")
  public static func makeClosureExpr(_ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndSignature: UnexpectedNodesSyntax? = nil, signature: ClosureSignatureSyntax?, _ unexpectedBetweenSignatureAndStatements: UnexpectedNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ unexpectedBetweenStatementsAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax, _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil) -> ClosureExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndSignature?.raw,
      signature?.raw,
      unexpectedBetweenSignatureAndStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndRightBrace?.raw,
      rightBrace.raw,
      unexpectedAfterRightBrace?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.closureExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClosureExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClosureExprSyntax")
  public static func makeBlankClosureExpr(presence: SourcePresence = .present) -> ClosureExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .closureExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: arena),
        nil,
      ], arena: arena))
      return ClosureExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on UnresolvedPatternExprSyntax")
  public static func makeUnresolvedPatternExpr(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedAfterPattern: UnexpectedNodesSyntax? = nil) -> UnresolvedPatternExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
      unexpectedAfterPattern?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.unresolvedPatternExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return UnresolvedPatternExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on UnresolvedPatternExprSyntax")
  public static func makeBlankUnresolvedPatternExpr(presence: SourcePresence = .present) -> UnresolvedPatternExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unresolvedPatternExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
      ], arena: arena))
      return UnresolvedPatternExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementSyntax")
  public static func makeMultipleTrailingClosureElement(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndClosure: UnexpectedNodesSyntax? = nil, closure: ClosureExprSyntax, _ unexpectedAfterClosure: UnexpectedNodesSyntax? = nil) -> MultipleTrailingClosureElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndClosure?.raw,
      closure.raw,
      unexpectedAfterClosure?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MultipleTrailingClosureElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementSyntax")
  public static func makeBlankMultipleTrailingClosureElement(presence: SourcePresence = .present) -> MultipleTrailingClosureElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .multipleTrailingClosureElement,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.closureExpr, arena: arena),
        nil,
      ], arena: arena))
      return MultipleTrailingClosureElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementListSyntax")
  public static func makeMultipleTrailingClosureElementList(
    _ elements: [MultipleTrailingClosureElementSyntax]) -> MultipleTrailingClosureElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.multipleTrailingClosureElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MultipleTrailingClosureElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MultipleTrailingClosureElementListSyntax")
  public static func makeBlankMultipleTrailingClosureElementList(presence: SourcePresence = .present) -> MultipleTrailingClosureElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .multipleTrailingClosureElementList,
        from: [
      ], arena: arena))
      return MultipleTrailingClosureElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FunctionCallExprSyntax")
  public static func makeFunctionCallExpr(_ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil, calledExpression: ExprSyntax, _ unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?, _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil, trailingClosure: ClosureExprSyntax?, _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?, _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil) -> FunctionCallExprSyntax {
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
      unexpectedAfterAdditionalTrailingClosures?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionCallExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FunctionCallExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FunctionCallExprSyntax")
  public static func makeBlankFunctionCallExpr(presence: SourcePresence = .present) -> FunctionCallExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionCallExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return FunctionCallExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SubscriptExprSyntax")
  public static func makeSubscriptExpr(_ unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil, calledExpression: ExprSyntax, _ unexpectedBetweenCalledExpressionAndLeftBracket: UnexpectedNodesSyntax? = nil, leftBracket: TokenSyntax, _ unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? = nil, rightBracket: TokenSyntax, _ unexpectedBetweenRightBracketAndTrailingClosure: UnexpectedNodesSyntax? = nil, trailingClosure: ClosureExprSyntax?, _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?, _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil) -> SubscriptExprSyntax {
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
      unexpectedAfterAdditionalTrailingClosures?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.subscriptExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SubscriptExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SubscriptExprSyntax")
  public static func makeBlankSubscriptExpr(presence: SourcePresence = .present) -> SubscriptExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .subscriptExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return SubscriptExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on OptionalChainingExprSyntax")
  public static func makeOptionalChainingExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax, _ unexpectedAfterQuestionMark: UnexpectedNodesSyntax? = nil) -> OptionalChainingExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndQuestionMark?.raw,
      questionMark.raw,
      unexpectedAfterQuestionMark?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalChainingExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return OptionalChainingExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on OptionalChainingExprSyntax")
  public static func makeBlankOptionalChainingExpr(presence: SourcePresence = .present) -> OptionalChainingExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .optionalChainingExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: arena),
        nil,
      ], arena: arena))
      return OptionalChainingExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ForcedValueExprSyntax")
  public static func makeForcedValueExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndExclamationMark: UnexpectedNodesSyntax? = nil, exclamationMark: TokenSyntax, _ unexpectedAfterExclamationMark: UnexpectedNodesSyntax? = nil) -> ForcedValueExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndExclamationMark?.raw,
      exclamationMark.raw,
      unexpectedAfterExclamationMark?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.forcedValueExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ForcedValueExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ForcedValueExprSyntax")
  public static func makeBlankForcedValueExpr(presence: SourcePresence = .present) -> ForcedValueExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .forcedValueExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.exclamationMark, arena: arena),
        nil,
      ], arena: arena))
      return ForcedValueExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PostfixUnaryExprSyntax")
  public static func makePostfixUnaryExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndOperatorToken: UnexpectedNodesSyntax? = nil, operatorToken: TokenSyntax, _ unexpectedAfterOperatorToken: UnexpectedNodesSyntax? = nil) -> PostfixUnaryExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndOperatorToken?.raw,
      operatorToken.raw,
      unexpectedAfterOperatorToken?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.postfixUnaryExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PostfixUnaryExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PostfixUnaryExprSyntax")
  public static func makeBlankPostfixUnaryExpr(presence: SourcePresence = .present) -> PostfixUnaryExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .postfixUnaryExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.postfixOperator(""), arena: arena),
        nil,
      ], arena: arena))
      return PostfixUnaryExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SpecializeExprSyntax")
  public static func makeSpecializeExpr(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax, _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil) -> SpecializeExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndGenericArgumentClause?.raw,
      genericArgumentClause.raw,
      unexpectedAfterGenericArgumentClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.specializeExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SpecializeExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SpecializeExprSyntax")
  public static func makeBlankSpecializeExpr(presence: SourcePresence = .present) -> SpecializeExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .specializeExpr,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericArgumentClause, arena: arena),
        nil,
      ], arena: arena))
      return SpecializeExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on StringSegmentSyntax")
  public static func makeStringSegment(_ unexpectedBeforeContent: UnexpectedNodesSyntax? = nil, content: TokenSyntax, _ unexpectedAfterContent: UnexpectedNodesSyntax? = nil) -> StringSegmentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeContent?.raw,
      content.raw,
      unexpectedAfterContent?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringSegment,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return StringSegmentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on StringSegmentSyntax")
  public static func makeBlankStringSegment(presence: SourcePresence = .present) -> StringSegmentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .stringSegment,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.stringSegment(""), arena: arena),
        nil,
      ], arena: arena))
      return StringSegmentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ExpressionSegmentSyntax")
  public static func makeExpressionSegment(_ unexpectedBeforeBackslash: UnexpectedNodesSyntax? = nil, backslash: TokenSyntax, _ unexpectedBetweenBackslashAndDelimiter: UnexpectedNodesSyntax? = nil, delimiter: TokenSyntax?, _ unexpectedBetweenDelimiterAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndExpressions: UnexpectedNodesSyntax? = nil, expressions: TupleExprElementListSyntax, _ unexpectedBetweenExpressionsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> ExpressionSegmentSyntax {
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
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.expressionSegment,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ExpressionSegmentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ExpressionSegmentSyntax")
  public static func makeBlankExpressionSegment(presence: SourcePresence = .present) -> ExpressionSegmentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .expressionSegment,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.backslash, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.stringInterpolationAnchor, arena: arena),
        nil,
      ], arena: arena))
      return ExpressionSegmentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on StringLiteralExprSyntax")
  public static func makeStringLiteralExpr(_ unexpectedBeforeOpenDelimiter: UnexpectedNodesSyntax? = nil, openDelimiter: TokenSyntax?, _ unexpectedBetweenOpenDelimiterAndOpenQuote: UnexpectedNodesSyntax? = nil, openQuote: TokenSyntax, _ unexpectedBetweenOpenQuoteAndSegments: UnexpectedNodesSyntax? = nil, segments: StringLiteralSegmentsSyntax, _ unexpectedBetweenSegmentsAndCloseQuote: UnexpectedNodesSyntax? = nil, closeQuote: TokenSyntax, _ unexpectedBetweenCloseQuoteAndCloseDelimiter: UnexpectedNodesSyntax? = nil, closeDelimiter: TokenSyntax?, _ unexpectedAfterCloseDelimiter: UnexpectedNodesSyntax? = nil) -> StringLiteralExprSyntax {
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
      unexpectedAfterCloseDelimiter?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.stringLiteralExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return StringLiteralExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on StringLiteralExprSyntax")
  public static func makeBlankStringLiteralExpr(presence: SourcePresence = .present) -> StringLiteralExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .stringLiteralExpr,
        from: [
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.stringQuote, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralSegments, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.stringQuote, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return StringLiteralExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on RegexLiteralExprSyntax")
  public static func makeRegexLiteralExpr(_ unexpectedBeforeRegex: UnexpectedNodesSyntax? = nil, regex: TokenSyntax, _ unexpectedAfterRegex: UnexpectedNodesSyntax? = nil) -> RegexLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeRegex?.raw,
      regex.raw,
      unexpectedAfterRegex?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.regexLiteralExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return RegexLiteralExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on RegexLiteralExprSyntax")
  public static func makeBlankRegexLiteralExpr(presence: SourcePresence = .present) -> RegexLiteralExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .regexLiteralExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.regexLiteral(""), arena: arena),
        nil,
      ], arena: arena))
      return RegexLiteralExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on KeyPathExprSyntax")
  public static func makeKeyPathExpr(_ unexpectedBeforeBackslash: UnexpectedNodesSyntax? = nil, backslash: TokenSyntax, _ unexpectedBetweenBackslashAndRoot: UnexpectedNodesSyntax? = nil, root: TypeSyntax?, _ unexpectedBetweenRootAndComponents: UnexpectedNodesSyntax? = nil, components: KeyPathComponentListSyntax, _ unexpectedAfterComponents: UnexpectedNodesSyntax? = nil) -> KeyPathExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBackslash?.raw,
      backslash.raw,
      unexpectedBetweenBackslashAndRoot?.raw,
      root?.raw,
      unexpectedBetweenRootAndComponents?.raw,
      components.raw,
      unexpectedAfterComponents?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return KeyPathExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on KeyPathExprSyntax")
  public static func makeBlankKeyPathExpr(presence: SourcePresence = .present) -> KeyPathExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.backslash, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.keyPathComponentList, arena: arena),
        nil,
      ], arena: arena))
      return KeyPathExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on KeyPathComponentListSyntax")
  public static func makeKeyPathComponentList(
    _ elements: [KeyPathComponentSyntax]) -> KeyPathComponentListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathComponentList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return KeyPathComponentListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on KeyPathComponentListSyntax")
  public static func makeBlankKeyPathComponentList(presence: SourcePresence = .present) -> KeyPathComponentListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathComponentList,
        from: [
      ], arena: arena))
      return KeyPathComponentListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on KeyPathComponentSyntax")
  public static func makeKeyPathComponent(_ unexpectedBeforePeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax?, _ unexpectedBetweenPeriodAndComponent: UnexpectedNodesSyntax? = nil, component: Syntax, _ unexpectedAfterComponent: UnexpectedNodesSyntax? = nil) -> KeyPathComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePeriod?.raw,
      period?.raw,
      unexpectedBetweenPeriodAndComponent?.raw,
      component.raw,
      unexpectedAfterComponent?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathComponent,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return KeyPathComponentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on KeyPathComponentSyntax")
  public static func makeBlankKeyPathComponent(presence: SourcePresence = .present) -> KeyPathComponentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathComponent,
        from: [
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
      ], arena: arena))
      return KeyPathComponentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on KeyPathPropertyComponentSyntax")
  public static func makeKeyPathPropertyComponent(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?, _ unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?, _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil) -> KeyPathPropertyComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndDeclNameArguments?.raw,
      declNameArguments?.raw,
      unexpectedBetweenDeclNameArgumentsAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
      unexpectedAfterGenericArgumentClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathPropertyComponent,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return KeyPathPropertyComponentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on KeyPathPropertyComponentSyntax")
  public static func makeBlankKeyPathPropertyComponent(presence: SourcePresence = .present) -> KeyPathPropertyComponentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathPropertyComponent,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return KeyPathPropertyComponentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on KeyPathSubscriptComponentSyntax")
  public static func makeKeyPathSubscriptComponent(_ unexpectedBeforeLeftBracket: UnexpectedNodesSyntax? = nil, leftBracket: TokenSyntax, _ unexpectedBetweenLeftBracketAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ unexpectedBetweenArgumentListAndRightBracket: UnexpectedNodesSyntax? = nil, rightBracket: TokenSyntax, _ unexpectedAfterRightBracket: UnexpectedNodesSyntax? = nil) -> KeyPathSubscriptComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBracket?.raw,
      leftBracket.raw,
      unexpectedBetweenLeftBracketAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightBracket?.raw,
      rightBracket.raw,
      unexpectedAfterRightBracket?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathSubscriptComponent,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return KeyPathSubscriptComponentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on KeyPathSubscriptComponentSyntax")
  public static func makeBlankKeyPathSubscriptComponent(presence: SourcePresence = .present) -> KeyPathSubscriptComponentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathSubscriptComponent,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: arena),
        nil,
      ], arena: arena))
      return KeyPathSubscriptComponentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on KeyPathOptionalComponentSyntax")
  public static func makeKeyPathOptionalComponent(_ unexpectedBeforeQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil, questionOrExclamationMark: TokenSyntax, _ unexpectedAfterQuestionOrExclamationMark: UnexpectedNodesSyntax? = nil) -> KeyPathOptionalComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeQuestionOrExclamationMark?.raw,
      questionOrExclamationMark.raw,
      unexpectedAfterQuestionOrExclamationMark?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.keyPathOptionalComponent,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return KeyPathOptionalComponentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on KeyPathOptionalComponentSyntax")
  public static func makeBlankKeyPathOptionalComponent(presence: SourcePresence = .present) -> KeyPathOptionalComponentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .keyPathOptionalComponent,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: arena),
        nil,
      ], arena: arena))
      return KeyPathOptionalComponentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MacroExpansionExprSyntax")
  public static func makeMacroExpansionExpr(_ unexpectedBeforePoundToken: UnexpectedNodesSyntax? = nil, poundToken: TokenSyntax, _ unexpectedBetweenPoundTokenAndMacro: UnexpectedNodesSyntax? = nil, macro: TokenSyntax, _ unexpectedBetweenMacroAndGenericArguments: UnexpectedNodesSyntax? = nil, genericArguments: GenericArgumentClauseSyntax?, _ unexpectedBetweenGenericArgumentsAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?, _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil, trailingClosure: ClosureExprSyntax?, _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?, _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil) -> MacroExpansionExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundToken?.raw,
      poundToken.raw,
      unexpectedBetweenPoundTokenAndMacro?.raw,
      macro.raw,
      unexpectedBetweenMacroAndGenericArguments?.raw,
      genericArguments?.raw,
      unexpectedBetweenGenericArgumentsAndLeftParen?.raw,
      leftParen?.raw,
      unexpectedBetweenLeftParenAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
      unexpectedBetweenRightParenAndTrailingClosure?.raw,
      trailingClosure?.raw,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
      unexpectedAfterAdditionalTrailingClosures?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.macroExpansionExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MacroExpansionExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MacroExpansionExprSyntax")
  public static func makeBlankMacroExpansionExpr(presence: SourcePresence = .present) -> MacroExpansionExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .macroExpansionExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.pound, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return MacroExpansionExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PostfixIfConfigExprSyntax")
  public static func makePostfixIfConfigExpr(_ unexpectedBeforeBase: UnexpectedNodesSyntax? = nil, base: ExprSyntax?, _ unexpectedBetweenBaseAndConfig: UnexpectedNodesSyntax? = nil, config: IfConfigDeclSyntax, _ unexpectedAfterConfig: UnexpectedNodesSyntax? = nil) -> PostfixIfConfigExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBase?.raw,
      base?.raw,
      unexpectedBetweenBaseAndConfig?.raw,
      config.raw,
      unexpectedAfterConfig?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.postfixIfConfigExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PostfixIfConfigExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PostfixIfConfigExprSyntax")
  public static func makeBlankPostfixIfConfigExpr(presence: SourcePresence = .present) -> PostfixIfConfigExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .postfixIfConfigExpr,
        from: [
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.ifConfigDecl, arena: arena),
        nil,
      ], arena: arena))
      return PostfixIfConfigExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on EditorPlaceholderExprSyntax")
  public static func makeEditorPlaceholderExpr(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedAfterIdentifier: UnexpectedNodesSyntax? = nil) -> EditorPlaceholderExprSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedAfterIdentifier?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.editorPlaceholderExpr,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return EditorPlaceholderExprSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on EditorPlaceholderExprSyntax")
  public static func makeBlankEditorPlaceholderExpr(presence: SourcePresence = .present) -> EditorPlaceholderExprSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .editorPlaceholderExpr,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
      ], arena: arena))
      return EditorPlaceholderExprSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on YieldExprListSyntax")
  public static func makeYieldExprList(
    _ elements: [YieldExprListElementSyntax]) -> YieldExprListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldExprList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return YieldExprListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on YieldExprListSyntax")
  public static func makeBlankYieldExprList(presence: SourcePresence = .present) -> YieldExprListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .yieldExprList,
        from: [
      ], arena: arena))
      return YieldExprListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on YieldExprListElementSyntax")
  public static func makeYieldExprListElement(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedAfterComma: UnexpectedNodesSyntax? = nil) -> YieldExprListElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndComma?.raw,
      comma?.raw,
      unexpectedAfterComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldExprListElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return YieldExprListElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on YieldExprListElementSyntax")
  public static func makeBlankYieldExprListElement(presence: SourcePresence = .present) -> YieldExprListElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .yieldExprListElement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return YieldExprListElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TypeInitializerClauseSyntax")
  public static func makeTypeInitializerClause(_ unexpectedBeforeEqual: UnexpectedNodesSyntax? = nil, equal: TokenSyntax, _ unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? = nil, value: TypeSyntax, _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil) -> TypeInitializerClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEqual?.raw,
      equal.raw,
      unexpectedBetweenEqualAndValue?.raw,
      value.raw,
      unexpectedAfterValue?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeInitializerClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TypeInitializerClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TypeInitializerClauseSyntax")
  public static func makeBlankTypeInitializerClause(presence: SourcePresence = .present) -> TypeInitializerClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typeInitializerClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return TypeInitializerClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TypealiasDeclSyntax")
  public static func makeTypealiasDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndTypealiasKeyword: UnexpectedNodesSyntax? = nil, typealiasKeyword: TokenSyntax, _ unexpectedBetweenTypealiasKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndInitializer: UnexpectedNodesSyntax? = nil, initializer: TypeInitializerClauseSyntax, _ unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? = nil) -> TypealiasDeclSyntax {
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
      unexpectedAfterGenericWhereClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.typealiasDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TypealiasDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TypealiasDeclSyntax")
  public static func makeBlankTypealiasDecl(presence: SourcePresence = .present) -> TypealiasDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typealiasDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.typealiasKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.typeInitializerClause, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return TypealiasDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AssociatedtypeDeclSyntax")
  public static func makeAssociatedtypeDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndAssociatedtypeKeyword: UnexpectedNodesSyntax? = nil, associatedtypeKeyword: TokenSyntax, _ unexpectedBetweenAssociatedtypeKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndInitializer: UnexpectedNodesSyntax? = nil, initializer: TypeInitializerClauseSyntax?, _ unexpectedBetweenInitializerAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? = nil) -> AssociatedtypeDeclSyntax {
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
      unexpectedAfterGenericWhereClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.associatedtypeDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AssociatedtypeDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AssociatedtypeDeclSyntax")
  public static func makeBlankAssociatedtypeDecl(presence: SourcePresence = .present) -> AssociatedtypeDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .associatedtypeDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.associatedtypeKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return AssociatedtypeDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FunctionParameterListSyntax")
  public static func makeFunctionParameterList(
    _ elements: [FunctionParameterSyntax]) -> FunctionParameterListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionParameterList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FunctionParameterListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FunctionParameterListSyntax")
  public static func makeBlankFunctionParameterList(presence: SourcePresence = .present) -> FunctionParameterListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionParameterList,
        from: [
      ], arena: arena))
      return FunctionParameterListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ParameterClauseSyntax")
  public static func makeParameterClause(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndParameterList: UnexpectedNodesSyntax? = nil, parameterList: FunctionParameterListSyntax, _ unexpectedBetweenParameterListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> ParameterClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndParameterList?.raw,
      parameterList.raw,
      unexpectedBetweenParameterListAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.parameterClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ParameterClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ParameterClauseSyntax")
  public static func makeBlankParameterClause(presence: SourcePresence = .present) -> ParameterClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .parameterClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionParameterList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return ParameterClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ReturnClauseSyntax")
  public static func makeReturnClause(_ unexpectedBeforeArrow: UnexpectedNodesSyntax? = nil, arrow: TokenSyntax, _ unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? = nil, returnType: TypeSyntax, _ unexpectedAfterReturnType: UnexpectedNodesSyntax? = nil) -> ReturnClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeArrow?.raw,
      arrow.raw,
      unexpectedBetweenArrowAndReturnType?.raw,
      returnType.raw,
      unexpectedAfterReturnType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.returnClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ReturnClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ReturnClauseSyntax")
  public static func makeBlankReturnClause(presence: SourcePresence = .present) -> ReturnClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .returnClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return ReturnClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FunctionSignatureSyntax")
  public static func makeFunctionSignature(_ unexpectedBeforeInput: UnexpectedNodesSyntax? = nil, input: ParameterClauseSyntax, _ unexpectedBetweenInputAndAsyncOrReasyncKeyword: UnexpectedNodesSyntax? = nil, asyncOrReasyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword: UnexpectedNodesSyntax? = nil, throwsOrRethrowsKeyword: TokenSyntax?, _ unexpectedBetweenThrowsOrRethrowsKeywordAndOutput: UnexpectedNodesSyntax? = nil, output: ReturnClauseSyntax?, _ unexpectedAfterOutput: UnexpectedNodesSyntax? = nil) -> FunctionSignatureSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeInput?.raw,
      input.raw,
      unexpectedBetweenInputAndAsyncOrReasyncKeyword?.raw,
      asyncOrReasyncKeyword?.raw,
      unexpectedBetweenAsyncOrReasyncKeywordAndThrowsOrRethrowsKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      unexpectedBetweenThrowsOrRethrowsKeywordAndOutput?.raw,
      output?.raw,
      unexpectedAfterOutput?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionSignature,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FunctionSignatureSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FunctionSignatureSyntax")
  public static func makeBlankFunctionSignature(presence: SourcePresence = .present) -> FunctionSignatureSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionSignature,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.parameterClause, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return FunctionSignatureSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IfConfigClauseSyntax")
  public static func makeIfConfigClause(_ unexpectedBeforePoundKeyword: UnexpectedNodesSyntax? = nil, poundKeyword: TokenSyntax, _ unexpectedBetweenPoundKeywordAndCondition: UnexpectedNodesSyntax? = nil, condition: ExprSyntax?, _ unexpectedBetweenConditionAndElements: UnexpectedNodesSyntax? = nil, elements: Syntax?, _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil) -> IfConfigClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundKeyword?.raw,
      poundKeyword.raw,
      unexpectedBetweenPoundKeywordAndCondition?.raw,
      condition?.raw,
      unexpectedBetweenConditionAndElements?.raw,
      elements?.raw,
      unexpectedAfterElements?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IfConfigClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IfConfigClauseSyntax")
  public static func makeBlankIfConfigClause(presence: SourcePresence = .present) -> IfConfigClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ifConfigClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundIfKeyword, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return IfConfigClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IfConfigClauseListSyntax")
  public static func makeIfConfigClauseList(
    _ elements: [IfConfigClauseSyntax]) -> IfConfigClauseListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigClauseList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IfConfigClauseListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IfConfigClauseListSyntax")
  public static func makeBlankIfConfigClauseList(presence: SourcePresence = .present) -> IfConfigClauseListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ifConfigClauseList,
        from: [
      ], arena: arena))
      return IfConfigClauseListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IfConfigDeclSyntax")
  public static func makeIfConfigDecl(_ unexpectedBeforeClauses: UnexpectedNodesSyntax? = nil, clauses: IfConfigClauseListSyntax, _ unexpectedBetweenClausesAndPoundEndif: UnexpectedNodesSyntax? = nil, poundEndif: TokenSyntax, _ unexpectedAfterPoundEndif: UnexpectedNodesSyntax? = nil) -> IfConfigDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeClauses?.raw,
      clauses.raw,
      unexpectedBetweenClausesAndPoundEndif?.raw,
      poundEndif.raw,
      unexpectedAfterPoundEndif?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifConfigDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IfConfigDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IfConfigDeclSyntax")
  public static func makeBlankIfConfigDecl(presence: SourcePresence = .present) -> IfConfigDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ifConfigDecl,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.ifConfigClauseList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundEndifKeyword, arena: arena),
        nil,
      ], arena: arena))
      return IfConfigDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PoundErrorDeclSyntax")
  public static func makePoundErrorDecl(_ unexpectedBeforePoundError: UnexpectedNodesSyntax? = nil, poundError: TokenSyntax, _ unexpectedBetweenPoundErrorAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? = nil, message: StringLiteralExprSyntax, _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> PoundErrorDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundError?.raw,
      poundError.raw,
      unexpectedBetweenPoundErrorAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndMessage?.raw,
      message.raw,
      unexpectedBetweenMessageAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundErrorDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PoundErrorDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PoundErrorDeclSyntax")
  public static func makeBlankPoundErrorDecl(presence: SourcePresence = .present) -> PoundErrorDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundErrorDecl,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundErrorKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return PoundErrorDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PoundWarningDeclSyntax")
  public static func makePoundWarningDecl(_ unexpectedBeforePoundWarning: UnexpectedNodesSyntax? = nil, poundWarning: TokenSyntax, _ unexpectedBetweenPoundWarningAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndMessage: UnexpectedNodesSyntax? = nil, message: StringLiteralExprSyntax, _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> PoundWarningDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundWarning?.raw,
      poundWarning.raw,
      unexpectedBetweenPoundWarningAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndMessage?.raw,
      message.raw,
      unexpectedBetweenMessageAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundWarningDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PoundWarningDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PoundWarningDeclSyntax")
  public static func makeBlankPoundWarningDecl(presence: SourcePresence = .present) -> PoundWarningDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundWarningDecl,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundWarningKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.stringLiteralExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return PoundWarningDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PoundSourceLocationSyntax")
  public static func makePoundSourceLocation(_ unexpectedBeforePoundSourceLocation: UnexpectedNodesSyntax? = nil, poundSourceLocation: TokenSyntax, _ unexpectedBetweenPoundSourceLocationAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndArgs: UnexpectedNodesSyntax? = nil, args: PoundSourceLocationArgsSyntax?, _ unexpectedBetweenArgsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> PoundSourceLocationSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundSourceLocation?.raw,
      poundSourceLocation.raw,
      unexpectedBetweenPoundSourceLocationAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndArgs?.raw,
      args?.raw,
      unexpectedBetweenArgsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundSourceLocation,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PoundSourceLocationSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PoundSourceLocationSyntax")
  public static func makeBlankPoundSourceLocation(presence: SourcePresence = .present) -> PoundSourceLocationSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundSourceLocation,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundSourceLocationKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return PoundSourceLocationSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PoundSourceLocationArgsSyntax")
  public static func makePoundSourceLocationArgs(_ unexpectedBeforeFileArgLabel: UnexpectedNodesSyntax? = nil, fileArgLabel: TokenSyntax, _ unexpectedBetweenFileArgLabelAndFileArgColon: UnexpectedNodesSyntax? = nil, fileArgColon: TokenSyntax, _ unexpectedBetweenFileArgColonAndFileName: UnexpectedNodesSyntax? = nil, fileName: TokenSyntax, _ unexpectedBetweenFileNameAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax, _ unexpectedBetweenCommaAndLineArgLabel: UnexpectedNodesSyntax? = nil, lineArgLabel: TokenSyntax, _ unexpectedBetweenLineArgLabelAndLineArgColon: UnexpectedNodesSyntax? = nil, lineArgColon: TokenSyntax, _ unexpectedBetweenLineArgColonAndLineNumber: UnexpectedNodesSyntax? = nil, lineNumber: TokenSyntax, _ unexpectedAfterLineNumber: UnexpectedNodesSyntax? = nil) -> PoundSourceLocationArgsSyntax {
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
      unexpectedAfterLineNumber?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundSourceLocationArgs,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PoundSourceLocationArgsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PoundSourceLocationArgsSyntax")
  public static func makeBlankPoundSourceLocationArgs(presence: SourcePresence = .present) -> PoundSourceLocationArgsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundSourceLocationArgs,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.stringLiteral(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: arena),
        nil,
      ], arena: arena))
      return PoundSourceLocationArgsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeclModifierDetailSyntax")
  public static func makeDeclModifierDetail(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndDetail: UnexpectedNodesSyntax? = nil, detail: TokenSyntax, _ unexpectedBetweenDetailAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> DeclModifierDetailSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndDetail?.raw,
      detail.raw,
      unexpectedBetweenDetailAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.declModifierDetail,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeclModifierDetailSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeclModifierDetailSyntax")
  public static func makeBlankDeclModifierDetail(presence: SourcePresence = .present) -> DeclModifierDetailSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declModifierDetail,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return DeclModifierDetailSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeclModifierSyntax")
  public static func makeDeclModifier(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndDetail: UnexpectedNodesSyntax? = nil, detail: DeclModifierDetailSyntax?, _ unexpectedAfterDetail: UnexpectedNodesSyntax? = nil) -> DeclModifierSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndDetail?.raw,
      detail?.raw,
      unexpectedAfterDetail?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.declModifier,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeclModifierSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeclModifierSyntax")
  public static func makeBlankDeclModifier(presence: SourcePresence = .present) -> DeclModifierSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declModifier,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return DeclModifierSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on InheritedTypeSyntax")
  public static func makeInheritedType(_ unexpectedBeforeTypeName: UnexpectedNodesSyntax? = nil, typeName: TypeSyntax, _ unexpectedBetweenTypeNameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> InheritedTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeTypeName?.raw,
      typeName.raw,
      unexpectedBetweenTypeNameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.inheritedType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return InheritedTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on InheritedTypeSyntax")
  public static func makeBlankInheritedType(presence: SourcePresence = .present) -> InheritedTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .inheritedType,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return InheritedTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on InheritedTypeListSyntax")
  public static func makeInheritedTypeList(
    _ elements: [InheritedTypeSyntax]) -> InheritedTypeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.inheritedTypeList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return InheritedTypeListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on InheritedTypeListSyntax")
  public static func makeBlankInheritedTypeList(presence: SourcePresence = .present) -> InheritedTypeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .inheritedTypeList,
        from: [
      ], arena: arena))
      return InheritedTypeListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TypeInheritanceClauseSyntax")
  public static func makeTypeInheritanceClause(_ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndInheritedTypeCollection: UnexpectedNodesSyntax? = nil, inheritedTypeCollection: InheritedTypeListSyntax, _ unexpectedAfterInheritedTypeCollection: UnexpectedNodesSyntax? = nil) -> TypeInheritanceClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndInheritedTypeCollection?.raw,
      inheritedTypeCollection.raw,
      unexpectedAfterInheritedTypeCollection?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeInheritanceClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TypeInheritanceClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TypeInheritanceClauseSyntax")
  public static func makeBlankTypeInheritanceClause(presence: SourcePresence = .present) -> TypeInheritanceClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typeInheritanceClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.inheritedTypeList, arena: arena),
        nil,
      ], arena: arena))
      return TypeInheritanceClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClassDeclSyntax")
  public static func makeClassDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndClassKeyword: UnexpectedNodesSyntax? = nil, classKeyword: TokenSyntax, _ unexpectedBetweenClassKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax, _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil) -> ClassDeclSyntax {
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
      unexpectedAfterMembers?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.classDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClassDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClassDeclSyntax")
  public static func makeBlankClassDecl(presence: SourcePresence = .present) -> ClassDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .classDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.classKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena),
        nil,
      ], arena: arena))
      return ClassDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ActorDeclSyntax")
  public static func makeActorDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndActorKeyword: UnexpectedNodesSyntax? = nil, actorKeyword: TokenSyntax, _ unexpectedBetweenActorKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax, _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil) -> ActorDeclSyntax {
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
      unexpectedAfterMembers?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.actorDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ActorDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ActorDeclSyntax")
  public static func makeBlankActorDecl(presence: SourcePresence = .present) -> ActorDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .actorDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena),
        nil,
      ], arena: arena))
      return ActorDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on StructDeclSyntax")
  public static func makeStructDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndStructKeyword: UnexpectedNodesSyntax? = nil, structKeyword: TokenSyntax, _ unexpectedBetweenStructKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax, _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil) -> StructDeclSyntax {
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
      unexpectedAfterMembers?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.structDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return StructDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on StructDeclSyntax")
  public static func makeBlankStructDecl(presence: SourcePresence = .present) -> StructDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .structDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.structKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena),
        nil,
      ], arena: arena))
      return StructDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ProtocolDeclSyntax")
  public static func makeProtocolDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndProtocolKeyword: UnexpectedNodesSyntax? = nil, protocolKeyword: TokenSyntax, _ unexpectedBetweenProtocolKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndPrimaryAssociatedTypeClause: UnexpectedNodesSyntax? = nil, primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax?, _ unexpectedBetweenPrimaryAssociatedTypeClauseAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax, _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil) -> ProtocolDeclSyntax {
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
      unexpectedAfterMembers?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.protocolDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ProtocolDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ProtocolDeclSyntax")
  public static func makeBlankProtocolDecl(presence: SourcePresence = .present) -> ProtocolDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .protocolDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.protocolKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena),
        nil,
      ], arena: arena))
      return ProtocolDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ExtensionDeclSyntax")
  public static func makeExtensionDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndExtensionKeyword: UnexpectedNodesSyntax? = nil, extensionKeyword: TokenSyntax, _ unexpectedBetweenExtensionKeywordAndExtendedType: UnexpectedNodesSyntax? = nil, extendedType: TypeSyntax, _ unexpectedBetweenExtendedTypeAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax, _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil) -> ExtensionDeclSyntax {
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
      unexpectedAfterMembers?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.extensionDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ExtensionDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ExtensionDeclSyntax")
  public static func makeBlankExtensionDecl(presence: SourcePresence = .present) -> ExtensionDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .extensionDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.extensionKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena),
        nil,
      ], arena: arena))
      return ExtensionDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclBlockSyntax")
  public static func makeMemberDeclBlock(_ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclListSyntax, _ unexpectedBetweenMembersAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax, _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil) -> MemberDeclBlockSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndMembers?.raw,
      members.raw,
      unexpectedBetweenMembersAndRightBrace?.raw,
      rightBrace.raw,
      unexpectedAfterRightBrace?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclBlock,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MemberDeclBlockSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclBlockSyntax")
  public static func makeBlankMemberDeclBlock(presence: SourcePresence = .present) -> MemberDeclBlockSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberDeclBlock,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: arena),
        nil,
      ], arena: arena))
      return MemberDeclBlockSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclListSyntax")
  public static func makeMemberDeclList(
    _ elements: [MemberDeclListItemSyntax]) -> MemberDeclListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MemberDeclListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclListSyntax")
  public static func makeBlankMemberDeclList(presence: SourcePresence = .present) -> MemberDeclListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberDeclList,
        from: [
      ], arena: arena))
      return MemberDeclListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MemberDeclListItemSyntax")
  public static func makeMemberDeclListItem(_ unexpectedBeforeDecl: UnexpectedNodesSyntax? = nil, decl: DeclSyntax, _ unexpectedBetweenDeclAndSemicolon: UnexpectedNodesSyntax? = nil, semicolon: TokenSyntax?, _ unexpectedAfterSemicolon: UnexpectedNodesSyntax? = nil) -> MemberDeclListItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDecl?.raw,
      decl.raw,
      unexpectedBetweenDeclAndSemicolon?.raw,
      semicolon?.raw,
      unexpectedAfterSemicolon?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberDeclListItem,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MemberDeclListItemSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MemberDeclListItemSyntax")
  public static func makeBlankMemberDeclListItem(presence: SourcePresence = .present) -> MemberDeclListItemSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberDeclListItem,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingDecl, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return MemberDeclListItemSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SourceFileSyntax")
  public static func makeSourceFile(_ unexpectedBeforeStatements: UnexpectedNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ unexpectedBetweenStatementsAndEOFToken: UnexpectedNodesSyntax? = nil, eofToken: TokenSyntax, _ unexpectedAfterEOFToken: UnexpectedNodesSyntax? = nil) -> SourceFileSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeStatements?.raw,
      statements.raw,
      unexpectedBetweenStatementsAndEOFToken?.raw,
      eofToken.raw,
      unexpectedAfterEOFToken?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.sourceFile,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SourceFileSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SourceFileSyntax")
  public static func makeBlankSourceFile(presence: SourcePresence = .present) -> SourceFileSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .sourceFile,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
      ], arena: arena))
      return SourceFileSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on InitializerClauseSyntax")
  public static func makeInitializerClause(_ unexpectedBeforeEqual: UnexpectedNodesSyntax? = nil, equal: TokenSyntax, _ unexpectedBetweenEqualAndValue: UnexpectedNodesSyntax? = nil, value: ExprSyntax, _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil) -> InitializerClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEqual?.raw,
      equal.raw,
      unexpectedBetweenEqualAndValue?.raw,
      value.raw,
      unexpectedAfterValue?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.initializerClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return InitializerClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on InitializerClauseSyntax")
  public static func makeBlankInitializerClause(presence: SourcePresence = .present) -> InitializerClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .initializerClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.equal, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return InitializerClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FunctionParameterSyntax")
  public static func makeFunctionParameter(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndFirstName: UnexpectedNodesSyntax? = nil, firstName: TokenSyntax?, _ unexpectedBetweenFirstNameAndSecondName: UnexpectedNodesSyntax? = nil, secondName: TokenSyntax?, _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax?, _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil, ellipsis: TokenSyntax?, _ unexpectedBetweenEllipsisAndDefaultArgument: UnexpectedNodesSyntax? = nil, defaultArgument: InitializerClauseSyntax?, _ unexpectedBetweenDefaultArgumentAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> FunctionParameterSyntax {
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
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionParameter,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FunctionParameterSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FunctionParameterSyntax")
  public static func makeBlankFunctionParameter(presence: SourcePresence = .present) -> FunctionParameterSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
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
        nil,
      ], arena: arena))
      return FunctionParameterSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ModifierListSyntax")
  public static func makeModifierList(
    _ elements: [DeclModifierSyntax]) -> ModifierListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.modifierList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ModifierListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ModifierListSyntax")
  public static func makeBlankModifierList(presence: SourcePresence = .present) -> ModifierListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .modifierList,
        from: [
      ], arena: arena))
      return ModifierListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FunctionDeclSyntax")
  public static func makeFunctionDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndFuncKeyword: UnexpectedNodesSyntax? = nil, funcKeyword: TokenSyntax, _ unexpectedBetweenFuncKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil, signature: FunctionSignatureSyntax, _ unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax?, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> FunctionDeclSyntax {
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
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FunctionDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FunctionDeclSyntax")
  public static func makeBlankFunctionDecl(presence: SourcePresence = .present) -> FunctionDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.funcKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionSignature, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return FunctionDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on InitializerDeclSyntax")
  public static func makeInitializerDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndInitKeyword: UnexpectedNodesSyntax? = nil, initKeyword: TokenSyntax, _ unexpectedBetweenInitKeywordAndOptionalMark: UnexpectedNodesSyntax? = nil, optionalMark: TokenSyntax?, _ unexpectedBetweenOptionalMarkAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil, signature: FunctionSignatureSyntax, _ unexpectedBetweenSignatureAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax?, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> InitializerDeclSyntax {
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
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.initializerDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return InitializerDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on InitializerDeclSyntax")
  public static func makeBlankInitializerDecl(presence: SourcePresence = .present) -> InitializerDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .initializerDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.initKeyword, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.functionSignature, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return InitializerDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeinitializerDeclSyntax")
  public static func makeDeinitializerDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndDeinitKeyword: UnexpectedNodesSyntax? = nil, deinitKeyword: TokenSyntax, _ unexpectedBetweenDeinitKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax?, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> DeinitializerDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndDeinitKeyword?.raw,
      deinitKeyword.raw,
      unexpectedBetweenDeinitKeywordAndBody?.raw,
      body?.raw,
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.deinitializerDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeinitializerDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeinitializerDeclSyntax")
  public static func makeBlankDeinitializerDecl(presence: SourcePresence = .present) -> DeinitializerDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .deinitializerDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.deinitKeyword, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return DeinitializerDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SubscriptDeclSyntax")
  public static func makeSubscriptDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndSubscriptKeyword: UnexpectedNodesSyntax? = nil, subscriptKeyword: TokenSyntax, _ unexpectedBetweenSubscriptKeywordAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndIndices: UnexpectedNodesSyntax? = nil, indices: ParameterClauseSyntax, _ unexpectedBetweenIndicesAndResult: UnexpectedNodesSyntax? = nil, result: ReturnClauseSyntax, _ unexpectedBetweenResultAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndAccessor: UnexpectedNodesSyntax? = nil, accessor: Syntax?, _ unexpectedAfterAccessor: UnexpectedNodesSyntax? = nil) -> SubscriptDeclSyntax {
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
      unexpectedAfterAccessor?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.subscriptDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SubscriptDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SubscriptDeclSyntax")
  public static func makeBlankSubscriptDecl(presence: SourcePresence = .present) -> SubscriptDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .subscriptDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.subscriptKeyword, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.parameterClause, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.returnClause, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return SubscriptDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AccessLevelModifierSyntax")
  public static func makeAccessLevelModifier(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndModifier: UnexpectedNodesSyntax? = nil, modifier: DeclModifierDetailSyntax?, _ unexpectedAfterModifier: UnexpectedNodesSyntax? = nil) -> AccessLevelModifierSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndModifier?.raw,
      modifier?.raw,
      unexpectedAfterModifier?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessLevelModifier,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AccessLevelModifierSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AccessLevelModifierSyntax")
  public static func makeBlankAccessLevelModifier(presence: SourcePresence = .present) -> AccessLevelModifierSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessLevelModifier,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return AccessLevelModifierSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AccessPathComponentSyntax")
  public static func makeAccessPathComponent(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndTrailingDot: UnexpectedNodesSyntax? = nil, trailingDot: TokenSyntax?, _ unexpectedAfterTrailingDot: UnexpectedNodesSyntax? = nil) -> AccessPathComponentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingDot?.raw,
      trailingDot?.raw,
      unexpectedAfterTrailingDot?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessPathComponent,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AccessPathComponentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AccessPathComponentSyntax")
  public static func makeBlankAccessPathComponent(presence: SourcePresence = .present) -> AccessPathComponentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessPathComponent,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return AccessPathComponentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AccessPathSyntax")
  public static func makeAccessPath(
    _ elements: [AccessPathComponentSyntax]) -> AccessPathSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessPath,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AccessPathSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AccessPathSyntax")
  public static func makeBlankAccessPath(presence: SourcePresence = .present) -> AccessPathSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessPath,
        from: [
      ], arena: arena))
      return AccessPathSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ImportDeclSyntax")
  public static func makeImportDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndImportTok: UnexpectedNodesSyntax? = nil, importTok: TokenSyntax, _ unexpectedBetweenImportTokAndImportKind: UnexpectedNodesSyntax? = nil, importKind: TokenSyntax?, _ unexpectedBetweenImportKindAndPath: UnexpectedNodesSyntax? = nil, path: AccessPathSyntax, _ unexpectedAfterPath: UnexpectedNodesSyntax? = nil) -> ImportDeclSyntax {
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
      unexpectedAfterPath?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.importDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ImportDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ImportDeclSyntax")
  public static func makeBlankImportDecl(presence: SourcePresence = .present) -> ImportDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .importDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.importKeyword, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.accessPath, arena: arena),
        nil,
      ], arena: arena))
      return ImportDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AccessorParameterSyntax")
  public static func makeAccessorParameter(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> AccessorParameterSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorParameter,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AccessorParameterSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AccessorParameterSyntax")
  public static func makeBlankAccessorParameter(presence: SourcePresence = .present) -> AccessorParameterSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessorParameter,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return AccessorParameterSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AccessorDeclSyntax")
  public static func makeAccessorDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifier: UnexpectedNodesSyntax? = nil, modifier: DeclModifierSyntax?, _ unexpectedBetweenModifierAndAccessorKind: UnexpectedNodesSyntax? = nil, accessorKind: TokenSyntax, _ unexpectedBetweenAccessorKindAndParameter: UnexpectedNodesSyntax? = nil, parameter: AccessorParameterSyntax?, _ unexpectedBetweenParameterAndAsyncKeyword: UnexpectedNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncKeywordAndThrowsKeyword: UnexpectedNodesSyntax? = nil, throwsKeyword: TokenSyntax?, _ unexpectedBetweenThrowsKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax?, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> AccessorDeclSyntax {
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
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AccessorDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AccessorDeclSyntax")
  public static func makeBlankAccessorDecl(presence: SourcePresence = .present) -> AccessorDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessorDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return AccessorDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AccessorListSyntax")
  public static func makeAccessorList(
    _ elements: [AccessorDeclSyntax]) -> AccessorListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AccessorListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AccessorListSyntax")
  public static func makeBlankAccessorList(presence: SourcePresence = .present) -> AccessorListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessorList,
        from: [
      ], arena: arena))
      return AccessorListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AccessorBlockSyntax")
  public static func makeAccessorBlock(_ unexpectedBeforeLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndAccessors: UnexpectedNodesSyntax? = nil, accessors: AccessorListSyntax, _ unexpectedBetweenAccessorsAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax, _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil) -> AccessorBlockSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftBrace?.raw,
      leftBrace.raw,
      unexpectedBetweenLeftBraceAndAccessors?.raw,
      accessors.raw,
      unexpectedBetweenAccessorsAndRightBrace?.raw,
      rightBrace.raw,
      unexpectedAfterRightBrace?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.accessorBlock,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AccessorBlockSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AccessorBlockSyntax")
  public static func makeBlankAccessorBlock(presence: SourcePresence = .present) -> AccessorBlockSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .accessorBlock,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.accessorList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: arena),
        nil,
      ], arena: arena))
      return AccessorBlockSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PatternBindingSyntax")
  public static func makePatternBinding(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil, initializer: InitializerClauseSyntax?, _ unexpectedBetweenInitializerAndAccessor: UnexpectedNodesSyntax? = nil, accessor: Syntax?, _ unexpectedBetweenAccessorAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> PatternBindingSyntax {
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
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.patternBinding,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PatternBindingSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PatternBindingSyntax")
  public static func makeBlankPatternBinding(presence: SourcePresence = .present) -> PatternBindingSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .patternBinding,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return PatternBindingSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PatternBindingListSyntax")
  public static func makePatternBindingList(
    _ elements: [PatternBindingSyntax]) -> PatternBindingListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.patternBindingList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PatternBindingListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PatternBindingListSyntax")
  public static func makeBlankPatternBindingList(presence: SourcePresence = .present) -> PatternBindingListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .patternBindingList,
        from: [
      ], arena: arena))
      return PatternBindingListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on VariableDeclSyntax")
  public static func makeVariableDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndLetOrVarKeyword: UnexpectedNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ unexpectedBetweenLetOrVarKeywordAndBindings: UnexpectedNodesSyntax? = nil, bindings: PatternBindingListSyntax, _ unexpectedAfterBindings: UnexpectedNodesSyntax? = nil) -> VariableDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      unexpectedBetweenLetOrVarKeywordAndBindings?.raw,
      bindings.raw,
      unexpectedAfterBindings?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.variableDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return VariableDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on VariableDeclSyntax")
  public static func makeBlankVariableDecl(presence: SourcePresence = .present) -> VariableDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .variableDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.patternBindingList, arena: arena),
        nil,
      ], arena: arena))
      return VariableDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseElementSyntax")
  public static func makeEnumCaseElement(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndAssociatedValue: UnexpectedNodesSyntax? = nil, associatedValue: ParameterClauseSyntax?, _ unexpectedBetweenAssociatedValueAndRawValue: UnexpectedNodesSyntax? = nil, rawValue: InitializerClauseSyntax?, _ unexpectedBetweenRawValueAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> EnumCaseElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndAssociatedValue?.raw,
      associatedValue?.raw,
      unexpectedBetweenAssociatedValueAndRawValue?.raw,
      rawValue?.raw,
      unexpectedBetweenRawValueAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return EnumCaseElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseElementSyntax")
  public static func makeBlankEnumCaseElement(presence: SourcePresence = .present) -> EnumCaseElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumCaseElement,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return EnumCaseElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseElementListSyntax")
  public static func makeEnumCaseElementList(
    _ elements: [EnumCaseElementSyntax]) -> EnumCaseElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return EnumCaseElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseElementListSyntax")
  public static func makeBlankEnumCaseElementList(presence: SourcePresence = .present) -> EnumCaseElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumCaseElementList,
        from: [
      ], arena: arena))
      return EnumCaseElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on EnumCaseDeclSyntax")
  public static func makeEnumCaseDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndCaseKeyword: UnexpectedNodesSyntax? = nil, caseKeyword: TokenSyntax, _ unexpectedBetweenCaseKeywordAndElements: UnexpectedNodesSyntax? = nil, elements: EnumCaseElementListSyntax, _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil) -> EnumCaseDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndCaseKeyword?.raw,
      caseKeyword.raw,
      unexpectedBetweenCaseKeywordAndElements?.raw,
      elements.raw,
      unexpectedAfterElements?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCaseDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return EnumCaseDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on EnumCaseDeclSyntax")
  public static func makeBlankEnumCaseDecl(presence: SourcePresence = .present) -> EnumCaseDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumCaseDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.enumCaseElementList, arena: arena),
        nil,
      ], arena: arena))
      return EnumCaseDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on EnumDeclSyntax")
  public static func makeEnumDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndEnumKeyword: UnexpectedNodesSyntax? = nil, enumKeyword: TokenSyntax, _ unexpectedBetweenEnumKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameters: UnexpectedNodesSyntax? = nil, genericParameters: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParametersAndInheritanceClause: UnexpectedNodesSyntax? = nil, inheritanceClause: TypeInheritanceClauseSyntax?, _ unexpectedBetweenInheritanceClauseAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndMembers: UnexpectedNodesSyntax? = nil, members: MemberDeclBlockSyntax, _ unexpectedAfterMembers: UnexpectedNodesSyntax? = nil) -> EnumDeclSyntax {
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
      unexpectedAfterMembers?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return EnumDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on EnumDeclSyntax")
  public static func makeBlankEnumDecl(presence: SourcePresence = .present) -> EnumDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.enumKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.memberDeclBlock, arena: arena),
        nil,
      ], arena: arena))
      return EnumDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on OperatorDeclSyntax")
  public static func makeOperatorDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndOperatorKeyword: UnexpectedNodesSyntax? = nil, operatorKeyword: TokenSyntax, _ unexpectedBetweenOperatorKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? = nil, operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax?, _ unexpectedAfterOperatorPrecedenceAndTypes: UnexpectedNodesSyntax? = nil) -> OperatorDeclSyntax {
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
      unexpectedAfterOperatorPrecedenceAndTypes?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.operatorDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return OperatorDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on OperatorDeclSyntax")
  public static func makeBlankOperatorDecl(presence: SourcePresence = .present) -> OperatorDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .operatorDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.operatorKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unspacedBinaryOperator(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return OperatorDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DesignatedTypeListSyntax")
  public static func makeDesignatedTypeList(
    _ elements: [DesignatedTypeElementSyntax]) -> DesignatedTypeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.designatedTypeList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DesignatedTypeListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DesignatedTypeListSyntax")
  public static func makeBlankDesignatedTypeList(presence: SourcePresence = .present) -> DesignatedTypeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .designatedTypeList,
        from: [
      ], arena: arena))
      return DesignatedTypeListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DesignatedTypeElementSyntax")
  public static func makeDesignatedTypeElement(_ unexpectedBeforeLeadingComma: UnexpectedNodesSyntax? = nil, leadingComma: TokenSyntax, _ unexpectedBetweenLeadingCommaAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedAfterName: UnexpectedNodesSyntax? = nil) -> DesignatedTypeElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeadingComma?.raw,
      leadingComma.raw,
      unexpectedBetweenLeadingCommaAndName?.raw,
      name.raw,
      unexpectedAfterName?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.designatedTypeElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DesignatedTypeElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DesignatedTypeElementSyntax")
  public static func makeBlankDesignatedTypeElement(presence: SourcePresence = .present) -> DesignatedTypeElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .designatedTypeElement,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
      ], arena: arena))
      return DesignatedTypeElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on OperatorPrecedenceAndTypesSyntax")
  public static func makeOperatorPrecedenceAndTypes(_ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndPrecedenceGroup: UnexpectedNodesSyntax? = nil, precedenceGroup: TokenSyntax, _ unexpectedBetweenPrecedenceGroupAndDesignatedTypes: UnexpectedNodesSyntax? = nil, designatedTypes: DesignatedTypeListSyntax, _ unexpectedAfterDesignatedTypes: UnexpectedNodesSyntax? = nil) -> OperatorPrecedenceAndTypesSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndPrecedenceGroup?.raw,
      precedenceGroup.raw,
      unexpectedBetweenPrecedenceGroupAndDesignatedTypes?.raw,
      designatedTypes.raw,
      unexpectedAfterDesignatedTypes?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.operatorPrecedenceAndTypes,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return OperatorPrecedenceAndTypesSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on OperatorPrecedenceAndTypesSyntax")
  public static func makeBlankOperatorPrecedenceAndTypes(presence: SourcePresence = .present) -> OperatorPrecedenceAndTypesSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .operatorPrecedenceAndTypes,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.designatedTypeList, arena: arena),
        nil,
      ], arena: arena))
      return OperatorPrecedenceAndTypesSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupDeclSyntax")
  public static func makePrecedenceGroupDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndPrecedencegroupKeyword: UnexpectedNodesSyntax? = nil, precedencegroupKeyword: TokenSyntax, _ unexpectedBetweenPrecedencegroupKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndGroupAttributes: UnexpectedNodesSyntax? = nil, groupAttributes: PrecedenceGroupAttributeListSyntax, _ unexpectedBetweenGroupAttributesAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax, _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil) -> PrecedenceGroupDeclSyntax {
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
      unexpectedAfterRightBrace?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrecedenceGroupDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupDeclSyntax")
  public static func makeBlankPrecedenceGroupDecl(presence: SourcePresence = .present) -> PrecedenceGroupDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.precedencegroupKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.precedenceGroupAttributeList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: arena),
        nil,
      ], arena: arena))
      return PrecedenceGroupDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAttributeListSyntax")
  public static func makePrecedenceGroupAttributeList(
    _ elements: [Syntax]) -> PrecedenceGroupAttributeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAttributeList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrecedenceGroupAttributeListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAttributeListSyntax")
  public static func makeBlankPrecedenceGroupAttributeList(presence: SourcePresence = .present) -> PrecedenceGroupAttributeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupAttributeList,
        from: [
      ], arena: arena))
      return PrecedenceGroupAttributeListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupRelationSyntax")
  public static func makePrecedenceGroupRelation(_ unexpectedBeforeHigherThanOrLowerThan: UnexpectedNodesSyntax? = nil, higherThanOrLowerThan: TokenSyntax, _ unexpectedBetweenHigherThanOrLowerThanAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndOtherNames: UnexpectedNodesSyntax? = nil, otherNames: PrecedenceGroupNameListSyntax, _ unexpectedAfterOtherNames: UnexpectedNodesSyntax? = nil) -> PrecedenceGroupRelationSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeHigherThanOrLowerThan?.raw,
      higherThanOrLowerThan.raw,
      unexpectedBetweenHigherThanOrLowerThanAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndOtherNames?.raw,
      otherNames.raw,
      unexpectedAfterOtherNames?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupRelation,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrecedenceGroupRelationSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupRelationSyntax")
  public static func makeBlankPrecedenceGroupRelation(presence: SourcePresence = .present) -> PrecedenceGroupRelationSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupRelation,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.precedenceGroupNameList, arena: arena),
        nil,
      ], arena: arena))
      return PrecedenceGroupRelationSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameListSyntax")
  public static func makePrecedenceGroupNameList(
    _ elements: [PrecedenceGroupNameElementSyntax]) -> PrecedenceGroupNameListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupNameList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrecedenceGroupNameListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameListSyntax")
  public static func makeBlankPrecedenceGroupNameList(presence: SourcePresence = .present) -> PrecedenceGroupNameListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupNameList,
        from: [
      ], arena: arena))
      return PrecedenceGroupNameListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameElementSyntax")
  public static func makePrecedenceGroupNameElement(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> PrecedenceGroupNameElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupNameElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrecedenceGroupNameElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupNameElementSyntax")
  public static func makeBlankPrecedenceGroupNameElement(presence: SourcePresence = .present) -> PrecedenceGroupNameElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupNameElement,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return PrecedenceGroupNameElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssignmentSyntax")
  public static func makePrecedenceGroupAssignment(_ unexpectedBeforeAssignmentKeyword: UnexpectedNodesSyntax? = nil, assignmentKeyword: TokenSyntax, _ unexpectedBetweenAssignmentKeywordAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndFlag: UnexpectedNodesSyntax? = nil, flag: TokenSyntax, _ unexpectedAfterFlag: UnexpectedNodesSyntax? = nil) -> PrecedenceGroupAssignmentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssignmentKeyword?.raw,
      assignmentKeyword.raw,
      unexpectedBetweenAssignmentKeywordAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndFlag?.raw,
      flag.raw,
      unexpectedAfterFlag?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAssignment,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrecedenceGroupAssignmentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssignmentSyntax")
  public static func makeBlankPrecedenceGroupAssignment(presence: SourcePresence = .present) -> PrecedenceGroupAssignmentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupAssignment,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.trueKeyword, arena: arena),
        nil,
      ], arena: arena))
      return PrecedenceGroupAssignmentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssociativitySyntax")
  public static func makePrecedenceGroupAssociativity(_ unexpectedBeforeAssociativityKeyword: UnexpectedNodesSyntax? = nil, associativityKeyword: TokenSyntax, _ unexpectedBetweenAssociativityKeywordAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil, value: TokenSyntax, _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil) -> PrecedenceGroupAssociativitySyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAssociativityKeyword?.raw,
      associativityKeyword.raw,
      unexpectedBetweenAssociativityKeywordAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValue?.raw,
      value.raw,
      unexpectedAfterValue?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.precedenceGroupAssociativity,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrecedenceGroupAssociativitySyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrecedenceGroupAssociativitySyntax")
  public static func makeBlankPrecedenceGroupAssociativity(presence: SourcePresence = .present) -> PrecedenceGroupAssociativitySyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .precedenceGroupAssociativity,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
      ], arena: arena))
      return PrecedenceGroupAssociativitySyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MacroDeclSyntax")
  public static func makeMacroDecl(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndModifiers: UnexpectedNodesSyntax? = nil, modifiers: ModifierListSyntax?, _ unexpectedBetweenModifiersAndMacroKeyword: UnexpectedNodesSyntax? = nil, macroKeyword: TokenSyntax, _ unexpectedBetweenMacroKeywordAndIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedBetweenIdentifierAndGenericParameterClause: UnexpectedNodesSyntax? = nil, genericParameterClause: GenericParameterClauseSyntax?, _ unexpectedBetweenGenericParameterClauseAndSignature: UnexpectedNodesSyntax? = nil, signature: Syntax, _ unexpectedBetweenSignatureAndDefinition: UnexpectedNodesSyntax? = nil, definition: InitializerClauseSyntax?, _ unexpectedBetweenDefinitionAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedAfterGenericWhereClause: UnexpectedNodesSyntax? = nil) -> MacroDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndModifiers?.raw,
      modifiers?.raw,
      unexpectedBetweenModifiersAndMacroKeyword?.raw,
      macroKeyword.raw,
      unexpectedBetweenMacroKeywordAndIdentifier?.raw,
      identifier.raw,
      unexpectedBetweenIdentifierAndGenericParameterClause?.raw,
      genericParameterClause?.raw,
      unexpectedBetweenGenericParameterClauseAndSignature?.raw,
      signature.raw,
      unexpectedBetweenSignatureAndDefinition?.raw,
      definition?.raw,
      unexpectedBetweenDefinitionAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedAfterGenericWhereClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.macroDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MacroDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MacroDeclSyntax")
  public static func makeBlankMacroDecl(presence: SourcePresence = .present) -> MacroDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .macroDecl,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.contextualKeyword(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return MacroDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MacroExpansionDeclSyntax")
  public static func makeMacroExpansionDecl(_ unexpectedBeforePoundToken: UnexpectedNodesSyntax? = nil, poundToken: TokenSyntax, _ unexpectedBetweenPoundTokenAndMacro: UnexpectedNodesSyntax? = nil, macro: TokenSyntax, _ unexpectedBetweenMacroAndGenericArguments: UnexpectedNodesSyntax? = nil, genericArguments: GenericArgumentClauseSyntax?, _ unexpectedBetweenGenericArgumentsAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax, _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?, _ unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil, trailingClosure: ClosureExprSyntax?, _ unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?, _ unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil) -> MacroExpansionDeclSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundToken?.raw,
      poundToken.raw,
      unexpectedBetweenPoundTokenAndMacro?.raw,
      macro.raw,
      unexpectedBetweenMacroAndGenericArguments?.raw,
      genericArguments?.raw,
      unexpectedBetweenGenericArgumentsAndLeftParen?.raw,
      leftParen?.raw,
      unexpectedBetweenLeftParenAndArgumentList?.raw,
      argumentList.raw,
      unexpectedBetweenArgumentListAndRightParen?.raw,
      rightParen?.raw,
      unexpectedBetweenRightParenAndTrailingClosure?.raw,
      trailingClosure?.raw,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures?.raw,
      additionalTrailingClosures?.raw,
      unexpectedAfterAdditionalTrailingClosures?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.macroExpansionDecl,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MacroExpansionDeclSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MacroExpansionDeclSyntax")
  public static func makeBlankMacroExpansionDecl(presence: SourcePresence = .present) -> MacroExpansionDeclSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .macroExpansionDecl,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.pound, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleExprElementList, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return MacroExpansionDeclSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TokenListSyntax")
  public static func makeTokenList(
    _ elements: [TokenSyntax]) -> TokenListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tokenList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TokenListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TokenListSyntax")
  public static func makeBlankTokenList(presence: SourcePresence = .present) -> TokenListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tokenList,
        from: [
      ], arena: arena))
      return TokenListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on NonEmptyTokenListSyntax")
  public static func makeNonEmptyTokenList(
    _ elements: [TokenSyntax]) -> NonEmptyTokenListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.nonEmptyTokenList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return NonEmptyTokenListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on NonEmptyTokenListSyntax")
  public static func makeBlankNonEmptyTokenList(presence: SourcePresence = .present) -> NonEmptyTokenListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .nonEmptyTokenList,
        from: [
      ], arena: arena))
      return NonEmptyTokenListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CustomAttributeSyntax")
  public static func makeCustomAttribute(_ unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? = nil, atSignToken: TokenSyntax, _ unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? = nil, attributeName: TypeSyntax, _ unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndArgumentList: UnexpectedNodesSyntax? = nil, argumentList: TupleExprElementListSyntax?, _ unexpectedBetweenArgumentListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> CustomAttributeSyntax {
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
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.customAttribute,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CustomAttributeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CustomAttributeSyntax")
  public static func makeBlankCustomAttribute(presence: SourcePresence = .present) -> CustomAttributeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .customAttribute,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.atSign, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return CustomAttributeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AttributeSyntax")
  public static func makeAttribute(_ unexpectedBeforeAtSignToken: UnexpectedNodesSyntax? = nil, atSignToken: TokenSyntax, _ unexpectedBetweenAtSignTokenAndAttributeName: UnexpectedNodesSyntax? = nil, attributeName: TokenSyntax, _ unexpectedBetweenAttributeNameAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndArgument: UnexpectedNodesSyntax? = nil, argument: Syntax?, _ unexpectedBetweenArgumentAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?, _ unexpectedBetweenRightParenAndTokenList: UnexpectedNodesSyntax? = nil, tokenList: TokenListSyntax?, _ unexpectedAfterTokenList: UnexpectedNodesSyntax? = nil) -> AttributeSyntax {
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
      unexpectedAfterTokenList?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.attribute,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AttributeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AttributeSyntax")
  public static func makeBlankAttribute(presence: SourcePresence = .present) -> AttributeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .attribute,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.atSign, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return AttributeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AttributeListSyntax")
  public static func makeAttributeList(
    _ elements: [Syntax]) -> AttributeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.attributeList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AttributeListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AttributeListSyntax")
  public static func makeBlankAttributeList(presence: SourcePresence = .present) -> AttributeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .attributeList,
        from: [
      ], arena: arena))
      return AttributeListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SpecializeAttributeSpecListSyntax")
  public static func makeSpecializeAttributeSpecList(
    _ elements: [Syntax]) -> SpecializeAttributeSpecListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.specializeAttributeSpecList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SpecializeAttributeSpecListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SpecializeAttributeSpecListSyntax")
  public static func makeBlankSpecializeAttributeSpecList(presence: SourcePresence = .present) -> SpecializeAttributeSpecListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .specializeAttributeSpecList,
        from: [
      ], arena: arena))
      return SpecializeAttributeSpecListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityEntrySyntax")
  public static func makeAvailabilityEntry(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndAvailabilityList: UnexpectedNodesSyntax? = nil, availabilityList: AvailabilitySpecListSyntax, _ unexpectedBetweenAvailabilityListAndSemicolon: UnexpectedNodesSyntax? = nil, semicolon: TokenSyntax, _ unexpectedAfterSemicolon: UnexpectedNodesSyntax? = nil) -> AvailabilityEntrySyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndAvailabilityList?.raw,
      availabilityList.raw,
      unexpectedBetweenAvailabilityListAndSemicolon?.raw,
      semicolon.raw,
      unexpectedAfterSemicolon?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityEntry,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AvailabilityEntrySyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityEntrySyntax")
  public static func makeBlankAvailabilityEntry(presence: SourcePresence = .present) -> AvailabilityEntrySyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityEntry,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.semicolon, arena: arena),
        nil,
      ], arena: arena))
      return AvailabilityEntrySyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on LabeledSpecializeEntrySyntax")
  public static func makeLabeledSpecializeEntry(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil, value: TokenSyntax, _ unexpectedBetweenValueAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> LabeledSpecializeEntrySyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValue?.raw,
      value.raw,
      unexpectedBetweenValueAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.labeledSpecializeEntry,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return LabeledSpecializeEntrySyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on LabeledSpecializeEntrySyntax")
  public static func makeBlankLabeledSpecializeEntry(presence: SourcePresence = .present) -> LabeledSpecializeEntrySyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .labeledSpecializeEntry,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return LabeledSpecializeEntrySyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TargetFunctionEntrySyntax")
  public static func makeTargetFunctionEntry(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndDeclname: UnexpectedNodesSyntax? = nil, declname: DeclNameSyntax, _ unexpectedBetweenDeclnameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> TargetFunctionEntrySyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndDeclname?.raw,
      declname.raw,
      unexpectedBetweenDeclnameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.targetFunctionEntry,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TargetFunctionEntrySyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TargetFunctionEntrySyntax")
  public static func makeBlankTargetFunctionEntry(presence: SourcePresence = .present) -> TargetFunctionEntrySyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .targetFunctionEntry,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.declName, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return TargetFunctionEntrySyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on NamedAttributeStringArgumentSyntax")
  public static func makeNamedAttributeStringArgument(_ unexpectedBeforeNameTok: UnexpectedNodesSyntax? = nil, nameTok: TokenSyntax, _ unexpectedBetweenNameTokAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndStringOrDeclname: UnexpectedNodesSyntax? = nil, stringOrDeclname: Syntax, _ unexpectedAfterStringOrDeclname: UnexpectedNodesSyntax? = nil) -> NamedAttributeStringArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeNameTok?.raw,
      nameTok.raw,
      unexpectedBetweenNameTokAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndStringOrDeclname?.raw,
      stringOrDeclname.raw,
      unexpectedAfterStringOrDeclname?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.namedAttributeStringArgument,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return NamedAttributeStringArgumentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on NamedAttributeStringArgumentSyntax")
  public static func makeBlankNamedAttributeStringArgument(presence: SourcePresence = .present) -> NamedAttributeStringArgumentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .namedAttributeStringArgument,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
      ], arena: arena))
      return NamedAttributeStringArgumentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeclNameSyntax")
  public static func makeDeclName(_ unexpectedBeforeDeclBaseName: UnexpectedNodesSyntax? = nil, declBaseName: TokenSyntax, _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?, _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil) -> DeclNameSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDeclBaseName?.raw,
      declBaseName.raw,
      unexpectedBetweenDeclBaseNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
      unexpectedAfterDeclNameArguments?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.declName,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeclNameSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeclNameSyntax")
  public static func makeBlankDeclName(presence: SourcePresence = .present) -> DeclNameSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declName,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return DeclNameSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ImplementsAttributeArgumentsSyntax")
  public static func makeImplementsAttributeArguments(_ unexpectedBeforeType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedBetweenTypeAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax, _ unexpectedBetweenCommaAndDeclBaseName: UnexpectedNodesSyntax? = nil, declBaseName: TokenSyntax, _ unexpectedBetweenDeclBaseNameAndDeclNameArguments: UnexpectedNodesSyntax? = nil, declNameArguments: DeclNameArgumentsSyntax?, _ unexpectedAfterDeclNameArguments: UnexpectedNodesSyntax? = nil) -> ImplementsAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type.raw,
      unexpectedBetweenTypeAndComma?.raw,
      comma.raw,
      unexpectedBetweenCommaAndDeclBaseName?.raw,
      declBaseName.raw,
      unexpectedBetweenDeclBaseNameAndDeclNameArguments?.raw,
      declNameArguments?.raw,
      unexpectedAfterDeclNameArguments?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.implementsAttributeArguments,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ImplementsAttributeArgumentsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ImplementsAttributeArgumentsSyntax")
  public static func makeBlankImplementsAttributeArguments(presence: SourcePresence = .present) -> ImplementsAttributeArgumentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .implementsAttributeArguments,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return ImplementsAttributeArgumentsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ObjCSelectorPieceSyntax")
  public static func makeObjCSelectorPiece(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax?, _ unexpectedBetweenNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil) -> ObjCSelectorPieceSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name?.raw,
      unexpectedBetweenNameAndColon?.raw,
      colon?.raw,
      unexpectedAfterColon?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.objCSelectorPiece,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ObjCSelectorPieceSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ObjCSelectorPieceSyntax")
  public static func makeBlankObjCSelectorPiece(presence: SourcePresence = .present) -> ObjCSelectorPieceSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objCSelectorPiece,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return ObjCSelectorPieceSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ObjCSelectorSyntax")
  public static func makeObjCSelector(
    _ elements: [ObjCSelectorPieceSyntax]) -> ObjCSelectorSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.objCSelector,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ObjCSelectorSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ObjCSelectorSyntax")
  public static func makeBlankObjCSelector(presence: SourcePresence = .present) -> ObjCSelectorSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .objCSelector,
        from: [
      ], arena: arena))
      return ObjCSelectorSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DifferentiableAttributeArgumentsSyntax")
  public static func makeDifferentiableAttributeArguments(_ unexpectedBeforeDiffKind: UnexpectedNodesSyntax? = nil, diffKind: TokenSyntax?, _ unexpectedBetweenDiffKindAndDiffKindComma: UnexpectedNodesSyntax? = nil, diffKindComma: TokenSyntax?, _ unexpectedBetweenDiffKindCommaAndDiffParams: UnexpectedNodesSyntax? = nil, diffParams: DifferentiabilityParamsClauseSyntax?, _ unexpectedBetweenDiffParamsAndDiffParamsComma: UnexpectedNodesSyntax? = nil, diffParamsComma: TokenSyntax?, _ unexpectedBetweenDiffParamsCommaAndWhereClause: UnexpectedNodesSyntax? = nil, whereClause: GenericWhereClauseSyntax?, _ unexpectedAfterWhereClause: UnexpectedNodesSyntax? = nil) -> DifferentiableAttributeArgumentsSyntax {
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
      unexpectedAfterWhereClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiableAttributeArguments,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DifferentiableAttributeArgumentsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DifferentiableAttributeArgumentsSyntax")
  public static func makeBlankDifferentiableAttributeArguments(presence: SourcePresence = .present) -> DifferentiableAttributeArgumentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
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
        nil,
      ], arena: arena))
      return DifferentiableAttributeArgumentsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsClauseSyntax")
  public static func makeDifferentiabilityParamsClause(_ unexpectedBeforeWrtLabel: UnexpectedNodesSyntax? = nil, wrtLabel: TokenSyntax, _ unexpectedBetweenWrtLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndParameters: UnexpectedNodesSyntax? = nil, parameters: Syntax, _ unexpectedAfterParameters: UnexpectedNodesSyntax? = nil) -> DifferentiabilityParamsClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrtLabel?.raw,
      wrtLabel.raw,
      unexpectedBetweenWrtLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndParameters?.raw,
      parameters.raw,
      unexpectedAfterParameters?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParamsClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DifferentiabilityParamsClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsClauseSyntax")
  public static func makeBlankDifferentiabilityParamsClause(presence: SourcePresence = .present) -> DifferentiabilityParamsClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiabilityParamsClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
      ], arena: arena))
      return DifferentiabilityParamsClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsSyntax")
  public static func makeDifferentiabilityParams(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndDiffParams: UnexpectedNodesSyntax? = nil, diffParams: DifferentiabilityParamListSyntax, _ unexpectedBetweenDiffParamsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> DifferentiabilityParamsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndDiffParams?.raw,
      diffParams.raw,
      unexpectedBetweenDiffParamsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParams,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DifferentiabilityParamsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamsSyntax")
  public static func makeBlankDifferentiabilityParams(presence: SourcePresence = .present) -> DifferentiabilityParamsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiabilityParams,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.differentiabilityParamList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return DifferentiabilityParamsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamListSyntax")
  public static func makeDifferentiabilityParamList(
    _ elements: [DifferentiabilityParamSyntax]) -> DifferentiabilityParamListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParamList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DifferentiabilityParamListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamListSyntax")
  public static func makeBlankDifferentiabilityParamList(presence: SourcePresence = .present) -> DifferentiabilityParamListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiabilityParamList,
        from: [
      ], arena: arena))
      return DifferentiabilityParamListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamSyntax")
  public static func makeDifferentiabilityParam(_ unexpectedBeforeParameter: UnexpectedNodesSyntax? = nil, parameter: TokenSyntax, _ unexpectedBetweenParameterAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> DifferentiabilityParamSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeParameter?.raw,
      parameter.raw,
      unexpectedBetweenParameterAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.differentiabilityParam,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DifferentiabilityParamSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DifferentiabilityParamSyntax")
  public static func makeBlankDifferentiabilityParam(presence: SourcePresence = .present) -> DifferentiabilityParamSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .differentiabilityParam,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.selfKeyword, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return DifferentiabilityParamSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DerivativeRegistrationAttributeArgumentsSyntax")
  public static func makeDerivativeRegistrationAttributeArguments(_ unexpectedBeforeOfLabel: UnexpectedNodesSyntax? = nil, ofLabel: TokenSyntax, _ unexpectedBetweenOfLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndOriginalDeclName: UnexpectedNodesSyntax? = nil, originalDeclName: QualifiedDeclNameSyntax, _ unexpectedBetweenOriginalDeclNameAndPeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax?, _ unexpectedBetweenPeriodAndAccessorKind: UnexpectedNodesSyntax? = nil, accessorKind: TokenSyntax?, _ unexpectedBetweenAccessorKindAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedBetweenCommaAndDiffParams: UnexpectedNodesSyntax? = nil, diffParams: DifferentiabilityParamsClauseSyntax?, _ unexpectedAfterDiffParams: UnexpectedNodesSyntax? = nil) -> DerivativeRegistrationAttributeArgumentsSyntax {
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
      unexpectedAfterDiffParams?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.derivativeRegistrationAttributeArguments,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DerivativeRegistrationAttributeArgumentsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DerivativeRegistrationAttributeArgumentsSyntax")
  public static func makeBlankDerivativeRegistrationAttributeArguments(presence: SourcePresence = .present) -> DerivativeRegistrationAttributeArgumentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .derivativeRegistrationAttributeArguments,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.qualifiedDeclName, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return DerivativeRegistrationAttributeArgumentsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on QualifiedDeclNameSyntax")
  public static func makeQualifiedDeclName(_ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax?, _ unexpectedBetweenBaseTypeAndDot: UnexpectedNodesSyntax? = nil, dot: TokenSyntax?, _ unexpectedBetweenDotAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? = nil, arguments: DeclNameArgumentsSyntax?, _ unexpectedAfterArguments: UnexpectedNodesSyntax? = nil) -> QualifiedDeclNameSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBaseType?.raw,
      baseType?.raw,
      unexpectedBetweenBaseTypeAndDot?.raw,
      dot?.raw,
      unexpectedBetweenDotAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndArguments?.raw,
      arguments?.raw,
      unexpectedAfterArguments?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.qualifiedDeclName,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return QualifiedDeclNameSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on QualifiedDeclNameSyntax")
  public static func makeBlankQualifiedDeclName(presence: SourcePresence = .present) -> QualifiedDeclNameSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .qualifiedDeclName,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return QualifiedDeclNameSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FunctionDeclNameSyntax")
  public static func makeFunctionDeclName(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndArguments: UnexpectedNodesSyntax? = nil, arguments: DeclNameArgumentsSyntax?, _ unexpectedAfterArguments: UnexpectedNodesSyntax? = nil) -> FunctionDeclNameSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndArguments?.raw,
      arguments?.raw,
      unexpectedAfterArguments?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionDeclName,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FunctionDeclNameSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FunctionDeclNameSyntax")
  public static func makeBlankFunctionDeclName(presence: SourcePresence = .present) -> FunctionDeclNameSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionDeclName,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return FunctionDeclNameSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on BackDeployedAttributeSpecListSyntax")
  public static func makeBackDeployedAttributeSpecList(_ unexpectedBeforeBeforeLabel: UnexpectedNodesSyntax? = nil, beforeLabel: TokenSyntax, _ unexpectedBetweenBeforeLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndVersionList: UnexpectedNodesSyntax? = nil, versionList: BackDeployVersionListSyntax, _ unexpectedAfterVersionList: UnexpectedNodesSyntax? = nil) -> BackDeployedAttributeSpecListSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBeforeLabel?.raw,
      beforeLabel.raw,
      unexpectedBetweenBeforeLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndVersionList?.raw,
      versionList.raw,
      unexpectedAfterVersionList?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployedAttributeSpecList,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return BackDeployedAttributeSpecListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on BackDeployedAttributeSpecListSyntax")
  public static func makeBlankBackDeployedAttributeSpecList(presence: SourcePresence = .present) -> BackDeployedAttributeSpecListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .backDeployedAttributeSpecList,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.backDeployVersionList, arena: arena),
        nil,
      ], arena: arena))
      return BackDeployedAttributeSpecListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on BackDeployVersionListSyntax")
  public static func makeBackDeployVersionList(
    _ elements: [BackDeployVersionArgumentSyntax]) -> BackDeployVersionListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployVersionList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return BackDeployVersionListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on BackDeployVersionListSyntax")
  public static func makeBlankBackDeployVersionList(presence: SourcePresence = .present) -> BackDeployVersionListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .backDeployVersionList,
        from: [
      ], arena: arena))
      return BackDeployVersionListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on BackDeployVersionArgumentSyntax")
  public static func makeBackDeployVersionArgument(_ unexpectedBeforeAvailabilityVersionRestriction: UnexpectedNodesSyntax? = nil, availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax, _ unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> BackDeployVersionArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAvailabilityVersionRestriction?.raw,
      availabilityVersionRestriction.raw,
      unexpectedBetweenAvailabilityVersionRestrictionAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.backDeployVersionArgument,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return BackDeployVersionArgumentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on BackDeployVersionArgumentSyntax")
  public static func makeBlankBackDeployVersionArgument(presence: SourcePresence = .present) -> BackDeployVersionArgumentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .backDeployVersionArgument,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilityVersionRestriction, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return BackDeployVersionArgumentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on OpaqueReturnTypeOfAttributeArgumentsSyntax")
  public static func makeOpaqueReturnTypeOfAttributeArguments(_ unexpectedBeforeMangledName: UnexpectedNodesSyntax? = nil, mangledName: TokenSyntax, _ unexpectedBetweenMangledNameAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax, _ unexpectedBetweenCommaAndOrdinal: UnexpectedNodesSyntax? = nil, ordinal: TokenSyntax, _ unexpectedAfterOrdinal: UnexpectedNodesSyntax? = nil) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMangledName?.raw,
      mangledName.raw,
      unexpectedBetweenMangledNameAndComma?.raw,
      comma.raw,
      unexpectedBetweenCommaAndOrdinal?.raw,
      ordinal.raw,
      unexpectedAfterOrdinal?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.opaqueReturnTypeOfAttributeArguments,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return OpaqueReturnTypeOfAttributeArgumentsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on OpaqueReturnTypeOfAttributeArgumentsSyntax")
  public static func makeBlankOpaqueReturnTypeOfAttributeArguments(presence: SourcePresence = .present) -> OpaqueReturnTypeOfAttributeArgumentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .opaqueReturnTypeOfAttributeArguments,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.stringLiteral(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.comma, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: arena),
        nil,
      ], arena: arena))
      return OpaqueReturnTypeOfAttributeArgumentsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ConventionAttributeArgumentsSyntax")
  public static func makeConventionAttributeArguments(_ unexpectedBeforeConventionLabel: UnexpectedNodesSyntax? = nil, conventionLabel: TokenSyntax, _ unexpectedBetweenConventionLabelAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedBetweenCommaAndCTypeLabel: UnexpectedNodesSyntax? = nil, cTypeLabel: TokenSyntax?, _ unexpectedBetweenCTypeLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndCTypeString: UnexpectedNodesSyntax? = nil, cTypeString: TokenSyntax?, _ unexpectedAfterCTypeString: UnexpectedNodesSyntax? = nil) -> ConventionAttributeArgumentsSyntax {
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
      unexpectedAfterCTypeString?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.conventionAttributeArguments,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ConventionAttributeArgumentsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ConventionAttributeArgumentsSyntax")
  public static func makeBlankConventionAttributeArguments(presence: SourcePresence = .present) -> ConventionAttributeArgumentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conventionAttributeArguments,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return ConventionAttributeArgumentsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ConventionWitnessMethodAttributeArgumentsSyntax")
  public static func makeConventionWitnessMethodAttributeArguments(_ unexpectedBeforeWitnessMethodLabel: UnexpectedNodesSyntax? = nil, witnessMethodLabel: TokenSyntax, _ unexpectedBetweenWitnessMethodLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndProtocolName: UnexpectedNodesSyntax? = nil, protocolName: TokenSyntax, _ unexpectedAfterProtocolName: UnexpectedNodesSyntax? = nil) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWitnessMethodLabel?.raw,
      witnessMethodLabel.raw,
      unexpectedBetweenWitnessMethodLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndProtocolName?.raw,
      protocolName.raw,
      unexpectedAfterProtocolName?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.conventionWitnessMethodAttributeArguments,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ConventionWitnessMethodAttributeArgumentsSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ConventionWitnessMethodAttributeArgumentsSyntax")
  public static func makeBlankConventionWitnessMethodAttributeArguments(presence: SourcePresence = .present) -> ConventionWitnessMethodAttributeArgumentsSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conventionWitnessMethodAttributeArguments,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
      ], arena: arena))
      return ConventionWitnessMethodAttributeArgumentsSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on LabeledStmtSyntax")
  public static func makeLabeledStmt(_ unexpectedBeforeLabelName: UnexpectedNodesSyntax? = nil, labelName: TokenSyntax, _ unexpectedBetweenLabelNameAndLabelColon: UnexpectedNodesSyntax? = nil, labelColon: TokenSyntax, _ unexpectedBetweenLabelColonAndStatement: UnexpectedNodesSyntax? = nil, statement: StmtSyntax, _ unexpectedAfterStatement: UnexpectedNodesSyntax? = nil) -> LabeledStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabelName?.raw,
      labelName.raw,
      unexpectedBetweenLabelNameAndLabelColon?.raw,
      labelColon.raw,
      unexpectedBetweenLabelColonAndStatement?.raw,
      statement.raw,
      unexpectedAfterStatement?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.labeledStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return LabeledStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on LabeledStmtSyntax")
  public static func makeBlankLabeledStmt(presence: SourcePresence = .present) -> LabeledStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .labeledStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingStmt, arena: arena),
        nil,
      ], arena: arena))
      return LabeledStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ContinueStmtSyntax")
  public static func makeContinueStmt(_ unexpectedBeforeContinueKeyword: UnexpectedNodesSyntax? = nil, continueKeyword: TokenSyntax, _ unexpectedBetweenContinueKeywordAndLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax?, _ unexpectedAfterLabel: UnexpectedNodesSyntax? = nil) -> ContinueStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeContinueKeyword?.raw,
      continueKeyword.raw,
      unexpectedBetweenContinueKeywordAndLabel?.raw,
      label?.raw,
      unexpectedAfterLabel?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.continueStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ContinueStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ContinueStmtSyntax")
  public static func makeBlankContinueStmt(presence: SourcePresence = .present) -> ContinueStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .continueStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.continueKeyword, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return ContinueStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on WhileStmtSyntax")
  public static func makeWhileStmt(_ unexpectedBeforeWhileKeyword: UnexpectedNodesSyntax? = nil, whileKeyword: TokenSyntax, _ unexpectedBetweenWhileKeywordAndConditions: UnexpectedNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ unexpectedBetweenConditionsAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> WhileStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWhileKeyword?.raw,
      whileKeyword.raw,
      unexpectedBetweenWhileKeywordAndConditions?.raw,
      conditions.raw,
      unexpectedBetweenConditionsAndBody?.raw,
      body.raw,
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.whileStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return WhileStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on WhileStmtSyntax")
  public static func makeBlankWhileStmt(presence: SourcePresence = .present) -> WhileStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .whileStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.whileKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.conditionElementList, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: arena),
        nil,
      ], arena: arena))
      return WhileStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeferStmtSyntax")
  public static func makeDeferStmt(_ unexpectedBeforeDeferKeyword: UnexpectedNodesSyntax? = nil, deferKeyword: TokenSyntax, _ unexpectedBetweenDeferKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> DeferStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDeferKeyword?.raw,
      deferKeyword.raw,
      unexpectedBetweenDeferKeywordAndBody?.raw,
      body.raw,
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.deferStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeferStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeferStmtSyntax")
  public static func makeBlankDeferStmt(presence: SourcePresence = .present) -> DeferStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .deferStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.deferKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: arena),
        nil,
      ], arena: arena))
      return DeferStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ExpressionStmtSyntax")
  public static func makeExpressionStmt(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil) -> ExpressionStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedAfterExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.expressionStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ExpressionStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ExpressionStmtSyntax")
  public static func makeBlankExpressionStmt(presence: SourcePresence = .present) -> ExpressionStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .expressionStmt,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return ExpressionStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseListSyntax")
  public static func makeSwitchCaseList(
    _ elements: [Syntax]) -> SwitchCaseListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCaseList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SwitchCaseListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseListSyntax")
  public static func makeBlankSwitchCaseList(presence: SourcePresence = .present) -> SwitchCaseListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchCaseList,
        from: [
      ], arena: arena))
      return SwitchCaseListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on RepeatWhileStmtSyntax")
  public static func makeRepeatWhileStmt(_ unexpectedBeforeRepeatKeyword: UnexpectedNodesSyntax? = nil, repeatKeyword: TokenSyntax, _ unexpectedBetweenRepeatKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedBetweenBodyAndWhileKeyword: UnexpectedNodesSyntax? = nil, whileKeyword: TokenSyntax, _ unexpectedBetweenWhileKeywordAndCondition: UnexpectedNodesSyntax? = nil, condition: ExprSyntax, _ unexpectedAfterCondition: UnexpectedNodesSyntax? = nil) -> RepeatWhileStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeRepeatKeyword?.raw,
      repeatKeyword.raw,
      unexpectedBetweenRepeatKeywordAndBody?.raw,
      body.raw,
      unexpectedBetweenBodyAndWhileKeyword?.raw,
      whileKeyword.raw,
      unexpectedBetweenWhileKeywordAndCondition?.raw,
      condition.raw,
      unexpectedAfterCondition?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.repeatWhileStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return RepeatWhileStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on RepeatWhileStmtSyntax")
  public static func makeBlankRepeatWhileStmt(presence: SourcePresence = .present) -> RepeatWhileStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .repeatWhileStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.repeatKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.whileKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return RepeatWhileStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GuardStmtSyntax")
  public static func makeGuardStmt(_ unexpectedBeforeGuardKeyword: UnexpectedNodesSyntax? = nil, guardKeyword: TokenSyntax, _ unexpectedBetweenGuardKeywordAndConditions: UnexpectedNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ unexpectedBetweenConditionsAndElseKeyword: UnexpectedNodesSyntax? = nil, elseKeyword: TokenSyntax, _ unexpectedBetweenElseKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> GuardStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeGuardKeyword?.raw,
      guardKeyword.raw,
      unexpectedBetweenGuardKeywordAndConditions?.raw,
      conditions.raw,
      unexpectedBetweenConditionsAndElseKeyword?.raw,
      elseKeyword.raw,
      unexpectedBetweenElseKeywordAndBody?.raw,
      body.raw,
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.guardStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GuardStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GuardStmtSyntax")
  public static func makeBlankGuardStmt(presence: SourcePresence = .present) -> GuardStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .guardStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.guardKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.conditionElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.elseKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: arena),
        nil,
      ], arena: arena))
      return GuardStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on WhereClauseSyntax")
  public static func makeWhereClause(_ unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? = nil, whereKeyword: TokenSyntax, _ unexpectedBetweenWhereKeywordAndGuardResult: UnexpectedNodesSyntax? = nil, guardResult: ExprSyntax, _ unexpectedAfterGuardResult: UnexpectedNodesSyntax? = nil) -> WhereClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWhereKeyword?.raw,
      whereKeyword.raw,
      unexpectedBetweenWhereKeywordAndGuardResult?.raw,
      guardResult.raw,
      unexpectedAfterGuardResult?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.whereClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return WhereClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on WhereClauseSyntax")
  public static func makeBlankWhereClause(presence: SourcePresence = .present) -> WhereClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .whereClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.whereKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return WhereClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ForInStmtSyntax")
  public static func makeForInStmt(_ unexpectedBeforeForKeyword: UnexpectedNodesSyntax? = nil, forKeyword: TokenSyntax, _ unexpectedBetweenForKeywordAndTryKeyword: UnexpectedNodesSyntax? = nil, tryKeyword: TokenSyntax?, _ unexpectedBetweenTryKeywordAndAwaitKeyword: UnexpectedNodesSyntax? = nil, awaitKeyword: TokenSyntax?, _ unexpectedBetweenAwaitKeywordAndCaseKeyword: UnexpectedNodesSyntax? = nil, caseKeyword: TokenSyntax?, _ unexpectedBetweenCaseKeywordAndPattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedBetweenTypeAnnotationAndInKeyword: UnexpectedNodesSyntax? = nil, inKeyword: TokenSyntax, _ unexpectedBetweenInKeywordAndSequenceExpr: UnexpectedNodesSyntax? = nil, sequenceExpr: ExprSyntax, _ unexpectedBetweenSequenceExprAndWhereClause: UnexpectedNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ unexpectedBetweenWhereClauseAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> ForInStmtSyntax {
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
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.forInStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ForInStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ForInStmtSyntax")
  public static func makeBlankForInStmt(presence: SourcePresence = .present) -> ForInStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .forInStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.forKeyword, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.inKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: arena),
        nil,
      ], arena: arena))
      return ForInStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SwitchStmtSyntax")
  public static func makeSwitchStmt(_ unexpectedBeforeSwitchKeyword: UnexpectedNodesSyntax? = nil, switchKeyword: TokenSyntax, _ unexpectedBetweenSwitchKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndLeftBrace: UnexpectedNodesSyntax? = nil, leftBrace: TokenSyntax, _ unexpectedBetweenLeftBraceAndCases: UnexpectedNodesSyntax? = nil, cases: SwitchCaseListSyntax, _ unexpectedBetweenCasesAndRightBrace: UnexpectedNodesSyntax? = nil, rightBrace: TokenSyntax, _ unexpectedAfterRightBrace: UnexpectedNodesSyntax? = nil) -> SwitchStmtSyntax {
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
      unexpectedAfterRightBrace?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SwitchStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SwitchStmtSyntax")
  public static func makeBlankSwitchStmt(presence: SourcePresence = .present) -> SwitchStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.switchKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftBrace, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.switchCaseList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightBrace, arena: arena),
        nil,
      ], arena: arena))
      return SwitchStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CatchClauseListSyntax")
  public static func makeCatchClauseList(
    _ elements: [CatchClauseSyntax]) -> CatchClauseListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchClauseList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CatchClauseListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CatchClauseListSyntax")
  public static func makeBlankCatchClauseList(presence: SourcePresence = .present) -> CatchClauseListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .catchClauseList,
        from: [
      ], arena: arena))
      return CatchClauseListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DoStmtSyntax")
  public static func makeDoStmt(_ unexpectedBeforeDoKeyword: UnexpectedNodesSyntax? = nil, doKeyword: TokenSyntax, _ unexpectedBetweenDoKeywordAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedBetweenBodyAndCatchClauses: UnexpectedNodesSyntax? = nil, catchClauses: CatchClauseListSyntax?, _ unexpectedAfterCatchClauses: UnexpectedNodesSyntax? = nil) -> DoStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDoKeyword?.raw,
      doKeyword.raw,
      unexpectedBetweenDoKeywordAndBody?.raw,
      body.raw,
      unexpectedBetweenBodyAndCatchClauses?.raw,
      catchClauses?.raw,
      unexpectedAfterCatchClauses?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.doStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DoStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DoStmtSyntax")
  public static func makeBlankDoStmt(presence: SourcePresence = .present) -> DoStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .doStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.doKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return DoStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ReturnStmtSyntax")
  public static func makeReturnStmt(_ unexpectedBeforeReturnKeyword: UnexpectedNodesSyntax? = nil, returnKeyword: TokenSyntax, _ unexpectedBetweenReturnKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax?, _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil) -> ReturnStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeReturnKeyword?.raw,
      returnKeyword.raw,
      unexpectedBetweenReturnKeywordAndExpression?.raw,
      expression?.raw,
      unexpectedAfterExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.returnStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ReturnStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ReturnStmtSyntax")
  public static func makeBlankReturnStmt(presence: SourcePresence = .present) -> ReturnStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .returnStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.returnKeyword, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return ReturnStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on YieldStmtSyntax")
  public static func makeYieldStmt(_ unexpectedBeforeYieldKeyword: UnexpectedNodesSyntax? = nil, yieldKeyword: TokenSyntax, _ unexpectedBetweenYieldKeywordAndYields: UnexpectedNodesSyntax? = nil, yields: Syntax, _ unexpectedAfterYields: UnexpectedNodesSyntax? = nil) -> YieldStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeYieldKeyword?.raw,
      yieldKeyword.raw,
      unexpectedBetweenYieldKeywordAndYields?.raw,
      yields.raw,
      unexpectedAfterYields?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return YieldStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on YieldStmtSyntax")
  public static func makeBlankYieldStmt(presence: SourcePresence = .present) -> YieldStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .yieldStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.yield, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
      ], arena: arena))
      return YieldStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on YieldListSyntax")
  public static func makeYieldList(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndElementList: UnexpectedNodesSyntax? = nil, elementList: YieldExprListSyntax, _ unexpectedBetweenElementListAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> YieldListSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElementList?.raw,
      elementList.raw,
      unexpectedBetweenElementListAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.yieldList,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return YieldListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on YieldListSyntax")
  public static func makeBlankYieldList(presence: SourcePresence = .present) -> YieldListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .yieldList,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.yieldExprList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return YieldListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FallthroughStmtSyntax")
  public static func makeFallthroughStmt(_ unexpectedBeforeFallthroughKeyword: UnexpectedNodesSyntax? = nil, fallthroughKeyword: TokenSyntax, _ unexpectedAfterFallthroughKeyword: UnexpectedNodesSyntax? = nil) -> FallthroughStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeFallthroughKeyword?.raw,
      fallthroughKeyword.raw,
      unexpectedAfterFallthroughKeyword?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.fallthroughStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FallthroughStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FallthroughStmtSyntax")
  public static func makeBlankFallthroughStmt(presence: SourcePresence = .present) -> FallthroughStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .fallthroughStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.fallthroughKeyword, arena: arena),
        nil,
      ], arena: arena))
      return FallthroughStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on BreakStmtSyntax")
  public static func makeBreakStmt(_ unexpectedBeforeBreakKeyword: UnexpectedNodesSyntax? = nil, breakKeyword: TokenSyntax, _ unexpectedBetweenBreakKeywordAndLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax?, _ unexpectedAfterLabel: UnexpectedNodesSyntax? = nil) -> BreakStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBreakKeyword?.raw,
      breakKeyword.raw,
      unexpectedBetweenBreakKeywordAndLabel?.raw,
      label?.raw,
      unexpectedAfterLabel?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.breakStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return BreakStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on BreakStmtSyntax")
  public static func makeBlankBreakStmt(presence: SourcePresence = .present) -> BreakStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .breakStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.breakKeyword, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return BreakStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CaseItemListSyntax")
  public static func makeCaseItemList(
    _ elements: [CaseItemSyntax]) -> CaseItemListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.caseItemList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CaseItemListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CaseItemListSyntax")
  public static func makeBlankCaseItemList(presence: SourcePresence = .present) -> CaseItemListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .caseItemList,
        from: [
      ], arena: arena))
      return CaseItemListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CatchItemListSyntax")
  public static func makeCatchItemList(
    _ elements: [CatchItemSyntax]) -> CatchItemListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchItemList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CatchItemListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CatchItemListSyntax")
  public static func makeBlankCatchItemList(presence: SourcePresence = .present) -> CatchItemListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .catchItemList,
        from: [
      ], arena: arena))
      return CatchItemListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ConditionElementSyntax")
  public static func makeConditionElement(_ unexpectedBeforeCondition: UnexpectedNodesSyntax? = nil, condition: Syntax, _ unexpectedBetweenConditionAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> ConditionElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCondition?.raw,
      condition.raw,
      unexpectedBetweenConditionAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.conditionElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ConditionElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ConditionElementSyntax")
  public static func makeBlankConditionElement(presence: SourcePresence = .present) -> ConditionElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conditionElement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return ConditionElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityConditionSyntax")
  public static func makeAvailabilityCondition(_ unexpectedBeforePoundAvailableKeyword: UnexpectedNodesSyntax? = nil, poundAvailableKeyword: TokenSyntax, _ unexpectedBetweenPoundAvailableKeywordAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? = nil, availabilitySpec: AvailabilitySpecListSyntax, _ unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> AvailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundAvailableKeyword?.raw,
      poundAvailableKeyword.raw,
      unexpectedBetweenPoundAvailableKeywordAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndAvailabilitySpec?.raw,
      availabilitySpec.raw,
      unexpectedBetweenAvailabilitySpecAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityCondition,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AvailabilityConditionSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityConditionSyntax")
  public static func makeBlankAvailabilityCondition(presence: SourcePresence = .present) -> AvailabilityConditionSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityCondition,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundAvailableKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return AvailabilityConditionSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MatchingPatternConditionSyntax")
  public static func makeMatchingPatternCondition(_ unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? = nil, caseKeyword: TokenSyntax, _ unexpectedBetweenCaseKeywordAndPattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil, initializer: InitializerClauseSyntax, _ unexpectedAfterInitializer: UnexpectedNodesSyntax? = nil) -> MatchingPatternConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCaseKeyword?.raw,
      caseKeyword.raw,
      unexpectedBetweenCaseKeywordAndPattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      unexpectedBetweenTypeAnnotationAndInitializer?.raw,
      initializer.raw,
      unexpectedAfterInitializer?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.matchingPatternCondition,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MatchingPatternConditionSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MatchingPatternConditionSyntax")
  public static func makeBlankMatchingPatternCondition(presence: SourcePresence = .present) -> MatchingPatternConditionSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .matchingPatternCondition,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.initializerClause, arena: arena),
        nil,
      ], arena: arena))
      return MatchingPatternConditionSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on OptionalBindingConditionSyntax")
  public static func makeOptionalBindingCondition(_ unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ unexpectedBetweenLetOrVarKeywordAndPattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedBetweenTypeAnnotationAndInitializer: UnexpectedNodesSyntax? = nil, initializer: InitializerClauseSyntax?, _ unexpectedAfterInitializer: UnexpectedNodesSyntax? = nil) -> OptionalBindingConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      unexpectedBetweenLetOrVarKeywordAndPattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      unexpectedBetweenTypeAnnotationAndInitializer?.raw,
      initializer?.raw,
      unexpectedAfterInitializer?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalBindingCondition,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return OptionalBindingConditionSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on OptionalBindingConditionSyntax")
  public static func makeBlankOptionalBindingCondition(presence: SourcePresence = .present) -> OptionalBindingConditionSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .optionalBindingCondition,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return OptionalBindingConditionSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on UnavailabilityConditionSyntax")
  public static func makeUnavailabilityCondition(_ unexpectedBeforePoundUnavailableKeyword: UnexpectedNodesSyntax? = nil, poundUnavailableKeyword: TokenSyntax, _ unexpectedBetweenPoundUnavailableKeywordAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndAvailabilitySpec: UnexpectedNodesSyntax? = nil, availabilitySpec: AvailabilitySpecListSyntax, _ unexpectedBetweenAvailabilitySpecAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> UnavailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePoundUnavailableKeyword?.raw,
      poundUnavailableKeyword.raw,
      unexpectedBetweenPoundUnavailableKeywordAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndAvailabilitySpec?.raw,
      availabilitySpec.raw,
      unexpectedBetweenAvailabilitySpecAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.unavailabilityCondition,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return UnavailabilityConditionSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on UnavailabilityConditionSyntax")
  public static func makeBlankUnavailabilityCondition(presence: SourcePresence = .present) -> UnavailabilityConditionSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .unavailabilityCondition,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundUnavailableKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.availabilitySpecList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return UnavailabilityConditionSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on HasSymbolConditionSyntax")
  public static func makeHasSymbolCondition(_ unexpectedBeforeHasSymbolKeyword: UnexpectedNodesSyntax? = nil, hasSymbolKeyword: TokenSyntax, _ unexpectedBetweenHasSymbolKeywordAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedBetweenExpressionAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> HasSymbolConditionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeHasSymbolKeyword?.raw,
      hasSymbolKeyword.raw,
      unexpectedBetweenHasSymbolKeywordAndLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndExpression?.raw,
      expression.raw,
      unexpectedBetweenExpressionAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.hasSymbolCondition,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return HasSymbolConditionSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on HasSymbolConditionSyntax")
  public static func makeBlankHasSymbolCondition(presence: SourcePresence = .present) -> HasSymbolConditionSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .hasSymbolCondition,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return HasSymbolConditionSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ConditionElementListSyntax")
  public static func makeConditionElementList(
    _ elements: [ConditionElementSyntax]) -> ConditionElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.conditionElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ConditionElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ConditionElementListSyntax")
  public static func makeBlankConditionElementList(presence: SourcePresence = .present) -> ConditionElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conditionElementList,
        from: [
      ], arena: arena))
      return ConditionElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DeclarationStmtSyntax")
  public static func makeDeclarationStmt(_ unexpectedBeforeDeclaration: UnexpectedNodesSyntax? = nil, declaration: DeclSyntax, _ unexpectedAfterDeclaration: UnexpectedNodesSyntax? = nil) -> DeclarationStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDeclaration?.raw,
      declaration.raw,
      unexpectedAfterDeclaration?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.declarationStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DeclarationStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DeclarationStmtSyntax")
  public static func makeBlankDeclarationStmt(presence: SourcePresence = .present) -> DeclarationStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .declarationStmt,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingDecl, arena: arena),
        nil,
      ], arena: arena))
      return DeclarationStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ThrowStmtSyntax")
  public static func makeThrowStmt(_ unexpectedBeforeThrowKeyword: UnexpectedNodesSyntax? = nil, throwKeyword: TokenSyntax, _ unexpectedBetweenThrowKeywordAndExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil) -> ThrowStmtSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeThrowKeyword?.raw,
      throwKeyword.raw,
      unexpectedBetweenThrowKeywordAndExpression?.raw,
      expression.raw,
      unexpectedAfterExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.throwStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ThrowStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ThrowStmtSyntax")
  public static func makeBlankThrowStmt(presence: SourcePresence = .present) -> ThrowStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .throwStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.throwKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return ThrowStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IfStmtSyntax")
  public static func makeIfStmt(_ unexpectedBeforeIfKeyword: UnexpectedNodesSyntax? = nil, ifKeyword: TokenSyntax, _ unexpectedBetweenIfKeywordAndConditions: UnexpectedNodesSyntax? = nil, conditions: ConditionElementListSyntax, _ unexpectedBetweenConditionsAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedBetweenBodyAndElseKeyword: UnexpectedNodesSyntax? = nil, elseKeyword: TokenSyntax?, _ unexpectedBetweenElseKeywordAndElseBody: UnexpectedNodesSyntax? = nil, elseBody: Syntax?, _ unexpectedAfterElseBody: UnexpectedNodesSyntax? = nil) -> IfStmtSyntax {
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
      unexpectedAfterElseBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.ifStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IfStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IfStmtSyntax")
  public static func makeBlankIfStmt(presence: SourcePresence = .present) -> IfStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .ifStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.ifKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.conditionElementList, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return IfStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseSyntax")
  public static func makeSwitchCase(_ unexpectedBeforeUnknownAttr: UnexpectedNodesSyntax? = nil, unknownAttr: AttributeSyntax?, _ unexpectedBetweenUnknownAttrAndLabel: UnexpectedNodesSyntax? = nil, label: Syntax, _ unexpectedBetweenLabelAndStatements: UnexpectedNodesSyntax? = nil, statements: CodeBlockItemListSyntax, _ unexpectedAfterStatements: UnexpectedNodesSyntax? = nil) -> SwitchCaseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeUnknownAttr?.raw,
      unknownAttr?.raw,
      unexpectedBetweenUnknownAttrAndLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndStatements?.raw,
      statements.raw,
      unexpectedAfterStatements?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCase,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SwitchCaseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseSyntax")
  public static func makeBlankSwitchCase(presence: SourcePresence = .present) -> SwitchCaseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchCase,
        from: [
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlockItemList, arena: arena),
        nil,
      ], arena: arena))
      return SwitchCaseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SwitchDefaultLabelSyntax")
  public static func makeSwitchDefaultLabel(_ unexpectedBeforeDefaultKeyword: UnexpectedNodesSyntax? = nil, defaultKeyword: TokenSyntax, _ unexpectedBetweenDefaultKeywordAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil) -> SwitchDefaultLabelSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeDefaultKeyword?.raw,
      defaultKeyword.raw,
      unexpectedBetweenDefaultKeywordAndColon?.raw,
      colon.raw,
      unexpectedAfterColon?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchDefaultLabel,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SwitchDefaultLabelSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SwitchDefaultLabelSyntax")
  public static func makeBlankSwitchDefaultLabel(presence: SourcePresence = .present) -> SwitchDefaultLabelSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchDefaultLabel,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.defaultKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
      ], arena: arena))
      return SwitchDefaultLabelSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CaseItemSyntax")
  public static func makeCaseItem(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> CaseItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndWhereClause?.raw,
      whereClause?.raw,
      unexpectedBetweenWhereClauseAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.caseItem,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CaseItemSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CaseItemSyntax")
  public static func makeBlankCaseItem(presence: SourcePresence = .present) -> CaseItemSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .caseItem,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return CaseItemSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CatchItemSyntax")
  public static func makeCatchItem(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax?, _ unexpectedBetweenPatternAndWhereClause: UnexpectedNodesSyntax? = nil, whereClause: WhereClauseSyntax?, _ unexpectedBetweenWhereClauseAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> CatchItemSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern?.raw,
      unexpectedBetweenPatternAndWhereClause?.raw,
      whereClause?.raw,
      unexpectedBetweenWhereClauseAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchItem,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CatchItemSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CatchItemSyntax")
  public static func makeBlankCatchItem(presence: SourcePresence = .present) -> CatchItemSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .catchItem,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return CatchItemSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SwitchCaseLabelSyntax")
  public static func makeSwitchCaseLabel(_ unexpectedBeforeCaseKeyword: UnexpectedNodesSyntax? = nil, caseKeyword: TokenSyntax, _ unexpectedBetweenCaseKeywordAndCaseItems: UnexpectedNodesSyntax? = nil, caseItems: CaseItemListSyntax, _ unexpectedBetweenCaseItemsAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedAfterColon: UnexpectedNodesSyntax? = nil) -> SwitchCaseLabelSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCaseKeyword?.raw,
      caseKeyword.raw,
      unexpectedBetweenCaseKeywordAndCaseItems?.raw,
      caseItems.raw,
      unexpectedBetweenCaseItemsAndColon?.raw,
      colon.raw,
      unexpectedAfterColon?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.switchCaseLabel,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SwitchCaseLabelSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SwitchCaseLabelSyntax")
  public static func makeBlankSwitchCaseLabel(presence: SourcePresence = .present) -> SwitchCaseLabelSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .switchCaseLabel,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.caseKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.caseItemList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
      ], arena: arena))
      return SwitchCaseLabelSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CatchClauseSyntax")
  public static func makeCatchClause(_ unexpectedBeforeCatchKeyword: UnexpectedNodesSyntax? = nil, catchKeyword: TokenSyntax, _ unexpectedBetweenCatchKeywordAndCatchItems: UnexpectedNodesSyntax? = nil, catchItems: CatchItemListSyntax?, _ unexpectedBetweenCatchItemsAndBody: UnexpectedNodesSyntax? = nil, body: CodeBlockSyntax, _ unexpectedAfterBody: UnexpectedNodesSyntax? = nil) -> CatchClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeCatchKeyword?.raw,
      catchKeyword.raw,
      unexpectedBetweenCatchKeywordAndCatchItems?.raw,
      catchItems?.raw,
      unexpectedBetweenCatchItemsAndBody?.raw,
      body.raw,
      unexpectedAfterBody?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.catchClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CatchClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CatchClauseSyntax")
  public static func makeBlankCatchClause(presence: SourcePresence = .present) -> CatchClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .catchClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.catchKeyword, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.codeBlock, arena: arena),
        nil,
      ], arena: arena))
      return CatchClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PoundAssertStmtSyntax")
  public static func makePoundAssertStmt(_ unexpectedBeforePoundAssert: UnexpectedNodesSyntax? = nil, poundAssert: TokenSyntax, _ unexpectedBetweenPoundAssertAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndCondition: UnexpectedNodesSyntax? = nil, condition: ExprSyntax, _ unexpectedBetweenConditionAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedBetweenCommaAndMessage: UnexpectedNodesSyntax? = nil, message: TokenSyntax?, _ unexpectedBetweenMessageAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> PoundAssertStmtSyntax {
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
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.poundAssertStmt,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PoundAssertStmtSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PoundAssertStmtSyntax")
  public static func makeBlankPoundAssertStmt(presence: SourcePresence = .present) -> PoundAssertStmtSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .poundAssertStmt,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.poundAssertKeyword, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return PoundAssertStmtSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericWhereClauseSyntax")
  public static func makeGenericWhereClause(_ unexpectedBeforeWhereKeyword: UnexpectedNodesSyntax? = nil, whereKeyword: TokenSyntax, _ unexpectedBetweenWhereKeywordAndRequirementList: UnexpectedNodesSyntax? = nil, requirementList: GenericRequirementListSyntax, _ unexpectedAfterRequirementList: UnexpectedNodesSyntax? = nil) -> GenericWhereClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWhereKeyword?.raw,
      whereKeyword.raw,
      unexpectedBetweenWhereKeywordAndRequirementList?.raw,
      requirementList.raw,
      unexpectedAfterRequirementList?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericWhereClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericWhereClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericWhereClauseSyntax")
  public static func makeBlankGenericWhereClause(presence: SourcePresence = .present) -> GenericWhereClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericWhereClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.whereKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericRequirementList, arena: arena),
        nil,
      ], arena: arena))
      return GenericWhereClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericRequirementListSyntax")
  public static func makeGenericRequirementList(
    _ elements: [GenericRequirementSyntax]) -> GenericRequirementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericRequirementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericRequirementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericRequirementListSyntax")
  public static func makeBlankGenericRequirementList(presence: SourcePresence = .present) -> GenericRequirementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericRequirementList,
        from: [
      ], arena: arena))
      return GenericRequirementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericRequirementSyntax")
  public static func makeGenericRequirement(_ unexpectedBeforeBody: UnexpectedNodesSyntax? = nil, body: Syntax, _ unexpectedBetweenBodyAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> GenericRequirementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBody?.raw,
      body.raw,
      unexpectedBetweenBodyAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericRequirement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericRequirementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericRequirementSyntax")
  public static func makeBlankGenericRequirement(presence: SourcePresence = .present) -> GenericRequirementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericRequirement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return GenericRequirementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SameTypeRequirementSyntax")
  public static func makeSameTypeRequirement(_ unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? = nil, leftTypeIdentifier: TypeSyntax, _ unexpectedBetweenLeftTypeIdentifierAndEqualityToken: UnexpectedNodesSyntax? = nil, equalityToken: TokenSyntax, _ unexpectedBetweenEqualityTokenAndRightTypeIdentifier: UnexpectedNodesSyntax? = nil, rightTypeIdentifier: TypeSyntax, _ unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? = nil) -> SameTypeRequirementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftTypeIdentifier?.raw,
      leftTypeIdentifier.raw,
      unexpectedBetweenLeftTypeIdentifierAndEqualityToken?.raw,
      equalityToken.raw,
      unexpectedBetweenEqualityTokenAndRightTypeIdentifier?.raw,
      rightTypeIdentifier.raw,
      unexpectedAfterRightTypeIdentifier?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.sameTypeRequirement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SameTypeRequirementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SameTypeRequirementSyntax")
  public static func makeBlankSameTypeRequirement(presence: SourcePresence = .present) -> SameTypeRequirementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .sameTypeRequirement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.spacedBinaryOperator(""), arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return SameTypeRequirementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on LayoutRequirementSyntax")
  public static func makeLayoutRequirement(_ unexpectedBeforeTypeIdentifier: UnexpectedNodesSyntax? = nil, typeIdentifier: TypeSyntax, _ unexpectedBetweenTypeIdentifierAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndLayoutConstraint: UnexpectedNodesSyntax? = nil, layoutConstraint: TokenSyntax, _ unexpectedBetweenLayoutConstraintAndLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax?, _ unexpectedBetweenLeftParenAndSize: UnexpectedNodesSyntax? = nil, size: TokenSyntax?, _ unexpectedBetweenSizeAndComma: UnexpectedNodesSyntax? = nil, comma: TokenSyntax?, _ unexpectedBetweenCommaAndAlignment: UnexpectedNodesSyntax? = nil, alignment: TokenSyntax?, _ unexpectedBetweenAlignmentAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax?, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> LayoutRequirementSyntax {
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
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.layoutRequirement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return LayoutRequirementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on LayoutRequirementSyntax")
  public static func makeBlankLayoutRequirement(presence: SourcePresence = .present) -> LayoutRequirementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .layoutRequirement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
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
      ], arena: arena))
      return LayoutRequirementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterListSyntax")
  public static func makeGenericParameterList(
    _ elements: [GenericParameterSyntax]) -> GenericParameterListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameterList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericParameterListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterListSyntax")
  public static func makeBlankGenericParameterList(presence: SourcePresence = .present) -> GenericParameterListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericParameterList,
        from: [
      ], arena: arena))
      return GenericParameterListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterSyntax")
  public static func makeGenericParameter(_ unexpectedBeforeAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndEllipsis: UnexpectedNodesSyntax? = nil, ellipsis: TokenSyntax?, _ unexpectedBetweenEllipsisAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndInheritedType: UnexpectedNodesSyntax? = nil, inheritedType: TypeSyntax?, _ unexpectedBetweenInheritedTypeAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> GenericParameterSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndEllipsis?.raw,
      ellipsis?.raw,
      unexpectedBetweenEllipsisAndColon?.raw,
      colon?.raw,
      unexpectedBetweenColonAndInheritedType?.raw,
      inheritedType?.raw,
      unexpectedBetweenInheritedTypeAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameter,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericParameterSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterSyntax")
  public static func makeBlankGenericParameter(presence: SourcePresence = .present) -> GenericParameterSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericParameter,
        from: [
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return GenericParameterSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeListSyntax")
  public static func makePrimaryAssociatedTypeList(
    _ elements: [PrimaryAssociatedTypeSyntax]) -> PrimaryAssociatedTypeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedTypeList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrimaryAssociatedTypeListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeListSyntax")
  public static func makeBlankPrimaryAssociatedTypeList(presence: SourcePresence = .present) -> PrimaryAssociatedTypeListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .primaryAssociatedTypeList,
        from: [
      ], arena: arena))
      return PrimaryAssociatedTypeListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeSyntax")
  public static func makePrimaryAssociatedType(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> PrimaryAssociatedTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrimaryAssociatedTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeSyntax")
  public static func makeBlankPrimaryAssociatedType(presence: SourcePresence = .present) -> PrimaryAssociatedTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .primaryAssociatedType,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return PrimaryAssociatedTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericParameterClauseSyntax")
  public static func makeGenericParameterClause(_ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ unexpectedBetweenLeftAngleBracketAndGenericParameterList: UnexpectedNodesSyntax? = nil, genericParameterList: GenericParameterListSyntax, _ unexpectedBetweenGenericParameterListAndGenericWhereClause: UnexpectedNodesSyntax? = nil, genericWhereClause: GenericWhereClauseSyntax?, _ unexpectedBetweenGenericWhereClauseAndRightAngleBracket: UnexpectedNodesSyntax? = nil, rightAngleBracket: TokenSyntax, _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil) -> GenericParameterClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      unexpectedBetweenLeftAngleBracketAndGenericParameterList?.raw,
      genericParameterList.raw,
      unexpectedBetweenGenericParameterListAndGenericWhereClause?.raw,
      genericWhereClause?.raw,
      unexpectedBetweenGenericWhereClauseAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
      unexpectedAfterRightAngleBracket?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericParameterClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericParameterClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericParameterClauseSyntax")
  public static func makeBlankGenericParameterClause(presence: SourcePresence = .present) -> GenericParameterClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericParameterClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericParameterList, arena: arena),
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: arena),
        nil,
      ], arena: arena))
      return GenericParameterClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ConformanceRequirementSyntax")
  public static func makeConformanceRequirement(_ unexpectedBeforeLeftTypeIdentifier: UnexpectedNodesSyntax? = nil, leftTypeIdentifier: TypeSyntax, _ unexpectedBetweenLeftTypeIdentifierAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndRightTypeIdentifier: UnexpectedNodesSyntax? = nil, rightTypeIdentifier: TypeSyntax, _ unexpectedAfterRightTypeIdentifier: UnexpectedNodesSyntax? = nil) -> ConformanceRequirementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftTypeIdentifier?.raw,
      leftTypeIdentifier.raw,
      unexpectedBetweenLeftTypeIdentifierAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndRightTypeIdentifier?.raw,
      rightTypeIdentifier.raw,
      unexpectedAfterRightTypeIdentifier?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.conformanceRequirement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ConformanceRequirementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ConformanceRequirementSyntax")
  public static func makeBlankConformanceRequirement(presence: SourcePresence = .present) -> ConformanceRequirementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .conformanceRequirement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return ConformanceRequirementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeClauseSyntax")
  public static func makePrimaryAssociatedTypeClause(_ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList: UnexpectedNodesSyntax? = nil, primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax, _ unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket: UnexpectedNodesSyntax? = nil, rightAngleBracket: TokenSyntax, _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil) -> PrimaryAssociatedTypeClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      unexpectedBetweenLeftAngleBracketAndPrimaryAssociatedTypeList?.raw,
      primaryAssociatedTypeList.raw,
      unexpectedBetweenPrimaryAssociatedTypeListAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
      unexpectedAfterRightAngleBracket?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.primaryAssociatedTypeClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PrimaryAssociatedTypeClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PrimaryAssociatedTypeClauseSyntax")
  public static func makeBlankPrimaryAssociatedTypeClause(presence: SourcePresence = .present) -> PrimaryAssociatedTypeClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .primaryAssociatedTypeClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.primaryAssociatedTypeList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: arena),
        nil,
      ], arena: arena))
      return PrimaryAssociatedTypeClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeSimpleTypeIdentifier(_ unexpectedBeforeName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?, _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil) -> SimpleTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeName?.raw,
      name.raw,
      unexpectedBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
      unexpectedAfterGenericArgumentClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.simpleTypeIdentifier,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return SimpleTypeIdentifierSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on SimpleTypeIdentifierSyntax")
  public static func makeBlankSimpleTypeIdentifier(presence: SourcePresence = .present) -> SimpleTypeIdentifierSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .simpleTypeIdentifier,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return SimpleTypeIdentifierSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MemberTypeIdentifierSyntax")
  public static func makeMemberTypeIdentifier(_ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax, _ unexpectedBetweenBaseTypeAndPeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax, _ unexpectedBetweenPeriodAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax, _ unexpectedBetweenNameAndGenericArgumentClause: UnexpectedNodesSyntax? = nil, genericArgumentClause: GenericArgumentClauseSyntax?, _ unexpectedAfterGenericArgumentClause: UnexpectedNodesSyntax? = nil) -> MemberTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBaseType?.raw,
      baseType.raw,
      unexpectedBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndName?.raw,
      name.raw,
      unexpectedBetweenNameAndGenericArgumentClause?.raw,
      genericArgumentClause?.raw,
      unexpectedAfterGenericArgumentClause?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.memberTypeIdentifier,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MemberTypeIdentifierSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MemberTypeIdentifierSyntax")
  public static func makeBlankMemberTypeIdentifier(presence: SourcePresence = .present) -> MemberTypeIdentifierSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .memberTypeIdentifier,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.period, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return MemberTypeIdentifierSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ClassRestrictionTypeSyntax")
  public static func makeClassRestrictionType(_ unexpectedBeforeClassKeyword: UnexpectedNodesSyntax? = nil, classKeyword: TokenSyntax, _ unexpectedAfterClassKeyword: UnexpectedNodesSyntax? = nil) -> ClassRestrictionTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeClassKeyword?.raw,
      classKeyword.raw,
      unexpectedAfterClassKeyword?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.classRestrictionType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ClassRestrictionTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ClassRestrictionTypeSyntax")
  public static func makeBlankClassRestrictionType(presence: SourcePresence = .present) -> ClassRestrictionTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .classRestrictionType,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.classKeyword, arena: arena),
        nil,
      ], arena: arena))
      return ClassRestrictionTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ArrayTypeSyntax")
  public static func makeArrayType(_ unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? = nil, leftSquareBracket: TokenSyntax, _ unexpectedBetweenLeftSquareBracketAndElementType: UnexpectedNodesSyntax? = nil, elementType: TypeSyntax, _ unexpectedBetweenElementTypeAndRightSquareBracket: UnexpectedNodesSyntax? = nil, rightSquareBracket: TokenSyntax, _ unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? = nil) -> ArrayTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftSquareBracket?.raw,
      leftSquareBracket.raw,
      unexpectedBetweenLeftSquareBracketAndElementType?.raw,
      elementType.raw,
      unexpectedBetweenElementTypeAndRightSquareBracket?.raw,
      rightSquareBracket.raw,
      unexpectedAfterRightSquareBracket?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.arrayType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ArrayTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ArrayTypeSyntax")
  public static func makeBlankArrayType(presence: SourcePresence = .present) -> ArrayTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .arrayType,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: arena),
        nil,
      ], arena: arena))
      return ArrayTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on DictionaryTypeSyntax")
  public static func makeDictionaryType(_ unexpectedBeforeLeftSquareBracket: UnexpectedNodesSyntax? = nil, leftSquareBracket: TokenSyntax, _ unexpectedBetweenLeftSquareBracketAndKeyType: UnexpectedNodesSyntax? = nil, keyType: TypeSyntax, _ unexpectedBetweenKeyTypeAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValueType: UnexpectedNodesSyntax? = nil, valueType: TypeSyntax, _ unexpectedBetweenValueTypeAndRightSquareBracket: UnexpectedNodesSyntax? = nil, rightSquareBracket: TokenSyntax, _ unexpectedAfterRightSquareBracket: UnexpectedNodesSyntax? = nil) -> DictionaryTypeSyntax {
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
      unexpectedAfterRightSquareBracket?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.dictionaryType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return DictionaryTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on DictionaryTypeSyntax")
  public static func makeBlankDictionaryType(presence: SourcePresence = .present) -> DictionaryTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .dictionaryType,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftSquareBracket, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightSquareBracket, arena: arena),
        nil,
      ], arena: arena))
      return DictionaryTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on MetatypeTypeSyntax")
  public static func makeMetatypeType(_ unexpectedBeforeBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax, _ unexpectedBetweenBaseTypeAndPeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax, _ unexpectedBetweenPeriodAndTypeOrProtocol: UnexpectedNodesSyntax? = nil, typeOrProtocol: TokenSyntax, _ unexpectedAfterTypeOrProtocol: UnexpectedNodesSyntax? = nil) -> MetatypeTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeBaseType?.raw,
      baseType.raw,
      unexpectedBetweenBaseTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndTypeOrProtocol?.raw,
      typeOrProtocol.raw,
      unexpectedAfterTypeOrProtocol?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.metatypeType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return MetatypeTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on MetatypeTypeSyntax")
  public static func makeBlankMetatypeType(presence: SourcePresence = .present) -> MetatypeTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .metatypeType,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.period, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
      ], arena: arena))
      return MetatypeTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on OptionalTypeSyntax")
  public static func makeOptionalType(_ unexpectedBeforeWrappedType: UnexpectedNodesSyntax? = nil, wrappedType: TypeSyntax, _ unexpectedBetweenWrappedTypeAndQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax, _ unexpectedAfterQuestionMark: UnexpectedNodesSyntax? = nil) -> OptionalTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrappedType?.raw,
      wrappedType.raw,
      unexpectedBetweenWrappedTypeAndQuestionMark?.raw,
      questionMark.raw,
      unexpectedAfterQuestionMark?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return OptionalTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on OptionalTypeSyntax")
  public static func makeBlankOptionalType(presence: SourcePresence = .present) -> OptionalTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .optionalType,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: arena),
        nil,
      ], arena: arena))
      return OptionalTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ConstrainedSugarTypeSyntax")
  public static func makeConstrainedSugarType(_ unexpectedBeforeSomeOrAnySpecifier: UnexpectedNodesSyntax? = nil, someOrAnySpecifier: TokenSyntax, _ unexpectedBetweenSomeOrAnySpecifierAndBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax, _ unexpectedAfterBaseType: UnexpectedNodesSyntax? = nil) -> ConstrainedSugarTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSomeOrAnySpecifier?.raw,
      someOrAnySpecifier.raw,
      unexpectedBetweenSomeOrAnySpecifierAndBaseType?.raw,
      baseType.raw,
      unexpectedAfterBaseType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.constrainedSugarType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ConstrainedSugarTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ConstrainedSugarTypeSyntax")
  public static func makeBlankConstrainedSugarType(presence: SourcePresence = .present) -> ConstrainedSugarTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .constrainedSugarType,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return ConstrainedSugarTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ImplicitlyUnwrappedOptionalTypeSyntax")
  public static func makeImplicitlyUnwrappedOptionalType(_ unexpectedBeforeWrappedType: UnexpectedNodesSyntax? = nil, wrappedType: TypeSyntax, _ unexpectedBetweenWrappedTypeAndExclamationMark: UnexpectedNodesSyntax? = nil, exclamationMark: TokenSyntax, _ unexpectedAfterExclamationMark: UnexpectedNodesSyntax? = nil) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWrappedType?.raw,
      wrappedType.raw,
      unexpectedBetweenWrappedTypeAndExclamationMark?.raw,
      exclamationMark.raw,
      unexpectedAfterExclamationMark?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.implicitlyUnwrappedOptionalType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ImplicitlyUnwrappedOptionalTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ImplicitlyUnwrappedOptionalTypeSyntax")
  public static func makeBlankImplicitlyUnwrappedOptionalType(presence: SourcePresence = .present) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .implicitlyUnwrappedOptionalType,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.exclamationMark, arena: arena),
        nil,
      ], arena: arena))
      return ImplicitlyUnwrappedOptionalTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeElementSyntax")
  public static func makeCompositionTypeElement(_ unexpectedBeforeType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedBetweenTypeAndAmpersand: UnexpectedNodesSyntax? = nil, ampersand: TokenSyntax?, _ unexpectedAfterAmpersand: UnexpectedNodesSyntax? = nil) -> CompositionTypeElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type.raw,
      unexpectedBetweenTypeAndAmpersand?.raw,
      ampersand?.raw,
      unexpectedAfterAmpersand?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionTypeElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CompositionTypeElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeElementSyntax")
  public static func makeBlankCompositionTypeElement(presence: SourcePresence = .present) -> CompositionTypeElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .compositionTypeElement,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return CompositionTypeElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeElementListSyntax")
  public static func makeCompositionTypeElementList(
    _ elements: [CompositionTypeElementSyntax]) -> CompositionTypeElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionTypeElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CompositionTypeElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeElementListSyntax")
  public static func makeBlankCompositionTypeElementList(presence: SourcePresence = .present) -> CompositionTypeElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .compositionTypeElementList,
        from: [
      ], arena: arena))
      return CompositionTypeElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on CompositionTypeSyntax")
  public static func makeCompositionType(_ unexpectedBeforeElements: UnexpectedNodesSyntax? = nil, elements: CompositionTypeElementListSyntax, _ unexpectedAfterElements: UnexpectedNodesSyntax? = nil) -> CompositionTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeElements?.raw,
      elements.raw,
      unexpectedAfterElements?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.compositionType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return CompositionTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on CompositionTypeSyntax")
  public static func makeBlankCompositionType(presence: SourcePresence = .present) -> CompositionTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .compositionType,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.compositionTypeElementList, arena: arena),
        nil,
      ], arena: arena))
      return CompositionTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PackExpansionTypeSyntax")
  public static func makePackExpansionType(_ unexpectedBeforePatternType: UnexpectedNodesSyntax? = nil, patternType: TypeSyntax, _ unexpectedBetweenPatternTypeAndEllipsis: UnexpectedNodesSyntax? = nil, ellipsis: TokenSyntax, _ unexpectedAfterEllipsis: UnexpectedNodesSyntax? = nil) -> PackExpansionTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePatternType?.raw,
      patternType.raw,
      unexpectedBetweenPatternTypeAndEllipsis?.raw,
      ellipsis.raw,
      unexpectedAfterEllipsis?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.packExpansionType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PackExpansionTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PackExpansionTypeSyntax")
  public static func makeBlankPackExpansionType(presence: SourcePresence = .present) -> PackExpansionTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .packExpansionType,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.ellipsis, arena: arena),
        nil,
      ], arena: arena))
      return PackExpansionTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on PackReferenceTypeSyntax")
  public static func makePackReferenceType(_ unexpectedBeforeEachKeyword: UnexpectedNodesSyntax? = nil, eachKeyword: TokenSyntax, _ unexpectedBetweenEachKeywordAndPackType: UnexpectedNodesSyntax? = nil, packType: TypeSyntax, _ unexpectedAfterPackType: UnexpectedNodesSyntax? = nil) -> PackReferenceTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEachKeyword?.raw,
      eachKeyword.raw,
      unexpectedBetweenEachKeywordAndPackType?.raw,
      packType.raw,
      unexpectedAfterPackType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.packReferenceType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return PackReferenceTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on PackReferenceTypeSyntax")
  public static func makeBlankPackReferenceType(presence: SourcePresence = .present) -> PackReferenceTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .packReferenceType,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.unknown(""), arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return PackReferenceTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeElementSyntax")
  public static func makeTupleTypeElement(_ unexpectedBeforeInOut: UnexpectedNodesSyntax? = nil, inOut: TokenSyntax?, _ unexpectedBetweenInOutAndName: UnexpectedNodesSyntax? = nil, name: TokenSyntax?, _ unexpectedBetweenNameAndSecondName: UnexpectedNodesSyntax? = nil, secondName: TokenSyntax?, _ unexpectedBetweenSecondNameAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax?, _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedBetweenTypeAndEllipsis: UnexpectedNodesSyntax? = nil, ellipsis: TokenSyntax?, _ unexpectedBetweenEllipsisAndInitializer: UnexpectedNodesSyntax? = nil, initializer: InitializerClauseSyntax?, _ unexpectedBetweenInitializerAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> TupleTypeElementSyntax {
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
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleTypeElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TupleTypeElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeElementSyntax")
  public static func makeBlankTupleTypeElement(presence: SourcePresence = .present) -> TupleTypeElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
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
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return TupleTypeElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeElementListSyntax")
  public static func makeTupleTypeElementList(
    _ elements: [TupleTypeElementSyntax]) -> TupleTypeElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleTypeElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TupleTypeElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeElementListSyntax")
  public static func makeBlankTupleTypeElementList(presence: SourcePresence = .present) -> TupleTypeElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleTypeElementList,
        from: [
      ], arena: arena))
      return TupleTypeElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeTupleType(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndElements: UnexpectedNodesSyntax? = nil, elements: TupleTypeElementListSyntax, _ unexpectedBetweenElementsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> TupleTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElements?.raw,
      elements.raw,
      unexpectedBetweenElementsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tupleType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TupleTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TupleTypeSyntax")
  public static func makeBlankTupleType(presence: SourcePresence = .present) -> TupleTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tupleType,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleTypeElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return TupleTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on FunctionTypeSyntax")
  public static func makeFunctionType(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil, arguments: TupleTypeElementListSyntax, _ unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedBetweenRightParenAndAsyncKeyword: UnexpectedNodesSyntax? = nil, asyncKeyword: TokenSyntax?, _ unexpectedBetweenAsyncKeywordAndThrowsOrRethrowsKeyword: UnexpectedNodesSyntax? = nil, throwsOrRethrowsKeyword: TokenSyntax?, _ unexpectedBetweenThrowsOrRethrowsKeywordAndArrow: UnexpectedNodesSyntax? = nil, arrow: TokenSyntax, _ unexpectedBetweenArrowAndReturnType: UnexpectedNodesSyntax? = nil, returnType: TypeSyntax, _ unexpectedAfterReturnType: UnexpectedNodesSyntax? = nil) -> FunctionTypeSyntax {
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
      unexpectedAfterReturnType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.functionType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return FunctionTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on FunctionTypeSyntax")
  public static func makeBlankFunctionType(presence: SourcePresence = .present) -> FunctionTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .functionType,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tupleTypeElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.arrow, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return FunctionTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AttributedTypeSyntax")
  public static func makeAttributedType(_ unexpectedBeforeSpecifier: UnexpectedNodesSyntax? = nil, specifier: TokenSyntax?, _ unexpectedBetweenSpecifierAndAttributes: UnexpectedNodesSyntax? = nil, attributes: AttributeListSyntax?, _ unexpectedBetweenAttributesAndBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax, _ unexpectedAfterBaseType: UnexpectedNodesSyntax? = nil) -> AttributedTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSpecifier?.raw,
      specifier?.raw,
      unexpectedBetweenSpecifierAndAttributes?.raw,
      attributes?.raw,
      unexpectedBetweenAttributesAndBaseType?.raw,
      baseType.raw,
      unexpectedAfterBaseType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.attributedType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AttributedTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AttributedTypeSyntax")
  public static func makeBlankAttributedType(presence: SourcePresence = .present) -> AttributedTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .attributedType,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return AttributedTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentListSyntax")
  public static func makeGenericArgumentList(
    _ elements: [GenericArgumentSyntax]) -> GenericArgumentListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgumentList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericArgumentListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentListSyntax")
  public static func makeBlankGenericArgumentList(presence: SourcePresence = .present) -> GenericArgumentListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericArgumentList,
        from: [
      ], arena: arena))
      return GenericArgumentListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentSyntax")
  public static func makeGenericArgument(_ unexpectedBeforeArgumentType: UnexpectedNodesSyntax? = nil, argumentType: TypeSyntax, _ unexpectedBetweenArgumentTypeAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> GenericArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeArgumentType?.raw,
      argumentType.raw,
      unexpectedBetweenArgumentTypeAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgument,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericArgumentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentSyntax")
  public static func makeBlankGenericArgument(presence: SourcePresence = .present) -> GenericArgumentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericArgument,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return GenericArgumentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on GenericArgumentClauseSyntax")
  public static func makeGenericArgumentClause(_ unexpectedBeforeLeftAngleBracket: UnexpectedNodesSyntax? = nil, leftAngleBracket: TokenSyntax, _ unexpectedBetweenLeftAngleBracketAndArguments: UnexpectedNodesSyntax? = nil, arguments: GenericArgumentListSyntax, _ unexpectedBetweenArgumentsAndRightAngleBracket: UnexpectedNodesSyntax? = nil, rightAngleBracket: TokenSyntax, _ unexpectedAfterRightAngleBracket: UnexpectedNodesSyntax? = nil) -> GenericArgumentClauseSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftAngleBracket?.raw,
      leftAngleBracket.raw,
      unexpectedBetweenLeftAngleBracketAndArguments?.raw,
      arguments.raw,
      unexpectedBetweenArgumentsAndRightAngleBracket?.raw,
      rightAngleBracket.raw,
      unexpectedAfterRightAngleBracket?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.genericArgumentClause,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return GenericArgumentClauseSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on GenericArgumentClauseSyntax")
  public static func makeBlankGenericArgumentClause(presence: SourcePresence = .present) -> GenericArgumentClauseSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .genericArgumentClause,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftAngle, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericArgumentList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightAngle, arena: arena),
        nil,
      ], arena: arena))
      return GenericArgumentClauseSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on NamedOpaqueReturnTypeSyntax")
  public static func makeNamedOpaqueReturnType(_ unexpectedBeforeGenericParameters: UnexpectedNodesSyntax? = nil, genericParameters: GenericParameterClauseSyntax, _ unexpectedBetweenGenericParametersAndBaseType: UnexpectedNodesSyntax? = nil, baseType: TypeSyntax, _ unexpectedAfterBaseType: UnexpectedNodesSyntax? = nil) -> NamedOpaqueReturnTypeSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeGenericParameters?.raw,
      genericParameters.raw,
      unexpectedBetweenGenericParametersAndBaseType?.raw,
      baseType.raw,
      unexpectedAfterBaseType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.namedOpaqueReturnType,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return NamedOpaqueReturnTypeSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on NamedOpaqueReturnTypeSyntax")
  public static func makeBlankNamedOpaqueReturnType(presence: SourcePresence = .present) -> NamedOpaqueReturnTypeSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .namedOpaqueReturnType,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.genericParameterClause, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return NamedOpaqueReturnTypeSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TypeAnnotationSyntax")
  public static func makeTypeAnnotation(_ unexpectedBeforeColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedAfterType: UnexpectedNodesSyntax? = nil) -> TypeAnnotationSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndType?.raw,
      type.raw,
      unexpectedAfterType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.typeAnnotation,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TypeAnnotationSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TypeAnnotationSyntax")
  public static func makeBlankTypeAnnotation(presence: SourcePresence = .present) -> TypeAnnotationSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .typeAnnotation,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return TypeAnnotationSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on EnumCasePatternSyntax")
  public static func makeEnumCasePattern(_ unexpectedBeforeType: UnexpectedNodesSyntax? = nil, type: TypeSyntax?, _ unexpectedBetweenTypeAndPeriod: UnexpectedNodesSyntax? = nil, period: TokenSyntax, _ unexpectedBetweenPeriodAndCaseName: UnexpectedNodesSyntax? = nil, caseName: TokenSyntax, _ unexpectedBetweenCaseNameAndAssociatedTuple: UnexpectedNodesSyntax? = nil, associatedTuple: TuplePatternSyntax?, _ unexpectedAfterAssociatedTuple: UnexpectedNodesSyntax? = nil) -> EnumCasePatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeType?.raw,
      type?.raw,
      unexpectedBetweenTypeAndPeriod?.raw,
      period.raw,
      unexpectedBetweenPeriodAndCaseName?.raw,
      caseName.raw,
      unexpectedBetweenCaseNameAndAssociatedTuple?.raw,
      associatedTuple?.raw,
      unexpectedAfterAssociatedTuple?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.enumCasePattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return EnumCasePatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on EnumCasePatternSyntax")
  public static func makeBlankEnumCasePattern(presence: SourcePresence = .present) -> EnumCasePatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .enumCasePattern,
        from: [
        nil,
        nil,
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.period, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return EnumCasePatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IsTypePatternSyntax")
  public static func makeIsTypePattern(_ unexpectedBeforeIsKeyword: UnexpectedNodesSyntax? = nil, isKeyword: TokenSyntax, _ unexpectedBetweenIsKeywordAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedAfterType: UnexpectedNodesSyntax? = nil) -> IsTypePatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIsKeyword?.raw,
      isKeyword.raw,
      unexpectedBetweenIsKeywordAndType?.raw,
      type.raw,
      unexpectedAfterType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.isTypePattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IsTypePatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IsTypePatternSyntax")
  public static func makeBlankIsTypePattern(presence: SourcePresence = .present) -> IsTypePatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .isTypePattern,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.isKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return IsTypePatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on OptionalPatternSyntax")
  public static func makeOptionalPattern(_ unexpectedBeforeSubPattern: UnexpectedNodesSyntax? = nil, subPattern: PatternSyntax, _ unexpectedBetweenSubPatternAndQuestionMark: UnexpectedNodesSyntax? = nil, questionMark: TokenSyntax, _ unexpectedAfterQuestionMark: UnexpectedNodesSyntax? = nil) -> OptionalPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeSubPattern?.raw,
      subPattern.raw,
      unexpectedBetweenSubPatternAndQuestionMark?.raw,
      questionMark.raw,
      unexpectedAfterQuestionMark?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.optionalPattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return OptionalPatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on OptionalPatternSyntax")
  public static func makeBlankOptionalPattern(presence: SourcePresence = .present) -> OptionalPatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .optionalPattern,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.postfixQuestionMark, arena: arena),
        nil,
      ], arena: arena))
      return OptionalPatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on IdentifierPatternSyntax")
  public static func makeIdentifierPattern(_ unexpectedBeforeIdentifier: UnexpectedNodesSyntax? = nil, identifier: TokenSyntax, _ unexpectedAfterIdentifier: UnexpectedNodesSyntax? = nil) -> IdentifierPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeIdentifier?.raw,
      identifier.raw,
      unexpectedAfterIdentifier?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.identifierPattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return IdentifierPatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on IdentifierPatternSyntax")
  public static func makeBlankIdentifierPattern(presence: SourcePresence = .present) -> IdentifierPatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .identifierPattern,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.selfKeyword, arena: arena),
        nil,
      ], arena: arena))
      return IdentifierPatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AsTypePatternSyntax")
  public static func makeAsTypePattern(_ unexpectedBeforePattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndAsKeyword: UnexpectedNodesSyntax? = nil, asKeyword: TokenSyntax, _ unexpectedBetweenAsKeywordAndType: UnexpectedNodesSyntax? = nil, type: TypeSyntax, _ unexpectedAfterType: UnexpectedNodesSyntax? = nil) -> AsTypePatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndAsKeyword?.raw,
      asKeyword.raw,
      unexpectedBetweenAsKeywordAndType?.raw,
      type.raw,
      unexpectedAfterType?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.asTypePattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AsTypePatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AsTypePatternSyntax")
  public static func makeBlankAsTypePattern(presence: SourcePresence = .present) -> AsTypePatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .asTypePattern,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.asKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingType, arena: arena),
        nil,
      ], arena: arena))
      return AsTypePatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternSyntax")
  public static func makeTuplePattern(_ unexpectedBeforeLeftParen: UnexpectedNodesSyntax? = nil, leftParen: TokenSyntax, _ unexpectedBetweenLeftParenAndElements: UnexpectedNodesSyntax? = nil, elements: TuplePatternElementListSyntax, _ unexpectedBetweenElementsAndRightParen: UnexpectedNodesSyntax? = nil, rightParen: TokenSyntax, _ unexpectedAfterRightParen: UnexpectedNodesSyntax? = nil) -> TuplePatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLeftParen?.raw,
      leftParen.raw,
      unexpectedBetweenLeftParenAndElements?.raw,
      elements.raw,
      unexpectedBetweenElementsAndRightParen?.raw,
      rightParen.raw,
      unexpectedAfterRightParen?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tuplePattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TuplePatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternSyntax")
  public static func makeBlankTuplePattern(presence: SourcePresence = .present) -> TuplePatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tuplePattern,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.leftParen, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.tuplePatternElementList, arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.rightParen, arena: arena),
        nil,
      ], arena: arena))
      return TuplePatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on WildcardPatternSyntax")
  public static func makeWildcardPattern(_ unexpectedBeforeWildcard: UnexpectedNodesSyntax? = nil, wildcard: TokenSyntax, _ unexpectedBetweenWildcardAndTypeAnnotation: UnexpectedNodesSyntax? = nil, typeAnnotation: TypeAnnotationSyntax?, _ unexpectedAfterTypeAnnotation: UnexpectedNodesSyntax? = nil) -> WildcardPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeWildcard?.raw,
      wildcard.raw,
      unexpectedBetweenWildcardAndTypeAnnotation?.raw,
      typeAnnotation?.raw,
      unexpectedAfterTypeAnnotation?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.wildcardPattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return WildcardPatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on WildcardPatternSyntax")
  public static func makeBlankWildcardPattern(presence: SourcePresence = .present) -> WildcardPatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .wildcardPattern,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.wildcardKeyword, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return WildcardPatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternElementSyntax")
  public static func makeTuplePatternElement(_ unexpectedBeforeLabelName: UnexpectedNodesSyntax? = nil, labelName: TokenSyntax?, _ unexpectedBetweenLabelNameAndLabelColon: UnexpectedNodesSyntax? = nil, labelColon: TokenSyntax?, _ unexpectedBetweenLabelColonAndPattern: UnexpectedNodesSyntax? = nil, pattern: PatternSyntax, _ unexpectedBetweenPatternAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> TuplePatternElementSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabelName?.raw,
      labelName?.raw,
      unexpectedBetweenLabelNameAndLabelColon?.raw,
      labelColon?.raw,
      unexpectedBetweenLabelColonAndPattern?.raw,
      pattern.raw,
      unexpectedBetweenPatternAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tuplePatternElement,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TuplePatternElementSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternElementSyntax")
  public static func makeBlankTuplePatternElement(presence: SourcePresence = .present) -> TuplePatternElementSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tuplePatternElement,
        from: [
        nil,
        nil,
        nil,
        nil,
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return TuplePatternElementSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ExpressionPatternSyntax")
  public static func makeExpressionPattern(_ unexpectedBeforeExpression: UnexpectedNodesSyntax? = nil, expression: ExprSyntax, _ unexpectedAfterExpression: UnexpectedNodesSyntax? = nil) -> ExpressionPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeExpression?.raw,
      expression.raw,
      unexpectedAfterExpression?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.expressionPattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ExpressionPatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ExpressionPatternSyntax")
  public static func makeBlankExpressionPattern(presence: SourcePresence = .present) -> ExpressionPatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .expressionPattern,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingExpr, arena: arena),
        nil,
      ], arena: arena))
      return ExpressionPatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on TuplePatternElementListSyntax")
  public static func makeTuplePatternElementList(
    _ elements: [TuplePatternElementSyntax]) -> TuplePatternElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.tuplePatternElementList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return TuplePatternElementListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on TuplePatternElementListSyntax")
  public static func makeBlankTuplePatternElementList(presence: SourcePresence = .present) -> TuplePatternElementListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .tuplePatternElementList,
        from: [
      ], arena: arena))
      return TuplePatternElementListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on ValueBindingPatternSyntax")
  public static func makeValueBindingPattern(_ unexpectedBeforeLetOrVarKeyword: UnexpectedNodesSyntax? = nil, letOrVarKeyword: TokenSyntax, _ unexpectedBetweenLetOrVarKeywordAndValuePattern: UnexpectedNodesSyntax? = nil, valuePattern: PatternSyntax, _ unexpectedAfterValuePattern: UnexpectedNodesSyntax? = nil) -> ValueBindingPatternSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLetOrVarKeyword?.raw,
      letOrVarKeyword.raw,
      unexpectedBetweenLetOrVarKeywordAndValuePattern?.raw,
      valuePattern.raw,
      unexpectedAfterValuePattern?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.valueBindingPattern,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return ValueBindingPatternSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on ValueBindingPatternSyntax")
  public static func makeBlankValueBindingPattern(presence: SourcePresence = .present) -> ValueBindingPatternSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .valueBindingPattern,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.letKeyword, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missingPattern, arena: arena),
        nil,
      ], arena: arena))
      return ValueBindingPatternSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AvailabilitySpecListSyntax")
  public static func makeAvailabilitySpecList(
    _ elements: [AvailabilityArgumentSyntax]) -> AvailabilitySpecListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilitySpecList,
        from: elements.map { $0.raw }, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AvailabilitySpecListSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AvailabilitySpecListSyntax")
  public static func makeBlankAvailabilitySpecList(presence: SourcePresence = .present) -> AvailabilitySpecListSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilitySpecList,
        from: [
      ], arena: arena))
      return AvailabilitySpecListSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityArgumentSyntax")
  public static func makeAvailabilityArgument(_ unexpectedBeforeEntry: UnexpectedNodesSyntax? = nil, entry: Syntax, _ unexpectedBetweenEntryAndTrailingComma: UnexpectedNodesSyntax? = nil, trailingComma: TokenSyntax?, _ unexpectedAfterTrailingComma: UnexpectedNodesSyntax? = nil) -> AvailabilityArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeEntry?.raw,
      entry.raw,
      unexpectedBetweenEntryAndTrailingComma?.raw,
      trailingComma?.raw,
      unexpectedAfterTrailingComma?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityArgument,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AvailabilityArgumentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityArgumentSyntax")
  public static func makeBlankAvailabilityArgument(presence: SourcePresence = .present) -> AvailabilityArgumentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityArgument,
        from: [
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return AvailabilityArgumentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityLabeledArgumentSyntax")
  public static func makeAvailabilityLabeledArgument(_ unexpectedBeforeLabel: UnexpectedNodesSyntax? = nil, label: TokenSyntax, _ unexpectedBetweenLabelAndColon: UnexpectedNodesSyntax? = nil, colon: TokenSyntax, _ unexpectedBetweenColonAndValue: UnexpectedNodesSyntax? = nil, value: Syntax, _ unexpectedAfterValue: UnexpectedNodesSyntax? = nil) -> AvailabilityLabeledArgumentSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeLabel?.raw,
      label.raw,
      unexpectedBetweenLabelAndColon?.raw,
      colon.raw,
      unexpectedBetweenColonAndValue?.raw,
      value.raw,
      unexpectedAfterValue?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityLabeledArgument,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AvailabilityLabeledArgumentSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityLabeledArgumentSyntax")
  public static func makeBlankAvailabilityLabeledArgument(presence: SourcePresence = .present) -> AvailabilityLabeledArgumentSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityLabeledArgument,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.colon, arena: arena),
        nil,
        RawSyntax.makeEmptyLayout(kind: SyntaxKind.missing, arena: arena),
        nil,
      ], arena: arena))
      return AvailabilityLabeledArgumentSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on AvailabilityVersionRestrictionSyntax")
  public static func makeAvailabilityVersionRestriction(_ unexpectedBeforePlatform: UnexpectedNodesSyntax? = nil, platform: TokenSyntax, _ unexpectedBetweenPlatformAndVersion: UnexpectedNodesSyntax? = nil, version: VersionTupleSyntax?, _ unexpectedAfterVersion: UnexpectedNodesSyntax? = nil) -> AvailabilityVersionRestrictionSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforePlatform?.raw,
      platform.raw,
      unexpectedBetweenPlatformAndVersion?.raw,
      version?.raw,
      unexpectedAfterVersion?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.availabilityVersionRestriction,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return AvailabilityVersionRestrictionSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on AvailabilityVersionRestrictionSyntax")
  public static func makeBlankAvailabilityVersionRestriction(presence: SourcePresence = .present) -> AvailabilityVersionRestrictionSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .availabilityVersionRestriction,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.identifier(""), arena: arena),
        nil,
        nil,
        nil,
      ], arena: arena))
      return AvailabilityVersionRestrictionSyntax(data)
    }
  }
  @available(*, deprecated, message: "Use initializer on VersionTupleSyntax")
  public static func makeVersionTuple(_ unexpectedBeforeMajorMinor: UnexpectedNodesSyntax? = nil, majorMinor: TokenSyntax, _ unexpectedBetweenMajorMinorAndPatchPeriod: UnexpectedNodesSyntax? = nil, patchPeriod: TokenSyntax?, _ unexpectedBetweenPatchPeriodAndPatchVersion: UnexpectedNodesSyntax? = nil, patchVersion: TokenSyntax?, _ unexpectedAfterPatchVersion: UnexpectedNodesSyntax? = nil) -> VersionTupleSyntax {
    let layout: [RawSyntax?] = [
      unexpectedBeforeMajorMinor?.raw,
      majorMinor.raw,
      unexpectedBetweenMajorMinorAndPatchPeriod?.raw,
      patchPeriod?.raw,
      unexpectedBetweenPatchPeriodAndPatchVersion?.raw,
      patchVersion?.raw,
      unexpectedAfterPatchVersion?.raw,
    ]
    return withExtendedLifetime(SyntaxArena()) { arena in
      let raw = RawSyntax.makeLayout(kind: SyntaxKind.versionTuple,
        from: layout, arena: arena)
      let data = SyntaxData.forRoot(raw)
      return VersionTupleSyntax(data)
    }
  }

  @available(*, deprecated, message: "Use initializer on VersionTupleSyntax")
  public static func makeBlankVersionTuple(presence: SourcePresence = .present) -> VersionTupleSyntax {
    return withExtendedLifetime(SyntaxArena()) { arena in
      let data = SyntaxData.forRoot(RawSyntax.makeLayout(kind: .versionTuple,
        from: [
        nil,
        RawSyntax.makeMissingToken(kind: TokenKind.integerLiteral(""), arena: arena),
        nil,
        nil,
        nil,
        nil,
        nil,
      ], arena: arena))
      return VersionTupleSyntax(data)
    }
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
    trailingTrivia: Trivia = []
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
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
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
    return makeGenericParameter(attributes: nil, name: name, ellipsis: nil,
                                colon: nil, inheritedType: nil,
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
