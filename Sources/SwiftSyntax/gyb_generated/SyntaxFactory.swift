// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 6)
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
    let raw = RawSyntax(kind: kind, leadingTrivia: leadingTrivia,
                        trailingTrivia: trailingTrivia, presence: presence)
    let data = SyntaxData(raw: raw)
    return TokenSyntax(root: data, data: data)
  }

  public static func makeUnknownSyntax(tokens: [TokenSyntax]) -> Syntax {
    let raw = RawSyntax(kind: .unknown, layout: tokens.map { $0.data.raw },
                        presence: .present)
    let data = SyntaxData(raw: raw)
    return UnknownSyntax(root: data, data: data)
  }

/// MARK: Syntax Node Creation APIs

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankUnknownDecl() -> UnknownDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .unknownDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return UnknownDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankUnknownExpr() -> UnknownExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .unknownExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return UnknownExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankUnknownStmt() -> UnknownStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .unknownStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return UnknownStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankUnknownType() -> UnknownTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .unknownType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return UnknownTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankUnknownPattern() -> UnknownPatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .unknownPattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return UnknownPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeCodeBlockItem(item: Syntax, semicolon: TokenSyntax?, errorTokens: Syntax?) -> CodeBlockItemSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      item.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      semicolon?.data.raw ?? RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      errorTokens?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.codeBlockItem,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CodeBlockItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCodeBlockItem() -> CodeBlockItemSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .codeBlockItem,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CodeBlockItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeCodeBlockItemList(
    _ elements: [CodeBlockItemSyntax]) -> CodeBlockItemListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.codeBlockItemList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CodeBlockItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCodeBlockItemList() -> CodeBlockItemListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .codeBlockItemList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CodeBlockItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeCodeBlock(leftBrace: TokenSyntax, statements: CodeBlockItemListSyntax, rightBrace: TokenSyntax) -> CodeBlockSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      statements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.codeBlock,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CodeBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCodeBlock() -> CodeBlockSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .codeBlock,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CodeBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeInOutExpr(ampersand: TokenSyntax, expression: ExprSyntax) -> InOutExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      ampersand.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.inOutExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return InOutExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankInOutExpr() -> InOutExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .inOutExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.prefixAmpersand),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return InOutExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundColumnExpr(poundColumn: TokenSyntax) -> PoundColumnExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundColumn.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundColumnExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundColumnExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundColumnExpr() -> PoundColumnExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundColumnExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundColumnKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundColumnExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeFunctionCallArgumentList(
    _ elements: [FunctionCallArgumentSyntax]) -> FunctionCallArgumentListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.functionCallArgumentList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FunctionCallArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFunctionCallArgumentList() -> FunctionCallArgumentListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .functionCallArgumentList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FunctionCallArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeTupleElementList(
    _ elements: [TupleElementSyntax]) -> TupleElementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.tupleElementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TupleElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTupleElementList() -> TupleElementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tupleElementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TupleElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeArrayElementList(
    _ elements: [ArrayElementSyntax]) -> ArrayElementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.arrayElementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ArrayElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankArrayElementList() -> ArrayElementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .arrayElementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ArrayElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeDictionaryElementList(
    _ elements: [DictionaryElementSyntax]) -> DictionaryElementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.dictionaryElementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DictionaryElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDictionaryElementList() -> DictionaryElementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .dictionaryElementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DictionaryElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeStringInterpolationSegments(
    _ elements: [Syntax]) -> StringInterpolationSegmentsSyntax {
    let raw = RawSyntax(kind: SyntaxKind.stringInterpolationSegments,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return StringInterpolationSegmentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankStringInterpolationSegments() -> StringInterpolationSegmentsSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .stringInterpolationSegments,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return StringInterpolationSegmentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTryExpr(tryKeyword: TokenSyntax, questionOrExclamationMark: TokenSyntax?, expression: ExprSyntax) -> TryExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      tryKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      questionOrExclamationMark?.data.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.tryExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTryExpr() -> TryExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tryExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.tryKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDeclNameArgument(name: TokenSyntax, colon: TokenSyntax) -> DeclNameArgumentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.declNameArgument,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DeclNameArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDeclNameArgument() -> DeclNameArgumentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .declNameArgument,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DeclNameArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeDeclNameArgumentList(
    _ elements: [DeclNameArgumentSyntax]) -> DeclNameArgumentListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.declNameArgumentList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DeclNameArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDeclNameArgumentList() -> DeclNameArgumentListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .declNameArgumentList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DeclNameArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDeclNameArguments(leftParen: TokenSyntax, arguments: DeclNameArgumentListSyntax, rightParen: TokenSyntax) -> DeclNameArgumentsSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      arguments.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.declNameArguments,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DeclNameArgumentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDeclNameArguments() -> DeclNameArgumentsSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .declNameArguments,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.declNameArgumentList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DeclNameArgumentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeIdentifierExpr(identifier: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?) -> IdentifierExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.identifierExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IdentifierExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIdentifierExpr() -> IdentifierExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .identifierExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IdentifierExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSuperRefExpr(superKeyword: TokenSyntax) -> SuperRefExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      superKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.superRefExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SuperRefExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSuperRefExpr() -> SuperRefExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .superRefExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.superKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SuperRefExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeNilLiteralExpr(nilKeyword: TokenSyntax) -> NilLiteralExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      nilKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.nilLiteralExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return NilLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankNilLiteralExpr() -> NilLiteralExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .nilLiteralExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.nilKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return NilLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDiscardAssignmentExpr(wildcard: TokenSyntax) -> DiscardAssignmentExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      wildcard.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.discardAssignmentExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DiscardAssignmentExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDiscardAssignmentExpr() -> DiscardAssignmentExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .discardAssignmentExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.wildcardKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DiscardAssignmentExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAssignmentExpr(assignToken: TokenSyntax) -> AssignmentExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      assignToken.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.assignmentExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AssignmentExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAssignmentExpr() -> AssignmentExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .assignmentExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AssignmentExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSequenceExpr(elements: ExprListSyntax) -> SequenceExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.sequenceExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SequenceExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSequenceExpr() -> SequenceExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .sequenceExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.exprList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SequenceExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeExprList(
    _ elements: [ExprSyntax]) -> ExprListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.exprList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ExprListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankExprList() -> ExprListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .exprList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ExprListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundLineExpr(poundLine: TokenSyntax) -> PoundLineExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundLine.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundLineExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundLineExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundLineExpr() -> PoundLineExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundLineExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundLineKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundLineExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundFileExpr(poundFile: TokenSyntax) -> PoundFileExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundFile.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundFileExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundFileExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundFileExpr() -> PoundFileExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundFileExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundFileKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundFileExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundFunctionExpr(poundFunction: TokenSyntax) -> PoundFunctionExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundFunction.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundFunctionExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundFunctionExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundFunctionExpr() -> PoundFunctionExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundFunctionExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundFunctionKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundFunctionExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundDsohandleExpr(poundDsohandle: TokenSyntax) -> PoundDsohandleExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundDsohandle.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundDsohandleExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundDsohandleExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundDsohandleExpr() -> PoundDsohandleExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundDsohandleExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundDsohandleKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundDsohandleExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSymbolicReferenceExpr(identifier: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericArgumentClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.symbolicReferenceExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SymbolicReferenceExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSymbolicReferenceExpr() -> SymbolicReferenceExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .symbolicReferenceExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SymbolicReferenceExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePrefixOperatorExpr(operatorToken: TokenSyntax?, postfixExpression: ExprSyntax) -> PrefixOperatorExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      operatorToken?.data.raw ?? RawSyntax.missingToken(TokenKind.prefixOperator("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      postfixExpression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.prefixOperatorExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PrefixOperatorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPrefixOperatorExpr() -> PrefixOperatorExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .prefixOperatorExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.prefixOperator("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PrefixOperatorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeBinaryOperatorExpr(operatorToken: TokenSyntax) -> BinaryOperatorExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      operatorToken.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.binaryOperatorExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return BinaryOperatorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankBinaryOperatorExpr() -> BinaryOperatorExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .binaryOperatorExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return BinaryOperatorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeArrowExpr(throwsToken: TokenSyntax?, arrowToken: TokenSyntax) -> ArrowExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      throwsToken?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      arrowToken.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.arrowExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ArrowExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankArrowExpr() -> ArrowExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .arrowExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.arrow),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ArrowExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeFloatLiteralExpr(floatingDigits: TokenSyntax) -> FloatLiteralExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      floatingDigits.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.floatLiteralExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FloatLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFloatLiteralExpr() -> FloatLiteralExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .floatLiteralExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.floatingLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FloatLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTupleExpr(leftParen: TokenSyntax, elementList: TupleElementListSyntax, rightParen: TokenSyntax) -> TupleExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elementList.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.tupleExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TupleExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTupleExpr() -> TupleExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tupleExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.tupleElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TupleExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeArrayExpr(leftSquare: TokenSyntax, elements: ArrayElementListSyntax, rightSquare: TokenSyntax) -> ArrayExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftSquare.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightSquare.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.arrayExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ArrayExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankArrayExpr() -> ArrayExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .arrayExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.arrayElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ArrayExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDictionaryExpr(leftSquare: TokenSyntax, content: Syntax, rightSquare: TokenSyntax) -> DictionaryExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftSquare.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      content.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightSquare.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.dictionaryExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DictionaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDictionaryExpr() -> DictionaryExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .dictionaryExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DictionaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeImplicitMemberExpr(dot: TokenSyntax, name: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?) -> ImplicitMemberExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      dot.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.implicitMemberExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ImplicitMemberExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankImplicitMemberExpr() -> ImplicitMemberExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .implicitMemberExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.prefixPeriod),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ImplicitMemberExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeFunctionCallArgument(label: TokenSyntax?, colon: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      label?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.functionCallArgument,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FunctionCallArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFunctionCallArgument() -> FunctionCallArgumentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .functionCallArgument,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FunctionCallArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTupleElement(label: TokenSyntax?, colon: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> TupleElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      label?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.tupleElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TupleElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTupleElement() -> TupleElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tupleElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TupleElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeArrayElement(expression: ExprSyntax, trailingComma: TokenSyntax?) -> ArrayElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.arrayElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ArrayElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankArrayElement() -> ArrayElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .arrayElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ArrayElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDictionaryElement(keyExpression: ExprSyntax, colon: TokenSyntax, valueExpression: ExprSyntax, trailingComma: TokenSyntax?) -> DictionaryElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      keyExpression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      valueExpression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.dictionaryElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DictionaryElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDictionaryElement() -> DictionaryElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .dictionaryElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DictionaryElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeIntegerLiteralExpr(digits: TokenSyntax) -> IntegerLiteralExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      digits.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.integerLiteralExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IntegerLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIntegerLiteralExpr() -> IntegerLiteralExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .integerLiteralExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IntegerLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeStringLiteralExpr(stringLiteral: TokenSyntax) -> StringLiteralExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      stringLiteral.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.stringLiteralExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return StringLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankStringLiteralExpr() -> StringLiteralExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .stringLiteralExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.stringLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return StringLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeBooleanLiteralExpr(booleanLiteral: TokenSyntax) -> BooleanLiteralExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      booleanLiteral.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.booleanLiteralExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return BooleanLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankBooleanLiteralExpr() -> BooleanLiteralExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .booleanLiteralExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.trueKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return BooleanLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTernaryExpr(conditionExpression: ExprSyntax, questionMark: TokenSyntax, firstChoice: ExprSyntax, colonMark: TokenSyntax, secondChoice: ExprSyntax) -> TernaryExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      conditionExpression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      questionMark.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      firstChoice.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colonMark.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      secondChoice.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.ternaryExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TernaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTernaryExpr() -> TernaryExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .ternaryExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.infixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TernaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeMemberAccessExpr(base: ExprSyntax?, dot: TokenSyntax, name: TokenSyntax, declNameArguments: DeclNameArgumentsSyntax?) -> MemberAccessExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      base?.data.raw ?? RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      dot.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.memberAccessExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return MemberAccessExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankMemberAccessExpr() -> MemberAccessExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .memberAccessExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return MemberAccessExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDotSelfExpr(expression: ExprSyntax, dot: TokenSyntax, selfKeyword: TokenSyntax) -> DotSelfExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      dot.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      selfKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.dotSelfExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DotSelfExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDotSelfExpr() -> DotSelfExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .dotSelfExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.selfKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DotSelfExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeIsExpr(isTok: TokenSyntax, typeName: TypeSyntax) -> IsExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      isTok.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      typeName.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.isExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IsExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIsExpr() -> IsExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .isExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.isKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IsExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAsExpr(asTok: TokenSyntax, questionOrExclamationMark: TokenSyntax?, typeName: TypeSyntax) -> AsExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      asTok.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      questionOrExclamationMark?.data.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      typeName.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.asExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AsExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAsExpr() -> AsExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .asExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.asKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AsExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTypeExpr(type: TypeSyntax) -> TypeExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      type.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.typeExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TypeExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTypeExpr() -> TypeExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .typeExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TypeExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeClosureCaptureItem(specifier: TokenListSyntax?, name: TokenSyntax?, assignToken: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> ClosureCaptureItemSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      specifier?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      name?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      assignToken?.data.raw ?? RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.closureCaptureItem,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClosureCaptureItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClosureCaptureItem() -> ClosureCaptureItemSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .closureCaptureItem,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClosureCaptureItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeClosureCaptureItemList(
    _ elements: [ClosureCaptureItemSyntax]) -> ClosureCaptureItemListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.closureCaptureItemList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClosureCaptureItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClosureCaptureItemList() -> ClosureCaptureItemListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .closureCaptureItemList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClosureCaptureItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeClosureCaptureSignature(leftSquare: TokenSyntax, items: ClosureCaptureItemListSyntax?, rightSquare: TokenSyntax) -> ClosureCaptureSignatureSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftSquare.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      items?.data.raw ?? RawSyntax.missing(SyntaxKind.closureCaptureItemList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightSquare.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.closureCaptureSignature,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClosureCaptureSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClosureCaptureSignature() -> ClosureCaptureSignatureSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .closureCaptureSignature,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.closureCaptureItemList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClosureCaptureSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeClosureParam(name: TokenSyntax, trailingComma: TokenSyntax?) -> ClosureParamSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.closureParam,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClosureParamSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClosureParam() -> ClosureParamSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .closureParam,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClosureParamSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeClosureParamList(
    _ elements: [ClosureParamSyntax]) -> ClosureParamListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.closureParamList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClosureParamListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClosureParamList() -> ClosureParamListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .closureParamList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClosureParamListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeClosureSignature(capture: ClosureCaptureSignatureSyntax?, input: Syntax?, throwsTok: TokenSyntax?, output: ReturnClauseSyntax?, inTok: TokenSyntax) -> ClosureSignatureSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      capture?.data.raw ?? RawSyntax.missing(SyntaxKind.closureCaptureSignature),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      input?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      throwsTok?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      output?.data.raw ?? RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      inTok.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.closureSignature,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClosureSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClosureSignature() -> ClosureSignatureSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .closureSignature,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.closureCaptureSignature),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.inKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClosureSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeClosureExpr(leftBrace: TokenSyntax, signature: ClosureSignatureSyntax?, statements: CodeBlockItemListSyntax, rightBrace: TokenSyntax) -> ClosureExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      signature?.data.raw ?? RawSyntax.missing(SyntaxKind.closureSignature),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      statements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.closureExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClosureExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClosureExpr() -> ClosureExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .closureExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.closureSignature),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClosureExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeUnresolvedPatternExpr(pattern: PatternSyntax) -> UnresolvedPatternExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.unresolvedPatternExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return UnresolvedPatternExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankUnresolvedPatternExpr() -> UnresolvedPatternExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .unresolvedPatternExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return UnresolvedPatternExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeFunctionCallExpr(calledExpression: ExprSyntax, leftParen: TokenSyntax?, argumentList: FunctionCallArgumentListSyntax, rightParen: TokenSyntax?, trailingClosure: ClosureExprSyntax?) -> FunctionCallExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      calledExpression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      leftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      argumentList.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      rightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingClosure?.data.raw ?? RawSyntax.missing(SyntaxKind.closureExpr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.functionCallExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FunctionCallExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFunctionCallExpr() -> FunctionCallExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .functionCallExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.functionCallArgumentList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.closureExpr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FunctionCallExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSubscriptExpr(calledExpression: ExprSyntax, leftBracket: TokenSyntax, argumentList: FunctionCallArgumentListSyntax, rightBracket: TokenSyntax, trailingClosure: ClosureExprSyntax?) -> SubscriptExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      calledExpression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      argumentList.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingClosure?.data.raw ?? RawSyntax.missing(SyntaxKind.closureExpr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.subscriptExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SubscriptExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSubscriptExpr() -> SubscriptExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .subscriptExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.functionCallArgumentList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.closureExpr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SubscriptExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeOptionalChainingExpr(expression: ExprSyntax, questionMark: TokenSyntax) -> OptionalChainingExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      questionMark.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.optionalChainingExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return OptionalChainingExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankOptionalChainingExpr() -> OptionalChainingExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .optionalChainingExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return OptionalChainingExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeForcedValueExpr(expression: ExprSyntax, exclamationMark: TokenSyntax) -> ForcedValueExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      exclamationMark.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.forcedValueExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ForcedValueExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankForcedValueExpr() -> ForcedValueExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .forcedValueExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.exclamationMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ForcedValueExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePostfixUnaryExpr(expression: ExprSyntax, operatorToken: TokenSyntax) -> PostfixUnaryExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      operatorToken.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.postfixUnaryExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PostfixUnaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPostfixUnaryExpr() -> PostfixUnaryExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .postfixUnaryExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.postfixOperator("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PostfixUnaryExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSpecializeExpr(expression: ExprSyntax, genericArgumentClause: GenericArgumentClauseSyntax) -> SpecializeExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      genericArgumentClause.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.specializeExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SpecializeExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSpecializeExpr() -> SpecializeExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .specializeExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SpecializeExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeStringSegment(content: TokenSyntax) -> StringSegmentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      content.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.stringSegment,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return StringSegmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankStringSegment() -> StringSegmentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .stringSegment,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.stringSegment("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return StringSegmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeExpressionSegment(backslash: TokenSyntax, leftParen: TokenSyntax, expression: ExprSyntax, rightParen: TokenSyntax) -> ExpressionSegmentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      backslash.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.expressionSegment,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ExpressionSegmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankExpressionSegment() -> ExpressionSegmentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .expressionSegment,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.backslash),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.stringInterpolationAnchor),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ExpressionSegmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeStringInterpolationExpr(openQuote: TokenSyntax, segments: StringInterpolationSegmentsSyntax, closeQuote: TokenSyntax) -> StringInterpolationExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      openQuote.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      segments.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      closeQuote.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.stringInterpolationExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return StringInterpolationExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankStringInterpolationExpr() -> StringInterpolationExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .stringInterpolationExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.stringQuote),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.stringInterpolationSegments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.stringQuote),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return StringInterpolationExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeKeyPathExpr(backslash: TokenSyntax, rootExpr: ExprSyntax?, expression: ExprSyntax) -> KeyPathExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      backslash.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      rootExpr?.data.raw ?? RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.keyPathExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return KeyPathExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankKeyPathExpr() -> KeyPathExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .keyPathExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.backslash),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return KeyPathExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeKeyPathBaseExpr(period: TokenSyntax) -> KeyPathBaseExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      period.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.keyPathBaseExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return KeyPathBaseExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankKeyPathBaseExpr() -> KeyPathBaseExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .keyPathBaseExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return KeyPathBaseExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeObjcNamePiece(name: TokenSyntax, dot: TokenSyntax?) -> ObjcNamePieceSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      dot?.data.raw ?? RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.objcNamePiece,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ObjcNamePieceSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankObjcNamePiece() -> ObjcNamePieceSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .objcNamePiece,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ObjcNamePieceSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeObjcName(
    _ elements: [ObjcNamePieceSyntax]) -> ObjcNameSyntax {
    let raw = RawSyntax(kind: SyntaxKind.objcName,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ObjcNameSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankObjcName() -> ObjcNameSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .objcName,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ObjcNameSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeObjcKeyPathExpr(keyPath: TokenSyntax, leftParen: TokenSyntax, name: ObjcNameSyntax, rightParen: TokenSyntax) -> ObjcKeyPathExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      keyPath.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.objcKeyPathExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ObjcKeyPathExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankObjcKeyPathExpr() -> ObjcKeyPathExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .objcKeyPathExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundKeyPathKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.objcName),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ObjcKeyPathExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeObjcSelectorExpr(poundSelector: TokenSyntax, leftParen: TokenSyntax, kind: TokenSyntax?, colon: TokenSyntax?, name: ExprSyntax, rightParen: TokenSyntax) -> ObjcSelectorExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundSelector.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      kind?.data.raw ?? RawSyntax.missingToken(TokenKind.contextualKeyword("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.objcSelectorExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ObjcSelectorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankObjcSelectorExpr() -> ObjcSelectorExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .objcSelectorExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundSelectorKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.contextualKeyword("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ObjcSelectorExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeEditorPlaceholderExpr(identifier: TokenSyntax) -> EditorPlaceholderExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.editorPlaceholderExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return EditorPlaceholderExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankEditorPlaceholderExpr() -> EditorPlaceholderExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .editorPlaceholderExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return EditorPlaceholderExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeObjectLiteralExpr(identifier: TokenSyntax, leftParen: TokenSyntax, arguments: FunctionCallArgumentListSyntax, rightParen: TokenSyntax) -> ObjectLiteralExprSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      arguments.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.objectLiteralExpr,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ObjectLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankObjectLiteralExpr() -> ObjectLiteralExprSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .objectLiteralExpr,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundColorLiteralKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.functionCallArgumentList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ObjectLiteralExprSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTypeInitializerClause(equal: TokenSyntax, value: TypeSyntax) -> TypeInitializerClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      equal.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      value.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.typeInitializerClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TypeInitializerClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTypeInitializerClause() -> TypeInitializerClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .typeInitializerClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TypeInitializerClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTypealiasDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, typealiasKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, initializer: TypeInitializerClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?) -> TypealiasDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      typealiasKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      initializer?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInitializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.typealiasDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TypealiasDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTypealiasDecl() -> TypealiasDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .typealiasDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.typealiasKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeInitializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TypealiasDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAssociatedtypeDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, associatedtypeKeyword: TokenSyntax, identifier: TokenSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, initializer: TypeInitializerClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      associatedtypeKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      initializer?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInitializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.associatedtypeDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AssociatedtypeDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAssociatedtypeDecl() -> AssociatedtypeDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .associatedtypeDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.associatedtypeKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeInitializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AssociatedtypeDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeFunctionParameterList(
    _ elements: [FunctionParameterSyntax]) -> FunctionParameterListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.functionParameterList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FunctionParameterListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFunctionParameterList() -> FunctionParameterListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .functionParameterList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FunctionParameterListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeParameterClause(leftParen: TokenSyntax, parameterList: FunctionParameterListSyntax, rightParen: TokenSyntax) -> ParameterClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      parameterList.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.parameterClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ParameterClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankParameterClause() -> ParameterClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .parameterClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.functionParameterList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ParameterClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeReturnClause(arrow: TokenSyntax, returnType: TypeSyntax) -> ReturnClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      arrow.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      returnType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.returnClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ReturnClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankReturnClause() -> ReturnClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .returnClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.arrow),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ReturnClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeFunctionSignature(input: ParameterClauseSyntax, throwsOrRethrowsKeyword: TokenSyntax?, output: ReturnClauseSyntax?) -> FunctionSignatureSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      input.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      throwsOrRethrowsKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      output?.data.raw ?? RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.functionSignature,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FunctionSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFunctionSignature() -> FunctionSignatureSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .functionSignature,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FunctionSignatureSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeIfConfigClause(poundKeyword: TokenSyntax, condition: ExprSyntax?, elements: Syntax) -> IfConfigClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      condition?.data.raw ?? RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.ifConfigClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IfConfigClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIfConfigClause() -> IfConfigClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .ifConfigClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundIfKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IfConfigClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeIfConfigClauseList(
    _ elements: [IfConfigClauseSyntax]) -> IfConfigClauseListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.ifConfigClauseList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IfConfigClauseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIfConfigClauseList() -> IfConfigClauseListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .ifConfigClauseList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IfConfigClauseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeIfConfigDecl(clauses: IfConfigClauseListSyntax, poundEndif: TokenSyntax) -> IfConfigDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      clauses.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundEndif.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.ifConfigDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IfConfigDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIfConfigDecl() -> IfConfigDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .ifConfigDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.ifConfigClauseList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundEndifKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IfConfigDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundErrorDecl(poundError: TokenSyntax, leftParen: TokenSyntax, message: StringLiteralExprSyntax, rightParen: TokenSyntax) -> PoundErrorDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundError.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      message.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundErrorDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundErrorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundErrorDecl() -> PoundErrorDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundErrorDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundErrorKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.stringLiteralExpr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundErrorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundWarningDecl(poundWarning: TokenSyntax, leftParen: TokenSyntax, message: StringLiteralExprSyntax, rightParen: TokenSyntax) -> PoundWarningDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundWarning.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      message.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundWarningDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundWarningDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundWarningDecl() -> PoundWarningDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundWarningDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundWarningKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.stringLiteralExpr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundWarningDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundSourceLocation(poundSourceLocation: TokenSyntax, leftParen: TokenSyntax, args: PoundSourceLocationArgsSyntax?, rightParen: TokenSyntax) -> PoundSourceLocationSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundSourceLocation.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      args?.data.raw ?? RawSyntax.missing(SyntaxKind.poundSourceLocationArgs),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundSourceLocation,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundSourceLocationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundSourceLocation() -> PoundSourceLocationSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundSourceLocation,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundSourceLocationKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.poundSourceLocationArgs),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundSourceLocationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundSourceLocationArgs(fileArgLabel: TokenSyntax, fileArgColon: TokenSyntax, fileName: TokenSyntax, comma: TokenSyntax, lineArgLabel: TokenSyntax, lineArgColon: TokenSyntax, lineNumber: TokenSyntax) -> PoundSourceLocationArgsSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      fileArgLabel.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      fileArgColon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      fileName.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      comma.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      lineArgLabel.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      lineArgColon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      lineNumber.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundSourceLocationArgs,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundSourceLocationArgsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundSourceLocationArgs() -> PoundSourceLocationArgsSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundSourceLocationArgs,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.stringLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundSourceLocationArgsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDeclModifier(name: TokenSyntax, detailLeftParen: TokenSyntax?, detail: TokenSyntax?, detailRightParen: TokenSyntax?) -> DeclModifierSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      detailLeftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      detail?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      detailRightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.declModifier,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DeclModifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDeclModifier() -> DeclModifierSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .declModifier,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DeclModifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeInheritedType(typeName: TypeSyntax, trailingComma: TokenSyntax?) -> InheritedTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      typeName.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.inheritedType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return InheritedTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankInheritedType() -> InheritedTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .inheritedType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return InheritedTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeInheritedTypeList(
    _ elements: [InheritedTypeSyntax]) -> InheritedTypeListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.inheritedTypeList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return InheritedTypeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankInheritedTypeList() -> InheritedTypeListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .inheritedTypeList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return InheritedTypeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTypeInheritanceClause(colon: TokenSyntax, inheritedTypeCollection: InheritedTypeListSyntax) -> TypeInheritanceClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      inheritedTypeCollection.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.typeInheritanceClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TypeInheritanceClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTypeInheritanceClause() -> TypeInheritanceClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .typeInheritanceClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.inheritedTypeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TypeInheritanceClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeClassDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, classKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ClassDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      classKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      members.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.classDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClassDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClassDecl() -> ClassDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .classDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.classKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClassDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeStructDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, structKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> StructDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      structKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      members.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.structDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return StructDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankStructDecl() -> StructDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .structDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.structKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return StructDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeProtocolDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, protocolKeyword: TokenSyntax, identifier: TokenSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ProtocolDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      protocolKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      members.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.protocolDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ProtocolDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankProtocolDecl() -> ProtocolDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .protocolDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.protocolKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ProtocolDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeExtensionDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, extensionKeyword: TokenSyntax, extendedType: TypeSyntax, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> ExtensionDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      extensionKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      extendedType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      members.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.extensionDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ExtensionDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankExtensionDecl() -> ExtensionDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .extensionDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.extensionKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ExtensionDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeMemberDeclBlock(leftBrace: TokenSyntax, members: MemberDeclListSyntax, rightBrace: TokenSyntax) -> MemberDeclBlockSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      members.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.memberDeclBlock,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return MemberDeclBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankMemberDeclBlock() -> MemberDeclBlockSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .memberDeclBlock,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.memberDeclList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return MemberDeclBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeMemberDeclList(
    _ elements: [MemberDeclListItemSyntax]) -> MemberDeclListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.memberDeclList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return MemberDeclListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankMemberDeclList() -> MemberDeclListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .memberDeclList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return MemberDeclListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeMemberDeclListItem(decl: DeclSyntax, semicolon: TokenSyntax?) -> MemberDeclListItemSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      decl.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      semicolon?.data.raw ?? RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.memberDeclListItem,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return MemberDeclListItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankMemberDeclListItem() -> MemberDeclListItemSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .memberDeclListItem,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.decl),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.semicolon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return MemberDeclListItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSourceFile(statements: CodeBlockItemListSyntax, eofToken: TokenSyntax) -> SourceFileSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      statements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      eofToken.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.sourceFile,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SourceFileSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSourceFile() -> SourceFileSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .sourceFile,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SourceFileSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeInitializerClause(equal: TokenSyntax, value: ExprSyntax) -> InitializerClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      equal.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      value.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.initializerClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return InitializerClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankInitializerClause() -> InitializerClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .initializerClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.equal),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return InitializerClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeFunctionParameter(attributes: AttributeListSyntax?, firstName: TokenSyntax?, secondName: TokenSyntax?, colon: TokenSyntax?, type: TypeSyntax?, ellipsis: TokenSyntax?, defaultArgument: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> FunctionParameterSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      firstName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      secondName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      type?.data.raw ?? RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      ellipsis?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      defaultArgument?.data.raw ?? RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.functionParameter,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FunctionParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFunctionParameter() -> FunctionParameterSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .functionParameter,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FunctionParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeModifierList(
    _ elements: [DeclModifierSyntax]) -> ModifierListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.modifierList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ModifierListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankModifierList() -> ModifierListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .modifierList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ModifierListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeFunctionDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, funcKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, signature: FunctionSignatureSyntax, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      funcKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      signature.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      body?.data.raw ?? RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.functionDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FunctionDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFunctionDecl() -> FunctionDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .functionDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.funcKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.functionSignature),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FunctionDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeInitializerDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, initKeyword: TokenSyntax, optionalMark: TokenSyntax?, genericParameterClause: GenericParameterClauseSyntax?, parameters: ParameterClauseSyntax, throwsOrRethrowsKeyword: TokenSyntax?, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax?) -> InitializerDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      initKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      optionalMark?.data.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      parameters.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      throwsOrRethrowsKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      body?.data.raw ?? RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.initializerDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return InitializerDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankInitializerDecl() -> InitializerDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .initializerDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.initKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return InitializerDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDeinitializerDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, deinitKeyword: TokenSyntax, body: CodeBlockSyntax) -> DeinitializerDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      deinitKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.deinitializerDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DeinitializerDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDeinitializerDecl() -> DeinitializerDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .deinitializerDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.deinitKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DeinitializerDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSubscriptDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, subscriptKeyword: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, indices: ParameterClauseSyntax, result: ReturnClauseSyntax, genericWhereClause: GenericWhereClauseSyntax?, accessor: Syntax?) -> SubscriptDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      subscriptKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericParameterClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      indices.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      result.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      accessor?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.subscriptDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SubscriptDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSubscriptDecl() -> SubscriptDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .subscriptDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.subscriptKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.returnClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SubscriptDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAccessLevelModifier(name: TokenSyntax, leftParen: TokenSyntax?, modifier: TokenSyntax?, rightParen: TokenSyntax?) -> AccessLevelModifierSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      leftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifier?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      rightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.accessLevelModifier,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AccessLevelModifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAccessLevelModifier() -> AccessLevelModifierSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .accessLevelModifier,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AccessLevelModifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAccessPathComponent(name: TokenSyntax, trailingDot: TokenSyntax?) -> AccessPathComponentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingDot?.data.raw ?? RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.accessPathComponent,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AccessPathComponentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAccessPathComponent() -> AccessPathComponentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .accessPathComponent,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AccessPathComponentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeAccessPath(
    _ elements: [AccessPathComponentSyntax]) -> AccessPathSyntax {
    let raw = RawSyntax(kind: SyntaxKind.accessPath,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AccessPathSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAccessPath() -> AccessPathSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .accessPath,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AccessPathSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeImportDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, importTok: TokenSyntax, importKind: TokenSyntax?, path: AccessPathSyntax) -> ImportDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      importTok.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      importKind?.data.raw ?? RawSyntax.missingToken(TokenKind.typealiasKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      path.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.importDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ImportDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankImportDecl() -> ImportDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .importDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.importKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.typealiasKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.accessPath),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ImportDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAccessorParameter(leftParen: TokenSyntax, name: TokenSyntax, rightParen: TokenSyntax) -> AccessorParameterSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.accessorParameter,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AccessorParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAccessorParameter() -> AccessorParameterSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .accessorParameter,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AccessorParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAccessorDecl(attributes: AttributeListSyntax?, modifier: DeclModifierSyntax?, accessorKind: TokenSyntax, parameter: AccessorParameterSyntax?, body: CodeBlockSyntax?) -> AccessorDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifier?.data.raw ?? RawSyntax.missing(SyntaxKind.declModifier),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      accessorKind.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      parameter?.data.raw ?? RawSyntax.missing(SyntaxKind.accessorParameter),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      body?.data.raw ?? RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.accessorDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AccessorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAccessorDecl() -> AccessorDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .accessorDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.declModifier),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.accessorParameter),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AccessorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeAccessorList(
    _ elements: [AccessorDeclSyntax]) -> AccessorListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.accessorList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AccessorListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAccessorList() -> AccessorListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .accessorList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AccessorListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAccessorBlock(leftBrace: TokenSyntax, accessors: AccessorListSyntax, rightBrace: TokenSyntax) -> AccessorBlockSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      accessors.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.accessorBlock,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AccessorBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAccessorBlock() -> AccessorBlockSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .accessorBlock,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.accessorList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AccessorBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePatternBinding(pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax?, accessor: Syntax?, trailingComma: TokenSyntax?) -> PatternBindingSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      initializer?.data.raw ?? RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      accessor?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.patternBinding,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PatternBindingSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPatternBinding() -> PatternBindingSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .patternBinding,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PatternBindingSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makePatternBindingList(
    _ elements: [PatternBindingSyntax]) -> PatternBindingListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.patternBindingList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PatternBindingListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPatternBindingList() -> PatternBindingListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .patternBindingList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PatternBindingListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeVariableDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, letOrVarKeyword: TokenSyntax, bindings: PatternBindingListSyntax) -> VariableDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      letOrVarKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      bindings.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.variableDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return VariableDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankVariableDecl() -> VariableDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .variableDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.letKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.patternBindingList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return VariableDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeEnumCaseElement(identifier: TokenSyntax, associatedValue: ParameterClauseSyntax?, rawValue: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> EnumCaseElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      associatedValue?.data.raw ?? RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      rawValue?.data.raw ?? RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.enumCaseElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return EnumCaseElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankEnumCaseElement() -> EnumCaseElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .enumCaseElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.parameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return EnumCaseElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeEnumCaseElementList(
    _ elements: [EnumCaseElementSyntax]) -> EnumCaseElementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.enumCaseElementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return EnumCaseElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankEnumCaseElementList() -> EnumCaseElementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .enumCaseElementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return EnumCaseElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeEnumCaseDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, caseKeyword: TokenSyntax, elements: EnumCaseElementListSyntax) -> EnumCaseDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      caseKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.enumCaseDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return EnumCaseDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankEnumCaseDecl() -> EnumCaseDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .enumCaseDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.enumCaseElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return EnumCaseDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeEnumDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, enumKeyword: TokenSyntax, identifier: TokenSyntax, genericParameters: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> EnumDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      enumKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericParameters?.data.raw ?? RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      inheritanceClause?.data.raw ?? RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericWhereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      members.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.enumDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return EnumDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankEnumDecl() -> EnumDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .enumDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.enumKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericParameterClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeInheritanceClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericWhereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.memberDeclBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return EnumDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeOperatorDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, operatorKeyword: TokenSyntax, identifier: TokenSyntax, operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax?) -> OperatorDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      operatorKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      operatorPrecedenceAndTypes?.data.raw ?? RawSyntax.missing(SyntaxKind.operatorPrecedenceAndTypes),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.operatorDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return OperatorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankOperatorDecl() -> OperatorDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .operatorDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.operatorKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unspacedBinaryOperator("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.operatorPrecedenceAndTypes),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return OperatorDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeIdentifierList(
    _ elements: [TokenSyntax]) -> IdentifierListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.identifierList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IdentifierListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIdentifierList() -> IdentifierListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .identifierList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IdentifierListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeOperatorPrecedenceAndTypes(colon: TokenSyntax, precedenceGroupAndDesignatedTypes: IdentifierListSyntax) -> OperatorPrecedenceAndTypesSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      precedenceGroupAndDesignatedTypes.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.operatorPrecedenceAndTypes,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return OperatorPrecedenceAndTypesSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankOperatorPrecedenceAndTypes() -> OperatorPrecedenceAndTypesSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .operatorPrecedenceAndTypes,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.identifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return OperatorPrecedenceAndTypesSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePrecedenceGroupDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, precedencegroupKeyword: TokenSyntax, identifier: TokenSyntax, leftBrace: TokenSyntax, groupAttributes: PrecedenceGroupAttributeListSyntax, rightBrace: TokenSyntax) -> PrecedenceGroupDeclSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      modifiers?.data.raw ?? RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      precedencegroupKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      groupAttributes.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.precedenceGroupDecl,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PrecedenceGroupDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPrecedenceGroupDecl() -> PrecedenceGroupDeclSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .precedenceGroupDecl,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.modifierList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.precedencegroupKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.precedenceGroupAttributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PrecedenceGroupDeclSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makePrecedenceGroupAttributeList(
    _ elements: [Syntax]) -> PrecedenceGroupAttributeListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.precedenceGroupAttributeList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PrecedenceGroupAttributeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPrecedenceGroupAttributeList() -> PrecedenceGroupAttributeListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .precedenceGroupAttributeList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PrecedenceGroupAttributeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePrecedenceGroupRelation(higherThanOrLowerThan: TokenSyntax, colon: TokenSyntax, otherNames: PrecedenceGroupNameListSyntax) -> PrecedenceGroupRelationSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      higherThanOrLowerThan.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      otherNames.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.precedenceGroupRelation,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PrecedenceGroupRelationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPrecedenceGroupRelation() -> PrecedenceGroupRelationSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .precedenceGroupRelation,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.precedenceGroupNameList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PrecedenceGroupRelationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makePrecedenceGroupNameList(
    _ elements: [PrecedenceGroupNameElementSyntax]) -> PrecedenceGroupNameListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.precedenceGroupNameList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PrecedenceGroupNameListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPrecedenceGroupNameList() -> PrecedenceGroupNameListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .precedenceGroupNameList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PrecedenceGroupNameListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePrecedenceGroupNameElement(name: TokenSyntax, trailingComma: TokenSyntax?) -> PrecedenceGroupNameElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.precedenceGroupNameElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PrecedenceGroupNameElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPrecedenceGroupNameElement() -> PrecedenceGroupNameElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .precedenceGroupNameElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PrecedenceGroupNameElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePrecedenceGroupAssignment(assignmentKeyword: TokenSyntax, colon: TokenSyntax, flag: TokenSyntax) -> PrecedenceGroupAssignmentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      assignmentKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      flag.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.precedenceGroupAssignment,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PrecedenceGroupAssignmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPrecedenceGroupAssignment() -> PrecedenceGroupAssignmentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .precedenceGroupAssignment,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.trueKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PrecedenceGroupAssignmentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePrecedenceGroupAssociativity(associativityKeyword: TokenSyntax, colon: TokenSyntax, value: TokenSyntax) -> PrecedenceGroupAssociativitySyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      associativityKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      value.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.precedenceGroupAssociativity,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PrecedenceGroupAssociativitySyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPrecedenceGroupAssociativity() -> PrecedenceGroupAssociativitySyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .precedenceGroupAssociativity,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PrecedenceGroupAssociativitySyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeTokenList(
    _ elements: [TokenSyntax]) -> TokenListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.tokenList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TokenListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTokenList() -> TokenListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tokenList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TokenListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeNonEmptyTokenList(
    _ elements: [TokenSyntax]) -> NonEmptyTokenListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.nonEmptyTokenList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return NonEmptyTokenListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankNonEmptyTokenList() -> NonEmptyTokenListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .nonEmptyTokenList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return NonEmptyTokenListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAttribute(atSignToken: TokenSyntax, attributeName: TokenSyntax, leftParen: TokenSyntax?, argument: Syntax?, rightParen: TokenSyntax?, tokenList: TokenListSyntax?) -> AttributeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      atSignToken.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      attributeName.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      leftParen?.data.raw ?? RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      argument?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      rightParen?.data.raw ?? RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      tokenList?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.attribute,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AttributeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAttribute() -> AttributeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .attribute,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.atSign),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AttributeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeAttributeList(
    _ elements: [AttributeSyntax]) -> AttributeListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.attributeList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AttributeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAttributeList() -> AttributeListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .attributeList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AttributeListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeSpecializeAttributeSpecList(
    _ elements: [Syntax]) -> SpecializeAttributeSpecListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.specializeAttributeSpecList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SpecializeAttributeSpecListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSpecializeAttributeSpecList() -> SpecializeAttributeSpecListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .specializeAttributeSpecList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SpecializeAttributeSpecListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeLabeledSpecializeEntry(label: TokenSyntax, colon: TokenSyntax, value: TokenSyntax, trailingComma: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      label.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      value.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.labeledSpecializeEntry,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return LabeledSpecializeEntrySyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankLabeledSpecializeEntry() -> LabeledSpecializeEntrySyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .labeledSpecializeEntry,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return LabeledSpecializeEntrySyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeNamedAttributeStringArgument(nameTok: TokenSyntax, colon: TokenSyntax, stringOrDeclname: Syntax) -> NamedAttributeStringArgumentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      nameTok.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      stringOrDeclname.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.namedAttributeStringArgument,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return NamedAttributeStringArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankNamedAttributeStringArgument() -> NamedAttributeStringArgumentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .namedAttributeStringArgument,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return NamedAttributeStringArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDeclName(declBaseName: Syntax, declNameArguments: DeclNameArgumentsSyntax?) -> DeclNameSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      declBaseName.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.declName,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DeclNameSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDeclName() -> DeclNameSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .declName,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DeclNameSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeImplementsAttributeArguments(type: SimpleTypeIdentifierSyntax, comma: TokenSyntax, declBaseName: Syntax, declNameArguments: DeclNameArgumentsSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      type.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      comma.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      declBaseName.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      declNameArguments?.data.raw ?? RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.implementsAttributeArguments,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ImplementsAttributeArgumentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankImplementsAttributeArguments() -> ImplementsAttributeArgumentsSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .implementsAttributeArguments,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.simpleTypeIdentifier),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.declNameArguments),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ImplementsAttributeArgumentsSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeObjCSelectorPiece(name: TokenSyntax?, colon: TokenSyntax?) -> ObjCSelectorPieceSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      name?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.objCSelectorPiece,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ObjCSelectorPieceSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankObjCSelectorPiece() -> ObjCSelectorPieceSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .objCSelectorPiece,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ObjCSelectorPieceSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeObjCSelector(
    _ elements: [ObjCSelectorPieceSyntax]) -> ObjCSelectorSyntax {
    let raw = RawSyntax(kind: SyntaxKind.objCSelector,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ObjCSelectorSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankObjCSelector() -> ObjCSelectorSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .objCSelector,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ObjCSelectorSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeContinueStmt(continueKeyword: TokenSyntax, label: TokenSyntax?) -> ContinueStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      continueKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      label?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.continueStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ContinueStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankContinueStmt() -> ContinueStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .continueStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.continueKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ContinueStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeWhileStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, whileKeyword: TokenSyntax, conditions: ConditionElementListSyntax, body: CodeBlockSyntax) -> WhileStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      whileKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      conditions.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.whileStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return WhileStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankWhileStmt() -> WhileStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .whileStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.whileKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.conditionElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return WhileStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDeferStmt(deferKeyword: TokenSyntax, body: CodeBlockSyntax) -> DeferStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      deferKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.deferStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DeferStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDeferStmt() -> DeferStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .deferStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.deferKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DeferStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeExpressionStmt(expression: ExprSyntax) -> ExpressionStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.expressionStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ExpressionStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankExpressionStmt() -> ExpressionStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .expressionStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ExpressionStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeSwitchCaseList(
    _ elements: [Syntax]) -> SwitchCaseListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.switchCaseList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SwitchCaseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSwitchCaseList() -> SwitchCaseListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .switchCaseList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SwitchCaseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeRepeatWhileStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, repeatKeyword: TokenSyntax, body: CodeBlockSyntax, whileKeyword: TokenSyntax, condition: ExprSyntax) -> RepeatWhileStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      repeatKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      whileKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      condition.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.repeatWhileStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return RepeatWhileStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankRepeatWhileStmt() -> RepeatWhileStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .repeatWhileStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.repeatKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.whileKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return RepeatWhileStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeGuardStmt(guardKeyword: TokenSyntax, conditions: ConditionElementListSyntax, elseKeyword: TokenSyntax, body: CodeBlockSyntax) -> GuardStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      guardKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      conditions.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elseKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.guardStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GuardStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGuardStmt() -> GuardStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .guardStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.guardKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.conditionElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.elseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GuardStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeWhereClause(whereKeyword: TokenSyntax, guardResult: ExprSyntax) -> WhereClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      whereKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      guardResult.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.whereClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return WhereClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankWhereClause() -> WhereClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .whereClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.whereKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return WhereClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeForInStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, forKeyword: TokenSyntax, caseKeyword: TokenSyntax?, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, inKeyword: TokenSyntax, sequenceExpr: ExprSyntax, whereClause: WhereClauseSyntax?, body: CodeBlockSyntax) -> ForInStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      forKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      caseKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      inKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      sequenceExpr.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      whereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.forInStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ForInStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankForInStmt() -> ForInStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .forInStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.forKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.inKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ForInStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSwitchStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, switchKeyword: TokenSyntax, expression: ExprSyntax, leftBrace: TokenSyntax, cases: SwitchCaseListSyntax, rightBrace: TokenSyntax) -> SwitchStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      switchKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      cases.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightBrace.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.switchStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SwitchStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSwitchStmt() -> SwitchStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .switchStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.switchKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.switchCaseList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightBrace),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SwitchStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeCatchClauseList(
    _ elements: [CatchClauseSyntax]) -> CatchClauseListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.catchClauseList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CatchClauseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCatchClauseList() -> CatchClauseListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .catchClauseList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CatchClauseListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDoStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, doKeyword: TokenSyntax, body: CodeBlockSyntax, catchClauses: CatchClauseListSyntax?) -> DoStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      doKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      catchClauses?.data.raw ?? RawSyntax.missing(SyntaxKind.catchClauseList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.doStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DoStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDoStmt() -> DoStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .doStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.doKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.catchClauseList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DoStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeReturnStmt(returnKeyword: TokenSyntax, expression: ExprSyntax?) -> ReturnStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      returnKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      expression?.data.raw ?? RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.returnStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ReturnStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankReturnStmt() -> ReturnStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .returnStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.returnKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ReturnStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeYieldStmt(yieldKeyword: TokenSyntax, yields: Syntax) -> YieldStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      yieldKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      yields.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.yieldStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return YieldStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankYieldStmt() -> YieldStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .yieldStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.yield),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return YieldStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeYieldList(leftParen: TokenSyntax, elementList: ExprListSyntax, trailingComma: TokenSyntax?, rightParen: TokenSyntax) -> YieldListSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elementList.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.yieldList,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return YieldListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankYieldList() -> YieldListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .yieldList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.exprList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return YieldListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeFallthroughStmt(fallthroughKeyword: TokenSyntax) -> FallthroughStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      fallthroughKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.fallthroughStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FallthroughStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFallthroughStmt() -> FallthroughStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .fallthroughStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.fallthroughKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FallthroughStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeBreakStmt(breakKeyword: TokenSyntax, label: TokenSyntax?) -> BreakStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      breakKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      label?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.breakStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return BreakStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankBreakStmt() -> BreakStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .breakStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.breakKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return BreakStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeCaseItemList(
    _ elements: [CaseItemSyntax]) -> CaseItemListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.caseItemList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CaseItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCaseItemList() -> CaseItemListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .caseItemList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CaseItemListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeConditionElement(condition: Syntax, trailingComma: TokenSyntax?) -> ConditionElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      condition.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.conditionElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ConditionElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankConditionElement() -> ConditionElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .conditionElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ConditionElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAvailabilityCondition(poundAvailableKeyword: TokenSyntax, leftParen: TokenSyntax, availabilitySpec: AvailabilitySpecListSyntax, rightParen: TokenSyntax) -> AvailabilityConditionSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundAvailableKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      availabilitySpec.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.availabilityCondition,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AvailabilityConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAvailabilityCondition() -> AvailabilityConditionSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .availabilityCondition,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundAvailableKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.availabilitySpecList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AvailabilityConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeMatchingPatternCondition(caseKeyword: TokenSyntax, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax) -> MatchingPatternConditionSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      caseKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      initializer.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.matchingPatternCondition,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return MatchingPatternConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankMatchingPatternCondition() -> MatchingPatternConditionSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .matchingPatternCondition,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return MatchingPatternConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeOptionalBindingCondition(letOrVarKeyword: TokenSyntax, pattern: PatternSyntax, typeAnnotation: TypeAnnotationSyntax?, initializer: InitializerClauseSyntax) -> OptionalBindingConditionSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      letOrVarKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      initializer.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.optionalBindingCondition,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return OptionalBindingConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankOptionalBindingCondition() -> OptionalBindingConditionSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .optionalBindingCondition,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.letKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return OptionalBindingConditionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeConditionElementList(
    _ elements: [ConditionElementSyntax]) -> ConditionElementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.conditionElementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ConditionElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankConditionElementList() -> ConditionElementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .conditionElementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ConditionElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDeclarationStmt(declaration: DeclSyntax) -> DeclarationStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      declaration.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.declarationStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DeclarationStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDeclarationStmt() -> DeclarationStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .declarationStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.decl),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DeclarationStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeThrowStmt(throwKeyword: TokenSyntax, expression: ExprSyntax) -> ThrowStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      throwKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.throwStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ThrowStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankThrowStmt() -> ThrowStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .throwStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.throwKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ThrowStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeIfStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, ifKeyword: TokenSyntax, conditions: ConditionElementListSyntax, body: CodeBlockSyntax, elseKeyword: TokenSyntax?, elseBody: Syntax?) -> IfStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      ifKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      conditions.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      elseKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.elseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      elseBody?.data.raw ?? RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.ifStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IfStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIfStmt() -> IfStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .ifStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.ifKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.conditionElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.elseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IfStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeElseIfContinuation(ifStatement: IfStmtSyntax) -> ElseIfContinuationSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      ifStatement.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.elseIfContinuation,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ElseIfContinuationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankElseIfContinuation() -> ElseIfContinuationSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .elseIfContinuation,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.ifStmt),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ElseIfContinuationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeElseBlock(elseKeyword: TokenSyntax, body: CodeBlockSyntax) -> ElseBlockSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elseKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.elseBlock,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ElseBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankElseBlock() -> ElseBlockSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .elseBlock,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.elseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ElseBlockSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSwitchCase(unknownAttr: AttributeSyntax?, label: Syntax, statements: CodeBlockItemListSyntax) -> SwitchCaseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      unknownAttr?.data.raw ?? RawSyntax.missing(SyntaxKind.attribute),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      label.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      statements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.switchCase,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SwitchCaseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSwitchCase() -> SwitchCaseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .switchCase,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attribute),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlockItemList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SwitchCaseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSwitchDefaultLabel(defaultKeyword: TokenSyntax, colon: TokenSyntax) -> SwitchDefaultLabelSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      defaultKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.switchDefaultLabel,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SwitchDefaultLabelSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSwitchDefaultLabel() -> SwitchDefaultLabelSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .switchDefaultLabel,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.defaultKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SwitchDefaultLabelSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeCaseItem(pattern: PatternSyntax, whereClause: WhereClauseSyntax?, trailingComma: TokenSyntax?) -> CaseItemSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      whereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.caseItem,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CaseItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCaseItem() -> CaseItemSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .caseItem,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CaseItemSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSwitchCaseLabel(caseKeyword: TokenSyntax, caseItems: CaseItemListSyntax, colon: TokenSyntax) -> SwitchCaseLabelSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      caseKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      caseItems.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.switchCaseLabel,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SwitchCaseLabelSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSwitchCaseLabel() -> SwitchCaseLabelSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .switchCaseLabel,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.caseKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.caseItemList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SwitchCaseLabelSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeCatchClause(catchKeyword: TokenSyntax, pattern: PatternSyntax?, whereClause: WhereClauseSyntax?, body: CodeBlockSyntax) -> CatchClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      catchKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      pattern?.data.raw ?? RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      whereClause?.data.raw ?? RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      body.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.catchClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CatchClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCatchClause() -> CatchClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .catchClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.catchKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.whereClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.codeBlock),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CatchClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makePoundAssertStmt(poundAssert: TokenSyntax, leftParen: TokenSyntax, condition: ExprSyntax, comma: TokenSyntax?, message: TokenSyntax?, rightParen: TokenSyntax) -> PoundAssertStmtSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      poundAssert.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      condition.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      comma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      message?.data.raw ?? RawSyntax.missingToken(TokenKind.stringLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.poundAssertStmt,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return PoundAssertStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankPoundAssertStmt() -> PoundAssertStmtSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .poundAssertStmt,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.poundAssertKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.stringLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return PoundAssertStmtSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeGenericWhereClause(whereKeyword: TokenSyntax, requirementList: GenericRequirementListSyntax) -> GenericWhereClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      whereKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      requirementList.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.genericWhereClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GenericWhereClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGenericWhereClause() -> GenericWhereClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .genericWhereClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.whereKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericRequirementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GenericWhereClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeGenericRequirementList(
    _ elements: [Syntax]) -> GenericRequirementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.genericRequirementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GenericRequirementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGenericRequirementList() -> GenericRequirementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .genericRequirementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GenericRequirementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSameTypeRequirement(leftTypeIdentifier: TypeSyntax, equalityToken: TokenSyntax, rightTypeIdentifier: TypeSyntax, trailingComma: TokenSyntax?) -> SameTypeRequirementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftTypeIdentifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      equalityToken.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightTypeIdentifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.sameTypeRequirement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SameTypeRequirementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSameTypeRequirement() -> SameTypeRequirementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .sameTypeRequirement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.spacedBinaryOperator("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SameTypeRequirementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeGenericParameterList(
    _ elements: [GenericParameterSyntax]) -> GenericParameterListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.genericParameterList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GenericParameterListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGenericParameterList() -> GenericParameterListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .genericParameterList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GenericParameterListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeGenericParameter(attributes: AttributeListSyntax?, name: TokenSyntax, colon: TokenSyntax?, inheritedType: TypeSyntax?, trailingComma: TokenSyntax?) -> GenericParameterSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      inheritedType?.data.raw ?? RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.genericParameter,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GenericParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGenericParameter() -> GenericParameterSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .genericParameter,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GenericParameterSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeGenericParameterClause(leftAngleBracket: TokenSyntax, genericParameterList: GenericParameterListSyntax, rightAngleBracket: TokenSyntax) -> GenericParameterClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftAngleBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      genericParameterList.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightAngleBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.genericParameterClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GenericParameterClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGenericParameterClause() -> GenericParameterClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .genericParameterClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftAngle),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericParameterList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightAngle),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GenericParameterClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeConformanceRequirement(leftTypeIdentifier: TypeSyntax, colon: TokenSyntax, rightTypeIdentifier: TypeSyntax, trailingComma: TokenSyntax?) -> ConformanceRequirementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftTypeIdentifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightTypeIdentifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.conformanceRequirement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ConformanceRequirementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankConformanceRequirement() -> ConformanceRequirementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .conformanceRequirement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ConformanceRequirementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeSimpleTypeIdentifier(name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericArgumentClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.simpleTypeIdentifier,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return SimpleTypeIdentifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankSimpleTypeIdentifier() -> SimpleTypeIdentifierSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .simpleTypeIdentifier,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return SimpleTypeIdentifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeMemberTypeIdentifier(baseType: TypeSyntax, period: TokenSyntax, name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      baseType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      period.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      name.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      genericArgumentClause?.data.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.memberTypeIdentifier,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return MemberTypeIdentifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankMemberTypeIdentifier() -> MemberTypeIdentifierSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .memberTypeIdentifier,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericArgumentClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return MemberTypeIdentifierSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeClassRestrictionType(classKeyword: TokenSyntax) -> ClassRestrictionTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      classKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.classRestrictionType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ClassRestrictionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankClassRestrictionType() -> ClassRestrictionTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .classRestrictionType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.classKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ClassRestrictionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeArrayType(leftSquareBracket: TokenSyntax, elementType: TypeSyntax, rightSquareBracket: TokenSyntax) -> ArrayTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftSquareBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elementType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightSquareBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.arrayType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ArrayTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankArrayType() -> ArrayTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .arrayType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ArrayTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeDictionaryType(leftSquareBracket: TokenSyntax, keyType: TypeSyntax, colon: TokenSyntax, valueType: TypeSyntax, rightSquareBracket: TokenSyntax) -> DictionaryTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftSquareBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      keyType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      valueType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightSquareBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.dictionaryType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return DictionaryTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankDictionaryType() -> DictionaryTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .dictionaryType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightSquareBracket),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return DictionaryTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeMetatypeType(baseType: TypeSyntax, period: TokenSyntax, typeOrProtocol: TokenSyntax) -> MetatypeTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      baseType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      period.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      typeOrProtocol.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.metatypeType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return MetatypeTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankMetatypeType() -> MetatypeTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .metatypeType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return MetatypeTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeOptionalType(wrappedType: TypeSyntax, questionMark: TokenSyntax) -> OptionalTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      wrappedType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      questionMark.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.optionalType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return OptionalTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankOptionalType() -> OptionalTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .optionalType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return OptionalTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeImplicitlyUnwrappedOptionalType(wrappedType: TypeSyntax, exclamationMark: TokenSyntax) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      wrappedType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      exclamationMark.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.implicitlyUnwrappedOptionalType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .implicitlyUnwrappedOptionalType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.exclamationMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeCompositionTypeElement(type: TypeSyntax, ampersand: TokenSyntax?) -> CompositionTypeElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      type.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      ampersand?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.compositionTypeElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CompositionTypeElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCompositionTypeElement() -> CompositionTypeElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .compositionTypeElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CompositionTypeElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeCompositionTypeElementList(
    _ elements: [CompositionTypeElementSyntax]) -> CompositionTypeElementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.compositionTypeElementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CompositionTypeElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCompositionTypeElementList() -> CompositionTypeElementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .compositionTypeElementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CompositionTypeElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeCompositionType(elements: CompositionTypeElementListSyntax) -> CompositionTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.compositionType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return CompositionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankCompositionType() -> CompositionTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .compositionType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.compositionTypeElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return CompositionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTupleTypeElement(inOut: TokenSyntax?, name: TokenSyntax?, secondName: TokenSyntax?, colon: TokenSyntax?, type: TypeSyntax, ellipsis: TokenSyntax?, initializer: InitializerClauseSyntax?, trailingComma: TokenSyntax?) -> TupleTypeElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      inOut?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      name?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      secondName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      colon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      type.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      ellipsis?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      initializer?.data.raw ?? RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.tupleTypeElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TupleTypeElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTupleTypeElement() -> TupleTypeElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tupleTypeElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.initializerClause),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TupleTypeElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeTupleTypeElementList(
    _ elements: [TupleTypeElementSyntax]) -> TupleTypeElementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.tupleTypeElementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TupleTypeElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTupleTypeElementList() -> TupleTypeElementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tupleTypeElementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TupleTypeElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTupleType(leftParen: TokenSyntax, elements: TupleTypeElementListSyntax, rightParen: TokenSyntax) -> TupleTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.tupleType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TupleTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTupleType() -> TupleTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tupleType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.tupleTypeElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TupleTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeFunctionType(leftParen: TokenSyntax, arguments: TupleTypeElementListSyntax, rightParen: TokenSyntax, throwsOrRethrowsKeyword: TokenSyntax?, arrow: TokenSyntax, returnType: TypeSyntax) -> FunctionTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      arguments.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      throwsOrRethrowsKeyword?.data.raw ?? RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      arrow.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      returnType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.functionType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return FunctionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankFunctionType() -> FunctionTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .functionType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.tupleTypeElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.throwsKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.arrow),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return FunctionTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAttributedType(specifier: TokenSyntax?, attributes: AttributeListSyntax?, baseType: TypeSyntax) -> AttributedTypeSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      specifier?.data.raw ?? RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      attributes?.data.raw ?? RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      baseType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.attributedType,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AttributedTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAttributedType() -> AttributedTypeSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .attributedType,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.unknown("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.attributeList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AttributedTypeSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeGenericArgumentList(
    _ elements: [GenericArgumentSyntax]) -> GenericArgumentListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.genericArgumentList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GenericArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGenericArgumentList() -> GenericArgumentListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .genericArgumentList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GenericArgumentListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeGenericArgument(argumentType: TypeSyntax, trailingComma: TokenSyntax?) -> GenericArgumentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      argumentType.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.genericArgument,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GenericArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGenericArgument() -> GenericArgumentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .genericArgument,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GenericArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeGenericArgumentClause(leftAngleBracket: TokenSyntax, arguments: GenericArgumentListSyntax, rightAngleBracket: TokenSyntax) -> GenericArgumentClauseSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftAngleBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      arguments.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightAngleBracket.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.genericArgumentClause,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return GenericArgumentClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankGenericArgumentClause() -> GenericArgumentClauseSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .genericArgumentClause,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftAngle),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.genericArgumentList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightAngle),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return GenericArgumentClauseSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTypeAnnotation(colon: TokenSyntax, type: TypeSyntax) -> TypeAnnotationSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      type.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.typeAnnotation,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TypeAnnotationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTypeAnnotation() -> TypeAnnotationSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .typeAnnotation,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TypeAnnotationSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeEnumCasePattern(type: TypeSyntax?, period: TokenSyntax, caseName: TokenSyntax, associatedTuple: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      type?.data.raw ?? RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      period.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      caseName.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      associatedTuple?.data.raw ?? RawSyntax.missing(SyntaxKind.tuplePattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.enumCasePattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return EnumCasePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankEnumCasePattern() -> EnumCasePatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .enumCasePattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.tuplePattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return EnumCasePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeIsTypePattern(isKeyword: TokenSyntax, type: TypeSyntax) -> IsTypePatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      isKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      type.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.isTypePattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IsTypePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIsTypePattern() -> IsTypePatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .isTypePattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.isKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IsTypePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeOptionalPattern(subPattern: PatternSyntax, questionMark: TokenSyntax) -> OptionalPatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      subPattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      questionMark.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.optionalPattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return OptionalPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankOptionalPattern() -> OptionalPatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .optionalPattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.postfixQuestionMark),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return OptionalPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeIdentifierPattern(identifier: TokenSyntax) -> IdentifierPatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      identifier.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.identifierPattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return IdentifierPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankIdentifierPattern() -> IdentifierPatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .identifierPattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return IdentifierPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAsTypePattern(pattern: PatternSyntax, asKeyword: TokenSyntax, type: TypeSyntax) -> AsTypePatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      asKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      type.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.asTypePattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AsTypePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAsTypePattern() -> AsTypePatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .asTypePattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.asKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.type),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AsTypePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTuplePattern(leftParen: TokenSyntax, elements: TuplePatternElementListSyntax, rightParen: TokenSyntax) -> TuplePatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      leftParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      elements.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      rightParen.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.tuplePattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TuplePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTuplePattern() -> TuplePatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tuplePattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.leftParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.tuplePatternElementList),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.rightParen),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TuplePatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeWildcardPattern(wildcard: TokenSyntax, typeAnnotation: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      wildcard.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      typeAnnotation?.data.raw ?? RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.wildcardPattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return WildcardPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankWildcardPattern() -> WildcardPatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .wildcardPattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.wildcardKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.typeAnnotation),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return WildcardPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeTuplePatternElement(labelName: TokenSyntax?, labelColon: TokenSyntax?, pattern: PatternSyntax, trailingComma: TokenSyntax?) -> TuplePatternElementSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelName?.data.raw ?? RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      labelColon?.data.raw ?? RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      pattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.tuplePatternElement,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TuplePatternElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTuplePatternElement() -> TuplePatternElementSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tuplePatternElement,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TuplePatternElementSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeExpressionPattern(expression: ExprSyntax) -> ExpressionPatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      expression.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.expressionPattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ExpressionPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankExpressionPattern() -> ExpressionPatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .expressionPattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.expr),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ExpressionPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeTuplePatternElementList(
    _ elements: [TuplePatternElementSyntax]) -> TuplePatternElementListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.tuplePatternElementList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return TuplePatternElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankTuplePatternElementList() -> TuplePatternElementListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .tuplePatternElementList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return TuplePatternElementListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeValueBindingPattern(letOrVarKeyword: TokenSyntax, valuePattern: PatternSyntax) -> ValueBindingPatternSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      letOrVarKeyword.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      valuePattern.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.valueBindingPattern,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return ValueBindingPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankValueBindingPattern() -> ValueBindingPatternSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .valueBindingPattern,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.letKeyword),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.pattern),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return ValueBindingPatternSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 76)
  public static func makeAvailabilitySpecList(
    _ elements: [AvailabilityArgumentSyntax]) -> AvailabilitySpecListSyntax {
    let raw = RawSyntax(kind: SyntaxKind.availabilitySpecList,
                        layout: elements.map { $0.data.raw },
                        presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AvailabilitySpecListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAvailabilitySpecList() -> AvailabilitySpecListSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .availabilitySpecList,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AvailabilitySpecListSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAvailabilityArgument(entry: Syntax, trailingComma: TokenSyntax?) -> AvailabilityArgumentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      entry.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      trailingComma?.data.raw ?? RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.availabilityArgument,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AvailabilityArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAvailabilityArgument() -> AvailabilityArgumentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .availabilityArgument,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.comma),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AvailabilityArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAvailabilityLabeledArgument(label: TokenSyntax, colon: TokenSyntax, value: Syntax) -> AvailabilityLabeledArgumentSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      label.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      colon.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      value.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.availabilityLabeledArgument,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AvailabilityLabeledArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAvailabilityLabeledArgument() -> AvailabilityLabeledArgumentSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .availabilityLabeledArgument,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.colon),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AvailabilityLabeledArgumentSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeAvailabilityVersionRestriction(platform: TokenSyntax, version: VersionTupleSyntax) -> AvailabilityVersionRestrictionSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      platform.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      version.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.availabilityVersionRestriction,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return AvailabilityVersionRestrictionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankAvailabilityVersionRestriction() -> AvailabilityVersionRestrictionSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .availabilityVersionRestriction,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.identifier("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.versionTuple),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return AvailabilityVersionRestrictionSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 60)
  public static func makeVersionTuple(majorMinor: Syntax, patchPeriod: TokenSyntax?, patchVersion: TokenSyntax?) -> VersionTupleSyntax {
    let layout: [RawSyntax?] = [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 66)
      majorMinor.data.raw,
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      patchPeriod?.data.raw ?? RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 64)
      patchVersion?.data.raw ?? RawSyntax.missingToken(TokenKind.integerLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 69)
    ]
    let raw = RawSyntax(kind: SyntaxKind.versionTuple,
                        layout: layout, presence: SourcePresence.present)
    let data = SyntaxData(raw: raw)
    return VersionTupleSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 85)

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 87)
  public static func makeBlankVersionTuple() -> VersionTupleSyntax {
    let data = SyntaxData(raw: RawSyntax(kind: .versionTuple,
                                         layout: [
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missing(SyntaxKind.unknown),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.period),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 91)
      RawSyntax.missingToken(TokenKind.integerLiteral("")),
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 93)
    ], presence: .present))
    return VersionTupleSyntax(root: data, data: data)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 98)

/// MARK: Token Creation APIs

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeAssociatedtypeKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.associatedtypeKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeClassKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.classKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeDeinitKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.deinitKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeEnumKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.enumKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeExtensionKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.extensionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeFuncKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.funcKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeImportKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.importKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeInitKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.initKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeInoutKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.inoutKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeLetKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.letKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeOperatorKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.operatorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePrecedencegroupKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.precedencegroupKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeProtocolKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.protocolKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeStructKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.structKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeSubscriptKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.subscriptKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeTypealiasKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.typealiasKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeVarKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.varKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeFileprivateKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.fileprivateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeInternalKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.internalKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePrivateKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.privateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePublicKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.publicKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeStaticKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.staticKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeDeferKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.deferKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeIfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.ifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeGuardKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.guardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeDoKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.doKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeRepeatKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.repeatKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeElseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.elseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeForKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.forKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeInKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.inKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeWhileKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.whileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeReturnKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.returnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeBreakKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.breakKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeContinueKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.continueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeFallthroughKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.fallthroughKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeSwitchKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.switchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeCaseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.caseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeDefaultKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.defaultKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeWhereKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.whereKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeCatchKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.catchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeThrowKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.throwKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeAsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.asKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeAnyKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.anyKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeFalseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.falseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeIsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.isKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeNilKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.nilKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeRethrowsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rethrowsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeSuperKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.superKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeSelfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.selfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeCapitalSelfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.capitalSelfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeTrueKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.trueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeTryKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.tryKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeThrowsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.throwsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func make__FILE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__file__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func make__LINE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__line__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func make__COLUMN__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__column__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func make__FUNCTION__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__function__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func make__DSO_HANDLE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__dso_handle__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makeWildcardKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.wildcardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeLeftParenToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeRightParenToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeLeftBraceToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeRightBraceToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeLeftSquareBracketToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeRightSquareBracketToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeLeftAngleToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeRightAngleToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makePeriodToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.period, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makePrefixPeriodToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.prefixPeriod, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeCommaToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.comma, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeColonToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.colon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeSemicolonToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.semicolon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeEqualToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.equal, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeAtSignToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.atSign, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makePoundToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.pound, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makePrefixAmpersandToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.prefixAmpersand, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeArrowToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.arrow, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeBacktickToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.backtick, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeBackslashToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.backslash, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeExclamationMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.exclamationMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makePostfixQuestionMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.postfixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeInfixQuestionMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.infixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeStringQuoteToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeMultilineStringQuoteToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.multilineStringQuote, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundKeyPathKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundKeyPathKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundLineKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundLineKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundSelectorKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundSelectorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundFileKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundFileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundColumnKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundColumnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundFunctionKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundFunctionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundDsohandleKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundDsohandleKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundAssertKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundAssertKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundSourceLocationKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundSourceLocationKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundWarningKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundWarningKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundErrorKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundErrorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundIfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundIfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundElseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundElseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundElseifKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundElseifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundEndifKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundEndifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundAvailableKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundAvailableKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundFileLiteralKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundFileLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundImageLiteralKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundImageLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 103)
  public static func makePoundColorLiteralKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundColorLiteralKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeIntegerLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.integerLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeFloatingLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.floatingLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeStringLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeUnknown(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.unknown(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeIdentifier(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.identifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeUnspacedBinaryOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.unspacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeSpacedBinaryOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makePostfixOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.postfixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makePrefixOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.prefixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeDollarIdentifier(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.dollarIdentifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeContextualKeyword(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.contextualKeyword(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 117)
  public static func makeStringSegment(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringSegment(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeStringInterpolationAnchorToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringInterpolationAnchor, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 110)
  public static func makeYieldToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.yield, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/SyntaxFactory.swift.gyb", line: 125)

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
