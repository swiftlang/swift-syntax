//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxNodes.swift - Syntax Node definitions -------------===//
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

import _InternalSwiftSyntaxParser


/// A wrapper around a raw Syntax layout.
public struct UnknownSyntax: _SyntaxBase, Hashable {
  let data: SyntaxData

  /// Creates an `UnknownSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// Determines if two `UnknownSyntax` nodes are equal to each other.
  public static func ==(lhs: UnknownSyntax, rhs: UnknownSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}

public protocol DeclSyntax: Syntax {}

public protocol ExprSyntax: Syntax {}

public protocol StmtSyntax: Syntax {}

public protocol TypeSyntax: Syntax {}

public protocol PatternSyntax: Syntax {}


public struct UnknownDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {

  let data: SyntaxData

  /// Creates a `UnknownDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }


  /// Determines if two `UnknownDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: UnknownDeclSyntax, rhs: UnknownDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct UnknownExprSyntax: ExprSyntax, _SyntaxBase, Hashable {

  let data: SyntaxData

  /// Creates a `UnknownExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }


  /// Determines if two `UnknownExprSyntax` nodes are equal to each other.
  public static func ==(lhs: UnknownExprSyntax, rhs: UnknownExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct UnknownStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {

  let data: SyntaxData

  /// Creates a `UnknownStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }


  /// Determines if two `UnknownStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: UnknownStmtSyntax, rhs: UnknownStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct UnknownTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {

  let data: SyntaxData

  /// Creates a `UnknownTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }


  /// Determines if two `UnknownTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: UnknownTypeSyntax, rhs: UnknownTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct UnknownPatternSyntax: PatternSyntax, _SyntaxBase, Hashable {

  let data: SyntaxData

  /// Creates a `UnknownPatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }


  /// Determines if two `UnknownPatternSyntax` nodes are equal to each other.
  public static func ==(lhs: UnknownPatternSyntax, rhs: UnknownPatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A CodeBlockItem is any Syntax node that appears on its own line inside
/// a CodeBlock.
/// 
public struct CodeBlockItemSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case item
    case semicolon
    case errorTokens
  }

  let data: SyntaxData

  /// Creates a `CodeBlockItemSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The underlying node inside the code block.
  public var item: Syntax {
  get {
    let child = data.child(at: Cursor.item, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withItem(value)
  }
  }

  /// Returns a copy of the receiver with its `item` replaced.
  /// - param newChild: The new `item` to replace the node's
  ///                   current `item`, if present.
  public func withItem(
    _ newChild: Syntax?) -> CodeBlockItemSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.item)
    return CodeBlockItemSyntax(newData)
  }
  /// 
  /// If present, the trailing semicolon at the end of the item.
  /// 
  public var semicolon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.semicolon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withSemicolon(value)
  }
  }

  /// Returns a copy of the receiver with its `semicolon` replaced.
  /// - param newChild: The new `semicolon` to replace the node's
  ///                   current `semicolon`, if present.
  public func withSemicolon(
    _ newChild: TokenSyntax?) -> CodeBlockItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.semicolon)
    return CodeBlockItemSyntax(newData)
  }
  public var errorTokens: Syntax? {
  get {
    let child = data.child(at: Cursor.errorTokens, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) 
  }
  set(value) {
    self = withErrorTokens(value)
  }
  }

  /// Returns a copy of the receiver with its `errorTokens` replaced.
  /// - param newChild: The new `errorTokens` to replace the node's
  ///                   current `errorTokens`, if present.
  public func withErrorTokens(
    _ newChild: Syntax?) -> CodeBlockItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.errorTokens)
    return CodeBlockItemSyntax(newData)
  }

  /// Determines if two `CodeBlockItemSyntax` nodes are equal to each other.
  public static func ==(lhs: CodeBlockItemSyntax, rhs: CodeBlockItemSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct CodeBlockSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftBrace
    case statements
    case rightBrace
  }

  let data: SyntaxData

  /// Creates a `CodeBlockSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `leftBrace` replaced.
  /// - param newChild: The new `leftBrace` to replace the node's
  ///                   current `leftBrace`, if present.
  public func withLeftBrace(
    _ newChild: TokenSyntax?) -> CodeBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return CodeBlockSyntax(newData)
  }
  public var statements: CodeBlockItemListSyntax {
  get {
    let child = data.child(at: Cursor.statements, parent: self)
    return CodeBlockItemListSyntax(child!)
  }
  set(value) {
    self = withStatements(value)
  }
  }

  /// Adds the provided `CodeBlockItem` to the node's `statements`
  /// collection.
  /// - param element: The new `CodeBlockItem` to add to the node's
  ///                  `statements` collection.
  /// - returns: A copy of the receiver with the provided `CodeBlockItem`
  ///            appended to its `statements` collection.
  public func addCodeBlockItem(_ element: CodeBlockItemSyntax) -> CodeBlockSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.statements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.statements)
    return CodeBlockSyntax(newData)
  }

  /// Returns a copy of the receiver with its `statements` replaced.
  /// - param newChild: The new `statements` to replace the node's
  ///                   current `statements`, if present.
  public func withStatements(
    _ newChild: CodeBlockItemListSyntax?) -> CodeBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlockItemList)
    let newData = data.replacingChild(raw, at: Cursor.statements)
    return CodeBlockSyntax(newData)
  }
  public var rightBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `rightBrace` replaced.
  /// - param newChild: The new `rightBrace` to replace the node's
  ///                   current `rightBrace`, if present.
  public func withRightBrace(
    _ newChild: TokenSyntax?) -> CodeBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return CodeBlockSyntax(newData)
  }

  /// Determines if two `CodeBlockSyntax` nodes are equal to each other.
  public static func ==(lhs: CodeBlockSyntax, rhs: CodeBlockSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct InOutExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case ampersand
    case expression
  }

  let data: SyntaxData

  /// Creates a `InOutExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var ampersand: TokenSyntax {
  get {
    let child = data.child(at: Cursor.ampersand, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAmpersand(value)
  }
  }

  /// Returns a copy of the receiver with its `ampersand` replaced.
  /// - param newChild: The new `ampersand` to replace the node's
  ///                   current `ampersand`, if present.
  public func withAmpersand(
    _ newChild: TokenSyntax?) -> InOutExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.prefixAmpersand)
    let newData = data.replacingChild(raw, at: Cursor.ampersand)
    return InOutExprSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> InOutExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return InOutExprSyntax(newData)
  }

  /// Determines if two `InOutExprSyntax` nodes are equal to each other.
  public static func ==(lhs: InOutExprSyntax, rhs: InOutExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundColumnExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundColumn
  }

  let data: SyntaxData

  /// Creates a `PoundColumnExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundColumn: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundColumn, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundColumn(value)
  }
  }

  /// Returns a copy of the receiver with its `poundColumn` replaced.
  /// - param newChild: The new `poundColumn` to replace the node's
  ///                   current `poundColumn`, if present.
  public func withPoundColumn(
    _ newChild: TokenSyntax?) -> PoundColumnExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundColumnKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundColumn)
    return PoundColumnExprSyntax(newData)
  }

  /// Determines if two `PoundColumnExprSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundColumnExprSyntax, rhs: PoundColumnExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TryExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case tryKeyword
    case questionOrExclamationMark
    case expression
  }

  let data: SyntaxData

  /// Creates a `TryExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var tryKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.tryKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTryKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `tryKeyword` replaced.
  /// - param newChild: The new `tryKeyword` to replace the node's
  ///                   current `tryKeyword`, if present.
  public func withTryKeyword(
    _ newChild: TokenSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.tryKeyword)
    let newData = data.replacingChild(raw, at: Cursor.tryKeyword)
    return TryExprSyntax(newData)
  }
  public var questionOrExclamationMark: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.questionOrExclamationMark, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withQuestionOrExclamationMark(value)
  }
  }

  /// Returns a copy of the receiver with its `questionOrExclamationMark` replaced.
  /// - param newChild: The new `questionOrExclamationMark` to replace the node's
  ///                   current `questionOrExclamationMark`, if present.
  public func withQuestionOrExclamationMark(
    _ newChild: TokenSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.questionOrExclamationMark)
    return TryExprSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> TryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return TryExprSyntax(newData)
  }

  /// Determines if two `TryExprSyntax` nodes are equal to each other.
  public static func ==(lhs: TryExprSyntax, rhs: TryExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DeclNameArgumentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case colon
  }

  let data: SyntaxData

  /// Creates a `DeclNameArgumentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> DeclNameArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return DeclNameArgumentSyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> DeclNameArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return DeclNameArgumentSyntax(newData)
  }

  /// Determines if two `DeclNameArgumentSyntax` nodes are equal to each other.
  public static func ==(lhs: DeclNameArgumentSyntax, rhs: DeclNameArgumentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DeclNameArgumentsSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftParen
    case arguments
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `DeclNameArgumentsSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> DeclNameArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return DeclNameArgumentsSyntax(newData)
  }
  public var arguments: DeclNameArgumentListSyntax {
  get {
    let child = data.child(at: Cursor.arguments, parent: self)
    return DeclNameArgumentListSyntax(child!)
  }
  set(value) {
    self = withArguments(value)
  }
  }

  /// Adds the provided `DeclNameArgument` to the node's `arguments`
  /// collection.
  /// - param element: The new `DeclNameArgument` to add to the node's
  ///                  `arguments` collection.
  /// - returns: A copy of the receiver with the provided `DeclNameArgument`
  ///            appended to its `arguments` collection.
  public func addDeclNameArgument(_ element: DeclNameArgumentSyntax) -> DeclNameArgumentsSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.arguments] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.declNameArgumentList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.arguments)
    return DeclNameArgumentsSyntax(newData)
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: DeclNameArgumentListSyntax?) -> DeclNameArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.declNameArgumentList)
    let newData = data.replacingChild(raw, at: Cursor.arguments)
    return DeclNameArgumentsSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> DeclNameArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return DeclNameArgumentsSyntax(newData)
  }

  /// Determines if two `DeclNameArgumentsSyntax` nodes are equal to each other.
  public static func ==(lhs: DeclNameArgumentsSyntax, rhs: DeclNameArgumentsSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct IdentifierExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case identifier
    case declNameArguments
  }

  let data: SyntaxData

  /// Creates a `IdentifierExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return IdentifierExprSyntax(newData)
  }
  public var declNameArguments: DeclNameArgumentsSyntax? {
  get {
    let child = data.child(at: Cursor.declNameArguments, parent: self)
    if child == nil { return nil }
    return DeclNameArgumentsSyntax(child!)
  }
  set(value) {
    self = withDeclNameArguments(value)
  }
  }

  /// Returns a copy of the receiver with its `declNameArguments` replaced.
  /// - param newChild: The new `declNameArguments` to replace the node's
  ///                   current `declNameArguments`, if present.
  public func withDeclNameArguments(
    _ newChild: DeclNameArgumentsSyntax?) -> IdentifierExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.declNameArguments)
    return IdentifierExprSyntax(newData)
  }

  /// Determines if two `IdentifierExprSyntax` nodes are equal to each other.
  public static func ==(lhs: IdentifierExprSyntax, rhs: IdentifierExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SuperRefExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case superKeyword
  }

  let data: SyntaxData

  /// Creates a `SuperRefExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var superKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.superKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withSuperKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `superKeyword` replaced.
  /// - param newChild: The new `superKeyword` to replace the node's
  ///                   current `superKeyword`, if present.
  public func withSuperKeyword(
    _ newChild: TokenSyntax?) -> SuperRefExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.superKeyword)
    let newData = data.replacingChild(raw, at: Cursor.superKeyword)
    return SuperRefExprSyntax(newData)
  }

  /// Determines if two `SuperRefExprSyntax` nodes are equal to each other.
  public static func ==(lhs: SuperRefExprSyntax, rhs: SuperRefExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct NilLiteralExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case nilKeyword
  }

  let data: SyntaxData

  /// Creates a `NilLiteralExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var nilKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.nilKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withNilKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `nilKeyword` replaced.
  /// - param newChild: The new `nilKeyword` to replace the node's
  ///                   current `nilKeyword`, if present.
  public func withNilKeyword(
    _ newChild: TokenSyntax?) -> NilLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.nilKeyword)
    let newData = data.replacingChild(raw, at: Cursor.nilKeyword)
    return NilLiteralExprSyntax(newData)
  }

  /// Determines if two `NilLiteralExprSyntax` nodes are equal to each other.
  public static func ==(lhs: NilLiteralExprSyntax, rhs: NilLiteralExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DiscardAssignmentExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case wildcard
  }

  let data: SyntaxData

  /// Creates a `DiscardAssignmentExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var wildcard: TokenSyntax {
  get {
    let child = data.child(at: Cursor.wildcard, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withWildcard(value)
  }
  }

  /// Returns a copy of the receiver with its `wildcard` replaced.
  /// - param newChild: The new `wildcard` to replace the node's
  ///                   current `wildcard`, if present.
  public func withWildcard(
    _ newChild: TokenSyntax?) -> DiscardAssignmentExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.wildcardKeyword)
    let newData = data.replacingChild(raw, at: Cursor.wildcard)
    return DiscardAssignmentExprSyntax(newData)
  }

  /// Determines if two `DiscardAssignmentExprSyntax` nodes are equal to each other.
  public static func ==(lhs: DiscardAssignmentExprSyntax, rhs: DiscardAssignmentExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AssignmentExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case assignToken
  }

  let data: SyntaxData

  /// Creates a `AssignmentExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var assignToken: TokenSyntax {
  get {
    let child = data.child(at: Cursor.assignToken, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAssignToken(value)
  }
  }

  /// Returns a copy of the receiver with its `assignToken` replaced.
  /// - param newChild: The new `assignToken` to replace the node's
  ///                   current `assignToken`, if present.
  public func withAssignToken(
    _ newChild: TokenSyntax?) -> AssignmentExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.equal)
    let newData = data.replacingChild(raw, at: Cursor.assignToken)
    return AssignmentExprSyntax(newData)
  }

  /// Determines if two `AssignmentExprSyntax` nodes are equal to each other.
  public static func ==(lhs: AssignmentExprSyntax, rhs: AssignmentExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SequenceExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case elements
  }

  let data: SyntaxData

  /// Creates a `SequenceExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var elements: ExprListSyntax {
  get {
    let child = data.child(at: Cursor.elements, parent: self)
    return ExprListSyntax(child!)
  }
  set(value) {
    self = withElements(value)
  }
  }

  /// Adds the provided `Expression` to the node's `elements`
  /// collection.
  /// - param element: The new `Expression` to add to the node's
  ///                  `elements` collection.
  /// - returns: A copy of the receiver with the provided `Expression`
  ///            appended to its `elements` collection.
  public func addExpression(_ element: ExprSyntax) -> SequenceExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.exprList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return SequenceExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: ExprListSyntax?) -> SequenceExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.exprList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return SequenceExprSyntax(newData)
  }

  /// Determines if two `SequenceExprSyntax` nodes are equal to each other.
  public static func ==(lhs: SequenceExprSyntax, rhs: SequenceExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundLineExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundLine
  }

  let data: SyntaxData

  /// Creates a `PoundLineExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundLine: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundLine, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundLine(value)
  }
  }

  /// Returns a copy of the receiver with its `poundLine` replaced.
  /// - param newChild: The new `poundLine` to replace the node's
  ///                   current `poundLine`, if present.
  public func withPoundLine(
    _ newChild: TokenSyntax?) -> PoundLineExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundLineKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundLine)
    return PoundLineExprSyntax(newData)
  }

  /// Determines if two `PoundLineExprSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundLineExprSyntax, rhs: PoundLineExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundFileExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundFile
  }

  let data: SyntaxData

  /// Creates a `PoundFileExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundFile: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundFile, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundFile(value)
  }
  }

  /// Returns a copy of the receiver with its `poundFile` replaced.
  /// - param newChild: The new `poundFile` to replace the node's
  ///                   current `poundFile`, if present.
  public func withPoundFile(
    _ newChild: TokenSyntax?) -> PoundFileExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundFileKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundFile)
    return PoundFileExprSyntax(newData)
  }

  /// Determines if two `PoundFileExprSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundFileExprSyntax, rhs: PoundFileExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundFunctionExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundFunction
  }

  let data: SyntaxData

  /// Creates a `PoundFunctionExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundFunction: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundFunction, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundFunction(value)
  }
  }

  /// Returns a copy of the receiver with its `poundFunction` replaced.
  /// - param newChild: The new `poundFunction` to replace the node's
  ///                   current `poundFunction`, if present.
  public func withPoundFunction(
    _ newChild: TokenSyntax?) -> PoundFunctionExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundFunctionKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundFunction)
    return PoundFunctionExprSyntax(newData)
  }

  /// Determines if two `PoundFunctionExprSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundFunctionExprSyntax, rhs: PoundFunctionExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundDsohandleExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundDsohandle
  }

  let data: SyntaxData

  /// Creates a `PoundDsohandleExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundDsohandle: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundDsohandle, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundDsohandle(value)
  }
  }

  /// Returns a copy of the receiver with its `poundDsohandle` replaced.
  /// - param newChild: The new `poundDsohandle` to replace the node's
  ///                   current `poundDsohandle`, if present.
  public func withPoundDsohandle(
    _ newChild: TokenSyntax?) -> PoundDsohandleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundDsohandleKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundDsohandle)
    return PoundDsohandleExprSyntax(newData)
  }

  /// Determines if two `PoundDsohandleExprSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundDsohandleExprSyntax, rhs: PoundDsohandleExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SymbolicReferenceExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case identifier
    case genericArgumentClause
  }

  let data: SyntaxData

  /// Creates a `SymbolicReferenceExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return SymbolicReferenceExprSyntax(newData)
  }
  public var genericArgumentClause: GenericArgumentClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericArgumentClause, parent: self)
    if child == nil { return nil }
    return GenericArgumentClauseSyntax(child!)
  }
  set(value) {
    self = withGenericArgumentClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericArgumentClause` replaced.
  /// - param newChild: The new `genericArgumentClause` to replace the node's
  ///                   current `genericArgumentClause`, if present.
  public func withGenericArgumentClause(
    _ newChild: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return SymbolicReferenceExprSyntax(newData)
  }

  /// Determines if two `SymbolicReferenceExprSyntax` nodes are equal to each other.
  public static func ==(lhs: SymbolicReferenceExprSyntax, rhs: SymbolicReferenceExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PrefixOperatorExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case operatorToken
    case postfixExpression
  }

  let data: SyntaxData

  /// Creates a `PrefixOperatorExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var operatorToken: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.operatorToken, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withOperatorToken(value)
  }
  }

  /// Returns a copy of the receiver with its `operatorToken` replaced.
  /// - param newChild: The new `operatorToken` to replace the node's
  ///                   current `operatorToken`, if present.
  public func withOperatorToken(
    _ newChild: TokenSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.operatorToken)
    return PrefixOperatorExprSyntax(newData)
  }
  public var postfixExpression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.postfixExpression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withPostfixExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `postfixExpression` replaced.
  /// - param newChild: The new `postfixExpression` to replace the node's
  ///                   current `postfixExpression`, if present.
  public func withPostfixExpression(
    _ newChild: ExprSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.postfixExpression)
    return PrefixOperatorExprSyntax(newData)
  }

  /// Determines if two `PrefixOperatorExprSyntax` nodes are equal to each other.
  public static func ==(lhs: PrefixOperatorExprSyntax, rhs: PrefixOperatorExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct BinaryOperatorExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case operatorToken
  }

  let data: SyntaxData

  /// Creates a `BinaryOperatorExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var operatorToken: TokenSyntax {
  get {
    let child = data.child(at: Cursor.operatorToken, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withOperatorToken(value)
  }
  }

  /// Returns a copy of the receiver with its `operatorToken` replaced.
  /// - param newChild: The new `operatorToken` to replace the node's
  ///                   current `operatorToken`, if present.
  public func withOperatorToken(
    _ newChild: TokenSyntax?) -> BinaryOperatorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.operatorToken)
    return BinaryOperatorExprSyntax(newData)
  }

  /// Determines if two `BinaryOperatorExprSyntax` nodes are equal to each other.
  public static func ==(lhs: BinaryOperatorExprSyntax, rhs: BinaryOperatorExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ArrowExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case throwsToken
    case arrowToken
  }

  let data: SyntaxData

  /// Creates a `ArrowExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var throwsToken: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.throwsToken, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withThrowsToken(value)
  }
  }

  /// Returns a copy of the receiver with its `throwsToken` replaced.
  /// - param newChild: The new `throwsToken` to replace the node's
  ///                   current `throwsToken`, if present.
  public func withThrowsToken(
    _ newChild: TokenSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.throwsToken)
    return ArrowExprSyntax(newData)
  }
  public var arrowToken: TokenSyntax {
  get {
    let child = data.child(at: Cursor.arrowToken, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withArrowToken(value)
  }
  }

  /// Returns a copy of the receiver with its `arrowToken` replaced.
  /// - param newChild: The new `arrowToken` to replace the node's
  ///                   current `arrowToken`, if present.
  public func withArrowToken(
    _ newChild: TokenSyntax?) -> ArrowExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.arrow)
    let newData = data.replacingChild(raw, at: Cursor.arrowToken)
    return ArrowExprSyntax(newData)
  }

  /// Determines if two `ArrowExprSyntax` nodes are equal to each other.
  public static func ==(lhs: ArrowExprSyntax, rhs: ArrowExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct FloatLiteralExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case floatingDigits
  }

  let data: SyntaxData

  /// Creates a `FloatLiteralExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var floatingDigits: TokenSyntax {
  get {
    let child = data.child(at: Cursor.floatingDigits, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withFloatingDigits(value)
  }
  }

  /// Returns a copy of the receiver with its `floatingDigits` replaced.
  /// - param newChild: The new `floatingDigits` to replace the node's
  ///                   current `floatingDigits`, if present.
  public func withFloatingDigits(
    _ newChild: TokenSyntax?) -> FloatLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.floatingLiteral(""))
    let newData = data.replacingChild(raw, at: Cursor.floatingDigits)
    return FloatLiteralExprSyntax(newData)
  }

  /// Determines if two `FloatLiteralExprSyntax` nodes are equal to each other.
  public static func ==(lhs: FloatLiteralExprSyntax, rhs: FloatLiteralExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TupleExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftParen
    case elementList
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `TupleExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return TupleExprSyntax(newData)
  }
  public var elementList: TupleElementListSyntax {
  get {
    let child = data.child(at: Cursor.elementList, parent: self)
    return TupleElementListSyntax(child!)
  }
  set(value) {
    self = withElementList(value)
  }
  }

  /// Adds the provided `TupleElement` to the node's `elementList`
  /// collection.
  /// - param element: The new `TupleElement` to add to the node's
  ///                  `elementList` collection.
  /// - returns: A copy of the receiver with the provided `TupleElement`
  ///            appended to its `elementList` collection.
  public func addTupleElement(_ element: TupleElementSyntax) -> TupleExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elementList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elementList)
    return TupleExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elementList` replaced.
  /// - param newChild: The new `elementList` to replace the node's
  ///                   current `elementList`, if present.
  public func withElementList(
    _ newChild: TupleElementListSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tupleElementList)
    let newData = data.replacingChild(raw, at: Cursor.elementList)
    return TupleExprSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> TupleExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return TupleExprSyntax(newData)
  }

  /// Determines if two `TupleExprSyntax` nodes are equal to each other.
  public static func ==(lhs: TupleExprSyntax, rhs: TupleExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ArrayExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftSquare
    case elements
    case rightSquare
  }

  let data: SyntaxData

  /// Creates a `ArrayExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftSquare: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftSquare, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftSquare(value)
  }
  }

  /// Returns a copy of the receiver with its `leftSquare` replaced.
  /// - param newChild: The new `leftSquare` to replace the node's
  ///                   current `leftSquare`, if present.
  public func withLeftSquare(
    _ newChild: TokenSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftSquare)
    return ArrayExprSyntax(newData)
  }
  public var elements: ArrayElementListSyntax {
  get {
    let child = data.child(at: Cursor.elements, parent: self)
    return ArrayElementListSyntax(child!)
  }
  set(value) {
    self = withElements(value)
  }
  }

  /// Adds the provided `ArrayElement` to the node's `elements`
  /// collection.
  /// - param element: The new `ArrayElement` to add to the node's
  ///                  `elements` collection.
  /// - returns: A copy of the receiver with the provided `ArrayElement`
  ///            appended to its `elements` collection.
  public func addArrayElement(_ element: ArrayElementSyntax) -> ArrayExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.arrayElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return ArrayExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: ArrayElementListSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.arrayElementList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return ArrayExprSyntax(newData)
  }
  public var rightSquare: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightSquare, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightSquare(value)
  }
  }

  /// Returns a copy of the receiver with its `rightSquare` replaced.
  /// - param newChild: The new `rightSquare` to replace the node's
  ///                   current `rightSquare`, if present.
  public func withRightSquare(
    _ newChild: TokenSyntax?) -> ArrayExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightSquare)
    return ArrayExprSyntax(newData)
  }

  /// Determines if two `ArrayExprSyntax` nodes are equal to each other.
  public static func ==(lhs: ArrayExprSyntax, rhs: ArrayExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DictionaryExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftSquare
    case content
    case rightSquare
  }

  let data: SyntaxData

  /// Creates a `DictionaryExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftSquare: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftSquare, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftSquare(value)
  }
  }

  /// Returns a copy of the receiver with its `leftSquare` replaced.
  /// - param newChild: The new `leftSquare` to replace the node's
  ///                   current `leftSquare`, if present.
  public func withLeftSquare(
    _ newChild: TokenSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftSquare)
    return DictionaryExprSyntax(newData)
  }
  public var content: Syntax {
  get {
    let child = data.child(at: Cursor.content, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withContent(value)
  }
  }

  /// Returns a copy of the receiver with its `content` replaced.
  /// - param newChild: The new `content` to replace the node's
  ///                   current `content`, if present.
  public func withContent(
    _ newChild: Syntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.content)
    return DictionaryExprSyntax(newData)
  }
  public var rightSquare: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightSquare, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightSquare(value)
  }
  }

  /// Returns a copy of the receiver with its `rightSquare` replaced.
  /// - param newChild: The new `rightSquare` to replace the node's
  ///                   current `rightSquare`, if present.
  public func withRightSquare(
    _ newChild: TokenSyntax?) -> DictionaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightSquare)
    return DictionaryExprSyntax(newData)
  }

  /// Determines if two `DictionaryExprSyntax` nodes are equal to each other.
  public static func ==(lhs: DictionaryExprSyntax, rhs: DictionaryExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct FunctionCallArgumentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case label
    case colon
    case expression
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `FunctionCallArgumentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var label: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.label, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.label)
    return FunctionCallArgumentSyntax(newData)
  }
  public var colon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return FunctionCallArgumentSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> FunctionCallArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return FunctionCallArgumentSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return FunctionCallArgumentSyntax(newData)
  }

  /// Determines if two `FunctionCallArgumentSyntax` nodes are equal to each other.
  public static func ==(lhs: FunctionCallArgumentSyntax, rhs: FunctionCallArgumentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TupleElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case label
    case colon
    case expression
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `TupleElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var label: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.label, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> TupleElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.label)
    return TupleElementSyntax(newData)
  }
  public var colon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> TupleElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return TupleElementSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> TupleElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return TupleElementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> TupleElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return TupleElementSyntax(newData)
  }

  /// Determines if two `TupleElementSyntax` nodes are equal to each other.
  public static func ==(lhs: TupleElementSyntax, rhs: TupleElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ArrayElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case expression
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `ArrayElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> ArrayElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ArrayElementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> ArrayElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return ArrayElementSyntax(newData)
  }

  /// Determines if two `ArrayElementSyntax` nodes are equal to each other.
  public static func ==(lhs: ArrayElementSyntax, rhs: ArrayElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DictionaryElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case keyExpression
    case colon
    case valueExpression
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `DictionaryElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var keyExpression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.keyExpression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withKeyExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `keyExpression` replaced.
  /// - param newChild: The new `keyExpression` to replace the node's
  ///                   current `keyExpression`, if present.
  public func withKeyExpression(
    _ newChild: ExprSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.keyExpression)
    return DictionaryElementSyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return DictionaryElementSyntax(newData)
  }
  public var valueExpression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.valueExpression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withValueExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `valueExpression` replaced.
  /// - param newChild: The new `valueExpression` to replace the node's
  ///                   current `valueExpression`, if present.
  public func withValueExpression(
    _ newChild: ExprSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.valueExpression)
    return DictionaryElementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> DictionaryElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return DictionaryElementSyntax(newData)
  }

  /// Determines if two `DictionaryElementSyntax` nodes are equal to each other.
  public static func ==(lhs: DictionaryElementSyntax, rhs: DictionaryElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct IntegerLiteralExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case digits
  }

  let data: SyntaxData

  /// Creates a `IntegerLiteralExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var digits: TokenSyntax {
  get {
    let child = data.child(at: Cursor.digits, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDigits(value)
  }
  }

  /// Returns a copy of the receiver with its `digits` replaced.
  /// - param newChild: The new `digits` to replace the node's
  ///                   current `digits`, if present.
  public func withDigits(
    _ newChild: TokenSyntax?) -> IntegerLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.integerLiteral(""))
    let newData = data.replacingChild(raw, at: Cursor.digits)
    return IntegerLiteralExprSyntax(newData)
  }

  /// Determines if two `IntegerLiteralExprSyntax` nodes are equal to each other.
  public static func ==(lhs: IntegerLiteralExprSyntax, rhs: IntegerLiteralExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct StringLiteralExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case stringLiteral
  }

  let data: SyntaxData

  /// Creates a `StringLiteralExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var stringLiteral: TokenSyntax {
  get {
    let child = data.child(at: Cursor.stringLiteral, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withStringLiteral(value)
  }
  }

  /// Returns a copy of the receiver with its `stringLiteral` replaced.
  /// - param newChild: The new `stringLiteral` to replace the node's
  ///                   current `stringLiteral`, if present.
  public func withStringLiteral(
    _ newChild: TokenSyntax?) -> StringLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.stringLiteral(""))
    let newData = data.replacingChild(raw, at: Cursor.stringLiteral)
    return StringLiteralExprSyntax(newData)
  }

  /// Determines if two `StringLiteralExprSyntax` nodes are equal to each other.
  public static func ==(lhs: StringLiteralExprSyntax, rhs: StringLiteralExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct BooleanLiteralExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case booleanLiteral
  }

  let data: SyntaxData

  /// Creates a `BooleanLiteralExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var booleanLiteral: TokenSyntax {
  get {
    let child = data.child(at: Cursor.booleanLiteral, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withBooleanLiteral(value)
  }
  }

  /// Returns a copy of the receiver with its `booleanLiteral` replaced.
  /// - param newChild: The new `booleanLiteral` to replace the node's
  ///                   current `booleanLiteral`, if present.
  public func withBooleanLiteral(
    _ newChild: TokenSyntax?) -> BooleanLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.trueKeyword)
    let newData = data.replacingChild(raw, at: Cursor.booleanLiteral)
    return BooleanLiteralExprSyntax(newData)
  }

  /// Determines if two `BooleanLiteralExprSyntax` nodes are equal to each other.
  public static func ==(lhs: BooleanLiteralExprSyntax, rhs: BooleanLiteralExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TernaryExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case conditionExpression
    case questionMark
    case firstChoice
    case colonMark
    case secondChoice
  }

  let data: SyntaxData

  /// Creates a `TernaryExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var conditionExpression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.conditionExpression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withConditionExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `conditionExpression` replaced.
  /// - param newChild: The new `conditionExpression` to replace the node's
  ///                   current `conditionExpression`, if present.
  public func withConditionExpression(
    _ newChild: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.conditionExpression)
    return TernaryExprSyntax(newData)
  }
  public var questionMark: TokenSyntax {
  get {
    let child = data.child(at: Cursor.questionMark, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withQuestionMark(value)
  }
  }

  /// Returns a copy of the receiver with its `questionMark` replaced.
  /// - param newChild: The new `questionMark` to replace the node's
  ///                   current `questionMark`, if present.
  public func withQuestionMark(
    _ newChild: TokenSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.infixQuestionMark)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return TernaryExprSyntax(newData)
  }
  public var firstChoice: ExprSyntax {
  get {
    let child = data.child(at: Cursor.firstChoice, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withFirstChoice(value)
  }
  }

  /// Returns a copy of the receiver with its `firstChoice` replaced.
  /// - param newChild: The new `firstChoice` to replace the node's
  ///                   current `firstChoice`, if present.
  public func withFirstChoice(
    _ newChild: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.firstChoice)
    return TernaryExprSyntax(newData)
  }
  public var colonMark: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colonMark, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColonMark(value)
  }
  }

  /// Returns a copy of the receiver with its `colonMark` replaced.
  /// - param newChild: The new `colonMark` to replace the node's
  ///                   current `colonMark`, if present.
  public func withColonMark(
    _ newChild: TokenSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colonMark)
    return TernaryExprSyntax(newData)
  }
  public var secondChoice: ExprSyntax {
  get {
    let child = data.child(at: Cursor.secondChoice, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withSecondChoice(value)
  }
  }

  /// Returns a copy of the receiver with its `secondChoice` replaced.
  /// - param newChild: The new `secondChoice` to replace the node's
  ///                   current `secondChoice`, if present.
  public func withSecondChoice(
    _ newChild: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.secondChoice)
    return TernaryExprSyntax(newData)
  }

  /// Determines if two `TernaryExprSyntax` nodes are equal to each other.
  public static func ==(lhs: TernaryExprSyntax, rhs: TernaryExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct MemberAccessExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case base
    case dot
    case name
    case declNameArguments
  }

  let data: SyntaxData

  /// Creates a `MemberAccessExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var base: ExprSyntax? {
  get {
    let child = data.child(at: Cursor.base, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) as? ExprSyntax
  }
  set(value) {
    self = withBase(value)
  }
  }

  /// Returns a copy of the receiver with its `base` replaced.
  /// - param newChild: The new `base` to replace the node's
  ///                   current `base`, if present.
  public func withBase(
    _ newChild: ExprSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.base)
    return MemberAccessExprSyntax(newData)
  }
  public var dot: TokenSyntax {
  get {
    let child = data.child(at: Cursor.dot, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDot(value)
  }
  }

  /// Returns a copy of the receiver with its `dot` replaced.
  /// - param newChild: The new `dot` to replace the node's
  ///                   current `dot`, if present.
  public func withDot(
    _ newChild: TokenSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.dot)
    return MemberAccessExprSyntax(newData)
  }
  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return MemberAccessExprSyntax(newData)
  }
  public var declNameArguments: DeclNameArgumentsSyntax? {
  get {
    let child = data.child(at: Cursor.declNameArguments, parent: self)
    if child == nil { return nil }
    return DeclNameArgumentsSyntax(child!)
  }
  set(value) {
    self = withDeclNameArguments(value)
  }
  }

  /// Returns a copy of the receiver with its `declNameArguments` replaced.
  /// - param newChild: The new `declNameArguments` to replace the node's
  ///                   current `declNameArguments`, if present.
  public func withDeclNameArguments(
    _ newChild: DeclNameArgumentsSyntax?) -> MemberAccessExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.declNameArguments)
    return MemberAccessExprSyntax(newData)
  }

  /// Determines if two `MemberAccessExprSyntax` nodes are equal to each other.
  public static func ==(lhs: MemberAccessExprSyntax, rhs: MemberAccessExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct IsExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case isTok
    case typeName
  }

  let data: SyntaxData

  /// Creates a `IsExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var isTok: TokenSyntax {
  get {
    let child = data.child(at: Cursor.isTok, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIsTok(value)
  }
  }

  /// Returns a copy of the receiver with its `isTok` replaced.
  /// - param newChild: The new `isTok` to replace the node's
  ///                   current `isTok`, if present.
  public func withIsTok(
    _ newChild: TokenSyntax?) -> IsExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.isKeyword)
    let newData = data.replacingChild(raw, at: Cursor.isTok)
    return IsExprSyntax(newData)
  }
  public var typeName: TypeSyntax {
  get {
    let child = data.child(at: Cursor.typeName, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withTypeName(value)
  }
  }

  /// Returns a copy of the receiver with its `typeName` replaced.
  /// - param newChild: The new `typeName` to replace the node's
  ///                   current `typeName`, if present.
  public func withTypeName(
    _ newChild: TypeSyntax?) -> IsExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return IsExprSyntax(newData)
  }

  /// Determines if two `IsExprSyntax` nodes are equal to each other.
  public static func ==(lhs: IsExprSyntax, rhs: IsExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AsExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case asTok
    case questionOrExclamationMark
    case typeName
  }

  let data: SyntaxData

  /// Creates a `AsExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var asTok: TokenSyntax {
  get {
    let child = data.child(at: Cursor.asTok, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAsTok(value)
  }
  }

  /// Returns a copy of the receiver with its `asTok` replaced.
  /// - param newChild: The new `asTok` to replace the node's
  ///                   current `asTok`, if present.
  public func withAsTok(
    _ newChild: TokenSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.asKeyword)
    let newData = data.replacingChild(raw, at: Cursor.asTok)
    return AsExprSyntax(newData)
  }
  public var questionOrExclamationMark: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.questionOrExclamationMark, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withQuestionOrExclamationMark(value)
  }
  }

  /// Returns a copy of the receiver with its `questionOrExclamationMark` replaced.
  /// - param newChild: The new `questionOrExclamationMark` to replace the node's
  ///                   current `questionOrExclamationMark`, if present.
  public func withQuestionOrExclamationMark(
    _ newChild: TokenSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.questionOrExclamationMark)
    return AsExprSyntax(newData)
  }
  public var typeName: TypeSyntax {
  get {
    let child = data.child(at: Cursor.typeName, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withTypeName(value)
  }
  }

  /// Returns a copy of the receiver with its `typeName` replaced.
  /// - param newChild: The new `typeName` to replace the node's
  ///                   current `typeName`, if present.
  public func withTypeName(
    _ newChild: TypeSyntax?) -> AsExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return AsExprSyntax(newData)
  }

  /// Determines if two `AsExprSyntax` nodes are equal to each other.
  public static func ==(lhs: AsExprSyntax, rhs: AsExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TypeExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case type
  }

  let data: SyntaxData

  /// Creates a `TypeExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var type: TypeSyntax {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: TypeSyntax?) -> TypeExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return TypeExprSyntax(newData)
  }

  /// Determines if two `TypeExprSyntax` nodes are equal to each other.
  public static func ==(lhs: TypeExprSyntax, rhs: TypeExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ClosureCaptureItemSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case specifier
    case name
    case assignToken
    case expression
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `ClosureCaptureItemSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var specifier: TokenListSyntax? {
  get {
    let child = data.child(at: Cursor.specifier, parent: self)
    if child == nil { return nil }
    return TokenListSyntax(child!)
  }
  set(value) {
    self = withSpecifier(value)
  }
  }

  /// Adds the provided `Token` to the node's `specifier`
  /// collection.
  /// - param element: The new `Token` to add to the node's
  ///                  `specifier` collection.
  /// - returns: A copy of the receiver with the provided `Token`
  ///            appended to its `specifier` collection.
  public func addToken(_ element: TokenSyntax) -> ClosureCaptureItemSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.specifier] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tokenList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.specifier)
    return ClosureCaptureItemSyntax(newData)
  }

  /// Returns a copy of the receiver with its `specifier` replaced.
  /// - param newChild: The new `specifier` to replace the node's
  ///                   current `specifier`, if present.
  public func withSpecifier(
    _ newChild: TokenListSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.specifier)
    return ClosureCaptureItemSyntax(newData)
  }
  public var name: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ClosureCaptureItemSyntax(newData)
  }
  public var assignToken: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.assignToken, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAssignToken(value)
  }
  }

  /// Returns a copy of the receiver with its `assignToken` replaced.
  /// - param newChild: The new `assignToken` to replace the node's
  ///                   current `assignToken`, if present.
  public func withAssignToken(
    _ newChild: TokenSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.assignToken)
    return ClosureCaptureItemSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ClosureCaptureItemSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> ClosureCaptureItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return ClosureCaptureItemSyntax(newData)
  }

  /// Determines if two `ClosureCaptureItemSyntax` nodes are equal to each other.
  public static func ==(lhs: ClosureCaptureItemSyntax, rhs: ClosureCaptureItemSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ClosureCaptureSignatureSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftSquare
    case items
    case rightSquare
  }

  let data: SyntaxData

  /// Creates a `ClosureCaptureSignatureSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftSquare: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftSquare, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftSquare(value)
  }
  }

  /// Returns a copy of the receiver with its `leftSquare` replaced.
  /// - param newChild: The new `leftSquare` to replace the node's
  ///                   current `leftSquare`, if present.
  public func withLeftSquare(
    _ newChild: TokenSyntax?) -> ClosureCaptureSignatureSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftSquare)
    return ClosureCaptureSignatureSyntax(newData)
  }
  public var items: ClosureCaptureItemListSyntax? {
  get {
    let child = data.child(at: Cursor.items, parent: self)
    if child == nil { return nil }
    return ClosureCaptureItemListSyntax(child!)
  }
  set(value) {
    self = withItems(value)
  }
  }

  /// Adds the provided `ClosureCaptureItem` to the node's `items`
  /// collection.
  /// - param element: The new `ClosureCaptureItem` to add to the node's
  ///                  `items` collection.
  /// - returns: A copy of the receiver with the provided `ClosureCaptureItem`
  ///            appended to its `items` collection.
  public func addClosureCaptureItem(_ element: ClosureCaptureItemSyntax) -> ClosureCaptureSignatureSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.items] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.closureCaptureItemList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.items)
    return ClosureCaptureSignatureSyntax(newData)
  }

  /// Returns a copy of the receiver with its `items` replaced.
  /// - param newChild: The new `items` to replace the node's
  ///                   current `items`, if present.
  public func withItems(
    _ newChild: ClosureCaptureItemListSyntax?) -> ClosureCaptureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.items)
    return ClosureCaptureSignatureSyntax(newData)
  }
  public var rightSquare: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightSquare, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightSquare(value)
  }
  }

  /// Returns a copy of the receiver with its `rightSquare` replaced.
  /// - param newChild: The new `rightSquare` to replace the node's
  ///                   current `rightSquare`, if present.
  public func withRightSquare(
    _ newChild: TokenSyntax?) -> ClosureCaptureSignatureSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightSquare)
    return ClosureCaptureSignatureSyntax(newData)
  }

  /// Determines if two `ClosureCaptureSignatureSyntax` nodes are equal to each other.
  public static func ==(lhs: ClosureCaptureSignatureSyntax, rhs: ClosureCaptureSignatureSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ClosureParamSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `ClosureParamSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> ClosureParamSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ClosureParamSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> ClosureParamSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return ClosureParamSyntax(newData)
  }

  /// Determines if two `ClosureParamSyntax` nodes are equal to each other.
  public static func ==(lhs: ClosureParamSyntax, rhs: ClosureParamSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ClosureSignatureSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case capture
    case input
    case throwsTok
    case output
    case inTok
  }

  let data: SyntaxData

  /// Creates a `ClosureSignatureSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var capture: ClosureCaptureSignatureSyntax? {
  get {
    let child = data.child(at: Cursor.capture, parent: self)
    if child == nil { return nil }
    return ClosureCaptureSignatureSyntax(child!)
  }
  set(value) {
    self = withCapture(value)
  }
  }

  /// Returns a copy of the receiver with its `capture` replaced.
  /// - param newChild: The new `capture` to replace the node's
  ///                   current `capture`, if present.
  public func withCapture(
    _ newChild: ClosureCaptureSignatureSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.capture)
    return ClosureSignatureSyntax(newData)
  }
  public var input: Syntax? {
  get {
    let child = data.child(at: Cursor.input, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) 
  }
  set(value) {
    self = withInput(value)
  }
  }

  /// Returns a copy of the receiver with its `input` replaced.
  /// - param newChild: The new `input` to replace the node's
  ///                   current `input`, if present.
  public func withInput(
    _ newChild: Syntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.input)
    return ClosureSignatureSyntax(newData)
  }
  public var throwsTok: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.throwsTok, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withThrowsTok(value)
  }
  }

  /// Returns a copy of the receiver with its `throwsTok` replaced.
  /// - param newChild: The new `throwsTok` to replace the node's
  ///                   current `throwsTok`, if present.
  public func withThrowsTok(
    _ newChild: TokenSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.throwsTok)
    return ClosureSignatureSyntax(newData)
  }
  public var output: ReturnClauseSyntax? {
  get {
    let child = data.child(at: Cursor.output, parent: self)
    if child == nil { return nil }
    return ReturnClauseSyntax(child!)
  }
  set(value) {
    self = withOutput(value)
  }
  }

  /// Returns a copy of the receiver with its `output` replaced.
  /// - param newChild: The new `output` to replace the node's
  ///                   current `output`, if present.
  public func withOutput(
    _ newChild: ReturnClauseSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.output)
    return ClosureSignatureSyntax(newData)
  }
  public var inTok: TokenSyntax {
  get {
    let child = data.child(at: Cursor.inTok, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withInTok(value)
  }
  }

  /// Returns a copy of the receiver with its `inTok` replaced.
  /// - param newChild: The new `inTok` to replace the node's
  ///                   current `inTok`, if present.
  public func withInTok(
    _ newChild: TokenSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.inKeyword)
    let newData = data.replacingChild(raw, at: Cursor.inTok)
    return ClosureSignatureSyntax(newData)
  }

  /// Determines if two `ClosureSignatureSyntax` nodes are equal to each other.
  public static func ==(lhs: ClosureSignatureSyntax, rhs: ClosureSignatureSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ClosureExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftBrace
    case signature
    case statements
    case rightBrace
  }

  let data: SyntaxData

  /// Creates a `ClosureExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `leftBrace` replaced.
  /// - param newChild: The new `leftBrace` to replace the node's
  ///                   current `leftBrace`, if present.
  public func withLeftBrace(
    _ newChild: TokenSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return ClosureExprSyntax(newData)
  }
  public var signature: ClosureSignatureSyntax? {
  get {
    let child = data.child(at: Cursor.signature, parent: self)
    if child == nil { return nil }
    return ClosureSignatureSyntax(child!)
  }
  set(value) {
    self = withSignature(value)
  }
  }

  /// Returns a copy of the receiver with its `signature` replaced.
  /// - param newChild: The new `signature` to replace the node's
  ///                   current `signature`, if present.
  public func withSignature(
    _ newChild: ClosureSignatureSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.signature)
    return ClosureExprSyntax(newData)
  }
  public var statements: CodeBlockItemListSyntax {
  get {
    let child = data.child(at: Cursor.statements, parent: self)
    return CodeBlockItemListSyntax(child!)
  }
  set(value) {
    self = withStatements(value)
  }
  }

  /// Adds the provided `CodeBlockItem` to the node's `statements`
  /// collection.
  /// - param element: The new `CodeBlockItem` to add to the node's
  ///                  `statements` collection.
  /// - returns: A copy of the receiver with the provided `CodeBlockItem`
  ///            appended to its `statements` collection.
  public func addCodeBlockItem(_ element: CodeBlockItemSyntax) -> ClosureExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.statements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.statements)
    return ClosureExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `statements` replaced.
  /// - param newChild: The new `statements` to replace the node's
  ///                   current `statements`, if present.
  public func withStatements(
    _ newChild: CodeBlockItemListSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlockItemList)
    let newData = data.replacingChild(raw, at: Cursor.statements)
    return ClosureExprSyntax(newData)
  }
  public var rightBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `rightBrace` replaced.
  /// - param newChild: The new `rightBrace` to replace the node's
  ///                   current `rightBrace`, if present.
  public func withRightBrace(
    _ newChild: TokenSyntax?) -> ClosureExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return ClosureExprSyntax(newData)
  }

  /// Determines if two `ClosureExprSyntax` nodes are equal to each other.
  public static func ==(lhs: ClosureExprSyntax, rhs: ClosureExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct UnresolvedPatternExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case pattern
  }

  let data: SyntaxData

  /// Creates a `UnresolvedPatternExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var pattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> UnresolvedPatternExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return UnresolvedPatternExprSyntax(newData)
  }

  /// Determines if two `UnresolvedPatternExprSyntax` nodes are equal to each other.
  public static func ==(lhs: UnresolvedPatternExprSyntax, rhs: UnresolvedPatternExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct FunctionCallExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case calledExpression
    case leftParen
    case argumentList
    case rightParen
    case trailingClosure
  }

  let data: SyntaxData

  /// Creates a `FunctionCallExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var calledExpression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.calledExpression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withCalledExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `calledExpression` replaced.
  /// - param newChild: The new `calledExpression` to replace the node's
  ///                   current `calledExpression`, if present.
  public func withCalledExpression(
    _ newChild: ExprSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.calledExpression)
    return FunctionCallExprSyntax(newData)
  }
  public var leftParen: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return FunctionCallExprSyntax(newData)
  }
  public var argumentList: FunctionCallArgumentListSyntax {
  get {
    let child = data.child(at: Cursor.argumentList, parent: self)
    return FunctionCallArgumentListSyntax(child!)
  }
  set(value) {
    self = withArgumentList(value)
  }
  }

  /// Adds the provided `FunctionCallArgument` to the node's `argumentList`
  /// collection.
  /// - param element: The new `FunctionCallArgument` to add to the node's
  ///                  `argumentList` collection.
  /// - returns: A copy of the receiver with the provided `FunctionCallArgument`
  ///            appended to its `argumentList` collection.
  public func addFunctionCallArgument(_ element: FunctionCallArgumentSyntax) -> FunctionCallExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.argumentList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.functionCallArgumentList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.argumentList)
    return FunctionCallExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `argumentList` replaced.
  /// - param newChild: The new `argumentList` to replace the node's
  ///                   current `argumentList`, if present.
  public func withArgumentList(
    _ newChild: FunctionCallArgumentListSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.functionCallArgumentList)
    let newData = data.replacingChild(raw, at: Cursor.argumentList)
    return FunctionCallExprSyntax(newData)
  }
  public var rightParen: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return FunctionCallExprSyntax(newData)
  }
  public var trailingClosure: ClosureExprSyntax? {
  get {
    let child = data.child(at: Cursor.trailingClosure, parent: self)
    if child == nil { return nil }
    return ClosureExprSyntax(child!)
  }
  set(value) {
    self = withTrailingClosure(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingClosure` replaced.
  /// - param newChild: The new `trailingClosure` to replace the node's
  ///                   current `trailingClosure`, if present.
  public func withTrailingClosure(
    _ newChild: ClosureExprSyntax?) -> FunctionCallExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingClosure)
    return FunctionCallExprSyntax(newData)
  }

  /// Determines if two `FunctionCallExprSyntax` nodes are equal to each other.
  public static func ==(lhs: FunctionCallExprSyntax, rhs: FunctionCallExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SubscriptExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case calledExpression
    case leftBracket
    case argumentList
    case rightBracket
    case trailingClosure
  }

  let data: SyntaxData

  /// Creates a `SubscriptExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var calledExpression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.calledExpression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withCalledExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `calledExpression` replaced.
  /// - param newChild: The new `calledExpression` to replace the node's
  ///                   current `calledExpression`, if present.
  public func withCalledExpression(
    _ newChild: ExprSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.calledExpression)
    return SubscriptExprSyntax(newData)
  }
  public var leftBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `leftBracket` replaced.
  /// - param newChild: The new `leftBracket` to replace the node's
  ///                   current `leftBracket`, if present.
  public func withLeftBracket(
    _ newChild: TokenSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftBracket)
    return SubscriptExprSyntax(newData)
  }
  public var argumentList: FunctionCallArgumentListSyntax {
  get {
    let child = data.child(at: Cursor.argumentList, parent: self)
    return FunctionCallArgumentListSyntax(child!)
  }
  set(value) {
    self = withArgumentList(value)
  }
  }

  /// Adds the provided `FunctionCallArgument` to the node's `argumentList`
  /// collection.
  /// - param element: The new `FunctionCallArgument` to add to the node's
  ///                  `argumentList` collection.
  /// - returns: A copy of the receiver with the provided `FunctionCallArgument`
  ///            appended to its `argumentList` collection.
  public func addFunctionCallArgument(_ element: FunctionCallArgumentSyntax) -> SubscriptExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.argumentList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.functionCallArgumentList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.argumentList)
    return SubscriptExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `argumentList` replaced.
  /// - param newChild: The new `argumentList` to replace the node's
  ///                   current `argumentList`, if present.
  public func withArgumentList(
    _ newChild: FunctionCallArgumentListSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.functionCallArgumentList)
    let newData = data.replacingChild(raw, at: Cursor.argumentList)
    return SubscriptExprSyntax(newData)
  }
  public var rightBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `rightBracket` replaced.
  /// - param newChild: The new `rightBracket` to replace the node's
  ///                   current `rightBracket`, if present.
  public func withRightBracket(
    _ newChild: TokenSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightBracket)
    return SubscriptExprSyntax(newData)
  }
  public var trailingClosure: ClosureExprSyntax? {
  get {
    let child = data.child(at: Cursor.trailingClosure, parent: self)
    if child == nil { return nil }
    return ClosureExprSyntax(child!)
  }
  set(value) {
    self = withTrailingClosure(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingClosure` replaced.
  /// - param newChild: The new `trailingClosure` to replace the node's
  ///                   current `trailingClosure`, if present.
  public func withTrailingClosure(
    _ newChild: ClosureExprSyntax?) -> SubscriptExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingClosure)
    return SubscriptExprSyntax(newData)
  }

  /// Determines if two `SubscriptExprSyntax` nodes are equal to each other.
  public static func ==(lhs: SubscriptExprSyntax, rhs: SubscriptExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct OptionalChainingExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case expression
    case questionMark
  }

  let data: SyntaxData

  /// Creates a `OptionalChainingExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return OptionalChainingExprSyntax(newData)
  }
  public var questionMark: TokenSyntax {
  get {
    let child = data.child(at: Cursor.questionMark, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withQuestionMark(value)
  }
  }

  /// Returns a copy of the receiver with its `questionMark` replaced.
  /// - param newChild: The new `questionMark` to replace the node's
  ///                   current `questionMark`, if present.
  public func withQuestionMark(
    _ newChild: TokenSyntax?) -> OptionalChainingExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return OptionalChainingExprSyntax(newData)
  }

  /// Determines if two `OptionalChainingExprSyntax` nodes are equal to each other.
  public static func ==(lhs: OptionalChainingExprSyntax, rhs: OptionalChainingExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ForcedValueExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case expression
    case exclamationMark
  }

  let data: SyntaxData

  /// Creates a `ForcedValueExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ForcedValueExprSyntax(newData)
  }
  public var exclamationMark: TokenSyntax {
  get {
    let child = data.child(at: Cursor.exclamationMark, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withExclamationMark(value)
  }
  }

  /// Returns a copy of the receiver with its `exclamationMark` replaced.
  /// - param newChild: The new `exclamationMark` to replace the node's
  ///                   current `exclamationMark`, if present.
  public func withExclamationMark(
    _ newChild: TokenSyntax?) -> ForcedValueExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.exclamationMark)
    let newData = data.replacingChild(raw, at: Cursor.exclamationMark)
    return ForcedValueExprSyntax(newData)
  }

  /// Determines if two `ForcedValueExprSyntax` nodes are equal to each other.
  public static func ==(lhs: ForcedValueExprSyntax, rhs: ForcedValueExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PostfixUnaryExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case expression
    case operatorToken
  }

  let data: SyntaxData

  /// Creates a `PostfixUnaryExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return PostfixUnaryExprSyntax(newData)
  }
  public var operatorToken: TokenSyntax {
  get {
    let child = data.child(at: Cursor.operatorToken, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withOperatorToken(value)
  }
  }

  /// Returns a copy of the receiver with its `operatorToken` replaced.
  /// - param newChild: The new `operatorToken` to replace the node's
  ///                   current `operatorToken`, if present.
  public func withOperatorToken(
    _ newChild: TokenSyntax?) -> PostfixUnaryExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.postfixOperator(""))
    let newData = data.replacingChild(raw, at: Cursor.operatorToken)
    return PostfixUnaryExprSyntax(newData)
  }

  /// Determines if two `PostfixUnaryExprSyntax` nodes are equal to each other.
  public static func ==(lhs: PostfixUnaryExprSyntax, rhs: PostfixUnaryExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SpecializeExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case expression
    case genericArgumentClause
  }

  let data: SyntaxData

  /// Creates a `SpecializeExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return SpecializeExprSyntax(newData)
  }
  public var genericArgumentClause: GenericArgumentClauseSyntax {
  get {
    let child = data.child(at: Cursor.genericArgumentClause, parent: self)
    return GenericArgumentClauseSyntax(child!)
  }
  set(value) {
    self = withGenericArgumentClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericArgumentClause` replaced.
  /// - param newChild: The new `genericArgumentClause` to replace the node's
  ///                   current `genericArgumentClause`, if present.
  public func withGenericArgumentClause(
    _ newChild: GenericArgumentClauseSyntax?) -> SpecializeExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentClause)
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return SpecializeExprSyntax(newData)
  }

  /// Determines if two `SpecializeExprSyntax` nodes are equal to each other.
  public static func ==(lhs: SpecializeExprSyntax, rhs: SpecializeExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct StringSegmentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case content
  }

  let data: SyntaxData

  /// Creates a `StringSegmentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var content: TokenSyntax {
  get {
    let child = data.child(at: Cursor.content, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withContent(value)
  }
  }

  /// Returns a copy of the receiver with its `content` replaced.
  /// - param newChild: The new `content` to replace the node's
  ///                   current `content`, if present.
  public func withContent(
    _ newChild: TokenSyntax?) -> StringSegmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.stringSegment(""))
    let newData = data.replacingChild(raw, at: Cursor.content)
    return StringSegmentSyntax(newData)
  }

  /// Determines if two `StringSegmentSyntax` nodes are equal to each other.
  public static func ==(lhs: StringSegmentSyntax, rhs: StringSegmentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ExpressionSegmentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case backslash
    case leftParen
    case expression
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `ExpressionSegmentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var backslash: TokenSyntax {
  get {
    let child = data.child(at: Cursor.backslash, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withBackslash(value)
  }
  }

  /// Returns a copy of the receiver with its `backslash` replaced.
  /// - param newChild: The new `backslash` to replace the node's
  ///                   current `backslash`, if present.
  public func withBackslash(
    _ newChild: TokenSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.backslash)
    let newData = data.replacingChild(raw, at: Cursor.backslash)
    return ExpressionSegmentSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ExpressionSegmentSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ExpressionSegmentSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.stringInterpolationAnchor)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ExpressionSegmentSyntax(newData)
  }

  /// Determines if two `ExpressionSegmentSyntax` nodes are equal to each other.
  public static func ==(lhs: ExpressionSegmentSyntax, rhs: ExpressionSegmentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct StringInterpolationExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case openQuote
    case segments
    case closeQuote
  }

  let data: SyntaxData

  /// Creates a `StringInterpolationExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var openQuote: TokenSyntax {
  get {
    let child = data.child(at: Cursor.openQuote, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withOpenQuote(value)
  }
  }

  /// Returns a copy of the receiver with its `openQuote` replaced.
  /// - param newChild: The new `openQuote` to replace the node's
  ///                   current `openQuote`, if present.
  public func withOpenQuote(
    _ newChild: TokenSyntax?) -> StringInterpolationExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.stringQuote)
    let newData = data.replacingChild(raw, at: Cursor.openQuote)
    return StringInterpolationExprSyntax(newData)
  }
  public var segments: StringInterpolationSegmentsSyntax {
  get {
    let child = data.child(at: Cursor.segments, parent: self)
    return StringInterpolationSegmentsSyntax(child!)
  }
  set(value) {
    self = withSegments(value)
  }
  }

  /// Adds the provided `Segment` to the node's `segments`
  /// collection.
  /// - param element: The new `Segment` to add to the node's
  ///                  `segments` collection.
  /// - returns: A copy of the receiver with the provided `Segment`
  ///            appended to its `segments` collection.
  public func addSegment(_ element: Syntax) -> StringInterpolationExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.segments] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.stringInterpolationSegments,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.segments)
    return StringInterpolationExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `segments` replaced.
  /// - param newChild: The new `segments` to replace the node's
  ///                   current `segments`, if present.
  public func withSegments(
    _ newChild: StringInterpolationSegmentsSyntax?) -> StringInterpolationExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.stringInterpolationSegments)
    let newData = data.replacingChild(raw, at: Cursor.segments)
    return StringInterpolationExprSyntax(newData)
  }
  public var closeQuote: TokenSyntax {
  get {
    let child = data.child(at: Cursor.closeQuote, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withCloseQuote(value)
  }
  }

  /// Returns a copy of the receiver with its `closeQuote` replaced.
  /// - param newChild: The new `closeQuote` to replace the node's
  ///                   current `closeQuote`, if present.
  public func withCloseQuote(
    _ newChild: TokenSyntax?) -> StringInterpolationExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.stringQuote)
    let newData = data.replacingChild(raw, at: Cursor.closeQuote)
    return StringInterpolationExprSyntax(newData)
  }

  /// Determines if two `StringInterpolationExprSyntax` nodes are equal to each other.
  public static func ==(lhs: StringInterpolationExprSyntax, rhs: StringInterpolationExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct KeyPathExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case backslash
    case rootExpr
    case expression
  }

  let data: SyntaxData

  /// Creates a `KeyPathExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var backslash: TokenSyntax {
  get {
    let child = data.child(at: Cursor.backslash, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withBackslash(value)
  }
  }

  /// Returns a copy of the receiver with its `backslash` replaced.
  /// - param newChild: The new `backslash` to replace the node's
  ///                   current `backslash`, if present.
  public func withBackslash(
    _ newChild: TokenSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.backslash)
    let newData = data.replacingChild(raw, at: Cursor.backslash)
    return KeyPathExprSyntax(newData)
  }
  public var rootExpr: ExprSyntax? {
  get {
    let child = data.child(at: Cursor.rootExpr, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) as? ExprSyntax
  }
  set(value) {
    self = withRootExpr(value)
  }
  }

  /// Returns a copy of the receiver with its `rootExpr` replaced.
  /// - param newChild: The new `rootExpr` to replace the node's
  ///                   current `rootExpr`, if present.
  public func withRootExpr(
    _ newChild: ExprSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.rootExpr)
    return KeyPathExprSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> KeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return KeyPathExprSyntax(newData)
  }

  /// Determines if two `KeyPathExprSyntax` nodes are equal to each other.
  public static func ==(lhs: KeyPathExprSyntax, rhs: KeyPathExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct KeyPathBaseExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case period
  }

  let data: SyntaxData

  /// Creates a `KeyPathBaseExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var period: TokenSyntax {
  get {
    let child = data.child(at: Cursor.period, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPeriod(value)
  }
  }

  /// Returns a copy of the receiver with its `period` replaced.
  /// - param newChild: The new `period` to replace the node's
  ///                   current `period`, if present.
  public func withPeriod(
    _ newChild: TokenSyntax?) -> KeyPathBaseExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return KeyPathBaseExprSyntax(newData)
  }

  /// Determines if two `KeyPathBaseExprSyntax` nodes are equal to each other.
  public static func ==(lhs: KeyPathBaseExprSyntax, rhs: KeyPathBaseExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ObjcNamePieceSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case dot
  }

  let data: SyntaxData

  /// Creates a `ObjcNamePieceSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> ObjcNamePieceSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ObjcNamePieceSyntax(newData)
  }
  public var dot: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.dot, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDot(value)
  }
  }

  /// Returns a copy of the receiver with its `dot` replaced.
  /// - param newChild: The new `dot` to replace the node's
  ///                   current `dot`, if present.
  public func withDot(
    _ newChild: TokenSyntax?) -> ObjcNamePieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.dot)
    return ObjcNamePieceSyntax(newData)
  }

  /// Determines if two `ObjcNamePieceSyntax` nodes are equal to each other.
  public static func ==(lhs: ObjcNamePieceSyntax, rhs: ObjcNamePieceSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ObjcKeyPathExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case keyPath
    case leftParen
    case name
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `ObjcKeyPathExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var keyPath: TokenSyntax {
  get {
    let child = data.child(at: Cursor.keyPath, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withKeyPath(value)
  }
  }

  /// Returns a copy of the receiver with its `keyPath` replaced.
  /// - param newChild: The new `keyPath` to replace the node's
  ///                   current `keyPath`, if present.
  public func withKeyPath(
    _ newChild: TokenSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundKeyPathKeyword)
    let newData = data.replacingChild(raw, at: Cursor.keyPath)
    return ObjcKeyPathExprSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjcKeyPathExprSyntax(newData)
  }
  public var name: ObjcNameSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return ObjcNameSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Adds the provided `ObjcNamePiece` to the node's `name`
  /// collection.
  /// - param element: The new `ObjcNamePiece` to add to the node's
  ///                  `name` collection.
  /// - returns: A copy of the receiver with the provided `ObjcNamePiece`
  ///            appended to its `name` collection.
  public func addObjcNamePiece(_ element: ObjcNamePieceSyntax) -> ObjcKeyPathExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.name] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.objcName,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.name)
    return ObjcKeyPathExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: ObjcNameSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.objcName)
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ObjcKeyPathExprSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> ObjcKeyPathExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjcKeyPathExprSyntax(newData)
  }

  /// Determines if two `ObjcKeyPathExprSyntax` nodes are equal to each other.
  public static func ==(lhs: ObjcKeyPathExprSyntax, rhs: ObjcKeyPathExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ObjcSelectorExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundSelector
    case leftParen
    case kind
    case colon
    case name
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `ObjcSelectorExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundSelector: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundSelector, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundSelector(value)
  }
  }

  /// Returns a copy of the receiver with its `poundSelector` replaced.
  /// - param newChild: The new `poundSelector` to replace the node's
  ///                   current `poundSelector`, if present.
  public func withPoundSelector(
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundSelectorKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundSelector)
    return ObjcSelectorExprSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjcSelectorExprSyntax(newData)
  }
  public var kind: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.kind, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withKind(value)
  }
  }

  /// Returns a copy of the receiver with its `kind` replaced.
  /// - param newChild: The new `kind` to replace the node's
  ///                   current `kind`, if present.
  public func withKind(
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.kind)
    return ObjcSelectorExprSyntax(newData)
  }
  public var colon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return ObjcSelectorExprSyntax(newData)
  }
  public var name: ExprSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: ExprSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ObjcSelectorExprSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> ObjcSelectorExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjcSelectorExprSyntax(newData)
  }

  /// Determines if two `ObjcSelectorExprSyntax` nodes are equal to each other.
  public static func ==(lhs: ObjcSelectorExprSyntax, rhs: ObjcSelectorExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct EditorPlaceholderExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case identifier
  }

  let data: SyntaxData

  /// Creates a `EditorPlaceholderExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> EditorPlaceholderExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return EditorPlaceholderExprSyntax(newData)
  }

  /// Determines if two `EditorPlaceholderExprSyntax` nodes are equal to each other.
  public static func ==(lhs: EditorPlaceholderExprSyntax, rhs: EditorPlaceholderExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ObjectLiteralExprSyntax: ExprSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case identifier
    case leftParen
    case arguments
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `ObjectLiteralExprSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundColorLiteralKeyword)
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ObjectLiteralExprSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ObjectLiteralExprSyntax(newData)
  }
  public var arguments: FunctionCallArgumentListSyntax {
  get {
    let child = data.child(at: Cursor.arguments, parent: self)
    return FunctionCallArgumentListSyntax(child!)
  }
  set(value) {
    self = withArguments(value)
  }
  }

  /// Adds the provided `FunctionCallArgument` to the node's `arguments`
  /// collection.
  /// - param element: The new `FunctionCallArgument` to add to the node's
  ///                  `arguments` collection.
  /// - returns: A copy of the receiver with the provided `FunctionCallArgument`
  ///            appended to its `arguments` collection.
  public func addFunctionCallArgument(_ element: FunctionCallArgumentSyntax) -> ObjectLiteralExprSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.arguments] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.functionCallArgumentList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.arguments)
    return ObjectLiteralExprSyntax(newData)
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: FunctionCallArgumentListSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.functionCallArgumentList)
    let newData = data.replacingChild(raw, at: Cursor.arguments)
    return ObjectLiteralExprSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> ObjectLiteralExprSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ObjectLiteralExprSyntax(newData)
  }

  /// Determines if two `ObjectLiteralExprSyntax` nodes are equal to each other.
  public static func ==(lhs: ObjectLiteralExprSyntax, rhs: ObjectLiteralExprSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TypeInitializerClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case equal
    case value
  }

  let data: SyntaxData

  /// Creates a `TypeInitializerClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var equal: TokenSyntax {
  get {
    let child = data.child(at: Cursor.equal, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withEqual(value)
  }
  }

  /// Returns a copy of the receiver with its `equal` replaced.
  /// - param newChild: The new `equal` to replace the node's
  ///                   current `equal`, if present.
  public func withEqual(
    _ newChild: TokenSyntax?) -> TypeInitializerClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.equal)
    let newData = data.replacingChild(raw, at: Cursor.equal)
    return TypeInitializerClauseSyntax(newData)
  }
  public var value: TypeSyntax {
  get {
    let child = data.child(at: Cursor.value, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withValue(value)
  }
  }

  /// Returns a copy of the receiver with its `value` replaced.
  /// - param newChild: The new `value` to replace the node's
  ///                   current `value`, if present.
  public func withValue(
    _ newChild: TypeSyntax?) -> TypeInitializerClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.value)
    return TypeInitializerClauseSyntax(newData)
  }

  /// Determines if two `TypeInitializerClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: TypeInitializerClauseSyntax, rhs: TypeInitializerClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TypealiasDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case typealiasKeyword
    case identifier
    case genericParameterClause
    case initializer
    case genericWhereClause
  }

  let data: SyntaxData

  /// Creates a `TypealiasDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> TypealiasDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return TypealiasDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return TypealiasDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> TypealiasDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return TypealiasDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return TypealiasDeclSyntax(newData)
  }
  public var typealiasKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.typealiasKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTypealiasKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `typealiasKeyword` replaced.
  /// - param newChild: The new `typealiasKeyword` to replace the node's
  ///                   current `typealiasKeyword`, if present.
  public func withTypealiasKeyword(
    _ newChild: TokenSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.typealiasKeyword)
    let newData = data.replacingChild(raw, at: Cursor.typealiasKeyword)
    return TypealiasDeclSyntax(newData)
  }
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return TypealiasDeclSyntax(newData)
  }
  public var genericParameterClause: GenericParameterClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericParameterClause, parent: self)
    if child == nil { return nil }
    return GenericParameterClauseSyntax(child!)
  }
  set(value) {
    self = withGenericParameterClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return TypealiasDeclSyntax(newData)
  }
  public var initializer: TypeInitializerClauseSyntax? {
  get {
    let child = data.child(at: Cursor.initializer, parent: self)
    if child == nil { return nil }
    return TypeInitializerClauseSyntax(child!)
  }
  set(value) {
    self = withInitializer(value)
  }
  }

  /// Returns a copy of the receiver with its `initializer` replaced.
  /// - param newChild: The new `initializer` to replace the node's
  ///                   current `initializer`, if present.
  public func withInitializer(
    _ newChild: TypeInitializerClauseSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return TypealiasDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> TypealiasDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return TypealiasDeclSyntax(newData)
  }

  /// Determines if two `TypealiasDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: TypealiasDeclSyntax, rhs: TypealiasDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AssociatedtypeDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case associatedtypeKeyword
    case identifier
    case inheritanceClause
    case initializer
    case genericWhereClause
  }

  let data: SyntaxData

  /// Creates a `AssociatedtypeDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> AssociatedtypeDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return AssociatedtypeDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return AssociatedtypeDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> AssociatedtypeDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return AssociatedtypeDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return AssociatedtypeDeclSyntax(newData)
  }
  public var associatedtypeKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.associatedtypeKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAssociatedtypeKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `associatedtypeKeyword` replaced.
  /// - param newChild: The new `associatedtypeKeyword` to replace the node's
  ///                   current `associatedtypeKeyword`, if present.
  public func withAssociatedtypeKeyword(
    _ newChild: TokenSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.associatedtypeKeyword)
    let newData = data.replacingChild(raw, at: Cursor.associatedtypeKeyword)
    return AssociatedtypeDeclSyntax(newData)
  }
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return AssociatedtypeDeclSyntax(newData)
  }
  public var inheritanceClause: TypeInheritanceClauseSyntax? {
  get {
    let child = data.child(at: Cursor.inheritanceClause, parent: self)
    if child == nil { return nil }
    return TypeInheritanceClauseSyntax(child!)
  }
  set(value) {
    self = withInheritanceClause(value)
  }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return AssociatedtypeDeclSyntax(newData)
  }
  public var initializer: TypeInitializerClauseSyntax? {
  get {
    let child = data.child(at: Cursor.initializer, parent: self)
    if child == nil { return nil }
    return TypeInitializerClauseSyntax(child!)
  }
  set(value) {
    self = withInitializer(value)
  }
  }

  /// Returns a copy of the receiver with its `initializer` replaced.
  /// - param newChild: The new `initializer` to replace the node's
  ///                   current `initializer`, if present.
  public func withInitializer(
    _ newChild: TypeInitializerClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return AssociatedtypeDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> AssociatedtypeDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return AssociatedtypeDeclSyntax(newData)
  }

  /// Determines if two `AssociatedtypeDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: AssociatedtypeDeclSyntax, rhs: AssociatedtypeDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ParameterClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftParen
    case parameterList
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `ParameterClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> ParameterClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return ParameterClauseSyntax(newData)
  }
  public var parameterList: FunctionParameterListSyntax {
  get {
    let child = data.child(at: Cursor.parameterList, parent: self)
    return FunctionParameterListSyntax(child!)
  }
  set(value) {
    self = withParameterList(value)
  }
  }

  /// Adds the provided `FunctionParameter` to the node's `parameterList`
  /// collection.
  /// - param element: The new `FunctionParameter` to add to the node's
  ///                  `parameterList` collection.
  /// - returns: A copy of the receiver with the provided `FunctionParameter`
  ///            appended to its `parameterList` collection.
  public func addFunctionParameter(_ element: FunctionParameterSyntax) -> ParameterClauseSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.parameterList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.functionParameterList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.parameterList)
    return ParameterClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `parameterList` replaced.
  /// - param newChild: The new `parameterList` to replace the node's
  ///                   current `parameterList`, if present.
  public func withParameterList(
    _ newChild: FunctionParameterListSyntax?) -> ParameterClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.functionParameterList)
    let newData = data.replacingChild(raw, at: Cursor.parameterList)
    return ParameterClauseSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> ParameterClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return ParameterClauseSyntax(newData)
  }

  /// Determines if two `ParameterClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: ParameterClauseSyntax, rhs: ParameterClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ReturnClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case arrow
    case returnType
  }

  let data: SyntaxData

  /// Creates a `ReturnClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var arrow: TokenSyntax {
  get {
    let child = data.child(at: Cursor.arrow, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withArrow(value)
  }
  }

  /// Returns a copy of the receiver with its `arrow` replaced.
  /// - param newChild: The new `arrow` to replace the node's
  ///                   current `arrow`, if present.
  public func withArrow(
    _ newChild: TokenSyntax?) -> ReturnClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.arrow)
    let newData = data.replacingChild(raw, at: Cursor.arrow)
    return ReturnClauseSyntax(newData)
  }
  public var returnType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.returnType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withReturnType(value)
  }
  }

  /// Returns a copy of the receiver with its `returnType` replaced.
  /// - param newChild: The new `returnType` to replace the node's
  ///                   current `returnType`, if present.
  public func withReturnType(
    _ newChild: TypeSyntax?) -> ReturnClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.returnType)
    return ReturnClauseSyntax(newData)
  }

  /// Determines if two `ReturnClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: ReturnClauseSyntax, rhs: ReturnClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct FunctionSignatureSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case input
    case throwsOrRethrowsKeyword
    case output
  }

  let data: SyntaxData

  /// Creates a `FunctionSignatureSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var input: ParameterClauseSyntax {
  get {
    let child = data.child(at: Cursor.input, parent: self)
    return ParameterClauseSyntax(child!)
  }
  set(value) {
    self = withInput(value)
  }
  }

  /// Returns a copy of the receiver with its `input` replaced.
  /// - param newChild: The new `input` to replace the node's
  ///                   current `input`, if present.
  public func withInput(
    _ newChild: ParameterClauseSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.parameterClause)
    let newData = data.replacingChild(raw, at: Cursor.input)
    return FunctionSignatureSyntax(newData)
  }
  public var throwsOrRethrowsKeyword: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.throwsOrRethrowsKeyword, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withThrowsOrRethrowsKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `throwsOrRethrowsKeyword` replaced.
  /// - param newChild: The new `throwsOrRethrowsKeyword` to replace the node's
  ///                   current `throwsOrRethrowsKeyword`, if present.
  public func withThrowsOrRethrowsKeyword(
    _ newChild: TokenSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.throwsOrRethrowsKeyword)
    return FunctionSignatureSyntax(newData)
  }
  public var output: ReturnClauseSyntax? {
  get {
    let child = data.child(at: Cursor.output, parent: self)
    if child == nil { return nil }
    return ReturnClauseSyntax(child!)
  }
  set(value) {
    self = withOutput(value)
  }
  }

  /// Returns a copy of the receiver with its `output` replaced.
  /// - param newChild: The new `output` to replace the node's
  ///                   current `output`, if present.
  public func withOutput(
    _ newChild: ReturnClauseSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.output)
    return FunctionSignatureSyntax(newData)
  }

  /// Determines if two `FunctionSignatureSyntax` nodes are equal to each other.
  public static func ==(lhs: FunctionSignatureSyntax, rhs: FunctionSignatureSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct IfConfigClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundKeyword
    case condition
    case elements
  }

  let data: SyntaxData

  /// Creates a `IfConfigClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `poundKeyword` replaced.
  /// - param newChild: The new `poundKeyword` to replace the node's
  ///                   current `poundKeyword`, if present.
  public func withPoundKeyword(
    _ newChild: TokenSyntax?) -> IfConfigClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundIfKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundKeyword)
    return IfConfigClauseSyntax(newData)
  }
  public var condition: ExprSyntax? {
  get {
    let child = data.child(at: Cursor.condition, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) as? ExprSyntax
  }
  set(value) {
    self = withCondition(value)
  }
  }

  /// Returns a copy of the receiver with its `condition` replaced.
  /// - param newChild: The new `condition` to replace the node's
  ///                   current `condition`, if present.
  public func withCondition(
    _ newChild: ExprSyntax?) -> IfConfigClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.condition)
    return IfConfigClauseSyntax(newData)
  }
  public var elements: Syntax {
  get {
    let child = data.child(at: Cursor.elements, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withElements(value)
  }
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: Syntax?) -> IfConfigClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return IfConfigClauseSyntax(newData)
  }

  /// Determines if two `IfConfigClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: IfConfigClauseSyntax, rhs: IfConfigClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct IfConfigDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case clauses
    case poundEndif
  }

  let data: SyntaxData

  /// Creates a `IfConfigDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var clauses: IfConfigClauseListSyntax {
  get {
    let child = data.child(at: Cursor.clauses, parent: self)
    return IfConfigClauseListSyntax(child!)
  }
  set(value) {
    self = withClauses(value)
  }
  }

  /// Adds the provided `IfConfigClause` to the node's `clauses`
  /// collection.
  /// - param element: The new `IfConfigClause` to add to the node's
  ///                  `clauses` collection.
  /// - returns: A copy of the receiver with the provided `IfConfigClause`
  ///            appended to its `clauses` collection.
  public func addIfConfigClause(_ element: IfConfigClauseSyntax) -> IfConfigDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.clauses] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.ifConfigClauseList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.clauses)
    return IfConfigDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `clauses` replaced.
  /// - param newChild: The new `clauses` to replace the node's
  ///                   current `clauses`, if present.
  public func withClauses(
    _ newChild: IfConfigClauseListSyntax?) -> IfConfigDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.ifConfigClauseList)
    let newData = data.replacingChild(raw, at: Cursor.clauses)
    return IfConfigDeclSyntax(newData)
  }
  public var poundEndif: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundEndif, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundEndif(value)
  }
  }

  /// Returns a copy of the receiver with its `poundEndif` replaced.
  /// - param newChild: The new `poundEndif` to replace the node's
  ///                   current `poundEndif`, if present.
  public func withPoundEndif(
    _ newChild: TokenSyntax?) -> IfConfigDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundEndifKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundEndif)
    return IfConfigDeclSyntax(newData)
  }

  /// Determines if two `IfConfigDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: IfConfigDeclSyntax, rhs: IfConfigDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundErrorDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundError
    case leftParen
    case message
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `PoundErrorDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundError: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundError, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundError(value)
  }
  }

  /// Returns a copy of the receiver with its `poundError` replaced.
  /// - param newChild: The new `poundError` to replace the node's
  ///                   current `poundError`, if present.
  public func withPoundError(
    _ newChild: TokenSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundErrorKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundError)
    return PoundErrorDeclSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundErrorDeclSyntax(newData)
  }
  public var message: StringLiteralExprSyntax {
  get {
    let child = data.child(at: Cursor.message, parent: self)
    return StringLiteralExprSyntax(child!)
  }
  set(value) {
    self = withMessage(value)
  }
  }

  /// Returns a copy of the receiver with its `message` replaced.
  /// - param newChild: The new `message` to replace the node's
  ///                   current `message`, if present.
  public func withMessage(
    _ newChild: StringLiteralExprSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.stringLiteralExpr)
    let newData = data.replacingChild(raw, at: Cursor.message)
    return PoundErrorDeclSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> PoundErrorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundErrorDeclSyntax(newData)
  }

  /// Determines if two `PoundErrorDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundErrorDeclSyntax, rhs: PoundErrorDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundWarningDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundWarning
    case leftParen
    case message
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `PoundWarningDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundWarning: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundWarning, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundWarning(value)
  }
  }

  /// Returns a copy of the receiver with its `poundWarning` replaced.
  /// - param newChild: The new `poundWarning` to replace the node's
  ///                   current `poundWarning`, if present.
  public func withPoundWarning(
    _ newChild: TokenSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundWarningKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundWarning)
    return PoundWarningDeclSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundWarningDeclSyntax(newData)
  }
  public var message: StringLiteralExprSyntax {
  get {
    let child = data.child(at: Cursor.message, parent: self)
    return StringLiteralExprSyntax(child!)
  }
  set(value) {
    self = withMessage(value)
  }
  }

  /// Returns a copy of the receiver with its `message` replaced.
  /// - param newChild: The new `message` to replace the node's
  ///                   current `message`, if present.
  public func withMessage(
    _ newChild: StringLiteralExprSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.stringLiteralExpr)
    let newData = data.replacingChild(raw, at: Cursor.message)
    return PoundWarningDeclSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> PoundWarningDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundWarningDeclSyntax(newData)
  }

  /// Determines if two `PoundWarningDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundWarningDeclSyntax, rhs: PoundWarningDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundSourceLocationSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundSourceLocation
    case leftParen
    case args
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `PoundSourceLocationSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundSourceLocation: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundSourceLocation, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundSourceLocation(value)
  }
  }

  /// Returns a copy of the receiver with its `poundSourceLocation` replaced.
  /// - param newChild: The new `poundSourceLocation` to replace the node's
  ///                   current `poundSourceLocation`, if present.
  public func withPoundSourceLocation(
    _ newChild: TokenSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundSourceLocationKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundSourceLocation)
    return PoundSourceLocationSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundSourceLocationSyntax(newData)
  }
  public var args: PoundSourceLocationArgsSyntax? {
  get {
    let child = data.child(at: Cursor.args, parent: self)
    if child == nil { return nil }
    return PoundSourceLocationArgsSyntax(child!)
  }
  set(value) {
    self = withArgs(value)
  }
  }

  /// Returns a copy of the receiver with its `args` replaced.
  /// - param newChild: The new `args` to replace the node's
  ///                   current `args`, if present.
  public func withArgs(
    _ newChild: PoundSourceLocationArgsSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.args)
    return PoundSourceLocationSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> PoundSourceLocationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundSourceLocationSyntax(newData)
  }

  /// Determines if two `PoundSourceLocationSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundSourceLocationSyntax, rhs: PoundSourceLocationSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundSourceLocationArgsSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case fileArgLabel
    case fileArgColon
    case fileName
    case comma
    case lineArgLabel
    case lineArgColon
    case lineNumber
  }

  let data: SyntaxData

  /// Creates a `PoundSourceLocationArgsSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var fileArgLabel: TokenSyntax {
  get {
    let child = data.child(at: Cursor.fileArgLabel, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withFileArgLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `fileArgLabel` replaced.
  /// - param newChild: The new `fileArgLabel` to replace the node's
  ///                   current `fileArgLabel`, if present.
  public func withFileArgLabel(
    _ newChild: TokenSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.fileArgLabel)
    return PoundSourceLocationArgsSyntax(newData)
  }
  public var fileArgColon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.fileArgColon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withFileArgColon(value)
  }
  }

  /// Returns a copy of the receiver with its `fileArgColon` replaced.
  /// - param newChild: The new `fileArgColon` to replace the node's
  ///                   current `fileArgColon`, if present.
  public func withFileArgColon(
    _ newChild: TokenSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.fileArgColon)
    return PoundSourceLocationArgsSyntax(newData)
  }
  public var fileName: TokenSyntax {
  get {
    let child = data.child(at: Cursor.fileName, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withFileName(value)
  }
  }

  /// Returns a copy of the receiver with its `fileName` replaced.
  /// - param newChild: The new `fileName` to replace the node's
  ///                   current `fileName`, if present.
  public func withFileName(
    _ newChild: TokenSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.stringLiteral(""))
    let newData = data.replacingChild(raw, at: Cursor.fileName)
    return PoundSourceLocationArgsSyntax(newData)
  }
  public var comma: TokenSyntax {
  get {
    let child = data.child(at: Cursor.comma, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withComma(value)
  }
  }

  /// Returns a copy of the receiver with its `comma` replaced.
  /// - param newChild: The new `comma` to replace the node's
  ///                   current `comma`, if present.
  public func withComma(
    _ newChild: TokenSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.comma)
    let newData = data.replacingChild(raw, at: Cursor.comma)
    return PoundSourceLocationArgsSyntax(newData)
  }
  public var lineArgLabel: TokenSyntax {
  get {
    let child = data.child(at: Cursor.lineArgLabel, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLineArgLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `lineArgLabel` replaced.
  /// - param newChild: The new `lineArgLabel` to replace the node's
  ///                   current `lineArgLabel`, if present.
  public func withLineArgLabel(
    _ newChild: TokenSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.lineArgLabel)
    return PoundSourceLocationArgsSyntax(newData)
  }
  public var lineArgColon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.lineArgColon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLineArgColon(value)
  }
  }

  /// Returns a copy of the receiver with its `lineArgColon` replaced.
  /// - param newChild: The new `lineArgColon` to replace the node's
  ///                   current `lineArgColon`, if present.
  public func withLineArgColon(
    _ newChild: TokenSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.lineArgColon)
    return PoundSourceLocationArgsSyntax(newData)
  }
  public var lineNumber: TokenSyntax {
  get {
    let child = data.child(at: Cursor.lineNumber, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLineNumber(value)
  }
  }

  /// Returns a copy of the receiver with its `lineNumber` replaced.
  /// - param newChild: The new `lineNumber` to replace the node's
  ///                   current `lineNumber`, if present.
  public func withLineNumber(
    _ newChild: TokenSyntax?) -> PoundSourceLocationArgsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.integerLiteral(""))
    let newData = data.replacingChild(raw, at: Cursor.lineNumber)
    return PoundSourceLocationArgsSyntax(newData)
  }

  /// Determines if two `PoundSourceLocationArgsSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundSourceLocationArgsSyntax, rhs: PoundSourceLocationArgsSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DeclModifierSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case detailLeftParen
    case detail
    case detailRightParen
  }

  let data: SyntaxData

  /// Creates a `DeclModifierSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> DeclModifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return DeclModifierSyntax(newData)
  }
  public var detailLeftParen: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.detailLeftParen, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDetailLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `detailLeftParen` replaced.
  /// - param newChild: The new `detailLeftParen` to replace the node's
  ///                   current `detailLeftParen`, if present.
  public func withDetailLeftParen(
    _ newChild: TokenSyntax?) -> DeclModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.detailLeftParen)
    return DeclModifierSyntax(newData)
  }
  public var detail: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.detail, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDetail(value)
  }
  }

  /// Returns a copy of the receiver with its `detail` replaced.
  /// - param newChild: The new `detail` to replace the node's
  ///                   current `detail`, if present.
  public func withDetail(
    _ newChild: TokenSyntax?) -> DeclModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.detail)
    return DeclModifierSyntax(newData)
  }
  public var detailRightParen: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.detailRightParen, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDetailRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `detailRightParen` replaced.
  /// - param newChild: The new `detailRightParen` to replace the node's
  ///                   current `detailRightParen`, if present.
  public func withDetailRightParen(
    _ newChild: TokenSyntax?) -> DeclModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.detailRightParen)
    return DeclModifierSyntax(newData)
  }

  /// Determines if two `DeclModifierSyntax` nodes are equal to each other.
  public static func ==(lhs: DeclModifierSyntax, rhs: DeclModifierSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct InheritedTypeSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case typeName
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `InheritedTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var typeName: TypeSyntax {
  get {
    let child = data.child(at: Cursor.typeName, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withTypeName(value)
  }
  }

  /// Returns a copy of the receiver with its `typeName` replaced.
  /// - param newChild: The new `typeName` to replace the node's
  ///                   current `typeName`, if present.
  public func withTypeName(
    _ newChild: TypeSyntax?) -> InheritedTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.typeName)
    return InheritedTypeSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> InheritedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return InheritedTypeSyntax(newData)
  }

  /// Determines if two `InheritedTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: InheritedTypeSyntax, rhs: InheritedTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TypeInheritanceClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case colon
    case inheritedTypeCollection
  }

  let data: SyntaxData

  /// Creates a `TypeInheritanceClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> TypeInheritanceClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return TypeInheritanceClauseSyntax(newData)
  }
  public var inheritedTypeCollection: InheritedTypeListSyntax {
  get {
    let child = data.child(at: Cursor.inheritedTypeCollection, parent: self)
    return InheritedTypeListSyntax(child!)
  }
  set(value) {
    self = withInheritedTypeCollection(value)
  }
  }

  /// Adds the provided `InheritedType` to the node's `inheritedTypeCollection`
  /// collection.
  /// - param element: The new `InheritedType` to add to the node's
  ///                  `inheritedTypeCollection` collection.
  /// - returns: A copy of the receiver with the provided `InheritedType`
  ///            appended to its `inheritedTypeCollection` collection.
  public func addInheritedType(_ element: InheritedTypeSyntax) -> TypeInheritanceClauseSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.inheritedTypeCollection] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.inheritedTypeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.inheritedTypeCollection)
    return TypeInheritanceClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `inheritedTypeCollection` replaced.
  /// - param newChild: The new `inheritedTypeCollection` to replace the node's
  ///                   current `inheritedTypeCollection`, if present.
  public func withInheritedTypeCollection(
    _ newChild: InheritedTypeListSyntax?) -> TypeInheritanceClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.inheritedTypeList)
    let newData = data.replacingChild(raw, at: Cursor.inheritedTypeCollection)
    return TypeInheritanceClauseSyntax(newData)
  }

  /// Determines if two `TypeInheritanceClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: TypeInheritanceClauseSyntax, rhs: TypeInheritanceClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ClassDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case classKeyword
    case identifier
    case genericParameterClause
    case inheritanceClause
    case genericWhereClause
    case members
  }

  let data: SyntaxData

  /// Creates a `ClassDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> ClassDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return ClassDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return ClassDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> ClassDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return ClassDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return ClassDeclSyntax(newData)
  }
  public var classKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.classKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withClassKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `classKeyword` replaced.
  /// - param newChild: The new `classKeyword` to replace the node's
  ///                   current `classKeyword`, if present.
  public func withClassKeyword(
    _ newChild: TokenSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.classKeyword)
    let newData = data.replacingChild(raw, at: Cursor.classKeyword)
    return ClassDeclSyntax(newData)
  }
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ClassDeclSyntax(newData)
  }
  public var genericParameterClause: GenericParameterClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericParameterClause, parent: self)
    if child == nil { return nil }
    return GenericParameterClauseSyntax(child!)
  }
  set(value) {
    self = withGenericParameterClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return ClassDeclSyntax(newData)
  }
  public var inheritanceClause: TypeInheritanceClauseSyntax? {
  get {
    let child = data.child(at: Cursor.inheritanceClause, parent: self)
    if child == nil { return nil }
    return TypeInheritanceClauseSyntax(child!)
  }
  set(value) {
    self = withInheritanceClause(value)
  }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return ClassDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return ClassDeclSyntax(newData)
  }
  public var members: MemberDeclBlockSyntax {
  get {
    let child = data.child(at: Cursor.members, parent: self)
    return MemberDeclBlockSyntax(child!)
  }
  set(value) {
    self = withMembers(value)
  }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(
    _ newChild: MemberDeclBlockSyntax?) -> ClassDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ClassDeclSyntax(newData)
  }

  /// Determines if two `ClassDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: ClassDeclSyntax, rhs: ClassDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct StructDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case structKeyword
    case identifier
    case genericParameterClause
    case inheritanceClause
    case genericWhereClause
    case members
  }

  let data: SyntaxData

  /// Creates a `StructDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> StructDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return StructDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return StructDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> StructDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return StructDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return StructDeclSyntax(newData)
  }
  public var structKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.structKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withStructKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `structKeyword` replaced.
  /// - param newChild: The new `structKeyword` to replace the node's
  ///                   current `structKeyword`, if present.
  public func withStructKeyword(
    _ newChild: TokenSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.structKeyword)
    let newData = data.replacingChild(raw, at: Cursor.structKeyword)
    return StructDeclSyntax(newData)
  }
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return StructDeclSyntax(newData)
  }
  public var genericParameterClause: GenericParameterClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericParameterClause, parent: self)
    if child == nil { return nil }
    return GenericParameterClauseSyntax(child!)
  }
  set(value) {
    self = withGenericParameterClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return StructDeclSyntax(newData)
  }
  public var inheritanceClause: TypeInheritanceClauseSyntax? {
  get {
    let child = data.child(at: Cursor.inheritanceClause, parent: self)
    if child == nil { return nil }
    return TypeInheritanceClauseSyntax(child!)
  }
  set(value) {
    self = withInheritanceClause(value)
  }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return StructDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return StructDeclSyntax(newData)
  }
  public var members: MemberDeclBlockSyntax {
  get {
    let child = data.child(at: Cursor.members, parent: self)
    return MemberDeclBlockSyntax(child!)
  }
  set(value) {
    self = withMembers(value)
  }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(
    _ newChild: MemberDeclBlockSyntax?) -> StructDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return StructDeclSyntax(newData)
  }

  /// Determines if two `StructDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: StructDeclSyntax, rhs: StructDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ProtocolDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case protocolKeyword
    case identifier
    case inheritanceClause
    case genericWhereClause
    case members
  }

  let data: SyntaxData

  /// Creates a `ProtocolDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> ProtocolDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return ProtocolDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return ProtocolDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> ProtocolDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return ProtocolDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return ProtocolDeclSyntax(newData)
  }
  public var protocolKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.protocolKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withProtocolKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `protocolKeyword` replaced.
  /// - param newChild: The new `protocolKeyword` to replace the node's
  ///                   current `protocolKeyword`, if present.
  public func withProtocolKeyword(
    _ newChild: TokenSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.protocolKeyword)
    let newData = data.replacingChild(raw, at: Cursor.protocolKeyword)
    return ProtocolDeclSyntax(newData)
  }
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return ProtocolDeclSyntax(newData)
  }
  public var inheritanceClause: TypeInheritanceClauseSyntax? {
  get {
    let child = data.child(at: Cursor.inheritanceClause, parent: self)
    if child == nil { return nil }
    return TypeInheritanceClauseSyntax(child!)
  }
  set(value) {
    self = withInheritanceClause(value)
  }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return ProtocolDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return ProtocolDeclSyntax(newData)
  }
  public var members: MemberDeclBlockSyntax {
  get {
    let child = data.child(at: Cursor.members, parent: self)
    return MemberDeclBlockSyntax(child!)
  }
  set(value) {
    self = withMembers(value)
  }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(
    _ newChild: MemberDeclBlockSyntax?) -> ProtocolDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ProtocolDeclSyntax(newData)
  }

  /// Determines if two `ProtocolDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: ProtocolDeclSyntax, rhs: ProtocolDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ExtensionDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case extensionKeyword
    case extendedType
    case inheritanceClause
    case genericWhereClause
    case members
  }

  let data: SyntaxData

  /// Creates a `ExtensionDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> ExtensionDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return ExtensionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return ExtensionDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> ExtensionDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return ExtensionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return ExtensionDeclSyntax(newData)
  }
  public var extensionKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.extensionKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withExtensionKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `extensionKeyword` replaced.
  /// - param newChild: The new `extensionKeyword` to replace the node's
  ///                   current `extensionKeyword`, if present.
  public func withExtensionKeyword(
    _ newChild: TokenSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.extensionKeyword)
    let newData = data.replacingChild(raw, at: Cursor.extensionKeyword)
    return ExtensionDeclSyntax(newData)
  }
  public var extendedType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.extendedType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withExtendedType(value)
  }
  }

  /// Returns a copy of the receiver with its `extendedType` replaced.
  /// - param newChild: The new `extendedType` to replace the node's
  ///                   current `extendedType`, if present.
  public func withExtendedType(
    _ newChild: TypeSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.extendedType)
    return ExtensionDeclSyntax(newData)
  }
  public var inheritanceClause: TypeInheritanceClauseSyntax? {
  get {
    let child = data.child(at: Cursor.inheritanceClause, parent: self)
    if child == nil { return nil }
    return TypeInheritanceClauseSyntax(child!)
  }
  set(value) {
    self = withInheritanceClause(value)
  }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return ExtensionDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return ExtensionDeclSyntax(newData)
  }
  public var members: MemberDeclBlockSyntax {
  get {
    let child = data.child(at: Cursor.members, parent: self)
    return MemberDeclBlockSyntax(child!)
  }
  set(value) {
    self = withMembers(value)
  }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(
    _ newChild: MemberDeclBlockSyntax?) -> ExtensionDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return ExtensionDeclSyntax(newData)
  }

  /// Determines if two `ExtensionDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: ExtensionDeclSyntax, rhs: ExtensionDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct MemberDeclBlockSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftBrace
    case members
    case rightBrace
  }

  let data: SyntaxData

  /// Creates a `MemberDeclBlockSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `leftBrace` replaced.
  /// - param newChild: The new `leftBrace` to replace the node's
  ///                   current `leftBrace`, if present.
  public func withLeftBrace(
    _ newChild: TokenSyntax?) -> MemberDeclBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return MemberDeclBlockSyntax(newData)
  }
  public var members: MemberDeclListSyntax {
  get {
    let child = data.child(at: Cursor.members, parent: self)
    return MemberDeclListSyntax(child!)
  }
  set(value) {
    self = withMembers(value)
  }
  }

  /// Adds the provided `MemberDeclListItem` to the node's `members`
  /// collection.
  /// - param element: The new `MemberDeclListItem` to add to the node's
  ///                  `members` collection.
  /// - returns: A copy of the receiver with the provided `MemberDeclListItem`
  ///            appended to its `members` collection.
  public func addMemberDeclListItem(_ element: MemberDeclListItemSyntax) -> MemberDeclBlockSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.members] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.memberDeclList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.members)
    return MemberDeclBlockSyntax(newData)
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(
    _ newChild: MemberDeclListSyntax?) -> MemberDeclBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclList)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return MemberDeclBlockSyntax(newData)
  }
  public var rightBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `rightBrace` replaced.
  /// - param newChild: The new `rightBrace` to replace the node's
  ///                   current `rightBrace`, if present.
  public func withRightBrace(
    _ newChild: TokenSyntax?) -> MemberDeclBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return MemberDeclBlockSyntax(newData)
  }

  /// Determines if two `MemberDeclBlockSyntax` nodes are equal to each other.
  public static func ==(lhs: MemberDeclBlockSyntax, rhs: MemberDeclBlockSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A member declaration of a type consisting of a declaration and an          optional semicolon;
/// 
public struct MemberDeclListItemSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case decl
    case semicolon
  }

  let data: SyntaxData

  /// Creates a `MemberDeclListItemSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The declaration of the type member.
  public var decl: DeclSyntax {
  get {
    let child = data.child(at: Cursor.decl, parent: self)
    return makeSyntax(child!) as! DeclSyntax
  }
  set(value) {
    self = withDecl(value)
  }
  }

  /// Returns a copy of the receiver with its `decl` replaced.
  /// - param newChild: The new `decl` to replace the node's
  ///                   current `decl`, if present.
  public func withDecl(
    _ newChild: DeclSyntax?) -> MemberDeclListItemSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.decl)
    let newData = data.replacingChild(raw, at: Cursor.decl)
    return MemberDeclListItemSyntax(newData)
  }
  /// An optional trailing semicolon.
  public var semicolon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.semicolon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withSemicolon(value)
  }
  }

  /// Returns a copy of the receiver with its `semicolon` replaced.
  /// - param newChild: The new `semicolon` to replace the node's
  ///                   current `semicolon`, if present.
  public func withSemicolon(
    _ newChild: TokenSyntax?) -> MemberDeclListItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.semicolon)
    return MemberDeclListItemSyntax(newData)
  }

  /// Determines if two `MemberDeclListItemSyntax` nodes are equal to each other.
  public static func ==(lhs: MemberDeclListItemSyntax, rhs: MemberDeclListItemSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SourceFileSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case statements
    case eofToken
  }

  let data: SyntaxData

  /// Creates a `SourceFileSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var statements: CodeBlockItemListSyntax {
  get {
    let child = data.child(at: Cursor.statements, parent: self)
    return CodeBlockItemListSyntax(child!)
  }
  set(value) {
    self = withStatements(value)
  }
  }

  /// Adds the provided `CodeBlockItem` to the node's `statements`
  /// collection.
  /// - param element: The new `CodeBlockItem` to add to the node's
  ///                  `statements` collection.
  /// - returns: A copy of the receiver with the provided `CodeBlockItem`
  ///            appended to its `statements` collection.
  public func addCodeBlockItem(_ element: CodeBlockItemSyntax) -> SourceFileSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.statements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.statements)
    return SourceFileSyntax(newData)
  }

  /// Returns a copy of the receiver with its `statements` replaced.
  /// - param newChild: The new `statements` to replace the node's
  ///                   current `statements`, if present.
  public func withStatements(
    _ newChild: CodeBlockItemListSyntax?) -> SourceFileSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlockItemList)
    let newData = data.replacingChild(raw, at: Cursor.statements)
    return SourceFileSyntax(newData)
  }
  public var eofToken: TokenSyntax {
  get {
    let child = data.child(at: Cursor.eofToken, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withEOFToken(value)
  }
  }

  /// Returns a copy of the receiver with its `eofToken` replaced.
  /// - param newChild: The new `eofToken` to replace the node's
  ///                   current `eofToken`, if present.
  public func withEOFToken(
    _ newChild: TokenSyntax?) -> SourceFileSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.eofToken)
    return SourceFileSyntax(newData)
  }

  /// Determines if two `SourceFileSyntax` nodes are equal to each other.
  public static func ==(lhs: SourceFileSyntax, rhs: SourceFileSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct InitializerClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case equal
    case value
  }

  let data: SyntaxData

  /// Creates a `InitializerClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var equal: TokenSyntax {
  get {
    let child = data.child(at: Cursor.equal, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withEqual(value)
  }
  }

  /// Returns a copy of the receiver with its `equal` replaced.
  /// - param newChild: The new `equal` to replace the node's
  ///                   current `equal`, if present.
  public func withEqual(
    _ newChild: TokenSyntax?) -> InitializerClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.equal)
    let newData = data.replacingChild(raw, at: Cursor.equal)
    return InitializerClauseSyntax(newData)
  }
  public var value: ExprSyntax {
  get {
    let child = data.child(at: Cursor.value, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withValue(value)
  }
  }

  /// Returns a copy of the receiver with its `value` replaced.
  /// - param newChild: The new `value` to replace the node's
  ///                   current `value`, if present.
  public func withValue(
    _ newChild: ExprSyntax?) -> InitializerClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.value)
    return InitializerClauseSyntax(newData)
  }

  /// Determines if two `InitializerClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: InitializerClauseSyntax, rhs: InitializerClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct FunctionParameterSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case firstName
    case secondName
    case colon
    case type
    case ellipsis
    case defaultArgument
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `FunctionParameterSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> FunctionParameterSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return FunctionParameterSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return FunctionParameterSyntax(newData)
  }
  public var firstName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.firstName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withFirstName(value)
  }
  }

  /// Returns a copy of the receiver with its `firstName` replaced.
  /// - param newChild: The new `firstName` to replace the node's
  ///                   current `firstName`, if present.
  public func withFirstName(
    _ newChild: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.firstName)
    return FunctionParameterSyntax(newData)
  }
  public var secondName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.secondName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withSecondName(value)
  }
  }

  /// Returns a copy of the receiver with its `secondName` replaced.
  /// - param newChild: The new `secondName` to replace the node's
  ///                   current `secondName`, if present.
  public func withSecondName(
    _ newChild: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.secondName)
    return FunctionParameterSyntax(newData)
  }
  public var colon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return FunctionParameterSyntax(newData)
  }
  public var type: TypeSyntax? {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) as? TypeSyntax
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: TypeSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.type)
    return FunctionParameterSyntax(newData)
  }
  public var ellipsis: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.ellipsis, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withEllipsis(value)
  }
  }

  /// Returns a copy of the receiver with its `ellipsis` replaced.
  /// - param newChild: The new `ellipsis` to replace the node's
  ///                   current `ellipsis`, if present.
  public func withEllipsis(
    _ newChild: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.ellipsis)
    return FunctionParameterSyntax(newData)
  }
  public var defaultArgument: InitializerClauseSyntax? {
  get {
    let child = data.child(at: Cursor.defaultArgument, parent: self)
    if child == nil { return nil }
    return InitializerClauseSyntax(child!)
  }
  set(value) {
    self = withDefaultArgument(value)
  }
  }

  /// Returns a copy of the receiver with its `defaultArgument` replaced.
  /// - param newChild: The new `defaultArgument` to replace the node's
  ///                   current `defaultArgument`, if present.
  public func withDefaultArgument(
    _ newChild: InitializerClauseSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.defaultArgument)
    return FunctionParameterSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return FunctionParameterSyntax(newData)
  }

  /// Determines if two `FunctionParameterSyntax` nodes are equal to each other.
  public static func ==(lhs: FunctionParameterSyntax, rhs: FunctionParameterSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct FunctionDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case funcKeyword
    case identifier
    case genericParameterClause
    case signature
    case genericWhereClause
    case body
  }

  let data: SyntaxData

  /// Creates a `FunctionDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> FunctionDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return FunctionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return FunctionDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> FunctionDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return FunctionDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return FunctionDeclSyntax(newData)
  }
  public var funcKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.funcKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withFuncKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `funcKeyword` replaced.
  /// - param newChild: The new `funcKeyword` to replace the node's
  ///                   current `funcKeyword`, if present.
  public func withFuncKeyword(
    _ newChild: TokenSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.funcKeyword)
    let newData = data.replacingChild(raw, at: Cursor.funcKeyword)
    return FunctionDeclSyntax(newData)
  }
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return FunctionDeclSyntax(newData)
  }
  public var genericParameterClause: GenericParameterClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericParameterClause, parent: self)
    if child == nil { return nil }
    return GenericParameterClauseSyntax(child!)
  }
  set(value) {
    self = withGenericParameterClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return FunctionDeclSyntax(newData)
  }
  public var signature: FunctionSignatureSyntax {
  get {
    let child = data.child(at: Cursor.signature, parent: self)
    return FunctionSignatureSyntax(child!)
  }
  set(value) {
    self = withSignature(value)
  }
  }

  /// Returns a copy of the receiver with its `signature` replaced.
  /// - param newChild: The new `signature` to replace the node's
  ///                   current `signature`, if present.
  public func withSignature(
    _ newChild: FunctionSignatureSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.functionSignature)
    let newData = data.replacingChild(raw, at: Cursor.signature)
    return FunctionDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return FunctionDeclSyntax(newData)
  }
  public var body: CodeBlockSyntax? {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    if child == nil { return nil }
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.body)
    return FunctionDeclSyntax(newData)
  }

  /// Determines if two `FunctionDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: FunctionDeclSyntax, rhs: FunctionDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct InitializerDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case initKeyword
    case optionalMark
    case genericParameterClause
    case parameters
    case throwsOrRethrowsKeyword
    case genericWhereClause
    case body
  }

  let data: SyntaxData

  /// Creates a `InitializerDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> InitializerDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return InitializerDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return InitializerDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> InitializerDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return InitializerDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return InitializerDeclSyntax(newData)
  }
  public var initKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.initKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withInitKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `initKeyword` replaced.
  /// - param newChild: The new `initKeyword` to replace the node's
  ///                   current `initKeyword`, if present.
  public func withInitKeyword(
    _ newChild: TokenSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.initKeyword)
    let newData = data.replacingChild(raw, at: Cursor.initKeyword)
    return InitializerDeclSyntax(newData)
  }
  public var optionalMark: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.optionalMark, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withOptionalMark(value)
  }
  }

  /// Returns a copy of the receiver with its `optionalMark` replaced.
  /// - param newChild: The new `optionalMark` to replace the node's
  ///                   current `optionalMark`, if present.
  public func withOptionalMark(
    _ newChild: TokenSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.optionalMark)
    return InitializerDeclSyntax(newData)
  }
  public var genericParameterClause: GenericParameterClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericParameterClause, parent: self)
    if child == nil { return nil }
    return GenericParameterClauseSyntax(child!)
  }
  set(value) {
    self = withGenericParameterClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return InitializerDeclSyntax(newData)
  }
  public var parameters: ParameterClauseSyntax {
  get {
    let child = data.child(at: Cursor.parameters, parent: self)
    return ParameterClauseSyntax(child!)
  }
  set(value) {
    self = withParameters(value)
  }
  }

  /// Returns a copy of the receiver with its `parameters` replaced.
  /// - param newChild: The new `parameters` to replace the node's
  ///                   current `parameters`, if present.
  public func withParameters(
    _ newChild: ParameterClauseSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.parameterClause)
    let newData = data.replacingChild(raw, at: Cursor.parameters)
    return InitializerDeclSyntax(newData)
  }
  public var throwsOrRethrowsKeyword: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.throwsOrRethrowsKeyword, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withThrowsOrRethrowsKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `throwsOrRethrowsKeyword` replaced.
  /// - param newChild: The new `throwsOrRethrowsKeyword` to replace the node's
  ///                   current `throwsOrRethrowsKeyword`, if present.
  public func withThrowsOrRethrowsKeyword(
    _ newChild: TokenSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.throwsOrRethrowsKeyword)
    return InitializerDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return InitializerDeclSyntax(newData)
  }
  public var body: CodeBlockSyntax? {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    if child == nil { return nil }
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> InitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.body)
    return InitializerDeclSyntax(newData)
  }

  /// Determines if two `InitializerDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: InitializerDeclSyntax, rhs: InitializerDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DeinitializerDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case deinitKeyword
    case body
  }

  let data: SyntaxData

  /// Creates a `DeinitializerDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> DeinitializerDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return DeinitializerDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return DeinitializerDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> DeinitializerDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return DeinitializerDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return DeinitializerDeclSyntax(newData)
  }
  public var deinitKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.deinitKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDeinitKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `deinitKeyword` replaced.
  /// - param newChild: The new `deinitKeyword` to replace the node's
  ///                   current `deinitKeyword`, if present.
  public func withDeinitKeyword(
    _ newChild: TokenSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.deinitKeyword)
    let newData = data.replacingChild(raw, at: Cursor.deinitKeyword)
    return DeinitializerDeclSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> DeinitializerDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return DeinitializerDeclSyntax(newData)
  }

  /// Determines if two `DeinitializerDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: DeinitializerDeclSyntax, rhs: DeinitializerDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SubscriptDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case subscriptKeyword
    case genericParameterClause
    case indices
    case result
    case genericWhereClause
    case accessor
  }

  let data: SyntaxData

  /// Creates a `SubscriptDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> SubscriptDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return SubscriptDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return SubscriptDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> SubscriptDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return SubscriptDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return SubscriptDeclSyntax(newData)
  }
  public var subscriptKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.subscriptKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withSubscriptKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `subscriptKeyword` replaced.
  /// - param newChild: The new `subscriptKeyword` to replace the node's
  ///                   current `subscriptKeyword`, if present.
  public func withSubscriptKeyword(
    _ newChild: TokenSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.subscriptKeyword)
    let newData = data.replacingChild(raw, at: Cursor.subscriptKeyword)
    return SubscriptDeclSyntax(newData)
  }
  public var genericParameterClause: GenericParameterClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericParameterClause, parent: self)
    if child == nil { return nil }
    return GenericParameterClauseSyntax(child!)
  }
  set(value) {
    self = withGenericParameterClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericParameterClause` replaced.
  /// - param newChild: The new `genericParameterClause` to replace the node's
  ///                   current `genericParameterClause`, if present.
  public func withGenericParameterClause(
    _ newChild: GenericParameterClauseSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameterClause)
    return SubscriptDeclSyntax(newData)
  }
  public var indices: ParameterClauseSyntax {
  get {
    let child = data.child(at: Cursor.indices, parent: self)
    return ParameterClauseSyntax(child!)
  }
  set(value) {
    self = withIndices(value)
  }
  }

  /// Returns a copy of the receiver with its `indices` replaced.
  /// - param newChild: The new `indices` to replace the node's
  ///                   current `indices`, if present.
  public func withIndices(
    _ newChild: ParameterClauseSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.parameterClause)
    let newData = data.replacingChild(raw, at: Cursor.indices)
    return SubscriptDeclSyntax(newData)
  }
  public var result: ReturnClauseSyntax {
  get {
    let child = data.child(at: Cursor.result, parent: self)
    return ReturnClauseSyntax(child!)
  }
  set(value) {
    self = withResult(value)
  }
  }

  /// Returns a copy of the receiver with its `result` replaced.
  /// - param newChild: The new `result` to replace the node's
  ///                   current `result`, if present.
  public func withResult(
    _ newChild: ReturnClauseSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.returnClause)
    let newData = data.replacingChild(raw, at: Cursor.result)
    return SubscriptDeclSyntax(newData)
  }
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return SubscriptDeclSyntax(newData)
  }
  public var accessor: Syntax? {
  get {
    let child = data.child(at: Cursor.accessor, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) 
  }
  set(value) {
    self = withAccessor(value)
  }
  }

  /// Returns a copy of the receiver with its `accessor` replaced.
  /// - param newChild: The new `accessor` to replace the node's
  ///                   current `accessor`, if present.
  public func withAccessor(
    _ newChild: Syntax?) -> SubscriptDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.accessor)
    return SubscriptDeclSyntax(newData)
  }

  /// Determines if two `SubscriptDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: SubscriptDeclSyntax, rhs: SubscriptDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AccessLevelModifierSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case leftParen
    case modifier
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `AccessLevelModifierSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> AccessLevelModifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return AccessLevelModifierSyntax(newData)
  }
  public var leftParen: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> AccessLevelModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return AccessLevelModifierSyntax(newData)
  }
  public var modifier: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.modifier, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withModifier(value)
  }
  }

  /// Returns a copy of the receiver with its `modifier` replaced.
  /// - param newChild: The new `modifier` to replace the node's
  ///                   current `modifier`, if present.
  public func withModifier(
    _ newChild: TokenSyntax?) -> AccessLevelModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifier)
    return AccessLevelModifierSyntax(newData)
  }
  public var rightParen: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> AccessLevelModifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return AccessLevelModifierSyntax(newData)
  }

  /// Determines if two `AccessLevelModifierSyntax` nodes are equal to each other.
  public static func ==(lhs: AccessLevelModifierSyntax, rhs: AccessLevelModifierSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AccessPathComponentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case trailingDot
  }

  let data: SyntaxData

  /// Creates a `AccessPathComponentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> AccessPathComponentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return AccessPathComponentSyntax(newData)
  }
  public var trailingDot: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingDot, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingDot(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingDot` replaced.
  /// - param newChild: The new `trailingDot` to replace the node's
  ///                   current `trailingDot`, if present.
  public func withTrailingDot(
    _ newChild: TokenSyntax?) -> AccessPathComponentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingDot)
    return AccessPathComponentSyntax(newData)
  }

  /// Determines if two `AccessPathComponentSyntax` nodes are equal to each other.
  public static func ==(lhs: AccessPathComponentSyntax, rhs: AccessPathComponentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ImportDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case importTok
    case importKind
    case path
  }

  let data: SyntaxData

  /// Creates a `ImportDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> ImportDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return ImportDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return ImportDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> ImportDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return ImportDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return ImportDeclSyntax(newData)
  }
  public var importTok: TokenSyntax {
  get {
    let child = data.child(at: Cursor.importTok, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withImportTok(value)
  }
  }

  /// Returns a copy of the receiver with its `importTok` replaced.
  /// - param newChild: The new `importTok` to replace the node's
  ///                   current `importTok`, if present.
  public func withImportTok(
    _ newChild: TokenSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.importKeyword)
    let newData = data.replacingChild(raw, at: Cursor.importTok)
    return ImportDeclSyntax(newData)
  }
  public var importKind: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.importKind, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withImportKind(value)
  }
  }

  /// Returns a copy of the receiver with its `importKind` replaced.
  /// - param newChild: The new `importKind` to replace the node's
  ///                   current `importKind`, if present.
  public func withImportKind(
    _ newChild: TokenSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.importKind)
    return ImportDeclSyntax(newData)
  }
  public var path: AccessPathSyntax {
  get {
    let child = data.child(at: Cursor.path, parent: self)
    return AccessPathSyntax(child!)
  }
  set(value) {
    self = withPath(value)
  }
  }

  /// Adds the provided `AccessPathComponent` to the node's `path`
  /// collection.
  /// - param element: The new `AccessPathComponent` to add to the node's
  ///                  `path` collection.
  /// - returns: A copy of the receiver with the provided `AccessPathComponent`
  ///            appended to its `path` collection.
  public func addAccessPathComponent(_ element: AccessPathComponentSyntax) -> ImportDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.path] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.accessPath,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.path)
    return ImportDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `path` replaced.
  /// - param newChild: The new `path` to replace the node's
  ///                   current `path`, if present.
  public func withPath(
    _ newChild: AccessPathSyntax?) -> ImportDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.accessPath)
    let newData = data.replacingChild(raw, at: Cursor.path)
    return ImportDeclSyntax(newData)
  }

  /// Determines if two `ImportDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: ImportDeclSyntax, rhs: ImportDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AccessorParameterSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftParen
    case name
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `AccessorParameterSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> AccessorParameterSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return AccessorParameterSyntax(newData)
  }
  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> AccessorParameterSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return AccessorParameterSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> AccessorParameterSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return AccessorParameterSyntax(newData)
  }

  /// Determines if two `AccessorParameterSyntax` nodes are equal to each other.
  public static func ==(lhs: AccessorParameterSyntax, rhs: AccessorParameterSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AccessorDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifier
    case accessorKind
    case parameter
    case body
  }

  let data: SyntaxData

  /// Creates a `AccessorDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> AccessorDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return AccessorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return AccessorDeclSyntax(newData)
  }
  public var modifier: DeclModifierSyntax? {
  get {
    let child = data.child(at: Cursor.modifier, parent: self)
    if child == nil { return nil }
    return DeclModifierSyntax(child!)
  }
  set(value) {
    self = withModifier(value)
  }
  }

  /// Returns a copy of the receiver with its `modifier` replaced.
  /// - param newChild: The new `modifier` to replace the node's
  ///                   current `modifier`, if present.
  public func withModifier(
    _ newChild: DeclModifierSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifier)
    return AccessorDeclSyntax(newData)
  }
  public var accessorKind: TokenSyntax {
  get {
    let child = data.child(at: Cursor.accessorKind, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAccessorKind(value)
  }
  }

  /// Returns a copy of the receiver with its `accessorKind` replaced.
  /// - param newChild: The new `accessorKind` to replace the node's
  ///                   current `accessorKind`, if present.
  public func withAccessorKind(
    _ newChild: TokenSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.accessorKind)
    return AccessorDeclSyntax(newData)
  }
  public var parameter: AccessorParameterSyntax? {
  get {
    let child = data.child(at: Cursor.parameter, parent: self)
    if child == nil { return nil }
    return AccessorParameterSyntax(child!)
  }
  set(value) {
    self = withParameter(value)
  }
  }

  /// Returns a copy of the receiver with its `parameter` replaced.
  /// - param newChild: The new `parameter` to replace the node's
  ///                   current `parameter`, if present.
  public func withParameter(
    _ newChild: AccessorParameterSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.parameter)
    return AccessorDeclSyntax(newData)
  }
  public var body: CodeBlockSyntax? {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    if child == nil { return nil }
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> AccessorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.body)
    return AccessorDeclSyntax(newData)
  }

  /// Determines if two `AccessorDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: AccessorDeclSyntax, rhs: AccessorDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AccessorBlockSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftBrace
    case accessors
    case rightBrace
  }

  let data: SyntaxData

  /// Creates a `AccessorBlockSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `leftBrace` replaced.
  /// - param newChild: The new `leftBrace` to replace the node's
  ///                   current `leftBrace`, if present.
  public func withLeftBrace(
    _ newChild: TokenSyntax?) -> AccessorBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return AccessorBlockSyntax(newData)
  }
  public var accessors: AccessorListSyntax {
  get {
    let child = data.child(at: Cursor.accessors, parent: self)
    return AccessorListSyntax(child!)
  }
  set(value) {
    self = withAccessors(value)
  }
  }

  /// Adds the provided `AccessorDecl` to the node's `accessors`
  /// collection.
  /// - param element: The new `AccessorDecl` to add to the node's
  ///                  `accessors` collection.
  /// - returns: A copy of the receiver with the provided `AccessorDecl`
  ///            appended to its `accessors` collection.
  public func addAccessorDecl(_ element: AccessorDeclSyntax) -> AccessorBlockSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.accessors] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.accessorList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.accessors)
    return AccessorBlockSyntax(newData)
  }

  /// Returns a copy of the receiver with its `accessors` replaced.
  /// - param newChild: The new `accessors` to replace the node's
  ///                   current `accessors`, if present.
  public func withAccessors(
    _ newChild: AccessorListSyntax?) -> AccessorBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.accessorList)
    let newData = data.replacingChild(raw, at: Cursor.accessors)
    return AccessorBlockSyntax(newData)
  }
  public var rightBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `rightBrace` replaced.
  /// - param newChild: The new `rightBrace` to replace the node's
  ///                   current `rightBrace`, if present.
  public func withRightBrace(
    _ newChild: TokenSyntax?) -> AccessorBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return AccessorBlockSyntax(newData)
  }

  /// Determines if two `AccessorBlockSyntax` nodes are equal to each other.
  public static func ==(lhs: AccessorBlockSyntax, rhs: AccessorBlockSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PatternBindingSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case pattern
    case typeAnnotation
    case initializer
    case accessor
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `PatternBindingSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var pattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return PatternBindingSyntax(newData)
  }
  public var typeAnnotation: TypeAnnotationSyntax? {
  get {
    let child = data.child(at: Cursor.typeAnnotation, parent: self)
    if child == nil { return nil }
    return TypeAnnotationSyntax(child!)
  }
  set(value) {
    self = withTypeAnnotation(value)
  }
  }

  /// Returns a copy of the receiver with its `typeAnnotation` replaced.
  /// - param newChild: The new `typeAnnotation` to replace the node's
  ///                   current `typeAnnotation`, if present.
  public func withTypeAnnotation(
    _ newChild: TypeAnnotationSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.typeAnnotation)
    return PatternBindingSyntax(newData)
  }
  public var initializer: InitializerClauseSyntax? {
  get {
    let child = data.child(at: Cursor.initializer, parent: self)
    if child == nil { return nil }
    return InitializerClauseSyntax(child!)
  }
  set(value) {
    self = withInitializer(value)
  }
  }

  /// Returns a copy of the receiver with its `initializer` replaced.
  /// - param newChild: The new `initializer` to replace the node's
  ///                   current `initializer`, if present.
  public func withInitializer(
    _ newChild: InitializerClauseSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return PatternBindingSyntax(newData)
  }
  public var accessor: Syntax? {
  get {
    let child = data.child(at: Cursor.accessor, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) 
  }
  set(value) {
    self = withAccessor(value)
  }
  }

  /// Returns a copy of the receiver with its `accessor` replaced.
  /// - param newChild: The new `accessor` to replace the node's
  ///                   current `accessor`, if present.
  public func withAccessor(
    _ newChild: Syntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.accessor)
    return PatternBindingSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> PatternBindingSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return PatternBindingSyntax(newData)
  }

  /// Determines if two `PatternBindingSyntax` nodes are equal to each other.
  public static func ==(lhs: PatternBindingSyntax, rhs: PatternBindingSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct VariableDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case letOrVarKeyword
    case bindings
  }

  let data: SyntaxData

  /// Creates a `VariableDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> VariableDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return VariableDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return VariableDeclSyntax(newData)
  }
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> VariableDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return VariableDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return VariableDeclSyntax(newData)
  }
  public var letOrVarKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.letOrVarKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLetOrVarKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `letOrVarKeyword` replaced.
  /// - param newChild: The new `letOrVarKeyword` to replace the node's
  ///                   current `letOrVarKeyword`, if present.
  public func withLetOrVarKeyword(
    _ newChild: TokenSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.letKeyword)
    let newData = data.replacingChild(raw, at: Cursor.letOrVarKeyword)
    return VariableDeclSyntax(newData)
  }
  public var bindings: PatternBindingListSyntax {
  get {
    let child = data.child(at: Cursor.bindings, parent: self)
    return PatternBindingListSyntax(child!)
  }
  set(value) {
    self = withBindings(value)
  }
  }

  /// Adds the provided `PatternBinding` to the node's `bindings`
  /// collection.
  /// - param element: The new `PatternBinding` to add to the node's
  ///                  `bindings` collection.
  /// - returns: A copy of the receiver with the provided `PatternBinding`
  ///            appended to its `bindings` collection.
  public func addPatternBinding(_ element: PatternBindingSyntax) -> VariableDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.bindings] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.patternBindingList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.bindings)
    return VariableDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `bindings` replaced.
  /// - param newChild: The new `bindings` to replace the node's
  ///                   current `bindings`, if present.
  public func withBindings(
    _ newChild: PatternBindingListSyntax?) -> VariableDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.patternBindingList)
    let newData = data.replacingChild(raw, at: Cursor.bindings)
    return VariableDeclSyntax(newData)
  }

  /// Determines if two `VariableDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: VariableDeclSyntax, rhs: VariableDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// An element of an enum case, containing the name of the case and,          optionally, either associated values or an assignment to a raw value.
/// 
public struct EnumCaseElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case identifier
    case associatedValue
    case rawValue
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `EnumCaseElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The name of this case.
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return EnumCaseElementSyntax(newData)
  }
  /// The set of associated values of the case.
  public var associatedValue: ParameterClauseSyntax? {
  get {
    let child = data.child(at: Cursor.associatedValue, parent: self)
    if child == nil { return nil }
    return ParameterClauseSyntax(child!)
  }
  set(value) {
    self = withAssociatedValue(value)
  }
  }

  /// Returns a copy of the receiver with its `associatedValue` replaced.
  /// - param newChild: The new `associatedValue` to replace the node's
  ///                   current `associatedValue`, if present.
  public func withAssociatedValue(
    _ newChild: ParameterClauseSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.associatedValue)
    return EnumCaseElementSyntax(newData)
  }
  /// 
  /// The raw value of this enum element, if present.
  /// 
  public var rawValue: InitializerClauseSyntax? {
  get {
    let child = data.child(at: Cursor.rawValue, parent: self)
    if child == nil { return nil }
    return InitializerClauseSyntax(child!)
  }
  set(value) {
    self = withRawValue(value)
  }
  }

  /// Returns a copy of the receiver with its `rawValue` replaced.
  /// - param newChild: The new `rawValue` to replace the node's
  ///                   current `rawValue`, if present.
  public func withRawValue(
    _ newChild: InitializerClauseSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.rawValue)
    return EnumCaseElementSyntax(newData)
  }
  /// 
  /// The trailing comma of this element, if the case has                    multiple elements.
  /// 
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> EnumCaseElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return EnumCaseElementSyntax(newData)
  }

  /// Determines if two `EnumCaseElementSyntax` nodes are equal to each other.
  public static func ==(lhs: EnumCaseElementSyntax, rhs: EnumCaseElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A `case` declaration of a Swift `enum`. It can have 1 or more          `EnumCaseElement`s inside, each declaring a different case of the
/// enum.
/// 
public struct EnumCaseDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case caseKeyword
    case elements
  }

  let data: SyntaxData

  /// Creates a `EnumCaseDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// The attributes applied to the case declaration.
  /// 
  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> EnumCaseDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return EnumCaseDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return EnumCaseDeclSyntax(newData)
  }
  /// 
  /// The declaration modifiers applied to the case declaration.
  /// 
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> EnumCaseDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return EnumCaseDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return EnumCaseDeclSyntax(newData)
  }
  /// The `case` keyword for this case.
  public var caseKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.caseKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withCaseKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `caseKeyword` replaced.
  /// - param newChild: The new `caseKeyword` to replace the node's
  ///                   current `caseKeyword`, if present.
  public func withCaseKeyword(
    _ newChild: TokenSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.caseKeyword)
    let newData = data.replacingChild(raw, at: Cursor.caseKeyword)
    return EnumCaseDeclSyntax(newData)
  }
  /// The elements this case declares.
  public var elements: EnumCaseElementListSyntax {
  get {
    let child = data.child(at: Cursor.elements, parent: self)
    return EnumCaseElementListSyntax(child!)
  }
  set(value) {
    self = withElements(value)
  }
  }

  /// Adds the provided `EnumCaseElement` to the node's `elements`
  /// collection.
  /// - param element: The new `EnumCaseElement` to add to the node's
  ///                  `elements` collection.
  /// - returns: A copy of the receiver with the provided `EnumCaseElement`
  ///            appended to its `elements` collection.
  public func addEnumCaseElement(_ element: EnumCaseElementSyntax) -> EnumCaseDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.enumCaseElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return EnumCaseDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: EnumCaseElementListSyntax?) -> EnumCaseDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.enumCaseElementList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return EnumCaseDeclSyntax(newData)
  }

  /// Determines if two `EnumCaseDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: EnumCaseDeclSyntax, rhs: EnumCaseDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// A Swift `enum` declaration.
public struct EnumDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case enumKeyword
    case identifier
    case genericParameters
    case inheritanceClause
    case genericWhereClause
    case members
  }

  let data: SyntaxData

  /// Creates a `EnumDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// The attributes applied to the enum declaration.
  /// 
  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> EnumDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return EnumDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return EnumDeclSyntax(newData)
  }
  /// 
  /// The declaration modifiers applied to the enum declaration.
  /// 
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> EnumDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return EnumDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return EnumDeclSyntax(newData)
  }
  /// 
  /// The `enum` keyword for this declaration.
  /// 
  public var enumKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.enumKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withEnumKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `enumKeyword` replaced.
  /// - param newChild: The new `enumKeyword` to replace the node's
  ///                   current `enumKeyword`, if present.
  public func withEnumKeyword(
    _ newChild: TokenSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.enumKeyword)
    let newData = data.replacingChild(raw, at: Cursor.enumKeyword)
    return EnumDeclSyntax(newData)
  }
  /// 
  /// The name of this enum.
  /// 
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return EnumDeclSyntax(newData)
  }
  /// 
  /// The generic parameters, if any, for this enum.
  /// 
  public var genericParameters: GenericParameterClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericParameters, parent: self)
    if child == nil { return nil }
    return GenericParameterClauseSyntax(child!)
  }
  set(value) {
    self = withGenericParameters(value)
  }
  }

  /// Returns a copy of the receiver with its `genericParameters` replaced.
  /// - param newChild: The new `genericParameters` to replace the node's
  ///                   current `genericParameters`, if present.
  public func withGenericParameters(
    _ newChild: GenericParameterClauseSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericParameters)
    return EnumDeclSyntax(newData)
  }
  /// 
  /// The inheritance clause describing conformances or raw                    values for this enum.
  /// 
  public var inheritanceClause: TypeInheritanceClauseSyntax? {
  get {
    let child = data.child(at: Cursor.inheritanceClause, parent: self)
    if child == nil { return nil }
    return TypeInheritanceClauseSyntax(child!)
  }
  set(value) {
    self = withInheritanceClause(value)
  }
  }

  /// Returns a copy of the receiver with its `inheritanceClause` replaced.
  /// - param newChild: The new `inheritanceClause` to replace the node's
  ///                   current `inheritanceClause`, if present.
  public func withInheritanceClause(
    _ newChild: TypeInheritanceClauseSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritanceClause)
    return EnumDeclSyntax(newData)
  }
  /// 
  /// The `where` clause that applies to the generic parameters of                    this enum.
  /// 
  public var genericWhereClause: GenericWhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericWhereClause, parent: self)
    if child == nil { return nil }
    return GenericWhereClauseSyntax(child!)
  }
  set(value) {
    self = withGenericWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericWhereClause` replaced.
  /// - param newChild: The new `genericWhereClause` to replace the node's
  ///                   current `genericWhereClause`, if present.
  public func withGenericWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericWhereClause)
    return EnumDeclSyntax(newData)
  }
  /// 
  /// The cases and other members of this enum.
  /// 
  public var members: MemberDeclBlockSyntax {
  get {
    let child = data.child(at: Cursor.members, parent: self)
    return MemberDeclBlockSyntax(child!)
  }
  set(value) {
    self = withMembers(value)
  }
  }

  /// Returns a copy of the receiver with its `members` replaced.
  /// - param newChild: The new `members` to replace the node's
  ///                   current `members`, if present.
  public func withMembers(
    _ newChild: MemberDeclBlockSyntax?) -> EnumDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.memberDeclBlock)
    let newData = data.replacingChild(raw, at: Cursor.members)
    return EnumDeclSyntax(newData)
  }

  /// Determines if two `EnumDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: EnumDeclSyntax, rhs: EnumDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// A Swift `operator` declaration.
public struct OperatorDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case operatorKeyword
    case identifier
    case operatorPrecedenceAndTypes
  }

  let data: SyntaxData

  /// Creates a `OperatorDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// The attributes applied to the 'operator' declaration.
  /// 
  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> OperatorDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return OperatorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return OperatorDeclSyntax(newData)
  }
  /// 
  /// The declaration modifiers applied to the 'operator'
  /// declaration.
  /// 
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> OperatorDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return OperatorDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return OperatorDeclSyntax(newData)
  }
  public var operatorKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.operatorKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withOperatorKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `operatorKeyword` replaced.
  /// - param newChild: The new `operatorKeyword` to replace the node's
  ///                   current `operatorKeyword`, if present.
  public func withOperatorKeyword(
    _ newChild: TokenSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.operatorKeyword)
    let newData = data.replacingChild(raw, at: Cursor.operatorKeyword)
    return OperatorDeclSyntax(newData)
  }
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unspacedBinaryOperator(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return OperatorDeclSyntax(newData)
  }
  /// 
  /// Optionally specify a precedence group and designated types.
  /// 
  public var operatorPrecedenceAndTypes: OperatorPrecedenceAndTypesSyntax? {
  get {
    let child = data.child(at: Cursor.operatorPrecedenceAndTypes, parent: self)
    if child == nil { return nil }
    return OperatorPrecedenceAndTypesSyntax(child!)
  }
  set(value) {
    self = withOperatorPrecedenceAndTypes(value)
  }
  }

  /// Returns a copy of the receiver with its `operatorPrecedenceAndTypes` replaced.
  /// - param newChild: The new `operatorPrecedenceAndTypes` to replace the node's
  ///                   current `operatorPrecedenceAndTypes`, if present.
  public func withOperatorPrecedenceAndTypes(
    _ newChild: OperatorPrecedenceAndTypesSyntax?) -> OperatorDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.operatorPrecedenceAndTypes)
    return OperatorDeclSyntax(newData)
  }

  /// Determines if two `OperatorDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: OperatorDeclSyntax, rhs: OperatorDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.
/// 
public struct OperatorPrecedenceAndTypesSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case colon
    case precedenceGroupAndDesignatedTypes
  }

  let data: SyntaxData

  /// Creates a `OperatorPrecedenceAndTypesSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> OperatorPrecedenceAndTypesSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }
  /// 
  /// The precedence group and designated types for this operator
  /// 
  public var precedenceGroupAndDesignatedTypes: IdentifierListSyntax {
  get {
    let child = data.child(at: Cursor.precedenceGroupAndDesignatedTypes, parent: self)
    return IdentifierListSyntax(child!)
  }
  set(value) {
    self = withPrecedenceGroupAndDesignatedTypes(value)
  }
  }

  /// Adds the provided `IdentifierToken` to the node's `precedenceGroupAndDesignatedTypes`
  /// collection.
  /// - param element: The new `IdentifierToken` to add to the node's
  ///                  `precedenceGroupAndDesignatedTypes` collection.
  /// - returns: A copy of the receiver with the provided `IdentifierToken`
  ///            appended to its `precedenceGroupAndDesignatedTypes` collection.
  public func addIdentifierToken(_ element: TokenSyntax) -> OperatorPrecedenceAndTypesSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.precedenceGroupAndDesignatedTypes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.identifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.precedenceGroupAndDesignatedTypes)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  /// Returns a copy of the receiver with its `precedenceGroupAndDesignatedTypes` replaced.
  /// - param newChild: The new `precedenceGroupAndDesignatedTypes` to replace the node's
  ///                   current `precedenceGroupAndDesignatedTypes`, if present.
  public func withPrecedenceGroupAndDesignatedTypes(
    _ newChild: IdentifierListSyntax?) -> OperatorPrecedenceAndTypesSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.identifierList)
    let newData = data.replacingChild(raw, at: Cursor.precedenceGroupAndDesignatedTypes)
    return OperatorPrecedenceAndTypesSyntax(newData)
  }

  /// Determines if two `OperatorPrecedenceAndTypesSyntax` nodes are equal to each other.
  public static func ==(lhs: OperatorPrecedenceAndTypesSyntax, rhs: OperatorPrecedenceAndTypesSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// A Swift `precedencegroup` declaration.
public struct PrecedenceGroupDeclSyntax: DeclSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case modifiers
    case precedencegroupKeyword
    case identifier
    case leftBrace
    case groupAttributes
    case rightBrace
  }

  let data: SyntaxData

  /// Creates a `PrecedenceGroupDeclSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// The attributes applied to the 'precedencegroup' declaration.
  /// 
  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> PrecedenceGroupDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return PrecedenceGroupDeclSyntax(newData)
  }
  /// 
  /// The declaration modifiers applied to the 'precedencegroup'
  /// declaration.
  /// 
  public var modifiers: ModifierListSyntax? {
  get {
    let child = data.child(at: Cursor.modifiers, parent: self)
    if child == nil { return nil }
    return ModifierListSyntax(child!)
  }
  set(value) {
    self = withModifiers(value)
  }
  }

  /// Adds the provided `Modifier` to the node's `modifiers`
  /// collection.
  /// - param element: The new `Modifier` to add to the node's
  ///                  `modifiers` collection.
  /// - returns: A copy of the receiver with the provided `Modifier`
  ///            appended to its `modifiers` collection.
  public func addModifier(_ element: DeclModifierSyntax) -> PrecedenceGroupDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.modifiers] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.modifierList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.modifiers)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `modifiers` replaced.
  /// - param newChild: The new `modifiers` to replace the node's
  ///                   current `modifiers`, if present.
  public func withModifiers(
    _ newChild: ModifierListSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.modifiers)
    return PrecedenceGroupDeclSyntax(newData)
  }
  public var precedencegroupKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.precedencegroupKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPrecedencegroupKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `precedencegroupKeyword` replaced.
  /// - param newChild: The new `precedencegroupKeyword` to replace the node's
  ///                   current `precedencegroupKeyword`, if present.
  public func withPrecedencegroupKeyword(
    _ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.precedencegroupKeyword)
    let newData = data.replacingChild(raw, at: Cursor.precedencegroupKeyword)
    return PrecedenceGroupDeclSyntax(newData)
  }
  /// 
  /// The name of this precedence group.
  /// 
  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return PrecedenceGroupDeclSyntax(newData)
  }
  public var leftBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `leftBrace` replaced.
  /// - param newChild: The new `leftBrace` to replace the node's
  ///                   current `leftBrace`, if present.
  public func withLeftBrace(
    _ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return PrecedenceGroupDeclSyntax(newData)
  }
  /// 
  /// The characteristics of this precedence group.
  /// 
  public var groupAttributes: PrecedenceGroupAttributeListSyntax {
  get {
    let child = data.child(at: Cursor.groupAttributes, parent: self)
    return PrecedenceGroupAttributeListSyntax(child!)
  }
  set(value) {
    self = withGroupAttributes(value)
  }
  }

  /// Adds the provided `Syntax` to the node's `groupAttributes`
  /// collection.
  /// - param element: The new `Syntax` to add to the node's
  ///                  `groupAttributes` collection.
  /// - returns: A copy of the receiver with the provided `Syntax`
  ///            appended to its `groupAttributes` collection.
  public func addSyntax(_ element: Syntax) -> PrecedenceGroupDeclSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.groupAttributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.precedenceGroupAttributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.groupAttributes)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// Returns a copy of the receiver with its `groupAttributes` replaced.
  /// - param newChild: The new `groupAttributes` to replace the node's
  ///                   current `groupAttributes`, if present.
  public func withGroupAttributes(
    _ newChild: PrecedenceGroupAttributeListSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.precedenceGroupAttributeList)
    let newData = data.replacingChild(raw, at: Cursor.groupAttributes)
    return PrecedenceGroupDeclSyntax(newData)
  }
  public var rightBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `rightBrace` replaced.
  /// - param newChild: The new `rightBrace` to replace the node's
  ///                   current `rightBrace`, if present.
  public func withRightBrace(
    _ newChild: TokenSyntax?) -> PrecedenceGroupDeclSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return PrecedenceGroupDeclSyntax(newData)
  }

  /// Determines if two `PrecedenceGroupDeclSyntax` nodes are equal to each other.
  public static func ==(lhs: PrecedenceGroupDeclSyntax, rhs: PrecedenceGroupDeclSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// Specify the new precedence group's relation to existing precedence
/// groups.
/// 
public struct PrecedenceGroupRelationSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case higherThanOrLowerThan
    case colon
    case otherNames
  }

  let data: SyntaxData

  /// Creates a `PrecedenceGroupRelationSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// The relation to specified other precedence groups.
  /// 
  public var higherThanOrLowerThan: TokenSyntax {
  get {
    let child = data.child(at: Cursor.higherThanOrLowerThan, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withHigherThanOrLowerThan(value)
  }
  }

  /// Returns a copy of the receiver with its `higherThanOrLowerThan` replaced.
  /// - param newChild: The new `higherThanOrLowerThan` to replace the node's
  ///                   current `higherThanOrLowerThan`, if present.
  public func withHigherThanOrLowerThan(
    _ newChild: TokenSyntax?) -> PrecedenceGroupRelationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.higherThanOrLowerThan)
    return PrecedenceGroupRelationSyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> PrecedenceGroupRelationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return PrecedenceGroupRelationSyntax(newData)
  }
  /// 
  /// The name of other precedence group to which this precedence
  /// group relates.
  /// 
  public var otherNames: PrecedenceGroupNameListSyntax {
  get {
    let child = data.child(at: Cursor.otherNames, parent: self)
    return PrecedenceGroupNameListSyntax(child!)
  }
  set(value) {
    self = withOtherNames(value)
  }
  }

  /// Adds the provided `PrecedenceGroupNameElement` to the node's `otherNames`
  /// collection.
  /// - param element: The new `PrecedenceGroupNameElement` to add to the node's
  ///                  `otherNames` collection.
  /// - returns: A copy of the receiver with the provided `PrecedenceGroupNameElement`
  ///            appended to its `otherNames` collection.
  public func addPrecedenceGroupNameElement(_ element: PrecedenceGroupNameElementSyntax) -> PrecedenceGroupRelationSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.otherNames] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.precedenceGroupNameList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.otherNames)
    return PrecedenceGroupRelationSyntax(newData)
  }

  /// Returns a copy of the receiver with its `otherNames` replaced.
  /// - param newChild: The new `otherNames` to replace the node's
  ///                   current `otherNames`, if present.
  public func withOtherNames(
    _ newChild: PrecedenceGroupNameListSyntax?) -> PrecedenceGroupRelationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.precedenceGroupNameList)
    let newData = data.replacingChild(raw, at: Cursor.otherNames)
    return PrecedenceGroupRelationSyntax(newData)
  }

  /// Determines if two `PrecedenceGroupRelationSyntax` nodes are equal to each other.
  public static func ==(lhs: PrecedenceGroupRelationSyntax, rhs: PrecedenceGroupRelationSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PrecedenceGroupNameElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `PrecedenceGroupNameElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> PrecedenceGroupNameElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return PrecedenceGroupNameElementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> PrecedenceGroupNameElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return PrecedenceGroupNameElementSyntax(newData)
  }

  /// Determines if two `PrecedenceGroupNameElementSyntax` nodes are equal to each other.
  public static func ==(lhs: PrecedenceGroupNameElementSyntax, rhs: PrecedenceGroupNameElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// Specifies the precedence of an operator when used in an operation
/// that includes optional chaining.
/// 
public struct PrecedenceGroupAssignmentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case assignmentKeyword
    case colon
    case flag
  }

  let data: SyntaxData

  /// Creates a `PrecedenceGroupAssignmentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var assignmentKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.assignmentKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAssignmentKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `assignmentKeyword` replaced.
  /// - param newChild: The new `assignmentKeyword` to replace the node's
  ///                   current `assignmentKeyword`, if present.
  public func withAssignmentKeyword(
    _ newChild: TokenSyntax?) -> PrecedenceGroupAssignmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.assignmentKeyword)
    return PrecedenceGroupAssignmentSyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> PrecedenceGroupAssignmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return PrecedenceGroupAssignmentSyntax(newData)
  }
  /// 
  /// When true, an operator in the corresponding precedence group
  /// uses the same grouping rules during optional chaining as the
  /// assignment operators from the standard library. Otherwise,
  /// operators in the precedence group follows the same optional
  /// chaining rules as operators that don't perform assignment.
  /// 
  public var flag: TokenSyntax {
  get {
    let child = data.child(at: Cursor.flag, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withFlag(value)
  }
  }

  /// Returns a copy of the receiver with its `flag` replaced.
  /// - param newChild: The new `flag` to replace the node's
  ///                   current `flag`, if present.
  public func withFlag(
    _ newChild: TokenSyntax?) -> PrecedenceGroupAssignmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.trueKeyword)
    let newData = data.replacingChild(raw, at: Cursor.flag)
    return PrecedenceGroupAssignmentSyntax(newData)
  }

  /// Determines if two `PrecedenceGroupAssignmentSyntax` nodes are equal to each other.
  public static func ==(lhs: PrecedenceGroupAssignmentSyntax, rhs: PrecedenceGroupAssignmentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// Specifies how a sequence of operators with the same precedence level
/// are grouped together in the absence of grouping parentheses.
/// 
public struct PrecedenceGroupAssociativitySyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case associativityKeyword
    case colon
    case value
  }

  let data: SyntaxData

  /// Creates a `PrecedenceGroupAssociativitySyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var associativityKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.associativityKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAssociativityKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `associativityKeyword` replaced.
  /// - param newChild: The new `associativityKeyword` to replace the node's
  ///                   current `associativityKeyword`, if present.
  public func withAssociativityKeyword(
    _ newChild: TokenSyntax?) -> PrecedenceGroupAssociativitySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.associativityKeyword)
    return PrecedenceGroupAssociativitySyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> PrecedenceGroupAssociativitySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return PrecedenceGroupAssociativitySyntax(newData)
  }
  /// 
  /// Operators that are `left`-associative group left-to-right.
  /// Operators that are `right`-associative group right-to-left.
  /// Operators that are specified with an associativity of `none`
  /// don't associate at all
  /// 
  public var value: TokenSyntax {
  get {
    let child = data.child(at: Cursor.value, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withValue(value)
  }
  }

  /// Returns a copy of the receiver with its `value` replaced.
  /// - param newChild: The new `value` to replace the node's
  ///                   current `value`, if present.
  public func withValue(
    _ newChild: TokenSyntax?) -> PrecedenceGroupAssociativitySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.value)
    return PrecedenceGroupAssociativitySyntax(newData)
  }

  /// Determines if two `PrecedenceGroupAssociativitySyntax` nodes are equal to each other.
  public static func ==(lhs: PrecedenceGroupAssociativitySyntax, rhs: PrecedenceGroupAssociativitySyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// An `@` attribute.
/// 
public struct AttributeSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case atSignToken
    case attributeName
    case leftParen
    case argument
    case rightParen
    case tokenList
  }

  let data: SyntaxData

  /// Creates a `AttributeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The `@` sign.
  public var atSignToken: TokenSyntax {
  get {
    let child = data.child(at: Cursor.atSignToken, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAtSignToken(value)
  }
  }

  /// Returns a copy of the receiver with its `atSignToken` replaced.
  /// - param newChild: The new `atSignToken` to replace the node's
  ///                   current `atSignToken`, if present.
  public func withAtSignToken(
    _ newChild: TokenSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.atSign)
    let newData = data.replacingChild(raw, at: Cursor.atSignToken)
    return AttributeSyntax(newData)
  }
  /// The name of the attribute.
  public var attributeName: TokenSyntax {
  get {
    let child = data.child(at: Cursor.attributeName, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAttributeName(value)
  }
  }

  /// Returns a copy of the receiver with its `attributeName` replaced.
  /// - param newChild: The new `attributeName` to replace the node's
  ///                   current `attributeName`, if present.
  public func withAttributeName(
    _ newChild: TokenSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.attributeName)
    return AttributeSyntax(newData)
  }
  /// 
  /// If the attribute takes arguments, the opening parenthesis.
  /// 
  public var leftParen: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return AttributeSyntax(newData)
  }
  /// 
  /// The arguments of the attribute. In case the attribute                     takes multiple arguments, they are gather in the                    appropriate takes first.
  /// 
  public var argument: Syntax? {
  get {
    let child = data.child(at: Cursor.argument, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) 
  }
  set(value) {
    self = withArgument(value)
  }
  }

  /// Returns a copy of the receiver with its `argument` replaced.
  /// - param newChild: The new `argument` to replace the node's
  ///                   current `argument`, if present.
  public func withArgument(
    _ newChild: Syntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.argument)
    return AttributeSyntax(newData)
  }
  /// 
  /// If the attribute takes arguments, the closing parenthesis.
  /// 
  public var rightParen: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return AttributeSyntax(newData)
  }
  public var tokenList: TokenListSyntax? {
  get {
    let child = data.child(at: Cursor.tokenList, parent: self)
    if child == nil { return nil }
    return TokenListSyntax(child!)
  }
  set(value) {
    self = withTokenList(value)
  }
  }

  /// Adds the provided `Token` to the node's `tokenList`
  /// collection.
  /// - param element: The new `Token` to add to the node's
  ///                  `tokenList` collection.
  /// - returns: A copy of the receiver with the provided `Token`
  ///            appended to its `tokenList` collection.
  public func addToken(_ element: TokenSyntax) -> AttributeSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.tokenList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tokenList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.tokenList)
    return AttributeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `tokenList` replaced.
  /// - param newChild: The new `tokenList` to replace the node's
  ///                   current `tokenList`, if present.
  public func withTokenList(
    _ newChild: TokenListSyntax?) -> AttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.tokenList)
    return AttributeSyntax(newData)
  }

  /// Determines if two `AttributeSyntax` nodes are equal to each other.
  public static func ==(lhs: AttributeSyntax, rhs: AttributeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A labeled argument for the `@_specialize` attribute like          `exported: true`
/// 
public struct LabeledSpecializeEntrySyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case label
    case colon
    case value
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `LabeledSpecializeEntrySyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The label of the argument
  public var label: TokenSyntax {
  get {
    let child = data.child(at: Cursor.label, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.label)
    return LabeledSpecializeEntrySyntax(newData)
  }
  /// The colon separating the label and the value
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return LabeledSpecializeEntrySyntax(newData)
  }
  /// The value for this argument
  public var value: TokenSyntax {
  get {
    let child = data.child(at: Cursor.value, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withValue(value)
  }
  }

  /// Returns a copy of the receiver with its `value` replaced.
  /// - param newChild: The new `value` to replace the node's
  ///                   current `value`, if present.
  public func withValue(
    _ newChild: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.value)
    return LabeledSpecializeEntrySyntax(newData)
  }
  /// 
  /// A trailing comma if this argument is followed by another one
  /// 
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> LabeledSpecializeEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return LabeledSpecializeEntrySyntax(newData)
  }

  /// Determines if two `LabeledSpecializeEntrySyntax` nodes are equal to each other.
  public static func ==(lhs: LabeledSpecializeEntrySyntax, rhs: LabeledSpecializeEntrySyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// The argument for the `@_dynamic_replacement` or `@_private`          attribute of the form `for: "function()"` or `sourceFile:          "Src.swift"`
/// 
public struct NamedAttributeStringArgumentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case nameTok
    case colon
    case stringOrDeclname
  }

  let data: SyntaxData

  /// Creates a `NamedAttributeStringArgumentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The label of the argument
  public var nameTok: TokenSyntax {
  get {
    let child = data.child(at: Cursor.nameTok, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withNameTok(value)
  }
  }

  /// Returns a copy of the receiver with its `nameTok` replaced.
  /// - param newChild: The new `nameTok` to replace the node's
  ///                   current `nameTok`, if present.
  public func withNameTok(
    _ newChild: TokenSyntax?) -> NamedAttributeStringArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.unknown(""))
    let newData = data.replacingChild(raw, at: Cursor.nameTok)
    return NamedAttributeStringArgumentSyntax(newData)
  }
  /// The colon separating the label and the value
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> NamedAttributeStringArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return NamedAttributeStringArgumentSyntax(newData)
  }
  public var stringOrDeclname: Syntax {
  get {
    let child = data.child(at: Cursor.stringOrDeclname, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withStringOrDeclname(value)
  }
  }

  /// Returns a copy of the receiver with its `stringOrDeclname` replaced.
  /// - param newChild: The new `stringOrDeclname` to replace the node's
  ///                   current `stringOrDeclname`, if present.
  public func withStringOrDeclname(
    _ newChild: Syntax?) -> NamedAttributeStringArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.stringOrDeclname)
    return NamedAttributeStringArgumentSyntax(newData)
  }

  /// Determines if two `NamedAttributeStringArgumentSyntax` nodes are equal to each other.
  public static func ==(lhs: NamedAttributeStringArgumentSyntax, rhs: NamedAttributeStringArgumentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DeclNameSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case declBaseName
    case declNameArguments
  }

  let data: SyntaxData

  /// Creates a `DeclNameSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// The base name of the protocol's requirement.
  /// 
  public var declBaseName: Syntax {
  get {
    let child = data.child(at: Cursor.declBaseName, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withDeclBaseName(value)
  }
  }

  /// Returns a copy of the receiver with its `declBaseName` replaced.
  /// - param newChild: The new `declBaseName` to replace the node's
  ///                   current `declBaseName`, if present.
  public func withDeclBaseName(
    _ newChild: Syntax?) -> DeclNameSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.declBaseName)
    return DeclNameSyntax(newData)
  }
  /// 
  /// The argument labels of the protocol's requirement if it                is a function requirement.
  /// 
  public var declNameArguments: DeclNameArgumentsSyntax? {
  get {
    let child = data.child(at: Cursor.declNameArguments, parent: self)
    if child == nil { return nil }
    return DeclNameArgumentsSyntax(child!)
  }
  set(value) {
    self = withDeclNameArguments(value)
  }
  }

  /// Returns a copy of the receiver with its `declNameArguments` replaced.
  /// - param newChild: The new `declNameArguments` to replace the node's
  ///                   current `declNameArguments`, if present.
  public func withDeclNameArguments(
    _ newChild: DeclNameArgumentsSyntax?) -> DeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.declNameArguments)
    return DeclNameSyntax(newData)
  }

  /// Determines if two `DeclNameSyntax` nodes are equal to each other.
  public static func ==(lhs: DeclNameSyntax, rhs: DeclNameSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// The arguments for the `@_implements` attribute of the form          `Type, methodName(arg1Label:arg2Label:)`
/// 
public struct ImplementsAttributeArgumentsSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case type
    case comma
    case declBaseName
    case declNameArguments
  }

  let data: SyntaxData

  /// Creates a `ImplementsAttributeArgumentsSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// The type for which the method with this attribute                    implements a requirement.
  /// 
  public var type: SimpleTypeIdentifierSyntax {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    return SimpleTypeIdentifierSyntax(child!)
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: SimpleTypeIdentifierSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.simpleTypeIdentifier)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return ImplementsAttributeArgumentsSyntax(newData)
  }
  /// 
  /// The comma separating the type and method name
  /// 
  public var comma: TokenSyntax {
  get {
    let child = data.child(at: Cursor.comma, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withComma(value)
  }
  }

  /// Returns a copy of the receiver with its `comma` replaced.
  /// - param newChild: The new `comma` to replace the node's
  ///                   current `comma`, if present.
  public func withComma(
    _ newChild: TokenSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.comma)
    let newData = data.replacingChild(raw, at: Cursor.comma)
    return ImplementsAttributeArgumentsSyntax(newData)
  }
  /// 
  /// The base name of the protocol's requirement.
  /// 
  public var declBaseName: Syntax {
  get {
    let child = data.child(at: Cursor.declBaseName, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withDeclBaseName(value)
  }
  }

  /// Returns a copy of the receiver with its `declBaseName` replaced.
  /// - param newChild: The new `declBaseName` to replace the node's
  ///                   current `declBaseName`, if present.
  public func withDeclBaseName(
    _ newChild: Syntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.declBaseName)
    return ImplementsAttributeArgumentsSyntax(newData)
  }
  /// 
  /// The argument labels of the protocol's requirement if it                    is a function requirement.
  /// 
  public var declNameArguments: DeclNameArgumentsSyntax? {
  get {
    let child = data.child(at: Cursor.declNameArguments, parent: self)
    if child == nil { return nil }
    return DeclNameArgumentsSyntax(child!)
  }
  set(value) {
    self = withDeclNameArguments(value)
  }
  }

  /// Returns a copy of the receiver with its `declNameArguments` replaced.
  /// - param newChild: The new `declNameArguments` to replace the node's
  ///                   current `declNameArguments`, if present.
  public func withDeclNameArguments(
    _ newChild: DeclNameArgumentsSyntax?) -> ImplementsAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.declNameArguments)
    return ImplementsAttributeArgumentsSyntax(newData)
  }

  /// Determines if two `ImplementsAttributeArgumentsSyntax` nodes are equal to each other.
  public static func ==(lhs: ImplementsAttributeArgumentsSyntax, rhs: ImplementsAttributeArgumentsSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A piece of an Objective-C selector. Either consisiting of just an          identifier for a nullary selector, an identifier and a colon for a          labeled argument or just a colon for an unlabeled argument
/// 
public struct ObjCSelectorPieceSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case colon
  }

  let data: SyntaxData

  /// Creates a `ObjCSelectorPieceSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> ObjCSelectorPieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.name)
    return ObjCSelectorPieceSyntax(newData)
  }
  public var colon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> ObjCSelectorPieceSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return ObjCSelectorPieceSyntax(newData)
  }

  /// Determines if two `ObjCSelectorPieceSyntax` nodes are equal to each other.
  public static func ==(lhs: ObjCSelectorPieceSyntax, rhs: ObjCSelectorPieceSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ContinueStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case continueKeyword
    case label
  }

  let data: SyntaxData

  /// Creates a `ContinueStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var continueKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.continueKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withContinueKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `continueKeyword` replaced.
  /// - param newChild: The new `continueKeyword` to replace the node's
  ///                   current `continueKeyword`, if present.
  public func withContinueKeyword(
    _ newChild: TokenSyntax?) -> ContinueStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.continueKeyword)
    let newData = data.replacingChild(raw, at: Cursor.continueKeyword)
    return ContinueStmtSyntax(newData)
  }
  public var label: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.label, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> ContinueStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.label)
    return ContinueStmtSyntax(newData)
  }

  /// Determines if two `ContinueStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: ContinueStmtSyntax, rhs: ContinueStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct WhileStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case labelName
    case labelColon
    case whileKeyword
    case conditions
    case body
  }

  let data: SyntaxData

  /// Creates a `WhileStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var labelName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelName(value)
  }
  }

  /// Returns a copy of the receiver with its `labelName` replaced.
  /// - param newChild: The new `labelName` to replace the node's
  ///                   current `labelName`, if present.
  public func withLabelName(
    _ newChild: TokenSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelName)
    return WhileStmtSyntax(newData)
  }
  public var labelColon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelColon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelColon(value)
  }
  }

  /// Returns a copy of the receiver with its `labelColon` replaced.
  /// - param newChild: The new `labelColon` to replace the node's
  ///                   current `labelColon`, if present.
  public func withLabelColon(
    _ newChild: TokenSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelColon)
    return WhileStmtSyntax(newData)
  }
  public var whileKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.whileKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withWhileKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `whileKeyword` replaced.
  /// - param newChild: The new `whileKeyword` to replace the node's
  ///                   current `whileKeyword`, if present.
  public func withWhileKeyword(
    _ newChild: TokenSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.whileKeyword)
    let newData = data.replacingChild(raw, at: Cursor.whileKeyword)
    return WhileStmtSyntax(newData)
  }
  public var conditions: ConditionElementListSyntax {
  get {
    let child = data.child(at: Cursor.conditions, parent: self)
    return ConditionElementListSyntax(child!)
  }
  set(value) {
    self = withConditions(value)
  }
  }

  /// Adds the provided `ConditionElement` to the node's `conditions`
  /// collection.
  /// - param element: The new `ConditionElement` to add to the node's
  ///                  `conditions` collection.
  /// - returns: A copy of the receiver with the provided `ConditionElement`
  ///            appended to its `conditions` collection.
  public func addConditionElement(_ element: ConditionElementSyntax) -> WhileStmtSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.conditions] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.conditions)
    return WhileStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `conditions` replaced.
  /// - param newChild: The new `conditions` to replace the node's
  ///                   current `conditions`, if present.
  public func withConditions(
    _ newChild: ConditionElementListSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.conditionElementList)
    let newData = data.replacingChild(raw, at: Cursor.conditions)
    return WhileStmtSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> WhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return WhileStmtSyntax(newData)
  }

  /// Determines if two `WhileStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: WhileStmtSyntax, rhs: WhileStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DeferStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case deferKeyword
    case body
  }

  let data: SyntaxData

  /// Creates a `DeferStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var deferKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.deferKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDeferKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `deferKeyword` replaced.
  /// - param newChild: The new `deferKeyword` to replace the node's
  ///                   current `deferKeyword`, if present.
  public func withDeferKeyword(
    _ newChild: TokenSyntax?) -> DeferStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.deferKeyword)
    let newData = data.replacingChild(raw, at: Cursor.deferKeyword)
    return DeferStmtSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> DeferStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return DeferStmtSyntax(newData)
  }

  /// Determines if two `DeferStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: DeferStmtSyntax, rhs: DeferStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ExpressionStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case expression
  }

  let data: SyntaxData

  /// Creates a `ExpressionStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> ExpressionStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ExpressionStmtSyntax(newData)
  }

  /// Determines if two `ExpressionStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: ExpressionStmtSyntax, rhs: ExpressionStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct RepeatWhileStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case labelName
    case labelColon
    case repeatKeyword
    case body
    case whileKeyword
    case condition
  }

  let data: SyntaxData

  /// Creates a `RepeatWhileStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var labelName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelName(value)
  }
  }

  /// Returns a copy of the receiver with its `labelName` replaced.
  /// - param newChild: The new `labelName` to replace the node's
  ///                   current `labelName`, if present.
  public func withLabelName(
    _ newChild: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelName)
    return RepeatWhileStmtSyntax(newData)
  }
  public var labelColon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelColon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelColon(value)
  }
  }

  /// Returns a copy of the receiver with its `labelColon` replaced.
  /// - param newChild: The new `labelColon` to replace the node's
  ///                   current `labelColon`, if present.
  public func withLabelColon(
    _ newChild: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelColon)
    return RepeatWhileStmtSyntax(newData)
  }
  public var repeatKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.repeatKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRepeatKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `repeatKeyword` replaced.
  /// - param newChild: The new `repeatKeyword` to replace the node's
  ///                   current `repeatKeyword`, if present.
  public func withRepeatKeyword(
    _ newChild: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.repeatKeyword)
    let newData = data.replacingChild(raw, at: Cursor.repeatKeyword)
    return RepeatWhileStmtSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return RepeatWhileStmtSyntax(newData)
  }
  public var whileKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.whileKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withWhileKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `whileKeyword` replaced.
  /// - param newChild: The new `whileKeyword` to replace the node's
  ///                   current `whileKeyword`, if present.
  public func withWhileKeyword(
    _ newChild: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.whileKeyword)
    let newData = data.replacingChild(raw, at: Cursor.whileKeyword)
    return RepeatWhileStmtSyntax(newData)
  }
  public var condition: ExprSyntax {
  get {
    let child = data.child(at: Cursor.condition, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withCondition(value)
  }
  }

  /// Returns a copy of the receiver with its `condition` replaced.
  /// - param newChild: The new `condition` to replace the node's
  ///                   current `condition`, if present.
  public func withCondition(
    _ newChild: ExprSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.condition)
    return RepeatWhileStmtSyntax(newData)
  }

  /// Determines if two `RepeatWhileStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: RepeatWhileStmtSyntax, rhs: RepeatWhileStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct GuardStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case guardKeyword
    case conditions
    case elseKeyword
    case body
  }

  let data: SyntaxData

  /// Creates a `GuardStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var guardKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.guardKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withGuardKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `guardKeyword` replaced.
  /// - param newChild: The new `guardKeyword` to replace the node's
  ///                   current `guardKeyword`, if present.
  public func withGuardKeyword(
    _ newChild: TokenSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.guardKeyword)
    let newData = data.replacingChild(raw, at: Cursor.guardKeyword)
    return GuardStmtSyntax(newData)
  }
  public var conditions: ConditionElementListSyntax {
  get {
    let child = data.child(at: Cursor.conditions, parent: self)
    return ConditionElementListSyntax(child!)
  }
  set(value) {
    self = withConditions(value)
  }
  }

  /// Adds the provided `ConditionElement` to the node's `conditions`
  /// collection.
  /// - param element: The new `ConditionElement` to add to the node's
  ///                  `conditions` collection.
  /// - returns: A copy of the receiver with the provided `ConditionElement`
  ///            appended to its `conditions` collection.
  public func addConditionElement(_ element: ConditionElementSyntax) -> GuardStmtSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.conditions] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.conditions)
    return GuardStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `conditions` replaced.
  /// - param newChild: The new `conditions` to replace the node's
  ///                   current `conditions`, if present.
  public func withConditions(
    _ newChild: ConditionElementListSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.conditionElementList)
    let newData = data.replacingChild(raw, at: Cursor.conditions)
    return GuardStmtSyntax(newData)
  }
  public var elseKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.elseKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withElseKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `elseKeyword` replaced.
  /// - param newChild: The new `elseKeyword` to replace the node's
  ///                   current `elseKeyword`, if present.
  public func withElseKeyword(
    _ newChild: TokenSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.elseKeyword)
    let newData = data.replacingChild(raw, at: Cursor.elseKeyword)
    return GuardStmtSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> GuardStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return GuardStmtSyntax(newData)
  }

  /// Determines if two `GuardStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: GuardStmtSyntax, rhs: GuardStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct WhereClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case whereKeyword
    case guardResult
  }

  let data: SyntaxData

  /// Creates a `WhereClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var whereKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.whereKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withWhereKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `whereKeyword` replaced.
  /// - param newChild: The new `whereKeyword` to replace the node's
  ///                   current `whereKeyword`, if present.
  public func withWhereKeyword(
    _ newChild: TokenSyntax?) -> WhereClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.whereKeyword)
    let newData = data.replacingChild(raw, at: Cursor.whereKeyword)
    return WhereClauseSyntax(newData)
  }
  public var guardResult: ExprSyntax {
  get {
    let child = data.child(at: Cursor.guardResult, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withGuardResult(value)
  }
  }

  /// Returns a copy of the receiver with its `guardResult` replaced.
  /// - param newChild: The new `guardResult` to replace the node's
  ///                   current `guardResult`, if present.
  public func withGuardResult(
    _ newChild: ExprSyntax?) -> WhereClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.guardResult)
    return WhereClauseSyntax(newData)
  }

  /// Determines if two `WhereClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: WhereClauseSyntax, rhs: WhereClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ForInStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case labelName
    case labelColon
    case forKeyword
    case caseKeyword
    case pattern
    case typeAnnotation
    case inKeyword
    case sequenceExpr
    case whereClause
    case body
  }

  let data: SyntaxData

  /// Creates a `ForInStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var labelName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelName(value)
  }
  }

  /// Returns a copy of the receiver with its `labelName` replaced.
  /// - param newChild: The new `labelName` to replace the node's
  ///                   current `labelName`, if present.
  public func withLabelName(
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelName)
    return ForInStmtSyntax(newData)
  }
  public var labelColon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelColon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelColon(value)
  }
  }

  /// Returns a copy of the receiver with its `labelColon` replaced.
  /// - param newChild: The new `labelColon` to replace the node's
  ///                   current `labelColon`, if present.
  public func withLabelColon(
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelColon)
    return ForInStmtSyntax(newData)
  }
  public var forKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.forKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withForKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `forKeyword` replaced.
  /// - param newChild: The new `forKeyword` to replace the node's
  ///                   current `forKeyword`, if present.
  public func withForKeyword(
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.forKeyword)
    let newData = data.replacingChild(raw, at: Cursor.forKeyword)
    return ForInStmtSyntax(newData)
  }
  public var caseKeyword: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.caseKeyword, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withCaseKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `caseKeyword` replaced.
  /// - param newChild: The new `caseKeyword` to replace the node's
  ///                   current `caseKeyword`, if present.
  public func withCaseKeyword(
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.caseKeyword)
    return ForInStmtSyntax(newData)
  }
  public var pattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return ForInStmtSyntax(newData)
  }
  public var typeAnnotation: TypeAnnotationSyntax? {
  get {
    let child = data.child(at: Cursor.typeAnnotation, parent: self)
    if child == nil { return nil }
    return TypeAnnotationSyntax(child!)
  }
  set(value) {
    self = withTypeAnnotation(value)
  }
  }

  /// Returns a copy of the receiver with its `typeAnnotation` replaced.
  /// - param newChild: The new `typeAnnotation` to replace the node's
  ///                   current `typeAnnotation`, if present.
  public func withTypeAnnotation(
    _ newChild: TypeAnnotationSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.typeAnnotation)
    return ForInStmtSyntax(newData)
  }
  public var inKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.inKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withInKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `inKeyword` replaced.
  /// - param newChild: The new `inKeyword` to replace the node's
  ///                   current `inKeyword`, if present.
  public func withInKeyword(
    _ newChild: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.inKeyword)
    let newData = data.replacingChild(raw, at: Cursor.inKeyword)
    return ForInStmtSyntax(newData)
  }
  public var sequenceExpr: ExprSyntax {
  get {
    let child = data.child(at: Cursor.sequenceExpr, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withSequenceExpr(value)
  }
  }

  /// Returns a copy of the receiver with its `sequenceExpr` replaced.
  /// - param newChild: The new `sequenceExpr` to replace the node's
  ///                   current `sequenceExpr`, if present.
  public func withSequenceExpr(
    _ newChild: ExprSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.sequenceExpr)
    return ForInStmtSyntax(newData)
  }
  public var whereClause: WhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.whereClause, parent: self)
    if child == nil { return nil }
    return WhereClauseSyntax(child!)
  }
  set(value) {
    self = withWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `whereClause` replaced.
  /// - param newChild: The new `whereClause` to replace the node's
  ///                   current `whereClause`, if present.
  public func withWhereClause(
    _ newChild: WhereClauseSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.whereClause)
    return ForInStmtSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> ForInStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return ForInStmtSyntax(newData)
  }

  /// Determines if two `ForInStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: ForInStmtSyntax, rhs: ForInStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SwitchStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case labelName
    case labelColon
    case switchKeyword
    case expression
    case leftBrace
    case cases
    case rightBrace
  }

  let data: SyntaxData

  /// Creates a `SwitchStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var labelName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelName(value)
  }
  }

  /// Returns a copy of the receiver with its `labelName` replaced.
  /// - param newChild: The new `labelName` to replace the node's
  ///                   current `labelName`, if present.
  public func withLabelName(
    _ newChild: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelName)
    return SwitchStmtSyntax(newData)
  }
  public var labelColon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelColon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelColon(value)
  }
  }

  /// Returns a copy of the receiver with its `labelColon` replaced.
  /// - param newChild: The new `labelColon` to replace the node's
  ///                   current `labelColon`, if present.
  public func withLabelColon(
    _ newChild: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelColon)
    return SwitchStmtSyntax(newData)
  }
  public var switchKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.switchKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withSwitchKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `switchKeyword` replaced.
  /// - param newChild: The new `switchKeyword` to replace the node's
  ///                   current `switchKeyword`, if present.
  public func withSwitchKeyword(
    _ newChild: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.switchKeyword)
    let newData = data.replacingChild(raw, at: Cursor.switchKeyword)
    return SwitchStmtSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return SwitchStmtSyntax(newData)
  }
  public var leftBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `leftBrace` replaced.
  /// - param newChild: The new `leftBrace` to replace the node's
  ///                   current `leftBrace`, if present.
  public func withLeftBrace(
    _ newChild: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftBrace)
    let newData = data.replacingChild(raw, at: Cursor.leftBrace)
    return SwitchStmtSyntax(newData)
  }
  public var cases: SwitchCaseListSyntax {
  get {
    let child = data.child(at: Cursor.cases, parent: self)
    return SwitchCaseListSyntax(child!)
  }
  set(value) {
    self = withCases(value)
  }
  }

  /// Adds the provided `Syntax` to the node's `cases`
  /// collection.
  /// - param element: The new `Syntax` to add to the node's
  ///                  `cases` collection.
  /// - returns: A copy of the receiver with the provided `Syntax`
  ///            appended to its `cases` collection.
  public func addSyntax(_ element: Syntax) -> SwitchStmtSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.cases] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.switchCaseList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.cases)
    return SwitchStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `cases` replaced.
  /// - param newChild: The new `cases` to replace the node's
  ///                   current `cases`, if present.
  public func withCases(
    _ newChild: SwitchCaseListSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.switchCaseList)
    let newData = data.replacingChild(raw, at: Cursor.cases)
    return SwitchStmtSyntax(newData)
  }
  public var rightBrace: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightBrace, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightBrace(value)
  }
  }

  /// Returns a copy of the receiver with its `rightBrace` replaced.
  /// - param newChild: The new `rightBrace` to replace the node's
  ///                   current `rightBrace`, if present.
  public func withRightBrace(
    _ newChild: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightBrace)
    let newData = data.replacingChild(raw, at: Cursor.rightBrace)
    return SwitchStmtSyntax(newData)
  }

  /// Determines if two `SwitchStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: SwitchStmtSyntax, rhs: SwitchStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DoStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case labelName
    case labelColon
    case doKeyword
    case body
    case catchClauses
  }

  let data: SyntaxData

  /// Creates a `DoStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var labelName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelName(value)
  }
  }

  /// Returns a copy of the receiver with its `labelName` replaced.
  /// - param newChild: The new `labelName` to replace the node's
  ///                   current `labelName`, if present.
  public func withLabelName(
    _ newChild: TokenSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelName)
    return DoStmtSyntax(newData)
  }
  public var labelColon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelColon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelColon(value)
  }
  }

  /// Returns a copy of the receiver with its `labelColon` replaced.
  /// - param newChild: The new `labelColon` to replace the node's
  ///                   current `labelColon`, if present.
  public func withLabelColon(
    _ newChild: TokenSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelColon)
    return DoStmtSyntax(newData)
  }
  public var doKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.doKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDoKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `doKeyword` replaced.
  /// - param newChild: The new `doKeyword` to replace the node's
  ///                   current `doKeyword`, if present.
  public func withDoKeyword(
    _ newChild: TokenSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.doKeyword)
    let newData = data.replacingChild(raw, at: Cursor.doKeyword)
    return DoStmtSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return DoStmtSyntax(newData)
  }
  public var catchClauses: CatchClauseListSyntax? {
  get {
    let child = data.child(at: Cursor.catchClauses, parent: self)
    if child == nil { return nil }
    return CatchClauseListSyntax(child!)
  }
  set(value) {
    self = withCatchClauses(value)
  }
  }

  /// Adds the provided `CatchClause` to the node's `catchClauses`
  /// collection.
  /// - param element: The new `CatchClause` to add to the node's
  ///                  `catchClauses` collection.
  /// - returns: A copy of the receiver with the provided `CatchClause`
  ///            appended to its `catchClauses` collection.
  public func addCatchClause(_ element: CatchClauseSyntax) -> DoStmtSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.catchClauses] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.catchClauseList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.catchClauses)
    return DoStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `catchClauses` replaced.
  /// - param newChild: The new `catchClauses` to replace the node's
  ///                   current `catchClauses`, if present.
  public func withCatchClauses(
    _ newChild: CatchClauseListSyntax?) -> DoStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.catchClauses)
    return DoStmtSyntax(newData)
  }

  /// Determines if two `DoStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: DoStmtSyntax, rhs: DoStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ReturnStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case returnKeyword
    case expression
  }

  let data: SyntaxData

  /// Creates a `ReturnStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var returnKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.returnKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withReturnKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `returnKeyword` replaced.
  /// - param newChild: The new `returnKeyword` to replace the node's
  ///                   current `returnKeyword`, if present.
  public func withReturnKeyword(
    _ newChild: TokenSyntax?) -> ReturnStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.returnKeyword)
    let newData = data.replacingChild(raw, at: Cursor.returnKeyword)
    return ReturnStmtSyntax(newData)
  }
  public var expression: ExprSyntax? {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) as? ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> ReturnStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ReturnStmtSyntax(newData)
  }

  /// Determines if two `ReturnStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: ReturnStmtSyntax, rhs: ReturnStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct YieldStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case yieldKeyword
    case yields
  }

  let data: SyntaxData

  /// Creates a `YieldStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var yieldKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.yieldKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withYieldKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `yieldKeyword` replaced.
  /// - param newChild: The new `yieldKeyword` to replace the node's
  ///                   current `yieldKeyword`, if present.
  public func withYieldKeyword(
    _ newChild: TokenSyntax?) -> YieldStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.yield)
    let newData = data.replacingChild(raw, at: Cursor.yieldKeyword)
    return YieldStmtSyntax(newData)
  }
  public var yields: Syntax {
  get {
    let child = data.child(at: Cursor.yields, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withYields(value)
  }
  }

  /// Returns a copy of the receiver with its `yields` replaced.
  /// - param newChild: The new `yields` to replace the node's
  ///                   current `yields`, if present.
  public func withYields(
    _ newChild: Syntax?) -> YieldStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.yields)
    return YieldStmtSyntax(newData)
  }

  /// Determines if two `YieldStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: YieldStmtSyntax, rhs: YieldStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct YieldListSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftParen
    case elementList
    case trailingComma
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `YieldListSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return YieldListSyntax(newData)
  }
  public var elementList: ExprListSyntax {
  get {
    let child = data.child(at: Cursor.elementList, parent: self)
    return ExprListSyntax(child!)
  }
  set(value) {
    self = withElementList(value)
  }
  }

  /// Adds the provided `Expression` to the node's `elementList`
  /// collection.
  /// - param element: The new `Expression` to add to the node's
  ///                  `elementList` collection.
  /// - returns: A copy of the receiver with the provided `Expression`
  ///            appended to its `elementList` collection.
  public func addExpression(_ element: ExprSyntax) -> YieldListSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elementList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.exprList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elementList)
    return YieldListSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elementList` replaced.
  /// - param newChild: The new `elementList` to replace the node's
  ///                   current `elementList`, if present.
  public func withElementList(
    _ newChild: ExprListSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.exprList)
    let newData = data.replacingChild(raw, at: Cursor.elementList)
    return YieldListSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return YieldListSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> YieldListSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return YieldListSyntax(newData)
  }

  /// Determines if two `YieldListSyntax` nodes are equal to each other.
  public static func ==(lhs: YieldListSyntax, rhs: YieldListSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct FallthroughStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case fallthroughKeyword
  }

  let data: SyntaxData

  /// Creates a `FallthroughStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var fallthroughKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.fallthroughKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withFallthroughKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `fallthroughKeyword` replaced.
  /// - param newChild: The new `fallthroughKeyword` to replace the node's
  ///                   current `fallthroughKeyword`, if present.
  public func withFallthroughKeyword(
    _ newChild: TokenSyntax?) -> FallthroughStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.fallthroughKeyword)
    let newData = data.replacingChild(raw, at: Cursor.fallthroughKeyword)
    return FallthroughStmtSyntax(newData)
  }

  /// Determines if two `FallthroughStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: FallthroughStmtSyntax, rhs: FallthroughStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct BreakStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case breakKeyword
    case label
  }

  let data: SyntaxData

  /// Creates a `BreakStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var breakKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.breakKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withBreakKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `breakKeyword` replaced.
  /// - param newChild: The new `breakKeyword` to replace the node's
  ///                   current `breakKeyword`, if present.
  public func withBreakKeyword(
    _ newChild: TokenSyntax?) -> BreakStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.breakKeyword)
    let newData = data.replacingChild(raw, at: Cursor.breakKeyword)
    return BreakStmtSyntax(newData)
  }
  public var label: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.label, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> BreakStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.label)
    return BreakStmtSyntax(newData)
  }

  /// Determines if two `BreakStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: BreakStmtSyntax, rhs: BreakStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ConditionElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case condition
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `ConditionElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var condition: Syntax {
  get {
    let child = data.child(at: Cursor.condition, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withCondition(value)
  }
  }

  /// Returns a copy of the receiver with its `condition` replaced.
  /// - param newChild: The new `condition` to replace the node's
  ///                   current `condition`, if present.
  public func withCondition(
    _ newChild: Syntax?) -> ConditionElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.condition)
    return ConditionElementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> ConditionElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return ConditionElementSyntax(newData)
  }

  /// Determines if two `ConditionElementSyntax` nodes are equal to each other.
  public static func ==(lhs: ConditionElementSyntax, rhs: ConditionElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AvailabilityConditionSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundAvailableKeyword
    case leftParen
    case availabilitySpec
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `AvailabilityConditionSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundAvailableKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundAvailableKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundAvailableKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `poundAvailableKeyword` replaced.
  /// - param newChild: The new `poundAvailableKeyword` to replace the node's
  ///                   current `poundAvailableKeyword`, if present.
  public func withPoundAvailableKeyword(
    _ newChild: TokenSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundAvailableKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundAvailableKeyword)
    return AvailabilityConditionSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return AvailabilityConditionSyntax(newData)
  }
  public var availabilitySpec: AvailabilitySpecListSyntax {
  get {
    let child = data.child(at: Cursor.availabilitySpec, parent: self)
    return AvailabilitySpecListSyntax(child!)
  }
  set(value) {
    self = withAvailabilitySpec(value)
  }
  }

  /// Adds the provided `AvailabilityArgument` to the node's `availabilitySpec`
  /// collection.
  /// - param element: The new `AvailabilityArgument` to add to the node's
  ///                  `availabilitySpec` collection.
  /// - returns: A copy of the receiver with the provided `AvailabilityArgument`
  ///            appended to its `availabilitySpec` collection.
  public func addAvailabilityArgument(_ element: AvailabilityArgumentSyntax) -> AvailabilityConditionSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.availabilitySpec] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.availabilitySpecList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.availabilitySpec)
    return AvailabilityConditionSyntax(newData)
  }

  /// Returns a copy of the receiver with its `availabilitySpec` replaced.
  /// - param newChild: The new `availabilitySpec` to replace the node's
  ///                   current `availabilitySpec`, if present.
  public func withAvailabilitySpec(
    _ newChild: AvailabilitySpecListSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.availabilitySpecList)
    let newData = data.replacingChild(raw, at: Cursor.availabilitySpec)
    return AvailabilityConditionSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> AvailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return AvailabilityConditionSyntax(newData)
  }

  /// Determines if two `AvailabilityConditionSyntax` nodes are equal to each other.
  public static func ==(lhs: AvailabilityConditionSyntax, rhs: AvailabilityConditionSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct MatchingPatternConditionSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case caseKeyword
    case pattern
    case typeAnnotation
    case initializer
  }

  let data: SyntaxData

  /// Creates a `MatchingPatternConditionSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var caseKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.caseKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withCaseKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `caseKeyword` replaced.
  /// - param newChild: The new `caseKeyword` to replace the node's
  ///                   current `caseKeyword`, if present.
  public func withCaseKeyword(
    _ newChild: TokenSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.caseKeyword)
    let newData = data.replacingChild(raw, at: Cursor.caseKeyword)
    return MatchingPatternConditionSyntax(newData)
  }
  public var pattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return MatchingPatternConditionSyntax(newData)
  }
  public var typeAnnotation: TypeAnnotationSyntax? {
  get {
    let child = data.child(at: Cursor.typeAnnotation, parent: self)
    if child == nil { return nil }
    return TypeAnnotationSyntax(child!)
  }
  set(value) {
    self = withTypeAnnotation(value)
  }
  }

  /// Returns a copy of the receiver with its `typeAnnotation` replaced.
  /// - param newChild: The new `typeAnnotation` to replace the node's
  ///                   current `typeAnnotation`, if present.
  public func withTypeAnnotation(
    _ newChild: TypeAnnotationSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.typeAnnotation)
    return MatchingPatternConditionSyntax(newData)
  }
  public var initializer: InitializerClauseSyntax {
  get {
    let child = data.child(at: Cursor.initializer, parent: self)
    return InitializerClauseSyntax(child!)
  }
  set(value) {
    self = withInitializer(value)
  }
  }

  /// Returns a copy of the receiver with its `initializer` replaced.
  /// - param newChild: The new `initializer` to replace the node's
  ///                   current `initializer`, if present.
  public func withInitializer(
    _ newChild: InitializerClauseSyntax?) -> MatchingPatternConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.initializerClause)
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return MatchingPatternConditionSyntax(newData)
  }

  /// Determines if two `MatchingPatternConditionSyntax` nodes are equal to each other.
  public static func ==(lhs: MatchingPatternConditionSyntax, rhs: MatchingPatternConditionSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct OptionalBindingConditionSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case letOrVarKeyword
    case pattern
    case typeAnnotation
    case initializer
  }

  let data: SyntaxData

  /// Creates a `OptionalBindingConditionSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var letOrVarKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.letOrVarKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLetOrVarKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `letOrVarKeyword` replaced.
  /// - param newChild: The new `letOrVarKeyword` to replace the node's
  ///                   current `letOrVarKeyword`, if present.
  public func withLetOrVarKeyword(
    _ newChild: TokenSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.letKeyword)
    let newData = data.replacingChild(raw, at: Cursor.letOrVarKeyword)
    return OptionalBindingConditionSyntax(newData)
  }
  public var pattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return OptionalBindingConditionSyntax(newData)
  }
  public var typeAnnotation: TypeAnnotationSyntax? {
  get {
    let child = data.child(at: Cursor.typeAnnotation, parent: self)
    if child == nil { return nil }
    return TypeAnnotationSyntax(child!)
  }
  set(value) {
    self = withTypeAnnotation(value)
  }
  }

  /// Returns a copy of the receiver with its `typeAnnotation` replaced.
  /// - param newChild: The new `typeAnnotation` to replace the node's
  ///                   current `typeAnnotation`, if present.
  public func withTypeAnnotation(
    _ newChild: TypeAnnotationSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.typeAnnotation)
    return OptionalBindingConditionSyntax(newData)
  }
  public var initializer: InitializerClauseSyntax {
  get {
    let child = data.child(at: Cursor.initializer, parent: self)
    return InitializerClauseSyntax(child!)
  }
  set(value) {
    self = withInitializer(value)
  }
  }

  /// Returns a copy of the receiver with its `initializer` replaced.
  /// - param newChild: The new `initializer` to replace the node's
  ///                   current `initializer`, if present.
  public func withInitializer(
    _ newChild: InitializerClauseSyntax?) -> OptionalBindingConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.initializerClause)
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return OptionalBindingConditionSyntax(newData)
  }

  /// Determines if two `OptionalBindingConditionSyntax` nodes are equal to each other.
  public static func ==(lhs: OptionalBindingConditionSyntax, rhs: OptionalBindingConditionSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DeclarationStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case declaration
  }

  let data: SyntaxData

  /// Creates a `DeclarationStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var declaration: DeclSyntax {
  get {
    let child = data.child(at: Cursor.declaration, parent: self)
    return makeSyntax(child!) as! DeclSyntax
  }
  set(value) {
    self = withDeclaration(value)
  }
  }

  /// Returns a copy of the receiver with its `declaration` replaced.
  /// - param newChild: The new `declaration` to replace the node's
  ///                   current `declaration`, if present.
  public func withDeclaration(
    _ newChild: DeclSyntax?) -> DeclarationStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.decl)
    let newData = data.replacingChild(raw, at: Cursor.declaration)
    return DeclarationStmtSyntax(newData)
  }

  /// Determines if two `DeclarationStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: DeclarationStmtSyntax, rhs: DeclarationStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ThrowStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case throwKeyword
    case expression
  }

  let data: SyntaxData

  /// Creates a `ThrowStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var throwKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.throwKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withThrowKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `throwKeyword` replaced.
  /// - param newChild: The new `throwKeyword` to replace the node's
  ///                   current `throwKeyword`, if present.
  public func withThrowKeyword(
    _ newChild: TokenSyntax?) -> ThrowStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.throwKeyword)
    let newData = data.replacingChild(raw, at: Cursor.throwKeyword)
    return ThrowStmtSyntax(newData)
  }
  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> ThrowStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ThrowStmtSyntax(newData)
  }

  /// Determines if two `ThrowStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: ThrowStmtSyntax, rhs: ThrowStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct IfStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case labelName
    case labelColon
    case ifKeyword
    case conditions
    case body
    case elseKeyword
    case elseBody
  }

  let data: SyntaxData

  /// Creates a `IfStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var labelName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelName(value)
  }
  }

  /// Returns a copy of the receiver with its `labelName` replaced.
  /// - param newChild: The new `labelName` to replace the node's
  ///                   current `labelName`, if present.
  public func withLabelName(
    _ newChild: TokenSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelName)
    return IfStmtSyntax(newData)
  }
  public var labelColon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelColon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelColon(value)
  }
  }

  /// Returns a copy of the receiver with its `labelColon` replaced.
  /// - param newChild: The new `labelColon` to replace the node's
  ///                   current `labelColon`, if present.
  public func withLabelColon(
    _ newChild: TokenSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelColon)
    return IfStmtSyntax(newData)
  }
  public var ifKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.ifKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIfKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `ifKeyword` replaced.
  /// - param newChild: The new `ifKeyword` to replace the node's
  ///                   current `ifKeyword`, if present.
  public func withIfKeyword(
    _ newChild: TokenSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.ifKeyword)
    let newData = data.replacingChild(raw, at: Cursor.ifKeyword)
    return IfStmtSyntax(newData)
  }
  public var conditions: ConditionElementListSyntax {
  get {
    let child = data.child(at: Cursor.conditions, parent: self)
    return ConditionElementListSyntax(child!)
  }
  set(value) {
    self = withConditions(value)
  }
  }

  /// Adds the provided `ConditionElement` to the node's `conditions`
  /// collection.
  /// - param element: The new `ConditionElement` to add to the node's
  ///                  `conditions` collection.
  /// - returns: A copy of the receiver with the provided `ConditionElement`
  ///            appended to its `conditions` collection.
  public func addConditionElement(_ element: ConditionElementSyntax) -> IfStmtSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.conditions] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.conditionElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.conditions)
    return IfStmtSyntax(newData)
  }

  /// Returns a copy of the receiver with its `conditions` replaced.
  /// - param newChild: The new `conditions` to replace the node's
  ///                   current `conditions`, if present.
  public func withConditions(
    _ newChild: ConditionElementListSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.conditionElementList)
    let newData = data.replacingChild(raw, at: Cursor.conditions)
    return IfStmtSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return IfStmtSyntax(newData)
  }
  public var elseKeyword: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.elseKeyword, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withElseKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `elseKeyword` replaced.
  /// - param newChild: The new `elseKeyword` to replace the node's
  ///                   current `elseKeyword`, if present.
  public func withElseKeyword(
    _ newChild: TokenSyntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.elseKeyword)
    return IfStmtSyntax(newData)
  }
  public var elseBody: Syntax? {
  get {
    let child = data.child(at: Cursor.elseBody, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) 
  }
  set(value) {
    self = withElseBody(value)
  }
  }

  /// Returns a copy of the receiver with its `elseBody` replaced.
  /// - param newChild: The new `elseBody` to replace the node's
  ///                   current `elseBody`, if present.
  public func withElseBody(
    _ newChild: Syntax?) -> IfStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.elseBody)
    return IfStmtSyntax(newData)
  }

  /// Determines if two `IfStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: IfStmtSyntax, rhs: IfStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ElseIfContinuationSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case ifStatement
  }

  let data: SyntaxData

  /// Creates a `ElseIfContinuationSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var ifStatement: IfStmtSyntax {
  get {
    let child = data.child(at: Cursor.ifStatement, parent: self)
    return IfStmtSyntax(child!)
  }
  set(value) {
    self = withIfStatement(value)
  }
  }

  /// Returns a copy of the receiver with its `ifStatement` replaced.
  /// - param newChild: The new `ifStatement` to replace the node's
  ///                   current `ifStatement`, if present.
  public func withIfStatement(
    _ newChild: IfStmtSyntax?) -> ElseIfContinuationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.ifStmt)
    let newData = data.replacingChild(raw, at: Cursor.ifStatement)
    return ElseIfContinuationSyntax(newData)
  }

  /// Determines if two `ElseIfContinuationSyntax` nodes are equal to each other.
  public static func ==(lhs: ElseIfContinuationSyntax, rhs: ElseIfContinuationSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ElseBlockSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case elseKeyword
    case body
  }

  let data: SyntaxData

  /// Creates a `ElseBlockSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var elseKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.elseKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withElseKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `elseKeyword` replaced.
  /// - param newChild: The new `elseKeyword` to replace the node's
  ///                   current `elseKeyword`, if present.
  public func withElseKeyword(
    _ newChild: TokenSyntax?) -> ElseBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.elseKeyword)
    let newData = data.replacingChild(raw, at: Cursor.elseKeyword)
    return ElseBlockSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> ElseBlockSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return ElseBlockSyntax(newData)
  }

  /// Determines if two `ElseBlockSyntax` nodes are equal to each other.
  public static func ==(lhs: ElseBlockSyntax, rhs: ElseBlockSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SwitchCaseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case unknownAttr
    case label
    case statements
  }

  let data: SyntaxData

  /// Creates a `SwitchCaseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var unknownAttr: AttributeSyntax? {
  get {
    let child = data.child(at: Cursor.unknownAttr, parent: self)
    if child == nil { return nil }
    return AttributeSyntax(child!)
  }
  set(value) {
    self = withUnknownAttr(value)
  }
  }

  /// Returns a copy of the receiver with its `unknownAttr` replaced.
  /// - param newChild: The new `unknownAttr` to replace the node's
  ///                   current `unknownAttr`, if present.
  public func withUnknownAttr(
    _ newChild: AttributeSyntax?) -> SwitchCaseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.unknownAttr)
    return SwitchCaseSyntax(newData)
  }
  public var label: Syntax {
  get {
    let child = data.child(at: Cursor.label, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: Syntax?) -> SwitchCaseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.label)
    return SwitchCaseSyntax(newData)
  }
  public var statements: CodeBlockItemListSyntax {
  get {
    let child = data.child(at: Cursor.statements, parent: self)
    return CodeBlockItemListSyntax(child!)
  }
  set(value) {
    self = withStatements(value)
  }
  }

  /// Adds the provided `CodeBlockItem` to the node's `statements`
  /// collection.
  /// - param element: The new `CodeBlockItem` to add to the node's
  ///                  `statements` collection.
  /// - returns: A copy of the receiver with the provided `CodeBlockItem`
  ///            appended to its `statements` collection.
  public func addCodeBlockItem(_ element: CodeBlockItemSyntax) -> SwitchCaseSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.statements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.codeBlockItemList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.statements)
    return SwitchCaseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `statements` replaced.
  /// - param newChild: The new `statements` to replace the node's
  ///                   current `statements`, if present.
  public func withStatements(
    _ newChild: CodeBlockItemListSyntax?) -> SwitchCaseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlockItemList)
    let newData = data.replacingChild(raw, at: Cursor.statements)
    return SwitchCaseSyntax(newData)
  }

  /// Determines if two `SwitchCaseSyntax` nodes are equal to each other.
  public static func ==(lhs: SwitchCaseSyntax, rhs: SwitchCaseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SwitchDefaultLabelSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case defaultKeyword
    case colon
  }

  let data: SyntaxData

  /// Creates a `SwitchDefaultLabelSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var defaultKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.defaultKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withDefaultKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `defaultKeyword` replaced.
  /// - param newChild: The new `defaultKeyword` to replace the node's
  ///                   current `defaultKeyword`, if present.
  public func withDefaultKeyword(
    _ newChild: TokenSyntax?) -> SwitchDefaultLabelSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.defaultKeyword)
    let newData = data.replacingChild(raw, at: Cursor.defaultKeyword)
    return SwitchDefaultLabelSyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> SwitchDefaultLabelSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return SwitchDefaultLabelSyntax(newData)
  }

  /// Determines if two `SwitchDefaultLabelSyntax` nodes are equal to each other.
  public static func ==(lhs: SwitchDefaultLabelSyntax, rhs: SwitchDefaultLabelSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct CaseItemSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case pattern
    case whereClause
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `CaseItemSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var pattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> CaseItemSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return CaseItemSyntax(newData)
  }
  public var whereClause: WhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.whereClause, parent: self)
    if child == nil { return nil }
    return WhereClauseSyntax(child!)
  }
  set(value) {
    self = withWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `whereClause` replaced.
  /// - param newChild: The new `whereClause` to replace the node's
  ///                   current `whereClause`, if present.
  public func withWhereClause(
    _ newChild: WhereClauseSyntax?) -> CaseItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.whereClause)
    return CaseItemSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> CaseItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return CaseItemSyntax(newData)
  }

  /// Determines if two `CaseItemSyntax` nodes are equal to each other.
  public static func ==(lhs: CaseItemSyntax, rhs: CaseItemSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SwitchCaseLabelSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case caseKeyword
    case caseItems
    case colon
  }

  let data: SyntaxData

  /// Creates a `SwitchCaseLabelSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var caseKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.caseKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withCaseKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `caseKeyword` replaced.
  /// - param newChild: The new `caseKeyword` to replace the node's
  ///                   current `caseKeyword`, if present.
  public func withCaseKeyword(
    _ newChild: TokenSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.caseKeyword)
    let newData = data.replacingChild(raw, at: Cursor.caseKeyword)
    return SwitchCaseLabelSyntax(newData)
  }
  public var caseItems: CaseItemListSyntax {
  get {
    let child = data.child(at: Cursor.caseItems, parent: self)
    return CaseItemListSyntax(child!)
  }
  set(value) {
    self = withCaseItems(value)
  }
  }

  /// Adds the provided `CaseItem` to the node's `caseItems`
  /// collection.
  /// - param element: The new `CaseItem` to add to the node's
  ///                  `caseItems` collection.
  /// - returns: A copy of the receiver with the provided `CaseItem`
  ///            appended to its `caseItems` collection.
  public func addCaseItem(_ element: CaseItemSyntax) -> SwitchCaseLabelSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.caseItems] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.caseItemList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.caseItems)
    return SwitchCaseLabelSyntax(newData)
  }

  /// Returns a copy of the receiver with its `caseItems` replaced.
  /// - param newChild: The new `caseItems` to replace the node's
  ///                   current `caseItems`, if present.
  public func withCaseItems(
    _ newChild: CaseItemListSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.caseItemList)
    let newData = data.replacingChild(raw, at: Cursor.caseItems)
    return SwitchCaseLabelSyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return SwitchCaseLabelSyntax(newData)
  }

  /// Determines if two `SwitchCaseLabelSyntax` nodes are equal to each other.
  public static func ==(lhs: SwitchCaseLabelSyntax, rhs: SwitchCaseLabelSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct CatchClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case catchKeyword
    case pattern
    case whereClause
    case body
  }

  let data: SyntaxData

  /// Creates a `CatchClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var catchKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.catchKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withCatchKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `catchKeyword` replaced.
  /// - param newChild: The new `catchKeyword` to replace the node's
  ///                   current `catchKeyword`, if present.
  public func withCatchKeyword(
    _ newChild: TokenSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.catchKeyword)
    let newData = data.replacingChild(raw, at: Cursor.catchKeyword)
    return CatchClauseSyntax(newData)
  }
  public var pattern: PatternSyntax? {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) as? PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return CatchClauseSyntax(newData)
  }
  public var whereClause: WhereClauseSyntax? {
  get {
    let child = data.child(at: Cursor.whereClause, parent: self)
    if child == nil { return nil }
    return WhereClauseSyntax(child!)
  }
  set(value) {
    self = withWhereClause(value)
  }
  }

  /// Returns a copy of the receiver with its `whereClause` replaced.
  /// - param newChild: The new `whereClause` to replace the node's
  ///                   current `whereClause`, if present.
  public func withWhereClause(
    _ newChild: WhereClauseSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.whereClause)
    return CatchClauseSyntax(newData)
  }
  public var body: CodeBlockSyntax {
  get {
    let child = data.child(at: Cursor.body, parent: self)
    return CodeBlockSyntax(child!)
  }
  set(value) {
    self = withBody(value)
  }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: CodeBlockSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.codeBlock)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return CatchClauseSyntax(newData)
  }

  /// Determines if two `CatchClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: CatchClauseSyntax, rhs: CatchClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct PoundAssertStmtSyntax: StmtSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case poundAssert
    case leftParen
    case condition
    case comma
    case message
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `PoundAssertStmtSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var poundAssert: TokenSyntax {
  get {
    let child = data.child(at: Cursor.poundAssert, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPoundAssert(value)
  }
  }

  /// Returns a copy of the receiver with its `poundAssert` replaced.
  /// - param newChild: The new `poundAssert` to replace the node's
  ///                   current `poundAssert`, if present.
  public func withPoundAssert(
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundAssertKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundAssert)
    return PoundAssertStmtSyntax(newData)
  }
  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return PoundAssertStmtSyntax(newData)
  }
  /// The assertion condition.
  public var condition: ExprSyntax {
  get {
    let child = data.child(at: Cursor.condition, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withCondition(value)
  }
  }

  /// Returns a copy of the receiver with its `condition` replaced.
  /// - param newChild: The new `condition` to replace the node's
  ///                   current `condition`, if present.
  public func withCondition(
    _ newChild: ExprSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.condition)
    return PoundAssertStmtSyntax(newData)
  }
  /// The comma after the assertion condition.
  public var comma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.comma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withComma(value)
  }
  }

  /// Returns a copy of the receiver with its `comma` replaced.
  /// - param newChild: The new `comma` to replace the node's
  ///                   current `comma`, if present.
  public func withComma(
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.comma)
    return PoundAssertStmtSyntax(newData)
  }
  /// The assertion message.
  public var message: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.message, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withMessage(value)
  }
  }

  /// Returns a copy of the receiver with its `message` replaced.
  /// - param newChild: The new `message` to replace the node's
  ///                   current `message`, if present.
  public func withMessage(
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.message)
    return PoundAssertStmtSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> PoundAssertStmtSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return PoundAssertStmtSyntax(newData)
  }

  /// Determines if two `PoundAssertStmtSyntax` nodes are equal to each other.
  public static func ==(lhs: PoundAssertStmtSyntax, rhs: PoundAssertStmtSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct GenericWhereClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case whereKeyword
    case requirementList
  }

  let data: SyntaxData

  /// Creates a `GenericWhereClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var whereKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.whereKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withWhereKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `whereKeyword` replaced.
  /// - param newChild: The new `whereKeyword` to replace the node's
  ///                   current `whereKeyword`, if present.
  public func withWhereKeyword(
    _ newChild: TokenSyntax?) -> GenericWhereClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.whereKeyword)
    let newData = data.replacingChild(raw, at: Cursor.whereKeyword)
    return GenericWhereClauseSyntax(newData)
  }
  public var requirementList: GenericRequirementListSyntax {
  get {
    let child = data.child(at: Cursor.requirementList, parent: self)
    return GenericRequirementListSyntax(child!)
  }
  set(value) {
    self = withRequirementList(value)
  }
  }

  /// Adds the provided `GenericRequirement` to the node's `requirementList`
  /// collection.
  /// - param element: The new `GenericRequirement` to add to the node's
  ///                  `requirementList` collection.
  /// - returns: A copy of the receiver with the provided `GenericRequirement`
  ///            appended to its `requirementList` collection.
  public func addGenericRequirement(_ element: Syntax) -> GenericWhereClauseSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.requirementList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.genericRequirementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.requirementList)
    return GenericWhereClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `requirementList` replaced.
  /// - param newChild: The new `requirementList` to replace the node's
  ///                   current `requirementList`, if present.
  public func withRequirementList(
    _ newChild: GenericRequirementListSyntax?) -> GenericWhereClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.genericRequirementList)
    let newData = data.replacingChild(raw, at: Cursor.requirementList)
    return GenericWhereClauseSyntax(newData)
  }

  /// Determines if two `GenericWhereClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: GenericWhereClauseSyntax, rhs: GenericWhereClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SameTypeRequirementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftTypeIdentifier
    case equalityToken
    case rightTypeIdentifier
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `SameTypeRequirementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftTypeIdentifier: TypeSyntax {
  get {
    let child = data.child(at: Cursor.leftTypeIdentifier, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withLeftTypeIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `leftTypeIdentifier` replaced.
  /// - param newChild: The new `leftTypeIdentifier` to replace the node's
  ///                   current `leftTypeIdentifier`, if present.
  public func withLeftTypeIdentifier(
    _ newChild: TypeSyntax?) -> SameTypeRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.leftTypeIdentifier)
    return SameTypeRequirementSyntax(newData)
  }
  public var equalityToken: TokenSyntax {
  get {
    let child = data.child(at: Cursor.equalityToken, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withEqualityToken(value)
  }
  }

  /// Returns a copy of the receiver with its `equalityToken` replaced.
  /// - param newChild: The new `equalityToken` to replace the node's
  ///                   current `equalityToken`, if present.
  public func withEqualityToken(
    _ newChild: TokenSyntax?) -> SameTypeRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.spacedBinaryOperator(""))
    let newData = data.replacingChild(raw, at: Cursor.equalityToken)
    return SameTypeRequirementSyntax(newData)
  }
  public var rightTypeIdentifier: TypeSyntax {
  get {
    let child = data.child(at: Cursor.rightTypeIdentifier, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withRightTypeIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `rightTypeIdentifier` replaced.
  /// - param newChild: The new `rightTypeIdentifier` to replace the node's
  ///                   current `rightTypeIdentifier`, if present.
  public func withRightTypeIdentifier(
    _ newChild: TypeSyntax?) -> SameTypeRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.rightTypeIdentifier)
    return SameTypeRequirementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> SameTypeRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return SameTypeRequirementSyntax(newData)
  }

  /// Determines if two `SameTypeRequirementSyntax` nodes are equal to each other.
  public static func ==(lhs: SameTypeRequirementSyntax, rhs: SameTypeRequirementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct GenericParameterSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case attributes
    case name
    case colon
    case inheritedType
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `GenericParameterSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> GenericParameterSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return GenericParameterSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return GenericParameterSyntax(newData)
  }
  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return GenericParameterSyntax(newData)
  }
  public var colon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return GenericParameterSyntax(newData)
  }
  public var inheritedType: TypeSyntax? {
  get {
    let child = data.child(at: Cursor.inheritedType, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) as? TypeSyntax
  }
  set(value) {
    self = withInheritedType(value)
  }
  }

  /// Returns a copy of the receiver with its `inheritedType` replaced.
  /// - param newChild: The new `inheritedType` to replace the node's
  ///                   current `inheritedType`, if present.
  public func withInheritedType(
    _ newChild: TypeSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritedType)
    return GenericParameterSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> GenericParameterSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return GenericParameterSyntax(newData)
  }

  /// Determines if two `GenericParameterSyntax` nodes are equal to each other.
  public static func ==(lhs: GenericParameterSyntax, rhs: GenericParameterSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct GenericParameterClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftAngleBracket
    case genericParameterList
    case rightAngleBracket
  }

  let data: SyntaxData

  /// Creates a `GenericParameterClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftAngleBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftAngleBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftAngleBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `leftAngleBracket` replaced.
  /// - param newChild: The new `leftAngleBracket` to replace the node's
  ///                   current `leftAngleBracket`, if present.
  public func withLeftAngleBracket(
    _ newChild: TokenSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftAngle)
    let newData = data.replacingChild(raw, at: Cursor.leftAngleBracket)
    return GenericParameterClauseSyntax(newData)
  }
  public var genericParameterList: GenericParameterListSyntax {
  get {
    let child = data.child(at: Cursor.genericParameterList, parent: self)
    return GenericParameterListSyntax(child!)
  }
  set(value) {
    self = withGenericParameterList(value)
  }
  }

  /// Adds the provided `GenericParameter` to the node's `genericParameterList`
  /// collection.
  /// - param element: The new `GenericParameter` to add to the node's
  ///                  `genericParameterList` collection.
  /// - returns: A copy of the receiver with the provided `GenericParameter`
  ///            appended to its `genericParameterList` collection.
  public func addGenericParameter(_ element: GenericParameterSyntax) -> GenericParameterClauseSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.genericParameterList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.genericParameterList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.genericParameterList)
    return GenericParameterClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `genericParameterList` replaced.
  /// - param newChild: The new `genericParameterList` to replace the node's
  ///                   current `genericParameterList`, if present.
  public func withGenericParameterList(
    _ newChild: GenericParameterListSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.genericParameterList)
    let newData = data.replacingChild(raw, at: Cursor.genericParameterList)
    return GenericParameterClauseSyntax(newData)
  }
  public var rightAngleBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightAngleBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightAngleBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `rightAngleBracket` replaced.
  /// - param newChild: The new `rightAngleBracket` to replace the node's
  ///                   current `rightAngleBracket`, if present.
  public func withRightAngleBracket(
    _ newChild: TokenSyntax?) -> GenericParameterClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightAngle)
    let newData = data.replacingChild(raw, at: Cursor.rightAngleBracket)
    return GenericParameterClauseSyntax(newData)
  }

  /// Determines if two `GenericParameterClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: GenericParameterClauseSyntax, rhs: GenericParameterClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ConformanceRequirementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftTypeIdentifier
    case colon
    case rightTypeIdentifier
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `ConformanceRequirementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftTypeIdentifier: TypeSyntax {
  get {
    let child = data.child(at: Cursor.leftTypeIdentifier, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withLeftTypeIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `leftTypeIdentifier` replaced.
  /// - param newChild: The new `leftTypeIdentifier` to replace the node's
  ///                   current `leftTypeIdentifier`, if present.
  public func withLeftTypeIdentifier(
    _ newChild: TypeSyntax?) -> ConformanceRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.leftTypeIdentifier)
    return ConformanceRequirementSyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> ConformanceRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return ConformanceRequirementSyntax(newData)
  }
  public var rightTypeIdentifier: TypeSyntax {
  get {
    let child = data.child(at: Cursor.rightTypeIdentifier, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withRightTypeIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `rightTypeIdentifier` replaced.
  /// - param newChild: The new `rightTypeIdentifier` to replace the node's
  ///                   current `rightTypeIdentifier`, if present.
  public func withRightTypeIdentifier(
    _ newChild: TypeSyntax?) -> ConformanceRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.rightTypeIdentifier)
    return ConformanceRequirementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> ConformanceRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return ConformanceRequirementSyntax(newData)
  }

  /// Determines if two `ConformanceRequirementSyntax` nodes are equal to each other.
  public static func ==(lhs: ConformanceRequirementSyntax, rhs: ConformanceRequirementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct SimpleTypeIdentifierSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case name
    case genericArgumentClause
  }

  let data: SyntaxData

  /// Creates a `SimpleTypeIdentifierSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return SimpleTypeIdentifierSyntax(newData)
  }
  public var genericArgumentClause: GenericArgumentClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericArgumentClause, parent: self)
    if child == nil { return nil }
    return GenericArgumentClauseSyntax(child!)
  }
  set(value) {
    self = withGenericArgumentClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericArgumentClause` replaced.
  /// - param newChild: The new `genericArgumentClause` to replace the node's
  ///                   current `genericArgumentClause`, if present.
  public func withGenericArgumentClause(
    _ newChild: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return SimpleTypeIdentifierSyntax(newData)
  }

  /// Determines if two `SimpleTypeIdentifierSyntax` nodes are equal to each other.
  public static func ==(lhs: SimpleTypeIdentifierSyntax, rhs: SimpleTypeIdentifierSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct MemberTypeIdentifierSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case baseType
    case period
    case name
    case genericArgumentClause
  }

  let data: SyntaxData

  /// Creates a `MemberTypeIdentifierSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var baseType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.baseType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withBaseType(value)
  }
  }

  /// Returns a copy of the receiver with its `baseType` replaced.
  /// - param newChild: The new `baseType` to replace the node's
  ///                   current `baseType`, if present.
  public func withBaseType(
    _ newChild: TypeSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.baseType)
    return MemberTypeIdentifierSyntax(newData)
  }
  public var period: TokenSyntax {
  get {
    let child = data.child(at: Cursor.period, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPeriod(value)
  }
  }

  /// Returns a copy of the receiver with its `period` replaced.
  /// - param newChild: The new `period` to replace the node's
  ///                   current `period`, if present.
  public func withPeriod(
    _ newChild: TokenSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return MemberTypeIdentifierSyntax(newData)
  }
  public var name: TokenSyntax {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return MemberTypeIdentifierSyntax(newData)
  }
  public var genericArgumentClause: GenericArgumentClauseSyntax? {
  get {
    let child = data.child(at: Cursor.genericArgumentClause, parent: self)
    if child == nil { return nil }
    return GenericArgumentClauseSyntax(child!)
  }
  set(value) {
    self = withGenericArgumentClause(value)
  }
  }

  /// Returns a copy of the receiver with its `genericArgumentClause` replaced.
  /// - param newChild: The new `genericArgumentClause` to replace the node's
  ///                   current `genericArgumentClause`, if present.
  public func withGenericArgumentClause(
    _ newChild: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.genericArgumentClause)
    return MemberTypeIdentifierSyntax(newData)
  }

  /// Determines if two `MemberTypeIdentifierSyntax` nodes are equal to each other.
  public static func ==(lhs: MemberTypeIdentifierSyntax, rhs: MemberTypeIdentifierSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ClassRestrictionTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case classKeyword
  }

  let data: SyntaxData

  /// Creates a `ClassRestrictionTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var classKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.classKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withClassKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `classKeyword` replaced.
  /// - param newChild: The new `classKeyword` to replace the node's
  ///                   current `classKeyword`, if present.
  public func withClassKeyword(
    _ newChild: TokenSyntax?) -> ClassRestrictionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.classKeyword)
    let newData = data.replacingChild(raw, at: Cursor.classKeyword)
    return ClassRestrictionTypeSyntax(newData)
  }

  /// Determines if two `ClassRestrictionTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: ClassRestrictionTypeSyntax, rhs: ClassRestrictionTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ArrayTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftSquareBracket
    case elementType
    case rightSquareBracket
  }

  let data: SyntaxData

  /// Creates a `ArrayTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftSquareBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftSquareBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftSquareBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `leftSquareBracket` replaced.
  /// - param newChild: The new `leftSquareBracket` to replace the node's
  ///                   current `leftSquareBracket`, if present.
  public func withLeftSquareBracket(
    _ newChild: TokenSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftSquareBracket)
    return ArrayTypeSyntax(newData)
  }
  public var elementType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.elementType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withElementType(value)
  }
  }

  /// Returns a copy of the receiver with its `elementType` replaced.
  /// - param newChild: The new `elementType` to replace the node's
  ///                   current `elementType`, if present.
  public func withElementType(
    _ newChild: TypeSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.elementType)
    return ArrayTypeSyntax(newData)
  }
  public var rightSquareBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightSquareBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightSquareBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `rightSquareBracket` replaced.
  /// - param newChild: The new `rightSquareBracket` to replace the node's
  ///                   current `rightSquareBracket`, if present.
  public func withRightSquareBracket(
    _ newChild: TokenSyntax?) -> ArrayTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightSquareBracket)
    return ArrayTypeSyntax(newData)
  }

  /// Determines if two `ArrayTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: ArrayTypeSyntax, rhs: ArrayTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct DictionaryTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftSquareBracket
    case keyType
    case colon
    case valueType
    case rightSquareBracket
  }

  let data: SyntaxData

  /// Creates a `DictionaryTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftSquareBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftSquareBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftSquareBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `leftSquareBracket` replaced.
  /// - param newChild: The new `leftSquareBracket` to replace the node's
  ///                   current `leftSquareBracket`, if present.
  public func withLeftSquareBracket(
    _ newChild: TokenSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.leftSquareBracket)
    return DictionaryTypeSyntax(newData)
  }
  public var keyType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.keyType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withKeyType(value)
  }
  }

  /// Returns a copy of the receiver with its `keyType` replaced.
  /// - param newChild: The new `keyType` to replace the node's
  ///                   current `keyType`, if present.
  public func withKeyType(
    _ newChild: TypeSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.keyType)
    return DictionaryTypeSyntax(newData)
  }
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return DictionaryTypeSyntax(newData)
  }
  public var valueType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.valueType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withValueType(value)
  }
  }

  /// Returns a copy of the receiver with its `valueType` replaced.
  /// - param newChild: The new `valueType` to replace the node's
  ///                   current `valueType`, if present.
  public func withValueType(
    _ newChild: TypeSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.valueType)
    return DictionaryTypeSyntax(newData)
  }
  public var rightSquareBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightSquareBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightSquareBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `rightSquareBracket` replaced.
  /// - param newChild: The new `rightSquareBracket` to replace the node's
  ///                   current `rightSquareBracket`, if present.
  public func withRightSquareBracket(
    _ newChild: TokenSyntax?) -> DictionaryTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightSquareBracket)
    let newData = data.replacingChild(raw, at: Cursor.rightSquareBracket)
    return DictionaryTypeSyntax(newData)
  }

  /// Determines if two `DictionaryTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: DictionaryTypeSyntax, rhs: DictionaryTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct MetatypeTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case baseType
    case period
    case typeOrProtocol
  }

  let data: SyntaxData

  /// Creates a `MetatypeTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var baseType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.baseType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withBaseType(value)
  }
  }

  /// Returns a copy of the receiver with its `baseType` replaced.
  /// - param newChild: The new `baseType` to replace the node's
  ///                   current `baseType`, if present.
  public func withBaseType(
    _ newChild: TypeSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.baseType)
    return MetatypeTypeSyntax(newData)
  }
  public var period: TokenSyntax {
  get {
    let child = data.child(at: Cursor.period, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPeriod(value)
  }
  }

  /// Returns a copy of the receiver with its `period` replaced.
  /// - param newChild: The new `period` to replace the node's
  ///                   current `period`, if present.
  public func withPeriod(
    _ newChild: TokenSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return MetatypeTypeSyntax(newData)
  }
  public var typeOrProtocol: TokenSyntax {
  get {
    let child = data.child(at: Cursor.typeOrProtocol, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTypeOrProtocol(value)
  }
  }

  /// Returns a copy of the receiver with its `typeOrProtocol` replaced.
  /// - param newChild: The new `typeOrProtocol` to replace the node's
  ///                   current `typeOrProtocol`, if present.
  public func withTypeOrProtocol(
    _ newChild: TokenSyntax?) -> MetatypeTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.typeOrProtocol)
    return MetatypeTypeSyntax(newData)
  }

  /// Determines if two `MetatypeTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: MetatypeTypeSyntax, rhs: MetatypeTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct OptionalTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case wrappedType
    case questionMark
  }

  let data: SyntaxData

  /// Creates a `OptionalTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var wrappedType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.wrappedType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withWrappedType(value)
  }
  }

  /// Returns a copy of the receiver with its `wrappedType` replaced.
  /// - param newChild: The new `wrappedType` to replace the node's
  ///                   current `wrappedType`, if present.
  public func withWrappedType(
    _ newChild: TypeSyntax?) -> OptionalTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.wrappedType)
    return OptionalTypeSyntax(newData)
  }
  public var questionMark: TokenSyntax {
  get {
    let child = data.child(at: Cursor.questionMark, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withQuestionMark(value)
  }
  }

  /// Returns a copy of the receiver with its `questionMark` replaced.
  /// - param newChild: The new `questionMark` to replace the node's
  ///                   current `questionMark`, if present.
  public func withQuestionMark(
    _ newChild: TokenSyntax?) -> OptionalTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return OptionalTypeSyntax(newData)
  }

  /// Determines if two `OptionalTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: OptionalTypeSyntax, rhs: OptionalTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ImplicitlyUnwrappedOptionalTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case wrappedType
    case exclamationMark
  }

  let data: SyntaxData

  /// Creates a `ImplicitlyUnwrappedOptionalTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var wrappedType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.wrappedType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withWrappedType(value)
  }
  }

  /// Returns a copy of the receiver with its `wrappedType` replaced.
  /// - param newChild: The new `wrappedType` to replace the node's
  ///                   current `wrappedType`, if present.
  public func withWrappedType(
    _ newChild: TypeSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.wrappedType)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }
  public var exclamationMark: TokenSyntax {
  get {
    let child = data.child(at: Cursor.exclamationMark, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withExclamationMark(value)
  }
  }

  /// Returns a copy of the receiver with its `exclamationMark` replaced.
  /// - param newChild: The new `exclamationMark` to replace the node's
  ///                   current `exclamationMark`, if present.
  public func withExclamationMark(
    _ newChild: TokenSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.exclamationMark)
    let newData = data.replacingChild(raw, at: Cursor.exclamationMark)
    return ImplicitlyUnwrappedOptionalTypeSyntax(newData)
  }

  /// Determines if two `ImplicitlyUnwrappedOptionalTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: ImplicitlyUnwrappedOptionalTypeSyntax, rhs: ImplicitlyUnwrappedOptionalTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct CompositionTypeElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case type
    case ampersand
  }

  let data: SyntaxData

  /// Creates a `CompositionTypeElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var type: TypeSyntax {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: TypeSyntax?) -> CompositionTypeElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return CompositionTypeElementSyntax(newData)
  }
  public var ampersand: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.ampersand, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAmpersand(value)
  }
  }

  /// Returns a copy of the receiver with its `ampersand` replaced.
  /// - param newChild: The new `ampersand` to replace the node's
  ///                   current `ampersand`, if present.
  public func withAmpersand(
    _ newChild: TokenSyntax?) -> CompositionTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.ampersand)
    return CompositionTypeElementSyntax(newData)
  }

  /// Determines if two `CompositionTypeElementSyntax` nodes are equal to each other.
  public static func ==(lhs: CompositionTypeElementSyntax, rhs: CompositionTypeElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct CompositionTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case elements
  }

  let data: SyntaxData

  /// Creates a `CompositionTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var elements: CompositionTypeElementListSyntax {
  get {
    let child = data.child(at: Cursor.elements, parent: self)
    return CompositionTypeElementListSyntax(child!)
  }
  set(value) {
    self = withElements(value)
  }
  }

  /// Adds the provided `CompositionTypeElement` to the node's `elements`
  /// collection.
  /// - param element: The new `CompositionTypeElement` to add to the node's
  ///                  `elements` collection.
  /// - returns: A copy of the receiver with the provided `CompositionTypeElement`
  ///            appended to its `elements` collection.
  public func addCompositionTypeElement(_ element: CompositionTypeElementSyntax) -> CompositionTypeSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.compositionTypeElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return CompositionTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: CompositionTypeElementListSyntax?) -> CompositionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.compositionTypeElementList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return CompositionTypeSyntax(newData)
  }

  /// Determines if two `CompositionTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: CompositionTypeSyntax, rhs: CompositionTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TupleTypeElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case inOut
    case name
    case secondName
    case colon
    case type
    case ellipsis
    case initializer
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `TupleTypeElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var inOut: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.inOut, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withInOut(value)
  }
  }

  /// Returns a copy of the receiver with its `inOut` replaced.
  /// - param newChild: The new `inOut` to replace the node's
  ///                   current `inOut`, if present.
  public func withInOut(
    _ newChild: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inOut)
    return TupleTypeElementSyntax(newData)
  }
  public var name: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.name, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withName(value)
  }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.name)
    return TupleTypeElementSyntax(newData)
  }
  public var secondName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.secondName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withSecondName(value)
  }
  }

  /// Returns a copy of the receiver with its `secondName` replaced.
  /// - param newChild: The new `secondName` to replace the node's
  ///                   current `secondName`, if present.
  public func withSecondName(
    _ newChild: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.secondName)
    return TupleTypeElementSyntax(newData)
  }
  public var colon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return TupleTypeElementSyntax(newData)
  }
  public var type: TypeSyntax {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: TypeSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return TupleTypeElementSyntax(newData)
  }
  public var ellipsis: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.ellipsis, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withEllipsis(value)
  }
  }

  /// Returns a copy of the receiver with its `ellipsis` replaced.
  /// - param newChild: The new `ellipsis` to replace the node's
  ///                   current `ellipsis`, if present.
  public func withEllipsis(
    _ newChild: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.ellipsis)
    return TupleTypeElementSyntax(newData)
  }
  public var initializer: InitializerClauseSyntax? {
  get {
    let child = data.child(at: Cursor.initializer, parent: self)
    if child == nil { return nil }
    return InitializerClauseSyntax(child!)
  }
  set(value) {
    self = withInitializer(value)
  }
  }

  /// Returns a copy of the receiver with its `initializer` replaced.
  /// - param newChild: The new `initializer` to replace the node's
  ///                   current `initializer`, if present.
  public func withInitializer(
    _ newChild: InitializerClauseSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return TupleTypeElementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return TupleTypeElementSyntax(newData)
  }

  /// Determines if two `TupleTypeElementSyntax` nodes are equal to each other.
  public static func ==(lhs: TupleTypeElementSyntax, rhs: TupleTypeElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TupleTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftParen
    case elements
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `TupleTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return TupleTypeSyntax(newData)
  }
  public var elements: TupleTypeElementListSyntax {
  get {
    let child = data.child(at: Cursor.elements, parent: self)
    return TupleTypeElementListSyntax(child!)
  }
  set(value) {
    self = withElements(value)
  }
  }

  /// Adds the provided `TupleTypeElement` to the node's `elements`
  /// collection.
  /// - param element: The new `TupleTypeElement` to add to the node's
  ///                  `elements` collection.
  /// - returns: A copy of the receiver with the provided `TupleTypeElement`
  ///            appended to its `elements` collection.
  public func addTupleTypeElement(_ element: TupleTypeElementSyntax) -> TupleTypeSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleTypeElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return TupleTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: TupleTypeElementListSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tupleTypeElementList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return TupleTypeSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> TupleTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return TupleTypeSyntax(newData)
  }

  /// Determines if two `TupleTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: TupleTypeSyntax, rhs: TupleTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct FunctionTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftParen
    case arguments
    case rightParen
    case throwsOrRethrowsKeyword
    case arrow
    case returnType
  }

  let data: SyntaxData

  /// Creates a `FunctionTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return FunctionTypeSyntax(newData)
  }
  public var arguments: TupleTypeElementListSyntax {
  get {
    let child = data.child(at: Cursor.arguments, parent: self)
    return TupleTypeElementListSyntax(child!)
  }
  set(value) {
    self = withArguments(value)
  }
  }

  /// Adds the provided `TupleTypeElement` to the node's `arguments`
  /// collection.
  /// - param element: The new `TupleTypeElement` to add to the node's
  ///                  `arguments` collection.
  /// - returns: A copy of the receiver with the provided `TupleTypeElement`
  ///            appended to its `arguments` collection.
  public func addTupleTypeElement(_ element: TupleTypeElementSyntax) -> FunctionTypeSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.arguments] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleTypeElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.arguments)
    return FunctionTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: TupleTypeElementListSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tupleTypeElementList)
    let newData = data.replacingChild(raw, at: Cursor.arguments)
    return FunctionTypeSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return FunctionTypeSyntax(newData)
  }
  public var throwsOrRethrowsKeyword: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.throwsOrRethrowsKeyword, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withThrowsOrRethrowsKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `throwsOrRethrowsKeyword` replaced.
  /// - param newChild: The new `throwsOrRethrowsKeyword` to replace the node's
  ///                   current `throwsOrRethrowsKeyword`, if present.
  public func withThrowsOrRethrowsKeyword(
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.throwsOrRethrowsKeyword)
    return FunctionTypeSyntax(newData)
  }
  public var arrow: TokenSyntax {
  get {
    let child = data.child(at: Cursor.arrow, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withArrow(value)
  }
  }

  /// Returns a copy of the receiver with its `arrow` replaced.
  /// - param newChild: The new `arrow` to replace the node's
  ///                   current `arrow`, if present.
  public func withArrow(
    _ newChild: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.arrow)
    let newData = data.replacingChild(raw, at: Cursor.arrow)
    return FunctionTypeSyntax(newData)
  }
  public var returnType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.returnType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withReturnType(value)
  }
  }

  /// Returns a copy of the receiver with its `returnType` replaced.
  /// - param newChild: The new `returnType` to replace the node's
  ///                   current `returnType`, if present.
  public func withReturnType(
    _ newChild: TypeSyntax?) -> FunctionTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.returnType)
    return FunctionTypeSyntax(newData)
  }

  /// Determines if two `FunctionTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: FunctionTypeSyntax, rhs: FunctionTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AttributedTypeSyntax: TypeSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case specifier
    case attributes
    case baseType
  }

  let data: SyntaxData

  /// Creates a `AttributedTypeSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var specifier: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.specifier, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withSpecifier(value)
  }
  }

  /// Returns a copy of the receiver with its `specifier` replaced.
  /// - param newChild: The new `specifier` to replace the node's
  ///                   current `specifier`, if present.
  public func withSpecifier(
    _ newChild: TokenSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.specifier)
    return AttributedTypeSyntax(newData)
  }
  public var attributes: AttributeListSyntax? {
  get {
    let child = data.child(at: Cursor.attributes, parent: self)
    if child == nil { return nil }
    return AttributeListSyntax(child!)
  }
  set(value) {
    self = withAttributes(value)
  }
  }

  /// Adds the provided `Attribute` to the node's `attributes`
  /// collection.
  /// - param element: The new `Attribute` to add to the node's
  ///                  `attributes` collection.
  /// - returns: A copy of the receiver with the provided `Attribute`
  ///            appended to its `attributes` collection.
  public func addAttribute(_ element: AttributeSyntax) -> AttributedTypeSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return AttributedTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return AttributedTypeSyntax(newData)
  }
  public var baseType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.baseType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withBaseType(value)
  }
  }

  /// Returns a copy of the receiver with its `baseType` replaced.
  /// - param newChild: The new `baseType` to replace the node's
  ///                   current `baseType`, if present.
  public func withBaseType(
    _ newChild: TypeSyntax?) -> AttributedTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.baseType)
    return AttributedTypeSyntax(newData)
  }

  /// Determines if two `AttributedTypeSyntax` nodes are equal to each other.
  public static func ==(lhs: AttributedTypeSyntax, rhs: AttributedTypeSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct GenericArgumentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case argumentType
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `GenericArgumentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var argumentType: TypeSyntax {
  get {
    let child = data.child(at: Cursor.argumentType, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withArgumentType(value)
  }
  }

  /// Returns a copy of the receiver with its `argumentType` replaced.
  /// - param newChild: The new `argumentType` to replace the node's
  ///                   current `argumentType`, if present.
  public func withArgumentType(
    _ newChild: TypeSyntax?) -> GenericArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.argumentType)
    return GenericArgumentSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> GenericArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return GenericArgumentSyntax(newData)
  }

  /// Determines if two `GenericArgumentSyntax` nodes are equal to each other.
  public static func ==(lhs: GenericArgumentSyntax, rhs: GenericArgumentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct GenericArgumentClauseSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftAngleBracket
    case arguments
    case rightAngleBracket
  }

  let data: SyntaxData

  /// Creates a `GenericArgumentClauseSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftAngleBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftAngleBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftAngleBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `leftAngleBracket` replaced.
  /// - param newChild: The new `leftAngleBracket` to replace the node's
  ///                   current `leftAngleBracket`, if present.
  public func withLeftAngleBracket(
    _ newChild: TokenSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftAngle)
    let newData = data.replacingChild(raw, at: Cursor.leftAngleBracket)
    return GenericArgumentClauseSyntax(newData)
  }
  public var arguments: GenericArgumentListSyntax {
  get {
    let child = data.child(at: Cursor.arguments, parent: self)
    return GenericArgumentListSyntax(child!)
  }
  set(value) {
    self = withArguments(value)
  }
  }

  /// Adds the provided `GenericArgument` to the node's `arguments`
  /// collection.
  /// - param element: The new `GenericArgument` to add to the node's
  ///                  `arguments` collection.
  /// - returns: A copy of the receiver with the provided `GenericArgument`
  ///            appended to its `arguments` collection.
  public func addGenericArgument(_ element: GenericArgumentSyntax) -> GenericArgumentClauseSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.arguments] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.genericArgumentList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.arguments)
    return GenericArgumentClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: GenericArgumentListSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.genericArgumentList)
    let newData = data.replacingChild(raw, at: Cursor.arguments)
    return GenericArgumentClauseSyntax(newData)
  }
  public var rightAngleBracket: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightAngleBracket, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightAngleBracket(value)
  }
  }

  /// Returns a copy of the receiver with its `rightAngleBracket` replaced.
  /// - param newChild: The new `rightAngleBracket` to replace the node's
  ///                   current `rightAngleBracket`, if present.
  public func withRightAngleBracket(
    _ newChild: TokenSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightAngle)
    let newData = data.replacingChild(raw, at: Cursor.rightAngleBracket)
    return GenericArgumentClauseSyntax(newData)
  }

  /// Determines if two `GenericArgumentClauseSyntax` nodes are equal to each other.
  public static func ==(lhs: GenericArgumentClauseSyntax, rhs: GenericArgumentClauseSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TypeAnnotationSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case colon
    case type
  }

  let data: SyntaxData

  /// Creates a `TypeAnnotationSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> TypeAnnotationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return TypeAnnotationSyntax(newData)
  }
  public var type: TypeSyntax {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: TypeSyntax?) -> TypeAnnotationSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return TypeAnnotationSyntax(newData)
  }

  /// Determines if two `TypeAnnotationSyntax` nodes are equal to each other.
  public static func ==(lhs: TypeAnnotationSyntax, rhs: TypeAnnotationSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct EnumCasePatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case type
    case period
    case caseName
    case associatedTuple
  }

  let data: SyntaxData

  /// Creates a `EnumCasePatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var type: TypeSyntax? {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    if child == nil { return nil }
    return makeSyntax(child!) as? TypeSyntax
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: TypeSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.type)
    return EnumCasePatternSyntax(newData)
  }
  public var period: TokenSyntax {
  get {
    let child = data.child(at: Cursor.period, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPeriod(value)
  }
  }

  /// Returns a copy of the receiver with its `period` replaced.
  /// - param newChild: The new `period` to replace the node's
  ///                   current `period`, if present.
  public func withPeriod(
    _ newChild: TokenSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.period)
    let newData = data.replacingChild(raw, at: Cursor.period)
    return EnumCasePatternSyntax(newData)
  }
  public var caseName: TokenSyntax {
  get {
    let child = data.child(at: Cursor.caseName, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withCaseName(value)
  }
  }

  /// Returns a copy of the receiver with its `caseName` replaced.
  /// - param newChild: The new `caseName` to replace the node's
  ///                   current `caseName`, if present.
  public func withCaseName(
    _ newChild: TokenSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.caseName)
    return EnumCasePatternSyntax(newData)
  }
  public var associatedTuple: TuplePatternSyntax? {
  get {
    let child = data.child(at: Cursor.associatedTuple, parent: self)
    if child == nil { return nil }
    return TuplePatternSyntax(child!)
  }
  set(value) {
    self = withAssociatedTuple(value)
  }
  }

  /// Returns a copy of the receiver with its `associatedTuple` replaced.
  /// - param newChild: The new `associatedTuple` to replace the node's
  ///                   current `associatedTuple`, if present.
  public func withAssociatedTuple(
    _ newChild: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.associatedTuple)
    return EnumCasePatternSyntax(newData)
  }

  /// Determines if two `EnumCasePatternSyntax` nodes are equal to each other.
  public static func ==(lhs: EnumCasePatternSyntax, rhs: EnumCasePatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct IsTypePatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case isKeyword
    case type
  }

  let data: SyntaxData

  /// Creates a `IsTypePatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var isKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.isKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIsKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `isKeyword` replaced.
  /// - param newChild: The new `isKeyword` to replace the node's
  ///                   current `isKeyword`, if present.
  public func withIsKeyword(
    _ newChild: TokenSyntax?) -> IsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.isKeyword)
    let newData = data.replacingChild(raw, at: Cursor.isKeyword)
    return IsTypePatternSyntax(newData)
  }
  public var type: TypeSyntax {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: TypeSyntax?) -> IsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return IsTypePatternSyntax(newData)
  }

  /// Determines if two `IsTypePatternSyntax` nodes are equal to each other.
  public static func ==(lhs: IsTypePatternSyntax, rhs: IsTypePatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct OptionalPatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case subPattern
    case questionMark
  }

  let data: SyntaxData

  /// Creates a `OptionalPatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var subPattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.subPattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withSubPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `subPattern` replaced.
  /// - param newChild: The new `subPattern` to replace the node's
  ///                   current `subPattern`, if present.
  public func withSubPattern(
    _ newChild: PatternSyntax?) -> OptionalPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.subPattern)
    return OptionalPatternSyntax(newData)
  }
  public var questionMark: TokenSyntax {
  get {
    let child = data.child(at: Cursor.questionMark, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withQuestionMark(value)
  }
  }

  /// Returns a copy of the receiver with its `questionMark` replaced.
  /// - param newChild: The new `questionMark` to replace the node's
  ///                   current `questionMark`, if present.
  public func withQuestionMark(
    _ newChild: TokenSyntax?) -> OptionalPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.postfixQuestionMark)
    let newData = data.replacingChild(raw, at: Cursor.questionMark)
    return OptionalPatternSyntax(newData)
  }

  /// Determines if two `OptionalPatternSyntax` nodes are equal to each other.
  public static func ==(lhs: OptionalPatternSyntax, rhs: OptionalPatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct IdentifierPatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case identifier
  }

  let data: SyntaxData

  /// Creates a `IdentifierPatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var identifier: TokenSyntax {
  get {
    let child = data.child(at: Cursor.identifier, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withIdentifier(value)
  }
  }

  /// Returns a copy of the receiver with its `identifier` replaced.
  /// - param newChild: The new `identifier` to replace the node's
  ///                   current `identifier`, if present.
  public func withIdentifier(
    _ newChild: TokenSyntax?) -> IdentifierPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.identifier)
    return IdentifierPatternSyntax(newData)
  }

  /// Determines if two `IdentifierPatternSyntax` nodes are equal to each other.
  public static func ==(lhs: IdentifierPatternSyntax, rhs: IdentifierPatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct AsTypePatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case pattern
    case asKeyword
    case type
  }

  let data: SyntaxData

  /// Creates a `AsTypePatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var pattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return AsTypePatternSyntax(newData)
  }
  public var asKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.asKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withAsKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `asKeyword` replaced.
  /// - param newChild: The new `asKeyword` to replace the node's
  ///                   current `asKeyword`, if present.
  public func withAsKeyword(
    _ newChild: TokenSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.asKeyword)
    let newData = data.replacingChild(raw, at: Cursor.asKeyword)
    return AsTypePatternSyntax(newData)
  }
  public var type: TypeSyntax {
  get {
    let child = data.child(at: Cursor.type, parent: self)
    return makeSyntax(child!) as! TypeSyntax
  }
  set(value) {
    self = withType(value)
  }
  }

  /// Returns a copy of the receiver with its `type` replaced.
  /// - param newChild: The new `type` to replace the node's
  ///                   current `type`, if present.
  public func withType(
    _ newChild: TypeSyntax?) -> AsTypePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.type)
    return AsTypePatternSyntax(newData)
  }

  /// Determines if two `AsTypePatternSyntax` nodes are equal to each other.
  public static func ==(lhs: AsTypePatternSyntax, rhs: AsTypePatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TuplePatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case leftParen
    case elements
    case rightParen
  }

  let data: SyntaxData

  /// Creates a `TuplePatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var leftParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.leftParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLeftParen(value)
  }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return TuplePatternSyntax(newData)
  }
  public var elements: TuplePatternElementListSyntax {
  get {
    let child = data.child(at: Cursor.elements, parent: self)
    return TuplePatternElementListSyntax(child!)
  }
  set(value) {
    self = withElements(value)
  }
  }

  /// Adds the provided `TuplePatternElement` to the node's `elements`
  /// collection.
  /// - param element: The new `TuplePatternElement` to add to the node's
  ///                  `elements` collection.
  /// - returns: A copy of the receiver with the provided `TuplePatternElement`
  ///            appended to its `elements` collection.
  public func addTuplePatternElement(_ element: TuplePatternElementSyntax) -> TuplePatternSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.elements] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tuplePatternElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.elements)
    return TuplePatternSyntax(newData)
  }

  /// Returns a copy of the receiver with its `elements` replaced.
  /// - param newChild: The new `elements` to replace the node's
  ///                   current `elements`, if present.
  public func withElements(
    _ newChild: TuplePatternElementListSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tuplePatternElementList)
    let newData = data.replacingChild(raw, at: Cursor.elements)
    return TuplePatternSyntax(newData)
  }
  public var rightParen: TokenSyntax {
  get {
    let child = data.child(at: Cursor.rightParen, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withRightParen(value)
  }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> TuplePatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return TuplePatternSyntax(newData)
  }

  /// Determines if two `TuplePatternSyntax` nodes are equal to each other.
  public static func ==(lhs: TuplePatternSyntax, rhs: TuplePatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct WildcardPatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case wildcard
    case typeAnnotation
  }

  let data: SyntaxData

  /// Creates a `WildcardPatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var wildcard: TokenSyntax {
  get {
    let child = data.child(at: Cursor.wildcard, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withWildcard(value)
  }
  }

  /// Returns a copy of the receiver with its `wildcard` replaced.
  /// - param newChild: The new `wildcard` to replace the node's
  ///                   current `wildcard`, if present.
  public func withWildcard(
    _ newChild: TokenSyntax?) -> WildcardPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.wildcardKeyword)
    let newData = data.replacingChild(raw, at: Cursor.wildcard)
    return WildcardPatternSyntax(newData)
  }
  public var typeAnnotation: TypeAnnotationSyntax? {
  get {
    let child = data.child(at: Cursor.typeAnnotation, parent: self)
    if child == nil { return nil }
    return TypeAnnotationSyntax(child!)
  }
  set(value) {
    self = withTypeAnnotation(value)
  }
  }

  /// Returns a copy of the receiver with its `typeAnnotation` replaced.
  /// - param newChild: The new `typeAnnotation` to replace the node's
  ///                   current `typeAnnotation`, if present.
  public func withTypeAnnotation(
    _ newChild: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.typeAnnotation)
    return WildcardPatternSyntax(newData)
  }

  /// Determines if two `WildcardPatternSyntax` nodes are equal to each other.
  public static func ==(lhs: WildcardPatternSyntax, rhs: WildcardPatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct TuplePatternElementSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case labelName
    case labelColon
    case pattern
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `TuplePatternElementSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var labelName: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelName, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelName(value)
  }
  }

  /// Returns a copy of the receiver with its `labelName` replaced.
  /// - param newChild: The new `labelName` to replace the node's
  ///                   current `labelName`, if present.
  public func withLabelName(
    _ newChild: TokenSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelName)
    return TuplePatternElementSyntax(newData)
  }
  public var labelColon: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.labelColon, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabelColon(value)
  }
  }

  /// Returns a copy of the receiver with its `labelColon` replaced.
  /// - param newChild: The new `labelColon` to replace the node's
  ///                   current `labelColon`, if present.
  public func withLabelColon(
    _ newChild: TokenSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.labelColon)
    return TuplePatternElementSyntax(newData)
  }
  public var pattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.pattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withPattern(value)
  }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return TuplePatternElementSyntax(newData)
  }
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> TuplePatternElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return TuplePatternElementSyntax(newData)
  }

  /// Determines if two `TuplePatternElementSyntax` nodes are equal to each other.
  public static func ==(lhs: TuplePatternElementSyntax, rhs: TuplePatternElementSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ExpressionPatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case expression
  }

  let data: SyntaxData

  /// Creates a `ExpressionPatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var expression: ExprSyntax {
  get {
    let child = data.child(at: Cursor.expression, parent: self)
    return makeSyntax(child!) as! ExprSyntax
  }
  set(value) {
    self = withExpression(value)
  }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> ExpressionPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return ExpressionPatternSyntax(newData)
  }

  /// Determines if two `ExpressionPatternSyntax` nodes are equal to each other.
  public static func ==(lhs: ExpressionPatternSyntax, rhs: ExpressionPatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public struct ValueBindingPatternSyntax: PatternSyntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case letOrVarKeyword
    case valuePattern
  }

  let data: SyntaxData

  /// Creates a `ValueBindingPatternSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  public var letOrVarKeyword: TokenSyntax {
  get {
    let child = data.child(at: Cursor.letOrVarKeyword, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLetOrVarKeyword(value)
  }
  }

  /// Returns a copy of the receiver with its `letOrVarKeyword` replaced.
  /// - param newChild: The new `letOrVarKeyword` to replace the node's
  ///                   current `letOrVarKeyword`, if present.
  public func withLetOrVarKeyword(
    _ newChild: TokenSyntax?) -> ValueBindingPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.letKeyword)
    let newData = data.replacingChild(raw, at: Cursor.letOrVarKeyword)
    return ValueBindingPatternSyntax(newData)
  }
  public var valuePattern: PatternSyntax {
  get {
    let child = data.child(at: Cursor.valuePattern, parent: self)
    return makeSyntax(child!) as! PatternSyntax
  }
  set(value) {
    self = withValuePattern(value)
  }
  }

  /// Returns a copy of the receiver with its `valuePattern` replaced.
  /// - param newChild: The new `valuePattern` to replace the node's
  ///                   current `valuePattern`, if present.
  public func withValuePattern(
    _ newChild: PatternSyntax?) -> ValueBindingPatternSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.pattern)
    let newData = data.replacingChild(raw, at: Cursor.valuePattern)
    return ValueBindingPatternSyntax(newData)
  }

  /// Determines if two `ValueBindingPatternSyntax` nodes are equal to each other.
  public static func ==(lhs: ValueBindingPatternSyntax, rhs: ValueBindingPatternSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A single argument to an `@available` argument like `*`, `iOS 10.1`,          or `message: "This has been deprecated"`.
/// 
public struct AvailabilityArgumentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case entry
    case trailingComma
  }

  let data: SyntaxData

  /// Creates a `AvailabilityArgumentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The actual argument
  public var entry: Syntax {
  get {
    let child = data.child(at: Cursor.entry, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withEntry(value)
  }
  }

  /// Returns a copy of the receiver with its `entry` replaced.
  /// - param newChild: The new `entry` to replace the node's
  ///                   current `entry`, if present.
  public func withEntry(
    _ newChild: Syntax?) -> AvailabilityArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.entry)
    return AvailabilityArgumentSyntax(newData)
  }
  /// 
  /// A trailing comma if the argument is followed by another                    argument
  /// 
  public var trailingComma: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.trailingComma, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withTrailingComma(value)
  }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> AvailabilityArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return AvailabilityArgumentSyntax(newData)
  }

  /// Determines if two `AvailabilityArgumentSyntax` nodes are equal to each other.
  public static func ==(lhs: AvailabilityArgumentSyntax, rhs: AvailabilityArgumentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A argument to an `@available` attribute that consists of a label and          a value, e.g. `message: "This has been deprecated"`.
/// 
public struct AvailabilityLabeledArgumentSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case label
    case colon
    case value
  }

  let data: SyntaxData

  /// Creates a `AvailabilityLabeledArgumentSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// The label of the argument
  public var label: TokenSyntax {
  get {
    let child = data.child(at: Cursor.label, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withLabel(value)
  }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> AvailabilityLabeledArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.label)
    return AvailabilityLabeledArgumentSyntax(newData)
  }
  /// The colon separating label and value
  public var colon: TokenSyntax {
  get {
    let child = data.child(at: Cursor.colon, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withColon(value)
  }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> AvailabilityLabeledArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return AvailabilityLabeledArgumentSyntax(newData)
  }
  /// The value of this labeled argument
  public var value: Syntax {
  get {
    let child = data.child(at: Cursor.value, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withValue(value)
  }
  }

  /// Returns a copy of the receiver with its `value` replaced.
  /// - param newChild: The new `value` to replace the node's
  ///                   current `value`, if present.
  public func withValue(
    _ newChild: Syntax?) -> AvailabilityLabeledArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.value)
    return AvailabilityLabeledArgumentSyntax(newData)
  }

  /// Determines if two `AvailabilityLabeledArgumentSyntax` nodes are equal to each other.
  public static func ==(lhs: AvailabilityLabeledArgumentSyntax, rhs: AvailabilityLabeledArgumentSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// An argument to `@available` that restricts the availability on a          certain platform to a version, e.g. `iOS 10` or `swift 3.4`.
/// 
public struct AvailabilityVersionRestrictionSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case platform
    case version
  }

  let data: SyntaxData

  /// Creates a `AvailabilityVersionRestrictionSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// The name of the OS on which the availability should be                    restricted or 'swift' if the availability should be                    restricted based on a Swift version.
  /// 
  public var platform: TokenSyntax {
  get {
    let child = data.child(at: Cursor.platform, parent: self)
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPlatform(value)
  }
  }

  /// Returns a copy of the receiver with its `platform` replaced.
  /// - param newChild: The new `platform` to replace the node's
  ///                   current `platform`, if present.
  public func withPlatform(
    _ newChild: TokenSyntax?) -> AvailabilityVersionRestrictionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.platform)
    return AvailabilityVersionRestrictionSyntax(newData)
  }
  public var version: VersionTupleSyntax {
  get {
    let child = data.child(at: Cursor.version, parent: self)
    return VersionTupleSyntax(child!)
  }
  set(value) {
    self = withVersion(value)
  }
  }

  /// Returns a copy of the receiver with its `version` replaced.
  /// - param newChild: The new `version` to replace the node's
  ///                   current `version`, if present.
  public func withVersion(
    _ newChild: VersionTupleSyntax?) -> AvailabilityVersionRestrictionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.versionTuple)
    let newData = data.replacingChild(raw, at: Cursor.version)
    return AvailabilityVersionRestrictionSyntax(newData)
  }

  /// Determines if two `AvailabilityVersionRestrictionSyntax` nodes are equal to each other.
  public static func ==(lhs: AvailabilityVersionRestrictionSyntax, rhs: AvailabilityVersionRestrictionSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


/// 
/// A version number of the form major.minor.patch in which the minor          and patch part may be ommited.
/// 
public struct VersionTupleSyntax: Syntax, _SyntaxBase, Hashable {
  enum Cursor: Int {
    case majorMinor
    case patchPeriod
    case patchVersion
  }

  let data: SyntaxData

  /// Creates a `VersionTupleSyntax` node from the provided root and data.
  internal init(_ data: SyntaxData) {
    self.data = data
  }

  /// 
  /// In case the version consists only of the major version, an                    integer literal that specifies the major version. In case                    the version consists of major and minor version number, a                    floating literal in which the decimal part is interpreted                    as the minor version.
  /// 
  public var majorMinor: Syntax {
  get {
    let child = data.child(at: Cursor.majorMinor, parent: self)
    return makeSyntax(child!) 
  }
  set(value) {
    self = withMajorMinor(value)
  }
  }

  /// Returns a copy of the receiver with its `majorMinor` replaced.
  /// - param newChild: The new `majorMinor` to replace the node's
  ///                   current `majorMinor`, if present.
  public func withMajorMinor(
    _ newChild: Syntax?) -> VersionTupleSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.majorMinor)
    return VersionTupleSyntax(newData)
  }
  /// 
  /// If the version contains a patch number, the period                    separating the minor from the patch number.
  /// 
  public var patchPeriod: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.patchPeriod, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPatchPeriod(value)
  }
  }

  /// Returns a copy of the receiver with its `patchPeriod` replaced.
  /// - param newChild: The new `patchPeriod` to replace the node's
  ///                   current `patchPeriod`, if present.
  public func withPatchPeriod(
    _ newChild: TokenSyntax?) -> VersionTupleSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.patchPeriod)
    return VersionTupleSyntax(newData)
  }
  /// 
  /// The patch version if specified.
  /// 
  public var patchVersion: TokenSyntax? {
  get {
    let child = data.child(at: Cursor.patchVersion, parent: self)
    if child == nil { return nil }
    return TokenSyntax(child!)
  }
  set(value) {
    self = withPatchVersion(value)
  }
  }

  /// Returns a copy of the receiver with its `patchVersion` replaced.
  /// - param newChild: The new `patchVersion` to replace the node's
  ///                   current `patchVersion`, if present.
  public func withPatchVersion(
    _ newChild: TokenSyntax?) -> VersionTupleSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.patchVersion)
    return VersionTupleSyntax(newData)
  }

  /// Determines if two `VersionTupleSyntax` nodes are equal to each other.
  public static func ==(lhs: VersionTupleSyntax, rhs: VersionTupleSyntax) -> Bool {
    return lhs.data.nodeId == rhs.data.nodeId
  }

  /// Feed the essential parts of this node to the supplied hasher.
  public func hash(into hasher: inout Hasher) {
    return data.nodeId.hash(into: &hasher)
  }
}


public protocol DeclGroupSyntax: Syntax {
  var attributes: AttributeListSyntax? { get }
  func withAttributes(_ newChild: AttributeListSyntax?) -> Self
  var modifiers: ModifierListSyntax? { get }
  func withModifiers(_ newChild: ModifierListSyntax?) -> Self
  var members: MemberDeclBlockSyntax { get }
  func withMembers(_ newChild: MemberDeclBlockSyntax?) -> Self
}
public protocol BracedSyntax: Syntax {
  var leftBrace: TokenSyntax { get }
  func withLeftBrace(_ newChild: TokenSyntax?) -> Self
  var rightBrace: TokenSyntax { get }
  func withRightBrace(_ newChild: TokenSyntax?) -> Self
}
public protocol IdentifiedDeclSyntax: Syntax {
  var identifier: TokenSyntax { get }
  func withIdentifier(_ newChild: TokenSyntax?) -> Self
}
public protocol WithCodeBlockSyntax: Syntax {
  var body: CodeBlockSyntax { get }
  func withBody(_ newChild: CodeBlockSyntax?) -> Self
}
public protocol ParenthesizedSyntax: Syntax {
  var leftParen: TokenSyntax { get }
  func withLeftParen(_ newChild: TokenSyntax?) -> Self
  var rightParen: TokenSyntax { get }
  func withRightParen(_ newChild: TokenSyntax?) -> Self
}
public protocol WithTrailingCommaSyntax: Syntax {
  var trailingComma: TokenSyntax? { get }
  func withTrailingComma(_ newChild: TokenSyntax?) -> Self
}
public protocol LabeledSyntax: Syntax {
  var labelName: TokenSyntax? { get }
  func withLabelName(_ newChild: TokenSyntax?) -> Self
  var labelColon: TokenSyntax? { get }
  func withLabelColon(_ newChild: TokenSyntax?) -> Self
}
public protocol WithStatementsSyntax: Syntax {
  var statements: CodeBlockItemListSyntax { get }
  func withStatements(_ newChild: CodeBlockItemListSyntax?) -> Self
}

extension CodeBlockSyntax: BracedSyntax, WithStatementsSyntax {}
extension DeclNameArgumentsSyntax: ParenthesizedSyntax {}
extension TupleExprSyntax: ParenthesizedSyntax {}
extension FunctionCallArgumentSyntax: WithTrailingCommaSyntax {}
extension TupleElementSyntax: WithTrailingCommaSyntax {}
extension ArrayElementSyntax: WithTrailingCommaSyntax {}
extension DictionaryElementSyntax: WithTrailingCommaSyntax {}
extension ClosureCaptureItemSyntax: WithTrailingCommaSyntax {}
extension ClosureParamSyntax: WithTrailingCommaSyntax {}
extension ClosureExprSyntax: BracedSyntax, WithStatementsSyntax {}
extension ExpressionSegmentSyntax: ParenthesizedSyntax {}
extension ObjcKeyPathExprSyntax: ParenthesizedSyntax {}
extension ObjcSelectorExprSyntax: ParenthesizedSyntax {}
extension ObjectLiteralExprSyntax: ParenthesizedSyntax {}
extension TypealiasDeclSyntax: IdentifiedDeclSyntax {}
extension AssociatedtypeDeclSyntax: IdentifiedDeclSyntax {}
extension ParameterClauseSyntax: ParenthesizedSyntax {}
extension PoundErrorDeclSyntax: ParenthesizedSyntax {}
extension PoundWarningDeclSyntax: ParenthesizedSyntax {}
extension PoundSourceLocationSyntax: ParenthesizedSyntax {}
extension InheritedTypeSyntax: WithTrailingCommaSyntax {}
extension ClassDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {}
extension StructDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {}
extension ProtocolDeclSyntax: DeclGroupSyntax, IdentifiedDeclSyntax {}
extension ExtensionDeclSyntax: DeclGroupSyntax {}
extension MemberDeclBlockSyntax: BracedSyntax {}
extension SourceFileSyntax: WithStatementsSyntax {}
extension FunctionParameterSyntax: WithTrailingCommaSyntax {}
extension FunctionDeclSyntax: IdentifiedDeclSyntax {}
extension AccessorParameterSyntax: ParenthesizedSyntax {}
extension AccessorBlockSyntax: BracedSyntax {}
extension PatternBindingSyntax: WithTrailingCommaSyntax {}
extension EnumCaseElementSyntax: WithTrailingCommaSyntax {}
extension EnumDeclSyntax: IdentifiedDeclSyntax {}
extension OperatorDeclSyntax: IdentifiedDeclSyntax {}
extension PrecedenceGroupDeclSyntax: IdentifiedDeclSyntax {}
extension LabeledSpecializeEntrySyntax: WithTrailingCommaSyntax {}
extension WhileStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension DeferStmtSyntax: WithCodeBlockSyntax {}
extension RepeatWhileStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension GuardStmtSyntax: WithCodeBlockSyntax {}
extension ForInStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension SwitchStmtSyntax: BracedSyntax, LabeledSyntax {}
extension DoStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension ConditionElementSyntax: WithTrailingCommaSyntax {}
extension IfStmtSyntax: WithCodeBlockSyntax, LabeledSyntax {}
extension ElseBlockSyntax: WithCodeBlockSyntax {}
extension SwitchCaseSyntax: WithStatementsSyntax {}
extension CaseItemSyntax: WithTrailingCommaSyntax {}
extension SameTypeRequirementSyntax: WithTrailingCommaSyntax {}
extension GenericParameterSyntax: WithTrailingCommaSyntax {}
extension ConformanceRequirementSyntax: WithTrailingCommaSyntax {}
extension TupleTypeElementSyntax: WithTrailingCommaSyntax {}
extension TupleTypeSyntax: ParenthesizedSyntax {}
extension FunctionTypeSyntax: ParenthesizedSyntax {}
extension GenericArgumentSyntax: WithTrailingCommaSyntax {}
extension TuplePatternSyntax: ParenthesizedSyntax {}
extension TuplePatternElementSyntax: WithTrailingCommaSyntax, LabeledSyntax {}

/// MARK: Convenience methods

extension StructDeclSyntax {
  /// Creates a new StructDeclSyntax with the provided name as its identifier.
  /// - param name: The new struct's name.
  /// - returns: A new StructDeclSyntax with the same fields as the receiver,
  ///            but with the provided identifier.
  func withIdentifier(_ name: String) -> StructDeclSyntax {
    let newToken = SyntaxFactory.makeIdentifier(name,
      leadingTrivia: identifier.leadingTrivia,
      trailingTrivia: identifier.trailingTrivia)
    return withIdentifier(newToken)
  }
}

extension SyntaxParser {
  static func verifyNodeDeclarationHash() -> Bool {
    return String(cString: swiftparse_syntax_structure_versioning_identifier()!) ==
      "3300989536797255056"
  }
}
