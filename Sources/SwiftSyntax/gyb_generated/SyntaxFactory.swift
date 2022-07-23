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
  @available(*, deprecated, message: "use pure token kind with 'tokenText' argument")
  public static func makeToken(_ kind: LegacyTokenKind, presence: SourcePresence,
                               leadingTrivia: Trivia = [],
                               trailingTrivia: Trivia = []) -> TokenSyntax {
    let (kind, text) = kind.plain
    if presence == .missing {
      let raw = RawTokenSyntax.makeBlank(arena: .default, tokenKind: kind).raw
      return TokenSyntax(data: SyntaxData(rootRaw: raw, arena: .default))
    }

    return makeToken(arena: .default, kind,
                     tokenText: text,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }


  public static func makeToken(
    arena: SyntaxArena = .default,
    _ tokenKind: TokenKind,
    tokenText: String = "",
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    let raw = RawSyntax.makeMaterializedToken(
      arena: arena, kind: tokenKind,
      text: tokenText,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
    return TokenSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeUnknownSyntax(
    arena: SyntaxArena = .default,
    tokens: [TokenSyntax]
  ) -> UnknownSyntax {
    let raw = RawSyntax.makeLayout(
      arena: arena, kind: .unknown, uninitializedCount: tokens.count) { buffer in
      _ = buffer.initialize(from: tokens.map { $0.raw })
    }
    return UnknownSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }
}

/// MARK: Syntax Node Creation APIs

extension SyntaxFactory {













  public static func makeBlankUnknownDecl(arena: SyntaxArena = .default) -> UnknownDeclSyntax {
    let raw = RawUnknownDeclSyntax.makeBlank(arena: arena).raw
    return UnknownDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }


  public static func makeBlankUnknownExpr(arena: SyntaxArena = .default) -> UnknownExprSyntax {
    let raw = RawUnknownExprSyntax.makeBlank(arena: arena).raw
    return UnknownExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }


  public static func makeBlankUnknownStmt(arena: SyntaxArena = .default) -> UnknownStmtSyntax {
    let raw = RawUnknownStmtSyntax.makeBlank(arena: arena).raw
    return UnknownStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }


  public static func makeBlankUnknownType(arena: SyntaxArena = .default) -> UnknownTypeSyntax {
    let raw = RawUnknownTypeSyntax.makeBlank(arena: arena).raw
    return UnknownTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }


  public static func makeBlankUnknownPattern(arena: SyntaxArena = .default) -> UnknownPatternSyntax {
    let raw = RawUnknownPatternSyntax.makeBlank(arena: arena).raw
    return UnknownPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCodeBlockItem(
    arena: SyntaxArena = .default, item: Syntax, semicolon: TokenSyntax?, errorTokens: Syntax?
  ) -> CodeBlockItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .codeBlockItem,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = item.raw
      buffer[1] = semicolon?.raw
      buffer[2] = errorTokens?.raw
    }
    return CodeBlockItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCodeBlockItem(arena: SyntaxArena = .default) -> CodeBlockItemSyntax {
    let raw = RawCodeBlockItemSyntax.makeBlank(arena: arena).raw
    return CodeBlockItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCodeBlockItemList(
    arena: SyntaxArena = .default, _ elements: [CodeBlockItemSyntax]
  ) -> CodeBlockItemListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .codeBlockItemList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return CodeBlockItemListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCodeBlockItemList(arena: SyntaxArena = .default) -> CodeBlockItemListSyntax {
    let raw = RawCodeBlockItemListSyntax.makeBlank(arena: arena).raw
    return CodeBlockItemListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCodeBlock(
    arena: SyntaxArena = .default, leftBrace: TokenSyntax, statements: CodeBlockItemListSyntax, rightBrace: TokenSyntax
  ) -> CodeBlockSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .codeBlock,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftBrace.raw
      buffer[1] = statements.raw
      buffer[2] = rightBrace.raw
    }
    return CodeBlockSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCodeBlock(arena: SyntaxArena = .default) -> CodeBlockSyntax {
    let raw = RawCodeBlockSyntax.makeBlank(arena: arena).raw
    return CodeBlockSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeInOutExpr(
    arena: SyntaxArena = .default, ampersand: TokenSyntax, expression: ExprSyntax
  ) -> InOutExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .inOutExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = ampersand.raw
      buffer[1] = expression.raw
    }
    return InOutExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankInOutExpr(arena: SyntaxArena = .default) -> InOutExprSyntax {
    let raw = RawInOutExprSyntax.makeBlank(arena: arena).raw
    return InOutExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundColumnExpr(
    arena: SyntaxArena = .default, poundColumn: TokenSyntax
  ) -> PoundColumnExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundColumnExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundColumn.raw
    }
    return PoundColumnExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundColumnExpr(arena: SyntaxArena = .default) -> PoundColumnExprSyntax {
    let raw = RawPoundColumnExprSyntax.makeBlank(arena: arena).raw
    return PoundColumnExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTupleExprElementList(
    arena: SyntaxArena = .default, _ elements: [TupleExprElementSyntax]
  ) -> TupleExprElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return TupleExprElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTupleExprElementList(arena: SyntaxArena = .default) -> TupleExprElementListSyntax {
    let raw = RawTupleExprElementListSyntax.makeBlank(arena: arena).raw
    return TupleExprElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeArrayElementList(
    arena: SyntaxArena = .default, _ elements: [ArrayElementSyntax]
  ) -> ArrayElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return ArrayElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankArrayElementList(arena: SyntaxArena = .default) -> ArrayElementListSyntax {
    let raw = RawArrayElementListSyntax.makeBlank(arena: arena).raw
    return ArrayElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDictionaryElementList(
    arena: SyntaxArena = .default, _ elements: [DictionaryElementSyntax]
  ) -> DictionaryElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return DictionaryElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDictionaryElementList(arena: SyntaxArena = .default) -> DictionaryElementListSyntax {
    let raw = RawDictionaryElementListSyntax.makeBlank(arena: arena).raw
    return DictionaryElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeStringLiteralSegments(
    arena: SyntaxArena = .default, _ elements: [Syntax]
  ) -> StringLiteralSegmentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .stringLiteralSegments, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return StringLiteralSegmentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankStringLiteralSegments(arena: SyntaxArena = .default) -> StringLiteralSegmentsSyntax {
    let raw = RawStringLiteralSegmentsSyntax.makeBlank(arena: arena).raw
    return StringLiteralSegmentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTryExpr(
    arena: SyntaxArena = .default, tryKeyword: TokenSyntax, questionOrExclamationMark: TokenSyntax?, expression: ExprSyntax
  ) -> TryExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tryExpr,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = tryKeyword.raw
      buffer[1] = questionOrExclamationMark?.raw
      buffer[2] = expression.raw
    }
    return TryExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTryExpr(arena: SyntaxArena = .default) -> TryExprSyntax {
    let raw = RawTryExprSyntax.makeBlank(arena: arena).raw
    return TryExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAwaitExpr(
    arena: SyntaxArena = .default, awaitKeyword: TokenSyntax, expression: ExprSyntax
  ) -> AwaitExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .awaitExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = awaitKeyword.raw
      buffer[1] = expression.raw
    }
    return AwaitExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAwaitExpr(arena: SyntaxArena = .default) -> AwaitExprSyntax {
    let raw = RawAwaitExprSyntax.makeBlank(arena: arena).raw
    return AwaitExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeclNameArgument(
    arena: SyntaxArena = .default, name: TokenSyntax, colon: TokenSyntax
  ) -> DeclNameArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declNameArgument,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = colon.raw
    }
    return DeclNameArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeclNameArgument(arena: SyntaxArena = .default) -> DeclNameArgumentSyntax {
    let raw = RawDeclNameArgumentSyntax.makeBlank(arena: arena).raw
    return DeclNameArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeclNameArgumentList(
    arena: SyntaxArena = .default, _ elements: [DeclNameArgumentSyntax]
  ) -> DeclNameArgumentListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declNameArgumentList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return DeclNameArgumentListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeclNameArgumentList(arena: SyntaxArena = .default) -> DeclNameArgumentListSyntax {
    let raw = RawDeclNameArgumentListSyntax.makeBlank(arena: arena).raw
    return DeclNameArgumentListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeclNameArguments(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, arguments: DeclNameArgumentListSyntax, rightParen: TokenSyntax
  ) -> DeclNameArgumentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declNameArguments,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = arguments.raw
      buffer[2] = rightParen.raw
    }
    return DeclNameArgumentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeclNameArguments(arena: SyntaxArena = .default) -> DeclNameArgumentsSyntax {
    let raw = RawDeclNameArgumentsSyntax.makeBlank(arena: arena).raw
    return DeclNameArgumentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIdentifierExpr(
    arena: SyntaxArena = .default, identifier: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?
  ) -> IdentifierExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .identifierExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = identifier.raw
      buffer[1] = declNameArguments?.raw
    }
    return IdentifierExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIdentifierExpr(arena: SyntaxArena = .default) -> IdentifierExprSyntax {
    let raw = RawIdentifierExprSyntax.makeBlank(arena: arena).raw
    return IdentifierExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSuperRefExpr(
    arena: SyntaxArena = .default, superKeyword: TokenSyntax
  ) -> SuperRefExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .superRefExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = superKeyword.raw
    }
    return SuperRefExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSuperRefExpr(arena: SyntaxArena = .default) -> SuperRefExprSyntax {
    let raw = RawSuperRefExprSyntax.makeBlank(arena: arena).raw
    return SuperRefExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeNilLiteralExpr(
    arena: SyntaxArena = .default, nilKeyword: TokenSyntax
  ) -> NilLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .nilLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = nilKeyword.raw
    }
    return NilLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankNilLiteralExpr(arena: SyntaxArena = .default) -> NilLiteralExprSyntax {
    let raw = RawNilLiteralExprSyntax.makeBlank(arena: arena).raw
    return NilLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDiscardAssignmentExpr(
    arena: SyntaxArena = .default, wildcard: TokenSyntax
  ) -> DiscardAssignmentExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .discardAssignmentExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = wildcard.raw
    }
    return DiscardAssignmentExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDiscardAssignmentExpr(arena: SyntaxArena = .default) -> DiscardAssignmentExprSyntax {
    let raw = RawDiscardAssignmentExprSyntax.makeBlank(arena: arena).raw
    return DiscardAssignmentExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAssignmentExpr(
    arena: SyntaxArena = .default, assignToken: TokenSyntax
  ) -> AssignmentExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .assignmentExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = assignToken.raw
    }
    return AssignmentExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAssignmentExpr(arena: SyntaxArena = .default) -> AssignmentExprSyntax {
    let raw = RawAssignmentExprSyntax.makeBlank(arena: arena).raw
    return AssignmentExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSequenceExpr(
    arena: SyntaxArena = .default, elements: ExprListSyntax
  ) -> SequenceExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .sequenceExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = elements.raw
    }
    return SequenceExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSequenceExpr(arena: SyntaxArena = .default) -> SequenceExprSyntax {
    let raw = RawSequenceExprSyntax.makeBlank(arena: arena).raw
    return SequenceExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeExprList(
    arena: SyntaxArena = .default, _ elements: [ExprSyntax]
  ) -> ExprListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .exprList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return ExprListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankExprList(arena: SyntaxArena = .default) -> ExprListSyntax {
    let raw = RawExprListSyntax.makeBlank(arena: arena).raw
    return ExprListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundLineExpr(
    arena: SyntaxArena = .default, poundLine: TokenSyntax
  ) -> PoundLineExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundLineExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundLine.raw
    }
    return PoundLineExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundLineExpr(arena: SyntaxArena = .default) -> PoundLineExprSyntax {
    let raw = RawPoundLineExprSyntax.makeBlank(arena: arena).raw
    return PoundLineExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundFileExpr(
    arena: SyntaxArena = .default, poundFile: TokenSyntax
  ) -> PoundFileExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFileExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundFile.raw
    }
    return PoundFileExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundFileExpr(arena: SyntaxArena = .default) -> PoundFileExprSyntax {
    let raw = RawPoundFileExprSyntax.makeBlank(arena: arena).raw
    return PoundFileExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundFileIDExpr(
    arena: SyntaxArena = .default, poundFileID: TokenSyntax
  ) -> PoundFileIDExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFileIDExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundFileID.raw
    }
    return PoundFileIDExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundFileIDExpr(arena: SyntaxArena = .default) -> PoundFileIDExprSyntax {
    let raw = RawPoundFileIDExprSyntax.makeBlank(arena: arena).raw
    return PoundFileIDExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundFilePathExpr(
    arena: SyntaxArena = .default, poundFilePath: TokenSyntax
  ) -> PoundFilePathExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFilePathExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundFilePath.raw
    }
    return PoundFilePathExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundFilePathExpr(arena: SyntaxArena = .default) -> PoundFilePathExprSyntax {
    let raw = RawPoundFilePathExprSyntax.makeBlank(arena: arena).raw
    return PoundFilePathExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundFunctionExpr(
    arena: SyntaxArena = .default, poundFunction: TokenSyntax
  ) -> PoundFunctionExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundFunctionExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundFunction.raw
    }
    return PoundFunctionExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundFunctionExpr(arena: SyntaxArena = .default) -> PoundFunctionExprSyntax {
    let raw = RawPoundFunctionExprSyntax.makeBlank(arena: arena).raw
    return PoundFunctionExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundDsohandleExpr(
    arena: SyntaxArena = .default, poundDsohandle: TokenSyntax
  ) -> PoundDsohandleExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundDsohandleExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundDsohandle.raw
    }
    return PoundDsohandleExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundDsohandleExpr(arena: SyntaxArena = .default) -> PoundDsohandleExprSyntax {
    let raw = RawPoundDsohandleExprSyntax.makeBlank(arena: arena).raw
    return PoundDsohandleExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSymbolicReferenceExpr(
    arena: SyntaxArena = .default, identifier: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?
  ) -> SymbolicReferenceExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .symbolicReferenceExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = identifier.raw
      buffer[1] = genericArgumentClause?.raw
    }
    return SymbolicReferenceExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSymbolicReferenceExpr(arena: SyntaxArena = .default) -> SymbolicReferenceExprSyntax {
    let raw = RawSymbolicReferenceExprSyntax.makeBlank(arena: arena).raw
    return SymbolicReferenceExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrefixOperatorExpr(
    arena: SyntaxArena = .default, operatorToken: TokenSyntax?, postfixExpression: ExprSyntax
  ) -> PrefixOperatorExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .prefixOperatorExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = operatorToken?.raw
      buffer[1] = postfixExpression.raw
    }
    return PrefixOperatorExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrefixOperatorExpr(arena: SyntaxArena = .default) -> PrefixOperatorExprSyntax {
    let raw = RawPrefixOperatorExprSyntax.makeBlank(arena: arena).raw
    return PrefixOperatorExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBinaryOperatorExpr(
    arena: SyntaxArena = .default, operatorToken: TokenSyntax
  ) -> BinaryOperatorExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .binaryOperatorExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = operatorToken.raw
    }
    return BinaryOperatorExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankBinaryOperatorExpr(arena: SyntaxArena = .default) -> BinaryOperatorExprSyntax {
    let raw = RawBinaryOperatorExprSyntax.makeBlank(arena: arena).raw
    return BinaryOperatorExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeArrowExpr(
    arena: SyntaxArena = .default, asyncKeyword: TokenSyntax?, throwsToken: TokenSyntax?, arrowToken: TokenSyntax
  ) -> ArrowExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrowExpr,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = asyncKeyword?.raw
      buffer[1] = throwsToken?.raw
      buffer[2] = arrowToken.raw
    }
    return ArrowExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankArrowExpr(arena: SyntaxArena = .default) -> ArrowExprSyntax {
    let raw = RawArrowExprSyntax.makeBlank(arena: arena).raw
    return ArrowExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFloatLiteralExpr(
    arena: SyntaxArena = .default, floatingDigits: TokenSyntax
  ) -> FloatLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .floatLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = floatingDigits.raw
    }
    return FloatLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFloatLiteralExpr(arena: SyntaxArena = .default) -> FloatLiteralExprSyntax {
    let raw = RawFloatLiteralExprSyntax.makeBlank(arena: arena).raw
    return FloatLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTupleExpr(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, elementList: TupleExprElementListSyntax, rightParen: TokenSyntax
  ) -> TupleExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleExpr,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = elementList.raw
      buffer[2] = rightParen.raw
    }
    return TupleExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTupleExpr(arena: SyntaxArena = .default) -> TupleExprSyntax {
    let raw = RawTupleExprSyntax.makeBlank(arena: arena).raw
    return TupleExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeArrayExpr(
    arena: SyntaxArena = .default, leftSquare: TokenSyntax, elements: ArrayElementListSyntax, rightSquare: TokenSyntax
  ) -> ArrayExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayExpr,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftSquare.raw
      buffer[1] = elements.raw
      buffer[2] = rightSquare.raw
    }
    return ArrayExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankArrayExpr(arena: SyntaxArena = .default) -> ArrayExprSyntax {
    let raw = RawArrayExprSyntax.makeBlank(arena: arena).raw
    return ArrayExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDictionaryExpr(
    arena: SyntaxArena = .default, leftSquare: TokenSyntax, content: Syntax, rightSquare: TokenSyntax
  ) -> DictionaryExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryExpr,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftSquare.raw
      buffer[1] = content.raw
      buffer[2] = rightSquare.raw
    }
    return DictionaryExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDictionaryExpr(arena: SyntaxArena = .default) -> DictionaryExprSyntax {
    let raw = RawDictionaryExprSyntax.makeBlank(arena: arena).raw
    return DictionaryExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTupleExprElement(
    arena: SyntaxArena = .default, label: TokenSyntax?, colon: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?
  ) -> TupleExprElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleExprElement,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = label?.raw
      buffer[1] = colon?.raw
      buffer[2] = expression.raw
      buffer[3] = trailingComma?.raw
    }
    return TupleExprElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTupleExprElement(arena: SyntaxArena = .default) -> TupleExprElementSyntax {
    let raw = RawTupleExprElementSyntax.makeBlank(arena: arena).raw
    return TupleExprElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeArrayElement(
    arena: SyntaxArena = .default, expression: ExprSyntax, trailingComma: TokenSyntax?
  ) -> ArrayElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayElement,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = expression.raw
      buffer[1] = trailingComma?.raw
    }
    return ArrayElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankArrayElement(arena: SyntaxArena = .default) -> ArrayElementSyntax {
    let raw = RawArrayElementSyntax.makeBlank(arena: arena).raw
    return ArrayElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDictionaryElement(
    arena: SyntaxArena = .default, keyExpression: ExprSyntax, colon: TokenSyntax, valueExpression: ExprSyntax, trailingComma: TokenSyntax?
  ) -> DictionaryElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryElement,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = keyExpression.raw
      buffer[1] = colon.raw
      buffer[2] = valueExpression.raw
      buffer[3] = trailingComma?.raw
    }
    return DictionaryElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDictionaryElement(arena: SyntaxArena = .default) -> DictionaryElementSyntax {
    let raw = RawDictionaryElementSyntax.makeBlank(arena: arena).raw
    return DictionaryElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIntegerLiteralExpr(
    arena: SyntaxArena = .default, digits: TokenSyntax
  ) -> IntegerLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .integerLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = digits.raw
    }
    return IntegerLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIntegerLiteralExpr(arena: SyntaxArena = .default) -> IntegerLiteralExprSyntax {
    let raw = RawIntegerLiteralExprSyntax.makeBlank(arena: arena).raw
    return IntegerLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBooleanLiteralExpr(
    arena: SyntaxArena = .default, booleanLiteral: TokenSyntax
  ) -> BooleanLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .booleanLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = booleanLiteral.raw
    }
    return BooleanLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankBooleanLiteralExpr(arena: SyntaxArena = .default) -> BooleanLiteralExprSyntax {
    let raw = RawBooleanLiteralExprSyntax.makeBlank(arena: arena).raw
    return BooleanLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTernaryExpr(
    arena: SyntaxArena = .default, conditionExpression: ExprSyntax, questionMark: TokenSyntax, firstChoice: ExprSyntax, colonMark: TokenSyntax, secondChoice: ExprSyntax
  ) -> TernaryExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ternaryExpr,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = conditionExpression.raw
      buffer[1] = questionMark.raw
      buffer[2] = firstChoice.raw
      buffer[3] = colonMark.raw
      buffer[4] = secondChoice.raw
    }
    return TernaryExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTernaryExpr(arena: SyntaxArena = .default) -> TernaryExprSyntax {
    let raw = RawTernaryExprSyntax.makeBlank(arena: arena).raw
    return TernaryExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMemberAccessExpr(
    arena: SyntaxArena = .default, base: ExprSyntax?, dot: TokenSyntax, name: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?
  ) -> MemberAccessExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberAccessExpr,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = base?.raw
      buffer[1] = dot.raw
      buffer[2] = name.raw
      buffer[3] = declNameArguments?.raw
    }
    return MemberAccessExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMemberAccessExpr(arena: SyntaxArena = .default) -> MemberAccessExprSyntax {
    let raw = RawMemberAccessExprSyntax.makeBlank(arena: arena).raw
    return MemberAccessExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIsExpr(
    arena: SyntaxArena = .default, isTok: TokenSyntax, typeName: TypeSyntax
  ) -> IsExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .isExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = isTok.raw
      buffer[1] = typeName.raw
    }
    return IsExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIsExpr(arena: SyntaxArena = .default) -> IsExprSyntax {
    let raw = RawIsExprSyntax.makeBlank(arena: arena).raw
    return IsExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAsExpr(
    arena: SyntaxArena = .default, asTok: TokenSyntax, questionOrExclamationMark: TokenSyntax?, typeName: TypeSyntax
  ) -> AsExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .asExpr,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = asTok.raw
      buffer[1] = questionOrExclamationMark?.raw
      buffer[2] = typeName.raw
    }
    return AsExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAsExpr(arena: SyntaxArena = .default) -> AsExprSyntax {
    let raw = RawAsExprSyntax.makeBlank(arena: arena).raw
    return AsExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTypeExpr(
    arena: SyntaxArena = .default, type: TypeSyntax
  ) -> TypeExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = type.raw
    }
    return TypeExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTypeExpr(arena: SyntaxArena = .default) -> TypeExprSyntax {
    let raw = RawTypeExprSyntax.makeBlank(arena: arena).raw
    return TypeExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClosureCaptureItem(
    arena: SyntaxArena = .default, specifier: TokenListSyntax?, name: TokenSyntax?, assignToken: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?
  ) -> ClosureCaptureItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureCaptureItem,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = specifier?.raw
      buffer[1] = name?.raw
      buffer[2] = assignToken?.raw
      buffer[3] = expression.raw
      buffer[4] = trailingComma?.raw
    }
    return ClosureCaptureItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClosureCaptureItem(arena: SyntaxArena = .default) -> ClosureCaptureItemSyntax {
    let raw = RawClosureCaptureItemSyntax.makeBlank(arena: arena).raw
    return ClosureCaptureItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClosureCaptureItemList(
    arena: SyntaxArena = .default, _ elements: [ClosureCaptureItemSyntax]
  ) -> ClosureCaptureItemListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureCaptureItemList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return ClosureCaptureItemListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClosureCaptureItemList(arena: SyntaxArena = .default) -> ClosureCaptureItemListSyntax {
    let raw = RawClosureCaptureItemListSyntax.makeBlank(arena: arena).raw
    return ClosureCaptureItemListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClosureCaptureSignature(
    arena: SyntaxArena = .default, leftSquare: TokenSyntax, items: ClosureCaptureItemListSyntax?, rightSquare: TokenSyntax
  ) -> ClosureCaptureSignatureSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureCaptureSignature,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftSquare.raw
      buffer[1] = items?.raw
      buffer[2] = rightSquare.raw
    }
    return ClosureCaptureSignatureSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClosureCaptureSignature(arena: SyntaxArena = .default) -> ClosureCaptureSignatureSyntax {
    let raw = RawClosureCaptureSignatureSyntax.makeBlank(arena: arena).raw
    return ClosureCaptureSignatureSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClosureParam(
    arena: SyntaxArena = .default, name: TokenSyntax, trailingComma: TokenSyntax?
  ) -> ClosureParamSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureParam,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = trailingComma?.raw
    }
    return ClosureParamSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClosureParam(arena: SyntaxArena = .default) -> ClosureParamSyntax {
    let raw = RawClosureParamSyntax.makeBlank(arena: arena).raw
    return ClosureParamSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClosureParamList(
    arena: SyntaxArena = .default, _ elements: [ClosureParamSyntax]
  ) -> ClosureParamListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureParamList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return ClosureParamListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClosureParamList(arena: SyntaxArena = .default) -> ClosureParamListSyntax {
    let raw = RawClosureParamListSyntax.makeBlank(arena: arena).raw
    return ClosureParamListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClosureSignature(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, capture: ClosureCaptureSignatureSyntax?, input: Syntax?, asyncKeyword: TokenSyntax?, throwsTok: TokenSyntax?, output: ReturnClauseSyntax?, inTok: TokenSyntax
  ) -> ClosureSignatureSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureSignature,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = capture?.raw
      buffer[2] = input?.raw
      buffer[3] = asyncKeyword?.raw
      buffer[4] = throwsTok?.raw
      buffer[5] = output?.raw
      buffer[6] = inTok.raw
    }
    return ClosureSignatureSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClosureSignature(arena: SyntaxArena = .default) -> ClosureSignatureSyntax {
    let raw = RawClosureSignatureSyntax.makeBlank(arena: arena).raw
    return ClosureSignatureSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClosureExpr(
    arena: SyntaxArena = .default, leftBrace: TokenSyntax, signature: ClosureSignatureSyntax?, statements: CodeBlockItemListSyntax, rightBrace: TokenSyntax
  ) -> ClosureExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .closureExpr,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftBrace.raw
      buffer[1] = signature?.raw
      buffer[2] = statements.raw
      buffer[3] = rightBrace.raw
    }
    return ClosureExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClosureExpr(arena: SyntaxArena = .default) -> ClosureExprSyntax {
    let raw = RawClosureExprSyntax.makeBlank(arena: arena).raw
    return ClosureExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeUnresolvedPatternExpr(
    arena: SyntaxArena = .default, pattern: PatternSyntax
  ) -> UnresolvedPatternExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .unresolvedPatternExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = pattern.raw
    }
    return UnresolvedPatternExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankUnresolvedPatternExpr(arena: SyntaxArena = .default) -> UnresolvedPatternExprSyntax {
    let raw = RawUnresolvedPatternExprSyntax.makeBlank(arena: arena).raw
    return UnresolvedPatternExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMultipleTrailingClosureElement(
    arena: SyntaxArena = .default, label: TokenSyntax, colon: TokenSyntax, closure: ClosureExprSyntax
  ) -> MultipleTrailingClosureElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .multipleTrailingClosureElement,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = label.raw
      buffer[1] = colon.raw
      buffer[2] = closure.raw
    }
    return MultipleTrailingClosureElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMultipleTrailingClosureElement(arena: SyntaxArena = .default) -> MultipleTrailingClosureElementSyntax {
    let raw = RawMultipleTrailingClosureElementSyntax.makeBlank(arena: arena).raw
    return MultipleTrailingClosureElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMultipleTrailingClosureElementList(
    arena: SyntaxArena = .default, _ elements: [MultipleTrailingClosureElementSyntax]
  ) -> MultipleTrailingClosureElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .multipleTrailingClosureElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return MultipleTrailingClosureElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMultipleTrailingClosureElementList(arena: SyntaxArena = .default) -> MultipleTrailingClosureElementListSyntax {
    let raw = RawMultipleTrailingClosureElementListSyntax.makeBlank(arena: arena).raw
    return MultipleTrailingClosureElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFunctionCallExpr(
    arena: SyntaxArena = .default, calledExpression: ExprSyntax, leftParen: TokenSyntax?, argumentList: TupleExprElementListSyntax, rightParen: TokenSyntax?, trailingClosure: ClosureExprSyntax?, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?
  ) -> FunctionCallExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionCallExpr,
                                   uninitializedCount: 6) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = calledExpression.raw
      buffer[1] = leftParen?.raw
      buffer[2] = argumentList.raw
      buffer[3] = rightParen?.raw
      buffer[4] = trailingClosure?.raw
      buffer[5] = additionalTrailingClosures?.raw
    }
    return FunctionCallExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFunctionCallExpr(arena: SyntaxArena = .default) -> FunctionCallExprSyntax {
    let raw = RawFunctionCallExprSyntax.makeBlank(arena: arena).raw
    return FunctionCallExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSubscriptExpr(
    arena: SyntaxArena = .default, calledExpression: ExprSyntax, leftBracket: TokenSyntax, argumentList: TupleExprElementListSyntax, rightBracket: TokenSyntax, trailingClosure: ClosureExprSyntax?, additionalTrailingClosures: MultipleTrailingClosureElementListSyntax?
  ) -> SubscriptExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .subscriptExpr,
                                   uninitializedCount: 6) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = calledExpression.raw
      buffer[1] = leftBracket.raw
      buffer[2] = argumentList.raw
      buffer[3] = rightBracket.raw
      buffer[4] = trailingClosure?.raw
      buffer[5] = additionalTrailingClosures?.raw
    }
    return SubscriptExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSubscriptExpr(arena: SyntaxArena = .default) -> SubscriptExprSyntax {
    let raw = RawSubscriptExprSyntax.makeBlank(arena: arena).raw
    return SubscriptExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeOptionalChainingExpr(
    arena: SyntaxArena = .default, expression: ExprSyntax, questionMark: TokenSyntax
  ) -> OptionalChainingExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalChainingExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = expression.raw
      buffer[1] = questionMark.raw
    }
    return OptionalChainingExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankOptionalChainingExpr(arena: SyntaxArena = .default) -> OptionalChainingExprSyntax {
    let raw = RawOptionalChainingExprSyntax.makeBlank(arena: arena).raw
    return OptionalChainingExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeForcedValueExpr(
    arena: SyntaxArena = .default, expression: ExprSyntax, exclamationMark: TokenSyntax
  ) -> ForcedValueExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .forcedValueExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = expression.raw
      buffer[1] = exclamationMark.raw
    }
    return ForcedValueExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankForcedValueExpr(arena: SyntaxArena = .default) -> ForcedValueExprSyntax {
    let raw = RawForcedValueExprSyntax.makeBlank(arena: arena).raw
    return ForcedValueExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePostfixUnaryExpr(
    arena: SyntaxArena = .default, expression: ExprSyntax, operatorToken: TokenSyntax
  ) -> PostfixUnaryExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .postfixUnaryExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = expression.raw
      buffer[1] = operatorToken.raw
    }
    return PostfixUnaryExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPostfixUnaryExpr(arena: SyntaxArena = .default) -> PostfixUnaryExprSyntax {
    let raw = RawPostfixUnaryExprSyntax.makeBlank(arena: arena).raw
    return PostfixUnaryExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSpecializeExpr(
    arena: SyntaxArena = .default, expression: ExprSyntax, genericArgumentClause: GenericArgumentClauseSyntax
  ) -> SpecializeExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .specializeExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = expression.raw
      buffer[1] = genericArgumentClause.raw
    }
    return SpecializeExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSpecializeExpr(arena: SyntaxArena = .default) -> SpecializeExprSyntax {
    let raw = RawSpecializeExprSyntax.makeBlank(arena: arena).raw
    return SpecializeExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeStringSegment(
    arena: SyntaxArena = .default, content: TokenSyntax
  ) -> StringSegmentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .stringSegment,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = content.raw
    }
    return StringSegmentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankStringSegment(arena: SyntaxArena = .default) -> StringSegmentSyntax {
    let raw = RawStringSegmentSyntax.makeBlank(arena: arena).raw
    return StringSegmentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeExpressionSegment(
    arena: SyntaxArena = .default, backslash: TokenSyntax, delimiter: TokenSyntax?, leftParen: TokenSyntax, expressions: TupleExprElementListSyntax, rightParen: TokenSyntax
  ) -> ExpressionSegmentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionSegment,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = backslash.raw
      buffer[1] = delimiter?.raw
      buffer[2] = leftParen.raw
      buffer[3] = expressions.raw
      buffer[4] = rightParen.raw
    }
    return ExpressionSegmentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankExpressionSegment(arena: SyntaxArena = .default) -> ExpressionSegmentSyntax {
    let raw = RawExpressionSegmentSyntax.makeBlank(arena: arena).raw
    return ExpressionSegmentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeStringLiteralExpr(
    arena: SyntaxArena = .default, openDelimiter: TokenSyntax?, openQuote: TokenSyntax, segments: StringLiteralSegmentsSyntax, closeQuote: TokenSyntax, closeDelimiter: TokenSyntax?
  ) -> StringLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .stringLiteralExpr,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = openDelimiter?.raw
      buffer[1] = openQuote.raw
      buffer[2] = segments.raw
      buffer[3] = closeQuote.raw
      buffer[4] = closeDelimiter?.raw
    }
    return StringLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankStringLiteralExpr(arena: SyntaxArena = .default) -> StringLiteralExprSyntax {
    let raw = RawStringLiteralExprSyntax.makeBlank(arena: arena).raw
    return StringLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeRegexLiteralExpr(
    arena: SyntaxArena = .default, regex: TokenSyntax
  ) -> RegexLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .regexLiteralExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = regex.raw
    }
    return RegexLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankRegexLiteralExpr(arena: SyntaxArena = .default) -> RegexLiteralExprSyntax {
    let raw = RawRegexLiteralExprSyntax.makeBlank(arena: arena).raw
    return RegexLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeKeyPathExpr(
    arena: SyntaxArena = .default, backslash: TokenSyntax, rootExpr: ExprSyntax?, expression: ExprSyntax
  ) -> KeyPathExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .keyPathExpr,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = backslash.raw
      buffer[1] = rootExpr?.raw
      buffer[2] = expression.raw
    }
    return KeyPathExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankKeyPathExpr(arena: SyntaxArena = .default) -> KeyPathExprSyntax {
    let raw = RawKeyPathExprSyntax.makeBlank(arena: arena).raw
    return KeyPathExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeKeyPathBaseExpr(
    arena: SyntaxArena = .default, period: TokenSyntax
  ) -> KeyPathBaseExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .keyPathBaseExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = period.raw
    }
    return KeyPathBaseExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankKeyPathBaseExpr(arena: SyntaxArena = .default) -> KeyPathBaseExprSyntax {
    let raw = RawKeyPathBaseExprSyntax.makeBlank(arena: arena).raw
    return KeyPathBaseExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeObjcNamePiece(
    arena: SyntaxArena = .default, name: TokenSyntax, dot: TokenSyntax?
  ) -> ObjcNamePieceSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcNamePiece,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = dot?.raw
    }
    return ObjcNamePieceSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankObjcNamePiece(arena: SyntaxArena = .default) -> ObjcNamePieceSyntax {
    let raw = RawObjcNamePieceSyntax.makeBlank(arena: arena).raw
    return ObjcNamePieceSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeObjcName(
    arena: SyntaxArena = .default, _ elements: [ObjcNamePieceSyntax]
  ) -> ObjcNameSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcName, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return ObjcNameSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankObjcName(arena: SyntaxArena = .default) -> ObjcNameSyntax {
    let raw = RawObjcNameSyntax.makeBlank(arena: arena).raw
    return ObjcNameSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeObjcKeyPathExpr(
    arena: SyntaxArena = .default, keyPath: TokenSyntax, leftParen: TokenSyntax, name: ObjcNameSyntax, rightParen: TokenSyntax
  ) -> ObjcKeyPathExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcKeyPathExpr,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = keyPath.raw
      buffer[1] = leftParen.raw
      buffer[2] = name.raw
      buffer[3] = rightParen.raw
    }
    return ObjcKeyPathExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankObjcKeyPathExpr(arena: SyntaxArena = .default) -> ObjcKeyPathExprSyntax {
    let raw = RawObjcKeyPathExprSyntax.makeBlank(arena: arena).raw
    return ObjcKeyPathExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeObjcSelectorExpr(
    arena: SyntaxArena = .default, poundSelector: TokenSyntax, leftParen: TokenSyntax, kind: TokenSyntax?, colon: TokenSyntax?, name: ExprSyntax, rightParen: TokenSyntax
  ) -> ObjcSelectorExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objcSelectorExpr,
                                   uninitializedCount: 6) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundSelector.raw
      buffer[1] = leftParen.raw
      buffer[2] = kind?.raw
      buffer[3] = colon?.raw
      buffer[4] = name.raw
      buffer[5] = rightParen.raw
    }
    return ObjcSelectorExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankObjcSelectorExpr(arena: SyntaxArena = .default) -> ObjcSelectorExprSyntax {
    let raw = RawObjcSelectorExprSyntax.makeBlank(arena: arena).raw
    return ObjcSelectorExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePostfixIfConfigExpr(
    arena: SyntaxArena = .default, base: ExprSyntax?, config: IfConfigDeclSyntax
  ) -> PostfixIfConfigExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .postfixIfConfigExpr,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = base?.raw
      buffer[1] = config.raw
    }
    return PostfixIfConfigExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPostfixIfConfigExpr(arena: SyntaxArena = .default) -> PostfixIfConfigExprSyntax {
    let raw = RawPostfixIfConfigExprSyntax.makeBlank(arena: arena).raw
    return PostfixIfConfigExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeEditorPlaceholderExpr(
    arena: SyntaxArena = .default, identifier: TokenSyntax
  ) -> EditorPlaceholderExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .editorPlaceholderExpr,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = identifier.raw
    }
    return EditorPlaceholderExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankEditorPlaceholderExpr(arena: SyntaxArena = .default) -> EditorPlaceholderExprSyntax {
    let raw = RawEditorPlaceholderExprSyntax.makeBlank(arena: arena).raw
    return EditorPlaceholderExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeObjectLiteralExpr(
    arena: SyntaxArena = .default, identifier: TokenSyntax, leftParen: TokenSyntax, arguments: TupleExprElementListSyntax, rightParen: TokenSyntax
  ) -> ObjectLiteralExprSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objectLiteralExpr,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = identifier.raw
      buffer[1] = leftParen.raw
      buffer[2] = arguments.raw
      buffer[3] = rightParen.raw
    }
    return ObjectLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankObjectLiteralExpr(arena: SyntaxArena = .default) -> ObjectLiteralExprSyntax {
    let raw = RawObjectLiteralExprSyntax.makeBlank(arena: arena).raw
    return ObjectLiteralExprSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTypeInitializerClause(
    arena: SyntaxArena = .default, equal: TokenSyntax, value: TypeSyntax
  ) -> TypeInitializerClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeInitializerClause,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = equal.raw
      buffer[1] = value.raw
    }
    return TypeInitializerClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTypeInitializerClause(arena: SyntaxArena = .default) -> TypeInitializerClauseSyntax {
    let raw = RawTypeInitializerClauseSyntax.makeBlank(arena: arena).raw
    return TypeInitializerClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTypealiasDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, typealiasKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, initializer: TypeInitializerClauseSyntax, genericWhereClause: GenericWhereClauseSyntax?
  ) -> TypealiasDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typealiasDecl,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = typealiasKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = genericParameterClause?.raw
      buffer[5] = initializer.raw
      buffer[6] = genericWhereClause?.raw
    }
    return TypealiasDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTypealiasDecl(arena: SyntaxArena = .default) -> TypealiasDeclSyntax {
    let raw = RawTypealiasDeclSyntax.makeBlank(arena: arena).raw
    return TypealiasDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAssociatedtypeDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, associatedtypeKeyword: TokenSyntax, identifier: TokenSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, initializer: TypeInitializerClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?
  ) -> AssociatedtypeDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .associatedtypeDecl,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = associatedtypeKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = inheritanceClause?.raw
      buffer[5] = initializer?.raw
      buffer[6] = genericWhereClause?.raw
    }
    return AssociatedtypeDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAssociatedtypeDecl(arena: SyntaxArena = .default) -> AssociatedtypeDeclSyntax {
    let raw = RawAssociatedtypeDeclSyntax.makeBlank(arena: arena).raw
    return AssociatedtypeDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFunctionParameterList(
    arena: SyntaxArena = .default, _ elements: [FunctionParameterSyntax]
  ) -> FunctionParameterListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionParameterList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return FunctionParameterListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFunctionParameterList(arena: SyntaxArena = .default) -> FunctionParameterListSyntax {
    let raw = RawFunctionParameterListSyntax.makeBlank(arena: arena).raw
    return FunctionParameterListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeParameterClause(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, parameterList: FunctionParameterListSyntax, rightParen: TokenSyntax
  ) -> ParameterClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .parameterClause,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = parameterList.raw
      buffer[2] = rightParen.raw
    }
    return ParameterClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankParameterClause(arena: SyntaxArena = .default) -> ParameterClauseSyntax {
    let raw = RawParameterClauseSyntax.makeBlank(arena: arena).raw
    return ParameterClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeReturnClause(
    arena: SyntaxArena = .default, arrow: TokenSyntax, returnType: TypeSyntax
  ) -> ReturnClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .returnClause,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = arrow.raw
      buffer[1] = returnType.raw
    }
    return ReturnClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankReturnClause(arena: SyntaxArena = .default) -> ReturnClauseSyntax {
    let raw = RawReturnClauseSyntax.makeBlank(arena: arena).raw
    return ReturnClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFunctionSignature(
    arena: SyntaxArena = .default, input: ParameterClauseSyntax, asyncOrReasyncKeyword: TokenSyntax?, throwsOrRethrowsKeyword: TokenSyntax?, output: ReturnClauseSyntax?
  ) -> FunctionSignatureSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionSignature,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = input.raw
      buffer[1] = asyncOrReasyncKeyword?.raw
      buffer[2] = throwsOrRethrowsKeyword?.raw
      buffer[3] = output?.raw
    }
    return FunctionSignatureSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFunctionSignature(arena: SyntaxArena = .default) -> FunctionSignatureSyntax {
    let raw = RawFunctionSignatureSyntax.makeBlank(arena: arena).raw
    return FunctionSignatureSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIfConfigClause(
    arena: SyntaxArena = .default, poundKeyword: TokenSyntax, condition: ExprSyntax?, elements: Syntax
  ) -> IfConfigClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifConfigClause,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundKeyword.raw
      buffer[1] = condition?.raw
      buffer[2] = elements.raw
    }
    return IfConfigClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIfConfigClause(arena: SyntaxArena = .default) -> IfConfigClauseSyntax {
    let raw = RawIfConfigClauseSyntax.makeBlank(arena: arena).raw
    return IfConfigClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIfConfigClauseList(
    arena: SyntaxArena = .default, _ elements: [IfConfigClauseSyntax]
  ) -> IfConfigClauseListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifConfigClauseList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return IfConfigClauseListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIfConfigClauseList(arena: SyntaxArena = .default) -> IfConfigClauseListSyntax {
    let raw = RawIfConfigClauseListSyntax.makeBlank(arena: arena).raw
    return IfConfigClauseListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIfConfigDecl(
    arena: SyntaxArena = .default, clauses: IfConfigClauseListSyntax, poundEndif: TokenSyntax
  ) -> IfConfigDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifConfigDecl,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = clauses.raw
      buffer[1] = poundEndif.raw
    }
    return IfConfigDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIfConfigDecl(arena: SyntaxArena = .default) -> IfConfigDeclSyntax {
    let raw = RawIfConfigDeclSyntax.makeBlank(arena: arena).raw
    return IfConfigDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundErrorDecl(
    arena: SyntaxArena = .default, poundError: TokenSyntax, leftParen: TokenSyntax, message: StringLiteralExprSyntax, rightParen: TokenSyntax
  ) -> PoundErrorDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundErrorDecl,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundError.raw
      buffer[1] = leftParen.raw
      buffer[2] = message.raw
      buffer[3] = rightParen.raw
    }
    return PoundErrorDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundErrorDecl(arena: SyntaxArena = .default) -> PoundErrorDeclSyntax {
    let raw = RawPoundErrorDeclSyntax.makeBlank(arena: arena).raw
    return PoundErrorDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundWarningDecl(
    arena: SyntaxArena = .default, poundWarning: TokenSyntax, leftParen: TokenSyntax, message: StringLiteralExprSyntax, rightParen: TokenSyntax
  ) -> PoundWarningDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundWarningDecl,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundWarning.raw
      buffer[1] = leftParen.raw
      buffer[2] = message.raw
      buffer[3] = rightParen.raw
    }
    return PoundWarningDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundWarningDecl(arena: SyntaxArena = .default) -> PoundWarningDeclSyntax {
    let raw = RawPoundWarningDeclSyntax.makeBlank(arena: arena).raw
    return PoundWarningDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundSourceLocation(
    arena: SyntaxArena = .default, poundSourceLocation: TokenSyntax, leftParen: TokenSyntax, args: PoundSourceLocationArgsSyntax?, rightParen: TokenSyntax
  ) -> PoundSourceLocationSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundSourceLocation,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundSourceLocation.raw
      buffer[1] = leftParen.raw
      buffer[2] = args?.raw
      buffer[3] = rightParen.raw
    }
    return PoundSourceLocationSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundSourceLocation(arena: SyntaxArena = .default) -> PoundSourceLocationSyntax {
    let raw = RawPoundSourceLocationSyntax.makeBlank(arena: arena).raw
    return PoundSourceLocationSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundSourceLocationArgs(
    arena: SyntaxArena = .default, fileArgLabel: TokenSyntax, fileArgColon: TokenSyntax, fileName: TokenSyntax, comma: TokenSyntax, lineArgLabel: TokenSyntax, lineArgColon: TokenSyntax, lineNumber: TokenSyntax
  ) -> PoundSourceLocationArgsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundSourceLocationArgs,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = fileArgLabel.raw
      buffer[1] = fileArgColon.raw
      buffer[2] = fileName.raw
      buffer[3] = comma.raw
      buffer[4] = lineArgLabel.raw
      buffer[5] = lineArgColon.raw
      buffer[6] = lineNumber.raw
    }
    return PoundSourceLocationArgsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundSourceLocationArgs(arena: SyntaxArena = .default) -> PoundSourceLocationArgsSyntax {
    let raw = RawPoundSourceLocationArgsSyntax.makeBlank(arena: arena).raw
    return PoundSourceLocationArgsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeclModifierDetail(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, detail: TokenSyntax, rightParen: TokenSyntax
  ) -> DeclModifierDetailSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declModifierDetail,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = detail.raw
      buffer[2] = rightParen.raw
    }
    return DeclModifierDetailSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeclModifierDetail(arena: SyntaxArena = .default) -> DeclModifierDetailSyntax {
    let raw = RawDeclModifierDetailSyntax.makeBlank(arena: arena).raw
    return DeclModifierDetailSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeclModifier(
    arena: SyntaxArena = .default, name: TokenSyntax, detail: DeclModifierDetailSyntax?
  ) -> DeclModifierSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declModifier,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = detail?.raw
    }
    return DeclModifierSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeclModifier(arena: SyntaxArena = .default) -> DeclModifierSyntax {
    let raw = RawDeclModifierSyntax.makeBlank(arena: arena).raw
    return DeclModifierSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeInheritedType(
    arena: SyntaxArena = .default, typeName: TypeSyntax, trailingComma: TokenSyntax?
  ) -> InheritedTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .inheritedType,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = typeName.raw
      buffer[1] = trailingComma?.raw
    }
    return InheritedTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankInheritedType(arena: SyntaxArena = .default) -> InheritedTypeSyntax {
    let raw = RawInheritedTypeSyntax.makeBlank(arena: arena).raw
    return InheritedTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeInheritedTypeList(
    arena: SyntaxArena = .default, _ elements: [InheritedTypeSyntax]
  ) -> InheritedTypeListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .inheritedTypeList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return InheritedTypeListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankInheritedTypeList(arena: SyntaxArena = .default) -> InheritedTypeListSyntax {
    let raw = RawInheritedTypeListSyntax.makeBlank(arena: arena).raw
    return InheritedTypeListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTypeInheritanceClause(
    arena: SyntaxArena = .default, colon: TokenSyntax, inheritedTypeCollection: InheritedTypeListSyntax
  ) -> TypeInheritanceClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeInheritanceClause,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = colon.raw
      buffer[1] = inheritedTypeCollection.raw
    }
    return TypeInheritanceClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTypeInheritanceClause(arena: SyntaxArena = .default) -> TypeInheritanceClauseSyntax {
    let raw = RawTypeInheritanceClauseSyntax.makeBlank(arena: arena).raw
    return TypeInheritanceClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClassDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, classKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax
  ) -> ClassDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .classDecl,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = classKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = genericParameterClause?.raw
      buffer[5] = inheritanceClause?.raw
      buffer[6] = genericWhereClause?.raw
      buffer[7] = members.raw
    }
    return ClassDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClassDecl(arena: SyntaxArena = .default) -> ClassDeclSyntax {
    let raw = RawClassDeclSyntax.makeBlank(arena: arena).raw
    return ClassDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeActorDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, actorKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax
  ) -> ActorDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .actorDecl,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = actorKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = genericParameterClause?.raw
      buffer[5] = inheritanceClause?.raw
      buffer[6] = genericWhereClause?.raw
      buffer[7] = members.raw
    }
    return ActorDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankActorDecl(arena: SyntaxArena = .default) -> ActorDeclSyntax {
    let raw = RawActorDeclSyntax.makeBlank(arena: arena).raw
    return ActorDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeStructDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, structKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax
  ) -> StructDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .structDecl,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = structKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = genericParameterClause?.raw
      buffer[5] = inheritanceClause?.raw
      buffer[6] = genericWhereClause?.raw
      buffer[7] = members.raw
    }
    return StructDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankStructDecl(arena: SyntaxArena = .default) -> StructDeclSyntax {
    let raw = RawStructDeclSyntax.makeBlank(arena: arena).raw
    return StructDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeProtocolDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, protocolKeyword: TokenSyntax, identifier: TokenSyntax, primaryAssociatedTypeClause: PrimaryAssociatedTypeClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax
  ) -> ProtocolDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .protocolDecl,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = protocolKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = primaryAssociatedTypeClause?.raw
      buffer[5] = inheritanceClause?.raw
      buffer[6] = genericWhereClause?.raw
      buffer[7] = members.raw
    }
    return ProtocolDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankProtocolDecl(arena: SyntaxArena = .default) -> ProtocolDeclSyntax {
    let raw = RawProtocolDeclSyntax.makeBlank(arena: arena).raw
    return ProtocolDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeExtensionDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, extensionKeyword: TokenSyntax, extendedType: TypeSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax
  ) -> ExtensionDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .extensionDecl,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = extensionKeyword.raw
      buffer[3] = extendedType.raw
      buffer[4] = inheritanceClause?.raw
      buffer[5] = genericWhereClause?.raw
      buffer[6] = members.raw
    }
    return ExtensionDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankExtensionDecl(arena: SyntaxArena = .default) -> ExtensionDeclSyntax {
    let raw = RawExtensionDeclSyntax.makeBlank(arena: arena).raw
    return ExtensionDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMemberDeclBlock(
    arena: SyntaxArena = .default, leftBrace: TokenSyntax, members: MemberDeclListSyntax, rightBrace: TokenSyntax
  ) -> MemberDeclBlockSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberDeclBlock,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftBrace.raw
      buffer[1] = members.raw
      buffer[2] = rightBrace.raw
    }
    return MemberDeclBlockSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMemberDeclBlock(arena: SyntaxArena = .default) -> MemberDeclBlockSyntax {
    let raw = RawMemberDeclBlockSyntax.makeBlank(arena: arena).raw
    return MemberDeclBlockSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMemberDeclList(
    arena: SyntaxArena = .default, _ elements: [MemberDeclListItemSyntax]
  ) -> MemberDeclListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberDeclList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return MemberDeclListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMemberDeclList(arena: SyntaxArena = .default) -> MemberDeclListSyntax {
    let raw = RawMemberDeclListSyntax.makeBlank(arena: arena).raw
    return MemberDeclListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMemberDeclListItem(
    arena: SyntaxArena = .default, decl: DeclSyntax, semicolon: TokenSyntax?
  ) -> MemberDeclListItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberDeclListItem,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = decl.raw
      buffer[1] = semicolon?.raw
    }
    return MemberDeclListItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMemberDeclListItem(arena: SyntaxArena = .default) -> MemberDeclListItemSyntax {
    let raw = RawMemberDeclListItemSyntax.makeBlank(arena: arena).raw
    return MemberDeclListItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSourceFile(
    arena: SyntaxArena = .default, statements: CodeBlockItemListSyntax, eofToken: TokenSyntax
  ) -> SourceFileSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .sourceFile,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = statements.raw
      buffer[1] = eofToken.raw
    }
    return SourceFileSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSourceFile(arena: SyntaxArena = .default) -> SourceFileSyntax {
    let raw = RawSourceFileSyntax.makeBlank(arena: arena).raw
    return SourceFileSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeInitializerClause(
    arena: SyntaxArena = .default, equal: TokenSyntax, value: ExprSyntax
  ) -> InitializerClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .initializerClause,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = equal.raw
      buffer[1] = value.raw
    }
    return InitializerClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankInitializerClause(arena: SyntaxArena = .default) -> InitializerClauseSyntax {
    let raw = RawInitializerClauseSyntax.makeBlank(arena: arena).raw
    return InitializerClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFunctionParameter(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, firstName: TokenSyntax?, secondName: TokenSyntax?, colon: TokenSyntax?, type: TypeSyntax?, ellipsis: TokenSyntax?, defaultArgument: InitializerClauseSyntax?, trailingComma: TokenSyntax?
  ) -> FunctionParameterSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionParameter,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = firstName?.raw
      buffer[2] = secondName?.raw
      buffer[3] = colon?.raw
      buffer[4] = type?.raw
      buffer[5] = ellipsis?.raw
      buffer[6] = defaultArgument?.raw
      buffer[7] = trailingComma?.raw
    }
    return FunctionParameterSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFunctionParameter(arena: SyntaxArena = .default) -> FunctionParameterSyntax {
    let raw = RawFunctionParameterSyntax.makeBlank(arena: arena).raw
    return FunctionParameterSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeModifierList(
    arena: SyntaxArena = .default, _ elements: [DeclModifierSyntax]
  ) -> ModifierListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .modifierList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return ModifierListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankModifierList(arena: SyntaxArena = .default) -> ModifierListSyntax {
    let raw = RawModifierListSyntax.makeBlank(arena: arena).raw
    return ModifierListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFunctionDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, funcKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, signature: FunctionSignatureSyntax, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax?
  ) -> FunctionDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionDecl,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = funcKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = genericParameterClause?.raw
      buffer[5] = signature.raw
      buffer[6] = genericWhereClause?.raw
      buffer[7] = body?.raw
    }
    return FunctionDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFunctionDecl(arena: SyntaxArena = .default) -> FunctionDeclSyntax {
    let raw = RawFunctionDeclSyntax.makeBlank(arena: arena).raw
    return FunctionDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeInitializerDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, initKeyword: TokenSyntax, optionalMark: TokenSyntax?, genericParameterClause: GenericParameterClauseSyntax?, signature: FunctionSignatureSyntax, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax?
  ) -> InitializerDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .initializerDecl,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = initKeyword.raw
      buffer[3] = optionalMark?.raw
      buffer[4] = genericParameterClause?.raw
      buffer[5] = signature.raw
      buffer[6] = genericWhereClause?.raw
      buffer[7] = body?.raw
    }
    return InitializerDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankInitializerDecl(arena: SyntaxArena = .default) -> InitializerDeclSyntax {
    let raw = RawInitializerDeclSyntax.makeBlank(arena: arena).raw
    return InitializerDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeinitializerDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, deinitKeyword: TokenSyntax, body: CodeBlockSyntax?
  ) -> DeinitializerDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .deinitializerDecl,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = deinitKeyword.raw
      buffer[3] = body?.raw
    }
    return DeinitializerDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeinitializerDecl(arena: SyntaxArena = .default) -> DeinitializerDeclSyntax {
    let raw = RawDeinitializerDeclSyntax.makeBlank(arena: arena).raw
    return DeinitializerDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSubscriptDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, subscriptKeyword: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, indices: ParameterClauseSyntax, result: ReturnClauseSyntax, genericWhereClause: GenericWhereClauseSyntax?, accessor: Syntax?
  ) -> SubscriptDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .subscriptDecl,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = subscriptKeyword.raw
      buffer[3] = genericParameterClause?.raw
      buffer[4] = indices.raw
      buffer[5] = result.raw
      buffer[6] = genericWhereClause?.raw
      buffer[7] = accessor?.raw
    }
    return SubscriptDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSubscriptDecl(arena: SyntaxArena = .default) -> SubscriptDeclSyntax {
    let raw = RawSubscriptDeclSyntax.makeBlank(arena: arena).raw
    return SubscriptDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAccessLevelModifier(
    arena: SyntaxArena = .default, name: TokenSyntax, modifier: DeclModifierDetailSyntax?
  ) -> AccessLevelModifierSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessLevelModifier,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = modifier?.raw
    }
    return AccessLevelModifierSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAccessLevelModifier(arena: SyntaxArena = .default) -> AccessLevelModifierSyntax {
    let raw = RawAccessLevelModifierSyntax.makeBlank(arena: arena).raw
    return AccessLevelModifierSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAccessPathComponent(
    arena: SyntaxArena = .default, name: TokenSyntax, trailingDot: TokenSyntax?
  ) -> AccessPathComponentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessPathComponent,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = trailingDot?.raw
    }
    return AccessPathComponentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAccessPathComponent(arena: SyntaxArena = .default) -> AccessPathComponentSyntax {
    let raw = RawAccessPathComponentSyntax.makeBlank(arena: arena).raw
    return AccessPathComponentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAccessPath(
    arena: SyntaxArena = .default, _ elements: [AccessPathComponentSyntax]
  ) -> AccessPathSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessPath, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return AccessPathSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAccessPath(arena: SyntaxArena = .default) -> AccessPathSyntax {
    let raw = RawAccessPathSyntax.makeBlank(arena: arena).raw
    return AccessPathSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeImportDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, importTok: TokenSyntax, importKind: TokenSyntax?, path: AccessPathSyntax
  ) -> ImportDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .importDecl,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = importTok.raw
      buffer[3] = importKind?.raw
      buffer[4] = path.raw
    }
    return ImportDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankImportDecl(arena: SyntaxArena = .default) -> ImportDeclSyntax {
    let raw = RawImportDeclSyntax.makeBlank(arena: arena).raw
    return ImportDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAccessorParameter(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, name: TokenSyntax, rightParen: TokenSyntax
  ) -> AccessorParameterSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorParameter,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = name.raw
      buffer[2] = rightParen.raw
    }
    return AccessorParameterSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAccessorParameter(arena: SyntaxArena = .default) -> AccessorParameterSyntax {
    let raw = RawAccessorParameterSyntax.makeBlank(arena: arena).raw
    return AccessorParameterSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAccessorDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifier: DeclModifierSyntax?, accessorKind: TokenSyntax, parameter: AccessorParameterSyntax?, asyncKeyword: TokenSyntax?, throwsKeyword: TokenSyntax?, body: CodeBlockSyntax?
  ) -> AccessorDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorDecl,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifier?.raw
      buffer[2] = accessorKind.raw
      buffer[3] = parameter?.raw
      buffer[4] = asyncKeyword?.raw
      buffer[5] = throwsKeyword?.raw
      buffer[6] = body?.raw
    }
    return AccessorDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAccessorDecl(arena: SyntaxArena = .default) -> AccessorDeclSyntax {
    let raw = RawAccessorDeclSyntax.makeBlank(arena: arena).raw
    return AccessorDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAccessorList(
    arena: SyntaxArena = .default, _ elements: [AccessorDeclSyntax]
  ) -> AccessorListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return AccessorListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAccessorList(arena: SyntaxArena = .default) -> AccessorListSyntax {
    let raw = RawAccessorListSyntax.makeBlank(arena: arena).raw
    return AccessorListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAccessorBlock(
    arena: SyntaxArena = .default, leftBrace: TokenSyntax, accessors: AccessorListSyntax, rightBrace: TokenSyntax
  ) -> AccessorBlockSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .accessorBlock,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftBrace.raw
      buffer[1] = accessors.raw
      buffer[2] = rightBrace.raw
    }
    return AccessorBlockSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAccessorBlock(arena: SyntaxArena = .default) -> AccessorBlockSyntax {
    let raw = RawAccessorBlockSyntax.makeBlank(arena: arena).raw
    return AccessorBlockSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePatternBinding(
    arena: SyntaxArena = .default, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax?, accessor: Syntax?, trailingComma: TokenSyntax?
  ) -> PatternBindingSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .patternBinding,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = pattern.raw
      buffer[1] = typeAnnotation?.raw
      buffer[2] = initializer?.raw
      buffer[3] = accessor?.raw
      buffer[4] = trailingComma?.raw
    }
    return PatternBindingSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPatternBinding(arena: SyntaxArena = .default) -> PatternBindingSyntax {
    let raw = RawPatternBindingSyntax.makeBlank(arena: arena).raw
    return PatternBindingSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePatternBindingList(
    arena: SyntaxArena = .default, _ elements: [PatternBindingSyntax]
  ) -> PatternBindingListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .patternBindingList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return PatternBindingListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPatternBindingList(arena: SyntaxArena = .default) -> PatternBindingListSyntax {
    let raw = RawPatternBindingListSyntax.makeBlank(arena: arena).raw
    return PatternBindingListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeVariableDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, letOrVarKeyword: TokenSyntax, bindings: PatternBindingListSyntax
  ) -> VariableDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .variableDecl,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = letOrVarKeyword.raw
      buffer[3] = bindings.raw
    }
    return VariableDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankVariableDecl(arena: SyntaxArena = .default) -> VariableDeclSyntax {
    let raw = RawVariableDeclSyntax.makeBlank(arena: arena).raw
    return VariableDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeEnumCaseElement(
    arena: SyntaxArena = .default, identifier: TokenSyntax, associatedValue: ParameterClauseSyntax?, rawValue: InitializerClauseSyntax?, trailingComma: TokenSyntax?
  ) -> EnumCaseElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCaseElement,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = identifier.raw
      buffer[1] = associatedValue?.raw
      buffer[2] = rawValue?.raw
      buffer[3] = trailingComma?.raw
    }
    return EnumCaseElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankEnumCaseElement(arena: SyntaxArena = .default) -> EnumCaseElementSyntax {
    let raw = RawEnumCaseElementSyntax.makeBlank(arena: arena).raw
    return EnumCaseElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeEnumCaseElementList(
    arena: SyntaxArena = .default, _ elements: [EnumCaseElementSyntax]
  ) -> EnumCaseElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCaseElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return EnumCaseElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankEnumCaseElementList(arena: SyntaxArena = .default) -> EnumCaseElementListSyntax {
    let raw = RawEnumCaseElementListSyntax.makeBlank(arena: arena).raw
    return EnumCaseElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeEnumCaseDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, caseKeyword: TokenSyntax, elements: EnumCaseElementListSyntax
  ) -> EnumCaseDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCaseDecl,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = caseKeyword.raw
      buffer[3] = elements.raw
    }
    return EnumCaseDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankEnumCaseDecl(arena: SyntaxArena = .default) -> EnumCaseDeclSyntax {
    let raw = RawEnumCaseDeclSyntax.makeBlank(arena: arena).raw
    return EnumCaseDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeEnumDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, enumKeyword: TokenSyntax, identifier: TokenSyntax, genericParameters: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax
  ) -> EnumDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumDecl,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = enumKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = genericParameters?.raw
      buffer[5] = inheritanceClause?.raw
      buffer[6] = genericWhereClause?.raw
      buffer[7] = members.raw
    }
    return EnumDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankEnumDecl(arena: SyntaxArena = .default) -> EnumDeclSyntax {
    let raw = RawEnumDeclSyntax.makeBlank(arena: arena).raw
    return EnumDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeOperatorDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, operatorKeyword: TokenSyntax, identifier: TokenSyntax, operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax?
  ) -> OperatorDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .operatorDecl,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = operatorKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = operatorPrecedenceAndTypes?.raw
    }
    return OperatorDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankOperatorDecl(arena: SyntaxArena = .default) -> OperatorDeclSyntax {
    let raw = RawOperatorDeclSyntax.makeBlank(arena: arena).raw
    return OperatorDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIdentifierList(
    arena: SyntaxArena = .default, _ elements: [TokenSyntax]
  ) -> IdentifierListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .identifierList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return IdentifierListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIdentifierList(arena: SyntaxArena = .default) -> IdentifierListSyntax {
    let raw = RawIdentifierListSyntax.makeBlank(arena: arena).raw
    return IdentifierListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeOperatorPrecedenceAndTypes(
    arena: SyntaxArena = .default, colon: TokenSyntax, precedenceGroupAndDesignatedTypes: IdentifierListSyntax
  ) -> OperatorPrecedenceAndTypesSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .operatorPrecedenceAndTypes,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = colon.raw
      buffer[1] = precedenceGroupAndDesignatedTypes.raw
    }
    return OperatorPrecedenceAndTypesSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankOperatorPrecedenceAndTypes(arena: SyntaxArena = .default) -> OperatorPrecedenceAndTypesSyntax {
    let raw = RawOperatorPrecedenceAndTypesSyntax.makeBlank(arena: arena).raw
    return OperatorPrecedenceAndTypesSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrecedenceGroupDecl(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, precedencegroupKeyword: TokenSyntax, identifier: TokenSyntax, leftBrace: TokenSyntax, groupAttributes: PrecedenceGroupAttributeListSyntax, rightBrace: TokenSyntax
  ) -> PrecedenceGroupDeclSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupDecl,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = modifiers?.raw
      buffer[2] = precedencegroupKeyword.raw
      buffer[3] = identifier.raw
      buffer[4] = leftBrace.raw
      buffer[5] = groupAttributes.raw
      buffer[6] = rightBrace.raw
    }
    return PrecedenceGroupDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrecedenceGroupDecl(arena: SyntaxArena = .default) -> PrecedenceGroupDeclSyntax {
    let raw = RawPrecedenceGroupDeclSyntax.makeBlank(arena: arena).raw
    return PrecedenceGroupDeclSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrecedenceGroupAttributeList(
    arena: SyntaxArena = .default, _ elements: [Syntax]
  ) -> PrecedenceGroupAttributeListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupAttributeList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return PrecedenceGroupAttributeListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrecedenceGroupAttributeList(arena: SyntaxArena = .default) -> PrecedenceGroupAttributeListSyntax {
    let raw = RawPrecedenceGroupAttributeListSyntax.makeBlank(arena: arena).raw
    return PrecedenceGroupAttributeListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrecedenceGroupRelation(
    arena: SyntaxArena = .default, higherThanOrLowerThan: TokenSyntax, colon: TokenSyntax, otherNames: PrecedenceGroupNameListSyntax
  ) -> PrecedenceGroupRelationSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupRelation,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = higherThanOrLowerThan.raw
      buffer[1] = colon.raw
      buffer[2] = otherNames.raw
    }
    return PrecedenceGroupRelationSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrecedenceGroupRelation(arena: SyntaxArena = .default) -> PrecedenceGroupRelationSyntax {
    let raw = RawPrecedenceGroupRelationSyntax.makeBlank(arena: arena).raw
    return PrecedenceGroupRelationSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrecedenceGroupNameList(
    arena: SyntaxArena = .default, _ elements: [PrecedenceGroupNameElementSyntax]
  ) -> PrecedenceGroupNameListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupNameList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return PrecedenceGroupNameListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrecedenceGroupNameList(arena: SyntaxArena = .default) -> PrecedenceGroupNameListSyntax {
    let raw = RawPrecedenceGroupNameListSyntax.makeBlank(arena: arena).raw
    return PrecedenceGroupNameListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrecedenceGroupNameElement(
    arena: SyntaxArena = .default, name: TokenSyntax, trailingComma: TokenSyntax?
  ) -> PrecedenceGroupNameElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupNameElement,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = trailingComma?.raw
    }
    return PrecedenceGroupNameElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrecedenceGroupNameElement(arena: SyntaxArena = .default) -> PrecedenceGroupNameElementSyntax {
    let raw = RawPrecedenceGroupNameElementSyntax.makeBlank(arena: arena).raw
    return PrecedenceGroupNameElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrecedenceGroupAssignment(
    arena: SyntaxArena = .default, assignmentKeyword: TokenSyntax, colon: TokenSyntax, flag: TokenSyntax
  ) -> PrecedenceGroupAssignmentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupAssignment,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = assignmentKeyword.raw
      buffer[1] = colon.raw
      buffer[2] = flag.raw
    }
    return PrecedenceGroupAssignmentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrecedenceGroupAssignment(arena: SyntaxArena = .default) -> PrecedenceGroupAssignmentSyntax {
    let raw = RawPrecedenceGroupAssignmentSyntax.makeBlank(arena: arena).raw
    return PrecedenceGroupAssignmentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrecedenceGroupAssociativity(
    arena: SyntaxArena = .default, associativityKeyword: TokenSyntax, colon: TokenSyntax, value: TokenSyntax
  ) -> PrecedenceGroupAssociativitySyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .precedenceGroupAssociativity,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = associativityKeyword.raw
      buffer[1] = colon.raw
      buffer[2] = value.raw
    }
    return PrecedenceGroupAssociativitySyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrecedenceGroupAssociativity(arena: SyntaxArena = .default) -> PrecedenceGroupAssociativitySyntax {
    let raw = RawPrecedenceGroupAssociativitySyntax.makeBlank(arena: arena).raw
    return PrecedenceGroupAssociativitySyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTokenList(
    arena: SyntaxArena = .default, _ elements: [TokenSyntax]
  ) -> TokenListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tokenList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return TokenListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTokenList(arena: SyntaxArena = .default) -> TokenListSyntax {
    let raw = RawTokenListSyntax.makeBlank(arena: arena).raw
    return TokenListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeNonEmptyTokenList(
    arena: SyntaxArena = .default, _ elements: [TokenSyntax]
  ) -> NonEmptyTokenListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .nonEmptyTokenList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return NonEmptyTokenListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankNonEmptyTokenList(arena: SyntaxArena = .default) -> NonEmptyTokenListSyntax {
    let raw = RawNonEmptyTokenListSyntax.makeBlank(arena: arena).raw
    return NonEmptyTokenListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCustomAttribute(
    arena: SyntaxArena = .default, atSignToken: TokenSyntax, attributeName: TypeSyntax, leftParen: TokenSyntax?, argumentList: TupleExprElementListSyntax?, rightParen: TokenSyntax?
  ) -> CustomAttributeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .customAttribute,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = atSignToken.raw
      buffer[1] = attributeName.raw
      buffer[2] = leftParen?.raw
      buffer[3] = argumentList?.raw
      buffer[4] = rightParen?.raw
    }
    return CustomAttributeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCustomAttribute(arena: SyntaxArena = .default) -> CustomAttributeSyntax {
    let raw = RawCustomAttributeSyntax.makeBlank(arena: arena).raw
    return CustomAttributeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAttribute(
    arena: SyntaxArena = .default, atSignToken: TokenSyntax, attributeName: TokenSyntax, leftParen: TokenSyntax?, argument: Syntax?, rightParen: TokenSyntax?, tokenList: TokenListSyntax?
  ) -> AttributeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .attribute,
                                   uninitializedCount: 6) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = atSignToken.raw
      buffer[1] = attributeName.raw
      buffer[2] = leftParen?.raw
      buffer[3] = argument?.raw
      buffer[4] = rightParen?.raw
      buffer[5] = tokenList?.raw
    }
    return AttributeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAttribute(arena: SyntaxArena = .default) -> AttributeSyntax {
    let raw = RawAttributeSyntax.makeBlank(arena: arena).raw
    return AttributeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAttributeList(
    arena: SyntaxArena = .default, _ elements: [Syntax]
  ) -> AttributeListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .attributeList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return AttributeListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAttributeList(arena: SyntaxArena = .default) -> AttributeListSyntax {
    let raw = RawAttributeListSyntax.makeBlank(arena: arena).raw
    return AttributeListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSpecializeAttributeSpecList(
    arena: SyntaxArena = .default, _ elements: [Syntax]
  ) -> SpecializeAttributeSpecListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .specializeAttributeSpecList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return SpecializeAttributeSpecListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSpecializeAttributeSpecList(arena: SyntaxArena = .default) -> SpecializeAttributeSpecListSyntax {
    let raw = RawSpecializeAttributeSpecListSyntax.makeBlank(arena: arena).raw
    return SpecializeAttributeSpecListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAvailabilityEntry(
    arena: SyntaxArena = .default, label: TokenSyntax, colon: TokenSyntax, availabilityList: AvailabilitySpecListSyntax, semicolon: TokenSyntax
  ) -> AvailabilityEntrySyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityEntry,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = label.raw
      buffer[1] = colon.raw
      buffer[2] = availabilityList.raw
      buffer[3] = semicolon.raw
    }
    return AvailabilityEntrySyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAvailabilityEntry(arena: SyntaxArena = .default) -> AvailabilityEntrySyntax {
    let raw = RawAvailabilityEntrySyntax.makeBlank(arena: arena).raw
    return AvailabilityEntrySyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeLabeledSpecializeEntry(
    arena: SyntaxArena = .default, label: TokenSyntax, colon: TokenSyntax, value: TokenSyntax, trailingComma: TokenSyntax?
  ) -> LabeledSpecializeEntrySyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .labeledSpecializeEntry,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = label.raw
      buffer[1] = colon.raw
      buffer[2] = value.raw
      buffer[3] = trailingComma?.raw
    }
    return LabeledSpecializeEntrySyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankLabeledSpecializeEntry(arena: SyntaxArena = .default) -> LabeledSpecializeEntrySyntax {
    let raw = RawLabeledSpecializeEntrySyntax.makeBlank(arena: arena).raw
    return LabeledSpecializeEntrySyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTargetFunctionEntry(
    arena: SyntaxArena = .default, label: TokenSyntax, colon: TokenSyntax, declname: DeclNameSyntax, trailingComma: TokenSyntax?
  ) -> TargetFunctionEntrySyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .targetFunctionEntry,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = label.raw
      buffer[1] = colon.raw
      buffer[2] = declname.raw
      buffer[3] = trailingComma?.raw
    }
    return TargetFunctionEntrySyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTargetFunctionEntry(arena: SyntaxArena = .default) -> TargetFunctionEntrySyntax {
    let raw = RawTargetFunctionEntrySyntax.makeBlank(arena: arena).raw
    return TargetFunctionEntrySyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeNamedAttributeStringArgument(
    arena: SyntaxArena = .default, nameTok: TokenSyntax, colon: TokenSyntax, stringOrDeclname: Syntax
  ) -> NamedAttributeStringArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .namedAttributeStringArgument,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = nameTok.raw
      buffer[1] = colon.raw
      buffer[2] = stringOrDeclname.raw
    }
    return NamedAttributeStringArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankNamedAttributeStringArgument(arena: SyntaxArena = .default) -> NamedAttributeStringArgumentSyntax {
    let raw = RawNamedAttributeStringArgumentSyntax.makeBlank(arena: arena).raw
    return NamedAttributeStringArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeclName(
    arena: SyntaxArena = .default, declBaseName: Syntax, declNameArguments: DeclNameArgumentsSyntax?
  ) -> DeclNameSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declName,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = declBaseName.raw
      buffer[1] = declNameArguments?.raw
    }
    return DeclNameSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeclName(arena: SyntaxArena = .default) -> DeclNameSyntax {
    let raw = RawDeclNameSyntax.makeBlank(arena: arena).raw
    return DeclNameSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeImplementsAttributeArguments(
    arena: SyntaxArena = .default, type: SimpleTypeIdentifierSyntax, comma: TokenSyntax, declBaseName: Syntax, declNameArguments: DeclNameArgumentsSyntax?
  ) -> ImplementsAttributeArgumentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .implementsAttributeArguments,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = type.raw
      buffer[1] = comma.raw
      buffer[2] = declBaseName.raw
      buffer[3] = declNameArguments?.raw
    }
    return ImplementsAttributeArgumentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankImplementsAttributeArguments(arena: SyntaxArena = .default) -> ImplementsAttributeArgumentsSyntax {
    let raw = RawImplementsAttributeArgumentsSyntax.makeBlank(arena: arena).raw
    return ImplementsAttributeArgumentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeObjCSelectorPiece(
    arena: SyntaxArena = .default, name: TokenSyntax?, colon: TokenSyntax?
  ) -> ObjCSelectorPieceSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objCSelectorPiece,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name?.raw
      buffer[1] = colon?.raw
    }
    return ObjCSelectorPieceSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankObjCSelectorPiece(arena: SyntaxArena = .default) -> ObjCSelectorPieceSyntax {
    let raw = RawObjCSelectorPieceSyntax.makeBlank(arena: arena).raw
    return ObjCSelectorPieceSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeObjCSelector(
    arena: SyntaxArena = .default, _ elements: [ObjCSelectorPieceSyntax]
  ) -> ObjCSelectorSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .objCSelector, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return ObjCSelectorSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankObjCSelector(arena: SyntaxArena = .default) -> ObjCSelectorSyntax {
    let raw = RawObjCSelectorSyntax.makeBlank(arena: arena).raw
    return ObjCSelectorSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDifferentiableAttributeArguments(
    arena: SyntaxArena = .default, diffKind: TokenSyntax?, diffKindComma: TokenSyntax?, diffParams: DifferentiabilityParamsClauseSyntax?, diffParamsComma: TokenSyntax?, whereClause: GenericWhereClauseSyntax?
  ) -> DifferentiableAttributeArgumentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiableAttributeArguments,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = diffKind?.raw
      buffer[1] = diffKindComma?.raw
      buffer[2] = diffParams?.raw
      buffer[3] = diffParamsComma?.raw
      buffer[4] = whereClause?.raw
    }
    return DifferentiableAttributeArgumentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDifferentiableAttributeArguments(arena: SyntaxArena = .default) -> DifferentiableAttributeArgumentsSyntax {
    let raw = RawDifferentiableAttributeArgumentsSyntax.makeBlank(arena: arena).raw
    return DifferentiableAttributeArgumentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDifferentiabilityParamsClause(
    arena: SyntaxArena = .default, wrtLabel: TokenSyntax, colon: TokenSyntax, parameters: Syntax
  ) -> DifferentiabilityParamsClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParamsClause,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = wrtLabel.raw
      buffer[1] = colon.raw
      buffer[2] = parameters.raw
    }
    return DifferentiabilityParamsClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDifferentiabilityParamsClause(arena: SyntaxArena = .default) -> DifferentiabilityParamsClauseSyntax {
    let raw = RawDifferentiabilityParamsClauseSyntax.makeBlank(arena: arena).raw
    return DifferentiabilityParamsClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDifferentiabilityParams(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, diffParams: DifferentiabilityParamListSyntax, rightParen: TokenSyntax
  ) -> DifferentiabilityParamsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParams,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = diffParams.raw
      buffer[2] = rightParen.raw
    }
    return DifferentiabilityParamsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDifferentiabilityParams(arena: SyntaxArena = .default) -> DifferentiabilityParamsSyntax {
    let raw = RawDifferentiabilityParamsSyntax.makeBlank(arena: arena).raw
    return DifferentiabilityParamsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDifferentiabilityParamList(
    arena: SyntaxArena = .default, _ elements: [DifferentiabilityParamSyntax]
  ) -> DifferentiabilityParamListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParamList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return DifferentiabilityParamListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDifferentiabilityParamList(arena: SyntaxArena = .default) -> DifferentiabilityParamListSyntax {
    let raw = RawDifferentiabilityParamListSyntax.makeBlank(arena: arena).raw
    return DifferentiabilityParamListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDifferentiabilityParam(
    arena: SyntaxArena = .default, parameter: Syntax, trailingComma: TokenSyntax?
  ) -> DifferentiabilityParamSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .differentiabilityParam,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = parameter.raw
      buffer[1] = trailingComma?.raw
    }
    return DifferentiabilityParamSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDifferentiabilityParam(arena: SyntaxArena = .default) -> DifferentiabilityParamSyntax {
    let raw = RawDifferentiabilityParamSyntax.makeBlank(arena: arena).raw
    return DifferentiabilityParamSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDerivativeRegistrationAttributeArguments(
    arena: SyntaxArena = .default, ofLabel: TokenSyntax, colon: TokenSyntax, originalDeclName: QualifiedDeclNameSyntax, period: TokenSyntax?, accessorKind: TokenSyntax?, comma: TokenSyntax?, diffParams: DifferentiabilityParamsClauseSyntax?
  ) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .derivativeRegistrationAttributeArguments,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = ofLabel.raw
      buffer[1] = colon.raw
      buffer[2] = originalDeclName.raw
      buffer[3] = period?.raw
      buffer[4] = accessorKind?.raw
      buffer[5] = comma?.raw
      buffer[6] = diffParams?.raw
    }
    return DerivativeRegistrationAttributeArgumentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDerivativeRegistrationAttributeArguments(arena: SyntaxArena = .default) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = RawDerivativeRegistrationAttributeArgumentsSyntax.makeBlank(arena: arena).raw
    return DerivativeRegistrationAttributeArgumentsSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeQualifiedDeclName(
    arena: SyntaxArena = .default, baseType: TypeSyntax?, dot: TokenSyntax?, name: TokenSyntax, arguments: DeclNameArgumentsSyntax?
  ) -> QualifiedDeclNameSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .qualifiedDeclName,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = baseType?.raw
      buffer[1] = dot?.raw
      buffer[2] = name.raw
      buffer[3] = arguments?.raw
    }
    return QualifiedDeclNameSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankQualifiedDeclName(arena: SyntaxArena = .default) -> QualifiedDeclNameSyntax {
    let raw = RawQualifiedDeclNameSyntax.makeBlank(arena: arena).raw
    return QualifiedDeclNameSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFunctionDeclName(
    arena: SyntaxArena = .default, name: Syntax, arguments: DeclNameArgumentsSyntax?
  ) -> FunctionDeclNameSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionDeclName,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = arguments?.raw
    }
    return FunctionDeclNameSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFunctionDeclName(arena: SyntaxArena = .default) -> FunctionDeclNameSyntax {
    let raw = RawFunctionDeclNameSyntax.makeBlank(arena: arena).raw
    return FunctionDeclNameSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBackDeployAttributeSpecList(
    arena: SyntaxArena = .default, beforeLabel: TokenSyntax, colon: TokenSyntax, versionList: BackDeployVersionListSyntax
  ) -> BackDeployAttributeSpecListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .backDeployAttributeSpecList,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = beforeLabel.raw
      buffer[1] = colon.raw
      buffer[2] = versionList.raw
    }
    return BackDeployAttributeSpecListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankBackDeployAttributeSpecList(arena: SyntaxArena = .default) -> BackDeployAttributeSpecListSyntax {
    let raw = RawBackDeployAttributeSpecListSyntax.makeBlank(arena: arena).raw
    return BackDeployAttributeSpecListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBackDeployVersionList(
    arena: SyntaxArena = .default, _ elements: [BackDeployVersionArgumentSyntax]
  ) -> BackDeployVersionListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .backDeployVersionList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return BackDeployVersionListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankBackDeployVersionList(arena: SyntaxArena = .default) -> BackDeployVersionListSyntax {
    let raw = RawBackDeployVersionListSyntax.makeBlank(arena: arena).raw
    return BackDeployVersionListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBackDeployVersionArgument(
    arena: SyntaxArena = .default, availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax, trailingComma: TokenSyntax?
  ) -> BackDeployVersionArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .backDeployVersionArgument,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = availabilityVersionRestriction.raw
      buffer[1] = trailingComma?.raw
    }
    return BackDeployVersionArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankBackDeployVersionArgument(arena: SyntaxArena = .default) -> BackDeployVersionArgumentSyntax {
    let raw = RawBackDeployVersionArgumentSyntax.makeBlank(arena: arena).raw
    return BackDeployVersionArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeContinueStmt(
    arena: SyntaxArena = .default, continueKeyword: TokenSyntax, label: TokenSyntax?
  ) -> ContinueStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .continueStmt,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = continueKeyword.raw
      buffer[1] = label?.raw
    }
    return ContinueStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankContinueStmt(arena: SyntaxArena = .default) -> ContinueStmtSyntax {
    let raw = RawContinueStmtSyntax.makeBlank(arena: arena).raw
    return ContinueStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeWhileStmt(
    arena: SyntaxArena = .default, labelName: TokenSyntax?, labelColon: TokenSyntax?, whileKeyword: TokenSyntax, conditions: ConditionElementListSyntax, body: CodeBlockSyntax
  ) -> WhileStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .whileStmt,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = labelName?.raw
      buffer[1] = labelColon?.raw
      buffer[2] = whileKeyword.raw
      buffer[3] = conditions.raw
      buffer[4] = body.raw
    }
    return WhileStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankWhileStmt(arena: SyntaxArena = .default) -> WhileStmtSyntax {
    let raw = RawWhileStmtSyntax.makeBlank(arena: arena).raw
    return WhileStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeferStmt(
    arena: SyntaxArena = .default, deferKeyword: TokenSyntax, body: CodeBlockSyntax
  ) -> DeferStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .deferStmt,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = deferKeyword.raw
      buffer[1] = body.raw
    }
    return DeferStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeferStmt(arena: SyntaxArena = .default) -> DeferStmtSyntax {
    let raw = RawDeferStmtSyntax.makeBlank(arena: arena).raw
    return DeferStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeExpressionStmt(
    arena: SyntaxArena = .default, expression: ExprSyntax
  ) -> ExpressionStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionStmt,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = expression.raw
    }
    return ExpressionStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankExpressionStmt(arena: SyntaxArena = .default) -> ExpressionStmtSyntax {
    let raw = RawExpressionStmtSyntax.makeBlank(arena: arena).raw
    return ExpressionStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSwitchCaseList(
    arena: SyntaxArena = .default, _ elements: [Syntax]
  ) -> SwitchCaseListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchCaseList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return SwitchCaseListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSwitchCaseList(arena: SyntaxArena = .default) -> SwitchCaseListSyntax {
    let raw = RawSwitchCaseListSyntax.makeBlank(arena: arena).raw
    return SwitchCaseListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeRepeatWhileStmt(
    arena: SyntaxArena = .default, labelName: TokenSyntax?, labelColon: TokenSyntax?, repeatKeyword: TokenSyntax, body: CodeBlockSyntax, whileKeyword: TokenSyntax, condition: ExprSyntax
  ) -> RepeatWhileStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .repeatWhileStmt,
                                   uninitializedCount: 6) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = labelName?.raw
      buffer[1] = labelColon?.raw
      buffer[2] = repeatKeyword.raw
      buffer[3] = body.raw
      buffer[4] = whileKeyword.raw
      buffer[5] = condition.raw
    }
    return RepeatWhileStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankRepeatWhileStmt(arena: SyntaxArena = .default) -> RepeatWhileStmtSyntax {
    let raw = RawRepeatWhileStmtSyntax.makeBlank(arena: arena).raw
    return RepeatWhileStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGuardStmt(
    arena: SyntaxArena = .default, guardKeyword: TokenSyntax, conditions: ConditionElementListSyntax, elseKeyword: TokenSyntax, body: CodeBlockSyntax
  ) -> GuardStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .guardStmt,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = guardKeyword.raw
      buffer[1] = conditions.raw
      buffer[2] = elseKeyword.raw
      buffer[3] = body.raw
    }
    return GuardStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGuardStmt(arena: SyntaxArena = .default) -> GuardStmtSyntax {
    let raw = RawGuardStmtSyntax.makeBlank(arena: arena).raw
    return GuardStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeWhereClause(
    arena: SyntaxArena = .default, whereKeyword: TokenSyntax, guardResult: ExprSyntax
  ) -> WhereClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .whereClause,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = whereKeyword.raw
      buffer[1] = guardResult.raw
    }
    return WhereClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankWhereClause(arena: SyntaxArena = .default) -> WhereClauseSyntax {
    let raw = RawWhereClauseSyntax.makeBlank(arena: arena).raw
    return WhereClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeForInStmt(
    arena: SyntaxArena = .default, labelName: TokenSyntax?, labelColon: TokenSyntax?, forKeyword: TokenSyntax, tryKeyword: TokenSyntax?, awaitKeyword: TokenSyntax?, caseKeyword: TokenSyntax?, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, inKeyword: TokenSyntax, sequenceExpr: ExprSyntax, whereClause: WhereClauseSyntax?, body: CodeBlockSyntax
  ) -> ForInStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .forInStmt,
                                   uninitializedCount: 12) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = labelName?.raw
      buffer[1] = labelColon?.raw
      buffer[2] = forKeyword.raw
      buffer[3] = tryKeyword?.raw
      buffer[4] = awaitKeyword?.raw
      buffer[5] = caseKeyword?.raw
      buffer[6] = pattern.raw
      buffer[7] = typeAnnotation?.raw
      buffer[8] = inKeyword.raw
      buffer[9] = sequenceExpr.raw
      buffer[10] = whereClause?.raw
      buffer[11] = body.raw
    }
    return ForInStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankForInStmt(arena: SyntaxArena = .default) -> ForInStmtSyntax {
    let raw = RawForInStmtSyntax.makeBlank(arena: arena).raw
    return ForInStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSwitchStmt(
    arena: SyntaxArena = .default, labelName: TokenSyntax?, labelColon: TokenSyntax?, switchKeyword: TokenSyntax, expression: ExprSyntax, leftBrace: TokenSyntax, cases: SwitchCaseListSyntax, rightBrace: TokenSyntax
  ) -> SwitchStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchStmt,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = labelName?.raw
      buffer[1] = labelColon?.raw
      buffer[2] = switchKeyword.raw
      buffer[3] = expression.raw
      buffer[4] = leftBrace.raw
      buffer[5] = cases.raw
      buffer[6] = rightBrace.raw
    }
    return SwitchStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSwitchStmt(arena: SyntaxArena = .default) -> SwitchStmtSyntax {
    let raw = RawSwitchStmtSyntax.makeBlank(arena: arena).raw
    return SwitchStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCatchClauseList(
    arena: SyntaxArena = .default, _ elements: [CatchClauseSyntax]
  ) -> CatchClauseListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .catchClauseList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return CatchClauseListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCatchClauseList(arena: SyntaxArena = .default) -> CatchClauseListSyntax {
    let raw = RawCatchClauseListSyntax.makeBlank(arena: arena).raw
    return CatchClauseListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDoStmt(
    arena: SyntaxArena = .default, labelName: TokenSyntax?, labelColon: TokenSyntax?, doKeyword: TokenSyntax, body: CodeBlockSyntax, catchClauses: CatchClauseListSyntax?
  ) -> DoStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .doStmt,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = labelName?.raw
      buffer[1] = labelColon?.raw
      buffer[2] = doKeyword.raw
      buffer[3] = body.raw
      buffer[4] = catchClauses?.raw
    }
    return DoStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDoStmt(arena: SyntaxArena = .default) -> DoStmtSyntax {
    let raw = RawDoStmtSyntax.makeBlank(arena: arena).raw
    return DoStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeReturnStmt(
    arena: SyntaxArena = .default, returnKeyword: TokenSyntax, expression: ExprSyntax?
  ) -> ReturnStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .returnStmt,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = returnKeyword.raw
      buffer[1] = expression?.raw
    }
    return ReturnStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankReturnStmt(arena: SyntaxArena = .default) -> ReturnStmtSyntax {
    let raw = RawReturnStmtSyntax.makeBlank(arena: arena).raw
    return ReturnStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeYieldStmt(
    arena: SyntaxArena = .default, yieldKeyword: TokenSyntax, yields: Syntax
  ) -> YieldStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .yieldStmt,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = yieldKeyword.raw
      buffer[1] = yields.raw
    }
    return YieldStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankYieldStmt(arena: SyntaxArena = .default) -> YieldStmtSyntax {
    let raw = RawYieldStmtSyntax.makeBlank(arena: arena).raw
    return YieldStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeYieldList(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, elementList: ExprListSyntax, trailingComma: TokenSyntax?, rightParen: TokenSyntax
  ) -> YieldListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .yieldList,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = elementList.raw
      buffer[2] = trailingComma?.raw
      buffer[3] = rightParen.raw
    }
    return YieldListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankYieldList(arena: SyntaxArena = .default) -> YieldListSyntax {
    let raw = RawYieldListSyntax.makeBlank(arena: arena).raw
    return YieldListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFallthroughStmt(
    arena: SyntaxArena = .default, fallthroughKeyword: TokenSyntax
  ) -> FallthroughStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .fallthroughStmt,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = fallthroughKeyword.raw
    }
    return FallthroughStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFallthroughStmt(arena: SyntaxArena = .default) -> FallthroughStmtSyntax {
    let raw = RawFallthroughStmtSyntax.makeBlank(arena: arena).raw
    return FallthroughStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBreakStmt(
    arena: SyntaxArena = .default, breakKeyword: TokenSyntax, label: TokenSyntax?
  ) -> BreakStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .breakStmt,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = breakKeyword.raw
      buffer[1] = label?.raw
    }
    return BreakStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankBreakStmt(arena: SyntaxArena = .default) -> BreakStmtSyntax {
    let raw = RawBreakStmtSyntax.makeBlank(arena: arena).raw
    return BreakStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCaseItemList(
    arena: SyntaxArena = .default, _ elements: [CaseItemSyntax]
  ) -> CaseItemListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .caseItemList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return CaseItemListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCaseItemList(arena: SyntaxArena = .default) -> CaseItemListSyntax {
    let raw = RawCaseItemListSyntax.makeBlank(arena: arena).raw
    return CaseItemListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCatchItemList(
    arena: SyntaxArena = .default, _ elements: [CatchItemSyntax]
  ) -> CatchItemListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .catchItemList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return CatchItemListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCatchItemList(arena: SyntaxArena = .default) -> CatchItemListSyntax {
    let raw = RawCatchItemListSyntax.makeBlank(arena: arena).raw
    return CatchItemListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeConditionElement(
    arena: SyntaxArena = .default, condition: Syntax, trailingComma: TokenSyntax?
  ) -> ConditionElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .conditionElement,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = condition.raw
      buffer[1] = trailingComma?.raw
    }
    return ConditionElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankConditionElement(arena: SyntaxArena = .default) -> ConditionElementSyntax {
    let raw = RawConditionElementSyntax.makeBlank(arena: arena).raw
    return ConditionElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAvailabilityCondition(
    arena: SyntaxArena = .default, poundAvailableKeyword: TokenSyntax, leftParen: TokenSyntax, availabilitySpec: AvailabilitySpecListSyntax, rightParen: TokenSyntax
  ) -> AvailabilityConditionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityCondition,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundAvailableKeyword.raw
      buffer[1] = leftParen.raw
      buffer[2] = availabilitySpec.raw
      buffer[3] = rightParen.raw
    }
    return AvailabilityConditionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAvailabilityCondition(arena: SyntaxArena = .default) -> AvailabilityConditionSyntax {
    let raw = RawAvailabilityConditionSyntax.makeBlank(arena: arena).raw
    return AvailabilityConditionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMatchingPatternCondition(
    arena: SyntaxArena = .default, caseKeyword: TokenSyntax, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax
  ) -> MatchingPatternConditionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .matchingPatternCondition,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = caseKeyword.raw
      buffer[1] = pattern.raw
      buffer[2] = typeAnnotation?.raw
      buffer[3] = initializer.raw
    }
    return MatchingPatternConditionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMatchingPatternCondition(arena: SyntaxArena = .default) -> MatchingPatternConditionSyntax {
    let raw = RawMatchingPatternConditionSyntax.makeBlank(arena: arena).raw
    return MatchingPatternConditionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeOptionalBindingCondition(
    arena: SyntaxArena = .default, letOrVarKeyword: TokenSyntax, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax?
  ) -> OptionalBindingConditionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalBindingCondition,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = letOrVarKeyword.raw
      buffer[1] = pattern.raw
      buffer[2] = typeAnnotation?.raw
      buffer[3] = initializer?.raw
    }
    return OptionalBindingConditionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankOptionalBindingCondition(arena: SyntaxArena = .default) -> OptionalBindingConditionSyntax {
    let raw = RawOptionalBindingConditionSyntax.makeBlank(arena: arena).raw
    return OptionalBindingConditionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeUnavailabilityCondition(
    arena: SyntaxArena = .default, poundUnavailableKeyword: TokenSyntax, leftParen: TokenSyntax, availabilitySpec: AvailabilitySpecListSyntax, rightParen: TokenSyntax
  ) -> UnavailabilityConditionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .unavailabilityCondition,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundUnavailableKeyword.raw
      buffer[1] = leftParen.raw
      buffer[2] = availabilitySpec.raw
      buffer[3] = rightParen.raw
    }
    return UnavailabilityConditionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankUnavailabilityCondition(arena: SyntaxArena = .default) -> UnavailabilityConditionSyntax {
    let raw = RawUnavailabilityConditionSyntax.makeBlank(arena: arena).raw
    return UnavailabilityConditionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeConditionElementList(
    arena: SyntaxArena = .default, _ elements: [ConditionElementSyntax]
  ) -> ConditionElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .conditionElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return ConditionElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankConditionElementList(arena: SyntaxArena = .default) -> ConditionElementListSyntax {
    let raw = RawConditionElementListSyntax.makeBlank(arena: arena).raw
    return ConditionElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDeclarationStmt(
    arena: SyntaxArena = .default, declaration: DeclSyntax
  ) -> DeclarationStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .declarationStmt,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = declaration.raw
    }
    return DeclarationStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDeclarationStmt(arena: SyntaxArena = .default) -> DeclarationStmtSyntax {
    let raw = RawDeclarationStmtSyntax.makeBlank(arena: arena).raw
    return DeclarationStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeThrowStmt(
    arena: SyntaxArena = .default, throwKeyword: TokenSyntax, expression: ExprSyntax
  ) -> ThrowStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .throwStmt,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = throwKeyword.raw
      buffer[1] = expression.raw
    }
    return ThrowStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankThrowStmt(arena: SyntaxArena = .default) -> ThrowStmtSyntax {
    let raw = RawThrowStmtSyntax.makeBlank(arena: arena).raw
    return ThrowStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIfStmt(
    arena: SyntaxArena = .default, labelName: TokenSyntax?, labelColon: TokenSyntax?, ifKeyword: TokenSyntax, conditions: ConditionElementListSyntax, body: CodeBlockSyntax, elseKeyword: TokenSyntax?, elseBody: Syntax?
  ) -> IfStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .ifStmt,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = labelName?.raw
      buffer[1] = labelColon?.raw
      buffer[2] = ifKeyword.raw
      buffer[3] = conditions.raw
      buffer[4] = body.raw
      buffer[5] = elseKeyword?.raw
      buffer[6] = elseBody?.raw
    }
    return IfStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIfStmt(arena: SyntaxArena = .default) -> IfStmtSyntax {
    let raw = RawIfStmtSyntax.makeBlank(arena: arena).raw
    return IfStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeElseIfContinuation(
    arena: SyntaxArena = .default, ifStatement: IfStmtSyntax
  ) -> ElseIfContinuationSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .elseIfContinuation,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = ifStatement.raw
    }
    return ElseIfContinuationSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankElseIfContinuation(arena: SyntaxArena = .default) -> ElseIfContinuationSyntax {
    let raw = RawElseIfContinuationSyntax.makeBlank(arena: arena).raw
    return ElseIfContinuationSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeElseBlock(
    arena: SyntaxArena = .default, elseKeyword: TokenSyntax, body: CodeBlockSyntax
  ) -> ElseBlockSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .elseBlock,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = elseKeyword.raw
      buffer[1] = body.raw
    }
    return ElseBlockSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankElseBlock(arena: SyntaxArena = .default) -> ElseBlockSyntax {
    let raw = RawElseBlockSyntax.makeBlank(arena: arena).raw
    return ElseBlockSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSwitchCase(
    arena: SyntaxArena = .default, unknownAttr: AttributeSyntax?, label: Syntax, statements: CodeBlockItemListSyntax
  ) -> SwitchCaseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchCase,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = unknownAttr?.raw
      buffer[1] = label.raw
      buffer[2] = statements.raw
    }
    return SwitchCaseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSwitchCase(arena: SyntaxArena = .default) -> SwitchCaseSyntax {
    let raw = RawSwitchCaseSyntax.makeBlank(arena: arena).raw
    return SwitchCaseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSwitchDefaultLabel(
    arena: SyntaxArena = .default, defaultKeyword: TokenSyntax, colon: TokenSyntax
  ) -> SwitchDefaultLabelSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchDefaultLabel,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = defaultKeyword.raw
      buffer[1] = colon.raw
    }
    return SwitchDefaultLabelSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSwitchDefaultLabel(arena: SyntaxArena = .default) -> SwitchDefaultLabelSyntax {
    let raw = RawSwitchDefaultLabelSyntax.makeBlank(arena: arena).raw
    return SwitchDefaultLabelSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCaseItem(
    arena: SyntaxArena = .default, pattern: PatternSyntax, whereClause: WhereClauseSyntax?, trailingComma: TokenSyntax?
  ) -> CaseItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .caseItem,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = pattern.raw
      buffer[1] = whereClause?.raw
      buffer[2] = trailingComma?.raw
    }
    return CaseItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCaseItem(arena: SyntaxArena = .default) -> CaseItemSyntax {
    let raw = RawCaseItemSyntax.makeBlank(arena: arena).raw
    return CaseItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCatchItem(
    arena: SyntaxArena = .default, pattern: PatternSyntax?, whereClause: WhereClauseSyntax?, trailingComma: TokenSyntax?
  ) -> CatchItemSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .catchItem,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = pattern?.raw
      buffer[1] = whereClause?.raw
      buffer[2] = trailingComma?.raw
    }
    return CatchItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCatchItem(arena: SyntaxArena = .default) -> CatchItemSyntax {
    let raw = RawCatchItemSyntax.makeBlank(arena: arena).raw
    return CatchItemSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSwitchCaseLabel(
    arena: SyntaxArena = .default, caseKeyword: TokenSyntax, caseItems: CaseItemListSyntax, colon: TokenSyntax
  ) -> SwitchCaseLabelSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .switchCaseLabel,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = caseKeyword.raw
      buffer[1] = caseItems.raw
      buffer[2] = colon.raw
    }
    return SwitchCaseLabelSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSwitchCaseLabel(arena: SyntaxArena = .default) -> SwitchCaseLabelSyntax {
    let raw = RawSwitchCaseLabelSyntax.makeBlank(arena: arena).raw
    return SwitchCaseLabelSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCatchClause(
    arena: SyntaxArena = .default, catchKeyword: TokenSyntax, catchItems: CatchItemListSyntax?, body: CodeBlockSyntax
  ) -> CatchClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .catchClause,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = catchKeyword.raw
      buffer[1] = catchItems?.raw
      buffer[2] = body.raw
    }
    return CatchClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCatchClause(arena: SyntaxArena = .default) -> CatchClauseSyntax {
    let raw = RawCatchClauseSyntax.makeBlank(arena: arena).raw
    return CatchClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePoundAssertStmt(
    arena: SyntaxArena = .default, poundAssert: TokenSyntax, leftParen: TokenSyntax, condition: ExprSyntax, comma: TokenSyntax?, message: TokenSyntax?, rightParen: TokenSyntax
  ) -> PoundAssertStmtSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .poundAssertStmt,
                                   uninitializedCount: 6) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = poundAssert.raw
      buffer[1] = leftParen.raw
      buffer[2] = condition.raw
      buffer[3] = comma?.raw
      buffer[4] = message?.raw
      buffer[5] = rightParen.raw
    }
    return PoundAssertStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPoundAssertStmt(arena: SyntaxArena = .default) -> PoundAssertStmtSyntax {
    let raw = RawPoundAssertStmtSyntax.makeBlank(arena: arena).raw
    return PoundAssertStmtSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericWhereClause(
    arena: SyntaxArena = .default, whereKeyword: TokenSyntax, requirementList: GenericRequirementListSyntax
  ) -> GenericWhereClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericWhereClause,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = whereKeyword.raw
      buffer[1] = requirementList.raw
    }
    return GenericWhereClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericWhereClause(arena: SyntaxArena = .default) -> GenericWhereClauseSyntax {
    let raw = RawGenericWhereClauseSyntax.makeBlank(arena: arena).raw
    return GenericWhereClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericRequirementList(
    arena: SyntaxArena = .default, _ elements: [GenericRequirementSyntax]
  ) -> GenericRequirementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericRequirementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return GenericRequirementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericRequirementList(arena: SyntaxArena = .default) -> GenericRequirementListSyntax {
    let raw = RawGenericRequirementListSyntax.makeBlank(arena: arena).raw
    return GenericRequirementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericRequirement(
    arena: SyntaxArena = .default, body: Syntax, trailingComma: TokenSyntax?
  ) -> GenericRequirementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericRequirement,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = body.raw
      buffer[1] = trailingComma?.raw
    }
    return GenericRequirementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericRequirement(arena: SyntaxArena = .default) -> GenericRequirementSyntax {
    let raw = RawGenericRequirementSyntax.makeBlank(arena: arena).raw
    return GenericRequirementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSameTypeRequirement(
    arena: SyntaxArena = .default, leftTypeIdentifier: TypeSyntax, equalityToken: TokenSyntax, rightTypeIdentifier: TypeSyntax
  ) -> SameTypeRequirementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .sameTypeRequirement,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftTypeIdentifier.raw
      buffer[1] = equalityToken.raw
      buffer[2] = rightTypeIdentifier.raw
    }
    return SameTypeRequirementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSameTypeRequirement(arena: SyntaxArena = .default) -> SameTypeRequirementSyntax {
    let raw = RawSameTypeRequirementSyntax.makeBlank(arena: arena).raw
    return SameTypeRequirementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericParameterList(
    arena: SyntaxArena = .default, _ elements: [GenericParameterSyntax]
  ) -> GenericParameterListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericParameterList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return GenericParameterListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericParameterList(arena: SyntaxArena = .default) -> GenericParameterListSyntax {
    let raw = RawGenericParameterListSyntax.makeBlank(arena: arena).raw
    return GenericParameterListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericParameter(
    arena: SyntaxArena = .default, attributes: AttributeListSyntax?, name: TokenSyntax, colon: TokenSyntax?, inheritedType: TypeSyntax?, trailingComma: TokenSyntax?
  ) -> GenericParameterSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericParameter,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = attributes?.raw
      buffer[1] = name.raw
      buffer[2] = colon?.raw
      buffer[3] = inheritedType?.raw
      buffer[4] = trailingComma?.raw
    }
    return GenericParameterSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericParameter(arena: SyntaxArena = .default) -> GenericParameterSyntax {
    let raw = RawGenericParameterSyntax.makeBlank(arena: arena).raw
    return GenericParameterSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrimaryAssociatedTypeList(
    arena: SyntaxArena = .default, _ elements: [PrimaryAssociatedTypeSyntax]
  ) -> PrimaryAssociatedTypeListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .primaryAssociatedTypeList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return PrimaryAssociatedTypeListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrimaryAssociatedTypeList(arena: SyntaxArena = .default) -> PrimaryAssociatedTypeListSyntax {
    let raw = RawPrimaryAssociatedTypeListSyntax.makeBlank(arena: arena).raw
    return PrimaryAssociatedTypeListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrimaryAssociatedType(
    arena: SyntaxArena = .default, name: TokenSyntax, trailingComma: TokenSyntax?
  ) -> PrimaryAssociatedTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .primaryAssociatedType,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = trailingComma?.raw
    }
    return PrimaryAssociatedTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrimaryAssociatedType(arena: SyntaxArena = .default) -> PrimaryAssociatedTypeSyntax {
    let raw = RawPrimaryAssociatedTypeSyntax.makeBlank(arena: arena).raw
    return PrimaryAssociatedTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericParameterClause(
    arena: SyntaxArena = .default, leftAngleBracket: TokenSyntax, genericParameterList: GenericParameterListSyntax, rightAngleBracket: TokenSyntax
  ) -> GenericParameterClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericParameterClause,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftAngleBracket.raw
      buffer[1] = genericParameterList.raw
      buffer[2] = rightAngleBracket.raw
    }
    return GenericParameterClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericParameterClause(arena: SyntaxArena = .default) -> GenericParameterClauseSyntax {
    let raw = RawGenericParameterClauseSyntax.makeBlank(arena: arena).raw
    return GenericParameterClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeConformanceRequirement(
    arena: SyntaxArena = .default, leftTypeIdentifier: TypeSyntax, colon: TokenSyntax, rightTypeIdentifier: TypeSyntax
  ) -> ConformanceRequirementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .conformanceRequirement,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftTypeIdentifier.raw
      buffer[1] = colon.raw
      buffer[2] = rightTypeIdentifier.raw
    }
    return ConformanceRequirementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankConformanceRequirement(arena: SyntaxArena = .default) -> ConformanceRequirementSyntax {
    let raw = RawConformanceRequirementSyntax.makeBlank(arena: arena).raw
    return ConformanceRequirementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makePrimaryAssociatedTypeClause(
    arena: SyntaxArena = .default, leftAngleBracket: TokenSyntax, primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax, rightAngleBracket: TokenSyntax
  ) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .primaryAssociatedTypeClause,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftAngleBracket.raw
      buffer[1] = primaryAssociatedTypeList.raw
      buffer[2] = rightAngleBracket.raw
    }
    return PrimaryAssociatedTypeClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankPrimaryAssociatedTypeClause(arena: SyntaxArena = .default) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = RawPrimaryAssociatedTypeClauseSyntax.makeBlank(arena: arena).raw
    return PrimaryAssociatedTypeClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeSimpleTypeIdentifier(
    arena: SyntaxArena = .default, name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?
  ) -> SimpleTypeIdentifierSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .simpleTypeIdentifier,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = name.raw
      buffer[1] = genericArgumentClause?.raw
    }
    return SimpleTypeIdentifierSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankSimpleTypeIdentifier(arena: SyntaxArena = .default) -> SimpleTypeIdentifierSyntax {
    let raw = RawSimpleTypeIdentifierSyntax.makeBlank(arena: arena).raw
    return SimpleTypeIdentifierSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMemberTypeIdentifier(
    arena: SyntaxArena = .default, baseType: TypeSyntax, period: TokenSyntax, name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?
  ) -> MemberTypeIdentifierSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .memberTypeIdentifier,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = baseType.raw
      buffer[1] = period.raw
      buffer[2] = name.raw
      buffer[3] = genericArgumentClause?.raw
    }
    return MemberTypeIdentifierSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMemberTypeIdentifier(arena: SyntaxArena = .default) -> MemberTypeIdentifierSyntax {
    let raw = RawMemberTypeIdentifierSyntax.makeBlank(arena: arena).raw
    return MemberTypeIdentifierSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeClassRestrictionType(
    arena: SyntaxArena = .default, classKeyword: TokenSyntax
  ) -> ClassRestrictionTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .classRestrictionType,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = classKeyword.raw
    }
    return ClassRestrictionTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankClassRestrictionType(arena: SyntaxArena = .default) -> ClassRestrictionTypeSyntax {
    let raw = RawClassRestrictionTypeSyntax.makeBlank(arena: arena).raw
    return ClassRestrictionTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeArrayType(
    arena: SyntaxArena = .default, leftSquareBracket: TokenSyntax, elementType: TypeSyntax, rightSquareBracket: TokenSyntax
  ) -> ArrayTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .arrayType,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftSquareBracket.raw
      buffer[1] = elementType.raw
      buffer[2] = rightSquareBracket.raw
    }
    return ArrayTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankArrayType(arena: SyntaxArena = .default) -> ArrayTypeSyntax {
    let raw = RawArrayTypeSyntax.makeBlank(arena: arena).raw
    return ArrayTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeDictionaryType(
    arena: SyntaxArena = .default, leftSquareBracket: TokenSyntax, keyType: TypeSyntax, colon: TokenSyntax, valueType: TypeSyntax, rightSquareBracket: TokenSyntax
  ) -> DictionaryTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .dictionaryType,
                                   uninitializedCount: 5) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftSquareBracket.raw
      buffer[1] = keyType.raw
      buffer[2] = colon.raw
      buffer[3] = valueType.raw
      buffer[4] = rightSquareBracket.raw
    }
    return DictionaryTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankDictionaryType(arena: SyntaxArena = .default) -> DictionaryTypeSyntax {
    let raw = RawDictionaryTypeSyntax.makeBlank(arena: arena).raw
    return DictionaryTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeMetatypeType(
    arena: SyntaxArena = .default, baseType: TypeSyntax, period: TokenSyntax, typeOrProtocol: TokenSyntax
  ) -> MetatypeTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .metatypeType,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = baseType.raw
      buffer[1] = period.raw
      buffer[2] = typeOrProtocol.raw
    }
    return MetatypeTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankMetatypeType(arena: SyntaxArena = .default) -> MetatypeTypeSyntax {
    let raw = RawMetatypeTypeSyntax.makeBlank(arena: arena).raw
    return MetatypeTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeOptionalType(
    arena: SyntaxArena = .default, wrappedType: TypeSyntax, questionMark: TokenSyntax
  ) -> OptionalTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalType,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = wrappedType.raw
      buffer[1] = questionMark.raw
    }
    return OptionalTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankOptionalType(arena: SyntaxArena = .default) -> OptionalTypeSyntax {
    let raw = RawOptionalTypeSyntax.makeBlank(arena: arena).raw
    return OptionalTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeConstrainedSugarType(
    arena: SyntaxArena = .default, someOrAnySpecifier: TokenSyntax, baseType: TypeSyntax
  ) -> ConstrainedSugarTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .constrainedSugarType,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = someOrAnySpecifier.raw
      buffer[1] = baseType.raw
    }
    return ConstrainedSugarTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankConstrainedSugarType(arena: SyntaxArena = .default) -> ConstrainedSugarTypeSyntax {
    let raw = RawConstrainedSugarTypeSyntax.makeBlank(arena: arena).raw
    return ConstrainedSugarTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeImplicitlyUnwrappedOptionalType(
    arena: SyntaxArena = .default, wrappedType: TypeSyntax, exclamationMark: TokenSyntax
  ) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .implicitlyUnwrappedOptionalType,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = wrappedType.raw
      buffer[1] = exclamationMark.raw
    }
    return ImplicitlyUnwrappedOptionalTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankImplicitlyUnwrappedOptionalType(arena: SyntaxArena = .default) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = RawImplicitlyUnwrappedOptionalTypeSyntax.makeBlank(arena: arena).raw
    return ImplicitlyUnwrappedOptionalTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCompositionTypeElement(
    arena: SyntaxArena = .default, type: TypeSyntax, ampersand: TokenSyntax?
  ) -> CompositionTypeElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .compositionTypeElement,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = type.raw
      buffer[1] = ampersand?.raw
    }
    return CompositionTypeElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCompositionTypeElement(arena: SyntaxArena = .default) -> CompositionTypeElementSyntax {
    let raw = RawCompositionTypeElementSyntax.makeBlank(arena: arena).raw
    return CompositionTypeElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCompositionTypeElementList(
    arena: SyntaxArena = .default, _ elements: [CompositionTypeElementSyntax]
  ) -> CompositionTypeElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .compositionTypeElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return CompositionTypeElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCompositionTypeElementList(arena: SyntaxArena = .default) -> CompositionTypeElementListSyntax {
    let raw = RawCompositionTypeElementListSyntax.makeBlank(arena: arena).raw
    return CompositionTypeElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeCompositionType(
    arena: SyntaxArena = .default, elements: CompositionTypeElementListSyntax
  ) -> CompositionTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .compositionType,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = elements.raw
    }
    return CompositionTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankCompositionType(arena: SyntaxArena = .default) -> CompositionTypeSyntax {
    let raw = RawCompositionTypeSyntax.makeBlank(arena: arena).raw
    return CompositionTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTupleTypeElement(
    arena: SyntaxArena = .default, inOut: TokenSyntax?, name: TokenSyntax?, secondName: TokenSyntax?, colon: TokenSyntax?, type: TypeSyntax, ellipsis: TokenSyntax?, initializer: InitializerClauseSyntax?, trailingComma: TokenSyntax?
  ) -> TupleTypeElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleTypeElement,
                                   uninitializedCount: 8) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = inOut?.raw
      buffer[1] = name?.raw
      buffer[2] = secondName?.raw
      buffer[3] = colon?.raw
      buffer[4] = type.raw
      buffer[5] = ellipsis?.raw
      buffer[6] = initializer?.raw
      buffer[7] = trailingComma?.raw
    }
    return TupleTypeElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTupleTypeElement(arena: SyntaxArena = .default) -> TupleTypeElementSyntax {
    let raw = RawTupleTypeElementSyntax.makeBlank(arena: arena).raw
    return TupleTypeElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTupleTypeElementList(
    arena: SyntaxArena = .default, _ elements: [TupleTypeElementSyntax]
  ) -> TupleTypeElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleTypeElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return TupleTypeElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTupleTypeElementList(arena: SyntaxArena = .default) -> TupleTypeElementListSyntax {
    let raw = RawTupleTypeElementListSyntax.makeBlank(arena: arena).raw
    return TupleTypeElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTupleType(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, elements: TupleTypeElementListSyntax, rightParen: TokenSyntax
  ) -> TupleTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tupleType,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = elements.raw
      buffer[2] = rightParen.raw
    }
    return TupleTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTupleType(arena: SyntaxArena = .default) -> TupleTypeSyntax {
    let raw = RawTupleTypeSyntax.makeBlank(arena: arena).raw
    return TupleTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeFunctionType(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, arguments: TupleTypeElementListSyntax, rightParen: TokenSyntax, asyncKeyword: TokenSyntax?, throwsOrRethrowsKeyword: TokenSyntax?, arrow: TokenSyntax, returnType: TypeSyntax
  ) -> FunctionTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .functionType,
                                   uninitializedCount: 7) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = arguments.raw
      buffer[2] = rightParen.raw
      buffer[3] = asyncKeyword?.raw
      buffer[4] = throwsOrRethrowsKeyword?.raw
      buffer[5] = arrow.raw
      buffer[6] = returnType.raw
    }
    return FunctionTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankFunctionType(arena: SyntaxArena = .default) -> FunctionTypeSyntax {
    let raw = RawFunctionTypeSyntax.makeBlank(arena: arena).raw
    return FunctionTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAttributedType(
    arena: SyntaxArena = .default, specifier: TokenSyntax?, attributes: AttributeListSyntax?, baseType: TypeSyntax
  ) -> AttributedTypeSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .attributedType,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = specifier?.raw
      buffer[1] = attributes?.raw
      buffer[2] = baseType.raw
    }
    return AttributedTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAttributedType(arena: SyntaxArena = .default) -> AttributedTypeSyntax {
    let raw = RawAttributedTypeSyntax.makeBlank(arena: arena).raw
    return AttributedTypeSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericArgumentList(
    arena: SyntaxArena = .default, _ elements: [GenericArgumentSyntax]
  ) -> GenericArgumentListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericArgumentList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return GenericArgumentListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericArgumentList(arena: SyntaxArena = .default) -> GenericArgumentListSyntax {
    let raw = RawGenericArgumentListSyntax.makeBlank(arena: arena).raw
    return GenericArgumentListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericArgument(
    arena: SyntaxArena = .default, argumentType: TypeSyntax, trailingComma: TokenSyntax?
  ) -> GenericArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericArgument,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = argumentType.raw
      buffer[1] = trailingComma?.raw
    }
    return GenericArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericArgument(arena: SyntaxArena = .default) -> GenericArgumentSyntax {
    let raw = RawGenericArgumentSyntax.makeBlank(arena: arena).raw
    return GenericArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeGenericArgumentClause(
    arena: SyntaxArena = .default, leftAngleBracket: TokenSyntax, arguments: GenericArgumentListSyntax, rightAngleBracket: TokenSyntax
  ) -> GenericArgumentClauseSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .genericArgumentClause,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftAngleBracket.raw
      buffer[1] = arguments.raw
      buffer[2] = rightAngleBracket.raw
    }
    return GenericArgumentClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankGenericArgumentClause(arena: SyntaxArena = .default) -> GenericArgumentClauseSyntax {
    let raw = RawGenericArgumentClauseSyntax.makeBlank(arena: arena).raw
    return GenericArgumentClauseSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTypeAnnotation(
    arena: SyntaxArena = .default, colon: TokenSyntax, type: TypeSyntax
  ) -> TypeAnnotationSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .typeAnnotation,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = colon.raw
      buffer[1] = type.raw
    }
    return TypeAnnotationSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTypeAnnotation(arena: SyntaxArena = .default) -> TypeAnnotationSyntax {
    let raw = RawTypeAnnotationSyntax.makeBlank(arena: arena).raw
    return TypeAnnotationSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeEnumCasePattern(
    arena: SyntaxArena = .default, type: TypeSyntax?, period: TokenSyntax, caseName: TokenSyntax, associatedTuple: TuplePatternSyntax?
  ) -> EnumCasePatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .enumCasePattern,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = type?.raw
      buffer[1] = period.raw
      buffer[2] = caseName.raw
      buffer[3] = associatedTuple?.raw
    }
    return EnumCasePatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankEnumCasePattern(arena: SyntaxArena = .default) -> EnumCasePatternSyntax {
    let raw = RawEnumCasePatternSyntax.makeBlank(arena: arena).raw
    return EnumCasePatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIsTypePattern(
    arena: SyntaxArena = .default, isKeyword: TokenSyntax, type: TypeSyntax
  ) -> IsTypePatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .isTypePattern,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = isKeyword.raw
      buffer[1] = type.raw
    }
    return IsTypePatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIsTypePattern(arena: SyntaxArena = .default) -> IsTypePatternSyntax {
    let raw = RawIsTypePatternSyntax.makeBlank(arena: arena).raw
    return IsTypePatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeOptionalPattern(
    arena: SyntaxArena = .default, subPattern: PatternSyntax, questionMark: TokenSyntax
  ) -> OptionalPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .optionalPattern,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = subPattern.raw
      buffer[1] = questionMark.raw
    }
    return OptionalPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankOptionalPattern(arena: SyntaxArena = .default) -> OptionalPatternSyntax {
    let raw = RawOptionalPatternSyntax.makeBlank(arena: arena).raw
    return OptionalPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeIdentifierPattern(
    arena: SyntaxArena = .default, identifier: TokenSyntax
  ) -> IdentifierPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .identifierPattern,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = identifier.raw
    }
    return IdentifierPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankIdentifierPattern(arena: SyntaxArena = .default) -> IdentifierPatternSyntax {
    let raw = RawIdentifierPatternSyntax.makeBlank(arena: arena).raw
    return IdentifierPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAsTypePattern(
    arena: SyntaxArena = .default, pattern: PatternSyntax, asKeyword: TokenSyntax, type: TypeSyntax
  ) -> AsTypePatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .asTypePattern,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = pattern.raw
      buffer[1] = asKeyword.raw
      buffer[2] = type.raw
    }
    return AsTypePatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAsTypePattern(arena: SyntaxArena = .default) -> AsTypePatternSyntax {
    let raw = RawAsTypePatternSyntax.makeBlank(arena: arena).raw
    return AsTypePatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTuplePattern(
    arena: SyntaxArena = .default, leftParen: TokenSyntax, elements: TuplePatternElementListSyntax, rightParen: TokenSyntax
  ) -> TuplePatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tuplePattern,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = leftParen.raw
      buffer[1] = elements.raw
      buffer[2] = rightParen.raw
    }
    return TuplePatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTuplePattern(arena: SyntaxArena = .default) -> TuplePatternSyntax {
    let raw = RawTuplePatternSyntax.makeBlank(arena: arena).raw
    return TuplePatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeWildcardPattern(
    arena: SyntaxArena = .default, wildcard: TokenSyntax, typeAnnotation: TypeAnnotationSyntax?
  ) -> WildcardPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .wildcardPattern,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = wildcard.raw
      buffer[1] = typeAnnotation?.raw
    }
    return WildcardPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankWildcardPattern(arena: SyntaxArena = .default) -> WildcardPatternSyntax {
    let raw = RawWildcardPatternSyntax.makeBlank(arena: arena).raw
    return WildcardPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTuplePatternElement(
    arena: SyntaxArena = .default, labelName: TokenSyntax?, labelColon: TokenSyntax?, pattern: PatternSyntax, trailingComma: TokenSyntax?
  ) -> TuplePatternElementSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tuplePatternElement,
                                   uninitializedCount: 4) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = labelName?.raw
      buffer[1] = labelColon?.raw
      buffer[2] = pattern.raw
      buffer[3] = trailingComma?.raw
    }
    return TuplePatternElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTuplePatternElement(arena: SyntaxArena = .default) -> TuplePatternElementSyntax {
    let raw = RawTuplePatternElementSyntax.makeBlank(arena: arena).raw
    return TuplePatternElementSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeExpressionPattern(
    arena: SyntaxArena = .default, expression: ExprSyntax
  ) -> ExpressionPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .expressionPattern,
                                   uninitializedCount: 1) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = expression.raw
    }
    return ExpressionPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankExpressionPattern(arena: SyntaxArena = .default) -> ExpressionPatternSyntax {
    let raw = RawExpressionPatternSyntax.makeBlank(arena: arena).raw
    return ExpressionPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeTuplePatternElementList(
    arena: SyntaxArena = .default, _ elements: [TuplePatternElementSyntax]
  ) -> TuplePatternElementListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .tuplePatternElementList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return TuplePatternElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankTuplePatternElementList(arena: SyntaxArena = .default) -> TuplePatternElementListSyntax {
    let raw = RawTuplePatternElementListSyntax.makeBlank(arena: arena).raw
    return TuplePatternElementListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeValueBindingPattern(
    arena: SyntaxArena = .default, letOrVarKeyword: TokenSyntax, valuePattern: PatternSyntax
  ) -> ValueBindingPatternSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .valueBindingPattern,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = letOrVarKeyword.raw
      buffer[1] = valuePattern.raw
    }
    return ValueBindingPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankValueBindingPattern(arena: SyntaxArena = .default) -> ValueBindingPatternSyntax {
    let raw = RawValueBindingPatternSyntax.makeBlank(arena: arena).raw
    return ValueBindingPatternSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAvailabilitySpecList(
    arena: SyntaxArena = .default, _ elements: [AvailabilityArgumentSyntax]
  ) -> AvailabilitySpecListSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilitySpecList, uninitializedCount: elements.count) { buffer in
      _ = buffer.initialize(from: elements.map { $0.raw })
    }
    return AvailabilitySpecListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAvailabilitySpecList(arena: SyntaxArena = .default) -> AvailabilitySpecListSyntax {
    let raw = RawAvailabilitySpecListSyntax.makeBlank(arena: arena).raw
    return AvailabilitySpecListSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAvailabilityArgument(
    arena: SyntaxArena = .default, entry: Syntax, trailingComma: TokenSyntax?
  ) -> AvailabilityArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityArgument,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = entry.raw
      buffer[1] = trailingComma?.raw
    }
    return AvailabilityArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAvailabilityArgument(arena: SyntaxArena = .default) -> AvailabilityArgumentSyntax {
    let raw = RawAvailabilityArgumentSyntax.makeBlank(arena: arena).raw
    return AvailabilityArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAvailabilityLabeledArgument(
    arena: SyntaxArena = .default, label: TokenSyntax, colon: TokenSyntax, value: Syntax
  ) -> AvailabilityLabeledArgumentSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityLabeledArgument,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = label.raw
      buffer[1] = colon.raw
      buffer[2] = value.raw
    }
    return AvailabilityLabeledArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAvailabilityLabeledArgument(arena: SyntaxArena = .default) -> AvailabilityLabeledArgumentSyntax {
    let raw = RawAvailabilityLabeledArgumentSyntax.makeBlank(arena: arena).raw
    return AvailabilityLabeledArgumentSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeAvailabilityVersionRestriction(
    arena: SyntaxArena = .default, platform: TokenSyntax, version: VersionTupleSyntax?
  ) -> AvailabilityVersionRestrictionSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .availabilityVersionRestriction,
                                   uninitializedCount: 2) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = platform.raw
      buffer[1] = version?.raw
    }
    return AvailabilityVersionRestrictionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankAvailabilityVersionRestriction(arena: SyntaxArena = .default) -> AvailabilityVersionRestrictionSyntax {
    let raw = RawAvailabilityVersionRestrictionSyntax.makeBlank(arena: arena).raw
    return AvailabilityVersionRestrictionSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeVersionTuple(
    arena: SyntaxArena = .default, majorMinor: Syntax, patchPeriod: TokenSyntax?, patchVersion: TokenSyntax?
  ) -> VersionTupleSyntax {
    let raw = RawSyntax.makeLayout(arena: arena, kind: .versionTuple,
                                   uninitializedCount: 3) { buffer in
      buffer.initialize(repeating: nil)
      buffer[0] = majorMinor.raw
      buffer[1] = patchPeriod?.raw
      buffer[2] = patchVersion?.raw
    }
    return VersionTupleSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }

  public static func makeBlankVersionTuple(arena: SyntaxArena = .default) -> VersionTupleSyntax {
    let raw = RawVersionTupleSyntax.makeBlank(arena: arena).raw
    return VersionTupleSyntax(data: SyntaxData(rootRaw: raw, arena: arena))
  }
}

/// MARK: Token Creation APIs

extension SyntaxFactory {

  public static func makeAssociatedtypeKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .associatedtypeKeyword, tokenText: "associatedtype",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeClassKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .classKeyword, tokenText: "class",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeDeinitKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .deinitKeyword, tokenText: "deinit",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeEnumKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .enumKeyword, tokenText: "enum",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeExtensionKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .extensionKeyword, tokenText: "extension",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeFuncKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .funcKeyword, tokenText: "func",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeImportKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .importKeyword, tokenText: "import",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeInitKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .initKeyword, tokenText: "init",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeInoutKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .inoutKeyword, tokenText: "inout",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeLetKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .letKeyword, tokenText: "let",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeOperatorKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .operatorKeyword, tokenText: "operator",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePrecedencegroupKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .precedencegroupKeyword, tokenText: "precedencegroup",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeProtocolKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .protocolKeyword, tokenText: "protocol",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeStructKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .structKeyword, tokenText: "struct",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeSubscriptKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .subscriptKeyword, tokenText: "subscript",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeTypealiasKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .typealiasKeyword, tokenText: "typealias",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeVarKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .varKeyword, tokenText: "var",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeFileprivateKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .fileprivateKeyword, tokenText: "fileprivate",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeInternalKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .internalKeyword, tokenText: "internal",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePrivateKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .privateKeyword, tokenText: "private",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePublicKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .publicKeyword, tokenText: "public",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeStaticKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .staticKeyword, tokenText: "static",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeDeferKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .deferKeyword, tokenText: "defer",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeIfKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .ifKeyword, tokenText: "if",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeGuardKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .guardKeyword, tokenText: "guard",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeDoKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .doKeyword, tokenText: "do",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeRepeatKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .repeatKeyword, tokenText: "repeat",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeElseKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .elseKeyword, tokenText: "else",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeForKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .forKeyword, tokenText: "for",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeInKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .inKeyword, tokenText: "in",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeWhileKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .whileKeyword, tokenText: "while",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeReturnKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .returnKeyword, tokenText: "return",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeBreakKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .breakKeyword, tokenText: "break",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeContinueKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .continueKeyword, tokenText: "continue",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeFallthroughKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .fallthroughKeyword, tokenText: "fallthrough",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeSwitchKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .switchKeyword, tokenText: "switch",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeCaseKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .caseKeyword, tokenText: "case",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeDefaultKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .defaultKeyword, tokenText: "default",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeWhereKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .whereKeyword, tokenText: "where",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeCatchKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .catchKeyword, tokenText: "catch",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeThrowKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .throwKeyword, tokenText: "throw",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeAsKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .asKeyword, tokenText: "as",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeAnyKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .anyKeyword, tokenText: "Any",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeFalseKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .falseKeyword, tokenText: "false",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeIsKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .isKeyword, tokenText: "is",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeNilKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .nilKeyword, tokenText: "nil",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeRethrowsKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .rethrowsKeyword, tokenText: "rethrows",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeSuperKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .superKeyword, tokenText: "super",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeSelfKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .selfKeyword, tokenText: "self",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeCapitalSelfKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .capitalSelfKeyword, tokenText: "Self",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeTrueKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .trueKeyword, tokenText: "true",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeTryKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .tryKeyword, tokenText: "try",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeThrowsKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .throwsKeyword, tokenText: "throws",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func make__FILE__Keyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .__file__Keyword, tokenText: "__FILE__",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func make__LINE__Keyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .__line__Keyword, tokenText: "__LINE__",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func make__COLUMN__Keyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .__column__Keyword, tokenText: "__COLUMN__",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func make__FUNCTION__Keyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .__function__Keyword, tokenText: "__FUNCTION__",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func make__DSO_HANDLE__Keyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .__dso_handle__Keyword, tokenText: "__DSO_HANDLE__",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeWildcardKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .wildcardKeyword, tokenText: "_",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeLeftParenToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .leftParen, tokenText: "(",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeRightParenToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .rightParen, tokenText: ")",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeLeftBraceToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [.spaces(1)],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .leftBrace, tokenText: "{",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeRightBraceToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .rightBrace, tokenText: "}",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeLeftSquareBracketToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .leftSquareBracket, tokenText: "[",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeRightSquareBracketToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .rightSquareBracket, tokenText: "]",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeLeftAngleToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [.spaces(1)],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .leftAngle, tokenText: "<",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeRightAngleToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [.spaces(1)],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .rightAngle, tokenText: ">",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePeriodToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .period, tokenText: ".",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePrefixPeriodToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .prefixPeriod, tokenText: ".",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeCommaToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .comma, tokenText: ",",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeEllipsisToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .ellipsis, tokenText: "...",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeColonToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .colon, tokenText: ":",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeSemicolonToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .semicolon, tokenText: ";",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeEqualToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [.spaces(1)],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .equal, tokenText: "=",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeAtSignToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .atSign, tokenText: "@",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .pound, tokenText: "#",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePrefixAmpersandToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [.spaces(1)],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .prefixAmpersand, tokenText: "&",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeArrowToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [.spaces(1)],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .arrow, tokenText: "->",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeBacktickToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .backtick, tokenText: "`",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeBackslashToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .backslash, tokenText: "\\",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeExclamationMarkToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .exclamationMark, tokenText: "!",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePostfixQuestionMarkToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .postfixQuestionMark, tokenText: "?",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeInfixQuestionMarkToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .infixQuestionMark, tokenText: "?",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeStringQuoteToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .stringQuote, tokenText: "\"",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeSingleQuoteToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .singleQuote, tokenText: "\'",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeMultilineStringQuoteToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .multilineStringQuote, tokenText: "\"\"\"",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundKeyPathKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundKeyPathKeyword, tokenText: "#keyPath",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundLineKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundLineKeyword, tokenText: "#line",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundSelectorKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundSelectorKeyword, tokenText: "#selector",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundFileKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundFileKeyword, tokenText: "#file",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundFileIDKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundFileIDKeyword, tokenText: "#fileID",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundFilePathKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundFilePathKeyword, tokenText: "#filePath",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundColumnKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundColumnKeyword, tokenText: "#column",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundFunctionKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundFunctionKeyword, tokenText: "#function",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundDsohandleKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundDsohandleKeyword, tokenText: "#dsohandle",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundAssertKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundAssertKeyword, tokenText: "#assert",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundSourceLocationKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundSourceLocationKeyword, tokenText: "#sourceLocation",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundWarningKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundWarningKeyword, tokenText: "#warning",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundErrorKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundErrorKeyword, tokenText: "#error",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundIfKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundIfKeyword, tokenText: "#if",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundElseKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundElseKeyword, tokenText: "#else",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundElseifKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundElseifKeyword, tokenText: "#elseif",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundEndifKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundEndifKeyword, tokenText: "#endif",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundAvailableKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundAvailableKeyword, tokenText: "#available",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundUnavailableKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundUnavailableKeyword, tokenText: "#unavailable",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundFileLiteralKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundFileLiteralKeyword, tokenText: "#fileLiteral",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundImageLiteralKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundImageLiteralKeyword, tokenText: "#imageLiteral",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePoundColorLiteralKeyword(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .poundColorLiteralKeyword, tokenText: "#colorLiteral",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeIntegerLiteral(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .integerLiteral, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeFloatingLiteral(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .floatingLiteral, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeStringLiteral(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .stringLiteral, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeRegexLiteral(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .regexLiteral, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeUnknown(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .unknown, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeIdentifier(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .identifier, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeUnspacedBinaryOperator(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .unspacedBinaryOperator, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeSpacedBinaryOperator(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [.spaces(1)],
    trailingTrivia: Trivia = [.spaces(1)]
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .spacedBinaryOperator, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePostfixOperator(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .postfixOperator, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makePrefixOperator(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .prefixOperator, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeDollarIdentifier(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .dollarIdentifier, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeContextualKeyword(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .contextualKeyword, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeRawStringDelimiter(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .rawStringDelimiter, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeStringSegment(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .stringSegment, tokenText: text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeStringInterpolationAnchorToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .stringInterpolationAnchor, tokenText: ")",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
  public static func makeYieldToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena, .yield, tokenText: "yield",
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
  }
}


/// MARK: Convenience APIs

extension SyntaxFactory {

  public static func makeVoidTupleType(arena: SyntaxArena = .default) -> TupleTypeSyntax {
    return makeTupleType(
      arena: arena,
      leftParen: makeLeftParenToken(arena: arena),
      elements: makeBlankTupleTypeElementList(arena: arena),
      rightParen: makeRightParenToken(arena: arena))
  }

  public static func makeTupleTypeElement(
    arena: SyntaxArena = .default,
    name: TokenSyntax?,
    colon: TokenSyntax?,
    type: TypeSyntax,
    trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
    return makeTupleTypeElement(
      arena: arena, inOut: nil, name: name, secondName: nil, colon: colon,
      type: type, ellipsis: nil, initializer: nil, trailingComma: trailingComma)
  }

  public static func makeTupleTypeElement(
    arena: SyntaxArena = .default,
    type: TypeSyntax,
    trailingComma: TokenSyntax?
  ) -> TupleTypeElementSyntax  {
    return makeTupleTypeElement(
    arena: arena, name: nil, colon: nil, type: type, trailingComma: trailingComma)
  }

  public static func makeGenericParameter(
    arena: SyntaxArena = .default,
    name: TokenSyntax,
    trailingComma: TokenSyntax
  ) -> GenericParameterSyntax {
    return makeGenericParameter(
      arena: arena, attributes: nil, name: name, colon: nil,
      inheritedType: nil, trailingComma: trailingComma)
  }

  public static func makeTypeIdentifier(
    arena: SyntaxArena = .default,
    _ name: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TypeSyntax {
    let identifier = makeIdentifier(
      arena: arena,
      name,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
    let typeIdentifier = makeSimpleTypeIdentifier(arena: arena,
                                                  name: identifier,
                                                  genericArgumentClause: nil)
    return TypeSyntax(typeIdentifier)
  }

  public static func makeAnyTypeIdentifier(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TypeSyntax {
    return makeTypeIdentifier(
      arena: arena,
      "Any",
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
  }

  public static func makeSelfTypeIdentifier(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TypeSyntax {
    return makeTypeIdentifier(
      arena: arena,
      "Self",
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
  }

  public static func makeTypeToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeIdentifier(
      arena: arena,
      "Type",
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
  }

  public static func makeProtocolToken(
    arena: SyntaxArena = .default,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeIdentifier(
      arena: arena,
      "Protocol",
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
  }

  public static func makeBinaryOperator(
    arena: SyntaxArena = .default,
    _ name: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> TokenSyntax {
    return makeToken(
      arena: arena,
      .spacedBinaryOperator,
      tokenText: name,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
  }

  public static func makeStringLiteralExpr(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> StringLiteralExprSyntax {
    let string = makeStringSegment(arena: arena, text)
    let segment = makeStringSegment(arena: arena, content: string)
    let segments = makeStringLiteralSegments(arena: arena, [Syntax(segment)])
    let openQuote = makeStringQuoteToken(arena: arena, leadingTrivia: leadingTrivia)
    let closeQuote = makeStringQuoteToken(arena: arena, trailingTrivia: trailingTrivia)
    return makeStringLiteralExpr(arena: arena, openDelimiter: nil,
                                 openQuote: openQuote,
                                 segments: segments,
                                 closeQuote: closeQuote,
                                 closeDelimiter: nil)
  }

  public static func makeVariableExpr(
    arena: SyntaxArena = .default,
    _ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []
  ) -> IdentifierExprSyntax {
    let string = makeIdentifier(arena: arena, text,
      leadingTrivia: leadingTrivia,
      trailingTrivia: trailingTrivia)
    return makeIdentifierExpr(arena: arena, identifier: string,
                              declNameArguments: nil)
  }
}
