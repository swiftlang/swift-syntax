//// Automatically Generated From DeclBuildables.swift.gyb.
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2021 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

// MARK: Protocols

public protocol DeclListBuildable: SyntaxListBuildable {
  func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]
}

public protocol DeclBuildable: SyntaxBuildable, DeclListBuildable {
  func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax
}

extension DeclBuildable {
  func buildDecl(format: Format) -> DeclSyntax {
    buildDecl(format: format, leadingTrivia: nil)
  }
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildDecl(format: format, leadingTrivia: leadingTrivia))
  }

  public func buildDeclList(format: Format) -> [DeclSyntax] {
    buildDeclList(format: format, leadingTrivia: nil)
  }

  public func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax] {
    [buildDecl(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol ExprListBuildable: SyntaxListBuildable {
  func buildExprList(format: Format, leadingTrivia: Trivia?) -> [ExprSyntax]
}

public protocol ExprBuildable: SyntaxBuildable, ExprListBuildable {
  func buildExpr(format: Format, leadingTrivia: Trivia?) -> ExprSyntax
}

extension ExprBuildable {
  func buildExpr(format: Format) -> ExprSyntax {
    buildExpr(format: format, leadingTrivia: nil)
  }
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildExpr(format: format, leadingTrivia: leadingTrivia))
  }

  public func buildExprList(format: Format) -> [ExprSyntax] {
    buildExprList(format: format, leadingTrivia: nil)
  }

  public func buildExprList(format: Format, leadingTrivia: Trivia?) -> [ExprSyntax] {
    [buildExpr(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol PatternListBuildable: SyntaxListBuildable {
  func buildPatternList(format: Format, leadingTrivia: Trivia?) -> [PatternSyntax]
}

public protocol PatternBuildable: SyntaxBuildable, PatternListBuildable {
  func buildPattern(format: Format, leadingTrivia: Trivia?) -> PatternSyntax
}

extension PatternBuildable {
  func buildPattern(format: Format) -> PatternSyntax {
    buildPattern(format: format, leadingTrivia: nil)
  }
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildPattern(format: format, leadingTrivia: leadingTrivia))
  }

  public func buildPatternList(format: Format) -> [PatternSyntax] {
    buildPatternList(format: format, leadingTrivia: nil)
  }

  public func buildPatternList(format: Format, leadingTrivia: Trivia?) -> [PatternSyntax] {
    [buildPattern(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol StmtListBuildable: SyntaxListBuildable {
  func buildStmtList(format: Format, leadingTrivia: Trivia?) -> [StmtSyntax]
}

public protocol StmtBuildable: SyntaxBuildable, StmtListBuildable {
  func buildStmt(format: Format, leadingTrivia: Trivia?) -> StmtSyntax
}

extension StmtBuildable {
  func buildStmt(format: Format) -> StmtSyntax {
    buildStmt(format: format, leadingTrivia: nil)
  }
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildStmt(format: format, leadingTrivia: leadingTrivia))
  }

  public func buildStmtList(format: Format) -> [StmtSyntax] {
    buildStmtList(format: format, leadingTrivia: nil)
  }

  public func buildStmtList(format: Format, leadingTrivia: Trivia?) -> [StmtSyntax] {
    [buildStmt(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol SyntaxListBuildable {
  func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax]
}

public protocol SyntaxBuildable: SyntaxListBuildable {
  func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax
}

extension SyntaxBuildable {
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildSyntax(format: format, leadingTrivia: leadingTrivia))
  }

  public func buildSyntaxList(format: Format) -> [Syntax] {
    buildSyntaxList(format: format, leadingTrivia: nil)
  }

  public func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax] {
    [buildSyntax(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol TypeListBuildable: SyntaxListBuildable {
  func buildTypeList(format: Format, leadingTrivia: Trivia?) -> [TypeSyntax]
}

public protocol TypeBuildable: SyntaxBuildable, TypeListBuildable {
  func buildType(format: Format, leadingTrivia: Trivia?) -> TypeSyntax
}

extension TypeBuildable {
  func buildType(format: Format) -> TypeSyntax {
    buildType(format: format, leadingTrivia: nil)
  }
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildType(format: format, leadingTrivia: leadingTrivia))
  }

  public func buildTypeList(format: Format) -> [TypeSyntax] {
    buildTypeList(format: format, leadingTrivia: nil)
  }

  public func buildTypeList(format: Format, leadingTrivia: Trivia?) -> [TypeSyntax] {
    [buildType(format: format, leadingTrivia: leadingTrivia)]
  }
}


// MARK: - Buildables

public struct CodeBlockItem: SyntaxBuildable {
  let item: SyntaxBuildable
  let semicolon: TokenSyntax?
  let errorTokens: SyntaxBuildable?

  public init(
    item: SyntaxBuildable,
    semicolon: TokenSyntax?,
    errorTokens: SyntaxBuildable?
  ) {
    self.item = item
    self.semicolon = semicolon
    self.errorTokens = errorTokens
  }
  
  func buildCodeBlockItem(format: Format, leadingTrivia: Trivia? = nil) -> CodeBlockItemSyntax {
    let codeBlockItem = SyntaxFactory.makeCodeBlockItem(
      item: item.buildSyntax(format: format),
      semicolon: semicolon,
      errorTokens: errorTokens?.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return codeBlockItem
        .withLeadingTrivia(leadingTrivia)
    }

    return codeBlockItem
  }

  /// Conformance for `CodeBlockItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let codeBlockItem = buildCodeBlockItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(codeBlockItem)
  }
}

// MARK: - Syntax collection
public struct CodeBlockItemList: SyntaxBuildable {
  let elements: [CodeBlockItem]

  public init(_ elements: [CodeBlockItem]) {
    self.elements = elements
  }

  public func buildCodeBlockItemList(format: Format, leadingTrivia: Trivia? = nil) -> CodeBlockItemListSyntax {
    return SyntaxFactory.makeCodeBlockItemList(elements.map {
      $0.buildCodeBlockItem(format: format, leadingTrivia: .newlines(1) + format._makeIndent())
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let codeBlockItemList = buildCodeBlockItemList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(codeBlockItemList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(codeBlockItemList)
  }
}

public struct CodeBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let statements: CodeBlockItemList
  let rightBrace: TokenSyntax

  public init(
    leftBrace: TokenSyntax,
    statements: CodeBlockItemList,
    rightBrace: TokenSyntax
  ) {
    self.leftBrace = leftBrace
    self.statements = statements
    self.rightBrace = rightBrace
  }
  
  func buildCodeBlock(format: Format, leadingTrivia: Trivia? = nil) -> CodeBlockSyntax {
    let codeBlock = SyntaxFactory.makeCodeBlock(
      leftBrace: leftBrace,
      statements: statements.buildCodeBlockItemList(format: format._indented()),
      rightBrace: rightBrace.withLeadingTrivia(.newlines(1) + format._makeIndent())
    )
    
    if let leadingTrivia = leadingTrivia {
      return codeBlock
        .withLeadingTrivia(leadingTrivia)
    }

    return codeBlock
  }

  /// Conformance for `CodeBlock` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let codeBlock = buildCodeBlock(format: format, leadingTrivia: leadingTrivia)
    return Syntax(codeBlock)
  }
}

public struct InOutExpr: ExprBuildable {
  let ampersand: TokenSyntax
  let expression: ExprBuildable

  public init(
    ampersand: TokenSyntax,
    expression: ExprBuildable
  ) {
    self.ampersand = ampersand
    self.expression = expression
  }
  
  func buildInOutExpr(format: Format, leadingTrivia: Trivia? = nil) -> InOutExprSyntax {
    let inOutExpr = SyntaxFactory.makeInOutExpr(
      ampersand: ampersand,
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return inOutExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return inOutExpr
  }

  /// Conformance for `InOutExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let inOutExpr = buildInOutExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(inOutExpr)
  }
}

public struct PoundColumnExpr: ExprBuildable {
  let poundColumn: TokenSyntax

  public init(
    poundColumn: TokenSyntax
  ) {
    self.poundColumn = poundColumn
  }
  
  func buildPoundColumnExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundColumnExprSyntax {
    let poundColumnExpr = SyntaxFactory.makePoundColumnExpr(
      poundColumn: poundColumn
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundColumnExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return poundColumnExpr
  }

  /// Conformance for `PoundColumnExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundColumnExpr = buildPoundColumnExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundColumnExpr)
  }
}

// MARK: - Syntax collection
public struct TupleExprElementList: SyntaxBuildable {
  let elements: [TupleExprElement]

  public init(_ elements: [TupleExprElement]) {
    self.elements = elements
  }

  public func buildTupleExprElementList(format: Format, leadingTrivia: Trivia? = nil) -> TupleExprElementListSyntax {
    return SyntaxFactory.makeTupleExprElementList(elements.map {
      $0.buildTupleExprElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tupleExprElementList = buildTupleExprElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(tupleExprElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(tupleExprElementList)
  }
}

// MARK: - Syntax collection
public struct ArrayElementList: SyntaxBuildable {
  let elements: [ArrayElement]

  public init(_ elements: [ArrayElement]) {
    self.elements = elements
  }

  public func buildArrayElementList(format: Format, leadingTrivia: Trivia? = nil) -> ArrayElementListSyntax {
    return SyntaxFactory.makeArrayElementList(elements.map {
      $0.buildArrayElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let arrayElementList = buildArrayElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(arrayElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(arrayElementList)
  }
}

// MARK: - Syntax collection
public struct DictionaryElementList: SyntaxBuildable {
  let elements: [DictionaryElement]

  public init(_ elements: [DictionaryElement]) {
    self.elements = elements
  }

  public func buildDictionaryElementList(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryElementListSyntax {
    return SyntaxFactory.makeDictionaryElementList(elements.map {
      $0.buildDictionaryElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let dictionaryElementList = buildDictionaryElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(dictionaryElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(dictionaryElementList)
  }
}

// MARK: - Syntax collection
public struct StringLiteralSegments: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [SyntaxBuildable]) {
    self.elements = elements
  }

  public func buildStringLiteralSegments(format: Format, leadingTrivia: Trivia? = nil) -> StringLiteralSegmentsSyntax {
    return SyntaxFactory.makeStringLiteralSegments(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let stringLiteralSegments = buildStringLiteralSegments(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(stringLiteralSegments).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(stringLiteralSegments)
  }
}

public struct TryExpr: ExprBuildable {
  let tryKeyword: TokenSyntax
  let questionOrExclamationMark: TokenSyntax?
  let expression: ExprBuildable

  public init(
    tryKeyword: TokenSyntax,
    questionOrExclamationMark: TokenSyntax?,
    expression: ExprBuildable
  ) {
    self.tryKeyword = tryKeyword
    self.questionOrExclamationMark = questionOrExclamationMark
    self.expression = expression
  }
  
  func buildTryExpr(format: Format, leadingTrivia: Trivia? = nil) -> TryExprSyntax {
    let tryExpr = SyntaxFactory.makeTryExpr(
      tryKeyword: tryKeyword,
      questionOrExclamationMark: questionOrExclamationMark,
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return tryExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return tryExpr
  }

  /// Conformance for `TryExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let tryExpr = buildTryExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(tryExpr)
  }
}

public struct AwaitExpr: ExprBuildable {
  let awaitKeyword: TokenSyntax
  let expression: ExprBuildable

  public init(
    awaitKeyword: TokenSyntax,
    expression: ExprBuildable
  ) {
    self.awaitKeyword = awaitKeyword
    self.expression = expression
  }
  
  func buildAwaitExpr(format: Format, leadingTrivia: Trivia? = nil) -> AwaitExprSyntax {
    let awaitExpr = SyntaxFactory.makeAwaitExpr(
      awaitKeyword: awaitKeyword,
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return awaitExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return awaitExpr
  }

  /// Conformance for `AwaitExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let awaitExpr = buildAwaitExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(awaitExpr)
  }
}

public struct DeclNameArgument: SyntaxBuildable {
  let name: TokenSyntax
  let colon: TokenSyntax

  public init(
    name: TokenSyntax,
    colon: TokenSyntax
  ) {
    self.name = name
    self.colon = colon
  }
  
  func buildDeclNameArgument(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameArgumentSyntax {
    let declNameArgument = SyntaxFactory.makeDeclNameArgument(
      name: name,
      colon: colon
    )
    
    if let leadingTrivia = leadingTrivia {
      return declNameArgument
        .withLeadingTrivia(leadingTrivia)
    }

    return declNameArgument
  }

  /// Conformance for `DeclNameArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declNameArgument = buildDeclNameArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(declNameArgument)
  }
}

// MARK: - Syntax collection
public struct DeclNameArgumentList: SyntaxBuildable {
  let elements: [DeclNameArgument]

  public init(_ elements: [DeclNameArgument]) {
    self.elements = elements
  }

  public func buildDeclNameArgumentList(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameArgumentListSyntax {
    return SyntaxFactory.makeDeclNameArgumentList(elements.map {
      $0.buildDeclNameArgument(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declNameArgumentList = buildDeclNameArgumentList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(declNameArgumentList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(declNameArgumentList)
  }
}

public struct DeclNameArguments: SyntaxBuildable {
  let leftParen: TokenSyntax
  let arguments: DeclNameArgumentList
  let rightParen: TokenSyntax

  public init(
    leftParen: TokenSyntax,
    arguments: DeclNameArgumentList,
    rightParen: TokenSyntax
  ) {
    self.leftParen = leftParen
    self.arguments = arguments
    self.rightParen = rightParen
  }
  
  func buildDeclNameArguments(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameArgumentsSyntax {
    let declNameArguments = SyntaxFactory.makeDeclNameArguments(
      leftParen: leftParen,
      arguments: arguments.buildDeclNameArgumentList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return declNameArguments
        .withLeadingTrivia(leadingTrivia)
    }

    return declNameArguments
  }

  /// Conformance for `DeclNameArguments` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declNameArguments = buildDeclNameArguments(format: format, leadingTrivia: leadingTrivia)
    return Syntax(declNameArguments)
  }
}

public struct IdentifierExpr: ExprBuildable {
  let identifier: TokenSyntax
  let declNameArguments: DeclNameArguments?

  public init(
    identifier: TokenSyntax,
    declNameArguments: DeclNameArguments?
  ) {
    self.identifier = identifier
    self.declNameArguments = declNameArguments
  }
  
  func buildIdentifierExpr(format: Format, leadingTrivia: Trivia? = nil) -> IdentifierExprSyntax {
    let identifierExpr = SyntaxFactory.makeIdentifierExpr(
      identifier: identifier,
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return identifierExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return identifierExpr
  }

  /// Conformance for `IdentifierExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let identifierExpr = buildIdentifierExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(identifierExpr)
  }
}

public struct SuperRefExpr: ExprBuildable {
  let superKeyword: TokenSyntax

  public init(
    superKeyword: TokenSyntax
  ) {
    self.superKeyword = superKeyword
  }
  
  func buildSuperRefExpr(format: Format, leadingTrivia: Trivia? = nil) -> SuperRefExprSyntax {
    let superRefExpr = SyntaxFactory.makeSuperRefExpr(
      superKeyword: superKeyword
    )
    
    if let leadingTrivia = leadingTrivia {
      return superRefExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return superRefExpr
  }

  /// Conformance for `SuperRefExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let superRefExpr = buildSuperRefExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(superRefExpr)
  }
}

public struct NilLiteralExpr: ExprBuildable {
  let nilKeyword: TokenSyntax

  public init(
    nilKeyword: TokenSyntax
  ) {
    self.nilKeyword = nilKeyword
  }
  
  func buildNilLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> NilLiteralExprSyntax {
    let nilLiteralExpr = SyntaxFactory.makeNilLiteralExpr(
      nilKeyword: nilKeyword
    )
    
    if let leadingTrivia = leadingTrivia {
      return nilLiteralExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return nilLiteralExpr
  }

  /// Conformance for `NilLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let nilLiteralExpr = buildNilLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(nilLiteralExpr)
  }
}

public struct DiscardAssignmentExpr: ExprBuildable {
  let wildcard: TokenSyntax

  public init(
    wildcard: TokenSyntax
  ) {
    self.wildcard = wildcard
  }
  
  func buildDiscardAssignmentExpr(format: Format, leadingTrivia: Trivia? = nil) -> DiscardAssignmentExprSyntax {
    let discardAssignmentExpr = SyntaxFactory.makeDiscardAssignmentExpr(
      wildcard: wildcard
    )
    
    if let leadingTrivia = leadingTrivia {
      return discardAssignmentExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return discardAssignmentExpr
  }

  /// Conformance for `DiscardAssignmentExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let discardAssignmentExpr = buildDiscardAssignmentExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(discardAssignmentExpr)
  }
}

public struct AssignmentExpr: ExprBuildable {
  let assignToken: TokenSyntax

  public init(
    assignToken: TokenSyntax
  ) {
    self.assignToken = assignToken
  }
  
  func buildAssignmentExpr(format: Format, leadingTrivia: Trivia? = nil) -> AssignmentExprSyntax {
    let assignmentExpr = SyntaxFactory.makeAssignmentExpr(
      assignToken: assignToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return assignmentExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return assignmentExpr
  }

  /// Conformance for `AssignmentExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let assignmentExpr = buildAssignmentExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(assignmentExpr)
  }
}

public struct SequenceExpr: ExprBuildable {
  let elements: ExprList

  public init(
    elements: ExprList
  ) {
    self.elements = elements
  }
  
  func buildSequenceExpr(format: Format, leadingTrivia: Trivia? = nil) -> SequenceExprSyntax {
    let sequenceExpr = SyntaxFactory.makeSequenceExpr(
      elements: elements.buildExprList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return sequenceExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return sequenceExpr
  }

  /// Conformance for `SequenceExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let sequenceExpr = buildSequenceExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(sequenceExpr)
  }
}

// MARK: - Syntax collection
public struct ExprList: SyntaxBuildable {
  let elements: [ExprBuildable]

  public init(_ elements: [ExprBuildable]) {
    self.elements = elements
  }

  public func buildExprList(format: Format, leadingTrivia: Trivia? = nil) -> ExprListSyntax {
    return SyntaxFactory.makeExprList(elements.map {
      $0.buildExpr(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let exprList = buildExprList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(exprList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(exprList)
  }
}

public struct PoundLineExpr: ExprBuildable {
  let poundLine: TokenSyntax

  public init(
    poundLine: TokenSyntax
  ) {
    self.poundLine = poundLine
  }
  
  func buildPoundLineExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundLineExprSyntax {
    let poundLineExpr = SyntaxFactory.makePoundLineExpr(
      poundLine: poundLine
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundLineExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return poundLineExpr
  }

  /// Conformance for `PoundLineExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundLineExpr = buildPoundLineExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundLineExpr)
  }
}

public struct PoundFileExpr: ExprBuildable {
  let poundFile: TokenSyntax

  public init(
    poundFile: TokenSyntax
  ) {
    self.poundFile = poundFile
  }
  
  func buildPoundFileExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFileExprSyntax {
    let poundFileExpr = SyntaxFactory.makePoundFileExpr(
      poundFile: poundFile
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundFileExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return poundFileExpr
  }

  /// Conformance for `PoundFileExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundFileExpr = buildPoundFileExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundFileExpr)
  }
}

public struct PoundFileIDExpr: ExprBuildable {
  let poundFileID: TokenSyntax

  public init(
    poundFileID: TokenSyntax
  ) {
    self.poundFileID = poundFileID
  }
  
  func buildPoundFileIDExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFileIDExprSyntax {
    let poundFileIDExpr = SyntaxFactory.makePoundFileIDExpr(
      poundFileID: poundFileID
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundFileIDExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return poundFileIDExpr
  }

  /// Conformance for `PoundFileIDExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundFileIDExpr = buildPoundFileIDExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundFileIDExpr)
  }
}

public struct PoundFilePathExpr: ExprBuildable {
  let poundFilePath: TokenSyntax

  public init(
    poundFilePath: TokenSyntax
  ) {
    self.poundFilePath = poundFilePath
  }
  
  func buildPoundFilePathExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFilePathExprSyntax {
    let poundFilePathExpr = SyntaxFactory.makePoundFilePathExpr(
      poundFilePath: poundFilePath
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundFilePathExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return poundFilePathExpr
  }

  /// Conformance for `PoundFilePathExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundFilePathExpr = buildPoundFilePathExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundFilePathExpr)
  }
}

public struct PoundFunctionExpr: ExprBuildable {
  let poundFunction: TokenSyntax

  public init(
    poundFunction: TokenSyntax
  ) {
    self.poundFunction = poundFunction
  }
  
  func buildPoundFunctionExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFunctionExprSyntax {
    let poundFunctionExpr = SyntaxFactory.makePoundFunctionExpr(
      poundFunction: poundFunction
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundFunctionExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return poundFunctionExpr
  }

  /// Conformance for `PoundFunctionExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundFunctionExpr = buildPoundFunctionExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundFunctionExpr)
  }
}

public struct PoundDsohandleExpr: ExprBuildable {
  let poundDsohandle: TokenSyntax

  public init(
    poundDsohandle: TokenSyntax
  ) {
    self.poundDsohandle = poundDsohandle
  }
  
  func buildPoundDsohandleExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundDsohandleExprSyntax {
    let poundDsohandleExpr = SyntaxFactory.makePoundDsohandleExpr(
      poundDsohandle: poundDsohandle
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundDsohandleExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return poundDsohandleExpr
  }

  /// Conformance for `PoundDsohandleExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundDsohandleExpr = buildPoundDsohandleExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundDsohandleExpr)
  }
}

public struct SymbolicReferenceExpr: ExprBuildable {
  let identifier: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  public init(
    identifier: TokenSyntax,
    genericArgumentClause: GenericArgumentClause?
  ) {
    self.identifier = identifier
    self.genericArgumentClause = genericArgumentClause
  }
  
  func buildSymbolicReferenceExpr(format: Format, leadingTrivia: Trivia? = nil) -> SymbolicReferenceExprSyntax {
    let symbolicReferenceExpr = SyntaxFactory.makeSymbolicReferenceExpr(
      identifier: identifier,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return symbolicReferenceExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return symbolicReferenceExpr
  }

  /// Conformance for `SymbolicReferenceExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let symbolicReferenceExpr = buildSymbolicReferenceExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(symbolicReferenceExpr)
  }
}

public struct PrefixOperatorExpr: ExprBuildable {
  let operatorToken: TokenSyntax?
  let postfixExpression: ExprBuildable

  public init(
    operatorToken: TokenSyntax?,
    postfixExpression: ExprBuildable
  ) {
    self.operatorToken = operatorToken
    self.postfixExpression = postfixExpression
  }
  
  func buildPrefixOperatorExpr(format: Format, leadingTrivia: Trivia? = nil) -> PrefixOperatorExprSyntax {
    let prefixOperatorExpr = SyntaxFactory.makePrefixOperatorExpr(
      operatorToken: operatorToken,
      postfixExpression: postfixExpression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return prefixOperatorExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return prefixOperatorExpr
  }

  /// Conformance for `PrefixOperatorExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let prefixOperatorExpr = buildPrefixOperatorExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(prefixOperatorExpr)
  }
}

public struct BinaryOperatorExpr: ExprBuildable {
  let operatorToken: TokenSyntax

  public init(
    operatorToken: TokenSyntax
  ) {
    self.operatorToken = operatorToken
  }
  
  func buildBinaryOperatorExpr(format: Format, leadingTrivia: Trivia? = nil) -> BinaryOperatorExprSyntax {
    let binaryOperatorExpr = SyntaxFactory.makeBinaryOperatorExpr(
      operatorToken: operatorToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return binaryOperatorExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return binaryOperatorExpr
  }

  /// Conformance for `BinaryOperatorExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let binaryOperatorExpr = buildBinaryOperatorExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(binaryOperatorExpr)
  }
}

public struct ArrowExpr: ExprBuildable {
  let asyncKeyword: TokenSyntax?
  let throwsToken: TokenSyntax?
  let arrowToken: TokenSyntax

  public init(
    asyncKeyword: TokenSyntax?,
    throwsToken: TokenSyntax?,
    arrowToken: TokenSyntax
  ) {
    self.asyncKeyword = asyncKeyword
    self.throwsToken = throwsToken
    self.arrowToken = arrowToken
  }
  
  func buildArrowExpr(format: Format, leadingTrivia: Trivia? = nil) -> ArrowExprSyntax {
    let arrowExpr = SyntaxFactory.makeArrowExpr(
      asyncKeyword: asyncKeyword,
      throwsToken: throwsToken,
      arrowToken: arrowToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return arrowExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return arrowExpr
  }

  /// Conformance for `ArrowExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let arrowExpr = buildArrowExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(arrowExpr)
  }
}

public struct FloatLiteralExpr: ExprBuildable {
  let floatingDigits: TokenSyntax

  public init(
    floatingDigits: TokenSyntax
  ) {
    self.floatingDigits = floatingDigits
  }
  
  func buildFloatLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> FloatLiteralExprSyntax {
    let floatLiteralExpr = SyntaxFactory.makeFloatLiteralExpr(
      floatingDigits: floatingDigits
    )
    
    if let leadingTrivia = leadingTrivia {
      return floatLiteralExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return floatLiteralExpr
  }

  /// Conformance for `FloatLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let floatLiteralExpr = buildFloatLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(floatLiteralExpr)
  }
}

public struct TupleExpr: ExprBuildable {
  let leftParen: TokenSyntax
  let elementList: TupleExprElementList
  let rightParen: TokenSyntax

  public init(
    leftParen: TokenSyntax,
    elementList: TupleExprElementList,
    rightParen: TokenSyntax
  ) {
    self.leftParen = leftParen
    self.elementList = elementList
    self.rightParen = rightParen
  }
  
  func buildTupleExpr(format: Format, leadingTrivia: Trivia? = nil) -> TupleExprSyntax {
    let tupleExpr = SyntaxFactory.makeTupleExpr(
      leftParen: leftParen,
      elementList: elementList.buildTupleExprElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return tupleExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return tupleExpr
  }

  /// Conformance for `TupleExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let tupleExpr = buildTupleExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(tupleExpr)
  }
}

public struct ArrayExpr: ExprBuildable {
  let leftSquare: TokenSyntax
  let elements: ArrayElementList
  let rightSquare: TokenSyntax

  public init(
    leftSquare: TokenSyntax,
    elements: ArrayElementList,
    rightSquare: TokenSyntax
  ) {
    self.leftSquare = leftSquare
    self.elements = elements
    self.rightSquare = rightSquare
  }
  
  func buildArrayExpr(format: Format, leadingTrivia: Trivia? = nil) -> ArrayExprSyntax {
    let arrayExpr = SyntaxFactory.makeArrayExpr(
      leftSquare: leftSquare,
      elements: elements.buildArrayElementList(format: format),
      rightSquare: rightSquare
    )
    
    if let leadingTrivia = leadingTrivia {
      return arrayExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return arrayExpr
  }

  /// Conformance for `ArrayExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let arrayExpr = buildArrayExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(arrayExpr)
  }
}

public struct DictionaryExpr: ExprBuildable {
  let leftSquare: TokenSyntax
  let content: SyntaxBuildable
  let rightSquare: TokenSyntax

  public init(
    leftSquare: TokenSyntax,
    content: SyntaxBuildable,
    rightSquare: TokenSyntax
  ) {
    self.leftSquare = leftSquare
    self.content = content
    self.rightSquare = rightSquare
  }
  
  func buildDictionaryExpr(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryExprSyntax {
    let dictionaryExpr = SyntaxFactory.makeDictionaryExpr(
      leftSquare: leftSquare,
      content: content.buildSyntax(format: format),
      rightSquare: rightSquare
    )
    
    if let leadingTrivia = leadingTrivia {
      return dictionaryExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return dictionaryExpr
  }

  /// Conformance for `DictionaryExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let dictionaryExpr = buildDictionaryExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(dictionaryExpr)
  }
}

public struct TupleExprElement: SyntaxBuildable {
  let label: TokenSyntax?
  let colon: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  public init(
    label: TokenSyntax?,
    colon: TokenSyntax?,
    expression: ExprBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.label = label
    self.colon = colon
    self.expression = expression
    self.trailingComma = trailingComma
  }
  
  func buildTupleExprElement(format: Format, leadingTrivia: Trivia? = nil) -> TupleExprElementSyntax {
    let tupleExprElement = SyntaxFactory.makeTupleExprElement(
      label: label,
      colon: colon,
      expression: expression.buildExpr(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return tupleExprElement
        .withLeadingTrivia(leadingTrivia)
    }

    return tupleExprElement
  }

  /// Conformance for `TupleExprElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tupleExprElement = buildTupleExprElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(tupleExprElement)
  }
}

public struct ArrayElement: SyntaxBuildable {
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  public init(
    expression: ExprBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.expression = expression
    self.trailingComma = trailingComma
  }
  
  func buildArrayElement(format: Format, leadingTrivia: Trivia? = nil) -> ArrayElementSyntax {
    let arrayElement = SyntaxFactory.makeArrayElement(
      expression: expression.buildExpr(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return arrayElement
        .withLeadingTrivia(leadingTrivia)
    }

    return arrayElement
  }

  /// Conformance for `ArrayElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let arrayElement = buildArrayElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(arrayElement)
  }
}

public struct DictionaryElement: SyntaxBuildable {
  let keyExpression: ExprBuildable
  let colon: TokenSyntax
  let valueExpression: ExprBuildable
  let trailingComma: TokenSyntax?

  public init(
    keyExpression: ExprBuildable,
    colon: TokenSyntax,
    valueExpression: ExprBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.keyExpression = keyExpression
    self.colon = colon
    self.valueExpression = valueExpression
    self.trailingComma = trailingComma
  }
  
  func buildDictionaryElement(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryElementSyntax {
    let dictionaryElement = SyntaxFactory.makeDictionaryElement(
      keyExpression: keyExpression.buildExpr(format: format),
      colon: colon,
      valueExpression: valueExpression.buildExpr(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return dictionaryElement
        .withLeadingTrivia(leadingTrivia)
    }

    return dictionaryElement
  }

  /// Conformance for `DictionaryElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let dictionaryElement = buildDictionaryElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(dictionaryElement)
  }
}

public struct IntegerLiteralExpr: ExprBuildable {
  let digits: TokenSyntax

  public init(
    digits: TokenSyntax
  ) {
    self.digits = digits
  }
  
  func buildIntegerLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> IntegerLiteralExprSyntax {
    let integerLiteralExpr = SyntaxFactory.makeIntegerLiteralExpr(
      digits: digits
    )
    
    if let leadingTrivia = leadingTrivia {
      return integerLiteralExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return integerLiteralExpr
  }

  /// Conformance for `IntegerLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let integerLiteralExpr = buildIntegerLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(integerLiteralExpr)
  }
}

public struct BooleanLiteralExpr: ExprBuildable {
  let booleanLiteral: TokenSyntax

  public init(
    booleanLiteral: TokenSyntax
  ) {
    self.booleanLiteral = booleanLiteral
  }
  
  func buildBooleanLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> BooleanLiteralExprSyntax {
    let booleanLiteralExpr = SyntaxFactory.makeBooleanLiteralExpr(
      booleanLiteral: booleanLiteral
    )
    
    if let leadingTrivia = leadingTrivia {
      return booleanLiteralExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return booleanLiteralExpr
  }

  /// Conformance for `BooleanLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let booleanLiteralExpr = buildBooleanLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(booleanLiteralExpr)
  }
}

public struct TernaryExpr: ExprBuildable {
  let conditionExpression: ExprBuildable
  let questionMark: TokenSyntax
  let firstChoice: ExprBuildable
  let colonMark: TokenSyntax
  let secondChoice: ExprBuildable

  public init(
    conditionExpression: ExprBuildable,
    questionMark: TokenSyntax,
    firstChoice: ExprBuildable,
    colonMark: TokenSyntax,
    secondChoice: ExprBuildable
  ) {
    self.conditionExpression = conditionExpression
    self.questionMark = questionMark
    self.firstChoice = firstChoice
    self.colonMark = colonMark
    self.secondChoice = secondChoice
  }
  
  func buildTernaryExpr(format: Format, leadingTrivia: Trivia? = nil) -> TernaryExprSyntax {
    let ternaryExpr = SyntaxFactory.makeTernaryExpr(
      conditionExpression: conditionExpression.buildExpr(format: format),
      questionMark: questionMark,
      firstChoice: firstChoice.buildExpr(format: format),
      colonMark: colonMark,
      secondChoice: secondChoice.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return ternaryExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return ternaryExpr
  }

  /// Conformance for `TernaryExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let ternaryExpr = buildTernaryExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(ternaryExpr)
  }
}

public struct MemberAccessExpr: ExprBuildable {
  let base: ExprBuildable?
  let dot: TokenSyntax
  let name: TokenSyntax
  let declNameArguments: DeclNameArguments?

  public init(
    base: ExprBuildable?,
    dot: TokenSyntax,
    name: TokenSyntax,
    declNameArguments: DeclNameArguments?
  ) {
    self.base = base
    self.dot = dot
    self.name = name
    self.declNameArguments = declNameArguments
  }
  
  func buildMemberAccessExpr(format: Format, leadingTrivia: Trivia? = nil) -> MemberAccessExprSyntax {
    let memberAccessExpr = SyntaxFactory.makeMemberAccessExpr(
      base: base?.buildExpr(format: format),
      dot: dot,
      name: name,
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return memberAccessExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return memberAccessExpr
  }

  /// Conformance for `MemberAccessExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let memberAccessExpr = buildMemberAccessExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(memberAccessExpr)
  }
}

public struct IsExpr: ExprBuildable {
  let isTok: TokenSyntax
  let typeName: TypeBuildable

  public init(
    isTok: TokenSyntax,
    typeName: TypeBuildable
  ) {
    self.isTok = isTok
    self.typeName = typeName
  }
  
  func buildIsExpr(format: Format, leadingTrivia: Trivia? = nil) -> IsExprSyntax {
    let isExpr = SyntaxFactory.makeIsExpr(
      isTok: isTok,
      typeName: typeName.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return isExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return isExpr
  }

  /// Conformance for `IsExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let isExpr = buildIsExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(isExpr)
  }
}

public struct AsExpr: ExprBuildable {
  let asTok: TokenSyntax
  let questionOrExclamationMark: TokenSyntax?
  let typeName: TypeBuildable

  public init(
    asTok: TokenSyntax,
    questionOrExclamationMark: TokenSyntax?,
    typeName: TypeBuildable
  ) {
    self.asTok = asTok
    self.questionOrExclamationMark = questionOrExclamationMark
    self.typeName = typeName
  }
  
  func buildAsExpr(format: Format, leadingTrivia: Trivia? = nil) -> AsExprSyntax {
    let asExpr = SyntaxFactory.makeAsExpr(
      asTok: asTok,
      questionOrExclamationMark: questionOrExclamationMark,
      typeName: typeName.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return asExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return asExpr
  }

  /// Conformance for `AsExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let asExpr = buildAsExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(asExpr)
  }
}

public struct TypeExpr: ExprBuildable {
  let type: TypeBuildable

  public init(
    type: TypeBuildable
  ) {
    self.type = type
  }
  
  func buildTypeExpr(format: Format, leadingTrivia: Trivia? = nil) -> TypeExprSyntax {
    let typeExpr = SyntaxFactory.makeTypeExpr(
      type: type.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typeExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return typeExpr
  }

  /// Conformance for `TypeExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let typeExpr = buildTypeExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(typeExpr)
  }
}

public struct ClosureCaptureItem: SyntaxBuildable {
  let specifier: TokenListSyntax?
  let name: TokenSyntax?
  let assignToken: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  public init(
    specifier: TokenListSyntax?,
    name: TokenSyntax?,
    assignToken: TokenSyntax?,
    expression: ExprBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.specifier = specifier
    self.name = name
    self.assignToken = assignToken
    self.expression = expression
    self.trailingComma = trailingComma
  }
  
  func buildClosureCaptureItem(format: Format, leadingTrivia: Trivia? = nil) -> ClosureCaptureItemSyntax {
    let closureCaptureItem = SyntaxFactory.makeClosureCaptureItem(
      specifier: specifier,
      name: name,
      assignToken: assignToken,
      expression: expression.buildExpr(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureCaptureItem
        .withLeadingTrivia(leadingTrivia)
    }

    return closureCaptureItem
  }

  /// Conformance for `ClosureCaptureItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureCaptureItem = buildClosureCaptureItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(closureCaptureItem)
  }
}

// MARK: - Syntax collection
public struct ClosureCaptureItemList: SyntaxBuildable {
  let elements: [ClosureCaptureItem]

  public init(_ elements: [ClosureCaptureItem]) {
    self.elements = elements
  }

  public func buildClosureCaptureItemList(format: Format, leadingTrivia: Trivia? = nil) -> ClosureCaptureItemListSyntax {
    return SyntaxFactory.makeClosureCaptureItemList(elements.map {
      $0.buildClosureCaptureItem(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureCaptureItemList = buildClosureCaptureItemList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(closureCaptureItemList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(closureCaptureItemList)
  }
}

public struct ClosureCaptureSignature: SyntaxBuildable {
  let leftSquare: TokenSyntax
  let items: ClosureCaptureItemList?
  let rightSquare: TokenSyntax

  public init(
    leftSquare: TokenSyntax,
    items: ClosureCaptureItemList?,
    rightSquare: TokenSyntax
  ) {
    self.leftSquare = leftSquare
    self.items = items
    self.rightSquare = rightSquare
  }
  
  func buildClosureCaptureSignature(format: Format, leadingTrivia: Trivia? = nil) -> ClosureCaptureSignatureSyntax {
    let closureCaptureSignature = SyntaxFactory.makeClosureCaptureSignature(
      leftSquare: leftSquare,
      items: items?.buildClosureCaptureItemList(format: format),
      rightSquare: rightSquare
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureCaptureSignature
        .withLeadingTrivia(leadingTrivia)
    }

    return closureCaptureSignature
  }

  /// Conformance for `ClosureCaptureSignature` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureCaptureSignature = buildClosureCaptureSignature(format: format, leadingTrivia: leadingTrivia)
    return Syntax(closureCaptureSignature)
  }
}

public struct ClosureParam: SyntaxBuildable {
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  public init(
    name: TokenSyntax,
    trailingComma: TokenSyntax?
  ) {
    self.name = name
    self.trailingComma = trailingComma
  }
  
  func buildClosureParam(format: Format, leadingTrivia: Trivia? = nil) -> ClosureParamSyntax {
    let closureParam = SyntaxFactory.makeClosureParam(
      name: name,
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureParam
        .withLeadingTrivia(leadingTrivia)
    }

    return closureParam
  }

  /// Conformance for `ClosureParam` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureParam = buildClosureParam(format: format, leadingTrivia: leadingTrivia)
    return Syntax(closureParam)
  }
}

// MARK: - Syntax collection
public struct ClosureParamList: SyntaxBuildable {
  let elements: [ClosureParam]

  public init(_ elements: [ClosureParam]) {
    self.elements = elements
  }

  public func buildClosureParamList(format: Format, leadingTrivia: Trivia? = nil) -> ClosureParamListSyntax {
    return SyntaxFactory.makeClosureParamList(elements.map {
      $0.buildClosureParam(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureParamList = buildClosureParamList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(closureParamList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(closureParamList)
  }
}

public struct ClosureSignature: SyntaxBuildable {
  let capture: ClosureCaptureSignature?
  let input: SyntaxBuildable?
  let asyncKeyword: TokenSyntax?
  let throwsTok: TokenSyntax?
  let output: ReturnClause?
  let inTok: TokenSyntax

  public init(
    capture: ClosureCaptureSignature?,
    input: SyntaxBuildable?,
    asyncKeyword: TokenSyntax?,
    throwsTok: TokenSyntax?,
    output: ReturnClause?,
    inTok: TokenSyntax
  ) {
    self.capture = capture
    self.input = input
    self.asyncKeyword = asyncKeyword
    self.throwsTok = throwsTok
    self.output = output
    self.inTok = inTok
  }
  
  func buildClosureSignature(format: Format, leadingTrivia: Trivia? = nil) -> ClosureSignatureSyntax {
    let closureSignature = SyntaxFactory.makeClosureSignature(
      capture: capture?.buildClosureCaptureSignature(format: format),
      input: input?.buildSyntax(format: format),
      asyncKeyword: asyncKeyword,
      throwsTok: throwsTok,
      output: output?.buildReturnClause(format: format),
      inTok: inTok
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureSignature
        .withLeadingTrivia(leadingTrivia)
    }

    return closureSignature
  }

  /// Conformance for `ClosureSignature` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureSignature = buildClosureSignature(format: format, leadingTrivia: leadingTrivia)
    return Syntax(closureSignature)
  }
}

public struct ClosureExpr: ExprBuildable {
  let leftBrace: TokenSyntax
  let signature: ClosureSignature?
  let statements: CodeBlockItemList
  let rightBrace: TokenSyntax

  public init(
    leftBrace: TokenSyntax,
    signature: ClosureSignature?,
    statements: CodeBlockItemList,
    rightBrace: TokenSyntax
  ) {
    self.leftBrace = leftBrace
    self.signature = signature
    self.statements = statements
    self.rightBrace = rightBrace
  }
  
  func buildClosureExpr(format: Format, leadingTrivia: Trivia? = nil) -> ClosureExprSyntax {
    let closureExpr = SyntaxFactory.makeClosureExpr(
      leftBrace: leftBrace,
      signature: signature?.buildClosureSignature(format: format),
      statements: statements.buildCodeBlockItemList(format: format),
      rightBrace: rightBrace
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return closureExpr
  }

  /// Conformance for `ClosureExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let closureExpr = buildClosureExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(closureExpr)
  }
}

public struct UnresolvedPatternExpr: ExprBuildable {
  let pattern: PatternBuildable

  public init(
    pattern: PatternBuildable
  ) {
    self.pattern = pattern
  }
  
  func buildUnresolvedPatternExpr(format: Format, leadingTrivia: Trivia? = nil) -> UnresolvedPatternExprSyntax {
    let unresolvedPatternExpr = SyntaxFactory.makeUnresolvedPatternExpr(
      pattern: pattern.buildPattern(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return unresolvedPatternExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return unresolvedPatternExpr
  }

  /// Conformance for `UnresolvedPatternExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let unresolvedPatternExpr = buildUnresolvedPatternExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(unresolvedPatternExpr)
  }
}

public struct MultipleTrailingClosureElement: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let closure: ClosureExpr

  public init(
    label: TokenSyntax,
    colon: TokenSyntax,
    closure: ClosureExpr
  ) {
    self.label = label
    self.colon = colon
    self.closure = closure
  }
  
  func buildMultipleTrailingClosureElement(format: Format, leadingTrivia: Trivia? = nil) -> MultipleTrailingClosureElementSyntax {
    let multipleTrailingClosureElement = SyntaxFactory.makeMultipleTrailingClosureElement(
      label: label,
      colon: colon,
      closure: closure.buildClosureExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return multipleTrailingClosureElement
        .withLeadingTrivia(leadingTrivia)
    }

    return multipleTrailingClosureElement
  }

  /// Conformance for `MultipleTrailingClosureElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let multipleTrailingClosureElement = buildMultipleTrailingClosureElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(multipleTrailingClosureElement)
  }
}

// MARK: - Syntax collection
public struct MultipleTrailingClosureElementList: SyntaxBuildable {
  let elements: [MultipleTrailingClosureElement]

  public init(_ elements: [MultipleTrailingClosureElement]) {
    self.elements = elements
  }

  public func buildMultipleTrailingClosureElementList(format: Format, leadingTrivia: Trivia? = nil) -> MultipleTrailingClosureElementListSyntax {
    return SyntaxFactory.makeMultipleTrailingClosureElementList(elements.map {
      $0.buildMultipleTrailingClosureElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let multipleTrailingClosureElementList = buildMultipleTrailingClosureElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(multipleTrailingClosureElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(multipleTrailingClosureElementList)
  }
}

public struct FunctionCallExpr: ExprBuildable {
  let calledExpression: ExprBuildable
  let leftParen: TokenSyntax?
  let argumentList: TupleExprElementList
  let rightParen: TokenSyntax?
  let trailingClosure: ClosureExpr?
  let additionalTrailingClosures: MultipleTrailingClosureElementList?

  public init(
    calledExpression: ExprBuildable,
    leftParen: TokenSyntax?,
    argumentList: TupleExprElementList,
    rightParen: TokenSyntax?,
    trailingClosure: ClosureExpr?,
    additionalTrailingClosures: MultipleTrailingClosureElementList?
  ) {
    self.calledExpression = calledExpression
    self.leftParen = leftParen
    self.argumentList = argumentList
    self.rightParen = rightParen
    self.trailingClosure = trailingClosure
    self.additionalTrailingClosures = additionalTrailingClosures
  }
  
  func buildFunctionCallExpr(format: Format, leadingTrivia: Trivia? = nil) -> FunctionCallExprSyntax {
    let functionCallExpr = SyntaxFactory.makeFunctionCallExpr(
      calledExpression: calledExpression.buildExpr(format: format),
      leftParen: leftParen,
      argumentList: argumentList.buildTupleExprElementList(format: format),
      rightParen: rightParen,
      trailingClosure: trailingClosure?.buildClosureExpr(format: format),
      additionalTrailingClosures: additionalTrailingClosures?.buildMultipleTrailingClosureElementList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return functionCallExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return functionCallExpr
  }

  /// Conformance for `FunctionCallExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let functionCallExpr = buildFunctionCallExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(functionCallExpr)
  }
}

public struct SubscriptExpr: ExprBuildable {
  let calledExpression: ExprBuildable
  let leftBracket: TokenSyntax
  let argumentList: TupleExprElementList
  let rightBracket: TokenSyntax
  let trailingClosure: ClosureExpr?
  let additionalTrailingClosures: MultipleTrailingClosureElementList?

  public init(
    calledExpression: ExprBuildable,
    leftBracket: TokenSyntax,
    argumentList: TupleExprElementList,
    rightBracket: TokenSyntax,
    trailingClosure: ClosureExpr?,
    additionalTrailingClosures: MultipleTrailingClosureElementList?
  ) {
    self.calledExpression = calledExpression
    self.leftBracket = leftBracket
    self.argumentList = argumentList
    self.rightBracket = rightBracket
    self.trailingClosure = trailingClosure
    self.additionalTrailingClosures = additionalTrailingClosures
  }
  
  func buildSubscriptExpr(format: Format, leadingTrivia: Trivia? = nil) -> SubscriptExprSyntax {
    let subscriptExpr = SyntaxFactory.makeSubscriptExpr(
      calledExpression: calledExpression.buildExpr(format: format),
      leftBracket: leftBracket,
      argumentList: argumentList.buildTupleExprElementList(format: format),
      rightBracket: rightBracket,
      trailingClosure: trailingClosure?.buildClosureExpr(format: format),
      additionalTrailingClosures: additionalTrailingClosures?.buildMultipleTrailingClosureElementList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return subscriptExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return subscriptExpr
  }

  /// Conformance for `SubscriptExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let subscriptExpr = buildSubscriptExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(subscriptExpr)
  }
}

public struct OptionalChainingExpr: ExprBuildable {
  let expression: ExprBuildable
  let questionMark: TokenSyntax

  public init(
    expression: ExprBuildable,
    questionMark: TokenSyntax
  ) {
    self.expression = expression
    self.questionMark = questionMark
  }
  
  func buildOptionalChainingExpr(format: Format, leadingTrivia: Trivia? = nil) -> OptionalChainingExprSyntax {
    let optionalChainingExpr = SyntaxFactory.makeOptionalChainingExpr(
      expression: expression.buildExpr(format: format),
      questionMark: questionMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return optionalChainingExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return optionalChainingExpr
  }

  /// Conformance for `OptionalChainingExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let optionalChainingExpr = buildOptionalChainingExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(optionalChainingExpr)
  }
}

public struct ForcedValueExpr: ExprBuildable {
  let expression: ExprBuildable
  let exclamationMark: TokenSyntax

  public init(
    expression: ExprBuildable,
    exclamationMark: TokenSyntax
  ) {
    self.expression = expression
    self.exclamationMark = exclamationMark
  }
  
  func buildForcedValueExpr(format: Format, leadingTrivia: Trivia? = nil) -> ForcedValueExprSyntax {
    let forcedValueExpr = SyntaxFactory.makeForcedValueExpr(
      expression: expression.buildExpr(format: format),
      exclamationMark: exclamationMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return forcedValueExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return forcedValueExpr
  }

  /// Conformance for `ForcedValueExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let forcedValueExpr = buildForcedValueExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(forcedValueExpr)
  }
}

public struct PostfixUnaryExpr: ExprBuildable {
  let expression: ExprBuildable
  let operatorToken: TokenSyntax

  public init(
    expression: ExprBuildable,
    operatorToken: TokenSyntax
  ) {
    self.expression = expression
    self.operatorToken = operatorToken
  }
  
  func buildPostfixUnaryExpr(format: Format, leadingTrivia: Trivia? = nil) -> PostfixUnaryExprSyntax {
    let postfixUnaryExpr = SyntaxFactory.makePostfixUnaryExpr(
      expression: expression.buildExpr(format: format),
      operatorToken: operatorToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return postfixUnaryExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return postfixUnaryExpr
  }

  /// Conformance for `PostfixUnaryExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let postfixUnaryExpr = buildPostfixUnaryExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(postfixUnaryExpr)
  }
}

public struct SpecializeExpr: ExprBuildable {
  let expression: ExprBuildable
  let genericArgumentClause: GenericArgumentClause

  public init(
    expression: ExprBuildable,
    genericArgumentClause: GenericArgumentClause
  ) {
    self.expression = expression
    self.genericArgumentClause = genericArgumentClause
  }
  
  func buildSpecializeExpr(format: Format, leadingTrivia: Trivia? = nil) -> SpecializeExprSyntax {
    let specializeExpr = SyntaxFactory.makeSpecializeExpr(
      expression: expression.buildExpr(format: format),
      genericArgumentClause: genericArgumentClause.buildGenericArgumentClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return specializeExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return specializeExpr
  }

  /// Conformance for `SpecializeExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let specializeExpr = buildSpecializeExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(specializeExpr)
  }
}

public struct StringSegment: SyntaxBuildable {
  let content: TokenSyntax

  public init(
    content: TokenSyntax
  ) {
    self.content = content
  }
  
  func buildStringSegment(format: Format, leadingTrivia: Trivia? = nil) -> StringSegmentSyntax {
    let stringSegment = SyntaxFactory.makeStringSegment(
      content: content
    )
    
    if let leadingTrivia = leadingTrivia {
      return stringSegment
        .withLeadingTrivia(leadingTrivia)
    }

    return stringSegment
  }

  /// Conformance for `StringSegment` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let stringSegment = buildStringSegment(format: format, leadingTrivia: leadingTrivia)
    return Syntax(stringSegment)
  }
}

public struct ExpressionSegment: SyntaxBuildable {
  let backslash: TokenSyntax
  let delimiter: TokenSyntax?
  let leftParen: TokenSyntax
  let expressions: TupleExprElementList
  let rightParen: TokenSyntax

  public init(
    backslash: TokenSyntax,
    delimiter: TokenSyntax?,
    leftParen: TokenSyntax,
    expressions: TupleExprElementList,
    rightParen: TokenSyntax
  ) {
    self.backslash = backslash
    self.delimiter = delimiter
    self.leftParen = leftParen
    self.expressions = expressions
    self.rightParen = rightParen
  }
  
  func buildExpressionSegment(format: Format, leadingTrivia: Trivia? = nil) -> ExpressionSegmentSyntax {
    let expressionSegment = SyntaxFactory.makeExpressionSegment(
      backslash: backslash,
      delimiter: delimiter,
      leftParen: leftParen,
      expressions: expressions.buildTupleExprElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return expressionSegment
        .withLeadingTrivia(leadingTrivia)
    }

    return expressionSegment
  }

  /// Conformance for `ExpressionSegment` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let expressionSegment = buildExpressionSegment(format: format, leadingTrivia: leadingTrivia)
    return Syntax(expressionSegment)
  }
}

public struct StringLiteralExpr: ExprBuildable {
  let openDelimiter: TokenSyntax?
  let openQuote: TokenSyntax
  let segments: StringLiteralSegments
  let closeQuote: TokenSyntax
  let closeDelimiter: TokenSyntax?

  public init(
    openDelimiter: TokenSyntax?,
    openQuote: TokenSyntax,
    segments: StringLiteralSegments,
    closeQuote: TokenSyntax,
    closeDelimiter: TokenSyntax?
  ) {
    self.openDelimiter = openDelimiter
    self.openQuote = openQuote
    self.segments = segments
    self.closeQuote = closeQuote
    self.closeDelimiter = closeDelimiter
  }
  
  func buildStringLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> StringLiteralExprSyntax {
    let stringLiteralExpr = SyntaxFactory.makeStringLiteralExpr(
      openDelimiter: openDelimiter,
      openQuote: openQuote,
      segments: segments.buildStringLiteralSegments(format: format),
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter
    )
    
    if let leadingTrivia = leadingTrivia {
      return stringLiteralExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return stringLiteralExpr
  }

  /// Conformance for `StringLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let stringLiteralExpr = buildStringLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(stringLiteralExpr)
  }
}

public struct KeyPathExpr: ExprBuildable {
  let backslash: TokenSyntax
  let rootExpr: ExprBuildable?
  let expression: ExprBuildable

  public init(
    backslash: TokenSyntax,
    rootExpr: ExprBuildable?,
    expression: ExprBuildable
  ) {
    self.backslash = backslash
    self.rootExpr = rootExpr
    self.expression = expression
  }
  
  func buildKeyPathExpr(format: Format, leadingTrivia: Trivia? = nil) -> KeyPathExprSyntax {
    let keyPathExpr = SyntaxFactory.makeKeyPathExpr(
      backslash: backslash,
      rootExpr: rootExpr?.buildExpr(format: format),
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return keyPathExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return keyPathExpr
  }

  /// Conformance for `KeyPathExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let keyPathExpr = buildKeyPathExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(keyPathExpr)
  }
}

public struct KeyPathBaseExpr: ExprBuildable {
  let period: TokenSyntax

  public init(
    period: TokenSyntax
  ) {
    self.period = period
  }
  
  func buildKeyPathBaseExpr(format: Format, leadingTrivia: Trivia? = nil) -> KeyPathBaseExprSyntax {
    let keyPathBaseExpr = SyntaxFactory.makeKeyPathBaseExpr(
      period: period
    )
    
    if let leadingTrivia = leadingTrivia {
      return keyPathBaseExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return keyPathBaseExpr
  }

  /// Conformance for `KeyPathBaseExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let keyPathBaseExpr = buildKeyPathBaseExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(keyPathBaseExpr)
  }
}

public struct ObjcNamePiece: SyntaxBuildable {
  let name: TokenSyntax
  let dot: TokenSyntax?

  public init(
    name: TokenSyntax,
    dot: TokenSyntax?
  ) {
    self.name = name
    self.dot = dot
  }
  
  func buildObjcNamePiece(format: Format, leadingTrivia: Trivia? = nil) -> ObjcNamePieceSyntax {
    let objcNamePiece = SyntaxFactory.makeObjcNamePiece(
      name: name,
      dot: dot
    )
    
    if let leadingTrivia = leadingTrivia {
      return objcNamePiece
        .withLeadingTrivia(leadingTrivia)
    }

    return objcNamePiece
  }

  /// Conformance for `ObjcNamePiece` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let objcNamePiece = buildObjcNamePiece(format: format, leadingTrivia: leadingTrivia)
    return Syntax(objcNamePiece)
  }
}

// MARK: - Syntax collection
public struct ObjcName: SyntaxBuildable {
  let elements: [ObjcNamePiece]

  public init(_ elements: [ObjcNamePiece]) {
    self.elements = elements
  }

  public func buildObjcName(format: Format, leadingTrivia: Trivia? = nil) -> ObjcNameSyntax {
    return SyntaxFactory.makeObjcName(elements.map {
      $0.buildObjcNamePiece(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let objcName = buildObjcName(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(objcName).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(objcName)
  }
}

public struct ObjcKeyPathExpr: ExprBuildable {
  let keyPath: TokenSyntax
  let leftParen: TokenSyntax
  let name: ObjcName
  let rightParen: TokenSyntax

  public init(
    keyPath: TokenSyntax,
    leftParen: TokenSyntax,
    name: ObjcName,
    rightParen: TokenSyntax
  ) {
    self.keyPath = keyPath
    self.leftParen = leftParen
    self.name = name
    self.rightParen = rightParen
  }
  
  func buildObjcKeyPathExpr(format: Format, leadingTrivia: Trivia? = nil) -> ObjcKeyPathExprSyntax {
    let objcKeyPathExpr = SyntaxFactory.makeObjcKeyPathExpr(
      keyPath: keyPath,
      leftParen: leftParen,
      name: name.buildObjcName(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return objcKeyPathExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return objcKeyPathExpr
  }

  /// Conformance for `ObjcKeyPathExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let objcKeyPathExpr = buildObjcKeyPathExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(objcKeyPathExpr)
  }
}

public struct ObjcSelectorExpr: ExprBuildable {
  let poundSelector: TokenSyntax
  let leftParen: TokenSyntax
  let kind: TokenSyntax?
  let colon: TokenSyntax?
  let name: ExprBuildable
  let rightParen: TokenSyntax

  public init(
    poundSelector: TokenSyntax,
    leftParen: TokenSyntax,
    kind: TokenSyntax?,
    colon: TokenSyntax?,
    name: ExprBuildable,
    rightParen: TokenSyntax
  ) {
    self.poundSelector = poundSelector
    self.leftParen = leftParen
    self.kind = kind
    self.colon = colon
    self.name = name
    self.rightParen = rightParen
  }
  
  func buildObjcSelectorExpr(format: Format, leadingTrivia: Trivia? = nil) -> ObjcSelectorExprSyntax {
    let objcSelectorExpr = SyntaxFactory.makeObjcSelectorExpr(
      poundSelector: poundSelector,
      leftParen: leftParen,
      kind: kind,
      colon: colon,
      name: name.buildExpr(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return objcSelectorExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return objcSelectorExpr
  }

  /// Conformance for `ObjcSelectorExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let objcSelectorExpr = buildObjcSelectorExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(objcSelectorExpr)
  }
}

public struct EditorPlaceholderExpr: ExprBuildable {
  let identifier: TokenSyntax

  public init(
    identifier: TokenSyntax
  ) {
    self.identifier = identifier
  }
  
  func buildEditorPlaceholderExpr(format: Format, leadingTrivia: Trivia? = nil) -> EditorPlaceholderExprSyntax {
    let editorPlaceholderExpr = SyntaxFactory.makeEditorPlaceholderExpr(
      identifier: identifier
    )
    
    if let leadingTrivia = leadingTrivia {
      return editorPlaceholderExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return editorPlaceholderExpr
  }

  /// Conformance for `EditorPlaceholderExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let editorPlaceholderExpr = buildEditorPlaceholderExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(editorPlaceholderExpr)
  }
}

public struct ObjectLiteralExpr: ExprBuildable {
  let identifier: TokenSyntax
  let leftParen: TokenSyntax
  let arguments: TupleExprElementList
  let rightParen: TokenSyntax

  public init(
    identifier: TokenSyntax,
    leftParen: TokenSyntax,
    arguments: TupleExprElementList,
    rightParen: TokenSyntax
  ) {
    self.identifier = identifier
    self.leftParen = leftParen
    self.arguments = arguments
    self.rightParen = rightParen
  }
  
  func buildObjectLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> ObjectLiteralExprSyntax {
    let objectLiteralExpr = SyntaxFactory.makeObjectLiteralExpr(
      identifier: identifier,
      leftParen: leftParen,
      arguments: arguments.buildTupleExprElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return objectLiteralExpr
        .withLeadingTrivia(leadingTrivia)
    }

    return objectLiteralExpr
  }

  /// Conformance for `ObjectLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let objectLiteralExpr = buildObjectLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(objectLiteralExpr)
  }
}

public struct TypeInitializerClause: SyntaxBuildable {
  let equal: TokenSyntax
  let value: TypeBuildable

  public init(
    equal: TokenSyntax,
    value: TypeBuildable
  ) {
    self.equal = equal
    self.value = value
  }
  
  func buildTypeInitializerClause(format: Format, leadingTrivia: Trivia? = nil) -> TypeInitializerClauseSyntax {
    let typeInitializerClause = SyntaxFactory.makeTypeInitializerClause(
      equal: equal,
      value: value.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typeInitializerClause
        .withLeadingTrivia(leadingTrivia)
    }

    return typeInitializerClause
  }

  /// Conformance for `TypeInitializerClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let typeInitializerClause = buildTypeInitializerClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(typeInitializerClause)
  }
}

public struct TypealiasDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let typealiasKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let initializer: TypeInitializerClause?
  let genericWhereClause: GenericWhereClause?

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    typealiasKeyword: TokenSyntax,
    identifier: TokenSyntax,
    genericParameterClause: GenericParameterClause?,
    initializer: TypeInitializerClause?,
    genericWhereClause: GenericWhereClause?
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.typealiasKeyword = typealiasKeyword
    self.identifier = identifier
    self.genericParameterClause = genericParameterClause
    self.initializer = initializer
    self.genericWhereClause = genericWhereClause
  }
  
  func buildTypealiasDecl(format: Format, leadingTrivia: Trivia? = nil) -> TypealiasDeclSyntax {
    let typealiasDecl = SyntaxFactory.makeTypealiasDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      typealiasKeyword: typealiasKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format),
      initializer: initializer?.buildTypeInitializerClause(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typealiasDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return typealiasDecl
  }

  /// Conformance for `TypealiasDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let typealiasDecl = buildTypealiasDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(typealiasDecl)
  }
}

public struct AssociatedtypeDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let associatedtypeKeyword: TokenSyntax
  let identifier: TokenSyntax
  let inheritanceClause: TypeInheritanceClause?
  let initializer: TypeInitializerClause?
  let genericWhereClause: GenericWhereClause?

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    associatedtypeKeyword: TokenSyntax,
    identifier: TokenSyntax,
    inheritanceClause: TypeInheritanceClause?,
    initializer: TypeInitializerClause?,
    genericWhereClause: GenericWhereClause?
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.associatedtypeKeyword = associatedtypeKeyword
    self.identifier = identifier
    self.inheritanceClause = inheritanceClause
    self.initializer = initializer
    self.genericWhereClause = genericWhereClause
  }
  
  func buildAssociatedtypeDecl(format: Format, leadingTrivia: Trivia? = nil) -> AssociatedtypeDeclSyntax {
    let associatedtypeDecl = SyntaxFactory.makeAssociatedtypeDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      associatedtypeKeyword: associatedtypeKeyword,
      identifier: identifier,
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format),
      initializer: initializer?.buildTypeInitializerClause(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return associatedtypeDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return associatedtypeDecl
  }

  /// Conformance for `AssociatedtypeDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let associatedtypeDecl = buildAssociatedtypeDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(associatedtypeDecl)
  }
}

// MARK: - Syntax collection
public struct FunctionParameterList: SyntaxBuildable {
  let elements: [FunctionParameter]

  public init(_ elements: [FunctionParameter]) {
    self.elements = elements
  }

  public func buildFunctionParameterList(format: Format, leadingTrivia: Trivia? = nil) -> FunctionParameterListSyntax {
    return SyntaxFactory.makeFunctionParameterList(elements.map {
      $0.buildFunctionParameter(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let functionParameterList = buildFunctionParameterList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(functionParameterList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(functionParameterList)
  }
}

public struct ParameterClause: SyntaxBuildable {
  let leftParen: TokenSyntax
  let parameterList: FunctionParameterList
  let rightParen: TokenSyntax

  public init(
    leftParen: TokenSyntax,
    parameterList: FunctionParameterList,
    rightParen: TokenSyntax
  ) {
    self.leftParen = leftParen
    self.parameterList = parameterList
    self.rightParen = rightParen
  }
  
  func buildParameterClause(format: Format, leadingTrivia: Trivia? = nil) -> ParameterClauseSyntax {
    let parameterClause = SyntaxFactory.makeParameterClause(
      leftParen: leftParen,
      parameterList: parameterList.buildFunctionParameterList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return parameterClause
        .withLeadingTrivia(leadingTrivia)
    }

    return parameterClause
  }

  /// Conformance for `ParameterClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let parameterClause = buildParameterClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(parameterClause)
  }
}

public struct ReturnClause: SyntaxBuildable {
  let arrow: TokenSyntax
  let returnType: TypeBuildable

  public init(
    arrow: TokenSyntax,
    returnType: TypeBuildable
  ) {
    self.arrow = arrow
    self.returnType = returnType
  }
  
  func buildReturnClause(format: Format, leadingTrivia: Trivia? = nil) -> ReturnClauseSyntax {
    let returnClause = SyntaxFactory.makeReturnClause(
      arrow: arrow,
      returnType: returnType.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return returnClause
        .withLeadingTrivia(leadingTrivia)
    }

    return returnClause
  }

  /// Conformance for `ReturnClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let returnClause = buildReturnClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(returnClause)
  }
}

public struct FunctionSignature: SyntaxBuildable {
  let input: ParameterClause
  let asyncOrReasyncKeyword: TokenSyntax?
  let throwsOrRethrowsKeyword: TokenSyntax?
  let output: ReturnClause?

  public init(
    input: ParameterClause,
    asyncOrReasyncKeyword: TokenSyntax?,
    throwsOrRethrowsKeyword: TokenSyntax?,
    output: ReturnClause?
  ) {
    self.input = input
    self.asyncOrReasyncKeyword = asyncOrReasyncKeyword
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    self.output = output
  }
  
  func buildFunctionSignature(format: Format, leadingTrivia: Trivia? = nil) -> FunctionSignatureSyntax {
    let functionSignature = SyntaxFactory.makeFunctionSignature(
      input: input.buildParameterClause(format: format),
      asyncOrReasyncKeyword: asyncOrReasyncKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      output: output?.buildReturnClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return functionSignature
        .withLeadingTrivia(leadingTrivia)
    }

    return functionSignature
  }

  /// Conformance for `FunctionSignature` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let functionSignature = buildFunctionSignature(format: format, leadingTrivia: leadingTrivia)
    return Syntax(functionSignature)
  }
}

public struct IfConfigClause: SyntaxBuildable {
  let poundKeyword: TokenSyntax
  let condition: ExprBuildable?
  let elements: SyntaxBuildable

  public init(
    poundKeyword: TokenSyntax,
    condition: ExprBuildable?,
    elements: SyntaxBuildable
  ) {
    self.poundKeyword = poundKeyword
    self.condition = condition
    self.elements = elements
  }
  
  func buildIfConfigClause(format: Format, leadingTrivia: Trivia? = nil) -> IfConfigClauseSyntax {
    let ifConfigClause = SyntaxFactory.makeIfConfigClause(
      poundKeyword: poundKeyword,
      condition: condition?.buildExpr(format: format),
      elements: elements.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return ifConfigClause
        .withLeadingTrivia(leadingTrivia)
    }

    return ifConfigClause
  }

  /// Conformance for `IfConfigClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let ifConfigClause = buildIfConfigClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(ifConfigClause)
  }
}

// MARK: - Syntax collection
public struct IfConfigClauseList: SyntaxBuildable {
  let elements: [IfConfigClause]

  public init(_ elements: [IfConfigClause]) {
    self.elements = elements
  }

  public func buildIfConfigClauseList(format: Format, leadingTrivia: Trivia? = nil) -> IfConfigClauseListSyntax {
    return SyntaxFactory.makeIfConfigClauseList(elements.map {
      $0.buildIfConfigClause(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let ifConfigClauseList = buildIfConfigClauseList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(ifConfigClauseList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(ifConfigClauseList)
  }
}

public struct IfConfigDecl: DeclBuildable {
  let clauses: IfConfigClauseList
  let poundEndif: TokenSyntax

  public init(
    clauses: IfConfigClauseList,
    poundEndif: TokenSyntax
  ) {
    self.clauses = clauses
    self.poundEndif = poundEndif
  }
  
  func buildIfConfigDecl(format: Format, leadingTrivia: Trivia? = nil) -> IfConfigDeclSyntax {
    let ifConfigDecl = SyntaxFactory.makeIfConfigDecl(
      clauses: clauses.buildIfConfigClauseList(format: format),
      poundEndif: poundEndif
    )
    
    if let leadingTrivia = leadingTrivia {
      return ifConfigDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return ifConfigDecl
  }

  /// Conformance for `IfConfigDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let ifConfigDecl = buildIfConfigDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(ifConfigDecl)
  }
}

public struct PoundErrorDecl: DeclBuildable {
  let poundError: TokenSyntax
  let leftParen: TokenSyntax
  let message: StringLiteralExpr
  let rightParen: TokenSyntax

  public init(
    poundError: TokenSyntax,
    leftParen: TokenSyntax,
    message: StringLiteralExpr,
    rightParen: TokenSyntax
  ) {
    self.poundError = poundError
    self.leftParen = leftParen
    self.message = message
    self.rightParen = rightParen
  }
  
  func buildPoundErrorDecl(format: Format, leadingTrivia: Trivia? = nil) -> PoundErrorDeclSyntax {
    let poundErrorDecl = SyntaxFactory.makePoundErrorDecl(
      poundError: poundError,
      leftParen: leftParen,
      message: message.buildStringLiteralExpr(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundErrorDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return poundErrorDecl
  }

  /// Conformance for `PoundErrorDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let poundErrorDecl = buildPoundErrorDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(poundErrorDecl)
  }
}

public struct PoundWarningDecl: DeclBuildable {
  let poundWarning: TokenSyntax
  let leftParen: TokenSyntax
  let message: StringLiteralExpr
  let rightParen: TokenSyntax

  public init(
    poundWarning: TokenSyntax,
    leftParen: TokenSyntax,
    message: StringLiteralExpr,
    rightParen: TokenSyntax
  ) {
    self.poundWarning = poundWarning
    self.leftParen = leftParen
    self.message = message
    self.rightParen = rightParen
  }
  
  func buildPoundWarningDecl(format: Format, leadingTrivia: Trivia? = nil) -> PoundWarningDeclSyntax {
    let poundWarningDecl = SyntaxFactory.makePoundWarningDecl(
      poundWarning: poundWarning,
      leftParen: leftParen,
      message: message.buildStringLiteralExpr(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundWarningDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return poundWarningDecl
  }

  /// Conformance for `PoundWarningDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let poundWarningDecl = buildPoundWarningDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(poundWarningDecl)
  }
}

public struct PoundSourceLocation: DeclBuildable {
  let poundSourceLocation: TokenSyntax
  let leftParen: TokenSyntax
  let args: PoundSourceLocationArgs?
  let rightParen: TokenSyntax

  public init(
    poundSourceLocation: TokenSyntax,
    leftParen: TokenSyntax,
    args: PoundSourceLocationArgs?,
    rightParen: TokenSyntax
  ) {
    self.poundSourceLocation = poundSourceLocation
    self.leftParen = leftParen
    self.args = args
    self.rightParen = rightParen
  }
  
  func buildPoundSourceLocation(format: Format, leadingTrivia: Trivia? = nil) -> PoundSourceLocationSyntax {
    let poundSourceLocation = SyntaxFactory.makePoundSourceLocation(
      poundSourceLocation: poundSourceLocation,
      leftParen: leftParen,
      args: args?.buildPoundSourceLocationArgs(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundSourceLocation
        .withLeadingTrivia(leadingTrivia)
    }

    return poundSourceLocation
  }

  /// Conformance for `PoundSourceLocation` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let poundSourceLocation = buildPoundSourceLocation(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(poundSourceLocation)
  }
}

public struct PoundSourceLocationArgs: SyntaxBuildable {
  let fileArgLabel: TokenSyntax
  let fileArgColon: TokenSyntax
  let fileName: TokenSyntax
  let comma: TokenSyntax
  let lineArgLabel: TokenSyntax
  let lineArgColon: TokenSyntax
  let lineNumber: TokenSyntax

  public init(
    fileArgLabel: TokenSyntax,
    fileArgColon: TokenSyntax,
    fileName: TokenSyntax,
    comma: TokenSyntax,
    lineArgLabel: TokenSyntax,
    lineArgColon: TokenSyntax,
    lineNumber: TokenSyntax
  ) {
    self.fileArgLabel = fileArgLabel
    self.fileArgColon = fileArgColon
    self.fileName = fileName
    self.comma = comma
    self.lineArgLabel = lineArgLabel
    self.lineArgColon = lineArgColon
    self.lineNumber = lineNumber
  }
  
  func buildPoundSourceLocationArgs(format: Format, leadingTrivia: Trivia? = nil) -> PoundSourceLocationArgsSyntax {
    let poundSourceLocationArgs = SyntaxFactory.makePoundSourceLocationArgs(
      fileArgLabel: fileArgLabel,
      fileArgColon: fileArgColon,
      fileName: fileName,
      comma: comma,
      lineArgLabel: lineArgLabel,
      lineArgColon: lineArgColon,
      lineNumber: lineNumber
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundSourceLocationArgs
        .withLeadingTrivia(leadingTrivia)
    }

    return poundSourceLocationArgs
  }

  /// Conformance for `PoundSourceLocationArgs` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let poundSourceLocationArgs = buildPoundSourceLocationArgs(format: format, leadingTrivia: leadingTrivia)
    return Syntax(poundSourceLocationArgs)
  }
}

public struct DeclModifier: SyntaxBuildable {
  let name: TokenSyntax
  let detailLeftParen: TokenSyntax?
  let detail: TokenSyntax?
  let detailRightParen: TokenSyntax?

  public init(
    name: TokenSyntax,
    detailLeftParen: TokenSyntax?,
    detail: TokenSyntax?,
    detailRightParen: TokenSyntax?
  ) {
    self.name = name
    self.detailLeftParen = detailLeftParen
    self.detail = detail
    self.detailRightParen = detailRightParen
  }
  
  func buildDeclModifier(format: Format, leadingTrivia: Trivia? = nil) -> DeclModifierSyntax {
    let declModifier = SyntaxFactory.makeDeclModifier(
      name: name,
      detailLeftParen: detailLeftParen,
      detail: detail,
      detailRightParen: detailRightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return declModifier
        .withLeadingTrivia(leadingTrivia)
    }

    return declModifier
  }

  /// Conformance for `DeclModifier` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declModifier = buildDeclModifier(format: format, leadingTrivia: leadingTrivia)
    return Syntax(declModifier)
  }
}

public struct InheritedType: SyntaxBuildable {
  let typeName: TypeBuildable
  let trailingComma: TokenSyntax?

  public init(
    typeName: TypeBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.typeName = typeName
    self.trailingComma = trailingComma
  }
  
  func buildInheritedType(format: Format, leadingTrivia: Trivia? = nil) -> InheritedTypeSyntax {
    let inheritedType = SyntaxFactory.makeInheritedType(
      typeName: typeName.buildType(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return inheritedType
        .withLeadingTrivia(leadingTrivia)
    }

    return inheritedType
  }

  /// Conformance for `InheritedType` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let inheritedType = buildInheritedType(format: format, leadingTrivia: leadingTrivia)
    return Syntax(inheritedType)
  }
}

// MARK: - Syntax collection
public struct InheritedTypeList: SyntaxBuildable {
  let elements: [InheritedType]

  public init(_ elements: [InheritedType]) {
    self.elements = elements
  }

  public func buildInheritedTypeList(format: Format, leadingTrivia: Trivia? = nil) -> InheritedTypeListSyntax {
    return SyntaxFactory.makeInheritedTypeList(elements.map {
      $0.buildInheritedType(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let inheritedTypeList = buildInheritedTypeList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(inheritedTypeList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(inheritedTypeList)
  }
}

public struct TypeInheritanceClause: SyntaxBuildable {
  let colon: TokenSyntax
  let inheritedTypeCollection: InheritedTypeList

  public init(
    colon: TokenSyntax,
    inheritedTypeCollection: InheritedTypeList
  ) {
    self.colon = colon
    self.inheritedTypeCollection = inheritedTypeCollection
  }
  
  func buildTypeInheritanceClause(format: Format, leadingTrivia: Trivia? = nil) -> TypeInheritanceClauseSyntax {
    let typeInheritanceClause = SyntaxFactory.makeTypeInheritanceClause(
      colon: colon,
      inheritedTypeCollection: inheritedTypeCollection.buildInheritedTypeList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typeInheritanceClause
        .withLeadingTrivia(leadingTrivia)
    }

    return typeInheritanceClause
  }

  /// Conformance for `TypeInheritanceClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let typeInheritanceClause = buildTypeInheritanceClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(typeInheritanceClause)
  }
}

public struct ClassDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let classOrActorKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    classOrActorKeyword: TokenSyntax,
    identifier: TokenSyntax,
    genericParameterClause: GenericParameterClause?,
    inheritanceClause: TypeInheritanceClause?,
    genericWhereClause: GenericWhereClause?,
    members: MemberDeclBlock
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.classOrActorKeyword = classOrActorKeyword
    self.identifier = identifier
    self.genericParameterClause = genericParameterClause
    self.inheritanceClause = inheritanceClause
    self.genericWhereClause = genericWhereClause
    self.members = members
  }
  
  func buildClassDecl(format: Format, leadingTrivia: Trivia? = nil) -> ClassDeclSyntax {
    let classDecl = SyntaxFactory.makeClassDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      classOrActorKeyword: classOrActorKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format),
      members: members.buildMemberDeclBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return classDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return classDecl
  }

  /// Conformance for `ClassDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let classDecl = buildClassDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(classDecl)
  }
}

public struct StructDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let structKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    structKeyword: TokenSyntax,
    identifier: TokenSyntax,
    genericParameterClause: GenericParameterClause?,
    inheritanceClause: TypeInheritanceClause?,
    genericWhereClause: GenericWhereClause?,
    members: MemberDeclBlock
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.structKeyword = structKeyword
    self.identifier = identifier
    self.genericParameterClause = genericParameterClause
    self.inheritanceClause = inheritanceClause
    self.genericWhereClause = genericWhereClause
    self.members = members
  }
  
  func buildStructDecl(format: Format, leadingTrivia: Trivia? = nil) -> StructDeclSyntax {
    let structDecl = SyntaxFactory.makeStructDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      structKeyword: structKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format),
      members: members.buildMemberDeclBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return structDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return structDecl
  }

  /// Conformance for `StructDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let structDecl = buildStructDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(structDecl)
  }
}

public struct ProtocolDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let protocolKeyword: TokenSyntax
  let identifier: TokenSyntax
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    protocolKeyword: TokenSyntax,
    identifier: TokenSyntax,
    inheritanceClause: TypeInheritanceClause?,
    genericWhereClause: GenericWhereClause?,
    members: MemberDeclBlock
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.protocolKeyword = protocolKeyword
    self.identifier = identifier
    self.inheritanceClause = inheritanceClause
    self.genericWhereClause = genericWhereClause
    self.members = members
  }
  
  func buildProtocolDecl(format: Format, leadingTrivia: Trivia? = nil) -> ProtocolDeclSyntax {
    let protocolDecl = SyntaxFactory.makeProtocolDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      protocolKeyword: protocolKeyword,
      identifier: identifier,
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format),
      members: members.buildMemberDeclBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return protocolDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return protocolDecl
  }

  /// Conformance for `ProtocolDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let protocolDecl = buildProtocolDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(protocolDecl)
  }
}

public struct ExtensionDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let extensionKeyword: TokenSyntax
  let extendedType: TypeBuildable
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    extensionKeyword: TokenSyntax,
    extendedType: TypeBuildable,
    inheritanceClause: TypeInheritanceClause?,
    genericWhereClause: GenericWhereClause?,
    members: MemberDeclBlock
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.extensionKeyword = extensionKeyword
    self.extendedType = extendedType
    self.inheritanceClause = inheritanceClause
    self.genericWhereClause = genericWhereClause
    self.members = members
  }
  
  func buildExtensionDecl(format: Format, leadingTrivia: Trivia? = nil) -> ExtensionDeclSyntax {
    let extensionDecl = SyntaxFactory.makeExtensionDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      extensionKeyword: extensionKeyword,
      extendedType: extendedType.buildType(format: format),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format),
      members: members.buildMemberDeclBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return extensionDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return extensionDecl
  }

  /// Conformance for `ExtensionDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let extensionDecl = buildExtensionDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(extensionDecl)
  }
}

public struct MemberDeclBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let members: MemberDeclList
  let rightBrace: TokenSyntax

  public init(
    leftBrace: TokenSyntax,
    members: MemberDeclList,
    rightBrace: TokenSyntax
  ) {
    self.leftBrace = leftBrace
    self.members = members
    self.rightBrace = rightBrace
  }
  
  func buildMemberDeclBlock(format: Format, leadingTrivia: Trivia? = nil) -> MemberDeclBlockSyntax {
    let memberDeclBlock = SyntaxFactory.makeMemberDeclBlock(
      leftBrace: leftBrace,
      members: members.buildMemberDeclList(format: format._indented()),
      rightBrace: rightBrace.withLeadingTrivia(.newlines(1) + format._makeIndent())
    )
    
    if let leadingTrivia = leadingTrivia {
      return memberDeclBlock
        .withLeadingTrivia(leadingTrivia)
    }

    return memberDeclBlock
  }

  /// Conformance for `MemberDeclBlock` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let memberDeclBlock = buildMemberDeclBlock(format: format, leadingTrivia: leadingTrivia)
    return Syntax(memberDeclBlock)
  }
}

// MARK: - Syntax collection
public struct MemberDeclList: SyntaxBuildable {
  let elements: [MemberDeclListItem]

  public init(_ elements: [MemberDeclListItem]) {
    self.elements = elements
  }

  public func buildMemberDeclList(format: Format, leadingTrivia: Trivia? = nil) -> MemberDeclListSyntax {
    return SyntaxFactory.makeMemberDeclList(elements.map {
      $0.buildMemberDeclListItem(format: format, leadingTrivia: .newlines(1) + format._makeIndent())
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let memberDeclList = buildMemberDeclList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(memberDeclList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(memberDeclList)
  }
}

public struct MemberDeclListItem: SyntaxBuildable {
  let decl: DeclBuildable
  let semicolon: TokenSyntax?

  public init(
    decl: DeclBuildable,
    semicolon: TokenSyntax?
  ) {
    self.decl = decl
    self.semicolon = semicolon
  }
  
  func buildMemberDeclListItem(format: Format, leadingTrivia: Trivia? = nil) -> MemberDeclListItemSyntax {
    let memberDeclListItem = SyntaxFactory.makeMemberDeclListItem(
      decl: decl.buildDecl(format: format),
      semicolon: semicolon
    )
    
    if let leadingTrivia = leadingTrivia {
      return memberDeclListItem
        .withLeadingTrivia(leadingTrivia)
    }

    return memberDeclListItem
  }

  /// Conformance for `MemberDeclListItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let memberDeclListItem = buildMemberDeclListItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(memberDeclListItem)
  }
}

public struct SourceFile: SyntaxBuildable {
  let statements: CodeBlockItemList
  let eofToken: TokenSyntax

  public init(
    statements: CodeBlockItemList,
    eofToken: TokenSyntax
  ) {
    self.statements = statements
    self.eofToken = eofToken
  }
  
  func buildSourceFile(format: Format, leadingTrivia: Trivia? = nil) -> SourceFileSyntax {
    let sourceFile = SyntaxFactory.makeSourceFile(
      statements: statements.buildCodeBlockItemList(format: format),
      eofToken: eofToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return sourceFile
        .withLeadingTrivia(leadingTrivia)
    }

    return sourceFile
  }

  /// Conformance for `SourceFile` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let sourceFile = buildSourceFile(format: format, leadingTrivia: leadingTrivia)
    return Syntax(sourceFile)
  }
}

public struct InitializerClause: SyntaxBuildable {
  let equal: TokenSyntax
  let value: ExprBuildable

  public init(
    equal: TokenSyntax,
    value: ExprBuildable
  ) {
    self.equal = equal
    self.value = value
  }
  
  func buildInitializerClause(format: Format, leadingTrivia: Trivia? = nil) -> InitializerClauseSyntax {
    let initializerClause = SyntaxFactory.makeInitializerClause(
      equal: equal,
      value: value.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return initializerClause
        .withLeadingTrivia(leadingTrivia)
    }

    return initializerClause
  }

  /// Conformance for `InitializerClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let initializerClause = buildInitializerClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(initializerClause)
  }
}

public struct FunctionParameter: SyntaxBuildable {
  let attributes: AttributeList?
  let firstName: TokenSyntax?
  let secondName: TokenSyntax?
  let colon: TokenSyntax?
  let type: TypeBuildable?
  let ellipsis: TokenSyntax?
  let defaultArgument: InitializerClause?
  let trailingComma: TokenSyntax?

  public init(
    attributes: AttributeList?,
    firstName: TokenSyntax?,
    secondName: TokenSyntax?,
    colon: TokenSyntax?,
    type: TypeBuildable?,
    ellipsis: TokenSyntax?,
    defaultArgument: InitializerClause?,
    trailingComma: TokenSyntax?
  ) {
    self.attributes = attributes
    self.firstName = firstName
    self.secondName = secondName
    self.colon = colon
    self.type = type
    self.ellipsis = ellipsis
    self.defaultArgument = defaultArgument
    self.trailingComma = trailingComma
  }
  
  func buildFunctionParameter(format: Format, leadingTrivia: Trivia? = nil) -> FunctionParameterSyntax {
    let functionParameter = SyntaxFactory.makeFunctionParameter(
      attributes: attributes?.buildAttributeList(format: format),
      firstName: firstName,
      secondName: secondName,
      colon: colon,
      type: type?.buildType(format: format),
      ellipsis: ellipsis,
      defaultArgument: defaultArgument?.buildInitializerClause(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return functionParameter
        .withLeadingTrivia(leadingTrivia)
    }

    return functionParameter
  }

  /// Conformance for `FunctionParameter` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let functionParameter = buildFunctionParameter(format: format, leadingTrivia: leadingTrivia)
    return Syntax(functionParameter)
  }
}

// MARK: - Syntax collection
public struct ModifierList: SyntaxBuildable {
  let elements: [DeclModifier]

  public init(_ elements: [DeclModifier]) {
    self.elements = elements
  }

  public func buildModifierList(format: Format, leadingTrivia: Trivia? = nil) -> ModifierListSyntax {
    return SyntaxFactory.makeModifierList(elements.map {
      $0.buildDeclModifier(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let modifierList = buildModifierList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(modifierList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(modifierList)
  }
}

public struct FunctionDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let funcKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let signature: FunctionSignature
  let genericWhereClause: GenericWhereClause?
  let body: CodeBlock?

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    funcKeyword: TokenSyntax,
    identifier: TokenSyntax,
    genericParameterClause: GenericParameterClause?,
    signature: FunctionSignature,
    genericWhereClause: GenericWhereClause?,
    body: CodeBlock?
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.funcKeyword = funcKeyword
    self.identifier = identifier
    self.genericParameterClause = genericParameterClause
    self.signature = signature
    self.genericWhereClause = genericWhereClause
    self.body = body
  }
  
  func buildFunctionDecl(format: Format, leadingTrivia: Trivia? = nil) -> FunctionDeclSyntax {
    let functionDecl = SyntaxFactory.makeFunctionDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      funcKeyword: funcKeyword,
      identifier: identifier,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format),
      signature: signature.buildFunctionSignature(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format),
      body: body?.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return functionDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return functionDecl
  }

  /// Conformance for `FunctionDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let functionDecl = buildFunctionDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(functionDecl)
  }
}

public struct InitializerDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let initKeyword: TokenSyntax
  let optionalMark: TokenSyntax?
  let genericParameterClause: GenericParameterClause?
  let parameters: ParameterClause
  let throwsOrRethrowsKeyword: TokenSyntax?
  let genericWhereClause: GenericWhereClause?
  let body: CodeBlock?

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    initKeyword: TokenSyntax,
    optionalMark: TokenSyntax?,
    genericParameterClause: GenericParameterClause?,
    parameters: ParameterClause,
    throwsOrRethrowsKeyword: TokenSyntax?,
    genericWhereClause: GenericWhereClause?,
    body: CodeBlock?
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.initKeyword = initKeyword
    self.optionalMark = optionalMark
    self.genericParameterClause = genericParameterClause
    self.parameters = parameters
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    self.genericWhereClause = genericWhereClause
    self.body = body
  }
  
  func buildInitializerDecl(format: Format, leadingTrivia: Trivia? = nil) -> InitializerDeclSyntax {
    let initializerDecl = SyntaxFactory.makeInitializerDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      initKeyword: initKeyword,
      optionalMark: optionalMark,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format),
      parameters: parameters.buildParameterClause(format: format),
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format),
      body: body?.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return initializerDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return initializerDecl
  }

  /// Conformance for `InitializerDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let initializerDecl = buildInitializerDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(initializerDecl)
  }
}

public struct DeinitializerDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let deinitKeyword: TokenSyntax
  let body: CodeBlock

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    deinitKeyword: TokenSyntax,
    body: CodeBlock
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.deinitKeyword = deinitKeyword
    self.body = body
  }
  
  func buildDeinitializerDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeinitializerDeclSyntax {
    let deinitializerDecl = SyntaxFactory.makeDeinitializerDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      deinitKeyword: deinitKeyword,
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return deinitializerDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return deinitializerDecl
  }

  /// Conformance for `DeinitializerDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let deinitializerDecl = buildDeinitializerDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(deinitializerDecl)
  }
}

public struct SubscriptDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let subscriptKeyword: TokenSyntax
  let genericParameterClause: GenericParameterClause?
  let indices: ParameterClause
  let result: ReturnClause
  let genericWhereClause: GenericWhereClause?
  let accessor: SyntaxBuildable?

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    subscriptKeyword: TokenSyntax,
    genericParameterClause: GenericParameterClause?,
    indices: ParameterClause,
    result: ReturnClause,
    genericWhereClause: GenericWhereClause?,
    accessor: SyntaxBuildable?
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.subscriptKeyword = subscriptKeyword
    self.genericParameterClause = genericParameterClause
    self.indices = indices
    self.result = result
    self.genericWhereClause = genericWhereClause
    self.accessor = accessor
  }
  
  func buildSubscriptDecl(format: Format, leadingTrivia: Trivia? = nil) -> SubscriptDeclSyntax {
    let subscriptDecl = SyntaxFactory.makeSubscriptDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      subscriptKeyword: subscriptKeyword,
      genericParameterClause: genericParameterClause?.buildGenericParameterClause(format: format),
      indices: indices.buildParameterClause(format: format),
      result: result.buildReturnClause(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format),
      accessor: accessor?.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return subscriptDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return subscriptDecl
  }

  /// Conformance for `SubscriptDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let subscriptDecl = buildSubscriptDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(subscriptDecl)
  }
}

public struct AccessLevelModifier: SyntaxBuildable {
  let name: TokenSyntax
  let leftParen: TokenSyntax?
  let modifier: TokenSyntax?
  let rightParen: TokenSyntax?

  public init(
    name: TokenSyntax,
    leftParen: TokenSyntax?,
    modifier: TokenSyntax?,
    rightParen: TokenSyntax?
  ) {
    self.name = name
    self.leftParen = leftParen
    self.modifier = modifier
    self.rightParen = rightParen
  }
  
  func buildAccessLevelModifier(format: Format, leadingTrivia: Trivia? = nil) -> AccessLevelModifierSyntax {
    let accessLevelModifier = SyntaxFactory.makeAccessLevelModifier(
      name: name,
      leftParen: leftParen,
      modifier: modifier,
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessLevelModifier
        .withLeadingTrivia(leadingTrivia)
    }

    return accessLevelModifier
  }

  /// Conformance for `AccessLevelModifier` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessLevelModifier = buildAccessLevelModifier(format: format, leadingTrivia: leadingTrivia)
    return Syntax(accessLevelModifier)
  }
}

public struct AccessPathComponent: SyntaxBuildable {
  let name: TokenSyntax
  let trailingDot: TokenSyntax?

  public init(
    name: TokenSyntax,
    trailingDot: TokenSyntax?
  ) {
    self.name = name
    self.trailingDot = trailingDot
  }
  
  func buildAccessPathComponent(format: Format, leadingTrivia: Trivia? = nil) -> AccessPathComponentSyntax {
    let accessPathComponent = SyntaxFactory.makeAccessPathComponent(
      name: name,
      trailingDot: trailingDot
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessPathComponent
        .withLeadingTrivia(leadingTrivia)
    }

    return accessPathComponent
  }

  /// Conformance for `AccessPathComponent` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessPathComponent = buildAccessPathComponent(format: format, leadingTrivia: leadingTrivia)
    return Syntax(accessPathComponent)
  }
}

// MARK: - Syntax collection
public struct AccessPath: SyntaxBuildable {
  let elements: [AccessPathComponent]

  public init(_ elements: [AccessPathComponent]) {
    self.elements = elements
  }

  public func buildAccessPath(format: Format, leadingTrivia: Trivia? = nil) -> AccessPathSyntax {
    return SyntaxFactory.makeAccessPath(elements.map {
      $0.buildAccessPathComponent(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessPath = buildAccessPath(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(accessPath).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(accessPath)
  }
}

public struct ImportDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let importTok: TokenSyntax
  let importKind: TokenSyntax?
  let path: AccessPath

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    importTok: TokenSyntax,
    importKind: TokenSyntax?,
    path: AccessPath
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.importTok = importTok
    self.importKind = importKind
    self.path = path
  }
  
  func buildImportDecl(format: Format, leadingTrivia: Trivia? = nil) -> ImportDeclSyntax {
    let importDecl = SyntaxFactory.makeImportDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      importTok: importTok,
      importKind: importKind,
      path: path.buildAccessPath(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return importDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return importDecl
  }

  /// Conformance for `ImportDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let importDecl = buildImportDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(importDecl)
  }
}

public struct AccessorParameter: SyntaxBuildable {
  let leftParen: TokenSyntax
  let name: TokenSyntax
  let rightParen: TokenSyntax

  public init(
    leftParen: TokenSyntax,
    name: TokenSyntax,
    rightParen: TokenSyntax
  ) {
    self.leftParen = leftParen
    self.name = name
    self.rightParen = rightParen
  }
  
  func buildAccessorParameter(format: Format, leadingTrivia: Trivia? = nil) -> AccessorParameterSyntax {
    let accessorParameter = SyntaxFactory.makeAccessorParameter(
      leftParen: leftParen,
      name: name,
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessorParameter
        .withLeadingTrivia(leadingTrivia)
    }

    return accessorParameter
  }

  /// Conformance for `AccessorParameter` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessorParameter = buildAccessorParameter(format: format, leadingTrivia: leadingTrivia)
    return Syntax(accessorParameter)
  }
}

public struct AccessorDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifier: DeclModifier?
  let accessorKind: TokenSyntax
  let parameter: AccessorParameter?
  let asyncKeyword: TokenSyntax?
  let throwsKeyword: TokenSyntax?
  let body: CodeBlock?

  public init(
    attributes: AttributeList?,
    modifier: DeclModifier?,
    accessorKind: TokenSyntax,
    parameter: AccessorParameter?,
    asyncKeyword: TokenSyntax?,
    throwsKeyword: TokenSyntax?,
    body: CodeBlock?
  ) {
    self.attributes = attributes
    self.modifier = modifier
    self.accessorKind = accessorKind
    self.parameter = parameter
    self.asyncKeyword = asyncKeyword
    self.throwsKeyword = throwsKeyword
    self.body = body
  }
  
  func buildAccessorDecl(format: Format, leadingTrivia: Trivia? = nil) -> AccessorDeclSyntax {
    let accessorDecl = SyntaxFactory.makeAccessorDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifier: modifier?.buildDeclModifier(format: format),
      accessorKind: accessorKind,
      parameter: parameter?.buildAccessorParameter(format: format),
      asyncKeyword: asyncKeyword,
      throwsKeyword: throwsKeyword,
      body: body?.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessorDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return accessorDecl
  }

  /// Conformance for `AccessorDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let accessorDecl = buildAccessorDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(accessorDecl)
  }
}

// MARK: - Syntax collection
public struct AccessorList: SyntaxBuildable {
  let elements: [AccessorDecl]

  public init(_ elements: [AccessorDecl]) {
    self.elements = elements
  }

  public func buildAccessorList(format: Format, leadingTrivia: Trivia? = nil) -> AccessorListSyntax {
    return SyntaxFactory.makeAccessorList(elements.map {
      $0.buildAccessorDecl(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessorList = buildAccessorList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(accessorList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(accessorList)
  }
}

public struct AccessorBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let accessors: AccessorList
  let rightBrace: TokenSyntax

  public init(
    leftBrace: TokenSyntax,
    accessors: AccessorList,
    rightBrace: TokenSyntax
  ) {
    self.leftBrace = leftBrace
    self.accessors = accessors
    self.rightBrace = rightBrace
  }
  
  func buildAccessorBlock(format: Format, leadingTrivia: Trivia? = nil) -> AccessorBlockSyntax {
    let accessorBlock = SyntaxFactory.makeAccessorBlock(
      leftBrace: leftBrace,
      accessors: accessors.buildAccessorList(format: format),
      rightBrace: rightBrace
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessorBlock
        .withLeadingTrivia(leadingTrivia)
    }

    return accessorBlock
  }

  /// Conformance for `AccessorBlock` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessorBlock = buildAccessorBlock(format: format, leadingTrivia: leadingTrivia)
    return Syntax(accessorBlock)
  }
}

public struct PatternBinding: SyntaxBuildable {
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause?
  let accessor: SyntaxBuildable?
  let trailingComma: TokenSyntax?

  public init(
    pattern: PatternBuildable,
    typeAnnotation: TypeAnnotation?,
    initializer: InitializerClause?,
    accessor: SyntaxBuildable?,
    trailingComma: TokenSyntax?
  ) {
    self.pattern = pattern
    self.typeAnnotation = typeAnnotation
    self.initializer = initializer
    self.accessor = accessor
    self.trailingComma = trailingComma
  }
  
  func buildPatternBinding(format: Format, leadingTrivia: Trivia? = nil) -> PatternBindingSyntax {
    let patternBinding = SyntaxFactory.makePatternBinding(
      pattern: pattern.buildPattern(format: format),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format),
      initializer: initializer?.buildInitializerClause(format: format),
      accessor: accessor?.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return patternBinding
        .withLeadingTrivia(leadingTrivia)
    }

    return patternBinding
  }

  /// Conformance for `PatternBinding` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let patternBinding = buildPatternBinding(format: format, leadingTrivia: leadingTrivia)
    return Syntax(patternBinding)
  }
}

// MARK: - Syntax collection
public struct PatternBindingList: SyntaxBuildable {
  let elements: [PatternBinding]

  public init(_ elements: [PatternBinding]) {
    self.elements = elements
  }

  public func buildPatternBindingList(format: Format, leadingTrivia: Trivia? = nil) -> PatternBindingListSyntax {
    return SyntaxFactory.makePatternBindingList(elements.map {
      $0.buildPatternBinding(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let patternBindingList = buildPatternBindingList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(patternBindingList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(patternBindingList)
  }
}

public struct VariableDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let letOrVarKeyword: TokenSyntax
  let bindings: PatternBindingList

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    letOrVarKeyword: TokenSyntax,
    bindings: PatternBindingList
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.letOrVarKeyword = letOrVarKeyword
    self.bindings = bindings
  }
  
  func buildVariableDecl(format: Format, leadingTrivia: Trivia? = nil) -> VariableDeclSyntax {
    let variableDecl = SyntaxFactory.makeVariableDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      letOrVarKeyword: letOrVarKeyword,
      bindings: bindings.buildPatternBindingList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return variableDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return variableDecl
  }

  /// Conformance for `VariableDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let variableDecl = buildVariableDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(variableDecl)
  }
}

public struct EnumCaseElement: SyntaxBuildable {
  let identifier: TokenSyntax
  let associatedValue: ParameterClause?
  let rawValue: InitializerClause?
  let trailingComma: TokenSyntax?

  public init(
    identifier: TokenSyntax,
    associatedValue: ParameterClause?,
    rawValue: InitializerClause?,
    trailingComma: TokenSyntax?
  ) {
    self.identifier = identifier
    self.associatedValue = associatedValue
    self.rawValue = rawValue
    self.trailingComma = trailingComma
  }
  
  func buildEnumCaseElement(format: Format, leadingTrivia: Trivia? = nil) -> EnumCaseElementSyntax {
    let enumCaseElement = SyntaxFactory.makeEnumCaseElement(
      identifier: identifier,
      associatedValue: associatedValue?.buildParameterClause(format: format),
      rawValue: rawValue?.buildInitializerClause(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return enumCaseElement
        .withLeadingTrivia(leadingTrivia)
    }

    return enumCaseElement
  }

  /// Conformance for `EnumCaseElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let enumCaseElement = buildEnumCaseElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(enumCaseElement)
  }
}

// MARK: - Syntax collection
public struct EnumCaseElementList: SyntaxBuildable {
  let elements: [EnumCaseElement]

  public init(_ elements: [EnumCaseElement]) {
    self.elements = elements
  }

  public func buildEnumCaseElementList(format: Format, leadingTrivia: Trivia? = nil) -> EnumCaseElementListSyntax {
    return SyntaxFactory.makeEnumCaseElementList(elements.map {
      $0.buildEnumCaseElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let enumCaseElementList = buildEnumCaseElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(enumCaseElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(enumCaseElementList)
  }
}

public struct EnumCaseDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let caseKeyword: TokenSyntax
  let elements: EnumCaseElementList

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    caseKeyword: TokenSyntax,
    elements: EnumCaseElementList
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.caseKeyword = caseKeyword
    self.elements = elements
  }
  
  func buildEnumCaseDecl(format: Format, leadingTrivia: Trivia? = nil) -> EnumCaseDeclSyntax {
    let enumCaseDecl = SyntaxFactory.makeEnumCaseDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      caseKeyword: caseKeyword,
      elements: elements.buildEnumCaseElementList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return enumCaseDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return enumCaseDecl
  }

  /// Conformance for `EnumCaseDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let enumCaseDecl = buildEnumCaseDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(enumCaseDecl)
  }
}

public struct EnumDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let enumKeyword: TokenSyntax
  let identifier: TokenSyntax
  let genericParameters: GenericParameterClause?
  let inheritanceClause: TypeInheritanceClause?
  let genericWhereClause: GenericWhereClause?
  let members: MemberDeclBlock

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    enumKeyword: TokenSyntax,
    identifier: TokenSyntax,
    genericParameters: GenericParameterClause?,
    inheritanceClause: TypeInheritanceClause?,
    genericWhereClause: GenericWhereClause?,
    members: MemberDeclBlock
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.enumKeyword = enumKeyword
    self.identifier = identifier
    self.genericParameters = genericParameters
    self.inheritanceClause = inheritanceClause
    self.genericWhereClause = genericWhereClause
    self.members = members
  }
  
  func buildEnumDecl(format: Format, leadingTrivia: Trivia? = nil) -> EnumDeclSyntax {
    let enumDecl = SyntaxFactory.makeEnumDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      enumKeyword: enumKeyword,
      identifier: identifier,
      genericParameters: genericParameters?.buildGenericParameterClause(format: format),
      inheritanceClause: inheritanceClause?.buildTypeInheritanceClause(format: format),
      genericWhereClause: genericWhereClause?.buildGenericWhereClause(format: format),
      members: members.buildMemberDeclBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return enumDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return enumDecl
  }

  /// Conformance for `EnumDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let enumDecl = buildEnumDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(enumDecl)
  }
}

public struct OperatorDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let operatorKeyword: TokenSyntax
  let identifier: TokenSyntax
  let operatorPrecedenceAndTypes: OperatorPrecedenceAndTypes?

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    operatorKeyword: TokenSyntax,
    identifier: TokenSyntax,
    operatorPrecedenceAndTypes: OperatorPrecedenceAndTypes?
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.operatorKeyword = operatorKeyword
    self.identifier = identifier
    self.operatorPrecedenceAndTypes = operatorPrecedenceAndTypes
  }
  
  func buildOperatorDecl(format: Format, leadingTrivia: Trivia? = nil) -> OperatorDeclSyntax {
    let operatorDecl = SyntaxFactory.makeOperatorDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      operatorKeyword: operatorKeyword,
      identifier: identifier,
      operatorPrecedenceAndTypes: operatorPrecedenceAndTypes?.buildOperatorPrecedenceAndTypes(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return operatorDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return operatorDecl
  }

  /// Conformance for `OperatorDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let operatorDecl = buildOperatorDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(operatorDecl)
  }
}

// MARK: - Syntax collection
public struct IdentifierList: SyntaxBuildable {
  let elements: [TokenSyntax]

  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
  }

  public func buildIdentifierList(format: Format, leadingTrivia: Trivia? = nil) -> IdentifierListSyntax {
    return SyntaxFactory.makeIdentifierList(elements)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let identifierList = buildIdentifierList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(identifierList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(identifierList)
  }
}

public struct OperatorPrecedenceAndTypes: SyntaxBuildable {
  let colon: TokenSyntax
  let precedenceGroupAndDesignatedTypes: IdentifierList

  public init(
    colon: TokenSyntax,
    precedenceGroupAndDesignatedTypes: IdentifierList
  ) {
    self.colon = colon
    self.precedenceGroupAndDesignatedTypes = precedenceGroupAndDesignatedTypes
  }
  
  func buildOperatorPrecedenceAndTypes(format: Format, leadingTrivia: Trivia? = nil) -> OperatorPrecedenceAndTypesSyntax {
    let operatorPrecedenceAndTypes = SyntaxFactory.makeOperatorPrecedenceAndTypes(
      colon: colon,
      precedenceGroupAndDesignatedTypes: precedenceGroupAndDesignatedTypes.buildIdentifierList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return operatorPrecedenceAndTypes
        .withLeadingTrivia(leadingTrivia)
    }

    return operatorPrecedenceAndTypes
  }

  /// Conformance for `OperatorPrecedenceAndTypes` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let operatorPrecedenceAndTypes = buildOperatorPrecedenceAndTypes(format: format, leadingTrivia: leadingTrivia)
    return Syntax(operatorPrecedenceAndTypes)
  }
}

public struct PrecedenceGroupDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let precedencegroupKeyword: TokenSyntax
  let identifier: TokenSyntax
  let leftBrace: TokenSyntax
  let groupAttributes: PrecedenceGroupAttributeList
  let rightBrace: TokenSyntax

  public init(
    attributes: AttributeList?,
    modifiers: ModifierList?,
    precedencegroupKeyword: TokenSyntax,
    identifier: TokenSyntax,
    leftBrace: TokenSyntax,
    groupAttributes: PrecedenceGroupAttributeList,
    rightBrace: TokenSyntax
  ) {
    self.attributes = attributes
    self.modifiers = modifiers
    self.precedencegroupKeyword = precedencegroupKeyword
    self.identifier = identifier
    self.leftBrace = leftBrace
    self.groupAttributes = groupAttributes
    self.rightBrace = rightBrace
  }
  
  func buildPrecedenceGroupDecl(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupDeclSyntax {
    let precedenceGroupDecl = SyntaxFactory.makePrecedenceGroupDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      precedencegroupKeyword: precedencegroupKeyword,
      identifier: identifier,
      leftBrace: leftBrace,
      groupAttributes: groupAttributes.buildPrecedenceGroupAttributeList(format: format),
      rightBrace: rightBrace
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupDecl
        .withLeadingTrivia(leadingTrivia)
    }

    return precedenceGroupDecl
  }

  /// Conformance for `PrecedenceGroupDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let precedenceGroupDecl = buildPrecedenceGroupDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(precedenceGroupDecl)
  }
}

// MARK: - Syntax collection
public struct PrecedenceGroupAttributeList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [SyntaxBuildable]) {
    self.elements = elements
  }

  public func buildPrecedenceGroupAttributeList(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupAttributeListSyntax {
    return SyntaxFactory.makePrecedenceGroupAttributeList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupAttributeList = buildPrecedenceGroupAttributeList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(precedenceGroupAttributeList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(precedenceGroupAttributeList)
  }
}

public struct PrecedenceGroupRelation: SyntaxBuildable {
  let higherThanOrLowerThan: TokenSyntax
  let colon: TokenSyntax
  let otherNames: PrecedenceGroupNameList

  public init(
    higherThanOrLowerThan: TokenSyntax,
    colon: TokenSyntax,
    otherNames: PrecedenceGroupNameList
  ) {
    self.higherThanOrLowerThan = higherThanOrLowerThan
    self.colon = colon
    self.otherNames = otherNames
  }
  
  func buildPrecedenceGroupRelation(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupRelationSyntax {
    let precedenceGroupRelation = SyntaxFactory.makePrecedenceGroupRelation(
      higherThanOrLowerThan: higherThanOrLowerThan,
      colon: colon,
      otherNames: otherNames.buildPrecedenceGroupNameList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupRelation
        .withLeadingTrivia(leadingTrivia)
    }

    return precedenceGroupRelation
  }

  /// Conformance for `PrecedenceGroupRelation` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupRelation = buildPrecedenceGroupRelation(format: format, leadingTrivia: leadingTrivia)
    return Syntax(precedenceGroupRelation)
  }
}

// MARK: - Syntax collection
public struct PrecedenceGroupNameList: SyntaxBuildable {
  let elements: [PrecedenceGroupNameElement]

  public init(_ elements: [PrecedenceGroupNameElement]) {
    self.elements = elements
  }

  public func buildPrecedenceGroupNameList(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupNameListSyntax {
    return SyntaxFactory.makePrecedenceGroupNameList(elements.map {
      $0.buildPrecedenceGroupNameElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupNameList = buildPrecedenceGroupNameList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(precedenceGroupNameList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(precedenceGroupNameList)
  }
}

public struct PrecedenceGroupNameElement: SyntaxBuildable {
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  public init(
    name: TokenSyntax,
    trailingComma: TokenSyntax?
  ) {
    self.name = name
    self.trailingComma = trailingComma
  }
  
  func buildPrecedenceGroupNameElement(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupNameElementSyntax {
    let precedenceGroupNameElement = SyntaxFactory.makePrecedenceGroupNameElement(
      name: name,
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupNameElement
        .withLeadingTrivia(leadingTrivia)
    }

    return precedenceGroupNameElement
  }

  /// Conformance for `PrecedenceGroupNameElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupNameElement = buildPrecedenceGroupNameElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(precedenceGroupNameElement)
  }
}

public struct PrecedenceGroupAssignment: SyntaxBuildable {
  let assignmentKeyword: TokenSyntax
  let colon: TokenSyntax
  let flag: TokenSyntax

  public init(
    assignmentKeyword: TokenSyntax,
    colon: TokenSyntax,
    flag: TokenSyntax
  ) {
    self.assignmentKeyword = assignmentKeyword
    self.colon = colon
    self.flag = flag
  }
  
  func buildPrecedenceGroupAssignment(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupAssignmentSyntax {
    let precedenceGroupAssignment = SyntaxFactory.makePrecedenceGroupAssignment(
      assignmentKeyword: assignmentKeyword,
      colon: colon,
      flag: flag
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupAssignment
        .withLeadingTrivia(leadingTrivia)
    }

    return precedenceGroupAssignment
  }

  /// Conformance for `PrecedenceGroupAssignment` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupAssignment = buildPrecedenceGroupAssignment(format: format, leadingTrivia: leadingTrivia)
    return Syntax(precedenceGroupAssignment)
  }
}

public struct PrecedenceGroupAssociativity: SyntaxBuildable {
  let associativityKeyword: TokenSyntax
  let colon: TokenSyntax
  let value: TokenSyntax

  public init(
    associativityKeyword: TokenSyntax,
    colon: TokenSyntax,
    value: TokenSyntax
  ) {
    self.associativityKeyword = associativityKeyword
    self.colon = colon
    self.value = value
  }
  
  func buildPrecedenceGroupAssociativity(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupAssociativitySyntax {
    let precedenceGroupAssociativity = SyntaxFactory.makePrecedenceGroupAssociativity(
      associativityKeyword: associativityKeyword,
      colon: colon,
      value: value
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupAssociativity
        .withLeadingTrivia(leadingTrivia)
    }

    return precedenceGroupAssociativity
  }

  /// Conformance for `PrecedenceGroupAssociativity` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupAssociativity = buildPrecedenceGroupAssociativity(format: format, leadingTrivia: leadingTrivia)
    return Syntax(precedenceGroupAssociativity)
  }
}

// MARK: - Syntax collection
public struct TokenList: SyntaxBuildable {
  let elements: [TokenSyntax]

  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
  }

  public func buildTokenList(format: Format, leadingTrivia: Trivia? = nil) -> TokenListSyntax {
    return SyntaxFactory.makeTokenList(elements)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tokenList = buildTokenList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(tokenList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(tokenList)
  }
}

// MARK: - Syntax collection
public struct NonEmptyTokenList: SyntaxBuildable {
  let elements: [TokenSyntax]

  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
  }

  public func buildNonEmptyTokenList(format: Format, leadingTrivia: Trivia? = nil) -> NonEmptyTokenListSyntax {
    return SyntaxFactory.makeNonEmptyTokenList(elements)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let nonEmptyTokenList = buildNonEmptyTokenList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(nonEmptyTokenList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(nonEmptyTokenList)
  }
}

public struct CustomAttribute: SyntaxBuildable {
  let atSignToken: TokenSyntax
  let attributeName: TypeBuildable
  let leftParen: TokenSyntax?
  let argumentList: TupleExprElementList?
  let rightParen: TokenSyntax?

  public init(
    atSignToken: TokenSyntax,
    attributeName: TypeBuildable,
    leftParen: TokenSyntax?,
    argumentList: TupleExprElementList?,
    rightParen: TokenSyntax?
  ) {
    self.atSignToken = atSignToken
    self.attributeName = attributeName
    self.leftParen = leftParen
    self.argumentList = argumentList
    self.rightParen = rightParen
  }
  
  func buildCustomAttribute(format: Format, leadingTrivia: Trivia? = nil) -> CustomAttributeSyntax {
    let customAttribute = SyntaxFactory.makeCustomAttribute(
      atSignToken: atSignToken,
      attributeName: attributeName.buildType(format: format),
      leftParen: leftParen,
      argumentList: argumentList?.buildTupleExprElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return customAttribute
        .withLeadingTrivia(leadingTrivia)
    }

    return customAttribute
  }

  /// Conformance for `CustomAttribute` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let customAttribute = buildCustomAttribute(format: format, leadingTrivia: leadingTrivia)
    return Syntax(customAttribute)
  }
}

public struct Attribute: SyntaxBuildable {
  let atSignToken: TokenSyntax
  let attributeName: TokenSyntax
  let leftParen: TokenSyntax?
  let argument: SyntaxBuildable?
  let rightParen: TokenSyntax?
  let tokenList: TokenListSyntax?

  public init(
    atSignToken: TokenSyntax,
    attributeName: TokenSyntax,
    leftParen: TokenSyntax?,
    argument: SyntaxBuildable?,
    rightParen: TokenSyntax?,
    tokenList: TokenListSyntax?
  ) {
    self.atSignToken = atSignToken
    self.attributeName = attributeName
    self.leftParen = leftParen
    self.argument = argument
    self.rightParen = rightParen
    self.tokenList = tokenList
  }
  
  func buildAttribute(format: Format, leadingTrivia: Trivia? = nil) -> AttributeSyntax {
    let attribute = SyntaxFactory.makeAttribute(
      atSignToken: atSignToken,
      attributeName: attributeName,
      leftParen: leftParen,
      argument: argument?.buildSyntax(format: format),
      rightParen: rightParen,
      tokenList: tokenList
    )
    
    if let leadingTrivia = leadingTrivia {
      return attribute
        .withLeadingTrivia(leadingTrivia)
    }

    return attribute
  }

  /// Conformance for `Attribute` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let attribute = buildAttribute(format: format, leadingTrivia: leadingTrivia)
    return Syntax(attribute)
  }
}

// MARK: - Syntax collection
public struct AttributeList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [SyntaxBuildable]) {
    self.elements = elements
  }

  public func buildAttributeList(format: Format, leadingTrivia: Trivia? = nil) -> AttributeListSyntax {
    return SyntaxFactory.makeAttributeList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let attributeList = buildAttributeList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(attributeList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(attributeList)
  }
}

// MARK: - Syntax collection
public struct SpecializeAttributeSpecList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [SyntaxBuildable]) {
    self.elements = elements
  }

  public func buildSpecializeAttributeSpecList(format: Format, leadingTrivia: Trivia? = nil) -> SpecializeAttributeSpecListSyntax {
    return SyntaxFactory.makeSpecializeAttributeSpecList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let specializeAttributeSpecList = buildSpecializeAttributeSpecList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(specializeAttributeSpecList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(specializeAttributeSpecList)
  }
}

public struct LabeledSpecializeEntry: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let value: TokenSyntax
  let trailingComma: TokenSyntax?

  public init(
    label: TokenSyntax,
    colon: TokenSyntax,
    value: TokenSyntax,
    trailingComma: TokenSyntax?
  ) {
    self.label = label
    self.colon = colon
    self.value = value
    self.trailingComma = trailingComma
  }
  
  func buildLabeledSpecializeEntry(format: Format, leadingTrivia: Trivia? = nil) -> LabeledSpecializeEntrySyntax {
    let labeledSpecializeEntry = SyntaxFactory.makeLabeledSpecializeEntry(
      label: label,
      colon: colon,
      value: value,
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return labeledSpecializeEntry
        .withLeadingTrivia(leadingTrivia)
    }

    return labeledSpecializeEntry
  }

  /// Conformance for `LabeledSpecializeEntry` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let labeledSpecializeEntry = buildLabeledSpecializeEntry(format: format, leadingTrivia: leadingTrivia)
    return Syntax(labeledSpecializeEntry)
  }
}

public struct TargetFunctionEntry: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let delcname: DeclName
  let trailingComma: TokenSyntax?

  public init(
    label: TokenSyntax,
    colon: TokenSyntax,
    delcname: DeclName,
    trailingComma: TokenSyntax?
  ) {
    self.label = label
    self.colon = colon
    self.delcname = delcname
    self.trailingComma = trailingComma
  }
  
  func buildTargetFunctionEntry(format: Format, leadingTrivia: Trivia? = nil) -> TargetFunctionEntrySyntax {
    let targetFunctionEntry = SyntaxFactory.makeTargetFunctionEntry(
      label: label,
      colon: colon,
      delcname: delcname.buildDeclName(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return targetFunctionEntry
        .withLeadingTrivia(leadingTrivia)
    }

    return targetFunctionEntry
  }

  /// Conformance for `TargetFunctionEntry` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let targetFunctionEntry = buildTargetFunctionEntry(format: format, leadingTrivia: leadingTrivia)
    return Syntax(targetFunctionEntry)
  }
}

public struct NamedAttributeStringArgument: SyntaxBuildable {
  let nameTok: TokenSyntax
  let colon: TokenSyntax
  let stringOrDeclname: SyntaxBuildable

  public init(
    nameTok: TokenSyntax,
    colon: TokenSyntax,
    stringOrDeclname: SyntaxBuildable
  ) {
    self.nameTok = nameTok
    self.colon = colon
    self.stringOrDeclname = stringOrDeclname
  }
  
  func buildNamedAttributeStringArgument(format: Format, leadingTrivia: Trivia? = nil) -> NamedAttributeStringArgumentSyntax {
    let namedAttributeStringArgument = SyntaxFactory.makeNamedAttributeStringArgument(
      nameTok: nameTok,
      colon: colon,
      stringOrDeclname: stringOrDeclname.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return namedAttributeStringArgument
        .withLeadingTrivia(leadingTrivia)
    }

    return namedAttributeStringArgument
  }

  /// Conformance for `NamedAttributeStringArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let namedAttributeStringArgument = buildNamedAttributeStringArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(namedAttributeStringArgument)
  }
}

public struct DeclName: SyntaxBuildable {
  let declBaseName: SyntaxBuildable
  let declNameArguments: DeclNameArguments?

  public init(
    declBaseName: SyntaxBuildable,
    declNameArguments: DeclNameArguments?
  ) {
    self.declBaseName = declBaseName
    self.declNameArguments = declNameArguments
  }
  
  func buildDeclName(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameSyntax {
    let declName = SyntaxFactory.makeDeclName(
      declBaseName: declBaseName.buildSyntax(format: format),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return declName
        .withLeadingTrivia(leadingTrivia)
    }

    return declName
  }

  /// Conformance for `DeclName` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declName = buildDeclName(format: format, leadingTrivia: leadingTrivia)
    return Syntax(declName)
  }
}

public struct ImplementsAttributeArguments: SyntaxBuildable {
  let type: SimpleTypeIdentifier
  let comma: TokenSyntax
  let declBaseName: SyntaxBuildable
  let declNameArguments: DeclNameArguments?

  public init(
    type: SimpleTypeIdentifier,
    comma: TokenSyntax,
    declBaseName: SyntaxBuildable,
    declNameArguments: DeclNameArguments?
  ) {
    self.type = type
    self.comma = comma
    self.declBaseName = declBaseName
    self.declNameArguments = declNameArguments
  }
  
  func buildImplementsAttributeArguments(format: Format, leadingTrivia: Trivia? = nil) -> ImplementsAttributeArgumentsSyntax {
    let implementsAttributeArguments = SyntaxFactory.makeImplementsAttributeArguments(
      type: type.buildSimpleTypeIdentifier(format: format),
      comma: comma,
      declBaseName: declBaseName.buildSyntax(format: format),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return implementsAttributeArguments
        .withLeadingTrivia(leadingTrivia)
    }

    return implementsAttributeArguments
  }

  /// Conformance for `ImplementsAttributeArguments` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let implementsAttributeArguments = buildImplementsAttributeArguments(format: format, leadingTrivia: leadingTrivia)
    return Syntax(implementsAttributeArguments)
  }
}

public struct ObjCSelectorPiece: SyntaxBuildable {
  let name: TokenSyntax?
  let colon: TokenSyntax?

  public init(
    name: TokenSyntax?,
    colon: TokenSyntax?
  ) {
    self.name = name
    self.colon = colon
  }
  
  func buildObjCSelectorPiece(format: Format, leadingTrivia: Trivia? = nil) -> ObjCSelectorPieceSyntax {
    let objCSelectorPiece = SyntaxFactory.makeObjCSelectorPiece(
      name: name,
      colon: colon
    )
    
    if let leadingTrivia = leadingTrivia {
      return objCSelectorPiece
        .withLeadingTrivia(leadingTrivia)
    }

    return objCSelectorPiece
  }

  /// Conformance for `ObjCSelectorPiece` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let objCSelectorPiece = buildObjCSelectorPiece(format: format, leadingTrivia: leadingTrivia)
    return Syntax(objCSelectorPiece)
  }
}

// MARK: - Syntax collection
public struct ObjCSelector: SyntaxBuildable {
  let elements: [ObjCSelectorPiece]

  public init(_ elements: [ObjCSelectorPiece]) {
    self.elements = elements
  }

  public func buildObjCSelector(format: Format, leadingTrivia: Trivia? = nil) -> ObjCSelectorSyntax {
    return SyntaxFactory.makeObjCSelector(elements.map {
      $0.buildObjCSelectorPiece(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let objCSelector = buildObjCSelector(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(objCSelector).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(objCSelector)
  }
}

public struct DifferentiableAttributeArguments: SyntaxBuildable {
  let diffKind: TokenSyntax?
  let diffKindComma: TokenSyntax?
  let diffParams: DifferentiabilityParamsClause?
  let diffParamsComma: TokenSyntax?
  let whereClause: GenericWhereClause?

  public init(
    diffKind: TokenSyntax?,
    diffKindComma: TokenSyntax?,
    diffParams: DifferentiabilityParamsClause?,
    diffParamsComma: TokenSyntax?,
    whereClause: GenericWhereClause?
  ) {
    self.diffKind = diffKind
    self.diffKindComma = diffKindComma
    self.diffParams = diffParams
    self.diffParamsComma = diffParamsComma
    self.whereClause = whereClause
  }
  
  func buildDifferentiableAttributeArguments(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiableAttributeArgumentsSyntax {
    let differentiableAttributeArguments = SyntaxFactory.makeDifferentiableAttributeArguments(
      diffKind: diffKind,
      diffKindComma: diffKindComma,
      diffParams: diffParams?.buildDifferentiabilityParamsClause(format: format),
      diffParamsComma: diffParamsComma,
      whereClause: whereClause?.buildGenericWhereClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return differentiableAttributeArguments
        .withLeadingTrivia(leadingTrivia)
    }

    return differentiableAttributeArguments
  }

  /// Conformance for `DifferentiableAttributeArguments` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiableAttributeArguments = buildDifferentiableAttributeArguments(format: format, leadingTrivia: leadingTrivia)
    return Syntax(differentiableAttributeArguments)
  }
}

public struct DifferentiabilityParamsClause: SyntaxBuildable {
  let wrtLabel: TokenSyntax
  let colon: TokenSyntax
  let parameters: SyntaxBuildable

  public init(
    wrtLabel: TokenSyntax,
    colon: TokenSyntax,
    parameters: SyntaxBuildable
  ) {
    self.wrtLabel = wrtLabel
    self.colon = colon
    self.parameters = parameters
  }
  
  func buildDifferentiabilityParamsClause(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamsClauseSyntax {
    let differentiabilityParamsClause = SyntaxFactory.makeDifferentiabilityParamsClause(
      wrtLabel: wrtLabel,
      colon: colon,
      parameters: parameters.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return differentiabilityParamsClause
        .withLeadingTrivia(leadingTrivia)
    }

    return differentiabilityParamsClause
  }

  /// Conformance for `DifferentiabilityParamsClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiabilityParamsClause = buildDifferentiabilityParamsClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(differentiabilityParamsClause)
  }
}

public struct DifferentiabilityParams: SyntaxBuildable {
  let leftParen: TokenSyntax
  let diffParams: DifferentiabilityParamList
  let rightParen: TokenSyntax

  public init(
    leftParen: TokenSyntax,
    diffParams: DifferentiabilityParamList,
    rightParen: TokenSyntax
  ) {
    self.leftParen = leftParen
    self.diffParams = diffParams
    self.rightParen = rightParen
  }
  
  func buildDifferentiabilityParams(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamsSyntax {
    let differentiabilityParams = SyntaxFactory.makeDifferentiabilityParams(
      leftParen: leftParen,
      diffParams: diffParams.buildDifferentiabilityParamList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return differentiabilityParams
        .withLeadingTrivia(leadingTrivia)
    }

    return differentiabilityParams
  }

  /// Conformance for `DifferentiabilityParams` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiabilityParams = buildDifferentiabilityParams(format: format, leadingTrivia: leadingTrivia)
    return Syntax(differentiabilityParams)
  }
}

// MARK: - Syntax collection
public struct DifferentiabilityParamList: SyntaxBuildable {
  let elements: [DifferentiabilityParam]

  public init(_ elements: [DifferentiabilityParam]) {
    self.elements = elements
  }

  public func buildDifferentiabilityParamList(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamListSyntax {
    return SyntaxFactory.makeDifferentiabilityParamList(elements.map {
      $0.buildDifferentiabilityParam(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiabilityParamList = buildDifferentiabilityParamList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(differentiabilityParamList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(differentiabilityParamList)
  }
}

public struct DifferentiabilityParam: SyntaxBuildable {
  let parameter: SyntaxBuildable
  let trailingComma: TokenSyntax?

  public init(
    parameter: SyntaxBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.parameter = parameter
    self.trailingComma = trailingComma
  }
  
  func buildDifferentiabilityParam(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamSyntax {
    let differentiabilityParam = SyntaxFactory.makeDifferentiabilityParam(
      parameter: parameter.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return differentiabilityParam
        .withLeadingTrivia(leadingTrivia)
    }

    return differentiabilityParam
  }

  /// Conformance for `DifferentiabilityParam` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiabilityParam = buildDifferentiabilityParam(format: format, leadingTrivia: leadingTrivia)
    return Syntax(differentiabilityParam)
  }
}

public struct DerivativeRegistrationAttributeArguments: SyntaxBuildable {
  let ofLabel: TokenSyntax
  let colon: TokenSyntax
  let originalDeclName: QualifiedDeclName
  let period: TokenSyntax?
  let accessorKind: TokenSyntax?
  let comma: TokenSyntax?
  let diffParams: DifferentiabilityParamsClause?

  public init(
    ofLabel: TokenSyntax,
    colon: TokenSyntax,
    originalDeclName: QualifiedDeclName,
    period: TokenSyntax?,
    accessorKind: TokenSyntax?,
    comma: TokenSyntax?,
    diffParams: DifferentiabilityParamsClause?
  ) {
    self.ofLabel = ofLabel
    self.colon = colon
    self.originalDeclName = originalDeclName
    self.period = period
    self.accessorKind = accessorKind
    self.comma = comma
    self.diffParams = diffParams
  }
  
  func buildDerivativeRegistrationAttributeArguments(format: Format, leadingTrivia: Trivia? = nil) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let derivativeRegistrationAttributeArguments = SyntaxFactory.makeDerivativeRegistrationAttributeArguments(
      ofLabel: ofLabel,
      colon: colon,
      originalDeclName: originalDeclName.buildQualifiedDeclName(format: format),
      period: period,
      accessorKind: accessorKind,
      comma: comma,
      diffParams: diffParams?.buildDifferentiabilityParamsClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return derivativeRegistrationAttributeArguments
        .withLeadingTrivia(leadingTrivia)
    }

    return derivativeRegistrationAttributeArguments
  }

  /// Conformance for `DerivativeRegistrationAttributeArguments` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let derivativeRegistrationAttributeArguments = buildDerivativeRegistrationAttributeArguments(format: format, leadingTrivia: leadingTrivia)
    return Syntax(derivativeRegistrationAttributeArguments)
  }
}

public struct QualifiedDeclName: SyntaxBuildable {
  let baseType: TypeBuildable?
  let dot: TokenSyntax?
  let name: TokenSyntax
  let arguments: DeclNameArguments?

  public init(
    baseType: TypeBuildable?,
    dot: TokenSyntax?,
    name: TokenSyntax,
    arguments: DeclNameArguments?
  ) {
    self.baseType = baseType
    self.dot = dot
    self.name = name
    self.arguments = arguments
  }
  
  func buildQualifiedDeclName(format: Format, leadingTrivia: Trivia? = nil) -> QualifiedDeclNameSyntax {
    let qualifiedDeclName = SyntaxFactory.makeQualifiedDeclName(
      baseType: baseType?.buildType(format: format),
      dot: dot,
      name: name,
      arguments: arguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return qualifiedDeclName
        .withLeadingTrivia(leadingTrivia)
    }

    return qualifiedDeclName
  }

  /// Conformance for `QualifiedDeclName` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let qualifiedDeclName = buildQualifiedDeclName(format: format, leadingTrivia: leadingTrivia)
    return Syntax(qualifiedDeclName)
  }
}

public struct FunctionDeclName: SyntaxBuildable {
  let name: SyntaxBuildable
  let arguments: DeclNameArguments?

  public init(
    name: SyntaxBuildable,
    arguments: DeclNameArguments?
  ) {
    self.name = name
    self.arguments = arguments
  }
  
  func buildFunctionDeclName(format: Format, leadingTrivia: Trivia? = nil) -> FunctionDeclNameSyntax {
    let functionDeclName = SyntaxFactory.makeFunctionDeclName(
      name: name.buildSyntax(format: format),
      arguments: arguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return functionDeclName
        .withLeadingTrivia(leadingTrivia)
    }

    return functionDeclName
  }

  /// Conformance for `FunctionDeclName` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let functionDeclName = buildFunctionDeclName(format: format, leadingTrivia: leadingTrivia)
    return Syntax(functionDeclName)
  }
}

public struct ContinueStmt: StmtBuildable {
  let continueKeyword: TokenSyntax
  let label: TokenSyntax?

  public init(
    continueKeyword: TokenSyntax,
    label: TokenSyntax?
  ) {
    self.continueKeyword = continueKeyword
    self.label = label
  }
  
  func buildContinueStmt(format: Format, leadingTrivia: Trivia? = nil) -> ContinueStmtSyntax {
    let continueStmt = SyntaxFactory.makeContinueStmt(
      continueKeyword: continueKeyword,
      label: label
    )
    
    if let leadingTrivia = leadingTrivia {
      return continueStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return continueStmt
  }

  /// Conformance for `ContinueStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let continueStmt = buildContinueStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(continueStmt)
  }
}

public struct WhileStmt: StmtBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let whileKeyword: TokenSyntax
  let conditions: ConditionElementList
  let body: CodeBlock

  public init(
    labelName: TokenSyntax?,
    labelColon: TokenSyntax?,
    whileKeyword: TokenSyntax,
    conditions: ConditionElementList,
    body: CodeBlock
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    self.whileKeyword = whileKeyword
    self.conditions = conditions
    self.body = body
  }
  
  func buildWhileStmt(format: Format, leadingTrivia: Trivia? = nil) -> WhileStmtSyntax {
    let whileStmt = SyntaxFactory.makeWhileStmt(
      labelName: labelName,
      labelColon: labelColon,
      whileKeyword: whileKeyword,
      conditions: conditions.buildConditionElementList(format: format),
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return whileStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return whileStmt
  }

  /// Conformance for `WhileStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let whileStmt = buildWhileStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(whileStmt)
  }
}

public struct DeferStmt: StmtBuildable {
  let deferKeyword: TokenSyntax
  let body: CodeBlock

  public init(
    deferKeyword: TokenSyntax,
    body: CodeBlock
  ) {
    self.deferKeyword = deferKeyword
    self.body = body
  }
  
  func buildDeferStmt(format: Format, leadingTrivia: Trivia? = nil) -> DeferStmtSyntax {
    let deferStmt = SyntaxFactory.makeDeferStmt(
      deferKeyword: deferKeyword,
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return deferStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return deferStmt
  }

  /// Conformance for `DeferStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let deferStmt = buildDeferStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(deferStmt)
  }
}

public struct ExpressionStmt: StmtBuildable {
  let expression: ExprBuildable

  public init(
    expression: ExprBuildable
  ) {
    self.expression = expression
  }
  
  func buildExpressionStmt(format: Format, leadingTrivia: Trivia? = nil) -> ExpressionStmtSyntax {
    let expressionStmt = SyntaxFactory.makeExpressionStmt(
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return expressionStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return expressionStmt
  }

  /// Conformance for `ExpressionStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let expressionStmt = buildExpressionStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(expressionStmt)
  }
}

// MARK: - Syntax collection
public struct SwitchCaseList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [SyntaxBuildable]) {
    self.elements = elements
  }

  public func buildSwitchCaseList(format: Format, leadingTrivia: Trivia? = nil) -> SwitchCaseListSyntax {
    return SyntaxFactory.makeSwitchCaseList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let switchCaseList = buildSwitchCaseList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(switchCaseList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(switchCaseList)
  }
}

public struct RepeatWhileStmt: StmtBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let repeatKeyword: TokenSyntax
  let body: CodeBlock
  let whileKeyword: TokenSyntax
  let condition: ExprBuildable

  public init(
    labelName: TokenSyntax?,
    labelColon: TokenSyntax?,
    repeatKeyword: TokenSyntax,
    body: CodeBlock,
    whileKeyword: TokenSyntax,
    condition: ExprBuildable
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    self.repeatKeyword = repeatKeyword
    self.body = body
    self.whileKeyword = whileKeyword
    self.condition = condition
  }
  
  func buildRepeatWhileStmt(format: Format, leadingTrivia: Trivia? = nil) -> RepeatWhileStmtSyntax {
    let repeatWhileStmt = SyntaxFactory.makeRepeatWhileStmt(
      labelName: labelName,
      labelColon: labelColon,
      repeatKeyword: repeatKeyword,
      body: body.buildCodeBlock(format: format),
      whileKeyword: whileKeyword,
      condition: condition.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return repeatWhileStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return repeatWhileStmt
  }

  /// Conformance for `RepeatWhileStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let repeatWhileStmt = buildRepeatWhileStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(repeatWhileStmt)
  }
}

public struct GuardStmt: StmtBuildable {
  let guardKeyword: TokenSyntax
  let conditions: ConditionElementList
  let elseKeyword: TokenSyntax
  let body: CodeBlock

  public init(
    guardKeyword: TokenSyntax,
    conditions: ConditionElementList,
    elseKeyword: TokenSyntax,
    body: CodeBlock
  ) {
    self.guardKeyword = guardKeyword
    self.conditions = conditions
    self.elseKeyword = elseKeyword
    self.body = body
  }
  
  func buildGuardStmt(format: Format, leadingTrivia: Trivia? = nil) -> GuardStmtSyntax {
    let guardStmt = SyntaxFactory.makeGuardStmt(
      guardKeyword: guardKeyword,
      conditions: conditions.buildConditionElementList(format: format),
      elseKeyword: elseKeyword,
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return guardStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return guardStmt
  }

  /// Conformance for `GuardStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let guardStmt = buildGuardStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(guardStmt)
  }
}

public struct WhereClause: SyntaxBuildable {
  let whereKeyword: TokenSyntax
  let guardResult: ExprBuildable

  public init(
    whereKeyword: TokenSyntax,
    guardResult: ExprBuildable
  ) {
    self.whereKeyword = whereKeyword
    self.guardResult = guardResult
  }
  
  func buildWhereClause(format: Format, leadingTrivia: Trivia? = nil) -> WhereClauseSyntax {
    let whereClause = SyntaxFactory.makeWhereClause(
      whereKeyword: whereKeyword,
      guardResult: guardResult.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return whereClause
        .withLeadingTrivia(leadingTrivia)
    }

    return whereClause
  }

  /// Conformance for `WhereClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let whereClause = buildWhereClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(whereClause)
  }
}

public struct ForInStmt: StmtBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let forKeyword: TokenSyntax
  let tryKeyword: TokenSyntax?
  let awaitKeyword: TokenSyntax?
  let caseKeyword: TokenSyntax?
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let inKeyword: TokenSyntax
  let sequenceExpr: ExprBuildable
  let whereClause: WhereClause?
  let body: CodeBlock

  public init(
    labelName: TokenSyntax?,
    labelColon: TokenSyntax?,
    forKeyword: TokenSyntax,
    tryKeyword: TokenSyntax?,
    awaitKeyword: TokenSyntax?,
    caseKeyword: TokenSyntax?,
    pattern: PatternBuildable,
    typeAnnotation: TypeAnnotation?,
    inKeyword: TokenSyntax,
    sequenceExpr: ExprBuildable,
    whereClause: WhereClause?,
    body: CodeBlock
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    self.forKeyword = forKeyword
    self.tryKeyword = tryKeyword
    self.awaitKeyword = awaitKeyword
    self.caseKeyword = caseKeyword
    self.pattern = pattern
    self.typeAnnotation = typeAnnotation
    self.inKeyword = inKeyword
    self.sequenceExpr = sequenceExpr
    self.whereClause = whereClause
    self.body = body
  }
  
  func buildForInStmt(format: Format, leadingTrivia: Trivia? = nil) -> ForInStmtSyntax {
    let forInStmt = SyntaxFactory.makeForInStmt(
      labelName: labelName,
      labelColon: labelColon,
      forKeyword: forKeyword,
      tryKeyword: tryKeyword,
      awaitKeyword: awaitKeyword,
      caseKeyword: caseKeyword,
      pattern: pattern.buildPattern(format: format),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format),
      inKeyword: inKeyword,
      sequenceExpr: sequenceExpr.buildExpr(format: format),
      whereClause: whereClause?.buildWhereClause(format: format),
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return forInStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return forInStmt
  }

  /// Conformance for `ForInStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let forInStmt = buildForInStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(forInStmt)
  }
}

public struct SwitchStmt: StmtBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let switchKeyword: TokenSyntax
  let expression: ExprBuildable
  let leftBrace: TokenSyntax
  let cases: SwitchCaseList
  let rightBrace: TokenSyntax

  public init(
    labelName: TokenSyntax?,
    labelColon: TokenSyntax?,
    switchKeyword: TokenSyntax,
    expression: ExprBuildable,
    leftBrace: TokenSyntax,
    cases: SwitchCaseList,
    rightBrace: TokenSyntax
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    self.switchKeyword = switchKeyword
    self.expression = expression
    self.leftBrace = leftBrace
    self.cases = cases
    self.rightBrace = rightBrace
  }
  
  func buildSwitchStmt(format: Format, leadingTrivia: Trivia? = nil) -> SwitchStmtSyntax {
    let switchStmt = SyntaxFactory.makeSwitchStmt(
      labelName: labelName,
      labelColon: labelColon,
      switchKeyword: switchKeyword,
      expression: expression.buildExpr(format: format),
      leftBrace: leftBrace,
      cases: cases.buildSwitchCaseList(format: format),
      rightBrace: rightBrace
    )
    
    if let leadingTrivia = leadingTrivia {
      return switchStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return switchStmt
  }

  /// Conformance for `SwitchStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let switchStmt = buildSwitchStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(switchStmt)
  }
}

// MARK: - Syntax collection
public struct CatchClauseList: SyntaxBuildable {
  let elements: [CatchClause]

  public init(_ elements: [CatchClause]) {
    self.elements = elements
  }

  public func buildCatchClauseList(format: Format, leadingTrivia: Trivia? = nil) -> CatchClauseListSyntax {
    return SyntaxFactory.makeCatchClauseList(elements.map {
      $0.buildCatchClause(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let catchClauseList = buildCatchClauseList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(catchClauseList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(catchClauseList)
  }
}

public struct DoStmt: StmtBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let doKeyword: TokenSyntax
  let body: CodeBlock
  let catchClauses: CatchClauseList?

  public init(
    labelName: TokenSyntax?,
    labelColon: TokenSyntax?,
    doKeyword: TokenSyntax,
    body: CodeBlock,
    catchClauses: CatchClauseList?
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    self.doKeyword = doKeyword
    self.body = body
    self.catchClauses = catchClauses
  }
  
  func buildDoStmt(format: Format, leadingTrivia: Trivia? = nil) -> DoStmtSyntax {
    let doStmt = SyntaxFactory.makeDoStmt(
      labelName: labelName,
      labelColon: labelColon,
      doKeyword: doKeyword,
      body: body.buildCodeBlock(format: format),
      catchClauses: catchClauses?.buildCatchClauseList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return doStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return doStmt
  }

  /// Conformance for `DoStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let doStmt = buildDoStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(doStmt)
  }
}

public struct ReturnStmt: StmtBuildable {
  let returnKeyword: TokenSyntax
  let expression: ExprBuildable?

  public init(
    returnKeyword: TokenSyntax,
    expression: ExprBuildable?
  ) {
    self.returnKeyword = returnKeyword
    self.expression = expression
  }
  
  func buildReturnStmt(format: Format, leadingTrivia: Trivia? = nil) -> ReturnStmtSyntax {
    let returnStmt = SyntaxFactory.makeReturnStmt(
      returnKeyword: returnKeyword,
      expression: expression?.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return returnStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return returnStmt
  }

  /// Conformance for `ReturnStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let returnStmt = buildReturnStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(returnStmt)
  }
}

public struct YieldStmt: StmtBuildable {
  let yieldKeyword: TokenSyntax
  let yields: SyntaxBuildable

  public init(
    yieldKeyword: TokenSyntax,
    yields: SyntaxBuildable
  ) {
    self.yieldKeyword = yieldKeyword
    self.yields = yields
  }
  
  func buildYieldStmt(format: Format, leadingTrivia: Trivia? = nil) -> YieldStmtSyntax {
    let yieldStmt = SyntaxFactory.makeYieldStmt(
      yieldKeyword: yieldKeyword,
      yields: yields.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return yieldStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return yieldStmt
  }

  /// Conformance for `YieldStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let yieldStmt = buildYieldStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(yieldStmt)
  }
}

public struct YieldList: SyntaxBuildable {
  let leftParen: TokenSyntax
  let elementList: ExprList
  let trailingComma: TokenSyntax?
  let rightParen: TokenSyntax

  public init(
    leftParen: TokenSyntax,
    elementList: ExprList,
    trailingComma: TokenSyntax?,
    rightParen: TokenSyntax
  ) {
    self.leftParen = leftParen
    self.elementList = elementList
    self.trailingComma = trailingComma
    self.rightParen = rightParen
  }
  
  func buildYieldList(format: Format, leadingTrivia: Trivia? = nil) -> YieldListSyntax {
    let yieldList = SyntaxFactory.makeYieldList(
      leftParen: leftParen,
      elementList: elementList.buildExprList(format: format),
      trailingComma: trailingComma,
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return yieldList
        .withLeadingTrivia(leadingTrivia)
    }

    return yieldList
  }

  /// Conformance for `YieldList` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let yieldList = buildYieldList(format: format, leadingTrivia: leadingTrivia)
    return Syntax(yieldList)
  }
}

public struct FallthroughStmt: StmtBuildable {
  let fallthroughKeyword: TokenSyntax

  public init(
    fallthroughKeyword: TokenSyntax
  ) {
    self.fallthroughKeyword = fallthroughKeyword
  }
  
  func buildFallthroughStmt(format: Format, leadingTrivia: Trivia? = nil) -> FallthroughStmtSyntax {
    let fallthroughStmt = SyntaxFactory.makeFallthroughStmt(
      fallthroughKeyword: fallthroughKeyword
    )
    
    if let leadingTrivia = leadingTrivia {
      return fallthroughStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return fallthroughStmt
  }

  /// Conformance for `FallthroughStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let fallthroughStmt = buildFallthroughStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(fallthroughStmt)
  }
}

public struct BreakStmt: StmtBuildable {
  let breakKeyword: TokenSyntax
  let label: TokenSyntax?

  public init(
    breakKeyword: TokenSyntax,
    label: TokenSyntax?
  ) {
    self.breakKeyword = breakKeyword
    self.label = label
  }
  
  func buildBreakStmt(format: Format, leadingTrivia: Trivia? = nil) -> BreakStmtSyntax {
    let breakStmt = SyntaxFactory.makeBreakStmt(
      breakKeyword: breakKeyword,
      label: label
    )
    
    if let leadingTrivia = leadingTrivia {
      return breakStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return breakStmt
  }

  /// Conformance for `BreakStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let breakStmt = buildBreakStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(breakStmt)
  }
}

// MARK: - Syntax collection
public struct CaseItemList: SyntaxBuildable {
  let elements: [CaseItem]

  public init(_ elements: [CaseItem]) {
    self.elements = elements
  }

  public func buildCaseItemList(format: Format, leadingTrivia: Trivia? = nil) -> CaseItemListSyntax {
    return SyntaxFactory.makeCaseItemList(elements.map {
      $0.buildCaseItem(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let caseItemList = buildCaseItemList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(caseItemList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(caseItemList)
  }
}

// MARK: - Syntax collection
public struct CatchItemList: SyntaxBuildable {
  let elements: [CatchItem]

  public init(_ elements: [CatchItem]) {
    self.elements = elements
  }

  public func buildCatchItemList(format: Format, leadingTrivia: Trivia? = nil) -> CatchItemListSyntax {
    return SyntaxFactory.makeCatchItemList(elements.map {
      $0.buildCatchItem(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let catchItemList = buildCatchItemList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(catchItemList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(catchItemList)
  }
}

public struct ConditionElement: SyntaxBuildable {
  let condition: SyntaxBuildable
  let trailingComma: TokenSyntax?

  public init(
    condition: SyntaxBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.condition = condition
    self.trailingComma = trailingComma
  }
  
  func buildConditionElement(format: Format, leadingTrivia: Trivia? = nil) -> ConditionElementSyntax {
    let conditionElement = SyntaxFactory.makeConditionElement(
      condition: condition.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return conditionElement
        .withLeadingTrivia(leadingTrivia)
    }

    return conditionElement
  }

  /// Conformance for `ConditionElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let conditionElement = buildConditionElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(conditionElement)
  }
}

public struct AvailabilityCondition: SyntaxBuildable {
  let poundAvailableKeyword: TokenSyntax
  let leftParen: TokenSyntax
  let availabilitySpec: AvailabilitySpecList
  let rightParen: TokenSyntax

  public init(
    poundAvailableKeyword: TokenSyntax,
    leftParen: TokenSyntax,
    availabilitySpec: AvailabilitySpecList,
    rightParen: TokenSyntax
  ) {
    self.poundAvailableKeyword = poundAvailableKeyword
    self.leftParen = leftParen
    self.availabilitySpec = availabilitySpec
    self.rightParen = rightParen
  }
  
  func buildAvailabilityCondition(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityConditionSyntax {
    let availabilityCondition = SyntaxFactory.makeAvailabilityCondition(
      poundAvailableKeyword: poundAvailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityCondition
        .withLeadingTrivia(leadingTrivia)
    }

    return availabilityCondition
  }

  /// Conformance for `AvailabilityCondition` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityCondition = buildAvailabilityCondition(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityCondition)
  }
}

public struct MatchingPatternCondition: SyntaxBuildable {
  let caseKeyword: TokenSyntax
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause

  public init(
    caseKeyword: TokenSyntax,
    pattern: PatternBuildable,
    typeAnnotation: TypeAnnotation?,
    initializer: InitializerClause
  ) {
    self.caseKeyword = caseKeyword
    self.pattern = pattern
    self.typeAnnotation = typeAnnotation
    self.initializer = initializer
  }
  
  func buildMatchingPatternCondition(format: Format, leadingTrivia: Trivia? = nil) -> MatchingPatternConditionSyntax {
    let matchingPatternCondition = SyntaxFactory.makeMatchingPatternCondition(
      caseKeyword: caseKeyword,
      pattern: pattern.buildPattern(format: format),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format),
      initializer: initializer.buildInitializerClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return matchingPatternCondition
        .withLeadingTrivia(leadingTrivia)
    }

    return matchingPatternCondition
  }

  /// Conformance for `MatchingPatternCondition` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let matchingPatternCondition = buildMatchingPatternCondition(format: format, leadingTrivia: leadingTrivia)
    return Syntax(matchingPatternCondition)
  }
}

public struct OptionalBindingCondition: SyntaxBuildable {
  let letOrVarKeyword: TokenSyntax
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause

  public init(
    letOrVarKeyword: TokenSyntax,
    pattern: PatternBuildable,
    typeAnnotation: TypeAnnotation?,
    initializer: InitializerClause
  ) {
    self.letOrVarKeyword = letOrVarKeyword
    self.pattern = pattern
    self.typeAnnotation = typeAnnotation
    self.initializer = initializer
  }
  
  func buildOptionalBindingCondition(format: Format, leadingTrivia: Trivia? = nil) -> OptionalBindingConditionSyntax {
    let optionalBindingCondition = SyntaxFactory.makeOptionalBindingCondition(
      letOrVarKeyword: letOrVarKeyword,
      pattern: pattern.buildPattern(format: format),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format),
      initializer: initializer.buildInitializerClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return optionalBindingCondition
        .withLeadingTrivia(leadingTrivia)
    }

    return optionalBindingCondition
  }

  /// Conformance for `OptionalBindingCondition` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let optionalBindingCondition = buildOptionalBindingCondition(format: format, leadingTrivia: leadingTrivia)
    return Syntax(optionalBindingCondition)
  }
}

// MARK: - Syntax collection
public struct ConditionElementList: SyntaxBuildable {
  let elements: [ConditionElement]

  public init(_ elements: [ConditionElement]) {
    self.elements = elements
  }

  public func buildConditionElementList(format: Format, leadingTrivia: Trivia? = nil) -> ConditionElementListSyntax {
    return SyntaxFactory.makeConditionElementList(elements.map {
      $0.buildConditionElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let conditionElementList = buildConditionElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(conditionElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(conditionElementList)
  }
}

public struct DeclarationStmt: StmtBuildable {
  let declaration: DeclBuildable

  public init(
    declaration: DeclBuildable
  ) {
    self.declaration = declaration
  }
  
  func buildDeclarationStmt(format: Format, leadingTrivia: Trivia? = nil) -> DeclarationStmtSyntax {
    let declarationStmt = SyntaxFactory.makeDeclarationStmt(
      declaration: declaration.buildDecl(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return declarationStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return declarationStmt
  }

  /// Conformance for `DeclarationStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let declarationStmt = buildDeclarationStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(declarationStmt)
  }
}

public struct ThrowStmt: StmtBuildable {
  let throwKeyword: TokenSyntax
  let expression: ExprBuildable

  public init(
    throwKeyword: TokenSyntax,
    expression: ExprBuildable
  ) {
    self.throwKeyword = throwKeyword
    self.expression = expression
  }
  
  func buildThrowStmt(format: Format, leadingTrivia: Trivia? = nil) -> ThrowStmtSyntax {
    let throwStmt = SyntaxFactory.makeThrowStmt(
      throwKeyword: throwKeyword,
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return throwStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return throwStmt
  }

  /// Conformance for `ThrowStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let throwStmt = buildThrowStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(throwStmt)
  }
}

public struct IfStmt: StmtBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let ifKeyword: TokenSyntax
  let conditions: ConditionElementList
  let body: CodeBlock
  let elseKeyword: TokenSyntax?
  let elseBody: SyntaxBuildable?

  public init(
    labelName: TokenSyntax?,
    labelColon: TokenSyntax?,
    ifKeyword: TokenSyntax,
    conditions: ConditionElementList,
    body: CodeBlock,
    elseKeyword: TokenSyntax?,
    elseBody: SyntaxBuildable?
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    self.ifKeyword = ifKeyword
    self.conditions = conditions
    self.body = body
    self.elseKeyword = elseKeyword
    self.elseBody = elseBody
  }
  
  func buildIfStmt(format: Format, leadingTrivia: Trivia? = nil) -> IfStmtSyntax {
    let ifStmt = SyntaxFactory.makeIfStmt(
      labelName: labelName,
      labelColon: labelColon,
      ifKeyword: ifKeyword,
      conditions: conditions.buildConditionElementList(format: format),
      body: body.buildCodeBlock(format: format),
      elseKeyword: elseKeyword,
      elseBody: elseBody?.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return ifStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return ifStmt
  }

  /// Conformance for `IfStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let ifStmt = buildIfStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(ifStmt)
  }
}

public struct ElseIfContinuation: SyntaxBuildable {
  let ifStatement: IfStmt

  public init(
    ifStatement: IfStmt
  ) {
    self.ifStatement = ifStatement
  }
  
  func buildElseIfContinuation(format: Format, leadingTrivia: Trivia? = nil) -> ElseIfContinuationSyntax {
    let elseIfContinuation = SyntaxFactory.makeElseIfContinuation(
      ifStatement: ifStatement.buildIfStmt(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return elseIfContinuation
        .withLeadingTrivia(leadingTrivia)
    }

    return elseIfContinuation
  }

  /// Conformance for `ElseIfContinuation` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let elseIfContinuation = buildElseIfContinuation(format: format, leadingTrivia: leadingTrivia)
    return Syntax(elseIfContinuation)
  }
}

public struct ElseBlock: SyntaxBuildable {
  let elseKeyword: TokenSyntax
  let body: CodeBlock

  public init(
    elseKeyword: TokenSyntax,
    body: CodeBlock
  ) {
    self.elseKeyword = elseKeyword
    self.body = body
  }
  
  func buildElseBlock(format: Format, leadingTrivia: Trivia? = nil) -> ElseBlockSyntax {
    let elseBlock = SyntaxFactory.makeElseBlock(
      elseKeyword: elseKeyword,
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return elseBlock
        .withLeadingTrivia(leadingTrivia)
    }

    return elseBlock
  }

  /// Conformance for `ElseBlock` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let elseBlock = buildElseBlock(format: format, leadingTrivia: leadingTrivia)
    return Syntax(elseBlock)
  }
}

public struct SwitchCase: SyntaxBuildable {
  let unknownAttr: Attribute?
  let label: SyntaxBuildable
  let statements: CodeBlockItemList

  public init(
    unknownAttr: Attribute?,
    label: SyntaxBuildable,
    statements: CodeBlockItemList
  ) {
    self.unknownAttr = unknownAttr
    self.label = label
    self.statements = statements
  }
  
  func buildSwitchCase(format: Format, leadingTrivia: Trivia? = nil) -> SwitchCaseSyntax {
    let switchCase = SyntaxFactory.makeSwitchCase(
      unknownAttr: unknownAttr?.buildAttribute(format: format),
      label: label.buildSyntax(format: format),
      statements: statements.buildCodeBlockItemList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return switchCase
        .withLeadingTrivia(leadingTrivia)
    }

    return switchCase
  }

  /// Conformance for `SwitchCase` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let switchCase = buildSwitchCase(format: format, leadingTrivia: leadingTrivia)
    return Syntax(switchCase)
  }
}

public struct SwitchDefaultLabel: SyntaxBuildable {
  let defaultKeyword: TokenSyntax
  let colon: TokenSyntax

  public init(
    defaultKeyword: TokenSyntax,
    colon: TokenSyntax
  ) {
    self.defaultKeyword = defaultKeyword
    self.colon = colon
  }
  
  func buildSwitchDefaultLabel(format: Format, leadingTrivia: Trivia? = nil) -> SwitchDefaultLabelSyntax {
    let switchDefaultLabel = SyntaxFactory.makeSwitchDefaultLabel(
      defaultKeyword: defaultKeyword,
      colon: colon
    )
    
    if let leadingTrivia = leadingTrivia {
      return switchDefaultLabel
        .withLeadingTrivia(leadingTrivia)
    }

    return switchDefaultLabel
  }

  /// Conformance for `SwitchDefaultLabel` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let switchDefaultLabel = buildSwitchDefaultLabel(format: format, leadingTrivia: leadingTrivia)
    return Syntax(switchDefaultLabel)
  }
}

public struct CaseItem: SyntaxBuildable {
  let pattern: PatternBuildable
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  public init(
    pattern: PatternBuildable,
    whereClause: WhereClause?,
    trailingComma: TokenSyntax?
  ) {
    self.pattern = pattern
    self.whereClause = whereClause
    self.trailingComma = trailingComma
  }
  
  func buildCaseItem(format: Format, leadingTrivia: Trivia? = nil) -> CaseItemSyntax {
    let caseItem = SyntaxFactory.makeCaseItem(
      pattern: pattern.buildPattern(format: format),
      whereClause: whereClause?.buildWhereClause(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return caseItem
        .withLeadingTrivia(leadingTrivia)
    }

    return caseItem
  }

  /// Conformance for `CaseItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let caseItem = buildCaseItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(caseItem)
  }
}

public struct CatchItem: SyntaxBuildable {
  let pattern: PatternBuildable?
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  public init(
    pattern: PatternBuildable?,
    whereClause: WhereClause?,
    trailingComma: TokenSyntax?
  ) {
    self.pattern = pattern
    self.whereClause = whereClause
    self.trailingComma = trailingComma
  }
  
  func buildCatchItem(format: Format, leadingTrivia: Trivia? = nil) -> CatchItemSyntax {
    let catchItem = SyntaxFactory.makeCatchItem(
      pattern: pattern?.buildPattern(format: format),
      whereClause: whereClause?.buildWhereClause(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return catchItem
        .withLeadingTrivia(leadingTrivia)
    }

    return catchItem
  }

  /// Conformance for `CatchItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let catchItem = buildCatchItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(catchItem)
  }
}

public struct SwitchCaseLabel: SyntaxBuildable {
  let caseKeyword: TokenSyntax
  let caseItems: CaseItemList
  let colon: TokenSyntax

  public init(
    caseKeyword: TokenSyntax,
    caseItems: CaseItemList,
    colon: TokenSyntax
  ) {
    self.caseKeyword = caseKeyword
    self.caseItems = caseItems
    self.colon = colon
  }
  
  func buildSwitchCaseLabel(format: Format, leadingTrivia: Trivia? = nil) -> SwitchCaseLabelSyntax {
    let switchCaseLabel = SyntaxFactory.makeSwitchCaseLabel(
      caseKeyword: caseKeyword,
      caseItems: caseItems.buildCaseItemList(format: format),
      colon: colon
    )
    
    if let leadingTrivia = leadingTrivia {
      return switchCaseLabel
        .withLeadingTrivia(leadingTrivia)
    }

    return switchCaseLabel
  }

  /// Conformance for `SwitchCaseLabel` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let switchCaseLabel = buildSwitchCaseLabel(format: format, leadingTrivia: leadingTrivia)
    return Syntax(switchCaseLabel)
  }
}

public struct CatchClause: SyntaxBuildable {
  let catchKeyword: TokenSyntax
  let catchItems: CatchItemList?
  let body: CodeBlock

  public init(
    catchKeyword: TokenSyntax,
    catchItems: CatchItemList?,
    body: CodeBlock
  ) {
    self.catchKeyword = catchKeyword
    self.catchItems = catchItems
    self.body = body
  }
  
  func buildCatchClause(format: Format, leadingTrivia: Trivia? = nil) -> CatchClauseSyntax {
    let catchClause = SyntaxFactory.makeCatchClause(
      catchKeyword: catchKeyword,
      catchItems: catchItems?.buildCatchItemList(format: format),
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return catchClause
        .withLeadingTrivia(leadingTrivia)
    }

    return catchClause
  }

  /// Conformance for `CatchClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let catchClause = buildCatchClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(catchClause)
  }
}

public struct PoundAssertStmt: StmtBuildable {
  let poundAssert: TokenSyntax
  let leftParen: TokenSyntax
  let condition: ExprBuildable
  let comma: TokenSyntax?
  let message: TokenSyntax?
  let rightParen: TokenSyntax

  public init(
    poundAssert: TokenSyntax,
    leftParen: TokenSyntax,
    condition: ExprBuildable,
    comma: TokenSyntax?,
    message: TokenSyntax?,
    rightParen: TokenSyntax
  ) {
    self.poundAssert = poundAssert
    self.leftParen = leftParen
    self.condition = condition
    self.comma = comma
    self.message = message
    self.rightParen = rightParen
  }
  
  func buildPoundAssertStmt(format: Format, leadingTrivia: Trivia? = nil) -> PoundAssertStmtSyntax {
    let poundAssertStmt = SyntaxFactory.makePoundAssertStmt(
      poundAssert: poundAssert,
      leftParen: leftParen,
      condition: condition.buildExpr(format: format),
      comma: comma,
      message: message,
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundAssertStmt
        .withLeadingTrivia(leadingTrivia)
    }

    return poundAssertStmt
  }

  /// Conformance for `PoundAssertStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let poundAssertStmt = buildPoundAssertStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(poundAssertStmt)
  }
}

public struct GenericWhereClause: SyntaxBuildable {
  let whereKeyword: TokenSyntax
  let requirementList: GenericRequirementList

  public init(
    whereKeyword: TokenSyntax,
    requirementList: GenericRequirementList
  ) {
    self.whereKeyword = whereKeyword
    self.requirementList = requirementList
  }
  
  func buildGenericWhereClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericWhereClauseSyntax {
    let genericWhereClause = SyntaxFactory.makeGenericWhereClause(
      whereKeyword: whereKeyword,
      requirementList: requirementList.buildGenericRequirementList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericWhereClause
        .withLeadingTrivia(leadingTrivia)
    }

    return genericWhereClause
  }

  /// Conformance for `GenericWhereClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericWhereClause = buildGenericWhereClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericWhereClause)
  }
}

// MARK: - Syntax collection
public struct GenericRequirementList: SyntaxBuildable {
  let elements: [GenericRequirement]

  public init(_ elements: [GenericRequirement]) {
    self.elements = elements
  }

  public func buildGenericRequirementList(format: Format, leadingTrivia: Trivia? = nil) -> GenericRequirementListSyntax {
    return SyntaxFactory.makeGenericRequirementList(elements.map {
      $0.buildGenericRequirement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericRequirementList = buildGenericRequirementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(genericRequirementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(genericRequirementList)
  }
}

public struct GenericRequirement: SyntaxBuildable {
  let body: SyntaxBuildable
  let trailingComma: TokenSyntax?

  public init(
    body: SyntaxBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.body = body
    self.trailingComma = trailingComma
  }
  
  func buildGenericRequirement(format: Format, leadingTrivia: Trivia? = nil) -> GenericRequirementSyntax {
    let genericRequirement = SyntaxFactory.makeGenericRequirement(
      body: body.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericRequirement
        .withLeadingTrivia(leadingTrivia)
    }

    return genericRequirement
  }

  /// Conformance for `GenericRequirement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericRequirement = buildGenericRequirement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericRequirement)
  }
}

public struct SameTypeRequirement: SyntaxBuildable {
  let leftTypeIdentifier: TypeBuildable
  let equalityToken: TokenSyntax
  let rightTypeIdentifier: TypeBuildable

  public init(
    leftTypeIdentifier: TypeBuildable,
    equalityToken: TokenSyntax,
    rightTypeIdentifier: TypeBuildable
  ) {
    self.leftTypeIdentifier = leftTypeIdentifier
    self.equalityToken = equalityToken
    self.rightTypeIdentifier = rightTypeIdentifier
  }
  
  func buildSameTypeRequirement(format: Format, leadingTrivia: Trivia? = nil) -> SameTypeRequirementSyntax {
    let sameTypeRequirement = SyntaxFactory.makeSameTypeRequirement(
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format),
      equalityToken: equalityToken,
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return sameTypeRequirement
        .withLeadingTrivia(leadingTrivia)
    }

    return sameTypeRequirement
  }

  /// Conformance for `SameTypeRequirement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let sameTypeRequirement = buildSameTypeRequirement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(sameTypeRequirement)
  }
}

// MARK: - Syntax collection
public struct GenericParameterList: SyntaxBuildable {
  let elements: [GenericParameter]

  public init(_ elements: [GenericParameter]) {
    self.elements = elements
  }

  public func buildGenericParameterList(format: Format, leadingTrivia: Trivia? = nil) -> GenericParameterListSyntax {
    return SyntaxFactory.makeGenericParameterList(elements.map {
      $0.buildGenericParameter(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericParameterList = buildGenericParameterList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(genericParameterList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(genericParameterList)
  }
}

public struct GenericParameter: SyntaxBuildable {
  let attributes: AttributeList?
  let name: TokenSyntax
  let colon: TokenSyntax?
  let inheritedType: TypeBuildable?
  let trailingComma: TokenSyntax?

  public init(
    attributes: AttributeList?,
    name: TokenSyntax,
    colon: TokenSyntax?,
    inheritedType: TypeBuildable?,
    trailingComma: TokenSyntax?
  ) {
    self.attributes = attributes
    self.name = name
    self.colon = colon
    self.inheritedType = inheritedType
    self.trailingComma = trailingComma
  }
  
  func buildGenericParameter(format: Format, leadingTrivia: Trivia? = nil) -> GenericParameterSyntax {
    let genericParameter = SyntaxFactory.makeGenericParameter(
      attributes: attributes?.buildAttributeList(format: format),
      name: name,
      colon: colon,
      inheritedType: inheritedType?.buildType(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericParameter
        .withLeadingTrivia(leadingTrivia)
    }

    return genericParameter
  }

  /// Conformance for `GenericParameter` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericParameter = buildGenericParameter(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericParameter)
  }
}

public struct GenericParameterClause: SyntaxBuildable {
  let leftAngleBracket: TokenSyntax
  let genericParameterList: GenericParameterList
  let rightAngleBracket: TokenSyntax

  public init(
    leftAngleBracket: TokenSyntax,
    genericParameterList: GenericParameterList,
    rightAngleBracket: TokenSyntax
  ) {
    self.leftAngleBracket = leftAngleBracket
    self.genericParameterList = genericParameterList
    self.rightAngleBracket = rightAngleBracket
  }
  
  func buildGenericParameterClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericParameterClauseSyntax {
    let genericParameterClause = SyntaxFactory.makeGenericParameterClause(
      leftAngleBracket: leftAngleBracket,
      genericParameterList: genericParameterList.buildGenericParameterList(format: format),
      rightAngleBracket: rightAngleBracket
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericParameterClause
        .withLeadingTrivia(leadingTrivia)
    }

    return genericParameterClause
  }

  /// Conformance for `GenericParameterClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericParameterClause = buildGenericParameterClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericParameterClause)
  }
}

public struct ConformanceRequirement: SyntaxBuildable {
  let leftTypeIdentifier: TypeBuildable
  let colon: TokenSyntax
  let rightTypeIdentifier: TypeBuildable

  public init(
    leftTypeIdentifier: TypeBuildable,
    colon: TokenSyntax,
    rightTypeIdentifier: TypeBuildable
  ) {
    self.leftTypeIdentifier = leftTypeIdentifier
    self.colon = colon
    self.rightTypeIdentifier = rightTypeIdentifier
  }
  
  func buildConformanceRequirement(format: Format, leadingTrivia: Trivia? = nil) -> ConformanceRequirementSyntax {
    let conformanceRequirement = SyntaxFactory.makeConformanceRequirement(
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format),
      colon: colon,
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return conformanceRequirement
        .withLeadingTrivia(leadingTrivia)
    }

    return conformanceRequirement
  }

  /// Conformance for `ConformanceRequirement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let conformanceRequirement = buildConformanceRequirement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(conformanceRequirement)
  }
}

public struct SimpleTypeIdentifier: TypeBuildable {
  let name: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  public init(
    name: TokenSyntax,
    genericArgumentClause: GenericArgumentClause?
  ) {
    self.name = name
    self.genericArgumentClause = genericArgumentClause
  }
  
  func buildSimpleTypeIdentifier(format: Format, leadingTrivia: Trivia? = nil) -> SimpleTypeIdentifierSyntax {
    let simpleTypeIdentifier = SyntaxFactory.makeSimpleTypeIdentifier(
      name: name,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return simpleTypeIdentifier
        .withLeadingTrivia(leadingTrivia)
    }

    return simpleTypeIdentifier
  }

  /// Conformance for `SimpleTypeIdentifier` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let simpleTypeIdentifier = buildSimpleTypeIdentifier(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(simpleTypeIdentifier)
  }
}

public struct MemberTypeIdentifier: TypeBuildable {
  let baseType: TypeBuildable
  let period: TokenSyntax
  let name: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  public init(
    baseType: TypeBuildable,
    period: TokenSyntax,
    name: TokenSyntax,
    genericArgumentClause: GenericArgumentClause?
  ) {
    self.baseType = baseType
    self.period = period
    self.name = name
    self.genericArgumentClause = genericArgumentClause
  }
  
  func buildMemberTypeIdentifier(format: Format, leadingTrivia: Trivia? = nil) -> MemberTypeIdentifierSyntax {
    let memberTypeIdentifier = SyntaxFactory.makeMemberTypeIdentifier(
      baseType: baseType.buildType(format: format),
      period: period,
      name: name,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return memberTypeIdentifier
        .withLeadingTrivia(leadingTrivia)
    }

    return memberTypeIdentifier
  }

  /// Conformance for `MemberTypeIdentifier` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let memberTypeIdentifier = buildMemberTypeIdentifier(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(memberTypeIdentifier)
  }
}

public struct ClassRestrictionType: TypeBuildable {
  let classKeyword: TokenSyntax

  public init(
    classKeyword: TokenSyntax
  ) {
    self.classKeyword = classKeyword
  }
  
  func buildClassRestrictionType(format: Format, leadingTrivia: Trivia? = nil) -> ClassRestrictionTypeSyntax {
    let classRestrictionType = SyntaxFactory.makeClassRestrictionType(
      classKeyword: classKeyword
    )
    
    if let leadingTrivia = leadingTrivia {
      return classRestrictionType
        .withLeadingTrivia(leadingTrivia)
    }

    return classRestrictionType
  }

  /// Conformance for `ClassRestrictionType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let classRestrictionType = buildClassRestrictionType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(classRestrictionType)
  }
}

public struct ArrayType: TypeBuildable {
  let leftSquareBracket: TokenSyntax
  let elementType: TypeBuildable
  let rightSquareBracket: TokenSyntax

  public init(
    leftSquareBracket: TokenSyntax,
    elementType: TypeBuildable,
    rightSquareBracket: TokenSyntax
  ) {
    self.leftSquareBracket = leftSquareBracket
    self.elementType = elementType
    self.rightSquareBracket = rightSquareBracket
  }
  
  func buildArrayType(format: Format, leadingTrivia: Trivia? = nil) -> ArrayTypeSyntax {
    let arrayType = SyntaxFactory.makeArrayType(
      leftSquareBracket: leftSquareBracket,
      elementType: elementType.buildType(format: format),
      rightSquareBracket: rightSquareBracket
    )
    
    if let leadingTrivia = leadingTrivia {
      return arrayType
        .withLeadingTrivia(leadingTrivia)
    }

    return arrayType
  }

  /// Conformance for `ArrayType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let arrayType = buildArrayType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(arrayType)
  }
}

public struct DictionaryType: TypeBuildable {
  let leftSquareBracket: TokenSyntax
  let keyType: TypeBuildable
  let colon: TokenSyntax
  let valueType: TypeBuildable
  let rightSquareBracket: TokenSyntax

  public init(
    leftSquareBracket: TokenSyntax,
    keyType: TypeBuildable,
    colon: TokenSyntax,
    valueType: TypeBuildable,
    rightSquareBracket: TokenSyntax
  ) {
    self.leftSquareBracket = leftSquareBracket
    self.keyType = keyType
    self.colon = colon
    self.valueType = valueType
    self.rightSquareBracket = rightSquareBracket
  }
  
  func buildDictionaryType(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryTypeSyntax {
    let dictionaryType = SyntaxFactory.makeDictionaryType(
      leftSquareBracket: leftSquareBracket,
      keyType: keyType.buildType(format: format),
      colon: colon,
      valueType: valueType.buildType(format: format),
      rightSquareBracket: rightSquareBracket
    )
    
    if let leadingTrivia = leadingTrivia {
      return dictionaryType
        .withLeadingTrivia(leadingTrivia)
    }

    return dictionaryType
  }

  /// Conformance for `DictionaryType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let dictionaryType = buildDictionaryType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(dictionaryType)
  }
}

public struct MetatypeType: TypeBuildable {
  let baseType: TypeBuildable
  let period: TokenSyntax
  let typeOrProtocol: TokenSyntax

  public init(
    baseType: TypeBuildable,
    period: TokenSyntax,
    typeOrProtocol: TokenSyntax
  ) {
    self.baseType = baseType
    self.period = period
    self.typeOrProtocol = typeOrProtocol
  }
  
  func buildMetatypeType(format: Format, leadingTrivia: Trivia? = nil) -> MetatypeTypeSyntax {
    let metatypeType = SyntaxFactory.makeMetatypeType(
      baseType: baseType.buildType(format: format),
      period: period,
      typeOrProtocol: typeOrProtocol
    )
    
    if let leadingTrivia = leadingTrivia {
      return metatypeType
        .withLeadingTrivia(leadingTrivia)
    }

    return metatypeType
  }

  /// Conformance for `MetatypeType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let metatypeType = buildMetatypeType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(metatypeType)
  }
}

public struct OptionalType: TypeBuildable {
  let wrappedType: TypeBuildable
  let questionMark: TokenSyntax

  public init(
    wrappedType: TypeBuildable,
    questionMark: TokenSyntax
  ) {
    self.wrappedType = wrappedType
    self.questionMark = questionMark
  }
  
  func buildOptionalType(format: Format, leadingTrivia: Trivia? = nil) -> OptionalTypeSyntax {
    let optionalType = SyntaxFactory.makeOptionalType(
      wrappedType: wrappedType.buildType(format: format),
      questionMark: questionMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return optionalType
        .withLeadingTrivia(leadingTrivia)
    }

    return optionalType
  }

  /// Conformance for `OptionalType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let optionalType = buildOptionalType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(optionalType)
  }
}

public struct SomeType: TypeBuildable {
  let someSpecifier: TokenSyntax
  let baseType: TypeBuildable

  public init(
    someSpecifier: TokenSyntax,
    baseType: TypeBuildable
  ) {
    self.someSpecifier = someSpecifier
    self.baseType = baseType
  }
  
  func buildSomeType(format: Format, leadingTrivia: Trivia? = nil) -> SomeTypeSyntax {
    let someType = SyntaxFactory.makeSomeType(
      someSpecifier: someSpecifier,
      baseType: baseType.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return someType
        .withLeadingTrivia(leadingTrivia)
    }

    return someType
  }

  /// Conformance for `SomeType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let someType = buildSomeType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(someType)
  }
}

public struct ImplicitlyUnwrappedOptionalType: TypeBuildable {
  let wrappedType: TypeBuildable
  let exclamationMark: TokenSyntax

  public init(
    wrappedType: TypeBuildable,
    exclamationMark: TokenSyntax
  ) {
    self.wrappedType = wrappedType
    self.exclamationMark = exclamationMark
  }
  
  func buildImplicitlyUnwrappedOptionalType(format: Format, leadingTrivia: Trivia? = nil) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let implicitlyUnwrappedOptionalType = SyntaxFactory.makeImplicitlyUnwrappedOptionalType(
      wrappedType: wrappedType.buildType(format: format),
      exclamationMark: exclamationMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return implicitlyUnwrappedOptionalType
        .withLeadingTrivia(leadingTrivia)
    }

    return implicitlyUnwrappedOptionalType
  }

  /// Conformance for `ImplicitlyUnwrappedOptionalType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let implicitlyUnwrappedOptionalType = buildImplicitlyUnwrappedOptionalType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(implicitlyUnwrappedOptionalType)
  }
}

public struct CompositionTypeElement: SyntaxBuildable {
  let type: TypeBuildable
  let ampersand: TokenSyntax?

  public init(
    type: TypeBuildable,
    ampersand: TokenSyntax?
  ) {
    self.type = type
    self.ampersand = ampersand
  }
  
  func buildCompositionTypeElement(format: Format, leadingTrivia: Trivia? = nil) -> CompositionTypeElementSyntax {
    let compositionTypeElement = SyntaxFactory.makeCompositionTypeElement(
      type: type.buildType(format: format),
      ampersand: ampersand
    )
    
    if let leadingTrivia = leadingTrivia {
      return compositionTypeElement
        .withLeadingTrivia(leadingTrivia)
    }

    return compositionTypeElement
  }

  /// Conformance for `CompositionTypeElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let compositionTypeElement = buildCompositionTypeElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(compositionTypeElement)
  }
}

// MARK: - Syntax collection
public struct CompositionTypeElementList: SyntaxBuildable {
  let elements: [CompositionTypeElement]

  public init(_ elements: [CompositionTypeElement]) {
    self.elements = elements
  }

  public func buildCompositionTypeElementList(format: Format, leadingTrivia: Trivia? = nil) -> CompositionTypeElementListSyntax {
    return SyntaxFactory.makeCompositionTypeElementList(elements.map {
      $0.buildCompositionTypeElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let compositionTypeElementList = buildCompositionTypeElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(compositionTypeElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(compositionTypeElementList)
  }
}

public struct CompositionType: TypeBuildable {
  let elements: CompositionTypeElementList

  public init(
    elements: CompositionTypeElementList
  ) {
    self.elements = elements
  }
  
  func buildCompositionType(format: Format, leadingTrivia: Trivia? = nil) -> CompositionTypeSyntax {
    let compositionType = SyntaxFactory.makeCompositionType(
      elements: elements.buildCompositionTypeElementList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return compositionType
        .withLeadingTrivia(leadingTrivia)
    }

    return compositionType
  }

  /// Conformance for `CompositionType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let compositionType = buildCompositionType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(compositionType)
  }
}

public struct TupleTypeElement: SyntaxBuildable {
  let inOut: TokenSyntax?
  let name: TokenSyntax?
  let secondName: TokenSyntax?
  let colon: TokenSyntax?
  let type: TypeBuildable
  let ellipsis: TokenSyntax?
  let initializer: InitializerClause?
  let trailingComma: TokenSyntax?

  public init(
    inOut: TokenSyntax?,
    name: TokenSyntax?,
    secondName: TokenSyntax?,
    colon: TokenSyntax?,
    type: TypeBuildable,
    ellipsis: TokenSyntax?,
    initializer: InitializerClause?,
    trailingComma: TokenSyntax?
  ) {
    self.inOut = inOut
    self.name = name
    self.secondName = secondName
    self.colon = colon
    self.type = type
    self.ellipsis = ellipsis
    self.initializer = initializer
    self.trailingComma = trailingComma
  }
  
  func buildTupleTypeElement(format: Format, leadingTrivia: Trivia? = nil) -> TupleTypeElementSyntax {
    let tupleTypeElement = SyntaxFactory.makeTupleTypeElement(
      inOut: inOut,
      name: name,
      secondName: secondName,
      colon: colon,
      type: type.buildType(format: format),
      ellipsis: ellipsis,
      initializer: initializer?.buildInitializerClause(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return tupleTypeElement
        .withLeadingTrivia(leadingTrivia)
    }

    return tupleTypeElement
  }

  /// Conformance for `TupleTypeElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tupleTypeElement = buildTupleTypeElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(tupleTypeElement)
  }
}

// MARK: - Syntax collection
public struct TupleTypeElementList: SyntaxBuildable {
  let elements: [TupleTypeElement]

  public init(_ elements: [TupleTypeElement]) {
    self.elements = elements
  }

  public func buildTupleTypeElementList(format: Format, leadingTrivia: Trivia? = nil) -> TupleTypeElementListSyntax {
    return SyntaxFactory.makeTupleTypeElementList(elements.map {
      $0.buildTupleTypeElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tupleTypeElementList = buildTupleTypeElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(tupleTypeElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(tupleTypeElementList)
  }
}

public struct TupleType: TypeBuildable {
  let leftParen: TokenSyntax
  let elements: TupleTypeElementList
  let rightParen: TokenSyntax

  public init(
    leftParen: TokenSyntax,
    elements: TupleTypeElementList,
    rightParen: TokenSyntax
  ) {
    self.leftParen = leftParen
    self.elements = elements
    self.rightParen = rightParen
  }
  
  func buildTupleType(format: Format, leadingTrivia: Trivia? = nil) -> TupleTypeSyntax {
    let tupleType = SyntaxFactory.makeTupleType(
      leftParen: leftParen,
      elements: elements.buildTupleTypeElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return tupleType
        .withLeadingTrivia(leadingTrivia)
    }

    return tupleType
  }

  /// Conformance for `TupleType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let tupleType = buildTupleType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(tupleType)
  }
}

public struct FunctionType: TypeBuildable {
  let leftParen: TokenSyntax
  let arguments: TupleTypeElementList
  let rightParen: TokenSyntax
  let asyncKeyword: TokenSyntax?
  let throwsOrRethrowsKeyword: TokenSyntax?
  let arrow: TokenSyntax
  let returnType: TypeBuildable

  public init(
    leftParen: TokenSyntax,
    arguments: TupleTypeElementList,
    rightParen: TokenSyntax,
    asyncKeyword: TokenSyntax?,
    throwsOrRethrowsKeyword: TokenSyntax?,
    arrow: TokenSyntax,
    returnType: TypeBuildable
  ) {
    self.leftParen = leftParen
    self.arguments = arguments
    self.rightParen = rightParen
    self.asyncKeyword = asyncKeyword
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    self.arrow = arrow
    self.returnType = returnType
  }
  
  func buildFunctionType(format: Format, leadingTrivia: Trivia? = nil) -> FunctionTypeSyntax {
    let functionType = SyntaxFactory.makeFunctionType(
      leftParen: leftParen,
      arguments: arguments.buildTupleTypeElementList(format: format),
      rightParen: rightParen,
      asyncKeyword: asyncKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      arrow: arrow,
      returnType: returnType.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return functionType
        .withLeadingTrivia(leadingTrivia)
    }

    return functionType
  }

  /// Conformance for `FunctionType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let functionType = buildFunctionType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(functionType)
  }
}

public struct AttributedType: TypeBuildable {
  let specifier: TokenSyntax?
  let attributes: AttributeList?
  let baseType: TypeBuildable

  public init(
    specifier: TokenSyntax?,
    attributes: AttributeList?,
    baseType: TypeBuildable
  ) {
    self.specifier = specifier
    self.attributes = attributes
    self.baseType = baseType
  }
  
  func buildAttributedType(format: Format, leadingTrivia: Trivia? = nil) -> AttributedTypeSyntax {
    let attributedType = SyntaxFactory.makeAttributedType(
      specifier: specifier,
      attributes: attributes?.buildAttributeList(format: format),
      baseType: baseType.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return attributedType
        .withLeadingTrivia(leadingTrivia)
    }

    return attributedType
  }

  /// Conformance for `AttributedType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let attributedType = buildAttributedType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(attributedType)
  }
}

// MARK: - Syntax collection
public struct GenericArgumentList: SyntaxBuildable {
  let elements: [GenericArgument]

  public init(_ elements: [GenericArgument]) {
    self.elements = elements
  }

  public func buildGenericArgumentList(format: Format, leadingTrivia: Trivia? = nil) -> GenericArgumentListSyntax {
    return SyntaxFactory.makeGenericArgumentList(elements.map {
      $0.buildGenericArgument(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericArgumentList = buildGenericArgumentList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(genericArgumentList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(genericArgumentList)
  }
}

public struct GenericArgument: SyntaxBuildable {
  let argumentType: TypeBuildable
  let trailingComma: TokenSyntax?

  public init(
    argumentType: TypeBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.argumentType = argumentType
    self.trailingComma = trailingComma
  }
  
  func buildGenericArgument(format: Format, leadingTrivia: Trivia? = nil) -> GenericArgumentSyntax {
    let genericArgument = SyntaxFactory.makeGenericArgument(
      argumentType: argumentType.buildType(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericArgument
        .withLeadingTrivia(leadingTrivia)
    }

    return genericArgument
  }

  /// Conformance for `GenericArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericArgument = buildGenericArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericArgument)
  }
}

public struct GenericArgumentClause: SyntaxBuildable {
  let leftAngleBracket: TokenSyntax
  let arguments: GenericArgumentList
  let rightAngleBracket: TokenSyntax

  public init(
    leftAngleBracket: TokenSyntax,
    arguments: GenericArgumentList,
    rightAngleBracket: TokenSyntax
  ) {
    self.leftAngleBracket = leftAngleBracket
    self.arguments = arguments
    self.rightAngleBracket = rightAngleBracket
  }
  
  func buildGenericArgumentClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericArgumentClauseSyntax {
    let genericArgumentClause = SyntaxFactory.makeGenericArgumentClause(
      leftAngleBracket: leftAngleBracket,
      arguments: arguments.buildGenericArgumentList(format: format),
      rightAngleBracket: rightAngleBracket
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericArgumentClause
        .withLeadingTrivia(leadingTrivia)
    }

    return genericArgumentClause
  }

  /// Conformance for `GenericArgumentClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericArgumentClause = buildGenericArgumentClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericArgumentClause)
  }
}

public struct TypeAnnotation: SyntaxBuildable {
  let colon: TokenSyntax
  let type: TypeBuildable

  public init(
    colon: TokenSyntax,
    type: TypeBuildable
  ) {
    self.colon = colon
    self.type = type
  }
  
  func buildTypeAnnotation(format: Format, leadingTrivia: Trivia? = nil) -> TypeAnnotationSyntax {
    let typeAnnotation = SyntaxFactory.makeTypeAnnotation(
      colon: colon,
      type: type.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typeAnnotation
        .withLeadingTrivia(leadingTrivia)
    }

    return typeAnnotation
  }

  /// Conformance for `TypeAnnotation` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let typeAnnotation = buildTypeAnnotation(format: format, leadingTrivia: leadingTrivia)
    return Syntax(typeAnnotation)
  }
}

public struct EnumCasePattern: PatternBuildable {
  let type: TypeBuildable?
  let period: TokenSyntax
  let caseName: TokenSyntax
  let associatedTuple: TuplePattern?

  public init(
    type: TypeBuildable?,
    period: TokenSyntax,
    caseName: TokenSyntax,
    associatedTuple: TuplePattern?
  ) {
    self.type = type
    self.period = period
    self.caseName = caseName
    self.associatedTuple = associatedTuple
  }
  
  func buildEnumCasePattern(format: Format, leadingTrivia: Trivia? = nil) -> EnumCasePatternSyntax {
    let enumCasePattern = SyntaxFactory.makeEnumCasePattern(
      type: type?.buildType(format: format),
      period: period,
      caseName: caseName,
      associatedTuple: associatedTuple?.buildTuplePattern(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return enumCasePattern
        .withLeadingTrivia(leadingTrivia)
    }

    return enumCasePattern
  }

  /// Conformance for `EnumCasePattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let enumCasePattern = buildEnumCasePattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(enumCasePattern)
  }
}

public struct IsTypePattern: PatternBuildable {
  let isKeyword: TokenSyntax
  let type: TypeBuildable

  public init(
    isKeyword: TokenSyntax,
    type: TypeBuildable
  ) {
    self.isKeyword = isKeyword
    self.type = type
  }
  
  func buildIsTypePattern(format: Format, leadingTrivia: Trivia? = nil) -> IsTypePatternSyntax {
    let isTypePattern = SyntaxFactory.makeIsTypePattern(
      isKeyword: isKeyword,
      type: type.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return isTypePattern
        .withLeadingTrivia(leadingTrivia)
    }

    return isTypePattern
  }

  /// Conformance for `IsTypePattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let isTypePattern = buildIsTypePattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(isTypePattern)
  }
}

public struct OptionalPattern: PatternBuildable {
  let subPattern: PatternBuildable
  let questionMark: TokenSyntax

  public init(
    subPattern: PatternBuildable,
    questionMark: TokenSyntax
  ) {
    self.subPattern = subPattern
    self.questionMark = questionMark
  }
  
  func buildOptionalPattern(format: Format, leadingTrivia: Trivia? = nil) -> OptionalPatternSyntax {
    let optionalPattern = SyntaxFactory.makeOptionalPattern(
      subPattern: subPattern.buildPattern(format: format),
      questionMark: questionMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return optionalPattern
        .withLeadingTrivia(leadingTrivia)
    }

    return optionalPattern
  }

  /// Conformance for `OptionalPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let optionalPattern = buildOptionalPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(optionalPattern)
  }
}

public struct IdentifierPattern: PatternBuildable {
  let identifier: TokenSyntax

  public init(
    identifier: TokenSyntax
  ) {
    self.identifier = identifier
  }
  
  func buildIdentifierPattern(format: Format, leadingTrivia: Trivia? = nil) -> IdentifierPatternSyntax {
    let identifierPattern = SyntaxFactory.makeIdentifierPattern(
      identifier: identifier
    )
    
    if let leadingTrivia = leadingTrivia {
      return identifierPattern
        .withLeadingTrivia(leadingTrivia)
    }

    return identifierPattern
  }

  /// Conformance for `IdentifierPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let identifierPattern = buildIdentifierPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(identifierPattern)
  }
}

public struct AsTypePattern: PatternBuildable {
  let pattern: PatternBuildable
  let asKeyword: TokenSyntax
  let type: TypeBuildable

  public init(
    pattern: PatternBuildable,
    asKeyword: TokenSyntax,
    type: TypeBuildable
  ) {
    self.pattern = pattern
    self.asKeyword = asKeyword
    self.type = type
  }
  
  func buildAsTypePattern(format: Format, leadingTrivia: Trivia? = nil) -> AsTypePatternSyntax {
    let asTypePattern = SyntaxFactory.makeAsTypePattern(
      pattern: pattern.buildPattern(format: format),
      asKeyword: asKeyword,
      type: type.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return asTypePattern
        .withLeadingTrivia(leadingTrivia)
    }

    return asTypePattern
  }

  /// Conformance for `AsTypePattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let asTypePattern = buildAsTypePattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(asTypePattern)
  }
}

public struct TuplePattern: PatternBuildable {
  let leftParen: TokenSyntax
  let elements: TuplePatternElementList
  let rightParen: TokenSyntax

  public init(
    leftParen: TokenSyntax,
    elements: TuplePatternElementList,
    rightParen: TokenSyntax
  ) {
    self.leftParen = leftParen
    self.elements = elements
    self.rightParen = rightParen
  }
  
  func buildTuplePattern(format: Format, leadingTrivia: Trivia? = nil) -> TuplePatternSyntax {
    let tuplePattern = SyntaxFactory.makeTuplePattern(
      leftParen: leftParen,
      elements: elements.buildTuplePatternElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return tuplePattern
        .withLeadingTrivia(leadingTrivia)
    }

    return tuplePattern
  }

  /// Conformance for `TuplePattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let tuplePattern = buildTuplePattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(tuplePattern)
  }
}

public struct WildcardPattern: PatternBuildable {
  let wildcard: TokenSyntax
  let typeAnnotation: TypeAnnotation?

  public init(
    wildcard: TokenSyntax,
    typeAnnotation: TypeAnnotation?
  ) {
    self.wildcard = wildcard
    self.typeAnnotation = typeAnnotation
  }
  
  func buildWildcardPattern(format: Format, leadingTrivia: Trivia? = nil) -> WildcardPatternSyntax {
    let wildcardPattern = SyntaxFactory.makeWildcardPattern(
      wildcard: wildcard,
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return wildcardPattern
        .withLeadingTrivia(leadingTrivia)
    }

    return wildcardPattern
  }

  /// Conformance for `WildcardPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let wildcardPattern = buildWildcardPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(wildcardPattern)
  }
}

public struct TuplePatternElement: SyntaxBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let pattern: PatternBuildable
  let trailingComma: TokenSyntax?

  public init(
    labelName: TokenSyntax?,
    labelColon: TokenSyntax?,
    pattern: PatternBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    self.pattern = pattern
    self.trailingComma = trailingComma
  }
  
  func buildTuplePatternElement(format: Format, leadingTrivia: Trivia? = nil) -> TuplePatternElementSyntax {
    let tuplePatternElement = SyntaxFactory.makeTuplePatternElement(
      labelName: labelName,
      labelColon: labelColon,
      pattern: pattern.buildPattern(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return tuplePatternElement
        .withLeadingTrivia(leadingTrivia)
    }

    return tuplePatternElement
  }

  /// Conformance for `TuplePatternElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tuplePatternElement = buildTuplePatternElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(tuplePatternElement)
  }
}

public struct ExpressionPattern: PatternBuildable {
  let expression: ExprBuildable

  public init(
    expression: ExprBuildable
  ) {
    self.expression = expression
  }
  
  func buildExpressionPattern(format: Format, leadingTrivia: Trivia? = nil) -> ExpressionPatternSyntax {
    let expressionPattern = SyntaxFactory.makeExpressionPattern(
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return expressionPattern
        .withLeadingTrivia(leadingTrivia)
    }

    return expressionPattern
  }

  /// Conformance for `ExpressionPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let expressionPattern = buildExpressionPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(expressionPattern)
  }
}

// MARK: - Syntax collection
public struct TuplePatternElementList: SyntaxBuildable {
  let elements: [TuplePatternElement]

  public init(_ elements: [TuplePatternElement]) {
    self.elements = elements
  }

  public func buildTuplePatternElementList(format: Format, leadingTrivia: Trivia? = nil) -> TuplePatternElementListSyntax {
    return SyntaxFactory.makeTuplePatternElementList(elements.map {
      $0.buildTuplePatternElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tuplePatternElementList = buildTuplePatternElementList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(tuplePatternElementList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(tuplePatternElementList)
  }
}

public struct ValueBindingPattern: PatternBuildable {
  let letOrVarKeyword: TokenSyntax
  let valuePattern: PatternBuildable

  public init(
    letOrVarKeyword: TokenSyntax,
    valuePattern: PatternBuildable
  ) {
    self.letOrVarKeyword = letOrVarKeyword
    self.valuePattern = valuePattern
  }
  
  func buildValueBindingPattern(format: Format, leadingTrivia: Trivia? = nil) -> ValueBindingPatternSyntax {
    let valueBindingPattern = SyntaxFactory.makeValueBindingPattern(
      letOrVarKeyword: letOrVarKeyword,
      valuePattern: valuePattern.buildPattern(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return valueBindingPattern
        .withLeadingTrivia(leadingTrivia)
    }

    return valueBindingPattern
  }

  /// Conformance for `ValueBindingPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let valueBindingPattern = buildValueBindingPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(valueBindingPattern)
  }
}

// MARK: - Syntax collection
public struct AvailabilitySpecList: SyntaxBuildable {
  let elements: [AvailabilityArgument]

  public init(_ elements: [AvailabilityArgument]) {
    self.elements = elements
  }

  public func buildAvailabilitySpecList(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilitySpecListSyntax {
    return SyntaxFactory.makeAvailabilitySpecList(elements.map {
      $0.buildAvailabilityArgument(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilitySpecList = buildAvailabilitySpecList(format: format, leadingTrivia: leadingTrivia)

    if let leadingTrivia = leadingTrivia {
      return Syntax(availabilitySpecList).withLeadingTrivia(leadingTrivia)
    }

    return Syntax(availabilitySpecList)
  }
}

public struct AvailabilityArgument: SyntaxBuildable {
  let entry: SyntaxBuildable
  let trailingComma: TokenSyntax?

  public init(
    entry: SyntaxBuildable,
    trailingComma: TokenSyntax?
  ) {
    self.entry = entry
    self.trailingComma = trailingComma
  }
  
  func buildAvailabilityArgument(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityArgumentSyntax {
    let availabilityArgument = SyntaxFactory.makeAvailabilityArgument(
      entry: entry.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityArgument
        .withLeadingTrivia(leadingTrivia)
    }

    return availabilityArgument
  }

  /// Conformance for `AvailabilityArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityArgument = buildAvailabilityArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityArgument)
  }
}

public struct AvailabilityLabeledArgument: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let value: SyntaxBuildable

  public init(
    label: TokenSyntax,
    colon: TokenSyntax,
    value: SyntaxBuildable
  ) {
    self.label = label
    self.colon = colon
    self.value = value
  }
  
  func buildAvailabilityLabeledArgument(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityLabeledArgumentSyntax {
    let availabilityLabeledArgument = SyntaxFactory.makeAvailabilityLabeledArgument(
      label: label,
      colon: colon,
      value: value.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityLabeledArgument
        .withLeadingTrivia(leadingTrivia)
    }

    return availabilityLabeledArgument
  }

  /// Conformance for `AvailabilityLabeledArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityLabeledArgument = buildAvailabilityLabeledArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityLabeledArgument)
  }
}

public struct AvailabilityVersionRestriction: SyntaxBuildable {
  let platform: TokenSyntax
  let version: VersionTuple?

  public init(
    platform: TokenSyntax,
    version: VersionTuple?
  ) {
    self.platform = platform
    self.version = version
  }
  
  func buildAvailabilityVersionRestriction(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityVersionRestrictionSyntax {
    let availabilityVersionRestriction = SyntaxFactory.makeAvailabilityVersionRestriction(
      platform: platform,
      version: version?.buildVersionTuple(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityVersionRestriction
        .withLeadingTrivia(leadingTrivia)
    }

    return availabilityVersionRestriction
  }

  /// Conformance for `AvailabilityVersionRestriction` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityVersionRestriction = buildAvailabilityVersionRestriction(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityVersionRestriction)
  }
}

public struct VersionTuple: SyntaxBuildable {
  let majorMinor: SyntaxBuildable
  let patchPeriod: TokenSyntax?
  let patchVersion: TokenSyntax?

  public init(
    majorMinor: SyntaxBuildable,
    patchPeriod: TokenSyntax?,
    patchVersion: TokenSyntax?
  ) {
    self.majorMinor = majorMinor
    self.patchPeriod = patchPeriod
    self.patchVersion = patchVersion
  }
  
  func buildVersionTuple(format: Format, leadingTrivia: Trivia? = nil) -> VersionTupleSyntax {
    let versionTuple = SyntaxFactory.makeVersionTuple(
      majorMinor: majorMinor.buildSyntax(format: format),
      patchPeriod: patchPeriod,
      patchVersion: patchVersion
    )
    
    if let leadingTrivia = leadingTrivia {
      return versionTuple
        .withLeadingTrivia(leadingTrivia)
    }

    return versionTuple
  }

  /// Conformance for `VersionTuple` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let versionTuple = buildVersionTuple(format: format, leadingTrivia: leadingTrivia)
    return Syntax(versionTuple)
  }
}

