//// Automatically Generated From DeclBuildables.swift.gyb.
//// Do Not Edit Directly!
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
  /// Builds list of `DeclSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `DeclSyntax`.
  func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]
}

public protocol ExpressibleByDeclBuildable: ExpressibleByCodeBlockItem, ExpressibleByMemberDeclListItem, ExpressibleBySyntaxBuildable {
  func createDeclBuildable() -> DeclBuildable
}

public protocol DeclBuildable: ExpressibleByDeclBuildable, SyntaxBuildable, DeclListBuildable {
  /// Builds a `DeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `DeclSyntax`.
  func buildDecl(format: Format, leadingTrivia: Trivia?) -> DeclSyntax
}

extension DeclBuildable {
  public func createDeclBuildable() -> DeclBuildable {
    self
  }
}

extension DeclBuildable {
  /// Builds a `DeclSyntax`.
  /// - Returns: A `DeclSyntax`.
  func buildDecl(format: Format) -> DeclSyntax {
    buildDecl(format: format, leadingTrivia: nil)
  }

  /// Builds a `DeclSyntax`.
  /// - Returns: A `DeclSyntax`.
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  /// Builds a `DeclSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A new `Syntax` with the builded `DeclSyntax`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildDecl(format: format, leadingTrivia: leadingTrivia))
  }

  /// Builds list of `DeclSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `DeclSyntax`.
  public func buildDeclList(format: Format, leadingTrivia: Trivia? = nil) -> [DeclSyntax] {
    [buildDecl(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol ExprListBuildable: SyntaxListBuildable {
  /// Builds list of `ExprSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `ExprSyntax`.
  func buildExprList(format: Format, leadingTrivia: Trivia?) -> [ExprSyntax]
}

public protocol ExpressibleByExprBuildable {
  func createExprBuildable() -> ExprBuildable
}

public protocol ExprBuildable: ExpressibleByExprBuildable, SyntaxBuildable, ExprListBuildable {
  /// Builds a `ExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `ExprSyntax`.
  func buildExpr(format: Format, leadingTrivia: Trivia?) -> ExprSyntax
}

extension ExprBuildable {
  public func createExprBuildable() -> ExprBuildable {
    self
  }
}

extension ExprBuildable {
  /// Builds a `ExprSyntax`.
  /// - Returns: A `ExprSyntax`.
  func buildExpr(format: Format) -> ExprSyntax {
    buildExpr(format: format, leadingTrivia: nil)
  }

  /// Builds a `ExprSyntax`.
  /// - Returns: A `ExprSyntax`.
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  /// Builds a `ExprSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A new `Syntax` with the builded `ExprSyntax`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildExpr(format: format, leadingTrivia: leadingTrivia))
  }

  /// Builds list of `ExprSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `ExprSyntax`.
  public func buildExprList(format: Format, leadingTrivia: Trivia? = nil) -> [ExprSyntax] {
    [buildExpr(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol PatternListBuildable: SyntaxListBuildable {
  /// Builds list of `PatternSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `PatternSyntax`.
  func buildPatternList(format: Format, leadingTrivia: Trivia?) -> [PatternSyntax]
}

public protocol ExpressibleByPatternBuildable {
  func createPatternBuildable() -> PatternBuildable
}

public protocol PatternBuildable: ExpressibleByPatternBuildable, SyntaxBuildable, PatternListBuildable {
  /// Builds a `PatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `PatternSyntax`.
  func buildPattern(format: Format, leadingTrivia: Trivia?) -> PatternSyntax
}

extension PatternBuildable {
  public func createPatternBuildable() -> PatternBuildable {
    self
  }
}

extension PatternBuildable {
  /// Builds a `PatternSyntax`.
  /// - Returns: A `PatternSyntax`.
  func buildPattern(format: Format) -> PatternSyntax {
    buildPattern(format: format, leadingTrivia: nil)
  }

  /// Builds a `PatternSyntax`.
  /// - Returns: A `PatternSyntax`.
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  /// Builds a `PatternSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A new `Syntax` with the builded `PatternSyntax`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildPattern(format: format, leadingTrivia: leadingTrivia))
  }

  /// Builds list of `PatternSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `PatternSyntax`.
  public func buildPatternList(format: Format, leadingTrivia: Trivia? = nil) -> [PatternSyntax] {
    [buildPattern(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol StmtListBuildable: SyntaxListBuildable {
  /// Builds list of `StmtSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `StmtSyntax`.
  func buildStmtList(format: Format, leadingTrivia: Trivia?) -> [StmtSyntax]
}

public protocol ExpressibleByStmtBuildable: ExpressibleByCodeBlockItem, ExpressibleBySyntaxBuildable {
  func createStmtBuildable() -> StmtBuildable
}

public protocol StmtBuildable: ExpressibleByStmtBuildable, SyntaxBuildable, StmtListBuildable {
  /// Builds a `StmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `StmtSyntax`.
  func buildStmt(format: Format, leadingTrivia: Trivia?) -> StmtSyntax
}

extension StmtBuildable {
  public func createStmtBuildable() -> StmtBuildable {
    self
  }
}

extension StmtBuildable {
  /// Builds a `StmtSyntax`.
  /// - Returns: A `StmtSyntax`.
  func buildStmt(format: Format) -> StmtSyntax {
    buildStmt(format: format, leadingTrivia: nil)
  }

  /// Builds a `StmtSyntax`.
  /// - Returns: A `StmtSyntax`.
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  /// Builds a `StmtSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A new `Syntax` with the builded `StmtSyntax`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildStmt(format: format, leadingTrivia: leadingTrivia))
  }

  /// Builds list of `StmtSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `StmtSyntax`.
  public func buildStmtList(format: Format, leadingTrivia: Trivia? = nil) -> [StmtSyntax] {
    [buildStmt(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol SyntaxListBuildable {
  /// Builds list of `Syntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `Syntax`.
  func buildSyntaxList(format: Format, leadingTrivia: Trivia?) -> [Syntax]
}

public protocol ExpressibleBySyntaxBuildable {
  func createSyntaxBuildable() -> SyntaxBuildable
}

public protocol SyntaxBuildable: ExpressibleBySyntaxBuildable, SyntaxListBuildable {
  /// Builds a `Syntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `Syntax`.
  func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax
}

extension SyntaxBuildable {
  public func createSyntaxBuildable() -> SyntaxBuildable {
    self
  }
}

extension SyntaxBuildable {
  /// Builds a `Syntax`.
  /// - Returns: A `Syntax`.
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  /// Builds a `Syntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A new `Syntax` with the builded `Syntax`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildSyntax(format: format, leadingTrivia: leadingTrivia))
  }

  /// Builds list of `Syntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `Syntax`.
  public func buildSyntaxList(format: Format, leadingTrivia: Trivia? = nil) -> [Syntax] {
    [buildSyntax(format: format, leadingTrivia: leadingTrivia)]
  }
}

public protocol TypeListBuildable: SyntaxListBuildable {
  /// Builds list of `TypeSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `TypeSyntax`.
  func buildTypeList(format: Format, leadingTrivia: Trivia?) -> [TypeSyntax]
}

public protocol ExpressibleByTypeBuildable {
  func createTypeBuildable() -> TypeBuildable
}

public protocol TypeBuildable: ExpressibleByTypeBuildable, SyntaxBuildable, TypeListBuildable {
  /// Builds a `TypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `TypeSyntax`.
  func buildType(format: Format, leadingTrivia: Trivia?) -> TypeSyntax
}

extension TypeBuildable {
  public func createTypeBuildable() -> TypeBuildable {
    self
  }
}

extension TypeBuildable {
  /// Builds a `TypeSyntax`.
  /// - Returns: A `TypeSyntax`.
  func buildType(format: Format) -> TypeSyntax {
    buildType(format: format, leadingTrivia: nil)
  }

  /// Builds a `TypeSyntax`.
  /// - Returns: A `TypeSyntax`.
  public func buildSyntax(format: Format) -> Syntax {
    buildSyntax(format: format, leadingTrivia: nil)
  }

  /// Builds a `TypeSyntax`.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A new `Syntax` with the builded `TypeSyntax`.
  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    Syntax(buildType(format: format, leadingTrivia: leadingTrivia))
  }

  /// Builds list of `TypeSyntax`s.
  /// - Parameter format: The `Format` to use.
  /// - Parameter leadingTrivia: Replaces the the last leading trivia if not nil.
  /// - Returns: A list of `TypeSyntax`.
  public func buildTypeList(format: Format, leadingTrivia: Trivia? = nil) -> [TypeSyntax] {
    [buildType(format: format, leadingTrivia: leadingTrivia)]
  }
}

// MARK: - Buildables

/// 
/// A CodeBlockItem is any Syntax node that appears on its own line inside
/// a CodeBlock.
/// 
public struct CodeBlockItem: SyntaxBuildable {
  let item: SyntaxBuildable
  let semicolon: TokenSyntax?
  let errorTokens: SyntaxBuildable?

  public init(
    item: ExpressibleBySyntaxBuildable,
    semicolon: ExpressibleByTokenSyntax? = nil,
    errorTokens: ExpressibleBySyntaxBuildable? = nil
  ) {
    self.item = item.createSyntaxBuildable()
    self.semicolon = semicolon?.createTokenSyntax()
    self.errorTokens = errorTokens?.createSyntaxBuildable()
  }
  
  func buildCodeBlockItem(format: Format, leadingTrivia: Trivia? = nil) -> CodeBlockItemSyntax {
    let codeBlockItem = SyntaxFactory.makeCodeBlockItem(
      item: item.buildSyntax(format: format),
      semicolon: semicolon,
      errorTokens: errorTokens?.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return codeBlockItem.withLeadingTrivia(leadingTrivia + (codeBlockItem.leadingTrivia ?? []))
    }

    return codeBlockItem
  }

  /// Conformance for `CodeBlockItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let codeBlockItem = buildCodeBlockItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(codeBlockItem)
  }
}

public protocol ExpressibleByCodeBlockItem {
  func createCodeBlockItem() -> CodeBlockItem
}

extension CodeBlockItem: ExpressibleByCodeBlockItem {
  public func createCodeBlockItem() -> CodeBlockItem {
    self
  }
}

// MARK: - Syntax collection

/// `CodeBlockItemList` represents a collection of 
/// `CodeBlockItem`s.
public struct CodeBlockItemList: SyntaxBuildable {
  let elements: [CodeBlockItem]

  public init(_ elements: [ExpressibleByCodeBlockItem]) {
    self.elements = elements.map { $0.createCodeBlockItem() }
  }

  public func buildCodeBlockItemList(format: Format) -> CodeBlockItemListSyntax {
    return SyntaxFactory.makeCodeBlockItemList(elements.map {
      $0.buildCodeBlockItem(format: format, leadingTrivia: .newlines(1) + format._makeIndent())
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let codeBlockItemList = buildCodeBlockItemList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(codeBlockItemList).withLeadingTrivia(leadingTrivia + (codeBlockItemList.leadingTrivia ?? []))
    }

    return Syntax(codeBlockItemList)
  }
}

public protocol ExpressibleByCodeBlockItemList {
  func createCodeBlockItemList() -> CodeBlockItemList
}

extension CodeBlockItemList: ExpressibleByCodeBlockItemList {
  public func createCodeBlockItemList() -> CodeBlockItemList {
    self
  }
}

public struct CodeBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let statements: CodeBlockItemList
  let rightBrace: TokenSyntax

  public init(
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    statements: ExpressibleByCodeBlockItemList,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace.createTokenSyntax()
    self.statements = statements.createCodeBlockItemList()
    self.rightBrace = rightBrace.createTokenSyntax()
  }
  
  func buildCodeBlock(format: Format, leadingTrivia: Trivia? = nil) -> CodeBlockSyntax {
    let codeBlock = SyntaxFactory.makeCodeBlock(
      leftBrace: leftBrace,
      statements: statements.buildCodeBlockItemList(format: format._indented()),
      rightBrace: rightBrace.withLeadingTrivia(.newlines(1) + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    
    if let leadingTrivia = leadingTrivia {
      return codeBlock.withLeadingTrivia(leadingTrivia + (codeBlock.leadingTrivia ?? []))
    }

    return codeBlock
  }

  /// Conformance for `CodeBlock` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let codeBlock = buildCodeBlock(format: format, leadingTrivia: leadingTrivia)
    return Syntax(codeBlock)
  }
}

public protocol ExpressibleByCodeBlock {
  func createCodeBlock() -> CodeBlock
}

extension CodeBlock: ExpressibleByCodeBlock {
  public func createCodeBlock() -> CodeBlock {
    self
  }
}

public struct InOutExpr: ExprBuildable {
  let ampersand: TokenSyntax
  let expression: ExprBuildable

  public init(
    ampersand: ExpressibleByTokenSyntax = TokenSyntax.`prefixAmpersand`,
    expression: ExpressibleByExprBuildable
  ) {
    self.ampersand = ampersand.createTokenSyntax()
    self.expression = expression.createExprBuildable()
  }
  
  func buildInOutExpr(format: Format, leadingTrivia: Trivia? = nil) -> InOutExprSyntax {
    let inOutExpr = SyntaxFactory.makeInOutExpr(
      ampersand: ampersand,
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return inOutExpr.withLeadingTrivia(leadingTrivia + (inOutExpr.leadingTrivia ?? []))
    }

    return inOutExpr
  }

  /// Conformance for `InOutExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let inOutExpr = buildInOutExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(inOutExpr)
  }
}

public protocol ExpressibleByInOutExpr {
  func createInOutExpr() -> InOutExpr
}

extension InOutExpr: ExpressibleByInOutExpr {
  public func createInOutExpr() -> InOutExpr {
    self
  }
}

public struct PoundColumnExpr: ExprBuildable {
  let poundColumn: TokenSyntax

  public init(
    poundColumn: ExpressibleByTokenSyntax = TokenSyntax.`poundColumn`
  ) {
    self.poundColumn = poundColumn.createTokenSyntax()
  }
  
  func buildPoundColumnExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundColumnExprSyntax {
    let poundColumnExpr = SyntaxFactory.makePoundColumnExpr(
      poundColumn: poundColumn
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundColumnExpr.withLeadingTrivia(leadingTrivia + (poundColumnExpr.leadingTrivia ?? []))
    }

    return poundColumnExpr
  }

  /// Conformance for `PoundColumnExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundColumnExpr = buildPoundColumnExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundColumnExpr)
  }
}

public protocol ExpressibleByPoundColumnExpr {
  func createPoundColumnExpr() -> PoundColumnExpr
}

extension PoundColumnExpr: ExpressibleByPoundColumnExpr {
  public func createPoundColumnExpr() -> PoundColumnExpr {
    self
  }
}

// MARK: - Syntax collection

/// `TupleExprElementList` represents a collection of 
/// `TupleExprElement`s.
public struct TupleExprElementList: SyntaxBuildable {
  let elements: [TupleExprElement]

  public init(_ elements: [ExpressibleByTupleExprElement]) {
    self.elements = elements.map { $0.createTupleExprElement() }
  }

  public func buildTupleExprElementList(format: Format) -> TupleExprElementListSyntax {
    return SyntaxFactory.makeTupleExprElementList(elements.map {
      $0.buildTupleExprElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tupleExprElementList = buildTupleExprElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(tupleExprElementList).withLeadingTrivia(leadingTrivia + (tupleExprElementList.leadingTrivia ?? []))
    }

    return Syntax(tupleExprElementList)
  }
}

public protocol ExpressibleByTupleExprElementList {
  func createTupleExprElementList() -> TupleExprElementList
}

extension TupleExprElementList: ExpressibleByTupleExprElementList {
  public func createTupleExprElementList() -> TupleExprElementList {
    self
  }
}

// MARK: - Syntax collection

/// `ArrayElementList` represents a collection of 
/// `ArrayElement`s.
public struct ArrayElementList: SyntaxBuildable {
  let elements: [ArrayElement]

  public init(_ elements: [ExpressibleByArrayElement]) {
    self.elements = elements.map { $0.createArrayElement() }
  }

  public func buildArrayElementList(format: Format) -> ArrayElementListSyntax {
    return SyntaxFactory.makeArrayElementList(elements.map {
      $0.buildArrayElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let arrayElementList = buildArrayElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(arrayElementList).withLeadingTrivia(leadingTrivia + (arrayElementList.leadingTrivia ?? []))
    }

    return Syntax(arrayElementList)
  }
}

public protocol ExpressibleByArrayElementList {
  func createArrayElementList() -> ArrayElementList
}

extension ArrayElementList: ExpressibleByArrayElementList {
  public func createArrayElementList() -> ArrayElementList {
    self
  }
}

// MARK: - Syntax collection

/// `DictionaryElementList` represents a collection of 
/// `DictionaryElement`s.
public struct DictionaryElementList: SyntaxBuildable {
  let elements: [DictionaryElement]

  public init(_ elements: [ExpressibleByDictionaryElement]) {
    self.elements = elements.map { $0.createDictionaryElement() }
  }

  public func buildDictionaryElementList(format: Format) -> DictionaryElementListSyntax {
    return SyntaxFactory.makeDictionaryElementList(elements.map {
      $0.buildDictionaryElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let dictionaryElementList = buildDictionaryElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(dictionaryElementList).withLeadingTrivia(leadingTrivia + (dictionaryElementList.leadingTrivia ?? []))
    }

    return Syntax(dictionaryElementList)
  }
}

public protocol ExpressibleByDictionaryElementList {
  func createDictionaryElementList() -> DictionaryElementList
}

extension DictionaryElementList: ExpressibleByDictionaryElementList {
  public func createDictionaryElementList() -> DictionaryElementList {
    self
  }
}

// MARK: - Syntax collection

/// `StringLiteralSegments` represents a collection of 
/// `SyntaxBuildable`s.
public struct StringLiteralSegments: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [ExpressibleBySyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public func buildStringLiteralSegments(format: Format) -> StringLiteralSegmentsSyntax {
    return SyntaxFactory.makeStringLiteralSegments(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let stringLiteralSegments = buildStringLiteralSegments(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(stringLiteralSegments).withLeadingTrivia(leadingTrivia + (stringLiteralSegments.leadingTrivia ?? []))
    }

    return Syntax(stringLiteralSegments)
  }
}

public protocol ExpressibleByStringLiteralSegments {
  func createStringLiteralSegments() -> StringLiteralSegments
}

extension StringLiteralSegments: ExpressibleByStringLiteralSegments {
  public func createStringLiteralSegments() -> StringLiteralSegments {
    self
  }
}

public struct TryExpr: ExprBuildable {
  let tryKeyword: TokenSyntax
  let questionOrExclamationMark: TokenSyntax?
  let expression: ExprBuildable

  public init(
    tryKeyword: ExpressibleByTokenSyntax = TokenSyntax.`try`,
    questionOrExclamationMark: ExpressibleByTokenSyntax? = nil,
    expression: ExpressibleByExprBuildable
  ) {
    self.tryKeyword = tryKeyword.createTokenSyntax()
    self.questionOrExclamationMark = questionOrExclamationMark?.createTokenSyntax()
    self.expression = expression.createExprBuildable()
  }
  
  func buildTryExpr(format: Format, leadingTrivia: Trivia? = nil) -> TryExprSyntax {
    let tryExpr = SyntaxFactory.makeTryExpr(
      tryKeyword: tryKeyword,
      questionOrExclamationMark: questionOrExclamationMark,
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return tryExpr.withLeadingTrivia(leadingTrivia + (tryExpr.leadingTrivia ?? []))
    }

    return tryExpr
  }

  /// Conformance for `TryExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let tryExpr = buildTryExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(tryExpr)
  }
}

public protocol ExpressibleByTryExpr {
  func createTryExpr() -> TryExpr
}

extension TryExpr: ExpressibleByTryExpr {
  public func createTryExpr() -> TryExpr {
    self
  }
}

public struct AwaitExpr: ExprBuildable {
  let awaitKeyword: TokenSyntax
  let expression: ExprBuildable

  public init(
    awaitKeyword: ExpressibleByTokenSyntax,
    expression: ExpressibleByExprBuildable
  ) {
    self.awaitKeyword = awaitKeyword.createTokenSyntax()
    self.expression = expression.createExprBuildable()
  }
  
  func buildAwaitExpr(format: Format, leadingTrivia: Trivia? = nil) -> AwaitExprSyntax {
    let awaitExpr = SyntaxFactory.makeAwaitExpr(
      awaitKeyword: awaitKeyword,
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return awaitExpr.withLeadingTrivia(leadingTrivia + (awaitExpr.leadingTrivia ?? []))
    }

    return awaitExpr
  }

  /// Conformance for `AwaitExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let awaitExpr = buildAwaitExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(awaitExpr)
  }
}

public protocol ExpressibleByAwaitExpr {
  func createAwaitExpr() -> AwaitExpr
}

extension AwaitExpr: ExpressibleByAwaitExpr {
  public func createAwaitExpr() -> AwaitExpr {
    self
  }
}

public struct DeclNameArgument: SyntaxBuildable {
  let name: TokenSyntax
  let colon: TokenSyntax

  public init(
    name: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`
  ) {
    self.name = name.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
  }
  
  func buildDeclNameArgument(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameArgumentSyntax {
    let declNameArgument = SyntaxFactory.makeDeclNameArgument(
      name: name,
      colon: colon
    )
    
    if let leadingTrivia = leadingTrivia {
      return declNameArgument.withLeadingTrivia(leadingTrivia + (declNameArgument.leadingTrivia ?? []))
    }

    return declNameArgument
  }

  /// Conformance for `DeclNameArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declNameArgument = buildDeclNameArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(declNameArgument)
  }
}

public protocol ExpressibleByDeclNameArgument {
  func createDeclNameArgument() -> DeclNameArgument
}

extension DeclNameArgument: ExpressibleByDeclNameArgument {
  public func createDeclNameArgument() -> DeclNameArgument {
    self
  }
}

// MARK: - Syntax collection

/// `DeclNameArgumentList` represents a collection of 
/// `DeclNameArgument`s.
public struct DeclNameArgumentList: SyntaxBuildable {
  let elements: [DeclNameArgument]

  public init(_ elements: [ExpressibleByDeclNameArgument]) {
    self.elements = elements.map { $0.createDeclNameArgument() }
  }

  public func buildDeclNameArgumentList(format: Format) -> DeclNameArgumentListSyntax {
    return SyntaxFactory.makeDeclNameArgumentList(elements.map {
      $0.buildDeclNameArgument(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declNameArgumentList = buildDeclNameArgumentList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(declNameArgumentList).withLeadingTrivia(leadingTrivia + (declNameArgumentList.leadingTrivia ?? []))
    }

    return Syntax(declNameArgumentList)
  }
}

public protocol ExpressibleByDeclNameArgumentList {
  func createDeclNameArgumentList() -> DeclNameArgumentList
}

extension DeclNameArgumentList: ExpressibleByDeclNameArgumentList {
  public func createDeclNameArgumentList() -> DeclNameArgumentList {
    self
  }
}

public struct DeclNameArguments: SyntaxBuildable {
  let leftParen: TokenSyntax
  let arguments: DeclNameArgumentList
  let rightParen: TokenSyntax

  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleByDeclNameArgumentList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.arguments = arguments.createDeclNameArgumentList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildDeclNameArguments(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameArgumentsSyntax {
    let declNameArguments = SyntaxFactory.makeDeclNameArguments(
      leftParen: leftParen,
      arguments: arguments.buildDeclNameArgumentList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return declNameArguments.withLeadingTrivia(leadingTrivia + (declNameArguments.leadingTrivia ?? []))
    }

    return declNameArguments
  }

  /// Conformance for `DeclNameArguments` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declNameArguments = buildDeclNameArguments(format: format, leadingTrivia: leadingTrivia)
    return Syntax(declNameArguments)
  }
}

public protocol ExpressibleByDeclNameArguments {
  func createDeclNameArguments() -> DeclNameArguments
}

extension DeclNameArguments: ExpressibleByDeclNameArguments {
  public func createDeclNameArguments() -> DeclNameArguments {
    self
  }
}

public struct IdentifierExpr: ExprBuildable {
  let identifier: TokenSyntax
  let declNameArguments: DeclNameArguments?

  public init(
    identifier: ExpressibleByTokenSyntax,
    declNameArguments: ExpressibleByDeclNameArguments? = nil
  ) {
    self.identifier = identifier.createTokenSyntax()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }
  
  func buildIdentifierExpr(format: Format, leadingTrivia: Trivia? = nil) -> IdentifierExprSyntax {
    let identifierExpr = SyntaxFactory.makeIdentifierExpr(
      identifier: identifier,
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return identifierExpr.withLeadingTrivia(leadingTrivia + (identifierExpr.leadingTrivia ?? []))
    }

    return identifierExpr
  }

  /// Conformance for `IdentifierExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let identifierExpr = buildIdentifierExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(identifierExpr)
  }
}

public protocol ExpressibleByIdentifierExpr {
  func createIdentifierExpr() -> IdentifierExpr
}

extension IdentifierExpr: ExpressibleByIdentifierExpr {
  public func createIdentifierExpr() -> IdentifierExpr {
    self
  }
}

public struct SuperRefExpr: ExprBuildable {
  let superKeyword: TokenSyntax

  public init(
    superKeyword: ExpressibleByTokenSyntax = TokenSyntax.`super`
  ) {
    self.superKeyword = superKeyword.createTokenSyntax()
  }
  
  func buildSuperRefExpr(format: Format, leadingTrivia: Trivia? = nil) -> SuperRefExprSyntax {
    let superRefExpr = SyntaxFactory.makeSuperRefExpr(
      superKeyword: superKeyword
    )
    
    if let leadingTrivia = leadingTrivia {
      return superRefExpr.withLeadingTrivia(leadingTrivia + (superRefExpr.leadingTrivia ?? []))
    }

    return superRefExpr
  }

  /// Conformance for `SuperRefExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let superRefExpr = buildSuperRefExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(superRefExpr)
  }
}

public protocol ExpressibleBySuperRefExpr {
  func createSuperRefExpr() -> SuperRefExpr
}

extension SuperRefExpr: ExpressibleBySuperRefExpr {
  public func createSuperRefExpr() -> SuperRefExpr {
    self
  }
}

public struct NilLiteralExpr: ExprBuildable {
  let nilKeyword: TokenSyntax

  public init(
    nilKeyword: ExpressibleByTokenSyntax = TokenSyntax.`nil`
  ) {
    self.nilKeyword = nilKeyword.createTokenSyntax()
  }
  
  func buildNilLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> NilLiteralExprSyntax {
    let nilLiteralExpr = SyntaxFactory.makeNilLiteralExpr(
      nilKeyword: nilKeyword
    )
    
    if let leadingTrivia = leadingTrivia {
      return nilLiteralExpr.withLeadingTrivia(leadingTrivia + (nilLiteralExpr.leadingTrivia ?? []))
    }

    return nilLiteralExpr
  }

  /// Conformance for `NilLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let nilLiteralExpr = buildNilLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(nilLiteralExpr)
  }
}

public protocol ExpressibleByNilLiteralExpr {
  func createNilLiteralExpr() -> NilLiteralExpr
}

extension NilLiteralExpr: ExpressibleByNilLiteralExpr {
  public func createNilLiteralExpr() -> NilLiteralExpr {
    self
  }
}

public struct DiscardAssignmentExpr: ExprBuildable {
  let wildcard: TokenSyntax

  public init(
    wildcard: ExpressibleByTokenSyntax = TokenSyntax.`wildcard`
  ) {
    self.wildcard = wildcard.createTokenSyntax()
  }
  
  func buildDiscardAssignmentExpr(format: Format, leadingTrivia: Trivia? = nil) -> DiscardAssignmentExprSyntax {
    let discardAssignmentExpr = SyntaxFactory.makeDiscardAssignmentExpr(
      wildcard: wildcard
    )
    
    if let leadingTrivia = leadingTrivia {
      return discardAssignmentExpr.withLeadingTrivia(leadingTrivia + (discardAssignmentExpr.leadingTrivia ?? []))
    }

    return discardAssignmentExpr
  }

  /// Conformance for `DiscardAssignmentExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let discardAssignmentExpr = buildDiscardAssignmentExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(discardAssignmentExpr)
  }
}

public protocol ExpressibleByDiscardAssignmentExpr {
  func createDiscardAssignmentExpr() -> DiscardAssignmentExpr
}

extension DiscardAssignmentExpr: ExpressibleByDiscardAssignmentExpr {
  public func createDiscardAssignmentExpr() -> DiscardAssignmentExpr {
    self
  }
}

public struct AssignmentExpr: ExprBuildable {
  let assignToken: TokenSyntax

  public init(
    assignToken: ExpressibleByTokenSyntax = TokenSyntax.`equal`
  ) {
    self.assignToken = assignToken.createTokenSyntax()
  }
  
  func buildAssignmentExpr(format: Format, leadingTrivia: Trivia? = nil) -> AssignmentExprSyntax {
    let assignmentExpr = SyntaxFactory.makeAssignmentExpr(
      assignToken: assignToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return assignmentExpr.withLeadingTrivia(leadingTrivia + (assignmentExpr.leadingTrivia ?? []))
    }

    return assignmentExpr
  }

  /// Conformance for `AssignmentExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let assignmentExpr = buildAssignmentExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(assignmentExpr)
  }
}

public protocol ExpressibleByAssignmentExpr {
  func createAssignmentExpr() -> AssignmentExpr
}

extension AssignmentExpr: ExpressibleByAssignmentExpr {
  public func createAssignmentExpr() -> AssignmentExpr {
    self
  }
}

public struct SequenceExpr: ExprBuildable {
  let elements: ExprList

  public init(
    elements: ExpressibleByExprList
  ) {
    self.elements = elements.createExprList()
  }
  
  func buildSequenceExpr(format: Format, leadingTrivia: Trivia? = nil) -> SequenceExprSyntax {
    let sequenceExpr = SyntaxFactory.makeSequenceExpr(
      elements: elements.buildExprList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return sequenceExpr.withLeadingTrivia(leadingTrivia + (sequenceExpr.leadingTrivia ?? []))
    }

    return sequenceExpr
  }

  /// Conformance for `SequenceExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let sequenceExpr = buildSequenceExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(sequenceExpr)
  }
}

public protocol ExpressibleBySequenceExpr {
  func createSequenceExpr() -> SequenceExpr
}

extension SequenceExpr: ExpressibleBySequenceExpr {
  public func createSequenceExpr() -> SequenceExpr {
    self
  }
}

// MARK: - Syntax collection

/// 
/// A list of expressions connected by operators. This list is contained
/// by a `SequenceExprSyntax`.
/// 
public struct ExprList: SyntaxBuildable {
  let elements: [ExprBuildable]

  public init(_ elements: [ExpressibleByExprBuildable]) {
    self.elements = elements.map { $0.createExprBuildable() }
  }

  public func buildExprList(format: Format) -> ExprListSyntax {
    return SyntaxFactory.makeExprList(elements.map {
      $0.buildExpr(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let exprList = buildExprList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(exprList).withLeadingTrivia(leadingTrivia + (exprList.leadingTrivia ?? []))
    }

    return Syntax(exprList)
  }
}

public protocol ExpressibleByExprList: ExpressibleByConditionElement, ExpressibleBySyntaxBuildable {
  func createExprList() -> ExprList
}

extension ExprList: ExpressibleByExprList {
  public func createExprList() -> ExprList {
    self
  }
}

public struct PoundLineExpr: ExprBuildable {
  let poundLine: TokenSyntax

  public init(
    poundLine: ExpressibleByTokenSyntax = TokenSyntax.`poundLine`
  ) {
    self.poundLine = poundLine.createTokenSyntax()
  }
  
  func buildPoundLineExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundLineExprSyntax {
    let poundLineExpr = SyntaxFactory.makePoundLineExpr(
      poundLine: poundLine
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundLineExpr.withLeadingTrivia(leadingTrivia + (poundLineExpr.leadingTrivia ?? []))
    }

    return poundLineExpr
  }

  /// Conformance for `PoundLineExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundLineExpr = buildPoundLineExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundLineExpr)
  }
}

public protocol ExpressibleByPoundLineExpr {
  func createPoundLineExpr() -> PoundLineExpr
}

extension PoundLineExpr: ExpressibleByPoundLineExpr {
  public func createPoundLineExpr() -> PoundLineExpr {
    self
  }
}

public struct PoundFileExpr: ExprBuildable {
  let poundFile: TokenSyntax

  public init(
    poundFile: ExpressibleByTokenSyntax = TokenSyntax.`poundFile`
  ) {
    self.poundFile = poundFile.createTokenSyntax()
  }
  
  func buildPoundFileExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFileExprSyntax {
    let poundFileExpr = SyntaxFactory.makePoundFileExpr(
      poundFile: poundFile
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundFileExpr.withLeadingTrivia(leadingTrivia + (poundFileExpr.leadingTrivia ?? []))
    }

    return poundFileExpr
  }

  /// Conformance for `PoundFileExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundFileExpr = buildPoundFileExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundFileExpr)
  }
}

public protocol ExpressibleByPoundFileExpr {
  func createPoundFileExpr() -> PoundFileExpr
}

extension PoundFileExpr: ExpressibleByPoundFileExpr {
  public func createPoundFileExpr() -> PoundFileExpr {
    self
  }
}

public struct PoundFileIDExpr: ExprBuildable {
  let poundFileID: TokenSyntax

  public init(
    poundFileID: ExpressibleByTokenSyntax = TokenSyntax.`poundFileID`
  ) {
    self.poundFileID = poundFileID.createTokenSyntax()
  }
  
  func buildPoundFileIDExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFileIDExprSyntax {
    let poundFileIDExpr = SyntaxFactory.makePoundFileIDExpr(
      poundFileID: poundFileID
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundFileIDExpr.withLeadingTrivia(leadingTrivia + (poundFileIDExpr.leadingTrivia ?? []))
    }

    return poundFileIDExpr
  }

  /// Conformance for `PoundFileIDExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundFileIDExpr = buildPoundFileIDExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundFileIDExpr)
  }
}

public protocol ExpressibleByPoundFileIDExpr {
  func createPoundFileIDExpr() -> PoundFileIDExpr
}

extension PoundFileIDExpr: ExpressibleByPoundFileIDExpr {
  public func createPoundFileIDExpr() -> PoundFileIDExpr {
    self
  }
}

public struct PoundFilePathExpr: ExprBuildable {
  let poundFilePath: TokenSyntax

  public init(
    poundFilePath: ExpressibleByTokenSyntax = TokenSyntax.`poundFilePath`
  ) {
    self.poundFilePath = poundFilePath.createTokenSyntax()
  }
  
  func buildPoundFilePathExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFilePathExprSyntax {
    let poundFilePathExpr = SyntaxFactory.makePoundFilePathExpr(
      poundFilePath: poundFilePath
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundFilePathExpr.withLeadingTrivia(leadingTrivia + (poundFilePathExpr.leadingTrivia ?? []))
    }

    return poundFilePathExpr
  }

  /// Conformance for `PoundFilePathExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundFilePathExpr = buildPoundFilePathExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundFilePathExpr)
  }
}

public protocol ExpressibleByPoundFilePathExpr {
  func createPoundFilePathExpr() -> PoundFilePathExpr
}

extension PoundFilePathExpr: ExpressibleByPoundFilePathExpr {
  public func createPoundFilePathExpr() -> PoundFilePathExpr {
    self
  }
}

public struct PoundFunctionExpr: ExprBuildable {
  let poundFunction: TokenSyntax

  public init(
    poundFunction: ExpressibleByTokenSyntax = TokenSyntax.`poundFunction`
  ) {
    self.poundFunction = poundFunction.createTokenSyntax()
  }
  
  func buildPoundFunctionExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundFunctionExprSyntax {
    let poundFunctionExpr = SyntaxFactory.makePoundFunctionExpr(
      poundFunction: poundFunction
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundFunctionExpr.withLeadingTrivia(leadingTrivia + (poundFunctionExpr.leadingTrivia ?? []))
    }

    return poundFunctionExpr
  }

  /// Conformance for `PoundFunctionExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundFunctionExpr = buildPoundFunctionExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundFunctionExpr)
  }
}

public protocol ExpressibleByPoundFunctionExpr {
  func createPoundFunctionExpr() -> PoundFunctionExpr
}

extension PoundFunctionExpr: ExpressibleByPoundFunctionExpr {
  public func createPoundFunctionExpr() -> PoundFunctionExpr {
    self
  }
}

public struct PoundDsohandleExpr: ExprBuildable {
  let poundDsohandle: TokenSyntax

  public init(
    poundDsohandle: ExpressibleByTokenSyntax = TokenSyntax.`poundDsohandle`
  ) {
    self.poundDsohandle = poundDsohandle.createTokenSyntax()
  }
  
  func buildPoundDsohandleExpr(format: Format, leadingTrivia: Trivia? = nil) -> PoundDsohandleExprSyntax {
    let poundDsohandleExpr = SyntaxFactory.makePoundDsohandleExpr(
      poundDsohandle: poundDsohandle
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundDsohandleExpr.withLeadingTrivia(leadingTrivia + (poundDsohandleExpr.leadingTrivia ?? []))
    }

    return poundDsohandleExpr
  }

  /// Conformance for `PoundDsohandleExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let poundDsohandleExpr = buildPoundDsohandleExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(poundDsohandleExpr)
  }
}

public protocol ExpressibleByPoundDsohandleExpr {
  func createPoundDsohandleExpr() -> PoundDsohandleExpr
}

extension PoundDsohandleExpr: ExpressibleByPoundDsohandleExpr {
  public func createPoundDsohandleExpr() -> PoundDsohandleExpr {
    self
  }
}

public struct SymbolicReferenceExpr: ExprBuildable {
  let identifier: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  public init(
    identifier: ExpressibleByTokenSyntax,
    genericArgumentClause: ExpressibleByGenericArgumentClause? = nil
  ) {
    self.identifier = identifier.createTokenSyntax()
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }
  
  func buildSymbolicReferenceExpr(format: Format, leadingTrivia: Trivia? = nil) -> SymbolicReferenceExprSyntax {
    let symbolicReferenceExpr = SyntaxFactory.makeSymbolicReferenceExpr(
      identifier: identifier,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return symbolicReferenceExpr.withLeadingTrivia(leadingTrivia + (symbolicReferenceExpr.leadingTrivia ?? []))
    }

    return symbolicReferenceExpr
  }

  /// Conformance for `SymbolicReferenceExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let symbolicReferenceExpr = buildSymbolicReferenceExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(symbolicReferenceExpr)
  }
}

public protocol ExpressibleBySymbolicReferenceExpr {
  func createSymbolicReferenceExpr() -> SymbolicReferenceExpr
}

extension SymbolicReferenceExpr: ExpressibleBySymbolicReferenceExpr {
  public func createSymbolicReferenceExpr() -> SymbolicReferenceExpr {
    self
  }
}

public struct PrefixOperatorExpr: ExprBuildable {
  let operatorToken: TokenSyntax?
  let postfixExpression: ExprBuildable

  public init(
    operatorToken: ExpressibleByTokenSyntax? = nil,
    postfixExpression: ExpressibleByExprBuildable
  ) {
    self.operatorToken = operatorToken?.createTokenSyntax()
    self.postfixExpression = postfixExpression.createExprBuildable()
  }
  
  func buildPrefixOperatorExpr(format: Format, leadingTrivia: Trivia? = nil) -> PrefixOperatorExprSyntax {
    let prefixOperatorExpr = SyntaxFactory.makePrefixOperatorExpr(
      operatorToken: operatorToken,
      postfixExpression: postfixExpression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return prefixOperatorExpr.withLeadingTrivia(leadingTrivia + (prefixOperatorExpr.leadingTrivia ?? []))
    }

    return prefixOperatorExpr
  }

  /// Conformance for `PrefixOperatorExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let prefixOperatorExpr = buildPrefixOperatorExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(prefixOperatorExpr)
  }
}

public protocol ExpressibleByPrefixOperatorExpr {
  func createPrefixOperatorExpr() -> PrefixOperatorExpr
}

extension PrefixOperatorExpr: ExpressibleByPrefixOperatorExpr {
  public func createPrefixOperatorExpr() -> PrefixOperatorExpr {
    self
  }
}

public struct BinaryOperatorExpr: ExprBuildable {
  let operatorToken: TokenSyntax

  public init(
    operatorToken: ExpressibleByTokenSyntax
  ) {
    self.operatorToken = operatorToken.createTokenSyntax()
  }
  
  func buildBinaryOperatorExpr(format: Format, leadingTrivia: Trivia? = nil) -> BinaryOperatorExprSyntax {
    let binaryOperatorExpr = SyntaxFactory.makeBinaryOperatorExpr(
      operatorToken: operatorToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return binaryOperatorExpr.withLeadingTrivia(leadingTrivia + (binaryOperatorExpr.leadingTrivia ?? []))
    }

    return binaryOperatorExpr
  }

  /// Conformance for `BinaryOperatorExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let binaryOperatorExpr = buildBinaryOperatorExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(binaryOperatorExpr)
  }
}

public protocol ExpressibleByBinaryOperatorExpr {
  func createBinaryOperatorExpr() -> BinaryOperatorExpr
}

extension BinaryOperatorExpr: ExpressibleByBinaryOperatorExpr {
  public func createBinaryOperatorExpr() -> BinaryOperatorExpr {
    self
  }
}

public struct ArrowExpr: ExprBuildable {
  let asyncKeyword: TokenSyntax?
  let throwsToken: TokenSyntax?
  let arrowToken: TokenSyntax

  public init(
    asyncKeyword: ExpressibleByTokenSyntax? = nil,
    throwsToken: ExpressibleByTokenSyntax? = nil,
    arrowToken: ExpressibleByTokenSyntax = TokenSyntax.`arrow`
  ) {
    self.asyncKeyword = asyncKeyword?.createTokenSyntax()
    self.throwsToken = throwsToken?.createTokenSyntax()
    self.arrowToken = arrowToken.createTokenSyntax()
  }
  
  func buildArrowExpr(format: Format, leadingTrivia: Trivia? = nil) -> ArrowExprSyntax {
    let arrowExpr = SyntaxFactory.makeArrowExpr(
      asyncKeyword: asyncKeyword,
      throwsToken: throwsToken,
      arrowToken: arrowToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return arrowExpr.withLeadingTrivia(leadingTrivia + (arrowExpr.leadingTrivia ?? []))
    }

    return arrowExpr
  }

  /// Conformance for `ArrowExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let arrowExpr = buildArrowExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(arrowExpr)
  }
}

public protocol ExpressibleByArrowExpr {
  func createArrowExpr() -> ArrowExpr
}

extension ArrowExpr: ExpressibleByArrowExpr {
  public func createArrowExpr() -> ArrowExpr {
    self
  }
}

public struct FloatLiteralExpr: ExprBuildable {
  let floatingDigits: TokenSyntax

  public init(
    floatingDigits: ExpressibleByTokenSyntax
  ) {
    self.floatingDigits = floatingDigits.createTokenSyntax()
  }
  
  func buildFloatLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> FloatLiteralExprSyntax {
    let floatLiteralExpr = SyntaxFactory.makeFloatLiteralExpr(
      floatingDigits: floatingDigits
    )
    
    if let leadingTrivia = leadingTrivia {
      return floatLiteralExpr.withLeadingTrivia(leadingTrivia + (floatLiteralExpr.leadingTrivia ?? []))
    }

    return floatLiteralExpr
  }

  /// Conformance for `FloatLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let floatLiteralExpr = buildFloatLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(floatLiteralExpr)
  }
}

public protocol ExpressibleByFloatLiteralExpr {
  func createFloatLiteralExpr() -> FloatLiteralExpr
}

extension FloatLiteralExpr: ExpressibleByFloatLiteralExpr {
  public func createFloatLiteralExpr() -> FloatLiteralExpr {
    self
  }
}

public struct TupleExpr: ExprBuildable {
  let leftParen: TokenSyntax
  let elementList: TupleExprElementList
  let rightParen: TokenSyntax

  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    elementList: ExpressibleByTupleExprElementList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.elementList = elementList.createTupleExprElementList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildTupleExpr(format: Format, leadingTrivia: Trivia? = nil) -> TupleExprSyntax {
    let tupleExpr = SyntaxFactory.makeTupleExpr(
      leftParen: leftParen,
      elementList: elementList.buildTupleExprElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return tupleExpr.withLeadingTrivia(leadingTrivia + (tupleExpr.leadingTrivia ?? []))
    }

    return tupleExpr
  }

  /// Conformance for `TupleExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let tupleExpr = buildTupleExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(tupleExpr)
  }
}

public protocol ExpressibleByTupleExpr {
  func createTupleExpr() -> TupleExpr
}

extension TupleExpr: ExpressibleByTupleExpr {
  public func createTupleExpr() -> TupleExpr {
    self
  }
}

public struct ArrayExpr: ExprBuildable {
  let leftSquare: TokenSyntax
  let elements: ArrayElementList
  let rightSquare: TokenSyntax

  public init(
    leftSquare: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    elements: ExpressibleByArrayElementList,
    rightSquare: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquare = leftSquare.createTokenSyntax()
    self.elements = elements.createArrayElementList()
    self.rightSquare = rightSquare.createTokenSyntax()
  }
  
  func buildArrayExpr(format: Format, leadingTrivia: Trivia? = nil) -> ArrayExprSyntax {
    let arrayExpr = SyntaxFactory.makeArrayExpr(
      leftSquare: leftSquare,
      elements: elements.buildArrayElementList(format: format),
      rightSquare: rightSquare
    )
    
    if let leadingTrivia = leadingTrivia {
      return arrayExpr.withLeadingTrivia(leadingTrivia + (arrayExpr.leadingTrivia ?? []))
    }

    return arrayExpr
  }

  /// Conformance for `ArrayExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let arrayExpr = buildArrayExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(arrayExpr)
  }
}

public protocol ExpressibleByArrayExpr {
  func createArrayExpr() -> ArrayExpr
}

extension ArrayExpr: ExpressibleByArrayExpr {
  public func createArrayExpr() -> ArrayExpr {
    self
  }
}

public struct DictionaryExpr: ExprBuildable {
  let leftSquare: TokenSyntax
  let content: SyntaxBuildable
  let rightSquare: TokenSyntax

  public init(
    leftSquare: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    content: ExpressibleBySyntaxBuildable,
    rightSquare: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquare = leftSquare.createTokenSyntax()
    self.content = content.createSyntaxBuildable()
    self.rightSquare = rightSquare.createTokenSyntax()
  }
  
  func buildDictionaryExpr(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryExprSyntax {
    let dictionaryExpr = SyntaxFactory.makeDictionaryExpr(
      leftSquare: leftSquare,
      content: content.buildSyntax(format: format),
      rightSquare: rightSquare
    )
    
    if let leadingTrivia = leadingTrivia {
      return dictionaryExpr.withLeadingTrivia(leadingTrivia + (dictionaryExpr.leadingTrivia ?? []))
    }

    return dictionaryExpr
  }

  /// Conformance for `DictionaryExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let dictionaryExpr = buildDictionaryExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(dictionaryExpr)
  }
}

public protocol ExpressibleByDictionaryExpr {
  func createDictionaryExpr() -> DictionaryExpr
}

extension DictionaryExpr: ExpressibleByDictionaryExpr {
  public func createDictionaryExpr() -> DictionaryExpr {
    self
  }
}

public struct TupleExprElement: SyntaxBuildable {
  let label: TokenSyntax?
  let colon: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  public init(
    label: ExpressibleByTokenSyntax? = nil,
    colon: ExpressibleByTokenSyntax? = nil,
    expression: ExpressibleByExprBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.label = label?.createTokenSyntax()
    self.colon = colon?.createTokenSyntax()
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildTupleExprElement(format: Format, leadingTrivia: Trivia? = nil) -> TupleExprElementSyntax {
    let tupleExprElement = SyntaxFactory.makeTupleExprElement(
      label: label,
      colon: colon,
      expression: expression.buildExpr(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return tupleExprElement.withLeadingTrivia(leadingTrivia + (tupleExprElement.leadingTrivia ?? []))
    }

    return tupleExprElement
  }

  /// Conformance for `TupleExprElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tupleExprElement = buildTupleExprElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(tupleExprElement)
  }
}

public protocol ExpressibleByTupleExprElement {
  func createTupleExprElement() -> TupleExprElement
}

extension TupleExprElement: ExpressibleByTupleExprElement {
  public func createTupleExprElement() -> TupleExprElement {
    self
  }
}

public struct ArrayElement: SyntaxBuildable {
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  public init(
    expression: ExpressibleByExprBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildArrayElement(format: Format, leadingTrivia: Trivia? = nil) -> ArrayElementSyntax {
    let arrayElement = SyntaxFactory.makeArrayElement(
      expression: expression.buildExpr(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return arrayElement.withLeadingTrivia(leadingTrivia + (arrayElement.leadingTrivia ?? []))
    }

    return arrayElement
  }

  /// Conformance for `ArrayElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let arrayElement = buildArrayElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(arrayElement)
  }
}

public protocol ExpressibleByArrayElement {
  func createArrayElement() -> ArrayElement
}

extension ArrayElement: ExpressibleByArrayElement {
  public func createArrayElement() -> ArrayElement {
    self
  }
}

public struct DictionaryElement: SyntaxBuildable {
  let keyExpression: ExprBuildable
  let colon: TokenSyntax
  let valueExpression: ExprBuildable
  let trailingComma: TokenSyntax?

  public init(
    keyExpression: ExpressibleByExprBuildable,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    valueExpression: ExpressibleByExprBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.keyExpression = keyExpression.createExprBuildable()
    self.colon = colon.createTokenSyntax()
    self.valueExpression = valueExpression.createExprBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildDictionaryElement(format: Format, leadingTrivia: Trivia? = nil) -> DictionaryElementSyntax {
    let dictionaryElement = SyntaxFactory.makeDictionaryElement(
      keyExpression: keyExpression.buildExpr(format: format),
      colon: colon,
      valueExpression: valueExpression.buildExpr(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return dictionaryElement.withLeadingTrivia(leadingTrivia + (dictionaryElement.leadingTrivia ?? []))
    }

    return dictionaryElement
  }

  /// Conformance for `DictionaryElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let dictionaryElement = buildDictionaryElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(dictionaryElement)
  }
}

public protocol ExpressibleByDictionaryElement {
  func createDictionaryElement() -> DictionaryElement
}

extension DictionaryElement: ExpressibleByDictionaryElement {
  public func createDictionaryElement() -> DictionaryElement {
    self
  }
}

public struct IntegerLiteralExpr: ExprBuildable {
  let digits: TokenSyntax

  public init(
    digits: ExpressibleByTokenSyntax
  ) {
    self.digits = digits.createTokenSyntax()
  }
  
  func buildIntegerLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> IntegerLiteralExprSyntax {
    let integerLiteralExpr = SyntaxFactory.makeIntegerLiteralExpr(
      digits: digits
    )
    
    if let leadingTrivia = leadingTrivia {
      return integerLiteralExpr.withLeadingTrivia(leadingTrivia + (integerLiteralExpr.leadingTrivia ?? []))
    }

    return integerLiteralExpr
  }

  /// Conformance for `IntegerLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let integerLiteralExpr = buildIntegerLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(integerLiteralExpr)
  }
}

public protocol ExpressibleByIntegerLiteralExpr {
  func createIntegerLiteralExpr() -> IntegerLiteralExpr
}

extension IntegerLiteralExpr: ExpressibleByIntegerLiteralExpr {
  public func createIntegerLiteralExpr() -> IntegerLiteralExpr {
    self
  }
}

public struct BooleanLiteralExpr: ExprBuildable {
  let booleanLiteral: TokenSyntax

  public init(
    booleanLiteral: ExpressibleByTokenSyntax
  ) {
    self.booleanLiteral = booleanLiteral.createTokenSyntax()
  }
  
  func buildBooleanLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> BooleanLiteralExprSyntax {
    let booleanLiteralExpr = SyntaxFactory.makeBooleanLiteralExpr(
      booleanLiteral: booleanLiteral
    )
    
    if let leadingTrivia = leadingTrivia {
      return booleanLiteralExpr.withLeadingTrivia(leadingTrivia + (booleanLiteralExpr.leadingTrivia ?? []))
    }

    return booleanLiteralExpr
  }

  /// Conformance for `BooleanLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let booleanLiteralExpr = buildBooleanLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(booleanLiteralExpr)
  }
}

public protocol ExpressibleByBooleanLiteralExpr {
  func createBooleanLiteralExpr() -> BooleanLiteralExpr
}

extension BooleanLiteralExpr: ExpressibleByBooleanLiteralExpr {
  public func createBooleanLiteralExpr() -> BooleanLiteralExpr {
    self
  }
}

public struct TernaryExpr: ExprBuildable {
  let conditionExpression: ExprBuildable
  let questionMark: TokenSyntax
  let firstChoice: ExprBuildable
  let colonMark: TokenSyntax
  let secondChoice: ExprBuildable

  public init(
    conditionExpression: ExpressibleByExprBuildable,
    questionMark: ExpressibleByTokenSyntax = TokenSyntax.`infixQuestionMark`,
    firstChoice: ExpressibleByExprBuildable,
    colonMark: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    secondChoice: ExpressibleByExprBuildable
  ) {
    self.conditionExpression = conditionExpression.createExprBuildable()
    self.questionMark = questionMark.createTokenSyntax()
    self.firstChoice = firstChoice.createExprBuildable()
    self.colonMark = colonMark.createTokenSyntax()
    self.secondChoice = secondChoice.createExprBuildable()
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
      return ternaryExpr.withLeadingTrivia(leadingTrivia + (ternaryExpr.leadingTrivia ?? []))
    }

    return ternaryExpr
  }

  /// Conformance for `TernaryExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let ternaryExpr = buildTernaryExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(ternaryExpr)
  }
}

public protocol ExpressibleByTernaryExpr {
  func createTernaryExpr() -> TernaryExpr
}

extension TernaryExpr: ExpressibleByTernaryExpr {
  public func createTernaryExpr() -> TernaryExpr {
    self
  }
}

public struct MemberAccessExpr: ExprBuildable {
  let base: ExprBuildable?
  let dot: TokenSyntax
  let name: TokenSyntax
  let declNameArguments: DeclNameArguments?

  public init(
    base: ExpressibleByExprBuildable? = nil,
    dot: ExpressibleByTokenSyntax,
    name: ExpressibleByTokenSyntax,
    declNameArguments: ExpressibleByDeclNameArguments? = nil
  ) {
    self.base = base?.createExprBuildable()
    self.dot = dot.createTokenSyntax()
    self.name = name.createTokenSyntax()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }
  
  func buildMemberAccessExpr(format: Format, leadingTrivia: Trivia? = nil) -> MemberAccessExprSyntax {
    let memberAccessExpr = SyntaxFactory.makeMemberAccessExpr(
      base: base?.buildExpr(format: format),
      dot: dot,
      name: name,
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return memberAccessExpr.withLeadingTrivia(leadingTrivia + (memberAccessExpr.leadingTrivia ?? []))
    }

    return memberAccessExpr
  }

  /// Conformance for `MemberAccessExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let memberAccessExpr = buildMemberAccessExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(memberAccessExpr)
  }
}

public protocol ExpressibleByMemberAccessExpr {
  func createMemberAccessExpr() -> MemberAccessExpr
}

extension MemberAccessExpr: ExpressibleByMemberAccessExpr {
  public func createMemberAccessExpr() -> MemberAccessExpr {
    self
  }
}

public struct IsExpr: ExprBuildable {
  let isTok: TokenSyntax
  let typeName: TypeBuildable

  public init(
    isTok: ExpressibleByTokenSyntax = TokenSyntax.`is`,
    typeName: ExpressibleByTypeBuildable
  ) {
    self.isTok = isTok.createTokenSyntax()
    self.typeName = typeName.createTypeBuildable()
  }
  
  func buildIsExpr(format: Format, leadingTrivia: Trivia? = nil) -> IsExprSyntax {
    let isExpr = SyntaxFactory.makeIsExpr(
      isTok: isTok,
      typeName: typeName.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return isExpr.withLeadingTrivia(leadingTrivia + (isExpr.leadingTrivia ?? []))
    }

    return isExpr
  }

  /// Conformance for `IsExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let isExpr = buildIsExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(isExpr)
  }
}

public protocol ExpressibleByIsExpr {
  func createIsExpr() -> IsExpr
}

extension IsExpr: ExpressibleByIsExpr {
  public func createIsExpr() -> IsExpr {
    self
  }
}

public struct AsExpr: ExprBuildable {
  let asTok: TokenSyntax
  let questionOrExclamationMark: TokenSyntax?
  let typeName: TypeBuildable

  public init(
    asTok: ExpressibleByTokenSyntax = TokenSyntax.`as`,
    questionOrExclamationMark: ExpressibleByTokenSyntax? = nil,
    typeName: ExpressibleByTypeBuildable
  ) {
    self.asTok = asTok.createTokenSyntax()
    self.questionOrExclamationMark = questionOrExclamationMark?.createTokenSyntax()
    self.typeName = typeName.createTypeBuildable()
  }
  
  func buildAsExpr(format: Format, leadingTrivia: Trivia? = nil) -> AsExprSyntax {
    let asExpr = SyntaxFactory.makeAsExpr(
      asTok: asTok,
      questionOrExclamationMark: questionOrExclamationMark,
      typeName: typeName.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return asExpr.withLeadingTrivia(leadingTrivia + (asExpr.leadingTrivia ?? []))
    }

    return asExpr
  }

  /// Conformance for `AsExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let asExpr = buildAsExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(asExpr)
  }
}

public protocol ExpressibleByAsExpr {
  func createAsExpr() -> AsExpr
}

extension AsExpr: ExpressibleByAsExpr {
  public func createAsExpr() -> AsExpr {
    self
  }
}

public struct TypeExpr: ExprBuildable {
  let type: TypeBuildable

  public init(
    type: ExpressibleByTypeBuildable
  ) {
    self.type = type.createTypeBuildable()
  }
  
  func buildTypeExpr(format: Format, leadingTrivia: Trivia? = nil) -> TypeExprSyntax {
    let typeExpr = SyntaxFactory.makeTypeExpr(
      type: type.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typeExpr.withLeadingTrivia(leadingTrivia + (typeExpr.leadingTrivia ?? []))
    }

    return typeExpr
  }

  /// Conformance for `TypeExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let typeExpr = buildTypeExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(typeExpr)
  }
}

public protocol ExpressibleByTypeExpr {
  func createTypeExpr() -> TypeExpr
}

extension TypeExpr: ExpressibleByTypeExpr {
  public func createTypeExpr() -> TypeExpr {
    self
  }
}

public struct ClosureCaptureItem: SyntaxBuildable {
  let specifier: TokenList?
  let name: TokenSyntax?
  let assignToken: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  public init(
    specifier: ExpressibleByTokenList? = nil,
    name: ExpressibleByTokenSyntax? = nil,
    assignToken: ExpressibleByTokenSyntax? = nil,
    expression: ExpressibleByExprBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.specifier = specifier?.createTokenList()
    self.name = name?.createTokenSyntax()
    self.assignToken = assignToken?.createTokenSyntax()
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildClosureCaptureItem(format: Format, leadingTrivia: Trivia? = nil) -> ClosureCaptureItemSyntax {
    let closureCaptureItem = SyntaxFactory.makeClosureCaptureItem(
      specifier: specifier?.buildTokenList(format: format),
      name: name,
      assignToken: assignToken,
      expression: expression.buildExpr(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureCaptureItem.withLeadingTrivia(leadingTrivia + (closureCaptureItem.leadingTrivia ?? []))
    }

    return closureCaptureItem
  }

  /// Conformance for `ClosureCaptureItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureCaptureItem = buildClosureCaptureItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(closureCaptureItem)
  }
}

public protocol ExpressibleByClosureCaptureItem {
  func createClosureCaptureItem() -> ClosureCaptureItem
}

extension ClosureCaptureItem: ExpressibleByClosureCaptureItem {
  public func createClosureCaptureItem() -> ClosureCaptureItem {
    self
  }
}

// MARK: - Syntax collection

/// `ClosureCaptureItemList` represents a collection of 
/// `ClosureCaptureItem`s.
public struct ClosureCaptureItemList: SyntaxBuildable {
  let elements: [ClosureCaptureItem]

  public init(_ elements: [ExpressibleByClosureCaptureItem]) {
    self.elements = elements.map { $0.createClosureCaptureItem() }
  }

  public func buildClosureCaptureItemList(format: Format) -> ClosureCaptureItemListSyntax {
    return SyntaxFactory.makeClosureCaptureItemList(elements.map {
      $0.buildClosureCaptureItem(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureCaptureItemList = buildClosureCaptureItemList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(closureCaptureItemList).withLeadingTrivia(leadingTrivia + (closureCaptureItemList.leadingTrivia ?? []))
    }

    return Syntax(closureCaptureItemList)
  }
}

public protocol ExpressibleByClosureCaptureItemList {
  func createClosureCaptureItemList() -> ClosureCaptureItemList
}

extension ClosureCaptureItemList: ExpressibleByClosureCaptureItemList {
  public func createClosureCaptureItemList() -> ClosureCaptureItemList {
    self
  }
}

public struct ClosureCaptureSignature: SyntaxBuildable {
  let leftSquare: TokenSyntax
  let items: ClosureCaptureItemList?
  let rightSquare: TokenSyntax

  public init(
    leftSquare: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    items: ExpressibleByClosureCaptureItemList? = nil,
    rightSquare: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquare = leftSquare.createTokenSyntax()
    self.items = items?.createClosureCaptureItemList()
    self.rightSquare = rightSquare.createTokenSyntax()
  }
  
  func buildClosureCaptureSignature(format: Format, leadingTrivia: Trivia? = nil) -> ClosureCaptureSignatureSyntax {
    let closureCaptureSignature = SyntaxFactory.makeClosureCaptureSignature(
      leftSquare: leftSquare,
      items: items?.buildClosureCaptureItemList(format: format),
      rightSquare: rightSquare
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureCaptureSignature.withLeadingTrivia(leadingTrivia + (closureCaptureSignature.leadingTrivia ?? []))
    }

    return closureCaptureSignature
  }

  /// Conformance for `ClosureCaptureSignature` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureCaptureSignature = buildClosureCaptureSignature(format: format, leadingTrivia: leadingTrivia)
    return Syntax(closureCaptureSignature)
  }
}

public protocol ExpressibleByClosureCaptureSignature {
  func createClosureCaptureSignature() -> ClosureCaptureSignature
}

extension ClosureCaptureSignature: ExpressibleByClosureCaptureSignature {
  public func createClosureCaptureSignature() -> ClosureCaptureSignature {
    self
  }
}

public struct ClosureParam: SyntaxBuildable {
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  public init(
    name: ExpressibleByTokenSyntax,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.name = name.createTokenSyntax()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildClosureParam(format: Format, leadingTrivia: Trivia? = nil) -> ClosureParamSyntax {
    let closureParam = SyntaxFactory.makeClosureParam(
      name: name,
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureParam.withLeadingTrivia(leadingTrivia + (closureParam.leadingTrivia ?? []))
    }

    return closureParam
  }

  /// Conformance for `ClosureParam` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureParam = buildClosureParam(format: format, leadingTrivia: leadingTrivia)
    return Syntax(closureParam)
  }
}

public protocol ExpressibleByClosureParam {
  func createClosureParam() -> ClosureParam
}

extension ClosureParam: ExpressibleByClosureParam {
  public func createClosureParam() -> ClosureParam {
    self
  }
}

// MARK: - Syntax collection

/// `ClosureParamList` represents a collection of 
/// `ClosureParam`s.
public struct ClosureParamList: SyntaxBuildable {
  let elements: [ClosureParam]

  public init(_ elements: [ExpressibleByClosureParam]) {
    self.elements = elements.map { $0.createClosureParam() }
  }

  public func buildClosureParamList(format: Format) -> ClosureParamListSyntax {
    return SyntaxFactory.makeClosureParamList(elements.map {
      $0.buildClosureParam(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureParamList = buildClosureParamList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(closureParamList).withLeadingTrivia(leadingTrivia + (closureParamList.leadingTrivia ?? []))
    }

    return Syntax(closureParamList)
  }
}

public protocol ExpressibleByClosureParamList {
  func createClosureParamList() -> ClosureParamList
}

extension ClosureParamList: ExpressibleByClosureParamList {
  public func createClosureParamList() -> ClosureParamList {
    self
  }
}

public struct ClosureSignature: SyntaxBuildable {
  let attributes: AttributeList?
  let capture: ClosureCaptureSignature?
  let input: SyntaxBuildable?
  let asyncKeyword: TokenSyntax?
  let throwsTok: TokenSyntax?
  let output: ReturnClause?
  let inTok: TokenSyntax

  public init(
    attributes: ExpressibleByAttributeList? = nil,
    capture: ExpressibleByClosureCaptureSignature? = nil,
    input: ExpressibleBySyntaxBuildable? = nil,
    asyncKeyword: ExpressibleByTokenSyntax? = nil,
    throwsTok: ExpressibleByTokenSyntax? = nil,
    output: ExpressibleByReturnClause? = nil,
    inTok: ExpressibleByTokenSyntax = TokenSyntax.`in`
  ) {
    self.attributes = attributes?.createAttributeList()
    self.capture = capture?.createClosureCaptureSignature()
    self.input = input?.createSyntaxBuildable()
    self.asyncKeyword = asyncKeyword?.createTokenSyntax()
    self.throwsTok = throwsTok?.createTokenSyntax()
    self.output = output?.createReturnClause()
    self.inTok = inTok.createTokenSyntax()
  }
  
  func buildClosureSignature(format: Format, leadingTrivia: Trivia? = nil) -> ClosureSignatureSyntax {
    let closureSignature = SyntaxFactory.makeClosureSignature(
      attributes: attributes?.buildAttributeList(format: format),
      capture: capture?.buildClosureCaptureSignature(format: format),
      input: input?.buildSyntax(format: format),
      asyncKeyword: asyncKeyword,
      throwsTok: throwsTok,
      output: output?.buildReturnClause(format: format),
      inTok: inTok
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureSignature.withLeadingTrivia(leadingTrivia + (closureSignature.leadingTrivia ?? []))
    }

    return closureSignature
  }

  /// Conformance for `ClosureSignature` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let closureSignature = buildClosureSignature(format: format, leadingTrivia: leadingTrivia)
    return Syntax(closureSignature)
  }
}

public protocol ExpressibleByClosureSignature {
  func createClosureSignature() -> ClosureSignature
}

extension ClosureSignature: ExpressibleByClosureSignature {
  public func createClosureSignature() -> ClosureSignature {
    self
  }
}

public struct ClosureExpr: ExprBuildable {
  let leftBrace: TokenSyntax
  let signature: ClosureSignature?
  let statements: CodeBlockItemList
  let rightBrace: TokenSyntax

  public init(
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    signature: ExpressibleByClosureSignature? = nil,
    statements: ExpressibleByCodeBlockItemList,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace.createTokenSyntax()
    self.signature = signature?.createClosureSignature()
    self.statements = statements.createCodeBlockItemList()
    self.rightBrace = rightBrace.createTokenSyntax()
  }
  
  func buildClosureExpr(format: Format, leadingTrivia: Trivia? = nil) -> ClosureExprSyntax {
    let closureExpr = SyntaxFactory.makeClosureExpr(
      leftBrace: leftBrace,
      signature: signature?.buildClosureSignature(format: format),
      statements: statements.buildCodeBlockItemList(format: format),
      rightBrace: rightBrace
    )
    
    if let leadingTrivia = leadingTrivia {
      return closureExpr.withLeadingTrivia(leadingTrivia + (closureExpr.leadingTrivia ?? []))
    }

    return closureExpr
  }

  /// Conformance for `ClosureExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let closureExpr = buildClosureExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(closureExpr)
  }
}

public protocol ExpressibleByClosureExpr {
  func createClosureExpr() -> ClosureExpr
}

extension ClosureExpr: ExpressibleByClosureExpr {
  public func createClosureExpr() -> ClosureExpr {
    self
  }
}

public struct UnresolvedPatternExpr: ExprBuildable {
  let pattern: PatternBuildable

  public init(
    pattern: ExpressibleByPatternBuildable
  ) {
    self.pattern = pattern.createPatternBuildable()
  }
  
  func buildUnresolvedPatternExpr(format: Format, leadingTrivia: Trivia? = nil) -> UnresolvedPatternExprSyntax {
    let unresolvedPatternExpr = SyntaxFactory.makeUnresolvedPatternExpr(
      pattern: pattern.buildPattern(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return unresolvedPatternExpr.withLeadingTrivia(leadingTrivia + (unresolvedPatternExpr.leadingTrivia ?? []))
    }

    return unresolvedPatternExpr
  }

  /// Conformance for `UnresolvedPatternExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let unresolvedPatternExpr = buildUnresolvedPatternExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(unresolvedPatternExpr)
  }
}

public protocol ExpressibleByUnresolvedPatternExpr {
  func createUnresolvedPatternExpr() -> UnresolvedPatternExpr
}

extension UnresolvedPatternExpr: ExpressibleByUnresolvedPatternExpr {
  public func createUnresolvedPatternExpr() -> UnresolvedPatternExpr {
    self
  }
}

public struct MultipleTrailingClosureElement: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let closure: ClosureExpr

  public init(
    label: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    closure: ExpressibleByClosureExpr
  ) {
    self.label = label.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.closure = closure.createClosureExpr()
  }
  
  func buildMultipleTrailingClosureElement(format: Format, leadingTrivia: Trivia? = nil) -> MultipleTrailingClosureElementSyntax {
    let multipleTrailingClosureElement = SyntaxFactory.makeMultipleTrailingClosureElement(
      label: label,
      colon: colon,
      closure: closure.buildClosureExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return multipleTrailingClosureElement.withLeadingTrivia(leadingTrivia + (multipleTrailingClosureElement.leadingTrivia ?? []))
    }

    return multipleTrailingClosureElement
  }

  /// Conformance for `MultipleTrailingClosureElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let multipleTrailingClosureElement = buildMultipleTrailingClosureElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(multipleTrailingClosureElement)
  }
}

public protocol ExpressibleByMultipleTrailingClosureElement {
  func createMultipleTrailingClosureElement() -> MultipleTrailingClosureElement
}

extension MultipleTrailingClosureElement: ExpressibleByMultipleTrailingClosureElement {
  public func createMultipleTrailingClosureElement() -> MultipleTrailingClosureElement {
    self
  }
}

// MARK: - Syntax collection

/// `MultipleTrailingClosureElementList` represents a collection of 
/// `MultipleTrailingClosureElement`s.
public struct MultipleTrailingClosureElementList: SyntaxBuildable {
  let elements: [MultipleTrailingClosureElement]

  public init(_ elements: [ExpressibleByMultipleTrailingClosureElement]) {
    self.elements = elements.map { $0.createMultipleTrailingClosureElement() }
  }

  public func buildMultipleTrailingClosureElementList(format: Format) -> MultipleTrailingClosureElementListSyntax {
    return SyntaxFactory.makeMultipleTrailingClosureElementList(elements.map {
      $0.buildMultipleTrailingClosureElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let multipleTrailingClosureElementList = buildMultipleTrailingClosureElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(multipleTrailingClosureElementList).withLeadingTrivia(leadingTrivia + (multipleTrailingClosureElementList.leadingTrivia ?? []))
    }

    return Syntax(multipleTrailingClosureElementList)
  }
}

public protocol ExpressibleByMultipleTrailingClosureElementList {
  func createMultipleTrailingClosureElementList() -> MultipleTrailingClosureElementList
}

extension MultipleTrailingClosureElementList: ExpressibleByMultipleTrailingClosureElementList {
  public func createMultipleTrailingClosureElementList() -> MultipleTrailingClosureElementList {
    self
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
    calledExpression: ExpressibleByExprBuildable,
    leftParen: ExpressibleByTokenSyntax? = nil,
    argumentList: ExpressibleByTupleExprElementList,
    rightParen: ExpressibleByTokenSyntax? = nil,
    trailingClosure: ExpressibleByClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleByMultipleTrailingClosureElementList? = nil
  ) {
    self.calledExpression = calledExpression.createExprBuildable()
    self.leftParen = leftParen?.createTokenSyntax()
    self.argumentList = argumentList.createTupleExprElementList()
    self.rightParen = rightParen?.createTokenSyntax()
    self.trailingClosure = trailingClosure?.createClosureExpr()
    self.additionalTrailingClosures = additionalTrailingClosures?.createMultipleTrailingClosureElementList()
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
      return functionCallExpr.withLeadingTrivia(leadingTrivia + (functionCallExpr.leadingTrivia ?? []))
    }

    return functionCallExpr
  }

  /// Conformance for `FunctionCallExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let functionCallExpr = buildFunctionCallExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(functionCallExpr)
  }
}

public protocol ExpressibleByFunctionCallExpr {
  func createFunctionCallExpr() -> FunctionCallExpr
}

extension FunctionCallExpr: ExpressibleByFunctionCallExpr {
  public func createFunctionCallExpr() -> FunctionCallExpr {
    self
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
    calledExpression: ExpressibleByExprBuildable,
    leftBracket: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    argumentList: ExpressibleByTupleExprElementList,
    rightBracket: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ExpressibleByClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleByMultipleTrailingClosureElementList? = nil
  ) {
    self.calledExpression = calledExpression.createExprBuildable()
    self.leftBracket = leftBracket.createTokenSyntax()
    self.argumentList = argumentList.createTupleExprElementList()
    self.rightBracket = rightBracket.createTokenSyntax()
    self.trailingClosure = trailingClosure?.createClosureExpr()
    self.additionalTrailingClosures = additionalTrailingClosures?.createMultipleTrailingClosureElementList()
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
      return subscriptExpr.withLeadingTrivia(leadingTrivia + (subscriptExpr.leadingTrivia ?? []))
    }

    return subscriptExpr
  }

  /// Conformance for `SubscriptExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let subscriptExpr = buildSubscriptExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(subscriptExpr)
  }
}

public protocol ExpressibleBySubscriptExpr {
  func createSubscriptExpr() -> SubscriptExpr
}

extension SubscriptExpr: ExpressibleBySubscriptExpr {
  public func createSubscriptExpr() -> SubscriptExpr {
    self
  }
}

public struct OptionalChainingExpr: ExprBuildable {
  let expression: ExprBuildable
  let questionMark: TokenSyntax

  public init(
    expression: ExpressibleByExprBuildable,
    questionMark: ExpressibleByTokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.expression = expression.createExprBuildable()
    self.questionMark = questionMark.createTokenSyntax()
  }
  
  func buildOptionalChainingExpr(format: Format, leadingTrivia: Trivia? = nil) -> OptionalChainingExprSyntax {
    let optionalChainingExpr = SyntaxFactory.makeOptionalChainingExpr(
      expression: expression.buildExpr(format: format),
      questionMark: questionMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return optionalChainingExpr.withLeadingTrivia(leadingTrivia + (optionalChainingExpr.leadingTrivia ?? []))
    }

    return optionalChainingExpr
  }

  /// Conformance for `OptionalChainingExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let optionalChainingExpr = buildOptionalChainingExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(optionalChainingExpr)
  }
}

public protocol ExpressibleByOptionalChainingExpr {
  func createOptionalChainingExpr() -> OptionalChainingExpr
}

extension OptionalChainingExpr: ExpressibleByOptionalChainingExpr {
  public func createOptionalChainingExpr() -> OptionalChainingExpr {
    self
  }
}

public struct ForcedValueExpr: ExprBuildable {
  let expression: ExprBuildable
  let exclamationMark: TokenSyntax

  public init(
    expression: ExpressibleByExprBuildable,
    exclamationMark: ExpressibleByTokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.expression = expression.createExprBuildable()
    self.exclamationMark = exclamationMark.createTokenSyntax()
  }
  
  func buildForcedValueExpr(format: Format, leadingTrivia: Trivia? = nil) -> ForcedValueExprSyntax {
    let forcedValueExpr = SyntaxFactory.makeForcedValueExpr(
      expression: expression.buildExpr(format: format),
      exclamationMark: exclamationMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return forcedValueExpr.withLeadingTrivia(leadingTrivia + (forcedValueExpr.leadingTrivia ?? []))
    }

    return forcedValueExpr
  }

  /// Conformance for `ForcedValueExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let forcedValueExpr = buildForcedValueExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(forcedValueExpr)
  }
}

public protocol ExpressibleByForcedValueExpr {
  func createForcedValueExpr() -> ForcedValueExpr
}

extension ForcedValueExpr: ExpressibleByForcedValueExpr {
  public func createForcedValueExpr() -> ForcedValueExpr {
    self
  }
}

public struct PostfixUnaryExpr: ExprBuildable {
  let expression: ExprBuildable
  let operatorToken: TokenSyntax

  public init(
    expression: ExpressibleByExprBuildable,
    operatorToken: ExpressibleByTokenSyntax
  ) {
    self.expression = expression.createExprBuildable()
    self.operatorToken = operatorToken.createTokenSyntax()
  }
  
  func buildPostfixUnaryExpr(format: Format, leadingTrivia: Trivia? = nil) -> PostfixUnaryExprSyntax {
    let postfixUnaryExpr = SyntaxFactory.makePostfixUnaryExpr(
      expression: expression.buildExpr(format: format),
      operatorToken: operatorToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return postfixUnaryExpr.withLeadingTrivia(leadingTrivia + (postfixUnaryExpr.leadingTrivia ?? []))
    }

    return postfixUnaryExpr
  }

  /// Conformance for `PostfixUnaryExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let postfixUnaryExpr = buildPostfixUnaryExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(postfixUnaryExpr)
  }
}

public protocol ExpressibleByPostfixUnaryExpr {
  func createPostfixUnaryExpr() -> PostfixUnaryExpr
}

extension PostfixUnaryExpr: ExpressibleByPostfixUnaryExpr {
  public func createPostfixUnaryExpr() -> PostfixUnaryExpr {
    self
  }
}

public struct SpecializeExpr: ExprBuildable {
  let expression: ExprBuildable
  let genericArgumentClause: GenericArgumentClause

  public init(
    expression: ExpressibleByExprBuildable,
    genericArgumentClause: ExpressibleByGenericArgumentClause
  ) {
    self.expression = expression.createExprBuildable()
    self.genericArgumentClause = genericArgumentClause.createGenericArgumentClause()
  }
  
  func buildSpecializeExpr(format: Format, leadingTrivia: Trivia? = nil) -> SpecializeExprSyntax {
    let specializeExpr = SyntaxFactory.makeSpecializeExpr(
      expression: expression.buildExpr(format: format),
      genericArgumentClause: genericArgumentClause.buildGenericArgumentClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return specializeExpr.withLeadingTrivia(leadingTrivia + (specializeExpr.leadingTrivia ?? []))
    }

    return specializeExpr
  }

  /// Conformance for `SpecializeExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let specializeExpr = buildSpecializeExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(specializeExpr)
  }
}

public protocol ExpressibleBySpecializeExpr {
  func createSpecializeExpr() -> SpecializeExpr
}

extension SpecializeExpr: ExpressibleBySpecializeExpr {
  public func createSpecializeExpr() -> SpecializeExpr {
    self
  }
}

public struct StringSegment: SyntaxBuildable {
  let content: TokenSyntax

  public init(
    content: ExpressibleByTokenSyntax
  ) {
    self.content = content.createTokenSyntax()
  }
  
  func buildStringSegment(format: Format, leadingTrivia: Trivia? = nil) -> StringSegmentSyntax {
    let stringSegment = SyntaxFactory.makeStringSegment(
      content: content
    )
    
    if let leadingTrivia = leadingTrivia {
      return stringSegment.withLeadingTrivia(leadingTrivia + (stringSegment.leadingTrivia ?? []))
    }

    return stringSegment
  }

  /// Conformance for `StringSegment` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let stringSegment = buildStringSegment(format: format, leadingTrivia: leadingTrivia)
    return Syntax(stringSegment)
  }
}

public protocol ExpressibleByStringSegment {
  func createStringSegment() -> StringSegment
}

extension StringSegment: ExpressibleByStringSegment {
  public func createStringSegment() -> StringSegment {
    self
  }
}

public struct ExpressionSegment: SyntaxBuildable {
  let backslash: TokenSyntax
  let delimiter: TokenSyntax?
  let leftParen: TokenSyntax
  let expressions: TupleExprElementList
  let rightParen: TokenSyntax

  public init(
    backslash: ExpressibleByTokenSyntax = TokenSyntax.`backslash`,
    delimiter: ExpressibleByTokenSyntax? = nil,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    expressions: ExpressibleByTupleExprElementList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`stringInterpolationAnchor`
  ) {
    self.backslash = backslash.createTokenSyntax()
    self.delimiter = delimiter?.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.expressions = expressions.createTupleExprElementList()
    self.rightParen = rightParen.createTokenSyntax()
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
      return expressionSegment.withLeadingTrivia(leadingTrivia + (expressionSegment.leadingTrivia ?? []))
    }

    return expressionSegment
  }

  /// Conformance for `ExpressionSegment` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let expressionSegment = buildExpressionSegment(format: format, leadingTrivia: leadingTrivia)
    return Syntax(expressionSegment)
  }
}

public protocol ExpressibleByExpressionSegment {
  func createExpressionSegment() -> ExpressionSegment
}

extension ExpressionSegment: ExpressibleByExpressionSegment {
  public func createExpressionSegment() -> ExpressionSegment {
    self
  }
}

public struct StringLiteralExpr: ExprBuildable {
  let openDelimiter: TokenSyntax?
  let openQuote: TokenSyntax
  let segments: StringLiteralSegments
  let closeQuote: TokenSyntax
  let closeDelimiter: TokenSyntax?

  public init(
    openDelimiter: ExpressibleByTokenSyntax? = nil,
    openQuote: ExpressibleByTokenSyntax,
    segments: ExpressibleByStringLiteralSegments,
    closeQuote: ExpressibleByTokenSyntax,
    closeDelimiter: ExpressibleByTokenSyntax? = nil
  ) {
    self.openDelimiter = openDelimiter?.createTokenSyntax()
    self.openQuote = openQuote.createTokenSyntax()
    self.segments = segments.createStringLiteralSegments()
    self.closeQuote = closeQuote.createTokenSyntax()
    self.closeDelimiter = closeDelimiter?.createTokenSyntax()
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
      return stringLiteralExpr.withLeadingTrivia(leadingTrivia + (stringLiteralExpr.leadingTrivia ?? []))
    }

    return stringLiteralExpr
  }

  /// Conformance for `StringLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let stringLiteralExpr = buildStringLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(stringLiteralExpr)
  }
}

public protocol ExpressibleByStringLiteralExpr {
  func createStringLiteralExpr() -> StringLiteralExpr
}

extension StringLiteralExpr: ExpressibleByStringLiteralExpr {
  public func createStringLiteralExpr() -> StringLiteralExpr {
    self
  }
}

public struct KeyPathExpr: ExprBuildable {
  let backslash: TokenSyntax
  let rootExpr: ExprBuildable?
  let expression: ExprBuildable

  public init(
    backslash: ExpressibleByTokenSyntax = TokenSyntax.`backslash`,
    rootExpr: ExpressibleByExprBuildable? = nil,
    expression: ExpressibleByExprBuildable
  ) {
    self.backslash = backslash.createTokenSyntax()
    self.rootExpr = rootExpr?.createExprBuildable()
    self.expression = expression.createExprBuildable()
  }
  
  func buildKeyPathExpr(format: Format, leadingTrivia: Trivia? = nil) -> KeyPathExprSyntax {
    let keyPathExpr = SyntaxFactory.makeKeyPathExpr(
      backslash: backslash,
      rootExpr: rootExpr?.buildExpr(format: format),
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return keyPathExpr.withLeadingTrivia(leadingTrivia + (keyPathExpr.leadingTrivia ?? []))
    }

    return keyPathExpr
  }

  /// Conformance for `KeyPathExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let keyPathExpr = buildKeyPathExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(keyPathExpr)
  }
}

public protocol ExpressibleByKeyPathExpr {
  func createKeyPathExpr() -> KeyPathExpr
}

extension KeyPathExpr: ExpressibleByKeyPathExpr {
  public func createKeyPathExpr() -> KeyPathExpr {
    self
  }
}

public struct KeyPathBaseExpr: ExprBuildable {
  let period: TokenSyntax

  public init(
    period: ExpressibleByTokenSyntax = TokenSyntax.`period`
  ) {
    self.period = period.createTokenSyntax()
  }
  
  func buildKeyPathBaseExpr(format: Format, leadingTrivia: Trivia? = nil) -> KeyPathBaseExprSyntax {
    let keyPathBaseExpr = SyntaxFactory.makeKeyPathBaseExpr(
      period: period
    )
    
    if let leadingTrivia = leadingTrivia {
      return keyPathBaseExpr.withLeadingTrivia(leadingTrivia + (keyPathBaseExpr.leadingTrivia ?? []))
    }

    return keyPathBaseExpr
  }

  /// Conformance for `KeyPathBaseExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let keyPathBaseExpr = buildKeyPathBaseExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(keyPathBaseExpr)
  }
}

public protocol ExpressibleByKeyPathBaseExpr {
  func createKeyPathBaseExpr() -> KeyPathBaseExpr
}

extension KeyPathBaseExpr: ExpressibleByKeyPathBaseExpr {
  public func createKeyPathBaseExpr() -> KeyPathBaseExpr {
    self
  }
}

public struct ObjcNamePiece: SyntaxBuildable {
  let name: TokenSyntax
  let dot: TokenSyntax?

  public init(
    name: ExpressibleByTokenSyntax,
    dot: ExpressibleByTokenSyntax? = nil
  ) {
    self.name = name.createTokenSyntax()
    self.dot = dot?.createTokenSyntax()
  }
  
  func buildObjcNamePiece(format: Format, leadingTrivia: Trivia? = nil) -> ObjcNamePieceSyntax {
    let objcNamePiece = SyntaxFactory.makeObjcNamePiece(
      name: name,
      dot: dot
    )
    
    if let leadingTrivia = leadingTrivia {
      return objcNamePiece.withLeadingTrivia(leadingTrivia + (objcNamePiece.leadingTrivia ?? []))
    }

    return objcNamePiece
  }

  /// Conformance for `ObjcNamePiece` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let objcNamePiece = buildObjcNamePiece(format: format, leadingTrivia: leadingTrivia)
    return Syntax(objcNamePiece)
  }
}

public protocol ExpressibleByObjcNamePiece {
  func createObjcNamePiece() -> ObjcNamePiece
}

extension ObjcNamePiece: ExpressibleByObjcNamePiece {
  public func createObjcNamePiece() -> ObjcNamePiece {
    self
  }
}

// MARK: - Syntax collection

/// `ObjcName` represents a collection of 
/// `ObjcNamePiece`s.
public struct ObjcName: SyntaxBuildable {
  let elements: [ObjcNamePiece]

  public init(_ elements: [ExpressibleByObjcNamePiece]) {
    self.elements = elements.map { $0.createObjcNamePiece() }
  }

  public func buildObjcName(format: Format) -> ObjcNameSyntax {
    return SyntaxFactory.makeObjcName(elements.map {
      $0.buildObjcNamePiece(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let objcName = buildObjcName(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(objcName).withLeadingTrivia(leadingTrivia + (objcName.leadingTrivia ?? []))
    }

    return Syntax(objcName)
  }
}

public protocol ExpressibleByObjcName {
  func createObjcName() -> ObjcName
}

extension ObjcName: ExpressibleByObjcName {
  public func createObjcName() -> ObjcName {
    self
  }
}

public struct ObjcKeyPathExpr: ExprBuildable {
  let keyPath: TokenSyntax
  let leftParen: TokenSyntax
  let name: ObjcName
  let rightParen: TokenSyntax

  public init(
    keyPath: ExpressibleByTokenSyntax = TokenSyntax.`poundKeyPath`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    name: ExpressibleByObjcName,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.keyPath = keyPath.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.name = name.createObjcName()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildObjcKeyPathExpr(format: Format, leadingTrivia: Trivia? = nil) -> ObjcKeyPathExprSyntax {
    let objcKeyPathExpr = SyntaxFactory.makeObjcKeyPathExpr(
      keyPath: keyPath,
      leftParen: leftParen,
      name: name.buildObjcName(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return objcKeyPathExpr.withLeadingTrivia(leadingTrivia + (objcKeyPathExpr.leadingTrivia ?? []))
    }

    return objcKeyPathExpr
  }

  /// Conformance for `ObjcKeyPathExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let objcKeyPathExpr = buildObjcKeyPathExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(objcKeyPathExpr)
  }
}

public protocol ExpressibleByObjcKeyPathExpr {
  func createObjcKeyPathExpr() -> ObjcKeyPathExpr
}

extension ObjcKeyPathExpr: ExpressibleByObjcKeyPathExpr {
  public func createObjcKeyPathExpr() -> ObjcKeyPathExpr {
    self
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
    poundSelector: ExpressibleByTokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    kind: ExpressibleByTokenSyntax? = nil,
    colon: ExpressibleByTokenSyntax? = nil,
    name: ExpressibleByExprBuildable,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundSelector = poundSelector.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.kind = kind?.createTokenSyntax()
    self.colon = colon?.createTokenSyntax()
    self.name = name.createExprBuildable()
    self.rightParen = rightParen.createTokenSyntax()
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
      return objcSelectorExpr.withLeadingTrivia(leadingTrivia + (objcSelectorExpr.leadingTrivia ?? []))
    }

    return objcSelectorExpr
  }

  /// Conformance for `ObjcSelectorExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let objcSelectorExpr = buildObjcSelectorExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(objcSelectorExpr)
  }
}

public protocol ExpressibleByObjcSelectorExpr {
  func createObjcSelectorExpr() -> ObjcSelectorExpr
}

extension ObjcSelectorExpr: ExpressibleByObjcSelectorExpr {
  public func createObjcSelectorExpr() -> ObjcSelectorExpr {
    self
  }
}

public struct PostfixIfConfigExpr: ExprBuildable {
  let base: ExprBuildable?
  let config: IfConfigDecl

  public init(
    base: ExpressibleByExprBuildable? = nil,
    config: ExpressibleByIfConfigDecl
  ) {
    self.base = base?.createExprBuildable()
    self.config = config.createIfConfigDecl()
  }
  
  func buildPostfixIfConfigExpr(format: Format, leadingTrivia: Trivia? = nil) -> PostfixIfConfigExprSyntax {
    let postfixIfConfigExpr = SyntaxFactory.makePostfixIfConfigExpr(
      base: base?.buildExpr(format: format),
      config: config.buildIfConfigDecl(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return postfixIfConfigExpr.withLeadingTrivia(leadingTrivia + (postfixIfConfigExpr.leadingTrivia ?? []))
    }

    return postfixIfConfigExpr
  }

  /// Conformance for `PostfixIfConfigExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let postfixIfConfigExpr = buildPostfixIfConfigExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(postfixIfConfigExpr)
  }
}

public protocol ExpressibleByPostfixIfConfigExpr {
  func createPostfixIfConfigExpr() -> PostfixIfConfigExpr
}

extension PostfixIfConfigExpr: ExpressibleByPostfixIfConfigExpr {
  public func createPostfixIfConfigExpr() -> PostfixIfConfigExpr {
    self
  }
}

public struct EditorPlaceholderExpr: ExprBuildable {
  let identifier: TokenSyntax

  public init(
    identifier: ExpressibleByTokenSyntax
  ) {
    self.identifier = identifier.createTokenSyntax()
  }
  
  func buildEditorPlaceholderExpr(format: Format, leadingTrivia: Trivia? = nil) -> EditorPlaceholderExprSyntax {
    let editorPlaceholderExpr = SyntaxFactory.makeEditorPlaceholderExpr(
      identifier: identifier
    )
    
    if let leadingTrivia = leadingTrivia {
      return editorPlaceholderExpr.withLeadingTrivia(leadingTrivia + (editorPlaceholderExpr.leadingTrivia ?? []))
    }

    return editorPlaceholderExpr
  }

  /// Conformance for `EditorPlaceholderExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let editorPlaceholderExpr = buildEditorPlaceholderExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(editorPlaceholderExpr)
  }
}

public protocol ExpressibleByEditorPlaceholderExpr {
  func createEditorPlaceholderExpr() -> EditorPlaceholderExpr
}

extension EditorPlaceholderExpr: ExpressibleByEditorPlaceholderExpr {
  public func createEditorPlaceholderExpr() -> EditorPlaceholderExpr {
    self
  }
}

public struct ObjectLiteralExpr: ExprBuildable {
  let identifier: TokenSyntax
  let leftParen: TokenSyntax
  let arguments: TupleExprElementList
  let rightParen: TokenSyntax

  public init(
    identifier: ExpressibleByTokenSyntax,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleByTupleExprElementList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.identifier = identifier.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.arguments = arguments.createTupleExprElementList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildObjectLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> ObjectLiteralExprSyntax {
    let objectLiteralExpr = SyntaxFactory.makeObjectLiteralExpr(
      identifier: identifier,
      leftParen: leftParen,
      arguments: arguments.buildTupleExprElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return objectLiteralExpr.withLeadingTrivia(leadingTrivia + (objectLiteralExpr.leadingTrivia ?? []))
    }

    return objectLiteralExpr
  }

  /// Conformance for `ObjectLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let objectLiteralExpr = buildObjectLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(objectLiteralExpr)
  }
}

public protocol ExpressibleByObjectLiteralExpr {
  func createObjectLiteralExpr() -> ObjectLiteralExpr
}

extension ObjectLiteralExpr: ExpressibleByObjectLiteralExpr {
  public func createObjectLiteralExpr() -> ObjectLiteralExpr {
    self
  }
}

public struct TypeInitializerClause: SyntaxBuildable {
  let equal: TokenSyntax
  let value: TypeBuildable

  public init(
    equal: ExpressibleByTokenSyntax = TokenSyntax.`equal`,
    value: ExpressibleByTypeBuildable
  ) {
    self.equal = equal.createTokenSyntax()
    self.value = value.createTypeBuildable()
  }
  
  func buildTypeInitializerClause(format: Format, leadingTrivia: Trivia? = nil) -> TypeInitializerClauseSyntax {
    let typeInitializerClause = SyntaxFactory.makeTypeInitializerClause(
      equal: equal,
      value: value.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typeInitializerClause.withLeadingTrivia(leadingTrivia + (typeInitializerClause.leadingTrivia ?? []))
    }

    return typeInitializerClause
  }

  /// Conformance for `TypeInitializerClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let typeInitializerClause = buildTypeInitializerClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(typeInitializerClause)
  }
}

public protocol ExpressibleByTypeInitializerClause {
  func createTypeInitializerClause() -> TypeInitializerClause
}

extension TypeInitializerClause: ExpressibleByTypeInitializerClause {
  public func createTypeInitializerClause() -> TypeInitializerClause {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    typealiasKeyword: ExpressibleByTokenSyntax = TokenSyntax.`typealias`,
    identifier: ExpressibleByTokenSyntax,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    initializer: ExpressibleByTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.typealiasKeyword = typealiasKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.initializer = initializer?.createTypeInitializerClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
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
      return typealiasDecl.withLeadingTrivia(leadingTrivia + (typealiasDecl.leadingTrivia ?? []))
    }

    return typealiasDecl
  }

  /// Conformance for `TypealiasDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let typealiasDecl = buildTypealiasDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(typealiasDecl)
  }
}

public protocol ExpressibleByTypealiasDecl {
  func createTypealiasDecl() -> TypealiasDecl
}

extension TypealiasDecl: ExpressibleByTypealiasDecl {
  public func createTypealiasDecl() -> TypealiasDecl {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    associatedtypeKeyword: ExpressibleByTokenSyntax = TokenSyntax.`associatedtype`,
    identifier: ExpressibleByTokenSyntax,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    initializer: ExpressibleByTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.associatedtypeKeyword = associatedtypeKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.initializer = initializer?.createTypeInitializerClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
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
      return associatedtypeDecl.withLeadingTrivia(leadingTrivia + (associatedtypeDecl.leadingTrivia ?? []))
    }

    return associatedtypeDecl
  }

  /// Conformance for `AssociatedtypeDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let associatedtypeDecl = buildAssociatedtypeDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(associatedtypeDecl)
  }
}

public protocol ExpressibleByAssociatedtypeDecl {
  func createAssociatedtypeDecl() -> AssociatedtypeDecl
}

extension AssociatedtypeDecl: ExpressibleByAssociatedtypeDecl {
  public func createAssociatedtypeDecl() -> AssociatedtypeDecl {
    self
  }
}

// MARK: - Syntax collection

/// `FunctionParameterList` represents a collection of 
/// `FunctionParameter`s.
public struct FunctionParameterList: SyntaxBuildable {
  let elements: [FunctionParameter]

  public init(_ elements: [ExpressibleByFunctionParameter]) {
    self.elements = elements.map { $0.createFunctionParameter() }
  }

  public func buildFunctionParameterList(format: Format) -> FunctionParameterListSyntax {
    return SyntaxFactory.makeFunctionParameterList(elements.map {
      $0.buildFunctionParameter(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let functionParameterList = buildFunctionParameterList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(functionParameterList).withLeadingTrivia(leadingTrivia + (functionParameterList.leadingTrivia ?? []))
    }

    return Syntax(functionParameterList)
  }
}

public protocol ExpressibleByFunctionParameterList {
  func createFunctionParameterList() -> FunctionParameterList
}

extension FunctionParameterList: ExpressibleByFunctionParameterList {
  public func createFunctionParameterList() -> FunctionParameterList {
    self
  }
}

public struct ParameterClause: SyntaxBuildable {
  let leftParen: TokenSyntax
  let parameterList: FunctionParameterList
  let rightParen: TokenSyntax

  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    parameterList: ExpressibleByFunctionParameterList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.parameterList = parameterList.createFunctionParameterList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildParameterClause(format: Format, leadingTrivia: Trivia? = nil) -> ParameterClauseSyntax {
    let parameterClause = SyntaxFactory.makeParameterClause(
      leftParen: leftParen,
      parameterList: parameterList.buildFunctionParameterList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return parameterClause.withLeadingTrivia(leadingTrivia + (parameterClause.leadingTrivia ?? []))
    }

    return parameterClause
  }

  /// Conformance for `ParameterClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let parameterClause = buildParameterClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(parameterClause)
  }
}

public protocol ExpressibleByParameterClause {
  func createParameterClause() -> ParameterClause
}

extension ParameterClause: ExpressibleByParameterClause {
  public func createParameterClause() -> ParameterClause {
    self
  }
}

public struct ReturnClause: SyntaxBuildable {
  let arrow: TokenSyntax
  let returnType: TypeBuildable

  public init(
    arrow: ExpressibleByTokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleByTypeBuildable
  ) {
    self.arrow = arrow.createTokenSyntax()
    self.returnType = returnType.createTypeBuildable()
  }
  
  func buildReturnClause(format: Format, leadingTrivia: Trivia? = nil) -> ReturnClauseSyntax {
    let returnClause = SyntaxFactory.makeReturnClause(
      arrow: arrow,
      returnType: returnType.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return returnClause.withLeadingTrivia(leadingTrivia + (returnClause.leadingTrivia ?? []))
    }

    return returnClause
  }

  /// Conformance for `ReturnClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let returnClause = buildReturnClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(returnClause)
  }
}

public protocol ExpressibleByReturnClause {
  func createReturnClause() -> ReturnClause
}

extension ReturnClause: ExpressibleByReturnClause {
  public func createReturnClause() -> ReturnClause {
    self
  }
}

public struct FunctionSignature: SyntaxBuildable {
  let input: ParameterClause
  let asyncOrReasyncKeyword: TokenSyntax?
  let throwsOrRethrowsKeyword: TokenSyntax?
  let output: ReturnClause?

  public init(
    input: ExpressibleByParameterClause,
    asyncOrReasyncKeyword: ExpressibleByTokenSyntax? = nil,
    throwsOrRethrowsKeyword: ExpressibleByTokenSyntax? = nil,
    output: ExpressibleByReturnClause? = nil
  ) {
    self.input = input.createParameterClause()
    self.asyncOrReasyncKeyword = asyncOrReasyncKeyword?.createTokenSyntax()
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword?.createTokenSyntax()
    self.output = output?.createReturnClause()
  }
  
  func buildFunctionSignature(format: Format, leadingTrivia: Trivia? = nil) -> FunctionSignatureSyntax {
    let functionSignature = SyntaxFactory.makeFunctionSignature(
      input: input.buildParameterClause(format: format),
      asyncOrReasyncKeyword: asyncOrReasyncKeyword,
      throwsOrRethrowsKeyword: throwsOrRethrowsKeyword,
      output: output?.buildReturnClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return functionSignature.withLeadingTrivia(leadingTrivia + (functionSignature.leadingTrivia ?? []))
    }

    return functionSignature
  }

  /// Conformance for `FunctionSignature` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let functionSignature = buildFunctionSignature(format: format, leadingTrivia: leadingTrivia)
    return Syntax(functionSignature)
  }
}

public protocol ExpressibleByFunctionSignature {
  func createFunctionSignature() -> FunctionSignature
}

extension FunctionSignature: ExpressibleByFunctionSignature {
  public func createFunctionSignature() -> FunctionSignature {
    self
  }
}

public struct IfConfigClause: SyntaxBuildable {
  let poundKeyword: TokenSyntax
  let condition: ExprBuildable?
  let elements: SyntaxBuildable

  public init(
    poundKeyword: ExpressibleByTokenSyntax,
    condition: ExpressibleByExprBuildable? = nil,
    elements: ExpressibleBySyntaxBuildable
  ) {
    self.poundKeyword = poundKeyword.createTokenSyntax()
    self.condition = condition?.createExprBuildable()
    self.elements = elements.createSyntaxBuildable()
  }
  
  func buildIfConfigClause(format: Format, leadingTrivia: Trivia? = nil) -> IfConfigClauseSyntax {
    let ifConfigClause = SyntaxFactory.makeIfConfigClause(
      poundKeyword: poundKeyword,
      condition: condition?.buildExpr(format: format),
      elements: elements.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return ifConfigClause.withLeadingTrivia(leadingTrivia + (ifConfigClause.leadingTrivia ?? []))
    }

    return ifConfigClause
  }

  /// Conformance for `IfConfigClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let ifConfigClause = buildIfConfigClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(ifConfigClause)
  }
}

public protocol ExpressibleByIfConfigClause {
  func createIfConfigClause() -> IfConfigClause
}

extension IfConfigClause: ExpressibleByIfConfigClause {
  public func createIfConfigClause() -> IfConfigClause {
    self
  }
}

// MARK: - Syntax collection

/// `IfConfigClauseList` represents a collection of 
/// `IfConfigClause`s.
public struct IfConfigClauseList: SyntaxBuildable {
  let elements: [IfConfigClause]

  public init(_ elements: [ExpressibleByIfConfigClause]) {
    self.elements = elements.map { $0.createIfConfigClause() }
  }

  public func buildIfConfigClauseList(format: Format) -> IfConfigClauseListSyntax {
    return SyntaxFactory.makeIfConfigClauseList(elements.map {
      $0.buildIfConfigClause(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let ifConfigClauseList = buildIfConfigClauseList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(ifConfigClauseList).withLeadingTrivia(leadingTrivia + (ifConfigClauseList.leadingTrivia ?? []))
    }

    return Syntax(ifConfigClauseList)
  }
}

public protocol ExpressibleByIfConfigClauseList {
  func createIfConfigClauseList() -> IfConfigClauseList
}

extension IfConfigClauseList: ExpressibleByIfConfigClauseList {
  public func createIfConfigClauseList() -> IfConfigClauseList {
    self
  }
}

public struct IfConfigDecl: DeclBuildable {
  let clauses: IfConfigClauseList
  let poundEndif: TokenSyntax

  public init(
    clauses: ExpressibleByIfConfigClauseList,
    poundEndif: ExpressibleByTokenSyntax = TokenSyntax.`poundEndif`
  ) {
    self.clauses = clauses.createIfConfigClauseList()
    self.poundEndif = poundEndif.createTokenSyntax()
  }
  
  func buildIfConfigDecl(format: Format, leadingTrivia: Trivia? = nil) -> IfConfigDeclSyntax {
    let ifConfigDecl = SyntaxFactory.makeIfConfigDecl(
      clauses: clauses.buildIfConfigClauseList(format: format),
      poundEndif: poundEndif
    )
    
    if let leadingTrivia = leadingTrivia {
      return ifConfigDecl.withLeadingTrivia(leadingTrivia + (ifConfigDecl.leadingTrivia ?? []))
    }

    return ifConfigDecl
  }

  /// Conformance for `IfConfigDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let ifConfigDecl = buildIfConfigDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(ifConfigDecl)
  }
}

public protocol ExpressibleByIfConfigDecl {
  func createIfConfigDecl() -> IfConfigDecl
}

extension IfConfigDecl: ExpressibleByIfConfigDecl {
  public func createIfConfigDecl() -> IfConfigDecl {
    self
  }
}

public struct PoundErrorDecl: DeclBuildable {
  let poundError: TokenSyntax
  let leftParen: TokenSyntax
  let message: StringLiteralExpr
  let rightParen: TokenSyntax

  public init(
    poundError: ExpressibleByTokenSyntax = TokenSyntax.`poundError`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    message: ExpressibleByStringLiteralExpr,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundError = poundError.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.message = message.createStringLiteralExpr()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildPoundErrorDecl(format: Format, leadingTrivia: Trivia? = nil) -> PoundErrorDeclSyntax {
    let poundErrorDecl = SyntaxFactory.makePoundErrorDecl(
      poundError: poundError,
      leftParen: leftParen,
      message: message.buildStringLiteralExpr(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundErrorDecl.withLeadingTrivia(leadingTrivia + (poundErrorDecl.leadingTrivia ?? []))
    }

    return poundErrorDecl
  }

  /// Conformance for `PoundErrorDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let poundErrorDecl = buildPoundErrorDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(poundErrorDecl)
  }
}

public protocol ExpressibleByPoundErrorDecl {
  func createPoundErrorDecl() -> PoundErrorDecl
}

extension PoundErrorDecl: ExpressibleByPoundErrorDecl {
  public func createPoundErrorDecl() -> PoundErrorDecl {
    self
  }
}

public struct PoundWarningDecl: DeclBuildable {
  let poundWarning: TokenSyntax
  let leftParen: TokenSyntax
  let message: StringLiteralExpr
  let rightParen: TokenSyntax

  public init(
    poundWarning: ExpressibleByTokenSyntax = TokenSyntax.`poundWarning`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    message: ExpressibleByStringLiteralExpr,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundWarning = poundWarning.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.message = message.createStringLiteralExpr()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildPoundWarningDecl(format: Format, leadingTrivia: Trivia? = nil) -> PoundWarningDeclSyntax {
    let poundWarningDecl = SyntaxFactory.makePoundWarningDecl(
      poundWarning: poundWarning,
      leftParen: leftParen,
      message: message.buildStringLiteralExpr(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundWarningDecl.withLeadingTrivia(leadingTrivia + (poundWarningDecl.leadingTrivia ?? []))
    }

    return poundWarningDecl
  }

  /// Conformance for `PoundWarningDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let poundWarningDecl = buildPoundWarningDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(poundWarningDecl)
  }
}

public protocol ExpressibleByPoundWarningDecl {
  func createPoundWarningDecl() -> PoundWarningDecl
}

extension PoundWarningDecl: ExpressibleByPoundWarningDecl {
  public func createPoundWarningDecl() -> PoundWarningDecl {
    self
  }
}

public struct PoundSourceLocation: DeclBuildable {
  let poundSourceLocation: TokenSyntax
  let leftParen: TokenSyntax
  let args: PoundSourceLocationArgs?
  let rightParen: TokenSyntax

  public init(
    poundSourceLocation: ExpressibleByTokenSyntax = TokenSyntax.`poundSourceLocation`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    args: ExpressibleByPoundSourceLocationArgs? = nil,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundSourceLocation = poundSourceLocation.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.args = args?.createPoundSourceLocationArgs()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildPoundSourceLocation(format: Format, leadingTrivia: Trivia? = nil) -> PoundSourceLocationSyntax {
    let poundSourceLocation = SyntaxFactory.makePoundSourceLocation(
      poundSourceLocation: poundSourceLocation,
      leftParen: leftParen,
      args: args?.buildPoundSourceLocationArgs(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return poundSourceLocation.withLeadingTrivia(leadingTrivia + (poundSourceLocation.leadingTrivia ?? []))
    }

    return poundSourceLocation
  }

  /// Conformance for `PoundSourceLocation` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let poundSourceLocation = buildPoundSourceLocation(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(poundSourceLocation)
  }
}

public protocol ExpressibleByPoundSourceLocation {
  func createPoundSourceLocation() -> PoundSourceLocation
}

extension PoundSourceLocation: ExpressibleByPoundSourceLocation {
  public func createPoundSourceLocation() -> PoundSourceLocation {
    self
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
    fileArgLabel: ExpressibleByTokenSyntax,
    fileArgColon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    fileName: ExpressibleByTokenSyntax,
    comma: ExpressibleByTokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: ExpressibleByTokenSyntax,
    lineArgColon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    lineNumber: ExpressibleByTokenSyntax
  ) {
    self.fileArgLabel = fileArgLabel.createTokenSyntax()
    self.fileArgColon = fileArgColon.createTokenSyntax()
    self.fileName = fileName.createTokenSyntax()
    self.comma = comma.createTokenSyntax()
    self.lineArgLabel = lineArgLabel.createTokenSyntax()
    self.lineArgColon = lineArgColon.createTokenSyntax()
    self.lineNumber = lineNumber.createTokenSyntax()
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
      return poundSourceLocationArgs.withLeadingTrivia(leadingTrivia + (poundSourceLocationArgs.leadingTrivia ?? []))
    }

    return poundSourceLocationArgs
  }

  /// Conformance for `PoundSourceLocationArgs` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let poundSourceLocationArgs = buildPoundSourceLocationArgs(format: format, leadingTrivia: leadingTrivia)
    return Syntax(poundSourceLocationArgs)
  }
}

public protocol ExpressibleByPoundSourceLocationArgs {
  func createPoundSourceLocationArgs() -> PoundSourceLocationArgs
}

extension PoundSourceLocationArgs: ExpressibleByPoundSourceLocationArgs {
  public func createPoundSourceLocationArgs() -> PoundSourceLocationArgs {
    self
  }
}

public struct DeclModifier: SyntaxBuildable {
  let name: TokenSyntax
  let detailLeftParen: TokenSyntax?
  let detail: TokenSyntax?
  let detailRightParen: TokenSyntax?

  public init(
    name: ExpressibleByTokenSyntax,
    detailLeftParen: ExpressibleByTokenSyntax? = nil,
    detail: ExpressibleByTokenSyntax? = nil,
    detailRightParen: ExpressibleByTokenSyntax? = nil
  ) {
    self.name = name.createTokenSyntax()
    self.detailLeftParen = detailLeftParen?.createTokenSyntax()
    self.detail = detail?.createTokenSyntax()
    self.detailRightParen = detailRightParen?.createTokenSyntax()
  }
  
  func buildDeclModifier(format: Format, leadingTrivia: Trivia? = nil) -> DeclModifierSyntax {
    let declModifier = SyntaxFactory.makeDeclModifier(
      name: name,
      detailLeftParen: detailLeftParen,
      detail: detail,
      detailRightParen: detailRightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return declModifier.withLeadingTrivia(leadingTrivia + (declModifier.leadingTrivia ?? []))
    }

    return declModifier
  }

  /// Conformance for `DeclModifier` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declModifier = buildDeclModifier(format: format, leadingTrivia: leadingTrivia)
    return Syntax(declModifier)
  }
}

public protocol ExpressibleByDeclModifier {
  func createDeclModifier() -> DeclModifier
}

extension DeclModifier: ExpressibleByDeclModifier {
  public func createDeclModifier() -> DeclModifier {
    self
  }
}

public struct InheritedType: SyntaxBuildable {
  let typeName: TypeBuildable
  let trailingComma: TokenSyntax?

  public init(
    typeName: ExpressibleByTypeBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.typeName = typeName.createTypeBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildInheritedType(format: Format, leadingTrivia: Trivia? = nil) -> InheritedTypeSyntax {
    let inheritedType = SyntaxFactory.makeInheritedType(
      typeName: typeName.buildType(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return inheritedType.withLeadingTrivia(leadingTrivia + (inheritedType.leadingTrivia ?? []))
    }

    return inheritedType
  }

  /// Conformance for `InheritedType` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let inheritedType = buildInheritedType(format: format, leadingTrivia: leadingTrivia)
    return Syntax(inheritedType)
  }
}

public protocol ExpressibleByInheritedType {
  func createInheritedType() -> InheritedType
}

extension InheritedType: ExpressibleByInheritedType {
  public func createInheritedType() -> InheritedType {
    self
  }
}

// MARK: - Syntax collection

/// `InheritedTypeList` represents a collection of 
/// `InheritedType`s.
public struct InheritedTypeList: SyntaxBuildable {
  let elements: [InheritedType]

  public init(_ elements: [ExpressibleByInheritedType]) {
    self.elements = elements.map { $0.createInheritedType() }
  }

  public func buildInheritedTypeList(format: Format) -> InheritedTypeListSyntax {
    return SyntaxFactory.makeInheritedTypeList(elements.map {
      $0.buildInheritedType(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let inheritedTypeList = buildInheritedTypeList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(inheritedTypeList).withLeadingTrivia(leadingTrivia + (inheritedTypeList.leadingTrivia ?? []))
    }

    return Syntax(inheritedTypeList)
  }
}

public protocol ExpressibleByInheritedTypeList {
  func createInheritedTypeList() -> InheritedTypeList
}

extension InheritedTypeList: ExpressibleByInheritedTypeList {
  public func createInheritedTypeList() -> InheritedTypeList {
    self
  }
}

public struct TypeInheritanceClause: SyntaxBuildable {
  let colon: TokenSyntax
  let inheritedTypeCollection: InheritedTypeList

  public init(
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    inheritedTypeCollection: ExpressibleByInheritedTypeList
  ) {
    self.colon = colon.createTokenSyntax()
    self.inheritedTypeCollection = inheritedTypeCollection.createInheritedTypeList()
  }
  
  func buildTypeInheritanceClause(format: Format, leadingTrivia: Trivia? = nil) -> TypeInheritanceClauseSyntax {
    let typeInheritanceClause = SyntaxFactory.makeTypeInheritanceClause(
      colon: colon,
      inheritedTypeCollection: inheritedTypeCollection.buildInheritedTypeList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typeInheritanceClause.withLeadingTrivia(leadingTrivia + (typeInheritanceClause.leadingTrivia ?? []))
    }

    return typeInheritanceClause
  }

  /// Conformance for `TypeInheritanceClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let typeInheritanceClause = buildTypeInheritanceClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(typeInheritanceClause)
  }
}

public protocol ExpressibleByTypeInheritanceClause {
  func createTypeInheritanceClause() -> TypeInheritanceClause
}

extension TypeInheritanceClause: ExpressibleByTypeInheritanceClause {
  public func createTypeInheritanceClause() -> TypeInheritanceClause {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    classOrActorKeyword: ExpressibleByTokenSyntax,
    identifier: ExpressibleByTokenSyntax,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.classOrActorKeyword = classOrActorKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
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
      return classDecl.withLeadingTrivia(leadingTrivia + (classDecl.leadingTrivia ?? []))
    }

    return classDecl
  }

  /// Conformance for `ClassDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let classDecl = buildClassDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(classDecl)
  }
}

public protocol ExpressibleByClassDecl {
  func createClassDecl() -> ClassDecl
}

extension ClassDecl: ExpressibleByClassDecl {
  public func createClassDecl() -> ClassDecl {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    structKeyword: ExpressibleByTokenSyntax = TokenSyntax.`struct`,
    identifier: ExpressibleByTokenSyntax,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.structKeyword = structKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
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
      return structDecl.withLeadingTrivia(leadingTrivia + (structDecl.leadingTrivia ?? []))
    }

    return structDecl
  }

  /// Conformance for `StructDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let structDecl = buildStructDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(structDecl)
  }
}

public protocol ExpressibleByStructDecl {
  func createStructDecl() -> StructDecl
}

extension StructDecl: ExpressibleByStructDecl {
  public func createStructDecl() -> StructDecl {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    protocolKeyword: ExpressibleByTokenSyntax = TokenSyntax.`protocol`,
    identifier: ExpressibleByTokenSyntax,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.protocolKeyword = protocolKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
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
      return protocolDecl.withLeadingTrivia(leadingTrivia + (protocolDecl.leadingTrivia ?? []))
    }

    return protocolDecl
  }

  /// Conformance for `ProtocolDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let protocolDecl = buildProtocolDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(protocolDecl)
  }
}

public protocol ExpressibleByProtocolDecl {
  func createProtocolDecl() -> ProtocolDecl
}

extension ProtocolDecl: ExpressibleByProtocolDecl {
  public func createProtocolDecl() -> ProtocolDecl {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    extensionKeyword: ExpressibleByTokenSyntax = TokenSyntax.`extension`,
    extendedType: ExpressibleByTypeBuildable,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.extensionKeyword = extensionKeyword.createTokenSyntax()
    self.extendedType = extendedType.createTypeBuildable()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
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
      return extensionDecl.withLeadingTrivia(leadingTrivia + (extensionDecl.leadingTrivia ?? []))
    }

    return extensionDecl
  }

  /// Conformance for `ExtensionDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let extensionDecl = buildExtensionDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(extensionDecl)
  }
}

public protocol ExpressibleByExtensionDecl {
  func createExtensionDecl() -> ExtensionDecl
}

extension ExtensionDecl: ExpressibleByExtensionDecl {
  public func createExtensionDecl() -> ExtensionDecl {
    self
  }
}

public struct MemberDeclBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let members: MemberDeclList
  let rightBrace: TokenSyntax

  public init(
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    members: ExpressibleByMemberDeclList,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace.createTokenSyntax()
    self.members = members.createMemberDeclList()
    self.rightBrace = rightBrace.createTokenSyntax()
  }
  
  func buildMemberDeclBlock(format: Format, leadingTrivia: Trivia? = nil) -> MemberDeclBlockSyntax {
    let memberDeclBlock = SyntaxFactory.makeMemberDeclBlock(
      leftBrace: leftBrace,
      members: members.buildMemberDeclList(format: format._indented()),
      rightBrace: rightBrace.withLeadingTrivia(.newlines(1) + format._makeIndent() + (rightBrace.leadingTrivia ?? []))
    )
    
    if let leadingTrivia = leadingTrivia {
      return memberDeclBlock.withLeadingTrivia(leadingTrivia + (memberDeclBlock.leadingTrivia ?? []))
    }

    return memberDeclBlock
  }

  /// Conformance for `MemberDeclBlock` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let memberDeclBlock = buildMemberDeclBlock(format: format, leadingTrivia: leadingTrivia)
    return Syntax(memberDeclBlock)
  }
}

public protocol ExpressibleByMemberDeclBlock {
  func createMemberDeclBlock() -> MemberDeclBlock
}

extension MemberDeclBlock: ExpressibleByMemberDeclBlock {
  public func createMemberDeclBlock() -> MemberDeclBlock {
    self
  }
}

// MARK: - Syntax collection

/// `MemberDeclList` represents a collection of 
/// `MemberDeclListItem`s.
public struct MemberDeclList: SyntaxBuildable {
  let elements: [MemberDeclListItem]

  public init(_ elements: [ExpressibleByMemberDeclListItem]) {
    self.elements = elements.map { $0.createMemberDeclListItem() }
  }

  public func buildMemberDeclList(format: Format) -> MemberDeclListSyntax {
    return SyntaxFactory.makeMemberDeclList(elements.map {
      $0.buildMemberDeclListItem(format: format, leadingTrivia: .newlines(1) + format._makeIndent())
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let memberDeclList = buildMemberDeclList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(memberDeclList).withLeadingTrivia(leadingTrivia + (memberDeclList.leadingTrivia ?? []))
    }

    return Syntax(memberDeclList)
  }
}

public protocol ExpressibleByMemberDeclList {
  func createMemberDeclList() -> MemberDeclList
}

extension MemberDeclList: ExpressibleByMemberDeclList {
  public func createMemberDeclList() -> MemberDeclList {
    self
  }
}

/// 
/// A member declaration of a type consisting of a declaration and an
/// optional semicolon;
/// 
public struct MemberDeclListItem: SyntaxBuildable {
  let decl: DeclBuildable
  let semicolon: TokenSyntax?

  public init(
    decl: ExpressibleByDeclBuildable,
    semicolon: ExpressibleByTokenSyntax? = nil
  ) {
    self.decl = decl.createDeclBuildable()
    self.semicolon = semicolon?.createTokenSyntax()
  }
  
  func buildMemberDeclListItem(format: Format, leadingTrivia: Trivia? = nil) -> MemberDeclListItemSyntax {
    let memberDeclListItem = SyntaxFactory.makeMemberDeclListItem(
      decl: decl.buildDecl(format: format),
      semicolon: semicolon
    )
    
    if let leadingTrivia = leadingTrivia {
      return memberDeclListItem.withLeadingTrivia(leadingTrivia + (memberDeclListItem.leadingTrivia ?? []))
    }

    return memberDeclListItem
  }

  /// Conformance for `MemberDeclListItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let memberDeclListItem = buildMemberDeclListItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(memberDeclListItem)
  }
}

public protocol ExpressibleByMemberDeclListItem {
  func createMemberDeclListItem() -> MemberDeclListItem
}

extension MemberDeclListItem: ExpressibleByMemberDeclListItem {
  public func createMemberDeclListItem() -> MemberDeclListItem {
    self
  }
}

public struct SourceFile: SyntaxBuildable {
  let statements: CodeBlockItemList
  let eofToken: TokenSyntax

  public init(
    statements: ExpressibleByCodeBlockItemList,
    eofToken: ExpressibleByTokenSyntax
  ) {
    self.statements = statements.createCodeBlockItemList()
    self.eofToken = eofToken.createTokenSyntax()
  }
  
  func buildSourceFile(format: Format, leadingTrivia: Trivia? = nil) -> SourceFileSyntax {
    let sourceFile = SyntaxFactory.makeSourceFile(
      statements: statements.buildCodeBlockItemList(format: format),
      eofToken: eofToken
    )
    
    if let leadingTrivia = leadingTrivia {
      return sourceFile.withLeadingTrivia(leadingTrivia + (sourceFile.leadingTrivia ?? []))
    }

    return sourceFile
  }

  /// Conformance for `SourceFile` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let sourceFile = buildSourceFile(format: format, leadingTrivia: leadingTrivia)
    return Syntax(sourceFile)
  }
}

public protocol ExpressibleBySourceFile {
  func createSourceFile() -> SourceFile
}

extension SourceFile: ExpressibleBySourceFile {
  public func createSourceFile() -> SourceFile {
    self
  }
}

public struct InitializerClause: SyntaxBuildable {
  let equal: TokenSyntax
  let value: ExprBuildable

  public init(
    equal: ExpressibleByTokenSyntax = TokenSyntax.`equal`,
    value: ExpressibleByExprBuildable
  ) {
    self.equal = equal.createTokenSyntax()
    self.value = value.createExprBuildable()
  }
  
  func buildInitializerClause(format: Format, leadingTrivia: Trivia? = nil) -> InitializerClauseSyntax {
    let initializerClause = SyntaxFactory.makeInitializerClause(
      equal: equal,
      value: value.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return initializerClause.withLeadingTrivia(leadingTrivia + (initializerClause.leadingTrivia ?? []))
    }

    return initializerClause
  }

  /// Conformance for `InitializerClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let initializerClause = buildInitializerClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(initializerClause)
  }
}

public protocol ExpressibleByInitializerClause {
  func createInitializerClause() -> InitializerClause
}

extension InitializerClause: ExpressibleByInitializerClause {
  public func createInitializerClause() -> InitializerClause {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    firstName: ExpressibleByTokenSyntax? = nil,
    secondName: ExpressibleByTokenSyntax? = nil,
    colon: ExpressibleByTokenSyntax? = nil,
    type: ExpressibleByTypeBuildable? = nil,
    ellipsis: ExpressibleByTokenSyntax? = nil,
    defaultArgument: ExpressibleByInitializerClause? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.firstName = firstName?.createTokenSyntax()
    self.secondName = secondName?.createTokenSyntax()
    self.colon = colon?.createTokenSyntax()
    self.type = type?.createTypeBuildable()
    self.ellipsis = ellipsis?.createTokenSyntax()
    self.defaultArgument = defaultArgument?.createInitializerClause()
    self.trailingComma = trailingComma?.createTokenSyntax()
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
      return functionParameter.withLeadingTrivia(leadingTrivia + (functionParameter.leadingTrivia ?? []))
    }

    return functionParameter
  }

  /// Conformance for `FunctionParameter` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let functionParameter = buildFunctionParameter(format: format, leadingTrivia: leadingTrivia)
    return Syntax(functionParameter)
  }
}

public protocol ExpressibleByFunctionParameter {
  func createFunctionParameter() -> FunctionParameter
}

extension FunctionParameter: ExpressibleByFunctionParameter {
  public func createFunctionParameter() -> FunctionParameter {
    self
  }
}

// MARK: - Syntax collection

/// `ModifierList` represents a collection of 
/// `DeclModifier`s.
public struct ModifierList: SyntaxBuildable {
  let elements: [DeclModifier]

  public init(_ elements: [ExpressibleByDeclModifier]) {
    self.elements = elements.map { $0.createDeclModifier() }
  }

  public func buildModifierList(format: Format) -> ModifierListSyntax {
    return SyntaxFactory.makeModifierList(elements.map {
      $0.buildDeclModifier(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let modifierList = buildModifierList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(modifierList).withLeadingTrivia(leadingTrivia + (modifierList.leadingTrivia ?? []))
    }

    return Syntax(modifierList)
  }
}

public protocol ExpressibleByModifierList {
  func createModifierList() -> ModifierList
}

extension ModifierList: ExpressibleByModifierList {
  public func createModifierList() -> ModifierList {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    funcKeyword: ExpressibleByTokenSyntax = TokenSyntax.`func`,
    identifier: ExpressibleByTokenSyntax,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    signature: ExpressibleByFunctionSignature,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    body: ExpressibleByCodeBlock? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.funcKeyword = funcKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.signature = signature.createFunctionSignature()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.body = body?.createCodeBlock()
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
      return functionDecl.withLeadingTrivia(leadingTrivia + (functionDecl.leadingTrivia ?? []))
    }

    return functionDecl
  }

  /// Conformance for `FunctionDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let functionDecl = buildFunctionDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(functionDecl)
  }
}

public protocol ExpressibleByFunctionDecl {
  func createFunctionDecl() -> FunctionDecl
}

extension FunctionDecl: ExpressibleByFunctionDecl {
  public func createFunctionDecl() -> FunctionDecl {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    initKeyword: ExpressibleByTokenSyntax = TokenSyntax.`init`,
    optionalMark: ExpressibleByTokenSyntax? = nil,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    parameters: ExpressibleByParameterClause,
    throwsOrRethrowsKeyword: ExpressibleByTokenSyntax? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    body: ExpressibleByCodeBlock? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.initKeyword = initKeyword.createTokenSyntax()
    self.optionalMark = optionalMark?.createTokenSyntax()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.parameters = parameters.createParameterClause()
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword?.createTokenSyntax()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.body = body?.createCodeBlock()
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
      return initializerDecl.withLeadingTrivia(leadingTrivia + (initializerDecl.leadingTrivia ?? []))
    }

    return initializerDecl
  }

  /// Conformance for `InitializerDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let initializerDecl = buildInitializerDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(initializerDecl)
  }
}

public protocol ExpressibleByInitializerDecl {
  func createInitializerDecl() -> InitializerDecl
}

extension InitializerDecl: ExpressibleByInitializerDecl {
  public func createInitializerDecl() -> InitializerDecl {
    self
  }
}

public struct DeinitializerDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let deinitKeyword: TokenSyntax
  let body: CodeBlock

  public init(
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    deinitKeyword: ExpressibleByTokenSyntax = TokenSyntax.`deinit`,
    body: ExpressibleByCodeBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.deinitKeyword = deinitKeyword.createTokenSyntax()
    self.body = body.createCodeBlock()
  }
  
  func buildDeinitializerDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeinitializerDeclSyntax {
    let deinitializerDecl = SyntaxFactory.makeDeinitializerDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      deinitKeyword: deinitKeyword,
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return deinitializerDecl.withLeadingTrivia(leadingTrivia + (deinitializerDecl.leadingTrivia ?? []))
    }

    return deinitializerDecl
  }

  /// Conformance for `DeinitializerDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let deinitializerDecl = buildDeinitializerDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(deinitializerDecl)
  }
}

public protocol ExpressibleByDeinitializerDecl {
  func createDeinitializerDecl() -> DeinitializerDecl
}

extension DeinitializerDecl: ExpressibleByDeinitializerDecl {
  public func createDeinitializerDecl() -> DeinitializerDecl {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    subscriptKeyword: ExpressibleByTokenSyntax = TokenSyntax.`subscript`,
    genericParameterClause: ExpressibleByGenericParameterClause? = nil,
    indices: ExpressibleByParameterClause,
    result: ExpressibleByReturnClause,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    accessor: ExpressibleBySyntaxBuildable? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.subscriptKeyword = subscriptKeyword.createTokenSyntax()
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.indices = indices.createParameterClause()
    self.result = result.createReturnClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.accessor = accessor?.createSyntaxBuildable()
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
      return subscriptDecl.withLeadingTrivia(leadingTrivia + (subscriptDecl.leadingTrivia ?? []))
    }

    return subscriptDecl
  }

  /// Conformance for `SubscriptDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let subscriptDecl = buildSubscriptDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(subscriptDecl)
  }
}

public protocol ExpressibleBySubscriptDecl {
  func createSubscriptDecl() -> SubscriptDecl
}

extension SubscriptDecl: ExpressibleBySubscriptDecl {
  public func createSubscriptDecl() -> SubscriptDecl {
    self
  }
}

public struct AccessLevelModifier: SyntaxBuildable {
  let name: TokenSyntax
  let leftParen: TokenSyntax?
  let modifier: TokenSyntax?
  let rightParen: TokenSyntax?

  public init(
    name: ExpressibleByTokenSyntax,
    leftParen: ExpressibleByTokenSyntax? = nil,
    modifier: ExpressibleByTokenSyntax? = nil,
    rightParen: ExpressibleByTokenSyntax? = nil
  ) {
    self.name = name.createTokenSyntax()
    self.leftParen = leftParen?.createTokenSyntax()
    self.modifier = modifier?.createTokenSyntax()
    self.rightParen = rightParen?.createTokenSyntax()
  }
  
  func buildAccessLevelModifier(format: Format, leadingTrivia: Trivia? = nil) -> AccessLevelModifierSyntax {
    let accessLevelModifier = SyntaxFactory.makeAccessLevelModifier(
      name: name,
      leftParen: leftParen,
      modifier: modifier,
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessLevelModifier.withLeadingTrivia(leadingTrivia + (accessLevelModifier.leadingTrivia ?? []))
    }

    return accessLevelModifier
  }

  /// Conformance for `AccessLevelModifier` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessLevelModifier = buildAccessLevelModifier(format: format, leadingTrivia: leadingTrivia)
    return Syntax(accessLevelModifier)
  }
}

public protocol ExpressibleByAccessLevelModifier {
  func createAccessLevelModifier() -> AccessLevelModifier
}

extension AccessLevelModifier: ExpressibleByAccessLevelModifier {
  public func createAccessLevelModifier() -> AccessLevelModifier {
    self
  }
}

public struct AccessPathComponent: SyntaxBuildable {
  let name: TokenSyntax
  let trailingDot: TokenSyntax?

  public init(
    name: ExpressibleByTokenSyntax,
    trailingDot: ExpressibleByTokenSyntax? = nil
  ) {
    self.name = name.createTokenSyntax()
    self.trailingDot = trailingDot?.createTokenSyntax()
  }
  
  func buildAccessPathComponent(format: Format, leadingTrivia: Trivia? = nil) -> AccessPathComponentSyntax {
    let accessPathComponent = SyntaxFactory.makeAccessPathComponent(
      name: name,
      trailingDot: trailingDot
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessPathComponent.withLeadingTrivia(leadingTrivia + (accessPathComponent.leadingTrivia ?? []))
    }

    return accessPathComponent
  }

  /// Conformance for `AccessPathComponent` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessPathComponent = buildAccessPathComponent(format: format, leadingTrivia: leadingTrivia)
    return Syntax(accessPathComponent)
  }
}

public protocol ExpressibleByAccessPathComponent {
  func createAccessPathComponent() -> AccessPathComponent
}

extension AccessPathComponent: ExpressibleByAccessPathComponent {
  public func createAccessPathComponent() -> AccessPathComponent {
    self
  }
}

// MARK: - Syntax collection

/// `AccessPath` represents a collection of 
/// `AccessPathComponent`s.
public struct AccessPath: SyntaxBuildable {
  let elements: [AccessPathComponent]

  public init(_ elements: [ExpressibleByAccessPathComponent]) {
    self.elements = elements.map { $0.createAccessPathComponent() }
  }

  public func buildAccessPath(format: Format) -> AccessPathSyntax {
    return SyntaxFactory.makeAccessPath(elements.map {
      $0.buildAccessPathComponent(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessPath = buildAccessPath(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(accessPath).withLeadingTrivia(leadingTrivia + (accessPath.leadingTrivia ?? []))
    }

    return Syntax(accessPath)
  }
}

public protocol ExpressibleByAccessPath {
  func createAccessPath() -> AccessPath
}

extension AccessPath: ExpressibleByAccessPath {
  public func createAccessPath() -> AccessPath {
    self
  }
}

public struct ImportDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let importTok: TokenSyntax
  let importKind: TokenSyntax?
  let path: AccessPath

  public init(
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    importTok: ExpressibleByTokenSyntax = TokenSyntax.`import`,
    importKind: ExpressibleByTokenSyntax? = nil,
    path: ExpressibleByAccessPath
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.importTok = importTok.createTokenSyntax()
    self.importKind = importKind?.createTokenSyntax()
    self.path = path.createAccessPath()
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
      return importDecl.withLeadingTrivia(leadingTrivia + (importDecl.leadingTrivia ?? []))
    }

    return importDecl
  }

  /// Conformance for `ImportDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let importDecl = buildImportDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(importDecl)
  }
}

public protocol ExpressibleByImportDecl {
  func createImportDecl() -> ImportDecl
}

extension ImportDecl: ExpressibleByImportDecl {
  public func createImportDecl() -> ImportDecl {
    self
  }
}

public struct AccessorParameter: SyntaxBuildable {
  let leftParen: TokenSyntax
  let name: TokenSyntax
  let rightParen: TokenSyntax

  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    name: ExpressibleByTokenSyntax,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.name = name.createTokenSyntax()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildAccessorParameter(format: Format, leadingTrivia: Trivia? = nil) -> AccessorParameterSyntax {
    let accessorParameter = SyntaxFactory.makeAccessorParameter(
      leftParen: leftParen,
      name: name,
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessorParameter.withLeadingTrivia(leadingTrivia + (accessorParameter.leadingTrivia ?? []))
    }

    return accessorParameter
  }

  /// Conformance for `AccessorParameter` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessorParameter = buildAccessorParameter(format: format, leadingTrivia: leadingTrivia)
    return Syntax(accessorParameter)
  }
}

public protocol ExpressibleByAccessorParameter {
  func createAccessorParameter() -> AccessorParameter
}

extension AccessorParameter: ExpressibleByAccessorParameter {
  public func createAccessorParameter() -> AccessorParameter {
    self
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
    attributes: ExpressibleByAttributeList? = nil,
    modifier: ExpressibleByDeclModifier? = nil,
    accessorKind: ExpressibleByTokenSyntax,
    parameter: ExpressibleByAccessorParameter? = nil,
    asyncKeyword: ExpressibleByTokenSyntax? = nil,
    throwsKeyword: ExpressibleByTokenSyntax? = nil,
    body: ExpressibleByCodeBlock? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifier = modifier?.createDeclModifier()
    self.accessorKind = accessorKind.createTokenSyntax()
    self.parameter = parameter?.createAccessorParameter()
    self.asyncKeyword = asyncKeyword?.createTokenSyntax()
    self.throwsKeyword = throwsKeyword?.createTokenSyntax()
    self.body = body?.createCodeBlock()
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
      return accessorDecl.withLeadingTrivia(leadingTrivia + (accessorDecl.leadingTrivia ?? []))
    }

    return accessorDecl
  }

  /// Conformance for `AccessorDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let accessorDecl = buildAccessorDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(accessorDecl)
  }
}

public protocol ExpressibleByAccessorDecl {
  func createAccessorDecl() -> AccessorDecl
}

extension AccessorDecl: ExpressibleByAccessorDecl {
  public func createAccessorDecl() -> AccessorDecl {
    self
  }
}

// MARK: - Syntax collection

/// `AccessorList` represents a collection of 
/// `AccessorDecl`s.
public struct AccessorList: SyntaxBuildable {
  let elements: [AccessorDecl]

  public init(_ elements: [ExpressibleByAccessorDecl]) {
    self.elements = elements.map { $0.createAccessorDecl() }
  }

  public func buildAccessorList(format: Format) -> AccessorListSyntax {
    return SyntaxFactory.makeAccessorList(elements.map {
      $0.buildAccessorDecl(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessorList = buildAccessorList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(accessorList).withLeadingTrivia(leadingTrivia + (accessorList.leadingTrivia ?? []))
    }

    return Syntax(accessorList)
  }
}

public protocol ExpressibleByAccessorList {
  func createAccessorList() -> AccessorList
}

extension AccessorList: ExpressibleByAccessorList {
  public func createAccessorList() -> AccessorList {
    self
  }
}

public struct AccessorBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let accessors: AccessorList
  let rightBrace: TokenSyntax

  public init(
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    accessors: ExpressibleByAccessorList,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace.createTokenSyntax()
    self.accessors = accessors.createAccessorList()
    self.rightBrace = rightBrace.createTokenSyntax()
  }
  
  func buildAccessorBlock(format: Format, leadingTrivia: Trivia? = nil) -> AccessorBlockSyntax {
    let accessorBlock = SyntaxFactory.makeAccessorBlock(
      leftBrace: leftBrace,
      accessors: accessors.buildAccessorList(format: format),
      rightBrace: rightBrace
    )
    
    if let leadingTrivia = leadingTrivia {
      return accessorBlock.withLeadingTrivia(leadingTrivia + (accessorBlock.leadingTrivia ?? []))
    }

    return accessorBlock
  }

  /// Conformance for `AccessorBlock` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let accessorBlock = buildAccessorBlock(format: format, leadingTrivia: leadingTrivia)
    return Syntax(accessorBlock)
  }
}

public protocol ExpressibleByAccessorBlock {
  func createAccessorBlock() -> AccessorBlock
}

extension AccessorBlock: ExpressibleByAccessorBlock {
  public func createAccessorBlock() -> AccessorBlock {
    self
  }
}

public struct PatternBinding: SyntaxBuildable {
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause?
  let accessor: SyntaxBuildable?
  let trailingComma: TokenSyntax?

  public init(
    pattern: ExpressibleByPatternBuildable,
    typeAnnotation: ExpressibleByTypeAnnotation? = nil,
    initializer: ExpressibleByInitializerClause? = nil,
    accessor: ExpressibleBySyntaxBuildable? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer?.createInitializerClause()
    self.accessor = accessor?.createSyntaxBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
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
      return patternBinding.withLeadingTrivia(leadingTrivia + (patternBinding.leadingTrivia ?? []))
    }

    return patternBinding
  }

  /// Conformance for `PatternBinding` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let patternBinding = buildPatternBinding(format: format, leadingTrivia: leadingTrivia)
    return Syntax(patternBinding)
  }
}

public protocol ExpressibleByPatternBinding {
  func createPatternBinding() -> PatternBinding
}

extension PatternBinding: ExpressibleByPatternBinding {
  public func createPatternBinding() -> PatternBinding {
    self
  }
}

// MARK: - Syntax collection

/// `PatternBindingList` represents a collection of 
/// `PatternBinding`s.
public struct PatternBindingList: SyntaxBuildable {
  let elements: [PatternBinding]

  public init(_ elements: [ExpressibleByPatternBinding]) {
    self.elements = elements.map { $0.createPatternBinding() }
  }

  public func buildPatternBindingList(format: Format) -> PatternBindingListSyntax {
    return SyntaxFactory.makePatternBindingList(elements.map {
      $0.buildPatternBinding(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let patternBindingList = buildPatternBindingList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(patternBindingList).withLeadingTrivia(leadingTrivia + (patternBindingList.leadingTrivia ?? []))
    }

    return Syntax(patternBindingList)
  }
}

public protocol ExpressibleByPatternBindingList {
  func createPatternBindingList() -> PatternBindingList
}

extension PatternBindingList: ExpressibleByPatternBindingList {
  public func createPatternBindingList() -> PatternBindingList {
    self
  }
}

public struct VariableDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let letOrVarKeyword: TokenSyntax
  let bindings: PatternBindingList

  public init(
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    letOrVarKeyword: ExpressibleByTokenSyntax,
    bindings: ExpressibleByPatternBindingList
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.letOrVarKeyword = letOrVarKeyword.createTokenSyntax()
    self.bindings = bindings.createPatternBindingList()
  }
  
  func buildVariableDecl(format: Format, leadingTrivia: Trivia? = nil) -> VariableDeclSyntax {
    let variableDecl = SyntaxFactory.makeVariableDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      letOrVarKeyword: letOrVarKeyword,
      bindings: bindings.buildPatternBindingList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return variableDecl.withLeadingTrivia(leadingTrivia + (variableDecl.leadingTrivia ?? []))
    }

    return variableDecl
  }

  /// Conformance for `VariableDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let variableDecl = buildVariableDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(variableDecl)
  }
}

public protocol ExpressibleByVariableDecl {
  func createVariableDecl() -> VariableDecl
}

extension VariableDecl: ExpressibleByVariableDecl {
  public func createVariableDecl() -> VariableDecl {
    self
  }
}

/// 
/// An element of an enum case, containing the name of the case and,
/// optionally, either associated values or an assignment to a raw value.
/// 
public struct EnumCaseElement: SyntaxBuildable {
  let identifier: TokenSyntax
  let associatedValue: ParameterClause?
  let rawValue: InitializerClause?
  let trailingComma: TokenSyntax?

  public init(
    identifier: ExpressibleByTokenSyntax,
    associatedValue: ExpressibleByParameterClause? = nil,
    rawValue: ExpressibleByInitializerClause? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.identifier = identifier.createTokenSyntax()
    self.associatedValue = associatedValue?.createParameterClause()
    self.rawValue = rawValue?.createInitializerClause()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildEnumCaseElement(format: Format, leadingTrivia: Trivia? = nil) -> EnumCaseElementSyntax {
    let enumCaseElement = SyntaxFactory.makeEnumCaseElement(
      identifier: identifier,
      associatedValue: associatedValue?.buildParameterClause(format: format),
      rawValue: rawValue?.buildInitializerClause(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return enumCaseElement.withLeadingTrivia(leadingTrivia + (enumCaseElement.leadingTrivia ?? []))
    }

    return enumCaseElement
  }

  /// Conformance for `EnumCaseElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let enumCaseElement = buildEnumCaseElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(enumCaseElement)
  }
}

public protocol ExpressibleByEnumCaseElement {
  func createEnumCaseElement() -> EnumCaseElement
}

extension EnumCaseElement: ExpressibleByEnumCaseElement {
  public func createEnumCaseElement() -> EnumCaseElement {
    self
  }
}

// MARK: - Syntax collection

/// A collection of 0 or more `EnumCaseElement`s.
public struct EnumCaseElementList: SyntaxBuildable {
  let elements: [EnumCaseElement]

  public init(_ elements: [ExpressibleByEnumCaseElement]) {
    self.elements = elements.map { $0.createEnumCaseElement() }
  }

  public func buildEnumCaseElementList(format: Format) -> EnumCaseElementListSyntax {
    return SyntaxFactory.makeEnumCaseElementList(elements.map {
      $0.buildEnumCaseElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let enumCaseElementList = buildEnumCaseElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(enumCaseElementList).withLeadingTrivia(leadingTrivia + (enumCaseElementList.leadingTrivia ?? []))
    }

    return Syntax(enumCaseElementList)
  }
}

public protocol ExpressibleByEnumCaseElementList {
  func createEnumCaseElementList() -> EnumCaseElementList
}

extension EnumCaseElementList: ExpressibleByEnumCaseElementList {
  public func createEnumCaseElementList() -> EnumCaseElementList {
    self
  }
}

/// 
/// A `case` declaration of a Swift `enum`. It can have 1 or more
/// `EnumCaseElement`s inside, each declaring a different case of the
/// enum.
/// 
public struct EnumCaseDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let caseKeyword: TokenSyntax
  let elements: EnumCaseElementList

  public init(
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    caseKeyword: ExpressibleByTokenSyntax = TokenSyntax.`case`,
    elements: ExpressibleByEnumCaseElementList
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.caseKeyword = caseKeyword.createTokenSyntax()
    self.elements = elements.createEnumCaseElementList()
  }
  
  func buildEnumCaseDecl(format: Format, leadingTrivia: Trivia? = nil) -> EnumCaseDeclSyntax {
    let enumCaseDecl = SyntaxFactory.makeEnumCaseDecl(
      attributes: attributes?.buildAttributeList(format: format),
      modifiers: modifiers?.buildModifierList(format: format),
      caseKeyword: caseKeyword,
      elements: elements.buildEnumCaseElementList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return enumCaseDecl.withLeadingTrivia(leadingTrivia + (enumCaseDecl.leadingTrivia ?? []))
    }

    return enumCaseDecl
  }

  /// Conformance for `EnumCaseDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let enumCaseDecl = buildEnumCaseDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(enumCaseDecl)
  }
}

public protocol ExpressibleByEnumCaseDecl {
  func createEnumCaseDecl() -> EnumCaseDecl
}

extension EnumCaseDecl: ExpressibleByEnumCaseDecl {
  public func createEnumCaseDecl() -> EnumCaseDecl {
    self
  }
}

/// A Swift `enum` declaration.
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
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    enumKeyword: ExpressibleByTokenSyntax = TokenSyntax.`enum`,
    identifier: ExpressibleByTokenSyntax,
    genericParameters: ExpressibleByGenericParameterClause? = nil,
    inheritanceClause: ExpressibleByTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleByGenericWhereClause? = nil,
    members: ExpressibleByMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.enumKeyword = enumKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.genericParameters = genericParameters?.createGenericParameterClause()
    self.inheritanceClause = inheritanceClause?.createTypeInheritanceClause()
    self.genericWhereClause = genericWhereClause?.createGenericWhereClause()
    self.members = members.createMemberDeclBlock()
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
      return enumDecl.withLeadingTrivia(leadingTrivia + (enumDecl.leadingTrivia ?? []))
    }

    return enumDecl
  }

  /// Conformance for `EnumDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let enumDecl = buildEnumDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(enumDecl)
  }
}

public protocol ExpressibleByEnumDecl {
  func createEnumDecl() -> EnumDecl
}

extension EnumDecl: ExpressibleByEnumDecl {
  public func createEnumDecl() -> EnumDecl {
    self
  }
}

/// A Swift `operator` declaration.
public struct OperatorDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let operatorKeyword: TokenSyntax
  let identifier: TokenSyntax
  let operatorPrecedenceAndTypes: OperatorPrecedenceAndTypes?

  public init(
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    operatorKeyword: ExpressibleByTokenSyntax = TokenSyntax.`operator`,
    identifier: ExpressibleByTokenSyntax,
    operatorPrecedenceAndTypes: ExpressibleByOperatorPrecedenceAndTypes? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.operatorKeyword = operatorKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.operatorPrecedenceAndTypes = operatorPrecedenceAndTypes?.createOperatorPrecedenceAndTypes()
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
      return operatorDecl.withLeadingTrivia(leadingTrivia + (operatorDecl.leadingTrivia ?? []))
    }

    return operatorDecl
  }

  /// Conformance for `OperatorDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let operatorDecl = buildOperatorDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(operatorDecl)
  }
}

public protocol ExpressibleByOperatorDecl {
  func createOperatorDecl() -> OperatorDecl
}

extension OperatorDecl: ExpressibleByOperatorDecl {
  public func createOperatorDecl() -> OperatorDecl {
    self
  }
}

// MARK: - Syntax collection

/// `IdentifierList` represents a collection of 
/// `TokenSyntax`s.
public struct IdentifierList: SyntaxBuildable {
  let elements: [TokenSyntax]

  public init(_ elements: [ExpressibleByTokenSyntax]) {
    self.elements = elements.map { $0.createTokenSyntax() }
  }

  public func buildIdentifierList(format: Format) -> IdentifierListSyntax {
    return SyntaxFactory.makeIdentifierList(elements)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let identifierList = buildIdentifierList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(identifierList).withLeadingTrivia(leadingTrivia + (identifierList.leadingTrivia ?? []))
    }

    return Syntax(identifierList)
  }
}

public protocol ExpressibleByIdentifierList {
  func createIdentifierList() -> IdentifierList
}

extension IdentifierList: ExpressibleByIdentifierList {
  public func createIdentifierList() -> IdentifierList {
    self
  }
}

/// 
/// A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.
/// 
public struct OperatorPrecedenceAndTypes: SyntaxBuildable {
  let colon: TokenSyntax
  let precedenceGroupAndDesignatedTypes: IdentifierList

  public init(
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    precedenceGroupAndDesignatedTypes: ExpressibleByIdentifierList
  ) {
    self.colon = colon.createTokenSyntax()
    self.precedenceGroupAndDesignatedTypes = precedenceGroupAndDesignatedTypes.createIdentifierList()
  }
  
  func buildOperatorPrecedenceAndTypes(format: Format, leadingTrivia: Trivia? = nil) -> OperatorPrecedenceAndTypesSyntax {
    let operatorPrecedenceAndTypes = SyntaxFactory.makeOperatorPrecedenceAndTypes(
      colon: colon,
      precedenceGroupAndDesignatedTypes: precedenceGroupAndDesignatedTypes.buildIdentifierList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return operatorPrecedenceAndTypes.withLeadingTrivia(leadingTrivia + (operatorPrecedenceAndTypes.leadingTrivia ?? []))
    }

    return operatorPrecedenceAndTypes
  }

  /// Conformance for `OperatorPrecedenceAndTypes` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let operatorPrecedenceAndTypes = buildOperatorPrecedenceAndTypes(format: format, leadingTrivia: leadingTrivia)
    return Syntax(operatorPrecedenceAndTypes)
  }
}

public protocol ExpressibleByOperatorPrecedenceAndTypes {
  func createOperatorPrecedenceAndTypes() -> OperatorPrecedenceAndTypes
}

extension OperatorPrecedenceAndTypes: ExpressibleByOperatorPrecedenceAndTypes {
  public func createOperatorPrecedenceAndTypes() -> OperatorPrecedenceAndTypes {
    self
  }
}

/// A Swift `precedencegroup` declaration.
public struct PrecedenceGroupDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let precedencegroupKeyword: TokenSyntax
  let identifier: TokenSyntax
  let leftBrace: TokenSyntax
  let groupAttributes: PrecedenceGroupAttributeList
  let rightBrace: TokenSyntax

  public init(
    attributes: ExpressibleByAttributeList? = nil,
    modifiers: ExpressibleByModifierList? = nil,
    precedencegroupKeyword: ExpressibleByTokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: ExpressibleByTokenSyntax,
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    groupAttributes: ExpressibleByPrecedenceGroupAttributeList,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.precedencegroupKeyword = precedencegroupKeyword.createTokenSyntax()
    self.identifier = identifier.createTokenSyntax()
    self.leftBrace = leftBrace.createTokenSyntax()
    self.groupAttributes = groupAttributes.createPrecedenceGroupAttributeList()
    self.rightBrace = rightBrace.createTokenSyntax()
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
      return precedenceGroupDecl.withLeadingTrivia(leadingTrivia + (precedenceGroupDecl.leadingTrivia ?? []))
    }

    return precedenceGroupDecl
  }

  /// Conformance for `PrecedenceGroupDecl` to the `DeclBuildable` protocol.
  public func buildDecl(format: Format, leadingTrivia: Trivia? = nil) -> DeclSyntax {
    let precedenceGroupDecl = buildPrecedenceGroupDecl(format: format, leadingTrivia: leadingTrivia)
    return DeclSyntax(precedenceGroupDecl)
  }
}

public protocol ExpressibleByPrecedenceGroupDecl {
  func createPrecedenceGroupDecl() -> PrecedenceGroupDecl
}

extension PrecedenceGroupDecl: ExpressibleByPrecedenceGroupDecl {
  public func createPrecedenceGroupDecl() -> PrecedenceGroupDecl {
    self
  }
}

// MARK: - Syntax collection

/// `PrecedenceGroupAttributeList` represents a collection of 
/// `SyntaxBuildable`s.
public struct PrecedenceGroupAttributeList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [ExpressibleBySyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public func buildPrecedenceGroupAttributeList(format: Format) -> PrecedenceGroupAttributeListSyntax {
    return SyntaxFactory.makePrecedenceGroupAttributeList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupAttributeList = buildPrecedenceGroupAttributeList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(precedenceGroupAttributeList).withLeadingTrivia(leadingTrivia + (precedenceGroupAttributeList.leadingTrivia ?? []))
    }

    return Syntax(precedenceGroupAttributeList)
  }
}

public protocol ExpressibleByPrecedenceGroupAttributeList {
  func createPrecedenceGroupAttributeList() -> PrecedenceGroupAttributeList
}

extension PrecedenceGroupAttributeList: ExpressibleByPrecedenceGroupAttributeList {
  public func createPrecedenceGroupAttributeList() -> PrecedenceGroupAttributeList {
    self
  }
}

/// 
/// Specify the new precedence group's relation to existing precedence
/// groups.
/// 
public struct PrecedenceGroupRelation: SyntaxBuildable {
  let higherThanOrLowerThan: TokenSyntax
  let colon: TokenSyntax
  let otherNames: PrecedenceGroupNameList

  public init(
    higherThanOrLowerThan: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    otherNames: ExpressibleByPrecedenceGroupNameList
  ) {
    self.higherThanOrLowerThan = higherThanOrLowerThan.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.otherNames = otherNames.createPrecedenceGroupNameList()
  }
  
  func buildPrecedenceGroupRelation(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupRelationSyntax {
    let precedenceGroupRelation = SyntaxFactory.makePrecedenceGroupRelation(
      higherThanOrLowerThan: higherThanOrLowerThan,
      colon: colon,
      otherNames: otherNames.buildPrecedenceGroupNameList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupRelation.withLeadingTrivia(leadingTrivia + (precedenceGroupRelation.leadingTrivia ?? []))
    }

    return precedenceGroupRelation
  }

  /// Conformance for `PrecedenceGroupRelation` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupRelation = buildPrecedenceGroupRelation(format: format, leadingTrivia: leadingTrivia)
    return Syntax(precedenceGroupRelation)
  }
}

public protocol ExpressibleByPrecedenceGroupRelation {
  func createPrecedenceGroupRelation() -> PrecedenceGroupRelation
}

extension PrecedenceGroupRelation: ExpressibleByPrecedenceGroupRelation {
  public func createPrecedenceGroupRelation() -> PrecedenceGroupRelation {
    self
  }
}

// MARK: - Syntax collection

/// `PrecedenceGroupNameList` represents a collection of 
/// `PrecedenceGroupNameElement`s.
public struct PrecedenceGroupNameList: SyntaxBuildable {
  let elements: [PrecedenceGroupNameElement]

  public init(_ elements: [ExpressibleByPrecedenceGroupNameElement]) {
    self.elements = elements.map { $0.createPrecedenceGroupNameElement() }
  }

  public func buildPrecedenceGroupNameList(format: Format) -> PrecedenceGroupNameListSyntax {
    return SyntaxFactory.makePrecedenceGroupNameList(elements.map {
      $0.buildPrecedenceGroupNameElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupNameList = buildPrecedenceGroupNameList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(precedenceGroupNameList).withLeadingTrivia(leadingTrivia + (precedenceGroupNameList.leadingTrivia ?? []))
    }

    return Syntax(precedenceGroupNameList)
  }
}

public protocol ExpressibleByPrecedenceGroupNameList {
  func createPrecedenceGroupNameList() -> PrecedenceGroupNameList
}

extension PrecedenceGroupNameList: ExpressibleByPrecedenceGroupNameList {
  public func createPrecedenceGroupNameList() -> PrecedenceGroupNameList {
    self
  }
}

public struct PrecedenceGroupNameElement: SyntaxBuildable {
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  public init(
    name: ExpressibleByTokenSyntax,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.name = name.createTokenSyntax()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildPrecedenceGroupNameElement(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupNameElementSyntax {
    let precedenceGroupNameElement = SyntaxFactory.makePrecedenceGroupNameElement(
      name: name,
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupNameElement.withLeadingTrivia(leadingTrivia + (precedenceGroupNameElement.leadingTrivia ?? []))
    }

    return precedenceGroupNameElement
  }

  /// Conformance for `PrecedenceGroupNameElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupNameElement = buildPrecedenceGroupNameElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(precedenceGroupNameElement)
  }
}

public protocol ExpressibleByPrecedenceGroupNameElement {
  func createPrecedenceGroupNameElement() -> PrecedenceGroupNameElement
}

extension PrecedenceGroupNameElement: ExpressibleByPrecedenceGroupNameElement {
  public func createPrecedenceGroupNameElement() -> PrecedenceGroupNameElement {
    self
  }
}

/// 
/// Specifies the precedence of an operator when used in an operation
/// that includes optional chaining.
/// 
public struct PrecedenceGroupAssignment: SyntaxBuildable {
  let assignmentKeyword: TokenSyntax
  let colon: TokenSyntax
  let flag: TokenSyntax

  public init(
    assignmentKeyword: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    flag: ExpressibleByTokenSyntax
  ) {
    self.assignmentKeyword = assignmentKeyword.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.flag = flag.createTokenSyntax()
  }
  
  func buildPrecedenceGroupAssignment(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupAssignmentSyntax {
    let precedenceGroupAssignment = SyntaxFactory.makePrecedenceGroupAssignment(
      assignmentKeyword: assignmentKeyword,
      colon: colon,
      flag: flag
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupAssignment.withLeadingTrivia(leadingTrivia + (precedenceGroupAssignment.leadingTrivia ?? []))
    }

    return precedenceGroupAssignment
  }

  /// Conformance for `PrecedenceGroupAssignment` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupAssignment = buildPrecedenceGroupAssignment(format: format, leadingTrivia: leadingTrivia)
    return Syntax(precedenceGroupAssignment)
  }
}

public protocol ExpressibleByPrecedenceGroupAssignment {
  func createPrecedenceGroupAssignment() -> PrecedenceGroupAssignment
}

extension PrecedenceGroupAssignment: ExpressibleByPrecedenceGroupAssignment {
  public func createPrecedenceGroupAssignment() -> PrecedenceGroupAssignment {
    self
  }
}

/// 
/// Specifies how a sequence of operators with the same precedence level
/// are grouped together in the absence of grouping parentheses.
/// 
public struct PrecedenceGroupAssociativity: SyntaxBuildable {
  let associativityKeyword: TokenSyntax
  let colon: TokenSyntax
  let value: TokenSyntax

  public init(
    associativityKeyword: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleByTokenSyntax
  ) {
    self.associativityKeyword = associativityKeyword.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.value = value.createTokenSyntax()
  }
  
  func buildPrecedenceGroupAssociativity(format: Format, leadingTrivia: Trivia? = nil) -> PrecedenceGroupAssociativitySyntax {
    let precedenceGroupAssociativity = SyntaxFactory.makePrecedenceGroupAssociativity(
      associativityKeyword: associativityKeyword,
      colon: colon,
      value: value
    )
    
    if let leadingTrivia = leadingTrivia {
      return precedenceGroupAssociativity.withLeadingTrivia(leadingTrivia + (precedenceGroupAssociativity.leadingTrivia ?? []))
    }

    return precedenceGroupAssociativity
  }

  /// Conformance for `PrecedenceGroupAssociativity` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let precedenceGroupAssociativity = buildPrecedenceGroupAssociativity(format: format, leadingTrivia: leadingTrivia)
    return Syntax(precedenceGroupAssociativity)
  }
}

public protocol ExpressibleByPrecedenceGroupAssociativity {
  func createPrecedenceGroupAssociativity() -> PrecedenceGroupAssociativity
}

extension PrecedenceGroupAssociativity: ExpressibleByPrecedenceGroupAssociativity {
  public func createPrecedenceGroupAssociativity() -> PrecedenceGroupAssociativity {
    self
  }
}

// MARK: - Syntax collection

/// `TokenList` represents a collection of 
/// `TokenSyntax`s.
public struct TokenList: SyntaxBuildable {
  let elements: [TokenSyntax]

  public init(_ elements: [ExpressibleByTokenSyntax]) {
    self.elements = elements.map { $0.createTokenSyntax() }
  }

  public func buildTokenList(format: Format) -> TokenListSyntax {
    return SyntaxFactory.makeTokenList(elements)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tokenList = buildTokenList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(tokenList).withLeadingTrivia(leadingTrivia + (tokenList.leadingTrivia ?? []))
    }

    return Syntax(tokenList)
  }
}

public protocol ExpressibleByTokenList {
  func createTokenList() -> TokenList
}

extension TokenList: ExpressibleByTokenList {
  public func createTokenList() -> TokenList {
    self
  }
}

// MARK: - Syntax collection

/// `NonEmptyTokenList` represents a collection of 
/// `TokenSyntax`s.
public struct NonEmptyTokenList: SyntaxBuildable {
  let elements: [TokenSyntax]

  public init(_ elements: [ExpressibleByTokenSyntax]) {
    self.elements = elements.map { $0.createTokenSyntax() }
  }

  public func buildNonEmptyTokenList(format: Format) -> NonEmptyTokenListSyntax {
    return SyntaxFactory.makeNonEmptyTokenList(elements)
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let nonEmptyTokenList = buildNonEmptyTokenList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(nonEmptyTokenList).withLeadingTrivia(leadingTrivia + (nonEmptyTokenList.leadingTrivia ?? []))
    }

    return Syntax(nonEmptyTokenList)
  }
}

public protocol ExpressibleByNonEmptyTokenList {
  func createNonEmptyTokenList() -> NonEmptyTokenList
}

extension NonEmptyTokenList: ExpressibleByNonEmptyTokenList {
  public func createNonEmptyTokenList() -> NonEmptyTokenList {
    self
  }
}

/// 
/// A custom `@` attribute.
/// 
public struct CustomAttribute: SyntaxBuildable {
  let atSignToken: TokenSyntax
  let attributeName: TypeBuildable
  let leftParen: TokenSyntax?
  let argumentList: TupleExprElementList?
  let rightParen: TokenSyntax?

  public init(
    atSignToken: ExpressibleByTokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleByTypeBuildable,
    leftParen: ExpressibleByTokenSyntax? = nil,
    argumentList: ExpressibleByTupleExprElementList? = nil,
    rightParen: ExpressibleByTokenSyntax? = nil
  ) {
    self.atSignToken = atSignToken.createTokenSyntax()
    self.attributeName = attributeName.createTypeBuildable()
    self.leftParen = leftParen?.createTokenSyntax()
    self.argumentList = argumentList?.createTupleExprElementList()
    self.rightParen = rightParen?.createTokenSyntax()
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
      return customAttribute.withLeadingTrivia(leadingTrivia + (customAttribute.leadingTrivia ?? []))
    }

    return customAttribute
  }

  /// Conformance for `CustomAttribute` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let customAttribute = buildCustomAttribute(format: format, leadingTrivia: leadingTrivia)
    return Syntax(customAttribute)
  }
}

public protocol ExpressibleByCustomAttribute {
  func createCustomAttribute() -> CustomAttribute
}

extension CustomAttribute: ExpressibleByCustomAttribute {
  public func createCustomAttribute() -> CustomAttribute {
    self
  }
}

/// 
/// An `@` attribute.
/// 
public struct Attribute: SyntaxBuildable {
  let atSignToken: TokenSyntax
  let attributeName: TokenSyntax
  let leftParen: TokenSyntax?
  let argument: SyntaxBuildable?
  let rightParen: TokenSyntax?
  let tokenList: TokenList?

  public init(
    atSignToken: ExpressibleByTokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleByTokenSyntax,
    leftParen: ExpressibleByTokenSyntax? = nil,
    argument: ExpressibleBySyntaxBuildable? = nil,
    rightParen: ExpressibleByTokenSyntax? = nil,
    tokenList: ExpressibleByTokenList? = nil
  ) {
    self.atSignToken = atSignToken.createTokenSyntax()
    self.attributeName = attributeName.createTokenSyntax()
    self.leftParen = leftParen?.createTokenSyntax()
    self.argument = argument?.createSyntaxBuildable()
    self.rightParen = rightParen?.createTokenSyntax()
    self.tokenList = tokenList?.createTokenList()
  }
  
  func buildAttribute(format: Format, leadingTrivia: Trivia? = nil) -> AttributeSyntax {
    let attribute = SyntaxFactory.makeAttribute(
      atSignToken: atSignToken,
      attributeName: attributeName,
      leftParen: leftParen,
      argument: argument?.buildSyntax(format: format),
      rightParen: rightParen,
      tokenList: tokenList?.buildTokenList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return attribute.withLeadingTrivia(leadingTrivia + (attribute.leadingTrivia ?? []))
    }

    return attribute
  }

  /// Conformance for `Attribute` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let attribute = buildAttribute(format: format, leadingTrivia: leadingTrivia)
    return Syntax(attribute)
  }
}

public protocol ExpressibleByAttribute {
  func createAttribute() -> Attribute
}

extension Attribute: ExpressibleByAttribute {
  public func createAttribute() -> Attribute {
    self
  }
}

// MARK: - Syntax collection

/// `AttributeList` represents a collection of 
/// `SyntaxBuildable`s.
public struct AttributeList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [ExpressibleBySyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public func buildAttributeList(format: Format) -> AttributeListSyntax {
    return SyntaxFactory.makeAttributeList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let attributeList = buildAttributeList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(attributeList).withLeadingTrivia(leadingTrivia + (attributeList.leadingTrivia ?? []))
    }

    return Syntax(attributeList)
  }
}

public protocol ExpressibleByAttributeList {
  func createAttributeList() -> AttributeList
}

extension AttributeList: ExpressibleByAttributeList {
  public func createAttributeList() -> AttributeList {
    self
  }
}

// MARK: - Syntax collection

/// 
/// A collection of arguments for the `@_specialize` attribute
/// 
public struct SpecializeAttributeSpecList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [ExpressibleBySyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public func buildSpecializeAttributeSpecList(format: Format) -> SpecializeAttributeSpecListSyntax {
    return SyntaxFactory.makeSpecializeAttributeSpecList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let specializeAttributeSpecList = buildSpecializeAttributeSpecList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(specializeAttributeSpecList).withLeadingTrivia(leadingTrivia + (specializeAttributeSpecList.leadingTrivia ?? []))
    }

    return Syntax(specializeAttributeSpecList)
  }
}

public protocol ExpressibleBySpecializeAttributeSpecList {
  func createSpecializeAttributeSpecList() -> SpecializeAttributeSpecList
}

extension SpecializeAttributeSpecList: ExpressibleBySpecializeAttributeSpecList {
  public func createSpecializeAttributeSpecList() -> SpecializeAttributeSpecList {
    self
  }
}

/// 
/// The availability argument for the _specialize attribute
/// 
public struct AvailabilityEntry: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let availabilityList: AvailabilitySpecList
  let semicolon: TokenSyntax

  public init(
    label: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    availabilityList: ExpressibleByAvailabilitySpecList,
    semicolon: ExpressibleByTokenSyntax = TokenSyntax.`semicolon`
  ) {
    self.label = label.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.availabilityList = availabilityList.createAvailabilitySpecList()
    self.semicolon = semicolon.createTokenSyntax()
  }
  
  func buildAvailabilityEntry(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityEntrySyntax {
    let availabilityEntry = SyntaxFactory.makeAvailabilityEntry(
      label: label,
      colon: colon,
      availabilityList: availabilityList.buildAvailabilitySpecList(format: format),
      semicolon: semicolon
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityEntry.withLeadingTrivia(leadingTrivia + (availabilityEntry.leadingTrivia ?? []))
    }

    return availabilityEntry
  }

  /// Conformance for `AvailabilityEntry` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityEntry = buildAvailabilityEntry(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityEntry)
  }
}

public protocol ExpressibleByAvailabilityEntry {
  func createAvailabilityEntry() -> AvailabilityEntry
}

extension AvailabilityEntry: ExpressibleByAvailabilityEntry {
  public func createAvailabilityEntry() -> AvailabilityEntry {
    self
  }
}

/// 
/// A labeled argument for the `@_specialize` attribute like
/// `exported: true`
/// 
public struct LabeledSpecializeEntry: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let value: TokenSyntax
  let trailingComma: TokenSyntax?

  public init(
    label: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleByTokenSyntax,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.label = label.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.value = value.createTokenSyntax()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildLabeledSpecializeEntry(format: Format, leadingTrivia: Trivia? = nil) -> LabeledSpecializeEntrySyntax {
    let labeledSpecializeEntry = SyntaxFactory.makeLabeledSpecializeEntry(
      label: label,
      colon: colon,
      value: value,
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return labeledSpecializeEntry.withLeadingTrivia(leadingTrivia + (labeledSpecializeEntry.leadingTrivia ?? []))
    }

    return labeledSpecializeEntry
  }

  /// Conformance for `LabeledSpecializeEntry` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let labeledSpecializeEntry = buildLabeledSpecializeEntry(format: format, leadingTrivia: leadingTrivia)
    return Syntax(labeledSpecializeEntry)
  }
}

public protocol ExpressibleByLabeledSpecializeEntry {
  func createLabeledSpecializeEntry() -> LabeledSpecializeEntry
}

extension LabeledSpecializeEntry: ExpressibleByLabeledSpecializeEntry {
  public func createLabeledSpecializeEntry() -> LabeledSpecializeEntry {
    self
  }
}

/// 
/// A labeled argument for the `@_specialize` attribute with a function
/// decl value like
/// `target: myFunc(_:)`
/// 
public struct TargetFunctionEntry: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let delcname: DeclName
  let trailingComma: TokenSyntax?

  public init(
    label: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    delcname: ExpressibleByDeclName,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.label = label.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.delcname = delcname.createDeclName()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildTargetFunctionEntry(format: Format, leadingTrivia: Trivia? = nil) -> TargetFunctionEntrySyntax {
    let targetFunctionEntry = SyntaxFactory.makeTargetFunctionEntry(
      label: label,
      colon: colon,
      delcname: delcname.buildDeclName(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return targetFunctionEntry.withLeadingTrivia(leadingTrivia + (targetFunctionEntry.leadingTrivia ?? []))
    }

    return targetFunctionEntry
  }

  /// Conformance for `TargetFunctionEntry` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let targetFunctionEntry = buildTargetFunctionEntry(format: format, leadingTrivia: leadingTrivia)
    return Syntax(targetFunctionEntry)
  }
}

public protocol ExpressibleByTargetFunctionEntry {
  func createTargetFunctionEntry() -> TargetFunctionEntry
}

extension TargetFunctionEntry: ExpressibleByTargetFunctionEntry {
  public func createTargetFunctionEntry() -> TargetFunctionEntry {
    self
  }
}

/// 
/// The argument for the `@_dynamic_replacement` or `@_private`
/// attribute of the form `for: "function()"` or `sourceFile:
/// "Src.swift"`
/// 
public struct NamedAttributeStringArgument: SyntaxBuildable {
  let nameTok: TokenSyntax
  let colon: TokenSyntax
  let stringOrDeclname: SyntaxBuildable

  public init(
    nameTok: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    stringOrDeclname: ExpressibleBySyntaxBuildable
  ) {
    self.nameTok = nameTok.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.stringOrDeclname = stringOrDeclname.createSyntaxBuildable()
  }
  
  func buildNamedAttributeStringArgument(format: Format, leadingTrivia: Trivia? = nil) -> NamedAttributeStringArgumentSyntax {
    let namedAttributeStringArgument = SyntaxFactory.makeNamedAttributeStringArgument(
      nameTok: nameTok,
      colon: colon,
      stringOrDeclname: stringOrDeclname.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return namedAttributeStringArgument.withLeadingTrivia(leadingTrivia + (namedAttributeStringArgument.leadingTrivia ?? []))
    }

    return namedAttributeStringArgument
  }

  /// Conformance for `NamedAttributeStringArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let namedAttributeStringArgument = buildNamedAttributeStringArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(namedAttributeStringArgument)
  }
}

public protocol ExpressibleByNamedAttributeStringArgument {
  func createNamedAttributeStringArgument() -> NamedAttributeStringArgument
}

extension NamedAttributeStringArgument: ExpressibleByNamedAttributeStringArgument {
  public func createNamedAttributeStringArgument() -> NamedAttributeStringArgument {
    self
  }
}

public struct DeclName: SyntaxBuildable {
  let declBaseName: SyntaxBuildable
  let declNameArguments: DeclNameArguments?

  public init(
    declBaseName: ExpressibleBySyntaxBuildable,
    declNameArguments: ExpressibleByDeclNameArguments? = nil
  ) {
    self.declBaseName = declBaseName.createSyntaxBuildable()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }
  
  func buildDeclName(format: Format, leadingTrivia: Trivia? = nil) -> DeclNameSyntax {
    let declName = SyntaxFactory.makeDeclName(
      declBaseName: declBaseName.buildSyntax(format: format),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return declName.withLeadingTrivia(leadingTrivia + (declName.leadingTrivia ?? []))
    }

    return declName
  }

  /// Conformance for `DeclName` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let declName = buildDeclName(format: format, leadingTrivia: leadingTrivia)
    return Syntax(declName)
  }
}

public protocol ExpressibleByDeclName {
  func createDeclName() -> DeclName
}

extension DeclName: ExpressibleByDeclName {
  public func createDeclName() -> DeclName {
    self
  }
}

/// 
/// The arguments for the `@_implements` attribute of the form
/// `Type, methodName(arg1Label:arg2Label:)`
/// 
public struct ImplementsAttributeArguments: SyntaxBuildable {
  let type: SimpleTypeIdentifier
  let comma: TokenSyntax
  let declBaseName: SyntaxBuildable
  let declNameArguments: DeclNameArguments?

  public init(
    type: ExpressibleBySimpleTypeIdentifier,
    comma: ExpressibleByTokenSyntax = TokenSyntax.`comma`,
    declBaseName: ExpressibleBySyntaxBuildable,
    declNameArguments: ExpressibleByDeclNameArguments? = nil
  ) {
    self.type = type.createSimpleTypeIdentifier()
    self.comma = comma.createTokenSyntax()
    self.declBaseName = declBaseName.createSyntaxBuildable()
    self.declNameArguments = declNameArguments?.createDeclNameArguments()
  }
  
  func buildImplementsAttributeArguments(format: Format, leadingTrivia: Trivia? = nil) -> ImplementsAttributeArgumentsSyntax {
    let implementsAttributeArguments = SyntaxFactory.makeImplementsAttributeArguments(
      type: type.buildSimpleTypeIdentifier(format: format),
      comma: comma,
      declBaseName: declBaseName.buildSyntax(format: format),
      declNameArguments: declNameArguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return implementsAttributeArguments.withLeadingTrivia(leadingTrivia + (implementsAttributeArguments.leadingTrivia ?? []))
    }

    return implementsAttributeArguments
  }

  /// Conformance for `ImplementsAttributeArguments` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let implementsAttributeArguments = buildImplementsAttributeArguments(format: format, leadingTrivia: leadingTrivia)
    return Syntax(implementsAttributeArguments)
  }
}

public protocol ExpressibleByImplementsAttributeArguments {
  func createImplementsAttributeArguments() -> ImplementsAttributeArguments
}

extension ImplementsAttributeArguments: ExpressibleByImplementsAttributeArguments {
  public func createImplementsAttributeArguments() -> ImplementsAttributeArguments {
    self
  }
}

/// 
/// A piece of an Objective-C selector. Either consisiting of just an
/// identifier for a nullary selector, an identifier and a colon for a
/// labeled argument or just a colon for an unlabeled argument
/// 
public struct ObjCSelectorPiece: SyntaxBuildable {
  let name: TokenSyntax?
  let colon: TokenSyntax?

  public init(
    name: ExpressibleByTokenSyntax? = nil,
    colon: ExpressibleByTokenSyntax? = nil
  ) {
    self.name = name?.createTokenSyntax()
    self.colon = colon?.createTokenSyntax()
  }
  
  func buildObjCSelectorPiece(format: Format, leadingTrivia: Trivia? = nil) -> ObjCSelectorPieceSyntax {
    let objCSelectorPiece = SyntaxFactory.makeObjCSelectorPiece(
      name: name,
      colon: colon
    )
    
    if let leadingTrivia = leadingTrivia {
      return objCSelectorPiece.withLeadingTrivia(leadingTrivia + (objCSelectorPiece.leadingTrivia ?? []))
    }

    return objCSelectorPiece
  }

  /// Conformance for `ObjCSelectorPiece` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let objCSelectorPiece = buildObjCSelectorPiece(format: format, leadingTrivia: leadingTrivia)
    return Syntax(objCSelectorPiece)
  }
}

public protocol ExpressibleByObjCSelectorPiece {
  func createObjCSelectorPiece() -> ObjCSelectorPiece
}

extension ObjCSelectorPiece: ExpressibleByObjCSelectorPiece {
  public func createObjCSelectorPiece() -> ObjCSelectorPiece {
    self
  }
}

// MARK: - Syntax collection

/// `ObjCSelector` represents a collection of 
/// `ObjCSelectorPiece`s.
public struct ObjCSelector: SyntaxBuildable {
  let elements: [ObjCSelectorPiece]

  public init(_ elements: [ExpressibleByObjCSelectorPiece]) {
    self.elements = elements.map { $0.createObjCSelectorPiece() }
  }

  public func buildObjCSelector(format: Format) -> ObjCSelectorSyntax {
    return SyntaxFactory.makeObjCSelector(elements.map {
      $0.buildObjCSelectorPiece(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let objCSelector = buildObjCSelector(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(objCSelector).withLeadingTrivia(leadingTrivia + (objCSelector.leadingTrivia ?? []))
    }

    return Syntax(objCSelector)
  }
}

public protocol ExpressibleByObjCSelector {
  func createObjCSelector() -> ObjCSelector
}

extension ObjCSelector: ExpressibleByObjCSelector {
  public func createObjCSelector() -> ObjCSelector {
    self
  }
}

/// 
/// The arguments for the `@differentiable` attribute: an optional
/// differentiability kind, an optional differentiability parameter clause,
/// and an optional 'where' clause.
/// 
public struct DifferentiableAttributeArguments: SyntaxBuildable {
  let diffKind: TokenSyntax?
  let diffKindComma: TokenSyntax?
  let diffParams: DifferentiabilityParamsClause?
  let diffParamsComma: TokenSyntax?
  let whereClause: GenericWhereClause?

  public init(
    diffKind: ExpressibleByTokenSyntax? = nil,
    diffKindComma: ExpressibleByTokenSyntax? = nil,
    diffParams: ExpressibleByDifferentiabilityParamsClause? = nil,
    diffParamsComma: ExpressibleByTokenSyntax? = nil,
    whereClause: ExpressibleByGenericWhereClause? = nil
  ) {
    self.diffKind = diffKind?.createTokenSyntax()
    self.diffKindComma = diffKindComma?.createTokenSyntax()
    self.diffParams = diffParams?.createDifferentiabilityParamsClause()
    self.diffParamsComma = diffParamsComma?.createTokenSyntax()
    self.whereClause = whereClause?.createGenericWhereClause()
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
      return differentiableAttributeArguments.withLeadingTrivia(leadingTrivia + (differentiableAttributeArguments.leadingTrivia ?? []))
    }

    return differentiableAttributeArguments
  }

  /// Conformance for `DifferentiableAttributeArguments` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiableAttributeArguments = buildDifferentiableAttributeArguments(format: format, leadingTrivia: leadingTrivia)
    return Syntax(differentiableAttributeArguments)
  }
}

public protocol ExpressibleByDifferentiableAttributeArguments {
  func createDifferentiableAttributeArguments() -> DifferentiableAttributeArguments
}

extension DifferentiableAttributeArguments: ExpressibleByDifferentiableAttributeArguments {
  public func createDifferentiableAttributeArguments() -> DifferentiableAttributeArguments {
    self
  }
}

/// A clause containing differentiability parameters.
public struct DifferentiabilityParamsClause: SyntaxBuildable {
  let wrtLabel: TokenSyntax
  let colon: TokenSyntax
  let parameters: SyntaxBuildable

  public init(
    wrtLabel: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    parameters: ExpressibleBySyntaxBuildable
  ) {
    self.wrtLabel = wrtLabel.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.parameters = parameters.createSyntaxBuildable()
  }
  
  func buildDifferentiabilityParamsClause(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamsClauseSyntax {
    let differentiabilityParamsClause = SyntaxFactory.makeDifferentiabilityParamsClause(
      wrtLabel: wrtLabel,
      colon: colon,
      parameters: parameters.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return differentiabilityParamsClause.withLeadingTrivia(leadingTrivia + (differentiabilityParamsClause.leadingTrivia ?? []))
    }

    return differentiabilityParamsClause
  }

  /// Conformance for `DifferentiabilityParamsClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiabilityParamsClause = buildDifferentiabilityParamsClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(differentiabilityParamsClause)
  }
}

public protocol ExpressibleByDifferentiabilityParamsClause {
  func createDifferentiabilityParamsClause() -> DifferentiabilityParamsClause
}

extension DifferentiabilityParamsClause: ExpressibleByDifferentiabilityParamsClause {
  public func createDifferentiabilityParamsClause() -> DifferentiabilityParamsClause {
    self
  }
}

/// The differentiability parameters.
public struct DifferentiabilityParams: SyntaxBuildable {
  let leftParen: TokenSyntax
  let diffParams: DifferentiabilityParamList
  let rightParen: TokenSyntax

  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    diffParams: ExpressibleByDifferentiabilityParamList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.diffParams = diffParams.createDifferentiabilityParamList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildDifferentiabilityParams(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamsSyntax {
    let differentiabilityParams = SyntaxFactory.makeDifferentiabilityParams(
      leftParen: leftParen,
      diffParams: diffParams.buildDifferentiabilityParamList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return differentiabilityParams.withLeadingTrivia(leadingTrivia + (differentiabilityParams.leadingTrivia ?? []))
    }

    return differentiabilityParams
  }

  /// Conformance for `DifferentiabilityParams` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiabilityParams = buildDifferentiabilityParams(format: format, leadingTrivia: leadingTrivia)
    return Syntax(differentiabilityParams)
  }
}

public protocol ExpressibleByDifferentiabilityParams {
  func createDifferentiabilityParams() -> DifferentiabilityParams
}

extension DifferentiabilityParams: ExpressibleByDifferentiabilityParams {
  public func createDifferentiabilityParams() -> DifferentiabilityParams {
    self
  }
}

// MARK: - Syntax collection

/// `DifferentiabilityParamList` represents a collection of 
/// `DifferentiabilityParam`s.
public struct DifferentiabilityParamList: SyntaxBuildable {
  let elements: [DifferentiabilityParam]

  public init(_ elements: [ExpressibleByDifferentiabilityParam]) {
    self.elements = elements.map { $0.createDifferentiabilityParam() }
  }

  public func buildDifferentiabilityParamList(format: Format) -> DifferentiabilityParamListSyntax {
    return SyntaxFactory.makeDifferentiabilityParamList(elements.map {
      $0.buildDifferentiabilityParam(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiabilityParamList = buildDifferentiabilityParamList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(differentiabilityParamList).withLeadingTrivia(leadingTrivia + (differentiabilityParamList.leadingTrivia ?? []))
    }

    return Syntax(differentiabilityParamList)
  }
}

public protocol ExpressibleByDifferentiabilityParamList {
  func createDifferentiabilityParamList() -> DifferentiabilityParamList
}

extension DifferentiabilityParamList: ExpressibleByDifferentiabilityParamList {
  public func createDifferentiabilityParamList() -> DifferentiabilityParamList {
    self
  }
}

/// 
/// A differentiability parameter: either the "self" identifier, a function
/// parameter name, or a function parameter index.
/// 
public struct DifferentiabilityParam: SyntaxBuildable {
  let parameter: SyntaxBuildable
  let trailingComma: TokenSyntax?

  public init(
    parameter: ExpressibleBySyntaxBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.parameter = parameter.createSyntaxBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildDifferentiabilityParam(format: Format, leadingTrivia: Trivia? = nil) -> DifferentiabilityParamSyntax {
    let differentiabilityParam = SyntaxFactory.makeDifferentiabilityParam(
      parameter: parameter.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return differentiabilityParam.withLeadingTrivia(leadingTrivia + (differentiabilityParam.leadingTrivia ?? []))
    }

    return differentiabilityParam
  }

  /// Conformance for `DifferentiabilityParam` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let differentiabilityParam = buildDifferentiabilityParam(format: format, leadingTrivia: leadingTrivia)
    return Syntax(differentiabilityParam)
  }
}

public protocol ExpressibleByDifferentiabilityParam {
  func createDifferentiabilityParam() -> DifferentiabilityParam
}

extension DifferentiabilityParam: ExpressibleByDifferentiabilityParam {
  public func createDifferentiabilityParam() -> DifferentiabilityParam {
    self
  }
}

/// 
/// The arguments for the '@derivative(of:)' and '@transpose(of:)'
/// attributes: the 'of:' label, the original declaration name, and an
/// optional differentiability parameter list.
/// 
public struct DerivativeRegistrationAttributeArguments: SyntaxBuildable {
  let ofLabel: TokenSyntax
  let colon: TokenSyntax
  let originalDeclName: QualifiedDeclName
  let period: TokenSyntax?
  let accessorKind: TokenSyntax?
  let comma: TokenSyntax?
  let diffParams: DifferentiabilityParamsClause?

  public init(
    ofLabel: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    originalDeclName: ExpressibleByQualifiedDeclName,
    period: ExpressibleByTokenSyntax? = nil,
    accessorKind: ExpressibleByTokenSyntax? = nil,
    comma: ExpressibleByTokenSyntax? = nil,
    diffParams: ExpressibleByDifferentiabilityParamsClause? = nil
  ) {
    self.ofLabel = ofLabel.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.originalDeclName = originalDeclName.createQualifiedDeclName()
    self.period = period?.createTokenSyntax()
    self.accessorKind = accessorKind?.createTokenSyntax()
    self.comma = comma?.createTokenSyntax()
    self.diffParams = diffParams?.createDifferentiabilityParamsClause()
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
      return derivativeRegistrationAttributeArguments.withLeadingTrivia(leadingTrivia + (derivativeRegistrationAttributeArguments.leadingTrivia ?? []))
    }

    return derivativeRegistrationAttributeArguments
  }

  /// Conformance for `DerivativeRegistrationAttributeArguments` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let derivativeRegistrationAttributeArguments = buildDerivativeRegistrationAttributeArguments(format: format, leadingTrivia: leadingTrivia)
    return Syntax(derivativeRegistrationAttributeArguments)
  }
}

public protocol ExpressibleByDerivativeRegistrationAttributeArguments {
  func createDerivativeRegistrationAttributeArguments() -> DerivativeRegistrationAttributeArguments
}

extension DerivativeRegistrationAttributeArguments: ExpressibleByDerivativeRegistrationAttributeArguments {
  public func createDerivativeRegistrationAttributeArguments() -> DerivativeRegistrationAttributeArguments {
    self
  }
}

/// 
/// An optionally qualified function declaration name (e.g. `+(_:_:)`,
/// `A.B.C.foo(_:_:)`).
/// 
public struct QualifiedDeclName: SyntaxBuildable {
  let baseType: TypeBuildable?
  let dot: TokenSyntax?
  let name: TokenSyntax
  let arguments: DeclNameArguments?

  public init(
    baseType: ExpressibleByTypeBuildable? = nil,
    dot: ExpressibleByTokenSyntax? = nil,
    name: ExpressibleByTokenSyntax,
    arguments: ExpressibleByDeclNameArguments? = nil
  ) {
    self.baseType = baseType?.createTypeBuildable()
    self.dot = dot?.createTokenSyntax()
    self.name = name.createTokenSyntax()
    self.arguments = arguments?.createDeclNameArguments()
  }
  
  func buildQualifiedDeclName(format: Format, leadingTrivia: Trivia? = nil) -> QualifiedDeclNameSyntax {
    let qualifiedDeclName = SyntaxFactory.makeQualifiedDeclName(
      baseType: baseType?.buildType(format: format),
      dot: dot,
      name: name,
      arguments: arguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return qualifiedDeclName.withLeadingTrivia(leadingTrivia + (qualifiedDeclName.leadingTrivia ?? []))
    }

    return qualifiedDeclName
  }

  /// Conformance for `QualifiedDeclName` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let qualifiedDeclName = buildQualifiedDeclName(format: format, leadingTrivia: leadingTrivia)
    return Syntax(qualifiedDeclName)
  }
}

public protocol ExpressibleByQualifiedDeclName {
  func createQualifiedDeclName() -> QualifiedDeclName
}

extension QualifiedDeclName: ExpressibleByQualifiedDeclName {
  public func createQualifiedDeclName() -> QualifiedDeclName {
    self
  }
}

/// A function declaration name (e.g. `foo(_:_:)`).
public struct FunctionDeclName: SyntaxBuildable {
  let name: SyntaxBuildable
  let arguments: DeclNameArguments?

  public init(
    name: ExpressibleBySyntaxBuildable,
    arguments: ExpressibleByDeclNameArguments? = nil
  ) {
    self.name = name.createSyntaxBuildable()
    self.arguments = arguments?.createDeclNameArguments()
  }
  
  func buildFunctionDeclName(format: Format, leadingTrivia: Trivia? = nil) -> FunctionDeclNameSyntax {
    let functionDeclName = SyntaxFactory.makeFunctionDeclName(
      name: name.buildSyntax(format: format),
      arguments: arguments?.buildDeclNameArguments(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return functionDeclName.withLeadingTrivia(leadingTrivia + (functionDeclName.leadingTrivia ?? []))
    }

    return functionDeclName
  }

  /// Conformance for `FunctionDeclName` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let functionDeclName = buildFunctionDeclName(format: format, leadingTrivia: leadingTrivia)
    return Syntax(functionDeclName)
  }
}

public protocol ExpressibleByFunctionDeclName {
  func createFunctionDeclName() -> FunctionDeclName
}

extension FunctionDeclName: ExpressibleByFunctionDeclName {
  public func createFunctionDeclName() -> FunctionDeclName {
    self
  }
}

public struct ContinueStmt: StmtBuildable {
  let continueKeyword: TokenSyntax
  let label: TokenSyntax?

  public init(
    continueKeyword: ExpressibleByTokenSyntax = TokenSyntax.`continue`,
    label: ExpressibleByTokenSyntax? = nil
  ) {
    self.continueKeyword = continueKeyword.createTokenSyntax()
    self.label = label?.createTokenSyntax()
  }
  
  func buildContinueStmt(format: Format, leadingTrivia: Trivia? = nil) -> ContinueStmtSyntax {
    let continueStmt = SyntaxFactory.makeContinueStmt(
      continueKeyword: continueKeyword,
      label: label
    )
    
    if let leadingTrivia = leadingTrivia {
      return continueStmt.withLeadingTrivia(leadingTrivia + (continueStmt.leadingTrivia ?? []))
    }

    return continueStmt
  }

  /// Conformance for `ContinueStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let continueStmt = buildContinueStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(continueStmt)
  }
}

public protocol ExpressibleByContinueStmt {
  func createContinueStmt() -> ContinueStmt
}

extension ContinueStmt: ExpressibleByContinueStmt {
  public func createContinueStmt() -> ContinueStmt {
    self
  }
}

public struct WhileStmt: StmtBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let whileKeyword: TokenSyntax
  let conditions: ConditionElementList
  let body: CodeBlock

  public init(
    labelName: ExpressibleByTokenSyntax? = nil,
    labelColon: ExpressibleByTokenSyntax? = nil,
    whileKeyword: ExpressibleByTokenSyntax = TokenSyntax.`while`,
    conditions: ExpressibleByConditionElementList,
    body: ExpressibleByCodeBlock
  ) {
    self.labelName = labelName?.createTokenSyntax()
    self.labelColon = labelColon?.createTokenSyntax()
    self.whileKeyword = whileKeyword.createTokenSyntax()
    self.conditions = conditions.createConditionElementList()
    self.body = body.createCodeBlock()
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
      return whileStmt.withLeadingTrivia(leadingTrivia + (whileStmt.leadingTrivia ?? []))
    }

    return whileStmt
  }

  /// Conformance for `WhileStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let whileStmt = buildWhileStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(whileStmt)
  }
}

public protocol ExpressibleByWhileStmt {
  func createWhileStmt() -> WhileStmt
}

extension WhileStmt: ExpressibleByWhileStmt {
  public func createWhileStmt() -> WhileStmt {
    self
  }
}

public struct DeferStmt: StmtBuildable {
  let deferKeyword: TokenSyntax
  let body: CodeBlock

  public init(
    deferKeyword: ExpressibleByTokenSyntax = TokenSyntax.`defer`,
    body: ExpressibleByCodeBlock
  ) {
    self.deferKeyword = deferKeyword.createTokenSyntax()
    self.body = body.createCodeBlock()
  }
  
  func buildDeferStmt(format: Format, leadingTrivia: Trivia? = nil) -> DeferStmtSyntax {
    let deferStmt = SyntaxFactory.makeDeferStmt(
      deferKeyword: deferKeyword,
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return deferStmt.withLeadingTrivia(leadingTrivia + (deferStmt.leadingTrivia ?? []))
    }

    return deferStmt
  }

  /// Conformance for `DeferStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let deferStmt = buildDeferStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(deferStmt)
  }
}

public protocol ExpressibleByDeferStmt {
  func createDeferStmt() -> DeferStmt
}

extension DeferStmt: ExpressibleByDeferStmt {
  public func createDeferStmt() -> DeferStmt {
    self
  }
}

public struct ExpressionStmt: StmtBuildable {
  let expression: ExprBuildable

  public init(
    expression: ExpressibleByExprBuildable
  ) {
    self.expression = expression.createExprBuildable()
  }
  
  func buildExpressionStmt(format: Format, leadingTrivia: Trivia? = nil) -> ExpressionStmtSyntax {
    let expressionStmt = SyntaxFactory.makeExpressionStmt(
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return expressionStmt.withLeadingTrivia(leadingTrivia + (expressionStmt.leadingTrivia ?? []))
    }

    return expressionStmt
  }

  /// Conformance for `ExpressionStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let expressionStmt = buildExpressionStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(expressionStmt)
  }
}

public protocol ExpressibleByExpressionStmt {
  func createExpressionStmt() -> ExpressionStmt
}

extension ExpressionStmt: ExpressibleByExpressionStmt {
  public func createExpressionStmt() -> ExpressionStmt {
    self
  }
}

// MARK: - Syntax collection

/// `SwitchCaseList` represents a collection of 
/// `SyntaxBuildable`s.
public struct SwitchCaseList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  public init(_ elements: [ExpressibleBySyntaxBuildable]) {
    self.elements = elements.map { $0.createSyntaxBuildable() }
  }

  public func buildSwitchCaseList(format: Format) -> SwitchCaseListSyntax {
    return SyntaxFactory.makeSwitchCaseList(elements.map {
      $0.buildSyntax(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let switchCaseList = buildSwitchCaseList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(switchCaseList).withLeadingTrivia(leadingTrivia + (switchCaseList.leadingTrivia ?? []))
    }

    return Syntax(switchCaseList)
  }
}

public protocol ExpressibleBySwitchCaseList {
  func createSwitchCaseList() -> SwitchCaseList
}

extension SwitchCaseList: ExpressibleBySwitchCaseList {
  public func createSwitchCaseList() -> SwitchCaseList {
    self
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
    labelName: ExpressibleByTokenSyntax? = nil,
    labelColon: ExpressibleByTokenSyntax? = nil,
    repeatKeyword: ExpressibleByTokenSyntax = TokenSyntax.`repeat`,
    body: ExpressibleByCodeBlock,
    whileKeyword: ExpressibleByTokenSyntax = TokenSyntax.`while`,
    condition: ExpressibleByExprBuildable
  ) {
    self.labelName = labelName?.createTokenSyntax()
    self.labelColon = labelColon?.createTokenSyntax()
    self.repeatKeyword = repeatKeyword.createTokenSyntax()
    self.body = body.createCodeBlock()
    self.whileKeyword = whileKeyword.createTokenSyntax()
    self.condition = condition.createExprBuildable()
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
      return repeatWhileStmt.withLeadingTrivia(leadingTrivia + (repeatWhileStmt.leadingTrivia ?? []))
    }

    return repeatWhileStmt
  }

  /// Conformance for `RepeatWhileStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let repeatWhileStmt = buildRepeatWhileStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(repeatWhileStmt)
  }
}

public protocol ExpressibleByRepeatWhileStmt {
  func createRepeatWhileStmt() -> RepeatWhileStmt
}

extension RepeatWhileStmt: ExpressibleByRepeatWhileStmt {
  public func createRepeatWhileStmt() -> RepeatWhileStmt {
    self
  }
}

public struct GuardStmt: StmtBuildable {
  let guardKeyword: TokenSyntax
  let conditions: ConditionElementList
  let elseKeyword: TokenSyntax
  let body: CodeBlock

  public init(
    guardKeyword: ExpressibleByTokenSyntax = TokenSyntax.`guard`,
    conditions: ExpressibleByConditionElementList,
    elseKeyword: ExpressibleByTokenSyntax = TokenSyntax.`else`,
    body: ExpressibleByCodeBlock
  ) {
    self.guardKeyword = guardKeyword.createTokenSyntax()
    self.conditions = conditions.createConditionElementList()
    self.elseKeyword = elseKeyword.createTokenSyntax()
    self.body = body.createCodeBlock()
  }
  
  func buildGuardStmt(format: Format, leadingTrivia: Trivia? = nil) -> GuardStmtSyntax {
    let guardStmt = SyntaxFactory.makeGuardStmt(
      guardKeyword: guardKeyword,
      conditions: conditions.buildConditionElementList(format: format),
      elseKeyword: elseKeyword,
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return guardStmt.withLeadingTrivia(leadingTrivia + (guardStmt.leadingTrivia ?? []))
    }

    return guardStmt
  }

  /// Conformance for `GuardStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let guardStmt = buildGuardStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(guardStmt)
  }
}

public protocol ExpressibleByGuardStmt {
  func createGuardStmt() -> GuardStmt
}

extension GuardStmt: ExpressibleByGuardStmt {
  public func createGuardStmt() -> GuardStmt {
    self
  }
}

public struct WhereClause: SyntaxBuildable {
  let whereKeyword: TokenSyntax
  let guardResult: ExprBuildable

  public init(
    whereKeyword: ExpressibleByTokenSyntax = TokenSyntax.`where`,
    guardResult: ExpressibleByExprBuildable
  ) {
    self.whereKeyword = whereKeyword.createTokenSyntax()
    self.guardResult = guardResult.createExprBuildable()
  }
  
  func buildWhereClause(format: Format, leadingTrivia: Trivia? = nil) -> WhereClauseSyntax {
    let whereClause = SyntaxFactory.makeWhereClause(
      whereKeyword: whereKeyword,
      guardResult: guardResult.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return whereClause.withLeadingTrivia(leadingTrivia + (whereClause.leadingTrivia ?? []))
    }

    return whereClause
  }

  /// Conformance for `WhereClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let whereClause = buildWhereClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(whereClause)
  }
}

public protocol ExpressibleByWhereClause {
  func createWhereClause() -> WhereClause
}

extension WhereClause: ExpressibleByWhereClause {
  public func createWhereClause() -> WhereClause {
    self
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
    labelName: ExpressibleByTokenSyntax? = nil,
    labelColon: ExpressibleByTokenSyntax? = nil,
    forKeyword: ExpressibleByTokenSyntax = TokenSyntax.`for`,
    tryKeyword: ExpressibleByTokenSyntax? = nil,
    awaitKeyword: ExpressibleByTokenSyntax? = nil,
    caseKeyword: ExpressibleByTokenSyntax? = nil,
    pattern: ExpressibleByPatternBuildable,
    typeAnnotation: ExpressibleByTypeAnnotation? = nil,
    inKeyword: ExpressibleByTokenSyntax = TokenSyntax.`in`,
    sequenceExpr: ExpressibleByExprBuildable,
    whereClause: ExpressibleByWhereClause? = nil,
    body: ExpressibleByCodeBlock
  ) {
    self.labelName = labelName?.createTokenSyntax()
    self.labelColon = labelColon?.createTokenSyntax()
    self.forKeyword = forKeyword.createTokenSyntax()
    self.tryKeyword = tryKeyword?.createTokenSyntax()
    self.awaitKeyword = awaitKeyword?.createTokenSyntax()
    self.caseKeyword = caseKeyword?.createTokenSyntax()
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.inKeyword = inKeyword.createTokenSyntax()
    self.sequenceExpr = sequenceExpr.createExprBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.body = body.createCodeBlock()
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
      return forInStmt.withLeadingTrivia(leadingTrivia + (forInStmt.leadingTrivia ?? []))
    }

    return forInStmt
  }

  /// Conformance for `ForInStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let forInStmt = buildForInStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(forInStmt)
  }
}

public protocol ExpressibleByForInStmt {
  func createForInStmt() -> ForInStmt
}

extension ForInStmt: ExpressibleByForInStmt {
  public func createForInStmt() -> ForInStmt {
    self
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
    labelName: ExpressibleByTokenSyntax? = nil,
    labelColon: ExpressibleByTokenSyntax? = nil,
    switchKeyword: ExpressibleByTokenSyntax = TokenSyntax.`switch`,
    expression: ExpressibleByExprBuildable,
    leftBrace: ExpressibleByTokenSyntax = TokenSyntax.`leftBrace`,
    cases: ExpressibleBySwitchCaseList,
    rightBrace: ExpressibleByTokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.labelName = labelName?.createTokenSyntax()
    self.labelColon = labelColon?.createTokenSyntax()
    self.switchKeyword = switchKeyword.createTokenSyntax()
    self.expression = expression.createExprBuildable()
    self.leftBrace = leftBrace.createTokenSyntax()
    self.cases = cases.createSwitchCaseList()
    self.rightBrace = rightBrace.createTokenSyntax()
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
      return switchStmt.withLeadingTrivia(leadingTrivia + (switchStmt.leadingTrivia ?? []))
    }

    return switchStmt
  }

  /// Conformance for `SwitchStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let switchStmt = buildSwitchStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(switchStmt)
  }
}

public protocol ExpressibleBySwitchStmt {
  func createSwitchStmt() -> SwitchStmt
}

extension SwitchStmt: ExpressibleBySwitchStmt {
  public func createSwitchStmt() -> SwitchStmt {
    self
  }
}

// MARK: - Syntax collection

/// `CatchClauseList` represents a collection of 
/// `CatchClause`s.
public struct CatchClauseList: SyntaxBuildable {
  let elements: [CatchClause]

  public init(_ elements: [ExpressibleByCatchClause]) {
    self.elements = elements.map { $0.createCatchClause() }
  }

  public func buildCatchClauseList(format: Format) -> CatchClauseListSyntax {
    return SyntaxFactory.makeCatchClauseList(elements.map {
      $0.buildCatchClause(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let catchClauseList = buildCatchClauseList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(catchClauseList).withLeadingTrivia(leadingTrivia + (catchClauseList.leadingTrivia ?? []))
    }

    return Syntax(catchClauseList)
  }
}

public protocol ExpressibleByCatchClauseList {
  func createCatchClauseList() -> CatchClauseList
}

extension CatchClauseList: ExpressibleByCatchClauseList {
  public func createCatchClauseList() -> CatchClauseList {
    self
  }
}

public struct DoStmt: StmtBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let doKeyword: TokenSyntax
  let body: CodeBlock
  let catchClauses: CatchClauseList?

  public init(
    labelName: ExpressibleByTokenSyntax? = nil,
    labelColon: ExpressibleByTokenSyntax? = nil,
    doKeyword: ExpressibleByTokenSyntax = TokenSyntax.`do`,
    body: ExpressibleByCodeBlock,
    catchClauses: ExpressibleByCatchClauseList? = nil
  ) {
    self.labelName = labelName?.createTokenSyntax()
    self.labelColon = labelColon?.createTokenSyntax()
    self.doKeyword = doKeyword.createTokenSyntax()
    self.body = body.createCodeBlock()
    self.catchClauses = catchClauses?.createCatchClauseList()
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
      return doStmt.withLeadingTrivia(leadingTrivia + (doStmt.leadingTrivia ?? []))
    }

    return doStmt
  }

  /// Conformance for `DoStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let doStmt = buildDoStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(doStmt)
  }
}

public protocol ExpressibleByDoStmt {
  func createDoStmt() -> DoStmt
}

extension DoStmt: ExpressibleByDoStmt {
  public func createDoStmt() -> DoStmt {
    self
  }
}

public struct ReturnStmt: StmtBuildable {
  let returnKeyword: TokenSyntax
  let expression: ExprBuildable?

  public init(
    returnKeyword: ExpressibleByTokenSyntax = TokenSyntax.`return`,
    expression: ExpressibleByExprBuildable? = nil
  ) {
    self.returnKeyword = returnKeyword.createTokenSyntax()
    self.expression = expression?.createExprBuildable()
  }
  
  func buildReturnStmt(format: Format, leadingTrivia: Trivia? = nil) -> ReturnStmtSyntax {
    let returnStmt = SyntaxFactory.makeReturnStmt(
      returnKeyword: returnKeyword,
      expression: expression?.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return returnStmt.withLeadingTrivia(leadingTrivia + (returnStmt.leadingTrivia ?? []))
    }

    return returnStmt
  }

  /// Conformance for `ReturnStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let returnStmt = buildReturnStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(returnStmt)
  }
}

public protocol ExpressibleByReturnStmt {
  func createReturnStmt() -> ReturnStmt
}

extension ReturnStmt: ExpressibleByReturnStmt {
  public func createReturnStmt() -> ReturnStmt {
    self
  }
}

public struct YieldStmt: StmtBuildable {
  let yieldKeyword: TokenSyntax
  let yields: SyntaxBuildable

  public init(
    yieldKeyword: ExpressibleByTokenSyntax = TokenSyntax.`yield`,
    yields: ExpressibleBySyntaxBuildable
  ) {
    self.yieldKeyword = yieldKeyword.createTokenSyntax()
    self.yields = yields.createSyntaxBuildable()
  }
  
  func buildYieldStmt(format: Format, leadingTrivia: Trivia? = nil) -> YieldStmtSyntax {
    let yieldStmt = SyntaxFactory.makeYieldStmt(
      yieldKeyword: yieldKeyword,
      yields: yields.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return yieldStmt.withLeadingTrivia(leadingTrivia + (yieldStmt.leadingTrivia ?? []))
    }

    return yieldStmt
  }

  /// Conformance for `YieldStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let yieldStmt = buildYieldStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(yieldStmt)
  }
}

public protocol ExpressibleByYieldStmt {
  func createYieldStmt() -> YieldStmt
}

extension YieldStmt: ExpressibleByYieldStmt {
  public func createYieldStmt() -> YieldStmt {
    self
  }
}

public struct YieldList: SyntaxBuildable {
  let leftParen: TokenSyntax
  let elementList: ExprList
  let trailingComma: TokenSyntax?
  let rightParen: TokenSyntax

  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    elementList: ExpressibleByExprList,
    trailingComma: ExpressibleByTokenSyntax? = nil,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.elementList = elementList.createExprList()
    self.trailingComma = trailingComma?.createTokenSyntax()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildYieldList(format: Format, leadingTrivia: Trivia? = nil) -> YieldListSyntax {
    let yieldList = SyntaxFactory.makeYieldList(
      leftParen: leftParen,
      elementList: elementList.buildExprList(format: format),
      trailingComma: trailingComma,
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return yieldList.withLeadingTrivia(leadingTrivia + (yieldList.leadingTrivia ?? []))
    }

    return yieldList
  }

  /// Conformance for `YieldList` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let yieldList = buildYieldList(format: format, leadingTrivia: leadingTrivia)
    return Syntax(yieldList)
  }
}

public protocol ExpressibleByYieldList {
  func createYieldList() -> YieldList
}

extension YieldList: ExpressibleByYieldList {
  public func createYieldList() -> YieldList {
    self
  }
}

public struct FallthroughStmt: StmtBuildable {
  let fallthroughKeyword: TokenSyntax

  public init(
    fallthroughKeyword: ExpressibleByTokenSyntax = TokenSyntax.`fallthrough`
  ) {
    self.fallthroughKeyword = fallthroughKeyword.createTokenSyntax()
  }
  
  func buildFallthroughStmt(format: Format, leadingTrivia: Trivia? = nil) -> FallthroughStmtSyntax {
    let fallthroughStmt = SyntaxFactory.makeFallthroughStmt(
      fallthroughKeyword: fallthroughKeyword
    )
    
    if let leadingTrivia = leadingTrivia {
      return fallthroughStmt.withLeadingTrivia(leadingTrivia + (fallthroughStmt.leadingTrivia ?? []))
    }

    return fallthroughStmt
  }

  /// Conformance for `FallthroughStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let fallthroughStmt = buildFallthroughStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(fallthroughStmt)
  }
}

public protocol ExpressibleByFallthroughStmt {
  func createFallthroughStmt() -> FallthroughStmt
}

extension FallthroughStmt: ExpressibleByFallthroughStmt {
  public func createFallthroughStmt() -> FallthroughStmt {
    self
  }
}

public struct BreakStmt: StmtBuildable {
  let breakKeyword: TokenSyntax
  let label: TokenSyntax?

  public init(
    breakKeyword: ExpressibleByTokenSyntax = TokenSyntax.`break`,
    label: ExpressibleByTokenSyntax? = nil
  ) {
    self.breakKeyword = breakKeyword.createTokenSyntax()
    self.label = label?.createTokenSyntax()
  }
  
  func buildBreakStmt(format: Format, leadingTrivia: Trivia? = nil) -> BreakStmtSyntax {
    let breakStmt = SyntaxFactory.makeBreakStmt(
      breakKeyword: breakKeyword,
      label: label
    )
    
    if let leadingTrivia = leadingTrivia {
      return breakStmt.withLeadingTrivia(leadingTrivia + (breakStmt.leadingTrivia ?? []))
    }

    return breakStmt
  }

  /// Conformance for `BreakStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let breakStmt = buildBreakStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(breakStmt)
  }
}

public protocol ExpressibleByBreakStmt {
  func createBreakStmt() -> BreakStmt
}

extension BreakStmt: ExpressibleByBreakStmt {
  public func createBreakStmt() -> BreakStmt {
    self
  }
}

// MARK: - Syntax collection

/// `CaseItemList` represents a collection of 
/// `CaseItem`s.
public struct CaseItemList: SyntaxBuildable {
  let elements: [CaseItem]

  public init(_ elements: [ExpressibleByCaseItem]) {
    self.elements = elements.map { $0.createCaseItem() }
  }

  public func buildCaseItemList(format: Format) -> CaseItemListSyntax {
    return SyntaxFactory.makeCaseItemList(elements.map {
      $0.buildCaseItem(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let caseItemList = buildCaseItemList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(caseItemList).withLeadingTrivia(leadingTrivia + (caseItemList.leadingTrivia ?? []))
    }

    return Syntax(caseItemList)
  }
}

public protocol ExpressibleByCaseItemList {
  func createCaseItemList() -> CaseItemList
}

extension CaseItemList: ExpressibleByCaseItemList {
  public func createCaseItemList() -> CaseItemList {
    self
  }
}

// MARK: - Syntax collection

/// `CatchItemList` represents a collection of 
/// `CatchItem`s.
public struct CatchItemList: SyntaxBuildable {
  let elements: [CatchItem]

  public init(_ elements: [ExpressibleByCatchItem]) {
    self.elements = elements.map { $0.createCatchItem() }
  }

  public func buildCatchItemList(format: Format) -> CatchItemListSyntax {
    return SyntaxFactory.makeCatchItemList(elements.map {
      $0.buildCatchItem(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let catchItemList = buildCatchItemList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(catchItemList).withLeadingTrivia(leadingTrivia + (catchItemList.leadingTrivia ?? []))
    }

    return Syntax(catchItemList)
  }
}

public protocol ExpressibleByCatchItemList {
  func createCatchItemList() -> CatchItemList
}

extension CatchItemList: ExpressibleByCatchItemList {
  public func createCatchItemList() -> CatchItemList {
    self
  }
}

public struct ConditionElement: SyntaxBuildable {
  let condition: SyntaxBuildable
  let trailingComma: TokenSyntax?

  public init(
    condition: ExpressibleBySyntaxBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.condition = condition.createSyntaxBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildConditionElement(format: Format, leadingTrivia: Trivia? = nil) -> ConditionElementSyntax {
    let conditionElement = SyntaxFactory.makeConditionElement(
      condition: condition.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return conditionElement.withLeadingTrivia(leadingTrivia + (conditionElement.leadingTrivia ?? []))
    }

    return conditionElement
  }

  /// Conformance for `ConditionElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let conditionElement = buildConditionElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(conditionElement)
  }
}

public protocol ExpressibleByConditionElement: ExpressibleByConditionElementList {
  func createConditionElement() -> ConditionElement
}

extension ConditionElement: ExpressibleByConditionElement {
  public func createConditionElement() -> ConditionElement {
    self
  }
}

public struct AvailabilityCondition: SyntaxBuildable {
  let poundAvailableKeyword: TokenSyntax
  let leftParen: TokenSyntax
  let availabilitySpec: AvailabilitySpecList
  let rightParen: TokenSyntax

  public init(
    poundAvailableKeyword: ExpressibleByTokenSyntax = TokenSyntax.`poundAvailable`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    availabilitySpec: ExpressibleByAvailabilitySpecList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundAvailableKeyword = poundAvailableKeyword.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildAvailabilityCondition(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityConditionSyntax {
    let availabilityCondition = SyntaxFactory.makeAvailabilityCondition(
      poundAvailableKeyword: poundAvailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityCondition.withLeadingTrivia(leadingTrivia + (availabilityCondition.leadingTrivia ?? []))
    }

    return availabilityCondition
  }

  /// Conformance for `AvailabilityCondition` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityCondition = buildAvailabilityCondition(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityCondition)
  }
}

public protocol ExpressibleByAvailabilityCondition {
  func createAvailabilityCondition() -> AvailabilityCondition
}

extension AvailabilityCondition: ExpressibleByAvailabilityCondition {
  public func createAvailabilityCondition() -> AvailabilityCondition {
    self
  }
}

public struct MatchingPatternCondition: SyntaxBuildable {
  let caseKeyword: TokenSyntax
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause

  public init(
    caseKeyword: ExpressibleByTokenSyntax = TokenSyntax.`case`,
    pattern: ExpressibleByPatternBuildable,
    typeAnnotation: ExpressibleByTypeAnnotation? = nil,
    initializer: ExpressibleByInitializerClause
  ) {
    self.caseKeyword = caseKeyword.createTokenSyntax()
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer.createInitializerClause()
  }
  
  func buildMatchingPatternCondition(format: Format, leadingTrivia: Trivia? = nil) -> MatchingPatternConditionSyntax {
    let matchingPatternCondition = SyntaxFactory.makeMatchingPatternCondition(
      caseKeyword: caseKeyword,
      pattern: pattern.buildPattern(format: format),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format),
      initializer: initializer.buildInitializerClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return matchingPatternCondition.withLeadingTrivia(leadingTrivia + (matchingPatternCondition.leadingTrivia ?? []))
    }

    return matchingPatternCondition
  }

  /// Conformance for `MatchingPatternCondition` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let matchingPatternCondition = buildMatchingPatternCondition(format: format, leadingTrivia: leadingTrivia)
    return Syntax(matchingPatternCondition)
  }
}

public protocol ExpressibleByMatchingPatternCondition {
  func createMatchingPatternCondition() -> MatchingPatternCondition
}

extension MatchingPatternCondition: ExpressibleByMatchingPatternCondition {
  public func createMatchingPatternCondition() -> MatchingPatternCondition {
    self
  }
}

public struct OptionalBindingCondition: SyntaxBuildable {
  let letOrVarKeyword: TokenSyntax
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause

  public init(
    letOrVarKeyword: ExpressibleByTokenSyntax,
    pattern: ExpressibleByPatternBuildable,
    typeAnnotation: ExpressibleByTypeAnnotation? = nil,
    initializer: ExpressibleByInitializerClause
  ) {
    self.letOrVarKeyword = letOrVarKeyword.createTokenSyntax()
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer.createInitializerClause()
  }
  
  func buildOptionalBindingCondition(format: Format, leadingTrivia: Trivia? = nil) -> OptionalBindingConditionSyntax {
    let optionalBindingCondition = SyntaxFactory.makeOptionalBindingCondition(
      letOrVarKeyword: letOrVarKeyword,
      pattern: pattern.buildPattern(format: format),
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format),
      initializer: initializer.buildInitializerClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return optionalBindingCondition.withLeadingTrivia(leadingTrivia + (optionalBindingCondition.leadingTrivia ?? []))
    }

    return optionalBindingCondition
  }

  /// Conformance for `OptionalBindingCondition` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let optionalBindingCondition = buildOptionalBindingCondition(format: format, leadingTrivia: leadingTrivia)
    return Syntax(optionalBindingCondition)
  }
}

public protocol ExpressibleByOptionalBindingCondition {
  func createOptionalBindingCondition() -> OptionalBindingCondition
}

extension OptionalBindingCondition: ExpressibleByOptionalBindingCondition {
  public func createOptionalBindingCondition() -> OptionalBindingCondition {
    self
  }
}

public struct UnavailabilityCondition: SyntaxBuildable {
  let poundUnavailableKeyword: TokenSyntax
  let leftParen: TokenSyntax
  let availabilitySpec: AvailabilitySpecList
  let rightParen: TokenSyntax

  public init(
    poundUnavailableKeyword: ExpressibleByTokenSyntax = TokenSyntax.`poundUnavailable`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    availabilitySpec: ExpressibleByAvailabilitySpecList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundUnavailableKeyword = poundUnavailableKeyword.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildUnavailabilityCondition(format: Format, leadingTrivia: Trivia? = nil) -> UnavailabilityConditionSyntax {
    let unavailabilityCondition = SyntaxFactory.makeUnavailabilityCondition(
      poundUnavailableKeyword: poundUnavailableKeyword,
      leftParen: leftParen,
      availabilitySpec: availabilitySpec.buildAvailabilitySpecList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return unavailabilityCondition.withLeadingTrivia(leadingTrivia + (unavailabilityCondition.leadingTrivia ?? []))
    }

    return unavailabilityCondition
  }

  /// Conformance for `UnavailabilityCondition` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let unavailabilityCondition = buildUnavailabilityCondition(format: format, leadingTrivia: leadingTrivia)
    return Syntax(unavailabilityCondition)
  }
}

public protocol ExpressibleByUnavailabilityCondition {
  func createUnavailabilityCondition() -> UnavailabilityCondition
}

extension UnavailabilityCondition: ExpressibleByUnavailabilityCondition {
  public func createUnavailabilityCondition() -> UnavailabilityCondition {
    self
  }
}

// MARK: - Syntax collection

/// `ConditionElementList` represents a collection of 
/// `ConditionElement`s.
public struct ConditionElementList: SyntaxBuildable {
  let elements: [ConditionElement]

  public init(_ elements: [ExpressibleByConditionElement]) {
    self.elements = elements.map { $0.createConditionElement() }
  }

  public func buildConditionElementList(format: Format) -> ConditionElementListSyntax {
    return SyntaxFactory.makeConditionElementList(elements.map {
      $0.buildConditionElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let conditionElementList = buildConditionElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(conditionElementList).withLeadingTrivia(leadingTrivia + (conditionElementList.leadingTrivia ?? []))
    }

    return Syntax(conditionElementList)
  }
}

public protocol ExpressibleByConditionElementList {
  func createConditionElementList() -> ConditionElementList
}

extension ConditionElementList: ExpressibleByConditionElementList {
  public func createConditionElementList() -> ConditionElementList {
    self
  }
}

public struct DeclarationStmt: StmtBuildable {
  let declaration: DeclBuildable

  public init(
    declaration: ExpressibleByDeclBuildable
  ) {
    self.declaration = declaration.createDeclBuildable()
  }
  
  func buildDeclarationStmt(format: Format, leadingTrivia: Trivia? = nil) -> DeclarationStmtSyntax {
    let declarationStmt = SyntaxFactory.makeDeclarationStmt(
      declaration: declaration.buildDecl(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return declarationStmt.withLeadingTrivia(leadingTrivia + (declarationStmt.leadingTrivia ?? []))
    }

    return declarationStmt
  }

  /// Conformance for `DeclarationStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let declarationStmt = buildDeclarationStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(declarationStmt)
  }
}

public protocol ExpressibleByDeclarationStmt {
  func createDeclarationStmt() -> DeclarationStmt
}

extension DeclarationStmt: ExpressibleByDeclarationStmt {
  public func createDeclarationStmt() -> DeclarationStmt {
    self
  }
}

public struct ThrowStmt: StmtBuildable {
  let throwKeyword: TokenSyntax
  let expression: ExprBuildable

  public init(
    throwKeyword: ExpressibleByTokenSyntax = TokenSyntax.`throw`,
    expression: ExpressibleByExprBuildable
  ) {
    self.throwKeyword = throwKeyword.createTokenSyntax()
    self.expression = expression.createExprBuildable()
  }
  
  func buildThrowStmt(format: Format, leadingTrivia: Trivia? = nil) -> ThrowStmtSyntax {
    let throwStmt = SyntaxFactory.makeThrowStmt(
      throwKeyword: throwKeyword,
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return throwStmt.withLeadingTrivia(leadingTrivia + (throwStmt.leadingTrivia ?? []))
    }

    return throwStmt
  }

  /// Conformance for `ThrowStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let throwStmt = buildThrowStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(throwStmt)
  }
}

public protocol ExpressibleByThrowStmt {
  func createThrowStmt() -> ThrowStmt
}

extension ThrowStmt: ExpressibleByThrowStmt {
  public func createThrowStmt() -> ThrowStmt {
    self
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
    labelName: ExpressibleByTokenSyntax? = nil,
    labelColon: ExpressibleByTokenSyntax? = nil,
    ifKeyword: ExpressibleByTokenSyntax = TokenSyntax.`if`,
    conditions: ExpressibleByConditionElementList,
    body: ExpressibleByCodeBlock,
    elseKeyword: ExpressibleByTokenSyntax? = nil,
    elseBody: ExpressibleBySyntaxBuildable? = nil
  ) {
    self.labelName = labelName?.createTokenSyntax()
    self.labelColon = labelColon?.createTokenSyntax()
    self.ifKeyword = ifKeyword.createTokenSyntax()
    self.conditions = conditions.createConditionElementList()
    self.body = body.createCodeBlock()
    self.elseKeyword = elseKeyword?.createTokenSyntax()
    self.elseBody = elseBody?.createSyntaxBuildable()
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
      return ifStmt.withLeadingTrivia(leadingTrivia + (ifStmt.leadingTrivia ?? []))
    }

    return ifStmt
  }

  /// Conformance for `IfStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let ifStmt = buildIfStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(ifStmt)
  }
}

public protocol ExpressibleByIfStmt {
  func createIfStmt() -> IfStmt
}

extension IfStmt: ExpressibleByIfStmt {
  public func createIfStmt() -> IfStmt {
    self
  }
}

public struct ElseIfContinuation: SyntaxBuildable {
  let ifStatement: IfStmt

  public init(
    ifStatement: ExpressibleByIfStmt
  ) {
    self.ifStatement = ifStatement.createIfStmt()
  }
  
  func buildElseIfContinuation(format: Format, leadingTrivia: Trivia? = nil) -> ElseIfContinuationSyntax {
    let elseIfContinuation = SyntaxFactory.makeElseIfContinuation(
      ifStatement: ifStatement.buildIfStmt(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return elseIfContinuation.withLeadingTrivia(leadingTrivia + (elseIfContinuation.leadingTrivia ?? []))
    }

    return elseIfContinuation
  }

  /// Conformance for `ElseIfContinuation` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let elseIfContinuation = buildElseIfContinuation(format: format, leadingTrivia: leadingTrivia)
    return Syntax(elseIfContinuation)
  }
}

public protocol ExpressibleByElseIfContinuation {
  func createElseIfContinuation() -> ElseIfContinuation
}

extension ElseIfContinuation: ExpressibleByElseIfContinuation {
  public func createElseIfContinuation() -> ElseIfContinuation {
    self
  }
}

public struct ElseBlock: SyntaxBuildable {
  let elseKeyword: TokenSyntax
  let body: CodeBlock

  public init(
    elseKeyword: ExpressibleByTokenSyntax = TokenSyntax.`else`,
    body: ExpressibleByCodeBlock
  ) {
    self.elseKeyword = elseKeyword.createTokenSyntax()
    self.body = body.createCodeBlock()
  }
  
  func buildElseBlock(format: Format, leadingTrivia: Trivia? = nil) -> ElseBlockSyntax {
    let elseBlock = SyntaxFactory.makeElseBlock(
      elseKeyword: elseKeyword,
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return elseBlock.withLeadingTrivia(leadingTrivia + (elseBlock.leadingTrivia ?? []))
    }

    return elseBlock
  }

  /// Conformance for `ElseBlock` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let elseBlock = buildElseBlock(format: format, leadingTrivia: leadingTrivia)
    return Syntax(elseBlock)
  }
}

public protocol ExpressibleByElseBlock {
  func createElseBlock() -> ElseBlock
}

extension ElseBlock: ExpressibleByElseBlock {
  public func createElseBlock() -> ElseBlock {
    self
  }
}

public struct SwitchCase: SyntaxBuildable {
  let unknownAttr: Attribute?
  let label: SyntaxBuildable
  let statements: CodeBlockItemList

  public init(
    unknownAttr: ExpressibleByAttribute? = nil,
    label: ExpressibleBySyntaxBuildable,
    statements: ExpressibleByCodeBlockItemList
  ) {
    self.unknownAttr = unknownAttr?.createAttribute()
    self.label = label.createSyntaxBuildable()
    self.statements = statements.createCodeBlockItemList()
  }
  
  func buildSwitchCase(format: Format, leadingTrivia: Trivia? = nil) -> SwitchCaseSyntax {
    let switchCase = SyntaxFactory.makeSwitchCase(
      unknownAttr: unknownAttr?.buildAttribute(format: format),
      label: label.buildSyntax(format: format),
      statements: statements.buildCodeBlockItemList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return switchCase.withLeadingTrivia(leadingTrivia + (switchCase.leadingTrivia ?? []))
    }

    return switchCase
  }

  /// Conformance for `SwitchCase` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let switchCase = buildSwitchCase(format: format, leadingTrivia: leadingTrivia)
    return Syntax(switchCase)
  }
}

public protocol ExpressibleBySwitchCase {
  func createSwitchCase() -> SwitchCase
}

extension SwitchCase: ExpressibleBySwitchCase {
  public func createSwitchCase() -> SwitchCase {
    self
  }
}

public struct SwitchDefaultLabel: SyntaxBuildable {
  let defaultKeyword: TokenSyntax
  let colon: TokenSyntax

  public init(
    defaultKeyword: ExpressibleByTokenSyntax = TokenSyntax.`default`,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`
  ) {
    self.defaultKeyword = defaultKeyword.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
  }
  
  func buildSwitchDefaultLabel(format: Format, leadingTrivia: Trivia? = nil) -> SwitchDefaultLabelSyntax {
    let switchDefaultLabel = SyntaxFactory.makeSwitchDefaultLabel(
      defaultKeyword: defaultKeyword,
      colon: colon
    )
    
    if let leadingTrivia = leadingTrivia {
      return switchDefaultLabel.withLeadingTrivia(leadingTrivia + (switchDefaultLabel.leadingTrivia ?? []))
    }

    return switchDefaultLabel
  }

  /// Conformance for `SwitchDefaultLabel` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let switchDefaultLabel = buildSwitchDefaultLabel(format: format, leadingTrivia: leadingTrivia)
    return Syntax(switchDefaultLabel)
  }
}

public protocol ExpressibleBySwitchDefaultLabel {
  func createSwitchDefaultLabel() -> SwitchDefaultLabel
}

extension SwitchDefaultLabel: ExpressibleBySwitchDefaultLabel {
  public func createSwitchDefaultLabel() -> SwitchDefaultLabel {
    self
  }
}

public struct CaseItem: SyntaxBuildable {
  let pattern: PatternBuildable
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  public init(
    pattern: ExpressibleByPatternBuildable,
    whereClause: ExpressibleByWhereClause? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildCaseItem(format: Format, leadingTrivia: Trivia? = nil) -> CaseItemSyntax {
    let caseItem = SyntaxFactory.makeCaseItem(
      pattern: pattern.buildPattern(format: format),
      whereClause: whereClause?.buildWhereClause(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return caseItem.withLeadingTrivia(leadingTrivia + (caseItem.leadingTrivia ?? []))
    }

    return caseItem
  }

  /// Conformance for `CaseItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let caseItem = buildCaseItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(caseItem)
  }
}

public protocol ExpressibleByCaseItem {
  func createCaseItem() -> CaseItem
}

extension CaseItem: ExpressibleByCaseItem {
  public func createCaseItem() -> CaseItem {
    self
  }
}

public struct CatchItem: SyntaxBuildable {
  let pattern: PatternBuildable?
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  public init(
    pattern: ExpressibleByPatternBuildable? = nil,
    whereClause: ExpressibleByWhereClause? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.pattern = pattern?.createPatternBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildCatchItem(format: Format, leadingTrivia: Trivia? = nil) -> CatchItemSyntax {
    let catchItem = SyntaxFactory.makeCatchItem(
      pattern: pattern?.buildPattern(format: format),
      whereClause: whereClause?.buildWhereClause(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return catchItem.withLeadingTrivia(leadingTrivia + (catchItem.leadingTrivia ?? []))
    }

    return catchItem
  }

  /// Conformance for `CatchItem` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let catchItem = buildCatchItem(format: format, leadingTrivia: leadingTrivia)
    return Syntax(catchItem)
  }
}

public protocol ExpressibleByCatchItem {
  func createCatchItem() -> CatchItem
}

extension CatchItem: ExpressibleByCatchItem {
  public func createCatchItem() -> CatchItem {
    self
  }
}

public struct SwitchCaseLabel: SyntaxBuildable {
  let caseKeyword: TokenSyntax
  let caseItems: CaseItemList
  let colon: TokenSyntax

  public init(
    caseKeyword: ExpressibleByTokenSyntax = TokenSyntax.`case`,
    caseItems: ExpressibleByCaseItemList,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`
  ) {
    self.caseKeyword = caseKeyword.createTokenSyntax()
    self.caseItems = caseItems.createCaseItemList()
    self.colon = colon.createTokenSyntax()
  }
  
  func buildSwitchCaseLabel(format: Format, leadingTrivia: Trivia? = nil) -> SwitchCaseLabelSyntax {
    let switchCaseLabel = SyntaxFactory.makeSwitchCaseLabel(
      caseKeyword: caseKeyword,
      caseItems: caseItems.buildCaseItemList(format: format),
      colon: colon
    )
    
    if let leadingTrivia = leadingTrivia {
      return switchCaseLabel.withLeadingTrivia(leadingTrivia + (switchCaseLabel.leadingTrivia ?? []))
    }

    return switchCaseLabel
  }

  /// Conformance for `SwitchCaseLabel` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let switchCaseLabel = buildSwitchCaseLabel(format: format, leadingTrivia: leadingTrivia)
    return Syntax(switchCaseLabel)
  }
}

public protocol ExpressibleBySwitchCaseLabel {
  func createSwitchCaseLabel() -> SwitchCaseLabel
}

extension SwitchCaseLabel: ExpressibleBySwitchCaseLabel {
  public func createSwitchCaseLabel() -> SwitchCaseLabel {
    self
  }
}

public struct CatchClause: SyntaxBuildable {
  let catchKeyword: TokenSyntax
  let catchItems: CatchItemList?
  let body: CodeBlock

  public init(
    catchKeyword: ExpressibleByTokenSyntax = TokenSyntax.`catch`,
    catchItems: ExpressibleByCatchItemList? = nil,
    body: ExpressibleByCodeBlock
  ) {
    self.catchKeyword = catchKeyword.createTokenSyntax()
    self.catchItems = catchItems?.createCatchItemList()
    self.body = body.createCodeBlock()
  }
  
  func buildCatchClause(format: Format, leadingTrivia: Trivia? = nil) -> CatchClauseSyntax {
    let catchClause = SyntaxFactory.makeCatchClause(
      catchKeyword: catchKeyword,
      catchItems: catchItems?.buildCatchItemList(format: format),
      body: body.buildCodeBlock(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return catchClause.withLeadingTrivia(leadingTrivia + (catchClause.leadingTrivia ?? []))
    }

    return catchClause
  }

  /// Conformance for `CatchClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let catchClause = buildCatchClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(catchClause)
  }
}

public protocol ExpressibleByCatchClause {
  func createCatchClause() -> CatchClause
}

extension CatchClause: ExpressibleByCatchClause {
  public func createCatchClause() -> CatchClause {
    self
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
    poundAssert: ExpressibleByTokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    condition: ExpressibleByExprBuildable,
    comma: ExpressibleByTokenSyntax? = nil,
    message: ExpressibleByTokenSyntax? = nil,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundAssert = poundAssert.createTokenSyntax()
    self.leftParen = leftParen.createTokenSyntax()
    self.condition = condition.createExprBuildable()
    self.comma = comma?.createTokenSyntax()
    self.message = message?.createTokenSyntax()
    self.rightParen = rightParen.createTokenSyntax()
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
      return poundAssertStmt.withLeadingTrivia(leadingTrivia + (poundAssertStmt.leadingTrivia ?? []))
    }

    return poundAssertStmt
  }

  /// Conformance for `PoundAssertStmt` to the `StmtBuildable` protocol.
  public func buildStmt(format: Format, leadingTrivia: Trivia? = nil) -> StmtSyntax {
    let poundAssertStmt = buildPoundAssertStmt(format: format, leadingTrivia: leadingTrivia)
    return StmtSyntax(poundAssertStmt)
  }
}

public protocol ExpressibleByPoundAssertStmt {
  func createPoundAssertStmt() -> PoundAssertStmt
}

extension PoundAssertStmt: ExpressibleByPoundAssertStmt {
  public func createPoundAssertStmt() -> PoundAssertStmt {
    self
  }
}

public struct GenericWhereClause: SyntaxBuildable {
  let whereKeyword: TokenSyntax
  let requirementList: GenericRequirementList

  public init(
    whereKeyword: ExpressibleByTokenSyntax = TokenSyntax.`where`,
    requirementList: ExpressibleByGenericRequirementList
  ) {
    self.whereKeyword = whereKeyword.createTokenSyntax()
    self.requirementList = requirementList.createGenericRequirementList()
  }
  
  func buildGenericWhereClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericWhereClauseSyntax {
    let genericWhereClause = SyntaxFactory.makeGenericWhereClause(
      whereKeyword: whereKeyword,
      requirementList: requirementList.buildGenericRequirementList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericWhereClause.withLeadingTrivia(leadingTrivia + (genericWhereClause.leadingTrivia ?? []))
    }

    return genericWhereClause
  }

  /// Conformance for `GenericWhereClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericWhereClause = buildGenericWhereClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericWhereClause)
  }
}

public protocol ExpressibleByGenericWhereClause {
  func createGenericWhereClause() -> GenericWhereClause
}

extension GenericWhereClause: ExpressibleByGenericWhereClause {
  public func createGenericWhereClause() -> GenericWhereClause {
    self
  }
}

// MARK: - Syntax collection

/// `GenericRequirementList` represents a collection of 
/// `GenericRequirement`s.
public struct GenericRequirementList: SyntaxBuildable {
  let elements: [GenericRequirement]

  public init(_ elements: [ExpressibleByGenericRequirement]) {
    self.elements = elements.map { $0.createGenericRequirement() }
  }

  public func buildGenericRequirementList(format: Format) -> GenericRequirementListSyntax {
    return SyntaxFactory.makeGenericRequirementList(elements.map {
      $0.buildGenericRequirement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericRequirementList = buildGenericRequirementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(genericRequirementList).withLeadingTrivia(leadingTrivia + (genericRequirementList.leadingTrivia ?? []))
    }

    return Syntax(genericRequirementList)
  }
}

public protocol ExpressibleByGenericRequirementList {
  func createGenericRequirementList() -> GenericRequirementList
}

extension GenericRequirementList: ExpressibleByGenericRequirementList {
  public func createGenericRequirementList() -> GenericRequirementList {
    self
  }
}

public struct GenericRequirement: SyntaxBuildable {
  let body: SyntaxBuildable
  let trailingComma: TokenSyntax?

  public init(
    body: ExpressibleBySyntaxBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.body = body.createSyntaxBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildGenericRequirement(format: Format, leadingTrivia: Trivia? = nil) -> GenericRequirementSyntax {
    let genericRequirement = SyntaxFactory.makeGenericRequirement(
      body: body.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericRequirement.withLeadingTrivia(leadingTrivia + (genericRequirement.leadingTrivia ?? []))
    }

    return genericRequirement
  }

  /// Conformance for `GenericRequirement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericRequirement = buildGenericRequirement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericRequirement)
  }
}

public protocol ExpressibleByGenericRequirement {
  func createGenericRequirement() -> GenericRequirement
}

extension GenericRequirement: ExpressibleByGenericRequirement {
  public func createGenericRequirement() -> GenericRequirement {
    self
  }
}

public struct SameTypeRequirement: SyntaxBuildable {
  let leftTypeIdentifier: TypeBuildable
  let equalityToken: TokenSyntax
  let rightTypeIdentifier: TypeBuildable

  public init(
    leftTypeIdentifier: ExpressibleByTypeBuildable,
    equalityToken: ExpressibleByTokenSyntax,
    rightTypeIdentifier: ExpressibleByTypeBuildable
  ) {
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.equalityToken = equalityToken.createTokenSyntax()
    self.rightTypeIdentifier = rightTypeIdentifier.createTypeBuildable()
  }
  
  func buildSameTypeRequirement(format: Format, leadingTrivia: Trivia? = nil) -> SameTypeRequirementSyntax {
    let sameTypeRequirement = SyntaxFactory.makeSameTypeRequirement(
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format),
      equalityToken: equalityToken,
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return sameTypeRequirement.withLeadingTrivia(leadingTrivia + (sameTypeRequirement.leadingTrivia ?? []))
    }

    return sameTypeRequirement
  }

  /// Conformance for `SameTypeRequirement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let sameTypeRequirement = buildSameTypeRequirement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(sameTypeRequirement)
  }
}

public protocol ExpressibleBySameTypeRequirement {
  func createSameTypeRequirement() -> SameTypeRequirement
}

extension SameTypeRequirement: ExpressibleBySameTypeRequirement {
  public func createSameTypeRequirement() -> SameTypeRequirement {
    self
  }
}

// MARK: - Syntax collection

/// `GenericParameterList` represents a collection of 
/// `GenericParameter`s.
public struct GenericParameterList: SyntaxBuildable {
  let elements: [GenericParameter]

  public init(_ elements: [ExpressibleByGenericParameter]) {
    self.elements = elements.map { $0.createGenericParameter() }
  }

  public func buildGenericParameterList(format: Format) -> GenericParameterListSyntax {
    return SyntaxFactory.makeGenericParameterList(elements.map {
      $0.buildGenericParameter(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericParameterList = buildGenericParameterList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(genericParameterList).withLeadingTrivia(leadingTrivia + (genericParameterList.leadingTrivia ?? []))
    }

    return Syntax(genericParameterList)
  }
}

public protocol ExpressibleByGenericParameterList {
  func createGenericParameterList() -> GenericParameterList
}

extension GenericParameterList: ExpressibleByGenericParameterList {
  public func createGenericParameterList() -> GenericParameterList {
    self
  }
}

public struct GenericParameter: SyntaxBuildable {
  let attributes: AttributeList?
  let name: TokenSyntax
  let colon: TokenSyntax?
  let inheritedType: TypeBuildable?
  let trailingComma: TokenSyntax?

  public init(
    attributes: ExpressibleByAttributeList? = nil,
    name: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax? = nil,
    inheritedType: ExpressibleByTypeBuildable? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.name = name.createTokenSyntax()
    self.colon = colon?.createTokenSyntax()
    self.inheritedType = inheritedType?.createTypeBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
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
      return genericParameter.withLeadingTrivia(leadingTrivia + (genericParameter.leadingTrivia ?? []))
    }

    return genericParameter
  }

  /// Conformance for `GenericParameter` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericParameter = buildGenericParameter(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericParameter)
  }
}

public protocol ExpressibleByGenericParameter {
  func createGenericParameter() -> GenericParameter
}

extension GenericParameter: ExpressibleByGenericParameter {
  public func createGenericParameter() -> GenericParameter {
    self
  }
}

public struct GenericParameterClause: SyntaxBuildable {
  let leftAngleBracket: TokenSyntax
  let genericParameterList: GenericParameterList
  let rightAngleBracket: TokenSyntax

  public init(
    leftAngleBracket: ExpressibleByTokenSyntax = TokenSyntax.`leftAngle`,
    genericParameterList: ExpressibleByGenericParameterList,
    rightAngleBracket: ExpressibleByTokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leftAngleBracket = leftAngleBracket.createTokenSyntax()
    self.genericParameterList = genericParameterList.createGenericParameterList()
    self.rightAngleBracket = rightAngleBracket.createTokenSyntax()
  }
  
  func buildGenericParameterClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericParameterClauseSyntax {
    let genericParameterClause = SyntaxFactory.makeGenericParameterClause(
      leftAngleBracket: leftAngleBracket,
      genericParameterList: genericParameterList.buildGenericParameterList(format: format),
      rightAngleBracket: rightAngleBracket
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericParameterClause.withLeadingTrivia(leadingTrivia + (genericParameterClause.leadingTrivia ?? []))
    }

    return genericParameterClause
  }

  /// Conformance for `GenericParameterClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericParameterClause = buildGenericParameterClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericParameterClause)
  }
}

public protocol ExpressibleByGenericParameterClause {
  func createGenericParameterClause() -> GenericParameterClause
}

extension GenericParameterClause: ExpressibleByGenericParameterClause {
  public func createGenericParameterClause() -> GenericParameterClause {
    self
  }
}

public struct ConformanceRequirement: SyntaxBuildable {
  let leftTypeIdentifier: TypeBuildable
  let colon: TokenSyntax
  let rightTypeIdentifier: TypeBuildable

  public init(
    leftTypeIdentifier: ExpressibleByTypeBuildable,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    rightTypeIdentifier: ExpressibleByTypeBuildable
  ) {
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.colon = colon.createTokenSyntax()
    self.rightTypeIdentifier = rightTypeIdentifier.createTypeBuildable()
  }
  
  func buildConformanceRequirement(format: Format, leadingTrivia: Trivia? = nil) -> ConformanceRequirementSyntax {
    let conformanceRequirement = SyntaxFactory.makeConformanceRequirement(
      leftTypeIdentifier: leftTypeIdentifier.buildType(format: format),
      colon: colon,
      rightTypeIdentifier: rightTypeIdentifier.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return conformanceRequirement.withLeadingTrivia(leadingTrivia + (conformanceRequirement.leadingTrivia ?? []))
    }

    return conformanceRequirement
  }

  /// Conformance for `ConformanceRequirement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let conformanceRequirement = buildConformanceRequirement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(conformanceRequirement)
  }
}

public protocol ExpressibleByConformanceRequirement {
  func createConformanceRequirement() -> ConformanceRequirement
}

extension ConformanceRequirement: ExpressibleByConformanceRequirement {
  public func createConformanceRequirement() -> ConformanceRequirement {
    self
  }
}

public struct SimpleTypeIdentifier: TypeBuildable {
  let name: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  public init(
    name: ExpressibleByTokenSyntax,
    genericArgumentClause: ExpressibleByGenericArgumentClause? = nil
  ) {
    self.name = name.createTokenSyntax()
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }
  
  func buildSimpleTypeIdentifier(format: Format, leadingTrivia: Trivia? = nil) -> SimpleTypeIdentifierSyntax {
    let simpleTypeIdentifier = SyntaxFactory.makeSimpleTypeIdentifier(
      name: name,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return simpleTypeIdentifier.withLeadingTrivia(leadingTrivia + (simpleTypeIdentifier.leadingTrivia ?? []))
    }

    return simpleTypeIdentifier
  }

  /// Conformance for `SimpleTypeIdentifier` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let simpleTypeIdentifier = buildSimpleTypeIdentifier(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(simpleTypeIdentifier)
  }
}

public protocol ExpressibleBySimpleTypeIdentifier {
  func createSimpleTypeIdentifier() -> SimpleTypeIdentifier
}

extension SimpleTypeIdentifier: ExpressibleBySimpleTypeIdentifier {
  public func createSimpleTypeIdentifier() -> SimpleTypeIdentifier {
    self
  }
}

public struct MemberTypeIdentifier: TypeBuildable {
  let baseType: TypeBuildable
  let period: TokenSyntax
  let name: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  public init(
    baseType: ExpressibleByTypeBuildable,
    period: ExpressibleByTokenSyntax,
    name: ExpressibleByTokenSyntax,
    genericArgumentClause: ExpressibleByGenericArgumentClause? = nil
  ) {
    self.baseType = baseType.createTypeBuildable()
    self.period = period.createTokenSyntax()
    self.name = name.createTokenSyntax()
    self.genericArgumentClause = genericArgumentClause?.createGenericArgumentClause()
  }
  
  func buildMemberTypeIdentifier(format: Format, leadingTrivia: Trivia? = nil) -> MemberTypeIdentifierSyntax {
    let memberTypeIdentifier = SyntaxFactory.makeMemberTypeIdentifier(
      baseType: baseType.buildType(format: format),
      period: period,
      name: name,
      genericArgumentClause: genericArgumentClause?.buildGenericArgumentClause(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return memberTypeIdentifier.withLeadingTrivia(leadingTrivia + (memberTypeIdentifier.leadingTrivia ?? []))
    }

    return memberTypeIdentifier
  }

  /// Conformance for `MemberTypeIdentifier` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let memberTypeIdentifier = buildMemberTypeIdentifier(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(memberTypeIdentifier)
  }
}

public protocol ExpressibleByMemberTypeIdentifier {
  func createMemberTypeIdentifier() -> MemberTypeIdentifier
}

extension MemberTypeIdentifier: ExpressibleByMemberTypeIdentifier {
  public func createMemberTypeIdentifier() -> MemberTypeIdentifier {
    self
  }
}

public struct ClassRestrictionType: TypeBuildable {
  let classKeyword: TokenSyntax

  public init(
    classKeyword: ExpressibleByTokenSyntax = TokenSyntax.`class`
  ) {
    self.classKeyword = classKeyword.createTokenSyntax()
  }
  
  func buildClassRestrictionType(format: Format, leadingTrivia: Trivia? = nil) -> ClassRestrictionTypeSyntax {
    let classRestrictionType = SyntaxFactory.makeClassRestrictionType(
      classKeyword: classKeyword
    )
    
    if let leadingTrivia = leadingTrivia {
      return classRestrictionType.withLeadingTrivia(leadingTrivia + (classRestrictionType.leadingTrivia ?? []))
    }

    return classRestrictionType
  }

  /// Conformance for `ClassRestrictionType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let classRestrictionType = buildClassRestrictionType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(classRestrictionType)
  }
}

public protocol ExpressibleByClassRestrictionType {
  func createClassRestrictionType() -> ClassRestrictionType
}

extension ClassRestrictionType: ExpressibleByClassRestrictionType {
  public func createClassRestrictionType() -> ClassRestrictionType {
    self
  }
}

public struct ArrayType: TypeBuildable {
  let leftSquareBracket: TokenSyntax
  let elementType: TypeBuildable
  let rightSquareBracket: TokenSyntax

  public init(
    leftSquareBracket: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    elementType: ExpressibleByTypeBuildable,
    rightSquareBracket: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquareBracket = leftSquareBracket.createTokenSyntax()
    self.elementType = elementType.createTypeBuildable()
    self.rightSquareBracket = rightSquareBracket.createTokenSyntax()
  }
  
  func buildArrayType(format: Format, leadingTrivia: Trivia? = nil) -> ArrayTypeSyntax {
    let arrayType = SyntaxFactory.makeArrayType(
      leftSquareBracket: leftSquareBracket,
      elementType: elementType.buildType(format: format),
      rightSquareBracket: rightSquareBracket
    )
    
    if let leadingTrivia = leadingTrivia {
      return arrayType.withLeadingTrivia(leadingTrivia + (arrayType.leadingTrivia ?? []))
    }

    return arrayType
  }

  /// Conformance for `ArrayType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let arrayType = buildArrayType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(arrayType)
  }
}

public protocol ExpressibleByArrayType {
  func createArrayType() -> ArrayType
}

extension ArrayType: ExpressibleByArrayType {
  public func createArrayType() -> ArrayType {
    self
  }
}

public struct DictionaryType: TypeBuildable {
  let leftSquareBracket: TokenSyntax
  let keyType: TypeBuildable
  let colon: TokenSyntax
  let valueType: TypeBuildable
  let rightSquareBracket: TokenSyntax

  public init(
    leftSquareBracket: ExpressibleByTokenSyntax = TokenSyntax.`leftSquareBracket`,
    keyType: ExpressibleByTypeBuildable,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    valueType: ExpressibleByTypeBuildable,
    rightSquareBracket: ExpressibleByTokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquareBracket = leftSquareBracket.createTokenSyntax()
    self.keyType = keyType.createTypeBuildable()
    self.colon = colon.createTokenSyntax()
    self.valueType = valueType.createTypeBuildable()
    self.rightSquareBracket = rightSquareBracket.createTokenSyntax()
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
      return dictionaryType.withLeadingTrivia(leadingTrivia + (dictionaryType.leadingTrivia ?? []))
    }

    return dictionaryType
  }

  /// Conformance for `DictionaryType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let dictionaryType = buildDictionaryType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(dictionaryType)
  }
}

public protocol ExpressibleByDictionaryType {
  func createDictionaryType() -> DictionaryType
}

extension DictionaryType: ExpressibleByDictionaryType {
  public func createDictionaryType() -> DictionaryType {
    self
  }
}

public struct MetatypeType: TypeBuildable {
  let baseType: TypeBuildable
  let period: TokenSyntax
  let typeOrProtocol: TokenSyntax

  public init(
    baseType: ExpressibleByTypeBuildable,
    period: ExpressibleByTokenSyntax = TokenSyntax.`period`,
    typeOrProtocol: ExpressibleByTokenSyntax
  ) {
    self.baseType = baseType.createTypeBuildable()
    self.period = period.createTokenSyntax()
    self.typeOrProtocol = typeOrProtocol.createTokenSyntax()
  }
  
  func buildMetatypeType(format: Format, leadingTrivia: Trivia? = nil) -> MetatypeTypeSyntax {
    let metatypeType = SyntaxFactory.makeMetatypeType(
      baseType: baseType.buildType(format: format),
      period: period,
      typeOrProtocol: typeOrProtocol
    )
    
    if let leadingTrivia = leadingTrivia {
      return metatypeType.withLeadingTrivia(leadingTrivia + (metatypeType.leadingTrivia ?? []))
    }

    return metatypeType
  }

  /// Conformance for `MetatypeType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let metatypeType = buildMetatypeType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(metatypeType)
  }
}

public protocol ExpressibleByMetatypeType {
  func createMetatypeType() -> MetatypeType
}

extension MetatypeType: ExpressibleByMetatypeType {
  public func createMetatypeType() -> MetatypeType {
    self
  }
}

public struct OptionalType: TypeBuildable {
  let wrappedType: TypeBuildable
  let questionMark: TokenSyntax

  public init(
    wrappedType: ExpressibleByTypeBuildable,
    questionMark: ExpressibleByTokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.wrappedType = wrappedType.createTypeBuildable()
    self.questionMark = questionMark.createTokenSyntax()
  }
  
  func buildOptionalType(format: Format, leadingTrivia: Trivia? = nil) -> OptionalTypeSyntax {
    let optionalType = SyntaxFactory.makeOptionalType(
      wrappedType: wrappedType.buildType(format: format),
      questionMark: questionMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return optionalType.withLeadingTrivia(leadingTrivia + (optionalType.leadingTrivia ?? []))
    }

    return optionalType
  }

  /// Conformance for `OptionalType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let optionalType = buildOptionalType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(optionalType)
  }
}

public protocol ExpressibleByOptionalType {
  func createOptionalType() -> OptionalType
}

extension OptionalType: ExpressibleByOptionalType {
  public func createOptionalType() -> OptionalType {
    self
  }
}

public struct SomeType: TypeBuildable {
  let someSpecifier: TokenSyntax
  let baseType: TypeBuildable

  public init(
    someSpecifier: ExpressibleByTokenSyntax,
    baseType: ExpressibleByTypeBuildable
  ) {
    self.someSpecifier = someSpecifier.createTokenSyntax()
    self.baseType = baseType.createTypeBuildable()
  }
  
  func buildSomeType(format: Format, leadingTrivia: Trivia? = nil) -> SomeTypeSyntax {
    let someType = SyntaxFactory.makeSomeType(
      someSpecifier: someSpecifier,
      baseType: baseType.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return someType.withLeadingTrivia(leadingTrivia + (someType.leadingTrivia ?? []))
    }

    return someType
  }

  /// Conformance for `SomeType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let someType = buildSomeType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(someType)
  }
}

public protocol ExpressibleBySomeType {
  func createSomeType() -> SomeType
}

extension SomeType: ExpressibleBySomeType {
  public func createSomeType() -> SomeType {
    self
  }
}

public struct ImplicitlyUnwrappedOptionalType: TypeBuildable {
  let wrappedType: TypeBuildable
  let exclamationMark: TokenSyntax

  public init(
    wrappedType: ExpressibleByTypeBuildable,
    exclamationMark: ExpressibleByTokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.wrappedType = wrappedType.createTypeBuildable()
    self.exclamationMark = exclamationMark.createTokenSyntax()
  }
  
  func buildImplicitlyUnwrappedOptionalType(format: Format, leadingTrivia: Trivia? = nil) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let implicitlyUnwrappedOptionalType = SyntaxFactory.makeImplicitlyUnwrappedOptionalType(
      wrappedType: wrappedType.buildType(format: format),
      exclamationMark: exclamationMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return implicitlyUnwrappedOptionalType.withLeadingTrivia(leadingTrivia + (implicitlyUnwrappedOptionalType.leadingTrivia ?? []))
    }

    return implicitlyUnwrappedOptionalType
  }

  /// Conformance for `ImplicitlyUnwrappedOptionalType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let implicitlyUnwrappedOptionalType = buildImplicitlyUnwrappedOptionalType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(implicitlyUnwrappedOptionalType)
  }
}

public protocol ExpressibleByImplicitlyUnwrappedOptionalType {
  func createImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalType
}

extension ImplicitlyUnwrappedOptionalType: ExpressibleByImplicitlyUnwrappedOptionalType {
  public func createImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalType {
    self
  }
}

public struct CompositionTypeElement: SyntaxBuildable {
  let type: TypeBuildable
  let ampersand: TokenSyntax?

  public init(
    type: ExpressibleByTypeBuildable,
    ampersand: ExpressibleByTokenSyntax? = nil
  ) {
    self.type = type.createTypeBuildable()
    self.ampersand = ampersand?.createTokenSyntax()
  }
  
  func buildCompositionTypeElement(format: Format, leadingTrivia: Trivia? = nil) -> CompositionTypeElementSyntax {
    let compositionTypeElement = SyntaxFactory.makeCompositionTypeElement(
      type: type.buildType(format: format),
      ampersand: ampersand
    )
    
    if let leadingTrivia = leadingTrivia {
      return compositionTypeElement.withLeadingTrivia(leadingTrivia + (compositionTypeElement.leadingTrivia ?? []))
    }

    return compositionTypeElement
  }

  /// Conformance for `CompositionTypeElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let compositionTypeElement = buildCompositionTypeElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(compositionTypeElement)
  }
}

public protocol ExpressibleByCompositionTypeElement {
  func createCompositionTypeElement() -> CompositionTypeElement
}

extension CompositionTypeElement: ExpressibleByCompositionTypeElement {
  public func createCompositionTypeElement() -> CompositionTypeElement {
    self
  }
}

// MARK: - Syntax collection

/// `CompositionTypeElementList` represents a collection of 
/// `CompositionTypeElement`s.
public struct CompositionTypeElementList: SyntaxBuildable {
  let elements: [CompositionTypeElement]

  public init(_ elements: [ExpressibleByCompositionTypeElement]) {
    self.elements = elements.map { $0.createCompositionTypeElement() }
  }

  public func buildCompositionTypeElementList(format: Format) -> CompositionTypeElementListSyntax {
    return SyntaxFactory.makeCompositionTypeElementList(elements.map {
      $0.buildCompositionTypeElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let compositionTypeElementList = buildCompositionTypeElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(compositionTypeElementList).withLeadingTrivia(leadingTrivia + (compositionTypeElementList.leadingTrivia ?? []))
    }

    return Syntax(compositionTypeElementList)
  }
}

public protocol ExpressibleByCompositionTypeElementList {
  func createCompositionTypeElementList() -> CompositionTypeElementList
}

extension CompositionTypeElementList: ExpressibleByCompositionTypeElementList {
  public func createCompositionTypeElementList() -> CompositionTypeElementList {
    self
  }
}

public struct CompositionType: TypeBuildable {
  let elements: CompositionTypeElementList

  public init(
    elements: ExpressibleByCompositionTypeElementList
  ) {
    self.elements = elements.createCompositionTypeElementList()
  }
  
  func buildCompositionType(format: Format, leadingTrivia: Trivia? = nil) -> CompositionTypeSyntax {
    let compositionType = SyntaxFactory.makeCompositionType(
      elements: elements.buildCompositionTypeElementList(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return compositionType.withLeadingTrivia(leadingTrivia + (compositionType.leadingTrivia ?? []))
    }

    return compositionType
  }

  /// Conformance for `CompositionType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let compositionType = buildCompositionType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(compositionType)
  }
}

public protocol ExpressibleByCompositionType {
  func createCompositionType() -> CompositionType
}

extension CompositionType: ExpressibleByCompositionType {
  public func createCompositionType() -> CompositionType {
    self
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
    inOut: ExpressibleByTokenSyntax? = nil,
    name: ExpressibleByTokenSyntax? = nil,
    secondName: ExpressibleByTokenSyntax? = nil,
    colon: ExpressibleByTokenSyntax? = nil,
    type: ExpressibleByTypeBuildable,
    ellipsis: ExpressibleByTokenSyntax? = nil,
    initializer: ExpressibleByInitializerClause? = nil,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.inOut = inOut?.createTokenSyntax()
    self.name = name?.createTokenSyntax()
    self.secondName = secondName?.createTokenSyntax()
    self.colon = colon?.createTokenSyntax()
    self.type = type.createTypeBuildable()
    self.ellipsis = ellipsis?.createTokenSyntax()
    self.initializer = initializer?.createInitializerClause()
    self.trailingComma = trailingComma?.createTokenSyntax()
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
      return tupleTypeElement.withLeadingTrivia(leadingTrivia + (tupleTypeElement.leadingTrivia ?? []))
    }

    return tupleTypeElement
  }

  /// Conformance for `TupleTypeElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tupleTypeElement = buildTupleTypeElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(tupleTypeElement)
  }
}

public protocol ExpressibleByTupleTypeElement {
  func createTupleTypeElement() -> TupleTypeElement
}

extension TupleTypeElement: ExpressibleByTupleTypeElement {
  public func createTupleTypeElement() -> TupleTypeElement {
    self
  }
}

// MARK: - Syntax collection

/// `TupleTypeElementList` represents a collection of 
/// `TupleTypeElement`s.
public struct TupleTypeElementList: SyntaxBuildable {
  let elements: [TupleTypeElement]

  public init(_ elements: [ExpressibleByTupleTypeElement]) {
    self.elements = elements.map { $0.createTupleTypeElement() }
  }

  public func buildTupleTypeElementList(format: Format) -> TupleTypeElementListSyntax {
    return SyntaxFactory.makeTupleTypeElementList(elements.map {
      $0.buildTupleTypeElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tupleTypeElementList = buildTupleTypeElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(tupleTypeElementList).withLeadingTrivia(leadingTrivia + (tupleTypeElementList.leadingTrivia ?? []))
    }

    return Syntax(tupleTypeElementList)
  }
}

public protocol ExpressibleByTupleTypeElementList {
  func createTupleTypeElementList() -> TupleTypeElementList
}

extension TupleTypeElementList: ExpressibleByTupleTypeElementList {
  public func createTupleTypeElementList() -> TupleTypeElementList {
    self
  }
}

public struct TupleType: TypeBuildable {
  let leftParen: TokenSyntax
  let elements: TupleTypeElementList
  let rightParen: TokenSyntax

  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    elements: ExpressibleByTupleTypeElementList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.elements = elements.createTupleTypeElementList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildTupleType(format: Format, leadingTrivia: Trivia? = nil) -> TupleTypeSyntax {
    let tupleType = SyntaxFactory.makeTupleType(
      leftParen: leftParen,
      elements: elements.buildTupleTypeElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return tupleType.withLeadingTrivia(leadingTrivia + (tupleType.leadingTrivia ?? []))
    }

    return tupleType
  }

  /// Conformance for `TupleType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let tupleType = buildTupleType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(tupleType)
  }
}

public protocol ExpressibleByTupleType {
  func createTupleType() -> TupleType
}

extension TupleType: ExpressibleByTupleType {
  public func createTupleType() -> TupleType {
    self
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
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleByTupleTypeElementList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`,
    asyncKeyword: ExpressibleByTokenSyntax? = nil,
    throwsOrRethrowsKeyword: ExpressibleByTokenSyntax? = nil,
    arrow: ExpressibleByTokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleByTypeBuildable
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.arguments = arguments.createTupleTypeElementList()
    self.rightParen = rightParen.createTokenSyntax()
    self.asyncKeyword = asyncKeyword?.createTokenSyntax()
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword?.createTokenSyntax()
    self.arrow = arrow.createTokenSyntax()
    self.returnType = returnType.createTypeBuildable()
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
      return functionType.withLeadingTrivia(leadingTrivia + (functionType.leadingTrivia ?? []))
    }

    return functionType
  }

  /// Conformance for `FunctionType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let functionType = buildFunctionType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(functionType)
  }
}

public protocol ExpressibleByFunctionType {
  func createFunctionType() -> FunctionType
}

extension FunctionType: ExpressibleByFunctionType {
  public func createFunctionType() -> FunctionType {
    self
  }
}

public struct AttributedType: TypeBuildable {
  let specifier: TokenSyntax?
  let attributes: AttributeList?
  let baseType: TypeBuildable

  public init(
    specifier: ExpressibleByTokenSyntax? = nil,
    attributes: ExpressibleByAttributeList? = nil,
    baseType: ExpressibleByTypeBuildable
  ) {
    self.specifier = specifier?.createTokenSyntax()
    self.attributes = attributes?.createAttributeList()
    self.baseType = baseType.createTypeBuildable()
  }
  
  func buildAttributedType(format: Format, leadingTrivia: Trivia? = nil) -> AttributedTypeSyntax {
    let attributedType = SyntaxFactory.makeAttributedType(
      specifier: specifier,
      attributes: attributes?.buildAttributeList(format: format),
      baseType: baseType.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return attributedType.withLeadingTrivia(leadingTrivia + (attributedType.leadingTrivia ?? []))
    }

    return attributedType
  }

  /// Conformance for `AttributedType` to the `TypeBuildable` protocol.
  public func buildType(format: Format, leadingTrivia: Trivia? = nil) -> TypeSyntax {
    let attributedType = buildAttributedType(format: format, leadingTrivia: leadingTrivia)
    return TypeSyntax(attributedType)
  }
}

public protocol ExpressibleByAttributedType {
  func createAttributedType() -> AttributedType
}

extension AttributedType: ExpressibleByAttributedType {
  public func createAttributedType() -> AttributedType {
    self
  }
}

// MARK: - Syntax collection

/// `GenericArgumentList` represents a collection of 
/// `GenericArgument`s.
public struct GenericArgumentList: SyntaxBuildable {
  let elements: [GenericArgument]

  public init(_ elements: [ExpressibleByGenericArgument]) {
    self.elements = elements.map { $0.createGenericArgument() }
  }

  public func buildGenericArgumentList(format: Format) -> GenericArgumentListSyntax {
    return SyntaxFactory.makeGenericArgumentList(elements.map {
      $0.buildGenericArgument(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericArgumentList = buildGenericArgumentList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(genericArgumentList).withLeadingTrivia(leadingTrivia + (genericArgumentList.leadingTrivia ?? []))
    }

    return Syntax(genericArgumentList)
  }
}

public protocol ExpressibleByGenericArgumentList {
  func createGenericArgumentList() -> GenericArgumentList
}

extension GenericArgumentList: ExpressibleByGenericArgumentList {
  public func createGenericArgumentList() -> GenericArgumentList {
    self
  }
}

public struct GenericArgument: SyntaxBuildable {
  let argumentType: TypeBuildable
  let trailingComma: TokenSyntax?

  public init(
    argumentType: ExpressibleByTypeBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.argumentType = argumentType.createTypeBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildGenericArgument(format: Format, leadingTrivia: Trivia? = nil) -> GenericArgumentSyntax {
    let genericArgument = SyntaxFactory.makeGenericArgument(
      argumentType: argumentType.buildType(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericArgument.withLeadingTrivia(leadingTrivia + (genericArgument.leadingTrivia ?? []))
    }

    return genericArgument
  }

  /// Conformance for `GenericArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericArgument = buildGenericArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericArgument)
  }
}

public protocol ExpressibleByGenericArgument {
  func createGenericArgument() -> GenericArgument
}

extension GenericArgument: ExpressibleByGenericArgument {
  public func createGenericArgument() -> GenericArgument {
    self
  }
}

public struct GenericArgumentClause: SyntaxBuildable {
  let leftAngleBracket: TokenSyntax
  let arguments: GenericArgumentList
  let rightAngleBracket: TokenSyntax

  public init(
    leftAngleBracket: ExpressibleByTokenSyntax = TokenSyntax.`leftAngle`,
    arguments: ExpressibleByGenericArgumentList,
    rightAngleBracket: ExpressibleByTokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leftAngleBracket = leftAngleBracket.createTokenSyntax()
    self.arguments = arguments.createGenericArgumentList()
    self.rightAngleBracket = rightAngleBracket.createTokenSyntax()
  }
  
  func buildGenericArgumentClause(format: Format, leadingTrivia: Trivia? = nil) -> GenericArgumentClauseSyntax {
    let genericArgumentClause = SyntaxFactory.makeGenericArgumentClause(
      leftAngleBracket: leftAngleBracket,
      arguments: arguments.buildGenericArgumentList(format: format),
      rightAngleBracket: rightAngleBracket
    )
    
    if let leadingTrivia = leadingTrivia {
      return genericArgumentClause.withLeadingTrivia(leadingTrivia + (genericArgumentClause.leadingTrivia ?? []))
    }

    return genericArgumentClause
  }

  /// Conformance for `GenericArgumentClause` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let genericArgumentClause = buildGenericArgumentClause(format: format, leadingTrivia: leadingTrivia)
    return Syntax(genericArgumentClause)
  }
}

public protocol ExpressibleByGenericArgumentClause {
  func createGenericArgumentClause() -> GenericArgumentClause
}

extension GenericArgumentClause: ExpressibleByGenericArgumentClause {
  public func createGenericArgumentClause() -> GenericArgumentClause {
    self
  }
}

public struct TypeAnnotation: SyntaxBuildable {
  let colon: TokenSyntax
  let type: TypeBuildable

  public init(
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    type: ExpressibleByTypeBuildable
  ) {
    self.colon = colon.createTokenSyntax()
    self.type = type.createTypeBuildable()
  }
  
  func buildTypeAnnotation(format: Format, leadingTrivia: Trivia? = nil) -> TypeAnnotationSyntax {
    let typeAnnotation = SyntaxFactory.makeTypeAnnotation(
      colon: colon,
      type: type.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return typeAnnotation.withLeadingTrivia(leadingTrivia + (typeAnnotation.leadingTrivia ?? []))
    }

    return typeAnnotation
  }

  /// Conformance for `TypeAnnotation` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let typeAnnotation = buildTypeAnnotation(format: format, leadingTrivia: leadingTrivia)
    return Syntax(typeAnnotation)
  }
}

public protocol ExpressibleByTypeAnnotation {
  func createTypeAnnotation() -> TypeAnnotation
}

extension TypeAnnotation: ExpressibleByTypeAnnotation {
  public func createTypeAnnotation() -> TypeAnnotation {
    self
  }
}

public struct EnumCasePattern: PatternBuildable {
  let type: TypeBuildable?
  let period: TokenSyntax
  let caseName: TokenSyntax
  let associatedTuple: TuplePattern?

  public init(
    type: ExpressibleByTypeBuildable? = nil,
    period: ExpressibleByTokenSyntax = TokenSyntax.`period`,
    caseName: ExpressibleByTokenSyntax,
    associatedTuple: ExpressibleByTuplePattern? = nil
  ) {
    self.type = type?.createTypeBuildable()
    self.period = period.createTokenSyntax()
    self.caseName = caseName.createTokenSyntax()
    self.associatedTuple = associatedTuple?.createTuplePattern()
  }
  
  func buildEnumCasePattern(format: Format, leadingTrivia: Trivia? = nil) -> EnumCasePatternSyntax {
    let enumCasePattern = SyntaxFactory.makeEnumCasePattern(
      type: type?.buildType(format: format),
      period: period,
      caseName: caseName,
      associatedTuple: associatedTuple?.buildTuplePattern(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return enumCasePattern.withLeadingTrivia(leadingTrivia + (enumCasePattern.leadingTrivia ?? []))
    }

    return enumCasePattern
  }

  /// Conformance for `EnumCasePattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let enumCasePattern = buildEnumCasePattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(enumCasePattern)
  }
}

public protocol ExpressibleByEnumCasePattern {
  func createEnumCasePattern() -> EnumCasePattern
}

extension EnumCasePattern: ExpressibleByEnumCasePattern {
  public func createEnumCasePattern() -> EnumCasePattern {
    self
  }
}

public struct IsTypePattern: PatternBuildable {
  let isKeyword: TokenSyntax
  let type: TypeBuildable

  public init(
    isKeyword: ExpressibleByTokenSyntax = TokenSyntax.`is`,
    type: ExpressibleByTypeBuildable
  ) {
    self.isKeyword = isKeyword.createTokenSyntax()
    self.type = type.createTypeBuildable()
  }
  
  func buildIsTypePattern(format: Format, leadingTrivia: Trivia? = nil) -> IsTypePatternSyntax {
    let isTypePattern = SyntaxFactory.makeIsTypePattern(
      isKeyword: isKeyword,
      type: type.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return isTypePattern.withLeadingTrivia(leadingTrivia + (isTypePattern.leadingTrivia ?? []))
    }

    return isTypePattern
  }

  /// Conformance for `IsTypePattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let isTypePattern = buildIsTypePattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(isTypePattern)
  }
}

public protocol ExpressibleByIsTypePattern {
  func createIsTypePattern() -> IsTypePattern
}

extension IsTypePattern: ExpressibleByIsTypePattern {
  public func createIsTypePattern() -> IsTypePattern {
    self
  }
}

public struct OptionalPattern: PatternBuildable {
  let subPattern: PatternBuildable
  let questionMark: TokenSyntax

  public init(
    subPattern: ExpressibleByPatternBuildable,
    questionMark: ExpressibleByTokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.subPattern = subPattern.createPatternBuildable()
    self.questionMark = questionMark.createTokenSyntax()
  }
  
  func buildOptionalPattern(format: Format, leadingTrivia: Trivia? = nil) -> OptionalPatternSyntax {
    let optionalPattern = SyntaxFactory.makeOptionalPattern(
      subPattern: subPattern.buildPattern(format: format),
      questionMark: questionMark
    )
    
    if let leadingTrivia = leadingTrivia {
      return optionalPattern.withLeadingTrivia(leadingTrivia + (optionalPattern.leadingTrivia ?? []))
    }

    return optionalPattern
  }

  /// Conformance for `OptionalPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let optionalPattern = buildOptionalPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(optionalPattern)
  }
}

public protocol ExpressibleByOptionalPattern {
  func createOptionalPattern() -> OptionalPattern
}

extension OptionalPattern: ExpressibleByOptionalPattern {
  public func createOptionalPattern() -> OptionalPattern {
    self
  }
}

public struct IdentifierPattern: PatternBuildable {
  let identifier: TokenSyntax

  public init(
    identifier: ExpressibleByTokenSyntax
  ) {
    self.identifier = identifier.createTokenSyntax()
  }
  
  func buildIdentifierPattern(format: Format, leadingTrivia: Trivia? = nil) -> IdentifierPatternSyntax {
    let identifierPattern = SyntaxFactory.makeIdentifierPattern(
      identifier: identifier
    )
    
    if let leadingTrivia = leadingTrivia {
      return identifierPattern.withLeadingTrivia(leadingTrivia + (identifierPattern.leadingTrivia ?? []))
    }

    return identifierPattern
  }

  /// Conformance for `IdentifierPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let identifierPattern = buildIdentifierPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(identifierPattern)
  }
}

public protocol ExpressibleByIdentifierPattern {
  func createIdentifierPattern() -> IdentifierPattern
}

extension IdentifierPattern: ExpressibleByIdentifierPattern {
  public func createIdentifierPattern() -> IdentifierPattern {
    self
  }
}

public struct AsTypePattern: PatternBuildable {
  let pattern: PatternBuildable
  let asKeyword: TokenSyntax
  let type: TypeBuildable

  public init(
    pattern: ExpressibleByPatternBuildable,
    asKeyword: ExpressibleByTokenSyntax = TokenSyntax.`as`,
    type: ExpressibleByTypeBuildable
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.asKeyword = asKeyword.createTokenSyntax()
    self.type = type.createTypeBuildable()
  }
  
  func buildAsTypePattern(format: Format, leadingTrivia: Trivia? = nil) -> AsTypePatternSyntax {
    let asTypePattern = SyntaxFactory.makeAsTypePattern(
      pattern: pattern.buildPattern(format: format),
      asKeyword: asKeyword,
      type: type.buildType(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return asTypePattern.withLeadingTrivia(leadingTrivia + (asTypePattern.leadingTrivia ?? []))
    }

    return asTypePattern
  }

  /// Conformance for `AsTypePattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let asTypePattern = buildAsTypePattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(asTypePattern)
  }
}

public protocol ExpressibleByAsTypePattern {
  func createAsTypePattern() -> AsTypePattern
}

extension AsTypePattern: ExpressibleByAsTypePattern {
  public func createAsTypePattern() -> AsTypePattern {
    self
  }
}

public struct TuplePattern: PatternBuildable {
  let leftParen: TokenSyntax
  let elements: TuplePatternElementList
  let rightParen: TokenSyntax

  public init(
    leftParen: ExpressibleByTokenSyntax = TokenSyntax.`leftParen`,
    elements: ExpressibleByTuplePatternElementList,
    rightParen: ExpressibleByTokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen.createTokenSyntax()
    self.elements = elements.createTuplePatternElementList()
    self.rightParen = rightParen.createTokenSyntax()
  }
  
  func buildTuplePattern(format: Format, leadingTrivia: Trivia? = nil) -> TuplePatternSyntax {
    let tuplePattern = SyntaxFactory.makeTuplePattern(
      leftParen: leftParen,
      elements: elements.buildTuplePatternElementList(format: format),
      rightParen: rightParen
    )
    
    if let leadingTrivia = leadingTrivia {
      return tuplePattern.withLeadingTrivia(leadingTrivia + (tuplePattern.leadingTrivia ?? []))
    }

    return tuplePattern
  }

  /// Conformance for `TuplePattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let tuplePattern = buildTuplePattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(tuplePattern)
  }
}

public protocol ExpressibleByTuplePattern {
  func createTuplePattern() -> TuplePattern
}

extension TuplePattern: ExpressibleByTuplePattern {
  public func createTuplePattern() -> TuplePattern {
    self
  }
}

public struct WildcardPattern: PatternBuildable {
  let wildcard: TokenSyntax
  let typeAnnotation: TypeAnnotation?

  public init(
    wildcard: ExpressibleByTokenSyntax = TokenSyntax.`wildcard`,
    typeAnnotation: ExpressibleByTypeAnnotation? = nil
  ) {
    self.wildcard = wildcard.createTokenSyntax()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
  }
  
  func buildWildcardPattern(format: Format, leadingTrivia: Trivia? = nil) -> WildcardPatternSyntax {
    let wildcardPattern = SyntaxFactory.makeWildcardPattern(
      wildcard: wildcard,
      typeAnnotation: typeAnnotation?.buildTypeAnnotation(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return wildcardPattern.withLeadingTrivia(leadingTrivia + (wildcardPattern.leadingTrivia ?? []))
    }

    return wildcardPattern
  }

  /// Conformance for `WildcardPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let wildcardPattern = buildWildcardPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(wildcardPattern)
  }
}

public protocol ExpressibleByWildcardPattern {
  func createWildcardPattern() -> WildcardPattern
}

extension WildcardPattern: ExpressibleByWildcardPattern {
  public func createWildcardPattern() -> WildcardPattern {
    self
  }
}

public struct TuplePatternElement: SyntaxBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let pattern: PatternBuildable
  let trailingComma: TokenSyntax?

  public init(
    labelName: ExpressibleByTokenSyntax? = nil,
    labelColon: ExpressibleByTokenSyntax? = nil,
    pattern: ExpressibleByPatternBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.labelName = labelName?.createTokenSyntax()
    self.labelColon = labelColon?.createTokenSyntax()
    self.pattern = pattern.createPatternBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildTuplePatternElement(format: Format, leadingTrivia: Trivia? = nil) -> TuplePatternElementSyntax {
    let tuplePatternElement = SyntaxFactory.makeTuplePatternElement(
      labelName: labelName,
      labelColon: labelColon,
      pattern: pattern.buildPattern(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return tuplePatternElement.withLeadingTrivia(leadingTrivia + (tuplePatternElement.leadingTrivia ?? []))
    }

    return tuplePatternElement
  }

  /// Conformance for `TuplePatternElement` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tuplePatternElement = buildTuplePatternElement(format: format, leadingTrivia: leadingTrivia)
    return Syntax(tuplePatternElement)
  }
}

public protocol ExpressibleByTuplePatternElement {
  func createTuplePatternElement() -> TuplePatternElement
}

extension TuplePatternElement: ExpressibleByTuplePatternElement {
  public func createTuplePatternElement() -> TuplePatternElement {
    self
  }
}

public struct ExpressionPattern: PatternBuildable {
  let expression: ExprBuildable

  public init(
    expression: ExpressibleByExprBuildable
  ) {
    self.expression = expression.createExprBuildable()
  }
  
  func buildExpressionPattern(format: Format, leadingTrivia: Trivia? = nil) -> ExpressionPatternSyntax {
    let expressionPattern = SyntaxFactory.makeExpressionPattern(
      expression: expression.buildExpr(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return expressionPattern.withLeadingTrivia(leadingTrivia + (expressionPattern.leadingTrivia ?? []))
    }

    return expressionPattern
  }

  /// Conformance for `ExpressionPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let expressionPattern = buildExpressionPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(expressionPattern)
  }
}

public protocol ExpressibleByExpressionPattern {
  func createExpressionPattern() -> ExpressionPattern
}

extension ExpressionPattern: ExpressibleByExpressionPattern {
  public func createExpressionPattern() -> ExpressionPattern {
    self
  }
}

// MARK: - Syntax collection

/// `TuplePatternElementList` represents a collection of 
/// `TuplePatternElement`s.
public struct TuplePatternElementList: SyntaxBuildable {
  let elements: [TuplePatternElement]

  public init(_ elements: [ExpressibleByTuplePatternElement]) {
    self.elements = elements.map { $0.createTuplePatternElement() }
  }

  public func buildTuplePatternElementList(format: Format) -> TuplePatternElementListSyntax {
    return SyntaxFactory.makeTuplePatternElementList(elements.map {
      $0.buildTuplePatternElement(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let tuplePatternElementList = buildTuplePatternElementList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(tuplePatternElementList).withLeadingTrivia(leadingTrivia + (tuplePatternElementList.leadingTrivia ?? []))
    }

    return Syntax(tuplePatternElementList)
  }
}

public protocol ExpressibleByTuplePatternElementList {
  func createTuplePatternElementList() -> TuplePatternElementList
}

extension TuplePatternElementList: ExpressibleByTuplePatternElementList {
  public func createTuplePatternElementList() -> TuplePatternElementList {
    self
  }
}

public struct ValueBindingPattern: PatternBuildable {
  let letOrVarKeyword: TokenSyntax
  let valuePattern: PatternBuildable

  public init(
    letOrVarKeyword: ExpressibleByTokenSyntax,
    valuePattern: ExpressibleByPatternBuildable
  ) {
    self.letOrVarKeyword = letOrVarKeyword.createTokenSyntax()
    self.valuePattern = valuePattern.createPatternBuildable()
  }
  
  func buildValueBindingPattern(format: Format, leadingTrivia: Trivia? = nil) -> ValueBindingPatternSyntax {
    let valueBindingPattern = SyntaxFactory.makeValueBindingPattern(
      letOrVarKeyword: letOrVarKeyword,
      valuePattern: valuePattern.buildPattern(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return valueBindingPattern.withLeadingTrivia(leadingTrivia + (valueBindingPattern.leadingTrivia ?? []))
    }

    return valueBindingPattern
  }

  /// Conformance for `ValueBindingPattern` to the `PatternBuildable` protocol.
  public func buildPattern(format: Format, leadingTrivia: Trivia? = nil) -> PatternSyntax {
    let valueBindingPattern = buildValueBindingPattern(format: format, leadingTrivia: leadingTrivia)
    return PatternSyntax(valueBindingPattern)
  }
}

public protocol ExpressibleByValueBindingPattern {
  func createValueBindingPattern() -> ValueBindingPattern
}

extension ValueBindingPattern: ExpressibleByValueBindingPattern {
  public func createValueBindingPattern() -> ValueBindingPattern {
    self
  }
}

// MARK: - Syntax collection

/// `AvailabilitySpecList` represents a collection of 
/// `AvailabilityArgument`s.
public struct AvailabilitySpecList: SyntaxBuildable {
  let elements: [AvailabilityArgument]

  public init(_ elements: [ExpressibleByAvailabilityArgument]) {
    self.elements = elements.map { $0.createAvailabilityArgument() }
  }

  public func buildAvailabilitySpecList(format: Format) -> AvailabilitySpecListSyntax {
    return SyntaxFactory.makeAvailabilitySpecList(elements.map {
      $0.buildAvailabilityArgument(format: format, leadingTrivia: nil)
    })
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilitySpecList = buildAvailabilitySpecList(format: format)

    if let leadingTrivia = leadingTrivia {
      return Syntax(availabilitySpecList).withLeadingTrivia(leadingTrivia + (availabilitySpecList.leadingTrivia ?? []))
    }

    return Syntax(availabilitySpecList)
  }
}

public protocol ExpressibleByAvailabilitySpecList {
  func createAvailabilitySpecList() -> AvailabilitySpecList
}

extension AvailabilitySpecList: ExpressibleByAvailabilitySpecList {
  public func createAvailabilitySpecList() -> AvailabilitySpecList {
    self
  }
}

/// 
/// A single argument to an `@available` argument like `*`, `iOS 10.1`,
/// or `message: "This has been deprecated"`.
/// 
public struct AvailabilityArgument: SyntaxBuildable {
  let entry: SyntaxBuildable
  let trailingComma: TokenSyntax?

  public init(
    entry: ExpressibleBySyntaxBuildable,
    trailingComma: ExpressibleByTokenSyntax? = nil
  ) {
    self.entry = entry.createSyntaxBuildable()
    self.trailingComma = trailingComma?.createTokenSyntax()
  }
  
  func buildAvailabilityArgument(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityArgumentSyntax {
    let availabilityArgument = SyntaxFactory.makeAvailabilityArgument(
      entry: entry.buildSyntax(format: format),
      trailingComma: trailingComma
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityArgument.withLeadingTrivia(leadingTrivia + (availabilityArgument.leadingTrivia ?? []))
    }

    return availabilityArgument
  }

  /// Conformance for `AvailabilityArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityArgument = buildAvailabilityArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityArgument)
  }
}

public protocol ExpressibleByAvailabilityArgument {
  func createAvailabilityArgument() -> AvailabilityArgument
}

extension AvailabilityArgument: ExpressibleByAvailabilityArgument {
  public func createAvailabilityArgument() -> AvailabilityArgument {
    self
  }
}

/// 
/// A argument to an `@available` attribute that consists of a label and
/// a value, e.g. `message: "This has been deprecated"`.
/// 
public struct AvailabilityLabeledArgument: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let value: SyntaxBuildable

  public init(
    label: ExpressibleByTokenSyntax,
    colon: ExpressibleByTokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleBySyntaxBuildable
  ) {
    self.label = label.createTokenSyntax()
    self.colon = colon.createTokenSyntax()
    self.value = value.createSyntaxBuildable()
  }
  
  func buildAvailabilityLabeledArgument(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityLabeledArgumentSyntax {
    let availabilityLabeledArgument = SyntaxFactory.makeAvailabilityLabeledArgument(
      label: label,
      colon: colon,
      value: value.buildSyntax(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityLabeledArgument.withLeadingTrivia(leadingTrivia + (availabilityLabeledArgument.leadingTrivia ?? []))
    }

    return availabilityLabeledArgument
  }

  /// Conformance for `AvailabilityLabeledArgument` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityLabeledArgument = buildAvailabilityLabeledArgument(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityLabeledArgument)
  }
}

public protocol ExpressibleByAvailabilityLabeledArgument {
  func createAvailabilityLabeledArgument() -> AvailabilityLabeledArgument
}

extension AvailabilityLabeledArgument: ExpressibleByAvailabilityLabeledArgument {
  public func createAvailabilityLabeledArgument() -> AvailabilityLabeledArgument {
    self
  }
}

/// 
/// An argument to `@available` that restricts the availability on a
/// certain platform to a version, e.g. `iOS 10` or `swift 3.4`.
/// 
public struct AvailabilityVersionRestriction: SyntaxBuildable {
  let platform: TokenSyntax
  let version: VersionTuple?

  public init(
    platform: ExpressibleByTokenSyntax,
    version: ExpressibleByVersionTuple? = nil
  ) {
    self.platform = platform.createTokenSyntax()
    self.version = version?.createVersionTuple()
  }
  
  func buildAvailabilityVersionRestriction(format: Format, leadingTrivia: Trivia? = nil) -> AvailabilityVersionRestrictionSyntax {
    let availabilityVersionRestriction = SyntaxFactory.makeAvailabilityVersionRestriction(
      platform: platform,
      version: version?.buildVersionTuple(format: format)
    )
    
    if let leadingTrivia = leadingTrivia {
      return availabilityVersionRestriction.withLeadingTrivia(leadingTrivia + (availabilityVersionRestriction.leadingTrivia ?? []))
    }

    return availabilityVersionRestriction
  }

  /// Conformance for `AvailabilityVersionRestriction` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let availabilityVersionRestriction = buildAvailabilityVersionRestriction(format: format, leadingTrivia: leadingTrivia)
    return Syntax(availabilityVersionRestriction)
  }
}

public protocol ExpressibleByAvailabilityVersionRestriction {
  func createAvailabilityVersionRestriction() -> AvailabilityVersionRestriction
}

extension AvailabilityVersionRestriction: ExpressibleByAvailabilityVersionRestriction {
  public func createAvailabilityVersionRestriction() -> AvailabilityVersionRestriction {
    self
  }
}

/// 
/// A version number of the form major.minor.patch in which the minor
/// and patch part may be ommited.
/// 
public struct VersionTuple: SyntaxBuildable {
  let majorMinor: SyntaxBuildable
  let patchPeriod: TokenSyntax?
  let patchVersion: TokenSyntax?

  public init(
    majorMinor: ExpressibleBySyntaxBuildable,
    patchPeriod: ExpressibleByTokenSyntax? = nil,
    patchVersion: ExpressibleByTokenSyntax? = nil
  ) {
    self.majorMinor = majorMinor.createSyntaxBuildable()
    self.patchPeriod = patchPeriod?.createTokenSyntax()
    self.patchVersion = patchVersion?.createTokenSyntax()
  }
  
  func buildVersionTuple(format: Format, leadingTrivia: Trivia? = nil) -> VersionTupleSyntax {
    let versionTuple = SyntaxFactory.makeVersionTuple(
      majorMinor: majorMinor.buildSyntax(format: format),
      patchPeriod: patchPeriod,
      patchVersion: patchVersion
    )
    
    if let leadingTrivia = leadingTrivia {
      return versionTuple.withLeadingTrivia(leadingTrivia + (versionTuple.leadingTrivia ?? []))
    }

    return versionTuple
  }

  /// Conformance for `VersionTuple` to the `SyntaxBuildable` protocol.
  public func buildSyntax(format: Format, leadingTrivia: Trivia? = nil) -> Syntax {
    let versionTuple = buildVersionTuple(format: format, leadingTrivia: leadingTrivia)
    return Syntax(versionTuple)
  }
}

public protocol ExpressibleByVersionTuple {
  func createVersionTuple() -> VersionTuple
}

extension VersionTuple: ExpressibleByVersionTuple {
  public func createVersionTuple() -> VersionTuple {
    self
  }
}

public protocol ExpressibleByTokenSyntax {
  func createTokenSyntax() -> TokenSyntax
}

extension TokenSyntax: ExpressibleByTokenSyntax {
  public func createTokenSyntax() -> TokenSyntax {
    self
  }
}

// MARK: - Syntax buildable expressible by conformances

extension ExpressibleByDeclBuildable {
  public func createCodeBlockItem() -> CodeBlockItem {
    CodeBlockItem(item: self)
  }
}

extension ExpressibleByDeclBuildable {
  public func createMemberDeclListItem() -> MemberDeclListItem {
    MemberDeclListItem(decl: self)
  }
}

extension ExpressibleByConditionElement {
  public func createConditionElementList() -> ConditionElementList {
    ConditionElementList([self])
  }
}

extension ExpressibleByStmtBuildable {
  public func createCodeBlockItem() -> CodeBlockItem {
    CodeBlockItem(item: self)
  }
}

extension ExpressibleByExprList {
  public func createConditionElement() -> ConditionElement {
    ConditionElement(condition: self)
  }
}

