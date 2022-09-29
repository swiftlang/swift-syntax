//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxNodes.swift - Syntax Node definitions -------------===//
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


// MARK: - CodeBlockItemSyntax

/// 
/// A CodeBlockItem is any Syntax node that appears on its own line inside
/// a CodeBlock.
/// 
public struct CodeBlockItemSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case item
    case semicolon
    case errorTokens
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `CodeBlockItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .codeBlockItem else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `CodeBlockItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .codeBlockItem)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The underlying node inside the code block.
  public var item: Syntax {
    get {
      let childData = data.child(at: Cursor.item,
                                 parent: Syntax(self))
      return Syntax(childData!)
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
      let childData = data.child(at: Cursor.semicolon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.errorTokens,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return Syntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is Syntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is Syntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
  }
}

extension CodeBlockItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "item": Syntax(item).asProtocol(SyntaxProtocol.self),
      "semicolon": semicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "errorTokens": errorTokens.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CodeBlockSyntax

public struct CodeBlockSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftBrace
    case statements
    case rightBrace
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `CodeBlockSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .codeBlock else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `CodeBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .codeBlock)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBrace,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.statements,
                                 parent: Syntax(self))
      return CodeBlockItemListSyntax(childData!)
    }
    set(value) {
      self = withStatements(value)
    }
  }

  /// Adds the provided `Statement` to the node's `statements`
  /// collection.
  /// - param element: The new `Statement` to add to the node's
  ///                  `statements` collection.
  /// - returns: A copy of the receiver with the provided `Statement`
  ///            appended to its `statements` collection.
  public func addStatement(_ element: CodeBlockItemSyntax) -> CodeBlockSyntax {
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
      let childData = data.child(at: Cursor.rightBrace,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is CodeBlockItemListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockItemListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension CodeBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DeclNameArgumentSyntax

public struct DeclNameArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case colon
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DeclNameArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .declNameArgument else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DeclNameArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declNameArgument)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension DeclNameArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DeclNameArgumentsSyntax

public struct DeclNameArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftParen
    case arguments
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DeclNameArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .declNameArguments else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DeclNameArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declNameArguments)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.arguments,
                                 parent: Syntax(self))
      return DeclNameArgumentListSyntax(childData!)
    }
    set(value) {
      self = withArguments(value)
    }
  }

  /// Adds the provided `Argument` to the node's `arguments`
  /// collection.
  /// - param element: The new `Argument` to add to the node's
  ///                  `arguments` collection.
  /// - returns: A copy of the receiver with the provided `Argument`
  ///            appended to its `arguments` collection.
  public func addArgument(_ element: DeclNameArgumentSyntax) -> DeclNameArgumentsSyntax {
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
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is DeclNameArgumentListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclNameArgumentListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension DeclNameArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TupleExprElementSyntax

public struct TupleExprElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case label
    case colon
    case expression
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TupleExprElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .tupleExprElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TupleExprElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tupleExprElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var label: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.label)
    return TupleExprElementSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return TupleExprElementSyntax(newData)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
    }
    set(value) {
      self = withExpression(value)
    }
  }

  /// Returns a copy of the receiver with its `expression` replaced.
  /// - param newChild: The new `expression` to replace the node's
  ///                   current `expression`, if present.
  public func withExpression(
    _ newChild: ExprSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.expr)
    let newData = data.replacingChild(raw, at: Cursor.expression)
    return TupleExprElementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> TupleExprElementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return TupleExprElementSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is ExprSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension TupleExprElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": label.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ArrayElementSyntax

public struct ArrayElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case expression
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ArrayElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .arrayElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ArrayElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .arrayElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var expression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.expression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ArrayElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DictionaryElementSyntax

public struct DictionaryElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case keyExpression
    case colon
    case valueExpression
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DictionaryElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .dictionaryElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DictionaryElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .dictionaryElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var keyExpression: ExprSyntax {
    get {
      let childData = data.child(at: Cursor.keyExpression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.valueExpression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is ExprSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is ExprSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension DictionaryElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "keyExpression": Syntax(keyExpression).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "valueExpression": Syntax(valueExpression).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureCaptureItemSyntax

public struct ClosureCaptureItemSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case specifier
    case name
    case assignToken
    case expression
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ClosureCaptureItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .closureCaptureItem else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ClosureCaptureItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureCaptureItem)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var specifier: TokenListSyntax? {
    get {
      let childData = data.child(at: Cursor.specifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenListSyntax(childData!)
    }
    set(value) {
      self = withSpecifier(value)
    }
  }

  /// Adds the provided `SpecifierToken` to the node's `specifier`
  /// collection.
  /// - param element: The new `SpecifierToken` to add to the node's
  ///                  `specifier` collection.
  /// - returns: A copy of the receiver with the provided `SpecifierToken`
  ///            appended to its `specifier` collection.
  public func addSpecifierToken(_ element: TokenSyntax) -> ClosureCaptureItemSyntax {
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
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.assignToken,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.expression,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 5)
    // Check child #0 child is TokenListSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenListSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is ExprSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #4 child is TokenSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ClosureCaptureItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "specifier": specifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": name.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "assignToken": assignToken.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "expression": Syntax(expression).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureCaptureSignatureSyntax

public struct ClosureCaptureSignatureSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftSquare
    case items
    case rightSquare
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ClosureCaptureSignatureSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .closureCaptureSignature else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ClosureCaptureSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureCaptureSignature)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftSquare: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftSquare,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.items,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ClosureCaptureItemListSyntax(childData!)
    }
    set(value) {
      self = withItems(value)
    }
  }

  /// Adds the provided `Item` to the node's `items`
  /// collection.
  /// - param element: The new `Item` to add to the node's
  ///                  `items` collection.
  /// - returns: A copy of the receiver with the provided `Item`
  ///            appended to its `items` collection.
  public func addItem(_ element: ClosureCaptureItemSyntax) -> ClosureCaptureSignatureSyntax {
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
      let childData = data.child(at: Cursor.rightSquare,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is ClosureCaptureItemListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureCaptureItemListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ClosureCaptureSignatureSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftSquare": Syntax(leftSquare).asProtocol(SyntaxProtocol.self),
      "items": items.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightSquare": Syntax(rightSquare).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ClosureParamSyntax

public struct ClosureParamSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ClosureParamSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .closureParam else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ClosureParamSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureParam)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ClosureParamSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ClosureSignatureSyntax

public struct ClosureSignatureSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case attributes
    case capture
    case input
    case asyncKeyword
    case throwsTok
    case output
    case inTok
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ClosureSignatureSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .closureSignature else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ClosureSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .closureSignature)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: Cursor.attributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeListSyntax(childData!)
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
  public func addAttribute(_ element: Syntax) -> ClosureSignatureSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return ClosureSignatureSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return ClosureSignatureSyntax(newData)
  }

  public var capture: ClosureCaptureSignatureSyntax? {
    get {
      let childData = data.child(at: Cursor.capture,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ClosureCaptureSignatureSyntax(childData!)
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
      let childData = data.child(at: Cursor.input,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return Syntax(childData!)
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

  public var asyncKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.asyncKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAsyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `asyncKeyword` replaced.
  /// - param newChild: The new `asyncKeyword` to replace the node's
  ///                   current `asyncKeyword`, if present.
  public func withAsyncKeyword(
    _ newChild: TokenSyntax?) -> ClosureSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.asyncKeyword)
    return ClosureSignatureSyntax(newData)
  }

  public var throwsTok: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.throwsTok,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.output,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ReturnClauseSyntax(childData!)
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
      let childData = data.child(at: Cursor.inTok,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 7)
    // Check child #0 child is AttributeListSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #1 child is ClosureCaptureSignatureSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureCaptureSignatureSyntax.self))
    }
    // Check child #2 child is Syntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #4 child is TokenSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #5 child is ReturnClauseSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ReturnClauseSyntax.self))
    }
    // Check child #6 child is TokenSyntax 
    assert(rawChildren[6].raw != nil)
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ClosureSignatureSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "capture": capture.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "input": input.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "asyncKeyword": asyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsTok": throwsTok.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "output": output.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inTok": Syntax(inTok).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MultipleTrailingClosureElementSyntax

public struct MultipleTrailingClosureElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case label
    case colon
    case closure
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MultipleTrailingClosureElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .multipleTrailingClosureElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MultipleTrailingClosureElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .multipleTrailingClosureElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> MultipleTrailingClosureElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.label)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> MultipleTrailingClosureElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return MultipleTrailingClosureElementSyntax(newData)
  }

  public var closure: ClosureExprSyntax {
    get {
      let childData = data.child(at: Cursor.closure,
                                 parent: Syntax(self))
      return ClosureExprSyntax(childData!)
    }
    set(value) {
      self = withClosure(value)
    }
  }

  /// Returns a copy of the receiver with its `closure` replaced.
  /// - param newChild: The new `closure` to replace the node's
  ///                   current `closure`, if present.
  public func withClosure(
    _ newChild: ClosureExprSyntax?) -> MultipleTrailingClosureElementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.closureExpr)
    let newData = data.replacingChild(raw, at: Cursor.closure)
    return MultipleTrailingClosureElementSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is ClosureExprSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ClosureExprSyntax.self))
    }
  }
}

extension MultipleTrailingClosureElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "closure": Syntax(closure).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - StringSegmentSyntax

public struct StringSegmentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case content
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `StringSegmentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .stringSegment else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `StringSegmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .stringSegment)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var content: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.content,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 1)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension StringSegmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "content": Syntax(content).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ExpressionSegmentSyntax

public struct ExpressionSegmentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case backslash
    case delimiter
    case leftParen
    case expressions
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ExpressionSegmentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .expressionSegment else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ExpressionSegmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .expressionSegment)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var backslash: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.backslash,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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

  public var delimiter: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.delimiter,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDelimiter(value)
    }
  }

  /// Returns a copy of the receiver with its `delimiter` replaced.
  /// - param newChild: The new `delimiter` to replace the node's
  ///                   current `delimiter`, if present.
  public func withDelimiter(
    _ newChild: TokenSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.delimiter)
    return ExpressionSegmentSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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

  public var expressions: TupleExprElementListSyntax {
    get {
      let childData = data.child(at: Cursor.expressions,
                                 parent: Syntax(self))
      return TupleExprElementListSyntax(childData!)
    }
    set(value) {
      self = withExpressions(value)
    }
  }

  /// Adds the provided `Expression` to the node's `expressions`
  /// collection.
  /// - param element: The new `Expression` to add to the node's
  ///                  `expressions` collection.
  /// - returns: A copy of the receiver with the provided `Expression`
  ///            appended to its `expressions` collection.
  public func addExpression(_ element: TupleExprElementSyntax) -> ExpressionSegmentSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.expressions] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleExprElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.expressions)
    return ExpressionSegmentSyntax(newData)
  }

  /// Returns a copy of the receiver with its `expressions` replaced.
  /// - param newChild: The new `expressions` to replace the node's
  ///                   current `expressions`, if present.
  public func withExpressions(
    _ newChild: TupleExprElementListSyntax?) -> ExpressionSegmentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.tupleExprElementList)
    let newData = data.replacingChild(raw, at: Cursor.expressions)
    return ExpressionSegmentSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 5)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TupleExprElementListSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
    }
    // Check child #4 child is TokenSyntax 
    assert(rawChildren[4].raw != nil)
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ExpressionSegmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "backslash": Syntax(backslash).asProtocol(SyntaxProtocol.self),
      "delimiter": delimiter.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "expressions": Syntax(expressions).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ObjcNamePieceSyntax

public struct ObjcNamePieceSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case dot
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ObjcNamePieceSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .objcNamePiece else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ObjcNamePieceSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .objcNamePiece)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.dot,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ObjcNamePieceSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "dot": dot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeInitializerClauseSyntax

public struct TypeInitializerClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case equal
    case value
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TypeInitializerClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .typeInitializerClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TypeInitializerClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typeInitializerClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var equal: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.equal,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.value,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TypeSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
  }
}

extension TypeInitializerClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "equal": Syntax(equal).asProtocol(SyntaxProtocol.self),
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ParameterClauseSyntax

public struct ParameterClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftParen
    case parameterList
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ParameterClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .parameterClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ParameterClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .parameterClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.parameterList,
                                 parent: Syntax(self))
      return FunctionParameterListSyntax(childData!)
    }
    set(value) {
      self = withParameterList(value)
    }
  }

  /// Adds the provided `Parameter` to the node's `parameterList`
  /// collection.
  /// - param element: The new `Parameter` to add to the node's
  ///                  `parameterList` collection.
  /// - returns: A copy of the receiver with the provided `Parameter`
  ///            appended to its `parameterList` collection.
  public func addParameter(_ element: FunctionParameterSyntax) -> ParameterClauseSyntax {
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
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is FunctionParameterListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(FunctionParameterListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ParameterClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "parameterList": Syntax(parameterList).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ReturnClauseSyntax

public struct ReturnClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case arrow
    case returnType
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ReturnClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .returnClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ReturnClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .returnClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var arrow: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.arrow,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.returnType,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TypeSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
  }
}

extension ReturnClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "arrow": Syntax(arrow).asProtocol(SyntaxProtocol.self),
      "returnType": Syntax(returnType).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FunctionSignatureSyntax

public struct FunctionSignatureSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case input
    case asyncOrReasyncKeyword
    case throwsOrRethrowsKeyword
    case output
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `FunctionSignatureSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .functionSignature else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `FunctionSignatureSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionSignature)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var input: ParameterClauseSyntax {
    get {
      let childData = data.child(at: Cursor.input,
                                 parent: Syntax(self))
      return ParameterClauseSyntax(childData!)
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

  public var asyncOrReasyncKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.asyncOrReasyncKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAsyncOrReasyncKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `asyncOrReasyncKeyword` replaced.
  /// - param newChild: The new `asyncOrReasyncKeyword` to replace the node's
  ///                   current `asyncOrReasyncKeyword`, if present.
  public func withAsyncOrReasyncKeyword(
    _ newChild: TokenSyntax?) -> FunctionSignatureSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.asyncOrReasyncKeyword)
    return FunctionSignatureSyntax(newData)
  }

  public var throwsOrRethrowsKeyword: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.throwsOrRethrowsKeyword,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.output,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ReturnClauseSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is ParameterClauseSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ParameterClauseSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is ReturnClauseSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ReturnClauseSyntax.self))
    }
  }
}

extension FunctionSignatureSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "input": Syntax(input).asProtocol(SyntaxProtocol.self),
      "asyncOrReasyncKeyword": asyncOrReasyncKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "throwsOrRethrowsKeyword": throwsOrRethrowsKeyword.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "output": output.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - IfConfigClauseSyntax

public struct IfConfigClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case poundKeyword
    case condition
    case elements
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `IfConfigClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .ifConfigClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `IfConfigClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .ifConfigClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var poundKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.condition,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ExprSyntax(childData!)
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
      let childData = data.child(at: Cursor.elements,
                                 parent: Syntax(self))
      return Syntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is ExprSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
    // Check child #2 child is Syntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
  }
}

extension IfConfigClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundKeyword": Syntax(poundKeyword).asProtocol(SyntaxProtocol.self),
      "condition": condition.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "elements": Syntax(elements).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PoundSourceLocationArgsSyntax

public struct PoundSourceLocationArgsSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case fileArgLabel
    case fileArgColon
    case fileName
    case comma
    case lineArgLabel
    case lineArgColon
    case lineNumber
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PoundSourceLocationArgsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .poundSourceLocationArgs else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PoundSourceLocationArgsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .poundSourceLocationArgs)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var fileArgLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.fileArgLabel,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.fileArgColon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.fileName,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.comma,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.lineArgLabel,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.lineArgColon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.lineNumber,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 7)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TokenSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #4 child is TokenSyntax 
    assert(rawChildren[4].raw != nil)
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #5 child is TokenSyntax 
    assert(rawChildren[5].raw != nil)
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #6 child is TokenSyntax 
    assert(rawChildren[6].raw != nil)
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PoundSourceLocationArgsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "fileArgLabel": Syntax(fileArgLabel).asProtocol(SyntaxProtocol.self),
      "fileArgColon": Syntax(fileArgColon).asProtocol(SyntaxProtocol.self),
      "fileName": Syntax(fileName).asProtocol(SyntaxProtocol.self),
      "comma": Syntax(comma).asProtocol(SyntaxProtocol.self),
      "lineArgLabel": Syntax(lineArgLabel).asProtocol(SyntaxProtocol.self),
      "lineArgColon": Syntax(lineArgColon).asProtocol(SyntaxProtocol.self),
      "lineNumber": Syntax(lineNumber).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DeclModifierSyntax

public struct DeclModifierSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case detailLeftParen
    case detail
    case detailRightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DeclModifierSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .declModifier else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DeclModifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declModifier)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.detailLeftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.detail,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.detailRightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension DeclModifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "detailLeftParen": detailLeftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "detail": detail.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "detailRightParen": detailRightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - InheritedTypeSyntax

public struct InheritedTypeSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case typeName
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `InheritedTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .inheritedType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `InheritedTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .inheritedType)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var typeName: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.typeName,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TypeSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension InheritedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "typeName": Syntax(typeName).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TypeInheritanceClauseSyntax

public struct TypeInheritanceClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case colon
    case inheritedTypeCollection
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TypeInheritanceClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .typeInheritanceClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TypeInheritanceClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typeInheritanceClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.inheritedTypeCollection,
                                 parent: Syntax(self))
      return InheritedTypeListSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is InheritedTypeListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(InheritedTypeListSyntax.self))
    }
  }
}

extension TypeInheritanceClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "inheritedTypeCollection": Syntax(inheritedTypeCollection).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MemberDeclBlockSyntax

public struct MemberDeclBlockSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftBrace
    case members
    case rightBrace
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MemberDeclBlockSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .memberDeclBlock else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MemberDeclBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .memberDeclBlock)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBrace,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.members,
                                 parent: Syntax(self))
      return MemberDeclListSyntax(childData!)
    }
    set(value) {
      self = withMembers(value)
    }
  }

  /// Adds the provided `Member` to the node's `members`
  /// collection.
  /// - param element: The new `Member` to add to the node's
  ///                  `members` collection.
  /// - returns: A copy of the receiver with the provided `Member`
  ///            appended to its `members` collection.
  public func addMember(_ element: MemberDeclListItemSyntax) -> MemberDeclBlockSyntax {
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
      let childData = data.child(at: Cursor.rightBrace,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is MemberDeclListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(MemberDeclListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension MemberDeclBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "members": Syntax(members).asProtocol(SyntaxProtocol.self),
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MemberDeclListItemSyntax

/// 
/// A member declaration of a type consisting of a declaration and an
/// optional semicolon;
/// 
public struct MemberDeclListItemSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case decl
    case semicolon
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MemberDeclListItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .memberDeclListItem else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MemberDeclListItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .memberDeclListItem)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The declaration of the type member.
  public var decl: DeclSyntax {
    get {
      let childData = data.child(at: Cursor.decl,
                                 parent: Syntax(self))
      return DeclSyntax(childData!)
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
      let childData = data.child(at: Cursor.semicolon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is DeclSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension MemberDeclListItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "decl": Syntax(decl).asProtocol(SyntaxProtocol.self),
      "semicolon": semicolon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SourceFileSyntax

public struct SourceFileSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case statements
    case eofToken
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SourceFileSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .sourceFile else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SourceFileSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .sourceFile)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var statements: CodeBlockItemListSyntax {
    get {
      let childData = data.child(at: Cursor.statements,
                                 parent: Syntax(self))
      return CodeBlockItemListSyntax(childData!)
    }
    set(value) {
      self = withStatements(value)
    }
  }

  /// Adds the provided `Statement` to the node's `statements`
  /// collection.
  /// - param element: The new `Statement` to add to the node's
  ///                  `statements` collection.
  /// - returns: A copy of the receiver with the provided `Statement`
  ///            appended to its `statements` collection.
  public func addStatement(_ element: CodeBlockItemSyntax) -> SourceFileSyntax {
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
      let childData = data.child(at: Cursor.eofToken,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is CodeBlockItemListSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockItemListSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension SourceFileSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
      "eofToken": Syntax(eofToken).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - InitializerClauseSyntax

public struct InitializerClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case equal
    case value
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `InitializerClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .initializerClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `InitializerClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .initializerClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var equal: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.equal,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.value,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension InitializerClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "equal": Syntax(equal).asProtocol(SyntaxProtocol.self),
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - FunctionParameterSyntax

public struct FunctionParameterSyntax: SyntaxProtocol, SyntaxHashable {
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

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `FunctionParameterSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .functionParameter else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `FunctionParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionParameter)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: Cursor.attributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeListSyntax(childData!)
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
  public func addAttribute(_ element: Syntax) -> FunctionParameterSyntax {
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
      let childData = data.child(at: Cursor.firstName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.secondName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.type,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TypeSyntax(childData!)
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
      let childData = data.child(at: Cursor.ellipsis,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.defaultArgument,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 8)
    // Check child #0 child is AttributeListSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #4 child is TypeSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #5 child is TokenSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #6 child is InitializerClauseSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(InitializerClauseSyntax.self))
    }
    // Check child #7 child is TokenSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension FunctionParameterSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "firstName": firstName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "secondName": secondName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": type.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "ellipsis": ellipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "defaultArgument": defaultArgument.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessLevelModifierSyntax

public struct AccessLevelModifierSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case leftParen
    case modifier
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AccessLevelModifierSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .accessLevelModifier else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AccessLevelModifierSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessLevelModifier)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.modifier,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension AccessLevelModifierSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "modifier": modifier.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessPathComponentSyntax

public struct AccessPathComponentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case trailingDot
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AccessPathComponentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .accessPathComponent else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AccessPathComponentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessPathComponent)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingDot,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension AccessPathComponentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "trailingDot": trailingDot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AccessorParameterSyntax

public struct AccessorParameterSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftParen
    case name
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AccessorParameterSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .accessorParameter else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AccessorParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessorParameter)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension AccessorParameterSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AccessorBlockSyntax

public struct AccessorBlockSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftBrace
    case accessors
    case rightBrace
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AccessorBlockSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .accessorBlock else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AccessorBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .accessorBlock)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftBrace: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftBrace,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.accessors,
                                 parent: Syntax(self))
      return AccessorListSyntax(childData!)
    }
    set(value) {
      self = withAccessors(value)
    }
  }

  /// Adds the provided `Accessor` to the node's `accessors`
  /// collection.
  /// - param element: The new `Accessor` to add to the node's
  ///                  `accessors` collection.
  /// - returns: A copy of the receiver with the provided `Accessor`
  ///            appended to its `accessors` collection.
  public func addAccessor(_ element: AccessorDeclSyntax) -> AccessorBlockSyntax {
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
      let childData = data.child(at: Cursor.rightBrace,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is AccessorListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AccessorListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension AccessorBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftBrace": Syntax(leftBrace).asProtocol(SyntaxProtocol.self),
      "accessors": Syntax(accessors).asProtocol(SyntaxProtocol.self),
      "rightBrace": Syntax(rightBrace).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PatternBindingSyntax

public struct PatternBindingSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case pattern
    case typeAnnotation
    case initializer
    case accessor
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PatternBindingSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .patternBinding else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PatternBindingSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .patternBinding)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern,
                                 parent: Syntax(self))
      return PatternSyntax(childData!)
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
      let childData = data.child(at: Cursor.typeAnnotation,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TypeAnnotationSyntax(childData!)
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
      let childData = data.child(at: Cursor.initializer,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
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
      let childData = data.child(at: Cursor.accessor,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return Syntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 5)
    // Check child #0 child is PatternSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
    }
    // Check child #1 child is TypeAnnotationSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeAnnotationSyntax.self))
    }
    // Check child #2 child is InitializerClauseSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(InitializerClauseSyntax.self))
    }
    // Check child #3 child is Syntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #4 child is TokenSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PatternBindingSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessor": accessor.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - EnumCaseElementSyntax

/// 
/// An element of an enum case, containing the name of the case and,
/// optionally, either associated values or an assignment to a raw value.
/// 
public struct EnumCaseElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case identifier
    case associatedValue
    case rawValue
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `EnumCaseElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .enumCaseElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `EnumCaseElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .enumCaseElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The name of this case.
  public var identifier: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.identifier,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.associatedValue,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return ParameterClauseSyntax(childData!)
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
      let childData = data.child(at: Cursor.rawValue,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
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
  /// The trailing comma of this element, if the case has
  /// multiple elements.
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is ParameterClauseSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ParameterClauseSyntax.self))
    }
    // Check child #2 child is InitializerClauseSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(InitializerClauseSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension EnumCaseElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "identifier": Syntax(identifier).asProtocol(SyntaxProtocol.self),
      "associatedValue": associatedValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rawValue": rawValue.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - OperatorPrecedenceAndTypesSyntax

/// 
/// A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.
/// 
public struct OperatorPrecedenceAndTypesSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case colon
    case precedenceGroupAndDesignatedTypes
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `OperatorPrecedenceAndTypesSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .operatorPrecedenceAndTypes else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `OperatorPrecedenceAndTypesSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .operatorPrecedenceAndTypes)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.precedenceGroupAndDesignatedTypes,
                                 parent: Syntax(self))
      return IdentifierListSyntax(childData!)
    }
    set(value) {
      self = withPrecedenceGroupAndDesignatedTypes(value)
    }
  }

  /// Adds the provided `PrecedenceGroupAndDesignatedType` to the node's `precedenceGroupAndDesignatedTypes`
  /// collection.
  /// - param element: The new `PrecedenceGroupAndDesignatedType` to add to the node's
  ///                  `precedenceGroupAndDesignatedTypes` collection.
  /// - returns: A copy of the receiver with the provided `PrecedenceGroupAndDesignatedType`
  ///            appended to its `precedenceGroupAndDesignatedTypes` collection.
  public func addPrecedenceGroupAndDesignatedType(_ element: TokenSyntax) -> OperatorPrecedenceAndTypesSyntax {
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is IdentifierListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(IdentifierListSyntax.self))
    }
  }
}

extension OperatorPrecedenceAndTypesSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "precedenceGroupAndDesignatedTypes": Syntax(precedenceGroupAndDesignatedTypes).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PrecedenceGroupRelationSyntax

/// 
/// Specify the new precedence group's relation to existing precedence
/// groups.
/// 
public struct PrecedenceGroupRelationSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case higherThanOrLowerThan
    case colon
    case otherNames
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupRelationSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .precedenceGroupRelation else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PrecedenceGroupRelationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupRelation)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// 
  /// The relation to specified other precedence groups.
  /// 
  public var higherThanOrLowerThan: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.higherThanOrLowerThan,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.otherNames,
                                 parent: Syntax(self))
      return PrecedenceGroupNameListSyntax(childData!)
    }
    set(value) {
      self = withOtherNames(value)
    }
  }

  /// Adds the provided `OtherName` to the node's `otherNames`
  /// collection.
  /// - param element: The new `OtherName` to add to the node's
  ///                  `otherNames` collection.
  /// - returns: A copy of the receiver with the provided `OtherName`
  ///            appended to its `otherNames` collection.
  public func addOtherName(_ element: PrecedenceGroupNameElementSyntax) -> PrecedenceGroupRelationSyntax {
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is PrecedenceGroupNameListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PrecedenceGroupNameListSyntax.self))
    }
  }
}

extension PrecedenceGroupRelationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "higherThanOrLowerThan": Syntax(higherThanOrLowerThan).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "otherNames": Syntax(otherNames).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PrecedenceGroupNameElementSyntax

public struct PrecedenceGroupNameElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupNameElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .precedenceGroupNameElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PrecedenceGroupNameElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupNameElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PrecedenceGroupNameElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrecedenceGroupAssignmentSyntax

/// 
/// Specifies the precedence of an operator when used in an operation
/// that includes optional chaining.
/// 
public struct PrecedenceGroupAssignmentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case assignmentKeyword
    case colon
    case flag
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupAssignmentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .precedenceGroupAssignment else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PrecedenceGroupAssignmentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupAssignment)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var assignmentKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.assignmentKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.flag,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PrecedenceGroupAssignmentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "assignmentKeyword": Syntax(assignmentKeyword).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "flag": Syntax(flag).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PrecedenceGroupAssociativitySyntax

/// 
/// Specifies how a sequence of operators with the same precedence level
/// are grouped together in the absence of grouping parentheses.
/// 
public struct PrecedenceGroupAssociativitySyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case associativityKeyword
    case colon
    case value
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PrecedenceGroupAssociativitySyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .precedenceGroupAssociativity else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PrecedenceGroupAssociativitySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .precedenceGroupAssociativity)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var associativityKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.associativityKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.value,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PrecedenceGroupAssociativitySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "associativityKeyword": Syntax(associativityKeyword).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - CustomAttributeSyntax

/// 
/// A custom `@` attribute.
/// 
public struct CustomAttributeSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case atSignToken
    case attributeName
    case leftParen
    case argumentList
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `CustomAttributeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .customAttribute else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `CustomAttributeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .customAttribute)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The `@` sign.
  public var atSignToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.atSignToken,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAtSignToken(value)
    }
  }

  /// Returns a copy of the receiver with its `atSignToken` replaced.
  /// - param newChild: The new `atSignToken` to replace the node's
  ///                   current `atSignToken`, if present.
  public func withAtSignToken(
    _ newChild: TokenSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.atSign)
    let newData = data.replacingChild(raw, at: Cursor.atSignToken)
    return CustomAttributeSyntax(newData)
  }

  /// The name of the attribute.
  public var attributeName: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.attributeName,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withAttributeName(value)
    }
  }

  /// Returns a copy of the receiver with its `attributeName` replaced.
  /// - param newChild: The new `attributeName` to replace the node's
  ///                   current `attributeName`, if present.
  public func withAttributeName(
    _ newChild: TypeSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.type)
    let newData = data.replacingChild(raw, at: Cursor.attributeName)
    return CustomAttributeSyntax(newData)
  }

  public var leftParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return CustomAttributeSyntax(newData)
  }

  public var argumentList: TupleExprElementListSyntax? {
    get {
      let childData = data.child(at: Cursor.argumentList,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TupleExprElementListSyntax(childData!)
    }
    set(value) {
      self = withArgumentList(value)
    }
  }

  /// Adds the provided `Argument` to the node's `argumentList`
  /// collection.
  /// - param element: The new `Argument` to add to the node's
  ///                  `argumentList` collection.
  /// - returns: A copy of the receiver with the provided `Argument`
  ///            appended to its `argumentList` collection.
  public func addArgument(_ element: TupleExprElementSyntax) -> CustomAttributeSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.argumentList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.tupleExprElementList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.argumentList)
    return CustomAttributeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `argumentList` replaced.
  /// - param newChild: The new `argumentList` to replace the node's
  ///                   current `argumentList`, if present.
  public func withArgumentList(
    _ newChild: TupleExprElementListSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.argumentList)
    return CustomAttributeSyntax(newData)
  }

  public var rightParen: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> CustomAttributeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return CustomAttributeSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 5)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TypeSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TupleExprElementListSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TupleExprElementListSyntax.self))
    }
    // Check child #4 child is TokenSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension CustomAttributeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "atSignToken": Syntax(atSignToken).asProtocol(SyntaxProtocol.self),
      "attributeName": Syntax(attributeName).asProtocol(SyntaxProtocol.self),
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argumentList": argumentList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AttributeSyntax

/// 
/// An `@` attribute.
/// 
public struct AttributeSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case atSignToken
    case attributeName
    case leftParen
    case argument
    case rightParen
    case tokenList
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AttributeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .attribute else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AttributeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .attribute)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The `@` sign.
  public var atSignToken: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.atSignToken,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.attributeName,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
  /// The arguments of the attribute. In case the attribute
  /// takes multiple arguments, they are gather in the
  /// appropriate takes first.
  /// 
  public var argument: Syntax? {
    get {
      let childData = data.child(at: Cursor.argument,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return Syntax(childData!)
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
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.tokenList,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenListSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 6)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is Syntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #4 child is TokenSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #5 child is TokenListSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenListSyntax.self))
    }
  }
}

extension AttributeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "atSignToken": Syntax(atSignToken).asProtocol(SyntaxProtocol.self),
      "attributeName": Syntax(attributeName).asProtocol(SyntaxProtocol.self),
      "leftParen": leftParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "argument": argument.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": rightParen.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "tokenList": tokenList.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityEntrySyntax

/// 
/// The availability argument for the _specialize attribute
/// 
public struct AvailabilityEntrySyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case label
    case colon
    case availabilityList
    case semicolon
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityEntrySyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .availabilityEntry else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AvailabilityEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityEntry)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.label)
    return AvailabilityEntrySyntax(newData)
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return AvailabilityEntrySyntax(newData)
  }

  public var availabilityList: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: Cursor.availabilityList,
                                 parent: Syntax(self))
      return AvailabilitySpecListSyntax(childData!)
    }
    set(value) {
      self = withAvailabilityList(value)
    }
  }

  /// Adds the provided `Availability` to the node's `availabilityList`
  /// collection.
  /// - param element: The new `Availability` to add to the node's
  ///                  `availabilityList` collection.
  /// - returns: A copy of the receiver with the provided `Availability`
  ///            appended to its `availabilityList` collection.
  public func addAvailability(_ element: AvailabilityArgumentSyntax) -> AvailabilityEntrySyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.availabilityList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.availabilitySpecList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.availabilityList)
    return AvailabilityEntrySyntax(newData)
  }

  /// Returns a copy of the receiver with its `availabilityList` replaced.
  /// - param newChild: The new `availabilityList` to replace the node's
  ///                   current `availabilityList`, if present.
  public func withAvailabilityList(
    _ newChild: AvailabilitySpecListSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.availabilitySpecList)
    let newData = data.replacingChild(raw, at: Cursor.availabilityList)
    return AvailabilityEntrySyntax(newData)
  }

  public var semicolon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.semicolon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withSemicolon(value)
    }
  }

  /// Returns a copy of the receiver with its `semicolon` replaced.
  /// - param newChild: The new `semicolon` to replace the node's
  ///                   current `semicolon`, if present.
  public func withSemicolon(
    _ newChild: TokenSyntax?) -> AvailabilityEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.semicolon)
    let newData = data.replacingChild(raw, at: Cursor.semicolon)
    return AvailabilityEntrySyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is AvailabilitySpecListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AvailabilitySpecListSyntax.self))
    }
    // Check child #3 child is TokenSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension AvailabilityEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "availabilityList": Syntax(availabilityList).asProtocol(SyntaxProtocol.self),
      "semicolon": Syntax(semicolon).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - LabeledSpecializeEntrySyntax

/// 
/// A labeled argument for the `@_specialize` attribute like
/// `exported: true`
/// 
public struct LabeledSpecializeEntrySyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case label
    case colon
    case value
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `LabeledSpecializeEntrySyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .labeledSpecializeEntry else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `LabeledSpecializeEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .labeledSpecializeEntry)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.value,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension LabeledSpecializeEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TargetFunctionEntrySyntax

/// 
/// A labeled argument for the `@_specialize` attribute with a function
/// decl value like
/// `target: myFunc(_:)`
/// 
public struct TargetFunctionEntrySyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case label
    case colon
    case delcname
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TargetFunctionEntrySyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .targetFunctionEntry else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TargetFunctionEntrySyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .targetFunctionEntry)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `label` replaced.
  /// - param newChild: The new `label` to replace the node's
  ///                   current `label`, if present.
  public func withLabel(
    _ newChild: TokenSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.label)
    return TargetFunctionEntrySyntax(newData)
  }

  /// The colon separating the label and the value
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return TargetFunctionEntrySyntax(newData)
  }

  /// The value for this argument
  public var delcname: DeclNameSyntax {
    get {
      let childData = data.child(at: Cursor.delcname,
                                 parent: Syntax(self))
      return DeclNameSyntax(childData!)
    }
    set(value) {
      self = withDelcname(value)
    }
  }

  /// Returns a copy of the receiver with its `delcname` replaced.
  /// - param newChild: The new `delcname` to replace the node's
  ///                   current `delcname`, if present.
  public func withDelcname(
    _ newChild: DeclNameSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.declName)
    let newData = data.replacingChild(raw, at: Cursor.delcname)
    return TargetFunctionEntrySyntax(newData)
  }

  /// 
  /// A trailing comma if this argument is followed by another one
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> TargetFunctionEntrySyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return TargetFunctionEntrySyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is DeclNameSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclNameSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension TargetFunctionEntrySyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "delcname": Syntax(delcname).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - NamedAttributeStringArgumentSyntax

/// 
/// The argument for the `@_dynamic_replacement` or `@_private`
/// attribute of the form `for: "function()"` or `sourceFile:
/// "Src.swift"`
/// 
public struct NamedAttributeStringArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case nameTok
    case colon
    case stringOrDeclname
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `NamedAttributeStringArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .namedAttributeStringArgument else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `NamedAttributeStringArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .namedAttributeStringArgument)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The label of the argument
  public var nameTok: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.nameTok,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.stringOrDeclname,
                                 parent: Syntax(self))
      return Syntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is Syntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
  }
}

extension NamedAttributeStringArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "nameTok": Syntax(nameTok).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "stringOrDeclname": Syntax(stringOrDeclname).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DeclNameSyntax

public struct DeclNameSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case declBaseName
    case declNameArguments
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DeclNameSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .declName else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DeclNameSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .declName)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// 
  /// The base name of the protocol's requirement.
  /// 
  public var declBaseName: Syntax {
    get {
      let childData = data.child(at: Cursor.declBaseName,
                                 parent: Syntax(self))
      return Syntax(childData!)
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
  /// The argument labels of the protocol's requirement if it
  /// is a function requirement.
  /// 
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.declNameArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return DeclNameArgumentsSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is Syntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #1 child is DeclNameArgumentsSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclNameArgumentsSyntax.self))
    }
  }
}

extension DeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "declBaseName": Syntax(declBaseName).asProtocol(SyntaxProtocol.self),
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ImplementsAttributeArgumentsSyntax

/// 
/// The arguments for the `@_implements` attribute of the form
/// `Type, methodName(arg1Label:arg2Label:)`
/// 
public struct ImplementsAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case type
    case comma
    case declBaseName
    case declNameArguments
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ImplementsAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .implementsAttributeArguments else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ImplementsAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .implementsAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// 
  /// The type for which the method with this attribute
  /// implements a requirement.
  /// 
  public var type: SimpleTypeIdentifierSyntax {
    get {
      let childData = data.child(at: Cursor.type,
                                 parent: Syntax(self))
      return SimpleTypeIdentifierSyntax(childData!)
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
      let childData = data.child(at: Cursor.comma,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.declBaseName,
                                 parent: Syntax(self))
      return Syntax(childData!)
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
  /// The argument labels of the protocol's requirement if it
  /// is a function requirement.
  /// 
  public var declNameArguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.declNameArguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return DeclNameArgumentsSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is SimpleTypeIdentifierSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(SimpleTypeIdentifierSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is Syntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #3 child is DeclNameArgumentsSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclNameArgumentsSyntax.self))
    }
  }
}

extension ImplementsAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "comma": Syntax(comma).asProtocol(SyntaxProtocol.self),
      "declBaseName": Syntax(declBaseName).asProtocol(SyntaxProtocol.self),
      "declNameArguments": declNameArguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - ObjCSelectorPieceSyntax

/// 
/// A piece of an Objective-C selector. Either consisiting of just an
/// identifier for a nullary selector, an identifier and a colon for a
/// labeled argument or just a colon for an unlabeled argument
/// 
public struct ObjCSelectorPieceSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case colon
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ObjCSelectorPieceSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .objCSelectorPiece else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ObjCSelectorPieceSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .objCSelectorPiece)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var name: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ObjCSelectorPieceSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": name.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DifferentiableAttributeArgumentsSyntax

/// 
/// The arguments for the `@differentiable` attribute: an optional
/// differentiability kind, an optional differentiability parameter clause,
/// and an optional 'where' clause.
/// 
public struct DifferentiableAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case diffKind
    case diffKindComma
    case diffParams
    case diffParamsComma
    case whereClause
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DifferentiableAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .differentiableAttributeArguments else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DifferentiableAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiableAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var diffKind: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.diffKind,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDiffKind(value)
    }
  }

  /// Returns a copy of the receiver with its `diffKind` replaced.
  /// - param newChild: The new `diffKind` to replace the node's
  ///                   current `diffKind`, if present.
  public func withDiffKind(
    _ newChild: TokenSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.diffKind)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The comma following the differentiability kind, if it exists.
  /// 
  public var diffKindComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.diffKindComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDiffKindComma(value)
    }
  }

  /// Returns a copy of the receiver with its `diffKindComma` replaced.
  /// - param newChild: The new `diffKindComma` to replace the node's
  ///                   current `diffKindComma`, if present.
  public func withDiffKindComma(
    _ newChild: TokenSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.diffKindComma)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var diffParams: DifferentiabilityParamsClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.diffParams,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return DifferentiabilityParamsClauseSyntax(childData!)
    }
    set(value) {
      self = withDiffParams(value)
    }
  }

  /// Returns a copy of the receiver with its `diffParams` replaced.
  /// - param newChild: The new `diffParams` to replace the node's
  ///                   current `diffParams`, if present.
  public func withDiffParams(
    _ newChild: DifferentiabilityParamsClauseSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.diffParams)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The comma following the differentiability parameters clause,
  /// if it exists.
  /// 
  public var diffParamsComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.diffParamsComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDiffParamsComma(value)
    }
  }

  /// Returns a copy of the receiver with its `diffParamsComma` replaced.
  /// - param newChild: The new `diffParamsComma` to replace the node's
  ///                   current `diffParamsComma`, if present.
  public func withDiffParamsComma(
    _ newChild: TokenSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.diffParamsComma)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }

  public var whereClause: GenericWhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.whereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return GenericWhereClauseSyntax(childData!)
    }
    set(value) {
      self = withWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `whereClause` replaced.
  /// - param newChild: The new `whereClause` to replace the node's
  ///                   current `whereClause`, if present.
  public func withWhereClause(
    _ newChild: GenericWhereClauseSyntax?) -> DifferentiableAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.whereClause)
    return DifferentiableAttributeArgumentsSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 5)
    // Check child #0 child is TokenSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is DifferentiabilityParamsClauseSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DifferentiabilityParamsClauseSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #4 child is GenericWhereClauseSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericWhereClauseSyntax.self))
    }
  }
}

extension DifferentiableAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "diffKind": diffKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffKindComma": diffKindComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffParams": diffParams.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffParamsComma": diffParamsComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DifferentiabilityParamsClauseSyntax

/// A clause containing differentiability parameters.
public struct DifferentiabilityParamsClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case wrtLabel
    case colon
    case parameters
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DifferentiabilityParamsClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .differentiabilityParamsClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DifferentiabilityParamsClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiabilityParamsClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The "wrt" label.
  public var wrtLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.wrtLabel,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withWrtLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `wrtLabel` replaced.
  /// - param newChild: The new `wrtLabel` to replace the node's
  ///                   current `wrtLabel`, if present.
  public func withWrtLabel(
    _ newChild: TokenSyntax?) -> DifferentiabilityParamsClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.wrtLabel)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  /// 
  /// The colon separating "wrt" and the parameter list.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> DifferentiabilityParamsClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return DifferentiabilityParamsClauseSyntax(newData)
  }

  public var parameters: Syntax {
    get {
      let childData = data.child(at: Cursor.parameters,
                                 parent: Syntax(self))
      return Syntax(childData!)
    }
    set(value) {
      self = withParameters(value)
    }
  }

  /// Returns a copy of the receiver with its `parameters` replaced.
  /// - param newChild: The new `parameters` to replace the node's
  ///                   current `parameters`, if present.
  public func withParameters(
    _ newChild: Syntax?) -> DifferentiabilityParamsClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.parameters)
    return DifferentiabilityParamsClauseSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is Syntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
  }
}

extension DifferentiabilityParamsClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "wrtLabel": Syntax(wrtLabel).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "parameters": Syntax(parameters).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DifferentiabilityParamsSyntax

/// The differentiability parameters.
public struct DifferentiabilityParamsSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftParen
    case diffParams
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DifferentiabilityParamsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .differentiabilityParams else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DifferentiabilityParamsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiabilityParams)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> DifferentiabilityParamsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return DifferentiabilityParamsSyntax(newData)
  }

  /// The parameters for differentiation.
  public var diffParams: DifferentiabilityParamListSyntax {
    get {
      let childData = data.child(at: Cursor.diffParams,
                                 parent: Syntax(self))
      return DifferentiabilityParamListSyntax(childData!)
    }
    set(value) {
      self = withDiffParams(value)
    }
  }

  /// Adds the provided `DifferentiabilityParam` to the node's `diffParams`
  /// collection.
  /// - param element: The new `DifferentiabilityParam` to add to the node's
  ///                  `diffParams` collection.
  /// - returns: A copy of the receiver with the provided `DifferentiabilityParam`
  ///            appended to its `diffParams` collection.
  public func addDifferentiabilityParam(_ element: DifferentiabilityParamSyntax) -> DifferentiabilityParamsSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.diffParams] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.differentiabilityParamList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.diffParams)
    return DifferentiabilityParamsSyntax(newData)
  }

  /// Returns a copy of the receiver with its `diffParams` replaced.
  /// - param newChild: The new `diffParams` to replace the node's
  ///                   current `diffParams`, if present.
  public func withDiffParams(
    _ newChild: DifferentiabilityParamListSyntax?) -> DifferentiabilityParamsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.differentiabilityParamList)
    let newData = data.replacingChild(raw, at: Cursor.diffParams)
    return DifferentiabilityParamsSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> DifferentiabilityParamsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return DifferentiabilityParamsSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is DifferentiabilityParamListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DifferentiabilityParamListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension DifferentiabilityParamsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "diffParams": Syntax(diffParams).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - DifferentiabilityParamSyntax

/// 
/// A differentiability parameter: either the "self" identifier, a function
/// parameter name, or a function parameter index.
/// 
public struct DifferentiabilityParamSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case parameter
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DifferentiabilityParamSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .differentiabilityParam else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DifferentiabilityParamSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .differentiabilityParam)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var parameter: Syntax {
    get {
      let childData = data.child(at: Cursor.parameter,
                                 parent: Syntax(self))
      return Syntax(childData!)
    }
    set(value) {
      self = withParameter(value)
    }
  }

  /// Returns a copy of the receiver with its `parameter` replaced.
  /// - param newChild: The new `parameter` to replace the node's
  ///                   current `parameter`, if present.
  public func withParameter(
    _ newChild: Syntax?) -> DifferentiabilityParamSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.parameter)
    return DifferentiabilityParamSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> DifferentiabilityParamSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return DifferentiabilityParamSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is Syntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension DifferentiabilityParamSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "parameter": Syntax(parameter).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - DerivativeRegistrationAttributeArgumentsSyntax

/// 
/// The arguments for the '@derivative(of:)' and '@transpose(of:)'
/// attributes: the 'of:' label, the original declaration name, and an
/// optional differentiability parameter list.
/// 
public struct DerivativeRegistrationAttributeArgumentsSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case ofLabel
    case colon
    case originalDeclName
    case period
    case accessorKind
    case comma
    case diffParams
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `DerivativeRegistrationAttributeArgumentsSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .derivativeRegistrationAttributeArguments else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `DerivativeRegistrationAttributeArgumentsSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .derivativeRegistrationAttributeArguments)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The "of" label.
  public var ofLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.ofLabel,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withOfLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `ofLabel` replaced.
  /// - param newChild: The new `ofLabel` to replace the node's
  ///                   current `ofLabel`, if present.
  public func withOfLabel(
    _ newChild: TokenSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.ofLabel)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The colon separating the "of" label and the original
  /// declaration name.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// The referenced original declaration name.
  public var originalDeclName: QualifiedDeclNameSyntax {
    get {
      let childData = data.child(at: Cursor.originalDeclName,
                                 parent: Syntax(self))
      return QualifiedDeclNameSyntax(childData!)
    }
    set(value) {
      self = withOriginalDeclName(value)
    }
  }

  /// Returns a copy of the receiver with its `originalDeclName` replaced.
  /// - param newChild: The new `originalDeclName` to replace the node's
  ///                   current `originalDeclName`, if present.
  public func withOriginalDeclName(
    _ newChild: QualifiedDeclNameSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.qualifiedDeclName)
    let newData = data.replacingChild(raw, at: Cursor.originalDeclName)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// 
  /// The period separating the original declaration name and the
  /// accessor name.
  /// 
  public var period: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.period,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPeriod(value)
    }
  }

  /// Returns a copy of the receiver with its `period` replaced.
  /// - param newChild: The new `period` to replace the node's
  ///                   current `period`, if present.
  public func withPeriod(
    _ newChild: TokenSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.period)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  /// The accessor name.
  public var accessorKind: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.accessorKind,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withAccessorKind(value)
    }
  }

  /// Returns a copy of the receiver with its `accessorKind` replaced.
  /// - param newChild: The new `accessorKind` to replace the node's
  ///                   current `accessorKind`, if present.
  public func withAccessorKind(
    _ newChild: TokenSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.accessorKind)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var comma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.comma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withComma(value)
    }
  }

  /// Returns a copy of the receiver with its `comma` replaced.
  /// - param newChild: The new `comma` to replace the node's
  ///                   current `comma`, if present.
  public func withComma(
    _ newChild: TokenSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.comma)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }

  public var diffParams: DifferentiabilityParamsClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.diffParams,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return DifferentiabilityParamsClauseSyntax(childData!)
    }
    set(value) {
      self = withDiffParams(value)
    }
  }

  /// Returns a copy of the receiver with its `diffParams` replaced.
  /// - param newChild: The new `diffParams` to replace the node's
  ///                   current `diffParams`, if present.
  public func withDiffParams(
    _ newChild: DifferentiabilityParamsClauseSyntax?) -> DerivativeRegistrationAttributeArgumentsSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.diffParams)
    return DerivativeRegistrationAttributeArgumentsSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 7)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is QualifiedDeclNameSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(QualifiedDeclNameSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #4 child is TokenSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #5 child is TokenSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #6 child is DifferentiabilityParamsClauseSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DifferentiabilityParamsClauseSyntax.self))
    }
  }
}

extension DerivativeRegistrationAttributeArgumentsSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "ofLabel": Syntax(ofLabel).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "originalDeclName": Syntax(originalDeclName).asProtocol(SyntaxProtocol.self),
      "period": period.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "accessorKind": accessorKind.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "comma": comma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "diffParams": diffParams.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - QualifiedDeclNameSyntax

/// 
/// An optionally qualified function declaration name (e.g. `+(_:_:)`,
/// `A.B.C.foo(_:_:)`).
/// 
public struct QualifiedDeclNameSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case baseType
    case dot
    case name
    case arguments
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `QualifiedDeclNameSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .qualifiedDeclName else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `QualifiedDeclNameSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .qualifiedDeclName)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// 
  /// The base type of the qualified name, optionally specified.
  /// 
  public var baseType: TypeSyntax? {
    get {
      let childData = data.child(at: Cursor.baseType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withBaseType(value)
    }
  }

  /// Returns a copy of the receiver with its `baseType` replaced.
  /// - param newChild: The new `baseType` to replace the node's
  ///                   current `baseType`, if present.
  public func withBaseType(
    _ newChild: TypeSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.baseType)
    return QualifiedDeclNameSyntax(newData)
  }

  public var dot: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.dot,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withDot(value)
    }
  }

  /// Returns a copy of the receiver with its `dot` replaced.
  /// - param newChild: The new `dot` to replace the node's
  ///                   current `dot`, if present.
  public func withDot(
    _ newChild: TokenSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.dot)
    return QualifiedDeclNameSyntax(newData)
  }

  /// 
  /// The base name of the referenced function.
  /// 
  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withName(value)
    }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return QualifiedDeclNameSyntax(newData)
  }

  /// 
  /// The argument labels of the referenced function, optionally
  /// specified.
  /// 
  public var arguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.arguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return DeclNameArgumentsSyntax(childData!)
    }
    set(value) {
      self = withArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: DeclNameArgumentsSyntax?) -> QualifiedDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.arguments)
    return QualifiedDeclNameSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TypeSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is DeclNameArgumentsSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclNameArgumentsSyntax.self))
    }
  }
}

extension QualifiedDeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "baseType": baseType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "dot": dot.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "arguments": arguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - FunctionDeclNameSyntax

/// A function declaration name (e.g. `foo(_:_:)`).
public struct FunctionDeclNameSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case name
    case arguments
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `FunctionDeclNameSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .functionDeclName else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `FunctionDeclNameSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .functionDeclName)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// 
  /// The base name of the referenced function.
  /// 
  public var name: Syntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return Syntax(childData!)
    }
    set(value) {
      self = withName(value)
    }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: Syntax?) -> FunctionDeclNameSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.name)
    return FunctionDeclNameSyntax(newData)
  }

  /// 
  /// The argument labels of the referenced function, optionally
  /// specified.
  /// 
  public var arguments: DeclNameArgumentsSyntax? {
    get {
      let childData = data.child(at: Cursor.arguments,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return DeclNameArgumentsSyntax(childData!)
    }
    set(value) {
      self = withArguments(value)
    }
  }

  /// Returns a copy of the receiver with its `arguments` replaced.
  /// - param newChild: The new `arguments` to replace the node's
  ///                   current `arguments`, if present.
  public func withArguments(
    _ newChild: DeclNameArgumentsSyntax?) -> FunctionDeclNameSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.arguments)
    return FunctionDeclNameSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is Syntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #1 child is DeclNameArgumentsSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(DeclNameArgumentsSyntax.self))
    }
  }
}

extension FunctionDeclNameSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "arguments": arguments.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - BackDeployAttributeSpecListSyntax

/// 
/// A collection of arguments for the `@_backDeploy` attribute
/// 
public struct BackDeployAttributeSpecListSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case beforeLabel
    case colon
    case versionList
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `BackDeployAttributeSpecListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .backDeployAttributeSpecList else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `BackDeployAttributeSpecListSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .backDeployAttributeSpecList)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The "before" label.
  public var beforeLabel: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.beforeLabel,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withBeforeLabel(value)
    }
  }

  /// Returns a copy of the receiver with its `beforeLabel` replaced.
  /// - param newChild: The new `beforeLabel` to replace the node's
  ///                   current `beforeLabel`, if present.
  public func withBeforeLabel(
    _ newChild: TokenSyntax?) -> BackDeployAttributeSpecListSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.beforeLabel)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  /// 
  /// The colon separating "before" and the parameter list.
  /// 
  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> BackDeployAttributeSpecListSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.colon)
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  /// 
  /// The list of OS versions in which the declaration became ABI
  /// stable.
  /// 
  public var versionList: BackDeployVersionListSyntax {
    get {
      let childData = data.child(at: Cursor.versionList,
                                 parent: Syntax(self))
      return BackDeployVersionListSyntax(childData!)
    }
    set(value) {
      self = withVersionList(value)
    }
  }

  /// Adds the provided `Availability` to the node's `versionList`
  /// collection.
  /// - param element: The new `Availability` to add to the node's
  ///                  `versionList` collection.
  /// - returns: A copy of the receiver with the provided `Availability`
  ///            appended to its `versionList` collection.
  public func addAvailability(_ element: BackDeployVersionArgumentSyntax) -> BackDeployAttributeSpecListSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.versionList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.backDeployVersionList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.versionList)
    return BackDeployAttributeSpecListSyntax(newData)
  }

  /// Returns a copy of the receiver with its `versionList` replaced.
  /// - param newChild: The new `versionList` to replace the node's
  ///                   current `versionList`, if present.
  public func withVersionList(
    _ newChild: BackDeployVersionListSyntax?) -> BackDeployAttributeSpecListSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.backDeployVersionList)
    let newData = data.replacingChild(raw, at: Cursor.versionList)
    return BackDeployAttributeSpecListSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is BackDeployVersionListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(BackDeployVersionListSyntax.self))
    }
  }
}

extension BackDeployAttributeSpecListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "beforeLabel": Syntax(beforeLabel).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "versionList": Syntax(versionList).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - BackDeployVersionArgumentSyntax

/// 
/// A single platform/version pair in a `@_backDeploy` attribute,
/// e.g. `iOS 10.1`.
/// 
public struct BackDeployVersionArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case availabilityVersionRestriction
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `BackDeployVersionArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .backDeployVersionArgument else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `BackDeployVersionArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .backDeployVersionArgument)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var availabilityVersionRestriction: AvailabilityVersionRestrictionSyntax {
    get {
      let childData = data.child(at: Cursor.availabilityVersionRestriction,
                                 parent: Syntax(self))
      return AvailabilityVersionRestrictionSyntax(childData!)
    }
    set(value) {
      self = withAvailabilityVersionRestriction(value)
    }
  }

  /// Returns a copy of the receiver with its `availabilityVersionRestriction` replaced.
  /// - param newChild: The new `availabilityVersionRestriction` to replace the node's
  ///                   current `availabilityVersionRestriction`, if present.
  public func withAvailabilityVersionRestriction(
    _ newChild: AvailabilityVersionRestrictionSyntax?) -> BackDeployVersionArgumentSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.availabilityVersionRestriction)
    let newData = data.replacingChild(raw, at: Cursor.availabilityVersionRestriction)
    return BackDeployVersionArgumentSyntax(newData)
  }

  /// 
  /// A trailing comma if the argument is followed by another
  /// argument
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> BackDeployVersionArgumentSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return BackDeployVersionArgumentSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is AvailabilityVersionRestrictionSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AvailabilityVersionRestrictionSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension BackDeployVersionArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "availabilityVersionRestriction": Syntax(availabilityVersionRestriction).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - WhereClauseSyntax

public struct WhereClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case whereKeyword
    case guardResult
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `WhereClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .whereClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `WhereClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .whereClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var whereKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.whereKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.guardResult,
                                 parent: Syntax(self))
      return ExprSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is ExprSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprSyntax.self))
    }
  }
}

extension WhereClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "whereKeyword": Syntax(whereKeyword).asProtocol(SyntaxProtocol.self),
      "guardResult": Syntax(guardResult).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - YieldListSyntax

public struct YieldListSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftParen
    case elementList
    case trailingComma
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `YieldListSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .yieldList else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `YieldListSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .yieldList)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.elementList,
                                 parent: Syntax(self))
      return ExprListSyntax(childData!)
    }
    set(value) {
      self = withElementList(value)
    }
  }

  /// Adds the provided `Element` to the node's `elementList`
  /// collection.
  /// - param element: The new `Element` to add to the node's
  ///                  `elementList` collection.
  /// - returns: A copy of the receiver with the provided `Element`
  ///            appended to its `elementList` collection.
  public func addElement(_ element: ExprSyntax) -> YieldListSyntax {
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is ExprListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(ExprListSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TokenSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension YieldListSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "elementList": Syntax(elementList).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ConditionElementSyntax

public struct ConditionElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case condition
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ConditionElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .conditionElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ConditionElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conditionElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var condition: Syntax {
    get {
      let childData = data.child(at: Cursor.condition,
                                 parent: Syntax(self))
      return Syntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is Syntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension ConditionElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "condition": Syntax(condition).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityConditionSyntax

public struct AvailabilityConditionSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case poundAvailableKeyword
    case leftParen
    case availabilitySpec
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .availabilityCondition else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AvailabilityConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityCondition)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var poundAvailableKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundAvailableKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.availabilitySpec,
                                 parent: Syntax(self))
      return AvailabilitySpecListSyntax(childData!)
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
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is AvailabilitySpecListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AvailabilitySpecListSyntax.self))
    }
    // Check child #3 child is TokenSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension AvailabilityConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundAvailableKeyword": Syntax(poundAvailableKeyword).asProtocol(SyntaxProtocol.self),
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "availabilitySpec": Syntax(availabilitySpec).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - MatchingPatternConditionSyntax

public struct MatchingPatternConditionSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case caseKeyword
    case pattern
    case typeAnnotation
    case initializer
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `MatchingPatternConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .matchingPatternCondition else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `MatchingPatternConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .matchingPatternCondition)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.caseKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.pattern,
                                 parent: Syntax(self))
      return PatternSyntax(childData!)
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
      let childData = data.child(at: Cursor.typeAnnotation,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TypeAnnotationSyntax(childData!)
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
      let childData = data.child(at: Cursor.initializer,
                                 parent: Syntax(self))
      return InitializerClauseSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is PatternSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
    }
    // Check child #2 child is TypeAnnotationSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeAnnotationSyntax.self))
    }
    // Check child #3 child is InitializerClauseSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(InitializerClauseSyntax.self))
    }
  }
}

extension MatchingPatternConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "caseKeyword": Syntax(caseKeyword).asProtocol(SyntaxProtocol.self),
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": Syntax(initializer).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - OptionalBindingConditionSyntax

public struct OptionalBindingConditionSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case letOrVarKeyword
    case pattern
    case typeAnnotation
    case initializer
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `OptionalBindingConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .optionalBindingCondition else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `OptionalBindingConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .optionalBindingCondition)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var letOrVarKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.letOrVarKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.pattern,
                                 parent: Syntax(self))
      return PatternSyntax(childData!)
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
      let childData = data.child(at: Cursor.typeAnnotation,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TypeAnnotationSyntax(childData!)
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

  public var initializer: InitializerClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.initializer,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
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
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return OptionalBindingConditionSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is PatternSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
    }
    // Check child #2 child is TypeAnnotationSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeAnnotationSyntax.self))
    }
    // Check child #3 child is InitializerClauseSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(InitializerClauseSyntax.self))
    }
  }
}

extension OptionalBindingConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "letOrVarKeyword": Syntax(letOrVarKeyword).asProtocol(SyntaxProtocol.self),
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "typeAnnotation": typeAnnotation.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - UnavailabilityConditionSyntax

public struct UnavailabilityConditionSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case poundUnavailableKeyword
    case leftParen
    case availabilitySpec
    case rightParen
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `UnavailabilityConditionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .unavailabilityCondition else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `UnavailabilityConditionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .unavailabilityCondition)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var poundUnavailableKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.poundUnavailableKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withPoundUnavailableKeyword(value)
    }
  }

  /// Returns a copy of the receiver with its `poundUnavailableKeyword` replaced.
  /// - param newChild: The new `poundUnavailableKeyword` to replace the node's
  ///                   current `poundUnavailableKeyword`, if present.
  public func withPoundUnavailableKeyword(
    _ newChild: TokenSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.poundUnavailableKeyword)
    let newData = data.replacingChild(raw, at: Cursor.poundUnavailableKeyword)
    return UnavailabilityConditionSyntax(newData)
  }

  public var leftParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftParen(value)
    }
  }

  /// Returns a copy of the receiver with its `leftParen` replaced.
  /// - param newChild: The new `leftParen` to replace the node's
  ///                   current `leftParen`, if present.
  public func withLeftParen(
    _ newChild: TokenSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftParen)
    let newData = data.replacingChild(raw, at: Cursor.leftParen)
    return UnavailabilityConditionSyntax(newData)
  }

  public var availabilitySpec: AvailabilitySpecListSyntax {
    get {
      let childData = data.child(at: Cursor.availabilitySpec,
                                 parent: Syntax(self))
      return AvailabilitySpecListSyntax(childData!)
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
  public func addAvailabilityArgument(_ element: AvailabilityArgumentSyntax) -> UnavailabilityConditionSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.availabilitySpec] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.availabilitySpecList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.availabilitySpec)
    return UnavailabilityConditionSyntax(newData)
  }

  /// Returns a copy of the receiver with its `availabilitySpec` replaced.
  /// - param newChild: The new `availabilitySpec` to replace the node's
  ///                   current `availabilitySpec`, if present.
  public func withAvailabilitySpec(
    _ newChild: AvailabilitySpecListSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.availabilitySpecList)
    let newData = data.replacingChild(raw, at: Cursor.availabilitySpec)
    return UnavailabilityConditionSyntax(newData)
  }

  public var rightParen: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightParen,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightParen(value)
    }
  }

  /// Returns a copy of the receiver with its `rightParen` replaced.
  /// - param newChild: The new `rightParen` to replace the node's
  ///                   current `rightParen`, if present.
  public func withRightParen(
    _ newChild: TokenSyntax?) -> UnavailabilityConditionSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightParen)
    let newData = data.replacingChild(raw, at: Cursor.rightParen)
    return UnavailabilityConditionSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is AvailabilitySpecListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AvailabilitySpecListSyntax.self))
    }
    // Check child #3 child is TokenSyntax 
    assert(rawChildren[3].raw != nil)
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension UnavailabilityConditionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "poundUnavailableKeyword": Syntax(poundUnavailableKeyword).asProtocol(SyntaxProtocol.self),
      "leftParen": Syntax(leftParen).asProtocol(SyntaxProtocol.self),
      "availabilitySpec": Syntax(availabilitySpec).asProtocol(SyntaxProtocol.self),
      "rightParen": Syntax(rightParen).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ElseIfContinuationSyntax

public struct ElseIfContinuationSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case ifStatement
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ElseIfContinuationSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .elseIfContinuation else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ElseIfContinuationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .elseIfContinuation)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var ifStatement: IfStmtSyntax {
    get {
      let childData = data.child(at: Cursor.ifStatement,
                                 parent: Syntax(self))
      return IfStmtSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 1)
    // Check child #0 child is IfStmtSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(IfStmtSyntax.self))
    }
  }
}

extension ElseIfContinuationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "ifStatement": Syntax(ifStatement).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ElseBlockSyntax

public struct ElseBlockSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case elseKeyword
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ElseBlockSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .elseBlock else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ElseBlockSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .elseBlock)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var elseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.elseKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is CodeBlockSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension ElseBlockSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "elseKeyword": Syntax(elseKeyword).asProtocol(SyntaxProtocol.self),
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SwitchCaseSyntax

public struct SwitchCaseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case unknownAttr
    case label
    case statements
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SwitchCaseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .switchCase else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SwitchCaseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .switchCase)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var unknownAttr: AttributeSyntax? {
    get {
      let childData = data.child(at: Cursor.unknownAttr,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeSyntax(childData!)
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
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      return Syntax(childData!)
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
      let childData = data.child(at: Cursor.statements,
                                 parent: Syntax(self))
      return CodeBlockItemListSyntax(childData!)
    }
    set(value) {
      self = withStatements(value)
    }
  }

  /// Adds the provided `Statement` to the node's `statements`
  /// collection.
  /// - param element: The new `Statement` to add to the node's
  ///                  `statements` collection.
  /// - returns: A copy of the receiver with the provided `Statement`
  ///            appended to its `statements` collection.
  public func addStatement(_ element: CodeBlockItemSyntax) -> SwitchCaseSyntax {
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is AttributeSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeSyntax.self))
    }
    // Check child #1 child is Syntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #2 child is CodeBlockItemListSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockItemListSyntax.self))
    }
  }
}

extension SwitchCaseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "unknownAttr": unknownAttr.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "statements": Syntax(statements).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - SwitchDefaultLabelSyntax

public struct SwitchDefaultLabelSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case defaultKeyword
    case colon
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SwitchDefaultLabelSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .switchDefaultLabel else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SwitchDefaultLabelSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .switchDefaultLabel)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var defaultKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.defaultKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension SwitchDefaultLabelSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "defaultKeyword": Syntax(defaultKeyword).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - CaseItemSyntax

public struct CaseItemSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case pattern
    case whereClause
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `CaseItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .caseItem else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `CaseItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .caseItem)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var pattern: PatternSyntax {
    get {
      let childData = data.child(at: Cursor.pattern,
                                 parent: Syntax(self))
      return PatternSyntax(childData!)
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
      let childData = data.child(at: Cursor.whereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return WhereClauseSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is PatternSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
    }
    // Check child #1 child is WhereClauseSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(WhereClauseSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension CaseItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - CatchItemSyntax

public struct CatchItemSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case pattern
    case whereClause
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `CatchItemSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .catchItem else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `CatchItemSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .catchItem)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var pattern: PatternSyntax? {
    get {
      let childData = data.child(at: Cursor.pattern,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return PatternSyntax(childData!)
    }
    set(value) {
      self = withPattern(value)
    }
  }

  /// Returns a copy of the receiver with its `pattern` replaced.
  /// - param newChild: The new `pattern` to replace the node's
  ///                   current `pattern`, if present.
  public func withPattern(
    _ newChild: PatternSyntax?) -> CatchItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.pattern)
    return CatchItemSyntax(newData)
  }

  public var whereClause: WhereClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.whereClause,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return WhereClauseSyntax(childData!)
    }
    set(value) {
      self = withWhereClause(value)
    }
  }

  /// Returns a copy of the receiver with its `whereClause` replaced.
  /// - param newChild: The new `whereClause` to replace the node's
  ///                   current `whereClause`, if present.
  public func withWhereClause(
    _ newChild: WhereClauseSyntax?) -> CatchItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.whereClause)
    return CatchItemSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> CatchItemSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return CatchItemSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is PatternSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
    }
    // Check child #1 child is WhereClauseSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(WhereClauseSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension CatchItemSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "pattern": pattern.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "whereClause": whereClause.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SwitchCaseLabelSyntax

public struct SwitchCaseLabelSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case caseKeyword
    case caseItems
    case colon
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SwitchCaseLabelSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .switchCaseLabel else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SwitchCaseLabelSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .switchCaseLabel)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var caseKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.caseKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.caseItems,
                                 parent: Syntax(self))
      return CaseItemListSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is CaseItemListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CaseItemListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension SwitchCaseLabelSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "caseKeyword": Syntax(caseKeyword).asProtocol(SyntaxProtocol.self),
      "caseItems": Syntax(caseItems).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - CatchClauseSyntax

public struct CatchClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case catchKeyword
    case catchItems
    case body
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `CatchClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .catchClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `CatchClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .catchClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var catchKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.catchKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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

  public var catchItems: CatchItemListSyntax? {
    get {
      let childData = data.child(at: Cursor.catchItems,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return CatchItemListSyntax(childData!)
    }
    set(value) {
      self = withCatchItems(value)
    }
  }

  /// Adds the provided `CatchItem` to the node's `catchItems`
  /// collection.
  /// - param element: The new `CatchItem` to add to the node's
  ///                  `catchItems` collection.
  /// - returns: A copy of the receiver with the provided `CatchItem`
  ///            appended to its `catchItems` collection.
  public func addCatchItem(_ element: CatchItemSyntax) -> CatchClauseSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.catchItems] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.catchItemList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.catchItems)
    return CatchClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `catchItems` replaced.
  /// - param newChild: The new `catchItems` to replace the node's
  ///                   current `catchItems`, if present.
  public func withCatchItems(
    _ newChild: CatchItemListSyntax?) -> CatchClauseSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.catchItems)
    return CatchClauseSyntax(newData)
  }

  public var body: CodeBlockSyntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return CodeBlockSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is CatchItemListSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CatchItemListSyntax.self))
    }
    // Check child #2 child is CodeBlockSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(CodeBlockSyntax.self))
    }
  }
}

extension CatchClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "catchKeyword": Syntax(catchKeyword).asProtocol(SyntaxProtocol.self),
      "catchItems": catchItems.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - GenericWhereClauseSyntax

public struct GenericWhereClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case whereKeyword
    case requirementList
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `GenericWhereClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .genericWhereClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `GenericWhereClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericWhereClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var whereKeyword: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.whereKeyword,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.requirementList,
                                 parent: Syntax(self))
      return GenericRequirementListSyntax(childData!)
    }
    set(value) {
      self = withRequirementList(value)
    }
  }

  /// Adds the provided `Requirement` to the node's `requirementList`
  /// collection.
  /// - param element: The new `Requirement` to add to the node's
  ///                  `requirementList` collection.
  /// - returns: A copy of the receiver with the provided `Requirement`
  ///            appended to its `requirementList` collection.
  public func addRequirement(_ element: GenericRequirementSyntax) -> GenericWhereClauseSyntax {
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is GenericRequirementListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericRequirementListSyntax.self))
    }
  }
}

extension GenericWhereClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "whereKeyword": Syntax(whereKeyword).asProtocol(SyntaxProtocol.self),
      "requirementList": Syntax(requirementList).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - GenericRequirementSyntax

public struct GenericRequirementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case body
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `GenericRequirementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .genericRequirement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `GenericRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericRequirement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var body: Syntax {
    get {
      let childData = data.child(at: Cursor.body,
                                 parent: Syntax(self))
      return Syntax(childData!)
    }
    set(value) {
      self = withBody(value)
    }
  }

  /// Returns a copy of the receiver with its `body` replaced.
  /// - param newChild: The new `body` to replace the node's
  ///                   current `body`, if present.
  public func withBody(
    _ newChild: Syntax?) -> GenericRequirementSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.unknown)
    let newData = data.replacingChild(raw, at: Cursor.body)
    return GenericRequirementSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> GenericRequirementSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return GenericRequirementSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is Syntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension GenericRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "body": Syntax(body).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - SameTypeRequirementSyntax

public struct SameTypeRequirementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftTypeIdentifier
    case equalityToken
    case rightTypeIdentifier
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `SameTypeRequirementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .sameTypeRequirement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `SameTypeRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .sameTypeRequirement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.leftTypeIdentifier,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
      let childData = data.child(at: Cursor.equalityToken,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.rightTypeIdentifier,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TypeSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TypeSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
  }
}

extension SameTypeRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftTypeIdentifier": Syntax(leftTypeIdentifier).asProtocol(SyntaxProtocol.self),
      "equalityToken": Syntax(equalityToken).asProtocol(SyntaxProtocol.self),
      "rightTypeIdentifier": Syntax(rightTypeIdentifier).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - GenericParameterSyntax

public struct GenericParameterSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case attributes
    case name
    case colon
    case inheritedType
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `GenericParameterSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .genericParameter else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `GenericParameterSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericParameter)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: Cursor.attributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeListSyntax(childData!)
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
  public func addAttribute(_ element: Syntax) -> GenericParameterSyntax {
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
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.inheritedType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TypeSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 5)
    // Check child #0 child is AttributeListSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TypeSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #4 child is TokenSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension GenericParameterSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritedType": inheritedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - PrimaryAssociatedTypeSyntax

public struct PrimaryAssociatedTypeSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case attributes
    case name
    case colon
    case inheritedType
    case initializer
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PrimaryAssociatedTypeSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .primaryAssociatedType else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PrimaryAssociatedTypeSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .primaryAssociatedType)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var attributes: AttributeListSyntax? {
    get {
      let childData = data.child(at: Cursor.attributes,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return AttributeListSyntax(childData!)
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
  public func addAttribute(_ element: Syntax) -> PrimaryAssociatedTypeSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.attributes] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.attributeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.attributes)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  /// Returns a copy of the receiver with its `attributes` replaced.
  /// - param newChild: The new `attributes` to replace the node's
  ///                   current `attributes`, if present.
  public func withAttributes(
    _ newChild: AttributeListSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.attributes)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var name: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withName(value)
    }
  }

  /// Returns a copy of the receiver with its `name` replaced.
  /// - param newChild: The new `name` to replace the node's
  ///                   current `name`, if present.
  public func withName(
    _ newChild: TokenSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.identifier(""))
    let newData = data.replacingChild(raw, at: Cursor.name)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var colon: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withColon(value)
    }
  }

  /// Returns a copy of the receiver with its `colon` replaced.
  /// - param newChild: The new `colon` to replace the node's
  ///                   current `colon`, if present.
  public func withColon(
    _ newChild: TokenSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.colon)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var inheritedType: TypeSyntax? {
    get {
      let childData = data.child(at: Cursor.inheritedType,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TypeSyntax(childData!)
    }
    set(value) {
      self = withInheritedType(value)
    }
  }

  /// Returns a copy of the receiver with its `inheritedType` replaced.
  /// - param newChild: The new `inheritedType` to replace the node's
  ///                   current `inheritedType`, if present.
  public func withInheritedType(
    _ newChild: TypeSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.inheritedType)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var initializer: TypeInitializerClauseSyntax? {
    get {
      let childData = data.child(at: Cursor.initializer,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TypeInitializerClauseSyntax(childData!)
    }
    set(value) {
      self = withInitializer(value)
    }
  }

  /// Returns a copy of the receiver with its `initializer` replaced.
  /// - param newChild: The new `initializer` to replace the node's
  ///                   current `initializer`, if present.
  public func withInitializer(
    _ newChild: TypeInitializerClauseSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.initializer)
    return PrimaryAssociatedTypeSyntax(newData)
  }

  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withTrailingComma(value)
    }
  }

  /// Returns a copy of the receiver with its `trailingComma` replaced.
  /// - param newChild: The new `trailingComma` to replace the node's
  ///                   current `trailingComma`, if present.
  public func withTrailingComma(
    _ newChild: TokenSyntax?) -> PrimaryAssociatedTypeSyntax {
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.trailingComma)
    return PrimaryAssociatedTypeSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 6)
    // Check child #0 child is AttributeListSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(AttributeListSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TypeSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #4 child is TypeInitializerClauseSyntax or missing
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeInitializerClauseSyntax.self))
    }
    // Check child #5 child is TokenSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PrimaryAssociatedTypeSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "attributes": attributes.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": Syntax(name).asProtocol(SyntaxProtocol.self),
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "inheritedType": inheritedType.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericParameterClauseSyntax

public struct GenericParameterClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftAngleBracket
    case genericParameterList
    case rightAngleBracket
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `GenericParameterClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .genericParameterClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `GenericParameterClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericParameterClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftAngleBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.genericParameterList,
                                 parent: Syntax(self))
      return GenericParameterListSyntax(childData!)
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
      let childData = data.child(at: Cursor.rightAngleBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is GenericParameterListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericParameterListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension GenericParameterClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self),
      "genericParameterList": Syntax(genericParameterList).asProtocol(SyntaxProtocol.self),
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - ConformanceRequirementSyntax

public struct ConformanceRequirementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftTypeIdentifier
    case colon
    case rightTypeIdentifier
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `ConformanceRequirementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .conformanceRequirement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `ConformanceRequirementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .conformanceRequirement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftTypeIdentifier: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.leftTypeIdentifier,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.rightTypeIdentifier,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TypeSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TypeSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
  }
}

extension ConformanceRequirementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftTypeIdentifier": Syntax(leftTypeIdentifier).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "rightTypeIdentifier": Syntax(rightTypeIdentifier).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - PrimaryAssociatedTypeClauseSyntax

public struct PrimaryAssociatedTypeClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftAngleBracket
    case primaryAssociatedTypeList
    case rightAngleBracket
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `PrimaryAssociatedTypeClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .primaryAssociatedTypeClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `PrimaryAssociatedTypeClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .primaryAssociatedTypeClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftAngleBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withLeftAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `leftAngleBracket` replaced.
  /// - param newChild: The new `leftAngleBracket` to replace the node's
  ///                   current `leftAngleBracket`, if present.
  public func withLeftAngleBracket(
    _ newChild: TokenSyntax?) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.leftAngle)
    let newData = data.replacingChild(raw, at: Cursor.leftAngleBracket)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var primaryAssociatedTypeList: PrimaryAssociatedTypeListSyntax {
    get {
      let childData = data.child(at: Cursor.primaryAssociatedTypeList,
                                 parent: Syntax(self))
      return PrimaryAssociatedTypeListSyntax(childData!)
    }
    set(value) {
      self = withPrimaryAssociatedTypeList(value)
    }
  }

  /// Adds the provided `PrimaryAssociatedType` to the node's `primaryAssociatedTypeList`
  /// collection.
  /// - param element: The new `PrimaryAssociatedType` to add to the node's
  ///                  `primaryAssociatedTypeList` collection.
  /// - returns: A copy of the receiver with the provided `PrimaryAssociatedType`
  ///            appended to its `primaryAssociatedTypeList` collection.
  public func addPrimaryAssociatedType(_ element: PrimaryAssociatedTypeSyntax) -> PrimaryAssociatedTypeClauseSyntax {
    var collection: RawSyntax
    if let col = raw[Cursor.primaryAssociatedTypeList] {
      collection = col.appending(element.raw)
    } else {
      collection = RawSyntax.create(kind: SyntaxKind.primaryAssociatedTypeList,
        layout: [element.raw], length: element.raw.totalLength, presence: .present)
    }
    let newData = data.replacingChild(collection,
                                      at: Cursor.primaryAssociatedTypeList)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  /// Returns a copy of the receiver with its `primaryAssociatedTypeList` replaced.
  /// - param newChild: The new `primaryAssociatedTypeList` to replace the node's
  ///                   current `primaryAssociatedTypeList`, if present.
  public func withPrimaryAssociatedTypeList(
    _ newChild: PrimaryAssociatedTypeListSyntax?) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missing(SyntaxKind.primaryAssociatedTypeList)
    let newData = data.replacingChild(raw, at: Cursor.primaryAssociatedTypeList)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }

  public var rightAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.rightAngleBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
    }
    set(value) {
      self = withRightAngleBracket(value)
    }
  }

  /// Returns a copy of the receiver with its `rightAngleBracket` replaced.
  /// - param newChild: The new `rightAngleBracket` to replace the node's
  ///                   current `rightAngleBracket`, if present.
  public func withRightAngleBracket(
    _ newChild: TokenSyntax?) -> PrimaryAssociatedTypeClauseSyntax {
    let raw = newChild?.raw ?? RawSyntax.missingToken(TokenKind.rightAngle)
    let newData = data.replacingChild(raw, at: Cursor.rightAngleBracket)
    return PrimaryAssociatedTypeClauseSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is PrimaryAssociatedTypeListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PrimaryAssociatedTypeListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension PrimaryAssociatedTypeClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self),
      "primaryAssociatedTypeList": Syntax(primaryAssociatedTypeList).asProtocol(SyntaxProtocol.self),
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - CompositionTypeElementSyntax

public struct CompositionTypeElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case type
    case ampersand
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `CompositionTypeElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .compositionTypeElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `CompositionTypeElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .compositionTypeElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var type: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.type,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
      let childData = data.child(at: Cursor.ampersand,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TypeSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension CompositionTypeElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "ampersand": ampersand.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - TupleTypeElementSyntax

public struct TupleTypeElementSyntax: SyntaxProtocol, SyntaxHashable {
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

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TupleTypeElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .tupleTypeElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TupleTypeElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tupleTypeElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var inOut: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.inOut,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.name,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.secondName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.type,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
      let childData = data.child(at: Cursor.ellipsis,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.initializer,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return InitializerClauseSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 8)
    // Check child #0 child is TokenSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #4 child is TypeSyntax 
    assert(rawChildren[4].raw != nil)
    if let raw = rawChildren[4].raw {
      let info = rawChildren[4].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #5 child is TokenSyntax or missing
    if let raw = rawChildren[5].raw {
      let info = rawChildren[5].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #6 child is InitializerClauseSyntax or missing
    if let raw = rawChildren[6].raw {
      let info = rawChildren[6].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(InitializerClauseSyntax.self))
    }
    // Check child #7 child is TokenSyntax or missing
    if let raw = rawChildren[7].raw {
      let info = rawChildren[7].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension TupleTypeElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "inOut": inOut.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "name": name.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "secondName": secondName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "colon": colon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
      "ellipsis": ellipsis.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "initializer": initializer.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericArgumentSyntax

public struct GenericArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case argumentType
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `GenericArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .genericArgument else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `GenericArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericArgument)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var argumentType: TypeSyntax {
    get {
      let childData = data.child(at: Cursor.argumentType,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TypeSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension GenericArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "argumentType": Syntax(argumentType).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - GenericArgumentClauseSyntax

public struct GenericArgumentClauseSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case leftAngleBracket
    case arguments
    case rightAngleBracket
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `GenericArgumentClauseSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .genericArgumentClause else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `GenericArgumentClauseSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .genericArgumentClause)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var leftAngleBracket: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.leftAngleBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.arguments,
                                 parent: Syntax(self))
      return GenericArgumentListSyntax(childData!)
    }
    set(value) {
      self = withArguments(value)
    }
  }

  /// Adds the provided `Argument` to the node's `arguments`
  /// collection.
  /// - param element: The new `Argument` to add to the node's
  ///                  `arguments` collection.
  /// - returns: A copy of the receiver with the provided `Argument`
  ///            appended to its `arguments` collection.
  public func addArgument(_ element: GenericArgumentSyntax) -> GenericArgumentClauseSyntax {
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
      let childData = data.child(at: Cursor.rightAngleBracket,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is GenericArgumentListSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(GenericArgumentListSyntax.self))
    }
    // Check child #2 child is TokenSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension GenericArgumentClauseSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "leftAngleBracket": Syntax(leftAngleBracket).asProtocol(SyntaxProtocol.self),
      "arguments": Syntax(arguments).asProtocol(SyntaxProtocol.self),
      "rightAngleBracket": Syntax(rightAngleBracket).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TypeAnnotationSyntax

public struct TypeAnnotationSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case colon
    case type
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TypeAnnotationSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .typeAnnotation else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TypeAnnotationSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .typeAnnotation)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var colon: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.type,
                                 parent: Syntax(self))
      return TypeSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TypeSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TypeSyntax.self))
    }
  }
}

extension TypeAnnotationSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "type": Syntax(type).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - TuplePatternElementSyntax

public struct TuplePatternElementSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case labelName
    case labelColon
    case pattern
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `TuplePatternElementSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .tuplePatternElement else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `TuplePatternElementSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .tuplePatternElement)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  public var labelName: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.labelName,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.labelColon,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.pattern,
                                 parent: Syntax(self))
      return PatternSyntax(childData!)
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
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 4)
    // Check child #0 child is TokenSyntax or missing
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is PatternSyntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(PatternSyntax.self))
    }
    // Check child #3 child is TokenSyntax or missing
    if let raw = rawChildren[3].raw {
      let info = rawChildren[3].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension TuplePatternElementSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "labelName": labelName.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "labelColon": labelColon.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "pattern": Syntax(pattern).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityArgumentSyntax

/// 
/// A single argument to an `@available` argument like `*`, `iOS 10.1`,
/// or `message: "This has been deprecated"`.
/// 
public struct AvailabilityArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case entry
    case trailingComma
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .availabilityArgument else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AvailabilityArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityArgument)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The actual argument
  public var entry: Syntax {
    get {
      let childData = data.child(at: Cursor.entry,
                                 parent: Syntax(self))
      return Syntax(childData!)
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
  /// A trailing comma if the argument is followed by another
  /// argument
  /// 
  public var trailingComma: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.trailingComma,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is Syntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension AvailabilityArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "entry": Syntax(entry).asProtocol(SyntaxProtocol.self),
      "trailingComma": trailingComma.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - AvailabilityLabeledArgumentSyntax

/// 
/// A argument to an `@available` attribute that consists of a label and
/// a value, e.g. `message: "This has been deprecated"`.
/// 
public struct AvailabilityLabeledArgumentSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case label
    case colon
    case value
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityLabeledArgumentSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .availabilityLabeledArgument else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AvailabilityLabeledArgumentSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityLabeledArgument)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// The label of the argument
  public var label: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.label,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.colon,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.value,
                                 parent: Syntax(self))
      return Syntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is TokenSyntax 
    assert(rawChildren[1].raw != nil)
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is Syntax 
    assert(rawChildren[2].raw != nil)
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
  }
}

extension AvailabilityLabeledArgumentSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "label": Syntax(label).asProtocol(SyntaxProtocol.self),
      "colon": Syntax(colon).asProtocol(SyntaxProtocol.self),
      "value": Syntax(value).asProtocol(SyntaxProtocol.self),
    ])
  }
}

// MARK: - AvailabilityVersionRestrictionSyntax

/// 
/// An argument to `@available` that restricts the availability on a
/// certain platform to a version, e.g. `iOS 10` or `swift 3.4`.
/// 
public struct AvailabilityVersionRestrictionSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case platform
    case version
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `AvailabilityVersionRestrictionSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .availabilityVersionRestriction else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `AvailabilityVersionRestrictionSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .availabilityVersionRestriction)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// 
  /// The name of the OS on which the availability should be
  /// restricted or 'swift' if the availability should be
  /// restricted based on a Swift version.
  /// 
  public var platform: TokenSyntax {
    get {
      let childData = data.child(at: Cursor.platform,
                                 parent: Syntax(self))
      return TokenSyntax(childData!)
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

  public var version: VersionTupleSyntax? {
    get {
      let childData = data.child(at: Cursor.version,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return VersionTupleSyntax(childData!)
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
    let raw = newChild?.raw
    let newData = data.replacingChild(raw, at: Cursor.version)
    return AvailabilityVersionRestrictionSyntax(newData)
  }


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 2)
    // Check child #0 child is TokenSyntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #1 child is VersionTupleSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(VersionTupleSyntax.self))
    }
  }
}

extension AvailabilityVersionRestrictionSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "platform": Syntax(platform).asProtocol(SyntaxProtocol.self),
      "version": version.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

// MARK: - VersionTupleSyntax

/// 
/// A version number of the form major.minor.patch in which the minor
/// and patch part may be ommited.
/// 
public struct VersionTupleSyntax: SyntaxProtocol, SyntaxHashable {
  enum Cursor: Int {
    case majorMinor
    case patchPeriod
    case patchVersion
  }

  public let _syntaxNode: Syntax

  /// Converts the given `Syntax` node to a `VersionTupleSyntax` if possible. Returns
  /// `nil` if the conversion is not possible.
  public init?(_ syntax: Syntax) {
    guard syntax.raw.kind == .versionTuple else { return nil }
    self._syntaxNode = syntax
  }

  /// Creates a `VersionTupleSyntax` node from the given `SyntaxData`. This assumes
  /// that the `SyntaxData` is of the correct kind. If it is not, the behaviour
  /// is undefined.
  internal init(_ data: SyntaxData) {
    assert(data.raw.kind == .versionTuple)
    self._syntaxNode = Syntax(data)
  }

  public var syntaxNodeType: SyntaxProtocol.Type {
    return Swift.type(of: self)
  }

  /// 
  /// In case the version consists only of the major version, an
  /// integer literal that specifies the major version. In case
  /// the version consists of major and minor version number, a
  /// floating literal in which the decimal part is interpreted
  /// as the minor version.
  /// 
  public var majorMinor: Syntax {
    get {
      let childData = data.child(at: Cursor.majorMinor,
                                 parent: Syntax(self))
      return Syntax(childData!)
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
  /// If the version contains a patch number, the period
  /// separating the minor from the patch number.
  /// 
  public var patchPeriod: TokenSyntax? {
    get {
      let childData = data.child(at: Cursor.patchPeriod,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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
      let childData = data.child(at: Cursor.patchVersion,
                                 parent: Syntax(self))
      if childData == nil { return nil }
      return TokenSyntax(childData!)
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


  public func _validateLayout() {
    let rawChildren = Array(RawSyntaxChildren(Syntax(self)))
    assert(rawChildren.count == 3)
    // Check child #0 child is Syntax 
    assert(rawChildren[0].raw != nil)
    if let raw = rawChildren[0].raw {
      let info = rawChildren[0].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(Syntax.self))
    }
    // Check child #1 child is TokenSyntax or missing
    if let raw = rawChildren[1].raw {
      let info = rawChildren[1].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
    // Check child #2 child is TokenSyntax or missing
    if let raw = rawChildren[2].raw {
      let info = rawChildren[2].syntaxInfo
      let absoluteRaw = AbsoluteRawSyntax(raw: raw, info: info)
      let syntaxData = SyntaxData(absoluteRaw, parent: Syntax(self))
      let syntaxChild = Syntax(syntaxData)
      assert(syntaxChild.is(TokenSyntax.self))
    }
  }
}

extension VersionTupleSyntax: CustomReflectable {
  public var customMirror: Mirror {
    return Mirror(self, children: [
      "majorMinor": Syntax(majorMinor).asProtocol(SyntaxProtocol.self),
      "patchPeriod": patchPeriod.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
      "patchVersion": patchVersion.map(Syntax.init)?.asProtocol(SyntaxProtocol.self) as Any,
    ])
  }
}

