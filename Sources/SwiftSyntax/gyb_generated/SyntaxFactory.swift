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
  public static func makeToken(_ kind: TokenKind, presence: SourcePresence,
                               leadingTrivia: Trivia = [],
                               trailingTrivia: Trivia = []) -> TokenSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: kind, leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia, presence: presence)
    let data = SyntaxData.forRoot(raw)
    return TokenSyntax(data)
  }

  public static func makeUnknownSyntax(tokens: [TokenSyntax]) -> UnknownSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: .unknown,
      layout: tokens.map { $0.raw }, presence: .present)
    let data = SyntaxData.forRoot(raw)
    return UnknownSyntax(data)
  }

/// MARK: Syntax Node Creation APIs







  public static func makeBlankUnknownDecl(presence: SourcePresence = .present) -> UnknownDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownDecl,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownDeclSyntax(data)
  }

  public static func makeBlankUnknownExpr(presence: SourcePresence = .present) -> UnknownExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownExpr,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownExprSyntax(data)
  }

  public static func makeBlankUnknownStmt(presence: SourcePresence = .present) -> UnknownStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownStmt,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownStmtSyntax(data)
  }

  public static func makeBlankUnknownType(presence: SourcePresence = .present) -> UnknownTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownType,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownTypeSyntax(data)
  }

  public static func makeBlankUnknownPattern(presence: SourcePresence = .present) -> UnknownPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unknownPattern,
      layout: [
    ], length: .zero, presence: presence))
    return UnknownPatternSyntax(data)
  }
  public static func makeCodeBlockItem(item: Syntax, semicolon: TokenSyntax?, errorTokens: Syntax?) -> CodeBlockItemSyntax {
    let layout: [RawSyntax?] = [
      item.raw,
      semicolon?.raw,
      errorTokens?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.codeBlockItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockItemSyntax(data)
  }

  public static func makeBlankCodeBlockItem(presence: SourcePresence = .present) -> CodeBlockItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .codeBlockItem,
      layout: [
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CodeBlockItemSyntax(data)
  }
  public static func makeCodeBlockItemList(
    _ elements: [CodeBlockItemSyntax]) -> CodeBlockItemListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.codeBlockItemList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockItemListSyntax(data)
  }

  public static func makeBlankCodeBlockItemList(presence: SourcePresence = .present) -> CodeBlockItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .codeBlockItemList,
      layout: [
    ], length: .zero, presence: presence))
    return CodeBlockItemListSyntax(data)
  }
  public static func makeCodeBlock(leftBrace: TokenSyntax, statements: CodeBlockItemListSyntax, rightBrace: TokenSyntax) -> CodeBlockSyntax {
    let layout: [RawSyntax?] = [
      leftBrace.raw,
      statements.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.codeBlock,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CodeBlockSyntax(data)
  }

  public static func makeBlankCodeBlock(presence: SourcePresence = .present) -> CodeBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .codeBlock,
      layout: [
      RawSyntax.missingToken(TokenKind.leftBrace),
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return CodeBlockSyntax(data)
  }
  public static func makeInOutExpr(ampersand: TokenSyntax, expression: ExprSyntax) -> InOutExprSyntax {
    let layout: [RawSyntax?] = [
      ampersand.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.inOutExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InOutExprSyntax(data)
  }

  public static func makeBlankInOutExpr(presence: SourcePresence = .present) -> InOutExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .inOutExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.prefixAmpersand),
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return InOutExprSyntax(data)
  }
  public static func makePoundColumnExpr(poundColumn: TokenSyntax) -> PoundColumnExprSyntax {
    let layout: [RawSyntax?] = [
      poundColumn.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundColumnExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundColumnExprSyntax(data)
  }

  public static func makeBlankPoundColumnExpr(presence: SourcePresence = .present) -> PoundColumnExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundColumnExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundColumnKeyword),
    ], length: .zero, presence: presence))
    return PoundColumnExprSyntax(data)
  }
  public static func makeTupleExprElementList(
    _ elements: [TupleExprElementSyntax]) -> TupleExprElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleExprElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleExprElementListSyntax(data)
  }

  public static func makeBlankTupleExprElementList(presence: SourcePresence = .present) -> TupleExprElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleExprElementList,
      layout: [
    ], length: .zero, presence: presence))
    return TupleExprElementListSyntax(data)
  }
  public static func makeArrayElementList(
    _ elements: [ArrayElementSyntax]) -> ArrayElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrayElementListSyntax(data)
  }

  public static func makeBlankArrayElementList(presence: SourcePresence = .present) -> ArrayElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrayElementList,
      layout: [
    ], length: .zero, presence: presence))
    return ArrayElementListSyntax(data)
  }
  public static func makeDictionaryElementList(
    _ elements: [DictionaryElementSyntax]) -> DictionaryElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DictionaryElementListSyntax(data)
  }

  public static func makeBlankDictionaryElementList(presence: SourcePresence = .present) -> DictionaryElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .dictionaryElementList,
      layout: [
    ], length: .zero, presence: presence))
    return DictionaryElementListSyntax(data)
  }
  public static func makeStringLiteralSegments(
    _ elements: [Syntax]) -> StringLiteralSegmentsSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.stringLiteralSegments,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return StringLiteralSegmentsSyntax(data)
  }

  public static func makeBlankStringLiteralSegments(presence: SourcePresence = .present) -> StringLiteralSegmentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .stringLiteralSegments,
      layout: [
    ], length: .zero, presence: presence))
    return StringLiteralSegmentsSyntax(data)
  }
  public static func makeTryExpr(tryKeyword: TokenSyntax, questionOrExclamationMark: TokenSyntax?, expression: ExprSyntax) -> TryExprSyntax {
    let layout: [RawSyntax?] = [
      tryKeyword.raw,
      questionOrExclamationMark?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TryExprSyntax(data)
  }

  public static func makeBlankTryExpr(presence: SourcePresence = .present) -> TryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tryExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.tryKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return TryExprSyntax(data)
  }
  public static func makeAwaitExpr(awaitKeyword: TokenSyntax, expression: ExprSyntax) -> AwaitExprSyntax {
    let layout: [RawSyntax?] = [
      awaitKeyword.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.awaitExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AwaitExprSyntax(data)
  }

  public static func makeBlankAwaitExpr(presence: SourcePresence = .present) -> AwaitExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .awaitExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return AwaitExprSyntax(data)
  }
  public static func makeDeclNameArgument(name: TokenSyntax, colon: TokenSyntax) -> DeclNameArgumentSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      colon.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declNameArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentSyntax(data)
  }

  public static func makeBlankDeclNameArgument(presence: SourcePresence = .present) -> DeclNameArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declNameArgument,
      layout: [
      RawSyntax.missingToken(TokenKind.unknown("")),
      RawSyntax.missingToken(TokenKind.colon),
    ], length: .zero, presence: presence))
    return DeclNameArgumentSyntax(data)
  }
  public static func makeDeclNameArgumentList(
    _ elements: [DeclNameArgumentSyntax]) -> DeclNameArgumentListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declNameArgumentList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentListSyntax(data)
  }

  public static func makeBlankDeclNameArgumentList(presence: SourcePresence = .present) -> DeclNameArgumentListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declNameArgumentList,
      layout: [
    ], length: .zero, presence: presence))
    return DeclNameArgumentListSyntax(data)
  }
  public static func makeDeclNameArguments(leftParen: TokenSyntax, arguments: DeclNameArgumentListSyntax, rightParen: TokenSyntax) -> DeclNameArgumentsSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      arguments.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declNameArguments,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclNameArgumentsSyntax(data)
  }

  public static func makeBlankDeclNameArguments(presence: SourcePresence = .present) -> DeclNameArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declNameArguments,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.declNameArgumentList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return DeclNameArgumentsSyntax(data)
  }
  public static func makeIdentifierExpr(identifier: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?) -> IdentifierExprSyntax {
    let layout: [RawSyntax?] = [
      identifier.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.identifierExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IdentifierExprSyntax(data)
  }

  public static func makeBlankIdentifierExpr(presence: SourcePresence = .present) -> IdentifierExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .identifierExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return IdentifierExprSyntax(data)
  }
  public static func makeSuperRefExpr(superKeyword: TokenSyntax) -> SuperRefExprSyntax {
    let layout: [RawSyntax?] = [
      superKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.superRefExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SuperRefExprSyntax(data)
  }

  public static func makeBlankSuperRefExpr(presence: SourcePresence = .present) -> SuperRefExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .superRefExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.superKeyword),
    ], length: .zero, presence: presence))
    return SuperRefExprSyntax(data)
  }
  public static func makeNilLiteralExpr(nilKeyword: TokenSyntax) -> NilLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      nilKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.nilLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return NilLiteralExprSyntax(data)
  }

  public static func makeBlankNilLiteralExpr(presence: SourcePresence = .present) -> NilLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .nilLiteralExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.nilKeyword),
    ], length: .zero, presence: presence))
    return NilLiteralExprSyntax(data)
  }
  public static func makeDiscardAssignmentExpr(wildcard: TokenSyntax) -> DiscardAssignmentExprSyntax {
    let layout: [RawSyntax?] = [
      wildcard.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.discardAssignmentExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DiscardAssignmentExprSyntax(data)
  }

  public static func makeBlankDiscardAssignmentExpr(presence: SourcePresence = .present) -> DiscardAssignmentExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .discardAssignmentExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.wildcardKeyword),
    ], length: .zero, presence: presence))
    return DiscardAssignmentExprSyntax(data)
  }
  public static func makeAssignmentExpr(assignToken: TokenSyntax) -> AssignmentExprSyntax {
    let layout: [RawSyntax?] = [
      assignToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.assignmentExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AssignmentExprSyntax(data)
  }

  public static func makeBlankAssignmentExpr(presence: SourcePresence = .present) -> AssignmentExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .assignmentExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.equal),
    ], length: .zero, presence: presence))
    return AssignmentExprSyntax(data)
  }
  public static func makeSequenceExpr(elements: ExprListSyntax) -> SequenceExprSyntax {
    let layout: [RawSyntax?] = [
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.sequenceExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SequenceExprSyntax(data)
  }

  public static func makeBlankSequenceExpr(presence: SourcePresence = .present) -> SequenceExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .sequenceExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.exprList),
    ], length: .zero, presence: presence))
    return SequenceExprSyntax(data)
  }
  public static func makeExprList(
    _ elements: [ExprSyntax]) -> ExprListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.exprList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExprListSyntax(data)
  }

  public static func makeBlankExprList(presence: SourcePresence = .present) -> ExprListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .exprList,
      layout: [
    ], length: .zero, presence: presence))
    return ExprListSyntax(data)
  }
  public static func makePoundLineExpr(poundLine: TokenSyntax) -> PoundLineExprSyntax {
    let layout: [RawSyntax?] = [
      poundLine.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundLineExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundLineExprSyntax(data)
  }

  public static func makeBlankPoundLineExpr(presence: SourcePresence = .present) -> PoundLineExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundLineExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundLineKeyword),
    ], length: .zero, presence: presence))
    return PoundLineExprSyntax(data)
  }
  public static func makePoundFileExpr(poundFile: TokenSyntax) -> PoundFileExprSyntax {
    let layout: [RawSyntax?] = [
      poundFile.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFileExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundFileExprSyntax(data)
  }

  public static func makeBlankPoundFileExpr(presence: SourcePresence = .present) -> PoundFileExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundFileExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundFileKeyword),
    ], length: .zero, presence: presence))
    return PoundFileExprSyntax(data)
  }
  public static func makePoundFileIDExpr(poundFileID: TokenSyntax) -> PoundFileIDExprSyntax {
    let layout: [RawSyntax?] = [
      poundFileID.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFileIDExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundFileIDExprSyntax(data)
  }

  public static func makeBlankPoundFileIDExpr(presence: SourcePresence = .present) -> PoundFileIDExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundFileIDExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundFileIDKeyword),
    ], length: .zero, presence: presence))
    return PoundFileIDExprSyntax(data)
  }
  public static func makePoundFilePathExpr(poundFilePath: TokenSyntax) -> PoundFilePathExprSyntax {
    let layout: [RawSyntax?] = [
      poundFilePath.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFilePathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundFilePathExprSyntax(data)
  }

  public static func makeBlankPoundFilePathExpr(presence: SourcePresence = .present) -> PoundFilePathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundFilePathExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundFilePathKeyword),
    ], length: .zero, presence: presence))
    return PoundFilePathExprSyntax(data)
  }
  public static func makePoundFunctionExpr(poundFunction: TokenSyntax) -> PoundFunctionExprSyntax {
    let layout: [RawSyntax?] = [
      poundFunction.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundFunctionExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundFunctionExprSyntax(data)
  }

  public static func makeBlankPoundFunctionExpr(presence: SourcePresence = .present) -> PoundFunctionExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundFunctionExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundFunctionKeyword),
    ], length: .zero, presence: presence))
    return PoundFunctionExprSyntax(data)
  }
  public static func makePoundDsohandleExpr(poundDsohandle: TokenSyntax) -> PoundDsohandleExprSyntax {
    let layout: [RawSyntax?] = [
      poundDsohandle.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundDsohandleExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundDsohandleExprSyntax(data)
  }

  public static func makeBlankPoundDsohandleExpr(presence: SourcePresence = .present) -> PoundDsohandleExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundDsohandleExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundDsohandleKeyword),
    ], length: .zero, presence: presence))
    return PoundDsohandleExprSyntax(data)
  }
  public static func makeSymbolicReferenceExpr(identifier: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let layout: [RawSyntax?] = [
      identifier.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.symbolicReferenceExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SymbolicReferenceExprSyntax(data)
  }

  public static func makeBlankSymbolicReferenceExpr(presence: SourcePresence = .present) -> SymbolicReferenceExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .symbolicReferenceExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return SymbolicReferenceExprSyntax(data)
  }
  public static func makePrefixOperatorExpr(operatorToken: TokenSyntax?, postfixExpression: ExprSyntax) -> PrefixOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      operatorToken?.raw,
      postfixExpression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.prefixOperatorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrefixOperatorExprSyntax(data)
  }

  public static func makeBlankPrefixOperatorExpr(presence: SourcePresence = .present) -> PrefixOperatorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .prefixOperatorExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return PrefixOperatorExprSyntax(data)
  }
  public static func makeBinaryOperatorExpr(operatorToken: TokenSyntax) -> BinaryOperatorExprSyntax {
    let layout: [RawSyntax?] = [
      operatorToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.binaryOperatorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BinaryOperatorExprSyntax(data)
  }

  public static func makeBlankBinaryOperatorExpr(presence: SourcePresence = .present) -> BinaryOperatorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .binaryOperatorExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.unknown("")),
    ], length: .zero, presence: presence))
    return BinaryOperatorExprSyntax(data)
  }
  public static func makeArrowExpr(asyncKeyword: TokenSyntax?, throwsToken: TokenSyntax?, arrowToken: TokenSyntax) -> ArrowExprSyntax {
    let layout: [RawSyntax?] = [
      asyncKeyword?.raw,
      throwsToken?.raw,
      arrowToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrowExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrowExprSyntax(data)
  }

  public static func makeBlankArrowExpr(presence: SourcePresence = .present) -> ArrowExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrowExpr,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.arrow),
    ], length: .zero, presence: presence))
    return ArrowExprSyntax(data)
  }
  public static func makeFloatLiteralExpr(floatingDigits: TokenSyntax) -> FloatLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      floatingDigits.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.floatLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FloatLiteralExprSyntax(data)
  }

  public static func makeBlankFloatLiteralExpr(presence: SourcePresence = .present) -> FloatLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .floatLiteralExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.floatingLiteral("")),
    ], length: .zero, presence: presence))
    return FloatLiteralExprSyntax(data)
  }
  public static func makeTupleExpr(leftParen: TokenSyntax, elementList: TupleExprElementListSyntax, rightParen: TokenSyntax) -> TupleExprSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      elementList.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleExprSyntax(data)
  }

  public static func makeBlankTupleExpr(presence: SourcePresence = .present) -> TupleExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return TupleExprSyntax(data)
  }
  public static func makeArrayExpr(leftSquare: TokenSyntax, elements: ArrayElementListSyntax, rightSquare: TokenSyntax) -> ArrayExprSyntax {
    let layout: [RawSyntax?] = [
      leftSquare.raw,
      elements.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrayExprSyntax(data)
  }

  public static func makeBlankArrayExpr(presence: SourcePresence = .present) -> ArrayExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrayExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      RawSyntax.missing(SyntaxKind.arrayElementList),
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return ArrayExprSyntax(data)
  }
  public static func makeDictionaryExpr(leftSquare: TokenSyntax, content: Syntax, rightSquare: TokenSyntax) -> DictionaryExprSyntax {
    let layout: [RawSyntax?] = [
      leftSquare.raw,
      content.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DictionaryExprSyntax(data)
  }

  public static func makeBlankDictionaryExpr(presence: SourcePresence = .present) -> DictionaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .dictionaryExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      RawSyntax.missing(SyntaxKind.unknown),
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return DictionaryExprSyntax(data)
  }
  public static func makeTupleExprElement(label: TokenSyntax?, colon: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> TupleExprElementSyntax {
    let layout: [RawSyntax?] = [
      label?.raw,
      colon?.raw,
      expression.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleExprElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleExprElementSyntax(data)
  }

  public static func makeBlankTupleExprElement(presence: SourcePresence = .present) -> TupleExprElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleExprElement,
      layout: [
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.expr),
      nil,
    ], length: .zero, presence: presence))
    return TupleExprElementSyntax(data)
  }
  public static func makeArrayElement(expression: ExprSyntax, trailingComma: TokenSyntax?) -> ArrayElementSyntax {
    let layout: [RawSyntax?] = [
      expression.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrayElementSyntax(data)
  }

  public static func makeBlankArrayElement(presence: SourcePresence = .present) -> ArrayElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrayElement,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      nil,
    ], length: .zero, presence: presence))
    return ArrayElementSyntax(data)
  }
  public static func makeDictionaryElement(keyExpression: ExprSyntax, colon: TokenSyntax, valueExpression: ExprSyntax, trailingComma: TokenSyntax?) -> DictionaryElementSyntax {
    let layout: [RawSyntax?] = [
      keyExpression.raw,
      colon.raw,
      valueExpression.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DictionaryElementSyntax(data)
  }

  public static func makeBlankDictionaryElement(presence: SourcePresence = .present) -> DictionaryElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .dictionaryElement,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.expr),
      nil,
    ], length: .zero, presence: presence))
    return DictionaryElementSyntax(data)
  }
  public static func makeIntegerLiteralExpr(digits: TokenSyntax) -> IntegerLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      digits.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.integerLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IntegerLiteralExprSyntax(data)
  }

  public static func makeBlankIntegerLiteralExpr(presence: SourcePresence = .present) -> IntegerLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .integerLiteralExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
    ], length: .zero, presence: presence))
    return IntegerLiteralExprSyntax(data)
  }
  public static func makeBooleanLiteralExpr(booleanLiteral: TokenSyntax) -> BooleanLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      booleanLiteral.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.booleanLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BooleanLiteralExprSyntax(data)
  }

  public static func makeBlankBooleanLiteralExpr(presence: SourcePresence = .present) -> BooleanLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .booleanLiteralExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.trueKeyword),
    ], length: .zero, presence: presence))
    return BooleanLiteralExprSyntax(data)
  }
  public static func makeTernaryExpr(conditionExpression: ExprSyntax, questionMark: TokenSyntax, firstChoice: ExprSyntax, colonMark: TokenSyntax, secondChoice: ExprSyntax) -> TernaryExprSyntax {
    let layout: [RawSyntax?] = [
      conditionExpression.raw,
      questionMark.raw,
      firstChoice.raw,
      colonMark.raw,
      secondChoice.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ternaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TernaryExprSyntax(data)
  }

  public static func makeBlankTernaryExpr(presence: SourcePresence = .present) -> TernaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ternaryExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.infixQuestionMark),
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return TernaryExprSyntax(data)
  }
  public static func makeMemberAccessExpr(base: ExprSyntax?, dot: TokenSyntax, name: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?) -> MemberAccessExprSyntax {
    let layout: [RawSyntax?] = [
      base?.raw,
      dot.raw,
      name.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberAccessExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberAccessExprSyntax(data)
  }

  public static func makeBlankMemberAccessExpr(presence: SourcePresence = .present) -> MemberAccessExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberAccessExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.period),
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
    ], length: .zero, presence: presence))
    return MemberAccessExprSyntax(data)
  }
  public static func makeIsExpr(isTok: TokenSyntax, typeName: TypeSyntax) -> IsExprSyntax {
    let layout: [RawSyntax?] = [
      isTok.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.isExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IsExprSyntax(data)
  }

  public static func makeBlankIsExpr(presence: SourcePresence = .present) -> IsExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .isExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.isKeyword),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return IsExprSyntax(data)
  }
  public static func makeAsExpr(asTok: TokenSyntax, questionOrExclamationMark: TokenSyntax?, typeName: TypeSyntax) -> AsExprSyntax {
    let layout: [RawSyntax?] = [
      asTok.raw,
      questionOrExclamationMark?.raw,
      typeName.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.asExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AsExprSyntax(data)
  }

  public static func makeBlankAsExpr(presence: SourcePresence = .present) -> AsExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .asExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.asKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return AsExprSyntax(data)
  }
  public static func makeTypeExpr(type: TypeSyntax) -> TypeExprSyntax {
    let layout: [RawSyntax?] = [
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypeExprSyntax(data)
  }

  public static func makeBlankTypeExpr(presence: SourcePresence = .present) -> TypeExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typeExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return TypeExprSyntax(data)
  }
  public static func makeClosureCaptureItem(specifier: TokenListSyntax?, name: TokenSyntax?, assignToken: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> ClosureCaptureItemSyntax {
    let layout: [RawSyntax?] = [
      specifier?.raw,
      name?.raw,
      assignToken?.raw,
      expression.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureCaptureItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureItemSyntax(data)
  }

  public static func makeBlankClosureCaptureItem(presence: SourcePresence = .present) -> ClosureCaptureItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureCaptureItem,
      layout: [
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.expr),
      nil,
    ], length: .zero, presence: presence))
    return ClosureCaptureItemSyntax(data)
  }
  public static func makeClosureCaptureItemList(
    _ elements: [ClosureCaptureItemSyntax]) -> ClosureCaptureItemListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureCaptureItemList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureItemListSyntax(data)
  }

  public static func makeBlankClosureCaptureItemList(presence: SourcePresence = .present) -> ClosureCaptureItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureCaptureItemList,
      layout: [
    ], length: .zero, presence: presence))
    return ClosureCaptureItemListSyntax(data)
  }
  public static func makeClosureCaptureSignature(leftSquare: TokenSyntax, items: ClosureCaptureItemListSyntax?, rightSquare: TokenSyntax) -> ClosureCaptureSignatureSyntax {
    let layout: [RawSyntax?] = [
      leftSquare.raw,
      items?.raw,
      rightSquare.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureCaptureSignature,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureCaptureSignatureSyntax(data)
  }

  public static func makeBlankClosureCaptureSignature(presence: SourcePresence = .present) -> ClosureCaptureSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureCaptureSignature,
      layout: [
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      nil,
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return ClosureCaptureSignatureSyntax(data)
  }
  public static func makeClosureParam(name: TokenSyntax, trailingComma: TokenSyntax?) -> ClosureParamSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureParam,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureParamSyntax(data)
  }

  public static func makeBlankClosureParam(presence: SourcePresence = .present) -> ClosureParamSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureParam,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return ClosureParamSyntax(data)
  }
  public static func makeClosureParamList(
    _ elements: [ClosureParamSyntax]) -> ClosureParamListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureParamList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureParamListSyntax(data)
  }

  public static func makeBlankClosureParamList(presence: SourcePresence = .present) -> ClosureParamListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureParamList,
      layout: [
    ], length: .zero, presence: presence))
    return ClosureParamListSyntax(data)
  }
  public static func makeClosureSignature(attributes: AttributeListSyntax?, capture: ClosureCaptureSignatureSyntax?, input: Syntax?, asyncKeyword: TokenSyntax?, throwsTok: TokenSyntax?, output: ReturnClauseSyntax?, inTok: TokenSyntax) -> ClosureSignatureSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      capture?.raw,
      input?.raw,
      asyncKeyword?.raw,
      throwsTok?.raw,
      output?.raw,
      inTok.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureSignature,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureSignatureSyntax(data)
  }

  public static func makeBlankClosureSignature(presence: SourcePresence = .present) -> ClosureSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureSignature,
      layout: [
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
  public static func makeClosureExpr(leftBrace: TokenSyntax, signature: ClosureSignatureSyntax?, statements: CodeBlockItemListSyntax, rightBrace: TokenSyntax) -> ClosureExprSyntax {
    let layout: [RawSyntax?] = [
      leftBrace.raw,
      signature?.raw,
      statements.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.closureExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClosureExprSyntax(data)
  }

  public static func makeBlankClosureExpr(presence: SourcePresence = .present) -> ClosureExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .closureExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.leftBrace),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return ClosureExprSyntax(data)
  }
  public static func makeUnresolvedPatternExpr(pattern: PatternSyntax) -> UnresolvedPatternExprSyntax {
    let layout: [RawSyntax?] = [
      pattern.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unresolvedPatternExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return UnresolvedPatternExprSyntax(data)
  }

  public static func makeBlankUnresolvedPatternExpr(presence: SourcePresence = .present) -> UnresolvedPatternExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unresolvedPatternExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.pattern),
    ], length: .zero, presence: presence))
    return UnresolvedPatternExprSyntax(data)
  }
  public static func makeMultipleTrailingClosureElement(label: TokenSyntax, colon: TokenSyntax, closure: ClosureExprSyntax) -> MultipleTrailingClosureElementSyntax {
    let layout: [RawSyntax?] = [
      label.raw,
      colon.raw,
      closure.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.multipleTrailingClosureElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MultipleTrailingClosureElementSyntax(data)
  }

  public static func makeBlankMultipleTrailingClosureElement(presence: SourcePresence = .present) -> MultipleTrailingClosureElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .multipleTrailingClosureElement,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.closureExpr),
    ], length: .zero, presence: presence))
    return MultipleTrailingClosureElementSyntax(data)
  }
  public static func makeMultipleTrailingClosureElementList(
    _ elements: [MultipleTrailingClosureElementSyntax]) -> MultipleTrailingClosureElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.multipleTrailingClosureElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MultipleTrailingClosureElementListSyntax(data)
  }

  public static func makeBlankMultipleTrailingClosureElementList(presence: SourcePresence = .present) -> MultipleTrailingClosureElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .multipleTrailingClosureElementList,
      layout: [
    ], length: .zero, presence: presence))
    return MultipleTrailingClosureElementListSyntax(data)
  }
  public static func makeFunctionCallExpr(calledExpression: ExprSyntax, leftParen: TokenSyntax?, argumentList: TupleExprElementListSyntax, rightParen: TokenSyntax?, trailingClosure: ClosureExprSyntax?, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?) -> FunctionCallExprSyntax {
    let layout: [RawSyntax?] = [
      calledExpression.raw,
      leftParen?.raw,
      argumentList.raw,
      rightParen?.raw,
      trailingClosure?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionCallExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionCallExprSyntax(data)
  }

  public static func makeBlankFunctionCallExpr(presence: SourcePresence = .present) -> FunctionCallExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionCallExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      nil,
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return FunctionCallExprSyntax(data)
  }
  public static func makeSubscriptExpr(calledExpression: ExprSyntax, leftBracket: TokenSyntax, argumentList: TupleExprElementListSyntax, rightBracket: TokenSyntax, trailingClosure: ClosureExprSyntax?, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?) -> SubscriptExprSyntax {
    let layout: [RawSyntax?] = [
      calledExpression.raw,
      leftBracket.raw,
      argumentList.raw,
      rightBracket.raw,
      trailingClosure?.raw,
      additionalTrailingClosures?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.subscriptExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SubscriptExprSyntax(data)
  }

  public static func makeBlankSubscriptExpr(presence: SourcePresence = .present) -> SubscriptExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .subscriptExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return SubscriptExprSyntax(data)
  }
  public static func makeOptionalChainingExpr(expression: ExprSyntax, questionMark: TokenSyntax) -> OptionalChainingExprSyntax {
    let layout: [RawSyntax?] = [
      expression.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalChainingExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OptionalChainingExprSyntax(data)
  }

  public static func makeBlankOptionalChainingExpr(presence: SourcePresence = .present) -> OptionalChainingExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .optionalChainingExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
    ], length: .zero, presence: presence))
    return OptionalChainingExprSyntax(data)
  }
  public static func makeForcedValueExpr(expression: ExprSyntax, exclamationMark: TokenSyntax) -> ForcedValueExprSyntax {
    let layout: [RawSyntax?] = [
      expression.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.forcedValueExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ForcedValueExprSyntax(data)
  }

  public static func makeBlankForcedValueExpr(presence: SourcePresence = .present) -> ForcedValueExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .forcedValueExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.exclamationMark),
    ], length: .zero, presence: presence))
    return ForcedValueExprSyntax(data)
  }
  public static func makePostfixUnaryExpr(expression: ExprSyntax, operatorToken: TokenSyntax) -> PostfixUnaryExprSyntax {
    let layout: [RawSyntax?] = [
      expression.raw,
      operatorToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.postfixUnaryExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PostfixUnaryExprSyntax(data)
  }

  public static func makeBlankPostfixUnaryExpr(presence: SourcePresence = .present) -> PostfixUnaryExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .postfixUnaryExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.postfixOperator("")),
    ], length: .zero, presence: presence))
    return PostfixUnaryExprSyntax(data)
  }
  public static func makeSpecializeExpr(expression: ExprSyntax, genericArgumentClause: GenericArgumentClauseSyntax) -> SpecializeExprSyntax {
    let layout: [RawSyntax?] = [
      expression.raw,
      genericArgumentClause.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.specializeExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SpecializeExprSyntax(data)
  }

  public static func makeBlankSpecializeExpr(presence: SourcePresence = .present) -> SpecializeExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .specializeExpr,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
    ], length: .zero, presence: presence))
    return SpecializeExprSyntax(data)
  }
  public static func makeStringSegment(content: TokenSyntax) -> StringSegmentSyntax {
    let layout: [RawSyntax?] = [
      content.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.stringSegment,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return StringSegmentSyntax(data)
  }

  public static func makeBlankStringSegment(presence: SourcePresence = .present) -> StringSegmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .stringSegment,
      layout: [
      RawSyntax.missingToken(TokenKind.stringSegment("")),
    ], length: .zero, presence: presence))
    return StringSegmentSyntax(data)
  }
  public static func makeExpressionSegment(backslash: TokenSyntax, delimiter: TokenSyntax?, leftParen: TokenSyntax, expressions: TupleExprElementListSyntax, rightParen: TokenSyntax) -> ExpressionSegmentSyntax {
    let layout: [RawSyntax?] = [
      backslash.raw,
      delimiter?.raw,
      leftParen.raw,
      expressions.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.expressionSegment,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExpressionSegmentSyntax(data)
  }

  public static func makeBlankExpressionSegment(presence: SourcePresence = .present) -> ExpressionSegmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .expressionSegment,
      layout: [
      RawSyntax.missingToken(TokenKind.backslash),
      nil,
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      RawSyntax.missingToken(TokenKind.stringInterpolationAnchor),
    ], length: .zero, presence: presence))
    return ExpressionSegmentSyntax(data)
  }
  public static func makeStringLiteralExpr(openDelimiter: TokenSyntax?, openQuote: TokenSyntax, segments: StringLiteralSegmentsSyntax, closeQuote: TokenSyntax, closeDelimiter: TokenSyntax?) -> StringLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      openDelimiter?.raw,
      openQuote.raw,
      segments.raw,
      closeQuote.raw,
      closeDelimiter?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.stringLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return StringLiteralExprSyntax(data)
  }

  public static func makeBlankStringLiteralExpr(presence: SourcePresence = .present) -> StringLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .stringLiteralExpr,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.stringQuote),
      RawSyntax.missing(SyntaxKind.stringLiteralSegments),
      RawSyntax.missingToken(TokenKind.stringQuote),
      nil,
    ], length: .zero, presence: presence))
    return StringLiteralExprSyntax(data)
  }
  public static func makeRegexLiteralExpr(regex: TokenSyntax) -> RegexLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      regex.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.regexLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return RegexLiteralExprSyntax(data)
  }

  public static func makeBlankRegexLiteralExpr(presence: SourcePresence = .present) -> RegexLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .regexLiteralExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.regexLiteral("")),
    ], length: .zero, presence: presence))
    return RegexLiteralExprSyntax(data)
  }
  public static func makeKeyPathExpr(backslash: TokenSyntax, rootExpr: ExprSyntax?, expression: ExprSyntax) -> KeyPathExprSyntax {
    let layout: [RawSyntax?] = [
      backslash.raw,
      rootExpr?.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.keyPathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return KeyPathExprSyntax(data)
  }

  public static func makeBlankKeyPathExpr(presence: SourcePresence = .present) -> KeyPathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .keyPathExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.backslash),
      nil,
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return KeyPathExprSyntax(data)
  }
  public static func makeKeyPathBaseExpr(period: TokenSyntax) -> KeyPathBaseExprSyntax {
    let layout: [RawSyntax?] = [
      period.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.keyPathBaseExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return KeyPathBaseExprSyntax(data)
  }

  public static func makeBlankKeyPathBaseExpr(presence: SourcePresence = .present) -> KeyPathBaseExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .keyPathBaseExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.period),
    ], length: .zero, presence: presence))
    return KeyPathBaseExprSyntax(data)
  }
  public static func makeObjcNamePiece(name: TokenSyntax, dot: TokenSyntax?) -> ObjcNamePieceSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      dot?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcNamePiece,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjcNamePieceSyntax(data)
  }

  public static func makeBlankObjcNamePiece(presence: SourcePresence = .present) -> ObjcNamePieceSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objcNamePiece,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return ObjcNamePieceSyntax(data)
  }
  public static func makeObjcName(
    _ elements: [ObjcNamePieceSyntax]) -> ObjcNameSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcName,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjcNameSyntax(data)
  }

  public static func makeBlankObjcName(presence: SourcePresence = .present) -> ObjcNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objcName,
      layout: [
    ], length: .zero, presence: presence))
    return ObjcNameSyntax(data)
  }
  public static func makeObjcKeyPathExpr(keyPath: TokenSyntax, leftParen: TokenSyntax, name: ObjcNameSyntax, rightParen: TokenSyntax) -> ObjcKeyPathExprSyntax {
    let layout: [RawSyntax?] = [
      keyPath.raw,
      leftParen.raw,
      name.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcKeyPathExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjcKeyPathExprSyntax(data)
  }

  public static func makeBlankObjcKeyPathExpr(presence: SourcePresence = .present) -> ObjcKeyPathExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objcKeyPathExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundKeyPathKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.objcName),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return ObjcKeyPathExprSyntax(data)
  }
  public static func makeObjcSelectorExpr(poundSelector: TokenSyntax, leftParen: TokenSyntax, kind: TokenSyntax?, colon: TokenSyntax?, name: ExprSyntax, rightParen: TokenSyntax) -> ObjcSelectorExprSyntax {
    let layout: [RawSyntax?] = [
      poundSelector.raw,
      leftParen.raw,
      kind?.raw,
      colon?.raw,
      name.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objcSelectorExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjcSelectorExprSyntax(data)
  }

  public static func makeBlankObjcSelectorExpr(presence: SourcePresence = .present) -> ObjcSelectorExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objcSelectorExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundSelectorKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return ObjcSelectorExprSyntax(data)
  }
  public static func makePostfixIfConfigExpr(base: ExprSyntax?, config: IfConfigDeclSyntax) -> PostfixIfConfigExprSyntax {
    let layout: [RawSyntax?] = [
      base?.raw,
      config.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.postfixIfConfigExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PostfixIfConfigExprSyntax(data)
  }

  public static func makeBlankPostfixIfConfigExpr(presence: SourcePresence = .present) -> PostfixIfConfigExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .postfixIfConfigExpr,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.ifConfigDecl),
    ], length: .zero, presence: presence))
    return PostfixIfConfigExprSyntax(data)
  }
  public static func makeEditorPlaceholderExpr(identifier: TokenSyntax) -> EditorPlaceholderExprSyntax {
    let layout: [RawSyntax?] = [
      identifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.editorPlaceholderExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EditorPlaceholderExprSyntax(data)
  }

  public static func makeBlankEditorPlaceholderExpr(presence: SourcePresence = .present) -> EditorPlaceholderExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .editorPlaceholderExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
    ], length: .zero, presence: presence))
    return EditorPlaceholderExprSyntax(data)
  }
  public static func makeObjectLiteralExpr(identifier: TokenSyntax, leftParen: TokenSyntax, arguments: TupleExprElementListSyntax, rightParen: TokenSyntax) -> ObjectLiteralExprSyntax {
    let layout: [RawSyntax?] = [
      identifier.raw,
      leftParen.raw,
      arguments.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objectLiteralExpr,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjectLiteralExprSyntax(data)
  }

  public static func makeBlankObjectLiteralExpr(presence: SourcePresence = .present) -> ObjectLiteralExprSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objectLiteralExpr,
      layout: [
      RawSyntax.missingToken(TokenKind.poundColorLiteralKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.tupleExprElementList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return ObjectLiteralExprSyntax(data)
  }
  public static func makeTypeInitializerClause(equal: TokenSyntax, value: TypeSyntax) -> TypeInitializerClauseSyntax {
    let layout: [RawSyntax?] = [
      equal.raw,
      value.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeInitializerClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypeInitializerClauseSyntax(data)
  }

  public static func makeBlankTypeInitializerClause(presence: SourcePresence = .present) -> TypeInitializerClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typeInitializerClause,
      layout: [
      RawSyntax.missingToken(TokenKind.equal),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return TypeInitializerClauseSyntax(data)
  }
  public static func makeTypealiasDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, typealiasKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, initializer: TypeInitializerClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?) -> TypealiasDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      typealiasKeyword.raw,
      identifier.raw,
      genericParameterClause?.raw,
      initializer?.raw,
      genericWhereClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typealiasDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypealiasDeclSyntax(data)
  }

  public static func makeBlankTypealiasDecl(presence: SourcePresence = .present) -> TypealiasDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typealiasDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.typealiasKeyword),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return TypealiasDeclSyntax(data)
  }
  public static func makeAssociatedtypeDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, associatedtypeKeyword: TokenSyntax, identifier: TokenSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, initializer: TypeInitializerClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      associatedtypeKeyword.raw,
      identifier.raw,
      inheritanceClause?.raw,
      initializer?.raw,
      genericWhereClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.associatedtypeDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AssociatedtypeDeclSyntax(data)
  }

  public static func makeBlankAssociatedtypeDecl(presence: SourcePresence = .present) -> AssociatedtypeDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .associatedtypeDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.associatedtypeKeyword),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AssociatedtypeDeclSyntax(data)
  }
  public static func makeFunctionParameterList(
    _ elements: [FunctionParameterSyntax]) -> FunctionParameterListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionParameterList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionParameterListSyntax(data)
  }

  public static func makeBlankFunctionParameterList(presence: SourcePresence = .present) -> FunctionParameterListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionParameterList,
      layout: [
    ], length: .zero, presence: presence))
    return FunctionParameterListSyntax(data)
  }
  public static func makeParameterClause(leftParen: TokenSyntax, parameterList: FunctionParameterListSyntax, rightParen: TokenSyntax) -> ParameterClauseSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      parameterList.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.parameterClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ParameterClauseSyntax(data)
  }

  public static func makeBlankParameterClause(presence: SourcePresence = .present) -> ParameterClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .parameterClause,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.functionParameterList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return ParameterClauseSyntax(data)
  }
  public static func makeReturnClause(arrow: TokenSyntax, returnType: TypeSyntax) -> ReturnClauseSyntax {
    let layout: [RawSyntax?] = [
      arrow.raw,
      returnType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.returnClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ReturnClauseSyntax(data)
  }

  public static func makeBlankReturnClause(presence: SourcePresence = .present) -> ReturnClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .returnClause,
      layout: [
      RawSyntax.missingToken(TokenKind.arrow),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return ReturnClauseSyntax(data)
  }
  public static func makeFunctionSignature(input: ParameterClauseSyntax, asyncOrReasyncKeyword: TokenSyntax?, throwsOrRethrowsKeyword: TokenSyntax?, output: ReturnClauseSyntax?) -> FunctionSignatureSyntax {
    let layout: [RawSyntax?] = [
      input.raw,
      asyncOrReasyncKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      output?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionSignature,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionSignatureSyntax(data)
  }

  public static func makeBlankFunctionSignature(presence: SourcePresence = .present) -> FunctionSignatureSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionSignature,
      layout: [
      RawSyntax.missing(SyntaxKind.parameterClause),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return FunctionSignatureSyntax(data)
  }
  public static func makeIfConfigClause(poundKeyword: TokenSyntax, condition: ExprSyntax?, elements: Syntax) -> IfConfigClauseSyntax {
    let layout: [RawSyntax?] = [
      poundKeyword.raw,
      condition?.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifConfigClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IfConfigClauseSyntax(data)
  }

  public static func makeBlankIfConfigClause(presence: SourcePresence = .present) -> IfConfigClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ifConfigClause,
      layout: [
      RawSyntax.missingToken(TokenKind.poundIfKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return IfConfigClauseSyntax(data)
  }
  public static func makeIfConfigClauseList(
    _ elements: [IfConfigClauseSyntax]) -> IfConfigClauseListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifConfigClauseList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IfConfigClauseListSyntax(data)
  }

  public static func makeBlankIfConfigClauseList(presence: SourcePresence = .present) -> IfConfigClauseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ifConfigClauseList,
      layout: [
    ], length: .zero, presence: presence))
    return IfConfigClauseListSyntax(data)
  }
  public static func makeIfConfigDecl(clauses: IfConfigClauseListSyntax, poundEndif: TokenSyntax) -> IfConfigDeclSyntax {
    let layout: [RawSyntax?] = [
      clauses.raw,
      poundEndif.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifConfigDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IfConfigDeclSyntax(data)
  }

  public static func makeBlankIfConfigDecl(presence: SourcePresence = .present) -> IfConfigDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ifConfigDecl,
      layout: [
      RawSyntax.missing(SyntaxKind.ifConfigClauseList),
      RawSyntax.missingToken(TokenKind.poundEndifKeyword),
    ], length: .zero, presence: presence))
    return IfConfigDeclSyntax(data)
  }
  public static func makePoundErrorDecl(poundError: TokenSyntax, leftParen: TokenSyntax, message: StringLiteralExprSyntax, rightParen: TokenSyntax) -> PoundErrorDeclSyntax {
    let layout: [RawSyntax?] = [
      poundError.raw,
      leftParen.raw,
      message.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundErrorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundErrorDeclSyntax(data)
  }

  public static func makeBlankPoundErrorDecl(presence: SourcePresence = .present) -> PoundErrorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundErrorDecl,
      layout: [
      RawSyntax.missingToken(TokenKind.poundErrorKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.stringLiteralExpr),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return PoundErrorDeclSyntax(data)
  }
  public static func makePoundWarningDecl(poundWarning: TokenSyntax, leftParen: TokenSyntax, message: StringLiteralExprSyntax, rightParen: TokenSyntax) -> PoundWarningDeclSyntax {
    let layout: [RawSyntax?] = [
      poundWarning.raw,
      leftParen.raw,
      message.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundWarningDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundWarningDeclSyntax(data)
  }

  public static func makeBlankPoundWarningDecl(presence: SourcePresence = .present) -> PoundWarningDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundWarningDecl,
      layout: [
      RawSyntax.missingToken(TokenKind.poundWarningKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.stringLiteralExpr),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return PoundWarningDeclSyntax(data)
  }
  public static func makePoundSourceLocation(poundSourceLocation: TokenSyntax, leftParen: TokenSyntax, args: PoundSourceLocationArgsSyntax?, rightParen: TokenSyntax) -> PoundSourceLocationSyntax {
    let layout: [RawSyntax?] = [
      poundSourceLocation.raw,
      leftParen.raw,
      args?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundSourceLocation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundSourceLocationSyntax(data)
  }

  public static func makeBlankPoundSourceLocation(presence: SourcePresence = .present) -> PoundSourceLocationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundSourceLocation,
      layout: [
      RawSyntax.missingToken(TokenKind.poundSourceLocationKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return PoundSourceLocationSyntax(data)
  }
  public static func makePoundSourceLocationArgs(fileArgLabel: TokenSyntax, fileArgColon: TokenSyntax, fileName: TokenSyntax, comma: TokenSyntax, lineArgLabel: TokenSyntax, lineArgColon: TokenSyntax, lineNumber: TokenSyntax) -> PoundSourceLocationArgsSyntax {
    let layout: [RawSyntax?] = [
      fileArgLabel.raw,
      fileArgColon.raw,
      fileName.raw,
      comma.raw,
      lineArgLabel.raw,
      lineArgColon.raw,
      lineNumber.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundSourceLocationArgs,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundSourceLocationArgsSyntax(data)
  }

  public static func makeBlankPoundSourceLocationArgs(presence: SourcePresence = .present) -> PoundSourceLocationArgsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundSourceLocationArgs,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missingToken(TokenKind.stringLiteral("")),
      RawSyntax.missingToken(TokenKind.comma),
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
    ], length: .zero, presence: presence))
    return PoundSourceLocationArgsSyntax(data)
  }
  public static func makeDeclModifier(name: TokenSyntax, detailLeftParen: TokenSyntax?, detail: TokenSyntax?, detailRightParen: TokenSyntax?) -> DeclModifierSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      detailLeftParen?.raw,
      detail?.raw,
      detailRightParen?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declModifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclModifierSyntax(data)
  }

  public static func makeBlankDeclModifier(presence: SourcePresence = .present) -> DeclModifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declModifier,
      layout: [
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DeclModifierSyntax(data)
  }
  public static func makeInheritedType(typeName: TypeSyntax, trailingComma: TokenSyntax?) -> InheritedTypeSyntax {
    let layout: [RawSyntax?] = [
      typeName.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.inheritedType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InheritedTypeSyntax(data)
  }

  public static func makeBlankInheritedType(presence: SourcePresence = .present) -> InheritedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .inheritedType,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      nil,
    ], length: .zero, presence: presence))
    return InheritedTypeSyntax(data)
  }
  public static func makeInheritedTypeList(
    _ elements: [InheritedTypeSyntax]) -> InheritedTypeListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.inheritedTypeList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InheritedTypeListSyntax(data)
  }

  public static func makeBlankInheritedTypeList(presence: SourcePresence = .present) -> InheritedTypeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .inheritedTypeList,
      layout: [
    ], length: .zero, presence: presence))
    return InheritedTypeListSyntax(data)
  }
  public static func makeTypeInheritanceClause(colon: TokenSyntax, inheritedTypeCollection: InheritedTypeListSyntax) -> TypeInheritanceClauseSyntax {
    let layout: [RawSyntax?] = [
      colon.raw,
      inheritedTypeCollection.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeInheritanceClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypeInheritanceClauseSyntax(data)
  }

  public static func makeBlankTypeInheritanceClause(presence: SourcePresence = .present) -> TypeInheritanceClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typeInheritanceClause,
      layout: [
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.inheritedTypeList),
    ], length: .zero, presence: presence))
    return TypeInheritanceClauseSyntax(data)
  }
  public static func makeClassDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, classOrActorKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ClassDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      classOrActorKeyword.raw,
      identifier.raw,
      genericParameterClause?.raw,
      inheritanceClause?.raw,
      genericWhereClause?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.classDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClassDeclSyntax(data)
  }

  public static func makeBlankClassDecl(presence: SourcePresence = .present) -> ClassDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .classDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.classKeyword),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return ClassDeclSyntax(data)
  }
  public static func makeStructDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, structKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> StructDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      structKeyword.raw,
      identifier.raw,
      genericParameterClause?.raw,
      inheritanceClause?.raw,
      genericWhereClause?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.structDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return StructDeclSyntax(data)
  }

  public static func makeBlankStructDecl(presence: SourcePresence = .present) -> StructDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .structDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.structKeyword),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return StructDeclSyntax(data)
  }
  public static func makeProtocolDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, protocolKeyword: TokenSyntax, identifier: TokenSyntax, primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ProtocolDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      protocolKeyword.raw,
      identifier.raw,
      primaryAssociatedTypeClause?.raw,
      inheritanceClause?.raw,
      genericWhereClause?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.protocolDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ProtocolDeclSyntax(data)
  }

  public static func makeBlankProtocolDecl(presence: SourcePresence = .present) -> ProtocolDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .protocolDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.protocolKeyword),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return ProtocolDeclSyntax(data)
  }
  public static func makeExtensionDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, extensionKeyword: TokenSyntax, extendedType: TypeSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ExtensionDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      extensionKeyword.raw,
      extendedType.raw,
      inheritanceClause?.raw,
      genericWhereClause?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.extensionDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExtensionDeclSyntax(data)
  }

  public static func makeBlankExtensionDecl(presence: SourcePresence = .present) -> ExtensionDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .extensionDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.extensionKeyword),
      RawSyntax.missing(SyntaxKind.type),
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return ExtensionDeclSyntax(data)
  }
  public static func makeMemberDeclBlock(leftBrace: TokenSyntax, members: MemberDeclListSyntax, rightBrace: TokenSyntax) -> MemberDeclBlockSyntax {
    let layout: [RawSyntax?] = [
      leftBrace.raw,
      members.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberDeclBlock,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclBlockSyntax(data)
  }

  public static func makeBlankMemberDeclBlock(presence: SourcePresence = .present) -> MemberDeclBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberDeclBlock,
      layout: [
      RawSyntax.missingToken(TokenKind.leftBrace),
      RawSyntax.missing(SyntaxKind.memberDeclList),
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return MemberDeclBlockSyntax(data)
  }
  public static func makeMemberDeclList(
    _ elements: [MemberDeclListItemSyntax]) -> MemberDeclListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberDeclList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclListSyntax(data)
  }

  public static func makeBlankMemberDeclList(presence: SourcePresence = .present) -> MemberDeclListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberDeclList,
      layout: [
    ], length: .zero, presence: presence))
    return MemberDeclListSyntax(data)
  }
  public static func makeMemberDeclListItem(decl: DeclSyntax, semicolon: TokenSyntax?) -> MemberDeclListItemSyntax {
    let layout: [RawSyntax?] = [
      decl.raw,
      semicolon?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberDeclListItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberDeclListItemSyntax(data)
  }

  public static func makeBlankMemberDeclListItem(presence: SourcePresence = .present) -> MemberDeclListItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberDeclListItem,
      layout: [
      RawSyntax.missing(SyntaxKind.decl),
      nil,
    ], length: .zero, presence: presence))
    return MemberDeclListItemSyntax(data)
  }
  public static func makeSourceFile(statements: CodeBlockItemListSyntax, eofToken: TokenSyntax) -> SourceFileSyntax {
    let layout: [RawSyntax?] = [
      statements.raw,
      eofToken.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.sourceFile,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SourceFileSyntax(data)
  }

  public static func makeBlankSourceFile(presence: SourcePresence = .present) -> SourceFileSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .sourceFile,
      layout: [
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
      RawSyntax.missingToken(TokenKind.unknown("")),
    ], length: .zero, presence: presence))
    return SourceFileSyntax(data)
  }
  public static func makeInitializerClause(equal: TokenSyntax, value: ExprSyntax) -> InitializerClauseSyntax {
    let layout: [RawSyntax?] = [
      equal.raw,
      value.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.initializerClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InitializerClauseSyntax(data)
  }

  public static func makeBlankInitializerClause(presence: SourcePresence = .present) -> InitializerClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .initializerClause,
      layout: [
      RawSyntax.missingToken(TokenKind.equal),
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return InitializerClauseSyntax(data)
  }
  public static func makeFunctionParameter(attributes: AttributeListSyntax?, firstName: TokenSyntax?, secondName: TokenSyntax?, colon: TokenSyntax?, type: TypeSyntax?, ellipsis: TokenSyntax?, defaultArgument: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> FunctionParameterSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      firstName?.raw,
      secondName?.raw,
      colon?.raw,
      type?.raw,
      ellipsis?.raw,
      defaultArgument?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionParameter,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionParameterSyntax(data)
  }

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
    ], length: .zero, presence: presence))
    return FunctionParameterSyntax(data)
  }
  public static func makeModifierList(
    _ elements: [DeclModifierSyntax]) -> ModifierListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.modifierList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ModifierListSyntax(data)
  }

  public static func makeBlankModifierList(presence: SourcePresence = .present) -> ModifierListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .modifierList,
      layout: [
    ], length: .zero, presence: presence))
    return ModifierListSyntax(data)
  }
  public static func makeFunctionDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, funcKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, signature: FunctionSignatureSyntax, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      funcKeyword.raw,
      identifier.raw,
      genericParameterClause?.raw,
      signature.raw,
      genericWhereClause?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionDeclSyntax(data)
  }

  public static func makeBlankFunctionDecl(presence: SourcePresence = .present) -> FunctionDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.funcKeyword),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      RawSyntax.missing(SyntaxKind.functionSignature),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return FunctionDeclSyntax(data)
  }
  public static func makeInitializerDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, initKeyword: TokenSyntax, optionalMark: TokenSyntax?, genericParameterClause: GenericParameterClauseSyntax?, parameters: ParameterClauseSyntax, throwsOrRethrowsKeyword: TokenSyntax?, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax?) -> InitializerDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      initKeyword.raw,
      optionalMark?.raw,
      genericParameterClause?.raw,
      parameters.raw,
      throwsOrRethrowsKeyword?.raw,
      genericWhereClause?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.initializerDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return InitializerDeclSyntax(data)
  }

  public static func makeBlankInitializerDecl(presence: SourcePresence = .present) -> InitializerDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .initializerDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.initKeyword),
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.parameterClause),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return InitializerDeclSyntax(data)
  }
  public static func makeDeinitializerDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, deinitKeyword: TokenSyntax, body: CodeBlockSyntax) -> DeinitializerDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      deinitKeyword.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.deinitializerDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeinitializerDeclSyntax(data)
  }

  public static func makeBlankDeinitializerDecl(presence: SourcePresence = .present) -> DeinitializerDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .deinitializerDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.deinitKeyword),
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return DeinitializerDeclSyntax(data)
  }
  public static func makeSubscriptDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, subscriptKeyword: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, indices: ParameterClauseSyntax, result: ReturnClauseSyntax, genericWhereClause: GenericWhereClauseSyntax?, accessor: Syntax?) -> SubscriptDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      subscriptKeyword.raw,
      genericParameterClause?.raw,
      indices.raw,
      result.raw,
      genericWhereClause?.raw,
      accessor?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.subscriptDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SubscriptDeclSyntax(data)
  }

  public static func makeBlankSubscriptDecl(presence: SourcePresence = .present) -> SubscriptDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .subscriptDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.subscriptKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.parameterClause),
      RawSyntax.missing(SyntaxKind.returnClause),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return SubscriptDeclSyntax(data)
  }
  public static func makeAccessLevelModifier(name: TokenSyntax, leftParen: TokenSyntax?, modifier: TokenSyntax?, rightParen: TokenSyntax?) -> AccessLevelModifierSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      leftParen?.raw,
      modifier?.raw,
      rightParen?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessLevelModifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessLevelModifierSyntax(data)
  }

  public static func makeBlankAccessLevelModifier(presence: SourcePresence = .present) -> AccessLevelModifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessLevelModifier,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AccessLevelModifierSyntax(data)
  }
  public static func makeAccessPathComponent(name: TokenSyntax, trailingDot: TokenSyntax?) -> AccessPathComponentSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      trailingDot?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessPathComponent,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessPathComponentSyntax(data)
  }

  public static func makeBlankAccessPathComponent(presence: SourcePresence = .present) -> AccessPathComponentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessPathComponent,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return AccessPathComponentSyntax(data)
  }
  public static func makeAccessPath(
    _ elements: [AccessPathComponentSyntax]) -> AccessPathSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessPath,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessPathSyntax(data)
  }

  public static func makeBlankAccessPath(presence: SourcePresence = .present) -> AccessPathSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessPath,
      layout: [
    ], length: .zero, presence: presence))
    return AccessPathSyntax(data)
  }
  public static func makeImportDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, importTok: TokenSyntax, importKind: TokenSyntax?, path: AccessPathSyntax) -> ImportDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      importTok.raw,
      importKind?.raw,
      path.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.importDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ImportDeclSyntax(data)
  }

  public static func makeBlankImportDecl(presence: SourcePresence = .present) -> ImportDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .importDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.importKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.accessPath),
    ], length: .zero, presence: presence))
    return ImportDeclSyntax(data)
  }
  public static func makeAccessorParameter(leftParen: TokenSyntax, name: TokenSyntax, rightParen: TokenSyntax) -> AccessorParameterSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      name.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorParameter,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessorParameterSyntax(data)
  }

  public static func makeBlankAccessorParameter(presence: SourcePresence = .present) -> AccessorParameterSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessorParameter,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return AccessorParameterSyntax(data)
  }
  public static func makeAccessorDecl(attributes: AttributeListSyntax?, modifier: DeclModifierSyntax?, accessorKind: TokenSyntax, parameter: AccessorParameterSyntax?, asyncKeyword: TokenSyntax?, throwsKeyword: TokenSyntax?, body: CodeBlockSyntax?) -> AccessorDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifier?.raw,
      accessorKind.raw,
      parameter?.raw,
      asyncKeyword?.raw,
      throwsKeyword?.raw,
      body?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessorDeclSyntax(data)
  }

  public static func makeBlankAccessorDecl(presence: SourcePresence = .present) -> AccessorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessorDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AccessorDeclSyntax(data)
  }
  public static func makeAccessorList(
    _ elements: [AccessorDeclSyntax]) -> AccessorListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessorListSyntax(data)
  }

  public static func makeBlankAccessorList(presence: SourcePresence = .present) -> AccessorListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessorList,
      layout: [
    ], length: .zero, presence: presence))
    return AccessorListSyntax(data)
  }
  public static func makeAccessorBlock(leftBrace: TokenSyntax, accessors: AccessorListSyntax, rightBrace: TokenSyntax) -> AccessorBlockSyntax {
    let layout: [RawSyntax?] = [
      leftBrace.raw,
      accessors.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.accessorBlock,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AccessorBlockSyntax(data)
  }

  public static func makeBlankAccessorBlock(presence: SourcePresence = .present) -> AccessorBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .accessorBlock,
      layout: [
      RawSyntax.missingToken(TokenKind.leftBrace),
      RawSyntax.missing(SyntaxKind.accessorList),
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return AccessorBlockSyntax(data)
  }
  public static func makePatternBinding(pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax?, accessor: Syntax?, trailingComma: TokenSyntax?) -> PatternBindingSyntax {
    let layout: [RawSyntax?] = [
      pattern.raw,
      typeAnnotation?.raw,
      initializer?.raw,
      accessor?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.patternBinding,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PatternBindingSyntax(data)
  }

  public static func makeBlankPatternBinding(presence: SourcePresence = .present) -> PatternBindingSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .patternBinding,
      layout: [
      RawSyntax.missing(SyntaxKind.pattern),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return PatternBindingSyntax(data)
  }
  public static func makePatternBindingList(
    _ elements: [PatternBindingSyntax]) -> PatternBindingListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.patternBindingList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PatternBindingListSyntax(data)
  }

  public static func makeBlankPatternBindingList(presence: SourcePresence = .present) -> PatternBindingListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .patternBindingList,
      layout: [
    ], length: .zero, presence: presence))
    return PatternBindingListSyntax(data)
  }
  public static func makeVariableDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, letOrVarKeyword: TokenSyntax, bindings: PatternBindingListSyntax) -> VariableDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      letOrVarKeyword.raw,
      bindings.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.variableDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return VariableDeclSyntax(data)
  }

  public static func makeBlankVariableDecl(presence: SourcePresence = .present) -> VariableDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .variableDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.letKeyword),
      RawSyntax.missing(SyntaxKind.patternBindingList),
    ], length: .zero, presence: presence))
    return VariableDeclSyntax(data)
  }
  public static func makeEnumCaseElement(identifier: TokenSyntax, associatedValue: ParameterClauseSyntax?, rawValue: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> EnumCaseElementSyntax {
    let layout: [RawSyntax?] = [
      identifier.raw,
      associatedValue?.raw,
      rawValue?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCaseElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseElementSyntax(data)
  }

  public static func makeBlankEnumCaseElement(presence: SourcePresence = .present) -> EnumCaseElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumCaseElement,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return EnumCaseElementSyntax(data)
  }
  public static func makeEnumCaseElementList(
    _ elements: [EnumCaseElementSyntax]) -> EnumCaseElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCaseElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseElementListSyntax(data)
  }

  public static func makeBlankEnumCaseElementList(presence: SourcePresence = .present) -> EnumCaseElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumCaseElementList,
      layout: [
    ], length: .zero, presence: presence))
    return EnumCaseElementListSyntax(data)
  }
  public static func makeEnumCaseDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, caseKeyword: TokenSyntax, elements: EnumCaseElementListSyntax) -> EnumCaseDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      caseKeyword.raw,
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCaseDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumCaseDeclSyntax(data)
  }

  public static func makeBlankEnumCaseDecl(presence: SourcePresence = .present) -> EnumCaseDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumCaseDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.caseKeyword),
      RawSyntax.missing(SyntaxKind.enumCaseElementList),
    ], length: .zero, presence: presence))
    return EnumCaseDeclSyntax(data)
  }
  public static func makeEnumDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, enumKeyword: TokenSyntax, identifier: TokenSyntax, genericParameters: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> EnumDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      enumKeyword.raw,
      identifier.raw,
      genericParameters?.raw,
      inheritanceClause?.raw,
      genericWhereClause?.raw,
      members.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumDeclSyntax(data)
  }

  public static func makeBlankEnumDecl(presence: SourcePresence = .present) -> EnumDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.enumKeyword),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
    ], length: .zero, presence: presence))
    return EnumDeclSyntax(data)
  }
  public static func makeOperatorDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, operatorKeyword: TokenSyntax, identifier: TokenSyntax, operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax?) -> OperatorDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      operatorKeyword.raw,
      identifier.raw,
      operatorPrecedenceAndTypes?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.operatorDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OperatorDeclSyntax(data)
  }

  public static func makeBlankOperatorDecl(presence: SourcePresence = .present) -> OperatorDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .operatorDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.operatorKeyword),
      RawSyntax.missingToken(TokenKind.unspacedBinaryOperator("")),
      nil,
    ], length: .zero, presence: presence))
    return OperatorDeclSyntax(data)
  }
  public static func makeIdentifierList(
    _ elements: [TokenSyntax]) -> IdentifierListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.identifierList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IdentifierListSyntax(data)
  }

  public static func makeBlankIdentifierList(presence: SourcePresence = .present) -> IdentifierListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .identifierList,
      layout: [
    ], length: .zero, presence: presence))
    return IdentifierListSyntax(data)
  }
  public static func makeOperatorPrecedenceAndTypes(colon: TokenSyntax, precedenceGroupAndDesignatedTypes: IdentifierListSyntax) -> OperatorPrecedenceAndTypesSyntax {
    let layout: [RawSyntax?] = [
      colon.raw,
      precedenceGroupAndDesignatedTypes.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.operatorPrecedenceAndTypes,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OperatorPrecedenceAndTypesSyntax(data)
  }

  public static func makeBlankOperatorPrecedenceAndTypes(presence: SourcePresence = .present) -> OperatorPrecedenceAndTypesSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .operatorPrecedenceAndTypes,
      layout: [
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.identifierList),
    ], length: .zero, presence: presence))
    return OperatorPrecedenceAndTypesSyntax(data)
  }
  public static func makePrecedenceGroupDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, precedencegroupKeyword: TokenSyntax, identifier: TokenSyntax, leftBrace: TokenSyntax, groupAttributes: PrecedenceGroupAttributeListSyntax, rightBrace: TokenSyntax) -> PrecedenceGroupDeclSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      modifiers?.raw,
      precedencegroupKeyword.raw,
      identifier.raw,
      leftBrace.raw,
      groupAttributes.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupDecl,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupDeclSyntax(data)
  }

  public static func makeBlankPrecedenceGroupDecl(presence: SourcePresence = .present) -> PrecedenceGroupDeclSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupDecl,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.precedencegroupKeyword),
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.leftBrace),
      RawSyntax.missing(SyntaxKind.precedenceGroupAttributeList),
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return PrecedenceGroupDeclSyntax(data)
  }
  public static func makePrecedenceGroupAttributeList(
    _ elements: [Syntax]) -> PrecedenceGroupAttributeListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupAttributeList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAttributeListSyntax(data)
  }

  public static func makeBlankPrecedenceGroupAttributeList(presence: SourcePresence = .present) -> PrecedenceGroupAttributeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupAttributeList,
      layout: [
    ], length: .zero, presence: presence))
    return PrecedenceGroupAttributeListSyntax(data)
  }
  public static func makePrecedenceGroupRelation(higherThanOrLowerThan: TokenSyntax, colon: TokenSyntax, otherNames: PrecedenceGroupNameListSyntax) -> PrecedenceGroupRelationSyntax {
    let layout: [RawSyntax?] = [
      higherThanOrLowerThan.raw,
      colon.raw,
      otherNames.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupRelation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupRelationSyntax(data)
  }

  public static func makeBlankPrecedenceGroupRelation(presence: SourcePresence = .present) -> PrecedenceGroupRelationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupRelation,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.precedenceGroupNameList),
    ], length: .zero, presence: presence))
    return PrecedenceGroupRelationSyntax(data)
  }
  public static func makePrecedenceGroupNameList(
    _ elements: [PrecedenceGroupNameElementSyntax]) -> PrecedenceGroupNameListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupNameList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupNameListSyntax(data)
  }

  public static func makeBlankPrecedenceGroupNameList(presence: SourcePresence = .present) -> PrecedenceGroupNameListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupNameList,
      layout: [
    ], length: .zero, presence: presence))
    return PrecedenceGroupNameListSyntax(data)
  }
  public static func makePrecedenceGroupNameElement(name: TokenSyntax, trailingComma: TokenSyntax?) -> PrecedenceGroupNameElementSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupNameElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupNameElementSyntax(data)
  }

  public static func makeBlankPrecedenceGroupNameElement(presence: SourcePresence = .present) -> PrecedenceGroupNameElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupNameElement,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return PrecedenceGroupNameElementSyntax(data)
  }
  public static func makePrecedenceGroupAssignment(assignmentKeyword: TokenSyntax, colon: TokenSyntax, flag: TokenSyntax) -> PrecedenceGroupAssignmentSyntax {
    let layout: [RawSyntax?] = [
      assignmentKeyword.raw,
      colon.raw,
      flag.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupAssignment,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAssignmentSyntax(data)
  }

  public static func makeBlankPrecedenceGroupAssignment(presence: SourcePresence = .present) -> PrecedenceGroupAssignmentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupAssignment,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missingToken(TokenKind.trueKeyword),
    ], length: .zero, presence: presence))
    return PrecedenceGroupAssignmentSyntax(data)
  }
  public static func makePrecedenceGroupAssociativity(associativityKeyword: TokenSyntax, colon: TokenSyntax, value: TokenSyntax) -> PrecedenceGroupAssociativitySyntax {
    let layout: [RawSyntax?] = [
      associativityKeyword.raw,
      colon.raw,
      value.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.precedenceGroupAssociativity,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrecedenceGroupAssociativitySyntax(data)
  }

  public static func makeBlankPrecedenceGroupAssociativity(presence: SourcePresence = .present) -> PrecedenceGroupAssociativitySyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .precedenceGroupAssociativity,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missingToken(TokenKind.identifier("")),
    ], length: .zero, presence: presence))
    return PrecedenceGroupAssociativitySyntax(data)
  }
  public static func makeTokenList(
    _ elements: [TokenSyntax]) -> TokenListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tokenList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TokenListSyntax(data)
  }

  public static func makeBlankTokenList(presence: SourcePresence = .present) -> TokenListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tokenList,
      layout: [
    ], length: .zero, presence: presence))
    return TokenListSyntax(data)
  }
  public static func makeNonEmptyTokenList(
    _ elements: [TokenSyntax]) -> NonEmptyTokenListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.nonEmptyTokenList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return NonEmptyTokenListSyntax(data)
  }

  public static func makeBlankNonEmptyTokenList(presence: SourcePresence = .present) -> NonEmptyTokenListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .nonEmptyTokenList,
      layout: [
    ], length: .zero, presence: presence))
    return NonEmptyTokenListSyntax(data)
  }
  public static func makeCustomAttribute(atSignToken: TokenSyntax, attributeName: TypeSyntax, leftParen: TokenSyntax?, argumentList: TupleExprElementListSyntax?, rightParen: TokenSyntax?) -> CustomAttributeSyntax {
    let layout: [RawSyntax?] = [
      atSignToken.raw,
      attributeName.raw,
      leftParen?.raw,
      argumentList?.raw,
      rightParen?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.customAttribute,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CustomAttributeSyntax(data)
  }

  public static func makeBlankCustomAttribute(presence: SourcePresence = .present) -> CustomAttributeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .customAttribute,
      layout: [
      RawSyntax.missingToken(TokenKind.atSign),
      RawSyntax.missing(SyntaxKind.type),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CustomAttributeSyntax(data)
  }
  public static func makeAttribute(atSignToken: TokenSyntax, attributeName: TokenSyntax, leftParen: TokenSyntax?, argument: Syntax?, rightParen: TokenSyntax?, tokenList: TokenListSyntax?) -> AttributeSyntax {
    let layout: [RawSyntax?] = [
      atSignToken.raw,
      attributeName.raw,
      leftParen?.raw,
      argument?.raw,
      rightParen?.raw,
      tokenList?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.attribute,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AttributeSyntax(data)
  }

  public static func makeBlankAttribute(presence: SourcePresence = .present) -> AttributeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .attribute,
      layout: [
      RawSyntax.missingToken(TokenKind.atSign),
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return AttributeSyntax(data)
  }
  public static func makeAttributeList(
    _ elements: [Syntax]) -> AttributeListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.attributeList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AttributeListSyntax(data)
  }

  public static func makeBlankAttributeList(presence: SourcePresence = .present) -> AttributeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .attributeList,
      layout: [
    ], length: .zero, presence: presence))
    return AttributeListSyntax(data)
  }
  public static func makeSpecializeAttributeSpecList(
    _ elements: [Syntax]) -> SpecializeAttributeSpecListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.specializeAttributeSpecList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SpecializeAttributeSpecListSyntax(data)
  }

  public static func makeBlankSpecializeAttributeSpecList(presence: SourcePresence = .present) -> SpecializeAttributeSpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .specializeAttributeSpecList,
      layout: [
    ], length: .zero, presence: presence))
    return SpecializeAttributeSpecListSyntax(data)
  }
  public static func makeAvailabilityEntry(label: TokenSyntax, colon: TokenSyntax, availabilityList: AvailabilitySpecListSyntax, semicolon: TokenSyntax) -> AvailabilityEntrySyntax {
    let layout: [RawSyntax?] = [
      label.raw,
      colon.raw,
      availabilityList.raw,
      semicolon.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityEntry,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityEntrySyntax(data)
  }

  public static func makeBlankAvailabilityEntry(presence: SourcePresence = .present) -> AvailabilityEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityEntry,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.availabilitySpecList),
      RawSyntax.missingToken(TokenKind.semicolon),
    ], length: .zero, presence: presence))
    return AvailabilityEntrySyntax(data)
  }
  public static func makeLabeledSpecializeEntry(label: TokenSyntax, colon: TokenSyntax, value: TokenSyntax, trailingComma: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let layout: [RawSyntax?] = [
      label.raw,
      colon.raw,
      value.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.labeledSpecializeEntry,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return LabeledSpecializeEntrySyntax(data)
  }

  public static func makeBlankLabeledSpecializeEntry(presence: SourcePresence = .present) -> LabeledSpecializeEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .labeledSpecializeEntry,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missingToken(TokenKind.unknown("")),
      nil,
    ], length: .zero, presence: presence))
    return LabeledSpecializeEntrySyntax(data)
  }
  public static func makeTargetFunctionEntry(label: TokenSyntax, colon: TokenSyntax, declname: DeclNameSyntax, trailingComma: TokenSyntax?) -> TargetFunctionEntrySyntax {
    let layout: [RawSyntax?] = [
      label.raw,
      colon.raw,
      declname.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.targetFunctionEntry,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TargetFunctionEntrySyntax(data)
  }

  public static func makeBlankTargetFunctionEntry(presence: SourcePresence = .present) -> TargetFunctionEntrySyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .targetFunctionEntry,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.declName),
      nil,
    ], length: .zero, presence: presence))
    return TargetFunctionEntrySyntax(data)
  }
  public static func makeNamedAttributeStringArgument(nameTok: TokenSyntax, colon: TokenSyntax, stringOrDeclname: Syntax) -> NamedAttributeStringArgumentSyntax {
    let layout: [RawSyntax?] = [
      nameTok.raw,
      colon.raw,
      stringOrDeclname.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.namedAttributeStringArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return NamedAttributeStringArgumentSyntax(data)
  }

  public static func makeBlankNamedAttributeStringArgument(presence: SourcePresence = .present) -> NamedAttributeStringArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .namedAttributeStringArgument,
      layout: [
      RawSyntax.missingToken(TokenKind.unknown("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return NamedAttributeStringArgumentSyntax(data)
  }
  public static func makeDeclName(declBaseName: Syntax, declNameArguments: DeclNameArgumentsSyntax?) -> DeclNameSyntax {
    let layout: [RawSyntax?] = [
      declBaseName.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declName,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclNameSyntax(data)
  }

  public static func makeBlankDeclName(presence: SourcePresence = .present) -> DeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declName,
      layout: [
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
    ], length: .zero, presence: presence))
    return DeclNameSyntax(data)
  }
  public static func makeImplementsAttributeArguments(type: SimpleTypeIdentifierSyntax, comma: TokenSyntax, declBaseName: Syntax, declNameArguments: DeclNameArgumentsSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      type.raw,
      comma.raw,
      declBaseName.raw,
      declNameArguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.implementsAttributeArguments,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ImplementsAttributeArgumentsSyntax(data)
  }

  public static func makeBlankImplementsAttributeArguments(presence: SourcePresence = .present) -> ImplementsAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .implementsAttributeArguments,
      layout: [
      RawSyntax.missing(SyntaxKind.simpleTypeIdentifier),
      RawSyntax.missingToken(TokenKind.comma),
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
    ], length: .zero, presence: presence))
    return ImplementsAttributeArgumentsSyntax(data)
  }
  public static func makeObjCSelectorPiece(name: TokenSyntax?, colon: TokenSyntax?) -> ObjCSelectorPieceSyntax {
    let layout: [RawSyntax?] = [
      name?.raw,
      colon?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objCSelectorPiece,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjCSelectorPieceSyntax(data)
  }

  public static func makeBlankObjCSelectorPiece(presence: SourcePresence = .present) -> ObjCSelectorPieceSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objCSelectorPiece,
      layout: [
      nil,
      nil,
    ], length: .zero, presence: presence))
    return ObjCSelectorPieceSyntax(data)
  }
  public static func makeObjCSelector(
    _ elements: [ObjCSelectorPieceSyntax]) -> ObjCSelectorSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.objCSelector,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ObjCSelectorSyntax(data)
  }

  public static func makeBlankObjCSelector(presence: SourcePresence = .present) -> ObjCSelectorSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .objCSelector,
      layout: [
    ], length: .zero, presence: presence))
    return ObjCSelectorSyntax(data)
  }
  public static func makeDifferentiableAttributeArguments(diffKind: TokenSyntax?, diffKindComma: TokenSyntax?, diffParams: DifferentiabilityParamsClauseSyntax?, diffParamsComma: TokenSyntax?, whereClause: GenericWhereClauseSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      diffKind?.raw,
      diffKindComma?.raw,
      diffParams?.raw,
      diffParamsComma?.raw,
      whereClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiableAttributeArguments,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiableAttributeArgumentsSyntax(data)
  }

  public static func makeBlankDifferentiableAttributeArguments(presence: SourcePresence = .present) -> DifferentiableAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiableAttributeArguments,
      layout: [
      nil,
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DifferentiableAttributeArgumentsSyntax(data)
  }
  public static func makeDifferentiabilityParamsClause(wrtLabel: TokenSyntax, colon: TokenSyntax, parameters: Syntax) -> DifferentiabilityParamsClauseSyntax {
    let layout: [RawSyntax?] = [
      wrtLabel.raw,
      colon.raw,
      parameters.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiabilityParamsClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamsClauseSyntax(data)
  }

  public static func makeBlankDifferentiabilityParamsClause(presence: SourcePresence = .present) -> DifferentiabilityParamsClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiabilityParamsClause,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return DifferentiabilityParamsClauseSyntax(data)
  }
  public static func makeDifferentiabilityParams(leftParen: TokenSyntax, diffParams: DifferentiabilityParamListSyntax, rightParen: TokenSyntax) -> DifferentiabilityParamsSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      diffParams.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiabilityParams,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamsSyntax(data)
  }

  public static func makeBlankDifferentiabilityParams(presence: SourcePresence = .present) -> DifferentiabilityParamsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiabilityParams,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.differentiabilityParamList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return DifferentiabilityParamsSyntax(data)
  }
  public static func makeDifferentiabilityParamList(
    _ elements: [DifferentiabilityParamSyntax]) -> DifferentiabilityParamListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiabilityParamList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamListSyntax(data)
  }

  public static func makeBlankDifferentiabilityParamList(presence: SourcePresence = .present) -> DifferentiabilityParamListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiabilityParamList,
      layout: [
    ], length: .zero, presence: presence))
    return DifferentiabilityParamListSyntax(data)
  }
  public static func makeDifferentiabilityParam(parameter: Syntax, trailingComma: TokenSyntax?) -> DifferentiabilityParamSyntax {
    let layout: [RawSyntax?] = [
      parameter.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.differentiabilityParam,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DifferentiabilityParamSyntax(data)
  }

  public static func makeBlankDifferentiabilityParam(presence: SourcePresence = .present) -> DifferentiabilityParamSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .differentiabilityParam,
      layout: [
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
    ], length: .zero, presence: presence))
    return DifferentiabilityParamSyntax(data)
  }
  public static func makeDerivativeRegistrationAttributeArguments(ofLabel: TokenSyntax, colon: TokenSyntax, originalDeclName: QualifiedDeclNameSyntax, period: TokenSyntax?, accessorKind: TokenSyntax?, comma: TokenSyntax?, diffParams: DifferentiabilityParamsClauseSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
      ofLabel.raw,
      colon.raw,
      originalDeclName.raw,
      period?.raw,
      accessorKind?.raw,
      comma?.raw,
      diffParams?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.derivativeRegistrationAttributeArguments,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DerivativeRegistrationAttributeArgumentsSyntax(data)
  }

  public static func makeBlankDerivativeRegistrationAttributeArguments(presence: SourcePresence = .present) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .derivativeRegistrationAttributeArguments,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.qualifiedDeclName),
      nil,
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return DerivativeRegistrationAttributeArgumentsSyntax(data)
  }
  public static func makeQualifiedDeclName(baseType: TypeSyntax?, dot: TokenSyntax?, name: TokenSyntax, arguments: DeclNameArgumentsSyntax?) -> QualifiedDeclNameSyntax {
    let layout: [RawSyntax?] = [
      baseType?.raw,
      dot?.raw,
      name.raw,
      arguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.qualifiedDeclName,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return QualifiedDeclNameSyntax(data)
  }

  public static func makeBlankQualifiedDeclName(presence: SourcePresence = .present) -> QualifiedDeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .qualifiedDeclName,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return QualifiedDeclNameSyntax(data)
  }
  public static func makeFunctionDeclName(name: Syntax, arguments: DeclNameArgumentsSyntax?) -> FunctionDeclNameSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      arguments?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionDeclName,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionDeclNameSyntax(data)
  }

  public static func makeBlankFunctionDeclName(presence: SourcePresence = .present) -> FunctionDeclNameSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionDeclName,
      layout: [
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
    ], length: .zero, presence: presence))
    return FunctionDeclNameSyntax(data)
  }
  public static func makeBackDeployAttributeSpecList(beforeLabel: TokenSyntax, colon: TokenSyntax, versionList: BackDeployVersionListSyntax) -> BackDeployAttributeSpecListSyntax {
    let layout: [RawSyntax?] = [
      beforeLabel.raw,
      colon.raw,
      versionList.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.backDeployAttributeSpecList,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BackDeployAttributeSpecListSyntax(data)
  }

  public static func makeBlankBackDeployAttributeSpecList(presence: SourcePresence = .present) -> BackDeployAttributeSpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .backDeployAttributeSpecList,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.backDeployVersionList),
    ], length: .zero, presence: presence))
    return BackDeployAttributeSpecListSyntax(data)
  }
  public static func makeBackDeployVersionList(
    _ elements: [BackDeployVersionArgumentSyntax]) -> BackDeployVersionListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.backDeployVersionList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BackDeployVersionListSyntax(data)
  }

  public static func makeBlankBackDeployVersionList(presence: SourcePresence = .present) -> BackDeployVersionListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .backDeployVersionList,
      layout: [
    ], length: .zero, presence: presence))
    return BackDeployVersionListSyntax(data)
  }
  public static func makeBackDeployVersionArgument(availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax, trailingComma: TokenSyntax?) -> BackDeployVersionArgumentSyntax {
    let layout: [RawSyntax?] = [
      availabilityVersionRestriction.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.backDeployVersionArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BackDeployVersionArgumentSyntax(data)
  }

  public static func makeBlankBackDeployVersionArgument(presence: SourcePresence = .present) -> BackDeployVersionArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .backDeployVersionArgument,
      layout: [
      RawSyntax.missing(SyntaxKind.availabilityVersionRestriction),
      nil,
    ], length: .zero, presence: presence))
    return BackDeployVersionArgumentSyntax(data)
  }
  public static func makeContinueStmt(continueKeyword: TokenSyntax, label: TokenSyntax?) -> ContinueStmtSyntax {
    let layout: [RawSyntax?] = [
      continueKeyword.raw,
      label?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.continueStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ContinueStmtSyntax(data)
  }

  public static func makeBlankContinueStmt(presence: SourcePresence = .present) -> ContinueStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .continueStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.continueKeyword),
      nil,
    ], length: .zero, presence: presence))
    return ContinueStmtSyntax(data)
  }
  public static func makeWhileStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, whileKeyword: TokenSyntax, conditions: ConditionElementListSyntax, body: CodeBlockSyntax) -> WhileStmtSyntax {
    let layout: [RawSyntax?] = [
      labelName?.raw,
      labelColon?.raw,
      whileKeyword.raw,
      conditions.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.whileStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return WhileStmtSyntax(data)
  }

  public static func makeBlankWhileStmt(presence: SourcePresence = .present) -> WhileStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .whileStmt,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.whileKeyword),
      RawSyntax.missing(SyntaxKind.conditionElementList),
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return WhileStmtSyntax(data)
  }
  public static func makeDeferStmt(deferKeyword: TokenSyntax, body: CodeBlockSyntax) -> DeferStmtSyntax {
    let layout: [RawSyntax?] = [
      deferKeyword.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.deferStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeferStmtSyntax(data)
  }

  public static func makeBlankDeferStmt(presence: SourcePresence = .present) -> DeferStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .deferStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.deferKeyword),
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return DeferStmtSyntax(data)
  }
  public static func makeExpressionStmt(expression: ExprSyntax) -> ExpressionStmtSyntax {
    let layout: [RawSyntax?] = [
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.expressionStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExpressionStmtSyntax(data)
  }

  public static func makeBlankExpressionStmt(presence: SourcePresence = .present) -> ExpressionStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .expressionStmt,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return ExpressionStmtSyntax(data)
  }
  public static func makeSwitchCaseList(
    _ elements: [Syntax]) -> SwitchCaseListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchCaseList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseListSyntax(data)
  }

  public static func makeBlankSwitchCaseList(presence: SourcePresence = .present) -> SwitchCaseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchCaseList,
      layout: [
    ], length: .zero, presence: presence))
    return SwitchCaseListSyntax(data)
  }
  public static func makeRepeatWhileStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, repeatKeyword: TokenSyntax, body: CodeBlockSyntax, whileKeyword: TokenSyntax, condition: ExprSyntax) -> RepeatWhileStmtSyntax {
    let layout: [RawSyntax?] = [
      labelName?.raw,
      labelColon?.raw,
      repeatKeyword.raw,
      body.raw,
      whileKeyword.raw,
      condition.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.repeatWhileStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return RepeatWhileStmtSyntax(data)
  }

  public static func makeBlankRepeatWhileStmt(presence: SourcePresence = .present) -> RepeatWhileStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .repeatWhileStmt,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.repeatKeyword),
      RawSyntax.missing(SyntaxKind.codeBlock),
      RawSyntax.missingToken(TokenKind.whileKeyword),
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return RepeatWhileStmtSyntax(data)
  }
  public static func makeGuardStmt(guardKeyword: TokenSyntax, conditions: ConditionElementListSyntax, elseKeyword: TokenSyntax, body: CodeBlockSyntax) -> GuardStmtSyntax {
    let layout: [RawSyntax?] = [
      guardKeyword.raw,
      conditions.raw,
      elseKeyword.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.guardStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GuardStmtSyntax(data)
  }

  public static func makeBlankGuardStmt(presence: SourcePresence = .present) -> GuardStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .guardStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.guardKeyword),
      RawSyntax.missing(SyntaxKind.conditionElementList),
      RawSyntax.missingToken(TokenKind.elseKeyword),
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return GuardStmtSyntax(data)
  }
  public static func makeWhereClause(whereKeyword: TokenSyntax, guardResult: ExprSyntax) -> WhereClauseSyntax {
    let layout: [RawSyntax?] = [
      whereKeyword.raw,
      guardResult.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.whereClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return WhereClauseSyntax(data)
  }

  public static func makeBlankWhereClause(presence: SourcePresence = .present) -> WhereClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .whereClause,
      layout: [
      RawSyntax.missingToken(TokenKind.whereKeyword),
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return WhereClauseSyntax(data)
  }
  public static func makeForInStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, forKeyword: TokenSyntax, tryKeyword: TokenSyntax?, awaitKeyword: TokenSyntax?, caseKeyword: TokenSyntax?, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, inKeyword: TokenSyntax, sequenceExpr: ExprSyntax, whereClause: WhereClauseSyntax?, body: CodeBlockSyntax) -> ForInStmtSyntax {
    let layout: [RawSyntax?] = [
      labelName?.raw,
      labelColon?.raw,
      forKeyword.raw,
      tryKeyword?.raw,
      awaitKeyword?.raw,
      caseKeyword?.raw,
      pattern.raw,
      typeAnnotation?.raw,
      inKeyword.raw,
      sequenceExpr.raw,
      whereClause?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.forInStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ForInStmtSyntax(data)
  }

  public static func makeBlankForInStmt(presence: SourcePresence = .present) -> ForInStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .forInStmt,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.forKeyword),
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.pattern),
      nil,
      RawSyntax.missingToken(TokenKind.inKeyword),
      RawSyntax.missing(SyntaxKind.expr),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return ForInStmtSyntax(data)
  }
  public static func makeSwitchStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, switchKeyword: TokenSyntax, expression: ExprSyntax, leftBrace: TokenSyntax, cases: SwitchCaseListSyntax, rightBrace: TokenSyntax) -> SwitchStmtSyntax {
    let layout: [RawSyntax?] = [
      labelName?.raw,
      labelColon?.raw,
      switchKeyword.raw,
      expression.raw,
      leftBrace.raw,
      cases.raw,
      rightBrace.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchStmtSyntax(data)
  }

  public static func makeBlankSwitchStmt(presence: SourcePresence = .present) -> SwitchStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchStmt,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.switchKeyword),
      RawSyntax.missing(SyntaxKind.expr),
      RawSyntax.missingToken(TokenKind.leftBrace),
      RawSyntax.missing(SyntaxKind.switchCaseList),
      RawSyntax.missingToken(TokenKind.rightBrace),
    ], length: .zero, presence: presence))
    return SwitchStmtSyntax(data)
  }
  public static func makeCatchClauseList(
    _ elements: [CatchClauseSyntax]) -> CatchClauseListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.catchClauseList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CatchClauseListSyntax(data)
  }

  public static func makeBlankCatchClauseList(presence: SourcePresence = .present) -> CatchClauseListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .catchClauseList,
      layout: [
    ], length: .zero, presence: presence))
    return CatchClauseListSyntax(data)
  }
  public static func makeDoStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, doKeyword: TokenSyntax, body: CodeBlockSyntax, catchClauses: CatchClauseListSyntax?) -> DoStmtSyntax {
    let layout: [RawSyntax?] = [
      labelName?.raw,
      labelColon?.raw,
      doKeyword.raw,
      body.raw,
      catchClauses?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.doStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DoStmtSyntax(data)
  }

  public static func makeBlankDoStmt(presence: SourcePresence = .present) -> DoStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .doStmt,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.doKeyword),
      RawSyntax.missing(SyntaxKind.codeBlock),
      nil,
    ], length: .zero, presence: presence))
    return DoStmtSyntax(data)
  }
  public static func makeReturnStmt(returnKeyword: TokenSyntax, expression: ExprSyntax?) -> ReturnStmtSyntax {
    let layout: [RawSyntax?] = [
      returnKeyword.raw,
      expression?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.returnStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ReturnStmtSyntax(data)
  }

  public static func makeBlankReturnStmt(presence: SourcePresence = .present) -> ReturnStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .returnStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.returnKeyword),
      nil,
    ], length: .zero, presence: presence))
    return ReturnStmtSyntax(data)
  }
  public static func makeYieldStmt(yieldKeyword: TokenSyntax, yields: Syntax) -> YieldStmtSyntax {
    let layout: [RawSyntax?] = [
      yieldKeyword.raw,
      yields.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.yieldStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return YieldStmtSyntax(data)
  }

  public static func makeBlankYieldStmt(presence: SourcePresence = .present) -> YieldStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .yieldStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.yield),
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return YieldStmtSyntax(data)
  }
  public static func makeYieldList(leftParen: TokenSyntax, elementList: ExprListSyntax, trailingComma: TokenSyntax?, rightParen: TokenSyntax) -> YieldListSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      elementList.raw,
      trailingComma?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.yieldList,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return YieldListSyntax(data)
  }

  public static func makeBlankYieldList(presence: SourcePresence = .present) -> YieldListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .yieldList,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.exprList),
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return YieldListSyntax(data)
  }
  public static func makeFallthroughStmt(fallthroughKeyword: TokenSyntax) -> FallthroughStmtSyntax {
    let layout: [RawSyntax?] = [
      fallthroughKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.fallthroughStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FallthroughStmtSyntax(data)
  }

  public static func makeBlankFallthroughStmt(presence: SourcePresence = .present) -> FallthroughStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .fallthroughStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.fallthroughKeyword),
    ], length: .zero, presence: presence))
    return FallthroughStmtSyntax(data)
  }
  public static func makeBreakStmt(breakKeyword: TokenSyntax, label: TokenSyntax?) -> BreakStmtSyntax {
    let layout: [RawSyntax?] = [
      breakKeyword.raw,
      label?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.breakStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return BreakStmtSyntax(data)
  }

  public static func makeBlankBreakStmt(presence: SourcePresence = .present) -> BreakStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .breakStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.breakKeyword),
      nil,
    ], length: .zero, presence: presence))
    return BreakStmtSyntax(data)
  }
  public static func makeCaseItemList(
    _ elements: [CaseItemSyntax]) -> CaseItemListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.caseItemList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CaseItemListSyntax(data)
  }

  public static func makeBlankCaseItemList(presence: SourcePresence = .present) -> CaseItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .caseItemList,
      layout: [
    ], length: .zero, presence: presence))
    return CaseItemListSyntax(data)
  }
  public static func makeCatchItemList(
    _ elements: [CatchItemSyntax]) -> CatchItemListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.catchItemList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CatchItemListSyntax(data)
  }

  public static func makeBlankCatchItemList(presence: SourcePresence = .present) -> CatchItemListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .catchItemList,
      layout: [
    ], length: .zero, presence: presence))
    return CatchItemListSyntax(data)
  }
  public static func makeConditionElement(condition: Syntax, trailingComma: TokenSyntax?) -> ConditionElementSyntax {
    let layout: [RawSyntax?] = [
      condition.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.conditionElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ConditionElementSyntax(data)
  }

  public static func makeBlankConditionElement(presence: SourcePresence = .present) -> ConditionElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .conditionElement,
      layout: [
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
    ], length: .zero, presence: presence))
    return ConditionElementSyntax(data)
  }
  public static func makeAvailabilityCondition(poundAvailableKeyword: TokenSyntax, leftParen: TokenSyntax, availabilitySpec: AvailabilitySpecListSyntax, rightParen: TokenSyntax) -> AvailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
      poundAvailableKeyword.raw,
      leftParen.raw,
      availabilitySpec.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityCondition,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityConditionSyntax(data)
  }

  public static func makeBlankAvailabilityCondition(presence: SourcePresence = .present) -> AvailabilityConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityCondition,
      layout: [
      RawSyntax.missingToken(TokenKind.poundAvailableKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.availabilitySpecList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return AvailabilityConditionSyntax(data)
  }
  public static func makeMatchingPatternCondition(caseKeyword: TokenSyntax, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax) -> MatchingPatternConditionSyntax {
    let layout: [RawSyntax?] = [
      caseKeyword.raw,
      pattern.raw,
      typeAnnotation?.raw,
      initializer.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.matchingPatternCondition,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MatchingPatternConditionSyntax(data)
  }

  public static func makeBlankMatchingPatternCondition(presence: SourcePresence = .present) -> MatchingPatternConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .matchingPatternCondition,
      layout: [
      RawSyntax.missingToken(TokenKind.caseKeyword),
      RawSyntax.missing(SyntaxKind.pattern),
      nil,
      RawSyntax.missing(SyntaxKind.initializerClause),
    ], length: .zero, presence: presence))
    return MatchingPatternConditionSyntax(data)
  }
  public static func makeOptionalBindingCondition(letOrVarKeyword: TokenSyntax, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax?) -> OptionalBindingConditionSyntax {
    let layout: [RawSyntax?] = [
      letOrVarKeyword.raw,
      pattern.raw,
      typeAnnotation?.raw,
      initializer?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalBindingCondition,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OptionalBindingConditionSyntax(data)
  }

  public static func makeBlankOptionalBindingCondition(presence: SourcePresence = .present) -> OptionalBindingConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .optionalBindingCondition,
      layout: [
      RawSyntax.missingToken(TokenKind.letKeyword),
      RawSyntax.missing(SyntaxKind.pattern),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return OptionalBindingConditionSyntax(data)
  }
  public static func makeUnavailabilityCondition(poundUnavailableKeyword: TokenSyntax, leftParen: TokenSyntax, availabilitySpec: AvailabilitySpecListSyntax, rightParen: TokenSyntax) -> UnavailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
      poundUnavailableKeyword.raw,
      leftParen.raw,
      availabilitySpec.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.unavailabilityCondition,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return UnavailabilityConditionSyntax(data)
  }

  public static func makeBlankUnavailabilityCondition(presence: SourcePresence = .present) -> UnavailabilityConditionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .unavailabilityCondition,
      layout: [
      RawSyntax.missingToken(TokenKind.poundUnavailableKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.availabilitySpecList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return UnavailabilityConditionSyntax(data)
  }
  public static func makeConditionElementList(
    _ elements: [ConditionElementSyntax]) -> ConditionElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.conditionElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ConditionElementListSyntax(data)
  }

  public static func makeBlankConditionElementList(presence: SourcePresence = .present) -> ConditionElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .conditionElementList,
      layout: [
    ], length: .zero, presence: presence))
    return ConditionElementListSyntax(data)
  }
  public static func makeDeclarationStmt(declaration: DeclSyntax) -> DeclarationStmtSyntax {
    let layout: [RawSyntax?] = [
      declaration.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.declarationStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DeclarationStmtSyntax(data)
  }

  public static func makeBlankDeclarationStmt(presence: SourcePresence = .present) -> DeclarationStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .declarationStmt,
      layout: [
      RawSyntax.missing(SyntaxKind.decl),
    ], length: .zero, presence: presence))
    return DeclarationStmtSyntax(data)
  }
  public static func makeThrowStmt(throwKeyword: TokenSyntax, expression: ExprSyntax) -> ThrowStmtSyntax {
    let layout: [RawSyntax?] = [
      throwKeyword.raw,
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.throwStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ThrowStmtSyntax(data)
  }

  public static func makeBlankThrowStmt(presence: SourcePresence = .present) -> ThrowStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .throwStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.throwKeyword),
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return ThrowStmtSyntax(data)
  }
  public static func makeIfStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, ifKeyword: TokenSyntax, conditions: ConditionElementListSyntax, body: CodeBlockSyntax, elseKeyword: TokenSyntax?, elseBody: Syntax?) -> IfStmtSyntax {
    let layout: [RawSyntax?] = [
      labelName?.raw,
      labelColon?.raw,
      ifKeyword.raw,
      conditions.raw,
      body.raw,
      elseKeyword?.raw,
      elseBody?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.ifStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IfStmtSyntax(data)
  }

  public static func makeBlankIfStmt(presence: SourcePresence = .present) -> IfStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .ifStmt,
      layout: [
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.ifKeyword),
      RawSyntax.missing(SyntaxKind.conditionElementList),
      RawSyntax.missing(SyntaxKind.codeBlock),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return IfStmtSyntax(data)
  }
  public static func makeElseIfContinuation(ifStatement: IfStmtSyntax) -> ElseIfContinuationSyntax {
    let layout: [RawSyntax?] = [
      ifStatement.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.elseIfContinuation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ElseIfContinuationSyntax(data)
  }

  public static func makeBlankElseIfContinuation(presence: SourcePresence = .present) -> ElseIfContinuationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .elseIfContinuation,
      layout: [
      RawSyntax.missing(SyntaxKind.ifStmt),
    ], length: .zero, presence: presence))
    return ElseIfContinuationSyntax(data)
  }
  public static func makeElseBlock(elseKeyword: TokenSyntax, body: CodeBlockSyntax) -> ElseBlockSyntax {
    let layout: [RawSyntax?] = [
      elseKeyword.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.elseBlock,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ElseBlockSyntax(data)
  }

  public static func makeBlankElseBlock(presence: SourcePresence = .present) -> ElseBlockSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .elseBlock,
      layout: [
      RawSyntax.missingToken(TokenKind.elseKeyword),
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return ElseBlockSyntax(data)
  }
  public static func makeSwitchCase(unknownAttr: AttributeSyntax?, label: Syntax, statements: CodeBlockItemListSyntax) -> SwitchCaseSyntax {
    let layout: [RawSyntax?] = [
      unknownAttr?.raw,
      label.raw,
      statements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchCase,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseSyntax(data)
  }

  public static func makeBlankSwitchCase(presence: SourcePresence = .present) -> SwitchCaseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchCase,
      layout: [
      nil,
      RawSyntax.missing(SyntaxKind.unknown),
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
    ], length: .zero, presence: presence))
    return SwitchCaseSyntax(data)
  }
  public static func makeSwitchDefaultLabel(defaultKeyword: TokenSyntax, colon: TokenSyntax) -> SwitchDefaultLabelSyntax {
    let layout: [RawSyntax?] = [
      defaultKeyword.raw,
      colon.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchDefaultLabel,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchDefaultLabelSyntax(data)
  }

  public static func makeBlankSwitchDefaultLabel(presence: SourcePresence = .present) -> SwitchDefaultLabelSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchDefaultLabel,
      layout: [
      RawSyntax.missingToken(TokenKind.defaultKeyword),
      RawSyntax.missingToken(TokenKind.colon),
    ], length: .zero, presence: presence))
    return SwitchDefaultLabelSyntax(data)
  }
  public static func makeCaseItem(pattern: PatternSyntax, whereClause: WhereClauseSyntax?, trailingComma: TokenSyntax?) -> CaseItemSyntax {
    let layout: [RawSyntax?] = [
      pattern.raw,
      whereClause?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.caseItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CaseItemSyntax(data)
  }

  public static func makeBlankCaseItem(presence: SourcePresence = .present) -> CaseItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .caseItem,
      layout: [
      RawSyntax.missing(SyntaxKind.pattern),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CaseItemSyntax(data)
  }
  public static func makeCatchItem(pattern: PatternSyntax?, whereClause: WhereClauseSyntax?, trailingComma: TokenSyntax?) -> CatchItemSyntax {
    let layout: [RawSyntax?] = [
      pattern?.raw,
      whereClause?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.catchItem,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CatchItemSyntax(data)
  }

  public static func makeBlankCatchItem(presence: SourcePresence = .present) -> CatchItemSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .catchItem,
      layout: [
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return CatchItemSyntax(data)
  }
  public static func makeSwitchCaseLabel(caseKeyword: TokenSyntax, caseItems: CaseItemListSyntax, colon: TokenSyntax) -> SwitchCaseLabelSyntax {
    let layout: [RawSyntax?] = [
      caseKeyword.raw,
      caseItems.raw,
      colon.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.switchCaseLabel,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SwitchCaseLabelSyntax(data)
  }

  public static func makeBlankSwitchCaseLabel(presence: SourcePresence = .present) -> SwitchCaseLabelSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .switchCaseLabel,
      layout: [
      RawSyntax.missingToken(TokenKind.caseKeyword),
      RawSyntax.missing(SyntaxKind.caseItemList),
      RawSyntax.missingToken(TokenKind.colon),
    ], length: .zero, presence: presence))
    return SwitchCaseLabelSyntax(data)
  }
  public static func makeCatchClause(catchKeyword: TokenSyntax, catchItems: CatchItemListSyntax?, body: CodeBlockSyntax) -> CatchClauseSyntax {
    let layout: [RawSyntax?] = [
      catchKeyword.raw,
      catchItems?.raw,
      body.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.catchClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CatchClauseSyntax(data)
  }

  public static func makeBlankCatchClause(presence: SourcePresence = .present) -> CatchClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .catchClause,
      layout: [
      RawSyntax.missingToken(TokenKind.catchKeyword),
      nil,
      RawSyntax.missing(SyntaxKind.codeBlock),
    ], length: .zero, presence: presence))
    return CatchClauseSyntax(data)
  }
  public static func makePoundAssertStmt(poundAssert: TokenSyntax, leftParen: TokenSyntax, condition: ExprSyntax, comma: TokenSyntax?, message: TokenSyntax?, rightParen: TokenSyntax) -> PoundAssertStmtSyntax {
    let layout: [RawSyntax?] = [
      poundAssert.raw,
      leftParen.raw,
      condition.raw,
      comma?.raw,
      message?.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.poundAssertStmt,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PoundAssertStmtSyntax(data)
  }

  public static func makeBlankPoundAssertStmt(presence: SourcePresence = .present) -> PoundAssertStmtSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .poundAssertStmt,
      layout: [
      RawSyntax.missingToken(TokenKind.poundAssertKeyword),
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.expr),
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return PoundAssertStmtSyntax(data)
  }
  public static func makeGenericWhereClause(whereKeyword: TokenSyntax, requirementList: GenericRequirementListSyntax) -> GenericWhereClauseSyntax {
    let layout: [RawSyntax?] = [
      whereKeyword.raw,
      requirementList.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericWhereClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericWhereClauseSyntax(data)
  }

  public static func makeBlankGenericWhereClause(presence: SourcePresence = .present) -> GenericWhereClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericWhereClause,
      layout: [
      RawSyntax.missingToken(TokenKind.whereKeyword),
      RawSyntax.missing(SyntaxKind.genericRequirementList),
    ], length: .zero, presence: presence))
    return GenericWhereClauseSyntax(data)
  }
  public static func makeGenericRequirementList(
    _ elements: [GenericRequirementSyntax]) -> GenericRequirementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericRequirementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericRequirementListSyntax(data)
  }

  public static func makeBlankGenericRequirementList(presence: SourcePresence = .present) -> GenericRequirementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericRequirementList,
      layout: [
    ], length: .zero, presence: presence))
    return GenericRequirementListSyntax(data)
  }
  public static func makeGenericRequirement(body: Syntax, trailingComma: TokenSyntax?) -> GenericRequirementSyntax {
    let layout: [RawSyntax?] = [
      body.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericRequirement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericRequirementSyntax(data)
  }

  public static func makeBlankGenericRequirement(presence: SourcePresence = .present) -> GenericRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericRequirement,
      layout: [
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
    ], length: .zero, presence: presence))
    return GenericRequirementSyntax(data)
  }
  public static func makeSameTypeRequirement(leftTypeIdentifier: TypeSyntax, equalityToken: TokenSyntax, rightTypeIdentifier: TypeSyntax) -> SameTypeRequirementSyntax {
    let layout: [RawSyntax?] = [
      leftTypeIdentifier.raw,
      equalityToken.raw,
      rightTypeIdentifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.sameTypeRequirement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SameTypeRequirementSyntax(data)
  }

  public static func makeBlankSameTypeRequirement(presence: SourcePresence = .present) -> SameTypeRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .sameTypeRequirement,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.spacedBinaryOperator("")),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return SameTypeRequirementSyntax(data)
  }
  public static func makeGenericParameterList(
    _ elements: [GenericParameterSyntax]) -> GenericParameterListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericParameterList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterListSyntax(data)
  }

  public static func makeBlankGenericParameterList(presence: SourcePresence = .present) -> GenericParameterListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericParameterList,
      layout: [
    ], length: .zero, presence: presence))
    return GenericParameterListSyntax(data)
  }
  public static func makeGenericParameter(attributes: AttributeListSyntax?, name: TokenSyntax, colon: TokenSyntax?, inheritedType: TypeSyntax?, trailingComma: TokenSyntax?) -> GenericParameterSyntax {
    let layout: [RawSyntax?] = [
      attributes?.raw,
      name.raw,
      colon?.raw,
      inheritedType?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericParameter,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterSyntax(data)
  }

  public static func makeBlankGenericParameter(presence: SourcePresence = .present) -> GenericParameterSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericParameter,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return GenericParameterSyntax(data)
  }
  public static func makePrimaryAssociatedTypeList(
    _ elements: [PrimaryAssociatedTypeSyntax]) -> PrimaryAssociatedTypeListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.primaryAssociatedTypeList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeListSyntax(data)
  }

  public static func makeBlankPrimaryAssociatedTypeList(presence: SourcePresence = .present) -> PrimaryAssociatedTypeListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .primaryAssociatedTypeList,
      layout: [
    ], length: .zero, presence: presence))
    return PrimaryAssociatedTypeListSyntax(data)
  }
  public static func makePrimaryAssociatedType(name: TokenSyntax, trailingComma: TokenSyntax?) -> PrimaryAssociatedTypeSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.primaryAssociatedType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeSyntax(data)
  }

  public static func makeBlankPrimaryAssociatedType(presence: SourcePresence = .present) -> PrimaryAssociatedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .primaryAssociatedType,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return PrimaryAssociatedTypeSyntax(data)
  }
  public static func makeGenericParameterClause(leftAngleBracket: TokenSyntax, genericParameterList: GenericParameterListSyntax, rightAngleBracket: TokenSyntax) -> GenericParameterClauseSyntax {
    let layout: [RawSyntax?] = [
      leftAngleBracket.raw,
      genericParameterList.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericParameterClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericParameterClauseSyntax(data)
  }

  public static func makeBlankGenericParameterClause(presence: SourcePresence = .present) -> GenericParameterClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericParameterClause,
      layout: [
      RawSyntax.missingToken(TokenKind.leftAngle),
      RawSyntax.missing(SyntaxKind.genericParameterList),
      RawSyntax.missingToken(TokenKind.rightAngle),
    ], length: .zero, presence: presence))
    return GenericParameterClauseSyntax(data)
  }
  public static func makeConformanceRequirement(leftTypeIdentifier: TypeSyntax, colon: TokenSyntax, rightTypeIdentifier: TypeSyntax) -> ConformanceRequirementSyntax {
    let layout: [RawSyntax?] = [
      leftTypeIdentifier.raw,
      colon.raw,
      rightTypeIdentifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.conformanceRequirement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ConformanceRequirementSyntax(data)
  }

  public static func makeBlankConformanceRequirement(presence: SourcePresence = .present) -> ConformanceRequirementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .conformanceRequirement,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return ConformanceRequirementSyntax(data)
  }
  public static func makePrimaryAssociatedTypeClause(leftAngleBracket: TokenSyntax, primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax, rightAngleBracket: TokenSyntax) -> PrimaryAssociatedTypeClauseSyntax {
    let layout: [RawSyntax?] = [
      leftAngleBracket.raw,
      primaryAssociatedTypeList.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.primaryAssociatedTypeClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return PrimaryAssociatedTypeClauseSyntax(data)
  }

  public static func makeBlankPrimaryAssociatedTypeClause(presence: SourcePresence = .present) -> PrimaryAssociatedTypeClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .primaryAssociatedTypeClause,
      layout: [
      RawSyntax.missingToken(TokenKind.leftAngle),
      RawSyntax.missing(SyntaxKind.primaryAssociatedTypeList),
      RawSyntax.missingToken(TokenKind.rightAngle),
    ], length: .zero, presence: presence))
    return PrimaryAssociatedTypeClauseSyntax(data)
  }
  public static func makeSimpleTypeIdentifier(name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
      name.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.simpleTypeIdentifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return SimpleTypeIdentifierSyntax(data)
  }

  public static func makeBlankSimpleTypeIdentifier(presence: SourcePresence = .present) -> SimpleTypeIdentifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .simpleTypeIdentifier,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return SimpleTypeIdentifierSyntax(data)
  }
  public static func makeMemberTypeIdentifier(baseType: TypeSyntax, period: TokenSyntax, name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
      baseType.raw,
      period.raw,
      name.raw,
      genericArgumentClause?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.memberTypeIdentifier,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MemberTypeIdentifierSyntax(data)
  }

  public static func makeBlankMemberTypeIdentifier(presence: SourcePresence = .present) -> MemberTypeIdentifierSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .memberTypeIdentifier,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.period),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return MemberTypeIdentifierSyntax(data)
  }
  public static func makeClassRestrictionType(classKeyword: TokenSyntax) -> ClassRestrictionTypeSyntax {
    let layout: [RawSyntax?] = [
      classKeyword.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.classRestrictionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ClassRestrictionTypeSyntax(data)
  }

  public static func makeBlankClassRestrictionType(presence: SourcePresence = .present) -> ClassRestrictionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .classRestrictionType,
      layout: [
      RawSyntax.missingToken(TokenKind.classKeyword),
    ], length: .zero, presence: presence))
    return ClassRestrictionTypeSyntax(data)
  }
  public static func makeArrayType(leftSquareBracket: TokenSyntax, elementType: TypeSyntax, rightSquareBracket: TokenSyntax) -> ArrayTypeSyntax {
    let layout: [RawSyntax?] = [
      leftSquareBracket.raw,
      elementType.raw,
      rightSquareBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.arrayType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ArrayTypeSyntax(data)
  }

  public static func makeBlankArrayType(presence: SourcePresence = .present) -> ArrayTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .arrayType,
      layout: [
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return ArrayTypeSyntax(data)
  }
  public static func makeDictionaryType(leftSquareBracket: TokenSyntax, keyType: TypeSyntax, colon: TokenSyntax, valueType: TypeSyntax, rightSquareBracket: TokenSyntax) -> DictionaryTypeSyntax {
    let layout: [RawSyntax?] = [
      leftSquareBracket.raw,
      keyType.raw,
      colon.raw,
      valueType.raw,
      rightSquareBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.dictionaryType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return DictionaryTypeSyntax(data)
  }

  public static func makeBlankDictionaryType(presence: SourcePresence = .present) -> DictionaryTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .dictionaryType,
      layout: [
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
    ], length: .zero, presence: presence))
    return DictionaryTypeSyntax(data)
  }
  public static func makeMetatypeType(baseType: TypeSyntax, period: TokenSyntax, typeOrProtocol: TokenSyntax) -> MetatypeTypeSyntax {
    let layout: [RawSyntax?] = [
      baseType.raw,
      period.raw,
      typeOrProtocol.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.metatypeType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return MetatypeTypeSyntax(data)
  }

  public static func makeBlankMetatypeType(presence: SourcePresence = .present) -> MetatypeTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .metatypeType,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.period),
      RawSyntax.missingToken(TokenKind.identifier("")),
    ], length: .zero, presence: presence))
    return MetatypeTypeSyntax(data)
  }
  public static func makeOptionalType(wrappedType: TypeSyntax, questionMark: TokenSyntax) -> OptionalTypeSyntax {
    let layout: [RawSyntax?] = [
      wrappedType.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OptionalTypeSyntax(data)
  }

  public static func makeBlankOptionalType(presence: SourcePresence = .present) -> OptionalTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .optionalType,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
    ], length: .zero, presence: presence))
    return OptionalTypeSyntax(data)
  }
  public static func makeConstrainedSugarType(someOrAnySpecifier: TokenSyntax, baseType: TypeSyntax) -> ConstrainedSugarTypeSyntax {
    let layout: [RawSyntax?] = [
      someOrAnySpecifier.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.constrainedSugarType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ConstrainedSugarTypeSyntax(data)
  }

  public static func makeBlankConstrainedSugarType(presence: SourcePresence = .present) -> ConstrainedSugarTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .constrainedSugarType,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return ConstrainedSugarTypeSyntax(data)
  }
  public static func makeImplicitlyUnwrappedOptionalType(wrappedType: TypeSyntax, exclamationMark: TokenSyntax) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let layout: [RawSyntax?] = [
      wrappedType.raw,
      exclamationMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.implicitlyUnwrappedOptionalType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ImplicitlyUnwrappedOptionalTypeSyntax(data)
  }

  public static func makeBlankImplicitlyUnwrappedOptionalType(presence: SourcePresence = .present) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .implicitlyUnwrappedOptionalType,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      RawSyntax.missingToken(TokenKind.exclamationMark),
    ], length: .zero, presence: presence))
    return ImplicitlyUnwrappedOptionalTypeSyntax(data)
  }
  public static func makeCompositionTypeElement(type: TypeSyntax, ampersand: TokenSyntax?) -> CompositionTypeElementSyntax {
    let layout: [RawSyntax?] = [
      type.raw,
      ampersand?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.compositionTypeElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeElementSyntax(data)
  }

  public static func makeBlankCompositionTypeElement(presence: SourcePresence = .present) -> CompositionTypeElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .compositionTypeElement,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      nil,
    ], length: .zero, presence: presence))
    return CompositionTypeElementSyntax(data)
  }
  public static func makeCompositionTypeElementList(
    _ elements: [CompositionTypeElementSyntax]) -> CompositionTypeElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.compositionTypeElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeElementListSyntax(data)
  }

  public static func makeBlankCompositionTypeElementList(presence: SourcePresence = .present) -> CompositionTypeElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .compositionTypeElementList,
      layout: [
    ], length: .zero, presence: presence))
    return CompositionTypeElementListSyntax(data)
  }
  public static func makeCompositionType(elements: CompositionTypeElementListSyntax) -> CompositionTypeSyntax {
    let layout: [RawSyntax?] = [
      elements.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.compositionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return CompositionTypeSyntax(data)
  }

  public static func makeBlankCompositionType(presence: SourcePresence = .present) -> CompositionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .compositionType,
      layout: [
      RawSyntax.missing(SyntaxKind.compositionTypeElementList),
    ], length: .zero, presence: presence))
    return CompositionTypeSyntax(data)
  }
  public static func makeTupleTypeElement(inOut: TokenSyntax?, name: TokenSyntax?, secondName: TokenSyntax?, colon: TokenSyntax?, type: TypeSyntax, ellipsis: TokenSyntax?, initializer: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
    let layout: [RawSyntax?] = [
      inOut?.raw,
      name?.raw,
      secondName?.raw,
      colon?.raw,
      type.raw,
      ellipsis?.raw,
      initializer?.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleTypeElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeElementSyntax(data)
  }

  public static func makeBlankTupleTypeElement(presence: SourcePresence = .present) -> TupleTypeElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleTypeElement,
      layout: [
      nil,
      nil,
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.type),
      nil,
      nil,
      nil,
    ], length: .zero, presence: presence))
    return TupleTypeElementSyntax(data)
  }
  public static func makeTupleTypeElementList(
    _ elements: [TupleTypeElementSyntax]) -> TupleTypeElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleTypeElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeElementListSyntax(data)
  }

  public static func makeBlankTupleTypeElementList(presence: SourcePresence = .present) -> TupleTypeElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleTypeElementList,
      layout: [
    ], length: .zero, presence: presence))
    return TupleTypeElementListSyntax(data)
  }
  public static func makeTupleType(leftParen: TokenSyntax, elements: TupleTypeElementListSyntax, rightParen: TokenSyntax) -> TupleTypeSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      elements.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tupleType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TupleTypeSyntax(data)
  }

  public static func makeBlankTupleType(presence: SourcePresence = .present) -> TupleTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tupleType,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.tupleTypeElementList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return TupleTypeSyntax(data)
  }
  public static func makeFunctionType(leftParen: TokenSyntax, arguments: TupleTypeElementListSyntax, rightParen: TokenSyntax, asyncKeyword: TokenSyntax?, throwsOrRethrowsKeyword: TokenSyntax?, arrow: TokenSyntax, returnType: TypeSyntax) -> FunctionTypeSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      arguments.raw,
      rightParen.raw,
      asyncKeyword?.raw,
      throwsOrRethrowsKeyword?.raw,
      arrow.raw,
      returnType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.functionType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return FunctionTypeSyntax(data)
  }

  public static func makeBlankFunctionType(presence: SourcePresence = .present) -> FunctionTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .functionType,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.tupleTypeElementList),
      RawSyntax.missingToken(TokenKind.rightParen),
      nil,
      nil,
      RawSyntax.missingToken(TokenKind.arrow),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return FunctionTypeSyntax(data)
  }
  public static func makeAttributedType(specifier: TokenSyntax?, attributes: AttributeListSyntax?, baseType: TypeSyntax) -> AttributedTypeSyntax {
    let layout: [RawSyntax?] = [
      specifier?.raw,
      attributes?.raw,
      baseType.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.attributedType,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AttributedTypeSyntax(data)
  }

  public static func makeBlankAttributedType(presence: SourcePresence = .present) -> AttributedTypeSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .attributedType,
      layout: [
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return AttributedTypeSyntax(data)
  }
  public static func makeGenericArgumentList(
    _ elements: [GenericArgumentSyntax]) -> GenericArgumentListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericArgumentList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentListSyntax(data)
  }

  public static func makeBlankGenericArgumentList(presence: SourcePresence = .present) -> GenericArgumentListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericArgumentList,
      layout: [
    ], length: .zero, presence: presence))
    return GenericArgumentListSyntax(data)
  }
  public static func makeGenericArgument(argumentType: TypeSyntax, trailingComma: TokenSyntax?) -> GenericArgumentSyntax {
    let layout: [RawSyntax?] = [
      argumentType.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentSyntax(data)
  }

  public static func makeBlankGenericArgument(presence: SourcePresence = .present) -> GenericArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericArgument,
      layout: [
      RawSyntax.missing(SyntaxKind.type),
      nil,
    ], length: .zero, presence: presence))
    return GenericArgumentSyntax(data)
  }
  public static func makeGenericArgumentClause(leftAngleBracket: TokenSyntax, arguments: GenericArgumentListSyntax, rightAngleBracket: TokenSyntax) -> GenericArgumentClauseSyntax {
    let layout: [RawSyntax?] = [
      leftAngleBracket.raw,
      arguments.raw,
      rightAngleBracket.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.genericArgumentClause,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return GenericArgumentClauseSyntax(data)
  }

  public static func makeBlankGenericArgumentClause(presence: SourcePresence = .present) -> GenericArgumentClauseSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .genericArgumentClause,
      layout: [
      RawSyntax.missingToken(TokenKind.leftAngle),
      RawSyntax.missing(SyntaxKind.genericArgumentList),
      RawSyntax.missingToken(TokenKind.rightAngle),
    ], length: .zero, presence: presence))
    return GenericArgumentClauseSyntax(data)
  }
  public static func makeTypeAnnotation(colon: TokenSyntax, type: TypeSyntax) -> TypeAnnotationSyntax {
    let layout: [RawSyntax?] = [
      colon.raw,
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.typeAnnotation,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TypeAnnotationSyntax(data)
  }

  public static func makeBlankTypeAnnotation(presence: SourcePresence = .present) -> TypeAnnotationSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .typeAnnotation,
      layout: [
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return TypeAnnotationSyntax(data)
  }
  public static func makeEnumCasePattern(type: TypeSyntax?, period: TokenSyntax, caseName: TokenSyntax, associatedTuple: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let layout: [RawSyntax?] = [
      type?.raw,
      period.raw,
      caseName.raw,
      associatedTuple?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.enumCasePattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return EnumCasePatternSyntax(data)
  }

  public static func makeBlankEnumCasePattern(presence: SourcePresence = .present) -> EnumCasePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .enumCasePattern,
      layout: [
      nil,
      RawSyntax.missingToken(TokenKind.period),
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return EnumCasePatternSyntax(data)
  }
  public static func makeIsTypePattern(isKeyword: TokenSyntax, type: TypeSyntax) -> IsTypePatternSyntax {
    let layout: [RawSyntax?] = [
      isKeyword.raw,
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.isTypePattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IsTypePatternSyntax(data)
  }

  public static func makeBlankIsTypePattern(presence: SourcePresence = .present) -> IsTypePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .isTypePattern,
      layout: [
      RawSyntax.missingToken(TokenKind.isKeyword),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return IsTypePatternSyntax(data)
  }
  public static func makeOptionalPattern(subPattern: PatternSyntax, questionMark: TokenSyntax) -> OptionalPatternSyntax {
    let layout: [RawSyntax?] = [
      subPattern.raw,
      questionMark.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.optionalPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return OptionalPatternSyntax(data)
  }

  public static func makeBlankOptionalPattern(presence: SourcePresence = .present) -> OptionalPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .optionalPattern,
      layout: [
      RawSyntax.missing(SyntaxKind.pattern),
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
    ], length: .zero, presence: presence))
    return OptionalPatternSyntax(data)
  }
  public static func makeIdentifierPattern(identifier: TokenSyntax) -> IdentifierPatternSyntax {
    let layout: [RawSyntax?] = [
      identifier.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.identifierPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return IdentifierPatternSyntax(data)
  }

  public static func makeBlankIdentifierPattern(presence: SourcePresence = .present) -> IdentifierPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .identifierPattern,
      layout: [
      RawSyntax.missingToken(TokenKind.selfKeyword),
    ], length: .zero, presence: presence))
    return IdentifierPatternSyntax(data)
  }
  public static func makeAsTypePattern(pattern: PatternSyntax, asKeyword: TokenSyntax, type: TypeSyntax) -> AsTypePatternSyntax {
    let layout: [RawSyntax?] = [
      pattern.raw,
      asKeyword.raw,
      type.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.asTypePattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AsTypePatternSyntax(data)
  }

  public static func makeBlankAsTypePattern(presence: SourcePresence = .present) -> AsTypePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .asTypePattern,
      layout: [
      RawSyntax.missing(SyntaxKind.pattern),
      RawSyntax.missingToken(TokenKind.asKeyword),
      RawSyntax.missing(SyntaxKind.type),
    ], length: .zero, presence: presence))
    return AsTypePatternSyntax(data)
  }
  public static func makeTuplePattern(leftParen: TokenSyntax, elements: TuplePatternElementListSyntax, rightParen: TokenSyntax) -> TuplePatternSyntax {
    let layout: [RawSyntax?] = [
      leftParen.raw,
      elements.raw,
      rightParen.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tuplePattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternSyntax(data)
  }

  public static func makeBlankTuplePattern(presence: SourcePresence = .present) -> TuplePatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tuplePattern,
      layout: [
      RawSyntax.missingToken(TokenKind.leftParen),
      RawSyntax.missing(SyntaxKind.tuplePatternElementList),
      RawSyntax.missingToken(TokenKind.rightParen),
    ], length: .zero, presence: presence))
    return TuplePatternSyntax(data)
  }
  public static func makeWildcardPattern(wildcard: TokenSyntax, typeAnnotation: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let layout: [RawSyntax?] = [
      wildcard.raw,
      typeAnnotation?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.wildcardPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return WildcardPatternSyntax(data)
  }

  public static func makeBlankWildcardPattern(presence: SourcePresence = .present) -> WildcardPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .wildcardPattern,
      layout: [
      RawSyntax.missingToken(TokenKind.wildcardKeyword),
      nil,
    ], length: .zero, presence: presence))
    return WildcardPatternSyntax(data)
  }
  public static func makeTuplePatternElement(labelName: TokenSyntax?, labelColon: TokenSyntax?, pattern: PatternSyntax, trailingComma: TokenSyntax?) -> TuplePatternElementSyntax {
    let layout: [RawSyntax?] = [
      labelName?.raw,
      labelColon?.raw,
      pattern.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tuplePatternElement,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternElementSyntax(data)
  }

  public static func makeBlankTuplePatternElement(presence: SourcePresence = .present) -> TuplePatternElementSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tuplePatternElement,
      layout: [
      nil,
      nil,
      RawSyntax.missing(SyntaxKind.pattern),
      nil,
    ], length: .zero, presence: presence))
    return TuplePatternElementSyntax(data)
  }
  public static func makeExpressionPattern(expression: ExprSyntax) -> ExpressionPatternSyntax {
    let layout: [RawSyntax?] = [
      expression.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.expressionPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ExpressionPatternSyntax(data)
  }

  public static func makeBlankExpressionPattern(presence: SourcePresence = .present) -> ExpressionPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .expressionPattern,
      layout: [
      RawSyntax.missing(SyntaxKind.expr),
    ], length: .zero, presence: presence))
    return ExpressionPatternSyntax(data)
  }
  public static func makeTuplePatternElementList(
    _ elements: [TuplePatternElementSyntax]) -> TuplePatternElementListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.tuplePatternElementList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return TuplePatternElementListSyntax(data)
  }

  public static func makeBlankTuplePatternElementList(presence: SourcePresence = .present) -> TuplePatternElementListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .tuplePatternElementList,
      layout: [
    ], length: .zero, presence: presence))
    return TuplePatternElementListSyntax(data)
  }
  public static func makeValueBindingPattern(letOrVarKeyword: TokenSyntax, valuePattern: PatternSyntax) -> ValueBindingPatternSyntax {
    let layout: [RawSyntax?] = [
      letOrVarKeyword.raw,
      valuePattern.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.valueBindingPattern,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return ValueBindingPatternSyntax(data)
  }

  public static func makeBlankValueBindingPattern(presence: SourcePresence = .present) -> ValueBindingPatternSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .valueBindingPattern,
      layout: [
      RawSyntax.missingToken(TokenKind.letKeyword),
      RawSyntax.missing(SyntaxKind.pattern),
    ], length: .zero, presence: presence))
    return ValueBindingPatternSyntax(data)
  }
  public static func makeAvailabilitySpecList(
    _ elements: [AvailabilityArgumentSyntax]) -> AvailabilitySpecListSyntax {
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilitySpecList,
      layout: elements.map { $0.raw }, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilitySpecListSyntax(data)
  }

  public static func makeBlankAvailabilitySpecList(presence: SourcePresence = .present) -> AvailabilitySpecListSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilitySpecList,
      layout: [
    ], length: .zero, presence: presence))
    return AvailabilitySpecListSyntax(data)
  }
  public static func makeAvailabilityArgument(entry: Syntax, trailingComma: TokenSyntax?) -> AvailabilityArgumentSyntax {
    let layout: [RawSyntax?] = [
      entry.raw,
      trailingComma?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityArgumentSyntax(data)
  }

  public static func makeBlankAvailabilityArgument(presence: SourcePresence = .present) -> AvailabilityArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityArgument,
      layout: [
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
    ], length: .zero, presence: presence))
    return AvailabilityArgumentSyntax(data)
  }
  public static func makeAvailabilityLabeledArgument(label: TokenSyntax, colon: TokenSyntax, value: Syntax) -> AvailabilityLabeledArgumentSyntax {
    let layout: [RawSyntax?] = [
      label.raw,
      colon.raw,
      value.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityLabeledArgument,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityLabeledArgumentSyntax(data)
  }

  public static func makeBlankAvailabilityLabeledArgument(presence: SourcePresence = .present) -> AvailabilityLabeledArgumentSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityLabeledArgument,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      RawSyntax.missingToken(TokenKind.colon),
      RawSyntax.missing(SyntaxKind.unknown),
    ], length: .zero, presence: presence))
    return AvailabilityLabeledArgumentSyntax(data)
  }
  public static func makeAvailabilityVersionRestriction(platform: TokenSyntax, version: VersionTupleSyntax?) -> AvailabilityVersionRestrictionSyntax {
    let layout: [RawSyntax?] = [
      platform.raw,
      version?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.availabilityVersionRestriction,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return AvailabilityVersionRestrictionSyntax(data)
  }

  public static func makeBlankAvailabilityVersionRestriction(presence: SourcePresence = .present) -> AvailabilityVersionRestrictionSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .availabilityVersionRestriction,
      layout: [
      RawSyntax.missingToken(TokenKind.identifier("")),
      nil,
    ], length: .zero, presence: presence))
    return AvailabilityVersionRestrictionSyntax(data)
  }
  public static func makeVersionTuple(majorMinor: Syntax, patchPeriod: TokenSyntax?, patchVersion: TokenSyntax?) -> VersionTupleSyntax {
    let layout: [RawSyntax?] = [
      majorMinor.raw,
      patchPeriod?.raw,
      patchVersion?.raw,
    ]
    let raw = RawSyntax.createAndCalcLength(kind: SyntaxKind.versionTuple,
      layout: layout, presence: SourcePresence.present)
    let data = SyntaxData.forRoot(raw)
    return VersionTupleSyntax(data)
  }

  public static func makeBlankVersionTuple(presence: SourcePresence = .present) -> VersionTupleSyntax {
    let data = SyntaxData.forRoot(RawSyntax.create(kind: .versionTuple,
      layout: [
      RawSyntax.missing(SyntaxKind.unknown),
      nil,
      nil,
    ], length: .zero, presence: presence))
    return VersionTupleSyntax(data)
  }

/// MARK: Token Creation APIs


  public static func makeAssociatedtypeKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.associatedtypeKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeClassKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.classKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDeinitKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.deinitKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeEnumKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.enumKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeExtensionKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.extensionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFuncKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.funcKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeImportKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.importKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInitKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.initKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInoutKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.inoutKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLetKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.letKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeOperatorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.operatorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrecedencegroupKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.precedencegroupKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeProtocolKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.protocolKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStructKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.structKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSubscriptKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.subscriptKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeTypealiasKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.typealiasKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeVarKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.varKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFileprivateKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.fileprivateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInternalKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.internalKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrivateKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.privateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePublicKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.publicKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStaticKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.staticKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDeferKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.deferKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeIfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.ifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeGuardKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.guardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDoKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.doKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRepeatKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.repeatKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeElseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.elseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeForKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.forKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.inKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeWhileKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.whileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeReturnKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.returnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeBreakKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.breakKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeContinueKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.continueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFallthroughKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.fallthroughKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSwitchKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.switchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeCaseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.caseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDefaultKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.defaultKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeWhereKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.whereKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeCatchKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.catchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeThrowKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.throwKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeAsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.asKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeAnyKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.anyKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFalseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.falseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeIsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.isKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeNilKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.nilKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRethrowsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.rethrowsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSuperKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.superKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSelfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.selfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeCapitalSelfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.capitalSelfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeTrueKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.trueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeTryKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.tryKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeThrowsKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.throwsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__FILE__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__file__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__LINE__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__line__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__COLUMN__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__column__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__FUNCTION__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__function__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__DSO_HANDLE__Keyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.__dso_handle__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeWildcardKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.wildcardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLeftParenToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.leftParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRightParenToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.rightParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLeftBraceToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.leftBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRightBraceToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.rightBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLeftSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.leftSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRightSquareBracketToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.rightSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLeftAngleToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.leftAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRightAngleToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.rightAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePeriodToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.period, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrefixPeriodToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.prefixPeriod, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeCommaToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.comma, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeEllipsisToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.ellipsis, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeColonToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.colon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSemicolonToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.semicolon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeEqualToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.equal, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeAtSignToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.atSign, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.pound, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrefixAmpersandToken(
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.prefixAmpersand, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeArrowToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.arrow, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeBacktickToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.backtick, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeBackslashToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.backslash, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeExclamationMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.exclamationMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePostfixQuestionMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.postfixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInfixQuestionMarkToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.infixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStringQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.stringQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSingleQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.singleQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeMultilineStringQuoteToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.multilineStringQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundKeyPathKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundKeyPathKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundLineKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundLineKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundSelectorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundSelectorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundFileKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundFileIDKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFileIDKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundFilePathKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFilePathKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundColumnKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundColumnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundFunctionKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFunctionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundDsohandleKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundDsohandleKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundAssertKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundAssertKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundSourceLocationKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundSourceLocationKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundWarningKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundWarningKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundErrorKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundErrorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundIfKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundIfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundElseKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundElseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundElseifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundElseifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundEndifKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundEndifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundAvailableKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundAvailableKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundUnavailableKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundUnavailableKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundFileLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundFileLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundImageLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundImageLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundColorLiteralKeyword(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.poundColorLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeIntegerLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.integerLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFloatingLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.floatingLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStringLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.stringLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRegexLiteral(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.regexLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeUnknown(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.unknown(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeIdentifier(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.identifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeUnspacedBinaryOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.unspacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSpacedBinaryOperator(
    _ text: String,
    leadingTrivia: Trivia = .space,
    trailingTrivia: Trivia = .space
  ) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePostfixOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.postfixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrefixOperator(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.prefixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDollarIdentifier(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.dollarIdentifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeContextualKeyword(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.contextualKeyword(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRawStringDelimiter(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.rawStringDelimiter(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStringSegment(
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.stringSegment(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStringInterpolationAnchorToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.stringInterpolationAnchor, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeYieldToken(
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(.yield, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }

/// MARK: Convenience APIs

  public static func makeVoidTupleType() -> TupleTypeSyntax {
    return makeTupleType(leftParen: makeLeftParenToken(),
                         elements: makeBlankTupleTypeElementList(),
                         rightParen: makeRightParenToken())
  }

  public static func makeTupleTypeElement(name: TokenSyntax?,
    colon: TokenSyntax?, type: TypeSyntax,
    trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
    return makeTupleTypeElement(inOut: nil, name: name, secondName: nil,
                                colon: colon, type: type, ellipsis: nil,
                                initializer: nil, trailingComma: trailingComma)
  }

  public static func makeTupleTypeElement(type: TypeSyntax,
    trailingComma: TokenSyntax?) -> TupleTypeElementSyntax  {
    return makeTupleTypeElement(name: nil, colon: nil, 
                                type: type, trailingComma: trailingComma)
  }

  public static func makeGenericParameter(name: TokenSyntax,
      trailingComma: TokenSyntax) -> GenericParameterSyntax {
    return makeGenericParameter(attributes: nil, name: name, colon: nil,
                                inheritedType: nil,
                                trailingComma: trailingComma)
  }

  public static func makeTypeIdentifier(_ name: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    let identifier = makeIdentifier(name, leadingTrivia: leadingTrivia, 
                                    trailingTrivia: trailingTrivia)
    let typeIdentifier = makeSimpleTypeIdentifier(name: identifier,
                                                  genericArgumentClause: nil)
    return TypeSyntax(typeIdentifier)
  }

  public static func makeAnyTypeIdentifier(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    return makeTypeIdentifier("Any", leadingTrivia: leadingTrivia, 
                              trailingTrivia: trailingTrivia)
  }

  public static func makeSelfTypeIdentifier(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    return makeTypeIdentifier("Self", leadingTrivia: leadingTrivia, 
                              trailingTrivia: trailingTrivia)
  }

  public static func makeTypeToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeIdentifier("Type", leadingTrivia: leadingTrivia, 
                          trailingTrivia: trailingTrivia)
  }

  public static func makeProtocolToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeIdentifier("Protocol", leadingTrivia: leadingTrivia,
                          trailingTrivia: trailingTrivia)
  }

  public static func makeBinaryOperator(_ name: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator(name),
                     presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }

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

  public static func makeVariableExpr(_ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> IdentifierExprSyntax {
    let string = makeIdentifier(text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
    return makeIdentifierExpr(identifier: string,
                              declNameArguments: nil)
  }
}
