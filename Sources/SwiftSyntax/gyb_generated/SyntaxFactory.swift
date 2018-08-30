// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 6)
//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===------- SyntaxFactory.swift - Syntax Factory implementations ---------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
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
    let data = SyntaxData(raw: .token(kind, leadingTrivia,
                                      trailingTrivia, presence))
    return TokenSyntax(root: data, data: data)
  }

  public static func makeUnknownSyntax(tokens: [TokenSyntax]) -> Syntax {
    let data = SyntaxData(raw: .node(.unknown, 
                                     tokens.map { $0.data.raw },
                                     .present))
    return UnknownSyntax(root: data, data: data)
  }

/// MARK: Syntax Node Creation APIs

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankUnknownDecl() -> UnknownDeclSyntax {
    let data = SyntaxData(raw: .node(.unknownDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return UnknownDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankUnknownExpr() -> UnknownExprSyntax {
    let data = SyntaxData(raw: .node(.unknownExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return UnknownExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankUnknownStmt() -> UnknownStmtSyntax {
    let data = SyntaxData(raw: .node(.unknownStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return UnknownStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankUnknownType() -> UnknownTypeSyntax {
    let data = SyntaxData(raw: .node(.unknownType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return UnknownTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankUnknownPattern() -> UnknownPatternSyntax {
    let data = SyntaxData(raw: .node(.unknownPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return UnknownPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeCodeBlockItem(item: Syntax, semicolon: TokenSyntax?, errorTokens: Syntax?) -> CodeBlockItemSyntax {
    let data = SyntaxData(raw: .node(.codeBlockItem, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      item.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      semicolon?.data.raw ?? RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      errorTokens?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return CodeBlockItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCodeBlockItem() -> CodeBlockItemSyntax {
    let data = SyntaxData(raw: .node(.codeBlockItem, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CodeBlockItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeCodeBlockItemList(
    _ elements: [CodeBlockItemSyntax]) -> CodeBlockItemListSyntax {
    let data = SyntaxData(raw: .node(.codeBlockItemList,
                                     elements.map { $0.data.raw }, .present))
    return CodeBlockItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCodeBlockItemList() -> CodeBlockItemListSyntax {
    let data = SyntaxData(raw: .node(.codeBlockItemList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CodeBlockItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeCodeBlock(leftBrace: TokenSyntax, statements: CodeBlockItemListSyntax, rightBrace: TokenSyntax) -> CodeBlockSyntax {
    let data = SyntaxData(raw: .node(.codeBlock, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      statements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return CodeBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCodeBlock() -> CodeBlockSyntax {
    let data = SyntaxData(raw: .node(.codeBlock, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CodeBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeInOutExpr(ampersand: TokenSyntax, expression: ExprSyntax) -> InOutExprSyntax {
    let data = SyntaxData(raw: .node(.inOutExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      ampersand.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return InOutExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankInOutExpr() -> InOutExprSyntax {
    let data = SyntaxData(raw: .node(.inOutExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.prefixAmpersand),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return InOutExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundColumnExpr(poundColumn: TokenSyntax) -> PoundColumnExprSyntax {
    let data = SyntaxData(raw: .node(.poundColumnExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundColumn.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundColumnExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundColumnExpr() -> PoundColumnExprSyntax {
    let data = SyntaxData(raw: .node(.poundColumnExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundColumnKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundColumnExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeFunctionCallArgumentList(
    _ elements: [FunctionCallArgumentSyntax]) -> FunctionCallArgumentListSyntax {
    let data = SyntaxData(raw: .node(.functionCallArgumentList,
                                     elements.map { $0.data.raw }, .present))
    return FunctionCallArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFunctionCallArgumentList() -> FunctionCallArgumentListSyntax {
    let data = SyntaxData(raw: .node(.functionCallArgumentList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FunctionCallArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeTupleElementList(
    _ elements: [TupleElementSyntax]) -> TupleElementListSyntax {
    let data = SyntaxData(raw: .node(.tupleElementList,
                                     elements.map { $0.data.raw }, .present))
    return TupleElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTupleElementList() -> TupleElementListSyntax {
    let data = SyntaxData(raw: .node(.tupleElementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TupleElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeArrayElementList(
    _ elements: [ArrayElementSyntax]) -> ArrayElementListSyntax {
    let data = SyntaxData(raw: .node(.arrayElementList,
                                     elements.map { $0.data.raw }, .present))
    return ArrayElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankArrayElementList() -> ArrayElementListSyntax {
    let data = SyntaxData(raw: .node(.arrayElementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ArrayElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeDictionaryElementList(
    _ elements: [DictionaryElementSyntax]) -> DictionaryElementListSyntax {
    let data = SyntaxData(raw: .node(.dictionaryElementList,
                                     elements.map { $0.data.raw }, .present))
    return DictionaryElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDictionaryElementList() -> DictionaryElementListSyntax {
    let data = SyntaxData(raw: .node(.dictionaryElementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DictionaryElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeStringInterpolationSegments(
    _ elements: [Syntax]) -> StringInterpolationSegmentsSyntax {
    let data = SyntaxData(raw: .node(.stringInterpolationSegments,
                                     elements.map { $0.data.raw }, .present))
    return StringInterpolationSegmentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankStringInterpolationSegments() -> StringInterpolationSegmentsSyntax {
    let data = SyntaxData(raw: .node(.stringInterpolationSegments, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return StringInterpolationSegmentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTryExpr(tryKeyword: TokenSyntax, questionOrExclamationMark: TokenSyntax?, expression: ExprSyntax) -> TryExprSyntax {
    let data = SyntaxData(raw: .node(.tryExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      tryKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      questionOrExclamationMark?.data.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTryExpr() -> TryExprSyntax {
    let data = SyntaxData(raw: .node(.tryExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.tryKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDeclNameArgument(name: TokenSyntax, colon: TokenSyntax) -> DeclNameArgumentSyntax {
    let data = SyntaxData(raw: .node(.declNameArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DeclNameArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDeclNameArgument() -> DeclNameArgumentSyntax {
    let data = SyntaxData(raw: .node(.declNameArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DeclNameArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeDeclNameArgumentList(
    _ elements: [DeclNameArgumentSyntax]) -> DeclNameArgumentListSyntax {
    let data = SyntaxData(raw: .node(.declNameArgumentList,
                                     elements.map { $0.data.raw }, .present))
    return DeclNameArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDeclNameArgumentList() -> DeclNameArgumentListSyntax {
    let data = SyntaxData(raw: .node(.declNameArgumentList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DeclNameArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDeclNameArguments(leftParen: TokenSyntax, arguments: DeclNameArgumentListSyntax, rightParen: TokenSyntax) -> DeclNameArgumentsSyntax {
    let data = SyntaxData(raw: .node(.declNameArguments, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      arguments.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DeclNameArgumentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDeclNameArguments() -> DeclNameArgumentsSyntax {
    let data = SyntaxData(raw: .node(.declNameArguments, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.declNameArgumentList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DeclNameArgumentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeIdentifierExpr(identifier: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?) -> IdentifierExprSyntax {
    let data = SyntaxData(raw: .node(.identifierExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return IdentifierExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIdentifierExpr() -> IdentifierExprSyntax {
    let data = SyntaxData(raw: .node(.identifierExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IdentifierExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSuperRefExpr(superKeyword: TokenSyntax) -> SuperRefExprSyntax {
    let data = SyntaxData(raw: .node(.superRefExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      superKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SuperRefExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSuperRefExpr() -> SuperRefExprSyntax {
    let data = SyntaxData(raw: .node(.superRefExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.superKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SuperRefExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeNilLiteralExpr(nilKeyword: TokenSyntax) -> NilLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.nilLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      nilKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return NilLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankNilLiteralExpr() -> NilLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.nilLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.nilKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return NilLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDiscardAssignmentExpr(wildcard: TokenSyntax) -> DiscardAssignmentExprSyntax {
    let data = SyntaxData(raw: .node(.discardAssignmentExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      wildcard.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DiscardAssignmentExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDiscardAssignmentExpr() -> DiscardAssignmentExprSyntax {
    let data = SyntaxData(raw: .node(.discardAssignmentExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.wildcardKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DiscardAssignmentExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAssignmentExpr(assignToken: TokenSyntax) -> AssignmentExprSyntax {
    let data = SyntaxData(raw: .node(.assignmentExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      assignToken.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AssignmentExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAssignmentExpr() -> AssignmentExprSyntax {
    let data = SyntaxData(raw: .node(.assignmentExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AssignmentExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSequenceExpr(elements: ExprListSyntax) -> SequenceExprSyntax {
    let data = SyntaxData(raw: .node(.sequenceExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SequenceExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSequenceExpr() -> SequenceExprSyntax {
    let data = SyntaxData(raw: .node(.sequenceExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.exprList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SequenceExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeExprList(
    _ elements: [ExprSyntax]) -> ExprListSyntax {
    let data = SyntaxData(raw: .node(.exprList,
                                     elements.map { $0.data.raw }, .present))
    return ExprListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankExprList() -> ExprListSyntax {
    let data = SyntaxData(raw: .node(.exprList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ExprListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundLineExpr(poundLine: TokenSyntax) -> PoundLineExprSyntax {
    let data = SyntaxData(raw: .node(.poundLineExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundLine.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundLineExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundLineExpr() -> PoundLineExprSyntax {
    let data = SyntaxData(raw: .node(.poundLineExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundLineKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundLineExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundFileExpr(poundFile: TokenSyntax) -> PoundFileExprSyntax {
    let data = SyntaxData(raw: .node(.poundFileExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundFile.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundFileExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundFileExpr() -> PoundFileExprSyntax {
    let data = SyntaxData(raw: .node(.poundFileExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundFileKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundFileExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundFunctionExpr(poundFunction: TokenSyntax) -> PoundFunctionExprSyntax {
    let data = SyntaxData(raw: .node(.poundFunctionExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundFunction.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundFunctionExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundFunctionExpr() -> PoundFunctionExprSyntax {
    let data = SyntaxData(raw: .node(.poundFunctionExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundFunctionKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundFunctionExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundDsohandleExpr(poundDsohandle: TokenSyntax) -> PoundDsohandleExprSyntax {
    let data = SyntaxData(raw: .node(.poundDsohandleExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundDsohandle.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundDsohandleExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundDsohandleExpr() -> PoundDsohandleExprSyntax {
    let data = SyntaxData(raw: .node(.poundDsohandleExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundDsohandleKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundDsohandleExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSymbolicReferenceExpr(identifier: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let data = SyntaxData(raw: .node(.symbolicReferenceExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericArgumentClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SymbolicReferenceExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSymbolicReferenceExpr() -> SymbolicReferenceExprSyntax {
    let data = SyntaxData(raw: .node(.symbolicReferenceExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SymbolicReferenceExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePrefixOperatorExpr(operatorToken: TokenSyntax?, postfixExpression: ExprSyntax) -> PrefixOperatorExprSyntax {
    let data = SyntaxData(raw: .node(.prefixOperatorExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      operatorToken?.data.raw ?? RawSyntax.missingToken(TokenKind.prefixOperator("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      postfixExpression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PrefixOperatorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPrefixOperatorExpr() -> PrefixOperatorExprSyntax {
    let data = SyntaxData(raw: .node(.prefixOperatorExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.prefixOperator("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PrefixOperatorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeBinaryOperatorExpr(operatorToken: TokenSyntax) -> BinaryOperatorExprSyntax {
    let data = SyntaxData(raw: .node(.binaryOperatorExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      operatorToken.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return BinaryOperatorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankBinaryOperatorExpr() -> BinaryOperatorExprSyntax {
    let data = SyntaxData(raw: .node(.binaryOperatorExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return BinaryOperatorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeArrowExpr(throwsToken: TokenSyntax?, arrowToken: TokenSyntax) -> ArrowExprSyntax {
    let data = SyntaxData(raw: .node(.arrowExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      throwsToken?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      arrowToken.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ArrowExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankArrowExpr() -> ArrowExprSyntax {
    let data = SyntaxData(raw: .node(.arrowExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.arrow),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ArrowExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeFloatLiteralExpr(floatingDigits: TokenSyntax) -> FloatLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.floatLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      floatingDigits.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return FloatLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFloatLiteralExpr() -> FloatLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.floatLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.floatingLiteral("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FloatLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTupleExpr(leftParen: TokenSyntax, elementList: TupleElementListSyntax, rightParen: TokenSyntax) -> TupleExprSyntax {
    let data = SyntaxData(raw: .node(.tupleExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elementList.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TupleExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTupleExpr() -> TupleExprSyntax {
    let data = SyntaxData(raw: .node(.tupleExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.tupleElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TupleExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeArrayExpr(leftSquare: TokenSyntax, elements: ArrayElementListSyntax, rightSquare: TokenSyntax) -> ArrayExprSyntax {
    let data = SyntaxData(raw: .node(.arrayExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftSquare.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightSquare.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ArrayExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankArrayExpr() -> ArrayExprSyntax {
    let data = SyntaxData(raw: .node(.arrayExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.arrayElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ArrayExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDictionaryExpr(leftSquare: TokenSyntax, content: Syntax, rightSquare: TokenSyntax) -> DictionaryExprSyntax {
    let data = SyntaxData(raw: .node(.dictionaryExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftSquare.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      content.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightSquare.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DictionaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDictionaryExpr() -> DictionaryExprSyntax {
    let data = SyntaxData(raw: .node(.dictionaryExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DictionaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeImplicitMemberExpr(dot: TokenSyntax, name: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?) -> ImplicitMemberExprSyntax {
    let data = SyntaxData(raw: .node(.implicitMemberExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      dot.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ImplicitMemberExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankImplicitMemberExpr() -> ImplicitMemberExprSyntax {
    let data = SyntaxData(raw: .node(.implicitMemberExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.prefixPeriod),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ImplicitMemberExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeFunctionCallArgument(label: TokenSyntax?, colon: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let data = SyntaxData(raw: .node(.functionCallArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      label?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return FunctionCallArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFunctionCallArgument() -> FunctionCallArgumentSyntax {
    let data = SyntaxData(raw: .node(.functionCallArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FunctionCallArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTupleElement(label: TokenSyntax?, colon: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> TupleElementSyntax {
    let data = SyntaxData(raw: .node(.tupleElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      label?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TupleElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTupleElement() -> TupleElementSyntax {
    let data = SyntaxData(raw: .node(.tupleElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TupleElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeArrayElement(expression: ExprSyntax, trailingComma: TokenSyntax?) -> ArrayElementSyntax {
    let data = SyntaxData(raw: .node(.arrayElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ArrayElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankArrayElement() -> ArrayElementSyntax {
    let data = SyntaxData(raw: .node(.arrayElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ArrayElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDictionaryElement(keyExpression: ExprSyntax, colon: TokenSyntax, valueExpression: ExprSyntax, trailingComma: TokenSyntax?) -> DictionaryElementSyntax {
    let data = SyntaxData(raw: .node(.dictionaryElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      keyExpression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      valueExpression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DictionaryElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDictionaryElement() -> DictionaryElementSyntax {
    let data = SyntaxData(raw: .node(.dictionaryElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DictionaryElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeIntegerLiteralExpr(digits: TokenSyntax) -> IntegerLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.integerLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      digits.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return IntegerLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIntegerLiteralExpr() -> IntegerLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.integerLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IntegerLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeStringLiteralExpr(stringLiteral: TokenSyntax) -> StringLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.stringLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      stringLiteral.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return StringLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankStringLiteralExpr() -> StringLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.stringLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.stringLiteral("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return StringLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeBooleanLiteralExpr(booleanLiteral: TokenSyntax) -> BooleanLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.booleanLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      booleanLiteral.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return BooleanLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankBooleanLiteralExpr() -> BooleanLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.booleanLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.trueKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return BooleanLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTernaryExpr(conditionExpression: ExprSyntax, questionMark: TokenSyntax, firstChoice: ExprSyntax, colonMark: TokenSyntax, secondChoice: ExprSyntax) -> TernaryExprSyntax {
    let data = SyntaxData(raw: .node(.ternaryExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      conditionExpression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      questionMark.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      firstChoice.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colonMark.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      secondChoice.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TernaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTernaryExpr() -> TernaryExprSyntax {
    let data = SyntaxData(raw: .node(.ternaryExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.infixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TernaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeMemberAccessExpr(base: ExprSyntax?, dot: TokenSyntax, name: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?) -> MemberAccessExprSyntax {
    let data = SyntaxData(raw: .node(.memberAccessExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      base?.data.raw ?? RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      dot.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return MemberAccessExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankMemberAccessExpr() -> MemberAccessExprSyntax {
    let data = SyntaxData(raw: .node(.memberAccessExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return MemberAccessExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDotSelfExpr(expression: ExprSyntax, dot: TokenSyntax, selfKeyword: TokenSyntax) -> DotSelfExprSyntax {
    let data = SyntaxData(raw: .node(.dotSelfExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      dot.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      selfKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DotSelfExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDotSelfExpr() -> DotSelfExprSyntax {
    let data = SyntaxData(raw: .node(.dotSelfExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.selfKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DotSelfExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeIsExpr(isTok: TokenSyntax, typeName: TypeSyntax) -> IsExprSyntax {
    let data = SyntaxData(raw: .node(.isExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      isTok.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      typeName.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return IsExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIsExpr() -> IsExprSyntax {
    let data = SyntaxData(raw: .node(.isExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.isKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IsExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAsExpr(asTok: TokenSyntax, questionOrExclamationMark: TokenSyntax?, typeName: TypeSyntax) -> AsExprSyntax {
    let data = SyntaxData(raw: .node(.asExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      asTok.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      questionOrExclamationMark?.data.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      typeName.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AsExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAsExpr() -> AsExprSyntax {
    let data = SyntaxData(raw: .node(.asExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.asKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AsExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTypeExpr(type: TypeSyntax) -> TypeExprSyntax {
    let data = SyntaxData(raw: .node(.typeExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      type.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TypeExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTypeExpr() -> TypeExprSyntax {
    let data = SyntaxData(raw: .node(.typeExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TypeExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeClosureCaptureItem(specifier: TokenListSyntax?, name: TokenSyntax?, assignToken: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> ClosureCaptureItemSyntax {
    let data = SyntaxData(raw: .node(.closureCaptureItem, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      specifier?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      name?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      assignToken?.data.raw ?? RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ClosureCaptureItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClosureCaptureItem() -> ClosureCaptureItemSyntax {
    let data = SyntaxData(raw: .node(.closureCaptureItem, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClosureCaptureItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeClosureCaptureItemList(
    _ elements: [ClosureCaptureItemSyntax]) -> ClosureCaptureItemListSyntax {
    let data = SyntaxData(raw: .node(.closureCaptureItemList,
                                     elements.map { $0.data.raw }, .present))
    return ClosureCaptureItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClosureCaptureItemList() -> ClosureCaptureItemListSyntax {
    let data = SyntaxData(raw: .node(.closureCaptureItemList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClosureCaptureItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeClosureCaptureSignature(leftSquare: TokenSyntax, items: ClosureCaptureItemListSyntax?, rightSquare: TokenSyntax) -> ClosureCaptureSignatureSyntax {
    let data = SyntaxData(raw: .node(.closureCaptureSignature, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftSquare.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      items?.data.raw ?? RawSyntax.missing(SyntaxKind.closureCaptureItemList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightSquare.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ClosureCaptureSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClosureCaptureSignature() -> ClosureCaptureSignatureSyntax {
    let data = SyntaxData(raw: .node(.closureCaptureSignature, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.closureCaptureItemList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClosureCaptureSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeClosureParam(name: TokenSyntax, trailingComma: TokenSyntax?) -> ClosureParamSyntax {
    let data = SyntaxData(raw: .node(.closureParam, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ClosureParamSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClosureParam() -> ClosureParamSyntax {
    let data = SyntaxData(raw: .node(.closureParam, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClosureParamSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeClosureParamList(
    _ elements: [ClosureParamSyntax]) -> ClosureParamListSyntax {
    let data = SyntaxData(raw: .node(.closureParamList,
                                     elements.map { $0.data.raw }, .present))
    return ClosureParamListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClosureParamList() -> ClosureParamListSyntax {
    let data = SyntaxData(raw: .node(.closureParamList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClosureParamListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeClosureSignature(capture: ClosureCaptureSignatureSyntax?, input: Syntax?, throwsTok: TokenSyntax?, output: ReturnClauseSyntax?, inTok: TokenSyntax) -> ClosureSignatureSyntax {
    let data = SyntaxData(raw: .node(.closureSignature, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      capture?.data.raw ?? RawSyntax.missing(SyntaxKind.closureCaptureSignature),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      input?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      throwsTok?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      output?.data.raw ?? RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      inTok.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ClosureSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClosureSignature() -> ClosureSignatureSyntax {
    let data = SyntaxData(raw: .node(.closureSignature, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.closureCaptureSignature),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.inKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClosureSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeClosureExpr(leftBrace: TokenSyntax, signature: ClosureSignatureSyntax?, statements: CodeBlockItemListSyntax, rightBrace: TokenSyntax) -> ClosureExprSyntax {
    let data = SyntaxData(raw: .node(.closureExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      signature?.data.raw ?? RawSyntax.missing(SyntaxKind.closureSignature),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      statements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ClosureExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClosureExpr() -> ClosureExprSyntax {
    let data = SyntaxData(raw: .node(.closureExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.closureSignature),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClosureExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeUnresolvedPatternExpr(pattern: PatternSyntax) -> UnresolvedPatternExprSyntax {
    let data = SyntaxData(raw: .node(.unresolvedPatternExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return UnresolvedPatternExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankUnresolvedPatternExpr() -> UnresolvedPatternExprSyntax {
    let data = SyntaxData(raw: .node(.unresolvedPatternExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return UnresolvedPatternExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeFunctionCallExpr(calledExpression: ExprSyntax, leftParen: TokenSyntax?, argumentList: FunctionCallArgumentListSyntax, rightParen: TokenSyntax?, trailingClosure: ClosureExprSyntax?) -> FunctionCallExprSyntax {
    let data = SyntaxData(raw: .node(.functionCallExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      calledExpression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      leftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      argumentList.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      rightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingClosure?.data.raw ?? RawSyntax.missing(SyntaxKind.closureExpr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return FunctionCallExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFunctionCallExpr() -> FunctionCallExprSyntax {
    let data = SyntaxData(raw: .node(.functionCallExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.functionCallArgumentList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.closureExpr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FunctionCallExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSubscriptExpr(calledExpression: ExprSyntax, leftBracket: TokenSyntax, argumentList: FunctionCallArgumentListSyntax, rightBracket: TokenSyntax, trailingClosure: ClosureExprSyntax?) -> SubscriptExprSyntax {
    let data = SyntaxData(raw: .node(.subscriptExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      calledExpression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      argumentList.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingClosure?.data.raw ?? RawSyntax.missing(SyntaxKind.closureExpr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SubscriptExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSubscriptExpr() -> SubscriptExprSyntax {
    let data = SyntaxData(raw: .node(.subscriptExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.functionCallArgumentList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.closureExpr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SubscriptExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeOptionalChainingExpr(expression: ExprSyntax, questionMark: TokenSyntax) -> OptionalChainingExprSyntax {
    let data = SyntaxData(raw: .node(.optionalChainingExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      questionMark.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return OptionalChainingExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankOptionalChainingExpr() -> OptionalChainingExprSyntax {
    let data = SyntaxData(raw: .node(.optionalChainingExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return OptionalChainingExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeForcedValueExpr(expression: ExprSyntax, exclamationMark: TokenSyntax) -> ForcedValueExprSyntax {
    let data = SyntaxData(raw: .node(.forcedValueExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      exclamationMark.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ForcedValueExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankForcedValueExpr() -> ForcedValueExprSyntax {
    let data = SyntaxData(raw: .node(.forcedValueExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.exclamationMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ForcedValueExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePostfixUnaryExpr(expression: ExprSyntax, operatorToken: TokenSyntax) -> PostfixUnaryExprSyntax {
    let data = SyntaxData(raw: .node(.postfixUnaryExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      operatorToken.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PostfixUnaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPostfixUnaryExpr() -> PostfixUnaryExprSyntax {
    let data = SyntaxData(raw: .node(.postfixUnaryExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.postfixOperator("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PostfixUnaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSpecializeExpr(expression: ExprSyntax, genericArgumentClause: GenericArgumentClauseSyntax) -> SpecializeExprSyntax {
    let data = SyntaxData(raw: .node(.specializeExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      genericArgumentClause.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SpecializeExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSpecializeExpr() -> SpecializeExprSyntax {
    let data = SyntaxData(raw: .node(.specializeExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SpecializeExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeStringSegment(content: TokenSyntax) -> StringSegmentSyntax {
    let data = SyntaxData(raw: .node(.stringSegment, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      content.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return StringSegmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankStringSegment() -> StringSegmentSyntax {
    let data = SyntaxData(raw: .node(.stringSegment, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.stringSegment("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return StringSegmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeExpressionSegment(backslash: TokenSyntax, leftParen: TokenSyntax, expression: ExprSyntax, rightParen: TokenSyntax) -> ExpressionSegmentSyntax {
    let data = SyntaxData(raw: .node(.expressionSegment, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      backslash.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ExpressionSegmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankExpressionSegment() -> ExpressionSegmentSyntax {
    let data = SyntaxData(raw: .node(.expressionSegment, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.backslash),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.stringInterpolationAnchor),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ExpressionSegmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeStringInterpolationExpr(openQuote: TokenSyntax, segments: StringInterpolationSegmentsSyntax, closeQuote: TokenSyntax) -> StringInterpolationExprSyntax {
    let data = SyntaxData(raw: .node(.stringInterpolationExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      openQuote.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      segments.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      closeQuote.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return StringInterpolationExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankStringInterpolationExpr() -> StringInterpolationExprSyntax {
    let data = SyntaxData(raw: .node(.stringInterpolationExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.stringQuote),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.stringInterpolationSegments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.stringQuote),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return StringInterpolationExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeKeyPathExpr(backslash: TokenSyntax, rootExpr: ExprSyntax?, expression: ExprSyntax) -> KeyPathExprSyntax {
    let data = SyntaxData(raw: .node(.keyPathExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      backslash.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      rootExpr?.data.raw ?? RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return KeyPathExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankKeyPathExpr() -> KeyPathExprSyntax {
    let data = SyntaxData(raw: .node(.keyPathExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.backslash),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return KeyPathExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeKeyPathBaseExpr(period: TokenSyntax) -> KeyPathBaseExprSyntax {
    let data = SyntaxData(raw: .node(.keyPathBaseExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      period.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return KeyPathBaseExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankKeyPathBaseExpr() -> KeyPathBaseExprSyntax {
    let data = SyntaxData(raw: .node(.keyPathBaseExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return KeyPathBaseExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeObjcNamePiece(name: TokenSyntax, dot: TokenSyntax?) -> ObjcNamePieceSyntax {
    let data = SyntaxData(raw: .node(.objcNamePiece, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      dot?.data.raw ?? RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ObjcNamePieceSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankObjcNamePiece() -> ObjcNamePieceSyntax {
    let data = SyntaxData(raw: .node(.objcNamePiece, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ObjcNamePieceSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeObjcName(
    _ elements: [ObjcNamePieceSyntax]) -> ObjcNameSyntax {
    let data = SyntaxData(raw: .node(.objcName,
                                     elements.map { $0.data.raw }, .present))
    return ObjcNameSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankObjcName() -> ObjcNameSyntax {
    let data = SyntaxData(raw: .node(.objcName, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ObjcNameSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeObjcKeyPathExpr(keyPath: TokenSyntax, leftParen: TokenSyntax, name: ObjcNameSyntax, rightParen: TokenSyntax) -> ObjcKeyPathExprSyntax {
    let data = SyntaxData(raw: .node(.objcKeyPathExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      keyPath.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ObjcKeyPathExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankObjcKeyPathExpr() -> ObjcKeyPathExprSyntax {
    let data = SyntaxData(raw: .node(.objcKeyPathExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundKeyPathKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.objcName),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ObjcKeyPathExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeObjcSelectorExpr(poundSelector: TokenSyntax, leftParen: TokenSyntax, kind: TokenSyntax?, colon: TokenSyntax?, name: ExprSyntax, rightParen: TokenSyntax) -> ObjcSelectorExprSyntax {
    let data = SyntaxData(raw: .node(.objcSelectorExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundSelector.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      kind?.data.raw ?? RawSyntax.missingToken(TokenKind.contextualKeyword("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ObjcSelectorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankObjcSelectorExpr() -> ObjcSelectorExprSyntax {
    let data = SyntaxData(raw: .node(.objcSelectorExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundSelectorKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.contextualKeyword("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ObjcSelectorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeEditorPlaceholderExpr(identifier: TokenSyntax) -> EditorPlaceholderExprSyntax {
    let data = SyntaxData(raw: .node(.editorPlaceholderExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return EditorPlaceholderExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankEditorPlaceholderExpr() -> EditorPlaceholderExprSyntax {
    let data = SyntaxData(raw: .node(.editorPlaceholderExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return EditorPlaceholderExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeObjectLiteralExpr(identifier: TokenSyntax, leftParen: TokenSyntax, arguments: FunctionCallArgumentListSyntax, rightParen: TokenSyntax) -> ObjectLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.objectLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      arguments.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ObjectLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankObjectLiteralExpr() -> ObjectLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.objectLiteralExpr, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundColorLiteralKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.functionCallArgumentList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ObjectLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTypeInitializerClause(equal: TokenSyntax, value: TypeSyntax) -> TypeInitializerClauseSyntax {
    let data = SyntaxData(raw: .node(.typeInitializerClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      equal.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      value.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TypeInitializerClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTypeInitializerClause() -> TypeInitializerClauseSyntax {
    let data = SyntaxData(raw: .node(.typeInitializerClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TypeInitializerClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTypealiasDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, typealiasKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, initializer: TypeInitializerClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?) -> TypealiasDeclSyntax {
    let data = SyntaxData(raw: .node(.typealiasDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      typealiasKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      initializer?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInitializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TypealiasDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTypealiasDecl() -> TypealiasDeclSyntax {
    let data = SyntaxData(raw: .node(.typealiasDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.typealiasKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeInitializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TypealiasDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAssociatedtypeDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, associatedtypeKeyword: TokenSyntax, identifier: TokenSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, initializer: TypeInitializerClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let data = SyntaxData(raw: .node(.associatedtypeDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      associatedtypeKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      initializer?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInitializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AssociatedtypeDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAssociatedtypeDecl() -> AssociatedtypeDeclSyntax {
    let data = SyntaxData(raw: .node(.associatedtypeDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.associatedtypeKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeInitializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AssociatedtypeDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeFunctionParameterList(
    _ elements: [FunctionParameterSyntax]) -> FunctionParameterListSyntax {
    let data = SyntaxData(raw: .node(.functionParameterList,
                                     elements.map { $0.data.raw }, .present))
    return FunctionParameterListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFunctionParameterList() -> FunctionParameterListSyntax {
    let data = SyntaxData(raw: .node(.functionParameterList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FunctionParameterListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeParameterClause(leftParen: TokenSyntax, parameterList: FunctionParameterListSyntax, rightParen: TokenSyntax) -> ParameterClauseSyntax {
    let data = SyntaxData(raw: .node(.parameterClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      parameterList.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ParameterClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankParameterClause() -> ParameterClauseSyntax {
    let data = SyntaxData(raw: .node(.parameterClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.functionParameterList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ParameterClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeReturnClause(arrow: TokenSyntax, returnType: TypeSyntax) -> ReturnClauseSyntax {
    let data = SyntaxData(raw: .node(.returnClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      arrow.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      returnType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ReturnClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankReturnClause() -> ReturnClauseSyntax {
    let data = SyntaxData(raw: .node(.returnClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.arrow),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ReturnClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeFunctionSignature(input: ParameterClauseSyntax, throwsOrRethrowsKeyword: TokenSyntax?, output: ReturnClauseSyntax?) -> FunctionSignatureSyntax {
    let data = SyntaxData(raw: .node(.functionSignature, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      input.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      throwsOrRethrowsKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      output?.data.raw ?? RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return FunctionSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFunctionSignature() -> FunctionSignatureSyntax {
    let data = SyntaxData(raw: .node(.functionSignature, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FunctionSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeIfConfigClause(poundKeyword: TokenSyntax, condition: ExprSyntax?, elements: Syntax) -> IfConfigClauseSyntax {
    let data = SyntaxData(raw: .node(.ifConfigClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      condition?.data.raw ?? RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return IfConfigClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIfConfigClause() -> IfConfigClauseSyntax {
    let data = SyntaxData(raw: .node(.ifConfigClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundIfKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IfConfigClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeIfConfigClauseList(
    _ elements: [IfConfigClauseSyntax]) -> IfConfigClauseListSyntax {
    let data = SyntaxData(raw: .node(.ifConfigClauseList,
                                     elements.map { $0.data.raw }, .present))
    return IfConfigClauseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIfConfigClauseList() -> IfConfigClauseListSyntax {
    let data = SyntaxData(raw: .node(.ifConfigClauseList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IfConfigClauseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeIfConfigDecl(clauses: IfConfigClauseListSyntax, poundEndif: TokenSyntax) -> IfConfigDeclSyntax {
    let data = SyntaxData(raw: .node(.ifConfigDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      clauses.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundEndif.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return IfConfigDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIfConfigDecl() -> IfConfigDeclSyntax {
    let data = SyntaxData(raw: .node(.ifConfigDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.ifConfigClauseList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundEndifKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IfConfigDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundErrorDecl(poundError: TokenSyntax, leftParen: TokenSyntax, message: StringLiteralExprSyntax, rightParen: TokenSyntax) -> PoundErrorDeclSyntax {
    let data = SyntaxData(raw: .node(.poundErrorDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundError.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      message.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundErrorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundErrorDecl() -> PoundErrorDeclSyntax {
    let data = SyntaxData(raw: .node(.poundErrorDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundErrorKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.stringLiteralExpr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundErrorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundWarningDecl(poundWarning: TokenSyntax, leftParen: TokenSyntax, message: StringLiteralExprSyntax, rightParen: TokenSyntax) -> PoundWarningDeclSyntax {
    let data = SyntaxData(raw: .node(.poundWarningDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundWarning.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      message.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundWarningDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundWarningDecl() -> PoundWarningDeclSyntax {
    let data = SyntaxData(raw: .node(.poundWarningDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundWarningKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.stringLiteralExpr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundWarningDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundSourceLocation(poundSourceLocation: TokenSyntax, leftParen: TokenSyntax, args: PoundSourceLocationArgsSyntax?, rightParen: TokenSyntax) -> PoundSourceLocationSyntax {
    let data = SyntaxData(raw: .node(.poundSourceLocation, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundSourceLocation.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      args?.data.raw ?? RawSyntax.missing(SyntaxKind.poundSourceLocationArgs),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundSourceLocationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundSourceLocation() -> PoundSourceLocationSyntax {
    let data = SyntaxData(raw: .node(.poundSourceLocation, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundSourceLocationKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.poundSourceLocationArgs),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundSourceLocationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePoundSourceLocationArgs(fileArgLabel: TokenSyntax, fileArgColon: TokenSyntax, fileName: TokenSyntax, comma: TokenSyntax, lineArgLabel: TokenSyntax, lineArgColon: TokenSyntax, lineNumber: TokenSyntax) -> PoundSourceLocationArgsSyntax {
    let data = SyntaxData(raw: .node(.poundSourceLocationArgs, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      fileArgLabel.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      fileArgColon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      fileName.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      comma.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      lineArgLabel.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      lineArgColon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      lineNumber.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PoundSourceLocationArgsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPoundSourceLocationArgs() -> PoundSourceLocationArgsSyntax {
    let data = SyntaxData(raw: .node(.poundSourceLocationArgs, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.stringLiteral("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PoundSourceLocationArgsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDeclModifier(name: TokenSyntax, detailLeftParen: TokenSyntax?, detail: TokenSyntax?, detailRightParen: TokenSyntax?) -> DeclModifierSyntax {
    let data = SyntaxData(raw: .node(.declModifier, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      detailLeftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      detail?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      detailRightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DeclModifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDeclModifier() -> DeclModifierSyntax {
    let data = SyntaxData(raw: .node(.declModifier, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DeclModifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeInheritedType(typeName: TypeSyntax, trailingComma: TokenSyntax?) -> InheritedTypeSyntax {
    let data = SyntaxData(raw: .node(.inheritedType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      typeName.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return InheritedTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankInheritedType() -> InheritedTypeSyntax {
    let data = SyntaxData(raw: .node(.inheritedType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return InheritedTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeInheritedTypeList(
    _ elements: [InheritedTypeSyntax]) -> InheritedTypeListSyntax {
    let data = SyntaxData(raw: .node(.inheritedTypeList,
                                     elements.map { $0.data.raw }, .present))
    return InheritedTypeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankInheritedTypeList() -> InheritedTypeListSyntax {
    let data = SyntaxData(raw: .node(.inheritedTypeList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return InheritedTypeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTypeInheritanceClause(colon: TokenSyntax, inheritedTypeCollection: InheritedTypeListSyntax) -> TypeInheritanceClauseSyntax {
    let data = SyntaxData(raw: .node(.typeInheritanceClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      inheritedTypeCollection.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TypeInheritanceClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTypeInheritanceClause() -> TypeInheritanceClauseSyntax {
    let data = SyntaxData(raw: .node(.typeInheritanceClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.inheritedTypeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TypeInheritanceClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeClassDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, classKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ClassDeclSyntax {
    let data = SyntaxData(raw: .node(.classDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      classKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      members.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ClassDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClassDecl() -> ClassDeclSyntax {
    let data = SyntaxData(raw: .node(.classDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.classKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClassDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeStructDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, structKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> StructDeclSyntax {
    let data = SyntaxData(raw: .node(.structDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      structKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      members.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return StructDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankStructDecl() -> StructDeclSyntax {
    let data = SyntaxData(raw: .node(.structDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.structKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return StructDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeProtocolDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, protocolKeyword: TokenSyntax, identifier: TokenSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ProtocolDeclSyntax {
    let data = SyntaxData(raw: .node(.protocolDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      protocolKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      members.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ProtocolDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankProtocolDecl() -> ProtocolDeclSyntax {
    let data = SyntaxData(raw: .node(.protocolDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.protocolKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ProtocolDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeExtensionDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, extensionKeyword: TokenSyntax, extendedType: TypeSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ExtensionDeclSyntax {
    let data = SyntaxData(raw: .node(.extensionDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      extensionKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      extendedType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      members.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ExtensionDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankExtensionDecl() -> ExtensionDeclSyntax {
    let data = SyntaxData(raw: .node(.extensionDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.extensionKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ExtensionDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeMemberDeclBlock(leftBrace: TokenSyntax, members: MemberDeclListSyntax, rightBrace: TokenSyntax) -> MemberDeclBlockSyntax {
    let data = SyntaxData(raw: .node(.memberDeclBlock, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      members.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return MemberDeclBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankMemberDeclBlock() -> MemberDeclBlockSyntax {
    let data = SyntaxData(raw: .node(.memberDeclBlock, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.memberDeclList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return MemberDeclBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeMemberDeclList(
    _ elements: [MemberDeclListItemSyntax]) -> MemberDeclListSyntax {
    let data = SyntaxData(raw: .node(.memberDeclList,
                                     elements.map { $0.data.raw }, .present))
    return MemberDeclListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankMemberDeclList() -> MemberDeclListSyntax {
    let data = SyntaxData(raw: .node(.memberDeclList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return MemberDeclListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeMemberDeclListItem(decl: DeclSyntax, semicolon: TokenSyntax?) -> MemberDeclListItemSyntax {
    let data = SyntaxData(raw: .node(.memberDeclListItem, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      decl.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      semicolon?.data.raw ?? RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return MemberDeclListItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankMemberDeclListItem() -> MemberDeclListItemSyntax {
    let data = SyntaxData(raw: .node(.memberDeclListItem, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.decl),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return MemberDeclListItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSourceFile(statements: CodeBlockItemListSyntax, eofToken: TokenSyntax) -> SourceFileSyntax {
    let data = SyntaxData(raw: .node(.sourceFile, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      statements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      eofToken.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SourceFileSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSourceFile() -> SourceFileSyntax {
    let data = SyntaxData(raw: .node(.sourceFile, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SourceFileSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeInitializerClause(equal: TokenSyntax, value: ExprSyntax) -> InitializerClauseSyntax {
    let data = SyntaxData(raw: .node(.initializerClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      equal.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      value.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return InitializerClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankInitializerClause() -> InitializerClauseSyntax {
    let data = SyntaxData(raw: .node(.initializerClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return InitializerClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeFunctionParameter(attributes: AttributeListSyntax?, firstName: TokenSyntax?, secondName: TokenSyntax?, colon: TokenSyntax?, type: TypeSyntax?, ellipsis: TokenSyntax?, defaultArgument: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> FunctionParameterSyntax {
    let data = SyntaxData(raw: .node(.functionParameter, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      firstName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      secondName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      type?.data.raw ?? RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      ellipsis?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      defaultArgument?.data.raw ?? RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return FunctionParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFunctionParameter() -> FunctionParameterSyntax {
    let data = SyntaxData(raw: .node(.functionParameter, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FunctionParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeModifierList(
    _ elements: [DeclModifierSyntax]) -> ModifierListSyntax {
    let data = SyntaxData(raw: .node(.modifierList,
                                     elements.map { $0.data.raw }, .present))
    return ModifierListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankModifierList() -> ModifierListSyntax {
    let data = SyntaxData(raw: .node(.modifierList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ModifierListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeFunctionDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, funcKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, signature: FunctionSignatureSyntax, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let data = SyntaxData(raw: .node(.functionDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      funcKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      signature.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      body?.data.raw ?? RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return FunctionDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFunctionDecl() -> FunctionDeclSyntax {
    let data = SyntaxData(raw: .node(.functionDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.funcKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.functionSignature),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FunctionDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeInitializerDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, initKeyword: TokenSyntax, optionalMark: TokenSyntax?, genericParameterClause: GenericParameterClauseSyntax?, parameters: ParameterClauseSyntax, throwsOrRethrowsKeyword: TokenSyntax?, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax?) -> InitializerDeclSyntax {
    let data = SyntaxData(raw: .node(.initializerDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      initKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      optionalMark?.data.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      parameters.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      throwsOrRethrowsKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      body?.data.raw ?? RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return InitializerDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankInitializerDecl() -> InitializerDeclSyntax {
    let data = SyntaxData(raw: .node(.initializerDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.initKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return InitializerDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDeinitializerDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, deinitKeyword: TokenSyntax, body: CodeBlockSyntax) -> DeinitializerDeclSyntax {
    let data = SyntaxData(raw: .node(.deinitializerDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      deinitKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DeinitializerDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDeinitializerDecl() -> DeinitializerDeclSyntax {
    let data = SyntaxData(raw: .node(.deinitializerDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.deinitKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DeinitializerDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSubscriptDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, subscriptKeyword: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, indices: ParameterClauseSyntax, result: ReturnClauseSyntax, genericWhereClause: GenericWhereClauseSyntax?, accessor: AccessorBlockSyntax?) -> SubscriptDeclSyntax {
    let data = SyntaxData(raw: .node(.subscriptDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      subscriptKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      indices.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      result.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      accessor?.data.raw ?? RawSyntax.missing(SyntaxKind.accessorBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SubscriptDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSubscriptDecl() -> SubscriptDeclSyntax {
    let data = SyntaxData(raw: .node(.subscriptDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.subscriptKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.accessorBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SubscriptDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAccessLevelModifier(name: TokenSyntax, leftParen: TokenSyntax?, modifier: TokenSyntax?, rightParen: TokenSyntax?) -> AccessLevelModifierSyntax {
    let data = SyntaxData(raw: .node(.accessLevelModifier, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      leftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifier?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      rightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AccessLevelModifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAccessLevelModifier() -> AccessLevelModifierSyntax {
    let data = SyntaxData(raw: .node(.accessLevelModifier, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AccessLevelModifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAccessPathComponent(name: TokenSyntax, trailingDot: TokenSyntax?) -> AccessPathComponentSyntax {
    let data = SyntaxData(raw: .node(.accessPathComponent, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingDot?.data.raw ?? RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AccessPathComponentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAccessPathComponent() -> AccessPathComponentSyntax {
    let data = SyntaxData(raw: .node(.accessPathComponent, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AccessPathComponentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeAccessPath(
    _ elements: [AccessPathComponentSyntax]) -> AccessPathSyntax {
    let data = SyntaxData(raw: .node(.accessPath,
                                     elements.map { $0.data.raw }, .present))
    return AccessPathSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAccessPath() -> AccessPathSyntax {
    let data = SyntaxData(raw: .node(.accessPath, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AccessPathSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeImportDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, importTok: TokenSyntax, importKind: TokenSyntax?, path: AccessPathSyntax) -> ImportDeclSyntax {
    let data = SyntaxData(raw: .node(.importDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      importTok.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      importKind?.data.raw ?? RawSyntax.missingToken(TokenKind.typealiasKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      path.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ImportDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankImportDecl() -> ImportDeclSyntax {
    let data = SyntaxData(raw: .node(.importDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.importKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.typealiasKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.accessPath),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ImportDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAccessorParameter(leftParen: TokenSyntax, name: TokenSyntax, rightParen: TokenSyntax) -> AccessorParameterSyntax {
    let data = SyntaxData(raw: .node(.accessorParameter, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AccessorParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAccessorParameter() -> AccessorParameterSyntax {
    let data = SyntaxData(raw: .node(.accessorParameter, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AccessorParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAccessorDecl(attributes: AttributeListSyntax?, modifier: DeclModifierSyntax?, accessorKind: TokenSyntax, parameter: AccessorParameterSyntax?, body: CodeBlockSyntax?) -> AccessorDeclSyntax {
    let data = SyntaxData(raw: .node(.accessorDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifier?.data.raw ?? RawSyntax.missing(SyntaxKind.declModifier),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      accessorKind.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      parameter?.data.raw ?? RawSyntax.missing(SyntaxKind.accessorParameter),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      body?.data.raw ?? RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AccessorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAccessorDecl() -> AccessorDeclSyntax {
    let data = SyntaxData(raw: .node(.accessorDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.declModifier),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.accessorParameter),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AccessorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeAccessorList(
    _ elements: [AccessorDeclSyntax]) -> AccessorListSyntax {
    let data = SyntaxData(raw: .node(.accessorList,
                                     elements.map { $0.data.raw }, .present))
    return AccessorListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAccessorList() -> AccessorListSyntax {
    let data = SyntaxData(raw: .node(.accessorList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AccessorListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAccessorBlock(leftBrace: TokenSyntax, accessorListOrStmtList: Syntax, rightBrace: TokenSyntax) -> AccessorBlockSyntax {
    let data = SyntaxData(raw: .node(.accessorBlock, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      accessorListOrStmtList.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AccessorBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAccessorBlock() -> AccessorBlockSyntax {
    let data = SyntaxData(raw: .node(.accessorBlock, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AccessorBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePatternBinding(pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax?, accessor: AccessorBlockSyntax?, trailingComma: TokenSyntax?) -> PatternBindingSyntax {
    let data = SyntaxData(raw: .node(.patternBinding, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      initializer?.data.raw ?? RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      accessor?.data.raw ?? RawSyntax.missing(SyntaxKind.accessorBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PatternBindingSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPatternBinding() -> PatternBindingSyntax {
    let data = SyntaxData(raw: .node(.patternBinding, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.accessorBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PatternBindingSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makePatternBindingList(
    _ elements: [PatternBindingSyntax]) -> PatternBindingListSyntax {
    let data = SyntaxData(raw: .node(.patternBindingList,
                                     elements.map { $0.data.raw }, .present))
    return PatternBindingListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPatternBindingList() -> PatternBindingListSyntax {
    let data = SyntaxData(raw: .node(.patternBindingList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PatternBindingListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeVariableDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, letOrVarKeyword: TokenSyntax, bindings: PatternBindingListSyntax) -> VariableDeclSyntax {
    let data = SyntaxData(raw: .node(.variableDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      letOrVarKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      bindings.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return VariableDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankVariableDecl() -> VariableDeclSyntax {
    let data = SyntaxData(raw: .node(.variableDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.letKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.patternBindingList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return VariableDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeEnumCaseElement(identifier: TokenSyntax, associatedValue: ParameterClauseSyntax?, rawValue: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> EnumCaseElementSyntax {
    let data = SyntaxData(raw: .node(.enumCaseElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      associatedValue?.data.raw ?? RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      rawValue?.data.raw ?? RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return EnumCaseElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankEnumCaseElement() -> EnumCaseElementSyntax {
    let data = SyntaxData(raw: .node(.enumCaseElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return EnumCaseElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeEnumCaseElementList(
    _ elements: [EnumCaseElementSyntax]) -> EnumCaseElementListSyntax {
    let data = SyntaxData(raw: .node(.enumCaseElementList,
                                     elements.map { $0.data.raw }, .present))
    return EnumCaseElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankEnumCaseElementList() -> EnumCaseElementListSyntax {
    let data = SyntaxData(raw: .node(.enumCaseElementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return EnumCaseElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeEnumCaseDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, caseKeyword: TokenSyntax, elements: EnumCaseElementListSyntax) -> EnumCaseDeclSyntax {
    let data = SyntaxData(raw: .node(.enumCaseDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      caseKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return EnumCaseDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankEnumCaseDecl() -> EnumCaseDeclSyntax {
    let data = SyntaxData(raw: .node(.enumCaseDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.enumCaseElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return EnumCaseDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeEnumDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, enumKeyword: TokenSyntax, identifier: TokenSyntax, genericParameters: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> EnumDeclSyntax {
    let data = SyntaxData(raw: .node(.enumDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      enumKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericParameters?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      members.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return EnumDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankEnumDecl() -> EnumDeclSyntax {
    let data = SyntaxData(raw: .node(.enumDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.enumKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return EnumDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeOperatorDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, operatorKeyword: TokenSyntax, identifier: TokenSyntax, infixOperatorGroup: InfixOperatorGroupSyntax?) -> OperatorDeclSyntax {
    let data = SyntaxData(raw: .node(.operatorDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      operatorKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      infixOperatorGroup?.data.raw ?? RawSyntax.missing(SyntaxKind.infixOperatorGroup),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return OperatorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankOperatorDecl() -> OperatorDeclSyntax {
    let data = SyntaxData(raw: .node(.operatorDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.operatorKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unspacedBinaryOperator("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.infixOperatorGroup),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return OperatorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeInfixOperatorGroup(colon: TokenSyntax, precedenceGroupName: TokenSyntax) -> InfixOperatorGroupSyntax {
    let data = SyntaxData(raw: .node(.infixOperatorGroup, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      precedenceGroupName.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return InfixOperatorGroupSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankInfixOperatorGroup() -> InfixOperatorGroupSyntax {
    let data = SyntaxData(raw: .node(.infixOperatorGroup, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return InfixOperatorGroupSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePrecedenceGroupDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, precedencegroupKeyword: TokenSyntax, identifier: TokenSyntax, leftBrace: TokenSyntax, groupAttributes: PrecedenceGroupAttributeListSyntax, rightBrace: TokenSyntax) -> PrecedenceGroupDeclSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      precedencegroupKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      groupAttributes.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PrecedenceGroupDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPrecedenceGroupDecl() -> PrecedenceGroupDeclSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupDecl, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.precedencegroupKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.precedenceGroupAttributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PrecedenceGroupDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makePrecedenceGroupAttributeList(
    _ elements: [Syntax]) -> PrecedenceGroupAttributeListSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupAttributeList,
                                     elements.map { $0.data.raw }, .present))
    return PrecedenceGroupAttributeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPrecedenceGroupAttributeList() -> PrecedenceGroupAttributeListSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupAttributeList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PrecedenceGroupAttributeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePrecedenceGroupRelation(higherThanOrLowerThan: TokenSyntax, colon: TokenSyntax, otherNames: PrecedenceGroupNameListSyntax) -> PrecedenceGroupRelationSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupRelation, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      higherThanOrLowerThan.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      otherNames.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PrecedenceGroupRelationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPrecedenceGroupRelation() -> PrecedenceGroupRelationSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupRelation, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.precedenceGroupNameList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PrecedenceGroupRelationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makePrecedenceGroupNameList(
    _ elements: [PrecedenceGroupNameElementSyntax]) -> PrecedenceGroupNameListSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupNameList,
                                     elements.map { $0.data.raw }, .present))
    return PrecedenceGroupNameListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPrecedenceGroupNameList() -> PrecedenceGroupNameListSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupNameList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PrecedenceGroupNameListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePrecedenceGroupNameElement(name: TokenSyntax, trailingComma: TokenSyntax?) -> PrecedenceGroupNameElementSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupNameElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PrecedenceGroupNameElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPrecedenceGroupNameElement() -> PrecedenceGroupNameElementSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupNameElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PrecedenceGroupNameElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePrecedenceGroupAssignment(assignmentKeyword: TokenSyntax, colon: TokenSyntax, flag: TokenSyntax) -> PrecedenceGroupAssignmentSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupAssignment, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      assignmentKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      flag.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PrecedenceGroupAssignmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPrecedenceGroupAssignment() -> PrecedenceGroupAssignmentSyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupAssignment, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.trueKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PrecedenceGroupAssignmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makePrecedenceGroupAssociativity(associativityKeyword: TokenSyntax, colon: TokenSyntax, value: TokenSyntax) -> PrecedenceGroupAssociativitySyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupAssociativity, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      associativityKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      value.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return PrecedenceGroupAssociativitySyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankPrecedenceGroupAssociativity() -> PrecedenceGroupAssociativitySyntax {
    let data = SyntaxData(raw: .node(.precedenceGroupAssociativity, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return PrecedenceGroupAssociativitySyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeTokenList(
    _ elements: [TokenSyntax]) -> TokenListSyntax {
    let data = SyntaxData(raw: .node(.tokenList,
                                     elements.map { $0.data.raw }, .present))
    return TokenListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTokenList() -> TokenListSyntax {
    let data = SyntaxData(raw: .node(.tokenList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TokenListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeNonEmptyTokenList(
    _ elements: [TokenSyntax]) -> NonEmptyTokenListSyntax {
    let data = SyntaxData(raw: .node(.nonEmptyTokenList,
                                     elements.map { $0.data.raw }, .present))
    return NonEmptyTokenListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankNonEmptyTokenList() -> NonEmptyTokenListSyntax {
    let data = SyntaxData(raw: .node(.nonEmptyTokenList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return NonEmptyTokenListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAttribute(atSignToken: TokenSyntax, attributeName: TokenSyntax, leftParen: TokenSyntax?, argument: Syntax?, rightParen: TokenSyntax?, tokenList: TokenListSyntax?) -> AttributeSyntax {
    let data = SyntaxData(raw: .node(.attribute, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      atSignToken.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      attributeName.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      leftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      argument?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      rightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      tokenList?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AttributeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAttribute() -> AttributeSyntax {
    let data = SyntaxData(raw: .node(.attribute, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.atSign),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AttributeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeAttributeList(
    _ elements: [AttributeSyntax]) -> AttributeListSyntax {
    let data = SyntaxData(raw: .node(.attributeList,
                                     elements.map { $0.data.raw }, .present))
    return AttributeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAttributeList() -> AttributeListSyntax {
    let data = SyntaxData(raw: .node(.attributeList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AttributeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeSpecializeAttributeSpecList(
    _ elements: [Syntax]) -> SpecializeAttributeSpecListSyntax {
    let data = SyntaxData(raw: .node(.specializeAttributeSpecList,
                                     elements.map { $0.data.raw }, .present))
    return SpecializeAttributeSpecListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSpecializeAttributeSpecList() -> SpecializeAttributeSpecListSyntax {
    let data = SyntaxData(raw: .node(.specializeAttributeSpecList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SpecializeAttributeSpecListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeLabeledSpecializeEntry(label: TokenSyntax, colon: TokenSyntax, value: TokenSyntax, trailingComma: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let data = SyntaxData(raw: .node(.labeledSpecializeEntry, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      label.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      value.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return LabeledSpecializeEntrySyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankLabeledSpecializeEntry() -> LabeledSpecializeEntrySyntax {
    let data = SyntaxData(raw: .node(.labeledSpecializeEntry, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return LabeledSpecializeEntrySyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeImplementsAttributeArguments(type: SimpleTypeIdentifierSyntax, comma: TokenSyntax, declBaseName: Syntax, declNameArguments: DeclNameArgumentsSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let data = SyntaxData(raw: .node(.implementsAttributeArguments, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      type.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      comma.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      declBaseName.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ImplementsAttributeArgumentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankImplementsAttributeArguments() -> ImplementsAttributeArgumentsSyntax {
    let data = SyntaxData(raw: .node(.implementsAttributeArguments, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.simpleTypeIdentifier),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ImplementsAttributeArgumentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeObjCSelectorPiece(name: TokenSyntax?, colon: TokenSyntax?) -> ObjCSelectorPieceSyntax {
    let data = SyntaxData(raw: .node(.objCSelectorPiece, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      name?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ObjCSelectorPieceSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankObjCSelectorPiece() -> ObjCSelectorPieceSyntax {
    let data = SyntaxData(raw: .node(.objCSelectorPiece, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ObjCSelectorPieceSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeObjCSelector(
    _ elements: [ObjCSelectorPieceSyntax]) -> ObjCSelectorSyntax {
    let data = SyntaxData(raw: .node(.objCSelector,
                                     elements.map { $0.data.raw }, .present))
    return ObjCSelectorSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankObjCSelector() -> ObjCSelectorSyntax {
    let data = SyntaxData(raw: .node(.objCSelector, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ObjCSelectorSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeContinueStmt(continueKeyword: TokenSyntax, label: TokenSyntax?) -> ContinueStmtSyntax {
    let data = SyntaxData(raw: .node(.continueStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      continueKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      label?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ContinueStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankContinueStmt() -> ContinueStmtSyntax {
    let data = SyntaxData(raw: .node(.continueStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.continueKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ContinueStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeWhileStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, whileKeyword: TokenSyntax, conditions: ConditionElementListSyntax, body: CodeBlockSyntax) -> WhileStmtSyntax {
    let data = SyntaxData(raw: .node(.whileStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      whileKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      conditions.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return WhileStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankWhileStmt() -> WhileStmtSyntax {
    let data = SyntaxData(raw: .node(.whileStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.whileKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.conditionElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return WhileStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDeferStmt(deferKeyword: TokenSyntax, body: CodeBlockSyntax) -> DeferStmtSyntax {
    let data = SyntaxData(raw: .node(.deferStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      deferKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DeferStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDeferStmt() -> DeferStmtSyntax {
    let data = SyntaxData(raw: .node(.deferStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.deferKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DeferStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeExpressionStmt(expression: ExprSyntax) -> ExpressionStmtSyntax {
    let data = SyntaxData(raw: .node(.expressionStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ExpressionStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankExpressionStmt() -> ExpressionStmtSyntax {
    let data = SyntaxData(raw: .node(.expressionStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ExpressionStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeSwitchCaseList(
    _ elements: [Syntax]) -> SwitchCaseListSyntax {
    let data = SyntaxData(raw: .node(.switchCaseList,
                                     elements.map { $0.data.raw }, .present))
    return SwitchCaseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSwitchCaseList() -> SwitchCaseListSyntax {
    let data = SyntaxData(raw: .node(.switchCaseList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SwitchCaseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeRepeatWhileStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, repeatKeyword: TokenSyntax, body: CodeBlockSyntax, whileKeyword: TokenSyntax, condition: ExprSyntax) -> RepeatWhileStmtSyntax {
    let data = SyntaxData(raw: .node(.repeatWhileStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      repeatKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      whileKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      condition.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return RepeatWhileStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankRepeatWhileStmt() -> RepeatWhileStmtSyntax {
    let data = SyntaxData(raw: .node(.repeatWhileStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.repeatKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.whileKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return RepeatWhileStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeGuardStmt(guardKeyword: TokenSyntax, conditions: ConditionElementListSyntax, elseKeyword: TokenSyntax, body: CodeBlockSyntax) -> GuardStmtSyntax {
    let data = SyntaxData(raw: .node(.guardStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      guardKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      conditions.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elseKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return GuardStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGuardStmt() -> GuardStmtSyntax {
    let data = SyntaxData(raw: .node(.guardStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.guardKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.conditionElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.elseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GuardStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeWhereClause(whereKeyword: TokenSyntax, guardResult: ExprSyntax) -> WhereClauseSyntax {
    let data = SyntaxData(raw: .node(.whereClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      whereKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      guardResult.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return WhereClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankWhereClause() -> WhereClauseSyntax {
    let data = SyntaxData(raw: .node(.whereClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.whereKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return WhereClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeForInStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, forKeyword: TokenSyntax, caseKeyword: TokenSyntax?, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, inKeyword: TokenSyntax, sequenceExpr: ExprSyntax, whereClause: WhereClauseSyntax?, body: CodeBlockSyntax) -> ForInStmtSyntax {
    let data = SyntaxData(raw: .node(.forInStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      forKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      caseKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      inKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      sequenceExpr.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      whereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ForInStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankForInStmt() -> ForInStmtSyntax {
    let data = SyntaxData(raw: .node(.forInStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.forKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.inKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ForInStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSwitchStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, switchKeyword: TokenSyntax, expression: ExprSyntax, leftBrace: TokenSyntax, cases: SwitchCaseListSyntax, rightBrace: TokenSyntax) -> SwitchStmtSyntax {
    let data = SyntaxData(raw: .node(.switchStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      switchKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      cases.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SwitchStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSwitchStmt() -> SwitchStmtSyntax {
    let data = SyntaxData(raw: .node(.switchStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.switchKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.switchCaseList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SwitchStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeCatchClauseList(
    _ elements: [CatchClauseSyntax]) -> CatchClauseListSyntax {
    let data = SyntaxData(raw: .node(.catchClauseList,
                                     elements.map { $0.data.raw }, .present))
    return CatchClauseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCatchClauseList() -> CatchClauseListSyntax {
    let data = SyntaxData(raw: .node(.catchClauseList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CatchClauseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDoStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, doKeyword: TokenSyntax, body: CodeBlockSyntax, catchClauses: CatchClauseListSyntax?) -> DoStmtSyntax {
    let data = SyntaxData(raw: .node(.doStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      doKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      catchClauses?.data.raw ?? RawSyntax.missing(SyntaxKind.catchClauseList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DoStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDoStmt() -> DoStmtSyntax {
    let data = SyntaxData(raw: .node(.doStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.doKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.catchClauseList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DoStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeReturnStmt(returnKeyword: TokenSyntax, expression: ExprSyntax?) -> ReturnStmtSyntax {
    let data = SyntaxData(raw: .node(.returnStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      returnKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      expression?.data.raw ?? RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ReturnStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankReturnStmt() -> ReturnStmtSyntax {
    let data = SyntaxData(raw: .node(.returnStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.returnKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ReturnStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeYieldStmt(yieldKeyword: TokenSyntax, leftParen: TokenSyntax?, expression: ExprSyntax, rightParen: TokenSyntax?, semicolon: TokenSyntax?) -> YieldStmtSyntax {
    let data = SyntaxData(raw: .node(.yieldStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      yieldKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      leftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      rightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      semicolon?.data.raw ?? RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return YieldStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankYieldStmt() -> YieldStmtSyntax {
    let data = SyntaxData(raw: .node(.yieldStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.yield),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return YieldStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeFallthroughStmt(fallthroughKeyword: TokenSyntax) -> FallthroughStmtSyntax {
    let data = SyntaxData(raw: .node(.fallthroughStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      fallthroughKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return FallthroughStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFallthroughStmt() -> FallthroughStmtSyntax {
    let data = SyntaxData(raw: .node(.fallthroughStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.fallthroughKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FallthroughStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeBreakStmt(breakKeyword: TokenSyntax, label: TokenSyntax?) -> BreakStmtSyntax {
    let data = SyntaxData(raw: .node(.breakStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      breakKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      label?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return BreakStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankBreakStmt() -> BreakStmtSyntax {
    let data = SyntaxData(raw: .node(.breakStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.breakKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return BreakStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeCaseItemList(
    _ elements: [CaseItemSyntax]) -> CaseItemListSyntax {
    let data = SyntaxData(raw: .node(.caseItemList,
                                     elements.map { $0.data.raw }, .present))
    return CaseItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCaseItemList() -> CaseItemListSyntax {
    let data = SyntaxData(raw: .node(.caseItemList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CaseItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeConditionElement(condition: Syntax, trailingComma: TokenSyntax?) -> ConditionElementSyntax {
    let data = SyntaxData(raw: .node(.conditionElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      condition.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ConditionElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankConditionElement() -> ConditionElementSyntax {
    let data = SyntaxData(raw: .node(.conditionElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ConditionElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAvailabilityCondition(poundAvailableKeyword: TokenSyntax, leftParen: TokenSyntax, availabilitySpec: AvailabilitySpecListSyntax, rightParen: TokenSyntax) -> AvailabilityConditionSyntax {
    let data = SyntaxData(raw: .node(.availabilityCondition, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      poundAvailableKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      availabilitySpec.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AvailabilityConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAvailabilityCondition() -> AvailabilityConditionSyntax {
    let data = SyntaxData(raw: .node(.availabilityCondition, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.poundAvailableKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.availabilitySpecList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AvailabilityConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeMatchingPatternCondition(caseKeyword: TokenSyntax, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax) -> MatchingPatternConditionSyntax {
    let data = SyntaxData(raw: .node(.matchingPatternCondition, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      caseKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      initializer.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return MatchingPatternConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankMatchingPatternCondition() -> MatchingPatternConditionSyntax {
    let data = SyntaxData(raw: .node(.matchingPatternCondition, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return MatchingPatternConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeOptionalBindingCondition(letOrVarKeyword: TokenSyntax, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax) -> OptionalBindingConditionSyntax {
    let data = SyntaxData(raw: .node(.optionalBindingCondition, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      letOrVarKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      initializer.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return OptionalBindingConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankOptionalBindingCondition() -> OptionalBindingConditionSyntax {
    let data = SyntaxData(raw: .node(.optionalBindingCondition, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.letKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return OptionalBindingConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeConditionElementList(
    _ elements: [ConditionElementSyntax]) -> ConditionElementListSyntax {
    let data = SyntaxData(raw: .node(.conditionElementList,
                                     elements.map { $0.data.raw }, .present))
    return ConditionElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankConditionElementList() -> ConditionElementListSyntax {
    let data = SyntaxData(raw: .node(.conditionElementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ConditionElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDeclarationStmt(declaration: DeclSyntax) -> DeclarationStmtSyntax {
    let data = SyntaxData(raw: .node(.declarationStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      declaration.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DeclarationStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDeclarationStmt() -> DeclarationStmtSyntax {
    let data = SyntaxData(raw: .node(.declarationStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.decl),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DeclarationStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeThrowStmt(throwKeyword: TokenSyntax, expression: ExprSyntax) -> ThrowStmtSyntax {
    let data = SyntaxData(raw: .node(.throwStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      throwKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ThrowStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankThrowStmt() -> ThrowStmtSyntax {
    let data = SyntaxData(raw: .node(.throwStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.throwKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ThrowStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeIfStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, ifKeyword: TokenSyntax, conditions: ConditionElementListSyntax, body: CodeBlockSyntax, elseKeyword: TokenSyntax?, elseBody: Syntax?) -> IfStmtSyntax {
    let data = SyntaxData(raw: .node(.ifStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      ifKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      conditions.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      elseKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.elseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      elseBody?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return IfStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIfStmt() -> IfStmtSyntax {
    let data = SyntaxData(raw: .node(.ifStmt, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.ifKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.conditionElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.elseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IfStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeElseIfContinuation(ifStatement: IfStmtSyntax) -> ElseIfContinuationSyntax {
    let data = SyntaxData(raw: .node(.elseIfContinuation, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      ifStatement.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ElseIfContinuationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankElseIfContinuation() -> ElseIfContinuationSyntax {
    let data = SyntaxData(raw: .node(.elseIfContinuation, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.ifStmt),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ElseIfContinuationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeElseBlock(elseKeyword: TokenSyntax, body: CodeBlockSyntax) -> ElseBlockSyntax {
    let data = SyntaxData(raw: .node(.elseBlock, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elseKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ElseBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankElseBlock() -> ElseBlockSyntax {
    let data = SyntaxData(raw: .node(.elseBlock, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.elseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ElseBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSwitchCase(unknownAttr: AttributeSyntax?, label: Syntax, statements: CodeBlockItemListSyntax) -> SwitchCaseSyntax {
    let data = SyntaxData(raw: .node(.switchCase, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      unknownAttr?.data.raw ?? RawSyntax.missing(SyntaxKind.attribute),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      label.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      statements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SwitchCaseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSwitchCase() -> SwitchCaseSyntax {
    let data = SyntaxData(raw: .node(.switchCase, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attribute),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SwitchCaseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSwitchDefaultLabel(defaultKeyword: TokenSyntax, colon: TokenSyntax) -> SwitchDefaultLabelSyntax {
    let data = SyntaxData(raw: .node(.switchDefaultLabel, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      defaultKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SwitchDefaultLabelSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSwitchDefaultLabel() -> SwitchDefaultLabelSyntax {
    let data = SyntaxData(raw: .node(.switchDefaultLabel, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.defaultKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SwitchDefaultLabelSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeCaseItem(pattern: PatternSyntax, whereClause: WhereClauseSyntax?, trailingComma: TokenSyntax?) -> CaseItemSyntax {
    let data = SyntaxData(raw: .node(.caseItem, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      whereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return CaseItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCaseItem() -> CaseItemSyntax {
    let data = SyntaxData(raw: .node(.caseItem, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CaseItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSwitchCaseLabel(caseKeyword: TokenSyntax, caseItems: CaseItemListSyntax, colon: TokenSyntax) -> SwitchCaseLabelSyntax {
    let data = SyntaxData(raw: .node(.switchCaseLabel, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      caseKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      caseItems.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SwitchCaseLabelSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSwitchCaseLabel() -> SwitchCaseLabelSyntax {
    let data = SyntaxData(raw: .node(.switchCaseLabel, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.caseItemList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SwitchCaseLabelSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeCatchClause(catchKeyword: TokenSyntax, pattern: PatternSyntax?, whereClause: WhereClauseSyntax?, body: CodeBlockSyntax) -> CatchClauseSyntax {
    let data = SyntaxData(raw: .node(.catchClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      catchKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      pattern?.data.raw ?? RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      whereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      body.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return CatchClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCatchClause() -> CatchClauseSyntax {
    let data = SyntaxData(raw: .node(.catchClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.catchKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CatchClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeGenericWhereClause(whereKeyword: TokenSyntax, requirementList: GenericRequirementListSyntax) -> GenericWhereClauseSyntax {
    let data = SyntaxData(raw: .node(.genericWhereClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      whereKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      requirementList.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return GenericWhereClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGenericWhereClause() -> GenericWhereClauseSyntax {
    let data = SyntaxData(raw: .node(.genericWhereClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.whereKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericRequirementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GenericWhereClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeGenericRequirementList(
    _ elements: [Syntax]) -> GenericRequirementListSyntax {
    let data = SyntaxData(raw: .node(.genericRequirementList,
                                     elements.map { $0.data.raw }, .present))
    return GenericRequirementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGenericRequirementList() -> GenericRequirementListSyntax {
    let data = SyntaxData(raw: .node(.genericRequirementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GenericRequirementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSameTypeRequirement(leftTypeIdentifier: TypeSyntax, equalityToken: TokenSyntax, rightTypeIdentifier: TypeSyntax, trailingComma: TokenSyntax?) -> SameTypeRequirementSyntax {
    let data = SyntaxData(raw: .node(.sameTypeRequirement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftTypeIdentifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      equalityToken.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightTypeIdentifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SameTypeRequirementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSameTypeRequirement() -> SameTypeRequirementSyntax {
    let data = SyntaxData(raw: .node(.sameTypeRequirement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.spacedBinaryOperator("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SameTypeRequirementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeGenericParameterList(
    _ elements: [GenericParameterSyntax]) -> GenericParameterListSyntax {
    let data = SyntaxData(raw: .node(.genericParameterList,
                                     elements.map { $0.data.raw }, .present))
    return GenericParameterListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGenericParameterList() -> GenericParameterListSyntax {
    let data = SyntaxData(raw: .node(.genericParameterList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GenericParameterListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeGenericParameter(attributes: AttributeListSyntax?, name: TokenSyntax, colon: TokenSyntax?, inheritedType: TypeSyntax?, trailingComma: TokenSyntax?) -> GenericParameterSyntax {
    let data = SyntaxData(raw: .node(.genericParameter, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      inheritedType?.data.raw ?? RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return GenericParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGenericParameter() -> GenericParameterSyntax {
    let data = SyntaxData(raw: .node(.genericParameter, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GenericParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeGenericParameterClause(leftAngleBracket: TokenSyntax, genericParameterList: GenericParameterListSyntax, rightAngleBracket: TokenSyntax) -> GenericParameterClauseSyntax {
    let data = SyntaxData(raw: .node(.genericParameterClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftAngleBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      genericParameterList.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightAngleBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return GenericParameterClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGenericParameterClause() -> GenericParameterClauseSyntax {
    let data = SyntaxData(raw: .node(.genericParameterClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftAngle),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericParameterList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightAngle),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GenericParameterClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeConformanceRequirement(leftTypeIdentifier: TypeSyntax, colon: TokenSyntax, rightTypeIdentifier: TypeSyntax, trailingComma: TokenSyntax?) -> ConformanceRequirementSyntax {
    let data = SyntaxData(raw: .node(.conformanceRequirement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftTypeIdentifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightTypeIdentifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ConformanceRequirementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankConformanceRequirement() -> ConformanceRequirementSyntax {
    let data = SyntaxData(raw: .node(.conformanceRequirement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ConformanceRequirementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeSimpleTypeIdentifier(name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let data = SyntaxData(raw: .node(.simpleTypeIdentifier, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericArgumentClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return SimpleTypeIdentifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankSimpleTypeIdentifier() -> SimpleTypeIdentifierSyntax {
    let data = SyntaxData(raw: .node(.simpleTypeIdentifier, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return SimpleTypeIdentifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeMemberTypeIdentifier(baseType: TypeSyntax, period: TokenSyntax, name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let data = SyntaxData(raw: .node(.memberTypeIdentifier, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      baseType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      period.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      name.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      genericArgumentClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return MemberTypeIdentifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankMemberTypeIdentifier() -> MemberTypeIdentifierSyntax {
    let data = SyntaxData(raw: .node(.memberTypeIdentifier, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return MemberTypeIdentifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeClassRestrictionType(classKeyword: TokenSyntax) -> ClassRestrictionTypeSyntax {
    let data = SyntaxData(raw: .node(.classRestrictionType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      classKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ClassRestrictionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankClassRestrictionType() -> ClassRestrictionTypeSyntax {
    let data = SyntaxData(raw: .node(.classRestrictionType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.classKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ClassRestrictionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeArrayType(leftSquareBracket: TokenSyntax, elementType: TypeSyntax, rightSquareBracket: TokenSyntax) -> ArrayTypeSyntax {
    let data = SyntaxData(raw: .node(.arrayType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftSquareBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elementType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightSquareBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ArrayTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankArrayType() -> ArrayTypeSyntax {
    let data = SyntaxData(raw: .node(.arrayType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ArrayTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeDictionaryType(leftSquareBracket: TokenSyntax, keyType: TypeSyntax, colon: TokenSyntax, valueType: TypeSyntax, rightSquareBracket: TokenSyntax) -> DictionaryTypeSyntax {
    let data = SyntaxData(raw: .node(.dictionaryType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftSquareBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      keyType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      valueType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightSquareBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return DictionaryTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankDictionaryType() -> DictionaryTypeSyntax {
    let data = SyntaxData(raw: .node(.dictionaryType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return DictionaryTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeMetatypeType(baseType: TypeSyntax, period: TokenSyntax, typeOrProtocol: TokenSyntax) -> MetatypeTypeSyntax {
    let data = SyntaxData(raw: .node(.metatypeType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      baseType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      period.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      typeOrProtocol.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return MetatypeTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankMetatypeType() -> MetatypeTypeSyntax {
    let data = SyntaxData(raw: .node(.metatypeType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return MetatypeTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeOptionalType(wrappedType: TypeSyntax, questionMark: TokenSyntax) -> OptionalTypeSyntax {
    let data = SyntaxData(raw: .node(.optionalType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      wrappedType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      questionMark.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return OptionalTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankOptionalType() -> OptionalTypeSyntax {
    let data = SyntaxData(raw: .node(.optionalType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return OptionalTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeImplicitlyUnwrappedOptionalType(wrappedType: TypeSyntax, exclamationMark: TokenSyntax) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let data = SyntaxData(raw: .node(.implicitlyUnwrappedOptionalType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      wrappedType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      exclamationMark.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let data = SyntaxData(raw: .node(.implicitlyUnwrappedOptionalType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.exclamationMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeCompositionTypeElement(type: TypeSyntax, ampersand: TokenSyntax?) -> CompositionTypeElementSyntax {
    let data = SyntaxData(raw: .node(.compositionTypeElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      type.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      ampersand?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return CompositionTypeElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCompositionTypeElement() -> CompositionTypeElementSyntax {
    let data = SyntaxData(raw: .node(.compositionTypeElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CompositionTypeElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeCompositionTypeElementList(
    _ elements: [CompositionTypeElementSyntax]) -> CompositionTypeElementListSyntax {
    let data = SyntaxData(raw: .node(.compositionTypeElementList,
                                     elements.map { $0.data.raw }, .present))
    return CompositionTypeElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCompositionTypeElementList() -> CompositionTypeElementListSyntax {
    let data = SyntaxData(raw: .node(.compositionTypeElementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CompositionTypeElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeCompositionType(elements: CompositionTypeElementListSyntax) -> CompositionTypeSyntax {
    let data = SyntaxData(raw: .node(.compositionType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return CompositionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankCompositionType() -> CompositionTypeSyntax {
    let data = SyntaxData(raw: .node(.compositionType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.compositionTypeElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return CompositionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTupleTypeElement(inOut: TokenSyntax?, name: TokenSyntax?, secondName: TokenSyntax?, colon: TokenSyntax?, type: TypeSyntax, ellipsis: TokenSyntax?, initializer: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
    let data = SyntaxData(raw: .node(.tupleTypeElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      inOut?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      name?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      secondName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      type.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      ellipsis?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      initializer?.data.raw ?? RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TupleTypeElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTupleTypeElement() -> TupleTypeElementSyntax {
    let data = SyntaxData(raw: .node(.tupleTypeElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TupleTypeElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeTupleTypeElementList(
    _ elements: [TupleTypeElementSyntax]) -> TupleTypeElementListSyntax {
    let data = SyntaxData(raw: .node(.tupleTypeElementList,
                                     elements.map { $0.data.raw }, .present))
    return TupleTypeElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTupleTypeElementList() -> TupleTypeElementListSyntax {
    let data = SyntaxData(raw: .node(.tupleTypeElementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TupleTypeElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTupleType(leftParen: TokenSyntax, elements: TupleTypeElementListSyntax, rightParen: TokenSyntax) -> TupleTypeSyntax {
    let data = SyntaxData(raw: .node(.tupleType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TupleTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTupleType() -> TupleTypeSyntax {
    let data = SyntaxData(raw: .node(.tupleType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.tupleTypeElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TupleTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeFunctionType(leftParen: TokenSyntax, arguments: TupleTypeElementListSyntax, rightParen: TokenSyntax, throwsOrRethrowsKeyword: TokenSyntax?, arrow: TokenSyntax, returnType: TypeSyntax) -> FunctionTypeSyntax {
    let data = SyntaxData(raw: .node(.functionType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      arguments.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      throwsOrRethrowsKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      arrow.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      returnType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return FunctionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankFunctionType() -> FunctionTypeSyntax {
    let data = SyntaxData(raw: .node(.functionType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.tupleTypeElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.arrow),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return FunctionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAttributedType(specifier: TokenSyntax?, attributes: AttributeListSyntax?, baseType: TypeSyntax) -> AttributedTypeSyntax {
    let data = SyntaxData(raw: .node(.attributedType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      specifier?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      baseType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AttributedTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAttributedType() -> AttributedTypeSyntax {
    let data = SyntaxData(raw: .node(.attributedType, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AttributedTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeGenericArgumentList(
    _ elements: [GenericArgumentSyntax]) -> GenericArgumentListSyntax {
    let data = SyntaxData(raw: .node(.genericArgumentList,
                                     elements.map { $0.data.raw }, .present))
    return GenericArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGenericArgumentList() -> GenericArgumentListSyntax {
    let data = SyntaxData(raw: .node(.genericArgumentList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GenericArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeGenericArgument(argumentType: TypeSyntax, trailingComma: TokenSyntax?) -> GenericArgumentSyntax {
    let data = SyntaxData(raw: .node(.genericArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      argumentType.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return GenericArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGenericArgument() -> GenericArgumentSyntax {
    let data = SyntaxData(raw: .node(.genericArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GenericArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeGenericArgumentClause(leftAngleBracket: TokenSyntax, arguments: GenericArgumentListSyntax, rightAngleBracket: TokenSyntax) -> GenericArgumentClauseSyntax {
    let data = SyntaxData(raw: .node(.genericArgumentClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftAngleBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      arguments.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightAngleBracket.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return GenericArgumentClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankGenericArgumentClause() -> GenericArgumentClauseSyntax {
    let data = SyntaxData(raw: .node(.genericArgumentClause, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftAngle),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.genericArgumentList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightAngle),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return GenericArgumentClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTypeAnnotation(colon: TokenSyntax, type: TypeSyntax) -> TypeAnnotationSyntax {
    let data = SyntaxData(raw: .node(.typeAnnotation, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      type.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TypeAnnotationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTypeAnnotation() -> TypeAnnotationSyntax {
    let data = SyntaxData(raw: .node(.typeAnnotation, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TypeAnnotationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeEnumCasePattern(type: TypeSyntax?, period: TokenSyntax, caseName: TokenSyntax, associatedTuple: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let data = SyntaxData(raw: .node(.enumCasePattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      type?.data.raw ?? RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      period.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      caseName.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      associatedTuple?.data.raw ?? RawSyntax.missing(SyntaxKind.tuplePattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return EnumCasePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankEnumCasePattern() -> EnumCasePatternSyntax {
    let data = SyntaxData(raw: .node(.enumCasePattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.tuplePattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return EnumCasePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeIsTypePattern(isKeyword: TokenSyntax, type: TypeSyntax) -> IsTypePatternSyntax {
    let data = SyntaxData(raw: .node(.isTypePattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      isKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      type.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return IsTypePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIsTypePattern() -> IsTypePatternSyntax {
    let data = SyntaxData(raw: .node(.isTypePattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.isKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IsTypePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeOptionalPattern(subPattern: PatternSyntax, questionMark: TokenSyntax) -> OptionalPatternSyntax {
    let data = SyntaxData(raw: .node(.optionalPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      subPattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      questionMark.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return OptionalPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankOptionalPattern() -> OptionalPatternSyntax {
    let data = SyntaxData(raw: .node(.optionalPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return OptionalPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeIdentifierPattern(identifier: TokenSyntax) -> IdentifierPatternSyntax {
    let data = SyntaxData(raw: .node(.identifierPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return IdentifierPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankIdentifierPattern() -> IdentifierPatternSyntax {
    let data = SyntaxData(raw: .node(.identifierPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return IdentifierPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAsTypePattern(pattern: PatternSyntax, asKeyword: TokenSyntax, type: TypeSyntax) -> AsTypePatternSyntax {
    let data = SyntaxData(raw: .node(.asTypePattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      asKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      type.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AsTypePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAsTypePattern() -> AsTypePatternSyntax {
    let data = SyntaxData(raw: .node(.asTypePattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.asKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AsTypePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTuplePattern(leftParen: TokenSyntax, elements: TuplePatternElementListSyntax, rightParen: TokenSyntax) -> TuplePatternSyntax {
    let data = SyntaxData(raw: .node(.tuplePattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      elements.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TuplePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTuplePattern() -> TuplePatternSyntax {
    let data = SyntaxData(raw: .node(.tuplePattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.tuplePatternElementList),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TuplePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeWildcardPattern(wildcard: TokenSyntax, typeAnnotation: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let data = SyntaxData(raw: .node(.wildcardPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      wildcard.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return WildcardPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankWildcardPattern() -> WildcardPatternSyntax {
    let data = SyntaxData(raw: .node(.wildcardPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.wildcardKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return WildcardPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeTuplePatternElement(labelName: TokenSyntax?, labelColon: TokenSyntax?, pattern: PatternSyntax, trailingComma: TokenSyntax?) -> TuplePatternElementSyntax {
    let data = SyntaxData(raw: .node(.tuplePatternElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return TuplePatternElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTuplePatternElement() -> TuplePatternElementSyntax {
    let data = SyntaxData(raw: .node(.tuplePatternElement, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TuplePatternElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeExpressionPattern(expression: ExprSyntax) -> ExpressionPatternSyntax {
    let data = SyntaxData(raw: .node(.expressionPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      expression.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ExpressionPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankExpressionPattern() -> ExpressionPatternSyntax {
    let data = SyntaxData(raw: .node(.expressionPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ExpressionPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeTuplePatternElementList(
    _ elements: [TuplePatternElementSyntax]) -> TuplePatternElementListSyntax {
    let data = SyntaxData(raw: .node(.tuplePatternElementList,
                                     elements.map { $0.data.raw }, .present))
    return TuplePatternElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankTuplePatternElementList() -> TuplePatternElementListSyntax {
    let data = SyntaxData(raw: .node(.tuplePatternElementList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return TuplePatternElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeValueBindingPattern(letOrVarKeyword: TokenSyntax, valuePattern: PatternSyntax) -> ValueBindingPatternSyntax {
    let data = SyntaxData(raw: .node(.valueBindingPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      letOrVarKeyword.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      valuePattern.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return ValueBindingPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankValueBindingPattern() -> ValueBindingPatternSyntax {
    let data = SyntaxData(raw: .node(.valueBindingPattern, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.letKeyword),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return ValueBindingPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 72)
  public static func makeAvailabilitySpecList(
    _ elements: [AvailabilityArgumentSyntax]) -> AvailabilitySpecListSyntax {
    let data = SyntaxData(raw: .node(.availabilitySpecList,
                                     elements.map { $0.data.raw }, .present))
    return AvailabilitySpecListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAvailabilitySpecList() -> AvailabilitySpecListSyntax {
    let data = SyntaxData(raw: .node(.availabilitySpecList, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AvailabilitySpecListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAvailabilityArgument(entry: Syntax, trailingComma: TokenSyntax?) -> AvailabilityArgumentSyntax {
    let data = SyntaxData(raw: .node(.availabilityArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      entry.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AvailabilityArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAvailabilityArgument() -> AvailabilityArgumentSyntax {
    let data = SyntaxData(raw: .node(.availabilityArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AvailabilityArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAvailabilityLabeledArgument(label: TokenSyntax, colon: TokenSyntax, value: Syntax) -> AvailabilityLabeledArgumentSyntax {
    let data = SyntaxData(raw: .node(.availabilityLabeledArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      label.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      colon.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      value.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AvailabilityLabeledArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAvailabilityLabeledArgument() -> AvailabilityLabeledArgumentSyntax {
    let data = SyntaxData(raw: .node(.availabilityLabeledArgument, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AvailabilityLabeledArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeAvailabilityVersionRestriction(platform: TokenSyntax, version: VersionTupleSyntax) -> AvailabilityVersionRestrictionSyntax {
    let data = SyntaxData(raw: .node(.availabilityVersionRestriction, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      platform.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      version.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return AvailabilityVersionRestrictionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankAvailabilityVersionRestriction() -> AvailabilityVersionRestrictionSyntax {
    let data = SyntaxData(raw: .node(.availabilityVersionRestriction, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.versionTuple),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return AvailabilityVersionRestrictionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 59)
  public static func makeVersionTuple(majorMinor: Syntax, patchPeriod: TokenSyntax?, patchVersion: TokenSyntax?) -> VersionTupleSyntax {
    let data = SyntaxData(raw: .node(.versionTuple, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 65)
      majorMinor.data.raw,
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      patchPeriod?.data.raw ?? RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 63)
      patchVersion?.data.raw ?? RawSyntax.missingToken(TokenKind.integerLiteral("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 68)
    ], .present))
    return VersionTupleSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 79)

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 81)
  public static func makeBlankVersionTuple() -> VersionTupleSyntax {
    let data = SyntaxData(raw: .node(.versionTuple, [
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 84)
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 86)
    ], .present))
    return VersionTupleSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)

/// MARK: Token Creation APIs

// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeAssociatedtypeKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.associatedtypeKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeClassKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.classKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeDeinitKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.deinitKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeEnumKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.enumKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeExtensionKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.extensionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeFuncKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.funcKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeImportKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.importKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeInitKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.initKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeInoutKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.inoutKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeLetKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.letKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeOperatorKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.operatorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePrecedencegroupKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.precedencegroupKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeProtocolKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.protocolKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeStructKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.structKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeSubscriptKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.subscriptKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeTypealiasKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.typealiasKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeVarKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.varKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeFileprivateKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.fileprivateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeInternalKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.internalKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePrivateKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.privateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePublicKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.publicKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeStaticKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.staticKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeDeferKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.deferKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeIfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.ifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeGuardKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.guardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeDoKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.doKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeRepeatKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.repeatKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeElseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.elseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeForKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.forKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeInKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.inKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeWhileKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.whileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeReturnKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.returnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeBreakKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.breakKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeContinueKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.continueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeFallthroughKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.fallthroughKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeSwitchKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.switchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeCaseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.caseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeDefaultKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.defaultKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeWhereKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.whereKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeCatchKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.catchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeThrowKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.throwKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeAsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.asKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeAnyKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.anyKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeFalseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.falseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeIsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.isKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeNilKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.nilKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeRethrowsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rethrowsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeSuperKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.superKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeSelfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.selfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeCapitalSelfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.capitalSelfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeTrueKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.trueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeTryKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.tryKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeThrowsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.throwsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func make__FILE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__file__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func make__LINE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__line__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func make__COLUMN__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__column__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func make__FUNCTION__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__function__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func make__DSO_HANDLE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__dso_handle__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makeWildcardKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.wildcardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeLeftParenToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeRightParenToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeLeftBraceToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeRightBraceToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeLeftSquareBracketToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeRightSquareBracketToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeLeftAngleToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeRightAngleToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePeriodToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.period, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePrefixPeriodToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.prefixPeriod, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeCommaToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.comma, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeColonToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.colon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeSemicolonToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.semicolon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeEqualToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.equal, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeAtSignToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.atSign, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.pound, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePrefixAmpersandToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.prefixAmpersand, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeArrowToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.arrow, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeBacktickToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.backtick, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeBackslashToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.backslash, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeExclamationMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.exclamationMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePostfixQuestionMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.postfixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeInfixQuestionMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.infixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeStringQuoteToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeMultilineStringQuoteToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.multilineStringQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundKeyPathKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundKeyPathKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundLineKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundLineKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundSelectorKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundSelectorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundFileKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundFileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundColumnKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundColumnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundFunctionKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundFunctionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundDsohandleKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundDsohandleKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundSourceLocationKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundSourceLocationKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundWarningKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundWarningKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundErrorKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundErrorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundIfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundIfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundElseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundElseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundElseifKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundElseifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundEndifKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundEndifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundAvailableKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundAvailableKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundFileLiteralKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundFileLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundImageLiteralKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundImageLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 96)
  public static func makePoundColorLiteralKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundColorLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeIntegerLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.integerLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeFloatingLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.floatingLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeStringLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeUnknown(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.unknown(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeIdentifier(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.identifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeUnspacedBinaryOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.unspacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeSpacedBinaryOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makePostfixOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.postfixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makePrefixOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.prefixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeDollarIdentifier(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.dollarIdentifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeContextualKeyword(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.contextualKeyword(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeStringSegment(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringSegment(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeStringInterpolationAnchorToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringInterpolationAnchor, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeYieldToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.yield, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/alex/Documents/swift-src/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 118)

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
    return makeSimpleTypeIdentifier(name: identifier,
                                    genericArgumentClause: nil)
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

  public static func makeEqualityOperator(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator("=="),
                     presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }

  public static func makeStringLiteralExpr(_ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> StringLiteralExprSyntax {
    let literal = makeStringLiteral("\"\(text)\"", 
                                    leadingTrivia: leadingTrivia,
                                    trailingTrivia: trailingTrivia)
    return makeStringLiteralExpr(stringLiteral: literal)
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
