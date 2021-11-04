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

public protocol ExpressibleAsDeclBuildable: ExpressibleAsCodeBlockItem, ExpressibleAsMemberDeclListItem, ExpressibleAsSyntaxBuildable {
  func createDeclBuildable() -> DeclBuildable
}

public protocol DeclBuildable: ExpressibleAsDeclBuildable, SyntaxBuildable, DeclListBuildable {
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

public protocol ExpressibleAsExprBuildable: ExpressibleAsExprList, ExpressibleAsCodeBlockItem {
  func createExprBuildable() -> ExprBuildable
}

public protocol ExprBuildable: ExpressibleAsExprBuildable, SyntaxBuildable, ExprListBuildable {
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

public protocol ExpressibleAsPatternBuildable {
  func createPatternBuildable() -> PatternBuildable
}

public protocol PatternBuildable: ExpressibleAsPatternBuildable, SyntaxBuildable, PatternListBuildable {
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

public protocol ExpressibleAsStmtBuildable: ExpressibleAsCodeBlockItem, ExpressibleAsSyntaxBuildable {
  func createStmtBuildable() -> StmtBuildable
}

public protocol StmtBuildable: ExpressibleAsStmtBuildable, SyntaxBuildable, StmtListBuildable {
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

public protocol ExpressibleAsSyntaxBuildable {
  func createSyntaxBuildable() -> SyntaxBuildable
}

public protocol SyntaxBuildable: ExpressibleAsSyntaxBuildable, SyntaxListBuildable {
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

public protocol ExpressibleAsTypeBuildable {
  func createTypeBuildable() -> TypeBuildable
}

public protocol TypeBuildable: ExpressibleAsTypeBuildable, SyntaxBuildable, TypeListBuildable {
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

  /// Creates a `CodeBlockItem` using the provided parameters.
  /// - Parameters:
  ///   - item: The underlying node inside the code block.
  ///   - semicolon: If present, the trailing semicolon at the end of the item.
  ///   - errorTokens: 
  public init(
    item: ExpressibleAsSyntaxBuildable,
    semicolon: TokenSyntax? = nil,
    errorTokens: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.item = item.createSyntaxBuildable()
    self.semicolon = semicolon
    assert(semicolon == nil || [";"].contains(self.semicolon!.text))
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

public protocol ExpressibleAsCodeBlockItem: ExpressibleAsSyntaxBuildable, ExpressibleAsCodeBlockItemList {
  func createCodeBlockItem() -> CodeBlockItem
}

extension CodeBlockItem: ExpressibleAsCodeBlockItem {
  public func createCodeBlockItem() -> CodeBlockItem {
    self
  }
}

// MARK: - Syntax collection

/// `CodeBlockItemList` represents a collection of 
/// `CodeBlockItem`s.
public struct CodeBlockItemList: SyntaxBuildable {
  let elements: [CodeBlockItem]

  /// Creates a `CodeBlockItemList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCodeBlockItem`
  public init(_ elements: [ExpressibleAsCodeBlockItem]) {
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

extension CodeBlockItemList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsCodeBlockItem...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsCodeBlockItemList: ExpressibleAsSyntaxBuildable, ExpressibleAsCodeBlock {
  func createCodeBlockItemList() -> CodeBlockItemList
}

extension CodeBlockItemList: ExpressibleAsCodeBlockItemList {
  public func createCodeBlockItemList() -> CodeBlockItemList {
    self
  }
}

public struct CodeBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let statements: CodeBlockItemList
  let rightBrace: TokenSyntax

  /// Creates a `CodeBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - statements: 
  ///   - rightBrace: 
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    statements: ExpressibleAsCodeBlockItemList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace
    assert(["{"].contains(self.leftBrace.text))
    self.statements = statements.createCodeBlockItemList()
    self.rightBrace = rightBrace
    assert(["}"].contains(self.rightBrace.text))
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

public protocol ExpressibleAsCodeBlock: ExpressibleAsSyntaxBuildable {
  func createCodeBlock() -> CodeBlock
}

extension CodeBlock: ExpressibleAsCodeBlock {
  public func createCodeBlock() -> CodeBlock {
    self
  }
}

public struct InOutExpr: ExprBuildable {
  let ampersand: TokenSyntax
  let expression: ExprBuildable

  /// Creates a `InOutExpr` using the provided parameters.
  /// - Parameters:
  ///   - ampersand: 
  ///   - expression: 
  public init(
    ampersand: TokenSyntax = TokenSyntax.`prefixAmpersand`,
    expression: ExpressibleAsExprBuildable
  ) {
    self.ampersand = ampersand
    assert(["&"].contains(self.ampersand.text))
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

public protocol ExpressibleAsInOutExpr: ExpressibleAsExprBuildable {
  func createInOutExpr() -> InOutExpr
}

extension InOutExpr: ExpressibleAsInOutExpr {
  public func createInOutExpr() -> InOutExpr {
    self
  }
}

public struct PoundColumnExpr: ExprBuildable {
  let poundColumn: TokenSyntax

  /// Creates a `PoundColumnExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundColumn: 
  public init(
    poundColumn: TokenSyntax = TokenSyntax.`poundColumn`
  ) {
    self.poundColumn = poundColumn
    assert(["#column"].contains(self.poundColumn.text))
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

public protocol ExpressibleAsPoundColumnExpr: ExpressibleAsExprBuildable {
  func createPoundColumnExpr() -> PoundColumnExpr
}

extension PoundColumnExpr: ExpressibleAsPoundColumnExpr {
  public func createPoundColumnExpr() -> PoundColumnExpr {
    self
  }
}

// MARK: - Syntax collection

/// `TupleExprElementList` represents a collection of 
/// `TupleExprElement`s.
public struct TupleExprElementList: SyntaxBuildable {
  let elements: [TupleExprElement]

  /// Creates a `TupleExprElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTupleExprElement`
  public init(_ elements: [ExpressibleAsTupleExprElement]) {
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

extension TupleExprElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsTupleExprElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsTupleExprElementList: ExpressibleAsSyntaxBuildable {
  func createTupleExprElementList() -> TupleExprElementList
}

extension TupleExprElementList: ExpressibleAsTupleExprElementList {
  public func createTupleExprElementList() -> TupleExprElementList {
    self
  }
}

// MARK: - Syntax collection

/// `ArrayElementList` represents a collection of 
/// `ArrayElement`s.
public struct ArrayElementList: SyntaxBuildable {
  let elements: [ArrayElement]

  /// Creates a `ArrayElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsArrayElement`
  public init(_ elements: [ExpressibleAsArrayElement]) {
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

extension ArrayElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsArrayElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsArrayElementList: ExpressibleAsSyntaxBuildable {
  func createArrayElementList() -> ArrayElementList
}

extension ArrayElementList: ExpressibleAsArrayElementList {
  public func createArrayElementList() -> ArrayElementList {
    self
  }
}

// MARK: - Syntax collection

/// `DictionaryElementList` represents a collection of 
/// `DictionaryElement`s.
public struct DictionaryElementList: SyntaxBuildable {
  let elements: [DictionaryElement]

  /// Creates a `DictionaryElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsDictionaryElement`
  public init(_ elements: [ExpressibleAsDictionaryElement]) {
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

extension DictionaryElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsDictionaryElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsDictionaryElementList: ExpressibleAsSyntaxBuildable {
  func createDictionaryElementList() -> DictionaryElementList
}

extension DictionaryElementList: ExpressibleAsDictionaryElementList {
  public func createDictionaryElementList() -> DictionaryElementList {
    self
  }
}

// MARK: - Syntax collection

/// `StringLiteralSegments` represents a collection of 
/// `SyntaxBuildable`s.
public struct StringLiteralSegments: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  /// Creates a `StringLiteralSegments` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
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

extension StringLiteralSegments: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsStringLiteralSegments: ExpressibleAsSyntaxBuildable {
  func createStringLiteralSegments() -> StringLiteralSegments
}

extension StringLiteralSegments: ExpressibleAsStringLiteralSegments {
  public func createStringLiteralSegments() -> StringLiteralSegments {
    self
  }
}

public struct TryExpr: ExprBuildable {
  let tryKeyword: TokenSyntax
  let questionOrExclamationMark: TokenSyntax?
  let expression: ExprBuildable

  /// Creates a `TryExpr` using the provided parameters.
  /// - Parameters:
  ///   - tryKeyword: 
  ///   - questionOrExclamationMark: 
  ///   - expression: 
  public init(
    tryKeyword: TokenSyntax = TokenSyntax.`try`,
    questionOrExclamationMark: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.tryKeyword = tryKeyword
    assert(["try"].contains(self.tryKeyword.text))
    self.questionOrExclamationMark = questionOrExclamationMark
    assert(questionOrExclamationMark == nil || ["?", "!"].contains(self.questionOrExclamationMark!.text))
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

public protocol ExpressibleAsTryExpr: ExpressibleAsExprBuildable {
  func createTryExpr() -> TryExpr
}

extension TryExpr: ExpressibleAsTryExpr {
  public func createTryExpr() -> TryExpr {
    self
  }
}

public struct AwaitExpr: ExprBuildable {
  let awaitKeyword: TokenSyntax
  let expression: ExprBuildable

  /// Creates a `AwaitExpr` using the provided parameters.
  /// - Parameters:
  ///   - awaitKeyword: 
  ///   - expression: 
  public init(
    awaitKeyword: TokenSyntax,
    expression: ExpressibleAsExprBuildable
  ) {
    self.awaitKeyword = awaitKeyword
    assert(["await"].contains(self.awaitKeyword.text))
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

public protocol ExpressibleAsAwaitExpr: ExpressibleAsExprBuildable {
  func createAwaitExpr() -> AwaitExpr
}

extension AwaitExpr: ExpressibleAsAwaitExpr {
  public func createAwaitExpr() -> AwaitExpr {
    self
  }
}

public struct DeclNameArgument: SyntaxBuildable {
  let name: TokenSyntax
  let colon: TokenSyntax

  /// Creates a `DeclNameArgument` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - colon: 
  public init(
    name: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.name = name
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsDeclNameArgument: ExpressibleAsSyntaxBuildable, ExpressibleAsDeclNameArgumentList {
  func createDeclNameArgument() -> DeclNameArgument
}

extension DeclNameArgument: ExpressibleAsDeclNameArgument {
  public func createDeclNameArgument() -> DeclNameArgument {
    self
  }
}

// MARK: - Syntax collection

/// `DeclNameArgumentList` represents a collection of 
/// `DeclNameArgument`s.
public struct DeclNameArgumentList: SyntaxBuildable {
  let elements: [DeclNameArgument]

  /// Creates a `DeclNameArgumentList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsDeclNameArgument`
  public init(_ elements: [ExpressibleAsDeclNameArgument]) {
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

extension DeclNameArgumentList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsDeclNameArgument...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsDeclNameArgumentList: ExpressibleAsSyntaxBuildable {
  func createDeclNameArgumentList() -> DeclNameArgumentList
}

extension DeclNameArgumentList: ExpressibleAsDeclNameArgumentList {
  public func createDeclNameArgumentList() -> DeclNameArgumentList {
    self
  }
}

public struct DeclNameArguments: SyntaxBuildable {
  let leftParen: TokenSyntax
  let arguments: DeclNameArgumentList
  let rightParen: TokenSyntax

  /// Creates a `DeclNameArguments` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - arguments: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsDeclNameArgumentList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.arguments = arguments.createDeclNameArgumentList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsDeclNameArguments: ExpressibleAsSyntaxBuildable {
  func createDeclNameArguments() -> DeclNameArguments
}

extension DeclNameArguments: ExpressibleAsDeclNameArguments {
  public func createDeclNameArguments() -> DeclNameArguments {
    self
  }
}

public struct IdentifierExpr: ExprBuildable {
  let identifier: TokenSyntax
  let declNameArguments: DeclNameArguments?

  /// Creates a `IdentifierExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - declNameArguments: 
  public init(
    identifier: TokenSyntax,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.identifier = identifier
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

public protocol ExpressibleAsIdentifierExpr: ExpressibleAsExprBuildable {
  func createIdentifierExpr() -> IdentifierExpr
}

extension IdentifierExpr: ExpressibleAsIdentifierExpr {
  public func createIdentifierExpr() -> IdentifierExpr {
    self
  }
}

public struct SuperRefExpr: ExprBuildable {
  let superKeyword: TokenSyntax

  /// Creates a `SuperRefExpr` using the provided parameters.
  /// - Parameters:
  ///   - superKeyword: 
  public init(
    superKeyword: TokenSyntax = TokenSyntax.`super`
  ) {
    self.superKeyword = superKeyword
    assert(["super"].contains(self.superKeyword.text))
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

public protocol ExpressibleAsSuperRefExpr: ExpressibleAsExprBuildable {
  func createSuperRefExpr() -> SuperRefExpr
}

extension SuperRefExpr: ExpressibleAsSuperRefExpr {
  public func createSuperRefExpr() -> SuperRefExpr {
    self
  }
}

public struct NilLiteralExpr: ExprBuildable {
  let nilKeyword: TokenSyntax

  /// Creates a `NilLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - nilKeyword: 
  public init(
    nilKeyword: TokenSyntax = TokenSyntax.`nil`
  ) {
    self.nilKeyword = nilKeyword
    assert(["nil"].contains(self.nilKeyword.text))
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

public protocol ExpressibleAsNilLiteralExpr: ExpressibleAsExprBuildable {
  func createNilLiteralExpr() -> NilLiteralExpr
}

extension NilLiteralExpr: ExpressibleAsNilLiteralExpr {
  public func createNilLiteralExpr() -> NilLiteralExpr {
    self
  }
}

public struct DiscardAssignmentExpr: ExprBuildable {
  let wildcard: TokenSyntax

  /// Creates a `DiscardAssignmentExpr` using the provided parameters.
  /// - Parameters:
  ///   - wildcard: 
  public init(
    wildcard: TokenSyntax = TokenSyntax.`wildcard`
  ) {
    self.wildcard = wildcard
    assert(["_"].contains(self.wildcard.text))
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

public protocol ExpressibleAsDiscardAssignmentExpr: ExpressibleAsExprBuildable {
  func createDiscardAssignmentExpr() -> DiscardAssignmentExpr
}

extension DiscardAssignmentExpr: ExpressibleAsDiscardAssignmentExpr {
  public func createDiscardAssignmentExpr() -> DiscardAssignmentExpr {
    self
  }
}

public struct AssignmentExpr: ExprBuildable {
  let assignToken: TokenSyntax

  /// Creates a `AssignmentExpr` using the provided parameters.
  /// - Parameters:
  ///   - assignToken: 
  public init(
    assignToken: TokenSyntax = TokenSyntax.`equal`
  ) {
    self.assignToken = assignToken
    assert(["="].contains(self.assignToken.text))
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

public protocol ExpressibleAsAssignmentExpr: ExpressibleAsExprBuildable {
  func createAssignmentExpr() -> AssignmentExpr
}

extension AssignmentExpr: ExpressibleAsAssignmentExpr {
  public func createAssignmentExpr() -> AssignmentExpr {
    self
  }
}

public struct SequenceExpr: ExprBuildable {
  let elements: ExprList

  /// Creates a `SequenceExpr` using the provided parameters.
  /// - Parameters:
  ///   - elements: 
  public init(
    elements: ExpressibleAsExprList
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

public protocol ExpressibleAsSequenceExpr: ExpressibleAsExprBuildable, ExpressibleAsTupleExprElement {
  func createSequenceExpr() -> SequenceExpr
}

extension SequenceExpr: ExpressibleAsSequenceExpr {
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

  /// Creates a `ExprList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsExprBuildable`
  public init(_ elements: [ExpressibleAsExprBuildable]) {
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

extension ExprList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsExprBuildable...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsExprList: ExpressibleAsSyntaxBuildable, ExpressibleAsConditionElement {
  func createExprList() -> ExprList
}

extension ExprList: ExpressibleAsExprList {
  public func createExprList() -> ExprList {
    self
  }
}

public struct PoundLineExpr: ExprBuildable {
  let poundLine: TokenSyntax

  /// Creates a `PoundLineExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundLine: 
  public init(
    poundLine: TokenSyntax = TokenSyntax.`poundLine`
  ) {
    self.poundLine = poundLine
    assert(["#line"].contains(self.poundLine.text))
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

public protocol ExpressibleAsPoundLineExpr: ExpressibleAsExprBuildable {
  func createPoundLineExpr() -> PoundLineExpr
}

extension PoundLineExpr: ExpressibleAsPoundLineExpr {
  public func createPoundLineExpr() -> PoundLineExpr {
    self
  }
}

public struct PoundFileExpr: ExprBuildable {
  let poundFile: TokenSyntax

  /// Creates a `PoundFileExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFile: 
  public init(
    poundFile: TokenSyntax = TokenSyntax.`poundFile`
  ) {
    self.poundFile = poundFile
    assert(["#file"].contains(self.poundFile.text))
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

public protocol ExpressibleAsPoundFileExpr: ExpressibleAsExprBuildable {
  func createPoundFileExpr() -> PoundFileExpr
}

extension PoundFileExpr: ExpressibleAsPoundFileExpr {
  public func createPoundFileExpr() -> PoundFileExpr {
    self
  }
}

public struct PoundFileIDExpr: ExprBuildable {
  let poundFileID: TokenSyntax

  /// Creates a `PoundFileIDExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFileID: 
  public init(
    poundFileID: TokenSyntax = TokenSyntax.`poundFileID`
  ) {
    self.poundFileID = poundFileID
    assert(["#fileID"].contains(self.poundFileID.text))
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

public protocol ExpressibleAsPoundFileIDExpr: ExpressibleAsExprBuildable {
  func createPoundFileIDExpr() -> PoundFileIDExpr
}

extension PoundFileIDExpr: ExpressibleAsPoundFileIDExpr {
  public func createPoundFileIDExpr() -> PoundFileIDExpr {
    self
  }
}

public struct PoundFilePathExpr: ExprBuildable {
  let poundFilePath: TokenSyntax

  /// Creates a `PoundFilePathExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFilePath: 
  public init(
    poundFilePath: TokenSyntax = TokenSyntax.`poundFilePath`
  ) {
    self.poundFilePath = poundFilePath
    assert(["#filePath"].contains(self.poundFilePath.text))
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

public protocol ExpressibleAsPoundFilePathExpr: ExpressibleAsExprBuildable {
  func createPoundFilePathExpr() -> PoundFilePathExpr
}

extension PoundFilePathExpr: ExpressibleAsPoundFilePathExpr {
  public func createPoundFilePathExpr() -> PoundFilePathExpr {
    self
  }
}

public struct PoundFunctionExpr: ExprBuildable {
  let poundFunction: TokenSyntax

  /// Creates a `PoundFunctionExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundFunction: 
  public init(
    poundFunction: TokenSyntax = TokenSyntax.`poundFunction`
  ) {
    self.poundFunction = poundFunction
    assert(["#function"].contains(self.poundFunction.text))
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

public protocol ExpressibleAsPoundFunctionExpr: ExpressibleAsExprBuildable {
  func createPoundFunctionExpr() -> PoundFunctionExpr
}

extension PoundFunctionExpr: ExpressibleAsPoundFunctionExpr {
  public func createPoundFunctionExpr() -> PoundFunctionExpr {
    self
  }
}

public struct PoundDsohandleExpr: ExprBuildable {
  let poundDsohandle: TokenSyntax

  /// Creates a `PoundDsohandleExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundDsohandle: 
  public init(
    poundDsohandle: TokenSyntax = TokenSyntax.`poundDsohandle`
  ) {
    self.poundDsohandle = poundDsohandle
    assert(["#dsohandle"].contains(self.poundDsohandle.text))
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

public protocol ExpressibleAsPoundDsohandleExpr: ExpressibleAsExprBuildable {
  func createPoundDsohandleExpr() -> PoundDsohandleExpr
}

extension PoundDsohandleExpr: ExpressibleAsPoundDsohandleExpr {
  public func createPoundDsohandleExpr() -> PoundDsohandleExpr {
    self
  }
}

public struct SymbolicReferenceExpr: ExprBuildable {
  let identifier: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  /// Creates a `SymbolicReferenceExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - genericArgumentClause: 
  public init(
    identifier: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.identifier = identifier
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

public protocol ExpressibleAsSymbolicReferenceExpr: ExpressibleAsExprBuildable {
  func createSymbolicReferenceExpr() -> SymbolicReferenceExpr
}

extension SymbolicReferenceExpr: ExpressibleAsSymbolicReferenceExpr {
  public func createSymbolicReferenceExpr() -> SymbolicReferenceExpr {
    self
  }
}

public struct PrefixOperatorExpr: ExprBuildable {
  let operatorToken: TokenSyntax?
  let postfixExpression: ExprBuildable

  /// Creates a `PrefixOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - operatorToken: 
  ///   - postfixExpression: 
  public init(
    operatorToken: TokenSyntax? = nil,
    postfixExpression: ExpressibleAsExprBuildable
  ) {
    self.operatorToken = operatorToken
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

public protocol ExpressibleAsPrefixOperatorExpr: ExpressibleAsExprBuildable {
  func createPrefixOperatorExpr() -> PrefixOperatorExpr
}

extension PrefixOperatorExpr: ExpressibleAsPrefixOperatorExpr {
  public func createPrefixOperatorExpr() -> PrefixOperatorExpr {
    self
  }
}

public struct BinaryOperatorExpr: ExprBuildable {
  let operatorToken: TokenSyntax

  /// Creates a `BinaryOperatorExpr` using the provided parameters.
  /// - Parameters:
  ///   - operatorToken: 
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

public protocol ExpressibleAsBinaryOperatorExpr: ExpressibleAsExprBuildable {
  func createBinaryOperatorExpr() -> BinaryOperatorExpr
}

extension BinaryOperatorExpr: ExpressibleAsBinaryOperatorExpr {
  public func createBinaryOperatorExpr() -> BinaryOperatorExpr {
    self
  }
}

public struct ArrowExpr: ExprBuildable {
  let asyncKeyword: TokenSyntax?
  let throwsToken: TokenSyntax?
  let arrowToken: TokenSyntax

  /// Creates a `ArrowExpr` using the provided parameters.
  /// - Parameters:
  ///   - asyncKeyword: 
  ///   - throwsToken: 
  ///   - arrowToken: 
  public init(
    asyncKeyword: TokenSyntax? = nil,
    throwsToken: TokenSyntax? = nil,
    arrowToken: TokenSyntax = TokenSyntax.`arrow`
  ) {
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || ["async"].contains(self.asyncKeyword!.text))
    self.throwsToken = throwsToken
    assert(throwsToken == nil || ["throws"].contains(self.throwsToken!.text))
    self.arrowToken = arrowToken
    assert(["->"].contains(self.arrowToken.text))
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

public protocol ExpressibleAsArrowExpr: ExpressibleAsExprBuildable {
  func createArrowExpr() -> ArrowExpr
}

extension ArrowExpr: ExpressibleAsArrowExpr {
  public func createArrowExpr() -> ArrowExpr {
    self
  }
}

public struct FloatLiteralExpr: ExprBuildable {
  let floatingDigits: TokenSyntax

  /// Creates a `FloatLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - floatingDigits: 
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

public protocol ExpressibleAsFloatLiteralExpr: ExpressibleAsExprBuildable {
  func createFloatLiteralExpr() -> FloatLiteralExpr
}

extension FloatLiteralExpr: ExpressibleAsFloatLiteralExpr {
  public func createFloatLiteralExpr() -> FloatLiteralExpr {
    self
  }
}

public struct TupleExpr: ExprBuildable {
  let leftParen: TokenSyntax
  let elementList: TupleExprElementList
  let rightParen: TokenSyntax

  /// Creates a `TupleExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elementList: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elementList: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.elementList = elementList.createTupleExprElementList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsTupleExpr: ExpressibleAsExprBuildable {
  func createTupleExpr() -> TupleExpr
}

extension TupleExpr: ExpressibleAsTupleExpr {
  public func createTupleExpr() -> TupleExpr {
    self
  }
}

public struct ArrayExpr: ExprBuildable {
  let leftSquare: TokenSyntax
  let elements: ArrayElementList
  let rightSquare: TokenSyntax

  /// Creates a `ArrayExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - elements: 
  ///   - rightSquare: 
  public init(
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    elements: ExpressibleAsArrayElementList,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquare = leftSquare
    assert(["["].contains(self.leftSquare.text))
    self.elements = elements.createArrayElementList()
    self.rightSquare = rightSquare
    assert(["]"].contains(self.rightSquare.text))
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

public protocol ExpressibleAsArrayExpr: ExpressibleAsExprBuildable {
  func createArrayExpr() -> ArrayExpr
}

extension ArrayExpr: ExpressibleAsArrayExpr {
  public func createArrayExpr() -> ArrayExpr {
    self
  }
}

public struct DictionaryExpr: ExprBuildable {
  let leftSquare: TokenSyntax
  let content: SyntaxBuildable
  let rightSquare: TokenSyntax

  /// Creates a `DictionaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - content: 
  ///   - rightSquare: 
  public init(
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    content: ExpressibleAsSyntaxBuildable,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquare = leftSquare
    assert(["["].contains(self.leftSquare.text))
    self.content = content.createSyntaxBuildable()
    self.rightSquare = rightSquare
    assert(["]"].contains(self.rightSquare.text))
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

public protocol ExpressibleAsDictionaryExpr: ExpressibleAsExprBuildable {
  func createDictionaryExpr() -> DictionaryExpr
}

extension DictionaryExpr: ExpressibleAsDictionaryExpr {
  public func createDictionaryExpr() -> DictionaryExpr {
    self
  }
}

public struct TupleExprElement: SyntaxBuildable {
  let label: TokenSyntax?
  let colon: TokenSyntax?
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `TupleExprElement` using the provided parameters.
  /// - Parameters:
  ///   - label: 
  ///   - colon: 
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    label: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.label = label
    self.colon = colon
    assert(colon == nil || [":"].contains(self.colon!.text))
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsTupleExprElement: ExpressibleAsSyntaxBuildable, ExpressibleAsTupleExprElementList {
  func createTupleExprElement() -> TupleExprElement
}

extension TupleExprElement: ExpressibleAsTupleExprElement {
  public func createTupleExprElement() -> TupleExprElement {
    self
  }
}

public struct ArrayElement: SyntaxBuildable {
  let expression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `ArrayElement` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsArrayElement: ExpressibleAsSyntaxBuildable, ExpressibleAsArrayElementList {
  func createArrayElement() -> ArrayElement
}

extension ArrayElement: ExpressibleAsArrayElement {
  public func createArrayElement() -> ArrayElement {
    self
  }
}

public struct DictionaryElement: SyntaxBuildable {
  let keyExpression: ExprBuildable
  let colon: TokenSyntax
  let valueExpression: ExprBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `DictionaryElement` using the provided parameters.
  /// - Parameters:
  ///   - keyExpression: 
  ///   - colon: 
  ///   - valueExpression: 
  ///   - trailingComma: 
  public init(
    keyExpression: ExpressibleAsExprBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    valueExpression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.keyExpression = keyExpression.createExprBuildable()
    self.colon = colon
    assert([":"].contains(self.colon.text))
    self.valueExpression = valueExpression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsDictionaryElement: ExpressibleAsSyntaxBuildable, ExpressibleAsDictionaryElementList {
  func createDictionaryElement() -> DictionaryElement
}

extension DictionaryElement: ExpressibleAsDictionaryElement {
  public func createDictionaryElement() -> DictionaryElement {
    self
  }
}

public struct IntegerLiteralExpr: ExprBuildable {
  let digits: TokenSyntax

  /// Creates a `IntegerLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - digits: 
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

public protocol ExpressibleAsIntegerLiteralExpr: ExpressibleAsExprBuildable {
  func createIntegerLiteralExpr() -> IntegerLiteralExpr
}

extension IntegerLiteralExpr: ExpressibleAsIntegerLiteralExpr {
  public func createIntegerLiteralExpr() -> IntegerLiteralExpr {
    self
  }
}

public struct BooleanLiteralExpr: ExprBuildable {
  let booleanLiteral: TokenSyntax

  /// Creates a `BooleanLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - booleanLiteral: 
  public init(
    booleanLiteral: TokenSyntax
  ) {
    self.booleanLiteral = booleanLiteral
    assert(["true", "false"].contains(self.booleanLiteral.text))
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

public protocol ExpressibleAsBooleanLiteralExpr: ExpressibleAsExprBuildable {
  func createBooleanLiteralExpr() -> BooleanLiteralExpr
}

extension BooleanLiteralExpr: ExpressibleAsBooleanLiteralExpr {
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

  /// Creates a `TernaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - conditionExpression: 
  ///   - questionMark: 
  ///   - firstChoice: 
  ///   - colonMark: 
  ///   - secondChoice: 
  public init(
    conditionExpression: ExpressibleAsExprBuildable,
    questionMark: TokenSyntax = TokenSyntax.`infixQuestionMark`,
    firstChoice: ExpressibleAsExprBuildable,
    colonMark: TokenSyntax = TokenSyntax.`colon`,
    secondChoice: ExpressibleAsExprBuildable
  ) {
    self.conditionExpression = conditionExpression.createExprBuildable()
    self.questionMark = questionMark
    assert(["?"].contains(self.questionMark.text))
    self.firstChoice = firstChoice.createExprBuildable()
    self.colonMark = colonMark
    assert([":"].contains(self.colonMark.text))
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

public protocol ExpressibleAsTernaryExpr: ExpressibleAsExprBuildable {
  func createTernaryExpr() -> TernaryExpr
}

extension TernaryExpr: ExpressibleAsTernaryExpr {
  public func createTernaryExpr() -> TernaryExpr {
    self
  }
}

public struct MemberAccessExpr: ExprBuildable {
  let base: ExprBuildable?
  let dot: TokenSyntax
  let name: TokenSyntax
  let declNameArguments: DeclNameArguments?

  /// Creates a `MemberAccessExpr` using the provided parameters.
  /// - Parameters:
  ///   - base: 
  ///   - dot: 
  ///   - name: 
  ///   - declNameArguments: 
  public init(
    base: ExpressibleAsExprBuildable? = nil,
    dot: TokenSyntax,
    name: TokenSyntax,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.base = base?.createExprBuildable()
    self.dot = dot
    assert([".", "."].contains(self.dot.text))
    self.name = name
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

public protocol ExpressibleAsMemberAccessExpr: ExpressibleAsExprBuildable {
  func createMemberAccessExpr() -> MemberAccessExpr
}

extension MemberAccessExpr: ExpressibleAsMemberAccessExpr {
  public func createMemberAccessExpr() -> MemberAccessExpr {
    self
  }
}

public struct IsExpr: ExprBuildable {
  let isTok: TokenSyntax
  let typeName: TypeBuildable

  /// Creates a `IsExpr` using the provided parameters.
  /// - Parameters:
  ///   - isTok: 
  ///   - typeName: 
  public init(
    isTok: TokenSyntax = TokenSyntax.`is`,
    typeName: ExpressibleAsTypeBuildable
  ) {
    self.isTok = isTok
    assert(["is"].contains(self.isTok.text))
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

public protocol ExpressibleAsIsExpr: ExpressibleAsExprBuildable {
  func createIsExpr() -> IsExpr
}

extension IsExpr: ExpressibleAsIsExpr {
  public func createIsExpr() -> IsExpr {
    self
  }
}

public struct AsExpr: ExprBuildable {
  let asTok: TokenSyntax
  let questionOrExclamationMark: TokenSyntax?
  let typeName: TypeBuildable

  /// Creates a `AsExpr` using the provided parameters.
  /// - Parameters:
  ///   - asTok: 
  ///   - questionOrExclamationMark: 
  ///   - typeName: 
  public init(
    asTok: TokenSyntax = TokenSyntax.`as`,
    questionOrExclamationMark: TokenSyntax? = nil,
    typeName: ExpressibleAsTypeBuildable
  ) {
    self.asTok = asTok
    assert(["as"].contains(self.asTok.text))
    self.questionOrExclamationMark = questionOrExclamationMark
    assert(questionOrExclamationMark == nil || ["?", "!"].contains(self.questionOrExclamationMark!.text))
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

public protocol ExpressibleAsAsExpr: ExpressibleAsExprBuildable {
  func createAsExpr() -> AsExpr
}

extension AsExpr: ExpressibleAsAsExpr {
  public func createAsExpr() -> AsExpr {
    self
  }
}

public struct TypeExpr: ExprBuildable {
  let type: TypeBuildable

  /// Creates a `TypeExpr` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  public init(
    type: ExpressibleAsTypeBuildable
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

public protocol ExpressibleAsTypeExpr: ExpressibleAsExprBuildable {
  func createTypeExpr() -> TypeExpr
}

extension TypeExpr: ExpressibleAsTypeExpr {
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

  /// Creates a `ClosureCaptureItem` using the provided parameters.
  /// - Parameters:
  ///   - specifier: 
  ///   - name: 
  ///   - assignToken: 
  ///   - expression: 
  ///   - trailingComma: 
  public init(
    specifier: ExpressibleAsTokenList? = nil,
    name: TokenSyntax? = nil,
    assignToken: TokenSyntax? = nil,
    expression: ExpressibleAsExprBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.specifier = specifier?.createTokenList()
    self.name = name
    self.assignToken = assignToken
    assert(assignToken == nil || ["="].contains(self.assignToken!.text))
    self.expression = expression.createExprBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsClosureCaptureItem: ExpressibleAsSyntaxBuildable, ExpressibleAsClosureCaptureItemList {
  func createClosureCaptureItem() -> ClosureCaptureItem
}

extension ClosureCaptureItem: ExpressibleAsClosureCaptureItem {
  public func createClosureCaptureItem() -> ClosureCaptureItem {
    self
  }
}

// MARK: - Syntax collection

/// `ClosureCaptureItemList` represents a collection of 
/// `ClosureCaptureItem`s.
public struct ClosureCaptureItemList: SyntaxBuildable {
  let elements: [ClosureCaptureItem]

  /// Creates a `ClosureCaptureItemList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsClosureCaptureItem`
  public init(_ elements: [ExpressibleAsClosureCaptureItem]) {
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

extension ClosureCaptureItemList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsClosureCaptureItem...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsClosureCaptureItemList: ExpressibleAsSyntaxBuildable {
  func createClosureCaptureItemList() -> ClosureCaptureItemList
}

extension ClosureCaptureItemList: ExpressibleAsClosureCaptureItemList {
  public func createClosureCaptureItemList() -> ClosureCaptureItemList {
    self
  }
}

public struct ClosureCaptureSignature: SyntaxBuildable {
  let leftSquare: TokenSyntax
  let items: ClosureCaptureItemList?
  let rightSquare: TokenSyntax

  /// Creates a `ClosureCaptureSignature` using the provided parameters.
  /// - Parameters:
  ///   - leftSquare: 
  ///   - items: 
  ///   - rightSquare: 
  public init(
    leftSquare: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    items: ExpressibleAsClosureCaptureItemList? = nil,
    rightSquare: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquare = leftSquare
    assert(["["].contains(self.leftSquare.text))
    self.items = items?.createClosureCaptureItemList()
    self.rightSquare = rightSquare
    assert(["]"].contains(self.rightSquare.text))
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

public protocol ExpressibleAsClosureCaptureSignature: ExpressibleAsSyntaxBuildable {
  func createClosureCaptureSignature() -> ClosureCaptureSignature
}

extension ClosureCaptureSignature: ExpressibleAsClosureCaptureSignature {
  public func createClosureCaptureSignature() -> ClosureCaptureSignature {
    self
  }
}

public struct ClosureParam: SyntaxBuildable {
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  /// Creates a `ClosureParam` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingComma: 
  public init(
    name: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.name = name
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsClosureParam: ExpressibleAsSyntaxBuildable, ExpressibleAsClosureParamList {
  func createClosureParam() -> ClosureParam
}

extension ClosureParam: ExpressibleAsClosureParam {
  public func createClosureParam() -> ClosureParam {
    self
  }
}

// MARK: - Syntax collection

/// `ClosureParamList` represents a collection of 
/// `ClosureParam`s.
public struct ClosureParamList: SyntaxBuildable {
  let elements: [ClosureParam]

  /// Creates a `ClosureParamList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsClosureParam`
  public init(_ elements: [ExpressibleAsClosureParam]) {
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

extension ClosureParamList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsClosureParam...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsClosureParamList: ExpressibleAsSyntaxBuildable {
  func createClosureParamList() -> ClosureParamList
}

extension ClosureParamList: ExpressibleAsClosureParamList {
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

  /// Creates a `ClosureSignature` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - capture: 
  ///   - input: 
  ///   - asyncKeyword: 
  ///   - throwsTok: 
  ///   - output: 
  ///   - inTok: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    capture: ExpressibleAsClosureCaptureSignature? = nil,
    input: ExpressibleAsSyntaxBuildable? = nil,
    asyncKeyword: TokenSyntax? = nil,
    throwsTok: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil,
    inTok: TokenSyntax = TokenSyntax.`in`
  ) {
    self.attributes = attributes?.createAttributeList()
    self.capture = capture?.createClosureCaptureSignature()
    self.input = input?.createSyntaxBuildable()
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || ["async"].contains(self.asyncKeyword!.text))
    self.throwsTok = throwsTok
    assert(throwsTok == nil || ["throws"].contains(self.throwsTok!.text))
    self.output = output?.createReturnClause()
    self.inTok = inTok
    assert(["in"].contains(self.inTok.text))
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

public protocol ExpressibleAsClosureSignature: ExpressibleAsSyntaxBuildable {
  func createClosureSignature() -> ClosureSignature
}

extension ClosureSignature: ExpressibleAsClosureSignature {
  public func createClosureSignature() -> ClosureSignature {
    self
  }
}

public struct ClosureExpr: ExprBuildable {
  let leftBrace: TokenSyntax
  let signature: ClosureSignature?
  let statements: CodeBlockItemList
  let rightBrace: TokenSyntax

  /// Creates a `ClosureExpr` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - signature: 
  ///   - statements: 
  ///   - rightBrace: 
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    signature: ExpressibleAsClosureSignature? = nil,
    statements: ExpressibleAsCodeBlockItemList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace
    assert(["{"].contains(self.leftBrace.text))
    self.signature = signature?.createClosureSignature()
    self.statements = statements.createCodeBlockItemList()
    self.rightBrace = rightBrace
    assert(["}"].contains(self.rightBrace.text))
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

public protocol ExpressibleAsClosureExpr: ExpressibleAsExprBuildable {
  func createClosureExpr() -> ClosureExpr
}

extension ClosureExpr: ExpressibleAsClosureExpr {
  public func createClosureExpr() -> ClosureExpr {
    self
  }
}

public struct UnresolvedPatternExpr: ExprBuildable {
  let pattern: PatternBuildable

  /// Creates a `UnresolvedPatternExpr` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  public init(
    pattern: ExpressibleAsPatternBuildable
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

public protocol ExpressibleAsUnresolvedPatternExpr: ExpressibleAsExprBuildable {
  func createUnresolvedPatternExpr() -> UnresolvedPatternExpr
}

extension UnresolvedPatternExpr: ExpressibleAsUnresolvedPatternExpr {
  public func createUnresolvedPatternExpr() -> UnresolvedPatternExpr {
    self
  }
}

public struct MultipleTrailingClosureElement: SyntaxBuildable {
  let label: TokenSyntax
  let colon: TokenSyntax
  let closure: ClosureExpr

  /// Creates a `MultipleTrailingClosureElement` using the provided parameters.
  /// - Parameters:
  ///   - label: 
  ///   - colon: 
  ///   - closure: 
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    closure: ExpressibleAsClosureExpr
  ) {
    self.label = label
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsMultipleTrailingClosureElement: ExpressibleAsSyntaxBuildable, ExpressibleAsMultipleTrailingClosureElementList {
  func createMultipleTrailingClosureElement() -> MultipleTrailingClosureElement
}

extension MultipleTrailingClosureElement: ExpressibleAsMultipleTrailingClosureElement {
  public func createMultipleTrailingClosureElement() -> MultipleTrailingClosureElement {
    self
  }
}

// MARK: - Syntax collection

/// `MultipleTrailingClosureElementList` represents a collection of 
/// `MultipleTrailingClosureElement`s.
public struct MultipleTrailingClosureElementList: SyntaxBuildable {
  let elements: [MultipleTrailingClosureElement]

  /// Creates a `MultipleTrailingClosureElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsMultipleTrailingClosureElement`
  public init(_ elements: [ExpressibleAsMultipleTrailingClosureElement]) {
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

extension MultipleTrailingClosureElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsMultipleTrailingClosureElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsMultipleTrailingClosureElementList: ExpressibleAsSyntaxBuildable {
  func createMultipleTrailingClosureElementList() -> MultipleTrailingClosureElementList
}

extension MultipleTrailingClosureElementList: ExpressibleAsMultipleTrailingClosureElementList {
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

  /// Creates a `FunctionCallExpr` using the provided parameters.
  /// - Parameters:
  ///   - calledExpression: 
  ///   - leftParen: 
  ///   - argumentList: 
  ///   - rightParen: 
  ///   - trailingClosure: 
  ///   - additionalTrailingClosures: 
  public init(
    calledExpression: ExpressibleAsExprBuildable,
    leftParen: TokenSyntax? = nil,
    argumentList: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax? = nil,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil
  ) {
    self.calledExpression = calledExpression.createExprBuildable()
    self.leftParen = leftParen
    assert(leftParen == nil || ["("].contains(self.leftParen!.text))
    self.argumentList = argumentList.createTupleExprElementList()
    self.rightParen = rightParen
    assert(rightParen == nil || [")"].contains(self.rightParen!.text))
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

public protocol ExpressibleAsFunctionCallExpr: ExpressibleAsExprBuildable {
  func createFunctionCallExpr() -> FunctionCallExpr
}

extension FunctionCallExpr: ExpressibleAsFunctionCallExpr {
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

  /// Creates a `SubscriptExpr` using the provided parameters.
  /// - Parameters:
  ///   - calledExpression: 
  ///   - leftBracket: 
  ///   - argumentList: 
  ///   - rightBracket: 
  ///   - trailingClosure: 
  ///   - additionalTrailingClosures: 
  public init(
    calledExpression: ExpressibleAsExprBuildable,
    leftBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    argumentList: ExpressibleAsTupleExprElementList,
    rightBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: ExpressibleAsMultipleTrailingClosureElementList? = nil
  ) {
    self.calledExpression = calledExpression.createExprBuildable()
    self.leftBracket = leftBracket
    assert(["["].contains(self.leftBracket.text))
    self.argumentList = argumentList.createTupleExprElementList()
    self.rightBracket = rightBracket
    assert(["]"].contains(self.rightBracket.text))
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

public protocol ExpressibleAsSubscriptExpr: ExpressibleAsExprBuildable {
  func createSubscriptExpr() -> SubscriptExpr
}

extension SubscriptExpr: ExpressibleAsSubscriptExpr {
  public func createSubscriptExpr() -> SubscriptExpr {
    self
  }
}

public struct OptionalChainingExpr: ExprBuildable {
  let expression: ExprBuildable
  let questionMark: TokenSyntax

  /// Creates a `OptionalChainingExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - questionMark: 
  public init(
    expression: ExpressibleAsExprBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.expression = expression.createExprBuildable()
    self.questionMark = questionMark
    assert(["?"].contains(self.questionMark.text))
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

public protocol ExpressibleAsOptionalChainingExpr: ExpressibleAsExprBuildable {
  func createOptionalChainingExpr() -> OptionalChainingExpr
}

extension OptionalChainingExpr: ExpressibleAsOptionalChainingExpr {
  public func createOptionalChainingExpr() -> OptionalChainingExpr {
    self
  }
}

public struct ForcedValueExpr: ExprBuildable {
  let expression: ExprBuildable
  let exclamationMark: TokenSyntax

  /// Creates a `ForcedValueExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - exclamationMark: 
  public init(
    expression: ExpressibleAsExprBuildable,
    exclamationMark: TokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.expression = expression.createExprBuildable()
    self.exclamationMark = exclamationMark
    assert(["!"].contains(self.exclamationMark.text))
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

public protocol ExpressibleAsForcedValueExpr: ExpressibleAsExprBuildable {
  func createForcedValueExpr() -> ForcedValueExpr
}

extension ForcedValueExpr: ExpressibleAsForcedValueExpr {
  public func createForcedValueExpr() -> ForcedValueExpr {
    self
  }
}

public struct PostfixUnaryExpr: ExprBuildable {
  let expression: ExprBuildable
  let operatorToken: TokenSyntax

  /// Creates a `PostfixUnaryExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - operatorToken: 
  public init(
    expression: ExpressibleAsExprBuildable,
    operatorToken: TokenSyntax
  ) {
    self.expression = expression.createExprBuildable()
    self.operatorToken = operatorToken
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

public protocol ExpressibleAsPostfixUnaryExpr: ExpressibleAsExprBuildable {
  func createPostfixUnaryExpr() -> PostfixUnaryExpr
}

extension PostfixUnaryExpr: ExpressibleAsPostfixUnaryExpr {
  public func createPostfixUnaryExpr() -> PostfixUnaryExpr {
    self
  }
}

public struct SpecializeExpr: ExprBuildable {
  let expression: ExprBuildable
  let genericArgumentClause: GenericArgumentClause

  /// Creates a `SpecializeExpr` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  ///   - genericArgumentClause: 
  public init(
    expression: ExpressibleAsExprBuildable,
    genericArgumentClause: ExpressibleAsGenericArgumentClause
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

public protocol ExpressibleAsSpecializeExpr: ExpressibleAsExprBuildable {
  func createSpecializeExpr() -> SpecializeExpr
}

extension SpecializeExpr: ExpressibleAsSpecializeExpr {
  public func createSpecializeExpr() -> SpecializeExpr {
    self
  }
}

public struct StringSegment: SyntaxBuildable {
  let content: TokenSyntax

  /// Creates a `StringSegment` using the provided parameters.
  /// - Parameters:
  ///   - content: 
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

public protocol ExpressibleAsStringSegment: ExpressibleAsSyntaxBuildable {
  func createStringSegment() -> StringSegment
}

extension StringSegment: ExpressibleAsStringSegment {
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

  /// Creates a `ExpressionSegment` using the provided parameters.
  /// - Parameters:
  ///   - backslash: 
  ///   - delimiter: 
  ///   - leftParen: 
  ///   - expressions: 
  ///   - rightParen: 
  public init(
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    delimiter: TokenSyntax? = nil,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    expressions: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`stringInterpolationAnchor`
  ) {
    self.backslash = backslash
    assert(["\\"].contains(self.backslash.text))
    self.delimiter = delimiter
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.expressions = expressions.createTupleExprElementList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsExpressionSegment: ExpressibleAsSyntaxBuildable {
  func createExpressionSegment() -> ExpressionSegment
}

extension ExpressionSegment: ExpressibleAsExpressionSegment {
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

  /// Creates a `StringLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - openDelimiter: 
  ///   - openQuote: 
  ///   - segments: 
  ///   - closeQuote: 
  ///   - closeDelimiter: 
  public init(
    openDelimiter: TokenSyntax? = nil,
    openQuote: TokenSyntax,
    segments: ExpressibleAsStringLiteralSegments,
    closeQuote: TokenSyntax,
    closeDelimiter: TokenSyntax? = nil
  ) {
    self.openDelimiter = openDelimiter
    self.openQuote = openQuote
    assert(["\"", "\"\"\""].contains(self.openQuote.text))
    self.segments = segments.createStringLiteralSegments()
    self.closeQuote = closeQuote
    assert(["\"", "\"\"\""].contains(self.closeQuote.text))
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

public protocol ExpressibleAsStringLiteralExpr: ExpressibleAsExprBuildable {
  func createStringLiteralExpr() -> StringLiteralExpr
}

extension StringLiteralExpr: ExpressibleAsStringLiteralExpr {
  public func createStringLiteralExpr() -> StringLiteralExpr {
    self
  }
}

public struct RegexLiteralExpr: ExprBuildable {
  let regex: TokenSyntax

  /// Creates a `RegexLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - regex: 
  public init(
    regex: TokenSyntax
  ) {
    self.regex = regex
  }
  
  func buildRegexLiteralExpr(format: Format, leadingTrivia: Trivia? = nil) -> RegexLiteralExprSyntax {
    let regexLiteralExpr = SyntaxFactory.makeRegexLiteralExpr(
      regex: regex
    )
    
    if let leadingTrivia = leadingTrivia {
      return regexLiteralExpr.withLeadingTrivia(leadingTrivia + (regexLiteralExpr.leadingTrivia ?? []))
    }

    return regexLiteralExpr
  }

  /// Conformance for `RegexLiteralExpr` to the `ExprBuildable` protocol.
  public func buildExpr(format: Format, leadingTrivia: Trivia? = nil) -> ExprSyntax {
    let regexLiteralExpr = buildRegexLiteralExpr(format: format, leadingTrivia: leadingTrivia)
    return ExprSyntax(regexLiteralExpr)
  }
}

public protocol ExpressibleAsRegexLiteralExpr: ExpressibleAsExprBuildable {
  func createRegexLiteralExpr() -> RegexLiteralExpr
}

extension RegexLiteralExpr: ExpressibleAsRegexLiteralExpr {
  public func createRegexLiteralExpr() -> RegexLiteralExpr {
    self
  }
}

public struct KeyPathExpr: ExprBuildable {
  let backslash: TokenSyntax
  let rootExpr: ExprBuildable?
  let expression: ExprBuildable

  /// Creates a `KeyPathExpr` using the provided parameters.
  /// - Parameters:
  ///   - backslash: 
  ///   - rootExpr: 
  ///   - expression: 
  public init(
    backslash: TokenSyntax = TokenSyntax.`backslash`,
    rootExpr: ExpressibleAsExprBuildable? = nil,
    expression: ExpressibleAsExprBuildable
  ) {
    self.backslash = backslash
    assert(["\\"].contains(self.backslash.text))
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

public protocol ExpressibleAsKeyPathExpr: ExpressibleAsExprBuildable {
  func createKeyPathExpr() -> KeyPathExpr
}

extension KeyPathExpr: ExpressibleAsKeyPathExpr {
  public func createKeyPathExpr() -> KeyPathExpr {
    self
  }
}

public struct KeyPathBaseExpr: ExprBuildable {
  let period: TokenSyntax

  /// Creates a `KeyPathBaseExpr` using the provided parameters.
  /// - Parameters:
  ///   - period: 
  public init(
    period: TokenSyntax = TokenSyntax.`period`
  ) {
    self.period = period
    assert(["."].contains(self.period.text))
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

public protocol ExpressibleAsKeyPathBaseExpr: ExpressibleAsExprBuildable {
  func createKeyPathBaseExpr() -> KeyPathBaseExpr
}

extension KeyPathBaseExpr: ExpressibleAsKeyPathBaseExpr {
  public func createKeyPathBaseExpr() -> KeyPathBaseExpr {
    self
  }
}

public struct ObjcNamePiece: SyntaxBuildable {
  let name: TokenSyntax
  let dot: TokenSyntax?

  /// Creates a `ObjcNamePiece` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - dot: 
  public init(
    name: TokenSyntax,
    dot: TokenSyntax? = nil
  ) {
    self.name = name
    self.dot = dot
    assert(dot == nil || ["."].contains(self.dot!.text))
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

public protocol ExpressibleAsObjcNamePiece: ExpressibleAsSyntaxBuildable, ExpressibleAsObjcName {
  func createObjcNamePiece() -> ObjcNamePiece
}

extension ObjcNamePiece: ExpressibleAsObjcNamePiece {
  public func createObjcNamePiece() -> ObjcNamePiece {
    self
  }
}

// MARK: - Syntax collection

/// `ObjcName` represents a collection of 
/// `ObjcNamePiece`s.
public struct ObjcName: SyntaxBuildable {
  let elements: [ObjcNamePiece]

  /// Creates a `ObjcName` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsObjcNamePiece`
  public init(_ elements: [ExpressibleAsObjcNamePiece]) {
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

extension ObjcName: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsObjcNamePiece...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsObjcName: ExpressibleAsSyntaxBuildable {
  func createObjcName() -> ObjcName
}

extension ObjcName: ExpressibleAsObjcName {
  public func createObjcName() -> ObjcName {
    self
  }
}

public struct ObjcKeyPathExpr: ExprBuildable {
  let keyPath: TokenSyntax
  let leftParen: TokenSyntax
  let name: ObjcName
  let rightParen: TokenSyntax

  /// Creates a `ObjcKeyPathExpr` using the provided parameters.
  /// - Parameters:
  ///   - keyPath: 
  ///   - leftParen: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    keyPath: TokenSyntax = TokenSyntax.`poundKeyPath`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: ExpressibleAsObjcName,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.keyPath = keyPath
    assert(["#keyPath"].contains(self.keyPath.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.name = name.createObjcName()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsObjcKeyPathExpr: ExpressibleAsExprBuildable {
  func createObjcKeyPathExpr() -> ObjcKeyPathExpr
}

extension ObjcKeyPathExpr: ExpressibleAsObjcKeyPathExpr {
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

  /// Creates a `ObjcSelectorExpr` using the provided parameters.
  /// - Parameters:
  ///   - poundSelector: 
  ///   - leftParen: 
  ///   - kind: 
  ///   - colon: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    poundSelector: TokenSyntax = TokenSyntax.`poundSelector`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    kind: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    name: ExpressibleAsExprBuildable,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundSelector = poundSelector
    assert(["#selector"].contains(self.poundSelector.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.kind = kind
    assert(kind == nil || ["getter", "setter"].contains(self.kind!.text))
    self.colon = colon
    assert(colon == nil || [":"].contains(self.colon!.text))
    self.name = name.createExprBuildable()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsObjcSelectorExpr: ExpressibleAsExprBuildable {
  func createObjcSelectorExpr() -> ObjcSelectorExpr
}

extension ObjcSelectorExpr: ExpressibleAsObjcSelectorExpr {
  public func createObjcSelectorExpr() -> ObjcSelectorExpr {
    self
  }
}

public struct PostfixIfConfigExpr: ExprBuildable {
  let base: ExprBuildable?
  let config: IfConfigDecl

  /// Creates a `PostfixIfConfigExpr` using the provided parameters.
  /// - Parameters:
  ///   - base: 
  ///   - config: 
  public init(
    base: ExpressibleAsExprBuildable? = nil,
    config: ExpressibleAsIfConfigDecl
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

public protocol ExpressibleAsPostfixIfConfigExpr: ExpressibleAsExprBuildable {
  func createPostfixIfConfigExpr() -> PostfixIfConfigExpr
}

extension PostfixIfConfigExpr: ExpressibleAsPostfixIfConfigExpr {
  public func createPostfixIfConfigExpr() -> PostfixIfConfigExpr {
    self
  }
}

public struct EditorPlaceholderExpr: ExprBuildable {
  let identifier: TokenSyntax

  /// Creates a `EditorPlaceholderExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
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

public protocol ExpressibleAsEditorPlaceholderExpr: ExpressibleAsExprBuildable {
  func createEditorPlaceholderExpr() -> EditorPlaceholderExpr
}

extension EditorPlaceholderExpr: ExpressibleAsEditorPlaceholderExpr {
  public func createEditorPlaceholderExpr() -> EditorPlaceholderExpr {
    self
  }
}

public struct ObjectLiteralExpr: ExprBuildable {
  let identifier: TokenSyntax
  let leftParen: TokenSyntax
  let arguments: TupleExprElementList
  let rightParen: TokenSyntax

  /// Creates a `ObjectLiteralExpr` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
  ///   - leftParen: 
  ///   - arguments: 
  ///   - rightParen: 
  public init(
    identifier: TokenSyntax,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsTupleExprElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.identifier = identifier
    assert(["#colorLiteral", "#fileLiteral", "#imageLiteral"].contains(self.identifier.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.arguments = arguments.createTupleExprElementList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsObjectLiteralExpr: ExpressibleAsExprBuildable {
  func createObjectLiteralExpr() -> ObjectLiteralExpr
}

extension ObjectLiteralExpr: ExpressibleAsObjectLiteralExpr {
  public func createObjectLiteralExpr() -> ObjectLiteralExpr {
    self
  }
}

public struct TypeInitializerClause: SyntaxBuildable {
  let equal: TokenSyntax
  let value: TypeBuildable

  /// Creates a `TypeInitializerClause` using the provided parameters.
  /// - Parameters:
  ///   - equal: 
  ///   - value: 
  public init(
    equal: TokenSyntax = TokenSyntax.`equal`,
    value: ExpressibleAsTypeBuildable
  ) {
    self.equal = equal
    assert(["="].contains(self.equal.text))
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

public protocol ExpressibleAsTypeInitializerClause: ExpressibleAsSyntaxBuildable {
  func createTypeInitializerClause() -> TypeInitializerClause
}

extension TypeInitializerClause: ExpressibleAsTypeInitializerClause {
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

  /// Creates a `TypealiasDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - typealiasKeyword: 
  ///   - identifier: 
  ///   - genericParameterClause: 
  ///   - initializer: 
  ///   - genericWhereClause: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    typealiasKeyword: TokenSyntax = TokenSyntax.`typealias`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.typealiasKeyword = typealiasKeyword
    assert(["typealias"].contains(self.typealiasKeyword.text))
    self.identifier = identifier
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

public protocol ExpressibleAsTypealiasDecl: ExpressibleAsDeclBuildable {
  func createTypealiasDecl() -> TypealiasDecl
}

extension TypealiasDecl: ExpressibleAsTypealiasDecl {
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

  /// Creates a `AssociatedtypeDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - associatedtypeKeyword: 
  ///   - identifier: 
  ///   - inheritanceClause: 
  ///   - initializer: 
  ///   - genericWhereClause: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    associatedtypeKeyword: TokenSyntax = TokenSyntax.`associatedtype`,
    identifier: TokenSyntax,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    initializer: ExpressibleAsTypeInitializerClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.associatedtypeKeyword = associatedtypeKeyword
    assert(["associatedtype"].contains(self.associatedtypeKeyword.text))
    self.identifier = identifier
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

public protocol ExpressibleAsAssociatedtypeDecl: ExpressibleAsDeclBuildable {
  func createAssociatedtypeDecl() -> AssociatedtypeDecl
}

extension AssociatedtypeDecl: ExpressibleAsAssociatedtypeDecl {
  public func createAssociatedtypeDecl() -> AssociatedtypeDecl {
    self
  }
}

// MARK: - Syntax collection

/// `FunctionParameterList` represents a collection of 
/// `FunctionParameter`s.
public struct FunctionParameterList: SyntaxBuildable {
  let elements: [FunctionParameter]

  /// Creates a `FunctionParameterList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsFunctionParameter`
  public init(_ elements: [ExpressibleAsFunctionParameter]) {
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

extension FunctionParameterList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsFunctionParameter...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsFunctionParameterList: ExpressibleAsSyntaxBuildable {
  func createFunctionParameterList() -> FunctionParameterList
}

extension FunctionParameterList: ExpressibleAsFunctionParameterList {
  public func createFunctionParameterList() -> FunctionParameterList {
    self
  }
}

public struct ParameterClause: SyntaxBuildable {
  let leftParen: TokenSyntax
  let parameterList: FunctionParameterList
  let rightParen: TokenSyntax

  /// Creates a `ParameterClause` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - parameterList: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    parameterList: ExpressibleAsFunctionParameterList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.parameterList = parameterList.createFunctionParameterList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsParameterClause: ExpressibleAsSyntaxBuildable {
  func createParameterClause() -> ParameterClause
}

extension ParameterClause: ExpressibleAsParameterClause {
  public func createParameterClause() -> ParameterClause {
    self
  }
}

public struct ReturnClause: SyntaxBuildable {
  let arrow: TokenSyntax
  let returnType: TypeBuildable

  /// Creates a `ReturnClause` using the provided parameters.
  /// - Parameters:
  ///   - arrow: 
  ///   - returnType: 
  public init(
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleAsTypeBuildable
  ) {
    self.arrow = arrow
    assert(["->"].contains(self.arrow.text))
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

public protocol ExpressibleAsReturnClause: ExpressibleAsSyntaxBuildable {
  func createReturnClause() -> ReturnClause
}

extension ReturnClause: ExpressibleAsReturnClause {
  public func createReturnClause() -> ReturnClause {
    self
  }
}

public struct FunctionSignature: SyntaxBuildable {
  let input: ParameterClause
  let asyncOrReasyncKeyword: TokenSyntax?
  let throwsOrRethrowsKeyword: TokenSyntax?
  let output: ReturnClause?

  /// Creates a `FunctionSignature` using the provided parameters.
  /// - Parameters:
  ///   - input: 
  ///   - asyncOrReasyncKeyword: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - output: 
  public init(
    input: ExpressibleAsParameterClause,
    asyncOrReasyncKeyword: TokenSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    output: ExpressibleAsReturnClause? = nil
  ) {
    self.input = input.createParameterClause()
    self.asyncOrReasyncKeyword = asyncOrReasyncKeyword
    assert(asyncOrReasyncKeyword == nil || ["async", "reasync"].contains(self.asyncOrReasyncKeyword!.text))
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    assert(throwsOrRethrowsKeyword == nil || ["throws", "rethrows"].contains(self.throwsOrRethrowsKeyword!.text))
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

public protocol ExpressibleAsFunctionSignature: ExpressibleAsSyntaxBuildable {
  func createFunctionSignature() -> FunctionSignature
}

extension FunctionSignature: ExpressibleAsFunctionSignature {
  public func createFunctionSignature() -> FunctionSignature {
    self
  }
}

public struct IfConfigClause: SyntaxBuildable {
  let poundKeyword: TokenSyntax
  let condition: ExprBuildable?
  let elements: SyntaxBuildable

  /// Creates a `IfConfigClause` using the provided parameters.
  /// - Parameters:
  ///   - poundKeyword: 
  ///   - condition: 
  ///   - elements: 
  public init(
    poundKeyword: TokenSyntax,
    condition: ExpressibleAsExprBuildable? = nil,
    elements: ExpressibleAsSyntaxBuildable
  ) {
    self.poundKeyword = poundKeyword
    assert(["#if", "#elseif", "#else"].contains(self.poundKeyword.text))
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

public protocol ExpressibleAsIfConfigClause: ExpressibleAsSyntaxBuildable, ExpressibleAsIfConfigClauseList {
  func createIfConfigClause() -> IfConfigClause
}

extension IfConfigClause: ExpressibleAsIfConfigClause {
  public func createIfConfigClause() -> IfConfigClause {
    self
  }
}

// MARK: - Syntax collection

/// `IfConfigClauseList` represents a collection of 
/// `IfConfigClause`s.
public struct IfConfigClauseList: SyntaxBuildable {
  let elements: [IfConfigClause]

  /// Creates a `IfConfigClauseList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsIfConfigClause`
  public init(_ elements: [ExpressibleAsIfConfigClause]) {
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

extension IfConfigClauseList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsIfConfigClause...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsIfConfigClauseList: ExpressibleAsSyntaxBuildable {
  func createIfConfigClauseList() -> IfConfigClauseList
}

extension IfConfigClauseList: ExpressibleAsIfConfigClauseList {
  public func createIfConfigClauseList() -> IfConfigClauseList {
    self
  }
}

public struct IfConfigDecl: DeclBuildable {
  let clauses: IfConfigClauseList
  let poundEndif: TokenSyntax

  /// Creates a `IfConfigDecl` using the provided parameters.
  /// - Parameters:
  ///   - clauses: 
  ///   - poundEndif: 
  public init(
    clauses: ExpressibleAsIfConfigClauseList,
    poundEndif: TokenSyntax = TokenSyntax.`poundEndif`
  ) {
    self.clauses = clauses.createIfConfigClauseList()
    self.poundEndif = poundEndif
    assert(["#endif"].contains(self.poundEndif.text))
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

public protocol ExpressibleAsIfConfigDecl: ExpressibleAsDeclBuildable {
  func createIfConfigDecl() -> IfConfigDecl
}

extension IfConfigDecl: ExpressibleAsIfConfigDecl {
  public func createIfConfigDecl() -> IfConfigDecl {
    self
  }
}

public struct PoundErrorDecl: DeclBuildable {
  let poundError: TokenSyntax
  let leftParen: TokenSyntax
  let message: StringLiteralExpr
  let rightParen: TokenSyntax

  /// Creates a `PoundErrorDecl` using the provided parameters.
  /// - Parameters:
  ///   - poundError: 
  ///   - leftParen: 
  ///   - message: 
  ///   - rightParen: 
  public init(
    poundError: TokenSyntax = TokenSyntax.`poundError`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    message: ExpressibleAsStringLiteralExpr,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundError = poundError
    assert(["#error"].contains(self.poundError.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.message = message.createStringLiteralExpr()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsPoundErrorDecl: ExpressibleAsDeclBuildable {
  func createPoundErrorDecl() -> PoundErrorDecl
}

extension PoundErrorDecl: ExpressibleAsPoundErrorDecl {
  public func createPoundErrorDecl() -> PoundErrorDecl {
    self
  }
}

public struct PoundWarningDecl: DeclBuildable {
  let poundWarning: TokenSyntax
  let leftParen: TokenSyntax
  let message: StringLiteralExpr
  let rightParen: TokenSyntax

  /// Creates a `PoundWarningDecl` using the provided parameters.
  /// - Parameters:
  ///   - poundWarning: 
  ///   - leftParen: 
  ///   - message: 
  ///   - rightParen: 
  public init(
    poundWarning: TokenSyntax = TokenSyntax.`poundWarning`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    message: ExpressibleAsStringLiteralExpr,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundWarning = poundWarning
    assert(["#warning"].contains(self.poundWarning.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.message = message.createStringLiteralExpr()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsPoundWarningDecl: ExpressibleAsDeclBuildable {
  func createPoundWarningDecl() -> PoundWarningDecl
}

extension PoundWarningDecl: ExpressibleAsPoundWarningDecl {
  public func createPoundWarningDecl() -> PoundWarningDecl {
    self
  }
}

public struct PoundSourceLocation: DeclBuildable {
  let poundSourceLocation: TokenSyntax
  let leftParen: TokenSyntax
  let args: PoundSourceLocationArgs?
  let rightParen: TokenSyntax

  /// Creates a `PoundSourceLocation` using the provided parameters.
  /// - Parameters:
  ///   - poundSourceLocation: 
  ///   - leftParen: 
  ///   - args: 
  ///   - rightParen: 
  public init(
    poundSourceLocation: TokenSyntax = TokenSyntax.`poundSourceLocation`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    args: ExpressibleAsPoundSourceLocationArgs? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundSourceLocation = poundSourceLocation
    assert(["#sourceLocation"].contains(self.poundSourceLocation.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.args = args?.createPoundSourceLocationArgs()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsPoundSourceLocation: ExpressibleAsDeclBuildable {
  func createPoundSourceLocation() -> PoundSourceLocation
}

extension PoundSourceLocation: ExpressibleAsPoundSourceLocation {
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

  /// Creates a `PoundSourceLocationArgs` using the provided parameters.
  /// - Parameters:
  ///   - fileArgLabel: 
  ///   - fileArgColon: 
  ///   - fileName: 
  ///   - comma: 
  ///   - lineArgLabel: 
  ///   - lineArgColon: 
  ///   - lineNumber: 
  public init(
    fileArgLabel: TokenSyntax,
    fileArgColon: TokenSyntax = TokenSyntax.`colon`,
    fileName: TokenSyntax,
    comma: TokenSyntax = TokenSyntax.`comma`,
    lineArgLabel: TokenSyntax,
    lineArgColon: TokenSyntax = TokenSyntax.`colon`,
    lineNumber: TokenSyntax
  ) {
    self.fileArgLabel = fileArgLabel
    assert(["file"].contains(self.fileArgLabel.text))
    self.fileArgColon = fileArgColon
    assert([":"].contains(self.fileArgColon.text))
    self.fileName = fileName
    self.comma = comma
    assert([","].contains(self.comma.text))
    self.lineArgLabel = lineArgLabel
    assert(["line"].contains(self.lineArgLabel.text))
    self.lineArgColon = lineArgColon
    assert([":"].contains(self.lineArgColon.text))
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

public protocol ExpressibleAsPoundSourceLocationArgs: ExpressibleAsSyntaxBuildable {
  func createPoundSourceLocationArgs() -> PoundSourceLocationArgs
}

extension PoundSourceLocationArgs: ExpressibleAsPoundSourceLocationArgs {
  public func createPoundSourceLocationArgs() -> PoundSourceLocationArgs {
    self
  }
}

public struct DeclModifier: SyntaxBuildable {
  let name: TokenSyntax
  let detailLeftParen: TokenSyntax?
  let detail: TokenSyntax?
  let detailRightParen: TokenSyntax?

  /// Creates a `DeclModifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - detailLeftParen: 
  ///   - detail: 
  ///   - detailRightParen: 
  public init(
    name: TokenSyntax,
    detailLeftParen: TokenSyntax? = nil,
    detail: TokenSyntax? = nil,
    detailRightParen: TokenSyntax? = nil
  ) {
    self.name = name
    assert(["class", "convenience", "dynamic", "final", "infix", "lazy", "optional", "override", "postfix", "prefix", "required", "static", "unowned", "weak", "private", "fileprivate", "internal", "public", "open", "mutating", "nonmutating", "indirect", "__consuming", "actor", "async", "distributed"].contains(self.name.text))
    self.detailLeftParen = detailLeftParen
    assert(detailLeftParen == nil || ["("].contains(self.detailLeftParen!.text))
    self.detail = detail
    self.detailRightParen = detailRightParen
    assert(detailRightParen == nil || [")"].contains(self.detailRightParen!.text))
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

public protocol ExpressibleAsDeclModifier: ExpressibleAsSyntaxBuildable, ExpressibleAsModifierList {
  func createDeclModifier() -> DeclModifier
}

extension DeclModifier: ExpressibleAsDeclModifier {
  public func createDeclModifier() -> DeclModifier {
    self
  }
}

public struct InheritedType: SyntaxBuildable {
  let typeName: TypeBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `InheritedType` using the provided parameters.
  /// - Parameters:
  ///   - typeName: 
  ///   - trailingComma: 
  public init(
    typeName: ExpressibleAsTypeBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.typeName = typeName.createTypeBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsInheritedType: ExpressibleAsSyntaxBuildable, ExpressibleAsInheritedTypeList {
  func createInheritedType() -> InheritedType
}

extension InheritedType: ExpressibleAsInheritedType {
  public func createInheritedType() -> InheritedType {
    self
  }
}

// MARK: - Syntax collection

/// `InheritedTypeList` represents a collection of 
/// `InheritedType`s.
public struct InheritedTypeList: SyntaxBuildable {
  let elements: [InheritedType]

  /// Creates a `InheritedTypeList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsInheritedType`
  public init(_ elements: [ExpressibleAsInheritedType]) {
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

extension InheritedTypeList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsInheritedType...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsInheritedTypeList: ExpressibleAsSyntaxBuildable {
  func createInheritedTypeList() -> InheritedTypeList
}

extension InheritedTypeList: ExpressibleAsInheritedTypeList {
  public func createInheritedTypeList() -> InheritedTypeList {
    self
  }
}

public struct TypeInheritanceClause: SyntaxBuildable {
  let colon: TokenSyntax
  let inheritedTypeCollection: InheritedTypeList

  /// Creates a `TypeInheritanceClause` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - inheritedTypeCollection: 
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
    inheritedTypeCollection: ExpressibleAsInheritedTypeList
  ) {
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsTypeInheritanceClause: ExpressibleAsSyntaxBuildable {
  func createTypeInheritanceClause() -> TypeInheritanceClause
}

extension TypeInheritanceClause: ExpressibleAsTypeInheritanceClause {
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

  /// Creates a `ClassDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - classOrActorKeyword: 
  ///   - identifier: 
  ///   - genericParameterClause: 
  ///   - inheritanceClause: 
  ///   - genericWhereClause: 
  ///   - members: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    classOrActorKeyword: TokenSyntax,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.classOrActorKeyword = classOrActorKeyword
    self.identifier = identifier
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

public protocol ExpressibleAsClassDecl: ExpressibleAsDeclBuildable {
  func createClassDecl() -> ClassDecl
}

extension ClassDecl: ExpressibleAsClassDecl {
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

  /// Creates a `StructDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - structKeyword: 
  ///   - identifier: 
  ///   - genericParameterClause: 
  ///   - inheritanceClause: 
  ///   - genericWhereClause: 
  ///   - members: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    structKeyword: TokenSyntax = TokenSyntax.`struct`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.structKeyword = structKeyword
    assert(["struct"].contains(self.structKeyword.text))
    self.identifier = identifier
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

public protocol ExpressibleAsStructDecl: ExpressibleAsDeclBuildable {
  func createStructDecl() -> StructDecl
}

extension StructDecl: ExpressibleAsStructDecl {
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

  /// Creates a `ProtocolDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - protocolKeyword: 
  ///   - identifier: 
  ///   - inheritanceClause: 
  ///   - genericWhereClause: 
  ///   - members: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    protocolKeyword: TokenSyntax = TokenSyntax.`protocol`,
    identifier: TokenSyntax,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.protocolKeyword = protocolKeyword
    assert(["protocol"].contains(self.protocolKeyword.text))
    self.identifier = identifier
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

public protocol ExpressibleAsProtocolDecl: ExpressibleAsDeclBuildable {
  func createProtocolDecl() -> ProtocolDecl
}

extension ProtocolDecl: ExpressibleAsProtocolDecl {
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

  /// Creates a `ExtensionDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - extensionKeyword: 
  ///   - extendedType: 
  ///   - inheritanceClause: 
  ///   - genericWhereClause: 
  ///   - members: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    extensionKeyword: TokenSyntax = TokenSyntax.`extension`,
    extendedType: ExpressibleAsTypeBuildable,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.extensionKeyword = extensionKeyword
    assert(["extension"].contains(self.extensionKeyword.text))
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

public protocol ExpressibleAsExtensionDecl: ExpressibleAsDeclBuildable {
  func createExtensionDecl() -> ExtensionDecl
}

extension ExtensionDecl: ExpressibleAsExtensionDecl {
  public func createExtensionDecl() -> ExtensionDecl {
    self
  }
}

public struct MemberDeclBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let members: MemberDeclList
  let rightBrace: TokenSyntax

  /// Creates a `MemberDeclBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - members: 
  ///   - rightBrace: 
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    members: ExpressibleAsMemberDeclList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace
    assert(["{"].contains(self.leftBrace.text))
    self.members = members.createMemberDeclList()
    self.rightBrace = rightBrace
    assert(["}"].contains(self.rightBrace.text))
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

public protocol ExpressibleAsMemberDeclBlock: ExpressibleAsSyntaxBuildable {
  func createMemberDeclBlock() -> MemberDeclBlock
}

extension MemberDeclBlock: ExpressibleAsMemberDeclBlock {
  public func createMemberDeclBlock() -> MemberDeclBlock {
    self
  }
}

// MARK: - Syntax collection

/// `MemberDeclList` represents a collection of 
/// `MemberDeclListItem`s.
public struct MemberDeclList: SyntaxBuildable {
  let elements: [MemberDeclListItem]

  /// Creates a `MemberDeclList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsMemberDeclListItem`
  public init(_ elements: [ExpressibleAsMemberDeclListItem]) {
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

extension MemberDeclList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsMemberDeclListItem...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsMemberDeclList: ExpressibleAsSyntaxBuildable, ExpressibleAsMemberDeclBlock {
  func createMemberDeclList() -> MemberDeclList
}

extension MemberDeclList: ExpressibleAsMemberDeclList {
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

  /// Creates a `MemberDeclListItem` using the provided parameters.
  /// - Parameters:
  ///   - decl: The declaration of the type member.
  ///   - semicolon: An optional trailing semicolon.
  public init(
    decl: ExpressibleAsDeclBuildable,
    semicolon: TokenSyntax? = nil
  ) {
    self.decl = decl.createDeclBuildable()
    self.semicolon = semicolon
    assert(semicolon == nil || [";"].contains(self.semicolon!.text))
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

public protocol ExpressibleAsMemberDeclListItem: ExpressibleAsSyntaxBuildable, ExpressibleAsMemberDeclList {
  func createMemberDeclListItem() -> MemberDeclListItem
}

extension MemberDeclListItem: ExpressibleAsMemberDeclListItem {
  public func createMemberDeclListItem() -> MemberDeclListItem {
    self
  }
}

public struct SourceFile: SyntaxBuildable {
  let statements: CodeBlockItemList
  let eofToken: TokenSyntax

  /// Creates a `SourceFile` using the provided parameters.
  /// - Parameters:
  ///   - statements: 
  ///   - eofToken: 
  public init(
    statements: ExpressibleAsCodeBlockItemList,
    eofToken: TokenSyntax
  ) {
    self.statements = statements.createCodeBlockItemList()
    self.eofToken = eofToken
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

public protocol ExpressibleAsSourceFile: ExpressibleAsSyntaxBuildable {
  func createSourceFile() -> SourceFile
}

extension SourceFile: ExpressibleAsSourceFile {
  public func createSourceFile() -> SourceFile {
    self
  }
}

public struct InitializerClause: SyntaxBuildable {
  let equal: TokenSyntax
  let value: ExprBuildable

  /// Creates a `InitializerClause` using the provided parameters.
  /// - Parameters:
  ///   - equal: 
  ///   - value: 
  public init(
    equal: TokenSyntax = TokenSyntax.`equal`,
    value: ExpressibleAsExprBuildable
  ) {
    self.equal = equal
    assert(["="].contains(self.equal.text))
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

public protocol ExpressibleAsInitializerClause: ExpressibleAsSyntaxBuildable {
  func createInitializerClause() -> InitializerClause
}

extension InitializerClause: ExpressibleAsInitializerClause {
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

  /// Creates a `FunctionParameter` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - firstName: 
  ///   - secondName: 
  ///   - colon: 
  ///   - type: 
  ///   - ellipsis: 
  ///   - defaultArgument: 
  ///   - trailingComma: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    firstName: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: ExpressibleAsTypeBuildable? = nil,
    ellipsis: TokenSyntax? = nil,
    defaultArgument: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.firstName = firstName
    self.secondName = secondName
    self.colon = colon
    assert(colon == nil || [":"].contains(self.colon!.text))
    self.type = type?.createTypeBuildable()
    self.ellipsis = ellipsis
    assert(ellipsis == nil || ["..."].contains(self.ellipsis!.text))
    self.defaultArgument = defaultArgument?.createInitializerClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsFunctionParameter: ExpressibleAsSyntaxBuildable, ExpressibleAsFunctionParameterList {
  func createFunctionParameter() -> FunctionParameter
}

extension FunctionParameter: ExpressibleAsFunctionParameter {
  public func createFunctionParameter() -> FunctionParameter {
    self
  }
}

// MARK: - Syntax collection

/// `ModifierList` represents a collection of 
/// `DeclModifier`s.
public struct ModifierList: SyntaxBuildable {
  let elements: [DeclModifier]

  /// Creates a `ModifierList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsDeclModifier`
  public init(_ elements: [ExpressibleAsDeclModifier]) {
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

extension ModifierList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsDeclModifier...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsModifierList: ExpressibleAsSyntaxBuildable {
  func createModifierList() -> ModifierList
}

extension ModifierList: ExpressibleAsModifierList {
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

  /// Creates a `FunctionDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - funcKeyword: 
  ///   - identifier: 
  ///   - genericParameterClause: 
  ///   - signature: 
  ///   - genericWhereClause: 
  ///   - body: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    funcKeyword: TokenSyntax = TokenSyntax.`func`,
    identifier: TokenSyntax,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    signature: ExpressibleAsFunctionSignature,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.funcKeyword = funcKeyword
    assert(["func"].contains(self.funcKeyword.text))
    self.identifier = identifier
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

public protocol ExpressibleAsFunctionDecl: ExpressibleAsDeclBuildable {
  func createFunctionDecl() -> FunctionDecl
}

extension FunctionDecl: ExpressibleAsFunctionDecl {
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

  /// Creates a `InitializerDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - initKeyword: 
  ///   - optionalMark: 
  ///   - genericParameterClause: 
  ///   - parameters: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - genericWhereClause: 
  ///   - body: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    initKeyword: TokenSyntax = TokenSyntax.`init`,
    optionalMark: TokenSyntax? = nil,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    parameters: ExpressibleAsParameterClause,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.initKeyword = initKeyword
    assert(["init"].contains(self.initKeyword.text))
    self.optionalMark = optionalMark
    assert(optionalMark == nil || ["?", "?", "!"].contains(self.optionalMark!.text))
    self.genericParameterClause = genericParameterClause?.createGenericParameterClause()
    self.parameters = parameters.createParameterClause()
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    assert(throwsOrRethrowsKeyword == nil || ["throws", "rethrows"].contains(self.throwsOrRethrowsKeyword!.text))
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

public protocol ExpressibleAsInitializerDecl: ExpressibleAsDeclBuildable {
  func createInitializerDecl() -> InitializerDecl
}

extension InitializerDecl: ExpressibleAsInitializerDecl {
  public func createInitializerDecl() -> InitializerDecl {
    self
  }
}

public struct DeinitializerDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let deinitKeyword: TokenSyntax
  let body: CodeBlock

  /// Creates a `DeinitializerDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - deinitKeyword: 
  ///   - body: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    deinitKeyword: TokenSyntax = TokenSyntax.`deinit`,
    body: ExpressibleAsCodeBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.deinitKeyword = deinitKeyword
    assert(["deinit"].contains(self.deinitKeyword.text))
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

public protocol ExpressibleAsDeinitializerDecl: ExpressibleAsDeclBuildable {
  func createDeinitializerDecl() -> DeinitializerDecl
}

extension DeinitializerDecl: ExpressibleAsDeinitializerDecl {
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

  /// Creates a `SubscriptDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - subscriptKeyword: 
  ///   - genericParameterClause: 
  ///   - indices: 
  ///   - result: 
  ///   - genericWhereClause: 
  ///   - accessor: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    subscriptKeyword: TokenSyntax = TokenSyntax.`subscript`,
    genericParameterClause: ExpressibleAsGenericParameterClause? = nil,
    indices: ExpressibleAsParameterClause,
    result: ExpressibleAsReturnClause,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.subscriptKeyword = subscriptKeyword
    assert(["subscript"].contains(self.subscriptKeyword.text))
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

public protocol ExpressibleAsSubscriptDecl: ExpressibleAsDeclBuildable {
  func createSubscriptDecl() -> SubscriptDecl
}

extension SubscriptDecl: ExpressibleAsSubscriptDecl {
  public func createSubscriptDecl() -> SubscriptDecl {
    self
  }
}

public struct AccessLevelModifier: SyntaxBuildable {
  let name: TokenSyntax
  let leftParen: TokenSyntax?
  let modifier: TokenSyntax?
  let rightParen: TokenSyntax?

  /// Creates a `AccessLevelModifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - leftParen: 
  ///   - modifier: 
  ///   - rightParen: 
  public init(
    name: TokenSyntax,
    leftParen: TokenSyntax? = nil,
    modifier: TokenSyntax? = nil,
    rightParen: TokenSyntax? = nil
  ) {
    self.name = name
    self.leftParen = leftParen
    assert(leftParen == nil || ["("].contains(self.leftParen!.text))
    self.modifier = modifier
    self.rightParen = rightParen
    assert(rightParen == nil || [")"].contains(self.rightParen!.text))
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

public protocol ExpressibleAsAccessLevelModifier: ExpressibleAsSyntaxBuildable {
  func createAccessLevelModifier() -> AccessLevelModifier
}

extension AccessLevelModifier: ExpressibleAsAccessLevelModifier {
  public func createAccessLevelModifier() -> AccessLevelModifier {
    self
  }
}

public struct AccessPathComponent: SyntaxBuildable {
  let name: TokenSyntax
  let trailingDot: TokenSyntax?

  /// Creates a `AccessPathComponent` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingDot: 
  public init(
    name: TokenSyntax,
    trailingDot: TokenSyntax? = nil
  ) {
    self.name = name
    self.trailingDot = trailingDot
    assert(trailingDot == nil || ["."].contains(self.trailingDot!.text))
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

public protocol ExpressibleAsAccessPathComponent: ExpressibleAsSyntaxBuildable, ExpressibleAsAccessPath {
  func createAccessPathComponent() -> AccessPathComponent
}

extension AccessPathComponent: ExpressibleAsAccessPathComponent {
  public func createAccessPathComponent() -> AccessPathComponent {
    self
  }
}

// MARK: - Syntax collection

/// `AccessPath` represents a collection of 
/// `AccessPathComponent`s.
public struct AccessPath: SyntaxBuildable {
  let elements: [AccessPathComponent]

  /// Creates a `AccessPath` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsAccessPathComponent`
  public init(_ elements: [ExpressibleAsAccessPathComponent]) {
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

extension AccessPath: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsAccessPathComponent...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsAccessPath: ExpressibleAsSyntaxBuildable {
  func createAccessPath() -> AccessPath
}

extension AccessPath: ExpressibleAsAccessPath {
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

  /// Creates a `ImportDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - importTok: 
  ///   - importKind: 
  ///   - path: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    importTok: TokenSyntax = TokenSyntax.`import`,
    importKind: TokenSyntax? = nil,
    path: ExpressibleAsAccessPath
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.importTok = importTok
    assert(["import"].contains(self.importTok.text))
    self.importKind = importKind
    assert(importKind == nil || ["typealias", "struct", "class", "enum", "protocol", "var", "let", "func"].contains(self.importKind!.text))
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

public protocol ExpressibleAsImportDecl: ExpressibleAsDeclBuildable {
  func createImportDecl() -> ImportDecl
}

extension ImportDecl: ExpressibleAsImportDecl {
  public func createImportDecl() -> ImportDecl {
    self
  }
}

public struct AccessorParameter: SyntaxBuildable {
  let leftParen: TokenSyntax
  let name: TokenSyntax
  let rightParen: TokenSyntax

  /// Creates a `AccessorParameter` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - name: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    name: TokenSyntax,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.name = name
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsAccessorParameter: ExpressibleAsSyntaxBuildable {
  func createAccessorParameter() -> AccessorParameter
}

extension AccessorParameter: ExpressibleAsAccessorParameter {
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

  /// Creates a `AccessorDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifier: 
  ///   - accessorKind: 
  ///   - parameter: 
  ///   - asyncKeyword: 
  ///   - throwsKeyword: 
  ///   - body: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifier: ExpressibleAsDeclModifier? = nil,
    accessorKind: TokenSyntax,
    parameter: ExpressibleAsAccessorParameter? = nil,
    asyncKeyword: TokenSyntax? = nil,
    throwsKeyword: TokenSyntax? = nil,
    body: ExpressibleAsCodeBlock? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifier = modifier?.createDeclModifier()
    self.accessorKind = accessorKind
    assert(["get", "set", "didSet", "willSet", "unsafeAddress", "addressWithOwner", "addressWithNativeOwner", "unsafeMutableAddress", "mutableAddressWithOwner", "mutableAddressWithNativeOwner", "_read", "_modify"].contains(self.accessorKind.text))
    self.parameter = parameter?.createAccessorParameter()
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || ["async"].contains(self.asyncKeyword!.text))
    self.throwsKeyword = throwsKeyword
    assert(throwsKeyword == nil || ["throws", "rethrows"].contains(self.throwsKeyword!.text))
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

public protocol ExpressibleAsAccessorDecl: ExpressibleAsDeclBuildable, ExpressibleAsAccessorList {
  func createAccessorDecl() -> AccessorDecl
}

extension AccessorDecl: ExpressibleAsAccessorDecl {
  public func createAccessorDecl() -> AccessorDecl {
    self
  }
}

// MARK: - Syntax collection

/// `AccessorList` represents a collection of 
/// `AccessorDecl`s.
public struct AccessorList: SyntaxBuildable {
  let elements: [AccessorDecl]

  /// Creates a `AccessorList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsAccessorDecl`
  public init(_ elements: [ExpressibleAsAccessorDecl]) {
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

extension AccessorList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsAccessorDecl...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsAccessorList: ExpressibleAsSyntaxBuildable, ExpressibleAsAccessorBlock {
  func createAccessorList() -> AccessorList
}

extension AccessorList: ExpressibleAsAccessorList {
  public func createAccessorList() -> AccessorList {
    self
  }
}

public struct AccessorBlock: SyntaxBuildable {
  let leftBrace: TokenSyntax
  let accessors: AccessorList
  let rightBrace: TokenSyntax

  /// Creates a `AccessorBlock` using the provided parameters.
  /// - Parameters:
  ///   - leftBrace: 
  ///   - accessors: 
  ///   - rightBrace: 
  public init(
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    accessors: ExpressibleAsAccessorList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.leftBrace = leftBrace
    assert(["{"].contains(self.leftBrace.text))
    self.accessors = accessors.createAccessorList()
    self.rightBrace = rightBrace
    assert(["}"].contains(self.rightBrace.text))
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

public protocol ExpressibleAsAccessorBlock: ExpressibleAsSyntaxBuildable {
  func createAccessorBlock() -> AccessorBlock
}

extension AccessorBlock: ExpressibleAsAccessorBlock {
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

  /// Creates a `PatternBinding` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  ///   - accessor: 
  ///   - trailingComma: 
  public init(
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause? = nil,
    accessor: ExpressibleAsSyntaxBuildable? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.initializer = initializer?.createInitializerClause()
    self.accessor = accessor?.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsPatternBinding: ExpressibleAsSyntaxBuildable, ExpressibleAsPatternBindingList {
  func createPatternBinding() -> PatternBinding
}

extension PatternBinding: ExpressibleAsPatternBinding {
  public func createPatternBinding() -> PatternBinding {
    self
  }
}

// MARK: - Syntax collection

/// `PatternBindingList` represents a collection of 
/// `PatternBinding`s.
public struct PatternBindingList: SyntaxBuildable {
  let elements: [PatternBinding]

  /// Creates a `PatternBindingList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsPatternBinding`
  public init(_ elements: [ExpressibleAsPatternBinding]) {
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

extension PatternBindingList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsPatternBinding...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsPatternBindingList: ExpressibleAsSyntaxBuildable {
  func createPatternBindingList() -> PatternBindingList
}

extension PatternBindingList: ExpressibleAsPatternBindingList {
  public func createPatternBindingList() -> PatternBindingList {
    self
  }
}

public struct VariableDecl: DeclBuildable {
  let attributes: AttributeList?
  let modifiers: ModifierList?
  let letOrVarKeyword: TokenSyntax
  let bindings: PatternBindingList

  /// Creates a `VariableDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - modifiers: 
  ///   - letOrVarKeyword: 
  ///   - bindings: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    letOrVarKeyword: TokenSyntax,
    bindings: ExpressibleAsPatternBindingList
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.letOrVarKeyword = letOrVarKeyword
    assert(["let", "var"].contains(self.letOrVarKeyword.text))
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

public protocol ExpressibleAsVariableDecl: ExpressibleAsDeclBuildable {
  func createVariableDecl() -> VariableDecl
}

extension VariableDecl: ExpressibleAsVariableDecl {
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

  /// Creates a `EnumCaseElement` using the provided parameters.
  /// - Parameters:
  ///   - identifier: The name of this case.
  ///   - associatedValue: The set of associated values of the case.
  ///   - rawValue: The raw value of this enum element, if present.
  ///   - trailingComma: The trailing comma of this element, if the case hasmultiple elements.
  public init(
    identifier: TokenSyntax,
    associatedValue: ExpressibleAsParameterClause? = nil,
    rawValue: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.identifier = identifier
    self.associatedValue = associatedValue?.createParameterClause()
    self.rawValue = rawValue?.createInitializerClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsEnumCaseElement: ExpressibleAsSyntaxBuildable, ExpressibleAsEnumCaseElementList {
  func createEnumCaseElement() -> EnumCaseElement
}

extension EnumCaseElement: ExpressibleAsEnumCaseElement {
  public func createEnumCaseElement() -> EnumCaseElement {
    self
  }
}

// MARK: - Syntax collection

/// A collection of 0 or more `EnumCaseElement`s.
public struct EnumCaseElementList: SyntaxBuildable {
  let elements: [EnumCaseElement]

  /// Creates a `EnumCaseElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsEnumCaseElement`
  public init(_ elements: [ExpressibleAsEnumCaseElement]) {
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

extension EnumCaseElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsEnumCaseElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsEnumCaseElementList: ExpressibleAsSyntaxBuildable {
  func createEnumCaseElementList() -> EnumCaseElementList
}

extension EnumCaseElementList: ExpressibleAsEnumCaseElementList {
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

  /// Creates a `EnumCaseDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the case declaration.
  ///   - modifiers: The declaration modifiers applied to the case declaration.
  ///   - caseKeyword: The `case` keyword for this case.
  ///   - elements: The elements this case declares.
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    elements: ExpressibleAsEnumCaseElementList
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.caseKeyword = caseKeyword
    assert(["case"].contains(self.caseKeyword.text))
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

public protocol ExpressibleAsEnumCaseDecl: ExpressibleAsDeclBuildable {
  func createEnumCaseDecl() -> EnumCaseDecl
}

extension EnumCaseDecl: ExpressibleAsEnumCaseDecl {
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

  /// Creates a `EnumDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the enum declaration.
  ///   - modifiers: The declaration modifiers applied to the enum declaration.
  ///   - enumKeyword: The `enum` keyword for this declaration.
  ///   - identifier: The name of this enum.
  ///   - genericParameters: The generic parameters, if any, for this enum.
  ///   - inheritanceClause: The inheritance clause describing conformances or rawvalues for this enum.
  ///   - genericWhereClause: The `where` clause that applies to the generic parameters ofthis enum.
  ///   - members: The cases and other members of this enum.
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    enumKeyword: TokenSyntax = TokenSyntax.`enum`,
    identifier: TokenSyntax,
    genericParameters: ExpressibleAsGenericParameterClause? = nil,
    inheritanceClause: ExpressibleAsTypeInheritanceClause? = nil,
    genericWhereClause: ExpressibleAsGenericWhereClause? = nil,
    members: ExpressibleAsMemberDeclBlock
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.enumKeyword = enumKeyword
    assert(["enum"].contains(self.enumKeyword.text))
    self.identifier = identifier
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

public protocol ExpressibleAsEnumDecl: ExpressibleAsDeclBuildable {
  func createEnumDecl() -> EnumDecl
}

extension EnumDecl: ExpressibleAsEnumDecl {
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

  /// Creates a `OperatorDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the 'operator' declaration.
  ///   - modifiers: The declaration modifiers applied to the 'operator'declaration.
  ///   - operatorKeyword: 
  ///   - identifier: 
  ///   - operatorPrecedenceAndTypes: Optionally specify a precedence group and designated types.
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    operatorKeyword: TokenSyntax = TokenSyntax.`operator`,
    identifier: TokenSyntax,
    operatorPrecedenceAndTypes: ExpressibleAsOperatorPrecedenceAndTypes? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.operatorKeyword = operatorKeyword
    assert(["operator"].contains(self.operatorKeyword.text))
    self.identifier = identifier
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

public protocol ExpressibleAsOperatorDecl: ExpressibleAsDeclBuildable {
  func createOperatorDecl() -> OperatorDecl
}

extension OperatorDecl: ExpressibleAsOperatorDecl {
  public func createOperatorDecl() -> OperatorDecl {
    self
  }
}

// MARK: - Syntax collection

/// `IdentifierList` represents a collection of 
/// `TokenSyntax`s.
public struct IdentifierList: SyntaxBuildable {
  let elements: [TokenSyntax]

  /// Creates a `IdentifierList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTokenSyntax`
  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
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

extension IdentifierList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: TokenSyntax...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsIdentifierList: ExpressibleAsSyntaxBuildable {
  func createIdentifierList() -> IdentifierList
}

extension IdentifierList: ExpressibleAsIdentifierList {
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

  /// Creates a `OperatorPrecedenceAndTypes` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - precedenceGroupAndDesignatedTypes: The precedence group and designated types for this operator
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
    precedenceGroupAndDesignatedTypes: ExpressibleAsIdentifierList
  ) {
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsOperatorPrecedenceAndTypes: ExpressibleAsSyntaxBuildable {
  func createOperatorPrecedenceAndTypes() -> OperatorPrecedenceAndTypes
}

extension OperatorPrecedenceAndTypes: ExpressibleAsOperatorPrecedenceAndTypes {
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

  /// Creates a `PrecedenceGroupDecl` using the provided parameters.
  /// - Parameters:
  ///   - attributes: The attributes applied to the 'precedencegroup' declaration.
  ///   - modifiers: The declaration modifiers applied to the 'precedencegroup'declaration.
  ///   - precedencegroupKeyword: 
  ///   - identifier: The name of this precedence group.
  ///   - leftBrace: 
  ///   - groupAttributes: The characteristics of this precedence group.
  ///   - rightBrace: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    modifiers: ExpressibleAsModifierList? = nil,
    precedencegroupKeyword: TokenSyntax = TokenSyntax.`precedencegroup`,
    identifier: TokenSyntax,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    groupAttributes: ExpressibleAsPrecedenceGroupAttributeList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.attributes = attributes?.createAttributeList()
    self.modifiers = modifiers?.createModifierList()
    self.precedencegroupKeyword = precedencegroupKeyword
    assert(["precedencegroup"].contains(self.precedencegroupKeyword.text))
    self.identifier = identifier
    self.leftBrace = leftBrace
    assert(["{"].contains(self.leftBrace.text))
    self.groupAttributes = groupAttributes.createPrecedenceGroupAttributeList()
    self.rightBrace = rightBrace
    assert(["}"].contains(self.rightBrace.text))
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

public protocol ExpressibleAsPrecedenceGroupDecl: ExpressibleAsDeclBuildable {
  func createPrecedenceGroupDecl() -> PrecedenceGroupDecl
}

extension PrecedenceGroupDecl: ExpressibleAsPrecedenceGroupDecl {
  public func createPrecedenceGroupDecl() -> PrecedenceGroupDecl {
    self
  }
}

// MARK: - Syntax collection

/// `PrecedenceGroupAttributeList` represents a collection of 
/// `SyntaxBuildable`s.
public struct PrecedenceGroupAttributeList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  /// Creates a `PrecedenceGroupAttributeList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
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

extension PrecedenceGroupAttributeList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsPrecedenceGroupAttributeList: ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupAttributeList() -> PrecedenceGroupAttributeList
}

extension PrecedenceGroupAttributeList: ExpressibleAsPrecedenceGroupAttributeList {
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

  /// Creates a `PrecedenceGroupRelation` using the provided parameters.
  /// - Parameters:
  ///   - higherThanOrLowerThan: The relation to specified other precedence groups.
  ///   - colon: 
  ///   - otherNames: The name of other precedence group to which this precedencegroup relates.
  public init(
    higherThanOrLowerThan: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    otherNames: ExpressibleAsPrecedenceGroupNameList
  ) {
    self.higherThanOrLowerThan = higherThanOrLowerThan
    assert(["higherThan", "lowerThan"].contains(self.higherThanOrLowerThan.text))
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsPrecedenceGroupRelation: ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupRelation() -> PrecedenceGroupRelation
}

extension PrecedenceGroupRelation: ExpressibleAsPrecedenceGroupRelation {
  public func createPrecedenceGroupRelation() -> PrecedenceGroupRelation {
    self
  }
}

// MARK: - Syntax collection

/// `PrecedenceGroupNameList` represents a collection of 
/// `PrecedenceGroupNameElement`s.
public struct PrecedenceGroupNameList: SyntaxBuildable {
  let elements: [PrecedenceGroupNameElement]

  /// Creates a `PrecedenceGroupNameList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsPrecedenceGroupNameElement`
  public init(_ elements: [ExpressibleAsPrecedenceGroupNameElement]) {
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

extension PrecedenceGroupNameList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsPrecedenceGroupNameElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsPrecedenceGroupNameList: ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupNameList() -> PrecedenceGroupNameList
}

extension PrecedenceGroupNameList: ExpressibleAsPrecedenceGroupNameList {
  public func createPrecedenceGroupNameList() -> PrecedenceGroupNameList {
    self
  }
}

public struct PrecedenceGroupNameElement: SyntaxBuildable {
  let name: TokenSyntax
  let trailingComma: TokenSyntax?

  /// Creates a `PrecedenceGroupNameElement` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - trailingComma: 
  public init(
    name: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.name = name
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsPrecedenceGroupNameElement: ExpressibleAsSyntaxBuildable, ExpressibleAsPrecedenceGroupNameList {
  func createPrecedenceGroupNameElement() -> PrecedenceGroupNameElement
}

extension PrecedenceGroupNameElement: ExpressibleAsPrecedenceGroupNameElement {
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

  /// Creates a `PrecedenceGroupAssignment` using the provided parameters.
  /// - Parameters:
  ///   - assignmentKeyword: 
  ///   - colon: 
  ///   - flag: When true, an operator in the corresponding precedence groupuses the same grouping rules during optional chaining as theassignment operators from the standard library. Otherwise,operators in the precedence group follows the same optionalchaining rules as operators that don't perform assignment.
  public init(
    assignmentKeyword: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    flag: TokenSyntax
  ) {
    self.assignmentKeyword = assignmentKeyword
    assert(["assignment"].contains(self.assignmentKeyword.text))
    self.colon = colon
    assert([":"].contains(self.colon.text))
    self.flag = flag
    assert(["true", "false"].contains(self.flag.text))
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

public protocol ExpressibleAsPrecedenceGroupAssignment: ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupAssignment() -> PrecedenceGroupAssignment
}

extension PrecedenceGroupAssignment: ExpressibleAsPrecedenceGroupAssignment {
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

  /// Creates a `PrecedenceGroupAssociativity` using the provided parameters.
  /// - Parameters:
  ///   - associativityKeyword: 
  ///   - colon: 
  ///   - value: Operators that are `left`-associative group left-to-right.Operators that are `right`-associative group right-to-left.Operators that are specified with an associativity of `none`don't associate at all
  public init(
    associativityKeyword: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax
  ) {
    self.associativityKeyword = associativityKeyword
    assert(["associativity"].contains(self.associativityKeyword.text))
    self.colon = colon
    assert([":"].contains(self.colon.text))
    self.value = value
    assert(["left", "right", "none"].contains(self.value.text))
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

public protocol ExpressibleAsPrecedenceGroupAssociativity: ExpressibleAsSyntaxBuildable {
  func createPrecedenceGroupAssociativity() -> PrecedenceGroupAssociativity
}

extension PrecedenceGroupAssociativity: ExpressibleAsPrecedenceGroupAssociativity {
  public func createPrecedenceGroupAssociativity() -> PrecedenceGroupAssociativity {
    self
  }
}

// MARK: - Syntax collection

/// `TokenList` represents a collection of 
/// `TokenSyntax`s.
public struct TokenList: SyntaxBuildable {
  let elements: [TokenSyntax]

  /// Creates a `TokenList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTokenSyntax`
  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
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

extension TokenList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: TokenSyntax...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsTokenList: ExpressibleAsSyntaxBuildable {
  func createTokenList() -> TokenList
}

extension TokenList: ExpressibleAsTokenList {
  public func createTokenList() -> TokenList {
    self
  }
}

// MARK: - Syntax collection

/// `NonEmptyTokenList` represents a collection of 
/// `TokenSyntax`s.
public struct NonEmptyTokenList: SyntaxBuildable {
  let elements: [TokenSyntax]

  /// Creates a `NonEmptyTokenList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTokenSyntax`
  public init(_ elements: [TokenSyntax]) {
    self.elements = elements
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

extension NonEmptyTokenList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: TokenSyntax...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsNonEmptyTokenList: ExpressibleAsSyntaxBuildable {
  func createNonEmptyTokenList() -> NonEmptyTokenList
}

extension NonEmptyTokenList: ExpressibleAsNonEmptyTokenList {
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

  /// Creates a `CustomAttribute` using the provided parameters.
  /// - Parameters:
  ///   - atSignToken: The `@` sign.
  ///   - attributeName: The name of the attribute.
  ///   - leftParen: 
  ///   - argumentList: 
  ///   - rightParen: 
  public init(
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: ExpressibleAsTypeBuildable,
    leftParen: TokenSyntax? = nil,
    argumentList: ExpressibleAsTupleExprElementList? = nil,
    rightParen: TokenSyntax? = nil
  ) {
    self.atSignToken = atSignToken
    assert(["@"].contains(self.atSignToken.text))
    self.attributeName = attributeName.createTypeBuildable()
    self.leftParen = leftParen
    assert(leftParen == nil || ["("].contains(self.leftParen!.text))
    self.argumentList = argumentList?.createTupleExprElementList()
    self.rightParen = rightParen
    assert(rightParen == nil || [")"].contains(self.rightParen!.text))
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

public protocol ExpressibleAsCustomAttribute: ExpressibleAsSyntaxBuildable {
  func createCustomAttribute() -> CustomAttribute
}

extension CustomAttribute: ExpressibleAsCustomAttribute {
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

  /// Creates a `Attribute` using the provided parameters.
  /// - Parameters:
  ///   - atSignToken: The `@` sign.
  ///   - attributeName: The name of the attribute.
  ///   - leftParen: If the attribute takes arguments, the opening parenthesis.
  ///   - argument: The arguments of the attribute. In case the attributetakes multiple arguments, they are gather in theappropriate takes first.
  ///   - rightParen: If the attribute takes arguments, the closing parenthesis.
  ///   - tokenList: 
  public init(
    atSignToken: TokenSyntax = TokenSyntax.`atSign`,
    attributeName: TokenSyntax,
    leftParen: TokenSyntax? = nil,
    argument: ExpressibleAsSyntaxBuildable? = nil,
    rightParen: TokenSyntax? = nil,
    tokenList: ExpressibleAsTokenList? = nil
  ) {
    self.atSignToken = atSignToken
    assert(["@"].contains(self.atSignToken.text))
    self.attributeName = attributeName
    self.leftParen = leftParen
    assert(leftParen == nil || ["("].contains(self.leftParen!.text))
    self.argument = argument?.createSyntaxBuildable()
    self.rightParen = rightParen
    assert(rightParen == nil || [")"].contains(self.rightParen!.text))
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

public protocol ExpressibleAsAttribute: ExpressibleAsSyntaxBuildable {
  func createAttribute() -> Attribute
}

extension Attribute: ExpressibleAsAttribute {
  public func createAttribute() -> Attribute {
    self
  }
}

// MARK: - Syntax collection

/// `AttributeList` represents a collection of 
/// `SyntaxBuildable`s.
public struct AttributeList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  /// Creates a `AttributeList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
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

extension AttributeList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsAttributeList: ExpressibleAsSyntaxBuildable {
  func createAttributeList() -> AttributeList
}

extension AttributeList: ExpressibleAsAttributeList {
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

  /// Creates a `SpecializeAttributeSpecList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
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

extension SpecializeAttributeSpecList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsSpecializeAttributeSpecList: ExpressibleAsSyntaxBuildable {
  func createSpecializeAttributeSpecList() -> SpecializeAttributeSpecList
}

extension SpecializeAttributeSpecList: ExpressibleAsSpecializeAttributeSpecList {
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

  /// Creates a `AvailabilityEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - availabilityList: 
  ///   - semicolon: 
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    availabilityList: ExpressibleAsAvailabilitySpecList,
    semicolon: TokenSyntax = TokenSyntax.`semicolon`
  ) {
    self.label = label
    self.colon = colon
    assert([":"].contains(self.colon.text))
    self.availabilityList = availabilityList.createAvailabilitySpecList()
    self.semicolon = semicolon
    assert([";"].contains(self.semicolon.text))
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

public protocol ExpressibleAsAvailabilityEntry: ExpressibleAsSyntaxBuildable {
  func createAvailabilityEntry() -> AvailabilityEntry
}

extension AvailabilityEntry: ExpressibleAsAvailabilityEntry {
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

  /// Creates a `LabeledSpecializeEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - value: The value for this argument
  ///   - trailingComma: A trailing comma if this argument is followed by another one
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: TokenSyntax,
    trailingComma: TokenSyntax? = nil
  ) {
    self.label = label
    self.colon = colon
    assert([":"].contains(self.colon.text))
    self.value = value
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsLabeledSpecializeEntry: ExpressibleAsSyntaxBuildable {
  func createLabeledSpecializeEntry() -> LabeledSpecializeEntry
}

extension LabeledSpecializeEntry: ExpressibleAsLabeledSpecializeEntry {
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

  /// Creates a `TargetFunctionEntry` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - delcname: The value for this argument
  ///   - trailingComma: A trailing comma if this argument is followed by another one
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    delcname: ExpressibleAsDeclName,
    trailingComma: TokenSyntax? = nil
  ) {
    self.label = label
    self.colon = colon
    assert([":"].contains(self.colon.text))
    self.delcname = delcname.createDeclName()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsTargetFunctionEntry: ExpressibleAsSyntaxBuildable {
  func createTargetFunctionEntry() -> TargetFunctionEntry
}

extension TargetFunctionEntry: ExpressibleAsTargetFunctionEntry {
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

  /// Creates a `NamedAttributeStringArgument` using the provided parameters.
  /// - Parameters:
  ///   - nameTok: The label of the argument
  ///   - colon: The colon separating the label and the value
  ///   - stringOrDeclname: 
  public init(
    nameTok: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    stringOrDeclname: ExpressibleAsSyntaxBuildable
  ) {
    self.nameTok = nameTok
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsNamedAttributeStringArgument: ExpressibleAsSyntaxBuildable {
  func createNamedAttributeStringArgument() -> NamedAttributeStringArgument
}

extension NamedAttributeStringArgument: ExpressibleAsNamedAttributeStringArgument {
  public func createNamedAttributeStringArgument() -> NamedAttributeStringArgument {
    self
  }
}

public struct DeclName: SyntaxBuildable {
  let declBaseName: SyntaxBuildable
  let declNameArguments: DeclNameArguments?

  /// Creates a `DeclName` using the provided parameters.
  /// - Parameters:
  ///   - declBaseName: The base name of the protocol's requirement.
  ///   - declNameArguments: The argument labels of the protocol's requirement if itis a function requirement.
  public init(
    declBaseName: ExpressibleAsSyntaxBuildable,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
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

public protocol ExpressibleAsDeclName: ExpressibleAsSyntaxBuildable {
  func createDeclName() -> DeclName
}

extension DeclName: ExpressibleAsDeclName {
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

  /// Creates a `ImplementsAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - type: The type for which the method with this attributeimplements a requirement.
  ///   - comma: The comma separating the type and method name
  ///   - declBaseName: The base name of the protocol's requirement.
  ///   - declNameArguments: The argument labels of the protocol's requirement if itis a function requirement.
  public init(
    type: ExpressibleAsSimpleTypeIdentifier,
    comma: TokenSyntax = TokenSyntax.`comma`,
    declBaseName: ExpressibleAsSyntaxBuildable,
    declNameArguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.type = type.createSimpleTypeIdentifier()
    self.comma = comma
    assert([","].contains(self.comma.text))
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

public protocol ExpressibleAsImplementsAttributeArguments: ExpressibleAsSyntaxBuildable {
  func createImplementsAttributeArguments() -> ImplementsAttributeArguments
}

extension ImplementsAttributeArguments: ExpressibleAsImplementsAttributeArguments {
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

  /// Creates a `ObjCSelectorPiece` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - colon: 
  public init(
    name: TokenSyntax? = nil,
    colon: TokenSyntax? = nil
  ) {
    self.name = name
    self.colon = colon
    assert(colon == nil || [":"].contains(self.colon!.text))
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

public protocol ExpressibleAsObjCSelectorPiece: ExpressibleAsSyntaxBuildable, ExpressibleAsObjCSelector {
  func createObjCSelectorPiece() -> ObjCSelectorPiece
}

extension ObjCSelectorPiece: ExpressibleAsObjCSelectorPiece {
  public func createObjCSelectorPiece() -> ObjCSelectorPiece {
    self
  }
}

// MARK: - Syntax collection

/// `ObjCSelector` represents a collection of 
/// `ObjCSelectorPiece`s.
public struct ObjCSelector: SyntaxBuildable {
  let elements: [ObjCSelectorPiece]

  /// Creates a `ObjCSelector` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsObjCSelectorPiece`
  public init(_ elements: [ExpressibleAsObjCSelectorPiece]) {
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

extension ObjCSelector: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsObjCSelectorPiece...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsObjCSelector: ExpressibleAsSyntaxBuildable {
  func createObjCSelector() -> ObjCSelector
}

extension ObjCSelector: ExpressibleAsObjCSelector {
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

  /// Creates a `DifferentiableAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - diffKind: 
  ///   - diffKindComma: The comma following the differentiability kind, if it exists.
  ///   - diffParams: 
  ///   - diffParamsComma: The comma following the differentiability parameters clause,if it exists.
  ///   - whereClause: 
  public init(
    diffKind: TokenSyntax? = nil,
    diffKindComma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil,
    diffParamsComma: TokenSyntax? = nil,
    whereClause: ExpressibleAsGenericWhereClause? = nil
  ) {
    self.diffKind = diffKind
    assert(diffKind == nil || ["forward", "reverse", "linear"].contains(self.diffKind!.text))
    self.diffKindComma = diffKindComma
    assert(diffKindComma == nil || [","].contains(self.diffKindComma!.text))
    self.diffParams = diffParams?.createDifferentiabilityParamsClause()
    self.diffParamsComma = diffParamsComma
    assert(diffParamsComma == nil || [","].contains(self.diffParamsComma!.text))
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

public protocol ExpressibleAsDifferentiableAttributeArguments: ExpressibleAsSyntaxBuildable {
  func createDifferentiableAttributeArguments() -> DifferentiableAttributeArguments
}

extension DifferentiableAttributeArguments: ExpressibleAsDifferentiableAttributeArguments {
  public func createDifferentiableAttributeArguments() -> DifferentiableAttributeArguments {
    self
  }
}

/// A clause containing differentiability parameters.
public struct DifferentiabilityParamsClause: SyntaxBuildable {
  let wrtLabel: TokenSyntax
  let colon: TokenSyntax
  let parameters: SyntaxBuildable

  /// Creates a `DifferentiabilityParamsClause` using the provided parameters.
  /// - Parameters:
  ///   - wrtLabel: The "wrt" label.
  ///   - colon: The colon separating "wrt" and the parameter list.
  ///   - parameters: 
  public init(
    wrtLabel: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    parameters: ExpressibleAsSyntaxBuildable
  ) {
    self.wrtLabel = wrtLabel
    assert(["wrt"].contains(self.wrtLabel.text))
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsDifferentiabilityParamsClause: ExpressibleAsSyntaxBuildable {
  func createDifferentiabilityParamsClause() -> DifferentiabilityParamsClause
}

extension DifferentiabilityParamsClause: ExpressibleAsDifferentiabilityParamsClause {
  public func createDifferentiabilityParamsClause() -> DifferentiabilityParamsClause {
    self
  }
}

/// The differentiability parameters.
public struct DifferentiabilityParams: SyntaxBuildable {
  let leftParen: TokenSyntax
  let diffParams: DifferentiabilityParamList
  let rightParen: TokenSyntax

  /// Creates a `DifferentiabilityParams` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - diffParams: The parameters for differentiation.
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    diffParams: ExpressibleAsDifferentiabilityParamList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.diffParams = diffParams.createDifferentiabilityParamList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsDifferentiabilityParams: ExpressibleAsSyntaxBuildable {
  func createDifferentiabilityParams() -> DifferentiabilityParams
}

extension DifferentiabilityParams: ExpressibleAsDifferentiabilityParams {
  public func createDifferentiabilityParams() -> DifferentiabilityParams {
    self
  }
}

// MARK: - Syntax collection

/// `DifferentiabilityParamList` represents a collection of 
/// `DifferentiabilityParam`s.
public struct DifferentiabilityParamList: SyntaxBuildable {
  let elements: [DifferentiabilityParam]

  /// Creates a `DifferentiabilityParamList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsDifferentiabilityParam`
  public init(_ elements: [ExpressibleAsDifferentiabilityParam]) {
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

extension DifferentiabilityParamList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsDifferentiabilityParam...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsDifferentiabilityParamList: ExpressibleAsSyntaxBuildable {
  func createDifferentiabilityParamList() -> DifferentiabilityParamList
}

extension DifferentiabilityParamList: ExpressibleAsDifferentiabilityParamList {
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

  /// Creates a `DifferentiabilityParam` using the provided parameters.
  /// - Parameters:
  ///   - parameter: 
  ///   - trailingComma: 
  public init(
    parameter: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.parameter = parameter.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsDifferentiabilityParam: ExpressibleAsSyntaxBuildable, ExpressibleAsDifferentiabilityParamList {
  func createDifferentiabilityParam() -> DifferentiabilityParam
}

extension DifferentiabilityParam: ExpressibleAsDifferentiabilityParam {
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

  /// Creates a `DerivativeRegistrationAttributeArguments` using the provided parameters.
  /// - Parameters:
  ///   - ofLabel: The "of" label.
  ///   - colon: The colon separating the "of" label and the originaldeclaration name.
  ///   - originalDeclName: The referenced original declaration name.
  ///   - period: The period separating the original declaration name and theaccessor name.
  ///   - accessorKind: The accessor name.
  ///   - comma: 
  ///   - diffParams: 
  public init(
    ofLabel: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    originalDeclName: ExpressibleAsQualifiedDeclName,
    period: TokenSyntax? = nil,
    accessorKind: TokenSyntax? = nil,
    comma: TokenSyntax? = nil,
    diffParams: ExpressibleAsDifferentiabilityParamsClause? = nil
  ) {
    self.ofLabel = ofLabel
    assert(["of"].contains(self.ofLabel.text))
    self.colon = colon
    assert([":"].contains(self.colon.text))
    self.originalDeclName = originalDeclName.createQualifiedDeclName()
    self.period = period
    assert(period == nil || ["."].contains(self.period!.text))
    self.accessorKind = accessorKind
    assert(accessorKind == nil || ["get", "set"].contains(self.accessorKind!.text))
    self.comma = comma
    assert(comma == nil || [","].contains(self.comma!.text))
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

public protocol ExpressibleAsDerivativeRegistrationAttributeArguments: ExpressibleAsSyntaxBuildable {
  func createDerivativeRegistrationAttributeArguments() -> DerivativeRegistrationAttributeArguments
}

extension DerivativeRegistrationAttributeArguments: ExpressibleAsDerivativeRegistrationAttributeArguments {
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

  /// Creates a `QualifiedDeclName` using the provided parameters.
  /// - Parameters:
  ///   - baseType: The base type of the qualified name, optionally specified.
  ///   - dot: 
  ///   - name: The base name of the referenced function.
  ///   - arguments: The argument labels of the referenced function, optionallyspecified.
  public init(
    baseType: ExpressibleAsTypeBuildable? = nil,
    dot: TokenSyntax? = nil,
    name: TokenSyntax,
    arguments: ExpressibleAsDeclNameArguments? = nil
  ) {
    self.baseType = baseType?.createTypeBuildable()
    self.dot = dot
    assert(dot == nil || [".", "."].contains(self.dot!.text))
    self.name = name
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

public protocol ExpressibleAsQualifiedDeclName: ExpressibleAsSyntaxBuildable {
  func createQualifiedDeclName() -> QualifiedDeclName
}

extension QualifiedDeclName: ExpressibleAsQualifiedDeclName {
  public func createQualifiedDeclName() -> QualifiedDeclName {
    self
  }
}

/// A function declaration name (e.g. `foo(_:_:)`).
public struct FunctionDeclName: SyntaxBuildable {
  let name: SyntaxBuildable
  let arguments: DeclNameArguments?

  /// Creates a `FunctionDeclName` using the provided parameters.
  /// - Parameters:
  ///   - name: The base name of the referenced function.
  ///   - arguments: The argument labels of the referenced function, optionallyspecified.
  public init(
    name: ExpressibleAsSyntaxBuildable,
    arguments: ExpressibleAsDeclNameArguments? = nil
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

public protocol ExpressibleAsFunctionDeclName: ExpressibleAsSyntaxBuildable {
  func createFunctionDeclName() -> FunctionDeclName
}

extension FunctionDeclName: ExpressibleAsFunctionDeclName {
  public func createFunctionDeclName() -> FunctionDeclName {
    self
  }
}

public struct ContinueStmt: StmtBuildable {
  let continueKeyword: TokenSyntax
  let label: TokenSyntax?

  /// Creates a `ContinueStmt` using the provided parameters.
  /// - Parameters:
  ///   - continueKeyword: 
  ///   - label: 
  public init(
    continueKeyword: TokenSyntax = TokenSyntax.`continue`,
    label: TokenSyntax? = nil
  ) {
    self.continueKeyword = continueKeyword
    assert(["continue"].contains(self.continueKeyword.text))
    self.label = label
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

public protocol ExpressibleAsContinueStmt: ExpressibleAsStmtBuildable {
  func createContinueStmt() -> ContinueStmt
}

extension ContinueStmt: ExpressibleAsContinueStmt {
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

  /// Creates a `WhileStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - whileKeyword: 
  ///   - conditions: 
  ///   - body: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    conditions: ExpressibleAsConditionElementList,
    body: ExpressibleAsCodeBlock
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || [":"].contains(self.labelColon!.text))
    self.whileKeyword = whileKeyword
    assert(["while"].contains(self.whileKeyword.text))
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

public protocol ExpressibleAsWhileStmt: ExpressibleAsStmtBuildable {
  func createWhileStmt() -> WhileStmt
}

extension WhileStmt: ExpressibleAsWhileStmt {
  public func createWhileStmt() -> WhileStmt {
    self
  }
}

public struct DeferStmt: StmtBuildable {
  let deferKeyword: TokenSyntax
  let body: CodeBlock

  /// Creates a `DeferStmt` using the provided parameters.
  /// - Parameters:
  ///   - deferKeyword: 
  ///   - body: 
  public init(
    deferKeyword: TokenSyntax = TokenSyntax.`defer`,
    body: ExpressibleAsCodeBlock
  ) {
    self.deferKeyword = deferKeyword
    assert(["defer"].contains(self.deferKeyword.text))
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

public protocol ExpressibleAsDeferStmt: ExpressibleAsStmtBuildable {
  func createDeferStmt() -> DeferStmt
}

extension DeferStmt: ExpressibleAsDeferStmt {
  public func createDeferStmt() -> DeferStmt {
    self
  }
}

public struct ExpressionStmt: StmtBuildable {
  let expression: ExprBuildable

  /// Creates a `ExpressionStmt` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  public init(
    expression: ExpressibleAsExprBuildable
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

public protocol ExpressibleAsExpressionStmt: ExpressibleAsStmtBuildable {
  func createExpressionStmt() -> ExpressionStmt
}

extension ExpressionStmt: ExpressibleAsExpressionStmt {
  public func createExpressionStmt() -> ExpressionStmt {
    self
  }
}

// MARK: - Syntax collection

/// `SwitchCaseList` represents a collection of 
/// `SyntaxBuildable`s.
public struct SwitchCaseList: SyntaxBuildable {
  let elements: [SyntaxBuildable]

  /// Creates a `SwitchCaseList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsSyntaxBuildable`
  public init(_ elements: [ExpressibleAsSyntaxBuildable]) {
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

extension SwitchCaseList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsSyntaxBuildable...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsSwitchCaseList: ExpressibleAsSyntaxBuildable {
  func createSwitchCaseList() -> SwitchCaseList
}

extension SwitchCaseList: ExpressibleAsSwitchCaseList {
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

  /// Creates a `RepeatWhileStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - repeatKeyword: 
  ///   - body: 
  ///   - whileKeyword: 
  ///   - condition: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    repeatKeyword: TokenSyntax = TokenSyntax.`repeat`,
    body: ExpressibleAsCodeBlock,
    whileKeyword: TokenSyntax = TokenSyntax.`while`,
    condition: ExpressibleAsExprBuildable
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || [":"].contains(self.labelColon!.text))
    self.repeatKeyword = repeatKeyword
    assert(["repeat"].contains(self.repeatKeyword.text))
    self.body = body.createCodeBlock()
    self.whileKeyword = whileKeyword
    assert(["while"].contains(self.whileKeyword.text))
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

public protocol ExpressibleAsRepeatWhileStmt: ExpressibleAsStmtBuildable {
  func createRepeatWhileStmt() -> RepeatWhileStmt
}

extension RepeatWhileStmt: ExpressibleAsRepeatWhileStmt {
  public func createRepeatWhileStmt() -> RepeatWhileStmt {
    self
  }
}

public struct GuardStmt: StmtBuildable {
  let guardKeyword: TokenSyntax
  let conditions: ConditionElementList
  let elseKeyword: TokenSyntax
  let body: CodeBlock

  /// Creates a `GuardStmt` using the provided parameters.
  /// - Parameters:
  ///   - guardKeyword: 
  ///   - conditions: 
  ///   - elseKeyword: 
  ///   - body: 
  public init(
    guardKeyword: TokenSyntax = TokenSyntax.`guard`,
    conditions: ExpressibleAsConditionElementList,
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    body: ExpressibleAsCodeBlock
  ) {
    self.guardKeyword = guardKeyword
    assert(["guard"].contains(self.guardKeyword.text))
    self.conditions = conditions.createConditionElementList()
    self.elseKeyword = elseKeyword
    assert(["else"].contains(self.elseKeyword.text))
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

public protocol ExpressibleAsGuardStmt: ExpressibleAsStmtBuildable {
  func createGuardStmt() -> GuardStmt
}

extension GuardStmt: ExpressibleAsGuardStmt {
  public func createGuardStmt() -> GuardStmt {
    self
  }
}

public struct WhereClause: SyntaxBuildable {
  let whereKeyword: TokenSyntax
  let guardResult: ExprBuildable

  /// Creates a `WhereClause` using the provided parameters.
  /// - Parameters:
  ///   - whereKeyword: 
  ///   - guardResult: 
  public init(
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    guardResult: ExpressibleAsExprBuildable
  ) {
    self.whereKeyword = whereKeyword
    assert(["where"].contains(self.whereKeyword.text))
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

public protocol ExpressibleAsWhereClause: ExpressibleAsSyntaxBuildable {
  func createWhereClause() -> WhereClause
}

extension WhereClause: ExpressibleAsWhereClause {
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

  /// Creates a `ForInStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - forKeyword: 
  ///   - tryKeyword: 
  ///   - awaitKeyword: 
  ///   - caseKeyword: 
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - inKeyword: 
  ///   - sequenceExpr: 
  ///   - whereClause: 
  ///   - body: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    forKeyword: TokenSyntax = TokenSyntax.`for`,
    tryKeyword: TokenSyntax? = nil,
    awaitKeyword: TokenSyntax? = nil,
    caseKeyword: TokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    inKeyword: TokenSyntax = TokenSyntax.`in`,
    sequenceExpr: ExpressibleAsExprBuildable,
    whereClause: ExpressibleAsWhereClause? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || [":"].contains(self.labelColon!.text))
    self.forKeyword = forKeyword
    assert(["for"].contains(self.forKeyword.text))
    self.tryKeyword = tryKeyword
    assert(tryKeyword == nil || ["try"].contains(self.tryKeyword!.text))
    self.awaitKeyword = awaitKeyword
    assert(awaitKeyword == nil || ["await"].contains(self.awaitKeyword!.text))
    self.caseKeyword = caseKeyword
    assert(caseKeyword == nil || ["case"].contains(self.caseKeyword!.text))
    self.pattern = pattern.createPatternBuildable()
    self.typeAnnotation = typeAnnotation?.createTypeAnnotation()
    self.inKeyword = inKeyword
    assert(["in"].contains(self.inKeyword.text))
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

public protocol ExpressibleAsForInStmt: ExpressibleAsStmtBuildable {
  func createForInStmt() -> ForInStmt
}

extension ForInStmt: ExpressibleAsForInStmt {
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

  /// Creates a `SwitchStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - switchKeyword: 
  ///   - expression: 
  ///   - leftBrace: 
  ///   - cases: 
  ///   - rightBrace: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    switchKeyword: TokenSyntax = TokenSyntax.`switch`,
    expression: ExpressibleAsExprBuildable,
    leftBrace: TokenSyntax = TokenSyntax.`leftBrace`,
    cases: ExpressibleAsSwitchCaseList,
    rightBrace: TokenSyntax = TokenSyntax.`rightBrace`
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || [":"].contains(self.labelColon!.text))
    self.switchKeyword = switchKeyword
    assert(["switch"].contains(self.switchKeyword.text))
    self.expression = expression.createExprBuildable()
    self.leftBrace = leftBrace
    assert(["{"].contains(self.leftBrace.text))
    self.cases = cases.createSwitchCaseList()
    self.rightBrace = rightBrace
    assert(["}"].contains(self.rightBrace.text))
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

public protocol ExpressibleAsSwitchStmt: ExpressibleAsStmtBuildable {
  func createSwitchStmt() -> SwitchStmt
}

extension SwitchStmt: ExpressibleAsSwitchStmt {
  public func createSwitchStmt() -> SwitchStmt {
    self
  }
}

// MARK: - Syntax collection

/// `CatchClauseList` represents a collection of 
/// `CatchClause`s.
public struct CatchClauseList: SyntaxBuildable {
  let elements: [CatchClause]

  /// Creates a `CatchClauseList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCatchClause`
  public init(_ elements: [ExpressibleAsCatchClause]) {
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

extension CatchClauseList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsCatchClause...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsCatchClauseList: ExpressibleAsSyntaxBuildable {
  func createCatchClauseList() -> CatchClauseList
}

extension CatchClauseList: ExpressibleAsCatchClauseList {
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

  /// Creates a `DoStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - doKeyword: 
  ///   - body: 
  ///   - catchClauses: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    doKeyword: TokenSyntax = TokenSyntax.`do`,
    body: ExpressibleAsCodeBlock,
    catchClauses: ExpressibleAsCatchClauseList? = nil
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || [":"].contains(self.labelColon!.text))
    self.doKeyword = doKeyword
    assert(["do"].contains(self.doKeyword.text))
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

public protocol ExpressibleAsDoStmt: ExpressibleAsStmtBuildable {
  func createDoStmt() -> DoStmt
}

extension DoStmt: ExpressibleAsDoStmt {
  public func createDoStmt() -> DoStmt {
    self
  }
}

public struct ReturnStmt: StmtBuildable {
  let returnKeyword: TokenSyntax
  let expression: ExprBuildable?

  /// Creates a `ReturnStmt` using the provided parameters.
  /// - Parameters:
  ///   - returnKeyword: 
  ///   - expression: 
  public init(
    returnKeyword: TokenSyntax = TokenSyntax.`return`,
    expression: ExpressibleAsExprBuildable? = nil
  ) {
    self.returnKeyword = returnKeyword
    assert(["return"].contains(self.returnKeyword.text))
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

public protocol ExpressibleAsReturnStmt: ExpressibleAsStmtBuildable {
  func createReturnStmt() -> ReturnStmt
}

extension ReturnStmt: ExpressibleAsReturnStmt {
  public func createReturnStmt() -> ReturnStmt {
    self
  }
}

public struct YieldStmt: StmtBuildable {
  let yieldKeyword: TokenSyntax
  let yields: SyntaxBuildable

  /// Creates a `YieldStmt` using the provided parameters.
  /// - Parameters:
  ///   - yieldKeyword: 
  ///   - yields: 
  public init(
    yieldKeyword: TokenSyntax = TokenSyntax.`yield`,
    yields: ExpressibleAsSyntaxBuildable
  ) {
    self.yieldKeyword = yieldKeyword
    assert(["yield"].contains(self.yieldKeyword.text))
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

public protocol ExpressibleAsYieldStmt: ExpressibleAsStmtBuildable {
  func createYieldStmt() -> YieldStmt
}

extension YieldStmt: ExpressibleAsYieldStmt {
  public func createYieldStmt() -> YieldStmt {
    self
  }
}

public struct YieldList: SyntaxBuildable {
  let leftParen: TokenSyntax
  let elementList: ExprList
  let trailingComma: TokenSyntax?
  let rightParen: TokenSyntax

  /// Creates a `YieldList` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elementList: 
  ///   - trailingComma: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elementList: ExpressibleAsExprList,
    trailingComma: TokenSyntax? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.elementList = elementList.createExprList()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsYieldList: ExpressibleAsSyntaxBuildable {
  func createYieldList() -> YieldList
}

extension YieldList: ExpressibleAsYieldList {
  public func createYieldList() -> YieldList {
    self
  }
}

public struct FallthroughStmt: StmtBuildable {
  let fallthroughKeyword: TokenSyntax

  /// Creates a `FallthroughStmt` using the provided parameters.
  /// - Parameters:
  ///   - fallthroughKeyword: 
  public init(
    fallthroughKeyword: TokenSyntax = TokenSyntax.`fallthrough`
  ) {
    self.fallthroughKeyword = fallthroughKeyword
    assert(["fallthrough"].contains(self.fallthroughKeyword.text))
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

public protocol ExpressibleAsFallthroughStmt: ExpressibleAsStmtBuildable {
  func createFallthroughStmt() -> FallthroughStmt
}

extension FallthroughStmt: ExpressibleAsFallthroughStmt {
  public func createFallthroughStmt() -> FallthroughStmt {
    self
  }
}

public struct BreakStmt: StmtBuildable {
  let breakKeyword: TokenSyntax
  let label: TokenSyntax?

  /// Creates a `BreakStmt` using the provided parameters.
  /// - Parameters:
  ///   - breakKeyword: 
  ///   - label: 
  public init(
    breakKeyword: TokenSyntax = TokenSyntax.`break`,
    label: TokenSyntax? = nil
  ) {
    self.breakKeyword = breakKeyword
    assert(["break"].contains(self.breakKeyword.text))
    self.label = label
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

public protocol ExpressibleAsBreakStmt: ExpressibleAsStmtBuildable {
  func createBreakStmt() -> BreakStmt
}

extension BreakStmt: ExpressibleAsBreakStmt {
  public func createBreakStmt() -> BreakStmt {
    self
  }
}

// MARK: - Syntax collection

/// `CaseItemList` represents a collection of 
/// `CaseItem`s.
public struct CaseItemList: SyntaxBuildable {
  let elements: [CaseItem]

  /// Creates a `CaseItemList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCaseItem`
  public init(_ elements: [ExpressibleAsCaseItem]) {
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

extension CaseItemList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsCaseItem...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsCaseItemList: ExpressibleAsSyntaxBuildable {
  func createCaseItemList() -> CaseItemList
}

extension CaseItemList: ExpressibleAsCaseItemList {
  public func createCaseItemList() -> CaseItemList {
    self
  }
}

// MARK: - Syntax collection

/// `CatchItemList` represents a collection of 
/// `CatchItem`s.
public struct CatchItemList: SyntaxBuildable {
  let elements: [CatchItem]

  /// Creates a `CatchItemList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCatchItem`
  public init(_ elements: [ExpressibleAsCatchItem]) {
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

extension CatchItemList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsCatchItem...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsCatchItemList: ExpressibleAsSyntaxBuildable {
  func createCatchItemList() -> CatchItemList
}

extension CatchItemList: ExpressibleAsCatchItemList {
  public func createCatchItemList() -> CatchItemList {
    self
  }
}

public struct ConditionElement: SyntaxBuildable {
  let condition: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `ConditionElement` using the provided parameters.
  /// - Parameters:
  ///   - condition: 
  ///   - trailingComma: 
  public init(
    condition: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.condition = condition.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsConditionElement: ExpressibleAsSyntaxBuildable, ExpressibleAsConditionElementList {
  func createConditionElement() -> ConditionElement
}

extension ConditionElement: ExpressibleAsConditionElement {
  public func createConditionElement() -> ConditionElement {
    self
  }
}

public struct AvailabilityCondition: SyntaxBuildable {
  let poundAvailableKeyword: TokenSyntax
  let leftParen: TokenSyntax
  let availabilitySpec: AvailabilitySpecList
  let rightParen: TokenSyntax

  /// Creates a `AvailabilityCondition` using the provided parameters.
  /// - Parameters:
  ///   - poundAvailableKeyword: 
  ///   - leftParen: 
  ///   - availabilitySpec: 
  ///   - rightParen: 
  public init(
    poundAvailableKeyword: TokenSyntax = TokenSyntax.`poundAvailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    availabilitySpec: ExpressibleAsAvailabilitySpecList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundAvailableKeyword = poundAvailableKeyword
    assert(["#available"].contains(self.poundAvailableKeyword.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsAvailabilityCondition: ExpressibleAsSyntaxBuildable {
  func createAvailabilityCondition() -> AvailabilityCondition
}

extension AvailabilityCondition: ExpressibleAsAvailabilityCondition {
  public func createAvailabilityCondition() -> AvailabilityCondition {
    self
  }
}

public struct MatchingPatternCondition: SyntaxBuildable {
  let caseKeyword: TokenSyntax
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause

  /// Creates a `MatchingPatternCondition` using the provided parameters.
  /// - Parameters:
  ///   - caseKeyword: 
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  public init(
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause
  ) {
    self.caseKeyword = caseKeyword
    assert(["case"].contains(self.caseKeyword.text))
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

public protocol ExpressibleAsMatchingPatternCondition: ExpressibleAsSyntaxBuildable {
  func createMatchingPatternCondition() -> MatchingPatternCondition
}

extension MatchingPatternCondition: ExpressibleAsMatchingPatternCondition {
  public func createMatchingPatternCondition() -> MatchingPatternCondition {
    self
  }
}

public struct OptionalBindingCondition: SyntaxBuildable {
  let letOrVarKeyword: TokenSyntax
  let pattern: PatternBuildable
  let typeAnnotation: TypeAnnotation?
  let initializer: InitializerClause

  /// Creates a `OptionalBindingCondition` using the provided parameters.
  /// - Parameters:
  ///   - letOrVarKeyword: 
  ///   - pattern: 
  ///   - typeAnnotation: 
  ///   - initializer: 
  public init(
    letOrVarKeyword: TokenSyntax,
    pattern: ExpressibleAsPatternBuildable,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil,
    initializer: ExpressibleAsInitializerClause
  ) {
    self.letOrVarKeyword = letOrVarKeyword
    assert(["let", "var"].contains(self.letOrVarKeyword.text))
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

public protocol ExpressibleAsOptionalBindingCondition: ExpressibleAsSyntaxBuildable {
  func createOptionalBindingCondition() -> OptionalBindingCondition
}

extension OptionalBindingCondition: ExpressibleAsOptionalBindingCondition {
  public func createOptionalBindingCondition() -> OptionalBindingCondition {
    self
  }
}

public struct UnavailabilityCondition: SyntaxBuildable {
  let poundUnavailableKeyword: TokenSyntax
  let leftParen: TokenSyntax
  let availabilitySpec: AvailabilitySpecList
  let rightParen: TokenSyntax

  /// Creates a `UnavailabilityCondition` using the provided parameters.
  /// - Parameters:
  ///   - poundUnavailableKeyword: 
  ///   - leftParen: 
  ///   - availabilitySpec: 
  ///   - rightParen: 
  public init(
    poundUnavailableKeyword: TokenSyntax = TokenSyntax.`poundUnavailable`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    availabilitySpec: ExpressibleAsAvailabilitySpecList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundUnavailableKeyword = poundUnavailableKeyword
    assert(["#unavailable"].contains(self.poundUnavailableKeyword.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.availabilitySpec = availabilitySpec.createAvailabilitySpecList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsUnavailabilityCondition: ExpressibleAsSyntaxBuildable {
  func createUnavailabilityCondition() -> UnavailabilityCondition
}

extension UnavailabilityCondition: ExpressibleAsUnavailabilityCondition {
  public func createUnavailabilityCondition() -> UnavailabilityCondition {
    self
  }
}

// MARK: - Syntax collection

/// `ConditionElementList` represents a collection of 
/// `ConditionElement`s.
public struct ConditionElementList: SyntaxBuildable {
  let elements: [ConditionElement]

  /// Creates a `ConditionElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsConditionElement`
  public init(_ elements: [ExpressibleAsConditionElement]) {
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

extension ConditionElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsConditionElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsConditionElementList: ExpressibleAsSyntaxBuildable {
  func createConditionElementList() -> ConditionElementList
}

extension ConditionElementList: ExpressibleAsConditionElementList {
  public func createConditionElementList() -> ConditionElementList {
    self
  }
}

public struct DeclarationStmt: StmtBuildable {
  let declaration: DeclBuildable

  /// Creates a `DeclarationStmt` using the provided parameters.
  /// - Parameters:
  ///   - declaration: 
  public init(
    declaration: ExpressibleAsDeclBuildable
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

public protocol ExpressibleAsDeclarationStmt: ExpressibleAsStmtBuildable {
  func createDeclarationStmt() -> DeclarationStmt
}

extension DeclarationStmt: ExpressibleAsDeclarationStmt {
  public func createDeclarationStmt() -> DeclarationStmt {
    self
  }
}

public struct ThrowStmt: StmtBuildable {
  let throwKeyword: TokenSyntax
  let expression: ExprBuildable

  /// Creates a `ThrowStmt` using the provided parameters.
  /// - Parameters:
  ///   - throwKeyword: 
  ///   - expression: 
  public init(
    throwKeyword: TokenSyntax = TokenSyntax.`throw`,
    expression: ExpressibleAsExprBuildable
  ) {
    self.throwKeyword = throwKeyword
    assert(["throw"].contains(self.throwKeyword.text))
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

public protocol ExpressibleAsThrowStmt: ExpressibleAsStmtBuildable {
  func createThrowStmt() -> ThrowStmt
}

extension ThrowStmt: ExpressibleAsThrowStmt {
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

  /// Creates a `IfStmt` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - ifKeyword: 
  ///   - conditions: 
  ///   - body: 
  ///   - elseKeyword: 
  ///   - elseBody: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    ifKeyword: TokenSyntax = TokenSyntax.`if`,
    conditions: ExpressibleAsConditionElementList,
    body: ExpressibleAsCodeBlock,
    elseKeyword: TokenSyntax? = nil,
    elseBody: ExpressibleAsSyntaxBuildable? = nil
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || [":"].contains(self.labelColon!.text))
    self.ifKeyword = ifKeyword
    assert(["if"].contains(self.ifKeyword.text))
    self.conditions = conditions.createConditionElementList()
    self.body = body.createCodeBlock()
    self.elseKeyword = elseKeyword
    assert(elseKeyword == nil || ["else"].contains(self.elseKeyword!.text))
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

public protocol ExpressibleAsIfStmt: ExpressibleAsStmtBuildable {
  func createIfStmt() -> IfStmt
}

extension IfStmt: ExpressibleAsIfStmt {
  public func createIfStmt() -> IfStmt {
    self
  }
}

public struct ElseIfContinuation: SyntaxBuildable {
  let ifStatement: IfStmt

  /// Creates a `ElseIfContinuation` using the provided parameters.
  /// - Parameters:
  ///   - ifStatement: 
  public init(
    ifStatement: ExpressibleAsIfStmt
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

public protocol ExpressibleAsElseIfContinuation: ExpressibleAsSyntaxBuildable {
  func createElseIfContinuation() -> ElseIfContinuation
}

extension ElseIfContinuation: ExpressibleAsElseIfContinuation {
  public func createElseIfContinuation() -> ElseIfContinuation {
    self
  }
}

public struct ElseBlock: SyntaxBuildable {
  let elseKeyword: TokenSyntax
  let body: CodeBlock

  /// Creates a `ElseBlock` using the provided parameters.
  /// - Parameters:
  ///   - elseKeyword: 
  ///   - body: 
  public init(
    elseKeyword: TokenSyntax = TokenSyntax.`else`,
    body: ExpressibleAsCodeBlock
  ) {
    self.elseKeyword = elseKeyword
    assert(["else"].contains(self.elseKeyword.text))
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

public protocol ExpressibleAsElseBlock: ExpressibleAsSyntaxBuildable {
  func createElseBlock() -> ElseBlock
}

extension ElseBlock: ExpressibleAsElseBlock {
  public func createElseBlock() -> ElseBlock {
    self
  }
}

public struct SwitchCase: SyntaxBuildable {
  let unknownAttr: Attribute?
  let label: SyntaxBuildable
  let statements: CodeBlockItemList

  /// Creates a `SwitchCase` using the provided parameters.
  /// - Parameters:
  ///   - unknownAttr: 
  ///   - label: 
  ///   - statements: 
  public init(
    unknownAttr: ExpressibleAsAttribute? = nil,
    label: ExpressibleAsSyntaxBuildable,
    statements: ExpressibleAsCodeBlockItemList
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

public protocol ExpressibleAsSwitchCase: ExpressibleAsSyntaxBuildable {
  func createSwitchCase() -> SwitchCase
}

extension SwitchCase: ExpressibleAsSwitchCase {
  public func createSwitchCase() -> SwitchCase {
    self
  }
}

public struct SwitchDefaultLabel: SyntaxBuildable {
  let defaultKeyword: TokenSyntax
  let colon: TokenSyntax

  /// Creates a `SwitchDefaultLabel` using the provided parameters.
  /// - Parameters:
  ///   - defaultKeyword: 
  ///   - colon: 
  public init(
    defaultKeyword: TokenSyntax = TokenSyntax.`default`,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.defaultKeyword = defaultKeyword
    assert(["default"].contains(self.defaultKeyword.text))
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsSwitchDefaultLabel: ExpressibleAsSyntaxBuildable {
  func createSwitchDefaultLabel() -> SwitchDefaultLabel
}

extension SwitchDefaultLabel: ExpressibleAsSwitchDefaultLabel {
  public func createSwitchDefaultLabel() -> SwitchDefaultLabel {
    self
  }
}

public struct CaseItem: SyntaxBuildable {
  let pattern: PatternBuildable
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  /// Creates a `CaseItem` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - whereClause: 
  ///   - trailingComma: 
  public init(
    pattern: ExpressibleAsPatternBuildable,
    whereClause: ExpressibleAsWhereClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsCaseItem: ExpressibleAsSyntaxBuildable, ExpressibleAsCaseItemList {
  func createCaseItem() -> CaseItem
}

extension CaseItem: ExpressibleAsCaseItem {
  public func createCaseItem() -> CaseItem {
    self
  }
}

public struct CatchItem: SyntaxBuildable {
  let pattern: PatternBuildable?
  let whereClause: WhereClause?
  let trailingComma: TokenSyntax?

  /// Creates a `CatchItem` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - whereClause: 
  ///   - trailingComma: 
  public init(
    pattern: ExpressibleAsPatternBuildable? = nil,
    whereClause: ExpressibleAsWhereClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.pattern = pattern?.createPatternBuildable()
    self.whereClause = whereClause?.createWhereClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsCatchItem: ExpressibleAsSyntaxBuildable, ExpressibleAsCatchItemList {
  func createCatchItem() -> CatchItem
}

extension CatchItem: ExpressibleAsCatchItem {
  public func createCatchItem() -> CatchItem {
    self
  }
}

public struct SwitchCaseLabel: SyntaxBuildable {
  let caseKeyword: TokenSyntax
  let caseItems: CaseItemList
  let colon: TokenSyntax

  /// Creates a `SwitchCaseLabel` using the provided parameters.
  /// - Parameters:
  ///   - caseKeyword: 
  ///   - caseItems: 
  ///   - colon: 
  public init(
    caseKeyword: TokenSyntax = TokenSyntax.`case`,
    caseItems: ExpressibleAsCaseItemList,
    colon: TokenSyntax = TokenSyntax.`colon`
  ) {
    self.caseKeyword = caseKeyword
    assert(["case"].contains(self.caseKeyword.text))
    self.caseItems = caseItems.createCaseItemList()
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsSwitchCaseLabel: ExpressibleAsSyntaxBuildable {
  func createSwitchCaseLabel() -> SwitchCaseLabel
}

extension SwitchCaseLabel: ExpressibleAsSwitchCaseLabel {
  public func createSwitchCaseLabel() -> SwitchCaseLabel {
    self
  }
}

public struct CatchClause: SyntaxBuildable {
  let catchKeyword: TokenSyntax
  let catchItems: CatchItemList?
  let body: CodeBlock

  /// Creates a `CatchClause` using the provided parameters.
  /// - Parameters:
  ///   - catchKeyword: 
  ///   - catchItems: 
  ///   - body: 
  public init(
    catchKeyword: TokenSyntax = TokenSyntax.`catch`,
    catchItems: ExpressibleAsCatchItemList? = nil,
    body: ExpressibleAsCodeBlock
  ) {
    self.catchKeyword = catchKeyword
    assert(["catch"].contains(self.catchKeyword.text))
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

public protocol ExpressibleAsCatchClause: ExpressibleAsSyntaxBuildable, ExpressibleAsCatchClauseList {
  func createCatchClause() -> CatchClause
}

extension CatchClause: ExpressibleAsCatchClause {
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

  /// Creates a `PoundAssertStmt` using the provided parameters.
  /// - Parameters:
  ///   - poundAssert: 
  ///   - leftParen: 
  ///   - condition: The assertion condition.
  ///   - comma: The comma after the assertion condition.
  ///   - message: The assertion message.
  ///   - rightParen: 
  public init(
    poundAssert: TokenSyntax = TokenSyntax.`poundAssert`,
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    condition: ExpressibleAsExprBuildable,
    comma: TokenSyntax? = nil,
    message: TokenSyntax? = nil,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.poundAssert = poundAssert
    assert(["#assert"].contains(self.poundAssert.text))
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.condition = condition.createExprBuildable()
    self.comma = comma
    assert(comma == nil || [","].contains(self.comma!.text))
    self.message = message
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsPoundAssertStmt: ExpressibleAsStmtBuildable {
  func createPoundAssertStmt() -> PoundAssertStmt
}

extension PoundAssertStmt: ExpressibleAsPoundAssertStmt {
  public func createPoundAssertStmt() -> PoundAssertStmt {
    self
  }
}

public struct GenericWhereClause: SyntaxBuildable {
  let whereKeyword: TokenSyntax
  let requirementList: GenericRequirementList

  /// Creates a `GenericWhereClause` using the provided parameters.
  /// - Parameters:
  ///   - whereKeyword: 
  ///   - requirementList: 
  public init(
    whereKeyword: TokenSyntax = TokenSyntax.`where`,
    requirementList: ExpressibleAsGenericRequirementList
  ) {
    self.whereKeyword = whereKeyword
    assert(["where"].contains(self.whereKeyword.text))
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

public protocol ExpressibleAsGenericWhereClause: ExpressibleAsSyntaxBuildable {
  func createGenericWhereClause() -> GenericWhereClause
}

extension GenericWhereClause: ExpressibleAsGenericWhereClause {
  public func createGenericWhereClause() -> GenericWhereClause {
    self
  }
}

// MARK: - Syntax collection

/// `GenericRequirementList` represents a collection of 
/// `GenericRequirement`s.
public struct GenericRequirementList: SyntaxBuildable {
  let elements: [GenericRequirement]

  /// Creates a `GenericRequirementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsGenericRequirement`
  public init(_ elements: [ExpressibleAsGenericRequirement]) {
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

extension GenericRequirementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsGenericRequirement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsGenericRequirementList: ExpressibleAsSyntaxBuildable {
  func createGenericRequirementList() -> GenericRequirementList
}

extension GenericRequirementList: ExpressibleAsGenericRequirementList {
  public func createGenericRequirementList() -> GenericRequirementList {
    self
  }
}

public struct GenericRequirement: SyntaxBuildable {
  let body: SyntaxBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `GenericRequirement` using the provided parameters.
  /// - Parameters:
  ///   - body: 
  ///   - trailingComma: 
  public init(
    body: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.body = body.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsGenericRequirement: ExpressibleAsSyntaxBuildable, ExpressibleAsGenericRequirementList {
  func createGenericRequirement() -> GenericRequirement
}

extension GenericRequirement: ExpressibleAsGenericRequirement {
  public func createGenericRequirement() -> GenericRequirement {
    self
  }
}

public struct SameTypeRequirement: SyntaxBuildable {
  let leftTypeIdentifier: TypeBuildable
  let equalityToken: TokenSyntax
  let rightTypeIdentifier: TypeBuildable

  /// Creates a `SameTypeRequirement` using the provided parameters.
  /// - Parameters:
  ///   - leftTypeIdentifier: 
  ///   - equalityToken: 
  ///   - rightTypeIdentifier: 
  public init(
    leftTypeIdentifier: ExpressibleAsTypeBuildable,
    equalityToken: TokenSyntax,
    rightTypeIdentifier: ExpressibleAsTypeBuildable
  ) {
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.equalityToken = equalityToken
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

public protocol ExpressibleAsSameTypeRequirement: ExpressibleAsSyntaxBuildable {
  func createSameTypeRequirement() -> SameTypeRequirement
}

extension SameTypeRequirement: ExpressibleAsSameTypeRequirement {
  public func createSameTypeRequirement() -> SameTypeRequirement {
    self
  }
}

// MARK: - Syntax collection

/// `GenericParameterList` represents a collection of 
/// `GenericParameter`s.
public struct GenericParameterList: SyntaxBuildable {
  let elements: [GenericParameter]

  /// Creates a `GenericParameterList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsGenericParameter`
  public init(_ elements: [ExpressibleAsGenericParameter]) {
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

extension GenericParameterList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsGenericParameter...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsGenericParameterList: ExpressibleAsSyntaxBuildable {
  func createGenericParameterList() -> GenericParameterList
}

extension GenericParameterList: ExpressibleAsGenericParameterList {
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

  /// Creates a `GenericParameter` using the provided parameters.
  /// - Parameters:
  ///   - attributes: 
  ///   - name: 
  ///   - colon: 
  ///   - inheritedType: 
  ///   - trailingComma: 
  public init(
    attributes: ExpressibleAsAttributeList? = nil,
    name: TokenSyntax,
    colon: TokenSyntax? = nil,
    inheritedType: ExpressibleAsTypeBuildable? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.attributes = attributes?.createAttributeList()
    self.name = name
    self.colon = colon
    assert(colon == nil || [":"].contains(self.colon!.text))
    self.inheritedType = inheritedType?.createTypeBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsGenericParameter: ExpressibleAsSyntaxBuildable, ExpressibleAsGenericParameterList {
  func createGenericParameter() -> GenericParameter
}

extension GenericParameter: ExpressibleAsGenericParameter {
  public func createGenericParameter() -> GenericParameter {
    self
  }
}

public struct GenericParameterClause: SyntaxBuildable {
  let leftAngleBracket: TokenSyntax
  let genericParameterList: GenericParameterList
  let rightAngleBracket: TokenSyntax

  /// Creates a `GenericParameterClause` using the provided parameters.
  /// - Parameters:
  ///   - leftAngleBracket: 
  ///   - genericParameterList: 
  ///   - rightAngleBracket: 
  public init(
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    genericParameterList: ExpressibleAsGenericParameterList,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leftAngleBracket = leftAngleBracket
    assert(["<"].contains(self.leftAngleBracket.text))
    self.genericParameterList = genericParameterList.createGenericParameterList()
    self.rightAngleBracket = rightAngleBracket
    assert([">"].contains(self.rightAngleBracket.text))
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

public protocol ExpressibleAsGenericParameterClause: ExpressibleAsSyntaxBuildable {
  func createGenericParameterClause() -> GenericParameterClause
}

extension GenericParameterClause: ExpressibleAsGenericParameterClause {
  public func createGenericParameterClause() -> GenericParameterClause {
    self
  }
}

public struct ConformanceRequirement: SyntaxBuildable {
  let leftTypeIdentifier: TypeBuildable
  let colon: TokenSyntax
  let rightTypeIdentifier: TypeBuildable

  /// Creates a `ConformanceRequirement` using the provided parameters.
  /// - Parameters:
  ///   - leftTypeIdentifier: 
  ///   - colon: 
  ///   - rightTypeIdentifier: 
  public init(
    leftTypeIdentifier: ExpressibleAsTypeBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    rightTypeIdentifier: ExpressibleAsTypeBuildable
  ) {
    self.leftTypeIdentifier = leftTypeIdentifier.createTypeBuildable()
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsConformanceRequirement: ExpressibleAsSyntaxBuildable {
  func createConformanceRequirement() -> ConformanceRequirement
}

extension ConformanceRequirement: ExpressibleAsConformanceRequirement {
  public func createConformanceRequirement() -> ConformanceRequirement {
    self
  }
}

public struct SimpleTypeIdentifier: TypeBuildable {
  let name: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  /// Creates a `SimpleTypeIdentifier` using the provided parameters.
  /// - Parameters:
  ///   - name: 
  ///   - genericArgumentClause: 
  public init(
    name: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.name = name
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

public protocol ExpressibleAsSimpleTypeIdentifier: ExpressibleAsTypeBuildable, ExpressibleAsTypeAnnotation, ExpressibleAsTypeExpr {
  func createSimpleTypeIdentifier() -> SimpleTypeIdentifier
}

extension SimpleTypeIdentifier: ExpressibleAsSimpleTypeIdentifier {
  public func createSimpleTypeIdentifier() -> SimpleTypeIdentifier {
    self
  }
}

public struct MemberTypeIdentifier: TypeBuildable {
  let baseType: TypeBuildable
  let period: TokenSyntax
  let name: TokenSyntax
  let genericArgumentClause: GenericArgumentClause?

  /// Creates a `MemberTypeIdentifier` using the provided parameters.
  /// - Parameters:
  ///   - baseType: 
  ///   - period: 
  ///   - name: 
  ///   - genericArgumentClause: 
  public init(
    baseType: ExpressibleAsTypeBuildable,
    period: TokenSyntax,
    name: TokenSyntax,
    genericArgumentClause: ExpressibleAsGenericArgumentClause? = nil
  ) {
    self.baseType = baseType.createTypeBuildable()
    self.period = period
    assert([".", "."].contains(self.period.text))
    self.name = name
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

public protocol ExpressibleAsMemberTypeIdentifier: ExpressibleAsTypeBuildable {
  func createMemberTypeIdentifier() -> MemberTypeIdentifier
}

extension MemberTypeIdentifier: ExpressibleAsMemberTypeIdentifier {
  public func createMemberTypeIdentifier() -> MemberTypeIdentifier {
    self
  }
}

public struct ClassRestrictionType: TypeBuildable {
  let classKeyword: TokenSyntax

  /// Creates a `ClassRestrictionType` using the provided parameters.
  /// - Parameters:
  ///   - classKeyword: 
  public init(
    classKeyword: TokenSyntax = TokenSyntax.`class`
  ) {
    self.classKeyword = classKeyword
    assert(["class"].contains(self.classKeyword.text))
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

public protocol ExpressibleAsClassRestrictionType: ExpressibleAsTypeBuildable {
  func createClassRestrictionType() -> ClassRestrictionType
}

extension ClassRestrictionType: ExpressibleAsClassRestrictionType {
  public func createClassRestrictionType() -> ClassRestrictionType {
    self
  }
}

public struct ArrayType: TypeBuildable {
  let leftSquareBracket: TokenSyntax
  let elementType: TypeBuildable
  let rightSquareBracket: TokenSyntax

  /// Creates a `ArrayType` using the provided parameters.
  /// - Parameters:
  ///   - leftSquareBracket: 
  ///   - elementType: 
  ///   - rightSquareBracket: 
  public init(
    leftSquareBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    elementType: ExpressibleAsTypeBuildable,
    rightSquareBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquareBracket = leftSquareBracket
    assert(["["].contains(self.leftSquareBracket.text))
    self.elementType = elementType.createTypeBuildable()
    self.rightSquareBracket = rightSquareBracket
    assert(["]"].contains(self.rightSquareBracket.text))
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

public protocol ExpressibleAsArrayType: ExpressibleAsTypeBuildable {
  func createArrayType() -> ArrayType
}

extension ArrayType: ExpressibleAsArrayType {
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

  /// Creates a `DictionaryType` using the provided parameters.
  /// - Parameters:
  ///   - leftSquareBracket: 
  ///   - keyType: 
  ///   - colon: 
  ///   - valueType: 
  ///   - rightSquareBracket: 
  public init(
    leftSquareBracket: TokenSyntax = TokenSyntax.`leftSquareBracket`,
    keyType: ExpressibleAsTypeBuildable,
    colon: TokenSyntax = TokenSyntax.`colon`,
    valueType: ExpressibleAsTypeBuildable,
    rightSquareBracket: TokenSyntax = TokenSyntax.`rightSquareBracket`
  ) {
    self.leftSquareBracket = leftSquareBracket
    assert(["["].contains(self.leftSquareBracket.text))
    self.keyType = keyType.createTypeBuildable()
    self.colon = colon
    assert([":"].contains(self.colon.text))
    self.valueType = valueType.createTypeBuildable()
    self.rightSquareBracket = rightSquareBracket
    assert(["]"].contains(self.rightSquareBracket.text))
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

public protocol ExpressibleAsDictionaryType: ExpressibleAsTypeBuildable {
  func createDictionaryType() -> DictionaryType
}

extension DictionaryType: ExpressibleAsDictionaryType {
  public func createDictionaryType() -> DictionaryType {
    self
  }
}

public struct MetatypeType: TypeBuildable {
  let baseType: TypeBuildable
  let period: TokenSyntax
  let typeOrProtocol: TokenSyntax

  /// Creates a `MetatypeType` using the provided parameters.
  /// - Parameters:
  ///   - baseType: 
  ///   - period: 
  ///   - typeOrProtocol: 
  public init(
    baseType: ExpressibleAsTypeBuildable,
    period: TokenSyntax = TokenSyntax.`period`,
    typeOrProtocol: TokenSyntax
  ) {
    self.baseType = baseType.createTypeBuildable()
    self.period = period
    assert(["."].contains(self.period.text))
    self.typeOrProtocol = typeOrProtocol
    assert(["Type", "Protocol"].contains(self.typeOrProtocol.text))
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

public protocol ExpressibleAsMetatypeType: ExpressibleAsTypeBuildable {
  func createMetatypeType() -> MetatypeType
}

extension MetatypeType: ExpressibleAsMetatypeType {
  public func createMetatypeType() -> MetatypeType {
    self
  }
}

public struct OptionalType: TypeBuildable {
  let wrappedType: TypeBuildable
  let questionMark: TokenSyntax

  /// Creates a `OptionalType` using the provided parameters.
  /// - Parameters:
  ///   - wrappedType: 
  ///   - questionMark: 
  public init(
    wrappedType: ExpressibleAsTypeBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.wrappedType = wrappedType.createTypeBuildable()
    self.questionMark = questionMark
    assert(["?"].contains(self.questionMark.text))
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

public protocol ExpressibleAsOptionalType: ExpressibleAsTypeBuildable {
  func createOptionalType() -> OptionalType
}

extension OptionalType: ExpressibleAsOptionalType {
  public func createOptionalType() -> OptionalType {
    self
  }
}

public struct SomeType: TypeBuildable {
  let someSpecifier: TokenSyntax
  let baseType: TypeBuildable

  /// Creates a `SomeType` using the provided parameters.
  /// - Parameters:
  ///   - someSpecifier: 
  ///   - baseType: 
  public init(
    someSpecifier: TokenSyntax,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.someSpecifier = someSpecifier
    assert(["some"].contains(self.someSpecifier.text))
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

public protocol ExpressibleAsSomeType: ExpressibleAsTypeBuildable {
  func createSomeType() -> SomeType
}

extension SomeType: ExpressibleAsSomeType {
  public func createSomeType() -> SomeType {
    self
  }
}

public struct ImplicitlyUnwrappedOptionalType: TypeBuildable {
  let wrappedType: TypeBuildable
  let exclamationMark: TokenSyntax

  /// Creates a `ImplicitlyUnwrappedOptionalType` using the provided parameters.
  /// - Parameters:
  ///   - wrappedType: 
  ///   - exclamationMark: 
  public init(
    wrappedType: ExpressibleAsTypeBuildable,
    exclamationMark: TokenSyntax = TokenSyntax.`exclamationMark`
  ) {
    self.wrappedType = wrappedType.createTypeBuildable()
    self.exclamationMark = exclamationMark
    assert(["!"].contains(self.exclamationMark.text))
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

public protocol ExpressibleAsImplicitlyUnwrappedOptionalType: ExpressibleAsTypeBuildable {
  func createImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalType
}

extension ImplicitlyUnwrappedOptionalType: ExpressibleAsImplicitlyUnwrappedOptionalType {
  public func createImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalType {
    self
  }
}

public struct CompositionTypeElement: SyntaxBuildable {
  let type: TypeBuildable
  let ampersand: TokenSyntax?

  /// Creates a `CompositionTypeElement` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  ///   - ampersand: 
  public init(
    type: ExpressibleAsTypeBuildable,
    ampersand: TokenSyntax? = nil
  ) {
    self.type = type.createTypeBuildable()
    self.ampersand = ampersand
    assert(ampersand == nil || ["&"].contains(self.ampersand!.text))
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

public protocol ExpressibleAsCompositionTypeElement: ExpressibleAsSyntaxBuildable, ExpressibleAsCompositionTypeElementList {
  func createCompositionTypeElement() -> CompositionTypeElement
}

extension CompositionTypeElement: ExpressibleAsCompositionTypeElement {
  public func createCompositionTypeElement() -> CompositionTypeElement {
    self
  }
}

// MARK: - Syntax collection

/// `CompositionTypeElementList` represents a collection of 
/// `CompositionTypeElement`s.
public struct CompositionTypeElementList: SyntaxBuildable {
  let elements: [CompositionTypeElement]

  /// Creates a `CompositionTypeElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsCompositionTypeElement`
  public init(_ elements: [ExpressibleAsCompositionTypeElement]) {
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

extension CompositionTypeElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsCompositionTypeElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsCompositionTypeElementList: ExpressibleAsSyntaxBuildable {
  func createCompositionTypeElementList() -> CompositionTypeElementList
}

extension CompositionTypeElementList: ExpressibleAsCompositionTypeElementList {
  public func createCompositionTypeElementList() -> CompositionTypeElementList {
    self
  }
}

public struct CompositionType: TypeBuildable {
  let elements: CompositionTypeElementList

  /// Creates a `CompositionType` using the provided parameters.
  /// - Parameters:
  ///   - elements: 
  public init(
    elements: ExpressibleAsCompositionTypeElementList
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

public protocol ExpressibleAsCompositionType: ExpressibleAsTypeBuildable {
  func createCompositionType() -> CompositionType
}

extension CompositionType: ExpressibleAsCompositionType {
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

  /// Creates a `TupleTypeElement` using the provided parameters.
  /// - Parameters:
  ///   - inOut: 
  ///   - name: 
  ///   - secondName: 
  ///   - colon: 
  ///   - type: 
  ///   - ellipsis: 
  ///   - initializer: 
  ///   - trailingComma: 
  public init(
    inOut: TokenSyntax? = nil,
    name: TokenSyntax? = nil,
    secondName: TokenSyntax? = nil,
    colon: TokenSyntax? = nil,
    type: ExpressibleAsTypeBuildable,
    ellipsis: TokenSyntax? = nil,
    initializer: ExpressibleAsInitializerClause? = nil,
    trailingComma: TokenSyntax? = nil
  ) {
    self.inOut = inOut
    assert(inOut == nil || ["inout"].contains(self.inOut!.text))
    self.name = name
    self.secondName = secondName
    self.colon = colon
    assert(colon == nil || [":"].contains(self.colon!.text))
    self.type = type.createTypeBuildable()
    self.ellipsis = ellipsis
    assert(ellipsis == nil || ["..."].contains(self.ellipsis!.text))
    self.initializer = initializer?.createInitializerClause()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsTupleTypeElement: ExpressibleAsSyntaxBuildable, ExpressibleAsTupleTypeElementList {
  func createTupleTypeElement() -> TupleTypeElement
}

extension TupleTypeElement: ExpressibleAsTupleTypeElement {
  public func createTupleTypeElement() -> TupleTypeElement {
    self
  }
}

// MARK: - Syntax collection

/// `TupleTypeElementList` represents a collection of 
/// `TupleTypeElement`s.
public struct TupleTypeElementList: SyntaxBuildable {
  let elements: [TupleTypeElement]

  /// Creates a `TupleTypeElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTupleTypeElement`
  public init(_ elements: [ExpressibleAsTupleTypeElement]) {
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

extension TupleTypeElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsTupleTypeElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsTupleTypeElementList: ExpressibleAsSyntaxBuildable {
  func createTupleTypeElementList() -> TupleTypeElementList
}

extension TupleTypeElementList: ExpressibleAsTupleTypeElementList {
  public func createTupleTypeElementList() -> TupleTypeElementList {
    self
  }
}

public struct TupleType: TypeBuildable {
  let leftParen: TokenSyntax
  let elements: TupleTypeElementList
  let rightParen: TokenSyntax

  /// Creates a `TupleType` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elements: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elements: ExpressibleAsTupleTypeElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.elements = elements.createTupleTypeElementList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsTupleType: ExpressibleAsTypeBuildable {
  func createTupleType() -> TupleType
}

extension TupleType: ExpressibleAsTupleType {
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

  /// Creates a `FunctionType` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - arguments: 
  ///   - rightParen: 
  ///   - asyncKeyword: 
  ///   - throwsOrRethrowsKeyword: 
  ///   - arrow: 
  ///   - returnType: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    arguments: ExpressibleAsTupleTypeElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`,
    asyncKeyword: TokenSyntax? = nil,
    throwsOrRethrowsKeyword: TokenSyntax? = nil,
    arrow: TokenSyntax = TokenSyntax.`arrow`,
    returnType: ExpressibleAsTypeBuildable
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.arguments = arguments.createTupleTypeElementList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
    self.asyncKeyword = asyncKeyword
    assert(asyncKeyword == nil || ["async"].contains(self.asyncKeyword!.text))
    self.throwsOrRethrowsKeyword = throwsOrRethrowsKeyword
    assert(throwsOrRethrowsKeyword == nil || ["throws", "rethrows", "throw"].contains(self.throwsOrRethrowsKeyword!.text))
    self.arrow = arrow
    assert(["->"].contains(self.arrow.text))
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

public protocol ExpressibleAsFunctionType: ExpressibleAsTypeBuildable {
  func createFunctionType() -> FunctionType
}

extension FunctionType: ExpressibleAsFunctionType {
  public func createFunctionType() -> FunctionType {
    self
  }
}

public struct AttributedType: TypeBuildable {
  let specifier: TokenSyntax?
  let attributes: AttributeList?
  let baseType: TypeBuildable

  /// Creates a `AttributedType` using the provided parameters.
  /// - Parameters:
  ///   - specifier: 
  ///   - attributes: 
  ///   - baseType: 
  public init(
    specifier: TokenSyntax? = nil,
    attributes: ExpressibleAsAttributeList? = nil,
    baseType: ExpressibleAsTypeBuildable
  ) {
    self.specifier = specifier
    assert(specifier == nil || ["inout", "__shared", "__owned"].contains(self.specifier!.text))
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

public protocol ExpressibleAsAttributedType: ExpressibleAsTypeBuildable {
  func createAttributedType() -> AttributedType
}

extension AttributedType: ExpressibleAsAttributedType {
  public func createAttributedType() -> AttributedType {
    self
  }
}

// MARK: - Syntax collection

/// `GenericArgumentList` represents a collection of 
/// `GenericArgument`s.
public struct GenericArgumentList: SyntaxBuildable {
  let elements: [GenericArgument]

  /// Creates a `GenericArgumentList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsGenericArgument`
  public init(_ elements: [ExpressibleAsGenericArgument]) {
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

extension GenericArgumentList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsGenericArgument...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsGenericArgumentList: ExpressibleAsSyntaxBuildable {
  func createGenericArgumentList() -> GenericArgumentList
}

extension GenericArgumentList: ExpressibleAsGenericArgumentList {
  public func createGenericArgumentList() -> GenericArgumentList {
    self
  }
}

public struct GenericArgument: SyntaxBuildable {
  let argumentType: TypeBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `GenericArgument` using the provided parameters.
  /// - Parameters:
  ///   - argumentType: 
  ///   - trailingComma: 
  public init(
    argumentType: ExpressibleAsTypeBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.argumentType = argumentType.createTypeBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsGenericArgument: ExpressibleAsSyntaxBuildable, ExpressibleAsGenericArgumentList {
  func createGenericArgument() -> GenericArgument
}

extension GenericArgument: ExpressibleAsGenericArgument {
  public func createGenericArgument() -> GenericArgument {
    self
  }
}

public struct GenericArgumentClause: SyntaxBuildable {
  let leftAngleBracket: TokenSyntax
  let arguments: GenericArgumentList
  let rightAngleBracket: TokenSyntax

  /// Creates a `GenericArgumentClause` using the provided parameters.
  /// - Parameters:
  ///   - leftAngleBracket: 
  ///   - arguments: 
  ///   - rightAngleBracket: 
  public init(
    leftAngleBracket: TokenSyntax = TokenSyntax.`leftAngle`,
    arguments: ExpressibleAsGenericArgumentList,
    rightAngleBracket: TokenSyntax = TokenSyntax.`rightAngle`
  ) {
    self.leftAngleBracket = leftAngleBracket
    assert(["<"].contains(self.leftAngleBracket.text))
    self.arguments = arguments.createGenericArgumentList()
    self.rightAngleBracket = rightAngleBracket
    assert([">"].contains(self.rightAngleBracket.text))
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

public protocol ExpressibleAsGenericArgumentClause: ExpressibleAsSyntaxBuildable {
  func createGenericArgumentClause() -> GenericArgumentClause
}

extension GenericArgumentClause: ExpressibleAsGenericArgumentClause {
  public func createGenericArgumentClause() -> GenericArgumentClause {
    self
  }
}

public struct TypeAnnotation: SyntaxBuildable {
  let colon: TokenSyntax
  let type: TypeBuildable

  /// Creates a `TypeAnnotation` using the provided parameters.
  /// - Parameters:
  ///   - colon: 
  ///   - type: 
  public init(
    colon: TokenSyntax = TokenSyntax.`colon`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsTypeAnnotation: ExpressibleAsSyntaxBuildable {
  func createTypeAnnotation() -> TypeAnnotation
}

extension TypeAnnotation: ExpressibleAsTypeAnnotation {
  public func createTypeAnnotation() -> TypeAnnotation {
    self
  }
}

public struct EnumCasePattern: PatternBuildable {
  let type: TypeBuildable?
  let period: TokenSyntax
  let caseName: TokenSyntax
  let associatedTuple: TuplePattern?

  /// Creates a `EnumCasePattern` using the provided parameters.
  /// - Parameters:
  ///   - type: 
  ///   - period: 
  ///   - caseName: 
  ///   - associatedTuple: 
  public init(
    type: ExpressibleAsTypeBuildable? = nil,
    period: TokenSyntax = TokenSyntax.`period`,
    caseName: TokenSyntax,
    associatedTuple: ExpressibleAsTuplePattern? = nil
  ) {
    self.type = type?.createTypeBuildable()
    self.period = period
    assert(["."].contains(self.period.text))
    self.caseName = caseName
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

public protocol ExpressibleAsEnumCasePattern: ExpressibleAsPatternBuildable {
  func createEnumCasePattern() -> EnumCasePattern
}

extension EnumCasePattern: ExpressibleAsEnumCasePattern {
  public func createEnumCasePattern() -> EnumCasePattern {
    self
  }
}

public struct IsTypePattern: PatternBuildable {
  let isKeyword: TokenSyntax
  let type: TypeBuildable

  /// Creates a `IsTypePattern` using the provided parameters.
  /// - Parameters:
  ///   - isKeyword: 
  ///   - type: 
  public init(
    isKeyword: TokenSyntax = TokenSyntax.`is`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.isKeyword = isKeyword
    assert(["is"].contains(self.isKeyword.text))
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

public protocol ExpressibleAsIsTypePattern: ExpressibleAsPatternBuildable {
  func createIsTypePattern() -> IsTypePattern
}

extension IsTypePattern: ExpressibleAsIsTypePattern {
  public func createIsTypePattern() -> IsTypePattern {
    self
  }
}

public struct OptionalPattern: PatternBuildable {
  let subPattern: PatternBuildable
  let questionMark: TokenSyntax

  /// Creates a `OptionalPattern` using the provided parameters.
  /// - Parameters:
  ///   - subPattern: 
  ///   - questionMark: 
  public init(
    subPattern: ExpressibleAsPatternBuildable,
    questionMark: TokenSyntax = TokenSyntax.`postfixQuestionMark`
  ) {
    self.subPattern = subPattern.createPatternBuildable()
    self.questionMark = questionMark
    assert(["?"].contains(self.questionMark.text))
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

public protocol ExpressibleAsOptionalPattern: ExpressibleAsPatternBuildable {
  func createOptionalPattern() -> OptionalPattern
}

extension OptionalPattern: ExpressibleAsOptionalPattern {
  public func createOptionalPattern() -> OptionalPattern {
    self
  }
}

public struct IdentifierPattern: PatternBuildable {
  let identifier: TokenSyntax

  /// Creates a `IdentifierPattern` using the provided parameters.
  /// - Parameters:
  ///   - identifier: 
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

public protocol ExpressibleAsIdentifierPattern: ExpressibleAsPatternBuildable {
  func createIdentifierPattern() -> IdentifierPattern
}

extension IdentifierPattern: ExpressibleAsIdentifierPattern {
  public func createIdentifierPattern() -> IdentifierPattern {
    self
  }
}

public struct AsTypePattern: PatternBuildable {
  let pattern: PatternBuildable
  let asKeyword: TokenSyntax
  let type: TypeBuildable

  /// Creates a `AsTypePattern` using the provided parameters.
  /// - Parameters:
  ///   - pattern: 
  ///   - asKeyword: 
  ///   - type: 
  public init(
    pattern: ExpressibleAsPatternBuildable,
    asKeyword: TokenSyntax = TokenSyntax.`as`,
    type: ExpressibleAsTypeBuildable
  ) {
    self.pattern = pattern.createPatternBuildable()
    self.asKeyword = asKeyword
    assert(["as"].contains(self.asKeyword.text))
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

public protocol ExpressibleAsAsTypePattern: ExpressibleAsPatternBuildable {
  func createAsTypePattern() -> AsTypePattern
}

extension AsTypePattern: ExpressibleAsAsTypePattern {
  public func createAsTypePattern() -> AsTypePattern {
    self
  }
}

public struct TuplePattern: PatternBuildable {
  let leftParen: TokenSyntax
  let elements: TuplePatternElementList
  let rightParen: TokenSyntax

  /// Creates a `TuplePattern` using the provided parameters.
  /// - Parameters:
  ///   - leftParen: 
  ///   - elements: 
  ///   - rightParen: 
  public init(
    leftParen: TokenSyntax = TokenSyntax.`leftParen`,
    elements: ExpressibleAsTuplePatternElementList,
    rightParen: TokenSyntax = TokenSyntax.`rightParen`
  ) {
    self.leftParen = leftParen
    assert(["("].contains(self.leftParen.text))
    self.elements = elements.createTuplePatternElementList()
    self.rightParen = rightParen
    assert([")"].contains(self.rightParen.text))
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

public protocol ExpressibleAsTuplePattern: ExpressibleAsPatternBuildable {
  func createTuplePattern() -> TuplePattern
}

extension TuplePattern: ExpressibleAsTuplePattern {
  public func createTuplePattern() -> TuplePattern {
    self
  }
}

public struct WildcardPattern: PatternBuildable {
  let wildcard: TokenSyntax
  let typeAnnotation: TypeAnnotation?

  /// Creates a `WildcardPattern` using the provided parameters.
  /// - Parameters:
  ///   - wildcard: 
  ///   - typeAnnotation: 
  public init(
    wildcard: TokenSyntax = TokenSyntax.`wildcard`,
    typeAnnotation: ExpressibleAsTypeAnnotation? = nil
  ) {
    self.wildcard = wildcard
    assert(["_"].contains(self.wildcard.text))
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

public protocol ExpressibleAsWildcardPattern: ExpressibleAsPatternBuildable {
  func createWildcardPattern() -> WildcardPattern
}

extension WildcardPattern: ExpressibleAsWildcardPattern {
  public func createWildcardPattern() -> WildcardPattern {
    self
  }
}

public struct TuplePatternElement: SyntaxBuildable {
  let labelName: TokenSyntax?
  let labelColon: TokenSyntax?
  let pattern: PatternBuildable
  let trailingComma: TokenSyntax?

  /// Creates a `TuplePatternElement` using the provided parameters.
  /// - Parameters:
  ///   - labelName: 
  ///   - labelColon: 
  ///   - pattern: 
  ///   - trailingComma: 
  public init(
    labelName: TokenSyntax? = nil,
    labelColon: TokenSyntax? = nil,
    pattern: ExpressibleAsPatternBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.labelName = labelName
    self.labelColon = labelColon
    assert(labelColon == nil || [":"].contains(self.labelColon!.text))
    self.pattern = pattern.createPatternBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsTuplePatternElement: ExpressibleAsSyntaxBuildable, ExpressibleAsTuplePatternElementList {
  func createTuplePatternElement() -> TuplePatternElement
}

extension TuplePatternElement: ExpressibleAsTuplePatternElement {
  public func createTuplePatternElement() -> TuplePatternElement {
    self
  }
}

public struct ExpressionPattern: PatternBuildable {
  let expression: ExprBuildable

  /// Creates a `ExpressionPattern` using the provided parameters.
  /// - Parameters:
  ///   - expression: 
  public init(
    expression: ExpressibleAsExprBuildable
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

public protocol ExpressibleAsExpressionPattern: ExpressibleAsPatternBuildable {
  func createExpressionPattern() -> ExpressionPattern
}

extension ExpressionPattern: ExpressibleAsExpressionPattern {
  public func createExpressionPattern() -> ExpressionPattern {
    self
  }
}

// MARK: - Syntax collection

/// `TuplePatternElementList` represents a collection of 
/// `TuplePatternElement`s.
public struct TuplePatternElementList: SyntaxBuildable {
  let elements: [TuplePatternElement]

  /// Creates a `TuplePatternElementList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsTuplePatternElement`
  public init(_ elements: [ExpressibleAsTuplePatternElement]) {
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

extension TuplePatternElementList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsTuplePatternElement...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsTuplePatternElementList: ExpressibleAsSyntaxBuildable {
  func createTuplePatternElementList() -> TuplePatternElementList
}

extension TuplePatternElementList: ExpressibleAsTuplePatternElementList {
  public func createTuplePatternElementList() -> TuplePatternElementList {
    self
  }
}

public struct ValueBindingPattern: PatternBuildable {
  let letOrVarKeyword: TokenSyntax
  let valuePattern: PatternBuildable

  /// Creates a `ValueBindingPattern` using the provided parameters.
  /// - Parameters:
  ///   - letOrVarKeyword: 
  ///   - valuePattern: 
  public init(
    letOrVarKeyword: TokenSyntax,
    valuePattern: ExpressibleAsPatternBuildable
  ) {
    self.letOrVarKeyword = letOrVarKeyword
    assert(["let", "var"].contains(self.letOrVarKeyword.text))
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

public protocol ExpressibleAsValueBindingPattern: ExpressibleAsPatternBuildable {
  func createValueBindingPattern() -> ValueBindingPattern
}

extension ValueBindingPattern: ExpressibleAsValueBindingPattern {
  public func createValueBindingPattern() -> ValueBindingPattern {
    self
  }
}

// MARK: - Syntax collection

/// `AvailabilitySpecList` represents a collection of 
/// `AvailabilityArgument`s.
public struct AvailabilitySpecList: SyntaxBuildable {
  let elements: [AvailabilityArgument]

  /// Creates a `AvailabilitySpecList` with the provided list of elements.
  /// - Parameters:
  ///   - elements: A list of `ExpressibleAsAvailabilityArgument`
  public init(_ elements: [ExpressibleAsAvailabilityArgument]) {
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

extension AvailabilitySpecList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: ExpressibleAsAvailabilityArgument...) {
    self.init(elements)
  }
}

public protocol ExpressibleAsAvailabilitySpecList: ExpressibleAsSyntaxBuildable {
  func createAvailabilitySpecList() -> AvailabilitySpecList
}

extension AvailabilitySpecList: ExpressibleAsAvailabilitySpecList {
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

  /// Creates a `AvailabilityArgument` using the provided parameters.
  /// - Parameters:
  ///   - entry: The actual argument
  ///   - trailingComma: A trailing comma if the argument is followed by anotherargument
  public init(
    entry: ExpressibleAsSyntaxBuildable,
    trailingComma: TokenSyntax? = nil
  ) {
    self.entry = entry.createSyntaxBuildable()
    self.trailingComma = trailingComma
    assert(trailingComma == nil || [","].contains(self.trailingComma!.text))
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

public protocol ExpressibleAsAvailabilityArgument: ExpressibleAsSyntaxBuildable, ExpressibleAsAvailabilitySpecList {
  func createAvailabilityArgument() -> AvailabilityArgument
}

extension AvailabilityArgument: ExpressibleAsAvailabilityArgument {
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

  /// Creates a `AvailabilityLabeledArgument` using the provided parameters.
  /// - Parameters:
  ///   - label: The label of the argument
  ///   - colon: The colon separating label and value
  ///   - value: The value of this labeled argument
  public init(
    label: TokenSyntax,
    colon: TokenSyntax = TokenSyntax.`colon`,
    value: ExpressibleAsSyntaxBuildable
  ) {
    self.label = label
    self.colon = colon
    assert([":"].contains(self.colon.text))
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

public protocol ExpressibleAsAvailabilityLabeledArgument: ExpressibleAsSyntaxBuildable {
  func createAvailabilityLabeledArgument() -> AvailabilityLabeledArgument
}

extension AvailabilityLabeledArgument: ExpressibleAsAvailabilityLabeledArgument {
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

  /// Creates a `AvailabilityVersionRestriction` using the provided parameters.
  /// - Parameters:
  ///   - platform: The name of the OS on which the availability should berestricted or 'swift' if the availability should berestricted based on a Swift version.
  ///   - version: 
  public init(
    platform: TokenSyntax,
    version: ExpressibleAsVersionTuple? = nil
  ) {
    self.platform = platform
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

public protocol ExpressibleAsAvailabilityVersionRestriction: ExpressibleAsSyntaxBuildable {
  func createAvailabilityVersionRestriction() -> AvailabilityVersionRestriction
}

extension AvailabilityVersionRestriction: ExpressibleAsAvailabilityVersionRestriction {
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

  /// Creates a `VersionTuple` using the provided parameters.
  /// - Parameters:
  ///   - majorMinor: In case the version consists only of the major version, aninteger literal that specifies the major version. In casethe version consists of major and minor version number, afloating literal in which the decimal part is interpretedas the minor version.
  ///   - patchPeriod: If the version contains a patch number, the periodseparating the minor from the patch number.
  ///   - patchVersion: The patch version if specified.
  public init(
    majorMinor: ExpressibleAsSyntaxBuildable,
    patchPeriod: TokenSyntax? = nil,
    patchVersion: TokenSyntax? = nil
  ) {
    self.majorMinor = majorMinor.createSyntaxBuildable()
    self.patchPeriod = patchPeriod
    assert(patchPeriod == nil || ["."].contains(self.patchPeriod!.text))
    self.patchVersion = patchVersion
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

public protocol ExpressibleAsVersionTuple: ExpressibleAsSyntaxBuildable {
  func createVersionTuple() -> VersionTuple
}

extension VersionTuple: ExpressibleAsVersionTuple {
  public func createVersionTuple() -> VersionTuple {
    self
  }
}

extension TokenSyntax: SyntaxBuildable, ExpressibleAsIdentifierList, ExpressibleAsTokenList, ExpressibleAsNonEmptyTokenList, ExpressibleAsBinaryOperatorExpr, ExpressibleAsDeclModifier {
}

// MARK: - Syntax Collection buildable expressible as conformances

extension ExpressibleAsTupleExprElement {
  public func createTupleExprElementList() -> TupleExprElementList {
    TupleExprElementList([self])
  }
}

extension ExpressibleAsDifferentiabilityParam {
  public func createDifferentiabilityParamList() -> DifferentiabilityParamList {
    DifferentiabilityParamList([self])
  }
}

extension ExpressibleAsAvailabilityArgument {
  public func createAvailabilitySpecList() -> AvailabilitySpecList {
    AvailabilitySpecList([self])
  }
}

extension ExpressibleAsGenericArgument {
  public func createGenericArgumentList() -> GenericArgumentList {
    GenericArgumentList([self])
  }
}

extension ExpressibleAsEnumCaseElement {
  public func createEnumCaseElementList() -> EnumCaseElementList {
    EnumCaseElementList([self])
  }
}

extension ExpressibleAsCatchItem {
  public func createCatchItemList() -> CatchItemList {
    CatchItemList([self])
  }
}

extension ExpressibleAsClosureCaptureItem {
  public func createClosureCaptureItemList() -> ClosureCaptureItemList {
    ClosureCaptureItemList([self])
  }
}

extension ExpressibleAsMultipleTrailingClosureElement {
  public func createMultipleTrailingClosureElementList() -> MultipleTrailingClosureElementList {
    MultipleTrailingClosureElementList([self])
  }
}

extension ExpressibleAsTupleTypeElement {
  public func createTupleTypeElementList() -> TupleTypeElementList {
    TupleTypeElementList([self])
  }
}

extension ExpressibleAsAccessorDecl {
  public func createAccessorList() -> AccessorList {
    AccessorList([self])
  }
}

extension ExpressibleAsDeclModifier {
  public func createModifierList() -> ModifierList {
    ModifierList([self])
  }
}

extension ExpressibleAsIfConfigClause {
  public func createIfConfigClauseList() -> IfConfigClauseList {
    IfConfigClauseList([self])
  }
}

extension ExpressibleAsAccessPathComponent {
  public func createAccessPath() -> AccessPath {
    AccessPath([self])
  }
}

extension ExpressibleAsArrayElement {
  public func createArrayElementList() -> ArrayElementList {
    ArrayElementList([self])
  }
}

extension ExpressibleAsCatchClause {
  public func createCatchClauseList() -> CatchClauseList {
    CatchClauseList([self])
  }
}

extension ExpressibleAsGenericRequirement {
  public func createGenericRequirementList() -> GenericRequirementList {
    GenericRequirementList([self])
  }
}

extension ExpressibleAsInheritedType {
  public func createInheritedTypeList() -> InheritedTypeList {
    InheritedTypeList([self])
  }
}

extension ExpressibleAsMemberDeclListItem {
  public func createMemberDeclList() -> MemberDeclList {
    MemberDeclList([self])
  }
}

extension ExpressibleAsGenericParameter {
  public func createGenericParameterList() -> GenericParameterList {
    GenericParameterList([self])
  }
}

extension ExpressibleAsDeclNameArgument {
  public func createDeclNameArgumentList() -> DeclNameArgumentList {
    DeclNameArgumentList([self])
  }
}

extension TokenSyntax {
  public func createIdentifierList() -> IdentifierList {
    IdentifierList([self])
  }
}

extension TokenSyntax {
  public func createTokenList() -> TokenList {
    TokenList([self])
  }
}

extension TokenSyntax {
  public func createNonEmptyTokenList() -> NonEmptyTokenList {
    NonEmptyTokenList([self])
  }
}

extension ExpressibleAsDictionaryElement {
  public func createDictionaryElementList() -> DictionaryElementList {
    DictionaryElementList([self])
  }
}

extension ExpressibleAsCompositionTypeElement {
  public func createCompositionTypeElementList() -> CompositionTypeElementList {
    CompositionTypeElementList([self])
  }
}

extension ExpressibleAsFunctionParameter {
  public func createFunctionParameterList() -> FunctionParameterList {
    FunctionParameterList([self])
  }
}

extension ExpressibleAsConditionElement {
  public func createConditionElementList() -> ConditionElementList {
    ConditionElementList([self])
  }
}

extension ExpressibleAsObjCSelectorPiece {
  public func createObjCSelector() -> ObjCSelector {
    ObjCSelector([self])
  }
}

extension ExpressibleAsCaseItem {
  public func createCaseItemList() -> CaseItemList {
    CaseItemList([self])
  }
}

extension ExpressibleAsTuplePatternElement {
  public func createTuplePatternElementList() -> TuplePatternElementList {
    TuplePatternElementList([self])
  }
}

extension ExpressibleAsCodeBlockItem {
  public func createCodeBlockItemList() -> CodeBlockItemList {
    CodeBlockItemList([self])
  }
}

extension ExpressibleAsExprBuildable {
  public func createExprList() -> ExprList {
    ExprList([self])
  }
}

extension ExpressibleAsPatternBinding {
  public func createPatternBindingList() -> PatternBindingList {
    PatternBindingList([self])
  }
}

extension ExpressibleAsObjcNamePiece {
  public func createObjcName() -> ObjcName {
    ObjcName([self])
  }
}

extension ExpressibleAsClosureParam {
  public func createClosureParamList() -> ClosureParamList {
    ClosureParamList([self])
  }
}

extension ExpressibleAsPrecedenceGroupNameElement {
  public func createPrecedenceGroupNameList() -> PrecedenceGroupNameList {
    PrecedenceGroupNameList([self])
  }
}

// MARK: - Syntax buildable expressible as conformances

extension ExpressibleAsAccessorList {
  public func createAccessorBlock() -> AccessorBlock {
    AccessorBlock(accessors: self)
  }
}

extension ExpressibleAsExprBuildable {
  public func createCodeBlockItem() -> CodeBlockItem {
    CodeBlockItem(item: self)
  }
}

extension ExpressibleAsStmtBuildable {
  public func createCodeBlockItem() -> CodeBlockItem {
    CodeBlockItem(item: self)
  }
}

extension ExpressibleAsCodeBlockItemList {
  public func createCodeBlock() -> CodeBlock {
    CodeBlock(statements: self)
  }
}

extension ExpressibleAsDeclBuildable {
  public func createCodeBlockItem() -> CodeBlockItem {
    CodeBlockItem(item: self)
  }
}

extension ExpressibleAsDeclBuildable {
  public func createMemberDeclListItem() -> MemberDeclListItem {
    MemberDeclListItem(decl: self)
  }
}

extension ExpressibleAsSimpleTypeIdentifier {
  public func createTypeAnnotation() -> TypeAnnotation {
    TypeAnnotation(type: self)
  }
}

extension ExpressibleAsSimpleTypeIdentifier {
  public func createTypeExpr() -> TypeExpr {
    TypeExpr(type: self)
  }
}

extension ExpressibleAsMemberDeclList {
  public func createMemberDeclBlock() -> MemberDeclBlock {
    MemberDeclBlock(members: self)
  }
}

extension ExpressibleAsExprList {
  public func createConditionElement() -> ConditionElement {
    ConditionElement(condition: self)
  }
}

extension ExpressibleAsSequenceExpr {
  public func createTupleExprElement() -> TupleExprElement {
    TupleExprElement(expression: self)
  }
}

extension TokenSyntax {
  public func createBinaryOperatorExpr() -> BinaryOperatorExpr {
    BinaryOperatorExpr(operatorToken: self)
  }
}

extension TokenSyntax {
  public func createDeclModifier() -> DeclModifier {
    DeclModifier(name: self)
  }
}

